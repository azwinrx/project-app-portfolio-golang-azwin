--
-- PostgreSQL database dump
--

\restrict QhZL2DrGT7Nvacu4hCWAfoeiWrUmS3ahSJEnZngcv3jjrpxuq0aQSU2fzZvIbZE

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-01-06 15:05:53

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
-- TOC entry 243 (class 1255 OID 18863)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 240 (class 1259 OID 19301)
-- Name: blog_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blog_comments (
    id integer NOT NULL,
    blog_post_id integer,
    commenter_name character varying(100) NOT NULL,
    commenter_email character varying(100) NOT NULL,
    commenter_website character varying(255),
    comment_text text NOT NULL,
    is_approved boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.blog_comments OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 19300)
-- Name: blog_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blog_comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.blog_comments_id_seq OWNER TO postgres;

--
-- TOC entry 5195 (class 0 OID 0)
-- Dependencies: 239
-- Name: blog_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blog_comments_id_seq OWNED BY public.blog_comments.id;


--
-- TOC entry 238 (class 1259 OID 19281)
-- Name: blog_posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blog_posts (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    content text NOT NULL,
    excerpt text,
    featured_image character varying(255),
    author_name character varying(100) NOT NULL,
    category character varying(100),
    tags text[],
    is_published boolean DEFAULT false,
    published_at timestamp without time zone,
    view_count integer DEFAULT 0,
    reading_time integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.blog_posts OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 19280)
-- Name: blog_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blog_posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.blog_posts_id_seq OWNER TO postgres;

--
-- TOC entry 5196 (class 0 OID 0)
-- Dependencies: 237
-- Name: blog_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blog_posts_id_seq OWNED BY public.blog_posts.id;


--
-- TOC entry 242 (class 1259 OID 19321)
-- Name: contact_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_messages (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    subject character varying(200),
    message text NOT NULL,
    phone character varying(20),
    is_read boolean DEFAULT false,
    is_replied boolean DEFAULT false,
    ip_address character varying(45),
    user_agent text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.contact_messages OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 19320)
-- Name: contact_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contact_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contact_messages_id_seq OWNER TO postgres;

--
-- TOC entry 5197 (class 0 OID 0)
-- Dependencies: 241
-- Name: contact_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contact_messages_id_seq OWNED BY public.contact_messages.id;


--
-- TOC entry 224 (class 1259 OID 19153)
-- Name: education; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.education (
    id integer NOT NULL,
    profile_id integer,
    institution character varying(200) NOT NULL,
    degree character varying(100) NOT NULL,
    field_of_study character varying(100),
    start_date date NOT NULL,
    end_date date,
    grade character varying(20),
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.education OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 19152)
-- Name: education_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.education_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.education_id_seq OWNER TO postgres;

--
-- TOC entry 5198 (class 0 OID 0)
-- Dependencies: 223
-- Name: education_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.education_id_seq OWNED BY public.education.id;


--
-- TOC entry 226 (class 1259 OID 19173)
-- Name: experiences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.experiences (
    id integer NOT NULL,
    profile_id integer,
    company_name character varying(200) NOT NULL,
    "position" character varying(100) NOT NULL,
    location character varying(150),
    start_date date NOT NULL,
    end_date date,
    is_current boolean DEFAULT false,
    description text,
    responsibilities text[],
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.experiences OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 19172)
-- Name: experiences_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.experiences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.experiences_id_seq OWNER TO postgres;

--
-- TOC entry 5199 (class 0 OID 0)
-- Dependencies: 225
-- Name: experiences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.experiences_id_seq OWNED BY public.experiences.id;


--
-- TOC entry 220 (class 1259 OID 19117)
-- Name: profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profile (
    id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    title character varying(150) NOT NULL,
    bio text NOT NULL,
    profile_image character varying(255),
    email character varying(100) NOT NULL,
    phone character varying(20),
    address text,
    date_of_birth date,
    website character varying(255),
    resume_url character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.profile OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 19116)
-- Name: profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profile_id_seq OWNER TO postgres;

--
-- TOC entry 5200 (class 0 OID 0)
-- Dependencies: 219
-- Name: profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profile_id_seq OWNED BY public.profile.id;


--
-- TOC entry 234 (class 1259 OID 19246)
-- Name: project_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_images (
    id integer NOT NULL,
    project_id integer,
    image_url character varying(255) NOT NULL,
    caption character varying(255),
    display_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.project_images OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 19245)
-- Name: project_images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.project_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_images_id_seq OWNER TO postgres;

--
-- TOC entry 5201 (class 0 OID 0)
-- Dependencies: 233
-- Name: project_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.project_images_id_seq OWNED BY public.project_images.id;


--
-- TOC entry 232 (class 1259 OID 19228)
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text NOT NULL,
    detailed_description text,
    category character varying(100) NOT NULL,
    client_name character varying(150),
    project_url character varying(255),
    github_url character varying(255),
    thumbnail_image character varying(255),
    start_date date,
    end_date date,
    status character varying(50) DEFAULT 'completed'::character varying,
    technologies text[],
    is_featured boolean DEFAULT false,
    view_count integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.projects OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 19227)
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_id_seq OWNER TO postgres;

--
-- TOC entry 5202 (class 0 OID 0)
-- Dependencies: 231
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- TOC entry 230 (class 1259 OID 19212)
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text NOT NULL,
    icon_class character varying(100),
    image_url character varying(255),
    price_range character varying(100),
    is_active boolean DEFAULT true,
    display_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.services OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 19211)
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.services_id_seq OWNER TO postgres;

--
-- TOC entry 5203 (class 0 OID 0)
-- Dependencies: 229
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- TOC entry 228 (class 1259 OID 19194)
-- Name: skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skills (
    id integer NOT NULL,
    profile_id integer,
    skill_name character varying(100) NOT NULL,
    category character varying(50),
    proficiency_level integer,
    years_of_experience integer,
    display_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT skills_proficiency_level_check CHECK (((proficiency_level >= 1) AND (proficiency_level <= 100)))
);


ALTER TABLE public.skills OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 19193)
-- Name: skills_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.skills_id_seq OWNER TO postgres;

--
-- TOC entry 5204 (class 0 OID 0)
-- Dependencies: 227
-- Name: skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.skills_id_seq OWNED BY public.skills.id;


--
-- TOC entry 222 (class 1259 OID 19135)
-- Name: social_media; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.social_media (
    id integer NOT NULL,
    profile_id integer,
    platform character varying(50) NOT NULL,
    url character varying(255) NOT NULL,
    icon_class character varying(100),
    display_order integer DEFAULT 0,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.social_media OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 19134)
-- Name: social_media_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.social_media_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.social_media_id_seq OWNER TO postgres;

--
-- TOC entry 5205 (class 0 OID 0)
-- Dependencies: 221
-- Name: social_media_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.social_media_id_seq OWNED BY public.social_media.id;


--
-- TOC entry 236 (class 1259 OID 19264)
-- Name: testimonials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.testimonials (
    id integer NOT NULL,
    client_name character varying(100) NOT NULL,
    client_position character varying(150),
    client_company character varying(150),
    client_image character varying(255),
    testimonial_text text NOT NULL,
    rating integer,
    is_approved boolean DEFAULT false,
    display_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT testimonials_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.testimonials OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 19263)
-- Name: testimonials_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.testimonials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.testimonials_id_seq OWNER TO postgres;

--
-- TOC entry 5206 (class 0 OID 0)
-- Dependencies: 235
-- Name: testimonials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.testimonials_id_seq OWNED BY public.testimonials.id;


--
-- TOC entry 4954 (class 2604 OID 19304)
-- Name: blog_comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_comments ALTER COLUMN id SET DEFAULT nextval('public.blog_comments_id_seq'::regclass);


--
-- TOC entry 4949 (class 2604 OID 19284)
-- Name: blog_posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_posts ALTER COLUMN id SET DEFAULT nextval('public.blog_posts_id_seq'::regclass);


--
-- TOC entry 4957 (class 2604 OID 19324)
-- Name: contact_messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_messages ALTER COLUMN id SET DEFAULT nextval('public.contact_messages_id_seq'::regclass);


--
-- TOC entry 4919 (class 2604 OID 19156)
-- Name: education id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education ALTER COLUMN id SET DEFAULT nextval('public.education_id_seq'::regclass);


--
-- TOC entry 4922 (class 2604 OID 19176)
-- Name: experiences id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experiences ALTER COLUMN id SET DEFAULT nextval('public.experiences_id_seq'::regclass);


--
-- TOC entry 4912 (class 2604 OID 19120)
-- Name: profile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile ALTER COLUMN id SET DEFAULT nextval('public.profile_id_seq'::regclass);


--
-- TOC entry 4941 (class 2604 OID 19249)
-- Name: project_images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_images ALTER COLUMN id SET DEFAULT nextval('public.project_images_id_seq'::regclass);


--
-- TOC entry 4935 (class 2604 OID 19231)
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- TOC entry 4930 (class 2604 OID 19215)
-- Name: services id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- TOC entry 4926 (class 2604 OID 19197)
-- Name: skills id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills ALTER COLUMN id SET DEFAULT nextval('public.skills_id_seq'::regclass);


--
-- TOC entry 4915 (class 2604 OID 19138)
-- Name: social_media id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_media ALTER COLUMN id SET DEFAULT nextval('public.social_media_id_seq'::regclass);


--
-- TOC entry 4944 (class 2604 OID 19267)
-- Name: testimonials id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testimonials ALTER COLUMN id SET DEFAULT nextval('public.testimonials_id_seq'::regclass);


--
-- TOC entry 5187 (class 0 OID 19301)
-- Dependencies: 240
-- Data for Name: blog_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blog_comments (id, blog_post_id, commenter_name, commenter_email, commenter_website, comment_text, is_approved, created_at) FROM stdin;
1	1	Dev Enthusiast	dev@example.com	\N	Great introduction to Golang! Very helpful for beginners.	t	2025-12-25 21:24:44.072949
2	2	API Developer	api.dev@email.com	\N	Excellent guide on REST APIs. The examples are clear and practical.	t	2025-12-25 21:24:44.072949
3	3	Database Admin	dba@company.com	\N	Good overview of database design principles. Would love to see more examples.	t	2025-12-25 21:24:44.072949
\.


--
-- TOC entry 5185 (class 0 OID 19281)
-- Dependencies: 238
-- Data for Name: blog_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blog_posts (id, title, slug, content, excerpt, featured_image, author_name, category, tags, is_published, published_at, view_count, reading_time, created_at, updated_at) FROM stdin;
1	Getting Started with Golang	getting-started-with-golang	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Full content here...	Learn the basics of Golang programming language	\N	Azwin Developer	Programming	{golang,programming,tutorial}	t	2025-12-25 21:24:44.072949	0	\N	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
2	Building REST APIs with Golang	building-rest-apis-golang	Comprehensive guide to building RESTful APIs using Golang and Gin framework.	Step-by-step tutorial for creating robust REST APIs	\N	Azwin Developer	Web Development	{golang,api,rest}	t	2025-12-25 21:24:44.072949	0	\N	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
3	Database Design Best Practices	database-design-best-practices	Learn about normalization, indexing, and optimization techniques for databases.	Essential principles for effective database design	\N	Azwin Developer	Database	{database,design,postgresql}	t	2025-12-25 21:24:44.072949	0	\N	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
\.


--
-- TOC entry 5189 (class 0 OID 19321)
-- Dependencies: 242
-- Data for Name: contact_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_messages (id, name, email, subject, message, phone, is_read, is_replied, ip_address, user_agent, created_at) FROM stdin;
1	Muhammad Azwin Rifai	azwinrifai321@gmail.com	Test 1	inin test 1		f	f	[::1]:62476	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	2025-12-26 19:43:04.870417
2	Prabowo	Praboworeal@gmail.com	Program Makan Bergizi Gratis	Siapa mw MBG kids???		f	f	[::1]:65532	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	2025-12-26 19:52:47.342151
3	Muhammad Azwin Rifai	azwinrifai321@gmail.com	Test lagi	duh test lagi		f	f	[::1]:61555	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	2025-12-26 20:35:16.112181
4	Lumosihve Academy	lumshive@gmail.com	Test Demo testestest	Test demo testestest		f	f	[::1]:52849	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	2025-12-27 15:05:46.89591
\.


--
-- TOC entry 5171 (class 0 OID 19153)
-- Dependencies: 224
-- Data for Name: education; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.education (id, profile_id, institution, degree, field_of_study, start_date, end_date, grade, description, created_at, updated_at) FROM stdin;
1	1	Monster University	Bachelor of Computer Science	Computer Science	2015-09-01	2019-06-01	GPA 3.75	\N	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
\.


--
-- TOC entry 5173 (class 0 OID 19173)
-- Dependencies: 226
-- Data for Name: experiences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.experiences (id, profile_id, company_name, "position", location, start_date, end_date, is_current, description, responsibilities, created_at, updated_at) FROM stdin;
1	1	Tech Company Indonesia	Senior Backend Developer	Jakarta, Indonesia	2022-01-01	\N	t	Leading backend development team, building scalable microservices architecture using Golang and PostgreSQL.	\N	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
\.


--
-- TOC entry 5167 (class 0 OID 19117)
-- Dependencies: 220
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profile (id, full_name, title, bio, profile_image, email, phone, address, date_of_birth, website, resume_url, created_at, updated_at) FROM stdin;
1	Azwin Developer	Android & Full Stack Developer	Passionate developer with experience in building scalable web and mobile applications. Skilled in Kotlin, JavaScript, Golang, and PostgreSQL.	/public/img/profile.png	azwinrifai321@gmail.com	+62 888-8888-8888	Bekasi, Indonesia	\N	https://azwin.dev	\N	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
\.


--
-- TOC entry 5181 (class 0 OID 19246)
-- Dependencies: 234
-- Data for Name: project_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_images (id, project_id, image_url, caption, display_order, created_at) FROM stdin;
\.


--
-- TOC entry 5179 (class 0 OID 19228)
-- Dependencies: 232
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects (id, title, description, detailed_description, category, client_name, project_url, github_url, thumbnail_image, start_date, end_date, status, technologies, is_featured, view_count, created_at, updated_at) FROM stdin;
1	Productive-Heroes	Todo List and Pomodoro Timer with Gamification	Productive android app that combining an Pomodoro timer and To Do List with gamification things, i made this project to help my self for managing my task and a simple timer to help when i study	Android Development	\N	https://github.com/azwinrx/Productive-Heroes/releases/tag/v1.0	https://github.com/azwinrx/Productive-Heroes	/public/img/portfolio/project1.png	\N	\N	completed	{Kotlin,"Jetpack Compose"}	t	0	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
2	LogicBase	Mini project platform for learning programming concepts	LogicBase is a mini project platform for helping people to understand about basic of programming, learning the concept, and do some quiz	Web Development	\N	https://logicbase-demo.netlify.app/	https://github.com/azwinrx/LogicBase	/public/img/portfolio/project2.png	\N	\N	completed	{JavaScript,Node.js,React,"Tailwind CSS",Supabase}	t	0	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
3	JantungIn	Capstone project for detection risk of heart disease	JantungIn is a web application that can help users to detect the risk of heart disease using machine learning model, this project is my capstone project in CodingCamp 2025 powered by DBS Indonesia and Dicoding	Web Development	\N	https://jantungin.netlify.app/	https://github.com/azwinrx/JantungIn	/public/img/portfolio/project3.png	\N	\N	completed	{JavaScript,Node.js,Vue,Vite,"Tailwind CSS",Hapi.js,TensorFlow.js,PostgreSQL}	t	0	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
4	WinChat	A simple global-chat anonymous application	WinChat is a simple global-chat anonymous application that built with golang and react, this app made to practice real-time application with websocket technology	Web Development	\N	https://winchat.vercel.app/	https://github.com/azwinrx/winchat	/public/img/portfolio/project4.png	\N	\N	completed	{JavaScript,Firebase}	t	0	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
\.


--
-- TOC entry 5177 (class 0 OID 19212)
-- Dependencies: 230
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, title, description, icon_class, image_url, price_range, is_active, display_order, created_at, updated_at) FROM stdin;
1	Web Development	Building responsive and scalable web applications using modern technologies.	fa fa-laptop	\N	\N	t	1	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
2	API Development	Creating RESTful APIs and microservices with Golang.	fa fa-code	\N	\N	t	2	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
3	Database Design	Designing efficient and normalized database schemas.	fa fa-database	\N	\N	t	3	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
4	Consulting	Technical consulting for architecture and best practices.	fa fa-comments	\N	\N	t	4	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
\.


--
-- TOC entry 5175 (class 0 OID 19194)
-- Dependencies: 228
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.skills (id, profile_id, skill_name, category, proficiency_level, years_of_experience, display_order, created_at, updated_at) FROM stdin;
1	1	Kotlin	Programming Language	90	\N	1	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
2	1	JavaScript	Programming Language	85	\N	2	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
3	1	Golang	Programming Language	85	\N	3	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
4	1	PostgreSQL	Database	80	\N	4	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
5	1	React	Framework	85	\N	5	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
6	1	Docker	Tools	75	\N	6	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
7	1	Git	Tools	90	\N	7	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
\.


--
-- TOC entry 5169 (class 0 OID 19135)
-- Dependencies: 222
-- Data for Name: social_media; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.social_media (id, profile_id, platform, url, icon_class, display_order, is_active, created_at) FROM stdin;
1	1	GitHub	https://github.com/azwin	fa fa-github	1	t	2025-12-25 21:24:44.072949
2	1	LinkedIn	https://linkedin.com/in/azwin	fa fa-linkedin	2	t	2025-12-25 21:24:44.072949
3	1	Twitter	https://twitter.com/azwin	fa fa-twitter	3	t	2025-12-25 21:24:44.072949
4	1	Instagram	https://instagram.com/azwin	fa fa-instagram	4	t	2025-12-25 21:24:44.072949
\.


--
-- TOC entry 5183 (class 0 OID 19264)
-- Dependencies: 236
-- Data for Name: testimonials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.testimonials (id, client_name, client_position, client_company, client_image, testimonial_text, rating, is_approved, display_order, created_at, updated_at) FROM stdin;
1	John Doe	CTO	Tech Startup Inc	\N	Excellent work! The project was delivered on time and exceeded our expectations.	5	t	0	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
2	Sarah Johnson	Project Manager	Digital Solutions Ltd	\N	Professional and reliable. Highly recommend for any development project.	5	t	0	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
3	Mike Chen	CEO	Innovate Corp	\N	Great communication and quality code. Will definitely work together again.	4	t	0	2025-12-25 21:24:44.072949	2025-12-25 21:24:44.072949
\.


--
-- TOC entry 5207 (class 0 OID 0)
-- Dependencies: 239
-- Name: blog_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blog_comments_id_seq', 3, true);


--
-- TOC entry 5208 (class 0 OID 0)
-- Dependencies: 237
-- Name: blog_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blog_posts_id_seq', 3, true);


--
-- TOC entry 5209 (class 0 OID 0)
-- Dependencies: 241
-- Name: contact_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_messages_id_seq', 4, true);


--
-- TOC entry 5210 (class 0 OID 0)
-- Dependencies: 223
-- Name: education_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.education_id_seq', 1, true);


--
-- TOC entry 5211 (class 0 OID 0)
-- Dependencies: 225
-- Name: experiences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.experiences_id_seq', 1, true);


--
-- TOC entry 5212 (class 0 OID 0)
-- Dependencies: 219
-- Name: profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profile_id_seq', 1, true);


--
-- TOC entry 5213 (class 0 OID 0)
-- Dependencies: 233
-- Name: project_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.project_images_id_seq', 1, false);


--
-- TOC entry 5214 (class 0 OID 0)
-- Dependencies: 231
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.projects_id_seq', 13, true);


--
-- TOC entry 5215 (class 0 OID 0)
-- Dependencies: 229
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 4, true);


--
-- TOC entry 5216 (class 0 OID 0)
-- Dependencies: 227
-- Name: skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.skills_id_seq', 7, true);


--
-- TOC entry 5217 (class 0 OID 0)
-- Dependencies: 221
-- Name: social_media_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.social_media_id_seq', 4, true);


--
-- TOC entry 5218 (class 0 OID 0)
-- Dependencies: 235
-- Name: testimonials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.testimonials_id_seq', 3, true);


--
-- TOC entry 5000 (class 2606 OID 19314)
-- Name: blog_comments blog_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_comments
    ADD CONSTRAINT blog_comments_pkey PRIMARY KEY (id);


--
-- TOC entry 4993 (class 2606 OID 19297)
-- Name: blog_posts blog_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_pkey PRIMARY KEY (id);


--
-- TOC entry 4995 (class 2606 OID 19299)
-- Name: blog_posts blog_posts_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_slug_key UNIQUE (slug);


--
-- TOC entry 5003 (class 2606 OID 19335)
-- Name: contact_messages contact_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_messages
    ADD CONSTRAINT contact_messages_pkey PRIMARY KEY (id);


--
-- TOC entry 4971 (class 2606 OID 19166)
-- Name: education education_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education
    ADD CONSTRAINT education_pkey PRIMARY KEY (id);


--
-- TOC entry 4974 (class 2606 OID 19187)
-- Name: experiences experiences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experiences
    ADD CONSTRAINT experiences_pkey PRIMARY KEY (id);


--
-- TOC entry 4964 (class 2606 OID 19133)
-- Name: profile profile_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_email_key UNIQUE (email);


--
-- TOC entry 4966 (class 2606 OID 19131)
-- Name: profile profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (id);


--
-- TOC entry 4989 (class 2606 OID 19257)
-- Name: project_images project_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_images
    ADD CONSTRAINT project_images_pkey PRIMARY KEY (id);


--
-- TOC entry 4986 (class 2606 OID 19244)
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- TOC entry 4981 (class 2606 OID 19226)
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- TOC entry 4979 (class 2606 OID 19205)
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);


--
-- TOC entry 4969 (class 2606 OID 19146)
-- Name: social_media social_media_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_media
    ADD CONSTRAINT social_media_pkey PRIMARY KEY (id);


--
-- TOC entry 4991 (class 2606 OID 19279)
-- Name: testimonials testimonials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testimonials
    ADD CONSTRAINT testimonials_pkey PRIMARY KEY (id);


--
-- TOC entry 5001 (class 1259 OID 19349)
-- Name: idx_blog_comments_post_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_blog_comments_post_id ON public.blog_comments USING btree (blog_post_id);


--
-- TOC entry 4996 (class 1259 OID 19341)
-- Name: idx_blog_posts_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_blog_posts_category ON public.blog_posts USING btree (category);


--
-- TOC entry 4997 (class 1259 OID 19340)
-- Name: idx_blog_posts_published; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_blog_posts_published ON public.blog_posts USING btree (is_published);


--
-- TOC entry 4998 (class 1259 OID 19339)
-- Name: idx_blog_posts_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_blog_posts_slug ON public.blog_posts USING btree (slug);


--
-- TOC entry 5004 (class 1259 OID 19342)
-- Name: idx_contact_messages_read; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contact_messages_read ON public.contact_messages USING btree (is_read);


--
-- TOC entry 4972 (class 1259 OID 19345)
-- Name: idx_education_profile_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_education_profile_id ON public.education USING btree (profile_id);


--
-- TOC entry 4975 (class 1259 OID 19346)
-- Name: idx_experiences_profile_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_experiences_profile_id ON public.experiences USING btree (profile_id);


--
-- TOC entry 4987 (class 1259 OID 19348)
-- Name: idx_project_images_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_project_images_project_id ON public.project_images USING btree (project_id);


--
-- TOC entry 4982 (class 1259 OID 19336)
-- Name: idx_projects_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_projects_category ON public.projects USING btree (category);


--
-- TOC entry 4983 (class 1259 OID 19338)
-- Name: idx_projects_featured; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_projects_featured ON public.projects USING btree (is_featured);


--
-- TOC entry 4984 (class 1259 OID 19337)
-- Name: idx_projects_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_projects_status ON public.projects USING btree (status);


--
-- TOC entry 4976 (class 1259 OID 19343)
-- Name: idx_skills_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_skills_category ON public.skills USING btree (category);


--
-- TOC entry 4977 (class 1259 OID 19347)
-- Name: idx_skills_profile_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_skills_profile_id ON public.skills USING btree (profile_id);


--
-- TOC entry 4967 (class 1259 OID 19344)
-- Name: idx_social_media_profile_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_social_media_profile_id ON public.social_media USING btree (profile_id);


--
-- TOC entry 5018 (class 2620 OID 19357)
-- Name: blog_posts update_blog_posts_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_blog_posts_updated_at BEFORE UPDATE ON public.blog_posts FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 5012 (class 2620 OID 19351)
-- Name: education update_education_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_education_updated_at BEFORE UPDATE ON public.education FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 5013 (class 2620 OID 19352)
-- Name: experiences update_experiences_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_experiences_updated_at BEFORE UPDATE ON public.experiences FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 5011 (class 2620 OID 19350)
-- Name: profile update_profile_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_profile_updated_at BEFORE UPDATE ON public.profile FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 5016 (class 2620 OID 19355)
-- Name: projects update_projects_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_projects_updated_at BEFORE UPDATE ON public.projects FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 5015 (class 2620 OID 19354)
-- Name: services update_services_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_services_updated_at BEFORE UPDATE ON public.services FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 5014 (class 2620 OID 19353)
-- Name: skills update_skills_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_skills_updated_at BEFORE UPDATE ON public.skills FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 5017 (class 2620 OID 19356)
-- Name: testimonials update_testimonials_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_testimonials_updated_at BEFORE UPDATE ON public.testimonials FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 5010 (class 2606 OID 19315)
-- Name: blog_comments blog_comments_blog_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_comments
    ADD CONSTRAINT blog_comments_blog_post_id_fkey FOREIGN KEY (blog_post_id) REFERENCES public.blog_posts(id) ON DELETE CASCADE;


--
-- TOC entry 5006 (class 2606 OID 19167)
-- Name: education education_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education
    ADD CONSTRAINT education_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profile(id) ON DELETE CASCADE;


--
-- TOC entry 5007 (class 2606 OID 19188)
-- Name: experiences experiences_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experiences
    ADD CONSTRAINT experiences_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profile(id) ON DELETE CASCADE;


--
-- TOC entry 5009 (class 2606 OID 19258)
-- Name: project_images project_images_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_images
    ADD CONSTRAINT project_images_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- TOC entry 5008 (class 2606 OID 19206)
-- Name: skills skills_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profile(id) ON DELETE CASCADE;


--
-- TOC entry 5005 (class 2606 OID 19147)
-- Name: social_media social_media_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_media
    ADD CONSTRAINT social_media_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profile(id) ON DELETE CASCADE;


-- Completed on 2026-01-06 15:05:54

--
-- PostgreSQL database dump complete
--

\unrestrict QhZL2DrGT7Nvacu4hCWAfoeiWrUmS3ahSJEnZngcv3jjrpxuq0aQSU2fzZvIbZE

