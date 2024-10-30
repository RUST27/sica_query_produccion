
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


-- Índices para la tabla tb_sica_catalogo_gerencias
CREATE INDEX idx_tb_sica_catalogo_gerencias_id ON public.tb_sica_catalogo_gerencias (id_gerencia);

-- Índices para la tabla tb_sica_catalogo_grupos_usuarios
CREATE INDEX idx_tb_sica_catalogo_grupos_usuarios_id ON public.tb_sica_catalogo_grupos_usuarios (id_grupo_usuario);

-- Índices para la tabla tb_sica_catalogo_departamentos
CREATE INDEX idx_tb_sica_catalogo_departamentos_id ON public.tb_sica_catalogo_departamentos (id_departamento);
CREATE INDEX idx_tb_sica_catalogo_departamentos_id_gerencia ON public.tb_sica_catalogo_departamentos (id_gerencia);

-- Índices para la tabla tb_sica_grupo_usuarios_responsables
CREATE INDEX idx_tb_sica_grupo_usuarios_responsables_id ON public.tb_sica_grupo_usuarios_responsables (id_grupo_usuario_responsable);
CREATE INDEX idx_tb_sica_grupo_usuarios_responsables_id_departamento ON public.tb_sica_grupo_usuarios_responsables (id_departamento);

-- Índices para la tabla tb_sica_catalogo_clasificacion_actividades
CREATE INDEX idx_tb_sica_catalogo_clasificacion_actividades_id ON public.tb_sica_catalogo_clasificacion_actividades (id_clasificacion_actividad);
CREATE INDEX idx_tb_sica_catalogo_clasificacion_actividades_id_departamento ON public.tb_sica_catalogo_clasificacion_actividades (id_departamento);

-- Índices para la tabla tb_sica_catalogo_grupo_actividades
CREATE INDEX idx_tb_sica_catalogo_grupo_actividades_id ON public.tb_sica_catalogo_grupo_actividades (id_grupo_actividad);
CREATE INDEX idx_tb_sica_catalogo_grupo_actividades_id_clasificacion_actividad ON public.tb_sica_catalogo_grupo_actividades (id_clasificacion_actividad);

-- Índices para la tabla tb_sica_catalogo_actividades
CREATE INDEX idx_tb_sica_catalogo_actividades_id ON public.tb_sica_catalogo_actividades (id_actividad);
CREATE INDEX idx_tb_sica_catalogo_actividades_id_grupo_actividad ON public.tb_sica_catalogo_actividades (id_grupo_actividad);

-- Índices para la tabla tb_sica_atenciones
CREATE INDEX idx_tb_sica_atenciones_id_sucursal_id_atencion ON public.tb_sica_atenciones (id_sucursal, id_atencion); 
CREATE INDEX idx_tb_sica_atenciones_id_atencion ON public.tb_sica_atenciones (id_atencion);
CREATE INDEX idx_tb_sica_atenciones_id_departamento_actual ON public.tb_sica_atenciones (id_departamento_actual);


-- Índices para la tabla tb_sica_mensajes
CREATE INDEX idx_tb_sica_mensajes_id ON public.tb_sica_mensajes (id_mensaje);
CREATE INDEX idx_tb_sica_mensajes_id_atencion_id_sucursal ON public.tb_sica_mensajes (id_atencion, id_sucursal); 


-- Índices para la tabla tb_sica_transferencias_atenciones
CREATE INDEX idx_tb_sica_transferencias_atenciones_id ON public.tb_sica_transferencias_atenciones (id_transferencia);
CREATE INDEX idx_tb_sica_transferencias_atenciones_id_atencion_id_sucursal ON public.tb_sica_transferencias_atenciones (id_atencion, id_sucursal); 


-- Índices para la tabla tb_sica_catalogo_usuarios_sica
CREATE INDEX idx_tb_sica_catalogo_usuarios_sica_id ON public.tb_sica_catalogo_usuarios_sica (id_usuario_sica);
CREATE INDEX idx_tb_sica_catalogo_usuarios_sica_id_grupo_usuario ON public.tb_sica_catalogo_usuarios_sica (id_grupo_usuario);
CREATE INDEX idx_tb_sica_catalogo_usuarios_sica_id_departamento ON public.tb_sica_catalogo_usuarios_sica (id_departamento);
CREATE INDEX idx_tb_sica_catalogo_usuarios_sica_id_gerencia ON public.tb_sica_catalogo_usuarios_sica (id_gerencia);
