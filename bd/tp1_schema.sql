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
-- Name: archienemigo_no_es_el_mismo(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.archienemigo_no_es_el_mismo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT * FROM tp1."Superheroe" sh, tp1."Civil" c where new."idSuperHeroe" = sh."idSuperHeroe" and c.dni = new.dni and sh.dni is not null and sh.dni = new.dni ) THEN
      RAISE EXCEPTION 'no puede ser archienemigo de si mismo';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.archienemigo_no_es_el_mismo() OWNER TO grupo_01;

--
-- Name: asignacion_fecha_mayor_a_oficial(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.asignacion_fecha_mayor_a_oficial() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT * FROM tp1."Oficial" o where new.placa = o.placa and new."fechaInicio" < o."fechaIngreso" ) THEN
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
    IF NOT EXISTS (SELECT * FROM tp1."Oficial" o where new.placa = o.placa ) THEN
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
    IF EXISTS (SELECT * FROM tp1."Civil" c where new.dni = c.dni ) THEN
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
    IF EXISTS (SELECT * FROM tp1."Oficial" o, tp1."Incidente" i where new.placa = o.placa and i."idIncidente" = new."idIncidente" and i.fecha < o."fechaIngreso" ) THEN
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
    IF EXISTS (SELECT * FROM tp1."EstadoSeguimiento" e where new."idEstadoSeguimiento" = e."idEstadoSeguimiento" and e."idEstadoSeguimiento" != 3 and old."idEstadoSeguimiento" = 3 ) THEN
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
    IF EXISTS (SELECT * FROM tp1."EstadoSeguimiento" e where new."idEstadoSeguimiento" = e."idEstadoSeguimiento" and ( (e."idEstadoSeguimiento" = 3 and new.conclusion is NULL) or (e."idEstadoSeguimiento" != 3 and new.conclusion is not NULL) )  ) THEN
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
    IF EXISTS (SELECT * FROM tp1."Incidente" i where i."idIncidente" = new."idIncidente" and new.fecha < i.fecha ) THEN
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
    IF EXISTS (SELECT * FROM tp1."Oficial" o where o.placa = new.placa and new.fecha < o."fechaIngreso" ) THEN
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
    IF new."idEstadoSeguimiento" = 2 and NOT EXISTS (SELECT * FROM tp1."EstadoSeguimiento" e, tp1."Oficial" o where new."idEstadoSeguimiento" = e."idEstadoSeguimiento" and e."idEstadoSeguimiento" = 2 and new.placa = o.placa  ) THEN
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
    IF EXISTS (SELECT * FROM tp1."EstadoSeguimiento" e where new."idEstadoSeguimiento" = e."idEstadoSeguimiento" and ((e."idEstadoSeguimiento" = 2 and new.placa is NULL) or (e."idEstadoSeguimiento" != 2 and new.placa is not NULL) ) ) THEN
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
    IF EXISTS (SELECT * FROM tp1."EstadoSumario" e where new."idEstadoSumario" = 3 and new.resultado IS NULL ) THEN
      RAISE EXCEPTION 'Si concluyo tiene resultado';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.sumario_concluyo_tiene_resultado() OWNER TO grupo_01;

--
-- Name: sumario_es_tipo_investigador(); Type: FUNCTION; Schema: tp1; Owner: postgres
--

CREATE FUNCTION tp1.sumario_es_tipo_investigador() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (SELECT o.tipo FROM tp1."Oficial" o where new.placa = o.placa) != 'Investigador' THEN
      RAISE EXCEPTION 'El oficial que investiga debe tener tipo Investigador';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.sumario_es_tipo_investigador() OWNER TO postgres;

--
-- Name: sumario_fecha_mayor_asignacion(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.sumario_fecha_mayor_asignacion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    IF EXISTS (SELECT * FROM tp1."Asignacion" a where new."idAsignacion" = a."idAsignacion" and new.fecha < a."fechaInicio" ) THEN
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
    AS $$BEGIN
    IF EXISTS (SELECT * FROM tp1."Oficial" i where new.placa = i.placa and new.fecha < i."fechaIngreso" ) THEN
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
    IF EXISTS (SELECT * FROM tp1."Asignacion" a where new."idAsignacion" = a."idAsignacion" and new.placa = a.placa ) THEN
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
    IF EXISTS (SELECT * FROM tp1."Civil" c, tp1."EstaCompuestaPor" comp where new.dni = c.dni and comp.dni = new.dni) THEN
      RAISE EXCEPTION 'No puede haber un oficial con mismo dni que un civil';              
    END IF;
    RETURN NULL;
  END;

$$;


ALTER FUNCTION tp1.superheroeo_no_delincuente() OWNER TO grupo_01;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Asignacion; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Asignacion" (
    "idAsignacion" integer NOT NULL,
    "fechaInicio" date NOT NULL,
    "idDesignacion" integer NOT NULL,
    placa integer NOT NULL
);


ALTER TABLE tp1."Asignacion" OWNER TO grupo_01;

--
-- Name: Barrio; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Barrio" (
    "idBarrio" integer NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."Barrio" OWNER TO grupo_01;

--
-- Name: Civil; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Civil" (
    dni integer NOT NULL,
    nombre character varying(250) NOT NULL,
    apellido character varying(250) NOT NULL
);


ALTER TABLE tp1."Civil" OWNER TO grupo_01;

--
-- Name: Conocimiento; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Conocimiento" (
    conocedor integer NOT NULL,
    conocido integer NOT NULL,
    "fechaConocimiento" date NOT NULL,
    "idTipoRelacion" integer NOT NULL
);


ALTER TABLE tp1."Conocimiento" OWNER TO grupo_01;

--
-- Name: Departamento; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Departamento" (
    "idDepartamento" integer NOT NULL,
    nombre character varying(250) NOT NULL,
    descripcion text DEFAULT ''::text NOT NULL
);


ALTER TABLE tp1."Departamento" OWNER TO grupo_01;

--
-- Name: Designacion; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Designacion" (
    "idDesignacion" integer NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."Designacion" OWNER TO grupo_01;

--
-- Name: Direccion; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Direccion" (
    "idDireccion" integer NOT NULL,
    calle character varying(250) NOT NULL,
    altura integer NOT NULL,
    "idBarrio" integer NOT NULL
);


ALTER TABLE tp1."Direccion" OWNER TO grupo_01;

--
-- Name: EsContactadoPor; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."EsContactadoPor" (
    "idSuperHeroe" integer NOT NULL,
    dni integer NOT NULL
);


ALTER TABLE tp1."EsContactadoPor" OWNER TO grupo_01;

--
-- Name: EstaCompuestaPor; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."EstaCompuestaPor" (
    "idMafia" integer NOT NULL,
    dni integer NOT NULL
);


ALTER TABLE tp1."EstaCompuestaPor" OWNER TO grupo_01;

--
-- Name: EstadoSeguimiento; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."EstadoSeguimiento" (
    "idEstadoSeguimiento" integer NOT NULL,
    estado character varying(250) NOT NULL
);


ALTER TABLE tp1."EstadoSeguimiento" OWNER TO grupo_01;

--
-- Name: EstadoSumario; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."EstadoSumario" (
    "idEstadoSumario" integer NOT NULL,
    estado character varying(25) NOT NULL
);


ALTER TABLE tp1."EstadoSumario" OWNER TO grupo_01;

--
-- Name: Habilidad; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Habilidad" (
    "idHabilidad" integer NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."Habilidad" OWNER TO grupo_01;

--
-- Name: Incidente; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Incidente" (
    "idIncidente" integer NOT NULL,
    fecha date NOT NULL,
    calle_1 character varying(250) NOT NULL,
    calle_2 character varying(250) NOT NULL,
    "idTipoInicidente" integer NOT NULL,
    "idDireccion" integer NOT NULL
);


ALTER TABLE tp1."Incidente" OWNER TO grupo_01;

--
-- Name: Oficial; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Oficial" (
    placa integer NOT NULL,
    dni integer NOT NULL,
    nombre character varying(250) NOT NULL,
    apellido character varying(250) NOT NULL,
    rango character varying(250) NOT NULL,
    "fechaIngreso" date NOT NULL,
    tipo character varying(250),
    "idDepartamento" integer NOT NULL
);


ALTER TABLE tp1."Oficial" OWNER TO grupo_01;

--
-- Name: OficialSeInvolucro; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."OficialSeInvolucro" (
    placa integer NOT NULL,
    "idIncidente" integer NOT NULL,
    "idResponsabilidad" integer NOT NULL
);


ALTER TABLE tp1."OficialSeInvolucro" OWNER TO grupo_01;

--
-- Name: OrganizacionDelictiva; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."OrganizacionDelictiva" (
    "idMafia" integer NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."OrganizacionDelictiva" OWNER TO grupo_01;

--
-- Name: Posee; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Posee" (
    "idSuperHeroe" integer NOT NULL,
    "idHabilidad" integer NOT NULL
);


ALTER TABLE tp1."Posee" OWNER TO grupo_01;

--
-- Name: RolCivil; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."RolCivil" (
    "idRolCivil" integer NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."RolCivil" OWNER TO grupo_01;

--
-- Name: RolOficial; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."RolOficial" (
    "idResponsabilidad" integer NOT NULL,
    descripcion text
);


ALTER TABLE tp1."RolOficial" OWNER TO grupo_01;

--
-- Name: SeInvolucraron; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."SeInvolucraron" (
    dni integer NOT NULL,
    "idIncidente" integer NOT NULL,
    "idRolCivil" integer NOT NULL
);


ALTER TABLE tp1."SeInvolucraron" OWNER TO grupo_01;

--
-- Name: Seguimiento; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Seguimiento" (
    numero integer NOT NULL,
    fecha date NOT NULL,
    descripcion text,
    conclusion text,
    "idIncidente" integer NOT NULL,
    placa integer,
    "idEstadoSeguimiento" integer NOT NULL
);


ALTER TABLE tp1."Seguimiento" OWNER TO grupo_01;

--
-- Name: Sumario; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Sumario" (
    "idSumario" integer NOT NULL,
    fecha date NOT NULL,
    observacion text,
    resultado text,
    placa integer NOT NULL,
    "idAsignacion" integer NOT NULL,
    "idEstadoSumario" integer NOT NULL
);


ALTER TABLE tp1."Sumario" OWNER TO grupo_01;

--
-- Name: SuperParticipo; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."SuperParticipo" (
    "idSuperHeroe" integer NOT NULL,
    "idIncidente" integer NOT NULL
);


ALTER TABLE tp1."SuperParticipo" OWNER TO grupo_01;

--
-- Name: Superheroe; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Superheroe" (
    "idSuperHeroe" integer NOT NULL,
    nombre character varying(250) NOT NULL,
    color_capa character varying(250) NOT NULL,
    dni integer,
    color_disfraz character varying(250) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE tp1."Superheroe" OWNER TO grupo_01;

--
-- Name: TipoIncidente; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."TipoIncidente" (
    "idTipoInicidente" integer NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."TipoIncidente" OWNER TO grupo_01;

--
-- Name: TipoRelacion; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."TipoRelacion" (
    "idTipoRelacion" integer NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."TipoRelacion" OWNER TO grupo_01;

--
-- Name: ViveEn; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."ViveEn" (
    dni integer NOT NULL,
    "idDireccion" integer NOT NULL,
    "fechaInicio" date NOT NULL
);


ALTER TABLE tp1."ViveEn" OWNER TO grupo_01;

--
-- Name: archienemigoDe; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."archienemigoDe" (
    "idSuperHeroe" integer NOT NULL,
    dni integer NOT NULL
);


ALTER TABLE tp1."archienemigoDe" OWNER TO grupo_01;

--
-- Name: Civil Civil_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Civil"
    ADD CONSTRAINT "Civil_pkey" PRIMARY KEY (dni);


--
-- Name: Departamento Departamento_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Departamento"
    ADD CONSTRAINT "Departamento_pkey" PRIMARY KEY ("idDepartamento");


--
-- Name: Direccion Direccion_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Direccion"
    ADD CONSTRAINT "Direccion_pkey" PRIMARY KEY ("idDireccion");


--
-- Name: Incidente Incidente_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Incidente"
    ADD CONSTRAINT "Incidente_pkey" PRIMARY KEY ("idIncidente");


--
-- Name: OrganizacionDelictiva Organización_delictiva_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."OrganizacionDelictiva"
    ADD CONSTRAINT "Organización_delictiva_pkey" PRIMARY KEY ("idMafia");


--
-- Name: TipoRelacion TipoDeRelacion_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."TipoRelacion"
    ADD CONSTRAINT "TipoDeRelacion_pkey" PRIMARY KEY ("idTipoRelacion");


--
-- Name: TipoIncidente TipoIncidente_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."TipoIncidente"
    ADD CONSTRAINT "TipoIncidente_pkey" PRIMARY KEY ("idTipoInicidente");


--
-- Name: archienemigoDe archienemigo_de_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."archienemigoDe"
    ADD CONSTRAINT archienemigo_de_pkey PRIMARY KEY ("idSuperHeroe", dni);


--
-- Name: Asignacion asignacion_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Asignacion"
    ADD CONSTRAINT asignacion_pkey PRIMARY KEY ("idAsignacion");


--
-- Name: Conocimiento conocimiento_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Conocimiento"
    ADD CONSTRAINT conocimiento_pkey PRIMARY KEY (conocedor, conocido);


--
-- Name: Designacion designacion_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Designacion"
    ADD CONSTRAINT designacion_pkey PRIMARY KEY ("idDesignacion");


--
-- Name: EsContactadoPor es_contactado_por_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EsContactadoPor"
    ADD CONSTRAINT es_contactado_por_pkey PRIMARY KEY ("idSuperHeroe", dni);


--
-- Name: EstaCompuestaPor esta_compuesta_por_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstaCompuestaPor"
    ADD CONSTRAINT esta_compuesta_por_pkey PRIMARY KEY ("idMafia", dni);


--
-- Name: EstadoSeguimiento estadoSeguimiento_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstadoSeguimiento"
    ADD CONSTRAINT "estadoSeguimiento_pkey" PRIMARY KEY ("idEstadoSeguimiento");


--
-- Name: EstadoSumario estado_sumario_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstadoSumario"
    ADD CONSTRAINT estado_sumario_pkey PRIMARY KEY ("idEstadoSumario");


--
-- Name: Barrio idBarrio; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Barrio"
    ADD CONSTRAINT "idBarrio" PRIMARY KEY ("idBarrio");


--
-- Name: Oficial oficial_dni_key; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Oficial"
    ADD CONSTRAINT oficial_dni_key UNIQUE (dni);


--
-- Name: Oficial oficial_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Oficial"
    ADD CONSTRAINT oficial_pkey PRIMARY KEY (placa);


--
-- Name: OficialSeInvolucro oficial_se_involucro_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."OficialSeInvolucro"
    ADD CONSTRAINT oficial_se_involucro_pkey PRIMARY KEY (placa, "idIncidente", "idResponsabilidad");


--
-- Name: Habilidad pk_habilidad; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Habilidad"
    ADD CONSTRAINT pk_habilidad PRIMARY KEY ("idHabilidad");


--
-- Name: Posee posee_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Posee"
    ADD CONSTRAINT posee_pkey PRIMARY KEY ("idSuperHeroe", "idHabilidad");


--
-- Name: RolCivil rol_civil_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."RolCivil"
    ADD CONSTRAINT rol_civil_pkey PRIMARY KEY ("idRolCivil");


--
-- Name: RolOficial rol_oficial_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."RolOficial"
    ADD CONSTRAINT rol_oficial_pkey PRIMARY KEY ("idResponsabilidad");


--
-- Name: SeInvolucraron se_involucraron_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SeInvolucraron"
    ADD CONSTRAINT se_involucraron_pkey PRIMARY KEY (dni, "idIncidente");


--
-- Name: Seguimiento seguimiento_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Seguimiento"
    ADD CONSTRAINT seguimiento_pkey PRIMARY KEY (numero, "idIncidente");


--
-- Name: Sumario sumario_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Sumario"
    ADD CONSTRAINT sumario_pkey PRIMARY KEY ("idSumario");


--
-- Name: SuperParticipo super_participo_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SuperParticipo"
    ADD CONSTRAINT super_participo_pkey PRIMARY KEY ("idSuperHeroe", "idIncidente");


--
-- Name: Superheroe superheroe_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Superheroe"
    ADD CONSTRAINT superheroe_pkey PRIMARY KEY ("idSuperHeroe");


--
-- Name: ViveEn vive_en_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."ViveEn"
    ADD CONSTRAINT vive_en_pkey PRIMARY KEY (dni, "idDireccion");


--
-- Name: fki_idDireccion; Type: INDEX; Schema: tp1; Owner: grupo_01
--

CREATE INDEX "fki_idDireccion" ON tp1."Incidente" USING btree ("idDireccion");


--
-- Name: fki_idTipoIncidente; Type: INDEX; Schema: tp1; Owner: grupo_01
--

CREATE INDEX "fki_idTipoIncidente" ON tp1."Incidente" USING btree ("idTipoInicidente");


--
-- Name: fki_superheroe_dni; Type: INDEX; Schema: tp1; Owner: grupo_01
--

CREATE INDEX fki_superheroe_dni ON tp1."Superheroe" USING btree (dni);


--
-- Name: archienemigoDe check_archienemigo_de_si_mismo; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_archienemigo_de_si_mismo AFTER INSERT OR UPDATE ON tp1."archienemigoDe" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.archienemigo_no_es_el_mismo();


--
-- Name: Sumario check_concluyo_tiene_resultado; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_concluyo_tiene_resultado AFTER INSERT OR UPDATE ON tp1."Sumario" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_concluyo_tiene_resultado();


--
-- Name: Oficial check_dni_no_civiles; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_dni_no_civiles AFTER INSERT OR UPDATE ON tp1."Oficial" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.dni_oficiales_civiles();


--
-- Name: Sumario check_es_tipo_investigador; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE TRIGGER check_es_tipo_investigador BEFORE INSERT OR UPDATE ON tp1."Sumario" FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_es_tipo_investigador();


--
-- Name: Asignacion check_fecha_inicio_mayor_a_oficial; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_inicio_mayor_a_oficial AFTER INSERT OR UPDATE ON tp1."Asignacion" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.asignacion_fecha_mayor_a_oficial();


--
-- Name: Sumario check_fecha_mayor_asigancion; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_mayor_asigancion AFTER INSERT OR UPDATE ON tp1."Sumario" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_fecha_mayor_asignacion();


--
-- Name: Sumario check_fecha_mayor_investigador; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_mayor_investigador AFTER INSERT OR UPDATE ON tp1."Sumario" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_fecha_mayor_investigador();


--
-- Name: OficialSeInvolucro check_fecha_oficial_involucrado; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_oficial_involucrado AFTER INSERT OR UPDATE ON tp1."OficialSeInvolucro" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.oficial_se_involucro_fecha();


--
-- Name: Seguimiento check_fecha_seg_incidente; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_seg_incidente AFTER INSERT OR UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_fecha_incidente();


--
-- Name: Seguimiento check_fecha_seg_oficial; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_seg_oficial AFTER INSERT OR UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_fecha_oficial();


--
-- Name: Sumario check_investigador_no_se_investiga; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_investigador_no_se_investiga AFTER INSERT OR UPDATE ON tp1."Sumario" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_investigador_no_investigado();


--
-- Name: Seguimiento check_seg_conclusion; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_seg_conclusion AFTER INSERT OR UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_conclusion();


--
-- Name: Seguimiento check_seg_placa_fk; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_seg_placa_fk AFTER INSERT OR UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_placa_fk();


--
-- Name: Seguimiento check_seguimiento_cerrado_no_cambia; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_seguimiento_cerrado_no_cambia AFTER UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_al_cerrarse_no_puede_cambiar();


--
-- Name: Seguimiento check_solo_seguido_en_proceso; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_solo_seguido_en_proceso AFTER INSERT OR UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_seguida_si_en_proceso();


--
-- Name: Superheroe check_superheroeo_no_delincuente; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_superheroeo_no_delincuente AFTER INSERT OR UPDATE ON tp1."Superheroe" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.superheroeo_no_delincuente();


--
-- Name: OficialSeInvolucro OficialSeInvolucro_placa_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."OficialSeInvolucro"
    ADD CONSTRAINT "OficialSeInvolucro_placa_fkey" FOREIGN KEY (placa) REFERENCES tp1."Oficial"(placa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: archienemigoDe archienemigo_de_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."archienemigoDe"
    ADD CONSTRAINT archienemigo_de_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni);


--
-- Name: archienemigoDe archienemigo_de_id_sh_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."archienemigoDe"
    ADD CONSTRAINT archienemigo_de_id_sh_fkey FOREIGN KEY ("idSuperHeroe") REFERENCES tp1."Superheroe"("idSuperHeroe");


--
-- Name: Asignacion asignacion_id_designacion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Asignacion"
    ADD CONSTRAINT asignacion_id_designacion_fkey FOREIGN KEY ("idDesignacion") REFERENCES tp1."Designacion"("idDesignacion");


--
-- Name: Asignacion asignacion_placa_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Asignacion"
    ADD CONSTRAINT asignacion_placa_fkey FOREIGN KEY (placa) REFERENCES tp1."Oficial"(placa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Conocimiento conocimiento_conocedor_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Conocimiento"
    ADD CONSTRAINT conocimiento_conocedor_fkey FOREIGN KEY (conocedor) REFERENCES tp1."Civil"(dni);


--
-- Name: Conocimiento conocimiento_conocido_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Conocimiento"
    ADD CONSTRAINT conocimiento_conocido_fkey FOREIGN KEY (conocido) REFERENCES tp1."Civil"(dni);


--
-- Name: Conocimiento conocimiento_id_tipo_de_relacion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Conocimiento"
    ADD CONSTRAINT conocimiento_id_tipo_de_relacion_fkey FOREIGN KEY ("idTipoRelacion") REFERENCES tp1."TipoRelacion"("idTipoRelacion");


--
-- Name: Direccion direccion_id_barrio_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Direccion"
    ADD CONSTRAINT direccion_id_barrio_fkey FOREIGN KEY ("idBarrio") REFERENCES tp1."Barrio"("idBarrio");


--
-- Name: EsContactadoPor es_contactado_por_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EsContactadoPor"
    ADD CONSTRAINT es_contactado_por_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni);


--
-- Name: EsContactadoPor es_contactado_por_id_sh_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EsContactadoPor"
    ADD CONSTRAINT es_contactado_por_id_sh_fkey FOREIGN KEY ("idSuperHeroe") REFERENCES tp1."Superheroe"("idSuperHeroe");


--
-- Name: EstaCompuestaPor esta_compuesta_por_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstaCompuestaPor"
    ADD CONSTRAINT esta_compuesta_por_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni);


--
-- Name: EstaCompuestaPor esta_compuesta_por_id_mafia_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstaCompuestaPor"
    ADD CONSTRAINT esta_compuesta_por_id_mafia_fkey FOREIGN KEY ("idMafia") REFERENCES tp1."OrganizacionDelictiva"("idMafia");


--
-- Name: Incidente incidente_idDireccion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Incidente"
    ADD CONSTRAINT "incidente_idDireccion_fkey" FOREIGN KEY ("idDireccion") REFERENCES tp1."Direccion"("idDireccion");


--
-- Name: Incidente incidente_idTIpoIncidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Incidente"
    ADD CONSTRAINT "incidente_idTIpoIncidente_fkey" FOREIGN KEY ("idTipoInicidente") REFERENCES tp1."TipoIncidente"("idTipoInicidente");


--
-- Name: Oficial oficial_idDepartamento_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Oficial"
    ADD CONSTRAINT "oficial_idDepartamento_fkey" FOREIGN KEY ("idDepartamento") REFERENCES tp1."Departamento"("idDepartamento");


--
-- Name: OficialSeInvolucro oficial_se_involucro_id_incidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."OficialSeInvolucro"
    ADD CONSTRAINT oficial_se_involucro_id_incidente_fkey FOREIGN KEY ("idIncidente") REFERENCES tp1."Incidente"("idIncidente");


--
-- Name: OficialSeInvolucro oficial_se_involucro_id_responsabilidad_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."OficialSeInvolucro"
    ADD CONSTRAINT oficial_se_involucro_id_responsabilidad_fkey FOREIGN KEY ("idResponsabilidad") REFERENCES tp1."RolOficial"("idResponsabilidad");


--
-- Name: Posee posee_id_habilidad_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Posee"
    ADD CONSTRAINT posee_id_habilidad_fkey FOREIGN KEY ("idHabilidad") REFERENCES tp1."Habilidad"("idHabilidad");


--
-- Name: Posee posee_id_sh_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Posee"
    ADD CONSTRAINT posee_id_sh_fkey FOREIGN KEY ("idSuperHeroe") REFERENCES tp1."Superheroe"("idSuperHeroe");


--
-- Name: SeInvolucraron se_involucraron_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SeInvolucraron"
    ADD CONSTRAINT se_involucraron_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni);


--
-- Name: SeInvolucraron se_involucraron_id_incidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SeInvolucraron"
    ADD CONSTRAINT se_involucraron_id_incidente_fkey FOREIGN KEY ("idIncidente") REFERENCES tp1."Incidente"("idIncidente");


--
-- Name: SeInvolucraron se_involucraron_id_rol_civil_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SeInvolucraron"
    ADD CONSTRAINT se_involucraron_id_rol_civil_fkey FOREIGN KEY ("idRolCivil") REFERENCES tp1."RolCivil"("idRolCivil");


--
-- Name: Seguimiento seguimiento_idEstadoSeg_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Seguimiento"
    ADD CONSTRAINT "seguimiento_idEstadoSeg_fkey" FOREIGN KEY ("idEstadoSeguimiento") REFERENCES tp1."EstadoSeguimiento"("idEstadoSeguimiento");


--
-- Name: Seguimiento seguimiento_idIncidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Seguimiento"
    ADD CONSTRAINT "seguimiento_idIncidente_fkey" FOREIGN KEY ("idIncidente") REFERENCES tp1."Incidente"("idIncidente");


--
-- Name: Seguimiento seguimiento_placa_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Seguimiento"
    ADD CONSTRAINT seguimiento_placa_fkey FOREIGN KEY (placa) REFERENCES tp1."Oficial"(placa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Sumario sumario_estado_idEEstadoSum; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Sumario"
    ADD CONSTRAINT "sumario_estado_idEEstadoSum" FOREIGN KEY ("idEstadoSumario") REFERENCES tp1."EstadoSumario"("idEstadoSumario") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: Sumario sumario_id_asignacion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Sumario"
    ADD CONSTRAINT sumario_id_asignacion_fkey FOREIGN KEY ("idAsignacion") REFERENCES tp1."Asignacion"("idAsignacion");


--
-- Name: Sumario sumario_investigador_placa_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Sumario"
    ADD CONSTRAINT sumario_investigador_placa_fkey FOREIGN KEY (placa) REFERENCES tp1."Oficial"(placa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SuperParticipo super_participo_id_incidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SuperParticipo"
    ADD CONSTRAINT super_participo_id_incidente_fkey FOREIGN KEY ("idIncidente") REFERENCES tp1."Incidente"("idIncidente");


--
-- Name: SuperParticipo super_participo_id_sh_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SuperParticipo"
    ADD CONSTRAINT super_participo_id_sh_fkey FOREIGN KEY ("idSuperHeroe") REFERENCES tp1."Superheroe"("idSuperHeroe");


--
-- Name: Superheroe superheroe_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Superheroe"
    ADD CONSTRAINT superheroe_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni) ON UPDATE CASCADE;


--
-- Name: ViveEn vive_en_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."ViveEn"
    ADD CONSTRAINT vive_en_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni);


--
-- Name: ViveEn vive_en_id_direccion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."ViveEn"
    ADD CONSTRAINT vive_en_id_direccion_fkey FOREIGN KEY ("idDireccion") REFERENCES tp1."Direccion"("idDireccion");


--
-- PostgreSQL database dump complete
--

