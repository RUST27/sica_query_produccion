DROP FUNCTION IF EXISTS public.fn_sica_grupo_usuario_responsables_insertar(varchar, text, integer, boolean, integer);
CREATE OR REPLACE FUNCTION public.fn_sica_grupo_usuario_responsables_insertar(
    p_nombre character varying, 
    p_descripcion text, 
    p_id_departamento integer,
    p_baja boolean,
    p_usuario_creacion integer
)
RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    v_id_grupo_responsable integer;
    _json jsonb;
BEGIN
    -- Insertar el nuevo grupo de usuarios responsables con el valor de 'baja'
    INSERT INTO public.tb_sica_grupo_usuarios_responsables (
        nombre, 
        descripcion, 
        fecha_creacion, 
        id_departamento,
        baja
    ) VALUES (
        p_nombre, 
        p_descripcion, 
        CURRENT_TIMESTAMP, 
        p_id_departamento,
        p_baja
    ) RETURNING id_grupo_usuario_responsable INTO v_id_grupo_responsable;

    -- Generar el JSONB del nuevo registro para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_grupo_usuarios_responsables t
    WHERE t.id_grupo_usuario_responsable = v_id_grupo_responsable;

    -- Registrar la operación en la tabla de seguimiento
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name, 
        id_registro, 
        accion, 
        usuario_id, 
        fecha
    ) VALUES (
        'tb_sica_grupo_usuarios_responsables', 
        v_id_grupo_responsable, 
        'INSERT', 
        p_usuario_creacion,  -- Utilizamos el usuario_creacion proporcionado
        CURRENT_TIMESTAMP
    );

    -- Llamar a la función de consolidación para enviar el registro a todas las sucursales
    PERFORM public.fn_consolidador_registrarmovimiento(
        _json,
        'i', -- 'i' indica que es una inserción
        'tb_sica_grupo_usuarios_responsables',
        0    -- Se pasa 0 para consolidación global en todas las sucursales
    );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al insertar en grupo_usuarios_responsables: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.fn_sica_grupo_usuario_responsables_insertar(varchar, text, integer, boolean, integer) OWNER TO postgres;


-- ------------------- Actualizar grupo de usuarios responsables -------------------


DROP FUNCTION IF EXISTS public.fn_sica_grupo_responsable_actualizar(integer, character varying, text, integer, boolean, integer);

CREATE OR REPLACE FUNCTION public.fn_sica_grupo_responsable_actualizar(
    p_id_grupo_usuario_responsable integer,
    p_nombre character varying,
    p_descripcion text,
    p_id_departamento integer,
    p_baja boolean,
    p_usuario_modificacion integer
)
RETURNS void
LANGUAGE 'plpgsql'
COST 100
VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    _json jsonb;
    v_id_grupo_usuario_responsable integer;
BEGIN
    -- Realiza la actualización del registro en la tabla, incluyendo el campo 'baja'
    UPDATE public.tb_sica_grupo_usuarios_responsables
    SET
        nombre = p_nombre,
        descripcion = p_descripcion,
        id_departamento = p_id_departamento,
        baja = p_baja,  -- Actualiza también el campo 'baja'
        fecha_modificacion = CURRENT_TIMESTAMP  -- Establece la fecha de modificación al momento actual
    WHERE tb_sica_grupo_usuarios_responsables.id_grupo_usuario_responsable = p_id_grupo_usuario_responsable
    RETURNING id_grupo_usuario_responsable INTO v_id_grupo_usuario_responsable;

    -- Verifica si el UPDATE ha afectado algún registro
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Grupo Responsable con ID % no encontrado.', p_id_grupo_usuario_responsable;
    END IF;

    -- Registrar la operación en la tabla de seguimiento
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name, 
        id_registro, 
        accion, 
        usuario_id, 
        fecha
    ) VALUES (
        'tb_sica_grupo_usuarios_responsables', 
        v_id_grupo_usuario_responsable, 
        'UPDATE', 
        p_usuario_modificacion, 
        CURRENT_TIMESTAMP
    );

    -- Generar el JSONB del registro actualizado para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_grupo_usuarios_responsables t
    WHERE t.id_grupo_usuario_responsable = v_id_grupo_usuario_responsable;

    -- Llamar a la función de consolidación para enviar el registro actualizado a todas las sucursales
    PERFORM public.fn_consolidador_registrarmovimiento(
        _json,
        'u',  -- Tipo de operación: 'u' para update
        'tb_sica_grupo_usuarios_responsables',
        0    -- Se pasa 0 para consolidación global en todas las sucursales
    );

EXCEPTION
    WHEN OTHERS THEN
        -- Proporciona detalles del error en caso de fallo en la actualización
        RAISE EXCEPTION 'Error al actualizar el grupo responsable: %', SQLERRM;
END;
$BODY$;

ALTER FUNCTION public.fn_sica_grupo_responsable_actualizar(
    integer, character varying, text, integer, boolean, integer
) OWNER TO postgres;

-- ----asignar usuarios a grupo de usuarios responsables
DROP FUNCTION IF EXISTS public.fn_sica_grupo_resp_asignar_usuario_insertar(integer, integer);

CREATE OR REPLACE FUNCTION public.fn_sica_grupo_resp_asignar_usuario_insertar(
    p_id_usuario integer, 
    p_id_grupo_usuario_responsable integer
) 
RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    _json jsonb;
BEGIN
    -- Intentar insertar el usuario en el grupo de responsables
    INSERT INTO public.tb_sica_relacion_usuarios_grupo_responsables (
        id_usuario, id_grupo_usuario_responsable
    ) VALUES (
        p_id_usuario, p_id_grupo_usuario_responsable
    )
    RETURNING to_jsonb(public.tb_sica_relacion_usuarios_grupo_responsables) INTO _json;  -- Obtener el registro insertado en formato JSONB

    -- Llamar a la función de consolidación para enviar el registro a todas las sucursales
    PERFORM public.fn_consolidador_registrarmovimiento(
        _json,
        'i', -- 'i' indica que es una inserción
        'tb_sica_relacion_usuarios_grupo_responsables',
        0    -- Se pasa 0 para consolidación global en todas las sucursales
    );

EXCEPTION
    WHEN unique_violation THEN
        -- Manejar la violación de unicidad
        RAISE EXCEPTION 'El usuario % ya está asignado al grupo de responsables %', p_id_usuario, p_id_grupo_usuario_responsable;
    WHEN OTHERS THEN
        -- Manejar cualquier otro error
        RAISE EXCEPTION 'Error al asignar usuario al grupo de responsables: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.fn_sica_grupo_resp_asignar_usuario_insertar(integer, integer) OWNER TO postgres;

-- obtener el detalles de los grupos -------------------

DROP FUNCTION IF EXISTS public.fn_sica_grupo_responsable_obtener_todos();
CREATE OR REPLACE FUNCTION public.fn_sica_grupo_responsable_obtener_todos()
RETURNS TABLE(id_grupo_usuario_responsable integer, nombre character varying, descripcion text, fecha_creacion timestamp without time zone, id_departamento integer, baja boolean, descripcion_departamento varchar)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        g.id_grupo_usuario_responsable,
        g.nombre,
        g.descripcion,
        g.fecha_creacion,
        g.id_departamento,
		g.baja,
		d.descripcion AS descripcion_departamento
    FROM 
        public.tb_sica_grupo_usuarios_responsables g
	JOIN 
		public.tb_sica_catalogo_departamentos d ON g.id_departamento = d.id_departamento;
END;
$$;

ALTER FUNCTION public.fn_sica_grupo_responsable_obtener_todos() OWNER TO postgres;

SELECT * FROM public.tb_sica_catalogo_departamentos;



DROP TABLE IF EXISTS public.tb_sica_grupo_usuarios_responsables CASCADE;
DROP TABLE IF EXISTS public.tb_sica_relacion_usuarios_grupo_responsables CASCADE;

DROP SEQUENCE IF EXISTS tb_sica_grupo_usuarios_responsables_id_grupo_usuario_responsable_seq;
DROP SEQUENCE IF EXISTS tb_sica_grupo_usuarios_responsables_seq;    
create table if not exists public.tb_sica_grupo_usuarios_responsables
(
    id_grupo_usuario_responsable SERIAL NOT NULL,
    nombre                       varchar(100),
    descripcion                  text,
    id_departamento              integer
        references public.tb_sica_catalogo_departamentos,
    fecha_creacion               timestamp default CURRENT_TIMESTAMP,
    fecha_modificacion           timestamp default CURRENT_TIMESTAMP,
    baja                         boolean,
    primary key (id_grupo_usuario_responsable)
);

alter table public.tb_sica_grupo_usuarios_responsables
    owner to postgres;

-- estatus

-- Insertar 'Nuevo'
SELECT public.fn_sica_catalogo_estatus_insertar(
    'Nuevo',    -- descripcion
    'NVO'        -- clave
);

-- Insertar 'Leído'
SELECT fn_sica_catalogo_estatus_insertar(
    'Leído',    -- descripcion
    'LDO'        -- clave
);

-- Insertar 'Ejecución'
SELECT fn_sica_catalogo_estatus_insertar(
    'Ejecución',    -- descripcion
    'EJEC'            -- clave
);

-- Insertar 'Observaciones'
SELECT fn_sica_catalogo_estatus_insertar(
    'Observaciones',    -- descripcion
    'OBS'                -- clave
);

-- Insertar 'Cancelado'
SELECT fn_sica_catalogo_estatus_insertar(
    'Cancelado',    -- descripcion
    'CANC'            -- clave
);

-- Insertar 'Cerrado'
SELECT fn_sica_catalogo_estatus_insertar(
    'Cerrado',    -- descripcion
    'CRDO'          -- clave
);


-- insertar grupos usuarios

-- Insertar 'Administradores'
SELECT fn_sica_catalogo_grupos_usuarios_insertar(
    'Administradores',  -- descripcion
    FALSE               -- baja
);

-- Insertar 'Usuarios'
SELECT fn_sica_catalogo_grupos_usuarios_insertar(
    'Usuarios',         -- descripcion
    FALSE               -- baja
);

-- Insertar 'Recepción'
SELECT fn_sica_catalogo_grupos_usuarios_insertar(
    'Recepción',        -- descripcion
    FALSE               -- baja
);

-- Insertar 'Gerencias'
SELECT fn_sica_catalogo_grupos_usuarios_insertar(
    'Gerencias',        -- descripcion
    FALSE               -- baja
);



-- Insertar 'Operaciones'
SELECT fn_sica_catalogo_gerencias_insertar(
    'Operaciones',  -- descripcion
    FALSE           -- baja
);

-- Insertar 'Abastos'
SELECT fn_sica_catalogo_gerencias_insertar(
    'Abastos',      -- descripcion
    FALSE           -- baja
);

-- Insertar 'Mercadotecnia'
SELECT fn_sica_catalogo_gerencias_insertar(
    'Mercadotecnia',  -- descripcion
    FALSE             -- baja
);

-- Insertar 'Recursos Humanos'
SELECT fn_sica_catalogo_gerencias_insertar(
    'Recursos Humanos',  -- descripcion
    FALSE                -- baja
);

-- Insertar 'Sistemas'
SELECT fn_sica_catalogo_gerencias_insertar(
    'Sistemas',  -- descripcion
    FALSE        -- baja
);

-- Insertar 'Compras'
SELECT fn_sica_catalogo_gerencias_insertar(
    'Compras',  -- descripcion
    FALSE       -- baja
);

-- Insertar 'Auditoria'
SELECT fn_sica_catalogo_gerencias_insertar(
    'Auditoria',  -- descripcion
    FALSE         -- baja
);

-- Insertar 'Contabilidad'
SELECT fn_sica_catalogo_gerencias_insertar(
    'Contabilidad',  -- descripcion
    FALSE            -- baja
);

-- Insertar 'Gerencia General'
SELECT fn_sica_catalogo_gerencias_insertar(
    'Gerencia General',  -- descripcion
    FALSE                -- baja
);
