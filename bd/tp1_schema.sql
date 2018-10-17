--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5 (Ubuntu 10.5-1.pgdg16.04+1)
-- Dumped by pg_dump version 10.5 (Ubuntu 10.5-1.pgdg16.04+1)

-- Started on 2018-10-17 10:00:07 -03

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
-- TOC entry 4 (class 2615 OID 19812)
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
-- TOC entry 3165 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 241 (class 1255 OID 19813)
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
-- TOC entry 242 (class 1255 OID 19814)
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
-- TOC entry 269 (class 1255 OID 20248)
-- Name: civil_no_superparticipo(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.civil_no_superparticipo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT * FROM tp1."Superheroe" sh, tp1."Civil" c , tp1."SuperParticipo" sp  where sp."idSuperHeroe" = sh."idSuperHeroe" and c.dni = sh.dni and c.dni = new.dni and new."idIncidente" = sp."idIncidente" ) THEN
      RAISE EXCEPTION 'no puede participar como superheroe y como civil al mismo tiempo';              
    END IF;
    RETURN NULL;
  END;

$$;


ALTER FUNCTION tp1.civil_no_superparticipo() OWNER TO grupo_01;

--
-- TOC entry 243 (class 1255 OID 19815)
-- Name: dni_oficiales_civiles(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.dni_oficiales_civiles() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    IF EXISTS (SELECT * FROM tp1."Civil" c, tp1."Oficial" o where new.dni = c.dni or new.dni = o.dni) THEN
      RAISE EXCEPTION 'No puede haber un oficial con mismo dni que un civil';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.dni_oficiales_civiles() OWNER TO grupo_01;

--
-- TOC entry 244 (class 1255 OID 19816)
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
-- TOC entry 257 (class 1255 OID 19817)
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
-- TOC entry 258 (class 1255 OID 19818)
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
-- TOC entry 259 (class 1255 OID 19819)
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
-- TOC entry 260 (class 1255 OID 19820)
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
-- TOC entry 261 (class 1255 OID 19821)
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
-- TOC entry 262 (class 1255 OID 19822)
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
-- TOC entry 263 (class 1255 OID 19823)
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
-- TOC entry 264 (class 1255 OID 19824)
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
-- TOC entry 265 (class 1255 OID 19825)
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
-- TOC entry 266 (class 1255 OID 19826)
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
-- TOC entry 267 (class 1255 OID 19827)
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

--
-- TOC entry 268 (class 1255 OID 20245)
-- Name: superparticipo_no_civil(); Type: FUNCTION; Schema: tp1; Owner: grupo_01
--

CREATE FUNCTION tp1.superparticipo_no_civil() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    IF EXISTS (SELECT * FROM tp1."Superheroe" sh, tp1."Civil" c , tp1."SeInvolucraron" si  where new."idSuperHeroe" = sh."idSuperHeroe" and c.dni = sh.dni and c.dni = si.dni and new."idIncidente" = si."idIncidente" ) THEN
      RAISE EXCEPTION 'no puede participar como superheroe y como civil al mismo tiempo';              
    END IF;
    RETURN NULL;
  END;
$$;


ALTER FUNCTION tp1.superparticipo_no_civil() OWNER TO grupo_01;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 19830)
-- Name: Asignacion; Type: TABLE; Schema: tp1; Owner: abg
--

CREATE TABLE tp1."Asignacion" (
    "idAsignacion" integer NOT NULL,
    "fechaInicio" date NOT NULL,
    "idDesignacion" integer NOT NULL,
    placa integer NOT NULL
);


ALTER TABLE tp1."Asignacion" OWNER TO abg;

--
-- TOC entry 197 (class 1259 OID 19828)
-- Name: Asignacion_idAsignacion_seq; Type: SEQUENCE; Schema: tp1; Owner: abg
--

CREATE SEQUENCE tp1."Asignacion_idAsignacion_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tp1."Asignacion_idAsignacion_seq" OWNER TO abg;

--
-- TOC entry 3166 (class 0 OID 0)
-- Dependencies: 197
-- Name: Asignacion_idAsignacion_seq; Type: SEQUENCE OWNED BY; Schema: tp1; Owner: abg
--

ALTER SEQUENCE tp1."Asignacion_idAsignacion_seq" OWNED BY tp1."Asignacion"."idAsignacion";


--
-- TOC entry 200 (class 1259 OID 19836)
-- Name: Barrio; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Barrio" (
    "idBarrio" integer NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."Barrio" OWNER TO grupo_01;

--
-- TOC entry 199 (class 1259 OID 19834)
-- Name: Barrio_idBarrio_seq; Type: SEQUENCE; Schema: tp1; Owner: grupo_01
--

CREATE SEQUENCE tp1."Barrio_idBarrio_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tp1."Barrio_idBarrio_seq" OWNER TO grupo_01;

--
-- TOC entry 3167 (class 0 OID 0)
-- Dependencies: 199
-- Name: Barrio_idBarrio_seq; Type: SEQUENCE OWNED BY; Schema: tp1; Owner: grupo_01
--

ALTER SEQUENCE tp1."Barrio_idBarrio_seq" OWNED BY tp1."Barrio"."idBarrio";


--
-- TOC entry 201 (class 1259 OID 19840)
-- Name: Civil; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Civil" (
    dni integer NOT NULL,
    nombre character varying(250) NOT NULL,
    apellido character varying(250) NOT NULL
);


ALTER TABLE tp1."Civil" OWNER TO grupo_01;

--
-- TOC entry 202 (class 1259 OID 19846)
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
-- TOC entry 204 (class 1259 OID 19851)
-- Name: Departamento; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Departamento" (
    "idDepartamento" integer NOT NULL,
    nombre character varying(250) NOT NULL,
    descripcion text DEFAULT ''::text NOT NULL
);


ALTER TABLE tp1."Departamento" OWNER TO grupo_01;

--
-- TOC entry 203 (class 1259 OID 19849)
-- Name: Departamento_idDepartamento_seq; Type: SEQUENCE; Schema: tp1; Owner: grupo_01
--

CREATE SEQUENCE tp1."Departamento_idDepartamento_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tp1."Departamento_idDepartamento_seq" OWNER TO grupo_01;

--
-- TOC entry 3168 (class 0 OID 0)
-- Dependencies: 203
-- Name: Departamento_idDepartamento_seq; Type: SEQUENCE OWNED BY; Schema: tp1; Owner: grupo_01
--

ALTER SEQUENCE tp1."Departamento_idDepartamento_seq" OWNED BY tp1."Departamento"."idDepartamento";


--
-- TOC entry 206 (class 1259 OID 19861)
-- Name: Designacion; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Designacion" (
    "idDesignacion" integer NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."Designacion" OWNER TO grupo_01;

--
-- TOC entry 205 (class 1259 OID 19859)
-- Name: Designacion_idDesignacion_seq; Type: SEQUENCE; Schema: tp1; Owner: grupo_01
--

CREATE SEQUENCE tp1."Designacion_idDesignacion_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tp1."Designacion_idDesignacion_seq" OWNER TO grupo_01;

--
-- TOC entry 3169 (class 0 OID 0)
-- Dependencies: 205
-- Name: Designacion_idDesignacion_seq; Type: SEQUENCE OWNED BY; Schema: tp1; Owner: grupo_01
--

ALTER SEQUENCE tp1."Designacion_idDesignacion_seq" OWNED BY tp1."Designacion"."idDesignacion";


--
-- TOC entry 208 (class 1259 OID 19867)
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
-- TOC entry 207 (class 1259 OID 19865)
-- Name: Direccion_idDireccion_seq; Type: SEQUENCE; Schema: tp1; Owner: grupo_01
--

CREATE SEQUENCE tp1."Direccion_idDireccion_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tp1."Direccion_idDireccion_seq" OWNER TO grupo_01;

--
-- TOC entry 3170 (class 0 OID 0)
-- Dependencies: 207
-- Name: Direccion_idDireccion_seq; Type: SEQUENCE OWNED BY; Schema: tp1; Owner: grupo_01
--

ALTER SEQUENCE tp1."Direccion_idDireccion_seq" OWNED BY tp1."Direccion"."idDireccion";


--
-- TOC entry 209 (class 1259 OID 19871)
-- Name: EsContactadoPor; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."EsContactadoPor" (
    "idSuperHeroe" integer NOT NULL,
    dni integer NOT NULL
);


ALTER TABLE tp1."EsContactadoPor" OWNER TO grupo_01;

--
-- TOC entry 210 (class 1259 OID 19874)
-- Name: EstaCompuestaPor; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."EstaCompuestaPor" (
    "idMafia" integer NOT NULL,
    dni integer NOT NULL
);


ALTER TABLE tp1."EstaCompuestaPor" OWNER TO grupo_01;

--
-- TOC entry 212 (class 1259 OID 19879)
-- Name: EstadoSeguimiento; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."EstadoSeguimiento" (
    "idEstadoSeguimiento" integer NOT NULL,
    estado character varying(250) NOT NULL
);


ALTER TABLE tp1."EstadoSeguimiento" OWNER TO grupo_01;

--
-- TOC entry 211 (class 1259 OID 19877)
-- Name: EstadoSeguimiento_idEstadoSeguimiento_seq; Type: SEQUENCE; Schema: tp1; Owner: grupo_01
--

CREATE SEQUENCE tp1."EstadoSeguimiento_idEstadoSeguimiento_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tp1."EstadoSeguimiento_idEstadoSeguimiento_seq" OWNER TO grupo_01;

--
-- TOC entry 3171 (class 0 OID 0)
-- Dependencies: 211
-- Name: EstadoSeguimiento_idEstadoSeguimiento_seq; Type: SEQUENCE OWNED BY; Schema: tp1; Owner: grupo_01
--

ALTER SEQUENCE tp1."EstadoSeguimiento_idEstadoSeguimiento_seq" OWNED BY tp1."EstadoSeguimiento"."idEstadoSeguimiento";


--
-- TOC entry 214 (class 1259 OID 19885)
-- Name: EstadoSumario; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."EstadoSumario" (
    "idEstadoSumario" integer NOT NULL,
    estado character varying(25) NOT NULL
);


ALTER TABLE tp1."EstadoSumario" OWNER TO grupo_01;

--
-- TOC entry 213 (class 1259 OID 19883)
-- Name: EstadoSumario_idEstadoSumario_seq; Type: SEQUENCE; Schema: tp1; Owner: grupo_01
--

CREATE SEQUENCE tp1."EstadoSumario_idEstadoSumario_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tp1."EstadoSumario_idEstadoSumario_seq" OWNER TO grupo_01;

--
-- TOC entry 3172 (class 0 OID 0)
-- Dependencies: 213
-- Name: EstadoSumario_idEstadoSumario_seq; Type: SEQUENCE OWNED BY; Schema: tp1; Owner: grupo_01
--

ALTER SEQUENCE tp1."EstadoSumario_idEstadoSumario_seq" OWNED BY tp1."EstadoSumario"."idEstadoSumario";


--
-- TOC entry 216 (class 1259 OID 19891)
-- Name: Habilidad; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Habilidad" (
    "idHabilidad" integer NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."Habilidad" OWNER TO grupo_01;

--
-- TOC entry 215 (class 1259 OID 19889)
-- Name: Habilidad_idHabilidad_seq; Type: SEQUENCE; Schema: tp1; Owner: grupo_01
--

CREATE SEQUENCE tp1."Habilidad_idHabilidad_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tp1."Habilidad_idHabilidad_seq" OWNER TO grupo_01;

--
-- TOC entry 3173 (class 0 OID 0)
-- Dependencies: 215
-- Name: Habilidad_idHabilidad_seq; Type: SEQUENCE OWNED BY; Schema: tp1; Owner: grupo_01
--

ALTER SEQUENCE tp1."Habilidad_idHabilidad_seq" OWNED BY tp1."Habilidad"."idHabilidad";


--
-- TOC entry 218 (class 1259 OID 19897)
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
-- TOC entry 217 (class 1259 OID 19895)
-- Name: Incidente_idIncidente_seq; Type: SEQUENCE; Schema: tp1; Owner: grupo_01
--

CREATE SEQUENCE tp1."Incidente_idIncidente_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tp1."Incidente_idIncidente_seq" OWNER TO grupo_01;

--
-- TOC entry 3174 (class 0 OID 0)
-- Dependencies: 217
-- Name: Incidente_idIncidente_seq; Type: SEQUENCE OWNED BY; Schema: tp1; Owner: grupo_01
--

ALTER SEQUENCE tp1."Incidente_idIncidente_seq" OWNED BY tp1."Incidente"."idIncidente";


--
-- TOC entry 219 (class 1259 OID 19904)
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
-- TOC entry 220 (class 1259 OID 19910)
-- Name: OficialSeInvolucro; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."OficialSeInvolucro" (
    placa integer NOT NULL,
    "idIncidente" integer NOT NULL,
    "idResponsabilidad" integer NOT NULL
);


ALTER TABLE tp1."OficialSeInvolucro" OWNER TO grupo_01;

--
-- TOC entry 222 (class 1259 OID 19915)
-- Name: OrganizacionDelictiva; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."OrganizacionDelictiva" (
    "idMafia" integer NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."OrganizacionDelictiva" OWNER TO grupo_01;

--
-- TOC entry 221 (class 1259 OID 19913)
-- Name: OrganizacionDelictiva_idMafia_seq; Type: SEQUENCE; Schema: tp1; Owner: grupo_01
--

CREATE SEQUENCE tp1."OrganizacionDelictiva_idMafia_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tp1."OrganizacionDelictiva_idMafia_seq" OWNER TO grupo_01;

--
-- TOC entry 3175 (class 0 OID 0)
-- Dependencies: 221
-- Name: OrganizacionDelictiva_idMafia_seq; Type: SEQUENCE OWNED BY; Schema: tp1; Owner: grupo_01
--

ALTER SEQUENCE tp1."OrganizacionDelictiva_idMafia_seq" OWNED BY tp1."OrganizacionDelictiva"."idMafia";


--
-- TOC entry 223 (class 1259 OID 19919)
-- Name: Posee; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."Posee" (
    "idSuperHeroe" integer NOT NULL,
    "idHabilidad" integer NOT NULL
);


ALTER TABLE tp1."Posee" OWNER TO grupo_01;

--
-- TOC entry 225 (class 1259 OID 19924)
-- Name: RolCivil; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."RolCivil" (
    "idRolCivil" integer NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."RolCivil" OWNER TO grupo_01;

--
-- TOC entry 224 (class 1259 OID 19922)
-- Name: RolCivil_idRolCivil_seq; Type: SEQUENCE; Schema: tp1; Owner: grupo_01
--

CREATE SEQUENCE tp1."RolCivil_idRolCivil_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tp1."RolCivil_idRolCivil_seq" OWNER TO grupo_01;

--
-- TOC entry 3176 (class 0 OID 0)
-- Dependencies: 224
-- Name: RolCivil_idRolCivil_seq; Type: SEQUENCE OWNED BY; Schema: tp1; Owner: grupo_01
--

ALTER SEQUENCE tp1."RolCivil_idRolCivil_seq" OWNED BY tp1."RolCivil"."idRolCivil";


--
-- TOC entry 227 (class 1259 OID 19930)
-- Name: RolOficial; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."RolOficial" (
    "idResponsabilidad" integer NOT NULL,
    descripcion character varying(250) NOT NULL
);


ALTER TABLE tp1."RolOficial" OWNER TO grupo_01;

--
-- TOC entry 226 (class 1259 OID 19928)
-- Name: RolOficial_idResponsabilidad_seq; Type: SEQUENCE; Schema: tp1; Owner: grupo_01
--

CREATE SEQUENCE tp1."RolOficial_idResponsabilidad_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tp1."RolOficial_idResponsabilidad_seq" OWNER TO grupo_01;

--
-- TOC entry 3177 (class 0 OID 0)
-- Dependencies: 226
-- Name: RolOficial_idResponsabilidad_seq; Type: SEQUENCE OWNED BY; Schema: tp1; Owner: grupo_01
--

ALTER SEQUENCE tp1."RolOficial_idResponsabilidad_seq" OWNED BY tp1."RolOficial"."idResponsabilidad";


--
-- TOC entry 228 (class 1259 OID 19934)
-- Name: SeInvolucraron; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."SeInvolucraron" (
    dni integer NOT NULL,
    "idIncidente" integer NOT NULL,
    "idRolCivil" integer NOT NULL
);


ALTER TABLE tp1."SeInvolucraron" OWNER TO grupo_01;

--
-- TOC entry 229 (class 1259 OID 19937)
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
-- TOC entry 231 (class 1259 OID 19945)
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
-- TOC entry 230 (class 1259 OID 19943)
-- Name: Sumario_idSumario_seq; Type: SEQUENCE; Schema: tp1; Owner: grupo_01
--

CREATE SEQUENCE tp1."Sumario_idSumario_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tp1."Sumario_idSumario_seq" OWNER TO grupo_01;

--
-- TOC entry 3178 (class 0 OID 0)
-- Dependencies: 230
-- Name: Sumario_idSumario_seq; Type: SEQUENCE OWNED BY; Schema: tp1; Owner: grupo_01
--

ALTER SEQUENCE tp1."Sumario_idSumario_seq" OWNED BY tp1."Sumario"."idSumario";


--
-- TOC entry 232 (class 1259 OID 19952)
-- Name: SuperParticipo; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."SuperParticipo" (
    "idSuperHeroe" integer NOT NULL,
    "idIncidente" integer NOT NULL
);


ALTER TABLE tp1."SuperParticipo" OWNER TO grupo_01;

--
-- TOC entry 234 (class 1259 OID 19957)
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
-- TOC entry 233 (class 1259 OID 19955)
-- Name: Superheroe_idSuperHeroe_seq; Type: SEQUENCE; Schema: tp1; Owner: grupo_01
--

CREATE SEQUENCE tp1."Superheroe_idSuperHeroe_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tp1."Superheroe_idSuperHeroe_seq" OWNER TO grupo_01;

--
-- TOC entry 3179 (class 0 OID 0)
-- Dependencies: 233
-- Name: Superheroe_idSuperHeroe_seq; Type: SEQUENCE OWNED BY; Schema: tp1; Owner: grupo_01
--

ALTER SEQUENCE tp1."Superheroe_idSuperHeroe_seq" OWNED BY tp1."Superheroe"."idSuperHeroe";


--
-- TOC entry 236 (class 1259 OID 19967)
-- Name: TipoIncidente; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."TipoIncidente" (
    "idTipoInicidente" integer NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."TipoIncidente" OWNER TO grupo_01;

--
-- TOC entry 235 (class 1259 OID 19965)
-- Name: TipoIncidente_idTipoInicidente_seq; Type: SEQUENCE; Schema: tp1; Owner: grupo_01
--

CREATE SEQUENCE tp1."TipoIncidente_idTipoInicidente_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tp1."TipoIncidente_idTipoInicidente_seq" OWNER TO grupo_01;

--
-- TOC entry 3180 (class 0 OID 0)
-- Dependencies: 235
-- Name: TipoIncidente_idTipoInicidente_seq; Type: SEQUENCE OWNED BY; Schema: tp1; Owner: grupo_01
--

ALTER SEQUENCE tp1."TipoIncidente_idTipoInicidente_seq" OWNED BY tp1."TipoIncidente"."idTipoInicidente";


--
-- TOC entry 238 (class 1259 OID 19973)
-- Name: TipoRelacion; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."TipoRelacion" (
    "idTipoRelacion" integer NOT NULL,
    nombre character varying(250) NOT NULL
);


ALTER TABLE tp1."TipoRelacion" OWNER TO grupo_01;

--
-- TOC entry 237 (class 1259 OID 19971)
-- Name: TipoRelacion_idTipoRelacion_seq; Type: SEQUENCE; Schema: tp1; Owner: grupo_01
--

CREATE SEQUENCE tp1."TipoRelacion_idTipoRelacion_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tp1."TipoRelacion_idTipoRelacion_seq" OWNER TO grupo_01;

--
-- TOC entry 3181 (class 0 OID 0)
-- Dependencies: 237
-- Name: TipoRelacion_idTipoRelacion_seq; Type: SEQUENCE OWNED BY; Schema: tp1; Owner: grupo_01
--

ALTER SEQUENCE tp1."TipoRelacion_idTipoRelacion_seq" OWNED BY tp1."TipoRelacion"."idTipoRelacion";


--
-- TOC entry 239 (class 1259 OID 19977)
-- Name: ViveEn; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."ViveEn" (
    dni integer NOT NULL,
    "idDireccion" integer NOT NULL,
    "fechaInicio" date NOT NULL
);


ALTER TABLE tp1."ViveEn" OWNER TO grupo_01;

--
-- TOC entry 240 (class 1259 OID 19980)
-- Name: archienemigoDe; Type: TABLE; Schema: tp1; Owner: grupo_01
--

CREATE TABLE tp1."archienemigoDe" (
    "idSuperHeroe" integer NOT NULL,
    dni integer NOT NULL
);


ALTER TABLE tp1."archienemigoDe" OWNER TO grupo_01;

--
-- TOC entry 2906 (class 2604 OID 19833)
-- Name: Asignacion idAsignacion; Type: DEFAULT; Schema: tp1; Owner: abg
--

ALTER TABLE ONLY tp1."Asignacion" ALTER COLUMN "idAsignacion" SET DEFAULT nextval('tp1."Asignacion_idAsignacion_seq"'::regclass);


--
-- TOC entry 2907 (class 2604 OID 19839)
-- Name: Barrio idBarrio; Type: DEFAULT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Barrio" ALTER COLUMN "idBarrio" SET DEFAULT nextval('tp1."Barrio_idBarrio_seq"'::regclass);


--
-- TOC entry 2908 (class 2604 OID 19854)
-- Name: Departamento idDepartamento; Type: DEFAULT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Departamento" ALTER COLUMN "idDepartamento" SET DEFAULT nextval('tp1."Departamento_idDepartamento_seq"'::regclass);


--
-- TOC entry 2910 (class 2604 OID 19864)
-- Name: Designacion idDesignacion; Type: DEFAULT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Designacion" ALTER COLUMN "idDesignacion" SET DEFAULT nextval('tp1."Designacion_idDesignacion_seq"'::regclass);


--
-- TOC entry 2911 (class 2604 OID 19870)
-- Name: Direccion idDireccion; Type: DEFAULT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Direccion" ALTER COLUMN "idDireccion" SET DEFAULT nextval('tp1."Direccion_idDireccion_seq"'::regclass);


--
-- TOC entry 2912 (class 2604 OID 19882)
-- Name: EstadoSeguimiento idEstadoSeguimiento; Type: DEFAULT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstadoSeguimiento" ALTER COLUMN "idEstadoSeguimiento" SET DEFAULT nextval('tp1."EstadoSeguimiento_idEstadoSeguimiento_seq"'::regclass);


--
-- TOC entry 2913 (class 2604 OID 19888)
-- Name: EstadoSumario idEstadoSumario; Type: DEFAULT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstadoSumario" ALTER COLUMN "idEstadoSumario" SET DEFAULT nextval('tp1."EstadoSumario_idEstadoSumario_seq"'::regclass);


--
-- TOC entry 2914 (class 2604 OID 19894)
-- Name: Habilidad idHabilidad; Type: DEFAULT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Habilidad" ALTER COLUMN "idHabilidad" SET DEFAULT nextval('tp1."Habilidad_idHabilidad_seq"'::regclass);


--
-- TOC entry 2915 (class 2604 OID 19900)
-- Name: Incidente idIncidente; Type: DEFAULT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Incidente" ALTER COLUMN "idIncidente" SET DEFAULT nextval('tp1."Incidente_idIncidente_seq"'::regclass);


--
-- TOC entry 2916 (class 2604 OID 19918)
-- Name: OrganizacionDelictiva idMafia; Type: DEFAULT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."OrganizacionDelictiva" ALTER COLUMN "idMafia" SET DEFAULT nextval('tp1."OrganizacionDelictiva_idMafia_seq"'::regclass);


--
-- TOC entry 2917 (class 2604 OID 19927)
-- Name: RolCivil idRolCivil; Type: DEFAULT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."RolCivil" ALTER COLUMN "idRolCivil" SET DEFAULT nextval('tp1."RolCivil_idRolCivil_seq"'::regclass);


--
-- TOC entry 2918 (class 2604 OID 19933)
-- Name: RolOficial idResponsabilidad; Type: DEFAULT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."RolOficial" ALTER COLUMN "idResponsabilidad" SET DEFAULT nextval('tp1."RolOficial_idResponsabilidad_seq"'::regclass);


--
-- TOC entry 2919 (class 2604 OID 19948)
-- Name: Sumario idSumario; Type: DEFAULT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Sumario" ALTER COLUMN "idSumario" SET DEFAULT nextval('tp1."Sumario_idSumario_seq"'::regclass);


--
-- TOC entry 2920 (class 2604 OID 19960)
-- Name: Superheroe idSuperHeroe; Type: DEFAULT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Superheroe" ALTER COLUMN "idSuperHeroe" SET DEFAULT nextval('tp1."Superheroe_idSuperHeroe_seq"'::regclass);


--
-- TOC entry 2922 (class 2604 OID 19970)
-- Name: TipoIncidente idTipoInicidente; Type: DEFAULT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."TipoIncidente" ALTER COLUMN "idTipoInicidente" SET DEFAULT nextval('tp1."TipoIncidente_idTipoInicidente_seq"'::regclass);


--
-- TOC entry 2923 (class 2604 OID 19976)
-- Name: TipoRelacion idTipoRelacion; Type: DEFAULT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."TipoRelacion" ALTER COLUMN "idTipoRelacion" SET DEFAULT nextval('tp1."TipoRelacion_idTipoRelacion_seq"'::regclass);


--
-- TOC entry 2929 (class 2606 OID 19984)
-- Name: Civil Civil_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Civil"
    ADD CONSTRAINT "Civil_pkey" PRIMARY KEY (dni);


--
-- TOC entry 2933 (class 2606 OID 19986)
-- Name: Departamento Departamento_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Departamento"
    ADD CONSTRAINT "Departamento_pkey" PRIMARY KEY ("idDepartamento");


--
-- TOC entry 2937 (class 2606 OID 19988)
-- Name: Direccion Direccion_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Direccion"
    ADD CONSTRAINT "Direccion_pkey" PRIMARY KEY ("idDireccion");


--
-- TOC entry 2949 (class 2606 OID 19990)
-- Name: Incidente Incidente_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Incidente"
    ADD CONSTRAINT "Incidente_pkey" PRIMARY KEY ("idIncidente");


--
-- TOC entry 2959 (class 2606 OID 19992)
-- Name: OrganizacionDelictiva Organización_delictiva_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."OrganizacionDelictiva"
    ADD CONSTRAINT "Organización_delictiva_pkey" PRIMARY KEY ("idMafia");


--
-- TOC entry 2980 (class 2606 OID 19994)
-- Name: TipoRelacion TipoDeRelacion_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."TipoRelacion"
    ADD CONSTRAINT "TipoDeRelacion_pkey" PRIMARY KEY ("idTipoRelacion");


--
-- TOC entry 2978 (class 2606 OID 19996)
-- Name: TipoIncidente TipoIncidente_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."TipoIncidente"
    ADD CONSTRAINT "TipoIncidente_pkey" PRIMARY KEY ("idTipoInicidente");


--
-- TOC entry 2984 (class 2606 OID 19998)
-- Name: archienemigoDe archienemigo_de_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."archienemigoDe"
    ADD CONSTRAINT archienemigo_de_pkey PRIMARY KEY ("idSuperHeroe", dni);


--
-- TOC entry 2925 (class 2606 OID 20000)
-- Name: Asignacion asignacion_pkey; Type: CONSTRAINT; Schema: tp1; Owner: abg
--

ALTER TABLE ONLY tp1."Asignacion"
    ADD CONSTRAINT asignacion_pkey PRIMARY KEY ("idAsignacion");


--
-- TOC entry 2931 (class 2606 OID 20002)
-- Name: Conocimiento conocimiento_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Conocimiento"
    ADD CONSTRAINT conocimiento_pkey PRIMARY KEY (conocedor, conocido);


--
-- TOC entry 2935 (class 2606 OID 20004)
-- Name: Designacion designacion_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Designacion"
    ADD CONSTRAINT designacion_pkey PRIMARY KEY ("idDesignacion");


--
-- TOC entry 2939 (class 2606 OID 20006)
-- Name: EsContactadoPor es_contactado_por_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EsContactadoPor"
    ADD CONSTRAINT es_contactado_por_pkey PRIMARY KEY ("idSuperHeroe", dni);


--
-- TOC entry 2941 (class 2606 OID 20008)
-- Name: EstaCompuestaPor esta_compuesta_por_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstaCompuestaPor"
    ADD CONSTRAINT esta_compuesta_por_pkey PRIMARY KEY ("idMafia", dni);


--
-- TOC entry 2943 (class 2606 OID 20010)
-- Name: EstadoSeguimiento estadoSeguimiento_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstadoSeguimiento"
    ADD CONSTRAINT "estadoSeguimiento_pkey" PRIMARY KEY ("idEstadoSeguimiento");


--
-- TOC entry 2945 (class 2606 OID 20012)
-- Name: EstadoSumario estado_sumario_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstadoSumario"
    ADD CONSTRAINT estado_sumario_pkey PRIMARY KEY ("idEstadoSumario");


--
-- TOC entry 2927 (class 2606 OID 20014)
-- Name: Barrio idBarrio; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Barrio"
    ADD CONSTRAINT "idBarrio" PRIMARY KEY ("idBarrio");


--
-- TOC entry 2953 (class 2606 OID 20016)
-- Name: Oficial oficial_dni_key; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Oficial"
    ADD CONSTRAINT oficial_dni_key UNIQUE (dni);


--
-- TOC entry 2955 (class 2606 OID 20018)
-- Name: Oficial oficial_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Oficial"
    ADD CONSTRAINT oficial_pkey PRIMARY KEY (placa);


--
-- TOC entry 2957 (class 2606 OID 20020)
-- Name: OficialSeInvolucro oficial_se_involucro_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."OficialSeInvolucro"
    ADD CONSTRAINT oficial_se_involucro_pkey PRIMARY KEY (placa, "idIncidente", "idResponsabilidad");


--
-- TOC entry 2947 (class 2606 OID 20022)
-- Name: Habilidad pk_habilidad; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Habilidad"
    ADD CONSTRAINT pk_habilidad PRIMARY KEY ("idHabilidad");


--
-- TOC entry 2961 (class 2606 OID 20024)
-- Name: Posee posee_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Posee"
    ADD CONSTRAINT posee_pkey PRIMARY KEY ("idSuperHeroe", "idHabilidad");


--
-- TOC entry 2963 (class 2606 OID 20026)
-- Name: RolCivil rol_civil_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."RolCivil"
    ADD CONSTRAINT rol_civil_pkey PRIMARY KEY ("idRolCivil");


--
-- TOC entry 2965 (class 2606 OID 20028)
-- Name: RolOficial rol_oficial_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."RolOficial"
    ADD CONSTRAINT rol_oficial_pkey PRIMARY KEY ("idResponsabilidad");


--
-- TOC entry 2967 (class 2606 OID 20030)
-- Name: SeInvolucraron se_involucraron_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SeInvolucraron"
    ADD CONSTRAINT se_involucraron_pkey PRIMARY KEY (dni, "idIncidente");


--
-- TOC entry 2969 (class 2606 OID 20032)
-- Name: Seguimiento seguimiento_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Seguimiento"
    ADD CONSTRAINT seguimiento_pkey PRIMARY KEY (numero, "idIncidente");


--
-- TOC entry 2971 (class 2606 OID 20034)
-- Name: Sumario sumario_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Sumario"
    ADD CONSTRAINT sumario_pkey PRIMARY KEY ("idSumario");


--
-- TOC entry 2973 (class 2606 OID 20036)
-- Name: SuperParticipo super_participo_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SuperParticipo"
    ADD CONSTRAINT super_participo_pkey PRIMARY KEY ("idSuperHeroe", "idIncidente");


--
-- TOC entry 2976 (class 2606 OID 20038)
-- Name: Superheroe superheroe_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Superheroe"
    ADD CONSTRAINT superheroe_pkey PRIMARY KEY ("idSuperHeroe");


--
-- TOC entry 2982 (class 2606 OID 20040)
-- Name: ViveEn vive_en_pkey; Type: CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."ViveEn"
    ADD CONSTRAINT vive_en_pkey PRIMARY KEY (dni, "idDireccion");


--
-- TOC entry 2950 (class 1259 OID 20041)
-- Name: fki_idDireccion; Type: INDEX; Schema: tp1; Owner: grupo_01
--

CREATE INDEX "fki_idDireccion" ON tp1."Incidente" USING btree ("idDireccion");


--
-- TOC entry 2951 (class 1259 OID 20042)
-- Name: fki_idTipoIncidente; Type: INDEX; Schema: tp1; Owner: grupo_01
--

CREATE INDEX "fki_idTipoIncidente" ON tp1."Incidente" USING btree ("idTipoInicidente");


--
-- TOC entry 2974 (class 1259 OID 20043)
-- Name: fki_superheroe_dni; Type: INDEX; Schema: tp1; Owner: grupo_01
--

CREATE INDEX fki_superheroe_dni ON tp1."Superheroe" USING btree (dni);


--
-- TOC entry 3036 (class 2620 OID 20045)
-- Name: archienemigoDe check_archienemigo_de_si_mismo; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_archienemigo_de_si_mismo AFTER INSERT OR UPDATE ON tp1."archienemigoDe" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.archienemigo_no_es_el_mismo();


--
-- TOC entry 3029 (class 2620 OID 20047)
-- Name: Sumario check_concluyo_tiene_resultado; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_concluyo_tiene_resultado AFTER INSERT OR UPDATE ON tp1."Sumario" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_concluyo_tiene_resultado();


--
-- TOC entry 3021 (class 2620 OID 20049)
-- Name: Oficial check_dni_no_civiles; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_dni_no_civiles AFTER INSERT OR UPDATE ON tp1."Oficial" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.dni_oficiales_civiles();


--
-- TOC entry 3020 (class 2620 OID 20252)
-- Name: Civil check_dni_no_oficial; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_dni_no_oficial AFTER INSERT OR UPDATE ON tp1."Civil" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.dni_oficiales_civiles();


--
-- TOC entry 3030 (class 2620 OID 20051)
-- Name: Sumario check_es_tipo_investigador; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_es_tipo_investigador AFTER INSERT OR UPDATE ON tp1."Sumario" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_es_tipo_investigador();


--
-- TOC entry 3019 (class 2620 OID 20053)
-- Name: Asignacion check_fecha_inicio_mayor_a_oficial; Type: TRIGGER; Schema: tp1; Owner: abg
--

CREATE CONSTRAINT TRIGGER check_fecha_inicio_mayor_a_oficial AFTER INSERT OR UPDATE ON tp1."Asignacion" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.asignacion_fecha_mayor_a_oficial();


--
-- TOC entry 3031 (class 2620 OID 20055)
-- Name: Sumario check_fecha_mayor_asigancion; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_mayor_asigancion AFTER INSERT OR UPDATE ON tp1."Sumario" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_fecha_mayor_asignacion();


--
-- TOC entry 3032 (class 2620 OID 20057)
-- Name: Sumario check_fecha_mayor_investigador; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_mayor_investigador AFTER INSERT OR UPDATE ON tp1."Sumario" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_fecha_mayor_investigador();


--
-- TOC entry 3022 (class 2620 OID 20059)
-- Name: OficialSeInvolucro check_fecha_oficial_involucrado; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_oficial_involucrado AFTER INSERT OR UPDATE ON tp1."OficialSeInvolucro" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.oficial_se_involucro_fecha();


--
-- TOC entry 3024 (class 2620 OID 20061)
-- Name: Seguimiento check_fecha_seg_incidente; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_seg_incidente AFTER INSERT OR UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_fecha_incidente();


--
-- TOC entry 3025 (class 2620 OID 20063)
-- Name: Seguimiento check_fecha_seg_oficial; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_fecha_seg_oficial AFTER INSERT OR UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_fecha_oficial();


--
-- TOC entry 3033 (class 2620 OID 20065)
-- Name: Sumario check_investigador_no_se_investiga; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_investigador_no_se_investiga AFTER INSERT OR UPDATE ON tp1."Sumario" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.sumario_investigador_no_investigado();


--
-- TOC entry 3026 (class 2620 OID 20067)
-- Name: Seguimiento check_seg_conclusion; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_seg_conclusion AFTER INSERT OR UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_conclusion();


--
-- TOC entry 3027 (class 2620 OID 20069)
-- Name: Seguimiento check_seguimiento_cerrado_no_cambia; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_seguimiento_cerrado_no_cambia AFTER UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_al_cerrarse_no_puede_cambiar();


--
-- TOC entry 3023 (class 2620 OID 20250)
-- Name: SeInvolucraron check_seinvolucraron_no_sh; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_seinvolucraron_no_sh AFTER INSERT OR UPDATE ON tp1."SeInvolucraron" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.civil_no_superparticipo();


--
-- TOC entry 3028 (class 2620 OID 20071)
-- Name: Seguimiento check_solo_seguido_en_proceso; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_solo_seguido_en_proceso AFTER INSERT OR UPDATE ON tp1."Seguimiento" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.seguimiento_seguida_si_en_proceso();


--
-- TOC entry 3035 (class 2620 OID 20073)
-- Name: Superheroe check_superheroeo_no_delincuente; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_superheroeo_no_delincuente AFTER INSERT OR UPDATE ON tp1."Superheroe" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.superheroeo_no_delincuente();


--
-- TOC entry 3034 (class 2620 OID 20247)
-- Name: SuperParticipo check_superparticipo_no_civil; Type: TRIGGER; Schema: tp1; Owner: grupo_01
--

CREATE CONSTRAINT TRIGGER check_superparticipo_no_civil AFTER INSERT OR UPDATE ON tp1."SuperParticipo" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE tp1.superparticipo_no_civil();


--
-- TOC entry 2998 (class 2606 OID 20074)
-- Name: OficialSeInvolucro OficialSeInvolucro_placa_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."OficialSeInvolucro"
    ADD CONSTRAINT "OficialSeInvolucro_placa_fkey" FOREIGN KEY (placa) REFERENCES tp1."Oficial"(placa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3017 (class 2606 OID 20079)
-- Name: archienemigoDe archienemigo_de_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."archienemigoDe"
    ADD CONSTRAINT archienemigo_de_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni);


--
-- TOC entry 3018 (class 2606 OID 20084)
-- Name: archienemigoDe archienemigo_de_id_sh_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."archienemigoDe"
    ADD CONSTRAINT archienemigo_de_id_sh_fkey FOREIGN KEY ("idSuperHeroe") REFERENCES tp1."Superheroe"("idSuperHeroe");


--
-- TOC entry 2985 (class 2606 OID 20089)
-- Name: Asignacion asignacion_id_designacion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: abg
--

ALTER TABLE ONLY tp1."Asignacion"
    ADD CONSTRAINT asignacion_id_designacion_fkey FOREIGN KEY ("idDesignacion") REFERENCES tp1."Designacion"("idDesignacion");


--
-- TOC entry 2986 (class 2606 OID 20094)
-- Name: Asignacion asignacion_placa_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: abg
--

ALTER TABLE ONLY tp1."Asignacion"
    ADD CONSTRAINT asignacion_placa_fkey FOREIGN KEY (placa) REFERENCES tp1."Oficial"(placa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2987 (class 2606 OID 20099)
-- Name: Conocimiento conocimiento_conocedor_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Conocimiento"
    ADD CONSTRAINT conocimiento_conocedor_fkey FOREIGN KEY (conocedor) REFERENCES tp1."Civil"(dni);


--
-- TOC entry 2988 (class 2606 OID 20104)
-- Name: Conocimiento conocimiento_conocido_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Conocimiento"
    ADD CONSTRAINT conocimiento_conocido_fkey FOREIGN KEY (conocido) REFERENCES tp1."Civil"(dni);


--
-- TOC entry 2989 (class 2606 OID 20109)
-- Name: Conocimiento conocimiento_id_tipo_de_relacion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Conocimiento"
    ADD CONSTRAINT conocimiento_id_tipo_de_relacion_fkey FOREIGN KEY ("idTipoRelacion") REFERENCES tp1."TipoRelacion"("idTipoRelacion");


--
-- TOC entry 2990 (class 2606 OID 20114)
-- Name: Direccion direccion_id_barrio_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Direccion"
    ADD CONSTRAINT direccion_id_barrio_fkey FOREIGN KEY ("idBarrio") REFERENCES tp1."Barrio"("idBarrio");


--
-- TOC entry 2991 (class 2606 OID 20119)
-- Name: EsContactadoPor es_contactado_por_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EsContactadoPor"
    ADD CONSTRAINT es_contactado_por_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni);


--
-- TOC entry 2992 (class 2606 OID 20124)
-- Name: EsContactadoPor es_contactado_por_id_sh_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EsContactadoPor"
    ADD CONSTRAINT es_contactado_por_id_sh_fkey FOREIGN KEY ("idSuperHeroe") REFERENCES tp1."Superheroe"("idSuperHeroe");


--
-- TOC entry 2993 (class 2606 OID 20129)
-- Name: EstaCompuestaPor esta_compuesta_por_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstaCompuestaPor"
    ADD CONSTRAINT esta_compuesta_por_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni);


--
-- TOC entry 2994 (class 2606 OID 20134)
-- Name: EstaCompuestaPor esta_compuesta_por_id_mafia_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."EstaCompuestaPor"
    ADD CONSTRAINT esta_compuesta_por_id_mafia_fkey FOREIGN KEY ("idMafia") REFERENCES tp1."OrganizacionDelictiva"("idMafia");


--
-- TOC entry 2995 (class 2606 OID 20139)
-- Name: Incidente incidente_idDireccion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Incidente"
    ADD CONSTRAINT "incidente_idDireccion_fkey" FOREIGN KEY ("idDireccion") REFERENCES tp1."Direccion"("idDireccion");


--
-- TOC entry 2996 (class 2606 OID 20144)
-- Name: Incidente incidente_idTIpoIncidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Incidente"
    ADD CONSTRAINT "incidente_idTIpoIncidente_fkey" FOREIGN KEY ("idTipoInicidente") REFERENCES tp1."TipoIncidente"("idTipoInicidente");


--
-- TOC entry 2997 (class 2606 OID 20149)
-- Name: Oficial oficial_idDepartamento_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Oficial"
    ADD CONSTRAINT "oficial_idDepartamento_fkey" FOREIGN KEY ("idDepartamento") REFERENCES tp1."Departamento"("idDepartamento");


--
-- TOC entry 2999 (class 2606 OID 20154)
-- Name: OficialSeInvolucro oficial_se_involucro_id_incidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."OficialSeInvolucro"
    ADD CONSTRAINT oficial_se_involucro_id_incidente_fkey FOREIGN KEY ("idIncidente") REFERENCES tp1."Incidente"("idIncidente");


--
-- TOC entry 3000 (class 2606 OID 20159)
-- Name: OficialSeInvolucro oficial_se_involucro_id_responsabilidad_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."OficialSeInvolucro"
    ADD CONSTRAINT oficial_se_involucro_id_responsabilidad_fkey FOREIGN KEY ("idResponsabilidad") REFERENCES tp1."RolOficial"("idResponsabilidad");


--
-- TOC entry 3001 (class 2606 OID 20164)
-- Name: Posee posee_id_habilidad_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Posee"
    ADD CONSTRAINT posee_id_habilidad_fkey FOREIGN KEY ("idHabilidad") REFERENCES tp1."Habilidad"("idHabilidad");


--
-- TOC entry 3002 (class 2606 OID 20169)
-- Name: Posee posee_id_sh_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Posee"
    ADD CONSTRAINT posee_id_sh_fkey FOREIGN KEY ("idSuperHeroe") REFERENCES tp1."Superheroe"("idSuperHeroe");


--
-- TOC entry 3003 (class 2606 OID 20174)
-- Name: SeInvolucraron se_involucraron_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SeInvolucraron"
    ADD CONSTRAINT se_involucraron_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni);


--
-- TOC entry 3004 (class 2606 OID 20179)
-- Name: SeInvolucraron se_involucraron_id_incidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SeInvolucraron"
    ADD CONSTRAINT se_involucraron_id_incidente_fkey FOREIGN KEY ("idIncidente") REFERENCES tp1."Incidente"("idIncidente");


--
-- TOC entry 3005 (class 2606 OID 20184)
-- Name: SeInvolucraron se_involucraron_id_rol_civil_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SeInvolucraron"
    ADD CONSTRAINT se_involucraron_id_rol_civil_fkey FOREIGN KEY ("idRolCivil") REFERENCES tp1."RolCivil"("idRolCivil");


--
-- TOC entry 3006 (class 2606 OID 20189)
-- Name: Seguimiento seguimiento_idEstadoSeg_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Seguimiento"
    ADD CONSTRAINT "seguimiento_idEstadoSeg_fkey" FOREIGN KEY ("idEstadoSeguimiento") REFERENCES tp1."EstadoSeguimiento"("idEstadoSeguimiento");


--
-- TOC entry 3007 (class 2606 OID 20194)
-- Name: Seguimiento seguimiento_idIncidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Seguimiento"
    ADD CONSTRAINT "seguimiento_idIncidente_fkey" FOREIGN KEY ("idIncidente") REFERENCES tp1."Incidente"("idIncidente");


--
-- TOC entry 3008 (class 2606 OID 20199)
-- Name: Seguimiento seguimiento_placa_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Seguimiento"
    ADD CONSTRAINT seguimiento_placa_fkey FOREIGN KEY (placa) REFERENCES tp1."Oficial"(placa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3009 (class 2606 OID 20204)
-- Name: Sumario sumario_estado_idEEstadoSum; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Sumario"
    ADD CONSTRAINT "sumario_estado_idEEstadoSum" FOREIGN KEY ("idEstadoSumario") REFERENCES tp1."EstadoSumario"("idEstadoSumario") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3010 (class 2606 OID 20209)
-- Name: Sumario sumario_id_asignacion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Sumario"
    ADD CONSTRAINT sumario_id_asignacion_fkey FOREIGN KEY ("idAsignacion") REFERENCES tp1."Asignacion"("idAsignacion");


--
-- TOC entry 3011 (class 2606 OID 20214)
-- Name: Sumario sumario_investigador_placa_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Sumario"
    ADD CONSTRAINT sumario_investigador_placa_fkey FOREIGN KEY (placa) REFERENCES tp1."Oficial"(placa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3012 (class 2606 OID 20219)
-- Name: SuperParticipo super_participo_id_incidente_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SuperParticipo"
    ADD CONSTRAINT super_participo_id_incidente_fkey FOREIGN KEY ("idIncidente") REFERENCES tp1."Incidente"("idIncidente");


--
-- TOC entry 3013 (class 2606 OID 20224)
-- Name: SuperParticipo super_participo_id_sh_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."SuperParticipo"
    ADD CONSTRAINT super_participo_id_sh_fkey FOREIGN KEY ("idSuperHeroe") REFERENCES tp1."Superheroe"("idSuperHeroe");


--
-- TOC entry 3014 (class 2606 OID 20229)
-- Name: Superheroe superheroe_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."Superheroe"
    ADD CONSTRAINT superheroe_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni) ON UPDATE CASCADE;


--
-- TOC entry 3015 (class 2606 OID 20234)
-- Name: ViveEn vive_en_dni_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."ViveEn"
    ADD CONSTRAINT vive_en_dni_fkey FOREIGN KEY (dni) REFERENCES tp1."Civil"(dni);


--
-- TOC entry 3016 (class 2606 OID 20239)
-- Name: ViveEn vive_en_id_direccion_fkey; Type: FK CONSTRAINT; Schema: tp1; Owner: grupo_01
--

ALTER TABLE ONLY tp1."ViveEn"
    ADD CONSTRAINT vive_en_id_direccion_fkey FOREIGN KEY ("idDireccion") REFERENCES tp1."Direccion"("idDireccion");


-- Completed on 2018-10-17 10:00:08 -03

--
-- PostgreSQL database dump complete
--

