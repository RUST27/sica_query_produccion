create table _rec_record
(
    id_telefonia integer,
    id_multired  integer,
    descripcion  varchar(255),
    usuario      varchar(50),
    password     varchar(50)
);

alter table _rec_record
    owner to postgres;

create table c_categorias
(
    id_categoria serial
        primary key,
    descripcion  varchar(250)
);

alter table c_categorias
    owner to postgres;

create table c_clientes
(
    id_cliente serial
        primary key,
    nombre     varchar(255)
);

alter table c_clientes
    owner to postgres;

create table c_estatus
(
    status      char not null
        primary key,
    descripcion varchar(100)
);

alter table c_estatus
    owner to postgres;

create table c_grupo_usuarios
(
    id_grupo_usuarios serial
        primary key,
    descripcion       varchar(250)
);

alter table c_grupo_usuarios
    owner to postgres;

create table c_ips
(
    unique_id     integer     not null,
    id_cliente    integer     not null,
    "Ip"          varchar(15) not null,
    "Mac_Address" varchar(25) not null,
    "Alias"       varchar(50) not null,
    status        varchar(1)
);

alter table c_ips
    owner to postgres;

create table c_productos
(
    id_producto     serial
        primary key,
    id_subcategoria integer,
    sku             varchar(100),
    costo_producto  numeric(19, 4),
    descripcion     text
);

alter table c_productos
    owner to postgres;

create table c_tipo_calle
(
    id_tipo_calle serial
        primary key,
    descripcion   varchar(150)
);

alter table c_tipo_calle
    owner to postgres;

create table c_tipo_movimientos
(
    id_tipo_movimiento serial
        primary key,
    descripcion        varchar(100),
    siglas             char(2)
);

alter table c_tipo_movimientos
    owner to postgres;

create table c_usuarios
(
    id_usuario       serial
        primary key,
    usuario          varchar(250),
    password         varchar(250),
    nombre_usuario   varchar(50),
    baja             integer,
    id_grupo_usuario integer not null
        constraint fkc_usuarios671173
            references c_grupo_usuarios
        constraint fkc_usuarios671174
            references c_grupo_usuarios,
    id_cliente       integer not null
        constraint fkc_usuarios856714
            references c_clientes
        constraint fkc_usuarios856715
            references c_clientes
);

alter table c_usuarios
    owner to postgres;

create table menu
(
    id_menu       integer,
    titulo        varchar(255),
    menu          varchar(255),
    id_menu_padre integer
);

alter table menu
    owner to postgres;

create table producto_telefonia
(
    id_producto  integer not null,
    id_telefonia integer not null,
    primary key (id_producto, id_telefonia)
);

alter table producto_telefonia
    owner to postgres;

create table productos_multired
(
    id_multired integer,
    sku         varchar(255)
);

alter table productos_multired
    owner to postgres;

create table respuestas_recibidas
(
    id_respuesta          serial
        primary key,
    respuesta             text,
    autorizacion          varchar(15),
    cve_respuesta         varchar(5),
    descripcion_respuesta text,
    fecha_respuesta       timestamp
);

alter table respuestas_recibidas
    owner to postgres;

create table tb_codigos_respuesta
(
    id_codigo   serial
        primary key,
    codigo      varchar(20),
    descripcion text,
    mensaje     varchar(255)
);

alter table tb_codigos_respuesta
    owner to postgres;

create table tb_comiciones_clientes
(
    id_producto serial
        primary key,
    id_cliente  integer not null,
    sku         varchar(255),
    comision    numeric(19, 4),
    costo       numeric(19, 4)
);

alter table tb_comiciones_clientes
    owner to postgres;

create table tb_conciliaciones
(
    id_conciliacion serial
        primary key,
    fecha           timestamp,
    archivo         text,
    status          text
);

alter table tb_conciliaciones
    owner to postgres;

create table tb_consultas
(
    id_consulta serial
        primary key,
    fecha       timestamp,
    id_tienda   integer,
    id_terminal integer,
    ticket      varchar(100),
    clientes    varchar(255),
    status      char,
    account     varchar(100),
    naadstre    text,
    partial     char(2),
    concepto    text,
    code        varchar(10),
    mensaje     text
);

alter table tb_consultas
    owner to postgres;

create table tb_contactos
(
    id_contacto serial
        primary key,
    id_cliente  integer not null
        constraint fktb_contact891731
            references c_clientes,
    nombre      varchar(255),
    telefono    varchar(10),
    email       varchar(255),
    status      char
);

alter table tb_contactos
    owner to postgres;

create table tb_costo_recargas_clientes
(
    id_costo_recarga serial
        primary key,
    id_cliente       integer,
    id_telefonia     integer,
    monto            numeric(19, 4),
    costo            numeric(19, 4),
    costo_prom       numeric(19, 4),
    status           char(2),
    id_producto      integer
);

alter table tb_costo_recargas_clientes
    owner to postgres;

create table tb_cuentas
(
    id_cuenta    serial
        primary key,
    id_proveedor integer,
    descripcion  varchar(255),
    tipo_cuenta  char,
    id_cliente   integer,
    saldo        numeric(19, 2),
    status       char,
    servicio     char,
    id_tienda    integer
);

alter table tb_cuentas
    owner to postgres;

create table tb_estados
(
    id_estado    serial
        primary key,
    nombre       varchar(255),
    nombre_corto varchar(255)
);

alter table tb_estados
    owner to postgres;

create table tb_fraudes
(
    id_fraude  serial
        primary key,
    id_tienda  integer,
    monto      numeric(19),
    referencia varchar(100)
);

alter table tb_fraudes
    owner to postgres;

create table tb_historial_saldos
(
    id_historico   serial
        primary key,
    id_cliente     integer,
    fecha          timestamp,
    saldo_actual   numeric(19, 2),
    saldo_anterior numeric(19, 2),
    entradas       numeric(19, 2),
    venta_dia      numeric(19, 2),
    diferencia     numeric(19, 2)
);

alter table tb_historial_saldos
    owner to postgres;

create table tb_movimientos_saldos
(
    id_movimiento_saldos serial
        primary key,
    tipo_movimiento      char(2),
    cuenta_origen        integer,
    cuenta_destino       integer,
    monto                numeric(19, 2),
    num_factura          varchar(255),
    referencia           varchar(255),
    fecha_documento      timestamp,
    status               char,
    usuario_alta         integer,
    fecha_alta           timestamp,
    usuario_modificacion integer,
    fecha_modificacion   timestamp
);

alter table tb_movimientos_saldos
    owner to postgres;

create table tb_network_invalida
(
    id_network serial
        primary key,
    fecha      timestamp,
    id_tienda  integer,
    ip         varchar(100),
    mac        varchar(100)
);

alter table tb_network_invalida
    owner to postgres;

create table tb_networks_credentials
(
    id_ipmac   serial
        primary key,
    id_cliente integer,
    ip         varchar(100),
    mac        varchar(50),
    alias      varchar(250),
    status     char
);

alter table tb_networks_credentials
    owner to postgres;

create table tb_proveedores
(
    id_proveedor serial
        primary key,
    descripcion  varchar(255)
);

alter table tb_proveedores
    owner to postgres;

create table tb_solicitudes_multired_recargas
(
    id_transaccion bigserial
        primary key,
    uuid           text
);

alter table tb_solicitudes_multired_recargas
    owner to postgres;

create table tb_solicitudes_multired_servicios
(
    id_transaccion bigserial
        primary key,
    uuid           text
);

alter table tb_solicitudes_multired_servicios
    owner to postgres;

create table tb_solicitudes_recargas
(
    id_solicitud          bigserial
        primary key,
    operacion             varchar(10),
    status                varchar(4),
    fecha                 timestamp,
    fecha_envio           timestamp,
    fecha_respuesta       timestamp,
    id_producto           integer,
    id_cliente            integer,
    id_tienda             integer,
    id_terminal           integer,
    id_cajero             integer,
    id_ticket             bigint,
    referencia            varchar(100),
    monto                 numeric(12, 4),
    costo_proveedor       numeric(12, 4),
    costo_cliente         numeric(12, 4),
    respuesta             text,
    autorizacion          varchar(10),
    cve_respuesta         varchar(6),
    descripcion_respuesta text,
    cve_respuesta_cte     varchar(10),
    id_proveedor          integer,
    ocurrio_excepcion     boolean
);

alter table tb_solicitudes_recargas
    owner to postgres;

create index index_id
    on tb_solicitudes_recargas (id_solicitud desc);

create index index_sol_pend_filter
    on tb_solicitudes_recargas (fecha, id_cliente, id_tienda);

create index index_sol_pend_filter_fecha
    on tb_solicitudes_recargas (fecha);

create table tb_solicitudes_recargas_enviadas
(
    id_envio    bigserial
        primary key,
    fecha_envio timestamp
);

alter table tb_solicitudes_recargas_enviadas
    owner to postgres;

create table tb_solicitudes_servicios
(
    id_solicitud          bigserial
        primary key,
    operacion             varchar(10),
    status                varchar(4),
    fecha                 timestamp,
    fecha_envio           timestamp,
    fecha_respuesta       timestamp,
    id_producto           integer,
    id_cliente            integer,
    id_tienda             integer,
    id_terminal           integer,
    id_cajero             integer,
    id_ticket             bigint,
    id_proveedor          integer,
    respuesta             text,
    autorizacion          varchar(10),
    cve_respuesta         varchar(6),
    descripcion_respuesta text,
    referencia            varchar(100),
    reference_billing     varchar(255),
    product_id            varchar(255),
    solicitud_json        text,
    respuesta_json        text,
    monto                 numeric(12, 4),
    ocurrio_excepcion     boolean
);

alter table tb_solicitudes_servicios
    owner to postgres;

create index indice_dx
    on tb_solicitudes_servicios (id_solicitud);

create table tb_solicitudes_servicios_enviadas
(
    id_envio    bigserial
        primary key,
    fecha_envio timestamp
);

alter table tb_solicitudes_servicios_enviadas
    owner to postgres;

create table tb_subcategorias
(
    id_subcategoria integer not null,
    id_categoria    integer not null,
    descripcion     varchar(255),
    primary key (id_subcategoria, id_categoria)
);

alter table tb_subcategorias
    owner to postgres;

create table tb_telefonias
(
    id_telefonia serial
        primary key,
    descripcion  varchar(255),
    id_multired  integer,
    usuario      varchar(50),
    password     varchar(50)
);

alter table tb_telefonias
    owner to postgres;

create table tb_terminales
(
    id_terminal serial
        primary key,
    id_tienda   integer,
    descripcion varchar(255),
    alias       integer
);

alter table tb_terminales
    owner to postgres;

create table tb_tiendas
(
    id_tienda          serial
        primary key,
    id_cliente         integer,
    nombre             varchar(255),
    ciudad             varchar(255),
    estado             varchar(255),
    porcentaje         varchar(10),
    factura            varchar(255),
    razon_social       varchar(255),
    region             varchar(5),
    comercio           varchar(200),
    calle              varchar(150),
    numero             integer,
    colonia            varchar(200),
    municipio          varchar(200),
    cp                 varchar(20),
    dias_laboran       varchar(10),
    horario            integer,
    contacto           varchar(255),
    telefono_contacto  varchar(30),
    alias              integer,
    tipo_calle         varchar(10),
    numero_ext         integer,
    fecha_alta         timestamp,
    fecha_modificacion timestamp
);

alter table tb_tiendas
    owner to postgres;

create table tb_tiendas_sepomex
(
    id_sepomex   serial
        primary key,
    id_tienda    integer,
    id_estado    integer,
    id_ciudad    integer,
    id_municipio integer,
    id_colonia   integer
);

alter table tb_tiendas_sepomex
    owner to postgres;

create table tb_tipo_cuenta
(
    id_tipo_cuenta char not null
        primary key,
    descripcion    varchar(150)
);

alter table tb_tipo_cuenta
    owner to postgres;

create table tb_usuario_menu
(
    id_usuario_menu serial
        primary key,
    id_usuario      integer,
    id_menu         integer,
    acceso          integer,
    lectura         integer,
    escritura       integer
);

alter table tb_usuario_menu
    owner to postgres;

create table tb_servicios
(
    id_servicio serial
        primary key,
    descripcion varchar(255) not null,
    usuario     varchar(50)  not null,
    password    varchar(50)  not null
);

alter table tb_servicios
    owner to postgres;

create index index_tb_servicios
    on tb_servicios (id_servicio);

create function fn_actualizar_respuesta_recarga_emunah(_id_transaccion bigint, _status character varying, _cadena_respuesta text, _cve_respuesta character varying, _desc_respuesta character varying, _autorizacion character varying) returns void
    language plpgsql
as
$$
DECLARE 
	_id_cliente int;
	_costo_cliente numeric;
	_costo_emunah  numeric;
	_monto numeric;
	_id_proveedor int;
	_saldo numeric;
	BEGIN	
	
	--Actualizamos la respuesta de nuestra recarga.
	update tb_solicitudes_recargas
		   set status = _status,
		   fecha_respuesta = current_timestamp,
		   respuesta=_cadena_respuesta,
		   descripcion_respuesta = _desc_respuesta,
		   cve_respuesta = _cve_respuesta,
		   autorizacion = _autorizacion
	where id_solicitud = _id_transaccion;
	
	
	if(_status = 'E')
	then
		--Obtenemos la información de la recarga.
		select into _id_cliente,_costo_cliente,_costo_emunah,_monto,_id_proveedor
					s.id_cliente,
					s.costo_cliente,
					s.costo_proveedor,
					s.monto,
					s.id_proveedor
					from tb_solicitudes_recargas s 
					where id_solicitud = _id_transaccion;

		--Obtenemos la información de la cuenta.	
		select into _saldo
					c.saldo
					from tb_cuentas c
					where id_cliente = _id_cliente
					and servicio = '0'
					and id_proveedor = _id_proveedor;
				
		--Validamos que el saldo de la cuenta sea mayor al costo de la recarga.
		if(_saldo >= _costo_cliente)
		then

				--Actualizamos el saldo de la cuenta del cliente.
				update tb_cuentas set saldo = saldo - _costo_cliente
				where id_cliente = _id_cliente
					  and servicio = '0'
				      and id_proveedor = _id_proveedor;
					  
					  
				--Actualizamos el saldo de la cuenta del proveedor.
				update tb_cuentas set saldo = saldo - _costo_emunah
				where id_cliente is null
				  		and servicio = '0'
				  		and id_proveedor = _id_proveedor;	
		end if;
	end if;						
END;
$$;

alter function fn_actualizar_respuesta_recarga_emunah(bigint, varchar, text, varchar, varchar, varchar) owner to postgres;

create function fn_actualizar_respuesta_recarga_multired(_id_transaccion bigint, _status character varying, _cadena_respuesta text, _cve_respuesta character varying, _desc_respuesta character varying, _autorizacion character varying) returns void
    language plpgsql
as
$$
DECLARE 
	_id_cliente int;
	_costo_cliente numeric;
	_costo_emunah  numeric;
	_monto numeric;
	_id_proveedor int;
	_saldo numeric;
	BEGIN	
	
	--Actualizamos la respuesta de nuestra recarga.
	update tb_solicitudes_recargas
		   set status = _status,
		   fecha_respuesta = current_timestamp,
		   respuesta=_cadena_respuesta,
		   descripcion_respuesta = _desc_respuesta,
		   cve_respuesta = _cve_respuesta,
		   autorizacion = _autorizacion
	where id_solicitud = _id_transaccion;
	
	
	if(_status = 'E')
	then
		--Obtenemos la información de la recarga.
		select into _id_cliente,_costo_cliente,_costo_emunah,_monto,_id_proveedor
					s.id_cliente,
					s.costo_cliente,
					s.costo_proveedor,
					s.monto,
					s.id_proveedor
					from tb_solicitudes_recargas s 
					where id_solicitud = _id_transaccion;
					
	 	raise notice 'Costo cliente %', _costo_cliente;
		raise notice 'Costo emunah %', _costo_emunah;
	 	raise notice 'Costo cliente %', _id_cliente;
	 	raise notice 'Costo cliente %', _id_transaccion;

		

		--Obtenemos la información de la cuenta.	
		select into _saldo
					c.saldo
					from tb_cuentas c
					where id_cliente = _id_cliente
					and servicio = '0'
					and id_proveedor = _id_proveedor;
				
		raise notice 'Saldo %', _saldo;

		--Validamos que el saldo de la cuenta sea mayor al costo de la recarga.
		if(_saldo >= _costo_cliente)
		then

				--Actualizamos el saldo de la cuenta del cliente.
				update tb_cuentas set saldo = saldo - _costo_cliente
				where id_cliente = _id_cliente
					  and servicio = '0'
				      and id_proveedor = _id_proveedor;
					  
					  
				--Actualizamos el saldo de la cuenta del proveedor.
				update tb_cuentas set saldo = saldo - _costo_emunah
				where id_cliente is null
				  		and servicio = '0'
				  		and id_proveedor = _id_proveedor;	
		end if;
	end if;						
END;
$$;

alter function fn_actualizar_respuesta_recarga_multired(bigint, varchar, text, varchar, varchar, varchar) owner to postgres;

create function fn_actualizar_respuesta_servicio_emunah(_id_transaccion bigint, _status character varying, _cadena_respuesta text, _cve_respuesta character varying, _desc_respuesta character varying, _autorizacion character varying) returns void
    language plpgsql
as
$$
DECLARE 
	BEGIN	
	--Actualizamos la respuesta de servicio
	update tb_solicitudes_servicios
		   set status = _status,
		   fecha_respuesta = current_timestamp,
		   respuesta=_cadena_respuesta,
		   descripcion_respuesta = _desc_respuesta,
		   autorizacion = _autorizacion,
		   cve_respuesta = _cve_respuesta
	where id_solicitud = _id_transaccion;				
END;
$$;

alter function fn_actualizar_respuesta_servicio_emunah(bigint, varchar, text, varchar, varchar, varchar) owner to postgres;

create function fn_automatico_reporte_sefiplan_nombre(fecha_inicio character varying, fecha_fin character varying)
    returns TABLE(dato text)
    language plpgsql
as
$$
begin
	return query
	select 
	'CR'||''|| to_char((now()::date - interval '1 days')::date,'DDMMYY')::varchar as DATO;		
	end;
$$;

alter function fn_automatico_reporte_sefiplan_nombre(varchar, varchar) owner to postgres;

create function fn_consultar_recarga_emunah(_tienda character varying, _terminal character varying, _telefono character varying)
    returns TABLE(id_ticket bigint, clave_respuesta character varying, descripcion_respuesta text, autorizacion character varying)
    language plpgsql
as
$$
DECLARE 	
	BEGIN	 	
		return query
		select 
		s.id_ticket,
		s.cve_respuesta, 
		s.descripcion_respuesta, 
		s.autorizacion
		from tb_solicitudes_recargas s
		inner join tb_tiendas t on t.id_tienda = _tienda ::integer
		inner join tb_terminales tt on tt.id_terminal = s.id_terminal --and tt.alias = _terminal ::integer
		where s.referencia = _telefono
		order by fecha desc
		limit 1;
END;
$$;

alter function fn_consultar_recarga_emunah(varchar, varchar, varchar) owner to postgres;

create function fn_consultar_recarga_emunah_rest(_tienda character varying, _terminal character varying, _telefono character varying, _ticket bigint)
    returns TABLE(id_ticket bigint, clave_respuesta character varying, descripcion_respuesta text, autorizacion character varying)
    language plpgsql
as
$$
DECLARE 	
	BEGIN	 	
		return query
		select 
		s.id_ticket,
		s.cve_respuesta, 
		s.descripcion_respuesta, 
		s.autorizacion
		from tb_solicitudes_recargas s
		inner join tb_tiendas t on t.id_tienda = _tienda ::integer
		inner join tb_terminales tt on tt.id_terminal = s.id_terminal --and tt.alias = _terminal ::integer
		where s.referencia = _telefono
		and s.id_ticket = _ticket
		order by fecha desc
		limit 1;
END;
$$;

alter function fn_consultar_recarga_emunah_rest(varchar, varchar, varchar, bigint) owner to postgres;

create function fn_consultar_servicio_emunah(_tienda character varying, _terminal character varying, _referencia character varying)
    returns TABLE(id_ticket bigint, clave_respuesta character varying, descripcion_respuesta text, autorizacion character varying)
    language plpgsql
as
$$
DECLARE 	
	BEGIN	 	
		return query
		select s.id_ticket, s.cve_respuesta, s.descripcion_respuesta, s.autorizacion
		from tb_solicitudes_servicios s
		inner join tb_tiendas t on t.id_tienda = _tienda ::integer
		inner join tb_terminales tt on tt.id_terminal = s.id_terminal and tt.alias = _terminal ::integer
		where s.reference_billing = _referencia
		order by fecha desc limit 1;			
END;
$$;

alter function fn_consultar_servicio_emunah(varchar, varchar, varchar) owner to postgres;

create function fn_consultar_servicio_emunah_rest(_tienda character varying, _terminal character varying, _referencia character varying, _ticket bigint)
    returns TABLE(id_ticket bigint, clave_respuesta character varying, descripcion_respuesta text, autorizacion character varying)
    language plpgsql
as
$$
DECLARE 	
	BEGIN	 	
		return query
		select s.id_ticket, s.cve_respuesta, s.descripcion_respuesta, s.autorizacion
		from tb_solicitudes_servicios s
		inner join tb_tiendas t on t.id_tienda = _tienda ::integer
		inner join tb_terminales tt on tt.id_terminal = s.id_terminal and tt.alias = _terminal ::integer
		where s.reference_billing = _referencia
		and s.id_ticket = _ticket
		order by fecha desc limit 1;			
END;
$$;

alter function fn_consultar_servicio_emunah_rest(varchar, varchar, varchar, bigint) owner to postgres;

create function fn_inserta_movimientos_en_cuenta(_tipo_movimeinto character varying, _cuenta_origen integer, _cuenta_destino integer, _monto numeric, _numero_factura character varying, _referencia character varying, _fecha_documento timestamp without time zone, _usuario integer) returns boolean
    language plpgsql
as
$$
BEGIN

		INSERT INTO tb_movimientos_saldos(tipo_movimiento,cuenta_origen,cuenta_destino,monto,num_factura,referencia,fecha_documento,usuario_alta,fecha_alta)
		values (_tipo_movimeinto,_cuenta_origen,_cuenta_destino,_monto,_numero_factura,_referencia,_fecha_documento,_usuario,now());
		
		IF _tipo_movimeinto = 'E' then
		 	update tb_cuentas set saldo = saldo + _monto where id_cuenta = _cuenta_origen;
			end if;
		IF _tipo_movimeinto = 'S' then
			update tb_cuentas set saldo = saldo - _monto where id_cuenta = _cuenta_origen;
			end if;
		IF _tipo_movimeinto = 'T' then
			update tb_cuentas set saldo = saldo + _monto where id_cuenta = _cuenta_destino;
			end if;
		
		return true;	
END;
$$;

alter function fn_inserta_movimientos_en_cuenta(varchar, integer, integer, numeric, varchar, varchar, timestamp, integer) owner to postgres;

create function fn_inserta_recargas_emunah(_uuid character varying, _sku character varying, _id_cliente integer, _tienda character varying, _terminal character varying, _id_cajero integer, _id_ticket character varying, _referencia character varying, _monto numeric, _operacion character varying, _id_proveedor integer) returns character varying
    language plpgsql
as
$$
DECLARE
	id_transaccion bigint default -2;
	_id_tienda integer default 0;
	_id_terminal integer default 0;
	_fecha timestamp default now();
	idproducto integer;
	id_producto_multired integer;
	costo_cliente decimal default 0;
	costo_emunah decimal default 0;
	numero_de_recargas integer;
	telefonia integer;
	saldo decimal default -1;
	saldo_emunah decimal default 0;
	begin
	
	--Obtenemos el Id de tienda y terminal.	
	raise notice 'Obtenemos el Id de tienda y terminal.	'; 
	select into _id_tienda, _id_terminal
	t.id_tienda, tt.id_terminal
	from c_clientes c 
	inner join tb_tiendas t on c.id_cliente = t.id_cliente
	inner join tb_terminales tt on t.id_tienda = tt.id_tienda
	where 
	t.alias = _tienda::integer 
	and tt.alias = _terminal::integer
	and c.id_cliente = _id_cliente;
	
	raise notice 'tienda %',_id_tienda;
	raise notice 'terminal %',_id_terminal;

	--Obtenemos el Id del producto.
	select into idproducto 
	p.id_producto
	from c_productos p
	inner join tb_subcategorias subc on subc.id_subcategoria = p.id_subcategoria and subc.id_categoria = 8
	where
	p.sku = _sku;
	
	if idproducto is null
	then
		raise exception 'No se encontró el sku del producto: %', _sku;
	end if;
	
	raise notice 'id_producto %',idproducto;
	
	--Obtenemos la telefonia.	
	select into telefonia
	pt.id_telefonia
	from producto_telefonia pt 
	where 
	pt.id_producto = idproducto;
	
	raise notice 'telefonia %',telefonia;

	
	--Obtenemos el costo del cliente.
	select into costo_cliente
	cr.costo	
	from tb_costo_recargas_clientes cr
	where
	cr.monto = _monto
	and cr.id_cliente = _id_cliente
	and cr.status = 'A'
	and cr.id_telefonia = telefonia;
	
	raise notice 'costo_cliente %',costo_cliente;
	
	
	--Obtenemos el costo de emunah	
	select into costo_emunah
	cr.costo	
	from tb_costo_recargas_clientes cr
	where
	cr.monto = _monto
	and cr.id_cliente = 2
	and cr.status = 'A'
	and cr.id_telefonia = telefonia;
	
	--Obtenemos el saldo del cliente.
	select into saldo 
	coalesce(c.saldo,0.00) - _monto
	from tb_cuentas c
	where 
	c.id_cliente = _id_cliente
	and c.servicio = '0'
	and c.id_proveedor = _id_proveedor;
	
	--Obtenemos el saldo de emunah
	select into saldo_emunah
	coalesce(c.saldo,0.00) - _monto
	from tb_cuentas c
	where 
	c.id_cliente is null
	and c.servicio = '0'
	and c.id_proveedor = _id_proveedor;
	
	--Validamos el saldo del cliente(ej 724)
	IF saldo <= 0 THEN
		RETURN '-1';
	END IF;
	
	--Validamos el saldo de emunah(proveedor)
	IF saldo_emunah <= 0 THEN
		RETURN '-1';
	END IF;
	
	IF(costo_cliente != 0) THEN
	
		--Obtenemos el numero de recargas hechas con un monto mayor o igual a 200
		select into numero_de_recargas 
		count(id_solicitud)
		from tb_solicitudes_recargas s
		where 
		s.id_tienda = _id_tienda
		and fecha between current_timestamp + (1||'minutes')::interval and _fecha 
		and monto >= 200;
		
		IF numero_de_recargas < 3 THEN
		
			--Insertamos la solicitud de recarga
			INSERT INTO tb_solicitudes_recargas(operacion,status,fecha_envio,fecha,id_producto,id_cliente,id_tienda,id_terminal
				,id_cajero,id_ticket,referencia,monto,costo_cliente,costo_proveedor,id_proveedor)			
				values(_operacion,'T',now()::timestamp,now()::timestamp,idproducto,_id_cliente,_id_tienda,_id_terminal,_id_cajero,
					  _id_ticket::bigint,_referencia,COALESCE(_monto,0.00),COALESCE(costo_cliente,0.00),COALESCE(costo_emunah,0.00),_id_proveedor)
					  returning id_solicitud into id_transaccion;
					  
					  insert into tb_solicitudes_multired_recargas(id_transaccion,uuid) values (id_transaccion,_uuid);
								
					  return id_transaccion;
		ELSE
			--Insertamos en la tabla un posible fraude.
			insert into tb_fraudes(id_tienda,fecha,monto,referencia)
			values(id_tienda,_fecha,_monto,_referencia);
			
		END IF;		
	END IF;	
	return id_transaccion;
END;
$$;

alter function fn_inserta_recargas_emunah(varchar, varchar, integer, varchar, varchar, integer, varchar, varchar, numeric, varchar, integer) owner to postgres;

create function fn_insertar_solicitud_consulta_servicios_emunah(_operacion character varying, _tienda character varying, _terminal character varying, _id_cliente character varying, _sku character varying, _fecha timestamp without time zone, _id_cajero character varying, _id_ticket character varying, _id_proveedor integer, _referencia character varying, _referencia_servicio character varying, _solicitud text) returns character varying
    language plpgsql
as
$$
DECLARE
	_id_tienda integer;
	_id_terminal integer;
	 idproducto integer;
	_id_transaccion varchar;
BEGIN
	--Obtenemos el Id de tienda y terminal.	
	select into _id_tienda, _id_terminal
	t.id_tienda, tt.id_terminal
	from c_clientes c 
	inner join tb_tiendas t on c.id_cliente = t.id_cliente
	inner join tb_terminales tt on t.id_tienda = tt.id_tienda
	where 
	t.alias = _tienda::integer 
	and tt.alias = _terminal::integer
	and c.id_cliente = _id_cliente::INTEGER;
		
	--Obtenemos el Id del producto.
	select into idproducto 
	p.id_producto
	from c_productos p
	where
	p.sku = _sku;

	insert into tb_solicitudes_servicios(operacion,status,fecha,fecha_envio,id_producto,id_cliente,id_tienda,id_terminal,id_cajero,id_ticket,id_proveedor,referencia,reference_billing,solicitud_json,
										product_id)values
	(_operacion,'T',now()::timestamp,now()::timestamp,idproducto,_id_cliente::integer,_id_tienda,_id_terminal,_id_cajero::integer,_id_ticket::bigint,_id_proveedor,_referencia,_referencia_servicio,_solicitud,_sku)
	
	returning id_solicitud into _id_transaccion;
	
	return _id_transaccion;		
END;
$$;

alter function fn_insertar_solicitud_consulta_servicios_emunah(varchar, varchar, varchar, varchar, varchar, timestamp, varchar, varchar, integer, varchar, varchar, text) owner to postgres;

create function fn_insertar_solicitud_servicios_emunah(_operacion character varying, _tienda character varying, _terminal character varying, _id_cliente character varying, _sku character varying, _fecha timestamp without time zone, _id_cajero character varying, _id_ticket character varying, _id_proveedor integer, _referencia character varying, _referencia_servicio character varying, _solicitud text, _uuid character varying) returns character varying
    language plpgsql
as
$$
DECLARE
	_id_tienda integer;
	_id_terminal integer;
	 idproducto integer;
	_id_transaccion varchar;
BEGIN
	--Obtenemos el Id de tienda y terminal.	
	select into _id_tienda, _id_terminal
	t.id_tienda, tt.id_terminal
	from c_clientes c 
	inner join tb_tiendas t on c.id_cliente = t.id_cliente
	inner join tb_terminales tt on t.id_tienda = tt.id_tienda
	where 
	t.alias = _tienda::integer 
	and tt.alias = _terminal::integer
	and c.id_cliente = _id_cliente::INTEGER;
		
	--Obtenemos el Id del producto.
	select into idproducto 
	p.id_producto
	from c_productos p
	where
	p.sku = _sku;

	insert into tb_solicitudes_servicios(operacion,status,fecha,fecha_envio,id_producto,id_cliente,id_tienda,id_terminal,id_cajero,id_ticket,id_proveedor,referencia,reference_billing,solicitud_json,
										product_id)values
	(_operacion,'T',now()::timestamp,now()::timestamp,idproducto,_id_cliente::integer,_id_tienda,_id_terminal,_id_cajero::integer,_id_ticket::bigint,_id_proveedor,_referencia,_referencia_servicio,_solicitud,_sku)
	
	returning id_solicitud into _id_transaccion;
	
	return _id_transaccion;		
END;
$$;

alter function fn_insertar_solicitud_servicios_emunah(varchar, varchar, varchar, varchar, varchar, timestamp, varchar, varchar, integer, varchar, varchar, text, varchar) owner to postgres;

create function fn_insertar_solicitud_servicios_emunah(_operacion character varying, _tienda character varying, _terminal character varying, _id_cliente character varying, _sku character varying, _fecha timestamp without time zone, _id_cajero character varying, _id_ticket character varying, _id_proveedor integer, _referencia character varying, _referencia_servicio character varying, _solicitud text, _uuid character varying, _monto numeric) returns character varying
    language plpgsql
as
$$
DECLARE
	_id_tienda integer;
	_id_terminal integer;
	 idproducto integer;
	_id_transaccion varchar;
BEGIN
	--Obtenemos el Id de tienda y terminal.	
	select into _id_tienda, _id_terminal
	t.id_tienda, tt.id_terminal
	from c_clientes c 
	inner join tb_tiendas t on c.id_cliente = t.id_cliente
	inner join tb_terminales tt on t.id_tienda = tt.id_tienda
	where 
	t.alias = _tienda::integer 
	and tt.alias = _terminal::integer
	and c.id_cliente = _id_cliente::INTEGER;
		
	--Obtenemos el Id del producto.
	select into idproducto 
	p.id_producto
	from c_productos p
	where
	p.sku = _sku;

	insert into tb_solicitudes_servicios(operacion,status,fecha,fecha_envio,id_producto,id_cliente,id_tienda,id_terminal,id_cajero,id_ticket,id_proveedor,referencia,reference_billing,solicitud_json,
										product_id,monto)values
	(_operacion,'T',now()::timestamp,now()::timestamp,idproducto,_id_cliente::integer,_id_tienda,_id_terminal,_id_cajero::integer,_id_ticket::bigint,_id_proveedor,_referencia,_referencia_servicio,_solicitud,_sku,_monto)
	
	returning id_solicitud into _id_transaccion;
	
	insert into tb_solicitudes_multired_servicios(id_transaccion,uuid) values (_id_transaccion::bigint,_uuid);
	
	return _id_transaccion;		
END;
$$;

alter function fn_insertar_solicitud_servicios_emunah(varchar, varchar, varchar, varchar, varchar, timestamp, varchar, varchar, integer, varchar, varchar, text, varchar, numeric) owner to postgres;

create function fn_solicitudes_reporte_recarga_top()
    returns TABLE(id_solicitud bigint, fecha timestamp without time zone, fecha_respuesta timestamp without time zone, diferencia double precision, telefonia character varying, cliente character varying, sucursal character varying, terminal character varying, ticket bigint, referencia character varying, monto numeric, costo_proveedor numeric, costo_cliente numeric, estatus character varying, clave_respuesta character varying, descripcion_respuesta text, autorizacion character varying, caja character varying, producto character varying)
    language plpgsql
as
$$
DECLARE 	
	begin
	return query
	SELECT 
		sol.id_solicitud,
		sol.fecha,
		sol.fecha_respuesta,
		extract(Epoch from (sol.fecha::timestamp - sol.fecha_envio::timestamp)) diferencia,
		tel.descripcion as telefonia,
		c.nombre as cliente,
		suc.nombre as sucursal,
		ter.descripcion as terminal, 
		sol.id_ticket,
		sol.referencia,
		sol.monto,
		sol.costo_proveedor,
		sol.costo_cliente ,
		CASE 
			WHEN sol.cve_respuesta = '0' then 'aprobada'
			WHEN sol.cve_respuesta != '0' then 'error'
		END::varchar estatus,
		sol.cve_respuesta as validacion,
		sol.descripcion_respuesta,
		sol.autorizacion,
		ter.descripcion  as caja,
		prod.descripcion::VARCHAR as producto
	FROM tb_solicitudes_recargas as sol
	LEFT JOIN c_clientes c  on c.id_cliente = sol.id_cliente
	LEFT JOIN tb_terminales as ter on ter.id_terminal = sol.id_terminal
	LEFT JOIN tb_tiendas as suc on suc.id_tienda = sol.id_tienda
	LEFT JOIN producto_telefonia pt on pt.id_producto = sol.id_producto
	LEFT JOIN c_productos as prod on prod.id_producto = sol.id_producto
	LEFT JOIN tb_telefonias as tel on tel.id_telefonia = pt.id_telefonia
		
	order by sol.id_solicitud desc  limit 20;
end;
$$;

alter function fn_solicitudes_reporte_recarga_top() owner to postgres;

create function fn_solicitudes_reporte_recargas(_sucursal integer, _fecha_inicio character varying, _fecha_final character varying)
    returns TABLE(id_solicitud bigint, fecha timestamp without time zone, fecha_respuesta timestamp without time zone, diferencia double precision, telefonia character varying, cliente character varying, sucursal character varying, terminal character varying, ticket bigint, referencia character varying, monto numeric, costo_proveedor numeric, costo_cliente numeric, estatus character varying, clave_respuesta character varying, descripcion_respuesta text, autorizacion character varying, caja character varying, producto character varying)
    language plpgsql
as
$$
DECLARE 	
	begin
	return query
		SELECT 
		sol.id_solicitud,
		sol.fecha,
		sol.fecha_respuesta,
		extract(Epoch from (sol.fecha::timestamp - sol.fecha_envio::timestamp)) diferencia,
		tel.descripcion as telefonia,
		c.nombre as cliente,
		suc.nombre as sucursal,
		ter.descripcion as terminal, 
		sol.id_ticket,
		sol.referencia,
		sol.monto,
		sol.costo_proveedor,
		sol.costo_cliente ,
		CASE 
			WHEN sol.cve_respuesta = '0' then 'aprobada'
			WHEN sol.cve_respuesta != '0' then 'error'
		END::varchar estatus,
		sol.cve_respuesta as validacion,
		sol.descripcion_respuesta,
		sol.autorizacion,
		ter.descripcion  as caja,
		prod.descripcion::VARCHAR as producto
	FROM tb_solicitudes_recargas as sol
	LEFT JOIN c_clientes c  on c.id_cliente = sol.id_cliente
	LEFT JOIN tb_terminales as ter on ter.id_terminal = sol.id_terminal
	LEFT JOIN tb_tiendas as suc on suc.id_tienda = sol.id_tienda
	LEFT JOIN producto_telefonia pt on pt.id_producto = sol.id_producto
	LEFT JOIN c_productos as prod on prod.id_producto = sol.id_producto
	LEFT JOIN tb_telefonias as tel on tel.id_telefonia = pt.id_telefonia
		WHERE
		suc.alias = case when _sucursal = 0 then suc.alias else _sucursal end and
		sol.fecha::date between _fecha_inicio::date and _fecha_final::date;
end;
$$;

alter function fn_solicitudes_reporte_recargas(integer, varchar, varchar) owner to postgres;

create function fn_solicitudes_reporte_recargas(_telefonia integer DEFAULT 0, _cliente integer DEFAULT 0, _tienda integer DEFAULT 0, _telefono character varying DEFAULT ''::character varying, _fecha_inicio character varying DEFAULT ''::character varying, _fecha_fin character varying DEFAULT ''::character varying)
    returns TABLE(id_solicitud bigint, fecha timestamp without time zone, fecha_respuesta timestamp without time zone, diferencia double precision, telefonia character varying, cliente character varying, sucursal character varying, terminal character varying, ticket bigint, referencia character varying, monto numeric, costo_proveedor numeric, costo_cliente numeric, estatus character varying, clave_respuesta character varying, descripcion_respuesta text, autorizacion character varying)
    language plpgsql
as
$$
DECLARE 	
	BEGIN	 	
	
		IF  _fecha_inicio  = '' THEN		
			return query
			select 
			s.id_solicitud,
			s.fecha,
			s.fecha_Respuesta,
		    extract(Epoch from (s.fecha::timestamp - s.fecha_envio::timestamp)),
			tel.descripcion,
			c.nombre,
			t.nombre,
			tt.descripcion,
			s.id_ticket,
			s.referencia,
			s.monto,
			s.costo_proveedor,
			s.costo_cliente,
			es.descripcion, 
			s.cve_respuesta,
			s.descripcion_respuesta,
			s.autorizacion
			from tb_solicitudes_recargas s
			left join c_clientes c  on c.id_cliente = s.id_cliente
			left join tb_tiendas t on  t.id_tienda = s.id_tienda
			left join tb_terminales tt on tt.id_terminal = s.id_terminal
			left join producto_telefonia pt on pt.id_producto = s.id_producto
			left join tb_telefonias tel on tel.id_telefonia = pt.id_telefonia
			left join c_estatus es on es.status = s.status
			where s.operacion = 'E' 
			--and tel.id_telefonia = case when _telefonia = 0 then tel.id_telefonia else _telefonia end
		    --and s.id_cliente = case when _cliente  = 0 then s.id_cliente else _cliente end
			--and s.id_tienda = case	when _tienda  = 0 then s.id_tienda else _tienda end
			--and s.referencia = case when _telefono  = ''  then s.referencia  else _telefono end
			and s.fecha::date  between now()::date and now()::date
			order by fecha desc limit 20;
			ELSE
			return query
			select 
			s.id_solicitud,
			s.fecha,
			s.fecha_Respuesta,
		    extract(Epoch from (s.fecha::timestamp - s.fecha_envio::timestamp)),
			tel.descripcion,
			c.nombre,
			t.nombre,
			tt.descripcion,
			s.id_ticket,
			s.referencia,
			s.monto,
			s.costo_proveedor,
			s.costo_cliente,
			es.descripcion, 
			s.cve_respuesta,
			s.descripcion_respuesta,
			s.autorizacion
			from tb_solicitudes_recargas s
			inner join c_clientes c  on c.id_cliente = s.id_cliente
			left outer join tb_tiendas t on  t.id_tienda = s.id_tienda
			left outer join tb_terminales tt on tt.id_terminal = s.id_terminal
			left outer join producto_telefonia pt on pt.id_producto = s.id_producto
			left outer join tb_telefonias as tel on tel.id_telefonia = pt.id_telefonia
			left join c_estatus es on es.status = s.status
			where s.operacion = 'E' 
			--and tel.id_telefonia = case when _telefonia  = 0then tel.id_telefonia else _telefonia end
			--and s.id_cliente = case when _cliente  = 0  then s.id_cliente else _cliente end
			--and s.id_tienda = case	when _tienda  = 0 then s.id_tienda else _tienda end
			--and s.referencia = case when _telefono  = ''then s.referencia  else _telefono end
			and s.fecha::date  between _fecha_inicio::date and _fecha_fin::date
			order by fecha desc;				
		END IF;
END;
$$;

alter function fn_solicitudes_reporte_recargas(integer, integer, integer, varchar, varchar, varchar) owner to postgres;

create function fn_solicitudes_reporte_servicio_top()
    returns TABLE(fecha timestamp without time zone, caja character varying, sucursal character varying, ticket bigint, referencia character varying, monto numeric, estatus text, descripcion_respuesta text, autorizacion character varying, fecha_respuesta timestamp without time zone)
    language plpgsql
as
$$
DECLARE 	
	begin
	return query
	select 
	sol.fecha,
	ter.descripcion,
	suc.nombre,
	sol.id_ticket,
	sol.referencia,
	sol.monto,
	case 
		when sol.cve_respuesta = '0' then 'aprobada'
		when sol.cve_respuesta != '0' then 'error'
	end estatus,
	sol.descripcion_respuesta,
	sol.autorizacion,
	sol.fecha_respuesta
	from tb_solicitudes_recargas as sol
	left join tb_terminales as ter on ter.id_terminal = sol.id_terminal
	left join tb_tiendas as suc on suc.id_tienda = sol.id_tienda
	order by sol.id_solicitud desc  limit 20;
end;
$$;

alter function fn_solicitudes_reporte_servicio_top() owner to postgres;

create function fn_solicitudes_reporte_servicios(_sucursal integer, _fecha_inicio character varying, _fecha_final character varying)
    returns TABLE(fecha timestamp without time zone, caja character varying, sucursal character varying, ticket bigint, producto character varying, referencia character varying, monto numeric, estatus text, descripcion_respuesta text, autorizacion character varying, fecha_respuesta timestamp without time zone)
    language plpgsql
as
$$
DECLARE 	
	begin
	return query
	select 
	sol.fecha,
	ter.descripcion,
	suc.nombre,
	sol.id_ticket,
	prod.descripcion::varchar,
	sol.referencia,
	sol.monto,
	case 
		when sol.cve_respuesta = '0' then 'aprobada'
		when sol.cve_respuesta != '0' then 'error'
	end estatus,
	sol.descripcion_respuesta,
	sol.autorizacion,
	sol.fecha_respuesta
	from tb_solicitudes_servicios as sol
	left join tb_terminales as ter on ter.id_terminal = sol.id_terminal
	left join tb_tiendas as suc on suc.id_tienda = sol.id_tienda
	left join c_productos as prod on prod.id_producto = sol.id_producto
	where
	suc.alias = case when _sucursal = 0 then suc.alias else _sucursal end and
	sol.fecha::date between _fecha_inicio::date and _fecha_final::date and
	sol.operacion = 'E';

end;
$$;

alter function fn_solicitudes_reporte_servicios(integer, varchar, varchar) owner to postgres;

create function fn_solicitudes_reporte_servicios(_cliente integer DEFAULT 0, _tienda integer DEFAULT 0, _referencia character varying DEFAULT ''::character varying, _fecha_inicio character varying DEFAULT ''::character varying, _fecha_fin character varying DEFAULT ''::character varying)
    returns TABLE(id_solicitud bigint, fecha timestamp without time zone, fecha_respuesta timestamp without time zone, diferencia double precision, cliente character varying, tienda character varying, terminal character varying, id_ticket bigint, monto numeric, descripcion character varying, cve_respuesta character varying, descripcion_respuesta text, autorizacion character varying, estatus character varying, referencia_pago character varying, tipo_operacion text)
    language plpgsql
as
$$
DECLARE 	
	BEGIN	 
IF(_fecha_inicio = '') then
		return query
		select 
		s.id_solicitud,
		s.fecha,
		s.fecha_respuesta,
		extract(Epoch from (s.fecha::timestamp - s.fecha_envio::timestamp)),
		c.nombre cliente,
		t.nombre tienda,
		tt.descripcion terminal,
		s.id_ticket,
		s.monto,
		es.descripcion,
		s.cve_respuesta,
		s.descripcion_Respuesta,
		s.autorizacion,
		es.descripcion,
		s.reference_billing,
		case when s.operacion = 'E' THEN 'PAGO'
		ELSE 'CONSULTA' END 
		from tb_solicitudes_servicios s
		inner join c_clientes c on c.id_cliente = s.id_cliente
		inner join tb_tiendas t on s.id_tienda = t.id_tienda
		inner join tb_terminales tt on tt.id_terminal = s.id_terminal
		inner join c_estatus es on es.status = s.status
		where 
		--s.operacion = 'E'
		s.id_cliente = case when _cliente = 0 then s.id_cliente else _cliente end
		and s.id_tienda = case when _tienda = 0 then s.id_tienda else _tienda end
		and s.reference_billing = case when _referencia = ''  then s.reference_billing else _referencia end
		and s.fecha::date between now()::date and now()::date
		order by fecha desc limit 20;
else
		return query
		select 
		s.id_solicitud,
		s.fecha,
		s.fecha_respuesta,
		extract(Epoch from (s.fecha::timestamp - s.fecha_envio::timestamp)),
		c.nombre cliente,
		t.nombre tienda,
		tt.descripcion terminal,
		s.id_ticket,
		s.monto,
		es.descripcion,
		s.cve_respuesta,
		s.descripcion_Respuesta,
		s.autorizacion,
		es.descripcion,
		s.reference_billing,
		case when s.operacion = 'E' THEN 'PAGO' 
		ELSE 'CONSULTA' END 
		from tb_solicitudes_servicios s
		inner join c_clientes c on c.id_cliente = s.id_cliente
		inner join tb_tiendas t on s.id_tienda = t.id_tienda
		inner join tb_terminales tt on tt.id_terminal = s.id_terminal
		inner join c_estatus es on es.status = s.status
		where 
		--s.operacion = 'E'
	    s.id_cliente = case when _cliente = 0 then s.id_cliente else _cliente end
		and s.id_tienda = case when _tienda = 0 then s.id_tienda else _tienda end
		and s.reference_billing = case when _referencia  = '' then s.reference_billing else _referencia end
		and s.fecha::date  between _fecha_inicio::date and _fecha_fin::date
		order by fecha desc;

	END IF;
END;
$$;

alter function fn_solicitudes_reporte_servicios(integer, integer, varchar, varchar, varchar) owner to postgres;

create function fn_solicitudes_reporte_servicios_top()
    returns TABLE(fecha timestamp without time zone, caja character varying, sucursal character varying, ticket bigint, producto character varying, referencia character varying, monto numeric, estatus text, descripcion_respuesta text, autorizacion character varying, fecha_respuesta timestamp without time zone)
    language plpgsql
as
$$
DECLARE 	
	begin
	return query
	select 
	sol.fecha,
	ter.descripcion,
	suc.nombre,
	sol.id_ticket,
	prod.descripcion::varchar,
	sol.referencia,
	sol.monto,
	case 
		when sol.cve_respuesta = '0' then 'aprobada'
		when sol.cve_respuesta != '0' then 'error'
	end estatus,
	sol.descripcion_respuesta,
	sol.autorizacion,
	sol.fecha_respuesta
	from tb_solicitudes_servicios as sol
	left join tb_terminales as ter on ter.id_terminal = sol.id_terminal
	left join tb_tiendas as suc on suc.id_tienda = sol.id_tienda
	left join c_productos as prod on prod.id_producto = sol.id_producto
	where 
	sol.operacion = 'E'
	order by sol.id_solicitud 
	
	desc  limit 20;
end;
$$;

alter function fn_solicitudes_reporte_servicios_top() owner to postgres;

create function fn_telefonias_consultar_id_multired_xsku(_sku character varying) returns integer
    language plpgsql
as
$$
/*
* Descripción: Función que se encarga de consultar el identificador de multired a travez del codigo/sku de producto
* Autor: Ing. Jesús Pére Ramírez
* Fecha: 01/04/2022
*/

	declare
		_id_multired integer;
	begin
	
		--0.- Validación de existencia de SKU
		if not exists (select *	from c_productos as producto where producto.sku = _sku)
		then
			raise exception 'No se encontró el SKU en c_productos.';
		end if;
		
		--1.- Se obtiene el valor del identificador de multired en base al codigo del producto relacionado con la telefonía
		select telefonia.id_multired into _id_multired
		from c_productos as producto
		join producto_telefonia as prod_tel on producto.id_producto = prod_tel.id_producto
		join tb_telefonias as telefonia on prod_tel.id_telefonia = telefonia.id_telefonia
		where producto.sku = _sku;
		
		--2.- Validaciones
		if _id_multired is null
		then 
			raise exception 'No se encontró el id_multired correspondiente al código: %', _sku;				
		end if;
		
		return _id_multired;
	end;
	
	$$;

alter function fn_telefonias_consultar_id_multired_xsku(varchar) owner to postgres;

create function fn_telefonias_consultar_xsku(_sku character varying)
    returns TABLE(id_telefonia integer, descripcion character varying, id_multired integer, usuario character varying, password character varying)
    language plpgsql
as
$$
/*
* Descripción: Función que se encarga de consultar el registro de telefonía multired a travez del codigo/sku de producto
* Autor: Ing. Jesús Pére Ramírez
* Fecha: 01/04/2022
*/

	declare
		_rec_record integer;
	begin
	
		--0.- Validación de existencia de SKU
		if not exists (select *	from c_productos as producto where producto.sku = _sku)
		then
			raise exception 'No se encontró el SKU en c_productos.';
		end if;
		
		--1.- Se obtiene el valor del identificador de multired en base al codigo del producto relacionado con la telefonía
		select  telefonia.id_telefonia, telefonia.id_multired, telefonia.descripcion, telefonia.usuario, telefonia.password into _rec_record
		from c_productos as producto
		join producto_telefonia as prod_tel on producto.id_producto = prod_tel.id_producto
		join tb_telefonias as telefonia on prod_tel.id_telefonia = telefonia.id_telefonia
		where producto.sku = _sku;
		
		--2.- Validaciones
		if _rec_record is null
		then 
			raise exception 'No se encontró el registro de tb_telefonias correspondiente al código: %', _sku;				
		end if;
		
		return query   --NO PUDE RETORNAR EL RECORD, TUVE QUE MANDAR A LLAMAR DE NUEVO LA CONSULTA
		(select  telefonia.id_telefonia, telefonia.descripcion, telefonia.id_multired, telefonia.usuario, telefonia.password 
		from c_productos as producto
		join producto_telefonia as prod_tel on producto.id_producto = prod_tel.id_producto
		join tb_telefonias as telefonia on prod_tel.id_telefonia = telefonia.id_telefonia
		where producto.sku = _sku);
	
	end;
	
	$$;

alter function fn_telefonias_consultar_xsku(varchar) owner to postgres;

create function fn_valida_credenciales(_ip character varying, _mac character varying) returns boolean
    language plpgsql
as
$$
DECLARE
BEGIN
	RETURN  EXISTS(select * from tb_networks_credentials nw where nw.ip = _ip and nw.mac = _mac);
END;
$$;

alter function fn_valida_credenciales(varchar, varchar) owner to postgres;

create function fn_servicios_consultar_credenciales(_id_servicio integer)
    returns TABLE(id_servicio integer, descripcion character varying, usuario character varying, password character varying)
    language plpgsql
as
$$
--*************************************************************
-- Descripción: Función que se encarga de consultar el registro de las credenciales para servicios.
-- Autor: I.S.C Eusebio L. Zurita Hegler
-- Fecha: 26/03/2024
--**************************************************************

DECLARE		
BEGIN	
		
		if not exists (select *	from tb_servicios as servicios where servicios.id_servicio = _id_servicio)
		then
			raise exception 'No se encontró la credencial de servicios.';
		end if;
		
		RETURN query   --NO PUDE RETORNAR EL RECORD, TUVE QUE MANDAR A LLAMAR DE NUEVO LA CONSULTA
		SELECT s.id_servicio,
			   s.descripcion,
			   s.usuario,
			   s.password
		FROM tb_servicios s
		WHERE s.id_servicio = _id_servicio;
	
END;
$$;

alter function fn_servicios_consultar_credenciales(integer) owner to postgres;

