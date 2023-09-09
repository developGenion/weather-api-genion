--
-- PostgreSQL database dump
--

-- Dumped from database version 14.8
-- Dumped by pg_dump version 15.3 (Ubuntu 15.3-1.pgdg20.04+1)

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: my_city_id_seq; Type: SEQUENCE; Schema: public; Owner: plataformal
--

CREATE SEQUENCE public.my_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.my_city_id_seq OWNER TO plataformal;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: my_city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.my_city (
    id bigint DEFAULT nextval('public.my_city_id_seq'::regclass) NOT NULL,
    city character varying,
    lat character varying,
    lon character varying
);


ALTER TABLE public.my_city OWNER TO postgres;

--
-- Name: user_city_id_seq; Type: SEQUENCE; Schema: public; Owner: plataformal
--

CREATE SEQUENCE public.user_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.user_city_id_seq OWNER TO plataformal;

--
-- Name: user_city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_city (
    id bigint DEFAULT nextval('public.user_city_id_seq'::regclass) NOT NULL,
    users_id integer,
    my_city_id integer
);


ALTER TABLE public.user_city OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: plataformal
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO plataformal;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint DEFAULT nextval('public.users_id_seq'::regclass) NOT NULL,
    ssesion character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: weather_query_history_id_seq; Type: SEQUENCE; Schema: public; Owner: plataformal
--

CREATE SEQUENCE public.weather_query_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.weather_query_history_id_seq OWNER TO plataformal;

--
-- Name: weather_query_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.weather_query_history (
    id bigint DEFAULT nextval('public.weather_query_history_id_seq'::regclass) NOT NULL,
    date_time character varying,
    users_id bigint,
    temp character varying,
    city character varying,
    description character varying,
    icon character varying
);


ALTER TABLE public.weather_query_history OWNER TO postgres;

--
-- Data for Name: my_city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.my_city (id, city, lat, lon) FROM stdin;
\.


--
-- Data for Name: user_city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_city (id, users_id, my_city_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, ssesion) FROM stdin;
\.


--
-- Data for Name: weather_query_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.weather_query_history (id, date_time, users_id, temp, city, description, icon) FROM stdin;
\.


--
-- Name: my_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: plataformal
--

SELECT pg_catalog.setval('public.my_city_id_seq', 44, true);


--
-- Name: user_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: plataformal
--

SELECT pg_catalog.setval('public.user_city_id_seq', 17, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: plataformal
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: weather_query_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: plataformal
--

SELECT pg_catalog.setval('public.weather_query_history_id_seq', 202, true);


--
-- Name: my_city my_city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.my_city
    ADD CONSTRAINT my_city_pkey PRIMARY KEY (id);


--
-- Name: user_city user_city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_city
    ADD CONSTRAINT user_city_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: weather_query_history weather_Query_History_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weather_query_history
    ADD CONSTRAINT "weather_Query_History_pkey" PRIMARY KEY (id);


--
-- Name: user_city fk_my_city_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_city
    ADD CONSTRAINT fk_my_city_id FOREIGN KEY (my_city_id) REFERENCES public.my_city(id) NOT VALID;


--
-- Name: weather_query_history fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weather_query_history
    ADD CONSTRAINT fk_users_id FOREIGN KEY (users_id) REFERENCES public.users(id) NOT VALID;


--
-- Name: user_city fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_city
    ADD CONSTRAINT fk_users_id FOREIGN KEY (users_id) REFERENCES public.users(id) NOT VALID;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

