create table public.transacciones
(
    id_transaccion     bigserial
        primary key,
    fecha              timestamp    not null,
    estatus            varchar(1)   not null,
    id_movimiento      integer      not null,
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

alter table public.transacciones
    owner to postgres;

create index index_transacciones
    on public.transacciones (id_transaccion, id_sucursal, corte, id_movimiento, fecha);

create index index_transacciones_ugm
    on public.transacciones (id_transaccion, id_sucursal, corte, fecha);

create table public.transacciones2
(
    id_transaccion     bigserial
        primary key,
    fecha              timestamp    not null,
    estatus            varchar(1)   not null,
    id_movimiento      integer      not null,
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

alter table public.transacciones2
    owner to postgres;

create index index_transacciones2
    on public.transacciones2 (id_transaccion, id_sucursal, corte, id_movimiento, fecha);

create table public.transacciones_ugm
(
    id_transaccion    bigserial
        primary key,
    fecha             timestamp    not null,
    estatus           varchar(1)   not null,
    id_sucursal       integer      not null,
    id_caja           integer      not null,
    ticket            varchar(25)  not null,
    referencia        varchar(100),
    importe           numeric(18, 6),
    fecha_solictud    timestamp,
    solicitud         text,
    fecha_respuesta   timestamp,
    respuesta         text,
    confirmado_pos    boolean,
    fecha_confirmado  timestamp,
    operador          varchar(150) not null,
    cierre            integer      not null,
    corte             integer      not null,
    pago_reverso      boolean default false,
    respuesta_reverso text,
    fecha_reverso     timestamp,
    codigo_reverso    text
);

alter table public.transacciones_ugm
    owner to postgres;

create table public.estatus
(
    estatus     varchar(1)   not null
        primary key,
    descripcion varchar(255) not null
);

alter table public.estatus
    owner to postgres;

create table public.movimientos
(
    id_movimiento serial
        primary key,
    movimiento    varchar(25) not null
);

alter table public.movimientos
    owner to postgres;

create table public.transacciones_ugmex
(
    id_transaccion   bigserial
        primary key,
    fecha            timestamp    not null,
    estatus          varchar(1)   not null
        constraint fktransaccio255640
            references public.estatus,
    id_movimiento    integer      not null
        constraint fktransaccio180655
            references public.movimientos,
    id_sucursal      integer      not null,
    id_caja          integer      not null,
    ticket           varchar(25)  not null,
    importe          numeric(18, 4),
    referencia       varchar(50),
    fecha_solicitud  timestamp,
    solicitud        text,
    fecha_respuesta  timestamp,
    respuesta        text,
    confirmado_pos   boolean,
    fecha_confirmado timestamp,
    operador         varchar(150) not null,
    cierre           integer      not null,
    corte            integer      not null
);

alter table public.transacciones_ugmex
    owner to postgres;

create index index_transacciones_ugmex
    on public.transacciones_ugmex (id_transaccion, id_sucursal, corte, id_movimiento, fecha);






create function public.fn_insertar_transaccion2(p_fecha timestamp without time zone, p_estatus character varying, p_id_movimiento integer, p_id_sucursal integer, p_id_caja integer, p_ticket character varying, p_contrato character varying, p_cliente character varying, p_importe numeric, p_numero_transaccion character varying, p_fecha_solicitud timestamp without time zone, p_solicitud text, p_fecha_respuesta timestamp without time zone, p_respuesta text, p_confirmado_pos boolean, p_fecha_confirmado timestamp without time zone, p_operador character varying, p_cierre integer, p_corte integer) returns bigint
    language plpgsql
as
$$
DECLARE
    v_id_transaccion BIGINT;
BEGIN
    INSERT INTO transacciones2 (
        fecha, estatus, id_movimiento, id_sucursal, id_caja, ticket, contrato, cliente, importe, numero_transaccion, 
        fecha_solictud, solicitud, fecha_respuesta, respuesta, confirmado_pos, fecha_confirmado, operador, cierre, corte
    ) VALUES (
        p_fecha, p_estatus, p_id_movimiento, p_id_sucursal, p_id_caja, p_ticket, p_contrato, p_cliente, p_importe, p_numero_transaccion,
        p_fecha_solicitud, p_solicitud, p_fecha_respuesta, p_respuesta, p_confirmado_pos, p_fecha_confirmado, p_operador, p_cierre, p_corte
    )
    RETURNING id_transaccion INTO v_id_transaccion;

    RETURN v_id_transaccion;
END;
$$;

alter function public.fn_insertar_transaccion2(timestamp, varchar, integer, integer, integer, varchar, varchar, varchar, numeric, varchar, timestamp, text, timestamp, text, boolean, timestamp, varchar, integer, integer) owner to postgres;

create function public.fn_transaccion_ugmex_insertar(p_fecha timestamp without time zone, p_estatus character varying, p_id_movimiento integer, p_id_sucursal integer, p_id_caja integer, p_ticket character varying, p_importe numeric, p_referencia character varying, p_fecha_solicitud timestamp without time zone, p_solicitud text, p_fecha_respuesta timestamp without time zone, p_respuesta text, p_confirmado_pos boolean, p_fecha_confirmado timestamp without time zone, p_operador character varying, p_cierre integer, p_corte integer) returns bigint
    language plpgsql
as
$$
DECLARE
    v_id_transaccion BIGINT;
BEGIN
    INSERT INTO public.transacciones_ugmex (fecha, estatus, id_movimiento, id_sucursal, id_caja, ticket, importe, referencia, fecha_solicitud, solicitud, fecha_respuesta, respuesta, confirmado_pos, fecha_confirmado, operador, cierre, corte)
    VALUES (p_fecha, p_estatus, p_id_movimiento, p_id_sucursal, p_id_caja, p_ticket, p_importe, p_referencia, p_fecha_solicitud, p_solicitud, p_fecha_respuesta, p_respuesta, p_confirmado_pos, p_fecha_confirmado, p_operador, p_cierre, p_corte)
    RETURNING id_transaccion INTO v_id_transaccion;
    RETURN v_id_transaccion;
END;
$$;

alter function public.fn_transaccion_ugmex_insertar(timestamp, varchar, integer, integer, integer, varchar, numeric, varchar, timestamp, text, timestamp, text, boolean, timestamp, varchar, integer, integer) owner to postgres;

create function public.fn_confirmar_pos_id(p_idtransaccion bigint) returns void
    language plpgsql
as
$$
BEGIN
    -- Actualizar el registro en la tabla transacciones_ugm
    UPDATE transacciones_ugmex
    SET
        confirmado_pos = TRUE,
        fecha_confirmado = NOW()
    WHERE
        id_transaccion = p_IdTransaccion;
    -- Verificar si se actualizó algún registro
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró una transacción con el id transaccion %', p_idTransaccion;
    END IF;
END;
$$;

alter function public.fn_confirmar_pos_id(bigint) owner to postgres;

create function public.fn_insertar_transaccion_ugmex(p_fecha timestamp with time zone, p_estatus character varying, p_id_movimiento integer, p_id_sucursal integer, p_id_caja integer, p_ticket character varying, p_importe numeric, p_referencia character varying, p_fecha_solicitud timestamp without time zone, p_solicitud text, p_fecha_respuesta timestamp without time zone, p_respuesta text, p_confirmado_pos boolean, p_fecha_confirmado timestamp without time zone, p_operador character varying, p_cierre integer, p_corte integer) returns bigint
    language plpgsql
as
$$
DECLARE
    v_id_transaccion BIGINT;
BEGIN
    INSERT INTO transacciones_ugmex (
        fecha,
        estatus,
        id_movimiento,
        id_sucursal,
        id_caja,
        ticket,
        importe,
        referencia,
        fecha_solicitud,
        solicitud,
        fecha_respuesta,
        respuesta,
        confirmado_pos,
        fecha_confirmado,
        operador,
        cierre,
        corte
    )
    VALUES (
        p_fecha,
        p_estatus,
        p_id_movimiento,
        p_id_sucursal,
        p_id_caja,
        p_ticket,
        p_importe,
        p_referencia,
        p_fecha_solicitud,
        p_solicitud,
        p_fecha_respuesta,
        p_respuesta,
        p_confirmado_pos,
        p_fecha_confirmado,
        p_operador,
        p_cierre,
        p_corte
    )
    RETURNING id_transaccion INTO v_id_transaccion;

    RETURN v_id_transaccion;
END;
$$;

alter function public.fn_insertar_transaccion_ugmex(timestamp with time zone, varchar, integer, integer, integer, varchar, numeric, varchar, timestamp, text, timestamp, text, boolean, timestamp, varchar, integer, integer) owner to postgres;

create function public.fn_insertar_transaccion_ugm(p_fecha timestamp with time zone, p_estatus character varying, p_id_movimiento integer, p_id_sucursal integer, p_id_caja integer, p_ticket text, p_referencia text, p_importe numeric, p_solicitud text, p_fecha_respuesta timestamp with time zone, p_respuesta text, p_confirmado_pos boolean, p_fecha_confirmado timestamp with time zone, p_operador text, p_cierre integer, p_corte integer) returns bigint
    language plpgsql
as
$$
DECLARE
    v_id_transaccion BIGINT;
BEGIN
    INSERT INTO transacciones_ugmex (
        fecha,
        estatus,
        id_movimiento,
        id_sucursal,
        id_caja,
        ticket,
        referencia,
        importe,
        solicitud,
        fecha_respuesta,
        respuesta,
        confirmado_pos,
        fecha_confirmado,
        operador,
        cierre,
        corte
    )
    VALUES (
        p_fecha,
        p_estatus,
        p_id_movimiento,
        p_id_sucursal,
        p_id_caja,
        p_ticket,
        p_referencia,
        p_importe,
        p_solicitud,
        p_fecha_respuesta,
        p_respuesta,
        p_confirmado_pos,
        p_fecha_confirmado,
        p_operador,
        p_cierre,
        p_corte
    )
    RETURNING id_transaccion INTO v_id_transaccion;

    RETURN v_id_transaccion;
END;
$$;

alter function public.fn_insertar_transaccion_ugm(timestamp with time zone, varchar, integer, integer, integer, text, text, numeric, text, timestamp with time zone, text, boolean, timestamp with time zone, text, integer, integer) owner to postgres;

create function public.fn_insertar_transaccion_ugmex1(_fecha timestamp without time zone, _estatus character varying, _id_movimiento integer, _id_sucursal integer, _id_caja integer, _ticket character varying, _importe numeric, _referencia character varying, _fecha_solicitud timestamp without time zone, _solicitud text, _fecha_respuesta timestamp without time zone, _respuesta text, _confirmado_pos boolean, _fecha_confirmado timestamp without time zone, _operador character varying, _cierre integer, _corte integer) returns bigint
    language plpgsql
as
$$
DECLARE
    _id_transaccion BIGINT;
BEGIN
    INSERT INTO transacciones_ugmex (
        fecha,
        estatus,
        id_movimiento,
        id_sucursal,
        id_caja,
        ticket,
        importe,
        referencia,
        fecha_solicitud,
        solicitud,
        fecha_respuesta,
        respuesta,
        confirmado_pos,
        fecha_confirmado,
        operador,
        cierre,
        corte
    )
    VALUES (
        _fecha,
        _estatus,
        _id_movimiento,
        _id_sucursal,
        _id_caja,
        _ticket,
        _importe,
        _referencia,
        _fecha_solicitud,
        _solicitud,
        _fecha_respuesta,
        _respuesta,
        _confirmado_pos,
        _fecha_confirmado,
        _operador,
        _cierre,
        _corte
    )
    RETURNING id_transaccion INTO _id_transaccion;

    RETURN _id_transaccion;
END;
$$;

alter function public.fn_insertar_transaccion_ugmex1(timestamp, varchar, integer, integer, integer, varchar, numeric, varchar, timestamp, text, timestamp, text, boolean, timestamp, varchar, integer, integer) owner to postgres;

create function public.fn_insertar_transaccion_ugmex1(_fecha timestamp with time zone, _estatus text, _id_movimiento integer, _id_sucursal integer, _id_caja integer, _ticket text, _importe numeric, _referencia text, _fecha_solicitud timestamp with time zone, _solicitud text, _fecha_respuesta timestamp without time zone, _respuesta text, _confirmado_pos boolean, _fecha_confirmado timestamp without time zone, _operador text, _cierre integer, _corte integer) returns bigint
    language plpgsql
as
$$
DECLARE
    _id_transaccion BIGINT;
BEGIN
    INSERT INTO transacciones_ugmex (
        fecha,
        estatus,
        id_movimiento,
        id_sucursal,
        id_caja,
        ticket,
        importe,
        referencia,
        fecha_solicitud,
        solicitud,
        fecha_respuesta,
        respuesta,
        confirmado_pos,
        fecha_confirmado,
        operador,
        cierre,
        corte
    )
    VALUES (
        _fecha,
        _estatus,
        _id_movimiento,
        _id_sucursal,
        _id_caja,
        _ticket,
        _importe,
        _referencia,
        _fecha_solicitud,
        _solicitud,
        _fecha_respuesta,
        _respuesta,
        _confirmado_pos,
        _fecha_confirmado,
        _operador,
        _cierre,
        _corte
    )
    RETURNING id_transaccion INTO _id_transaccion;

    RETURN _id_transaccion;
END;
$$;

alter function public.fn_insertar_transaccion_ugmex1(timestamp with time zone, text, integer, integer, integer, text, numeric, text, timestamp with time zone, text, timestamp, text, boolean, timestamp, text, integer, integer) owner to postgres;

create function public.fn_confirmar_pos(p_id_transaccion integer) returns void
    language plpgsql
as
$$
BEGIN
    -- Actualizar el registro en la tabla transacciones_ugm
    UPDATE transacciones_ugmex
    SET
        confirmado_pos = TRUE,
        fecha_confirmado = NOW()
    WHERE
        id_transaccion = p_id_transaccion;

    -- Verificar si se actualizó algún registro
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró una transacción con el IdTransaccion %', p_id_transaccion;
    END IF;
END;
$$;

alter function public.fn_confirmar_pos(integer) owner to postgres;

