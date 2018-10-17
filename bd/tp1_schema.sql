--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5 (Ubuntu 10.5-1.pgdg16.04+1)
-- Dumped by pg_dump version 10.5 (Ubuntu 10.5-1.pgdg16.04+1)

-- Started on 2018-10-16 12:07:33 -03

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
-- TOC entry 7 (class 2615 OID 18516)
-- Name: tp1; Type: SCHEMA; Schema: -; Owner: grupo_01
--

CREATE SCHEMA tp1;


ALTER SCHEMA tp1 OWNER TO grupo_01;

--
-- TOC entry 1 (class 3079 OID 12998)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3114 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 224 (class 1255 OID 18517)
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
-- TOC entry 225 (class 1255 OID 18518)
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
-- TOC entry 227 (class 1255 OID 18520)
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
-- TOC entry 228 (class 1255 OID 18521)
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
-- TOC entry 241 (class 1255 OID 18522)
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
-- TOC entry 242 (class 1255 OID 18523)
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
-- TOC entry 243 (class 1255 OID 18524)
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
-- TOC entry 244 (class 1255 OID 18525)
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
-- TOC entry 245 (class 1255 OID 18526)
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
-- TOC entry 246 (class 1255 OID 18527)
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
-- TOC entry 247 (class 1255 OID 18528)
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
-- TOC entry 248 (class 1255 OID 18529)
-- Name: sumario_es_tipo_investigador(); Type: FUNCTION; Schema: tp1; Owner: postgres
--

CREATE FUNCTION tp1.sumario_es_tipo_investigador() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    IF (SELECT o.tipo FROM tp1."Oficial" o where new.placa = o.placa and o.tipo != 'Investigador') THEN
      RAISE EXCEPTION 'El oficial que investiga debe tener tipo Investigador';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.sumario_es_tipo_investigador() OWNER TO postgres;

--
-- TOC entry 249 (class 1255 OID 18530)
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
-- TOC entry 250 (class 1255 OID 18531)
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
-- TOC entry 251 (class 1255 OID 18532)
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
-- TOC entry 252 (class 1255 OID 18533)
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
-- TOC entry 196 (class 1259 OID 18534)
-- Name: Asignacion; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Asignacion" (
    "idAsignacion" serial NOT NULL,
    "fechaInicio" date NOT NULL,
    "idDesignacion" integer NOT NULL,
    placa integer NOT NULL
);

--
-- TOC entry 197 (class 1259 OID 18537)
-- Name: Barrio; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Barrio" (
    "idBarrio" serial NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."Barrio" OWNER TO grupo_01;

--
-- TOC entry 198 (class 1259 OID 18540)
-- Name: Civil; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Civil" (
    dni integer NOT NULL,
    nombre character varying(250) NOT NULL,
    apellido character varying(250) NOT NULL
);


ALTER TABLE tp1."Civil" OWNER TO grupo_01;

--
-- TOC entry 199 (class 1259 OID 18546)
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
-- TOC entry 200 (class 1259 OID 18549)
-- Name: Departamento; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Departamento" (
    "idDepartamento" serial NOT NULL,
    nombre character varying(250) NOT NULL,
    descripcion text DEFAULT ''::text NOT NULL
);


ALTER TABLE tp1."Departamento" OWNER TO grupo_01;

--
-- TOC entry 201 (class 1259 OID 18556)
-- Name: Designacion; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Designacion" (
    "idDesignacion" serial NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."Designacion" OWNER TO grupo_01;

--
-- TOC entry 202 (class 1259 OID 18559)
-- Name: Direccion; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Direccion" (
    "idDireccion" serial NOT NULL,
    calle character varying(250) NOT NULL,
    altura integer NOT NULL,
    "idBarrio" integer NOT NULL
);


ALTER TABLE tp1."Direccion" OWNER TO grupo_01;

--
-- TOC entry 203 (class 1259 OID 18562)
-- Name: EsContactadoPor; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."EsContactadoPor" (
    "idSuperHeroe" integer NOT NULL,
    dni integer NOT NULL
);


ALTER TABLE tp1."EsContactadoPor" OWNER TO grupo_01;

--
-- TOC entry 204 (class 1259 OID 18565)
-- Name: EstaCompuestaPor; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."EstaCompuestaPor" (
    "idMafia" integer NOT NULL,
    dni integer NOT NULL
);


ALTER TABLE tp1."EstaCompuestaPor" OWNER TO grupo_01;

--
-- TOC entry 205 (class 1259 OID 18568)
-- Name: EstadoSeguimiento; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."EstadoSeguimiento" (
    "idEstadoSeguimiento" serial NOT NULL,
    estado character varying(250) NOT NULL
);


ALTER TABLE tp1."EstadoSeguimiento" OWNER TO grupo_01;

--
-- TOC entry 206 (class 1259 OID 18571)
-- Name: EstadoSumario; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."EstadoSumario" (
    "idEstadoSumario" serial NOT NULL,
    estado character varying(25) NOT NULL
);


ALTER TABLE tp1."EstadoSumario" OWNER TO grupo_01;

--
-- TOC entry 207 (class 1259 OID 18574)
-- Name: Habilidad; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Habilidad" (
    "idHabilidad" serial NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."Habilidad" OWNER TO grupo_01;

--
-- TOC entry 208 (class 1259 OID 18577)
-- Name: Incidente; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Incidente" (
    "idIncidente" serial NOT NULL,
    fecha date NOT NULL,
    calle_1 character varying(250) NOT NULL,
    calle_2 character varying(250) NOT NULL,
    "idTipoInicidente" integer NOT NULL,
    "idDireccion" integer NOT NULL
);


ALTER TABLE tp1."Incidente" OWNER TO grupo_01;

--
-- TOC entry 209 (class 1259 OID 18583)
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
-- TOC entry 210 (class 1259 OID 18589)
-- Name: OficialSeInvolucro; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."OficialSeInvolucro" (
    placa integer NOT NULL,
    "idIncidente" integer NOT NULL,
    "idResponsabilidad" integer NOT NULL
);


ALTER TABLE tp1."OficialSeInvolucro" OWNER TO grupo_01;

--
-- TOC entry 211 (class 1259 OID 18592)
-- Name: OrganizacionDelictiva; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."OrganizacionDelictiva" (
    "idMafia" serial NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."OrganizacionDelictiva" OWNER TO grupo_01;

--
-- TOC entry 212 (class 1259 OID 18595)
-- Name: Posee; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Posee" (
    "idSuperHeroe" integer NOT NULL,
    "idHabilidad" integer NOT NULL
);


ALTER TABLE tp1."Posee" OWNER TO grupo_01;

--
-- TOC entry 213 (class 1259 OID 18598)
-- Name: RolCivil; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."RolCivil" (
    "idRolCivil" serial NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."RolCivil" OWNER TO grupo_01;

--
-- TOC entry 214 (class 1259 OID 18601)
-- Name: RolOficial; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."RolOficial" (
    "idResponsabilidad" serial NOT NULL,
    descripcion text
);


ALTER TABLE tp1."RolOficial" OWNER TO grupo_01;

--
-- TOC entry 215 (class 1259 OID 18607)
-- Name: SeInvolucraron; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."SeInvolucraron" (
    dni integer NOT NULL,
    "idIncidente" integer NOT NULL,
    "idRolCivil" integer NOT NULL
);


ALTER TABLE tp1."SeInvolucraron" OWNER TO grupo_01;

--
-- TOC entry 216 (class 1259 OID 18610)
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
-- TOC entry 217 (class 1259 OID 18616)
-- Name: Sumario; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Sumario" (
    "idSumario" serial NOT NULL,
    fecha date NOT NULL,
    observacion text,
    resultado text,
    placa integer NOT NULL,
    "idAsignacion" integer NOT NULL,
    "idEstadoSumario" integer NOT NULL
);


ALTER TABLE tp1."Sumario" OWNER TO grupo_01;

--
-- TOC entry 218 (class 1259 OID 18622)
-- Name: SuperParticipo; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."SuperParticipo" (
    "idSuperHeroe" integer NOT NULL,
    "idIncidente" integer NOT NULL
);


ALTER TABLE tp1."SuperParticipo" OWNER TO grupo_01;

--
-- TOC entry 219 (class 1259 OID 18625)
-- Name: Superheroe; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Superheroe" (
    "idSuperHeroe" serial NOT NULL,
    nombre character varying(250) NOT NULL,
    color_capa character varying(250) NOT NULL,
    dni integer,
    color_disfraz character varying(250) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE tp1."Superheroe" OWNER TO grupo_01;

--
-- TOC entry 220 (class 1259 OID 18632)
-- Name: TipoIncidente; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."TipoIncidente" (
    "idTipoInicidente" serial NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."TipoIncidente" OWNER TO grupo_01;

--
-- TOC entry 221 (class 1259 OID 18635)
-- Name: TipoRelacion; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."TipoRelacion" (
    "idTipoRelacion" serial NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."TipoRelacion" OWNER TO grupo_01;

--
-- TOC entry 222 (class 1259 OID 18638)
-- Name: ViveEn; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."ViveEn" (
    dni integer NOT NULL,
    "idDireccion" integer NOT NULL,
    "fechaInicio" date NOT NULL
);


ALTER TABLE tp1."ViveEn" OWNER TO grupo_01;

--
-- TOC entry 223 (class 1259 OID 18641)
-- Name: archienemigoDe; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."archienemigoDe" (
    "idSuperHeroe" integer NOT NULL,
    dni integer NOT NULL
);


ALTER TABLE tp1."archienemigoDe" OWNER TO grupo_01;

--
-- TOC entry 2881 (class 2606 OID 18645)
-- Name: Civil Civil_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Civil"
    ADD CONSTRAINT "Civil_pkey" PRIMARY KEY (dni);


--
-- TOC entry 2885 (class 2606 OID 18647)
-- Name: Departamento Departamento_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Departamento"
    ADD CONSTRAINT "Departamento_pkey" PRIMARY KEY ("idDepartamento");


--
-- TOC entry 2889 (class 2606 OID 18649)
-- Name: Direccion Direccion_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Direccion"
    ADD CONSTRAINT "Direccion_pkey" PRIMARY KEY ("idDireccion");


--
-- TOC entry 2901 (class 2606 OID 18651)
-- Name: Incidente Incidente_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Incidente"
    ADD CONSTRAINT "Incidente_pkey" PRIMARY KEY ("idIncidente");


--
-- TOC entry 2911 (class 2606 OID 18653)
-- Name: OrganizacionDelictiva Organización_delictiva_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."OrganizacionDelictiva"
    ADD CONSTRAINT "Organización_delictiva_pkey" PRIMARY KEY ("idMafia");


--
-- TOC entry 2932 (class 2606 OID 18655)
-- Name: TipoRelacion TipoDeRelacion_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."TipoRelacion"
    ADD CONSTRAINT "TipoDeRelacion_pkey" PRIMARY KEY ("idTipoRelacion");


--
-- TOC entry 2930 (class 2606 OID 18657)
-- Name: TipoIncidente TipoIncidente_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."TipoIncidente"
    ADD CONSTRAINT "TipoIncidente_pkey" PRIMARY KEY ("idTipoInicidente");


--
-- TOC entry 2936 (class 2606 OID 18659)
-- Name: archienemigoDe archienemigo_de_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."archienemigoDe"
    ADD CONSTRAINT archienemigo_de_pkey PRIMARY KEY ("idSuperHeroe", dni);


--
-- TOC entry 2877 (class 2606 OID 18661)
-- Name: Asignacion asignacion_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Asignacion"
    ADD CONSTRAINT asignacion_pkey PRIMARY KEY ("idAsignacion");


--
-- TOC entry 2883 (class 2606 OID 18663)
-- Name: Conocimiento conocimiento_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Conocimiento"
    ADD CONSTRAINT conocimiento_pkey PRIMARY KEY (conocedor, conocido);


--
-- TOC entry 2887 (class 2606 OID 18665)
-- Name: Designacion designacion_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Designacion"
    ADD CONSTRAINT designacion_pkey PRIMARY KEY ("idDesignacion");


--
-- TOC entry 2891 (class 2606 OID 18667)
-- Name: EsContactadoPor es_contactado_por_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EsContactadoPor"
    ADD CONSTRAINT es_contactado_por_pkey PRIMARY KEY ("idSuperHeroe", dni);


--
-- TOC entry 2893 (class 2606 OID 18669)
-- Name: EstaCompuestaPor esta_compuesta_por_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstaCompuestaPor"
    ADD CONSTRAINT esta_compuesta_por_pkey PRIMARY KEY ("idMafia", dni);


--
-- TOC entry 2895 (class 2606 OID 18671)
-- Name: EstadoSeguimiento estadoSeguimiento_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstadoSeguimiento"
    ADD CONSTRAINT "estadoSeguimiento_pkey" PRIMARY KEY ("idEstadoSeguimiento");


--
-- TOC entry 2897 (class 2606 OID 18673)
-- Name: EstadoSumario estado_sumario_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstadoSumario"
    ADD CONSTRAINT estado_sumario_pkey PRIMARY KEY ("idEstadoSumario");


--
-- TOC entry 2879 (class 2606 OID 18675)
-- Name: Barrio idBarrio; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Barrio"
    ADD CONSTRAINT "idBarrio" PRIMARY KEY ("idBarrio");


--
-- TOC entry 2905 (class 2606 OID 18677)
-- Name: Oficial oficial_dni_key; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Oficial"
    ADD CONSTRAINT oficial_dni_key UNIQUE (dni);


--
-- TOC entry 2907 (class 2606 OID 18679)
-- Name: Oficial oficial_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Oficial"
    ADD CONSTRAINT oficial_pkey PRIMARY KEY (placa);


--
-- TOC entry 2909 (class 2606 OID 18681)
-- Name: OficialSeInvolucro oficial_se_involucro_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."OficialSeInvolucro"
    ADD CONSTRAINT oficial_se_involucro_pkey PRIMARY KEY (placa, "idIncidente", "idResponsabilidad");


--
-- TOC entry 2899 (class 2606 OID 18683)
-- Name: Habilidad pk_habilidad; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Habilidad"
    ADD CONSTRAINT pk_habilidad PRIMARY KEY ("idHabilidad");


--
-- TOC entry 2913 (class 2606 OID 18685)
-- Name: Posee posee_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Posee"
    ADD CONSTRAINT posee_pkey PRIMARY KEY ("idSuperHeroe", "idHabilidad");


--
-- TOC entry 2915 (class 2606 OID 18687)
-- Name: RolCivil rol_civil_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."RolCivil"
    ADD CONSTRAINT rol_civil_pkey PRIMARY KEY ("idRolCivil");


--
-- TOC entry 2917 (class 2606 OID 18689)
-- Name: RolOficial rol_oficial_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."RolOficial"
    ADD CONSTRAINT rol_oficial_pkey PRIMARY KEY ("idResponsabilidad");


--
-- TOC entry 2919 (class 2606 OID 18691)
-- Name: SeInvolucraron se_involucraron_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SeInvolucraron"
    ADD CONSTRAINT se_involucraron_pkey PRIMARY KEY (dni, "idIncidente");


--
-- TOC entry 2921 (class 2606 OID 18693)
-- Name: Seguimiento seguimiento_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Seguimiento"
    ADD CONSTRAINT seguimiento_pkey PRIMARY KEY (numero, "idIncidente");


--
-- TOC entry 2923 (class 2606 OID 18695)
-- Name: Sumario sumario_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Sumario"
    ADD CONSTRAINT sumario_pkey PRIMARY KEY ("idSumario");


--
-- TOC entry 2925 (class 2606 OID 18697)
-- Name: SuperParticipo super_participo_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SuperParticipo"
    ADD CONSTRAINT super_participo_pkey PRIMARY KEY ("idSuperHeroe", "idIncidente");


--
-- TOC entry 2928 (class 2606 OID 18699)
-- Name: Superheroe superheroe_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Superheroe"
    ADD CONSTRAINT superheroe_pkey PRIMARY KEY ("idSuperHeroe");


--
-- TOC entry 2934 (class 2606 OID 18701)
-- Name: ViveEn vive_en_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."ViveEn"
    ADD CONSTRAINT vive_en_pkey PRIMARY KEY (dni, "idDireccion");


--
-- TOC entry 2902 (class 1259 OID 18702)
-- Name: fki_idDireccion; Type: INDEX; Schema: tp1; Owner: grupo_01
--

CREATE INDEX "fki_idDireccion" ON tp1."Incidente" USING btree ("idDireccion");


--
-- TOC entry 2903 (class 1259 OID 18703)
-- Name: fki_idTipoIncidente; Type: INDEX; Schema: tp1; Owner: grupo_01
--

CREATE INDEX "fki_idTipoIncidente" ON tp1."Incidente" USING btree ("idTipoInicidente");


--
-- TOC entry 2926 (class 1259 OID 18704)
-- Name: fki_superheroe_dni; Type: INDEX; Schema: tp1; Owner: grupo_01
--

CREATE INDEX fki_superheroe_dni ON tp1."Superheroe" USING btree (dni);


--
-- TOC entry 2986 (class 2620 OID 18706)
-- Name: archienemigoDe check_archienemigo_de_si_mismo; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_archienemigo_de_si_mismo AFTER INSERT OR UPDATE ON tp1."archienemigoDe" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.archienemigo_no_es_el_mismo();


--
-- TOC entry 2980 (class 2620 OID 18708)
-- Name: Sumario check_concluyo_tiene_resultado; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_concluyo_tiene_resultado AFTER INSERT OR UPDATE ON tp1."Sumario" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_concluyo_tiene_resultado();


--
-- TOC entry 2972 (class 2620 OID 18710)
-- Name: Oficial check_dni_no_civiles; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_dni_no_civiles AFTER INSERT OR UPDATE ON tp1."Oficial" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.dni_oficiales_civiles();


--
-- TOC entry 2984 (class 2620 OID 18908)
-- Name: Sumario check_es_tipo_investigador; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_es_tipo_investigador AFTER INSERT OR UPDATE ON tp1."Sumario" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_es_tipo_investigador();


--
-- TOC entry 2971 (class 2620 OID 18713)
-- Name: Asignacion check_fecha_inicio_mayor_a_oficial; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_inicio_mayor_a_oficial AFTER INSERT OR UPDATE ON tp1."Asignacion" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.asignacion_fecha_mayor_a_oficial();


--
-- TOC entry 2981 (class 2620 OID 18715)
-- Name: Sumario check_fecha_mayor_asigancion; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_mayor_asigancion AFTER INSERT OR UPDATE ON tp1."Sumario" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_fecha_mayor_asignacion();


--
-- TOC entry 2982 (class 2620 OID 18717)
-- Name: Sumario check_fecha_mayor_investigador; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_mayor_investigador AFTER INSERT OR UPDATE ON tp1."Sumario" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_fecha_mayor_investigador();


--
-- TOC entry 2973 (class 2620 OID 18719)
-- Name: OficialSeInvolucro check_fecha_oficial_involucrado; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_oficial_involucrado AFTER INSERT OR UPDATE ON tp1."OficialSeInvolucro" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.oficial_se_involucro_fecha();


--
-- TOC entry 2974 (class 2620 OID 18721)
-- Name: Seguimiento check_fecha_seg_incidente; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_seg_incidente AFTER INSERT OR UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_fecha_incidente();


--
-- TOC entry 2975 (class 2620 OID 18723)
-- Name: Seguimiento check_fecha_seg_oficial; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_seg_oficial AFTER INSERT OR UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_fecha_oficial();


--
-- TOC entry 2983 (class 2620 OID 18725)
-- Name: Sumario check_investigador_no_se_investiga; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_investigador_no_se_investiga AFTER INSERT OR UPDATE ON tp1."Sumario" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_investigador_no_investigado();


--
-- TOC entry 2976 (class 2620 OID 18727)
-- Name: Seguimiento check_seg_conclusion; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_seg_conclusion AFTER INSERT OR UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_conclusion();


--
-- TOC entry 2977 (class 2620 OID 18729)
-- Name: Seguimiento check_seg_placa_fk; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_seg_placa_fk AFTER INSERT OR UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_placa_fk();


--
-- TOC entry 2978 (class 2620 OID 18731)
-- Name: Seguimiento check_seguimiento_cerrado_no_cambia; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_seguimiento_cerrado_no_cambia AFTER UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_al_cerrarse_no_puede_cambiar();


--
-- TOC entry 2979 (class 2620 OID 18733)
-- Name: Seguimiento check_solo_seguido_en_proceso; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_solo_seguido_en_proceso AFTER INSERT OR UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_seguida_si_en_proceso();


--
-- TOC entry 2985 (class 2620 OID 18735)
-- Name: Superheroe check_superheroeo_no_delincuente; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_superheroeo_no_delincuente AFTER INSERT OR UPDATE ON tp1."Superheroe" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.superheroeo_no_delincuente();


--
-- TOC entry 2950 (class 2606 OID 18736)
-- Name: OficialSeInvolucro OficialSeInvolucro_placa_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."OficialSeInvolucro"
    ADD CONSTRAINT "OficialSeInvolucro_placa_fkey" FOREIGN KEY (placa) REFERENCES tp1."Oficial"(placa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2969 (class 2606 OID 18741)
-- Name: archienemigoDe archienemigo_de_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."archienemigoDe"
    ADD CONSTRAINT archienemigo_de_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni);


--
-- TOC entry 2970 (class 2606 OID 18746)
-- Name: archienemigoDe archienemigo_de_id_sh_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."archienemigoDe"
    ADD CONSTRAINT archienemigo_de_id_sh_fkey FOREIGN KEY ("idSuperHeroe") REFERENCES tp1."Superheroe"("idSuperHeroe");


--
-- TOC entry 2937 (class 2606 OID 18751)
-- Name: Asignacion asignacion_id_designacion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Asignacion"
    ADD CONSTRAINT asignacion_id_designacion_fkey FOREIGN KEY ("idDesignacion") REFERENCES tp1."Designacion"("idDesignacion");


--
-- TOC entry 2938 (class 2606 OID 18756)
-- Name: Asignacion asignacion_placa_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Asignacion"
    ADD CONSTRAINT asignacion_placa_fkey FOREIGN KEY (placa) REFERENCES tp1."Oficial"(placa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2939 (class 2606 OID 18761)
-- Name: Conocimiento conocimiento_conocedor_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Conocimiento"
    ADD CONSTRAINT conocimiento_conocedor_fkey FOREIGN KEY (conocedor) REFERENCES tp1."Civil"(dni);


--
-- TOC entry 2940 (class 2606 OID 18766)
-- Name: Conocimiento conocimiento_conocido_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Conocimiento"
    ADD CONSTRAINT conocimiento_conocido_fkey FOREIGN KEY (conocido) REFERENCES tp1."Civil"(dni);


--
-- TOC entry 2941 (class 2606 OID 18771)
-- Name: Conocimiento conocimiento_id_tipo_de_relacion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Conocimiento"
    ADD CONSTRAINT conocimiento_id_tipo_de_relacion_fkey FOREIGN KEY ("idTipoRelacion") REFERENCES tp1."TipoRelacion"("idTipoRelacion");


--
-- TOC entry 2942 (class 2606 OID 18776)
-- Name: Direccion direccion_id_barrio_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Direccion"
    ADD CONSTRAINT direccion_id_barrio_fkey FOREIGN KEY ("idBarrio") REFERENCES tp1."Barrio"("idBarrio");


--
-- TOC entry 2943 (class 2606 OID 18781)
-- Name: EsContactadoPor es_contactado_por_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EsContactadoPor"
    ADD CONSTRAINT es_contactado_por_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni);


--
-- TOC entry 2944 (class 2606 OID 18786)
-- Name: EsContactadoPor es_contactado_por_id_sh_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EsContactadoPor"
    ADD CONSTRAINT es_contactado_por_id_sh_fkey FOREIGN KEY ("idSuperHeroe") REFERENCES tp1."Superheroe"("idSuperHeroe");


--
-- TOC entry 2945 (class 2606 OID 18791)
-- Name: EstaCompuestaPor esta_compuesta_por_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstaCompuestaPor"
    ADD CONSTRAINT esta_compuesta_por_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni);


--
-- TOC entry 2946 (class 2606 OID 18796)
-- Name: EstaCompuestaPor esta_compuesta_por_id_mafia_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstaCompuestaPor"
    ADD CONSTRAINT esta_compuesta_por_id_mafia_fkey FOREIGN KEY ("idMafia") REFERENCES tp1."OrganizacionDelictiva"("idMafia");


--
-- TOC entry 2947 (class 2606 OID 18801)
-- Name: Incidente incidente_idDireccion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Incidente"
    ADD CONSTRAINT "incidente_idDireccion_fkey" FOREIGN KEY ("idDireccion") REFERENCES tp1."Direccion"("idDireccion");


--
-- TOC entry 2948 (class 2606 OID 18806)
-- Name: Incidente incidente_idTIpoIncidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Incidente"
    ADD CONSTRAINT "incidente_idTIpoIncidente_fkey" FOREIGN KEY ("idTipoInicidente") REFERENCES tp1."TipoIncidente"("idTipoInicidente");


--
-- TOC entry 2949 (class 2606 OID 18811)
-- Name: Oficial oficial_idDepartamento_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Oficial"
    ADD CONSTRAINT "oficial_idDepartamento_fkey" FOREIGN KEY ("idDepartamento") REFERENCES tp1."Departamento"("idDepartamento");


--
-- TOC entry 2951 (class 2606 OID 18816)
-- Name: OficialSeInvolucro oficial_se_involucro_id_incidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."OficialSeInvolucro"
    ADD CONSTRAINT oficial_se_involucro_id_incidente_fkey FOREIGN KEY ("idIncidente") REFERENCES tp1."Incidente"("idIncidente");


--
-- TOC entry 2952 (class 2606 OID 18821)
-- Name: OficialSeInvolucro oficial_se_involucro_id_responsabilidad_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."OficialSeInvolucro"
    ADD CONSTRAINT oficial_se_involucro_id_responsabilidad_fkey FOREIGN KEY ("idResponsabilidad") REFERENCES tp1."RolOficial"("idResponsabilidad");


--
-- TOC entry 2953 (class 2606 OID 18826)
-- Name: Posee posee_id_habilidad_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Posee"
    ADD CONSTRAINT posee_id_habilidad_fkey FOREIGN KEY ("idHabilidad") REFERENCES tp1."Habilidad"("idHabilidad");


--
-- TOC entry 2954 (class 2606 OID 18831)
-- Name: Posee posee_id_sh_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Posee"
    ADD CONSTRAINT posee_id_sh_fkey FOREIGN KEY ("idSuperHeroe") REFERENCES tp1."Superheroe"("idSuperHeroe");


--
-- TOC entry 2955 (class 2606 OID 18836)
-- Name: SeInvolucraron se_involucraron_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SeInvolucraron"
    ADD CONSTRAINT se_involucraron_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni);


--
-- TOC entry 2956 (class 2606 OID 18841)
-- Name: SeInvolucraron se_involucraron_id_incidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SeInvolucraron"
    ADD CONSTRAINT se_involucraron_id_incidente_fkey FOREIGN KEY ("idIncidente") REFERENCES tp1."Incidente"("idIncidente");


--
-- TOC entry 2957 (class 2606 OID 18846)
-- Name: SeInvolucraron se_involucraron_id_rol_civil_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SeInvolucraron"
    ADD CONSTRAINT se_involucraron_id_rol_civil_fkey FOREIGN KEY ("idRolCivil") REFERENCES tp1."RolCivil"("idRolCivil");


--
-- TOC entry 2958 (class 2606 OID 18851)
-- Name: Seguimiento seguimiento_idEstadoSeg_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Seguimiento"
    ADD CONSTRAINT "seguimiento_idEstadoSeg_fkey" FOREIGN KEY ("idEstadoSeguimiento") REFERENCES tp1."EstadoSeguimiento"("idEstadoSeguimiento");


--
-- TOC entry 2959 (class 2606 OID 18856)
-- Name: Seguimiento seguimiento_idIncidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Seguimiento"
    ADD CONSTRAINT "seguimiento_idIncidente_fkey" FOREIGN KEY ("idIncidente") REFERENCES tp1."Incidente"("idIncidente");


--
-- TOC entry 2960 (class 2606 OID 18861)
-- Name: Seguimiento seguimiento_placa_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Seguimiento"
    ADD CONSTRAINT seguimiento_placa_fkey FOREIGN KEY (placa) REFERENCES tp1."Oficial"(placa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2961 (class 2606 OID 18866)
-- Name: Sumario sumario_estado_idEEstadoSum; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Sumario"
    ADD CONSTRAINT "sumario_estado_idEEstadoSum" FOREIGN KEY ("idEstadoSumario") REFERENCES tp1."EstadoSumario"("idEstadoSumario") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2962 (class 2606 OID 18871)
-- Name: Sumario sumario_id_asignacion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Sumario"
    ADD CONSTRAINT sumario_id_asignacion_fkey FOREIGN KEY ("idAsignacion") REFERENCES tp1."Asignacion"("idAsignacion");


--
-- TOC entry 2963 (class 2606 OID 18876)
-- Name: Sumario sumario_investigador_placa_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Sumario"
    ADD CONSTRAINT sumario_investigador_placa_fkey FOREIGN KEY (placa) REFERENCES tp1."Oficial"(placa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2964 (class 2606 OID 18881)
-- Name: SuperParticipo super_participo_id_incidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SuperParticipo"
    ADD CONSTRAINT super_participo_id_incidente_fkey FOREIGN KEY ("idIncidente") REFERENCES tp1."Incidente"("idIncidente");


--
-- TOC entry 2965 (class 2606 OID 18886)
-- Name: SuperParticipo super_participo_id_sh_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SuperParticipo"
    ADD CONSTRAINT super_participo_id_sh_fkey FOREIGN KEY ("idSuperHeroe") REFERENCES tp1."Superheroe"("idSuperHeroe");


--
-- TOC entry 2966 (class 2606 OID 18891)
-- Name: Superheroe superheroe_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Superheroe"
    ADD CONSTRAINT superheroe_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni) ON UPDATE CASCADE;


--
-- TOC entry 2967 (class 2606 OID 18896)
-- Name: ViveEn vive_en_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."ViveEn"
    ADD CONSTRAINT vive_en_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni);


--
-- TOC entry 2968 (class 2606 OID 18901)
-- Name: ViveEn vive_en_id_direccion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."ViveEn"
    ADD CONSTRAINT vive_en_id_direccion_fkey FOREIGN KEY ("idDireccion") REFERENCES tp1."Direccion"("idDireccion");


-- Completed on 2018-10-16 12:07:33 -03

--
-- PostgreSQL database dump complete
--

