
CREATE OR REPLACE FUNCTION public.fn_sica_mensaje_insertar_para_oficinas(
    p_descripcion text,
    p_es_interno boolean,
    p_id_atencion bigint,
    p_id_usuario_creacion integer,
    p_id_sucursal integer)
RETURNS integer
LANGUAGE 'plpgsql'
COST 100
VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    v_id_mensaje bigint;
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
        --id_mensaje,
        id_atencion,
        id_sucursal,
        descripcion,
        fecha_creacion,
        es_interno,
        id_usuario_creacion
    )
    VALUES (
        --nextval('public.tb_sica_mensajes_id_mensaje_seq'),  -- Usar la secuencia para id_mensaje
        p_id_atencion,
        p_id_sucursal,
        p_descripcion,
        CURRENT_TIMESTAMP,
        p_es_interno,
        p_id_usuario_creacion
    ) RETURNING id_mensaje INTO v_id_mensaje;

    -- Generar el JSONB del nuevo registro para consolidación
    SELECT to_jsonb(t) INTO _json
    FROM public.tb_sica_mensajes t
    WHERE t.id_mensaje = v_id_mensaje
      AND t.id_atencion = p_id_atencion
      AND t.id_sucursal = p_id_sucursal;

    -- Llamar a la función de consolidación para enviar el registro a oficinas
    PERFORM public.fn_consolidador_registrarmovimiento_para_oficinas(
        _json,
        'i',  -- Tipo de movimiento "i" (insert)
        'tb_sica_mensajes',
        NULL
    );

    -- Ejecutar la función para marcar la atención como "En Ejecución"
    --PERFORM public.fn_sica_atencion_en_ejecucion(p_id_atencion, p_id_sucursal);

    -- Devolver el ID del mensaje insertado
    RETURN v_id_mensaje;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al insertar mensaje para oficinas o marcar la atención como en ejecución: %', SQLERRM;
END;
$BODY$;

ALTER FUNCTION public.fn_sica_mensaje_insertar_para_oficinas(text, boolean, bigint, integer, integer)
    OWNER TO postgres;




CREATE OR REPLACE FUNCTION sica_mensajes_obtener_por_id_atencion_2(p_id_atencion bigint, p_id_sucursal integer)
    RETURNS TABLE(
        descripcion_origen character varying,
        id_atencion bigint,
        id_mensaje bigint,
        descripcion_mensaje text,
        fecha_creacion timestamp without time zone,
        es_interno boolean,
        nombre_usuario character varying
    )
    LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT
        CASE
            WHEN msg.es_interno THEN dep.descripcion
            ELSE suc.descripcion
        END AS descripcion_origen,
        msg.id_atencion,
        msg.id_mensaje,
        msg.descripcion AS descripcion_mensaje,
        msg.fecha_creacion,
        msg.es_interno,
        usr.nombre AS nombre_usuario
    FROM
        public.tb_sica_mensajes msg
    JOIN
        public.tb_sica_atenciones atn ON msg.id_atencion = atn.id_atencion
    JOIN
        public.tb_sica_catalogo_departamentos dep ON atn.id_departamento_actual = dep.id_departamento
    JOIN
        public.tb_catalogo_sucursales suc ON msg.id_sucursal = suc.id_sucursal
    JOIN
        public.tb_catalogo_usuarios usr ON msg.id_usuario_creacion = usr.id_usuario
    WHERE
        msg.id_atencion = p_id_atencion
        AND msg.id_sucursal = p_id_sucursal;
END;
$$;

ALTER FUNCTION sica_mensajes_obtener_por_id_atencion_2(bigint, integer) OWNER TO postgres;



CREATE OR REPLACE FUNCTION public.sica_mensajes_obtener_por_id_atencion_2(
	p_id_atencion bigint,
	p_id_sucursal integer)
    RETURNS TABLE(
        descripcion_origen character varying,
        id_atencion bigint,
        id_mensaje bigint,
        descripcion_mensaje text,
        fecha_creacion timestamp without time zone,
        es_interno boolean,
        nombre_usuario character varying
    )
    LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    RETURN QUERY
    SELECT 
        CASE
            WHEN msg.es_interno THEN (
                SELECT dep.descripcion
                FROM public.tb_sica_catalogo_departamentos dep
                JOIN public.tb_sica_atenciones atn ON dep.id_departamento = atn.id_departamento_actual
                WHERE atn.id_atencion = msg.id_atencion
                LIMIT 1
            )
            ELSE suc.descripcion
        END AS descripcion_origen,
        msg.id_atencion,
        msg.id_mensaje,
        msg.descripcion AS descripcion_mensaje,
        msg.fecha_creacion,
        msg.es_interno,
        usr.nombre AS nombre_usuario
    FROM
        public.tb_sica_mensajes msg
    JOIN
        public.tb_catalogo_usuarios usr ON msg.id_usuario_creacion = usr.id_usuario
    LEFT JOIN
        public.tb_catalogo_sucursales suc ON msg.id_sucursal = suc.id_sucursal
    WHERE
        msg.id_atencion = p_id_atencion
        AND msg.id_sucursal = p_id_sucursal;
END;
$BODY$;

ALTER FUNCTION public.sica_mensajes_obtener_por_id_atencion_2(bigint, integer)
    OWNER TO postgres;
