--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: game_histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_histories (
    id integer NOT NULL,
    user_id character varying(16) NOT NULL,
    game_name character varying(255) NOT NULL,
    bet_amount double precision NOT NULL,
    result character varying(50) NOT NULL,
    payout double precision,
    played_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.game_histories OWNER TO postgres;

--
-- Name: game_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.game_histories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.game_histories_id_seq OWNER TO postgres;

--
-- Name: game_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.game_histories_id_seq OWNED BY public.game_histories.id;


--
-- Name: games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text
);


ALTER TABLE public.games OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.games_id_seq OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_id_seq OWNED BY public.games.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    user_id character varying(16) NOT NULL,
    amount double precision NOT NULL,
    transaction_type character varying(50) NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    login character varying(16) NOT NULL,
    user_id character varying(16) NOT NULL,
    email character varying(255) NOT NULL,
    hashed_password character varying(255) NOT NULL,
    balance double precision DEFAULT 0.0,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: game_histories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_histories ALTER COLUMN id SET DEFAULT nextval('public.game_histories_id_seq'::regclass);


--
-- Name: games id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games ALTER COLUMN id SET DEFAULT nextval('public.games_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Data for Name: game_histories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_histories (id, user_id, game_name, bet_amount, result, payout, played_at) FROM stdin;
1	phVHgJi3FOKqG1Hx	roulette	10	win	20	2024-12-30 16:15:40.756022
2	7nojVFfw7vbh7hrE	roulette	20	lose	0	2024-12-30 16:32:45.769357
3	7nojVFfw7vbh7hrE	blackjack	5	bust	0	2024-12-30 16:48:49.993368
4	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-04 17:47:54.234727
5	QjRPSfMjX7d0VLhM	roulette	6	lose	0	2025-01-04 17:47:59.744416
6	QjRPSfMjX7d0VLhM	roulette	6	win	12	2025-01-04 17:48:01.055489
7	QjRPSfMjX7d0VLhM	roulette	6	lose	0	2025-01-04 17:48:10.374985
8	QjRPSfMjX7d0VLhM	roulette	1	lose	0	2025-01-04 17:48:13.43237
9	QjRPSfMjX7d0VLhM	roulette	1	lose	0	2025-01-04 17:48:14.688803
10	QjRPSfMjX7d0VLhM	roulette	1	lose	0	2025-01-04 17:48:15.282077
11	QjRPSfMjX7d0VLhM	roulette	1	lose	0	2025-01-04 17:48:15.863144
12	QjRPSfMjX7d0VLhM	roulette	1	lose	0	2025-01-04 17:48:16.359427
13	QjRPSfMjX7d0VLhM	roulette	1	lose	0	2025-01-04 17:48:16.897038
14	QjRPSfMjX7d0VLhM	roulette	1	lose	0	2025-01-04 17:48:17.456128
15	QjRPSfMjX7d0VLhM	roulette	1	lose	0	2025-01-04 17:48:17.949952
16	QjRPSfMjX7d0VLhM	roulette	1	win	36	2025-01-04 17:48:18.46879
17	QjRPSfMjX7d0VLhM	roulette	1	lose	0	2025-01-04 17:48:18.927281
18	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 17:48:24.570623
19	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 17:48:25.786913
20	QjRPSfMjX7d0VLhM	roulette	82	lose	0	2025-01-04 17:49:04.360271
21	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-04 17:50:43.218516
22	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 17:51:23.954838
23	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 17:57:59.599995
24	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 18:00:07.32145
25	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:20:17.835179
26	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-04 20:25:32.442657
27	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-04 20:32:47.060778
28	QjRPSfMjX7d0VLhM	roulette	22	lose	0	2025-01-04 20:33:10.258343
29	QjRPSfMjX7d0VLhM	roulette	22	win	44	2025-01-04 20:33:11.155744
30	QjRPSfMjX7d0VLhM	roulette	50	lose	0	2025-01-04 20:33:14.696932
31	QjRPSfMjX7d0VLhM	roulette	50	lose	0	2025-01-04 20:33:15.780627
32	QjRPSfMjX7d0VLhM	roulette	15	lose	0	2025-01-04 20:33:18.312164
33	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-04 20:33:27.045313
34	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-04 20:33:27.776199
35	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-04 20:33:28.705492
36	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-04 20:33:34.951909
37	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-04 20:33:38.541515
38	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-04 20:40:11.767503
39	QjRPSfMjX7d0VLhM	roulette	3	win	6	2025-01-04 20:41:08.23472
40	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:41:27.013092
41	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-04 20:41:34.962885
42	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:42:38.842694
43	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:42:39.817145
44	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:42:40.51442
45	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:42:41.130053
46	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:42:41.770493
47	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:42:42.772984
48	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:42:43.560827
49	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:42:44.351804
50	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:42:45.010676
51	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:42:46.078906
52	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:42:47.318497
53	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:42:48.852965
54	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:42:51.838965
55	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:42:52.753751
56	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-04 20:43:02.833048
57	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-04 20:43:27.573888
58	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-04 20:43:29.895691
59	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-04 20:43:32.355766
60	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-04 20:43:34.11245
61	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-04 20:43:56.746928
62	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-04 20:43:57.679221
63	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:46:39.259274
64	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:46:41.210473
65	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:46:42.822376
66	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:47:21.78701
67	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:47:26.409252
68	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:47:30.218571
69	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:47:33.348113
70	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:47:37.458156
71	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:47:39.048303
72	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:47:39.952818
73	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:47:41.40424
74	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:47:42.096874
75	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:47:42.799517
76	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:47:43.396313
77	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:47:44.04761
78	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:47:44.980978
79	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:47:45.674432
80	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:47:46.248153
81	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:47:46.928993
82	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:47:48.221448
83	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:47:49.775049
84	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:47:50.910354
85	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:49:33.602985
86	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:49:37.176963
87	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:49:41.034976
88	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:49:46.176957
89	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:55:09.688358
90	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:55:11.624028
91	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:55:13.977543
92	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:55:15.077835
93	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:55:26.768741
94	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:55:28.099649
95	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:55:30.579203
96	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:55:31.58463
97	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:55:32.49501
98	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:55:35.514854
99	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:55:36.156455
100	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:55:36.748998
101	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:55:37.424704
102	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:55:38.585951
103	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:55:39.32672
104	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:57:41.211537
105	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:57:44.15901
106	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:57:44.908954
107	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:57:45.964053
108	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:57:46.868521
109	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:57:48.445698
110	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:57:49.82042
111	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:57:50.74
112	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 20:57:52.170274
113	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 20:59:20.681672
114	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:00:33.698623
115	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:01:23.912917
116	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:04:10.138856
117	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:08:30.317711
118	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:08:31.806336
119	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:11:49.584011
120	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:12:38.473493
121	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:12:39.570366
122	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:14:06.815122
123	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:15:52.359762
124	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:15:53.011709
125	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:15:53.754846
126	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:15:54.434053
127	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:16:31.361283
128	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:16:50.112555
129	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:20:49.586073
130	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:20:55.484929
131	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:21:05.583961
132	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:21:06.815726
133	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:21:43.610449
134	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:22:14.404349
135	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:22:19.59683
136	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:25:01.848277
137	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:25:16.73116
138	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:25:23.911933
139	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:25:29.344306
140	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:25:47.545652
141	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:25:52.8712
142	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:26:00.651113
143	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:26:04.859816
144	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:26:18.617088
145	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:26:23.764023
146	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:27:27.297093
147	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:28:45.514112
148	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:28:49.180213
149	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:28:53.55865
150	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:29:07.920231
151	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:29:18.783706
152	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:29:22.253087
153	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:29:30.503426
154	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:29:36.734293
155	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:29:43.172295
156	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:29:49.527756
157	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:29:57.341917
158	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:30:02.15611
159	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:30:11.165529
160	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:30:15.98614
161	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:30:19.914505
162	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:30:23.738465
163	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:30:27.968
164	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:30:38.959399
165	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:30:57.36457
166	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:31:13.449679
167	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:31:20.658815
168	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:31:35.148025
169	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:31:42.193875
170	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:32:23.603454
171	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:32:25.553271
172	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:32:27.677445
173	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:32:29.76862
174	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:32:32.397148
175	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:32:40.888239
176	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:33:03.90935
177	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:33:15.087199
178	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:34:18.641085
179	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:34:34.738527
180	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:35:06.052068
181	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:35:10.552758
182	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:35:21.971836
183	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:36:45.41243
184	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:38:50.521405
185	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:42:05.698707
186	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:42:09.788994
187	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:42:14.660832
188	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:42:32.04241
189	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:43:02.130088
190	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:43:15.270227
191	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:43:22.011753
192	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:43:22.56921
193	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:43:30.255333
194	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:43:40.465165
195	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:44:19.702805
196	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:44:39.240148
197	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:44:53.411721
198	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:45:26.221547
199	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:45:34.372131
200	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:45:49.987509
201	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:46:37.624374
202	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:47:01.616932
203	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:47:12.2099
204	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:49:16.01481
205	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:49:23.233826
206	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:49:42.201146
207	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:49:47.388198
208	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:49:51.279001
209	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:50:12.135833
210	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:50:12.694062
211	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:50:13.400453
212	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:50:13.948151
213	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:50:18.655902
214	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:50:23.008339
215	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:50:45.583757
216	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:52:05.042915
217	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:52:12.088835
218	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:52:13.423758
219	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:52:14.415625
220	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:52:15.496351
221	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:52:16.179234
222	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-04 21:52:22.598373
223	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-04 21:52:31.902176
224	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-04 21:52:33.272609
225	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-04 21:52:34.07135
226	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-04 21:52:35.805446
227	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-04 21:52:36.919128
228	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-04 21:52:37.511835
229	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-04 21:52:41.186767
230	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:53:54.05471
231	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:53:59.18596
232	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-04 21:54:00.261258
233	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:54:06.256309
234	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:54:19.484675
235	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:54:31.896828
236	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-04 21:55:48.255909
237	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-04 21:56:13.037189
238	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 13:55:17.826282
239	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 13:55:25.514257
240	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 13:55:32.380375
241	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 13:56:03.829201
242	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 13:56:08.49248
243	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 13:57:34.732855
244	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 13:57:39.957641
245	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:00:01.721981
246	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:02:11.167188
247	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:02:17.222427
248	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:02:22.361362
249	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:02:36.862936
250	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:05:29.269777
251	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:06:06.674634
252	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:08:29.920547
253	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:11:50.192281
254	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:11:56.175653
255	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:12:01.048571
256	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:15:16.383186
257	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:15:18.805163
258	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:15:19.446943
259	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:17:12.94224
260	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:17:42.884202
261	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:19:55.46457
262	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:20:33.874092
263	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:23:31.250309
264	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:23:36.519497
265	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:23:46.741102
266	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:25:08.447498
267	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:25:12.901931
268	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:25:29.426262
269	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:25:40.401563
270	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:25:48.576025
271	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:25:54.100639
272	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:26:03.008951
273	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:26:25.029632
274	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:26:43.710921
275	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:28:22.074521
276	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:28:37.395615
277	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:30:35.238915
278	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:30:49.359929
279	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:30:55.18032
280	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:31:03.321708
281	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:31:14.157651
282	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:31:24.412349
283	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:31:32.722726
284	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:32:50.039388
285	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:33:02.868243
286	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:33:10.900013
287	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:35:10.675723
288	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:35:16.366464
289	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:35:21.511602
290	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:36:04.195741
291	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:36:10.627977
292	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:36:22.98188
293	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:36:28.467057
294	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:36:36.195767
295	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:37:37.264922
296	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:37:43.138636
297	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:37:48.198295
298	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:38:17.663739
299	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:38:35.15985
300	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:38:44.255583
301	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:38:55.155066
302	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 14:39:11.864997
303	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:39:18.063524
304	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:39:23.60746
305	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:39:30.424011
306	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:40:30.411298
307	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:40:35.205416
308	QjRPSfMjX7d0VLhM	roulette	20	win	40	2025-01-05 14:40:54.450815
309	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:41:32.440291
310	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:41:37.388776
311	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:41:43.382412
312	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:41:48.823971
313	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:41:58.164217
314	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:43:22.031568
315	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:43:27.078993
316	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:43:33.89327
317	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:43:40.122784
318	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 14:44:01.678564
319	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:44:07.187248
320	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:44:12.072094
321	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 14:44:13.211299
322	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:44:22.122833
323	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:44:28.176345
324	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:44:33.553144
325	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:44:38.702525
326	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:44:40.421413
327	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:44:43.828687
328	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:44:46.279318
329	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:45:10.683892
330	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:45:16.046487
331	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:45:23.869102
332	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:45:28.857806
333	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:45:37.065083
334	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:46:34.715014
335	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:46:40.566484
336	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:46:46.39856
337	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:46:50.955092
338	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:46:57.164211
339	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:47:01.866049
340	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:48:20.48126
341	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:48:26.286634
342	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:49:17.87595
343	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:49:22.944706
344	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:49:30.142468
345	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:49:37.565202
346	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:50:04.218709
347	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:50:10.187218
348	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:50:16.325723
349	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:50:29.24663
350	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:50:34.492838
351	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:51:46.611098
352	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:51:52.548161
353	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:52:01.763798
354	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:52:07.442629
355	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:53:05.137865
356	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:53:08.858808
357	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:53:13.791004
358	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:54:17.038174
359	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:54:18.67343
360	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:54:20.7734
361	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:54:22.791302
362	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:54:31.658294
363	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:54:38.093835
364	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:54:54.8621
365	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:54:59.531905
366	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:57:30.636564
367	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:57:35.50019
368	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:57:40.396422
369	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:57:45.839787
370	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 14:58:02.191725
371	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:58:15.251407
372	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:59:22.040927
373	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 14:59:27.11585
374	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 15:00:00.324966
375	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 15:00:08.938698
376	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 15:00:15.889876
377	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 15:01:27.91456
378	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 15:01:33.702919
379	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 15:01:57.108048
380	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 15:02:07.078243
381	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 15:04:11.949993
382	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 15:04:16.952723
383	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 15:04:22.410639
384	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 15:04:28.532239
385	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 15:05:40.089268
386	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 15:05:46.665901
387	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 15:07:29.53281
388	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 15:08:36.970786
389	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 15:08:49.526032
390	QjRPSfMjX7d0VLhM	roulette	70	lose	0	2025-01-05 15:13:33.57597
391	QjRPSfMjX7d0VLhM	roulette	20	lose	0	2025-01-05 15:17:42.58076
392	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 15:22:41.541244
393	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 15:28:30.053814
394	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 15:28:35.804873
395	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 15:28:41.061114
396	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 15:32:56.726965
397	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 15:33:06.059632
398	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 15:33:32.380089
399	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 15:33:45.983504
400	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 15:36:29.936155
401	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 15:36:35.518663
402	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 15:36:55.058094
403	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 15:37:08.96201
404	QjRPSfMjX7d0VLhM	roulette	5	lose	0	2025-01-05 15:37:45.529334
405	QjRPSfMjX7d0VLhM	roulette	5	win	10	2025-01-05 15:37:54.361998
406	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 16:05:00.154134
407	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 16:05:24.550211
408	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 16:05:32.856003
409	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 16:06:24.081089
410	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 16:07:25.488912
411	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 16:09:15.927635
412	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 16:09:41.204945
413	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 16:09:46.528929
414	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 16:09:51.774812
415	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 16:10:06.825823
416	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 16:10:33.885234
417	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 16:10:39.37356
418	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 16:10:44.491779
419	QjRPSfMjX7d0VLhM	roulette	10	win	20	2025-01-05 16:10:49.582606
420	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 16:11:06.491326
421	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 16:11:12.247274
422	QjRPSfMjX7d0VLhM	roulette	10	lose	0	2025-01-05 16:11:17.050736
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games (id, name, description) FROM stdin;
1	blackjack	A classic card game where players aim to beat the dealer by having a hand total closer to 21 than the dealer.
2	roulette	A popular casino game where players bet on where a ball will land on a spinning wheel, with numbers and colors.
3	slots	A simple game of chance where players spin reels with various symbols and aim to match them to win.
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, user_id, amount, transaction_type, "timestamp") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (login, user_id, email, hashed_password, balance, is_active, created_at) FROM stdin;
gracz1	phVHgJi3FOKqG1Hx	test@example.com	$2b$12$fG8iJaMIJjOU3yDDEvPyluF6NJl8fHxYW8gW0E0Frogl70ihKgAyS	80	t	2024-12-30 14:16:15.419051
dawid	7nojVFfw7vbh7hrE	xyz123@gmail.com	$2b$12$ytYwnQ/LXRqw8Qby2zuba.LqEcdyqY3dl3UOcGJsm8cKVQEA.L1YG	85	t	2024-12-30 16:24:52.135165
michal	QjRPSfMjX7d0VLhM	testemail123@xyz.com	$2b$12$qwEZYYcyOKA82e8F/ggAeOOJtUf6lHpoj69tlJy4hywSa3AXd3EaK	0	t	2025-01-04 15:22:56.760512
\.


--
-- Name: game_histories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_histories_id_seq', 422, true);


--
-- Name: games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.games_id_seq', 3, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 1, false);


--
-- Name: game_histories game_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_histories
    ADD CONSTRAINT game_histories_pkey PRIMARY KEY (id);


--
-- Name: games games_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_name_key UNIQUE (name);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (login);


--
-- Name: users users_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_id_key UNIQUE (user_id);


--
-- Name: game_histories game_histories_game_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_histories
    ADD CONSTRAINT game_histories_game_name_fkey FOREIGN KEY (game_name) REFERENCES public.games(name);


--
-- Name: game_histories game_histories_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_histories
    ADD CONSTRAINT game_histories_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: transactions transactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

