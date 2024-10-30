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

-- catalogo gerencias 

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

-- catalogo de departamentos

-- Insertar 'RECURSOS HUMANOS' en la gerencia con ID 4
SELECT public.fn_sica_departamento_insertar('RECURSOS HUMANOS', 4, false, 1);

-- Insertar 'OPERACIONES' en la gerencia con ID 1
SELECT public.fn_sica_departamento_insertar('OPERACIONES', 1, false, 1);

-- Insertar 'SISTEMAS' en la gerencia con ID 5
SELECT public.fn_sica_departamento_insertar('SISTEMAS', 5, false, 1);

-- Insertar 'COMPRAS' en la gerencia con ID 1 (estado de baja true)
SELECT public.fn_sica_departamento_insertar('COMPRAS', 1, true, 1);

-- Insertar 'Logistica' en la gerencia con ID 2
SELECT public.fn_sica_departamento_insertar('Logistica', 2, false, 1);

-- Insertar 'Mercadotecnia' en la gerencia con ID 3
SELECT public.fn_sica_departamento_insertar('Mercadotecnia', 3, false, 1);

-- Insertar 'Compras' en la gerencia con ID 6
SELECT public.fn_sica_departamento_insertar('Compras', 6, false, 1);

-- Insertar 'AUDITORIA' en la gerencia con ID 7
SELECT public.fn_sica_departamento_insertar('AUDITORIA', 7, false, 1);

-- Insertar 'Contabilidad y Finanzas' en la gerencia con ID 8
SELECT public.fn_sica_departamento_insertar('Contabilidad y Finanzas', 8, false, 1);

-- Insertar 'Gerencia General' en la gerencia con ID 9
SELECT public.fn_sica_departamento_insertar('Gerencia General', 9, false, 1);

-- catalogo clasificacion actividades

-- Insertar 'RECLUTAMIENTO' en la clasificación de actividades para el departamento con ID 1
SELECT public.fn_sica_clasificacion_actividad_insertar('RECLUTAMIENTO', 'RECLUTAMIENTO', 1, false, 1);

-- Insertar 'HERRAMIENTAS' en la clasificación de actividades para el departamento con ID 1
SELECT public.fn_sica_clasificacion_actividad_insertar('HERRAMIENTAS', 'HERRAMIENTAS', 1, false, 1);

-- Insertar 'REQUERIMIENTO' en la clasificación de actividades para el departamento con ID 1
SELECT public.fn_sica_clasificacion_actividad_insertar('REQUERIMIENTO', 'REQUERIMIENTO', 1, false, 1);

-- Insertar 'MENTENIMIENTO FIO' en la clasificación de actividades para el departamento con ID 2
SELECT public.fn_sica_clasificacion_actividad_insertar('MENTENIMIENTO FIO', 'MENTENIMIENTO FIO', 2, false, 1);

-- Insertar 'MANTENIMIENTOS TIENDA' en la clasificación de actividades para el departamento con ID 2
SELECT public.fn_sica_clasificacion_actividad_insertar('MANTENIMIENTOS TIENDA', 'MANTENIMIENTOS TIENDA', 2, false, 1);

-- Insertar 'EQUIPOS' en la clasificación de actividades para el departamento con ID 3
SELECT public.fn_sica_clasificacion_actividad_insertar('EQUIPOS', 'EQUIPOS', 3, false, 1);

-- Insertar 'SISTEMA' en la clasificación de actividades para el departamento con ID 3
SELECT public.fn_sica_clasificacion_actividad_insertar('SISTEMA', 'FALLA DEL SISTEMA', 3, false, 1);

-- Insertar 'COMPRAS' en la clasificación de actividades para el departamento con ID 7
SELECT public.fn_sica_clasificacion_actividad_insertar('COMPRAS', 'COMPRAS', 7, false, 1);

-- Insertar 'PLANOGRAMAS' en la clasificación de actividades para el departamento con ID 6
SELECT public.fn_sica_clasificacion_actividad_insertar('PLANOGRAMAS', 'PLANOGRAMAS', 6, false, 1);

-- Insertar 'MATERIAL POP' en la clasificación de actividades para el departamento con ID 6
SELECT public.fn_sica_clasificacion_actividad_insertar('MATERIAL POP', 'MATERIAL POP', 6, false, 1);

-- Insertar 'PROMOCIONES' en la clasificación de actividades para el departamento con ID 6
SELECT public.fn_sica_clasificacion_actividad_insertar('PROMOCIONES', 'PROMOCIONES', 6, false, 1);

-- Insertar 'CONTABILIDAD' en la clasificación de actividades para el departamento con ID 9
SELECT public.fn_sica_clasificacion_actividad_insertar('CONTABILIDAD', 'CONTABILIDAD', 9, false, 1);

-- Insertar 'AUDITORIA' en la clasificación de actividades para el departamento con ID 8
SELECT public.fn_sica_clasificacion_actividad_insertar('AUDITORIA', 'AUDITORIA', 8, false, 1);

-- catalogo grupo actividades

-- Insertar 'RECLUTAMIENTO' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('RECLUTAMIENTO', 'RECLUTAMIENTO', 1, false, 1);

-- Insertar 'HERRAMIENTAS' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('HERRAMIENTAS', 'HERRAMIENTAS', 2, false, 1);

-- Insertar 'REQUERIMIENTO' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('REQUERIMIENTO', 'REQUERIMIENTO', 3, false, 1);

-- Insertar 'MENTENIMIENTO FIO' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('MENTENIMIENTO FIO', 'MENTENIMIENTO FIO', 4, false, 1);

-- Insertar 'MANTENIMIENTOS TIENDA' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('MANTENIMIENTOS TIENDA', 'MANTENIMIENTOS TIENDA', 5, false, 1);

-- Insertar 'FALLAS' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('FALLAS', 'FALLAS', 6, false, 1);

-- Insertar 'REPARACION' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('REPARACION', 'REPARACION', 6, false, 1);

-- Insertar 'FALLA DEL SISTEMA' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('FALLA DEL SISTEMA', 'FALLA DEL SISTEMA', 7, false, 1);

-- Insertar 'PROVEEDORES' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('PROVEEDORES', 'PROVEEDORES', 8, false, 1);

-- Insertar 'NUEVA CATALOGACIÓN' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('NUEVA CATALOGACIÓN', 'Nueva Catalogación', 9, false, 1);

-- Insertar 'PRODUCTO DESCATALOGADO' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('PRODUCTO DESCATALOGADO', 'Producto descatalogado', 9, false, 1);

-- Insertar 'GONDOLA' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('GONDOLA', 'GONDOLA', 9, false, 1);

-- Insertar 'CORTINA DE AIRE' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('CORTINA DE AIRE', 'CORTINA DE AIRE', 9, false, 1);

-- Insertar 'FAST FOOD' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('FAST FOOD', 'FAST FOOD', 9, false, 1);

-- Insertar 'CAMARA FRÍA' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('CAMARA FRÍA', 'CAMARA FRÍA', 9, false, 1);

-- Insertar 'VITRINA' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('VITRINA', 'VITRINA', 9, false, 1);

-- Insertar 'Señaletica' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('Señaletica', 'Señaletica', 10, false, 1);

-- Insertar 'Señaletica Fast Food' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('Señaletica Fast Food', 'Señaletica Fast Food', 10, false, 1);

-- Insertar 'PROMOCIONES MENSUALES' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('PROMOCIONES MENSUALES', 'PROMOCIONES MENSUALES', 11, false, 1);

-- Insertar 'CADUCIDAD' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('CADUCIDAD', 'CADUCIDAD', 8, false, 1);

-- Insertar 'PROMOCIONES' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('PROMOCIONES', 'PROMOCIONES', 8, false, 1);

-- Insertar 'PRODUCTOS' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('PRODUCTOS', 'PRODUCTOS', 8, false, 1);

-- Insertar 'BANCO' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('BANCO', 'BANCO', 12, false, 1);

-- Insertar 'FACTURACION' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('FACTURACION', 'FACTURACION', 12, false, 1);

-- Insertar 'GENERAL' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('GENERAL', 'GENERAL', 12, false, 1);

-- Insertar 'AUDITORIA' en el grupo de actividades
SELECT public.fn_sica_grupo_actividad_insertar('AUDITORIA', 'AUDITORIA', 13, false, 1);

-- catalogo grupos usuarios  responsables

-- Insertar 'Grupo de Gestión de Recursos Humanos' en el departamento con ID 1
SELECT public.fn_sica_grupo_usuario_responsables_insertar(
    'Grupo de Gestión de Recursos Humanos', 
    'Grupo responsable de la gestión y administración de los recursos humanos.', 
    1, 
    false, 
    1
);

-- Insertar 'Grupo de Operaciones y Logística' en el departamento con ID 2
SELECT public.fn_sica_grupo_usuario_responsables_insertar(
    'Grupo de Operaciones y Logística', 
    'Grupo encargado de la supervisión y control de operaciones diarias y logística.', 
    2, 
    false, 
    1
);

-- Insertar 'Grupo Soporte de Sistemas' en el departamento con ID 3
SELECT public.fn_sica_grupo_usuario_responsables_insertar(
    'Grupo Soporte de Sistemas', 
    'Grupo encargado del mantenimiento, desarrollo y soporte de los sistemas informáticos.', 
    3, 
    false, 
    1
);

-- Insertar 'Grupo Logística' en el departamento con ID 5
SELECT public.fn_sica_grupo_usuario_responsables_insertar(
    'Grupo Logística', 
    'Grupo responsable de la planificación y ejecución de la logística y distribución.', 
    5, 
    false, 
    1
);

-- Insertar 'Grupo Mercadotecnia' en el departamento con ID 6
SELECT public.fn_sica_grupo_usuario_responsables_insertar(
    'Grupo Mercadotecnia', 
    'Grupo encargado de desarrollar e implementar estrategias de marketing.', 
    6, 
    false, 
    1
);

-- Insertar 'Grupo de Compras' en el departamento con ID 7
SELECT public.fn_sica_grupo_usuario_responsables_insertar(
    'Grupo de Compras', 
    'Grupo responsable de la gestión de compras.', 
    7, 
    false, 
    1
);

-- Insertar 'Grupo de Auditoría' en el departamento con ID 8
SELECT public.fn_sica_grupo_usuario_responsables_insertar(
    'Grupo de Auditoría', 
    'Grupo encargado de la auditoría interna y el control de riesgos.', 
    8, 
    false, 
    1
);

-- Insertar 'Grupo de Contabilidad y Finanzas' en el departamento con ID 9
SELECT public.fn_sica_grupo_usuario_responsables_insertar(
    'Grupo de Contabilidad y Finanzas', 
    'Grupo responsable de la gestión financiera y contable de la organización.', 
    9, 
    false, 
    1
);

-- Insertar 'Grupo de Gestión de la Gerencia General' en el departamento con ID 10
SELECT public.fn_sica_grupo_usuario_responsables_insertar(
    'Grupo de Gestión de la Gerencia General', 
    'Grupo encargado de la coordinación y administración de la Gerencia General.', 
    10, 
    false, 
    1
);

-- catalogo de actividades

-- Insertar 'OPER'
SELECT public.fn_sica_actividad_insertar(
    'OPER', 
    'OPER', 
    190.00, 
    false, 
    1, 
    1, 
    1
);

-- Insertar 'STAFF'
SELECT public.fn_sica_actividad_insertar(
    'STAFF', 
    'STAFF', 
    360.00, 
    false, 
    1, 
    1, 
    1
);

-- Insertar 'GAFETES'
SELECT public.fn_sica_actividad_insertar(
    'GAFETES', 
    'GAFETES', 
    24.00, 
    false, 
    2, 
    1, 
    1
);

-- Insertar 'CASACAS'
SELECT public.fn_sica_actividad_insertar(
    'CASACAS', 
    'CASACAS', 
    24.00, 
    false, 
    2, 
    1, 
    1
);

-- Insertar 'FAJAS'
SELECT public.fn_sica_actividad_insertar(
    'FAJAS', 
    'FAJAS', 
    24.00, 
    false, 
    2, 
    1, 
    1
);

-- Insertar 'CONSTACIA'
SELECT public.fn_sica_actividad_insertar(
    'CONSTACIA', 
    'CONSTACIA', 
    24.00, 
    false, 
    3, 
    1, 
    1
);

-- Insertar 'DESCUENTOS (INVENTARIO/CAJA)'
SELECT public.fn_sica_actividad_insertar(
    'DESCUENTOS (INVENTARIO/CAJA)', 
    'DESCUENTOS (INVENTARIO/CAJA)', 
    72.00, 
    false, 
    3, 
    1, 
    1
);

-- Insertar 'DESCANSOS'
SELECT public.fn_sica_actividad_insertar(
    'DESCANSOS', 
    'DESCANSOS', 
    72.00, 
    false, 
    3, 
    1, 
    1
);

-- Insertar 'NOCTURNOS'
SELECT public.fn_sica_actividad_insertar(
    'NOCTURNOS', 
    'NOCTURNOS', 
    72.00, 
    false, 
    3, 
    1, 
    1
);

-- Insertar 'CAMARA FRIA NO ENFRIA'
SELECT public.fn_sica_actividad_insertar(
    'CAMARA FRIA NO ENFRIA', 
    'CAMARA FRIA NO ENFRIA', 
    48.00, 
    false, 
    4, 
    2, 
    1
);

-- Insertar 'CORTINA DE AIRE NO ENFRIA'
SELECT public.fn_sica_actividad_insertar(
    'CORTINA DE AIRE NO ENFRIA', 
    'CORTINA DE AIRE NO ENFRIA', 
    72.00, 
    false, 
    4, 
    2, 
    1
);

-- Insertar 'VITRINA NO ENFRIA'
SELECT public.fn_sica_actividad_insertar(
    'VITRINA NO ENFRIA', 
    'VITRINA NO ENFRIA', 
    96.00, 
    false, 
    4, 
    2, 
    1
);

-- Insertar 'ENFRIADOR NO ENFRIA'
SELECT public.fn_sica_actividad_insertar(
    'ENFRIADOR NO ENFRIA', 
    'ENFRIADOR NO ENFRIA', 
    48.00, 
    false, 
    4, 
    2, 
    1
);

-- Insertar 'PUERTA ACCESO A TIENDA ARRASTRA'
SELECT public.fn_sica_actividad_insertar(
    'PUERTA ACCESO A TIENDA ARRASTRA', 
    'PUERTA ACCESO A TIENDA ARRASTRA', 
    96.00, 
    false, 
    5, 
    2, 
    1
);

-- Insertar 'FUGA DE AGUA EN EL BAÑO'
SELECT public.fn_sica_actividad_insertar(
    'FUGA DE AGUA EN EL BAÑO', 
    'FUGA DE AGUA EN EL BAÑO', 
    48.00, 
    false, 
    5, 
    2, 
    1
);

-- Insertar 'FUGA DE AGUA EN LLAVE ESTACIONAMIENTO'
SELECT public.fn_sica_actividad_insertar(
    'FUGA DE AGUA EN LLAVE ESTACIONAMIENTO', 
    'FUGA DE AGUA EN LLAVE ESTACIONAMIENTO', 
    48.00, 
    false, 
    5, 
    2, 
    1
);

-- Insertar 'CRISTA ROTO DE SUCURSAL'
SELECT public.fn_sica_actividad_insertar(
    'CRISTA ROTO DE SUCURSAL', 
    'CRISTA ROTO DE SUCURSAL', 
    48.00, 
    false, 
    5, 
    2, 
    1
);

-- Insertar 'CAJA FUERTE DAÑADA'
SELECT public.fn_sica_actividad_insertar(
    'CAJA FUERTE DAÑADA', 
    'CAJA FUERTE DAÑADA', 
    48.00, 
    false, 
    5, 
    2, 
    1
);

-- Insertar 'CAJA 1'
SELECT public.fn_sica_actividad_insertar(
    'CAJA 1', 
    'CAJA 1', 
    6.00, 
    false, 
    6, 
    3, 
    1
);

-- Insertar 'CAJA 2'
SELECT public.fn_sica_actividad_insertar(
    'CAJA 2', 
    'CAJA 2', 
    6.00, 
    false, 
    6, 
    3, 
    1
);

-- Insertar 'RECARGAS/BANCO/TELEFONO'
SELECT public.fn_sica_actividad_insertar(
    'RECARGAS/BANCO/TELEFONO', 
    'RECARGAS/BANCO/TELEFONO', 
    72.00, 
    false, 
    6, 
    3, 
    1
);

-- Insertar 'CAMARA DE VIDEO'
SELECT public.fn_sica_actividad_insertar(
    'CAMARA DE VIDEO', 
    'CAMARA DE VIDEO', 
    24.00, 
    false, 
    6, 
    3, 
    1
);

-- Insertar 'FALLA DE EQUIPO'
SELECT public.fn_sica_actividad_insertar(
    'FALLA DE EQUIPO', 
    'FALLA DE EQUIPO', 
    168.00, 
    false, 
    6, 
    3, 
    1
);

-- Insertar 'ACCESORIOS'
SELECT public.fn_sica_actividad_insertar(
    'ACCESORIOS', 
    'ACCESORIOS', 
    24.00, 
    false, 
    7, 
    3, 
    1
);

-- Insertar 'FALLA EN EL SISTEMA'
SELECT public.fn_sica_actividad_insertar(
    'FALLA EN EL SISTEMA', 
    'FALLA EN EL SISTEMA', 
    24.00, 
    false, 
    8, 
    3, 
    1
);

-- Insertar 'PROVEEDORES'
SELECT public.fn_sica_actividad_insertar(
    'PROVEEDORES', 
    'PROVEEDORES', 
    144.00, 
    false, 
    9, 
    6, 
    1
);

-- Insertar 'ACOMODO DE PRODUCTO NUEVO'
SELECT public.fn_sica_actividad_insertar(
    'ACOMODO DE PRODUCTO NUEVO', 
    'ACOMODO DE PRODUCTO NUEVO', 
    24.00, 
    false, 
    10, 
    5, 
    1
);

-- Insertar 'SUSTITUIR FRENTE POR OTRO PRODUCTO'
SELECT public.fn_sica_actividad_insertar(
    'SUSTITUIR FRENTE POR OTRO PRODUCTO', 
    'SUSTITUIR FRENTE POR OTRO PRODUCTO', 
    24.00, 
    false, 
    11, 
    5, 
    1
);

-- Insertar 'GONDOLA PLANOGRAMAS ACTUALIZADOS'
SELECT public.fn_sica_actividad_insertar(
    'GONDOLA PLANOGRAMAS ACTUALIZADOS', 
    'GONDOLA PLANOGRAMAS ACTUALIZADOS', 
    24.00, 
    false, 
    12, 
    5, 
    1
);

-- Insertar 'CORTINA DE AIRE PLANOGRAMAS ACTUALIZADOS'
SELECT public.fn_sica_actividad_insertar(
    'CORTINA DE AIRE PLANOGRAMAS ACTUALIZADOS', 
    'CORTINA DE AIRE PLANOGRAMAS ACTUALIZADOS', 
    24.00, 
    false, 
    13, 
    5, 
    1
);

-- Insertar 'FAST FOOD PLANOGRAMAS ACTUALIZADOS'
SELECT public.fn_sica_actividad_insertar(
    'FAST FOOD PLANOGRAMAS ACTUALIZADOS', 
    'FAST FOOD PLANOGRAMAS ACTUALIZADOS', 
    24.00, 
    false, 
    14, 
    5, 
    1
);

-- Insertar 'CAMARA FRÍA PLANOGRAMAS ACTUALIZADOS'
SELECT public.fn_sica_actividad_insertar(
    'CAMARA FRÍA PLANOGRAMAS ACTUALIZADOS', 
    'CAMARA FRÍA PLANOGRAMAS ACTUALIZADOS', 
    24.00, 
    false, 
    15, 
    5, 
    1
);

-- Insertar 'VITRINA PLANOGRAMAS ACTUALIZADOS'
SELECT public.fn_sica_actividad_insertar(
    'VITRINA PLANOGRAMAS ACTUALIZADOS', 
    'VITRINA PLANOGRAMAS ACTUALIZADOS', 
    24.00, 
    false, 
    16, 
    5, 
    1
);

-- Insertar 'SEÑALIZACIÓN EN LAS SUCURSALES'
SELECT public.fn_sica_actividad_insertar(
    'SEÑALIZACIÓN EN LAS SUCURSALES', 
    'SEÑALIZACIÓN EN LAS SUCURSALES', 
    24.00, 
    false, 
    17, 
    5, 
    1
);

-- Insertar 'TIRAS PRECIADORAS'
SELECT public.fn_sica_actividad_insertar(
    'TIRAS PRECIADORAS', 
    'TIRAS PRECIADORAS', 
    24.00, 
    false, 
    18, 
    5, 
    1
);

-- Insertar 'MICROONDAS'
SELECT public.fn_sica_actividad_insertar(
    'MICROONDAS', 
    'MICROONDAS', 
    24.00, 
    false, 
    18, 
    5, 
    1
);

-- Insertar 'HOTDOG'
SELECT public.fn_sica_actividad_insertar(
    'HOTDOG', 
    'HOTDOG', 
    24.00, 
    false, 
    18, 
    5, 
    1
);

-- Insertar 'SIERRA BONITA'
SELECT public.fn_sica_actividad_insertar(
    'SIERRA BONITA', 
    'SIERRA BONITA', 
    24.00, 
    false, 
    18, 
    5, 
    1
);

-- Insertar 'VIGENCIA'
SELECT public.fn_sica_actividad_insertar(
    'VIGENCIA', 
    'VIGENCIA', 
    24.00, 
    false, 
    19, 
    5, 
    1
);

-- Insertar 'GUÍA DE EJECUCIÓN'
SELECT public.fn_sica_actividad_insertar(
    'GUÍA DE EJECUCIÓN', 
    'GUÍA DE EJECUCIÓN', 
    24.00, 
    false, 
    19, 
    5, 
    1
);

-- Insertar 'PRODUCTOS PROXIMOS A CADUCAR'
SELECT public.fn_sica_actividad_insertar(
    'PRODUCTOS PROXIMOS A CADUCAR', 
    'PRODUCTOS PROXIMOS A CADUCAR', 
    48.00, 
    false, 
    20, 
    6, 
    1
);

-- Insertar 'PRODUCTOS QUE NO PASAN'
SELECT public.fn_sica_actividad_insertar(
    'PRODUCTOS QUE NO PASAN', 
    'PRODUCTOS QUE NO PASAN', 
    12.00, 
    false, 
    22, 
    6, 
    1
);

-- Insertar 'DESBLOQUEO DE PRODUCTOS'
SELECT public.fn_sica_actividad_insertar(
    'DESBLOQUEO DE PRODUCTOS', 
    'DESBLOQUEO DE PRODUCTOS', 
    24.00, 
    false, 
    22, 
    6, 
    1
);

-- Insertar 'REFERENCIAS BANCO'
SELECT public.fn_sica_actividad_insertar(
    'REFERENCIAS BANCO', 
    'REFERENCIAS BANCO', 
    24.00, 
    false, 
    23, 
    8, 
    1
);

-- Insertar 'CASH'
SELECT public.fn_sica_actividad_insertar(
    'CASH', 
    'CASH', 
    24.00, 
    false, 
    23, 
    8, 
    1
);

-- Insertar 'CORRESPONSALIAS'
SELECT public.fn_sica_actividad_insertar(
    'CORRESPONSALIAS', 
    'CORRESPONSALIAS', 
    24.00, 
    false, 
    23, 
    8, 
    1
);

-- Insertar 'ADDENDA'
SELECT public.fn_sica_actividad_insertar(
    'ADDENDA', 
    'ADDENDA', 
    24.00, 
    false, 
    24, 
    8, 
    1
);

-- Insertar 'SERVICIOS'
SELECT public.fn_sica_actividad_insertar(
    'SERVICIOS', 
    'SERVICIOS', 
    24.00, 
    false, 
    25, 
    8, 
    1
);

-- Insertar 'FALTANTE DE CAJA'
SELECT public.fn_sica_actividad_insertar(
    'FALTANTE DE CAJA', 
    'FALTANTE DE CAJA', 
    24.00, 
    false, 
    25, 
    8, 
    1
);

-- Insertar 'RESULTADOS DE INVENTARIO'
SELECT public.fn_sica_actividad_insertar(
    'RESULTADOS DE INVENTARIO', 
    'RESULTADOS DE INVENTARIO', 
    48.00, 
    false, 
    26, 
    7, 
    1
);

-- Insertar 'CADUCADO EXHIBIDO'
SELECT public.fn_sica_actividad_insertar(
    'CADUCADO EXHIBIDO', 
    'CADUCADO EXHIBIDO', 
    48.00, 
    false, 
    26, 
    7, 
    1
);

-- Insertar 'SOLICITUD DE INVENTARIO'
SELECT public.fn_sica_actividad_insertar(
    'SOLICITUD DE INVENTARIO', 
    'SOLICITUD DE INVENTARIO', 
    48.00, 
    false, 
    26, 
    7, 
    1
);

-- Insertar 'AJUSTES DE INVENTARIO'
SELECT public.fn_sica_actividad_insertar(
    'AJUSTES DE INVENTARIO', 
    'AJUSTES DE INVENTARIO', 
    48.00, 
    false, 
    26, 
    7, 
    1
);

-- Insertar 'OTROS'
SELECT public.fn_sica_actividad_insertar(
    'OTROS', 
    'OTROS', 
    48.00, 
    false, 
    26, 
    7, 
    1
);
