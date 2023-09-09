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
6	Canada, CA	60.1087	-113.6426
9	Manizales, CO	5.0689	-75.5174
10	Republic of Chile, CL	-30	-71
11	Cali, CO	3.4372	-76.5225
\.


--
-- Data for Name: user_city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_city (id, users_id, my_city_id) FROM stdin;
17	3	11
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, ssesion) FROM stdin;
3	3d709285-d636-5474-acd7-e6b2b9d9631a
\.


--
-- Data for Name: weather_query_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.weather_query_history (id, date_time, users_id, temp, city, description, icon) FROM stdin;
112	2023-09-08T20:51:06.911Z	3	27	Medellín, CO	scattered clouds	03d
113	2023-09-08T20:52:33.849Z	3	28	Pereira, CO	scattered clouds	03d
114	2023-09-08T20:52:46.061Z	3	18	Bogotá, CO	broken clouds	04d
115	2023-09-08T20:54:22.089Z	3	28	Pereira, CO	scattered clouds	03d
116	2023-09-08T20:54:32.176Z	3	32	Cali, CO	scattered clouds	03d
117	2023-09-08T20:59:53.313Z	3	27	Pereira, CO	scattered clouds	03d
118	2023-09-08T21:01:52.204Z	3	21	Pereira, CO	broken clouds	04d
119	2023-09-08T21:02:38.805Z	3	21	Pereira, CO	broken clouds	04d
120	2023-09-08T21:03:07.908Z	3	27	Medellín, CO	scattered clouds	03d
121	2023-09-08T21:04:01.299Z	3	21	Pereira, CO	broken clouds	04d
122	2023-09-08T21:07:05.220Z	3	28	Cali, CO	broken clouds	04d
123	2023-09-08T21:08:09.279Z	3	21	Pereira, CO	broken clouds	04d
124	2023-09-08T21:08:52.659Z	3	27	Medellín, CO	scattered clouds	03d
125	2023-09-08T21:09:19.630Z	3	21	Pereira, CO	broken clouds	04d
126	2023-09-08T21:09:45.905Z	3	21	Pereira, CO	broken clouds	04d
127	2023-09-08T21:11:30.271Z	3	25	Pereira, CO	broken clouds	04d
128	2023-09-08T21:15:38.194Z	3	25	Pereira, CO	broken clouds	04d
129	2023-09-08T21:16:29.841Z	3	31	Miami, US	few clouds	02d
130	2023-09-08T21:17:35.116Z	3	25	Pereira, CO	broken clouds	04d
131	2023-09-08T21:18:02.613Z	3	27	Medellín, CO	scattered clouds	03d
132	2023-09-08T21:18:32.761Z	3	25	Pereira, CO	broken clouds	04d
133	2023-09-08T21:20:09.439Z	3	25	Pereira, CO	broken clouds	04d
\.


--
-- Name: my_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: plataformal
--

SELECT pg_catalog.setval('public.my_city_id_seq', 11, true);


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

SELECT pg_catalog.setval('public.weather_query_history_id_seq', 133, true);


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

