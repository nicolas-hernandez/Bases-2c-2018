--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: Departamento; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."Departamento" ("idDepartamento", nombre, descripcion) VALUES (1, 'Belgrano', '');
INSERT INTO tp1."Departamento" ("idDepartamento", nombre, descripcion) VALUES (2, 'Caballito', '');
INSERT INTO tp1."Departamento" ("idDepartamento", nombre, descripcion) VALUES (3, 'Barracas', '');
INSERT INTO tp1."Departamento" ("idDepartamento", nombre, descripcion) VALUES (4, 'Avellaneda', '');
INSERT INTO tp1."Departamento" ("idDepartamento", nombre, descripcion) VALUES (5, 'San Isidro', '');
INSERT INTO tp1."Departamento" ("idDepartamento", nombre, descripcion) VALUES (6, 'Recoleta', '');
INSERT INTO tp1."Departamento" ("idDepartamento", nombre, descripcion) VALUES (7, 'San Telmo', '');
INSERT INTO tp1."Departamento" ("idDepartamento", nombre, descripcion) VALUES (8, 'Moron', '');
INSERT INTO tp1."Departamento" ("idDepartamento", nombre, descripcion) VALUES (9, 'Adrogue', '');


--
-- Data for Name: Designacion; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."Designacion" ("idDesignacion", nombre) VALUES (1, 'Transito');
INSERT INTO tp1."Designacion" ("idDesignacion", nombre) VALUES (2, 'Vigilancia Bancaria');
INSERT INTO tp1."Designacion" ("idDesignacion", nombre) VALUES (3, 'Espionaje');
INSERT INTO tp1."Designacion" ("idDesignacion", nombre) VALUES (4, 'Patrullaje');
INSERT INTO tp1."Designacion" ("idDesignacion", nombre) VALUES (5, 'SWAT');
INSERT INTO tp1."Designacion" ("idDesignacion", nombre) VALUES (6, 'Narcotrafico');
INSERT INTO tp1."Designacion" ("idDesignacion", nombre) VALUES (7, 'Policia Cientifica');
INSERT INTO tp1."Designacion" ("idDesignacion", nombre) VALUES (8, 'Delitos financieros');
INSERT INTO tp1."Designacion" ("idDesignacion", nombre) VALUES (9, 'Cybercrimen');
INSERT INTO tp1."Designacion" ("idDesignacion", nombre) VALUES (10, 'Antiterrorista');


--
-- Data for Name: Oficial; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."Oficial" (placa, dni, nombre, apellido, rango, "fechaIngreso", tipo, "idDepartamento") VALUES (1, 25346251, 'Pablo', 'Megueres', 'Coronel', '2008-03-04', NULL, 1);
INSERT INTO tp1."Oficial" (placa, dni, nombre, apellido, rango, "fechaIngreso", tipo, "idDepartamento") VALUES (4, 14276572, 'Erica', 'Trungetili', 'Teniente', '2012-11-10', NULL, 1);
INSERT INTO tp1."Oficial" (placa, dni, nombre, apellido, rango, "fechaIngreso", tipo, "idDepartamento") VALUES (5, 23468131, 'Fabian', 'Rodriguez', 'Cabp', '2011-02-04', NULL, 8);
INSERT INTO tp1."Oficial" (placa, dni, nombre, apellido, rango, "fechaIngreso", tipo, "idDepartamento") VALUES (6, 28624356, 'Cristina', 'Peralta', 'General', '2010-02-04', NULL, 5);
INSERT INTO tp1."Oficial" (placa, dni, nombre, apellido, rango, "fechaIngreso", tipo, "idDepartamento") VALUES (8, 14534652, 'Mariana', 'Pineri', 'Coronel', '2011-05-04', NULL, 9);
INSERT INTO tp1."Oficial" (placa, dni, nombre, apellido, rango, "fechaIngreso", tipo, "idDepartamento") VALUES (9, 28246324, 'Nestor', 'Williams', 'Cabo', '2010-05-04', NULL, 3);
INSERT INTO tp1."Oficial" (placa, dni, nombre, apellido, rango, "fechaIngreso", tipo, "idDepartamento") VALUES (10, 32565470, 'Camilo', 'Petrassi', 'General', '2010-02-01', NULL, 2);
INSERT INTO tp1."Oficial" (placa, dni, nombre, apellido, rango, "fechaIngreso", tipo, "idDepartamento") VALUES (3, 15349526, 'Daniel', 'Perez', 'Teniente', '2010-02-05', 'Investigador', 1);
INSERT INTO tp1."Oficial" (placa, dni, nombre, apellido, rango, "fechaIngreso", tipo, "idDepartamento") VALUES (7, 35246243, 'Roque', 'Villalba', 'Teniente', '2011-02-04', 'Investigador', 4);
INSERT INTO tp1."Oficial" (placa, dni, nombre, apellido, rango, "fechaIngreso", tipo, "idDepartamento") VALUES (2, 15349524, 'Jorge', 'Perez', 'Teniente', '2010-02-05', 'Investigador', 1);


--
-- Data for Name: Asignacion; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (1, '2008-03-04', 1, 1);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (2, '2010-03-04', 4, 1);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (3, '2010-02-05', 1, 2);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (4, '2014-02-05', 7, 2);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (5, '2010-02-05', 2, 3);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (6, '2015-05-05', 8, 3);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (7, '2012-11-10', 4, 4);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (8, '2016-11-10', 5, 4);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (9, '2011-02-04', 7, 5);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (10, '2013-02-04', 10, 5);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (11, '2010-02-04', 6, 6);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (12, '2018-02-04', 6, 6);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (13, '2011-02-04', 4, 7);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (14, '2017-02-04', 7, 7);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (15, '2011-05-04', 8, 8);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (16, '2012-05-04', 5, 8);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (17, '2010-05-04', 9, 9);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (18, '2010-05-04', 3, 9);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (19, '2010-02-01', 10, 10);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (21, '2016-02-01', 8, 10);
INSERT INTO tp1."Asignacion" ("idAsignacion", "fechaInicio", "idDesignacion", placa) VALUES (20, '2013-02-01', 7, 10);


--
-- Data for Name: Barrio; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."Barrio" ("idBarrio", nombre) VALUES (5, 'San Isidro');
INSERT INTO tp1."Barrio" ("idBarrio", nombre) VALUES (6, 'Recoleta');
INSERT INTO tp1."Barrio" ("idBarrio", nombre) VALUES (7, 'sAN TELMO');
INSERT INTO tp1."Barrio" ("idBarrio", nombre) VALUES (9, 'Adrogue');
INSERT INTO tp1."Barrio" ("idBarrio", nombre) VALUES (1, 'Belgrano');
INSERT INTO tp1."Barrio" ("idBarrio", nombre) VALUES (2, 'Caballito');
INSERT INTO tp1."Barrio" ("idBarrio", nombre) VALUES (3, 'Barracas');
INSERT INTO tp1."Barrio" ("idBarrio", nombre) VALUES (4, 'Avellaneda');
INSERT INTO tp1."Barrio" ("idBarrio", nombre) VALUES (8, 'Moron');


--
-- Data for Name: Civil; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (2, 'Dick', 'Grayson');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (5, 'Clark', 'Kent');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (4, 'Peter', 'Parker');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (1, 'Bruce', 'Wayne');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (3, 'Diego', 'Maradona');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (6, 'Arthur', 'Curry');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (7, 'Luke', 'Skywalker');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (8, 'Dieg', 'de la Vega');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (100, 'Joker', 'Joker');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (101, 'Alexander', 'Luthor');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (102, 'Antonio', 'Dorrance');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (103, 'Selina', 'Kyle');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (104, 'Oswald', 'Cobblepot');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (106, 'Anakin', 'Skywalker');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (107, 'Sheev', 'Palpatine');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (108, 'Bob', 'Page');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (109, 'Julio', 'Grondona');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (110, 'Joseph', 'Blatter');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (200, 'Eric', 'Dolphy');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (201, 'Andrew', 'Hill');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (202, 'Stan', 'Kenton');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (203, 'Grahan', 'Moncur');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (204, 'Bobby', 'Hutcherson');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (205, 'Jack', 'McLean');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (206, 'Cecil', 'Taylor');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (207, 'Carla', 'Bley');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (208, 'Ron', 'Carter');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (210, 'Mal', 'Waldron');
INSERT INTO tp1."Civil" (dni, nombre, apellido) VALUES (209, 'Tim', 'Berne');


--
-- Data for Name: TipoRelacion; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."TipoRelacion" ("idTipoRelacion", nombre) VALUES (1, 'Amistad');
INSERT INTO tp1."TipoRelacion" ("idTipoRelacion", nombre) VALUES (2, 'Compañerismo');
INSERT INTO tp1."TipoRelacion" ("idTipoRelacion", nombre) VALUES (3, 'Amorosa');
INSERT INTO tp1."TipoRelacion" ("idTipoRelacion", nombre) VALUES (4, 'Familiar');
INSERT INTO tp1."TipoRelacion" ("idTipoRelacion", nombre) VALUES (5, 'Enemigo');


--
-- Data for Name: Conocimiento; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."Conocimiento" (conocedor, conocido, "fechaConocimiento", "idTipoRelacion") VALUES (1, 2, '2008-05-05', 1);
INSERT INTO tp1."Conocimiento" (conocedor, conocido, "fechaConocimiento", "idTipoRelacion") VALUES (2, 1, '2008-05-05', 1);
INSERT INTO tp1."Conocimiento" (conocedor, conocido, "fechaConocimiento", "idTipoRelacion") VALUES (7, 106, '2008-05-05', 1);
INSERT INTO tp1."Conocimiento" (conocedor, conocido, "fechaConocimiento", "idTipoRelacion") VALUES (106, 7, '2008-05-05', 4);


--
-- Data for Name: Direccion; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (1, '9 de Julio', 251, 6);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (2, 'San Martin', 1250, 2);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (3, 'San Martin', 1270, 2);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (4, 'San Martin', 1250, 4);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (5, 'Belgrano', 103, 4);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (6, 'Belgrano', 1122, 4);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (7, 'Hipolito Yrigoyen', 701, 5);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (8, 'Marcelo Alvear', 802, 5);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (9, 'Marcelo Alvear', 202, 5);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (10, 'Marcelo Alvear', 380, 6);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (11, 'Juan Domingo Peron', 1710, 4);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (12, 'Juan Domingo Peron', 1017, 4);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (13, 'Juan Domingo Peron', 1945, 7);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (14, 'JUlio Roca', 1945, 8);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (16, 'Guillermo Brown', 256, 9);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (17, 'Guillermo Brown', 323, 9);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (18, 'Cabildo', 5540, 1);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (19, 'Cabildo', 5545, 1);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (20, 'Cabildo', 6540, 1);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (21, 'Cabildo', 7213, 1);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (22, 'Iriarte', 2456, 3);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (23, 'Iriarte', 2356, 3);
INSERT INTO tp1."Direccion" ("idDireccion", calle, altura, "idBarrio") VALUES (24, 'Iriarte', 250, 3);


--
-- Data for Name: Superheroe; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."Superheroe" ("idSuperHeroe", nombre, color_capa, dni, color_disfraz) VALUES (2, 'Robin', 'Amarilla', 2, '');
INSERT INTO tp1."Superheroe" ("idSuperHeroe", nombre, color_capa, dni, color_disfraz) VALUES (5, 'Superman', 'Roja', 5, '');
INSERT INTO tp1."Superheroe" ("idSuperHeroe", nombre, color_capa, dni, color_disfraz) VALUES (4, 'Spiderman', 'Roja', 4, '');
INSERT INTO tp1."Superheroe" ("idSuperHeroe", nombre, color_capa, dni, color_disfraz) VALUES (1, 'Batman', 'Negra', 1, '');
INSERT INTO tp1."Superheroe" ("idSuperHeroe", nombre, color_capa, dni, color_disfraz) VALUES (3, 'Barrilete Cosmico', 'celeste', 3, '');
INSERT INTO tp1."Superheroe" ("idSuperHeroe", nombre, color_capa, dni, color_disfraz) VALUES (6, 'Aquaman', 'Azul', 6, '');
INSERT INTO tp1."Superheroe" ("idSuperHeroe", nombre, color_capa, dni, color_disfraz) VALUES (50, 'Obi Wan Kenobi', 'Marron', NULL, '');
INSERT INTO tp1."Superheroe" ("idSuperHeroe", nombre, color_capa, dni, color_disfraz) VALUES (7, 'Luke Skywalker', 'Verde', 7, '');
INSERT INTO tp1."Superheroe" ("idSuperHeroe", nombre, color_capa, dni, color_disfraz) VALUES (51, 'Goku', 'Amarilla', NULL, '');
INSERT INTO tp1."Superheroe" ("idSuperHeroe", nombre, color_capa, dni, color_disfraz) VALUES (52, 'Vegeta', 'Azul', NULL, '');
INSERT INTO tp1."Superheroe" ("idSuperHeroe", nombre, color_capa, dni, color_disfraz) VALUES (53, 'JC Denton', 'Negra', NULL, '');
INSERT INTO tp1."Superheroe" ("idSuperHeroe", nombre, color_capa, dni, color_disfraz) VALUES (54, 'Geralt', 'Negra', NULL, '');
INSERT INTO tp1."Superheroe" ("idSuperHeroe", nombre, color_capa, dni, color_disfraz) VALUES (55, 'Gandalf', 'Blanca', NULL, '');
INSERT INTO tp1."Superheroe" ("idSuperHeroe", nombre, color_capa, dni, color_disfraz) VALUES (56, 'Jesus de Laferrere', 'Blanca', NULL, '');


--
-- Data for Name: EsContactadoPor; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."EsContactadoPor" ("idSuperHeroe", dni) VALUES (1, 2);
INSERT INTO tp1."EsContactadoPor" ("idSuperHeroe", dni) VALUES (2, 1);
INSERT INTO tp1."EsContactadoPor" ("idSuperHeroe", dni) VALUES (50, 7);


--
-- Data for Name: OrganizacionDelictiva; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."OrganizacionDelictiva" ("idMafia", nombre) VALUES (1, 'Liga de la Injusticia');
INSERT INTO tp1."OrganizacionDelictiva" ("idMafia", nombre) VALUES (2, 'Escuadron Suicida');
INSERT INTO tp1."OrganizacionDelictiva" ("idMafia", nombre) VALUES (3, 'Siths');
INSERT INTO tp1."OrganizacionDelictiva" ("idMafia", nombre) VALUES (4, 'Imperio Galactico');
INSERT INTO tp1."OrganizacionDelictiva" ("idMafia", nombre) VALUES (5, 'AFA');
INSERT INTO tp1."OrganizacionDelictiva" ("idMafia", nombre) VALUES (6, 'FIFA');
INSERT INTO tp1."OrganizacionDelictiva" ("idMafia", nombre) VALUES (7, 'Illuminati');


--
-- Data for Name: EstaCompuestaPor; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."EstaCompuestaPor" ("idMafia", dni) VALUES (1, 100);
INSERT INTO tp1."EstaCompuestaPor" ("idMafia", dni) VALUES (1, 101);
INSERT INTO tp1."EstaCompuestaPor" ("idMafia", dni) VALUES (1, 104);
INSERT INTO tp1."EstaCompuestaPor" ("idMafia", dni) VALUES (1, 103);
INSERT INTO tp1."EstaCompuestaPor" ("idMafia", dni) VALUES (2, 104);
INSERT INTO tp1."EstaCompuestaPor" ("idMafia", dni) VALUES (2, 100);
INSERT INTO tp1."EstaCompuestaPor" ("idMafia", dni) VALUES (2, 102);
INSERT INTO tp1."EstaCompuestaPor" ("idMafia", dni) VALUES (3, 106);
INSERT INTO tp1."EstaCompuestaPor" ("idMafia", dni) VALUES (4, 106);
INSERT INTO tp1."EstaCompuestaPor" ("idMafia", dni) VALUES (7, 108);
INSERT INTO tp1."EstaCompuestaPor" ("idMafia", dni) VALUES (4, 107);
INSERT INTO tp1."EstaCompuestaPor" ("idMafia", dni) VALUES (3, 107);
INSERT INTO tp1."EstaCompuestaPor" ("idMafia", dni) VALUES (5, 109);
INSERT INTO tp1."EstaCompuestaPor" ("idMafia", dni) VALUES (6, 109);
INSERT INTO tp1."EstaCompuestaPor" ("idMafia", dni) VALUES (6, 110);


--
-- Data for Name: EstadoSeguimiento; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."EstadoSeguimiento" ("idEstadoSeguimiento", estado) VALUES (1, 'Pendiente');
INSERT INTO tp1."EstadoSeguimiento" ("idEstadoSeguimiento", estado) VALUES (2, 'En Proceso');
INSERT INTO tp1."EstadoSeguimiento" ("idEstadoSeguimiento", estado) VALUES (3, 'Cerrado');


--
-- Data for Name: EstadoSumario; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."EstadoSumario" ("idEstadoSumario", estado) VALUES (1, 'Iniciado');
INSERT INTO tp1."EstadoSumario" ("idEstadoSumario", estado) VALUES (2, 'En Proceso');
INSERT INTO tp1."EstadoSumario" ("idEstadoSumario", estado) VALUES (3, 'Concluyo');


--
-- Data for Name: Habilidad; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."Habilidad" ("idHabilidad", nombre) VALUES (1, 'Sable Laser');
INSERT INTO tp1."Habilidad" ("idHabilidad", nombre) VALUES (2, 'La fuerza');
INSERT INTO tp1."Habilidad" ("idHabilidad", nombre) VALUES (3, 'Gambetear');
INSERT INTO tp1."Habilidad" ("idHabilidad", nombre) VALUES (4, 'Trepar');
INSERT INTO tp1."Habilidad" ("idHabilidad", nombre) VALUES (5, 'Artes Marciales');
INSERT INTO tp1."Habilidad" ("idHabilidad", nombre) VALUES (7, 'Volar');
INSERT INTO tp1."Habilidad" ("idHabilidad", nombre) VALUES (8, 'Nadar');
INSERT INTO tp1."Habilidad" ("idHabilidad", nombre) VALUES (9, 'Espada');
INSERT INTO tp1."Habilidad" ("idHabilidad", nombre) VALUES (10, 'Genki-dama');
INSERT INTO tp1."Habilidad" ("idHabilidad", nombre) VALUES (11, 'kamehameha');
INSERT INTO tp1."Habilidad" ("idHabilidad", nombre) VALUES (12, 'Respawnear al tercer dia');
INSERT INTO tp1."Habilidad" ("idHabilidad", nombre) VALUES (14, 'Magia');
INSERT INTO tp1."Habilidad" ("idHabilidad", nombre) VALUES (15, 'Hacking');
INSERT INTO tp1."Habilidad" ("idHabilidad", nombre) VALUES (16, 'Armas de fuego');


--
-- Data for Name: TipoIncidente; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."TipoIncidente" ("idTipoInicidente", nombre) VALUES (1, 'Accidente');
INSERT INTO tp1."TipoIncidente" ("idTipoInicidente", nombre) VALUES (2, 'Robo');
INSERT INTO tp1."TipoIncidente" ("idTipoInicidente", nombre) VALUES (3, 'Hurto');
INSERT INTO tp1."TipoIncidente" ("idTipoInicidente", nombre) VALUES (4, 'Homicidio');
INSERT INTO tp1."TipoIncidente" ("idTipoInicidente", nombre) VALUES (5, 'Terrorismo');


--
-- Data for Name: Incidente; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."Incidente" ("idIncidente", fecha, calle_1, calle_2, "idTipoInicidente", "idDireccion") VALUES (1, '2018-10-01', 'Gorriti', 'Portugal', 2, 7);
INSERT INTO tp1."Incidente" ("idIncidente", fecha, calle_1, calle_2, "idTipoInicidente", "idDireccion") VALUES (2, '2018-10-04', 'Pavon', 'Mitre', 4, 17);
INSERT INTO tp1."Incidente" ("idIncidente", fecha, calle_1, calle_2, "idTipoInicidente", "idDireccion") VALUES (3, '2018-10-09', 'Alcorta', 'Colon', 3, 8);


--
-- Data for Name: RolOficial; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."RolOficial" ("idResponsabilidad", descripcion) VALUES (1, 'Choque');
INSERT INTO tp1."RolOficial" ("idResponsabilidad", descripcion) VALUES (2, 'Indagador');
INSERT INTO tp1."RolOficial" ("idResponsabilidad", descripcion) VALUES (3, 'Perito');


--
-- Data for Name: OficialSeInvolucro; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."OficialSeInvolucro" (placa, "idIncidente", "idResponsabilidad") VALUES (8, 1, 1);
INSERT INTO tp1."OficialSeInvolucro" (placa, "idIncidente", "idResponsabilidad") VALUES (1, 1, 2);
INSERT INTO tp1."OficialSeInvolucro" (placa, "idIncidente", "idResponsabilidad") VALUES (2, 2, 3);
INSERT INTO tp1."OficialSeInvolucro" (placa, "idIncidente", "idResponsabilidad") VALUES (8, 3, 2);
INSERT INTO tp1."OficialSeInvolucro" (placa, "idIncidente", "idResponsabilidad") VALUES (6, 3, 1);


--
-- Data for Name: Posee; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (3, 3);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (5, 7);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (1, 5);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (2, 5);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (4, 4);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (4, 5);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (50, 1);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (50, 2);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (7, 1);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (7, 2);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (5, 8);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (6, 8);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (51, 10);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (51, 11);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (51, 5);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (52, 5);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (53, 15);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (53, 16);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (54, 9);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (54, 14);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (55, 14);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (55, 9);
INSERT INTO tp1."Posee" ("idSuperHeroe", "idHabilidad") VALUES (56, 12);


--
-- Data for Name: RolCivil; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."RolCivil" ("idRolCivil", nombre) VALUES (1, 'Victima');
INSERT INTO tp1."RolCivil" ("idRolCivil", nombre) VALUES (2, 'Sospechoso');
INSERT INTO tp1."RolCivil" ("idRolCivil", nombre) VALUES (3, 'Testigo');


--
-- Data for Name: SeInvolucraron; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."SeInvolucraron" (dni, "idIncidente", "idRolCivil") VALUES (202, 1, 1);
INSERT INTO tp1."SeInvolucraron" (dni, "idIncidente", "idRolCivil") VALUES (102, 1, 2);
INSERT INTO tp1."SeInvolucraron" (dni, "idIncidente", "idRolCivil") VALUES (100, 2, 2);
INSERT INTO tp1."SeInvolucraron" (dni, "idIncidente", "idRolCivil") VALUES (203, 2, 1);
INSERT INTO tp1."SeInvolucraron" (dni, "idIncidente", "idRolCivil") VALUES (207, 3, 1);
INSERT INTO tp1."SeInvolucraron" (dni, "idIncidente", "idRolCivil") VALUES (210, 3, 3);
INSERT INTO tp1."SeInvolucraron" (dni, "idIncidente", "idRolCivil") VALUES (107, 3, 2);


--
-- Data for Name: Seguimiento; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."Seguimiento" (numero, fecha, descripcion, conclusion, "idIncidente", placa, "idEstadoSeguimiento") VALUES (1, '2018-10-08', NULL, NULL, 1, 2, 2);
INSERT INTO tp1."Seguimiento" (numero, fecha, descripcion, conclusion, "idIncidente", placa, "idEstadoSeguimiento") VALUES (2, '2018-10-09', NULL, NULL, 1, 9, 2);
INSERT INTO tp1."Seguimiento" (numero, fecha, descripcion, conclusion, "idIncidente", placa, "idEstadoSeguimiento") VALUES (3, '2018-10-11', NULL, NULL, 1, NULL, 1);
INSERT INTO tp1."Seguimiento" (numero, fecha, descripcion, conclusion, "idIncidente", placa, "idEstadoSeguimiento") VALUES (4, '2018-10-12', 'Buscando al asesino', 'No se encontro nada', 2, NULL, 3);


--
-- Data for Name: Sumario; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--



--
-- Data for Name: SuperParticipo; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."SuperParticipo" ("idSuperHeroe", "idIncidente") VALUES (7, 1);
INSERT INTO tp1."SuperParticipo" ("idSuperHeroe", "idIncidente") VALUES (1, 2);
INSERT INTO tp1."SuperParticipo" ("idSuperHeroe", "idIncidente") VALUES (3, 3);
INSERT INTO tp1."SuperParticipo" ("idSuperHeroe", "idIncidente") VALUES (6, 3);


--
-- Data for Name: ViveEn; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (1, 1, '2010-02-03');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (1, 5, '2012-04-07');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (1, 8, '2016-11-15');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (2, 8, '2017-12-08');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (2, 4, '2011-01-05');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (3, 3, '2011-05-05');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (3, 7, '2018-05-05');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (4, 11, '2009-04-05');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (4, 2, '2012-04-05');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (4, 9, '2018-07-05');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (5, 12, '2012-07-06');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (5, 1, '2016-08-08');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (6, 13, '2013-09-16');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (6, 8, '2017-12-12');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (7, 3, '2015-12-12');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (7, 11, '2018-04-13');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (8, 12, '2010-02-04');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (8, 20, '2015-04-04');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (100, 21, '2015-05-05');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (100, 22, '2016-05-05');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (100, 17, '2018-05-05');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (101, 16, '2012-07-05');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (101, 17, '2016-07-05');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (102, 14, '2010-06-28');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (102, 23, '2015-06-28');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (102, 20, '2018-06-28');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (103, 20, '2014-06-28');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (103, 1, '2017-06-28');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (104, 6, '2011-06-28');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (104, 8, '2015-06-28');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (106, 12, '2013-06-28');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (106, 20, '2018-06-28');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (107, 4, '2012-06-28');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (107, 9, '2017-06-28');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (108, 19, '2017-07-07');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (109, 7, '2010-07-07');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (110, 12, '2013-07-07');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (200, 2, '2011-07-07');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (200, 14, '2018-07-07');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (201, 14, '2010-04-26');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (202, 13, '2010-04-26');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (202, 9, '2012-04-26');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (203, 19, '2015-04-26');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (203, 22, '2017-04-26');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (204, 11, '2016-08-15');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (205, 6, '2012-08-15');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (205, 20, '2012-08-15');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (206, 20, '2012-08-15');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (206, 3, '2018-08-15');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (207, 8, '2010-08-15');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (208, 8, '2009-08-15');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (209, 16, '2015-08-15');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (209, 10, '2016-02-02');
INSERT INTO tp1."ViveEn" (dni, "idDireccion", "fechaInicio") VALUES (210, 4, '2018-02-02');


--
-- Data for Name: archienemigoDe; Type: TABLE DATA; Schema: tp1; Owner: grupo_01
--

INSERT INTO tp1."archienemigoDe" ("idSuperHeroe", dni) VALUES (1, 100);
INSERT INTO tp1."archienemigoDe" ("idSuperHeroe", dni) VALUES (1, 101);
INSERT INTO tp1."archienemigoDe" ("idSuperHeroe", dni) VALUES (1, 102);
INSERT INTO tp1."archienemigoDe" ("idSuperHeroe", dni) VALUES (1, 104);
INSERT INTO tp1."archienemigoDe" ("idSuperHeroe", dni) VALUES (2, 100);
INSERT INTO tp1."archienemigoDe" ("idSuperHeroe", dni) VALUES (2, 101);
INSERT INTO tp1."archienemigoDe" ("idSuperHeroe", dni) VALUES (3, 109);
INSERT INTO tp1."archienemigoDe" ("idSuperHeroe", dni) VALUES (3, 110);
INSERT INTO tp1."archienemigoDe" ("idSuperHeroe", dni) VALUES (53, 108);
INSERT INTO tp1."archienemigoDe" ("idSuperHeroe", dni) VALUES (5, 101);
INSERT INTO tp1."archienemigoDe" ("idSuperHeroe", dni) VALUES (50, 106);
INSERT INTO tp1."archienemigoDe" ("idSuperHeroe", dni) VALUES (50, 107);
INSERT INTO tp1."archienemigoDe" ("idSuperHeroe", dni) VALUES (7, 107);
INSERT INTO tp1."archienemigoDe" ("idSuperHeroe", dni) VALUES (7, 106);


--
-- PostgreSQL database dump complete
--

