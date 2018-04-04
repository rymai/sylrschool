--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3
-- Dumped by pg_dump version 10.3

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accesses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accesses (
    id integer NOT NULL,
    roles character varying,
    controller character varying,
    action character varying,
    custo character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: accesses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.accesses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.accesses_id_seq OWNED BY public.accesses.id;


--
-- Name: base_classes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.base_classes (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: base_classes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.base_classes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: base_classes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.base_classes_id_seq OWNED BY public.base_classes.id;


--
-- Name: class_schools; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.class_schools (
    id integer NOT NULL,
    name character varying,
    nb_max_student integer,
    default_location_id bigint,
    description text,
    custo character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: class_schools_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.class_schools_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: class_schools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.class_schools_id_seq OWNED BY public.class_schools.id;


--
-- Name: elements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.elements (
    id integer NOT NULL,
    name character varying,
    for_what character varying,
    description text,
    custo character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: elements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.elements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: elements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.elements_id_seq OWNED BY public.elements.id;


--
-- Name: grade_contexts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.grade_contexts (
    id integer NOT NULL,
    name character varying,
    goal character varying,
    min_value character varying,
    max_value character varying,
    description text,
    custo character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: grade_contexts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.grade_contexts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: grade_contexts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.grade_contexts_id_seq OWNED BY public.grade_contexts.id;


--
-- Name: gradecontexts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gradecontexts (
    id integer NOT NULL,
    name character varying,
    goal character varying,
    min_value character varying,
    max_value character varying,
    description text,
    custo character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: gradecontexts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gradecontexts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gradecontexts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.gradecontexts_id_seq OWNED BY public.gradecontexts.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    name character varying,
    usage_id character varying,
    description text,
    custo character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: matter_durations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.matter_durations (
    id integer NOT NULL,
    name character varying,
    level_id integer,
    value integer,
    description text,
    custo character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: matter_durations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.matter_durations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: matter_durations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.matter_durations_id_seq OWNED BY public.matter_durations.id;


--
-- Name: matters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.matters (
    id integer NOT NULL,
    name character varying,
    matter_type_id integer,
    matter_duration_id integer,
    matter_nb_max_student integer,
    description text,
    custo character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: matters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.matters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: matters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.matters_id_seq OWNED BY public.matters.id;


--
-- Name: responsibles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.responsibles (
    id integer NOT NULL,
    name character varying,
    person_status character varying,
    email character varying,
    firstname character varying,
    lastname character varying,
    adress character varying,
    postalcode character varying,
    town character varying,
    phone1 character varying,
    phone2 character varying,
    birthday date,
    description text,
    custo character varying,
    type_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: responsibles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.responsibles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: responsibles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.responsibles_id_seq OWNED BY public.responsibles.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    custo character varying
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schedules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schedules (
    id integer NOT NULL,
    schedule_type character varying,
    start_time timestamp without time zone,
    all_of_day boolean,
    duration integer,
    custo character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.schedules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.schedules_id_seq OWNED BY public.schedules.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.students (
    id integer NOT NULL,
    name character varying,
    person_status character varying,
    email character varying,
    firstname character varying,
    lastname character varying,
    adress character varying,
    postalcode character varying,
    town character varying,
    phone1 character varying,
    phone2 character varying,
    birthday date,
    description text,
    custo character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.students_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;


--
-- Name: teachers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teachers (
    id integer NOT NULL,
    name character varying,
    person_status character varying,
    email character varying,
    firstname character varying,
    lastname character varying,
    adress character varying,
    postalcode character varying,
    town character varying,
    phone1 character varying,
    phone2 character varying,
    birthday date,
    description text,
    custo character varying,
    defmatter_id integer,
    defgradecontext_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.teachers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.teachers_id_seq OWNED BY public.teachers.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: accesses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accesses ALTER COLUMN id SET DEFAULT nextval('public.accesses_id_seq'::regclass);


--
-- Name: base_classes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.base_classes ALTER COLUMN id SET DEFAULT nextval('public.base_classes_id_seq'::regclass);


--
-- Name: class_schools id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.class_schools ALTER COLUMN id SET DEFAULT nextval('public.class_schools_id_seq'::regclass);


--
-- Name: elements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.elements ALTER COLUMN id SET DEFAULT nextval('public.elements_id_seq'::regclass);


--
-- Name: grade_contexts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grade_contexts ALTER COLUMN id SET DEFAULT nextval('public.grade_contexts_id_seq'::regclass);


--
-- Name: gradecontexts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gradecontexts ALTER COLUMN id SET DEFAULT nextval('public.gradecontexts_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: matter_durations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matter_durations ALTER COLUMN id SET DEFAULT nextval('public.matter_durations_id_seq'::regclass);


--
-- Name: matters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matters ALTER COLUMN id SET DEFAULT nextval('public.matters_id_seq'::regclass);


--
-- Name: responsibles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.responsibles ALTER COLUMN id SET DEFAULT nextval('public.responsibles_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: schedules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schedules ALTER COLUMN id SET DEFAULT nextval('public.schedules_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: students id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);


--
-- Name: teachers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teachers ALTER COLUMN id SET DEFAULT nextval('public.teachers_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: accesses accesses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accesses
    ADD CONSTRAINT accesses_pkey PRIMARY KEY (id);


--
-- Name: base_classes base_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.base_classes
    ADD CONSTRAINT base_classes_pkey PRIMARY KEY (id);


--
-- Name: class_schools class_schools_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.class_schools
    ADD CONSTRAINT class_schools_pkey PRIMARY KEY (id);


--
-- Name: elements elements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT elements_pkey PRIMARY KEY (id);


--
-- Name: grade_contexts grade_contexts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grade_contexts
    ADD CONSTRAINT grade_contexts_pkey PRIMARY KEY (id);


--
-- Name: gradecontexts gradecontexts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gradecontexts
    ADD CONSTRAINT gradecontexts_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: matter_durations matter_durations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matter_durations
    ADD CONSTRAINT matter_durations_pkey PRIMARY KEY (id);


--
-- Name: matters matters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matters
    ADD CONSTRAINT matters_pkey PRIMARY KEY (id);


--
-- Name: responsibles responsibles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.responsibles
    ADD CONSTRAINT responsibles_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schedules schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_class_schools_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_class_schools_on_name ON public.class_schools USING btree (name);


--
-- Name: index_elements_on_for_what; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_elements_on_for_what ON public.elements USING btree (for_what);


--
-- Name: index_elements_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_elements_on_name ON public.elements USING btree (name);


--
-- Name: index_grade_contexts_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_grade_contexts_on_name ON public.grade_contexts USING btree (name);


--
-- Name: index_gradecontexts_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_gradecontexts_on_name ON public.gradecontexts USING btree (name);


--
-- Name: index_locations_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_locations_on_name ON public.locations USING btree (name);


--
-- Name: index_matter_durations_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_matter_durations_on_name ON public.matter_durations USING btree (name);


--
-- Name: index_matters_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_matters_on_name ON public.matters USING btree (name);


--
-- Name: index_responsibles_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_responsibles_on_name ON public.responsibles USING btree (name);


--
-- Name: index_schedules_on_start_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_schedules_on_start_time ON public.schedules USING btree (start_time);


--
-- Name: index_students_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_students_on_email ON public.students USING btree (email);


--
-- Name: index_students_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_students_on_name ON public.students USING btree (name);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON public.schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20180228071639');

INSERT INTO schema_migrations (version) VALUES ('20180228090054');

INSERT INTO schema_migrations (version) VALUES ('20180228102442');

INSERT INTO schema_migrations (version) VALUES ('20180228114812');

INSERT INTO schema_migrations (version) VALUES ('20180302074634');

INSERT INTO schema_migrations (version) VALUES ('20180302081317');

INSERT INTO schema_migrations (version) VALUES ('20180302105655');

INSERT INTO schema_migrations (version) VALUES ('20180302170402');

INSERT INTO schema_migrations (version) VALUES ('20180302170417');

INSERT INTO schema_migrations (version) VALUES ('20180302170513');

INSERT INTO schema_migrations (version) VALUES ('20180302172933');

INSERT INTO schema_migrations (version) VALUES ('20180302175056');

INSERT INTO schema_migrations (version) VALUES ('20180302175057');

INSERT INTO schema_migrations (version) VALUES ('20180302175059');

INSERT INTO schema_migrations (version) VALUES ('20180302175606');

INSERT INTO schema_migrations (version) VALUES ('20180302175607');

INSERT INTO schema_migrations (version) VALUES ('20180302175608');

INSERT INTO schema_migrations (version) VALUES ('20180302181436');

INSERT INTO schema_migrations (version) VALUES ('20180302181437');

INSERT INTO schema_migrations (version) VALUES ('20180302181439');

INSERT INTO schema_migrations (version) VALUES ('20180328102419');

INSERT INTO schema_migrations (version) VALUES ('20180328190802');

INSERT INTO schema_migrations (version) VALUES ('20180328214048');

INSERT INTO schema_migrations (version) VALUES ('20180329093501');

INSERT INTO schema_migrations (version) VALUES ('20180329114847');

INSERT INTO schema_migrations (version) VALUES ('20180329161733');

