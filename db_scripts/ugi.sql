create table estatus
(
    estatus     varchar(1)   not null
        primary key,
    descripcion varchar(255) not null
);

alter table estatus
    owner to postgres;

create table movimientos
(
    id_movimiento serial
        primary key,
    movimiento    varchar(25) not null
);

alter table movimientos
    owner to postgres;

create table transacciones
(
    id_transaccion     bigserial
        primary key,
    fecha              timestamp    not null,
    estatus            varchar(1)   not null
        constraint fktransaccio255640
            references estatus,
    id_movimiento      integer      not null
        constraint fktransaccio180655
            references movimientos,
    id_sucursal        integer      not null,
    id_caja            integer      not null,
    ticket             varchar(25)  not null,
    contrato           varchar(25),
    cliente            varchar(255),
    importe            numeric(18, 6),
    numero_transaccion varchar(20),
    fecha_solictud     timestamp,
    solicitud          text,
    fecha_respuesta    timestamp,
    respuesta          text,
    confirmado_pos     boolean,
    fecha_confirmado   timestamp,
    operador           varchar(150) not null,
    cierre             integer      not null,
    corte              integer      not null
);

alter table transacciones
    owner to postgres;

create index index_transacciones
    on transacciones (id_transaccion, id_sucursal, corte, id_movimiento, fecha);

