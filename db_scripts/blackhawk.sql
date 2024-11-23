create sequence echos_id_echo_seq
    as integer;

alter sequence echos_id_echo_seq owner to postgres;

create sequence login_id_login_seq
    as integer;

alter sequence login_id_login_seq owner to postgres;

create sequence tb_transacciones_blackhawk_ftp_id_seq;

alter sequence tb_transacciones_blackhawk_ftp_id_seq owner to postgres;

create table if not exists _total_de_transacciones
(
    count bigint
);

alter table _total_de_transacciones
    owner to postgres;

create table if not exists codigos_procesamiento
(
    id_codigo        serial
        primary key,
    tipo_transaccion varchar(35) not null,
    normal           varchar(10) not null,
    void             varchar(10) not null
);

alter table codigos_procesamiento
    owner to postgres;

create index if not exists index_codigos_procesamiento
    on codigos_procesamiento (id_codigo);

create table if not exists codigos_respuesta
(
    codigo_respuesta varchar(3)   not null
        primary key,
    tipo             varchar(30),
    descripcion      varchar(255) not null
);

alter table codigos_respuesta
    owner to postgres;

create index if not exists index_codigos_respuesta
    on codigos_respuesta (codigo_respuesta);

create table if not exists echos
(
    id_echo        bigint  default nextval('echos_id_echo_seq'::regclass) not null
        primary key,
    estatus        boolean default false                                  not null,
    fecha          timestamp                                              not null,
    solicitud_echo text,
    respuesta_echo text,
    statuscode     varchar(2)
);

alter table echos
    owner to postgres;

alter sequence echos_id_echo_seq owned by echos.id_echo;

create index if not exists index_echos
    on echos (id_echo, estatus, fecha);

create table if not exists folios_conciliacion
(
    id_folio integer   not null
        primary key,
    fecha    timestamp not null
        unique,
    folio    integer   not null,
    enviado  boolean
);

alter table folios_conciliacion
    owner to postgres;

create table if not exists login
(
    id_login        bigint default nextval('login_id_login_seq'::regclass) not null
        primary key,
    estatus         boolean                                                not null,
    fecha           timestamp                                              not null,
    solicitud_login text,
    respuesta_login text,
    statuscode      varchar(2),
    responsecode    varchar(2)
);

alter table login
    owner to postgres;

alter sequence login_id_login_seq owned by login.id_login;

create table if not exists movimientos
(
    id_movimiento serial
        primary key,
    valor         varchar(30),
    descripcion   varchar(255) not null
);

alter table movimientos
    owner to postgres;

create index if not exists index_movimientos
    on movimientos (id_movimiento);

create table if not exists tarjetaregalo_tipodemoneda
(
    id_tarjeta     serial
        primary key,
    codigodebarras varchar(255)  not null,
    monto          numeric(8, 2) not null,
    clave_moneda   varchar(4)    not null,
    codigo_moneda  varchar(4)    not null
);

alter table tarjetaregalo_tipodemoneda
    owner to postgres;

create index if not exists index_tarjetaregalo_tipodemoneda
    on tarjetaregalo_tipodemoneda (id_tarjeta, codigodebarras);

create table if not exists test_transacciones
(
    id_transaccion         bigint,
    fecha                  timestamp,
    fecha_pos              timestamp,
    estatus                varchar(20),
    id_tipo_transaccion    integer,
    id_movimiento          integer,
    id_sucursal            integer,
    id_caja                integer,
    ticket                 varchar(25),
    numero_de_sucursal     integer,
    id_articulo            integer,
    codigodebarras         varchar(255),
    referencia             varchar(100),
    importe                numeric(18, 6),
    cliente_celular        varchar(15),
    cliente_email          varchar(255),
    codigo_estatus         varchar(2),
    codigo_respuesta       varchar(3),
    autorizacion           varchar(10),
    guid                   varchar(26),
    cguid                  varchar(26),
    fecha_solicitud        timestamp,
    solicitud              text,
    fecha_respuesta        timestamp,
    respuesta              text,
    id_transaccion_reverso bigint,
    reverso_aprobado       boolean,
    confirmado_pos         boolean,
    fecha_confirmado       timestamp,
    operador               varchar(255),
    cierre                 integer,
    corte                  integer
);

alter table test_transacciones
    owner to postgres;

create table if not exists tipo_producto
(
    id_tipo     serial
        primary key,
    id_articulo integer    not null,
    tipo        varchar(2) not null
);

alter table tipo_producto
    owner to postgres;

create index if not exists index_tipo_producto
    on tipo_producto (id_tipo);

create table if not exists tipo_transacciones
(
    id_tipo_transaccion serial
        primary key,
    valor               varchar(50)  not null,
    descripcion         varchar(255) not null
);

alter table tipo_transacciones
    owner to postgres;

create index if not exists index_tipo_transacciones
    on tipo_transacciones (id_tipo_transaccion);

create table if not exists transacciones
(
    id_transaccion         bigserial
        primary key,
    fecha                  timestamp             not null,
    fecha_pos              timestamp             not null,
    estatus                varchar(20),
    id_tipo_transaccion    integer               not null
        constraint fktransaccio968323
            references tipo_transacciones,
    id_movimiento          integer,
    id_sucursal            integer               not null,
    id_caja                integer               not null,
    ticket                 varchar(25)           not null,
    numero_de_sucursal     integer               not null,
    id_articulo            integer               not null,
    codigodebarras         varchar(255)          not null,
    referencia             varchar(100),
    importe                numeric(18, 6),
    cliente_celular        varchar(15),
    cliente_email          varchar(255),
    codigo_estatus         varchar(2),
    codigo_respuesta       varchar(3),
    autorizacion           varchar(10),
    guid                   varchar(26),
    cguid                  varchar(26),
    fecha_solicitud        timestamp,
    solicitud              text,
    fecha_respuesta        timestamp,
    respuesta              text,
    id_transaccion_reverso bigint,
    reverso_aprobado       boolean default false not null,
    confirmado_pos         boolean,
    fecha_confirmado       timestamp,
    operador               varchar(255),
    cierre                 integer,
    corte                  integer,
    fecha_mst              timestamp
);

alter table transacciones
    owner to postgres;

create index if not exists index_transacciones
    on transacciones (id_transaccion, fecha, id_sucursal, referencia, codigo_respuesta, autorizacion, cierre, corte);

create table if not exists tb_transacciones_blackhawk_ftp
(
    id                                integer default nextval('tb_transacciones_blackhawk_ftp_id_seq'::regclass) not null
        constraint tb_transacciones_blackhawk_pkey
            primary key,
    ch                                char(2),
    company_name                      varchar(255),
    merchant_id                       varchar(100),
    merchant_name                     varchar(255),
    store_id                          varchar(100),
    terminal_id                       varchar(100),
    clerk_id                          varchar(100),
    acquired_transaction_date         date,
    acquired_transaction_time         time,
    gift_card_number                  varchar(100),
    product_id                        varchar(100),
    product_description               text,
    pos_transaction_date              date,
    pos_transaction_time              time,
    transaction_type                  varchar(50),
    system_trace_audit_number         integer,
    product_item_price                numeric(10, 2),
    currency_code                     char(3),
    merchant_transaction_id           varchar(255),
    bhn_transaction_id                varchar(255),
    auth_response_code                varchar(10),
    approval_code                     varchar(50),
    reversal_saf_code                 varchar(50),
    transaction_amount                numeric(10, 2),
    consumer_fee_amount               numeric(10, 2),
    commission_amount                 numeric(10, 2),
    total_tax_on_transaction_amount   numeric(10, 2),
    total_tax_on_commission_amount    numeric(10, 2),
    total_tax_on_fees_amount          numeric(10, 2),
    net_amount                        numeric(10, 2),
    order_id_sid                      varchar(255),
    reloadit_pack_number              varchar(255),
    transaction_guid                  varchar(26),
    transaction_cguid                 varchar(26),
    phone_number                      varchar(30),
    sales_tax                         numeric(10, 2),
    digital_activation_account_number varchar(255),
    digital_redemption_account_number varchar(255),
    proxy_card_number                 varchar(255),
    message_reason_code               varchar(50),
    date_c1                           date,
    date_d1                           date
);

alter table tb_transacciones_blackhawk_ftp
    owner to postgres;

create or replace function uuid_nil() returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_nil() owner to postgres;

create or replace function uuid_ns_dns() returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_ns_dns() owner to postgres;

create or replace function uuid_ns_url() returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_ns_url() owner to postgres;

create or replace function uuid_ns_oid() returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_ns_oid() owner to postgres;

create or replace function uuid_ns_x500() returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_ns_x500() owner to postgres;

create or replace function uuid_generate_v1() returns uuid
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_generate_v1() owner to postgres;

create or replace function uuid_generate_v1mc() returns uuid
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_generate_v1mc() owner to postgres;

create or replace function uuid_generate_v3(namespace uuid, name text) returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_generate_v3(uuid, text) owner to postgres;

create or replace function uuid_generate_v4() returns uuid
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_generate_v4() owner to postgres;

create or replace function uuid_generate_v5(namespace uuid, name text) returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_generate_v5(uuid, text) owner to postgres;

create or replace function fn_automatico_reporte_blackhawk_detalle(fecha_inicio character varying, fecha_fin character varying)
    returns TABLE(ch text, "bhn transaction id" bigint, "company name" text, "merchant id" text, "merchant name" text, "stored id" integer, "partner store id" text, "store name" text, state text, "terminal id" integer, "acquired transaction date" text, "acquired transaction time" text, "gift card number" text, "digital activation account number" text, "digital redemption account number" text, "proxy card number" text, "product id" character varying, "product description" text, "pos transaction date" text, "pos transaction time" text, "transaction type" character varying, "system trace audit number" text, "currency code" text, "MERCHANT TRANSACTION ID/REFERENCE NUMBER" text, "invoice number" text, "internal response code" text, "approval code" text, "REVERSAL/SAF_CODE" text, "transaction amount" numeric, "consumer fee amount" numeric, "commission amount" numeric, "total tax on transaction amount" numeric, "total tax on commission amount" numeric, "total tax on fees amount" numeric, "ORDER_ID/SID" text, "EXTERNAL ORDER ID/RELOADIT PACK NUMBER" text, "transaction guid" character varying, "transaction cguid" character varying, "phone number" character varying, "sales tax" numeric, "message reason code" text, "shipment date" text, "bhn shipment carrier code" text, "bhn shipment method name" text, "external shipment method name" text, "shipment cost" numeric, "shipment tracking number" text, "bhn po number" text, "external po number" text, "external sku" text, "external upc" text, "external line item identifier" text, "partner transaction_id1" text, "partner transaction_id2" text, "net amount" numeric, "provisioning type" character varying, "product item identifier" text, "order billing sender id" text, "shipment receiver id" text, "incident ticket number" text, "external card number" text, "devalue date" text, "settlement date" text)
    language plpgsql
as
$$
DECLARE

BEGIN


	RETURN query
	SELECT 'DT' AS CH
	      ,id_transaccion AS BHN_TRANSACTION_ID
		  ,'COMERCIALIZADORA RAPIDO SA DE CV' AS COMPANY_NAME
		  ,'60300029843' AS MERCHANT_ID
		  ,'724 MIX' AS MERCHANT_NAME
		  ,id_sucursal AS STORE_ID
		  ,'' AS PARTNER_STORE_ID  --Numero de sucursal
		  ,'' AS STORE_NAME		   --Descripcion de la sucursal.
		  ,'' AS STATE			   --Estado ubicacion de la sucursal
		  ,id_caja AS TERMINAL_ID
		  ,to_char(fecha, 'YYYYMMDD') AS ACQUIRED_TRANSACTION_DATE
		  ,to_char(fecha, 'HH24:MI:SS') AS ACQUIRED_TRANSACTION_TIME
		  ,referencia::text AS GIFT_CARD_NUMBER
		  ,'' AS DIGITAL_ACTIVATION_ACCOUNT_NUMBER
		  ,'' AS DIGITAL_REDEMPTION_ACCOUNT_NUMBER
		  ,'' AS PROXY_CARD_NUMBER
		  ,codigodebarras AS PRODUCT_ID
		  ,'' AS PRODUCT_DESCRIPTION
		  ,to_char(fecha_pos, 'YYYYMMDD') AS POS_TRANSACTION_DATE
		  ,to_char(fecha_pos, 'HH24:MI:SS') AS POS_TRANSACTION_TIME
		  ,(SELECT tipo_transaccion
			 FROM codigos_procesamiento
			 WHERE normal = ((t.solicitud::json#>'{request,transaction}')->>'processingCode'::varchar)
			)AS TRANSACTION_TYPE
		  ,'' AS SYSTEM_TRACE_AUDIT_NUMBER
		  ,((t.solicitud::json#>'{request,transaction}')->>'transactionCurrencyCode'::varchar) AS CURRENCY_CODE
		  ,'' AS "MERCHANT_TRANSACTION_ID/REFERENCE_NUMBER"
		  ,'' AS INVOICE_NUMBER
		  ,((t.solicitud::json#>'{response,transaction}')->>'responseCode'::varchar) AS INTERNAL_RESPONSE_CODE
		  ,'' AS APPROVAL_CODE
		  ,CASE WHEN id_tipo_transaccion = 5 THEN 'R' ELSE '' END AS "REVERSAL/SAF_CODE" 	--Ver tema de revesos por las condiciones solicitadas
		  ,importe::NUMERIC(15,4) AS TRANSACTION_AMOUNT
		  , 0.0000::NUMERIC(15,4) AS CONSUMER_FEE_AMOUNT
		  , 0.0000::NUMERIC(15,4) AS COMMISSION_AMOUNT  --PREGUNTAR EL TEMA DE LA COMISION??
		  , 0.0000::NUMERIC(15,4) AS TOTAL_TAX_ON_TRANSACTION_AMOUNT
		  , 0.0000::NUMERIC(15,4) AS TOTAL_TAX_ON_COMMISSION_AMOUNT
		  , 0.0000::NUMERIC(15,4) AS ASTOTAL_TAX_ON_FEES_AMOUNT
		  ,'' AS "ORDER_ID/SID"
		  ,'' AS "EXTERNAL_ORDER_ID/RELOADIT_PACK_NUMBER"
		  ,guid AS TRANSACTION_GUID
		  ,cguid AS TRANSACTION_CGUID
		  ,cliente_celular AS PHONE_NUMBER
		  ,0.0000::NUMERIC(15,4)  AS SALES_TAX
		  ,'' AS MESSAGE_REASON_CODE
		  ,'' AS SHIPMENT_DATE
		  ,'' AS BHN_SHIPMENT_CARRIER_CODE
		  ,'' AS BHN_SHIPMENT_METHOD_NAME
		  ,'' AS EXTERNAL_SHIPMENT_METHOD_NAME
		  ,0.0000::NUMERIC(13,1) AS SHIPMENT_COST
		  ,'' AS SHIPMENT_TRACKING_NUMBER
		  ,'' AS BHN_PO_NUMBER
		  ,'' AS EXTERNAL_PO_NUMBER
		  ,'' AS EXTERNAL_SKU
		  ,'' AS EXTERNAL_UPC
		  ,'' AS EXTERNAL_LINE_ITEM_IDENTIFIER
		  ,'' AS PARTNER_TRANSACTION_ID1
		  ,'' AS PARTNER_TRANSACTION_ID2
		  ,0.0000::NUMERIC(15,4) AS NET_AMOUNT
		  ,(SELECT tipo FROM tipo_producto WHERE id_articulo = t.id_articulo) AS PROVISIONING_TYPE  --D=Digital, P=Physical, o Null (if not available for a product)
		  ,'' AS PRODUCT_ITEM_IDENTIFIER
		  ,'' AS ORDER_BILLING_SENDER_ID
		  ,'' AS SHIPMENT_RECEIVER_ID
		  ,'' AS INCIDENT_TICKET_NUMBER
		  ,'' AS EXTERNAL_CARD_NUMBER
		  ,'' AS DEVALUE_DATE
		  ,'' AS SETTLEMENT_DATE
	FROM transacciones t
	--WHERE t.fecha::DATE BETWEEN '2023-11-30' AND '2024-02-28'
	WHERE t.fecha_mst::DATE BETWEEN fecha_inicio::DATE AND fecha_fin::DATE
	  AND codigo_respuesta = '00' -- 00 = Exitosa
	  AND confirmado_pos = true
	ORDER BY id_transaccion DESC;

END;
$$;

alter function fn_automatico_reporte_blackhawk_detalle(varchar, varchar) owner to postgres;

create or replace function fn_automatico_reporte_blackhawk_encabezado(fecha_inicio character varying, fecha_fin character varying)
    returns TABLE(dato text)
    language plpgsql
as
$$
DECLARE

BEGIN
	-- RECORD ID 			  -> TAMAÑO = 2  CONSTANTE 'HR'
	-- FILE ID   			  -> TAMAÑO = 40 CONSTANTE 'BHN Statement Transaction Detail'
	-- FILE TRANSMISSION DATE -> TAMAÑO = 10 Fecha en que el archivo fue creado para la transmisión
	-- FILE REPORTING DATE    -> TAMAÑO = 10 Fecha de las transacciones
	-- PARTNER ID             -> TAMAÑO = 10 Numero del cliente
	-- PARTNER NAME  		  -> TAMAÑO = 25 Nombre del socio

	RETURN query
	SELECT 'HR'
	       ||','||'BHN Statement Transaction Detail'
		   ||','||'' ||TO_CHAR(fecha_inicio::DATE, 'YYYYmmdd') ||''
		   ||','||'' ||TO_CHAR(fecha_inicio::DATE, 'YYYYmmdd') ||''
		   ||','||'' ||'60300029843'||''
		   ||','||'' ||'COMERCIALIZADORA RAPIDO 724'||''
		   ;

	END;
$$;

alter function fn_automatico_reporte_blackhawk_encabezado(varchar, varchar) owner to postgres;

create or replace function fn_automatico_reporte_blackhawk_nombre(fecha_inicio character varying, fecha_fin character varying)
    returns TABLE(dato text)
    language plpgsql
as
$$
DECLARE
	_consecutivo character varying;
BEGIN

	RETURN query
	SELECT 'CP_'
		   ||TO_CHAR(NOW()::DATE, 'ddmmYYYY');

END;
$$;

alter function fn_automatico_reporte_blackhawk_nombre(varchar, varchar) owner to postgres;

create or replace function fn_automatico_reporte_blackhawk_pie(fecha_inicio character varying, fecha_fin character varying)
    returns TABLE("RECORD ID" text, "FILE ID" text, "FILE TRANSMISSION DATE" text, "TOTAL TRANSACTION COUNT" integer, "TOTAL TRANSACTION TYPES" integer, "TOTAL COMMISSION AMOUNT" numeric, "TOTAL CONSUMER FEE AMOUNT" numeric, "TOTAL TAX ON TRANSACTION AMOUNT" numeric, "TOTAL TAX ON COMMISSION AMOUNT" numeric, "TOTAL TAX ON CONSUMER FEES AMOUNT" numeric, "NET TRANSACTIONS AMOUNT" numeric)
    language plpgsql
as
$$
DECLARE
	_total_de_transacciones integer;
	_total_tipo_transacciones integer;
	_totales RECORD;
BEGIN

	CREATE TEMP TABLE temp_detalle_blackhawk ON COMMIT DROP AS
	SELECT *
	--INTO TEMP temp_detalle_blackhawk
	FROM fn_automatico_reporte_blackhawk_detalle(fecha_inicio,fecha_fin);--(fecha_inicio,fecha_fin);


	SELECT COUNT(ch) INTO _total_de_transacciones
	FROM temp_detalle_blackhawk;

	SELECT COUNT(DISTINCT("transaction type")) INTO _total_tipo_transacciones
	FROM temp_detalle_blackhawk;

	SELECT SUM("commission amount") 	AS commission_amount			--TOTAL COMMISSION AMOUNT
		  ,SUM("consumer fee amount") AS consumer_fee_amount			--TOTAL CONSUMER FEE AMOUNT
		  ,SUM("total tax on transaction amount") AS total_tax_on_transaction_amount --TOTAL TAX ON TRANSACTION AMOUNT
		  ,SUM("total tax on commission amount")  AS total_tax_on_commission_amount  --TOTAL TAX ON COMMISSION AMOUNT
		  ,SUM("total tax on fees amount") 		  AS total_tax_on_fees_amount		--TOTAL TAX ON CONSUMER FEES AMOUNT
		  ,SUM("transaction amount")			  AS transaction_amount --NET TRANSACTIONS AMOUNT
	INTO _totales
	FROM temp_detalle_blackhawk;


	RETURN query
	SELECT 'TR' AS "RECORD ID"
	      ,'BHN Statement Transaction Detail' AS "FILE ID"
		  , to_char(now(),'YYYYmmdd') AS "FILE TRANSMISSION DATE"
		  , COALESCE(_total_de_transacciones, 0) AS "TOTAL TRANSACTION COUNT"
		  , COALESCE(_total_tipo_transacciones, 0) AS "TOTAL TRANSACTION TYPES"
		  , COALESCE(_totales.commission_amount, 0) AS "TOTAL COMMISSION AMOUNT"
		  , COALESCE(_totales.consumer_fee_amount, 0) AS "TOTAL CONSUMER FEE AMOUNT"
		  , COALESCE(_totales.total_tax_on_transaction_amount, 0) AS "TOTAL TAX ON TRANSACTION AMOUNT"
		  , COALESCE(_totales.total_tax_on_commission_amount, 0) AS "TOTAL TAX ON COMMISSION AMOUNT"
		  , COALESCE(_totales.total_tax_on_fees_amount, 0) AS "TOTAL TAX ON CONSUMER FEES AMOUNT"
		  , COALESCE(_totales.transaction_amount, 0) AS "NET TRANSACTIONS AMOUNT"
		  ;

END;
$$;

alter function fn_automatico_reporte_blackhawk_pie(varchar, varchar) owner to postgres;

create or replace function fn_consultar_transacciones_a_reversar()
    returns TABLE(id_transaccion bigint, fecha timestamp without time zone, fecha_pos timestamp without time zone, estatus character varying, id_tipo_transaccion integer, id_movimiento integer, id_sucursal integer, id_caja integer, ticket character varying, numero_de_sucursal integer, id_articulo integer, codigodebarras character varying, referencia character varying, importe numeric, cliente_celular character varying, cliente_email character varying, codigo_estatus character varying, codigo_respuesta character varying, autorizacion character varying, guid character varying, cguid character varying, fecha_solicitud timestamp without time zone, solicitud text, fecha_respuesta timestamp without time zone, respuesta text, id_transaccion_reverso bigint, reverso_aprobado boolean, confirmado_pos boolean, fecha_confirmado timestamp without time zone, operador character varying, cierre integer, corte integer, fecha_mst timestamp without time zone)
    language plpgsql
as
$$
DECLARE

BEGIN

	--Los reversos se pueden reversar hasta un maximo de 24 Hrs
	--con intentos cada 15 min.

	-- 00 = Approved – balance available
	-- 15 = Time Out occurred- Auth Server not available /responding
	-- 74 = Unable to route / System Error


	--500 = Internal Server Error -Valor retornado por BlackHawk
	--408 = Request Timeout - Si no se tuvo respuesta por x razón se lanza reverso

	RETURN query
	SELECT *
	FROM transacciones t
	WHERE t.id_tipo_transaccion = 7
	  AND t.codigo_respuesta IN ('15','74','500','408')
	  AND t.reverso_aprobado = false
	  AND t.codigo_estatus = '00'
	  AND t.fecha >= (now() - '24 hour'::INTERVAL); -- Limite maximo para reverso


END;
$$;

alter function fn_consultar_transacciones_a_reversar() owner to postgres;

create or replace function fn_solicitudes_blackhawk(_fecha_ini date, _fecha_fin date)
    returns TABLE(id_transaccion bigint, tipo character varying, fecha timestamp without time zone, estatus character varying, id_sucursal integer, terminal integer, ticket character varying, referencia character varying, importe numeric, autorizacion character varying, codigo_estatus character varying, codigo_respuesta character varying, mensaje text, confirmado_pos boolean, fecha_confirmado timestamp without time zone, id_reverso bigint)
    language plpgsql
as
$$
DECLARE
--****************************************************************
--Elaborado: Eusebio L. Zurita Hegler.
--Creado: 11/12/2023
--Funcion: Consulta de las solicitudes realizadas a BlackHawk.
--****************************************************************
BEGIN

	RETURN query
	SELECT t.id_transaccion,
		   tipo.descripcion tipo,
		   t.fecha,
		   t.estatus,
		   t.id_sucursal,
		   t.id_caja terminal,
		   t.ticket,
		   t.referencia,
		   t.importe,
		   t.guid AS autorizacion,
		   t.codigo_estatus,
		   t.codigo_respuesta,
		   c.tipo || ' | ' || c.descripcion mensaje,
		   t.confirmado_pos,
		   t.fecha_confirmado,
		   t.id_transaccion_reverso id_reverso
	FROM transacciones t
	LEFT JOIN codigos_respuesta c ON t.codigo_respuesta = c.codigo_respuesta
	LEFT JOIN tipo_transacciones tipo ON t.id_tipo_transaccion = tipo.id_tipo_transaccion
	WHERE t.fecha::date between _fecha_ini and _fecha_fin --'10-01-2023'::date and  '10-01-2023'::date --
	ORDER BY t.id_transaccion DESC;--limit 10;

END;
$$;

alter function fn_solicitudes_blackhawk(date, date) owner to postgres;

create or replace function fn_solicitudes_blackhawk(_fecha_ini date, _fecha_fin date, _id_sucursal bigint)
    returns TABLE(id_transaccion bigint, tipo character varying, fecha timestamp without time zone, estatus character varying, id_sucursal integer, terminal integer, ticket character varying, referencia character varying, importe numeric, autorizacion character varying, codigo_estatus character varying, codigo_respuesta character varying, mensaje text, confirmado_pos boolean, fecha_confirmado timestamp without time zone, id_reverso bigint)
    language plpgsql
as
$$
DECLARE
--****************************************************************
--Elaborado: Eusebio L. Zurita Hegler.
--Creado: 11/12/2023
--Funcion: Consulta de las solicitudes realizadas a BlackHawk.
--****************************************************************
BEGIN

	RETURN query
	SELECT t.id_transaccion,
		   tipo.descripcion tipo,
		   t.fecha,
		   t.estatus,
		   t.id_sucursal,
		   t.id_caja terminal,
		   t.ticket,
		   t.referencia,
		   t.importe,
		   t.guid AS autorizacion,
		   t.codigo_estatus,
		   t.codigo_respuesta,
		   c.tipo || ' | ' || c.descripcion mensaje,
		   t.confirmado_pos,
		   t.fecha_confirmado,
		   t.id_transaccion_reverso id_reverso
	FROM transacciones t
	LEFT JOIN codigos_respuesta c ON t.codigo_respuesta = c.codigo_respuesta
	LEFT JOIN tipo_transacciones tipo ON t.id_tipo_transaccion = tipo.id_tipo_transaccion
	WHERE t.fecha::date between _fecha_ini and _fecha_fin --'10-01-2023'::date and  '10-01-2023'::date --
	AND  t.id_sucursal = _id_sucursal
	ORDER BY t.id_transaccion DESC;

END;
$$;

alter function fn_solicitudes_blackhawk(date, date, bigint) owner to postgres;

create or replace function fn_solicitudes_blackhawk_top()
    returns TABLE(id_transaccion bigint, tipo character varying, fecha timestamp without time zone, estatus character varying, id_sucursal integer, terminal integer, ticket character varying, referencia character varying, importe numeric, autorizacion character varying, codigo_estatus character varying, codigo_respuesta character varying, mensaje text, confirmado_pos boolean, fecha_confirmado timestamp without time zone, id_reverso bigint)
    language plpgsql
as
$$
DECLARE
--****************************************************************
--Elaborado: Eusebio L. Zurita Hegler.
--Creado: 11/12/2023
--Funcion: Consulta el top de las solicitudes realizadas a BlackHawk.
--****************************************************************
BEGIN

	RETURN query
	SELECT t.id_transaccion,
		   tipo.descripcion tipo,
		   t.fecha,
		   t.estatus,
		   t.id_sucursal,
		   t.id_caja terminal,
		   t.ticket,
		   t.referencia,
		   t.importe,
		   t.guid AS autorizacion,
		   t.codigo_estatus,
		   t.codigo_respuesta,
		   c.tipo || ' | ' || c.descripcion mensaje,
		   t.confirmado_pos,
		   t.fecha_confirmado,
		   t.id_transaccion_reverso id_reverso
	FROM transacciones t
	LEFT JOIN codigos_respuesta c ON t.codigo_respuesta = c.codigo_respuesta
	LEFT JOIN tipo_transacciones tipo ON t.id_tipo_transaccion = tipo.id_tipo_transaccion
	WHERE t.fecha::date between now()::date and now()::date --'10-01-2023'::date and  '10-01-2023'::date --
	ORDER BY t.id_transaccion DESC
	LIMIT 30;

END;
$$;

alter function fn_solicitudes_blackhawk_top() owner to postgres;

create or replace function fn_tipodemoneda_consultar(_codigodebarras character varying)
    returns TABLE(id_tarjeta integer, codigodebarras character varying, monto numeric, clave_moneda character varying, codigo_moneda integer)
    language plpgsql
as
$$
-- =============================================
-- Author:Eusebio Lorenzo Zurita Hegler
-- Create date: 12/02/2024
-- Description:	CONSULTA PARA LOS PRODUCTOS MARCADOS EN DOLARES
--				SE DEBE ENVIAR CON ESTOS IMPORTES EN LA MENSAJERIA.
-- =============================================
DECLARE
	_siguiente_folio int;
BEGIN

	RETURN query
	SELECT t.id_tarjeta,
		   t.codigodebarras,
		   t.monto,
		   t.clave_moneda,
		   t.codigo_moneda
	FROM tarjetaregalo_tipodemoneda t
	WHERE t.codigodebarras = _codigodebarras;

END;
$$;

alter function fn_tipodemoneda_consultar(varchar) owner to postgres;

create or replace function fn_verificaconexionpor_echo_blackhawk(_echos integer)
    returns TABLE(id_echo bigint, estatus boolean, fecha timestamp without time zone, solicitud_echo text, respuesta_echo text, statuscode character varying)
    language plpgsql
as
$$
DECLARE
--****************************************************************
--Elaborado: Eusebio L. Zurita Hegler.
--Creado: 16/01/2024
--Funcion: Consulta los echos para verificar que se tenga arriba el servicio con BlackHawk
--****************************************************************
BEGIN


	RETURN QUERY
	SELECT *
	FROM echos e
	WHERE e.fecha >= (now()- (INTERVAL '1 second' * _echos))
	ORDER BY e.id_echo DESC
	LIMIT 1;


END;
$$;

alter function fn_verificaconexionpor_echo_blackhawk(integer) owner to postgres;



-- black hawk
create table codigos_respuesta
(
    codigo_respuesta varchar(3)   not null
        primary key,
    tipo             varchar(30),
    descripcion      varchar(255) not null
);

alter table codigos_respuesta
    owner to postgres;

create index index_codigos_respuesta
    on codigos_respuesta (codigo_respuesta);

create table movimientos
(
    id_movimiento serial
        primary key,
    valor         varchar(30),
    descripcion   varchar(255) not null
);

alter table movimientos
    owner to postgres;

create index index_movimientos
    on movimientos (id_movimiento);

create table tipo_transacciones
(
    id_tipo_transaccion serial
        primary key,
    valor               varchar(50)  not null,
    descripcion         varchar(255) not null
);

alter table tipo_transacciones
    owner to postgres;

create index index_tipo_transacciones
    on tipo_transacciones (id_tipo_transaccion);

create table login
(
    id_login        serial
        primary key,
    estatus         boolean   not null,
    fecha           timestamp not null,
    solicitud_login text,
    respuesta_login text,
    statuscode      varchar(2),
    responsecode    varchar(2)
);

alter table login
    owner to postgres;

create table echos
(
    id_echo        serial
        primary key,
    estatus        boolean default false not null,
    fecha          timestamp             not null,
    solicitud_echo text,
    respuesta_echo text,
    statuscode     varchar(2)
);

alter table echos
    owner to postgres;

create index index_echos
    on echos (id_echo, estatus, fecha);

create table transacciones
(
    id_transaccion        bigserial
        primary key,
    fecha                 timestamp             not null,
    fecha_pos             timestamp             not null,
    estatus               varchar(20),
    id_tipo_transaccion   integer               not null
        constraint fktransaccio968323
            references tipo_transacciones,
    id_movimiento         integer,
    id_sucursal           integer               not null,
    id_caja               integer               not null,
    ticket                varchar(25)           not null,
    numero_de_sucursal    integer               not null,
    id_articulo           integer               not null,
    codigodebarras        varchar(255)          not null,
    referencia            varchar(100),
    importe               numeric(18, 6),
    cliente_celular       varchar(15),
    cliente_email         varchar(255),
    codigo_estatus        varchar(2),
    codigo_respuesta      varchar(3),
    autorizacion          varchar(10),
    guid                  varchar(26),
    cguid                 varchar(26),
    fecha_solicitud       timestamp,
    solicitud             text,
    fecha_respuesta       timestamp,
    respuesta             text,
    id_trasaccion_reverso bigint,
    reverso_aprobado      boolean default false not null,
    confirmado_pos        boolean,
    fecha_confirmado      timestamp,
    operador              varchar(255),
    cierre                integer,
    corte                 integer
);

alter table transacciones
    owner to postgres;

create index index_transacciones
    on transacciones (id_transaccion, fecha, id_sucursal, referencia, codigo_respuesta, autorizacion, cierre, corte);

create function uuid_nil() returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_nil() owner to postgres;

create function uuid_ns_dns() returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_ns_dns() owner to postgres;

create function uuid_ns_url() returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_ns_url() owner to postgres;

create function uuid_ns_oid() returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_ns_oid() owner to postgres;

create function uuid_ns_x500() returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_ns_x500() owner to postgres;

create function uuid_generate_v1() returns uuid
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_generate_v1() owner to postgres;

create function uuid_generate_v1mc() returns uuid
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_generate_v1mc() owner to postgres;

create function uuid_generate_v3(namespace uuid, name text) returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_generate_v3(uuid, text) owner to postgres;

create function uuid_generate_v4() returns uuid
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_generate_v4() owner to postgres;

create function uuid_generate_v5(namespace uuid, name text) returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_generate_v5(uuid, text) owner to postgres;

create function fn_consultar_transacciones_a_reversar()
    returns TABLE(id_transaccion bigint, fecha timestamp without time zone, fecha_pos timestamp without time zone, estatus character varying, id_tipo_transaccion integer, id_movimiento integer, id_sucursal integer, id_caja integer, ticket character varying, numero_de_sucursal integer, id_articulo integer, codigodebarras character varying, referencia character varying, importe numeric, cliente_celular character varying, cliente_email character varying, codigo_estatus character varying, codigo_respuesta character varying, autorizacion character varying, guid character varying, cguid character varying, fecha_solicitud timestamp without time zone, solicitud text, fecha_respuesta timestamp without time zone, respuesta text, id_trasaccion_reverso bigint, reverso_aprobado boolean, confirmado_pos boolean, fecha_confirmado timestamp without time zone, operador character varying, cierre integer, corte integer)
    language plpgsql
as
$$
DECLARE 
	
BEGIN
	
	--Los reversos se pueden reversar hasta un maximo de 24 Hrs
	--con intentos cada 15 min.
	
	-- 00 = Approved – balance available
	-- 15 = Time Out occurred- Auth Server not available /responding
	-- 74 = Unable to route / System Error 
	
	
	--500 = Internal Server Error -Valor retornado por BlackHawk 
	--408 = Request Timeout - Si no se tuvo respuesta por x razón se lanza reverso
	
	RETURN query
	SELECT *
	FROM transacciones t
	WHERE t.id_tipo_transaccion = 7
	  AND t.codigo_respuesta IN ('15','74','500','408')
	  AND t.reverso_aprobado = false	  
	  AND t.codigo_estatus = '00'	  
	  AND t.fecha >= (now() - '24 hour'::INTERVAL); -- Limite maximo para reverso	  
	
			
END;
$$;

alter function fn_consultar_transacciones_a_reversar() owner to postgres;

