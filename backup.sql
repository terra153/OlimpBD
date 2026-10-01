--
-- PostgreSQL database dump
--

\restrict 8RekpAwBylto0iSruLibTo4IRztpRq8A4jBfc0kTUWNygRw9Ix8dIs4UnzjhrId

-- Dumped from database version 17.7
-- Dumped by pg_dump version 17.7

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
-- Name: create_player(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_player() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO "Player" (user_id, privilege_id, player_status_id, experience, rating)
VALUES (NEW.id, 1, 1, 0, 0);
RETURN NEW;
END;
$$;


ALTER FUNCTION public.create_player() OWNER TO postgres;

--
-- Name: get_player_collection_count(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_player_collection_count(user_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
BEGIN
RETURN (SELECT COUNT(*) FROM "PlayerCollection" WHERE player_id = $1);
END;
$_$;


ALTER FUNCTION public.get_player_collection_count(user_id integer) OWNER TO postgres;

--
-- Name: update_club_users_count(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_club_users_count() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE "Club"
	SET users_count = (
			SELECT COUNT(*) FROM "UserClub" WHERE club_id = NEW.club_id)
	WHERE id = NEW.club_id;
	
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_club_users_count() OWNER TO postgres;

--
-- Name: update_last_activity(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_last_activity() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE "Player" SET last_activity = Now() WHERE id = NEW.id;
RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_last_activity() OWNER TO postgres;

--
-- Name: update_player_rating_log(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_player_rating_log() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO "PlayerRatingLog" (player_id, rating, date) VALUES (OLD.id, OLD.rating, NOW());
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_player_rating_log() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Admin" (
    id integer NOT NULL,
    user_id integer
);


ALTER TABLE public."Admin" OWNER TO postgres;

--
-- Name: Admin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Admin_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Admin_id_seq" OWNER TO postgres;

--
-- Name: Admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Admin_id_seq" OWNED BY public."Admin".id;


--
-- Name: Basket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Basket" (
    id integer NOT NULL,
    user_id integer,
    service_id integer
);


ALTER TABLE public."Basket" OWNER TO postgres;

--
-- Name: Basket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Basket_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Basket_id_seq" OWNER TO postgres;

--
-- Name: Basket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Basket_id_seq" OWNED BY public."Basket".id;


--
-- Name: Club; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Club" (
    id integer NOT NULL,
    name character varying(100),
    users_count integer DEFAULT 0
);


ALTER TABLE public."Club" OWNER TO postgres;

--
-- Name: Club_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Club_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Club_id_seq" OWNER TO postgres;

--
-- Name: Club_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Club_id_seq" OWNED BY public."Club".id;


--
-- Name: Collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Collection" (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public."Collection" OWNER TO postgres;

--
-- Name: Collection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Collection_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Collection_id_seq" OWNER TO postgres;

--
-- Name: Collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Collection_id_seq" OWNED BY public."Collection".id;


--
-- Name: FreeTime; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FreeTime" (
    id integer NOT NULL,
    text character varying(20)
);


ALTER TABLE public."FreeTime" OWNER TO postgres;

--
-- Name: FreeTime_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."FreeTime_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."FreeTime_id_seq" OWNER TO postgres;

--
-- Name: FreeTime_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."FreeTime_id_seq" OWNED BY public."FreeTime".id;


--
-- Name: Game; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Game" (
    id integer NOT NULL,
    name character varying(100),
    game_category_id integer,
    rules text,
    image bytea
);


ALTER TABLE public."Game" OWNER TO postgres;

--
-- Name: GameCategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GameCategory" (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public."GameCategory" OWNER TO postgres;

--
-- Name: GameCategory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."GameCategory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."GameCategory_id_seq" OWNER TO postgres;

--
-- Name: GameCategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."GameCategory_id_seq" OWNED BY public."GameCategory".id;


--
-- Name: Game_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Game_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Game_id_seq" OWNER TO postgres;

--
-- Name: Game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Game_id_seq" OWNED BY public."Game".id;


--
-- Name: Location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Location" (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public."Location" OWNER TO postgres;

--
-- Name: Location_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Location_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Location_id_seq" OWNER TO postgres;

--
-- Name: Location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Location_id_seq" OWNED BY public."Location".id;


--
-- Name: Message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Message" (
    id integer NOT NULL,
    user_sender_id integer,
    user_reciever_id integer,
    is_audio boolean,
    text text,
    audio bytea
);


ALTER TABLE public."Message" OWNER TO postgres;

--
-- Name: Message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Message_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Message_id_seq" OWNER TO postgres;

--
-- Name: Message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Message_id_seq" OWNED BY public."Message".id;


--
-- Name: News; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."News" (
    id integer NOT NULL,
    text text,
    date date,
    image bytea
);


ALTER TABLE public."News" OWNER TO postgres;

--
-- Name: News_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."News_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."News_id_seq" OWNER TO postgres;

--
-- Name: News_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."News_id_seq" OWNED BY public."News".id;


--
-- Name: Player; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Player" (
    id integer NOT NULL,
    user_id integer,
    description character varying(255),
    privilege_id integer,
    player_status_id integer,
    last_activity timestamp without time zone,
    experience integer,
    rating integer,
    is_online_status boolean,
    free_time_id integer
);


ALTER TABLE public."Player" OWNER TO postgres;

--
-- Name: PlayerCollection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PlayerCollection" (
    id integer NOT NULL,
    collection_id integer,
    player_id integer
);


ALTER TABLE public."PlayerCollection" OWNER TO postgres;

--
-- Name: PlayerCollection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PlayerCollection_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."PlayerCollection_id_seq" OWNER TO postgres;

--
-- Name: PlayerCollection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PlayerCollection_id_seq" OWNED BY public."PlayerCollection".id;


--
-- Name: PlayerRatingLog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PlayerRatingLog" (
    id integer NOT NULL,
    player_id integer,
    rating integer,
    date date
);


ALTER TABLE public."PlayerRatingLog" OWNER TO postgres;

--
-- Name: PlayerRatingLog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PlayerRatingLog_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."PlayerRatingLog_id_seq" OWNER TO postgres;

--
-- Name: PlayerRatingLog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PlayerRatingLog_id_seq" OWNED BY public."PlayerRatingLog".id;


--
-- Name: PlayerStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PlayerStatus" (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public."PlayerStatus" OWNER TO postgres;

--
-- Name: PlayerStatus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PlayerStatus_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."PlayerStatus_id_seq" OWNER TO postgres;

--
-- Name: PlayerStatus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PlayerStatus_id_seq" OWNED BY public."PlayerStatus".id;


--
-- Name: Player_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Player_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Player_id_seq" OWNER TO postgres;

--
-- Name: Player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Player_id_seq" OWNED BY public."Player".id;


--
-- Name: Privilege; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Privilege" (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public."Privilege" OWNER TO postgres;

--
-- Name: Privilege_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Privilege_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Privilege_id_seq" OWNER TO postgres;

--
-- Name: Privilege_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Privilege_id_seq" OWNED BY public."Privilege".id;


--
-- Name: Service; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Service" (
    id integer NOT NULL,
    name character varying(100),
    price real,
    service_category_id integer
);


ALTER TABLE public."Service" OWNER TO postgres;

--
-- Name: ServiceCategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ServiceCategory" (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public."ServiceCategory" OWNER TO postgres;

--
-- Name: ServiceCategory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ServiceCategory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ServiceCategory_id_seq" OWNER TO postgres;

--
-- Name: ServiceCategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ServiceCategory_id_seq" OWNED BY public."ServiceCategory".id;


--
-- Name: Service_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Service_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Service_id_seq" OWNER TO postgres;

--
-- Name: Service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Service_id_seq" OWNED BY public."Service".id;


--
-- Name: Tournament; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tournament" (
    id integer NOT NULL,
    game_id integer,
    tournament_category_id integer,
    player_status_id integer,
    tournament_status_id integer,
    text text,
    location_id integer,
    start_date date,
    start_time time without time zone,
    end_date date,
    end_time time without time zone,
    is_notificate boolean,
    description character varying(255),
    tournament_theme_id integer,
    users_count integer,
    rating real,
    age_rating character varying(3),
    price real
);


ALTER TABLE public."Tournament" OWNER TO postgres;

--
-- Name: TournamentCategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TournamentCategory" (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public."TournamentCategory" OWNER TO postgres;

--
-- Name: TournamentCategory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."TournamentCategory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."TournamentCategory_id_seq" OWNER TO postgres;

--
-- Name: TournamentCategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."TournamentCategory_id_seq" OWNED BY public."TournamentCategory".id;


--
-- Name: TournamentStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TournamentStatus" (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public."TournamentStatus" OWNER TO postgres;

--
-- Name: TournamentStatus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."TournamentStatus_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."TournamentStatus_id_seq" OWNER TO postgres;

--
-- Name: TournamentStatus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."TournamentStatus_id_seq" OWNED BY public."TournamentStatus".id;


--
-- Name: TournamentTheme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TournamentTheme" (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public."TournamentTheme" OWNER TO postgres;

--
-- Name: TournamentTheme_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."TournamentTheme_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."TournamentTheme_id_seq" OWNER TO postgres;

--
-- Name: TournamentTheme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."TournamentTheme_id_seq" OWNED BY public."TournamentTheme".id;


--
-- Name: Tournament_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Tournament_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Tournament_id_seq" OWNER TO postgres;

--
-- Name: Tournament_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Tournament_id_seq" OWNED BY public."Tournament".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    name character varying(100),
    login character varying(255),
    phone_number character varying(20),
    email character varying(255),
    password character varying(255),
    photo bytea
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: UserClub; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserClub" (
    id integer NOT NULL,
    user_id integer,
    club_id integer
);


ALTER TABLE public."UserClub" OWNER TO postgres;

--
-- Name: UserClub_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UserClub_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UserClub_id_seq" OWNER TO postgres;

--
-- Name: UserClub_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UserClub_id_seq" OWNED BY public."UserClub".id;


--
-- Name: UserGame; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserGame" (
    id integer NOT NULL,
    user_id integer,
    game_id integer
);


ALTER TABLE public."UserGame" OWNER TO postgres;

--
-- Name: UserGame_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UserGame_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UserGame_id_seq" OWNER TO postgres;

--
-- Name: UserGame_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UserGame_id_seq" OWNED BY public."UserGame".id;


--
-- Name: UserLog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserLog" (
    id integer NOT NULL,
    user_id integer,
    text character varying(255),
    date timestamp without time zone
);


ALTER TABLE public."UserLog" OWNER TO postgres;

--
-- Name: UserLog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UserLog_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UserLog_id_seq" OWNER TO postgres;

--
-- Name: UserLog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UserLog_id_seq" OWNED BY public."UserLog".id;


--
-- Name: UserTournament; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserTournament" (
    id integer NOT NULL,
    user_id integer,
    tournament_id integer,
    is_notificate boolean
);


ALTER TABLE public."UserTournament" OWNER TO postgres;

--
-- Name: UserTournament_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UserTournament_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UserTournament_id_seq" OWNER TO postgres;

--
-- Name: UserTournament_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UserTournament_id_seq" OWNED BY public."UserTournament".id;


--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: tournament_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.tournament_view AS
 SELECT t.id,
    g.name AS game_name,
    g.rules AS game_rules,
    gc.name AS game_category,
    tc.name AS tournament_category,
    ps.name AS player_status,
    ts.name AS tournament_status,
    t.text,
    l.name AS location,
    t.start_date,
    t.start_time,
    t.end_date,
    t.end_time,
    t.is_notificate,
    t.description,
    th.name AS tournament_theme,
    t.users_count,
    t.rating,
    t.age_rating,
    t.price
   FROM (((((((public."Tournament" t
     LEFT JOIN public."Game" g ON ((t.game_id = g.id)))
     LEFT JOIN public."GameCategory" gc ON ((gc.id = g.game_category_id)))
     LEFT JOIN public."TournamentCategory" tc ON ((tc.id = t.tournament_category_id)))
     LEFT JOIN public."PlayerStatus" ps ON ((ps.id = t.player_status_id)))
     LEFT JOIN public."TournamentStatus" ts ON ((ts.id = t.tournament_status_id)))
     LEFT JOIN public."Location" l ON ((l.id = t.location_id)))
     LEFT JOIN public."TournamentTheme" th ON ((th.id = t.tournament_theme_id)));


ALTER VIEW public.tournament_view OWNER TO postgres;

--
-- Name: user_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.user_view AS
 SELECT u.id,
    u.name,
    u.phone_number,
    u.email,
    p.description,
    p.last_activity,
    p.rating,
    p.experience,
    p.is_online_status,
    pr.name AS privilege,
    ps.name AS player_status,
    ft.text AS free_time
   FROM ((((public."User" u
     RIGHT JOIN public."Player" p ON ((p.user_id = u.id)))
     RIGHT JOIN public."Privilege" pr ON ((pr.id = p.privilege_id)))
     RIGHT JOIN public."PlayerStatus" ps ON ((ps.id = p.player_status_id)))
     RIGHT JOIN public."FreeTime" ft ON ((ft.id = p.free_time_id)));


ALTER VIEW public.user_view OWNER TO postgres;

--
-- Name: Admin id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Admin" ALTER COLUMN id SET DEFAULT nextval('public."Admin_id_seq"'::regclass);


--
-- Name: Basket id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Basket" ALTER COLUMN id SET DEFAULT nextval('public."Basket_id_seq"'::regclass);


--
-- Name: Club id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Club" ALTER COLUMN id SET DEFAULT nextval('public."Club_id_seq"'::regclass);


--
-- Name: Collection id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Collection" ALTER COLUMN id SET DEFAULT nextval('public."Collection_id_seq"'::regclass);


--
-- Name: FreeTime id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FreeTime" ALTER COLUMN id SET DEFAULT nextval('public."FreeTime_id_seq"'::regclass);


--
-- Name: Game id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Game" ALTER COLUMN id SET DEFAULT nextval('public."Game_id_seq"'::regclass);


--
-- Name: GameCategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GameCategory" ALTER COLUMN id SET DEFAULT nextval('public."GameCategory_id_seq"'::regclass);


--
-- Name: Location id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Location" ALTER COLUMN id SET DEFAULT nextval('public."Location_id_seq"'::regclass);


--
-- Name: Message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message" ALTER COLUMN id SET DEFAULT nextval('public."Message_id_seq"'::regclass);


--
-- Name: News id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."News" ALTER COLUMN id SET DEFAULT nextval('public."News_id_seq"'::regclass);


--
-- Name: Player id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Player" ALTER COLUMN id SET DEFAULT nextval('public."Player_id_seq"'::regclass);


--
-- Name: PlayerCollection id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PlayerCollection" ALTER COLUMN id SET DEFAULT nextval('public."PlayerCollection_id_seq"'::regclass);


--
-- Name: PlayerRatingLog id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PlayerRatingLog" ALTER COLUMN id SET DEFAULT nextval('public."PlayerRatingLog_id_seq"'::regclass);


--
-- Name: PlayerStatus id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PlayerStatus" ALTER COLUMN id SET DEFAULT nextval('public."PlayerStatus_id_seq"'::regclass);


--
-- Name: Privilege id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Privilege" ALTER COLUMN id SET DEFAULT nextval('public."Privilege_id_seq"'::regclass);


--
-- Name: Service id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Service" ALTER COLUMN id SET DEFAULT nextval('public."Service_id_seq"'::regclass);


--
-- Name: ServiceCategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ServiceCategory" ALTER COLUMN id SET DEFAULT nextval('public."ServiceCategory_id_seq"'::regclass);


--
-- Name: Tournament id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tournament" ALTER COLUMN id SET DEFAULT nextval('public."Tournament_id_seq"'::regclass);


--
-- Name: TournamentCategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TournamentCategory" ALTER COLUMN id SET DEFAULT nextval('public."TournamentCategory_id_seq"'::regclass);


--
-- Name: TournamentStatus id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TournamentStatus" ALTER COLUMN id SET DEFAULT nextval('public."TournamentStatus_id_seq"'::regclass);


--
-- Name: TournamentTheme id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TournamentTheme" ALTER COLUMN id SET DEFAULT nextval('public."TournamentTheme_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Name: UserClub id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserClub" ALTER COLUMN id SET DEFAULT nextval('public."UserClub_id_seq"'::regclass);


--
-- Name: UserGame id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserGame" ALTER COLUMN id SET DEFAULT nextval('public."UserGame_id_seq"'::regclass);


--
-- Name: UserLog id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserLog" ALTER COLUMN id SET DEFAULT nextval('public."UserLog_id_seq"'::regclass);


--
-- Name: UserTournament id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserTournament" ALTER COLUMN id SET DEFAULT nextval('public."UserTournament_id_seq"'::regclass);


--
-- Data for Name: Admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Admin" (id, user_id) FROM stdin;
1	42
2	18
3	10
4	2
\.


--
-- Data for Name: Basket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Basket" (id, user_id, service_id) FROM stdin;
1	37	32
2	12	50
3	23	15
4	28	23
5	23	21
6	23	10
7	21	6
8	31	5
9	40	31
10	19	9
11	9	32
12	23	18
13	1	32
14	32	10
15	12	32
16	46	38
17	48	12
18	41	29
19	32	3
20	20	6
21	10	20
22	9	1
23	3	32
24	32	20
25	12	19
26	43	18
27	39	15
28	48	16
29	12	12
30	45	32
31	32	50
32	22	45
33	20	42
34	18	23
35	12	12
36	34	43
37	29	40
38	5	21
39	6	32
40	10	20
41	12	19
42	31	17
43	45	16
44	32	12
45	50	32
46	8	50
47	7	32
48	1	3
49	12	29
50	23	1
\.


--
-- Data for Name: Club; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Club" (id, name, users_count) FROM stdin;
5	Игровой Уголок	1
9	Игровая Арена	0
10	Клуб Друзей	0
13	Экипаж Мультивселенной	0
14	Клуб Битва Кибер	0
15	Геймерские Звёзды	0
17	Квантум Гейм	0
19	Геймерские Легенды	0
25	Геймерская Явь	0
26	Цифровой Рай	0
31	Галактический Порт	0
32	СтимСфера	0
33	ПлейСтанция	0
34	КосмоКод	0
36	Геймерский Пульс	0
40	ГеймПалуба	0
41	Цифровой Домен	0
44	ПлейЛандия	0
45	Игровой Синдикат	0
48	ГеймГроуд	0
51	Байт-База	0
22	Битва КиберЭлит	1
24	Сетевые Авангардисты	1
43	Геймерский Олимп	1
42	КиберКолизей	1
12	Игровая Вселенная	1
11	Геймерский Хаб	2
29	ИгроМир	2
30	Процессорный Портал	1
47	КиберКоридор	1
35	Цифровое Гнездо	1
27	Кодовый Замок	1
46	Пиксельное Подземелье	1
23	Цифровые Штурмовики	1
18	Элементы Победа	2
49	КиберКолизей	1
50	Вирт-Ведомость	2
21	КиберЛегенда	1
20	Цифровые Штурманы	3
37	ЛанЛабиринт	1
38	ТехноТерритория	3
16	Короли Аренды	1
28	Клубная Матрица	3
39	ЦиферБлок	4
8	Команда Игроков	1
7	Геймерский Оазис	1
6	Клуб Стратегов	1
2	Виртуальный Мост	2
1	Игровая Сфера	6
4	Геймерская Лига	2
3	Клуб Победителей	1
\.


--
-- Data for Name: Collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Collection" (id, name) FROM stdin;
1	поиск предметов
2	пошаговая стратегия
3	многопользовательская
4	лабиринт
5	космический симулятор
6	соулс-лайк
7	раннер
8	гонки
9	авиасимуляторы
10	поинт-энд-клик
11	приключения
12	стелс
13	песочница
14	метроидвания
15	головоломки
16	ММОРПГ
17	менеджеры
18	симулятор жизни
19	защита башни
20	квест
21	тактические
22	военные
23	визуальная новелла
24	интерактивное кино
25	платформер
26	аркада
27	сюжетные
28	пазлы
29	три-в-ряд
30	динамическая
31	стратегия
32	выживание
33	строительство
34	афк
35	кликер
36	ритм-игра
37	симулятор
38	ферма
39	рогалик
40	настольные
41	казуальные
42	психологический хоррор
43	хоррор
44	королевская битва
45	шутер
46	моба
47	рпг
48	футбол
49	экшн
50	файтинги
\.


--
-- Data for Name: FreeTime; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FreeTime" (id, text) FROM stdin;
1	19-00
2	10-19
3	В любое время
\.


--
-- Data for Name: Game; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Game" (id, name, game_category_id, rules, image) FROM stdin;
2	GolfTopia	31	ПРОЕКТИРУЙТЕ, СТРОЙТЕ и УПРАВЛЯЙТЕ своим собственным футуристическим полем для гольфа. Держите 200 постоянных посетителей сытыми, увлажненными и счастливыми. Защитите свое творение от растущего заражения сорняками с помощью роботов-рабочих и оборонительных турелей. Превратите свой курс в мега-курорт, куда никто не хочет возвращаться домой, НИКОГДА	\N
3	Resist the succubus—The end of the female Knight	30	Как лорд города, будете ли вы придерживаться своей веры, чтобы сопротивляться, или решите поддаться желанию? Рассвет надежды или конец отчаяния? В таком шатающемся городе ваш выбор определит судьбу Селин ——	\N
4	Tom Clancy’s Splinter Cell: Conviction	29	Расследуя убийство дочери, бывший агент Сэм Фишер невольно открывает для себя, что он предан агентством под названием Третий Эшелон, на которое он когда-то работал. Теперь изменник Фишер вступает в гонку со временем, чтобы расстроить смертельный террористический заговор, угрожающий миллионам невинных жизней.	\N
5	Star Wars Jedi: Survivor	31	Приключенческий экшен, который продолжает историю Кэла Кестиса спустя пять лет после событий Star Wars Jedi: Fallen Order. Кэл стал могущественным рыцарем-джедаем и теперь ведёт отчаянную борьбу против Империи. Ему предстоит решить, насколько далеко он готов зайти, чтобы спасти своих близких.\n	\N
6	Prince of Persia: The Lost Crown - Mask of Darkness	28	Готовы ли вы нырнуть в пучину кошмаров? Mask of Darkness зовёт в новое приключение, где Саргон, главный герой Prince of Persia: The Lost Crown, оказывается в ловушке разума Раджен — коварной убийцы Бессмертных. Здесь, в царстве её тёмных фантазий, реальность извивается ужом, а прошлое обретает зловещую плоть. Представьте себе: каждый поворот может обернуться смертельной западнёй, каждая тень таит в себе неведомую опасность. И вот вы, ловкий как кошка, должны пройти по лезвию ножа между явью и безумием.	\N
7	Persona 5 Strikers	32	Присоединяйтесь к Призрачным ворам и нанесите ответный удар коррупции, охватившей города Японии. Летние каникулы с близкими друзьями принимают неожиданный оборот, когда возникает искаженная реальность; раскрыть правду и искупить сердца тех, кто находится в заключении в центре кризиса!	\N
8	Voidigo	31	Voidigo — это хаотичный и красочный шутер в жанре roguelite с упором на динамичные и уникальные бои с боссами. Экипируйте множество оружия и бонусов, чтобы дать отпор порче Бездны во всех мирах. Охотьтесь или будете охотиться.	\N
9	Baldur’s Gate II: Enhanced Edition\n	28	Вас похитили. Вас держат в плену. Вас пытают. Маг Айреникус пленил вас в своей крепости и пытается лишить сил, принадлежащих вам по праву рождения. Сможете ли вы сопротивляться злу, что в вашей крови и отринуть темную судьбу, что ждет вас? Или вы примете как должное свою чудовищную природу и вознесетесь, став новым Богом Убийства?	\N
10	World of Goo 2	14	Эта игра-головоломка предлагает нырнуть в мир, где привычные законы физики отдыхают, а правит бал вязкая субстанция. Хотите перекинуть мост через пропасть? Да запросто! Мечтаете о башне до небес? Почему бы и нет! А может, вам по душе лепить причудливые ландшафты или заправлять летающие штуковины? Всё в ваших руках.\n	\N
11	Lords of the Fallen	17	"В эпоху древних миром правил злобный бог, и всё человечество жило у него под пятой. Но страх, сковывавший сердца людей, уступил место ярости, и наступило утро Великого восстания, когда началась борьба за свободу. После славной победы над низвергнутым богом, люди установили новый порядок… при котором нет прощения грехам и спасение недоступно никому.	\N
12	StarCraft II: Legacy of the Void\n	12	StarCraft 2: Legacy of the Void – третье по счету сюжетно-ориентированное полномасштабное дополнение к легендарной реал-тайм стратегии. На этот раз под контроль игрока попадают войска разумной внеземной цивилизации Протосов. Героем сюжетной компании станет иерарх Артанис. Протагонист преследует две цели: первая – сплотить представителей своей расы в одну могущественную армию, вторая – препятствовать разрушительным планам Амуна.	\N
13	Homefront: The Revolution	27	После 4-х лет оккупации Америка на коленях.\nВ Филадельфии, бывшей родине независимости, с жителей не спускают глаз, подавляя любое инакомыслие.\nНекогда гордые граждане живут в полицейском государстве и вынуждены выживать; мечты о свободе давно угасли.\nОднако в бесплодных землях Красной Зоны формируются силы Сопротивления. Партизаны готовы биться за свободу и начать 2-ю американскую революцию.	\N
14	Homefront	39	На дворе 2027 год. Мир восстанавливается после 15-летнего упадка всей экономики и мирового конфликта, возникшего из-за резкого сокращения запасов природных ресурсов.\nПосле распада гордой Америки осталась лишь её шаткая инфраструктура и неорганизованная армия. Подвергшись атаке мощнейшего электромагнитного импульса, США лишилась всей своей защиты против постоянно увеличивающейся экспансии смертельно опасной, владеющей ядерным оружием Великой Корейской республики.\nСоединенные Штаты, потерявшие всех своих бывших союзников, теперь больше похожи на одну большую пустошь с городами, окруженными мощными стенами, и покинутыми поселками с кое-где проглядывающими людьми. Отныне Америка — это полицейский штат, где школьные стадионы превратились в тюрьмы, а торговые центры стали гаражами для напичканного оружием транспорта. Некогда свободные люди стали заключенными, дезертирами или же революционерами.	\N
15	Dyson Sphere Program	35	Постройте самую эффективную межгалактическую фабрику в космической стратегии Dyson Sphere Program! Используйте силу звезд, собирайте ресурсы, планируйте и проектируйте производственные линии и развивайте свою межзвездную фабрику из небольшой космической мастерской в индустриальную империю галактической масштабности.	\N
16	Sonic & All-Stars Racing Transformed	28	Sonic и команда All-Stars снова замерли на стартовых позициях, чтобы выявить лучшего в этих величайших гонках. На этот раз это не просто гонки, а гонки с трансформациями! Болиды прямо по ходу гонки превращаются то в машины, то в лодки, то в самолеты – и с каждым видом транспорта связан уникальный геймплей. Более 20 легендарных звездных персонажей, каждый со своим болидом-трансформером. 16 динамичных трасс, предлагающих непростые испытания для вас на земле, на воде и в воздухе. Пользуйтесь оригинальным оружием и способностями All-Star, уникальными для каждого персонажа, чтобы победить соперников. Участвуйте в сетевых гонках (до 10 человек) или же бросьте вызов своим друзьям и играйте с ними на разделенном экране вчетвером. Множество режимов, включая "Гранпри", "Боевые арены" и просто невероятный "Всемирный тур".	\N
17	Bitburner	41	Bitburner — это инкрементная игра, основанная на программировании. Пишите сценарии на JavaScript, чтобы автоматизировать игровой процесс, изучать навыки, играть в мини-игры, решать головоломки и многое другое в этой текстовой инкрементной ролевой игре в стиле киберпанк.	\N
18	Marvel’s Spider-Man Remastered	46	В Marvel's Spider-Man Remastered миры Питера Паркера и Человека-паука сталкиваются в оригинальной захватывающей истории. Играйте за опытного Питера Паркера, сражающегося с крупной преступностью и знаменитыми злодеями в Нью-Йорке Marvel. Перемещайтесь по паутине через оживленные районы и побеждайте злодеев с помощью эпических убийств.	\N
19	Alpaca Stacka	30	Трехмерный приключенческий платформер, в котором вы играете за добрую альпаку, которая помогает своим друзьям-животным.	\N
20	Outlast: Whistleblower	29	Whistleblower начинает историю, которая привела к событиям в Outlast, а также показывает, что произошло после окончания основной игры, являясь настоящей последней главой в истории психбольницы Маунт Массив.\nOutlast: Whistleblower рассказывает историю Вейлона Парка - программиста, работающего на компанию Муркофф, который отправил электронные письма журналистам всего мира, включая Майлза Апшура, протагониста оригинальной Outlast.	\N
21	Ultimate Marvel vs. Capcom 3	8	Marvel и Capcom объединились, чтобы организовать самые безумные битвы 3 на 3 в игре Ultimate Marvel vs. Capcom 3. Игра содержит весь выпущенный ранее контент и артбук Marvel vs. Capcom: Official Complete Works. Выбирайте из самых популярных персонажей Marvel и Capcom и соберите команду на свой вкус в режиме «Heroes and Heralds». Отточив свои навыки, отправляйтесь в гущу сетевых сражений с другими игроками за звание лучшего бойца во вселенной.	\N
22	Battlefield Hardline	8	Преступники против копов, честь против денег. Примите одну из сторон и выполняйте специфические задания на свойственной вашему классу технике. Ожидается много новых игровых режимов, новое оружие и вспомогательные устройства. И все это в стиле полюбившейся многим серии Battlefield.	\N
23	Monster Hunter Wilds	45	На самом краешке мира раскинулись таинственные Запретные земли. Именно здесь разворачивается история Monster Hunter Wilds. Всё завертелось вокруг мальчугана по имени Ната, каким-то чудом вырвавшегося из лап неведомого чудища и нашедшего приют у бравых ребят из Гильдии охотников. Его рассказ о разорённой дотла деревеньке и чудовище, доселе невиданном, стал той самой искоркой, из которой разгорелось пламя неуёмного любопытства в душах бывалых следопытов. Так и началась эта сумасбродная затея — экспедиция, призванная не только раскрыть тайны неизведанных земель, но и попытаться наладить хрупкий мостик взаимопонимания между человеком и дикой природой.	\N
24	In Sound Mind	10	In Sound Mind — это творческий психологический хоррор от первого лица с безумными головоломками, уникальными битвами с боссами и оригинальной музыкой от The Living Tombstone. Путешествие во внутреннюю работу единственного места, от которого вы, кажется, не можете убежать — вашего собственного разума.	\N
25	Life Is Strange 2	1	Встречайте новую историю в серии Life is Strange от DONTNOD Entertainment.\nИз-за трагических событий братья Шон и Даниэль Диасы сбегают из дома. Скрываясь от полиции, они обнаруживают у Даниэля телекинетическую способность — умение двигать предметы силой мысли. В поисках убежища братья отправляются в мексиканский городок Пуэрто-Лобос, на родину их отца.	\N
26	Apollo Justice: Ace Attorney Trilogy	4	Приготовьтесь отправиться в захватывающее юридическое приключение в компании с Аполло Джастисом - талантливым молодым адвокатом из легендарной серии игр Ace Attorney!	\N
27	Trials of the Blood Dragon	32	2019 год\nКровавые драконы.\nНовое будущее.\nИ мужчина.\nИ мальчик.\nИ девочка.\nРоксанна и Слэйтер, потомки Рекса Пауэра Кольта. Достойные дети своих родителей, лучшие из лучших. Они сразятся в 4-й вьетнамской войне за мир и свободу.\n	\N
28	Grounded	18	Мир — огромное, красивое и опасное место, особенно если вы уменьшились до размеров муравья. Сможете ли вы процветать вместе с полчищами гигантских насекомых, сражаясь за выживание в опасностях заднего двора?	\N
29	Evil God Korone	27	Неожиданное сотрудничество от Tsugunohi, игры, в которой ужас вторгается в повседневную жизнь, и VTuber Inugami Korone из группы VTuber hololive. Инугами Короне, которая в прямом эфире транслировала многие игры ужасов, стала злой богиней и захватила Цугунохи. А теперь отрежь себе палец и отдай ей.	\N
30	Far Cry 4	19	Добро пожаловать в Кират – затерянную среди вершин Гималаев страну с богатыми традициями, мир которому угрожает деспотичный правитель. Ваш герой, Аджай Гейл, прибыл сюда, чтобы исполнить последнюю волю матери, но оказался втянут в гражданскую войну: местные жители пытаются свергнуть самозванца Паган Мина. Отправляйтесь в путешествие по открытому миру, но будьте осторожны: в незнакомой стране с вами может случиться что угодно.	\N
31	Idle Skilling	27	Idle Skilling — лучшая игра в режиме ожидания с многолетним контентом! В нее можно играть по 5-10 минут в день, постепенно открывая новые навыки, такие как добыча полезных ископаемых, рыбалка, разведение домашних животных, крестовый поход, зельеварение, лабораторные исследования, строительство и многое другое! С появлением новых обновлений у вас всегда будет чем заняться!	\N
32	LEGO The Lord of the Rings	40	Концептуально LEGO The Lord of the Rings предлагает все тот же суповой набор развлечений, что и тысяча игр с мясистой биркой LEGO до нее. В качестве декораций и сюжетного фона тут предсказуемо используются материалы из кинотрилогии «Властелин Колец». На правах пластмассовых фигурок, условно копирующих персонажей из трех фильмов Питера Джексона, игрокам предстоит поскитаться по Средиземью, посетить шахты Мории, миновать черные ворота Мордора и, естественно, уничтожить зловещее кольцо. Развлекать путников по мере того, как они будут сплавляться по сюжетному руслу всей трилогии, суждено угловатым оркам, Балрогу и прочей фэнтезийной живности, фигурировавшей в кинолентах	\N
33	Goose Goose Duck	10	Гусь, гусь, УТКА? Игра на социальную дедукцию, в которой вы и ваши собратья-гуси должны работать вместе, чтобы выполнить свою миссию. Следите за теми злобными Кряквами и другими птицами, которые проникли в вашу команду и сделают все, чтобы остановить вас.	\N
34	Aliens vs. Predator (2010)	29	Игра перенесет вас в легендарную войну между двумя известнейшими научно-популярными персонажами. В AvP присутствуют 3 невообразимые кампании и уникальная совместная игра, включающая 3 режима.\nНовые незабываемые впечатления и новый геймплей от первого лица на выживание. Устраивайте охоту в смертельных джунглях и на колонии, окруженной болотами.	\N
35	Among Us	46	Приветствуем новобранцев!\nПора отправиться на новую карту — Airship! Работайте в команде, чтобы воплотить в жизнь амбициозный план... а принесете ли вы пользу или станете предателем, уже другой вопрос.\n	\N
36	Monster Hunter Rise: Sunbreak Demo	39	Почувствуйте вкус однопользовательской и многопользовательской игры Monster Hunter Rise и ее масштабного дополнения Monster Hunter Rise: Sunbreak в этой демоверсии. Испытайте новые функции Sunbreak, сражаясь с Великим Изути, Тетранадоном, Асталосом и Мальзено!	\N
37	Coromon	36	Coromon — это современная интерпретация классического жанра приручения монстров. Приручите Коромона и исследуйте огромный мир, наполненный захватывающими пошаговыми сражениями, головоломными головоломками и таинственной угрозой миру, ожидающей поражения. Никто не говорил, что быть исследователем боевых действий легко!	\N
38	Postal III	28	Быть добрым или сумасшедшим? Выбор за вами!\nПосле апокалиптично закончившейся недели Чувака из Постал в городе-раю Парадайз, мы переезжаем с ним и чокнутым питбулем Чампом в город-побратим рая Катарсис. К сожалению, оказалось что из-за глобального экономического кризиса, психически нестабильных фанатиков защиты природы, коррупции и лицемерии у власти, и в Катарсисе жизнь непроста.	\N
39	Half-Life: Alyx	10	Half-Life: Alyx — это возвращение Valve во вселенную Half-Life в виртуальной реальности. Это история невозможной борьбы с жестокой расой пришельцев, известной как Альянс. События происходят между Half-Life и Half-Life 2.	\N
40	FIFA Online 3	19	FIFA Online 3 — бесплатный Free-to-play, распространяющийся исключительно для азиатского рынка, относится к разряду футбольный спортивный симулятор. Игра была анонсирована 12 августа 2012 года на Е3 наряду с европейским аналогом FIFA World . 13 декабря 2012 года было анонсировано, что моделью игры станет Ким Хёна	\N
41	Touhou Endless Dream	38	Стреляющий ад в жанре roguelike. Игроки могут использовать персонажей с разными способностями, собирать и собирать мощные предметы. Танцуйте под бесконечным шквалом пуль, чтобы спасти себя и Touhou Gensokyo от тьмы, которая поглощает все вокруг.	\N
42	Anger Foot	20	Шутер от первого лица, в котором вы можете пинать врагов так сильно, что они летят на другой конец карты. А если это не помогает, то вы всегда можете прикончить их из своего арсенала оружия, который включает в себя не только классические пистолеты, дробовики и экзотические винтовки.\n	\N
43	Warhammer 40,000: Mechanicus	8	Управляйте одной из самых технологически продвинутых армий Империума — Адептус Механикус. В роли магоса доминуса Фаустиниуса возглавьте экспедицию на недавно заново открытую планету некронов Сильва Тенебрис. Настраивайте отряд, распределяйте ресурсы, ищите давно забытые технологии и управляйте техножрецами.\nКаждое ваше решение в ходе 50 созданных вручную заданий повлияет на следующие задания и в конечном счете решит судьбу всего отряда. Выбирайте свой путь осторожно — судьба Империума зависит от вас.	\N
44	Dyson Sphere Program	7	Постройте самую эффективную межгалактическую фабрику в космической стратегии Dyson Sphere Program! Используйте силу звезд, собирайте ресурсы, планируйте и проектируйте производственные линии и развивайте свою межзвездную фабрику из небольшой космической мастерской в индустриальную империю галактической масштабности.	\N
45	Lara Croft and the Guardian of Light	17	Lara Croft and the Guardian of Light — это динамичная приключенческая игра, где в роли главной героини выступает сама Лара Крофт. Эта часть серии совмещает в себе исследования и открытия, платформер и решение загадок с развитием персонажа, интересными сражениями, совместной игрой и состязаниями.	\N
46	Avengers (2020)	49	Вам предстоит собрать команду Величайших героев Земли, принять свою силу и воплотить в жизнь свои мечты о подвигах.\n«Мстители Marvel» – это грандиозный приключенческий боевик от третьего лица, сочетающий в себе увлекательный сюжет и захватывающий игровой процесс как в одиночной, так и в совместной игре. Сформируйте онлайн-команду, в которой может быть до четырех человек, освойте невероятные способности, выберите героев из регулярно пополняющегося списка и защитите Землю от надвигающейся угрозы.	\N
47	Star Wars Hunters	42	Многопользовательская игра, которая погружает игроков в мир охотников за головами и гладиаторских сражений во вселенной «Звёздных войн». Действие игры разворачивается на планете Веспаара, где лучшие охотники со всей галактики собираются на Арене, чтобы сразиться в состязаниях с высокими ставками.	\N
48	OPUS: Echo of Starsong - Full Bloom Edition	50	Echo of Starsong — это приключенческая игра в стиле визуальных новелл. Эда, девушка, которая может слышать таинственные звуковые волны, известные как песня звезд, пересекает пути с молодым человеком в поисках их источника. Вместе они отправляются в самое сердце космоса, чтобы разгадать древний миф.	\N
49	Flintlock: The Siege of Dawn	12	Приключенческий экшен в стиле souls-lite. Эта игра погружает вас в эпическую битву, где судьба человечества висит на волоске, а боги и огнестрельное оружие сталкиваются в непримиримом противостоянии.\n	\N
50	Quake Champions	34	Игра Quake Champions, созданная компанией id Software в сотрудничестве с Saber Interactive, вернет вас в мир жесткого соперничества и неистовых перестрелок, которые более двух десятилетий назад сделали Quake прародителем жанра многопользовательских шутеров. Quake Champions объединяет мрачный сюжет первого Quake, мощные сетевые баталии Quake III Arena и современный игровой тренд — чемпионов. Каждый из этих свирепых воинов обладает уникальными навыками и характеристиками, а значит, игрок сможет сражаться на арене в своем неповторимом стиле.	\N
1	Tavern Master	2	Tavern Master — это игра об управлении средневековой таверной. Вы начинаете с очень маленькой комнаты, пары скамеек и столов и строите свой путь до огромной успешной таверны с кухней, комнатами для гостей, группой преданных сотрудников и многим другим!	\N
\.


--
-- Data for Name: GameCategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."GameCategory" (id, name) FROM stdin;
1	поиск предметов
2	пошаговая стратегия
3	многопользовательская
4	лабиринт
5	космический симулятор
6	соулс-лайк
7	раннер
8	гонки
9	авиасимуляторы
10	поинт-энд-клик
11	приключения
12	стелс
13	песочница
14	метроидвания
15	головоломки
16	ММОРПГ
17	менеджеры
18	симулятор жизни
19	защита башни
20	квест
21	тактические
22	военные
23	визуальная новелла
24	интерактивное кино
25	платформер
26	аркада
27	сюжетные
28	пазлы
29	три-в-ряд
30	динамическая
31	стратегия
32	выживание
33	строительство
34	афк
35	кликер
36	ритм-игра
37	симулятор
38	ферма
39	рогалик
40	настольные
41	казуальные
42	психологический хоррор
43	хоррор
44	королевская битва
45	шутер
46	моба
47	рпг
48	футбол
49	экшн
50	файтинги
\.


--
-- Data for Name: Location; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Location" (id, name) FROM stdin;
1	Встреча по адресу
2	По договорённости
3	Из дома
\.


--
-- Data for Name: Message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Message" (id, user_sender_id, user_reciever_id, is_audio, text, audio) FROM stdin;
1	1	10	f	RG2JOO6rR9JYHaeZdrUq9HecjmG9O9R+t8nK6pVPor4=	\N
2	36	20	f	RLKN+VHXr9O9/iLCtBQ0zvzOfaSsxXzvejoRawQl6RI=	\N
3	27	46	f	5cXkIW7wTHN72mKZ4ETwdVvwBwvP5Fnm06FNuUkiba4=	\N
4	9	25	f	W8rZ2kj058f94MJQOP7xHfA3zOU3uWrRBTuYxRjJ7eI=	\N
5	2	39	f	1Oo69yqaCGy7Z6Aggcvru6UASBo7B5rJoUTkGRm2FG4=	\N
6	6	35	f	3Wg6/KNPy1tHlZ3+7bvMvXPSm2Uf4oNi+IRzalBn6tQ=	\N
7	14	3	f	f4Ga+dgZh9br0zYlY7bI/rl3rrQwy9fm7xiWF0zHXdY=	\N
8	11	8	f	gNYo9epr4kDuTV6fQYiz/IVfSKc1G2DA1speK3ZZg18=	\N
9	16	12	f	eoec4gnZLdr/quxeew4no8bWMYnB9CWu7hrdcgwW2/Q=	\N
10	29	28	f	eYUPyiIa6OZlLq+Q9FoPa4EjWjyV0drPUMLFaovk3OY=	\N
11	29	9	f	YEs7gHlSwRHtA9rRoElZjtNwN5ZhyZmn00g3n9PvKhQ=	\N
12	1	8	f	q5YqcpyqqsRR7odrZzundIkXJSDL/1l1cvh9otGmboA=	\N
13	10	7	f	ymJ3BrP660pA45tdmy+8wZi6LP8mNF/ibxkLslLu7yo=	\N
14	43	25	f	TItEgUd4NanB2SusmCaKc4NsYbexUS/y9Rg8ygGw2No=	\N
15	32	2	f	f4SgtoXNR919YjpqyqFGGN1bdFaDGJenhIhhwIi/RA8=	\N
16	12	50	f	jmV61MAiksaAno2lmiLbIEmgwA9x2ZP74Y3CExbJh/w=	\N
17	48	49	f	G8wSSn1r86XzEfedWi42oj07ZYvwK6CaU3C0XjShOkw=	\N
18	43	48	f	4nwGCmA3dA0WY63GBoh0jAmlDeScGu9vobeNUwP9hO4=	\N
19	49	32	f	1Pb1SvC8zlH0uhQX8UijHozEREJi48fOnc9klrrP1L0=	\N
20	29	29	f	/31ltkcuUZpr/4dJL8E8TyBqJR5hbk+6rQT1te5MlT0=	\N
21	37	32	f	6DUtF2YK1QzaTTh0S03D7tedTy1V1POuhlBPwcImt4Y=	\N
22	29	38	f	hc4FAOSZkWZpCc/+5OjSoBC7lxaknZ3L/0HIXeK1xu8=	\N
23	9	12	f	aM5zqZDFuI7GjZPrcKe+nnXIOlKcWMcgEi3tnCVxiFQ=	\N
24	21	15	f	l8jJK5LphAALrr3ptQNpdoNYCEcs7J5dt4Oh6NDZySw=	\N
25	22	12	f	iedeuriWohQs8fFX46vutJ/2r5Dh6Vvu/V57PVZHSbM=	\N
26	25	10	f	5s1oPG8Dv7Xw8vMyPsI0pLIKUxX5dJRrQt0sXBh9jvo=	\N
27	1	19	f	W4fbqR2NPcLXOblhd1N3F+mNue+diB/mEABtuOiKkVA=	\N
28	28	36	f	22D77mRzrLHYJoZ1vLocJiRETZfNmradEInnuIY8VV0=	\N
29	39	31	f	r+pz5JKBxLXQSoq54f3APUej5il1KFPFkqY29cEUqng=	\N
30	1	33	f	y8gzh6N6ml+Nf6Q/Kv63dvkeMvJDln6nws2Z9JH494k=	\N
31	26	37	f	f/J7ptasTwqaRHeyad4ir35Ee6zu68/aebYmYNotG4c=	\N
32	18	26	f	2VvkegiJqAXD+1DxXvMJF8SLoHrs3oQ8Y2MK5Fipdrw=	\N
33	20	39	f	Kf2hxvmMalmhgbrB6LzqiVzW6ablb57FiQdhwLUreA8=	\N
34	1	21	f	PqGlkbiSQ176pbW7Eypeumqs3BM8NsP1SWyZqcPlSWY=	\N
35	9	29	f	dUx7bnjtxSzcG/S+nN+6uzZ7ThhH63LB8Ndm/tKUMCA=	\N
36	8	27	f	8uejKV/nKe3I4c5a3d9hNEPK0ym6xl8Zw7Peg0aKzeo=	\N
37	5	19	f	JyzX9un3gom9NNGwoMzf89gbT4iVNN9bs60jX7iWTlc=	\N
38	4	12	f	T/Uw6V9kpIyF87+nJMIldlr51cua4HQM/lGDsh0Dois=	\N
39	12	50	f	/f4fOz6rcxamxzTrt0uP3GxYT0YlpUtY4E7PnXnVAHI=	\N
40	42	2	f	N578AFeqkK86f5tVQh7mwtrG0fIKhcyF+hxKEtjboSk=	\N
41	42	48	f	/ZZNMqiHbzCuQsOSLfIVtBtFkxKbD1x7f7FNcQIlNkQ=	\N
42	35	47	f	pl0drAagzkx1yKoA1K71sOn0qB/P//FzjgDvqhmSCKU=	\N
43	29	34	f	u+yv7sS8PtSgB2CSsp76qnPft73jQ05EypjO65Rwedw=	\N
44	1	41	f	4KNSgwrtUu7tu5fXUinuKhu7MuLp32IutfcpEukXFyg=	\N
45	9	2	f	AFNUB8jjvLtjmQBc2tHiK7d4GEdqLsE59ufh7e9m/HA=	\N
46	10	2	f	JFy5eQQbmDF/BRN0ib71YrIYIuBVPxEP0LBLq7udaYc=	\N
47	1	17	f	tlTCLKaIYEYErM4oqzpInvvOL47MkmzbRgZdqODjmN4=	\N
48	32	39	f	YDpSIT9ka69RBeTFFBMv0wuTzl94b2uxqzzCq7zhit0=	\N
49	1	32	f	dWICe08PlGBBhwCBrLiPw/mfUf7bLTHpsW8IAq+8agE=	\N
50	12	3	f	2Ix3Sa+Zb0Nz2LzoPS9CrpAnonHX34A4Mcm3KNMrw9E=	\N
51	28	2	f	OMILl8OrqDae+MOIrMDsvcW+WADFUlQV96zZbxJFZ+Q=	\N
52	1	2	f	ebXQYU2qn20S7SlUsdRP5pjqBZEl+2chXiYCkEhiR2o=	\N
\.


--
-- Data for Name: News; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."News" (id, text, date, image) FROM stdin;
1	Авторы TimeSplitters анонсировали Beyond Words — рогалик про составление слов	2025-04-04	\N
2	Дебютную игру студии соавтора Just Cause и Mad Max представят на следующей неделе	2025-04-12	\N
3	Square Enix и Atlus стали крупнейшими клиентами «призрачной» студии Tose в прошлом году	2025-08-19	\N
4	Ремейк Prince of Persia: The Sands of Time «сильно изменился» — Ubisoft о слитой презентации	2025-04-01	\N
5	Treyarch объяснила, почему матчмейкинг в Call of Duty: Black Ops 7 ощущается «по-другому»	2025-05-14	\N
6	PARIVISION по Counter-Strike 2 выбилась во вторую стадию StarLadder Budapest Major 2025	2025-04-04	\N
7	Создатели Path of Exile 2 представили анонсирующий тизер лиги Фатум Ваал	2025-06-04	\N
8	Глава Epic Games обвинил Valve в давлении на маленьких разработчиков	2025-03-29	\N
9	Игроки ARC Raiders в восторге от защиты закрытых комнат — эксплойтеров сжигают заживо	2025-06-13	\N
10	Начался закрытый бета-тест Monster Hunter: Outlanders	2025-06-08	\N
11	Virtus.pro по Dota 2 перевела Antares на скамейку запасных	2025-06-12	\N
12	Разработчики Nivalis объяснились за перенос релиза и рассказали об одной из локаций	2025-03-25	\N
13	Будущее Last Epoch выглядит грустным и платным — фанаты подбили рейтинг игры в Steam	2025-01-24	\N
14	Менеджер Team Spirit удивлен героям MOUZ и назвал Yamich топом мирового уровня в Dota 2	2025-04-23	\N
15	Соавтор Halo рассказал, что Мастер Чиф это танк M1 «Абрамс» и шлем для BMX	2025-08-27	\N
16	Тренер NRG раскритиковал себя после вылета команды с мейджора по Counter-Strike 2	2025-05-29	\N
17	GTA 4 получила фанатский мод с впечатляющим освещением благодаря RTX Remix	2025-06-12	\N
18	Forza Horizon 6 могут выпустить в первой половине 2026 года, но не из-за GTA 6	2025-02-24	\N
19	Именитые аналитики и игроки в Counter-Strike 2 оценили победу PARIVISION на мейджоре	2025-09-26	\N
20	Актёр из Assassinʼs Creed Origins разнёс коллаборацию Assassinʼs Creed Shadows с «Атакой титанов»	2025-08-04	\N
21	Аналитик Thorin раскритиковал низкий уровень игры на старте мейджора по Counter-Strike 2	2025-05-02	\N
22	Уникальные сборки Fallout: New Vegas с вырезанным контентом нашли на девкитах Xbox 360	2025-02-08	\N
23	Стример Afoninje бросил Dota 2 из-за нелюдимых тиммейтов и вечных буткемпов	2025-08-02	\N
24	Хоррор The 9th Charnel о мрачном будущем получил трейлер геймплея с датой выхода 30 января	2025-01-17	\N
25	Автор Death Stranding и Metal Gear Хидео Кодзима стал лауреатом «Человека года» GQ Japan	2025-07-20	\N
26	В ролевой игре Arknights: Endfield начался второй бета-тест с новым регионом и расширенным сюжетом	2025-01-06	\N
27	Игрок Team Falcons по Dota 2 жестко высказался о победе над Tundra и высмеял драфты врагов	2025-05-26	\N
28	Хоррор Layers of Fear: Final Masterpiece Edition выйдет на Nintendo Switch 2 19 декабря	2025-03-02	\N
29	Игроки украинской B8 уничтожили соперников и ворвались в топ мейджора по Counter-Strike 2	2025-02-05	\N
30	Создатели Dispatch признались, что их удивляют некоторые фанатские теории	2025-01-25	\N
31	На Comic Con Игромир 2025 представят «Фурию» и «Возвращение в Сайлент Хилл» — кинопрограмма	2025-08-03	\N
32	Аналитик Pimp раскритиковал FaZe за блеклое выступление на мейджоре по Counter-Strike 2	2025-10-29	\N
33	В ролевой игре Sword of Convallaria началась коллаборация с The Witcher 3	2025-06-12	\N
34	Разработчики экшена Let It Die: Inferno признались в использовании ИИ для вывесок и музыки	2025-07-22	\N
35	Сложная MMO от маленькой российской студии Reign of Guilds разделила игроков на два лагеря	2025-09-10	\N
36	Мидер Team Falcons по Dota 2 пошел против всех и прокачал «мертвого» героя до максимума	2025-04-27	\N
37	Увольнениями в студии авторов GTA 6 заинтересовался шотландский политик	2025-04-09	\N
38	Стратегия Total War: Warhammer 3 получила менеджер модификаций — он вышел в раннем доступе	2025-01-10	\N
39	Шутер Escape from Tarkov в Steam получил коллекционные карточки и предметы для профиля	2025-04-21	\N
40	Менеджер Team Spirit назвал Miposhka королем Dota 2 и отправил стримера RAMZES666 на отдых	2025-03-31	\N
41	На Московской международной неделе видеоигр объяснили успехи российских киберспортсменов	2025-05-29	\N
42	Крупнейшая площадка скинов по Counter-Strike 2 официально объявила о банкротстве	2025-02-14	\N
43	Авторы выживача Icarus поделились новостями о долгожданном дополнении Dangerous Horizons	2025-01-05	\N
44	Разработчица Dead Rising 5 раскрыла детали противников и движка отменённой игры	2025-10-16	\N
45	Авторы Warhammer 40,000: Space Marine 2 рассказали о будущем классе технодесантника	2025-05-06	\N
46	Вышло сравнение графики GTA 4 с новым модом на трассировку лучей и без него	2025-01-20	\N
47	Песочница Hytale в духе Minecraft выйдет в раннем доступе 13 января 2026 года	2025-02-19	\N
48	Немецкая HEROIC по Counter-Strike 2 назначила нового капитана	2025-01-26	\N
49	Ретро-хоррор Tormented Souls 2 продался тиражом свыше 100 тысяч копий	2025-06-08	\N
50	Yakuza Kiwami 3 & Dark Ties покажет вектор направления серии Like a Dragon	2025-08-22	\N
\.


--
-- Data for Name: Player; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Player" (id, user_id, description, privilege_id, player_status_id, last_activity, experience, rating, is_online_status, free_time_id) FROM stdin;
4	49	\N	2	1	2025-07-17 11:38:00	87	365	f	2
5	48	\N	2	3	2025-05-17 19:31:00	32	423	f	1
6	47	\N	1	1	2025-02-23 01:59:00	86	199	f	1
9	44	\N	1	1	2025-09-05 11:39:00	26	824	f	2
11	42	\N	2	1	2025-01-23 00:21:00	96	262	f	3
13	40	\N	3	3	2025-09-16 20:39:00	46	354	f	3
14	39	\N	1	1	2025-01-09 03:27:00	53	395	f	2
15	38	\N	1	2	2025-04-04 08:46:00	62	715	f	3
20	33	\N	2	1	2025-09-04 00:38:00	35	687	f	1
21	32	\N	2	1	2025-04-26 12:53:00	32	430	f	3
22	31	\N	1	3	2025-09-08 08:45:00	53	641	f	3
24	29	\N	1	3	2025-09-09 03:21:00	37	885	f	3
25	28	\N	1	2	2025-03-17 22:46:00	19	664	f	2
28	25	\N	2	2	2025-07-04 19:16:00	28	840	f	1
30	23	\N	1	3	2025-05-16 05:11:00	45	920	f	2
36	17	\N	1	2	2025-01-16 00:55:00	96	150	f	1
37	16	\N	3	3	2025-04-14 23:20:00	37	700	f	3
44	9	\N	1	2	2025-05-06 18:24:00	30	754	f	1
45	2	\N	3	1	2025-02-20 01:39:00	90	421	f	2
47	7	\N	3	2	2025-07-15 12:40:00	27	327	f	1
51	3	\N	2	1	2025-08-15 18:59:00	2	810	f	1
42	11	Люблю погружаться в мультяшные миры и создавать свои легенды. В игре — как дома, в жизни — как в игре.\n	1	1	2025-08-12 14:11:00	88	109	f	1
7	46	Геймер в душе и на деле, ищу новых друзей и соратников для совместных побед.	1	2	2025-03-08 18:28:00	70	287	f	1
8	45	Люблю мультигеймерство и социальные игровые проекты. Время — мой главный актив.	1	3	2025-04-28 12:59:00	86	645	f	3
17	36	Внутри меня — strategist и искатель приключений. Взоры на победу и новые уровни.	1	1	2025-01-24 02:57:00	13	360	f	2
23	30	Путешественник по виртуальным мирам, погружаюсь в новые виды игр каждую неделю.	2	1	2025-09-08 08:45:00	25	223	f	2
26	27	Креативный геймер, люблю создавать свои собственные уровни и делиться ими с миром.\n	1	3	2025-09-03 23:52:00	83	570	f	3
27	26	Искатель редких скинов и крутых команд. Играю для удовольствия и победы!	3	2	2025-10-17 05:27:00	94	235	f	2
29	24	За спиной — тысячи боёв и столько же побед. В игре — моя вторая жизнь.	3	1	2025-05-02 06:46:00	62	634	f	1
31	22	Отстранён от мира, но погружён в игровой вселенной. Люблю RPG и легендарных боссов.	1	1	2025-08-29 20:33:00	57	568	f	1
33	20	Геймер, стример и просто любитель хорошего настроения. В игре — чтобы быть немного счастливее.\n	1	3	2025-09-16 04:14:00	76	525	f	2
34	19	Осваиваю разные жанры, от командных шутеров до инди-приключений. Мир игр — моя вселенная.	2	1	2025-01-30 05:44:00	49	557	f	1
35	18	Привет! В основном люблю PvP и командные бои. За каждым новым матчем — новый вызов!	1	3	2025-10-04 18:34:00	9	150	f	2
38	15	Играю ради удовольствия и новых ощущений. Любая игра — это возможность вспомнить детство и почувствовать драйв.	2	2	2025-06-26 00:32:00	70	400	f	3
40	13	Мастер тактики и стратегии. Вижу в каждом раунде шанс на победу. В игре — свой стиль и характер.	2	3	2025-05-18 21:24:00	50	200	f	1
41	12	Просто геймер с мечтой стать чемпионом. Всё, что мне нужно — хороший интернет и отличная команда!	1	1	2025-03-28 12:05:00	33	139	f	3
46	8	Настоящий киберспортсмен и любитель хаоса. Ставлю рекорды, ищу новых друзей и просто наслаждаюсь игрой.	1	3	2025-09-03 11:40:00	38	378	f	2
16	37	\N	3	2	2025-05-19 00:33:00	91	189	f	3
39	14	\N	1	1	2025-05-27 04:28:00	65	238	f	3
32	21	\N	1	1	2025-09-04 11:55:00	96	392	f	1
18	35	\N	3	3	2025-10-07 02:18:00	65	769	f	2
12	41	\N	2	2	2025-04-05 15:24:00	35	382	f	2
10	43	\N	3	1	2025-08-28 00:56:00	73	400	f	2
50	4	\N	3	2	2025-01-14 01:13:00	64	329	f	2
19	34	\N	2	3	2025-02-17 14:23:00	14	540	f	2
43	10	\N	1	3	2025-09-02 23:28:00	96	192	f	3
48	6	Виртуальный исследователь и фанат RPG. Встаю на путь приключений, чтобы открыть новые миры и встретить легендарных героев.	1	1	2025-05-30 22:20:00	60	470	f	3
49	5	Геймер-энтузиаст, любящий стратегии и шутеры. Время — мой главный ресурс, а победа — моя цель. В команду — за победами!	1	3	2025-09-11 07:35:00	61	604	f	2
52	1	Погружён в мир фэнтези, магии и легенд. Люблю командные сражения и эпические гонки. Вроде бы новичок, но стремлюсь стать героем!	1	1	2025-06-05 14:56:00	36	821	f	2
3	50	Фанат классики и новинок. В игре я — артист, а победа — мой шедевр.	1	2	2025-11-28 20:52:57.175891	20	283	f	1
\.


--
-- Data for Name: PlayerCollection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PlayerCollection" (id, collection_id, player_id) FROM stdin;
1	50	51
2	46	51
3	34	45
4	23	4
5	19	26
6	27	11
7	12	12
8	50	30
9	43	29
10	32	12
11	17	29
12	23	36
13	16	47
14	18	29
15	12	10
16	50	12
17	43	11
18	32	6
19	19	5
20	32	12
21	18	43
22	10	12
23	3	32
24	8	18
25	40	32
26	41	10
27	43	42
28	38	18
29	35	32
30	29	17
31	9	21
32	8	29
33	7	28
34	20	21
35	21	29
36	39	37
37	4	9
38	45	40
39	32	41
40	18	43
41	2	50
42	6	52
43	50	32
44	43	32
45	12	32
46	43	18
47	39	12
48	2	10
49	12	5
50	23	4
\.


--
-- Data for Name: PlayerRatingLog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PlayerRatingLog" (id, player_id, rating, date) FROM stdin;
9	3	793	2025-11-28
10	7	287	2025-11-28
11	8	645	2025-11-28
12	17	360	2025-11-28
13	23	223	2025-11-28
14	26	570	2025-11-28
15	27	235	2025-11-28
16	29	634	2025-11-28
17	31	568	2025-11-28
18	33	525	2025-11-28
19	34	557	2025-11-28
20	35	150	2025-11-28
21	38	400	2025-11-28
22	40	200	2025-11-28
23	41	139	2025-11-28
24	42	537	2025-11-28
25	46	378	2025-11-28
26	48	470	2025-11-28
27	49	604	2025-11-28
28	52	308	2025-11-28
30	19	654	2025-11-28
31	10	816	2025-11-28
32	16	604	2025-11-28
33	19	200	2025-11-28
34	32	625	2025-11-28
35	18	429	2025-11-28
36	3	793	2025-11-28
37	3	382	2025-11-28
38	3	100	2025-11-28
39	3	159	2025-11-28
40	19	200	2025-11-28
41	50	640	2025-11-28
42	19	129	2025-11-28
43	19	932	2025-11-28
44	19	600	2025-11-28
45	43	232	2025-11-28
46	42	537	2025-11-28
47	39	300	2025-11-28
48	52	308	2025-11-28
49	12	916	2025-11-28
50	10	299	2025-11-28
51	4	365	2025-11-28
52	5	423	2025-11-28
53	6	199	2025-11-28
54	9	824	2025-11-28
55	11	262	2025-11-28
56	13	354	2025-11-28
57	14	395	2025-11-28
58	15	715	2025-11-28
59	20	687	2025-11-28
60	21	430	2025-11-28
61	22	641	2025-11-28
62	24	885	2025-11-28
63	25	664	2025-11-28
64	28	840	2025-11-28
65	30	920	2025-11-28
66	36	150	2025-11-28
67	37	700	2025-11-28
68	44	754	2025-11-28
69	45	421	2025-11-28
70	47	327	2025-11-28
71	51	810	2025-11-28
72	42	109	2025-11-28
73	7	287	2025-11-28
74	8	645	2025-11-28
75	17	360	2025-11-28
76	23	223	2025-11-28
77	26	570	2025-11-28
78	27	235	2025-11-28
79	29	634	2025-11-28
80	31	568	2025-11-28
81	33	525	2025-11-28
82	34	557	2025-11-28
83	35	150	2025-11-28
84	38	400	2025-11-28
85	40	200	2025-11-28
86	41	139	2025-11-28
87	46	378	2025-11-28
88	3	283	2025-11-28
89	16	189	2025-11-28
90	39	238	2025-11-28
91	32	392	2025-11-28
92	18	769	2025-11-28
93	12	382	2025-11-28
94	10	400	2025-11-28
95	50	329	2025-11-28
96	19	540	2025-11-28
97	43	192	2025-11-28
98	48	470	2025-11-28
99	49	604	2025-11-28
100	52	821	2025-11-28
101	3	283	2025-11-28
102	3	283	2025-11-28
103	3	283	2025-11-28
104	3	283	2025-11-28
\.


--
-- Data for Name: PlayerStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PlayerStatus" (id, name) FROM stdin;
1	Гость
2	Новичок
3	Мастер
\.


--
-- Data for Name: Privilege; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Privilege" (id, name) FROM stdin;
2	Серебрянный
3	Золотой
1	Отсутствует
\.


--
-- Data for Name: Service; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Service" (id, name, price, service_category_id) FROM stdin;
3	Опыт использования в реальных условиях	\N	10
7	Поддержка и обслуживание клиентов	\N	9
8	Обеспечение безопасности транзакций	\N	9
9	Интеграция платежных систем	\N	9
11	Продажа виртуальной валюты	\N	9
13	Продвижение каналов на YouTube и Twitch	\N	8
14	Монтаж и графический дизайн для видео	\N	8
15	Обработка видеоконтента	\N	8
21	Модерация форумов и групп	\N	7
25	Тематические игровые вечеринки	\N	6
26	Организация LAN-патий	\N	6
27	Поддержка и обновление серверного ПО	\N	5
28	Обеспечение безопасности серверов	\N	5
29	Услуги по управлению игровыми мирами	\N	5
30	Услуги по настройке серверов	\N	5
32	Продажа жидкостей для охлаждения ПК	\N	4
33	 Продажа игровых наушников	\N	4
36	Партнерство с киберспортивными организациями	\N	3
37	Тренировки команд	\N	3
42	Видеоуроки по прокачке персонажей	\N	2
44	Тренировки по стратегии и тактике	\N	2
45	Курсы по киберспорту	\N	2
1	Продажа VR-оборудования	534	11
2	Поддержка по вопросам выбора техники	255	10
4	Тестирование новых моделей	139	10
5	Статьи и рекомендации	144	10
6	Видео-обзоры	352	10
10	Создание кастомных скинов и предметов	144	9
12	Создание рекламных роликов	315	8
16	Настройка стримингового оборудования	250	8
17	Организация встреч и конференций	286	7
18	Ведение блогов и новостных каналов	376	7
19	Участие в челленджах и ивентах	588	7
20	Ведение соцсетей	277	7
22	Фото- и видеосъемка мероприятий	572	6
23	Кейтеринг для геймеров	320	6
24	Аренда помещения для игр	590	6
31	Аутентичные игровые коврики	565	4
34	Ремонт и настройка геймерских устройств	316	4
35	 Продажа игровых мышей и клавиатур	356	4
38	Консультации по командообразованию	200	3
39	Киберспортивная аналитика	239	3
40	Организация турниров	158	3
41	Мастер-классы по дизайну игр\n	481	2
43	Обучение созданию контента по играм	261	2
46	Провайдинг высокоскоростного интернета для геймеров	245	1
47	 Прокат игровых приставок	425	1
48	Ремонт и настройка игровых ПК	247	1
49	Онлайн-турниры	113	1
50	Аренда игровых компьютеров	100	1
\.


--
-- Data for Name: ServiceCategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ServiceCategory" (id, name) FROM stdin;
1	Геймерский интернет-клуб
2	Обучение и тренинги по играм
3	Киберспортивные услуги
4	Магазины игровых аксессуаров
5	Аренда игровых серверов
6	Проведение геймерских мероприятий и вечеринок
7	Создание и управление геймерскими сообществами
8	Стриминг и видеопроизводство
9	Виртуальные бутики и магазины игровых предметов
10	Обзоры и тесты игровых устройств
11	Индустрия виртуальной реальности (VR)
\.


--
-- Data for Name: Tournament; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Tournament" (id, game_id, tournament_category_id, player_status_id, tournament_status_id, text, location_id, start_date, start_time, end_date, end_time, is_notificate, description, tournament_theme_id, users_count, rating, age_rating, price) FROM stdin;
6	5	28	2	2	\N	3	2025-07-31	13:20:00	2025-08-02	12:30:00	f	\N	15	4	6.71	18+	\N
1	12	8	1	2	Поддерживайте команду! Убедитесь, что все участники вашей команды подтвердили участие до конца недели.\n	3	2025-01-27	17:00:00	2025-01-29	13:10:00	t	Время подзарядиться адреналином! Наш турнир — это возможность проявить себя и сделать первый шаг к славе.	40	2	6.35	18+	\N
2	32	6	3	3	\N	2	2025-03-03	20:00:00	2025-03-03	23:00:00	f	Проверьте свои навыки и логическое мышление! Эти соревнования — шанс стать настоящим чемпионом.\n	26	3	\N	16+	544
3	29	4	1	2	Подарки и бонусы! Не пропустите специальные награды для лучших команд и участников. Участвуйте и побеждайте!\n	3	2025-03-21	20:40:00	2025-03-23	18:50:00	t	\N	28	5	9.86	8+	782
4	12	21	3	3	Время подтверждения! Напоминаем, что дата и время турнира будет объявлены после окончания регистрации. Следите за обновлениями.	2	2025-09-20	12:10:00	2025-09-23	10:20:00	t	Играйте ради победы! Впереди — напряжённые матчи, крутые награды и новые знакомства.	23	6	2.86	18+	701
5	8	20	2	3	Планируемые расписания. Подробнее о расписании и формате турнира будет опубликовано за несколько дней до начала.	3	2025-09-17	11:30:00	2025-09-17	14:40:00	t	Легендарный турнир с уникальной атмосферой! Готовьтесь к борьбе с лучшими и к незабываемым эмоциям.	10	4	\N	14+	\N
7	11	32	1	3	\N	3	2025-08-20	16:00:00	2025-08-20	18:40:00	f	\N	16	5	\N	16+	782
8	12	13	3	2	Технические требования. Перед турниром убедитесь в наличии стабильного интернет-соединения и необходимого оборудования.	1	2025-06-26	23:40:00	2025-06-28	16:10:00	t	Турнир собирает сильнейших! Уделите время, соберите команду и побеждайте в каждом раунде.	17	2	4.93	16+	103
33	42	50	1	1	\N	3	2025-04-09	13:30:00	2025-04-10	08:20:00	f	\N	43	3	\N	8+	\N
34	40	43	2	1	\N	3	2025-06-06	09:10:00	2025-06-06	20:50:00	t	\N	25	4	\N	16+	\N
9	23	43	1	1	Объявление лауреатов! Итоги и награждение победителей состоится в онлайн-церемонии через несколько дней после завершения турнира.	2	2025-09-24	09:30:00	2025-09-27	08:50:00	t	\N	21	5	6.82	14+	\N
10	43	32	3	1	\N	2	2025-09-15	22:50:00	2025-09-16	21:30:00	f	\N	28	4	\N	16+	121
11	31	17	3	2	Обратная связь. Нужна помощь или есть вопросы? Свяжитесь с нашей поддержкой по электронной почте или в чате.	1	2025-08-27	19:50:00	2025-08-29	14:20:00	t	\N	45	7	2.49	16+	418
12	23	10	2	1	\N	3	2025-09-22	10:00:00	2025-09-22	13:00:00	t	\N	32	8	2.08	8+	\N
13	50	18	1	1	Публичная трансляция. Турнир будет транслироваться онлайн — следите за нашими соцсетями за ссылками и анонсами.	2	2025-01-26	17:40:00	2025-01-28	16:40:00	f	\N	21	4	\N	14+	140
14	12	12	2	3	\N	3	2025-10-23	10:50:00	2025-10-24	10:10:00	f	В этот раз решающая битва! Станьте частью грандиозного события и выиграйте главные призы.\n	23	5	4.09	18+	\N
15	32	42	1	2	\N	3	2025-03-20	20:10:00	2025-03-24	11:40:00	t	\N	20	4	\N	8+	714
16	38	32	2	3	Проверка оборудования. За сутки до турнира рекомендуется проверить работу всех устройств и программного обеспечения.	1	2025-02-01	10:20:00	2025-02-01	18:10:00	t	\N	41	8	\N	8+	\N
17	29	12	1	3	\N	2	2025-01-02	15:50:00	2025-01-05	15:30:00	t	\N	50	3	4	8+	\N
18	12	43	1	3	\N	1	2025-02-02	12:20:00	2025-02-02	17:50:00	f	\N	12	6	\N	16+	326
19	9	43	3	1	Обновление правил. Перед стартом внимательно ознакомьтесь с правилами и регламентом соревнования.	3	2025-05-06	14:00:00	2025-05-07	14:10:00	f	\N	43	5	9.34	18+	592
20	8	12	1	4	\N	2	2025-01-11	21:10:00	2025-01-14	15:40:00	t	Горячие матчи, крутые моменты — наш турнир для тех, кто любит играть и побеждать. Не пропустите!	32	2	2.17	8+	\N
21	10	3	3	1	Объявление участников. График игр и список участников будет опубликован за день до начала — держите в курсе!	1	2025-03-12	18:30:00	2025-03-13	18:20:00	t	\N	12	3	\N	8+	\N
22	12	24	2	1	\N	2	2025-04-01	11:20:00	2025-04-05	10:30:00	f	Уровень подготовлен, стратегия на подходе! Кто из вас заслужит титул лучшего игрока? Докажите это на турнире!	27	8	9.6	14+	\N
23	29	8	3	4	Обучающие материалы. Для тех, кто хочет улучшить свои навыки, подготовлены видео и советы от профи.\n	3	2025-07-27	08:30:00	2025-07-27	22:40:00	t	\N	20	4	\N	14+	\N
24	36	31	2	2	\N	1	2025-08-25	15:10:00	2025-08-28	11:50:00	f	Самое время для конкуренции! Испытайте свои силы на арене нашего турнира и заработайте заслуженные награды.	32	6	\N	8+	\N
25	33	20	1	2	\N	2	2025-03-02	18:50:00	2025-03-02	19:20:00	t	\N	12	3	5.99	8+	119
26	23	12	2	2	\N	2	2025-09-14	23:10:00	2025-09-15	09:50:00	f	\N	45	7	\N	18+	476
27	12	30	3	1	Погода и новости. Следите за обновлениями — возможны изменения в расписании или форматах из-за технических причин.	3	2025-04-22	16:50:00	2025-04-24	16:30:00	t	\N	12	8	3.21	16+	701
28	43	37	2	3	\N	1	2025-04-01	14:50:00	2025-04-03	18:00:00	t	Вдохновляющая битва за звание чемпиона! Отбирайте команду, совершенствуйте навыки и боритесь за победу.	32	6	\N	8+	\N
29	29	31	2	1	Безопасность в играх. Помните о правилах честной игры и уважительном отношении к соперникам.	2	2025-07-12	09:00:00	2025-07-12	19:40:00	t	Покажите свою тактику и командный дух! Турнир по игре собирает лучших геймеров со всей страны.	40	10	7.86	8+	782
30	43	43	1	3	\N	1	2025-03-28	19:00:00	2025-03-28	20:20:00	f	\N	30	6	2.12	18+	774
31	50	12	2	2	Время начала. Не забудьте — турнир стартует в запланленное время. Предварительно подготовьте всё необходимое.	1	2025-10-31	21:00:00	2025-10-31	22:10:00	f	\N	48	2	4.94	8+	\N
32	12	23	1	3	\N	2	2025-04-11	23:00:00	2025-04-14	20:30:00	t	Готовьтесь к ярким сражениям и неожиданным поворотам! Наш турнир — это место, где рождаются герои.	41	5	\N	8+	424
35	27	12	1	2	\N	2	2025-08-28	13:10:00	2025-08-28	15:20:00	t	\N	18	3	3.78	18+	\N
36	29	32	2	2	\N	3	2025-08-22	12:40:00	2025-08-22	21:50:00	t	Самое масштабное соревнование года! Участвуйте, боритесь за титул и покажите, что вы — лучшие в этой игре.	15	2	4.94	16+	\N
37	31	29	1	1	\N	1	2025-02-28	12:50:00	2025-02-28	23:20:00	f	\N	16	5	\N	14+	\N
38	34	47	2	2	\N	2	2025-01-27	22:20:00	2025-01-28	09:40:00	f	Игра началась! Соберите команду и станьте частью захватывающего турнира с крутыми наградами и драйвовыми матчами.	43	4	5.21	8+	\N
39	24	38	1	1	\N	1	2025-04-14	15:00:00	2025-04-16	23:30:00	f	\N	50	5	\N	14+	\N
40	45	43	3	2	\N	2	2025-10-21	13:50:00	2025-10-22	13:40:00	f	\N	10	6	\N	8+	\N
41	32	25	1	2	Доступ к чатам и форумам. Для участников будут открыты специальные каналы общений — используйте их для koordinacji.	3	2025-07-17	16:20:00	2025-07-19	08:40:00	t	Взрыв эмоций и незабываемых моментов! Наш турнир по игре — это шанс проявить себя и побороться за победу.	12	3	4.12	18+	\N
42	19	12	3	3	\N	1	2025-06-14	12:00:00	2025-06-14	21:40:00	t	\N	34	12	4.14	8+	\N
43	6	9	1	3	\N	1	2025-09-01	11:00:00	2025-09-01	22:00:00	t	В этот уикенд — битва за главный приз! Турнир объединяет любителей и профессионалов. Не пропусти свой шанс стать чемпионом!	7	6	\N	8+	\N
44	5	10	2	3	Фотографии и отчёты. Делитесь самыми яркими моментами турнира в соцсетях с нашими хештегами!	1	2025-08-16	14:30:00	2025-08-20	08:00:00	t	\N	8	3	4	16+	\N
45	1	4	3	1	\N	2	2025-07-25	11:10:00	2025-07-25	17:30:00	f	Испытай свои силы! Собери команду, подготовь стратегию и сразись за звание лучшего игрока этого сезона. Кто зайдёт на вершину?	23	5	\N	8+	\N
46	12	32	2	4	\N	3	2025-07-23	17:10:00	2025-07-28	17:20:00	f	\N	12	8	4.8	18+	\N
47	50	12	1	4	Обратная связь после турнира. Мы ценим ваше мнение — расскажите, как прошла ваша игра, и что можно улучшить.	3	2025-04-28	19:30:00	2025-04-29	19:10:00	t	\N	45	2	3.76	8+	\N
48	43	50	3	2	Спасибо за участие! Будем рады видеть вас снова в наших будущих мероприятиях. Следите за новостями!	1	2025-10-25	10:40:00	2025-10-27	21:20:00	t	Время для легендарных боёв! Турнир по игре собирает всех фаворитов и новичков. Кто возьмёт верх? Следите за новостями!\n	32	3	8.74	16+	\N
49	12	34	2	4	\N	2	2025-07-13	23:50:00	2025-07-15	08:10:00	f	Готовы к вызову? Наш турнир обещает напряжённые матчи и яркие моменты. Собирайте команду и покажите, на что вы способны!	12	2	\N	8+	\N
50	23	4	3	3	Добро пожаловать! Напоминаем, что регистрация на турнир завершится через несколько дней. Не пропустите возможность показать свои навыки!	3	2025-02-04	09:20:00	2025-02-04	22:30:00	t	Приготовьтесь к эпическому сражению! Лучшие команды собираются, чтобы показать свои навыки и завоевать титул чемпиона. Кто станет победителем? Узнаем скоро!	28	2	4.9	16+	\N
\.


--
-- Data for Name: TournamentCategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TournamentCategory" (id, name) FROM stdin;
1	Спонсорские компании и бренды
2	Локальные встречи и чемпионаты
3	Инновационные игровые гаджеты
4	Контроль через геймпады или клавиатуры
5	Турниры с использованием VR-шлемов
6	Весенние баталии
7	Зимние турниры
8	Летние чемпионаты
9	Денежные выплаты
10	Фанатские инди-клубы
11	Официальные сезоны киберспорта
12	Онлайн-оценка и отзывы
13	 Голосование зрителей за MVP
14	Локальные чемпионы
15	Спортивные симуляторы
16	Карточные игры в виртуальном формате
17	Тактические бои
18	Временные режимы и акции
19	Турниры приуроченные к релизам игр
20	VIP-мероприятия
21	Итерационные турниры с ранжированием
22	Турниры с мультифункциональными режимами
23	Командные баталии
24	Публичные стриминговые мероприятия
25	Стратегические встречи на закрытых форумах
26	Профессиональные чемпионаты
27	Закрытые клубные соревнования
28	Турниры для массовой публики
29	Спонсорское техническое оборудование
30	Трансляционная студия
31	Виртуальный конфиг с настройками
32	Офлайн-зал с оборудованием под ключ
33	Мультистриминг каналов
34	Прямой эфир на Twitch, YouTube, VK
35	Участие с взносом и денежными наградами
36	Бесплатные турниры
37	Мастер-классы и демонстрации\n
38	Специальные тематические квесты и сценарии
39	Фанатские мероприятия по популярным играм
40	Командный формат
41	Офлайн-турниры
42	Онлайн-турниры
43	Региональные лига
44	Многодневные финалы
45	Однодневные турниры
46	Кроссплатформенные турниры
47	Виртуальная реальность (VR)
48	Мобильные устройства
49	Консоли 
50	ПК
\.


--
-- Data for Name: TournamentStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TournamentStatus" (id, name) FROM stdin;
1	Отменён
2	Завершён
3	В процессе
4	Закрыт
5	Открыт
\.


--
-- Data for Name: TournamentTheme; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TournamentTheme" (id, name) FROM stdin;
1	Карточные игры
2	Приключения
3	Фэнтези королевство
4	Космическая Одиссея
5	Апокалипсис
6	Пиратские приключения
7	Мифологический мир
8	Ретро-аркада
9	Киберпанк будущее
10	Магический лес
11	Древние цивилизации
12	Полнолуние
13	Поствоенная руина
14	Шпионаж и триллеры
15	Морские сражения
16	Город будущего
17	Джунгли и тайнственные острова
18	Стратегический замок
19	Артиллерийские баталии
20	Пустынные приключения
21	Морские легенды и легендарные морские жители
22	Вулканические земли
23	Тайны фондовых рынков
24	Фантастические звери и существа
25	Средневековая Европа
26	Гонки на выживание
27	Крутые гангстеры и мафиози
28	Эпоха динозавров
29	Путешествие во времени
30	Атомный постапокалипсис
31	Индустриальная революция
32	Тропические острова и архипелаги 
33	Восточные боевые искусства
34	Готическая туманность
35	Космический фермер
36	Крепкие командиры и флотилии
37	Великая арктическая экспедиция
38	Ночные города и теневые улочки
39	Магический цирк
40	Арктическое выживание
41	Зимняя спортивная гонка
42	Подводные приключения
43	Легендарные рыцари
44	Японский самурайский мир
45	Громовые бури и штормы
46	Технологичные роботы и механизмы
47	Пазлы и логические миссии
48	Зоологическое королевство
49	Легендарные герои и героини
50	Мировые войны
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, name, login, phone_number, email, password, photo) FROM stdin;
1	Iusa	uvA9JpZLZB8Oefj3mwjl+SyGKlY1+KXOZFTyJ8Ed1i0=	+7 (940) 388-28-96	yefrumodojau-4759@mail.com	LvW+BbAYLP6wQyuHKyIXKmjP07+loJXMiNaxbOzc8YE=	\N
2	Yasuoh	2aU9FCvlkE34XAh4Eu+GXDX7tMd8pLf+RORUFji9jJA=	+7 (928) 628-18-29	beuyoucruwucro-7070@gmail.com	xrkXTEC3GCRlgxrUpAwI8YEu2PmhxRhqlFtDZ819qvQ=	\N
0	ГЕЙМТАЙМ ✓	\N	\N	\N	\N	\N
3	Ganisa	6dfc9b164a7072f9abff6c585de6be1d95ef8e09817198bf4c75e30fedbbda56	+7 (960) 681-39-97	yimmuprafeiprou-5501@yopmail.com	r6crMbouqAXNTKxLg/amWBLicuqtn/FZ7fS8Ijx9UFw=	\N
4	Quilla	23ec314d1e149d6520052fcbea03ea6c0e5b4349790744e57471272cb95211aa	+7 (911) 835-11-37	licauhedete-5458@yopmail.com	DnGZDg5qyVhGwX/RLaObsY/cFXMnuvUEEAK+4zxJ7Lk=	\N
5	Jefferry	1deaee897b0ab52fec83ca15e43242b45d7c42bf6c42028c77506e5b526cc836	+7 (926) 670-45-55	crirottennozo-2238@yopmail.com	bxM3c54eyuI3T0XdHV2wxy3jNO3qJ1LxQBmoum13mH0=	\N
6	Unginael	4b451556a26f07d92c952a88beba6ab9bc051a8ae3a93172da1e5886b4d63042	+7 (971) 281-23-95	bauhisuseuqueu-2063@yopmail.com	zhLlfnjrR27V8Xg0ApOMQfAu5suAED9wsaM8UYIVwRE=	\N
7	Uilikom	265767421419760a504a9af13d7ca91e72144b01f198e21eb4ff058f253574dc	+7 (910) 158-24-78	frubassotreddu-3869@yopmail.com	AJBRHDaJ3Z6dZnz869HDUPWDYCHCY6d2I+3nhsFgV/8=	\N
8	Vain	5bef7674ae7985acd9de6bc9af6bab566f4fc331fd2c8c6b6ec6cb58f01f4918	+7 (914) 768-66-11	gaquagaddatra-9838@yopmail.com	sg2Psjjqn9TrcC7D3V9y5ukPVtlD4eWOteXh+oYr098=	\N
9	Pifacya	9dece81de2be58ebbda115c22472cac2303325ec380b79f0e1b5fdc6c0704f1a	+7 (942) 907-85-64	vottidakinne-3807@yopmail.com	1D3xubUGlo2cxmjFTfqNtUKAiEqXTRYRGWwuVvHGOZQ=	\N
10	Lianto	614937b871f998ec1ee48f35f3dc450aff7029de1b83cadf4ac361255e573f0e	+7 (992) 549-16-56	nounnaripacrei-8161@yopmail.com	n0LswGz8S8qOWLtpzKA6I3cZ2xRkEj/rle1oluKbr/s=	\N
11	Quintagu	8f2b9f302957b72724be3c27c9b55f3a78bdfb96db81649f803665c941e57d18	+7 (967) 686-65-13	zeidinefulau-3619@yopmail.com	trn0KiXRyCkQjJJG73PX4Q25IvHc7oOg6/k1DalBGV8=	\N
12	Hava	5239b52f8e2a437bafbae967dc0123552185b9d6f43eedfaa777496a4f77765d	+7 (912) 437-94-55	peutuprawute-5642@yopmail.com	SwR2lWjmR9sTd1zMJSaARJdlxTP023FOL2HuktMiX9Y=	\N
13	Nanisha	c8a079c9f49271d1747e23f827b152abd72091089afe95d49a80bea373c151c8	+7 (905) 600-90-69	bebeyussixau-2127@yopmail.com	dRlos5ajbaSQgiZ8GLCLty6u4wD3U+9KaB1Hf7Cp9Ho=	\N
14	Darahan	d3a18190d784bebe2db2b658dd3bf6a652629215aa1c94c6838b5b0a6ad28841	+7 (946) 847-79-89	ledinninnedde-9280@yopmail.com	1LBHkyhQTkWD7K10Spp1wf4UOS5u/W248W2jBedbSbA=	\N
15	Radysi	6029ff342690a790f5744ed2ce0342d064fc25183e295625e4f652fa93cba2b3	+7 (912) 458-27-79	geixeubofrida-4280@yopmail.com	7VOypvxZV8bKY8q8NuAUGz4wZlXj0tZfOAjmVDb7GVM=	\N
16	Cedri	19b4e48fba74bb04b3888ff30cd7d6ce92f3bab64c9e6cdd0b0788013f904c5f	+7 (982) 979-39-58	priveweffemme-8457@yopmail.com	n2z00JtTw+53acF1c8jxVuRR5FYuEC8Gcmum3Aqh/mU=	\N
17	Barnicar	56c58b44fb47e5fbebb0b6ba84d5a9e478ad836da5dc489d61040f25f9f28f07	+7 (951) 308-31-26	mejaffeinaumou-9144@yopmail.com	Hh7oDh4AsjOjeRUi4x03orPk6zFqRCO/GhBdkpeJ3wg=	\N
18	Weste	b21135235d909709b95cef6fc9e6da4af40812a3364e28ffa837c4accf90d82a	+7 (916) 211-64-18	freimmicoimmora-2789@yopmail.com	RE1FBcGAq08OOwk+mltknBrCAEL+U1HavpeoQ2XoRWM=	\N
19	Alenad	077a794cb3eb5cfbb211651f7eba56cb4299e093185924b791d3a97c606f62b4	+7 (933) 141-66-94	griffouddeufaxou-4315@yopmail.com	9HjT+yKk4YHiBPcMFbp51keVFuE0rgJsqAUoZhjmB3Y=	\N
20	Omenaya	c6df118e4b9c70663e4493b4df53855cab7c0e7202ac65439ca02d195d0d407b	+7 (968) 122-79-56	quehireugeifau-3313@yopmail.com	FmSOOgz6ssFJ7OeU8sDasVJIPWGY+d8uXhglmmy0jI4=	\N
21	Veatr	1a8b3cdf99de6611d747b186b2d00fb58ee951a25f9db4239d32e6d1598202a6	+7 (955) 968-10-78	cremaucedouku-5261@yopmail.com	hTjtsOzNotFesjTmYkEOoFJKD8F9QKO7oyd4ttQP2Mc=	\N
22	Dany	5e365177a4485a91c7fe7f19c8753a013fe075b517e67cc38b53a77011697857	+7 (940) 892-14-32	jocruwuhobro-7328@yopmail.com	sTNGLIvnE4DChtMOO0fMR27l/DP1qYDu1AUgIHtE14k=	\N
23	Xuan	5681ba637a1735b972cc0fdc99c5733348f174bb8fc4cbdc2eb060437ee9bec6	+7 (941) 692-13-49	suxoipuveute-3607@yopmail.com	rshGmREqLNmfPPZ5iorGY7khhCjiM//fORL48HzSVf4=	\N
24	Traco	lT3Iduf9dBejJ+xoMYWTpL3iI1JRxO0PslAV8rdtuDo=	+7 (969) 423-17-48	rojobakepu-1444@yopmail.com	8gso8Fx3XXlUvEdwjMyXDiPMwdc/zX8Sj7kjfgXOuHA=	\N
25	Naluland	F/AQX3YhUC8Qeqkne5/OpEwY05n/DERoGKzUy/sqXNw=	+7 (938) 931-76-91	rofaufricrejo-8111@yopmail.com	Ymhqtybyqk17Xqm9smJWQBWHP5jibP/SI0ofWjJowyE=	\N
26	Orington	s8cuh/25LGB74veqvu78CWCkpJMVtrCL2eLFDu/j5uc=	+7 (970) 691-85-63	magotaudipe-8463@yopmail.com	ayi+oyEgEb/uOVGyak1qdpC2rZUC86ZHDzIFLC41BDI=	\N
27	Durinna	OX08X3IwK9jaWmtU53RfbHXTQe5OiC11NKDfigJiGoY=	+7 (974) 397-53-81	nauttoprexofi-5130@yopmail.com	lC2gTTCTbi206gpF13EqG/9HxnMlYuNukE3xoIIeEf0=	\N
28	Hirac	KFMBxc+av76mcBKBcr8VisW0mB0TGm3f4IP18YhCTOo=	+7 (984) 819-55-85	youcegreveuke-5864@yopmail.com	9vQTTX7dklL5+TgUfhYbHZaoL+sXYYEAtx71TR8VPXU=	\N
29	Phre	kwfJ4hatoxSgBJlnF/NKgtdRHRilZncXE8kIDV3pHro=	+7 (996) 734-59-94	frouttuyalemme-2702@yopmail.com	aQMGq+GV1h6OOMuI8YstLNstFIssBrWT8OzjGgI6NfA=	\N
30	Jaceyala	+lzylXXxJN3IPeNInrldNZiIg/1hohXULWzyByzvOpw=	+7 (940) 758-74-79	bauttallapruse-3579@yopmail.com	cYoMT+GLl+w6fKYbhe/9QTzSPi3uTObZyHpanfDqvzQ=	\N
31	Stia	qEmDyPWUkN7u8Uvky0v34S2t4sG3v04wF1FW4BW+PG0=	+7 (911) 533-38-24	queijiviquisse-4275@yopmail.com	s5qsideXClAACGoSCPzdUjtFqjYgbFYu2hVkugScxMM=	\N
32	Ooksanc	d9p7fRTmB43V/5fVWrX18WYiDvKaQoWz5cWgrgPiC6M=	+7 (983) 861-37-56	frouvoupequowau-4063@yopmail.com	P2gUtnoO+RkPQcqV2WgSoxj9G/Vr7pKq3glc+hEhasc=	\N
33	Terry	U0Qon7T8da3CIx76I/FF7ZYluUGjCB1QSgcFeJKTyqo=	+7 (953) 527-80-78	quatiddejammo-3361@yopmail.com	aq4l8yHZHZxE/4mjHQzinmGY/rX+YPu9n4fHSwjUTNw=	\N
34	Cosinj	890PpyJDE5N0XBtW4fD+Z98zwfjT099pwjOAIUGebIA=	+7 (912) 814-56-13	kecrellotopou-8891@yopmail.com	WickqiL/1xVNu5moSfbaWFTnlOKKsFnXiYCXjEjNTEs=	\N
35	Veli	UuCbO65Ot2pJfeAhwcFXkrhN0+FMUG22PkQNSji6XvI=	+7 (960) 892-73-51	kennikeisaxa-8723@yopmail.com	AJflyoiLMVbHKUwUefqK0zAyHJSJLpNT2Z7kYu1I8I8=	\N
36	Bith	XYs08CtAghRwUxp2zg27uJDotj56BVUaACWM0fp7LZg=	+7 (912) 377-83-64	tegratayilei-7846@yopmail.com	Sw9tG9BBH8kOj8EsJEhME7TWZ2HRfIQ4Ck6ZsT158tQ=	\N
37	Handida	2OcU7Uk3cHFm/l39s84B4JM2V3Ui/BdaMchRNSOAn7s=	+7 (988) 830-53-99	kubreihappoipoi-6539@yopmail.com	Iu/bYzhwTpI+GiC73kWT/bRNR4ywCOFnBPi+W6kuTpU=	\N
38	Baruko	aWCQf1I8y1QAa/9Z+AnUpoVsmploIBryzqrqfc6PjYw=	+7 (973) 543-45-15	quovugameuce-4871@yopmail.com	wHETMYtfz4BNq+vv6Z1XL4XRXk1LnAhfehUWboXCip0=	\N
39	Ronani	EQ6abVSbBxEWBULAG0VCE8hNeBqD/Q8vawIlzX/VnW0=	+7 (972) 435-41-73	sasseubreukucu-9879@yopmail.com	rdHttIfH4r8eAezlWxbgOvwm1saeLqK99ajOokktP1Q=	\N
40	Dorissal	73FNcIVeaC9MkKr2ozmy9ma2tcvqbkTl69xmMQxKVPs=	+7 (920) 382-65-40	vibabrufaufi-8111@yopmail.com	BffkhqHDGe/hrwya+YERPiRgu0mdxGa0bcNpu1y/z5I=	\N
41	Hanza	MNYqC8dGUNv114B95j0syu9k4RGUS9c9j5tKOjPS2t8=	+7 (996) 240-97-58	trauzennezeipri-4319@yopmail.com	4r5V9KuhYxkHq16u1Dj+rLivO/ee4QZNkx2e7Q58rxo=	\N
42	Phyr	juqysYuL/KbD2vV83BHRvZC0+whTOZvR8WpYHx55390=	+7 (954) 964-34-41	pegaubalakeu-8816@yopmail.com	adqddtYhNtBn/zp19JgDNdCtLKjNIKmCKenJmBmCXvE=	\N
43	Vinahidi	d6TgUKxx3iyqmVWvZO++9r12jd/xfKFLdGtbmX7Baug=	+7 (924) 511-55-94	feulezeigappou-4169@yopmail.com	lx7GZzUDwPnwJTvdHDsOUJsFkIYIpucsDwEnTW/f6To=	\N
44	Hallanch	RJfQGksslkjap3l3QUjBzWReg4MPh6z96uYiW4Xnc5g=	+7 (907) 130-21-90	demmautreinnepri-2424@yopmail.com	ABKrsCWsStepU+O/A+ECGiNfwQmAoge07UhgfftDztQ=	\N
45	Sperian	1fh5Bugli7M3X7w2+8oZxIdRhy0ABgY9r4zFOVJT8sA=	+7 (984) 650-34-96	zucrilolaffe-9476@yopmail.com	UVbWD5UCalPQBUKTz5XxhfnDISf7l42sJ/Dl/fiVeak=	\N
46	Deckeyad	orDdasTlF7IQzhgo8CevTtBrQWiTtBmfuUJhkpm/uzw=	+7 (911) 639-97-67	grougrovessiquau-8247@yopmail.com	xOZNkwWzbccBe+8AGqSagzKnfrQ1SFVLHCU08VUTiyA=	\N
47	Diatus	MbyHeqKCAFK4cCaHC0XbO6FLno/56R5wXoY9DNX/Yxw=	+7 (910) 314-76-42	muzejauceugrou-2339@yopmail.com	Z0o7DbG8pf6T1VrxNR0a4ZwVY6BAd96zc7zXG8W9VGE=	\N
48	Jaim	uxRgi0+b/YqYcAFqJaZMVjh/tF6908W9l0ogL7ysmIQ=	+7 (925) 308-82-79	yoffussoukoiwe-3476@yopmail.com	/7PtHy1BZCiLkKSma6/8X4q6Bv7gqe0hKFIu/TUEfrs=	\N
49	Tsyaa	/w2bK73sSn3uYS1WVXRrrsKz/3JISHcCcaukBxrOQTk=	+7 (990) 447-17-57	cefrouweuttautroi-9502@yopmail.com	eyS3y5R8wiB3JzSXtqcgvy9ypGQsP1IzBnlTodgTH88=	\N
50	Scenturn	EQHO0QgkZThX7pw1M9vdmJ6EOIlbwHTJp1IXrNsf2vA=	+7 (922) 766-85-27	bedeicezuzi-4661@yopmail.com	rw70LYZwF5Nd+S0EOr8tgIR+ZwyOLBg6Ry15SXpObU8=	\N
\.


--
-- Data for Name: UserClub; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserClub" (id, user_id, club_id) FROM stdin;
3	1	1
8	2	1
9	2	2
10	38	11
11	29	22
12	38	24
13	50	28
14	38	43
15	1	42
16	9	39
17	5	28
18	16	1
19	47	1
20	37	29
21	28	1
22	39	18
23	28	20
24	50	12
25	39	11
26	12	29
27	27	30
28	49	47
29	47	35
30	39	27
31	28	46
32	4	39
33	10	23
34	46	18
35	37	49
36	29	4
37	48	50
38	38	50
39	38	39
40	26	38
41	28	20
42	20	21
43	19	20
44	8	37
45	24	38
46	17	38
47	8	16
48	2	28
49	28	39
50	33	8
51	42	7
52	50	6
53	19	2
54	10	1
55	18	4
56	2	3
57	19	5
\.


--
-- Data for Name: UserGame; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserGame" (id, user_id, game_id) FROM stdin;
1	3	48
2	1	19
3	12	17
4	20	32
5	30	29
6	34	23
7	27	41
8	31	50
9	37	42
10	18	15
11	19	12
12	32	10
13	34	8
14	12	7
15	32	34
16	40	2
17	38	15
18	39	18
19	11	12
20	10	21
21	12	38
22	32	29
23	30	31
24	27	40
25	18	30
26	27	20
27	23	9
28	29	44
29	41	3
30	19	1
31	20	12
32	28	19
33	43	12
34	19	32
35	1	42
36	43	49
37	4	23
38	32	12
39	12	32
40	50	10
41	46	2
42	43	7
43	21	16
44	10	12
45	29	23
46	38	34
47	10	32
48	29	10
49	2	2
50	3	1
\.


--
-- Data for Name: UserLog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserLog" (id, user_id, text, date) FROM stdin;
1	16	пользователь организовал турнир	2025-02-28 01:03:00
2	12	пользователь вошёл в систему	2025-05-14 14:27:00
3	49	пользователь присоединился к турниру	2025-05-13 10:05:00
4	29	пользователь вошёл в систему	2025-08-06 22:33:00
5	30	пользователь вошёл в систему	2025-04-05 14:34:00
6	18	пользователь вошёл в систему	2025-01-22 22:53:00
7	17	пользователь присоединился к турниру	2025-04-05 14:34:00
8	42	пользователь организовал турнир	2025-09-10 02:00:00
9	40	пользователь организовал турнир	2025-09-27 19:36:00
10	31	Пользователь поднял свой привилегированный уровень	2025-07-27 18:54:00
11	37	пользователь купил услуги	2025-06-18 14:11:00
12	28	пользователь организовал турнир	2025-01-21 19:39:00
13	23	пользователь присоединился к турниру	2025-01-02 02:18:00
14	18	Пользователь создал клуб	2025-09-17 12:10:00
15	4	Пользователь поднял свой привилегированный уровень 	2025-08-29 21:22:00
16	9	Пользователь поднял свой привилегированный уровень	2025-06-16 22:12:00
17	50	пользователь присоединился к турниру	2025-02-07 23:00:00
18	47	пользователь вошёл в систему	2025-07-05 16:46:00
19	31	пользователь присоединился к турниру	2025-06-09 12:50:00
20	29	пользователь организовал турнир	2025-03-04 12:27:00
21	42	Пользователь создал клуб	2025-01-26 12:16:00
22	39	пользователь вошёл в систему	2025-06-21 20:46:00
23	40	пользователь купил услуги	2025-09-23 00:47:00
24	12	пользователь присоединился к турниру	2025-02-28 19:14:00
25	39	пользователь организовал турнир	2025-01-21 19:39:00
26	27	пользователь присоединился к турниру	2025-06-18 14:11:00
27	37	Пользователь создал клуб	2025-08-13 00:59:00
28	38	Пользователь создал клуб	2025-08-05 08:02:00
29	20	Пользователь создал клуб	2025-08-10 02:12:00
37	1	Пользователь создал клуб	2025-05-09 21:27:00
30	39	пользователь купил услуги	2025-01-02 00:57:00
31	39	пользователь вошёл в систему	2025-02-10 12:28:00
32	37	пользователь вошёл в систему	2025-07-11 16:19:00
33	28	пользователь присоединился к турниру	2025-08-05 08:02:00
34	20	Пользователь поднял свой привилегированный уровень	2025-07-20 07:18:00
35	6	пользователь вошёл в систему	2025-09-23 00:47:00
36	8	пользователь организовал турнир	2025-08-25 08:54:00
38	2	пользователь присоединился к турниру	2025-07-19 03:47:00
39	29	пользователь вошёл в систему	2025-03-12 06:35:00
40	50	пользователь организовал турнир	2025-09-10 15:58:00
41	41	пользователь организовал турнир	2025-06-11 06:56:00
42	45	Пользователь создал клуб	2025-08-13 00:59:00
43	30	пользователь купил услуги	2025-01-21 10:52:00
44	13	пользователь купил услуги	2025-09-23 00:47:00
45	29	пользователь вошёл в систему	2025-08-13 00:59:00
46	2	Пользователь создал клуб	2025-06-18 14:11:00
47	37	пользователь присоединился к турниру	2025-03-14 13:37:00
48	32	пользователь купил услуги	2025-01-02 00:57:00
49	10	Пользователь поднял свой привилегированный уровень	2025-06-18 14:11:00
50	2	Пользователь вошёл в систему	2025-01-02 00:57:00
\.


--
-- Data for Name: UserTournament; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserTournament" (id, user_id, tournament_id, is_notificate) FROM stdin;
1	23	10	t
2	17	27	f
3	18	12	t
4	12	29	t
5	29	43	t
6	10	12	f
7	20	23	f
8	12	38	f
9	27	38	t
10	28	38	t
11	12	12	f
12	43	27	t
13	12	18	f
14	32	12	f
15	28	42	t
16	12	40	t
17	32	49	f
18	27	17	f
19	12	42	t
20	43	27	t
21	12	18	t
22	32	32	t
23	28	20	f
24	9	31	t
25	8	23	t
26	16	26	f
27	19	17	f
28	12	19	f
29	38	43	f
30	36	32	t
31	48	12	f
32	23	9	t
33	41	4	f
34	48	3	t
35	32	12	f
36	50	50	t
37	39	30	t
38	3	39	f
39	41	43	f
40	40	29	f
41	23	19	t
42	3	15	f
43	23	10	t
44	19	9	t
45	5	5	f
46	3	4	t
47	23	12	f
48	19	20	f
49	32	24	t
50	12	21	t
\.


--
-- Name: Admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Admin_id_seq"', 4, true);


--
-- Name: Basket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Basket_id_seq"', 50, true);


--
-- Name: Club_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Club_id_seq"', 51, true);


--
-- Name: Collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Collection_id_seq"', 50, true);


--
-- Name: FreeTime_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."FreeTime_id_seq"', 3, true);


--
-- Name: GameCategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."GameCategory_id_seq"', 50, true);


--
-- Name: Game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Game_id_seq"', 51, true);


--
-- Name: Location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Location_id_seq"', 3, true);


--
-- Name: Message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Message_id_seq"', 52, true);


--
-- Name: News_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."News_id_seq"', 50, true);


--
-- Name: PlayerCollection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PlayerCollection_id_seq"', 50, true);


--
-- Name: PlayerRatingLog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PlayerRatingLog_id_seq"', 104, true);


--
-- Name: PlayerStatus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PlayerStatus_id_seq"', 3, true);


--
-- Name: Player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Player_id_seq"', 52, true);


--
-- Name: Privilege_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Privilege_id_seq"', 3, true);


--
-- Name: ServiceCategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ServiceCategory_id_seq"', 50, true);


--
-- Name: Service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Service_id_seq"', 50, true);


--
-- Name: TournamentCategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."TournamentCategory_id_seq"', 50, true);


--
-- Name: TournamentStatus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."TournamentStatus_id_seq"', 5, true);


--
-- Name: TournamentTheme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."TournamentTheme_id_seq"', 51, true);


--
-- Name: Tournament_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Tournament_id_seq"', 50, true);


--
-- Name: UserClub_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UserClub_id_seq"', 57, true);


--
-- Name: UserGame_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UserGame_id_seq"', 50, true);


--
-- Name: UserLog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UserLog_id_seq"', 50, true);


--
-- Name: UserTournament_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UserTournament_id_seq"', 50, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 53, true);


--
-- Name: Admin Admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Admin"
    ADD CONSTRAINT "Admin_pkey" PRIMARY KEY (id);


--
-- Name: Admin Admin_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Admin"
    ADD CONSTRAINT "Admin_user_id_key" UNIQUE (user_id);


--
-- Name: Basket Basket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Basket"
    ADD CONSTRAINT "Basket_pkey" PRIMARY KEY (id);


--
-- Name: Club Club_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Club"
    ADD CONSTRAINT "Club_pkey" PRIMARY KEY (id);


--
-- Name: Collection Collection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Collection"
    ADD CONSTRAINT "Collection_pkey" PRIMARY KEY (id);


--
-- Name: FreeTime FreeTime_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FreeTime"
    ADD CONSTRAINT "FreeTime_pkey" PRIMARY KEY (id);


--
-- Name: GameCategory GameCategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GameCategory"
    ADD CONSTRAINT "GameCategory_pkey" PRIMARY KEY (id);


--
-- Name: Game Game_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Game"
    ADD CONSTRAINT "Game_pkey" PRIMARY KEY (id);


--
-- Name: Location Location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Location"
    ADD CONSTRAINT "Location_pkey" PRIMARY KEY (id);


--
-- Name: Message Message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_pkey" PRIMARY KEY (id);


--
-- Name: News News_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."News"
    ADD CONSTRAINT "News_pkey" PRIMARY KEY (id);


--
-- Name: PlayerCollection PlayerCollection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PlayerCollection"
    ADD CONSTRAINT "PlayerCollection_pkey" PRIMARY KEY (id);


--
-- Name: PlayerRatingLog PlayerRatingLog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PlayerRatingLog"
    ADD CONSTRAINT "PlayerRatingLog_pkey" PRIMARY KEY (id);


--
-- Name: PlayerStatus PlayerStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PlayerStatus"
    ADD CONSTRAINT "PlayerStatus_pkey" PRIMARY KEY (id);


--
-- Name: Player Player_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Player"
    ADD CONSTRAINT "Player_pkey" PRIMARY KEY (id);


--
-- Name: Player Player_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Player"
    ADD CONSTRAINT "Player_user_id_key" UNIQUE (user_id);


--
-- Name: Privilege Privilege_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Privilege"
    ADD CONSTRAINT "Privilege_pkey" PRIMARY KEY (id);


--
-- Name: ServiceCategory ServiceCategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ServiceCategory"
    ADD CONSTRAINT "ServiceCategory_pkey" PRIMARY KEY (id);


--
-- Name: Service Service_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Service"
    ADD CONSTRAINT "Service_pkey" PRIMARY KEY (id);


--
-- Name: TournamentCategory TournamentCategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TournamentCategory"
    ADD CONSTRAINT "TournamentCategory_pkey" PRIMARY KEY (id);


--
-- Name: TournamentStatus TournamentStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TournamentStatus"
    ADD CONSTRAINT "TournamentStatus_pkey" PRIMARY KEY (id);


--
-- Name: TournamentTheme TournamentTheme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TournamentTheme"
    ADD CONSTRAINT "TournamentTheme_pkey" PRIMARY KEY (id);


--
-- Name: Tournament Tournament_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tournament"
    ADD CONSTRAINT "Tournament_pkey" PRIMARY KEY (id);


--
-- Name: UserClub UserClub_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserClub"
    ADD CONSTRAINT "UserClub_pkey" PRIMARY KEY (id);


--
-- Name: UserGame UserGame_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserGame"
    ADD CONSTRAINT "UserGame_pkey" PRIMARY KEY (id);


--
-- Name: UserLog UserLog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserLog"
    ADD CONSTRAINT "UserLog_pkey" PRIMARY KEY (id);


--
-- Name: UserTournament UserTournament_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserTournament"
    ADD CONSTRAINT "UserTournament_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: User do_create_player; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER do_create_player AFTER INSERT ON public."User" FOR EACH ROW EXECUTE FUNCTION public.create_player();


--
-- Name: UserClub do_update_club_user_count; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER do_update_club_user_count AFTER INSERT OR DELETE OR UPDATE ON public."UserClub" FOR EACH ROW EXECUTE FUNCTION public.update_club_users_count();


--
-- Name: Player do_update_last_activity; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER do_update_last_activity AFTER UPDATE OF is_online_status ON public."Player" FOR EACH ROW EXECUTE FUNCTION public.update_last_activity();


--
-- Name: Player do_update_player_rating_log; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER do_update_player_rating_log BEFORE UPDATE ON public."Player" FOR EACH ROW EXECUTE FUNCTION public.update_player_rating_log();


--
-- Name: Admin Admin_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Admin"
    ADD CONSTRAINT "Admin_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id);


--
-- Name: Basket Basket_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Basket"
    ADD CONSTRAINT "Basket_service_id_fkey" FOREIGN KEY (service_id) REFERENCES public."Service"(id);


--
-- Name: Basket Basket_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Basket"
    ADD CONSTRAINT "Basket_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id);


--
-- Name: Game Game_game_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Game"
    ADD CONSTRAINT "Game_game_category_id_fkey" FOREIGN KEY (game_category_id) REFERENCES public."GameCategory"(id);


--
-- Name: Message Message_user_reciever_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_user_reciever_id_fkey" FOREIGN KEY (user_reciever_id) REFERENCES public."User"(id);


--
-- Name: Message Message_user_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_user_sender_id_fkey" FOREIGN KEY (user_sender_id) REFERENCES public."User"(id);


--
-- Name: PlayerCollection PlayerCollection_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PlayerCollection"
    ADD CONSTRAINT "PlayerCollection_collection_id_fkey" FOREIGN KEY (collection_id) REFERENCES public."Collection"(id);


--
-- Name: PlayerCollection PlayerCollection_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PlayerCollection"
    ADD CONSTRAINT "PlayerCollection_player_id_fkey" FOREIGN KEY (player_id) REFERENCES public."Player"(id);


--
-- Name: PlayerRatingLog PlayerRatingLog_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PlayerRatingLog"
    ADD CONSTRAINT "PlayerRatingLog_player_id_fkey" FOREIGN KEY (player_id) REFERENCES public."Player"(id);


--
-- Name: Player Player_free_time_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Player"
    ADD CONSTRAINT "Player_free_time_fkey" FOREIGN KEY (free_time_id) REFERENCES public."FreeTime"(id);


--
-- Name: Player Player_player_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Player"
    ADD CONSTRAINT "Player_player_status_id_fkey" FOREIGN KEY (player_status_id) REFERENCES public."PlayerStatus"(id);


--
-- Name: Player Player_privilege_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Player"
    ADD CONSTRAINT "Player_privilege_id_fkey" FOREIGN KEY (privilege_id) REFERENCES public."Privilege"(id);


--
-- Name: Player Player_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Player"
    ADD CONSTRAINT "Player_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id);


--
-- Name: Service Service_service_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Service"
    ADD CONSTRAINT "Service_service_category_id_fkey" FOREIGN KEY (service_category_id) REFERENCES public."ServiceCategory"(id);


--
-- Name: Tournament Tournament_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tournament"
    ADD CONSTRAINT "Tournament_game_id_fkey" FOREIGN KEY (game_id) REFERENCES public."Game"(id);


--
-- Name: Tournament Tournament_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tournament"
    ADD CONSTRAINT "Tournament_location_id_fkey" FOREIGN KEY (location_id) REFERENCES public."Location"(id);


--
-- Name: Tournament Tournament_player_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tournament"
    ADD CONSTRAINT "Tournament_player_status_id_fkey" FOREIGN KEY (player_status_id) REFERENCES public."PlayerStatus"(id);


--
-- Name: Tournament Tournament_tournament_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tournament"
    ADD CONSTRAINT "Tournament_tournament_category_id_fkey" FOREIGN KEY (tournament_category_id) REFERENCES public."TournamentCategory"(id);


--
-- Name: Tournament Tournament_tournament_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tournament"
    ADD CONSTRAINT "Tournament_tournament_status_id_fkey" FOREIGN KEY (tournament_status_id) REFERENCES public."TournamentStatus"(id);


--
-- Name: Tournament Tournament_tournament_theme_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tournament"
    ADD CONSTRAINT "Tournament_tournament_theme_id_fkey" FOREIGN KEY (tournament_theme_id) REFERENCES public."TournamentTheme"(id);


--
-- Name: UserClub UserClub_club_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserClub"
    ADD CONSTRAINT "UserClub_club_id_fkey" FOREIGN KEY (club_id) REFERENCES public."Club"(id);


--
-- Name: UserClub UserClub_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserClub"
    ADD CONSTRAINT "UserClub_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id);


--
-- Name: UserGame UserGame_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserGame"
    ADD CONSTRAINT "UserGame_game_id_fkey" FOREIGN KEY (game_id) REFERENCES public."Game"(id);


--
-- Name: UserGame UserGame_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserGame"
    ADD CONSTRAINT "UserGame_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id);


--
-- Name: UserLog UserLog_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserLog"
    ADD CONSTRAINT "UserLog_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id);


--
-- Name: UserTournament UserTournament_tournament_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserTournament"
    ADD CONSTRAINT "UserTournament_tournament_id_fkey" FOREIGN KEY (tournament_id) REFERENCES public."Tournament"(id);


--
-- Name: UserTournament UserTournament_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserTournament"
    ADD CONSTRAINT "UserTournament_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id);


--
-- Name: TABLE "Admin"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Admin" TO manager;


--
-- Name: SEQUENCE "Admin_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."Admin_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."Admin_id_seq" TO creator;


--
-- Name: TABLE "Basket"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Basket" TO manager;


--
-- Name: SEQUENCE "Basket_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."Basket_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."Basket_id_seq" TO creator;


--
-- Name: TABLE "Club"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Club" TO manager;


--
-- Name: SEQUENCE "Club_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."Club_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."Club_id_seq" TO creator;


--
-- Name: TABLE "Collection"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Collection" TO manager;


--
-- Name: SEQUENCE "Collection_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."Collection_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."Collection_id_seq" TO creator;


--
-- Name: TABLE "FreeTime"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."FreeTime" TO manager;


--
-- Name: SEQUENCE "FreeTime_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."FreeTime_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."FreeTime_id_seq" TO creator;


--
-- Name: TABLE "Game"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Game" TO manager;


--
-- Name: TABLE "GameCategory"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."GameCategory" TO manager;


--
-- Name: SEQUENCE "GameCategory_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."GameCategory_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."GameCategory_id_seq" TO creator;


--
-- Name: SEQUENCE "Game_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."Game_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."Game_id_seq" TO creator;


--
-- Name: TABLE "Location"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Location" TO manager;


--
-- Name: SEQUENCE "Location_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."Location_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."Location_id_seq" TO creator;


--
-- Name: TABLE "Message"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Message" TO manager;


--
-- Name: SEQUENCE "Message_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."Message_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."Message_id_seq" TO creator;


--
-- Name: TABLE "News"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."News" TO manager;


--
-- Name: SEQUENCE "News_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."News_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."News_id_seq" TO creator;


--
-- Name: TABLE "Player"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Player" TO manager;


--
-- Name: TABLE "PlayerCollection"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."PlayerCollection" TO manager;


--
-- Name: SEQUENCE "PlayerCollection_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."PlayerCollection_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."PlayerCollection_id_seq" TO creator;


--
-- Name: TABLE "PlayerRatingLog"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."PlayerRatingLog" TO manager;


--
-- Name: SEQUENCE "PlayerRatingLog_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."PlayerRatingLog_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."PlayerRatingLog_id_seq" TO creator;


--
-- Name: TABLE "PlayerStatus"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."PlayerStatus" TO manager;


--
-- Name: SEQUENCE "PlayerStatus_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."PlayerStatus_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."PlayerStatus_id_seq" TO creator;


--
-- Name: SEQUENCE "Player_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."Player_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."Player_id_seq" TO creator;


--
-- Name: TABLE "Privilege"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Privilege" TO manager;


--
-- Name: SEQUENCE "Privilege_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."Privilege_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."Privilege_id_seq" TO creator;


--
-- Name: TABLE "Service"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Service" TO manager;


--
-- Name: TABLE "ServiceCategory"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."ServiceCategory" TO manager;


--
-- Name: SEQUENCE "ServiceCategory_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."ServiceCategory_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."ServiceCategory_id_seq" TO creator;


--
-- Name: SEQUENCE "Service_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."Service_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."Service_id_seq" TO creator;


--
-- Name: TABLE "Tournament"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Tournament" TO manager;


--
-- Name: TABLE "TournamentCategory"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."TournamentCategory" TO manager;


--
-- Name: SEQUENCE "TournamentCategory_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."TournamentCategory_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."TournamentCategory_id_seq" TO creator;


--
-- Name: TABLE "TournamentStatus"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."TournamentStatus" TO manager;


--
-- Name: SEQUENCE "TournamentStatus_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."TournamentStatus_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."TournamentStatus_id_seq" TO creator;


--
-- Name: TABLE "TournamentTheme"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."TournamentTheme" TO manager;


--
-- Name: SEQUENCE "TournamentTheme_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."TournamentTheme_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."TournamentTheme_id_seq" TO creator;


--
-- Name: SEQUENCE "Tournament_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."Tournament_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."Tournament_id_seq" TO creator;


--
-- Name: TABLE "User"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."User" TO manager;


--
-- Name: TABLE "UserClub"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."UserClub" TO manager;


--
-- Name: SEQUENCE "UserClub_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."UserClub_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."UserClub_id_seq" TO creator;


--
-- Name: TABLE "UserGame"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."UserGame" TO manager;


--
-- Name: SEQUENCE "UserGame_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."UserGame_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."UserGame_id_seq" TO creator;


--
-- Name: TABLE "UserLog"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."UserLog" TO manager;


--
-- Name: SEQUENCE "UserLog_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."UserLog_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."UserLog_id_seq" TO creator;


--
-- Name: TABLE "UserTournament"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."UserTournament" TO manager;


--
-- Name: SEQUENCE "UserTournament_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."UserTournament_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."UserTournament_id_seq" TO creator;


--
-- Name: SEQUENCE "User_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public."User_id_seq" TO manager;
GRANT SELECT ON SEQUENCE public."User_id_seq" TO creator;


--
-- Name: TABLE tournament_view; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tournament_view TO manager;


--
-- Name: TABLE user_view; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_view TO manager;


--
-- PostgreSQL database dump complete
--

\unrestrict 8RekpAwBylto0iSruLibTo4IRztpRq8A4jBfc0kTUWNygRw9Ix8dIs4UnzjhrId

