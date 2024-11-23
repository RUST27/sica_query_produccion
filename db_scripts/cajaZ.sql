create sequence caz_transacciones_id_transaccion_seq;

alter sequence caz_transacciones_id_transaccion_seq owner to postgres;

create table "__EFMigrationsHistory"
(
    "MigrationId"    varchar(150) not null
        constraint "PK___EFMigrationsHistory"
            primary key,
    "ProductVersion" varchar(32)  not null
);

alter table "__EFMigrationsHistory"
    owner to postgres;

create table caz_estatus
(
    id_estatus serial
        primary key,
    estatus    varchar(50) not null
);

alter table caz_estatus
    owner to postgres;

create table caz_movimientos
(
    id_movimiento     integer     not null
        primary key,
    movimiento        varchar(50) not null,
    reverso_operacion varchar(50)
);

alter table caz_movimientos
    owner to postgres;

create index idx_caz_movimientos_id_movimiento
    on caz_movimientos (id_movimiento);

create table caz_token
(
    id_token serial
        primary key,
    token    varchar(50) not null
);

alter table caz_token
    owner to postgres;

create table caz_transacciones
(
    id_transaccion    numeric(19) default nextval('caz_transacciones_id_transaccion_seq'::regclass) not null
        primary key,
    id_estatus        integer                                                                       not null,
    fecha             timestamp                                                                     not null,
    id_sucursal       integer                                                                       not null,
    id_terminal       integer                                                                       not null,
    cierre            numeric(19)                                                                   not null,
    corte             numeric(19)                                                                   not null,
    ticket            varchar(15)                                                                   not null,
    id_movimiento     integer                                                                       not null,
    cuenta            varchar(50)                                                                   not null,
    fecha_pos         date                                                                          not null,
    hora_pos          time                                                                          not null,
    monto             numeric(19, 2)                                                                not null,
    id_tipo_operacion integer,
    id_referencia     numeric(19),
    fecha_respuesta   timestamp,
    codigo_resultado  varchar(255),
    folio_operacion   varchar(25),
    cajero            varchar(150)                                                                  not null,
    baja              boolean                                                                       not null,
    comentarios       varchar(255)
);

alter table caz_transacciones
    owner to postgres;

