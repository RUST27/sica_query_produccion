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
CREATE SEQUENCE tb_sica_catalogo_gerencias_id_gerencia_seq;
create table if not exists public.tb_sica_catalogo_gerencias
(
    id_gerencia        integer NOT NULL DEFAULT nextval('tb_sica_catalogo_gerencias_id_gerencia_seq'),
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
CREATE SEQUENCE tb_sica_catalogo_grupos_usuarios_id_grupo_usuario_seq;
create table if not exists public.tb_sica_catalogo_grupos_usuarios
(
    id_grupo_usuario   integer NOT NULL DEFAULT nextval('tb_sica_catalogo_grupos_usuarios_id_grupo_usuario_seq'),
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
CREATE SEQUENCE tb_sica_catalogo_departamentos_id_departamento_seq;
create table if not exists public.tb_sica_catalogo_departamentos
(
    id_departamento    integer NOT NULL DEFAULT nextval('tb_sica_catalogo_departamentos_id_departamento_seq'),
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
CREATE SEQUENCE tb_sica_grupo_usuarios_responsables_id_grupo_usuario_responsable_seq;
create table if not exists public.tb_sica_grupo_usuarios_responsables
(
    id_grupo_usuario_responsable integer NOT NULL DEFAULT nextval('tb_sica_grupo_usuarios_responsables_id_grupo_usuario_responsable_seq'),
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
CREATE SEQUENCE tb_sica_catalogo_clasificacion_actividades_id_clasificacion_actividad_seq;
create table if not exists public.tb_sica_catalogo_clasificacion_actividades
(
    id_clasificacion_actividad integer NOT NULL DEFAULT nextval('tb_sica_catalogo_clasificacion_actividades_id_clasificacion_actividad_seq'),
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
CREATE SEQUENCE tb_sica_catalogo_grupo_actividades_id_grupo_actividad_seq;
create table if not exists public.tb_sica_catalogo_grupo_actividades
(
    id_grupo_actividad         integer NOT NULL DEFAULT nextval('tb_sica_catalogo_grupo_actividades_id_grupo_actividad_seq'),
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
CREATE SEQUENCE tb_sica_catalogo_actividades_id_actividad_seq;
create table if not exists public.tb_sica_catalogo_actividades
(
    id_actividad                 integer NOT NULL DEFAULT nextval('tb_sica_catalogo_actividades_id_actividad_seq'),
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
CREATE SEQUENCE tb_sica_catalogo_estatus_id_estatus_seq;
create table if not exists public.tb_sica_catalogo_estatus
(
    id_estatus         integer NOT NULL DEFAULT nextval('tb_sica_catalogo_estatus_id_estatus_seq'),
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
CREATE SEQUENCE tb_sica_catalogo_usuarios_sica_id_usuario_sica_seq;
create table if not exists public.tb_sica_catalogo_usuarios_sica
(
    id_usuario_sica    integer NOT NULL DEFAULT nextval('tb_sica_catalogo_usuarios_sica_id_usuario_sica_seq'),
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
CREATE SEQUENCE tb_sica_atenciones_id_atencion_seq;
CREATE TABLE IF NOT EXISTS public.tb_sica_atenciones
(
    id_atencion                  bigint NOT NULL DEFAULT nextval('tb_sica_atenciones_id_atencion_seq'),
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
CREATE SEQUENCE tb_sica_mensajes_id_mensaje_seq;
CREATE TABLE IF NOT EXISTS public.tb_sica_mensajes
(
    id_mensaje          bigint NOT NULL DEFAULT nextval('tb_sica_mensajes_id_mensaje_seq'),
    id_atencion         bigint not null, -- Cambiado a BIGINT
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
CREATE SEQUENCE tb_sica_transferencias_atenciones_id_transferencia_seq;
CREATE TABLE IF NOT EXISTS public.tb_sica_transferencias_atenciones
(
    id_transferencia        bigint NOT NULL DEFAULT nextval('tb_sica_transferencias_atenciones_id_transferencia_seq'), -- Cambiado a BIGINT
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
CREATE SEQUENCE tb_sica_seguimiento_id_seguimiento_seq;
CREATE TABLE IF NOT EXISTS public.tb_sica_seguimiento
(
    id_seguimiento integer NOT NULL DEFAULT nextval('tb_sica_seguimiento_id_seguimiento_seq'),
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





{
  "asunto": "prueba de insercion sica",
  "ticket": "24093001388111",
  "id_estatus": 2,
  "descripcion": "prueba de insercion sica",
  "id_atencion": 1,
  "id_sucursal": 17,
  "fecha_cierre": null,
  "fecha_inicio": "2024-09-30T13:38:54.663583",
  "id_actividad": 19,
  "enviar_alerta": false,
  "fecha_creacion": "2024-09-30T13:38:54.663583",
  "usuario_cierre": null,
  "usuario_cancelo": null,
  "usuario_reporta": 3238,
  "fecha_cancelacion": null,
  "fecha_modificacion": "2024-09-30T13:43:54.719029",
  "fecha_inicio_ejecucion": "2024-09-30T13:38:54.663583",
  "id_departamento_actual": 3,
  "id_departamento_anterior": null,
  "id_grupo_usuario_responsable": 3
}