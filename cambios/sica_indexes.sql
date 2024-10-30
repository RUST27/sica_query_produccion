
-- Índices para la tabla tb_sica_catalogo_gerencias
CREATE INDEX idx_tb_sica_catalogo_gerencias_id ON public.tb_sica_catalogo_gerencias (id_gerencia);

-- Índices para la tabla tb_sica_catalogo_grupos_usuarios
CREATE INDEX idx_tb_sica_catalogo_grupos_usuarios_id ON public.tb_sica_catalogo_grupos_usuarios (id_grupo_usuario);

-- Índices para la tabla tb_sica_catalogo_departamentos
CREATE INDEX idx_tb_sica_catalogo_departamentos_id ON public.tb_sica_catalogo_departamentos (id_departamento,id_gerencia);


-- Índices para la tabla tb_sica_grupo_usuarios_responsables
CREATE INDEX idx_tb_sica_grupo_usuarios_responsables_id ON public.tb_sica_grupo_usuarios_responsables (id_grupo_usuario_responsable, id_departamento);


-- Índices para la tabla tb_sica_catalogo_clasificacion_actividades
CREATE INDEX idx_tb_sica_catalogo_clasificacion_actividades_id ON public.tb_sica_catalogo_clasificacion_actividades (id_clasificacion_actividad, id_departamento);


-- Índices para la tabla tb_sica_catalogo_grupo_actividades
CREATE INDEX idx_tb_sica_catalogo_grupo_actividades_id ON public.tb_sica_catalogo_grupo_actividades (id_grupo_actividad, id_clasificacion_actividad);


-- Índices para la tabla tb_sica_catalogo_actividades
CREATE INDEX idx_tb_sica_catalogo_actividades_id ON public.tb_sica_catalogo_actividades (id_actividad, id_grupo_actividad);


-- Índices para la tabla tb_sica_atenciones
CREATE INDEX idx_tb_sica_atenciones_id_sucursal_id_atencion ON public.tb_sica_atenciones (id_sucursal, id_atencion); 


-- Índices para la tabla tb_sica_mensajes
CREATE INDEX idx_tb_sica_mensajes_id ON public.tb_sica_mensajes (id_mensaje);
CREATE INDEX idx_tb_sica_mensajes_id_atencion_id_sucursal ON public.tb_sica_mensajes (id_atencion, id_sucursal, id_usuario_creacion); 


-- Índices para la tabla tb_sica_transferencias_atenciones
CREATE INDEX idx_tb_sica_transferencias_atenciones_id ON public.tb_sica_transferencias_atenciones (id_transferencia,id_atencion, id_sucursal);


-- Índices para la tabla tb_sica_catalogo_usuarios_sica
CREATE INDEX idx_tb_sica_catalogo_usuarios_sica_id ON public.tb_sica_catalogo_usuarios_sica (id_usuario_sica);



CREATE OR REPLACE function fn_sica_atenciones_obtener_por_creador(p_id_usuario integer)
    returns TABLE(id_atencion bigint, ticket character varying, asunto character varying, usuario_reporto character varying, fecha_inicio timestamp without time zone, estatus_descripcion character varying, usuario_grupo_asignado character varying, id_sucursal integer, descripcion_sucursal character varying)
    language plpgsql
as
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
        --a.usuario_reporta = p_id_usuario
         a.id_estatus IN (1, 2, 3);
END;
$$;

alter function fn_sica_atenciones_obtener_por_creador(integer) owner to postgres;


CREATE OR REPLACE function fn_sica_atenciones_filtrar_por_usuario_reporta(p_id_usuario integer, p_estado integer DEFAULT NULL::integer, p_sucursal integer DEFAULT NULL::integer, p_departamento integer DEFAULT NULL::integer, p_fecha_inicio timestamp without time zone DEFAULT NULL::timestamp without time zone, p_fecha_fin timestamp without time zone DEFAULT NULL::timestamp without time zone, p_ticket character varying DEFAULT NULL::character varying)
    returns TABLE(id_atencion bigint, ticket character varying, asunto character varying, usuario_reporto character varying, usuario_grupo_asignado character varying, fecha_inicio timestamp without time zone, estatus_descripcion character varying, id_sucursal integer, descripcion_sucursal character varying)
    language plpgsql
as
$$
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
        --a.usuario_reporta = p_id_usuario  -- Asegura que el usuario sea el que reportó la atención
        (p_estado IS NULL OR a.id_estatus = p_estado)
        AND (p_sucursal IS NULL OR a.id_sucursal = p_sucursal)
        AND (p_departamento IS NULL OR a.id_departamento_actual = p_departamento)
        AND (p_fecha_inicio IS NULL OR a.fecha_inicio >= p_fecha_inicio)
        AND (p_fecha_fin IS NULL OR a.fecha_inicio < p_fecha_fin + interval '1 day')
        AND (p_ticket IS NULL OR a.ticket ILIKE '%' || p_ticket || '%');
END;
$$;

alter function fn_sica_atenciones_filtrar_por_usuario_reporta(integer, integer, integer, integer, timestamp, timestamp, varchar) owner to postgres;


