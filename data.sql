


-- <=======================================================Datos tablas sica ==========================================================>

-- datos a insertar en tablas

--INSERT INTO public.tb_catalogo_tablas (descripcion, consolidacion_global, es_movimiento, tiene_secuencia)
--VALUES 
    --('tb_sica_catalogo_gerencias', true, false, true),
    --('tb_sica_catalogo_grupos_usuarios', true, false, true),
    --('tb_sica_catalogo_departamentos', true, false, true),
    --('tb_sica_grupo_usuarios_responsables', true, false, true),
    --('tb_sica_relacion_usuarios_grupo_responsables', true, false, false),
    --('tb_sica_catalogo_clasificacion_actividades', true, false, true),
    --('tb_sica_catalogo_grupo_actividades', true, false, true),
    --('tb_sica_catalogo_actividades', true, false, true),
    --('tb_sica_catalogo_estatus', true, false, true),
    --('tb_sica_catalogo_usuarios_sica', true, false, true),
    --('tb_sica_atenciones', false, true, true),
    --('tb_sica_mensajes', false, true, true),
    --('tb_sica_transferencias_atenciones', false, true, true);

INSERT INTO public.tb_sica_catalogo_estatus (descripcion, clave, fecha_creacion, fecha_modificacion)
VALUES
    ('Nuevo', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Leído', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Ejecución', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Observaciones', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Cancelado', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Cerrado', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO public.tb_sica_catalogo_grupos_usuarios (descripcion, fecha_creacion, fecha_modificacion, baja)
VALUES
    ('Administradores', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('Usuarios', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('Recepción', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('Gerencias', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false);

---- datos gerencias ------------------------------------------------------------------------------------------------------------
-- Insertar 'Operaciones'
INSERT INTO public.tb_sica_catalogo_gerencias (descripcion, baja, fecha_creacion, fecha_modificacion)
VALUES ('Operaciones', false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'Abastos'
INSERT INTO public.tb_sica_catalogo_gerencias (descripcion, baja, fecha_creacion, fecha_modificacion)
VALUES ('Abastos', false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'Mercadotecnia'
INSERT INTO public.tb_sica_catalogo_gerencias (descripcion, baja, fecha_creacion, fecha_modificacion)
VALUES ('Mercadotecnia', false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'Recursos Humanos'
INSERT INTO public.tb_sica_catalogo_gerencias (descripcion, baja, fecha_creacion, fecha_modificacion)
VALUES ('Recursos Humanos', false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'Sistemas'
INSERT INTO public.tb_sica_catalogo_gerencias (descripcion, baja, fecha_creacion, fecha_modificacion)
VALUES ('Sistemas', false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'Compras'
INSERT INTO public.tb_sica_catalogo_gerencias (descripcion, baja, fecha_creacion, fecha_modificacion)
VALUES ('Compras', false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'Auditoria'
INSERT INTO public.tb_sica_catalogo_gerencias (descripcion, baja, fecha_creacion, fecha_modificacion)
VALUES ('Auditoria', false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'Contabilidad'
INSERT INTO public.tb_sica_catalogo_gerencias (descripcion, baja, fecha_creacion, fecha_modificacion)
VALUES ('Contabilidad', false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'Gerencia General'
INSERT INTO public.tb_sica_catalogo_gerencias (descripcion, baja, fecha_creacion, fecha_modificacion)
VALUES ('Gerencia General', false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- datos departamentos --------------------------------------------------------------------------------------------------------

-- Insertar 'RECURSOS HUMANOS' en la gerencia con ID 4
INSERT INTO public.tb_sica_catalogo_departamentos (descripcion, id_gerencia, baja, fecha_creacion, fecha_modificacion)
VALUES ('RECURSOS HUMANOS', 4, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'OPERACIONES' en la gerencia con ID 1
INSERT INTO public.tb_sica_catalogo_departamentos (descripcion, id_gerencia, baja, fecha_creacion, fecha_modificacion)
VALUES ('OPERACIONES', 1, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'SISTEMAS' en la gerencia con ID 5
INSERT INTO public.tb_sica_catalogo_departamentos (descripcion, id_gerencia, baja, fecha_creacion, fecha_modificacion)
VALUES ('SISTEMAS', 5, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'COMPRAS' en la gerencia con ID 1
INSERT INTO public.tb_sica_catalogo_departamentos (descripcion, id_gerencia, baja, fecha_creacion, fecha_modificacion)
VALUES ('COMPRAS', 1, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'Logistica' en la gerencia con ID 2
INSERT INTO public.tb_sica_catalogo_departamentos (descripcion, id_gerencia, baja, fecha_creacion, fecha_modificacion)
VALUES ('Logistica', 2, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'Mercadotecnia' en la gerencia con ID 3
INSERT INTO public.tb_sica_catalogo_departamentos (descripcion, id_gerencia, baja, fecha_creacion, fecha_modificacion)
VALUES ('Mercadotecnia', 3, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'Compras' en la gerencia con ID 6
INSERT INTO public.tb_sica_catalogo_departamentos (descripcion, id_gerencia, baja, fecha_creacion, fecha_modificacion)
VALUES ('Compras', 6, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'AUDITORIA' en la gerencia con ID 7
INSERT INTO public.tb_sica_catalogo_departamentos (descripcion, id_gerencia, baja, fecha_creacion, fecha_modificacion)
VALUES ('AUDITORIA', 7, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'Contabilidad y Finanzas' en la gerencia con ID 8
INSERT INTO public.tb_sica_catalogo_departamentos (descripcion, id_gerencia, baja, fecha_creacion, fecha_modificacion)
VALUES ('Contabilidad y Finanzas', 8, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'Gerencia General' en la gerencia con ID 9
INSERT INTO public.tb_sica_catalogo_departamentos (descripcion, id_gerencia, baja, fecha_creacion, fecha_modificacion)
VALUES ('Gerencia General', 9, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

----- datos clasificacion actividades ----------------------------------------------------------------------------------------

-- Insertar 'RECLUTAMIENTO' en la clasificación de actividades para el departamento con ID 1
INSERT INTO public.tb_sica_catalogo_clasificacion_actividades (nombre, descripcion, id_departamento, baja, fecha_creacion, fecha_modificacion)
VALUES ('RECLUTAMIENTO', 'RECLUTAMIENTO', 1, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'HERRAMIENTAS' en la clasificación de actividades para el departamento con ID 1
INSERT INTO public.tb_sica_catalogo_clasificacion_actividades (nombre, descripcion, id_departamento, baja, fecha_creacion, fecha_modificacion)
VALUES ('HERRAMIENTAS', 'HERRAMIENTAS', 1, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'REQUERIMIENTO' en la clasificación de actividades para el departamento con ID 1
INSERT INTO public.tb_sica_catalogo_clasificacion_actividades (nombre, descripcion, id_departamento, baja, fecha_creacion, fecha_modificacion)
VALUES ('REQUERIMIENTO', 'REQUERIMIENTO', 1, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'MENTENIMIENTO FIO' en la clasificación de actividades para el departamento con ID 2
INSERT INTO public.tb_sica_catalogo_clasificacion_actividades (nombre, descripcion, id_departamento, baja, fecha_creacion, fecha_modificacion)
VALUES ('MENTENIMIENTO FIO', 'MENTENIMIENTO FIO', 2, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'MANTENIMIENTOS TIENDA' en la clasificación de actividades para el departamento con ID 2
INSERT INTO public.tb_sica_catalogo_clasificacion_actividades (nombre, descripcion, id_departamento, baja, fecha_creacion, fecha_modificacion)
VALUES ('MANTENIMIENTOS TIENDA', 'MANTENIMIENTOS TIENDA', 2, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'EQUIPOS' en la clasificación de actividades para el departamento con ID 3
INSERT INTO public.tb_sica_catalogo_clasificacion_actividades (nombre, descripcion, id_departamento, baja, fecha_creacion, fecha_modificacion)
VALUES ('EQUIPOS', 'EQUIPOS', 3, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'SISTEMA' en la clasificación de actividades para el departamento con ID 3
INSERT INTO public.tb_sica_catalogo_clasificacion_actividades (nombre, descripcion, id_departamento, baja, fecha_creacion, fecha_modificacion)
VALUES ('SISTEMA', 'FALLA DEL SISTEMA', 3, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'COMPRAS' en la clasificación de actividades para el departamento con ID 7
INSERT INTO public.tb_sica_catalogo_clasificacion_actividades (nombre, descripcion, id_departamento, baja, fecha_creacion, fecha_modificacion)
VALUES ('COMPRAS', 'COMPRAS', 7, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'PLANOGRAMAS' en la clasificación de actividades para el departamento con ID 6
INSERT INTO public.tb_sica_catalogo_clasificacion_actividades (nombre, descripcion, id_departamento, baja, fecha_creacion, fecha_modificacion)
VALUES ('PLANOGRAMAS', 'PLANOGRAMAS', 6, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'MATERIAL POP' en la clasificación de actividades para el departamento con ID 6
INSERT INTO public.tb_sica_catalogo_clasificacion_actividades (nombre, descripcion, id_departamento, baja, fecha_creacion, fecha_modificacion)
VALUES ('MATERIAL POP', 'MATERIAL POP', 6, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'PROMOCIONES' en la clasificación de actividades para el departamento con ID 6
INSERT INTO public.tb_sica_catalogo_clasificacion_actividades (nombre, descripcion, id_departamento, baja, fecha_creacion, fecha_modificacion)
VALUES ('PROMOCIONES', 'PROMOCIONES', 6, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'CONTABILIDAD' en la clasificación de actividades para el departamento con ID 9
INSERT INTO public.tb_sica_catalogo_clasificacion_actividades (nombre, descripcion, id_departamento, baja, fecha_creacion, fecha_modificacion)
VALUES ('CONTABILIDAD', 'CONTABILIDAD', 9, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'AUDITORIA' en la clasificación de actividades para el departamento con ID 8
INSERT INTO public.tb_sica_catalogo_clasificacion_actividades (nombre, descripcion, id_departamento, baja, fecha_creacion, fecha_modificacion)
VALUES ('AUDITORIA', 'AUDITORIA', 8, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- datos grupo actividades ------------------------------------------------------------------------------------------------

-- Insertar 'RECLUTAMIENTO' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('RECLUTAMIENTO', 'RECLUTAMIENTO', 1, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'HERRAMIENTAS' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('HERRAMIENTAS', 'HERRAMIENTAS', 2, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'REQUERIMIENTO' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('REQUERIMIENTO', 'REQUERIMIENTO', 3, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'MENTENIMIENTO FIO' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('MENTENIMIENTO FIO', 'MENTENIMIENTO FIO', 4, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'MANTENIMIENTOS TIENDA' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('MANTENIMIENTOS TIENDA', 'MANTENIMIENTOS TIENDA', 5, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'FALLAS' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('FALLAS', 'FALLAS', 6, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'REPARACION' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('REPARACION', 'REPARACION', 6, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'FALLA DEL SISTEMA' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('FALLA DEL SISTEMA', 'FALLA DEL SISTEMA', 7, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'PROVEEDORES' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('PROVEEDORES', 'PROVEEDORES', 8, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'NUEVA CATALOGACIÓN' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('NUEVA CATALOGACIÓN', 'Nueva Catalogación', 9, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'PRODUCTO DESCATALOGADO' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('PRODUCTO DESCATALOGADO', 'Producto descatalogado', 9, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'GONDOLA' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('GONDOLA', 'GONDOLA', 9, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'CORTINA DE AIRE' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('CORTINA DE AIRE', 'CORTINA DE AIRE', 9, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'FAST FOOD' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('FAST FOOD', 'FAST FOOD', 9, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'CAMARA FRÍA' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('CAMARA FRÍA', 'CAMARA FRÍA', 9, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'VITRINA' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('VITRINA', 'VITRINA', 9, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'Señaletica' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('Señaletica', 'Señaletica', 10, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'Señaletica Fast Food' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('Señaletica Fast Food', 'Señaletica Fast Food', 10, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'PROMOCIONES MENSUALES' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('PROMOCIONES MENSUALES', 'PROMOCIONES MENSUALES', 11, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'CADUCIDAD' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('CADUCIDAD', 'CADUCIDAD', 8, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'PROMOCIONES' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('PROMOCIONES', 'PROMOCIONES', 8, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'PRODUCTOS' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('PRODUCTOS', 'PRODUCTOS', 8, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'BANCO' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('BANCO', 'BANCO', 12, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'FACTURACION' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('FACTURACION', 'FACTURACION', 12, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'GENERAL' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('GENERAL', 'GENERAL', 12, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insertar 'AUDITORIA' en el grupo de actividades
INSERT INTO public.tb_sica_catalogo_grupo_actividades 
(nombre, descripcion, id_clasificacion_actividad, baja, fecha_creacion, fecha_modificacion) 
VALUES ('AUDITORIA', 'AUDITORIA', 13, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


-- datos grupos responsables ------------------------------------------------------------------------------------------------

INSERT INTO public.tb_sica_grupo_usuarios_responsables (nombre, descripcion, id_departamento, fecha_creacion, fecha_modificacion, baja)
VALUES
    ('Grupo de Gestión de Recursos Humanos', 'Grupo responsable de la gestión y administración de los recursos humanos.', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('Grupo de Operaciones y Logística', 'Grupo encargado de la supervisión y control de operaciones diarias y logística.', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('Grupo Soporte de Sistemas', 'Grupo encargado del mantenimiento, desarrollo y soporte de los sistemas informáticos.', 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('Grupo Logistica', 'Grupo responsable de la planificación y ejecución de la logística y distribución.', 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('Grupo Mercadotecnia', 'Grupo encargado de desarrollar e implementar estrategias de marketing.', 6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('Grupo de Compras', 'Grupo responsable de la gestión de compras.', 7, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('Grupo de Auditoría', 'Grupo encargado de la auditoría interna y el control de riesgos.', 8, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('Grupo de Contabilidad y Finanzas', 'Grupo responsable de la gestión financiera y contable de la organización.', 9, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('Grupo de Gestión de la Gerencia General', 'Grupo encargado de la coordinación y administración de la Gerencia General.', 10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false);

-- --------------------------------------------------------< datos catalogo actividades > ------------------------------------------------------------------------------------------------

INSERT INTO public.tb_sica_catalogo_actividades
(
    nombre, descripcion, tiempo, baja, 
    id_grupo_actividad, id_grupo_usuario_responsable
)
VALUES
('OPER', 'OPER', 190.00, false, 1, 1),
('STAFF', 'STAFF', 360.00, false, 1, 1),
('GAFETES', 'GAFETES', 24.00, false, 2, 1),
('CASACAS', 'CASACAS', 24.00, false, 2, 1),
('FAJAS', 'FAJAS', 24.00, false, 2, 1),
('CONSTACIA', 'CONSTACIA', 24.00, false, 3, 1),
('DESCUENTOS (INVENTARIO/CAJA)', 'DESCUENTOS (INVENTARIO/CAJA)', 72.00, false, 3, 1),
('DESCANSOS', 'DESCANSOS', 72.00, false, 3, 1),
('NOCTURNOS', 'NOCTURNOS', 72.00, false, 3, 1),
('CAMARA FRIA NO ENFRIA', 'CAMARA FRIA NO ENFRIA', 48.00, false, 4, 2),
('CORTINA DE AIRE NO ENFRIA', 'CORTINA DE AIRE NO ENFRIA', 72.00, false, 4, 2),
('VITRINA NO ENFRIA', 'VITRINA NO ENFRIA', 96.00, false, 4, 2),
('ENFRIADOR NOENFRIA', 'ENFRIADOR NOENFRIA', 48.00, false, 4, 2),
('PUERTA ACCESO A TIENDA ARRASTRA', 'PUERTA ACCESO A TIENDA ARRASTRA', 96.00, false, 5, 2),
('FUGA DE AGUA EN EL BAÑO', 'FUGA DE AGUA EN EL BAÑO', 48.00, false, 5, 2),
('FUGA DE AGUA EN LLAVE ESTACIONAMIENTO', 'FUGA DE AGUA EN LLAVE ESTACIONAMIENTO', 48.00, false, 5, 2),
('CRISTA ROTO DE SUCURSAL', 'CRISTA ROTO DE SUCURSAL', 48.00, false, 5, 2),
('CAJA FUERTE DAÑADA', 'CAJA FUERTE DAÑADA', 48.00, false, 5, 2),
('CAJA 1', 'CAJA 1', 6.00, false, 6, 3),
('CAJA 2', 'CAJA 2', 6.00, false, 6, 3),
('RECARGAS/BANCO/TELEONO', 'RECARGAS/BANCO/TELEFONO', 72.00, false, 6, 3),
('CAMARA DE VIDEO', 'CAMARA DE VIDEO', 24.00, false, 6, 3),
('FALLA DE EQUIPO', 'FALLA DE EQUIPO', 168.00, false, 6, 3),
('ACCESORIOS', 'ACCESORIOS', 24.00, false, 7, 3),
('FALLA EN EL SISTEMA', 'FALLA EN EL SISTEMA', 24.00, false, 8, 3),
('PROVEEDORES', 'PROVEEDORES', 144.00, false, 9, 6),
('ACOMODO DE PRODUCTO NUEVO', 'ACOMODO DE PRODUCTO NUEVO', 24.00, false, 10, 5),
('SUSTITUIR FRENTE POR OTRO PRODUCTO', 'SUSTITUIR FRENTE POR OTRO PRODUCTO', 24.00, false, 11, 5),
('GONDOLA PLANOGRAMAS ACTUALIZADOS ', 'GONDOLA PLANOGRAMAS ACTUALIZADOS ', 24.00, false, 12, 5),
('CORTINA DE AIRE PLANOGRAMAS ACTUALIZADOS', 'CORTINA DE AIRE PLANOGRAMAS ACTUALIZADOS', 24.00, false, 13, 5),
('FAST FOOD PLANOGRAMAS ACTUALIZADOS', 'FAST FOOD PLANOGRAMAS ACTUALIZADOS', 24.00, false, 14, 5),
('CAMARA FRÍA PLANOGRAMAS ACTUALIZADOS', 'CAMARA FRÍA PLANOGRAMAS ACTUALIZADOS', 24.00, false, 15, 5),
('VITRINA PLANOGRAMAS ACTUALIZADOS', 'VITRINA PLANOGRAMAS ACTUALIZADOS', 24.00, false, 16, 5),
('SEÑALIZACIÓN EN LAS SUCURSALES', 'SEÑALIZACIÓN EN LAS SUCURSALES', 24.00, false, 17, 5),
('TIRAS PRECIADORAS', 'TIRAS PRECIADORAS', 24.00, false, 18, 5),
('MICROONDAS', 'MICROONDAS', 24.00, false, 18, 5),
('HOTDOG', 'HOTDOG', 24.00, false, 18, 5),
('SIERRA BONITA', 'SIERRA BONITA', 24.00, false, 18, 5),
('VIGENCIA', 'VIGENCIA', 24.00, false, 19, 5),
('GUÍA DE EJECUCIÓN', 'GUÍA DE EJECUCIÓN', 24.00, false, 19, 5),
('PRODUCTOS PROXIMOS A CADUCAR', 'PRODUCTOS PROXIMOS A CADUCAR', 48.00, false, 20, 6),
('PRODUCTOS QUE NO PASAN', 'PRODUCTOS QUE NO PASAN ', 12.00, false, 22, 6),
('DESBLOQUEO DE PRODUCTOS', 'DESBLOQUEO DE PRODUCTOS', 24.00, false, 22, 6),
('REFERENCIAS BANCO', 'REFERENCIAS BANCO', 24.00, false, 23, 8),
('CASH', 'CASH', 24.00, false, 23, 8),
('CORRESPONSALIAS', 'CORRESPONSALIAS', 24.00, false, 23, 8),
('ADDENDA', 'ADDENDA', 24.00, false, 24, 8),
('SERVICIOS', 'SERVICIOS', 24.00, false, 25, 8),
('FALTANTE DE CAJA', 'FALTANTE DE CAJA', 24.00, false, 25, 8),
('RESULTADOS DE INVENTARIO', 'RESULTADOS DE INVENTARIO', 48.00, false, 26, 7),
('CADUCADO EXHIBIDO', 'CADUCADO EXHIBIDO', 48.00, false, 26, 7),
('SOLICITUD DE INVENTARIO', 'SOLICITUD DE INVENTARIO', 48.00, false, 26, 7),
('AJUSTES DE INVENTARIO', 'AJUSTES DE INVENTARIO', 48.00, false, 26, 7),
('OTROS', 'OTROS', 48.00, false, 26, 7);

INSERT INTO public.tb_sica_catalogo_usuarios_sica (
    responsable, 
    jefe_area, 
    correo, 
    es_staff, 
    id_grupo_usuario, 
    id_usuario, 
    id_departamento, 
    id_gerencia, 
    baja
) VALUES (
    true,              
    true,            
    'id2.sistemas@724.com.mx', 
    false,              
    1,                 
    3238,               
    3,                 
    5,                 
    false              
);


INSERT INTO public.tb_sica_relacion_usuarios_grupo_responsables (id_usuario, id_grupo_usuario_responsable)
VALUES (3238, 3); 
