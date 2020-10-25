--
-- PostgreSQL database dump
--

-- Dumped from database version 11.9
-- Dumped by pg_dump version 11.9

-- Started on 2020-10-24 19:59:18

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE transport;
--
-- TOC entry 2946 (class 1262 OID 16393)
-- Name: transport; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE transport WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Spain.1252' LC_CTYPE = 'Spanish_Spain.1252';


ALTER DATABASE transport OWNER TO postgres;

\connect transport

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 24710)
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- TOC entry 2947 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


--
-- TOC entry 267 (class 1255 OID 24811)
-- Name: counter(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.counter() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	rec record;
	counter integer := 0;
BEGIN
	FOR rec IN SELECT * FROM passengers LOOP
		counter := counter +1;
	END LOOP;
	INSERT INTO count_passengers(amount,time)
	VALUES(counter,NOW());
	RETURN NEW;
END
$$;


ALTER FUNCTION public.counter() OWNER TO postgres;

--
-- TOC entry 268 (class 1255 OID 24816)
-- Name: counterp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.counterp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	rec record;
	counter integer := 0;
BEGIN
	FOR rec IN SELECT * FROM passengers LOOP
		counter := counter +1;
	END LOOP;
	INSERT INTO count_passengers(amount,time)
	VALUES(counter,NOW());
	RETURN NEW;
END
$$;


ALTER FUNCTION public.counterp() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 212 (class 1259 OID 16517)
-- Name: count_passengers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.count_passengers (
    "idCount" integer NOT NULL,
    amount integer,
    "time" timestamp without time zone
);


ALTER TABLE public.count_passengers OWNER TO postgres;

--
-- TOC entry 2948 (class 0 OID 0)
-- Dependencies: 212
-- Name: TABLE count_passengers; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.count_passengers IS 'Tabla que almacena el conteo de pasajeros cada vez que se actualiza la tabla pasajeros.';


--
-- TOC entry 211 (class 1259 OID 16515)
-- Name: cont_pasajeros_idCont_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."cont_pasajeros_idCont_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."cont_pasajeros_idCont_seq" OWNER TO postgres;

--
-- TOC entry 2949 (class 0 OID 0)
-- Dependencies: 211
-- Name: cont_pasajeros_idCont_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."cont_pasajeros_idCont_seq" OWNED BY public.count_passengers."idCount";


--
-- TOC entry 202 (class 1259 OID 16434)
-- Name: stations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stations (
    "idStation" integer NOT NULL,
    name character varying,
    adress character varying
);


ALTER TABLE public.stations OWNER TO postgres;

--
-- TOC entry 2950 (class 0 OID 0)
-- Dependencies: 202
-- Name: TABLE stations; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.stations IS 'Esta tabla almacena las estaciones del sistema de transporte.';


--
-- TOC entry 201 (class 1259 OID 16432)
-- Name: estaciones_idEstacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."estaciones_idEstacion_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."estaciones_idEstacion_seq" OWNER TO postgres;

--
-- TOC entry 2951 (class 0 OID 0)
-- Dependencies: 201
-- Name: estaciones_idEstacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."estaciones_idEstacion_seq" OWNED BY public.stations."idStation";


--
-- TOC entry 198 (class 1259 OID 16412)
-- Name: passengers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passengers (
    "idPassenger" integer NOT NULL,
    name character varying,
    "homeAddress" character varying,
    "birthDate" date
);


ALTER TABLE public.passengers OWNER TO postgres;

--
-- TOC entry 2952 (class 0 OID 0)
-- Dependencies: 198
-- Name: TABLE passengers; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.passengers IS 'Esta tabla almacena la información básica de las personas que usan el servicio de transporte.';


--
-- TOC entry 197 (class 1259 OID 16410)
-- Name: pasajeros_idPasajero_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."pasajeros_idPasajero_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pasajeros_idPasajero_seq" OWNER TO postgres;

--
-- TOC entry 2953 (class 0 OID 0)
-- Dependencies: 197
-- Name: pasajeros_idPasajero_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."pasajeros_idPasajero_seq" OWNED BY public.passengers."idPassenger";


--
-- TOC entry 206 (class 1259 OID 16449)
-- Name: routes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.routes (
    "idRoute" integer NOT NULL,
    "idStation" integer NOT NULL,
    "idTrain" integer NOT NULL,
    name character varying
);


ALTER TABLE public.routes OWNER TO postgres;

--
-- TOC entry 2954 (class 0 OID 0)
-- Dependencies: 206
-- Name: TABLE routes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.routes IS 'Esta tabla almacena los trayectos de los trenes entre las estaciones del sistema de transporte.';


--
-- TOC entry 200 (class 1259 OID 16423)
-- Name: trains; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trains (
    "idTrain" integer NOT NULL,
    model character varying,
    capacity integer
);


ALTER TABLE public.trains OWNER TO postgres;

--
-- TOC entry 2955 (class 0 OID 0)
-- Dependencies: 200
-- Name: TABLE trains; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.trains IS 'Esta tabla almacena la información de los modelos de trenes y su capacidad.';


--
-- TOC entry 210 (class 1259 OID 16466)
-- Name: travels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.travels (
    "idTravel" integer NOT NULL,
    "idPassenger" integer NOT NULL,
    "idRoute" integer NOT NULL,
    start time without time zone,
    "end" time without time zone
);


ALTER TABLE public.travels OWNER TO postgres;

--
-- TOC entry 2956 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE travels; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.travels IS 'Esta tabla almacena los viajes de los pasajeros con cada trayecto del sistema de transporte.';


--
-- TOC entry 204 (class 1259 OID 16445)
-- Name: trayectos_idEstacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."trayectos_idEstacion_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."trayectos_idEstacion_seq" OWNER TO postgres;

--
-- TOC entry 2957 (class 0 OID 0)
-- Dependencies: 204
-- Name: trayectos_idEstacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."trayectos_idEstacion_seq" OWNED BY public.routes."idStation";


--
-- TOC entry 203 (class 1259 OID 16443)
-- Name: trayectos_idTrayecto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."trayectos_idTrayecto_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."trayectos_idTrayecto_seq" OWNER TO postgres;

--
-- TOC entry 2958 (class 0 OID 0)
-- Dependencies: 203
-- Name: trayectos_idTrayecto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."trayectos_idTrayecto_seq" OWNED BY public.routes."idRoute";


--
-- TOC entry 205 (class 1259 OID 16447)
-- Name: trayectos_idTren_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."trayectos_idTren_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."trayectos_idTren_seq" OWNER TO postgres;

--
-- TOC entry 2959 (class 0 OID 0)
-- Dependencies: 205
-- Name: trayectos_idTren_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."trayectos_idTren_seq" OWNED BY public.routes."idTrain";


--
-- TOC entry 199 (class 1259 OID 16421)
-- Name: trenes_idTren_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."trenes_idTren_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."trenes_idTren_seq" OWNER TO postgres;

--
-- TOC entry 2960 (class 0 OID 0)
-- Dependencies: 199
-- Name: trenes_idTren_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."trenes_idTren_seq" OWNED BY public.trains."idTrain";


--
-- TOC entry 208 (class 1259 OID 16462)
-- Name: viajes_idPasajero_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."viajes_idPasajero_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."viajes_idPasajero_seq" OWNER TO postgres;

--
-- TOC entry 2961 (class 0 OID 0)
-- Dependencies: 208
-- Name: viajes_idPasajero_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."viajes_idPasajero_seq" OWNED BY public.travels."idPassenger";


--
-- TOC entry 209 (class 1259 OID 16464)
-- Name: viajes_idTrayecto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."viajes_idTrayecto_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."viajes_idTrayecto_seq" OWNER TO postgres;

--
-- TOC entry 2962 (class 0 OID 0)
-- Dependencies: 209
-- Name: viajes_idTrayecto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."viajes_idTrayecto_seq" OWNED BY public.travels."idRoute";


--
-- TOC entry 207 (class 1259 OID 16460)
-- Name: viajes_idViaje_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."viajes_idViaje_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."viajes_idViaje_seq" OWNER TO postgres;

--
-- TOC entry 2963 (class 0 OID 0)
-- Dependencies: 207
-- Name: viajes_idViaje_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."viajes_idViaje_seq" OWNED BY public.travels."idTravel";


--
-- TOC entry 2785 (class 2604 OID 16520)
-- Name: count_passengers idCount; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.count_passengers ALTER COLUMN "idCount" SET DEFAULT nextval('public."cont_pasajeros_idCont_seq"'::regclass);


--
-- TOC entry 2776 (class 2604 OID 16415)
-- Name: passengers idPassenger; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passengers ALTER COLUMN "idPassenger" SET DEFAULT nextval('public."pasajeros_idPasajero_seq"'::regclass);


--
-- TOC entry 2779 (class 2604 OID 16452)
-- Name: routes idRoute; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.routes ALTER COLUMN "idRoute" SET DEFAULT nextval('public."trayectos_idTrayecto_seq"'::regclass);


--
-- TOC entry 2780 (class 2604 OID 16453)
-- Name: routes idStation; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.routes ALTER COLUMN "idStation" SET DEFAULT nextval('public."trayectos_idEstacion_seq"'::regclass);


--
-- TOC entry 2781 (class 2604 OID 16454)
-- Name: routes idTrain; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.routes ALTER COLUMN "idTrain" SET DEFAULT nextval('public."trayectos_idTren_seq"'::regclass);


--
-- TOC entry 2778 (class 2604 OID 16437)
-- Name: stations idStation; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stations ALTER COLUMN "idStation" SET DEFAULT nextval('public."estaciones_idEstacion_seq"'::regclass);


--
-- TOC entry 2777 (class 2604 OID 16426)
-- Name: trains idTrain; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trains ALTER COLUMN "idTrain" SET DEFAULT nextval('public."trenes_idTren_seq"'::regclass);


--
-- TOC entry 2782 (class 2604 OID 16469)
-- Name: travels idTravel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.travels ALTER COLUMN "idTravel" SET DEFAULT nextval('public."viajes_idViaje_seq"'::regclass);


--
-- TOC entry 2783 (class 2604 OID 16470)
-- Name: travels idPassenger; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.travels ALTER COLUMN "idPassenger" SET DEFAULT nextval('public."viajes_idPasajero_seq"'::regclass);


--
-- TOC entry 2784 (class 2604 OID 16471)
-- Name: travels idRoute; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.travels ALTER COLUMN "idRoute" SET DEFAULT nextval('public."viajes_idTrayecto_seq"'::regclass);


--
-- TOC entry 2940 (class 0 OID 16517)
-- Dependencies: 212
-- Data for Name: count_passengers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.count_passengers VALUES (1, 100, '2020-10-02 12:30:34.83637');
INSERT INTO public.count_passengers VALUES (2, 101, '2020-10-02 12:41:51.151576');
INSERT INTO public.count_passengers VALUES (3, 102, '2020-10-02 12:45:46.093256');
INSERT INTO public.count_passengers VALUES (4, 101, '2020-10-02 12:50:48.089113');
INSERT INTO public.count_passengers VALUES (5, 100, '2020-10-02 13:36:27.535248');
INSERT INTO public.count_passengers VALUES (7, 101, '2020-10-24 19:00:23.542489');
INSERT INTO public.count_passengers VALUES (8, 102, '2020-10-24 19:08:30.388639');
INSERT INTO public.count_passengers VALUES (9, 102, '2020-10-24 19:08:30.388639');
INSERT INTO public.count_passengers VALUES (10, 102, '2020-10-24 19:16:21.258991');
INSERT INTO public.count_passengers VALUES (11, 101, '2020-10-24 19:17:52.183216');
INSERT INTO public.count_passengers VALUES (12, 100, '2020-10-24 19:19:31.544678');
INSERT INTO public.count_passengers VALUES (13, 99, '2020-10-24 19:21:23.678318');
INSERT INTO public.count_passengers VALUES (14, 100, '2020-10-24 19:22:46.441421');


--
-- TOC entry 2926 (class 0 OID 16412)
-- Dependencies: 198
-- Data for Name: passengers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.passengers VALUES (1, 'Leone Lambersen', 'Crownhardt', '1997-03-30');
INSERT INTO public.passengers VALUES (2, 'Avrit Foukx', 'Northport', '1990-10-30');
INSERT INTO public.passengers VALUES (3, 'Tabitha Landrick', 'Delladonna', '1972-11-03');
INSERT INTO public.passengers VALUES (4, 'Mureil Petrenko', 'Sommers', '2002-08-27');
INSERT INTO public.passengers VALUES (5, 'Elysha Eddicott', 'Sundown', '1972-04-02');
INSERT INTO public.passengers VALUES (6, 'Myer Ashburne', 'Prentice', '1963-05-12');
INSERT INTO public.passengers VALUES (7, 'Bliss Margery', 'Autumn Leaf', '1973-04-04');
INSERT INTO public.passengers VALUES (8, 'Colver Antonowicz', 'Macpherson', '1998-11-28');
INSERT INTO public.passengers VALUES (9, 'Giles Lauga', 'Crest Line', '1972-07-29');
INSERT INTO public.passengers VALUES (10, 'Celka Ivell', '5th', '2008-11-28');
INSERT INTO public.passengers VALUES (11, 'Langston Hoofe', 'Rigney', '1946-06-26');
INSERT INTO public.passengers VALUES (12, 'Pennie Kester', 'Cambridge', '1976-04-09');
INSERT INTO public.passengers VALUES (13, 'Avigdor Sear', 'Trailsway', '2005-03-03');
INSERT INTO public.passengers VALUES (14, 'Katya Emberson', 'Glendale', '1973-01-03');
INSERT INTO public.passengers VALUES (15, 'Antonio Curwen', 'Hanson', '1947-09-06');
INSERT INTO public.passengers VALUES (16, 'Burlie Thaller', 'Dawn', '1975-03-20');
INSERT INTO public.passengers VALUES (17, 'Kimbell Killough', 'Canary', '1987-02-13');
INSERT INTO public.passengers VALUES (18, 'Case Gosnell', 'Atwood', '1999-05-24');
INSERT INTO public.passengers VALUES (19, 'Michaeline Franzotto', 'Columbus', '1951-11-21');
INSERT INTO public.passengers VALUES (20, 'Sylvia Potell', 'Debra', '1969-04-26');
INSERT INTO public.passengers VALUES (21, 'Gayleen Dayton', 'Sachs', '1957-11-20');
INSERT INTO public.passengers VALUES (22, 'Alexis Cubbon', 'Warner', '1992-03-21');
INSERT INTO public.passengers VALUES (23, 'Hilliard Ruhben', 'Gerald', '1990-11-03');
INSERT INTO public.passengers VALUES (24, 'Benton Coldbath', 'Arrowood', '1965-07-07');
INSERT INTO public.passengers VALUES (25, 'Torrie Twinberrow', 'Lindbergh', '1983-01-24');
INSERT INTO public.passengers VALUES (26, 'Devy Phinn', 'Crest Line', '1989-01-22');
INSERT INTO public.passengers VALUES (27, 'Seana Braferton', 'Ridgeview', '1978-03-17');
INSERT INTO public.passengers VALUES (28, 'Sibeal Esberger', 'Coolidge', '2003-06-16');
INSERT INTO public.passengers VALUES (29, 'Doyle O Mullen', 'Lien', '1984-10-12');
INSERT INTO public.passengers VALUES (30, 'Freedman Paynton', 'Acker', '1978-03-31');
INSERT INTO public.passengers VALUES (31, 'Eward Weigh', 'Daystar', '2011-01-10');
INSERT INTO public.passengers VALUES (32, 'Sybyl Glowacki', 'Anniversary', '1946-09-10');
INSERT INTO public.passengers VALUES (33, 'Silvie Alleway', 'Tony', '1996-01-15');
INSERT INTO public.passengers VALUES (34, 'Gisela O''Connell', 'Debra', '1977-08-16');
INSERT INTO public.passengers VALUES (35, 'Zabrina Morfey', 'Carberry', '1994-05-16');
INSERT INTO public.passengers VALUES (36, 'Cathrine Summerfield', 'Arkansas', '1985-11-10');
INSERT INTO public.passengers VALUES (37, 'Wendy Arnason', 'Logan', '1971-02-22');
INSERT INTO public.passengers VALUES (38, 'Even Geillier', 'Pleasure', '1962-08-04');
INSERT INTO public.passengers VALUES (39, 'Andria Cawtheray', 'Oxford', '1974-04-04');
INSERT INTO public.passengers VALUES (40, 'Sanders Ainsbury', 'Sundown', '1997-09-03');
INSERT INTO public.passengers VALUES (41, 'Cordula Lafontaine', 'Heath', '1997-06-08');
INSERT INTO public.passengers VALUES (42, 'Winifield Hannaby', 'Clemons', '1951-06-15');
INSERT INTO public.passengers VALUES (43, 'Normand Southerill', 'Tennyson', '2001-03-25');
INSERT INTO public.passengers VALUES (44, 'Shirlee Faircley', 'Starling', '1961-07-20');
INSERT INTO public.passengers VALUES (45, 'Loretta Anney', 'Tomscot', '1985-12-30');
INSERT INTO public.passengers VALUES (46, 'Maxy Kennermann', 'Eggendart', '1983-05-29');
INSERT INTO public.passengers VALUES (47, 'Smith Durgan', 'Pennsylvania', '1988-05-21');
INSERT INTO public.passengers VALUES (48, 'Sheelah Barles', 'Sunbrook', '1977-03-19');
INSERT INTO public.passengers VALUES (49, 'Isador Warboy', 'Blaine', '1981-09-09');
INSERT INTO public.passengers VALUES (50, 'Alric Allwell', 'Browning', '1989-10-29');
INSERT INTO public.passengers VALUES (51, 'Valerye Gaucher', 'Monument', '1989-10-05');
INSERT INTO public.passengers VALUES (52, 'Fionnula Pauletti', 'Columbus', '2002-12-24');
INSERT INTO public.passengers VALUES (53, 'Benedicta Cranstone', 'Mayfield', '1946-03-08');
INSERT INTO public.passengers VALUES (54, 'Jacky Robens', 'Roth', '1978-05-06');
INSERT INTO public.passengers VALUES (55, 'Darnell Murra', 'Basil', '2012-05-02');
INSERT INTO public.passengers VALUES (56, 'Teri Morfey', 'Marcy', '1979-04-20');
INSERT INTO public.passengers VALUES (57, 'Candice Bazely', 'Hollow Ridge', '1996-10-29');
INSERT INTO public.passengers VALUES (58, 'Grace Brandino', 'Kenwood', '2019-05-12');
INSERT INTO public.passengers VALUES (59, 'Rhea Leese', '8th', '1997-09-02');
INSERT INTO public.passengers VALUES (60, 'Aleta Beltzner', 'Continental', '2011-01-08');
INSERT INTO public.passengers VALUES (61, 'Sibbie Urlin', 'Charing Cross', '2019-09-08');
INSERT INTO public.passengers VALUES (62, 'Marcie Corey', 'Atwood', '1978-05-20');
INSERT INTO public.passengers VALUES (63, 'Jessee Videan', 'Jackson', '2009-01-07');
INSERT INTO public.passengers VALUES (64, 'Ricard Fumagall', 'Merry', '1950-04-21');
INSERT INTO public.passengers VALUES (65, 'Gram Muzzlewhite', 'Golf', '2003-06-06');
INSERT INTO public.passengers VALUES (66, 'Portie Cayet', 'Stang', '2000-03-05');
INSERT INTO public.passengers VALUES (67, 'Moll Biggam', 'Roth', '1983-12-07');
INSERT INTO public.passengers VALUES (68, 'Irina Wakeley', 'Texas', '2010-10-11');
INSERT INTO public.passengers VALUES (69, 'Nataline Morcom', 'Helena', '1974-09-27');
INSERT INTO public.passengers VALUES (70, 'Russell Vela', 'Dovetail', '1951-04-02');
INSERT INTO public.passengers VALUES (71, 'Alan Santora', 'American Ash', '2013-04-07');
INSERT INTO public.passengers VALUES (72, 'Benn Cutford', 'Havey', '2012-12-25');
INSERT INTO public.passengers VALUES (73, 'Maryjane Guidetti', '3rd', '2019-03-30');
INSERT INTO public.passengers VALUES (74, 'Caitrin Volleth', 'Sunfield', '2011-01-06');
INSERT INTO public.passengers VALUES (75, 'Kristen Bernocchi', 'Texas', '1958-02-26');
INSERT INTO public.passengers VALUES (76, 'Ali Sagg', 'Starling', '1963-02-25');
INSERT INTO public.passengers VALUES (77, 'Lu Piaggia', 'Schurz', '1976-07-22');
INSERT INTO public.passengers VALUES (78, 'Fairlie Heather', 'Crest Line', '1989-08-19');
INSERT INTO public.passengers VALUES (79, 'Ollie Jindra', '7th', '2010-07-29');
INSERT INTO public.passengers VALUES (80, 'Miguelita Hallock', 'American Ash', '1988-03-29');
INSERT INTO public.passengers VALUES (81, 'Rodolfo MacCartan', 'Aberg', '1950-08-21');
INSERT INTO public.passengers VALUES (82, 'Anastasia Middle', 'Sutteridge', '1990-07-07');
INSERT INTO public.passengers VALUES (83, 'Dalt Donati', 'Commercial', '1991-10-01');
INSERT INTO public.passengers VALUES (84, 'Robinette Tamlett', 'Loftsgordon', '1959-07-05');
INSERT INTO public.passengers VALUES (85, 'Zack Dudbridge', 'Gina', '1947-11-06');
INSERT INTO public.passengers VALUES (86, 'Tallulah Stannard', 'Stephen', '2015-06-26');
INSERT INTO public.passengers VALUES (87, 'Lucie Bottomley', 'Cottonwood', '1961-10-12');
INSERT INTO public.passengers VALUES (88, 'Carey Whewill', 'Corry', '1946-10-31');
INSERT INTO public.passengers VALUES (89, 'Teri Leif', 'Brickson Park', '1992-08-22');
INSERT INTO public.passengers VALUES (90, 'Jonas Roney', 'Coolidge', '2013-05-08');
INSERT INTO public.passengers VALUES (91, 'Jarvis Gianettini', 'Moulton', '2007-05-08');
INSERT INTO public.passengers VALUES (92, 'Arabele Gyppes', 'Helena', '1975-06-28');
INSERT INTO public.passengers VALUES (93, 'Valentine Craske', 'Bellgrove', '1984-07-28');
INSERT INTO public.passengers VALUES (94, 'Zaneta Hullbrook', 'Anderson', '1986-02-02');
INSERT INTO public.passengers VALUES (95, 'Hans Pilsbury', 'Sloan', '1999-04-05');
INSERT INTO public.passengers VALUES (96, 'Elsa Pautard', 'Parkside', '1980-11-27');
INSERT INTO public.passengers VALUES (97, 'Cheri Boughtflower', 'Aberg', '1989-12-07');
INSERT INTO public.passengers VALUES (98, 'Keir Georg', 'Chive', '1985-11-30');
INSERT INTO public.passengers VALUES (99, 'Rebecca Caseborne', '8th', '1975-05-02');
INSERT INTO public.passengers VALUES (100, 'Barbara', 'home', '2000-08-30');


--
-- TOC entry 2934 (class 0 OID 16449)
-- Dependencies: 206
-- Data for Name: routes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.routes VALUES (1, 12, 23, 'Bigtax');
INSERT INTO public.routes VALUES (2, 84, 30, 'Bitchip');
INSERT INTO public.routes VALUES (3, 76, 75, 'Domainer');
INSERT INTO public.routes VALUES (4, 63, 51, 'Lotlux');
INSERT INTO public.routes VALUES (5, 40, 91, 'Zamit');
INSERT INTO public.routes VALUES (6, 18, 70, 'Lotlux');
INSERT INTO public.routes VALUES (7, 9, 45, 'Mat Lam Tam');
INSERT INTO public.routes VALUES (8, 43, 83, 'Stringtough');
INSERT INTO public.routes VALUES (9, 48, 14, 'Alphazap');
INSERT INTO public.routes VALUES (10, 54, 51, 'Cardguard');
INSERT INTO public.routes VALUES (11, 74, 15, 'Regrant');
INSERT INTO public.routes VALUES (12, 82, 14, 'Latlux');
INSERT INTO public.routes VALUES (13, 23, 86, 'Pannier');
INSERT INTO public.routes VALUES (14, 23, 26, 'Holdlamis');
INSERT INTO public.routes VALUES (15, 43, 83, 'Bamity');
INSERT INTO public.routes VALUES (16, 30, 50, 'Prodder');
INSERT INTO public.routes VALUES (17, 24, 49, 'Zoolab');
INSERT INTO public.routes VALUES (18, 57, 45, 'Daltfresh');
INSERT INTO public.routes VALUES (19, 75, 60, 'Zaam-Dox');
INSERT INTO public.routes VALUES (20, 51, 25, 'Kanlam');
INSERT INTO public.routes VALUES (21, 23, 31, 'Alpha');
INSERT INTO public.routes VALUES (22, 74, 90, 'Prodder');
INSERT INTO public.routes VALUES (23, 13, 78, 'Sub-Ex');
INSERT INTO public.routes VALUES (24, 4, 50, 'Hatity');
INSERT INTO public.routes VALUES (25, 75, 59, 'Tempsoft');
INSERT INTO public.routes VALUES (26, 96, 21, 'Voltsillam');
INSERT INTO public.routes VALUES (27, 16, 9, 'Y-Solowarm');
INSERT INTO public.routes VALUES (28, 81, 71, 'Sonair');
INSERT INTO public.routes VALUES (29, 93, 7, 'Lotlux');
INSERT INTO public.routes VALUES (30, 14, 27, 'Viva');
INSERT INTO public.routes VALUES (31, 41, 83, 'Namfix');
INSERT INTO public.routes VALUES (32, 76, 14, 'Duobam');
INSERT INTO public.routes VALUES (33, 65, 64, 'Fixflex');
INSERT INTO public.routes VALUES (34, 56, 62, 'Zontrax');
INSERT INTO public.routes VALUES (35, 79, 93, 'Domainer');
INSERT INTO public.routes VALUES (36, 88, 73, 'Sonair');
INSERT INTO public.routes VALUES (37, 81, 47, 'Hatity');
INSERT INTO public.routes VALUES (38, 16, 27, 'Sonsing');
INSERT INTO public.routes VALUES (39, 54, 90, 'Bitchip');
INSERT INTO public.routes VALUES (40, 5, 7, 'Fintone');
INSERT INTO public.routes VALUES (41, 52, 85, 'Zamit');
INSERT INTO public.routes VALUES (42, 88, 16, 'Matsoft');
INSERT INTO public.routes VALUES (43, 72, 68, 'Transcof');
INSERT INTO public.routes VALUES (44, 65, 37, 'Gembucket');
INSERT INTO public.routes VALUES (45, 12, 49, 'Biodex');
INSERT INTO public.routes VALUES (46, 42, 98, 'Sub-Ex');
INSERT INTO public.routes VALUES (47, 33, 6, 'Lotstring');
INSERT INTO public.routes VALUES (48, 89, 64, 'Aerified');
INSERT INTO public.routes VALUES (49, 10, 71, 'Keylex');
INSERT INTO public.routes VALUES (50, 34, 60, 'Zontrax');
INSERT INTO public.routes VALUES (51, 35, 90, 'Duobam');
INSERT INTO public.routes VALUES (52, 27, 97, 'Veribet');
INSERT INTO public.routes VALUES (53, 49, 15, 'Namfix');
INSERT INTO public.routes VALUES (54, 47, 64, 'Subin');
INSERT INTO public.routes VALUES (55, 11, 38, 'Fix San');
INSERT INTO public.routes VALUES (56, 83, 27, 'Mat Lam Tam');
INSERT INTO public.routes VALUES (57, 56, 43, 'Trippledex');
INSERT INTO public.routes VALUES (58, 34, 55, 'Span');
INSERT INTO public.routes VALUES (59, 77, 42, 'Aerified');
INSERT INTO public.routes VALUES (60, 51, 45, 'Namfix');
INSERT INTO public.routes VALUES (61, 80, 5, 'Konklab');
INSERT INTO public.routes VALUES (62, 48, 85, 'Stim');
INSERT INTO public.routes VALUES (63, 61, 92, 'Transcof');
INSERT INTO public.routes VALUES (64, 39, 13, 'Fixflex');
INSERT INTO public.routes VALUES (65, 93, 41, 'Voyatouch');
INSERT INTO public.routes VALUES (66, 41, 94, 'Daltfresh');
INSERT INTO public.routes VALUES (67, 67, 78, 'Overhold');
INSERT INTO public.routes VALUES (68, 100, 24, 'Rank');
INSERT INTO public.routes VALUES (69, 20, 24, 'Stim');
INSERT INTO public.routes VALUES (70, 21, 39, 'Prodder');
INSERT INTO public.routes VALUES (71, 32, 72, 'Quo Lux');
INSERT INTO public.routes VALUES (72, 82, 94, 'Transcof');
INSERT INTO public.routes VALUES (73, 19, 100, 'Flexidy');
INSERT INTO public.routes VALUES (74, 40, 32, 'Matsoft');
INSERT INTO public.routes VALUES (75, 82, 32, 'Regrant');
INSERT INTO public.routes VALUES (76, 17, 29, 'Tampflex');
INSERT INTO public.routes VALUES (77, 55, 45, 'Cardify');
INSERT INTO public.routes VALUES (78, 52, 96, 'Opela');
INSERT INTO public.routes VALUES (79, 49, 91, 'Gembucket');
INSERT INTO public.routes VALUES (80, 26, 1, 'Ronstring');
INSERT INTO public.routes VALUES (81, 68, 36, 'Stringtough');
INSERT INTO public.routes VALUES (82, 60, 89, 'Flowdesk');
INSERT INTO public.routes VALUES (83, 27, 1, 'Job');
INSERT INTO public.routes VALUES (84, 9, 87, 'Aerified');
INSERT INTO public.routes VALUES (85, 76, 81, 'Y-Solowarm');
INSERT INTO public.routes VALUES (86, 40, 82, 'Y-Solowarm');
INSERT INTO public.routes VALUES (87, 9, 92, 'Wrapsafe');
INSERT INTO public.routes VALUES (88, 15, 40, 'Treeflex');
INSERT INTO public.routes VALUES (89, 25, 44, 'Y-find');
INSERT INTO public.routes VALUES (90, 36, 50, 'Toughjoyfax');
INSERT INTO public.routes VALUES (91, 16, 45, 'Konklux');
INSERT INTO public.routes VALUES (92, 67, 41, 'Sonsing');
INSERT INTO public.routes VALUES (93, 79, 92, 'Job');
INSERT INTO public.routes VALUES (94, 48, 90, 'Y-Solowarm');
INSERT INTO public.routes VALUES (95, 17, 59, 'Fixflex');
INSERT INTO public.routes VALUES (96, 67, 82, 'Cardguard');
INSERT INTO public.routes VALUES (97, 59, 27, 'Bamity');
INSERT INTO public.routes VALUES (98, 94, 4, 'Asoka');
INSERT INTO public.routes VALUES (99, 89, 38, 'Matsoft');
INSERT INTO public.routes VALUES (100, 77, 55, 'Regrant');


--
-- TOC entry 2930 (class 0 OID 16434)
-- Dependencies: 202
-- Data for Name: stations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.stations VALUES (1, 'Wyman-Rau', '05824 Nevada Plaza');
INSERT INTO public.stations VALUES (2, 'Wisozk-Bartoletti', '7 Northfield Lane');
INSERT INTO public.stations VALUES (3, 'Hoppe-Williamson', '6929 1st Road');
INSERT INTO public.stations VALUES (4, 'Schiller, O''Hara and Franecki', '00 Quincy Avenue');
INSERT INTO public.stations VALUES (5, 'Hudson, Berge and Fisher', '1 Park Meadow Parkway');
INSERT INTO public.stations VALUES (6, 'Bailey and Sons', '07060 Banding Way');
INSERT INTO public.stations VALUES (7, 'Wolff-Ullrich', '6639 Dorton Crossing');
INSERT INTO public.stations VALUES (8, 'Haag-Reichert', '1189 Sloan Terrace');
INSERT INTO public.stations VALUES (9, 'Little, Cummerata and Hermiston', '5672 Nova Park');
INSERT INTO public.stations VALUES (10, 'Stoltenberg-Parisian', '55 Lakewood Park');
INSERT INTO public.stations VALUES (11, 'Nienow LLC', '52 Park Meadow Pass');
INSERT INTO public.stations VALUES (12, 'Bechtelar Inc', '02 Dapin Trail');
INSERT INTO public.stations VALUES (13, 'Bauch-Rutherford', '10745 Loeprich Avenue');
INSERT INTO public.stations VALUES (14, 'Heaney and Sons', '8 Meadow Ridge Park');
INSERT INTO public.stations VALUES (15, 'Christiansen, Bosco and Nader', '8 Stoughton Avenue');
INSERT INTO public.stations VALUES (16, 'Runolfsson-Koepp', '99242 Doe Crossing Trail');
INSERT INTO public.stations VALUES (17, 'Halvorson, Stiedemann and Windler', '34148 Debra Lane');
INSERT INTO public.stations VALUES (18, 'Doyle, Sanford and Watsica', '2 New Castle Court');
INSERT INTO public.stations VALUES (19, 'Schneider, Bechtelar and Sanford', '81003 La Follette Drive');
INSERT INTO public.stations VALUES (20, 'Littel-Torp', '54773 Browning Circle');
INSERT INTO public.stations VALUES (21, 'Beahan-Cremin', '245 Ridgeway Street');
INSERT INTO public.stations VALUES (22, 'Skiles, Quitzon and Bayer', '748 Rusk Point');
INSERT INTO public.stations VALUES (23, 'Schiller Inc', '943 Elka Trail');
INSERT INTO public.stations VALUES (24, 'Breitenberg Group', '995 Anhalt Court');
INSERT INTO public.stations VALUES (25, 'Ankunding-Mitchell', '353 Thierer Point');
INSERT INTO public.stations VALUES (26, 'Harber Inc', '2096 Caliangt Way');
INSERT INTO public.stations VALUES (27, 'Hirthe, Barton and Shields', '6 Schiller Plaza');
INSERT INTO public.stations VALUES (28, 'Romaguera, Turner and Haag', '08 Stephen Point');
INSERT INTO public.stations VALUES (29, 'Sanford and Sons', '8411 Hoffman Point');
INSERT INTO public.stations VALUES (30, 'Doyle, Bradtke and Pfeffer', '0 Granby Road');
INSERT INTO public.stations VALUES (31, 'Miller-Feil', '57280 Killdeer Terrace');
INSERT INTO public.stations VALUES (32, 'Batz Inc', '8 Comanche Trail');
INSERT INTO public.stations VALUES (33, 'Sporer, Jast and Kerluke', '306 Ronald Regan Junction');
INSERT INTO public.stations VALUES (34, 'Berge, Weissnat and Pagac', '82 Granby Road');
INSERT INTO public.stations VALUES (35, 'Conroy-Leuschke', '1318 Hansons Pass');
INSERT INTO public.stations VALUES (36, 'Champlin, Mohr and Raynor', '0 Bellgrove Place');
INSERT INTO public.stations VALUES (37, 'Heathcote Group', '24 Lakeland Road');
INSERT INTO public.stations VALUES (38, 'Murazik-Dooley', '739 Lawn Avenue');
INSERT INTO public.stations VALUES (39, 'Wilkinson LLC', '4 Summer Ridge Pass');
INSERT INTO public.stations VALUES (40, 'Tremblay-Goodwin', '625 Blue Bill Park Trail');
INSERT INTO public.stations VALUES (41, 'Koepp, Mertz and Lindgren', '0139 Pepper Wood Terrace');
INSERT INTO public.stations VALUES (42, 'Bartell, Robel and Rau', '520 Nobel Hill');
INSERT INTO public.stations VALUES (43, 'Sporer, Daniel and Walter', '663 Union Court');
INSERT INTO public.stations VALUES (44, 'Williamson, Hauck and Monahan', '08986 Gina Court');
INSERT INTO public.stations VALUES (45, 'Gottlieb-Ernser', '82 Division Hill');
INSERT INTO public.stations VALUES (46, 'Hoppe-Steuber', '00370 Melvin Hill');
INSERT INTO public.stations VALUES (47, 'Powlowski, Jerde and Schultz', '41195 Little Fleur Pass');
INSERT INTO public.stations VALUES (48, 'Zulauf, Rogahn and Stiedemann', '54144 Hooker Parkway');
INSERT INTO public.stations VALUES (49, 'Ernser LLC', '2 Miller Point');
INSERT INTO public.stations VALUES (50, 'Paucek Group', '371 Summer Ridge Circle');
INSERT INTO public.stations VALUES (51, 'Lakin and Sons', '36100 Melrose Way');
INSERT INTO public.stations VALUES (52, 'Terry-Erdman', '30 Mallard Pass');
INSERT INTO public.stations VALUES (53, 'McClure Group', '4037 Butternut Point');
INSERT INTO public.stations VALUES (54, 'Olson-Quitzon', '91 Brentwood Circle');
INSERT INTO public.stations VALUES (55, 'Hagenes-Ebert', '01 Prentice Terrace');
INSERT INTO public.stations VALUES (56, 'Wyman-Graham', '43959 International Lane');
INSERT INTO public.stations VALUES (57, 'Cronin-Schroeder', '174 Artisan Parkway');
INSERT INTO public.stations VALUES (58, 'Schumm-Boyle', '14 Bowman Street');
INSERT INTO public.stations VALUES (59, 'Hermann Inc', '65886 Mandrake Pass');
INSERT INTO public.stations VALUES (60, 'Daugherty-Jacobson', '486 Sutherland Alley');
INSERT INTO public.stations VALUES (61, 'Hilll, Abshire and Schmeler', '14065 Prairie Rose Court');
INSERT INTO public.stations VALUES (62, 'Kling, Macejkovic and Quigley', '802 Southridge Center');
INSERT INTO public.stations VALUES (63, 'Mann-Harvey', '911 Oak Alley');
INSERT INTO public.stations VALUES (64, 'Pfannerstill, Price and Frami', '8429 Mcbride Drive');
INSERT INTO public.stations VALUES (65, 'Greenholt, Berge and Champlin', '460 Artisan Hill');
INSERT INTO public.stations VALUES (66, 'Cummings, Frami and Sauer', '8896 4th Pass');
INSERT INTO public.stations VALUES (67, 'O''Conner, Sporer and Romaguera', '2 Vernon Park');
INSERT INTO public.stations VALUES (68, 'Ratke and Sons', '2275 Di Loreto Court');
INSERT INTO public.stations VALUES (69, 'Rogahn, Farrell and Dach', '40409 Miller Road');
INSERT INTO public.stations VALUES (70, 'Larkin, O''Reilly and Watsica', '9351 Doe Crossing Alley');
INSERT INTO public.stations VALUES (71, 'Breitenberg Group', '465 Monica Park');
INSERT INTO public.stations VALUES (72, 'Collins Inc', '630 Harper Hill');
INSERT INTO public.stations VALUES (73, 'Lakin-Yost', '59421 Sauthoff Street');
INSERT INTO public.stations VALUES (74, 'Langworth-Wuckert', '414 Lyons Alley');
INSERT INTO public.stations VALUES (75, 'Douglas, Gislason and Mitchell', '69438 Monterey Trail');
INSERT INTO public.stations VALUES (76, 'Barton-Wehner', '8 Maple Wood Hill');
INSERT INTO public.stations VALUES (77, 'Kuhlman Inc', '501 Steensland Point');
INSERT INTO public.stations VALUES (78, 'Gusikowski Inc', '6803 Novick Parkway');
INSERT INTO public.stations VALUES (79, 'Gorczany Inc', '7 Redwing Court');
INSERT INTO public.stations VALUES (80, 'Douglas-Barton', '87816 Nevada Drive');
INSERT INTO public.stations VALUES (81, 'Daniel, Harris and Erdman', '011 Artisan Lane');
INSERT INTO public.stations VALUES (82, 'Schaden-Koepp', '15153 Darwin Hill');
INSERT INTO public.stations VALUES (83, 'Runte, Dicki and Wiegand', '2982 Onsgard Park');
INSERT INTO public.stations VALUES (84, 'Grant Inc', '28 Mockingbird Street');
INSERT INTO public.stations VALUES (85, 'Kovacek Inc', '136 Center Parkway');
INSERT INTO public.stations VALUES (86, 'Senger Group', '9040 Anzinger Park');
INSERT INTO public.stations VALUES (87, 'Bradtke-Dare', '97356 Nobel Terrace');
INSERT INTO public.stations VALUES (88, 'Toy Group', '79 Eggendart Terrace');
INSERT INTO public.stations VALUES (89, 'Fisher Inc', '51 Portage Hill');
INSERT INTO public.stations VALUES (90, 'Kuhlman-Satterfield', '4817 Bowman Way');
INSERT INTO public.stations VALUES (91, 'Ward, Farrell and Feest', '24 Ryan Junction');
INSERT INTO public.stations VALUES (92, 'Emmerich Group', '43078 Del Mar Point');
INSERT INTO public.stations VALUES (93, 'Anderson-Schuppe', '08686 Susan Alley');
INSERT INTO public.stations VALUES (94, 'Dicki LLC', '6597 Johnson Way');
INSERT INTO public.stations VALUES (95, 'Mueller Inc', '2 Northland Way');
INSERT INTO public.stations VALUES (96, 'Hudson-Armstrong', '8 Westport Parkway');
INSERT INTO public.stations VALUES (97, 'Hagenes and Sons', '11 Pennsylvania Court');
INSERT INTO public.stations VALUES (98, 'Reichel-Larson', '32 Quincy Street');
INSERT INTO public.stations VALUES (99, 'Crona, Kerluke and Reinger', '0027 Gale Hill');
INSERT INTO public.stations VALUES (100, 'Fahey, Huels and Gleason', '9796 Randy Plaza');


--
-- TOC entry 2928 (class 0 OID 16423)
-- Dependencies: 200
-- Data for Name: trains; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.trains VALUES (1, '1 Series', 37);
INSERT INTO public.trains VALUES (2, 'Town Car', 73);
INSERT INTO public.trains VALUES (3, 'Nubira', 78);
INSERT INTO public.trains VALUES (4, 'Taurus', 24);
INSERT INTO public.trains VALUES (5, 'V70', 8);
INSERT INTO public.trains VALUES (6, 'S-Type', 68);
INSERT INTO public.trains VALUES (7, '928', 5);
INSERT INTO public.trains VALUES (8, 'Caravan', 92);
INSERT INTO public.trains VALUES (9, 'Touareg', 39);
INSERT INTO public.trains VALUES (10, 'Skylark', 85);
INSERT INTO public.trains VALUES (11, 'Sportvan G20', 85);
INSERT INTO public.trains VALUES (12, '200', 81);
INSERT INTO public.trains VALUES (13, 'Rendezvous', 65);
INSERT INTO public.trains VALUES (14, 'Bravada', 89);
INSERT INTO public.trains VALUES (15, 'Monte Carlo', 39);
INSERT INTO public.trains VALUES (16, 'Grand Caravan', 71);
INSERT INTO public.trains VALUES (17, 'Sparrow', 44);
INSERT INTO public.trains VALUES (18, '3500', 12);
INSERT INTO public.trains VALUES (19, '57', 60);
INSERT INTO public.trains VALUES (20, 'XLR-V', 77);
INSERT INTO public.trains VALUES (21, 'Sportage', 4);
INSERT INTO public.trains VALUES (22, 'A4', 11);
INSERT INTO public.trains VALUES (23, 'Freestyle', 19);
INSERT INTO public.trains VALUES (24, 'Capri', 21);
INSERT INTO public.trains VALUES (25, 'Matrix', 93);
INSERT INTO public.trains VALUES (26, 'Crossfire', 51);
INSERT INTO public.trains VALUES (27, 'Xterra', 5);
INSERT INTO public.trains VALUES (28, 'Sedona', 65);
INSERT INTO public.trains VALUES (29, 'X5', 24);
INSERT INTO public.trains VALUES (30, 'Nitro', 98);
INSERT INTO public.trains VALUES (31, 'DBS', 33);
INSERT INTO public.trains VALUES (32, 'QX', 44);
INSERT INTO public.trains VALUES (33, 'i-Series', 83);
INSERT INTO public.trains VALUES (34, 'Cayenne', 29);
INSERT INTO public.trains VALUES (35, 'Coachbuilder', 42);
INSERT INTO public.trains VALUES (36, '190E', 94);
INSERT INTO public.trains VALUES (37, 'Leaf', 60);
INSERT INTO public.trains VALUES (38, 'Fit', 21);
INSERT INTO public.trains VALUES (39, 'MX-6', 40);
INSERT INTO public.trains VALUES (40, 'Land Cruiser', 42);
INSERT INTO public.trains VALUES (41, 'Montero', 31);
INSERT INTO public.trains VALUES (42, 'Roadmaster', 50);
INSERT INTO public.trains VALUES (43, 'Taurus', 82);
INSERT INTO public.trains VALUES (44, 'Highlander', 68);
INSERT INTO public.trains VALUES (45, 'Equator', 72);
INSERT INTO public.trains VALUES (46, 'Outback', 32);
INSERT INTO public.trains VALUES (47, 'TL', 87);
INSERT INTO public.trains VALUES (48, 'Esteem', 16);
INSERT INTO public.trains VALUES (49, 'Mirage', 67);
INSERT INTO public.trains VALUES (50, 'Century', 33);
INSERT INTO public.trains VALUES (51, 'Camaro', 53);
INSERT INTO public.trains VALUES (52, 'Prelude', 93);
INSERT INTO public.trains VALUES (53, 'Pajero', 59);
INSERT INTO public.trains VALUES (54, 'Pathfinder', 40);
INSERT INTO public.trains VALUES (55, 'LTD Crown Victoria', 15);
INSERT INTO public.trains VALUES (56, 'Altima', 3);
INSERT INTO public.trains VALUES (57, 'Rendezvous', 54);
INSERT INTO public.trains VALUES (58, '6000', 91);
INSERT INTO public.trains VALUES (59, 'S90', 39);
INSERT INTO public.trains VALUES (60, 'Mark VIII', 100);
INSERT INTO public.trains VALUES (61, 'Econoline E350', 31);
INSERT INTO public.trains VALUES (62, 'Jetta', 95);
INSERT INTO public.trains VALUES (63, 'Grand Am', 38);
INSERT INTO public.trains VALUES (64, 'G', 43);
INSERT INTO public.trains VALUES (65, 'i-370', 45);
INSERT INTO public.trains VALUES (66, '929', 10);
INSERT INTO public.trains VALUES (67, 'New Beetle', 9);
INSERT INTO public.trains VALUES (68, 'Grand Am', 47);
INSERT INTO public.trains VALUES (69, 'Range Rover Sport', 25);
INSERT INTO public.trains VALUES (70, '7 Series', 41);
INSERT INTO public.trains VALUES (71, 'Mazda6', 69);
INSERT INTO public.trains VALUES (72, 'VehiCROSS', 5);
INSERT INTO public.trains VALUES (73, 'GTI', 97);
INSERT INTO public.trains VALUES (74, 'Intrepid', 48);
INSERT INTO public.trains VALUES (75, 'Ram Wagon B350', 76);
INSERT INTO public.trains VALUES (76, 'LS', 5);
INSERT INTO public.trains VALUES (77, 'H2', 45);
INSERT INTO public.trains VALUES (78, 'Accord', 28);
INSERT INTO public.trains VALUES (79, 'GS', 18);
INSERT INTO public.trains VALUES (80, '599 GTB Fiorano', 59);
INSERT INTO public.trains VALUES (81, 'Elantra', 85);
INSERT INTO public.trains VALUES (82, 'Freelander', 13);
INSERT INTO public.trains VALUES (83, 'MR2', 48);
INSERT INTO public.trains VALUES (84, 'Sequoia', 35);
INSERT INTO public.trains VALUES (85, 'B-Series', 98);
INSERT INTO public.trains VALUES (86, 'MDX', 41);
INSERT INTO public.trains VALUES (87, 'S80', 64);
INSERT INTO public.trains VALUES (88, 'Blazer', 45);
INSERT INTO public.trains VALUES (89, 'TSX', 45);
INSERT INTO public.trains VALUES (90, 'Cayman', 43);
INSERT INTO public.trains VALUES (91, '3500', 53);
INSERT INTO public.trains VALUES (92, 'Cooper', 60);
INSERT INTO public.trains VALUES (93, 'SL-Class', 15);
INSERT INTO public.trains VALUES (94, 'Canyon', 88);
INSERT INTO public.trains VALUES (95, 'Tracker', 72);
INSERT INTO public.trains VALUES (96, 'LS', 63);
INSERT INTO public.trains VALUES (97, 'Continental', 34);
INSERT INTO public.trains VALUES (98, 'Sebring', 65);
INSERT INTO public.trains VALUES (99, '430 Scuderia', 91);
INSERT INTO public.trains VALUES (100, 'Prizm', 94);


--
-- TOC entry 2938 (class 0 OID 16466)
-- Dependencies: 210
-- Data for Name: travels; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.travels VALUES (1, 95, 37, '14:19:48', '22:28:24');
INSERT INTO public.travels VALUES (2, 46, 51, '01:33:31', '12:21:10');
INSERT INTO public.travels VALUES (3, 67, 74, '08:12:24', '18:37:06');
INSERT INTO public.travels VALUES (4, 93, 99, '01:34:30', '18:07:15');
INSERT INTO public.travels VALUES (5, 84, 62, '01:58:04', '06:18:47');
INSERT INTO public.travels VALUES (6, 72, 31, '00:33:37', '04:50:44');
INSERT INTO public.travels VALUES (7, 78, 4, '20:14:29', '04:12:58');
INSERT INTO public.travels VALUES (8, 90, 91, '16:10:16', '18:14:47');
INSERT INTO public.travels VALUES (9, 7, 53, '17:05:16', '04:50:52');
INSERT INTO public.travels VALUES (10, 48, 2, '16:04:13', '08:00:12');
INSERT INTO public.travels VALUES (11, 3, 48, '15:43:24', '14:33:14');
INSERT INTO public.travels VALUES (12, 92, 17, '00:03:10', '03:32:44');
INSERT INTO public.travels VALUES (13, 41, 67, '18:54:48', '12:01:19');
INSERT INTO public.travels VALUES (14, 91, 27, '18:03:54', '23:45:25');
INSERT INTO public.travels VALUES (15, 22, 28, '14:39:57', '08:53:04');
INSERT INTO public.travels VALUES (16, 62, 2, '03:09:58', '21:48:03');
INSERT INTO public.travels VALUES (17, 60, 76, '20:49:49', '03:43:04');
INSERT INTO public.travels VALUES (18, 29, 86, '22:35:15', '01:27:30');
INSERT INTO public.travels VALUES (19, 88, 50, '10:58:08', '19:46:28');
INSERT INTO public.travels VALUES (20, 42, 40, '20:57:35', '18:08:38');
INSERT INTO public.travels VALUES (21, 93, 86, '16:38:53', '09:47:42');
INSERT INTO public.travels VALUES (22, 18, 2, '20:45:56', '20:02:34');
INSERT INTO public.travels VALUES (23, 52, 1, '01:02:31', '14:01:03');
INSERT INTO public.travels VALUES (24, 74, 4, '09:52:10', '10:38:58');
INSERT INTO public.travels VALUES (25, 78, 2, '03:43:31', '04:21:12');
INSERT INTO public.travels VALUES (26, 31, 16, '13:08:51', '08:11:38');
INSERT INTO public.travels VALUES (27, 49, 71, '10:46:10', '17:50:49');
INSERT INTO public.travels VALUES (28, 36, 37, '01:27:33', '11:48:10');
INSERT INTO public.travels VALUES (29, 42, 60, '09:07:51', '23:41:32');
INSERT INTO public.travels VALUES (30, 94, 47, '00:46:22', '00:43:28');
INSERT INTO public.travels VALUES (31, 91, 13, '18:27:37', '07:39:39');
INSERT INTO public.travels VALUES (32, 35, 22, '19:37:09', '17:25:47');
INSERT INTO public.travels VALUES (33, 93, 12, '22:18:40', '16:56:10');
INSERT INTO public.travels VALUES (34, 63, 83, '00:02:22', '03:13:34');
INSERT INTO public.travels VALUES (35, 41, 8, '04:15:05', '00:46:33');
INSERT INTO public.travels VALUES (36, 75, 91, '05:36:13', '19:30:27');
INSERT INTO public.travels VALUES (37, 49, 35, '09:23:31', '05:08:34');
INSERT INTO public.travels VALUES (38, 28, 53, '01:47:48', '01:25:20');
INSERT INTO public.travels VALUES (39, 81, 48, '18:31:33', '22:42:02');
INSERT INTO public.travels VALUES (40, 39, 66, '07:07:07', '21:00:42');
INSERT INTO public.travels VALUES (41, 92, 24, '09:10:46', '01:20:05');
INSERT INTO public.travels VALUES (42, 12, 29, '02:30:11', '21:20:56');
INSERT INTO public.travels VALUES (43, 69, 26, '22:29:04', '20:38:29');
INSERT INTO public.travels VALUES (44, 5, 35, '19:54:50', '15:21:07');
INSERT INTO public.travels VALUES (45, 60, 63, '09:03:04', '03:00:18');
INSERT INTO public.travels VALUES (46, 32, 11, '10:39:29', '09:02:01');
INSERT INTO public.travels VALUES (47, 82, 19, '20:57:29', '17:14:21');
INSERT INTO public.travels VALUES (48, 88, 18, '18:55:57', '09:51:50');
INSERT INTO public.travels VALUES (49, 23, 85, '00:24:51', '22:19:11');
INSERT INTO public.travels VALUES (50, 1, 48, '13:25:15', '22:55:54');
INSERT INTO public.travels VALUES (51, 72, 56, '07:45:16', '03:28:18');
INSERT INTO public.travels VALUES (52, 89, 17, '09:11:45', '23:47:24');
INSERT INTO public.travels VALUES (53, 61, 52, '05:43:52', '19:28:45');
INSERT INTO public.travels VALUES (54, 7, 82, '14:19:15', '11:46:21');
INSERT INTO public.travels VALUES (55, 52, 51, '15:51:18', '06:01:56');
INSERT INTO public.travels VALUES (56, 97, 53, '00:21:11', '23:53:06');
INSERT INTO public.travels VALUES (57, 1, 77, '15:27:20', '00:53:53');
INSERT INTO public.travels VALUES (58, 28, 81, '15:40:52', '17:51:34');
INSERT INTO public.travels VALUES (59, 94, 77, '12:18:39', '14:20:35');
INSERT INTO public.travels VALUES (60, 76, 24, '20:45:12', '06:22:23');
INSERT INTO public.travels VALUES (61, 79, 97, '21:44:53', '07:49:11');
INSERT INTO public.travels VALUES (62, 50, 67, '12:12:03', '08:09:27');
INSERT INTO public.travels VALUES (63, 84, 41, '17:14:53', '12:30:16');
INSERT INTO public.travels VALUES (64, 72, 63, '23:45:34', '04:39:11');
INSERT INTO public.travels VALUES (65, 28, 81, '22:50:52', '04:56:29');
INSERT INTO public.travels VALUES (66, 52, 8, '20:00:31', '07:12:30');
INSERT INTO public.travels VALUES (67, 65, 66, '14:04:03', '20:23:47');
INSERT INTO public.travels VALUES (68, 5, 14, '19:23:37', '19:02:03');
INSERT INTO public.travels VALUES (69, 78, 2, '01:51:52', '00:05:54');
INSERT INTO public.travels VALUES (70, 90, 52, '01:10:38', '21:08:07');
INSERT INTO public.travels VALUES (71, 6, 65, '14:19:50', '22:44:37');
INSERT INTO public.travels VALUES (72, 16, 28, '04:38:28', '07:42:13');
INSERT INTO public.travels VALUES (73, 1, 28, '04:02:53', '07:01:19');
INSERT INTO public.travels VALUES (74, 27, 63, '06:46:37', '09:58:58');
INSERT INTO public.travels VALUES (75, 96, 39, '00:03:48', '21:44:17');
INSERT INTO public.travels VALUES (76, 98, 49, '04:01:01', '01:01:24');
INSERT INTO public.travels VALUES (77, 74, 58, '22:56:33', '08:57:15');
INSERT INTO public.travels VALUES (78, 61, 99, '00:41:09', '17:55:40');
INSERT INTO public.travels VALUES (79, 44, 82, '20:02:15', '09:57:45');
INSERT INTO public.travels VALUES (80, 91, 5, '19:51:19', '14:57:00');
INSERT INTO public.travels VALUES (81, 4, 67, '10:31:42', '22:21:03');
INSERT INTO public.travels VALUES (82, 97, 27, '00:33:48', '14:41:22');
INSERT INTO public.travels VALUES (83, 61, 66, '22:50:56', '03:00:06');
INSERT INTO public.travels VALUES (84, 94, 79, '11:38:35', '23:50:19');
INSERT INTO public.travels VALUES (85, 36, 49, '20:08:03', '15:13:25');
INSERT INTO public.travels VALUES (86, 29, 85, '12:43:03', '17:51:23');
INSERT INTO public.travels VALUES (87, 44, 74, '05:47:25', '15:58:15');
INSERT INTO public.travels VALUES (88, 19, 1, '12:41:39', '07:56:10');
INSERT INTO public.travels VALUES (89, 98, 59, '07:58:08', '10:47:37');
INSERT INTO public.travels VALUES (90, 76, 60, '22:17:12', '13:01:17');
INSERT INTO public.travels VALUES (91, 65, 25, '06:49:30', '12:54:25');
INSERT INTO public.travels VALUES (92, 39, 30, '12:50:39', '18:04:20');
INSERT INTO public.travels VALUES (93, 6, 82, '09:35:24', '09:28:26');
INSERT INTO public.travels VALUES (94, 88, 53, '11:59:15', '10:47:37');
INSERT INTO public.travels VALUES (95, 37, 39, '10:56:45', '00:25:11');
INSERT INTO public.travels VALUES (96, 36, 6, '05:58:06', '16:38:11');
INSERT INTO public.travels VALUES (97, 23, 65, '14:37:42', '16:29:46');
INSERT INTO public.travels VALUES (98, 45, 78, '06:49:20', '22:08:33');
INSERT INTO public.travels VALUES (99, 88, 37, '00:16:02', '06:50:35');
INSERT INTO public.travels VALUES (100, 20, 19, '02:27:31', '12:39:33');


--
-- TOC entry 2964 (class 0 OID 0)
-- Dependencies: 211
-- Name: cont_pasajeros_idCont_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."cont_pasajeros_idCont_seq"', 14, true);


--
-- TOC entry 2965 (class 0 OID 0)
-- Dependencies: 201
-- Name: estaciones_idEstacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."estaciones_idEstacion_seq"', 100, true);


--
-- TOC entry 2966 (class 0 OID 0)
-- Dependencies: 197
-- Name: pasajeros_idPasajero_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."pasajeros_idPasajero_seq"', 106, true);


--
-- TOC entry 2967 (class 0 OID 0)
-- Dependencies: 204
-- Name: trayectos_idEstacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."trayectos_idEstacion_seq"', 1, false);


--
-- TOC entry 2968 (class 0 OID 0)
-- Dependencies: 203
-- Name: trayectos_idTrayecto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."trayectos_idTrayecto_seq"', 100, true);


--
-- TOC entry 2969 (class 0 OID 0)
-- Dependencies: 205
-- Name: trayectos_idTren_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."trayectos_idTren_seq"', 1, false);


--
-- TOC entry 2970 (class 0 OID 0)
-- Dependencies: 199
-- Name: trenes_idTren_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."trenes_idTren_seq"', 101, true);


--
-- TOC entry 2971 (class 0 OID 0)
-- Dependencies: 208
-- Name: viajes_idPasajero_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."viajes_idPasajero_seq"', 1, false);


--
-- TOC entry 2972 (class 0 OID 0)
-- Dependencies: 209
-- Name: viajes_idTrayecto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."viajes_idTrayecto_seq"', 1, false);


--
-- TOC entry 2973 (class 0 OID 0)
-- Dependencies: 207
-- Name: viajes_idViaje_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."viajes_idViaje_seq"', 100, true);


--
-- TOC entry 2797 (class 2606 OID 16522)
-- Name: count_passengers cont_pasajeros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.count_passengers
    ADD CONSTRAINT cont_pasajeros_pkey PRIMARY KEY ("idCount");


--
-- TOC entry 2791 (class 2606 OID 16442)
-- Name: stations estaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stations
    ADD CONSTRAINT estaciones_pkey PRIMARY KEY ("idStation");


--
-- TOC entry 2787 (class 2606 OID 16420)
-- Name: passengers pasajeros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passengers
    ADD CONSTRAINT pasajeros_pkey PRIMARY KEY ("idPassenger");


--
-- TOC entry 2793 (class 2606 OID 16459)
-- Name: routes trayectos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT trayectos_pkey PRIMARY KEY ("idRoute");


--
-- TOC entry 2789 (class 2606 OID 16431)
-- Name: trains trenes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trains
    ADD CONSTRAINT trenes_pkey PRIMARY KEY ("idTrain");


--
-- TOC entry 2795 (class 2606 OID 16473)
-- Name: travels viajes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.travels
    ADD CONSTRAINT viajes_pkey PRIMARY KEY ("idTravel");


--
-- TOC entry 2802 (class 2620 OID 24817)
-- Name: passengers count_delete; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER count_delete AFTER DELETE ON public.passengers FOR EACH STATEMENT EXECUTE PROCEDURE public.counterp();


--
-- TOC entry 2803 (class 2620 OID 24812)
-- Name: passengers count_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER count_update AFTER INSERT ON public.passengers FOR EACH ROW EXECUTE PROCEDURE public.counter();


--
-- TOC entry 2798 (class 2606 OID 16474)
-- Name: routes trayectos_estaciones_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT trayectos_estaciones_fk FOREIGN KEY ("idStation") REFERENCES public.stations("idStation") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 2799 (class 2606 OID 16479)
-- Name: routes trayectos_trenes_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT trayectos_trenes_fk FOREIGN KEY ("idTrain") REFERENCES public.trains("idTrain") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 2800 (class 2606 OID 16484)
-- Name: travels viajes_pasajeros_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.travels
    ADD CONSTRAINT viajes_pasajeros_fk FOREIGN KEY ("idPassenger") REFERENCES public.passengers("idPassenger") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 2801 (class 2606 OID 16489)
-- Name: travels viajes_trayectos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.travels
    ADD CONSTRAINT viajes_trayectos_fk FOREIGN KEY ("idRoute") REFERENCES public.routes("idRoute") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


-- Completed on 2020-10-24 19:59:19

--
-- PostgreSQL database dump complete
--

