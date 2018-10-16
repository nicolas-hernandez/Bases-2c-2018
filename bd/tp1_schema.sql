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
-- Name: tp1; Type: SCHEMA; Schema: -; Owner: grupo_01
--

CREATE SCHEMA tp1;


ALTER SCHEMA tp1 OWNER TO grupo_01;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: archienemigo_de_no_es_el_mismo(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.archienemigo_de_no_es_el_mismo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT * FROM tp1.superheroe sh, tp1.civil c where new.id_sh = sh.id_sh and c.dni = new.dni and sh.dni is not null and sh.dni = new.dni ) THEN
      RAISE EXCEPTION 'no puede ser archienemigo de si mismo';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.archienemigo_de_no_es_el_mismo() OWNER TO grupo_01;

--
-- Name: asignacion_fecha_mayor_a_oficial(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.asignacion_fecha_mayor_a_oficial() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT * FROM tp1.oficial o where new.placa = o.placa and new.fecha_inicio < o.fecha_ingreso ) THEN
      RAISE EXCEPTION 'fecha de asignacion menor a fecha de ingreso del oficial';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.asignacion_fecha_mayor_a_oficial() OWNER TO grupo_01;

--
-- Name: asignacion_placa_fk(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.asignacion_placa_fk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (SELECT * FROM tp1.oficial o where new.placa = o.placa ) THEN
      RAISE EXCEPTION 'No existe ese oficial';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.asignacion_placa_fk() OWNER TO grupo_01;

--
-- Name: dni_oficiales_civiles(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.dni_oficiales_civiles() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    IF EXISTS (SELECT * FROM tp1.civil c where new.dni = c.dni ) THEN
      RAISE EXCEPTION 'No puede haber un oficial con mismo dni que un civil';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.dni_oficiales_civiles() OWNER TO grupo_01;

--
-- Name: oficial_se_involucro_fecha(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.oficial_se_involucro_fecha() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    IF EXISTS (SELECT * FROM tp1.oficial o, tp1.incidente i where new.placa = o.placa and i.id_incidente = new.id_incidente and i.fecha < o.fecha_ingreso ) THEN
      RAISE EXCEPTION 'Fecha de oficial menor a fecha de incidente';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.oficial_se_involucro_fecha() OWNER TO grupo_01;

--
-- Name: seguimiento_al_cerrarse_no_puede_cambiar(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.seguimiento_al_cerrarse_no_puede_cambiar() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT * FROM tp1.estado_seguimiento e where new.id_estado_seg = e.id_estado_seg and e.id_estado_seg != 3 and old.id_estado_seg = 3 ) THEN
      RAISE EXCEPTION 'seguimiento al cerrare no puede cambiar de estado';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.seguimiento_al_cerrarse_no_puede_cambiar() OWNER TO grupo_01;

--
-- Name: seguimiento_conclusion(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.seguimiento_conclusion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    IF EXISTS (SELECT * FROM tp1.estado_seguimiento e where new.id_estado_seg = e.id_estado_seg and ( (e.id_estado_seg = 3 and new.conclusion is NULL) or (e.id_estado_seg != 3 and new.conclusion is not NULL) )  ) THEN
      RAISE EXCEPTION 'al cerrarse se tiene una conclusion';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.seguimiento_conclusion() OWNER TO grupo_01;

--
-- Name: seguimiento_fecha_incidente(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.seguimiento_fecha_incidente() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    IF EXISTS (SELECT * FROM tp1.incidente i where i.id_incidente = new.id_incidente and new.fecha < i.fecha ) THEN
      RAISE EXCEPTION 'fecha incidente menor a fecha de seguimiento';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.seguimiento_fecha_incidente() OWNER TO grupo_01;

--
-- Name: seguimiento_fecha_oficial(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.seguimiento_fecha_oficial() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    IF EXISTS (SELECT * FROM tp1.oficial o where o.placa = new.placa and new.fecha < o.fecha_ingreso ) THEN
      RAISE EXCEPTION 'fehcha de ingreos de oficial mayor a fecha de seguimiento';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.seguimiento_fecha_oficial() OWNER TO grupo_01;

--
-- Name: seguimiento_placa_fk(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.seguimiento_placa_fk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    IF new.id_estado_seg = 2 and NOT EXISTS (SELECT * FROM tp1.estado_seguimiento e, tp1.oficial o where new.id_estado_seg = e.id_estado_seg and e.id_estado_seg = 2 and new.placa = o.placa  ) THEN
      RAISE EXCEPTION 'clave foranea';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.seguimiento_placa_fk() OWNER TO grupo_01;

--
-- Name: seguimiento_seguida_si_en_proceso(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.seguimiento_seguida_si_en_proceso() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    IF EXISTS (SELECT * FROM tp1.estado_seguimiento e where new.id_estado_seg = e.id_estado_seg and ((e.id_estado_seg = 2 and new.placa is NULL) or (e.id_estado_seg != 2 and new.placa is not NULL) ) ) THEN
      RAISE EXCEPTION 'Solo puede ser seguido cuando esta en proceso';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.seguimiento_seguida_si_en_proceso() OWNER TO grupo_01;

--
-- Name: sumario_concluyo_tiene_resultado(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.sumario_concluyo_tiene_resultado() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    IF EXISTS (SELECT * FROM tp1.estado_sumario e where new.id_estado_sumario = 3 and new.resultado IS NULL ) THEN
      RAISE EXCEPTION 'Si concluyo tiene resultado';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.sumario_concluyo_tiene_resultado() OWNER TO grupo_01;

--
-- Name: sumario_fecha_mayor_asignacion(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.sumario_fecha_mayor_asignacion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    IF EXISTS (SELECT * FROM tp1.asignacion a where new.id_asignacion = a.id_asignacion and new.fecha < a.fecha_inicio ) THEN
      RAISE EXCEPTION 'fecha de sumario menor a la de asignacion';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.sumario_fecha_mayor_asignacion() OWNER TO grupo_01;

--
-- Name: sumario_fecha_mayor_investigador(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.sumario_fecha_mayor_investigador() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT * FROM tp1.investigador i where new.placa = i.placa and new.fecha < i.fecha_ingreso ) THEN
      RAISE EXCEPTION 'fecha sumario menor a fecha de ingreso del investigador';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.sumario_fecha_mayor_investigador() OWNER TO grupo_01;

--
-- Name: sumario_investigador_no_investigado(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.sumario_investigador_no_investigado() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    IF EXISTS (SELECT * FROM tp1.asignacion a where new.id_asignacion = a.id_asignacion and new.placa = a.placa ) THEN
      RAISE EXCEPTION 'Un investigador no puede investigarse a si mismo';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.sumario_investigador_no_investigado() OWNER TO grupo_01;

--
-- Name: superheroeo_no_delincuente(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.superheroeo_no_delincuente() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT * FROM tp1.civil c, tp1.esta_compuesta_por comp where new.dni = c.dni and comp.dni = new.dni) THEN
      RAISE EXCEPTION 'No puede haber un oficial con mismo dni que un civil';              
    END IF;
    RETURN NULL;
  END;

$$;


ALTER FUNCTION tp1.superheroeo_no_delincuente() OWNER TO grupo_01;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: archienemigo_de; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.archienemigo_de (
    id_sh integer NOT NULL,
    dni integer NOT NULL
);


ALTER TABLE tp1.archienemigo_de OWNER TO grupo_01;

--
-- Name: asignacion; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.asignacion (
    id_asignacion integer NOT NULL,
    fecha_inicio date NOT NULL,
    id_designacion integer NOT NULL,
    placa integer NOT NULL
);


ALTER TABLE tp1.asignacion OWNER TO grupo_01;

--
-- Name: barrio; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.barrio (
    id_barrio integer NOT NULL,
    nombre character(250) NOT NULL
);


ALTER TABLE tp1.barrio OWNER TO grupo_01;

--
-- Name: civil; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.civil (
    dni integer NOT NULL,
    nombre character(250) NOT NULL,
    apellido character(250) NOT NULL
);


ALTER TABLE tp1.civil OWNER TO grupo_01;

--
-- Name: conocimiento; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.conocimiento (
    conocedor integer NOT NULL,
    conocido integer NOT NULL,
    fecha_conocimiento date NOT NULL,
    id_tipo_de_relacion integer NOT NULL
);


ALTER TABLE tp1.conocimiento OWNER TO grupo_01;

--
-- Name: departamento; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.departamento (
    id_departamento integer NOT NULL,
    nombre character(250) NOT NULL
);


ALTER TABLE tp1.departamento OWNER TO grupo_01;

--
-- Name: designacion; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.designacion (
    id_designacion integer NOT NULL,
    nombre character(250) NOT NULL
);


ALTER TABLE tp1.designacion OWNER TO grupo_01;

--
-- Name: direccion; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.direccion (
    id_direccion integer NOT NULL,
    calle character(250) NOT NULL,
    altura integer NOT NULL,
    id_barrio integer NOT NULL
);


ALTER TABLE tp1.direccion OWNER TO grupo_01;

--
-- Name: es_contactado_por; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.es_contactado_por (
    id_sh integer NOT NULL,
    dni integer NOT NULL
);


ALTER TABLE tp1.es_contactado_por OWNER TO grupo_01;

--
-- Name: esta_compuesta_por; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.esta_compuesta_por (
    id_mafia integer NOT NULL,
    dni integer NOT NULL
);


ALTER TABLE tp1.esta_compuesta_por OWNER TO grupo_01;

--
-- Name: estado_seguimiento; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.estado_seguimiento (
    id_estado_seg integer NOT NULL,
    estado character(250) NOT NULL
);


ALTER TABLE tp1.estado_seguimiento OWNER TO grupo_01;

--
-- Name: estado_sumario; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.estado_sumario (
    id_estado_sumario integer NOT NULL,
    estado character(25) NOT NULL
);


ALTER TABLE tp1.estado_sumario OWNER TO grupo_01;

--
-- Name: habilidad; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.habilidad (
    id_habilidad integer NOT NULL,
    nombre character(250) NOT NULL
);


ALTER TABLE tp1.habilidad OWNER TO grupo_01;

--
-- Name: incidente; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.incidente (
    id_incidente integer NOT NULL,
    fecha date NOT NULL,
    calle_1 character(250) NOT NULL,
    calle_2 character(250) NOT NULL,
    id_tipo_incidente integer NOT NULL,
    id_direccion integer NOT NULL
);


ALTER TABLE tp1.incidente OWNER TO grupo_01;

--
-- Name: oficial; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.oficial (
    placa integer NOT NULL,
    dni integer NOT NULL,
    nombre character(250) NOT NULL,
    apellido character(250) NOT NULL,
    rango character(250) NOT NULL,
    fecha_ingreso date NOT NULL,
    tipo character(250),
    id_departamento integer NOT NULL
);


ALTER TABLE tp1.oficial OWNER TO grupo_01;

--
-- Name: investigador; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.investigador (
)
INHERITS (tp1.oficial);


ALTER TABLE tp1.investigador OWNER TO grupo_01;

--
-- Name: oficial_se_involucro; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.oficial_se_involucro (
    placa integer NOT NULL,
    id_incidente integer NOT NULL,
    id_responsabilidad integer NOT NULL
);


ALTER TABLE tp1.oficial_se_involucro OWNER TO grupo_01;

--
-- Name: organizacion_delictiva; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.organizacion_delictiva (
    id_mafia integer NOT NULL,
    nombre character(250) NOT NULL
);


ALTER TABLE tp1.organizacion_delictiva OWNER TO grupo_01;

--
-- Name: posee; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.posee (
    id_sh integer NOT NULL,
    id_habilidad integer NOT NULL
);


ALTER TABLE tp1.posee OWNER TO grupo_01;

--
-- Name: rol_civil; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.rol_civil (
    id_rol_civil integer NOT NULL,
    nombre character(250) NOT NULL
);


ALTER TABLE tp1.rol_civil OWNER TO grupo_01;

--
-- Name: rol_oficial; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.rol_oficial (
    id_responsabilidad integer NOT NULL,
    descripcion character(250) NOT NULL
);


ALTER TABLE tp1.rol_oficial OWNER TO grupo_01;

--
-- Name: se_involucraron; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.se_involucraron (
    dni integer NOT NULL,
    id_incidente integer NOT NULL,
    id_rol_civil integer NOT NULL
);


ALTER TABLE tp1.se_involucraron OWNER TO grupo_01;

--
-- Name: seguimiento; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.seguimiento (
    numero integer NOT NULL,
    fecha date NOT NULL,
    descripcion character(250),
    conclusion character(250),
    id_incidente integer NOT NULL,
    placa integer,
    id_estado_seg integer NOT NULL
);


ALTER TABLE tp1.seguimiento OWNER TO grupo_01;

--
-- Name: sumario; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.sumario (
    id_sumario integer NOT NULL,
    fecha date NOT NULL,
    observacion character(250),
    resultado character(250),
    placa integer NOT NULL,
    id_asignacion integer NOT NULL,
    id_estado_sumario integer NOT NULL
);


ALTER TABLE tp1.sumario OWNER TO grupo_01;

--
-- Name: super_participo; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.super_participo (
    id_sh integer NOT NULL,
    id_incidente integer NOT NULL
);


ALTER TABLE tp1.super_participo OWNER TO grupo_01;

--
-- Name: superheroe; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.superheroe (
    id_sh integer NOT NULL,
    nombre character(250) NOT NULL,
    color_capa character(250) NOT NULL,
    dni integer
);


ALTER TABLE tp1.superheroe OWNER TO grupo_01;

--
-- Name: tipo_de_incidente; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.tipo_de_incidente (
    id_tipo_incidente integer NOT NULL,
    nombre character(250) NOT NULL
);


ALTER TABLE tp1.tipo_de_incidente OWNER TO grupo_01;

--
-- Name: tipo_de_relacion; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.tipo_de_relacion (
    id_tipo_de_relacion integer NOT NULL,
    nombre character(250) NOT NULL
);


ALTER TABLE tp1.tipo_de_relacion OWNER TO grupo_01;

--
-- Name: vive_en; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1.vive_en (
    dni integer NOT NULL,
    id_direccion integer NOT NULL,
    fecha_inicio date NOT NULL
);


ALTER TABLE tp1.vive_en OWNER TO grupo_01;

--
-- Name: civil Civil_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.civil
    ADD CONSTRAINT "Civil_pkey" PRIMARY KEY (dni);


--
-- Name: departamento Departamento_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.departamento
    ADD CONSTRAINT "Departamento_pkey" PRIMARY KEY (id_departamento);


--
-- Name: direccion Direccion_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.direccion
    ADD CONSTRAINT "Direccion_pkey" PRIMARY KEY (id_direccion);


--
-- Name: incidente Incidente_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.incidente
    ADD CONSTRAINT "Incidente_pkey" PRIMARY KEY (id_incidente);


--
-- Name: organizacion_delictiva Organización_delictiva_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.organizacion_delictiva
    ADD CONSTRAINT "Organización_delictiva_pkey" PRIMARY KEY (id_mafia);


--
-- Name: tipo_de_relacion TipoDeRelacion_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.tipo_de_relacion
    ADD CONSTRAINT "TipoDeRelacion_pkey" PRIMARY KEY (id_tipo_de_relacion);


--
-- Name: tipo_de_incidente TipoIncidente_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.tipo_de_incidente
    ADD CONSTRAINT "TipoIncidente_pkey" PRIMARY KEY (id_tipo_incidente);


--
-- Name: archienemigo_de archienemigo_de_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.archienemigo_de
    ADD CONSTRAINT archienemigo_de_pkey PRIMARY KEY (id_sh, dni);


--
-- Name: asignacion asignacion_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.asignacion
    ADD CONSTRAINT asignacion_pkey PRIMARY KEY (id_asignacion);


--
-- Name: conocimiento conocimiento_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.conocimiento
    ADD CONSTRAINT conocimiento_pkey PRIMARY KEY (conocedor, conocido);


--
-- Name: designacion designacion_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.designacion
    ADD CONSTRAINT designacion_pkey PRIMARY KEY (id_designacion);


--
-- Name: es_contactado_por es_contactado_por_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.es_contactado_por
    ADD CONSTRAINT es_contactado_por_pkey PRIMARY KEY (id_sh, dni);


--
-- Name: esta_compuesta_por esta_compuesta_por_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.esta_compuesta_por
    ADD CONSTRAINT esta_compuesta_por_pkey PRIMARY KEY (id_mafia, dni);


--
-- Name: estado_seguimiento estadoSeguimiento_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.estado_seguimiento
    ADD CONSTRAINT "estadoSeguimiento_pkey" PRIMARY KEY (id_estado_seg);


--
-- Name: estado_sumario estado_sumario_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.estado_sumario
    ADD CONSTRAINT estado_sumario_pkey PRIMARY KEY (id_estado_sumario);


--
-- Name: barrio idBarrio; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.barrio
    ADD CONSTRAINT "idBarrio" PRIMARY KEY (id_barrio);


--
-- Name: investigador investigador_dni_key; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.investigador
    ADD CONSTRAINT investigador_dni_key UNIQUE (dni);


--
-- Name: investigador investigador_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.investigador
    ADD CONSTRAINT investigador_pkey PRIMARY KEY (placa);


--
-- Name: investigador investigador_tipo_check; Type: CHECK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE tp1.investigador
    ADD CONSTRAINT investigador_tipo_check CHECK ((tipo = 'Investigador'::bpchar)) NOT VALID;


--
-- Name: oficial oficial_dni_key; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.oficial
    ADD CONSTRAINT oficial_dni_key UNIQUE (dni);


--
-- Name: oficial oficial_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.oficial
    ADD CONSTRAINT oficial_pkey PRIMARY KEY (placa);


--
-- Name: oficial_se_involucro oficial_se_involucro_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.oficial_se_involucro
    ADD CONSTRAINT oficial_se_involucro_pkey PRIMARY KEY (placa, id_incidente, id_responsabilidad);


--
-- Name: habilidad pk_habilidad; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.habilidad
    ADD CONSTRAINT pk_habilidad PRIMARY KEY (id_habilidad);


--
-- Name: posee posee_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.posee
    ADD CONSTRAINT posee_pkey PRIMARY KEY (id_sh, id_habilidad);


--
-- Name: rol_civil rol_civil_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.rol_civil
    ADD CONSTRAINT rol_civil_pkey PRIMARY KEY (id_rol_civil);


--
-- Name: rol_oficial rol_oficial_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.rol_oficial
    ADD CONSTRAINT rol_oficial_pkey PRIMARY KEY (id_responsabilidad);


--
-- Name: se_involucraron se_involucraron_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.se_involucraron
    ADD CONSTRAINT se_involucraron_pkey PRIMARY KEY (dni, id_incidente);


--
-- Name: seguimiento seguimiento_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.seguimiento
    ADD CONSTRAINT seguimiento_pkey PRIMARY KEY (numero, id_incidente);


--
-- Name: sumario sumario_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.sumario
    ADD CONSTRAINT sumario_pkey PRIMARY KEY (id_sumario);


--
-- Name: super_participo super_participo_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.super_participo
    ADD CONSTRAINT super_participo_pkey PRIMARY KEY (id_sh, id_incidente);


--
-- Name: superheroe superheroe_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.superheroe
    ADD CONSTRAINT superheroe_pkey PRIMARY KEY (id_sh);


--
-- Name: vive_en vive_en_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.vive_en
    ADD CONSTRAINT vive_en_pkey PRIMARY KEY (dni, id_direccion);


--
-- Name: fki_idDireccion; Type: INDEX; Schema: tp1; Owner: grupo_01
--

CREATE INDEX "fki_idDireccion" ON tp1.incidente USING btree (id_direccion);


--
-- Name: fki_idTipoIncidente; Type: INDEX; Schema: tp1; Owner: grupo_01
--

CREATE INDEX "fki_idTipoIncidente" ON tp1.incidente USING btree (id_tipo_incidente);


--
-- Name: fki_superheroe_dni; Type: INDEX; Schema: tp1; Owner: grupo_01
--

CREATE INDEX fki_superheroe_dni ON tp1.superheroe USING btree (dni);


--
-- Name: archienemigo_de check_archienemigo_de_si_mismo; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_archienemigo_de_si_mismo AFTER INSERT OR UPDATE ON tp1.archienemigo_de NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.archienemigo_de_no_es_el_mismo();


--
-- Name: sumario check_concluyo_tiene_resultado; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_concluyo_tiene_resultado AFTER INSERT OR UPDATE ON tp1.sumario NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_concluyo_tiene_resultado();


--
-- Name: oficial check_dni_no_civiles; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_dni_no_civiles AFTER INSERT OR UPDATE ON tp1.oficial NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.dni_oficiales_civiles();


--
-- Name: asignacion check_fecha_inicio_mayor_a_oficial; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_inicio_mayor_a_oficial AFTER INSERT OR UPDATE ON tp1.asignacion NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.asignacion_fecha_mayor_a_oficial();


--
-- Name: sumario check_fecha_mayor_asigancion; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_mayor_asigancion AFTER INSERT OR UPDATE ON tp1.sumario NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_fecha_mayor_asignacion();


--
-- Name: sumario check_fecha_mayor_investigador; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_mayor_investigador AFTER INSERT OR UPDATE ON tp1.sumario NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_fecha_mayor_investigador();


--
-- Name: oficial_se_involucro check_fecha_oficial_involucrado; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_oficial_involucrado AFTER INSERT OR UPDATE ON tp1.oficial_se_involucro NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.oficial_se_involucro_fecha();


--
-- Name: seguimiento check_fecha_seg_incidente; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_seg_incidente AFTER INSERT OR UPDATE ON tp1.seguimiento NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_fecha_incidente();


--
-- Name: seguimiento check_fecha_seg_oficial; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_seg_oficial AFTER INSERT OR UPDATE ON tp1.seguimiento NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_fecha_oficial();


--
-- Name: sumario check_investigador_no_se_investiga; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_investigador_no_se_investiga AFTER INSERT OR UPDATE ON tp1.sumario NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_investigador_no_investigado();


--
-- Name: asignacion check_oficial_fk; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_oficial_fk AFTER INSERT OR UPDATE ON tp1.asignacion NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.asignacion_placa_fk();


--
-- Name: oficial_se_involucro check_se_involucro_placa_fk; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_se_involucro_placa_fk AFTER INSERT OR UPDATE ON tp1.oficial_se_involucro NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.asignacion_placa_fk();


--
-- Name: seguimiento check_seg_conclusion; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_seg_conclusion AFTER INSERT OR UPDATE ON tp1.seguimiento NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_conclusion();


--
-- Name: seguimiento check_seg_placa_fk; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_seg_placa_fk AFTER INSERT OR UPDATE ON tp1.seguimiento NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_placa_fk();


--
-- Name: seguimiento check_seguimiento_cerrado_no_cambia; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_seguimiento_cerrado_no_cambia AFTER UPDATE ON tp1.seguimiento NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_al_cerrarse_no_puede_cambiar();


--
-- Name: seguimiento check_solo_seguido_en_proceso; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_solo_seguido_en_proceso AFTER INSERT OR UPDATE ON tp1.seguimiento NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_seguida_si_en_proceso();


--
-- Name: superheroe check_superheroeo_no_delincuente; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_superheroeo_no_delincuente AFTER INSERT OR UPDATE ON tp1.superheroe NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.superheroeo_no_delincuente();


--
-- Name: archienemigo_de archienemigo_de_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.archienemigo_de
    ADD CONSTRAINT archienemigo_de_dni_fkey FOREIGN KEY (dni) REFERENCES tp1.civil(dni);


--
-- Name: archienemigo_de archienemigo_de_id_sh_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.archienemigo_de
    ADD CONSTRAINT archienemigo_de_id_sh_fkey FOREIGN KEY (id_sh) REFERENCES tp1.superheroe(id_sh);


--
-- Name: asignacion asignacion_id_designacion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.asignacion
    ADD CONSTRAINT asignacion_id_designacion_fkey FOREIGN KEY (id_designacion) REFERENCES tp1.designacion(id_designacion);


--
-- Name: conocimiento conocimiento_conocedor_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.conocimiento
    ADD CONSTRAINT conocimiento_conocedor_fkey FOREIGN KEY (conocedor) REFERENCES tp1.civil(dni);


--
-- Name: conocimiento conocimiento_conocido_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.conocimiento
    ADD CONSTRAINT conocimiento_conocido_fkey FOREIGN KEY (conocido) REFERENCES tp1.civil(dni);


--
-- Name: conocimiento conocimiento_id_tipo_de_relacion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.conocimiento
    ADD CONSTRAINT conocimiento_id_tipo_de_relacion_fkey FOREIGN KEY (id_tipo_de_relacion) REFERENCES tp1.tipo_de_relacion(id_tipo_de_relacion);


--
-- Name: direccion direccion_id_barrio_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.direccion
    ADD CONSTRAINT direccion_id_barrio_fkey FOREIGN KEY (id_barrio) REFERENCES tp1.barrio(id_barrio);


--
-- Name: es_contactado_por es_contactado_por_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.es_contactado_por
    ADD CONSTRAINT es_contactado_por_dni_fkey FOREIGN KEY (dni) REFERENCES tp1.civil(dni);


--
-- Name: es_contactado_por es_contactado_por_id_sh_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.es_contactado_por
    ADD CONSTRAINT es_contactado_por_id_sh_fkey FOREIGN KEY (id_sh) REFERENCES tp1.superheroe(id_sh);


--
-- Name: esta_compuesta_por esta_compuesta_por_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.esta_compuesta_por
    ADD CONSTRAINT esta_compuesta_por_dni_fkey FOREIGN KEY (dni) REFERENCES tp1.civil(dni);


--
-- Name: esta_compuesta_por esta_compuesta_por_id_mafia_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.esta_compuesta_por
    ADD CONSTRAINT esta_compuesta_por_id_mafia_fkey FOREIGN KEY (id_mafia) REFERENCES tp1.organizacion_delictiva(id_mafia);


--
-- Name: incidente incidente_idDireccion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.incidente
    ADD CONSTRAINT "incidente_idDireccion_fkey" FOREIGN KEY (id_direccion) REFERENCES tp1.direccion(id_direccion);


--
-- Name: incidente incidente_idTIpoIncidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.incidente
    ADD CONSTRAINT "incidente_idTIpoIncidente_fkey" FOREIGN KEY (id_tipo_incidente) REFERENCES tp1.tipo_de_incidente(id_tipo_incidente);


--
-- Name: investigador investigador_id_departamento_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.investigador
    ADD CONSTRAINT investigador_id_departamento_fkey FOREIGN KEY (id_departamento) REFERENCES tp1.departamento(id_departamento);


--
-- Name: oficial oficial_idDepartamento_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.oficial
    ADD CONSTRAINT "oficial_idDepartamento_fkey" FOREIGN KEY (id_departamento) REFERENCES tp1.departamento(id_departamento);


--
-- Name: oficial_se_involucro oficial_se_involucro_id_incidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.oficial_se_involucro
    ADD CONSTRAINT oficial_se_involucro_id_incidente_fkey FOREIGN KEY (id_incidente) REFERENCES tp1.incidente(id_incidente);


--
-- Name: oficial_se_involucro oficial_se_involucro_id_responsabilidad_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.oficial_se_involucro
    ADD CONSTRAINT oficial_se_involucro_id_responsabilidad_fkey FOREIGN KEY (id_responsabilidad) REFERENCES tp1.rol_oficial(id_responsabilidad);


--
-- Name: posee posee_id_habilidad_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.posee
    ADD CONSTRAINT posee_id_habilidad_fkey FOREIGN KEY (id_habilidad) REFERENCES tp1.habilidad(id_habilidad);


--
-- Name: posee posee_id_sh_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.posee
    ADD CONSTRAINT posee_id_sh_fkey FOREIGN KEY (id_sh) REFERENCES tp1.superheroe(id_sh);


--
-- Name: se_involucraron se_involucraron_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.se_involucraron
    ADD CONSTRAINT se_involucraron_dni_fkey FOREIGN KEY (dni) REFERENCES tp1.civil(dni);


--
-- Name: se_involucraron se_involucraron_id_incidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.se_involucraron
    ADD CONSTRAINT se_involucraron_id_incidente_fkey FOREIGN KEY (id_incidente) REFERENCES tp1.incidente(id_incidente);


--
-- Name: se_involucraron se_involucraron_id_rol_civil_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.se_involucraron
    ADD CONSTRAINT se_involucraron_id_rol_civil_fkey FOREIGN KEY (id_rol_civil) REFERENCES tp1.rol_civil(id_rol_civil);


--
-- Name: seguimiento seguimiento_idEstadoSeg_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.seguimiento
    ADD CONSTRAINT "seguimiento_idEstadoSeg_fkey" FOREIGN KEY (id_estado_seg) REFERENCES tp1.estado_seguimiento(id_estado_seg);


--
-- Name: seguimiento seguimiento_idIncidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.seguimiento
    ADD CONSTRAINT "seguimiento_idIncidente_fkey" FOREIGN KEY (id_incidente) REFERENCES tp1.incidente(id_incidente);


--
-- Name: sumario sumario_id_asignacion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.sumario
    ADD CONSTRAINT sumario_id_asignacion_fkey FOREIGN KEY (id_asignacion) REFERENCES tp1.asignacion(id_asignacion);


--
-- Name: sumario sumario_placa_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.sumario
    ADD CONSTRAINT sumario_placa_fkey FOREIGN KEY (placa) REFERENCES tp1.investigador(placa);


--
-- Name: super_participo super_participo_id_incidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.super_participo
    ADD CONSTRAINT super_participo_id_incidente_fkey FOREIGN KEY (id_incidente) REFERENCES tp1.incidente(id_incidente);


--
-- Name: super_participo super_participo_id_sh_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.super_participo
    ADD CONSTRAINT super_participo_id_sh_fkey FOREIGN KEY (id_sh) REFERENCES tp1.superheroe(id_sh);


--
-- Name: superheroe superheroe_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.superheroe
    ADD CONSTRAINT superheroe_dni_fkey FOREIGN KEY (dni) REFERENCES tp1.civil(dni) ON UPDATE CASCADE;


--
-- Name: vive_en vive_en_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.vive_en
    ADD CONSTRAINT vive_en_dni_fkey FOREIGN KEY (dni) REFERENCES tp1.civil(dni);


--
-- Name: vive_en vive_en_id_direccion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1.vive_en
    ADD CONSTRAINT vive_en_id_direccion_fkey FOREIGN KEY (id_direccion) REFERENCES tp1.direccion(id_direccion);


--
-- PostgreSQL database dump complete
--

