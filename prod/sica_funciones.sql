-- Borrar las tablas en cascada
DROP TABLE IF EXISTS public.tb_sica_catalogo_gerencias CASCADE;
DROP TABLE IF EXISTS public.tb_sica_catalogo_grupos_usuarios CASCADE;
DROP TABLE IF EXISTS public.tb_sica_catalogo_departamentos CASCADE;
DROP TABLE IF EXISTS public.tb_sica_grupo_usuarios_responsables CASCADE;
DROP TABLE IF EXISTS public.tb_sica_relacion_usuarios_grupo_responsables CASCADE;
DROP TABLE IF EXISTS public.tb_sica_catalogo_clasificacion_actividades CASCADE;
DROP TABLE IF EXISTS public.tb_sica_catalogo_grupo_actividades CASCADE;
DROP TABLE IF EXISTS public.tb_sica_catalogo_actividades CASCADE;
DROP TABLE IF EXISTS public.tb_sica_catalogo_estatus CASCADE;
DROP TABLE IF EXISTS public.tb_sica_catalogo_usuarios_sica CASCADE;
DROP TABLE IF EXISTS public.tb_sica_atenciones CASCADE;
DROP TABLE IF EXISTS public.tb_sica_mensajes CASCADE;
DROP TABLE IF EXISTS public.tb_sica_transferencias_atenciones CASCADE;
DROP TABLE IF EXISTS public.tb_sica_seguimiento CASCADE;


-- Crear tabla tb_sica_catalogo_gerencias con secuencia personalizada
DROP SEQUENCE IF EXISTS tb_sica_catalogo_gerencias_id_gerencia_seq;
create table if not exists public.tb_sica_catalogo_gerencias
(
    id_gerencia        SERIAL NOT NULL,
    descripcion        varchar(150),
    baja               boolean,
    fecha_creacion     timestamp default CURRENT_TIMESTAMP,
    fecha_modificacion timestamp default CURRENT_TIMESTAMP,
    primary key (id_gerencia)
);

alter table public.tb_sica_catalogo_gerencias
    owner to postgres;

-- Crear tabla tb_sica_catalogo_grupos_usuarios con secuencia personalizada
DROP SEQUENCE IF EXISTS tb_sica_catalogo_grupos_usuarios_id_grupo_usuario_seq;
create table if not exists public.tb_sica_catalogo_grupos_usuarios
(
    id_grupo_usuario   SERIAL NOT NULL,
    descripcion        varchar(100),
    fecha_creacion     timestamp default CURRENT_TIMESTAMP,
    fecha_modificacion timestamp default CURRENT_TIMESTAMP,
    baja               boolean,
    primary key (id_grupo_usuario)
);

alter table public.tb_sica_catalogo_grupos_usuarios
    owner to postgres;

-- Crear tabla tb_sica_catalogo_departamentos con secuencia personalizada
DROP SEQUENCE IF EXISTS tb_sica_catalogo_departamentos_id_departamento_seq;
create table if not exists public.tb_sica_catalogo_departamentos
(
    id_departamento    SERIAL NOT NULL,
    descripcion        varchar(100),
    baja               boolean,
    id_gerencia        integer
        references public.tb_sica_catalogo_gerencias,
    fecha_creacion     timestamp default CURRENT_TIMESTAMP,
    fecha_modificacion timestamp default CURRENT_TIMESTAMP,
    primary key (id_departamento)
);

alter table public.tb_sica_catalogo_departamentos
    owner to postgres;

-- Crear tabla tb_sica_grupo_usuarios_responsables con secuencia personalizada
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

-- Crear tabla tb_sica_catalogo_clasificacion_actividades con secuencia personalizada
DROP SEQUENCE IF EXISTS tb_sica_catalogo_clasificacion_actividades_id_clasificacion_actividad_seq;
create table if not exists public.tb_sica_catalogo_clasificacion_actividades
(
    id_clasificacion_actividad SERIAL NOT NULL,
    nombre                     varchar(100),
    descripcion                text,
    baja                       boolean,
    id_departamento            integer
        references public.tb_sica_catalogo_departamentos,
    fecha_creacion             timestamp default CURRENT_TIMESTAMP,
    fecha_modificacion         timestamp default CURRENT_TIMESTAMP,
    primary key (id_clasificacion_actividad)
);

alter table public.tb_sica_catalogo_clasificacion_actividades
    owner to postgres;

-- Crear tabla tb_sica_catalogo_grupo_actividades con secuencia personalizada
DROP SEQUENCE IF EXISTS tb_sica_catalogo_grupo_actividades_id_grupo_actividad_seq;
create table if not exists public.tb_sica_catalogo_grupo_actividades
(
    id_grupo_actividad         SERIAL NOT NULL,
    nombre                     varchar(100),
    descripcion                text,
    baja                       boolean,
    id_clasificacion_actividad integer
        references public.tb_sica_catalogo_clasificacion_actividades,
    fecha_creacion             timestamp default CURRENT_TIMESTAMP,
    fecha_modificacion         timestamp default CURRENT_TIMESTAMP,
    primary key (id_grupo_actividad)
);

alter table public.tb_sica_catalogo_grupo_actividades
    owner to postgres;

-- Crear tabla tb_sica_catalogo_actividades con secuencia personalizada
DROP SEQUENCE IF EXISTS tb_sica_catalogo_actividades_id_actividad_seq;
create table if not exists public.tb_sica_catalogo_actividades
(
    id_actividad                 SERIAL NOT NULL,
    nombre                       varchar(150),
    descripcion                  text,
    tiempo                       numeric(18, 2),
    baja                         boolean,
    id_grupo_actividad           integer
        references public.tb_sica_catalogo_grupo_actividades,
    id_grupo_usuario_responsable integer
        references public.tb_sica_grupo_usuarios_responsables,
    fecha_creacion               timestamp default CURRENT_TIMESTAMP,
    fecha_modificacion           timestamp default CURRENT_TIMESTAMP,
    primary key (id_actividad)
);

alter table public.tb_sica_catalogo_actividades
    owner to postgres;

-- Crear tabla tb_sica_catalogo_estatus con secuencia personalizada
DROP SEQUENCE IF EXISTS tb_sica_catalogo_estatus_id_estatus_seq;
create table if not exists public.tb_sica_catalogo_estatus
(
    id_estatus         SERIAL NOT NULL,
    descripcion        varchar(100),
    clave              varchar(10),
    fecha_creacion     timestamp default CURRENT_TIMESTAMP,
    fecha_modificacion timestamp default CURRENT_TIMESTAMP,
    primary key (id_estatus)
);

alter table public.tb_sica_catalogo_estatus
    owner to postgres;

-- Crear tabla tb_sica_catalogo_usuarios_sica con secuencia personalizada
DROP SEQUENCE IF EXISTS tb_sica_catalogo_usuarios_sica_id_usuario_sica_seq;

create table if not exists public.tb_sica_catalogo_usuarios_sica
(
    id_usuario_sica    SERIAL NOT NULL,
    responsable        boolean,
    jefe_area          boolean,
    correo             varchar(150),
    es_staff           boolean,
    id_grupo_usuario   integer
        references public.tb_sica_catalogo_grupos_usuarios,
    id_usuario         integer
        references public.tb_catalogo_usuarios,
    id_departamento    integer
        references public.tb_sica_catalogo_departamentos,
    id_gerencia        integer
        references public.tb_sica_catalogo_gerencias,
    fecha_creacion     timestamp default CURRENT_TIMESTAMP,
    fecha_modificacion timestamp default CURRENT_TIMESTAMP,
    baja               boolean,
    primary key (id_usuario_sica)
);

alter table public.tb_sica_catalogo_usuarios_sica
    owner to postgres;

-- Crear tabla tb_sica_atenciones con secuencia personalizada
DROP SEQUENCE IF EXISTS tb_sica_atenciones_id_atencion_seq;
CREATE TABLE IF NOT EXISTS public.tb_sica_atenciones
(
    id_atencion                  BIGSERIAL NOT NULL,
    id_sucursal                  integer not null,
    ticket                       varchar(14) unique,
    asunto                       varchar(150),
    usuario_reporta              integer
        references public.tb_catalogo_usuarios,
    fecha_inicio                 timestamp,
    fecha_cierre                 timestamp,
    usuario_cierre               integer
        references public.tb_catalogo_usuarios,
    fecha_cancelacion            timestamp,
    usuario_cancelo              integer
        references public.tb_catalogo_usuarios,
    id_estatus                   integer
        references public.tb_sica_catalogo_estatus,
    id_actividad                 integer
        references public.tb_sica_catalogo_actividades,
    id_grupo_usuario_responsable integer
        references public.tb_sica_grupo_usuarios_responsables,
    id_departamento_actual       integer
        references public.tb_sica_catalogo_departamentos,
    id_departamento_anterior     integer
        references public.tb_sica_catalogo_departamentos,
    descripcion                  text,
    fecha_modificacion           timestamp default CURRENT_TIMESTAMP,
    fecha_creacion               timestamp default CURRENT_TIMESTAMP,
    enviar_alerta                boolean,
    fecha_inicio_ejecucion       timestamp default CURRENT_TIMESTAMP,
    primary key (id_atencion, id_sucursal)
);

ALTER TABLE public.tb_sica_atenciones
    OWNER TO postgres;

-- Crear tabla tb_sica_mensajes con secuencia personalizada
DROP SEQUENCE IF EXISTS tb_sica_mensajes_id_mensaje_seq;
CREATE TABLE IF NOT EXISTS public.tb_sica_mensajes
(
    id_mensaje          BIGSERIAL NOT NULL ,
    id_atencion         bigint not null, 
    id_sucursal         integer not null,
    descripcion         text,
    fecha_creacion      timestamp,
    es_interno          boolean,
    id_usuario_creacion integer
        references public.tb_catalogo_usuarios,
    primary key (id_mensaje, id_atencion, id_sucursal),
    foreign key (id_atencion, id_sucursal) references public.tb_sica_atenciones(id_atencion, id_sucursal)
);

ALTER TABLE public.tb_sica_mensajes
    OWNER TO postgres;

-- Crear tabla tb_sica_transferencias_atenciones con secuencia personalizada
DROP SEQUENCE IF EXISTS tb_sica_transferencias_atenciones_id_transferencia_seq;
CREATE TABLE IF NOT EXISTS public.tb_sica_transferencias_atenciones
(
    id_transferencia        BIGSERIAL NOT NULL, -- Cambiado a BIGINT
    id_atencion             bigint not null, 
    id_sucursal             integer not null,
    id_departamento_origen  integer
        references public.tb_sica_catalogo_departamentos,
    id_departamento_destino integer
        references public.tb_sica_catalogo_departamentos,
    fecha_transferencia     timestamp default CURRENT_TIMESTAMP,
    usuario_transferencia   integer
        references public.tb_catalogo_usuarios,
    motivo                  text,
    primary key (id_transferencia, id_atencion, id_sucursal),
    foreign key (id_atencion, id_sucursal) references public.tb_sica_atenciones(id_atencion, id_sucursal)
);

ALTER TABLE public.tb_sica_transferencias_atenciones
    OWNER TO postgres;

-- Crear tabla tb_sica_seguimiento con secuencia personalizada
DROP SEQUENCE IF EXISTS tb_sica_seguimiento_id_seguimiento_seq;
CREATE TABLE IF NOT EXISTS public.tb_sica_seguimiento
(
    id_seguimiento SERIAL NOT NULL,
    tabla_name varchar(100),
    id_registro integer,
    accion varchar(50),
    usuario_id integer REFERENCES public.tb_catalogo_usuarios(id_usuario),
    fecha timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_seguimiento)
);

ALTER TABLE public.tb_sica_seguimiento
    OWNER TO postgres;

-- Crear tabla tb_sica_relacion_usuarios_grupo_responsables
CREATE TABLE IF NOT EXISTS public.tb_sica_relacion_usuarios_grupo_responsables
(
    id_usuario                   integer not null
        references public.tb_catalogo_usuarios,
    id_grupo_usuario_responsable integer not null
        references public.tb_sica_grupo_usuarios_responsables,
    primary key (id_usuario, id_grupo_usuario_responsable)
);

ALTER TABLE public.tb_sica_relacion_usuarios_grupo_responsables
    OWNER TO postgres;



-- <================================================ funciones ================================================================= >
DROP FUNCTION IF EXISTS public.fn_sica_atencion_generar_ticket();
CREATE OR REPLACE FUNCTION public.fn_sica_atencion_generar_ticket() 
RETURNS character varying
LANGUAGE plpgsql
AS
$$
DECLARE
    nuevo_ticket varchar(14);
BEGIN
    -- Generar un ticket con la fecha y hora actual en formato YYMMDDHHMI (10 caracteres) y un número aleatorio de 4 dígitos
    nuevo_ticket := to_char(CURRENT_TIMESTAMP, 'YYMMDDHHMI') || lpad((trunc(random() * 10000)::int)::varchar, 4, '0');
    
    RETURN left(nuevo_ticket, 14);
END;
$$;

ALTER FUNCTION public.fn_sica_atencion_generar_ticket() OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_obtener_todos_usuarios_catalogo_consulta();
CREATE FUNCTION public.fn_sica_obtener_todos_usuarios_catalogo_consulta()
    RETURNS TABLE(id_usuario integer, nombre character varying, usuario character varying, password character varying, restablecer_password boolean, bloqueado boolean, status character varying, ultima_actualizacion_password date, imagen text, fecha_ingreso date)
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        u.id_usuario,
        u.nombre,
        u.usuario,
        u.password,
        u.restablecer_password,
        u.bloqueado,
        u.status,
        u.ultima_actualizacion_password,
        u.imagen,
        u.fecha_ingreso
    FROM 
        public.tb_catalogo_usuarios u
    WHERE 
        u.status = 'A';
END;
$$;

ALTER FUNCTION public.fn_sica_obtener_todos_usuarios_catalogo_consulta() OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_actividad_detalle_obtener_por_id(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_actividad_detalle_obtener_por_id(p_id_actividad integer)
RETURNS TABLE(
    id_actividad integer, 
    nombre character varying, 
    descripcion text, 
    tiempo numeric, 
    grupo_actividad_descripcion text, 
    clasificacion_actividad_descripcion text, 
    departamento_descripcion character varying, 
    grupo_responsable_descripcion character varying)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        a.id_actividad,
        a.nombre,
        a.descripcion,
        a.tiempo,
        ga.descripcion AS grupo_actividad_descripcion,
        ca.descripcion AS clasificacion_actividad_descripcion,
        d.descripcion AS departamento_descripcion,
        gur.nombre AS grupo_responsable_descripcion
    FROM 
        public.tb_sica_catalogo_actividades a
    JOIN 
        public.tb_sica_catalogo_grupo_actividades ga ON a.id_grupo_actividad = ga.id_grupo_actividad
    JOIN 
        public.tb_sica_catalogo_clasificacion_actividades ca ON ga.id_clasificacion_actividad = ca.id_clasificacion_actividad
    JOIN 
        public.tb_sica_catalogo_departamentos d ON ca.id_departamento = d.id_departamento
    LEFT JOIN 
        public.tb_sica_grupo_usuarios_responsables gur ON a.id_grupo_usuario_responsable = gur.id_grupo_usuario_responsable
    WHERE 
        a.id_actividad = p_id_actividad;
END;
$$;

ALTER FUNCTION public.fn_sica_actividad_detalle_obtener_por_id(integer) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_actividad_obtener_por_id_consulta(integer);

CREATE OR REPLACE FUNCTION public.fn_sica_actividad_obtener_por_id_consulta(p_id_actividad integer)
RETURNS TABLE(
    id_actividad integer, 
    nombre character varying, 
    descripcion text, 
    tiempo numeric, 
    id_departamento integer, 
    id_grupo_usuario_responsable integer, 
    id_clasificacion_actividad integer, 
    id_grupo_actividad integer, 
    baja boolean,  
    fecha_creacion timestamp without time zone, 
    fecha_modificacion timestamp without time zone)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT
        a.id_actividad,
        a.nombre,
        a.descripcion,
        a.tiempo,
        d.id_departamento,
        gur.id_grupo_usuario_responsable,
        ca.id_clasificacion_actividad,
        ga.id_grupo_actividad,
        a.baja,
        a.fecha_creacion,
        a.fecha_modificacion
    FROM public.tb_sica_catalogo_actividades a
    JOIN public.tb_sica_catalogo_grupo_actividades ga ON a.id_grupo_actividad = ga.id_grupo_actividad
    JOIN public.tb_sica_catalogo_clasificacion_actividades ca ON ga.id_clasificacion_actividad = ca.id_clasificacion_actividad
    JOIN public.tb_sica_catalogo_departamentos d ON ca.id_departamento = d.id_departamento
    LEFT JOIN public.tb_sica_grupo_usuarios_responsables gur ON a.id_grupo_usuario_responsable = gur.id_grupo_usuario_responsable
    WHERE a.id_actividad = p_id_actividad;
END;
$$;

ALTER FUNCTION public.fn_sica_actividad_obtener_por_id_consulta(integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_actividades_detalle_obtener_consulta();
CREATE OR REPLACE FUNCTION public.fn_sica_actividades_detalle_obtener_consulta()
RETURNS TABLE(
    id_actividad integer, 
    nombre character varying, 
    descripcion text, 
    tiempo numeric, 
    grupo_actividad_descripcion text, 
    clasificacion_actividad_descripcion text, 
    departamento_descripcion character varying, 
    grupo_responsable_descripcion character varying,
    baja boolean)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT
        a.id_actividad,
        a.nombre,
        a.descripcion,
        a.tiempo,
        ga.descripcion AS grupo_actividad_descripcion,
        ca.descripcion AS clasificacion_actividad_descripcion,
        d.descripcion AS departamento_descripcion,
        gr.nombre AS grupo_responsable_descripcion,
        a.baja
    FROM
        public.tb_sica_catalogo_actividades a
    JOIN
        public.tb_sica_catalogo_grupo_actividades ga ON a.id_grupo_actividad = ga.id_grupo_actividad
    JOIN
        public.tb_sica_catalogo_clasificacion_actividades ca ON ga.id_clasificacion_actividad = ca.id_clasificacion_actividad
    JOIN
        public.tb_sica_catalogo_departamentos d ON ca.id_departamento = d.id_departamento
    LEFT JOIN
        public.tb_sica_grupo_usuarios_responsables gr ON a.id_grupo_usuario_responsable = gr.id_grupo_usuario_responsable;
END;
$$;

ALTER FUNCTION public.fn_sica_actividades_detalle_obtener_consulta() OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_atencion_actualizar_estatus(bigint, integer, integer);

CREATE OR REPLACE FUNCTION public.fn_sica_atencion_actualizar_estatus(
    p_id_atencion bigint,  
    p_id_sucursal integer, 
    p_id_estatus integer)
RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    _json jsonb;
BEGIN
    -- Actualizar el estatus de la atención en la tabla tb_sica_atenciones
    UPDATE public.tb_sica_atenciones
    SET id_estatus = p_id_estatus
    WHERE id_atencion = p_id_atencion AND id_sucursal = p_id_sucursal;

    -- Registrar la operación en la tabla de seguimiento
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name,
        id_registro,
        accion,
        usuario_id,
        fecha
    ) VALUES (
        'tb_sica_atenciones',
        p_id_atencion,  -- El valor de BIGINT ahora se pasa aquí
        'UPDATE ESTATUS',
        current_setting('app.user_id')::integer,
        CURRENT_TIMESTAMP
    );

    -- Generar el JSONB de la atención actualizada para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_atenciones t
    WHERE t.id_atencion = p_id_atencion AND t.id_sucursal = p_id_sucursal;

    -- Llamar a la función de consolidación
    PERFORM public.fn_consolidador_registrarmovimiento_para_sucursalx(
        _json,
        'u',
        'tb_sica_atenciones',
        p_id_sucursal,
        ''
    );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al actualizar estatus de la atención: %', SQLERRM;
END;
$$;

-- Cambiar el propietario de la función
ALTER FUNCTION public.fn_sica_atencion_actualizar_estatus(bigint, integer, integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_atencion_cerrar(bigint, integer, integer);

CREATE OR REPLACE FUNCTION public.fn_sica_atencion_cerrar(
	p_id_atencion bigint,
	p_id_sucursal integer,
	p_id_usuario_cierre integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    _json jsonb;
BEGIN
    -- Verificar si la atención existe
    IF EXISTS (
        SELECT 1
        FROM public.tb_sica_atenciones
        WHERE id_atencion = p_id_atencion
        AND id_sucursal = p_id_sucursal
    ) THEN
        -- Actualizar el estatus de la atención a '6' (Cerrado)
        UPDATE public.tb_sica_atenciones
        SET id_estatus = 6,
            usuario_cierre = p_id_usuario_cierre,
            fecha_cierre = CURRENT_TIMESTAMP,
            fecha_modificacion = CURRENT_TIMESTAMP
        WHERE id_atencion = p_id_atencion
        AND id_sucursal = p_id_sucursal;

        -- Registrar la operación en la tabla de seguimiento
        INSERT INTO public.tb_sica_seguimiento (
            tabla_name, 
            id_registro, 
            accion, 
            usuario_id, 
            fecha
        ) VALUES (
            'tb_sica_atenciones', 
            p_id_atencion, 
            'CLOSE', 
            p_id_usuario_cierre, 
            CURRENT_TIMESTAMP
        );

        -- Generar el JSONB del registro actualizado para consolidación
        SELECT to_jsonb(t) INTO _json
        FROM public.tb_sica_atenciones t
        WHERE t.id_atencion = p_id_atencion
        AND t.id_sucursal = p_id_sucursal;

        -- Llamar a la función de consolidación para enviar el registro actualizado a oficinas
        PERFORM public.fn_consolidador_registrarmovimiento_para_oficinas(
            _json,
            'u', -- 'u' indica que es una actualización
            'tb_sica_atenciones',
            ''  -- Tags opcionales, puedes cambiar esto según sea necesario
        );
    ELSE
        -- Si la atención no existe, se lanza un error
        RAISE EXCEPTION 'Atención con id % y sucursal % no encontrada.', p_id_atencion, p_id_sucursal;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al cerrar la atención: %', SQLERRM;
END;
$BODY$;

ALTER FUNCTION public.fn_sica_atencion_cerrar(bigint, integer, integer)
    OWNER TO postgres;




DROP FUNCTION IF EXISTS public.fn_sica_atencion_obtener_por_id(bigint, integer);

CREATE OR REPLACE FUNCTION public.fn_sica_atencion_obtener_por_id(
    p_id_atencion bigint, -- Cambiado a BIGINT
    p_id_sucursal integer)
RETURNS TABLE(
    id_atencion bigint, -- Cambiado a BIGINT
    ticket character varying, 
    asunto character varying, 
    descripcion text, 
    sucursal_descripcion character varying, 
    grupo_responsable_nombre character varying, 
    fecha_inicio timestamp without time zone, 
    usuario_reporta integer, 
    usuario_responsable integer, 
    fecha_cierre timestamp without time zone, 
    usuario_cierre integer, 
    fecha_modificacion timestamp without time zone, 
    fecha_cancelacion timestamp without time zone, 
    usuario_cancelo integer, 
    id_estatus integer, 
    enviar_alerta boolean, 
    id_actividad integer, 
    id_grupo_usuario_responsable integer, 
    id_departamento_actual integer, 
    id_departamento_anterior integer)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT
        a.id_atencion,
        a.ticket,
        a.asunto,
        a.descripcion,
        s.descripcion AS sucursal_descripcion,
        g.nombre AS grupo_responsable_nombre,
        a.fecha_inicio,
        a.usuario_reporta,
        a.fecha_cierre,
        a.usuario_cierre,
        a.fecha_modificacion,
        a.fecha_cancelacion,
        a.usuario_cancelo,
        a.id_estatus,
        a.enviar_alerta,
        a.id_actividad,
        a.id_grupo_usuario_responsable,
        a.id_departamento_actual,
        a.id_departamento_anterior
    FROM public.tb_sica_atenciones a
    JOIN public.tb_catalogo_sucursales s ON a.id_sucursal = s.id_sucursal
    JOIN public.tb_sica_grupo_usuarios_responsables g ON a.id_grupo_usuario_responsable = g.id_grupo_usuario_responsable
    WHERE a.id_atencion = p_id_atencion AND a.id_sucursal = p_id_sucursal;
END;
$$;

-- Cambiar el propietario de la función
ALTER FUNCTION public.fn_sica_atencion_obtener_por_id(bigint, integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_atencion_obtener_por_ticket(varchar);

CREATE OR REPLACE FUNCTION public.fn_sica_atencion_obtener_por_ticket(
    p_ticket character varying)
RETURNS TABLE(
    id_atencion bigint, -- Cambiado a BIGINT
    ticket character varying, 
    asunto character varying, 
    descripcion text, 
    sucursal_descripcion character varying, 
    grupo_responsable_nombre character varying, 
    fecha_inicio timestamp without time zone, 
    usuario_reporta integer, 
    usuario_responsable integer, 
    fecha_cierre timestamp without time zone, 
    usuario_cierre integer, 
    fecha_modificacion timestamp without time zone, 
    fecha_cancelacion timestamp without time zone, 
    usuario_cancelo integer, 
    id_estatus integer, 
    enviar_alerta boolean, 
    id_actividad integer, 
    id_grupo_usuario_responsable integer, 
    id_departamento_actual integer, 
    id_departamento_anterior integer)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT
        a.id_atencion,
        a.ticket,
        a.asunto,
        a.descripcion,
        s.descripcion AS sucursal_descripcion,
        g.nombre AS grupo_responsable_nombre,
        a.fecha_inicio,
        a.usuario_reporta,
        a.fecha_cierre,
        a.usuario_cierre,
        a.fecha_modificacion,
        a.fecha_cancelacion,
        a.usuario_cancelo,
        a.id_estatus,
        a.enviar_alerta,
        a.id_actividad,
        a.id_grupo_usuario_responsable,
        a.id_departamento_actual,
        a.id_departamento_anterior
    FROM public.tb_sica_atenciones a
    JOIN public.tb_catalogo_sucursales s ON a.id_sucursal = s.id_sucursal
    JOIN public.tb_sica_grupo_usuarios_responsables g ON a.id_grupo_usuario_responsable = g.id_grupo_usuario_responsable
    WHERE a.ticket = p_ticket;
END;
$$;

-- Cambiar el propietario de la función
ALTER FUNCTION public.fn_sica_atencion_obtener_por_ticket(varchar) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_atencion_obtener_por_ticket(varchar);
CREATE OR REPLACE FUNCTION public.fn_sica_atencion_obtener_por_ticket(
    p_ticket character varying)
RETURNS TABLE(
    id_atencion integer, 
    ticket character varying, 
    asunto character varying, 
    descripcion text, 
    sucursal_descripcion character varying, 
    grupo_responsable_nombre character varying, 
    fecha_inicio timestamp without time zone, 
    usuario_reporta integer, 
    usuario_responsable integer, 
    fecha_cierre timestamp without time zone, 
    usuario_cierre integer, 
    fecha_modificacion timestamp without time zone, 
    fecha_cancelacion timestamp without time zone, 
    usuario_cancelo integer, 
    id_estatus integer, 
    enviar_alerta boolean, 
    id_actividad integer, 
    id_grupo_usuario_responsable integer, 
    id_departamento_actual integer, 
    id_departamento_anterior integer)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT
        a.id_atencion,
        a.ticket,
        a.asunto,
        a.descripcion,
        s.descripcion AS sucursal_descripcion,
        g.nombre AS grupo_responsable_nombre,
        a.fecha_inicio,
        a.usuario_reporta,
        a.fecha_cierre,
        a.usuario_cierre,
        a.fecha_modificacion,
        a.fecha_cancelacion,
        a.usuario_cancelo,
        a.id_estatus,
        a.enviar_alerta,
        a.id_actividad,
        a.id_grupo_usuario_responsable,
        a.id_departamento_actual,
        a.id_departamento_anterior
    FROM public.tb_sica_atenciones a
    JOIN public.tb_catalogo_sucursales s ON a.id_sucursal = s.id_sucursal
    JOIN public.tb_sica_grupo_usuarios_responsables g ON a.id_grupo_usuario_responsable = g.id_grupo_usuario_responsable
    WHERE a.ticket = p_ticket;
END;
$$;

ALTER FUNCTION public.fn_sica_atencion_obtener_por_ticket(varchar) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_atencion_transferir(bigint, integer, integer, integer, text);

CREATE OR REPLACE FUNCTION public.fn_sica_atencion_transferir(
    p_id_atencion bigint,  -- Cambiado a BIGINT
    p_id_sucursal integer, 
    p_id_departamento_destino integer, 
    p_usuario_transferencia integer, 
    p_motivo text)
RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    _json jsonb;
BEGIN
    -- Registrar la transferencia en la tabla tb_sica_transferencias_atenciones
    INSERT INTO public.tb_sica_transferencias_atenciones(
        id_atencion,
        id_sucursal,
        id_departamento_origen,
        id_departamento_destino,
        fecha_transferencia,
        usuario_transferencia,
        motivo
    )
    SELECT
        id_atencion,
        id_sucursal,
        id_departamento_actual,
        p_id_departamento_destino,
        current_timestamp,
        p_usuario_transferencia,
        p_motivo
    FROM public.tb_sica_atenciones
    WHERE id_atencion = p_id_atencion
      AND id_sucursal = p_id_sucursal;

    -- Actualizar el departamento actual en la tabla tb_sica_atenciones
    UPDATE public.tb_sica_atenciones
    SET id_departamento_actual = p_id_departamento_destino,
        fecha_modificacion = current_timestamp
    WHERE id_atencion = p_id_atencion
      AND id_sucursal = p_id_sucursal;

    -- Generar el JSONB del registro actualizado para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_atenciones t
    WHERE t.id_atencion = p_id_atencion
      AND t.id_sucursal = p_id_sucursal;

    -- Llamar a la función de consolidación para enviar el registro a la sucursal correspondiente
    PERFORM public.fn_consolidador_registrarmovimiento_para_sucursalx(
        _json,
        'u',
        'tb_sica_atenciones',
        p_id_sucursal,
        ''
    );

    -- Registrar la operación en la tabla de seguimiento
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name, 
        id_registro, 
        accion, 
        usuario_id, 
        fecha
    ) VALUES (
        'public.tb_sica_atenciones', 
        p_id_atencion, 
        'TRANSFERENCIA', 
        p_usuario_transferencia, 
        CURRENT_TIMESTAMP
    );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al transferir la atención: %', SQLERRM;
END;
$$;

-- Cambiar el propietario de la función
ALTER FUNCTION public.fn_sica_atencion_transferir(bigint, integer, integer, integer, text) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_atenciones_filtrar_obtener_detalladas_por_usuario(integer, integer, integer, integer, timestamp, timestamp, varchar);

CREATE OR REPLACE FUNCTION public.fn_sica_atenciones_filtrar_obtener_detalladas_por_usuario(
    p_id_usuario integer, 
    p_estado integer DEFAULT NULL::integer, 
    p_sucursal integer DEFAULT NULL::integer, 
    p_departamento integer DEFAULT NULL::integer, 
    p_fecha_inicio timestamp without time zone DEFAULT NULL::timestamp without time zone, 
    p_fecha_fin timestamp without time zone DEFAULT NULL::timestamp without time zone, 
    p_ticket character varying DEFAULT NULL::character varying)
RETURNS TABLE(
    id_atencion bigint, -- Cambiado a BIGINT
    ticket character varying, 
    usuario_reporto character varying, 
    usuario_grupo_asignado character varying, 
    fecha_inicio timestamp without time zone, 
    estatus_descripcion character varying,
    id_sucursal integer,  -- Nuevo campo para el ID de la sucursal
    descripcion_sucursal character varying  -- Nuevo campo para la descripción de la sucursal
)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT
        a.id_atencion,
        a.ticket,
        ur.nombre AS usuario_reporto,
        gur.nombre AS usuario_grupo_asignado,
        a.fecha_inicio,
        e.descripcion AS estatus_descripcion,
        a.id_sucursal,  -- ID de la sucursal
        s.descripcion AS descripcion_sucursal  -- Descripción de la sucursal
    FROM
        public.tb_sica_atenciones a
        JOIN public.tb_catalogo_usuarios ur ON a.usuario_reporta = ur.id_usuario
        JOIN public.tb_sica_grupo_usuarios_responsables gur ON a.id_grupo_usuario_responsable = gur.id_grupo_usuario_responsable
        JOIN public.tb_sica_relacion_usuarios_grupo_responsables ugr ON a.id_grupo_usuario_responsable = ugr.id_grupo_usuario_responsable
        JOIN public.tb_catalogo_usuarios u ON ugr.id_usuario = u.id_usuario
        JOIN public.tb_sica_catalogo_estatus e ON a.id_estatus = e.id_estatus
        LEFT JOIN public.tb_catalogo_sucursales s ON a.id_sucursal = s.id_sucursal  -- JOIN con la tabla de sucursales
    WHERE
        u.id_usuario = p_id_usuario
        AND (p_estado IS NULL OR a.id_estatus = p_estado)
        AND (p_sucursal IS NULL OR a.id_sucursal = p_sucursal)
        AND (p_departamento IS NULL OR a.id_departamento_actual = p_departamento)
        AND (p_fecha_inicio IS NULL OR a.fecha_inicio >= p_fecha_inicio)
        AND (p_fecha_fin IS NULL OR a.fecha_inicio < p_fecha_fin + interval '1 day')
        AND (p_ticket IS NULL OR a.ticket ILIKE '%' || p_ticket || '%');
END;
$$;

-- Cambiar el propietario de la función
ALTER FUNCTION public.fn_sica_atenciones_filtrar_obtener_detalladas_por_usuario(integer, integer, integer, integer, timestamp, timestamp, varchar) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_actividad_actualizar(integer, varchar, text, numeric, integer, boolean, integer, integer);
CREATE OR REPLACE FUNCTION public.fn_sica_actividad_actualizar(
    p_id_actividad integer, 
    p_nombre character varying, 
    p_descripcion text, 
    p_tiempo numeric, 
    p_id_grupo_actividad integer, 
    p_baja boolean, 
    p_id_grupo_usuario_responsable integer,
    p_usuario_modificacion integer
) RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    _json jsonb;
BEGIN
    -- Actualizar la actividad existente en la tabla tb_sica_catalogo_actividades
    UPDATE public.tb_sica_catalogo_actividades
    SET
        nombre = p_nombre,
        descripcion = p_descripcion,
        tiempo = p_tiempo,
        id_grupo_actividad = p_id_grupo_actividad,
        baja = p_baja,
        fecha_modificacion = CURRENT_TIMESTAMP,
        id_grupo_usuario_responsable = p_id_grupo_usuario_responsable
    WHERE id_actividad = p_id_actividad;

    -- Registrar la operación en la tabla de seguimiento
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name,
        id_registro,
        accion,
        usuario_id,
        fecha
    ) VALUES (
        'tb_sica_catalogo_actividades',
        p_id_actividad,
        'UPDATE',
        p_usuario_modificacion,  -- Se usa el parámetro pasado a la función
        CURRENT_TIMESTAMP
    );

    -- Generar el JSONB de la actividad actualizada para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_catalogo_actividades t
    WHERE t.id_actividad = p_id_actividad;

    -- Llamar a la función de consolidación para todas las sucursales
    PERFORM public.fn_consolidador_registrarmovimiento(
        _json,
        'u',                       -- 'u' indica que es una actualización
        'tb_sica_catalogo_actividades',
        0                          -- Pasar 0 para indicar todas las sucursales
    );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al actualizar actividad: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.fn_sica_actividad_actualizar(integer, varchar, text, numeric, integer, boolean, integer, integer) OWNER TO postgres;



DROP FUNCTION IF EXISTS public.fn_sica_actividades_por_departamento_consulta(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_actividades_por_departamento_consulta(
    depto_id integer)
RETURNS TABLE(
    id_actividad integer, 
    nombre character varying, 
    descripcion text, 
    tiempo numeric, 
    baja boolean, 
    fecha_creacion timestamp without time zone, 
    fecha_modificacion timestamp without time zone, 
    id_grupo_actividad integer, 
    id_grupo_usuario_responsable integer)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT
        a.id_actividad,
        a.nombre,
        a.descripcion,
        a.tiempo,
        a.baja,
        a.fecha_creacion,
        a.fecha_modificacion,
        a.id_grupo_actividad,
        a.id_grupo_usuario_responsable
    FROM
        public.tb_sica_catalogo_actividades a
    INNER JOIN
        public.tb_sica_catalogo_grupo_actividades ga ON a.id_grupo_actividad = ga.id_grupo_actividad
    INNER JOIN
        public.tb_sica_catalogo_clasificacion_actividades ca ON ga.id_clasificacion_actividad = ca.id_clasificacion_actividad
    INNER JOIN
        public.tb_sica_catalogo_departamentos d ON ca.id_departamento = d.id_departamento
    WHERE
        d.id_departamento = depto_id
        AND a.baja = false
        AND ga.baja = false
        AND ca.baja = false
        AND d.baja = false;
END;
$$;

ALTER FUNCTION public.fn_sica_actividades_por_departamento_consulta(integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_atencion_insertar(varchar, text, integer, integer, timestamp, integer, integer, integer, integer);

CREATE OR REPLACE FUNCTION public.fn_sica_atencion_insertar(
    p_asunto character varying, 
    p_descripcion text, 
    p_id_sucursal integer, 
    p_usuario_reporta integer, 
    p_fecha_inicio timestamp without time zone, 
    p_id_estatus integer, 
    p_id_actividad integer, 
    p_id_grupo_usuario_responsable integer, 
    p_id_departamento_actual integer) 
RETURNS bigint  -- Cambiado a BIGINT
LANGUAGE plpgsql
AS
$$
DECLARE
    v_id_atencion bigint;  -- Cambiado a BIGINT
    v_ticket varchar;
    _json jsonb;
BEGIN
    -- Generar el ticket
    v_ticket := public.fn_sica_atencion_generar_ticket();

    -- Insertar un nuevo registro en la tabla tb_sica_atenciones
    INSERT INTO public.tb_sica_atenciones(
        ticket,
        asunto,
        descripcion,
        id_sucursal,
        usuario_reporta,
        fecha_inicio,
        id_estatus,
        id_actividad,
        id_grupo_usuario_responsable,
        id_departamento_actual,
        fecha_creacion,
        fecha_modificacion
    ) VALUES (
        v_ticket,
        p_asunto,
        p_descripcion,
        p_id_sucursal,
        p_usuario_reporta,
        p_fecha_inicio,
        p_id_estatus,
        p_id_actividad,
        p_id_grupo_usuario_responsable,
        p_id_departamento_actual,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ) RETURNING id_atencion INTO v_id_atencion;

    -- Registrar la operación en la tabla de seguimiento
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name,
        id_registro,
        accion,
        usuario_id,
        fecha
    ) VALUES (
        'tb_sica_atenciones',
        v_id_atencion,
        'INSERT',
        p_usuario_reporta,  -- Se registra el usuario que reporta como el creador
        CURRENT_TIMESTAMP
    );

    -- Generar el JSONB de la atención insertada para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_atenciones t
    WHERE t.id_atencion = v_id_atencion AND t.id_sucursal = p_id_sucursal;

    -- Llamar a la función de consolidación para enviar el registro a oficinas
    PERFORM public.fn_consolidador_registrarmovimiento_para_oficinas(
        _json,
        'i',
        'tb_sica_atenciones',
        NULL
    );

    -- Retornar el ID de la nueva atención insertada
    RETURN v_id_atencion;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al insertar en atenciones: %', SQLERRM;
END;
$$;

-- Cambiar el propietario de la función
ALTER FUNCTION public.fn_sica_atencion_insertar(varchar, text, integer, integer, timestamp, integer, integer, integer, integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_atencion_nueva_insertar(varchar, text, integer, integer, integer, integer, integer);

CREATE OR REPLACE FUNCTION public.fn_sica_atencion_nueva_insertar(
    p_asunto character varying, 
    p_descripcion text, 
    p_usuario_reporta integer, 
    p_id_actividad integer, 
    p_id_sucursal integer, 
    p_id_grupo_usuario_responsable integer, 
    p_id_departamento_actual integer)
RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    v_id_atencion bigint;  -- Cambiado a BIGINT
    _json jsonb;
BEGIN
    -- Insertar la nueva atención en la tabla tb_sica_atenciones
    INSERT INTO public.tb_sica_atenciones(
        ticket,
        asunto,
        descripcion,
        usuario_reporta,
        fecha_inicio,
        id_estatus,
        enviar_alerta,
        id_actividad,
        id_sucursal,
        id_grupo_usuario_responsable,
        id_departamento_actual,
        fecha_creacion,
        fecha_modificacion
    )
    VALUES (
        public.fn_sica_atencion_generar_ticket(),
        p_asunto,
        p_descripcion,
        p_usuario_reporta,
        current_timestamp,
        1, -- Estado inicial: 'Nuevo'
        true,  -- Enviar alerta por defecto
        p_id_actividad,
        p_id_sucursal,
        p_id_grupo_usuario_responsable,
        p_id_departamento_actual,
        current_timestamp,
        current_timestamp
    ) RETURNING id_atencion INTO v_id_atencion;  -- Cambiado a BIGINT


    -- Generar el JSONB de la atención insertada para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_atenciones t
    WHERE t.id_atencion = v_id_atencion AND t.id_sucursal = p_id_sucursal;

    -- Llamar a la función de consolidación para enviar el registro a oficinas
    PERFORM public.fn_consolidador_registrarmovimiento_para_oficinas(
        _json,
        'i',
        'tb_sica_atenciones',
        NULL
    );

END;
$$;

-- Cambiar el propietario de la función
ALTER FUNCTION public.fn_sica_atencion_nueva_insertar(varchar, text, integer, integer, integer, integer, integer) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_clasificacion_actividad_actualizar(integer, varchar, text, integer, boolean, integer);
CREATE OR REPLACE FUNCTION public.fn_sica_clasificacion_actividad_actualizar(
    p_id_clasificacion_actividad integer, 
    p_nombre character varying, 
    p_descripcion text, 
    p_id_departamento integer, 
    p_baja boolean, 
    p_usuario_modificacion integer)
RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    _json jsonb;
BEGIN
    -- Actualizar la clasificación de actividad en la tabla tb_sica_catalogo_clasificacion_actividades
    UPDATE public.tb_sica_catalogo_clasificacion_actividades
    SET 
        nombre = p_nombre,
        descripcion = p_descripcion,
        id_departamento = p_id_departamento,
        baja = p_baja,
        fecha_modificacion = CURRENT_TIMESTAMP
    WHERE id_clasificacion_actividad = p_id_clasificacion_actividad;

    -- Registrar la operación en la tabla de seguimiento
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name, 
        id_registro, 
        accion, 
        usuario_id, 
        fecha
    ) VALUES (
        'tb_sica_catalogo_clasificacion_actividades', 
        p_id_clasificacion_actividad, 
        'UPDATE', 
        p_usuario_modificacion,  -- Registrar el usuario que realizó la modificación
        CURRENT_TIMESTAMP
    );

    -- Generar el JSONB de la clasificación de actividad actualizada para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_catalogo_clasificacion_actividades t
    WHERE t.id_clasificacion_actividad = p_id_clasificacion_actividad;

    -- Llamar a la función de consolidación para enviar el registro actualizado a todas las sucursales
    PERFORM public.fn_consolidador_registrarmovimiento(
        _json,
        'u', -- 'u' indica que es una actualización
        'tb_sica_catalogo_clasificacion_actividades',
        0    -- Se pasa 0 para consolidación global en todas las sucursales
    );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al actualizar clasificación de actividad: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.fn_sica_clasificacion_actividad_actualizar(integer, varchar, text, integer, boolean, integer) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_clasificacion_actividad_insertar(varchar, text, integer, boolean, integer);
CREATE OR REPLACE FUNCTION public.fn_sica_clasificacion_actividad_insertar(
    p_nombre character varying, 
    p_descripcion text, 
    p_id_departamento integer, 
    p_baja boolean, 
    p_usuario_creacion integer)
RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    v_id_clasificacion_actividad integer;
    _json jsonb;
BEGIN
    -- Insertar un nuevo registro en la tabla tb_sica_catalogo_clasificacion_actividades
    INSERT INTO public.tb_sica_catalogo_clasificacion_actividades (
        nombre, 
        descripcion, 
        id_departamento, 
        baja, 
        fecha_creacion, 
        fecha_modificacion
    )
    VALUES (
        p_nombre, 
        p_descripcion, 
        p_id_departamento, 
        p_baja, 
        CURRENT_TIMESTAMP, 
        CURRENT_TIMESTAMP
    ) RETURNING id_clasificacion_actividad INTO v_id_clasificacion_actividad;

    -- Registrar la operación en la tabla de seguimiento
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name, 
        id_registro, 
        accion, 
        usuario_id, 
        fecha
    ) VALUES (
        'tb_sica_catalogo_clasificacion_actividades', 
        v_id_clasificacion_actividad, 
        'INSERT', 
        p_usuario_creacion, 
        CURRENT_TIMESTAMP
    );

    -- Generar el JSONB del nuevo registro para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_catalogo_clasificacion_actividades t
    WHERE t.id_clasificacion_actividad = v_id_clasificacion_actividad;

    -- Llamar a la función de consolidación para enviar el registro a todas las sucursales
    PERFORM public.fn_consolidador_registrarmovimiento(
        _json,
        'i', -- 'i' indica que es una inserción
        'tb_sica_catalogo_clasificacion_actividades',
        0    -- Se pasa 0 para consolidación global en todas las sucursales
    );

EXCEPTION
    WHEN OTHERS THEN
        -- Manejar cualquier error que ocurra durante la inserción
        RAISE EXCEPTION 'Error al insertar en clasificacion_actividades: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.fn_sica_clasificacion_actividad_insertar(varchar, text, integer, boolean, integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_clasificacion_actividad_obtener_por_id_consulta(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_clasificacion_actividad_obtener_por_id_consulta(p_id_clasificacion_actividad integer)
    RETURNS TABLE(id_clasificacion_actividad integer, nombre character varying, descripcion text, id_departamento integer, baja boolean, fecha_creacion timestamp without time zone, fecha_modificacion timestamp without time zone)
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        a.id_clasificacion_actividad, 
        a.nombre, 
        a.descripcion, 
        a.id_departamento, 
        a.baja,
        a.fecha_creacion, 
        a.fecha_modificacion
    FROM public.tb_sica_catalogo_clasificacion_actividades a
    WHERE a.id_clasificacion_actividad = p_id_clasificacion_actividad;
END;
$$;

ALTER FUNCTION public.fn_sica_clasificacion_actividad_obtener_por_id_consulta(integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_clasificaciones_actividad_obtener_detalle_consulta();
CREATE OR REPLACE FUNCTION public.fn_sica_clasificaciones_actividad_obtener_detalle_consulta()
    RETURNS TABLE(
        id_clasificacion_actividad integer, 
        nombre character varying, 
        descripcion text, 
        descripcion_departamento character varying, 
        baja boolean  -- Añadimos la columna baja
    )
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        a.id_clasificacion_actividad, 
        a.nombre, 
        a.descripcion,
        d.descripcion AS descripcion_departamento,
        a.baja  -- Seleccionamos también la columna baja
    FROM 
        public.tb_sica_catalogo_clasificacion_actividades a
    JOIN 
        public.tb_sica_catalogo_departamentos d ON a.id_departamento = d.id_departamento;
    -- Eliminamos la condición en el WHERE para traer todos los registros, incluyendo los inactivos
END;
$$;

ALTER FUNCTION public.fn_sica_clasificaciones_actividad_obtener_detalle_consulta() OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_clasificaciones_actividad_obtener_todos_consulta();
CREATE OR REPLACE FUNCTION public.fn_sica_clasificaciones_actividad_obtener_todos_consulta()
    RETURNS TABLE(id_clasificacion_actividad integer, nombre character varying, descripcion text, id_departamento integer, baja boolean, fecha_creacion timestamp without time zone, fecha_modificacion timestamp without time zone)
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        a.id_clasificacion_actividad, 
        a.nombre, 
        a.descripcion, 
        a.id_departamento, 
        a.baja, 
        a.fecha_creacion, 
        a.fecha_modificacion
    FROM public.tb_sica_catalogo_clasificacion_actividades AS a;
END;
$$;

ALTER FUNCTION public.fn_sica_clasificaciones_actividad_obtener_todos_consulta() OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_departamento_insertar(varchar, integer, boolean, integer);
CREATE OR REPLACE FUNCTION public.fn_sica_departamento_insertar(
    p_descripcion character varying, 
    p_id_gerencia integer, 
    p_baja boolean, 
    p_usuario_creacion integer
) 
RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    v_id_departamento integer;
    _json jsonb;
BEGIN
    -- Verificar si la gerencia proporcionada existe
    IF EXISTS (SELECT 1 FROM public.tb_sica_catalogo_gerencias WHERE id_gerencia = p_id_gerencia) THEN
        -- Inserta el nuevo departamento si la gerencia existe
        INSERT INTO public.tb_sica_catalogo_departamentos(
            descripcion, 
            id_gerencia, 
            baja, 
            fecha_creacion, 
            fecha_modificacion
        )
        VALUES (
            p_descripcion, 
            p_id_gerencia, 
            p_baja, 
            CURRENT_TIMESTAMP, 
            CURRENT_TIMESTAMP
        ) RETURNING id_departamento INTO v_id_departamento;

        -- Registrar la operación en la tabla de seguimiento
        INSERT INTO public.tb_sica_seguimiento (
            tabla_name, 
            id_registro, 
            accion, 
            usuario_id, 
            fecha
        ) VALUES (
            'tb_sica_catalogo_departamentos', 
            v_id_departamento, 
            'INSERT', 
            p_usuario_creacion, 
            CURRENT_TIMESTAMP
        );

        -- Generar el JSONB del nuevo registro para consolidación
        SELECT to_jsonb(t) INTO _json
        FROM public.tb_sica_catalogo_departamentos t
        WHERE t.id_departamento = v_id_departamento;

        -- Llamar a la función de consolidación para enviar el registro a todas las sucursales
        PERFORM public.fn_consolidador_registrarmovimiento(
            _json,
            'i', -- 'i' indica que es una inserción
            'tb_sica_catalogo_departamentos',
            0    -- Se pasa 0 para consolidación global en todas las sucursales
        );

    ELSE
        -- Si la gerencia no existe, emite un error
        RAISE EXCEPTION 'La gerencia con ID % no existe.', p_id_gerencia;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Ocurrió un error al insertar el nuevo departamento: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.fn_sica_departamento_insertar(varchar, integer, boolean, integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_departamento_obtener_por_id_clasificacion(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_departamento_obtener_por_id_clasificacion(
    p_id_clasificacion_actividad integer
)
RETURNS TABLE(id_clasificacion_actividad integer, nombre_clasificacion character varying, descripcion_clasificacion text, id_departamento integer, descripcion_departamento character varying)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT
        ca.id_clasificacion_actividad,
        ca.nombre AS nombre_clasificacion,
        ca.descripcion AS descripcion_clasificacion,
        d.id_departamento,
        d.descripcion AS descripcion_departamento      
    FROM
        public.tb_sica_catalogo_clasificacion_actividades ca
    JOIN
        public.tb_sica_catalogo_departamentos d ON ca.id_departamento = d.id_departamento
    WHERE
        ca.id_clasificacion_actividad = p_id_clasificacion_actividad;
END;
$$;

ALTER FUNCTION public.fn_sica_departamento_obtener_por_id_clasificacion(integer) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_departamento_obtener_por_id_consulta(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_departamento_obtener_por_id_consulta(
    p_id_departamento integer
)
RETURNS TABLE(id_departamento integer, descripcion character varying, id_gerencia integer, baja boolean, fecha_creacion timestamp without time zone, fecha_modificacion timestamp without time zone)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        d.id_departamento, 
        d.descripcion, 
        d.id_gerencia, 
        d.baja, 
        d.fecha_creacion, 
        d.fecha_modificacion
    FROM 
        public.tb_sica_catalogo_departamentos d
    WHERE d.id_departamento = p_id_departamento;
END;
$$;

ALTER FUNCTION public.fn_sica_departamento_obtener_por_id_consulta(integer) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_departamento_sica_actualizar(integer, varchar, boolean, integer);
CREATE OR REPLACE FUNCTION public.fn_sica_departamento_sica_actualizar(
    p_id_departamento integer, 
    p_descripcion character varying, 
    p_baja boolean, 
    p_usuario_modificacion integer
) 
RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    _json jsonb;
BEGIN
    -- Actualizar el departamento en la tabla tb_sica_catalogo_departamentos
    UPDATE public.tb_sica_catalogo_departamentos
    SET 
        descripcion = p_descripcion,
        baja = p_baja,
        fecha_modificacion = CURRENT_TIMESTAMP
    WHERE id_departamento = p_id_departamento;

    -- Registrar la operación en la tabla de seguimiento
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name, 
        id_registro, 
        accion, 
        usuario_id, 
        fecha
    ) VALUES (
        'tb_sica_catalogo_departamentos', 
        p_id_departamento, 
        'UPDATE', 
        p_usuario_modificacion, 
        CURRENT_TIMESTAMP
    );

    -- Generar el JSONB del registro actualizado para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_catalogo_departamentos t
    WHERE t.id_departamento = p_id_departamento;

    -- Llamar a la función de consolidación para enviar el registro actualizado a todas las sucursales
    PERFORM public.fn_consolidador_registrarmovimiento(
        _json,
        'u', -- 'u' indica que es una actualización
        'tb_sica_catalogo_departamentos',
        0    -- Se pasa 0 para consolidación global en todas las sucursales
    );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al actualizar el departamento: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.fn_sica_departamento_sica_actualizar(integer, varchar, boolean, integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_departamentos_detalle_obtener_consulta();
CREATE OR REPLACE FUNCTION public.fn_sica_departamentos_detalle_obtener_consulta()
RETURNS TABLE(
    id_departamento integer, 
    descripcion character varying, 
    descripcion_gerencia character varying,
    baja boolean)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        d.id_departamento, 
        d.descripcion AS descripcion, 
        g.descripcion AS descripcion_gerencia,
        d.baja
    FROM 
        public.tb_sica_catalogo_departamentos d
    JOIN 
        public.tb_sica_catalogo_gerencias g ON d.id_gerencia = g.id_gerencia
    ORDER BY 
        d.id_departamento ASC;
END;
$$;

ALTER FUNCTION public.fn_sica_departamentos_detalle_obtener_consulta() OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_departamentos_obtener_por_id_gerencia_consulta(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_departamentos_obtener_por_id_gerencia_consulta(
    p_id_gerencia integer
)
RETURNS TABLE(id_departamento integer, descripcion character varying, baja boolean, fecha_creacion timestamp without time zone, fecha_modificacion timestamp without time zone)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        d.id_departamento,
        d.descripcion,
        d.baja,
        d.fecha_creacion,
        d.fecha_modificacion
    FROM 
        public.tb_sica_catalogo_departamentos d
    WHERE d.id_gerencia = p_id_gerencia;
END;
$$;

ALTER FUNCTION public.fn_sica_departamentos_obtener_por_id_gerencia_consulta(integer) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_departamentos_obtener_todos_consulta();
CREATE OR REPLACE FUNCTION public.fn_sica_departamentos_obtener_todos_consulta()
RETURNS TABLE(id_departamento integer, descripcion character varying, id_gerencia integer, baja boolean, fecha_creacion timestamp without time zone, fecha_modificacion timestamp without time zone)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        d.id_departamento, 
        d.descripcion, 
        d.id_gerencia, 
        d.baja, 
        d.fecha_creacion, 
        d.fecha_modificacion
    FROM 
        public.tb_sica_catalogo_departamentos d
    WHERE 
        d.baja = false;
END;
$$;

ALTER FUNCTION public.fn_sica_departamentos_obtener_todos_consulta() OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_estatus_obtener_todos();
CREATE OR REPLACE FUNCTION public.fn_sica_estatus_obtener_todos()
RETURNS TABLE(id_estatus integer, descripcion character varying, clave character varying)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY 
    SELECT 
        e.id_estatus, 
        e.descripcion, 
        e.clave
    FROM 
        public.tb_sica_catalogo_estatus e
    WHERE 
        e.id_estatus <> 4;  -- Omitir el registro con id_estatus = 4
END;
$$;

ALTER FUNCTION public.fn_sica_estatus_obtener_todos() OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_gerencia_actualizar(integer, varchar, boolean, integer);
CREATE OR REPLACE FUNCTION public.fn_sica_gerencia_actualizar(
    p_id_gerencia integer, 
    p_descripcion character varying, 
    p_baja boolean, 
    p_usuario_modificacion integer
) 
RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    _json jsonb;
BEGIN
    -- Actualizar el registro en la tabla tb_sica_catalogo_gerencias
    UPDATE public.tb_sica_catalogo_gerencias
    SET
        descripcion = p_descripcion,
        baja = p_baja,
        fecha_modificacion = CURRENT_TIMESTAMP
    WHERE id_gerencia = p_id_gerencia;

    -- Registrar la operación en la tabla de seguimiento
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name, 
        id_registro, 
        accion, 
        usuario_id, 
        fecha
    ) VALUES (
        'tb_sica_catalogo_gerencias', 
        p_id_gerencia, 
        'UPDATE', 
        p_usuario_modificacion, 
        CURRENT_TIMESTAMP
    );

    -- Generar el JSONB del registro actualizado para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_catalogo_gerencias t
    WHERE t.id_gerencia = p_id_gerencia;

    -- Llamar a la función de consolidación para enviar el registro actualizado a todas las sucursales
    PERFORM public.fn_consolidador_registrarmovimiento(
        _json,
        'u', -- 'u' indica que es una actualización
        'tb_sica_catalogo_gerencias',
        0    -- Se pasa 0 para consolidación global en todas las sucursales
    );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al actualizar la gerencia: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.fn_sica_gerencia_actualizar(integer, varchar, boolean, integer) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_gerencia_insertar(varchar, boolean, integer);
CREATE OR REPLACE FUNCTION public.fn_sica_gerencia_insertar(
    p_descripcion character varying, 
    p_baja boolean, 
    p_usuario_creacion integer
) 
RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    v_id_gerencia integer;
    _json jsonb;
BEGIN
    -- Insertar el nuevo registro en la tabla tb_sica_catalogo_gerencias
    INSERT INTO public.tb_sica_catalogo_gerencias(
        descripcion, 
        baja, 
        fecha_creacion, 
        fecha_modificacion
    ) 
    VALUES (
        p_descripcion, 
        p_baja, 
        CURRENT_TIMESTAMP, 
        CURRENT_TIMESTAMP
    ) RETURNING id_gerencia INTO v_id_gerencia;

    -- Registrar la operación en la tabla de seguimiento
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name, 
        id_registro, 
        accion, 
        usuario_id, 
        fecha
    ) VALUES (
        'tb_sica_catalogo_gerencias', 
        v_id_gerencia, 
        'INSERT', 
        p_usuario_creacion, 
        CURRENT_TIMESTAMP
    );

    -- Generar el JSONB del nuevo registro para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_catalogo_gerencias t
    WHERE t.id_gerencia = v_id_gerencia;

    -- Llamar a la función de consolidación para enviar el registro a todas las sucursales
    PERFORM public.fn_consolidador_registrarmovimiento(
        _json,
        'i', -- 'i' indica que es una inserción
        'tb_sica_catalogo_gerencias',
        0    -- Se pasa 0 para consolidación global en todas las sucursales
    );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al insertar la gerencia: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.fn_sica_gerencia_insertar(varchar, boolean, integer) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_gerencia_obtener_por_id_consulta(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_gerencia_obtener_por_id_consulta(p_id_gerencia integer)
RETURNS TABLE(id_gerencia integer, descripcion character varying, baja boolean, fecha_creacion timestamp without time zone, fecha_modificacion timestamp without time zone)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        g.id_gerencia,
        g.descripcion,
        g.baja,
        g.fecha_creacion,
        g.fecha_modificacion
    FROM 
        public.tb_sica_catalogo_gerencias AS g
    WHERE 
        g.id_gerencia = p_id_gerencia;
END;
$$;

ALTER FUNCTION public.fn_sica_gerencia_obtener_por_id_consulta(integer) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_gerencia_obtener_todos_consulta();
CREATE OR REPLACE FUNCTION public.fn_sica_gerencia_obtener_todos_consulta()
RETURNS TABLE(id_gerencia integer, descripcion character varying, baja boolean, fecha_creacion timestamp without time zone, fecha_modificacion timestamp without time zone)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        g.id_gerencia,
        g.descripcion,
        g.baja,
        g.fecha_creacion,
        g.fecha_modificacion
    FROM 
        public.tb_sica_catalogo_gerencias g
    WHERE 
        g.baja = false;
END;
$$;

ALTER FUNCTION public.fn_sica_gerencia_obtener_todos_consulta() OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_grupo_act_obtener_por_id_clasificacion(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_grupo_act_obtener_por_id_clasificacion(p_id_clasificacion_actividad integer)
RETURNS TABLE(id_grupo_actividad integer, nombre character varying, descripcion text, baja boolean, id_clasificacion_actividad integer, fecha_creacion timestamp without time zone, fecha_modificacion timestamp without time zone)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        ga.id_grupo_actividad,
        ga.nombre,
        ga.descripcion,
        ga.baja,
        ga.id_clasificacion_actividad,
        ga.fecha_creacion,
        ga.fecha_modificacion
    FROM 
        public.tb_sica_catalogo_grupo_actividades ga
    WHERE 
        ga.id_clasificacion_actividad = p_id_clasificacion_actividad;
END;
$$;

ALTER FUNCTION public.fn_sica_grupo_act_obtener_por_id_clasificacion(integer) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_grupo_actividad_insertar(varchar, text, integer, boolean, integer);
CREATE OR REPLACE FUNCTION public.fn_sica_grupo_actividad_insertar(
    p_nombre character varying, 
    p_descripcion text, 
    p_id_clasificacion_actividad integer, 
    p_baja boolean, 
    p_usuario_creacion integer
) 
RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    v_id_grupo_actividad integer;
    _json jsonb;
BEGIN
    -- Insertar un nuevo registro en la tabla tb_sica_catalogo_grupo_actividades
    INSERT INTO public.tb_sica_catalogo_grupo_actividades (
        nombre, 
        descripcion, 
        id_clasificacion_actividad, 
        baja, 
        fecha_creacion, 
        fecha_modificacion
    ) 
    VALUES (
        p_nombre, 
        p_descripcion, 
        p_id_clasificacion_actividad,
        p_baja, 
        CURRENT_TIMESTAMP, 
        CURRENT_TIMESTAMP
    ) RETURNING id_grupo_actividad INTO v_id_grupo_actividad;

    -- Generar el JSONB solo del registro recién insertado
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_catalogo_grupo_actividades t
    WHERE t.id_grupo_actividad = v_id_grupo_actividad;

    -- Registrar la operación en la tabla de seguimiento
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name, 
        id_registro, 
        accion, 
        usuario_id, 
        fecha
    ) VALUES (
        'tb_sica_catalogo_grupo_actividades', 
        v_id_grupo_actividad, 
        'INSERT', 
        p_usuario_creacion, 
        CURRENT_TIMESTAMP
    );

    -- Llamar a la función de consolidación para enviar el registro a todas las sucursales
    PERFORM public.fn_consolidador_registrarmovimiento(
        _json,
        'i', -- 'i' indica que es una inserción
        'tb_sica_catalogo_grupo_actividades',
        0    -- Se pasa 0 para consolidación global en todas las sucursales
    );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al insertar en grupo_actividades: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.fn_sica_grupo_actividad_insertar(varchar, text, integer, boolean, integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_grupo_actividad_obtener_por_id_consulta(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_grupo_actividad_obtener_por_id_consulta(p_id_grupo_actividad integer)
RETURNS TABLE(
    id_grupo_actividad integer, 
    nombre character varying, 
    descripcion text, 
    id_clasificacion_actividad integer, 
    id_departamento integer,  -- Nuevo campo para obtener el departamento
    baja boolean, 
    fecha_creacion timestamp without time zone, 
    fecha_modificacion timestamp without time zone)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        ga.id_grupo_actividad, 
        ga.nombre, 
        ga.descripcion, 
        ga.id_clasificacion_actividad, 
        d.id_departamento,  -- Obtenemos el id_departamento de la tabla relacionada
        ga.baja, 
        ga.fecha_creacion, 
        ga.fecha_modificacion
    FROM public.tb_sica_catalogo_grupo_actividades ga
    JOIN public.tb_sica_catalogo_clasificacion_actividades ca ON ga.id_clasificacion_actividad = ca.id_clasificacion_actividad
    JOIN public.tb_sica_catalogo_departamentos d ON ca.id_departamento = d.id_departamento  -- Join para obtener el departamento
    WHERE ga.id_grupo_actividad = p_id_grupo_actividad;
END;
$$;

ALTER FUNCTION public.fn_sica_grupo_actividad_obtener_por_id_consulta(integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_grupo_actividad_obtener_todos_consulta();
CREATE OR REPLACE FUNCTION public.fn_sica_grupo_actividad_obtener_todos_consulta()
RETURNS TABLE(id_grupo_actividad integer, nombre character varying, descripcion text, id_clasificacion_actividad integer, baja boolean, fecha_creacion timestamp without time zone, fecha_modificacion timestamp without time zone)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        ga.id_grupo_actividad, 
        ga.nombre, 
        ga.descripcion, 
        ga.id_clasificacion_actividad, 
        ga.baja, 
        ga.fecha_creacion, 
        ga.fecha_modificacion
    FROM public.tb_sica_catalogo_grupo_actividades AS ga;
END;
$$;

ALTER FUNCTION public.fn_sica_grupo_actividad_obtener_todos_consulta() OWNER TO postgres;

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
    );

    -- Generar el JSONB del nuevo registro para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_relacion_usuarios_grupo_responsables t
    WHERE t.id_usuario = p_id_usuario 
      AND t.id_grupo_usuario_responsable = p_id_grupo_usuario_responsable;

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


DROP FUNCTION IF EXISTS public.fn_sica_grupo_actividad_actualizar(
    integer, varchar, text, integer, boolean, integer
);
CREATE OR REPLACE FUNCTION public.fn_sica_grupo_actividad_actualizar(
    p_id_grupo_actividad integer,
    p_nombre character varying,
    p_descripcion text,
    p_id_clasificacion_actividad integer,
    p_baja boolean,
    p_usuario_modificacion integer
) RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    _json jsonb;
    v_id_grupo_actividad integer;
BEGIN
    -- Realiza la actualización del registro en la tabla
    UPDATE public.tb_sica_catalogo_grupo_actividades
    SET
        nombre = p_nombre,
        descripcion = p_descripcion,
        id_clasificacion_actividad = p_id_clasificacion_actividad,
        baja = p_baja,
        fecha_modificacion = CURRENT_TIMESTAMP  -- Establece la fecha de modificación al momento actual
    WHERE id_grupo_actividad = p_id_grupo_actividad
    RETURNING id_grupo_actividad INTO v_id_grupo_actividad;

    -- Verifica si el UPDATE ha afectado algún registro
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Grupo de actividad con ID % no encontrado.', p_id_grupo_actividad;
    END IF;

    -- Registrar la operación en la tabla de seguimiento
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name, 
        id_registro, 
        accion, 
        usuario_id, 
        fecha
    ) VALUES (
        'tb_sica_catalogo_grupo_actividades',  -- Nombre de la tabla
        v_id_grupo_actividad, 
        'UPDATE', 
        p_usuario_modificacion, 
        CURRENT_TIMESTAMP
    );

    -- Generar el JSONB del registro actualizado para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_catalogo_grupo_actividades t
    WHERE t.id_grupo_actividad = v_id_grupo_actividad;

    -- Llamar a la función de consolidación para enviar el registro actualizado a todas las sucursales
    PERFORM public.fn_consolidador_registrarmovimiento(
        _json,
        'u', -- 'u' indica que es una actualización
        'tb_sica_catalogo_grupo_actividades',
        0    -- Se pasa 0 para consolidación global en todas las sucursales
    );

EXCEPTION
    WHEN OTHERS THEN
        -- Proporciona detalles del error en caso de fallo en la actualización
        RAISE EXCEPTION 'Error al actualizar el grupo de actividad: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.fn_sica_grupo_actividad_actualizar(
    integer, varchar, text, integer, boolean, integer
) OWNER TO postgres;



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

DROP FUNCTION IF EXISTS public.fn_sica_grupo_responsable_por_departamento(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_grupo_responsable_por_departamento(p_id_departamento integer)
RETURNS TABLE(id_grupo_usuario_responsable integer, nombre character varying, descripcion text, fecha_creacion timestamp without time zone, id_departamento integer)
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
        g.id_departamento
    FROM 
        public.tb_sica_grupo_usuarios_responsables g
    WHERE 
        g.id_departamento = p_id_departamento;
END;
$$;

ALTER FUNCTION public.fn_sica_grupo_responsable_por_departamento(integer) OWNER TO postgres;

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


DROP FUNCTION IF EXISTS public.fn_sica_grupos_y_clasificaciones_actividades_obtener_detalle();
CREATE OR REPLACE FUNCTION public.fn_sica_grupos_y_clasificaciones_actividades_obtener_detalle()
RETURNS TABLE(
    id_grupo_actividad integer, 
    nombre_grupo character varying, 
    descripcion_grupo text, 
    descripcion_clasificacion text,
    baja_grupo boolean,
    baja_clasificacion boolean)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        g.id_grupo_actividad, 
        g.nombre AS nombre_grupo, 
        g.descripcion AS descripcion_grupo, 
        c.descripcion AS descripcion_clasificacion,
        g.baja AS baja_grupo,
        c.baja AS baja_clasificacion
    FROM 
        public.tb_sica_catalogo_grupo_actividades g
    JOIN 
        public.tb_sica_catalogo_clasificacion_actividades c ON g.id_clasificacion_actividad = c.id_clasificacion_actividad
    ORDER BY 
        g.id_grupo_actividad ASC;
END;
$$;

ALTER FUNCTION public.fn_sica_grupos_y_clasificaciones_actividades_obtener_detalle() OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_jefes_responsables_por_departamento_obtener_consulta(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_jefes_responsables_por_departamento_obtener_consulta(p_id_departamento integer)
RETURNS TABLE(id_usuario_sica integer, responsable boolean, id_grupo_usuario integer, id_usuario integer, nombre_usuario character varying, usuario character varying, id_departamento integer, id_gerencia integer, descripcion_departamento character varying)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        us.id_usuario_sica, 
        us.responsable, 
        us.id_grupo_usuario, 
        us.id_usuario, 
        cu.nombre AS nombre_usuario, 
        cu.usuario AS usuario, 
        us.id_departamento, 
        us.id_gerencia, 
        d.descripcion AS descripcion_departamento
    FROM 
        public.tb_sica_catalogo_usuarios_sica us
    JOIN 
        public.tb_sica_catalogo_departamentos d ON us.id_departamento = d.id_departamento
    JOIN 
        public.tb_catalogo_usuarios cu ON us.id_usuario = cu.id_usuario
    JOIN 
        public.tb_sica_catalogo_grupos_usuarios gu ON us.id_grupo_usuario = gu.id_grupo_usuario
    WHERE 
        us.responsable = TRUE  -- Filtra usuarios que son responsables.
        AND us.jefe_area = TRUE  -- Filtra usuarios que son jefes de área.
        --AND (gu.descripcion = 'Gerencia' OR gu.descripcion = 'Administradores')  -- Filtra usuarios que pertenecen a 'Gerencia' o 'Administradores'.
        AND d.baja = FALSE  -- Asegura que el departamento no esté dado de baja.
        AND d.id_departamento = p_id_departamento;  -- Filtra por el ID del departamento especificado.
END;
$$;

ALTER FUNCTION public.fn_sica_jefes_responsables_por_departamento_obtener_consulta(integer) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_mensajes_obtener_por_atencion(bigint, integer);
CREATE OR REPLACE FUNCTION public.fn_sica_mensajes_obtener_por_atencion(p_id_atencion bigint, p_id_sucursal integer)
RETURNS TABLE(
    id_mensaje bigint,  -- Cambiado a BIGINT
    descripcion text, 
    fecha_creacion timestamp without time zone, 
    es_interno boolean, 
    id_atencion bigint,  -- Cambiado a BIGINT
    id_sucursal integer, 
    id_usuario_creacion integer)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT
        m.id_mensaje,
        m.descripcion,
        m.fecha_creacion,
        m.es_interno,
        m.id_atencion,
        m.id_sucursal,
        m.id_usuario_creacion
    FROM public.tb_sica_mensajes m
    JOIN public.tb_catalogo_usuarios u ON m.id_usuario_creacion = u.id_usuario  
    WHERE m.id_atencion = p_id_atencion
      AND m.id_sucursal = p_id_sucursal
    ORDER BY m.fecha_creacion;
END;
$$;

-- Cambiar el propietario de la función
ALTER FUNCTION public.fn_sica_mensajes_obtener_por_atencion(bigint, integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_obtener_clasificaciones_por_id_departamento(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_obtener_clasificaciones_por_id_departamento(p_id_departamento integer)
RETURNS TABLE(id_clasificacion_actividad integer, nombre_clasificacion character varying, descripcion_clasificacion text, nombre_departamento character varying)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        ca.id_clasificacion_actividad, 
        ca.nombre AS nombre_clasificacion, 
        ca.descripcion AS descripcion_clasificacion,
        d.descripcion AS nombre_departamento
    FROM public.tb_sica_catalogo_clasificacion_actividades ca
    JOIN public.tb_sica_catalogo_departamentos d ON ca.id_departamento = d.id_departamento
    WHERE 
        ca.id_departamento = p_id_departamento
        AND ca.baja = false
        AND d.baja = false;
END;
$$;

ALTER FUNCTION public.fn_sica_obtener_clasificaciones_por_id_departamento(integer) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_obtener_grupo_responsable_por_actividad(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_obtener_grupo_responsable_por_actividad(p_id_actividad integer)
RETURNS TABLE(id_grupo_usuario_responsable integer, descripcion character varying)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        gr.id_grupo_usuario_responsable, 
        gr.descripcion::character varying
    FROM 
        public.tb_sica_catalogo_actividades a
    JOIN 
        public.tb_sica_grupo_usuarios_responsables gr ON a.id_grupo_usuario_responsable = gr.id_grupo_usuario_responsable
    WHERE 
        a.id_actividad = p_id_actividad;
END;
$$;

ALTER FUNCTION public.fn_sica_obtener_grupo_responsable_por_actividad(integer) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_obtener_responsable_y_departamento(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_obtener_responsable_y_departamento(p_id_departamento integer)
RETURNS TABLE(id_usuario_sica integer, nombre_usuario character varying, correo_usuario character varying, es_responsable boolean, nombre_departamento character varying)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT
        u.id_usuario_sica,
        c.nombre AS nombre_usuario,
        u.correo AS correo_usuario,
        u.responsable AS es_responsable,
        d.descripcion AS nombre_departamento
    FROM public.tb_sica_catalogo_usuarios_sica u
    INNER JOIN public.tb_catalogo_usuarios c ON u.id_usuario = c.id_usuario
    INNER JOIN public.tb_sica_catalogo_departamentos d ON u.id_departamento = d.id_departamento
    WHERE u.id_departamento = p_id_departamento AND u.responsable = TRUE;
END;
$$;

ALTER FUNCTION public.fn_sica_obtener_responsable_y_departamento(integer) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_responsables_por_departamento_obtener_consulta(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_responsables_por_departamento_obtener_consulta(p_id_departamento integer)
RETURNS TABLE(id_usuario_sica integer, responsable boolean, id_grupo_usuario integer, id_usuario integer, nombre_usuario character varying, usuario character varying, id_departamento integer, id_gerencia integer, descripcion_departamento character varying)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        us.id_usuario_sica,
        us.responsable,
        us.id_grupo_usuario,
        us.id_usuario,
        cu.nombre AS nombre_usuario,
        cu.usuario,
        us.id_departamento,
        us.id_gerencia,
        d.descripcion AS descripcion_departamento
    FROM 
        public.tb_sica_catalogo_usuarios_sica us
    JOIN 
        public.tb_sica_catalogo_departamentos d ON us.id_departamento = d.id_departamento
    JOIN 
        public.tb_catalogo_usuarios cu ON us.id_usuario = cu.id_usuario
    WHERE 
        us.id_departamento = p_id_departamento AND us.responsable = TRUE;
END;
$$;

ALTER FUNCTION public.fn_sica_responsables_por_departamento_obtener_consulta(integer) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_usuario_grupo_responsable_todos_consulta();
CREATE OR REPLACE FUNCTION public.fn_sica_usuario_grupo_responsable_todos_consulta()
RETURNS TABLE(id_usuario integer, nombre_usuario character varying, usuario character varying, id_grupo_usuario_responsable integer, nombre_grupo character varying, descripcion_grupo text, id_departamento integer, descripcion_departamento character varying)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        u.id_usuario, 
        u.nombre AS nombre_usuario, 
        u.usuario,  
        gr.id_grupo_usuario_responsable, 
        gr.nombre AS nombre_grupo, 
        gr.descripcion AS descripcion_grupo,
        gr.id_departamento,
        d.descripcion AS descripcion_departamento
    FROM 
        public.tb_catalogo_usuarios u
    JOIN 
        public.tb_sica_relacion_usuarios_grupo_responsables r ON u.id_usuario = r.id_usuario
    JOIN 
        public.tb_sica_grupo_usuarios_responsables gr ON r.id_grupo_usuario_responsable = gr.id_grupo_usuario_responsable
    JOIN 
        public.tb_sica_catalogo_departamentos d ON gr.id_departamento = d.id_departamento;
END;
$$;

ALTER FUNCTION public.fn_sica_usuario_grupo_responsable_todos_consulta() OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_usuario_obtener_por_usuario(varchar);
CREATE OR REPLACE FUNCTION public.fn_sica_usuario_obtener_por_usuario(p_usuario character varying)
RETURNS TABLE(id_usuario integer, nombre character varying, usuario character varying, password character varying, restablecer_password boolean, bloqueado boolean, status character varying, ultima_actualizacion_password date, imagen text, fecha_ingreso date)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        u.id_usuario,
        u.nombre,
        u.usuario,
        u.password,
        u.restablecer_password,
        u.bloqueado,
        u.status,
        u.ultima_actualizacion_password,
        u.imagen,
        u.fecha_ingreso
    FROM 
        public.tb_catalogo_usuarios u
    WHERE 
        u.usuario = p_usuario;
END;
$$;

ALTER FUNCTION public.fn_sica_usuario_obtener_por_usuario(varchar) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_usuario_sica_actualizar(
    integer, boolean, boolean, varchar, boolean, integer, integer, integer, integer, boolean, integer
);
CREATE OR REPLACE FUNCTION public.fn_sica_usuario_sica_actualizar(
    p_id_usuario_sica integer,
    p_responsable boolean,
    p_jefe_area boolean,
    p_correo character varying,
    p_es_staff boolean,
    p_id_grupo_usuario integer,
    p_id_usuario integer,
    p_id_departamento integer,
    p_id_gerencia integer,
    p_baja boolean,  -- Nuevo parámetro para la columna baja
    p_usuario_modificacion integer
) RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    _json jsonb;
    v_id_usuario_sica integer;
BEGIN
    -- Realiza la actualización del registro en la tabla
    UPDATE public.tb_sica_catalogo_usuarios_sica
    SET
        responsable = p_responsable,
        jefe_area = p_jefe_area,
        correo = p_correo,
        es_staff = p_es_staff,
        id_grupo_usuario = p_id_grupo_usuario,
        id_usuario = p_id_usuario,
        id_departamento = p_id_departamento,
        id_gerencia = p_id_gerencia,
        baja = p_baja,  -- Actualiza la columna baja
        fecha_modificacion = CURRENT_TIMESTAMP  -- Establece la fecha de modificación al momento actual
    WHERE id_usuario_sica = p_id_usuario_sica
    RETURNING id_usuario_sica INTO v_id_usuario_sica;

    -- Verifica si el UPDATE ha afectado algún registro
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Usuario SICA con ID % no encontrado.', p_id_usuario_sica;
    END IF;

    -- Registrar la operación en la tabla de seguimiento
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name, 
        id_registro, 
        accion, 
        usuario_id, 
        fecha
    ) VALUES (
        'tb_sica_catalogo_usuarios_sica',  -- Nombre de la tabla correcto
        v_id_usuario_sica, 
        'UPDATE', 
        p_usuario_modificacion, 
        CURRENT_TIMESTAMP
    );

    -- Generar el JSONB del registro actualizado para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_catalogo_usuarios_sica t
    WHERE t.id_usuario_sica = v_id_usuario_sica;

    -- Llamar a la función de consolidación para enviar el registro actualizado a todas las sucursales
    PERFORM public.fn_consolidador_registrarmovimiento(
        _json,
        'u', -- 'u' indica que es una actualización
        'tb_sica_catalogo_usuarios_sica',
        0    -- Se pasa 0 para consolidación global en todas las sucursales
    );

EXCEPTION
    WHEN OTHERS THEN
        -- Proporciona detalles del error en caso de fallo en la actualización
        RAISE EXCEPTION 'Error al actualizar el usuario SICA: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.fn_sica_usuario_sica_actualizar(
    integer, boolean, boolean, varchar, boolean, integer, integer, integer, integer, boolean, integer
) OWNER TO postgres;



DROP FUNCTION IF EXISTS public.fn_sica_usuario_sica_detalle_obtener_consulta();
CREATE OR REPLACE FUNCTION public.fn_sica_usuario_sica_detalle_obtener_consulta()
RETURNS TABLE(
    id_usuario_sica integer, 
    nombre_usuario character varying, 
    grupo_usuario character varying, 
    departamento character varying, 
    gerencia character varying, 
    correo character varying, 
    responsable boolean, 
    jefe_area boolean, 
    es_staff boolean,
    baja boolean)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY 
    SELECT 
        u.id_usuario_sica, 
        c.nombre AS nombre_usuario, 
        g.descripcion AS grupo_usuario, 
        d.descripcion AS departamento, 
        gr.descripcion AS gerencia, 
        u.correo, 
        u.responsable, 
        u.jefe_area, 
        u.es_staff,
        u.baja AS baja  
    FROM 
        public.tb_sica_catalogo_usuarios_sica AS u
    LEFT JOIN 
        public.tb_sica_catalogo_grupos_usuarios AS g ON u.id_grupo_usuario = g.id_grupo_usuario
    LEFT JOIN 
        public.tb_catalogo_usuarios AS c ON u.id_usuario = c.id_usuario
    LEFT JOIN 
        public.tb_sica_catalogo_departamentos AS d ON u.id_departamento = d.id_departamento
    LEFT JOIN 
        public.tb_sica_catalogo_gerencias AS gr ON u.id_gerencia = gr.id_gerencia;
END;
$$;

ALTER FUNCTION public.fn_sica_usuario_sica_detalle_obtener_consulta() OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_usuario_sica_insertar(
    boolean, boolean, varchar, boolean, integer, integer, integer, integer, integer, boolean
);
CREATE OR REPLACE FUNCTION public.fn_sica_usuario_sica_insertar(
    p_responsable boolean,
    p_jefe_area boolean,
    p_correo character varying,
    p_es_staff boolean,
    p_id_grupo_usuario integer,
    p_id_usuario integer,
    p_id_departamento integer,
    p_id_gerencia integer,
    p_usuario_creacion integer,
    p_baja boolean
) RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    v_id_usuario_sica integer;
    _json jsonb;
BEGIN
    -- Insertar un nuevo registro en la tabla tb_sica_catalogo_usuarios_sica
    INSERT INTO public.tb_sica_catalogo_usuarios_sica (
        responsable,
        jefe_area,
        correo,
        es_staff,
        fecha_creacion,
        fecha_modificacion,
        id_grupo_usuario,
        id_usuario,
        id_departamento,
        id_gerencia,
        baja
    ) VALUES (
        p_responsable,
        p_jefe_area,
        p_correo,
        p_es_staff,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        p_id_grupo_usuario,
        p_id_usuario,
        p_id_departamento,
        p_id_gerencia,
        p_baja
    ) RETURNING id_usuario_sica INTO v_id_usuario_sica;

    -- Registrar la operación en la tabla de seguimiento
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name, 
        id_registro, 
        accion, 
        usuario_id, 
        fecha
    ) VALUES (
        'tb_sica_catalogo_usuarios_sica', 
        v_id_usuario_sica, 
        'INSERT', 
        p_usuario_creacion, 
        CURRENT_TIMESTAMP
    );

    -- Generar el JSONB del nuevo registro para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_catalogo_usuarios_sica t
    WHERE t.id_usuario_sica = v_id_usuario_sica;

    -- Llamar a la función de consolidación para enviar el registro a todas las sucursales
    PERFORM public.fn_consolidador_registrarmovimiento(
        _json,
        'i', -- 'i' indica que es una inserción
        'tb_sica_catalogo_usuarios_sica',
        0    -- Se pasa 0 para consolidación global en todas las sucursales
    );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al insertar en usuarios_sica: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.fn_sica_usuario_sica_insertar(
    boolean, boolean, varchar, boolean, integer, integer, integer, integer, integer, boolean
) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_usuario_sica_obtener_por_id_consulta(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_usuario_sica_obtener_por_id_consulta(p_id_usuario_sica integer)
RETURNS TABLE(id_usuario_sica integer, responsable boolean, jefe_area boolean, correo character varying, es_staff boolean, id_grupo_usuario integer, id_usuario integer, id_departamento integer, id_gerencia integer, baja boolean)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY 
    SELECT 
        u.id_usuario_sica, 
        u.responsable, 
        u.jefe_area, 
        u.correo, 
        u.es_staff,
        u.id_grupo_usuario, 
        u.id_usuario, 
        u.id_departamento, 
        u.id_gerencia,
        u.baja
    FROM 
        public.tb_sica_catalogo_usuarios_sica u
    WHERE 
        u.id_usuario_sica = p_id_usuario_sica;
END;
$$;

ALTER FUNCTION public.fn_sica_usuario_sica_obtener_por_id_consulta(integer) OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_usuario_sica_obtener_todos_consulta();
CREATE OR REPLACE FUNCTION public.fn_sica_usuario_sica_obtener_todos_consulta()
RETURNS TABLE(id_usuario_sica integer, responsable boolean, jefe_area boolean, correo character varying, es_staff boolean, fecha_creacion timestamp without time zone, id_grupo_usuario integer, id_usuario integer, id_departamento integer, id_gerencia integer)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        s.id_usuario_sica,
        s.responsable,
        s.jefe_area,
        s.correo,
        s.es_staff,
        s.fecha_creacion,
        s.id_grupo_usuario,
        s.id_usuario,
        s.id_departamento,
        s.id_gerencia
    FROM public.tb_sica_catalogo_usuarios_sica s;
END;
$$;

ALTER FUNCTION public.fn_sica_usuario_sica_obtener_todos_consulta() OWNER TO postgres;

DROP FUNCTION IF EXISTS public.sica_mensajes_obtener_por_id_atencion(bigint);
DROP FUNCTION IF EXISTS public.sica_mensajes_obtener_por_id_atencion(bigint, integer);
CREATE OR REPLACE FUNCTION public.sica_mensajes_obtener_por_id_atencion(
    p_id_atencion bigint,  -- Cambiado a BIGINT
    p_id_sucursal integer  -- Agregado el parámetro para la sucursal
)
RETURNS TABLE(
    descripcion_departamento character varying, 
    id_atencion bigint,  -- Cambiado a BIGINT
    id_mensaje bigint,   -- Cambiado a BIGINT
    descripcion_mensaje text, 
    fecha_creacion timestamp without time zone)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        dep.descripcion AS descripcion_departamento,
        msg.id_atencion,
        msg.id_mensaje,
        msg.descripcion AS descripcion_mensaje,
        msg.fecha_creacion
    FROM 
        public.tb_sica_mensajes msg
    JOIN 
        public.tb_sica_atenciones atn ON msg.id_atencion = atn.id_atencion
    JOIN 
        public.tb_sica_catalogo_departamentos dep ON atn.id_departamento_actual = dep.id_departamento
    WHERE 
        msg.id_atencion = p_id_atencion
        AND msg.id_sucursal = p_id_sucursal;  -- Condición agregada para filtrar por sucursal
END;
$$;

-- Cambiar el propietario de la función
ALTER FUNCTION public.sica_mensajes_obtener_por_id_atencion(bigint, integer) OWNER TO postgres;



DROP FUNCTION IF EXISTS public.sica_usuario_a_grupo_asignar(integer, integer);
CREATE OR REPLACE FUNCTION public.sica_usuario_a_grupo_asignar(p_id_usuario integer, p_id_grupo_usuario_responsable integer)
RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    _json jsonb;
BEGIN
    -- Insertar la relación entre el usuario y el grupo de usuarios responsables
    INSERT INTO public.tb_sica_relacion_usuarios_grupo_responsables (
        id_usuario, id_grupo_usuario_responsable
    ) VALUES (
        p_id_usuario, p_id_grupo_usuario_responsable
    );

    -- Generar el JSONB del nuevo registro para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_relacion_usuarios_grupo_responsables t
    WHERE t.id_usuario = p_id_usuario 
      AND t.id_grupo_usuario_responsable = p_id_grupo_usuario_responsable;

    -- Llamar a la función de consolidación para enviar el registro a todas las sucursales
    PERFORM public.fn_consolidador_registrarmovimiento(
        _json,
        'i', -- 'i' indica que es una inserción
        'tb_sica_relacion_usuarios_grupo_responsables',
        0    -- Se pasa 0 para consolidación global en todas las sucursales
    );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al asignar usuario al grupo: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.sica_usuario_a_grupo_asignar(integer, integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_sucursales_obtener_todas_consulta();
CREATE OR REPLACE FUNCTION public.fn_sica_sucursales_obtener_todas_consulta()
RETURNS TABLE(id_sucursal integer, descripcion_corta character varying, descripcion character varying, telefono character varying, status character varying, serie_facturacion character varying, id_zona integer, id_clasificacion integer, id_subclasificacion integer, id_categoria integer, id_subcategoria integer, numero_de_sucursal integer, es_cedis boolean)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT
        s.id_sucursal,
        s.descripcion_corta,
        s.descripcion,
        s.telefono,
        s.status,
        s.serie_facturacion,
        s.id_zona,
        s.id_clasificacion,
        s.id_subclasificacion,
        s.id_categoria,
        s.id_subcategoria,
        s.numero_de_sucursal,
        s.es_cedis
    FROM public.tb_catalogo_sucursales s
    WHERE s.id_sucursal != 1;
END;
$$;

ALTER FUNCTION public.fn_sica_sucursales_obtener_todas_consulta() OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_actividades_obtener_todas_consulta();
CREATE OR REPLACE FUNCTION public.fn_sica_actividades_obtener_todas_consulta()
RETURNS TABLE(id_actividad integer, nombre character varying, descripcion text, tiempo numeric, id_grupo_actividad integer, id_grupo_usuario_responsable integer, baja boolean, fecha_creacion timestamp without time zone, fecha_modificacion timestamp without time zone)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        a.id_actividad, 
        a.nombre, 
        a.descripcion, 
        a.tiempo, 
        a.id_grupo_actividad, 
        a.id_grupo_usuario_responsable,
        a.baja, 
        a.fecha_creacion, 
        a.fecha_modificacion
    FROM 
        public.tb_sica_catalogo_actividades a;
END;
$$;

ALTER FUNCTION public.fn_sica_actividades_obtener_todas_consulta() OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_mensaje_agregar(text, boolean, bigint, integer);
CREATE OR REPLACE FUNCTION public.fn_sica_mensaje_agregar(
    p_descripcion text, 
    p_es_interno boolean, 
    p_id_atencion bigint,  -- Cambiado a BIGINT
    p_id_usuario_creacion integer)
RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE
    _json jsonb;
    v_id_mensaje bigint;  -- Cambiado a BIGINT
    v_id_sucursal integer;
BEGIN
    -- Obtener la sucursal asociada a la atención
    SELECT id_sucursal INTO v_id_sucursal
    FROM public.tb_sica_atenciones
    WHERE id_atencion = p_id_atencion;

    -- Insertar el mensaje en la tabla tb_sica_mensajes
    INSERT INTO public.tb_sica_mensajes(
        id_mensaje,
        id_atencion,
        id_sucursal,
        descripcion,
        fecha_creacion,
        es_interno,
        id_usuario_creacion
    )
    VALUES(
        nextval('public.tb_sica_mensajes_id_mensaje_seq'),  -- Secuencia para id_mensaje
        p_id_atencion,
        v_id_sucursal,
        p_descripcion,
        current_timestamp,
        p_es_interno,
        p_id_usuario_creacion
    ) RETURNING id_mensaje INTO v_id_mensaje;

    -- Generar el JSONB del nuevo registro para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_mensajes t
    WHERE t.id_mensaje = v_id_mensaje 
      AND t.id_atencion = p_id_atencion
      AND t.id_sucursal = v_id_sucursal;

    -- Llamar a la función de consolidación para enviar el registro a la sucursal
    PERFORM public.fn_consolidador_registrarmovimiento_para_sucursalx(
        _json,
        'i',
        'tb_sica_mensajes',
        v_id_sucursal,  -- Sucursal de destino
        NULL
    );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al insertar el mensaje: %', SQLERRM;
END;
$$;

-- Cambiar el propietario de la función
ALTER FUNCTION public.fn_sica_mensaje_agregar(text, boolean, bigint, integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_actividad_insertar(varchar, text, numeric, boolean, integer, integer, integer);
CREATE OR REPLACE FUNCTION public.fn_sica_actividad_insertar(
    p_nombre character varying, 
    p_descripcion text, 
    p_tiempo numeric, 
    p_baja boolean, 
    p_id_grupo_actividad integer, 
    p_id_grupo_usuario_responsable integer, 
    p_usuario_creacion integer
)
RETURNS integer
LANGUAGE plpgsql
AS
$$
DECLARE
    v_id_actividad integer;
    _json jsonb;
BEGIN
    -- Insertar la nueva actividad en la tabla tb_catalogo_actividades
    INSERT INTO public.tb_sica_catalogo_actividades (
        nombre, 
        descripcion, 
        tiempo, 
        baja, 
        fecha_creacion, 
        fecha_modificacion, 
        id_grupo_actividad, 
        id_grupo_usuario_responsable
    ) VALUES (
        p_nombre, 
        p_descripcion, 
        p_tiempo, 
        p_baja, 
        CURRENT_TIMESTAMP, 
        CURRENT_TIMESTAMP, 
        p_id_grupo_actividad, 
        p_id_grupo_usuario_responsable
    ) RETURNING id_actividad INTO v_id_actividad;

    -- Registrar la operación en la tabla de auditoría
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name, 
        id_registro, 
        accion, 
        usuario_id, 
        fecha
    ) VALUES (
        'public.tb_sica_catalogo_actividades', 
        v_id_actividad, 
        'INSERT', 
        p_usuario_creacion,  -- Usar el usuario_creacion proporcionado
        CURRENT_TIMESTAMP
    );

    -- Generar el JSONB del nuevo registro para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_catalogo_actividades t
    WHERE t.id_actividad = v_id_actividad;

    -- Llamar a la función de consolidación para enviar el registro a todas las sucursales
    PERFORM public.fn_consolidador_registrarmovimiento(
        _json,
        'i', -- 'i' indica que es una inserción
        'tb_sica_catalogo_actividades',
        0    -- Se pasa 0 para consolidación global en todas las sucursales
    );

    -- Devolver el ID de la nueva actividad
    RETURN v_id_actividad;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al insertar actividad: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.fn_sica_actividad_insertar(varchar, text, numeric, boolean, integer, integer, integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_atenciones_obtener_detalladas_por_usuario(integer);
CREATE OR REPLACE FUNCTION public.fn_sica_atenciones_obtener_detalladas_por_usuario(p_id_usuario integer)
RETURNS TABLE(
    id_atencion bigint,  -- Cambiado a BIGINT
    ticket character varying, 
    asunto character varying,  -- Nuevo campo "asunto" agregado
    usuario_reporto character varying, 
    usuario_grupo_asignado character varying, 
    fecha_inicio timestamp without time zone, 
    estatus_descripcion character varying,
    id_sucursal integer,  
    descripcion_sucursal character varying  
)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        a.id_atencion,
        a.ticket,
        a.asunto,  -- Seleccionar el campo "asunto"
        ur.nombre AS usuario_reporto,
        gur.nombre AS usuario_grupo_asignado,
        a.fecha_inicio,
        e.descripcion AS estatus_descripcion,
        a.id_sucursal,  
        s.descripcion AS descripcion_sucursal  
    FROM 
        public.tb_sica_atenciones a
        JOIN public.tb_catalogo_usuarios ur ON a.usuario_reporta = ur.id_usuario
        JOIN public.tb_sica_grupo_usuarios_responsables gur ON a.id_grupo_usuario_responsable = gur.id_grupo_usuario_responsable
        JOIN public.tb_sica_relacion_usuarios_grupo_responsables ugr ON a.id_grupo_usuario_responsable = ugr.id_grupo_usuario_responsable
        JOIN public.tb_catalogo_usuarios u ON ugr.id_usuario = u.id_usuario
        JOIN public.tb_sica_catalogo_estatus e ON a.id_estatus = e.id_estatus
        JOIN public.tb_catalogo_sucursales s ON a.id_sucursal = s.id_sucursal  
    WHERE
        u.id_usuario = p_id_usuario
        AND a.id_estatus IN (1, 2, 3);  
END;
$$;

ALTER FUNCTION public.fn_sica_atenciones_obtener_detalladas_por_usuario(integer) OWNER TO postgres;




DROP FUNCTION IF EXISTS public.fn_sica_atenciones_obtener_por_creador(integer);

CREATE OR REPLACE FUNCTION public.fn_sica_atenciones_obtener_por_creador(p_id_usuario integer)
RETURNS TABLE(
    id_atencion bigint,  -- Cambiado a BIGINT
    ticket character varying, 
    asunto character varying,  -- Nuevo campo "asunto" agregado
    usuario_reporto character varying, 
    fecha_inicio timestamp without time zone, 
    estatus_descripcion character varying,
    usuario_grupo_asignado character varying,  
    id_sucursal integer,  
    descripcion_sucursal character varying  
)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        a.id_atencion,
        a.ticket,
        a.asunto,  -- Seleccionar el campo "asunto"
        ur.nombre AS usuario_reporto,
        a.fecha_inicio,
        e.descripcion AS estatus_descripcion,
        gru.nombre AS usuario_grupo_asignado,  
        a.id_sucursal,  
        s.descripcion AS descripcion_sucursal  
    FROM 
        public.tb_sica_atenciones a
        JOIN public.tb_catalogo_usuarios ur ON a.usuario_reporta = ur.id_usuario
        JOIN public.tb_sica_catalogo_estatus e ON a.id_estatus = e.id_estatus
        LEFT JOIN public.tb_sica_grupo_usuarios_responsables gru ON a.id_grupo_usuario_responsable = gru.id_grupo_usuario_responsable
        LEFT JOIN public.tb_catalogo_sucursales s ON a.id_sucursal = s.id_sucursal  
    WHERE
        a.usuario_reporta = p_id_usuario  
        AND a.id_estatus IN (1, 2, 3);  
END;
$$;

ALTER FUNCTION public.fn_sica_atenciones_obtener_por_creador(integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_insertar_mensaje(text, boolean, bigint, integer);

CREATE OR REPLACE FUNCTION public.fn_sica_insertar_mensaje(
    p_descripcion text, 
    p_es_interno boolean, 
    p_id_atencion bigint,  -- Cambiado a BIGINT
    p_id_usuario_creacion integer)
RETURNS bigint  -- Cambiado a BIGINT
LANGUAGE plpgsql
AS
$$
DECLARE
    v_id_mensaje bigint;  -- Cambiado a BIGINT
    v_id_sucursal integer;
    _json jsonb;
BEGIN
    -- Obtener la sucursal asociada a la atención
    SELECT id_sucursal INTO v_id_sucursal
    FROM public.tb_sica_atenciones
    WHERE id_atencion = p_id_atencion;

    -- Insertar el mensaje en la tabla tb_sica_mensajes con fecha_creacion = CURRENT_TIMESTAMP
    INSERT INTO public.tb_sica_mensajes(
        id_mensaje,
        id_atencion,
        id_sucursal,
        descripcion,
        fecha_creacion,
        es_interno,
        id_usuario_creacion
    )
    VALUES (
        nextval('public.tb_sica_mensajes_id_mensaje_seq'),  -- Usar la secuencia para id_mensaje
        p_id_atencion,
        v_id_sucursal,
        p_descripcion,
        CURRENT_TIMESTAMP,  -- Inserta la fecha y hora actual
        p_es_interno,        -- Valor para es_interno proporcionado en la llamada a la función
        p_id_usuario_creacion
    ) RETURNING id_mensaje INTO v_id_mensaje;  -- Cambiado a BIGINT

    -- Generar el JSONB del nuevo registro para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_mensajes t
    WHERE t.id_mensaje = v_id_mensaje
      AND t.id_atencion = p_id_atencion
      AND t.id_sucursal = v_id_sucursal;

    -- Llamar a la función de consolidación para enviar el registro a la sucursal destino
    PERFORM public.fn_consolidador_registrarmovimiento_para_sucursalx(
        _json,
        'i',
        'tb_sica_mensajes',
        v_id_sucursal,
        NULL
    );

    -- Devolver el ID del mensaje insertado
    RETURN v_id_mensaje;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al insertar en mensajes: %', SQLERRM;
END;
$$;

-- Cambiar el propietario de la función
ALTER FUNCTION public.fn_sica_insertar_mensaje(text, boolean, bigint, integer) OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_atencion_cancelar(bigint, integer, integer);

CREATE OR REPLACE FUNCTION public.fn_sica_atencion_cancelar(
    p_id_atencion BIGINT,  -- Cambiado a BIGINT
    p_id_sucursal INTEGER,
    p_id_usuario_cancelo INTEGER
)
RETURNS VOID
LANGUAGE 'plpgsql'
COST 100
VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    _json jsonb;
BEGIN
    -- Verificar si la atención existe
    IF EXISTS (
        SELECT 1
        FROM public.tb_sica_atenciones
        WHERE id_atencion = p_id_atencion
        AND id_sucursal = p_id_sucursal
    ) THEN
        -- Actualizar el estatus de la atención a '6' (Cancelado)
        UPDATE public.tb_sica_atenciones
        SET id_estatus = 6,
            usuario_cancelo = p_id_usuario_cancelo,
            fecha_cancelacion = CURRENT_TIMESTAMP,
            fecha_modificacion = CURRENT_TIMESTAMP
        WHERE id_atencion = p_id_atencion
        AND id_sucursal = p_id_sucursal;

        -- Registrar la operación en la tabla de seguimiento
        INSERT INTO public.tb_sica_seguimiento (
            tabla_name, 
            id_registro, 
            accion, 
            usuario_id, 
            fecha
        ) VALUES (
            'tb_sica_atenciones', 
            p_id_atencion,  -- Cambiado a BIGINT
            'CANCEL', 
            p_id_usuario_cancelo, 
            CURRENT_TIMESTAMP
        );

        -- Generar el JSONB del registro actualizado para consolidación
        SELECT to_jsonb(t) INTO _json
        FROM public.tb_sica_atenciones t
        WHERE t.id_atencion = p_id_atencion
        AND t.id_sucursal = p_id_sucursal;

        -- Llamar a la función de consolidación para enviar el registro actualizado a todas las sucursales
        PERFORM public.fn_consolidador_registrarmovimiento_para_oficinas(
            _json,
            'u', -- 'u' indica que es una actualización
            'tb_sica_atenciones',
            NULL
        );
    ELSE
        -- Si la atención no existe, se lanza un error
        RAISE EXCEPTION 'Atención con id % y sucursal % no encontrada.', p_id_atencion, p_id_sucursal;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al cancelar la atención: %', SQLERRM;
END;
$BODY$;

-- Cambiar el propietario de la función
ALTER FUNCTION public.fn_sica_atencion_cancelar(bigint, integer, integer)
    OWNER TO postgres;



DROP FUNCTION IF EXISTS public.fn_sica_atencion_leido(bigint, integer);

CREATE OR REPLACE FUNCTION public.fn_sica_atencion_leido(
    p_id_atencion BIGINT,  -- Cambiado a BIGINT
    p_id_sucursal INTEGER
)
RETURNS VOID
LANGUAGE 'plpgsql'
COST 100
VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    _json jsonb;
    _current_status INTEGER;
BEGIN
    -- Verificar si la atención existe
    IF EXISTS (
        SELECT 1
        FROM public.tb_sica_atenciones
        WHERE id_atencion = p_id_atencion
        AND id_sucursal = p_id_sucursal
    ) THEN
        -- Obtener el estado actual de la atención
        SELECT id_estatus INTO _current_status
        FROM public.tb_sica_atenciones
        WHERE id_atencion = p_id_atencion
        AND id_sucursal = p_id_sucursal;

        -- Si el estado actual es 1 (Nuevo), actualizar a 2 (Leído)
        IF _current_status = 1 THEN
            UPDATE public.tb_sica_atenciones
            SET id_estatus = 2,  -- Cambiar a Leído
                enviar_alerta = false,  -- Desactivar alerta
                fecha_modificacion = CURRENT_TIMESTAMP
            WHERE id_atencion = p_id_atencion
            AND id_sucursal = p_id_sucursal;

        ELSE
            -- Si el estado no es 1, solo desactivar la alerta
            UPDATE public.tb_sica_atenciones
            SET enviar_alerta = false,
                fecha_modificacion = CURRENT_TIMESTAMP
            WHERE id_atencion = p_id_atencion
            AND id_sucursal = p_id_sucursal;
        END IF;

        -- Generar el JSONB del registro actualizado para consolidación
        SELECT to_jsonb(t) INTO _json
        FROM public.tb_sica_atenciones t
        WHERE t.id_atencion = p_id_atencion
        AND t.id_sucursal = p_id_sucursal;

        -- Llamar a la función de consolidación específica para sucursal
        PERFORM public.fn_consolidador_registrarmovimiento_para_sucursalx(
            _json,
            'u', -- 'u' indica que es una actualización
            'tb_sica_atenciones',
            p_id_sucursal,
            NULL
        );

    ELSE
        -- Si la atención no existe, se lanza un error
        RAISE EXCEPTION 'Atención con id % y sucursal % no encontrada.', p_id_atencion, p_id_sucursal;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al marcar como leído la atención: %', SQLERRM;
END;
$BODY$;

-- Cambiar el propietario de la función
ALTER FUNCTION public.fn_sica_atencion_leido(bigint, integer)
    OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_atencion_en_ejecucion(bigint, integer);

CREATE OR REPLACE FUNCTION public.fn_sica_atencion_en_ejecucion(
    p_id_atencion bigint,
    p_id_sucursal integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    _json jsonb;
    _current_status integer;
BEGIN
    -- Verificar si la atención existe
    IF EXISTS (
        SELECT 1
        FROM public.tb_sica_atenciones
        WHERE id_atencion = p_id_atencion
        AND id_sucursal = p_id_sucursal
    ) THEN
        -- Obtener el estado actual de la atención
        SELECT id_estatus INTO _current_status
        FROM public.tb_sica_atenciones
        WHERE id_atencion = p_id_atencion
        AND id_sucursal = p_id_sucursal;

        -- Solo actualizar a estatus '3' si el estatus actual es '2'
        IF _current_status = 2 THEN
            UPDATE public.tb_sica_atenciones
            SET id_estatus = 3,
                fecha_inicio_ejecucion = CURRENT_TIMESTAMP, -- Registrar el inicio de la ejecución
                fecha_modificacion = CURRENT_TIMESTAMP
            WHERE id_atencion = p_id_atencion
            AND id_sucursal = p_id_sucursal;

            -- Generar el JSONB del registro actualizado para consolidación
            SELECT to_jsonb(t) INTO _json
            FROM public.tb_sica_atenciones t
            WHERE t.id_atencion = p_id_atencion
            AND t.id_sucursal = p_id_sucursal;

            -- Llamar a la función de consolidación específica para sucursal
            PERFORM public.fn_consolidador_registrarmovimiento_para_sucursalx(
                _json,
                'u', -- 'u' indica que es una actualización
                'tb_sica_atenciones',
                p_id_sucursal,
                NULL
            );
        ELSE
            -- Si el estatus no es '2', no se hace la actualización
            RAISE NOTICE 'La atención con id % y sucursal % no está en estatus 2.', p_id_atencion, p_id_sucursal;
        END IF;
    ELSE
        -- Si la atención no existe, se lanza un error
        RAISE EXCEPTION 'Atención con id % y sucursal % no encontrada.', p_id_atencion, p_id_sucursal;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al marcar como en ejecución la atención: %', SQLERRM;
END;
$BODY$;

ALTER FUNCTION public.fn_sica_atencion_en_ejecucion(bigint, integer)
    OWNER TO postgres;


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


DROP FUNCTION IF EXISTS public.fn_sica_grupo_responsable_obtener_por_id(integer);

CREATE OR REPLACE FUNCTION public.fn_sica_grupo_responsable_obtener_por_id(
    p_grupo_id integer) 
    RETURNS TABLE(id_grupo_usuario_responsable integer, nombre character varying, descripcion text, id_departamento integer, fecha_creacion timestamp without time zone, fecha_modificacion timestamp without time zone, baja boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
AS $BODY$
BEGIN
    RETURN QUERY 
    SELECT 
        gru.id_grupo_usuario_responsable,
        gru.nombre,
        gru.descripcion,
        gru.id_departamento,
        gru.fecha_creacion,
        gru.fecha_modificacion,
        gru.baja
    FROM 
        public.tb_sica_grupo_usuarios_responsables gru  -- Asignar alias a la tabla
    WHERE 
        gru.id_grupo_usuario_responsable = p_grupo_id;  -- Usar el alias de la tabla
END;
$BODY$;

ALTER FUNCTION public.fn_sica_grupo_responsable_obtener_por_id(integer)
    OWNER TO postgres;


DROP FUNCTION IF EXISTS public.fn_sica_actividad_actualizar(
    integer, character varying, text, numeric(18,2), boolean, integer, integer, integer
);
CREATE OR REPLACE FUNCTION public.fn_sica_actividad_actualizar(
    p_id_actividad integer,
    p_nombre character varying,
    p_descripcion text,
    p_tiempo numeric(18,2),
    p_baja boolean,
    p_id_grupo_actividad integer,
    p_id_grupo_usuario_responsable integer,
    p_usuario_modificacion integer
)
RETURNS void
LANGUAGE 'plpgsql'
COST 100
VOLATILE PARALLEL UNSAFE
AS $$
DECLARE
    _json jsonb;
    v_id_actividad integer;
BEGIN
    -- Realiza la actualización del registro en la tabla
    UPDATE public.tb_sica_catalogo_actividades
    SET
        nombre = p_nombre,
        descripcion = p_descripcion,
        tiempo = p_tiempo,
        baja = p_baja,
        id_grupo_actividad = p_id_grupo_actividad,
        id_grupo_usuario_responsable = p_id_grupo_usuario_responsable,
        fecha_modificacion = CURRENT_TIMESTAMP  -- Establece la fecha de modificación al momento actual
    WHERE tb_sica_catalogo_actividades.id_actividad = p_id_actividad
    RETURNING id_actividad INTO v_id_actividad;

    -- Verifica si el UPDATE ha afectado algún registro
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Actividad con ID % no encontrada.', p_id_actividad;
    END IF;

    -- Registrar la operación en la tabla de seguimiento
    INSERT INTO public.tb_sica_seguimiento (
        tabla_name, 
        id_registro, 
        accion, 
        usuario_id, 
        fecha
    ) VALUES (
        'tb_sica_catalogo_actividades', 
        v_id_actividad, 
        'UPDATE', 
        p_usuario_modificacion, 
        CURRENT_TIMESTAMP
    );

    -- Generar el JSONB del registro actualizado para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_catalogo_actividades t
    WHERE t.id_actividad = v_id_actividad;

    -- Llamar a la función de consolidación para enviar el registro actualizado a todas las sucursales
    PERFORM public.fn_consolidador_registrarmovimiento(
        _json,
        'u',  -- Tipo de operación: 'u' para update
        'tb_sica_catalogo_actividades',
        0    -- Se pasa 0 para consolidación global en todas las sucursales
    );

EXCEPTION
    WHEN OTHERS THEN
        -- Proporciona detalles del error en caso de fallo en la actualización
        RAISE EXCEPTION 'Error al actualizar la actividad: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.fn_sica_actividad_actualizar(
    integer, character varying, text, numeric(18,2), boolean, integer, integer, integer
) OWNER TO postgres;


CREATE OR REPLACE FUNCTION public.fn_sica_actividad_obtener_por_id(
    p_id_actividad integer
)
RETURNS TABLE (
    id_actividad integer,
    nombre character varying,
    descripcion text,
    tiempo numeric(18,2),
    baja boolean,
    id_grupo_actividad integer,
    id_grupo_usuario_responsable integer,
    fecha_creacion timestamp without time zone,
    fecha_modificacion timestamp without time zone
) AS
$$
BEGIN
    RETURN QUERY 
    SELECT 
        t.id_actividad,
        t.nombre,
        t.descripcion,
        t.tiempo,
        t.baja,
        t.id_grupo_actividad,
        t.id_grupo_usuario_responsable,
        t.fecha_creacion,
        t.fecha_modificacion
    FROM 
        public.tb_sica_catalogo_actividades t
    WHERE 
        t.id_actividad = p_id_actividad;
END;
$$
LANGUAGE plpgsql;

ALTER FUNCTION public.fn_sica_actividad_obtener_por_id(integer)
OWNER TO postgres;

CREATE OR REPLACE FUNCTION public.fn_sica_obtener_correos_por_grupo_responsable(
    p_id_grupo_usuario_responsable integer
) 
RETURNS TABLE(correo varchar) AS
$$
BEGIN
    RETURN QUERY
    SELECT u.correo
    FROM public.tb_sica_catalogo_usuarios_sica u
    JOIN public.tb_sica_relacion_usuarios_grupo_responsables r 
    ON u.id_usuario_sica = r.id_usuario
    WHERE r.id_grupo_usuario_responsable = p_id_grupo_usuario_responsable
    AND u.baja = false;  
END;
$$ LANGUAGE plpgsql;

ALTER FUNCTION public.fn_sica_obtener_correos_por_grupo_responsable(integer)
OWNER TO postgres;

CREATE OR REPLACE FUNCTION public.fn_sica_obtener_correos_por_grupo_responsable(
    p_id_grupo_usuario_responsable integer
) 
RETURNS TABLE(correo varchar) AS
$$
BEGIN
    RETURN QUERY
    SELECT u.correo
    FROM public.tb_sica_catalogo_usuarios_sica u
    JOIN public.tb_sica_relacion_usuarios_grupo_responsables r 
        ON u.id_usuario = r.id_usuario
    WHERE r.id_grupo_usuario_responsable = p_id_grupo_usuario_responsable
    AND (u.baja IS NULL OR u.baja = false)  -- Considera null como no baja
    AND u.correo IS NOT NULL
    AND u.correo != '';
END;
$$ LANGUAGE plpgsql;

ALTER FUNCTION public.fn_sica_obtener_correos_por_grupo_responsable(integer)
OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_mensaje_insertar(text, boolean, bigint, integer, integer);

CREATE OR REPLACE FUNCTION public.fn_sica_mensaje_insertar(
    p_descripcion text, 
    p_es_interno boolean, 
    p_id_atencion BIGINT,  -- Cambiado a BIGINT
    p_id_usuario_creacion integer,
    p_id_sucursal integer
)
RETURNS integer
LANGUAGE plpgsql
AS
$$
DECLARE
    v_id_mensaje integer;
    _json jsonb;
BEGIN
    -- Validar que la combinación de id_atencion e id_sucursal existe en la tabla tb_sica_atenciones
    IF NOT EXISTS (
        SELECT 1
        FROM public.tb_sica_atenciones
        WHERE id_atencion = p_id_atencion
        AND id_sucursal = p_id_sucursal
    ) THEN
        RAISE EXCEPTION 'Atención con id_atencion % y id_sucursal % no existe en la tabla tb_sica_atenciones', p_id_atencion, p_id_sucursal;
    END IF;

    -- Insertar el mensaje en la tabla tb_sica_mensajes con fecha_creacion = CURRENT_TIMESTAMP
    INSERT INTO public.tb_sica_mensajes(
        id_atencion,
        id_sucursal,
        descripcion,
        fecha_creacion,
        es_interno,
        id_usuario_creacion
    )
    VALUES (      -- Usar la secuencia para id_mensaje
        p_id_atencion,
        p_id_sucursal,  -- Sucursal proporcionada como parámetro
        p_descripcion,
        CURRENT_TIMESTAMP, -- Inserta la fecha y hora actual
        p_es_interno, -- Valor para es_interno proporcionado en la llamada a la función
        p_id_usuario_creacion
    ) RETURNING id_mensaje INTO v_id_mensaje;

    -- Generar el JSONB del nuevo registro para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_mensajes t
    WHERE t.id_mensaje = v_id_mensaje
      AND t.id_atencion = p_id_atencion
      AND t.id_sucursal = p_id_sucursal;

    -- Llamar a la función de consolidación para enviar el registro a la sucursal destino
    PERFORM public.fn_consolidador_registrarmovimiento_para_sucursalx(
        _json,
        'i',
        'tb_sica_mensajes',
        p_id_sucursal,  -- Sucursal proporcionada como parámetro
        NULL
    );

    -- Ejecutar la función para marcar la atención como "En Ejecución"
    PERFORM public.fn_sica_atencion_en_ejecucion(p_id_atencion, p_id_sucursal);

    -- Devolver el ID del mensaje insertado
    RETURN v_id_mensaje;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al insertar en mensajes o marcar la atención como en ejecución: %', SQLERRM;
END;
$$;

ALTER FUNCTION public.fn_sica_mensaje_insertar(text, boolean, bigint, integer, integer) OWNER TO postgres;

-- DROP FUNCTION para fn_sica_atenciones_filtrar_por_usuario_reporta
DROP FUNCTION IF EXISTS public.fn_sica_atenciones_filtrar_por_usuario_reporta(integer, integer, integer, integer, timestamp without time zone, timestamp without time zone, character varying);

CREATE OR REPLACE FUNCTION public.fn_sica_atenciones_filtrar_por_usuario_reporta(
    p_id_usuario integer,
    p_estado integer DEFAULT NULL::integer,
    p_sucursal integer DEFAULT NULL::integer,
    p_departamento integer DEFAULT NULL::integer,
    p_fecha_inicio timestamp without time zone DEFAULT NULL::timestamp without time zone,
    p_fecha_fin timestamp without time zone DEFAULT NULL::timestamp without time zone,
    p_ticket character varying DEFAULT NULL::character varying)
    RETURNS TABLE(
        id_atencion bigint,  -- Cambiado a BIGINT
        ticket character varying, 
        asunto character varying,  -- Añadir el campo "asunto"
        usuario_reporto character varying, 
        usuario_grupo_asignado character varying, 
        fecha_inicio timestamp without time zone, 
        estatus_descripcion character varying, 
        id_sucursal integer, 
        descripcion_sucursal character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
AS $BODY$
BEGIN
    RETURN QUERY
    SELECT
        a.id_atencion,  -- Cambiado a BIGINT
        a.ticket,
        a.asunto,  -- Añadir el campo "asunto"
        ur.nombre AS usuario_reporto,
        gur.nombre AS usuario_grupo_asignado,
        a.fecha_inicio,
        e.descripcion AS estatus_descripcion,
        a.id_sucursal,  -- ID de la sucursal
        s.descripcion AS descripcion_sucursal  -- Descripción de la sucursal
    FROM
        public.tb_sica_atenciones a
        JOIN public.tb_catalogo_usuarios ur ON a.usuario_reporta = ur.id_usuario
        JOIN public.tb_sica_grupo_usuarios_responsables gur ON a.id_grupo_usuario_responsable = gur.id_grupo_usuario_responsable
        LEFT JOIN public.tb_catalogo_sucursales s ON a.id_sucursal = s.id_sucursal  -- JOIN con la tabla de sucursales
        JOIN public.tb_sica_catalogo_estatus e ON a.id_estatus = e.id_estatus
    WHERE
        a.usuario_reporta = p_id_usuario  -- Asegura que el usuario sea el que reportó la atención
        AND (p_estado IS NULL OR a.id_estatus = p_estado)
        AND (p_sucursal IS NULL OR a.id_sucursal = p_sucursal)
        AND (p_departamento IS NULL OR a.id_departamento_actual = p_departamento)
        AND (p_fecha_inicio IS NULL OR a.fecha_inicio >= p_fecha_inicio)
        AND (p_fecha_fin IS NULL OR a.fecha_inicio < p_fecha_fin + interval '1 day')
        AND (p_ticket IS NULL OR a.ticket ILIKE '%' || p_ticket || '%');
END;
$BODY$;

ALTER FUNCTION public.fn_sica_atenciones_filtrar_por_usuario_reporta(integer, integer, integer, integer, timestamp without time zone, timestamp without time zone, character varying)
    OWNER TO postgres;




-- DROP FUNCTION para fn_sica_atenciones_filtrar_por_grupo_usuario
DROP FUNCTION IF EXISTS public.fn_sica_atenciones_filtrar_por_grupo_usuario(integer, integer, integer, integer, timestamp without time zone, timestamp without time zone, character varying);

CREATE OR REPLACE FUNCTION public.fn_sica_atenciones_filtrar_por_grupo_usuario(
    p_id_usuario integer,
    p_estado integer DEFAULT NULL::integer,
    p_sucursal integer DEFAULT NULL::integer,
    p_departamento integer DEFAULT NULL::integer,
    p_fecha_inicio timestamp without time zone DEFAULT NULL::timestamp without time zone,
    p_fecha_fin timestamp without time zone DEFAULT NULL::timestamp without time zone,
    p_ticket character varying DEFAULT NULL::character varying)
    RETURNS TABLE(
        id_atencion bigint,  -- Cambiado a BIGINT
        ticket character varying, 
        asunto character varying,  -- Añadir el campo "asunto"
        usuario_reporto character varying, 
        usuario_grupo_asignado character varying, 
        fecha_inicio timestamp without time zone, 
        estatus_descripcion character varying, 
        id_sucursal integer, 
        descripcion_sucursal character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
AS $BODY$
BEGIN
    RETURN QUERY
    SELECT
        a.id_atencion,  -- Cambiado a BIGINT
        a.ticket,
        a.asunto,  -- Añadir el campo "asunto"
        ur.nombre AS usuario_reporto,
        gur.nombre AS usuario_grupo_asignado,
        a.fecha_inicio,
        e.descripcion AS estatus_descripcion,
        a.id_sucursal,  -- ID de la sucursal
        s.descripcion AS descripcion_sucursal  -- Descripción de la sucursal
    FROM
        public.tb_sica_atenciones a
        JOIN public.tb_catalogo_usuarios ur ON a.usuario_reporta = ur.id_usuario
        JOIN public.tb_sica_grupo_usuarios_responsables gur ON a.id_grupo_usuario_responsable = gur.id_grupo_usuario_responsable
        JOIN public.tb_sica_relacion_usuarios_grupo_responsables ugr ON a.id_grupo_usuario_responsable = ugr.id_grupo_usuario_responsable
        JOIN public.tb_catalogo_usuarios u ON ugr.id_usuario = u.id_usuario
        JOIN public.tb_sica_catalogo_estatus e ON a.id_estatus = e.id_estatus
        LEFT JOIN public.tb_catalogo_sucursales s ON a.id_sucursal = s.id_sucursal  -- JOIN con la tabla de sucursales
    WHERE
        ugr.id_usuario = p_id_usuario  -- Asegura que el usuario esté en el grupo responsable de la atención
        AND (p_estado IS NULL OR a.id_estatus = p_estado)
        AND (p_sucursal IS NULL OR a.id_sucursal = p_sucursal)
        AND (p_departamento IS NULL OR a.id_departamento_actual = p_departamento)
        AND (p_fecha_inicio IS NULL OR a.fecha_inicio >= p_fecha_inicio)
        AND (p_fecha_fin IS NULL OR a.fecha_inicio < p_fecha_fin + interval '1 day')
        AND (p_ticket IS NULL OR a.ticket ILIKE '%' || p_ticket || '%');
END;
$BODY$;

ALTER FUNCTION public.fn_sica_atenciones_filtrar_por_grupo_usuario(integer, integer, integer, integer, timestamp without time zone, timestamp without time zone, character varying)
    OWNER TO postgres;

 DROP FUNCTION IF EXISTS public.fn_sica_atenciones_contar_con_alerta_por_usuario(integer);

CREATE OR REPLACE FUNCTION public.fn_sica_atenciones_contar_con_alerta_por_usuario(
	p_id_usuario integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    alerta_count integer;
BEGIN
    SELECT COUNT(*)
    INTO alerta_count
    FROM 
        public.tb_sica_atenciones a
        JOIN public.tb_sica_relacion_usuarios_grupo_responsables ugr ON a.id_grupo_usuario_responsable = ugr.id_grupo_usuario_responsable
        JOIN public.tb_catalogo_usuarios u ON ugr.id_usuario = u.id_usuario
    WHERE
        u.id_usuario = p_id_usuario
        AND a.enviar_alerta = TRUE  -- Filtro para obtener solo las atenciones con alerta activa
        AND a.id_estatus IN (1, 2, 3);  -- Filtrar por los estados específicos

    RETURN alerta_count;
END;
$BODY$;

ALTER FUNCTION public.fn_sica_atenciones_contar_con_alerta_por_usuario(integer)
    OWNER TO postgres;


DROP  FUNCTION IF EXISTS public.fn_sica_catalogo_estatus_insertar(character varying, character varying);
CREATE OR REPLACE FUNCTION public.fn_sica_catalogo_estatus_insertar(
    p_descripcion character varying,
    p_clave character varying
)
RETURNS void AS
$$
DECLARE
    v_id_estatus integer;
    v_json jsonb;
BEGIN
    -- 1. Inserta el nuevo registro en la tabla tb_sica_catalogo_estatus
    INSERT INTO public.tb_sica_catalogo_estatus(
        descripcion,
        clave,
        fecha_creacion,
        fecha_modificacion
    )
    VALUES (
        p_descripcion,
        p_clave,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    )
    RETURNING id_estatus INTO v_id_estatus;
    
    -- 2. Convierte el registro recién insertado en formato JSONB
    SELECT row_to_json(t) INTO v_json
    FROM tb_sica_catalogo_estatus t
    WHERE t.id_estatus = v_id_estatus;
    
    -- 3. Llama a la función de consolidación pasando el registro en formato JSONB
    PERFORM fn_consolidador_registrarmovimiento(
        v_json,                   -- El registro en formato JSONB
        'i',                      -- Tipo de movimiento (i = Insertar)
        'tb_sica_catalogo_estatus',-- Nombre de la tabla
        0                         -- ID de la sucursal (o el valor adecuado)
    );
    
    -- Fin de la función
END;
$$
LANGUAGE plpgsql;

-- Asigna el propietario de la función
ALTER FUNCTION public.fn_sica_catalogo_estatus_insertar(
    character varying,
    character varying
)
OWNER TO postgres;

DROP FUNCTION IF EXISTS public.fn_sica_catalogo_grupos_usuarios_insertar(character varying, boolean);
CREATE OR REPLACE FUNCTION public.fn_sica_catalogo_grupos_usuarios_insertar(
    p_descripcion character varying,
    p_baja boolean
)
RETURNS void AS
$$
DECLARE
    v_id_grupo_usuario integer;
    v_json jsonb;
BEGIN
    -- 1. Inserta el nuevo registro en la tabla tb_sica_catalogo_grupos_usuarios
    INSERT INTO public.tb_sica_catalogo_grupos_usuarios(
        descripcion,
        fecha_creacion,
        fecha_modificacion,
        baja
    )
    VALUES (
        p_descripcion,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        p_baja
    )
    RETURNING id_grupo_usuario INTO v_id_grupo_usuario;
    
    -- 2. Convierte el registro recién insertado en formato JSONB
    SELECT row_to_json(t) INTO v_json
    FROM tb_sica_catalogo_grupos_usuarios t
    WHERE t.id_grupo_usuario = v_id_grupo_usuario;
    
    -- 3. Llama a la función de consolidación pasando el registro en formato JSONB
    PERFORM fn_consolidador_registrarmovimiento(
        v_json,                   -- El registro en formato JSONB
        'i',                      -- Tipo de movimiento (i = Insertar)
        'tb_sica_catalogo_grupos_usuarios', -- Nombre de la tabla
        0                         -- ID de la sucursal (puede ajustarse según tu lógica)
    );
    
    -- Fin de la función
END;
$$
LANGUAGE plpgsql;

-- Asigna el propietario de la función
ALTER FUNCTION public.fn_sica_catalogo_grupos_usuarios_insertar(
    character varying,
    boolean
)
OWNER TO postgres;


----- views ---------->

DROP VIEW IF EXISTS public.sica_vw_atencion_detalles;

CREATE OR REPLACE VIEW public.sica_vw_atencion_detalles AS
SELECT 
    a.id_atencion,
    a.ticket,
    a.asunto,
    a.descripcion,
    a.id_sucursal,
    s.descripcion AS sucursal,
    a.fecha_inicio,
    ur.nombre AS usuario_reporta,
    e.descripcion AS estatus_descripcion,
    act.descripcion AS actividad_descripcion,
    act.tiempo AS actividad_tiempo,
    gr.nombre AS grupo_responsable_nombre,
    a.id_grupo_usuario_responsable,
    -- Calcular el tiempo transcurrido solo si la atención está en ejecución (estatus = 3)
    CASE 
        WHEN a.id_estatus = 3 THEN NOW() - a.fecha_inicio_ejecucion
        ELSE NULL
    END AS tiempo_transcurrido -- Nuevo campo calculado para el tiempo transcurrido en ejecución
FROM 
    tb_sica_atenciones a
    JOIN tb_catalogo_sucursales s ON a.id_sucursal = s.id_sucursal
    JOIN tb_catalogo_usuarios ur ON a.usuario_reporta = ur.id_usuario
    JOIN tb_sica_catalogo_estatus e ON a.id_estatus = e.id_estatus
    JOIN tb_sica_catalogo_actividades act ON a.id_actividad = act.id_actividad
    JOIN tb_sica_grupo_usuarios_responsables gr ON a.id_grupo_usuario_responsable = gr.id_grupo_usuario_responsable;

ALTER TABLE public.sica_vw_atencion_detalles
    OWNER TO postgres;

DROP VIEW IF EXISTS public.sica_vw_atenciones_usuario;

CREATE OR REPLACE VIEW public.sica_vw_atenciones_usuario
(id_atencion, ticket, asunto, descripcion, id_sucursal, usuario_reporta, fecha_inicio, fecha_cierre,
 usuario_cierre, fecha_modificacion, fecha_cancelacion, usuario_cancelo, id_estatus, enviar_alerta,
 id_actividad, id_grupo_usuario_responsable, id_departamento_actual, id_departamento_anterior, id_usuario)
AS
SELECT a.id_atencion,  -- Cambiado a BIGINT
       a.ticket,
       a.asunto,
       a.descripcion,
       a.id_sucursal,
       a.usuario_reporta,
       a.fecha_inicio,
       a.fecha_cierre,
       a.usuario_cierre,
       a.fecha_modificacion,
       a.fecha_cancelacion,
       a.usuario_cancelo,
       a.id_estatus,
       a.enviar_alerta,
       a.id_actividad,
       a.id_grupo_usuario_responsable,
       a.id_departamento_actual,
       a.id_departamento_anterior,
       u.id_usuario
FROM public.tb_sica_atenciones a
JOIN public.tb_sica_relacion_usuarios_grupo_responsables ugr ON a.id_grupo_usuario_responsable = ugr.id_grupo_usuario_responsable
JOIN public.tb_catalogo_usuarios u ON ugr.id_usuario = u.id_usuario;

ALTER TABLE public.sica_vw_atenciones_usuario OWNER TO postgres;


DROP VIEW IF EXISTS public.sica_vw_atenciones_usuario_detalladas;

CREATE OR REPLACE VIEW public.sica_vw_atenciones_usuario_detalladas
(ticket, asunto, descripcion, fecha_inicio, id_sucursal, sucursal_descripcion, grupo_responsable_nombre, id_usuario)
AS
SELECT a.ticket,
       a.asunto,
       a.descripcion,
       a.fecha_inicio,
       a.id_sucursal,  -- Referencia del ID de la sucursal
       s.descripcion AS sucursal_descripcion,
       gur.nombre    AS grupo_responsable_nombre,
       u.id_usuario
FROM public.tb_sica_atenciones a
JOIN public.tb_catalogo_sucursales s ON a.id_sucursal = s.id_sucursal
JOIN public.tb_sica_grupo_usuarios_responsables gur ON a.id_grupo_usuario_responsable = gur.id_grupo_usuario_responsable
JOIN public.tb_sica_relacion_usuarios_grupo_responsables ugr ON a.id_grupo_usuario_responsable = ugr.id_grupo_usuario_responsable
JOIN public.tb_catalogo_usuarios u ON ugr.id_usuario = u.id_usuario;

ALTER TABLE public.sica_vw_atenciones_usuario_detalladas OWNER TO postgres;


-- 12/09/2024

-- FUNCTION: public.fn_sica_atenciones_contar_con_alerta_por_usuario(integer)








