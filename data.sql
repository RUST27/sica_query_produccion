


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

insert into public.tb_sica_catalogo_estatus (id_estatus, descripcion, clave, fecha_creacion, fecha_modificacion)
values  (1, 'Nuevo', 'NVO', '2024-10-14 16:48:56.023743', '2024-10-14 16:48:56.023743'),
        (2, 'Leído', 'LDO', '2024-10-14 16:49:01.453775', '2024-10-14 16:49:01.453775'),
        (3, 'Ejecución', 'EJEC', '2024-10-14 16:49:06.377251', '2024-10-14 16:49:06.377251'),
        (4, 'Observaciones', 'OBS', '2024-10-14 16:49:11.314687', '2024-10-14 16:49:11.314687'),
        (5, 'Cancelado', 'CANC', '2024-10-14 16:49:15.392726', '2024-10-14 16:49:15.392726'),
        (6, 'Cerrado', 'CRDO', '2024-10-14 16:49:20.065877', '2024-10-14 16:49:20.065877');

insert into public.tb_sica_catalogo_grupos_usuarios (id_grupo_usuario, descripcion, fecha_creacion, fecha_modificacion, baja)
values  (1, 'Administradores', '2024-10-14 16:50:33.251236', '2024-10-14 16:50:33.251236', false),
        (2, 'Usuarios', '2024-10-14 16:50:37.607875', '2024-10-14 16:50:37.607875', false),
        (3, 'Recepción', '2024-10-14 16:50:41.363187', '2024-10-14 16:50:41.363187', false),
        (4, 'Gerencias', '2024-10-14 16:50:46.233178', '2024-10-14 16:50:46.233178', false);

---- datos gerencias ------------------------------------------------------------------------------------------------------------
-- Insertar 'Operaciones'
insert into public.tb_sica_catalogo_gerencias (id_gerencia, descripcion, baja, fecha_creacion, fecha_modificacion)
values  (1, 'Operaciones', false, '2024-10-14 16:51:56.167132', '2024-10-14 16:51:56.167132'),
        (2, 'Abastos', false, '2024-10-14 16:52:01.187960', '2024-10-14 16:52:01.187960'),
        (3, 'Mercadotecnia', false, '2024-10-14 16:52:05.152074', '2024-10-14 16:52:05.152074'),
        (4, 'Recursos Humanos', false, '2024-10-14 16:52:09.444771', '2024-10-14 16:52:09.444771'),
        (5, 'Sistemas', false, '2024-10-14 16:52:13.611603', '2024-10-14 16:52:13.611603'),
        (6, 'Compras', false, '2024-10-14 16:52:17.426867', '2024-10-14 16:52:17.426867'),
        (7, 'Auditoria', false, '2024-10-14 16:52:22.078166', '2024-10-14 16:52:22.078166'),
        (8, 'Contabilidad', false, '2024-10-14 16:52:26.202998', '2024-10-14 16:52:26.202998'),
        (9, 'Gerencia General', false, '2024-10-14 16:52:30.324886', '2024-10-14 16:52:30.324886');

-- datos departamentos --------------------------------------------------------------------------------------------------------
insert into public.tb_sica_catalogo_departamentos (id_departamento, descripcion, baja, id_gerencia, fecha_creacion, fecha_modificacion)
values  (1, 'RECURSOS HUMANOS', false, 4, '2024-10-14 16:58:56.392843', '2024-10-14 16:58:56.392843'),
        (2, 'OPERACIONES', false, 1, '2024-10-14 16:58:59.761358', '2024-10-14 16:58:59.761358'),
        (3, 'SISTEMAS', false, 5, '2024-10-14 16:59:02.263814', '2024-10-14 16:59:02.263814'),
        (4, 'COMPRAS', true, 1, '2024-10-14 16:59:05.609331', '2024-10-14 16:59:05.609331'),
        (5, 'Logistica', false, 2, '2024-10-14 16:59:08.148011', '2024-10-14 16:59:08.148011'),
        (6, 'Mercadotecnia', false, 3, '2024-10-14 16:59:10.886232', '2024-10-14 16:59:10.886232'),
        (7, 'Compras', false, 6, '2024-10-14 16:59:14.942086', '2024-10-14 16:59:14.942086'),
        (8, 'AUDITORIA', false, 7, '2024-10-14 16:59:18.790146', '2024-10-14 16:59:18.790146'),
        (9, 'Contabilidad y Finanzas', false, 8, '2024-10-14 16:59:22.305999', '2024-10-14 16:59:22.305999'),
        (10, 'Gerencia General', false, 9, '2024-10-14 16:59:25.915470', '2024-10-14 16:59:25.915470');

----- datos clasificacion actividades ----------------------------------------------------------------------------------------
insert into public.tb_sica_catalogo_clasificacion_actividades (id_clasificacion_actividad, nombre, descripcion, baja, id_departamento, fecha_creacion, fecha_modificacion)
values  (1, 'RECLUTAMIENTO', 'RECLUTAMIENTO', false, 1, '2024-10-14 17:14:00.464264', '2024-10-14 17:14:00.464264'),
        (2, 'HERRAMIENTAS', 'HERRAMIENTAS', false, 1, '2024-10-14 17:14:03.464835', '2024-10-14 17:14:03.464835'),
        (3, 'REQUERIMIENTO', 'REQUERIMIENTO', false, 1, '2024-10-14 17:14:06.124996', '2024-10-14 17:14:06.124996'),
        (4, 'MENTENIMIENTO FRIO', 'MENTENIMIENTO FRIO', false, 2, '2024-10-14 17:14:09.927562', '2024-10-14 17:14:09.927562'),
        (5, 'MANTENIMIENTOS TIENDA', 'MANTENIMIENTOS TIENDA', false, 2, '2024-10-14 17:14:13.939314', '2024-10-14 17:14:13.939314'),
        (6, 'EQUIPOS', 'EQUIPOS', false, 3, '2024-10-14 17:14:16.612959', '2024-10-14 17:14:16.612959'),
        (7, 'SISTEMA', 'FALLA DEL SISTEMA', false, 3, '2024-10-14 17:14:19.505905', '2024-10-14 17:14:19.505905'),
        (8, 'COMPRAS', 'COMPRAS', false, 7, '2024-10-14 17:14:22.924279', '2024-10-14 17:14:22.924279'),
        (9, 'PLANOGRAMAS', 'PLANOGRAMAS', false, 6, '2024-10-14 17:14:25.579265', '2024-10-14 17:14:25.579265'),
        (10, 'MATERIAL POP', 'MATERIAL POP', false, 6, '2024-10-14 17:14:28.736377', '2024-10-14 17:14:28.736377'),
        (11, 'PROMOCIONES', 'PROMOCIONES', false, 6, '2024-10-14 17:14:47.860484', '2024-10-14 17:14:47.860484'),
        (12, 'CONTABILIDAD', 'CONTABILIDAD', false, 9, '2024-10-14 17:14:54.694965', '2024-10-14 17:14:54.694965'),
        (13, 'AUDITORIA', 'AUDITORIA', false, 8, '2024-10-14 17:14:57.810765', '2024-10-14 17:14:57.810765');

-- datos grupo actividades ------------------------------------------------------------------------------------------------

insert into public.tb_sica_catalogo_grupo_actividades (id_grupo_actividad, nombre, descripcion, baja, id_clasificacion_actividad, fecha_creacion, fecha_modificacion)
values  (1, 'RECLUTAMIENTO', 'RECLUTAMIENTO', false, 1, '2024-10-14 17:24:30.257467', '2024-10-14 17:24:30.257467'),
        (2, 'HERRAMIENTAS', 'HERRAMIENTAS', false, 2, '2024-10-14 17:24:34.102971', '2024-10-14 17:24:34.102971'),
        (3, 'REQUERIMIENTO', 'REQUERIMIENTO', false, 3, '2024-10-14 17:24:37.642504', '2024-10-14 17:24:37.642504'),
        (4, 'MENTENIMIENTO FRIO', 'MENTENIMIENTO FRIO', false, 4, '2024-10-14 17:24:40.593740', '2024-10-14 17:24:40.593740'),
        (5, 'MANTENIMIENTOS TIENDA', 'MANTENIMIENTOS TIENDA', false, 5, '2024-10-14 17:24:43.782607', '2024-10-14 17:24:43.782607'),
        (6, 'FALLAS', 'FALLAS', false, 6, '2024-10-14 17:24:47.127923', '2024-10-14 17:24:47.127923'),
        (7, 'REPARACION', 'REPARACION', false, 6, '2024-10-14 17:24:51.005073', '2024-10-14 17:24:51.005073'),
        (8, 'FALLA DEL SISTEMA', 'FALLA DEL SISTEMA', false, 7, '2024-10-14 17:24:53.679631', '2024-10-14 17:24:53.679631'),
        (9, 'PROVEEDORES', 'PROVEEDORES', false, 8, '2024-10-14 17:24:56.625145', '2024-10-14 17:24:56.625145'),
        (10, 'NUEVA CATALOGACIÓN', 'Nueva Catalogación', false, 9, '2024-10-14 17:24:59.139324', '2024-10-14 17:24:59.139324'),
        (11, 'PRODUCTO DESCATALOGADO', 'Producto descatalogado', false, 9, '2024-10-14 17:25:03.155175', '2024-10-14 17:25:03.155175'),
        (12, 'GONDOLA', 'GONDOLA', false, 9, '2024-10-14 17:25:05.515452', '2024-10-14 17:25:05.515452'),
        (13, 'CORTINA DE AIRE', 'CORTINA DE AIRE', false, 9, '2024-10-14 17:25:08.576595', '2024-10-14 17:25:08.576595'),
        (14, 'FAST FOOD', 'FAST FOOD', false, 9, '2024-10-14 17:25:11.400073', '2024-10-14 17:25:11.400073'),
        (15, 'CAMARA FRÍA', 'CAMARA FRÍA', false, 9, '2024-10-14 17:25:14.324893', '2024-10-14 17:25:14.324893'),
        (16, 'VITRINA', 'VITRINA', false, 9, '2024-10-14 17:25:17.639791', '2024-10-14 17:25:17.639791'),
        (17, 'Señaletica', 'Señaletica', false, 10, '2024-10-14 17:25:20.423591', '2024-10-14 17:25:20.423591'),
        (18, 'Señaletica Fast Food', 'Señaletica Fast Food', false, 10, '2024-10-14 17:25:22.912062', '2024-10-14 17:25:22.912062'),
        (19, 'PROMOCIONES MENSUALES', 'PROMOCIONES MENSUALES', false, 11, '2024-10-14 17:25:26.030638', '2024-10-14 17:25:26.030638'),
        (20, 'CADUCIDAD', 'CADUCIDAD', false, 8, '2024-10-14 17:25:30.956546', '2024-10-14 17:25:30.956546'),
        (21, 'PROMOCIONES', 'PROMOCIONES', false, 8, '2024-10-14 17:25:36.827898', '2024-10-14 17:25:36.827898'),
        (22, 'PRODUCTOS', 'PRODUCTOS', false, 8, '2024-10-14 17:25:39.406093', '2024-10-14 17:25:39.406093'),
        (23, 'BANCO', 'BANCO', false, 12, '2024-10-14 17:25:42.275905', '2024-10-14 17:25:42.275905'),
        (24, 'FACTURACION', 'FACTURACION', false, 12, '2024-10-14 17:25:45.862017', '2024-10-14 17:25:45.862017'),
        (25, 'GENERAL', 'GENERAL', false, 12, '2024-10-14 17:25:48.696166', '2024-10-14 17:25:48.696166'),
        (26, 'AUDITORIA', 'AUDITORIA', false, 13, '2024-10-14 17:25:52.336988', '2024-10-14 17:25:52.336988');

-- datos grupos responsables ------------------------------------------------------------------------------------------------

insert into public.tb_sica_grupo_usuarios_responsables (id_grupo_usuario_responsable, nombre, descripcion, id_departamento, fecha_creacion, fecha_modificacion, baja)
values  (1, 'Grupo de Gestión de Recursos Humanos', 'Grupo responsable de la gestión y administración de los recursos humanos.', 1, '2024-10-14 17:31:38.326408', '2024-10-14 17:31:38.326408', false),
        (2, 'Grupo de Operaciones y Logística', 'Grupo encargado de la supervisión y control de operaciones diarias y logística.', 2, '2024-10-14 17:31:43.720422', '2024-10-14 17:31:43.720422', false),
        (3, 'Grupo Soporte de Sistemas', 'Grupo encargado del mantenimiento, desarrollo y soporte de los sistemas informáticos.', 3, '2024-10-14 17:31:48.784919', '2024-10-14 17:31:48.784919', false),
        (4, 'Grupo Logística', 'Grupo responsable de la planificación y ejecución de la logística y distribución.', 5, '2024-10-14 17:31:53.046201', '2024-10-14 17:31:53.046201', false),
        (5, 'Grupo Mercadotecnia', 'Grupo encargado de desarrollar e implementar estrategias de marketing.', 6, '2024-10-14 17:31:58.894827', '2024-10-14 17:31:58.894827', false),
        (6, 'Grupo de Compras', 'Grupo responsable de la gestión de compras.', 7, '2024-10-14 17:32:04.477855', '2024-10-14 17:32:04.477855', false),
        (7, 'Grupo de Auditoría', 'Grupo encargado de la auditoría interna y el control de riesgos.', 8, '2024-10-14 17:32:09.441330', '2024-10-14 17:32:09.441330', false),
        (8, 'Grupo de Contabilidad y Finanzas', 'Grupo responsable de la gestión financiera y contable de la organización.', 9, '2024-10-14 17:32:13.905114', '2024-10-14 17:32:13.905114', false),
        (9, 'Grupo de Gestión de la Gerencia General', 'Grupo encargado de la coordinación y administración de la Gerencia General.', 10, '2024-10-14 17:32:17.763142', '2024-10-14 17:32:17.763142', false);

-- --------------------------------------------------------< datos catalogo actividades > ------------------------------------------------------------------------------------------------
insert into public.tb_sica_catalogo_actividades (id_actividad, nombre, descripcion, tiempo, baja, id_grupo_actividad, id_grupo_usuario_responsable, fecha_creacion, fecha_modificacion)
values  (1, 'OPER', 'OPER', 190.00, false, 1, 1, '2024-10-14 17:41:51.097178', '2024-10-14 17:41:51.097178'),
        (2, 'STAFF', 'STAFF', 360.00, false, 1, 1, '2024-10-14 17:41:57.092877', '2024-10-14 17:41:57.092877'),
        (3, 'GAFETES', 'GAFETES', 24.00, false, 2, 1, '2024-10-14 17:42:01.721641', '2024-10-14 17:42:01.721641'),
        (4, 'CASACAS', 'CASACAS', 24.00, false, 2, 1, '2024-10-14 17:42:05.919373', '2024-10-14 17:42:05.919373'),
        (5, 'FAJAS', 'FAJAS', 24.00, false, 2, 1, '2024-10-14 17:42:09.992875', '2024-10-14 17:42:09.992875'),
        (6, 'CONSTACIA', 'CONSTACIA', 24.00, false, 3, 1, '2024-10-14 17:42:13.746854', '2024-10-14 17:42:13.746854'),
        (7, 'DESCUENTOS (INVENTARIO/CAJA)', 'DESCUENTOS (INVENTARIO/CAJA)', 72.00, false, 3, 1, '2024-10-14 17:42:18.694458', '2024-10-14 17:42:18.694458'),
        (8, 'DESCANSOS', 'DESCANSOS', 72.00, false, 3, 1, '2024-10-14 17:42:23.043717', '2024-10-14 17:42:23.043717'),
        (9, 'NOCTURNOS', 'NOCTURNOS', 72.00, false, 3, 1, '2024-10-14 17:42:26.758878', '2024-10-14 17:42:26.758878'),
        (10, 'CAMARA FRIA NO ENFRIA', 'CAMARA FRIA NO ENFRIA', 48.00, false, 4, 2, '2024-10-14 17:42:30.508686', '2024-10-14 17:42:30.508686'),
        (11, 'CORTINA DE AIRE NO ENFRIA', 'CORTINA DE AIRE NO ENFRIA', 72.00, false, 4, 2, '2024-10-14 17:42:34.726333', '2024-10-14 17:42:34.726333'),
        (12, 'VITRINA NO ENFRIA', 'VITRINA NO ENFRIA', 96.00, false, 4, 2, '2024-10-14 17:42:38.825909', '2024-10-14 17:42:38.825909'),
        (13, 'ENFRIADOR NO ENFRIA', 'ENFRIADOR NO ENFRIA', 48.00, false, 4, 2, '2024-10-14 17:42:44.132130', '2024-10-14 17:42:44.132130'),
        (14, 'PUERTA ACCESO A TIENDA ARRASTRA', 'PUERTA ACCESO A TIENDA ARRASTRA', 96.00, false, 5, 2, '2024-10-14 17:42:49.742462', '2024-10-14 17:42:49.742462'),
        (15, 'FUGA DE AGUA EN EL BAÑO', 'FUGA DE AGUA EN EL BAÑO', 48.00, false, 5, 2, '2024-10-14 17:42:54.626710', '2024-10-14 17:42:54.626710'),
        (16, 'FUGA DE AGUA EN LLAVE ESTACIONAMIENTO', 'FUGA DE AGUA EN LLAVE ESTACIONAMIENTO', 48.00, false, 5, 2, '2024-10-14 17:42:59.330186', '2024-10-14 17:42:59.330186'),
        (17, 'CRISTA ROTO DE SUCURSAL', 'CRISTA ROTO DE SUCURSAL', 48.00, false, 5, 2, '2024-10-14 17:43:03.518947', '2024-10-14 17:43:03.518947'),
        (18, 'CAJA FUERTE DAÑADA', 'CAJA FUERTE DAÑADA', 48.00, false, 5, 2, '2024-10-14 17:43:08.335445', '2024-10-14 17:43:08.335445'),
        (19, 'CAJA 1', 'CAJA 1', 6.00, false, 6, 3, '2024-10-14 17:43:12.078097', '2024-10-14 17:43:12.078097'),
        (20, 'CAJA 2', 'CAJA 2', 6.00, false, 6, 3, '2024-10-14 17:43:16.031616', '2024-10-14 17:43:16.031616'),
        (21, 'RECARGAS/BANCO/TELEFONO', 'RECARGAS/BANCO/TELEFONO', 72.00, false, 6, 3, '2024-10-14 17:44:07.249003', '2024-10-14 17:44:07.249003'),
        (22, 'CAMARA DE VIDEO', 'CAMARA DE VIDEO', 24.00, false, 6, 3, '2024-10-14 17:44:11.450493', '2024-10-14 17:44:11.450493'),
        (23, 'FALLA DE EQUIPO', 'FALLA DE EQUIPO', 168.00, false, 6, 3, '2024-10-14 17:44:15.467407', '2024-10-14 17:44:15.467407'),
        (24, 'ACCESORIOS', 'ACCESORIOS', 24.00, false, 7, 3, '2024-10-14 17:44:19.787164', '2024-10-14 17:44:19.787164'),
        (25, 'FALLA EN EL SISTEMA', 'FALLA EN EL SISTEMA', 24.00, false, 8, 3, '2024-10-14 17:44:24.181095', '2024-10-14 17:44:24.181095'),
        (26, 'PROVEEDORES', 'PROVEEDORES', 144.00, false, 9, 6, '2024-10-14 17:44:28.718418', '2024-10-14 17:44:28.718418'),
        (27, 'ACOMODO DE PRODUCTO NUEVO', 'ACOMODO DE PRODUCTO NUEVO', 24.00, false, 10, 5, '2024-10-14 17:44:32.399396', '2024-10-14 17:44:32.399396'),
        (28, 'SUSTITUIR FRENTE POR OTRO PRODUCTO', 'SUSTITUIR FRENTE POR OTRO PRODUCTO', 24.00, false, 11, 5, '2024-10-14 17:44:36.269623', '2024-10-14 17:44:36.269623'),
        (29, 'GONDOLA PLANOGRAMAS ACTUALIZADOS', 'GONDOLA PLANOGRAMAS ACTUALIZADOS', 24.00, false, 12, 5, '2024-10-14 17:44:41.390359', '2024-10-14 17:44:41.390359'),
        (30, 'CORTINA DE AIRE PLANOGRAMAS ACTUALIZADOS', 'CORTINA DE AIRE PLANOGRAMAS ACTUALIZADOS', 24.00, false, 13, 5, '2024-10-14 17:44:46.479954', '2024-10-14 17:44:46.479954'),
        (31, 'FAST FOOD PLANOGRAMAS ACTUALIZADOS', 'FAST FOOD PLANOGRAMAS ACTUALIZADOS', 24.00, false, 14, 5, '2024-10-14 17:44:50.654945', '2024-10-14 17:44:50.654945'),
        (32, 'CAMARA FRÍA PLANOGRAMAS ACTUALIZADOS', 'CAMARA FRÍA PLANOGRAMAS ACTUALIZADOS', 24.00, false, 15, 5, '2024-10-14 17:44:54.409659', '2024-10-14 17:44:54.409659'),
        (33, 'VITRINA PLANOGRAMAS ACTUALIZADOS', 'VITRINA PLANOGRAMAS ACTUALIZADOS', 24.00, false, 16, 5, '2024-10-14 17:44:58.425308', '2024-10-14 17:44:58.425308'),
        (34, 'SEÑALIZACIÓN EN LAS SUCURSALES', 'SEÑALIZACIÓN EN LAS SUCURSALES', 24.00, false, 17, 5, '2024-10-14 17:45:02.758517', '2024-10-14 17:45:02.758517'),
        (35, 'TIRAS PRECIADORAS', 'TIRAS PRECIADORAS', 24.00, false, 18, 5, '2024-10-14 17:45:06.122351', '2024-10-14 17:45:06.122351'),
        (36, 'MICROONDAS', 'MICROONDAS', 24.00, false, 18, 5, '2024-10-14 17:45:09.919368', '2024-10-14 17:45:09.919368'),
        (37, 'HOTDOG', 'HOTDOG', 24.00, false, 18, 5, '2024-10-14 17:45:14.890945', '2024-10-14 17:45:14.890945'),
        (38, 'SIERRA BONITA', 'SIERRA BONITA', 24.00, false, 18, 5, '2024-10-14 17:46:00.750545', '2024-10-14 17:46:00.750545'),
        (39, 'VIGENCIA', 'VIGENCIA', 24.00, false, 19, 5, '2024-10-14 17:46:04.275470', '2024-10-14 17:46:04.275470'),
        (40, 'GUÍA DE EJECUCIÓN', 'GUÍA DE EJECUCIÓN', 24.00, false, 19, 5, '2024-10-14 17:46:08.230505', '2024-10-14 17:46:08.230505'),
        (41, 'PRODUCTOS PROXIMOS A CADUCAR', 'PRODUCTOS PROXIMOS A CADUCAR', 48.00, false, 20, 6, '2024-10-14 17:46:12.315334', '2024-10-14 17:46:12.315334'),
        (42, 'PRODUCTOS QUE NO PASAN', 'PRODUCTOS QUE NO PASAN', 12.00, false, 22, 6, '2024-10-14 17:46:16.159174', '2024-10-14 17:46:16.159174'),
        (43, 'DESBLOQUEO DE PRODUCTOS', 'DESBLOQUEO DE PRODUCTOS', 24.00, false, 22, 6, '2024-10-14 17:46:19.927860', '2024-10-14 17:46:19.927860'),
        (44, 'REFERENCIAS BANCO', 'REFERENCIAS BANCO', 24.00, false, 23, 8, '2024-10-14 17:46:24.372010', '2024-10-14 17:46:24.372010'),
        (45, 'CASH', 'CASH', 24.00, false, 23, 8, '2024-10-14 17:46:28.300169', '2024-10-14 17:46:28.300169'),
        (46, 'CORRESPONSALIAS', 'CORRESPONSALIAS', 24.00, false, 23, 8, '2024-10-14 17:46:32.048760', '2024-10-14 17:46:32.048760'),
        (47, 'ADDENDA', 'ADDENDA', 24.00, false, 24, 8, '2024-10-14 17:46:35.812536', '2024-10-14 17:46:35.812536'),
        (48, 'SERVICIOS', 'SERVICIOS', 24.00, false, 25, 8, '2024-10-14 17:46:41.054764', '2024-10-14 17:46:41.054764'),
        (49, 'FALTANTE DE CAJA', 'FALTANTE DE CAJA', 24.00, false, 25, 8, '2024-10-14 17:46:45.527653', '2024-10-14 17:46:45.527653'),
        (50, 'RESULTADOS DE INVENTARIO', 'RESULTADOS DE INVENTARIO', 48.00, false, 26, 7, '2024-10-14 17:46:49.914974', '2024-10-14 17:46:49.914974'),
        (51, 'CADUCADO EXHIBIDO', 'CADUCADO EXHIBIDO', 48.00, false, 26, 7, '2024-10-14 17:46:53.901015', '2024-10-14 17:46:53.901015'),
        (52, 'SOLICITUD DE INVENTARIO', 'SOLICITUD DE INVENTARIO', 48.00, false, 26, 7, '2024-10-14 17:46:58.506542', '2024-10-14 17:46:58.506542'),
        (53, 'AJUSTES DE INVENTARIO', 'AJUSTES DE INVENTARIO', 48.00, false, 26, 7, '2024-10-14 17:47:03.610817', '2024-10-14 17:47:03.610817'),
        (54, 'OTROS', 'OTROS', 48.00, false, 26, 7, '2024-10-14 17:47:08.306078', '2024-10-14 17:47:08.306078');

-- datos usuarios ------------------------------------------------------------------------------------------------------------
insert into public.tb_sica_catalogo_usuarios_sica (id_usuario_sica, responsable, jefe_area, correo, es_staff, id_grupo_usuario, id_usuario, id_departamento, id_gerencia, fecha_creacion, fecha_modificacion, baja)
values  (1, true, true, 'operaciones@724.com.mx', false, 4, 121, 2, 1, '2024-10-14 18:04:33.420734', '2024-10-14 18:04:33.420734', false),
        (2, true, true, 'compras@724.com.mx', false, 4, 2603, 7, 6, '2024-10-14 18:08:55.241435', '2024-10-14 18:08:55.241435', false),
        (3, true, true, 'abastos@724.com.mx', false, 4, 82, 5, 2, '2024-10-14 18:10:47.625256', '2024-10-14 18:10:47.625256', false),
        (4, true, true, 'mercadotecnia@724.com.mx', false, 4, 104, 6, 3, '2024-10-14 18:12:41.429271', '2024-10-14 18:12:41.429271', false),
        (5, true, true, 'recursoshumanos@724.com.mx', false, 4, 2836, 1, 4, '2024-10-14 18:14:14.101943', '2024-10-14 18:14:14.101943', false),
        (6, true, true, 'auditoria@724.com.mx', false, 4, 84, 8, 7, '2024-10-14 18:15:12.698875', '2024-10-14 18:15:12.698875', false),
        (7, true, true, 'administracion@724.com.mx', false, 4, 1680, 9, 8, '2024-10-14 18:16:23.072565', '2024-10-14 18:16:23.072565', false),
        (8, true, true, 'sistemas@724.com.mx', false, 4, 2054, 3, 5, '2024-10-14 18:17:51.004042', '2024-10-14 18:17:51.004042', false),
        (9, false, false, 'soporte1.sistemas@724.com.mx', true, 2, 3207, 3, 5, '2024-10-14 18:20:01.242607', '2024-10-14 18:20:01.242607', false),
        (10, false, false, 'soporte2.sistemas@724.com.mx', true, 2, 972, 3, 5, '2024-10-14 18:21:08.340192', '2024-10-14 18:21:08.340192', false),
        (11, false, false, 'soporte1.sistemas@724.com.mx', true, 2, 92, 3, 5, '2024-10-14 18:22:15.350526', '2024-10-14 18:22:15.350526', false),
        (12, false, false, 'adm.sistemas@724.com.mx', true, 2, 77, 3, 5, '2024-10-14 18:23:19.105915', '2024-10-14 18:23:19.105915', false);

-- relacion usuarios grupos responsables

insert into public.tb_sica_relacion_usuarios_grupo_responsables (id_usuario, id_grupo_usuario_responsable)
values  (972, 3),
        (92, 3),
        (77, 3),
        (3207, 3),
        (121, 2),
        (2836, 1),
        (82, 4),
        (104, 5),
        (84, 7),
        (2603, 6),
        (1680, 8),
        (2054, 3),
        (1, 1),
        (1, 2),
        (1, 3),
        (1, 4),
        (1, 5),
        (1, 6),
        (1, 7),
        (1, 8);