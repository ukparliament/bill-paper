SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: heroku_ext; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA heroku_ext;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: bill_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bill_categories (
    id integer NOT NULL,
    label character varying(255) NOT NULL
);


--
-- Name: bill_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bill_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bill_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bill_categories_id_seq OWNED BY public.bill_categories.id;


--
-- Name: bill_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bill_types (
    id integer NOT NULL,
    label character varying(255) NOT NULL,
    bill_system_id integer NOT NULL,
    description text NOT NULL,
    bill_category_id integer NOT NULL
);


--
-- Name: bill_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bill_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bill_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bill_types_id_seq OWNED BY public.bill_types.id;


--
-- Name: bills; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bills (
    id integer NOT NULL,
    short_title character varying(255) NOT NULL,
    bill_system_id integer NOT NULL,
    is_act boolean DEFAULT false,
    is_withdrawn boolean DEFAULT false,
    is_defeated boolean DEFAULT false,
    originating_house_id integer,
    current_house_id integer,
    originating_session_id integer NOT NULL,
    bill_type_id integer NOT NULL,
    updated timestamp without time zone NOT NULL
);


--
-- Name: bills_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bills_id_seq OWNED BY public.bills.id;


--
-- Name: content_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.content_types (
    id integer NOT NULL,
    content_type character varying(255) NOT NULL
);


--
-- Name: content_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.content_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: content_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.content_types_id_seq OWNED BY public.content_types.id;


--
-- Name: links; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.links (
    id integer NOT NULL,
    title character varying(10000) NOT NULL,
    url character varying(10000) NOT NULL,
    content_length integer,
    source character varying(20) NOT NULL,
    bill_system_id integer NOT NULL,
    publication_id integer NOT NULL,
    content_type_id integer NOT NULL
);


--
-- Name: links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.links_id_seq OWNED BY public.links.id;


--
-- Name: parliamentary_houses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.parliamentary_houses (
    id integer NOT NULL,
    short_label character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


--
-- Name: parliamentary_houses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.parliamentary_houses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: parliamentary_houses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.parliamentary_houses_id_seq OWNED BY public.parliamentary_houses.id;


--
-- Name: publication_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publication_types (
    id integer NOT NULL,
    label character varying(255) NOT NULL,
    bill_system_id integer NOT NULL,
    description text
);


--
-- Name: publication_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.publication_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: publication_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.publication_types_id_seq OWNED BY public.publication_types.id;


--
-- Name: publications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publications (
    id integer NOT NULL,
    title character varying(10000) NOT NULL,
    display_date date NOT NULL,
    bill_system_id integer NOT NULL,
    parliamentary_house_id integer,
    publication_type_id integer NOT NULL,
    bill_id integer NOT NULL
);


--
-- Name: publications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.publications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: publications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.publications_id_seq OWNED BY public.publications.id;


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
    number character varying(255) NOT NULL,
    start_on date NOT NULL,
    end_on date NOT NULL,
    commons_description character varying(255) NOT NULL,
    lords_description character varying(255) NOT NULL,
    parliament_number integer NOT NULL,
    session_number integer NOT NULL,
    bill_system_id integer NOT NULL
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
-- Name: bill_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bill_categories ALTER COLUMN id SET DEFAULT nextval('public.bill_categories_id_seq'::regclass);


--
-- Name: bill_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bill_types ALTER COLUMN id SET DEFAULT nextval('public.bill_types_id_seq'::regclass);


--
-- Name: bills id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bills ALTER COLUMN id SET DEFAULT nextval('public.bills_id_seq'::regclass);


--
-- Name: content_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_types ALTER COLUMN id SET DEFAULT nextval('public.content_types_id_seq'::regclass);


--
-- Name: links id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.links ALTER COLUMN id SET DEFAULT nextval('public.links_id_seq'::regclass);


--
-- Name: parliamentary_houses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parliamentary_houses ALTER COLUMN id SET DEFAULT nextval('public.parliamentary_houses_id_seq'::regclass);


--
-- Name: publication_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publication_types ALTER COLUMN id SET DEFAULT nextval('public.publication_types_id_seq'::regclass);


--
-- Name: publications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publications ALTER COLUMN id SET DEFAULT nextval('public.publications_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: bill_categories bill_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bill_categories
    ADD CONSTRAINT bill_categories_pkey PRIMARY KEY (id);


--
-- Name: bill_types bill_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bill_types
    ADD CONSTRAINT bill_types_pkey PRIMARY KEY (id);


--
-- Name: bills bills_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bills
    ADD CONSTRAINT bills_pkey PRIMARY KEY (id);


--
-- Name: content_types content_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_types
    ADD CONSTRAINT content_types_pkey PRIMARY KEY (id);


--
-- Name: links links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT links_pkey PRIMARY KEY (id);


--
-- Name: parliamentary_houses parliamentary_houses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parliamentary_houses
    ADD CONSTRAINT parliamentary_houses_pkey PRIMARY KEY (id);


--
-- Name: publication_types publication_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publication_types
    ADD CONSTRAINT publication_types_pkey PRIMARY KEY (id);


--
-- Name: publications publications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publications
    ADD CONSTRAINT publications_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: publications fk_bill; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publications
    ADD CONSTRAINT fk_bill FOREIGN KEY (bill_id) REFERENCES public.bills(id);


--
-- Name: bill_types fk_bill_category; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bill_types
    ADD CONSTRAINT fk_bill_category FOREIGN KEY (bill_category_id) REFERENCES public.bill_categories(id);


--
-- Name: bills fk_bill_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bills
    ADD CONSTRAINT fk_bill_type FOREIGN KEY (current_house_id) REFERENCES public.parliamentary_houses(id);


--
-- Name: links fk_content_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT fk_content_type FOREIGN KEY (content_type_id) REFERENCES public.content_types(id);


--
-- Name: bills fk_current_house; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bills
    ADD CONSTRAINT fk_current_house FOREIGN KEY (current_house_id) REFERENCES public.parliamentary_houses(id);


--
-- Name: publications fk_house; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publications
    ADD CONSTRAINT fk_house FOREIGN KEY (parliamentary_house_id) REFERENCES public.parliamentary_houses(id);


--
-- Name: bills fk_originating_house; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bills
    ADD CONSTRAINT fk_originating_house FOREIGN KEY (originating_house_id) REFERENCES public.parliamentary_houses(id);


--
-- Name: bills fk_originating_session; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bills
    ADD CONSTRAINT fk_originating_session FOREIGN KEY (originating_session_id) REFERENCES public.sessions(id);


--
-- Name: links fk_publication; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT fk_publication FOREIGN KEY (publication_id) REFERENCES public.publications(id);


--
-- Name: publications fk_publication_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publications
    ADD CONSTRAINT fk_publication_type FOREIGN KEY (publication_type_id) REFERENCES public.publication_types(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20250227175703');

