--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

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
-- Name: auto_update_time_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.auto_update_time_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    new.update_time = current_timestamp;
    return new;
end ;
$$;


ALTER FUNCTION public.auto_update_time_trigger() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: general_field; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.general_field (
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.general_field OWNER TO postgres;

--
-- Name: TABLE general_field; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.general_field IS '通用字段表，主要用于继承';


--
-- Name: COLUMN general_field.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.general_field.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN general_field.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.general_field.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN general_field.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.general_field.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: tb_approval; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_approval (
    id bigint NOT NULL,
    opening_plan_id bigint NOT NULL,
    textbook_ids character varying(100) NOT NULL,
    teaching_group_state smallint DEFAULT 0 NOT NULL,
    teaching_group_message character varying(100),
    secondary_college_state smallint DEFAULT 0 NOT NULL,
    secondary_college_message character varying(100),
    deans_office_state smallint DEFAULT 0 NOT NULL,
    deans_office_message character varying(100),
    state smallint DEFAULT 0 NOT NULL,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_approval OWNER TO postgres;

--
-- Name: TABLE tb_approval; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_approval IS '审批';


--
-- Name: COLUMN tb_approval.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_approval.id IS '主键id';


--
-- Name: COLUMN tb_approval.opening_plan_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_approval.opening_plan_id IS '开课计划id';


--
-- Name: COLUMN tb_approval.textbook_ids; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_approval.textbook_ids IS '教材ids';


--
-- Name: COLUMN tb_approval.teaching_group_state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_approval.teaching_group_state IS '教学组审批状态 0(未审批) 1(通过) 2(驳回)';


--
-- Name: COLUMN tb_approval.teaching_group_message; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_approval.teaching_group_message IS '教学组审批信息';


--
-- Name: COLUMN tb_approval.secondary_college_state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_approval.secondary_college_state IS '二级学院审批状态 0(未审批) 1(通过) 2(驳回)';


--
-- Name: COLUMN tb_approval.secondary_college_message; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_approval.secondary_college_message IS '二级学院审批信息';


--
-- Name: COLUMN tb_approval.deans_office_state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_approval.deans_office_state IS '教务处审批状态 0(未审批) 1(通过) 2(驳回)';


--
-- Name: COLUMN tb_approval.deans_office_message; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_approval.deans_office_message IS '教务处审批信息';


--
-- Name: COLUMN tb_approval.state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_approval.state IS '状态 默认0(教学组审批中) 1(二级审批中) 2(教务处审批中) 3(审批通过) 4(拒绝，驳回)';


--
-- Name: COLUMN tb_approval.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_approval.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_approval.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_approval.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_approval.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_approval.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: tb_approval_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_approval_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_approval_id_seq OWNER TO postgres;

--
-- Name: tb_approval_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_approval_id_seq OWNED BY public.tb_approval.id;


--
-- Name: tb_user_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_user_info (
    id bigint NOT NULL,
    user_faculty_id bigint NOT NULL,
    sex smallint NOT NULL,
    birthday timestamp(0) without time zone,
    address character varying(30),
    email character varying(20),
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_user_info OWNER TO postgres;

--
-- Name: TABLE tb_user_info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_user_info IS '用户信息';


--
-- Name: COLUMN tb_user_info.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user_info.id IS '主键id';


--
-- Name: COLUMN tb_user_info.user_faculty_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user_info.user_faculty_id IS '教职工用户表id';


--
-- Name: COLUMN tb_user_info.sex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user_info.sex IS '性别 0(女) 1(男) 2(未知)';


--
-- Name: COLUMN tb_user_info.birthday; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user_info.birthday IS '生日';


--
-- Name: COLUMN tb_user_info.address; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user_info.address IS '地址';


--
-- Name: COLUMN tb_user_info.email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user_info.email IS '邮箱';


--
-- Name: COLUMN tb_user_info.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user_info.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_user_info.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user_info.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_user_info.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user_info.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: tb_faculty_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_faculty_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_faculty_info_id_seq OWNER TO postgres;

--
-- Name: tb_faculty_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_faculty_info_id_seq OWNED BY public.tb_user_info.id;


--
-- Name: tb_user_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_user_role (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    role_id bigint NOT NULL,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_user_role OWNER TO postgres;

--
-- Name: TABLE tb_user_role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_user_role IS '角色权限';


--
-- Name: COLUMN tb_user_role.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user_role.id IS '主键id';


--
-- Name: COLUMN tb_user_role.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user_role.user_id IS '用户id';


--
-- Name: COLUMN tb_user_role.role_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user_role.role_id IS '角色id';


--
-- Name: COLUMN tb_user_role.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user_role.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_user_role.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user_role.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_user_role.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user_role.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: tb_faculty_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_faculty_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_faculty_role_id_seq OWNER TO postgres;

--
-- Name: tb_faculty_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_faculty_role_id_seq OWNED BY public.tb_user_role.id;


--
-- Name: tb_grade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_grade (
    id bigint NOT NULL,
    major_id bigint NOT NULL,
    year smallint NOT NULL,
    number character varying(10) NOT NULL,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_grade OWNER TO postgres;

--
-- Name: TABLE tb_grade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_grade IS '班级';


--
-- Name: COLUMN tb_grade.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_grade.id IS '主键id';


--
-- Name: COLUMN tb_grade.major_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_grade.major_id IS '专业id';


--
-- Name: COLUMN tb_grade.year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_grade.year IS '年级 如(2019,2020,2021..)';


--
-- Name: COLUMN tb_grade.number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_grade.number IS '班级序号 如(1,2,3,1A,1B,2A,2B..)';


--
-- Name: COLUMN tb_grade.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_grade.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_grade.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_grade.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_grade.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_grade.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: tb_grade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_grade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_grade_id_seq OWNER TO postgres;

--
-- Name: tb_grade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_grade_id_seq OWNED BY public.tb_grade.id;


--
-- Name: tb_login_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_login_log (
    id bigint NOT NULL,
    account character varying(20) NOT NULL,
    ip character varying(128) NOT NULL,
    state smallint NOT NULL,
    message character varying(20),
    access_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL,
    browser character varying(100) NOT NULL,
    os character varying(100),
    login_location character varying(200)
);


ALTER TABLE public.tb_login_log OWNER TO postgres;

--
-- Name: TABLE tb_login_log; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_login_log IS '登录日志';


--
-- Name: COLUMN tb_login_log.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_login_log.id IS '主键id';


--
-- Name: COLUMN tb_login_log.account; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_login_log.account IS '用户名';


--
-- Name: COLUMN tb_login_log.ip; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_login_log.ip IS '登录ip地址';


--
-- Name: COLUMN tb_login_log.state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_login_log.state IS '登录状态 0成功 1失败';


--
-- Name: COLUMN tb_login_log.message; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_login_log.message IS '提示信息';


--
-- Name: COLUMN tb_login_log.access_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_login_log.access_time IS '访问时间';


--
-- Name: COLUMN tb_login_log.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_login_log.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_login_log.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_login_log.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_login_log.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_login_log.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: COLUMN tb_login_log.browser; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_login_log.browser IS '浏览器';


--
-- Name: COLUMN tb_login_log.os; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_login_log.os IS '操作系统';


--
-- Name: COLUMN tb_login_log.login_location; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_login_log.login_location IS '登陆地点';


--
-- Name: tb_login_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_login_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_login_log_id_seq OWNER TO postgres;

--
-- Name: tb_login_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_login_log_id_seq OWNED BY public.tb_login_log.id;


--
-- Name: tb_major; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_major (
    id bigint NOT NULL,
    name character varying(20) NOT NULL,
    secondary_college_id bigint NOT NULL,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_major OWNER TO postgres;

--
-- Name: TABLE tb_major; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_major IS '专业';


--
-- Name: COLUMN tb_major.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_major.id IS '主键id';


--
-- Name: COLUMN tb_major.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_major.name IS '专业名';


--
-- Name: COLUMN tb_major.secondary_college_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_major.secondary_college_id IS '二级学院id';


--
-- Name: COLUMN tb_major.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_major.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_major.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_major.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_major.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_major.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: tb_major_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_major_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_major_id_seq OWNER TO postgres;

--
-- Name: tb_major_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_major_id_seq OWNED BY public.tb_major.id;


--
-- Name: tb_opening_plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_opening_plan (
    id bigint NOT NULL,
    secondary_college_id bigint NOT NULL,
    teacher_id bigint NOT NULL,
    grade_id bigint NOT NULL,
    teaching_group_id bigint NOT NULL,
    state smallint DEFAULT 0 NOT NULL,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_opening_plan OWNER TO postgres;

--
-- Name: TABLE tb_opening_plan; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_opening_plan IS '开课计划';


--
-- Name: COLUMN tb_opening_plan.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan.id IS '主键id';


--
-- Name: COLUMN tb_opening_plan.secondary_college_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan.secondary_college_id IS '二级院校id';


--
-- Name: COLUMN tb_opening_plan.teacher_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan.teacher_id IS '教师id';


--
-- Name: COLUMN tb_opening_plan.grade_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan.grade_id IS '班级id';


--
-- Name: COLUMN tb_opening_plan.teaching_group_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan.teaching_group_id IS '教学组id';


--
-- Name: COLUMN tb_opening_plan.state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan.state IS '状态 0(等待教师选定教材) 1(已经选定教材，等待审批) 2(审批完成，close)';


--
-- Name: COLUMN tb_opening_plan.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_opening_plan.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_opening_plan.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: tb_opening_plan_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_opening_plan_detail (
    id bigint NOT NULL,
    opening_plan_id bigint NOT NULL,
    course_name character varying(50) NOT NULL,
    credit integer NOT NULL,
    teaching_hours integer NOT NULL,
    weeks_teach integer NOT NULL,
    type smallint NOT NULL,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_opening_plan_detail OWNER TO postgres;

--
-- Name: TABLE tb_opening_plan_detail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_opening_plan_detail IS '开课计划详情';


--
-- Name: COLUMN tb_opening_plan_detail.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan_detail.id IS '主键id';


--
-- Name: COLUMN tb_opening_plan_detail.opening_plan_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan_detail.opening_plan_id IS '开课计划id';


--
-- Name: COLUMN tb_opening_plan_detail.course_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan_detail.course_name IS '课程名';


--
-- Name: COLUMN tb_opening_plan_detail.credit; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan_detail.credit IS '学分';


--
-- Name: COLUMN tb_opening_plan_detail.teaching_hours; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan_detail.teaching_hours IS '总课时';


--
-- Name: COLUMN tb_opening_plan_detail.weeks_teach; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan_detail.weeks_teach IS '教学周数';


--
-- Name: COLUMN tb_opening_plan_detail.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan_detail.type IS '类型 0(考试) 1(考察)';


--
-- Name: COLUMN tb_opening_plan_detail.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan_detail.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_opening_plan_detail.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan_detail.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_opening_plan_detail.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_opening_plan_detail.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: tb_opening_plan_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_opening_plan_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_opening_plan_detail_id_seq OWNER TO postgres;

--
-- Name: tb_opening_plan_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_opening_plan_detail_id_seq OWNED BY public.tb_opening_plan_detail.id;


--
-- Name: tb_opening_plan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_opening_plan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_opening_plan_id_seq OWNER TO postgres;

--
-- Name: tb_opening_plan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_opening_plan_id_seq OWNED BY public.tb_opening_plan.id;


--
-- Name: tb_operate_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_operate_log (
    id bigint NOT NULL,
    title character varying(50),
    business_type smallint,
    method character varying(100),
    request_method character varying(10),
    operator_name character varying(50),
    operate_url character varying(255),
    operate_ip character varying(128),
    operate_param character varying(2000),
    json_result character varying(2000),
    status smallint,
    error_msg character varying(2000),
    operate_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_operate_log OWNER TO postgres;

--
-- Name: TABLE tb_operate_log; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_operate_log IS '操作日志';


--
-- Name: COLUMN tb_operate_log.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_operate_log.id IS '主键';


--
-- Name: COLUMN tb_operate_log.title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_operate_log.title IS '模块标题';


--
-- Name: COLUMN tb_operate_log.business_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_operate_log.business_type IS '业务类型（0其它 1新增 2修改 3删除 4导出）';


--
-- Name: COLUMN tb_operate_log.method; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_operate_log.method IS '方法名称';


--
-- Name: COLUMN tb_operate_log.request_method; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_operate_log.request_method IS '请求方式';


--
-- Name: COLUMN tb_operate_log.operator_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_operate_log.operator_name IS '操作人员';


--
-- Name: COLUMN tb_operate_log.operate_url; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_operate_log.operate_url IS '请求URL';


--
-- Name: COLUMN tb_operate_log.operate_ip; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_operate_log.operate_ip IS '主机地址';


--
-- Name: COLUMN tb_operate_log.operate_param; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_operate_log.operate_param IS '请求参数';


--
-- Name: COLUMN tb_operate_log.json_result; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_operate_log.json_result IS '返回参数';


--
-- Name: COLUMN tb_operate_log.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_operate_log.status IS '操作状态（0正常 1异常）';


--
-- Name: COLUMN tb_operate_log.error_msg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_operate_log.error_msg IS '错误消息';


--
-- Name: COLUMN tb_operate_log.operate_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_operate_log.operate_time IS '操作时间';


--
-- Name: COLUMN tb_operate_log.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_operate_log.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_operate_log.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_operate_log.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_operate_log.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_operate_log.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: tb_operate_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_operate_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_operate_log_id_seq OWNER TO postgres;

--
-- Name: tb_operate_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_operate_log_id_seq OWNED BY public.tb_operate_log.id;


--
-- Name: tb_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_permission (
    id bigint NOT NULL,
    parent_id bigint DEFAULT 0 NOT NULL,
    path character varying(30),
    request_url character varying(30),
    name character varying(20) NOT NULL,
    perms character varying(100),
    icon character varying(100),
    component character varying(100),
    type smallint DEFAULT 0 NOT NULL,
    state smallint DEFAULT 0 NOT NULL,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_permission OWNER TO postgres;

--
-- Name: TABLE tb_permission; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_permission IS '权限';


--
-- Name: COLUMN tb_permission.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_permission.id IS '主键id';


--
-- Name: COLUMN tb_permission.parent_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_permission.parent_id IS '上级id';


--
-- Name: COLUMN tb_permission.path; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_permission.path IS '路由地址';


--
-- Name: COLUMN tb_permission.request_url; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_permission.request_url IS '请求路径';


--
-- Name: COLUMN tb_permission.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_permission.name IS '名称';


--
-- Name: COLUMN tb_permission.perms; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_permission.perms IS '权限标识';


--
-- Name: COLUMN tb_permission.icon; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_permission.icon IS '图标';


--
-- Name: COLUMN tb_permission.component; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_permission.component IS '组件路径';


--
-- Name: COLUMN tb_permission.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_permission.type IS '类型 0目录 1路由 2按钮or请求';


--
-- Name: COLUMN tb_permission.state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_permission.state IS '状态 默认0(正常) 1(停用)';


--
-- Name: COLUMN tb_permission.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_permission.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_permission.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_permission.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_permission.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_permission.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: tb_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_permission_id_seq OWNER TO postgres;

--
-- Name: tb_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_permission_id_seq OWNED BY public.tb_permission.id;


--
-- Name: tb_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_role (
    id bigint NOT NULL,
    name character varying(20) NOT NULL,
    description character varying(20),
    state smallint DEFAULT 0 NOT NULL,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_role OWNER TO postgres;

--
-- Name: TABLE tb_role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_role IS '角色';


--
-- Name: COLUMN tb_role.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_role.id IS '主键id';


--
-- Name: COLUMN tb_role.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_role.name IS '角色名';


--
-- Name: COLUMN tb_role.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_role.description IS '描述';


--
-- Name: COLUMN tb_role.state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_role.state IS '状态 默认0(正常) 1(停用)';


--
-- Name: COLUMN tb_role.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_role.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_role.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_role.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_role.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_role.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: tb_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_role_id_seq OWNER TO postgres;

--
-- Name: tb_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_role_id_seq OWNED BY public.tb_role.id;


--
-- Name: tb_role_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_role_permission (
    id bigint NOT NULL,
    role_id bigint NOT NULL,
    permission_id bigint NOT NULL,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_role_permission OWNER TO postgres;

--
-- Name: TABLE tb_role_permission; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_role_permission IS '角色权限';


--
-- Name: COLUMN tb_role_permission.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_role_permission.id IS '主键id';


--
-- Name: COLUMN tb_role_permission.role_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_role_permission.role_id IS '角色id';


--
-- Name: COLUMN tb_role_permission.permission_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_role_permission.permission_id IS '权限id';


--
-- Name: COLUMN tb_role_permission.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_role_permission.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_role_permission.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_role_permission.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_role_permission.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_role_permission.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: tb_role_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_role_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_role_permission_id_seq OWNER TO postgres;

--
-- Name: tb_role_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_role_permission_id_seq OWNED BY public.tb_role_permission.id;


--
-- Name: tb_secondary_college; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_secondary_college (
    id bigint NOT NULL,
    name character varying(30) NOT NULL,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_secondary_college OWNER TO postgres;

--
-- Name: TABLE tb_secondary_college; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_secondary_college IS '教学组';


--
-- Name: COLUMN tb_secondary_college.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_secondary_college.id IS '主键id';


--
-- Name: COLUMN tb_secondary_college.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_secondary_college.name IS '教学组名';


--
-- Name: COLUMN tb_secondary_college.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_secondary_college.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_secondary_college.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_secondary_college.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_secondary_college.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_secondary_college.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: tb_secondary_college_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_secondary_college_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_secondary_college_id_seq OWNER TO postgres;

--
-- Name: tb_secondary_college_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_secondary_college_id_seq OWNED BY public.tb_secondary_college.id;


--
-- Name: tb_supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_supplier (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    contact_number character varying(20),
    email character varying(50),
    address character varying(50),
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_supplier OWNER TO postgres;

--
-- Name: TABLE tb_supplier; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_supplier IS '供应商';


--
-- Name: COLUMN tb_supplier.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_supplier.id IS '主键id';


--
-- Name: COLUMN tb_supplier.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_supplier.name IS '供应商名';


--
-- Name: COLUMN tb_supplier.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_supplier.description IS '描述';


--
-- Name: COLUMN tb_supplier.contact_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_supplier.contact_number IS '联系电话';


--
-- Name: COLUMN tb_supplier.email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_supplier.email IS '邮箱';


--
-- Name: COLUMN tb_supplier.address; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_supplier.address IS '地址';


--
-- Name: COLUMN tb_supplier.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_supplier.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_supplier.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_supplier.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_supplier.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_supplier.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志为主键id';


--
-- Name: tb_supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_supplier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_supplier_id_seq OWNER TO postgres;

--
-- Name: tb_supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_supplier_id_seq OWNED BY public.tb_supplier.id;


--
-- Name: tb_teaching_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_teaching_group (
    id bigint NOT NULL,
    name character varying(30) NOT NULL,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_teaching_group OWNER TO postgres;

--
-- Name: COLUMN tb_teaching_group.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_teaching_group.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_teaching_group.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_teaching_group.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_teaching_group.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_teaching_group.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: tb_teaching_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_teaching_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_teaching_group_id_seq OWNER TO postgres;

--
-- Name: tb_teaching_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_teaching_group_id_seq OWNED BY public.tb_teaching_group.id;


--
-- Name: tb_textbook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_textbook (
    id bigint NOT NULL,
    book_name character varying(80),
    isbn character varying(30),
    bar_code character varying(30),
    author character varying(100),
    binding character varying(10),
    print character varying(10),
    folio character varying(10),
    price character varying(20),
    words character varying(10),
    publishing_house character varying(20),
    page_number integer,
    issue_number character varying(20),
    pre_packet_number integer,
    publication_date date,
    img_url character varying(70),
    description text,
    state smallint DEFAULT 2 NOT NULL,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL,
    stock integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_textbook OWNER TO postgres;

--
-- Name: TABLE tb_textbook; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_textbook IS '教材';


--
-- Name: COLUMN tb_textbook.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.id IS '主键id';


--
-- Name: COLUMN tb_textbook.book_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.book_name IS '书名';


--
-- Name: COLUMN tb_textbook.isbn; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.isbn IS 'ISBN码';


--
-- Name: COLUMN tb_textbook.bar_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.bar_code IS '条码';


--
-- Name: COLUMN tb_textbook.author; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.author IS '作者';


--
-- Name: COLUMN tb_textbook.binding; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.binding IS '装订';


--
-- Name: COLUMN tb_textbook.print; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.print IS '印次';


--
-- Name: COLUMN tb_textbook.folio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.folio IS '开本';


--
-- Name: COLUMN tb_textbook.price; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.price IS '定价';


--
-- Name: COLUMN tb_textbook.words; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.words IS '字数';


--
-- Name: COLUMN tb_textbook.publishing_house; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.publishing_house IS '出版社';


--
-- Name: COLUMN tb_textbook.page_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.page_number IS '页数';


--
-- Name: COLUMN tb_textbook.issue_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.issue_number IS '发行编号';


--
-- Name: COLUMN tb_textbook.pre_packet_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.pre_packet_number IS '每包册数';


--
-- Name: COLUMN tb_textbook.publication_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.publication_date IS '出版日期';


--
-- Name: COLUMN tb_textbook.img_url; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.img_url IS '封面图片地址';


--
-- Name: COLUMN tb_textbook.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.description IS '描述';


--
-- Name: COLUMN tb_textbook.state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.state IS '状态 默认0(正常) 1(库存不足) 2(审核中) 3(弃用)';


--
-- Name: COLUMN tb_textbook.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.create_time IS '创建时间，默认当前时间，不需要手动设置';


--
-- Name: COLUMN tb_textbook.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_textbook.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志为主键id';


--
-- Name: COLUMN tb_textbook.stock; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook.stock IS '库存';


--
-- Name: tb_textbook_feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_textbook_feedback (
    id bigint NOT NULL,
    student_id bigint NOT NULL,
    textbook_id bigint NOT NULL,
    images character varying(300),
    message character varying(100) NOT NULL,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_textbook_feedback OWNER TO postgres;

--
-- Name: TABLE tb_textbook_feedback; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_textbook_feedback IS '教材反馈';


--
-- Name: COLUMN tb_textbook_feedback.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook_feedback.id IS '主键id';


--
-- Name: COLUMN tb_textbook_feedback.student_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook_feedback.student_id IS '学生用户id';


--
-- Name: COLUMN tb_textbook_feedback.textbook_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook_feedback.textbook_id IS '教材id';


--
-- Name: COLUMN tb_textbook_feedback.images; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook_feedback.images IS '图片 以，分割';


--
-- Name: COLUMN tb_textbook_feedback.message; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook_feedback.message IS '反馈信息';


--
-- Name: COLUMN tb_textbook_feedback.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook_feedback.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_textbook_feedback.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook_feedback.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_textbook_feedback.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook_feedback.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: tb_textbook_feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_textbook_feedback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_textbook_feedback_id_seq OWNER TO postgres;

--
-- Name: tb_textbook_feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_textbook_feedback_id_seq OWNED BY public.tb_textbook_feedback.id;


--
-- Name: tb_textbook_order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_textbook_order (
    id bigint NOT NULL,
    textbook_id bigint NOT NULL,
    supplier_id bigint,
    state smallint NOT NULL,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tb_textbook_order OWNER TO postgres;

--
-- Name: TABLE tb_textbook_order; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_textbook_order IS '教材订单';


--
-- Name: COLUMN tb_textbook_order.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook_order.id IS '主键id';


--
-- Name: COLUMN tb_textbook_order.textbook_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook_order.textbook_id IS '教材id';


--
-- Name: COLUMN tb_textbook_order.supplier_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook_order.supplier_id IS '供应商id(可以为空)';


--
-- Name: COLUMN tb_textbook_order.state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook_order.state IS '状态 0(采购中) 1(已到货) 2(已入库) 3(发放中) 4(已经发放)';


--
-- Name: COLUMN tb_textbook_order.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook_order.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_textbook_order.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook_order.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_textbook_order.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_textbook_order.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: tb_textbook_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_textbook_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_textbook_order_id_seq OWNER TO postgres;

--
-- Name: tb_textbook_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_textbook_order_id_seq OWNED BY public.tb_textbook_order.id;


--
-- Name: tb_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_user (
    id bigint NOT NULL,
    account character varying(20),
    password character varying(50),
    phone_number character varying(20),
    teaching_group_id bigint,
    secondary_college_id bigint,
    name character varying(20) NOT NULL,
    icon character varying(30),
    state smallint DEFAULT 0 NOT NULL,
    create_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted bigint DEFAULT 0 NOT NULL,
    grade_id bigint,
    introduction character varying(100)
);


ALTER TABLE public.tb_user OWNER TO postgres;

--
-- Name: TABLE tb_user; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tb_user IS '教职工用户';


--
-- Name: COLUMN tb_user.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user.id IS '主键id';


--
-- Name: COLUMN tb_user.account; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user.account IS '账号(教职工号)';


--
-- Name: COLUMN tb_user.password; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user.password IS '密码';


--
-- Name: COLUMN tb_user.phone_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user.phone_number IS '手机号码';


--
-- Name: COLUMN tb_user.teaching_group_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user.teaching_group_id IS '教学组id';


--
-- Name: COLUMN tb_user.secondary_college_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user.secondary_college_id IS '二级学院id';


--
-- Name: COLUMN tb_user.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user.name IS '姓名';


--
-- Name: COLUMN tb_user.icon; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user.icon IS '头像';


--
-- Name: COLUMN tb_user.state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user.state IS '状态 默认0(正常),1(封禁)';


--
-- Name: COLUMN tb_user.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user.create_time IS '创建时间，默认为当前时间，不需要手动设置';


--
-- Name: COLUMN tb_user.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user.update_time IS '更新时间，默认为当前时间，可以使用触发器来进行自动更新';


--
-- Name: COLUMN tb_user.is_deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user.is_deleted IS '逻辑删除标志位，默认为0代表未删除，删除标志建议为主键id';


--
-- Name: COLUMN tb_user.grade_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tb_user.grade_id IS '班级id';


--
-- Name: tb_user_faculty_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_user_faculty_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_user_faculty_id_seq OWNER TO postgres;

--
-- Name: tb_user_faculty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_user_faculty_id_seq OWNED BY public.tb_user.id;


--
-- Name: textbook_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.textbook_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.textbook_id_seq OWNER TO postgres;

--
-- Name: textbook_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.textbook_id_seq OWNED BY public.tb_textbook.id;


--
-- Name: tb_approval id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_approval ALTER COLUMN id SET DEFAULT nextval('public.tb_approval_id_seq'::regclass);


--
-- Name: tb_grade id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_grade ALTER COLUMN id SET DEFAULT nextval('public.tb_grade_id_seq'::regclass);


--
-- Name: tb_login_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_login_log ALTER COLUMN id SET DEFAULT nextval('public.tb_login_log_id_seq'::regclass);


--
-- Name: tb_major id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_major ALTER COLUMN id SET DEFAULT nextval('public.tb_major_id_seq'::regclass);


--
-- Name: tb_opening_plan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_opening_plan ALTER COLUMN id SET DEFAULT nextval('public.tb_opening_plan_id_seq'::regclass);


--
-- Name: tb_opening_plan_detail id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_opening_plan_detail ALTER COLUMN id SET DEFAULT nextval('public.tb_opening_plan_detail_id_seq'::regclass);


--
-- Name: tb_operate_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_operate_log ALTER COLUMN id SET DEFAULT nextval('public.tb_operate_log_id_seq'::regclass);


--
-- Name: tb_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_permission ALTER COLUMN id SET DEFAULT nextval('public.tb_permission_id_seq'::regclass);


--
-- Name: tb_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_role ALTER COLUMN id SET DEFAULT nextval('public.tb_role_id_seq'::regclass);


--
-- Name: tb_role_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_role_permission ALTER COLUMN id SET DEFAULT nextval('public.tb_role_permission_id_seq'::regclass);


--
-- Name: tb_secondary_college id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_secondary_college ALTER COLUMN id SET DEFAULT nextval('public.tb_secondary_college_id_seq'::regclass);


--
-- Name: tb_supplier id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_supplier ALTER COLUMN id SET DEFAULT nextval('public.tb_supplier_id_seq'::regclass);


--
-- Name: tb_teaching_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_teaching_group ALTER COLUMN id SET DEFAULT nextval('public.tb_teaching_group_id_seq'::regclass);


--
-- Name: tb_textbook id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_textbook ALTER COLUMN id SET DEFAULT nextval('public.textbook_id_seq'::regclass);


--
-- Name: tb_textbook_feedback id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_textbook_feedback ALTER COLUMN id SET DEFAULT nextval('public.tb_textbook_feedback_id_seq'::regclass);


--
-- Name: tb_textbook_order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_textbook_order ALTER COLUMN id SET DEFAULT nextval('public.tb_textbook_order_id_seq'::regclass);


--
-- Name: tb_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_user ALTER COLUMN id SET DEFAULT nextval('public.tb_user_faculty_id_seq'::regclass);


--
-- Name: tb_user_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_user_info ALTER COLUMN id SET DEFAULT nextval('public.tb_faculty_info_id_seq'::regclass);


--
-- Name: tb_user_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_user_role ALTER COLUMN id SET DEFAULT nextval('public.tb_faculty_role_id_seq'::regclass);


--
-- Data for Name: general_field; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.general_field (create_time, update_time, is_deleted) FROM stdin;
\.


--
-- Data for Name: tb_approval; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_approval (id, opening_plan_id, textbook_ids, teaching_group_state, teaching_group_message, secondary_college_state, secondary_college_message, deans_office_state, deans_office_message, state, create_time, update_time, is_deleted) FROM stdin;
17	13	1742	0	\N	0	\N	0	\N	0	2023-03-03 01:47:38	2023-03-03 01:47:38	0
\.


--
-- Data for Name: tb_grade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_grade (id, major_id, year, number, create_time, update_time, is_deleted) FROM stdin;
1	1	2021	1	2023-02-21 06:11:20	2023-02-21 06:11:20	0
2	1	2021	2	2023-02-21 06:11:20	2023-02-21 06:11:20	0
\.


--
-- Data for Name: tb_login_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_login_log (id, account, ip, state, message, access_time, create_time, update_time, is_deleted, browser, os, login_location) FROM stdin;
1	test111	127.0.0.1	1	用户名或密码错误	2023-03-05 23:41:17	2023-03-05 23:41:17	2023-03-05 23:41:17	0	Chrome	Windows 10 or Windows Server 2016	内网ip
2	banUser	127.0.0.1	1	当前用户已被封禁	2023-03-05 23:42:14	2023-03-05 23:42:14	2023-03-05 23:42:14	0	Chrome	Windows 10 or Windows Server 2016	内网ip
3	test	127.0.0.1	1	密码错误	2023-03-05 23:42:45	2023-03-05 23:42:45	2023-03-05 23:42:45	0	Chrome	Windows 10 or Windows Server 2016	内网ip
4	test	127.0.0.1	1	用户名或密码错误	2023-03-05 23:43:22	2023-03-05 23:43:22	2023-03-05 23:43:22	0	Chrome	Windows 10 or Windows Server 2016	内网ip
5	test	127.0.0.1	1	验证码错误	2023-03-05 23:43:37	2023-03-05 23:43:37	2023-03-05 23:43:37	0	Chrome	Windows 10 or Windows Server 2016	内网ip
6	test	127.0.0.1	1	验证码过期	2023-03-05 23:44:03	2023-03-05 23:44:03	2023-03-05 23:44:03	0	Chrome	Windows 10 or Windows Server 2016	内网ip
7	test	127.0.0.1	0	登陆成功	2023-03-05 23:44:42	2023-03-05 23:44:42	2023-03-05 23:44:42	0	Chrome	Windows 10 or Windows Server 2016	内网ip
8	176****1234	127.0.0.1	1	验证码过期	2023-03-05 23:45:35	2023-03-05 23:45:35	2023-03-05 23:45:35	0	Chrome	Windows 10 or Windows Server 2016	内网ip
9	176****1234	127.0.0.1	0	登陆成功	2023-03-05 23:46:31	2023-03-05 23:46:31	2023-03-05 23:46:31	0	Chrome	Windows 10 or Windows Server 2016	内网ip
10	176****1231	127.0.0.1	1	验证码错误	2023-03-05 23:56:38	2023-03-05 23:56:38	2023-03-05 23:56:38	0	Chrome	Windows 10 or Windows Server 2016	内网ip
11	176****1231	127.0.0.1	1	用户不存在	2023-03-05 23:56:50	2023-03-05 23:56:50	2023-03-05 23:56:50	0	Chrome	Windows 10 or Windows Server 2016	内网ip
12	test	127.0.0.1	1	验证码过期	2023-03-06 00:16:03	2023-03-06 00:16:03	2023-03-06 00:16:03	0	Chrome	Windows 10 or Windows Server 2016	内网ip
13	test	127.0.0.1	0	登陆成功	2023-03-06 00:16:13	2023-03-06 00:16:13	2023-03-06 00:16:13	0	Chrome	Windows 10 or Windows Server 2016	内网ip
14	test	127.0.0.1	0	登陆成功	2023-03-06 01:27:52	2023-03-06 01:27:52	2023-03-06 01:27:52	0	Chrome	Windows 10 or Windows Server 2016	内网ip
\.


--
-- Data for Name: tb_major; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_major (id, name, secondary_college_id, create_time, update_time, is_deleted) FROM stdin;
1	计算机科学与技术	1	2023-02-21 06:10:38	2023-02-21 06:10:38	0
3	机器人工程	1	2023-02-21 06:10:38	2023-02-21 06:10:38	0
4	人工智能	1	2023-02-21 06:10:38	2023-02-21 06:10:38	0
5	电子信息类	1	2023-02-21 06:10:38	2023-02-21 06:10:38	0
6	金融科技	1	2023-02-21 06:10:38	2023-02-21 06:10:38	0
7	商务英语	2	2023-02-21 06:10:38	2023-02-21 06:10:38	0
8	日语	2	2023-02-21 06:10:38	2023-02-21 06:10:38	0
9	酒店管理	3	2023-02-21 06:10:38	2023-02-21 06:10:38	0
10	金融学类	4	2023-02-21 06:10:38	2023-02-21 06:10:38	0
11	会计学	4	2023-02-21 06:10:38	2023-02-21 06:10:38	0
12	工商管理	4	2023-02-21 06:10:38	2023-02-21 06:10:38	0
13	电子商务	4	2023-02-21 06:10:38	2023-02-21 06:10:38	0
14	法学	5	2023-02-21 06:10:38	2023-02-21 06:10:38	0
15	土木工程	6	2023-02-21 06:10:38	2023-02-21 06:10:38	0
16	建筑电气与智能化	6	2023-02-21 06:10:38	2023-02-21 06:10:38	0
17	数字媒体技术	7	2023-02-21 06:10:38	2023-02-21 06:10:38	0
18	学前教育	8	2023-02-21 06:10:38	2023-02-21 06:10:38	0
19	应用心理学	8	2023-02-21 06:10:38	2023-02-21 06:10:38	0
2	数据科学与大数据技术	1	2023-02-21 06:10:38	2023-03-02 17:29:39	0
\.


--
-- Data for Name: tb_opening_plan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_opening_plan (id, secondary_college_id, teacher_id, grade_id, teaching_group_id, state, create_time, update_time, is_deleted) FROM stdin;
12	1	2	2	8	0	2023-02-27 13:44:33	2023-02-27 13:44:33	0
13	1	2	1	2	1	2023-03-03 01:35:27	2023-03-03 01:47:38	0
\.


--
-- Data for Name: tb_opening_plan_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_opening_plan_detail (id, opening_plan_id, course_name, credit, teaching_hours, weeks_teach, type, create_time, update_time, is_deleted) FROM stdin;
20	12	考试	3	40	20	0	2023-02-27 13:44:33	2023-02-27 13:44:33	0
21	12	考察	1	20	10	1	2023-02-27 13:44:33	2023-02-27 13:44:33	0
22	13	121	2	12	12	0	2023-03-03 01:35:27	2023-03-03 01:35:27	0
\.


--
-- Data for Name: tb_operate_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_operate_log (id, title, business_type, method, request_method, operator_name, operate_url, operate_ip, operate_param, json_result, status, error_msg, operate_time, create_time, update_time, is_deleted) FROM stdin;
22	测试	0	com.chen.graduation.controller.TestController.logTest()	POST	\N	/test/logTest/12	0:0:0:0:0:0:0:1	{"e":false,"name":"123","phoneNumberDTO":{"phoneNumber":"17612341234"},"id":"12"}	{"e":false,"phone":"17612341234","name":"123","id":"12"}	0	\N	2023-03-05 21:07:52	2023-03-05 21:07:52	2023-03-05 21:07:52	0
23	测试	0	com.chen.graduation.controller.TestController.logTest()	POST	\N	/test/logTest/12	127.0.0.1	{"e":false,"name":"123","phoneNumberDTO":{"phoneNumber":"17612341234"},"id":"12"}	{"e":false,"phone":"17612341234","name":"123","id":"12"}	0	\N	2023-03-05 23:58:07	2023-03-05 23:58:07	2023-03-05 23:58:07	0
24	测试	0	com.chen.graduation.controller.TestController.logTest()	POST	\N	/test/logTest/12	127.0.0.1	{"e":true,"name":"123","phoneNumberDTO":{"phoneNumber":"17612341234"},"id":"12"}	null	1	测试错误	2023-03-05 23:58:23	2023-03-05 23:58:23	2023-03-05 23:58:23	0
25	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	1	nested exception is org.apache.ibatis.binding.BindingException: Parameter 'params' not found. Available parameters are [search, objectPage, param1, param2]	2023-03-06 02:03:16	2023-03-06 02:03:16	2023-03-06 02:03:16	0
26	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	0	\N	2023-03-06 02:04:55	2023-03-06 02:04:55	2023-03-06 02:04:55	0
27	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	0	\N	2023-03-06 02:13:25	2023-03-06 02:13:25	2023-03-06 02:13:25	0
28	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	0	\N	2023-03-06 02:15:53	2023-03-06 02:15:53	2023-03-06 02:15:53	0
29	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	0	\N	2023-03-06 02:17:48	2023-03-06 02:17:48	2023-03-06 02:17:48	0
30	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	0	\N	2023-03-06 02:19:28	2023-03-06 02:19:28	2023-03-06 02:19:28	0
31	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	0	\N	2023-03-06 02:25:09	2023-03-06 02:25:09	2023-03-06 02:25:09	0
32	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	0	\N	2023-03-06 02:26:33	2023-03-06 02:26:33	2023-03-06 02:26:33	0
33	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	0	\N	2023-03-06 02:28:36	2023-03-06 02:28:36	2023-03-06 02:28:36	0
34	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	0	\N	2023-03-06 02:34:19	2023-03-06 02:34:19	2023-03-06 02:34:19	0
35	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	1	Could not auto-size column. Make sure the column was tracked prior to auto-sizing the column.	2023-03-06 02:39:28	2023-03-06 02:39:28	2023-03-06 02:39:28	0
36	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	1	org.apache.poi.xssf.usermodel.XSSFSheet cannot be cast to org.apache.poi.xssf.streaming.SXSSFSheet	2023-03-06 02:40:09	2023-03-06 02:40:09	2023-03-06 02:40:09	0
37	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	0	\N	2023-03-06 02:43:46	2023-03-06 02:43:46	2023-03-06 02:43:46	0
38	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	0	\N	2023-03-06 02:44:44	2023-03-06 02:44:44	2023-03-06 02:44:44	0
39	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	0	\N	2023-03-06 02:47:49	2023-03-06 02:47:49	2023-03-06 02:47:49	0
40	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	0	\N	2023-03-06 02:49:08	2023-03-06 02:49:08	2023-03-06 02:49:08	0
41	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	0	\N	2023-03-06 02:50:42	2023-03-06 02:50:42	2023-03-06 02:50:42	0
42	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	0	\N	2023-03-06 02:55:54	2023-03-06 02:55:54	2023-03-06 02:55:54	0
43	操作日志	4	com.chen.graduation.controller.LogController.export()	POST	测试账号	/log/operate/export	127.0.0.1	{"operateLogSearchDTO":{"beginTime":"","endTime":"","operatorName":"","pageParamDTO":{"page":1,"size":10},"title":""}}	null	0	\N	2023-03-06 03:02:07	2023-03-06 03:02:07	2023-03-06 03:02:07	0
\.


--
-- Data for Name: tb_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_permission (id, parent_id, path, request_url, name, perms, icon, component, type, state, create_time, update_time, is_deleted) FROM stdin;
8	0	system	\N	系统管理		el-icon-s-tools	Layout	0	0	2023-03-01 23:30:26	2023-03-01 23:30:26	0
15	0	academic	\N	教务管理		academic	Layout	0	0	2023-03-01 23:39:25	2023-03-01 23:39:25	0
21	0	textbookSubscription	\N	教材征订		el-icon-notebook-2	Layout	0	0	2023-03-01 23:42:38	2023-03-01 23:42:38	0
30	15	supplier	\N	供应商管理		el-icon-s-order	academic/supplier/index	1	0	2023-03-02 17:09:23	2023-03-02 09:28:40	0
31	21	order	\N	教材订单管理		el-icon-s-order	textbookSubscription/order/index	1	0	2023-03-02 17:45:03	2023-03-02 17:45:03	0
32	15	major	\N	专业管理		el-icon-s-platform	academic/major/index	1	0	2023-03-03 00:47:04	2023-03-03 00:47:04	0
27	0	student	\N	学生服务		el-icon-reading	Layout	0	0	2023-03-01 23:49:24	2023-03-01 23:49:24	0
10	8	role	\N	角色管理		el-icon-user-solid	system/role/index	1	0	2023-03-01 23:34:44	2023-03-02 06:54:03	0
9	8	user	\N	用户管理		el-icon-user	system/user/index	1	0	2023-03-01 23:33:06	2023-03-02 06:54:03	0
11	8	permission	\N	权限管理		permission	system/permission/index	1	0	2023-03-01 23:35:37	2023-03-02 06:55:52	0
14	12	login	\N	登陆日志		el-icon-s-goods	system/log/login	1	0	2023-03-01 23:37:50	2023-03-02 06:58:45	0
18	15	secondaryCollege	\N	二级学院管理		secondaryCollege	academic/secondaryCollege/index	1	0	2023-03-01 23:40:53	2023-03-02 07:56:18	0
16	15	grade	\N	班级管理		grade	academic/grade/index	1	0	2023-03-01 23:39:51	2023-03-02 07:56:18	0
20	15	approval	\N	教材申请管理		approval	academic/approval/index	1	0	2023-03-01 23:41:50	2023-03-02 07:56:18	0
17	15	teachingGroup	\N	教学组管理		teachingGroup	academic/teachingGroup/index	1	0	2023-03-01 23:40:23	2023-03-02 07:56:18	0
19	15	openingPlan	\N	开课计划管理		openingPlan	academic/openingPlan/index	1	0	2023-03-01 23:41:21	2023-03-02 07:56:18	0
25	21	secondaryCollege	\N	二级学院审核		el-icon-s-help	textbookSubscription/secondaryCollege/index	1	0	2023-03-01 23:46:00	2023-03-02 08:10:34	0
22	21	openingPlan	\N	我的开课计划		el-icon-s-home	textbookSubscription/openingPlan/index	1	0	2023-03-01 23:43:39	2023-03-02 08:10:34	0
26	21	academic	\N	教务处审核		el-icon-s-check	textbookSubscription/academic/index	1	0	2023-03-01 23:48:58	2023-03-02 08:10:34	0
23	21	approval	\N	我的教材申请		el-icon-s-management	textbookSubscription/approval/index	1	0	2023-03-01 23:44:07	2023-03-02 08:10:34	0
24	21	teachingGroup	\N	教学组审核		el-icon-s-custom	textbookSubscription/teachingGroup/index	1	0	2023-03-01 23:44:32	2023-03-02 08:10:34	0
29	27	textbook	\N	我的教材		el-icon-s-management	student/textbook/index	1	0	2023-03-01 23:50:16	2023-03-02 08:13:04	0
28	27	openingPlan	\N	我的开课计划		el-icon-s-home	student/openingPlan/index	1	0	2023-03-01 23:49:51	2023-03-02 08:13:04	0
13	12	operate	\N	操作日志		el-icon-document-remove	system/log/operate	1	0	2023-03-01 23:37:13	2023-03-02 08:17:39	0
12	8	log	\N	日志管理		el-icon-tickets	ParentView	1	0	2023-03-01 23:36:33	2023-03-02 08:17:39	0
\.


--
-- Data for Name: tb_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_role (id, name, description, state, create_time, update_time, is_deleted) FROM stdin;
1	teacher	教师	0	2023-02-24 13:49:31	2023-02-24 13:49:31	0
2	student	学生	0	2023-02-24 13:49:31	2023-02-24 13:49:31	0
\.


--
-- Data for Name: tb_role_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_role_permission (id, role_id, permission_id, create_time, update_time, is_deleted) FROM stdin;
1	2	27	2023-03-01 17:35:18	2023-03-01 17:35:18	0
2	2	28	2023-03-01 17:35:18	2023-03-01 17:35:18	0
3	2	29	2023-03-01 17:35:18	2023-03-01 17:35:18	0
4	1	8	2023-03-02 01:36:13	2023-03-02 01:36:13	0
5	1	9	2023-03-02 01:36:13	2023-03-02 01:36:13	0
6	1	10	2023-03-02 01:36:13	2023-03-02 01:36:13	0
7	1	11	2023-03-02 01:36:13	2023-03-02 01:36:13	0
8	1	12	2023-03-02 01:36:13	2023-03-02 01:36:13	0
9	1	13	2023-03-02 01:36:13	2023-03-02 01:36:13	0
10	1	14	2023-03-02 01:36:13	2023-03-02 01:36:13	0
11	1	15	2023-03-02 01:36:13	2023-03-02 01:36:13	0
12	1	16	2023-03-02 01:36:13	2023-03-02 01:36:13	0
13	1	17	2023-03-02 01:36:13	2023-03-02 01:36:13	0
14	1	18	2023-03-02 01:36:13	2023-03-02 01:36:13	0
15	1	19	2023-03-02 01:36:13	2023-03-02 01:36:13	0
16	1	20	2023-03-02 01:36:13	2023-03-02 01:36:13	0
17	1	21	2023-03-02 01:36:13	2023-03-02 01:36:13	0
18	1	25	2023-03-02 01:36:13	2023-03-02 01:36:13	0
19	1	22	2023-03-02 01:36:13	2023-03-02 01:36:13	0
20	1	23	2023-03-02 01:36:13	2023-03-02 01:36:13	0
21	1	24	2023-03-02 01:36:13	2023-03-02 01:36:13	0
22	1	26	2023-03-02 01:36:13	2023-03-02 01:36:13	0
23	1	27	2023-03-02 01:36:13	2023-03-02 01:36:13	0
24	1	28	2023-03-02 01:36:13	2023-03-02 01:36:13	0
25	1	29	2023-03-02 01:36:13	2023-03-02 01:36:13	0
26	1	30	2023-03-02 09:11:37	2023-03-02 09:11:37	0
27	1	31	2023-03-02 09:45:39	2023-03-02 09:45:39	0
28	1	32	2023-03-02 16:49:39	2023-03-02 16:49:39	0
\.


--
-- Data for Name: tb_secondary_college; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_secondary_college (id, name, create_time, update_time, is_deleted) FROM stdin;
1	人工智能学院	2023-02-21 06:03:28	2023-02-21 06:03:28	0
2	外国语与海外教育学院	2023-02-21 06:06:00	2023-02-21 06:06:00	0
3	现代管理学院	2023-02-21 06:06:00	2023-02-21 06:06:00	0
4	商学院	2023-02-21 06:06:00	2023-02-21 06:06:00	0
5	法学院	2023-02-21 06:06:00	2023-02-21 06:06:00	0
6	土木工程学院	2023-02-21 06:06:00	2023-02-21 06:06:00	0
7	设计学院	2023-02-21 06:06:00	2023-02-21 06:06:00	0
8	儿童发展与教育学院	2023-02-21 06:06:00	2023-02-21 06:06:00	0
\.


--
-- Data for Name: tb_supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_supplier (id, name, description, contact_number, email, address, create_time, update_time, is_deleted) FROM stdin;
2	供应商史烨伟	这是供应商2	17252004716	17252004716@gmail.com	段中心67号, 江阴, 黔 934764	2023-02-21 17:38:38	2023-02-21 17:38:38	0
3	供应商顾鸿涛	这是供应商3	15727178520	15727178520@gmail.com	Apt. 340 石街5675号, 石家庄, 蒙 068088	2023-02-21 17:38:38	2023-02-21 17:38:38	0
4	供应商赵鹏	这是供应商4	15026029107	15026029107@gmail.com	史巷1720号, 西宁, 苏 778929	2023-02-21 17:38:38	2023-02-21 17:38:38	0
5	供应商夏志泽	这是供应商5	17285931444	17285931444@gmail.com	Apt. 509 杜巷18号, 佛山, 黔 097358	2023-02-21 17:38:38	2023-02-21 17:38:38	0
6	供应商冯鸿涛	这是供应商6	17357631489	17357631489@gmail.com	Apt. 766 袁中心8573号, 西安, 陕 065915	2023-02-21 17:38:38	2023-02-21 17:38:38	0
7	供应商李立辉	这是供应商7	14704830703	14704830703@gmail.com	Suite 369 覃旁79309号, 东莞, 川 559332	2023-02-21 17:38:38	2023-02-21 17:38:38	0
8	供应商贾绍辉	这是供应商8	15225923584	15225923584@gmail.com	刘栋9号, 肇庆, 浙 356074	2023-02-21 17:38:38	2023-02-21 17:38:38	0
9	供应商孟黎昕	这是供应商9	13592841117	13592841117@gmail.com	陈中心33号, 上海, 陕 224850	2023-02-21 17:38:38	2023-02-21 17:38:38	0
1	供应商余思源	这是供应商1	18514117907	18514117907@gmail.com	潘路462号, 鄂尔多斯, 京 962721	2023-02-21 17:38:38	2023-02-21 10:18:13	0
10	供应商傅鸿煊	这是供应商10	15629656991	15629656991@gmail.com	何中心82号, 兰州, 赣 578257	2023-02-21 17:38:38	2023-02-22 18:03:23	0
18	123aaa	123	123	123@qq.com	123	2023-03-02 17:18:47	2023-03-02 17:19:35	18
19	aaaasaxzz	123	123	123@123.com	123	2023-03-05 20:10:07	2023-03-05 20:13:53	19
\.


--
-- Data for Name: tb_teaching_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_teaching_group (id, name, create_time, update_time, is_deleted) FROM stdin;
2	电气类专业主要技术基础课程教学团队	2023-02-21 06:17:14	2023-02-21 06:17:14	0
3	思想政治理论课系列课程教学团队	2023-02-21 06:17:14	2023-02-21 06:17:14	0
4	国际贸易理论与实务课程教学团队	2023-02-21 06:17:14	2023-02-21 06:17:14	0
5	大学数学教学团队	2023-02-21 06:17:14	2023-02-21 06:17:14	0
6	电路教学团队	2023-02-21 06:17:14	2023-02-21 06:17:14	0
7	数据结构与离散数学教学团队	2023-02-21 06:17:14	2023-02-21 06:17:14	0
8	高级语言——程序设计与实现技术教学团队	2023-02-21 06:17:14	2023-03-02 12:50:50	0
1	机械制造系列课程教学团队	2023-02-21 06:17:14	2023-03-02 17:00:06	0
\.


--
-- Data for Name: tb_textbook; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_textbook (id, book_name, isbn, bar_code, author, binding, print, folio, price, words, publishing_house, page_number, issue_number, pre_packet_number, publication_date, img_url, description, state, create_time, update_time, is_deleted, stock) FROM stdin;
1779	货币幻觉	978-7-5598-4640-2	\N	[美]欧文·费雪（Irving Fisher） 著 译者：曹乾 	精装	1-1	32开	59.00	\N	广西师范大学出版社	\N	\N	\N	2022-04-01	/book/f7b0a75c-6929-47df-b5fe-a3078e9286cb1086036.jpg	觉得生活成本越来越高，工资涨了还是不够用？这说明你出现了货币幻觉。货币幻觉是人的一种心理错觉，即决策时只看到货币的名义价值，而忽视了实际购买力的变化。 费雪列举了大量存在货币幻觉的生动例子，并认为这种错觉源于货币单位的不稳定——即货币购买力的波动。他继而分析波动的原因和对不同行业不同阶层的危害，分别站在个人、银行和政府的角度提出补救办法。比如用指数衡量货币购买力，并根据指数调整工资等；或直接用指数创造商品本位，取代当时的金本位。 本书能加深人们对货币的认识，更重要的是，能帮助个人在生活、投资决策时少受货币幻觉的影响。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	488
1788	漠河盆地侏罗系陆相泥页岩储层特征及页岩气资源潜力	978-7-5625-4959-8	\N	侯宇光 等 著 	平装	1-1	16开	86.00	\N	中国地质大学出版社	\N	\N	\N	2020-10-01	/book/23bd8305-b1e7-4d98-9efc-0cf47629a1cd1086082.jpg	本书，基于大量的野外地质调查和研究工作，全面阐述了漠河盆地中侏罗统陆相泥页岩发育的构造地质背景、沉积环境和空间展布规律，系统分析了中侏罗统陆相泥页岩的矿物组成、有机地球化学和储层孔隙结构特征，深入论述了中侏罗统陆相泥页岩的生烃能力、储集能力、可压裂性及其影响因素；最后，对漠河盆地陆相页岩气资源进行了潜力评价和有利区带预测。 本书，可供从事“页岩油气”地质勘探与开发、页岩油气资源潜力评价等相关研究与生产的企、事业单位研究人员和高等院校师生参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	131
1780	中国古今蚕桑丝绸技艺精华	9787567236462	\N	钱小萍 白伦 主编 	平装	1-1	16开	680.00	\N	苏州大学出版社	\N	\N	\N	2022-04-01	/book/7bc56b3c-6876-4833-a1c7-429b667f371f1086039.jpg	　　《中国古今蚕桑丝绸技艺精华》共115万字，通过对自古以来蚕丝绸生产中的重要生产要素，如蚕桑品种、丝绸品种、缫丝技艺、丝织器具、染整技艺及染料等，进行系统整理、分类解说，对其技艺精华进行了全面阐释。本书充分关注蚕丝绸技艺与时代进步的互动现象，在发掘丝绸生产要素文化文明价值的同时，深入探索了其科学技术价值，凸显了蚕丝绸丰富的文化文明及科学内涵。全书图文并茂，以直观生动的方式呈现，为展示和弘扬中国发明的蚕桑丝绸技艺提供了一个崭新的视角。 　　《中国古今蚕桑丝绸技艺精华》为广大读者群体特别是年轻一代提供了一本了解蚕桑丝绸技艺精华及其珍贵科学技术与文化价值的读物。它不是一本单纯介绍古代和当代蚕桑丝绸技术的著述，也不同于记录蚕桑丝绸发展历史的著作，它在萃取我国古今蚕桑丝绸技艺精华进行介绍的同时，讲解了这些技艺的产生机缘、科技文化内涵及其演化脉络，并特别关注蚕桑丝绸技艺在社会文化文明发展进程中的价值与贡献。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	458
1781	中国公共管理案例	9787302596288	\N	清华大学公共管理学院中国公共管理案例中心　编著 	平装	1-1	大32开	78.00	\N	清华大学出版社	\N	\N	\N	2022-04-01	/book/15621afb-7917-4f2e-a427-bff25eaaf32e1086042.png	《中国公共管理案例》是由清华大学公共管理学院授权出版。本书在前期案例出版的基础上进行了新的探索,纳入清华公共管理教材。全书分为党的建设、政府建设、经济、社会、文教、生态文明六个部分,共计十章,内容涵盖党建、国家机构改革、行政审批改革、财税改革、区域发展、社会组织发展、社会保障、贫困治理、教育发展、生态文明。在每一章中,第一节围绕该领域的主要发展阶段、主要模式和特点、相关国际比较及所形成的中国经验等展开;第二节为扎根中国大地的、具有时代性的优秀案例,通过多角度展示我国新时代改革开放和社会主义现代化建设实践成就,用中国概念讲好中国故事,促进国家治理体系和治理能力现代化建设的经验传播,传递中国新发展理念,彰显中国特色社会主义制度的特色优势;第三节为案例分析,作者从公共管理的专业视角,运用适当的公共管理理论,结合中国的创新实践,选取一两个点进行深刻分析,在帮助授课教师、学生、读者较为系统、深入地掌握公共管理知识的同时,为社会科学的未来发展贡献中国的学术增量。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	151
1782	高考西班牙语全真模拟题16套	9787566920386	\N	叶臻 童林林 李婉莎 	平装	1-1	16开	68.00	\N	东华大学出版社	\N	\N	\N	2022-03-01	/book/d8dea1e8-b5f2-457c-ae91-c7639192317d1086050.png	本书根据西班牙语考试中的常考知识点和学生容易犯错的知识点，有针对性地编写了16套模拟试题。内容涉及全国西班牙语高考题型，包含了动词变位、介词填空、动词填空、单项选择、阅读理解、中翻西、西翻中、写作和听力部分。目的是帮助中学生进行综合、系统地练习，以适应考试题型，提高学习成绩；同时西语自学者也可用来检测学习效果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	366
1783	海洋测绘学概论	978-7-307-22919-8	\N	阳凡林、翟国君、赵建虎 等 编著 	平装	1-1	16开	80.00	\N	武汉大学出版社	\N	\N	\N	2022-03-01	/book/59eca9c6-9b92-4bbb-808f-3baf4fb1d98d1086057.jpg	海洋测绘是研究海洋和内陆水域及其毗邻陆地空间地理信息采集、处理、表达、管理和应用的测绘科学与技术学科分支，是海洋测量、海图制图及海洋地理信息工程的总称。作为测绘学的一个分支，海洋测绘在坐标框架、测绘基础理论、定位方法等方面与测绘学是一脉相承的，但由于海洋环境的不可通视性和动态性，使得海洋测绘在理论和方法上又有其独特之处。本书共分8章，重点介绍了海洋环境特性、海洋测绘的定义与内涵、海洋垂直基准与水位控制、海洋定位、海底地形测量、海洋重力与磁力测量、海洋测量数据管理与海图生产、海洋工程测量和海洋环境调查方法等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	582
1785	深圳珠宝行业发展简史	978-7-5625-5101-0	\N	深圳珠宝博物馆 编著 	平装	1-1	16开	60.00	131.0千字	中国地质大学出版社	\N	\N	\N	2021-09-01	/book/850dd8f5-e092-40a6-99b6-8aeb63f57c3c1086074.jpg	本书是首次对深圳珠宝发展四十年的一个梳理，讲述了珠宝行业发展的重要节点和大事件，呈现行业发展不同阶段的面貌，当下所面临的机遇与挑战，自萌芽期的锋芒初绽，到探索期的敢为人先、发展期的锐意进取，再到升级期的砥砺转型，无数珠宝业者将青春与汗水烙印其间。最后一部分是围绕深圳珠宝博物馆在建党100周年节点策划的“水贝传奇——深圳珠宝四十年回顾展”所做的人物采访以及展览概况，是对四十年历史的一个补充。本书可供珠宝爱好者阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	204
1742	跨境电商实务	978-7-5689-3028-4	\N	殷秀梅 彭奇 	0	1-1	16开	35.00	287.0千字	重庆大学出版社	184	\N	\N	2022-02-21	/book/6cc15907-a238-4432-9474-977cbf510ec21085759.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	193
1786	湖南省煤系气地质研究	978-7-5625-5059-4	\N	何红生 等 著 	平装	1-1	16开	128.00	327.0千字	中国地质大学出版社	\N	\N	\N	2021-10-01	/book/2020cf7a-7adc-430e-8eb3-8dd6612bf3111086077.jpg	本专著系统研究了煤系中煤层、页岩层、砂岩层的地质特征，首次发现了煤系气的叠置共生组合规律，并创建了3种煤系气共生组合模式；创新性地运用层序地层学及小波分析的方法对湖南省含煤岩系进行了含气系统的识别与划分；建立了煤系气分类分级资源勘查潜力评价体系，优选了煤系气勘查有利区带；首次运用概率体积法估算了湖南省煤系气资源量。本专著集成了以湖南省自然资源厅重大科研项目“湖南省煤系气资源评价及综合开发利用研究”为主体的系列专项研究课题，是湖南省煤系气资源调查评价与研究的第一部专著，资料系列长而全面，同时集成了湖南省最新的煤系气研究成果，可为指导湖南省开发利用煤系气资源提供科学依据，也可为科研院、所研究湖南省煤系气资源提供丰富的基础资料。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	323
1787	三峡库区滑坡监测预警理论与实践	978-7-5625-5109-6	\N	霍志涛 等 编著 	平装	1-1	16开	168.00	491.0千字	中国地质大学出版社	\N	\N	\N	2020-10-01	/book/cc35c428-0b9f-4125-bc4c-33158eb6ddc71086080.jpg	在系统分析三峡库区滑坡监测预警方法和工程实践的基础上，对滑坡监测预警工作成果的集成，也可作为广大地质灾害研究方向的研究生和地质灾害监测预警方面的专业技术人员的学习教材。全书共分三篇。第一篇为概述篇，主要介绍了三峡库区滑坡的发育模式和监测预警体系；第二篇为滑坡监测篇，详细介绍了专业监测和群测群防监测的主要内容以及相关滑坡案例，另外还介绍与之紧密相连的信息系统；第三篇为滑坡预警预报篇，从理论上介绍了滑坡预报模型和预警判据，并从管理角度介绍了滑坡预警流程，另在每一章中通过滑坡案例进行相应的分析阐述。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	903
1789	经济管理类专业大数据技术与应用实验教程	978-7-5625-5119-5	\N	郭明晶 等 编著 	平装	1-1	16开	38.00	225.0千字	中国地质大学出版社	\N	\N	\N	2021-09-01	/book/76360d54-75f7-455a-9db9-90af8cd458141086084.jpg	本教材主要是针对经济管理类、公共管理类等相关专业特点，介绍大数据技术应用领域，着力培养学生建模和分析技能，安排与各专业内容相结合的实验内容和案例（例如电子商务推荐系统、景区大数据可视化、商务智能分析、数据挖掘算法等），使学生在掌握专业领域知识的前提下，了解各专业中的现实热点问题和解决方案，以此来提高自身大数据应用和管理能力。除此之外，为提高本教程的科学性和实用性，作者将特邀中关村大数据联盟知名企业——北京清数教育科技有限公司的技术团队参与编写工作，该公司在大数据教育推广和培训等领域积累了丰富的实践经验，不仅有利于针对我校的专业和学生特点提供个性化技术支持，而且有利于本教材在国内其他高校的推广。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	650
1790	城市交通管理与控制（第2版）	978-7-5121-4691-4	\N	袁振洲 主编 	平装	1-1	16开	69.00	\N	北京交通大学出版社	\N	\N	\N	2022-04-01	/book/318296c7-34dd-4c98-9f2e-de7713fa1aae1086085.jpg	本书共分为10章，主要内容包括交通管理与控制概述、交通管理法规及标志标线、交叉口交通管理、交通运行管理、交通信号控制理论基础、单交叉信号控制、干道多交叉口信号联动控制、区域交叉口信号协调控制、城市快速道路交通控制、交通检测设备与仿真软件简介。 本书可作为高等院校交通工程专业的教材，也可作为道路工程、交通运输管理等相关专业的选修课教材，同时可供从事交通运输规划与管理的工程技术人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	455
1791	交通系统分析与应用	978-7-5121-4611-2	\N	王江锋，顾明臣 主编 	平装	1-1	16开	58.00	\N	北京交通大学出版社	\N	\N	\N	2022-04-01	/book/67221eeb-33ce-42e1-aee5-9b0fe39c214b1086086.jpg	本书在总结国内外交通系统分析方面最新研究成果的基础上，运用系统工程思维，从系统状态、供需平衡、出行行为等维度进行交通系统分析，在此基础上重点从交通系统预测、评价与决策、建模与仿真、仿真评价等不同角度介绍了交通系统分析的相关概念、理论、方法，并结合R软件对交通分析相关理论方法进行了实例分析。 本书在内容安排上充分考虑了交通系统分析相关知识的基础性、理论性和应用性，使读者能够循序渐进地掌握交通系统分析的相关方法，并在此基础上介绍了车路协同、交通大数据等前沿新技术，具有一定的前瞻性。 本书可作为高等院校交通运输、交通工程及相关专业的本科生、研究生教材，也可作为交通管理、运营、设计工程技术人员的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	837
1792	财务管理（第3版）	978-7-5121-4594-8	\N	陈昌龙 主编 	平装	1-1	16开	49.00	\N	北京交通大学出版社	\N	\N	\N	2022-04-01	/book/b2efa882-3f9b-4671-a2db-08320ac9f64d1086090.jpg	　　本书比较详尽地介绍了财务管理的基本理论与基本方法。全书共9章，包括总论、财务管理价值观念、财务预算、筹资管理、投资管理、营运资金管理、利润分配管理、财务控制和财务分析。 　　本书每章都精心设计了章前“本章内容提要”与章后“本章小结”“复习思考题”“计算分析题”等专栏。对于书中某些需要说明的问题，一般以脚注的形式注明。本书具有较强的可读性，适合在经济管理领域学习研究的师生及从业人员参考使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	994
1793	海洋地球化学实验指导书	978-7-5625-5077-8	\N	吕晓霞 等 编著 	平装	1-1	16开	28.00	148.0千字	中国地质大学出版社	\N	\N	\N	2021-09-01	/book/d6811bd1-b95e-4573-a6ee-05444a8c43531086096.jpg	《海洋地球化学实验指导书》是针对《海洋地球化学》理论教学开设的实验课程，涉及海洋化学、海洋环境学、海洋地质学等专业领域的实验技能练习。实验内容包括样品的采集和分析。其中样品的采集分为水样、悬浮颗粒物和沉积物的采集；样品分析同样包括水样、悬浮颗粒物和沉积物的分析。实验内容涉及海洋地质、海洋化学和海洋环境学等学科常用参数的分析方法介绍。该教材可供海洋地质学、海洋环境学、海洋化学、海洋生态学、海洋矿产资源学等领域的科研、教学人员及本科生和研究生在学习和科研工作中阅读参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	888
90	基本乐理与视唱练耳（第3版）	9787565139970	\N	陈星 等 	0	3-1	0	31.00	266.0千字	南京师范大学出版社有限责任公司	134	\N	50	2019-02-01	/book/28632705-180c-4f50-aae4-65aec77635389787565139970.jpg	教材按照循序渐进、由浅入深的脉络进行编排，共19课，每一课分为基本乐理与视唱练耳两大部分，并把视唱练耳的内容融入基本乐理教学的每一科，使理论与实践相结合。乐理部分的理论讲解，避免了以往教材中常出现的，以后面的知识点解释前面知识的弊病。 　　《基本乐理与视唱练耳（第3版）》按照循序渐进、由浅入深的脉络进行编排，共19课，每一课分为基本乐理与视唱练耳两大部分，并把视唱练耳的内容融入基本乐理教学的每一科，使理论与实践相结合。 　　乐理部分的理论讲解，避免了以往教材中常出现的，以后面的知识点解释前面知识的弊病。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	200
91	中国经济伦理学年鉴（2017）	9787565141560	\N	主编 王小锡 	0	1-1	0	99.00	426.0千字	南京师范大学出版社有限责任公司	388	\N	18	2019-03-01	/book/de5cdd85-32be-4c91-bb29-7a132c4ddeee9787565141560.jpg	　　为了全面系统地展示我国经济伦理学的发展历程，总结我国经济伦理学学科建设和学术研究的成就，促进国内国际的学术交流，由教育部人文社会科学重点研究基地中国人民大学伦理学与道德建设研究中心和南京师范大学共建的经济伦理学研究所决定编辑出版从2000年起的《中国经济伦理学年鉴》。 　　《中国经济伦理学年鉴（2017）》的内容主要包括学者介绍、特稿、论文摘要、著作简介、伦理学前沿、学术活动和主要课题等。 　　《中国经济伦理学年鉴（2017）》主要反映当年度我国经济伦理学的发展状况，设置了“特稿”“伦理学前沿”栏目，并介绍国外经济伦理学相关中译本著作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	193
96	培智学校正向行为支持体系的构建与运营	9787565141515	\N	郤玲亚 	0	1-1	0	49.80	226.0千字	南京师范大学出版社有限责任公司	231	\N	40	2019-05-01	/book/4044ebc1-ff08-4a52-be26-c8e4bc830ea19787565141515.jpg	近年来随着培智学校招生对象的障碍程度趋于严重化、障碍类型趋于复杂化，学生的行为问题类型日趋增加，危害程度愈加严重。针对该情况，本书以个案研究为基础，开展了为期五年的实践研究，提出培智学校应建立以正向行为支持理论为基础的面向全体、班集体和个案的预防体系	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	235
97	中国传媒文化百年史	9787565139161	\N	曾一果 许静波 	0	1-1	0	78.00	280.0千字	南京师范大学出版社有限责任公司	292	\N	32	2018-12-01	/book/bbb9ae17-3593-42e5-b43b-3473a453c5ee9787565139161.jpg	本书总结一百年来中国传媒文化发生、发展的历史，兼及总结中国传媒文化发展的历史规律。分别从五四时代的民主与科学，二三十年代的革命与自由，三四十年代的民族与民主，五十至七十年代的理想与斗争，七十年代末到八十年代的改革与开放，九十年代到新世纪的多元与发展等六个	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	353
98	中国美术文化百年史	9787565140136	\N	韩靖 	0	1-1	0	90.00	327.0千字	南京师范大学出版社有限责任公司	342	\N	32	2018-12-01	/book/c0b4399e-a71b-4bd9-8b78-f6c077c872889787565140136.jpg	本书总结一百年来中国美术文化发生、发展的历史，兼及总结中国美术文化发展的历史规律。分别从五四时代的民主与科学，二三十年代的革命与自由，三四十年代的民族与民主，五十至七十年代的理想与斗争，七十年代末到八十年代的改革与开放，九十年代到新世纪的多元与发展等六个	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	485
99	幼儿保教质量评估——持续共享思维和情绪情感健康（SSTEW）评量表	9787565142949	\N	伊拉穆·西拉杰 丹妮斯·金斯顿 爱德华·梅尔韦什 译者 詹慧妮 朱姗 	0	1-1	0	22.00	112.0千字	南京师范大学出版社有限责任公司	53	\N	80	2019-08-01	/book/ee731122-7a7a-4f24-bc03-58e19cbcfaa79787565142949.jpg	持续共享思维和情绪情感健康量表的目的是考虑一些意图性的和关系性的教育策略与儿童发展的密切关系。量表以高质量的教学方法和实践为出发点，可以让幼儿教育者更全面地了解高质量的幼儿教育和护理是什么样子的。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	363
100	南京古代文化变迁与文学演进	9787565138959	\N	高峰 	0	1-1	0	118.00	721.0千字	南京师范大学出版社有限责任公司	635	\N	16	2019-07-01	/book/357b05b4-5ab9-4a48-959f-d40df2d18f429787565138959.jpg	本书是江苏省哲学社会科学基金项目成果，首次对十朝古都南京悠久漫长的文化变迁与文学发展历程进行了全面细致的梳理和探析，具有填补南京古代文学整体研究空白的学术价值。全书依循历史文化演变轨迹，全面梳理地域历史文化资源，深入挖掘并阐发各类文学创作的意旨、格调、情趣与南京古都文化之间的内在关联，探析南京地域文化特征，研究不同历史时期南京的城市地位、文人心态、文艺思潮、文学风尚，剖析典型作家的艺术特征以及时代文化、地域特色的动因，探析文学演进的实质，系统地总结了不同时代南京文学的整体风貌、发展规律和价值意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	476
101	语言实践教程	9787565142611	\N	许迅 	0	3-1	0	45.00	413.0千字	南京师范大学出版社有限责任公司	308	\N	30	2020-01-01	/book/4517d741-0692-4f45-85f7-986828a79b0e9787565142611.jpg	它是一本专为师范生提高语言实践能力而编写的训练教程。全书以“清晰、准确、生动、得体”为语言实践能力的目标，重点对发声、语音、态势语、倾听四个基本要素，朗读、讲述、演讲、论辩、主持五个重要环节，以及人际交往、教育教学两个应用平台进行理论阐述和实践演练，呈现基础、提高和实践三个层次的梯度，采用“训”、“练”结合的编排方法，让师范生在“训导模块”中求“知”，在“训练模块”中提“能”。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	643
102	陈之佛全集	9787565139758	\N	陈之佛 	0	1-1	0	4,800.00	\N	南京师范大学出版社有限责任公司	\N	\N	1	2020-04-15	/book/921d836e-59a9-448e-84f9-e8a34e2d0c8b9787565139758.jpg	本项目成果全面系统地研究整理收录了陈之佛先生存世的自1928年以来所撰写的图案（工艺美术）、美术教育等著作20余部，专业文章160余篇，绘画、设计作品400余幅，以及信札日记手稿40余篇等，其中的大部分内容均为经过考证的原版、权威、稀见的第一手资料。全书以著作、文集、	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	537
103	陈之佛全集.14.陈之佛手稿	9787565145131	\N	陈之佛 	0	1-1	0	188.00	\N	南京师范大学出版社有限责任公司	583	\N	8	2020-03-01	/book/17ee8510-b4b2-43c9-b5ca-c47bf993d7299787565145131.jpg	本书收录的陈之佛先生的学术文章、学习感悟、艺术界的活动、求学生涯的回忆等手稿，均是第一次出现在公众的视野。这些出自于陈之佛先生之手的文字，更有温度，立体地呈现了一位现代设计先驱、云锦复兴元勋、工笔花鸟画大家的温润如玉的性格特点、严谨的治学精神和强烈的民族责任感。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	942
104	陈之佛全集.3.表号图案	9787565145155	\N	陈之佛 	0	1-1	0	38.00	\N	南京师范大学出版社有限责任公司	127	\N	30	2020-03-01	/book/cc50f302-4092-4789-b3c9-f8d8341389729787565145155.jpg	表号是《圣经》中特有的一种阐述道理或借代说明的方式。埃及或古希腊的图像中，黑梅斯的神杖代表什么?倒放或正放的火把有什么寓意?有翼的龙、火轮象征什么?《表号图案》用通俗的语言对中外表达特定象征含义的图案进行了解读，读者可以通过轻松的故事了解各种图案符号的寓意，设计师或艺术家在创作时可以用作参考，以恰当地表达作品的内在含义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	724
105	学校教育时间的社会逻辑	9787565144387	\N	主编 程天君 作者 桑志坚 	0	1-1	0	48.00	207.0千字	南京师范大学出版社有限责任公司	246	\N	30	2019-12-01	/book/2cc5d39a-f9b3-4737-bede-b38bba655c879787565144387.jpg	本书认为学校教育时间作为一种社会时间，被学校教育的“行动者”赋予了特定的价值和意义，是具有生产性的社会因素。在学校场域中，它是学校教育活动的表达方式，是一种“超越现在，指向未来”的观念，是权力规训展开的有效途径。为了更好地关照现实和弥补理论研究的不足，本书主要从社会学的角度，通过“概括性教育事实”，选取了与学校教育时间紧密联系的两个主题——“超越”和“规训”展开进一步分析，对现代学校教育时间进行了阐释。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	504
106	互联网时代高校思政课翻转课堂的理论与实践	9787565145759	\N	赵晓春 	0	1-1	0	42.00	171.0千字	南京师范大学出版社有限责任公司	165	\N	50	2020-04-01	/book/efc13c9f-8200-4aa7-81bc-ad87286567069787565145759.jpg	起源于美国的翻转课堂，是互联网时代的智慧教育。它发挥信息技术与教育教学高度融合的优势，对课堂内外的学习时间和学习空间进行重新规划和利用，实现育人标准和育人方式的创新。本书为近五年来，笔者将翻转课堂运用于高校思政课的理论探索与成功实践的成果。本书共五章，第一章和第二章属于理论部分，对互联网时代的高校思政课以及高校思政课的学习革命：翻转课堂作了理论性探讨。第三章，结合教学实践，创造性地提出了高校思政课翻转课堂教学策略。第四章“高校思政课翻转课堂教学攻略”中，详细介绍了高校思政课翻转课堂教学流程、教学互动、考核评价，具有较强的可操作性;第五章“高校思政课翻转课堂实践成果”，总结了笔者在教学实践中最具特色、最富成效的两大方面，一是在线讨论，二是小组实践，前者强调学思并重，后者重视知行合一。附录部分收录了校内外媒体对笔者思政课教学改革的诸多报道，笔者参加相关学术交流产生学术影响的介绍，以及学生们在翻转课堂教学模式下学习思政课的心得与感悟。总体来看，全书结构完整、逻辑清晰、语言简练，将理论与实践相结合探讨互联网时代高校思政课翻转课堂的“金课”建设，有较为突出的创新性和可操作性，以期对新时代新要求下的学校思想政治理论课改革创新有所启迪与贡献。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	484
107	响水方言	9787565144349	\N	主编 裴彦贵 	0	1-1	0	68.00	240.0千字	南京师范大学出版社有限责任公司	300	\N	30	2019-12-01	/book/da054c0e-463a-45fa-a318-de68f7ccb03f9787565144349.jpg	本书是响水县政协组织征编的文史图书，采用田野调查和资料收集相结合的方法，历时近三年，客观地考证了响水成陆的历史和先民的由来，系统地分析了响水人的语音特点，比较全面地收集整理了流传在响水地区的使用频率较高、人们耳熟能详的方言词汇词语，包括口头禅、俗成语、俗语、谚语和歇后语等，并予以适当的注音和释义。这些在生产和生活中形成的方言词语，生动记录和描绘了响水地区社会风俗、生产方式、生活习性、思想观念、审美情趣、人文环境等多种文化内涵，散发出响水地区社会生活的独特韵味。本书是一本融地域性、实用性、知识性、研究性、趣味性于一体的响水方言集大成之作，对于响水人了解自己的本土文化，对于语言学者、在响工作的外地人士、海内外响水籍人士及其子孙后代，都很有价值和意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	689
108	“生活化、游戏化”幼儿园课程	9787565144424	\N	主编 孟瑾 副主编 田鸿 	0	1-1	0	45.00	309.0千字	南京师范大学出版社有限责任公司	277	\N	40	2019-12-01	/book/e4870e35-fe57-408d-93d2-f2f1f132971c9787565144424.jpg	《生活化、游戏化幼儿园课程》是基于苏州幼儿师范高等专科学校附属花朵幼儿园全体教师多年集体智慧的结晶，以生活化、游戏化为指引，对幼儿园课程建设进行了梳理与总结，较为全面且系统地介绍了生活化、游戏化课程的理念、发展历程、目标、内容的选择、组织及实施、评价以	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	908
109	现代汉语斥量名词研究	9787565143632	\N	王红侠 	0	1-1	0	49.00	221.0千字	南京师范大学出版社有限责任公司	275	\N	60	2020-06-01	/book/ffef01ab-43b7-427c-8e04-82ac506a28f99787565143632.jpg	本书的内容特色主要有：1.依据名量关系标准提出了名词次类“斥量名词”。斥量名词-普通名词是以外在形式特征而非意义标准对名词进行的次类划分，是名词语法分类的大胆尝试，也是汉语语法理论的一次创新。2.打破了斥量名词属于少数边缘名词的偏见。传统的观点认为斥量名词属于少数名词、边缘名词、不典型名词，汉语作为第二语言的教学难以回避。等	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	493
110	大学内部治理论（精装）	9787565146244	\N	胡建华 王建华 陈何芳 	0	1-1	0	85.00	352.0千字	南京师范大学出版社有限责任公司	337	\N	26	2020-06-01	/book/0dfc7ae1-08a2-4f3e-abb3-017fece7519d9787565146244.jpg	本书是国家社科基金项目研究成果，入选国家出版基金项目。大学治理是近年来引起人们广泛关注的一个重要课题。不仅学术界有众多的研究与讨论，政府的文件、大学的章程也都提出要构建现代高等教育治理体系，提高大学治理能力。大学治理是高等教育治理体系中的主要部分。在现代大学治理结构中，虽然外部治理，尤其是政府的作用影响着大学的办学行为，但是大学内部治理能力与水平对大学的发展是至关重要的。本书以大学内部治理为主要研究对象，全书7章，内容上可以分为两大部分。前4章分别从理论与实践的结合上论述了大学内部治理问题的分析框架、大学内部治理结构、权力以及大学内外部治理关系；后3章分别研究了在大学治理上颇具代表意义的美国、英国、日本三个国家大学内部治理的结构、组织、权力以及治理改革等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	839
111	教育统计学——思想、方法与应用（第三版）	9787565146930	\N	主编 徐文彬 副主编 吴红梅 彭亮 	0	1-1	0	52.00	355.0千字	南京师范大学出版社有限责任公司	301	\N	30	2020-08-01	/book/8ef6f42e-7979-4803-9021-955b694c390c9787565146930.jpg	本书为修订第三版。本次内容修订，一方面是充分反映学科教学理论与实践的最新发展，另一方面是替换原有陈旧的内容、数据或案例，并编配相应的数字资源。与国内同类教材相比较而言，本教材具有以下几个方面的特点：体例结构方面，由教育统计学的基本思想、描述统计学、推断统计学和SPSS在教育统计中的应用等组成，并首次明确表明，教育统计的思维方式是经验的、归纳的和从部分到整体的思维方式，其基本思想就是在这种思维方式指导下的具体思维过程的统计思想。例习题选编方面，选取具有实际背景，甚至真实的课堂教学和教育研究中的具体事例。统计软件应用方面，用高度概括的教育真实实例简明扼要地介绍SPSS在教育统计中的应用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	890
112	钢琴实用教程（1）（第5版）	9787565144417	\N	主编 陈星 孙霞 	0	5-1	0	36.00	442.0千字	南京师范大学出版社有限责任公司	188	\N	30	2020-08-01	/book/62c60184-9fe2-45b4-b5b1-7aeff3ba0e4d9787565144417.jpg	本套教材是一套较为全面的综合性教材，主要服务于各学历层次的学前教育专业，钢琴教学和其它各类师范院校的钢琴教学，还适用于儿童钢琴教学和幼儿音乐教育活动，教材分为两册，主要有三部分：一、介绍钢琴弹奏的基本常识，包含钢琴介绍、钢琴弹奏的基本姿势和手型的图片文字	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	502
113	教育大数据理论与实践	9787565144608	\N	施聪莺 徐朝军 	0	1-1	0	48.00	299.0千字	南京师范大学出版社有限责任公司	216	\N	46	2019-12-01	/book/d55f4ea2-628b-449e-a670-37be4665cc3d9787565144608.jpg	本书从教育要素、教育活动出发，结合大数据教育研究实践，提出教育大数据研究范畴，从大数据来源探索了教育大数据踪迹，详尽描述了教育大数据生态构成和教育大数据常用分析工具和算法，并从实践出发展现了教育大数据技术在资源建设、信息化工程、社区用户行为分析等方面的应用。本书首先概述教育大数据的研究范畴、来源、安全与共享；接着介绍常用的数据分析算法和大数据生态；并结合web教育资源、“校校通”工程等展示了教育大数据的应用魅力；最后介绍了大数据背景下心理健康云平台和危机干预系统的实践案例。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	183
114	智力障碍儿童生活数学学科实施指南	9787565146992	\N	华东师范大学中国言语听觉康复科学与ICF应用研究院等 	0	1-1	0	12.00	56.0千字	南京师范大学出版社有限责任公司	54	\N	200	2020-08-01	/book/638384fe-ff8b-42cf-84d4-7de80ec6f44c9787565146992.jpg	　　生活适应学科作为必修科目，它主要是结合不同年龄段学生的成长、生活和发展需求，整合各学科获得的知识与技能，借助现实生活的载体，将习得的知识与技能转化为实际生活能力，从而提高学生的生活和生命质量。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	319
115	新教育公平视野下的学校再生产	9787565145995	\N	主编 程天君 著者 高水红 	0	1-1	0	42.00	192.0千字	南京师范大学出版社有限责任公司	187	\N	40	2020-09-01	/book/961943ac-a5c4-480a-abc6-93048adefa639787565145995.jpg	《新教育公平视野下的学校再生产/新教育公平研究丛书》将目光聚焦于学校教育过程，旨在关注不同地位群体学生的真实处境，并揭示其背后的作用机制。研究发现：不同地位群体在教育获得上存在差异。城乡学生在时空意识上的差异导致了其心智的不同，这一不同决定了他们在学校中的不同处境。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	605
117	马拉古奇导论	9787565102806	\N	【英】桑德拉·斯米特 译者 吴媛媛 	0	1-1	0	45.00	170.0千字	南京师范大学出版社有限责任公司	\N	\N	40	2020-01-01	/book/52b5456e-59b4-4cfe-836d-e89577f0bf929787565102806.jpg	该书是《世界著名教育家评传》丛书中的一本，是关于瑞吉欧创始人马拉古奇的评传，讲述瑞吉欧创始人马拉古奇的学术成长、从事学前教育事业的历程。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	552
118	当代中国名家双语阅读文库·迟子建卷	9787565147241	\N	著者 迟子建 译者 Michael Day，Aaris Woo，Luisetta Mudie，Denis Mair 	0	1-1	0	38.00	279.0千字	南京师范大学出版社有限责任公司	359	\N	48	2020-10-01	/book/79b746f3-37ab-43a3-b0f9-d5b8bfc19e509787565147241.jpg	《当代中国名家双语阅读文库》共两辑十卷，分别遴选了叶兆言、毕飞宇、苏童、范小青、鲁敏（第一辑），叶弥、迟子建、赵本夫、贾平凹、韩少功（第二辑），共十位当代中国深具文化影响力的作家，精选其优秀短篇代表作，邀请英语为母语的海外汉学家或英语水平等同于母语的翻译	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	815
119	国际理解教育课程建设的国际比较研究	9787565147272	\N	张蓉 	0	1-1	0	68.00	382.0千字	南京师范大学出版社有限责任公司	370	\N	24	2020-12-01	/book/22e244cd-29f7-4109-93d2-745350b010db9787565147272.jpg	开展国际理解教育，培养学生的国际理解素养已经成为全球化时代各国教育改革的主要策略之一。国际理解教育课程则是开展国际理解教育的重要载体。在全球化这一世界教育变革的大背景下，从国际比较的视角讨论国际理解教育课程建设问题，以美国、英国、日本、澳大利亚及中国等五个有代表性的国家为研究对象，论述这些国家国际理解教育课程发展的社会背景、政策导向和国际理解教育课程目标、内容、实施途径及评价方式，并比较其异同，总结世界国际理解教育课程的基本理念与改革趋向，将有利于进一步认清中国国际理解教育课程建设的现实，促进中国教育的改革与发展，丰富国际理解教育的理论体系。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	464
120	活的教育与活的教师——南通市新生代教学名师案例研究	9787565147661	\N	南通市陶行知研究会 	0	1-1	0	78.00	487.0千字	南京师范大学出版社有限责任公司	480	\N	\N	2020-12-01	/book/7af2fc4a-459d-4bfe-8668-8517a1c3733b9787565147661.jpg	本书系江苏省教育科学“十三五”规划课题（陶行知教育思想研究专项）“活的教师核心素养及其生成研究”的主要成果。书稿基于陶行知“活的教育”思想，紧扣当下基础教育实际，对践行“活的教育”的主体——“活的教师”的核心素养、生成机制问题，进行了现状调查、理论探索和实践研究，探讨了教师“活化”和基础教育“活化”的相关问题，内容丰实而理念前瞻。该书在陶行知教育思想研究方面有着鲜明的继承性、创新性，对于新时代加强教师队伍建设，造就一支党和人民满意的高素质、专业化、创新性基础教育教师队伍，具有较强的参考价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	915
121	世说新语导读	9787565145018	\N	王青 	0	1-1	0	48.00	253.0千字	南京师范大学出版社有限责任公司	225	\N	36	2020-09-01	/book/7ed3ff5f-45f8-4494-ad6a-724ff6df54869787565145018.jpg	书旨在以通俗易懂的方式向读者介绍《世说新语》的作者与写作背景，并从人物与语言两方面入手，结合当时的社会状况，分析《世说新语》的写作特点、艺术价值，进而指出此本经典在文学史上的影响。本书特点是语言明白晓畅，图文并茂，并根据文本特点，在“知识链接”或“拓展	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	344
130	硬笔楷书速成歌诀	978-7-5618-6887-4	9787561868874	李国钟 	\N	1-2	16开	29.80	141.0千字	天津大学出版社	88	\N	\N	2021-04-01	/book/2d22fbd6-f3db-4ca1-8711-c0736cb320379787561868874.jpg	本书从最基本的横画开始，让学员逐渐体会运腕的基本要领，逐步掌握顿笔和迟速。通过“塔式教学法”使字例练习的范围越来越大，进一步掌握笔画形态变化的四大因素（长度、圆度、斜度、顿笔度），使学生在学习书法时做到“意在笔先，笔居心后”，通过回宫格逐步掌握笔画的外延（放开）的规律。本书的书写技巧全部以口诀形式出现，通俗易懂，简明易学，便于记忆，并能很快形成应用，对楷书快写有一定作用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	228
122	美术史与观念史25、26	9787565147456	\N	主编 范景中 曹意强 刘赦 执行主编 杨振国 	0	1-1	0	108.00	599.0千字	南京师范大学出版社有限责任公司	288	\N	14	2020-12-01	/book/237fba8b-1cf3-49d2-b4d9-51bdf8aeb7cf9787565147456.jpg	本书是美术史与观念史系列丛书第25、26册，延续丛书的传统，上册主要是西方美术著作翻译和观念、作品等的分析；下册为中国艺术家、艺术作品、艺术现象的研究。不同于前面几期都是以约稿的方式确定全书的主题，本次是在全世界美术史研究领域公开征稿，经过编委会商讨审稿后确定的，共遴选出了二十几篇文章，其中外国部分12篇，中国部分11篇。作者既有美术史与观念史领域名家，也有美术史研究领域的后起新秀，代表了当代中国美术史与观念史研究的水平和视野。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	605
169	我的中国梦—红色经典故事	978-7-5631-3093-1	9787563130931	中共浙江省委党史研究室主编；买买提·托合提译 	0	1-1	0	13.50	73.0千字	新疆大学出版社	106	\N	80	2020-12-01	/book/a946f0d2-16e2-4661-99d5-ab71d292b6cb9787563130931.jpg	本书通过浙江优秀儿女的精彩故事，引导读者走进近代中国历经磨难的风雨沧桑，感受中国共产党成长壮大的曲折历程，了解中华儿女为铺就强国之路付出的努力和心血。《请战》《铁道部的“神眼”》《战旗重插会稽山》等一篇篇感人的故事，是镌刻中华民族自强不息的不朽丰碑，是见证中国人民发愤图强的历史画卷。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	925
123	国家联系网络的结构演化	9787565133787	\N	车冰清 	0	1-1	0	68.00	206.0千字	南京师范大学出版社有限责任公司	192	\N	34	2020-12-01	/book/c59303f1-85e9-41db-beea-5196b68637a99787565133787.jpg	本书作为探索全球国家联系网络结构演化的创新成果，聚焦新时代国家合作的理论研究与“一带一路”建设实践，在界定相关概念内涵和构建基于媒体大数据的国家联系强度评价模型的基础上，从基础环境、热点区域、国家等级体系、关系网络等层面展开具体研究，并分析“一带一路”建设的发展成就与不足，提出“一带一路”建设的路径优化和重点举措。本书得到以下科研项目资助——国家自然科学基金重点项目(41430635)：区域空间结构演化机理与模式体系构建研究；国家自然科学基金项目(41671122)：面向“一带一路”战略的淮海经济区空间组织响应及优化研究。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	686
124	江苏省区域经济发展与格局优化	9787565147432	\N	管卫华 	0	1-1	0	68.00	227.0千字	南京师范大学出版社有限责任公司	198	\N	40	2020-12-01	/book/01cfe9f6-9c27-40d3-a912-813533f94b0c9787565147432.jpg	系国家自然科学基金（41271128）项目成果。江苏省区域经济差异长期以来一直是制约江苏省区域经济协调发展的主要原因，因此本书试图对改革开放以来江苏省区域经济差异变化特征和原因进行多视角分析，着重分析江苏省区域产业集聚与区域经济差异之间的关系，据此分析江苏省区域	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	839
125	百年上大画传（普及版）	9787567139503	\N	成旦红 刘昌胜 主编 	平装	1-1	20开	98.00	\N	上海大学出版社	\N	\N	\N	2020-10-01	/book/3e14d10c-0af0-4759-896b-67580ef6606a1070228.jpg	1922年10月，国共合作曾创建了上海大学，校长为于右任，教务长为瞿秋白。这是一所被誉为“武有黄埔、文有上大”的革命学校，1927年被国民党当局强行关闭。1983年，上海市人民政府在复旦大学分校、上海外国语学院分校、华东师范大学分校、上海科学技术大学分校、上海机械学院轻工分校、上海美术专科学校的基础上复办上海大学（简称原上海大学）。1994年组建的上海大学是上海市属、国家“211工程”重点建设的综合性大学，是教育部与上海市人民政府共建高校，上海市首批高水平地方高校建设试点，教育部一流学科建设高校。上海大学是拥有悠久传统和红色基因的大学，是走过峥嵘岁月和光辉历史的大学，它的诞生、成长、发展和壮大，始终与国家和民族以及我们所在的城市同呼吸、共命运、心连心。本书从档案中挖掘历史，以图片的形式展现上海大学100年来的办学历史、发展轨迹、重大事件和杰出人物，展现不同时期上大人不懈努力的精神风貌。本书的出版，旨在让我们牢记历史、牢记“上大人”身负的责任，不忘初心，砥砺奋进。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	895
126	上海大学（1922—1927）师生诗文书信选	9787567141674	\N	胡申生 编 	平装	1-1	16开	68.00	\N	上海大学出版社	\N	\N	\N	2021-03-01	/book/7bab01ae-196c-4ab2-919d-da98b2dcd0c71070232.jpg	上海大学（1922—1927）的办学历史虽然只有短短的5年，却留下了大批诗文和书信。虽然其中绝大部分随着学校被封和兵燹之祸湮没和散失，但新中国成立以后，随着寻找力度的加强和研究的深入，找到了其中的一部分。这些诗文书信的搜集出版，不仅对于了解和研究老上海大学有着重要文献价值，对于传播红色文化进行革命传统教育也有着很重要的意义。诗文和书信入选的范围包括：老上海大学的教师、学生；在1922—1927年上海大学存世期间，诗文作品和书信的内容和老上海大学有关联；烈士的遗嘱；具有重大影响的烈士代表作品等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	460
139	安装工程造价	978-7-308-20858-1	\N	巩学梅 周旭芳 主编 	平装	1-1	16开	55.00	\N	浙江大学出版社	\N	\N	\N	2021-03-01	/book/42a644ca-3459-49c5-b1e9-b7cf9f3861e91070336.jpg	本书立足应用型本科人才培养，基于真实工程项目，以完成暖通空调工程、电气工程、给排水工程、工业管道等多单位安装工程造价任务为主线，结合工程经济知识和现行定额规定，并配以相应专业知识的精述，介绍了清单计价和工料单价两种计价模式的计量和计价方法。针对现有过分注重理论和过分注重技能培养的两种误区，基于真实工程项目，采用项目化教学思路，注重经济管理思维培养，配合微视频讲解，为应用型本科人才培养提供合适的教材。适合建筑环境与能源应用工程、给水排水工程、建筑电气与智能化、工程管理、工程造价、房地产经营管理专业、物业管理等本科专业。适合大三、大四学习。 本书共7章。主要包括：安装工程项目招标说明、造价理论基础、电气设备安装工程造价、通风空调安装工程造价、工业管道安装工程造价、给排水安装工程造价、建筑消防与智能化安装工程造价等内容。 本书以一个机电设备安装工程招标项目案例的招标控制价编制为主线进行编写，在第1章中就以“安装工程项目招标说明”抛出造价任务，引导学习者进人造价从业人员的角色，带着明确的目标开展后续学习。本书编写结合了《浙江省通用安装工程预算定额》和工程实际的相关规范、规定，反映了本领域当前的主流知识和技能要求，并注重结合不同案例阐述造价过程中需要注意的问题，比如在第6章给排水造价中重点阐述了投标报价和招标控制价编制的异同点，在第7章智能化工程造价中重点说明了补充清单编码的做法。本书结构合理，系统性强，各章末附有思考与启示和习题，便于学生理解书中阐述的基本理论与方法、进行知识拓展，有利于学生从业能力和学习能力的培养。本书各章紧密联系，但又相对独立，便于教师在教学中取舍和学生自学。 作为新形态教材，本书针对主要知识点均配备了授课视频，读者可扫描二维码学习。同时，配套提供一套招标项目案例资料，供造价作业选用。另外，本书提供编写参照的定额扫描文件，仅供教学过程参考使用。 本书可作为工业与民用建设工程类专业，如工程管理、造价工程、建筑环境与能源应用工程、土木工程、石油化工工程等专业为提升工程经济知识、能力、素养而开设课程的教材；亦可作为造价从业人员的参考用书。另外，因其灵活的模块化设计，大学本科高校、高职院校以及中等职业教育等不同层次院校均可选用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	519
127	校长创新领导力:引领学校走向卓越（第8版）	978-7-5760-0689-6	\N	加拉德·C.乌本 	平装	1-1	16开	108.00	\N	华东师范大学出版社	\N	\N	\N	2020-10-30	/book/4c4f160c-7afc-4dfc-a0d0-2ecc5d9a3ca91070236.jpg	本书从社会与历史基础出发，立足于学校的组织管理案例研究，具体分析了校长如何开创领导力和通过系统规划提升对学校的改造等，以平白的语言阐释了每一位校长在工作中所遇到的现实问题，涵盖了校长日常工作中的各个方面，从管理基础、操作的基本原则与细节，到与组织和评价相关的现实与事务。详细讨论了组织文化、受到挑战的社会事务，深入探讨了当今学校中包括校园欺凌、青少年厌学以及残疾学生等问题，并对于此类现实问题进行了案例研究。本书在讨论关于组织、领导的当代观点的同时还涉及了被当今许多专业标准委员会所采用的标准。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	709
128	海洋结构金属腐蚀机理及防护	978-7-5618-6892-8	9787561868928	余杨，余建星 	\N	1-1	16开	45.00	275.0千字	天津大学出版社	168	\N	\N	2021-03-01	/book/84eb8048-be9e-493b-858a-614b7fc86c299787561868928.jpg	本书旨在通过对金属电化学腐蚀基本原理、腐蚀类型及防护措施的介绍，以加强腐蚀工作者或交叉学科工作者的理论水平。本书主要介绍了金属电化学腐蚀的基本原理、金属局部腐蚀的类型、金属电化学测试方法及金属腐蚀的防控措施。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	422
129	难忘清华	978-7-5618-6878-2	9787561868782	马国馨 	\N	1-1	16开	96.00	358.0千字	天津大学出版社	384	\N	\N	2021-03-01	/book/127cd673-54bc-4f52-a42a-5bb57c5b952c9787561868782.jpg	本书收录了作者几十年来曾经撰写的与母校清华大学相关的部分文章，内容丰富，情感真实。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	960
131	商业智能：方法与应用	9787560659107	\N	温浩宇 	0	1-1	16开	31.00	230.0千字	西安电子科技大学出版社	160	\N	16	2021-04-27	/book/6e25f845-32c5-4696-938d-c1e49780b0371070269.jpg	本书系统地介绍了与商业智能（也称为商务智能）相关的基础知识和技术，用简洁、清晰的语言讲解了数据分析、数据挖掘、数据可视化等技术和管理模式。 全书共分为10章，内容包括商业智能概述、联机事务处理与联机分析处理、数据仓库、数据挖掘、人工神经网络与机器学习、Web挖掘与文本分析、用户画像与推荐系统、数据可视化、报表自动化系统、大数据技术与应用。本书提供了多个典型应用，以帮助读者理解各种技术工具及其在商业智能实践中的作用，章末给出了课后思考题，以便于教师对学生的学习情况进行考查。 本书可作为高等学校计算机、信息管理、电子商务和工商管理等相关专业的教材，也适合广大商业智能管理者自学使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	838
132	采购管理（第2版）	9787302578871	\N	孙旭、贾强法、刘子玉、温卫娟 	平装	1-1	16开	58.00	\N	清华大学出版社	\N	\N	\N	2021-05-01	/book/647a312c-253d-4a4c-a621-968dce2b10071070277.jpg	本书在借鉴和吸收国内外采购管理理论和最新研究成果的基础上，紧密结合物流企业采购管理发展的新形势和新特点，系统阐述：采购战略规划、采购组织与人员、采购计划和预算、采购决策与选择、采购招投标与评标、采购绩效考核与评价、供应商管理、电子商务采购、国际采购等采购管理的基础知识、基本技术方法，并通过实证案例分析讲解和就业能力训练，培养提高读者的应用能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	533
133	面向未来的新工科建设——新理念	9787040553079	\N	林健 	平装	1-1	16开	60.00	\N	高等教育出版社	\N	\N	\N	2021-01-01	/book/bb6d5e3c-3b5f-4cb1-8f89-da311942d6951070286.jpg	本书是作者近年来针对新工科建设中必须面对且普遍存在的核心和重大问题所开展的系统性研究成果。新工科建设作为“卓越工程师教育培养计划”2.0，本书既是作者在“卓越工程师教育培养计划”方面研究的继续和深化，也是作者在工程教育发展与改革方面的第三部专著。全书以面向未来需求的工程教育改革为导向，以建设工程教育强国为目标，着力突出新工科建设中的新理念、新模式和新突破，力求为各种类型高校和众多工科专业的新工科建设提供系统性、专题性、前沿性和可操作性的参考和指导。 本书内容由六部分组成。*部分既从总体层面讨论新工科的内涵特征，建设目标、原则、思路，分类建设和建设重点，又分析新工科建设对“卓越计划”内涵8个方面的丰富和加强。第二部分从7个方面讨论和分析如何组织和有效实施新工科建设所依托的新工科项目。第三部分集中探讨新工科教育质量标准体系的构建以及具有纲领性作用的新工科教育质量通用标准的研制。第四部分系统深入地研讨新工科建设中两大主体专业的建设，即新型工科专业建设和新生工科专业建设。第五部分针对新工科专业人才培养中*核心的两个环节即课程和教学，重点讨论课程体系改革与课程建设以及挑战性学习。第六部分全方位研讨新工科专业人才必须面对的理解、解决复杂工程问题的能力培养。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	487
134	审计实务	978-7-5645-7717-9	\N	耿聪慧 	0	1-1	16开	35.00	510.0千字	郑州大学出版社	257	\N	10	2021-04-01	/book/17a0f04f-8537-4798-a04c-9c4c41b426a01070289.jpg	本书将审计理论和审计实务相结合，使内容更贴合实际，更具实用性和可操作性，注重培养和提高学生运用所学的理论分析和解决实际问题的能力，为培养高素质技能型人才提供更好的服务。本书提供了实训操作知识和审计实训的工作底稿，让学生可以在做中学、学中做，主要包括承接业务、制定审计计划、风险评估、销售与收款业务审计、采购与付款业务审计、存货与生产业务审计、货币资金审计、业务完成阶段、审计报告等内容。审计是由独立的专门机构和人员接受委托或根据授权，依法对被审计单位的财务报表和其他资料所反映的经济活动的真实性、合法性、效益性进行审查并提出结论的一种监督、鉴证和评价的活动。其中，真实性是指反映财政收支、财务收支及有关经济活动的信息与实际情况相符合的程度；合法性是指财政收支、财务收支及有关经济活动遵守法律、法规或者规章的情况；效益性是指财政收支、财务收支及有关经济活动实现的经济效益、社会效益和环境效益。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	922
135	国际体育与健康=International	978-7-5645-6632-6	\N	聂东风 	0	1-1	大16开	119.00	1262.0千字	郑州大学出版社	504	\N	4	2021-04-01	/book/5aec230d-3a85-4e4b-bf13-dc4caa20becf1070296.jpg	国际体育与健康为国内首本相关公共体育教学的双语教材。其适用对象为普通高校的国际留学生和中国学生。总体内容分为体育理论篇、流行运动篇、特色运动篇3篇15章。其中体育理论篇涵盖体育与健康概述、体育锻炼的科学认知、体育锻炼的科学控制、国际体育的现状与发展4章内容。流行运动篇介绍篮球、排球、足球、网球、乒乓球、羽毛球运动的概述和基本技战术与规则。特色运动篇则包括美式橄榄球、板球运动、健美操运动、健身瑜伽、武术运动等东西方体育特色项目。全书立足国际，中英对照、图文并茂，为大学体育教育的国际化服务。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	644
136	妇产科学学习指导	978-7-5645-7538-0	\N	韩丽萍 	0	1-1	大16开	49.00	297.0千字	郑州大学出版社	102	\N	20	2021-04-01	/book/6d888327-7f95-4f19-8ee4-0051587e9f9a1070299.jpg	本学习指导共分五个版块，即临床病历的书写、妇产科临床实践操作技能、产科常见疾病、妇科常见疾病，以及妇产科常用药物。其中妇产科常见疾病部分设计为案例加问答的形式，阐明了临床实践中的具体问题，一步一步地解释它们，并设有课后讨论，既贴近临床，又能激发学生的学习兴趣。这种方法使医学生能够快速、方便、准确地掌握与各种情景相关的临床医学知识。本书内容清楚，简明扼要，重点突出，在满足医学生不断丰富理论知识的愿望的同时，兼顾了妇产科临床工作的繁忙性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	215
137	产科抗感染药物临床应用	978-7-5645-7685-1	\N	朱锦明,石祥奎 	0	1-1	大32开	38.00	111.0千字	郑州大学出版社	129	\N	34	2021-04-01	/book/1c515041-3b1b-4383-b8e3-3f7f97edb5b91070305.jpg	近年来，由于抗生素应用缺乏规范，不少医疗机构存在抗生素滥用情况，人群中产生大量耐药性，对人类抗病产生不良影响。作为临床比较特殊的产科来讲，抗生素规范使用显得尤为重要。孕产妇抗生素应用可能同时对母婴产生影响，有些药物还可能影响胎儿正常发育。因此，产科抗生素规范应用非常重要。该书系统阐述了女性生殖道正常菌群特点、女性生殖道致病特点及围产期女性感染用药原则，为临床规范，保障母婴健康具有重要意义。本书可以为临床医师及药师工作提供很好的指导。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	894
138	赛道上飘起的五星红旗	978-7-5482-4202-4	\N	陈工著 	平装	1-1	16开	48.00	275.0千字	云南大学出版社	294	\N	\N	2021-04-01	/book/bedeb2d0-feac-45e6-bf65-68e26aa58d431070330.jpg	该书为纪实性长篇小说，主要讲述主人公恒瑞在中国和美国的个人成长史、精神成长史。恒瑞是一个特立独行的男孩，早年被父母送到南京的贵族学校读书。但远离父母，导致恒瑞出现了叛逆。之后他和一群同学被送到美国念高中。到了美国，恒瑞走上了赛车之路，并在美国赛车手的歧视和同胞的冷眼中克服重重困难，获得冠军。他的事迹被新浪等国内主流媒体以《赛道上飘起的五星红旗》为题进行了广泛的报道。全书分为二十三章，真切地展现了中国年青一代的爱国情怀。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	526
760	分子发光与药物代谢分析研究	9787566619129	9787566619129	孙汉文课题组 	\N	1-1	16开	398.00	\N	河北大学出版社	\N	\N	\N	2021-10-07	/book/11fdf665-08fa-483b-90b8-51e76912f46b9787566619129.jpg	本选题介绍以高锰酸钾体系化学发光机理与在抗拒抗癌药物分析中的应用，重点讨论超常氧化态配合物化学发光机理与抗菌消炎抗癌药物的分析，研讨电致化学发光、量子点化学发光机理与氨基酸及配伍药物分析，介绍氨基酸分子和药物分子识别与生物亲和电极对药物代谢的影响。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	646
140	让建南钟声传响大山深处：厦门大学研究生支教团22周年访谈录	9787561579275	\N	赖虹凯 主编 	平装	1-1	16开	56.00	\N	厦门大学出版社	\N	\N	\N	2021-04-01	/book/d26d97c7-1044-412a-8ee1-534d3554fe7b1070340.jpg	厦门大学研究生支教团走过了22年的传承，时代的沧海桑田给支教地的发展和每一位支教队员的人生都打上了厚重的时代烙印。本书收录了厦门大学研究生支教团成立至今每一届队员代表的访谈，以及对曾经受支教学生和受援学校代表的专访。回看曾经的支教老师们重忆当年支教艰辛与初心，曾经的受支教学生如今也已事业有成。在这22年间，厦门大学研究生支教团所播下的每一个希望的种子，闪耀的每一个动人的瞬间，许下的每一个跨越山海的嘱托，终汇聚成了这本书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	752
141	北京市十大高精尖产业发展报告	9787563831906	\N	范合君 周芳 纪健恒 	0	\N	16开	55.00	273.0千字	首都经济贸易大学出版社	236	\N	\N	2021-05-01	/book/faa2bc01-4cc3-4b84-a737-30939ee2227d1070345.jpg	本书系统地介绍了北京市集成电路产业、新一代信息技术产业、人工智能产业、软件和信息服务业、智能装备产业、医药健康产业、节能环保产业、新能源智能汽车产业、新材料产业及科技服务业等十大高精尖产业，分别从产业重要性和技术经济特征、国内外发展趋势、国家和北京市的规划和政策、北京市产业发展概况、园区建设进展、企业上市及融资情况、主要企业七个维度，全面展示了每个产业的发展概况，通过与国外产业的对比分析指出了各产业在发展中存在的问题，提出了相关的对策建议，最后对各个产业未来的发展方向做出了展望。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	907
142	项目管控——完美掌控成本和进度	978-7-300-28900-7	\N	[美]兰德尔·威尔逊 	0	1-1	0	59.00	150.0千字	中国人民大学出版社	\N	289007	9	2021-05-10	/book/728d1bc1-b549-4ee7-8c4c-fb477902dfe81070347.png	本书通过七步，完成对一个项目的全程控制，保障项目的进度，成本预算的效益。七步包括项目的结构分析：项目和计划之间的差异,以及这些差异如何影响成本和调度。立项：如何开发项目章程和利益相关者,如何管理利益相关者。项目深度规划:成本分解,流程约束。项目进度分析:工作定义、WBS和工作簇,工作排序和制图; 论证估算资源;项目进度等。项目成本分析:收集和评估所有项目成本,包括劳动力、材料、供应商报价、分包商、合同、设备、设施,和直接/间接成本。预算：通过自上而下、自底向上和基于活动的方法。项目监测和控制:增值、甘特图跟踪,S-Curves,绩效考核,里程碑分析,危机控制系统,完成后评估,预测等等。 如何精通成本与进度控制？ 　　《项目管控：完美掌控成本和进度》有你想要的一切： 　　100%聚焦于成本与进度控制的项目管理指南 　　涵盖成本与进度的分析、制定、监督、控制 　　借助丰富的案例研究、实操范例、图表掌握关键技能 　　适用于任何组织中任何资历的项目管理人员 　　拥有项目管理研究和资格认证所需的全面知识体系 　　项目管理是涉及多个部门、多种资源的复杂过程，成功的关键在于对项目成本和进度的控制。在项目开发阶段，项目管理人员要花费大量的精力收集数据，合理制订所有项目活动的进度计划，精确估计项目成本、规划项目预算。在项目实施过程中，项目管理人员要监管、报告和控制项目活动，以确保项目按计划的进度和预算进行。 　　《项目管控：完美掌控成本和进度》全面介绍了分析与管控项目成本和进度的重要技术和方法，帮助项目管理人员关注项目生命周期中每个细节的安排，圆满完成关键任务的同时很好地兼顾项目活动与日常经营活动的资源平衡。书中丰富的案例和图表让这些技术和方法变得简单易学，可轻松应用于实际工作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	123
143	学会开一家公司：从创立到盈利的全流程指南	978-7-300-29339-4	\N	[英]保罗·伯恩斯（Paul Burns） 	0	1-1	0	79.00	250.0千字	中国人民大学出版社	\N	2015Z2271	\N	2021-05-26	/book/01497b8e-0eeb-41dc-aaae-0813dc20ad1c1070349.png	　《学会开一家公司：从创立到盈利的全流程指南》打破了创业不能教授的魔咒，为创业过程建立了一个七级新企业创建框架，一步一步指导创业者完成从计划到真正建立企业的整个过程，包括产生创意，发展商业模型，到融资。 　　《学会开一家公司：从创立到盈利的全流程指南》将企业家的实践经验、学术研究以及相关理论完美结合到了一起。 　　《学会开一家公司：从创立到盈利的全流程指南》打破了创业不能教授的魔咒，为创业过程建立了一个七级新企业创建框架，一步一步指导创业者完成从计划到真正建立企业的整个过程，包括产生创意，发展商业模型，再到融资。在商业和管理相关领域，创立一家新公司总是令人兴奋且激励人心。创立一家新公司的核心是创造力和创新——在当今竞争激烈的市场环境中，这是一种非常难能可贵的技能。总体说来，它整合了多个传统学科，并专注于实践。书中的技能只有被应用起来，才能显示其价值。如果你想要创业或正在创业，那么它可以帮助你了解创业的相关基础知识，并且把学到的技能知识运用于实践中，所以它特别适合创业者阅读学习。 　　一直以来，人们认为创业是不能教授的，商业头脑是与生俱来的。但创业学教授保罗-伯恩斯以他四十年的教学经验打破了这个神话。他本人也深受英国前首相、“铁娘子”玛格丽特·撒切尔的赏识。《学会开一家公司》是一本探究创业全流程的理论和实践问题的领先的创业教科书，是英国数十所大学商学院指定的创业学读本。 　　《学会开一家公司：从创立到盈利的全流程指南》对创业过程分阶段的逐步剖析，兼具深度和广度，书中的指点和实践建议可以降低创业失败的风险，很大限度地提升创业成功的概率，非常适合所有想要创业的人和初创公司创始人阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	450
144	宪法练习题集（第四版）（21世纪法学系列教材配套辅导用书）	978-7-300-29262-5	\N	胡锦光 	0	4-1	0	42.00	380.0千字	中国人民大学出版社	\N	292625	12	2021-04-15	/book/57f3ca50-4505-4bb5-a789-06b4620136271070354.png	本套“练习题集”是“21世纪法学系列教材”的配套辅导用书，按照教材的章节安排了同步练习题，帮助学生切实掌握课程内容，真正把专业知识学好。每章都设有名词解释与概念比较、选择题、简答题、案例分析题、论述题与深度思考题等题型。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	706
145	网店美工与视觉设计	978-7-300-29269-4	\N	邹凌空 闫寒 	0	1-1	0	38.00	130.0千字	中国人民大学出版社	\N	292694	10	2021-04-13	/book/39ff63ab-664a-4f55-979c-1fd2c1ef00531070362.png	本教材包括电商美工基础知识、商品图片的处理与美化、视觉设计基础知识、商品详情页的制作、网络店铺首页的制作、网络店铺视频的制作、移动端店铺的设计制作、综合案例。 　　《网店美工与视觉设计/职业教育电子商务专业实战型规划教材·普通高等职业教育“十三五”规划教材》详细介绍了网店美工所需要的基础知识与基本技能，通过案例、任务等多种形式，帮助学生在较短的时间内掌握网店美工所需的知识、技能与方法，具备良好的操作能力。 　　《网店美工与视觉设计/职业教育电子商务专业实战型规划教材·普通高等职业教育“十三五”规划教材》共8章，依次讲解网店美工入门基础、商品图片的处理与美化、电商视觉设计的基本要素、店铺Logo与主图的视觉设计、网店首页视觉设计、商品详情页的设计制作、网店营销推广图的制作、移动端网店的视觉设计与装修。 　　《网店美工与视觉设计/职业教育电子商务专业实战型规划教材·普通高等职业教育“十三五”规划教材》层次分明、重点突出、步骤清晰，能让学生更好、更快、更深入地掌握网店美工基本技能。 　　《网店美工与视觉设计/职业教育电子商务专业实战型规划教材·普通高等职业教育“十三五”规划教材》既可以作为职业院校电子商务、市场营销类专业的教学用书，也可以作为从业人员的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	547
146	教师英语口语训练（第三版）（21世纪小学教师教育系列教材）	978-7-300-29343-1	\N	王融、钱虹 	0	3-1	0	38.00	200.0千字	中国人民大学出版社	\N	293431	13	2021-05-31	/book/db430304-261c-43b8-ab7f-4a464ad93ef91070368.png	本书旨在训练教师英语口语和提高广大师生课堂互动英语能力。全书主要从课堂的时间顺序、上课的内容、师生交流、语音训练四个方面进行编写，内容涉及课前的基本问候、课中的提问、课堂活动、内容讲解、测验与考试、课堂作业，还包括课后师生的交流。本书整体编排清晰，结构合理，内容详尽，是帮助广大师生提高课堂会话和互动能力的参考必备，不仅可以作为英语授课教师的指导用书，也可以帮助学生进一步掌握课堂内容，更好地与教师进行沟通。修订版在第二版的基础上，增加了部分与学生听说交流、科学的教学手段等内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	518
147	消费者心理学（21世纪高职高专规划教材·市场营销系列）	978-7-300-29327-1	\N	刘清云 	0	1-1	0	38.00	260.0千字	中国人民大学出版社	\N	293271	11	2021-05-15	/book/3584bcaa-2207-4dd0-8a21-0c58574f1ffd1070373.png	随着社会的发展，人们的消费水平越来越高；随着互联网的普及，消费者的购物习惯及购物方式也在不断改变。企业的生存和发展需要研究消费者的心理与行为，因此，营销人员必须具备相应的消费者心理学知识，以更好地把握消费者的心理，开展相应的营销活动。 　　《消费者心理学/21世纪高职高专规划教材·市场营销系列》从消费者心理学概述人手，涉及消费者的心理活动过程、消费者个性心理特征、消费者购买过程中的心理活动、影响消费者心理变化的因素、不同消费者群体的心理分析、主要消费品市场的消费心理分析、营销沟通与消费心理、网络消费者特征及心理分析共九个模块。 　　《消费者心理学/21世纪高职高专规划教材·市场营销系列》既可以作为高职高专院校市场营销及相关专业教材，也可以作为市场营销人员培训、参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	510
148	幼儿园家庭教育指导（实践应用型学前教育专业规划教材）	978-7-300-29056-0	\N	王普华 	0	1-1	0	39.00	200.0千字	中国人民大学出版社	\N	290560	9	2021-05-27	/book/a3b2a6d4-5380-4968-91a5-255d50135f5f1070377.png	教材主要设置十二章内容，分别为：家园合作共育的重要性、家园合作关系的建立、来离园交流与指导、个别约谈、辨析讨论会、家长会、家庭教育讲座、家庭教育经验交流会（沙龙）、家长进课堂活动、家长开放日活动、亲子趣味活动、家园共育主题活动。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	754
149	金融科技合规实务（21世纪高职高专规划教材·金融保险系列；浙江省普通高校“十三五”新形态教材）	978-7-300-29338-7	\N	靖研 曹文芳 吴金旺 	0	1-1	0	35.00	185.0千字	中国人民大学出版社	\N	293387	9	2021-05-31	/book/d8ae1ce8-f81a-4780-9730-19957391085e1070378.png	全书从互联网金融典型业态展开，分析了互联网金融隔业态的发展及涉及风险，在此基础上梳理了相关业态涉及的法律法规，并囊括了当下处于新兴发展态势的互联网征信、大数据金融、区块链金融、智能投顾、虚拟货币等领域，并配有丰富的案例分析和实战演练。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	103
150	税务会计（第4版）（普通高等学校应用型教材·会计与财务）	978-7-300-29325-7	\N	梁文涛 	平装	4-1	16开	59.00	618.0千字	中国人民大学出版社	\N	2020F0128	\N	2021-05-26	/book/55e6be93-0ed4-4331-838d-08cc8c8692a41070386.jpg	本书主要讲授企业税务会计实际工作所必需的各税种的计算、会计核算和纳税申报等问题，突出了税务会计的实用性和应用性，让学生在学习税务会计理论知识的同时，提升税务会计的实践和应用能力。其主要内容包括税务会计总论、增值税会计、消费税会计、企业所得税会计、个人所得税会计、其他税种会计。 本书最大的特色在于：强调“理实一体、学做合一”，更加突出实践性，力求实现情境化教学。教材编写形式和内容适合应用型人才培养特点。每章开头设置“能力目标”，让学生首先能够明确本章的学习目标。在每章具体学习之前设置“工作引例”，在每节具体学习之前设置“情境引例”，激发学生的学习兴趣。在税务会计知识的讲授过程中，一方面设置“点拨指导”“特别提示”“归纳总结”“知识链接”等模块，再次激发学生的学习兴趣；另一方面融入税务会计实例，通过“工作实例”“工作要求”“工作实施”对税务会计实例进行分析与操作，让学生体验案例学习的趣味，又一次激发学生的学习兴趣。每章的最后设置“技能训练”“实战演练”；并配备单独的《习题集》，设置“技能训练”（含单项选择题、多项选择题、判断题、业务题共4种题型）和“实战演练”，并附有参考答案，让学生通过训练和实战，进一步理解和掌握所学知识。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	369
158	养老机构经营与管理	978-7-305-21953-5	\N	李健、石晓燕 	0	2-1	16开	42.00	338.0千字	南京大学出版社	224	\N	40	2020-12-01	/book/245a7afe-d336-407c-adb4-cd5b75013af01070486.png	本书共有七个学习单元，内容包括：初识养老机构、养老机构建设管理、养老机构的运营、养老机构的组织管理、养老机构的服务管理、养老机构财务与后勤支持管理、养老机构安全管理。适合作为高校老年专业学生的学习用书，也可以作为相关从业者的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	474
178	读好大学六堂课	978-7-5645-7737-7	\N	吴金星 	0	1-1	小16开	49.80	272.0千字	郑州大学出版社	271	\N	8	2021-05-01	/book/7f7f556e-891b-4f00-83f9-53c48da3865d1070691.jpg	本书由教学和实践经验丰富的郑州大学吴金星教授编著，内容包括：快速适应大学生活、做好大学四年学习计划、大学里要学习哪些知识、要培养的业务能力和生活能力、必做的十件事、大学的经验与教训等七个方面，对大学生进行生活能力指导、学习方法指导、能力培养和素质教育等。编写时一般先指出问题，再进行分析论述，并给出解决方法。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	830
167	学生教育实习手册	978-7-305-23693-8	\N	陆珊珊,宋琛琛 	0	1-1	16开	28.00	100.0千字	南京大学出版社	132	\N	60	2020-11-18	/book/13923491-48ca-406b-b00e-b608bd2581969787305236938.jpg	本书为高等院校学前教育专业专科教材，适用于高等职业教育大二年级使用。本书通过对实习内容的规范和指导，使学生的实习更加具有针对性和可操作性。在上一版的基础上，本次根据最新的人才培养方案和课时计划，做了相应内容的调整，使新版更具有实用性，更符合人才培养的要求，也更贴近幼儿园教师的工作内容。本书以任务为导向，更加明确地突出了实习的目标和要求。本书采用活页式的装帧方式，学生可以根据所需选取相应内容，更贴近实习的实际情况，也更方便学生使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	538
151	金融企业会计（21世纪高职高专规划教材·金融保险系列）	978-7-300-29075-1	\N	丁贵英 	0	1-1	0	39.00	200.0千字	中国人民大学出版社	\N	290751	11	2021-05-31	/book/48639eff-643a-4a06-a2c6-1c7240d31fe81070387.png	《金融企业会计/21世纪高职高专规划教材·金融保险系列》将内容分为金融企业会计认知、商业银行会计核算、证券公司会计核算、保险公司会计核算、金融企业共性业务核算五个模块，全面阐述了金融企业会计核算的特点、方法及各种专业业务的会计核算和常见的共性业务核算。重点是银行会计核算、证券公司会计核算和保险公司会计核算。 　　《金融企业会计/21世纪高职高专规划教材·金融保险系列》在编写过程中力求突出培养素质高、能力强、上岗快的技能型人才的目的，在每个任务中都设计了“案例分析”“课堂讨论”“知识拓展”等模块。另外，对于一些知识性内容以二维码形式呈现，力求做到全面、实用、精炼。 　　《金融企业会计/21世纪高职高专规划教材·金融保险系列》立足会计，反映金融经济活动，积极探讨金融企业会计现代化和会计改革问题，注重实务操作，不仅可以作为高等职业教育金融类专业的教材，还可以作为相关从业人员学习培训的参考资料。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	686
152	银行授信业务（21世纪高职高专规划教材·金融保险系列）	978-7-300-29299-1	\N	石月华 	0	1-1	0	39.00	200.0千字	中国人民大学出版社	\N	292991	10	2021-05-17	/book/fb317c02-8abf-4fff-8c21-9731745084351070389.png	本书主要根据银行授信工作过程分九个项目编写，内容主要包括银行授信的基础知识，银行授信的客户拓展、申请受理、授信前调查、授信审查与审批、授信合同签订与履行、授信后管理以及授信的基础管理等内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	589
153	金融大监管：大变局下的监管逻辑与市场博弈	978-7-300-29045-4	\N	武良山 周代数 王文韬 	0	1-1	0	68.00	150.0千字	中国人民大学出版社	\N	290454	6	2021-05-12	/book/06b413a5-f1ce-47df-be75-f5ffc63d0ec01070398.png	近年来，资本市场改革加快，监管新规频发，“金融监管”成为金融界、学术界、监管层共同关心的问题。本书邀请了多位切身参与监管实践和工作于各金融行业一线的资深金融人士，结合切身体会阐述我国金融监管的发展情况，梳理当下的金融监管方面的热点问题。 书中分别阐述了银行、证券、保险、信托、私募基金等行业的金融监管新政、影响和趋势，并结合瑞幸咖啡事件分析了跨境金融监管问题，给读者勾画了一幅中国金融监管的全景路线图。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	274
154	《政府会计实务（第五版）》单元实训手册(21世纪高职高专会计类专业课程改革规划教材)	978-7-300-29227-4	\N	李启明 李君梅 	0	1-1	16开	25.00	175.0千字	中国人民大学出版社	\N	292274	17	2021-05-25	/book/fe5bdc19-1a6c-40a3-9fbc-46ee7f5f276b1070403.png	本教材是《政府单位会计实务（第五版）》的配套教材，按照配套教材结构分单元训练，每单元训练内容包括巩固基本知识训练和熟练掌握业务技能训练。基本知识训练部分主要以单项选择题、多项选择题、填空题等形式进行，主要巩固学生该单元应当熟悉了解的基本概念、管理原则与要求、科目核算范围等。业务技能训练部分以事业单位经常发生的经济业务或事项的会计处理方法为主进行，主要使学生进一步熟练掌握事业单位会计业务的处理方法。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	164
155	驾驭独角兽——新经济企业的公司治理	978-7-300-29237-3	\N	郑志刚 	0	1-1	0	69.00	150.0千字	中国人民大学出版社	\N	292373	14	2021-05-13	/book/0c26b8a8-a4ff-4adf-95eb-ccb5d190ddd71070406.png	随着科创板的开板，作为新经济的代表——独角兽企业被越来越多人关注，而其有别于传统同股同权架构的公司治理模式，为其后的股权之争埋下了伏笔。 本书选取了当前具有代表性的独角兽企业的股权结构设计，包括当当、万科、优刻得、桂碧园、法拉第、阿里巴巴、永辉、中民投等，详细介绍了独角兽企业公司治理的显著特征，从而为各方利益相关者如何设计合理的独角兽企业的治理模式提供了有益的参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	613
156	人际沟通与礼仪(21世纪高职高专规划教材·通识课系列)	978-7-300-29305-9	\N	王光华 	0	1-1	0	39.00	200.0千字	中国人民大学出版社	\N	293059	11	2021-04-28	/book/5c24345c-8b12-4694-8f65-71511ae58a3d1070409.png	本教材设计了既有一定逻辑关联又相互交叉的教学和培训项目十八个，每个项目下是教学与培训各项任务和实训导引，充分利用移动互联网平台，丰富典范的视频案例，均在职教云平台共享，包括沟通与礼仪三个基本规则项目、三个基本方向项目、四个基本程序项目、四个基本要素项目、形象礼仪项目、有声语与礼仪项目、体态语与礼仪项目、个性风格以礼仪项目、沟通控场与礼仪项目、表达方式技巧与礼仪项目、会务场景沟通与礼仪项目、社交沟通与礼仪项目、公关沟通与礼仪项目、求职沟通与礼仪项目、主持和主播沟通与礼仪项目、商务办公沟通与礼仪、团队沟通与礼仪项目、演讲沟通与礼仪项目等。根据不同专业和职业岗位需求，可以全项目教学，也可以选择不同的项目重点教学，最大程度的将课程与专业和职业贴近。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	493
223	成都市人民防空地下室设计标准	155643·114	\N	成都市人防建筑设计研究院 	0	1-1	16开	55.00	\N	西南交通大学出版社	308	\N	\N	2021-04-01	/book/222c5f6f-d07a-498b-b3d9-ac9cec10fccd1071391.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	578
159	戴着假面具上学	978-7-305-23459-0	\N	车培晶 	0	1-1	32开	28.00	180.0千字	南京大学出版社	180	\N	60	2021-01-01	/book/ebb26fbc-cf6f-471f-9f19-85f903968bec1070490.png	本书讲述的是一天清晨，几乎每天都迟到的“我”意外地被姥姥早早叫醒，赶到了学校，在教室里遇上小女妖乔细。本指望小女妖可以将我平凡的日子变得精彩纷呈。可没想到她将我的生活搅得天翻地覆一团糟之后却又突然消失……车培晶的创作是以想象为依托来建构一种关于儿童梦想的诗学，他的作品中关于幻想的叙事有与西方幻想叙事重合的地方，也有他自己的独特探索与尝试，显示出别具一格的审美意义。在文学的世界里，小读者得到了充分的滋养和满足，同时也从主人公身上看到担当、勇气、智慧、宽容的人性品质和为人处世的道理。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	994
160	大学语文：简编本	978-7-305-23560-3	\N	王步高,乔光辉 	0	5-1	16开	49.00	550.0千字	南京大学出版社	388	\N	30	2021-01-01	/book/a0c48e14-e29f-43fa-ac14-ff59e73d7c2b1070495.png	本教材分为三十个单元，涵盖了从《诗经》、先秦散文直到现当代的主要作家、主要文学流派，一些中小作家的吉光片羽也以附录形式收入，包括了诗、词、曲、赋、散文、小说、戏剧各大文体。古代部分每单元还突出某一二题材(如山水、田园、爱情、爱国等)，让学生点、线、面相结合，多侧面、多角度地去认识中国文学的概貌。每单元除同类教材常有的作家小传、注释、赏析外，还附有单元和文体的综论、作家的集评、代表作的汇评，汇集千百年来文学家言简意赅的评语，方便学生深入领悟，使课本不仅可读，而且耐读，可以常读常新。每单元还附有备选课文及该作家(流派)的其他代表作，作为泛读的作品。也附有该作家(流派)的作品综述，从而可克服管中窥豹的片面性。有的单元还附有有关的研究综述，就若干学术争鸣问题作概略介绍，使学生对文学研究略知一二，对做学问有一些初步的感受，有利于日后在自身学科领域中逐渐深入，有所创新。每单元后均附有参考书目，方便学生深入自学。全书附有总参考书目，这样做更符合信息时代对传统学科改革的要求。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	450
161	文学研究——中国文学研究的新视野	978-7-305-24085-0	\N	徐兴无,王彬彬 	0	1-1	16开	48.00	353.0千字	南京大学出版社	232	\N	40	2020-10-22	/book/c4a4d859-8c21-403f-ab34-0a6e4bd8db601070502.png	中国文学研究有着十分丰厚的学术积累，形成了自己的学术传统，但这也意味着取得大的突破越来越困难。如何走出文学研究的瓶颈状态，在现有的基础上进行创新，推动中国文学研究持续深入的进行，这是一个亟待解决的问题。本书所收文章无论是研究古代作家还是研究现当代作品，都是着眼于这一问题展开。本书所收文章涉及诗文、小说等文体，视野开阔，论证扎实，观点新颖，代表着中国文学研究的新收获，为更为深入的研究提供了有益的借鉴和启发。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	716
162	工程数学	978-7-305-23998-4	\N	陈静,陈旻霞,姚星桃 	0	1-1	16开	39.80	377.0千字	南京大学出版社	248	\N	40	2021-01-15	/book/ed84c759-1918-4254-8546-865dd5d0bcb19787305239984.jpg	本书的内容共分十章：行列式、矩阵、线性方程组、无穷级数、傅里叶变换、拉普拉斯变换、随机事件与概率、一维随机变量及其数字特征、数理统计基础、图论简介等，每章都配有一定数量的习题，书末还附有参考答案。“以应用为目的，以必需够用为度”就是本书的基本原则。本书适合作为高职院校的教学用书，可供不同专业在教学时选用相应的内容。本书还可作为成人高校、夜大和函授大学等层次的教学用书，也可作为广大自学者的自学用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	969
163	湖泊的故事	978-7-305-23790-4	\N	薛滨，李玲玲 	0	1-1	大32开	58.00	132.0千字	南京大学出版社	220	\N	60	2020-11-30	/book/aa7602e9-a1e4-4123-b74c-f75f4353f8ef9787305237904.jpg	本书系《湖泊科普系列丛书》中的一册，为科普性读物，选取了诸多有知识性、趣味性和科学性的问题，对湖泊的形成发展、地理分布、自然生态以及与人类的关系等方面进行了多点叙述与展示，不仅可增进读者对于湖泊的认识，也可增强他们的环保意识，促使其进一步思考人类与自然和谐相处的意义。本书对湖泊的形成、在全球的分布、及物理、化学和生物特点进行了一个全面的介绍。另外对一些世界上的奇异湖泊进行了专门的介绍。最后提及当前湖泊面临的面积锐减、污染严重及生态系统退化等问题，介绍了当今在湖泊治理方面的一些措施，并呼吁大众参与环保，绿色健康生活。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	921
164	动画编导基础教程	978-7-305-24225-0	\N	袁晓黎 	0	3-1	大16开	52.00	170.0千字	南京大学出版社	136	\N	44	2020-12-17	/book/8203463f-de13-47f4-a757-4c76453245c69787305242250.jpg	本书以动画行业的生产标准为编写依据，密切考虑所面向的不同基础和条件的本专业学员的特点和思维习惯，选择了大量精心绘制的图片巧妙地融合到教学内容中，尽可能结合动画视觉艺术的专业特点，力图能够更大限度地适合教学。本教材的另一特点是可以配合教材内容进行网上学习。每章后有具体的讨论思考与作业练习，并配备准确的图片可供参考和描摹。本书在编写时始终密切关注专业基础知识的系统性，注重研究使用者的共性与差异化，重视线上教学的特点并积极结合相关特点进行编写研究，结合动画专业学员的专业特点和思维习惯，在理论上深入浅出，对原理重新分析并进行扁平化处理，通过简洁易懂的语言加以表述。教材运用现代信息技术、图形处理技术及数字存贮技术，筛选文字信息、图片信息，选择了大量精心绘制的图片巧妙地融合到教学内容中。尽可能地结合动画视觉艺术的专业特点，合理的图文混排使教学内容生动有效地展示给学生，也使学生在得到一套教材的同时拥有了一套专业性强的资料集。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	582
165	商务英语口语实训教程(初级)（修订版）	978-7-305-23491-0	\N	于群 	0	1-1	16开	39.00	170.0千字	南京大学出版社	124	\N	60	2021-02-19	/book/5584f036-4706-4897-89d5-f9b811d015fc1070521.png	本书是《商务英语口语实训教程(初级)》的修订版教材，对原书的材料和练习进行了更换，主要涉及商务英语口语的初步交际技能，与学生校园交际技能紧密联系，旨在帮助学生逐步融入高级商务情境的学习。本书突出任务型、项目型教学思路，以角色扮演为主要训练手段，并提供简单明了、便于操作的训练步骤，有利于教师安排课堂内外训练活动。本教材主要供开设商务英语口语课程的公办院校、独立学院和高职高专院校使用，使用对象为本科一年级、二年级学生或水平相当的学习者。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	699
166	小学课程设计与评价	978-7-305-24054-6	\N	晋银峰 	0	1-1	16开	38.00	300.0千字	南京大学出版社	208	\N	50	2021-01-15	/book/259d5336-673e-4cff-9f6d-b283be3e62a19787305240546.jpg	本书主要包括小学课程设计的模式、价值取向、目标设计、内容设计、实施方法及策略设计、小学课程评价、校本课程的设计与评价、案例研究等内容。全书理论与实践相结合，突出重点，讲清理论，并结合案例研究展开，使内容更具操作性，有助于学习者掌握小学课程设计与评价知识与技能；全书设置内容摘要、关键词、学习目标、学习策略、延伸阅读等模块，体例新颖，有利于促进学习者自主学习。同时，本书设置二维码，提供丰富的数字学习资源。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	251
168	《荀子》形容词研究	978-7-5631-2939-3	9787563129393	何霞、刘敏 	0	\N	0	30.00	138.0千字	新疆大学出版社	176	\N	80	2020-09-01	/book/45cd5e7f-e535-4c8e-a28a-79f3985bec529787563129393.jpg	本书主要以《荀子》形容词为研究对象，对其进行穷尽性考察，统计数量，描写形容词的特征，分析复音形容词的结构类型和语义特征，探讨各类形容词在句中的语法功能，总结《荀子》形容词所呈现出的特点和规律。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	557
170	国家通用语言文字普及科技丛书（汉维对照）天天学知识	978-7-5631-3013-9	9787563130139	米尔夏提工作室编译 	0	\N	0	26.00	121.0千字	新疆大学出版社	214	\N	80	2020-12-01	/book/d4e667a1-3b4a-4f98-a96d-a5e9b1dd5ca49787563130139.jpg	该丛书从我国公开发行的科普著作中挑选出关于天文、地理、生命、动物、植物、生物、医学等方面的科普文章，为新疆各族群众普及科普知识。本书采用汉文、维吾尔文对照的形式，主要介绍鸟类的知识，包括：大雁的飞行、鸟类没有牙齿、鸟类方言、最聪明的鸟等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	230
171	国家通用语言文字普及科技丛书（汉维对照）天天学知识	978-7-5631-2912-6	9787563129126	米尔夏提工作室编译 	0	1-1	0	28.00	129.0千字	新疆大学出版社	230	\N	80	2020-12-01	/book/b7324b57-9b91-45e2-ab03-42a7404045e59787563129126.jpg	该丛书从我国公开发行的科普著作中挑选出关于天文、地理、生命、动物、植物、生物、医学等方面的科普文章，为新疆各族群众普及科普知识。本书采用汉文、维吾尔文对照的形式，主要介绍大脑的相关知识，包括：爱因斯坦的大脑、狼孩的智力水平、认出熟人、人的大脑等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	497
172	国家通用语言文字普及科技丛书（汉维对照）天天学知识	978-7-5631-3092-4	9787563130924	米尔夏提工作室编译 	0	1-1	0	27.00	125.0千字	新疆大学出版社	224	\N	80	2020-12-01	/book/5e6f6b31-7917-4dd9-a14f-92bda622caae9787563130924.jpg	该丛书从我国公开发行的科普著作中挑选出关于天文、地理、生命、动物、植物、生物、医学等方面的科普文章，为新疆各族群众普及科普知识。本书采用汉文、维吾尔文对照的形式，主要介绍能源方面的知识，包括：化石能源、我国第一大能源、太阳能汽车、阳光和风能等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	917
173	国家通用语言文字普及科技丛书（汉维对照）天天学知识	978-7-5631-3046-7	9787563130467	米尔夏提工作室编译 	0	1-1	0	30.00	123.0千字	新疆大学出版社	244	\N	80	2020-12-01	/book/b4d7a45e-cc8e-4341-b60e-c342f4952ca09787563130467.jpg	该丛书从我国公开发行的科普著作中挑选出关于天文、地理、生命、动物、植物、生物、医学等方面的科普文章，为新疆各族群众普及科普知识。本书采用汉文、维吾尔文对照的形式，主要介绍疾病与预防知识，包括：癌症与化疗、甲状腺的功能、儿童白血病、肥胖与心脏病等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	228
174	解析本尼迪克特·安德森《想象的共同体》	9787544666749	\N	杰森·克西迪亚斯著 张曼译 	平装	1-1	大32开	30.00	\N	上海外语教育出版社	\N	\N	\N	2021-05-01	/book/a6882bc3-436b-42c7-b4e5-b12b99508d001070673.jpg	我社引进的The Macat Library 系列丛书邀请相关研究专家撰写深入浅出的简明读本，让读者在短时间内把握原著的精华、作者生平、对后世的影响力等关键信息，快速拓展知识面。世界思想宝库钥匙丛书是从The Macat Library 系列丛书中挑选并编译的汉英双语读物，由我社组织译者翻译。整套丛书分11个学科，共计100册图书。 本书是对政治学著作《想象的共同体》的解析，作者深入解读原著，从原著作者介绍、原著的历史贡献、学术价值、局限性以及各方评价等方面，全面地对原著进行剖析，有助于读者用批判性思维来研读原著，本书也可作为学生研读原著的导读书籍。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	665
175	传染病防控与护理手册（配习题与技能操作视频）	978-7-5645-7689-9	\N	刘延锦 	0	1-1	16开	29.00	166.0千字	郑州大学出版社	103	\N	20	2021-05-01	/book/ed83c0fb-dd10-466e-adf2-9880dd9de0b31070676.jpg	本书重点围绕传染病防控这一主线，立足当前大家关注的新冠肺炎这一焦点，采用“一问一答”的形式，力求将琐碎而复杂的知识点尽量清晰、明确的呈现出来，供广大公众和医护人员参考使用。全书共分三个部分。第一部分为传染病的防控与护理知识，根据受众的需求特点分为公众篇和护理篇。第二部分为传染性疾病防控与护理习题集。第三部分为常用感染防控技术操作视频，由郑州大学第一附属医院护理部、医院感染预防与控制科联合宣传处等部门共同录制。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	191
176	食品安全法原理	978-7-5645-7365-2	\N	侯宇 	0	1-1	小16开	45.00	243.0千字	郑州大学出版社	179	\N	10	2021-05-01	/book/8f399cf1-0c31-4f4d-b710-59b310d4858e1070677.jpg	本课程从理论和制度两个层面对食品安全监管进行了详细介绍，涉及到食品准入制度、食品安全风险控制制度、食品安全标准制度、食品生产与流通制度、食品检验制度、食品安全处置制度以及食品安全救济制度等。此课程法学、公共卫生及药学专业本科生学习，也适合食品安全管理、食品从业、食品安全监管等人员。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	463
177	解密儿童癫痫	978-7-5645-7479-6	\N	高丽 	0	1-1	16开	59.00	293.0千字	郑州大学出版社	260	\N	10	2021-05-01	/book/f8342c86-1ccf-4bfd-af12-469afca54a731070686.jpg	本书是针对癫痫儿童的家庭科普书，全书共有十二个章节，内容涵盖儿童大脑发育、认识癫痫之千奇百怪的癫痫、眼花缭乱的癫痫病因、神秘的癫痫发病机制、儿童癫痫检查知多少、儿童癫痫共患病、儿童非癫痫性发作、儿童癫痫治疗、治疗误区、儿童癫痫的护理、儿童癫痫预后、儿童癫痫社会现象面面观；全书共122问，分属于十二个章节，从患儿家长视角提出问题，进行解答式科普，并通过形象的插图、通俗易懂的科普文字、条理的分析，使问题浅显易懂，便于癫痫患儿家长理解学习。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	271
179	刘仙洲传	9787302578048	\N	王向田 	平装	1-2	16开	68.00	\N	清华大学出版社	\N	\N	\N	2021-04-01	/book/fe8326ff-0c37-4fa3-a763-a1e4e24e79f91070698.png	本书是著名工程教育家、机械工程学家刘仙洲先生的第一本传记。以生动的记述、翔实的资料、珍贵的图片，展现了刘仙洲先生热爱祖国、热爱人民、追求真理，最终成为优秀的共产主义战士的光辉一生；讲述了他数十年如一日从事工程教育和机械工程史研究的勤奋笃实，以及他对为我国教育事业、科学事业做出的非凡贡献。 刘仙洲先生一生胸怀坦荡，严于律己，严谨治学，堪称学界楷模。本书的读者对象包括教育工作者、机械行业、机械史、教育史工作者、大中学生等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	628
761	探索吧！科学！（第二辑）	9787519126063	\N	冰 波?孙幼忱等/文?周建明?李?丹等/图 	0	1-1	12开	249.00	\N	教育科学出版社	\N	\N	\N	2021-09-15	/book/a31dc1e1-dd17-430a-b507-5e84363636ec1078605.png	《探索吧！科学！》丛书一共10册，分两辑，精选10个科学启蒙经典童话，通过生动的语言、精美的图画、有趣的只是、好玩的游戏、奇妙的视频等，全方位地介绍发生在儿童身边的科学现象，帮助儿童更好地认识世界，萌发科学探索意识，提高科学素养。 《探索吧！科学！——幼儿科学启蒙经典绘本》丛书共10册，分2辑，精选了10个科学启蒙经典童话，通过生动的语言、精美的图画、有趣的知识、好玩的游戏、奇妙的视频等，全方位地介绍发生在孩子身边的科学现象，帮助孩子更好地认识大自然，萌发科学探索意识，提高科学素养。 第2辑包括《小“伞兵”和小“刺猬”》《太阳哥哥和月亮妹妹》《毛毛虫的鞋子》《冬天的小鱼》《特别的“气象员”》，具体内容如下： 《小“伞兵”和小“刺猬”》这本书涉及到科学知识是种子的传播方式。蒲公英的头上长着一撮白绒毛，成熟后一下子散开了，这些种子像小“伞兵”一样飞向天空，又随风飘到了各地。苍耳的种子长得小小的，全身长满了尖尖的刺，像一个个小刺猬，他们挂在小鹿的毛上，跟着小鹿到处旅行。后，这些蒲公英和苍耳的种子都生根发芽长大了。 《太阳哥哥和月亮妹妹》这本书涉及到的科学知识是日月运动规律。白天，太阳挂在空中，把大地妈妈照得暖洋洋的，给大家带来了光和热，也带来了欢笑。到了晚上，月亮妹妹去接太阳哥哥的班。月亮来到了天空，把银色的光芒洒向大地，照亮了小鸟回家的路……嗬，太阳又跳出了海面，新的又开始了。 《毛毛虫的鞋子》这本书涉及到的科学知识是毛毛虫由蛹到茧—破茧成蝶的过程。蜘蛛老鞋匠很会做鞋。小动物们常常来请蜘蛛做鞋。蜘蛛给蟋蟀做了六只玉米皮布鞋，给小蜥蜴做了四只豆壳皮鞋。有一只毛毛虫，她也想穿咯噔咯噔的豆壳皮鞋。于是，她也来找蜘蛛。蜘蛛做完了蜈蚣的四十二只鞋子，就做毛毛虫的。毛毛虫等啊等啊，风儿吹在她身上，她感到冷了。毛毛虫就爬到树枝上，做了一个茧。茧吊在细细的树枝上，在风里晃呀晃呀。蜘蛛日夜加工，做好了鞋子却找不到毛毛虫了。蜘蛛只好把鞋子挂在树枝上。过了些日子，一只美丽的蝴蝶从茧里飞出来了。她看到挂在树上的鞋子，非常高兴，她说要把宝宝生在里面…… 《冬天的小鱼》这本书涉及到的科学知识是动物过冬、四季变换。本书主要讲了一条夏天出生的小鱼如何度过冬天的故事，书中小鱼经历了夏、秋、冬三个季节，小鱼的妈妈向小鱼描述了春天的样子，所以整本图画书体现了江水四季的变化。全书的重点是通过小鱼和妈妈的对话，表现冬天小鱼怎么过冬，小鱼担心江水结冰，鱼会闷死。小鱼妈妈回答了小鱼的困惑，同时也是回答读者的困惑。 《特别的“气象员”》这本书涉及动物“预报”天气的科学知识。为了更好地生存，自然界中的许多动物对天气变化比人类更敏感，能更早地察觉天气的变化，就像一个个“气象员”。故事中的小山羊打算出门旅行，它先后遇到了乌龟、蜻蜓、蜘蛛，它们都告诉小山羊“要下雨了”，并说明了自己是怎么知道这一点的，小山羊从怀疑到相信，终在风雨到来前跑回了家。 这些故事虽然短小，但却巧妙地将相关科学知识融入情节发展，让幼儿在有趣的故事中感受自然界的神奇，而且这些故事童趣十足,定能调动起孩子对科学探索的兴趣！ 每本书的后有两个栏目，分别是“科学知识我知道”和“科学游戏玩起来”。“科学知识我知道”，解读书中的科学知识，开阔孩子的视野；“科学游戏玩起来”，使书中的科学知识活起来，让孩子在好玩的游戏中加深对知识的理解和运用。这样的延伸活动设计让幼儿在互动中加强对科学经验的总结和回忆。 每本书都配套提供免费的科学知识讲解视频，只要扫描封底二维码就能看到。这些视频由科普教育工作者和幼儿教师共同进行内容设计，由相关领域的科学家审定，播音员配音，并选用高清的图像素材，兼顾科学性和趣味性、教育性和观赏性，让孩子在轻松愉快的观看过程中收获科学知识、提高科学素养。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	806
180	公共空间室内设计	9787566918765	\N	刘静宇 主编 	平装	1-1	16开	68.00	\N	东华大学出版社	\N	\N	\N	2021-04-01	/book/7011b5b6-00f4-42c7-90fa-035d7fea5a0c1070699.png	公共空间设计正处于一个向多元化、多层次方向发展的阶段，人们已不再满足于那些缺乏文化内涵、没有自身特色的公共空间。在国际化的今天，各种新的空间设计形式、新的技术和材料、新的时尚风格和人居环境概念正不断地冲击着这个领域，人们对公共空间的精神层面和文化内涵的追求也已经在潜移默化中展开。本书介绍了公共空间室内设计问题，包括办公空间、餐饮空间、酒店空间、休闲娱乐空间和商业空间设计。本书文字简练，图例丰富，还配有习题，融知识性与实用性于一体，可作为艺术设计相关专业的教材，也可供相关艺术设计从业人员学习。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	939
181	国际商务英语（初级）（高职）	9787560660240	\N	乔丽苹 	0	1-1	16开	38.00	271.0千字	西安电子科技大学出版社	184	5606	15	2021-05-24	/book/9450a533-895a-4d61-be8d-643a6b8751b19787560660240.jpg	在商务和一般生活环境下使用英语进行沟通的能力是高职院校商务英语专业学生必备的专业核心能力。本书以一名商务英语专业学生毕业后参与的一系列商务活动为线索，从商务听、说、读、写四个维度进行知识的讲解和技能的训练。同时本书还结合由英国剑桥大学考试委员会颁发的权威证书——剑桥商务英语初级证书（BECP）考试的要点进行讲解与模拟分析，助力学生获取这一求职的“通行证”。 作为一本新形态教材，本书内容与该课程配套的线上学习内容相对应，适合高职院校商务英语专业师生开展线上、线下相融合的混合式教学实践，提高课程教学效果。 本书结构清晰，重点突出，实践性强，其内容按照课前—课中—课后三个环节辅助该课程的教学。书中穿插的教学微课视频为课前教学做知识与技能准备，所提供的习题能够及时有效地巩固相关知识与技能要点，可作为课后复习任务布置给学生。本书附录提供了BECP考试的备考词汇，方便学生备考。同时，本书也可为报考该考试的社会学习者提供丰富的自学内容和考试要点讲解。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	763
182	外贸跟单（高职）	9787560660523	\N	王一名 	0	1-1	16开	30.00	222.0千字	西安电子科技大学出版社	152	5606	16	2021-05-28	/book/73c6bcee-72d5-402e-a500-cfc57063e1cc9787560660523.jpg	本书是围绕外贸企业中跟单员岗位的相关工作编写的，涉及订单从无到有，从签订合同到履行合同的完整流程，覆盖了跟单员的所有实际工作任务，同时体现跟单员与客户、工厂及公司内各个部门之间的联系。本书对最新的外贸跟单的知识和技能模块进行了梳理，包含打样跟单、订单审核、大货跟单、结算跟单及出运跟单五大实训项目，共计15个工作任务，力图通过具体项目任务执行的过程构建外贸跟单的知识体系，并培养职业素养。本书案例丰富、实用性强，编者创新性地制作了一系列商贸短片(扫描书中二维码获取)，生动地展现了外贸工作中的重要环节和大量细节，对于学生理解跟单员岗位工作有极大的帮助作用。 本书主要针对高职高专院校国际贸易相关专业的学生，旨在通过立体化、数字化的新形态方式，指导有关跟单课程的项目化教学的开展。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	960
183	智能制造导论	978-7-04-055595-0	\N	周济 李培根 	平装	1-1	16开	53.00	610.0千字	高等教育出版社	\N	\N	\N	2021-06-01	/book/dfa6191b-5026-4a43-be86-68b11572879e1070718.png	智能制造导论数字课程与纸质教材一体化设计，紧密配合。数字课程资源涵盖多媒体课件、图片等，极大地丰富了知识的呈现形式，拓展了教材内容。在提升课程教学效果的同时，为学生学习提供思维与探索的空间。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	755
184	旅游文创产品设计	978-7-5661-3084-6	\N	赵勤 	平装	1-1	16开	45.00	240.0千字	哈尔滨工程大学出版社	\N	\N	\N	2021-06-01	/book/d0561859-e22e-4d98-80b2-7fd9af0874ac1070725.png	本书主要从旅游文创产品概述、旅游文创产品的分类、旅游所在地地域文化元素分类、地域文化元素在文创产品中的运用及设计原则、旅游文创产品的设计要点、旅游文创产品的研究价值、旅游文创产品赏析几个方面进行叙述，使学生及艺术设计爱好者能更清晰、直接、快速地了解和掌握旅游文创产品的创意和表现方法。 　　本书主要供高等院校设计类相关专业学生使用，也可作为通识课公共基础课、艺术素养课教材或设计爱好者、自学者及艺术相关行业从业者的参考书使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	974
185	交通引领城市可持续发展：中国交通发展与变革40年	9787313225016	\N	彭仲仁 路庆昌 朱祎 等 编著 	平装	1-1	16开	89.00	\N	上海交通大学出版社	\N	\N	\N	2020-06-01	/book/ccb3a5cb-fd8f-422c-9d56-d8693b9a09901070727.jpg	中国交通在改革开放40年中，无论是在交通基础设施规模、运输能力和服务质量、技术装备等方面，还是在发展理念转变、体制和政策创新、市场化发展等方面，都取得了很大的成就。本书通过大量的文献查阅、数据分析，对1978—2018年中国交通所发生的变化及其原因，尤其是对重要的交通政策及其实施效果进行了分析、归纳和总结。本书适合城市治理领域的实践者和研究者参考阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	214
186	大国工匠——南笼泰斗颜虎金	978-7-5672-3409-3	\N	袁牧 	平装	1-1	16开	88.00	251.0千字	苏州大学出版社	\N	\N	\N	2021-03-22	/book/21f749b1-3abe-4c34-bfd8-d4b5509734511070730.png	《大国工匠——南笼泰斗颜虎金》是一本由人及物的工艺美术研究专著。目前工艺美术研究还只停留在对造物技艺、艺术样式和工艺源流进行梳理，而未及造物主体——人的研究。工艺美术是人的造物，人才是决定其发展方向的决定性因素。本书以工艺人为研究对象，从其生存环境、人生境遇、学艺轨迹、从艺道路等方面切入，来研究工艺美术运动变化的规律。全书分三大块：1.工艺人生；2.技艺传承；3.手艺家谱。全书共大约十五万字，八九十幅插图。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	959
187	老子注读	978-7-307-21741-6	\N	罗耀松 著 	平装	1-1	16开	59.00	\N	武汉大学出版社	\N	\N	\N	2021-05-01	/book/13384eee-9b2d-4634-9433-bc6b40cb8ab01070736.jpg	《老子》（《道德经》）是春秋时期老子（李耳）所著，是道家文化重要经典，为中华民族优秀传统文化瑰宝。《老子注读》一书是作者多年在从事《老子》（《道德经》）教学与科研过程中，以马王堆帛书本《老子》为底本，在充分吸收前人研究成果基础上，对《老子》进行注释、今译、解读所形成的成果。本书主要特色在于原文每章前有文章主旨，每章后对本章进行层次分析、解读。最后一部分是古代文化经典引证、古今事例。本书通俗、规范，力求达到思想性、学术性、通俗性相统一，适合高校及社会各界广大读者阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	795
762	怎样处理农村土地纠纷	9787561093139	9787561093139	吉朝然, 李成, 鲁伊 	\N	1-1	16开	22.00	\N	辽宁大学出版社	\N	\N	\N	2018-12-01	/book/1e222dfe-45ad-4e34-b893-78d537f16d359787561093139.jpg	以设问的形式，提出农村土地纠纷中经常涉及的法律问题，结合实际案例，结合现行法律法规，以浅显通俗的语言，对案例的审判结果、适用法律法规的适当与否进行分析解读，以此引导广大农民朋友在土地承包、租赁等经营活动中防范风险、依法行使权利。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	697
188	爱的永恒：彼特拉克《胜利之歌》与加西拉索诗歌创作的平行研究	9787561579978	\N	李文进 	0	1-1	16开	49.00	290.0千字	厦门大学出版社	208	\N	\N	2021-04-01	/book/c701b4f2-b8ea-4c6a-8a2c-fb57d6d303b21070885.png	弗兰齐斯科·彼特拉克，意大利学者、诗人，文艺复兴第一个人文主义者，被誉为"文艺复兴之父"。彼特拉克的爱情诗收集在他的代表作--《歌集》中，《歌集》中的诗都是即兴而作的诗体日记，共366首。本书以彼特拉克《歌集》中的爱情表现为基础，分析彼特拉克如何建构具有个人特色并影响欧洲文坛深远的精神式恋爱。另外，再以被誉为西班牙诗歌王子的加西拉索的作品为分析文本，剖析彼特拉克文学风格如何成功地传人西班牙，在当地扎根，成为永恒的爱情诗歌表现。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	640
189	文化自信与新时代中国现代化发展理念研究	9787561581773	\N	邱昌东 	0	1-1	16开	58.00	270.0千字	厦门大学出版社	200	\N	\N	2021-04-01	/book/fb8a2349-c7d8-414c-8a2d-d6eb3cb29fcc1070894.png	本书以中国传统文化在世界文明史上的地位为出发点，阐述了从鸦片战争到新文化运动期间，马克思主义中国化对救亡图存的新民主主义革命文化的影响；现代文化理论及文化自信；社会主义探索和建设时期党对思想文化的整合，形成中国特色社会主义文化；改革开放时期中国文化建设的现实逻辑；党的十八大以来我国文化自信的理论与实践；中国文化自信对“西方文化中心论”的超越。构成一幅关于中国文化自信与社会主义现代化发展的历史图谱。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	963
190	县级融媒体：国际化视野与本土化建设	9787561581810	\N	张宏邦 	0	1-1	16开	68.00	255.0千字	厦门大学出版社	252	\N	\N	2021-04-01	/book/6fd4e5b3-5b99-4729-b5f0-919f9de211ee1070901.png	县级融媒体中心建设是提升县级媒体传播力、引导力、影响力和公信力的重要机遇，是打通舆论宣传最后一公里的关键一步，对于维护我国主流意识形态安全具有重要意义。然而通过前期调研发现，在投入了大量的人力、物力、财力之后，县级融媒体的传播力、引导力、影响力和公信力并没有得到明显的改善。本书旨在通过问卷调查、深度访谈等研究方法，深入县级融媒体中心进行实地考察，分析县级融媒体的建设现状及存在的问题，结合国际上有关媒体融合实践的案例和理论研究，在国际化视野的背景下探索我国县级融媒体本土化建设之路。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	730
191	厦门大学百年校史（精装）：（1921—2021年）	9787561581056	\N	陈支平 	0	1-1	16开	188.00	541.0千字	厦门大学出版社	564	\N	\N	2021-03-01	/book/56225031-97b9-41c6-8294-6d3093c8d8491070906.png	《厦门大学百年校史（1921—2021年）》一书以史书记载之形式，记录、叙述和评价厦门大学在1921—2021年间教育发展的过程，反映了学校在各个历史时期所历经的风雨和取得的办学成就。共分九章，“陈嘉庚与厦门大学”“粗具规模 曲折发展”“国难当头 共克时艰”“复员厦门 迎接解放”“新中国与新教育”“‘十年浩劫’到‘拨乱反正’”“改革开放 恢复发展”“科教兴国 创建一流”“与时俱进 突破发展”等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	241
209	天体运行论（学生版）	978-7-301-31961-1	9787301319611	哥白尼（Nicolaus Copernicus，1473—1543）， 	\N	1-1	16开	38.00	110.0千字	北京大学出版社	240	7301	\N	2021-04-27	/book/7d1bf1a5-fa78-44ce-af51-405b75913ea931961.jpg	自然科学借以宣布其独立于神学的不朽著作，提出并论证了革命性的日心地动说，批判并推翻了占据西方世界观统治地位一千余年的地心说。全书共6卷。第一卷扼要阐述日心地动说，论述宇宙和大地是都是球形的、天体运动是均速和永恒的、天体作圆周或复合圆周运动，提出地球的三重运动说，系统批驳了地心说。第二卷解释地球的周日自转、绕日公转和赤纬运动所引起的各种现象。第三卷解释岁差。第四卷解释月球运动、月球视差和日月食。第五、六两卷论述行星运动。日心地动说简化了天文学模型，动摇了基督教宇宙体系，解放了思想。此书有助于读者深入了解文艺复兴时期科学革命的内容，学习哥白尼严谨的治学态度、清晰的逻辑思维和巧妙的分析方法。 ——《中国教育报》 《天体运行论》是波兰天文学家，日心说的创立者，近代科学革命的先驱哥白尼的经典著作。本书为中学生量身打造，分为上篇、中篇和下篇三部分。上篇为阅读指导，由中国科学院南京紫金山天文台叶式煇研究员，中国科学院上海天文台原台长李珩等撰写，深入浅出地介绍了哥白尼的生平、《天体运行论》的主要内容、哥白尼的科学贡献，并为学生提供切实的阅读建议。中篇精选《天体运行论》原著精华，由中国科学院南京紫金山天文台叶式煇研究员翻译，将这部关于日心说的革命性著作的精华内容突出呈现。下篇为学习资源，包括扩展阅读、数字课程、思考题、阅读笔记。名著名译，名家导读，配备优质融媒体学习资源，有助于中学生更好地阅读经典、理解经典、感受经典魅力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	942
192	中华人民共和国刑事诉讼法及配套规定分解集成	978-7-5620-9992-5	\N	刘玫 编 	平装	1-1	16开	66.00	\N	中国政法大学出版社	\N	\N	\N	2021-05-01	/book/55aaac84-a78d-435e-9f1f-cb858efab9531070914.jpg	作者将最新的《刑事诉讼法》《六机关规定》《刑事诉讼法解释》《人民检察院刑事诉讼规则》《公安机关办理刑事案件程序规定》《法律援助工作规定》等相关规定，采用以《刑事诉讼法》条文内容为主框架，以其他重要的相关法律和规范性文件的条文作为配套内容排列在相关主条文之后，并将其他相关配套规定附在文前的二维码中，最终形成本书。 本书可帮助司法从业人员，法律专业的师生，以及社会公众更好地了解和掌握最新的刑事诉讼法及其相关规范性文件。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	236
193	文化性动物：人类的本性、意义与社会生活	978-7-5760-1141-8	\N	罗伊·F.鲍迈斯特 著 张建新 等译 	平装	1-1	16开	78.00	\N	华东师范大学出版社	\N	\N	\N	2021-05-01	/book/d2136ca8-1253-46e7-9d69-ffd82ebf2fa11070920.jpg	人类心智受到自然和文化两种环境的影响，这是一个被广泛接受的观点。但人们一般都认为，文化是在人类的生产力发展到一定水平的基础之上，才产生和发展出来的。 但本书颠覆了这个一般性的预设。它假定，文化其实先于人类而存在。因为文化在某些动物活动之中，已经向大自然显示出自己所具有的优势，即较之个体的聪明和群体的力量，文化是一种更有利于物种的生殖与繁衍的存在方式。因此，大自然便在各个物种之中进行选择，让 那些已经在生物学意义上为文化准备好的物种，为利用和享用文化而进化和演进。 这个物种便是在漫长的演进过程中充分利用了文化的优势，从而进化为超越其他动物而独步自然环境的人类。也就是说，文化不是人类进化的结果，而是人类进化的目的。是大自然选择了人类这个物种去进入和适应文化，以帮助生物物种更好地达成生存与繁衍之最终目标。当然，在更广泛的意义上，文化反过来也改造了自然。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	880
299	新编英美概况教程(第二版)	978-7-301-15085-6	9787301150856	周叔麟 	\N	2-1	16开	58.00	641.0千字	北京大学出版社	372	\N	\N	2021-08-09	/book/fd372677-c528-4f4e-95ff-6fca59d4d56d1508502.jpg	本书由美国，英国和中国的相关领域的教授编写，英语地道，内容全面丰富。它包括哲学，历史，地理，政治，经济教育，文化和社会等领域。每个单元包括英文课文及注释。此次修订作者更新了部分内容。本书自2004年出版以来已11次印刷，深受读者的欢迎。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	901
194	机械专业综合实验教程	978-7-307-22226-7	\N	张志强、刘照、肖晓晖 主编 	平装	1-1	16开	29.00	\N	武汉大学出版社	\N	\N	\N	2021-05-01	/book/fd0942fb-f421-4ac1-bf9b-d121ce2b27d31070924.jpg	"本书是武汉大学机械设计制造及其自动化专业必修课——“专业综合实验”的配套教材，是在总结多年实验教学经验的基础上编写而成的。全书共分为三部分，第一部分简要阐述了实践教学的意义及国外大学的实践教学现状；第二部分主要介绍实验相关的理论知识；最后一部分提供了面向机械专业的一系列综合实验，主要包括现代设计、先进制造和智能机器人等方面内容，这些实验紧密结合各种先进设计、制造和自动化技术在机械工程上的实际应用。本书可作为机械类学生学习专业综合实验课程的实验指导书或参考书，非机械类学生也可参考。 "	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	283
195	公共城市的地平线：超大型城市治理的问题、特性与逻辑	978-7-309-15465-8	\N	秦德君 著 	平装	1-1	32开	55.00	289.0千字	复旦大学出版社	324	\N	\N	2021-05-01	/book/de0225cd-433e-4279-aa69-393ead683c611070926.jpg	　　超大型城市的出现，是人类城市文明的第二个里程碑。它是人类地平线上的新现象，也是人类城市文明的新形态。 　　超大型城市有着极高的公共性，这种公共性就是超地域的巨大影响力。当城市体量规模发展到一定阶段时，它就成为地域城市群的领袖，产生“量变到质变”的飞跃而成为世界重要城市序列的参与者。 　　超大型城市还有着极高的治理性，它的发展与状况取决于治理行为科学性的层级。超大型城市治理实质上就是对城市现代性进行重整，这不仅是城市治理上的一种革命性变革，也是一种颠覆性的城市创新。 　　上海作为中国“城市样本”之一，在城市治理中遇到的许多问题具有先期性，其探索性、公共性、引领性不断增益。本书立足于上海的城市治理实践，探索超大型城市治理现代化及其问题、特性与逻辑，助力提升中国城市治理效能与城市能级，推进中国现代化进程。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	627
196	中国城市通史	978-7-5690-3809-5	\N	何一民、陆雨思、王立华、韩英、黄灵、田玥 	平装	1-1	16开	220.00	\N	四川大学出版社	\N	\N	\N	2020-12-01	/book/c7799881-f622-4823-80f0-ea33f5d726fa1070931.jpg	全书凡四篇。第一篇以宋代城市的发展变迁为中心，在分别梳理北宋、南宋城市发展脉络的基础上，对其中的重点问题如城市分布、规模与内部结构的演变，城市经济发展，城市管理的变化，城市生活变迁等进行探讨。第二、三、四篇分别以辽、夏、金的城市发展为中心，主要探讨了其城市兴起的自然地理和社会经济条件，城市数量、规模的变化和空间分布特征，城市经济发展的状况及特点，居民结构以及城市社会生活变迁等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	943
197	中国城市通史	978-7-5690-3808-8	\N	何一民、赵淑亮、吴朝彦 	平装	1-1	16开	220.00	\N	四川大学出版社	\N	\N	\N	2020-12-01	/book/25dba7e3-0033-4d2b-bb87-00c68141d9fd1070932.jpg	上篇以元代的城市发展为研究对象，全面梳理这一时期城市的发展与变迁过程，再现城市发展的基本轨迹，不仅对城市发展中所涉及的重要问题，如自然、人文环境对城市分布的影响，城市体系、数量及空间的变化，城市经济的发展和社会的变迁等进行研究，还对“省制”的创设等进行重点探讨，揭示出元代城市多元性、开放性的特点。下篇以明代的城市发展为研究对象，重点研究明代城市的周期性发展现象及其影响因素、城市经济与城市发展等问题，并以军事城市和建制城市的兴起、数量与规模等为切入点，探讨明代城市发展的特点。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	969
198	英文小说名篇导读：从文字到光影的嬗变（汉、英）	978-7-307-22189-5	\N	程向莉 主编 	平装	1-1	16开	40.00	\N	武汉大学出版社	\N	\N	\N	2021-06-01	/book/96191fc5-f41f-47d3-a375-6d51b56bd8751071051.jpg	《英文小说名篇导读:从文字到光影的嬗变》聚焦六部改编为电影的英美小说名篇，探讨小说与电影不同的表达形式。全书分为上篇、中篇和下篇三个部分。上篇是由编者撰写的六部英美小说评论，实现从文字到光影的整体鸟瞰。中篇内容源于以产出为导向的真实课堂，撷取六部小说中的一个章节，从小说文本和影视赏析两方面设计教学任务，实现从文字到光影的具象体现。下篇是学生创作荟萃，学生在学习上篇和中篇内容后融会贯通，在课堂内外完成极具创意的作品。本教材上篇、中篇和下篇融为一体，整体构架立足于小说文本从文字到光影的嬗变。编著布局从整体鸟瞰到局部透视，从小说多模态赏析到小说作品创作，便于读者在赏析的同时实现思维提升。本书适合于作为英语语言文化类通识课教材，也适合对于英美文学作品感兴趣的读者阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	725
199	高等代数学习指南	978-7-301-12905-0	9787301129050	蓝以中 	\N	1-1	16开	40.00	410.0千字	北京大学出版社	472	7301	\N	2021-05-11	/book/1dbc9748-373b-4a48-9f33-163c1fccabe11290502.jpg	本书是本科生学习高等代数课程的学习指导书，内容是教会学生如何学好高等代数，其中包括学习高等代数的思维方法和解题思路的归纳总结。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	409
200	语言学纲要(修订版)	978-7-301-16310-8	9787301163108	叶蜚声，徐通锵 	\N	4-1	16开	69.00	270.0千字	北京大学出版社	292	7301	\N	2021-04-30	/book/a6e59c01-e8be-4448-b76a-e2d2219480741631007.jpg	本书是我社出版的《语言学纲要》的修订版，已入选十一五规划教材。本书是我社出版的《语言学纲要》的修订版.本次修订在内容上有所扩充，同时努力在整体上保持原书的特色：大的章节没有变动，大的理论框架也没有改变，修订内容力求与原书有机地统一成整体。全书修订主要包括三个方面：1.补充新的研究内容；2.对于已有的概念或观点增加例证和解释说明；3.个别观点和材料的修正。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	597
201	个人自由与社会进步	978-7-301-22193-8	9787301221938	胡适 	\N	1-1	16开	39.00	142.0千字	北京大学出版社	248	7301	\N	2021-05-20	/book/c01d4c79-8752-4c5d-ab93-514b07b195882219302.jpg	本书从北大版《胡适文集》中，主要是第十一卷中，选取比较轻松好读的文字15万字左右，如《我们要我们的自由》、《北京大学五十周年》、《争取学术独立的十年计划》等等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	326
202	哲学与人生：胡适演讲集(四)	978-7-301-22199-0	9787301221990	胡适 	\N	1-1	16开	39.00	128.0千字	北京大学出版社	224	7301	\N	2021-05-20	/book/640fcb70-07f5-4066-acf3-3474f699a27b2219902.jpg	本书选自北大版《胡适文集》第12卷。作为哲学家、学者、作家兼教授的胡适，不仅其诗其文对当时或者后世有一定影响，其演讲艺术亦因有独特的风度而受到学者的普遍赞誉。主要收卷五人生与社会，卷六科学、文化的内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	494
203	一封未寄的信：胡适译短篇小说集	978-7-301-23661-1	9787301236611	胡适 	\N	1-1	16开	38.00	152.0千字	北京大学出版社	204	7301	\N	2021-05-20	/book/58bed8ca-fa2b-4460-9cc4-e71bda3de7292366102.jpg	胡适曾经翻译出版的两本短篇小说集，所收均为名家名作，其中《最后一课》收进小学语文课本。《短篇小说 第一集》收《最后一课》、《柏林之围》（[法]都德），《百愁门》（[英]吉百龄），《决斗》（[俄]泰来夏甫），《梅吕哀》、《二渔夫》、《杀父母的儿子》（[法]莫泊桑），《一件美术品》（[俄]契诃夫），《爱情与面包》（[瑞典]史特林堡），《一封未寄的信》（[意]卡德奴勿），《他的情人》（[苏]高尔基）等11篇短篇小说。每篇前均有作者简介。附录《论短篇小说》。初版只收10篇，再版增加《他的情人》一篇。 《短篇小说 第二集》收《米格儿》、《扑克坦赶出的人》（[美]哈特），《戒酒》（[美]欧亨利），《洛斯奇尔的提琴》、《苦恼》（[俄]契诃夫），《楼梯上》（[英]莫理孙）等短篇小说6篇。每篇前有作者简介。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	210
204	文化记忆：早期高级文化中的文字、回忆和政治身份	978-7-301-25261-1	9787301252611	(德)扬·阿斯曼 	\N	1-1	16开	69.00	296.0千字	北京大学出版社	388	7301	\N	2021-05-19	/book/183bda97-a32a-4a04-9cd5-1fb9b08fa9ff2526102.jpg	记忆问题是历史研究中的新领域，丛书中已经收入一本讨论社会记忆问题的文集，本书之论题为文化记忆。本书的译介将会促进国内史学界对记忆问题的深入研究。两位作者是夫妻，都以研究文化记忆问题而闻名。应丛书主编之约，两人从两本专著中选取部分章节，合编为一书。原著分别为Jan Assmann的Das kulturelle Gedaechtnis.（Munich: C.H. Beck, 2nd Edition 1997）和Aleida Assmann的Erinnerungsraeume.（Munich: C.H. Beck, 3rd Edition 2006）。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	164
205	唐诗选注	978-7-301-31051-9	9787301310519	欧丽娟 	\N	1-1	16开	99.00	560.0千字	北京大学出版社	564	7301	\N	2021-04-25	/book/57c8c75f-2475-4db3-b90d-11b5c85b9fb731051.jpg	深刻地读首唐诗吧！ 唐诗的美，折射着帝国的辉煌与沧桑， 镌刻着对人生的体证、对悲欢的感悟、对天地万物的悲悯，点点滴滴都是深情与悲愿。 《唐诗选注》参酌各家选本，兼采众美，选注了自初唐以迄唐末五代三百年间，共七十九家五百四十五首作品，以编年的方式观察其间时代兴衰及诗歌流变的情形。除简要的小传外，每一首诗的典故注解力求清晰详实，所加诗评更有助于画龙点睛，达到深入体会大唐诗人的艺术锻炼和人格努力的目的。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	890
206	数字电子技术（第2版）	978-7-301-31886-7	9787301318867	赵建周，张天鹏 	\N	2-1	16开	59.00	581.0千字	北京大学出版社	380	7301	\N	2021-04-30	/book/d7ebf4f2-f7fb-409c-8e4a-0c84229883a131886.jpg	本书从当前的教学实际出发，将理论知识和实践教学相结合，既强调理论基础，又注重实践应用。本书重点介绍数字电子技术的基础知识、基本理论以及数字电路的一般分析方法和设计方法。全书共分9章，内容包括逻辑代数基础、逻辑门电路、组合逻辑电路、触发器、时序逻辑电路、脉冲波形的产生与整形、半导体存储器、数/模和模/数转换器及数字系统设计。本书可作为高等院校电子信息工程、电气工程、通信工程、电子科学与技术、自动化、机电一体化及其他相关专业的本科生或专科生教材，也可作为自动化、通信、电子技术等行业的工程技术人员的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	315
207	三维彩色立体图集	978-7-301-31932-1	9787301319321	傅华夏 	\N	1-1	16开	139.00	330.0千字	北京大学出版社	220	7301	\N	2021-04-27	/book/192595fc-04e0-4da4-ae8f-710c68a8f4b23193202.jpg	本书采用三维模型的方式注解了国家建筑标准设计图集16G101—1 的全套详图以及16G101—2、16G101—3 的部分详图，除包含一般教材中基本的梁、板、柱、墙、楼梯、 基础详图外，还加入了国家标准中的无梁楼盖、地下室外墙、板洞、板翻边、基坑、柱帽、后浇带、桩基承台等相关混凝土构件详图。 全书共分为7 章，内容包括：一般构造标准构造详图；柱平法标准构造详图及三维示意图；剪力墙平法标准构造详图及三维示意图；梁平法标准构造详图及三维示意图； 板平法标准构造详图及三维示意图；楼梯平法识图规则与标准构造详图及三维示意图；基础平法标准构造详图及三维示意图。 本书可作为高职高专院校、成人教育学院等高校建筑工程类专业教材和教学参考书，也可供从事土木工程相关工作的工程人员学习参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	353
208	居里夫人文选（学生版）	978-7-301-31952-9	9787301319529	玛丽·居里 	\N	1-1	16开	38.00	100.0千字	北京大学出版社	232	7301	\N	2021-04-28	/book/cd3b4e27-43e9-467c-8e87-d94c24528bba31952.jpg	作者研究放射性物质的代表性论文、自传、居里传、诺贝尔奖获奖演说的文集，附有诺贝尔奖委员会给作者的颁奖词、作者生平大事年表及论著目录和各种奖励荣誉，以及作者母女两代人的中国研究生的回忆文章。反映了作者的科研活动、卓越成就和人生追求，以及她的优秀品质、工作精神和处事态度。生动描述了作者从小对学习的强烈兴趣、处处表现出的顽强进取精神，介绍了她只身远赴异国求学和工作，在极其简陋和艰苦的条件下制备放射性元素钋和镭，推动原子核科学发展，先后获得诺贝尔物理学奖和化学奖的过程。既是科学经典，也是青少年励志读物。 ——《中国教育报》 本学生版为中学生量身打造，分为上篇、中篇和下篇三部分。上篇为阅读指导，由著名科普作家、华中科技大学杨建邺教授撰写，深入浅出地介绍了居里夫人的生平及其贡献，并为学生提供切实的阅读建议。另有美国社会活动家麦隆内夫人撰写的《伟大的心灵》，讲述了居里夫人赴美接受1克镭的捐赠过程。中篇精选原著的精华，展现了居里夫人的博士论文，她未丈夫皮埃尔·居里撰写的小传，以及居里夫人的自传。中篇由华南农业大学胡圣荣教授主译。下篇为学习资源，包括扩展阅读、数字课程、思考题、阅读笔记。名著名译，名家导读，配备优质融媒体学习资源，有助于中学生更好地阅读经典、理解经典、感受经典魅力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	645
210	计算机与人脑（学生版）	978-7-301-31962-8	9787301319628	冯·诺伊曼 	\N	1-1	16开	38.00	100.0千字	北京大学出版社	228	7301	\N	2021-05-08	/book/efcdc1a7-18ad-4297-b254-eb15efb6756231962.jpg	为电子计算机和人工智能提供思想基础的经典著作，根据作者生前部分演讲稿整理而成。随着人工智能时代的来临，人类更加关注计算机是否可以实现智能化，即像人的大脑一样工作。作者在书中用数学语言表达了他对于这个问题的思考。分“计算机”和“人脑”两个部分，共16章。第一部分描述模拟计算机和数字计算机的区别，提出混合数字和模拟两种原则的计算机模型。第二部分简述神经元、神经脉冲以及由神经元组成神经系统（神经网络）的记忆和逻辑结构等，比较其与计算机的相似和不同之处。作者站在20世纪50年代的最前沿思考计算机与人脑问题。本书有助于读者理解计算机、神经网络，乃至人工智能的基本思想。——《中国教育报》《计算机与人脑》是20世纪著名的天才之一，在诸多领域有杰出建树，被誉为“博弈论之父”和“计算机之父”冯·诺伊曼的经典著作。本书为中学生量身打造，分为上篇、中篇和下篇三部分。上篇为阅读指导，由中国科学院研究员胡作玄撰写，深入浅出地介绍了甘子玉的生平、《计算机与人脑》的主要内容、冯·诺伊曼的科学贡献，并为学生提供切实的阅读建议。中篇精选《计算机与人脑》原著精华，由著名管理专家、北京大学兼职教授甘子玉翻译，将这部关于计算机与人脑的革命性著作的精华内容突出呈现。下篇为学习资源，包括扩展阅读、数字课程、思考题、阅读笔记。名著名译，名家导读，配备优质融媒体学习资源，有助于中学生更好地阅读经典、理解经典、感受经典魅力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	372
258	岛崎藤村小说与近代日本社会问题研究	978-7-5618-6913-0	9787561869130	李敏 	0	1-1	16开	48.00	295.0千字	天津大学出版社	228	\N	\N	2021-05-05	/book/6819da51-c573-48ce-88ec-20187a9b17f41071593.jpg	书稿在吸收和借鉴前人研究成果的基础上，结合相关文献资料，从文学、历史学、社会学等相关学科结合的角度，对岛崎藤村的《破戒》、《家》、《新生》这三篇长篇小说以及反映了近代日本风俗业的其他小说进行了分析，考察了近代日本社会中的部落民歧视、家制度、近亲通婚现象、风俗业繁荣这几大社会问题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	900
211	市政工程材料(第二版)	978-7-301-31984-0	9787301319840	郑晓国 	\N	2-1	16开	59.00	507.0千字	北京大学出版社	340	7301	\N	2021-05-08	/book/7766179f-ea27-47e5-aa44-f1a0e7fcb0aa31984.jpg	本书通过对市政工程技术专业毕业生就业对应岗位材料试验员的工作内容进行分析梳理，抽取代表性的八个典型实际工作项目：集料检测；水泥检测；沥青检测；钢材检测；水泥混凝土配合比设计；水泥稳定碎石配合比设计；沥青混合料配合比设计、土工织物检测。 本书基于每个项目工作过程进行任务分析，结合岗位素质、技能与知识要求对学生边教边学、边学边做，实现教学做一体化。 本书适合作为高职高专院校市政类专业的教材，也可作为相关专业的人员的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	430
254	设计管理	978-7-5618-6870-6	9787561868706	李通，赵莹雪 	\N	1-1	16开	48.00	182.0千字	天津大学出版社	152	\N	\N	2021-04-01	/book/40364d6d-5b55-4a91-a43b-9ce53eb683539787561868706.jpg	本书定位为面向设计类本科学生设计管理入门启蒙教材。本书分为四章。 第一章集中解决“What什么是设计管理问题”。 第二到第三章，依据设计项目发展的时间顺序展开，通过“How如何开展设计管理”这一话题探讨设计开始前、设计进行中、设计完成后三个阶段需要什么样的设计管理，如何操作。考虑到初入大学的设计类学生对设计相关概念理解较浅，相关管理知识零储备的特点，书的主题内容将以“讲故事”的方式进行组织， 分别从设计项目签约的甲方和乙方的视角进行说明。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	773
212	深入浅出TCP/IP和VPN	978-7-301-32024-2	9787301320242	李宗标 	\N	1-1	16开	198.00	1152.0千字	北京大学出版社	804	7301	\N	2021-05-21	/book/b728c45d-b6c0-4381-8fbe-03ec38775a6232024.jpg	TCP/IP （Transmission Control Protocol/Internet Protocol的简写），传输控制协议/因特网互联协议，又名网络通讯协议，是Internet最基本的协议、Internet国际互联网络的基础，由网络层的IP协议和传输层的TCP协议组成。 本书是一本图文并茂的网络技术书籍，旨在让读者理解TCP/IP的基本知识和原理，掌握TCP/IP的基本技术及应用。本书主要内容包括：第1章为TCP/IP 概述；第2章具体讲述IP协议；第3章主要讲解路由协议；第4章具体讲述TCP协议；第5章主要讲解UDP；第6章主要讲解GRE；第7章主要讲解IPSec；第8章主要讲解MPLS；第9章主要讲解BGP；第10章主要讲解MP-BGP、MPLS、L3VPN；第10章主要讲解VXLAN；第11章主要讲解SDN；第12章主要讲解CloudVPN与SD-WAN；第13章主要讲解应用场景及组网，以及基于native IP（IP协议）、VPN、SDN/SD-WAN 的基本应用。 本书既适合计算机网络的开发人员阅读，也可作为大专院校相关专业的教学参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	434
1794	中国哲学简史（英汉双语对照）	9787513561280	\N	冯友兰　著，赵复三　译 	平装	1-1	大32开	80.00	\N	外语教学与研究出版社	\N	\N	\N	2015-06-01	/book/9a9d9124-2322-484f-9520-bc8109d182281086100.png	　　《中国哲学简史》成稿于1946年至1947年冯友兰受聘美国宾夕法尼亚大学期间，为中国哲学史课程讲稿，于1948年由美国麦克米伦公司出版。本书以二十余万字深入浅出地讲述了几千年的中国哲学史，不仅一直是世界许多大学中国哲学的通用教材，更成为许多西方人了解中国思想文化的入门书。此次出版为英汉对照版本，中文译文采用赵复三译本。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	857
213	世界格局中的澳大利亚：历史、现实与未来	978-7-301-32033-4	9787301320334	刘树森 	\N	1-1	16开	79.00	600.0千字	北京大学出版社	332	7301	\N	2021-04-25	/book/c27f4fc0-2131-4c5f-bce1-fb1ac6bc227932033.jpg	本书是一部具有较高水平的澳大利亚研究中英文论文集，由北京大学资深教授胡壮麟先生等40余位国内外专门从事澳大利亚研究的专家和学者撰写，从人类文明发展史与当今世界日益全球化的双重视角探讨澳大利亚作为亚太区域一个重要国家的发展与变化,包括其自然环境、历史、社会、文化、民族个性、贸易、国际关系、教育、语言文学、艺术以及新媒体等诸多方面的内容，以及澳大利亚在世界文明发展历程中的地位与作用，论文体现了当前澳大利亚研究的领先学术水平，在研究对象与研究方法等方面具有创新性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	808
214	托马斯·品钦四部小说的空间问题研究	978-7-301-32051-8	9787301320518	李荣睿 	\N	1-1	16开	72.00	345.0千字	北京大学出版社	260	7301	\N	2021-05-14	/book/7526a3db-8c2b-41a9-8d5b-8446c73a8eda32051.jpg	本书以后现代代表作家托马斯·品钦的四部小说《V.》、《拍卖第49批》、《葡萄园》和《性本恶》为研究对象，将叙事空间研究和空间批评理论相结合，从空间的角度分别考察这四部小说，以便更好地揭示作品对人物思维方式的批判，更全面深入地理解品钦对后现代多样性多元化的谨慎态度、作品的后现代叙述技巧与社会政治含义的深层关联，以及小说对二战后资本主义社会的空间化思考，并修正先前的研究存在的相关问题和弥补它们的不足。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	747
215	直面冲击，面向未来	978-7-301-32056-3	9787301320563	孙祁祥 	0	1-1	16开	65.00	323.0千字	北京大学出版社	340	7301	\N	2021-05-20	/book/d0fda573-8f2e-4eb5-8410-0a78804145991071129.jpg	《直面冲击，面向未来——北京大学经济学院2020年两会笔谈》是2020年全国“两会”之后北京大学经济学院的多位专家学者围绕《政府工作报告》各抒己见，汇总而成。特别是，针对2020年的新冠肺炎疫情，大家从各种不同角度，从宏观方面给出了政策建议，畅谈经济改革与发展，为国家经济发展与制度创新提供智力支持。“两会笔谈”已经成为研究“两会”经济热点、分析国民经济现状、提供相关政策意见的重要思想阵地，产生了良好的政策影响和社会影响。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	671
216	CEO人力资源管理与开发（第二版）	978-7-301-32068-6	9787301320686	赵曙明,刘洪,李乾文 	\N	2-1	16开	55.00	427.0千字	北京大学出版社	304	7301	\N	2021-04-30	/book/5a9eddeb-3f9b-488b-9d04-f24357dade2032068.jpg	本书站在培养具有全球视野和战略思维人才的高度，以企业高管的视角，关注企业人力资源管理传统职能的新变化，以及VUCA时代和数智时代企业人力资源管理问题，全面、深入地阐述适应中国新时代的企业人力资源管理系统，反映新的人力资源管理发展趋势。本书对象明确、体系新颖、案例引导、研究扎实。本书针对的是企业的CEO层面，以及未来希望成为CEO层面的企业高级经营管理者。本书充分梳理了21世纪人力资源管理的最新发展趋势，特设了组织学习与员工发展、劳动关系管理、国际人力资源管理、全球化背景下的领导胜任力、我国人力资源管理发展历程和面临挑战等章节。南京大学商学院是国内人力资源管理研究的重要力量，作者先后承担了“转型期人力资源管理的若干重大问题”“基于创新导向的中国企业人力资源管理模式研究”等一系列国家自然科学基金重点项目，举办了颇具国内外学术影响力的十届“企业跨国经营国际研讨会”。本书吸收了已有的持续化研究成果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	597
411	会计培训教程	978-7-5618-6916-1	9787561869161	张巨强 	\N	1-1	16开	21.00	169.0千字	天津大学出版社	104	\N	\N	2021-05-01	/book/207446e5-609f-4a14-abbb-94a16fbfcaac9787561869161.jpg	本书是根据当前职业教育的发展要求，即以技能培养为主线来设计项目内容，按照项目教学法的教学形式来组织编写的，符合当前职业教育发展的需要。在保证基本能力的基础上，重点培养学员分析问题、解决问题的能力。整个教材实训项目内容严格按照《会计职业标准》中级工技能标准编写开发，能更好的适用于社会需求人员等群体的技能培训教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	723
257	BIM技术与建模技巧（中级篇）	978-7-5618-6859-1	9787561868591	王帅 赵建 	\N	1-1	16开	78.00	412.0千字	天津大学出版社	276	\N	\N	2021-05-01	/book/826f023f-dd6a-4df4-8085-298a031d7a9b9787561868591.jpg	本书旨在承接BIM基础课程，从Revit的更多操作技巧入手，针对BIM课程所需的相关操作进行介绍，其中涉及到多种软件之间的关联。并着重介绍了与之并列的BIM核心建模软件ArchiCAD，在国内教学领域创造性的同时引入Revit与ArchiCAD，学习者在对比学习的过程中能对BIM的理解更为深入和充分。本书可作为应用型本科、高职高专院校土建筑学专业教材,也可作为高校、岗位培训和相关专业人员的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	963
217	文体·文事·文学史——中古文体学研究	978-7-301-32095-2	9787301320952	胡大雷 	\N	1-1	16开	76.00	375.0千字	北京大学出版社	420	7301	\N	2021-05-12	/book/6cbc89e6-4061-4906-be7b-82c80be6e82b32095.jpg	本书讨论发生在“文体”与“文体”研究上的那些故事，全书共七章，第一章论述具有总体性质的中古文体问题，后六章分别论述了中古时期的文体命名、文体扩张、文体三分及中古诗人谱系； “言笔之辨”与“文笔之辨”；史学与文体的关系及“说”体、乐府的文体、诗歌文体、辞赋文体等。书讨论发生在“文体”与“文体”研究上的那些故事，全书共七章，第一章论述具有总体性质的中古文体问题，后六章分别论述了中古时期的文体命名、文体扩张、文体三分及中古诗人谱系； “言笔之辨”与“文笔之辨”；史学与文体的关系及“说”体、乐府的文体、诗歌文体、辞赋文体等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	776
218	数字时代的教学求变——西南交通大学教师在线教学研究与探索文集	9787564380243	\N	苏谦, 崔凯, 主编 	0	1-1	16开	68.00	247.0千字	西南交通大学出版社	220	\N	\N	2021-05-01	/book/15644c9e-3c9c-4011-ad86-01997cd929101071366.jpg	本书是西南交通大学37位老师/团队结合授课体验和教学反思写成的教研论文集，共分为时代特征理性思索（识变）、课程思政深入探究（求变）、教学模式流程再造（应变）、特别记录全面梳理（复盘）4部分内容，尤其对如何将思政元素和交大师生的精神面貌及爱国情怀有机融入专业学习中也进行了阐释，呈现了一则则生动的课程思政案例。本书从宏观视野和微观视角，给出了富有启发性和推广性的建议，给开展在线教学和混合式教学提供了有益的借鉴与启发。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	841
308	法律英语泛读教程（上）	978-7-301-27498-9	9787301274989	张法连 	\N	1-1	16开	78.00	350.0千字	北京大学出版社	376	\N	\N	2021-07-09	/book/b4d22d30-3fc1-4b93-9beb-93de8916d5982749803.jpg	随着我国入世和世界经济一体化进程的不断加快，国际交流合作日益增多，涉外法务活动空前频繁，法律英语的重要性日益凸显。掌握专业英语已经成为现代法律人必备的职业素质。由于法律英语的特殊性。国内一直没有一个科学的考核指标衡量法律从业人员专业英语的掌握程度。法律英语证书（LEC）全国统一考试的推出为我国法律英语的教与学指明了方向。意义重大、影响深远。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	582
219	外国语言文学的本体与教学研究（第二辑）	9787564378981	\N	周琳, 主编 	0	1-1	16开	88.00	480.0千字	西南交通大学出版社	280	\N	\N	2020-12-01	/book/7d7f0616-f160-4e47-a31f-47c0b89cca071071375.jpg	本论文集是重庆工商大学外国语学院老师的研究成果集，共收录2019至2020年教师撰写的近30篇教科研论文。论文展示的研究方向包括：外语教学、语言学、文学、翻译、区域与国别研究、跨学科研究等。本论文集凝聚了外语专业教师在高校教科研方面不断探索、不断创新思考教学教研现状及对策的最新成果，体现了教师力争走在教研前沿的努力，也激励老师们为今后在更广的领域、更深的层面开展高校教学研究和实践奉献出更新、更多的成果。本文集对于其他专业教师开展相关教学改革研究具有一定的借鉴意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	441
220	城市规模扩大对居民收入的影响研究——来自CHIP2013的经验证据	9787564379629	\N	梁艳菊, 著 	0	1-1	16开	78.00	262.0千字	西南交通大学出版社	280	\N	\N	2020-12-01	/book/6a10d2b0-64dc-435c-b031-0d5d92ad476a1071377.jpg	本书是探讨城市化过程中城市发展规模适度性问题的学术著作。本书在对最佳城市规模和城镇居民收入影响因素相关研究的基础上，构建了以居民收入为被解释变量，以城市规模为核心解释变量的回归模型；运用统计回归方法和工具变量估计，使用“中国城乡居民收入分配与生活状况”第五次入户调查中的城镇居民调查数据，以及样本城市的宏观特征数据，实证分析了能够使城镇居民收入最大化的最佳城市规模区间，城市规模对不同技能组、不同行业、不同产业城镇居民收入的影响，城市规模对城镇内部居民收入差距的影响，城市规模对居民收入增长的影响机制等；在此基础上，提出促进我国城市化进一步发展的政策建议，以期能为我国的城市化发展、以及实现全面小康社会提供参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	611
221	印迹——西部大地人居环境规划设计廿年	9787564380120	\N	邱建, 等著 	0	1-1	16开	268.00	1105.0千字	西南交通大学出版社	584	\N	\N	2021-04-01	/book/8a7bc04f-da1a-4ff1-92c6-1661753669171071385.jpg	西部大开发是党中央贯彻我国现代化建设“两个大局”战略思想、面向新世纪作出的重大战略决策。在中国共产党领导下，经过20年两轮大开发，西部经济建设取得显著成果，为全面建成小康社会奠定了坚实基础。本书为作者深度参与以四川为主阵地的西部人居环境建设的成果，记录了该艰辛探索历程中思想碰撞的火花、智慧交流的硕果，集结了作者团队在灾后重建、城乡规划、风景园林、建筑设计、相关领域、人才培养6方面取得的科研和实践应用成果，期望为新时代推进西部大开发形成新格局提供有益借鉴和参考，从人居环境规划设计视角向世界展示：西部设计工作者在优越的社会主义制度下为灾区重建美好家园、为欠发达地区改善人居环境质量不懈努力的真实立体画卷。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	900
222	空乘形体塑造与仪态训练	9787564380144	\N	吴霜, 王月, 主编 	0	1-1	16开	39.00	350.0千字	西南交通大学出版社	228	\N	\N	2021-04-01	/book/a607b080-3906-4726-b3ab-89643757dbd41071386.jpg	本书为高等职业教育空中乘务专业教材，旨在帮助空乘专业学生树立正确的审美理念，塑造优美的体态，培养高雅的气质。全书共分为6个单元，分别是形体训练概述、形体素质训练、形体基础训练、形体舞蹈训练、形体仪态训练、形体塑造与健身。每个单元均设置“教学目标”“思考与训练”栏目，帮助学生学与练结合，塑造符合空乘职业素养要求的优美个人形象。全书图文并茂，形象地讲解了形体训练的科学理念和有效方法，也可作为相关企业和机构的培训用书，还可作为各行业服务工作者的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	572
224	数字信号处理学习指导及实验	9787564380151	\N	袁世英, 姚道金, 曹东, 主编 	0	1-1	16开	36.00	319.0千字	西南交通大学出版社	204	\N	\N	2021-04-01	/book/2eaf93ae-32dd-40cf-a8e7-4984595821121071396.jpg	本书为普通高等院校通信、电子、计算机等相关专业的教材，为主教材《数字信号处理》的学习参考书。全书共分为两大部分：第一部分为学习指导，第二部分为上机实验。第一部分中的每章都由重难点和习题解答2个相互关联的部分组成，对配套主教材的重点与难点进行了归纳、集中与概括，并对全部习题进行了详细、严谨的解答。第二部分的实验包括离散系统的分析、快速傅里叶变换及应用和滤波器的设计。本书与主教材相互补充，有助于深入理解数字信号处理的理论及其应用。本书也可作为考研人员的参考教材，还可作为相关专业工程技术人员的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	190
225	初中数学审美训练案例探究	9787564379971	\N	谢祥, 著 	0	1-1	16开	69.00	220.0千字	西南交通大学出版社	228	\N	\N	2021-03-01	/book/dde39040-a51c-4abc-a347-ff86a4af21ce1071397.jpg	中学数学教育中需要渗透美育，引导学生对数学产生兴趣。教师渗透数学美育要坚持“有意、有机、有序、有法、有范”五个原则，最重要的途径就是投身于数学的创造性实践活动之中，在实践中培养数学审美能力，发现数学美、感悟数学美、创造数学美。本书分三部分：第一部分为作者研究数学美育探索的论文；第二部分为作者选取的审美训练教学案例，第三部分为微型审美案例选谈。本书在培养初中学生的数学审美方面提出具有启发性和指导性的观点，实用性、创新性强，适合作为初中数学教师的教学参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	940
226	青春向党　奋斗强国——新时代西南交大青年说	9787564380298	\N	张军琪, 朱炜, 主编 	0	1-1	16开	96.00	265.0千字	西南交通大学出版社	260	\N	\N	2021-05-01	/book/b3990f41-0f2a-4d59-bd5d-7b39f58082311071401.jpg	本书为文集，以 “青春奋斗”“责任担当”“初心使命”为主线，遴选了西南交通大学60位优秀学生、青年教师、青年校友的典型代表，介绍了他们的先进事迹，充分展现交大青年的奋斗精神、家国情怀、责任担当、初心使命，引领青年学生不忘初心跟党走、青春建功新时代。本书是创新大学生思想政治教育工作和青年思想政治引领工作的有益探索，有助于鼓舞青年学子在西南交通大学建设交通特色鲜明的世界一流大学和实现中华民族伟大复兴的中国梦的新征程中建功立业。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	301
368	精准扶贫战略下城乡低保目标瞄准及执行机制优化--广东经验	9787306070869	\N	庄文嘉、岳经纶、刘洋 	平装	1-1	16开	86.00	\N	中山大学出版社	\N	\N	\N	2021-03-01	/book/60a7065f-06fa-45ab-81b8-0249f5732e6c1073771.png	本书将目光聚焦于城乡低保目标瞄准的“广东经验”，在回顾国内外贫困治理理论研究成果的基础上，重点对新时代以来广东低保瞄准的改革创新实践、引入准家计模型的识别指标体系、改革后的瞄准效果，以及可能产生的变化，进行全面的梳理、测算和分析。城乡低保目标瞄准的“广东经验”，不仅可以有效提升城乡低保对象瞄准的准确度，很大程度上降低错保和漏报率，而且可以为2020年之后中国的贫困治理提供一种可借鉴、可复制的路径。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	229
227	各美其美　臻于至善—贵阳市安井学校与麻江县第三小学学校管理与教学实践论文集（2020）	9787564380472	\N	王娜, 韦运霞, 主编 	0	1-1	16开	120.00	262.0千字	西南交通大学出版社	196	\N	\N	2021-05-01	/book/d6b90c50-bd2b-4ca2-aa16-c95c87712a0b1071404.jpg	本书是贵阳市安井学校和麻江县第三小学校教师在2020年编写的关于教学与管理工作的论文集。全书围绕贵阳市安井学校与黔东南州麻江县第三小学开展的“美”“善”教育以及生动的课堂教学改革实践主题展开，共有“教育管理”“小学语文”“小学数学”“道德与法治”“小学英语”“小学体育/小学美术”“信息技术/小学科学”7个部分共25篇文章，体现了2020年两个学校教育对口帮扶过程中的喜人成果，从小的角度与横断面展现了地方小学校生机勃勃、欣欣向荣的良好风气。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	655
228	语文教育研究2021	978-7-307-22272-4	\N	汤天勇 主编 	平装	1-1	16开	48.00	\N	武汉大学出版社	\N	\N	\N	2021-06-01	/book/024f9e6e-7bd4-479e-9854-2f34014bd3ea1071435.jpg	本书主要聚焦中小学语文教育改革，力争助力鄂东语文教学与教研，促进鄂东语文教育学派形成并引领鄂东语文教学改革与实践。全书共分6个板块，主要包括名师风采、教育访谈、语文视点、语文研究、教学设计以及动态聚焦。本书立足鄂东，面向荆楚，辐射华夏，意愿在热闹喧哗的基础语文研究领域发出一点自己的声音。本书围绕语文教学，探讨了目前存在的问题以及前沿问题，以此助力鄂东语文教学与教研,促进鄂东语文教育学派形成,引领鄂东语文教学改革与实践。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	946
229	本·琼生城市喜剧中的怪诞研究	978-7-307-21801-7	\N	吴美群 著 	平装	1-1	16开	39.00	\N	武汉大学出版社	\N	\N	\N	2021-06-01	/book/5757ef5c-ff19-444e-a615-e435f51732931071441.jpg	本·琼生的城市喜剧代表了17世纪早期英国喜剧从宫廷走向城市、从浪漫走向现实、从田园牧歌走向讽刺批评的新方向。本书以本·琼生城市喜剧中的怪诞为研究对象，首先探究其怪诞的根本性质及其思想来源，随后分别从四个方面探讨了不同城市喜剧中的怪诞形态，即《福尔蓬涅》中的愚人怪诞、《艾泼辛》中的女性怪诞、《炼金术士》中的怪诞城市和《巴斯洛缪集市》中的怪诞群像，提出琼生式怪诞是兼具古典式道德劝诫性和现代化狂欢颠覆性的双重怪诞。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	331
230	平易近人——习近平的语言力量（外交卷）	978-7-313-20196-6	\N	苏格 	平装	1-1	大32开	68.00	\N	上海交通大学出版社	\N	\N	\N	2018-10-01	/book/95650a02-64bc-4f9c-88e5-95463c7510371071450.png	党的十八大以来，在以习近平同志为核心的党中央坚强领导下，中国特色大国外交不断取得新成 ，开创新局面，形成了完整的理论体系、丰富的实践内容和鲜明的风格特征。在对外交往中，习近平善于引用古今中外的诗文谚语，以生动形象的语言阐述中国外交的新理念、新思想、新战略，给人留下深刻印象。 本书以语言力量为出发点，选取习近平关于中国外交的意义深远且富有特色的论述，分开篇、形象比喻篇、俗文俚语篇和诗文引用篇四个部分，对党的十八大以来的中国外交作了全面系统的解读，以帮助读者更好地理解习近平外交思想的深刻内涵，体会习近平既高屋建瓴又平易近人的语言魅力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	523
231	国家如何成功——制造业、贸易、产业政策与经济发展	9787302572626	\N	[土耳其]穆拉特· A.尤勒克（Murat A. Yülek）著，孙志燕 译 	平装	1-1	16开	89.00	\N	清华大学出版社	\N	\N	\N	2021-04-01	/book/4eb3cf0f-968e-4bd5-8972-f7799467b2e11071452.jpg	本书从历史长周期的视角对主要发达国家的发展政策进行了全面比较，基于各国的发展实践回答了“制造业如何促进国家经济繁荣”的现实问题。该书还从发展经济学维度论证了产业政策与一国经济增长的关系，在理论层面回答了“产业政策是否必要”的学术争论。在全球经济体系重构的新时代，该书对于深化认识制造业在国家高质量发展和创新能力建设中的战略作用具有重要的参考价值。 本书适合从事发展经济学和发展政策研究的学者，以及从事宏观经济管理和政策制定的读者阅读，也适合制造业、贸易等行业的从业人员和关注经济发展的一般人员阅读参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	944
232	新编阿拉伯语实用会话	978-7-301-16785-4	9787301167854	吴宝国 	0	1-1	16开	55.00	440.0千字	北京大学出版社	296	7301	\N	2021-06-22	/book/0c18cf5a-ca6b-4dd3-9781-b4ed58296c681071456.jpg	《新编阿拉伯语实用会话》适合阿拉伯语高等院校学生、自学者或阿文工作者使用。本书分两大部分，第一部分为"功能意念"表达，第二部分为"情景"会话。本书第一部分涵盖了"问候、致意"、"祝贺"、"致谢"、"遗憾、道歉"、"告辞"、"请求"、"命令"、"鼓励"、"告诫"、"承诺"、"起誓"、"赞赏"、"责备"、"同意不同意"、"满意不满意"等46个方面常用基本功能意念各种表达方式；第二部分设计了140个不同具体场景会话，涵盖了日常生活和涉外工作的方方面面。为了准确理解会话内容，采用汉阿对照；为了举一反三，扩大会话范围，每段会话后列出相关的术语和补充词汇。 本书最大的特色是语言表达准确、得体、口语化；内容新颖、涵盖面广、实用。"意念"和"情景"分开编写，既突出了"意念"的基本功能表达，又省略了每段会话开始的"问候"和结尾时"感谢"、"再见"之类的重复，每段会话直接进入主题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	722
1824	长城国家文化公园建设推动区域经济发展专题论坛论文集	978-7-5761-0197-3	\N	中国长城学会 八达岭特区办事处 编 	软精	1-1	16开	298.00	\N	燕山大学出版社	\N	\N	\N	2022-04-01	/book/6918c56e-ff28-46d1-bea4-0891735979b31086342.jpg	　　本论文集是“长城国家文化公园建设推动区域经济发展专题论坛”的学术成果，内容紧紧围绕长城国家文化公园建设，聚焦长城区域经济社会发展、长城保护利用、长城文旅融合、长城学术研究、农业发展与乡村振兴等领域。以促进长城沿线地区文旅产业及现代农业产业发展为目的，邀请文化传播、文旅体产业、现代农业产业及乡村振兴发展等领域的相关政府部门、业内专家共同参与，为长城沿线地区提供政策指导、理念与路径输出、资源与合作对接。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	676
233	课程与教学论	978-7-301-25408-0	9787301254080	李允 	\N	1-1	16开	42.00	350.0千字	北京大学出版社	268	7301	\N	2021-06-07	/book/d4424cb3-9a98-4a0b-97b1-02296ea1be8b2540802.jpg	"课程与教学论"作为教师教育的一门基础学科，无论是对学生继续深造还是走向基础教育教学工作都具有重要的意义。在即将全面铺开的全国中小学教师资格考试中，"课程与教学论"中的相关知识以及在实践中的运用所占的比例是所涵盖的众多科目之首。 本教材力求根据学科特点整合相关内容，体现理论和实践的新发展、新要求，案例丰富，突出实用性、实效性。 本教材是作者是从事课程论、教学论研究和教学多年的一线教师，是作者多年、多次研究和教学的基础上的总结和提升。适应教师资格证、教师入职考试的规范要求。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	797
245	硬件十万个为什么（无源器件篇）	978-7-301-32181-2	9787301321812	朱晓明 等 	\N	1-1	16开	89.00	443.0千字	北京大学出版社	312	7301	\N	2021-06-07	/book/98873faf-3412-4871-ba3f-6cae4ba591bb32181.jpg	电子元器件是电路设计的基础，而电阻、电容和电感又是电路设计中使用非常普遍的电子元器件。本书从物理层面来阐述这三类元器件的实现原理，帮助读者更好地理解这三类电子元器件的电气特性及其在电路中的应用。 本书分为三篇，每篇对应一类电子元器件，以问答的形式对三类元器件的原理和使用进行详细的解释。每篇还包括元器件的选型规范，帮助读者快速掌握元器件的选型原则。 本书内容深入浅出、浅显易懂，通过丰富的实例来剖析枯燥的原理，适合广大高校学生和电路设计相关工作的工程师。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	869
234	在阴影中绽放——中国日本绘画史上的女性	978-7-301-29387-4	9787301293874	(美)魏玛莎 	0	1-1	16开	99.00	260.0千字	北京大学出版社	316	7301	\N	2021-06-15	/book/35515942-620a-4db2-8172-229987b6a9ba1071473.jpg	本书为海外学界研究东亚艺术史的代表性作品之一，将处在“那些幽深隐蔽、易被遗忘的院落”，却积极投身于艺术的女性，进行逐一再现。全书生动介绍了男性审美下的女性形象、男性规范下的女性生活、男性标准下的女性绘画，为了解中日古代绘画打开了一扇窗口，也为体味中日古代社会生活提供了独特视角。 本书所涉及的文章作者多为活跃于美国学界东亚艺术史研究领域的新一代学者，也不乏高居翰、傅申等大家之作。书稿分为两部分，第一部分介绍中国绘画史上的女性，既有柳隐、陈书这样的女画家，以及祥哥剌吉这样的女收藏家，也有《女孝经图》这样的女性题材绘画。第二部分介绍日本绘画史上的女性，从平安时代直至明治维新时期，如池玉澜、“祇园三女”、张红兰等，从中可以看出女性画家在日本美术史上独特的地位和突出的贡献。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	814
235	心理学的邀请（第五版）	978-7-301-31695-5	9787301316955	（美）卡萝尔·韦德,（美）卡罗尔·塔佛瑞斯 	\N	1-1	16开	239.00	1104.0千字	北京大学出版社	660	7301	\N	2021-05-31	/book/78e12f29-1cbd-4868-926a-78972789f61e31695.jpg	心理学为什么是一门科学？ 如何真正运用批判性思维？ 如何让自己变得更有创造性？ 你会抑郁、焦虑、感到压力大吗？如何缓解？ 为什么你很难减肥？你知道脂肪细胞吗？ …… 心理学是一门贴近我们每个人自身的学科，它的研究内容无所不包，从先天的基因遗传到后天的环境改变，涉及人的所有；它的研究跨度更是无所不容，从胎儿期到老年期，横贯人的一生，可谓与人的毕生发展息息相关。 本书按照个人成长经历的六个方面——自我、身体、心理、环境、心理健康、生活——通过独特的组织方式、引人入胜的生动叙述、给人启迪的鲜活案例，展示了心理科学的方方面面，给读者提供了一个思考人类行为的构架，带领大家积极探索心理学研究领域，深入了解我们的身体与心灵和我们所置身的这个世界。 本书易读、易学、易入，科学性、严谨性、趣味性兼容，尤其注重培养你的批判性和科学思维，这也是本书有别于同类书籍的最大特点。本书适用于寻求心理学入门的人、有兴趣深入探索自身内在工作秘密的人。如果你想认识自己，了解他人，实现自我，就请接受我们的邀请，进入心理学为你开启的这扇大门。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	588
300	无机及分析化学	978-7-301-18396-0	9787301183960	严新,徐茂蓉 	\N	1-1	16开	69.00	575.0千字	北京大学出版社	400	\N	\N	2021-07-07	/book/47806229-9edd-48af-b597-8c1dcadb81461839603.jpg	第1章 绪论，第2章 化学反应的基本原理，第3章 酸碱平衡与酸碱滴定法，第4章 沉淀溶解平衡与沉淀滴定法，第5章 原子结构和元素周期系，第6章 分子结构和晶体结构，第7章配位平衡与配位滴定法，第8章 氧化还原反应与氧化还原滴定法，第9章元素化学，第10章 仪器分析法简介，第11章 一般物质的分析步骤及常用分离方法	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	155
236	美国货币史：1867—1960（精校本）	978-7-301-31761-7	9787301317617	米尔顿·弗里德曼（Milton Friedman）,安娜·J.施瓦茨（Anna J. Schwart 	\N	2-1	16开	138.00	1129.0千字	北京大学出版社	764	7301	\N	2021-06-17	/book/76b1adf5-0c65-4342-8d0c-ca2b757ee82331761.jpg	本书以货币存量为主线，研究了美国1867—1960年近一个世纪的货币发展历程，及其对美国一系列重大历史事件的影响。作者通过对货币供应变化和通胀水平的因果关系的细致描绘，证明了货币政策对于一国经济运行的深远影响，尤其是货币在稳定经济周期中的重要地位。全书将繁杂详尽的历史统计材料与具有敏锐洞察力的经济分析完美地融于一体。书中许多视角独特的分析以及具有开创性的研究结论，例如作者关于1929—1933年大萧条的分析和解释，转变了人们的观念，深化了全球金融界对金融市场的理解。 该书被公认为是弗里德曼的影响最为深远和突出的成就之一，是20世纪具有里程碑意义的经典著作。不仅是经济学者不可或缺的研究参考文献，而且对于各国宏观经济政策的制定，特别是理解全球金融动荡及其政策走向也具有重要借鉴意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	354
1795	中华思想文化术语(中英对照)	9787521321104	\N	《中华思想文化术语》编委会 	平装	1-1	16开	398.00	\N	外语教学与研究出版社	\N	\N	\N	2020-10-01	/book/0007c16a-3de8-4be5-bd0d-3b994437ace91086101.png	　　越来越多的外国学者和友人对中华思想文化及其术语产生浓厚的兴趣，希望有更全面、更进一步的了解。今天我们整理、诠释、译写、传播中华思想文化术语，目的是立足于中华传统的思想文化，通过全面系统的整理与诠释，深度挖掘其中既能反映中华哲学思想、人文精神、思维方式、价值观念、文化特征，又具跨越时空、超越国度之意义，以及富有永恒魅力与当代价值的含义和内容，并将其译成英语等语言，让世界更客观、更全面地认识中国，了解中华民族的过去和现在，了解当代中国人及海外华人的精神世界，从而推动国家间的平等对话及不同文明间的交流借鉴。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	141
237	英语导游听说教程（第四版）	978-7-301-31973-4	9787301319734	朱华 	\N	4-1	16开	58.00	350.0千字	北京大学出版社	200	7301	\N	2021-06-02	/book/53f53415-310c-41ec-b167-11cd45955c1c31973.jpg	《英语导游听说教程》自出版以来，深受广大师生欢迎，现已出版第四版。第四版采用“互联网+”形式，扫描二维码便可轻松获得音频教学资源。教材采用听说一体化设计，通过科学的编写结构，配以针对性的听说练习，把传统单一的听力课、口语课变成听说相结合的新型导游英语课程。第四版注重学历教育与职业教育相结合。教学内容模拟导游服务全过程，将导游专业知识、导游服务规范和专业英语能力提升相结合，在一定程度上突破了我国专业英语教材普遍存在的“语言学习”和“专业学习”相割裂的“二元结构”，较好地解决了英语语言学习与导游专业知识学习二者之间的关系。本次修订，作者对书中语言和习题进行了完善，而且之前是在书后附盘，本次修订改为音频二维码。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	226
238	物权纠纷案例解析	978-7-301-32066-2	9787301320662	北京市律师协会 	\N	1-1	16开	128.00	778.0千字	北京大学出版社	608	7301	\N	2021-05-27	/book/5a31ddef-ffce-415e-83e1-b6a67edcfcf432066.jpg	本选题涵盖《民事案由》中涉及物权法案例的全部类型，收集了自2007年《物权法》实施至迄今所有具有典型代表性的物权法案例。 案例的具体类型包括：不动产登记纠纷、物权保护纠纷、所有权纠纷、用益物权纠纷、担保物权纠纷、占有保护纠纷和拆迁补偿纠纷。 案例的写作结构为：题目、案由、案例导读、基本案情、审理与判决、法律要点解析、律师代理技巧、法官审判观点和结语等。本选题可为办理物权纠纷案件的专业律师带来有益的指导与帮助。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	270
246	国家金融学（第2版）	978-7-301-32190-4	9787301321904	陈云贤 	\N	2-1	16开	89.00	480.0千字	北京大学出版社	408	7301	\N	2021-06-11	/book/01480239-b9fc-4281-95f9-dd62409b8af532190.jpg	本书有别于一般的《金融学》所涉及到相关的一些国家金融事务问题，是从一国金融发展最核心而又迫切需要解决的八大方面问题入手——即在国家金融的顶层布局与监管模式选择之后，纵向涉及国家与地方、横向涉及离岸与在岸的金融发展难题，并面对世界各国的金融崛起，一国金融如何？面对世界人工智能+区块链高科技的突飞猛进，一国金融如何应对？金融的永恒主题是安全、流动和赢利，如何防范和处置一国系统性或区域性金融风险？一国面对国际金融群雄，如何构建并推动国际金融新体系和国际金融新秩序？——它们是国家金融必须面对的课题。全书共分十章，具体内容包括：概论、国家金融顶层布局、国家金融监管协调、国家金融层级发展、国家金融内外联动、国家金融弯道超车、国家金融科技创新、国家金融风险防范、国家金融国际参与、中国金融发展需要解决八大问题等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	496
1760	跟着蛟龙去探海·探海重器	978-7-5670-2754-1	刘峰主编	刘峰 主编 	0	1-1	16开	39.80	\N	中国海洋大学出版社有限公司	\N	\N	\N	2021-12-01	/book/9649e4e5-d2d6-4ac9-a5ac-568e268eb5651085919.jpg	《探海重器》作为“跟着蛟龙去探海”丛书中的一本，从走向深蓝的海洋强国梦、世界各国深潜器的发展历史、中国深潜器、蛟龙探海、深潜器工作母船与支撑保障基地五个部分来讲述深海潜水器的相关内容，让读者来了解我国蛟龙号深潜器	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	490
239	观：先秦话语及其诗性建构	978-7-301-32074-7	9787301320747	冀志强 	\N	1-1	16开	52.00	294.0千字	北京大学出版社	252	7301	\N	2021-05-31	/book/be0dd189-5dde-438f-b1f7-24792348a2b032074.jpg	在对世界整体的把握上，中国古人非常重视“观”这样一种方式。这种方式使得华夏文化在很大程度上具有了一种“诗性”特征。尽管“观”这个概念在先秦时期表现为多种形态，但它都没有停留于单纯的观看，而各自都具有多层意义的结构。这不同的层次，就体现为“观”的建构。并且这种建构本身，在其形上层面经常就是具有诗性的。并且，这个概念成为中国文化中主体的基本认知方式与体验方式。它是一种观看方式，也是一种思维方式，而且更是一种存在方式。 我们可以说，天人关系是中国古代文化中的核心课题。从“观”的角度，则有观天文与观人文两个方面。观天文具有一种特殊的意义，它是古代政治文化的一项重要内容。观人文的核心就是观政、观德，而这种德政主要是通过礼的形式来实现的。由于礼需要体现在一系列的仪式中，所以这种礼也就具有了很浓的审美色彩。 从《周易》开始，“观”即成为中国古典哲学中主体与对象发生关系的基本方式，而“观”所具有的特殊意蕴就使得由此而来的主体行为在某种程度上具有了非认识论的性质。在《周易》中，“观”的对象主要是“象”。在古人看来，“象”可以直接呈现出那种体现为“生生之德”的天地精神。所以，观象也就有了浓厚的诗意色彩。 诸子之前，“观”主要体现为一种政治性、礼仪性的交往行为；而到了诸子那里，则主要体现为一种哲学性、审美性的主体方式。儒家的代表人物都重视观人，即通过对一个人各方面的观察来判断他是否具有德性，所以这种观看也是要成为一种从见者到隐者的本质洞见。 在老庄这里，“观”成为一个具有深刻形上意义的哲学概念。老庄所说的“观”，并不是通常的经验直观，而是一种超验的体证方式。“观”也就是“体”，观道也就是体道。老子的观，是对道的悟解行为，是由观有到观无的一个归其根的过程。庄子则提出了在“以物观之”和“以道观之”这两种观看方式之间的一个转化。完成了这个转化，也就实现了他所说的游心逍遥的境界。这种境界既是哲学的，同时也是美学的和艺术的。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	748
415	纳税筹划项目化教程	978-7-5618-6969-7	9787561869697	王龙 	\N	1-1	16开	49.00	499.0千字	天津大学出版社	320	\N	\N	2021-06-01	/book/f75bff83-95b2-43ba-bfc6-a29561a0f52d9787561869697.jpg	《纳税筹划项目化教程》（第2版）在2017年版的基础上，结合最新税企应用项目任务体例进行编写，突出“理实一体、学做合一”，力求通过仿真案例、开展专业素养为本的情境化教学，突出人才培养的实用性和应用性。内容包括认识纳税筹划及发展前景、增值税的纳税筹划、消费税的纳税筹划、企业所得税的纳税筹划、个人所得税的纳税筹划、其他税种的纳税筹划等，共6个项目（章），涉及100多个有代表性的纳税筹划案例。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	699
240	中国刑事合议庭研究	978-7-301-32113-3	9787301321133	蒋志如 	\N	1-1	16开	68.00	457.0千字	北京大学出版社	372	7301	\N	2021-06-11	/book/fae2de2b-d538-4955-8d80-03d96b78a37232113.jpg	本书运用实证研究方法、法律文本研究方法和历史研究方法过对刑事合议庭基本原理、中国司法实践中的刑事合议庭、中国刑事合议庭的法官及中国刑事合议庭的运行程序进行了系统的研究，多角度地观察和洞悉中国刑事审判组织、刑事合议庭的现状和问题，并对中国刑事合议庭相关制度的修正和完善提出了建议，具有出版价值。同时，书中不仅包含理论，而且加入了作者在法院多年挂职时收集的案例，使本书读起来生动有趣，具有一定的可阅读性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	697
241	中观经济学教与学辅导指南	978-7-301-32129-4	9787301321294	陈云贤 	\N	1-1	16开	30.00	115.0千字	北京大学出版社	96	7301	\N	2021-05-25	/book/a205da7e-20e9-435e-b1fe-8540792375a332129.jpg	本书是《中观经济学》的配套教材，设置了教学目标与要求、教学内容、教学注意事项、教学课时分配表等，通过对各个章节知识要点进行梳理，并配备大量的习题和案例供学习者使用，使学习者能快速掌握本书核心知识以及重难点。 中观经济学是经济理论学科中主流经济学的重要组成部分，是一门基础理论学科。本书旨在通过学习和比较微观经济学、宏观经济学，进而探讨中观经济学的范畴、理论和体系，使学生切实掌握中观经济学的研究主体、研究对象、研究焦点、研究内容，实现对学生学习目标的指引。中观经济学提炼中国改革开放四十多年来的成功实践经验，发掘世界各国现在与未来的经济驱动力和经济新引擎，突破西方主流经济体系和市场经济理论框架的局限，破解国际社会在经济发展和理论探研中遇到的政府与市场关系的共同难题，提供了中国特色社会主义市场经济作为有为政府与有效市场相融合的样板，为全球构建经济治理新体系探索了路径。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	154
242	大国农业——中俄农产品贸易发展研究	978-7-301-32149-2	9787301321492	文峰 	\N	1-1	16开	68.00	156.0千字	北京大学出版社	224	7301	\N	2021-05-24	/book/dfb63009-419a-4b90-a9ba-9daaf8c9b40032149.jpg	在中国施行“农业走出去”战略和“一带一路”倡议的时代背景下，农业“走出去”问题，是新时代赋予国际问题研究领域的重要科学问题。2017年俄罗斯谷物总产量高达1.354亿吨，小麦产量为8590万吨，其中，小麦出口占据全球第一，谷物出口全球第二的位置。中国和俄罗斯作为世界上具有代表性的农业大国，多双边贸易关系更加日趋紧密。 本书围绕中俄之间农产品贸易结构、特征与趋势，以及各自的农产品贸易特征与发展趋势；两国间农产品贸易比较优势，各自的优势农产品出口情况等展开实证研究，并对未来进一步加强合作交流提出了展望。全书共分八章，首先对中俄粮食贸易现状进行详细阐述；其次，对中俄农产品贸易、特征及其竞争力作出展望； 再次，对中国农产品对俄罗斯出口增长的倾向性进行研究；复次，从战略角度阐述如何促进中国农产品对俄罗斯出口的增长；最后，对“一带一路”区域经济合作下如何促进中国农产品出口增长提出了切实可行的建议。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	552
243	诈骗罪的理论与实务：全国青年刑法学者实务论坛（一）	978-7-301-32165-2	9787301321652	车浩 	\N	1-1	16开	59.00	194.0千字	北京大学出版社	224	7301	\N	2021-06-16	/book/225c5b36-edb4-421d-b60b-988d5a18770932165.jpg	本书以诈骗罪为主题，围绕五个典型案例、六篇主题发言和报告及两个实务案例的控辩意见，通过典型案例研讨、主题论文报告和实务案例解剖三个单元的多维探讨，深度剖析了互联网时代诈骗罪的特点、表现、认定、与他罪的区分及裁判争点，展现了互联网时代诈骗罪的多种理论面貌和多处实务细节。 本书收录文章作者均为80后和90后青年刑法学者，几乎集合了国内80后刑法学者中最强劲、最精锐的力量，研究对象则聚焦于刑法实务案例。 本书的出版将对中国刑法的学术创新和传承、中国刑法理论与实务的融合产生积极影响，具有重要的学术价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	136
244	建筑工程经济（第二版）	978-7-301-32175-1	9787301321751	刘晓丽,谷莹莹 	\N	2-1	16开	56.00	486.0千字	北京大学出版社	324	7301	\N	2021-06-21	/book/70d88970-1518-44ac-9b28-b90c8fc1375632175.jpg	本书以培养高质量的工程技术类人才为目标，在编写过程中以“必须、够用”为度，以“实用”为准，关注现代理论与实践的发展趋势，不断进行内容更新，在自编教材的基础上经过多次修改、补充和完善编纂而成。 书中系统地阐述了建筑工程经济的主要内容，包括绪论、工程经济评价要素、现金流量与资金时间价值、工程项目方案的经济评价、工程项目的融资方案、工程项目的可行性研究与财务分析、设备更新分析、不确定性分析与风险分析、工程项目的经济分析、价值工程和工程项目后评价等知识。 本书适用于工程管理专业的教材，也可作为高职、高专以及成人教育的教学用书，还可作为广大工程技术人员的自学用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	577
1784	巴基斯坦商务环境	9787566314796	\N	闫丽君　主编 	平装	1-1	16开	29.00	\N	对外经济贸易大学出版社	\N	\N	\N	2015-10-01	/book/f0514133-accd-401d-a71f-1918055f6c401086065.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	996
247	信仰的力量——北大老同志庆祝中国共产党成立100周年回忆文集	978-7-301-32248-2	9787301322482	邱水平 	\N	1-1	16开	96.00	291.0千字	北京大学出版社	408	7301	\N	2021-06-24	/book/adb3a895-545b-42f8-b9e7-2da511353af232248.jpg	2021年是中国共产党成立100周年，北京大学作为中国最早研究和传播马克思主义的阵地、创建中国共产党的重要基地，有着悠久的革命历史和光荣的红色基因。特别是北大老同志在党的领导下，攻坚克难、无私奉献，创造了彪炳史册的功勋，是我们的宝贵财富。为庆祝建党100周年，北京大学邀请30余位老同志作为历史的见证者和参与者撰写回忆文章，抒发爱国爱党情怀，唱响共产党好、社会主义好的时代主旋律，展示了老一辈北大人与党同心同向同行、与祖国和人民共奋进的历程，为中国共产党百年华诞献礼，为党史学习教育提供生动的学习读本。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	550
294	漫画中国文化关键词	9787521326246	\N	铲史官绘著 	平装	1-1	16开	58.00	\N	外语教学与研究出版社	\N	\N	\N	2021-08-01	/book/8fb716ae-ad57-4979-aaf4-a812a18df21c1072918.png	《漫画中国文化关键词》从“中华思想文化术语”系列图书中精选了一些有代表性的术语，以这些术语为核心，介绍相关领域历史文化知识，以漫画版的形式，深入浅出地介绍中华优秀思想文化。本书包含“四书五经”“科举选才”“年与纪年”“载舟覆舟”“建安风骨”“书法艺术”等12篇内容，每篇以有内在逻辑关联的若干个术语为线索，串联出相应的背景知识和思想观念介绍给读者。本书将知识性、思想性和趣味性相结合，向读者介绍中华优秀思想文化。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	410
1853	传统文化阅读与鉴赏	9787567590120	\N	陈引驰，陶磊 	平装	1-1	16开	39.00	\N	华东师范大学出版社	\N	\N	\N	2019-08-01	/book/b72d13dd-b32a-4248-aff3-488ba516ee4e1086563.png	《传统文化阅读与鉴赏》教材使用对象对高职院校的学生。教材编写以中国传统文化中的名篇为范例，引导高职学生进行阅读与鉴赏，使学生能够汲取优秀传统文化营养，升华思想道德情操，培养语文阅读理解的能力，提升各方面的语文素养和审美能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	676
269	体育与健康（八年级）	9787562261483	\N	王健主编 	平装	1-1	大32开	8.75	\N	华中师范大学出版社	\N	\N	\N	2021-07-01	/book/f4cb5163-cbf0-4c2e-b0f8-30d32cf49c1a1071848.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	813
248	丝绸之路千问千答	9787560447605	\N	高建群 	平装	1-1	16开	168.00	\N	西北大学出版社	\N	\N	\N	2021-06-01	/book/63162674-2850-40f0-a9f5-a4ca7ad9bb501071556.jpg	《丝绸之路千问千答》是著名作家高建群以四十年创作经验，调动多年生活积累和知识储备，撰著的一部丝绸之路“百科全书”。以丝绸之路为线索，叙述了从距今7000万年至300万年的新生代造山运动至于当今，亚欧大陆上的高原山脉、河川湖沼以及各个民族、各种文明初生、演进、蝶变的历史过程；廓清了从东方到西方的广袤地域上，先后存在的二百多个部落民族以蹄、犁、刀、币为方式，繁衍生存、冲突交流、融合发展的历史事实。在东西文化的时空比较中，梳理丝绸之路沿线草原游牧文明、农业城市文明乃至海洋文明的演进脉络和相互关系，阐述欧亚大陆上各种民族成分、各个文明板块对于形成当今世界格局乃至当今人类文明形态的重要意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	606
482	华东师大档案馆藏名人手札	9787567556683	\N	汤涛，朱小怡 著 	平装	1-1	16开	108.00	\N	华东师范大学出版社	\N	\N	\N	2017-04-01	/book/05da8a49-f2e9-4b98-b858-e4571f9d552a1074509.png	《华东师大档案馆藏名人手札》系发掘利用华东师范大学档案馆馆藏名人信札，配以释文和信札作者人物简介，图文并茂地展示华东师范大学档案馆馆藏书法珍品，进而展示华东师范大学的艺术文化。所选名人信札来自于学校档案馆所藏因公务活动产生的档案。依照信札作者身份可分为政界名人信札、教育界名人信札、文化界名人信札、财经界名人信札。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	531
249	“红星”——世界是如何知道毛泽东的？	9787301319024	\N	[日]石川祯浩 著，袁广泉 译 	精装	1-1	32开	64.00	213.0千字	北京大学出版社	292	\N	\N	2021-06-01	/book/5084535b-6fbf-4dc0-a64d-df7e351e0bba1071557.jpg	本书前半部分从1937年日本政府公报登载的一幅错误的“毛泽东”照片入手，追寻外界逐渐认识中国革命领袖的历史过程，以及其间所发生的误解、巧合与蓄意隐瞒。后半部分则致力于复原《红星照耀中国》的诞生过程与版本流变，详细梳理了它在中国、苏联、日本等地的历史命运，澄清了后世对于这一名著的诸多误解与不实指控。 作者掌握了极为丰富的史料，以生动有趣的笔触，带领读者一步步拨开迷雾，触摸历史的真实，探索《红星照耀中国》之前的毛泽东形象，解读红色经典的历史命运。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	188
250	吴门匠造：苏州建筑文化探古	9787567233638	\N	华以丹 	平装	1-1	16开	68.00	\N	苏州大学出版社	\N	\N	\N	2021-06-01	/book/206c9ddc-bce7-443c-bdf0-d6e33d7203361071558.jpg	本书分8章介绍了苏州建筑文化的各个方面，并配有100多张插图。具体如下： 第一章 历史见证：苏州城的前世今生。分述：千年古城（建城年代）、屡毁屡建（兴衰史）、坊市变迁(时空区位)、美丽转身（城市形态的流变与传承）。 第二章 营造理念：天地人合一的自然崇尚。分述：因地制宜选取城址、因循法则规制城池、因势利导理水筑城。 第三章 大匠营城：古城的形制格局。分述：阖闾大城、平江府城、老街幽巷。 第四章 风貌神韵：水是苏州的魂与脉。分述：水陆城门、人家尽枕河的诗意栖居环境、桥的工艺与水景致。 第五章 古镇古村：古城派生之璀璨群星。分述：古镇古村的空间意象、原生态原真性、乡村古建中的文化印记。 第六章 传统建筑：建筑艺术殿堂中的瑰宝。分述：民居宅第、衙署官邸、会馆公所、庙宇寺观、府学书院、官钱银局、中西合璧杰作。 第七章 就地取材：天地造化之物。分述：砖造瓦作、御窑金砖、金山石。 第八章 苏派筑造：建筑艺术园圃中的奇葩。香山帮、传统技法、叠山理水技能、古建元素特色。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	657
251	维新旧梦录——戊戌前百年中国的“自改革”运动	9787308145473	\N	朱维铮 龙应台 	平装	1-1	32开	38.60	\N	浙江大学出版社	\N	\N	\N	2021-03-01	/book/581521b2-8930-4253-a0b1-2add653e59331071561.jpg	　　《维新旧梦录：戊戌前百年中国的“自改革”运动》是十九世纪中国的时论选集，旨在通过不同时间、不同人物从不同视角吁求清帝国实行“自改革”的代表性论著，展现晚清“变法维新”形成思潮和运动的迂回曲折的历程。 　　该书所收论著，始于十九世纪初，止于戊戌“百日维新”前；编次大致以写作或发表的时间为序，并大致以思潮在某个历史段落的共同取向，略分为三个部分。 　　该书所收论著，以原作为准，并力求依据经前人校订的较合原貌的版本；凡版本有争议的，均略加说明。所收全部论著，均经该书编者重予校勘，重施通行标点并分段。 　　该书所收论著，篇前均附简介，包括篇目介绍和作者简历两部分。 　　该书设想为非专业读者，提供一部简明扼要而又让历史人物自己说话的普及性读物。为说明编者意向，以及为使读者了解与该书主题有关的一般历史过程，该书前附龙应台序和朱维铮所撰导读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	423
252	复合材料手册第1卷：聚合物基复合材料结构材料表征指南	9787313114938	\N	[美]CMH-17协调委员会著，汪海等译 	平装	1-1	大32开	248.00	\N	上海交通大学出版社	\N	\N	\N	2014-12-01	/book/b4c0d3b9-e474-457d-ba76-887c70a73a891071567.png	由CMH-17协调委员会编著的《复合材料手册(1聚 合物基复合材料结构材料表征指南)(精)》是《复合 材料手册》(以下简称CMH一17)的**卷，主要包括用 于确定聚合物基复合材料体系及其组分，以及一般结 构元件性能的指南，即试验计划、试验矩阵、取样、 浸润处理、选驭试验方法、数据报告、数据处理、统 计分析以及其他相关的专题，并对数据的统计处理和 分析给予了特别的关注，还包括了产生材料表征数据 的一般指南，以及将相关材料数据在CMH一17中发布 的特殊要求。 本书可供材料领域及其相关行业的工程技术人员 、研发人员、管理人员，以及高等院校相关专业师生 参考使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	216
253	复合材料手册第4卷：金属基复合材料	9787313173638	\N	[美]CMH-17协调委员会著，乔菁、杨文澍、武高辉译 	平装	1-1	大32开	248.00	\N	上海交通大学出版社	\N	\N	\N	2017-08-01	/book/74284f12-5973-4bd4-a42c-f3c5511930641071571.png	　《复合材料手册4（金属基复合材料）》是《复合材料手册》（简称CMH-17）的第4卷，主要介绍了金属基复合材料体系、组分及其制备工艺，给出了金属基复合材料性能测试方法、数据处理、数据报告、统计分析，特别是设计方法等相关指南。书中还包含了以统计为基础的金属基复合材料性能数据，它们满足CMH-17特定母体取样要求和数据文件要求，并涵盖了普遍感兴趣的材料体系。 　　《复合材料手册4（金属基复合材料）》可供材料领域及其相关行业的工程技术人员、研发人员、管理人员，以及高等院校相关专业师生参考使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	603
255	高质量发展的雄安之道：雄安新区容西片区规划设计	978-7-5618-6935-2	9787561869352	河北雄安新区 河北雄安新区规划研究中心，天津市城市规划设计研究总院有限公司 	0	1-1	16开	256.00	331.0千字	天津大学出版社	276	\N	\N	2021-05-01	/book/f2e8eb6b-0199-4f8a-841e-04f54c281e9b1071584.jpg	本书全面记录了本次规划建设的历程与特色，叙述了容西片区规划设计的工作过程、设计成果与后续容西建设实施的技术支撑工作，展示了规划编制团队及国内外设计师们在容西这片土地上所迸发的热情与城市理想，展现了责任规划师单位的艰辛与努力，也汇集了规划组织方、编委、编写人员和规划管理集体的智慧，体现了雄安新区的高标准规划和高起点建设的要求，希望能为过去的容西、现在的容西、未来的容西留下记忆，也为同行们和政府相关管理部门提供一些案例。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	951
256	适情德育思考与实践——温职专专业德育读本	978-7-5618-6818-8	9787561868188	黄威 	\N	1-1	16开	50.00	312.0千字	天津大学出版社	192	\N	\N	2021-05-01	/book/a09ac816-7177-4a7e-b3e9-7eb38baa083b9787561868188.jpg	本书内容：分为三大部分，第一部分：第一篇-----走进职专，心萌希望；第二部分：第二篇------适情德育，助力成长；第三部分：第三篇------走进专业，走进德育。分为五个学部，五大专业群编写。计算机专业（信息学部）、经贸专业（经贸学部）、数控专业+电子专业（机电学部）、学前专业（幼师学部）、汽修专业（交通学部）。 本书是我校对于中职德育工作创新改革的尝试与探索，也是多年来我校“适情德育”成果的一次展示，我们的思考是深邃的，探索是务实的，经验是可借鉴的，期待本书能成为中职学校德育干部、班主任、普通老师开展职业道德教育的参考读本。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	773
259	设计与建造项目式课程建设实录	978-7-5618-6954-3	9787561869543	张冠伟 	\N	1-1	16开	48.00	412.0千字	天津大学出版社	264	\N	\N	2021-06-01	/book/1862d7a7-b4b0-4773-92cf-a824c318d2c59787561869543.jpg	本书是本科生新工科项目式课程“设计与建造”课程建设中的课程文档汇总。“设计与建造”课程是面向一年级学生开设的一门有关产品设计与开发的项目式课程，其主要目标是通过学习产品设计与开发过程，实施基于项目的学习，使学生掌握产品和技术研发过程，了解工程师工作特点，培养学生运用现代设计技术与方法解决产品和系统设计的问题。通过改变课程内容与组织形式，改变教学形式，改变考核结构，实施新工科项目式课程教学。授课内容包括产品设计流程、产品设计表达与软件工具使用、制造与控制技术、项目管理技术和工程伦理等。学生通过完成智能派送小车项目，获得项目实践经验和团队工作的经历，对产品和技术开发有了更深刻理解，学习运用结构化方法解决非结构化工程实际问题，培养了团队合作、沟通交流和项目管理的基本能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	731
260	以石入画——天津市蓟州区西井峪村的自然、文化、聚落与更新	978-7-5618-6830-0	9787561868300	郝卫国，于坤 	\N	1-1	16开	99.00	374.0千字	天津大学出版社	208	\N	\N	2021-06-08	/book/1b899bb0-967c-4b97-931c-597a1539e0cd9787561868300.jpg	西井峪村位于天津蓟州区渔阳镇中上元古界国家地质公园内，清代成村，群山环抱、绿树敝舍。特殊的地质条件造就了村庄特色的民居与环境风貌。西井峪村以石头作为文化要素，产生了“因石而生、因石而居、因石而乐”的独特民居文化，因石头民居、石头巷、石头游戏等，又被称为“石头村”。2010年被评为第五批“中国历史文化名村”。2015年村庄引进设计团队为西井峪村进行保护性开发。经过几年乡村发展，已成为京津冀地区小有名气的乡村旅游地。书籍从村落的建筑风貌、景观特点、历史沿革、村庄文化、传统技艺和民风民俗等方面，挖掘和总结村庄的记忆元素，找到记忆与现代发展相融合的途径，并梳理和分析近年西井峪传统村落的保护与开发策略，针对乡村景观民俗文化面临的问题提出社会层面具体实践的方法和针对性策略。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	557
261	机制主义人工智能理论	9787563562510	\N	钟义信 	平装	1-1	大32开	68.00	\N	北京邮电大学出版社	\N	\N	\N	2020-12-01	/book/12e41c3d-db7d-4e0e-a317-fa3e582377371071605.png	迄今，国内外人工智能的研究被分割为物理符号系统/专家系统、人工神经网络和感知动作系统/智能机器人三个方向，没有形成人工智能的统一理论，表明人工智能的研究还没有成熟。追根寻源发现，当今人工智能研究的科学观、方法论和系统模型均存在认识上的很大误区。 有鉴于此，本书以全新的科学观、方法论、系统模型、理论体系重构了人工智能的基本原理。为了与现有的人工智能出版物相区别，遂命名为《机制主义人工智能原理》。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	559
262	体育服务运营管理（第三版）	9787563832286	\N	肖淑红 	0	1-1	16开	46.00	389.0千字	首都经济贸易大学出版社	300	\N	\N	2021-06-01	/book/9b08174d-6eed-421d-8a91-270c386b10481071612.jpg	本教材在内容上反映了运营管理学的知识体系和发展趋势，并吸收了最新的成果。第一部分是体育服务运营管理基础。第二部分是体育服务传递系统的设计。第三部分是体育服务运营的管理。第三版修订补充了体育服务运营管理领域前沿鲜活的小资料，更新了相关案例，便于师生紧跟时代发展，增强分析问题，解决问题，活学活用的能力，更好地学习知识，掌握技能。我国体育产业已进入新的理性思考的阶段，以顾客为导向是成功制定、实施、持续改进计划的基础，满足顾客需求成为运营管理的焦点问题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	531
263	低压电工特种作业教程	9787560660738	\N	杨立平 	0	1-1	16开	42.00	414.0千字	西安电子科技大学出版社	280	5606	10	2021-07-07	/book/5459fed4-7aec-4ed9-937b-7230e7c201651071621.jpg	低压电工特种作业课程是针对低压电工特种作业(含理论上机考试和实训操作)的需求开设的一门重要的技术基础课。本书作为该门课程的配套教材，涵盖电工基础理论知识和电工技术实训操作两大模块，共12章，具体包括电工安全法律法规、电工电子基础、电工安全基础知识、电工工具与电工仪表、电工安全用具与安全标识、照明电路、电动机基础、低压电器、电气线路、电动机基本控制电路、作业现场安全隐患排除、作业现场应急处置。 本书可作为高职、中职院校电气技术应用、电气运行与控制、供用电技术等相关专业的教材，也可作为低压电工特种作业操作的培训用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	113
264	电子系统设计与工程应用	9787560660516	\N	田孝华 刘小虎 胡亚维 著 	0	1-1	16开	36.00	314.0千字	西安电子科技大学出版社	232	5606	10	2021-07-07	/book/571cba7b-86dd-43e3-bd1a-093a7ee4da9f1071622.jpg	本书全面论述了电子系统的设计与应用技术。全书共7章。第1章介绍了电子系统及其功能组成、电子系统设计方法与开发流程、电子系统设计应考虑的主要因素、常用EDA软件以及电子系统设计的资料查找方法；第2章论述了电子系统的基本结构和主要性能指标、发射机和接收机组成与性能指标，并介绍了分贝的概念及其应用；第3章论述了信息传感与转换技术及其工程应用，包括信息传感技术、数/模与模/数转换技术以及信源编译码技术；第4章论述了信道编译码、块交织、扰码、RAKE接收等数字基带信号处理技术，并通过实例讨论了数字信号处理技术的应用；第5章论述了调制解调与中频单元的设计及其工程应用，包括调制与解调、混频与滤波、中频放大以及同步技术；第6章论述了射频通道与天线的设计，包括电波传播与天线、馈线、信号隔离与射频滤波、射频放大、频率合成技术、电磁兼容技术；第7章论述了嵌入式技术在人机交互与控制、设备自检与监测和Internet互联设备中的应用，以及供电系统设计和常用总线与接口技术。 本书聚焦电子工程应用，内容系统全面，论述简明清晰，每章均有设计实例，实用性强，既可作为应用型本科高年级学生和研究生的教材与参考用书，也可供从事电子系统设计与开发工作的工程技术人员、科研工作者以及大专院校教师参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	903
301	英汉翻译教程新说	978-7-301-22133-4	9787301221334	武峰 	\N	1-1	16开	45.00	329.0千字	北京大学出版社	224	\N	\N	2021-08-02	/book/861c44d5-10b1-4df3-b2b9-3291289ec3fe2213302.jpg	本书以庄绎传《英汉翻译教程》为基本分析材料，以《十二天突破英汉翻译》中所涉及的技巧和方法为基础，采取了句型分析和词汇分析的基本策略，将《英汉翻译教程》的所有文章进行逐一分析，以具体的译例作为对笔译的理解，让翻译的理论与实践进行有效的结合。本书适用于英语专业高年级学生、英语专业自学及英语专业研究生（包括MTI课程）使用，亦可作为本科英汉翻译课程的教材使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	727
265	钢琴即兴伴奏的理论与实践	9787567232068	\N	倪高峰 著 	平装	1-1	大32开	68.00	\N	苏州大学出版社	\N	\N	\N	2020-07-01	/book/8a195a74-98b0-4f96-a9fb-ad0329becc381071628.png	　《钢琴即兴伴奏的理论与实践》既有即兴伴奏的相关理论深度，又结合苏教版、人教版、人音版中小学教材中的歌曲编配案例，理论与实践并重。作者以和声学为基础，强化柱式和弦、半分解和弦、全分解和弦的织体形式，将即兴伴奏中的两大核心问题进行了清晰阐述，并结合当下师范生考编需求，结合三大出版社中的经典歌曲作编配教学，有效地将“授人以渔”和“授人以鱼”相结合。另外，作者对当下年轻人喜爱的流行歌曲的编配理论与技术也有相当的涉猎。总之，这是一本兼具学术性和通俗性的专著。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	452
266	陈田鹤音乐作品全集·器乐卷	9787567233096	\N	蒲方 编 	平装	1-1	大32开	160.00	\N	苏州大学出版社	\N	\N	\N	2020-10-01	/book/45098b76-88da-404b-8b52-fa004cfd8c6f1071632.png	《陈田鹤音乐作品全集·器乐卷》包括室内乐（钢琴及重奏作品）、管弦乐和民族管弦乐三部分，其中有较多他1949年以后创作及编配的管弦乐（含民族管弦乐）作品。这部分内容非常丰富，如管弦乐曲《芦笙舞曲》（1952年）和根据福建民歌编配的《采茶扑蝶》（1953年）；还有1953年创作的民族管弦乐曲《花鼓灯》，以及1955年根据古琴曲《广陵散》片段编配的民族管弦乐作品。这些作品与1949年以前创作的一些室内乐、管弦乐作品，给广大读者展现了陈田鹤先生在器乐创作方面的独特才能。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	653
267	中华大典·农业典·农书分典	9787564931254	\N	宁智峰 郑鹏 主编 	平装	1-1	大32开	740.00	\N	河南大学出版社	\N	\N	\N	2017-12-01	/book/f21cacb1-b56a-4660-9971-9ccb0a79d3d11071640.png	《農書分典》是《中華大典·農業典》的分典之一。中國是歷史悠久的農業大國，歷代遺留下來的農業古籍十分豐富，它們是中國傳統農業精髓的主要載體，也是我國文化遺産的重要組成部分，史料價值極高。相比其他分典，《農書分典》在《農業典》中所占字數雖然不多，却是《中華大典•農業典》的重要組成部分，意在全面介紹我國傳統農業典籍的形態、源流、傳承與分布，也兼及晚晴時期翻譯的一些國外農業資料。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	961
268	云上光辉	9787559830906	\N	陈新 	平装	1-1	大32开	59.80	\N	广西师范大学出版社	\N	\N	\N	2020-09-01	/book/c092a49f-6296-463e-ab7a-ed432fde26d61071844.png	“山陵既固，中夏小康。”小康美好，实现很难。要实现小康，必须消除贫困。而西藏的脱贫攻坚，难度更甚。西藏，地球上海拔最gao的地方，离天最近的地方。这片云上圣地，矗立着世界第一高峰，怀抱着世界最da的高原湖群。这片独一无二的土地，却布满了寒难。“广”“大”“高”“深”是西藏的贫困特点，即贫困人群所居地域广阔、贫困人口基数大、贫困人群所处环境海拔高、整体处于深度贫困状态。 自脱贫攻坚战打响以来，西藏自治区先后有17万人次的扶贫干部深入一线驻村，他们用青春与热血投身新时代的脱贫攻坚战。他们的身影贴近百姓的心灵，风刀霜剑无情割裂粗糙的容貌里，是高寒缺氧摧毁不垮的铮铮铁骨。他们与百姓同吃同住同生产，同思同想同悲喜，扶贫扶心扶志更扶智。经过不懈努力，西藏自治区的扶贫成果，得到了国务院扶贫办的充分肯定，连续四年在省级党委政府扶贫开发成效考核中，被中央确定为“综合评价好”的省市之一。到2019年12月，西藏74个县（区）全部实现脱贫摘帽。他们，为祖国的繁荣富强做出了巨大的贡献。 这里，有你所不了解的中国硬核精神。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	561
270	历史如何选择了中国共产党	9787567630543	\N	张旭东 	平装	1-1	大16开	38.50	\N	安徽师范大学出版社	\N	\N	\N	2017-09-01	/book/3677b712-a608-4dd6-beae-84d170430ca71071849.png	　　《历史如何选择了中国共产党》以独特的视角、新锐的观点、清新的思想，力图挖掘中国共产党自我革新、不断完善的基因，探寻中国共产党的成功之道。全书共分十五章节，全景式展现中国共产党从创立到夺取国家政权，从革命到现代化建设，从改革开放到加强自身建设等一系列历史活动中发展壮大的内在历史逻辑，从学理角度论证中国共产党革命和执政的合法性，准确生动地展现了中国共产党90余年的奋斗历程、光辉业绩和取得的伟大成就。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	774
271	文化观念生长时期的英国文学典籍研究	9787544665940	\N	曹山柯等著 	平装	1-1	大16开	118.00	\N	上海外语教育出版社	\N	\N	\N	2021-06-01	/book/4a03b5b1-ac36-422e-b931-1f7b26fd8d5d1071856.png	本丛书系统梳理了从中世纪到当代英国文化观念变化背景下的英国文学典籍，共分六卷，分别为《总论卷》《文化观念萌芽时期的英国文学典籍研究》《文化观念生长时期的英国文学典籍研究》《文化观念成熟时期的英国文学典籍研究》《文化观拓展熟时期的英国文学典籍研究》《文化观念裂变时期的英国文学典籍研究》。本稿为第1卷《总论卷》，着眼于整个历史时期变化文化观念和英国文学典籍之间互动关系的综述。本卷还负有一个前后勾连的使命，即引导本丛书其他各卷论证以下核心观点：就最主要的文化命题而言，伟大的英国文学家们在不同时期给出了相同的答案，即生活质量不在于发达的工业、诱人的科技经济指标，而在于共同体的和谐，在于精神与物质的互补和平衡。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	177
272	文化观念裂变时期的英国文学典籍研究	9787544665599	\N	欧荣等著 	平装	1-1	大16开	148.00	\N	上海外语教育出版社	\N	\N	\N	2021-06-01	/book/05e8642a-88e7-498c-81f9-2f09b4e2ec7c1071859.png	本丛书系统梳理了从中世纪到当代英国文化观念变化背景下的英国文学典籍，共分六卷，分别为《总论卷》《文化观念萌芽时期的英国文学典籍研究》《文化观念生长时期的英国文学典籍研究》《文化观念成熟时期的英国文学典籍研究》《文化观拓展熟时期的英国文学典籍研究》《文化观念裂变时期的英国文学典籍研究》。本稿为第1卷《总论卷》，着眼于整个历史时期变化文化观念和英国文学典籍之间互动关系的综述。本卷还负有一个前后勾连的使命，即引导本丛书其他各卷论证以下核心观点：就最主要的文化命题而言，伟大的英国文学家们在不同时期给出了相同的答案，即生活质量不在于发达的工业、诱人的科技经济指标，而在于共同体的和谐，在于精神与物质的互补和平衡。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	410
273	外语教育探索与研究（第三辑）	978-7-307-22369-1	\N	牛忠光、刘晓燕 主编 	平装	1-1	16开	59.00	\N	武汉大学出版社	\N	\N	\N	2021-06-01	/book/044a3924-0640-47f4-810a-a8a3fbf73d6f1071862.jpg	本书是江汉大学外国语学院师生的论文集，是他们教学和科研的成果和结晶。全书分为外语教学研究、文学与语言学研究、翻译与文化研究、国别区域研究、基础英语教育研究五部分。外语教学研究主要探讨新技术和新教学模态下的外语课程教学，文学与语言学研究既有对外国传统经典文学作品的解读，又有对不同语言观之下的不同语言研究范式的研究，翻译与文化研究涉及翻译与中国近现代学术话语体系的建构等，国别区域研究涉及历史、服饰、中西教育等，基础英语教育研究展现江汉大学外国语学院学科教学方向在读研究生对各阶段英语教学的思索。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	505
274	实施健康湖北战略智库建设	978-7-307-21876-5	\N	胡慧远 编著 	平装	1-1	16开	60.00	\N	武汉大学出版社	\N	\N	\N	2020-10-01	/book/dbf69c9d-cfb8-4561-b29b-70906edba1c11071869.jpg	本书从健康湖北战略的理论和现实依据，把握健康湖北战略的历史意义，通过梳理健康湖北战略的实施现状，深刻认识健康湖北指导思想及相关政策，来思考健康湖北实施中的问题，进而把握健康湖北战略实施中的重大关系，特别人民健康与公共卫生的关系，城市健康与农村健康的关系，疾病治疗与预防关系，充分发挥中医药在实施健康湖北战略中的重要作用，建设健康中国，必须尊循中医药发展规律，传承精华，守正创新，加快推进中医药发展。本书内容充分体现我国对人民健康高度负责的政治担当和维护人民健康的坚定决心，具有现实意义和历史意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	439
275	时尚服饰营销	9787566918932	\N	裘晓雯 	平装	1-1	16开	59.80	\N	东华大学出版社	\N	\N	\N	2021-06-01	/book/248a4e8d-2f3b-4502-be31-d15bbd68d5231071871.jpg	本书贯彻《关于全面提高高等职业教育教学质量的若干意见》（教高[2006]16号）等重要文件精神，按照“工学结合”人才培养模式的要求，采用“基于工作过程导向——工作过程系统化课程”设计方法，以时尚服饰营销工作过程为导向，以工作任务为载体，进行工作过程系统化课程设计。 本书按照时尚服饰市场营销的工作任务及工作过程，分为8个工作任务，包括时尚服饰市场营销的认识、时尚服饰产业及其营销环境的认识与分析、时尚服饰消费心理与行为认识与分析、目标市场的分析与识别、时尚服饰产品策略的分析与制订、价格策略的分析与制订、分销渠道的设计与管理、促销策略的分析与制订。 特色：1、与浙江省经济发展尤其是与时尚产业发展相结合，符合纺织服装学院的定位和优势，具有浙江特色和本校特点。 2、本教材全程由本院深度融合的校企合作企业雅戈尔集团的专家把脉，充分参考时尚领域市场实战专家的建议，从而保证教材知识与技能的新颖性和实战性，使学习与职业能力、岗位要求密切融合，真正体现“校企合作、工学结合”。 3、线上线下相结合，成果展示引导，配套资源丰富，在线资源一体化设计 本教材覆盖时尚服饰营销的核心内容，具有8个任务，25个学习型任务，67个实操型任务，丰富的前沿案例，配套的数字资源情况（包括视频、PPT课件、习题库、案例、教学网站等）：二维码链接更多拓展资源。该教材由《营销基础》浙江省精品在线开放课程，《服装市场营销》校级精品课程、《营销基础》校级慕课、宁波市特色专业等教育教学改革项目等支撑。 本书适合高职高专院校市场营销及经济管理类相关专业的教材，同时对服装企业在职人员具有一定的实践指导作用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	419
1796	智能教育的风险	978-7-5191-2665-0	\N	袁振国 主编 刘世清 等 	0	1-1	16开	62.00	\N	教育科学出版社	\N	\N	\N	2022-03-01	/book/5fb3493c-1d0f-4a59-ac91-30c8860610bc1086112.jpg	本书将从历史角度梳理技术引发的教育变革，探讨人工智能技术对教育领域的革命性影响，着力分析智能教育的风险，拟聚焦人工智能应用于教育领域可能引发的隐私风险、公平风险、歧视风险、伦理风险、情感风险、法律风险、安全风险、价值风险、健康风险和社交风险等，并在此基础上，加强前瞻预防与约束引导，提出可能的预防举措，确保智能教育的安全、可靠发展。 本书读者对象主要包括公务员，各行各业白领，媒体人员等。立足于读者立场，书中在探讨各种风险时充分利用国内外案例，由问题导入，引发教育思考，激发共鸣。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	757
276	雷蒙德·卡佛访谈录	978-7-305-24463-6	\N	(美) 马歇尔·布鲁斯·金特里 (美) 威廉·L. 斯塔尔 编 小二 译 	平装	1-1	32开	68.00	\N	南京大学出版社	468	\N	\N	2021-07-01	/book/d329c538-86da-47cf-bb17-845090d395501071873.jpg	当卡佛谈论自己时卡佛在谈论什么？雷蒙德·卡佛，《当我们谈论爱情时我们在谈论什么》的作者，“美国的契诃夫”，坐拥无数粉丝的短篇小说大师。《雷蒙德·卡佛访谈录》是首度译成中文的卡佛访谈合集，精选他去世前十多年间接受的二十三篇重要采访，清晰完整地刻画了这位作家的创作理念与创作发展脉络，真实地记录了他的“两次生命”，为深入了解与研究卡佛其人其事提供了珍贵的一手资料。在这些访谈中，传奇卡佛抖落了一身标签（特别是“极简主义”），变回说话声音轻柔的大块头男人，真诚地讲述接地气的故事：钓鱼打猎、早婚早育、打工挣钱、酗酒戒酒、写作教书、投稿退稿……他对自己热爱的契诃夫、陀思妥耶夫斯基、海明威、福楼拜等人不吝赞美，对部分后现代主义者、解构主义者则毫不留情。卡佛坦率、不做作的风格让陌生人放松，把正式访谈变成一种亲切的交流。短暂却充盈的生命在他的话语中闪光。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	264
277	边缘海深水油气地质理论	9787563668076	\N	张功成 等 著 	精装	1-1	16开	475.00	\N	中国石油大学出版社	\N	\N	\N	2020-12-01	/book/35da188a-40e2-427a-b638-ba13d7a787151071880.jpg	《边缘海深水油气地质理论》主要介绍了作者经多年理论与实践研究所创新性提出的南海边缘海构造旋回演化新模式，以及所创建的边缘海构造旋回控制南海深水区油气成藏理论，系统性地揭示了我国南海深水区的盆地形成、成烃、成藏特征及深水区油气勘探潜力，发展了基于被动大陆边缘深水区的经典的油气成藏理论。 　　《边缘海深水油气地质理论》共分五篇十七章，其中篇共三章，为边缘海构造旋回-南海形成新模式；第二篇共两章，为边缘海构造旋回控制南海深水区成盆；第三篇共三章，为边缘海构造旋回控制南海深水区成烃；第四篇共三章，为边缘海构造旋回控制南海深水区成藏；第五篇共六章，为边缘海构造旋回控制南海深水区油气资源。全书内容翔实、图文并茂，可供油气地质研究者、勘探工作者和勘探决策者等参考，同时也可供有关科研院校师生参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	332
332	现代仪器分析实验	978-7-5689-1906-7	\N	张晓凤 柏俊杰 曹坤 杨波 	\N	1-1	16开	36.00	291.0千字	重庆大学出版社	170	\N	\N	2020-10-26	/book/b9c52333-5c82-4137-9524-9d0e4224943b91906.jpg	本书共分为十二章。 主要内容包括:绪论、原子发射光谱法、原子吸收光谱法、紫外-可见分光光度法、红外光谱法、分子荧光光谱法、电化学分析法、气相色谱法、液相色谱法、气相色谱-质谱分析法、毛细管电泳色谱法、X 射线衍射(XRD),共 35 个实验。各章节简要介绍了该仪器分析方法的基本原理和仪器结构,并依次介绍了实验原理和实验步骤,内容简明扼要、通俗易懂,重难点突出。 本书可作为高等学校化学、化工、药学、环境及相关专业学生的教学用书,也可作为教师的教学参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	404
278	健身气功.易筋经	9787500960119	9787500960119	国家体育总局健身气功管理中心 	0	1-1	16开	43.00	188.0千字	人民体育出版社	228	\N	7	2021-07-01	/book/d8a8b8b1-366d-400a-aa18-9f6396b50f321071969.jpeg	从2003年始，健身气功中心陆续推出了健身气功?易筋经、五禽戏、六字诀等系列功法丛书，限于种种原因，仅对编创推广的各种功法进行了简要介绍，未能就功法功理等深层次问题进行系统阐述。为了满足广大健身气功习练者的迫切需要，气功中心经过长时间的论证和酝酿，以科技攻关的方式展开，自2014年起陆续启动了健身气功系列通用教材的编撰工作。本次推出的教材系列，主要包括《健身气功导论》《健身气功?八段锦》《健身气功?五禽戏》《健身气功?六字诀》等。本书委托原健身气功?易筋经功法编创课题组负责编撰。从史、理、法、效、学、练、教、问等角度讲述功法的奥秘，既有继承，也有发扬。特别是使过去很多难以言表的、只有靠师徒传授和反复领悟的内容跃然纸上，让学者有迹可循、有法可依，对初学健身气功具有指导意义，亦能指明向更高境界进取的途径。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	104
279	陈式五十六式太极拳	9787500957867	9787500957867	张振兴 	0	1-1	32开	34.00	126.0千字	人民体育出版社	145	\N	26	2021-06-01	/book/90295467-3c82-47ee-84c7-202e91df4c151071976.jpg	陈式太极拳，发源于河南温县陈家沟，是非常古老、久负盛名的太极拳派。当今流传的杨式、吴式、武式、孙式等传统太极诸拳，多由其演变而来。陈式太极拳风格独特：缠绕折叠，穿蹦跳跃，松活弹抖；快慢相间，虚实结合，节奏鲜明；连绵不断，气势恢弘，独树一帜。 五十六式陈式太极拳，属国家标准竞赛套路。其以传统陈式一路与二路为编创基础，既具有多缠绕、以柔为主的一路拳风格，又有多发劲、以刚为主的二路拳的特点；在很好保留陈式传统精华的同时，又很好地满足了现代人比赛竞技与健身锻炼之需。整套拳法，动作优美，功架舒展；螺旋缠丝，劲道明显；虚实分明，刚柔相济；转换灵活，连贯流畅。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	547
280	四十二式太极拳	9787500958161	9787500958161	董国兴 	0	1-1	32开	33.00	116.0千字	人民体育出版社	133	\N	26	2021-06-01	/book/003e93fd-858d-492b-943d-511100f5dd8b1071977.jpg	四十二式太极拳是原国家体委武术研究院于1989年组织编创的太极拳竞赛套路。目前，在全国套路武术的比赛中，太极拳比赛所用套路规定为42式。此外，四十二式太极拳是中国武术六段位的考核规定内容。 四十二式太极拳兼采众长，动作以杨式太极拳为主，并在套路中间引用了不少其他流派的太极拳练法，如孙式太极拳的开合手、 右单鞭；陈式太极拳的 掩手肱捶、野马分鬃;吴式太极拳的"斜飞势等；外形严格规范，劲力刚柔并重，气势舒展大方。 四十二式太极拳的另一个主要特点是很注重左右动作的均衡性，如起势为 右揽雀尾，收势为左揽雀尾，而在传统太极拳中一般是偏重一侧的，这样就使布局更合理，结构更严谨，内容更充实，锻炼更全面。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	808
281	少林秘传五禽功（少林秘传绝技丛书.二）	9787500959007	9787500959007	邓方华 	0	1-1	32开	35.00	180.0千字	人民体育出版社	260	\N	17	2021-06-01	/book/b33897e0-4538-437c-b749-47f1e9e6bb071071982.jpeg	少林武术，中国武术的最大流派，其拳种之多、流传之广、影响之深， 无武能出其右。本套少林系列图书，内文配图不用现代的、直观的摄影照片，而是全部采用手绘的“绣像”插图，以企彰显武术的传统文化性，加深少林流派的武学内涵，增强对读者翻阅、选购、鉴赏与收藏的吸引力度。本套丛书大致可以分为古谱技击类、单一打法类、技击汇宗类、强壮健身类。本书属内壮健身类。本书属内壮健身类。本书所述的不是一般俗传的所谓"五禽戏"，乃少林古传真功，其吸取鹿、熊、鹤 、虎、猿之要，而为练功外五形，内加呼吸吐纳，然后内外合练。既可养生强壮，又可抗打自卫，为不可多得之功夫秘法。五禽功，又称"五禽操"、"五禽气功"、 "五禽戏"等，根据人体肾、脾、肺、肝、心五脏，相应地分为鹿、熊、鹤、虎、猿五部功法。古传达摩派虎、豹、鹤、蛇、猴五拳，也被称作"五禽内功拳"，属不传之秘。本书准备选其精粹，挖整出来，以广传益众。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	949
295	货币金融学	9787550448988	\N	翁舟杰 	平装	1-1	大32开	49.80	\N	西南财经大学出版社	\N	\N	\N	2020-08-01	/book/4886f1b3-469b-4911-8856-7a48c93b301b1072919.png	本书的的章节分布和《货币金融学》教材一致,各章的具体安排包括：教学大纲、重点难点分析、习题练习、参考答案。此外,部分章节安排有延伸阅读,读者可以通过阅读加深对知识点的理解和掌握并开拓视野。本书为《货币金融学》配套的学习指导，可供金融学相关专业本科生、硕士研究生使用,帮助学生对《货币金融学》课程的学习；可以作为《货币金融学》主讲教师的辅助教学资料；可以作为相应考试（硕士入学考试等）和相关培训的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	830
282	象棋实用残局棋典	9787500958949	9787500958949	焦克延 焦家祥 	0	1-1	32开	386.00	569.0千字	人民体育出版社	1268	\N	3	2021-04-01	/book/d72fb326-1256-4008-b126-9a0044ce6b421071988.jpeg	象棋是中华民族传统文化宝库中一颗璀璨的明珠，有着广泛的群众基础，它集竞技性和趣味性于一体，吸引亿万棋迷鏖战在楚河汉界，流连忘返，“棋”乐无穷。象棋对局一般经历开局、中局、残局三个阶段，水平相当的棋手对奕，特别是高手相争，往往要战斗到残局才见分晓。要想在残局战斗中取得最佳战果，如果没有深厚的残局功底，就难能如愿。 残局定式，是象棋残局知识的重要组成部分，是古今实战经验的结晶，它有固定的棋型和着法，并有确定的结果，对实战具有普遍的指导意义。长期以来，虽然介绍象棋残局的书籍很多，但是遗憾的是，缺少一本全面、系统的论述象棋实用残局定式的专著。现在《象棋实用残局棋典》的出版问世，正好填补了这一空白。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	159
330	变电运行	978-7-5689-2077-3	\N	舒辉 	\N	1-1	16开	45.00	453.0千字	重庆大学出版社	299	\N	\N	2020-04-23	/book/36191e25-b2f4-4fd5-8512-155d10b6c3f692077.jpg	本书编写采用“任务驱动、项目导向”的模式，围绕变电站电气设备巡视、变电站电气设备维护、变电站倒闸操作、变电站电气设备异常处理、变电站事故处理5个项目展开，每个项目根据生产现场的典型工作情境设置任务，任务按照任务描述、任务准备、相关知识、任务实施的顺序展开。本书的内容编排符合学生知识和技能的学习规律，具有很强的针对性和可操作性。 本书既可作为高职高专院校电力技术类专业的专业教材，也可作为变电站运行人员的技能鉴定培训教材，同时还可供相关工程技术人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	671
283	竞技参赛理论解析及案例分析（天津体育学院“十二五”规划教材）	9787500959403	9787500959403	谢云 	0	1-1	16开	50.00	186.0千字	人民体育出版社	153	\N	13	2021-03-01	/book/685b6ce0-5134-43f4-ab97-80ff0f8573671071989.png	竞技参赛是运动竞赛,也是竞技体育中不可缺少的组成部分,具有无可替代的重要性和独立性。竞技参赛学是指导教练员、运动员成功参加比赛的理论,对培养优秀的竞技选手、创造高水平运动成绩有着重要的作用。多年来,作者在赛前准备、参赛行为及其控制、赛后认知和调教训练3个领域进行了多个课题的深入研究,进而系统地构建了竞技参赛学理论体系,弥补了这一明显的理论缺失,是竞技体育学理论体系的重要发展和完善。竞技参赛理论解析及案例分析能给大家带来更直观的答案。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	447
284	甘凤池秘传内外功（少林秘传绝技丛书.二）	9787500959014	9787500959014	杨应威 	0	1-1	32开	30.00	177.0千字	人民体育出版社	220	\N	20	2020-11-01	/book/03b45771-bb68-4f88-aa0f-716ebeb6d8731071994.jpeg	少林武术，中国武术的最大流派，其拳种之多、流传之广、影响之深， 无武能出其右。本套少林系列图书，内文配图不用现代的、直观的摄影照片，而是全部采用手绘的“绣像”插图，以企彰显武术的传统文化性，加深少林流派的武学内涵，增强对读者翻阅、选购、鉴赏与收藏的吸引力度。本套丛书大致可以分为古谱技击类、单一打法类、技击汇宗类、强壮健身类。本书属内壮健身类。本书属内壮健身类。甘凤池，被武林誉为"江南大侠"，为清代著名武术家。其武功传至今天，仍然传人众多，高手辈出。内容框架为第一章坐功、第二章行功、第三章盘功、第四章操功、第五章甘凤池八段锦、第六章甘凤池十段锦、第七章小武功。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	212
285	中国青少年田径大纲教法指导	9787500945710	9787500945710	国家体育总局青少年体育司 中国田径协会编 	0	1-1	16开	135.00	877.0千字	人民体育出版社	649	\N	4	2021-03-01	/book/ca8919ee-3da0-4259-a919-02c0cb21dc491072002.png	本书是体育总局青少司组织编写的青少年项目训练教学大纲的配套教法指导书丛书之一，引导读者（教练员）用好大纲，起到真正执导教练员组织训练的目的。本书由田径协会组织高校教师、资深教练员团队共同编写。教法指导书的目的就是让青少年运动员在科学方法的指导下，通过刻苦训练，提高竞技能力，在比赛中获胜。全书按照田径的具体项目分为十三章，每章大致分为8节，具体包括：项目特性与发展趋势；运动技术；项目的选材；各年龄阶段训练任务与要求；各项评价指标、训练负荷及训练要求与任务；训练计划的制定；专项训练方法与手段；恢复训练、心理训练、训练监控与伤病预防等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	663
286	足球有氧与无氧训练（足球体能训练丛书1）	9787500955283	9787500955283	（丹）延斯.邦斯博 	0	1-1	16开	72.00	220.0千字	人民体育出版社	202	\N	9	2021-02-01	/book/4cea4787-b1b5-46fe-bd22-a50356cad5f21072007.png	全书共分7章。内容涵盖了教练员需要了解的体能方面的基本知识，其中有些内容体现在欧足联B级教练培训教程中。主要内容包括足球专项有氧训练与无氧训练的原则、方法和组织。 作者延斯.邦斯博博士是足球体能训练领域的专家。他既是一名足球从业者，同时也是一名运动科学家。他不仅可以将体能训练理论以一种通俗方式进行阐述，而且也可以为教练员提供实践指导。本书无论对于体院学生还是教练员，都是一本非常有价值的参考书，其独特之处在于，它不仅为读者提供了基本的理论知识，并结合训练实践进行了实例说明	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	201
287	网球力量训练理论与实践	9787500959724	9787500959724	钱光鑑 史兵 马孝刚 	0	1-1	16开	56.00	348.0千字	人民体育出版社	269	\N	9	2021-04-01	/book/8f24ba14-1801-4e16-aaca-b06c774408221072010.jpeg	如今，网球是极为普及的运动，男女老少都很喜爱。但由于网球运动容易受伤，尤其是“网球肘”和膝关节的受伤率较高，使网球明星的高超技艺大打折扣，让许多爱好者望而怯步，只能成为网球明星的忠实观众和粉丝，而不敢进行网球运动。本书首次提出了以“力量优先”来发展网球运动，第一次把力量理论和实践融入到了网球运动之中，是一种首创和发展；特别提出了要优先加强“骨骼力量”才能带动肌肉力量的提高，这才是不受伤、少受伤、能打球、打好球的根本。为此，就骨骼、关节、肌肉的用力顺序，提出了“骨关节肌”的概念。本书从网球力量概述开始，根据网球力量的力学分析， 研发了网球力量训练和方法，并配合有大量动作图，为防止受伤提出了网球力量训练的原则、计划和康复手段，用评估和检测来检验效果，制定了网球力量的基本标准，提供了网球力量训练的最佳方法，并配有动作图， 这是一种全新的网球力量训练的创新理论和实践。本书适用于各层次运动员和青少年及所有普通人群，以使大家通过力量训练不但有实力有能力娱乐网球，而且更能愉悦身心。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	421
288	天人共生与道文兼济——汉语诗学样本	978-7-5487-4554-9	\N	孟泽 	平装	1-1	16开	68.00	\N	中南大学出版社	\N	\N	\N	2021-08-01	/book/f0031132-12a7-4e11-8e59-fb5616143cd41072889.png	该书通过描述和阐释陈白沙、王船山、曾国藩等人的诗学思想，在比较文化的视野中勾勒了汉语诗学的基本命题、性质和品格，论述了这种诗学思想在特定时代及个体的展开过程中的单纯与复杂、丰饶与贫瘠，探讨了这种诗学思想发生的社会依据、精神背景与个人渊源，论证汉语诗学思想与精神在现代中国文艺思想中的延伸与拓展，论述了汉字对于汉语诗学的决定性，以及汉语诗歌的地方属性与方言属性。书中所述的不同时地、不同身份、不同教养的思想者，对于审美，对于文艺的设计、处置、诉求、祈愿和想象，重心或许有别，动机和动力则疑似仿佛，他们共同为有机的整体主义的汉语诗学，提供了高明、精致、通达而个性鲜明的样本。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	286
289	巴风渝韵话古今	9787569707434	\N	邹克纯 撰文 游江 绘 	平装	1-1	16开	68.00	\N	西南大学出版社	\N	\N	\N	2021-04-01	/book/a28e42f6-f364-4712-910f-af731f93f89f1072898.png	本书谈古论今，相当于一部重庆地域文化事典，由20余篇文化随笔构成，分为溯源、母城、文脉、风俗四个篇章，从巴渝族群和重庆母城这两个视角着眼，笔墨涉及巴渝古今的历史与文化，将巴渝地区的历史传说、轶闻掌故、地理气象、宗教信仰、街市建筑、风俗民情、方言土语、民间艺术等融于一炉，大致勾勒出一个巴渝古今的背影轮廓。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	816
331	视讯技术——构建宇视大规模监控系统	978-7-5689-2363-7	\N	杨业令 王璐烽 	\N	1-1	16开	49.00	462.0千字	重庆大学出版社	318	\N	\N	2021-01-13	/book/1d07442c-8156-4cf1-8a9d-1aa210fb998792363.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	669
297	世间味道	9787559839046	\N	肖于 著 	平装	1-1	32开	52.00	175.0千字	广西师范大学出版社	\N	\N	\N	2021-07-01	/book/8fdd064f-65d7-486d-8a10-52678e9efa0b1072931.jpg	本书是一本东北美食散文合集。糖蒜、锅包肉、大拉皮、白菜猪肉炖粉条……每一种熟悉的东北菜背后，都有一个令人动容的故事。作者从咸、甜、酸、辣、鲜香五种味道出发，写下一道道热气腾腾、鲜香美味的东北菜，写出了温暖、温厚的人情味。而关于家乡菜的回忆里，还包括了若干小人物的命运故事，他们勤劳、勇敢、有趣，在时代的起起伏伏中，他们用辛勤的劳动把苦日子过甜，把苦涩生活变成诙谐、轻松的人间喜剧。 东北雄浑的黑土地上，孕育出了形形色色的美食，而众多小人物跌宕在大时代的红尘中，生成90年代热火朝天的东北小城的一帧影像。愿更多的东北人从这本书中，看到自己的过往，记起自己的来处。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	701
290	迷上数学——触动童心的数学文化课	9787519126612	\N	李铁安 	平装	1-1	16开	68.00	\N	教育科学出版社	\N	\N	\N	2021-06-01	/book/407cb8bf-8caf-4e09-9cd2-0411ac3340bb1072901.png	数学不只是冷冰冰的，数学也是有温度的，数学的温度就是通过数学文化来体现的。彰显数学的文化价值，充分发挥数学深刻而独特的育人力量，是数学文化进课堂的宗旨追求与核心功能。但数学文化进课堂绝不是简单地给单调枯燥的数学内容添加一点数学史、数学故事的作料。数学有更深刻的内涵、价值。本书就通过对数学、数学文化、数学文化课的追问以及对具体课例的实录和解析，来呈现如何让学生更深刻地认识数学的本质与价值，更有力地培植数学学习的积极兴趣和坚定信心，更有效地培育敏锐的问题解决意识、火热的好奇心、大胆的想象力和灵动的数学思维方式，更切实地培养数学的思维能力和问题解决能力及创新能力，从而迷上数学。 本书可作为广大一线教师开展课堂育人的参考书，也不失为新入职教师理解课堂教学的工具书，乃至师范大学生迈向教师职业的入门书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	385
291	心理学史（第二版）	978-7-5760-1375-7	\N	叶浩生 杨莉萍 主编 	平装	1-1	16开	56.00	\N	华东师范大学出版社	\N	\N	\N	2021-07-01	/book/3819db0b-3206-4dfd-a5c3-2ce7b34398451072904.jpg	本书扼要叙述了心理学的长期过去，追溯了心理学的历史起源和科学心理学建立之后心理学流派的兴衰，分析了心理学的历史发展过程。本书是高校心理学专业的主干课教材，系统介绍心理学的发展历史及主要的心理学流派及其相互间的影响和联系，并借助于图片和图表的使用，增强历史知识的直观性、生动性和趣味性。新版基本维持了原来的体系和内容，但对部分章节进行了较大的修订，更新了许多案例，删除了许多过时的内容，力求在内容和版式上与时俱进。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	919
292	城市地下空间防洪与安全	9787560857008	\N	刘曙光，陈峰，钟桂辉 著 	平装	1-1	16开	88.00	\N	同济大学出版社	\N	\N	\N	2014-12-01	/book/a995876d-4ae6-4bc5-a59a-adda1db80cd01072908.png	　　《城市地下空间出版工程·防灾与安全系列：城市地下空间防洪与安全》为“十二五”国家重点出版图书。《城市地下空间出版工程·防灾与安全系列：城市地下空间防洪与安全》围绕目前日益关注的城市地下空间防洪与安全问题，系统阐述了城市地下空间洪水灾害水力特性、地下空间出入口洪灾的水力特征、地下空间洪水灾害风险评估体系的内容和研究方法、城市地下空间洪灾防灾减灾和应急管理措施。《城市地下空间出版工程·防灾与安全系列：城市地下空间防洪与安全》内容丰富，反映了当前在地下空间防洪与安全方面的新成果与新趋势，有助于加深对地下空间洪灾的认识，推动学科研究的深化和新成果的工程应用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	423
293	城市地下空间通风与环境控制技术	9787560883397	\N	张旭，叶蔚，徐琳 著，钱七虎，朱合华，黄宏伟 编 	平装	1-1	16开	138.00	\N	同济大学出版社	\N	\N	\N	2018-12-01	/book/0a373cb8-c57e-404d-87a9-7a721ca537811072909.png	　　城市地下空间通风与环境控制技术的主旨是保障城市地下空间的安全、健康、舒适和节能环保。全书的主要特色是围绕地下商场、地铁车站、地下车库、地下综合体联络通道、地下科学实验室、地下公路隧道等典型城市地下空间，系统阐述了以下三方面的内容：①主要污染物来源及其扩散特性；②运营通风设计方法与适用的环境控制技术；③火灾等事故条件下的烟气扩散规律及防排烟控制技术。全书结合作者多年来的研究，内容反映了当前在城市地下空间通风与环境控制技术方面的一部分新成果与新趋势，有助于读者加深对地下空间环境控制技术新进展的了解与认识，并推动相关研究的深化和新成果的应用转化。 　　《城市地下空间通风与环境控制技术》可供从事城市地下空间通风与环境控制的设计、运行与管理以及政府相关部门决策、制定行业规范等技术人员参考与应用，也可供高等院校土木工程及建筑环境与能源应用工程等相关专业作教学使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	181
296	魏晋风度与中国文化基因	9787569508611	\N	胡建升 	平装	1-1	16开	128.00	\N	陕西师范大学出版总社	\N	\N	\N	2019-08-01	/book/5b243188-67f6-42f4-9c33-26ca7c8797531072928.png	魏晋士人厌弃世俗世界的虚妄伪善与礼法秩序，“归玄”成为魏晋士人的文化认同，代表一代知识分子由有入无的神话回归与心性追寻。魏晋士人群体的文化资本与神话认同都由世俗层面回归大传统鲜活的尚玄之根，使原初文化的神话力量贯通在士人存在的本来心性之中，践行于世俗的方内世界，形成魏晋士人群体OO的文化气韵与潇洒风姿。 本书从大传统的文化基因视角重新审视魏晋风度的编码，力求揭橥其潜藏的神性源泉与文化趣味。作者综合采用文学人类学的多学科视角，体现了跨学科研究的整合性范式。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	909
298	可爱的江苏(初中版)	978-7-301-09370-2	9787301093702	《可爱的江苏》编写组 	\N	1-1	16开	10.26	190.0千字	北京大学出版社	284	\N	\N	2021-07-08	/book/c2c1aeb2-fe56-459e-a0d2-8f11ebefcab50937013.jpg	《可爱的江苏(初中版)》从乡土乡情、经济纵横、历史长河、人文荟萃等几个方面介绍了江苏的地方历史、文化、经济发展等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	748
302	职业道德与药学伦理学	978-7-301-23097-8	9787301230978	王育红，黄金宇 	\N	1-1	16开	33.00	258.0千字	北京大学出版社	168	\N	\N	2021-08-03	/book/559f0de8-e36f-4dc0-bf38-264d9a5cb78e2309702.jpg	药学职业是与人类健康和生命安全、与社会公共利益密切相关的特殊职业。药学职业道德是社会主义道德体系的重要组成部分，是人们在药学职业实践活动中形成的行为规范。这种特殊性和重要性，决定着药学职业道德规范有着自己特殊的原则与内涵。药学伦理学是研究医药道德的一门科学。随着医药事业的发展，加强药学相关从业人员的职业道德和伦理规范建设，重视行业内的道德理论研究，有利于实现依法治国和以德治国的有机结合，有利于促进社会主义精神文明建设。主要内容包括：道德与职业道德、伦理学与药学伦理、药学伦理的规范体系、药学职业道德的基本原则、基本范畴、基本规范、主要内容以及在新药开发、药品生产、药品经营、药品监管和医院药学领域的职业道德要求。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	973
303	综合日语第二册	978-7-301-23795-3	9787301237953	何琳 	\N	2-1	16开	39.00	210.0千字	北京大学出版社	200	\N	\N	2021-07-15	/book/fe2f72c9-1a75-40d8-a527-8374630e7f022379502.jpg	本书系《综合日语》教材的配套练习册。本书与课本内容一一对应，每课内容包含课文相关文字、词汇、语法练习，以及听力练习等。形式丰富多样，有选词填空、翻译、堂解释、选择题等。每三课设置一个单元练习，巩固学习效果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	981
304	综合日语·第三册练习册(修订版)	978-7-301-24119-6	9787301241196	何琳 	\N	2-1	16开	37.00	200.0千字	北京大学出版社	164	\N	\N	2021-07-20	/book/ff89ea21-e9e5-4c09-9ddb-aac7f6c2ac012411903.jpg	本书系《综合日语》教材的配套练习册。本书与课本内容一一对应，每课内容包含课文相关文字、词汇、语法练习，以及听力练习等。形式丰富多样，有选词填空、翻译、堂解释、选择题等。每三课设置一个单元练习，巩固学习效果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	128
305	外国语文导论	978-7-301-24655-9	9787301246559	石坚 	\N	1-1	16开	48.00	256.0千字	北京大学出版社	244	\N	\N	2021-06-28	/book/d1a48e74-c772-4fab-ad89-fb1903e0eb752465502.jpg	本教材是为高校外语专业的学生编写的，对外国文学(英、法、美、日本、俄罗斯、圣经文学）、外国文化、语言学、翻译(翻译史、翻译理论）等各方面进行简要的介绍，并配有思考练习题。培养目标是具有扎实的外语语言基础和广博的文化知识的复合型外语人才。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	986
306	改变世界的一粒种子——记杂交水稻之父袁隆平	978-7-301-26286-3	9787301262863	席德强 	\N	1-1	16开	30.00	98.0千字	北京大学出版社	228	\N	\N	2021-07-13	/book/663c2746-8182-482f-a839-a008fd9d47222628602.jpg	本书介绍了“杂交水稻之父”、国家科学技术进步奖特等奖获得者袁隆平的科研故事。全书分为“追梦人生”、“求学之路”、“曲折的科研之路”、“用一生做好一件事——培育杂交稻的岁月”、“辉煌的成就，做人的楷模”、“伟人的平凡生活”几个章节，全方位地介绍了袁隆平的成长经历、科研历程。本书作为励志图书，有助于培养学生不怕困难，勤奋努力向上的精神，也有助于培养学生对生命科学、对大自然产生好奇心和探究的欲望。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	394
307	物业管理实务	978-7-301-27163-6	9787301271636	胡大见 	\N	1-1	16开	49.00	483.0千字	北京大学出版社	324	\N	\N	2021-08-06	/book/a44855ca-e977-493b-b800-c8fb5d543ad32716302.jpg	本书以培养物业管理应用型中高级人才为目标，系统地介绍了物业企业管理、物业管理招标投标、前期物业管理、接管验收和入住管理、业主自治管理、物业管理费用管理、房屋维护管理、环境管理与安全管理、物业文书拟写、物业租赁管理、物业估价、物业管理法律与物业服务质量标准内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	752
333	新编环境与资源保护法学	978-7-5689-1934-0	\N	黄锡生 史玉成 	\N	1-1	16开	45.00	389.0千字	重庆大学出版社	260	\N	\N	2019-12-28	/book/ef565914-b42c-4729-9a08-96866251ae2291934.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	339
309	德语民法学精读译文集	978-7-301-30496-9	9787301304969	孙宪忠 	\N	1-1	16开	29.00	151.0千字	北京大学出版社	268	\N	\N	2021-07-06	/book/ce9e844f-2366-4cc5-9909-db06a8190dea3049602.jpg	本书是孙宪忠教授在学习德语民法文献的过程中，为自己精读的需要而完成的部分译文的汇编。一些在国内发表的译文，得到民法学界的喜爱，如“民法上的人”引用率甚高；另外，关于法律行为、法律关系、物权行为理论的译文，也常常见诸于法学著述的引注或者文献之中。平心而论，这些文献确实有正本清源的作用，望能给读者以启发。 本书选编的九篇译文包括： ■《德国民法典》的过去与现在 ■《德国民法典》和民法学的发展 ■“抽象物权契约”理论——德意志法系的特征 ■民法上的人 ■行为能力比较研究 ■法律行为的概念——产生以及发展 ■违背法律和善良风俗的法律行为后果比较 ■三大法系的要约与承诺制度 ■德国民法中的形成权	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	298
351	实用办公软件（WPS	9787560660837	\N	冯寿鹏 	\N	1-1	16开	37.00	362.0千字	西安电子科技大学出版社	244	5606	11	2021-08-16	/book/a5121ec7-1539-48ce-86a8-13ef8cbb53bf9787560660837.jpg	本书基于国产办公软件WPS Office，按照“模块化、任务式”形式组织内容，主要包括文字处理技术、数据处理技术、多媒体课件制作技术三大模块。本书图文并茂、通俗易懂、实践性强，学生通过实际训练，在熟练掌握办公软件基础上，应用能力和信息素养也会得到全面培养和提高。 本书可作为大专院校和职业技术院校学生的计算机基础教材，也可供广大计算机爱好者自学使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	664
310	诗词格律读本	978-7-301-31852-2	9787301318522	梅振才 	\N	1-1	16开	58.00	266.0千字	北京大学出版社	344	\N	\N	2021-07-12	/book/2ca669a0-ba8c-4b81-aaf1-dec0ee367f4831852.jpg	这是一本有关诗词格律的普及读物，次第清晰，既周到细致，又简明扼要，既有对基本常识的一一解说，又有许多自己创作诗词的心得体会，很适合学诗者随手参看使用。与同类书籍比较，此书有如下特点:1.简明易懂；2.突出攻平仄难关；3.重点介绍对仗、押韵及拗救；.详解近体、仄韵及拗体诗律 ；4.词牌之词例选当代诗人作品；5。入多种趣味别体诗词；6.有诗话篇章谈诗艺和修养；7.知识性与趣味性融于一炉。此书次第清晰，既周到细致，又简明扼要，既有对基本常识的一一解说，又有许多自己创作诗词的心得体会，很适合学诗者随手参看使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	262
311	视觉修辞学	978-7-301-32064-8	9787301320648	刘涛 	\N	1-1	16开	126.00	561.0千字	北京大学出版社	512	\N	\N	2021-06-29	/book/def1aee5-e442-4337-b6cc-441cea7f623732064.jpg	传统的修辞学主要关注语言文本的修辞问题，而视觉修辞学（visual rhetoric）则是视觉文化时代修辞学亟待拓展和延伸的一个新兴的学术领域，其主要关注以视觉文本为修辞对象的修辞实践与方法。作为一种认识论、方法论和实践论，视觉修辞学意为研究视觉文本修辞语言、活动与规律的学问。本书立足视觉修辞学的学术史考察，沿着修辞学的“学科建制”思路与要求，从理论和方法两个维度搭建视觉修辞学的知识系统，即视觉修辞学的基本原理和方法体系，并在此基础上探讨视觉文化时代人类在视觉修辞意义上的生存方式及对话体系。在内容构成上，本书上编主要探讨视觉修辞学原理与理论，核心关注视觉修辞学的学术范式、意义原理、认知模式三大命题；下编主要探讨视觉修辞学方法与批评，核心关注视觉修辞学的分析方法和批评范式两大命题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	662
312	国际金融学	978-7-301-32122-5	9787301321225	罗丹程 	\N	1-1	16开	49.00	450.0千字	北京大学出版社	300	\N	\N	2021-08-03	/book/a48f30b0-25ec-4204-9857-2c6950a91c3a32122.jpg	本书分为三篇共 13 章。 第一篇为国际金融基础，该篇主要内容是国际金融外汇、汇率、外汇市场基本业务等基础知识，内容包括外汇与汇率、国际收支和国际储备、外汇市场基本业务、外汇衍生品市场四章；第二篇为国际金融实务，内容包括外汇风险及防范、外汇管制政策、国际金融市场及业务、国际贸易短期融资、国际贸易中长期融资、跨国企业财务管理、国际资本流动与金融危机七章；第三篇为国际金融制度与组织，内容包括国际货币制度、国际金融组织两章。 此外，本书在每章前列出了教学要点、知识架构和导入案例，并在各章中间加入了案例、知识拓展和资料卡，还编写了配套的习题，以加深读者对每章内容的理解。 本书可作为高等院校金融学专业、国际贸易专业、国际经济专业及其他相关专业的教材使用，也可以作为从事金融和国贸等实际工作者的参考用书。 "	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	453
313	消费者行为学——理论、案例与实务	978-7-301-32183-6	9787301321836	周斌 	\N	1-1	16开	59.00	531.0千字	北京大学出版社	356	\N	\N	2021-07-19	/book/75014d34-ddbf-4759-be72-3f218ef8da8d32183.jpg	本书以行为主义学派的思想构建消费者行为学学科体系，减少空洞晦涩的心理学概念。内容结构根据“消费者内部因素、外部环境因素和营销因素（如商品、促销等）”这三大类影响因素，以及消费者购买行为过程来进行构思。基本顺序是先微观影响因素、后宏观影响因素，然后是购买行为过程，最后再将反映网络时代的网购行为进行专门论述。全书借鉴营销学派的思路，注重将消费者行为学的基本理论和市场营销实践相结合，书中既有深入浅出的理论分析、丰富创新的研究成果，又有具体生动的本土化营销实例，融理论性、实用性、操作性、趣味性于一体。本教材充分吸收国内外的最新研究成果和近年来的案例资料，内容与资料都努力体现与时俱进。同时，传统的消费行为的论述过程中，努力结合互联网及新媒体环境下消费者购买心理与行为的发展变化。本书采用互联网+教材的思维进行编写，相对其他教材在内容和编排上都具有特色。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	368
484	5-6岁儿童学习与发展教师指导手册(下)	9787565228612	\N	赵宇、但菲 编，杨丽珠 总主编 	平装	1-1	16开	50.00	\N	辽宁师范大学出版社	\N	\N	\N	2018-07-01	/book/928c770c-b71e-4b3e-9649-145d8631ef741074532.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	622
314	模糊数学	978-7-301-32212-3	9787301322123	张博侃 	\N	1-1	16开	56.00	292.0千字	北京大学出版社	264	\N	\N	2021-08-04	/book/c9efe6c9-06cd-4dfa-86f8-006fb0ce7b9532212.jpg	本书是高等院校本科生高年级《模糊数学》教材，书中系统介绍了模糊理论的基本内容，包括模糊集合的定义与运算、模糊算子、模糊性的度量、分解定理、表现定理、扩展原理、模糊数、模糊关系以及模糊关系方程等，同时也介绍了隶属函数的确定方法、模糊模式识别、模糊聚类分析、模糊综合评判等应用方面的内容. 每章配有习题，书末附有习题的部分答案. 本书可作为高等院校相关专业高年级本科生和研究生的教材，也可作为科研人员的参考书.	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	924
334	电子商务基础	978-7-5689-1160-3	\N	程驰 郭江霞 	0	1-1	16开	25.00	193.0千字	重庆大学出版社	130	\N	\N	2021-03-24	/book/f46b5890-45db-436a-972b-7b8c04e7135f1073259.png	本书按电子商务的构建与运行所需环境，按项目组织教材内容，教材中每个项目涉及的知识和操作技能都来自电子商务的实践，可以一边学习一边操作，让学习者轻松体会到学习的价值和乐趣，不断强化学习的目的性。在教材结构规划、内容组织、文字编撰等方面，始终坚持以人为本的原则，体现了中等职业教育电子商务专业学生在知识与技能、过程与方法、情感态度与价值观等方面的基本要求。本书图文并茂，文字通俗易懂，内容安排突出“学生为中心，能力为本位”的教育理念，方便教师以新课程的理念来组织教学，教师成为学生学习的组织者参与者和引领者，让学生去探究、发现、实践以提高运用电子商务的实践能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	184
328	电力系统继电保护信号识别与分析	978-7-5689-2024-7	\N	刘娟 	\N	1-1	16开	45.00	376.0千字	重庆大学出版社	241	\N	\N	2020-03-10	/book/4e85bad2-aaa0-4eb2-9564-81eb0b0324b392024.jpg	本书是高等职业教育适用于发电厂及电力系统、供用电技术、电力系统自动化等专业的教材，主要介绍电力系统继电保护的基本知识、电力系统故障时的监控信号识别及分析方法。全书分为6个项目，内容包括继电保护的基本知识、配电线路保护信号识别与分析、输电线路保护信号识别与分析、变压器保护信号识别与分析、发电机保护信号识别与分析、母线保护信号识别与分析。本书针对高职高专院校学生的特点和教学要求，本着“理论适度够用，强化实践技能”的原则，对理论内容进行了适度的取舍，以项目任务为主线进行信号识别、故障判断、综合故障分析等各级难度的训练。 本书可作为高职高专电气工程类专业的教材和从事电力行业的职工职业技术培训用书，也可作为从事变电运维、监控值班、继电保护调试等工作的有关工程技术人员的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	972
315	德国法学与当代中国	978-7-301-32224-6	9787301322246	卜元石 	\N	1-1	16开	69.00	417.0千字	北京大学出版社	468	\N	\N	2021-07-14	/book/99f03957-e6f1-45e1-b662-77c9a18cf45732224.jpg	德国法学作为大陆法学的代表，过去二三十年间，在中国被关注的程度逐渐增加，在具体法律制度之外，越来越多的学者开始把注意力转向包括法教义学、法律评注、鉴定式案例教学在内的德国法学特色。 本书旨在为中国读者解读德国法学学科文化以及法学传统的形成，主要涉及的也是这三个方面的问题。此外，本书还希望通过对德国法学与美国法学在制度输出方面竞争的探讨以及对德国法学反思二战期间自身角色的回顾，从历史与比较的视角展示德国法学今天在国际上的自我定位。最后，本书考察中国法在德国的研究状况以及中国学者在德国留学的情况等，进而对德国法学与中国的关系之现状作一个盘点。法教义学为目前我国法学教育的主要研究方法，法学院教科书及论文写作大都按照这种范式，而法律评注的写作方式在中国法学界也日渐兴起，作为大陆法系代表的德国法，无论从立法还是在司法实践等方面都深深影响着我们，本书是目前所见到的介绍德国法对中国法学界影响力的一部比较全面、系统的法学学术作品。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	522
316	历代宋诗总集研究	978-7-301-32233-8	9787301322338	王友胜 	\N	1-1	16开	55.00	314.0千字	北京大学出版社	296	\N	\N	2021-07-15	/book/c15677d6-208f-4a56-b7cc-fba4c2edec4e32233.jpg	《历代宋诗总集研究》为国家社科基金后期资助项目成果。该书分上中下三编，比较全面系统地对宋诗总集进行了清理和研究。上编通过对大量宋诗总集的叙录与考辨，分析、总结出宋诗总集的理论型态、价值意义与编纂语境等；中编通过描述宋诗总集编纂由形成、过渡、繁盛、转型到集成等五个阶段发展与演变的历史进程，分析每一时段宋诗总集编纂的主要成就、特点以及宋诗总集得以形成的政治、文化、教育、科举、诗学等生态背景；通过考察重点宋诗总集，探讨宋诗总集的编纂与诗社、诗学流派的形成及诗学思潮发展的密切关系；下编通过系列个案研究，剖析重要宋诗总集的编纂缘起、编纂目的、编纂过程、基本内容、采用体例、诗学主张、文献局限、版刻情况、传播接受等，以比较不同总集彼此之间的异同得失等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	576
763	超声波检测实用技术	9787561085523	9787561085523	刘应和, 卢盛华 	\N	1-1	16开	90.00	\N	辽宁大学出版社	\N	\N	\N	2017-03-01	/book/446a4a83-03a7-4217-9d22-2b406563c1e19787561085523.jpg	全书通过超声横波双弧单孔法、横波外圆双孔法、横波内圆双孔法、横波（纵波）双孔法、表面波与爬波法等超声波检测的新方法，进一步完善了超声波检测的通用技术。重点解决了钢板、高压电阻焊钢管、无缝钢管、直缝焊管、螺旋焊钢管、轴类锻件、筒形锻件、高强度螺栓、奥氏体不锈钢焊缝等大量工件超声波检测存在的问题。本书的出版对提高特种设备无损检测人员的实际工作技能大有帮助。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	402
350	力量：中国作家2020早春纪事	9787569518733	\N	贾平凹 	平装	1-1	16开	59.00	\N	陕西师范大学出版总社	\N	\N	\N	2020-12-01	/book/a4ac30a0-cb46-4796-b9c2-ff66ec74baca1073415.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	448
317	保险法原论	978-7-301-32240-6	9787301322406	孙宏涛 	\N	1-1	16开	86.00	513.0千字	北京大学出版社	444	\N	\N	2021-07-07	/book/776c38c7-cfac-4da7-9556-19d77f407f2c32240.jpg	本书覆盖全面、重点突出，涉及保险法中最重要的知识要点，是对传统保险法教材的传承与创新。本书在保留传统保险法最核心、精髓内容的进行了创新，编入了新型保险形式，如知识产权保险、物流保险等，吸收最新的成果，反映了最新的研究方向。 在内容上，本书注重理论与实践的结合，选取最经典的案例，采用理论教学与案例教学相结合的方式，并将案例分为示范案例、思考案例：示范案例展示了思考与解决保险法纠纷的思路，引导学生从理论走向实践；思考案例让学生结合法条主动去思考，学以致用，引导生从全面学习走向深度研究。为更贴近保险实务，本书放置了不同类型的真实保单，让保险法看得见摸得着，提高学生对保险法的学习热情，拉进学生与保险法的距离。 本书按照从宏观到微观、从抽象到具体的思路安排，共四编、十六章：第一编主要是对保险法的概述，包含保险法的历史演变以及种类，是对保险法宏观的介绍。第二编为保险合同法总论，是提纲挈领的部分，是对保险法中最为重要的一些原则和理论的阐述，较为详细地阐述了险合同的订立、生效、变更等问题，以及作者对中国保险法中一些规定和原则的思考。第三编是保险法合同分论，重点介绍人身、财产、责任保险三类理论和实务中最常见的 “三大金刚”。尾编为保险业法，具体研究了保险业的组织形态以及保险业的监督管理。附录为保险法相关的法律法规、司法解释，以及国外相关保险法的规定，力求一本书整合主要的保险法资源，成为集理论与实务为一体的保险法百科全书。 本书可为法学本科生、研究生、实务界人士研习保险法的参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	998
318	全球结构下中国刑法体系的构造	978-7-301-32241-3	9787301322413	童德华 	\N	1-1	16开	69.00	360.0千字	北京大学出版社	492	\N	\N	2021-07-06	/book/35b90aaf-50a6-46ab-9557-24138884165032241.jpg	本书系国家社科基金项目“递进式、抗辩式与耦合式犯罪构成论体系比较研究”（10BFX033）的最终成果。 从20世纪90年代末期开始，随着社会主义法治目标的确立，犯罪构成理论作为刑法理论的核心和基础，成为受到学界高度重视和关注的“焦点”。我国学者对犯罪论体系的视角不同，构想各异，导致学者之间难以形成有效的学术对话。本研究以我国犯罪论体系的理论困境为进路，通过对我国传统犯罪论体系的理论分歧和主要争议点的解读，提出了犯罪论体系研究的基本思路，同时对递进式、抗辩式与耦合式犯罪构成论体系进行深入地比较研究，进一步剖析中国犯罪论体系构造的基础，展开对犯罪论体系的理论、现实和科学维度的探究，并据此提出我国犯罪论体系构造的方向，对犯罪论体系的程式化构造、开放化构造和论辩式构造分别予以全面的介绍和论述。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	770
319	论历史（下）	978-7-301-32253-6	9787301322536	费尔南·布罗代尔 	\N	1-1	16开	69.00	255.0千字	北京大学出版社	320	\N	\N	2021-07-12	/book/42490185-1686-4e3d-82cd-bf83b9eaa12732253.jpg	布罗代尔是法国年鉴学派第二代代表人物，他关于治史理论与方法的论述曾先后两次以法文精选结集出版，本书是对其中第二部的移译，由视野各异的几篇文章组成。在书中，我们不仅可以看到布罗代尔投身历史学研究、结识年鉴学派学人的人生轨迹，看到他尤以长时段、整体性的社会经济史研究而闻名的治史特色，也能看到他在研究取径上丰富的包容性：书中收入的关于查理五世和菲利普二世的两篇传记显示出作者对于事件史和人物研究的兴趣。由此我们得以窥见布罗代尔作为一名史家广泛的好奇心和求索欲，更加多面地了解他的思想和人生。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	493
320	从辅助教学到重塑生态——教育信息化发展之路	9787567577121	\N	顾小清等著，袁振国编 	平装	1-1	16开	78.00	\N	华东师范大学出版社	\N	\N	\N	2018-07-01	/book/995fd503-1638-4393-bca9-59886a49b1201073134.png	改革开放40年来，教育信息化经历了从辅助教学到重塑教育生态的变革之路，经历了五个关键时期：政策驱动下的计算机教育（1978-1998）、面向新世纪的教育振兴行动（1999-2007）、走入基础教育的校校通工程建设（2000-2012）、追求均衡的班班通工程推进（2012-2015）、走向融合创新的人人通工程深化（2012-2016）。资源、网络、应用、产业、人才、法规则构成了中国教育信息化发展的六个关键要素。 改革开放40年来，在教育信息化政策的引导以及技术进步的双重推动下，我国的教育信息化经历了“计算机要从娃娃抓起”，“迎接21世纪的教育振兴行动”，“校校通”，“班班通”，以及“人人通”的发展历程，形成了凸显中国特色的教育信息化发展之路，体现出教育技术从辅助教学到重塑教育生态的变革之势。 政策驱动下的计算机教育（1978-1998）、面向新世纪的教育振兴行动期（1999-2007）、走入基础教育的校校通工程建设期（2000-2012）、追求均衡的班班通工程推进期（2012-2015）、走向融合创新的人人通工程深化期（2012-2016）。而从建设内容角度审视每一个阶段内的教育信息化内涵，在资源、网络、应用、产业、人才、法规六个关键要素上，足以刻画四十年来的教育信息化全景图。 适应性、个性化、基于位置的学习等新形态或将成为人们应对挑战的落脚点，伴随着计算机的识别与理解能力不断提升，深度学习的广泛应用，脑认知与脑增强的进一步强化，一个新的链接网络呼之欲出，这其中将产生难以想象的互动与联系，将从根本上改变人类的生活、学习方式，最大程度释放教育的潜能，彰显自由与个性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	375
321	从高度集中到放管结合——高等教育变革之路	9787567577084	\N	荀渊、刘信阳著 	平装	1-1	16开	68.00	\N	华东师范大学出版社	\N	\N	\N	2018-08-01	/book/3dfbd0ac-908d-4737-beca-a3d40c8aaf681073137.png	改革开放40年来，为建立与社会主义市场经济体制相适应的高等教育体系与制度，体制改革始终是高等教育改革发展的重中之重，逐步形成了中央政府放管结合、省级政府统筹为主和高校自主办学相结合的现代教育体制。与之伴随的是政府管理高等教育方式的变革，政府通过立法、评估、监督等手段进行宏观管理；高等学校办学法人地位得以确立，积极推进以高校章程为核心的现代大学制度建设，推进高校治理体系与治理能力的现代化。 改革开放40年来，体制改革始终是高等教育改革发展的一条主线。改变中央高度集中的管理体制，通过多种形式的权力下放，持续扩大省级政府的管理权限和高校的办学自主权，逐步形成了中央政府放管结合、省级政府统筹为主和高校自主办学相结合的新体制。与之伴随的是政府管理高等教育方式的变革，强调政府的宏观管理和通过立法、评估、监督等手段的间接管理；高等学校办学法人地位得以确立，积极推进以高校章程为核心的现代大学制度建设，推进高校治理体系域治理能力的现代化。 改革开放之初，高等教育体制改革的重点是恢复、重建文革前“统一领导、分级管理”的高等教育管理体制，在中央与地方高等教育权限和扩大高校办学自主权上做了初步的探索。1985年全面启动了高等教育体制改革的宏伟进程，开始推行中央、省（自治区、直辖市）、中心城市三级办学体制，逐步扩大了省级政府的高等教育管理权限和高校办学自主权，并开始在全国试点高校校长负责制。1993年至1999年间，确立了中央与省（自治区、直辖市）分级管理、分级负责的管理体制，进一步扩大高等学校的办学自主权，逐步确立和全面实施党委领导下的校长负责制。1999年至2010年间，以《高等教育法》的实施为标志，确立了中央和省级人民政府两级管理、以省级人民政府管理为主的新体制，对高校的法人地位作出了明确的规定，对高校的办学自主权进行了详细说明。2010年至今，深入推进管办评分离、扩大省级政府教育统筹权，以行政审批权下发为抓手突出地方政府对高校的统筹管理，强调在高等教育管理过程中的管办评分离与放管服结合，高校办学自主权进一步扩大，初步构建起了以章程建设与实施为核心的现代大学制度，确立了高校面向社会自主办学的基本格局。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	616
322	高考英语外刊阅读及模拟强化训练2	9787521322095	\N	外研基础测评中心 	平装	1-1	16开	49.00	\N	外语教学与研究出版社	\N	\N	\N	2021-08-01	/book/7f966147-3ff5-4a61-83e7-d06d06e513d61073144.png	“高考英语前沿备考系列丛书”由外研基础测评中心策划、一线教学名师及教研员共同编写而成。丛书内容高度贴合高考考查要求，同时也融入了丰富多彩的教学活动设计元素，能够有效满足高中英语课堂教学需要。《高考英语外刊阅读及模拟强化训练1》是该系列丛书的册，不仅适用于高三学生进行备考冲刺，亦能帮助高中低年级学生有效提升读写及思维等关键能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	996
323	科技英语论文阅读与写作	978-7-5689-2217-3	\N	陈臻林 胡潇 	\N	1-1	16开	29.00	236.0千字	重庆大学出版社	126	\N	\N	2020-11-29	/book/d42d2d9e-1949-42f6-9a2a-bd91c57654fc92217.jpg	本教材旨在提高学生科技英语论文的阅读理解能力和综合分析能力，使其熟悉科技词汇、了解科技论文的文体结构，培养其科技英语读、写、译的能力。教材共分10个单元，每个单元包括阅读、语法和翻译3个部分，内容涵盖科技论文写作的基本格式、常用语法、常见错误及修改方法。教材中第1、2单元简要介绍科技论文的基本特点、阅读要点和写作技巧；第3至第8单元，分别从科技论文写作中的空间描述、时间顺序和逻辑关系等方面进一步介绍常见科技英语论文的阅读方法和写作技巧；第9和第10单元分别介绍留学申请的注意事项和科技论文摘要的基本写法。 本教材适合作为土木工程、工程力学、地质工程、岩土与地下工程等相关理工类专业的本科生和研究生的教学及参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	186
324	文博旅游学	978-7-5689-2458-0	\N	雷若欣 张方军 	\N	1-1	16开	58.00	320.0千字	重庆大学出版社	225	\N	\N	2020-10-19	/book/0562fbb4-a0cb-47d5-bb6a-54b421c03b9f92458.jpg	本教材依托安徽省省级重大线上教学改革研究项目“线上‘共生式’课堂的建构路径与实施效果评价研究”、安徽省省级精品线下开放课程“文博旅游学”等项目，以物质文化遗产和非物质文化遗产旅游资源为基（土壤），以博物馆外部空间到内部空间的延伸为线（树干），以博物馆管理内容为枝（枝节），大体采用了树形图的编写结构。每一章除主要内容以外，附以案例和知识拓展阅读，并以二维码形式导入了微课视频和各种教学资源，有助于提升学生知识的广度和深度。同时，教材搜集编入了国内外旅游学界的一些新理论，有助于学生更好地掌握学科相关的前沿理论，力求让学生做到学以致用、知行合一。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	665
325	瑜伽模块化教学教程	978-7-5689-2309-5	\N	胡娜 	\N	1-1	16开	39.80	270.0千字	重庆大学出版社	124	\N	\N	2020-08-26	/book/14aa08d0-93e0-4b0b-8b23-8a3be124db4492309.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	836
326	中职英语听说教程	978-7-5689-2549-5	\N	皮莉丽 雷静 	\N	1-1	16开	29.00	237.0千字	重庆大学出版社	110	\N	\N	2021-02-25	/book/0ac22f40-ed8e-47d7-bc34-eb5d05f1d90c92549.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	833
327	特殊儿童表达性艺术活动设计与指导	978-7-5689-1988-3	\N	周巧 李丹 谭雪莲 洪显利 	\N	1-1	16开	88.00	243.0千字	重庆大学出版社	212	\N	\N	2020-11-10	/book/4497b7c8-9d89-4e15-b1ef-9b13ed0ebc3b91988.jpg	本书综合地介绍了表达性艺术活动的设计和开展思路。分别从美术、音乐、戏剧、游戏四个方面，介绍了活动设计的原则和方法，并给出了生动范例。每个活动设计虽然所属类别不同，但是都秉持着同样的设计逻辑，即从儿童发展的七大领域分析深入。艺术活动的表达性特征和儿童的发展领域把不同的艺术门类有机结合在一起，各有特色又系统整合地展示了特殊儿童的活动设计。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	822
329	语料库在英语教学中的应用研究	978-7-5689-2031-5	\N	侯静 	\N	1-1	16开	48.00	106.0千字	重庆大学出版社	84	\N	\N	2019-12-17	/book/b94bae99-1078-4dd6-af2b-2a565a9975b592031.jpg	《语料库在英语教学中的应用研究》内容理论联系实际、重点突出。全书分五章，分别为绪论、语料库应用于英语教学的基本理论、语料库应用于英语教学的背景和实验方案、语料库在英语课堂教学中的实际应用、语料库在英语教学中应用的反思。 本书适合英语专业本科生、研究生阅读，也可作为语言学及应用语言学方向研究人员的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	582
335	网店装修（第3版）	978-7-5689-0146-8	\N	张文彬 	0	3-8	16开	49.00	250.0千字	重庆大学出版社	157	\N	\N	2021-01-07	/book/ea74fc79-8c82-4613-bccb-03a7b92a3a791073267.jpg	本书由讲授“网店装修”课程的一线教师编写，以实例的方式介绍网上店铺的装修操作。全书主要包括店铺开设、店铺图设计、网店首页装修、淘宝视频制作、详情页设计与制作、手机端淘宝店铺装修、综合案例制作等7个项目模块，全方位介绍了淘宝网店装修的流程、方法和技巧，使读者能够轻松、快速地设计出令人满意的店铺展示效果。 本书内容丰富全面，图文并茂，深入浅出，可作为职业院校电子商务、平面设计等专业以及计算机相关专业学生的教材，也可作为广大网商、网络从业人员、网上创业者的学习和参考用书，还可作为电子商务培训班的教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	761
336	漆艺教程(第2版)	978-7-5624-7096-0	\N	张丽 	0	2-8	16开	49.00	205.0千字	重庆大学出版社	133	\N	\N	2021-03-09	/book/ec4cd72f-9a30-47fb-b8ae-d348364729c21073269.png	　　本书强调理论与实践相结合,叙述了中国漆艺与外国漆艺的发展历程,以漆艺材料、漆艺工具与设备为制作条件,以掌握髹饰技法为制作基础,将漆器、漆画制作流程作为工作过程,通过循序渐进的章节设置,使学生明白漆艺的特殊性,了解漆艺的创作构思必须通过工艺过程和技术手段来实现,使之成为一本图文并茂、通俗易懂的现代漆艺教材。　　本书附有中外优秀精美的漆艺作品供大家学习、欣赏。本书可作为艺术类专业及其他相关专业的教材,也可作为相关艺术领域漆艺爱好者的教学参考书和自学用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	784
483	中国近代股份制企业研究	9787564200244	\N	朱荫贵 著 	平装	1-1	16开	58.00	\N	上海财经大学出版社	\N	\N	\N	2008-12-01	/book/09948bab-843b-4748-b220-64dd4bfb34d91074523.png	股份制企业这种资本组织形式引进中国后，其诞生发展进程是保持了原汁原味的西方形态，还是有所改变？换句话说，引进的西方股份制资本组织形式在中国的诞生发展是否打上了中国式的“烙印”？如果有，是什么，又是如何表现的？本书将为您解答这些问题！ 本书从中国近代股份制企业的几种类型、资金运行特点、经营管理中的不同类型等六个方面系统地探究了中国近代股份制企业的发展。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	863
337	建筑结构(第2版)	978-7-5624-8394-6	\N	张银会 黎洪光 	0	2-8	16开	59.00	573.0千字	重庆大学出版社	364	\N	\N	2021-01-28	/book/b0506257-0b9d-4bbe-84e4-fc46279517578394.jpg	本书是“高等职业教育建筑工程技术专业系列教材”之一。全书共11章，主要讲述了建筑结构基本计算原则、钢筋混凝土结构材料的力学性能、受弯构件承载力计算、受扭构件承载力计算、受压构件承载力计算、受拉构件承载力计算、钢筋混凝土梁板结构、多高层框架结构、钢筋混凝土结构施工图识读、砌体结构、钢结构。 本书内容系统、新颖实用，依据国家最新的技术标准和技术规范编写，可作为高等职业教育（职业本科、职业专科）建筑工程技术、工程监理、工程管理等土建类专业的专业教材，也可作为从事相关工作的技术和管理人员自学和参考使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	235
338	建筑结构抗震设计（第3版）	978-7-5689-2539-6	\N	李英民 杨溥 	\N	3-7	16开	39.00	370.0千字	重庆大学出版社	224	\N	\N	2021-01-27	/book/e31337f1-2336-4eed-a1e2-02d34cf5eae992539.jpg	建筑结构抗震设计是土木工程专业的一门重要课程。本教材是根据《建筑抗震设计规范》（GB 50011—2010，2016版）以及国家教育部大学本科新专业目录规定的土木工程专业培养要求编写的。全书共9章，分别为地震与抗震设防，地震动及其特性，结构地震作用及响应，建筑抗震设计与抗震计算，地基基础抗震设计，钢筋混凝土结构房屋抗震设计，砌体房屋抗震设计，多层和高层钢结构房屋抗震设计原则和步骤，以及结构控制的初步知识。 本书可作为土木工程专业本科建筑结构抗震设计课程的教材，也可以作为研究人员、设计和施工人员的学习参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	892
339	建筑工程测量(第2版)	978-7-5624-7792-1	\N	覃辉 	\N	2-8	16开	49.00	513.0千字	重庆大学出版社	313	\N	\N	2021-02-10	/book/53f40215-5d76-470d-a481-ed4282cef0ed7792.jpg	“建筑工程测量”课程是土建类专业的基础课程，是一门理论与实践相结合，但更侧重实践的课程，课程的实践能力主要体现在应用测量的基本原理、基本方法和测量仪器进行测、算、绘作业3个方面。本书在这3个方面都引入并介绍了成熟的先进技术，其中，测的重点是操作主流全站仪、数字水准仪与GNSS RTK，算的重点是应用随书光盘提供的工程编程机fx5800P程序进行现场快速计算，绘的重点是操作数字测图软件CASS进行数字测图及其数字地形图的应用，建筑物放样的重点是数字化放样方法等。 本书适用于土建类各专业使用，也可用于本行业施工技术人员的继续教育教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	364
340	企业新型学徒制焊工中级理论教程	978-7-5689-2356-9	\N	朱游兵 魏健东 	0	1-1	16开	49.00	352.0千字	重庆大学出版社	217	\N	\N	2021-04-26	/book/5808b0a1-35fa-4d00-91af-602b664f338f1073327.png	　　《企业新型学徒制焊工中级理论教程》详细地从焊前准备、各种焊接方法运用、焊接质量及焊接新技术等方面介绍了中级焊工需要掌握的相关理论知识，采用模块化教学，内容上力求体现“以职业活动为导向，以职业技能为核心”的指导思想，突出新型学徒制职业培训特色。 　　《企业新型学徒制焊工中级理论教程》定位为中级焊工职业技能培训理论教材，同时有实训教程与该书配套，适用于企业参加技能鉴定培训的人员自学使用，也可供焊接专业技校师生、从事焊接工作的技术人员阅读，是焊工职业技能培训与鉴定的辅导用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	449
341	化工工艺学（第五版）	978-7-5689-2395-8	\N	魏顺安 谭陆西 	\N	5-20	16开	63.00	727.0千字	重庆大学出版社	418	\N	\N	2021-05-15	/book/8b94f2c4-9db8-4990-ba3f-23ca060b3ec592395.jpg	本书是为适应高等院校化工类专业教学改革、拓宽专业面需要编写的一本新教材。其内容为合成氨、化学肥料、硫酸与硝酸、纯碱与烧碱、基本有机化工的主要产品、天然气化工、石油加工、煤的化学加工共8章。重点讲述基本原理和主要生产方法、工艺流程、主要设备及工艺计算。本书重点突出，具有一定深度，还注意引入了新技术和新资料。可帮助学生了解现代化工的全貌，并掌握一般过程和方法，有助于增强学生的业务发展和适应能力。 本书可作为高等院校化学工程与工艺专业教材，也可供化学和相关专业的化工工艺课程选用，还可供从事化工生产和设计的工程技术人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	752
342	BIM建筑工程计量与计价实训（湖北版）	978-7-5689-2621-8	\N	张西平 王晓青 	0	1-2	16开	59.00	557.0千字	重庆大学出版社	344	\N	\N	2021-05-21	/book/315d840f-e497-48a4-a0db-31e17acabf8a1073343.jpg	本书分为建筑工程计量和建筑工程计价上、下两篇。上篇详细介绍了如何识图，如何从清单定额和平法图集角度进行分析，确定算什么，如何算的问题；讲解了如何应用广联达ＢＩＭ 土建计量平台ＧＴＪ软件完成工程量的计算。下篇主要介绍了如何运用广联达云计价平台ＧＣＣＰ完成工程量清单计价的全过程并提供了报表实例。通过本书的学习，学生可以正确地掌握算量流程、组价流程和软件应用方法并能够独立完成工程量计算和清单计价。 本书可作为高校工程造价专业的实训教材，也可作为GIAC工程造价电算化应用技能认证考试教材，以及建筑工程技术、工程管理等专业的教学参考用书和岗位技能培训教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	782
343	罗马式艺术	978-7-5689-2414-6	\N	维多利亚·查尔斯 克劳斯·H.卡尔 编著 候海燕 译 	0	1-1	大32开	48.00	62.0千字	重庆大学出版社	103	\N	\N	2021-01-30	/book/76059964-cb81-482d-9be8-b0e933243e331073369.png	艺术史上，我们常用罗马式艺术一词来甄别11世纪初至12世纪末这段历史时期。该时期呈现出多样化的地域流派，这些流派有其各自独特的风格。无论是在雕塑还是在建筑中，罗马式艺术均体现出鲜明的粗犷的形式特征。本书以丰富的插图和极具魅力的文字，重申了罗马式艺术的重要性。书中讲到，当今，罗马式艺术总掩盖在后来的哥特式风格艺术光环之下。罗马式艺术是欧洲历史上，首个自成一体、独立统一的艺术风格。罗马式艺术吸收了古希腊美术成就，继承了埃特鲁斯坎艺术传统，而将艺术推向实用主义，在内容上侧重描绘享乐主义的世俗生活，在建筑形式上追求宏伟壮丽的风格，在人物表现上强调个性化。其突出成就主要反映在建筑、肖像雕刻、壁画和彩绘泥金稿本方面。本书作为一本普及读物，可以使读者快速掌握和了解罗马式艺术的精华，本书适用于想要了解罗马式艺术风格的读者。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	152
344	园林工程施工技术（第3版）	978-7-5624-7770-9	\N	李本鑫 史春凤 杨杰峰 	\N	3-5	16开	53.00	537.0千字	重庆大学出版社	334	\N	\N	2021-07-13	/book/601bdfd5-6d5b-4c13-afa0-e7ef4bf0664d7770.jpg	本教材是高等职业教育园林类专业系列教材之一，是根据工学结合的目标和要求，以园林工程施工技术能力的培养为主线，从园林工程施工员的岗位分析入手，针对园林工程市场的需求，结合职业教育的发展趋势，系统地阐述了土方工程、给排水工程、建筑小品工程、水景工程、园路工程、假山工程、种植工程、景观照明工程等方面的内容。在理论上重点突出实践技能所需要的理论基础，在实践上突出了技能训练与生产实际的“零距离”结合。做到了图文并茂，内容翔实，南北兼顾。本书配有电子教案，可扫描封底二维码查看，并在电脑上进入重庆大学出版社官网下载。 本书可作为高等职业院校、高等专科院校、成人高校、民办高校及本科院校举办的二级职业技术学院园林类、园林工程等专业使用，也可以作为相关专业相关课程的教学参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	390
345	维特根斯坦：关键概念	978-7-5689-2599-0	\N	凯利·迪恩·乔利 著 张晓川 译 	\N	1-1	大32开	52.00	248.0千字	重庆大学出版社	285	\N	\N	2021-06-18	/book/fe13e3a7-cb04-4d17-94ab-b34f0402d41392599.jpg	本书详尽地论述了贯穿维特根斯坦哲学生涯的各个关键概念：意义与用法、游戏语言、家族相似、平常/日常语言、遵从规则、思维与理解、心理主义、摩尔悖论、面向感知、哲学治疗、语法研究、表达与宣示，等等。学界通常认为，维特根斯坦最著名的两本著作《逻辑哲学论》和《哲学研究》之间具有某种断裂性，这种断裂揭示了他本人哲学取向和进路的根本转变——从实证主义到日常语言哲学的转变。而本书的多数撰稿者则拒斥了这一非连续性的解读思路，且没有将论述局限于这两本著作，而是采取了与之相反的连续性解读的立场，尝试完整、连贯地呈现维特根斯坦对各个主题的总体思考。就此而言，本书为读者提供了一个鸟瞰维特根斯坦哲学的绝佳视点。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	644
347	有诈：5000年来的谎言、伪造与谣传	978-7-5689-2566-2	\N	伊恩·塔特索尔 彼得·内夫罗蒙特 著 王寅军 译 	\N	1-1	16开	89.00	301.0千字	重庆大学出版社	299	\N	\N	2021-08-02	/book/39866b9d-a2c9-425a-9d1c-afed37f6914292566.jpg	《有诈》讲述了人类历史5000年来的知名骗局，同时配以大量珍贵图片，有图有真相……吗？	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	830
348	溪流的神秘居民——哈佛博士蝾螈寻访记	978-7-5689-2582-2	\N	吴耘珂 	\N	1-1	16开	68.00	181.0千字	重庆大学出版社	196	\N	\N	2021-06-25	/book/fdd5edb6-2b5a-406f-ae4c-498002a85b0692582.jpg	作者通过回忆的方式，真实详细地记录了自己十余年前初出茅庐时的野外考察经历。什么是蝾螈？为什么要寻找蝾螈？在哪儿才能找到蝾螈？这些问题在书中都能得到答案。广西大瑶山、浙江天目山、福建武夷山、江西军峰山、湖南莽山……作者的脚步遍布华南地区重峦叠嶂的名山。作者在记录的同时，又附上所见所闻的各种动植物的精彩描写及知识介绍，更有许多精美的物种照片与生态照片，使本书同时具有科研与科普的价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	873
349	图利的猫：史上最著名的116个思想悖论	978-7-5689-1467-3	\N	佩格·蒂特尔 著 李思逸 译 	平装	1-1	大32开	49.00	167.0千字	重庆大学出版社	201	\N	\N	2021-07-13	/book/8611348a-d5cb-46c9-a83a-beb781ee6d9391467.jpg	《图利的猫：史上最著名的116个思想悖论》是一本思想悖论通俗读本。作者以简练的语言介绍了悖论的提出者、命题、逻辑推理方式、核心论点和矛盾之处等，涉及的思想悖论类型包括形而上学、精神哲学、身份认同、语言哲学、逻辑学、伦理学、美学等，这些思想悖论及其衍生或流变的问题吸引了众多思想家和学者的关注，提出了别开生面的不俗见解，促进了现代逻辑学、哲学、物理学等的发展，对这些思想悖论的思考和分析也能触发阅读者的求知探索欲和创造性思维。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	190
359	线上线下混合式运动人体科学实验指导	9787564381691	\N	杨赳赳, 张劲松, 肖俊, 主编 	0	1-1	16开	48.00	393.0千字	西南交通大学出版社	252	\N	\N	2021-07-01	/book/7e0b270e-d8d2-49af-8185-d0bb6c9e9f041073552.jpg	本书是高等院校体育专业“运动人体科学”课程的实验教材，主要介绍了线上线下混合式运动人体科学实验课的基本方法与要求，具体涵盖运动解剖学实验、运动生理学实验、健康教育学实验、体育心理学实验、体育保健学实验、运动防护实验、体育测量与评价实验、红十字救护实验等。本书的每个实验指导均分为线上学习指导和线下学习指导两部分，是对课程教学的创新，同时在教材中融入了实验教学视频、PPT、作业库、题库等，还在每个实验中融入案例，充分挖掘课程思政元素，使学生在掌握操作技能的同时得到思想教育。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	549
360	高速铁路动车组运用与管理（第2版）	9787564381288	\N	时蕾, 石高山, 主编 	0	2-5	16开	48.00	439.0千字	西南交通大学出版社	284	\N	\N	2021-07-01	/book/157c2b5f-2aa1-4314-8875-037d86750d641073558.jpg	“高速铁路动车组运用与管理”是高职专院校动车组检修技术的核心课程。本书为高等职业教育动车组检修技术专业教材，主要针对高速动车组运用管理、运用维修、动车组应急故障处置等方面的内容进行了详细的介绍。本书针对职业教育特点及学生认知规律，为保证教材内容与现场发展同步，邀请郑州动车段及郑州铁路集团有限公司车辆处专家共同参与编写，并配套丰富的数字化信息资源，将知识点与能力点有机结合，注重培养学生的应用能力和解决现场实际问题的能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	907
352	文献检索与毕业论文写作（第二版）	9787560661179	\N	张言彩 	0	2-9	16开	33.00	200.0千字	西安电子科技大学出版社	184	5606	13	2021-08-17	/book/ba4167ff-3d54-4a28-8301-be9cdf388bc51073495.png	本书在编写过程中，吸收了国内外文献检索和科技论文写作理论与实务的研究成果，系统地说明了文献信息检索基础知识和基本技能，从学术研究与毕业论文兼具的视角介绍了各种文献的特点与分布、一些常用文献检索工具的编排组织规则和使用方法以及电子资源检索技术。本书分为两大部分：第一部分为文献检索的理论与实践，对国内外常用的经典中外文文献数据库、引文数据库、全文数据库的特点和检索技能进行了详细介绍；第二部分为毕业论文写作，介绍了毕业论文写作的基本知识，论文写作的要求和技巧，论文的选题、撰写、修改和答辩，学术不端行为的内涵及防范等方面的知识。 本书适合高等院校本科生、研究生及教师使用，也可以作为相关研究人员以及企业经营管理者的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	731
353	密码技术应用与实践	9787560660752	\N	张敏情 	\N	1-1	16开	45.00	420.0千字	西安电子科技大学出版社	284	5606	10	2021-08-18	/book/293067ea-deb4-4ee4-b063-aca7f0c43d9f9787560660752.jpg	全书分为5章。第1章为密码算法基本应用实践，介绍基于Pycryptodome密码函数库的对称加密算法、公钥加密算法、哈希算法的基本应用；第2章为密码学扩展应用实践，主要讲解使用常见密码库完成文件的加解密、签名传输，实现HTTPS的交互过程，进一步实现密码学在工程实践中的应用；第3章为PKI应用与实践，主要介绍基于Windows Server建立PKI体系，并介绍了其配置和综合防护应用；第4章为常见加密工具应用实践，主要介绍PGP、Gnu PG、VeraCrypt等常见工具的使用；第5章为加密技术创新综合实践，主要结合区块链、云计算、移动终端等场景，介绍密码算法的创新应用实践。 本书可作为高等学校密码学、网络空间安全或相关专业的密码实践指导性教材，也可作为信息安全工程人员的实践参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	452
354	C语言程序设计立体化教程练习册	9787560661490	\N	廖智蓉 	0	1-1	16开	26.00	204.0千字	西安电子科技大学出版社	140	5606	20	2021-08-23	/book/b31642e2-ba67-4651-b4b6-56304d7a349f1073503.png	本书是《C语言程序设计立体化教程》(廖智蓉主编，西安电子科技大学出版社出版)的配套练习册。本书共两篇：基础知识篇和实战篇。基础知识篇中设置了主教材中各项目的知识要点和习题；实战篇中设置了上机考试题和笔试模拟题，内容全面覆盖了“全国计算机等级考试二级C语言程序设计考试大纲”的知识点。附录中提供了各项目习题及上机考试题、笔试模拟题的参考答案，以便读者检测知识点的掌握情况。另外，本书配备了部分上机考试题的讲解视频，读者可以通过扫描二维码的方式获取视频资源，从而进行反复学习。 本书可作为高职高专院校计算机类及相关专业学生的C语言程序设计练习册，也可作为计算机二级考试的复习资料。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	876
355	高等数学（上）	9787564381738	\N	吴琦, 主编 	0	1-1	16开	48.00	405.0千字	西南交通大学出版社	260	\N	\N	2021-07-01	/book/da717518-dc45-4541-8270-a7499b94e0621073527.jpg	本书为本科院校基础课程的教材，主要内容包括：一元函数的极限与连续，一元函数微分学，微分中值定理与导数应用，不定积分，定积分，微分方程。本书注重数学思想的渗透以及数学方法的介绍，注重数学的应用和数学建模能力的培养，章节安排的例题与练习题能帮助学生巩固所学知识并检测学习情况。该教材作此次出版是在作者已使用多年的《高等数学》教材的基础上进行修订的。该书稿结构完整、层次清晰，适合高等院校的师生们学习使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	750
356	模拟电子技术基础	9787564380489	\N	钟化兰, 周霞, 主编 	0	1-1	16开	58.00	486.0千字	西南交通大学出版社	312	\N	\N	2021-05-01	/book/c851ac69-d69b-4d01-8896-f729012074981073536.jpg	本书为高等学校电气信息类专业“模拟电子技术基础” 课程的教材，按照教育部高等学校工科电工电子基础课程教学指导分委员会关于模拟电子技术课程教学的基本要求，结合教学实践编写而成。全书共分为十章，内容包括：绪论、半导体二极管及其基本电路、双极型晶体管及放大电路基础、场效应管及其放大电路、功率放大电路、集成运算放大电路、放大电路的频率响应、放大电路中的反馈、信号的运算与处理电路、波形发生与信号转换电路、直流稳压电源。本书也可供其他相关专业选用和从事电子技术工作的工程技术人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	168
1332	医生和您说说“心”里话	978-7-5645-7879-4	\N	董建增 	0	1-1	小16开	49.00	240.0千字	郑州大学出版社	195	\N	\N	2021-11-01	/book/fa51119e-bf24-4509-ab47-abb3084bd8d11082289.jpg	本书内容包括心血管领域的基础知识、疾病知识、药物及其它治疗手段。重点强调心血管疾病的预防、诊疗和康复。全书共分十二章，包括心脏基础篇、冠心病篇、心律失常篇、心力衰竭篇、心肌病篇、心肌炎篇、高脂血症篇、先天性心脏病篇、肺动脉高压篇、结构性心脏病篇、猝死篇和药物治疗篇。本书通俗易懂，适用于提高人民群众对心血管知识的认知水准和保健水平。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	312
357	体验与润泽的旅程——高中班级文化一体化建设的实践探索	9787564381509	\N	陈默, 陈家武, 主编 	0	1-1	16开	60.00	199.0千字	西南交通大学出版社	228	\N	\N	2021-07-01	/book/5c5c22dc-573d-4073-a607-cb6274ce54831073545.jpg	班级文化是以班级为载体，师生在学习生活中所形成的价值观念、行为法则的总和。班级文化具有个体与集体的整合性，兼顾意识和行为，对于引领青春期学生的成长具有重要意义。本书基于主体性原则和发展性原则，建设班级物质文化、制度文化、行为文化和精神文化，用班级文化建设产生的凝聚、导向、驱动、规范、陶冶五大效能来实现班级管理的三重变化，收获教育的成和幸福感。本书探讨变传统的班主任管理方式为学生“自治”，变守、堵、压为疏、导、用，以文化熏陶实现潜移默化的班级管理的方法，旨在助力教师转变教育理念，创新职业生活，让学生收获美丽成长，学会学习，学会生活。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	880
358	图像特征检测的偏微分方程方法及应用	9787564380212	\N	李梦, 詹毅, 邹黎敏, 著 	0	1-1	16开	68.00	250.0千字	西南交通大学出版社	216	\N	\N	2021-04-01	/book/c25cd96a-fe02-4c26-a889-ca76ce3c75be1073549.png	随着互联网的快速发展，伴随着智能化、数字化和网络化的快速发展，图像已成为重要信息载体被广泛用于卫星系统、科学试验、系统监测、数字图书馆、生物医学和地理信息系统等，越来越多的重要信息通过图像来描述。因此，提取图像重要特征信息，去掉图像冗余信息，这在实际应用中就显得尤为重要。本书阐述了图像特征检测的偏微分方程方法，根据数学理论建立偏微分方程模型去输出图像的重要特征信息或者刻画图像的边缘特征，其研究结果可应用于海量图像精确检索，红外目标准确追踪、定位，医学肿瘤自动分析，以及指纹识别、虹膜识别等领域，为图像更深层次的理解提供更为广泛的应用前景。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	700
361	高等数学（上、下册）	9787564381097	\N	潘小东, 冯颖, 编 	0	1-1	16开	87.00	901.0千字	西南交通大学出版社	\N	\N	\N	2021-06-01	/book/ca77e27e-abf9-4c57-b1eb-f75157785a521073562.jpg	本书为大学本科理工科专业公共基础课教材，分上、下两册。上册共8章，内容包括函数与极限、导数与微分、微分中值定理与导数的应用、不定积分、定积分及其应用、微分方程等内容；下册共5章，内容包括向量代数与空间解析几何、多元函数的微分学、二重积分与三重积分、曲线积分与曲面积分以及无穷级数等内容。本书的内容在深度和广度上符合“理工科类本科数学基础课程教学基本要求”，适合高等院校理工科类本科“高等数学”课程选用，也可供其他相关专业选用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	707
362	宏观经济学（英文版·第九版）	978-7-300-29754-5	\N	安德鲁·B.亚伯 ；本·S.伯南克；迪安̶ 	0	1-1	0	99.00	1000.0千字	中国人民大学出版社	\N	2020F0298	\N	2021-08-31	/book/b71ed85a-0fbf-44ec-83ce-4ff5d3017a9b1073718.jpg	本书是英文影印版本，以核心的经济思想为基础，在统一的理论框架下，全面、透彻地论述了长期经济增长、经济周期和宏观经济政策。在内容上，除了涵盖传统的宏观经济学教学内容外，本书还纳入了长期经济增长和世界经济一体化等方面的新进展以及近年的房地产和金融市场危机等方面的内容。此外，本书还大量引用近期的经济现象，对各国的财政和金融政策进行了分析和比较，深入浅出地阐述了宏观经济学基本理论及其在实践中的运用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	786
363	足球运动与训练生理学（足球体能训练丛书3）	9787500960218	9787500960218	（丹）延斯.邦斯博 	0	\N	16开	68.00	219.0千字	人民体育出版社	188	\N	10	2021-07-01	/book/cbca0f61-d816-4f0a-8780-8cf9363def131073737.jpg	本书共分为12章，主要对体育运动和足球专项体能训练的生理学研究与知识进行了详细的阐述。通过大量的科学研究对于运动过程中的有氧供能，无氧供能，呼吸，循环系统，血液的构成及肌纤维类型等方面的内容进行了研究和论证，从而引申到在运动训练及足球训练中应该注意哪些要素，并为运动训练过程中原则的把握，计划的制定，训练的监控提供了科学依据与理论参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	349
364	基于机载LiDAR点云的建筑物语义化三维重建技术研究	978-7-307-22406-3	\N	王庆栋、孙钰珊、许彪、艾海滨、张力 著 	平装	1-1	16开	36.00	\N	武汉大学出版社	\N	\N	\N	2021-08-01	/book/6ab6e423-a72b-44bd-9ba5-cdc9d796d5701073743.jpg	本书共七章，第一章绪论，是在分析前人工作的基础上，确定并分析了目前建筑物重建技术中普遍存在的问题和局限性；第二章建筑物语义三维建模框架研究，本章以机载LiDAR数据为数据源，针对机载LiDAR数据的特点并结合模型驱动建模思想，提出基于语义建模框架的自动化三维重建流程；第三章机载LiDAR点云建筑物检测，本章对机载LiDAR技术以及建筑点云分类与分割等方法进行了简单介绍；第四章基于点云的建筑物语义信息提取，着重介绍点云预处理和建筑语义特征识别；第五章基于语义信息的建筑物三维重建，着重对流程中语义信息转换和XBML解析器的设计进行详细介绍；第六章实验与分析，主要通过四组实验对前文所提出的方法进行验证和比较；第七章结论与展望，主要是对本书研究进行总结，对可以继续深入研究的方面进行展望。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	451
365	家庭与法律	978-7-307-22322-6	\N	张荣丽、刘永廷 等 著 	平装	1-1	16开	49.00	\N	武汉大学出版社	\N	\N	\N	2021-08-01	/book/ac074119-864e-4d4e-a1ae-c42bbe2593501073750.jpg	本书分为四部分，第一章、第二章介绍了家庭的概念、功能、中外国家和地区的家庭政策、家庭的发展历史及家庭未来发展的走向等基本内容；第二部分是第三章到第六章，围绕日常生活中家庭成员对法律知识的需求，从婚姻家庭、财产、住房、继承等方面结合法律规定作了详细的论述；第三部分是第七章到第十章，结合国家颁布的专项法律，介绍了妇女、未成年人、老年人、残疾人等弱势群体依法享有各项重要权益；第四部分是第十一章到第十三章，对家庭的救助和维权内容。本书注重理论联系实际，在各部分内容中还穿插着一些真实案例，举案说法，将法律带入家门。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	323
402	字腔字冲：16世纪铸字到现代字体设计	978-7-301-32194-2	9787301321942	弗雷德·斯迈尔斯 	\N	1-1	16开	86.00	203.0千字	北京大学出版社	264	7301	\N	2021-08-13	/book/4feca98b-f49b-460b-a298-6e0219d3bc9f32194.jpg	西方的文字设计仍然由西式活版印刷发明最初一百年中设计的字体主导。这些字形背后有着什么样的工艺流程？《字腔字冲：16世纪铸字到现代字体设计》聚焦于16世纪法国和佛兰芒的字冲雕刻师的工作。作者弗雷德?斯迈尔斯是字体设计领域的专家，他基于在铸字方面的经验和对现存资料的认真研究，揭开了这个尘封已久的话题。斯迈尔斯通过概述字母和字体设计的基本问题引入论述，并在最后几章观照了当前的技术和社会发展。本书可以被用作任何媒介中字体和字库建构的指南。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	634
366	医学伦理学	978-7-307-22465-0	\N	郑文清、周宏菊 主编 	平装	1-1	16开	49.50	\N	武汉大学出版社	\N	\N	\N	2021-08-01	/book/87928522-6b02-4879-a04d-e88c3c0001251073752.jpg	为了满足在校的医药大学生医学伦理学学习与教学的实际需要，适应我国国家职业医师资格考试的要求，由大学医学伦理学教学与科研人员组织编写本教材，该教材是在《现代医学伦理学概论》（2017年版）的基础上，根据社会的发展与教学、科研的需要进行的重新修订。现代医学与技术的发，深刻地影响着人类社会、经济、文化、教育，也带来了人们道德、伦理、价值观的深刻变化。本书对广大医药卫生工作者和在校的医药大学生进行医学伦理教育，提高现代医学伦理道德的敏感度，激发医学伦理学的学习兴趣，培育现代医伦理学的人文关怀精神，培养良好的职业道德素质，是医药卫生系统加强社会主义精神文明建设，培育社会主义核心价值观的重要内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	337
367	读懂深圳——四十年四十个视点	9787306069184	\N	吴俊忠、高洵 编 	平装	1-1	16开	59.00	\N	中山大学出版社	\N	\N	\N	2020-08-01	/book/de8aa8d5-85fb-4e70-96de-402b04885df21073768.png	本书是全面反映深圳特区改革创新与经济社会发展的文化读本，通过四十个不同视点，对深圳特区创办、特区精神、文化创新、产业体系、深港合作、前海新区开发、智慧城市建设等进行了系统的阐述和梳理，揭示了“深圳奇迹”创造之原因，展现出深圳从先行先试到先行示范的历史沿革和历史使命。这“四十个视点”，撷取深圳某个代表性的象征物展拓开来，讲述背后的故事，娓娓道来。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	455
1428	建筑工程计量与计价——透过案例学造价(第2版)	978-7-301-23852-3	9787301238523	"张强,易红霞" 	\N	2	16开	59.00	752.0千字	北京大学出版社	516	7301	\N	\N	/book/3ff4c531-02be-48a3-95f2-6381d76aefca2385203.jpg	本书主要内容包括： 建筑工程造价基本知识， 建筑工程定额，建筑安装工程造价，建筑面积计算，建筑工程定额计价模式， 装饰装修工程定额计价模式等。本书可作为高职院校建筑工程类、工程造价管理类专业及相关专业的教材，也可作为成人教育以及相关职业岗位的培训教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	126
675	巍巍嵯峨	9787561392287	\N	暮千雪 	平装	1-1	16开	68.00	\N	陕西师范大学出版总社	\N	\N	\N	2018-06-01	/book/d24fd75f-3c69-4f0c-9a63-d3e8bad03db81077495.png	　　西安事变后，红军南下关中，于1937年8月在泾阳县云阳镇紧急改编为八路军，东渡黄河奔赴抗日前线。继之，中央团校的前身，被誉为“抗日青年的旗帜，革命青年的熔炉，中国青运史上的丰碑”的安吴青训班在云阳镇安吴村轰轰烈烈地开办……作品通过讲述嵯峨山下军民联手抗敌的革命历史，弘扬我党自力更生、艰苦奋斗的精神。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	289
369	闪光的日子	9787567028050	\N	青岛市崂山区教育和体育局 编 	平装	1-1	16开	39.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2021-08-01	/book/7a8c5dde-e5c9-428e-a595-5a77dff844201073779.png	　　《闪光的日子》为一本教育文集，分为班主任管理、教育叙事、主题班队会三个部分，汇集了青岛市崂山区中小学教师的教育故事、教学心得等。中小学阶段为学生成长的关键阶段，对于学生性格与学习习惯的形成有着较大的影响。而中小学班主任作为班级的关键管理者，其管理工作的优劣直接的关系到学生的各个方面。本书从班主任工作的本位入手，找出班主任“该”做的事，为班主任提供一条有效的带班之路。本书对于新教师、班主任等从事教育行业的人具有重要的借鉴意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	732
370	爱在路上	9787567028432	\N	赵宏亮、孙洪锐 	平装	1-1	16开	50.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2021-08-01	/book/dea8fbd6-1fa8-421a-ba01-f2196ac242301073780.png	　　名班主任工作室成长纪实。共分启程篇、成长篇、抗疫篇和家校共育篇四个部分，主要记录了中职名班主任工作室从组建到成长过程中的点点滴滴；本书内容充分体现了德育的核心和灵魂——爱与责任；工作室立足于中职学校班主任工作的特点和焦点，针对德育工作中的特殊问题确立工作室的目标和方向，制定了行之有效的策略和方案，尤其是以案例解读的方式，为有效开展家校共育，为工作室的建设和班主任的发展打开思路，提供了建设性意见和模式，适合广大教师阅读。对进一步促进我国教育事业的发展必将起到十分积极的作用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	135
371	民法原理与实务：人格权	978-7-5764-0076-2	\N	袁志丽 朱萍萍 	平装	1-1	16开	59.00	\N	中国政法大学出版社	\N	\N	\N	2021-08-01	/book/7c2ebe0c-95f8-4aa7-8761-5dcc41251d271073786.png	人格权、婚姻家庭、继承编是《民法典》的重要组成部分，是与人们的日常生活密切相关的应用性较强的高职法律类专业课程，同时又是一门实用性很强的社会科学。根据高职高专院校法律专业课程的特点，为了培养面向未来的法律应用型人才，增强学生的实践能力，更好地适应社会的最新发展，本书有的放矢，针对人格权、婚姻家庭、继承编的重点内容分别论述：第一编详细阐述了人格权的定义和保护，并分别对各重点的具体人格权详细展开论述；第二编详细介绍了结婚、离婚、收养等重要的家庭法制度，并对特殊区际婚姻家庭关系保持关注；第三编论述了继承的方式与遗产的处理。本书既按照实践项目分类，又设置了情境训练模块，力求有力提高高职高专院校法律专业课程的培养质量。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	877
372	花物语	9787302497370	\N	[日]寺田寅彦 著 解璞 译 	平装	1-1	16开	58.00	\N	清华大学出版社	\N	\N	\N	2021-07-01	/book/614b7dd7-0593-4058-b18e-6539b4792b531073789.jpg	　　本书收录寺田寅彦的十二篇经典作品，一花一物语，大多取材于作者少年时的真实经历，富于人情味。这些作品作为科学家的敏锐视角和作家的诗情雅致，蕴含着人生与宇宙的神秘与哲理，优美清新，隽永动人。每篇文章短小清丽，并穿插大量美图。尽管这些作品写于一百多年前，但历久弥新。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	501
373	高等数学	978-7-5482-4159-1	\N	王琼华，张丽萍主编 	平装	1-1	16开	42.00	360.0千字	云南大学出版社	225	\N	\N	2021-08-01	/book/29c5d827-24d3-430b-a9e8-905e78ca724e1073791.jpg	高等数学是高校理工类学生必须掌握的基本理论与知识，是高校理工类各专业的一门专业必修课。本书全面、系统地论述了高等数学的概念、方法、理论及其应用。全书共分6章，内容包括函数与复数、极限与连续、导数与微分、导数与微分的应用、不定积分、定积分及其应用几个部分。本书以应用为目的，以实用、够用为尺度，注重以实例引入知识点，并最终回归到数学应用思维，增强学生对数学知识的兴趣，培养他们的运用能力。全书结构完整，逻辑严密，材料翔实，具有一定理论水平。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	659
374	高等数学习题集	978-7-5482-4160-7	\N	沈栩竹, 洪银胜主编 	平装	1-1	16开	24.00	120.0千字	云南大学出版社	68	\N	\N	2021-08-01	/book/a3e8c24a-0ba0-45d6-a2a6-8ac6c45940641073792.jpg	高等数学是高校理工类学生必须掌握的基本理论与知识，是高校理工类各专业的一门专业必修课。本书是针对教材《高等数学》而编写的辅导书《高等数学习题册》。其目的是配合高等数学的教学使用，同时为学生自主学习时提供学习辅导和参考。本书按照配套教材的章节顺序，以节为单位进行编写。书中每节由知识点归纳、典型例题和同步训练三部分构成。全书共分6章，内容包括函数与复数、极限与连续、导数与微分、导数与微分的应用、不定积分、定积分及其应用几个部分。全书结构严谨、逻辑清晰、讲解简练，具有一定实用价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	105
376	鞋履设计与表达	9787566919281	\N	田玉晶 杨景裕 	平装	1-1	16开	49.00	\N	东华大学出版社	\N	\N	\N	2021-07-01	/book/a818b0d2-b744-43ec-8b7b-e4470267d7631073803.png	《鞋履设计与表达》是一本关于鞋履设计的专业书籍，以鞋履设计环节为主要对象，介绍了鞋履设计师需要了解的基础知识及基本的设计流程和方法，主要包括鞋履发展简史、鞋履设计基础、鞋履设计研究、鞋履设计构思、鞋履设计表达等板块，囊括了中西方鞋履发展简史、足部解剖学、鞋楦、鞋号、鞋履基本款式和设计、鞋履设计研究的要点和方法、鞋履设计表达的特点和要求等内容和分析，是上海市重点课程《鞋履设计与工艺》的配套教材之一。 本书在综合了多位鞋履设计专家实践经验的同时，提供了大量的设计案例及图片，揭示了鞋履设计的关键流程和方法，让初学者了解鞋履设计开发过程。本书是高等本科院校、鞋履设计师和钟情于鞋履设计人们的学习指南。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	499
377	中国科学技术通史Ⅴ:旧命维新	9787313142733	\N	江晓原 	平装	1-1	16开	720.00	\N	上海交通大学出版社	\N	\N	\N	2015-12-01	/book/4c5cb5d2-f2f7-47d3-bd00-48b81117ea351073808.png	本书是第一部既有高度学术价值、又能雅俗共赏的中国科学技术通史。本书汇聚中国科技史研究领域全国一流学者，撰写各自领域研究最精深的专题，以百科全书“大条目”形式的专题串联起来，展示中国科学技术史的历史全貌。全书上自远古，下迄当代，按照大致时间顺序分为五卷：《源远流长》、《经天纬地》、《正午时分》、《技进于道》、《旧命维新》。每卷按照大致的时间顺序设置大小不等的专题，每个专题都是中国科技史研究领域中的*研究成果和研究思想。全书共300多万字，包含天学、地学、农学、医学、物理学、化学、博物学等中国科技史所有学科，同时配备“名词简释”、“中西对照大事年表”，各卷末附全书总目录，方便检索使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	350
378	业财一体化实验教程	978-7-5669-1853-6	\N	沈爱荣 编著 	平装	1-1	16开	68.00	\N	东华大学出版社	\N	\N	\N	2020-12-01	/book/65b195ab-07bb-453b-b7b9-54c41714bac41073819.png	　　本书的主要内容包括：建立账套、基础信息设置、总账管理系统、薪资管理系统、固定资产管理系统、采购与应付款管理系统、销售与应收款管理系统、库存与存货核算系统、报表管理系统、预算与决策分析。以商贸企业购销存业务为主线，借助用友ERP-U8V10.1软件，将业务流程、财务流程、管理流程有机融合；配备立体化的教学资源，提供实验账套数据、微课视频方便教学。 　　本书以商贸企业为例将业财深度融合，有助于推动高职院校的业财一体化教学，也有助于提升企业现有财务人员和经营管理人员的业财融合的能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	857
379	机械原理学习指导及习题集（2版）	978-7-5669-1899-4	\N	孙志宏 主编 	平装	1-1	16开	42.00	\N	东华大学出版社	\N	\N	\N	2020-12-01	/book/9576872c-0bf8-4b3a-a9fc-2907b581ae131073820.png	本书是按照国家教学指导委员会颁布的《机械原理课程教学基本要求》,为帮助机械类、近机类本科学生和考研人员学习、复习而编写的。 其目的是使学生系统地掌握和巩固“机械原理”课程的基本内容,建立工程意识,能够综合运用机械原理的知识和方法解决工程应用中关于机构设计和分析的问题。 本书共八章,包括机构的组成和结构分析,平面机构的运动分析,机械中的摩擦、效率和自锁,机械的平衡,平面连杆机构及其设计,凸轮机构及其设计,齿轮机构及其设计和轮系及其设计。 每章由本章教学要求、基本概念、难点、例题和习题五个部分组成。 本书可作为工科院校机械类、近机类专业学生学习“机械原理”课程的辅助教材,报考研究生时的复习参考书,也可供教师及工程技术人员参考使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	223
380	国家教师发展报告（2019）	9787576011371	\N	李廷洲，吴晶，郅庭瑾 等 著，郅庭瑾 编 	平装	1-1	16开	58.00	\N	华东师范大学出版社	\N	\N	\N	2021-02-01	/book/d8046dd4-7bd0-49c1-8d2a-1b6673cf39d21073828.png	《国家教师发展报告（2019）》是华东师范大学国家教育宏观政策研究院团队基于多年研究积累形成的智库成果。报告致力于记录我国教师队伍建设历程，回应教师领域重要的学术和政策议题，总结区域改革发展经验，为教育决策、教育研究和教育实践提供参考。本年度以“教师职业吸引力”为主题，分析当前教师职业吸引力的基本形势，距离“令人羡慕的职业”目标的差距、短板及关键影响因素，并提出若干政策思路。报告还呈现了2019年度我国各级各类教育教师队伍建设的成就、进展和研究述评，以及对“三区三州”等典型地区教师队伍建设的政策举措做了深入分析。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	384
381	非洲现代史（上、下册）	9787576009705	\N	李安山 著 	平装	1-1	16开	188.00	\N	华东师范大学出版社	\N	\N	\N	2021-07-01	/book/0ff6ebb9-658c-4b6f-9e06-e21df8f11d0d1073837.png	立足中国视野，反思西方史观； 一部带有强烈问题意识、正当其时的非洲现代史。 史论结合，研判国内外现代非洲史研究得失； 详略得当，全面展现非洲大陆的现代化进程。 《非洲现代史》由非洲史权威学者李安山历时多年撰写而成，从政治、经济、文化、民族四个方面聚焦现代非洲，为中国理解非洲提供一套知识参照系。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	783
382	智慧之旅（上、下册）	9787576005141	\N	朱邦复 著 	平装	1-1	16开	128.00	\N	华东师范大学出版社	\N	\N	\N	2021-01-01	/book/41473384-1076-4cc8-ada5-7259ff496f0a1073840.png	　　人生有五道关隘，无一不是私心的防护堡垒，人生的意义就在于这些关隘的感受。说是生活的经历也罢，当作晋阶的考验亦然，真假虚实悉在其中。不论圣智俗愚，也不分六道轮回，任谁都必须亲身历险，世间清浊遂分。视诸业障也罢，循此善缘也可，渡尽五关，得斩六将，方见得康庄大道。 　　一关是由出生起到少年时期，此时身心尚未定型，幼稚嫩弱，完全在环境操控之下，是为人之“灾关”。灾关若未应验，或者因社会、亲人的百般呵护，将各种灾难以人为意志化除。则此人之成长已与现实脱节，等到身心成熟之后，再也不可能体认惊心动魄的悚栗。失去了相对的比较感受，人生将如囫囵吞枣，难以领略真正的幸福、美妙。 　　第二关则是青年时期的“情关”，此时正当性征甫现，两性间的自然诱因，步步导向必然的落点。美满的婚姻固是人生理想的终站，但人人只顾一己，交往激情，私密系心，古今中外又曾有几对无怨的佳偶？情之一关，宛如附骨之蛆，得之愈多，依之愈深。 　　第三关是独立自主后的中年，谋生养家，追求地位，唯钱是问，是为“财关”。钱财本为无主之物，朝三暮四，得失不过转瞬之间。更有甚者，钱少不足保证安全，钱多却又危险倍增，职是之故，难识其止。待走到钢索中央，进退不得，求财者往往是人为财缚，丧失自主。 　　随着经验的增进，财关之后，紧接着便是“权关”。这时人已至壮年，雄心勃勃，只知天上有天，却不顾人下有人。但得大权到手，便自以为万事由心，为所欲为。不幸权势人人觊觎，易攻而难守，人生顿成修罗战场，永无止境。 　　最后一关为“贪关”，人所得愈多，愈是难舍。尤其到了黄昏夕阳之际，余日无几，抓之唯恐不紧。 　　一方面要防人之图己，一方面又骇大限之到临，七情六欲，各味俱陈。人生至此，未悉所为何来？ 　　想要安然渡过五关，又期望一己超群脱俗，其难难尽，难于上青天。 　　《智慧之旅（套装上下册）》特以自传形式，详述作者对智慧认知之本末。读者若有机缘，得以从字里行间领悟到人生真谛，以之作为技术可以谋生。若有大德，空明返照，青苔处处，更不难超凡入圣。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	631
383	排污权交易理论与实践策略研究	978-7-307-21904-5	\N	蔡俊雄、刘哲 主编 	平装	1-1	16开	50.00	\N	武汉大学出版社	\N	\N	\N	2021-08-01	/book/1d4c2aeb-b60d-49a7-82f2-0e97f5577c471073847.jpg	《排污权交易理论与实践策略研究》本书对排污权交易法律制度的基本理论进行系统总结，了解排污权交易动态运行的法律机理；对全国成功开展排污权交易试点的省市经验进行实证研究，探讨排污权如何随着社会变化和经验积累而发展演化的，分析在当前排污权交易中面临的挑战；落脚于湖北省排污权交易制度实施现状，从进一步扩大交易范围、创新交易机制、激活二级交易市场等方面为探索湖北省排污权交易今后的发展路径。本书以我国的现实情况和条件为基础，借鉴发达国家的做法，对我国排污权交易的理论和实践做了探讨，并对我国开展相关交易、制定政策进行了研究。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	430
384	中国金融思想史	9787313089533	\N	姚遂　著 	平装	1-1	16开	532.95	\N	上海交通大学出版社	\N	\N	\N	2012-10-01	/book/07fc732a-5575-4dae-bdc6-51acdd9865a41073852.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	208
385	中国哲学简史	9787567567290	\N	郭齐勇 著 	平装	1-1	16开	68.00	\N	华东师范大学出版社	\N	\N	\N	2018-07-01	/book/75300dea-71f4-47bd-9862-0278808afcc11073854.png	本书由三部分组成： 上编《中国哲学简史》，由郭齐勇先生主编，欧阳祯人副主编，从中国哲学的起源，先秦两汉的发展，直到近现代的转型，全面地介绍了中国哲学的概貌和中国传统文化的智慧。 中编《国学智慧与中华复兴》，郭齐勇先生阐述了传统文化复兴与中国复兴的关系，传统儒释道智慧对立身处世、自我调适、应对工作与生活的价值。 下编《哲学经典选读》，由郭齐勇先生主编，选取从《周易》《老子》《论语》直到朱熹、等重要哲学家的经典文献，有详细注释和解读，读者通读本编可以了解原汁原味的中国古典哲学智慧。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	496
386	小学课本成语故事（一年级）	9787565148071	\N	丁俞斌 	平装	1-1	16开	25.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2021-07-01	/book/c836ff98-56ae-4e9c-b96f-84a84c6885c71073858.png	　　《小学语文课本中的成语故事》系列丛书搜罗了的小学语文教材中的成语，共选取苏教版、人教版现行小学语文课本中出现的成语条目1000余条，对其进行详细讲解，并对每个成语进行释义、标注典故，为重要的是讲解该成语的相关故事，一般即为该成语典故所呈现的故事，在此基础上呈现例句。 学生通过阅读一条成语，基本会对该成语的写法、读法、用法有一个全面的学习，尤其是通过通俗、易懂的成语故事的呈现， 会让学生学得有趣而深入。本书语言简洁明了，尽量切合小学生的阅读风格。故事按拼音排列，便于学生查检;故事后面注明与课本的链接，便于学生领会。通过阅读整本书，学生可以全面系统地学习整个年级语文课本中的成语。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	469
827	满族萨满女神面具	978-7-5692-5195-1	9787569251951	李秀云，主编 	\N	1-1	16开	118.00	\N	吉林大学出版社	\N	\N	\N	2019-07-01	/book/a193e2e2-fbff-46ff-955a-e43e8cfe1d5f978-7-5692-5195-1.jpg	本书以剪纸艺术表现“满族说部”中的女神形象，将口传史诗中的神话、传说、故事转化为视觉造型，阐释“满族说部”的文化内涵，让满族说部中蕴含的不屈不挠的民族精神，人与自然万物和谐相处的生态观念等等通过剪纸形象传达出来，以视觉形象讲述东北故事，使大众直观地认识辉煌灿烂的东北文化，增强文化自信。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	626
433	民法典让青少年有“德”	9787569705416	\N	张力 编 	平装	1-1	16开	20.00	\N	西南大学出版社	\N	\N	\N	2020-12-01	/book/9e07ed17-948d-4851-9ff7-293c85e027671074152.png	《民法典让青少年有“德”》分六篇讲述了民法基本原则：平等原则、自愿原则、公平原则、诚实信用原则、公序良俗原则和绿色原则。每一篇以一问一答的形式编写了与青少年息息相关的民法典知识，通俗易懂。《民法典让青少年有“德”》旨在让青少年有“德”：意思自治者，有选择自由，更要为自己的选择后果负责，方可证明其成年、自立；诚实守信者，创造放心不欺的交往（交易）环境，才可以有“朋友圈”；公平者，中庸容让，体恤弱小，舍得让利，促进长远共赢；公序良俗者，审时度势，顺势而为，保持公心，尊重传统。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	658
387	小学课本成语故事（二年级）	9787565148088	\N	丁俞斌 	平装	1-1	16开	30.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2021-06-01	/book/40b10aad-4aca-4ca1-b9b0-157bebad53791073859.png	《小学语文课本中的成语故事》系列丛书搜罗了近期新的小学语文教材中的成语，共选取苏教版、人教版现行小学语文课本中出现的成语条目1000余条，对其进行详细讲解，并对每个成语进行释义、标注典故，为重要的是讲解该成语的相关故事，一般即为该成语典故所呈现的故事，在此基础上呈现例句。 学生通过阅读一条成语，基本会对该成语的写法、读法、用法有一个全面的学习，尤其是通过通俗、易懂的成语故事的呈现， 会让学生学得有趣而深入。本书语言简洁明了，尽量切合小学生的阅读风格。故事按拼音排列，便于学生查检；故事后面注明与课本的链接，便于学生领会。通过阅读整本书，学生可以全面系统地学习整个年级语文课本中的成语。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	168
388	中国古代丝绸设计素材图系：绒毯卷	9787308182195	\N	赵丰 著 	平装	1-1	大16开	168.00	\N	浙江大学出版社	\N	\N	\N	2018-06-01	/book/d718dd2b-e6e6-4786-bbd8-4f483066e5141073865.png	绒是中国古代极具特色的一种丝织物，在基本的织物组织地上用杆织起绒或手工栽绒的方式起绒，表面比一般的丝织物多出一层绒面。这一特点使起绒织物从使用到外观都与其他织物有所不同。在中国丝绸发展历史中，杆起绒织物是出现时间较晚的一种织物形式，在元时才有关于绒的使用记载，至明清时期，绒织物被广泛地织造和使用。 因绒出现时间的特殊性，与之相关的实物资料大都是清代的传世品。本书汇集了美国大都会艺术博物馆、美国波士顿美术博物馆、英国维多利亚与艾伯特博物馆、加拿大皇家安大略博物馆、中国丝绸博物馆、北京故宫博物院、首都博物馆、北京艺术博物馆、南京博物院、江宁织造博物馆、苏州丝绸博物馆等多个博物馆的绒织物资料，对其纹样、组织结构进行了详细的研究总结，制作了大量表格；并对部分实物纹样进行矢量图的绘制，再挑选其中的83 幅汇编成册。希望本书可以在一定程度上展现绒织物的纹样特色，丰富中国传统织物的纹样宝库，为从事纺织品设计、艺术创作及艺术史研究的诸位提供参考资料。 本书为国家科技支撑计划课题“中国丝绸文物分析与设计素材再造关键技术研究与应用”的子课题“古代图像中的纹样信息提取与设计元素分析”的研究成果，并得到了上海市设计学IV类高峰学科“服饰文化历史与传承”研究团队的支持。 “中国古代丝绸设计素材图系”丛书总主编为中国丝绸博物馆馆长赵丰，本书作者为赵丰、苗荟萃。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	204
389	“一带一路”沿线国家法律精要	9787308172271	\N	王贵国,李鋈麟,梁美芬 主编 	平装	1-1	16开	88.00	\N	浙江大学出版社	\N	\N	\N	2017-12-01	/book/32cfa47f-6d9f-4efa-aa3c-59de5e3eb39e1073872.png	本书系“一带一路”沿线近40个重要国家的法律体系和规则制度精要，主要包括该国的（1）海关体系，如海关当局的权力、进出口检查规程和标准等；（2）对外贸易制度，如*制度、反倾销和技术壁垒等；（3）外国直接投资，如外国直接投资的优待措施，双边投资条约等；（4）货币银行体系，如外汇制度、银行制度等；（5）基础设施建设方面的法律，如项目融资、政府参与程度、外资参与限制等；（6）有关劳动管理方面的法律，如强制要求薪水、伤亡赔偿等；（7）环境法，如污染排放标准等；（8）相关纠纷解决方面的法律。 本书由香港世界贸易组织研究中心、有名的靠前经济法学家王贵国教授担任主编，来自俄罗斯、哈萨克斯坦、印度、斯里兰卡、日本、新加坡、马来西亚、印度尼西亚、英国、法国、德国、瑞士、埃及、希腊、意大利、荷兰、土耳其等“一带一路”沿线近40个重要国家的法律专家，直接用英文撰写本国的法律及规则精要，充分体现了该国国情。 此书的出版，将为我国企业与“一带一路”沿线国家顺利展开经贸活动、规避法律风险提供有效指导；同时，也为我国政府相关部门提供直接、适时的决策参考意见。此外，在学理层面，此书将为我国与“一带一路”沿线国家靠前关系、靠前政治和经济等相关领域的交叉学科理论研究提供新素材和理念。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	134
390	应用多元统计分析	978-7-301-07858-7	9787301078587	高惠璇 	\N	1-1	16开	49.00	392.0千字	北京大学出版社	436	7301	\N	2021-08-18	/book/dabb6375-ea03-4222-9c30-a855bcc0ce9f0785806.jpg	主要介绍一些实用的多元统计分析方法的理论及其应用，并列举了各方面的实例，同时还以国际上著名的统计分析软件SAS系统作为典型工具，通过实例介绍如何处理数据分析中的各种实际问题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	316
391	中国当代文学史作品选(修订版)	978-7-301-13875-5	9787301138755	洪子诚 	\N	1-1	16开	59.00	763.0千字	北京大学出版社	696	7301	\N	2021-08-13	/book/3fe95235-afd4-4b86-8a7b-69cf5a3295611387503.jpg	本书是为配合中国当代文学史的教学而编选的作品选，在编排上，以体裁为划分依据，以方便同一作家不同时期作品的处理。本书选入的作品，始于20世纪50年代初，终于90年代末，由于篇幅的限制，以短诗、散文、短篇小说为主，也适当选入一些中篇小说和戏剧作品。许多重要的中、长篇小说和戏剧作品无法容纳，采用了存目的方式在目录中做了提示。本书是学习中国当代文学史的辅助作品选本。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	176
392	土木工程材料	978-7-301-16792-2	9787301167922	赵志曼,张建平 	\N	1-1	16开	48.00	375.0千字	北京大学出版社	332	7301	\N	2021-08-16	/book/6013cda7-d0ac-45fa-afb0-c3841556ddb21679202.jpg	本书根据国家最新规范及相关规定进行编写，主要内容包括：绪论，材料概述，无机胶凝材料，混凝土与砂浆， 建筑金属材料， 墙体材料和屋面材料，沥青和沥青混合料，合成高分子材料，木材，建筑石材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	954
393	现代汉语导论	978-7-301-18985-6	9787301189856	周芸,邓瑶，周春林 	\N	1-1	16开	52.00	562.0千字	北京大学出版社	340	7301	\N	2021-08-16	/book/1718fc20-010b-45b7-9103-3e9f23eea4b31898502.jpg	本书为云南师范大学“现代汉语”校级精品课程配套教材、云南省普通高校重点建设专业"云南师大汉语言文学教育专业"建设项目内容，由云南师大中文系组织和牵头，昆明学院、云南财经大学、曲靖师范学院、保山师范学院、昭通师专、思茅师专、临沧师专等高校专家学者、一线教师共同参与，是一部适应21世纪云南高校汉语言文学教育、中国语言文学、文秘、对外汉语教学、广播电视新闻学、播音主持等专业本科课程发展需要的云南省高校本科《现代汉语》课程通用优秀教材。 全书共绪论、语音、词汇、语法、语用、书写符号六章，对现代汉语基本理论和基础知识进行了描述和分析，同时还较好地展现了近年来学界最新研究成果、东南亚"华文教育热"、边疆多民族地区汉语教学、传媒语言文化规范等热点问题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	756
394	幼儿文学	978-7-301-23216-3	9787301232163	瞿亚红 	\N	1-1	16开	58.00	360.0千字	北京大学出版社	356	7301	\N	2021-08-18	/book/a8022702-70b7-485e-92b6-7a56c153f9452321602.jpg	本教材的写作以入选教育部和重庆市两级的精品视频课程《幼儿文学》为基础。全书分为幼儿文学理论篇、文体篇、活动篇。理论部分紧紧围绕幼儿文学的核心理论展开，简练而精准；实践部分力求多方面、多角度去深入挖掘幼儿文学的具体使用方式，从而实现高校课程与社会实践需要的对接。 全书力图结合幼儿园的语言课程，以实用、好用以及让学前教育专业的学生、在校幼儿园老师以及幼儿家长乐用为原则，以拉近幼儿文学课程与幼儿、幼儿园之间的距离，从而满足更多人对学前幼儿文学的教育要求。本书不仅适合高校学前教育专业的需要，而且对在职的幼儿教师和广大家长都有帮助。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	537
395	20世纪欧美文学史	978-7-301-23619-2	9787301236192	郑克鲁 	\N	1-1	16开	52.00	340.0千字	北京大学出版社	332	7301	\N	2021-08-25	/book/4e3675a7-f771-4f98-ad55-862faa6727202361902.jpg	20世纪欧美文学对中国的影响巨大，目前图书市场上也已经有一些欧美文学史教材。该书不同于其他同类教材的特征在于，在撰写过程中，尤其着眼于那些已经对中国现当代文学产生巨大影响的作家作品、文学思潮和事件，以编读者在掌握这一时期欧美文学史的同时，也对中国现当代文学中的许多现象有更深的了解。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	643
410	符号学论略	978-7-301-32243-7	9787301322437	王铭玉 	\N	1-1	16开	128.00	560.0千字	北京大学出版社	488	7301	\N	2021-08-30	/book/8b21381f-9c2e-4e65-8c8c-34b77356df4f32243.jpg	符号学是研究符号及其意指活动规律的科学。本书分为五个部分：符号学概论、符号学理论阐释、语言符号学研究、符号学应用研究、符号学评介，对符号学研究进行了系统介绍。全书追踪世界符号学的发展步伐，汇集了作者相关领域学术论文三十余篇，涉及符号学历史、符号学各学派典型代表人物的基本理论阐释总结、个人在语言符号学方向上的探索、关于以翻译符号学为代表的符号学当代应用方面的思考、关于其他当代学人符号学研究成果的评介几个方面，比较清晰地呈现了作者学术生涯各阶段深耕符号学领域的成绩，全面展示了作者在国内符号学界的学术影响力。本书既是作者个人的成果总结，也有利于读者回顾20世纪世界各符号学大国的发展脉络，展望21世纪的未来走向，对我国相关领域学者继续建构有中国特色的符号学学派，具有很好的借鉴和启示意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	299
396	晚清女性与近代中国(第二版)	978-7-301-24626-9	9787301246269	夏晓虹 	\N	2-1	16开	88.00	347.0千字	北京大学出版社	408	7301	\N	2021-08-26	/book/e8f5e5f3-ec12-4154-9417-03226424d4132462602.jpg	本书从晚清新兴的报章文字中选取女性社会、女性典范、女性之死三个视角，透过对晚清女界生活与观念的考察，具体探讨晚清女性与近代中国社会、思想发展之间的复杂纠葛。作者试图通过进入报刊，实现阅读视角从官方到民间的转移，并由此返回现场，这种努力在本书中具体落实为通过对十个个案的剖析，对史料进行精细处理，以期逼真地展示晚清社会的某一现场，并由此揭示出其间隐含的诸种文化动态。上篇"女性社会"以个案整合"的方式，映现晚清女性从生活形态到思想意识的新变；中篇"女性典范"以勾勒晚清女性的人格理想为目标，意在展现先进女性有别于传统的精神世界：下篇"女性之死"是对三位死于上个世纪初的女性各异的死亡方式、原因以及由此引发的社会风波的歧出的意义指向的解说。作者认为，由此构成的晚清社会的图景，实际上蕴含了现代社会与现代思想萌发的种种迹象。本书作者以宏阔的视野精细地操作向不被学界看重的报章史料，以此生气淋漓地重现了晚清社会的诸般图景，从一个独特的视角出人意料又令人信服地勾勒出晚清社会与思想新变的轨迹。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	693
397	应用心理基础教程	978-7-301-24911-6	9787301249116	兰继军 	\N	1-1	16开	48.00	350.0千字	北京大学出版社	288	7301	\N	2021-08-23	/book/a72fa16e-2f72-49e2-bba8-9658d776c1fc2491102.jpg	本教材吸收当代心理学研究最新成果，系统介绍了感知觉、注意、记忆、思维、情绪、动机、人格、智力等心理现象，并从进化及生物基础等方面，对有关人类心理的发生、动物心理的多样化表现、个体心理的发展历程等方面进行了介绍。在相关章节对感官障碍、智力障碍、学习障碍、孤独症等特殊群体的心理进行了简要介绍。 内容采用故事、图片、案例、知识卡片、推荐影视（故事、歌曲）等灵活多样的形式呈现心理学中重要的原理，并针对当前社会中常见的心理问题提出了解决对策，在内容选择上密切结合当前热点的社会心理现象，帮助读者拓展对心理学在社会中应用的认识。 本书作者队伍由西北5所院校教授、副教授组成，都任课多年，实践经验丰富。 本教材可作为师范院校本科生的公选课对应的教材，也可作为心理学、教育学相关专业本科生、研究生教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	713
398	旅游景观设计与欣赏	978-7-301-25737-1	9787301257371	凌善金 	\N	1-1	16开	49.00	420.0千字	北京大学出版社	280	7301	\N	2021-08-23	/book/1638c5b0-33cc-4592-83e8-ad14189f46862573702.jpg	景观设计是为欣赏服务的，设计者必须了解欣赏者才能做好设计，欣赏者只有理解设计者思想才能更好地欣赏，旅游景观设计与欣赏两者存在着本质联系，因此本书将两者合在一起。本书以阐明旅游景观设计与欣赏的本质、原理和方法为宗旨，力求站在更宽泛的学科知识背景下，运用多学科理论来综合论述旅游景观设计与欣赏问题。全书拟分为九章，分为绪论、设计、欣赏三部分。第一部分为绪论，共一章，论述旅游景观设计与欣赏的基本概念、理论及本质问题；第二部分为设计篇，共四章，论述旅游景观设计的基本理论问题，旅游景观的设计依据，旅游景观的风格定位，各类旅游景观分类设计方法，旅游景观元素设计方法；第三部分为欣赏篇，共四章，论述旅游景观欣赏基本理论问题，旅游景观欣赏心理，自然景观的欣赏特性及欣赏方法，人文景观的欣赏特性及欣赏方法。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	577
399	汉英对比与英语学习	978-7-301-26862-9	9787301268629	张培成 	\N	1-1	16开	89.00	450.0千字	北京大学出版社	448	7301	\N	2021-08-16	/book/2fcc9cd6-1df1-4cd9-a96d-fc9316d059792686202.jpg	本书根据我国英语专业大学生所处的汉语语言和文化环境，针对他们英语学习中出现的重要问题，提出一种较新的英语学习理论和方法--利用汉英对比学习英语。本书系统阐述了这种方法的依据、思路、具体步骤及需注意的问题，并对英语学习所涉及的各个层面的汉英对比进行了较详细的论述。 本书的宗旨是帮助高校英语专业学生树立汉英对比意识，熟悉汉英对比知识，掌握汉英转换规律，最终达到克服汉式英语、掌握地道英语、提高准确表达英语能力的目的。 本书采用师生对话的形式，体现了师生平等讨论的亲切氛围，使理论问题的阐释深入浅出，易于为本科学生所接受。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	469
400	我的三轮教育教学实验	978-7-301-31134-9	9787301311349	孙维刚 	\N	1-1	16开	46.00	250.0千字	北京大学出版社	168	7301	\N	2021-08-11	/book/674b000d-b17e-490d-9818-7843ac0fde2d31134.jpg	本书是著名教育家孙维刚的力作，自1980年起，孙维刚开始进行从初一年级至高三年级的大循环实验，六年一循环，教数学并担任班主任，进行教育教学改革实验。书中介绍了作者在教学和教育上的思考做法，以及从中总结出的经验。书中指出作者在教学和学习上的具体做法主要有六个方面：站在系统的高度传输和接受知识；更着重对哲理的发现和汲取；让学生做课堂的真正主人；题不在多但求精彩，学会一题多解、多解归一、多题归一；从初一年级开始提倡和指导学生开展问题研究，练习写论文；保证学生充足的睡眠等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	703
401	创新的资本逻辑（第二版）	978-7-301-32079-2	9787301320792	田轩 	\N	2-1	16开	89.00	687.0千字	北京大学出版社	492	7301	\N	2021-08-25	/book/a3671fa6-86f9-4e1a-80cb-9c4938ae47e132079.jpg	本书是清华大学五道口金融学院金融学教授田轩的经典著作，也是金融与企业创新研究领域的代表作品。《创新的资本逻辑》通过国际比较的视野，剖析了中国场景下金融工具、金融市场和金融制度影响企业科技创新的作用机制、特征和结果。书中主要观点和结论均来自发表于国际金融学和经济学期刊的论文，经过严格、苛刻的反复论证，对当前中国经济、制度建设、市场运行具有深远意义。 第二版中，作者对原书内容做了大幅调整和充实，对多个章节进行更新，并根据最新研究成果增加了四章内容。新版对企业财务披露是否越频繁越好、企业地理位置如何影响创新绩效、开放资本市场有哪些利弊、制度创新如何激励企业创新等问题进行了详细分析，并加入一章金融与创新领域十分全面的文献综述，回顾了该领域近200篇文献。此外，新版保留了第一版中计量经济学方法、著名经济学家的专栏介绍，以及基于中国场景的迷你案例和数据分析，在写作上兼顾严谨性和可读性。 本书可以作为相关研究者、高校教师、博士、硕士、MBA（EMBA）和有余力的高年级本科生的学术参考书或教材，亦可作为业界人士与党政机关工作者等专业人士的参考读本，也可作为一般读者的专业知识普及读物。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	979
403	抗战时期典籍文献抢救保护研讨会文集	978-7-301-32282-6	9787301322826	国家古籍保护中心 	\N	1-1	16开	56.00	282.0千字	北京大学出版社	292	7301	\N	2021-08-20	/book/0c7dfabe-bf30-4d01-a6f3-361f119afcc832282.jpg	2015年为纪念中国人民抗日战争胜利暨世界反法西斯战争胜利七十周年，国家古籍保护中心组织各地图书馆的专家学者召开“抗战时期古籍抢救保护史迹研讨会”，并结集为《抗战时期古籍抢救保护史迹文集》，由北京大学出版社出版。此书受到相关领域专家的一致好评，《中华读书报》等也予以报道引用。2020年，适逢纪念中国人民抗日战争胜利暨世界反法西斯战争胜利75周年，为缅怀图书馆和社会各界仁人志士在民族危亡之际抢救保护古籍的义举，揭露日本军国主义抢掠破坏中国文化典籍的罪行，更好地传承中华优秀传统文化，弘扬红色革命文化，国家古籍保护中心（国家图书馆）再次召开“抗战时期典籍文献抢救保护学术研讨会”。与会专家、学者提交相关文章20篇。这些文章主要讲述了抗战时期合众图书馆等先贤抢救保护典籍文献、八路军抢救保护《赵城金藏》、文澜阁《四库全书》西迁贵阳、梅冷生抢救温州重要典籍文献等伟大壮举；揭示了郑振铎抢救典籍文献的新史料；丰富了抗战期间王重民在美国为抢救和整理中华典籍文献的历史细节；介绍了国家图书馆、重庆图书馆、四川大学图书馆、云南省图书馆、陕西省图书馆等单位对馆藏历经抗日兵燹劫难典籍和民国时期抗战文献的保护整理与研究开发，以及当代图书馆界在保存抗战文献，挖掘抗战典籍文献资源所做出的努力。本书对很好补充了2015年版《抗战时期古籍抢救保护史迹文集》内容空白，完善了相关事迹的细节。在学术价值层面，本书汇集介绍了全国各大图书馆抗战时期主要古籍文献的流转、编目及抗战相关资料的搜集、收藏、数据开发状况，可为相关专题研究的工具索隐。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	766
429	介尔景福	9787560771236	\N	徐超 	平装	1-1	16开	199.00	\N	山东大学出版社	\N	\N	\N	2021-09-01	/book/708cee94-6398-4636-a154-ad9c2cc832dc1074127.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	195
432	数学文化与教学设计：二年级	9787562189190	\N	宋乃庆，张渝，陈婷 等 编 	平装	1-1	16开	36.00	\N	西南大学出版社	\N	\N	\N	2017-10-01	/book/26737508-bfa5-4355-a834-af878614c4251074150.png	　　根据《义务教育数学课程标准（2011年版）》（以下简称《课标》）提出的“数学文化作为教材的组成部分，应渗透在整套教材中”的要求，我们组织编写了一套课外读物《数学文化读本》（以下简称《读本》）。《读本》发行以来，在渝、黔、云、琼、浙、川、豫、鲁、甘、辽等十多个省（市）、上百所学校使用并受到好评。《读本》还得到了张恭庆院士、刘应明院士、顾明远教授、张奠宙教授、周玉仁教授等大家的关心指导和高度评价。为了更好地发挥《读本》在课堂教学、课外活动及家庭教育中的育人作用，我们又组织编写了这套《数学文化与教学设计>，作为《读本》配套的教学指导用书。 　　《数学文化与教学设计》注重发挥《读本》的科普读物性，以连环画方式呈现的生动活泼性，与教材结合的紧密性，“文化性”与“数学内涵”相结合等特点，在内容编排上，精心设计了内容分析（含兴趣点）、教学目标、教学形式与教材配搭建议、教学过程分析与建议、教学参考资料等内容。《数学文化与教学设计》解读了《读本》中的每个故事，并提供了一些供参考的教学设计，深入挖掘故事所蕴含的数学知识、数学史料、数学方法，以及隐含在故事背后的数学思想和数学精神等，使之更好地借助《读本》的特色.充分发挥数学文化的育人功能。 　　《数学文化与教学设计》充分运用现代教学设计理念，指导数学文化的教学活动。首先，强调发挥学生的主体作用，有效指导学生开展操作活动、游戏、交流与探索活动等；其次，重视现代传媒技术在教学评价中的应用，对教师教学活动中的过程性评价和结果性评价，都做了科学合理设计。 　　我们认为，在以下几种情况时，《数学文化与教学设计》可以给予教师必要的指导性意见：（1）单元教学后，作为课堂教学的补充；（2）常规教学中，插入适当数学文化内容，作为数学教学支撑；（3）选作课外活动材料；（4）选作“亲子教育”素材；（5）选作学生阅读材料。因此，在使用《读本》教学时，可参阅《数学文化与教学设计》相应部分，一定大有收益。同时，由于各个学校、班级的差异，在使用时应根据实际情况进行适当调整。 　　《数学文化与教学设计》的编者由高校研究者和一线实践者组成，既有理念的**，更有实践的指导，更“接地气”。因此，我们希望这套《数学文化与教学设计》不同于通常编写的“教参”，能够很大限度地帮助一线教师使用好《读本》，能在教学实践中充分发挥《读本》的特色，更好地推进素质教育。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	880
404	增值物流业务运作与管理	978-7-301-32301-4	9787301323014	付荣华 	\N	1-1	16开	40.00	315.0千字	北京大学出版社	220	7301	\N	2021-08-13	/book/bf73314c-ae98-4e9d-8b42-11f5e9106d4732301.jpg	本书是在线精品开放课程配套教材，以社会主义核心价值观为引领，按照金课标准打造，根据物流企业最新采用的增值物流业务运作与管理的新模式、新技术、新方法来设计教学情境，结合增值物流业务运作流程来组织设置学生实训工作任务，通过做中学、学中做的方式，让学生掌握增值物流业务处理的基本流程和关键技术；在此基础上，训练学生针对增值物流业务处理过程的诸多要素进行计划、组织、协调、控制及统筹安排，提高业务运作效率，确保业务运作效果，满足客户期望，创新客户体验，激发学生创新创业意识，培养学生创新创业实践能力，使学生的专业能力、方法能力和社会能力稳步提高。本书适合作为高职高专物流管理等相关专业的教材，也可用作物流行业专业人士的培训资料。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	482
405	“有情之天下”就在此岸——叶朗谈《红楼梦》	978-7-301-32319-9	9787301323199	叶朗 	\N	1-1	16开	45.00	90.0千字	北京大学出版社	124	7301	\N	2021-08-16	/book/8aa8b093-853f-4740-ba31-918ea1dc41a432319.jpg	本书是叶朗从美学眼光谈《红楼梦》的文集。书中主要谈两个内容，一个是《红楼梦》的形而上的意蕴，曹雪芹对人生终极意义的追求，就是肯定“情”的价值，追求“情”的解放，追求爱的尊严，追求人与人的平等，归结起来就是追求“有情之天下”。“有情之天下”不是虚幻的存在，而是真实的存在，“有情之天下”就在此岸，因此人生是有意义的。这就是《红楼梦》给予读者的“悟”。再一个内容是《红楼梦》的悲剧性。《红楼梦》的悲剧性不在贵族之家的衰亡，而在“有情之天下”的毁灭，用林黛玉的诗就是“冷月葬花魂”。此外书中还谈了叶燮、金圣叹对《红楼梦》的影响，脂砚斋的评点，以及“点睛之笔”“闲笔”等小说美学的内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	211
406	国家赔偿法学（第三版）	978-7-301-32328-1	9787301323281	房绍坤,毕可志,鲁鹏宇 	\N	3-1	16开	59.00	395.0千字	北京大学出版社	332	7301	\N	2021-08-20	/book/a86b40c6-39c8-4187-92e9-621a5bfe479b32328.jpg	本教材以《国家赔偿法》的规定为主线，吸收了国内外国家赔偿法的理论研究成果，对《国家赔偿法》的基本原理、行政赔偿、司法赔偿、国家赔偿法的适用以及《国际赔偿法》的适用问题作了系统的阐述。作者对国家赔偿法领域的问题有多年的理论与实务经验。本书语言流畅，逻辑严谨，行文中，理论与实践相结合，围绕《国家赔偿法》和相关司法解释，深入浅出地对国家赔偿法作了详细的论述，反映出国家赔偿法的理论研究成果和实践经验，内容全面、资料翔实，适合作为大学本科生教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	386
529	创意写作十五堂课	978-7-5671-3724-0	\N	许道军 	\N	1-1	16开	52.00	\N	上海大学出版社	\N	\N	\N	2019-12-01	/book/770997e9-6532-4033-b2a4-d0afe472656b9787567137240.jpg	著作精选中国著名工坊专家许道军十五堂创意写作课程，涵盖故事、小说、影视、非虚构、自由诗与创意文案六种基本文体，从原理、技巧和工坊活动三个方面，全程复盘创意写作课堂真实概貌，回答“创意写作如何教”和“创意写作如何学”根本问题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	939
407	社会工作导论（第三版）	978-7-301-32333-5	9787301323335	王思斌 	\N	3-1	16开	62.00	375.0千字	北京大学出版社	396	7301	\N	2021-08-23	/book/71fd32dd-e659-4922-82ab-05de351ec46b32333.jpg	本书分为四个部分，对社会工作进行了全面介绍。第一，系统阐释了社会工作的含义和功能，概括了社会工作的发展历史，论述了社会工作的哲学基础与价值体系及社会福利制度，扼要说明了社会工作的理论与知识基础；第二，对人类行为与社会环境的关系进行了分析，并从社会干预的角度阐述了社会工作过程，尤其是通用社会工作过程模式；第三，从微观到宏观，阐明了社会工作的主要专业方法——个案工作、小组工作、社区工作、社会行政等；第四，对我国社会工作的教育与专业发展及前景进行了探讨。 本书适用于社会工作、社会学等本科专业教学，也可供相关专业师生、社会工作和社会政策领域的实际工作者选用和参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	210
408	大学生职业生涯规划与就业指导(第二版)	978-7-301-19426-3	9787301194263	赵麟斌 	\N	2-1	16开	49.00	387.0千字	北京大学出版社	296	7301	\N	2021-08-30	/book/1ccd7215-0233-4608-a349-2372aa87c8711942603.jpg	本书内容主要包括：就业与就业指导、就业观念、就业心理、职业与职业道德、职业生涯规划、就业市场与就业方式、就业综合素质、就业技巧、就业制度与政策、就业信息与程序、就业法律等。 本书从实用的角度出发，由具有多年大学生就业指导工作经验的一线优秀教师编写，内容丰富，结构清晰，概念清楚明确，并配有大量阅读材料和实例说明，适合高等院校作为大学生就业指导课程的教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	121
409	老年心理维护与服务	978-7-301-22897-5	9787301228975	李欣 	0	1-1	16开	49.00	469.0千字	北京大学出版社	300	7301	\N	2021-08-30	/book/df0e9b92-ccaf-4b1b-ad82-46553370487b1073989.jpg	老年心理学总论、老年心理的生理学基础、老年心理健康与相关疾病、老年心理特征及影响因素、老年心理卫生保健、老年心理相关的热点现实问题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	408
412	Oracle数据库应用与开发	978-7-5618-7009-9	9787561870099	李春青 	\N	1-1	16开	48.00	456.0千字	天津大学出版社	292	\N	\N	2021-07-01	/book/9a5764fc-7390-45d6-afd7-f003692bbf059787561870099.jpg	本教材介绍了最新版本的Oracle18c数据库的基本概念，数据库对象的基本操作，数据模型概念，关系数据库设计过程等内容；Oracle数据库系统中对象的操作与管理，SQL语句的使用；PL/SQL基本语法介绍，存储过程、存储函数、触发器的创建与使用，程序包的概念及使用；索引、视图、序列、同义词的使用，权限管理、数据的导入与导出，数据库的备份和恢复。使读者不仅掌握大型数据库Oracle的基本原理，了解大型数据库的管理方法，而且熟练掌握Oracle数据库系统中的SQL语言运用及PL/SQL程序设计。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	751
413	人工智能系统平台实施中级	978-7-5618-6989-5	9787561869895	曙光信息产业 	\N	1-1	16开	59.00	399.0千字	天津大学出版社	256	\N	\N	2021-07-01	/book/d9efbb49-4958-4731-9147-2e94454673b59787561869895.jpg	本书从人工智能系统平台环境部署为主线讲解了人工智能的概念以及人工智能平台环境的部署，主要涉及Linux系统安装、GPU环境配置、Python环境配置、人工智能基础概念、Hadoop环境部署、数据库部署、Docker部署、集群的部署和维护等知识。全书知识点的讲解由浅入深，使每一位读者都能有所收获，也保持了整本书的知识深度。本书主要涉及八个项目，即基础环境搭建、人工智能平台知识基础、分布式计算原理及Hadoop部署、数据库基础知识、容器知识基础、容器管理工具及Kubernetes部署、人工智能平台实施、人工智能平台监控与维护，严格按照生产环境中的操作流程对知识体系进行编排。使用循序渐进的方式从Linux系统安装、GPU配置一直到相关服务的部署等知识进行讲解。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	811
414	管理学基础	978-7-5618-7000-6	9787561870006	马彩云，陈移 	\N	1-1	16开	46.00	394.0千字	天津大学出版社	252	\N	\N	2021-07-01	/book/62adcd94-738d-464f-b5f2-3ad245ba50639787561870006.jpg	本教材编写不追求管理理论的创新，而是将成熟的管理理论以通俗、形象、易懂的方式呈现出来，即将管理的基本原则、原理、程序、方法完全置入仿真或真实的管理情境，通过让学生开展和完成所设计的学习（工作）任务去体验、模拟、实践管理，在这个过程中获得知识，训练能力，培养职业素质。真正做到“做中学、学中做、学后练、学后用”。本教材包括认知管理、模拟管理、实践管理三个环节，涉及7个学习情境，22个学习子情境。情境1属于认知管理环节，分为2个子情境。情境2、情境3、情境4、情境5、情境6属于模拟管理环节，包括16个子情境。情境7属于实践管理环节，分为4个子情境，各情境及子情境之间存在严密的“任务”逻辑关系，模拟管理和实践管理两个环节完整体现管理的计划、组织、领导、控制四个工作流程。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	946
416	力量训练的理论基础	978-7-5618-6963-5	9787561869635	陈浩 寇天伟 	\N	1-1	16开	39.00	206.0千字	天津大学出版社	204	\N	\N	2021-06-01	/book/71bd0910-8cea-41c0-9093-dbd8008497779787561869635.jpg	本书是“2020年度天津市社科界‘千名学者服务基层’活动大调研项目转化成果之一，并且是校企合作下“订单式”人才培养模式下的专业教材。 在编写的过程中，根据体育高职类院校学生的学习要求，结合当今力量训练的特点和发展趋势，参考了国内外有关书籍及文献，着重以理论框架为基础，强调理论指导实践，深入、全面的描述和整合力量训练的相关理论知识和训练体系，适用于本院校各个专业的教学使用。 其次，结合目前体能训练发展趋势及未来市场需求，在整个编写的过程中，融合其他学科知识，不拘泥于单科的知识体系，为学生在进行力量训练实践提供了借鉴和理论支撑。 社会价值： 1. 指导运动爱好者，正确的进行力量训练实践。 2. 作为高职类院校学生力量训练课程的校本教材和教辅。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	879
417	Python项目实战	978-7-5618-7008-2	9787561870082	天津滨海迅腾 	\N	1-1	16开	59.00	374.0千字	天津大学出版社	240	\N	\N	2021-07-01	/book/b7059e34-f8d3-4fcd-8317-b6d683b95f189787561870082.jpg	本书的特点是由浅入深，从最基本的Python安装、基础语法开始讲起，逐步深入到数据类型、数据结构、函数使用、面向对象编程、文件操作、图形用户界面、数据分析、数据库编程、网络编程以及Web应用和多线程操作。在介绍语法时，本书并没有像一些语法书那样教条死板地讲定义，而是利用示例代码生动地让读者在实践中体会一个个知识点。同时基础结合实训，在本书最后两章节通过项目案例巩固所学的知识点。本书分别介绍了Python的安装、Python条件、循环语句、列表和函数、字符串、元组和字典，主要包括字符串、元组和字典的基本属性和常用方法、面向对象设计和异常处理、文件读、写等相关操作、图像用户界面、数据分析和数据可视化等知识。Python是一种面向对象、直译式计算机程序设计语言，也是一种功能强大而完善的通用型语言，已经具有十多年的发展历史，成熟且稳定。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	283
418	与中国院士对话·大脑奥秘知多少：脑科学初探	9787567577770	\N	杨雄里，闫蓉珊，海波，秦畅 著 	平装	1-1	16开	48.00	\N	华东师范大学出版社	\N	\N	\N	2018-08-01	/book/ac22a475-3208-49e7-9818-c82cefe7de281074040.png	中国科学院院士 神经生物学家 杨雄里 讲述自身成长的小故事，回答孩子们感兴趣的问题，为他们讲解脑科学的知识。更重要的是让孩子们在追问和争论中，学着去思考，去感受科学的魅力。 大脑的结构是怎样的？ 有些鱼类的记忆只有几秒，为什么人类的记忆有时候可以保持几十年？ 科学家怎么探测大脑的奥秘呢？ 读完这本书，这些问题你都能找到答案！	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	983
419	与中国院士对话·把你看得更清楚：红外探测技术	9787567578210	\N	薛永祺，亓洪兴，海波，秦畅 著 	平装	1-1	16开	48.00	\N	华东师范大学出版社	\N	\N	\N	2018-08-01	/book/247883fc-4eaf-459c-8a1d-58a0185f4db31074041.png	中国科学院院士 红外和遥感技术专家 薛永祺 讲述自身成长的小故事，回答孩子们感兴趣的问题，为他们讲解光的知识和红外探测技术的秘密。更重要的是让孩子们明白，科学探索就是一种从已知到未知的探究，大多数新的发现是从已知的东西推断出来的。探索未知的领域，从中体会乐趣，这正是科学的魅力。 我们为什么能看见世界？ 这个世界的颜色从哪里来的？ 如何去感知看不见的世界？ 相机的图像是怎么拍出来的？ 是不是越来越好奇了？快来看书吧！	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	350
420	那时的大学：大师们的求学记忆（1912—1937）	978-7-313-24718-6	\N	张宁芳 著 	平装	1-1	16开	68.00	\N	上海交通大学出版社	\N	\N	\N	2021-08-01	/book/5f6ea17c-70a9-40ed-9480-7333f2cef58e1074048.png	本书以轻松幽默的文字，描绘民国学生的大学考试、衣食住行、学习生活、校园文化和毕业故事等，通过胡适、费孝通、潘光旦、陈岱孙、赵元任、茅盾、冰心、钱锺书、季羡林等知名学者对求学经历的记述和回忆，并利用民国报刊、口述资料、学校档案等材料，重现民国时期大学的优良学风和多姿多彩的校园生活，反映民国时期知名大学在教育管理方面的经验，生动展现了民国高等教育的一个侧面，可以为今天的教育工作者以及对民国历史感兴趣的读者提供参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	446
421	跨文化教育：从多元文化到跨文化	9787313250445	\N	姜亚洲 著 	平装	1-1	16开	78.00	\N	上海交通大学出版社	\N	\N	\N	2021-08-01	/book/4fc9c5d0-ac69-4708-ae04-faf31a025f8a1074054.png	应对文化多样性的挑战是当前世界各国面临的重要议题。近十年来，世界范围特别是欧盟各国的文化多样性政策出现了从多元文化主义到跨文化主义的转向，跨文化教育因此成为应对文化多样性挑战的重要举措。为了深入理解这一转向的理论根源，本书以澄清两个关键概念——文化差异和身份认同——为起点，系统梳理了跨文化教育的理论逻辑，在此基础上分析了各种不同类型跨文化能力的理论建构，归纳出学校中跨文化能力的理论模型，并以欧盟跨文化教育的实施为例，探讨了跨文化教育的课程与教学实践。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	288
1297	现代林业产业知识读本	978-7-5683-0166-4	\N	钱栓提 	0	1-1	16开	38.00	\N	西北农林科技大学出版社	\N	\N	\N	2017-10-01	/book/abbde318-f41a-4d85-bf51-0f4cfad7f30c1081824.jpg	本书是专门为大学新生代型职业农民培育而编写的参考读物，重在触发性认知上有所帮助，内容突出了时效性、资料性和趋势性;主要内容包括:我国近现代林业产业的发展;现代林业产业发展基本理论;我国林业产业发展方向;陕西林业产业发展方向;林业产业标准化。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	363
422	北京市城市治理与京津冀区域市场一体化研究	9787563831708	\N	邬晓霞 	平装	1-1	16开	38.00	\N	首都经济贸易大学出版社	\N	\N	\N	2021-01-01	/book/0d612bd2-141e-41e8-a5b7-1847b94544911074057.png	京津冀协同发展战略是国家重大区域发展战略之一，有效缓解北京“城市病”和加快推动京津冀要素市场一体化是京津冀协同发展的两个关键问题。本书探讨了城市治理能力的内涵和分析框架，从政府主导、社会参与、法治保障、跨区域合作、生态环境这五个维度系统构建"城市治理"综合评价指标体系、通过调查问卷对比分析北京、上海、广州和南京的城市治理能力差异，找出北京城市治理能力存在的主要问题，提出提升北京城治理能力的对策建议。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	599
431	酒人类学教程	978-7-5691-0448-6	\N	封孝伦 薛富兴 	平装	1-1	16开	68.00	\N	贵州大学出版社	\N	\N	\N	2021-08-01	/book/76acf78d-d479-4ae2-88b4-47bf40fb9d311074138.jpg	封孝伦、薛富兴两位教授撰写的《酒人类学教程》，主要从“酒艺”“酒与人生”“酒与社会”“酒与文化”等层面分析酒的文化内涵，从“酒品与酒器”“品酒与酒兴”“酒令、酒礼与酒累”“酒与农耕文明、酿酒文化”“酒与社会治理、经济发展、艺术”等方面研究酒人类学之间的紧密关系，力图全景式地呈现酒的人类学理论谱系。本书内容上不但追溯了酒的起源与发展，并且对酒在人类文化方方面面所发挥的作用做了全面的介绍和论述，从而强有力地证明了酒对于人类生活的价值、意义和人性的本质特征；同时，在分析酒人类学问题时做了比较深入的思考和研究，搜集、列举了大量历史文化资料，提出一系列具有重大意义和参考价值的问题，相信读者通过对本书的阅读学习，一定会获益良多并深受启发，进而推进“酒人类学”的建设和发展。本书还能为相关学科教育和人才培养提供助益，促进人才培养和品牌塑造，推动酿酒事业的发展，为人类的健康与幸福做出积极贡献。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	523
423	北京上市公司品牌国际化经营问题研究	9787563830121	\N	张松波 	平装	1-1	16开	42.00	\N	首都经济贸易大学出版社	\N	\N	\N	2020-06-01	/book/348edbe2-3d11-4c12-a87f-f572163031ba1074059.png	随着“走出去”、“一带一路”、上海自由贸易区的实施与国家政策的推动，中国的经济发展进入了一种新模式，正如习近平总书记在2014年5月河南考察时提出的“中国经济新常态”。从品牌国际化的角度来思考，中国企业品牌发展仍然处于发展建设阶段，在与国外品牌竞争中仍然存在一些问题。现阶段对品牌国际化的研究也比之前较为深入，但是对品牌国际化发展过程中的整体运营问题，比如企业的路径选择与实施等研究相对较少。基于此，本书主要研究内容为： 首先，立足北京企业品牌国际化经营的现实背景，分析文献成果，梳理本课题的核心概念，开展前沿理论评析，确立研究框架；其次，借鉴战略管理分析框架，分析北京企业品牌国际化经营的成长方式和战略选择，突出文化传播视角分析，探索国际市场中弱势品牌企业的品牌战略；第三，基于本研究提出的理论框架，选择小米科技有限责任公司（后文简称“小米公司”）和北汽福田汽车股份有限公司（后文简称“福田汽车”）作为案例进行深入分析和研究，进一步探究我国企业品牌国际化发展实践；*后，对研究结果进行讨论和挖掘，进行理论总结，提出针对性的优化对策和政策建议。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	494
424	铁道机车制动机	978-7-5121-4559-7	\N	许大勇 李长生 主编 	0	1-1	16开	49.80	\N	北京交通大学出版社	220	\N	\N	2021-09-08	/book/5820daeb-84eb-4a5c-acb7-b8ee115f72971074061.jpg	本书根据职业教育铁道运输类铁道机车运用与维护、电力机车运用与检修和内燃机车运用与检修专业教学计划中“机车制动机”课程的教学大纲编写而成，全书以东风系列内燃机车使用的JZ-7型空气制动机及SS4改型电力机车使用的DK-1型电空制动机为例，依据典型工作岗位的典型工作任务对教学内容进行项目化处理，以典型工作任务为驱动，介绍制动机的性能、构造、控制关系、作用原理、验收原则及实际运用。此外，书中还介绍了有关制动的基本理论、机车制动机附件、风源系统、基础制动装置与停车制动装置等内容。 本书以“工作导向”为指导思想来设计学习过程，采用“项目—任务—活动”模式组织内容，具体由职业院校专业教师团队与铁路部门一线技术骨干双元开发，内容反映企业现场新技术，贯彻人才技能培养新理念，项目安排合理，取材深度与学生水平相适应，便于组织教学。配备数字化教学资源，扫描二维码即可轻松学习，符合铁道机车制动机运用与检修岗位需求，适合职业教育学生学习的特点，便于自学。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	875
425	美学拼图	978-7-309-15565-5	\N	祁志祥 主编 	平装	1-1	16开	120.00	603.0千字	复旦大学出版社	600	\N	\N	2021-06-01	/book/a676fd45-33a5-48e4-81ec-d76c1dcf61c61074098.jpg	本书是2017年以来第九届上海市美学学会代表性论文的汇编。 这是一次“无目的的合目的性”的美学实践，一次没有彩排的学术会演，一个随机应物的美学拼图，一个充满张力的思想探寻。 四年一度的学会会员成果结集，将上海众多高校和机构的优秀师资聚合在一起，成就了难得的豪华作者阵容。 充当章节的论文曾在各种名刊发表过。 本书也是学会四十周岁生日的献礼文集。它记录了上海美学家的奋斗踪迹，体现了老中青学者的学术接力，为中国当代美学画卷献上了浓墨重彩的一笔。 书中配有会员的37幅书画篆刻插图，别具特殊的纪念意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	212
426	人类世与平台城市	9787305244506	\N	陈兴华 	平装	1-1	16开	68.00	\N	南京大学出版社	\N	\N	\N	2021-06-01	/book/7e05eb2f-84df-409c-8d09-f793d54ba5641074114.jpg	本书是从哲学的角度研究城市历史和城市文化的专著。全书基于马克思主义空间生产理论、本雅明·布拉顿的堆栈理论和斯蒂格勒的逆熵哲学，对城市的历史和城市研究的历史作了全面的回顾，并进一步讨论了人类世城市面对的诸多新挑战，尤其深入探讨了云计算平台对于优选城市化和城市优选化的决定性影响。本书不仅探讨和梳理了城市哲学，而且在此基础上，分析了技术的进步、艺术的发展、优选化的进程对于城市发展的影响，在理论上探讨了中国城市化和优选城市化的未来，具有较高的学术价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	715
508	许国璋英语（第1册）（附自学辅导1992年重印本）	9787560006659	\N	许国璋 编 	平装	1-1	16开	15.90	\N	外语教学与研究出版社	\N	\N	\N	1992-09-01	/book/57d343df-16d0-4923-9f91-58bacafa39dc1074727.png	《许国璋英语（第1册）》介绍了语音的重要性：语言是一种工具。人们使用语言，进行交往，交流思想。我们学习的是英语，通过它，我们可以和许多国家和人民交往，可以吸取有用的科学文化知识，为我国社会主义建设服务。语言有三个方面，即语音、语法、词汇。语音是根本的，首要的。语法和词汇都是通过语音得到体现的。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	431
427	惠园师韵	9787566323194	\N	编委会 	平装	1-1	大32开	108.00	\N	对外经济贸易大学出版社	\N	\N	\N	2021-09-01	/book/7f8fd00c-8bdf-45c0-b474-5a88064c4c6d1074115.png	　　《惠园师韵》为对外经济贸易大学建校70周年校庆系列图书之一。本书将2019年至今在《中华英才》上刊登出版的对外经济贸易大学教师的专访汇编成册，以名师视角，视贸大精彩古今轶事，观中国对外经贸事业发展方向潮头，与惠园群英一道，领略别样的惠园师韵。对外经济贸易大学的辉煌离不开党和国家的大力支持与关爱，更离不开在“中国经贸学府”“中国经贸人才摇篮”这样响当当的名号背后，每一位默默奉献，燃烧自己的贸大教师。本书稿的汇编体现了贸大教师先进的教学理念，精益求精的学术精神以及对学生的极大热忱。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	894
428	足迹2——2011—2020年对外经济贸易大学来华留学教育事业发展历程	9787566323187	\N	韩维春 	平装	1-1	大32开	188.00	\N	对外经济贸易大学出版社	\N	\N	\N	2021-09-01	/book/b450ffb3-3c41-453d-9502-8d0af69a97e41074118.png	　　2021年是建党100周年、建校70周年，也是来华留学教育60周年，至此大庆之年，国际学院拟在2011年出版的院史著作《足迹》基础上，回顾总结过去10年学院发展历程，集结成书，是为《足迹2》。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	904
430	马克思主义法律思想通史(第4卷)	9787565119453	\N	龚廷泰、程德文编，公丕祥、龚廷泰总主编 	平装	1-1	16开	130.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2014-11-01	/book/093760bf-54d4-476b-9dc2-2fcced75837e1074135.png	龚廷泰、程德文主编的《马克思主义法律思想通史(第4卷)(精)》主要探讨了西方马克思主义法学的产生、发展过程，重点阐述了西方马克思主义各重点流派和主要代表人物的法律思想。该书是西方马克思主义研究与建设工程的重要成果之一，具有重要的学术价值，有助于推动我国马克思主义法学理论研究的深入与发展，有助于强化马克思主义法学在法学学科领域中的指导性地位。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	707
434	民法典让青少年有“力量”	9787569705430	\N	张力 编 	平装	1-1	16开	28.60	\N	西南大学出版社	\N	\N	\N	2020-12-01	/book/cf1de984-ad72-4f23-a6e9-af26fff355f51074154.png	《民法典让青少年有“力量”》为“青少年民法典教育丛书”之一。民法典出台后，国家强调要“加强对青少年民法典教育”。《民法典让青少年有“力量”》采用“以案说法”的方式，取材生活中的点滴小事，通过简单易懂的法律分析，为青少年如何救济自身权利提供指导。《民法典让青少年有“力量”》分为四篇，分别介绍青少年的“权利束”和在家庭生活、学校生活、社会生活中如何培养青少年有“力量”。《民法典让青少年有“智”》旨在培育青少年在家庭、学校、社会等特定环境中的守法意识、权利意识、规则意识，引导现代社会中青少年的行为模式和处世原则，力求全方位涵养青少年思想道德素养。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	986
435	中国乡土建筑赏析（南方篇）	978-7-307-22454-4	\N	王炎松 著 	平装	1-1	16开	49.00	\N	武汉大学出版社	\N	\N	\N	2021-08-01	/book/6ea50365-0d64-4e04-968a-04065f9cb7bc1074159.jpg	本书是作者二十多年以来在全国各地乡村考察的亲身经历和感受的梳理和总结。希望通过这种方式，能够从建筑学、历史学、文化学、文化人类学、社会学、民俗学、古文献学、美学等跨学科视角，拓展学生的知识面，提高学生的审美境界。并希望通过这门课时并不长的课程，以乡土建筑为载体，引导未来的城乡设计者们对乡土价值的认知回归。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	304
436	遮蔽与显露的游戏——服饰艺术与身体美学（英文）	978-7-307-22495-7	\N	张贤根 著；韩征顺、吴凤娟、李建鹏、王敬忠、韩聪 译 	平装	1-1	16开	69.00	\N	武汉大学出版社	\N	\N	\N	2021-08-01	/book/e9a9c94f-1dd1-419e-804e-7c7cfbc05a691074166.jpg	作为一种艺术与设计样式，时尚不仅与人们的审美经验密切相关，无疑还是创意产业与文化的重要构成部分。该书旨在关注与探讨时尚与审美独特的生成性关联，以及时尚创意所涉及的社会、历史与文化语境，从而阐释创意文化的建构及其对时尚设计的影响。它主要集中在以下几个方面：1.时尚与其他艺术，设计的审美差异，服饰设计与身体及其存在的关联，以及时尚文化与日常生活的相互生成。2，时尚创意与民族文化的深刻联系，创意的民族性与世界性认同问题，全球化语境里民族时尚文化的重构。3.时尚传播的原理，路径与方式，时尚的传播及其文化产业背景，以及创意传播与文化发展的对策等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	276
437	海派文学论	978-7-309-15779-6	\N	许道明 著 	平装	1-1	32开	75.00	351.0千字	复旦大学出版社	466	\N	\N	2021-09-01	/book/71b88c9c-6a60-45fb-8e69-3fa017b682071074184.jpg	　　本书旨在清理了现代海派文学这一历史文学现象，并包含作者对这一现象的判断。作者没有将“海派文学”看成唯以地域为标准的大火锅，而是趋赴于从“现代”这一板块来厘定海派文学的概念，为考察海派文学在当代的命运提供了一些切实的说法。所选择的作家，既非海派的全部，也并不完全是一流作家，而或是阶段的代表，或是风格的代表，或是学艺身份的代表。本书是“海派文学研究丛书”之一种，供近现代文学研究者参考阅读，也可作为文学爱好者了解海派文学的入门读物。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	545
438	直击中考英语词汇——读音规则记忆法	978-7-5446-5798-3	\N	吴颖 蒋品圭 编著 	平装	1-1	32开	32.00	\N	上海外语教育出版社	\N	\N	\N	2021-08-01	/book/66367c52-b08d-414b-a5a0-12c0a84b80e11074196.jpg	本书将英语读音规则与初中词汇的教学和复习结合在一起：一方面可为初中教师开展英语读音规则教学，训练、巩固和提升学生运用靠前音标的能力，以及进行语音测试命题提供实用的参考资料；另一方面可用来强化初中学生音形结合记单词的意识，为他们使用音形结合的方法记单词提供可用的训练材料。本书所用的词汇表涵盖了上海市教委教研室编写的《上海市初中英语学科教学基本要求》、上海市教育考试院编写的《上海市初中毕业统一学业考试手册》和教育部制定的《义务教育英语课程标准》所附词汇表中的所有词汇。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	249
439	企业人力资源风险管理200句	9787564381226	\N	漆明 	平装	1-1	32开	42.00	\N	西南交通大学出版社	\N	\N	\N	2021-08-01	/book/b704a0ca-0104-42ea-8a5f-5f06ce0f8d3c1074229.jpg	本书以较为精炼的语言，将人力资源管理中的常见风险认知问题进行了高度概括和提炼，目的在于方便组织管理者们用少的时间或碎片时间进行阅读，以发现自己的组织在人力资源管理方面可能存在的风险问题，思索适合自己组织的用工风险管理策略，终构建和谐的劳动关系。本书针对当前大量企业、社会组织在具体管理过程中面临许多不必要的劳动争议诉讼风险，结合作者在为企业提供课程培训和咨询服务、作为仲裁员审理大量的劳动争议案件的过程中的经验，凝练了值得企业中高层管理人员掌握的警言200余条，以提示中、高层管理者修正认知偏差，在决策过程中减少乃至回避劳动用工方面的风险。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	721
440	希贤立德——谢希德画传	978-7-309-15601-0	\N	焦扬 许宁生 主编 	精装	1-1	12开	560.00	398.0千字	复旦大学出版社	318	\N	\N	2021-09-01	/book/d8bd4753-03c9-4910-b9f7-26126ad28d861074252.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	285
441	高等教育运动医学&运动康复精品教材——体育保健学	978-7-5644-0831-2	\N	高维纬 	平装	1-2	16开	50.00	414.0千字	北京体育大学出版社	\N	\N	\N	2021-07-01	/book/4d35f954-5f57-4831-b942-0754eba9d0fc1074261.jpg	“体育保健学”是体育学二级学科本科专业的主干课程。本书由北京体育大学运动医学与运动康复学院长期教授本门课程的高维纬教授编撰，教学对象为体育院校和师范大学体育学院的本科生、专科生，体育职业教育的本、专科专业也适用。内容包括身体形态的测量与评价、身体机能的检查与评价（包括运动系统、心血管系统、呼吸系统、神经系统等的检查与评价）、学校体育运动的医务监督、运动环境卫生学、特殊人群的体育卫生、运动性病症（包括过度训练综合症、过度紧张、晕厥、运动员贫血、运动中腹痛、肌肉痉挛、运动性血尿、运动中暑、运动猝死）运动疗法、运动损伤与干预、运动意外事故的急救与处理、身体各部位常见损伤。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	284
442	高等教育体育专业通用教材——《运动损伤的治疗与康复》（第2版）	978-7-5644-0421-5	\N	黄涛 	平装	2-7	16开	35.00	195.0千字	北京体育大学出版社	\N	\N	\N	2019-02-01	/book/e3e016fc-2df5-45f0-b934-a36822380ac51074265.jpg	本教材主要讲述运动损伤的基本知识和处理，运动损伤概论，运动损伤的分类，运动损伤的原因，运动损伤的预防原则，常见的运动损伤，组织损伤的病理学简介，组织损伤的形态变化，炎症，组织的修复与再生，运动损伤的急救，休克和休克的现场处理等等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	525
443	高等教育运动医学&运动康复精品教材——运动损伤评估与防治	978-7-5644-3348-2	\N	何海燕 	平装	1-1	16开	60.00	263.0千字	北京体育大学出版社	\N	\N	\N	2021-02-01	/book/0c24c315-01e7-4dab-be63-1065fc1346a61074274.jpg	本教材的教学对象为体育院校和师范大学体育学院的本科生、专科生，体育职业教育的本、专科专业也适用。本教材编写的特色主要体现在三个方面：（1）体医融合。在内容方面突出以下两点：运动损伤学对运动实践的指导、运动技能对运动损伤的康复治疗。（2）内容前沿。将近些年来在运动康复、体能训练领域较为前沿且实用的理念技术进行梳理总结，如泡沫轴、肌效贴等引入运动损伤教材。（3）突出运动损伤的预防。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	311
444	1945—1949年东北解放区文学大系：中篇小说卷	978-7-5686-0456-7	\N	蓝天、金刚 	平装	1-1	16开	208.00	\N	黑龙江大学出版社	\N	\N	\N	2021-09-01	/book/c29bbc93-e58e-4b65-9b59-1a9dd6f3d8521074282.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	824
445	高等教育体育学精品教材——中医养生康复	978-7-5644-2943-0	\N	白震民 	平装	1-1	16开	65.00	600.0千字	北京体育大学出版社	\N	\N	\N	2018-12-01	/book/8ff9cc4b-75c8-4eb1-bdff-31feac5792851074288.jpg	《中医养生康复》是为运动康复专业方向学生编写的教材。教材编写的目标是使学生通过本课程的学习，熟悉中医基础理论概要，掌握中医养生康复的基本原则；使学 生在理解和掌握中医养生康复的相关基础知识和操作方法的基础上，通过实践课的操作练习，能够初步运用中医养生康复的方法解决临床中的实际问题。本教材理论部分包括：中医基础理论概要，中医养生康复技术的理论基础和经络腧穴的介绍。操作技术包括：刺灸疗法、 推拿疗法、药食疗法和传统运动疗法。临床应用主要包括常见骨骼肌肉和神经病损功能障碍的中医康复治疗。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	678
476	中国昆曲年鉴2021	9787567236882	\N	中国昆曲年鉴编纂委员会 编，朱栋霖 主编 	平装	1-1	16开	298.00	\N	苏州大学出版社	\N	\N	\N	2021-09-01	/book/2ae0d56b-6682-48c5-8b4c-eb6b9d4c24771074465.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	416
452	WTO体制下消费者知情权保护问题研究：以食品标签为视角	978-7-5620-9286-5	\N	郭桂环，齐秀敏著 	\N	1-1	32开	35.00	208.0千字	中国政法大学出版社	160	\N	\N	2019-11-01	/book/5540dc60-b974-47ee-b289-da060ba336869286-5.jpg	随着国际社会消费者保护浪潮的兴起，各国日益重视消费者知情权保护问题。这一趋势在食品领域的表现尤为突出，一些国家开始以消费者知情权保护为理由进行食品标签立法。而这些以消费者知情权保护为目的的食品标签措施对国际贸易自由造成影响。如何协调消费者知情权保护和贸易自由之间的关系成为世界贸易组织不得不面对的一个重要问题。本书从美国金枪鱼II案和美国COOL案等WTO具体案件出发，分析了WTO体制下保护消费者知情权保护所面临的问题，并提出了具体解决建议。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	997
446	高等教育运动医学&运动康复精品教材——运动康复评定学	978-7-5644-3244-7	\N	钱菁华 	平装	1-1	16开	90.00	608.0千字	北京体育大学出版社	\N	\N	\N	2021-05-01	/book/8f0d5a54-fd8f-4511-9e4c-070cd324149d1074289.jpg	本教材的教学对象为体育院校和师范大学体育学院的本科生、专科生，体育职业教育的本、专科专业也适用。本教材以培养学生运动实践应用能力为宗旨，重点介绍运动康复评定的思路和具体方法，以四肢及脊柱的运动康复评定理论与实践方法为主线，分别就肩、肘、腕、手、髋、膝、踝、足、颈椎、胸椎、腰椎、骨盆等身体部位损伤的常见功能障碍、主观检查方法、客观检查方法进行详细阐述，再结合案例分析引导学生掌握应用运动康复评定方法。身体姿势评估、疼痛、 肌力检查、步态分析、功能动作筛查等与全身运动功能状况密切不可分的内容，独立成章节。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	235
447	高等教育体育学精品教材——游泳池救生教程	978-7-5644-1591-4	\N	高捷 	平装	1-2	16开	40.00	320.0千字	北京体育大学出版社	\N	\N	\N	2020-03-01	/book/eebe83cd-e302-419c-9491-ba7eae69d0491074293.jpg	本教程中包含了游泳救生基本理论与方法、游泳救生基本技术、游泳救生赴救技术、游泳救生现场急救技术、游泳救生中的观察与判断、游泳池安全管理等多方面的最新理论知识。在每一章节中均提供了内容概述、 学习目标、案例分析、思考题，并结合大量图片，以最直观的图文结合的形式帮助学生快速理解教材内容，提高学习效率。该教程不仅适合于本专科体育类院校运动训练、体育教育、社会体育、休闲体育专业学生作为游泳专项理论的教学教材，同时也适合于其他院校、其他专业选修游泳或游泳救生课程的教学教材。此外该书也适用于参与各级游泳救生员国家职业资格考核的考生作为教学参考教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	600
844	无人机图像处理	9787561253564	9787561253564	段连飞 	\N	1-1	16开	48.00	\N	西北工业大学出版社	\N	\N	\N	2021-12-01	/book/7ef28568-f7d0-4eeb-a6cc-6731f6c4534d9787561253564.jpg	无人机图像处理是数据获取和信息处理重要手段，本书以无人机图像应用为牵引，系统阐述了无人机图像增强、无人机图像拼接、无人机图像融合、无人机图像判读、无人机图像正射纠正和无人机图像目标定位等处理技术问题。 本书既可作为无人机技术、遥感专业等本科生教材，也可供武器装备设计和研制领域的广大科技工作者、工程技术人员参考和使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	712
448	桑磊法考讲真题	978-7-5620-9953-6	\N	桑磊主编 	\N	1-1	16开	415.00	1932.0千字	中国政法大学出版社	3014	\N	\N	2021-05-01	/book/49c0e54b-4011-4346-b6c1-56ed49bc59149953-6.jpg	本书由前命题处长桑磊领衔主编，分别从题目难度分析、题目所涉考点分析、命题和解题思路、选项分析等方面对近年的历年真题以命题人命题角度进行了真题设计思路还原及作答技巧指导，使考生知道“真题要考查什么”“以什么形式考查”“考查中常设置哪些命题陷阱”“如何发现并避开这些陷阱”等，同时对真题选项逐项分析并单设【易混淆点分析】【难点解析】等知识要点小贴士，使考生在做真题的同时，牢固掌握法考常考、易考的重要考点。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	891
449	海商法	978-7-5620-9848-5	\N	张丽英主编 	\N	5-1	16开	76.00	408.0千字	中国政法大学出版社	458	\N	\N	2021-05-01	/book/3b3e4ea7-e8e1-4c86-955b-1146545ed4759848-5.jpg	《海商法》教材的本次修订针对《中华人民共和国民法典》的通过，船员相关法规的修改，与定期租船、光船租船相关的标准合同格式的修订等情况，对本教材相关部分进行了修订。另外，对各章的拓展阅读部分进行了更新。修订的具体内容如下： 1．依《中华人民共和国民法典》，对涉及已废止的《中华人民共和国民法通则》部分进行修改。 2．由于《中华人民共和国物权法》的内容并入《中华人民共和国民法典》物权编，对相关船舶所有权、船舶抵押权、船舶留置权的内容进行了调整。 3．依2020年修订的《中华人民共和国船员条例》，在船员一章进行了相应的修改。 4．依《中华人民共和国海员外派管理规定》（2019年11月28日修订），对船员外派部分的内容进行了修订。 5．在定期租船方面，加入了定租租船纽约土产格式NYPE2015的修订。 6．在光船租船方面，加入了光船租船标准合同格式“贝尔康”（BARCON）2001年版和2017年版的相关内容。 7．在共同海损方面，加入了2016年的《约克—安特卫普规则》的内容。 8．在海事诉讼法方面，与民诉法的相关内容进行了协调，加入了2017年《最高人民法院关于审理海洋自然资源与生态环境损害赔偿纠纷案件若干问题的规定》、2015年《最高人民法院关于扣押与拍卖船舶适用法律若干问题的规定》等相关司法解释的内容，并结合近期的典型案例，对海诉法的条款进行了释析。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	633
450	中国政法大学年鉴.2018	978-7-5620-9949-9	\N	中国政法大学年鉴编委会编 	0	1-1	16开	185.00	732.0千字	中国政法大学出版社	1056	\N	\N	2021-04-01	/book/7cc9e41a-a2c3-41d4-a392-0436c87bf9639949-9.jpg	2018卷年鉴设置二十二章，包括学校概况、机构设置、特载、重要文件、校内文件索引、教育教学与人才培养、学科建设、科研工作、党建与思想政治工作、行政管理工作、国际及港澳台地区交流与合作、国内合作与社会服务、图书建设、后勤服务工作、校办产业、教学科研单位、学术刊物、奖励与表彰、综合统计表、毕业生名册、大事记、媒体索引。各章下的条目以事件发生时间为序排列。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	997
451	2021年国家统一法律职业资格考试主观题行政法宝典	978-7-5620-9928-4	\N	黄文涛编著 	0	1-1	16开	58.00	196.0千字	中国政法大学出版社	310	\N	\N	2021-04-01	/book/3d8c008e-e923-44bb-a99b-1d047db00b5e9928-4.jpg	本书科目为行政法与行政诉讼法。2018年国家法律职业资格考试特别设置了主观卷的考查，为了适应最新考试政策的变化，特组织辅导教师，结合考试大纲考查要求，对于主观卷的考查方式、特点及要求做了说明和解析，通过对本学科的知识梳理，帮助考生对于主观题的掌握和理解，提升复习备考成绩。本书结合最新颁布的行政诉讼法司法解释，本着新法必考的原则，突出重难点的分析。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	233
470	校园足球教师教练员培训教材——足球教学训练计划文件的制订	978-7-5644-2682-8	\N	北京体育大学足球教研室 	平装	1-1	大32开	20.00	109.0千字	北京体育大学出版社	72	\N	\N	2018-01-01	/book/5ac41968-3f6c-4c4e-8665-57e2797531a71074424.jpg	足球教学文件包括：教学大纲、教学进度、教案等。它是开展足球教学工作的重要依据，也是检查和提高足球教学工作质量的重要保证。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	350
453	高等教育体育学精品教材——体育英语阅读教程•Ⅱ	978-7-5644-2009-3	\N	田慧 	平装	1-2	16开	60.00	455.0千字	北京体育大学出版社	\N	\N	\N	2017-08-01	/book/3517ff9b-1261-4dd9-8dd2-2f07032c90521074351.jpg	《体育英语阅读教程》可作为体育院校英语专业学生以及高等院校体育专业的高年级学生、硕士生和博士生的阅读教材，亦适用于广大体育爱好者和体育专业人士阅读参考。本书文章广泛选自英国、美国、加拿大及澳大利亚等英语国家的体育相关著作、报刊、杂志以及相应报刊名下的网址。在 CBI（content-based instruction）理念指导下，选材注重体裁和题材的多样性和视角的多元性，同时兼顾题材的系统性，旨在传授相关体育学科知识，开阔学生视野，同时增强其英语阅读能力、表达能力、分析能力和思辨能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	883
454	电工电子实验指导教程（第二版）	9787560661414	\N	欧阳宏志 	\N	2-1	16开	37.00	342.0千字	西安电子科技大学出版社	232	\N	10	2021-09-03	/book/59fd1694-52bc-4a83-ad5d-bd25ebe0ca989787560661414.jpg	本书结合实验装置以及仪器设备，介绍了电工基础、电子技术等实验内容以及电子技术课程设计。 全书共6章，主要内容包括实验设备、电路仿真软件TINA、电工基础实验、电子技术基础实验、电子技术综合实验和电子技术课程设计等。本书内容安排从基础到综合、从局部到整体， 将虚拟实验与真实实验相结合，内容完整，资源丰富，可作为高 等院校电气信息类相关专业本科生电工电子实验及课程设计的教学用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	416
463	高等教育体育专业通用教材——《体育运动心理学简编》（第2版）	978-7-5644-0526-7	\N	毛志雄 	平装	2-3	16开	42.00	407.0千字	北京体育大学出版社	\N	\N	\N	2020-01-01	/book/e3e1cb7c-7dea-4ee2-a496-dfe5976d55fa1074401.jpg	本教材以竞技运动心理学核心内容为主干，同时也概括了体育教育心理学和大众锻炼心理学的重要内容，从知识体系的内容上看，既有重点，也较全面，便于学生了解整个运动心理学的体系框架。作者加入许多实例包括北京奥运会的实例，使全书显得十分贴近运动实际，也使学生更容易对体育运动心理学产生直观的、具象的感受。本书十分注意使教材内容能够体现不断变化不断发展的运动心理学的理论与实践。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	528
455	可编程控制器原理及应用	9787560661698	\N	姜久超 	\N	1-1	16开	49.00	402.0千字	西安电子科技大学出版社	272	\N	13	2021-09-03	/book/686c8d25-c19e-4c02-8300-b2b4a246975c9787560661698.jpg	本书以应用能力培养为主线，注重体现“可编程控制器原理及应用”课程在专业培养中的作用，力求满足学生后续课程的学习和专业能力培养的需要。全书内容包括可编程控制器概述、西门子S7-200 PLC的硬件系统、S7-200 PLC编程工具、S7-200 PLC的基本指令及应用、S7-200 PLC步进指令及应用、S7-200 PLC功能指令及应用、PLC控制系统的设计、西门子其他型号PLC简介、可编程控制系统通信等。书中的每个例子都是从实践中提炼形成的，既能突出本门学科的实践应用性，又能训练学生的动手能力，充分体现了理论与实践相结合，满足了应用性和技能培养的要求。 本书可作为自动化、电气工程及其自动化、机械电子工程等专业课程的教材，同时也可作为相关技术人员的自学书籍。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	180
456	电力电子技术实践指导	9787560661537	\N	逄海萍 	\N	1-1	16开	24.00	213.0千字	西安电子科技大学出版社	148	\N	19	2021-09-07	/book/e653563e-b188-4613-89c2-240c7cb8ab949787560661537.jpg	本书将“电力电子技术”课程的主要实践环节融合在一起，以全方位培养学生实践能力和创新思维能力为目标而编写。 全书共5章，第1章和第2章分别是基于MATLAB和PSpice的仿真指导，主要涉及仿真软件的使用以及典型电力电子变换电路的仿真；第3章是基于求是教仪NMCL实验平台的电力电子技术基础实验，主要涉及电力电子变换器的基础硬件实验；第4章是综合拓展及创新实验，所涉及的实验属于创新性、设计性的综合提升型实验；第5章是课程设计指导。 本书面向电气工程及其自动化、自动化等专业及相近专业的本科生，贯穿整个“电力电子技术”课程教学过程，可以作为实验课、课程设计以及创新实验课等的配套教材，也可以作为研究生和专业教师的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	826
457	大学计算机基础	9787560661735	\N	侯素红 	\N	1-1	16开	52.00	320.0千字	西安电子科技大学出版社	264	\N	10	2021-09-13	/book/37d32b93-cab1-4e65-bfd6-440446ee40919787560661735.jpg	本书是针对计算机应用基础课程教学要求，依据2021年高等职业教育信息技术课程标准编写的，全书包含计算机基础知识、操作系统、文字处理软件、电子表格处理软件、演示文稿软件、计算机网络基础和计算机前沿技术等内容。 本书采用项目驱动的编写方式，使学生积极思考任务描述、掌握完成任务的必备知识，同时通过练习巩固知识点，配合习题使学生做到对知识点的融会贯通及延伸拓展，最终培养其可持续学习、可持续发展的终身学习的能力。 本书适合大学一年级所有专业的学生学习，也可作为全国计算机等级考试(一级MS Office考试)的培训书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	698
458	社交礼仪与交往艺术	9787560661957	\N	张彤 	0	1-1	16开	35.00	293.0千字	西安电子科技大学出版社	200	\N	13	2021-09-16	/book/ce576f5d-d540-4586-9956-f8a04f32c1891074379.png	本书主要介绍了仪表礼仪、会面礼仪、拜访与接待礼仪、聚会礼仪、会议礼仪、商务礼仪、公共礼仪、面试礼仪的内容，书中编入了思政内容，将爱国主义教育、习近平新时代中国特色社会主义思想、社会主义核心价值观等融入其中，更便于读者掌握礼仪文化，提升内在素养。 本书可作为高等院校相关专业的教材，同时也可作为有关专业人员，如机关、企事业单位公关人员和文秘人员的岗位培训教材以及社会读者的自学读物。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	580
459	高等教育体育学精品教材——体育场馆管理	978-7-5644-3242-3	\N	李艳丽 	平装	1-1	16开	90.00	371.0千字	北京体育大学出版社	\N	\N	\N	2020-06-01	/book/be81e01d-0f2d-4421-8420-a265cd476b771074380.jpg	本教材遵循理论与实践并重原则，给相关章节的内容主要提供了管理学理论基础（部分内容运用了经济学分析工具）。本教材遵循“体育场馆内涵—— 体育场馆建设——体育场馆运营——体育场馆管理改革（未来发展方向）” 的逻辑框架。同时，分别从场馆资产和场馆单位两个角度，论述了场馆管理的相关知识。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	641
460	高等教育体育学精品教材——冰雪运动英语阅读教程	978-7-5644-3187-7	\N	田慧 	平装	1-1	16开	80.00	423.0千字	北京体育大学出版社	\N	\N	\N	2020-03-01	/book/0b8a9053-3a81-45df-b133-dcc65b5b1f2b1074386.jpg	本书包括 16 个单元。每单元围绕同一个主题设计一篇主课文（Text A) 和一篇副课文 (Text B)，主课文用作课堂重点讲解，副课文供学生在教师指导下使用。文章后的 Identifying Information 根据文章的体裁和题材做出了相关的设计，以不同形式检验学生在宏观和微观水平上把握文章的能力。Building Your Language 部分所设练习丰富全面，形式多样，包含语义、词法及句法方面的练习，培养学生相关语言知识技能。在文章的注释中，编者在 Glossary 部分对重要词汇提供了准确、详尽的中英注释，以帮助学生精确掌握词义， 同时在 Notes on the Text 部分对文章中出现的难句和文化背景知识进行了适当的解释和说明，以丰富学生的语言知识和文化知识。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	148
461	高等教育体育专业通用教材——排球	978-7-5644-0252-5	\N	排球精品课程团队 	平装	2-2	16开	30.00	281.0千字	北京体育大学出版社	\N	\N	\N	2019-08-01	/book/4f73be7a-6762-4ab7-96ad-441d03c545e01074392.jpg	本教材包括排球运动概述、排球基本技术、排球基本战术、排球竞赛工作、排球竞赛规则与裁判、排球教学工作和沙滩排球与软式排球等章节。全书力求方便学生阅读，注重学生排球技能、比赛能力、教学能力、裁判能力和竞赛组织能力的培养，并将课程改革的成果注入教材中，把国际排联最新规则的相关要点编写到教材中。本教材主要适用于体育院系排球普修课程学生，也可供排球教学工作者和排球运动爱好者阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	327
462	高等教育体育专业通用教材——田径	978-7-5644-2276-9	\N	孙南 	平装	1-2	16开	35.00	167.0千字	北京体育大学出版社	\N	\N	\N	2016-07-01	/book/5a28ef0c-4827-4bc2-93e5-30390defc67f1074393.jpg	这本教材把各运动单项的“技术教学”和“训练”的共性成份统归到两章， 即“田径运动中的技能培养”和“田径运动中的身体素质训练”。这样编排避免了某些内容的多次重复，也凸显了知识的整体性，有助于读者的系统学习。而对于不同运动项目的专项特点，则主要是用“影响该项目成绩的关键因素” 和“专项常用练习方法”来加以体现。本教材选用了大量的技术图片，这样做的目的是为了突出技术学习的“直观性”原则，使学生更加易懂易学。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	996
464	高等教育运动医学&运动康复精品教材——临床康复学	978-7-5644-2480-0	\N	刘华 	平装	1-2	16开	50.00	404.0千字	北京体育大学出版社	\N	\N	\N	2020-02-01	/book/81127b1f-650d-4d61-91cf-c05799d87e571074402.jpg	本教材教学对象为体育院校和师范大学体育学院的本科生、专科生，体育职业教育的本、专科专业也适用。根据本教材的特定对象，以临床常见疾病为重点，突出疾病的康复功能评定和康复治疗技术的应用。在本书的编写过程中，紧紧围绕体育院校运动康复专业学生的培养目标，始终坚持与“康复治疗专业技术人才准入标准” 接轨的原则，紧扣课程标准，体现体育院校运动康复专业的特点。重点介绍常见疾病康复的基本理论、基本知识、基本技能，同时强调科学性和适用性；减少过繁的理论知识，注重临床与实践结合，学以致用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	831
465	高等教育运动医学&运动康复精品教材——理疗学	978-7-5644-2481-7	\N	荣湘江 刘华 	平装	1-4	16开	50.00	419.0千字	北京体育大学出版社	\N	\N	\N	2020-02-01	/book/66add808-7a3b-4560-a616-0ec0bf94fd031074403.jpg	本教材根据理疗学的学科性质将内容分为十三章，分别是概述、直流电疗法、低频电疗法、中频电疗法、高频电疗法、传导热疗法、磁疗法、超声波疗法、冲击波疗法、光疗法、水疗法、生物反馈疗法与压力疗法。概述是理疗学的理论知识，后面几章是具体的理疗学的方法，在介绍每种方法都具体的介绍了相应的操作方法，便于学生联系实际，加强动手能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	893
466	高等教育体育专业通用教材——水中健身理论与实践	978-7-5644-2754-2	\N	温宇红 	平装	1-1	16开	80.00	200.0千字	北京体育大学出版社	\N	\N	\N	2018-01-01	/book/786454ba-ee38-46ad-8f73-f139662601881074407.jpg	本教材精选水中健身操、水中体能训练、水中康复训练、水中娱乐互动等水中健身活动的常用练习方法，通过图文结合的形式帮助读者了解、掌握并进行水中健身活动，教材还针对不同的授课群体特点，设计适用于俱乐部、高等院校、中小学的水中健身课程大纲，更好地为今后水中健身课程的开展提供帮助。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	678
467	高等教育体育专业通用教材——体育课堂教学技能实训教程	978-7-5644-3083-2	\N	张桃臣 	平装	1-2	16开	60.00	267.0千字	北京体育大学出版社	\N	\N	\N	2018-10-01	/book/922d1d5f-ec57-43cd-b44d-7e1d5f53655b1074414.jpg	本书以教育学、心理学、传播学、系统科学理论、教学理论及体育专业理论为基础，以实践性和可操作性为原则，在参考微格教学及其课堂教学技能研究的基础上，结合体育学科教学的特点及规律，对体育课堂基本教学技能进行了较为详细的阐述，并附有微课堂案例及评价方法，帮助学生理解和掌握体育课堂教学的各项基本技能，提升其教学能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	961
468	高等教育体育专业通用教材——体育教学设计与教案编写	978-7-81100-229-4	\N	赵立 等 	平装	1-4	16开	20.00	159.0千字	北京体育大学出版社	\N	\N	\N	2020-01-01	/book/82a8ae70-55da-432f-83e3-25fb8f59907f1074417.jpg	本书的主要特点是：（1）运用教学设计的基本理论，对体育课教学设计提出了比较好的建议。（2）根据我国《体育与健康课程标准》的基本理念，对不同年级，不同学习内容，提供了有一定借鉴意义的教案。（3）每个教案都包括教学设计及对教案的点评。（4）注重教案的可拓展性。本书既可作为广大体育教师继续教育的参考读物，也可作为体育院校和高师体育专业学生的教学实习参考读物，又可供学校体育课程与教学领域的研究人员使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	300
469	校园足球教师教练员培训教材——足球战术教学与训练	978-7-5644-2686-6	\N	北京体育大学足球教研室 	平装	1-1	16开	40.00	170.0千字	北京体育大学出版社	\N	\N	\N	2018-01-01	/book/77c3677a-2b2b-4c6f-a295-600f7ca43e601074420.jpg	本教材分 7 章介绍了足球运动战术教学与训练，内容分别为足球战术的基本概念与分类、现在足球战术发展趋势、足球比赛原则、比赛阵型、进攻和防守战术、战术教学与训练，其中第四、五、六章为重点介绍内容，分别就足球比赛阵型、进攻和防守战术进行了详细的介绍，先通过各种具体的阵型介绍让读者对其有一个具体的了解，之后再详细介绍各种进攻和防守战术，每种战术介绍都分别从概念、要点和训练方法示例来介绍，介绍内容时层次分明、图文并茂，可以使读者对足球战术有一个直观的认识。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	753
471	帆船（入门—进阶）	978-7-5670-2683-4	\N	Barry，Pickthall 著，曲春 译 	平装	1-1	16开	150.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2020-12-01	/book/c2ba2c6a-c62d-4b24-81f3-f215b5de1f011074431.jpg	你是帆船运动的新手吗？或者你是一位有经验的水手，想要扩宽技能范围、提高技术？无论你是哪种情况，《帆船》一书都能够非常好地给你提供帮助。 这本书非常易学，一步步地指导你有关绳结、导航、恶劣天气航行等方面的技能。《帆船》一书适用于各种水平层次的水手，为帆船运动的新手提供了直接且明确的建议，为有经验的水手提供了提高运动水平的专业提示及更快、更安全航海的窍门。 《帆船》涵盖以下内容及更多其他内容： 基础理论——帆船航行的科学原理、航行角度和帆具 航行准备——必要装备、登船和航路规则 首航——操船、潮汐、天气和导航 海上安全——提出申请、火灾和人员落水再加上数以百计的插图和照片，这就是你学习、提高、更新航海技能的方式。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	943
473	寻找油气的物探理论与方法	978-7-5670-2762-6	\N	李庆忠 	平装	1-1	大16开	260.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2015-12-01	/book/a39019fe-ac5b-48b9-963f-81a17e2f1dec1074441.jpg	　　第四册的主要内容包括近年来高分辨率地震勘探的进程与展望；节点地震仪器的研制及仪器改进方向；基于“三明治”模型的薄层AVO分析；基于免疫遗传算法的弹性参数变化率反演；基于混沌蚁群算法的弹性阻抗反演；深井VSP层析求偏移速度场的方法；极低信噪比地区三维地震勘探的理论探讨；英雄岭地区勘探地势与三维地震勘探历程；可控震源的技术进步与深层勘探；正确认识“两宽一高”的作用等。该书的读者对象为高校本、硕、博学生及从事地球物理工作的专家。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	370
474	青岛教育史	978-7-5670-1981-2	\N	翟广顺 著 	平装	1-1	16开	89.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2019-12-01	/book/7e9ce14f-b43d-43c8-acfe-b65612589e741074442.jpg	　　《青岛教育史：1891-1949》是青岛的地方教育史，时间跨度自1891年青岛建置至1949年青岛解放。《青岛教育史：1891-1949》通过挖掘逾半个世纪的教育史料，展现了近代青岛历史转型中的教育发展历程。《青岛教育史：1891-1949》通过总结近代城市教育发展历程的经验和教训，揭示了青岛教育特殊的地缘及特定的政治、经济、文化因素，诠释了近现代青岛教育的特殊性、突变性、包容性和阶段性特征。《青岛教育史：1891-1949》是中国城市教育发展史著述的成功范例，对于填补地方教育史空白、发挥资政育人的功能不无裨益。作为2019年新中国成立70周年的主题论著，《青岛教育史：1891-1949》还具有特殊的政治影响力和社会价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	914
475	中国文化常识（中法对照）	9787560061535	\N	国务院侨务办公室，国家汉语国际推广领导小组办公室 编 	平装	1-1	16开	67.00	\N	外语教学与研究出版社	\N	\N	\N	2007-03-01	/book/107ce444-c1d8-4365-bcb6-cef21c1204251074451.png	《中国文化常识》、《中国历史常识》和《中国地理常识》是由中华人民共和国国务院侨务办公室组织北京华文学院、南京师范大学和安徽师范大学编写的一套华文教学辅助读物，供海外华裔青少年通过课堂学习或自学的方式了解中国文化、历史、地理常识，同时供家长辅导孩子学习使用，在海外反响很好。 近年来，随着中国经济、社会的迅速发展和国际影响的不断扩大，海外学习汉语的人数，尤其是非华裔汉语学习者人数大幅度增加。为了进一步适应广大海外汉语学习者了解中华文化的需求，促进中外文化交流，中华人民共和国国务院侨务办公室授权国家汉语国际推广领导小组办公室对《中国文化常识》、《中国历史常识》和《中国地理常识》进行改编。 《中国文化常识》、《中国历史常识》和《中国地理常识》改编本是一套面向世界各国汉语学习者的普及型、口语化的文化辅助读物，适用于海外对中华文化和汉语感兴趣的各类人员。在中华人民共和国国务院侨务办公室编写的中英文对照版基础上，此次改编又增加了中文与德、法、日、韩、俄、泰、西班牙、阿拉伯语的对照版本。 国家汉语国际推广领导小组办公室委托高等教育出版社对《中国文化常识》、《中国历史常识》和《中国地理常识》进行改编，高等教育出版社对原书的部分内容进行了增删，修订了部分数据，重新遴选和修改了插图，并翻译出版英、德、泰语版本；外语教学与研究出版社翻译出版法、日、韩语版本；华语教学出版社翻译出版俄、西班牙、阿拉伯语版本。此次改编力求在原书强调科学性、思想性和实用性的基础上作进一步创新。希望本系列读物成为您了解中国的窗口，成为您通向汉语世界的桥梁。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	535
1797	幼儿深度学习——面向未来的学前教育丛书：幼儿深度学习课程设计与实施	978-7-5191-2947-7	\N	叶平枝 等 	0	1-1	16开	48.00	\N	教育科学出版社	\N	\N	\N	2022-03-21	/book/cbd06625-e3c9-4d3d-aace-9c2aa560befa1086117.jpg	本书首先阐明了幼儿深度学习的概念、特点、理论基础、影响因素，其次从课程目标、课程内容、课程实施和课程评价四个方面，阐述了幼儿深度学习的课程设计原理和具体方法，再次从情境带入、提问和回应、评价激励三个方面讨论了幼儿深度学习的教育策略。最后，作者通过幼儿深度学习课程故事案例及其评价提出可以如何推进幼儿的深度学习。本书详细解读深度学习的理论、课程设计原理、教学策略和课程案例，全面解决幼儿深度学习课程设计的理论和实践问题，具有较高的学术价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	438
477	砥砺十年铸华章：中国教育改革发展报告（2010—2020年）	9787519126629	\N	中国教育科学研究院 著 	平装	1-1	16开	155.00	\N	教育科学出版社	\N	\N	\N	2021-08-01	/book/a9626f2f-220f-41e2-8a3a-bb445950cd021074471.png	本书主体部分包括五篇。第一篇总体描述十年来我国教育事业主要发展成就，第二篇描述和分析立德树人根本任务落实情况，第三篇描述和分析各级各类教育发展状况，第四篇描述和分析重要领域的改革进展，第五篇描述和分析教育保障体系构建情况。 各章的分析架构包括主要成就、重大举措、理论与经验、问题与不足和未来展望等部分。 l “主要成就”旨在呈现“十年来取得的辉煌成就” l “重大举措”旨在回顾“十年来中央的重大决策部署与举措” l “理论与经验”旨在回答“是什么理论引领和规律性把握保证了辉煌成就的取得” l “问题与不足”旨在分析“现阶段教育事业发展还存在的短板弱项” l “未来展望”旨在提出“未来努力方向的建议”。 “主要成就”重在科学评估，“重大举措”重在突出重点，“理论与经验”重在提炼升华，“问题与不足”重在客观准确，“未来展望”重在切实可行。 第一篇为“成就概览”，包括教育改革发展十年概览、基本实现教育现代化、基本形成学习型社会、进入人力资源强国行列共四章内容。 第二篇为“立德树人”，包括德育为先、育人方式改革、学校体育美育、学校劳动教育共四章内容。 第三篇为“事业发展”，包括学前教育、义务教育、高中教育、职业教育、高等教育、继续教育、民族教育、特殊教育共八章内容。 第四篇为“改革创新”，包括人才培养体制改革、考试招生制度改革、现代学校制度建设、扩大教育对外开放共四章内容。 第五篇为“保障体系”，包括全面加强党的领导、全面推进依法治教、加强教师队伍建设、保障教育经费投入、加快教育信息化建设共五章内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	605
478	景观社会中的“异轨”与突围	9787303267866	\N	刘冰菁 著 	平装	1-1	16开	98.00	\N	北京师范大学出版社	\N	\N	\N	2021-08-01	/book/1c8928c4-b261-4554-8792-c2f63fe5a64f1074484.png	居伊·德波，是当代马克思主义研究中许多学者挥之不去的思想他者。德波的美学政治实践、情境主义国际与1968年左翼运动、景观社会批判、综合景观理论等，都成为了这批在1968年左翼运动中成长起来的学者不断回溯的主题。然而，在我们过往关于德波的景观社会理论的过于聚焦化的研究中，而对其景观社会理论也由于缺少思想史谱系的回溯，而被视为是从天而降的作品，全景式的德波思想形象恰恰被遮蔽了。因此，本书正是要从德波所处的现代资本主义统治的激烈转型的时代背景出发，以其一生写作的文本群为基础，来提供一扇踏入德波激进哲学全貌的任意门。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	873
479	文化研究、政治性解读和社会本体论	9787303267903	\N	孔智键 著 	平装	1-1	16开	88.00	\N	北京师范大学出版社	\N	\N	\N	2021-08-01	/book/ac0d7202-ca60-41ec-b069-028d4c4a30ec1074487.png	本书主要讨论的《政治经济学批判大纲》（通常也称为《1857-1858年经济学手稿》，文后以《大纲》代称）也是如此。如今我们不能试想一个没有写作《大纲》的马克思，就如同我们也已经不能设想一段不存在《大纲》的马克思主义发展史一般。在这一文本写作和形成160多年后的今天，我们有必要回过头来，重新审视和进一步探索它的理论效应史，重温它的内在价值与魅力，继而为我们理解当代语境下《大纲》的地位和理论观照现实之可能性提供一种基础性的视角。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	812
480	明天我会忘记	9787303269723	\N	[沙特] 艾麦乐·默罕默德·沙塔 著 	平装	1-1	32开	46.00	\N	北京师范大学出版社	\N	\N	\N	2021-07-01	/book/ceabbed1-7188-4975-91ab-55c9c16bbf541074494.png	《明天我将忘记》讲述了一位母亲自我救赎的故事。女儿三岁的时候，父亲听信了谣言休了来自印度尼西亚的妻子泰玛，带着女儿悄然离去。时隔多年，母亲历尽艰辛找到了自己的女儿，讲出了自己真正的故事，直面来自过去的幽灵。目光、眼泪、颤抖与支离破碎的话语表现着怨恨、后悔、遗憾与无限的爱怜。听到前夫的道歉，泰玛紧握着自己的尊严：“明天，先生……明天我会忘记……明天我会原谅你……”《明天我将忘记》展现了我们社会生活的一个侧面。沙特著名批评家阿齐兹·迪亚对作者评论道：“艾麦乐··沙塔博士的作品于我而言真是意外惊喜。相信当其他读者沉浸于作者精心构筑的小说情节，细细品味其简洁优雅的写作风格和行云流水的语言时，一定也会体会到这种惊喜。”	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	688
481	东北振兴与开放合作：2019东北亚经济论坛专家论文集	9787565443374	\N	东北财经大学东北亚经济研究院 	平装	1-1	16开	46.00	\N	东北财经大学出版社	\N	\N	\N	2021-08-01	/book/2d597523-0114-4e61-8b0a-3f8ffce686031074500.jpg	"本论文集是对与会专家学者真知灼见的集结汇总，按照具体探讨的问题共分 为七篇： 第一篇“振兴东北与重塑辉煌”。本篇汇集了四位特邀嘉宾的主旨报告，从 宏观角度既回顾了十余年东北振兴所取得的成果，也点出了当前所面临的亟待解决的重点难题，更为破解发展困局指明了方向。在“滚石上山、爬坡过坎”的关键阶段，这些高屋建瓴的见解为东北全面振兴、重塑昔日辉煌廓清了疑虑、提振了信心。 第二篇“东北振兴与企业力量”。企业是经济发展的基础力量，本篇汇集了 来自中小企业协会、大型国企、知名民企，以及辽宁、吉林、黑龙江、内蒙古代表性企业的高层管理人员的报告内容，展示了不同类型、不同地域的企业在东北振兴中做出的贡献和努力，以及企业家眼中的东北振兴面临的挑战与机遇。 第三篇“东北振兴与东北经济韧性”。东北经济的韧性是对国家经济贡献的 重要支撑，是可圈可点的亮色，也是未来东北全面振兴的底色。本篇汇集了国内业界四位知名专家学者对东北振兴提出的建议，具体聚焦于重大战略性工程、文化振兴、产业发展与园区建设等方面，既具有理论支撑，又有实践引领。 第四篇“‘一带一路’与东北亚区域合作”。“一带一路”倡议是党中央在新时期统筹国内发展与对外开放高层次结合的一个大的战略，是深化我国与周边国家开展区域经济合作的总思路、总纲领和顶层设计。本篇汇集了来自中国、韩国和蒙古国的学者和优秀企业家对“一带一路”框架下国家发展规划对接的路径建议、已有成果的展示和对未来的展望。 第五篇“东北亚贸易与《中日韩自由贸易协定》”。中日韩经济合作是推动 东北亚区域经济一体化发展的重要基础，在单边主义、贸易保护主义抬头的背景下，中日韩三国应更加团结，努力打造新的《中日韩自由贸易协定》（FTA）。本篇汇集了来自中国、日本和韩国的多位专家学者对中韩、中日经济合作及中日韩FTA 发展前景的新颖观点和结论，理论与实际相结合并富有现实意义。 第六篇“农村金融与东北乡村振兴”。重农固本，国之大纲，三农的战略地 位十分重要，社会主义现代化离不开农业农村现代化，东北全面振兴也离不开乡村振兴。本篇汇集了来自政府部门、高校科研机构、金融机构的多位专家学者对如何改进农村金融服务、运用金融科技、促进农业产业发展和乡村振兴的重要观点和举措建议。 第七篇“金融科技与东北经济振兴”。金融与科技融合发展方兴未艾，发展 势头迅猛，而东北经济转型升级已经进入攻坚深水区，金融科技能否成为破解转型难题的源头活水，以及如何拥抱金融科技助力东北经济发展亟待深入讨论。本篇汇集了政府部门领导、银行机构和新兴科技公司高级管理人员对金融科技和科技金融的理解，对金融科技应用实践成果和经验的总结，以及对东北依靠金融科技加速发展的优势和空间的见解。"	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	366
485	信息技术基础	978-7-307-22570-1	\N	张剑波、邵秀杰、刘秀艳 主编；张润娟、国灵华、常磊 副主编 	平装	1-1	16开	49.00	\N	武汉大学出版社	\N	\N	\N	2021-09-01	/book/ecb6cb27-a906-4842-818b-bdc8fc58dd3f1074539.jpg	本教材紧扣“高等职业教育专科信息技术课程标准（2021年版）”的主旨要求，涵盖新一代信息技术概述、文档处理、电子表格处理、演示文稿制作、信息检索、信息素养与社会责任等主要内容。教学组织上选择当前技术先进、应用广泛、自主可控的office 2016等平台和工具，以真实项目案例为依托，采用“任务描述-技术分析-示例演示-任务实现-能力拓展”的教学结构，重点突出“理实一体、任务驱动、分层递进”的有利于学生综合能力培养的教学模式，开发了“思政园地”“云端微课”等丰富的教学资源，构建了新形态立体化教材新范示。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	332
486	扬子鳄刑辩联盟精选刑事案例集——辩点的挖掘与应用	9787567236592	\N	周小羊 主编 	平装	1-1	16开	66.00	\N	苏州大学出版社	\N	\N	\N	2021-10-01	/book/f5b265e4-4b76-4435-9f67-42d990fb8a1e1074546.png	刑辩是围绕着“辩点”展开的。这本书就聚焦“辩点”。刑辩就是一个挖掘和运用辩点的过程。法庭辩论是对辩点的阐述。办理认罪认罚的案件也要拿着有利、有力的辩点去协商才会有更好的效果。本书收录了来自国各地的刑辩同仁们41个刑辩案例，不管是重大案件还是普通案件，知名案件还是一般案件，重罪案件还是轻罪案件，大人物的案件还是小人物的案件，各位律师在他们代理的案件中通过专业和智慧找出了各种各样的辩点，运用辩点的过程更是各有各的精彩，各有各的妙招，让人受益匪浅	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	600
487	中国湖泊历史图谱	9787305239649	\N	薛滨，姚书春 编 	平装	1-1	16开	68.00	\N	南京大学出版社	\N	\N	\N	2020-12-01	/book/535d36eb-6509-4c83-81e7-00eeb52d74241074547.png	本书运用我国丰富的历史地图，再现了约三百年来我国湖泊的变化，架起了千年和现代之间的桥梁，丰富并形象地展现了百年尺度的湖泊环境变化。汇编了我国历史时期重要湖泽的图件、水利、测绘、文献资料，结合中国湖泊演变研究的最新成果，以时间为主线，将我国历史上重要湖泊的演变横向以图的形式在有时间刻度的横坐标上铺展开来，由湖泊演变指示的我国环境变化如时间隧道展现在眼前；纵向以重要环境、历史事件为单位对湖泊的变化加以描述，以翔实的图文史料为我国环境演变及相关研究提供科学参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	622
488	长江中下游湖泊沉积地球化学与环境演变	9787305213816	\N	薛滨，姚书春 等 著 	平装	1-1	16开	58.00	\N	南京大学出版社	\N	\N	\N	2018-12-01	/book/89d9fa07-cfda-4dbc-8e89-a0101fa68d291074561.png	　　长江中下游是我国湖泊为集中的区域之一。近百年来该区湖泊在自然和人为的双重胁迫下发生了巨大改变，湖泊的众多服务功能受到了影响。《长江中下游湖泊沉积地球化学与环境演变/湖泊学研究系列丛书》从湖泊沉积环境地球化学的角度出发，在多年研究的基础上，并收集整理了该区其他研究成果，揭示了湖泊沉积物堆积速率变化、沉积物碳氮磷埋藏、湖泊沉积物重金属和有机污染的时空变化特征，揭示了长江中下游湖泊近现代湖泊流域环境演变的趋势特征，地球化学本底，以及与人类活动的关系。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	733
489	压水堆核电厂燃料管理	978-7-5693-1776-3	\N	吴宏春 	平装	1-1	16开	35.00	\N	西安交通大学出版社	\N	\N	\N	2021-08-01	/book/d927396d-cb29-48ac-b18c-663ce994f55d1074564.jpg	该教材系统地包括了核反应堆燃料管理的基本概念、单循环燃料管理与优化、多循环燃料管理与优化、燃料管理计算方法简介、堆芯核设计、换料堆芯安全评价、反应堆启动与物理试验、核燃料制造与核废料处理等，可作为核能科学与工程专业的本科生或研究生教材，也可供核科学与技术相关学科的工程技术人员及研究人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	699
497	汉字里的古诗词漫画版	9787305243653	\N	拾鹿童书 	\N	1-1	12开	140.00	600.0千字	南京大学出版社	264	\N	\N	2021-07-01	/book/99af8d1b-3e25-476e-9a21-987ba7837d359787305243653.jpg	这是一套用漫画和故事展现古诗词魅力的少儿读物，共有4册。本套书选取了116首经典古诗词，覆盖了“小学生必背古诗词”的所有篇目。本套书图文并茂，用唯美的古风漫画描绘古诗词的意境；通过青少年喜爱的多格漫画的形式，结合幽默诙谐的语言，讲述发生在诗词名家身上的故事，描绘古诗词背后的趣味故事；同时，共选取了116个汉字，图解汉字从甲骨文、金文到隶书、楷书的演变过程，解析汉字的本义，并给出对应的飞花令诗句，让小读者从汉字的角度感知古诗词的美感。本套书通过漫画和故事，让古诗词“活”了起来，本套书可帮助小读者理解古诗词，提升其诗词鉴赏能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	206
490	致用日语	9787513585064	\N	王晓东 著 	平装	1-1	16开	36.00	\N	外语教学与研究出版社	\N	\N	\N	2017-02-01	/book/d68f6a26-8ec4-42e8-a0ff-1e3cacac3a911074573.png	《致用日语会话教程》是“十二五”高职高专日语专业国家规划教材《致用日语》基础课系列教材的核心教材，是依据高职高专日语专业的培养目标和教学要求，在充分调研的基础上，根据高职高专日语专业学生的实际需求，自主研发的一套全新的日语会话教材。本教材紧密结合我国目前高职高专日语教学的实际情况，同时充分吸收和借鉴国内外优秀日语会话教材的特点，力求用新的日语教学理念引领高职高专专业日语会话教学的发展方向。本教材编写思路是，配合《综合》课的主要语法内容与进度，训练《综合》课所学语法知识，运用《综合》课语法知识训练和构建学生的说话能力。同时，通过基础会话、应用会话、语用解释、主题扩展词语、基础练习、应用练习等手段，系统扩充主题相关知识，强化口头输出能力，最终达到“帮助学习者构建起完整的关于日常生活、学习、工作等领域的日汉双语表述体系”之目的。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	818
491	舞马与驯鸢：柯睿自选集	9787305233029	\N	柯睿 	0	1-1	小16开	68.00	420.0千字	南京大学出版社	440	\N	\N	2021-05-07	/book/aa7a7bc4-b8f0-481e-a5e4-4479705040849787305233029.jpg	本书为《海外汉学研究新视野丛书》之一。作者精心选择自1976年博士毕业后代表性汉学研究学术论文12篇，主要涉及中古中国的文学、宗教和文化史研究，在时间跨度上包含汉末建安、南北朝以及作者用力尤多的唐朝三百年，集中体现了作者学术成就的精华，为学界提供了不同的研究方法与研究角度，有助于进一步打开中西对话交流对话之门。同时，本书由其本人门生担任翻译与编纂工作，在富有严谨学术精神的兼具可读性，同时也使本书的出版具有特殊的意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	590
492	莎士比亚：欲望之火	9787305237164	\N	（法）勒内·基拉尔（René Girard） 	\N	1-1	大32开	90.00	370.0千字	南京大学出版社	548	\N	\N	2021-07-30	/book/c2be5a57-9e2a-4496-a05e-d094a4838ea29787305237164.jpg	本书是法国著名人类学家、哲学家勒内·基拉尔研究莎士比亚的专著。基拉尔以其欲望模拟理论而享有国际盛誉，在他看来，这一理论也贯穿于莎士比亚的作品中。在本书中，作者用欲望模拟理论分析了莎士比亚的《仲夏夜之梦》《无事生非》《裘力斯?凯撒》《威尼斯商人》《第十二夜》《特洛伊罗斯与克瑞西达》《哈姆莱特》《李尔王》《冬天的故事》《暴风雨》等剧作。本书既精密又现代，既宏大又惊人，是文学、人类学和精神分析学相关研究者及爱好者不容错过的开创性作品。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	252
493	中国新文学的多元审美选择	9787305240027	\N	王爱松 	\N	1-1	小16开	88.00	274.0千字	南京大学出版社	320	\N	\N	2020-12-31	/book/8d472d79-67ae-4dfa-8c0a-7d535bcd86fa9787305240027.jpg	南京大学中国新文学研究中心是1999年12月首批入选的教育部人文社会科学重点研究基地。本书稿是该研究中心王爱松教授的个人学术论文自选集，通过梳理中国新文学的多元审美选择，探讨中国新文学发生发展的轨迹和规律。主要涉及中国现当代文学思潮研究，如京海派论争与南北文化差异、出版制度与三四十年代的中国文学、伤痕文学研究等；当代作家作品研究，如张贤亮、王朔、王蒙、张炜、李锐等；文学叙事研究，如新潮小说的历史叙事、军事文学的形态、互文性与中国当代小说等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	706
494	安托南·阿尔托	9787305240485	\N	(美)大卫?A.谢弗（David A. Shafer） 	\N	1-1	大32开	65.00	217.0千字	南京大学出版社	288	\N	\N	2021-06-22	/book/3c336d75-eb82-46d1-b9ce-63cc124a68c69787305240485.jpg	本书是法国著名戏剧理论家、演员、诗人安托南·阿尔托（AntoninArtaud）的传记。阿尔托是法国“残忍戏剧”的创始人，主张把戏剧比作瘟疫，经受它的残忍之后，观众得以超越于它。其戏剧理论和创作深刻地影响了热内、尤奈斯库等人的荒诞派戏剧。这部传记探索了这位20世纪最神秘的人物和最独特的思想家之一的生活，书写了他的坎坷、疾病以及独特的思想和戏剧理念，揭示了他与众多法国极具影响力的文化人物交往的历程，也深刻地展示了他人生存在之旅的孤独乃至孤立。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	270
495	说课、微型课与模拟授课技能训练与指导	9787305241550	\N	刘毓航,蔡旺庆 	\N	1-1	16开	42.00	290.0千字	南京大学出版社	196	\N	\N	2020-12-31	/book/81ebee2b-9f00-4560-9c62-4b361cc346cc9787305241550.jpg	说课、微型课以及模拟授课教学已经在师范院校引起重视并积极实施，目前已经有很多师范院校把说课、微型课和模拟授课教学技能纳入必修课程或选修课程。本书有三篇共十三章内容。第一篇是说课，共有六章内容，主要阐述了说课的意义、说课的认识、说课的方法、说课的技巧和艺术以及说课模式、说课案例等；第二篇是微型课，共有三章内容，主要阐述了微型课的意义、特点、教学策略、教学评价以及案例等；第三篇是模拟授课，共有四章内容，主要阐述了模拟授课的意义、基本结构、规范要求、教学策略、教学评价以及案例等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	433
531	百年交大故事撷英	9787313252247	\N	上海交通大学校史编纂委员会 编 	平装	1-1	大32开	35.00	\N	上海交通大学出版社	\N	\N	\N	2021-10-01	/book/4d153e9f-7a0c-4d42-ba94-c54b8ed342541074972.png	本书精选了20篇体现交大历史文化的重要文献、文章或访谈录，从不同的视角出发，生动描绘了交大在不同历史时期的重要事件、精神风貌和校园趣事，为今人感悟交大文化、重温交大历史、促进励志成才提供了鲜活的历史记录。 本书适合对上海交通大学不同发展时期人物故事、校园趣事感兴趣的青年学生阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	653
496	英语测评	9787305242960	\N	杨香玲 	\N	1-1	小16开	50.00	201.0千字	南京大学出版社	192	\N	\N	2021-09-01	/book/edab1243-fcd3-47d5-8615-46f525df89f99787305242960.jpg	随着国家英语能力等级量表研发、国家外语能力测评体系建设工作的有序推进，作者针对不断优化的顶层设计之下一线英语教师存在的测评理念陈旧，测评知识缺失，测评技能低下等问题进行深入研究。本书分为三部分。第一部分测评理论，论述了测评的目的、方法、分类、原则及其开发；第二部分测试性评估，详述了听、说、读、写四项语言技能的测评；第三部分非测试评估，阐述了课堂观察、学习档案袋、学习日志、叙事评价、访谈、学生自评、同伴互评等评估手段。本书着力将抽象的理论用具体的教例呈现出来，将划一的测评规则用操作的方式表现出来，将先进的测评理念用技能的方式外化出来，力求为英语教师提供便于实际应用的测评手册。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	561
514	新视野商务英语视听说（第三版）下册	9787521307948	\N	马龙海 李毅 李慧娟 编 	平装	1-1	16开	45.90	\N	外语教学与研究出版社	\N	\N	\N	2021-10-01	/book/11281bac-f13b-4e30-907b-3f4f973b65f01074762.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	615
498	南大戏剧论丛	9787305244711	\N	胡星亮 	\N	1-1	16开	40.00	240.0千字	南京大学出版社	196	\N	\N	2021-06-25	/book/677936fa-aad4-41db-bce7-68925ac361579787305244711.jpg	本书为戏剧学学术研究图书，着重探讨当前国内戏剧研究动态、前沿理论问题、古今中外重要戏剧现象和问题，有戏剧创作与批评、古今剧史新论、中国现当代戏剧、外国戏剧、学术史思辨等栏目，收入的论文从文献史料和作品文本入手，结合不同时代背景，在细致梳理、深入分析的基础上，解读作家作品，研究作品的形成过程，探讨传统戏剧与现代话剧的分离，剖析戏剧理论、戏剧观念、戏剧美学的内涵及其演变，揭示其中蕴含的丰富的戏剧文化和戏剧精神。本书作者均为专业领域的研究者，文章论述严谨，逻辑清晰，观点鲜明，论题和研究方法富有新意，代表了专业领域内最新研究成果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	200
499	中国文物学教程	9787305244896	\N	周晓陆,殷洁,张晋政 	\N	1-1	16开	80.00	450.0千字	南京大学出版社	308	\N	\N	2021-06-18	/book/b8f4a8b0-c575-4a14-a3b0-362f3c390fda9787305244896.jpg	这是一本系统介绍文物学的通识教材，适合大学本科使用，全书介绍了文物学的基本概念、主要知识体系、理论与方法，文物学与相关学科的联系，重要的文物学的人物以及及研究著作等。作者长期从事文物的鉴定实务与理论研究，且从事该领域的教学，本书稿是在多轮大学授课基础上形成的以部有关文物学系统知识的教材，书中有丰富的图片，单元设计也非常符合教学单元，是一部从形式到内容都有新意的文物学教程，适合大学文博专业学生、文物爱好者以及文物实务工作者参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	734
500	VBSE跨专业综合实训工作手册	9787305244957	\N	陈秀秀,赵燕 	\N	1-1	16开	62.00	322.0千字	南京大学出版社	212	\N	\N	2021-07-20	/book/939ce2bb-b7c0-43cb-a145-4e315c5ace199787305244957.jpg	VBSE跨专业综合实训工作手册采用新道VBSE软件平台，以智慧商科多专业综合实训多年相关教学经验汇编，本书以制造企业为样板，包括五个部分内容，项目一为课程导学、项目二为实训准备、项目三为供产销仿真实训、项目四为组织内部日常业务、项目五为自主经营。本综合实训手册围绕制造企业搭建了一个虚拟的商业社会环境，为学生真实打造了一个工业园区生产氛围，让学生在实训中体会到现实操作与课堂学习的联系与区别，为学生更好更快地融入社会企业生产起到积极推动作用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	735
501	建筑制图与识图	9787305245367	\N	吴伟,张多峰 	\N	3-1	16开	42.00	347.0千字	南京大学出版社	240	\N	\N	2021-06-01	/book/c1ffaaaf-b0e0-44c2-a02a-87b737e7277e9787305245367.jpg	本书是为高等职业院校建筑工程类专业学生编写的教材，全书依据高等职业院校建筑工程技术专业人才培养方案的基本要求，按照“任务驱动，教、学、做一体化”的课程教学模式编写，在6个教学项目模块中设计了21个学习型教学任务，内容包括制图基础知识、正投影原理与三视图绘制、正等轴测图和斜二轴测图绘制、组合体三视图识读、建筑形体图示表达、房屋建筑施工图识读与绘制、房屋结构施工图识读与绘制、室内给排水施工图识读等。教学内容按照建筑工程“施工员”的岗位任职要求选取，教学任务设计贴近工程实际，强化工程图识读能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	505
502	证券投资理论与实务	9787305245589	\N	马瑞 	\N	3-1	16开	54.00	399.0千字	南京大学出版社	296	\N	\N	2021-08-09	/book/047c4410-2d09-4608-9310-b42a7d9e1e599787305245589.jpg	本教材的内容分为导语篇、工具篇、市场篇，以及实务篇四个部分。既侧重于证券知识的介绍，又着重于证券市场的操作，在证券知识的介绍中，主要包括项目一认识证券与投资，项目二千股千寻——走进股票的世界，项目三另一种投资工具——债券，项目四专家理财产品——证券投资基金，项目五金融产品中的“双刃剑”——金融衍生工具，项目六证券市场运行，项目七证券市场的中介机构；在证券市场的操作中，主要包括项目八炒股前的准备，项目九证券投资基本面分析，项目十证券投资技术分析，以及项目十一证券投资策略与技巧。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	900
503	货币银行学	9787305246012	\N	范从来,王宇伟,周耿 	\N	5-1	16开	65.00	676.0千字	南京大学出版社	412	\N	\N	2021-08-02	/book/80bfa030-3703-47a4-86e2-18b85d5141ba9787305246012.jpg	本书强调了货币银行学作为宏观金融基础课程的特点。近年来，关于金融学的研究内容，在我国学术界一直存在争论，我们认为，从公司的角度研究资金运行的公司金融和从资本市场运行机制角度研究资金运行的微观金融固然重要，但从宏观层面研究资金运动的宏观金融也是金融学不可缺少的一部分，本书就着重从这个方面来探讨货币运行与经济运行间关系以及宏观金融体系的运行机制问题。本书突出现实性，注重与中国实际的结合。在本书的写作中，我们一直注意以中国金融问题为主线，在各部分都结合理论对中国的实际问题进行了相应的分析，其中的一些还以专栏的形式呈现给读者，提高了教材的可读性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	546
504	外国文学经典导读	9787305246708	\N	龙云 	0	1-1	16开	42.00	390.0千字	南京大学出版社	208	\N	\N	2021-09-01	/book/2324e91f-e05a-47b2-b6e9-95adb4391d6a1074707.jpg	本书以外国文学史为纲，精选上迄古希腊、古印度，下止20世纪当代外国文学12位大家的经典代表之作为教学内容，从作家生平、情节简述、作品评析等多个层面切入，解析经典文本的思想情感、审美价值和文化意义，全面而系统地介绍了文学四种体裁的艺术特征和文化内涵，使读者在阅读中感悟文字的魅力，在经典中开拓求知的视野。本书旨在培养学生对文学作品文本内和文本外启发研究思维，掌握文学鉴赏和美方式，探究世界文学发展脉络，是英语专业、翻译专业、英语教育专业等专业学生及文学方向研究生的必修教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	350
505	走出东拉河	9787305247057	\N	李红岩 	\N	1-1	大32开	35.00	214.0千字	南京大学出版社	280	\N	\N	2021-07-21	/book/59e07d87-d718-45e6-88be-8d756ed1009f9787305247057.jpg	该书是一本文集，共45篇，分为四个部分，叙写了作者的故乡生活、故土风物；驼城生活、塞北风光；长安生活、长安求索；大美人性、人间亲情。从作者的童年、故乡写起，一直写到作者的知命之年，写了一个牧羊少年从复读生到博士生，从乡村到都市，从塞外大漠到关中平原近五十年里的奋斗历程。在温醇的叙述中写出了人性、人情的无穷魅力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	821
506	钢琴基础与儿歌即兴伴奏	9787305247149	\N	闫冉,刘雨燕 	\N	1-1	大16开	40.00	313.0千字	南京大学出版社	188	\N	\N	2021-07-13	/book/304983ca-8b5f-4504-bd2b-a67ac8efa32c9787305247149.jpg	《钢琴基础与儿歌即兴伴奏》是以讲授钢琴基础与儿歌即兴伴奏相结合的综合性教材，共七章，前四章为钢琴基础理论，第五章实例分析儿歌并配以公示化伴奏，通过公式化伴奏掌握儿歌即兴伴奏的伴奏织体、方法和步骤，第六章实例分析儿歌配以弹唱伴奏，掌握无旋律即兴伴奏技巧，并附自配曲供学生练习。第七章为综合性大型曲目。教材可面向师范院校小学教育专业、学前教育专业的音乐模块课程使用，通过公式化伴奏织体掌握儿歌即兴伴奏的方法，由浅入深、循序渐进使学生达到能够独立自主地进行儿歌编配及弹唱的学习目标。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	802
507	建设工程法规	9787305248290	\N	李海霞,何立志,曾欢 	\N	3-1	16开	45.00	458.0千字	南京大学出版社	264	\N	\N	2021-06-15	/book/f63fbbee-fb19-4e4b-9b79-90b2d98051e69787305248290.jpg	本书是为高校本科学生编写的教材，全书依据土木工程类专业的建设工程法规课程标准组织编写，内容包括建设工程基本法律知识、建设工程许可、建设工程发包与承包、建设工程合同、建设工程质量、建设工程安全生产、建设工程标准化、环境保护、劳动合同等方面的法规。每个模块之后都附有涵盖本模块主要内容的复习思考题，重要知识点均有法规实务案例解析。书中内容均是根据土木工程领域最新的法律、法规文件编写，力求全面、准确；同时，又紧缩篇幅，贴近教学实际，便于读者阅读理解，学以致用。本书面向土木工程类专业方向，内容选择具有针对性，语言通俗易懂，注重理论与实践的结合；形式上具有新颖性，教学资源力求立体化，注重传统与时代的结合。本书是土木工程类专业开设的建设工程法规课程的教材，可作为高等院校土木工程及相关专业的教学用书，也可作为土木工程领域的监理、设计和施工单位的工程技术人员、管理人员学习和工作的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	118
509	新时代核心英语教程	9787521323313	\N	蒋洪新 陈立平 郑祥丽 李志雪 编 	平装	1-1	16开	54.90	\N	外语教学与研究出版社	\N	\N	\N	2021-01-01	/book/b50cfd32-651b-4f5d-8875-720239c0e2231074731.png	《新时代核心英语教程写作》系列共三册，适合普通高等学校本科英语类专业英语写作课程使用。OO册涵盖句子写作和段落写作；第二册围绕篇章写作；第三册聚焦应用文写作和学术论文写作。 全面覆盖写作知识、写作策略和写作能力三个方面，任务难度与写作话题循序渐进。 广泛吸收国内外写作教学理论与实践经验，关注中国学习者特点，理论概念阐述与实际范例讲解兼顾，助力写作学习。 练习设计与理论讲解有机串联，系统科学；融入四、八级等国内考试常见题型，满足备考需求。 既从各类真实的语料中选取例句和样文，又选用名家作品供学生学习和模仿，语言优美地道。 配备电子版教师用书、PPT课件和电子版范文集，帮助教师灵活组织教学内容与课堂活动，提升教学效果。 本书为第二册。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	348
510	新视野大学英语	9787560072364	\N	吴勇 张忠魁 等 	平装	1-1	16开	21.90	\N	外语教学与研究出版社	\N	\N	\N	2011-03-01	/book/20ffdf96-f3e7-4143-8cb9-2f85dc97a6341074737.png	《新视野大学英语:泛读教程1(第2版)》主要内容简介：《新视野大学英语》（第二版）系列教材是普通高等教育“十一五”规划教材。本教材在保持第一版优势的基础上，依据《大学英语课程教学要求》的精神及大学英语教学的发展方向，对整体结构和内容进行了全面完善和提高。作为一套与现代信息技术相结合的立体化大学英语教材，《新视野大学英语》（第二版）通过课本.光盘。网络等不同载体的有机结合，为新形势下的大学英语教学提供多层次，多渠道，立体化的服务。先进的教学理念：教材编写充分考虑教学过程。注重教学内容、教学模式、教学方法及教学手段的创新，遵循分类指导和因材施教的原则，倡导课堂教学与自主学习相结合，提高语言能力，培养学习策略。完备的教材体系：系列教材包含1-4级，每级有《读写教程》、《听说教程》、《泛读教程》，《快速阅读》和《综合训练》。各教程自成一体，又相互联系，在巩固和强化专项能力的同时提高学生的语言综合应用能力。丰富的主题内容：教材内容以主题为线索，涉及文化交流、道德情感、信息技术、科学教育、社会焦点等各个方面，选材注重信息性、趣味性、时代感和文化内涵，有助于开拓视野，培养人文素质和文化意识。多样的活动设计：教材针对不同技能的培养需要设计了各类训练活动，充分体现输入与输出的有机结合以及从语言知识到交际能力的转化。活动形式多样.目标明确，鼓励学生积极思考和充分参与。立体化的教学支持：同步提供课本、光盘与网络课程，丰富和拓展教学内容，创造多元、立体、便捷的语言学习环境，帮助学生巩固知识，提高能力。同时为教师提供多种教学资源，支持教师的教学与科研工作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	125
1444	科学技术发展简史(第四版)	978-7-301-25465-3	9787301254653	王士舫、董自励 	0	4	16开	79.00	528.0千字	北京大学出版社	496	7301	\N	2022-01-07	/book/bcf91282-dc90-4536-b67c-0479b9429b891083537.jpg	本书按照古代、近代和现代的历史顺序简要介绍了两千多年来古今中外科学技术发展的主要成就。在内容取舍上，突出了现代部分，并密切跟踪当今科学技术方面的新发现和新发明。本书被国内多所院校选为教材。第四版增加了最新的科技发展情况，并对已有内容进行调整和完善。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	281
511	大学思辨英语教程	9787513557818	\N	蓝纯 孙有中 	平装	1-1	16开	53.90	\N	外语教学与研究出版社	\N	\N	\N	2015-08-01	/book/c57fe97a-24cd-4fcc-bd8c-604a3cbd8afb1074739.png	《大学思辨英语教程 精读1 语言与文化》共15个单元，分为“语言”、“文化”以及“语言与文化的交流”三个模块，每个模块包括五个单元，每个单元分别讨论语言与文化领域的一个主题，包括Text A和Text B两篇课文。为了确保课文的经典性，编者们从中外图书馆海量的英文著作和文集中遴选出30篇课文。入选的课文都兼顾了内容的思想性和语言的规范性，且难易适当。考虑到文章的时效性，编者在注重语言和主题的时代特征的同时，尽量选择名家经典作品，且所讨论的主题大多涉及语言和文化领域的经典问题。在安排每个单元的Text A和Text B时，还特别注意了两篇文章从不同侧面切入单元主题，观点相异或相互补充，这将有助于学生开阔视野，拓展思维，对同一个问题进行批判性分析。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	374
512	当代大学德语(1)(学生用书)	9787521310306	\N	梁敏，聂黎曦（Michael，Nerlich）（德），佟秀英，常和芳 著 	平装	1-1	16开	56.00	\N	外语教学与研究出版社	\N	\N	\N	2019-08-01	/book/11ea39c9-0a5f-4117-9ec8-ec2f7b1067601074744.png	《当代大学德语（1）学生用书》是为高等学校德语专业学生编写的德语语言基础教程。本书由语音教程和基础教程两部分组成：语音教程部分共分6课，要求通过简单的交际情景使学生掌握德语的语音和基本语调，了解德语的读音规则。每课有一定数量的重点音素及语调练习，教师可根据具体情况选择使用；基础教程部分共12课，分三个单元。每个单元的最后一课，即第4、8、12课的内容为师生共同探讨学习德语的技巧和方法，同时也是复习课，复习前三课所学的内容。 《当代大学德语1》(学生用书)是一本实用性强的教材，内容必须“与时俱进”。自GrundstudiumDeutsch一册1991年问世以来，中德两国在各个领域都发生了许多变化，书中一些内容已显得过时；同时德语教学界也在不断探讨，积累了不少新的、有益的经验。因此，在原有基础上对该书进行重新编写便迫在眉睫，2002年编者正式开始了新教材StudienwegDeutsch的编写工作。此教材于2002年分别被国家教育部和北京市选入“普通高等教育‘十五’国家规划教材”及“北京市精品教材”之列。这就更加激励我们兢兢业业地把工作做好。StudienwegDeutsch共分四册，每册除主教材外还配有练习手册、教师手册、听说练习册及录音磁带。一册由语音教程和基础教程两部分组成：语音教程部共分6课，要求通过简单的交际情景使学生掌握德语的语音和基本语调，了解德语的读音规则。每课有一定数量的重点音素及语调练习，教师可根据具体情况选择使用；基础教程部分共12课，分三个单元。每个单元的之后一课，即第4、8、12课的内容为师生共同探讨学习德语的技巧和方法，同时也是复习课，复习前三课所学的内容。新教材强调调动学生学习的积极性和培养学生的学习能力，使学生树立勤学苦练的优良作风，掌握科学的学习方法，养成主动参加语言实践的习惯。由于这套教材是专门为中国高校学生编写的，对中国学生学习中的困难、习惯、特点以及他们生活的环境都给予了充分的关注。因为从语音到语法，从交际意向的语言表述到笔头论证的方式，都能体现出文化差异。对一种全新的语言，一种别样的文化和一种不同的社会现实的接近，也是对本国语言、文化和社会现实的比较和认同的过程。这套教材给予学习者的不只是新的语言和新的学习途径，同时也能帮助学习者逾越社会文化障碍，沟通人际关系。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	409
513	现代西班牙语(学生用书)(1-2自学辅导)	9787521311327	\N	董燕生，刘建 编 	平装	1-1	16开	65.00	\N	外语教学与研究出版社	\N	\N	\N	2019-09-01	/book/83a9a873-a8f7-4fde-9033-648bc374b4671074754.png	《现代西班牙语学生用书(1-2)自学辅导》为《现代西班牙语学生用书1》和《现代西班牙语学生用书2》配套自学辅导用书。内含课文译文及习题答案。本册供大学西班语专业一年级上学期和下学期使用，同时适用于社会西班牙语初学者。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	647
516	中国志留纪地层及标志化石图集	9787308198424	\N	王光旭，詹仁斌，王怿，黄冰，吴荣昌 等 著 	平装	1-1	16开	148.00	\N	浙江大学出版社	\N	\N	\N	2020-07-01	/book/81749f50-ff2f-47d5-8f34-09715bfaac491074780.png	　　第一部分由第1～6章组成。第1章简述了国际志留纪年代地层划分及研究现状。第2章对中国志留纪地层区划进行概述。第3～6章分别介绍了华南、塔里木、中泰缅马及兴安等4个块体的志留系发育情况及其各自的代表性剖面（或综合剖面），其中华南板块包括湖北宜昌大中坝、重庆秀山溶溺、天声曲靖、贵州石阡雷家屯、贵州桐梓代家沟、四川广元宣河、江西武宁-修水等剖面（或综合剖面）塔里木、中泰缅马及兴安分别选取了新疆柯坪铁热克阿瓦提、云南保山老尖山和黑龙江黑河等剖而（或综合剖面）作为各自的参照标准。 　　第二部分即标志化石图集。该部分实际上属于生物地层学的范畴，鉴于其在地层学研究及野外实践中的重要性而单独成章。考虑到我国志留纪各化石门类研究程度上的差别，该部分仅涉及生物地层学研究较精细的11个化石门类，它们（及其撰写者）分别是：笔石；牙形类；几丁虫；腕足类；三叶虫；皱纹珊瑞；鹦鹉螺类；苔藓虫；古植物与孢粉；疑源类；遗迹化石。 　　《中国志留纪地层及标志化石图集》是“中国古生代地层及标志化石图集”系列丛书之一，可作为地质调查、油气和矿产资源的勘探和开发及地质学等领域研究的重要参考书和工具书，也可供高等院校和研究院所教学使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	762
517	中国石炭纪地层及标志化石图集	9787308198387	\N	王向东 胡科毅 黄兴 乔丽 王秋来 等 	平装	1-1	16开	188.00	\N	浙江大学出版社	\N	\N	\N	2020-07-01	/book/b2394c7d-2455-4cff-ad81-b2c8580ea8201074782.png	《中国石炭纪地层及标 志化石图集》详细介绍了石 炭纪的 和 年代地层 划分和对比、中国石炭纪地 层的区域分布特征，具体分 析了中国几大区块的沉积类 型和地层发育情况，选择了 13条有代表性的基干剖面进 行了详细的综合地层描述。 书中有关地层介绍的部分， 引用了一些本书作者及其他 作者曾经发表过的内容；图 版中的部分化石图片已经在 其他出版物中发表过，也引 用了其他作者的化石图片， 在此说明和致谢。另外，经 过详细分析中国石炭纪的海 相化石，包括牙形类、非□( 特殊字体)有孔虫及□(特殊 字体)类、珊瑚、腕足动物 、头足动物等，系统整理了或部分区域内地层划分 和对比的重要标志化石，形 成130幅图版，包括牙形类 38幅，有孔虫34幅(其中蜒 类20幅)，菊石20幅，腕足 类18幅，四射珊瑚20幅。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	280
518	上海百景	9787567142848	\N	刘寅斌 	平装	1-1	大32开	58.00	\N	上海大学出版社	\N	\N	\N	2021-08-01	/book/eaf6218a-71ad-4968-af3d-be6210cb7d131074799.jpg	这是一本和城市有关的书，也是一本和城市里的人有关的书。本书以上海为背景，选取了一百个地点，将本书作者从2003年来到上海后的近20年里与它有关的人和故事呈现给读者，向读者展示这是一个充满温情与爱的城市，这是一个充满烟火气和生活气息的城市，这是一个中西交融的城市，无论你是来自世界上任何地方，在这里，你都能找到自己喜欢的生活；这是一个充满机会的城市，勇敢的创业者，胸怀大志的企业家，逐梦的年轻人，甚至来自各地的打工者，在这里，都能找到属于自己的机会，实现自己的价值；这是一个充满魔幻色彩，谜一般的城市，一旦你爱上她，就很难割舍；纵使离去万里，亦心心念念，难以忘怀。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	447
519	牛爸思维训练（三年级）	9787309142976	\N	孙跃勇（牛牛爸爸） 著 	平装	1-1	16开	68.00	\N	复旦大学出版社	\N	\N	\N	2019-06-01	/book/d354f73a-c65e-4661-a6ba-2e44211734861074805.png	　　牛爸以和牛牛父子对话的形式来展现牛牛学习奥数的历程。书中绝大部分题目都选自竞赛真题，因此有相当的难度。不过牛爸的语言比较幽默、讲解深入浅出，使得很多难题学起来轻松了不少。《牛爸思维训练（三年级）（亲子脑锻炼丛书）》的例题和练习题的选择范围以四大杯赛为主（中环杯、小机灵杯、亚太杯、走美杯）。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	216
710	发展汉语（第2版）初级听力（Ⅰ）	9787561930632	9787561930632	么书君 编著 	\N	1-1	16开	79.00	\N	北京语言大学出版社	\N	\N	\N	2021-12-01	/book/7843afbe-35fa-462d-9e14-46f6e1b44ce59787561930632.jpg	　本册为初级听力（I），全书共30课，适合零起点的汉语初学者使用。本教材课文内容紧密联系学习者的学习和日常生活，语音训练贯穿始终，同时注重听说结合。学完本册教材，学习者能够逐渐听懂与语言学习及个人日常生活密切相关的简单语言材料，并能就相关话题与他人进行简单交际。听力课本每册均包括“练习与活动”和“文本与答案”两个分册，独立装订，既满足教师授课需要，又方便学生复习或自学。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	684
521	统计学（第8版）	978-7-300-29310-3	\N	贾俊平 何晓群 金勇进 	0	8-1	0	49.00	380.0千字	中国人民大学出版社	\N	2020O1718	\N	2021-10-13	/book/db2c3af5-a32c-4477-b849-19f33fec1cdf1074829.jpg	　　统计学是一门收集、处理、分析、解释数据并从数据中得出结论的科学，提供了一套通用与各学科领域的数据分析方法。统计学也是高校各专业普遍开设的一门公共基础课。本书自2000年初版以来，被全国近千所院校选作教材，受到教师、学生和社会各界的广泛好评。 　　第8版是最新版，内容上包括描述统计、推断统计、经济管理中常用的统计方法等，写法上与计算机软件操作紧密结合，给出了详细的计算与分析的步骤。同时第8版强调课程内容与思政建设的结合，书中例题和习题数据均以我国的社会经济等领域为背景，紧密联系实际问题讲述统计方法的应用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	211
532	三国志	9787569277173	\N	陈虎 编，高方 译 	平装	1-1	32开	26.00	\N	吉林大学出版社	\N	\N	\N	2021-04-01	/book/f94d61e0-8766-4aa6-82ad-69707322e3511074996.png	《三国志》与《史记》、《汉书》、《后汉书》并称为“四史”。作者陈寿，以其史识及叙事能力，在当时已有“良史之才”的称誉。 《三国志》在二十四史中，有它自己的特点，它既不像《史记》那样的通史，也不像《汉书》一类史书那样的断代史，它平行地叙述东汉末年魏、蜀、吴三国鼎峙的史实。 本版编纂体例分为题解、原文、注释、译文四部分。注者在前贤古本的基础上重新进行精心点校，又进行了简洁精明的注释和准确流畅的翻译，同时为每卷都做了题解，介绍本卷主要内容、写作背景、相关人物轶事等，可作为读者在阅读时的参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	892
522	不忘初心：中国共产党为什么能永葆朝气（第三版）	978-7-300-29893-1	\N	黄相怀 等 	0	3-1	0	48.00	150.0千字	中国人民大学出版社	\N	298931	16	2021-10-01	/book/616e7607-1e44-4109-ac2b-a4730a7f54f01074861.jpg	研究中国共产党，是一门大学问。对很多西方学者来说，中国共产党始终是个谜。他们热衷于唱衰或是预言，却一次次落空，中国共产党始终保持朝气蓬勃的精神状态，以强大的生命力和活力傲立于世界政治舞台。党的十九大胜利召开，宣告党和国家的发展已经进入了新时代、开启了新征程。 本书作者为中共中央党校八位青年学者，他们以独特的视角、新锐的观点、清新的思想，全方位解读中国共产党自我净化、自我完善、自我革新、自我提高的能力，探寻中国共产党成功之道，深入回答国内外读者关注和困惑的重大问题：中国共产党永葆朝气活力的“秘诀”是什么，有哪些“看家本领”?中国共产党的执政理念为什么能获得人民的认同？西方的政治制度真比中国的好吗？中国共产党如何避免苏共覆辙？在全面建成小康社会决胜阶段，中国共产党如何引领中国进入新时代？	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	781
523	企业重组的税会处理与筹划	978-7-300-29835-1	\N	梁俊娇 刘金科 	0	1-1	16开	86.00	322.0千字	中国人民大学出版社	\N	2020F0980	\N	2021-10-14	/book/60be8313-cfdb-44b9-aaa7-966c273eac3f1074892.jpg	本书内容涵盖了企业重组的所有主要形式，包括债务重组、股权收购、资产收购、企业合并、企业分立、股权资产划转、跨境重组、非货币性资产交换等，并结合当前的热点还讲解了对赌协议、借“壳”上市、资产证券化以VIE结构搭建和拆除的相关税会处理。在税会差异的处理、税收筹划的方案设计上通过大量的案例加以分析。因此，本书可以称得上是一部有关企业重组税会处理的百科全书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	371
535	社会法学前沿问题研究	9787562097587	\N	赵红梅 	平装	1-1	大32开	55.00	\N	中国政法大学出版社	\N	\N	\N	2021-10-01	/book/adcaf797-5dc7-4b79-97ac-b4072cf381111075024.png	本书为我国部社会法学研究生精品教材，共分五章，内容包括：社会法基础理论前沿问题、劳动法前沿问题、社会保障法前沿问题、慈善法前沿问题、卫生法前沿问题。这些问题体现了我国法治社会建设的基本要求，回应了我国法治社会建设面临的主要挑战，也反映了我国法治社会建设的主要任务。本书紧扣中国特色社会主义法治理论，反映我国法治社会建设的客观现实和社会法学理论的发展动态，试图呈现我国社会法学理论的前沿问题和成果。?	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	385
524	伯克毕生发展心理学（第7版）	978-7-300-29844-3	\N	[美]劳拉·E.伯克 著，陈会昌 译 	0	1-1	0	258.00	1300.0千字	中国人民大学出版社	\N	298443	\N	2021-10-15	/book/4d1c43ad-c294-4dfb-9935-5c2d7701c0741074921.png	《伯克毕生发展心理学（第7版）》是在美国及世界各地被广泛使用的大学本科和研究生教科书，是发展心理学教学中权威的教材之一，同时也是发展心理学研究领域引用率极高的著作。作者劳拉•E.伯克既是美国一位颇有影响的心理学家，也是儿童事业的积极活动者。它在系统而全面地阐述发展心理学各种理论和研究方法基础上，以人的发展的生物基础和环境基础为依托，以真人真事为例，把生理学、身体发育与心理发展知识和理论融为一体，对个体的生命早期、婴儿期和学步期、幼儿期、小学期、青少年期、青年期、中年期、老年期的各领域的发展娓娓道来。丰富详实的研究成果、鲜活生动的图文资料、简练流畅的表达风格，使本书将理论性、科学性和趣味性融为一体。它既可以作为我国大学心理系的教学与学习参考书，也可以作为各种培训教材。而对于一般读者而言，本书是其了解自身发展的必备参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	425
525	医学起源与发展简史	978-7-5671-3831-5	\N	苏佳灿 黄标通 许金廉 	\N	1-1	16开	78.00	\N	上海大学出版社	\N	\N	\N	2020-05-26	/book/fbcc6fa3-2d7d-4ada-b260-79dcffb8d5209787567138315.jpg	医学从远古时代的巫术与神话开始，从古典医学走向现代医学，它的发展与人类征服自然、认识自身的历程息息相关，更与科学技术的发展及哲学思想的认识密切联系，在新医学与新医科发展背景下，基础医学研究与临床学科发展联系更加密切，对医学历史进行溯源并对其发展历程进行梳理，可充分认识人类在浩瀚历史中探索医学传承、发展及创新的曲折与艰辛，更能体会无数科学家在未知世界中摸索、与疾病抗争的不懈与卓越。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	245
755	故宫文创记	9787566614407	9787566614407	王亚民 	\N	1-1	16开	126.00	\N	河北大学出版社	\N	\N	\N	2018-12-13	/book/34ff959e-9d71-4783-a75f-c9bc5e877e369787566614407.jpg	该书选择了近年来在社会上有广泛影响的展览案例，从其规划，展览大纲，空间设计，施工装修，宣传推广诸方面，通过图文并茂的形式表达出来。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	135
526	环境工程专业实验教程	978-7-5671-3468-3	\N	陆永生 	\N	1-1	16开	35.00	\N	上海大学出版社	\N	\N	\N	2019-03-01	/book/332953d0-60a7-4b87-a40f-d325cb5134539787567134683.jpg	本书将环境工程专业核心课程，如：环境工程原理、水污染控制工程、大气污染控制工程、固体废物处理与资源化技术、物理性污染控制工程等配套实验课程，实现有效综合，形成有机整体，避免专业基础课、专业课等相关课程之间的内容重复。每个课程实验内容安排由简入繁，实验类型涵盖基础验证型、综合设计型、创新探究型等，尤其是创新探究型实验以产学研为技术支撑，充分考虑社会对环境工程专业的需求。本书可作为高等院校环境工程专业的本科教材使用，也为相关专业的研究生和工程技术人员提供参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	504
527	大学生健康指南	978-7-5671-3829-2	\N	上海市疾病预防控制中心 编 郭常义 罗春燕 主编 	0	1-1	16开	28.00	\N	上海大学出版社	\N	\N	\N	2020-04-16	/book/4f8dabda-c036-4268-a03b-df8368dae8259787567138292.jpg	本书由上海市疾病预防控制中心组织编撰，作者为公共卫生研究及管理领域的主任医师或副主任医师，内容包括公共卫生常识、大学生主要健康问题与健康教育、学校新冠病毒肺炎防控策略与措施、大学生常见传染病防控、大学生常见慢性病和伤害防控、大学生健康相关行为、大学生心理健康等六章，是一部内容权威、针对性强的公共卫生指南读物，对于人群密集而公共卫生问题比较突出的大学生来说，具有极高且及时的实用价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	450
528	上海大学（1922—1927）教材：施存统《社会运动史》《社会思想史》《社会问题》	978-7-5671-4254-1	\N	《上海大学（1922—1927）教材》编委会 	\N	1-1	16开	68.00	\N	上海大学出版社	\N	\N	\N	2021-06-01	/book/46a57feb-e4f8-482b-9162-c8be11da0bcc9787567142541.jpg	本书由上海大学组织编委会搜集整理、汇编出版。上海大学（1922—1927）是中国共产党早期发展史上传播革命思想、传播马克思主义、培养革命干部的重要阵地，存世时间不长，却也编写了不少教材，当时这些教材不仅用于课堂教学，还在社会上广泛流传，影响了一批青年人的人生走向。本书收录施存统编写的教材《社会运动史》《社会思想史》《社会问题》，邓中夏和李立三编写的教材《劳动常识》，胡朴安编写的教材《文字学ABC》。本书作为资料集，可供学术研究参考；内容本身可读性强，也可供一般读者品读；同时，希望能对当前的学科建设与教材编写具有一定的借鉴价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	572
533	人际沟通实用教程	978-7-5121-4548-1	\N	张岩松 主编 	0	1-1	16开	49.00	\N	北京交通大学出版社	304	\N	\N	2021-09-24	/book/187dc6b2-abbc-44bb-97c3-0b4596f876641075002.jpg	本教材作为高职新型实用教材，是工作过程导向的项目课程开发的有益尝试。其内容是根据企事业单位所涉及的人际沟通活动而设定的，包括认识人际沟通、语言沟通、非语言沟通、倾听、面谈、网络沟通、面试沟通、商务沟通、会议沟通九章内容，每章由课程思政要求、学习目标、案例导入、“基本知识”、实训项目、课后练习几部分构成。在“基本知识”介绍中插入小案例、小故事、小训练等栏目，加强可读性、趣味性和指导性。实训项目和课后练习的设计，通过案例分析、角色模拟、情境训练等方式，让学生“做中学、学中做、学做结合”，不断提高其人际沟通能力和水平，塑造最佳的职业形象。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	848
1375	沟通技巧（第3版）	978-7-5637-3894-6	\N	汝勇健 	\N	3-1	16开	30.00	\N	旅游教育出版社	\N	\N	\N	2019-01-01	/book/e39dbd61-5d42-4b79-86cc-0267c480323c3894-6.jpg	本书围绕饭店督导层人员应具备哪些素质、应掌握哪些技能，以及 如何运用这些技能展开写作，力求提供给读者一个素质养成和技能强化 的系统化方案。本书特别强调员工创造力的培训，并关注未来旅游企业 发展要求员工掌握新兴点技能的要求，将上述技能要求、自我能力评估 等内容融入了教材的编写中。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	190
536	实验室生物安全	9787564578053	\N	郗园林 	0	1-1	16开	89.00	603.0千字	郑州大学出版社	396	\N	8	2021-07-01	/book/58a67b1a-4848-478e-8fdf-19d7c60ba5221075109.jpg	实验室生物安全概念自20世纪50～60 年代提出后，逐渐成为一个重要的国际性议题，受到世界卫生组织（WHO)和各国的高度重视。习近平总书记多次谈到生物安全问题，并将生物安全纳入国家安全体系的一部分，其中实验室生物安全是生物安全的重要内容之一。 近年来，随着传染病防控和生物科技发展的逐渐加大，大量生物安全实验室陆续建设并投入使用，确保生物安全实验室安全运行，防止重大生物泄露事故的发生，已成为保障公共卫生安全乃至国家安全的一个重要环节和内容，是国家和社会的一个关注焦点。因此明确实验室生物安全工作人员的应具备的能力，确保其具有安全处理生物材料的专业知识和专业素养，并完善相应的操作标准和行为规范是十分必要的。生物安全的意识理念培养和行为规范教育应从学生抓起，目前郑州大学针对基础医学和预防医学开设了本科生和研究生实验室生物安全课程，对学生教育阶段进行生物安全的教育做了有益探索和尝试。本书的出版正是适应了当前生物安全形势的需要。 本教材从实验室生物危害、病原微生物危害评估、生物安全实验室的设计和设备要求、实验室操作规范、实验室的管理、实验室存在的物理危害和化学危害等方面详细阐述了生物安全方法的要求，是针对我国生命科学领域从事涉及病原微生物实验活动的一线操作人员及实验室管理人员的具体需求“量身定做”的一本参考书，内容特色鲜明，实用性强。不仅对从事实验室生物安全的专业人员，而且对高等院校的本科生和研究生是一本很好的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	906
1798	王亚南全集（第十三卷）	《王亚南全集》编纂委员会	\N	978-7-5615-8351-7 	平装	1-1	16开	168.00	\N	厦门大学出版社	\N	\N	\N	2021-11-01	/book/1d069fab-32a0-48f9-9b4f-733d39ac45eb1086123.jpg	王亚南是我国当代著名的马克思主义经济学家、教育家，也是新中国成立后厦门大学的首任校长，是《资本论》全三卷的首译者之一。其一生著作等身，共有近40部著作和译著、340篇左右的论文和讲稿。适逢厦门大学百年校庆，厦门大学组织专家学者编辑出版《王亚南全集》，本书为全集第十三卷，收录王亚南的译著《经济学绪论》及《地租思想史》。《经济学绪论》由克赖士著，讲述经济学一般原理，尤其是经济学的研究方法；《地租思想史》由日本学者高岛素之著，讲述地租理论的演变。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	541
537	临床技能学=Clinical	9787564576226	\N	李薇 	0	1-1	大16开	89.00	763.0千字	郑州大学出版社	290	\N	7	2021-07-01	/book/b4c9117a-7fc8-4f2b-bf4a-e9ed8baeeced1075115.jpg	本书将临床医学本科阶段需要涵盖的临床技能分为八章。内容符合中国临床技能毕业考试标准，符合医学许可考试的基本能力要求。从简单的非侵入性到高级侵入性对临床技能进行分类和解释，并旨在逐步进行和分阶段进行，以适应医学生的能力发展。第一章为医患沟通和咨询的重点。第二章为核心技能：身体检查。第三章主要解释了医务人员的基本保护法和社区医疗的基本技能。第四章介绍了符合本科教育水平的基本穿刺方法。第五章介绍手术无菌技术和一般基础手术。第六章介绍了基本的急救技能。第七章介绍了妇产科的非侵入性技能。第八章介绍了儿科基础护理的内容。适合医学留学生使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	775
538	新医改背景下医疗服务供应链协调机制研究	9787564577056	\N	王晓燕 	0	1-1	16开	39.00	304.0千字	郑州大学出版社	291	\N	10	2021-07-01	/book/037dd71f-db39-4b4d-91d8-78b123d8cec31075124.jpg	针对新医改背景下的医疗服务 “碎片化”问题以及由此带来的医疗服务体系失衡和“看病贵、看病难”等问题，将供应链管理思想引入医疗服务领域，通过在医疗服务系统内建立供应链协调机制来促进医疗服务体系的完善、医疗服务质量的提升，减少成本消耗和提升医疗服务效率。本论著为我国医疗服务系统的协调机制研究提供了一种探索思路，为我国当前医改制度的合理设计和良性运作提供了借鉴，所建立的以市场机制为基础的医疗保险与医疗服务协调、医疗服务一体化、供应链激励协调与医疗保险体系整合等“一基四维”协调机制给出了具体的实施路径，可以指导各地的医改实践，操作性强，值得推广。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	211
539	妇产科学=Obstetrics	9787564576936	\N	黄元华 	0	1-1	大16开	139.00	1003.0千字	郑州大学出版社	397	\N	5	2021-08-01	/book/d3dc64fc-d8ae-45f7-8b59-071b160a3e781075132.jpg	本书全英编写，以《中国本科医学教育标准——临床医学专业（2016年）》为标准，以达成临床医学学士应当具备的妇产科专业知识的目标，汲取了国内外优秀教材的优点，纳入了本学科近年的成熟的成果和进展，由国内16所高校25名教授精心编写而成。全书共26章，按产科、妇科、计划生育的顺序排列；产科部分根据产前、产时、产后从生理到病理排列；妇科：按普通妇科、妇科肿瘤、生殖内分泌排列，其中对妇科疾病从外生殖器到内生殖器排列。培养学生系统的妇产科基本知识、基本理论、基本技能和临床思维能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	717
540	移动互联网时代网络文学生产新论	9787564577100	\N	李存 	0	1-1	小16开	82.00	292.0千字	郑州大学出版社	271	\N	8	2021-08-01	/book/3b75c93d-c8da-40b3-98ab-0ea92d8b3e8e1075137.jpg	随着移动互联网技术的发展，网络文学日益成为重要的文学现象，成为我国文化软实力的重要体现。本研究着眼于网络文学生产媒介化、交互性、技术性等新趋势，从影响网络文学生产力发展的生产形态、参与者和内容三大层面入手，将生产形态拓展到影视、声音、ACG等多媒体形态，深入分析作者、受众、传播者等生产参与者在交互中的融合态势，从生产内容的主题、文体、语言等变迁中，探究反映网络原住民生活体验和价值认同的网络文学独特审美的创新。这些构成了中国网络文学生产的比较优势，将为中华文化全球拓展提供坚实的发展动力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	939
541	聋啸龙声——你所不了解的你身边的聋人群体	9787564574642	\N	陈少毅 	0	1-1	16开	86.00	316.0千字	郑州大学出版社	300	\N	6	2021-09-01	/book/a85976f6-0dd5-4694-abf9-5ad1d725074f1075146.jpg	本书是作者多年来特殊教育第一线的工作经验积累和探索的理论升华。其内容翔实、图文并茂，穿插了许多鲜活生动的聋人经历、典故、叙述、故事，挖掘了很多精彩感人的历史材料，揭开聋人生活的独特内涵。本书全方位地介绍了聋和聋人的问题，可以说是一部有关聋的知识宝库，也是一本指导听人如何尊重聋人，与聋人相处的手册。作者深入全面地向读者普及了一遍耳聋及其相关的知识，描述聋人的特点以及聋人和听人融洽相处的方法，描绘了一个有利于聋人良好生存、提升社会文明的图画。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	224
542	话语与形象建构研究	9787564575175	\N	党兰玲 	0	1-1	小16开	98.00	309.0千字	郑州大学出版社	287	\N	8	2021-09-01	/book/6b07d530-04f5-4007-b0a7-5bc5bed33ec91075147.jpg	话语作为语言的实际使用，不仅反映社会实在和社会意义，还可以潜在反映生产、建构乃至重构社会实在和社会意义。对此，本书在探讨过程中持动态建构形象观，即认为：话语与行为个体形象的关系，不是“反映与被反映”的静态再现关系，而是“建构与被建构”的动态建构关系，在借鉴社会学、建构主义国际关系学、系统功能语言学、积极话语分析、会话分析、互动语言学、认知语言学及修辞学、语用学等相关理论的基础上，依次探讨了个人形象的话语建构、团体形象的话语建构、区域形象的话语建构和国家形象的话语建构。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	763
1376	旅游景区服务	978-7-5637-3499-3	\N	黎瑛 	\N	1-1	16开	28.00	\N	旅游教育出版社	\N	\N	\N	2017-01-01	/book/375813e1-0d15-4fbf-9b4c-b993387e1be53499-3.jpg	本书主要介绍了旅游景区与景区服务的基本知识，注重学科知识在 实践中的应用，强调技能的锻炼，旨在通过案例分析、理论讲解全面提 高学生实践思维能力，致力于培养实用型、技能型专业人才。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	950
543	脑瘫儿的疗育	9787564576332	\N	尤登攀 	0	1-1	32开	48.00	222.0千字	郑州大学出版社	302	\N	15	2021-09-01	/book/2741ffbe-75a6-47a3-a3e5-bac0aebe40df1075150.jpg	本书结合最新颁布的中国脑性瘫痪康复指南（2015），系统介绍了小儿脑瘫的定义、病因、临床表现及诊断，对脑瘫的高危因素、早期诊断、脑瘫的现代康复方法，均做出了详细的说明。对各种治疗方法的机制、神经生理学意义和治疗手技操作也做了说明。根据脑瘫病儿多有重复障碍的特点，介绍了运动发育训练、生活能力训练、语言矫治及各种理疗仪器、按摩、针刺、穴位注射、矫形器的应用等综合疗法。增添了脑瘫的各项评估及脑瘫病儿的家庭日常护理的有关内容。本书可供基层医院儿科、妇产科、儿保科及康复科的医师参考，也是患儿家长的良师益友。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	911
544	香椿功能组分研究及制备技术	9787564578688	\N	王赵改 	0	1-1	16开	49.00	251.0千字	郑州大学出版社	161	\N	10	2021-09-01	/book/f7ad9e2e-a7fe-4e82-8ff8-399001a36f281075158.jpg	本书主要撰写了植物中的功能组分概述、分类及其制备方法。以及香椿中的主要功能组分，分类、功能作用、制备技术、活性评价技术方法等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	171
545	开片——2020年诗选	9787564579715	\N	陆健 	0	1-1	32开	35.00	143.0千字	郑州大学出版社	257	\N	15	2021-09-01	/book/5ec1328d-69cf-41f6-8000-02f2a04fe2131075161.jpg	《开片——2020年诗选》精选诗人陆健于2020年创作的《东坡穿越》《我想象》《路过》《每天，那条鱼》等约一百五十首诗作，按照时间顺序编排。内容丰富，题材多样。记人的有《一个退休老头》《太太和她的朋友》《观花女孩》等；读书心得、生活感悟的有《得闲读好诗》《晒书》《在管庄看地图》《凌晨三点》等，反映了诗人丰富的精神世界和对当下社会、人生的思考，语言时而朴实时而跳脱，结构时而齐整时而参差，极富感染力，具有一定的文学性和艺术性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	324
546	太和脊道正骨疗法	9787564580506	\N	邓祥 	0	1-1	16开	89.00	233.0千字	郑州大学出版社	248	\N	9	2021-09-01	/book/6bff1872-2690-4400-927c-f4f1e2db9dcb1075164.jpg	全书共分七章，分别为太和脊道的起源、太和正脊技术基本理论、太和脊道诊断技术、太和脊道治疗技术（包括颈椎、胸椎、腰椎等矫正法）、肩背矫形技术、太和脊道基本功法等，并在文后附以案例供读者阅读。书中配有大量插图便于读者阅读理解。本书可供喜好正骨、自然养生者参阅。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	585
547	生物化学实验指导=Biochemistry	9787564576523	\N	李凌 	0	1-1	16开	69.00	700.0千字	郑州大学出版社	264	\N	8	2021-09-01	/book/5576132a-a2ad-4779-8f81-49499e73e7421075172.jpg	本书内容分为三大部分：生物化学实验概论（Part Ⅰ）、专项实验（Part Ⅱ~Part Ⅵ）、附录。第一部分包括生物化学实验的基本要求、基本技能及生物化学技术的基本原理（Chapter 1~6）。根据系统的特点，本书从蛋白质实验、酶学实验、糖脂实验、核酸实验、设计性实验、生物信息学实验等方面进行了专题实验，共35个实验。每一个实验中，在简要介绍了实验原理后，重点阐述了实验过程中的要点、技术分析和注意事项。最后，分析了可能遇到的问题、潜在原因及解决办法。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	902
548	组织学与胚胎学实验指导	9787564580094	\N	蒋杞英 	0	1-1	16开	39.00	312.0千字	郑州大学出版社	175	\N	12	2021-09-01	/book/06191b5b-5040-4910-a172-5ee7978013641075176.jpg	本教材是按照卫生部规划教材《组织学与胚胎学》第9版及教学大纲的要求编写的。在文字上要求简明扼要，重点突出，叙述明白，尽可能采用镜下拍摄真实的彩色图片。本教材侧重实践教学，分组织学与胚胎学两部分，内容上共26章，在每一章节的前后增加导读和课后思考题；实习的切片标本分别以肉眼观察、低倍镜观察、高倍镜观察的顺序进行描述，另外增加示教标本部分；书中精选了200多幅彩色图片，图像清晰并有图中标注，方便学生观察对照。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	240
658	汉语国际传播中的动词互动等级关系研究	9787310059386	\N	赵毅玲 	0	1-1	16开	78.00	\N	南开大学出版社	\N	\N	\N	2021-04-12	/book/fa881c22-7e77-484d-9203-b36b699023bb1077351.png	本书是国家出版基金项目“‘一带一路’核心区语言战略研究丛书（第一辑）”的一种。本书从社会语言学的角度，对现代汉语双音节动词中存在的典型等级关系和一般等级关系的词语进行了分类研究和探讨。语言中存在着由于社会地位、职业特性和年龄的长幼以及亲属辈分的差异而带来的等级关系问题。更重要的是，本文以研究现代汉语中能够体现等级关系的动词为对象，等级关系恰到好处的地述了自上而下或自下而上的不对称序列，即上对下的命令式和下对上的请求式。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	331
549	2020云南小说选本	978-7-5482-4341-0	\N	云南省作家协会 编 	平装	1-1	16开	52.00	460.0千字	云南大学出版社	358	\N	\N	2021-08-01	/book/1d82e8e2-6076-4f7c-bcf0-32bc4c760ce41075183.jpg	此书是云南省作家协会选编的2020发表在国内各大文学刊物上的云南省著名作家的短篇小说10多篇。总结并展示了云南作家2020年的创造成果及创造水平。该短篇小说选本既注重了作品的文学审美价值，也注意了作品的思想导向认识意义。该书稿的出版是为了总结和展示2020省内小说家的创造情况及成果，也是众多小说名家的集中亮相。该书稿质量较高，内容积极健康向上，代表着云南小说的发展高度和发展方向，出版价值深远。相信它的出版，将对年青一代的小说创造家起鼓励和引领作用，从而促进云南文艺事业向更加健康和积极的方向发展。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	571
550	高等教育体育学精品教材——体育英语文体学教程	978-7-5644-3420-5	\N	宋玉梅、田慧、Russell Savage、Jiawei Zhang 	平装	1-1	16开	70.00	428.0千字	北京体育大学出版社	\N	\N	\N	2021-11-01	/book/42c4de78-cb0c-4761-bf3e-32a2fb4aba231075190.jpg	《体育英语文体学教程》以文体学相关理论为指导，结合当前文体学发展新趋势，选用体育领域经典语言素材，引导学生对体育英语中的各类功能文体的范文（如体育广告、体育解说、体育新闻和体育电影等）进行文体分析，从而得出体育英语文体的语言特征。该教程集理论性、实践性、知识性、教育性、趣味性于一体，旨在让学生不仅可以掌握文体学的基本理论框架，更重要的是学会文体分析的方法、了解各类文本的基本文体特征，从而有利于学生了解、学习和使用体育英语。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	339
1377	热菜制作（彩图在线欣赏）	978-7-5637-3907-3	\N	朱海刚 	\N	1-1	16开	28.00	\N	旅游教育出版社	\N	\N	\N	2019-01-01	/book/0c14d146-15e4-474e-85c2-3758582849e63907-3.jpg	本书为全国烹饪专业及餐饮运营服务十三五规划教材，配有二维码 学习资源。教材围绕热菜制作常用的 26 种烹调方法，对 44 道热菜菜品 的选料、制作进行了细致讲解。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	863
551	英语小史	978-7-5446-6828-6	\N	姜锋 主编 张勇先 著 	平装	1-1	大32开	56.00	\N	上海外语教育出版社	\N	\N	\N	2021-10-01	/book/c9a327f6-080a-462f-9a4b-e21ff1646af31075194.png	本书共分四个部分十八讲，从英语小史概说开始，以时间为主轴分别介绍了古英语、中世纪英语、早期现代英语和现代英语等不同时期的英语状况，包括语音、词汇、语法等要素的演变，各时期文学代表作、重大历史事件和重要历史人物。在现代英语部分，着重对比了古今英语文本，指出了读音、拼写、词汇等主要特点，介绍了英语俚语、成语和短语的文化元素，分析了英文报刊在英语发展中的作用，并就美国英语、澳大利亚英语、苏格兰英语、爱尔兰英语、威尔士英语以及克里奥尔英语等核心圈成员与各类变体做了举例说明，还简述了人名、地名文化以及英语对汉语的影响。让我们一起去探索英语的前世今生吧！	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	208
552	旅游英语综合教程	9787566322777	\N	彭萍 主编 	平装	1-1	16开	52.00	\N	对外经济贸易大学出版社	\N	\N	\N	2021-10-01	/book/fc7ec314-be8a-49f1-bb31-adee4bdc2e2b1075197.png	本套教材按照“工学结合、动态更新、立体展示”的指导思想进行整体规划，突出产教融合、校企“双元”育人，强调校企共同开发反映现代旅游企业新技术、新流程、新标准的课程教学内容和职业能力标准，校企合作编写和开发符合现代旅游业服务实际和旅游接待行业最新趋势的教材。 本教材尽量涵盖旅游的各个方面和领域，包括旅途、景点、节日与活动、餐馆与美食、地方艺术与文化、博物馆与展览、传统与风俗、购物与纪念品、跨文化交流和旅游保险等十四个单元。每个单元由对话、听力、阅读三个部分组成。 尤其值得一提的是，本教材将中国元素纳入其中。目的在于让学生不仅熟悉异国旅游素材，更要熟悉中国旅游内容，从而能够用英语讲好中国故事，介绍中国旅游的方方面面。 本套教材适用于应用型本科院校和高职院校。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	794
553	兴农重器：中国农机文化传承与创新	978-7-5684-1684-9	\N	江苏大学党委宣传部,编著 金丽馥,高雅晶,主编 	平装	1-1	16开	228.00	\N	江苏大学出版社	\N	\N	\N	2021-09-01	/book/40e0332f-9658-4e2f-8547-2252ea10ebd11075202.png	我国是农业大国，农业生产具有悠久的历史，每一件农机具背后都包含着历史的根、文明的印。本书以时间为轴线，分为“追寻历史 溯源农机——中华农机文化源远流长”“时代变革 兴盛农机——新中国农机文化亮点纷呈”“无界畅想 未来农机——智能农机文化将闪耀未来”三个部分，用珍贵的照片、翔实的档案和精练的文字多角度、全方位还原中国波澜壮阔的农机发展历程，挖掘农机发展背后所蕴藏的精神文化内涵，重点展示新中国成立以来我国农机发展取得的巨大成就，展陈历代农机人对农机发展的贡献，展现农业机械化的重要作用，展望农机发展的光明前景。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	576
554	神鸟起舞：金沙太阳神鸟与太阳崇拜的文化解读	9787569039870	\N	何一民 等 著 	平装	1-1	16开	68.00	\N	四川大学出版社	\N	\N	\N	2021-06-01	/book/be8479db-a627-406c-8558-e4fc900d04c51075212.png	　　太阳神鸟，是成都金沙遗址出土的一件国宝文物，当它被发现之日起，就引起世人的关注和赞美。而当太阳神鸟被中国国家文物局定为中国文化遗产标志，并随神舟飞船进入太空之后，更是受到全世界的注目。太阳神鸟不是一件简单的工艺品或文物，而是古蜀历史悠久和文明高度发达的象征，承载着古蜀先民的智慧和思想。关于太阳神鸟的前世今生有很多猜想和推测，但无论怎样说，都与太阳崇拜有着密切的关系。太阳，是太阳系中散发出巨大热能、光芒的中心天体，地球等太阳系行星都围绕太阳公转。地球是太阳系中有生命的星球，而地球上的生命体都离不开太阳的热能和光亮，正是太阳光照射到地球上，才维持着地球地表的温度和大气水体运动及生物活动。人类从蒙昧时代进入野蛮时代，再进入文明时代，都一直感受到太阳的伟大和恩赐，因而凡是有阳光照射的地方就有着太阳崇拜，这是全世界共同的文化现象。成都金沙太阳神鸟则是众多太阳崇拜的一个集中表现。因而不能孤立地看待金沙太阳神鸟，应将它放在整个人类文明进程中来进行解读，以此来认识人类文明发展进程的共性和特征。 　　早在2005年，成都金沙遗址博物馆还在修建过程中，时任馆长、著名考古学家王毅先生就曾与我多次谈到太阳神鸟所承载的人类共同的文化现象，希望我带领学生对此进行探讨。我对考古学完全是门外汉，对古蜀文明也只是一知半解，不过为了研究成都城市的起源，也多少学习了一些相关知识，并对太阳神鸟十分关注，对太阳崇拜也略有了解，故而在好奇心的驱动下也就率领几位学生一起收集相关资料，准备进行研究。但是，要对此一问题进行深入研究不是想象中的那么简单和容易，故而此一学术活动进行了一半就停顿下来了，剩下一堆资料和不成形的初稿放在电脑里。但有关古蜀文明和太阳神鸟的思考一直在脑海中挥之不去。近年来，随着对成都城市历史起源研究的推进，对相关问题的认识更加深入，对太阳神鸟和太阳崇拜的研究情结一直在心中悬系。 　　2017年，中共成都市委倡导“传承巴蜀文明，发展天府文化”。2018年，成都市社科联组织编写一套天府文化系列丛书，故而受其启发，从电脑的文件堆中翻出十余年前所收集的有关太阳神鸟的资料进行梳理，不过这次不再准备进行系统的学术研究，而是在原有资料的基础上，写一本普及性的小册子，力求将太阳神鸟与太阳崇拜放在人类文明进程中加以考察，不仅对成都金沙太阳神鸟进行文化解读，而且也对中国各地的太阳崇拜及世界主要地区和民族的太阳崇拜进行文化解读，希望能让读者对人类早期文明和太阳崇拜有一定程度的了解。 　　本书由于是普及性读物，参考了部分专家学者的研究成果，有的直接引用原文，都做了资料来源注释，有的未直接引用，故就未加注释，特在此说明，敬请理解。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	726
555	传统文化体验教育引论	9787560767529	\N	耿成义,李文军 	平装	1-1	16开	49.00	\N	山东大学出版社	\N	\N	\N	2021-10-01	/book/a2896652-0504-4882-a095-cb893f2b73511075218.png	《传统文化体验教育引论》是“传统文化教学研究论丛”首推之书。本书是一部专门探讨如何在基础教育阶段贯彻实施传统文化体验教育的研究著作。本书聚焦基础教育阶段的传统文化体验教育，探索以中华优秀传统文化为基础内容，以情境体验为基本形式，以文化传承、精神融入为目的，有目的、有计划地对受教育者成长施加影响的过程。本书包含两大部分：第一部分，即第一章至第五章的理论探索，如阐论体验教学论，传统文化体验教育概论、课程论以及教学论；第二部分，即第六章至第十章的实践课例，如传统文化教育的学科整合体验课程探索、教学模式探索、生活化育人模式探索、戏剧课程教学模式探索、研学游体验课程探索以及相关课例评析。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	122
1322	物理学中的理论概念	9787312033766	9787312033766	Malcolm Longair 	\N	\N	16开	99.00	\N	中国科学技术大学出版社	\N	\N	\N	2021-04-02	/book/3c20ae84-c4fc-41d4-81d7-d0c978e554c89787312033766.jpg	本书第1版出版于1984年，第2版出版于2003年，是一本备受欢迎的优秀教材，通过一系列的专题，将全部物理概念融会贯通，十分精彩。内容包括：开普勒定理、伽利略定理、牛顿万有引力定律、麦克斯韦方程、电磁学、力学和动力学、热学、统计力学、黑体辐射、普朗克定律、爱因斯坦方程、量子假设、广义相对论、天文学，等等。本书旨在传达一种对现代物理的深刻理解，适合具备大学普通物理基础的学生、教师和科研人员，以及对物理感兴趣的一般读者。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	954
556	Some	978-7-5625-4823-2	\N	肖海军 黄刚 著 	平装	1-1	16开	38.00	176.0千字	中国地质大学出版社	\N	\N	\N	2020-10-01	/book/68449e57-b416-41c5-96ee-53ec354f0f421075223.jpg	SVM基于结构风险最小化，克服了传统方法的过度拟合和陷于局部最小化问题，具有泛化能力强等优点; 使用核函数将数据映射到高维空间，在不增加计算复杂度的情况下，有效地克服了维数灾难问题。当然，当前SVM的研究也存在一些局限性。本书在介绍SVM基本原理的前提下，分三部分介绍了SVM的理论与应用研究。包括数据预处理与SVM；融合分类与SVM；智能分类与SVM。它们在充分展示了SVM的优良性能的同时，还克服了SVM的应用中面临的局限问题。本书理论详实、实验结果丰富，很好将理论研究与应用研究结合起来，对读者学习与研究SVM具有一定的帮助。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	246
557	流域水文分析与中长期预报方法	978-7-5625-4797-6	\N	朱双 张海荣 罗显刚 编著 	平装	1-1	16开	32.00	129.0千字	中国地质大学出版社	\N	\N	\N	2020-08-01	/book/66a5a9d5-fd17-4eae-ab23-be9ff88cdc921075229.jpg	水资源在人类生存和社会发展中占有重要地位，保证水资源的可持续发展利用，是实现经济社会可持续发展的首要前提条件。流域水文预报和水资源承载力分析是水资源系统研究中的两个重要课题，是水利工程规划建设、水资源优化配置及社会可持续发展的重要支撑。进入二十一世纪以来，我国水资源的可持续利用面临人口增长、供需水不平衡以及气候变化影响等多重压力。一方面全球气候变暖导致两极冰盖加剧融化，海平面升高，淡水资源减少，暴雨、洪涝、干旱等极端事件发生频率显著增加；另一方面，水利工程胁迫导致流域自然径流破碎化，流域水资源系统的时空变异规律更加复杂，水循环系统的大气、地表、土壤、河川和地下水过程的显著变化诱发了系列资源、生态、环境等问题。气候和水循环过程的变异对流域水文预报和水资源承载力分析提出了更高的要求。本书针对变化环境下水资源中长期预报与评估研究中存在的关键科学问题，以长江上游金沙江流域及西南地区为主要研究对象，分析了金沙江流域径流和降雨特性时空变化规律；建立了基于灰色关联分析的模糊支持向量机月径流预报模型，为了提高模型预报精度，研究了模型构建过程中预报因子选择与时间序列分解两个关键环节。将气象，大气环流，影响长江中上游流域降雨的黑潮海温，东亚夏季风指数等遥相关因子组成特征集合，采用序列浮动前向算法挖掘预报因子特征子集，并尝试采用高斯过程回归对金沙江上游石鼓站和下游屏山站月径流进行不确定性预报，得到月径流的预报区间和置信水平，在此基础上，采用Sobol全局敏感性方法推求了石鼓和屏山站汛期径流预报因子的灵敏度，辨识了对汛期径流预报结果产生较大影响的因子集。最后针对传统模糊综合评价方法中的不足之处，建立了可变模糊集与集对分析耦合的西南地区水资源承载力评价模型，识别了西南各地水资源承载力等级。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	521
558	高校社区运动干预型健康管理模式的构建	978-7-5625-4858-4	\N	井玲 杨帅 弓颖 著 	平装	1-1	16开	42.00	126.0千字	中国地质大学出版社	\N	\N	\N	2020-10-01	/book/e45f5bf1-6eb4-4552-94fa-7609536863621075232.jpg	高校社区健康管理意即以高校学生的实际需要为导向，向学生提供有针对性的健康咨询和指导，对大学生在日常生活中出现的危险因素进行检测、分析、评估及预测，并进行系统性的干预和管理的过程。本书以高校社区为研究对象，以构建健康管理与运动干预体系与运动干预现状为主题,从高校健康管理体系的研究背景、目的和意义，以及存在的不足和需要建立的方案等多个方面构思，探讨高校社区健康管理体系构建的方法,从而提高大学生体制健康管理水平，建立健全高校社区健康管理体制机制。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	636
559	陆相断陷湖盆钻井岩心特征及沉积相分析——以渤海湾盆地南堡凹陷为例	978-7-5625-4807-2	\N	甘华军 等 编著 	平装	1-1	16开	68.00	201.0千字	中国地质大学出版社	\N	\N	\N	2020-08-01	/book/aaae9d63-3420-4b5e-85be-3a312cf80b001075241.jpg	本书着重介绍了碎屑岩系沉积盆地的岩心观察、描述与分析的基本原理与方法，并偏重于在含能源盆地以及油气资源勘查领域的应用实践与综合分析。本书以渤海湾盆地南堡凹陷钻井岩心为主要研究对象，建立系统完整的典型沉积特征图版。全书共分为8章，内容包括南堡凹陷地质背景、岩心观察与描述基础、冲积扇、三角洲、深湖-半深湖、重力流沉积体系的岩心图版、岩心沉积相综合分析、火成岩岩相观察等，并附中英文词汇表以供参考。 本书是笔者们长期在该领域开展科学研究、国际合作与学术交流以及研究生、本科生教学工作的成果，并结合国内外最新的相关论著和研究成果而编著的。适用于基础地质、矿产地质、能源地质、沉积盆地分析相关的本科生、研究生阅读和学习，同时也适用于这些领域的教学和科研人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	754
560	中国特色社会主义建设若干热点问题调查研究（第三辑）	978-7-5625-4822-5	\N	高翔莲 等 著 	平装	1-1	大32开	60.00	317.0千字	中国地质大学出版社	\N	\N	\N	2020-10-01	/book/1d5fa654-6726-44c4-ae96-1584036442281075247.jpg	习近平新时代中国特色社会主义思想是马克思主义中国化的最新成果，是实现中华民族伟大复兴中国梦的行动指南。加强对习近平新时代中国特色社会主义思想的学习、研究、阐释和宣传，使马克思主义中国化这一最新理论成果深入人心，为广大人民群众认知、认同、理解、应用，对坚持马克思主义意识形态的指导地位，对坚强和巩固巩固党的执政基础，对全面建成小康社会，实现中华民族伟大复兴的中国梦，具有十分重大的意义。本书以马克思主义理论为指导，结合党的十九大报告精神，研究中国特色社会主义建设中热点问题。在调查研究的基础上，形成一系列优秀调研报告。1.乡村基层党组织振兴的现状与对策研究；2.乡村振兴视野下红色资源文化教育功能发挥现状调查研究；3.乡村振兴进程中的人才引领机制调查研究4.乡村振兴战略下农民专业合作社作用调查研究；5.大学生国家安全观现状调查与教育对策研究。本书集学术性、前沿性和系统性为一体。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	578
561	马尔克斯与他的百年孤独（修订版）	9787559822284	\N	杨照 著 	平装	1-1	32开	35.00	\N	广西师范大学出版社	\N	\N	\N	2019-12-01	/book/985d2333-0d5b-4669-bb3a-a4f143714f5e1075255.png	作为诺贝尔文学奖获得者马尔克斯zui重要的作品，同时也是震撼二十世纪文坛的奇书，《百年孤独》宏大繁复，引人入胜，而本书是对这部文学经典的解读。在书中，作家、文化评论家杨照以历史学和文学的双重视角，借由拉丁美洲的历史文化背景和马尔克斯的生活经历，探问魔幻现实主义的内在逻辑，追寻马尔克斯的文学源头，解读埋藏在《百年孤独》复杂奇谲之下的痛与真。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	205
562	决战职场：跨国公司总裁邢军给你的贴心忠告	9787309159509	\N	邢军 著 	平装	1-1	16开	68.00	\N	复旦大学出版社	\N	\N	\N	2021-10-01	/book/a658f7a8-9da3-449d-834c-2798b66e4d021075256.png	邢军是一位能力超群的领导，作为一名跨国公司全球高管，她长年行走于中西文化之间，有着丰富的职场经验，信奉“勤奋自律者无敌”的她，在职场与生活中践行着自己的座右铭。《决战职场：跨国公司总裁邢军给你的贴心忠告》是职场过来人写的一本职场完全手册，干货满满，力求以拨云见日为宗旨，不仅接地气，更直奔职场的热点与痛点。全书分“职点迷津”“识人职道”“品牌职造”“求职必得”“人间职得”五个部分，职场人关心的时间管理、自我提升、人际关系、技能学习、情绪控制等问题，在本书中你都可找到答案。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	669
1315	小学武术（二年级）	9787500958635	9787500958635	高菲 	0	1-1	16开	60.00	170.0千字	人民体育出版社	134	\N	\N	2021-09-01	/book/25fae86c-6460-48ba-b4d8-7795dfe14a6d1082002.jpeg	此书为《小学武术》系列的第二本教材，为二年级学生偏写。本教材是北京教委支持的“高参小”项目研究成果之一，由首都体育学院武术与表演学院牵头，北京市许多著名的武术专家、学者和具有丰富教学经验的中小学武术教师参与编写，力图为武术这朵民族体育文化之花在小学校园里绽放新姿做出集体力量的贡献。 本教材突出实用性，采用教案式写作方式，根据学生年龄特点针对性地选择具体项目和教学内容。其特色是不再单纯教授技术，而是将武术知识、技术、功法、体能融为一体，制定了许多自检自测的标准，教师、学生和家长可以随时检查学生学习完成的情况。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	829
1316	少林功夫高段位教程7-9段	9787500959144	9787500959144	释永信 	0	1-1	16开	120.00	874.0千字	人民体育出版社	699	\N	\N	2021-12-01	/book/f47b88ff-8f40-43dc-bf0b-6daf12241e431082003.png	武术界历来有“天下功夫出少林”之说，还有北少林、南武当之说，由此可见少林拳在武术界的深厚底蕴。作为有着极高知名度的少林拳，在当代是我国优秀传统文化的一个名片，此说应不为过。正是鉴于这种认识，少林寺组织编写了这套《少林功夫段品制系列教程》，以更好地推广少林功夫和我国传统文化。本套丛书突出了少林功夫特色、注重传统，并将进行品牌化系列运作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	148
1317	华佗五禽戏基本功法教程	9787500960379	9787500960379	夏克平 	0	1-1	16开	32.00	60.0千字	人民体育出版社	86	\N	\N	2021-11-01	/book/53dfbfdf-b0e0-4bae-ae59-9d06b36273a61082012.jpeg	导引又称气功，作为中医药健康养生文化的重要组成部分，在我国有着五千多年的发展历史，深受历代养生家所推崇。华佗五禽戏是我国最早形成并施用于防治疾病的系统仿生导引套路，属于气功动功，既能健身未病先防，又可治病既病防病。 本书稿在“保护文化遗产、秉承先哲遗训、不失导引本貌、传承导引精髓”的原则下对华佗五禽戏的基本功法原理和操作方法予以详细的阐释介绍，并对动作运用加以示范，赋予了基本功法的可操作性，使功法抽象概念具体化，为初学者奠定良好习练基础，以期对这一宝贵遗产的传承和习练有所裨益。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	670
1318	太极拳心传与体悟	9787500960348	9787500960348	二水居士 	0	1-1	16开	79.00	346.0千字	人民体育出版社	345	\N	\N	2021-09-01	/book/a9fc8f9f-3248-4cb6-9d00-42862689789b1082021.jpeg	本书为《经典拳论解读丛书》之一，共六卷180小节，插图100幅，主要内容涉及太极拳的拳架、拳理、拳技、拳艺、精气神、历史脉络、文化特质等太极拳文化的各个方面。作者凭借多年习练、传承杨式叶派太极拳的心得和体悟，对太极拳老拳谱进行深入的梳理和解读，对太极拳从理论和实践的结合上进行了全面的总览和概括。由拳入道，精确阐释太极拳的文化内核——“性命践行的哲学”，从文化自信、文化自觉的角度，定位这张中国特有的太极文化名片，为其向世界的传播和普及提供极具价值的依据。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	385
1319	抚今追昔话量子	9787312049965	9787312049965	范洪义 	\N	\N	16开	70.00	\N	中国科学技术大学出版社	\N	\N	\N	2021-01-31	/book/91791374-f46d-4adf-8f06-b8adbe10481d9787312049965.jpg	“十三五”国家重点出版物出版规划项目“量子科学出版工程”中的一本。1900年普朗克为了克服经典理论解释黑体辐射规律的困难，引入了能量子概念，为量子理论奠下了基石。在第二次量子革命到来之际，本书作者根据自己近50年来对量子力学的理论探索，梳理量子理论发展脉络，并融合中国人的思维模式进行理解，以期读者能较好地理解量子理论。本书可作为科普著作供感兴趣的中学生及大学生阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	736
1320	量子物理学.下册	9787312048852	9787312048852	Vladimir Zelevinsky 	\N	\N	16开	198.00	\N	中国科学技术大学出版社	\N	\N	\N	2019-12-20	/book/07fc66af-7b37-420e-86eb-76d239c00b649787312048852.jpg	物理学家捷列文斯基曾在俄罗斯新西伯利亚州立大学、美国密歇根州立大学以及丹麦哥本哈根尼尔斯玻尔研究所讲授“量子物理”课程，基于多年的讲稿，他整理出版了《量子物理学》（两卷本），由Wiley出版社出版。本书是第2卷，副书名是《从时间依赖动力学到多体物理与量子混沌》，译者是丁亦兵、马维兴、沈彭年、姜焕清、梁伟红。内容包括相对论量子力学、狄拉克方程、分立的对称性、中微子、全同粒子、同位旋、二次量子化、费米子、玻色子、超导电性、密度矩阵、量子混沌、量子纠缠，等等。本书可作为物理及相关专业高年级本科生和研究生的教材，也可供研究人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	188
1321	量子信息简话	9787312051883	9787312051883	袁岚峰 	\N	\N	16开	80.00	\N	中国科学技术大学出版社	\N	\N	\N	2021-03-28	/book/f5295f8b-c9fc-4435-b96a-4d16eee8d1b49787312051883.jpg	本书是作者通过研读量子信息的教材和对量子信息一线科研工作者的采访，并结合自己两年多来对量子信息方面进行的科普工作整理而成的，介绍了量子信息的逻辑框架并对科学原理进行了解释。适合对量子信息感兴趣的广大读者阅读，也可供研究该领域的专业人士参考使用，希望读者通过阅读本书，能够对量子信息达到科学原理层面的了解，获得这个学科的大图景，进而增加对科学思维方式的了解，提高科学素养。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	224
1331	神经内科疾病100问	978-7-5645-7964-7	\N	滕军放 	0	1-1	小16开	39.00	197.0千字	郑州大学出版社	150	\N	\N	2021-11-01	/book/fcebe0cd-02af-4df9-ae8e-d1f0cf60182c1082288.jpg	本书为叩问疾病解密健康医学科普丛书的神内分册。该书共分100个小节，从大众熟知的临床症状出发，提出问题，引出疾病相关知识，以问答的方式，阐述了神经内科常见疾病的概念、典型症状、常见误区、检查手段、诊疗流程、家庭识别和急救方法等，内容丰富，针对性、实用性强，由浅入深，便于理解。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	291
1323	宇宙线和粒子物理	9787312039638	9787312039638	（美）Thomas K. Gaisser 	\N	\N	16开	49.00	\N	中国科学技术大学出版社	\N	\N	\N	2018-02-01	/book/5e00027f-022f-4649-96c6-3d72b50577649787312039638.jpg	本书是宇宙线领域的经典之作，在宇宙线研究领域里影响巨大，其英文版为世界范围内宇宙线研究机构和学校用作教科书或参考书。宇宙线研究的是基本粒子及其和物质的相互作用，因此粒子物理是宇宙线研究所必需的基础知识。本书介绍了宇宙线的起源、加速、传播、相互作用和探测等基础性知识，以及相关的粒子物理背景，可作为刚进入宇宙线研究领域的研究生教材，对于从事相关研究工作的学者也具有重要的参考价值。虽然本书已出版二十多年，但其中涉及的方法、理论、技术和思想却丝毫不显过时，即便是今天它也是宇宙线专业的研究生和科技工作者必备的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	881
1324	高能物理数据分析	9787312045844	9787312045844	（德）O.贝恩克，（德）K.克朗宁格，（德）G.肖特，（德）T.肖纳-赛德涅斯 	\N	\N	16开	78.00	\N	中国科学技术大学出版社	\N	\N	\N	2019-03-01	/book/83b0a664-de6d-4312-95ba-70ff5d3718339787312045844.jpg	本书介绍高能物理实验统计分析的相关知识，原书（英文版）由长期在欧洲核子中心CERN、美国国立费米实验室FNAL、德国电子同步加速器中心DESY等国际高能物理研究中心各著名合作组从事数据分析的专家合作撰写，他们同时是德、美、英、荷等国著名高等学府的教授。全书共分十二章，包括基本概念、参数估计、假设检验、区间估计、事例分类、去弥散方法、约束拟合、系统不确定性的处理、理论不确定性、高能物理的常用统计方法、分析实例演练和天文学中的应用等内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	272
1378	餐饮服务与管理	978-7-5637-3213-5	\N	董家彪 卿 琳 	\N	1-1	16开	33.00	\N	旅游教育出版社	\N	\N	\N	2015-01-01	/book/ac993497-1321-4321-ad68-8bac40d978263213-5.jpg	本教材紧密契合饭店餐厅的日常服务与管理能力要求，根据餐厅服 务人员工作内容的需要，突出对服务人员所需技能点的训练。在体例和 内容编排上，打破传统教材以知识为主线的编写模式，以工作过程为导 向，整合项目模块、序化教学任务、整体呈螺旋式上升，以“项目—任务” 为体例进行编排。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	802
1325	粒子天体物理	9787312035579	9787312035579	（英）唐纳德·帕金斯 	\N	\N	16开	68.00	\N	中国科学技术大学出版社	\N	\N	\N	2015-06-09	/book/2d37e968-6d6d-4b04-b55c-cf4b433892639787312035579.jpg	作为粒子物理与天体物理之间的交叉学科，粒子天体物理近来发展迅速。Perkins所著的这本《粒子天体物理》深入浅出地引导初学者了解该学科的全貌，并反映当今若干重要研究前沿。她适合高年级本科生和研究生的阅读，或选作相关课程的参考书。全书分三部分。第一部分介绍粒子物理和相对论的基本概念。第二部分引入宇宙学知识，包括宇宙膨胀热力学、重子产生、核合成、暗物质和暗能量、结构形成及微波背景辐射，等等。第三部分阐述宇宙线、恒星演化等粒子天体物理研究领域。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	530
1326	MBA商务英语教程	9787312051418	9787312051418	陶伟，陈纪梁，孙晓茹 	0	\N	16开	45.00	\N	中国科学技术大学出版社	\N	\N	\N	2021-06-17	/book/33fbd602-a4b1-4c6d-b3c7-3ace0586c2b49787312051418.jpg	本书共分为10个单元，书稿编写体现实用性和针对性原则，以及自主学习与协作学习相结合的原则。融听、说、读、写、译等多项语言技能于一体，本书体系包括网络热身、导入活动、专业阅读教材、自测评估、复习练习、案例讨论、能力测试等。内容体现了MBA、工商管理专业的特色，涵盖了管理学、组织行为学、市场营销、人力资源管理、战略管理、企业文化、商务沟通、经济全球化、电子商务、职业规划、领导力、创新与创业、市场营销等话题，结合我国高校MBA项目“商务英语”课程的基本目标及教学对象的实际需求，以内容带动语言能力的训练。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	788
1327	电磁学简史	9787312051340	9787312051340	纪辰，石云里 	0	\N	16开	56.00	\N	中国科学技术大学出版社	\N	\N	\N	2021-07-01	/book/355fce87-82e8-4dc0-b5b6-bffe0f7146089787312051340.jpg	本书首先回顾古代电学和磁学的发展，然后分别梳理出电和磁独立发展的历史脉络。后又专门介绍了电流与电路的发展历史。接着，本书从奥斯特发现电流的磁效应讲起，先是介绍了电磁学理论的两大学派的发展和竞争，即超距电动力学体系和电磁场理论体系；此后，麦克斯韦登上历史的舞台，他在二者的基础之上建立了电磁场理论，创建了经典电磁学理论体系。本书最后还介绍了狭义相对论的建立过程以及电磁学的一些应用。共分为8章：第1章，古代关于电和磁现象的观察和应用//第2章，静电学的独立发展阶段//第3章，电流与电路//第4章，磁学的独立发展阶段//第5章，从奥斯特到法拉第//第6章，集大成者——麦克斯韦电磁场理论的建立//第7章，电磁理论的继续和发展——狭义相对论的建立//第8章，电磁学的应用	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	353
1328	技术史研究导论	9787312051081	9787312051081	王安轶，（德）沃尔夫冈·科尼希（Wolfgang K?enig） 	0	\N	16开	39.00	\N	中国科学技术大学出版社	\N	\N	\N	2020-12-30	/book/1e837884-5c99-43ee-b2f2-a8aa873705ec9787312051081.jpg	技术源于人类生存和进化的需要。随着技术的发展，人类从蒙昧走向文明，可以说，人类历史就是一部技术史。对技术的历史研究是科学技术史中不可或缺的重要研究内容之一。但是，对技术史的方法论研究的著作较少，该书是在德国技术史专家Wolfgang Koenig教授多年对技术史研究的基础上，结合德国技术发展史为本科生开设的一门技术史概论的参考书目。该书从技术史的内涵，特点，研究理论和方法以及以德国技术史研究为例，讨论了技术史研究的方方面面的问题，是一本技术史入门级的教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	702
1329	生物化学=Biochemistry	978-7-5645-7577-9	\N	李凌 	0	1-1	大16开	139.00	1310.0千字	郑州大学出版社	526	\N	\N	2021-11-01	/book/5b1c8a2d-6733-4211-978b-dc70470bfaea1082280.jpg	生物化学是指用化学的方法和理论研究生命的化学分支学科。其任务主要是了解生物的化学组成、结构及生命过程中各种化学变化。本教材共26章，分为四个部分: 生物分子的结构与功能、代谢与调节、信息途径和分子医学。图文并茂，具有较高的学术价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	828
1330	新编法律英语	978-7-5645-8181-7	\N	胡光全 	0	1-1	16开	59.00	705.0千字	郑州大学出版社	359	\N	\N	2021-11-01	/book/c66cadfc-fcf5-4910-a471-9459b679fdfd1082283.jpg	本书将专题讨论、案例分析、模拟谈判、法庭辩论、案情摘要撰写以及法律备忘录撰写等法律实用技能训练项目单独列出，以提高读者的英语表达能力和法律实务能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	544
1333	传统文化当代价值与组织行为学体系	978-7-5645-8207-4	\N	朱美光 	0	1-1	16开	68.00	279.0千字	郑州大学出版社	204	\N	\N	2021-11-01	/book/bc3bf669-d563-4f84-997a-0dbb6a0401af1082296.jpg	本书是河南省级高校精品在线开放课程和省级一流线上线下混合式本科课程《中原文化：行为篇（组织行为的文化溯源）》研究成果的延伸和拓展，力求突出中华优秀传统文化特色，坚持“不忘本来、吸收外来、面向未来”原则，将中国特有的文化精神、思想智慧和管理实践融入组织行为学理论，尝试搭建组织行为学本土化知识体系，创建个体心智修炼、群体行为诱导、组织文化塑造和领导能力提升模型，有助于以史观己、以史明理、以史明志，帮助学生实现自我认同与文化自觉，增强文化自信。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	968
1379	旅游心理原理与实务（第4版）（配课件）	978-7-5637-1240-3	\N	麻益军 	\N	4-1	16开	29.00	\N	旅游教育出版社	\N	\N	\N	2015-01-01	/book/ccc6359e-3480-4e6f-ab63-42758a6426a01240-3.jpg	本书就“原理”而言，是以心理学的体系来构建的，同时突出学生 心理素质的培养；就“实务”而言，是专业所需，以突出学生把握游客 心理的技能培养。全书内容分成四部分共九章。每章又分别由本章导读、 本章小结、思考与练习、案例分析与心理测验等 5 个板块组成。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	185
1334	坚持党对教育工作的全面领导（新时代马克思主义教育理论创新与发展研究丛书）	978-7-300-30033-7	\N	丛书总主编：靳诺 执行主编：翟博 张剑 本书主编：王庭大 唐景莉 	0	1-1	0	88.00	180.0千字	中国人民大学出版社	\N	2019G0781	\N	2021-12-31	/book/bde22a0e-acb6-4b4f-9e03-549a7a6ae39c1082315.jpg	加强党的领导是做好教育工作的根本保证。必须牢牢掌握党对教育工作的领导权，始终坚持马克思主义指导地位，把思想政治工作贯穿学校教育管理全过程，使教育领域成为坚持党的领导的坚强阵地。本书共分五章，全面分析了党对教育事业全面领导的价值定位，指出坚持党对教育事业的全面领导的实施路径等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	992
1335	市场营销（第2版）(高等学校经济管理类主干课程教材·市场营销系列；“十二五”普通高等教育本科国家级规划教材；北京高等教育精品教材）	978-7-300-30001-6	\N	王永贵 	平装	2-1	16开	65.00	684.0千字	中国人民大学出版社	\N	300016	6	2022-01-01	/book/fc9ae079-e730-479f-bc29-c4a306aa9a691082352.jpg	立足于中国本土的课程思政教材 本土的市场营销学教材如何才能更好地满足立德树人根本任务的要求？如何更好地服务于高水平社会主义市场经济体制？如何更好地服务于企业的营销实践需求？如何更好地服务于满足人民对美好生活的需要？这是作者在本次修订中尝试做出的探索。 第2版吸取了国内外学术界和企业界的许多前沿观点和实践，以广阔的视野、丰富的案例、独到的点评，全面系统地阐述了市场营销的核心内容和方法，深化和拓展了对市场营销的理解和实际应用，使读者更好地应对不断变化的、动态的、充满机会与挑战的新环境。 特别融入了课程思政元素，强化了社会主义核心价值观的引领作用。 突出顾客价值主线，全书沿着理解价值、锁定价值、创造价值、传播价值、交付价值和提升价值的逻辑展开。 特别强调了市场营销管理中的核心问题、基本概念和关键工具以及面向未来的营销变革与创新，并特别突出了价值、体验、服务、品牌、关系、网络以及伦理与社会责任行为等。 特别充实了国内外市场营销领域的新理论发展与实践，在企业营销实践调研、经理人员访谈和学术期刊研读的基础上，引入了大量有关营销实践的新探索和新案例，强化了本书的前沿性和实践性。 特别关注了移动互联网、大数据、云计算、人工智能等当今时代的重要主题及其对市场营销的影响，强化了本书的时代性和针对性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	365
1336	刘希娅与小梅花课程	9787303267149	\N	刘希娅 著 	平装	1-1	16开	65.00	\N	北京师范大学出版社	\N	\N	\N	2021-04-01	/book/75b73ac8-e112-48a8-a8fc-2803936556211082387.jpg	“我说我做的，我做我说的”，《刘希娅与小梅花课程》是刘希娅校长的一本自传体著作。全书以实践者的视角，用平实而真诚的文字，介绍了她从一名乡村教师成长为著名校长的过程，呈现了她在谢家湾小学进行教育教学改革的历程，以及在博弈与坚守中那些关于孩子、教育和人生的感悟与启示。内容丰富而实在，读者特别是老师可以从这部著作中得到许多启发。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	680
1337	黄希庭心理学文集	978-7-5697-0994-0	\N	黄希庭 	平装	1-1	16开	2,680.00	\N	西南大学出版社	\N	\N	\N	2022-01-01	/book/40ca2a52-4441-41c0-94ec-f43c2229a6781082391.jpg	《黄希庭心理学文集》（全十卷），是著名心理学家黄希庭先生从教60余载学术思想与人生智慧的精华荟萃。系统收录了黄希庭先生在人格心理学、时间心理学、社区心理学等领域的经典著作、学术文章与重要的演讲文稿，是当代中国心理科学研究及成果的典型代表，具有较高的学术价值和人文价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	757
1338	进口产品质量对我国企业性别工资差距的影响研究	9787563833023	\N	文磊 	0	1-1	16开	59.00	275.0千字	首都经济贸易大学出版社	260	\N	\N	2021-12-01	/book/f43fb61c-e7a5-4347-9e16-75571beabf2e1082477.jpg	长期以来，我国实施出口导向型贸易政策，大力发展出口贸易。伴随进口贸易的快速扩张，我国企业性别工资差距也不断扩大。女性相对于男性收入的比例由1988年的88.4%下降到1995年的82.5%，2007年进一步下降到78.28%。本书从进口产品质量入手，通过定性分析和定量分析相结合的方式，考查进口扩张对我国企业性别工资差距的影响。在以稳增长、调结构、提质量为特征的外贸新常态下对进口产品质量与我国企业性别工资差距进行研究，不仅有助于我国在传统比较优势弱化、国内资源环境压力增大的背景下逐渐形成以品牌、技术、质量、服务为核心的竞争新优势，也为调整收入分配格局提供一定的理论支撑和实践指导。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	942
1339	企业战略管理（第六版）	9787563833030	\N	宋云 	0	1-1	16开	39.00	358.0千字	首都经济贸易大学出版社	284	\N	\N	2021-12-01	/book/c619552b-edc6-4f4a-abdf-f5876e4181131082482.jpg	本书作者宋云从1990年开始从事企业战略管理课程的教学工作，根据多年的教学经验和对企业战略管理理论的研究，于2000年出版了《企业战略管理》一书，本书是作者对企业战略管理理论研究成果的归集整理和理论上的探索总结，历经30年，销量近10万册，此次为第六次再版。 《企业战略管理》第六版在内容方面做了大幅度的调整，对整体结构、章节顺序做了很大的改动，补充了许多新理论和新理念，加大了经典企业案例和事例用以佐证所阐述的观点，增强了本书的实用性。希望借此能为我国企业战略管理理论的教学与研究以及实践运用做出应有的贡献。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	268
1340	青年说：感恩中国科学家——仰望民族复兴路上的闪耀“星”光	9787564383206	\N	高平平 	0	1-1	16开	88.00	327.0千字	西南交通大学出版社	330	\N	\N	2021-10-01	/book/d03ce861-df3b-4370-8683-8fe559b1f8641082486.jpg	本书是西南交通大学党委学生工作部、西南交通大学出版社、《教育导报》面向西部地区27所“双一流”高校举办的“学科学家精神 喜迎建党百年”主题征文大赛的优秀作品集，是深入学习贯彻习近平新时代中国特色社会主义思想、庆祝中国共产党成立100周年的成果之一。本书以感恩为主题，精选了100篇优秀作品，旨在充分激发当代大学生的爱党爱国热情，在大学生群体中大力弘扬新时代科学家精神，广泛凝聚青年学生的奋斗力量，具有一定出版价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	429
1341	复杂城市环境下综合交通枢纽火灾防治研究与应用	9787564380748	\N	朱颖 李正川 总主编；赖良驹 林程保 陈俊敏 彭小兵 张冬奇 著 	0	1-1	16开	160.00	413.0千字	西南交通大学出版社	320	\N	\N	2021-06-01	/book/563bbead-04e9-4cea-bb38-b736008876e11082490.jpg	本书为“复杂城市环境下综合交通枢纽成套技术研究丛书”之一，系统分析了国内外大型综合交通枢纽工程防灾设计、建设规划与运营管理模式，结合沙坪坝综合交通枢纽的工程特点和使用特性，从设计、施工、运营、维护等方面入手，研究了沙坪坝综合交通枢纽工程可能发生的火灾特性及防排烟、灭火及防火分隔、自动报警及联动、人群应急疏散及诱导、火灾救援体系及应急预案五部分的设计难点，在此基础上展开研究并提出了相对应的防控措施。本书的研究具有较高的学术价值，且对类似工程项目的防灾设计有重要的借鉴意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	749
1342	氢能源有轨电车运营概论	9787564383459	\N	佛山市轨道交通发展有限公司运营事业总部 	0	1-1	16开	49.00	260.0千字	西南交通大学出版社	168	\N	\N	2021-10-01	/book/a942895e-3113-410b-8bad-99451b475e5e1082495.jpg	本书是城市轨道交通运营企业面向有轨电车运营岗位的培训教材。本书根据氢能源有轨电车的运营现状，围绕在运营生产过程中与“氢”直接相关的安全管理、设备维保和运营组织等三项核心业务，在实践的基础上阐述运营阶段的生产业务解决方案，总结运营管理经验。氢能源有轨电车的运营安全管理基于现代有轨电车运营安全管理体系，结合氢能源行业的安全规范。设备维保采用行业的传统维保管理模式及技术规范，在涉氢环境和涉氢设备的维修维保工作中依照行业技术标准，采用科学合理的管理方法，规范作业标准、保障安全生产。运营组织将轨道交通运输组织和加氢站运营有机结合，按照有轨电车行业标准开展行车组织、乘务运作、客运管理，针对氢能有轨电车特点对加氢行车组织、涉氢模块故障处理、氢能列车客运管理、加氢站运作等进行专项业务论述。本书基于理论和实践两方面阐述了氢能源有轨电车的运营管理，将为我们在轨道交通领域更好地探索和应用氢能提供有利条件。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	770
1391	民宿运营与管理（配课件）	978-7-5637-4010-9	\N	洪涛 苏炜 	\N	1-1	16开	45.00	\N	旅游教育出版社	\N	\N	\N	2019-01-01	/book/4484b306-fda7-446f-b919-77d1dce995ae4010-9.jpg	本教材以民宿职业人才、民宿经营者、乡村旅游基层管理者为目标群体，架构了包括“认识民宿、民宿的设计和规划、民宿的设立、民宿产品的开发和设计、民宿的接待服务、民宿的日常管理、民宿IP建设与传播、国内外民宿建设及未来发展布局“在内的全面的民宿运营与管理体系。知识框架贯穿于民宿准备——开发——经营的全过程，深度剖析国内外经典民宿案例，提供全方位的民宿运营管理解决方案，引导我国民宿业的良性发展和经营品质提升。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	547
1392	大数据与互联网公司估值Ⅲ：美国上市公司精选案例分析	9787565443701	\N	陈玉罡 鲁济华 	0	1-1	16开	49.00	168.0千字	东北财经大学出版社	180	\N	\N	2022-01-01	/book/ffcaa0f9-b28d-4212-b21b-6a29fd5248ec1082878.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	271
1393	中国农村集体经济改革与发展研究	9787568013116	\N	彭海红著 	\N	1-1	16开	158.00	\N	华中科技大学出版社	\N	\N	\N	2021-05-01	/book/5b70fb9f-9d5f-4ba3-b7e4-6a854387ea569787568013116.jpg	"专著,本书系中国农村改革四十年研究丛书中的一种.套书以中国特色社会主义理论体系,尤其是习近平新时代中国特色社会主义思想为指导,站在中国特色社会主义事业发展和改革开放全局的视角,紧紧围绕探索中国特色社会主义农村发展道路的主题主线、主流本质,运用大量一手资料,从农村民主政治发展与乡村治理体系建设、农业现代化与经济发展、农村社会建设与民生保障、农村社会主义精神建设与文化发展、农村环境治理保护与美丽乡村建设等方面,全面梳理、研究、呈现改革开放40年来中国农村、农业、农民改革与发展的历程和路径、重点和亮点、经验和启示,展现中国乡村40年发生的翻天覆地变化,深刻总结中国农村改革与发展40年的成就与经验,揭示中国农村改革与发展的规律与趋势"	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	869
1394	其命维新——刘道玉口述史	9787568071703	\N	刘道玉著 	\N	1-1	16开	198.00	\N	华中科技大学出版社	\N	\N	\N	2021-06-01	/book/ab36a07c-9c4f-4e89-84e9-e40d3c0a36bc9787568071703.jpg	"本专著,从担任武汉大学副教务长到校长共计22年.本书主要记叙的是作者任校长的近8年时间中的所作所为.本书由八章构成,第一章是改革引论,阐述了影响教育改革的一些重要观念和措施,以作为改革的铺垫；从第二章到第七章,全面记叙了武汉大学改革中的实践和经验.作者是研究创造教育学的,必须身先士卒,践行自己的创造教育理念.因此,创新精神贯彻在教学改革的全过程,本书的书名就体现了这个主旨.最后一章是作者准备在武汉大学实施改革的第二个五年规划,具有承前启后的作用,它既是作者在武汉大学改革的延续,又勾画出了武汉大学未来的美好远景.从某种意义上说,这一章体现一个励志改革者的精神境界：创新无止境！"	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	789
1395	中国现代文学基础理论稀见文献选编	9787568070102	\N	"贺昌盛,何锡章主编" 	\N	1-1	大16开	98.00	\N	华中科技大学出版社	\N	\N	\N	2021-03-01	/book/a90e160f-213f-4ffe-9419-17cf2fc0cbef9787568070102.jpg	"专著,中国现代文学基础理论稀见文献选编选择编辑了部分具有代表性的稀见理论文献资料,一方面为读者寻找这些稀见资料提供查找阅读的方便,另一方面也希望以此为线索,指引读者进一步阅读相关的文献资料,填补了中国现代文学基础理论文献整理的空白,并且初步描画出了现代文学理论演进的具体历程,为中国现代文学的研究开拓了诸多新的学术生长点.为大学中文专业中国现代文学方向的学者和教师,以及中文专业的本科学生、硕士与博士研究生,用以在现有教材学习的基础上开拓视野,深化和拓展相关的理论研究,以进一步推进现代文学研究的发展."	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	689
1396	太赫兹生物医学科学与技术	9787568069151	\N	(韩)孙周贤Joo-HiukSon编著 	\N	1-1	16开	198.00	\N	华中科技大学出版社	\N	\N	\N	2021-03-01	/book/6a918f33-c15d-4a41-aa8d-e118f69299f99787568069151.jpg	"本专著,这本关于太赫兹装置、测量技术和应用的非常全面的最新研究著作(专门针对生物和生物医学的用途)为那些希望调查和理解这一新兴技术领域且拥有日益增长的兴趣的人来说,提供了精彩的介绍和持久的参考.撰稿者包括许多优秀的研究团体和当今世界上最著名的专家.具体主题包括太赫兹源和探测器、脉冲和连续波电路、成像和层析技术、导波元件、溶剂化合物和生物分子的光谱研究、太赫兹电磁场与生物的相互作用及其最近在生物医学领域的应用(例如,药物吸收、癌症检测和纳米颗粒探测)."	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	837
1397	庐山常见植物图鉴	9787568071888	\N	"董洪进,李世升主编" 	\N	1-1	16开	228.00	\N	华中科技大学出版社	\N	\N	\N	2021-07-01	/book/a2829a0d-a10e-4447-b56c-ff0f63fe70569787568071888.jpg	"专著,庐山以雄、奇、险、秀闻名于世,集教育名山、文化名山、宗教名山、政治名山于一身,具有较高的植物多样性,这些植物资源对维持庐山地区的生态平衡与生物多样性具有重要作用,同时也为人类生产、生活提供了多方面的种质资源. 本书在庐山地区多年野外实地考察和标本采集的基础上,筛选出近年来庐山较为常见的300种植物,精心编排,分别介绍其鉴定特征、生境及花果期,并附上彩色图片,以及植物学野外实习方案、植物标本的采集与制作等内容. 本书图文并茂,具有系统新、科学性和科普性等特点.本书可作为普通高等院校生物科学、植物科学等专业植物学野外实习的指导参考书,也可供植物研究相关科研人员及广大植物爱好者学习参考."	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	791
1343	健康管理学	9787564383503	\N	马兴铭 陈煜 	0	1-1	16开	59.00	479.0千字	西南交通大学出版社	340	\N	\N	2021-10-01	/book/5c955f80-3233-4cd3-87f7-2b4533cb6c4d1082500.jpg	本书是高等学校健康服务与管理专业系列教材之一，由西华大学、成都医学院等学校联合编写。本书分为健康管理的基本技术和技能、国家基本公共卫生服务与健康管理、慢性非感染性疾病健康管理三个模块，并兼顾了健康管理师国家职业标准的技能要求。其中，健康管理的基本技术和技能模块包括健康管理基本策略、健康风险评估与干预、常用健康干预技术；国家基本公共卫生服务与健康管理模块包括健康信息与健康档案、中医特色健康管理等方面的常见慢病健康管理。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	785
1344	分数阶广义线性系统的研究与应用	9787564382339	\N	冯再勇 	0	1-1	16开	49.00	217.0千字	西南交通大学出版社	200	\N	\N	2021-08-01	/book/27e9d23e-98c3-48cb-88bf-de19ddcaae8c1082516.jpg	本书为学术著作。广义系统广泛存在于各类机电、控制系统中，绝大部分针对广义系统的研究也都来自机电、控制等工程领域。近年来，以智能材料、新电池装置和分数阶电路为代表的新型机电系统逐渐涌现。由于它们自身的固有特点，在对它们进行系统建模和控制时，常常要用分数阶广义系统来刻画，这就需要我们加强对分数阶广义系统的研究。本书以最基础的分数阶广义线性定常系统为研究对象，研究了其运动分析，系统能控性、能观性以及观测器设计等基本控制问题，探讨了其在分数阶电路中的应用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	160
1345	钢波纹板及其复合结构在大基建中的创新研究与应用	9787564382940	\N	彭海涛 等 	0	1-1	16开	168.00	420.0千字	西南交通大学出版社	368	\N	\N	2021-10-01	/book/2e27843c-75e1-42ab-bd8f-8d2e824d074a1082523.jpg	波纹钢板作为弥补目前混凝土结构缺陷的替代品，是将板材通过波纹成型增加其强度并通过组装施工的新型结构物。钢波纹板及其复合结构具有施工速度快、受力性能好、工程造价低、耐久性好、适用性强等显著优势，属于真正的工业化建筑，可应用在公路、市政、铁路、采矿、能源、军事等众多行业的基建领域，符合我国建筑行业的绿色、环保的可持续发展理念。目前，波纹钢板在我国应用起步比较晚，工程界对该结构的认识和理解程度不高，推广应用的难度比较大。本书通过研究其受力特点、防腐技术、耐久性保证措施、适用条件和范围，结合多个典型工程应用案例对其进行了系统介绍，旨在提高工程技术人员对其应用的正确认识和理解，提高采用波纹板及其复合结构解决技术问题的能力，为大基建工程提供助力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	627
1346	基于变电站全闭环自动化运行的机器人巡检技术	9787564383350	\N	王纪渝 黄绪勇 马力 唐标 程俊 赵其根 王欣 于辉 秦雄鹏 	0	1-1	16开	79.00	320.0千字	西南交通大学出版社	244	\N	\N	2021-10-01	/book/43bacd47-d55e-483f-8263-86f901ee6b1d1082525.jpg	本书是电网企业智能巡检技术系列专著之一。云南电网智能机器人巡检系统能够实现变电站全天候、全方位和全自主巡检作业，可以代替人开展例行日常巡视、抄录表计、红外普测等十二项工作，基本实现全闭环自动化运行。从智能巡检机器人的推广应用上看，基本可取代人工巡检，运维人员只须定期到现场核对性巡检、其它时间在主站远程检查上传信息即可。本书通过研究变电站智能巡检机器人整合机器人技术、电力设备非接触检测技术、多传感器融合技术、模式识别技术、无轨导航定位技术以及物联网技术，采用自主或遥控方式对变电站室内外设备进行可见光、红外、声音等检测，可以全流程替代或辅助人工开展室外设备巡视，实现变电站全闭环自动化运行的机器人巡检技术替代人工巡检，减轻了基层班组一线员工的工作负担，使电网企业变电站可以通过机器人全天候、全方位和全自主巡检作业。本书可供从事电网变电领域的运维、技术研究以及智能机器人技术研究、开发的人员参考使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	573
1347	北山有故事	9787564379735	\N	中国人民政治协商会议重庆市涪陵区委员会 	0	1-1	16开	76.00	223.0千字	西南交通大学出版社	240	\N	\N	2021-11-01	/book/2ccae576-9757-4fe9-87c8-69e1aefd86c61082535.jpg	本书为地方文化读物，搜集整理了流传于涪陵地区的的民间故事。涪陵北山与涪陵城隔江相望，风光独秀、人文荟萃。北宋绍圣四年，著名思想家、教育家程颐因“元祐党争”贬谪来涪州，驻足于北山脚下普净禅院，并在北岩石壁上凿洞点注《周易》，完成了程朱理学的开山之作《周易程氏传》。从此，涪陵北山作为官方显学“程朱理学”的发祥地而闻名天下。本书围绕涪陵北山和北岩文化，搜集整理了一批优秀故事，力图通过短小精悍的形式，生动有趣的内容，将北岩文化知识普及千家万户。其内容包括：人物传说、神话传说、物产传说、生活传说、地理风物传说等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	395
1348	高中物理合作学习	9787564382117	\N	麦建华 袁勇 	0	1-1	16开	48.00	265.0千字	西南交通大学出版社	236	\N	\N	2021-08-01	/book/fad6a09c-0b2b-4a1e-8040-f296b107ea6c1082541.jpg	合作学习是大家通过共同工作来促进自己和他人学习效果最大化的一种教学方式，可充分体现教师主导作用与学生主体地位，引导学生主动参与学习过程。本书从学生学的角度去设计，以知识为主线，以卡甘合作学习法为基础，从合作学习之本、合作学习之理、合作之组、合作学习之策、合作学习之思、合作学习之践、合作学习之旅、合作学习之光八个角度阐述高中物理合作学习的概念、方法、策略、教学任务设计与实践，通过对高中物理教学的思考及对国内实施合作学习的有效性进行总结，旨在促进高中物理教学质量与学生物理学习效果的提升。本书内容布局合理得当，实用性较强，可作为从理论到实践研究合作学习与课程整合的指导书，尤其是为研究和实施高中物理合作学习的教师们提供重要的教学参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	334
1349	时代脉动——高速铁路发展简史	9787564382155	\N	曲思源 	0	1-1	16开	58.00	422.0千字	西南交通大学出版社	376	\N	\N	2021-11-01	/book/9a63e284-227a-456f-a898-7f928227fb341082543.jpg	本书为高速铁路科普读物，从技术发展的客观角度，以我国高铁技术发展为核心，向读者整体真实地展现了我国高铁技术发展历史、高速铁路技术、运营组织与管理，并将其放到世界高铁发展视野中比较，分析其他各国高铁技术的发展状况，深度分析我国高铁与其他国家高铁技术的差别，从中比较出我国高铁发展的竞争力、发展前景和短板，为我国高铁的进一步发展献策献力。本书介绍高铁技术知识兼具科学性和可读性，旨在让读者了解我国高速铁路的技术发展历程，强化民族自信与自豪。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	610
1350	智能家居工程技术（活页式）	9787564382797	\N	赵永富 聂兆伟 龚晓娟 	0	1-1	16开	48.00	359.0千字	西南交通大学出版社	256	\N	\N	2021-09-01	/book/b29f6868-031e-4b78-82e3-d27adf5ad93c1082547.jpg	本书是中等职业院校物联网智能家居方向的专业教材，采用活页式按项目制编写，主要内容包含：智能家居系统认知与操作、照明系统实现、安防监控系统实现、环境监控系统实现、背景音乐系统实现、家庭影院系统实现、电动窗与窗帘系统实现、家电控制系统实现、供电系统实现等10个项目44个任务，重点突出项目设计和岗位技能训练。 本书也适合作为中等职业院校计算机类、电子信息类等专业的教材，以及智能建筑、智能家居行业施工安装与运维等专业技术人员的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	564
1351	量子力学和虚数的哲学解读	9787564383213	\N	耿化民 	0	1-1	16开	88.00	190.0千字	西南交通大学出版社	188	\N	\N	2021-10-01	/book/3b1e0e35-aa1c-4853-b1eb-52aff7067d2b1082562.jpg	本书不仅对量子力学的基础概念进行解析，更重要地对全新的量子辐射能量方程和时空确定原理的研究结果和分析推论进行阐述解读，同样也全新地论述了虚数及复数微分方程的数学基础原理，并对洛伦兹变换不协变性问题、太阳运动与水星进动的关系等新的研究成果内容进行了阐述，同时附有对弹性力学的基本问题进行解读。本书可看为作者先后出版的《量子基础构造原理解读》《量子力学基础原理解读》《量子物理数学基础解读》系列书的修订总结，适合教师、研究生、科研工作者及相关学科的专家学者阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	877
1352	城市轨道交通低压配电技术（智媒体版）	9787564383336	\N	文晓娟 李孝普 	0	1-1	16开	39.00	343.0千字	西南交通大学出版社	224	\N	\N	2021-10-01	/book/b731968a-fefd-4d28-af8a-dd02ffcf94221082563.jpg	本书为高等职业教育城市轨道交通机电技术专业教材，主要内容包括：城市轨道交通低压配电基础知识、系统设备、常用工具和材料、室内配线、设备维护、设备故障分析及处理等内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	375
1353	城市轨道交通全自动运行系统行车调度团队任务复杂性理论与方法	9787564383497	\N	牛可 	0	1-1	16开	80.00	204.0千字	西南交通大学出版社	212	\N	\N	2021-11-01	/book/d1867f6e-c60c-4d98-a809-301d54dd99461082566.jpg	本书为学术著作，采用认知工程理论、复杂性理论、网络理论以及工效学方法等多学科融合的方法，分析城市轨道交通全自动运行系统（FAO）控制中心团队任务本质，研究以事件为基础的团队任务复杂性度量模型，形成适用于FAO系统行车调度团队任务的复杂性理论与方法。本书在交通运输工程领域首次针对铁路系统团队任务复杂性尤其是FAO趋势下的团队任务复杂性概念、影响因素、度量方法和形成机理进行了研究，其理论成果能够为铁路系统控制中心团队任务流程设计和优化提供科学指导，也能为航空空中管制中心、核电主控室以及舰船指挥中心等自动化系统的设计提供参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	308
1354	中国古代文学（上）（第二版）	9787564383558	\N	罗莹 曾晓洪 	0	2-1	16开	59.80	618.0千字	西南交通大学出版社	396	\N	\N	2021-11-01	/book/a24cb48d-078e-446e-b58c-cdcd714736241082568.jpg	本书是高职高专语文教育专业的专业基础课配套教材，共2册。本书为上册，分为先秦文学、秦汉文学、魏晋南北朝文学、隋唐五代文学四编。每编开头设“概说”，总述每一历史时期文学发展的总貌，适度分析文学发展与特定时期的经济、政治、思想、文化等方面的关系；按文体分立章节，每章（节）由文学史简述和作品选读两部分构成；每章（节）后设“思考与练习”，重点章（节）后设“课程思政提示”。本书再版时体现四大特点：一是文学史与文学作品合编，点与面充分结合；二是注重知识性、思想性、启发性和实用性相结合；三是注重内容的深入浅出与繁简适度；四是融入课程思政的元素，加入融媒体资源。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	484
1355	路面形貌数字化测量技术研究与应用	9787564383718	\N	王元元 	0	1-1	16开	58.00	266.0千字	西南交通大学出版社	196	\N	\N	2021-11-01	/book/2ee9c821-ef88-490f-a833-29fb13a26e5c1082572.jpg	本书为公路路面养护方面的学术著作，首先针对影响路面抗滑性能的路面宏观、微观形貌指标的数字化测量展开研究，对传统的光度立体算法和双目重构算法作了改进与优化；然后建立起了不同于传统的以摩擦系数为评价指标的新的评价体系，即以从路面形貌中提取出的优化指标BPN和DF60为评价指标的评价体系，以更全面系统地评价路面的抗滑性能；最后，经过对比分析，采用多元二次多项式模式建立了数字形貌指标与抗滑性能指标之间关系的模型，并结合IFI评价指标体系对该模型的准确性进行了分析验证。本书主要对路面形貌的数字化测量技术作了相应改进，并对提高路面抗滑性能给出了相关措施，不仅响应了国家“交通强国”的战略，也为交通基础设施更好地服务于驾驶、降低交通事故率作出了有益的探索，同时为自动驾驶、智能治理等提供了有益的参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	539
1356	人居环境自然适宜性评价与优化策略研究——以东莞市为例	9787564384067	\N	彭义春 	0	1-1	16开	76.00	200.0千字	西南交通大学出版社	216	\N	\N	2021-11-01	/book/5ba77a2d-808d-442b-9725-7b466757da801082581.jpg	本书为学术著作，运用计算机GIS、RS和SPSS等技术，研究东莞市地形、气候、水文和植被等自然因子对人类居住环境的影响。本书以东莞市2014-2020年的气象数据、DEM数据及东莞行政区划矢量数据等相关资料为基础，借助GIS、RS和SPSS等技术，采用窗口分析法、K-最近邻等算法，建立人居环境指数模型(HEI)；再对东莞市人居环境自然适宜性进行定量综合评价分析；最后，根据各镇街2020年人口密度数据以及土地利用现状数据中的建设用地，对人口空间分布进行处理，再结合自然适宜性评价结果，分析两者的相互关系并提出优化建议。本书对国内其他城市的人居环境适宜性、宜居社区（村）工作具有一定的借鉴意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	616
1357	城市安全风险评估技术及其应用实践	9787564384029	\N	陈勇 赖小林 盛锴 	0	1-1	16开	98.00	624.0千字	西南交通大学出版社	400	\N	\N	2021-11-01	/book/a6706cf5-68e9-44ec-b722-1f52c5f71b071082588.jpg	本书为学术著作，以城市安全风险评估为主线，以凝练总结“点、线、面”城市安全风险评估技术方法体系为目标，以深圳市城市安全风险评估实践经验为落脚点，总结归纳了分别适用于风险单元、重点行业领域和区域的安全风险评估方法体系，可以为推动城市安全风险评估工作深入开展提供参考，对于相关政府部门、技术服务机构开展城市安全风险评估工作具有一定的参考借鉴价值。全书立足实际、案例丰富、材料翔实，是深圳市在城市安全风险评估工作的总结，为我国城市安全风险评估提供了方法和手段，可作为相关从业人员的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	965
1358	现代礼仪学（第2版）	9787564384852	\N	龚波，陈保健 	0	2-5	16开	30.00	257.0千字	西南交通大学出版社	164	\N	\N	2021-12-01	/book/5dec3499-f9bb-4651-b15b-2a1c8ac2bc9b1082589.jpg	本书是高等院校礼仪类课程教材。全书分为礼仪的内容与原则、个人礼仪、学校礼仪、家庭礼仪、公众基本礼仪、求职礼仪、社交礼仪、接待礼仪、办公室礼仪9个项目27个任务，较为全面总结了学生在人际交往中可能用到的各种礼仪规范，重点突出社交礼仪，兼顾学生应聘时的基本礼仪，将公共礼仪和职场礼仪相结合，并精选案例进行讲解分析。本书有助于学生强化文明行为，提高文明素养，对读者建立良好的人际关系与健康成长有良好参考意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	997
1359	焊接技能培训教程	9787564384180	\N	武永志，王贺龙 	0	1-1	16开	37.00	285.0千字	西南交通大学出版社	188	\N	\N	2021-11-01	/book/838b5704-ea94-4d60-a730-fc7010c977701082590.jpg	本书是为培训从事压力容器、压力管道焊接的焊接技术工人而编写的，主要讲授了焊工安全文明生产知识、焊条电弧焊、手工钨极氩弧焊、手工钨极氩弧焊+焊条电弧焊联合焊接方法的基本操作技术，并结合实例按操作项目进行讲解。本书由浅入深地向学员传授焊条电弧焊、手工钨极氩弧焊的不同位置的焊接操作手法，配合视频演示，使学员能从书面理论到感观认知，学习焊接技术。本书可供缺乏焊接实操经验的中、高职院校学生、企业新入职员工及有志于从事焊接工作的社会人员学习。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	559
1360	乐以成之——乐黛云先生九十华诞贺寿文集	978-7-309-15784-0	\N	张辉 刘耘华 编 	精装	1-1	16开	158.00	625.0千字	复旦大学出版社	585	\N	\N	2021-09-01	/book/cf6a41a9-cb98-400d-8b38-01b87a75ceef1082599.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	449
1361	融合、感悟、认同——课程思政优秀案例集	9787560662213	\N	祁永敏 	0	1-1	16开	34.00	295.0千字	西安电子科技大学出版社	200	5606	\N	2021-12-03	/book/4e65a1a8-dc4c-4c35-9bd9-be125201c2b81082601.jpg	为增强“课程思政”教学设计能力，提升课程育人能力，打造精品课堂，提高育人效果，本书以汇编形式展示专业课程中“课程思政”的具体实践，以推广多样化的“课程思政”教学设计方法和“课程思政”育人经验，充分发挥示范辐射作用，促进教师相互交流学习，使更多的教师、学生从中受益。本书精选了50个有代表性的优秀“课程思政”教学设计案例，每个案例都包括课程基本情况、思政育人目标、与专业教学内容相结合的思政育人映射与融入点、教学实施过程、教学方法和载体途径、教学成效和教学反思这六个部分。 本书可作为专业课程的教学参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	246
1362	应用统计学（第二版）	9787560659947	\N	颜节礼 主编 王雷 主审 	0	2-1	16开	46.00	459.0千字	西安电子科技大学出版社	312	5606	\N	2021-12-13	/book/761deac8-f50e-4d22-8ed8-07ad5d1fee271082605.jpg	本书介绍了经济、管理和社会学研究中的主要统计方法，包括相关理论及软件操作，还提供了大量练习和六个单元的综合实验，以期帮助读者构建统计学的知识体系。本书注重统计思想和实证分析的逻辑，除了介绍每种统计方法的原理和实际运用，还结合统计方法的历史发展帮助读者理解统计方法的本质——基于概率思想的归纳推理和假设检验。本书在描述主要统计方法的基础上，重点结合实例讲解了参数估计、假设检验、列联分析、回归分析以及在经济分析中常用的时间序列分析工具和指数工具，希望对读者建立统计学科的基本学科架构有所帮助。 本书以大学本科生、研究生为读者对象，适合作为统计学的入门教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	387
1363	移动电子商务基础	9787560662268	\N	王亮 	0	1-1	16开	26.00	243.0千字	西安电子科技大学出版社	168	5606	\N	2021-12-13	/book/fc7810a7-72fd-4820-943b-75c369b6caea1082610.jpg	本书以项目为导向、任务为驱动，按照项目、任务的要求组织学习内容，以“任务情景—知识链接—实训项目”为内容框架，由浅入深地讲解移动电子商务的相关知识点和技能点。本书内容包括移动电子商务概述、移动电子商务技术、移动电子商务运营模式、移动电子商务营销、移动电子商务支付和移动电子商务安全六个部分。 本书案例典型，实践性强，内容翔实，结构清晰，图文并茂，集知识性与实践性于一体，强化知识和技能的学习，符合职业教育对技能型人才的培养要求。本书可作为高职高专院校电子商务专业及其他相关专业的教材，也可作为移动电子商务应用技能的培训教材以及移动电子商务爱好者的自学用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	893
1111	元人小令分类选注	9787569517873	9787569517873	罗锦堂 	\N	1-1	16开	98.00	\N	陕西师范大学出版总社	\N	\N	\N	2021-01-01	/book/0e104516-27e9-4ff1-b931-cefc6159d88a9787569517873.jpg	《元人小令分类选注》收录三百零五首能广泛代表元代文学水平和内容的小令，并依其性质分为写景、言情、伤别、感时、叹世、遣兴、怀古、咏物八类。每一首作品按曲文、注解、说明三部分进行分析，并附录所选小令作者简介以及对曲牌、宫调、句法、押韵等的简要说明，是了解元人小令以及元代社会、生活较为全面的文学文献资料。?	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	869
1364	高频电路原理与分析（第七版）	9787560662220	\N	曾兴雯 	0	7-1	16开	54.00	526.0千字	西安电子科技大学出版社	356	5606	7	2021-11-22	/book/a6a9f4ac-b877-4374-83ed-cc36db7006ad1082615.jpg	本书是《高频电路原理与分析（第六版）》的修订版，主要是在《高频电路原理与分析（第六版）》的基础上更新了部分电路，强化了系统概念和系统设计。本书内容包括绪论，高频电路基础与系统问题, 高频谐振放大器，正弦波振荡器，频谱的线性搬移电路，振幅调制、解调及混频，频率调制与解调，反馈控制电路和高频电路系统设计等。 本书可作为通信工程、电子信息工程等专业的本科生教材，也可作为高职高专院校相关专业的教材和有关工程技术人员的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	160
1365	建筑工程制图习题集	9787560661018	\N	张逯见 	0	1-1	16开	28.00	105.0千字	西安电子科技大学出版社	144	5606	18	2021-11-23	/book/29ec2a09-acd3-42cc-ac82-c4571dc553fa1082617.jpg	本书与张逯见主编的《建筑工程制图》(由西安电子科技大学出版社出版)教材配套使用。本书主要内容包括绪论，制图基本知识，投影法的基本知识和点、直线、平面投影，平面建筑形体的投影，曲面建筑形体的投影，轴测投影图，标高投影，建筑施工图，结构施工图，设备工程图，道路桥涵施工图。本书按照现行国家及行业制图规范的要求编写，可作为高职高专土建类相关专业教材，也可作为有关工程技术人员参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	595
1366	先进制造系统	9787560661421	\N	李雪 	0	1-1	16开	45.00	450.0千字	西安电子科技大学出版社	304	5606	10	2021-11-30	/book/65273932-67b3-44b1-a0fc-0299979f61801082621.jpg	本书系统地阐述了先进制造系统的规划、设计、建模、运行计划与控制、信息集成、再制造等理论和方法，主要内容包括先进制造系统概论、制造系统的理论基础、制造系统设计和建模、自动化制造系统设计、制造系统的物流设计、制造系统的计划与控制、制造信息化及系统集成、再制造与循环经济理论。 本书可以作为高等工科院校机械设计制造及其自动化、工业工程、物流工程等专业本科生、研究生的教材，也可供从事企业生产管理、设施规划、制造系统设计等工作的科技工作者参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	845
1367	信息科学与技术研究论文写作：案例与方法	978-7-5671-4365-4	\N	方勇 主编 	平装	1-1	大32开	49.00	\N	上海大学出版社	\N	\N	\N	2022-01-01	/book/e8457a19-932f-4351-b74e-aff60cbf21f21082625.jpg	本书为“研究生学术论文写作”丛书的一种，选取了电子科学与技术、信息与通信工程和计算机科学与技术领域20篇具有较高水准的论文作为示范案例，旨在使其更具针对性，同时也兼顾了示范案例的覆盖范围。我们邀请到了每篇研究论文的作者亲自撰文解析，完整勾画出科技论文写作的每一个环节，让读者能感受到论文写作的整个过程。对研究生而言，与论文作者直接交流，无疑是提升问题意识、提高研究水平、提升论文写作能力的最佳机会。 每篇示范论文的作者都力图从如何选题、立题；体现了什么样的科学关键问题；结合当前的研究现状，如何在现有的理论或方法上进行创新；如何实现有效论证；如何实现实验或仿真结果对创新理论方法的支撑，关键问题解决的论文主题框架如何构建；如何通过摘要、引言、论文总结完成论文的写作，以及论文发表后的反思等，反响与被引用，甚至论文的不足之处等方面，给读者进行全方位的解析。这是本书与其他论文写作方面的指导书的区别之处。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	145
1368	永恒的瞬间	9787544666831	\N	[白俄罗斯] 娜塔莉雅·巴特拉科娃 著；贝文力，何潇 译 	平装	1-1	大32开	55.00	\N	上海外语教育出版社	\N	\N	\N	2022-01-01	/book/8a3205bd-c810-4d1c-bd8d-4a1ca7aebbf51082626.jpg	女主人公卡佳曾拥有作为幸福生活标配的一切，但突然间，一切荡然无存，她内心充满了痛苦与绝望。这时，瓦季姆走进了她的生活，让她改变了自己的想法并回归幸福生活，她又开始相信爱情了。 哀伤的瞬间与幸福的瞬间，迷茫的瞬间与智慧的瞬间，无数内涵深厚的瞬间在明斯克的时空里连成“永恒的瞬间”，构成对“爱情”的当代白俄罗斯的诠释与表达。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	498
1369	新冠肺炎健康防护手册（电子版）【免费阅读】	978--	\N	张雅利 主编 许丹 方堃 副主编 	平装	1-1	大32开	0.00	\N	西安交通大学出版社	\N	\N	\N	2022-01-01	/book/f05e29fb-48ef-43d4-a2cb-ab15de496d221082630.jpg	《新冠肺炎健康防护手册》（电子版）是由西安交通大学生命科学与技术学院线粒体研究所书记、副所长张雅利教授带领团队成员，在疫情迅猛而来的形势下、在焦灼的等待中协力编撰而成。 全书主要包括新冠肺炎的基础知识、个人防疫原则、不同场所的防护准则、不同人员行为准则、新冠疫苗的相关知识等内容，图文并茂，直面人们防疫期间的困惑，帮助大家做好个人防护，快速击溃病毒突袭，希望长安城能早日重回车水马龙的繁荣景象。 （请扫描封面上二维码，免费阅读本书）	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	562
1370	直播带货从新手到高手	9787302585978	\N	谭焱焱 	平装	1-1	大32开	59.80	\N	清华大学出版社	\N	\N	\N	2022-01-01	/book/5a1ab428-7a7d-4d28-aff4-561a1883b1991082633.jpg	10章专题内容，一线直播运营达人倾心之作，行内大咖不愿分享的秘密。150多个干货技巧，拆解直播带货行业背后的秘密，让您的直播带货销量步步高！ 《直播带货从新手到高手》具体内容包括：直播带货的解析、变现路径的分析、开通直播的流程、直播设备的选购、直播场地的规划、直播预告的设置、直播内容的策划、直播文案的构思、直播脚本的制作、直播引流的技巧、直播带货的话术、提升销量的策略、刺激下单的技巧、变现的运营手段、直播带货的禁区以及提升口碑的售后等内容，以实战为核心，帮助读者直观地认识直播带货行业，掌握直播带货的技能，更好地开展直播带货业务，快速实现商业变现。 《直播带货从新手到高手》适合直播带货的新人主播，以及转型做直播的商家阅读，同时还可以作为企业直播带货岗位的培训教材，或供直播带货相关从业人员参加就业培训、岗位培训使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	370
1371	英语同步练习册（选择性必修第一册）	978-7-5689-2729-1	\N	王新瑜 	平装	1-2	大16开	9.65	257.0千字	重庆大学出版社	114	\N	\N	2022-01-01	/book/ae77137b-495a-4ba2-94cd-bc51607a13f51082641.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	808
1114	秦直道研究论集	9787561398456	9787561398456	孙闻博 	\N	1-1	16开	440.00	\N	陕西师范大学出版总社	\N	\N	\N	2018-06-01	/book/a7373e32-e53c-4c76-af7c-2ae50528fcfb9787561398456.jpg	本书是一部有关秦直道研究的综合性论文集。《秦直道研究论集》共分考古调查、研究论文、学术综述三个板块，收录论文共60多篇，内容涉及秦直道的修建、秦直道的路线走向、秦直道的历史社会意义、秦直道沿线的历史遗迹及传说等内容。本书以包容性、开放性原则，对秦直道研究领域的东线说、西线说的观点均做收录。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	359
1372	中国海关报关实用手册（2022）	978-7-5175-0548-8	\N	《中国海关报关实用手册》编写组 	平装	1-1	16开	400.00	\N	中国海关出版社	\N	\N	\N	2022-01-01	/book/fee81c83-7743-4005-a64d-2a14bda380511082645.jpg	《中国海关报关实用手册》是由中国海关出版社出版发行的重点图书和具有品牌效益的工具书，每年一版，2022年版是在2021年版的基础上根据我国《税则》的变化进行了修改，同时增加了有关我国新签订的自由贸易协定如 RCEP协定税率，提供了最新的出口退税率等内容。具体内容包括：10位海关商品编号、商品中英文名称及备注、检验检疫3位编码及名称、进出口商品普通税率、最惠国税率、暂定税率、出口退税率、监管条件、检验检疫类别、海关统计计量单位，以及各种最新区域或双边协定税率、特惠税率，进口商品从量税、复合税税率，消费税税率，关税配额商品税目税率表，以及海关通关系统常用代码表及说明、进口关税与进口环节代征税计税常数表等。该书有助于进出口企业及时了解进出口税收政策和贸易管制政策的变动情况，加快通关速度，提高通关效率。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	299
1373	价格革命：一部全新的世界史	9787559841018	\N	[美]大卫·哈克特·费舍尔 译者：X. Li 	精装	1-1	大32开	128.00	\N	广西师范大学出版社	\N	\N	\N	2021-12-01	/book/7c412fbd-27e3-4d99-9cac-a487967b4dd11082650.jpg	价格记录比任何其他可量化的数据都要丰富，并且跨越了历史的整个范围，从中世纪的谷物价格表到过剩的现代统计数据……它们与我们的日常生活息息相关，我们却很少会用历史学的眼光去审视它们。 　　费舍尔研究了这些丰富的数据，将广泛的研究和细致的学术研究与引人入胜的写作结合起来，以令人惊叹的价格的历史为轴，创造了一个涵盖所有西方文化的故事，赋予了世界史以全新的面目：四次价格革命浪潮，每一次都始于一个均衡时期，盛世中世纪、文艺复兴、启蒙运动，最后是维多利亚时代。每一场革命的特点都是持续的通货膨胀，不断扩大的贫富差距，日益增加的不稳定，最后在这一浪潮的高潮出现一场危机，其特点是人口紧缩、社会和政治动荡以及经济崩溃。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	476
1374	现代厨房管理（第2版）（配试题库）	978-7-5637-3739-0	\N	马开良 	\N	2-1	16开	32.00	\N	旅游教育出版社	\N	\N	\N	2018-01-01	/book/d3d5aa8c-4a62-46e5-b659-9f1dd3b451c73739-0.jpg	《现代厨房管理》是新编全国高等职业院校烹饪专业规划教材中的 一本。第一版自出版以来，受到广大学生和学校的欢迎。第二版教材在 原有的9章内容的基础上，增加了一章“厨房菜单管理”，丰富了原书的 内容，使教材更加完善。本书共十章，包括现代厨房管理概述、厨房组 织机构、厨房人力资源管理、厨房设计布局、厨房设备与设备管理、厨 房生产管理等内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	507
1380	酒水经营与管理（第6版）	978-7-5637-1163-5	\N	王天佑 	\N	6-1	16开	45.00	\N	旅游教育出版社	\N	\N	\N	2020-01-01	/book/2a786e83-fb89-4153-9138-d09a77f79f021163-5.jpg	本书根据现代饭店和餐饮管理对酒水经营知识的需要，结合我国酒 水经营实践，融合国内外名酒和饮料的历史、文化、种类及特点、酒水 经营设施、酒水经营方法和策略，并在总结多年教学与实践经验的基础 上编写而成。本书共分 11 章，从介绍酒水种类与特点开始，概述了葡萄酒、 啤酒、白兰地酒、威士忌酒、金酒、朗姆酒、伏特加酒、特吉拉酒、中 国白酒、开胃酒、甜点酒、利口酒、鸡尾酒和非酒精饮料等的销售和服 务方法，同时总结了各种酒水经营企业的组织结构、经营特点、经营设施、 营销方法和策略等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	704
1381	旅游实践英语（第3版）（下册）（扫码听音频）（配教师用书）	978-7-5637-4254-7	\N	吴 云 	\N	3-1	16开	35.00	\N	旅游教育出版社	\N	\N	\N	2021-01-01	/book/befdb23c-78e2-4948-bbd9-cc1296abcb6f4254-7.jpg	本套书分上下册，每册书有 10 个单元，每单元由 6 部分组成：热身 练习；旅游情景对话；两篇旅游应用文阅读；听力理解；功能句；口语操练； 旅游应用文套写。 本套书配有对话和听力理解部分的二维码音频资源，语音纯正，音 色表现力丰富，情景性强。可供高职高专及以上水平的旅游相关专业教 学使用，也可供旅游外语爱好者研习或自学。同时，本书亦可作为旅游 企业服务与管理从业人员的培训教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	374
1382	景区服务与管理	978-7-5637-4200-4	\N	郎富平、陈蔚 	\N	1-1	16开	58.00	\N	旅游教育出版社	\N	\N	\N	2021-01-01	/book/93d5010e-b5c9-4d34-a8be-a678d1b1ffd94200-4.jpg	教材包含了以往教材的精华部分，又增加了与时俱进的内容，并 且利用现代化教学手段，对书本中的知识点进行数字化处理，既方便 了教师教学，也利于学生对知识的消化和吸收，是一套同时具备前瞻 性和实用性双重属性的教材，是为旅游职业教育工作者量身打造的。实 训教材体现了产教融合与校企合作，教材内容既适合课堂教学又适合企 业培训。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	268
784	刘学锴文集	9787567649767	9787567649767	刘学锴 著 	\N	1-1	16开	170.00	\N	安徽师范大学出版社	\N	\N	\N	2020-12-01	/book/90c70f85-a2e7-431f-8de5-a65c64ad42989787567649767.jpg	《温庭筠传论》分为两部分：一是考辨研究温庭筠生平事迹及相关作品；二是阐释温庭筠的诗歌、词、骈文和赋、小说及其在中国文学史上的地位。《温庭筠诗词选》包括“诗选”“词选”“附录（骈文、小说）”三部分，是在《温庭筠全集校注》的基础上进行编选的。作品选注了多篇诗、词、骈文、小说，并对其做了注释疏解和必要的校勘。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	486
1383	酒店实训之餐饮服务	978-7-5637-4216-5	\N	曾小力、杨结 	\N	1-1	16开	68.00	\N	旅游教育出版社	\N	\N	\N	2021-01-01	/book/38a38279-30b8-4850-84a6-e2ee73017f7e4216-5.jpg	教材包含了以往教材的精华部分，又增加了与时俱进的内容，并且利 用现代化教学手段，对书本中的知识点进行数字化处理，既方便了教师教 学，也利于学生对知识的消化和吸收，是一套同时具备前瞻性和实用性双 重属性的教材，是为旅游职业教育工作者量身打造的。实训教材体现了产 教融合与校企合作，教材内容既适合课堂教学又适合企业培训。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	267
1384	酒店实训之前厅服务	978-7-5637-4211-0	\N	杨结 	\N	1-1	16开	58.00	\N	旅游教育出版社	\N	\N	\N	2021-01-01	/book/271c295b-609d-460b-996b-d128d71ffd234211-0.jpg	教材包含了以往教材的精华部分，又增加了与时俱进的内容，并 且利用现代化教学手段，对书本中的知识点进行数字化处理，既方便 了教师教学，也利于学生对知识的消化和吸收，是一套同时具备前瞻 性和实用性双重属性的教材，是为旅游职业教育工作者量身打造的。实 训教材体现了产教融合与校企合作，教材内容既适合课堂教学又适合企 业培训。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	638
1385	研学旅行指导师实务(配教学资源包）（二维码资源）	978-7-5637-4128-1	\N	邓德智 伍欣 	\N	1-1	16开	48.00	\N	旅游教育出版社	\N	\N	\N	2020-01-01	/book/7f33c955-973a-4a33-9787-3246f6096cd74128-1.jpg	本书对研学旅行指导师的职责与工作进行了全方位的讲解。研学旅 行指导师兼具导游与教师的双重职能，是保障研学旅行顺利有效开展的 核心岗位。本书从研学旅行指导师的概念、内涵开始，详细介绍了指导 师应该具备的职业素养、课程设计能力和应变技巧，并分别讲述了学校、 旅行社、基营地等不同主体的研学旅行指导师的工作流程与要点。书中 内容全面细致，讲解中结合了大量案例，极具实用性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	927
1386	研学旅行教育理论与实践(配教学资源包）（二维码资源）	978-7-5637-4126-7	\N	甄鸿启 李凤堂 	\N	1-1	16开	48.00	\N	旅游教育出版社	\N	\N	\N	2020-01-01	/book/b39cf9b7-6d89-4d46-b8a2-12e96f1fea914126-7.jpg	研学旅行的本质是一门校外实践课，符合一般的教育教学规律，但 又有其自身的特点。本书针对高职学生的知识特点，由浅入深介绍了研 学旅行相关的教育理论与实践方法，首先从心理学、教育学角度分析了 研学旅行指导师的角色定位，介绍了研学旅行的教育教学的目的和任务； 然后从设计、教学、评价三个环节重点讲解了研学旅行的教学实践方法。 书中各章节以案例导入的形式予以讲解，理论结合实践，带着问题进入 学习，既方便老师教学，又方便学生学习。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	273
1387	康养休闲旅游服务基础	978-7-5637-4282-0	\N	赵晓鸿 邹陆彬 李丹 	\N	1-1	16开	47.00	\N	旅游教育出版社	\N	\N	\N	2021-01-01	/book/61d0342e-d146-4381-b486-2e9b7d0542054282-0.jpg	本书主要讲解旅游服务的基础知识，特别是康养休闲旅游服务的基 本方式、特色服务等，通过对本书的学习，学生将能够掌握康养旅游服务、 休闲旅游服务的基本服务内容与服务规范要求，具备良好的康养旅游服 务与休闲旅游服务意识和职业素养，同时也可以为学习康养旅游服务、 休闲旅游服务相关方向课程打下理论基础。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	354
639	全球视角下的林业经济学	978-7-301-32652-7	9787301326527	(美)威廉·F.海德（William F. Hyde） 	\N	1	16开	79.00	590.0千字	北京大学出版社	464	7301	\N	2021-11-26	/book/8c93c11a-4fbd-4725-8965-65c0472aaa4b32652.jpg	本书将林业发展分为三个独立的阶段，并记述了天然林业与现代产业林业在各阶段的生物学和经济学模式。作者就许多重要的林业经济学问题进行了介绍，包括林业管理、林产工业体系、林业土地所有者、林业政策（如林业税和激励性开支）等。作者还探讨了当前的一些热点话题，如全球变暖、生物多样性和森林游憩功能的开发等。书中所用案例和数据来自六大洲，既包括发达国家，也包括发展中国家。作者认为森林是一种独特的自然资源，需要在其发展的各个阶段使用不同的管理方式和支持政策，其视野超越了传统林业经济学范畴。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	414
1388	高铁乘务英语（配二维码资源）	978-7-5637-3999-8	\N	苏健 	\N	1-1	16开	26.00	\N	旅游教育出版社	\N	\N	\N	2020-01-01	/book/79d7f5cd-fc65-4983-8104-7414dc2aae1e3999-8.jpg	本书结合了高铁行业的现状和发展趋势，基于高铁服务流程和标准， 利用任务型的教学理念，来设计教学模块和任务。希望以此来提高高铁 服务人员的英语服务能力。本书包含了票务，车站服务和车厢服务三个 模块。每个模块都包含学习目标、导入、情景对话和翻译练习。每个模 块分为若干个单元。每个单元先通过图片、单词匹配和问题讨论等活动 导入吸引学生兴趣，再学习服务场景中的典型对话让学生熟悉每一个服 务环节，在对话学习结束后有角色扮演情景对话和句子翻译练习来帮助 学生巩固相关学习内容。这样学生在每一个教学环节都能在任务的履行 过程中，以参与、体验、互动、交流、合作的学习方式，充分发挥学生 自身的认知能力，在实践中感知、认识、应用语言，在“干”中学，“用” 中学，通过完成一系列任务来激发学生兴趣和提升学习效率。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	200
633	语言政策与政治经济：全球化背景下的英语	9787521331080	\N	托马斯·里森托 编 	平装	1-1	大32开	55.00	\N	外语教学与研究出版社	\N	\N	\N	2021-12-01	/book/ad8d561f-d097-4efe-bb27-102916c68af51076946.jpg	本书内容主要包含三部分：第一部分包括四章，主要研究在古典自由主义理论中"国家"这一概念如何影响语言政策的模式和制定，以及从政治经济角度分析"国家"如何继续在英语作为广泛应用的交流语言的经济全球化世界体系中发挥重要作用；第二部分包括五章，研究了在一些国家和地区英语影响态度和政策的方式；第三部分由三个章节组成，重点讨论了全球英语、发展和民主。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	430
634	从族际通婚看云南通海蒙古族的文化适应	978-7-5482-4318-2	\N	张玉皎著 	平装	1-1	16开	56.00	173.0千字	云南大学出版社	162	\N	\N	2021-06-01	/book/70263037-ed3f-4e13-af0e-a90fade699a51076948.jpg	族际通婚是研究少数民族文化适应的重要视角。《从族际通婚看云南通海蒙古族的文化适应》主要以云南通海蒙古族为研究对象，并结合历史文献、人口发展、墓志和家谱等资料对通海蒙古族族际通婚和文化适应的历史进行考察；并通过问卷调查和数理统计，对通海蒙古族族际通婚状况和影响因素进行分析研究。本书以族际通婚的民族混合家庭为研究场域，对少数民族族际通婚和文化适应的关系模式展开研究，主要包括三个方面内容。第一，云南通海蒙古族历史上的族际通婚和文化适应研究。第二，云南通海蒙古族族际通婚与文化适应现状的调查与分析。第三，少数民族族际通婚与文化适应的关系探讨。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	715
635	日语听力进阶教程	978-7-5672-3653-0	\N	孙杨 	平装	1-1	16开	45.00	223.0千字	苏州大学出版社	\N	\N	\N	2021-11-01	/book/e416754a-fdb0-49a2-b575-4267d13efe561076955.jpg	本书是以零起点日语学习者为对象而编写的日语听力进阶教程，结合日语高考大纲及新课标听力能力要求，既可适合零起点大学日语学习者使用，也可适合高中日语学习者使用。本书分为专项听力训练和综合听力训练两大部分。其中专项听力训练部分由时间问询、道路问询、顺序问询、近音辨析等听力技能训练构成；综合听力训练按照高考真题模式进行编写。每项构成单元后均配有对应专项练习及单元总练习。本选题为日语学习者听力技能和对听力的理解思路进行有效指导，以便提升日语考生对各种类型文章听力理解能力，提高他们的听力作答正确率。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	642
636	PPP项目土地应用研究	9787563832514	\N	彭程 等 	0	1-1	16开	40.00	185.0千字	首都经济贸易大学出版社	160	\N	\N	2021-11-01	/book/b9752c6e-e0f9-4773-a2de-24a352ddc1f01076959.jpg	本书针对目前国内PPP这一新型政府和社会资本合作模式，聚焦其在建立健全我国城市基础设施和公共服务体系、推进新时代城镇化建设中的作用和做法，在搜集、分析现有政策、法规、案例的基础上提出PPP模式的改革思路与政策建议。主要包括以下方面：1.梳理现行PPP项目用地法规，并从应用层面对PPP项目用地取得方式进行整理，同时重点论述“土地资源配置”方式的可行性。2.通过研究政府性基金预算的使用限制，探讨其在城镇综合开发类项目中的应用。3.通过整理典型PPP项目案例，梳理各类项目中的土地应用方式，并从扩大PPP项目收入来源的角度，思考“溢价归公”模式的应用的可行性。4.从土地取得、土地价值的分配利用等多角度提出政策研究建议。本书选题思路较新颖，兼具学术与政策建议价值，在目前PPP类读物的出版市场上尚不多见。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	782
637	新编通用德语（上册）	978-7-301-32176-8	9787301321768	桂乾元 	\N	1	16开	98.00	520.0千字	北京大学出版社	388	7301	\N	2021-11-22	/book/8415bdc2-c56d-4223-b0dd-04241dc94b0532176.jpg	《新编通用德语》为适合本科德语专业和德语作为第二外语、德语培训班以及高职德语专业学生使用的德语入门教材。 上册教材分为“语音部分”和“课文部分”两大部分。 “语音部分”共10个单元，分为语音常识、发音提示、练习等3个部分，附有德语字母表、德语字母歌，以及德语元音表和辅音表。 “课文部分”共15个单元，涉及相识、问路、饮食、交通、居住、拜访、购物、天气、就医、在邮局、在银行、旅行、打电话、节日和看电视等有关日常生活的主题。每单元由对话、听力和阅读3个部分组成，每个部分均配有多种练习。 本书配有二维码，扫码即可听取课文录音。 本书为授课教师提供教学课件和习题参考答案。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	767
638	PS教程：迅速提升Photoshop核心技术的100个关键技能	978-7-301-32509-4	9787301325094	凤凰高新教育 	\N	1	16开	119.00	4000.0千字	北京大学出版社	392	7301	\N	2021-11-16	/book/02350da2-3fb5-406c-b68c-854f3b58e96932509.jpg	本书以Adobe公司出品的Photoshop2020为蓝本，将熟练掌握Photoshop核心技能作为出发点，全面系统地讲解Photoshop图像处理的方法和技巧，并分享运用Photoshop进行图像处理的思路和经验。 本书共分为两大篇章。 第1篇（第1-8章）：专项技能篇。主要从图像处理准备工作、选区创建与编辑、图层应用、文字与路径应用、通道与蒙版的应用、图像光影调整与调色、滤镜应用以及高效处理图像的方法8个方面深入讲解Photoshop的专项操作技能与技巧，帮助读者透彻掌握每一项关键技能，迅速提高图像处理能力。 第2篇（第9-12章）：综合实战篇。以Photoshop最常用的四大领域（抠图、修图、调色和特效合成）为蓝本，列举多个图像处理的实际案例，将前面篇章介绍的关键技能融会贯通，讲解和示范如何运用Photoshop处理图像的实战综合技能，同时向读者分享图像处理思路，以使读者的图像处理能力更上一层楼。 全书内容循序渐进，由浅入深，再深入浅出，案例丰富翔实，既适合刚接触Photoshop又想快速掌握Photoshop技能的小白学习，也适合已经掌握Photoshop基本技能但想要进一步提升Photoshop应用能力的进阶读者学习。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	196
640	商法小全书	978-7-301-32691-6	9787301326916	张双根 	\N	1	16开	45.00	641.0千字	北京大学出版社	484	7301	\N	2021-11-29	/book/7da4accd-254c-47f6-aed1-9c28a261409832691.jpg	本书稿为作者精心编排的商法类法律法规及重要文件的汇编，全书主要按照公司、企业两类商主体，破产、证券、信托、保险、票据、海商六大商行为版块的分类进行编排，各类重要文件均予以收录。各文件在目录中通过缩略语的形式予以体现，方便读者抓住重点词，快速查询到自己需要的文件。同时书后列出商法关键词汇，进一步方便读者理解商法，用好商法，特别是方便法考群体对商法考试内容的深入掌握。总之，该书希望在准确性、时效性、高效性上给予读者查阅帮助。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	217
641	综合素质（幼儿园）（第二版）	978-7-301-32698-5	9787301326985	傅建明 	\N	2	16开	45.00	393.0千字	北京大学出版社	236	7301	\N	2021-11-29	/book/0668eeaa-33bd-40d1-92d9-b088942c8a9a32698.jpg	本书是一本专门针对国家教师资格考试幼儿园综合素质的专用复习教材，切实围绕考纲，深入浅出地向考生讲解每个知识点，作者团队根据考试大纲精心设计了全书的框架结构，内容详实，在一些重点知识下面插入了相关历年真题和答案解析，更加方便了考生将理论知识与考试实践相结合。书中的知识要点、备考点睛、章后的知识结构图、本章小结、自测训练等栏目，都能很好地帮助读者进行学习和复习，是一本不错的综合素质备考用书。第二版根据近年考题进行了修订，并融入“习近平新时代中国特色社会主义思想”及最新的法律法规等。 本书既可作为在校师范生参加教师资格考试的指导课教材，也可作为其他有意参加教师资格考试的考生复习参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	557
642	高等代数简明教程(上)	978-7-301-05370-6	9787301053706	蓝以中 	\N	2	16开	45.00	374.0千字	北京大学出版社	416	7301	\N	2021-10-25	/book/7c2f7e94-f91c-4a36-8218-c95e02911b180537004.jpg	《高等代数简明教程》(上册)(第2版)共十二章，分上、下两册出版。上册(第一章至第五章)是线性代数的基础教材，内容包括向量空间、矩阵、行列式、线性空间与线性变换、双线性函数与二次型。《高等代数简明教程》(上册)(第2版)每个章节都安排了相当数量的习题作为课外练习或习题课上选用，其中的计算题在书末附有答案，较难的题则有提示。《高等代数简明教程》(上册)(第2版)可作为综合大学、高等师范院校数学系、力学系、应用数学系大学生高等代数课程的教材或教学参考书，对于青年教师、数学工作者《高等代数简明教程》(上册)(第2版)也是很好的教学参考书或学习用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	596
653	电力电子技术(第二版)	978-7-5646-4704-9	\N	贺虎成 	平装	1-1	16开	38.00	\N	中国矿业大学出版社	\N	\N	\N	2020-12-01	/book/f0a2d5c5-fff4-42d0-adc5-eaac825763161077200.jpg	电力电子技术的研究主要包括电力电子器件、电力电子电路和电力电子装置及其系统。本书内容主要包括：电力电子电路的分析基础、电力电子器件基本特性与使用方法、交流-直流变换技术、直流-交流变换技术、隔离与非隔离的直流-直流变换电路、交流-交流变换技术，软开关谐振变换技术、PWM控制技术和电力电子技术的计算机仿真等。 本书根据学科发展和专业需求对课程内容进行更新和调整，注重学科体系的完整性，加强了工程实践和仿真分析，可作为高等院校自动化专业、电气工程及其自动化专业和其他相关专业的本科教材，也可作为研究生、科研及工程技术人员的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	223
1799	青年马克思(第三版）（马克思主义研究译丛·典藏版）	978-7-300-30487-8	\N	[俄]H.И.拉宾 	0	1-1	0	98.00	300.0千字	中国人民大学出版社	\N	2014D0533	\N	2022-04-08	/book/0efbf27f-c23d-4dda-9235-0e5d07af50191086127.jpg	作为一部生动描述马克思青年时代学术思想的传记，本书第一版于1968年问世，当时正值马克思诞辰150周年。1976年，该书第二版出版后，被中国、德国、法国等多国翻译出版。该书在中国出版后，很快就引起国内学界高度重视，至今仍是马克思主义哲学教学与研究的主要参考文献之一。作者通过对《马克思恩格斯全集》历史考证版（MEGA2）的研究，对马克思青年时代两部重要的手稿，即1843年克罗茨纳赫笔记和1844年巴黎手稿，进行了深入的探讨，对于进一步研究马克思主义理论的来源和形成具有重要价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	976
759	李鸿章年谱长编	9787566609182	9787566609182	刘忆江 	\N	1-1	16开	128.00	\N	河北大学出版社	\N	\N	\N	2015-07-17	/book/be9107bb-b2b7-4e79-9703-75d6533634fa9787566609182.jpg	李鸿章在中国近代史上，尤其在晚清洋务运动与外交方面，是举足轻重的人物。一部晚清史，方方面面都留有他的印记。但至今为止，除香港、台湾于上世纪六七十年代曾出版过他的年谱，大陆无一部其人年谱。刘忆江著《李鸿章年谱长编》为大陆第一部李鸿章年谱。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	995
643	韩中翻译教程	978-7-301-32321-2	9787301323212	张敏,朴光海,金宣希 	\N	4	16开	85.00	500.0千字	北京大学出版社	364	7301	\N	2021-10-29	/book/89f11827-1de4-4d5b-9018-de845b5d937c32321.jpg	《韩中翻译教材》是教育部认定的“‘十二五’普通高等教育本科国 家 级规划教材”，获首届“中国大学出版社图书奖‘优秀教材’一等奖”。本教材自2005年正式出版以来，已被国内外的几十所大学韩国语系选为翻译必修课的教材使用。为了进一步提高韩国语翻译的教学水平，满足学习者的要求，编者根据各校师生提出的建议，在原教材基础上进行了调整和修订，使新修订版得以出版问世。 编者在修订教材时，特别注意保留原教材的特长，即翻译理论与实践的紧密结合，翻译技巧与课文练习的自然融会，翻译应用与外语教学的合理接洽。各课内容的设计、教案的编写、资料的选择、翻译知识的教授、翻译体裁的安排、翻译质量的评估等，均按照教学大纲的要求，方便教师授课，开展多样性教学活动。 教材中的课文、作业、练习题所选用文章的内容与形式规范化、经典化、多样化，涉及韩国社会生活、政治文化、经贸商业、新闻等方方面面。课容量大，信息量足，可以满足不同层次学生的学习要求。附录中有一般词典不易查找的最新词汇信息，如现代流行韩国语、网络语言等。通过本教材的讲解讨论、实践练习、总结归纳，可以使学生迅速掌握韩中翻译的一般规律与技巧，达到大学教学大纲中所要求的韩国语翻译水平。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	610
756	我的老师顾随先生	9787566611635	9787566611635	叶嘉莹 	\N	1-1	16开	45.00	\N	河北大学出版社	\N	\N	\N	2017-05-06	/book/b903fca6-7e23-4ab9-b9de-250b1fb13f909787566611635.jpg	本书是为纪念顾随先生一百二十周年诞辰的献礼书，是在叶嘉莹先生在“2016年词学国际学术研讨会”的演讲稿《七十五年师生情》的基础上进行扩充和调整，加入了先生之老师顾随的一些照片整理而成的。通过叶嘉莹和顾随先生交往的细节，让读者领悟到了一种感人的师生情谊；通过叶嘉莹先生对师生情的描写，突出了大师们对于中国古典文化事业薪火相传的重要意义和责任。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	402
644	爱上北京的100个理由	978-7-301-32358-8	9787301323588	衣彩天 等 	\N	1	16开	58.00	294.0千字	北京大学出版社	348	7301	\N	2021-10-29	/book/261c625b-778a-4c41-8548-b9b1b732cae232358.jpg	本书是以北京大学新闻与传播学院肖东发教授开设的《北京风物与传统文化》（该课2008年曾在北京大学全校通选课排名第一，2150人争选）的选课优秀生为作者，以及多年来学生采集到的信息资料为蓝本，是一部关于青少年传承北京历史文化的中型基本读物。北京有太厚太重的历史积淀，有四平八稳的建筑格局，有温和敦厚的人情风貌，有内涵丰厚的人文底蕴，有吸纳八方的气度胸怀；这既是北京又是中国，这城的文化就是中国人的精神。遗憾的是广大青少年包括大中学生并不能清楚地了解北京，认识中国传统文化；我们有必要以北京历史文化为题，开展深入研究，编出青少年喜闻乐见的读物。对于那些对北京感兴趣的普通读者来说，也能够得到丰富的知识和文化精神的熏陶。 简要目录： 一、京城记忆：那些事儿 二、皇家气派：帝都范儿 三、四季山河：燕八景儿 四、胡同情结：皇城根儿 五、玩家本性：好这口儿 六、文化魅力：忒拔份儿 七、艺术气息：图个乐儿 八、宗教圣地：神秘劲儿 九、饕餮美味：北京味儿	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	909
660	市场营销英语（第2版）	9787310060764	\N	高嘉勇 张琳琳 	0	1-1	16开	38.00	\N	南开大学出版社	\N	\N	\N	2021-02-23	/book/ced905af-12f5-4688-b9d9-67e1cee359a81077363.png	本教材主要介绍市场营销的发展及新趋势、市场营销的环境、市场营销的国际环境、市场调研方法、市场细分、目标市场及定位、消费者决策过程、产品及品牌、新产品开发、促销：广告及公共关系、促销：推销及促销行为、分销：分销渠道及供应链、零售及批发、定价策略。本教材通俗易懂，行文流畅，讲解详细。本教材对关键词语、关键句子进行了详细介绍，有利于提高学生的阅读、写作能力。 本教材有两个明显的特点：第一，内容全面、系统。本书以简洁的语言系统介绍了营销的理论，包括营销组合、营销环境、市场细分、目标市场、市场定位、消费者购买决	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	903
645	纳税评估教程（第三版）	978-7-301-32368-7	9787301323687	白彦锋，史大譞 	\N	3	16开	49.00	394.0千字	北京大学出版社	316	7301	\N	2021-10-29	/book/f3141f5d-75c1-416e-af27-344cb165ad2d32368.jpg	近年来我国不断深化税收征管改革，对税务机关服务市场主体能力的要求不断提升。纳税评估作为目前国际上通行的一种税收管理方式，在很多国家和地区都得到了广泛应用。面对“建立'无风险不打扰、有违法要追究、全过程强智控'的税务执法新体系，实现从经验式执法向科学精确执法转变”的要求，纳税评估势必要在未来的税收征管体系中发挥越来越重要的作用。 本书第三版在近年来税制改革成果的基础上进行了修订，使书中内容与最新的税制相吻合。此外，新版融入了近年来纳税评估理论和实践的发展，以帮助纳税评估工作者更好地适应日臻精确和完善的税收征管体系。本书可以作为财税专业本科生、研究生纳税评估课程的教材，也可作为税务部门、企业财务部门从业人员等纳税评估相关工作者的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	748
646	行政程序法学（上下册）	978-7-301-32395-3	9787301323953	关保英 	\N	1	16开	168.00	995.0千字	北京大学出版社	888	7301	\N	2021-10-20	/book/a05738cb-73f4-48b8-b3d2-b37877c82b3732395.jpg	本书是上海政法学院行政法重点学科带头人关保英教授主持、策划的一部在全国范围内适用的行政法学专著或教辅读物。该书强调理论与实践相结合、原理与实务相结合、阐述与评价相结合，紧紧围绕行政程序法学的基础理论与中国行政法治实践展开阐述和探讨。 该书共设置了七篇三十四章，区分为上、下两册。本书上册重点关注行政程序法原理、行政决策程序、行政立法程序、行政规范性文件制定程序四部分内容；下册重点关注行政执法程序、行政程序拟制和行政监督程序三部分内容。 本书既有理论的阐述，又有实践的论证。主要有以下目的：第一，为法律专业学生了解行政程序法提供最基础的教学辅导参考；第二，为各位读者研究行政程序提供指引；第三，为将来制定行政程序法做分析研究的准备，以期推动中国行政程序法学的发展。 截至目前，该书可能是国内相关行政程序法专著中内容最为全面和系统的一部，可用作高等院校行政法专业的学生的教学参考用书，也可以为国内各行政机关 进行培训提供帮助。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	594
765	全国中考试题分类精选	9787561097007	9787561097007	刘沛 	\N	19-1	16开	36.00	\N	辽宁大学出版社	\N	\N	\N	2019-09-01	/book/65b23771-9e06-4f24-9d0f-5ae9b5ab1e909787561097007.jpg	融汇全国各地中考试题，全面细致的解读，为考生迎战中考提供全面帮助。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	141
647	中国现代文学经典1915—2021（两卷本）（上）	978-7-301-32432-5	9787301324325	朱栋霖 	\N	1	16开	88.00	619.0千字	北京大学出版社	552	7301	\N	2021-10-25	/book/010ccbba-405b-4c0d-8c42-5069a3eb2eea32432.jpg	《中国现代文学经典1915—2021》（精编版）（两卷本）分上、下两册，是与朱栋霖主编的《中国现代文学史1917—2016》（上、下）、《中国现代文学史1915—2020》（精编版）（全一册）相配套的作品选。该书的读者对象为中国语言文学各专业方向、新闻传播学各专业方向、戏剧影视学专业等。 除了选入1915—2021年这一时段诗歌、散文、小说、戏剧等大量经典文学作品外，本书的重要亮点是，其中许多重要作品都附有二维码，内含关于作品的导读文字（包括“作家自述”“名家要评”“作品解读”等）及拓展阅读（包括论文、资料等），以供师生使用。 本书是在《中国现代文学经典1917—2010》（精编版）的基础上修订而成。旧版只有一册，此次新版，考虑到市场需求的变化、内容容量的提升，改为上下两册。本书为上册。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	105
648	影响人生的书单：来自百位北大教授的推荐	978-7-301-32462-2	9787301324622	任羽中,李喆主编，北京大学党委宣传部,北京大学招生办公室 	\N	1	16开	86.00	200.0千字	北京大学出版社	376	7301	\N	2021-10-21	/book/4ae2045e-916b-4c9a-bb9e-22820244326932462.jpg	大师身旁宜聆教，未名湖畔好读书。本书集结了百位北大教授的读书分享与治学感言，以期呈现北大人的思想精华、学术风采。难能可贵的是，136位北大教授细数优良著作，推荐影响其人生的书目，围绕“治学”“阅读”“人生”等话题，将治学感悟、读书经验和人生阅历凝练成句句箴言。本书内容涵盖两大主题：治学感言与推荐书目。北大教授们凭借深厚的学识学养旁征博引，依托丰富的教学经验妙语连珠，为读者带来一场足以纵情享用的阅读盛宴。出版后，北大招生部门将在招生季巡回演讲时向各学校推荐本书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	786
649	国际中国学研究	978-7-301-32465-3	9787301324653	严绍璗 	\N	1	16开	108.00	340.0千字	北京大学出版社	324	7301	\N	2021-10-28	/book/75fe8667-663f-440e-8ac5-0656e2d4944632465.jpg	严绍璗，北京大学比较文学与比较文化研究所教授、博士生导师。先后担任北大比较文学研究所所长、日本京都大学人文科学研究所、日本佛教大学文学部、日本文部省国际日本文化研究中心客座教授等。著有《日本的中国学家》《中日古代文学关系史稿》《中国文学在日本》、《日本中国学史稿》等14种专著。发表论文、译文170余篇。这部“严绍璗文集”全面收录了严绍璗先生治学50多年各方面的成就，本册为“国际中国学研究”，主要阐述对于“国际中国学“这一学术概念的论见，对日本中国学领域研究状况的考察，以及对日本在明治维新后，日本在意识形态上的转型，所引起的日本在中国学研究上发生的一系列变化的研究。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	987
757	河北民俗通览	9787566611482	9787566611482	陈旭霞 	\N	1-1	16开	212.00	\N	河北大学出版社	\N	\N	\N	2017-08-24	/book/44071c78-a9a8-401f-9503-5c7bbe95f9819787566611482.jpg	《燕赵文库》出版工程项目之一。原著者丁世良、赵放。本书在《中国地方志民俗资料汇编?华北卷》的基础上，整理历代志书记载介绍的河北省各地、各行业的民俗文化，深刻全面的反映了河北地区的风土人情，历史风貌，对于再现和保护非物质文化具有深远的意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	302
650	日本藏汉籍善本研究	978-7-301-32487-5	9787301324875	严绍璗 	\N	1	16开	138.00	470.0千字	北京大学出版社	444	7301	\N	2021-10-28	/book/f24d404c-54d8-42f7-a1e9-c24e77ed3e4632487.jpg	严绍璗，北京大学比较文学与比较文化研究所教授、博士生导师。先后担任北大比较文学研究所所长、日本京都大学人文科学研究所、日本佛教大学文学部、日本文部省国际日本文化研究中心客座教授等。著有《日本的中国学家》《中日古代文学关系史稿》《中国文学在日本》、《日本中国学史稿》等14种专著。发表论文、译文170余篇。本书收录严绍璗教授二十余年间出入日本三十余次，在日本数所大学担任客座教授期间，在各界朋友的帮助下，从北海道到冲绳群岛，从太平洋之畔到日本海沿岸，走访了日本近百所汉籍收藏机构的访书心路历程。全面调查了日本现今所藏的汉籍善本，其中许多已被日本定为“日本国宝”，许多善本在国内早已无存，是了解我国汉籍在日本流布的重要记录。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	281
1855	特大城市流动人口变动特征及社会经济影响	9787563833207	\N	齐明珠 曾雪婷 盛亦男 张航空 著 	0	1-1	16开	59.00	394.0千字	首都经济贸易大学出版社	280	\N	\N	2022-03-01	/book/92887356-e0e2-430c-97b3-de1d4fabec101086578.jpg	这部专著结合课题组“十三五”期间做的大规模流动人口追踪调研结果，对我国特大城市人口治理现状和问题进行深入剖析，对流动人口特征及其变动趋势进行深入研究及对比。本书从内容上分为三大部分，第一部分探究特大城市人口发展客观规律，寻找适合中国国情的特大城市人口治理路径。第二部分分析特大城市流动人口和家庭特征、就业、收入与支出、居住特征与居留意愿等。第三部分全面阐述特大城市流动人口特征及其变动的社会经济影响。本书是人口经济领域的重要参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	241
651	古希腊哲人论神	978-7-301-32493-6	9787301324936	大卫·赛德利 	\N	1	16开	65.00	188.0千字	北京大学出版社	320	7301	\N	2021-10-29	/book/83933579-4c01-43cd-ba4b-7ddca16fc3ea32493.jpg	本书由国际著名古典哲学家大卫·赛德利教授在“中国人民大学古希腊哲学名师讲座”的基础上修订而成。作者按照专题而非历史梳理的方式，考察了“神”的问题在古代哲学中的不同表现形式，包括了善恶二元论、球形神、与神相似的人、无神论、不可知论、伊壁鸠鲁主义神学和神的匿名性。作者表明，在古代哲人的眼中，神的存在形式多种多样，既可能是宇宙本身，也可能被设想为有生命的东西，可能是给我们提供模仿对象的理想范型，也可能是政治家创造出来的“超人警察”，同时也有人否认神的存在或者否认人可以认识神。本书集中展现了赛德利教授治学的宏大视野和细致入微，是了解古代哲学中的“神学”维度不可多得的佳作。特别值得一提的是本书的英文版尚未出版，这使得中文版更显珍贵。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	115
652	北大法宝文粹：法学研究与应用（8）	978-7-301-32501-8	9787301325018	北大法律信息网 	\N	1	16开	78.00	537.0千字	北京大学出版社	456	7301	\N	2021-11-08	/book/5264e4cf-6129-4649-b57a-f31443d8975732501.jpg	新的时代背景下，人工智能、大数据、云计算等新兴技术如洪流般涌向法律领域；立法、执行及司法等领域出现新局面、新形势；先进科技的应用，在注入新鲜血液、提升发展动力的同时，也造成了猛烈地冲击。我们正处于时刻受大数据影响的时代，既要正确理解和科学运用法律大数据，同时还要敏锐地发现其中存在的问题，推动法律大数据研究工作的有序展开。 本选题包括“大数据分析”“互联网+法律”“民法典”“焦点法谈”“法律实务探讨”五个部分，其中“大数据分析”栏目有7篇报告，分别涉及最高人民法院指导性案例、最高人民法院公报案例、最高人民法院公司纠纷案例和房地产纠纷案例的大数据分析报告、法学核心期刊学术热点分析报告、行贿罪量刑规范化数据分析以及大数据时代的个人信息保护等内容，希望能为读者带来更多的思考和启示。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	911
766	马克思恩格斯列宁经典著作导读	9787561076682	9787561076682	戴艳军 	\N	1-1	16开	46.00	\N	辽宁大学出版社	\N	\N	\N	2014-05-01	/book/160f953c-dfac-4a3d-bb72-a3e5842a81c19787561076682.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	404
654	矿山开采沉陷学	978-7-5646-1174-3	\N	郭广礼 	平装	1-1	16开	59.00	\N	中国矿业大学出版社	\N	\N	\N	2020-10-01	/book/ba535b26-2b03-4196-ad79-8d02ef15ac771077206.jpg	本书共十一章，主要内容包括：第一章 绪论；第二章 矿山开采沉陷观测技术；第三章 地表移动的一般规律；第四章 地表移动与变形计算方法；第五章 矿山开采沉陷数值和物理模拟；第六章 建（构）筑物保护煤柱的留设；第七章 建筑物下采煤理论与技术措施；第八章 充填与条带开采沉陷控制的理论与技术；第九章 铁路及其它线形构筑物下采煤理论与技术；第十章 水体压煤安全开采原理与技术；第十一章 井筒保护煤柱开采与变形预计。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	864
655	20世纪美国文学史（修订版）	978-7-5446-6019-8	\N	杨仁敬 	平装	1-1	大32开	138.00	\N	上海外语教育出版社	\N	\N	\N	2021-12-01	/book/c539b17e-40fa-4427-8a24-6d611380d3f91077266.jpg	《20世纪美国文学史》原为“中华社科基金‘八五’规划重点项目”，2015年入选“中文学术图书引文索引”数据库，是国内美国文学史研究领域的重要学术著作之一。本书论述从1890年到1995年100多年间美国文学的发展、变化。此次新版全面补充了美国文学名著的英文名，增补了重要作家的生卒时间，方便读者了解时代语境和文学创作的关系。本书可以作为高校师生和社会读者学习和研究美国文学的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	706
656	能源矿产概论	978-7-5646-4558-8	\N	万志军 	平装	1-1	16开	25.00	\N	中国矿业大学出版社	\N	\N	\N	2020-01-01	/book/cdff5d5d-305b-4071-84c6-5f5c19ea5a9b1077288.jpg	本书主要介绍了各类能源矿产资源，重在面向社会大众介绍各类能源矿产资源的基本知识、开发利用及其发展前景，以提高大众科学素养，培养大众节能环保的意识。全书层次清晰、内容丰富、图文并茂，普适性和实用性强。本书可供与矿产资源开采与利用的相关专业学生和工程技术人员参考使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	798
657	旅游地质概论	9787310060061	\N	杨世瑜，李波 	0	1-1	16开	55.00	\N	南开大学出版社	\N	\N	\N	2021-07-09	/book/cf93dff0-0c8a-4120-a4d7-ce0d5dfc8f5e1077312.png	本书融合旅游科学与地质科学、社会科学与自然科学的研究方法，从旅游的视觉研究地质资源旅游资源化，阐述旅游地质的理念与方法；系统地叙述旅游地质学概述、旅游地质基础理念概略、地质资源旅游功能与旅游价值、旅游地质资源、地球演化遗迹类旅游地质资源、第四纪地质遗迹类旅游地质资源、经济地质与人文地质类旅游地质资源、人文－地质复合类旅游地质资源、地质资源旅游资源化、中国旅游地质景观域。本书定位为教材，内容专业性比较强。因作者年岁较大，文字功底不是非常好，原稿的文字问题较多，层次结构设计缺陷也比较明显，知识点组合方式较为松散	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	772
659	东海西海：英语名诗名译赏鉴	9787310060573	\N	欧光安 等 	0	1-1	16开	56.00	\N	南开大学出版社	\N	\N	\N	2021-03-17	/book/fa440e08-abfc-4c80-8bb6-aa4721c301011077357.png	该著作选取英语文学中的十四篇著名诗歌，以及一篇代表性的汉译，作为分析的切入点。以文本细读为中心，结合相关的翻译理论，从具体选篇分析扩展至该翻译家的代表性译作，以点带面，深入阐释该翻译家的风格和思想。同时，或比较其他译文，或结合该翻译家的文学创作，从宏观角度考察其跨文化交流的所做的努力和创作特征。在阐释和赏鉴的同时，笔者结合自身教学科研实践，提出对文学翻译、跨文化交际等领域发展的看法和观点，做到评议结合。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	755
661	国外基层社会治理	9787310060641	\N	王杰秀 	0	1-1	16开	128.00	\N	南开大学出版社	\N	\N	\N	2021-02-23	/book/b8464bbf-0bb1-43e4-a9eb-7364f3dcdb531077368.png	本书将与中国社会科学出版社联合出版。作者以美国、英国、德国、法国、日本、新加坡等国的治理体制为例，以各国的典型案例为着眼点，分析了国外社区之间的联合与协调机制、“皮毛法”对社区纠纷的有效处置、强制性社区规约与软法治理、针对公益慈善的综合监管体系、社区教育的多维功能、“健康守门人”与管理化保健等多个议题，紧密结合当下中国基层社区治理的现状，从乡村过疏化治理、社区治理平台、社区联合与协调机制、志愿服务与社会工作、社区教育、医疗和养老服务等一系列热点、难点问题出发，剖析了国外一些国家政府与社会的关系，以及政府、社	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	318
662	国际私法案例	9787310060771	\N	秦瑞亭 耿小宁 	0	1-1	16开	65.00	\N	南开大学出版社	\N	\N	\N	2021-03-03	/book/3e30fd52-ab16-44b8-a020-760e75bf61851077369.png	国际私法在世界各国民法和商法互相歧异的情况下，对含有涉外因素的民法和商法关系，解决应当适用哪国法律的法律。全书分为22章，内容涵盖涉外民商事管辖权、识 别、合同冲突法、侵权冲突法、物权冲突法、合同准据法和物权准据法的区分、继承冲突法等内容。除了少量国外经典性案例外，本书分析的案例大多取材于当前中国涉外民商事审判和仲裁实务中的典型案例，并紧扣国际私法教材，旨在提升阅读者对国际私法的认知水平和实务操作能力。每个案例分析，主要包括案情简介、案例评析、拓展思考几部分。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	747
663	读点儿《楚辞》	9787310059058	\N	（美）宋德利 	0	1-1	16开	48.00	\N	南开大学出版社	\N	\N	\N	2021-03-17	/book/59a4f3f8-acdd-483c-9bb3-631e97fa66071077377.png	本书为古典文化普及读物，为汉英对照版，面向中高等文化水平的中外读者。本书作者以深厚的中国传统文化修养和几十年的双语翻译经验为基础，对经典诗集做了精心的以诗译诗的呈现，并在语言表达和结构形式等多方面有所创新。本书选取了楚辞中的《离骚》《九歌》《九章》《远游》《卜居》《渔父》《九辩》《招魂》《大招》《天问》等十篇，并译成英文。全书文字准确、流畅；同时，聘请专家对全书的中英文进行审订，使本书既通俗，又不失文采。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	220
664	历史城镇管理	9787310060429	\N	[荷] 吴瑞梵，[日]原口幸子 主编；张柔然，贺鼎，谢洁怡，译 	0	1-1	16开	35.00	\N	南开大学出版社	\N	\N	\N	2021-03-17	/book/1fd13c3e-f7f8-4137-8b41-cb91f9878cf31077379.png	世界遗产城市项目是世界遗产委员会正式通过的六个专题项目之一。它于2001年世界遗产委员会第二十五届会议之后成立，是秘书处新出炉的多年计划编制方法的一部分。它旨在提供一个框架，一方面协助缔约国寻求符合与世界遗产委员会战略目标一致的一系列需求固定的技术和财政支持；另一方面也促进国际捐助者提供上述支持。本书收录了一系列历史性城镇景观倡议地区专家会议上发表的的论文，包含了前瞻性的想法，部分提出了纳入城市保护实践的创新战略，还有一些提出了具体的工具处理历史性城镇景观管理中出现的特殊问题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	789
767	档案逻辑管理学	9787561067673	9787561067673	林华 苏晓轩 倪丽娟 	\N	1-1	16开	35.00	\N	辽宁大学出版社	\N	\N	\N	2012-06-01	/book/1b8cc076-11b1-4b44-8f42-6f15fb8f259c9787561067673.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	531
665	种植业保险	9787310061204	\N	丁少群 王 信 等 	0	1-1	16开	65.00	\N	南开大学出版社	\N	\N	\N	2021-08-11	/book/2f20d7a5-33e8-4919-b40a-1cf759c6f1461077386.png	开展种植业保险业务以来，农业保险产品设计与开发一直是提供农业风险保障的核心。本书旨在将当前种植业保险中各类具体保险业务的类别、责任、补偿方式进行具体陈述，结合实践案例分析，总结出种植业保险的经验，为种植业保险经营提供借鉴和参考。本书主要对于粮食作物保险、小麦保险、水稻保险、玉米保险、大豆保险、经济作物保险、园艺作物保险、果树保险、森林保险的特点、保险责任与除外责任确定、保额确定与损失补偿方式以及防灾防损工作进行了详细的论述，对于农业保险实践有很大的指导作用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	355
666	悲剧性美学	9787310061334	\N	万晓高 	0	1-1	16开	150.00	\N	南开大学出版社	\N	\N	\N	2021-10-27	/book/b133bc18-b632-429f-9ab6-a7a82f9706ca1077390.png	本书是一部研究探讨文学中的悲剧性美学的专著，全书共分6章，主要内容包括：从“悲剧”到“悲剧性”（悲剧的多义性、悲剧的“衰亡”、生活—文学中的“悲剧性”如何跃入理论研究视野、前人关于“悲剧性”的探索、研究“悲剧性”的意义、思路与方法、“悲剧性”范畴的性质与内涵、悲剧性的生成及其机制、悲剧性的特征、悲剧性的文学显现（不同民族作品、不同体裁、不同艺术要素中的悲剧性流变）、文学中悲剧性的功能（文学批评视角及社会文化功能）考察等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	591
683	乡里的圣人：颜元与明清思想转型	978-7-305-24707-1	\N	王东杰 	0	1-1	小32开	68.00	176.0千字	南京大学出版社	320	\N	32	2021-10-01	/book/e43c400e-5f74-4823-8732-e544e5fbcb7f1077962.png	颜元被认为是中国近世思想史研究中的一个关键人物。学界之前对他的研究有两个问题：一是对其思想进行“现代化”误读，二是在深度上开掘有限。本书另辟蹊径，从思想史、生活史相交融的角度，讨论了一个“乡里的圣人”所具有的思想史价值。 相对于传统思想史以“新观点”的提出作为衡量尺度的做法，本书试图提出一种将“平庸的思想者”纳入思想史研究中的思路。此外，本书亦具有鲜明的方法论意识，广泛采用了“心理史学”“具身认知”等理论，并借鉴了民间文学研究的做法，以期开掘思想史研究的新空间。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	889
667	大学英语翻译与写作教程	978-7-5213-1739-8	9787521317398	王允曦，关键，王鹤 	0	\N	16开	39.90	\N	外语教学与研究出版社	184	\N	\N	2020-08-01	/book/31841aec-498b-48ed-843a-78c319fa170f1077397.png	《大学英语翻译与写 作教程(1)》是“大学英语 翻译与写作教程”中的第 一册。“大学英语翻译与 写作教程”顺应当前《大学 英语教学指南》为依据， 以培养学生英语实际运用 能力为目标，结合大学英 语教学实际而编写的一套 较为系统、科学和实用的 教材。该套教材共四册， 适合大学本科一年级和二 年级的公共英语必修课使 用。每册均包含八个单元 ，每单元均包含语法、阅 读、翻译、写作四个部分 内容。全书在传授基础知 识、翻译技巧和写作模式 的同时，力求做到在大纲 规定的范围内培养学生用 英文准确表达思想的技能 ， 终达到规范英语翻译 、写作，流畅交际的目的 。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	251
855	国家大学生学情发展研究/厦门大学南强丛书第7辑【厦门大学百年校庆】	9787561578148	9787561578148	史秋衡 	\N	1-1	16开	72.00	\N	厦门大学出版社	\N	\N	\N	2021-01-01	/book/a11378b0-c8c2-4cdd-8739-9ef51eda43839787561578148.jpg	本书围绕大学生学情的整体情况、分类特征、规律规则开展深入的分析和全面的研究，按照立论价值、要素结构、客观规律、理论模型、要义探究的逻辑过程予以展开与深究，最后立足于人才培养之于高等教育的重要性 。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	341
668	大学英语思政导学教程	978-7-5213-2000-8	9787521320008	吴鹏等 	0	\N	16开	36.90	\N	外语教学与研究出版社	168	\N	\N	2020-08-01	/book/bc6736d3-bc60-4835-8a0c-889269a22ea41077400.png	“导学”作为大学英语课程先导环节，对学生树立正确的价值导向、培养良好的学习习惯、制订科学的发展规划起到重要作用。 《大学英语思政导学教程》是针对全国本科院校与高职院校学生编写的英语导学读本。本教程从立德树人根本任务出发，阐述大学英语课程的时代使命，挖掘大学英语课程的育人内涵，使学生在明确学习目标的同时，养成端正的学习态度，掌握有效的学习方法，善用丰富的学习资源，取得扎实的学习成效。本教程进一步明确了大学英语课程不仅应传授学生英语语言知识和技能，也应帮助学生拓展国际视野，树立世界眼光，增强沟通能力和思辨能力，并引导学生厚植爱国情怀，坚定理想信念，健全人生观和价值观，加强品德修养。 《大学英语思政导学教程》包括为什么学大学英语、大学英语学什么、如何学好大学英语、大学英语的竞技场四个部分，从学习意义、学习要求、学习策略、学习资源、社会实践等多角度对大学阶段的英语学习进行全面阐述。每部分均设置“常见误区”“释疑解惑”和思考题，为学生厘清英语学习中的一些错误认识，引导其深入反思，巩固知识，精进英语能力，提升综合素养。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	729
669	大学英语思政导学教程	978-7-5213-2000-8(01)	978752132000801	吴鹏等 	0	\N	16开	42.90	\N	外语教学与研究出版社	176	\N	\N	2020-08-01	/book/c7daf004-d126-4c79-b09e-d3f08e87ddb51077401.png	“导学”作为大学英语课程先导环节，对学生树立正确的价值导向、培养良好的学习习惯、制订科学的发展规划起到重要作用。 《大学英语思政导学教程》是针对全国本科院校与高职院校学生编写的英语导学读本。本教程从立德树人根本任务出发，阐述大学英语课程的时代使命，挖掘大学英语课程的育人内涵，使学生在明确学习目标的同时，养成端正的学习态度，掌握有效的学习方法，善用丰富的学习资源，取得扎实的学习成效。本教程进一步明确了大学英语课程不仅应传授学生英语语言知识和技能，也应帮助学生拓展国际视野，树立世界眼光，增强沟通能力和思辨能力，并引导学生厚植爱国情怀，坚定理想信念，健全人生观和价值观，加强品德修养。 《大学英语思政导学教程》包括为什么学大学英语、大学英语学什么、如何学好大学英语、大学英语的竞技场四个部分，从学习意义、学习要求、学习策略、学习资源、社会实践等多角度对大学阶段的英语学习进行全面阐述。每部分均设置“常见误区”“释疑解惑”和思考题，为学生厘清英语学习中的一些错误认识，引导其深入反思，巩固知识，精进英语能力，提升综合素养。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	853
768	公文管理教程	9787561072219	9787561072219	周耀林 叶鹏 黄川川 	\N	1-1	16开	36.00	\N	辽宁大学出版社	\N	\N	\N	2013-04-01	/book/a9885210-041c-40da-8637-c5886f4f40cc9787561072219.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	610
670	翻译测试与评估研究	978-7-5213-0764-1	9787521307641	杨志红 	0	\N	16开	59.90	\N	外语教学与研究出版社	240	\N	\N	2020-01-01	/book/82d2b756-c89f-4a0c-8846-0e0298ab3d921077404.png	　　《翻译测试与评估研究》一书致力于对国内外翻译测评领域的研究成果进行梳理和评述，并在此基础上探讨翻译测试中的实际问题，提出选题建议，为翻译教师和研究者提供参考。 全书共分为六章。第一、二章介绍翻译测试的理论和国内外的翻译测试实践，对翻译测试研究进行系统的回顾与总结，并指出目前面临的挑战；第三至六章分别详细阐释翻译测试中的构念确定、题型与难度设计、测试信度及效度检验和译文质量评估等各个环节。此外，在每章的最后作者都给出了进行此方面研究的选题建议。 本书注重理论与应用兼顾，兼具学术性、前沿性和引领性，适合翻译测评研究领域的硕博士研究生、翻译教师及研究者参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	716
671	高级职场英语写作教程	978-7-5213-1847-0	9787521318470	（美）袁义（Yuan Yi），（马来西亚）黄良日（Wong Lian-Aik），杨瑞英 	0	\N	16开	59.90	\N	外语教学与研究出版社	336	\N	\N	2020-08-01	/book/a2e4ab70-9cb7-4a90-9a36-1065d08f5f991077408.png	　　《高级职场英语写作教程》主要面向国内外高等院校高年级本科生、研究生、商务英语及其他相关专业的学生，可作为职场或商务英语写作课程的教材使用，也可供已进入职场或即将进入职场的人士作为职场英语写作的参考书使用，旨在提高使用者职场英语应用文的写作能力。本书共包含十个单元，前四个单元主要绍职场英语写作的基本特征、原则、写作过程、以读者为中心的职场写作理念、以及图表图像等视觉手段在职场文档中的使用和作用。后六个单元逐一讨论简历、商业信函、摘要和执行摘要、使用说明、非正式报告（包括进度报告、实验报告、事故报告、及会议议程和会议记录）、以及项目提案等六类职场文档体裁的写作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	305
672	英语写作规范	978-7-5135-0785-1(01)	978751350785101	石坚 等 	0	\N	16开	36.90	\N	外语教学与研究出版社	219	\N	\N	2011-05-01	/book/cfc3818e-4389-4707-a3f2-4baf0b3450241077480.png	　《英语写作规范》大学英语教材，英语写作规范工具书，对英语行文中涉及的标点方法、英文学术论文参考文献标注等做了详细阐述。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	940
673	应用英语教程综合英语1	978-7-5213-2459-4	9787521324594	薛家宝 	0	\N	16开	59.90	\N	外语教学与研究出版社	224	\N	\N	2021-03-01	/book/f1a986a1-35d7-4ff4-a703-31ad4e95ba221077487.png	《应用英语教程综合英语1》为高等学校英语专业基础教材，适用于综合英语课程。本教材融听说读写为一体，每个单元含有两篇主题相近、角度不同的选篇。其中，TextA作为精读课文，配有课前拓展学习任务，课文后面配有课文注释、词汇表、重难点讲解和练习。练习层层深入，在充分理解选篇和外延的基础上，配有大量的词汇、语法和翻译方面的练习，以夯实学生的语言基本功。此外，还有专门的口语和写作板块，用以加强学生的口头和笔头表达能力。TextB作为泛读选篇，目的在于提高学生的自主学习能力和思辨能力，通过设置适合自主学题目，加强学生的自我学习能力。此外，还配有课文主题欣赏和写作分析的板块，以提高学生的文本分析能力和写作水平。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	730
674	语料库翻译学理论研究	978-7-5213-2277-4	9787521322774	黄立波 	0	\N	16开	51.90	\N	外语教学与研究出版社	213	\N	\N	2020-07-29	/book/30c085f5-dbc6-408f-ac4c-ee5b73f582281077488.png	《语料库翻译学理论研究》一书回顾了国内外语料库翻译学二十多年来的理论发展，并对此领域从研究对象到研究方法、从研究视角到研究课题都提出了诸多思考。 全书共分为六章。第一章从研究理念、方法、对象等方面梳理语料库翻译学的缘起。第二章介绍语料库翻译学的学术话语体系，包括语料库类型、基本术语以及参数类考察工具等。第三章简要介绍语料库翻译学方法论的发展历程。第四章回顾语料库翻译学的基本研究课题。第五章探讨语料库翻译学现有研究的不同视角。末章是对语料库翻译学理论的简要评价，既讨论语料库翻译学的学科贡献，也从认识角度说明其局限性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	617
676	体育舞蹈	978-7-305-24347-9	\N	果梅 	0	1-1	16开	36.80	230.0千字	南京大学出版社	164	\N	60	2021-03-15	/book/e5adde5a-3788-4eb5-8d27-5dd0ef60bc841077877.png	体育舞蹈，是体育与艺术高度结合的体育项目，集体育、舞蹈、艺术、娱乐于一体，具有健身、强心、娱乐、交往及竞赛等特点。本书主要内容包括体育舞蹈的起源及发展，体育舞蹈的基本理论知识、竞赛规则、竞赛方法，学习华尔滋、探戈、恰恰、四步舞蹈技能，更侧重培养气质风度和社交礼仪，培养科学健身法、树立终身体育意识，通过学习掌握一定的体育舞蹈的表演技能，具备欣赏体育舞蹈的能力，并能在深入了解如何运用体育舞蹈进行健身的基础上形成终生锻炼的习惯，提高审美能力及合作意识。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	785
677	语言学史教程	978-7-305-24351-6	\N	周远富 	0	1-1	小16开	40.00	270.0千字	南京大学出版社	244	\N	50	2021-06-30	/book/b8f5054a-3f91-4630-ba5c-235ee911343e1077910.png	本教材条分缕析，以简驭繁，将海量的语言学知识按语言学分支加以梳理，纲举目张，便于教学。使学生了解中外语言学的发展过程、学术流派、学术思想、语言理论，反映了中外语言学各个时期的研究成果，培养学生运用语言学理论知识和分析一些语言现象的能力，从而提高学生的语言学理论水平和理论高度，提升学生的语言文化意识和批判性思维能力。深入浅出，利于课上教学和课下自学，适合高校语言专业本科学生以及语言学相关专业研究人员使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	555
678	教师专业发展	978-7-305-24784-2	\N	陆道坤 	0	2-1	16开	45.00	350.0千字	南京大学出版社	256	\N	40	2021-07-20	/book/a910a57f-7182-4384-86f4-0efde49a392e1077917.png	本书被评为江苏省重点教材，主要包括教师专业情感、教师专业理念、教师职业道德、教师专业知识、教师专业能力、教师专业实践与反思、教师职业生涯规划、教师专业发展路径、教师专业发展评价等内容，改版时在内容与形式上均做较大改动，以最新的教师职业能力标准为导向，融入课程思政元素和教师资格考试内容，综合近年来国内外教师专业理论研究的最新成果和教师专业发展实践探索的优秀经验，提供配套的数字资源，以贴合一线教师培养需要。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	696
769	社会主义核心价值观教程	9787561095751	9787561095751	刘玉红 王莉 王凤环 	\N	1-1	16开	36.00	\N	辽宁大学出版社	\N	\N	\N	2019-02-01	/book/899e64a0-ba22-4dca-afca-e59592dcdccf9787561095751.jpg	本书论述了社会主义核心价值观的科学内涵，分析了社会主义核心价值观的理论依据和思想渊源，对现代国家的价值标准、现代社会的价值导向、现代公民的价值准则都进行了深入阐述，对培育和践行社会主义核心价值观的重大意义予以全面论述。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	654
679	中国湖泊历史图谱	978-7-305-23964-9	\N	薛滨，姚书春 	0	1-1	16开	68.00	234.0千字	南京大学出版社	260	\N	36	2020-12-23	/book/d743d913-6756-4ad5-b743-5279914013421077924.png	本书运用我国丰富的历史地图，再现了约三百年来我国湖泊的变化，架起了千年和现代之间的桥梁，丰富并形象地展现了百年尺度的湖泊环境变化。汇编了我国历史时期重要湖泽的图件、水利、测绘、文献资料，结合中国湖泊演变研究的最新成果，以时间为主线，将我国历史上重要湖泊的演变横向以图的形式在有时间刻度的横坐标上铺展开来，由湖泊演变指示的我国环境变化如时间隧道展现在眼前；纵向以重要环境、历史事件为单位对湖泊的变化加以描述，以翔实的图文史料为我国环境演变及相关研究提供科学参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	177
680	Android移动开发技术	978-7-305-24506-0	\N	杨剑勇,钱振江 	0	1-1	16开	39.80	200.0千字	南京大学出版社	\N	\N	50	2021-09-01	/book/d3fb7a82-15f9-41c8-9ea8-f36b420572ea1077925.png	本书系统全面地介绍了有关Android程序开发所涉及的各类知识，全书内容按照技术体系和内容难度，分为14个章节，第1和2章是Android的概念和开发环境。第3~6章介绍了Android开发的基础知识，包含界面布局、资源文件、控件和适配器等。第7~12章介绍了Android的高级开发技术，包括权限控制、线程和服务、数据存储、网络编程、多媒体和地图定位服务等。第13和14章是两个综合案例，分别为基于本机数据的app和使用网络数据的app。本书适合有一定Java基础，希望掌握Android程序设计的读者。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	733
681	幼儿园语言教育活动100例	978-7-305-24979-2	\N	徐剑媚 	0	1-1	16开	38.00	168.0千字	南京大学出版社	224	\N	50	2021-09-01	/book/50ebe60d-d0ed-4083-832d-23cb45248dd51077933.png	本书从幼儿一日生活出发，阐述幼儿园语言教育活动的理论和不同年龄阶段幼儿的语言发展目标，围绕幼儿园语言教育中的谈话活动、讲述活动、听说游戏、文学作品和早期阅读活动五种类型，分别进行了小、中、大班不同年龄段幼儿的100个语言教育活动案例的设计与组织。案例中包含活动方案、活动延伸（包含家庭指导）、活动资源（包含音视频资料、多媒体课件、活动实录等）三个部分，融入现代化教育技术手段，实现可视、可感、可操作，体现科学性、系统性和生活化、游戏化，便于民族地区幼儿园教师学习、理解和实际运用。填补了民族地区幼儿普通话推广、语言教育用书的空白，同时对非民族地区幼儿园教师也有很强的实操性和指导意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	946
682	泽塔奥特曼·拼音认读故事第一辑	978-7-305-24874-0	\N	圆谷制作株式会社 	0	1-1	20开	90.00	300.0千字	南京大学出版社	300	\N	24	2021-09-06	/book/849f5e4e-b22c-4ac1-963c-250f10acc6f51077957.png	本书是泽塔奥特曼的第一辑，包含第1、2、3、4、5册5本故事。贝利亚的残躯——恶魔碎片四散在宇宙之中。碎片有着让怪兽变得凶残的恐怖力量，使得整个宇宙陷入了混乱之中。奥特战士们为了守护和平，开始回收散落在四方的恶魔碎片。一只寄生生物赛雷布洛袭击了光之国，并抢走了由希卡利奥特曼开发的道具泽塔升华器以及奥特勋章。泽塔追着盖内伽古来到了地球。作为本作舞台的地球是一个怪兽如同日常的灾害一样出现的地方，为了对抗怪兽，人类组成了地球防卫军。本作的主人公夏川遥辉是隶属于防卫军·日本支部的机甲部队“军械库”的一员，他和泽塔为了阻止赛雷布洛的文明自灭游戏挺身而出。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	403
684	“学衡派”与近代中国大学教育	978-7-305-24513-8	\N	朱鲜峰 	0	1-1	小16开	78.00	274.0千字	南京大学出版社	296	\N	30	2021-09-29	/book/20ad527c-c534-42f6-8367-a80bfd62daa61077964.png	在近代中国大学教育史上，以梅光迪、吴宓、胡先骕等为代表的“学衡派”力主“昌明国粹，融化新知”。本书以“学衡派”的人文教育思想和实践为研究中心，对这一学派在近代中国大学教育史上的地位与贡献作了较为细致的探讨。本书充分利用哈佛大学、浙江大学、中正大学等高校的档案等史料，梳理了“学衡派”成员求学与执教的经历；充分借鉴文史哲学界已有的研究成果，将“学衡派”置于近代中国大学教育史的政治、文化语境中进行考察。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	805
685	非洲研究五十年	978-7-305-24909-9	\N	姜忠尽 	0	1-1	小16开	148.00	547.0千字	南京大学出版社	460	\N	20	2021-09-15	/book/eca83158-9944-402a-a275-35a6684488ac1077979.png	本书是作者长期从事非洲地理研究，并多次赴黑非洲9国访问研究和学术交流的基础上，将亲身经历和耳闻目睹的黑人儿女创造的人文事象写成的一部地理散记。内容涉及所到国家的自然环境、资源开发、史实古迹、黑人传统社会文化与艺术、风土人情、城市风光与原始的乡村。从不同侧面展示黑人儿女的生活情趣和精神风貌，读者可从中领略黑非洲大自然的风采和魅力，品味黑人儿女的情怀。记述内容丰富而多彩，具体而形象，兼有学术性与趣味性，雅俗共赏，老少皆宜。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	437
686	中国的，莎士比亚的——莎士比亚戏剧在当代中国的跨文化改编	978-7-305-23911-3	\N	张瑛 	0	1-1	大32开	50.00	200.0千字	南京大学出版社	248	\N	60	2021-09-27	/book/0649f976-e574-4f0e-93f4-0a57ebd48f1a1077987.png	本书以上世纪80年代以来中国戏曲舞台与银幕上的莎剧改编与演出为研究对象，选择了十余出改编个案，涵盖了京剧、昆曲、越剧、豫剧等中国人民耳熟能详的主要剧种以及一部电影改编，在探讨相对传统的戏曲改编的同时，也加入了对实验性独角戏以及双语戏剧改编的探讨，从学理的角度客观地分析在改編过程中所采取的策略与方法，所发生的改写与变异，所产生的新的内涵与意义，反映出莎士比亚戏剧在当代中国跨文化改编与演出所具备的世界胸怀及强烈的本土意识。本书研究莎士比亚戏剧的戏曲改编，有助于了解东西方戏剧的新动向以及发展趋势，深化我们对莎剧文学经典、戏曲艺术范式以及跨文化戏剧这一文化现象的理解与认识。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	971
687	长不大的向日葵	978-7-305-24568-8	\N	王一梅 	0	1-1	24开	28.00	120.0千字	南京大学出版社	120	\N	100	2021-10-31	/book/fba0b15c-30cc-4685-a6e7-d38d2a2533321078005.png	本书是作家王一梅的精品短篇童话集，语言温馨有趣，思想开放宽广，富有诗意，文字优美。故事里透着浓浓的温情和关爱，充满幽默感、蕴藏哲理，还有独到的美感，能给人独特的阅读体验。书中作品有着超凡的想象力，独特的叙述风格，文字优美，具有温暖的人道精神、温馨的人性氛围，为孩子们展现了一个不一样的童话世界，给小读者带来爱的感悟及奇趣的阅读体验。王一梅的童话充满诗意，为读者营造了一个个温馨浪漫又略带忧伤的童话世界，使读者能够在阅读中捕捉到生活中的动人瞬间，进而去发掘生命中的真善美。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	259
688	孙中山与杨杏佛	978-7-305-25033-0	\N	任维波,陈宁骏 	0	1-1	小16开	35.00	143.0千字	南京大学出版社	160	\N	60	2021-10-14	/book/0700889b-63a8-4ded-aa96-bf301028e2561078014.png	1912年1月1日，年仅19岁的杨杏佛在孙中山组建的南京临时政府秘书处任收发组组长。虽然仅有三个多月时间，但杨杏佛深为孙中山“亟拯斯民于水火，切扶大厦之将倾”的革命精神和爱国情怀感染，在他年轻的心里埋下了为革命事业奋斗终身的种子，扣好了“人生第一粒扣子”。从此，无论身在何方，强烈的社会责任感驱使着杨杏佛不断奋斗。本书以时间为线索，通过“敬佩孙中山 加入同盟会”、“初见孙中山加入秘书处”、“践行中山愿留学寻科学”、“追随孙中山任职大帅府”、“随侍孙中山筹建中山陵”、“继承中山志维民权遇难”六个篇章，全面地展现了杨杏佛在孙中山精神影响下英勇奋斗的历程。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	466
689	有线遥测数字地震仪原理和制造	978-7-305-25071-2	\N	宋祈真,郭建,郝学元,王剑,宋志翔 	0	1-1	16开	88.00	420.0千字	南京大学出版社	276	\N	40	2021-12-08	/book/2825f8f2-9bb5-4828-bdb4-12b6184610021078023.png	人工地震和数字地震仪是探测石油、煤炭等矿产资源的主要方法手段和勘探工具。有线遥测数字地震仪系统庞大，技术复杂，而且各代先进数字地震仪都紧密结合当时最先进的微电子技术。国内由于芯片技术与外界有差距，到目前为止，用于石油勘探的数字地震仪市场基本全部被外国公司所占据。本书编著团队多年来始终坚持对有线数字地震仪关键技术的深入研究和探讨，本书目的意在和国内的数字地震仪研发同行们分享我们的经验和教训，以求促进我国的数字地震仪国产化进程。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	238
690	李晓春自选集：劳动力转移的经济学理论探索	978-7-305-24921-1	\N	李晓春 	0	1-1	小16开	158.00	587.0千字	南京大学出版社	576	\N	14	2021-10-29	/book/d4b1cecb-71be-49a0-9872-577313a1005f1078026.png	我国改革开放以后的劳动力转移是市场经济运作的产物，是推动经济发展的主要动力，具有规模大、涉及面广的中国特色。关于这场劳动力转移，尽管国内外学术界有了许多研究，但这些研究大都是从实证分析的角度展开的。而经济学的理论分析具有经济结构清晰、经济主体作用明确以及严谨可靠等实证研究无法替代的优势，特别适合宏观及微观层面的经济研究。本书以我国的劳动力转移为背景，从经济学理论研究的角度，多方位地考察了具有我国特色的劳动力转移所引起的各种问题。主要涉及户籍、环境、城乡工资、城市失业、农业生产性服务业以及收入差距等经济与环境的各个方面。不仅可以为相关领域的研究人员提供学术参考，也作为高校相关专业的教学参考书，还可以为有关部门制定相关经济政策时提供理论依据。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	835
691	西方演出空间简史	978-7-305-24459-9	\N	大卫·怀尔斯 	0	1-1	大32开	69.00	335.0千字	南京大学出版社	456	\N	40	2021-09-01	/book/7c907736-c9c4-4f75-be4d-7cc783b596241078029.jpg	作者的关注点不仅限于西欧，到二十世纪的部分扩大至东欧和美国。他的研究目的是将西方文化置于人类学视野中，而且不是将欧洲实践看做自然，使之成为标准，而是使欧洲实践陌生化，将它们定位成一种特定文化体系中的仪式。在研究过程中，作者作为一名历史学者，试图阐释一个多元的世界，在涉及“演员”和“观众”的空间实践中存在一种连续性，他集中讨论了扮演故事的实践和由现场表演者参与的实践，即空间、实践和角色的模型叠加在表演的真实地点和时间之上，叠加在表演者的身份之上。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	234
692	小猫鲁普最爱吃苹果	978-7-305-24972-3	\N	莫莫罗/文.图 	0	1-1	16开	46.00	40.0千字	南京大学出版社	63	\N	40	2022-01-01	/book/f204f717-b80e-48d7-ac1b-c3c42da313a61078041.png	小猫咪鲁普最爱吃苹果，他和小熊一起盘算着做各种美味的苹果美食，最后他们决定搭建一座完全用苹果做的甜品屋。小猫咪鲁普摘了满满一大袋苹果，赶着去找小熊，结果在路上，他遇到了需要帮助的小兔子全家、小牛母子、小松鼠一族，他一边把苹果分给大家，一边盘算着，或许没了苹果屋，可以做苹果派，做不了苹果派，还可以做苹果饼干。到最后，小猫咪鲁普的袋子里只剩下一个苹果了，天呢，苹果饼干也做不了。小猫鲁普伤心地哭了，哭着哭着就睡着了，等他醒来，哇！朋友们带来了什么？	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	394
693	袁中郎禅学要解——《珊瑚林》《金屑编》与禅诗解读	978-7-305-24378-3	\N	翁心诚 	0	1-1	大32开	78.00	448.0千字	南京大学出版社	390	\N	36	2021-05-12	/book/fe2ceb95-3525-45a0-8069-1050c7f1226e1078050.png	本书为著者袁中郎研究系列第三本。以中国社会科学出版社《袁宏道〈珊瑚林〉〈金屑编〉校释》及《袁宏道集笺校》，故宫博物院藏《珊瑚林》《金屑编》影印版为蓝本，侧重探讨袁中郎的佛禅思想与文学主张，从三教圆融、以佛摄禅的角度，对袁中郎的学术取向进行深入挖掘，既有学术价值，也有现实意义。本书是著者继《袁中郎佛学与〈西方合论〉初探》、《袁中郎小品思想探究》后的一部新作。天纵异才的袁中郎通过参禅、修持、彻悟对禅学进行了卓有成效的探索，他对历代禅学与禅师横空扫描，褒扬评点；对虚空法界彻照静观，挥洒自如，攀登到了禅学境界的最高峰。《珊瑚林》、《金屑编》与禅诗是他探索与攀登禅学历程的影像记录。著者以中国社会科学出版社《袁宏道〈珊瑚林〉〈金屑编〉校释》及《袁宏道集笺校》，故宫博物院藏《珊瑚林》《金屑编》影印版为蓝本，侧重探讨袁中郎的佛禅思想与文学主张，从三教圆融、以佛摄禅的角度，对袁中郎的学术取向进行深入挖掘，既有学术价值，也有现实意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	768
694	百年中国儿童文学的整体观研究	978-7-305-24642-5	\N	吴翔宇,卫栋 	0	1-1	小16开	98.00	320.0千字	南京大学出版社	392	\N	18	2021-11-30	/book/3470862d-0903-4e11-8997-4452c4b23f751078058.png	中国儿童文学已走过百年发展的历程。对百年中国儿童文学的整体研究，意在把握“整体观”的前提下梳理其演进的轨迹与规律。从整体上看，百年中国儿童文学与现代中国的发展具有同构性，对其予以整体性的观照需要持守“世界性”与“中国性”的标尺。本书提出“整体观”的研究思路，旨在超越纯文学的本质主义与非文学的工具主义，将中国儿童文学与现当代文学的互动共生关系置于现代中国动态文化语境中予以考察。百年中国儿童文学的整体观研究的理论前提是系统把握其发展的过程。在此基础上寻绎融通传统资源与域外资源的机制，梳理其互动共生关系之于百年中国儿童文学发展的影响，为重构立体化的现代中国文学全息图景提供新的研究路径。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	467
695	交通大学西迁校址千年地缘文化考	9787569311242	\N	李慧 	平装	1-1	大32开	258.00	\N	西安交通大学出版社	\N	\N	\N	2021-12-01	/book/8f17c720-abfb-4f17-9cd5-178c67119b271078062.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	498
696	会展设计	9787566719805	\N	许邵艺 主编 	平装	1-1	16开	48.00	\N	湖南大学出版社	\N	\N	\N	2021-09-01	/book/8f36e94c-2813-46ce-921d-df8d013120171078069.jpg	本书对会展设计的含义、起源与发展、特征与原则、会展项目策划与运作、会展设计的基础原理、会展品牌识别系统与版面设计、会展环境的空间规划与设计、会展环境的色彩与照明设计、会展的道具和陈列艺术设计、新技术在会展设计中的应用、会展设计的表现技法、会展项目设计与制作的管理等内容进行了详细、专业的分析和讲解。全书论述面广，既包含会展设计的理论、基本原则、还列举了各种类型的展示设计案例。理论与实践密切结合，使学生能够学以致用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	835
697	电路基础（第三版）（王松林）	9787560608648	\N	王松林 	\N	3-29	16开	56.00	656.0千字	西安电子科技大学出版社	444	\N	7	2020-12-22	/book/bb0d8422-8b6c-4a5d-bf1f-a44fa04b3eea9787560608648.jpg	本书为普通高等教育“十一五”国家级规划教材, 内容符合国家教育部高等学校电子信息科学与电气信息类基础课程教学指导委员会最新制定的《高等学校电路分析基础课程教学基本要求》。 　　全书包括电路的基本规律、电阻电路分析、动态电路、正弦稳态分析、电路的频率响应和谐振现象、二端口电路和非线性电路七章, 以及复数及其运算、OrCAD/PSpice工具使用简介和MATLAB工具使用简介三个附录。各章配有大量例题、不同层次的习题、工程应用实例及仿真实例供选用。 　　本书可作为电子、通信、计算机、自控、微电子、测控与仪器类等各专业“电路”或“电路分析基础”课程教材, 也可供有关科技人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	775
698	幸福地播种：优秀教师的耕耘之路	9787303267934	\N	马万成 	平装	1-1	小16开	56.00	\N	北京师范大学出版社	248	\N	\N	2021-03-01	/book/cdfd2f4a-020f-4ee5-a409-7fe6b241f4bd1078083.jpg	本书以习近平总书记在北京师范大学举办的庆祝第三十个教师节大会上提出的“有理想信念、有道德情操、有扎实知识、有仁爱之心”的四有好老师为引领（也作为本书的理论暗线），以教师成长经验与教育故事为主题，阐述民族小学教师的教育情怀。在2003年前，学校发展遇到困境，教师团队涣散，没有上进心，学生成绩是区域内垫底。2003年马万成接任校长，在他的带领下，学校教师团队逐渐形成教师团队文化与精神引领，开始了10多年的发展与提升，并在2014年荣获国务院颁发的“全国教育系统先进集体”。本书重在梳理民族小学在教师自我修身以及在立德树人方面所做的探索与教育智慧，展现出民小人的教育情怀与追求。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	970
699	清华时间简史：教育研究院（第二版)	9787302579854	\N	王孙禺、李越、李珍、赵琳 	平装	2-1	16开	98.00	\N	清华大学出版社	\N	\N	\N	2021-04-01	/book/66fa69c1-a48a-4359-9376-558ff73271bd1078090.jpg	清华在建校初期即设有哲学教育类别、教育心理学系，后根据社会发展及学校自身需要进行了相应调整。改革开放以来成立了教育研究室，并相继更名为教育研究所、教育研究院。本书通过对档案文献、图书著作、内部文集等资料的挖掘，从多个维度对该学科的历史进行系统归纳和整理，力图为读者提供一部较为完整的清华大学教育学发展演变脉络，亦为我国一流教育学科的建设提供有益的借鉴。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	911
700	温妮女巫魔法绘本:精装珍藏版	9789900331100	\N	[澳大利亚]（澳）瓦莱丽·托马斯 著，（英）科奇·保罗 绘，任溶溶，钱儿妈（白雁飞） 译 	平装	1-1	大16开	591.60	\N	外语教学与研究出版社	\N	\N	\N	2016-12-01	/book/aa32b8cd-13d6-4ea6-a18b-e63e4b7262421078095.jpg	　　《温妮和圣诞老人》：女巫温妮和黑猫威尔伯正等着圣诞节的到来。在圣诞节，他们可以做圣诞蛋糕，写圣诞贺卡，还可以装扮圣诞树……平安夜终于到了，烟囱里传来的声音将温妮和威尔伯从睡梦中惊醒。那是什么？温妮举起魔法棒，高声喊出“阿布拉卡达布拉！”这下子，会发生什么事情呢？ 　　《女巫温妮》：女巫温妮和黑猫威尔伯住在一栋黑色的房子里，房子里的东西也全是黑色的。温妮看不清威尔伯，有时会被他绊倒。这可真麻烦！于是，温妮朝威尔伯举起了魔法棒……阿布拉卡达布拉！你们猜，这下子，会发生什么事情呢？ 　　《温妮去海边》：一个炎热的夏天，女巫温妮和黑猫威尔伯去海边度假。一不小心，温妮的飞天扫帚被卷进了海里，越漂越远！温妮赶紧拿出魔法棒，冲着大海念起了咒语……阿布拉卡达布拉！你们猜，这下子，会发生什么事情呢？ 　　《温妮又飞起来啦》：女巫温妮喜欢骑着飞天扫帚飞来飞去，四处旅行。可这几天，她总会在飞行的时候遇到障碍。现在，温妮决定不骑扫帚了，想要试试别的办法。于是她拿出了魔法棒……阿布拉卡达布拉！你们猜，这下子，会发生什么事情呢？ 　　《温妮过冬》：这个冬天真是太冷了！女巫温妮被冻坏了，就连黑猫威尔伯的胡子上也挂着冰碴儿。这可怎么办！温妮拿出了魔法书，举起了魔法棒，想要给自己变出一个夏天！阿布拉卡达布拉！你们猜，这下子，会发生什么事情呢？ 　　《温妮的魔法棒》：女巫魔法秀终于要开始啦！为了参加这场盼望已久的聚会，女巫温妮把晚礼服和一堆别的衣服扔进了洗衣机。不料，温妮的魔法棒也被一起扔了进去！这可怎么办，温妮就要错过魔法秀了！你们猜，这下子，会发生什么事情呢？ 　　《温妮和午夜小火龙》：一天夜里，女巫温妮的黑猫威尔伯被一阵奇怪的声音吵醒了。他们发现花园里有一只小火龙！威尔伯吓坏了，飞快地向楼上跑去，可小火龙却紧追不舍！这时，温妮想到了一个绝妙的好主意，她抓起魔法棒……阿布拉卡达布拉！你们猜，这下子，会发生什么事情呢？ 　　《温妮的新电脑》：女巫温妮买的新电脑送来了，她非常喜欢。温妮认为电脑能为她做任何事，只要点一点鼠标，就能心想事成！既然这样，还要魔法书和魔法棒做什么？于是，温妮把它们扔进了垃圾桶。你们猜，这下子，会发生什么事情呢？ 　　《温妮和恐龙》：为了画出逼真的恐龙，赢得博物馆“恐龙周”活动的大奖，女巫温妮和黑猫威尔伯来到了恐龙时代，想看看真正的恐龙长什么样子。他们会遇到什么？还能不能顺利地回来？你们猜，这下子，会发生什么事情呢？ 　　《温妮去潜水》：女巫温妮和黑猫威尔伯在海岛上度假。海里到处都是鱼，实在是太美了！温妮灵机一动，把威尔伯变成了“猫鱼”，还把自己变成了章鱼。不料，变身之后的温妮和威尔伯却遇到了大麻烦……你们猜，这下子，会发生什么事情呢？ 　　《温妮去太空》：女巫温妮想去太空冒险。她用魔法变出一枚火箭，乘着火箭来到了一颗小行星上。在那儿，温妮遇到了很多太空兔子。太空兔子不喜欢吃胡萝卜，却把温妮的火箭吃了个精光！没有火箭，温妮该怎么回家呢？你们猜，这下子，会发生什么事情呢？ 　　《温妮和魔法南瓜》：女巫温妮在花园里种了很多很多蔬菜。为了帮助蔬菜生长，温妮在花园里施了魔法。没想到，魔法却让所有的蔬菜都开始疯狂地生长，温妮的房子眼看就要被一个大得惊人的南瓜给压扁了……你们猜，这下子，会发生什么事情呢？ 　　《温妮和飞毯》：女巫温妮有一块漂亮的飞毯，那是妹妹们送给她的生日礼物。可这块飞毯一点儿都不听话，这可让温妮伤透了脑筋。温妮不相信这块飞毯毫无用处，她打开箱子，取出飞毯，这下子，麻烦开始了……你们猜，这下子，会发生什么事情呢？ 　　《温妮，生日快乐！》：女巫温妮要过生日啦！她决定举办一个生日派对，还给大家发了邀请函。为了让派对更加精彩，温妮打算给大家一个大大的惊喜。可她无意间吹响了一支魔法小号，一瞬间，所有人都消失了……你们猜，这下子，会发生什么事情呢？ 　　《温妮的海盗之旅》：温妮带着威尔伯去参加化装舞会。她摇身一变，变成了一个海盗！可晚会上的海盗实在太多，大家一致要求来一场真正的海盗之旅。于是，温妮举起了魔法棒，大喊了一声咒语……阿布拉卡达布拉！你们猜，这下子，会发生什么事情呢？ 　　《温妮和捣蛋机器人》：温妮这几天特别喜欢去图书馆上艺术课，她学会了很多东西，每天都乐在其中。一天，大家要学做模型，温妮本想做一只狗熊来着，却做出了一个机器人。为了让它变成真的机器人，温妮举起了魔法棒……阿布拉卡达布拉！你们猜，这下子，会发生什么事情呢？ 　　《温妮女巫大冒险》：温妮的午睡被一只摔碎的花瓶打断了，她的房子里发生了一些非常奇怪的事情。这是谁干的呢？难道屋子里闹鬼了吗？温妮越想越害怕，赶紧找来魔法书查看修复鬼屋的办法，可关键时刻眼镜不见了！温妮就这样稀里糊涂地喊起了一声咒语。这下子，会发生什么事呢？	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	772
711	发展汉语（第2版）中级口语（Ⅱ）	9787561930694	9787561930694	蔡永强 编著 	\N	1-1	16开	52.00	\N	北京语言大学出版社	\N	\N	\N	2021-12-01	/book/d40c2827-ea08-4ed8-b02d-05546f0420489787561930694.jpg	《发展汉语》（第二版）中级口语（II）适合已经具有中级汉语水平、具备中级汉语口语入门水平、已掌握基本汉语语法和大致2000-2500常用词的汉语学习者使用。本书共15课，建议每课用6课时完成。本书以实用性的选文、内容、练习、体例为学习者建立一个口语训练平台，编写过程中努力突出：选文的广泛性和时代性、编排的科学性和实用性、练习的交际性和任务性。核心目标是：全方位提高汉语学习者的口语表达能力，特别是基于日常对话和语篇语段的口语综合表达能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	181
701	护理模拟教育——从概念到评价（第3版）	978-7-5659-2522-1	\N	原著：[美]Pamela R. Jeffries 主译：尚少梅 金晓燕 	平装	1-1	16开	80.00	\N	北京大学医学出版社	\N	\N	\N	2021-12-01	/book/224d7dbe-d105-4164-bb11-a610faaa7a881078096.jpg	　　模拟教学是解决当今护理学生临床实习日益缺乏的有效策略，能够提供循证为基础的体验式学习机会，以培养学生的批判性思维和临床推理能力。《护理模拟教育——从概念到评价（第3版）》能为初学者学习模拟奠定基础，也能为经验丰富的模拟教育者提供先进的模拟策略和决策依据，以确保模拟项目的成功实施。 　　本版书籍以美国护理联盟Jeffries模拟教学理论（2015）为框架，强调了当前在模拟设计、开发、教学实践、实施过程以及相关学习结局等方面的最佳实践。新增的三个章节介绍了全方位模拟策略的新概念及新进展，包括模拟前介绍，为研究生护理课程的客观结构化临床考核（OSCEs）创建模拟案例，以及使用虚拟现实和游戏来增加学生兴趣。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	191
702	合同法总论	978-7-307-22389-9	\N	杨巍 著 	平装	1-1	16开	68.00	\N	武汉大学出版社	\N	\N	\N	2021-12-01	/book/0a9a0820-90cb-4293-bf1f-62399e3012e51078102.jpg	本书根据《中华人民共和国民法典》以及相关司法解释撰写。本书共分为九章，分别从债与合同概述、合同的成立、合同的内容和形式、合同的效力、合同的履行、合同的保全、合同的变更与转让、合同的权利义务终止、违约责任等方面详细阐述了合同法的相关知识。 《合同法总论》依据《中华人民共和国民法典》对原教材进行了修订，对合同法课程中诸多条款因《民法典》的施行而修改的地方进行了说明。本教材通过比较各国与各地区的立法实践，对合同法相关的重点知识点进行了讲解，并以历年司法考试真题为课后练习以巩固各知识点。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	385
813	通用航空发动机原理与构造（第2版）	9787512435193	9787512435193	董彦非 	\N	1-1	16开	45.00	\N	北京航空航天大学出版社	\N	\N	\N	2021-08-01	/book/f22af244-1c27-4ae5-a7b1-602f9767e5109787512435193.jpg	本书根据通用航空发动机发展的趋势和特点,以非飞行器动力工程专业学习航空发动机知识为目标,全面系统地讲述了通用航空发动机中活塞式发动机和燃气涡轮发动机的原理与基本构造,以及航空发动机工作系统和试验等内容。 本书可作为高等院校飞行器类专业以及涉航各专业的教材,也可供研究人员、工程技术人员及有关管理人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	137
703	文献辨伪研究	978-7-307-22127-7	\N	司马朝军 著 	平装	1-1	16开	78.00	\N	武汉大学出版社	\N	\N	\N	2021-07-01	/book/68d7f9a6-5143-419f-a8f1-d3661b23bf6f1078110.jpg	本书为《辨伪研究书系》中的一种，是一部关于辨伪学的专题论文集。本书是一部关于辨伪学的专题论著。作者在原《文献辨伪研究》出版的基础上，重新进行了修订。介绍了两汉至民国时期知名考据大家的辨伪方法，并对考据方法进行点评。全书分为源流、专题两编。“源流”包括“明代以前辨伪学述论”“明代辨伪四大家合论”“姚际恒《古今伪书考》评析”“《四库全书全目》辨伪方法释例”“梁启超辨伪公例质疑”，“专题”包括七篇论文，将宏观和微观、纵向和横向、个案和专题等研究方法相结合，考察了文献辨伪研究的历史及成就，分析前人辨伪研究的理论方法和思想观念，订正了辨伪学中的诸多错误。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	854
704	基础教育治理模式创新与学校变革	9787565234033	9787565234033	曾晓洁 	0	1-1	16开	68.00	383.0千字	辽宁师范大学出版社	120	\N	40	2021-09-03	/book/92762dc9-7ec6-4318-9113-975bdfa3a5241078134.jpg	本书将精选近五年《比较教育研究》刊发的优秀研究成果。主要内容拟包括：美国、法国、日本、芬兰、德国、澳大利亚等发达国家在基础教育改革方面所颁布的最新政策；学校质量保证体系改革新举措；校外教育治理及影子教育研究；美国特许学校、俄罗斯基础教育社区学校模式、法国“教育优先区”和英国公立学校“学院化”等学校变革内容。全书共5个主题30篇论文，涉及基础教育智力模式创新和学校变革的各个领域。主要主题有：公平取向下的教育创新治理、多样态学校发展模式、学校改进的多元审视、信息时代学校智慧建设等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	793
705	实用汉语语法（第2次修订本）	9787561920831	9787561920831	房玉清 	\N	1-1	16开	78.00	\N	北京语言大学出版社	\N	\N	\N	2021-12-01	/book/bf6aa206-e732-4352-a082-a85580d4a5a99787561920831.jpg	本书是一部全面系统的汉语语法书，专为外国人学习汉语而编写。可作为留学生本科三、四年级语法课教材，也可用于自学，对外汉语教学专业本科生、研究生及对外汉语教师也可用以学习和参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	745
706	乐读——国际中文阅读教学课本2	9787561958506	9787561958506	苏英霞 主编 	\N	1-1	16开	55.00	\N	北京语言大学出版社	\N	\N	\N	2021-12-01	/book/9a84944c-fcdc-4c2e-a527-3d94cacb5a189787561958506.jpg	本教材以培养汉语学习者中文阅读能力为目标，针对汉语学习者中文阅读难点和阅读能力提升需要进行教材内容设计与编写，突出阅读教材特色，通过有针对性的训练帮助学生提高中文阅读能力，为学习者阅读能力提升和教师进行阅读技能训练提供丰富而适用的学习和练习素材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	842
707	轻松学中文（第二版）（英文版）课本1	9787561955970	9787561955970	马亚敏，李欣颖 	\N	1-1	16开	138.00	\N	北京语言大学出版社	\N	\N	\N	2021-12-01	/book/0d167e1f-6a93-4271-a14a-f1d4cc9ab9979787561955970.jpg	《轻松学中文》系列（第二版）是一套专门为非华裔学生学习汉语编写的国际汉语教材，主要适用于小学高年级的学生和中学生。 本套教材旨在为学生奠定扎实的汉语基础，帮助学生在现实生活中得体、准确地使用语言， 有逻辑、有条理地表达观点和思想。这个目标是通过语言、主题和文化的自然结合，字、词、句、语法等语言知识的学习以及听、说、读、写各项交际技能的训练来实现的。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	841
708	轻松学中文（第二版）（英文版）练习册2	9787561957929	9787561957929	马亚敏，李欣颖 	\N	1-1	16开	78.00	\N	北京语言大学出版社	\N	\N	\N	2021-12-01	/book/a31570c4-b72e-4dac-9e68-48a20f82fdbf9787561957929.jpg	《轻松学中文》系列（第二版）是一套专门为非华裔学生学习汉语编写的国际汉语教材，主要适用于小学高年级的学生和中学生。 本套教材旨在为学生奠定扎实的汉语基础，帮助学生在现实生活中得体、准确地使用语言， 有逻辑、有条理地表达观点和思想。这个目标是通过语言、主题和文化的自然结合，字、词、句、语法等语言知识的学习以及听、说、读、写各项交际技能的训练来实现的。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	469
709	发展汉语（第2版）初级口语（Ⅱ）	9787561932988	9787561932988	王淑红 么书君 严禔 张葳 编著 	\N	1-1	16开	74.00	\N	北京语言大学出版社	\N	\N	\N	2021-12-01	/book/d90e5c06-8484-4b8b-8ce2-85e1baba4fa59787561932988.jpg	本套教材的总体目标是全面发展和提高学习者的汉语语言能力、汉语交际能力、汉语综合运用能力和汉语学习兴趣、汉语学习能力。 　　《发展汉语（第二版）初级口语（Ⅰ）》，适合零起点或能进行最简单而有限交际的汉语初学者使用。本书共23课，建议每课用4课时完成。本书内容注重实用性、编排注重科学性、练习注重可操作性，通过本教材的学习，学习者能够逐渐运用简单的汉语解决与语言学习及日常生活密切相关的问题，能就相关话题与他人进行简单的口头交际。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	138
712	发展汉语（第2版）高级综合（Ⅱ）	9787561932513	9787561932513	高增霞 游舒 编著 	\N	1-1	16开	60.00	\N	北京语言大学出版社	\N	\N	\N	2021-12-01	/book/68be1c3a-e14d-4dfd-b1fc-57024a4f9f489787561932513.jpg	　本册教材与《发展汉语·高级综合》（I）相衔接，适合已具备高级汉语入门水平，能理解与社会生活相关的多种语言材料，能用汉语就一般性话题、专业领域的一般性话题与他人进行一定层次的沟通和交流，能准确理解各种意见和较为完整、准确地表明自己观点的学习者使用。本册教材突出课文语体及语域风格的多样性，重视选文的文化视角和课文的文化蕴涵，体例设计以方便使用者和服务教学为宗旨，全面提高高级阶段学习者听、说、读、写综合汉语交际能力。 　　随书赠送录音MP3一张，录有每课的生词、课文等内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	170
713	HSK标准教程1	9787561937099	9787561937099	姜丽萍 主编 	\N	1-1	16开	78.00	\N	北京语言大学出版社	\N	\N	\N	2021-12-01	/book/937b4153-5b8c-4b72-8700-18ffa0e830a89787561937099.jpg	《HSK标准教程》经国家汉办授权，由北京语言大学出版社联合汉考国际（CTI）共同研发，将HSK真题作为基本素材，以自然幽默的风格、亲切熟悉的话题、科学严谨的课程设计，实现了与HSK考试内容、形式及等级水平的全方位对接，是一套充分体现“考教结合、以考促学、以考促教”理念的新型汉语教材。既适用于各国孔子学院，也适用于其他汉语教学机构和个人自学。 全套教程对应HSK考试分为6个级别，1-3级每级1册、4-6级每级2册，共9册。每册分课本、练习册、教师用书3本，共27本。 本书为教程1，共设15课，覆盖HSK（一级）考试的150个词语、45个语言点。学完本书学生可达到“理解并使用一些简单的汉语词语和句子，满足具体的交际需求，具备进一步学习汉语的能力”的目标。 全书配以大量与考试风格相一致的实景图片，彩色印刷。本书配有录音，可扫描封底二维码提取。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	949
714	HSK标准教程3	9787561938157	9787561938157	姜丽萍 主编 	\N	1-1	16开	35.00	\N	北京语言大学出版社	\N	\N	\N	2021-12-01	/book/936e824f-4e89-44cb-a76b-8e17a66225399787561938157.jpg	《HSK标准教程》经国家汉办授权，由北京语言大学出版社联合汉考国际（CTI）共同研发，将HSK真题作为基本素材，以自然幽默的风格、亲切熟悉的话题、科学严谨的课程设计，实现了与HSK考试内容、形式及等级水平的全方位对接，是一套充分体现“考教结合、以考促学、以考促教”理念的新型汉语教材。既适用于各国孔子学院，也适用于其他汉语教学机构和个人自学。 本书为《HSK标准教程3 练习册》，配合《HSK标准教程3》使用，包括教程20课的配套练习，同时，本书附录部分还提供一套HSK（三级）全真模拟试卷和HSK（三级）考试说明。通过使用本书，不但可以帮助学习者顺利通过HSK（三级）考试，还可以全面提升学习者的汉语能力和水平。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	674
715	HSK标准教程4	9787561939031	9787561939031	姜丽萍 主编 	\N	1-1	16开	78.00	\N	北京语言大学出版社	\N	\N	\N	2021-12-01	/book/9ad79de0-9ee7-4ce6-a409-5604035519d79787561939031.jpg	《HSK标准教程》经国家汉办授权，由北京语言大学出版社联合汉考国际（CTI）共同研发，将HSK真题作为基本素材，以自然幽默的风格、亲切熟悉的话题、科学严谨的课程设计，实现了与HSK考试内容、形式及等级水平的全方位对接，是一套充分体现“考教结合、以考促学、以考促教”理念的新型汉语教材。既适用于各国孔子学院，也适用于其他汉语教学机构和个人自学。 全套教程对应HSK考试分为6个级别，1-3级每级1册、4-6级每级2册，共9册。每册分课本、练习册、教师用书3本，共27本。本书为教程4（上），共设10课，覆盖HSK（四级）考试一半的生词量（约300个），包含50个语言点和10组易混淆词语的详解。学完本书学生可达到“用汉语就广泛领域的话题进行谈论，比较流利地与汉语为母语者进行交流”的目标。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	595
716	HSK标准教程5	9787561942451	9787561942451	姜丽萍 主编 	\N	1-1	16开	78.00	\N	北京语言大学出版社	\N	\N	\N	2021-12-01	/book/e1279152-c9d0-4c3e-92ba-4ab064904a679787561942451.jpg	《HSK标准教程》经国家汉办授权，由北京语言大学出版社联合汉考国际（CTI）共同研发，将HSK真题作为基本素材，以自然幽默的风格、亲切熟悉的话题、科学严谨的课程设计，实现了与HSK考试内容、形式及等级水平的全方位对接，是一套充分体现“考教结合、以考促学、以考促教”理念的新型汉语教材。既适用于各国孔子学院，也适用于其他汉语教学机构和个人自学。 全套教程对应HSK考试分为6个级别，1-3级每级1册、4-6级每级2册，共9册。每册分课本、练习册、教师用书3本，共27本。 本书为教程5（下），共设18课，覆盖HSK（五级）考试一半的生词量（约1200个），包含50个语言点和18组易混淆词语的详解。学完本书学生可达到“用汉语就广泛领域的话题进行谈论，比较流利地与汉语为母语者进行交流”的目标。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	460
717	HSK标准教程5下	9787561949733	9787561949733	姜丽萍 主编 	\N	1-1	16开	55.00	\N	北京语言大学出版社	\N	\N	\N	2021-12-01	/book/58d042c4-1611-4a57-bd15-7fdbff46e1ce9787561949733.jpg	《HSK标准教程》经国家汉办授权，由北京语言大学出版社联合汉考国际（CTI）共同研发，将HSK真题作为基本素材，以自然幽默的风格、亲切熟悉的话题、科学严谨的课程设计，实现了与HSK考试内容、形式及等级水平的全方位对接，是一套充分体现“考教结合、以考促学、以考促教”理念的新型汉语教材。既适用于各国孔子学院，也适用于其他汉语教学机构和个人自学。 全套教程对应HSK考试分为6个级别，1-3级每级1册、4-6级每级2册，共9册。每册分课本、练习册、教师用书3本，共27本。 本书为《HSK标准教程5下 练习册》，配合《HSK标准教程5下》使用，包括教程18课的配套练习，同时，本书附录部分还提供了HSK（四级）模拟试卷。通过使用本书，不但可以帮助学习者顺利通过HSK（五级）考试，还可以全面提升学习者的汉语能力和水平。 全书配以大量与考试风格相一致的实景图片。本书配有录音，可扫描封底二维码提取。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	476
725	传媒与艺术研究（2019年第3辑）	9787565729478	9787565729478	李锦云 	\N	1-1	16开	58.00	\N	中国传媒大学出版社	\N	\N	\N	2021-07-19	/book/6cb02cce-d4bc-4196-8e47-53ab8336ddc49787565729478.jpg	《传媒与艺术研究》一书是以传媒与艺术为主要研究领域的人文社会科学类学术出版物。本书宗旨为：立足校内，面向传媒艺术类高校和传媒艺术领域，秉持“百花齐放、百家争鸣”的方针，主要开展传媒与艺术理论及实践研究，打造学术名片，为展示学校教学科研成果提供窗口，为开展学术交流和提升教师队伍素质搭建平台。集刊分新闻与传播、影视艺术、美术与设计、文学与传播、信息与管理、高教园地、科研论苑、文化论坛八个版块，为传媒与艺术的研究者提供了发表见解、互相讨论的平台。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	931
718	剑桥国际英语美语语音与听力入门	9787561958612	9787561958612	[美] 朱迪·B.吉尔伯特 (Judy B. Gilbert) 	\N	1-1	16开	45.00	\N	北京语言大学出版社	\N	\N	\N	2021-12-01	/book/df29c77e-02c9-4c27-a677-2f33bcfce19d9787561958612.jpg	本教材是Clear Speech的入门级版本，它与《剑桥国际英语美语语音与听力速成》（Clear Speech）、《剑桥国际英语语音入门》（Tree or Three?）、《剑桥国际英语语音教程（美音版）》（Pronunciation Pairs）和《剑桥国际英语语音教程（英音版）》（Ship or Sheep?）为同一系列，是由剑桥大学出版社出版的经典英语语音教材。自2001年问世以来，本教材被很多非英语国家引进。北京语言大学出版社独家引进了本教材的第二版，使其以全新的面孔呈现在中国读者面前。英语听说能力强，首先体现在发音准确。发音不标准往往会影响交流。你可能有过这样令人沮丧的经历——一些很普通的单词，你说出来对方就是听不懂。原因很简单，就是你的发音不准确。一线教师实践证明，较早学习标准的发音可以避免日后花费时间、精力纠正错误的发音习惯。本教材可以帮助学习者掌握标准的美式英语发音，学到如何更清晰地发音、更有效地听其他人发音、猜测单词的发音，从语音入手，听说水平一起提高。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	790
837	世说新语	978-7-5677-3354-1	9787567733541	（南朝宋）刘义庆 编撰 	\N	1-1	16开	29.00	\N	吉林大学出版社	\N	\N	\N	2015-04-01	/book/9d6269de-cb5d-4c24-a3a9-ddbf9963148f978-7-5677-3354-1.jpg	《世说新语》是中国传统的志人小说的名著，主要记述了汉末魏晋人物的言谈风尚和遗闻轶事。全书共36篇1130则，它涉及的内容包括政治、经济、社会、文学、思想等许多方面，因而也是研究这一时期历史的重要资料。它真实反映了当时人们的思想、生活和社会风貌，也显现出来其在社会、政治、思想、文学、语言等方面所具备的价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	512
719	巨鲸：私人文学史	978-7-307-21953-3	\N	杨典 著 	平装	1-1	32开	48.00	\N	武汉大学出版社	\N	\N	\N	2020-12-01	/book/01b7cc03-a748-4288-a57c-51222a1d4af01078282.jpg	本书是作家杨典若干年来积累的一些读书随笔、写作观念或偶然记下的书话之集锦。书中共收录三十二篇文章，而所涉及的作家与作品至少数倍于此。作者不仅用极具个性的语言对古今中外一些或经典、或冷门的作品进行了解读，同时还将自己对于人生，对于写作的思索融入其中，最终提出了独到的观点与见解。这些文章并非体系化的书评，亦非理论化的文论，而是一系列匠心独运的小品文；作者在阅读过程中，通过对相关历史的考证、查阅，像盲人摸象一样从局部去探索文学史，将所获所感化为文字，充分反映了其庞杂的阅读兴趣与深厚的阅读积淀；因此，本作也可以说是一个人阅读的精神史，故称为“私人文学史”。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	832
720	地下工程施工（高职“十三五”）	978-7-5646-4351-5	\N	张恩正 	平装	1-1	16开	38.00	\N	中国矿业大学出版社	\N	\N	\N	2019-03-01	/book/044a4e4e-a481-4e68-ba06-3c546082ae0c1078287.jpg	本书为职业教育国家“十三五规划教材”，内容是根据本课程的教学基本要求并按照国家颁布的有关施工、设计新规范、新标准编写的。本书力求体现高职高专教学改革的特点，突出针对性、适用性、实用性，重视由浅入深和理论联系实际，内容简明扼要，通俗易懂，图文配合紧密。本书共分为11章，内容包括地下工程概述、明挖法施工、盖挖法、隧道钻爆法施工、顶管法施工、沉管隧道施工、盾构法施工、TBM掘进施工、沉井施工、桩基施工、辅助工法等内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	856
721	矿山压力观测与控制（高职“十三五”）	978-7-5646-4011-8	\N	元永国 	平装	1-1	16开	37.00	\N	中国矿业大学出版社	\N	\N	\N	2018-10-01	/book/8584a593-49c5-4b11-a412-a3ebdc2527dc1078392.jpg	本书为职业教育国家“十三五规划教材”，是根据煤炭高职高专煤矿开采技术专业教学培养方案的要求编写的。在编写过程中，结合培养煤矿开采技术专业高技能人才的要求，力求突出高等职业教育的特点，基本理论以够用为度，重点加强实践知识和能力的培养与训练。因此，增加了实验、实践教学内容。旨在提高学生实际分析问题和解决问题的能力。就文字叙述来说，本书要力求通俗易懂，风趣活泼；就版面编排来说，要力求图文并茂，版式灵活。新颖的表现形式能够激发学生的学习兴趣，有助于消化教学内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	476
722	矿图(高职“十三五”)	978-7-5646-3991-4	\N	冯新顶 	平装	1-1	16开	25.00	\N	中国矿业大学出版社	\N	\N	\N	2021-01-01	/book/fc221fa4-f049-4dbc-a0fd-21f13c7ccc491078393.jpg	本书为职业教育国家“十三五规划教材”，系统地介绍了煤矿常用矿图的特点、内容、绘制和识读方法煤矿常用矿图的特点、内容、绘制和识读方法。全书共分八个单元，内容包括矿图基本知识、矿图投影基本原理、矿图制图基本知识、矿山测量图、矿井地质图、矿井开拓开采设计图、煤矿生产管理图和煤矿安全工程图等。书后附有综合练习和常用矿图符号。本书适合职业技术院校和成人教育院校煤矿开采技术专业、矿井通风与安全专业及其他煤炭开采类相关专业使用，也可供广大煤矿工程技术人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	257
723	报刊与近现代中国城市	9787565728945	9787565728945	黄旦主编 周奇副主编 	\N	1-1	16开	78.00	\N	中国传媒大学出版社	\N	\N	\N	2021-07-29	/book/01d09f39-1af3-40d2-846f-30bec9eb21aa9787565728945.jpg	近代以来的印刷革命已经深刻改变了人们的生活和沟通方式，也无所不在地影响着商业和政治的运作模式。报刊作为印刷媒介，还是一种新型的业态，在塑造近代中国的政治经济文化和社会各个方面都有不可替代的作用。大至近代中国的政治和政治再生产、思想、教育和文化，小至都市市民消费文化、城市传播和都市文化的形塑，无不有印刷传媒业的印记。报纸这种印刷媒介不仅在物质上提升了近代社会的传播技术，还在人际族群间建构了新的心理认同和文化认同。这种印刷中的中国是现实中国与想象中国的结合体。本书以近几年的“传播视野中的中国问题研究”学术会议为基础，将之论文收集成编，展示不同学科在这方面研究的进展及其变化，启迪学术，推动对话。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	190
724	播音主持基本功训练掌中宝——语音·发声·表达（第二版）	9787565727832	9787565727832	李俊文、肖云际 	\N	1-1	64开	28.00	\N	中国传媒大学出版社	\N	\N	\N	2021-04-16	/book/221c3057-256d-4ae4-822e-85f7de9522389787565727832.jpg	《播音主持基本功训练掌中宝：语音·发声·表达》是专门为播音与主持艺术专业学生和爱好者设计编写的练声手册。形态上为64开，外观小巧，便于携带，深受读者喜爱。内容以训练材料为主，涵盖普通话语音、播音发声、语言表达内外部技巧等，并用新闻播音来加强语言基本功的训练，还附有大量容易读错的字、绕口令、贯口。本次修订对案例进行了大量替换，使之更符合时代发展，贴近专业要求。对上一版中语言表达不严谨之处进行了修订，整体质量将更加优秀。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	418
758	燕京墨场——刘世衡翰墨集	9787566619082	9787566619082	吴占良 	\N	1-1	16开	628.00	\N	河北大学出版社	\N	\N	\N	2021-09-18	/book/5e5ed3c2-ab6a-4fed-ae40-703aaf9c2e8c9787566619082.jpg	作者对刘世衡诗文、书法等遗稿做出的整理和注释，主要包括三方面内容：一是对其诗文书法等做出释文；二是对凌乱的手稿进行科学的问题归类；三是制定刘世衡年表。本选题不仅能带给读者一定的艺术熏陶和享受，某些方面还可弥补史书记载之缺，具有一定史料价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	704
726	大数据技术导论	9787565729317	9787565729317	李春芳 石民勇 	\N	1-1	16开	78.00	\N	中国传媒大学出版社	\N	\N	\N	2021-07-05	/book/b08ec284-a4f0-4c72-9c3b-91c299cc4f299787565729317.jpg	本书面向计算机大类17个专业，包括：数据科学与大数据技术、计算机科学与技术、数字媒体技术、新媒体技术，和数据新闻等专业，以及面向本科通识教育，阐述了大数据相关技术生态概况，包括大数据、人工智能、区块链、云计算、网络空间安全等内容，从教育、媒体、电商、影视、游戏等行业角度看大数据技术应用现状。全书分为12章，内容选择涵盖国家政策、国家和行业标准、院士和权威专家观点，及作者团队对大数据技术与应用的理解。本书特色定位：关注前沿、视频链接、案例丰富、兼顾周边、围绕大数据讨论新技术生态概况。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	753
727	媒介与传播研究方法	9787565727566	9787565727566	阿瑟·阿萨·伯格（Arthur Asa Berger） 	\N	1-1	16开	98.00	\N	中国传媒大学出版社	\N	\N	\N	2021-05-17	/book/5df1e4ac-3fe8-4618-ae87-5cd01e902c559787565727566.jpg	本书是一本畅销的教科书，在美国大学的媒介研究、文化研究及相关领域的课程中被广泛使用，自2000年出版以来已多次再版。作者阿瑟·阿萨·伯是旧金山州立大学的荣休教授，他极为擅长以通俗易懂、诙谐幽默的语言撰写教科书和入门性读物，已有8本著作译成中文，包括备受欢迎的《涂尔干死了！》《哈姆雷特谋杀案》《媒介分析技巧》等。本书系统梳理了媒介研究的主要方法，从符号分析到意识形态批判，从民族志到统计学，从文献综述到报告撰写，囊括了媒介研究可能涉及的所有研究方法和研究环节，并以极为生动的方式加以呈现。作者不仅将方法论及理论概念解释的深入浅出，将操作策略、注意事项与应用练习呈现的条理清晰，而且以图表、案例、小短剧、自绘插图等方式为本书增添了许多趣味性。本书对于入门研究者来说，足可成为案头宝典。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	183
728	电视剧人物创作论	9787565727764	9787565727764	倪学礼 	\N	1-1	16开	65.00	\N	中国传媒大学出版社	\N	\N	\N	2021-04-15	/book/2ce18c42-2cdd-4fa5-8710-5c21be9865699787565727764.jpg	本著作以“如何创造出成功的电视剧人物”为中心议题，从“人物思想”“人物造型”“人物与情节结构”“人物与场景”“人物与对白”五个方面探讨电视剧创作的美学理路，梳理近年来电视剧剧作人物处理的成败得失，试图倡导电视剧剧作中的文学倾向，倡导电视剧应该写人，以人物与故事的有机互动与镜像呈现实现电视剧与文学的双向激活，进而提高电视剧创作的艺术品位。本书理论扎实，案例翔实，分析到位，在电视剧剧作研究领域具有一定的学术价。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	354
729	发布台	9787565729140	9787565729140	王勇平 	\N	1-1	32开	68.00	\N	中国传媒大学出版社	\N	\N	\N	2021-06-04	/book/59256b3f-2830-41ab-b659-057be903536f9787565729140.jpg	2003年至今，中国新闻发言人制度化建设经历了从试点到推广、从个别到普遍的过程。如今，从中央到地方、从政府机关到企事业单位，都普遍建立了新闻发言人制度。中国新闻发言人制度化的建设已经逐步走向健全、规范和完善。2003—2011年，作者担任了八年的铁道部新闻发言人，恰逢2003年“非典”危机是中国政府新闻发布制度建设的起点，2011年甬温线动车事故是中国政府新闻制度建设的重要拐点。作为曾经的政府发言人，作者在书中分享了他的心路历程，不仅对自己过往的工作进行了梳理和归纳，还原了2011年甬温线动车事故新闻发布的历史真相，而且在其过往经验教训的基础上提出了一些宝贵的建议，对于建立更加完善、更加规范和更加成熟的新闻发言人制度具有很大的借鉴意义，使后浪推前浪式的新闻发言人队伍在发布台前更加自觉、更加自信和更加自如。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	660
730	全球治理中国话语体系的建构与国际传播	9787565729263	9787565729263	郭璇 	\N	1-1	16开	62.00	\N	中国传媒大学出版社	\N	\N	\N	2021-08-08	/book/61fa6697-9b9c-4ea0-be7b-2e120f6c5ea19787565729263.jpg	党的十八大以来，习近平总书记等国家领导人十分重视全球治理工作，“中国贡献”、“中国方案”、“中国声音”、“中国药方”等全新提法频繁在国内国际的重要场合发声，以期逐渐实现中国在全球治理中从被治理者、疏离者向积极参与者和主动建设者角色的转型。中国政府特别强调，为了实现更加完善的全球治理体系，需要中国作为新兴经济体国家的代表，努力提升制度性话语权。制度性话语权的实现需要两个层面的建设，一是建构起全球治理的中国话语；二是通过中国话语与世界各国的话语互动，形成国际共识，完成话语权的实现。因此，本书的研究将围绕两大核心问题展开，即“中国怎么说”和“世界怎么看”。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	658
731	少儿国学经典诵习（第一册）	9787565728686	9787565728686	汤儒、吕铭、汤翘楚 	\N	1-1	16开	58.00	\N	中国传媒大学出版社	\N	\N	\N	2021-03-24	/book/63e86766-ed0c-4f4d-9387-1a49e4974ee59787565728686.jpg	本书有《三字经》及唐诗的原文、讲解。讲解内容富有特色，有对原文和作者的解读，有诵读的方法指导，还有教女儿学习的详细方法。唐诗部分从选材到编排，都结合了小升初、中考大纲，知识点归类，直接对接学校语文课堂，趣味性强。音频是朗诵艺术名家的朗读和讲解。作者汤儒深刻感受到国学功底为自己在工作、生活、育儿方面带来的诸多益处，非常重视女儿汤翘楚的国学教育，把女儿培养得非常出色。她希望推广自己成功的国学育儿经验，惠及更多家庭和孩子。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	984
732	戏剧影视形体表演基础（第三版）	9787565726415	9787565726415	杨扬 	\N	1-1	16开	48.00	\N	中国传媒大学出版社	\N	\N	\N	2021-03-15	/book/209522ba-6a71-4037-b187-c9ab2a8cb3189787565726415.jpg	本书讲解了古典芭蕾舞、现代舞、毯子功等形体基本功的训练，中国古典舞身韵、器械道具运用等舞台技能的训练，中国民间舞、古典仪等代表性动作技能的训练。对于形体训练的讲解图文并茂，还有示范动作的完整视频。本书填补戏剧影视表演专业形体课程教材的空白，既可作为高校相关专业的教材，也可作为广大表演艺术、舞蹈艺术爱好者的参考用书。本书作者在十几年表演专业形体课的教学实践中，根据戏剧影视表演的实际需要，不断创新，摸索和总结出更适合培养演员形体表演能力的训练方法。本书出版后，得到专家和师生的广泛好评，被几十家高校指定为相关课程的教材。修订后的第3版，讲解更加简洁，图片更加清晰，是表演专业形体课程不可多得的教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	307
753	先秦两汉史学步集	9787566616173	9787566616173	王汉昌 	\N	1-1	16开	60.00	\N	河北大学出版社	\N	\N	\N	2020-05-16	/book/b43a4176-d537-4568-b95e-e54806bff4f29787566616173.jpg	本书为河北大学历史系退休教授王汉昌先生的史学文集	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	485
733	新媒体设计基础	9787565726781	9787565726781	柯力嘉 	\N	1-1	16开	49.00	\N	中国传媒大学出版社	\N	\N	\N	2021-02-08	/book/37418357-559a-435f-acbe-f8dcf0b908509787565726781.jpg	本书是一本实用性比较强的课堂用教材，针对基础薄弱，甚至零基础的学生，进行新媒体设计入门的教学。内容从平面制图入手，让在掌握图形创造的方法的同时对计算机图形的模式有一定的了解。在有了制图基础之后进行动画制作的讲解，其中包括时间轴的控制以及通过运用代码进行简单动画制作。最后进入交互作品实现的学习，利用已有的制图和动画制作基础，结合简单的交互技术，可以实现日常大部分常见的交互效果。在讲解操作的同时，书中还会适当介绍相关的领域知识以及针对性强且实用的理论知识，以便学生能理论结合实践并对新媒体设计有较全面的了解。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	375
734	影视编导：艺术与形态的构成	9787565729065	9787565729065	严前海 	\N	1-1	16开	59.00	\N	中国传媒大学出版社	\N	\N	\N	2021-07-12	/book/e2b65d94-dae0-47f4-8ce0-c6ab233d7b5a9787565729065.jpg	本书在操作、艺术、美学三个维度，为大学生的影视创作提供丰富的经验总结、案例导引和阅读延伸，从剧作线性、非线性、剧作结构、导演核心环节的场面调度(包括词与表演)，到图像、空间与声音的艺术规定性、时间与节奏、经典与现代电影美学对制作的内在影响，以及实验电影的可能等关键议题，相对完整地解决影视创作中“怎么做”和“为什么这样做”所涉及的多重实践挑战。 本书既可作为新思维视野下的影视艺术概论类教材，也可作为影视爱好者的有益读物。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	434
735	影视剧改编经典案例解析	9787565728013	9787565728013	李胜利、黄金华、杜斌 	0	1-1	16开	56.00	\N	中国传媒大学出版社	\N	\N	\N	2021-03-29	/book/0150d498-19a6-4ce7-b4cd-9259a69c00c69787565728013.jpg	本书收录了16个有代表性的影视剧改编案例，围绕影视剧的首度创作即剧本创作撰写案例分析，理论性与实践性兼具，且相对通俗易懂。本书中的案例选择主要兼顾各种改编类型与改编效果，以此来保障案例建设的完整性与典型性。比如，既包括从原著到影视剧的改编，也包括从小说到戏剧改编；既包括从短到长的改编，也包括从长到短的改编；既包括从原作到改编作品的单次改编，也包括从原作到改编作品的多次改编；既包括忠于原著的改编，也包括不那么忠于原著的改编；既关注宏观变化，也关注比较特别的微观变化，并努力关注从剧本到完成片的变化，以便让编剧对整个剧本的定稿过程有更全面的认识，以此来保障对案例使用者的高度启发性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	583
736	中国传播学评论（第九辑）	9787565728549	9787565728549	黄旦 	\N	1-1	16开	79.00	\N	中国传媒大学出版社	\N	\N	\N	2021-06-17	/book/e16e25b4-bd45-4c72-85c2-2e2e05e4f5c69787565728549.jpg	本书围绕“城市传播”主题，以书代刊地展现中国新闻传播学学术研究前沿成果，包括译文、论文、沙龙讲稿、调研报告、课程论文等板块。根据《C时代：城市传播方略》的定义：城市传播研究的基本命题就是将城市视为一个庞大而又复杂的传播体系。研究以最佳的投入形式、投入规模以及科学的开发手段组织城市传播活动，实现城市传播系统的良性运行，并使相关利益主体的需求获得相对满足。是一门研究城市运行体系中各种载体所承载的信息及其运行规律，以此促进城市良性发展，满足城市相关利益主体需求的独立的应用性学科。城市传播学的研究对象是城市中的各种组织、个人和空间系统及其运行情况。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	729
737	中国近代新闻国际交流史	9787565728570	9787565728570	倪延年 	\N	1-1	16开	69.00	\N	中国传媒大学出版社	\N	\N	\N	2021-03-24	/book/353b9c77-8dee-4133-acae-85b830b486e59787565728570.jpg	“中国近代新闻国际交流史”研究的是在“中国近代”这一特定历史阶段里发生的“中国新闻界和外国新闻界在新闻传播领域的相互交流现象起源、发展、变化的历史过程及其规律”。所研究的“新闻交流现象”是特指发生在“中国近代”这个历史阶段中“中国”和“外国”间的“新闻交流现象”。在这一书名中涉及到“中国近代”“新闻国际交流”和“中国近代新闻国际交流”三个基本概念。在叙述“中国近代新闻国际交流史”的具体内容之前，很有必要先界定一下“中国近代”、“新闻国际交流”及“中国近代新闻国际交流”这几个基本概念的做一简单阐释，以作为本书内容和叙述逻辑的学理基点。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	715
738	中国网络传播研究：互联网的历史分析	9787565729447	9787565729447	夏倩芳 	\N	1-1	16开	63.00	\N	中国传媒大学出版社	\N	\N	\N	2021-07-21	/book/a30f6b68-3023-4f29-b4c2-44b26929a9fd9787565729447.jpg	《中国网络传播研究：互联网的历史分析》包括“本刊特稿”“专题论文：中国互联网历史”和“研究论文”三个部分，共11篇文章。“特稿”部分1篇，为胡泳教授撰写的《土味视频和新生代农民工的身份认同》。专题论文聚集媒介史的最新成员——中国互联网历史，包括引言、中国早期互联网接入的政治和经济考察、《人民日报》关于互联网的话语研究；在微观层面，涉及网络意见领袖、博客文化、网络文学、网红文化等几个议题。本专题探讨了近30年来中国互联网发展的技术路径和网络文化，研究较为前沿。研究论文包括3篇，分别探讨社交机器人、公共事件微博舆情演化、网络欺凌等话题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	956
739	中国网络传播研究：在线媒体的使用与效果	9787565728440	9787565728440	夏倩芳 	\N	1-1	16开	49.00	\N	中国传媒大学出版社	\N	\N	\N	2021-04-12	/book/1497b754-01f3-461f-a2c4-3d36f2598c0e9787565728440.jpg	《中国网络传播研究：在线媒体的使用与效果》由南京大学夏倩芳教授主编，总结了中国学界关于网络传播研究的最新成果，旨在为媒介效果研究在新媒体方向上的理论探索提供学术平台，彰显了经典理论在互联网时代的新应用、新发展、新思考。全书分“理论前沿”“研究生专栏”和“学术综述”三个版块，收入《移动视频客户端个性化推荐系统的评价指标体系研究》《计算广告中的效果衡量方法》《“沉默”在理性诉求视频广告中的认知心理研究——基于ELM的动实验证据》《基于在线媒体的饮食文化多样性研究》《论“数据无意识”——精神分析哲学视角下的网络大数据》《金融App与个人隐私保护强化问题》《微信使用对大学生健康行为的影响》《微博舆论场中大学生意见表达及其影响因素研究——以环境议题为例》《想象的地方：少数民族“再地方化”与文化边界重塑——以土家摆手舞为例》等文章,既有理论研究、学术研究发展动态，又有对媒介实践经验的总结，代表了该领域学术研究的较高水平。 20世纪90年代以来，随着媒介技术的飞速发展，网络传播领域发生了很多重大变化，成为传播学研究的热点。本书有效地集合学界业界力量，从不同视角对这一领域中的现象进行研究和阐释，力求为中国网络传播的发展提供理论指导和实践借鉴。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	858
740	中国新闻传播研究：网络视频传播	9787565728563	9787565728563	高晓虹 	\N	1-1	16开	79.00	\N	中国传媒大学出版社	\N	\N	\N	2021-08-30	/book/6fc7aa52-06b6-4f9d-b832-38c1dbd0d4449787565728563.jpg	近年来，网络视频逐渐发展成为互联网传播的主流内容形态。从短视频到网络直播，一个又一个的互联网风口被网络视频所占据。而以抖音、快手等为代表的网络视频平台不但促进了互联网产业的发展，也极大地丰富了网络文化，并深刻地影响了人们的生活方式。本书旨在探讨网络视频在新时代面临的机遇和挑战，研究如果通过网络视频更好地传递主流价观和社会正能量，并进而建设一个积极向上、风清气正的网络视频空间。本书既适合新闻传播专业的学生和研究者阅读，以拓展自己的专业视野，也适合从业者阅读，以提高自己对行业的认识。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	685
741	转型社会政务微信创新扩散研究	9787565728525	9787565728525	曾丽红 	\N	1-1	16开	76.00	\N	中国传媒大学出版社	\N	\N	\N	2021-05-24	/book/df71b60c-bf2d-4ff6-a8e2-9f3a7f1235419787565728525.jpg	当下世界各国都在积极利用社交媒体来寻找他们在网络社会中的定位，并将其行为嵌入“新公共管理运动”和“数字化时代治理”的浪潮中。在此背景下，本书重点探讨中国本土文化的政府社交媒体————政务微信的创新扩散机制，兼而讨论转型中国语境下的政治-技术关系命题。 本书基于中国的政治和社会实践，搭建了一个转型社会政务微信创新扩散影响因素和影响机制的理论模型，为信息技术在转型中国政府内部的创新扩散过程提供新的理论解释。 本书提出的理论分析框架亦可为中国转型社会的媒介整合及“去隔层对话”提供一些新的思路和政策建议。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	549
742	自我与他人	9787565720307	9787565720307	Julie L. Andsager H.Allen White 	\N	1-1	16开	59.00	\N	中国传媒大学出版社	\N	\N	\N	2021-05-13	/book/db9dc62a-0a6d-4e3d-bcb2-6980673f64de9787565720307.jpg	本书是第一本关注第三人效果的学术专著，也是迄今为止比较全面讨论第三人效果的著作，探讨了第三人效果及其作为一种说服手段在媒介中的作用。 本书作者朱莉·L.安德萨格和H.艾伦·怀特重点分析了媒介和信息的作用，并认为第三人效果起着说服的作用。此外，本书还探讨了第三人效果与已经建立的说服理论和媒介传播理论共享的基本概念和关系。 本书对第三人效果作了深入而不失生动的阐述，对我们认识、学习、借鉴这一美国传播学“新论”，包括缘起、演化、相关内容、实践背景、具体研究及其发现等，提供了一个恰如其分的读本。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	664
743	刘秀与河北	9787566617996	9787566617996	常海成 	\N	1-1	16开	118.00	\N	河北大学出版社	\N	\N	\N	2021-09-18	/book/ca83a358-fd86-46e5-ab46-df511718da189787566617996.jpg	讲述汉光武帝刘秀在河北，重点收录了刘秀在河边的传说故事、典籍记载和文化遗存，既是通俗读物。也是关于刘秀与河北的文化资料集。刘秀的帝业兴于河北，成于河北。本选题的出版有助于人们了解并研究东汉之初河北的重要地位，进而重新审视河北在中国历史上的地位。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	936
744	在二十四节气里细数日子	9787566614223	9787566614223	曹羽 	\N	1-1	16开	58.00	\N	河北大学出版社	\N	\N	\N	2019-04-25	/book/d2bd007d-c35f-42f4-935f-c9dba4ca03939787566614223.jpg	该书从文化的角度对二十四节气进行解读，并从物候、生活、精神等层面对其文化内涵进行解剖。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	399
745	圆梦清华——34位家长的教育笔记	9787566618917	9787566618917	耿宝辉 	\N	1-1	16开	40.00	\N	河北大学出版社	\N	\N	\N	2021-09-23	/book/8192a735-db84-4a79-b4c4-e0a3e1bcb5df9787566618917.jpg	本书真实地记述了34位清华大学在校生家长结合自己孩子的成长经历，畅谈培养和教育孩子的经验、方法和感悟，值得每一位学生家长学习借鉴，既给人憧憬又引人深思，无论是父母长辈还是孩子，甚至专家学者、教育者都可能从中获得一些启发。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	117
746	雄安文脉丛书	9787566615626	9787566615626	胡连利 	\N	1-1	16开	199,800.00	\N	河北大学出版社	\N	\N	\N	2020-07-27	/book/a9e4ac0f-fe7e-43ed-ab8f-e3d6c4035ba69787566615626.jpg	本书整理影印了雄安新区郝经、刘因、杨继盛等先贤的传世著作，共136册，展现了雄安先贤守正的历史风貌，对雄安新区的文化传承、学风延续和精神构建必将发挥积极的作用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	373
747	大山里的音乐会——共产党员邓小岚的故事	9787566618597	9787566618597	翟英琴 	\N	1-1	16开	28.00	\N	河北大学出版社	\N	\N	\N	2021-08-19	/book/6c1c349c-63b1-4800-995c-552e2ae6b72d9787566618597.jpg	讲述了共产党员邓小岚音乐支教的故事。在抗日战争时期，通过音乐助教，邓小岚帮助革命老区的孩子们树立起自信心，健康快乐地成长，从而改变了人生的命运，本书旨在讲述一位普通共产党员的奉献故事，她以自己的身体力行，弘扬了中国共产党的精神，彰显了社会主义核心价值观。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	537
748	燕赵濒危剧种手抄本传统剧目整理丛书：丝弦卷	9787566618122	9787566618122	刘金柱 	\N	1-1	16开	198.00	\N	河北大学出版社	\N	\N	\N	2021-07-23	/book/f1394fc6-5b0b-4c3e-aaae-4bb3c3f504649787566618122.jpg	该丛书共4本，丛书搜集整理出燕赵地区有代表性的地方戏剧4种，手抄本剧目共150余本，其中不乏有着102多年历史的老剧本。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	147
749	《三国演义》诗词文全注及研究论稿	9787566617576	9787566617576	李新、孙维芳 	\N	1-1	16开	58.00	\N	河北大学出版社	\N	\N	\N	2021-02-25	/book/efbd67d9-3486-43a5-94d6-4c8ff869360b9787566617576.jpg	本书稿将罗贯中所著《三国演义》小说文本中全部诗词诗文等主义梳理统计、诠释，并对《三国演义》诗词文之题材类型、体裁艺术等做了系统和整体的评析。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	923
750	宋代骚体文学的嬗变	9787566605221	9787566605221	李金善 	\N	1-1	16开	46.00	\N	河北大学出版社	\N	\N	\N	2013-10-17	/book/dfce8370-6a54-41fd-baeb-2f81995f4a379787566605221.jpg	本书展现了骚体从屈骚精神复兴到逐渐淡化的过程，具有一定出版价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	201
751	近代汉字研究（一）	9787566610195	9787566610195	河北大学传世字书与出土文字研究中心 	\N	1-1	16开	48.00	\N	河北大学出版社	\N	\N	\N	2018-07-25	/book/108dd0ab-1269-4111-a310-8f30fe8ecf909787566610195.jpg	书中分七个栏目：近代汉字理论研究、近代汉字疑难字考释、出土文献整理与研究、传世文献整理与研究、域外汉字整理与研究、研究生论坛、学术书评。书中辑录了专业论文25篇，代表了近代汉字研究的最高水平，具有很高的学术价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	857
752	文化视野下的唐宋八大家研究	9787566616890	9787566616890	申惠萍 	\N	1-1	16开	36.00	\N	河北大学出版社	\N	\N	\N	2020-09-21	/book/ed35cd7a-ea2b-4ddc-a028-a003453687019787566616890.jpg	本书将唐宋八大家的古文作品放置于中华传统文化流变的宏伟视野中，以唐宋八家文章为切入点，不仅回顾、解析了中华文化中的基本概念的内涵及其流变历程。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	404
764	特种设备基础知识	9787561085653	9787561085653	辽宁省安全科学研究院 	\N	2-1	16开	75.00	\N	辽宁大学出版社	\N	\N	\N	2017-04-01	/book/c391ea99-0356-4742-91d4-642b644d89309787561085653.jpg	《特种设备基础知识》为 《特种设备Ⅰ、Ⅱ级无损检测人员培训教材（第2版）》之一，本书是面向辽宁省乃至全国无损检测人员掌握特种设备基础知识的必备培训教材。主要内容包括金属材料基础知识、金属焊接工艺基础知识、热处理基础知识、锅炉基础知识、压力容器基础知识、压力管道基础知识、气瓶基础知识、起重机械基础知识、游乐设施基础知识、客运架空索道基础知识、特种设备相关法规与标准等内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	704
770	精进之路	9787561091173	9787561091173	毛宏伟 	\N	1-1	16开	68.00	\N	辽宁大学出版社	\N	\N	\N	2019-12-01	/book/922b4dd8-9674-449e-9327-d8a79e9335969787561091173.jpg	本书作者通过自身管理的经验和心得，用小故事和精简的文字，阐述了人生的道理，让人们通过阅读产生奋进的力量，带给人们正能量，解除困惑，让人们能够通过阅读，解决内心的迷茫，让人缓解压力，让人们在生活中遇到的种种困难得到解答。作者每天忙于管理企业，还笔耕不断，通过真实的亲身体验，解决生活和工作中的难题，并把心得和经验写出来，给人们启迪，小故事作为导引，引发深入的思考，得出详实的人生道理。激发人们的潜能，让人们不再迷茫，对生活充满热忱，积极进取的去迎接新的生活。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	541
771	英语写作	9787561036044	9787561036044	杨俊峰 	\N	2-1	16开	15.00	\N	辽宁大学出版社	\N	\N	\N	1999-10-01	/book/caa0f1a5-b2ea-495d-a24e-71779c2155589787561036044.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	645
772	大学生职业发展研究	9787569800777	9787569800777	逄晓娟 	\N	1-1	16开	38.00	\N	辽宁大学出版社	\N	\N	\N	2020-09-01	/book/55851abf-f50c-4c2f-9d35-d438106c616e9787569800777.jpg	本书从大学生综合素质的内涵要求出发，以职业生涯教育为突破口，以学生职业发展为主线，以职业能力和倾向为切入点，以真实的职业环境为背景，研究大学生如何在树立正确的人生观和价值观的基础上，合理确定适合自己的职业发展目标和方向。阐述了认知个人兴趣、性格、能力和价值观的内涵及其与职业发展的关系，深入认知职业环境、类别及其发展态势，提出以应用型人才培养为导向，坚持大学生职业生涯规划与人才培养模式研究相结合理论。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	248
773	博物馆品牌传播研究	9787569805710	9787569805710	孙晓钟 	\N	1-1	16开	38.00	\N	辽宁大学出版社	\N	\N	\N	2021-10-01	/book/9e730512-91f8-4e67-889a-a0fbe3456d579787569805710.jpg	文化自信是一个民族、一个国家对自身文化价值的充分肯定和积极践行，并对其文化的生命力持有的坚定信心。沈阳博物院充分发挥旗下文博场馆的能动性，全方位展现四大文化自信：考古文化、清文化、民国文化、红色（抗战）文化，以满足市民不断提高的文化需求。沈阳博物院为如何讲好文物故事，让优秀传统文化“活”起来，在公共普及上“创”出来，从而提升文化自信、增强城市影响力，努力为最广大的人民群众提供多样化多层次的文化产品与服务做了积极探索，并取得了一定成效。本书系统梳理了沈阳博物院自建院以来在品牌营销方面做的一些工作，阐述了博物馆在品牌定位、社会宣传方式方法上的一些思考，对做好博物馆品牌营销具有很强的借鉴意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	979
774	辽宁省农家书屋社区书屋管理员工作手册	9787561085608	9787561085608	辽宁省新闻出版广电局 	\N	1-1	16开	38.00	\N	辽宁大学出版社	\N	\N	\N	2017-04-01	/book/63199849-55f8-4358-980c-cabea56c1dbc9787561085608.jpg	农家书屋工程是社会主义新农村建设的文化工程，是缩小城乡文化差距、实现公共文化服务均等化、保障农民群众基本文化权益的必然要求，也是提高农民科学文化素质、传播社会主义先进文化的重要平台。本书从农家书屋管理的最基础知识谈起，立足于农家书屋管理的实际，对农家书屋基本知识、农家书屋建设必备的条件、管理员必备的常识、农家书屋的业务工作、农家书屋的分析与展望进行了比较深入具体的的阐述。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	730
775	怎样处理农村选举权纠纷	9787561092781	9787561092781	王璐瑶, 杨舒涵, 张诗洋 	\N	1-1	16开	18.00	\N	辽宁大学出版社	\N	\N	\N	2018-12-01	/book/8efe8d51-45c2-433d-a759-1cc9f524f2c79787561092781.jpg	本书未出版。以设问方式提出农村选举中常见的法律问题并依据现行法律法规给予精准的解答，同时结合实际案例，以浅显通俗的语言阐述相关法律知识，从而引导农民朋友在选举活动中，严格遵守选举法，正确运用法律，维护自身的合法权益。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	948
776	满族文学史第一卷	9787561067116	9787561067116	赵志辉 	\N	1-1	16开	37.00	\N	辽宁大学出版社	\N	\N	\N	2012-10-01	/book/30572fa9-cb4f-4bc8-96f7-463b890865229787561067116.jpg	作为《中国少数民族文学史丛书》中的一本，讲述了各时期满族文学的发展与概述。包括诗歌、散文、戏剧、文人作品等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	147
795	清末民初社会主义在中国的传播	9787567634824	9787567634824	王先俊 著 	\N	1-1	16开	99.00	\N	安徽师范大学出版社	\N	\N	\N	2020-09-01	/book/16df9cce-705a-48b0-8b55-f06732fc5f539787567634824.jpg	本书力图在社会主义传入中国的历史语境下，介绍在西学东渐的大潮中国人如何初识社会主义，分析资产阶级维新派、资产阶级革命派、无政府主义者、清末留日学生等不同群体与社会主义传播的关系，厘清中国社会主义传播史的脉络进程，揭示清末民初社会主义传播的基本特征和历史地位。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	570
785	电工电子基础课程基础实验教程	9787567627277	9787567627277	喻其山 主编 	\N	1-1	16开	35.00	\N	安徽师范大学出版社	\N	\N	\N	2018-01-01	/book/ef4a021f-a36f-4683-a750-5df3ce52cc049787567627277.jpg	本书是在借鉴了已有电工与电子类课程的相关教学和研究成果的基础上，结合多位作者长期从事电工与电子类课程的相关教学工作，以及他们多年为本科学生开展实验教学取得的经验基础上编著而成。主要内容包括：第一章是通用实验仪器的使用方法；第二章是电工技术实验；第三章是电路分析实验；第四章是模拟电子技术实验；第五章是数字电子技术实验。本书理论与实践紧密结合，以实验为主。全书内容丰富、适应面宽，既具有很强的可读性和可操作性，又可以使读者在阅读和实践中掌握相关理论知识和实验技能。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	575
777	法治视域下的营商环境问题研究	9787569805178	9787569805178	杭冬婷 	\N	1-1	16开	36.00	\N	辽宁大学出版社	\N	\N	\N	2021-09-01	/book/c2c68ab5-effc-4047-802c-0004870469eb9787569805178.jpg	构建法治化的营商环境，是解决我们面临的经济社会问题的重要抓手，是国家和社会发展的软实力，对强国建设及法治化国家建设都具有非常重要的时代意义。本书内容为法治视域下的营商环境问题研究，主要从法治的角度深入研究营商环境问题，主要阐明以下五个方面问题：一是深入分析阐释营商环境的内涵，营商环境是指对市场主体的生产、经营产生影响的各种条件和状况的总和，既包括物质因素，也包括非物质因素，法治环境即为非物质要素。二是深入分析阐释法治环境的内涵，法治环境主要指法律、政策的制定和执行情况对市场主体的影响等，市场经济本质上是法治经济，法治是影响一个地方营商环境的重要因素。三是深入分析阐释法治视域下营商环境建设取得的主要成绩。四是深入分析阐释法治视域下营商环境存在的主要问题。五是深入分析阐释优化法治视域下营商环境的具体对策建议。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	526
778	基层社会治理理论与实践研究	9787569804218	9787569804218	何艳波 	\N	1-1	16开	46.00	\N	辽宁大学出版社	\N	\N	\N	2021-07-01	/book/b782f294-e719-49ea-b235-a4a36229eb5a9787569804218.jpg	基层是社会治理的基础和重心，对维护整个社会的和谐稳定起着基础性的作用，而如何加强和创新基层社会治理，打造共建共治共享的社会治理格局，是新时代坚持和发展中国特色社会主义的一项重大任务，也是推进国家治理体系和治理能力现代化的题中之意。本书秉承“夯实理论基础、勇于实践创新”的科学发展理念，主要围绕加强和创新基层社会治理的基本理念、基层社会治理的体制机制、基层社会治理的矛盾和问题化解、基层社会治理的创新实践与路径、基层社会治理的创新模式、基层社会治理的人才保障、基层社会治理的文化建设等基本要求和实践创新展开，对我国基层社会治理理论与实践进行了总结、归纳、分析与提炼。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	570
779	论幽默文本翻译——以儿童文学《汤姆索亚历险记》为例	9787569805987	9787569805987	田东琰 	\N	1-1	16开	36.00	\N	辽宁大学出版社	\N	\N	\N	2021-12-01	/book/036e044f-a953-4b42-8757-74cf365aba0b9787569805987.jpg	幽默是一种普遍的社会现象，出现在各种文学体裁中。言语幽默概论被认为能够从系统和结构上分析幽默。本书将依据该理论，对《汤姆·索耶历险记》和英译本的幽默翻译进行比较研究，这是一种创新的研究视角。本书通过创立的英汉平行语料库，对比原著与译者，即原作者如何实现幽默的效果，译者通过哪些翻译策略处理原著幽默，译者的译文是否忠实于原文。本书尝试为言语幽默概论提供重要的实证支持。具体的研究意义如下：1.如果幽默语段属于规范化类型，则可以传达完整的幽默语义。否则，它无法表达完整的幽默语义。2.脚本对立参数是被视为文本幽默的充分充要条件。3.两个笑话（幽默语段）的相似性取决于它们共同的参数数量，这也适用于较长的幽默文本。4.作者使用了多种修辞表现幽默的效果，例如讽刺，夸张，典故，暗喻，拟人与明喻，等等。这些修辞手段的使用情况，是幽默文本的特殊规律。5.同类幽默转换模式可以较好地保留原作的幽默效果，但还是存在幽默效果缺失的情况，具体有六大因素要注意。6.在张友松译本中，译者使用了儿话词、口语词汇、押韵、叠词等方式来处理原著幽默效果，这对儿童文学的翻译提供了重要借鉴与参考价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	306
780	文化符号生成机制研究	9787569806045	9787569806045	李帅 	\N	1-1	16开	48.00	\N	辽宁大学出版社	\N	\N	\N	2021-12-01	/book/a708ff18-788c-4001-99e6-931a71c730cf9787569806045.jpg	本书为辽宁社会科学院的项目结项成果。作者从文艺学学科角度切入到文化符号生成机制的研究，从文艺理论与批评的视角观察辽宁文化符号生成的现状、成果、问题、原因以及对策，但更多的是剖析文化运行的内部肌理。文化符号是区域文化和民族文化的独特标识，它既来自于文化基因的传承与变异，也来自于历史变迁过程中不同文化因素的交流与融合。它是时间和空间坐标定位中的产物。但目前学术界对文化符号的研究主要集中在从电影、绘画、小说等文艺作品中提取的地域文化和民族文化符号，或者基于文化创意产业视角对作为特定企业品牌标签和产品形象的符号化研究。而对辽宁地域文化符号的研究还没有得到足够的重视，区域和民族文化符号的历史溯源和现状整合也有待进一步探讨。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	192
781	新时代基层公共管理实践研究	9787569804881	9787569804881	朱丽英 	\N	1-1	16开	40.00	\N	辽宁大学出版社	\N	\N	\N	2021-08-01	/book/fd4f2da6-264c-410a-a374-613b726ca06c9787569804881.jpg	中国特色社会主义进入新时代，我国在推进国家治理体系和治理能力现代化方面进行了一系列重大实践创新，积累了大量公共管理实践新经验。“十四五”时期，地方政府要适应经济发展新常态，脱困解难，最根本的是走出发展新路子。本书以地方政府发展与改革为研究视点，从公共管理基本理论和政府实践创新两部分展开，主要对新时代基层公共管理实践领域进行系统研究和实践探讨，贯彻党中央精神、研究省情、市情，力求做到求真务实、精雕细刻、取长补短。目的在于提升政府效能，促进经济社会全面进步，展现新时代公共管理理论与实践取得的伟大成就。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	964
782	月是故乡明	9787569805963	9787569805963	马喜军 	\N	1-1	16开	60.00	\N	辽宁大学出版社	\N	\N	\N	2021-11-01	/book/71b2dd3d-7fa7-462d-a2b5-4d6bf66b0db19787569805963.jpg	本书是作者多年来从事诗歌、散文等文学创作的精粹的集合。本书收录了作者2020年以来创作的200多首现代汉语新诗，主要是歌颂家乡、描写家乡、怀念家乡和赞美亲情爱情的内容。作者的所见、所闻、所历、所思、所想都从诗里轻轻地飘过。诗句优美、朴素、亲切、真诚和热烈，显现出一种灵魂的欢呼和震颤。每首诗都是从作者心灵深处流出的小溪。诗集通篇充满着热爱家乡的朴素而又美好的情怀，充满正能量。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	637
783	刘学锴文集	9787567649705	9787567649705	刘学锴 余恕诚 著 	\N	1-1	16开	630.00	\N	安徽师范大学出版社	\N	\N	\N	2020-12-01	/book/4d5fcbcc-5402-488a-9fff-0a1a75e8a0269787567649705.jpg	本书收录了李商隐存世各体文章共三百五十二篇。作者将清人冯浩《樊南文集详注》（八卷）与钱振伦、钱振常《樊南文集补编》（十二卷）合为一编，并增入从《后村诗话》中辑出之两赋（《虎赋》《恶马赋》），在前人考订补笺基础上，进一步做了系年考证、校勘、笺注，改分体编次为编年，撰成此书。全书在最基本的文献层面为李商隐文研究廓清榛莽,且多有新见,“其有功于李商隐研究乃至于整个唐代文史研究者实在多多”。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	814
786	汉字与中国文化教程	9787567637160	9787567637160	詹绪左 朱良志 著 	\N	1-1	16开	39.50	\N	安徽师范大学出版社	\N	\N	\N	2018-08-01	/book/612ec194-2024-4289-a838-fe22045264199787567637160.jpg	汉字涵容着中国文化的意蕴，在文化的传播中发挥着重要作用，并随着中国文化的发展不断增加着自身的文化容量。本书从中国文化的角度审视汉字的象征意味，弘扬民族文化传统。从汉字本身的特点、属性、功能多方面，探讨了汉字中蕴藏的中国文化，以及汉字对中华民族的心理结构的深刻影响。以汉字作为文化确证、生命符号、文化镜象等作为切入点，论述了汉字与中国古代的衣食住行、民俗文化、中国文学意象创造、中国人的思维方式之间密不可分的联系。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	255
787	祁门红茶史料丛刊	9787567646001	9787567646001	康健 主编 王世华 审定 	\N	1-1	16开	86.00	\N	安徽师范大学出版社	\N	\N	\N	2020-06-01	/book/6ee1c828-5906-4955-a707-98495dfbeee29787567646001.jpg	《祁门红茶史料丛刊》是首次系统、全面的祁门红茶史料整理，对涉及祁门红茶史料的近代报纸、杂志、方志、调查报告、官方档案、民间文书等资料进行地毯式查找，同时通过田间调查等途径，系统搜集、整理，爬梳出300余万字，基本涵盖了各种典籍中的祁门红茶史料。 丛书中主要收录了19世纪中期至1949年之间的祁门红茶史料，由八册组成，系统展示了近百年祁门红茶的起源、发展、兴盛、衰落以及生产加工、运输、销售等方方面面的内容。 此丛书的出版填补了祁门红茶史料整理的空白，为从事历史学、茶学和文化产业等领域的研究者提供了丰富的史料；为徽学研究、区域史研究开拓了一个新视角；更使祁红的渊源、底蕴更为世界所了解，让祁门红茶不仅仅作为一种商品，更是作为一种文化而享誉世界。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	985
788	徽商·徽州·族谱——明清家训研究：明清徽州家训研究	9787567637078	9787567637078	陈孔祥 著 	0	1-1	16开	75.00	\N	安徽师范大学出版社	\N	\N	\N	2021-03-01	/book/faf620df-1a23-4c0b-aa0c-309fadd652ba9787567637078.jpg	本书是关于明清徽州家训的研究，由安徽师范大学陈孔祥教授著。本书主要内容包括以下部分：第一章 明清时期徽州家训研究概说 ，第二章 明清时期徽州家训的发展脉络，第三章 影响明清时期徽州家训的主要因素，第四章 明清时期徽州家训的主要内容，第五章 明清时期徽州家训的功能与实践路径，第六章 明清时期徽州家训的影响，第七章 明清时期徽州家训的经验与局限。本书从多个方面对明清徽州家训进行研究，角度全面，内容深入，是一部严谨的学术著作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	391
789	主编教你怎么教《逻辑与思维》教师用书	9787567652118	9787567652118	王习胜 主编 	\N	1-1	16开	60.00	\N	安徽师范大学出版社	\N	\N	\N	2021-08-01	/book/de511195-5762-4787-b14f-2cd48946b86d9787567652118.jpg	为帮助教师在“逻辑与思维”教学中存在的亟待解决的教学设计方面的技术层面的问题编写本书，以期待与广大一线教师共同努力，把“逻辑与思维”课程讲好讲透，让广大中学生真正受益，真正实现党和国家设置这门新课程的教育教学目的。《主编教你怎么教：逻辑与思维教师用书》本着“少而精”“讲管用”的原则，主要针对教师备课和讲课中的困难而设置“课标链接”“重点难点”“教学设计”“疑难解答”四个板块，重心在“教学设计”，对每个框题的内容都严格按照最新的教学设计版式要求进行了规范性展示，以期对广大一线教师有所帮助。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	495
790	《力冈译文全集》	9787567632943	9787567632943	力冈（1926—1997） 	\N	1-1	16开	2,298.00	\N	安徽师范大学出版社	\N	\N	\N	2018-01-01	/book/35d0224b-b413-4a97-b5d5-5aa29d5b9a5e9787567632943.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	848
791	安徽师范大学文学院学术文库（第一辑	9787567645196	9787567645196	蒋立甫 著 	\N	1-1	16开	58.00	\N	安徽师范大学出版社	\N	\N	\N	2021-01-01	/book/466cfe8a-20ca-4033-94d7-dd082377b6a09787567645196.jpg	本书收录作者在先秦文学研究方面的众多学术成果。既有普及古代文学读本基础知识的篇幅，又有专门探讨先秦文学研究的学术成果，尤其以《诗经》《楚辞》《左传》为中心，逐一予以标点、校刊、考证、注释，系统讨论当时作者、作品、言语等所呈现的文学特质，其模式与证据值得后学揣摩。本书雅俗共赏，初学者与研究者均可从中获得启迪。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	114
792	两晋南北朝隋唐婚姻制度研究	9787567637795	9787567637795	陈娟 著 	\N	1-1	16开	45.00	\N	安徽师范大学出版社	\N	\N	\N	2021-05-01	/book/f5f8a942-2698-4ce3-9e73-0e1c2382dde09787567637795.jpg	本书以我国古代婚姻制度的发展变化为研究对象，前言概述婚姻的本质、形态以及我国古代婚姻制度的形式类别，然后详细研究两晋、南朝、北朝、隋朝、唐朝婚姻方面的继承与变化，特别梳理了我国古代“士庶不婚”“门第婚姻”“财婚”等特定婚姻的来龙去脉，从而对我国古代婚姻制度予以审视，批判夹杂其中的门第、敛财、殉葬等落后观念，褒扬繁衍生殖、情感交流、美好追求等积极方面，对我国的婚礼、婚俗予以批判继承，引导读者予以正确认知。本书发展与丰富中国魏晋南北朝隋唐史中婚姻方面的研究，可供历史和文学的研究者、爱好者阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	338
793	发现徽州——徽学资料整理与研究	9787567643512	9787567643512	邵宝振 著 	\N	1-1	16开	69.00	\N	安徽师范大学出版社	\N	\N	\N	2021-01-01	/book/787fa1bb-a084-4af7-b744-9595abd379d09787567643512.jpg	本书对徽州的商业、宗族、民俗、人物、艺术与收藏等方面的资料进行了整理与研究，对打造徽学文化品牌、弘扬中国传统优秀文化具有重要价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	861
794	中华法文化中天人合一教育理念的重构	9787567635784	9787567635784	余俊 著 	\N	1-1	16开	53.00	\N	安徽师范大学出版社	\N	\N	\N	2021-01-01	/book/7461a7b7-f093-4d49-b7d3-8f73dff153089787567635784.jpg	本书从分析中华法文化中的天人合一教育理念的内涵及发展入手，在研究了中国古代天人合一教育理念对传统制度文明各个方面的影响后，指出了在“西法东进”过程中这一思想所遭受的冲击和境遇。在对传统的中华法文化中天人合一教育理念的内涵进行现代转化的基础上，彰显了其对当前立法、执法、司法以及法治教育所具有的价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	136
796	现代职业教育师资培养研究	9787567646919	9787567646919	汤霓 著 	\N	1-1	16开	58.00	\N	安徽师范大学出版社	\N	\N	\N	2020-11-01	/book/1c9bae98-b60a-489d-8ba3-e3d9a14fbdcd9787567646919.jpg	本书以职业教育师资培养为研究对象，旨在为职业教育师资培养这一研究领域提供一定的理论贡献和实践贡献。先提出职教专业教学知识（VPCK）这一新的理论工具，作为“职教师资培养的分析框架”，然后分别对国外职教师资的培养进行呈现和分析，对职教师资培养的基本经验与规律进行总结，重点分析我国职教师资培养的发展策略，将我国职教师资培养的特色概括为政府为主导、项目化培养体系、基本要素相互独立，最终构建我国职教师资培养的理想模型。可供职业教育研究者和工作者阅读使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	750
847	巡游大海——舰船武器	9787561258187	9787561258187	田战省 	\N	1-1	16开	58.00	\N	西北工业大学出版社	\N	\N	\N	2021-12-01	/book/6c3e696f-6553-4d9b-95fd-efacad81ff8a9787561258187.jpg	本书采用图文结合的形式，向读者展示了各种军用和民用船只的基本概况和技术水平，包括舰船的发展历史，民用船只的类型，军舰的结构、动力、舰载设备和世界著名的军舰型号，以及海上航行的基本知识等。书中内容编排科学合理，知识点清晰明确，还特别设置有不同格式的小栏目版块，可以带领读者系统地了解舰船的发展历程，以及现代舰艇的知识和技术水平。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	392
797	空中隐约的耳语	9787567636620	9787567636620	邹贤尧 著 	\N	1-1	16开	58.00	\N	安徽师范大学出版社	\N	\N	\N	2020-11-01	/book/0360716a-8d35-4156-9575-8a72b9644fb49787567636620.jpg	本书收录作者近年创作的十五篇小说：《爱传导》，时代兴替，爱在一代代传递；《深呼吸》，遭遇“非典”，困境中突围与希望；《献给旅鸽》，生态伦理，濒危动物在需求保护；《空中隐约的耳语》，燃情岁月，那是青春在夜空弥漫；《中文系》，高校往事，学人内心有坚守与高地；《文学史》，互文叙事，古今文人有侠骨柔肠；《与杨贵妃有关》，从战争到和平，萦绕不去的传说与回忆；等等。小说题材涉及都市、乡土、校园、社会、爱情、生态、哲理、记忆等，内容有一定创意，形式有一定创新，内涵有一定深入。供文学研究者探索，评论者鉴赏，爱好者阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	698
798	中学文学审美教育论	9787567645943	9787567645943	程海滨 著 	\N	1-1	16开	49.80	\N	安徽师范大学出版社	\N	\N	\N	2020-08-01	/book/518f8093-5069-42e2-b792-48bc24ec485c9787567645943.jpg	本书以中学文学课教学为研究对象，以王国维的“入乎其内”“出乎其外”为理论依据，在文学教育中，培养学生的审美感悟能力、审美鉴赏能力以及审美批评能力；在审美鉴赏与审美批评、审美判断与价值判断的二元生成关系中，切实提升学生的思维品质、审美情趣和价值判断能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	520
799	中国·飞行·影像	9787512431423	9787512431423	王亚男 	\N	1-1	16开	158.00	\N	北京航空航天大学出版社	\N	\N	\N	2020-03-01	/book/d8bd2d2d-22a1-4f08-af4e-9438e535bc729787512431423.jpg	本书是著名航空航天科普专家、《航空知识》杂志主编王亚男先生的著作。“敦煌飞天”至当代航空，该书钩沉中国千年飞行历史，主要按时间顺序，以中国飞行史实为切入点，辑入百余幅珍贵历史照片。始自1500s明朝万历年间的风筝，讲述了中国人在飞行道路上的跋涉历程；侧重介绍了中华人民共和国成立后中国航空及“人民空军”的伟大成就，堪称有故事的图片、有温度的历史，在国内航空图文书中是一部不可多得、值得珍藏的精品。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	948
800	月宫日记	9787512431454	9787512431454	“月宫一号”团队 	\N	1-1	32开	78.00	\N	北京航空航天大学出版社	\N	\N	\N	2020-08-01	/book/37f04f65-b82a-42b1-852c-e4093a1858389787512431454.jpg	“月宫365”实验是世界上时间最长、闭合度最高的模拟人类在外太空长期生存的密闭隔离实验，《月宫日记》记录了“月宫365”实验期间，舱内实验志愿者们的工作和生活，舱外“月宫一号”团队的风采，忠实地记录了入舱、换班、出舱的重要时间节点及其在国内外产生的影响，并跟踪后记到出舱一周年。《月宫日记》主要以志愿者视角，从多方面介绍“月宫一号”的原理和“月宫365”实验，为读者生动地揭开了“月宫”的神秘面纱。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	727
801	赛博物理系统工程建模与仿真	9787512436084	9787512436084	[美] Saurabh Mittal，[美] Andreas Tolk 编，高星海 译 	\N	1-1	16开	169.00	\N	北京航空航天大学出版社	\N	\N	\N	2021-10-01	/book/ab9a1699-7ebf-4a5e-8d27-e4f26ee461689787512436084.jpg	本书面向赛博物理系统(CPS)的智能、自主和适应的复杂性特征,聚焦建模与仿真(M&S)技术 在基于模型的工程、基于仿真的工程等方面的研究成果,广泛汇编并综述近年来国际上多个政府组 织、研究团体的相应的文献和验证项目,面对被广为关注的智慧城市、自主驾驶、复杂防务体系等多个 应用领域,详细阐述 CPS工程中 M&S技术的领先应用模式;同时,就普适性解决方案中共享的概 念,如 CPS统一本体架构、自主系统协同仿真框架、自主系统架构、复杂系统强韧性测度以及社会系 统演进等,提出了卓有建树的开放性研究思路和探索方向,从而激发读者对 M&S的研究兴趣,并将 其应用于CPS工程的技术与管理流程中,使本书成为基于模型的系统工程(MBSE)中应用先进 M&S 技术和方法的一站式参考,从而为工程领域提供领先的设计和评估能力发挥重要的作用。 本书适合从事复杂组织体系和先进工程系统开发方法研究的学者,以及系统架构师、系统工程师 等从业者阅读;可作为系统工程大学教育中复杂系统设计分析的专业课程的教材,也可作为其他专业 课程扩展领域的参考书,如针对计算机科学的人工智能和赛博安全、电子工程和控制工程的嵌入式实 时系统、机械工程的现场制造系统等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	320
802	FPGA设计与验证	9787512431294	9787512431294	梅雪松，袁玉卓，曾凯锋 	\N	2-1	16开	79.00	\N	北京航空航天大学出版社	\N	\N	\N	2021-03-01	/book/cb10a728-98a3-43ef-b10e-40a2a28bd9329787512431294.jpg	本书以Intel CycloneⅣ E系列FPGA 为例,系统介绍了FPGA 的硬件结构、电路设计以及逻辑设计和验证流程。书中以若干个具有工程实用意义的案例为背景,详细介绍了FPGA 数字逻辑设计中常见的功能模块设计思路、FPGA 片上资源的使用方法、开发软件中各种调试工具的使用，包括SignaltapⅡ、In System Sources and Probes Editor、In System Memory Content Editor。本书最后通过若干个综合性实例,讲解了复杂数字系统的设计方法和验证思路。作为实用型FPGA 教程，本书的每一个实验都有完整的仿真和验证过程,即强调了仿真验证在FPGA设计中的重要作用。 本书可作为工程应用类、电子信息类专业本科生以及相关专业专科生的EDA 基础类课程的教材；也可作为FPGA自学人员,以及从事FPGA开发的工程技术人员的培训教材和参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	324
803	航空工程材料（第2版）	9787512427150	9787512427150	陈海英 	\N	1-1	16开	38.00	\N	北京航空航天大学出版社	\N	\N	\N	2018-08-01	/book/1c6227ca-6923-4e09-9f7a-9a3d3d1197df9787512427150.jpg	本书分为两篇,第一篇是工程材料基础知识,共3章,包括工程材料的主要性能、金属材料的基础知识、 钢的热处理;第二篇是常用工程材料及选材,共6章,包括铁合金与高温合金、有色金属及其合金、高分子材 料、复合材料、其他航空材料和零件的失效与材料的选择。每章后面都附有小结、习题,便于学生复习和巩固 所学知识。 本书是高职高专院校航空制造类、航空机电类、航空材料类专业用教材,也可作为航空工程技术人员、飞 行器维修人员和地勤人员的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	351
812	飞机机械系统实训	9787512435452	9787512435452	刘清杰 丁昌昆 	\N	1-1	16开	29.00	\N	北京航空航天大学出版社	\N	\N	\N	2021-08-01	/book/5281f3d3-8671-4a0c-9525-7f8a24e1cff39787512435452.jpg	本书主要介绍飞机的紧固件的拆装和保险,管路系统的安装与检查,操纵钢索的拆装与检查,轴承的拆 装与维护,油脂、滑油和液压油,胶接,密封与腐蚀,还介绍了飞机的结构维修与钣金加工。书中内容着重于民 航维修实际,主要突出了飞机机械系统的管道检查与维修、钢索检查与维修、保险及常用紧固件、腐蚀检查与 防腐处理、密封胶与胶连接操作与质量检查等实际维修操作;同时在每章后都留有思考题,以帮助巩固知识。 本书可作为高等职业技术院校飞机机电设备维修等专业课程的教材,也可作为从事飞机维修新员工培 训的参考教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	460
805	Python程序设计（微课版）	9787512433014	9787512433014	张婷婷 	\N	1-1	16开	49.00	\N	北京航空航天大学出版社	\N	\N	\N	2020-08-01	/book/f7da0217-c26c-4b78-9cba-114555c76f349787512433014.jpg	Python作为近年来最热门的编程语言之一,语法简洁、易读性强,成为大多编程初学者首选的入门语言。 目前Python已被广泛应用于自动化脚本、Web开发、游戏编程、科学计算、数据分析、人工智能等众多领域。 本书从初学者的角度出发,基于Python3.8版本,以通俗易懂的语言和清晰明了的结构,系统、全面地讲 解了Python基础知识,包括Python的发展历程、安装与帮助文档、基础语法、数据类型和字符串、流程控制、 列表、元组和字典、函数与模块、异常、文件与数据库操作、网络连接以及面向对象编程的基本概念,并以一个 完整的游戏实践《抵御外星人》(第12~14章)结尾。各章配有大量的学习案例和重点、难点教学视频,读者可 以边学、边听、边练,在实践中增强对知识的理解程度和实际编程能力。 本书既适合作为高等院校计算机等相关专业的Python课程教材,也可以作为Python基础培训和编程爱 好者的培训教材或自学参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	177
806	体育俱乐部的经营与管理（第3版）	9787512424593	9787512424593	刘平江 	\N	1-1	16开	28.00	\N	北京航空航天大学出版社	\N	\N	\N	2017-08-01	/book/05ef7ed0-b423-40eb-a304-2f2a7dcdf4d99787512424593.jpg	本书旨在通过对体育俱乐部的概念、起源、意义、特征、管理和经营等基本概念和基本原理的介绍,结合我国体育俱乐部的现状及体育俱乐部的发展趋势,使学生正确认识体育俱乐部的功能,掌握体育俱乐部管理与经营的运作程序、方法和手段,提高体育俱乐部管理的意识和能力,学会经营体育俱乐部的方式方法。同时,通过大量的案例分析和评述,加强理论与实践的联系,提高学生的实践意识和分析能力。本书涉及的俱乐部分为营利性体育俱乐部和非营利性体育俱乐部,内容主要包括:职业体育俱乐部的经营与管理、健身体育俱乐部的经营与管理、青少年体育俱乐部的经营与管理、社区体育俱乐部的经营与管理和体育俱乐部的财务管理。本书可作为普通高等学校体育及其他相关专业的教材以及社会体育工作者的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	466
807	画法几何	9787512433304	9787512433304	刘静华 	\N	1-1	16开	29.00	\N	北京航空航天大学出版社	\N	\N	\N	2020-09-01	/book/c683a108-3fe1-4eba-9f96-aab3ec47deea9787512433304.jpg	本书根据教育部提出的“面向二十一世纪高等教育改革”教改项目———“机械基础系列课的教改研究与实践”课题的改革成果编写而成,形成《画法几何》和《机械制图》两本教材。本书主要内容包括空间形体、几何元素的投影及相对位置、投影变换、平面立体、基本旋转体、平/曲面的相交、CSG体素构造法、轴测投影等。 本书可作为高等工科院校机械类专业本科生的专业基础课教材,也可作为其他相关专业学生或工程技术人员的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	308
808	测试信号处理技术（第3版）	9787512430464	9787512430464	王睿 	\N	1-1	16开	79.00	\N	北京航空航天大学出版社	\N	\N	\N	2019-09-01	/book/23cb9cf1-e8c4-4f87-b594-884e682595789787512430464.jpg	《测试信号处理技术（第3版）》是北京市精品课“信号分析与处理”的配套教材，是在《测试信号处理技术》第1版和第2版的基础上重写而成的。《测试信号处理技术（第3版）》共分10章，包括：概论、连续时间信号和系统、连续信号傅里叶变换、连续信号拉普拉斯变换、离散信号与系统的时域分析、离散时间信号傅里叶分析、离散信号与系统的z域分析、滤波器分析与设计、随机信号分析基础、现代信号处理技术。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	856
809	基于MATLAB/Simulink的通信系统建模与仿真（第2版）	9787512424890	9787512424890	张瑾 	\N	1-1	16开	29.00	\N	北京航空航天大学出版社	\N	\N	\N	2017-10-01	/book/a51b0e9b-b6e3-421f-9b75-0f5e1c7e6e829787512424890.jpg	本书以MATLAB R2016a为平台,通过大量的MATLAB、Simulink仿真实例,加深读者对通信系统原理的理解。本书共9章,前8章主要包括仿真思想的引入、MATLAB语言及Simulink仿真基础、MATLAB计算和可视化、信号系统分析基础、模拟信号的数字传输、数字信号基带传输、载波调制、数字信号处理应用等内容。第9章综合篇,提供了通信系统原理仿真、语音信号处理、计算机视觉这三个方向的4个设计项目,供读者在学习前面章节的基础上,对仿真技术加以综合运用。 　　本书中所举的大量实例有助于读者对通信原理及仿真实践的理解,设计项目也提供了必要的程序框架和参考资料,可作为高等院校通信工程、电子信息技术等专业学生的通信仿真课程教材和参考书。本书适合所有MATLAB编程爱好者和使用MATLAB的不同专业大学生阅读，还可供研究生、科研工作人员及高校教师参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	140
810	Introduction	9787512431690	9787512431690	王耀军 	0	1-1	16开	29.00	\N	北京航空航天大学出版社	\N	\N	\N	2021-03-01	/book/38be65a4-e5d8-4290-bbb9-2a3aab6cda7f9787512431690.jpg	本书针对工业机器人技术技能人才培养的需求,以机器人相关专业的英语能力培养为目标,旨在使读者掌握工业机器人专业英语知识,以及机器人技术应现状和发展趋势。全书正文部分由11个单元组成,涵盖了机器人主要概念和技术内容,包括基本定义和知识、机器人的类型和应用、机器人的主要结构、机器人的动力驱动、机器人的信号检测、机器人的控制与编程、机器人末端执行器、机器人运动学和动力学基础、机器人性能指标、机器人安全和伦理、机器人发展趋势和展望;附录部分由7个单元组成,包括科技英语、职业规划和简历撰写、机器人从业人员职业素养、文献检索、讨论和思考、机器人 大观园、生词释义。本书突出了材料的新颖性和资料的趣味性,兼具内容的拓展性,既注重专业能力培养,又融入职业核心能力培育,可作为高职高专机器人相关专业的专业英语教材,也可作为工程技术人员的参考资料和培训用书,亦 可作为科普读物供广大关注机器人发展的读者使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	951
811	电化学原理（第4版）	9787512435834	9787512435834	李荻 李松梅 	\N	1-1	16开	62.00	\N	北京航空航天大学出版社	\N	\N	\N	2021-08-01	/book/1c7f72f2-4714-4b9f-871f-86fe5f16aef39787512435834.jpg	本书主要介绍水溶液电化学的基本原理。全书包括电化学热力学、电极与溶液界面的结构和性质、电极过程动力学、重要的实用电化学过程等几大部分内容,其中基本原理部分重点叙述较成熟的基础理论,实用部分包含了氢、氧电极过程及其电催化、金属阳极过程、金属电沉积过程、化学电源等方面的基础知识。本书可作为高等院校材料科学与工程、电化学工程类专业的教学用书,也可供从事材料物理与化学、电化学、腐蚀与防护、电镀、电解、化学电源和电分析化学等工作的科学技术人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	328
814	物业管理综合能力运用	9787512431447	9787512431447	倪霓 向铮 	0	1-1	16开	36.00	\N	北京航空航天大学出版社	\N	\N	\N	2021-02-01	/book/3377c101-5a32-4a77-8c07-eec49ac745cc9787512431447.jpg	本书是高职高专院校物业管理专业的综合实践教材,系统阐述了物业管理的基本理论知识及其运用。 全书共分为10个项目,分别介绍了管理学基础知识与运用、心理学基础知识与运用、经济学基础知识与运用、公共关系基础知识与运用、法律基础知识与运用、保险基础知识与运用、统计学基础知识与运用、社会学基础知识与运用、建筑工程基础知识与运用以及物业管理智能化系统的运用。 本书适合作为高职高专院校物业管理专业及其他相关专业的教学用书,也适合作为企业相关从业人员的业务自学参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	178
815	城市轨道交通运营管理概论	9787512432994	9787512432994	张秀芳 闫靖 	\N	1-1	16开	39.00	\N	北京航空航天大学出版社	\N	\N	\N	2020-08-01	/book/47ac0d41-a6db-4a53-92f6-034c43c4dcb79787512432994.jpg	本书结合城市轨道交通专业人才培养方案来介绍城市轨道交通运输的运营管理知识,分为理论篇、运作 篇、管理篇。理论篇(项目1~2)主要包括城市轨道交通概述、城市轨道交通的发展概况,城市轨道交通线路、 车站和车辆的基本概念,城市轨道交通的供电系统和机电系统、交通信号和通信系统等设施设备系统的基础 知识;运作篇(项目3~6)主要包括城市轨道交通客流概念和客流分析,城市轨道交通计划和行车图的制定, 行车调度指挥和行车组织,城市轨道交通客运组织和票务管理等基本作业内容;管理篇(项目7~11)主要包 括客户服务管理、网络运营管理、安全管理、人力资源管理、危机公关管理等内容。 为方便教学,本书配有教学资源包,包括电子课件、课后练习题答案以及其他相关教学资源,方便教师 使用。 本 书适合用作高职高专院校城市轨道交通运营管理专业教材,也可供城市轨道交通从业人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	544
816	单片机技术及项目训练(第3版)	9787512433281	9787512433281	赵威 李彬 杨怡 	\N	1-1	16开	42.00	\N	北京航空航天大学出版社	\N	\N	\N	2020-08-01	/book/5694722f-9437-451f-b0e2-522bb9b805bb9787512433281.jpg	本书是四川省省级示范性高职院校———四川航天职业技术学院单片机应用技术教学团队在多年教学改 革经验的基础上,结合最新的高等职业教育改革要求,通过10个学习情境及多个训练项目,系统介绍了单片 机硬件结构、C51语言、单片机中断与定时系统、人机信息交互、单片机串行通信以及单片机系统功能扩展等 内容。本书所有学习情境均先讲解相关知识点,再通过“任务实施”和“能力扩展”培养学生的实践能力,符合 高职教学任务引导、逐层递进的教学方式,具有很强的实用性和可读性。 本书可作为高职高专院校电子信息类、自动化类、机电类等专业的单片机技术课程教材,也可作为单片机 工程技术人员的入门参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	636
817	机械零部件图的识读与绘制习题集（第3版)	9787512433267	9787512433267	刘利军 张玥 	\N	1-1	16开	28.00	\N	北京航空航天大学出版社	\N	\N	\N	2020-08-03	/book/226327ab-df44-4f5d-8021-292fd2ebc5ba9787512433267.jpg	本习题集与《机械零部件图的识读与绘制》(第3版)(ISBN 978 7 5124 3327 4)教材配套使用。为了方便教学,本习题集的编排顺序与教材基本一致,并采用了最新颁布的国家标准。习题集配合教材中各学习情境所需的知识点进行编写,内容包括制图的基本知识、正技影法基础,机械图样以及计算机绘图4部分。各校可根据课程特点和教学要求选做习题。本书可作为高职院校、高等专科学校、本科院校的二级职业技术学院、技师学院及各类培训学校中机械类及近机类专业的教学用书,也可作为相关工程技术人员的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	584
818	Java程序设计任务驱动式教程(第4版)	9787512431249	9787512431249	孙修东 李 嘉 王永红 	\N	1-1	16开	59.00	\N	北京航空航天大学出版社	\N	\N	\N	2020-02-01	/book/3c864913-c43f-4df0-a29f-abfb07f56b119787512431249.jpg	Java是目前世界上流行、优秀的编程语言，它不但赢得了程序员的拥护，也赢得了企业的支持。编程语言的学习是生涩的，本书致力于使读者更轻松、更愉快地进入Java世界的大门。 本书是一线教师长期教学和软件开发实践的经验积累，也是根据学生的认知规律精心组织编写的项目化教程。本书以培养岗位职业能力为主线，按照典型任务序化知识，将知识融入任务情景之中。全书共29项任务，采用行业流行的Eclipse作为开发工具进行讲解，内容主要包括Java开发环境、Java语言基础、面向对象程序设计、GUI程序设计、Applet、异常处理、数据库操作、文件操作、多线程和网络编程等。每个任务都按“跟我做→实现方案→代码分析→必备知识→动手做一做→动脑想一想”的结构组织。最后，通过综合实训，引导学生学习应用Swing界面和JDBC数据库编程技术开发实际应用系统。本书内容丰富，案例经典，知识讲解系统，突出能力培养，易于学习，易于提高编程能力。 本书适合作为高职高专院校计算机及相关专业的教材，也可作为职业培训的教材或自学者的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	157
819	用理论照亮现实——马克思主义哲学中国化的理论思维、研究范式和实践智慧	978-7-5692-8421-8	9787569284218	孙正聿，著 	0	1-1	16开	95.00	\N	吉林大学出版社	\N	\N	\N	2021-06-01	/book/80ba1e84-8e2e-47e0-bcf6-fa01f411b479978-7-5692-8421-8.jpg	本书在回顾和总结马克思主义哲学中国化百年历程的过程中，着力地探索了“问题导向”的马克思主义哲学中国化的理论思维，集中地概括了“守正创新”的马克思主义哲学中国化的研究范式，具体地阐述了“照亮现实”的马克思主义哲学中国化的实践智慧，深入地探讨了构建当代中国马克思主义哲学体系的“使命担当”，努力地展现了马克思主义哲学中国化的理论创新和理论创造。本书比较集中地表达了对马克思主义哲学中国化的理论创新和理论创造的总结和概括。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	108
820	东北亚地区发展报告（2014）	978-7-5692-8304-4	9787569283044	王胜今，主编 	\N	1-1	16开	38.00	\N	吉林大学出版社	\N	\N	\N	2021-05-01	/book/24127ce2-da8d-42e7-b022-c771aa3f8145978-7-5692-8304-4.jpg	《东北亚地区发展报告2014》在整体把握世界经济政治格局变化的基础上，以翔实的数据和准确的语言，对东北亚地区发展进行阐述，共包括总论，东北亚地区政治与外交动态、东北亚地区经济发展动态、东北亚地区人口与社会发展动态、东北亚地区安全局势动态，东北亚地区经济合作发展动态等六个专题内容。其中“总述”部分介绍了世界经济总体形势概述，国际政治形势总体概述，东北亚地区政治与安全形势概述，东北亚地区经济发展形势概述，东北亚地区人口与发展概述等内容。该书作为系列研究成果，具有系统性，全面性，权威性，连续性的特点，对于东北亚问题研究的数据库建设有着重要的意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	944
821	资源、权力与经济利益分配	978-7-5692-6872-0	9787569268720	张屹山，著 	\N	1-1	16开	128.00	\N	吉林大学出版社	\N	\N	\N	2020-12-01	/book/6017f82f-84ae-4545-9cac-c6d825bd5d8c978-7-5692-6872-0.jpg	本书共分十章，主要以权力与经济权力范式、经济权力与企业契约安排、基于权力范式的交易价格理论、商品市场及其交易价格决定、金融市场及其交易价格决定、劳动力市场及其价格决定、政府介入经济活动的理论依据与边界和经济权力结构与生产要素最优配置、制度变迁等内容，从权力的角度探讨了与资源分配相关的各种经济问题，以期建立经济学研究的权力范式。本书内容既有理论上的感悟，又有实践中的体验，可为相关学术人员研究提供参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	473
822	新科技新产业新业态——战略选择与实践	978-7-5692-8363-1	9787569283631	张世彤，史琳，宋微，著 	\N	1-1	32开	50.00	\N	吉林大学出版社	\N	\N	\N	2021-05-01	/book/d39a3687-9398-4c06-ad00-efa5b36ede77978-7-5692-8363-1.jpg	本书在吉林省面临深化改革、深入实施创新驱动，加快发展新经济，不断培育新动能的要求的背景下，客观调查和研究国内外发达地区和吉林省新科技新产业新业态的发展现状及经验借鉴，以吉林省实际情况为基础，分析吉林省新科技新产业新业态发展面临的挑战，并制定出吉林省新科技新产业新业态试验园区的战略选择，实现园区不局限于单一产业集聚、引入贯穿某产业领域技术转移转化等一系列配套产业与服务，顺应多元化、多样化、个性化的产品或服务需求，对加快吉林省不断培育新动能，促进新技术、新业态、新产业蓬勃发展具有重要理论与实践意义，能够调动地方积极性和增强内生动力，形成示范效应。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	259
823	国家教育人力资本投资风险评估体系研究	978-7-5692-8458-4	9787569284584	房国忠，杨成岭，著 	\N	1-1	16开	82.00	\N	吉林大学出版社	\N	\N	\N	2021-06-01	/book/1320f94c-6e40-426d-952f-6fd00605dd1e978-7-5692-8458-4.jpg	本书聚焦当前国家教育人力资本投资问题，运用人力资本投资和风险管理相关理论，从国家层面出发，结合现阶段我国教育人力资本投资中产生的一些现象，对国家教育人力资本投资风险进行识别和评估。书中应用层次分析法确定风险权重，结合多层面不同指标值，构建国家教育人力资本投资风险评估模型，建立国家教育人力资本投资风险评价体系。作者最终通过吉林省数据开展实证评估，对模型进行验证，以期将此模型应用于未来国家教育人力资本投资风险预测，成为国家和地方政府制定教育人力资本投资政策的参考依据。本书构建了一套适合我国国情的国家教育人力资本投资风险评估体系，提出了一些兼具理论性和实践性的管理对策。一方面在理论上延展了教育人力资本投资风险的研究内容和研究方法，丰富了教育人力资本投资相关理论；另一方面可以在实践中充分发挥教育作为一种公共产品或者是准公共产品的特性，真正将教育发展成果落到实处、惠及全体人民，体现了国家治理能力的现代化水平，对于维护社会公平和正义，构建和谐社会具有重要作用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	676
824	杜甫韵文韩国汉诗接受文献缉考	978-7-5677-8951-7	9787567789517	沈文凡，著 	\N	1-1	16开	148.00	\N	吉林大学出版社	\N	\N	\N	2017-02-01	/book/d6456292-fd03-48e5-a6e9-22a960dd9949978-7-5677-8951-7.jpg	本著作立足于第一手文献，钩沉稽引，追求资料翔实赅备、文献集成作用，弥补杜甫韵文在东亚汉诗的接受研究方面的空缺，为学界研究唐诗接受等问题，提供坚实的文献基础，搭建良好的学术平台。为唐代文学与文化在海外的传播及其发展形态的研究，提供重要文献依据。揭示东亚汉诗作者、区域的多种关联，丰富研究视野，具有较高的文献价值、学术价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	123
825	文学经典跨媒介传播的观念演变研究	978-7-5692-8149-1	9787569281491	刘叶琳，著 	\N	1-1	16开	92.00	\N	吉林大学出版社	\N	\N	\N	2021-04-01	/book/5dc12016-ddc7-440a-bec4-747cb6f8597f978-7-5692-8149-1.jpg	文学经典的跨媒介传播，是指文学经典作品的内容和艺术形象在其他媒介形态中的表现和传播，其代表性形式就是文学经典作品的影像化改编创作和媒介化传播运作。本书系统地阐释了文学经典跨媒介传播的概念范畴，全面总结了我国自20世纪初至21世纪的文学经典跨媒介传播的发展历程，对各个历史时期文学经典跨媒介传播的实践理念做了系统梳理，从媒介文化的角度分析文学经典跨媒介传播的观念演变，对文学媒介化审美的经典意识、经典化构建和文化生产传播活动给予论述与评价。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	490
864	陈景润传	9787561580370	9787561580370	沈世豪 	0	1-1	16开	50.00	\N	厦门大学出版社	\N	\N	\N	2021-02-01	/book/c678bb93-50d3-492a-9569-39c79daf7e6e9787561580370.jpg	当代数学家陈景润1949年至1953年就读于厦门大学数学系，1953年9月分配到北京四中任教。1955年2月由当时厦门大学的校长王亚南先生举荐，回母校厦门大学数学系任助教。本书讲述这位在厦大校史上占据重要地位的伟大学者勇攀科学高峰的故事。该书第一版于1994年出版，引起轰动，后数次重版重印，这次增补了至2020年十月前为止的相关信息，对一些事实进行了修订，使其更符合传记求真求新求全的内在规律。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	791
826	19—20世纪法国文学中的中国印记	978-7-5692-8353-2	9787569283532	丁濛，著 	\N	1-1	32开	58.00	\N	吉林大学出版社	\N	\N	\N	2021-05-01	/book/14dd0a5e-60ae-4fe0-9fc7-6279b7cfcf32978-7-5692-8353-2.jpg	19世纪以前，法国汉学研究主要集中在经院哲学、历史、宗教等方面，对中国文学关注较少。自19世纪以来，中国文学与文化开始走进法国学者的视野，尤其一些法国作家亲自来到中国，接触中国，感受中国，他们从中国文学与文化中汲取灵感，创作了大量充满异域情调的作品。本书拟选取朱迪特?戈蒂耶、儒勒?凡尔纳、圣琼?佩斯、波伏娃、克里斯蒂娃等法国作家的作品，从汇通融合的角度研究了中国文化对法国文学的影响，总结了可资借鉴的推动中国文化对外传播的启示意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	634
828	非遗瑰宝——安徽凤阳民歌研究	978-7-5692-8313-6	9787569283136	杨尚翡，著 	\N	1-1	16开	42.00	\N	吉林大学出版社	\N	\N	\N	2021-04-01	/book/29ef4e3c-26e6-4bbb-a6c9-96ed2168fc73978-7-5692-8313-6.jpg	凤阳民歌发源于安徽省凤阳县境内，是当地历史文化发展的一个艺术化反映，具有高度的艺术价值和重要的社会价值，它不仅是我国安徽凤阳地区的音乐艺术代表，我国其他地区的很多民歌在曲种和唱腔方面也都受到凤阳民歌的影响。凤阳民歌在传播过程中受到不同地区文化风格和受众喜好的影响出现了变化，凤阳民歌的跨地域传播和跨体裁传播是我国民歌传播体系中较为典型的文化现象。 本书在对凤阳民歌的音乐特征进行细致剖析以及对凤阳民歌的溯源、发展和传播进行详细论述的基础上提出了多个具有现实意义的观点，其对凤阳民歌的深入研究具有很高的参考价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	870
829	历史上的“中国”与中国历史疆域研究	978-7-5677-9995-0	9787567799950	赵永春，著 	\N	1-1	16开	109.00	\N	吉林大学出版社	\N	\N	\N	2017-05-01	/book/cd35b4b3-6b4d-4906-9871-8e9a6e9a9dfb978-7-5677-9995-0.jpg	本书认为中国古代的“中国”一词，除了具有指称一国之中心的京师、华夏汉族、中原、文化中心等各种含义以外，也用来指称政权。中国古代用“中国”一词指称政权时，存在以“国号”为代表的汉族政权和少数民族政权自称“中国”的情况。也存在几个政权并立之时，地处中原之外的政权常常依据中原即中国的地理观念称占据中原地区的政权为“中国”；当时和后来的“域外”政权（即中国之外的政权）称中国历史上某一政权或有相互递嬗关系的各个政权为“中国”；后来的政权称以前某一个政权或后来的政权在追述本朝历史、议论以前各个朝代时，称历史上以中原地区为主且有相互递嬗关系或没有递嬗关系但为自己政权所继承的多个政权为“中国”等他称“中国”的情况。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	784
830	寻证：东北抗日义勇军代王砬子密营遗址	978-7-5692-6478-4	9787569264784	于化冰，赵聆实，主编 	\N	1-1	16开	91.80	\N	吉林大学出版社	\N	\N	\N	2019-12-01	/book/9fa5e900-c85b-4afb-90fa-d2dc4bce26e8978-7-5692-6478-4.jpg	本书为口述史，是经吉林省吉林市龙潭区东北抗日联军历史资料征集研究项目组两年时间的调查，采访当事人、见证人、知情人50多位，整理、甄选、编撰而成。整部口述史均是围绕在吉林市境内最新发现的东北抗日义勇军代王砬子密营情况展开，通过1位义勇军当事人、3位见证人以及多位知情人的回忆，揭开该处密营的建造年代、使用年代、使用者、使用者去向、遗址性质，以及该处密营的主人有过哪些抗日事迹等等被尘封近80年的历史史实。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	398
831	地壳一号	978-7-5692-4265-2	9787569242652	孙友宏，赵研，许畅，主编 	\N	1-1	16开	68.00	\N	吉林大学出版社	\N	\N	\N	2019-01-01	/book/7216b63b-0c74-4801-896a-757ece669cbd978-7-5692-4265-2.jpg	科学钻探是探索地球深部奥秘和开发地下资源唯一最直接的技术手段，被誉为通向地球深部的“望远镜”和了解地球演化的“时间隧道”。习近平总书记在全国科技创新大会上明确指出：“向地球深部进军是我们必须解决的战略科技问题。”大陆深部科学钻探装备是打开地球奥秘之门的钥匙，代表一个国家的综合实力和科技水平。为满足我国地球深部探测工程的重大需求，在自然资源部、教育部和财政部等部门的大力支持下，吉林大学自主研发了我国首台“地壳一号”超深科学钻探专用装备，突破了多项重大关键技术，填补了我国在深部大陆科学钻探装备领域空白，使我国成为继前苏联和德国之后世界上第三个具备万米大陆科学钻探能力的国家。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	548
832	园艺探要——园艺植物栽培与病虫害防治研究	978-7-5692-8527-7	9787569285277	刘建海，王宁堂，著 	\N	1-1	16开	85.00	\N	吉林大学出版社	\N	\N	\N	2021-07-01	/book/6fd41833-b92d-426e-8144-0697f519efcc978-7-5692-8527-7.jpg	本书属于园艺学方面的著作。由园艺植物基础、园艺植物栽培的影响因素、园艺植物的育种、园艺植物的繁殖与定植、园艺植物的栽培管理、园艺植物病虫害防治基础、园艺植物的病虫害绿色防控技术、园艺植物农药使用及检测等部分组成。全书以园艺植物为研究对象，前部分针对园艺植物的栽培进行了全面的论述，后部分就园艺植物的病虫害防治进行了系统研究。本书对于从事园艺植物研究的学者以及从事园艺植物栽培的相关人员具有一定的学习和参考价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	499
833	萃锦集——文学和翻译研究散论	978-7-5692-8098-2	9787569280982	宁欣，著 	\N	1-1	16开	58.00	\N	吉林大学出版社	\N	\N	\N	2021-03-01	/book/c7c4c222-c1fc-48a2-9058-88e4f1e346ec978-7-5692-8098-2.jpg	本书收录了作者近年来的学术论文和随笔，共计十六篇，大致分为以下五个部分：第一部分主要围绕生态主义、城市空间等理论课题展开；第二部分关乎译介理论和实践；第三部分牵涉莎士比亚研究；第四部分是对一些外国作家的简论及对若干具体作品的细读；最后一部分则是与古典中国文学相关的论述。本书立足于国内外研究视角，以文学和翻译为研究对象，于散论中透射出理智与创新的光芒。该书既可作为文学爱好者的休闲读本，又因其严密的理论特性可飨研究人员。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	192
834	老子	978-7-5677-3359-6	9787567733596	（春秋）老子 著 	\N	1-1	16开	12.00	\N	吉林大学出版社	\N	\N	\N	2015-04-01	/book/5d83a9c5-cb6c-4e74-8c12-7653ba838f1c978-7-5677-3359-6.jpg	本书分为上下两篇，《道经》和《德经》。内容涉及哲学、文学、美学、社会学、伦理学、军事学等许多领域，本书中的智慧源于老子对世事人情的深刻洞察，时局的动荡、社会的不安定、人事的纷争、生命的无常等，这些都深刻地影响到了老子的思想，并且反映在《老子》中。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	227
926	张闻玉文集·文学卷	9787569100662	9787569100662	张闻玉 	\N	1-1	16开	128.00	435.0千字	贵州大学出版社	396	\N	\N	2018-11-01	/book/a7e49672-a77d-425f-92e5-ba8b5e55d8be9787569100662.jpg	本书本书分怀人篇、忆往篇、历史篇、记游篇、书评序跋篇、随笔篇、学诗说诗等部分，是张闻玉老先生文学作品的大集合。作者诗文俱佳，醉心学术，学养深厚。作品构思精巧、情感真挚，文笔流畅、情趣高雅，具有一定的出版价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	399
835	大学	978-7-5677-3360-2	9787567733602	（春秋）曾参，子思 著 	\N	1-1	16开	10.00	\N	吉林大学出版社	\N	\N	\N	2015-04-01	/book/26cf6739-cb45-46cf-ba38-d665e374aa7d978-7-5677-3360-2.jpg	本书是《大学》和《中庸》合集。《大学》是中国古代典籍名篇之一，约为秦汉之际儒家作品。一说曾子作。提出明明德、亲民、止于至善的三纲领和格物、致知、诚意、正心、修身、齐家、治国、平天下的八条目。中庸》的主题思想是教育人们自觉地进行自我修养、自我监督、自我完善，把自己培养成为具有理想人格，达到至善、至仁、至诚、至道、至德、至圣、合外内之道的理想人物。本书在文章后面又一条条加以解读，力求清楚细致地讲解。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	993
836	孙子兵法	978-7-5677-3353-4	9787567733534	（春秋）孙武 著 	\N	1-1	16开	18.00	\N	吉林大学出版社	\N	\N	\N	2015-04-01	/book/2e46b770-c3cf-472e-8590-8692d3891a7a978-7-5677-3353-4.jpg	《孙子兵法》共十三篇，不但对"孙子兵法"进行了选注、翻译、解析，而且还根据每一篇的具体内容，将其分段归纳，并对兵法和智谋配以具体战例，加深少年儿童对中国古代优秀军事思想的理解。同时，《孙子兵法》一书还具有极高的文学价值和哲学价值，是最具代表性的国学经典之一，对此书的编写，力求易读易懂，为广大少年儿童构建一个全面、系统的国学知识体系。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	214
838	资治通鉴	978-7-5677-3337-4	9787567733374	（宋）司马光 撰 	\N	1-1	16开	25.00	\N	吉林大学出版社	\N	\N	\N	2015-04-01	/book/48530f06-4fe9-43da-b390-a1b1630455b8978-7-5677-3337-4.jpg	《资治通鉴》是北宋时期一部编年体通史，共294卷，三百多万字。记载的历史由周威烈王二十三年写起，一直到五代的后周世宗显德六年征淮南，跨越十六个朝代，共1362年的逐年记载详细历史。是我国编年史中包含时间最长的一部鸿篇巨著，在中国史书中有着极其重要的地位。本书在编写的过程中，在保证原文、注释和译文力求准确的基础上，另设置了"词语积累""人物简析""考题举隅""写作点拨"等栏目，还在高考考题方面和写作方面进行了有益的尝试和训练。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	875
839	战国策	978-7-5677-3338-1	9787567733381	（西汉）刘向 编 	\N	1-1	16开	26.00	\N	吉林大学出版社	\N	\N	\N	2015-04-01	/book/d582ac6c-5e70-4718-9081-2d4df1714f2a978-7-5677-3338-1.jpg	《战国策》是中国古代一部著名的国别体史书。主要记载战国时期谋臣策士纵横捭阖的斗争，是我国古代记载战国时期政治斗争的一部最完整的著作，也是先秦历史散文成就最高、影响最大的著作之一。《战国策》实际上是当时纵横家（即策士）游说之辞的汇编，而当时七国风云变幻，合纵连横，战争绵延，政权更迭，都与谋士献策、智士论辩有关，因而具有重要的史料价值。本书在编写的过程中，在保证原文、注释和译文力求准确的基础上，另设置了"词语积累""人物简析""考题举隅""写作点拨"等栏目，，还在高考考题方面和写作方面进行了有益的尝试和训练。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	364
840	礼记	978-7-5677-3347-3	9787567733473	（西汉）戴圣，（春秋）孔子 著 	\N	1-1	16开	21.00	\N	吉林大学出版社	\N	\N	\N	2015-04-01	/book/2afdfb01-8331-4664-b9b6-3ddd6bfa31da978-7-5677-3347-3.jpg	本书是《礼记》和《孝经》的合集。《礼记》是一部儒家思想的资料汇编，是记录中国古代典章制度的重点书籍。《孝经》是中国古代儒家思想的经典著作，集中地阐述了儒家的伦理思想，并且分门别类地对"孝行"进行了诠释和解读，对实行"孝"的要求和方法也作了系统而详细的规定。本书针对初中生的认知水平，依据"贴近学生生活，促进学生成长、指导学生写作"的原则，先后对两本经典著作的章节进行了筛选和编辑，通过翻译和解析等环节，力争让经典走进学生生活，用思想指导学生行动，并同时获得写作上的材料和写作思维的启迪。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	148
841	锻造工艺与模具设计	9787561272374	9787561272374	张金龙 	\N	1-1	16开	55.00	\N	西北工业大学出版社	\N	\N	\N	2021-12-01	/book/facae9bc-a27f-4572-b40d-c5dd37d83a4b9787561272374.jpg	《锻造工艺与模具设计》为西安航空学院应用型本科规划教材，基本内容包括绪论、锻造用材料准备、锻造的加热规范、自由锻造工艺、模锻成形工序分析、锤上模锻、机械压力机上模锻、螺旋压力机上模锻、平锻机上模锻、液压机上模锻、模锻后续工序、特种锻造、锻造工艺的技术经济分析。本书理论联系实际，有较强的实用性。 本书既可作为高等院校模具、材料成形及控制工程、机械类等专业的教材，也可供高等职业学校、成人教育同类专业、有关技术人员及自学者学习参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	280
842	无人机空气动力学与飞行原理	9787561260753	9787561260753	符长青 	\N	1-1	16开	39.00	\N	西北工业大学出版社	\N	\N	\N	2021-12-01	/book/a10dec8d-90d9-40a2-9a08-5a63c1dd225e9787561260753.jpg	本书内容包括大气飞行环境和空气流动的基本规律， 无人机空气动力学教材，翼型及其空气动力，无人机机翼特性、地面效应和增升装置，高速空气动力学基础，固定翼无人机飞行性能分析，无人直升机飞行性能分析，多旋翼无人机性能分析等内容。本书力求理论完善、基本原理清晰、详略得当、重点突出。 本书可作为无人机应用技术专业的教材，也可供无人机领域科技人员、操作人员和爱好者使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	313
843	无人机专业英语	9787561261163	9787561261163	刘肩山 	\N	1-1	16开	39.00	\N	西北工业大学出版社	\N	\N	\N	2021-12-01	/book/736dff1b-26fa-4502-8626-800ed7a424d99787561261163.jpg	本书是根据无人机应用技术专业的发展需求，结合无人机行业发展实际，用英文讲述了无人机组装、调试及无人机考证等内容，如无人机导航、无人机组装与调试、无线电遥控技术、无人机飞手认证等，旨在使读者通过研读的方式掌握无人机应用技术相关的专业英 文词汇和无人机装调及飞行知识。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	664
1298	榆林山地苹果高效栽培实用技术	978-7-5683-0551-8	\N	韩秀涛 	0	1-1	16开	38.00	\N	西北农林科技大学出版社	\N	\N	\N	2018-08-01	/book/f86eb84b-5e9b-4d37-9089-2b69c37ac8521081827.jpg	本书主要介绍榆林山地苹果高效生产栽培管理技术及病虫害防治与农药使用方法，全书共分6章，分别介绍了苹果建园技术，苹果园土肥水管理，苹果树整形修剪、花果管理、病虫灾害防治以及配套技术等内容，附录介绍了果园常用农药。内容通俗易懂，图文并茂，针对性强，适于本市农技人员和广大果农参阅。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	882
845	无人机空域感知与碰撞规避技术	9787561266045	9787561266045	赵春晖 	\N	1-1	16开	78.00	\N	西北工业大学出版社	\N	\N	\N	2021-12-01	/book/39b0017d-cad3-4b8b-aa08-0e686eeb6b609787561266045.jpg	本书总结了相关研究成果，对无人机空域感知与碰撞规避（SAA）技术的发展状况进行了分析，综述了国内外研究现状，然后提出单机和编队SAA技术方案，并给出实验实例，以期能给我国无人机SAA技术的发展积累相应的经验。全书共分为6章，内容包括无人机系统综述，无人机感知与规避的定义，无人机感知、规划、控制的要素，无人机自主跟踪与避障实验系统，多无人机编队防撞控制，等等。本书适合从事相关工作的人员作为参考用书使用，也可供各大专院校作为高年级本科生和研究生的学习教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	235
846	神盾保驾——核能与核武器	9787561264010	9787561264010	田战省 	\N	1-1	16开	58.00	\N	西北工业大学出版社	\N	\N	\N	2021-12-01	/book/0afce072-3409-4771-bbc4-7cfef18795699787561264010.jpg	本书是一本介绍原子核的发现、知识及应用的百科书籍，全面涵盖了与原子核有关的方方面面，包括走进微观世界、核武器横空出世、核电站、身边的核技术、重要的科学家五个部分。全书图文并茂，知识点明确清晰，语言生动有趣，另外还设置了“聚焦历史”、“寻根问底”、“见微知著”三个不同的小栏目，可以大大丰富读者的阅读，扩大读者的视野。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	700
848	简明飞机飞行原理（第2版）	9787561249871	9787561249871	丘宏俊 	\N	1-1	16开	45.00	\N	西北工业大学出版社	\N	\N	\N	2021-12-01	/book/146f8661-f223-44dd-8807-cf7f5597bf9f9787561249871.jpg	本书采用了通俗易懂的语言，紧扣飞机基本飞行原理这个主题，简单介绍了飞机的主要构成及功用，飞机飞行环境；以飞机机翼为基础，重点阐述了飞机的低速空气动力，飞机的平衡、稳定和操纵，飞机的基本飞行和飞机的高速空气动力，简述了飞机的机动飞行和特殊飞行；同时，还分析了螺旋桨飞机空气动力，直升机飞行原理和飞机载重平衡等相关飞行知识。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	449
849	通用航空器结构与修理	9787561252376	9787561252376	任艳萍 	\N	1-1	16开	35.00	\N	西北工业大学出版社	\N	\N	\N	2021-12-01	/book/18999e9b-7fd8-4729-92a1-312f2d3965cf9787561252376.jpg	本书是根据通用航空器维修专业人才培养方案编写的。全书共分为七章。第一章为民用飞机结构的概述；第二章为小固定翼飞机结构介绍；第三章为直升机结构介绍；第四章为飞机金属结构损伤与修理；第五章为飞机先进复合材料结构损伤与修理；第六章为飞机有机玻璃结构损伤与修理；第七章为飞机其它结构损伤与修理，其中包括密封、橡胶、钛合金结构等。其中各章理论部分后附有思考题，可作为课后练习；第四章至第六章中的典型结构修理。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	254
850	航空地面设备构造与维修（货运类）	9787561259948	9787561259948	白建坤 	\N	1-1	16开	39.00	\N	西北工业大学出版社	\N	\N	\N	2021-12-01	/book/32d7d628-0220-4427-a013-beeda0acc4139787561259948.jpg	本书主要介绍机场摆渡车、客梯车、残疾人登机车、航空食品车、清水车、污水车、升降平台车、行李传送带车和行李拖头车等设备的构造、工作原理、维护和故障维修等内容。 本书适用于航空地面设备维修专业，也可作为为航空地面设备维修和操作从业人员参加职业技能鉴定考评提供参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	901
851	改革开放40年法律制度变迁·国际法卷	9787561571781	9787561571781	黄进 	\N	1-1	16开	141.00	\N	厦门大学出版社	\N	\N	\N	2019-10-09	/book/36874eb4-c96c-49ae-8968-4efe12936b479787561571781.jpg	本书旨在通过全面回顾总结改革开放40年来与我国相关的国际法的制度变迁，系统梳理中国特色社会主义法律体系在中国特色社会主义事业的发展进程中的变迁逻辑、生成规律和实现路径，以唱响我国法学界献礼改革开放40周年主旋律和最强音，为我国法学界和实务界在新时代更好推动中国特色社会主义法律体系发展完善贡献力量。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	972
852	潘维廉《我在厦大30年》英文版（3	9787561581155	9787561581155	潘维廉 	0	1-1	16开	80.00	\N	厦门大学出版社	\N	\N	\N	2021-03-01	/book/3a2c55e0-5ac8-4ed1-ba13-036478c2590d9787561581155.jpg	本书是潘维廉教授从教厦门大学三十余年的回忆录，记叙了潘维廉教授来到厦门大学，在工作和生活上逐渐适应了厦门大学的环境，在厦门大学管理学院开始了从教生涯，从厦大出发走遍福建甚至环游中国，著书立说成为一名讲好中国故事的人的动人故事。本书是潘维廉教授从教厦门大学三十余年的回忆录，记叙了潘维廉教授来到厦门大学，在工作和生活上逐渐适应了厦门大学的环境，在厦门大学管理学院开始了从教生涯，从厦大出发走遍福建甚至环游中国，著书立说成为一名讲好中国故事的人的动人故事。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	335
853	为官一任，造福一方——谷文昌精神与基层“不忘初心”实践	9787561575925	9787561575925	陈再生 	\N	1-1	16开	68.00	\N	厦门大学出版社	\N	\N	\N	2019-11-22	/book/8ee77ed2-31f2-4236-a98f-968c3fc8687e9787561575925.jpg	谷文昌说，“对群众有利的事，再难也要办”，“党要求什么，群众需要什么，我们就去做什么”。他坚持深入基层、深入群众，他带领群众抗御风沙、脱贫致富，对党对人民高度负责，不惧承担政治风险。本书研讨谷文昌精神与基层“四个全面”实践，突出强调谷文昌基层全面建设思想和创业精神。?	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	519
854	闽东抗日战争档案史料·第五辑	9787561576144	9787561576144	宁德市档案局;厦门大学马克思主义学院 	\N	1-1	16开	180.00	\N	厦门大学出版社	\N	\N	\N	2019-12-02	/book/fc005d1c-a749-4cde-a588-30f1275cc2139787561576144.jpg	闽东抗日战争档案史料选取抗日战争时期闽东地区"经济游击队"、"军事游击队"、"国民自卫队"等馆藏档案，编辑"闽东抗日战争档案史料"。对名册、章程、组织结构、活动记述、报告、会议记录等不同类型档案类整理进行分类整理，并影印出版。本书为第五辑。?	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	638
856	葛家澍教授学术思想研究[纪念葛家澍先生诞辰100周年]	9787561580578	9787561580578	杜兴强 	0	1-1	16开	72.00	\N	厦门大学出版社	\N	\N	\N	2021-03-02	/book/5a0c6c43-0d50-4eff-a751-4ed094bc47459787561580578.jpg	该书主要内容包括：第一篇：绪论。第二篇：思想破冰——必须替借贷记账法恢复名誉；会计对象：资金运动学派；会计理论：继承与发展。 第三篇——会计基本理论研究。第四篇——财务会计概念框架与会计准则。第五篇——会计学教育与学术思想：独树一帜的教材体系与国家级教学成果奖。此外还有五个附录：葛家澍教授简介，葛家澍教授扼要年谱，葛家澍教授主要论文与著作目录，葛家澍教授指导的博士生、博士后及首届硕士生名录，厦门大学会计学系：历史与现状书末有葛家澍教授生平介绍等4个附录。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	202
887	10人以下高效小团队管理法	9787542969033	9787542969033	陈政一 	\N	1-1	16开	58.00	\N	立信会计出版社	\N	\N	\N	2021-08-20	/book/40d3888a-63c8-47f1-9910-71fac8d184a79787542969033.jpg	在传统工业时代，员工的数量决定了企业的规模，但互联网时代完全不可同日而语。未来没有大企业，只有小团队。边界将被打破，沟通创造价值。本书《10人以下高效小团队管理法》从“打造小团队的九个关键点”“团队赋能的八项修炼”“主管不可不懂的十门技术”三大篇、二十七个章节来介绍小团队的管理方法和管理技巧。这些方法技巧，主要针对管理10人以下的主管而写的，其中既有案例分享，也有经验总结，值得借鉴。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	979
857	重要产品供应链追溯系统与实践案例	9787561578087	9787561578087	许志端 	\N	1-1	16开	56.00	\N	厦门大学出版社	\N	\N	\N	2020-12-01	/book/942bde1c-4186-4f72-9c83-e189f8d962ac9787561578087.jpg	本书在全面深入介绍、分析产品追溯和供应链追溯理论的基础上，对作为全国重要产品追溯系统建设示范城市的厦门市的实施案例展开研究，理论结合我国实践，期望为我国重要产品追溯系统的建设提供可复制、可推广的经验。本书由追溯系统理论篇和追溯实践案例篇两部分组成。本书在全面深入介绍、分析产品追溯和供应链追溯理论的基础上，对作为全国重要产品追溯系统建设示范城市的厦门市的实施案例展开研究，理论结合我国实践，期望为我国重要产品追溯系统的建设提供可复制、可推广的经验。本书由追溯系统理论篇和追溯实践案例篇两部分组成	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	959
858	高甜度甜味剂的生产与应用	9787561566220	9787561566220	黎四芳 	\N	1-1	16开	66.00	\N	厦门大学出版社	\N	\N	\N	2021-01-01	/book/0272ff7a-0d7e-4458-887b-86ab66db96b59787561566220.jpg	本书结合作者多年从事高甜度甜味剂的生产技术研发和产业化实践，系统阐述了各类高甜度甜味剂的物化性质、甜味特性、生产工艺、技术进展、应用、复配、安全性、监管标准和分析方法。全书共分八章，分别为绪论、A-K 糖、三氯蔗糖、阿斯巴甜、纽甜、爱德万甜、从植物中提取天然高甜度甜味剂、高甜度甜味剂的复配与协同增效作用。内容新颖、具体实用。 本书可供精细化工、食品、医药、饲料等领域的科研和生产部门的技术人员和经营管理人员参考，也可供化工、食品等相关专业的高校师生阅读参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	668
859	乡村振兴战略与茶产业高质量发展：“福鼎白茶”产业发展的创新规划与战略支撑	9787561582848	9787561582848	苏晖阳 	\N	1-1	16开	68.00	\N	厦门大学出版社	\N	\N	\N	2021-08-01	/book/7a819587-d4cf-4f08-b14e-d4366dd17e739787561582848.jpg	本书所展示的正是在国家打赢脱贫攻坚战、开启全面推进乡村振兴新篇章之时，“福鼎白茶”产业进一步主动抢抓机遇，寻求学术赋能，实现高质量发展的创新规划与战略支撑。在本书当中，来自政府、高校、企业、媒体等领域的专家，围绕产业投资、技术改良、品牌营销、茶文化传播、茶产业链延伸等系列议题，为“福鼎白茶”实现国际化、品牌化、年轻化、标准化、多元化目标绘就了切实可行的发展路径，为统筹做好茶文化、茶产业、茶科技这篇大文章，为茶产业如何凭借改革创新走出一条具有闽东特色的乡村振兴之路提供了深刻的启示与思考。 ?	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	859
860	乡村振兴战略下农村土地产权制度改革研究	9787561577707	9787561577707	郑兴明 	0	1-1	16开	68.00	\N	厦门大学出版社	\N	\N	\N	2021-11-01	/book/98e1f65a-1126-4f51-b6ee-75a3c39268369787561577707.jpg	本书将立足于新时代农业农村发展的新形势和新特征，紧紧围绕党的十九大报告和2018年中央“一号文件”关于农村土地产权制度改革的总体部署，对乡村振兴战略下农村土地产权制度改革问题展开前瞻性研究。本书研究主要目标有两个：一是在理论层面上，以乡村振兴战略下如何解决土地资源紧约束难题为逻辑起点，重新审视和拓展研究农村土地产权制度改革问题，有望充实与丰富既有的研究内容；二是在实践层面上，基于对乡村振兴战略下农村土地产权制度问题及其改革路径的探讨，为各地扎实推进土地产权制度改革提供可资借鉴的理论与实践参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	995
861	新周期与新金融	9787561569078	9787561569078	巴曙松 	\N	1-1	16开	78.00	\N	厦门大学出版社	\N	\N	\N	2018-05-01	/book/77edb034-03b1-4d19-9ae8-0547de6bab9e9787561569078.jpg	十九大之后，中国经济将由高速增长阶段转向高质量发展阶段的新时代。本书重点阐述在经济发展方式、经济结构和增长动力转换时期，中国金融体系将面临的挑战，以及金融机构、金融业务、金融创新和金融监管的发展趋势。?	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	600
862	新中介的崛起与房地产价值链的重构	9787561562901	9787561562901	巴曙松 杨现领 	\N	1-1	16开	43.00	\N	厦门大学出版社	\N	\N	\N	2017-09-01	/book/24959ac9-2813-4cc6-9ad1-a2235071e69c9787561562901.jpg	随着互联网的冲击和存量房市场的快速上升，中国房地产经纪行业正在积极的裂变，而其中最引人注目的变化则是经纪人的全面崛起。本书将从经纪人的角度对整个房地产经纪行业的历史、现状与未来进行全面的总结与展望，同时讨论互联网给房地产经纪人角色所带来的变化。?	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	928
863	厦大孔院故事	9787561581292	9787561581292	《厦大孔院故事》编委会 	0	1-1	16开	128.00	\N	厦门大学出版社	\N	\N	\N	2021-03-01	/book/ad0f9080-8fc9-4c94-a033-f046b7e8dd3b9787561581292.jpg	　　孔子学院作为世界了解中国的一个重要平台，以开放和包容的姿态，积极开展汉语教学和文化交流活动，推动世界各国文明互鉴，促进多元多彩的世界文明发展。《厦大孔院故事》主要讲述厦大汉教人在全世界范围内教学汉语，传播中国文化，促进中外文化交流的生动故事。全书分为经历篇、教学篇、感悟篇、生活篇、新闻篇、人物篇，通过一百余篇鲜活的故事反映厦大孔院为增进世界各国人民对中国语言和文化的了解、促进各国文明交流互鉴所做的贡献。全书图文并茂，可读性强。该书的出版将为广大读者提供一扇深入了解孔子学院、了解厦大汉教人的窗口。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	487
865	X射线检测检测关键技术与应用研究	9787561580684	9787561580684	方正 	0	1-1	16开	68.00	\N	厦门大学出版社	\N	\N	\N	2021-03-01	/book/6deda290-ac8c-4044-85d4-58ea15f7cf9f9787561580684.jpg	本书系统地介绍了X射线检测和CT重建方面的理论知识及应用实例。本书从X射线的基础理论知识开始，介绍了X射线检测的物理学基础。对射线检测各种方法进行了较为全面的描述，包括常规的X射线成像、射线光谱检测、 CT重建等，还涉及前沿的吸收光谱检测、光/能谱CT、发射型计算机断层成像等领域。通读全书能系统地了解该领域的基础理论，把握良好的知识体系框架，有利于读者客观全面地分析和解决实际问题。本书适合高等学校师生及科研院所工作人员，特别是生物医学工程和无损检测两个不同领域的技术人员阅读参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	760
866	中国外汇储备风险测度与管理	9787561581117	9787561581117	朱孟楠 	\N	1-1	16开	68.00	\N	厦门大学出版社	\N	\N	\N	2021-04-01	/book/eb70fb7b-451e-4b5c-b33f-6b83d68ff5309787561581117.jpg	中国拥有世界上最多的外汇储备，自1994年以来持续、巨额、大幅度增长，因此提高对外汇储备储备的风险管理，增强外汇储备的效率与效益非常必要。本书从宏观与微观角度，研究以下重要课题：中国外汇储备增长情况及其内部与外部的动因与机制，中国外汇储备快速与巨额增长的经济影响，中国外汇储备增长过程中的风险累积及其识别与评估，中国外汇储备风险管理，尤其是适度外汇储备量、最优储备币种结构、最合理的储备资产结构等问题，外汇储备资产运用与投资机制，金融危机背景下外汇储备有效风险管理体系等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	549
867	不见外的魅力老潘（套装）	9787561573396	9787561573396	潘维廉 	\N	1-1	16开	300.00	\N	厦门大学出版社	\N	\N	\N	2019-03-25	/book/97690765-296e-4995-a201-9ae6b335d6fc9787561573396.jpg	本书是套书，包括“魅力•老潘”系列中的8种图书：《魅力厦门》《魅力厦门（中文版）》《魅力泉州》《魅力鼓浪屿》《魅力厦大》《老外看福建》《老外看老鼓浪屿》《商业老厦门》，从一个外国朋友的视角，介绍厦门、泉州、福建的历史、风土人情、发展成就等，文笔流畅，笔调轻松、幽默，是一套很好的宣传厦门、福建的图书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	117
868	论拉辛	9787560444833	9787560444833	[法]罗兰·巴尔特 	\N	1-1	16开	62.00	\N	西北大学出版社	\N	\N	\N	2020-05-01	/book/3b089247-feda-496b-94d5-50bbd1c777f89787560444833.jpg	本书是法国当代杰出的思想家、批评家罗兰·巴尔特1963年出版的作品，其所引起的巨大反响和论争，催生了以法国为中心的结构主义－后结构主义知识变革运动的兴起。与传统文学批评不同的是，作者打破了不同知识领域的界限，以结构分析的方法“努力重建一种拉辛人类学”，使批评话语从此发生了彻底的变革。自20世纪80年代以来，罗兰·巴尔特备受国内研究界关注，其著作绝大多数已有中译本，本书则是他生前发表专著中唯一未翻译的一本。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	306
869	民主的未来	9787560444840	9787560444840	[意]诺伯托·博比奥 	\N	1-1	16开	65.00	\N	西北大学出版社	\N	\N	\N	2019-12-01	/book/2fee66bd-e535-441c-ac89-236f3f2af0299787560444840.jpg	《民主的未来》本书被评比为“最有气魄”的重要工作成果，在该著作中，博比奥用富有激情的思辨、博学，对及其争议的“民主”问题进行了探讨，本书的主题，是思考西方民主理念在当代资本主义条件下面临的困境和危机，从学理上深入批判资本主义、经济自由主义对民主的残害。作者主要讨论了在西方资本主义国家如何真正的实现民主，或西方民主如何自我改造，实现未来的“转型”。这些见解虽然不一定是真正的“药方”，但对于我们研究和批判当代西方资本主义政治制度，却有重要的参考价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	632
870	政治与历史	9787560440965	9787560440965	[法]路易·阿尔都塞 	\N	1-1	16开	116.00	\N	西北大学出版社	\N	\N	\N	2018-01-01	/book/a381fd10-a81d-49ab-93e6-a54857bf69979787560440965.jpg	该书是法国当代著名哲学家路易·阿尔都塞在巴黎高师哲学史课程的讲义，讲授了从马基雅维利、霍布斯、18世纪法国哲学与政治、黑格尔和费尔巴哈、直到马克思的现代思想历程。阿尔都塞把“在哲学中成为马克思主义者”的艰巨事业落实于对理论文本进行精彩、深邃而细腻的解读之中	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	513
871	歧义：政治与哲学	9787560435671	9787560435671	[法]雅克·朗西埃 	\N	1-1	16开	42.00	\N	西北大学出版社	\N	\N	\N	2015-01-01	/book/e19ca2e7-9711-400c-a608-5e420bab10819787560435671.jpg	本书作者阐述其独特的美学－政治理论，通过对于治理性的“政治”概念的反思和批判，试图提出以“感性共享”作为新政治起点的、解放性的“政略”概念，以“歧义”的声音批判和替代现代资本主义民主政治的“共识”，从而为社会的“无分者”争取“无分者之分”，以聚合多元的、	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	720
872	史记研究集成·十二本纪·周本纪	9787560440446	9787560440446	尹盛平 	\N	1-1	16开	165.00	\N	西北大学出版社	\N	\N	\N	2019-03-01	/book/b9e557b5-b585-40ed-93f6-73c7cd9626c99787560440446.jpg	本书主要从汇校、汇注、汇评三方面整理、综合有关学术研究成就，力求较全面的反映出历代有见解的观点。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	173
873	史记研究集成·十二本纪·孝景本纪	9787560440491	9787560440491	吕新峰 	\N	1-1	16开	85.00	\N	西北大学出版社	\N	\N	\N	2019-03-01	/book/e42f1c02-a296-4ed4-aaf1-32ba2a1e38469787560440491.jpg	本书主要讲述了西汉第6位皇帝汉景帝刘启在位16年间的文治武功。他在位期间，平定了七国之乱，且继续执行与民休息和轻徭薄赋的政策，使汉朝从国家初定走向繁荣昌盛的过渡时期，开创了历史上著名的文景之治。本书主要从汇校、汇注、汇评三方面整理、综合有关学术研究成就，力	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	809
874	秦交通史	9787560446646	9787560446646	丛书主编王子今 本册 王子今 著 	0	1-1	16开	232.00	\N	西北大学出版社	\N	\N	\N	2021-02-01	/book/3ce5a9b3-8c49-484f-b3dc-00247fa0cc7c1079257.png	本书以秦人在渭水上游及西汉水上游的早期经营为起始点考察秦史，提取秦交通与秦帝业的兴衰、国家运输与民间商运、秦国君主远行、秦军远征与军需运输、秦通信制度、秦交通管理、秦交通礼俗等多个视角，深入探析有关秦交通开发、交通建设、交通发明、交通条件利用等方面的历史文化信息。本书在原有的《秦汉交通史稿》的基础上，以秦为独立研究对象，将秦祖先神话传说、秦史资料、考古成果，以及与秦交通史相关的民俗资料相结合，旁征博引，从交通这一关键词出发，深入探析有关秦交通开发、交通建设、交通发明、交通条件利用等方面的历史文化信息。从交通文化层面的象征意义切入还原秦朝社会气象的，通过个案研究，以交通为核心，在秦政治建设、军事管理、经济发展，以及文化进步等方面提出许多值得思考的新观点。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	231
875	秦法律文化新探	9787560445946	9787560445946	丛书主编王子今 本册 闫晓君 著 	0	1-1	16开	108.00	\N	西北大学出版社	\N	\N	\N	2021-02-01	/book/c2404eaf-82cb-4700-bf89-9408f3b423111079259.png	《秦法律文化新探》对秦法律文化的渊源、流变、内涵、特色、影响和历史地位等问题一一进行了探究、分析，内容涉及刑法、民事法、经济法等各方面，尤其是深入论述了秦的司法文化和监察文化，阐释了监察文化对中国的行政体系的深远影响。将传世文献与出土文献、考古资料相结合，将法律思想与法律制度相结合，并吸收了学界对秦律、秦文化的最新研究成果，为一部较为简明而又能反映秦法律文化前沿学术研究成果的专著。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	201
888	中国财政制度史	9787542963109	9787542963109	贾康 申学锋 柳文 田远 	\N	1-1	16开	110.00	\N	立信会计出版社	\N	\N	\N	2020-05-18	/book/8f6d6eee-60be-4876-9eac-347dc218c9f89787542963109.jpg	《中国财政制度史》重点探究中国自古至今财政制度的历史沿革，分析这种变迁的多重因素，总结制度演进的规律性及经验教训，结合当前中国财政体制改革的实际，为进一步完善财政制度提供值得借鉴的历史参考。本书拟分古代、近代、现代三卷。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	724
886	企业纳税筹划实用技巧与典型案例分析（2021年版）	9787542967817	9787542967817	翟继光，袁芸，梁小斌 	0	1-1	16开	65.00	\N	立信会计出版社	\N	\N	\N	2021-03-29	/book/e703f8a0-7786-4bdf-abea-da0c6efbe8479787542967817.jpg	　　《企业纳税筹划实用技巧与典型案例分析（2021年版）（原6365）》论述了企业投资决策纳税筹划方案、企业经营决策纳税筹划方案、企业融资决策纳税筹划方案、企业再投资与结业决策纳税筹划方案、企业跨国经营纳税筹划方案、企业薪金发放纳税筹划方案、企业增值税纳税筹划方案、企业消费税纳税筹划方案、企业营改增纳税筹划方案、房地产业纳税筹划方案、公司股权架构与纳税筹划以及纳税筹划与反避税经典案例分析。 　　《企业纳税筹划实用技巧与典型案例分析（2021年版）（原6365）》精选了近200个纳税筹划的常用方法和技巧，力求简明、实用、可操作，让读者在具体案例的演示中轻松掌握纳税筹划的精髓和要领。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	292
876	初并天下——秦君主集权研究	9787560446714	9787560446714	丛书主编王子今 本册 孙闻博 著 	0	1-1	16开	118.00	\N	西北大学出版社	\N	\N	\N	2021-02-01	/book/97290ee5-094b-4a34-8a68-4e1ba6005bdb1079263.png	本书探讨秦统一历史进程中君主权力的巩固与发展，聚焦“集权君主制”下与秦君关系密切的政策、口号、名号、信物，进而从这四个层面展开分析。其中，政策探讨商鞅“农战”政策推行及与“君——官——民”政治结构的互动；口号探讨秦君臣“并天下”政治表述的产生过程及其意义；名号探讨秦自战国献公、孝公以降君主称谓的使用变化与“皇帝”名号的出现；信物主要围绕兵符、帝玺与玺书，梳理制度源流，揭示政治文化意涵，进而思考君主在军事、政治活动中的角色及地位。以往之秦史研究，“政策”内容虽然系统、明确，但是执行情形却会存在调整、产生波动；有关“口号、名号”的思考，学界之前措意较少，梳理相关“口号、名号”，有助于体察战国至秦统一政治秩序的演进；而“信物”政治意涵丰富，诠释着秦君在秦统一过程中的角色及定位。本书立足史料，旁征博引，钩沉典籍，分析细致而深入，读者在了解秦代种种变革举措之后，便能理解秦“初并天下”的政治现实之顺理成章。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	540
877	西安碑林博物馆珍品讲读	9787560444611	9787560444611	陈根远 	0	1-1	16开	88.00	\N	西北大学出版社	\N	\N	\N	2019-12-01	/book/d0e05870-636a-4c0a-905f-096c4a5b3ca91079271.jpg	《西安碑林博物馆珍品讲读》由西安碑林博物馆资深馆员、著名文物鉴定家陈根远编著。全书分为“石墨镌华”和“古刻萃珍”两篇，撷取西安碑林博物馆精华文物70件(组)，择要介绍其历史文化价值，彰显其在需家文化传承、中外文化交流、中国书法流脉、雕塑艺术特色等方面的独特魅力。全书配有11个音视频文件，细致讲解馆藏名碑，以图文声全方位展示的方式，带您感受风雨沧桑九百年的西安碑林。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	391
878	张伯声院士论著选集	9787560448084	9787560448084	张伯声 	0	1-1	16开	400.00	\N	西北大学出版社	\N	\N	\N	2021-10-01	/book/d531fcac-9133-4964-b47b-47301ac57de71079277.png	本书精选张伯声院士代表性论文46篇，专著1部。内容涉及岩石分类及命名、矿产分布与地质构造的关系、大地构造单位划分、黄土线及黄土的形成、黄河河道变迁、陕西水系发育及特点、波浪状镶嵌构造等。尤其是“地壳波浪状镶嵌构造”学说，被我国地质学界公认为“五大构造地质学派”之一。所选论文及专著，既体现“波浪状镶嵌构造说”的发展脉络，也反映了张先生的治学精神和地学教育理念，对后学者具有重要的启迪意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	885
879	C语言程序设计教程	9787560444543	9787560444543	董卫军 索琦 邢为民 主编 	0	1-1	16开	58.00	\N	西北大学出版社	\N	\N	\N	2019-11-01	/book/e8087b30-7aa0-4653-9f0d-4be859201c591079286.png	程序设计作为实现计算思维的核心课程之一，在大学生的知识体系中占有重要位置，其内容组织应该体现创造性思维教育培养过程。本书是国家精品课程“大学计算机”系列之“C语言程序设计”的主教材，是大学MOOC“C语言程序设计”的配套教材，也是《教育部大学计算机课程改革项目》成果之一。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	828
880	大学心理委员	9787560446196	9787560446196	李佳 	0	1-1	16开	78.00	\N	西北大学出版社	\N	\N	\N	2020-12-01	/book/5223ebc7-2c7a-4ab7-9100-11fbc76572821079288.jpg	大学心理委员	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	563
881	财务管理项目化教程	9787560442457	9787560442457	杨敏茹 刘胜辉 	0	1-1	16开	49.80	\N	西北大学出版社	\N	\N	\N	2018-11-01	/book/685bd255-4507-4499-aae7-75861acd10f51079296.jpg	财务管理项目化教程	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	853
882	Thesis	9787560446639	9787560446639	Dinesh Raj Bhuju， Jiani Ma 	0	1-1	16开	36.00	\N	西北大学出版社	\N	\N	\N	2020-12-01	/book/8d381b7e-aa75-4f03-a5b1-7568ee90ddd81079305.png	Thesis Research and Writing	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	390
883	中国现当代文学作品英译选读	9787560444628	9787560444628	李建利 	0	1-1	16开	36.00	\N	西北大学出版社	\N	\N	\N	2019-12-01	/book/95643e56-6357-480c-9a44-6bf9d3d54a961079306.jpg	中国现当代文学作品英译选读	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	706
884	陕西古塔全编（上下册）	9787560443652	9787560443652	徐进 	\N	1-1	16开	780.00	\N	西北大学出版社	\N	\N	\N	2019-06-01	/book/a2ce9eea-fba3-4e49-8e7b-4e3b8ee554fb9787560443652.jpg	古格王国作为10—17世纪占据西藏西部的一个地方性王国，在长达700余年的王朝史中曾兴盛一时，它发展生产、抵御外侵、尊崇佛教，是当时西藏西部有影响的地方政权。王国遗留下来的建筑、塑像、壁画、金银器、武器、生产生活用品等文物向我们诉说着它曾经的辉煌。17世纪30年代，由于宗教之争与僧俗之争，终引发了王朝的覆灭，古格故城逐渐沦为废墟。《秘境之国：寻找消失的古格文明》以作者多年来专业科学的考古调查为基础，力图向读者呈现出那消失了的秘境之国——古格王朝的本真面貌。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	386
927	小江文书·高坪卷：土地契约	9787569102031	9787569102031	龙泽江 陈洪波 编者 	\N	1-1	16开	129.00	748.0千字	贵州大学出版社	258	\N	\N	2018-12-01	/book/8fde7cbb-7444-4a68-8202-27716dfe0d0d9787569102031.jpg	高坪村民间遗存的清代和民国鱼鳞册、田赋编审册、归户册、土地契约、税票等文献，相互之间有较强的关联性，可以相互比照核对，形成了完整的资料系统，为研究近代侗族地区土地制度与赋税制度提供了宝贵的实证资料，因而具有重要的文献价值。 本册主要是土地契约，土地契约有比较独特的书写形式或书写习惯。土地契约在形式上一般包括以下要素：立契人、立契（出卖）原因、山场名称、四至、购买人、中人、书写人（亲笔或代笔）、时间。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	373
885	转让定价风险管理之本：同期资料准备与审核	9787542968531	9787542968531	易奉菊 李时 	\N	1-1	16开	79.00	\N	立信会计出版社	\N	\N	\N	2021-08-24	/book/f553476d-7217-4332-9541-e667dd8da1109787542968531.jpg	本书共分九章，全面介绍企业应该如何准备和审阅同期资料。为了帮助企业全面深入的了解同期资料的方方面面，我们专门设计了一个综合性案例，此案例贯穿本书的前面七章，通过还原该企业准备同期资料的过程，系统介绍同期资料每一部分的相关理论，并在每章的结尾部分，给出该企业同期资料的示范报告，将各章节结尾的案例示范组合起来，就是该企业完整的同期资料报告。在完整全面呈现同期资料准备过程与结果的同时，对于转让定价领域具有深度的问题，在相关章节以“问题与讨论”的方式呈现，旨在帮助企业更好地认识同期资料报告结论背后存在的不确定性，为企业应对转让定价调查与调整过程中可能的争议做好准备。本书的最后两章主要是介绍特殊事项文档，分别是资本弱化与成本分摊协议，尽管目前国内需要准备特殊事项文档的企业较少，实务中也缺少具体的案例，为了本书的完整性，我们仍然进行了比较深入的介绍。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	270
889	个人所得税实务操作与合法节税技巧	9787542967503	9787542967503	翟继光 郭宇泰 	\N	1-1	16开	65.00	\N	立信会计出版社	\N	\N	\N	2021-04-06	/book/93703a6a-2d81-4edc-9342-c94d6043cab39787542967503.jpg	2018年8月31日，第十三届全国人民代表大会常务委员会第五次会议通过了《关于修改〈中华人民共和国个人所得税法〉的决定》，对《个人所得税法》进行了第七次修正。本次对个税法的修正与前几次小规模修正具有重大区别，我国个人所得税已经从分类所得税制转变为分类综合所得税制，由此导致我国个人所得税在应纳税额的计算、税款的预扣与汇算清缴以及个人所得税的征收管理等方面均发生了重大变化。为帮助广大纳税人及企事业单位掌握个人所得税的最新政策，我们特编写了《个人所得税实务操作与合法节税技巧》一书。本书分为三个部分，共十一章。第一部分介绍个人所得税最新政策，分为六章。第二部分介绍个人所得税纳税筹划技巧，分为四章。第三部分介绍个人所得税典型诉讼案例分析，包括一章，分为四节，分别介绍股权转让个人所得税退税案、个人所得税偷税查处违法案、个人所得税举报复议案、个人所得税退税申请不予受理案。本书适宜作为新《个人所得税法》的培训教材，适宜作为广大企事业单位扣缴申报个人所得税以及为职工进行纳税筹划的辅导教材，也适宜作为广大高净值人士进行个人所得税筹划的指导用书。本书所收录的个人所得税法律法规及相关政策截至2020年12月10日。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	738
890	税务稽查案件查办实务及典型案例	9787542965325	9787542965325	郭勇平 安履承 方永武 	\N	1-1	16开	98.00	\N	立信会计出版社	\N	\N	\N	2020-06-19	/book/b8fc755d-9d26-4500-a560-ea026270cb569787542965325.jpg	税务稽查是税收执法工作的重要环节，担负着打击偷逃骗抗税和虚开发票等税收违法行为的法定职责。本书以税务稽查案件查办为主线，对现行税务稽查相关法律、行政法规、部门规章、规范性文件等进行了梳理、整合，参照了部分涉税相关司法解释，并结合税务稽查工作实践，建立了税务稽查案件查办的基本框架，包括案件查办流程，案件查办工具与基本方法，及偷（逃）税、骗税、虚开发票等重点案件查办实务。为帮助读者在阅读学习过程中能够尽可能还原税务稽查工作真实场景，本书精选76个真实案例，贯穿于税务稽查案件查办流程、方法、重点案件查办实务等各方面，既有工作思路、方法，也有对疑难问题争议和司法机关裁判观点，强化税务稽查人员防范税务稽查执法风险。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	996
891	国际会计(第五版)	9787542969590	9787542969590	郝振平 	\N	1-1	16开	58.00	\N	立信会计出版社	\N	\N	\N	2021-11-02	/book/acb4bd60-3f6b-46fb-8190-2e469ae7f25c9787542969590.jpg	本书在第四版的基础上根据国际会计领域发生的重大变化，及时更新教材内容。各国的会计实务和会计准则都有变化。这些在会计环境阐述中得到反映。本书主要内容包括：国际会计环境、美洲及大洋洲的会计环境、欧洲的会计环境、亚洲及非洲的会计环境、会计准则的国际趋同、国际资本市场和跨国公司、国际财务报告外币会计、通货膨胀会计、外汇风险管理、国际转移定价、国际税务国际审计等。每章还有复习思考题、参考文献等。每章内容更加教学需要有所修改，相关例题、数据多进行了更新。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	752
892	财务管理案例分析（第二版）	9787542968333	9787542968333	邵军 	\N	1-1	16开	45.00	\N	立信会计出版社	\N	\N	\N	2021-07-01	/book/a842e9af-5d71-4dc1-8adb-daa73c7a94cb9787542968333.jpg	本书围绕现代财务管理理论和财务管理课程内容安排，分为五篇二十二章（22个案例），第一篇为融资决策的案例分析，第二篇为投资决策的案例分析，第三篇为营运资金管理案例分析，第四篇为股利政策的案例分析，第五篇为企业并购与反并购的案例分析，第六篇为公司治理案例分析。本书内容充分体现财务管理在理论、实务与政策三个方面的难点、热点和重点问题，实践性和操作性非常强。案例全部来源于真实的中国上市公司案例。对每个案例给出的案例分析、问題探讨与思考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	109
937	北部侗族婚嫁歌	9787811267983	9787811267983	吴世源 	\N	1-1	16开	108.00	450.0千字	贵州大学出版社	354	\N	\N	2015-08-01	/book/72b3a0f1-38b9-4028-93cd-3fedbc3757f29787811267983.jpg	独特古老的侗族风情蕴涵于侗歌之中，侗族人民的婚嫁民俗的全过程都渗透侗歌精髓和魅力。本书以侗语汉字记音、侗文、汉文翻译三种方式行文，为研究侗族民歌、侗族语言文字以及侗族婚俗提供了很好的参考资料，同时对抢救、挖掘、保护和发展侗族文化具有深远的意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	135
893	财务数据处理技术	9787542969934	9787542969934	滕文惠 侯玉荣等 	0	1-1	16开	0.00	\N	立信会计出版社	\N	\N	\N	2022-01-01	/book/715620fe-70a5-4389-9f2c-9a7f90d0d8649787542969934.jpg	本书是《财务数据处理技术》课程的配套教材，全书共包括七章内容，以教学案例为引导，讲述了软件开发平台的主要内容，包括常用的语句、对象、控件、事件、函数，重点讲述数据库对象与数据管理、SQL语言及应用。其中，通过不同的技术方案实现商品信息管理，基本上涵盖了会计软件开发技术的主要知识点与能力要求。最终应用数据库以及SQL语句开发完成了一个简单的进销存系统，实现了初始化进销存系统中的数据表、操作员信息管理、商品信息管理、采购单管理、销售单管理、商品库存管理、报表计算等功能，同时实现了对进销存系统中各类非正常数据的稽核审计功能。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	833
894	企业涉税风险	9787542968821	9787542968821	韩海敏 	\N	1-1	16开	48.00	\N	立信会计出版社	\N	\N	\N	2021-08-01	/book/f4e097ba-d54b-4a04-b060-6bb8257252a19787542968821.jpg	《企业涉税风险》主要从企业风险管控的角度编写。本教材编委会成员集合了上海国家会计学院、上海财经大学、东北财经大学、中南财经政法大学、山西省财政税务专科学校等高校教授、实务专家共同编写，集聚专家多年的理论与实践经验，配以丰富的案例，具有非常强的实操性。本书主要内容包括企业设立与投融资涉税风险分析、生产经营涉税风险分析、企业重组、清算中的涉税风险分析、财务报表涉税风险分析、税务管理风险分析、企业涉税风险的法律责任。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	238
895	商业银行市场营销	9787542969750	9787542969750	周珊珊 	\N	1-1	16开	42.00	\N	立信会计出版社	\N	\N	\N	2022-01-02	/book/a9dba987-4e51-440a-82ad-84ef1b200df99787542969750.jpg	本书是普通高等教育“十四五”金融学类专业产教融合系列规划教材。在概述商业银行市场营销基本原理的基础上，着重介绍了商业银行市场营销环境分析、商业银行市场细分与竞争战略、商业银行市场营销产品策略、商业银行市场营销定价策略、金融促销策略、商业银行市场营销渠道策略、商业银行客户关系管理以及普惠金融市场营销。本书引入大量案例，将理论知识立体、形象地展现，并充分考虑商业银行在互联网金融时代背景下所面临的新变化，使学生了解商业银行市场营销问题研究的现状，了解市场需求的变化趋势及其规律性，掌握观察和分析商业银行市场营销问题的正确方法，通过大量案例学习熟悉商业银行应对金融市场变化的营销战略和策略，为以后职业的可持续发展奠定了良好的基础。本书适合作为普通高等教育金融类专业教学用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	742
896	企业成本核算与分析（第二版）	978-7-5429-6890-6	9787542968906	史艳利 陈哲 	0	1-1	16开	55.00	\N	立信会计出版社	\N	\N	\N	2021-07-01	/book/8068dabe-70c6-4a93-ade9-8c62b1f1d77e1079385.jpg	本教材融基础知识与实务操作为一体，不仅注重岗位工作的过程化运作和实务化操作训练，同时也注重知识的提炼、补充和拓展，本教材以各项目的“项目描述”“任务描述”“任务实操”等直观的形式，将学生引入一个形象的岗位环境，并达到相关的技能要求。本书主要包括以下内容：认识成本核算与分析、产品成本构成要素的归集与分配、生产费用在完工产品与在产品之间的分配、利用品种法核算产品成本、利用分批法核算产品成本、利用分步法核算产品成本、利用辅助方法核算产品成本等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	433
897	ERP财务管理系统实训教程（用友U8V10.1版）	9787542964052	9787542964052	韦兰英 	\N	1-1	16开	42.00	\N	立信会计出版社	\N	\N	\N	2020-07-01	/book/d4480dc8-6ff0-4389-bc86-955cb9b1f1ad9787542964052.jpg	内容包括三大模块：企业建账及初始化处理，分企业建账及系统管理、企业基础信息设置、各模块期初设置；企业日常业务处理，包括总账、应收管理、应付管理、固定资产、薪酬管理系统业务处理；企业期末业务处理，对常用会计报表设置和修改，自定义报表设计工作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	544
898	智能投顾	9787542969613	9787542969613	金玮佳 梁睿 	\N	1-1	16开	48.00	\N	立信会计出版社	\N	\N	\N	2022-01-25	/book/18d11d3b-3508-4b7c-b529-6e403c3474969787542969613.jpg	本教材按照高职高专人才培养目标以及专业教学改革的需要，依据最新政策法规、标准规范来进行编写。针对金融领域中的问题，紧跟金融科技发展态势，根据目前智能投顾主要业务，提供相关证券投资基础理论知识，针对性地研究目前智能投顾行业案例，支持互联网+证券投资相关课程的教学，促进人工智能在金融领域的研究，服务当前金融科技的迫切需要而编写。在建设互联网金融国家教学资源库的基础上，建设课程在线资源，把目前智能投顾几个工作项目：客户分析、大类资产配置、投资组合选择、交易执行、投资组合再平衡、税收规划、投资组合分析，将云计算、大数据和人工智能在证券投资上的基础应用知识利用文字、图片、视频等新形态信息化手段展现，改革以往书本一统的局面，从单调的文字、图片，转向声、影、光立体展现，从纸介质一种表现形式转向不同媒体的多元表现形式，以满足灵活、自主学习的需要。通过建设立体化教材改革现有教学模式，以形成培养具有综合能力和创新精神人才的教材平台。本书适合高职高专金融、金融科技、互联网金融等专业学习使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	120
899	会计岗位项目实训（第二版）	9787542968036	9787542968036	曹华祝 薛松 	\N	1-1	16开	48.00	\N	立信会计出版社	\N	\N	\N	2021-07-02	/book/991a6b14-79b3-4e68-81c4-69447afa28fb9787542968036.jpg	本书打破了传统实训教材的模式，以一个真实的主体企业账项为依据，突出以企业的会计岗位为独立实训项目，综合了相关课程的核心内容和会计处理方法，培养学生认知分析原始凭证、正确进行会计处理，从而掌握会计相关岗位业务核算，并编制报表的综合实训能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	946
900	小企业会计综合实训	9787542969309	9787542969309	余国艳 	\N	1-1	16开	42.00	\N	立信会计出版社	\N	\N	\N	2021-09-07	/book/66fede88-eeb6-4c6c-973f-c71dfea2ab549787542969309.jpg	书稿内容可从以下三方面叙述：由手工记账和电算化记账两个模块组成，其中电算化记账是以“用友财务软件”为蓝本，所涉数据同样适用于其他财务软件；按照制造业会计核算工作过程，模拟了一家真实企业一个月发生的经济业务；使用最新版的银行结算凭证、发票和纳税申报表，所涉资料均十分准确、规范。内容的安排合理得当，能有效解决会计职业教育的岗位针对性、就业适应性，也有助于学生熟练掌握手工记账的基本流程、提高会计电算化的操作技能。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	668
901	企业与会计认知	9787542967305	9787542967305	陆世皓 	\N	1-1	16开	48.00	\N	立信会计出版社	\N	\N	\N	2021-07-13	/book/4be25eae-78f3-416a-9b56-5da3a417ca1b9787542967305.jpg	《企业与会计认知》是“以就业为导向”，探索“工作过程系统化”的会计专业入门课程的教材，是按照会计专业人才规格的要求，基于工作过程的课程观和行动导向的教学观，遵循学生认知规律和职业成长规律，以工作过程为导向，突出学生为主，概念和原理适度够用的教材。《企业与会计认知》根据中等职业学校学生的认知特点及在外勤会计工作岗位能力的需要编写，以认知企业与会计工作为主线，由企业认知篇、会计认知篇、企业业务单据篇、社保公积金办理篇和会计职业道德篇五个单元组成。通过学习目标、知识导图、案例导入、任务活动等多种手段展现教学内容，可作为中等职业学校会计专业的教材，也可作为会计从业人员在职岗位培训教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	212
902	会计信息化基础	9787542966858	9787542966858	罗光德 	\N	1-1	16开	40.00	\N	立信会计出版社	\N	\N	\N	2021-02-01	/book/f9478dc7-46fc-4013-8aff-2c98744e7af49787542966858.jpg	本书基于畅捷通信息技术股份有限公司T3平台，为财务篇,与上海财经大学出版社公开出版的《会计实务信息化处理》（财务业务一体化篇）构成完整的会计信息化逻辑体系。本书按照“项目教学法”要求，以小型制造企业的典型财务业务为背景，从账套建立开始，完成证账表业务处理流程，符合行动导向教学要求，力求情境创设真实、任务要求明确、指导过程详细。本书注重信息系统与经营环境的契合，先从会计实务角度阐述做账原理，再从会计软件角度阐述会计业务处理，使学员领会信息系统的高效和逻辑，为培养信息化会计人才夯实基础。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	906
903	ERP基本知识	9787542966292	9787542966292	王玮 	\N	1-1	16开	49.00	\N	立信会计出版社	\N	\N	\N	2021-01-01	/book/d4e704f1-cb1e-46b0-b8f7-d175687198999787542966292.jpg	《ERP基本知识》课程是中职会计专业核心课程之一，为学生将来就业或升学起到一个导入、初识、衔接的作用。目前，上海乃至全国没有适合中职学生学习参考的本课程教材。依托上海市中职《ERP基本知识》在线课程建设，《ERP基本知识》活页式校本教材2019年9月编写完成，在校内使用；经过教学实践和修订，2020年3月第二版又投入使用。教材充分考虑财经商贸类中职学生对本课程相关知识和技能的认知能力，以学生初识ERP系统所应了解和掌握的知识与能力为限，根据职业能力培养需求选取了ERP的基础知识、基本架构和主要模块操作等作为课程和教材的主要内容，包含五大模块任务：初识ERP、认知ERP主要模块和功能、供应链管理系统主要模块实训、成本管理系统主要模块实训、财务管理系统主要模块实训。教材内容的选择符合上海市课标要求，支撑课程目标的实现，并且源于真实工作任务、项目、流程来组织，符合中职学校学生学习的特点。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	929
904	明清域外官话文献语言研究	9787560268484	9787560268484	张美兰 	\N	1-1	32开	57.00	\N	东北师范大学出版社	\N	\N	\N	2011-06-21	/book/874ebf6c-42cb-4347-9b67-5a593f9924cb9787560268484.jpg	本书第一次从汉语发展史的角度系统对明清时期的可以专门用作汉语官话研究的域外资料进行本体研究。研究方法上突破传统汉语研究界只用本土的文献资料研究明清官话的单一途径，突破汉学研究界仅限于对域外官话资料译介、评述的单一描写，抓住域外官话文献中关于汉语官话特点的线索，试图将汉语官话研究纳入国际学术研究的框架中，从汉语发展史的角度系统地对明清域外汉语官话研究进行专题研究。在对比研究同期明清汉语基础上，深入探讨十九世纪末汉语南方官话、北京官话的历史面貌。勾勒出明清官话在词汇、语法等方面的地域分布特征。将域外世界汉语研究同国内已有的对本土汉语文献的语言研究作对比研究，从一个全新的视角揭示清代汉语的面貌，重现汉语发展史中最辉煌的一页。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	428
905	中国城市空间统计模型方法及应用研究	9787568109673	9787568109673	董春 胡晶 刘纪平 	\N	1-1	32开	82.50	\N	东北师范大学出版社	\N	\N	\N	2017-03-22	/book/83440153-0831-4fd0-8c49-2ecb3f939c0e9787568109673.jpg	本书对城市的特点、分布格局及发展变化和空间统计学的发展理论进行了全方位的总结和剖析。在原有随机前沿模型的基础上，引入空间滞后项和空间误差自相关，从而将趋于潜在的相互影响纳入模型之中进行分析，对基于横截面数据和面板数据两种情况下的空间随机前沿模型进行了研究，得出了模型参数的估计，并进而得到了生产单元技术（无）效率的估计。在此基础上，通过城市空间统计数据框架的研究、不同模式下城市分布的研究，构建城市空间统计模型，对中国各个省市的竞争力进行综合评价。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	180
906	高校战	9787568168755	9787568168755	教育部高校思想政治工作队伍培训研修中心（东北师范大学） 	\N	1-1	32开	58.00	\N	东北师范大学出版社	\N	\N	\N	2020-11-04	/book/a5413d04-cf0f-4828-93c2-f464e5ba0e089787568168755.jpg	本书通过充分挖掘高校优秀辅导员抗疫过程中的典型事迹，集中展示全国20万高校辅导员在特殊时期引领守护3700万大学生的良好风貌，彰显高校一线抗击疫情的思政力量。全书共分三篇。（一）学习篇反映广大辅导员立足本职工作，深入学习领会习近平总书记关于新冠肺炎疫情防控的系列重要讲话精神，特别是给北京大学援鄂医疗队全体“90后”党员的回信精神的心得体会。（二）行动篇展现广大辅导员围绕学生思想引领、安全管理、心理疏导、学习生活指导等开展的战“疫”实践，特别是武汉市、湖北省辅导员投身抗疫主战场的典型事迹，以及全国辅导员对湖北籍学生关爱支持的典型做法。（三）思考篇展示广大辅导员把握战“疫”育人契机，提炼抗疫精神，总结抗疫经验，探索工作规律，深化对中国共产党领导和社会主义制度优越性的认识的标志性成果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	943
907	幼儿教育政策与法规	9787568168373	9787568168373	马焕灵 	\N	1-1	32开	39.80	\N	东北师范大学出版社	\N	\N	\N	2020-09-01	/book/39e7a649-0cd1-4835-9768-49a8cd07e44c9787568168373.jpg	《幼儿教育政策与法规》以教师资格考试改革、工学结合以及“互联网+”新形势下的教育教学需要为目标，内容前沿，思政育人，体例新颖，是一本齐聚科学性、理论性、实践性的 “教考训”一体化新形态精品教材。该教材旨在提高学生和幼儿教师对幼儿教育政策与法规的正确认识，有效帮助学生提高幼儿园教师资格考试通过率，打通职前职后培养壁垒。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	757
908	物理课程与教学论（第二版）	9787868159395	9787868159395	于海波 	\N	2-2	32开	48.00	\N	东北师范大学出版社	\N	\N	\N	2019-06-01	/book/c08c1de8-c6a8-4836-9c44-11b783060f4c9787868159395.jpg	本书结合国家基础教育课程改革和物理教育发展的新形势，从我国物理教育的实际出发，分析探讨物理教育的基本理论和物理教育改革的热点问题。 为了更好地达到培养理想物理教师的目的，本书在编写过程中力求突出以下价值：一是增进学习者对物理课程与教学发展历程和未来趋势的全面认识。二是强化学习者对物理课程与教学理论知识和思想的理解与领会。三是帮助学习者掌握物理教学的基本方法和技能。四是提高学习者思考和解决物理教学问题的能力。五是培养学习者严谨的学术精神和科学的价值追求。 从整体而言，本书在撰写中力图凸显如下几个特色：（1）体系完整。本书撰写的五个模块基本囊括了课程与教学论的主要内容，并在撰写中努力打通各模块之间的壁垒，使之纵向贯通、横向联系、逻辑严密。（2）凸显理论。（3）关注实践。本书编写注重兼顾理论的头脑、学术的思维、实践的指向。（4）难度适当。（5）体系开放。为此，本书提供了丰富的学习资源、开放的学习问题和公共的学习平台。（6）力争新颖。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	406
909	欢欢喜喜中国年	9787568172691	9787568172691	梦幻岛 	\N	1-1	其他	168.00	\N	东北师范大学出版社	\N	\N	\N	2020-10-01	/book/f7d65432-c640-47ba-a774-5bd617759afe9787568172691.jpg	这本有趣的立体书将带领小朋友们走进一个节日风情盎然的新年欢乐之旅。书中藏着过年的知识，让孩子们能够从中了解年的由来、介绍有趣的年俗和丰富多彩的新年活动。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	880
910	万物生长·二十四节气	9787568171007	9787568171007	张从众 	\N	1-1	其他	53.00	\N	东北师范大学出版社	\N	\N	\N	2020-08-01	/book/6237f885-ce75-4dce-b607-4ee419dbce399787568171007.jpg	本书讲述了二十四节气的由来和历史发展，通过“概述”“气候”“农事”三部分介绍了每个节气的征候，向孩子普及了天文、地理、气象、农业知识。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	409
912	幼儿园区域游戏50问	9787568182249	9787568182249	祝晓燕 张皎红 赵娜 	\N	1-1	16开	51.00	\N	东北师范大学出版社	\N	\N	\N	2021-07-01	/book/17514261-78fe-4e6c-bf27-b66a4aa768429787568182249.jpg	“区域游戏”的内涵也是“儿童发展”，《幼儿园区域游戏50问》一书主要内容是如何基于幼儿的学习特点规划空间、提供材料，如何组织与指导区域游戏，以促进幼儿全面和谐地发展。这是“区域游戏”质量的重要评估内容。新手教师需要掌握班级各个区域创建工作中最基本的概念、要求和原则，以更好地支持幼儿的发展，进而不断地反思并改善教师“区域游戏”的创建过程及师幼互动过程。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	419
913	管理团队信息化领导力	9787568170956	9787568170956	闫寒冰 	\N	1-1	16开	49.00	\N	东北师范大学出版社	\N	\N	\N	2020-08-01	/book/ac101715-1d7a-4871-8f34-dd3f91daf6c09787568170956.jpg	《管理团队信息化领导力》一书的内容主要包括能力提升工程2.0的要义、学校信息化发展的变革、学校信息化教育教学发展规划、校本研修活动的设计、组织实施的要点剖析。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	986
914	乐读子学	9787568162531	9787568162531	韦丹 	\N	1-1	16开	29.00	\N	东北师范大学出版社	\N	\N	\N	2019-09-01	/book/d85c96ec-08c8-4be2-a102-fb1d614925bf9787568162531.jpg	子学即先秦诸子之学，指春秋战国时期诸子百家的学术思想。本册是从先秦诸子的文集中选取为数不多的篇章，以“立志之道”“修身之道”“成事之道”“为学之道”“自然之道”为分类，考虑了经典性、可读性、教育性，体现了诸子在人格修养、为人处世方面的思考。本书选文遴选结合了对青少年人文素养、道德情操的培养。体例上，每一课都包含了“原文”“注释”“译文”“赏析”“贯通古今”“知识链接”，对难以理解的诸子经典既有文字上的疏通，又有理解上的引导。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	902
915	职通英语综合教程3（第二版）	9787568157339	9787568157339	安晓灿，王朝晖，段成 	\N	2-11	大16开	39.80	\N	东北师范大学出版社	\N	\N	\N	2019-04-01	/book/b926b6a1-829b-48b5-88de-f26492e429b09787568157339.jpg	本套教材以落实立德树人为根本任务，结合国内高等职业教育英语教学现状和我国社会经济发展对高职学生英语综合应用能力的要求编写而成。该套教材共包含2个级别，每级由《综合教程》《教学参考书》《单元跟踪测试》及配套的音视频资源和PPT课件组成。 本教材以言语功能为主线设计教学内容，以话题为中心展开每个单元，突出相应的语法项目和词语表达。话题涵盖文学艺术、审美情趣、职业选择、企业使命、技术应用、绿色发展等。单元内采用模块化设置，包含听力与表达、阅读与写作、巩固与拓展三大板块。教学目标设计明确，练习活动设置活泼新颖。图文并茂，版式生动，音频模仿真实场景录制。同时，教材注重立体化资源建设，制作点读、在线题库等交互式小应用，精心录 制了微课、视频，精选了图片、案例、阅读材料等，利用互联网技术嵌入到纸质教材中，便于学生利用多渠道、多载体进行自学。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	700
916	保育工作入门	9787568181921	9787568181921	马兵 邓如 	\N	1-1	16开	36.00	\N	东北师范大学出版社	\N	\N	\N	2021-07-01	/book/7c1a9859-378c-450b-9fad-46c6e2691df89787568181921.jpg	本教材结合了职业学校幼儿保育教学要求，介绍了保育员工作的基础内容，分别阐述了0-3岁儿童及3-6岁儿童的保育工作，并阐明了保育与教育工作结合的重要意义。本教材帮助学生在掌握保育知识的基础上，熟悉各年龄段婴幼儿的保育重点。该教材包含了诸多生动活泼的教学小栏目，旨在引发学生进行自主思考，切实为保育员日常工作提供了培训方法和实践技能。本教材适用于职业学校幼儿保育专业，也适用于托幼机构及广大幼儿教育爱好者。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	164
917	婴幼儿行为观察与分析	9787568181785	9787568181785	张文军 艾桃桃 	\N	1-1	16开	38.00	\N	东北师范大学出版社	\N	\N	\N	2021-07-01	/book/85bccc35-5bd3-4d3b-a39e-ad6635cdc4ca9787568181785.jpg	本教材从婴幼儿行为观察与记录的体系出发，分别介绍了婴幼儿行为观察概述、婴幼儿行为观察的方法、0-3岁儿童生活活动的观察与分析、3-6岁儿童生活活动的观察与分析等内容，并提供了实践的案例引导学习者结合现状思考和分析问题，力求培养学习者的观察记录和分析解释的能力，使其能够根据婴幼儿的发展水平提出适宜的指导方法。本教材适用于幼儿保育专业学生，也适用于托幼机构及广大幼儿教育爱好者。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	598
918	新课改下高中物理教学研究与实践	9787568183819	9787568183819	贾玉兵 	\N	1-1	16开	45.00	\N	东北师范大学出版社	\N	\N	\N	2021-09-01	/book/3874cc66-c36b-47e1-a524-3a2f0420b7439787568183819.jpg	本书是笔者在二十余年高中物理教学实践中撰写的教学反思、问题探索、教育科学研究等教研成果，主要包括教学问题研究、课堂教学设计、学生能力培养和教育课题研究等内容，反映了新课程改革背景下高中物理课堂教学模式的革新，教学手段从“粉笔加黑板”向多媒体融合的信息化教学方式的转变，教师的专业成长历程等。本书从物理教学实践中遇到的问题研究开始，到提高课堂效率、增强教学效果的教学示范，再到学生能力的培养、教育课题的研究，实现物理教育教学的深入思考、研究和提高，按照年轻教师成长规律设计，由浅入深，既是自己的成长过程，也为年轻教师提高理论功底和教学水平提供借鉴。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	845
919	常见园林植物的识别	9787568184793	9787568184793	熊缨 	\N	1-1	16开	50.00	\N	东北师范大学出版社	\N	\N	\N	2021-10-01	/book/bbf9cbfc-c640-4676-b516-3fbcc49819569787568184793.jpg	本书讲述了园林植物对环境的保护和改善以及在景观建设中的作用，讲解了园林植物的分类和命名、植物的鉴定和检索，介绍了常见的园林蕨类植物、裸子植物、被子植物及其特征，并进一步举例示范了如何对常见的园林植物进行识别应用。 为了便于没有专业基础的读者理解，书中插入了大量图片进行详细讲解，并提供了近两百种常见园林植物的照片，方便读者对照识别。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	324
920	艺术组织管理新论	9787568185394	9787568185394	张杨 	\N	1-1	16开	30.00	\N	东北师范大学出版社	\N	\N	\N	2021-11-01	/book/f6c11cdb-48e2-458f-84b5-06d01948ef3f9787568185394.jpg	近年来，随着文化创意产业发展，艺术市场的全面升温催化了艺术管理的产生，艺术管理在艺术组织和机构中发挥着越来越重要的作用。对于我国的艺术市场和艺术行业来说，探讨艺术组织管理对于艺术产业的发展是十分必要的。本书系统的梳理了艺术组织管理的各个环节，包括艺术组织的人力资源管理、艺术项目管理、财务管理以及艺术营销等话题。《艺术组织管理新论》可以帮着读者加深对艺术组织管理基本概念和理论的理解，也是文化产业、艺术管理研究者、政府管理者以及艺术管理从业者、爱好者的重要参考资料。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	526
921	破茧成蝶——优秀园长成长路径与管理实践	9787568183062	9787568183062	缴润凯 赵旭莹 	\N	1-1	16开	77.00	\N	东北师范大学出版社	\N	\N	\N	2021-09-01	/book/62a55d2b-5b43-4812-a957-705d1100f4459787568183062.jpg	本书主要从优秀园长的角色定位（专业职责、角色定位、自我激励、克服压力、时间管理、应对变革等）；优秀园长的管理行为与内容（幼儿园文化体系构建、课程开发与实施、教师队伍发展、幼儿园安全保障、保育与教育、环境设计与实施、后勤服务与保障、家园共育、制度管理、幼小衔接教育等）；优秀园长的成长路径（课题研究引领专业发展、有效阅读汲取教育营养、读懂儿童做专家型园长、目标管理清晰办园思路、他山之石——探寻教育真谛、研修学习丰富管理智慧、外部资源的分析与利用）；优秀园长的关键素养（坚定的政治素养、高尚的道德品质、深厚的文化底蕴、卓越的管理才能、高超的教学水平、反思和创新能力）；优秀园长的社会担当（幼儿园之间的共研、幼儿园与家庭共育、幼儿园与社区共思、优秀园长管理经验的共享）。五个章节完整阐述了一个优秀园长的养成记，内容全面，具体可实践。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	755
922	寻找地理空间的秩序——地理空间秩序思想及其在中学地理教学中的应用	9787568181686	9787568181686	张福彦 	\N	1-1	16开	48.00	\N	东北师范大学出版社	\N	\N	\N	2021-06-01	/book/d56c4baa-5214-4a94-8ff0-1f81084a484c9787568181686.jpg	本书通过对美学、建筑学、规划学等学科关于空间秩序的相关理论的梳理，概括出了地理空间秩序的基本内涵要义及特征，明确了地理空间秩序是认知领域的指导思想，是以方便学生进行空间认知为主要目的的。为了更好的指导地理教学实践，以地理空间秩序思想为线索，梳理总结出了对地理空间信息加工寻找空间秩序的方法体系。为了突显地理空间秩序思想在地理教学中的指导意义，以地理位置秩序、形态秩序、分布秩序及过程秩序四个方面进行了策略研究，更好的帮助了教师提升开展空间知识教学的有效性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	545
923	艺术教育与教学实践	9787568182997	9787568182997	高西美 	\N	1-1	16开	36.00	\N	东北师范大学出版社	\N	\N	\N	2021-08-01	/book/e4747c2c-a89d-4679-b02c-3700d7db768f9787568182997.jpg	本书阐述了艺术教育发展的历史演进，论述了艺术教育基础理论，诠释了艺术教育教学的一般原理，剖析了大学艺术教育对人才培养的影响，对大学艺术教育的改革进行了探究，论述了大学艺术教育创新人才培养体系的构建。本书分析中国高等艺术教育发展现状，指出目前存在的问题。在此基础上，从改革高等艺术院校人才培养体制、建设适应高等艺术教育需要的现代大学制度、改革高等艺术院校人事分配制度、建设高素质的高等艺术院校教师队伍、提升高等艺术院校科学研究水平、加强大学生的艺术通识教育等六个方面，全面论述中国大学艺术教育与教学改革发展的方向和路径。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	407
924	现代公共管理理论与实践研究	9787568184632	9787568184632	李旺根 	\N	1-1	16开	49.00	\N	东北师范大学出版社	\N	\N	\N	2021-11-01	/book/339eaa92-31fa-4733-87c4-8356c037ef179787568184632.jpg	所谓“公共管理”,即政府以及社会公益性部门对社会各类公共事务的管理。伴随着现代经济与社会的高度发展，人类所面临的必须予以应对处理的公共事务、各类社会问题，日益丰富多样,纷繁复杂。在现代社会中,政府的主要职能就体现在对社会公共事务的管理上。从国际角度看,政府的公共事务管理能力还被看做关系一国综合竞争力的主要构成要素,因而正越来越成为各国政府和社会关注的中心。本书属于现代公共管理方面的著作，全书主要研究现代公共管理的基础理论，并分别对其分支财政管理、人力资源、公关危机等方面进行分析，最后对现代公共管理的实践与发展进行了阐述，对从事现代公共管理的工作者有学习和参考的价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	386
925	《商补》续编(精装版)	9787811268942	9787811268942	王 锳 编 	\N	1-1	32开	58.00	173.0千字	贵州大学出版社	312	\N	\N	2016-09-01	/book/61b77f22-9f6d-4279-be05-0a417a64f6899787811268942.jpg	本书就《汉语大词典》中常见词但释义不清，语源、引文有误，词目、义项缺失、例证不充足等问题进行解释、考证、举例。尽管本书以对词条的解释、考证、举例为内容，但不同于词典的是，每词条的内容都连贯可读，可称之为一小篇精彩的汉语词汇的考证文章。每章节按词的汉语拼音排序，书稿最后有全书涉及词目的拼音索引，既体现了严谨性，也方便读者阅读、检索。具有出版价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	543
928	小江文书·高坪卷：田赋清查册	9787569102048	9787569102048	龙泽江 陈洪波 曹贤平 编 	\N	1-1	16开	62.00	456.0千字	贵州大学出版社	246	\N	\N	2018-12-01	/book/b28c50a2-101b-40ff-967b-5ecfe72b28509787569102048.jpg	笔者在天柱县一个侗族村寨调研时，意外发现了7册清代同治十三年（1874年）编造的田册，其中4册名称为《登鳌清查鱼鳞册》，另外3册名称为《清查田册呈送》。前者是地籍清册，逐坵登记了登鳌寨（清代属天柱县循礼里九甲和十甲，包括今柳寨和高坪，现已合并为柳鳌村）的田地、产量、田主等；后者是田赋清查册，逐户登记了每户的田产、等级、产量、应纳粮数量等。登鳌田册是非常稀缺的贵州少数民族地区清代社会经济史资料，其历史文献价值与学术价值不言而喻。笔者分别对其进行了整理，本书即是对三册田赋清查册的汇编。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	518
929	中观哲学	9787811266207	9787811266207	【印】穆帝 （郭忠生 译） 	\N	1-1	32开	85.00	322.0千字	贵州大学出版社	236	\N	\N	2013-11-01	/book/3101e39d-ac91-47a2-9d3c-03042ca6a2af9787811266207.jpg	中观哲学是二十世纪以来国际哲学和佛学界的重要哲学论辩思想之一，中观学派发挥了大乘初期《大般若经》中空的思想，认为世界上的一切事物以及人们的认识甚至包括佛法在内都是一种相对的、依存的关系（因缘、缘会），一种假借的概念或名相（假名），它们本身没有不变的实体或自性（无自性）。本书由十四章组成，不仅阐释中观之空的思想，而且列举其评破对象及其评破过程，但中观并未提出任何自己的观点，而是站在评论、批判的角度对其他几乎所有佛学及哲学流派加以评破，归谬其缺陷与矛盾所在，以启发人们修为的不断提升。这是一种超越哲学和佛学思维，甚至被各该评破对象嗤之以“虚无主义”的哲学理念。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	685
980	昆虫之美：勐海寻虫记	9787568917230	9787568917230	李元胜 	\N	1-1	16开	68.00	\N	重庆大学出版社	\N	\N	\N	2019-09-02	/book/e2305aba-4ab3-4dcc-9b34-a06582171d929787568917230.jpg	这是一部充满了物种情报、知识点和戏剧性故事的考察记，记录了李元胜在西双版纳自然考察空白区勐海的系统田野考察。他选择了布朗山、苏湖林区、大黑山、曼稿和纳板河自然保护区大黑山作为调查重点，分别在雨季、旱季以及雨旱季过渡期进行详细调查，发现了50多种当地昆虫新纪录。本书详细记录了这一艰难、危险但又时时有惊喜的过程，作为一个诗人兼博物旅行家，他讲述的这些亲身经历，不仅轻松有趣，还充满了对自然的情感和洋溢的诗意。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	546
930	胡适禅宗研究文集	9787811265804	9787811265804	胡适 	\N	1-1	32开	75.00	278.0千字	贵州大学出版社	288	\N	\N	2013-05-01	/book/22e783a9-286f-4384-9845-5f39d7a8ca9e9787811265804.jpg	这本禅宗研究文集，主要是收录了胡适先生有关禅宗研究的一些学术作品，包括已刊、未刊的各种专著、论文、函牍、讲演、札记。胡适先生对禅宗研究的贡献集中在两个方面：一是对禅宗历史的考实；二是对禅宗思想的梳寻、归纳。主要表现在对于禅宗史的批判研究上。他的怀疑精神和科学态度使他成为第一个利用敦煌史料研究禅宗史的学人。他对禅宗研究的最大贡献是对禅宗七祖神会和尚的研究，重新肯定了神会在禅宗史上的重要地位，指出正是由于神会的积极作用，使得慧能南宗一系能够在禅宗中取得了主流地位。这些内容，本文集中都有体现	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	787
931	丝路与佛教文化	9787811266016	9787811266016	【日】冈崎敬 等 （张桐生 译） 	\N	1-1	32开	60.00	190.0千字	贵州大学出版社	288	\N	\N	2013-08-01	/book/f381149b-ef01-4100-81b6-5527247230d69787811266016.jpg	本书由冈崎敬等8位日本学者的研究论文合集二成。冈崎敬，日本著名考古学家、九州大学名誉教授博士。冈崎敬教授从中学时代起就开始致力于考古学的学习和研究。从事考古工作后,先后主持了冲之岛等与大陆文化学关系密切的遗址发掘工作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	562
932	佛教改革家日莲	9787811266627	9787811266627	【日】井上义澄 编译 	\N	1-1	32开	65.00	257.0千字	贵州大学出版社	288	\N	\N	2014-02-01	/book/64821d57-c838-48dd-a587-822a5c94fe029787811266627.jpg	本书以日本佛教改革家日莲的生平，即从其出生、入道、求学，到广宣流布其日莲主义思想为主线，把日莲圣人的一生，及其在末法时代乃至未来世界的佛学思想传承娓娓道来，脉络清晰，故事质朴、感人。对研究日莲的人具有很高的史学价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	880
933	天台性具思想论	9787811267617	9787811267617	【日】安藤俊雄 	\N	1-1	32开	60.00	186.0千字	贵州大学出版社	288	\N	\N	2015-01-01	/book/8615e9d4-ffd6-451d-a271-1c8f315b97c79787811267617.jpg	书中认为天台实相之秘键，特别是性具说之关键，是从三法说而出发者，至三法说之解释，在相对种之思想。因此性具说的理论构造，可说全在于此。本书分前后编共十一章论述天台实相论的背景、起源、发达，从而得出结论，深及天台性具思想说。本书译者演培法师，专研天台教理，弘扬天台学说。他深入经藏，对经、律、论三藏莫不通达，誉之为三藏法师亦无不当。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	150
934	明代贵州驿道资料钩沉	9787811267525	9787811267525	闫平凡 	\N	1-1	16开	35.00	285.0千字	贵州大学出版社	144	\N	\N	2015-06-01	/book/44da6da1-b2f6-436a-9070-9290318e4f079787811267525.jpg	本书是《书不尽的贵州》丛书之一，本书稿分为绪论、总论、附录三部分。其中总论为本书的主体，分为贵州宣慰使司、思州府、思南府、镇远府、石阡府等部分。本书通过对明清方志典籍中关于贵州驿道资料的爬梳和整理，反映了驿道建设对于明代贵州建省以及后期全面开发的重大作用。全书结构合理，条理清晰，可做相关研究参考之用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	769
935	因明学	9787811267082	9787811267082	虞愚 	\N	1-1	32开	18.00	120.0千字	贵州大学出版社	288	\N	\N	2014-07-01	/book/191860fa-271c-437e-8889-4661a7284ef29787811267082.jpg	本书首次用英文的逻辑术语标注因明概念。太虚法师评价此书“根据古论疏而采择近人最明确之说，以相发明，并进而与西洋逻辑及名辩归纳诸术互资参证”。学术界对其有一定的需求量。今次我社刊行此书，无论是社会效益还是经济效益，都可获得一定收获。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	105
936	北部侗族玩山凉月歌	9787811268669	9787811268669	吴世源 	\N	1-1	16开	268.00	630.0千字	贵州大学出版社	356	\N	\N	2016-05-01	/book/c8fa3007-0fc4-4526-a86f-755f8fd93dad9787811268669.jpg	独特古老的侗族风情蕴涵于侗歌之中，侗族青年的玩山凉月民俗的全过程都渗透了侗歌精髓和魅力。本书以侗语汉字记音、侗文、汉文翻译三种方式行文，为研究侗族民歌、侗族语言文字以及侗族青年男女恋情活动——玩山凉月提供了很好的参考资料，同时对抢救、挖掘、保护和发展侗族文化具有深远的意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	441
938	文人与文化	9787811266566	9787811266566	姜澄清 	\N	1-1	32开	48.00	273.0千字	贵州大学出版社	258	\N	\N	2014-04-01	/book/bc146bc9-cafa-471c-9feb-fece3473d8049787811266566.jpg	文人画即文人所作的画，而古之画家，多系被“文“化”了的，因此，合三者以讨论，或可更亲切地知其一合之相。本书在广阔的文化背景下探讨中国绘画各层面的问题，深入浅出，饶有风趣，见解精微，文笔舒畅，足以开拓读者眼界。在本书的附录中，辑录了澄清先生辑篡的姜亮夫年谱，简要叙述了其一生；另外，还辑入了《苦瓜和尚画语录》介绍及译文，具有重要的学术价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	106
939	纯粹西江	9787569100693	9787569100693	姚瑶等著 	\N	1-1	32开	60.00	150.0千字	贵州大学出版社	196	\N	\N	2017-11-01	/book/b0f2403d-d284-4bf3-a338-343d95a97b9f9787569100693.jpg	《纯粹西江》一书主要向人们讲述位于黔东南的世界文化遗产西江苗寨。将曾经养在深闺人未识的西江苗寨的历史、风物、习俗乃至精神文化内核完整地介绍给了读者，由衷赞美了生活在西江的苗族人民的勤劳善良、质朴纯粹。 全书共分为四章，分别是西江传说、西江秀美、西江纯粹、西江天下。 西江传说一章，西江承载着苗族的的精神文化内核，苗族的图腾深深刻在西江这方土地上，随着苗族的繁衍传承至今。西江秀美中的西江由风雨桥、吊脚楼等文化传承实体组成，因而变得具象了。西江纯粹里的食物体现了苗家生活的烟火气息，读来令人垂涎欲滴。西江天下中的西江向读者描绘了西江带给人们的乡愁，那一方土地总令人牵绊，那一方山水总惹人牵挂。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	679
962	小学综合实践活动	9787569703795	9787569703795	张华 	\N	1-1	16开	32.00	\N	西南大学出版社	\N	\N	\N	2020-08-01	/book/1b781468-15ae-41ba-bfce-f6f89dc27b529787569703795.jpg	本书是“小学教育专业规划教材”之一，融合教育行政部门、高校、科研机构、一线小学各方的实践经验，内容上放低起点、减缓坡度、降低难度、便于自学，适用于高校“一专多能”全科教师的培养，适用于广大一线在职小学教师的转型培训。本书主要介绍综合实践活动课程的概述、课程目标、内容、课程资源开发、课程设计的原则与方法、课程设计过程、实施与指导、评价与管理等内容。可作为应用型本科、师范专科、高职院校小学教育（全科教师）专业教材；教师进修学校小学教师转型培训教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	103
940	“朴”释旧州	9787569100518	9787569100518	杨杰等著 	\N	1-1	32开	60.00	132.0千字	贵州大学出版社	184	\N	\N	2017-09-01	/book/7e0bbc9b-d90b-47a5-b05a-f9fa7dba68859787569100518.jpg	《“朴”释旧州》一书是“栖居贵州 特色小镇”系列丛书中的一本，是作者写给安顺旧州小镇的优美诗歌。 本书共分为四章，分别是石头颜色、人文底色、传承本色、居家特色。第一章对由石头组成的旧州小镇古朴的赞美，同时怀有对逝去时光的追忆。第二章对旧州传承六百年的人文底蕴进行歌颂，突出旧州时光的旧、岁月的长、文化的厚。第三章介绍了旧州的特色民居、服饰、食物，凸显了旧州的地域特色。第四章用虚与实、近与远勾勒了旧州小镇的时光印记、记忆轨迹。 本书语言有诗意的优美，又有写实的生动，虚与实结合，以娓娓道来的方式讲述了一个走过百年岁月的悠久小镇，向人们介绍“她”的今生前世。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	333
941	亚鲁，我的王	9787569100624	9787569100624	杨杰等著 	\N	1-1	32开	60.00	135.0千字	贵州大学出版社	198	\N	\N	2017-10-01	/book/b8376670-58cf-40ad-b60d-ff0efc6f44a99787569100624.jpg	本书依旧属于“舍不得乡愁离开胸膛”系列丛书，所以它的基调仍是通过赞颂苗族祖先亚鲁王，表达对苗族世居地文化的眷恋与向往。全书共分为四个部分，分别是骁勇为“王”、只退为“王”、感恩为“王”、大美为“王”，每部分下的三个小标题既相互联系，又各成体系。 本书语言优美，诗歌表达既有文学上的诗情画意，又有史诗的厚重与对现实的思考。文章虽然以诗歌形式写成，却内容饱满，含义深远，既对苗族几千年历史与文化进行了描摹与赞赏，也在勉励现在苗族的后人们继续继承并发扬光大苗族文化。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	720
942	苗族诗体口传经典“骚通”1	9787569101225	9787569101225	龙秀章、吴秀菊、龙进朝、龙杰、龙超 收集、整理、译注 	\N	1-1	16开	168.00	651.0千字	贵州大学出版社	268	\N	\N	2018-05-01	/book/ece7167a-ba38-4d03-99e3-c2c411f871e09787569101225.jpg	SEAD NTONGD（骚通）是东部方言苗族内流传的，对多首内容相同或相近的“SONGB SEAD颂骚”（诗歌）群集的统称，内容涉及劝善教育、结亲嫁女等各方面，其在篇幅上都是洋洋洒洒的鸿篇巨制。其既是苗族宝贵的精神财富，也是中华民族共同拥有的文化资源。对探寻中国古代诗歌的源流、演变和发展，有着非常重要的参考价值和研究意义。 本书包括“骚通”系列中的《相慕》《倾诉》《迷情》篇，其都是美丽的爱情歌，是一场场智慧的较量，口才的辩论，诗歌的比拼以及人品的鉴别等。因此通过这种方式自由爱恋的苗族青年男女，相互组合后往往都是婚姻幸福美满，家庭和谐稳定。其中《迷情》篇虽然是苗族社会不准随便传唱、传授的的 “禁歌”，但其作为骚通的一个种类，也具有独特的文学魅力和欣赏价值，也收录其中。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	857
943	翰墨华彩	9787569102314	9787569102314	马庆中 著 	\N	1-1	12开	160.00	130.0千字	贵州大学出版社	192	\N	\N	2019-06-01	/book/46763a82-80dd-44b3-9f6b-06af5c0ef3749787569102314.jpg	书稿内容包括画家的画作与画家友人入木三分的点评文章，二者相辅而成，同时，画家在序言中对自己从艺数十年的切身体悟、实践认知做了概括性论述。本作品集的主要题材为山水、人物、花鸟等，默默表达着画家对自然、社会、人生的认识和感悟。这种感悟，来源于画家对人生哲理的深刻思考，蕴含着一种锐意求新的艺术追求。 本书文字流畅，对画作的论述细致入微，图文并茂的表现方式让读者不经意间沉入其中，心魂俱醉。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	362
993	“十四五”职业教育国家规划教材	9787107357848	9787107357848	褚君浩 朱志勇 	\N	\N	16开	37.20	\N	人民教育出版社	\N	\N	\N	2022-01-01	/book/67371b13-6048-4b7d-9dbd-f410f19d9e6c9787107357848.jpg	本教材是依据《中等职业学校公共基础课程方案》和《中等职业学校物理课程标准》编写，通过教育部审定的中等职业学校公共基础课程国家规划教材。 教材编写特色： 1.注重突出职业教育特色 教材编写贯彻“加快构建现代职业教育体系，培养更多高素质技术技能人才、能工巧匠、大国工匠”的职业教育理念，将职业道德、工匠精神、科学思维等融入教材当中。教材编写过程中，坚持体现学生的主体地位，使教材内容的呈现方式符合学生的认知规律和职业教育成长规律，有关栏目设置符合学生的能力水平和教学需要，从而达到激发学生学习兴趣的目的，使得学生想学、乐学、能学、会学。 2.着力提升学科核心素养 教材栏目和内容紧密围绕物理学科核心素养进行设置和编排。例如，“物理与生活”“实践与应用”栏目将相关物理学概念与生产、生活实际紧密联系起来，帮助学生解释自然现象，解决实际问题，了解物理技术在生活中应用，渗透“物理观念及应用”；“思维与方法”栏目将物理研究的方法穿插在相应的章节当中，展现“科学思维与创新”；“实验与观察”通过观察、操作、设计等手段，鼓励学生自己动手、自己动脑、探究实践，体现“科学实践与技能”；教材还安排了丰富的案例和材料，让学生通过实例体会工匠精神，感知辉煌灿烂的中华文明，注重科技传承、树立文化自信和社会责任，培养学生的“科学态度与责任”。 3.合理安排学科知识，创新建设数字资源 教材编写紧抓基本知识和概念，突出基本物理思想和基本物理研究方法的教育。同时注意由旧知引出新知，做到深入浅出、温故知新。既与初中教材做好衔接，又注重借鉴普通高中教材编写新成果。同时，本教材设有专题网页，提供课件、视频、网络课程等丰富的配套数字资源，利用信息技术为学生营造立体化的学习环境。 4.全面渗透应用观念，兼顾物理文化教育 教材注重物理知识的应用，列举物理在生活实际、近代科学和生产中应用的实例，培养学生应用物理学知识解决实际问题的意识和能力。教材内容力求体现时代气息，选取丰富的阅读材料，能使学生了解物理文化、增加职业相关背景知识，激发学生的学习兴趣。教材坚持德育为先，注意爱国主义和科学品质教育，弘扬民族精神、时代精神。同时加强与其他文化课和专业课的配合，为学生专业技能的学习打好基础。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	653
944	金刺梨	9787569104240	9787569104240	紫丁香 	\N	1-1	32开	60.00	113.0千字	贵州大学出版社	208	\N	\N	2020-11-01	/book/c5be8d9e-f2ae-4484-8300-7ca00e1e49d69787569104240.jpg	本书以新时代诗歌地表现形式挖掘贵州脱贫攻坚英雄模范和先进奋斗的精神，通过“诗写脱贫攻坚”提振文化自信。以贵州特产“金刺梨”为题，书写一个“感恩”全国劳动模范贵州省安顺市西秀区双堡镇大坝村党支部书记陈大兴的诗歌，描述了在脱贫攻坚这场战斗中，陈大兴书记无私地付出和带领人民克服困难脱贫的事迹，赞赏了在脱贫攻坚中共同付出努力的人民和驻村干部。并且以此生动形象地介绍了安顺特产——金刺梨，以诗歌的形式描述了一幅满山刺梨花开，人民为了共同的理想辛勤劳作的美景。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	723
945	烛照苗乡	9787569103816	9787569103816	姚瑶 	\N	1-1	32开	60.00	133.0千字	贵州大学出版社	240	\N	\N	2020-11-01	/book/557c976f-0ad2-447f-aa6c-2623db722bae9787569103816.jpg	为诗意挖掘贵州脱贫攻坚英雄模范和先进典例的奋斗精神，生动诠释其“艰难困苦，玉汝于成”的奋斗姿态，为平凡英雄讴歌，贵州省诗人协会启动了“相约2020?诗写脱贫攻坚”之“长诗书写脱贫攻坚大英雄”活动，本书便是其中的一部长诗。本书主人翁为陈立群，2016年，头顶“全国名校长”光环的陈立群从任上退休，离开繁华都市和亲人远赴1400公里之外的国家级贫困县——贵州省台江县无偿支教，成为当地唯一一所民族高中校长。本书作者通过一个个鲜活、极富个性和生命意味的生活细节的描绘，体现了陈立群老师充满大爱的师者形象。作者站在深厚的苗疆大地上，以民族诗人的朴素情怀，通过多重具有民族特色的诗意生活的抒写与审美意象的构建，向我们展示了纯洁无私的人间大爱和爱所充盈的力量。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	945
952	听觉训练——和声的练习	9787569707694	9787569707694	李金华 	\N	1-1	16开	79.00	\N	西南大学出版社	\N	\N	\N	2021-05-01	/book/b53714bb-ef38-4c0f-a42c-5e747a3f2d809787569707694.jpg	书稿是湖北省高等学校省级教学研究项目成果，主要内容包括和声听觉训练中的音程与和弦、音程连接、和弦连接以及四部和声连接。这四项内容既各自独立发展，又纵向上相互关联，最终形成以和声学理论为支撑的、符合听觉发展规律的有机整体。书稿中所有文本、谱例均为原创，具有针对性强、实用性强，且便于教学和自学的内容特点。书稿适用对象为高等学校音乐专业、音乐特色中学学生，对各层次音乐类入学考试以及对音乐听觉训练有发展需求的大众均适用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	684
946	贵州省红色地名故事（上、下）	9787569104592	9787569104592	贵州省民政厅 	\N	1-1	32开	268.00	569.0千字	贵州大学出版社	592	\N	\N	2021-06-01	/book/20e1ad55-e2e5-4087-ad67-a528ef0223159787569104592.jpg	本书以红色教育和革命传统教育为重要内容，凸显新民主主义革命在贵州的历程，传承老区红色精神，发挥红色地名讲述革命、印证历史、激励后人、服务经济社会建设。本书采用图文并茂的形式，讲述地名的来历、含义、沿革和相关的红色故事，做到图片、文字互补展示贵州丰富多彩的地名文化。本书分上、下两册，收录了近200个故事，约35万余字，以红军进入贵州活动的时间先后顺序为线索，分为红七军、红八军，红三军，红六军团，中央红军，红二、红六军团，遵湄绥游击队6个部分，其内容涵盖红军在贵州境内成立的重要机构旧址、重要事件发生地、重大战斗遗址、重要人物、红色教育基地等与地名相关的故事，采用图文结合，使其更具可读性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	563
977	戏剧疗法	9787562498056	9787562498056	多洛丝·兰格利著 游振声译 	\N	1-1	\N	56.00	\N	重庆大学出版社	\N	\N	\N	2021-08-03	/book/ac9d7339-bd71-40b9-8aec-6fc2cf29db7b9787562498056.jpg	作为国内第一本关于戏剧疗法的作品，作者多洛丝?兰格利从戏剧疗法的概念、核心、理论与实践、准备工作、应用、以及与之相关的运用领域和适用人群等诸方面为读者和相关专业人士呈现了一种系统而全面的以戏剧为核心的创造性心理疗法。在本书中作者取材于自身戏剧治疗的工作经历提供了大量的典型治疗案例，描绘了戏剧疗法过程，适合有志于从事戏剧疗法的心理咨询师以及戏剧治疗、戏剧心理学课程的学生阅读。同时也适合对戏剧疗法感兴趣的社会读者。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	196
947	《历史的丰碑·六盘水卷》	9787569104448	9787569104448	贵州省作家协会 	\N	1-1	16开	890.00	375.0千字	贵州大学出版社	480	\N	\N	2021-06-01	/book/d1a9fa81-84c5-4639-a72e-701a0e5a11d99787569104448.jpg	本丛书是反映贵州波澜壮阔的伟大变革的历史画卷，是书写脱贫攻坚的奋斗史诗。站在全省的角度创作1部报告文学，由概述、各方面成效和亮点组成；站在9个市州的视野各创作1部报告文学，由反映全市（州）脱贫攻坚成效综述，各市、区、县脱贫攻坚亮点（成效），以及成绩突出、特点突出的乡村组成，共计10部：《历史的丰碑·省卷》《历史的丰碑·贵阳卷》《历史的丰碑·遵义卷》《历史的丰碑·安顺卷》《历史的丰碑·六盘水卷》《历史的丰碑·铜仁卷》《历史的丰碑·毕节卷》《历史的丰碑·黔东南卷》《历史的丰碑·黔西南卷》《历史的丰碑·黔南卷》。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	317
948	《历史的丰碑·贵阳卷》	9787569104448	9787569104448	贵州省作家协会 	\N	1-1	16开	890.00	375.0千字	贵州大学出版社	480	\N	\N	2021-06-01	/book/456019fc-6e5d-43e1-b657-3d13e4038df39787569104448.jpg	本丛书是反映贵州波澜壮阔的伟大变革的历史画卷，是书写脱贫攻坚的奋斗史诗。站在全省的角度创作1部报告文学，由概述、各方面成效和亮点组成；站在9个市州的视野各创作1部报告文学，由反映全市（州）脱贫攻坚成效综述，各市、区、县脱贫攻坚亮点（成效），以及成绩突出、特点突出的乡村组成，共计10部：《历史的丰碑·省卷》《历史的丰碑·贵阳卷》《历史的丰碑·遵义卷》《历史的丰碑·安顺卷》《历史的丰碑·六盘水卷》《历史的丰碑·铜仁卷》《历史的丰碑·毕节卷》《历史的丰碑·黔东南卷》《历史的丰碑·黔西南卷》《历史的丰碑·黔南卷》。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	800
949	儿童舞蹈作品赏析	9787569710694	9787569710694	胡伟 武巍峰 	\N	1-1	16开	58.00	\N	西南大学出版社	\N	\N	\N	2021-08-01	/book/f35ae250-d809-4d9c-8d11-112db17f89499787569710694.jpg	根据《国务院关于当前发展学前教育的若干意见》及教育部《3～6岁儿童学习与发展指南》精神，结合师资能力培养要求，系统介绍幼儿舞蹈教育、幼儿园舞蹈欣赏活动、舞蹈作品欣赏、舞蹈艺术创作、幼儿舞蹈创编、幼儿舞蹈创编方法、幼儿舞蹈排练与演出等知识；通过教学案例分析，实践训练，提高幼儿教师的应用技能与能力，帮助学生较好地掌握幼儿舞蹈训练和幼儿舞蹈创编的方法与观念，达到理论与实践的一致性、动机与效果的统一性，为幼师舞蹈教学作一定的参考。在教学过程中，教师们还可以创造性地丰富和发展它的内容，使教材更加完善，更好地发挥它的作用。书稿具有知识性、趣味性、应用性、操作性，遵循幼儿舞蹈欣赏与创编教学规律。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	288
950	特效化装的泛应用	9787569706277	9787569706277	王果 童浩原 	\N	1-1	16开	88.00	\N	西南大学出版社	\N	\N	\N	2021-05-01	/book/f6ea688e-8e78-4af1-9f16-ce78442d530e9787569706277.jpg	本书从特效化装技术的形成与发展出发，探究了特效化装的传统应用以及在新时代下电影中的运用，提出了新时代下特效化装的变化，并从“实体化装”“实体与虚拟结合化装”“机械装备”三个方面向读者阐述了特效化装的发展。具体来看，本书共六章，分别为特效化装的形成与发展、特效化装在电影中的传统应用、国内特效化装的现状对比、新时代下特效化装的发展、新时代下特效化装在多元文化中的泛应用、新时代对特效化装的展望。本书以专业的角度纵观特效化装在电影市场中的现状，分析了国外市场环境下特效化装的发展趋势与走向，探究了当下特效化装技术在国内市场面临困境时应如何寻求突破。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	864
1110	明清传奇选注	9787569517859	9787569517859	罗锦堂 	\N	1-1	16开	106.00	\N	陕西师范大学出版总社	\N	\N	\N	2021-01-01	/book/3e95396f-3a25-4f0a-983b-5d61061c90329787569517859.jpg	《明清传奇选注》选取八出明代传奇作品，如《琵琶记》的《赏荷》，《还魂记》的《游园》《惊梦》，八出清代传奇作品，如《雷峰塔》的《断桥》，《长生殿》的《惊变》《弹词》，进行讲解和注释，同时，在书后附录所选作品的工尺谱和简谱，以供戏剧爱好者参照、研究，还可借此让原音重现，一展明清传奇作品的真实面目。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	650
951	雕塑基础	9787569706260	9787569706260	陈刚 	\N	1-1	16开	56.00	\N	西南大学出版社	\N	\N	\N	2021-06-01	/book/d787b02d-265e-4288-ba03-d1de474fb9ee9787569706260.jpg	本书是“21世纪美术教育丛书”中的一种，全书分为六章。第一章内容是雕塑艺术发展简史，第二章是讲解雕塑的种类和形式，第三章内容是雕塑的基本工具与基本材料介绍，第四章内容是雕塑的技法，包括园雕、浮雕、速雕等技法介绍，第五章内容是石膏像表面效果处理，包括仿金属类、仿石材类的处理技巧，第六章是优秀雕塑作品欣赏。全书具有系统性、知识性、可操作性，讲述知识，分享经验。全书的编撰是作者多年教学心得的结晶，并根据近年来雕塑的变化作针对性的指导，可以给读者提供很好的参照作用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	619
953	陕北民歌演唱教学曲选	9787569708769	9787569708769	王颖 任洁玉 	\N	1-1	16开	49.00	\N	西南大学出版社	\N	\N	\N	2021-05-01	/book/08c5ee01-ca17-40b3-a573-a3038734287d9787569708769.jpg	陕北民歌作为我国非物质文化遗产，是陕西最具特色的传统音乐文化之一，是陕北人民思想与智慧的结晶，是我们民族文化的瑰宝。为了更好地促进陕北民歌演唱作品在高校音乐艺术院系的推广和传承，编者结合多年的教学实践和系统的教学分析研究, 精心选编整理三十余首具有较高艺术性与代表性,并且在教学中被广泛采用的陕北民歌曲目，如《赶牲灵》《船夫曲》《绣金匾》《陕北家乡变了样》等。此外，编者还将这些曲目加入了钢琴伴奏编配,并在每首作品后附加演唱提示，方便读者使用。这些作品涵盖了号子、信天游、小调等民歌类型，以经典传统曲目为主并兼有新时期陕北民歌风格。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	349
961	小学道德与法治课程与教学	9787569703894	9787569703894	刘慧 	\N	1-1	16开	43.00	\N	西南大学出版社	\N	\N	\N	2021-01-01	/book/807fba1b-1365-4cc0-ab3e-c9397ec2361a9787569703894.jpg	书稿是“小学教育（全科教师）专业系列教材”之一，融合教育行政部门、高校、科研机构、一线小学各方的实践经验，内容上放低起点、减缓坡度、降低难度、便于自学，适用于高校“一专多能”全科教师的培养，适用于广大一线在职小学教师的转型培训。书稿主要包括小学德育课程课程标准解读、小学德育课程课教材分析、小学德育课程教学设计、小学德育课程资源的开发与利用、小学德育课程活动教学、小学德育课程对话教学、小学德育课程学习等。可作为应用型本科、师范专科、高职院校小学教育（全科教师）专业教材；教师进修学校小学教师转型培训教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	598
954	课堂教学技能	9787569708684	9787569708684	张凌洋 张学敏 谢欧 	\N	1-1	16开	58.00	\N	西南大学出版社	\N	\N	\N	2021-05-01	/book/379c345f-62a9-4560-a3d4-1507469cf1749787569708684.jpg	选题结合现代教育领域的新发展新理念，立足现代教师专业发展的要求，基于学生“学”的立场和教师“教”的立场，将内容分为九章。第一章着重介绍了课堂教学与课堂教学技能的一般理论；第二章探讨了基于教师教学素养的课堂教学技能，主要包括教学体态、教学语言、教学板书、教学管理等四个方面；第三章为基于设计层面的课堂教学技能，主要包括教学设计的分析技能、教学目标的设计技能以及教学策略的设计技能；第四章为基于环节层面的课堂教学技能，主要包括教学的导入、过渡和结课；第五章为基于方法层面的课堂教学技能，主要包括课堂讲授技能、课堂问答技能与课堂演示技能；第六章为基于不同课型的课堂教学技能，着重介绍了实验课、活动课、探究课三种较为常见的课型的基本技能；第七章为基于教学测评的课堂教学技能，主要包括教学测量与教学评价；第八章为基于现代技术的课堂教学技能，重点讲解了多媒体教学技能、微课、慕课与网络直播教学技能；第九章为课堂教学艺术，着重讲解了课堂教学艺术的基本理论、表征形式以及教师如何形成自身独特的课堂教学艺术。本书适合作为普通高等学校教育类专业的教材使用，也可作为相关研究人员和实践人员的参考读物。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	549
1008	新中国小学教育研究70年（数学卷）	9787107345463	9787107345463	刘京莉,张春莉 著 	\N	\N	16开	65.90	\N	人民教育出版社	\N	\N	\N	2020-08-01	/book/72645917-0506-4e89-911d-2896c17df9929787107345463.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	691
955	0-3岁婴幼儿早期教育活动设计与指导	9787569707892	9787569707892	胡红梅 王书 	\N	1-1	16开	39.00	\N	西南大学出版社	\N	\N	\N	2021-05-01	/book/028c5e65-3e3b-4e13-8569-77fd083f5e259787569707892.jpg	书稿以培养0-3岁婴幼儿积极主动的学习品质为指导原则，努力开发主题统一、材料统一或场景统一的早教课程，力图避免现有早教课程中游戏转化生硬、缺乏连贯性等问题。课程内容涉及婴幼儿动作、语言、艺术、认知、社会与情感、自我照护等发展方面的核心经验。课程的编排符合婴幼儿的生活经验和身心发展的年龄特点。书稿还详细罗列使用者在运用过程中可能遇到的任何困境及可使用的解决问题策略。选题适用于早教中心、亲子园、儿童活动中心等机构，也可以为广大家长科学育儿提供参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	106
965	花腔女高音精选曲集	9787569704679	9787569704679	林弥忠 刘子殷 	\N	1-1	16开	68.00	\N	西南大学出版社	\N	\N	\N	2020-12-01	/book/928150a6-e435-4a7d-bbfd-46d9a87236a69787569704679.jpg	花腔女高音是美声唱法中具有花腔技巧的女高音，换言之，就是主要在高音区的炫技演唱，音域比一般女高音还要高。学习花腔唱法的学生常为找谱子而大伤脑筋，目前市面上各个声部的乐曲集版本很多，有的偏重女高音、男高音，有的则偏重收法、德、奥、俄作品，几乎没有专门针对花腔女高音声部的声乐曲集。 《花腔女高音精选曲集》一共精选了16首花腔女高音作品，这些作品大部分为国内首次出版，作者为每一首乐曲还编写了非常实用作品介绍和演唱提示。本书是面向音乐院校专业学生、师范院校音乐专业以及艺术考生的声乐教材，所选曲目大多是有高度艺术性、音乐会常常选用，但目前国内出版书目中难以寻找的乐谱，对拓宽花腔女高音的曲目演唱范围有积极的意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	668
956	婴幼儿语言发展、评估与活动指导	9787569709889	9787569709889	徐莉 莫立芸 	\N	1-1	16开	42.00	\N	西南大学出版社	\N	\N	\N	2021-09-01	/book/fb42378d-554f-4150-8b13-39d2fede56e69787569709889.jpg	本书可作为早期教育师资培训专业教材，为亲子园、早教中心及儿童活动中心等机构开展婴幼儿活动提供专业参考。本书将梳理0—3岁婴幼儿语言生理、语言心理发展的基本轨迹，结合语言作为儿童早期社会交往、符号认知、文化习得等背景，分解语音、词汇、语法、语用在婴幼儿每一个关键阶段的发展特点与规律；根据家庭生活、早教机构以及幼儿园教育的需要，在全纳教育环境中设计适应婴幼儿语言发展的教育活动。这些活动取材于生活实际，注重亲子关系、师幼关系互动，合理运用辅助沟通系统，将有益于促进婴幼儿语言的听、说能力，同时拓展其早期的阅读、涂鸦、书写能力。同时，帮助读者了解判断婴幼儿语言发展过程中的一般性与特殊性，并提出应注意的问题。全书提供活动案例设计作为教育活动的参考，并讲解活动设计原理，以使案例在不同的环境下具有可供调整的空间，帮助读者灵活运用，使其都能接纳各类婴幼儿的多样性并视之为机会，让学习环境更加丰富。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	431
957	网页设计	9787569709858	9787569709858	王立峰 张毅 	\N	1-1	16开	72.00	\N	西南大学出版社	\N	\N	\N	2021-08-01	/book/bd85caeb-2c74-48b4-b880-ed6a4f0a438c9787569709858.jpg	全书共有四章：第一章网络话起、印象初立，第二章技术探究、媒体鉴识，第三章元素碰撞、设计创新，第四章潮流玩转、经典涅槃。本书立足于视觉传达设计艺术的特点，从新时代、新形势下的互联网的作用与网页的特点出发，以网络的发展为依据，详细阐述了网页设计的理论与技术原理，并结合网页设计与时代变化的紧密性、技术发展的同步性、艺术变革的共存性，对网页的设计标准和技术发展做了探索分析和趋势展望，为网页设计教学注入前进的动力。书稿从网页设计的基础知识、网页设计的技术变迁、网页设计的组成和网页设计的流程等方面进行讲解，使学生能够充分掌握网页设计的基础知识和方法。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	823
958	书籍设计	9787569701203	9787569701203	卢上尉 曾珊 	\N	1-1	16开	59.00	\N	西南大学出版社	\N	\N	\N	2020-08-01	/book/ec6ad390-790f-468b-87a2-63e0762202299787569701203.jpg	《书籍设计》是“设计新动力”系列丛书中的一种。本书以书籍设计为主题，由浅入深、由表及里地从书籍的外形、结构到书籍的神韵、精神等分析书籍设计的各个环节，以及如何在各个环节中把握统一原则。全书由六个篇章组成：叩问“书籍”、领会书“神”、打造书“形”、揣摩书“韵”、再闻书“香”、倾注书“魂”，用生动轻松而富有诗意的语言带领读者去体会书籍设计所承载的精神力量。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	334
959	形式语意	9787569701197	9787569701197	彭芳燕 	\N	1-1	16开	59.00	\N	西南大学出版社	\N	\N	\N	2020-07-01	/book/0aba4c55-aee9-4f19-a16e-2c799ae1227a9787569701197.jpg	本书拟从视觉基本元素点、线、面，图形的组合与形成入手，论述形像呈现与形式规律，阐释形像秩序背后的话语意义。基于视觉设计画面，渐进探讨视觉基本元素、组合方法、构成规律、语意表现的设计思维过程。将平面构成、图形创意、版式设计等视觉传达设计科目进行关联整合；并结合符号语意、形式知觉深入分析。以跨界贯通的方式对视觉传达基础教学的内涵与外延进行阐述。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	885
960	早教机构运营管理	9787569707465	9787569707465	孟庆玲 	\N	1-1	16开	43.00	\N	西南大学出版社	\N	\N	\N	2021-08-01	/book/c2350710-e339-4913-9cc3-b5fba139c3209787569707465.jpg	0—3岁是孩子发展的重要阶段，若没有专业的指导，很容易在保教与管理的过程中出现疏漏或错误。本书稿以儿童身心发展水平与社会需要为线索，强调政府在早期教育中的作用。具体包括以下内容：婴幼儿保教与社会发展；婴幼儿发展与保教；婴幼儿保教目标；新生儿期的保育与教育；乳儿期婴儿的保育与教育；幼儿前期儿童的保育与教育；保教机构创办与管理；早教机构的质量认定与管理。以儿童身心发展水平与社会需要为出发点，强调政府责任，突出质量管理。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	843
978	常见两栖动物野外识别手册	9787568924252	9787568924252	史静耸 	\N	1-1	32开	58.00	\N	重庆大学出版社	\N	\N	\N	2021-07-15	/book/dc482820-fa7f-48c9-a0b5-7249dc6bfc199787568924252.jpg	本书收录了在中国分布的300 余种两栖动物，约占中国两栖动物种类总数的一半，绝大多数的科、属均有所涵盖。其中，着重收录了中国特有物种，同时也介绍了一些常见的外来引进、入侵物种。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	682
963	心理诊断学(第3版）	9787569704730	9787569704730	张仲明 	\N	1-1	16开	64.00	\N	西南大学出版社	\N	\N	\N	2021-07-01	/book/b0197f7d-8a2b-43e9-8078-94b8f2f344749787569704730.jpg	稿系“高等院校应用型专业心理学系列教材”之一，是西南大学规划教材。选题自出版以来经过多次重印，此次根据心理诊断学的研究进展和发展成果以及在使用过程中读者的反馈，进行修订。本书共十三章，即第一章绪论、第二章心理诊断过程、第三章心理诊断的基本理论、第四章资料的收集整理和分析、第五章心理诊断的基本技能、第六章心理诊断的同盟关系建立技术、第七章心理诊断的症状学基础、第八章一般和严重心理问题的诊断、第九章神经症的诊断、第十章心理问题的病因诊断、第十一章心理问题的定性和定量诊断、第十二章精神病及人格障碍的诊断、第十三章中学生常见心理问题的诊断。此次修订对一些章节进行改写，使逻辑层次更加清晰，内容更加系统，同时增加了案例解读，并对拓展板块中的内容进行替换，以便提升图书的可读性。选题适合作为高等院校相关专业的本科教材使用，也适合作为社会机构培训心理咨询人员的培训教材使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	484
964	设计思维与艺术表达——动画设计	9787562197935	9787562197935	郭宇 	\N	1-1	16开	59.00	\N	西南大学出版社	\N	\N	\N	2020-10-01	/book/1aa47234-e48b-453a-a89a-a86244379ab99787562197935.jpg	本书是训练动画人设计思维及艺术表达的实用技法书籍。本书根据动画制作的流程环节，分为三个部分：第一部分讲述动画设计思维的基本概念；第二部分（第二章到第六章）讲解动画创作各环节中的设计思维及技巧；第三部分是一些案例分析。本书主要针对动画创作中的设计思维方式进行讲解，具有针对性强、内容丰富的特点，全书力求做到理论精简、思路开阔、案例具有启发性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	981
1133	“一带一路”大型系列丛书.	9787566019059	9787566019059	阿苏 	\N	1-1	16开	42.00	\N	中央民族大学出版社	\N	\N	\N	2021-05-01	/book/f9a74cfe-06fe-4b89-a92f-58993595e11e9787566019059.jpg	作者坚守“地方主义”的写作姿态，展开个人的思索和想象，以“内心地理”为主线，从身边的边疆一直写到心灵的家园，既抒发对家乡一山一水、一草一木的满腔热爱，也暗含作者对于祖国边疆的深切感情。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	490
966	特殊需求儿童融合教育手册（上册）	9787562148227	9787562148227	张文京 	\N	1-1	16开	90.00	\N	西南大学出版社	\N	\N	\N	2020-01-01	/book/a9b21e15-51cb-449b-89d9-571271d6343f9787562148227.jpg	本书是提供给融合教育中有特殊教育需求的小学一至六年级孩子们的支持性学习手册。 该书包括三大部分内容：学校适应、学习、自我成长。其中，学校适应部分包括：适应学校环境、遵守学校常规、人际沟通、参与活动、品行。学习部分包括：与学校同步的语文和数学的辅导、学习能力与态度、学习策略。自我成长部分包括：自我引导、解决矛盾、认识自我身体等单元活动。共6分册，每年级一份册，每册学习内容与每学期学科学习基本同步，每册29课，平均每周完成两课左右。 该书内容新颖全面，既可供相关学生选用，也可供广大相关专业人士参考。 　	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	938
967	高等教育学	9787569702958	9787569702958	艾兴 	\N	1-1	16开	32.00	\N	西南大学出版社	\N	\N	\N	2020-06-01	/book/e549bcd9-df52-436e-8d5e-f0454b0f41b99787569702958.jpg	高等教育是在基础教育之后进行的专业教育或职业教育，是培养社会和时代所需要的高级人才的特殊社会活动，居于现代整个教育系统中的顶端。本书在总体把握分析中外高等教育发展历程及其特征，中外高等教育理念的哲学基础、内涵和时代特点的基础上，首先总结了中外高等教育学校制度、学位制度、招生考试制度和管理制度的演变和现状，论述制度的革新发展趋势。其次，从高等教育主体这一要素出发，分析高等教育的教育者和受教育者，即师生的角色内涵及特点，探讨和谐师生关系的建构，并基于主体关系的把握阐述高等教育德育现状及其改革对策。再次，本书聚焦高等教什么，学什么，怎么教，怎么学，解读高等教育课程与教学独特内涵，阐述课程与教学的原则、模式和方法等。最后，本书结合当代的社会发展背景，对中外高等教育发展趋势进行了深入探讨。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	588
968	《宋代蜀文辑存》校补	9787562484264	9787562484264	傅增湘、 吴洪泽 	\N	1-1	16开	780.00	\N	重庆大学出版社	\N	\N	\N	2014-12-17	/book/8aa4451c-ae5d-4d4c-ad91-c5b44df1f54b9787562484264.jpg	本书为古籍整理著作（2013年度国家出版基金资助项目，2011—2020年国家古籍整理出版规划增补项目，国家社科基金重大委托项目“巴蜀全书”工程“精品集萃”系列子项目之一），全书分为六册，共一百卷。本书对蜀人傅增湘历时十六年编成的巴蜀地方文章总集《宋代蜀文辑存》作了重新整理、点校、补辑，并新编了《篇目分类索引》，集校注、考证、检索功用于一身。本书丰富了有关蜀学的研究手段，一方面弥补了《宋代蜀文辑存》相关研究的不足，促进了蜀学文献研究的发展，为巴蜀断代文献研究打下了坚实的基础；另一方面也为弘扬传统文化、建设精神文明家园，推动巴蜀文化建设，为地方经济发展、旅游开发、蜀学研究提供了信实可靠的文献资料，具有积极的现实意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	726
979	私法视野下的信息	9787562467595	9787562467595	齐爱民 	\N	1-1	16开	59.00	\N	重庆大学出版社	\N	\N	\N	2012-06-01	/book/84feea05-768a-49ad-a2dc-7a21257b32bf9787562467595.jpg	随着全球社会信息化转型的深入发展，信息已经成为一项崭新的客体进入法律的视野。在私法领域，《俄罗斯民法典》第128条明确规定，信息是和物、智力成果相并列的客体。信息的法律性质比其他任何一种客体都复杂，个人信息为人格权客体，中国应在制定人格权法时，将个人信息权明定为一项具体的人格权，和姓名权、隐私权等并列，待时机成熟再制定专门的个人信息保护法。信息财产是财产权的新客体，在信息财产立法之前，应准用民法总则和物权法的有关规定加以保护。信息财产权、物权和知识产权构成大陆法系财产法的三大组成部分。信息作为一项崭新的客体，在人格权领域丰富和完善了具体人格权制度，在财产权领域完善了大陆法系财产权的体系，是民法因应信息社会而获得自身发展的重要内因。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	669
969	中国古代禁毁戏剧编年史	9787562487654	9787562487654	丁淑梅 	\N	1-1	16开	98.00	\N	重庆大学出版社	\N	\N	\N	2014-12-30	/book/7968e49a-7307-40bb-9319-ec04ca7f9c1f9787562487654.jpg	一、本编年史收录中国古代禁毁戏剧史料起于约公元前7世纪中期，讫于宣统三年（1911）。以中国古代禁毁戏剧史事的发展变化为界，分为七个板块十三章，即导言、前论各一章（至秦末）、上编三章（西汉至南宋后期）、中编三章（金至明末）、下编三章（清初至同治中期）、后论一章（清同治后期至 1911年）、结语一章。 二、本编年史按时间先后为序，以年为基限，公元纪年在前、朝代及年号纪年在后。史事月份及月日可考的，依序在具体资料及按语中加以呈示或说明。其中，史事可推测一定年限前后的，公元纪年前用“~”表示约数；史事月份不详者系于该年末；史事年份不详而可大致推定年限者，以朝代纪年系于该年限末；个别史事年份不详可大致推定某一朝代者，暂系于该朝代末。 三、本编年史各章以小引、分段编年史及小结行文，小引介绍特定阶段禁毁戏剧史事发生的时空背景、文化环境和特定的禁毁视阈。每条史料均依时序编年，由时间、标题性提示、文献原文及按语组成。小结对这一阶段禁毁戏剧史事的特征及作用作扼要梳理和综合分析。 四、本编年史按语部分，对史料字句艰涩难明处略有解说，多关注其与戏剧史发展进程相关联的内容，依据禁毁戏剧现象涉及的时地背景、发言人身份、言论性质，以及事件发生的原因、过程、影响等，依托戏剧史展开与发展的大背景，有侧重地追踪细节、推衍问题。 五、本编年史辑释禁毁戏剧史料，遵循资料性与学术性统一的原则，前言和结语，加上各章小引和小结，力求宏观描述和准确勾勒中国古代禁毁戏剧编年史的源流和发展轮廓，从不同层面和细节上探讨与考究禁毁戏剧产生的作用、影响、力度、效应，以及其与古代戏剧史发展的伴生互动关系。 六、在参考文献增加域外研究成果部分附录的同时，还专门增列了五种索引，对禁毁戏剧史料涉及的相关剧目剧类、人名职事、名物事类及禁毁戏剧主题词词群及出现频率做了专门索引，以提高文献检索和史料利用的实际价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	716
970	社会科学研究方法百科全书	9787568907859	9787568907859	米歇尔?刘易斯?伯克 艾伦?布里曼 廖福挺 主编 沈崇麟 高勇 赵锋 主译 	\N	1-1	16开	698.00	\N	重庆大学出版社	\N	\N	\N	2017-11-03	/book/05a18259-867a-4083-a70f-00d4eca2bd639787568907859.jpg	本书是社会科学研究方法的基础工具书，是国际学术界对研究方法术语所做的系统梳理和规范。全书共收词条1100余个，涉及方法论、研究设计、定性和定量研究的基本方法等；每个词条约两三千字，在对术语做简练的定义和阐释的基础上，对术语的生成与演变、应用范围，以及与相关概念的关系等，做了深入、全面的讨论，并提供了相关的经典阅读文献。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	692
1113	古诗今选	9787569504125	9787569504125	程千帆 沈祖棻 	\N	1-1	32开	128.00	\N	陕西师范大学出版总社	\N	\N	\N	2019-02-01	/book/1771f2eb-c741-49b1-9ecd-89a3760b03e09787569504125.jpg	《古诗今选》是程千帆、沈祖棻合作选注的通代古典诗歌选本。厘清源头，囊括八代，打通唐宋，勾勒出从西汉到南宋五七言诗歌的整体发展脉络。所选1000余首诗，各体皆备，突出了各家在诗体上的特点和优点；选篇经验，对较罕见的诗体也予以充分挖掘；注释详尽，评语精到，不乏新鲜卓见。 中华民族诗心千载相续，在本书中一览无余。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	598
971	京畿协作——京津冀协同发展	9787568913867	9787568913867	孙久文 闫昊生 李恒森 	\N	1-2	16开	89.00	\N	重庆大学出版社	\N	\N	\N	2019-08-25	/book/8f41e3ed-1621-415b-b68f-17e18eea9c1d9787568913867.jpg	京津冀区域是中国创新能力最强、吸纳人口最多的地区之一，是北方经济发展的重要引擎。自2014年习近平总书记提出京津冀协同发展战略以来，京津冀协同发展战略已经上升为国家战略，成为区域协同发展战略的重要组成部分。本书从京津冀区域的资源环境与发展历程出发，分析了京津冀区域的优势条件与发展中存在的核心问题，并进一步对京畿地区的发展定位与功能布局、北京非首都功能疏解以及交通、生态和产业三个重点突破领域进行了研究。最后，本书还提出了政策保障的建议，并对未来建设京津冀世界级城市群进行了展望。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	729
972	海上通道——21世纪海上丝绸之路	9787568913850	9787568913850	陈万灵 等 	\N	1-2	16开	89.00	\N	重庆大学出版社	\N	\N	\N	2019-08-20	/book/cab18373-8a90-43a4-bbf4-aba6dde705d09787568913850.jpg	共建“21世纪海上丝绸之路”的倡议，从内涵阐释到具体行动，已经实践了5年，取得了辉煌成就。本书通过采取多视角的观察方法，比较全面地呈现“海上新通道”面貌——以“海上故轨迹”为参照，揭示古代“海上丝绸之路”历史启示，凸显沿线各国“通道新征程”；基于国际组织角度阐释“通道新机制”；基于节点国家呈现“海上新伙伴”；基于合作领域展示“海上新合作”和“海上新人文”；最后，在“海上新起点”“通道新拓展”中展望未来发展方向。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	601
973	中国科幻文学大系·晚清卷·创作一集	9787568919241	9787568919241	李广益 	\N	1-1	32开	88.00	\N	重庆大学出版社	\N	\N	\N	2020-08-29	/book/1f128bc5-699c-4037-99b0-e33c093c694f9787568919241.jpg	本书为“中国科幻文学大系·晚清卷”系列中创作一集，收录了荒江钓叟撰《月球民地小说》，该小说最初连载于《绣像小说》，共三十五回，约十三万字，未完。有配图，其中前三十二回每回配图一张，每张包含回目所概括的两部分内容，之后第三十二回重新配图，至三十五回，每回配图两张，每张分别对应回目的一句。共计四十张配图。作者“荒江钓叟”身份不详，目前未见相同署名的其他作品。 小说内容主要围绕因赃官迫害逃难南下海外的华人龙孟华展开。逃难途中龙孟华痛失妻、子，适逢日本友人藤田玉太郎发明世界上最先进的气球，得其所助，龙孟华一行人乘至各国寻亲。几经波折后寻回亲人，并得以与月球人的更高科技的气球相会，相聚后的龙家三人到月球游学，玉太郎则留在地球苦思如何改进气球。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	875
974	自闭症儿童沟通技能指导	9787568915267	9787568915267	魏寿洪 	\N	1-1	16开	88.00	\N	重庆大学出版社	\N	\N	\N	2020-10-23	/book/6d0144af-e161-4e2e-999b-f7f69df01d0a9787568915267.jpg	本书着重与自闭症儿童的沟通障碍。首先介绍了自闭症谱系儿童的沟通障碍表现，并简单介绍了评估方法和训练理论。其次，为教师的教学介绍了非语言沟通技能、语言沟通技能和沟通功能训练。很后，为家长介绍了自闭症儿童沟通缺陷的早期发现、如何在家中进行沟通技能训练，以及进行沟通训练的资源。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	393
975	特殊儿童表达性艺术活动设计与指导	9787568919883	9787568919883	周巧 李丹 谭雪莲 洪显利 	\N	1-1	16开	88.00	\N	重庆大学出版社	\N	\N	\N	2020-11-10	/book/341f91bc-803a-41a8-8ac2-c0eabab3de3d9787568919883.jpg	本书综合地介绍了表达性艺术活动的设计和开展思路。分别从美术、音乐、戏剧、游戏四个方面，介绍了活动设计的原则和方法，并给出了生动范例。每个活动设计虽然所属类别不同，但是都秉持着同样的设计逻辑，即从儿童发展的七大领域分析深入。艺术活动的表达性特征和儿童的发展领域把不同的艺术门类有机结合在一起，各有特色又系统整合地展示了特殊儿童的活动设计。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	449
976	南方丝绸之路丛书：贸易通天下	9787568908856	9787568908856	邹一清 	\N	1-1	32开	48.00	\N	重庆大学出版社	\N	\N	\N	2018-11-05	/book/5f9de87a-bac9-4e48-96d4-4075cf7b09339787568908856.jpg	对外贸易不仅促进了南方丝绸之路沿线各地的经济发展，也促进了文明的进步，促进了文明的相互沟通与交流，为欧亚古代文明的形成和发展做出了贡献。《南方丝绸之路丛书：贸易通天下》系统讲述南方丝绸之路对外贸易的产生与发展史，对外贸易在沿线的城市形成、城市经济变革中的地位和作用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	252
981	石墨烯	9787568923279	9787568923279	布赖恩·克莱格 著 杜美娜 译 	\N	1-1	\N	46.00	\N	重庆大学出版社	\N	\N	\N	2020-09-23	/book/99214d78-c26d-4d6d-9e0b-f60a684f00ec9787568923279.jpg	2004年，安德烈·海姆和康斯坦丁·诺沃瑟洛夫通过他们独特的“星期五晚的实验”开启了一场新技术革命。他们仅用透明胶带和一块石墨就分离出了石墨烯——世界上最薄的物质，只有一个原子的厚度。 两位物理学家的努力为他们赢得了2010年的诺贝尔物理学奖。现在，石墨烯及其他二维材料的应用已成为世界性的产业。 石墨烯是一种非常奇妙的物质。它是比任何金属都好得多的导体，兼具柔性和高透明度的特点，这使得制造柔性电子产品、能净化海水的分子筛、能监测健康状况的隐形文身等成为可能。而石墨烯基芯片在性能和功耗等方面都远优于相同制程的硅基芯片。以石墨烯为代表的超薄材料对世界的改变将会远超你我的预期！ 《石墨烯 : 改变世界的超级材料》（“微百科系列·第二季”）一书全面介绍了人类目前发现的最薄、最坚硬、导电导热性能最优良的新型二维碳纳米材料——石墨烯，如石墨烯的发现过程、基础结构、力学与电学特性，石墨烯及其同类二维晶体的创新应用及发展潜力，展现了石墨烯被誉为“新材料之王”、将“彻底改变21世纪”的科学依据，既有有趣的科学和技术细节，也涉及超薄材料产业的创新需求。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	149
982	中国昆虫生态大图鉴（第2版）	9787568915236	\N	张巍巍 李元胜 	0	2-8	大16开	498.00	1111.0千字	重庆大学出版社	691	\N	\N	2021-08-26	/book/b1383e75-6de2-4aa3-a701-90cde3792d1f9787568915236.jpg	《中国昆虫生态大图鉴》系百名中国昆虫分类学家、生态摄影师5年合作的结晶。本书通过大量野外生态照片以及识别特征、生活习性、分布地区的描述，图文并茂地介绍了六足总纲3纲29目2 200多种昆虫。作为国内目前*全面的昆虫物种生态图鉴，本书不仅呈现了昆虫分类系统研究的*成果，是极有价值的生物工具书，还以大量珍贵照片充分展现了自然的神秘和奇美，适合昆虫学研究者、昆虫爱好者、自然摄影爱好者等一切热爱自然的朋友们欣赏和收藏。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	105
1161	体裁与二语写作研究	9787521321852	9787521321852	邓鹂鸣、肖亮 	\N	1	16开	55.90	\N	外语教学与研究出版社	\N	\N	\N	2020-11-30	/book/c016c393-1511-4590-b90a-a598d3158e009787521321852.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	229
990	面料设计：从灵感到工艺	978-7-5669-1919-9	\N	马颜雪 丁亦 编著 	平装	1-1	16开	49.00	\N	东华大学出版社	\N	\N	\N	2021-12-01	/book/c1a72067-1845-480d-833f-3c67c8fc4b491079958.jpg	　　本书聚焦纺织面料设计的灵感、创意及不同的纺织工艺，阐述了印花面料、纬编针织面料、梭织面料的设计要素和方法，并结合具体的面料设计案例，详细展示了从设计调研、图案设计到工艺设计及最终纺织面料的设计过程。此外，本书还在最后一章引入了中国传统纺织工艺的内容，以典型的染织绣技艺为例，展示中国传统纺织文化的魅力。 　　本书图文并茂，通俗易懂，适合纺织工程、纺织材料与纺织品设计、服装设计与工程等专业的本科生或研究生及国际学生使用，也可供纺织服装行业的技术或设计人员阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	263
983	远程心电监护技术及其应用	9787568902151	9787568902151	吴宝明，储伟，曾垂省　 	\N	1-1	16开	48.00	\N	重庆大学出版社	\N	\N	\N	2016-11-01	/book/59401702-c135-4d66-9fda-c80158b5cbc39787568902151.jpg	吴宝明、储伟、曾垂省编著的《远程心电监护技 术及其应用》分为技术篇、应用篇和趋势篇三部分。 其中，技术篇在回顾远程心电监护的发展历史的基础 上，详细阐述了远程心电监护心电检测、传输、分析 关键技术；应用篇系统介绍远程心电监护在临床诊治 、预防保健、急救医学、基层医疗、科学研究与特种 医学、战场救治等领域的应用；趋势篇对远程心电监 护技术的发展趋势进行了展望。 本书是作者多年研究成果和工作经验推广的总结 ，内容丰富，资料翔实，配有100多幅插图，给出了大 量的应用案例，兼具理论和实用价值。本书既可作为 普通高等院校生物医学工程、医学等相关专业教学的 参考书，同时也可作为企业远程心电监护相关技术研 发人员、医院信息科技术人员和相关科室医护人员设 计、开发、应用时的参考资料。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	849
984	长江三峡汉代图文砖	9787562492023	9787562492023	李应兰 彭川 	\N	1-1	\N	398.00	\N	重庆大学出版社	\N	\N	\N	2015-11-01	/book/4aa98bd3-1f93-4103-8166-0724bc7e61139787562492023.jpg	本书收录了三峡地区出土的古代图文砖363种，其中文字砖140种，图案砖223种，年代大多为东汉时期。文字砖多为记年和吉语，从中可以看到中华文字从篆书，经隶书到楷书的演变过程。图案砖有车马、龙凤、人物、虫鱼等图案，除去图腾崇拜的图案，更多地记录了三峡地区古代先民的生活娱乐场景，以及对美好生活的憧憬和向往。通过这些不同形式的图文，可以深地了解三峡地区古代先民的生活态度与审美意识。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	920
1800	阶层——组织和社会运行的核心逻辑	978-7-300-30484-7	\N	【英】约翰·查尔德（John Child） 	0	1-1	0	69.00	220.0千字	中国人民大学出版社	\N	2019F1818	\N	2022-05-11	/book/cffba0fe-0577-4e82-a25e-f9f388f31be51086148.png	阶层体系在人类社会中起着至关重要的作用。当今的组织与社会实践中，人们对市场行为的关注以及对内部集体规范和团队合作的重视，使得阶层结构关系似乎不像过去那么重要了。年轻一代对阶层制度导致的不平等感到不满，但阶层体系内在的生命力与影响力，仍然在商业和社会运行中发挥着无可替代的作用。本书深入探讨了这个困扰所有组织和文化的令人困惑的悖论：阶层体系在功能上有效地组织起一切互动，但却造成了商业组织和社会中或多或少的隔阂与不平等。查尔德教授在书中不仅探讨了这种悖论，而且更重要的是，他指出了科学高效地理解和应用阶层制度的方法，最大程度地减少阶层体系的弊端。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	402
985	当太阳照进深山：重庆脱贫攻坚故事	9787568927321	9787568927321	中共重庆市委宣传部 重庆市扶贫开发办公室 	\N	1-1	16开	69.00	\N	重庆大学出版社	\N	\N	\N	2021-06-11	/book/f05cc23c-22dc-4df9-926d-d569026f1d699787568927321.jpg	太阳照进深山，大地气象万千。2012年底，新时代脱贫攻坚拉开序幕。 8年来，以习近平同志为核心的党中央把脱贫攻坚摆在治国理政的突出位置， 把脱贫攻坚作为全面建成小康社会的底线任务，组织开展了声势浩大的脱贫攻坚人民战争，完成了消除绝对贫困的艰巨任务，创造了彪炳史册的人间奇迹。这 是中国人民的伟大光荣，是中国共产党的伟大光荣，是中华民族的伟大光荣。 在伟大光荣的背后，靠着我们党的坚强领导和扶贫政策，深度贫困地区尽 锐出战、精准施策、奋力减贫，扶贫干部不畏艰苦、扎根基层、倾力扶贫， 贫困群众自强不息、顽强奋斗、努力脱贫，点点滴滴包含着为民的深情、奉 献的真情、奋斗的豪情，汇聚成决战决胜脱贫攻坚的强大精神力量，值得书写，更应铭记。2020年6月至12月，我们开展了“决战决胜、奋斗有我”脱贫攻坚故事征集宣讲活动，精心遴选减贫、扶贫、脱贫故事60篇，汇编而成 《当太阳照进深山：重庆脱贫攻坚故事》这本书。 本书从减贫故事、扶贫故事、脱贫故事三个部分具体而详细地讲述了重庆各地的精准脱贫攻坚故事。第一部分讲述了重庆市18个深度贫困乡镇通过调整优化粮经结构、发展特色高效农林经济作物等措施。第二部分讲述了扶贫干部如何在一线开展扶贫工作。第三部分讲述了脱贫道路上代表性人物等的故事。 此书正是重庆上下在以习近平同志为核心的党中央坚强领导下打赢脱贫攻坚战的闪光记忆，生动再 现了伟大脱贫攻坚精神。越把记忆擦得铮亮，让精神熠熠生辉，我们就越能 深切体悟这非同寻常的伟大光荣，就越会倍加珍惜这来之不易的伟大成就。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	502
986	纸蔷薇的绕线首饰基础教程	9787560894829	9787560894829	纸蔷薇 	\N	\N	16开	79.80	\N	同济大学出版社	\N	\N	\N	2020-09-25	/book/d221fd4b-06f3-46b0-919e-32c15114a68f9787560894829.jpg	绕线首饰是这几年刚刚兴起的一类手作品类，关于它的教程书目前市面上还没有，这本书可以填补市场上的空白。本书是针对没有基础的新手，零基础手工小白也能做出精致绕线首饰，享受自己动手创造美的快乐。详细讲解绕线首饰基础入门要点，分种类介绍使用的工具、线材、常用配件、常用石等基础知识，详细分解9种绕线首饰技能点，分步骤讲解12个绕线首饰教程，跟着纸蔷薇一起，新手能够自己动手做出独一无二的绕线首饰，也帮助已经了解绕线首饰的高级玩家解构现有的绕线首饰教程来模仿和创新。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	587
987	大学语文（第2版）	9787560861814	9787560861814	姜南 	\N	\N	16开	58.00	\N	同济大学出版社	\N	\N	\N	2021-05-25	/book/3e896311-3d3d-46bb-ae1b-03fa60af58499787560861814.jpg	本教材在第1版的基础上，根据高职业教育人才培养目标，并结合学院专业特点和办学特色，突出人文性、职业性、时代性、专业性。将《大学语文》作为"文化艺术"模块的核心课程，通过对学生加强文学、历史、哲学、艺术等人文社会科学方面的教育，以提高全体学生的文化品位、审美情趣和职业素养。本书精心遴选了文学、哲学、历史、艺术等人文社会科学方面的作品，满足语文课堂教学与学生课外阅读的需要。全书分为文学荟萃、文化长廊、人与自然、走近科学、人在职场、名家讲坛和学者之声七个单元，选文力求体现人文性、职业性、实用性和时代性的特征。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	151
988	烽火中的华盖建筑师	9787560897066	9787560897066	张琴 	\N	\N	16开	52.00	\N	同济大学出版社	\N	\N	\N	2021-05-25	/book/9990e516-5634-4b77-a282-ae5557e39d2f9787560897066.jpg	张琴，东南大学建筑学学士 同济大学城市规划硕士、博士。长年从事城市历史文化遗产保护。主持浙江省温州市古城保护规划、浙江省温州市五马街历史街区保护规划、山东省烟台市朝阳历史街区保护规划、浙江省湖州市南浔古镇保护规划、江苏省苏州市平江历史街区保护规划。 华盖建筑师事务所由赵深、陈植、童寯三位建筑师于1932年在上海组成。他们先后留学美国，毕业于宾夕法尼亚大学并都获得建筑硕士学位。事务所从创办到1952年结束，其设计作品近二百项，是上海近代最多产的华人建筑设计事务所。本书聚焦于事务所自1932年成立至1952年解散这30年间的经历。作者与这三位建筑师的后人有密切的社交关系，积累了一手的素材，文笔生动活泼，可读性强。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	220
989	四季城乡	9787560899596	9787560899596	杨贵庆 	\N	\N	16开	98.00	\N	同济大学出版社	\N	\N	\N	2021-05-25	/book/9cdcce61-4c76-44b9-a5dd-b739e20956739787560899596.jpg	本书以当前国家国土空间规划改革发展为背景，以国际国内城乡规划教学科研和专业实践为主线，记述了作者从2019年5月以来到2020年7月一年之中经历的重要专业活动事件。以一个从事城乡规划专业30多年的专业人士视角，并以同济大学城市规划系系主任和教育部高等学校城乡规划教学指导分委员会委员的身份，洞察了第一线我国城乡规划教育进程的重要切片。本书视角新颖，贯穿全书的写作方式独特，是当今我国从事城乡规划教学科研事业第一线的专业人士的观察实践。本书以事件活动记述的方式，通俗易懂，适合大专院校城乡规划、城乡地理、建筑学、风景园林学等专业的本科生、研究生的参考读物，同时可作为从事城乡规划设计、研究、建设和管理人员的业务参考，也可作为对城乡规划建设发展领域感兴趣的各界人士阅读参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	779
991	时装画表现技法	978-7-5669-1904-5	\N	黄平 	平装	1-1	大32开	59.00	\N	东华大学出版社	\N	\N	\N	2021-12-01	/book/9080b119-f06f-45c7-a18b-85f737e530bc1079962.jpg	　　本书详尽介绍了时装画艺术表现中人体的表现方法、时装效果图的各类构图形式、男女人物组合技法以及服装款式与人物动态之间的关系。本书细致讲解了常用颜料的绘制技法，生动而具体地介绍了几种常用工具在时装画中的使用技法，展示了几种常见面料服装的表现技法，同时十分全面地阐述了时装画中几种特殊技法的使用方法，并图文并茂地论述了不同形式时装画的绘制方法。特别值得一提的是，在介绍上述这些时装画表现技法与技能时，作者给大部分示例时装画附上了详尽的绘制步骤图及部分作品的创作视频，这些使初学者能较明了地感受时装画技法的表现特色，为他们熟练掌握这些技法奠定了基础。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	691
1801	蛋糕经济学：如何实现企业商业价值和社会责任的双赢	978-7-300-30299-7	\N	[英]亚历克斯·爱德蒙斯（Alex Edmans） 	0	1-1	0	99.00	250.0千字	中国人民大学出版社	\N	2021F0623	4	2022-05-01	/book/fe3c7bed-e45f-46d2-a366-000d9f4e9a9d1086179.jpg	传统的经济学理论认为，利润最大化就是企业存在的目的，本书建立了一个全新的框架对这一理论进行了反驳。作者认为：分蛋糕甚至抢蛋糕思维负面影响甚大，让企业、个人和社会陷入零和博弈的陷阱中。抢蛋糕不如做大蛋糕。本书通过强有力的论证回答了两个重要问题：经济效益和社会效益在现实中是否真的能够统一？如果真想实现经济效益和社会效益的统一，应该怎么做？	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	647
992	走进纺织	978-7-5669-1912-0	\N	朱远胜 主编 杨梅 陈敏 副主 	平装	1-1	16开	69.00	\N	东华大学出版社	\N	\N	\N	2021-12-01	/book/88ef80ae-feae-4780-94d7-d42c77db52741079966.jpg	　　本书是作者结合多年的教学和管理经验，针对纺织工业正加快转型成为“科技、时尚、绿色”的形势编写而成的，旨在帮助纺织专业的学生在学习专业知识之前，快速把握纺织全貌，形成对纺织的整体认识，为后续专业课程学习提供方向性的指导，也为给感兴趣于纺织的非纺织专业学习者提供快速了解纺织的渠道。本书主要内容包括源远流长的纺织历史、迅猛发展的现代中国纺织工业、丰富多彩的纺织纤维、纤维变成纱的奥秘、经纬交织的机织、线圈串套的针织、神奇的纤维直接成布、灿烂多姿的印花染整共八个部分，高度对接纺织产业链。学习者通过本教材的学习，能快速了解纺织历史、中国纺织工业发展史和纺织加工流程等。 　　本书既可作为纺织类专业的导论课程教材,也可为对纺织业感兴趣的读者提供参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	718
994	青少年心理发展与教育	9787107359033	9787107359033	张大均主编 	\N	\N	16开	48.00	\N	人民教育出版社	\N	\N	\N	2021-06-01	/book/b26ea57e-a4c8-42d6-bb49-b267574b50279787107359033.jpg	《青少年心理发展与教育》是由全国教育专业学位研究生教育指导委员会组织编写的全国教育硕十专业学位研究生教育通用教材。本教材依据《教育部人力资源社会保障部关于深入推进专业学位研究生培养模式改革的意见》《全日制教育硕士专业学位研究生指导性培养方案(修订)》的精神和要求编写，主要读者对象为教育硕上专业学位研究生，同时亦可供心理学、教育学等相关专业的学术型硕十研究生和中小学教师学习与参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	885
995	现代教育原理	9787107196027	9787107196027	柳海民主编 	\N	\N	16开	41.60	\N	人民教育出版社	\N	\N	\N	2011-06-01	/book/29e55924-75b8-436c-956d-e731544b6d8f9787107196027.jpg	这是教育部普通高等教育“十五”*规划教材。它的直接使用对象是全国高等师范院校教育科学学院或普通大学教育学院教育学类专业的本科生，包括教育学专业、课程与教学论专业、教育与经济管理专业、学前教育专业、小学教育专业等。该书主要有以下几个特点。指导思想明确，内容结构清晰，学科定位明确，内容的相对稳定性与学术性的统一。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	752
1005	中国百年教科书史·生物学卷	9787107340345	9787107340345	赵占良 谭永平/主编 	\N	\N	16开	198.00	\N	人民教育出版社	\N	\N	\N	2020-10-01	/book/214e77da-f9ba-48f5-b475-380693c8d1029787107340345.jpg	该书是在2010国家社科基金重大项目“中国百年教科书整理与研究”子课题——百年中学生物学教科书变迁研究的脉络研究报告的基础上修改完善而成的。该书全面概括了中学生物学教科书一百多年的发展历史，图文并茂，史料详尽。第一编从整体上概述了我国中学生物学课程与教科书的百年发展历程，第二编至第四编分别详述了清朝末年、民国时期以及中华人民共和国成立之后各个时期我国中学生物学教科书的发展情况，第五编对全书内容进行总结。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	790
996	教育学原理（第三版）	9787107265365	9787107265365	胡德海 著 	\N	\N	16开	54.90	\N	人民教育出版社	\N	\N	\N	2013-11-01	/book/db771d72-2d88-4ae9-aad2-ac3f282288279787107265365.jpg	“教育学原理”部分对整个教育学专业基础综合考试的成败具有关键性的作用，这不仅因为这部分内容在270分的必答题中占了100分的分值，还在于教育学原理方面的知识和素养对理解其他部分的知识以及提高综合与深度分析问题的能力具有基础性的作用。 这本复习指导书是完全按照考试大纲中所拟定的考试目标和考试内容的要点来编写的，与考试大纲中罗列出的问题一一对应，有助于考生有针对性地备考。本书的编写具有如下基本特点。 一是结构性。考试大纲中所给出的知识和理论要点是非常简扼的，在此基础上，我们又围绕大纲中的要点构建了一个内容结构，分层次地突出了教育学原理中的基本知识、基本概念、基本观点、基本理论、基本逻辑、基本价值以及它们背后的原理，以帮助考生形成教育学原理的知识结构和理论框架。 二是系统性。本书的整体系统尽管已由考试大纲所规定，但在分析阐释大纲中的每个问题时，我们又注重了知识呈现的系统性、问题分析的系统性以及不同知识和问题之间相互关联与相互观照的系统性，以帮助考生形成运用不同教育学原理的知识、观点和思维方式综合分析问题的能力。 三是知识性。本书呈现和突出了大量的教育学原理方面的知识点，包括基础知识、基本概念、基本观点以及围绕某些重大问题的论争在学术界出现的不同见解，知识内容比较丰富，信息量比较大，以帮助考生形成比较扎实的知识基础，具有持之有据地应对各种类型试题的基本能力。 四是学术性。本书并不是简单和肤浅地停留在教育学原理方面现成知识的阐释和各种相关教科书知识重复性地综合与梳理上，而是尽量在这其中渗透教育学原理的问题性、研究性和学术性，呈现不同观点的分歧和争论，分析其中的症结和原因，并适当反映一些理论界的*新研究成果，以提高考生的理论思维和学术素养，提升考生应对考试的内在功力。 五是丰富性。本书在突出教育学原理知识点的基础上，围绕相关问题，参考有代表性的教科书以及学术界有代表性的观点和见解，呈现了比较丰富和翔实的学术资料，以帮助考生深入理解和内化教育学原理的基本知识和基本观点，向考生提供考试时分析论述问题的可资选择的事实和材料。 六是现实性。本书适当地阐述了我国教育中的一些现实问题及其理论回应，注意了教育理论与教育实践之间的联系，以提示考生注意善心教育现实问题。提高理论联系实际地分析问题的意识和能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	431
997	现代课程与教学论（第三版）	9787107275418	9787107275418	黄甫全 主编 	\N	\N	16开	52.20	\N	人民教育出版社	\N	\N	\N	2014-01-01	/book/cd77d7e0-b9d6-46b3-8412-f36e84d1974f9787107275418.jpg	《现代课程与教学论（第三版）/“十二五”普通高等教育本科规划教材》致力于反映当代课程与教学论学科发展的全貌和教材开发的趋势，加强“课程与教学整合”和“学习为本取向”。 　　《现代课程与教学论（第三版）/“十二五”普通高等教育本科规划教材》力图融会课程（论）与教学（论），更多反映当代课程与教学改革和研究的成果，重点突出“基本理论一课程开发一班课技能”的内容结构。 　　《现代课程与教学论（第三版）/“十二五”普通高等教育本科规划教材》内容丰富，结构合理，理论性、针对性和实用性强，既便于教师的教授，又利于学生的学习。 　　《现代课程与教学论（第三版）/“十二五”普通高等教育本科规划教材》是为普通高等院校教育类专业和教师教育课程编写的教材，也可以作为各类教师培训的教材，还可以供广大校长、教师、教育行政人员、教育研究工作者以及教育类的研究生自学参考使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	993
1802	中国政治的细节：一个县的减贫治理	978-7-300-30485-4	\N	周鑫宇 	0	1-1	0	65.00	130.0千字	中国人民大学出版社	\N	2021D0881	\N	2022-03-31	/book/52d9c458-9ef4-45d8-9900-14ff61a682961086186.jpg	有效的减贫治理是如何在中国政治中实现的？为什么我国拥有超出外界想象的治理能力？本书以融通中外的话语方式，以摆事实、讲道理的方式分析了中国县域减贫案例中体现出来的“中国之治”。作者以对山西省岢岚县村庄前后三次深入调研资料为依据，以前沿政治学者的视角、深入浅出的生动语言、别开生面的文风，描绘、剖析了中国减贫治理在村庄、县域和国家层面所体现出来的政治过程。本书不但可以让中外读者深入理解中国治理背后的细节，也以雄辩的语言和扎实的学理回应了西方学界提出的前沿问题，是一本少有的既具有大众传播力、又能对外开展严肃学术对话的政治读物。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	180
998	现代教学论基础（第二版）	9787107302114	9787107302114	裴娣娜 主编 	\N	\N	16开	41.80	\N	人民教育出版社	\N	\N	\N	2011-10-01	/book/445d8f47-6ff0-417f-8576-7cfbb4a8fdf29787107302114.jpg	《现代教学论基础（第二版）》在全面梳理百年以来教学论学科从传统走向现代发展进程的基础上，深入论述了教学论学科范围内的基础理论问题，并从我国教育改革和发展的实际出发，对当前教学中的一些重大问题做出回答。 　　《现代教学论基础（第二版）》依据学科发展的理论根基，借鉴哲学、心理学、社会学等相关学科及国内外新研究成果，注重历史与逻辑、理性与非理性、确定性与非确定性的统一，力图体现学理性、前沿性、原创性。 　　《现代教学论基础（第二版）》内容丰富，结构合理，理论性、针对性和实用性强，既便于教师的教授，又利于学生的学习。 　　《现代教学论基础（第二版）》主要供全国高等师范院校教育相关专业本科生、研究生学习使用，也是教育科研人员从事教学研究的重要参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	286
999	教育心理学（第三版）	9787107297755	9787107297755	张大均 主编 	\N	\N	16开	58.00	\N	人民教育出版社	\N	\N	\N	2015-06-01	/book/f83e226d-538c-449d-933e-49cbee7d6d729787107297755.jpg	本书是教育心理学课程的教材，遵循学与教并重、相长、统一的思想原则，从理论框架的构建到具体内容的组织都强调将学科发展、培养目标、教学要求和学生需要等相结合，旨在使学生系统了解教育心理学的学科性质、理论体系、发展趋势，全面掌握教育心理学的理论和方法。 　　在结构上，本书包括基本理论、学习心理、教学心理、制约教与学的因素和条件这四大部分，既重视学科基本结构、基本知识的系统介绍、分析和探讨，又强调与教育目标、教与学的独特要求和学生的特点相结合，尽量做到科学性、前沿性和实用性的统一，着力构建中国特色的教育心理学理论体系。 　　在内容上，本书既重视学科的传承，系统介绍基础的、科学的基本知识、理论和方法，又注重反映学科发展的前沿，强调吸收国内外新近有代表性的研究成果，尤其是反映我国当代教育改革和素质教育要求的创新性成果，着力构建中国特色的教育心理学内容体系。 　　本书主要供高等院校心理学、教育学专业的学生使用，也可作为教师培训的教材，还可供广大心理学工作者和教育工作者学习、参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	202
1000	幼儿心理学（第三版）	9787107254864	9787107254864	丁祖荫 主编 	\N	\N	16开	31.40	\N	人民教育出版社	\N	\N	\N	2016-07-01	/book/411af3d4-8e3b-4f3d-acaf-2e3934ab46969787107254864.jpg	本书是人民教育出版社心理学系列经典教材之一。作为幼儿心理学课程的必修教材，其突出的特点是深入浅出、通俗易懂、便于教、利于学。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	590
1001	外国教育史教程（第三版）	9787107298103	9787107298103	吴式颖 李明德 主编 	\N	\N	16开	49.00	\N	人民教育出版社	\N	\N	\N	2015-06-01	/book/0dd41459-a34f-4df0-9af0-c8d0f4ba9d119787107298103.jpg	《外国教育史教程（第三版）》全面呈现了外国教育史的研究成果和高校教育史学科教学的新趋势，对外国古代教育史、近代教育史和现代教育史的演进过程、教育制度、教育思想等进行了系统论述，史料翔实，观点鲜明，反映了本学科发展的新成果，体现了鲜明的基础性、科学性、学术性和创新性。 《外国教育史教程（第三版）》各章提供了精练的“内容提要”和反映本学科经典成果或新发展的“阅读书目”，并附有与各章内容紧密相连的“思考题”，具有鲜明的引导性、可读性和适用性。 《外国教育史教程（第三版）》是全国普通高等学校教育专业本科生、研究生、自考生学习和使用的教材，也是在职中小学教师和教育科研人员提高教育专业素养的读物。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	127
1003	中国教材研究文库·袁微子论教材	9787107346644	9787107346644	袁微子/著 	\N	\N	16开	58.00	\N	人民教育出版社	\N	\N	\N	2020-11-01	/book/54e41721-2af9-447e-924f-6e2b0e3d649d9787107346644.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	216
1006	中国百年教科书史	9787107348464	9787107348464	王晶/主编 	\N	\N	16开	188.00	\N	人民教育出版社	\N	\N	\N	2021-01-01	/book/2a0260f0-a344-4ec7-a972-ec92d54728e69787107348464.jpg	本书是国家社科基金重大项目“中国百年教科书整理与研究”（课题批准号：10＆ZD095）的成果之一。全书从清朝末年，我国开始设置化学课程起，根据社会时代变革、课程重大变化等历史发展的脉络，分十一个时期地梳理了百年间中学化学教科书变迁的历史沿革。书中对每个时期的社会、经济、文化等背景进行了有针对性的分析，之后研究当时的教育发展、学科背景以及化学课程要求和教科书的整体情况。在此基础上，选择出具有本时期特点的代表性教科书进行剖析。剖析过程完整地描述了教科书的体系构建，全面地分析了教科书的内容特点，客观评价了教科书的教育学价值。本书在历史资料方面、化学教育学方面、在价值体系方面，对于研究化学教科书及化学教育、课程具有重大的科学价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	800
1051	历史研究基础	9787311043926	\N	汪受宽 	\N	1-1	16开	66.00	\N	兰州大学出版社	\N	\N	\N	2015-12-21	/book/2180fbb4-64cc-478c-9faa-e8e52d4b1e099787311043926.jpg	该书是古今中外学者从事历史研究方法、经验和规律的探讨与总结，吸收国内外史学方法论的新成果，总结史学论文写作的规律、技巧与方法，对研究生进行从事历史研究的目的、史学论文写作的基本方法和一般要求的指导，为使研究生更好更快地进入学术研究殿堂，促进历史人才的迅速成长打下基础。该书适合高等院校历史学专业研究生及历史研究人员参考阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	182
1007	陶行知年谱长编（全四卷）	9787107360862	9787107360862	周洪宇,刘大伟撰著 	\N	\N	16开	368.00	\N	人民教育出版社	\N	\N	\N	2021-10-01	/book/126d187d-65a9-485a-81d9-fffed1c723e69787107360862.jpg	本书以编年体形式重现了陶行知五十五年短暂而光辉的一生，全面记录了其生平、事业、著述和思想轨迹，重点呈现了其从事中国教育改造事业的时代背景、先进事迹和献身精神，并附录了陶行知去世之后有关他的学术活动大事。本书是新时代陶行知年谱研究的集大成之作，为广大教育工作者进一步学习、研究和实践陶行知丰富多彩的文教活动和博大精深的教育思想，提供了重要的思想参照和智慧借鉴。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	975
1009	新中国小学教育研究70年（英语卷）	9787107346392	9787107346392	阚维,陆洋 著 	\N	\N	16开	35.10	\N	人民教育出版社	\N	\N	\N	2020-08-01	/book/0e0b419a-39d5-4548-87d0-c2d1ce0be10f9787107346392.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	436
1010	游戏?学习?发展——全国幼儿园优秀游戏活动案例选编	9787107348426	9787107348426	教育部基础教育司/组编 	\N	\N	16开	59.80	\N	人民教育出版社	\N	\N	\N	2020-07-01	/book/14a76303-33be-4d59-bd5b-1545d3ee76559787107348426.jpg	本书为教育部贯彻落实《幼儿园教育指导纲要》《3-6岁儿童学习与发展指南》的成果，集结了从全国2900多个幼儿园游戏活动案例遴选和推荐中脱颖而出的32个优秀游戏案例，分为沙水的乐园、积木的世界、别样的构建、奇妙的探索、扮演的快乐五部分。游戏案例生动地体现了幼儿所拥有的自主、自发的探索空间，幼儿所获得的多样的学习经验，以及他们表现出来的认真专注、不怕困难、大胆设想和创造性解决问题等宝贵的学习品质；也体现了老师们对每个幼儿的关注和欣赏，对幼儿学习与发展的支持，对幼儿游戏和生活独特价值的珍视。每个案例都配了照片，生动、真实地记录了游戏过程中的精彩时刻；有些案例还配有精彩视频，既有片段性的，也有比较完整的，它们都生动地再现了游戏发生、发展的真实情景。教师通过扫描书中的二维码，观看视频，可以直观地了解游戏的整个过程，进行深入的学习和研究，反思在自身教育实践中遇到的困惑和问题，不断提高专业实践能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	484
1011	大学本科学前教育专业教材	9787107224867	9787107224867	王坚红/主编 	\N	\N	16开	31.60	\N	人民教育出版社	\N	\N	\N	2018-11-01	/book/c3690f56-0451-4bb0-8fe3-d11696bdc5d59787107224867.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	497
1012	大学本科学前教育专业教材	9787107345425	9787107345425	杨汉麟/主编 	\N	\N	16开	52.00	\N	人民教育出版社	\N	\N	\N	2020-04-01	/book/5339dc75-45d0-429c-ba06-ae28e9736e3c9787107345425.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	805
1013	幼儿园课程资源丛书	9787107233432	9787107233432	周兢/主编 	\N	\N	16开	43.30	\N	人民教育出版社	\N	\N	\N	2015-01-01	/book/93c22500-2b39-4a7d-946e-843bb8679b159787107233432.jpg	本套丛书共12册，由我国学前教育领域的知名专家学者领衔编写，涵盖了幼儿园五大领域教育，有深入浅出的领域说明、幼儿学习的关键经验、丰富的教育素材、多样的教育活动和游戏活动实例，激发教师头脑风暴，减轻日常教学负担，增强教育教学的实用性和操作性。适用于各级各类幼教工作者及幼儿园教师，同时也适合不同层次学前教育专业教师和学生选用，是教材的有效补充和丰富。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	646
1014	幼儿园课程资源丛书	9787107315961	9787107315961	刘馨/主编 	\N	\N	16开	49.00	\N	人民教育出版社	\N	\N	\N	2017-07-01	/book/d63e9186-b671-4a38-b99f-0a2654e3ccd49787107315961.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	985
1015	幼儿园课程资源丛书	9787107315244	9787107315244	许卓娅/主编 	\N	\N	16开	38.00	\N	人民教育出版社	\N	\N	\N	2018-08-01	/book/fea7cb01-a7c3-43bf-8ec3-0fc3d0a89b439787107315244.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	233
1016	当代外国学前教育译丛	9787107219122	9787107219122	［美］琳达·杜威尔-沃森等/著 苏贵民 陈晓霞/译 	\N	\N	16开	49.20	\N	人民教育出版社	\N	\N	\N	2009-08-01	/book/28c26124-209c-4b2b-9598-2e2cfa1180a49787107219122.jpg	如何为婴幼儿提供高质量的保育与教育，一直以来都是困扰家庭和教育机构的 主要问题。本书由具有多年临床医疗经验的护士、临床儿童心理学家和幼儿教育专 业博士联合撰写，以0-36 个月的婴幼儿为研究对象，有助于学习者掌握对婴儿和学 步儿进行保育、教育所必需的技能。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	493
1017	学前教育新视点丛书	9787107341199	9787107341199	李琳/著 	\N	\N	16开	45.00	\N	人民教育出版社	\N	\N	\N	2019-11-01	/book/3354776a-6f76-491e-9536-8dfba62d7c7c9787107341199.jpg	该书是一本兼具理论性和可读性的研究专著，具有很强的现实价值。 当前，在社会转型和服务型政府构建的关键期，在公平均衡、助薄扶弱的价值观成为时代发展主旋律的背景下，发展农村学前教育作为国家农村发展战略的重要组成部分，被提升至前所未有的战略高度。 本书既关注了农村学前教育发展中政府责任的理论与政策问题，又密切结合近年来农村学前教育改革与发展的实践进展，对政府主导责任的建构及其实施进行了较为深入而系统的梳理与思考，具有如下三个特点：第一，跨学科构建理论基础，提出了农村学前教育发展中政府责任边界与内容的理论框架，具有较大的理论价值；第二，结合理论研究与政策研究构建分析框架，为政策制定与落实提供了重要借鉴；第三，基于现状、结合未来发展趋势提出政策建议，为新时期政府发展农村学前教育的体制、机制提供了可资参考的思路与对策。相信本书的出版对农村学前教育发展中政府责任的理论建设和实践改进，能发挥一定程度的影响与作用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	347
1018	《3-6岁儿童学习与发展指南》解读	9787107261480	9787107261480	李季湄 冯晓霞/主编 	\N	\N	16开	35.00	\N	人民教育出版社	\N	\N	\N	2013-03-01	/book/7b2c9096-3a45-40b2-8d76-ffefe8c6e6879787107261480.jpg	2012年，教育部发布了《3-6岁儿童学习与发展指南》，这是近年来我国发布的最重要的学前教育文件。人民教育出版社出版的《<3-6岁儿童学习与发展指南>解读》是对《指南》精神的全面讲解，权威、解渴、好读！ · 权威。什么是《指南》？怎样实施《指南》？以李季湄、冯晓霞教授为首的《指南》研制专家，给出了最权威的答案。 · 解渴。围绕研制的背景、理念、具体内容，对《指南》进行了介绍和解释；从观察评价儿童的发展，到如何在生活、游戏、集体教学活动中运用《指南》，阐明了方法。 · 好读。观点切中要害，论述深入浅出，精选实践中的案例，行文流畅，一气呵成，可读性强。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	202
1019	教育康复学概论	9787565148323	9787565148323	黄昭鸣 庾晓萌 张奕雯 	0	1-1	16开	78.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2021-03-01	/book/cf5886dc-ffd5-476b-aeaf-f56173fcf1ed1080095.jpg	本书系“医学·教育康复系列”丛书（22册）理论基础系列之一分册目前大多数的特殊儿童既有接受教育的需要，又有接受康复服务的需要，为满足特殊儿童的双重需求，本书以医教结合、综合康复为基本理念，根据现代康复医学理论与障碍儿童的需要，以功能障碍类型为依据分为七大模块，构建综合康复的基本框架，书稿主要包括听觉功能评估与训练、言语功能评估与训练、语言能力评估与训练、认知能力评估与训练、情绪行为评估与干预、运动功能评估与训练、学习能力评估与训练七个方面。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	463
1020	儿童构音治疗学	9787565148231	9787565148231	张青 卢红云 葛胜男 	0	1-1	16开	79.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2021-03-01	/book/28b6244e-998d-4863-8fe9-222e52c7e82d1080097.jpg	本书系“医学·教育康复系列”丛书（22册）理论基础系列之一分册。本书借助标准化的评估和治疗工具，系统介绍运动性言语障碍构音语音功能的评估—治疗—监控—评价的康复治疗流程，并通过典型案例示范对康复治疗全过程进行介绍，加强相关从业者的临床实践能力培养。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	551
1021	近代英国人口、婚姻与家庭	9787565147500	9787565147500	傅新球 	0	1-1	16开	98.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2021-03-01	/book/4d81cfae-8874-4d61-97f2-afcd53daa1681080111.jpg	本书堪称目前国内研究近代英国人口、婚姻与家庭问题的经典之作，探讨了近代英国经济、政治、宗教、思想的变化对英国人口、婚姻与家庭带来的相应影响与变化，旨在研究英国社会转型时期的人口、婚姻与家庭发展状况，提出了在这种社会全面变革的历史进程中，经济社会条件的变化虽然改变着家庭的经济功能，但家庭的存在形式、家庭结构、家庭内部的情感却呈现出十分明显的延续性特征。这一研究表明，前工业时期的英国家庭比人们曾经想象的更接近于当代家庭模式。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	356
1022	综合康复实验	9787565148019	9787565148019	杨三华 丁忠冰 周林灿 	0	1-1	16开	58.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2021-03-01	/book/27c1a63d-e7a8-4d95-b712-6162b6181add1080119.jpg	本书系“医学·教育康复系列”丛书（22册）标准、实验实训系列之一分册，采用专业的康复设备与实验教学相结合的模式，全面介绍了综合康复实验的具体内容与方法，适用于康复治疗学、听力与言语康复学、教育康复学和特殊教育学等相关专业的教学与实践。同时，本书可用于包括构音ICF-PCT疗法、嗓音ICF-RFT疗法、孤独症儿童语言ICF-ESL疗法和失语症ICF-SLI疗法等言语康复技能疗法认证，以及康复治疗师、康复医师、临床医师和护士的临床工作指南。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	122
1023	普通话儿童语言能力临床分级评估指导	9787565148057	9787565148057	刘巧云 	0	1-1	16开	38.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2021-03-01	/book/6ee57bc0-6440-4dc0-890d-a23f3ff84c721080125.jpg	本书系“医学·教育康复系列”丛书（22册）标准、实验实训系列之一分册，作者基于儿童语言的发育规律，针对儿童的理解和表达自己的语言能力尚不成熟等特点，在长期的理论和实践研究基础上，开发了一整套的、符合科学标准的测量工具，满足了家长和社会对于判断一个儿童到底是否存在语言障碍或是处于哪一阶段水平的语言能力的需要。一套系统化、标准化的检查方法不仅能了解儿童当前的语言能力水平，还能为儿童的康复方案提供依据。作为一本针对特殊需要儿童综合康复的专业书籍，本书的文字表述简洁易懂，实用性操作性高。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	917
1024	听障儿童教育康复的原理与方法	9787565144226	9787565144226	李岩 张联驰 刘巧云 	0	1-1	16开	69.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2021-03-01	/book/81d3c7a1-ce87-4217-a426-65f616da295e1080129.jpg	本书系“医学·教育康复系列”丛书（22册）儿童综合康复系列之一分册，主要介绍了听力障碍、听障儿童的特征、听障儿童教育康复的历史沿革及现状与问题；以HSL理论与“1+X+Y”模式为核心，阐述理论并介绍以此为基础构建的学前、学龄低年级教育康复课程；关于集体教育和个别化教育康复方案的制定与实施，提供了丰富而详细的案例与解析；此外，还从家庭康复概述、家长培训和家庭康复指导三个方面对听障儿童家庭康复进行了介绍。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	301
1025	特殊儿童沟通与交往	9787565119699	9787565119699	李泽慧 	\N	1-1	16开	42.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2015-01-01	/book/2b2e990a-cb74-4abe-8745-b72fb0593be89787565119699.jpg	本书作为大陆地区第一本专门论述特殊儿童沟通与交往能力发展的专业书籍，针对目前国内不同障碍类型儿童沟通与交往发展不均衡的现状，以及特殊儿童日益增长的沟通与交往的需求，阐述了不同障碍类型儿童沟通与交往上存在的问题、特点与需求以及如何发展不同障碍类型儿童沟通与交往的能力。在结合前人经验的基础上，弥补了之前对视觉障碍儿童、学习障碍儿童、脑瘫儿童沟通与交往研究上的不足，将重点放在如何发展各类特殊儿童沟通与交往的能力上。 本书为沟通与交往能力训练工作者、有沟通与交往障碍儿童的家庭以及存在沟通与交往障碍的儿童自身提供了一些训练范例和思路。适合特殊儿童的教师、家长和其他从事特殊儿童沟通与交往能力教学和训练的专业人员，同时也是各级特殊教育师范学校培养特殊儿童师资的教学材料，促进特殊教育师范专业课程的建设。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	816
1034	儿童·国家·未来——学前教育体制机制改革研究	9787565147050	9787565147050	虞永平 王海英 张斌 等 	\N	1-1	16开	98.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2020-08-01	/book/2c392ec3-a2f6-4627-b9f2-0516617dd4479787565147050.jpg	本书为教育部哲学社会科学研究重大课题攻关项目“学前教育体制机制改革研究”的总结性成果。本书把视角置于更为宏观的儿童与国家关系之上，梳理了国内外学前教育体制机制改革方面的成功经验与失败教训，在总结经验的基础上指向未来，为建构更为合理的学前教育体制机制提供可行的思路与建议。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	864
1026	特殊儿童物理治疗	9787565119705	9787565119705	励建安 	\N	1-1	16开	55.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2015-01-01	/book/2334fc61-9677-4e8b-8a88-b64d422960939787565119705.jpg	本书共六章38节，内容紧扣“特殊儿童”和“物理治疗”两大核心概念，紧盯国内外新学术动态，针对我国不同类别特殊儿童的身心特征、疾病与障碍特点，结合专家们的临床实践，从特殊儿童的诊断、评估和物理治疗方法等方面进行了科学而严谨的描述，重点介绍了特殊儿童的训练技术要点和物理治疗方法，在坚持科学性、规范性的前提下，突出了“特殊儿童物理治疗”这一学科的专业性和创新性，部分章节内容体现了国内外新理论研究与实践成果，具有较高的学术价值和应用价值。《特殊儿童物理治疗/特殊儿童教育与康复文库》通俗易懂，图文并茂，是一本学术性、实践性、可操作性兼具的重要参考书，非常适合儿童康复专业技术工作者，从事特殊教育的教师和家长、残疾人事业社会工作者等使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	395
1803	北京师范大学数学科学学院志（1915～2020）	978-7-303-27668-4	\N	李仲来 主编 	平装	1-1	16开	198.00	\N	北京师范大学出版社	\N	\N	\N	2021-12-01	/book/00205feb-fa68-484c-b869-26bc5b6cf33d1086220.jpg	本志在简介北京师范大学数学科学学院及其大事的基础上，引入学院的机构发展、教师队伍的建设和成果、培养的各类毕业生的概述和总结、以及学院的固定资产等内容，并按年代汇总。表和录详细列举学院有关的多种翔实可靠的数据和非常难得的资料，从而增强对北京高等师范学校数学物理部和北京师范大学数学系/数学科学学院成立100多年来奋斗的历史做一个整体的了解，并为如何编写高校数学院系志提供参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	317
1027	特殊儿童心理治疗	9787565119651	9787565119651	何侃 	\N	1-1	16开	36.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2015-01-01	/book/5c0f2feb-6dc7-4c1e-996b-31e6657eb7179787565119651.jpg	本书共设八章，第一章为引论，主要论及特殊儿童心理治疗的概念、理论、方法、实务，并广泛涉及特殊儿童心理治疗的理念与模式（如三级预防）、服务对象与内容、服务方式与绩效等。具体包括心理治疗的理论述评、方法概览和模式评介，以及特殊儿童心理治疗实务。第二章至第八章则分别论述了听觉、视觉、肢体、智力障碍以及自闭症、学习障碍、情绪与行为障碍等各类障碍儿童的心理治疗；每章内容均从各类障碍儿童常见的心理问题、案例与评析、相关研究三个方面加以阐述。 本书不仅适用于高校特殊教育、儿童康复、应用心理学、康复治疗学等专业的教学，也适用于从事特殊儿童教育和儿童心理治疗相关专业人员的日常学习或继续教育，还可供关注特殊儿童成长的研究者、实践者、特殊儿童家长等参考。期望我们的研究，能帮助特殊儿童生命中的重要他人，给予特殊儿童最需要的理解和支持；也希望我们共同的兴趣和使命，可以创造特殊儿童生命中的奇迹。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	833
1028	当代中国名家双语阅读文库·贾平凹卷	9787565147227	9787565147227	贾平凹著；许诗焱，杨昊成主编 	\N	1-1	16开	38.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2020-10-01	/book/efb75e45-869b-40d4-af48-24f27194fea09787565147227.jpg	《当代中国名家双语阅读文库》共两辑十卷，分别遴选了叶兆言、毕飞宇、苏童、范小青、鲁敏（第一辑），叶弥、迟子建、赵本夫、贾平凹、韩少功（第二辑），共十位当代中国深具文化影响力的作家，精选其优秀短篇代表作，邀请英语为母语的海外汉学家或英语水平等同于母语的翻译家进行英文译介，并附评论及访谈，通过多元化的形式，凸显其文化性、时代性和趣味性。本书择选了贾平凹的四篇短篇小说，按写作年代的先后排序，分别为《土炕》《秋天》《制造声音》《猎人》，附录为对贾平凹的一篇评论和一篇采访，并邀请国外知名的汉学家或母语为英语但精通汉语的学者对上述文章进行英译，形成这本中英双语对照图书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	810
1029	中国荷文化经典读本	9787565143496	9787565143496	俞香顺 	\N	1-1	16开	92.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2021-01-01	/book/b7158610-28a5-4bc1-af6e-676e8b8b74039787565143496.jpg	本书精选历代荷花诗词文赋及相关史料笔记等核心文献，内容广及荷花与中国社会文化诸方面，如诗词歌赋、音乐绘画、园林园艺、节庆民俗、工艺装饰等，并通过对这些经典篇章、段落和文物图像的分类选注、鉴赏和通俗解说，生动、立体地阐述荷花的自然特点、社会作用、历史价值和文化意义，从而在整体上通过荷花这一深具文化意蕴的植物，展现中华文化传统的博大精深和美仑美奂。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	617
1030	中国菊文化经典读本	9787565143502	9787565143502	石润宏 	\N	1-1	16开	88.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2021-01-01	/book/05253a63-bc4c-4735-a4e9-7a63d9f37d649787565143502.jpg	本书精选历代菊花诗词文赋及相关史料笔记等核心文献，内容广及菊花与中国社会文化诸方面，如诗词歌赋、音乐绘画、园林园艺、节庆民俗、工艺装饰等，并通过对这些经典篇章、段落和文物图像的分类选注、鉴赏和通俗解说，生动、立体地阐述菊花的自然特点、社会作用、历史价值和文化意义，从而在整体上通过菊花这一深具文化意蕴的植物，展现中华文化传统的博大精深和美仑美奂。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	516
1031	世说新语导读	9787565145018	9787565145018	王青 	\N	1-1	16开	48.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2020-09-01	/book/1c94d46e-66ef-446a-b41f-75059c83eb439787565145018.jpg	本书旨在以通俗易懂的方式向读者介绍《世说新语》的作者与写作背景，并从人物与语言两方面入手，结合当时的社会状况，分析《世说新语》的写作特点、艺术价值，进而指出此本经典在文学史上的影响。本书特点是语言明白晓畅，图文并茂，并根据文本特点，在“知识链接”或“拓展阅读”栏目中配套相应的音频、微视频等数字资源。本书配套“中国优秀传统文化育人体系”课程建设，是专为高等院校学生学习中国古典文学经典作品，提高文学文化素养而编写的。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	283
1032	实验心理学（高等院校心理学融媒体精品教材）	9787565145230	9787565145230	邓铸 	\N	1-1	16开	68.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2020-11-01	/book/dbd195b1-2ee4-4b5a-9ee3-2cd9dbe52c459787565145230.jpg	实验心理学是以科学的实验方法研究人的心理现象和行为规律的学科，是心理学教学和科研不可缺少的学科。实验心理学主要介绍心理实验的基本逻辑、基本模式、常用范式和有效技术，是心理学作为科学的知识积累的主要方法学。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	703
1033	亨利·贝尔蒂尼钢琴练习曲50首	9787565125966	9787565125966	陈学元 	\N	1-1	16开	46.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2017-03-01	/book/b4d09e00-b5be-4d5b-8c8a-0442cc2b621e9787565125966.jpg	亨利·贝尔蒂尼是法国的作曲家、钢琴家，同时也是一位钢琴教师。他的作品有180多号，大多旋律优美、和声流畅、体裁丰富，其中钢琴作品的创作是其所有作品中的重中之重。本书中选用的50首乐谱均来自贝尔蒂尼的100号、29号和32号作品。其中29号和32号作品为国内首次面世，难度大约在3-6级（以《上海音乐学院社会艺术水平钢琴考级曲集》为准），是适合初级过渡至中级程度学习者使用的优秀作品。此外，这50首练习曲中有为手小，不够八度的初学者创作的《专为小手而作的简易练习曲》，以及为了衔接练习约翰·克拉默的《84首钢琴练习曲》和车尔尼的299而创作的《为预备克拉默学习的练习曲》。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	363
1035	世间的陌生人：梵高心理传记	978-7-5760-1761-8	\N	[美]艾伯特·J·卢宾 著 程应铸 译 	平装	1-1	大32开	78.00	\N	华东师范大学出版社	\N	\N	\N	2021-11-01	/book/ab6aa879-6f48-47fe-8c6c-13ba3126864a1080193.jpg	国内首部从心理分析角度解读梵高的传记作品。作者以弗洛伊德所创立的精神分析法为特独视角，以梵高遗留给世人的数百封书信和数百幅画作为“自由联想”的素材，同时运用大量的背景资料，对梵高的一生展开追踪。从他幼年的遭遇、宗教的信仰、职业的挫折、爱情的失败、对父母的叛逆、跟弟弟的复杂情感以及与同时代画家的关系等诸方面的因素来解译这位画坛旷世奇才的内心世界，对他的怪诞、疯癫，对他的割耳、自杀，对他绚烂眩晕的绘画风格做出较合理的解释。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	825
1163	演讲的艺术（第十三版-中国版）	9787521312843	9787521312843	Stephen E. Lucas 	\N	1	大16开	79.90	\N	外语教学与研究出版社	\N	\N	\N	2020-04-24	/book/0ba4da18-fef4-4dcb-9265-22f250b844db9787521312843.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	172
1036	广义相对论和引力规范理论讲义	9787311055202	\N	段一士 	\N	1-1	16开	210.00	\N	兰州大学出版社	\N	\N	\N	2019-07-17	/book/2f9bb2cd-58d5-4107-aebd-e3a6649fd13d9787311055202.jpg	本讲义是段一士教授多年来在兰州大学讲授《广义相对论》《宇宙学》《引力规范理论》的讲义手稿。包括一个简版的《广义相对论与宇宙学讲义》，一个详细版本的《广义相对论与引力规范理论》，以及一个旧版的《引力规范理论讲义》。内容包括黎曼几何，引力场方程，测地线方程，引力场方程的中心球对称解和引力效应，宇宙学基本原理，宇宙动力学方程，SO(N)规范场理论与黎曼几何，引力规范理论。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	176
1037	规范场理论	9787311055189	\N	段一士 	\N	1-1	16开	160.00	\N	兰州大学出版社	\N	\N	\N	2019-07-17	/book/4952b02a-ec5e-4f36-aa06-fe0800ef66729787311055189.jpg	本书包括四部分内容：基本的规范场理论，弱电相互作用、量子色动力学和粒子物理。基本的规范场理论部分主要介绍了SU（N）规范场理论，弱电相互作用主要介绍了粒子弱电统一模型的拉氏量和Higgs机制，量子色动力学部分主要介基本的泛函理论，QCD作用量和广义Ward-Takahash恒等式。粒子物理和现代宇宙学介绍了宇宙论中的重要参数，重子和反重子的不对称性。最后还收录了段一士教授报告的幻灯片。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	244
1038	草叶锋芒——当代文艺批评探索与实践	9787311058715	\N	阎小鹏 	\N	1-1	16开	48.00	\N	兰州大学出版社	\N	\N	\N	2021-04-07	/book/c85190dd-d1e7-4142-846c-f3d42dc131099787311058715.jpg	本书汇集了作者近年来关于现当代作家作品的批评文章，以及关于文学、文化及当代精神生活相关的文艺随笔。全书分三辑：第一辑 挑战与致敬。本辑是关于当代文学热点话题、文学现象或重点作家作品的评论文章。本辑文章均发表于国内文艺理论刊物或被收入作家专论集，均受到评论界关注或争鸣。第二辑 遐想与质疑。本辑是文艺随笔的汇集。题材涉及读书、写作、影视、阅读、时尚生活等，是作者有感而发的随便性文字，于诙谐辛辣中表明作者的文学主张和艺术观念。第三辑 品味与商榷。本辑是对中青年作家作品的评论文章，旨在培植本土作家，激励本土作家的文学创作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	349
1039	矿物药鉴别彩色图谱	9787311060152	\N	周印锁，胡芳弟，王淑华 	\N	1-1	16开	98.00	\N	兰州大学出版社	\N	\N	\N	2021-07-30	/book/55755b78-cdd6-4666-bb0d-fb7cec3105989787311060152.jpg	矿物药包括可供药用的天然矿物、矿物加工品及动物化石等。本书作者根据多年调查研究以及实地考察，发现市场中出售的矿物药存在以伪充真的现象，使伪品、掺伪品、易混品进入商品药材流通渠道，严重影响临床用药安全，危害人民健康。本书经过多年来收集的中药材市场中矿物药出现的习用品、混淆品、惨伪品、伪品等样本和第一手资料，整理编写而成。以求简便、快速地鉴别矿物真伪，正本清源，澄清混乱，以便正确、合理地使用矿物药。本图谱收集的样品均经过严格的鉴定，特别注意矿物药的鉴别特征，真伪对比明显，文字描述简明扼要，通俗易懂，是一本具有极强实用价值的工具书，可供矿物药检验、临床医疗、教学和矿物药研究以及经营管理人员应用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	634
1040	明代诗文涉医文化文献资料辑要	9787311057718	\N	高璐 	\N	1-1	16开	48.00	\N	兰州大学出版社	\N	\N	\N	2020-05-01	/book/517e8221-2cb5-45d0-8e34-607cbf5202d69787311057718.jpg	《明代涉医诗文选编》收录了明代产生的、内容涉及传统中医学的文章与诗歌，其中包括宋濂、刘基、高启、王九思、康海、王世贞等著名作家的相关诗文作品。全书分为上下编，上编为明代涉医文选，按照文体下分十一类，分别为奏疏、传记、赠序、箴铭、行状、祭文、论说、序跋、书信、像赞、笔记。下编为明代涉医诗选，按照题材分为三类，分别为赠医类、述病类、闲居类。所选作品在创作形式、内容等方面的具有独特性，同时又涉及大量关于医理、药学、疾病、养生等方面的信息，体现了重要的文学研究意义和医学文献价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	914
1041	全元诗涉医文化文献辑要	9787311057701	\N	周欣媛 	\N	1-1	16开	36.00	\N	兰州大学出版社	\N	\N	\N	2020-05-01	/book/0f18e72f-b72b-47ac-bb81-d58c511dabf99787311057701.jpg	元代是中国历史发展进程中一个较为特殊的阶段，元代涉医诗歌创作也呈现出不同于前代涉医诗歌的新气象。《全元诗涉医文献资料汇编》一书以编录于《全元诗》中五千余位元代诗人的十三万两千多首诗歌作为考察对象，总共搜集到元代142位诗人的574首涉医诗歌，涉医内容主要包括中药方剂、病证病状、养生防病、医术医技、医文交游、医理论述、因病感怀等。以杨镰主编，中华书局2013年出版的《全元诗》为主要参照，按该书原有诗人顺序进行编排，依次将涵盖以上涉医内容的诗人及作品进行呈现，力求为后续研究工作奠定基础。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	967
1042	齐家文化百年研究文丛（上、下册）	9787311057923	\N	魏文斌，唐士乾 	\N	1-1	16开	69.00	\N	兰州大学出版社	\N	\N	\N	2020-10-12	/book/1e7c4044-64e1-499b-b71c-dd2f559c37349787311057923.jpg	本书是齐家文化及西北地区新石器至青铜时代文化研究非常珍贵的文献资料。按省份，分甘青、青海和宁夏，将1921年至2017年相关齐家文化的考古资料进行了收集，包括：调查和发掘的主要居址材料、调查和发掘的主要墓地材料等。再者，对齐家文化的各类研究进行了分类整理，包括：分期、年代和源流等方面的基础研究和墓葬、玉器、铜器、生业、经济和社会等方面专题研究等。本书首次较为全面的汇总了齐家文化的考古发掘资料，为学术界利用和研读齐家文化考古资料提供便利。同时系统地汇总了齐家文化的各类学术研究，为学术界了解齐家文化研究史、明晰齐家文化各类相关问题的研究进度以及进一步深入研究齐家文化相关问题提供参照。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	728
1081	什么是材料？	9787568529914	9787568529914	赵杰 	\N	1-1	16开	39.80	\N	大连理工大学出版社	\N	\N	\N	2021-09-01	/book/d6c23ef8-ee91-4275-a516-cf716baa22019787568529914.jpg	材料科学是如何走到今天的？材料的内涵是什么？材料方面的知识和我们的社会有什么关联呢？《什么是材料》一书将为您解答这些疑问，并为您打开认识材料的窗口。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	165
1090	国际贸易实务（第五版）	9787568514583	9787568514583	马莉、戴海珊 	\N	1-1	16开	44.80	\N	大连理工大学出版社	\N	\N	\N	2018-07-05	/book/8137949f-bf78-4f9b-acb6-7c8eb887d2ef9787568514583.jpg	本教材由来自国家示范性高等职业院校的专业负责人、行业企业专家和来自不同区域的一线骨干教师共同编写。教材积极导入任务驱动式教学模式，共有磋商准备、合同磋商和合同签订3个模块，以及这3个模块下的9个学习情境，共26个工作任务。学生在学习目标、任务描述、任务分析、知识导入、任务提升、知识测试、情景再现和职场体验等模块的有序引领下完成学习。这样的体系架构，不仅遵循了外贸从业岗位的职业特点，同样有利于教学效果最大化的实现。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	160
1043	雷达文学批评访谈与研究	9787311057190	\N	张继红 	\N	1-1	16开	49.00	\N	兰州大学出版社	\N	\N	\N	2020-06-01	/book/aa68c684-4f4a-43a9-a68a-d3f1df3f53489787311057190.jpg	这是雷达先生去世后第一部系统梳理、整体研究、全方位概括雷达一生文学批评历程、文学观念的产生、文学风格的形成的编著。该著主要分为雷达文学批评历程对话、批评美学风格概括、“中国化批评方法”阐释、多元话语与意义建构、文学批评与散文作品、批评职业与批评家的宿命等六大特色内容，既勾勒了雷达文学批评主体性生成的复合语境，又以其政治话语与美学话语的整合平衡的思想结构特征，确立了雷达批评美学的整体观、本土性产生的理论资源和现实依据，是一份积极参与“中国化批评诗学建构”、彰显中国当代批评家风采的理论资料。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	378
1044	Python中文文本分析	9787311058364	\N	景永霞 苟和平 	\N	1-1	16开	58.00	\N	兰州大学出版社	\N	\N	\N	2020-12-15	/book/97a16ca2-b559-43aa-9aa7-7174a195713f9787311058364.jpg	随着大数据时代的到来，非结构化的中文文本数据快速增长，如何能够让机器自动获取这些文本数据中蕴含的有用知识显得尤为重要。因此，实现中文文本数据的预处理，将中文文本表示成计算机能够理解的形式，通过特征选择、特征抽取算法，结合词向量技术实现中文文本数据语义分析和维度缩减，并采用机器学习技术获取相应的知识，实现中文文本中蕴含有价值内容的挖掘分析。书中对中文文本处理的关键技术和实现算法进行了分析与设计，并提供了相应案例分析。本书可供自然语言处理、人工智能、文本挖掘等方面的程序员和爱好者阅读，同时，也可作为高等院校计算机类专业的参考教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	395
1045	赵俪生文集（1-6卷）	9787311056476	\N	赵俪生 	\N	1-1	16开	950.00	\N	兰州大学出版社	\N	\N	\N	2019-08-08	/book/5c6b8287-dd04-413b-bfeb-5b2eca8f23c49787311056476.jpg	《赵俪生文集》于2002年4月由兰州大学出版社第一次出版，时隔17年后，在兰州大学110周年校庆之际，出版社决定将本书共6卷重新排版印刷，以纪念赵俪生先生，并为校庆献礼。 本书作者赵俪生，新中国成立后，历任东北师范大学、山东大学、兰州大学教授，甘肃省史学会第一届副会长。早年从事苏联文学翻译和革命文学创作，以冯夷等笔名发表过不少译作、剧本和小说。后专于中国土地制度史和中国农民战争史。晚年专攻先秦文化，探讨中国文化的源头。先后出版著作16部，发表论文200余篇。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	435
1046	青藏铁路工程地质选线（英文版）	9787311050290	\N	李金城 谌文武 刘争平 	\N	1-1	16开	128.00	\N	兰州大学出版社	\N	\N	\N	2018-12-19	/book/4465c5fb-5d08-402e-87aa-f29c5b48b1ba9787311050290.jpg	该书结合青藏铁路的复杂地质条件，通过对多年冻土、地震与活动断裂、斜坡地质灾害、环境保护、地热、风沙及风吹雪等不良地质条件的分析，确定了线路方案的选线原则,列举了大量的工程实例，为线路方案的选择和完善提供了依据。该著作是理论与实践结合的典范，是对科研和工程实践的总结、升华，对高原冻土地区铁路选线具有重要的借鉴作用，该书的出版将彰显中国的科研实力，为世界的铁路建设贡献中国智慧。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	194
1047	〔乾隆〕《甘肃通志》（上下卷）点校整理本	9787311054588	\N	〔清〕许容 监修 李迪等 撰 刘光华 等点校整理 	\N	1-1	16开	1,380.00	\N	兰州大学出版社	\N	\N	\N	2018-09-01	/book/b27a220c-57ed-4f7d-acd7-eca605e2a0649787311054588.jpg	乾隆版《甘肃通志》是清初陕甘分治后第一部全面反映甘肃历史的通志；纂修于雍正年间，刊刻于乾隆元年（1736年）。 通志原刊刻本共50卷，白文80万字；点校整理本辑为上下两卷，字数约250万字。 内容包括：图考、星野、建置、山川、兵防、水利、风俗、选举、人物、孝义等36门。 本通志由〔清〕甘肃巡抚许容监修，兰州大学历史文化学院刘光华教授主持点校整理。 本通志对于研究甘肃历史具有极高的文献价值和学术价值，也具有很高的收藏价值和馆藏价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	763
1048	大河谣——景泰川电力提灌工程纪实	9787311052614	\N	阎世德 	\N	1-1	16开	150.00	\N	兰州大学出版社	\N	\N	\N	2018-05-01	/book/ba203658-615d-4a92-babe-e5a6c73516e49787311052614.jpg	景泰川电力提灌工程是新中国成立以来，甘肃省首次兴建的大型高扬程电力提灌工程，是一项高扬程、大流量、多梯级电力提水灌溉工程。位于甘肃省中部，河西走廊东端。灌区东临黄河，北与腾格里沙漠接壤，是一个横跨甘蒙两省区的景泰、古浪、民勤、阿拉善左旗四县（旗），跨黄河、石羊河流域的大型电力提灌水利工程。整个工程由景电一期工程、景电二期工程（简称二期工程）、景电二期延伸向民勤调水工程（简称民调工程）三部分组成。其中景电一期是一个独立的供水系统，景电二期和民勤调水工程共用一个提水系统。灌区干旱、少雨、风沙多，属于干旱型大陆性气候；灌区范围内地表径流和地下水都极度匮乏，灌溉水源来自从黄河提水。工程建成后，彻底改变了当地农业生产的基本条件，取得了显著的经济、社会和生态效益。为了从根本上改变甘肃省景泰、古浪等地群众守着黄河讨饭吃的困境，改变民勤地区因过度取用地下水造成的生态危机，20世纪60年代至90年代初，甘肃省进行了景泰川电力提灌工程建设。本书为纪实文学体裁，作者以大量工程资料和采访记录为基础，以景泰川电力提灌工程的建设为背景，讴歌了以李培福、贺建山、陈可言等同志为代表的共和国领导干部面向群众，为人民群众的利益奋斗终身的高尚品质，讴歌了以李士元、达慧中、李智仁、张九麦、张延英等普通工程技术人员和普通农民为代表的工程建设者，艰苦奋斗、勤劳朴素的崇高精神。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	416
1049	生物化学实验（第三版）	9787311048037	\N	张雪燕 	\N	1-1	16开	26.00	\N	兰州大学出版社	\N	\N	\N	2015-08-24	/book/3e264523-b911-44ba-a61c-413c5f953dfa9787311048037.jpg	本书真实、准确、重点地记载了甘肃省中医院2008年至2010年期间的整体发展变化，翔实地记载了医院的重点工作、重要会议、重大成果、重大活动、企业管理、后勤服务、精神文明建设、先进荣誉等内容，以及各部门开展的新技术和新业务等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	956
1050	《四库全书》西北文献研究	9787311043865	\N	徐亮 	\N	1-1	16开	38.00	\N	兰州大学出版社	\N	\N	\N	2017-06-01	/book/42583110-84eb-4246-8592-cb2c4f07dcad9787311043865.jpg	本书是第一部关于《四库全书》与地方文献关系的研究专著。该书从清朝西北地区与《四库全书》纂修的关系，《四库全书》西北文献的来源，四库馆对《四库全书》西北文献的处置，《四库全书》西北作者及文献简介，《四库全书》西北文献存世情况，《四库全书》西北文献在《四库全书》体系中的地位和价值，非西北作者的西北文献等方面，对清修《四库全书》与西北地方文献的关系进行了全面系统的勾稽与研究，有发凡起例的功效。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	293
1052	泰戈尔的大爱思想	9787311050122	\N	袁永平 	\N	1-1	16开	38.00	\N	兰州大学出版社	\N	\N	\N	2016-09-21	/book/8fdd1b26-c36d-47e9-842c-60389b49a0889787311050122.jpg	本书比较全面系统地阐述了印度伟大诗人、文学家泰戈尔的大爱思想。从结构上看，全书从三个层面展开：首先，泰戈尔的大爱表现在他以“爱”为本体的哲学思想上。泰戈尔拥有“诗哲”之称，全书阐述了他的以“爱”为核心的哲学思想体系，这个体系容括了他的宇宙观、人生观、宗教观、真理观、美学观以及社会观等。其次，泰戈尔的大爱思想也表现在他的爱情历程和对爱情的态度上。在泰戈尔的一生里，爱情是他歌颂的主题之一。他在诗篇里讴歌爱情，抒发对爱人的怀念；他的小说中最感人的情节是对爱情的描写。再次，泰戈尔的大爱思想还表现在他对人生的态度上。研究发现，泰戈尔人生最悲痛的一段日子，正好是他创作精力最旺盛、创作成果最高产之时。该书对于全面认识泰戈尔，帮助我们理解他的人生历程和作品，启迪心灵，都有积极意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	440
1053	马克思主义基本原理概论专题讲义	9787311056957	\N	夏淼 	\N	1-1	16开	38.00	\N	兰州大学出版社	\N	\N	\N	2019-10-10	/book/e0faf6ce-efef-4acd-a81d-10da887e7a7d9787311056957.jpg	《马克思主义基本原理概论专题讲义》为兰州大学马克思主义学院创新系列教材《思想政治理论课专题教学讲义》之一。本册分为十五讲，以问题的方式阐述了关于马克思主义基本原理，内容包括：无产阶级和人类解放的科学、马克思主义唯物论的本质基石、唯物辩证法的实质核心、马克思主义认识论的内在本质、马克思主义实践论基础上的革命变革、人类社会发展的根本动力、马克思主义的根本立场、马克思的经济增长理论、马克思主义的远大理想信念等。本书的特点在于：每一讲开始有问题导入，之后是理论阐释，并配有案例结合讲解，最后罗列各种相关教学资源，是一本趣味性强、资料丰富的创新性教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	958
1054	《礼记》品读	9787311050429	\N	曹志坚 	\N	1-1	16开	26.00	\N	兰州大学出版社	\N	\N	\N	2017-12-01	/book/0513d39d-1b9a-4f87-befd-c68e15f55f999787311050429.jpg	《礼记》是一部杂纂古代经传和儒家言论的典籍，多数篇章为孔子后学编纂而成，记载古代的礼仪制度及制度形成的意义等。此书在先秦时为单篇别行，至汉始编纂成书。今本《礼记》又称《小戴礼记》，共四十九篇。具体来说，《礼记》中的“礼”指的是《仪礼》，“记”指的是札记、笔记。《礼记》即战国至秦汉年间儒家学者解释说明《仪礼》的文章选集。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	721
1055	《论语》品读	9787311050399	\N	雷恩海 张志玮 	\N	1-1	16开	41.00	\N	兰州大学出版社	\N	\N	\N	2017-12-01	/book/de0ac8c0-cd14-4453-a797-0aa663b9c5cb9787311050399.jpg	《论语》是儒家经典著作之一，以语录体和对话文体为主，记录了孔子及其弟子的言行，集中体现了孔子的政治主张、道德观念及教育原则等内容。与《大学》《中庸》《孟子》并称为“四书”。该书是在阅读经典注本的基础上，择取《论语》各篇精华，由题解、原文、注释、品读、扩展阅读等部分组成，将主题相近的章节归为一类，进行品读，力求将原文意义融会贯通并予以展现，有助于青少年读者更好地接近经典、读懂经典。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	226
1056	《庄子》品读	9787311050474	\N	白宪娟 	\N	1-1	16开	27.00	\N	兰州大学出版社	\N	\N	\N	2017-12-01	/book/b1f011fe-deec-4e61-a61b-ac7ac997134d9787311050474.jpg	《庄子》在塑形中国文化上起着重要的作用，而此书也历来以难读著称。该书意在对《庄子》思想整体把握与恰切解读的前提下，探究发掘《庄子》思想的精髓及其有益人生的见解，并在《庄子》与后世文学、文化的关联中，显示《庄子》在中国文化史上的地位与价值。包括《庄子》选文、文字注释、品读、扩展阅读四个部分。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	846
1057	医学生理学实验指导	9787311057602	\N	蔺美玲、张小郁 	\N	1-1	16开	38.00	\N	兰州大学出版社	\N	\N	\N	2019-09-06	/book/f25af63e-d9c6-4a52-8a0b-a0edc9051db69787311057602.jpg	生理学(physiology)是生物科学的一个分支，是以生物机体的生命活动现象和机体各个组成部分的功能为研究对象的一门科学。以实验为特征的近代生理学始于17世纪。生命科学和信息本书分为三个部分。第一部分实验室规则及要求；第二部分常用实验仪器介绍；第三部分实验。本书主要介绍医学生理学实验的基本原理、具体操作方法、观察内容，以及实验中的注意事项。根据多年教学经验编写而成，内容简洁、条理清晰、实用性强，对医学本科所有专业均具有良好的指导意义。 《医学生理学实验指导》一书汇聚了兰州大学基础医学院生理学研究所老师们多年的教学经验和教学成果，对推动教学内容和教学方法改革，提高教学质量，做出了非常有益的尝试。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	802
1058	心理学通史（第2版）	9787303241453	9787303241453	叶浩生 	\N	1-4	16开	79.00	\N	北京师范大学出版社	\N	\N	\N	2019-09-19	/book/1c6f696e-542b-49d0-89bd-00649689d7599787303241453.jpg	本书分三篇，上篇为心理学思想史，中篇为心理学流派，下篇为心理学新发展。全书内容丰富，涵盖了近代欧洲的心理学思想、科学心理学的建立、行为主义的演变、精神分析的演变、女性主义心理学和社会建构论心理学等内容。本书最为显明的特色在于通。内容涵盖了古今中外心理学的基本内容,既有科学心理学建立之前的心理学思想,也有现代心理学的最新发展;既有中国心理学史的内容,也有西方和俄罗斯心理学的理论和流派。在全球化的今天,这也应是时代精神的体现。作者认为,尽管心理学在西方获得了更多更快的发展,但心理学史应该是世界的心理学史和一般性的心理学史,而不是西方心理学史。根据读者需求，作者对全书进行了详细的修订，缩减了篇幅，保留了最精华的内容，以更切合师生需要。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	981
1067	顾明远文集	9787303239764	9787303239764	顾明远 	\N	\N	16开	1,980.00	\N	北京师范大学出版社	\N	\N	\N	2018-10-01	/book/a97f4463-dde3-4eca-ab64-3bd5c8fe3dda9787303239764.jpg	《顾明远文集》（以下简称《文集》）共12卷，由北京师范大学出版社于2018年8月出版，《文集》的内容包括了顾明远先生从教70年来大部分的教育著述，几乎涵盖了所有的教育领域，全面反映了顾明远先生在教育理论领域的耕耘和对教育实践的感悟，既有纵横捭阖的鸿篇巨制，亦有信手拈来的娓娓而谈。《文集》不仅是他一生从事教育事业的全面总结，更体现了他对世界教育的洞见、中国教育的透视、教育历史的总结、教育现实的分析与教育未来的展望，可以说是一部鲜活的教育百科全书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	214
1059	大学生心理健康（慕课版）	9787303230617	9787303230617	俞国良 	\N	2-6	16开	48.00	\N	北京师范大学出版社	\N	\N	\N	2019-08-19	/book/711d6df3-3854-4da3-b107-89c59e843e469787303230617.jpg	大学生心理健康教育已经成为国家高等教育的重点内容，本教材根据国家教育部推出的最新《大学生心理健康教育指导纲要》、由主持纲要编写的主要专家组成作者队伍，内容涵盖教育部最新要求，目的是帮助大学生正确认识和处理好学习成才、择业交友、健康生活方式等方面的具体问题，帮助大学生学会调节和管理自我情绪，提高应对挫折的能力；学会关注社会、服务社会，提高自己的社会适应能力；培养积极心理品质，优化人格特征。是非常适合各高校、高职高专院校师生选用的大学生心理健康教育教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	266
1060	应用心理统计学	9787303166497	9787303166497	刘红云 	\N	1-14	小16开	65.00	\N	北京师范大学出版社	\N	\N	\N	2019-01-08	/book/7c888106-ba1e-48dd-a8f3-66d566de09f89787303166497.jpg	本书全面、系统地讲解了心理统计学的知识，在内容设计上，突出应用性和“学以致用”的原则，着重通过实例讲述统计思想，培养和提高学生应用统计方法的能力。书中详细介绍了文献中的报告方式和统计软件的操作以及 SPSS在各种统计分析中的具体应用。结合目前论文发表中对统计结果报告的要求，本书还较为全面地介绍了统计检验力和效应量的意义和计算方法。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	471
1061	大学生入学教育	9787303270910	9787303270910	舒显奇, 吕罗伊莎, 刘江主编 	\N	2-3	小16开	26.80	\N	北京师范大学出版社	\N	\N	\N	2021-08-12	/book/35a7c3c8-2128-4ae3-ac5a-878bccb1127e9787303270910.jpg	《大学生入学教育》根据大学新生特点、教育规律和现行教育制度、政策和规定，以大学生学习和生活为主要内容，以帮助大学新生顺利度过初入大学的适应期，更好更快地完成角色转换。本书以实用和创新为特色，从入学到毕业对学生进行全面的指导和教育，具有内容新颖、实用性强、论述系统等特点，可以作为大学生解决学习、生活、就业等问题的工具书，还可作为大学生及其家长、老师了解大学生活的参考书。 本书作为大学新生入学教育的辅导读物，让刚步入大学的学生能初步认识大学，了解大学教育的特点和教学模式，了解大学教育的制度、政策和规定；为了使大学生在校园中尽快适应学习和生活环境，掌握科学的学习方法，过好有意义的大学生活，本书从大学生的专业选择、学习、考试和继续教育、校园组织生活和社会实践生活等方面进行了阐述；本书以促进大学生素质的全面提高和健康成长为宗旨，对大学生的心理健康、人际交往和完美人格的塑造做了阐述；为了引导大学生树立正确的择业观，提高就业、创业能力，本书还从职业与职业生涯设计、就业准备和应聘技巧、自主创业等方面进行了阐述。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	425
1062	创业基础与实践	9787303267774	9787303267774	李俊 	\N	1-1	小16开	49.80	\N	北京师范大学出版社	\N	\N	\N	2021-03-01	/book/5c673fd3-e2cc-47b3-be9b-a72574ceaffd9787303267774.jpg	《创业基础与实践》将为您解读创新创业的基础逻辑，思考从0到1的商业秘密，为您的创新创业带来新的机会与价值！《创业基础与实践》基于先进的教学方法和理念，开创性地构建了一套创业理论与实践教学体系，同步还配套了丰富的精品在线课程资源，将开启数字经济时代和后疫情背景下创新创业教育新模式。全书内容共分为九章：第一、二章围绕创业者和创业团队，主要探讨了如何成为创业者和如何打造卓越的创业团队；第三、四章围绕商业机会和创业项目，主要探讨了如何发现和筛选商业机会，以及精益创业、设计思维和技术创业等知识；第五、六章围绕商业模式和创业资源，主要探讨了商业模式设计、互联网思维和公益创业模式，以及如何有效整合创业资源；第七章围绕创业项目展示，主要探讨了创业计划书的撰写和项目路演；第八章围绕新企业创建与成长，主要探讨了成立新企业、新创企业运营和创业企业成长等问题；第九章则为读者提供了商业游戏沙盘和创业模拟仿真的两个创业综合实践教学方案。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	823
1063	创业基础（十二五普通高等教育本科国家级规划教材）	9787303156511	9787303156511	李家华 	\N	4-12	16开	35.00	\N	北京师范大学出版社	\N	\N	\N	2019-03-04	/book/6f7a376b-845c-4424-8f23-2250061f0f359787303156511.jpg	教育部日前出台了《普通本科学校创业教育教学基本要求》，这是各高校开展创业教育教学活动的规范性文件，也是检验创业教育教学的重要标准。 《创业基础》是由教育部高教司根据文件精神组织编写的高等学校创业教育示范教材。本书编委会由“创业基础”教学大纲的起草专家组成员组成，确保权威性、科学性、针对性、可读性。教材编写专家研究创业教育多年，既有理论深度又有实践维度，汇集了目前中国高校创业教育的最新经验，也充分吸收了国际上特别是发达国家创业教育方面的最新研究成果进展，是全国创业教育教学的代表作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	403
1064	《诗经》讲读	9787303263233	9787303263233	李山 	\N	1-1	16开	58.00	\N	北京师范大学出版社	\N	\N	\N	2021-06-27	/book/3bb52c21-b428-4f58-897f-fa5c2b85126d9787303263233.jpg	《诗经》的“讲读”，已有两千多年的历史了。两千多年中，有自汉至唐的经学讲读，有北宋、元、明的宋学讲读，也有兴盛于清代乾隆、嘉庆时期“新汉学”的讲读，当然也有近代以来的文学讲读。 而本书之“讲读”，立足当下新的学术预设，力避生搬与学究的做法，将《诗经》的产生，放在夏商以来社会文明大幅提升、文化生产高涨的历史大背景下加以考察；将对《诗经》篇章的理解，同“西周礼乐文明”深刻联系，力求揭示《诗经》所包藏的精神线索，梳理民族文化的精神传统。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	309
1065	艺术理论教程（第4版）	9787303191932	9787303191932	张同道 	\N	1-1	小16开	39.80	\N	北京师范大学出版社	\N	\N	\N	2018-06-07	/book/021f189b-3d1c-4024-8f74-c50d6faa3c5c9787303191932.jpg	本书为教育部哲学社会科学重大课题攻关项目，获得普通高等教育“十一五”国家级规划教材，32页彩色插图，案例丰富，可读性强。作为国内“艺术概论”课程畅销教材，艺考指定用书，最新修订版，收到广泛欢迎。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	860
1091	中华优秀传统文化	9787568522403	9787568522403	吴婕 	\N	1-1	16开	39.80	\N	大连理工大学出版社	\N	\N	\N	2019-10-22	/book/4ca1648c-2150-4eb7-9e9c-aa3e150216c79787568522403.jpg	本教材的主要内容分上、下两编，上编概述了中华优秀传统文化里思想哲学文学艺术等高雅文化，下编从国家制度、生活方式等实务角度较为系统地梳理了中华优秀传统文化。全书共五大模块：文以载道——智慧与信仰； 艺以修身——文学与审美； 治国有常——传统社会制度与中外交流；人间情味——家园乡土与风俗人情；传统与现代。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	837
1066	共和国教育学70年·总论卷	9787303258093	9787303258093	侯怀银等 	\N	\N	16开	210.00	\N	北京师范大学出版社	\N	\N	\N	2020-06-01	/book/c02953f5-3b12-420a-8fc1-ee8fc779e8a59787303258093.jpg	“共和国教育学70年”丛书，以教育学分支学科为经，以学科发展为纬，旨在对中华人民共和国成立以来教育学各学科的发展进行全方位的研究，在此基础上，梳理各学科70年来的发展历程、取得的进展与成就；分析各学科70年发展所出现的问题与不足，展望未来的建设与发展。本卷为德育原理卷，集中论述了中华人民共和国教育学二级学科德育原理70年的发展历程，有助于拓展中国教育学史的研究领域，有助于推进中国教育学的学科发展，有助于中国教育理论的完善和中国人文社会科学学科的建设和发展。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	453
1068	大学物理	9787303193158	9787303193158	胡祥青 付淑英 	\N	1-8	16开	45.00	\N	北京师范大学出版社	\N	\N	\N	2022-03-01	/book/53ca0b35-9fc1-44f1-b33b-9ffa442bb78d9787303193158.jpg	大学物理课是理工科的重要基础课，物理学的内容又极其丰富。如何编写出适合高专高职类的大学物理教材，我们注重了内容的精选，尽可能系统地、完整地、准确地讲述物理学的主要进展和成就，包括基本知识、基本概念、基本规律、基本方法，介绍物理学的现代发展，使学生既能掌握物理学的基础知识，又能了解物理学的前沿动态，培养学生的科学素养、科学思维方法和科学研究能力。学习本课程要有一定微积分基础。《大学物理》教材融入了作者多年来的课程体系探索、内容把握、过程控制和经验总结，编写的特点如下：1）以提高学生的科学素养和综合职业能力为主要目的，注重培养学生分析问题和解决问题的能力。2）注重以学生为中心，以就业为导向，既注意科学性，又注重实践应用。3）充分考虑高职高专学生的认知程度，注意用简明扼要的叙述、丰富的实例、大量的图片引导学生对概念的理解。大学物理及实验课程于2006年评为江西省级优质课程、2009年评为江西省高校首批双语教学示范课程、2011年评为江西省精品课程，2008年获校第十一批优秀教学成果二等奖，本书为“十二五”职业教育国家规划教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	590
1069	电子技术	9787303220342	9787303220342	廖芳 	\N	1-7	16开	47.00	\N	北京师范大学出版社	\N	\N	\N	2021-04-01	/book/82578d59-3e31-4479-a1de-d5fbaf0d60749787303220342.jpg	本书介绍的基础理论知识以够用为度，注重拓展能力、操作能力的培养。书中主要阐述了模拟电路、数字电路的基本工作原理和基本分析方法，以及相关电路的实验、实训操作内容。每章前有学习要点，每章后有小结、习题，书末附有各章的习题答案。本书列选了10 个电子技术基础方面的实验内容，其中包括：常用电子仪器的使用、晶体管的检测、单管放大电路的安装与调试、集成运算放大器的线性应用、集成运算放大器的非线性应用、集成稳压电源、常用逻辑门电路的测试、组合逻辑电路的简单设计、计数译码和显示电路、555 时基电路及其应用等内容，目的在于培养学生对常 规电子仪器仪表的使用能力，将电子理论转换为实际电路的动手能力以及应用理论解决实际问题的能力。本书为普通高等教育“十一五”国家级规划教材、“十二五”职业教育国家规划教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	974
1070	管理学（微课版）	9787303270965	9787303270965	王文周 	\N	1-1	16开	49.80	\N	北京师范大学出版社	\N	\N	\N	2021-08-01	/book/844b6d8f-b78c-4435-bb85-d2f842bab7b89787303270965.jpg	《管理学》适应互联网时代学习特点，旨在为读者构建一个立体化、沉浸式、迭代型的学习平台。全书内容围绕管理学概述、计划、组织、领导、控制和创新六篇展开，力求将知识传授、能力培养和价值引导做到深度协同、有机统一，帮助读者掌握宽厚的管理学基础知识和解决复杂管理问题的思路、工具和方法，提高读者人文素质和强烈的社会责任感，同时了解中国企业发展进程所面临的环境、挑战和需求，更好地增强“四个意识”、坚定“四个自信”、做到“两个维护”。本书配套教学资源丰富，通过扫描书中二维码，可以在线学习视频课程，便于教师开展翻转课堂SPOC教学，也便于读者自学。每章后面附有定期更新的在线测试题和案例分析等辅助学习手段，便于读者深入掌握课程所讲知识技能并有所拓展。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	318
1071	数据科学与大数据技术导论实验	9787303234509	9787303234509	陈明 	\N	1-1	16开	32.80	\N	北京师范大学出版社	\N	\N	\N	2018-07-02	/book/14a6a130-b64c-41cd-a0e2-f4c6d7e276209787303234509.jpg	本书是《数据科学与大数据技术导论实验》课程的实验教材，可以配合主教材使用。主要内容包括：Linux环境部署、Hadoop开发环境部署、网页数据采集、大数据去重、大数据最大值计算、大数据排序、大数据倒排索引、大数据平均值计算、大数据单表关联、大数据可视化。 本书选材先进、特点鲜明，注重应用。通过本书所提供的实验练习，可以提高大数据处理能力。可用于大数据实验教材，也可以作为科学技术人员学习和应用大数据的科技参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	944
1166	国际工程承包和管理实务英语	9787521318043	9787521318043	戴若愚 	\N	1	16开	42.90	\N	外语教学与研究出版社	\N	\N	\N	2020-03-13	/book/e4a34005-744a-46e9-a899-f4cb186356bc9787521318043.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	512
1072	幼儿教育学基础（第2版）	9787303205455	9787303205455	李季湄 	\N	2-43	16开	39.00	\N	北京师范大学出版社	\N	\N	\N	2017-01-19	/book/432efe1c-6bab-4d55-870a-1fc0fb029e949787303205455.jpg	《幼儿教育学基础（第2版）》在内容上保持并强化了第1版教材所反映的现代教育观、儿童观，更加强调了以幼儿发展为本，更体现时代性、前瞻性；补充、扩展了中外幼儿教育的新趋势、新思想、新信息，更多地结合了我国幼儿教育改革的新成果、新动向、新经验，特别是近年来发布的具有重大指导意义的新教育法规与文件，如《幼儿园教师专业标准（试行）》、2016年3月新修订的《幼儿园工作规程》等。教材分三部分系统介绍了幼儿园教育的基础知识、幼儿园教育的基本要素和幼儿园教育的实施。 相较于第1版，本教材在第二部分第四章新增“幼儿”一节，第五章新增“幼儿园室内外空间环境创设的注意事项”一节，特别根据新的研究成果对第三部分第六章“幼儿园课程”进行了重新编写。在编写体例上，为提高教材的可读性，促进学习者对重点内容的理解，教材随文配合大量幼儿园教育案例，并提供了丰富的思考与练习题和拓展阅读资源。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	101
1134	“一带一路”大型系列丛书.	9787566019028	9787566019028	程静 	\N	1-1	16开	47.00	\N	中央民族大学出版社	\N	\N	\N	2021-05-01	/book/1006e18c-d3ad-473c-b565-1d77d9837e359787566019028.jpg	《雪山环绕》散文集书写了一种真实的边地生活，不论草木还是人群，都是作者对自己所生活的伊犁大地，这片混血与色彩斑斓之域的种种体验、认知和判断。面对西域的磅礴物象，用自己的生命和心灵发出追问，是寥廓西域最为细微、温暖 、自我和微小的部分，不仅敏锐、良善，并且有着某种河流一样的静谧和深阔	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	129
1073	汽车发动机构造与维修（第3版）	9787303259434	9787303259434	方道生，徐小花 	\N	3-9	16开	39.80	\N	北京师范大学出版社	\N	\N	\N	2021-02-02	/book/e6746e69-2ac3-4656-b303-c311864dd1e99787303259434.jpg	本书为教材第三版，配套了教案、课件、习题答案，增加了练习册等内容，本书系统地介绍了汽车发动机的结构、工作原理、零部件检修及故障诊断与排除，主要内容包括：发动机基本知识、曲柄连杆机构、配气机构、汽油机电控燃油喷射系统、传统柴油机燃油供给系统、柴油机电控燃油喷射系统、发动机润滑系、发动机冷却系和发动机起动系等。 本书可作为高职高专院校汽车运用与维修技术类专业教材，也可作为相关行业培训教材，还可作为汽车维修技术人员自学参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	208
1092	计算机应用基础项目化教程（第二版））	9787568522557	9787568522557	刁洪斌，孙丕波 	\N	1-1	16开	40.80	\N	大连理工大学出版社	\N	\N	\N	2019-10-08	/book/c4faf388-54f9-422f-b157-0703bfd084739787568522557.jpg	本教材共分为六个模块，既有信息技术前沿，也有实用工具软件，主要内容包括：未来已来——前沿信息技术初析、操作系统Windows 10、电子文档Word 2010、电子表格Excel 2010、演示文稿PowerPoint 2010、常用工具软件。提供了极为丰富的配套学习资源，包括配套实例的教学课件、教学视频、源文件、素材文件、习题库等，读者可以通过手机扫描书中二维码，观看对应的微课视频，随时随地学习	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	690
1082	孤残儿童护理员国家职业技能培训评价教材	9787568532013	9787568532013	北京社会管理职业学院（民政部培训中心）组编 	\N	1-1	16开	75.00	\N	大连理工大学出版社	\N	\N	\N	2021-10-30	/book/8c01c0e7-2b62-4b0c-a60a-cbfbc96119559787568532013.jpg	《孤残儿童护理员国家职业技能评价教材（基础知识）》根据《孤残儿童国家职业技能标准（2021版）》编写。共14章，分别为职业道德、儿童生长发育基础知识、儿童运动发展基础知识、儿童营养需求基础知识、儿童预防保健基础知识、儿科基础护理知识、残疾儿童康复基础知识、儿童心理发展基础知识、儿童异常心理发展基础知识、儿童特殊教育基础知识、儿童安全防护基础知识、孤残儿童护理员基本要求及职业适应、儿童保护相关法律法规知识、困境儿童保护相关政策知识。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	239
1074	内外科护理	9787303185641	9787303185641	周娟仙 	\N	1-7	16开	85.00	\N	北京师范大学出版社	\N	\N	\N	2021-09-04	/book/42a068fa-7c8f-4fdb-adab-7df19ca1e5699787303185641.jpg	本书为“十三五”职业教育国家规划教材，教材以工学结合为导向，护理程序为主线，选择典型临床案例为载体，按完成临床护理工作任务需要组织教材内容。教材共12个项目，每个项目下有若干个任务，包括循环系统疾病病人的护理（包含循环系统疾病常见症状体征的护理、心力衰竭病人的护理等8大任务），消化系统疾病病人的护理（包含消化系统疾病常见症状体征的护理、胃十二指肠疾病病人护理等13大任务），呼吸系统疾病病人的护理（包含呼吸系统疾病常见症状体征的护理、肺炎病人的护理等8大任务），泌尿系统疾病病人的护理（包含泌尿系统疾病常见症状体征的护理、肾小球肾炎病人的护理等8大任务），损伤病人的护理（包含创伤、烧伤、毒蛇咬伤病人的护理等7大任务），皮肤及皮下组织疾病病人的护理（包含皮肤及皮下组织化脓性感染、手部急性化脓性感染病人的护理2大任务），肌肉、骨骼系统疾病病人的护理（包含颈肩腰腿痛、化脓性骨髓炎病人护理等4大任务，血液系统疾病病人的护理（包含血液系统疾病常见症状体征的护理、贫血病人的护理等4大任务），内分泌系统疾病病人的护理（包含甲状腺机能亢进、糖尿病病人的护理2大任务），神经系统疾病病人的护理（包含颅内压增高、颅脑损伤病人的护理4大任务），肿瘤病人的护理（包含食管癌、大肠癌、肝癌病人的护理6大任务），围手术期病人的护理（包含手术前、手术室、手术后护理及认识麻醉4大任务）。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	145
1075	护理评估	9787303185108	9787303185108	卢英菊 	\N	1-8	16开	56.00	\N	北京师范大学出版社	\N	\N	\N	2021-09-29	/book/9b743749-bbed-4bd2-9e2a-e7cb1515de419787303185108.jpg	《护理评估》是中职护理专业的一门核心课程，是研究诊断个体，家庭或社区对现存的或潜在的健康问题或生命过程的反应的基本理论、基本技能和临床思维方法的学科。编写时结合课程标准和临床护理评估工作实际，确定了健康史采集、全身状态评估、头颈部评估、胸廓和肺评估、心脏和血管评估、腹部评估、四肢脊柱与神经反射评估、实验室评估、特殊器械检查、病例分析与护理诊断等十个教学项目。帮助学生全面学习护理评估所需的基本方法、基本理论和基本临床思维，从而形成重要的护士岗位职业能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	429
1076	0～3岁婴幼儿抚育与教育（第2版）	9787303262427	9787303262427	康松玲，许晨宇 	\N	2-9	16开	35.00	\N	北京师范大学出版社	\N	\N	\N	2021-12-01	/book/ebbde392-10b0-4b7d-88fc-2a9f88265f029787303262427.jpg	本教材系“十三五”职业教育国家规划教材，获首届国家教材奖。本书包括四个单元的内容，以“婴幼儿”为中心，以“年龄段”为单元，比较完整地描述了0～3岁婴幼儿在胎儿期（受精卵至娩出前280天）、新生儿期（娩出至满月28天）、婴儿期（满月至1周岁）和幼儿期（1周岁至3周岁）抚育的重点与教育的内容、策略，包括各阶段身心发展的特点和规律、营养与喂养要求、生活照料与护理保健、安全与意外事故预防以及各阶段早期教育的内容、方法与策略。本书适合学前教育专业、早期教育专业学生学习，也适合家长科学育儿参考。各单元根据内容的需要配备视频、微课、图片、数据统计图表、案例、“互动平台”等，深入浅出，便于学习者理解和掌握。同时，单元前设置了“学习目标”和“案例导入”，为学习单元重点内容作好准备；单元后设计了“思考与练习”、“学习反思”等，便于知识辨析、巩固、理解和应用。每课课后设置了“本课内容回顾”，帮助总结理清思路并明确应知应会的内容。另外，考虑不同学习者的需要，各单元增加了拓展学习的“相关链接”和“幼儿教师资格考试要点”等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	237
1077	什么是航空航天？	9787568530118	9787568530118	万志强, 杨超 	\N	1-1	16开	39.80	\N	大连理工大学出版社	\N	\N	\N	2021-09-01	/book/ced5ff65-a193-4d7e-9f77-3f9cc890f5f49787568530118.jpg	本书主要介绍航空航天的基本知识和基本原理，包括航空航天的分类、基本组成、飞行原理、推进系统、安全飞行、未来飞行以及航空航天学科专业等几个方面，并在各部分增加一些亮点小知识，拓展和丰富读者的认识，力图展现航空航天的基本特征、宏大家族、发展规律、未来趋势，方便大家走进航空航天，为进一步了解、理解、学习航空航天提供最基础的支持和帮助！	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	958
1078	什么是土木工程？	9787568530071	9787568530071	李宏男 	\N	1-1	16开	39.80	\N	大连理工大学出版社	\N	\N	\N	2021-09-01	/book/0383a938-9987-4472-a486-c784606554ec9787568530071.jpg	本书从三个方面进行了论述：土木是什么？这门学科学什么？将来毕业后可以做什么？从土木的定义、内涵、发展（历史、现状和未来）、学科分支和分类进行介绍。在介绍“土木是什么”的同时，突出人文内容。对于土木本科生的课程设置进行概括性的介绍。结合土木毕业生情况，给出案例。本书从土木专业的重要地位出发，讲述了土木工程对国民经济和社会发展的重要支撑作用，以及土木工程向绿色和智能方向的发展趋势。然后介绍土木工程类专业的学科分类，各专业的人才培养目标和定位，主要课程设置，毕业生就业方向等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	230
1079	什么是纺织？	9787568530125	9787568530125	郑来久 	\N	1-1	16开	39.80	\N	大连理工大学出版社	\N	\N	\N	2021-09-01	/book/32c5914f-bc60-4bdd-83f1-b114fef58aff9787568530125.jpg	本书从三个方面进行了论述：1.纺织是什么？从纺织的定义、内涵、发展（历史、现状和未来）、学科分支和分类进行介绍。在介绍“纺织是什么”的同时，突出一些人文内容。2.这门学科学什么？对于纺织类本科生的课程设置进行概括性的介绍。3.将来毕业后可以做什么？结合该专业毕业生的具体情况，给出一些真实案例。本书从纺织的重要地位出发，讲述了纺织对国民经济和社会发展的重要支撑作用，以及纺织向绿色和智能方向的发展趋势。然后介绍纺织类专业的学科分类，各专业的人才培养目标和定位，主要课程设置，毕业生就业方向等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	936
1083	假肢装配工国家职业技能培训评价教材（二级/技师、一级/高级技师）	9787568531689	9787568531689	北京社会管理职业学院（民政部培训中心） 组编 	\N	1-1	16开	60.00	\N	大连理工大学出版社	\N	\N	\N	2021-09-13	/book/73183031-ba5b-4130-aa41-c2f54d935dfd9787568531689.jpg	本教材适用于二级/技师、一级/高级技师假肢装配工国家职业技能培训，涵盖了足部假肢、塞姆假肢、膝离段假肢、髋离段假肢的解剖学定义、串者接待和尺寸测量、石膏取型和修型技术、假肢试穿调整技术、教学培训和生产管理相关知识。本教材为国家职业技能培训教材，为民政部职业资格考试培训类推荐教材，教材根据项目任务式展开编写，与目前市场上的章节式教材相比，具有可操作性强、更实用的特点。本教材适用于高职高专类及自学人员使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	316
1084	矫形器装配工国家职业技能培训评价教材（五级/初级工、四级/中级工、三级/高级工）	9787568531696	9787568531696	北京社会管理职业学院（民政部培训中心） 组编 	\N	1-1	16开	66.00	\N	大连理工大学出版社	\N	\N	\N	2021-09-13	/book/56fb1c28-e830-4c94-a1cc-17de561df42e9787568531696.jpg	本培训评价教材完全遵循矫形器装配工五级/初级工、四级/中级工、三级/高级工要求的职业功能、工作内容、技能要求和相关知识要求进行编写，教材内容紧密贴合生产实际，注重操作流程的规范性和操作技术的标准性，符合矫形器临床配置规律，是一本兼具实用性和规范标准的工作手册式教材。本教材为职业技能培训教材，为民政部职业资格考试培训类推荐教材，教材根据项目任务式展开编写，与目前市场上的章节式教材相比，具有可操作性强、更实用的特点。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	434
1085	工业设计中国之路——轻工卷（一）	9787568507424	9787568507424	沈榆，孙立 著 	\N	1-1	16开	252.00	\N	大连理工大学出版社	\N	\N	\N	2017-07-20	/book/a7aa7379-5303-40e5-bf5a-9cecd39ca67e9787568507424.jpg	《工业设计中国之路》是呈现中国工业设计发展之路的著作，内容主要是对碎片化的技术文献资料、历史口述资料以及产品实物等进行梳理及研究。本卷是轻工卷（一），书稿对中国工业设计发展的历史背景，民族品牌及代表产品"自行车、手表、缝纫机"的设计背景、工艺资料、经典设计、品牌记忆、系列产品等均有详细描述。内容涉及历史时间、事件、产品型号、技术发展，资料来源涉及地方志、厂志等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	670
1169	汉英翻译技巧（第二版）	9787521327625	9787521327625	钟书能 	\N	1	16开	52.90	\N	外语教学与研究出版社	\N	\N	\N	2021-02-25	/book/a9047a30-58d9-4acb-9a11-20f199d0148f9787521327625.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	376
1086	工业设计中国之路——轻工卷（二）	9787568507431	9787568507431	俞海波 编著 	\N	1-1	16开	215.00	\N	大连理工大学出版社	\N	\N	\N	2017-07-20	/book/58fbd488-bfb9-4df0-82a5-57b918a3c79c9787568507431.jpg	《工业设计中国之路》是呈现中国工业设计发展之路的著作，内容主要是对碎片化的技术文献资料、历史口述资料以及产品实物等进行梳理及研究。本卷是轻工卷（二），书稿对中国工业设计发展的历史背景，民族品牌及代表产品照相机等的设计背景、工艺资料、经典设计、品牌记忆、系列产品等均有详细描述。内容涉及历史时间、事件、产品型号、技术发展，资料来源涉及地方志、厂志等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	455
1087	工业设计中国之路·理论探索卷	9787568519540	9787568519540	曹汝平等10人 	\N	1-1	16开	198.00	\N	大连理工大学出版社	\N	\N	\N	2019-06-20	/book/31d226b1-d678-4652-a7c6-2868e93010309787568519540.jpg	《工业设计中国之路》关注促进中国工业设计发展各种要素的研究，围绕工业产品的设计，从各个层面进行“纵向”的研究和写作。本卷内容首先呈现了早期与中国工业化相关的史料研究，从中可以看出当中国工业设计处于萌芽状态时，中国设计先驱们以“图案学”为代表的设计理论探索。其次收集整理了在国际技术转移、工业产品输入过程中，海归设计师的主要观点和理论。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	651
1088	工业设计中国之路·重工业装备产品卷	9787568519533	9787568519533	孙立，沈榆编著，共10人 	\N	1-1	16开	318.00	\N	大连理工大学出版社	\N	\N	\N	2019-06-20	/book/2e324082-eac6-4887-94c6-c5355962f2f29787568519533.jpg	《工业设计中国之路》是呈现中国工业设计发展之路的著作，内容主要是对碎片化的技术文献资料、历史口述资料以及产品实物等进行梳理及研究。“装备”被称作“国之重器”，其工业设计具有高集成度、先进性、综合性、可靠性等特质。本卷内容将通过追踪、挖掘历史资料，呈现工业设计是如何平衡产品性能的先进性和生产的可能性的。只有解决了这一矛盾，研制出的装备才能提升品质，并在各种复杂的环境中很好地完成任务。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	604
1089	文化经济学的“一带一路”（"??????	9787568507318	9787568507318	赵磊 	\N	1-1	16开	80.00	\N	大连理工大学出版社	\N	\N	\N	2016-04-28	/book/3f3334cc-9289-43f2-961d-9d9eaca92e539787568507318.jpg	全书共21个部分，包括打通发展痛点，仰望人文高点、国际秩序变化与中国对外战略，“一带一路”要打造人文格局，让中国文化行走起来，“一带一路”要精准法力，“一带一路”要有标志性项目，动态系统评估“一带一路”，“一带一路”建设亟需解决的问题，感受化为经济热度背后的文化温度等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	119
1093	纯电动汽车构造与检修	9787568527064	9787568527064	李仕生，杨俊伟主编 	\N	1-1	16开	59.80	\N	大连理工大学出版社	\N	\N	\N	2020-11-06	/book/4f57b631-6258-4d31-b9ad-56ef12ad45179787568527064.jpg	本教材包含电动汽车维修安全操作、纯电动汽车整体构造认知、高压线束与高压部件的检修、整车控制系统结构原理与检修、动力电池系统结构原理与检修、驱动电机及控制系统结构原理与检修、充电系统结构原理与检修、辅助系统结构原理与检修共8个学习项目。本书采用学习任务导入模式，任务多以企业一线的案例作为引子，增强了学习内容的融入感，具有良好的教学效果。本书编著中所使用的车型主要是近来针对中、高职学生开展的国家级（包括教育部、交通部、人社部等）新能源汽车维修赛项所使用吉利和比亚迪的纯电动主流车型作为参考，以电动汽车的主流技术及其检修方法为主要出发点，对纯电动汽车的构造与检修进行了全方位的讲解。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	644
1094	新编大学生心理健康(第八版)	9787568531603	9787568531603	刘庆明 赵生玉 	\N	1-1	16开	49.80	\N	大连理工大学出版社	\N	\N	\N	2021-09-02	/book/fd41ca32-b202-430c-bf0d-6066956e4c4f9787568531603.jpg	本书紧紧围绕高职大学生的心理困扰，现代社会对高职生心理素质的要求来组织内容，共14章：心理健康概述、心理适应、自我意识、职业生涯规划、健康人格、学习成才、创新思维、人际交往、恋爱与性、绿色网络、情绪管理、挫折应对、珍爱生命、爱与感恩。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	891
1095	数学——科学和职业	9787568518093	9787568518093	(俄)柯尔莫戈洛夫(A.N.Kolmogorov) 著；姚芳 刘岩瑜 吴帆 编译 	\N	1-1	16开	35.00	\N	大连理工大学出版社	\N	\N	\N	2021-02-24	/book/1cc85811-871c-49dd-9ffe-7d0d28dabeb89787568518093.jpg	柯尔莫戈洛夫一生喜欢数学，研究数学，培养数学人才，对数学和数学教育的发展做出了重大贡献。本书首先介绍了柯尔莫戈洛夫在数学学习和数学研究方面的成长经历，对下一代数学人才的培养过程，然后介绍了柯尔莫戈洛夫写给中学生的通俗数学读物。最后是数学家对柯尔莫戈洛夫的回忆文章。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	833
1096	埃尔朗根纲领	9787568526876	9787568526876	（德）F.克莱因 著，何绍庚 郭书春 译 	0	1-1	16开	30.00	\N	大连理工大学出版社	\N	\N	\N	2021-02-01	/book/e91b7fce-c5e0-45c0-a230-04eb11b3ef519787568526876.jpg	1872年德国数学家F.克莱因在埃尔朗根大学的教授就职演讲中，作了题为《关于近代几何研究的比较考察》的论文演讲，论述了变换群在几何中的主导作用，把到当时为止已发现的所有几何统一在变换群论观点之下，明确地给出了几何的一种新定义，把几何定义为一个变换群之下的不变性质。这篇演讲在数学史上以《埃尔朗根纲领》著称。《埃尔朗根纲领》的提出，意味着对几何认识的深化。它把所有几何化为统一的形式，使人们明确了古典几何所研究的对象；同时显示出如何建立抽象空间所对应几何的方法，对以后几何的发展起了指导性的作用，故有深远的历史意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	994
1097	生物工程综合实践教程——重组蛋白药物生产	9787568517614	9787568517614	孜力汗 贾凌云 	0	1-1	16开	15.00	\N	大连理工大学出版社	\N	\N	\N	2021-03-13	/book/2381e794-d639-47f4-9239-5b71b2a53c889787568517614.jpg	本图书是生物工程综合实践教程，聚焦重组蛋白药物生产原理与技术，详细介绍了重组蛋白药物的发展历史、现状、主要制备技术、工艺要求和优化策略，并提供生产实践实例。重组蛋白药物生产是生物工程领域的重要内容，也是生物产业和生物经济的热点和亮点。本书详尽地介绍了重组蛋白药物生产的原理、关键技术、主要进展和工程实践案例，图书内容着眼产业发展前沿，充分梳理了重组蛋白药物生产的历史、现状和发展趋势，内容充实全面。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	119
1098	无机与分析化学	9787568527132	9787568527132	陈若愚 朱建飞 	\N	1-1	16开	58.00	\N	大连理工大学出版社	\N	\N	\N	2021-10-15	/book/a0b622e7-ae18-458c-b491-f11d969225619787568527132.jpg	《无机与分析化学》是工科高等学校化工、材料等专业学生的第一门专业基础课。本次修订充分注重与中学化学课程的衔接，共分13章，包括化学平衡的基本概念,定量分析概论,酸碱滴定法,沉淀平衡和沉淀滴定法等。注重术语和概念的正确性、法定计量单位的普及，增加了例题和习题，更新的拓展阅读的最新内容。体现环境保护意识，关注学科发展前沿。新加新媒体相关教学视频。该书将“无机化学”四大平衡与元素知识与分析化学中的化学分析有机组合，形成学时少，知识体系全面，结构紧凑的一本教材。本书适用于化学化工类本科生。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	594
1099	彼岸	978-7-5213-1937-8	\N	斯蒂芬·杰·古尔德 著 	平装	1-1	大32开	82.00	\N	外语教学与研究出版社	\N	\N	\N	2021-12-01	/book/ab75f052-7f01-4fa2-9bef-991ea853cb981080601.jpg	《彼岸：博物学家古尔德生命观念文集的末卷》是作者为《博物学》杂志所写的专栏文章的合集，共收录31篇文章，按主题分为八章。这样的合集共有十卷，本书是最后一卷。这些专栏文章以生物演化为中心主题，不仅涉及演化科学的发展，还涉及演化这门科学所折射出的社会现象、心理现象等。在这卷出版于作者去世前一年的博物学随笔集中，古尔德以生命演化为经线，以文学、艺术、哲学、历史等为纬线，为读者勾勒了一幅科学与人文交相辉映的画卷，让人们思考现象背后的深刻道理，将科学散文提升到一个新的高度。 古尔德是百科全书式的大师，他的作品不是不加批判地传达理论，而是用思辨的眼光看待所有论题。古尔德以他的博学多才为读者展开了一幅连绵不绝的画卷，使读者不由自主地跟随他的思路进入一个奇幻的世界，最后对他得出的结论心悦诚服。我们不得不为古尔德的论辩技巧所折服。作为公众代言人，他对当代科学与文化做出了杰出的贡献。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	811
1100	近世中国民间故事	9787569520194	9787569520194	[法]戴遂良 	\N	1-1	16开	88.00	\N	陕西师范大学出版总社	\N	\N	\N	2020-12-01	/book/a1513011-48a3-4f55-94b1-c6037abbe6e89787569520194.jpg	本书是法国著名汉学家戴遂良在1887被派遣到直隶东南（河北献县）耶稣会任教职期间在中国收集的志怪故事。全书包括222个志怪故事，取材于自3世纪起至清末的三十种汉文文献（如《集异记》《幻异志》《灵怪录》《牡丹灯记》《稽神录》《广异记》《异闻总录》等），汇集了历代的中国民间奇异故事，展现了中国历代百姓的生活知识和鬼神观念，是西方学者编纂的第一本中国民间故事集。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	316
1112	九叶集	9787569523850	9787569523850	辛笛、穆旦等 	\N	1-1	32开	49.00	\N	陕西师范大学出版总社	\N	\N	\N	2021-12-01	/book/76211a89-6f9a-4dc9-b45b-40764cef45779787569523850.jpg	《九叶集》是20世纪40年代九位年轻诗人辛笛、陈敬容、杜运燮、杭约赫、郑敏、唐祈、唐湜、袁可嘉、穆旦作品的合集。他们的作品诞生于那个血与火的特殊时期，抒写了当时人民的苦难、斗争与对光明的渴望，个性鲜明，风格严肃而沉静，被公认为中国百年新诗史的一座高峰。 四十周年纪念修订版全面订正了初版中的讹误，并附上九位诗人的生平小照。是读者了解“九叶派”乃至中国新诗史的必读书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	119
1101	大平原	9787569520446	9787569520446	高建群 	\N	1-1	16开	72.00	\N	陕西师范大学出版总社	\N	\N	\N	2021-01-01	/book/0db4cfe4-51f0-4a87-b30c-fdd0c4ae56169787569520446.jpg	本书所讲述的是一个来自关中平原的故事，一部《百年孤独》式的家族史。在这个传奇的家族里，从20世纪的上半叶开始，到21世纪的阳光照到这个世界之时，三代人历经了种种苦难与爱恨情仇，在顽强地生存的同时，捍卫着自己的尊严在本世纪的城市化浪潮中，这个村庄被改造成城市的高新区，结束了上千年的乡村文明，而新一代弄潮儿开始在商业社会中继续成长、前行……作者宛如生活在大平原上的一位说书人，将近百年来不同时期的历史风貌娓娓道来。全书既厚重朴实，又瑰丽峭拔，具有浓厚的中国式的人情味，以此献给大变革时代中每个中国人已经消失和正在消失的故乡。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	262
1102	耕读传家	9787561396018	9787561396018	大生 	\N	1-1	16开	65.00	\N	陕西师范大学出版总社	\N	\N	\N	2018-01-01	/book/e7a0ce95-1c1d-45f9-8094-e1ecea84ee679787561396018.jpg	所谓“耕读”，是农耕与读书和合称，是中国传统社会里最普遍的一种生活状态和价值追求。中国的古人们，农忙稼穑，闲来读书，在耕田里井、案头书斋中，创造出灿烂绚美的传统文化来。这是农耕文明重视教育的结果。所以“耕读传家”，成为我们这个民族，最为悠久的祖训之一。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	658
1103	明月松间	9787561396049	9787561396049	董雁 	\N	1-1	16开	65.00	\N	陕西师范大学出版总社	\N	\N	\N	2018-01-01	/book/1b46f483-5e3f-416d-9684-f02ed146b0f09787561396049.jpg	中国古典园林，兴于商周，至今已有三千余年的历史。以追求“虽由人作，宛自天开” 为最高境界，其中蕴藏着老庄哲理、佛道精义、魏晋风流、诗文趣味，表达了古人对心灵自由放逸的求索，古人的精神追求，正是值得后人细细品赏的园林之魂。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	772
1104	人间有味	9787561396063	9787561396063	毛晓雯 	\N	1-1	16开	65.00	\N	陕西师范大学出版总社	\N	\N	\N	2018-01-01	/book/75bf23bb-c3b6-47a0-ac52-4f341e0fd2999787561396063.jpg	中国是美食之邦，一代一代人开发出各种各色精致的美食。今天我们享用的每一餐，都有几千年的积累与传承。菊花酒曾经白居易和杜甫调制配方，花色拼盘的色彩搭配出自宣和或永乐年间，而你在宴席上品尝的一道道美味，也许曾经出现在司马迁、王羲之、霍去病、李白、王维等人的餐桌上。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	287
1105	关学及其文化精神	9787569520118	9787569520118	马瑞映 	\N	1-1	16开	68.00	\N	陕西师范大学出版总社	\N	\N	\N	2020-12-01	/book/4e818efa-f916-43bd-8b10-6e0dc3931baa9787569520118.jpg	本书以“何谓关学”谈起，从张载及其关学、关学的传承与流变、关学的精神气象、关学的时代价值等方面，深入阐述了作为陕西地区最为重要的学派——关学其所蕴含的尊礼贵德、经世致用、开放包容、崇尚气节的精神传统，在中国思想文化史上具有的承前启后的重要地位。在今天推动中华传统文化复兴的新时代，本书对深入挖掘和创新传承关学，让关学的优秀精神在新的历史条件下重放光辉、再呈异彩，有重要意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	798
1106	第一书记扶贫手记	9787569502732	9787569502732	贾平凹 	\N	1-1	16开	88.00	\N	陕西师范大学出版总社	\N	\N	\N	2018-10-01	/book/9fa4820a-b220-4892-8134-b10a81234ca99787569502732.jpg	本书系统总结第一书记的基层工作经验、扶贫成果。该书内容丰富，情真意切，讴歌扶贫精神，歌颂伟大时代，对奋战在乡村振兴一线的第一书记和农村基层干部无疑是一道营养丰富的精神大餐。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	114
1107	西京故事（插图本）	9787569505887	9787569505887	陈彦 	\N	1-1	16开	58.00	\N	陕西师范大学出版总社	\N	\N	\N	2019-07-01	/book/8899b7ea-33c1-4345-aebe-aaa1309c4a449787569505887.jpg	该书讲述了一群生活在西京城里的普通人的故事。一个租住着数十位农民工的西京大杂院中，迎来了一家四口“西京寻梦”人。一家之长罗天福，因女儿甲秀、儿子甲成先后考上重点大学，而领着妻子，从乡村来到西京城，用打“千层饼”的手艺支撑起了他们在西京城里的新生活。梦在跳荡、变幻，人在寻觅、确立……作品展现了生活在城市中的农村人面对种种意想不到的困难如何自强不息、努力实现梦想的历程，于平凡中传递一种折不弯、压不垮的人性品质和人格力量。整个故事一气呵成、直击人心、震撼心灵。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	239
1108	国府西迁	9787569508406	9787569508406	唐润明 	\N	1-1	16开	88.00	\N	陕西师范大学出版总社	\N	\N	\N	2020-07-01	/book/c3ba0ebf-3dc6-4d6a-a66e-899ceb0bfa529787569508406.jpg	“大迁徒抗战实录”丛书定位于建立在学术基础上的通俗作品，资料新颖真实，学术观点前沿，涵盖政府、金融、企业、科技、文化、医疗救助等各个领域。通过大量的日记、图片、资料展示的不是前线的浴血奋战，而是有为延续民族的血脉、为支援前线进行艰苦卓绝的迁移之旅。本套丛书立意不仅宣传此段值得咀嚼，值得流传却鲜为知晓的历史，更要展示中国人不屈不挠之民族精神。《国府西迁》卷主要记述抗战期间政府机构的变化与迁徙，以及在重庆的发展。 	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	651
1109	陕西古代文明	9787569510188	9787569510188	王炜林 	\N	1-1	16开	198.00	\N	陕西师范大学出版总社	\N	\N	\N	2019-10-01	/book/844637da-5f67-4812-a97f-c5f615c233c29787569510188.jpg	陕西是中华文明的重要发源地之一，曾长期是中国古代历史的中心舞台。独特的历史地位造就了陕西文化遗存的完整性、丰富性和至高性，也成就了陕西历史博物馆“古都明珠，华夏宝库”的美誉。本书按照陕西历史博物馆最新基本陈列“陕西古代文明展”的陈列体系，通过对史前、商周、秦、汉、魏晋、隋唐和宋元明清七个时期历史的深度解读以及重点文物内涵的深度挖掘，全面展示了陕西古代文明孕育、发展、鼎盛的过程及其发展成就，力求增进观众对陕西古代文明的了解和认识，充分感受陕西古代文明的辉煌与神韵。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	269
1165	新英语语法教程（第二版）	9787521315622	9787521315622	何桂金、高纪兰 	\N	2	16开	69.90	\N	外语教学与研究出版社	\N	\N	\N	2019-09-18	/book/b02ebd6e-e3bc-4b9a-be29-7e2a275c0c359787521315622.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	536
1115	中华通历·先秦（全2册）	9787561398968	9787561398968	王双怀 编著 	\N	1-2	16开	790.00	\N	陕西师范大学出版总社	\N	\N	\N	2018-04-01	/book/b2cbce68-2bcd-4ad1-a33e-8a7ff137c4c09787561398968.jpg	《中华通历·先秦》是一部中国先秦时期中西历日对照的工具书，商周部分从公元前 1400 年开始，据当时的实际天象编制，春秋部分用《鲁历》，战国部分用《殷历》及《瑞顼历》，列举年代异同或月首差异。 每年一表，有年代、月序、日序、中西历日对照、节气与天象等栏目。书后还附有一些实用的历法资料和年代资料。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	469
1116	中华通历·宋辽金元（全2册）	9787561399002	9787561399002	王双怀 编著 	\N	1-2	16开	550.00	\N	陕西师范大学出版总社	\N	\N	\N	2018-04-01	/book/13a3ceef-c9e0-4cd4-970e-c529c16dcb1d9787561399002.jpg	《中华通历·宋辽金元》是一部中国宋辽金元时期中西历日对照的工具书，时间跨度为宋太祖建隆元年（公元960~961年）至元顺帝至正二十七年（公元1367~1368年），内容涉及北宋、南宋、辽、金、蒙古、元六个历史时期。 每年一表，有年代、月序、日序、中西历日对照、节气与天象等栏目。书后还附有一些实用的历法资料和年代资料。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	943
1117	中华通历·明清	9787561399019	9787561399019	王双怀 编著 	\N	1-2	16开	390.00	\N	陕西师范大学出版总社	\N	\N	\N	2018-04-01	/book/08cb9b0e-588e-4ff4-b6dd-61b960e837d39787561399019.jpg	《中华通历·明清》是一部中国明清时期中西历日对照的工具书，时间跨度为明太祖洪武元年（公元1368~1369年）至清宣统三年（公元1911~1912年），内容涉及明、清两个历史时期和后金、太平天国两个政权。 每年一表，有年代、月序、日序、中西历日对照、节气与天象等栏目。书后还附有一些实用的历法资料和年代资料。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	505
1118	王广成剪纸艺术精选：剪纸里的中国	9787567028951	9787567028951	王广成 	0	1-1	16开	108.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2021-12-07	/book/9482dfff-8012-4da2-804a-9267b8dc8de11080704.jpg	作者作为研究员、工艺美术大师，将多年作品集结成册。这本《剪纸艺术精选：剪纸里的中国》，运用传神的造型、优美的线条、娴熟的技法，呈现了成千上百中国传统文化形象。这些生动的作品（福禄寿喜、中国名建筑等）皆取材于中国文化，传统寓意和现代元素立体交融，蕴含灵动丰厚的思想内涵，呼吁广大读者关注传统文化、热爱祖国。本书文化味道浓郁，文化内涵丰润，不仅用优美的剪纸艺术造型赢得读者的青睐，还以深厚的人文寓意引人入胜。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	157
1119	海洋科学概论	9787567011380	9787567011380	赵进平 	0	1-1	16开	72.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2021-11-25	/book/49bc3c1c-4790-490a-ac29-6abe680ea7681080705.jpg	本书深入浅出地介绍了海洋科学各个主要方向的基本内容，涉及面广，易于理解，有利于读者拓展知识面，增进对海洋科学的全面理解。内容包括海底地形地貌、海水运动、海水的化学组成、海洋中的生命、海洋生态系统、海洋生物地球化学循环、海洋矿产资源、海洋与气候、海洋中光的传输、海洋中声的传播、海洋环境保护、海洋调查等。本书由中国海洋大学教授编写，力图从较高的立脚点看待海洋科学，建立基础知识与最新科学知识的关系，注重不同学科间的联系，有利于海洋科学的学科交融。可供海洋科学专业各个方向的本科生，非海洋专业的本科生、研究生授课使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	252
1120	海水淡化产业发展研究及战略思考	9787567028180	9787567028180	张晓东，杨兴涛 	0	1-1	16开	62.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2021-07-06	/book/14be9f07-ba27-4311-b82b-6e431567f0801080714.jpg	本书主要介绍了海水淡化在推进生态文明建设中的战略意义，保障国家水资源安全的应用场景，结合山东半岛地区水资源分析，推动山东半岛和青岛市海水淡化的利用及规模化布局。海水淡化与常规水源全周期产水成本对比分析。结合山东省的的实际从技术、经济和政策等多方面积极有效地推动海水淡化产业发展。本书主要特点是针对山东半岛地区海水淡化建设的战略推动。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	134
1121	海洋文化概论	9787810670937	9787810670937	曲金良 	0	1-1	大32开	32.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2021-03-15	/book/459eb847-342b-44cd-84a9-a2a8c67032ec1080722.png	这是我国海洋文化学基础理论专著，已被有关大学包括国家重点大学确定为人文素质教育教材和基础课程专用教材。《海洋文化概论》主编是我国海洋文化学科的积极倡导者和创建者。随着“海洋世纪”蓝色浪潮的兴起，海洋科技不断创新，海洋经济日趋繁荣，性的海洋意识、海洋观念日益强化，海洋文化研究和学科建设被提上了议事日程，并引起了越来越多人文社会科学学者的浓厚兴趣，受到了社会各界的普遍关注。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	381
1122	救援潜水员手册	9787567026568	9787567026568	王奇 王佐恺 	0	1-1	16开	200.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2021-06-04	/book/b0c371da-cd60-4a30-ab10-99c1836004d81080737.jpg	学会如何应对各种突发状况，在水下救人和自救的保命技巧。本书主要介绍如何避免潜水危险及意外的发生，并能随时应付水中的紧急状况。培训技巧包括自救练习，救助疲惫潜水员、恐慌潜水员、遇难潜水员、失踪潜水员、无反应潜水员的正确程序和技巧，潜水意外情节模拟等等。学习完成后你将知道如何应对各种复杂的潜水紧急情况，在紧急情况发生时如何为其他潜水员提供救助。可供潜水领导与管理人员、潜水训练人员使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	422
1160	社会语言学视角下的共同体	9787513502467(01)	9787513502467(01)	胡荫桐、段晓英等 	\N	2	大32开	49.90	\N	外语教学与研究出版社	\N	\N	\N	2020-03-09	/book/f7b62d04-ad81-4d7d-9c91-f358621069299787513502467(01).jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	969
1123	海洋可控源电磁法三维有限元正演	9787567026865	9787567026865	叶益信，李予国 	0	1-1	16开	58.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2021-04-27	/book/12f09420-d2e0-459a-b619-c9d5da7561b91080751.jpg	海洋可控源电磁法是近年来大力发展并逐渐被广泛采用的海洋地球物理勘查技术。为了提高复杂地质构造情况下海洋可控源电磁三维正演的精度，提升复杂海底地形下海洋可控源电磁三维数据解释的能力，本书对频率域海洋可控源电磁三维有限元正演进行了系统的研究，包括结构网格、非结构网格、自适应非结构网格、电导率各向异性的海洋可控源电磁三维有限元正演等8个方面，并分析了覆盖层各向异性和储层各向异性对海洋可控源电磁响应的影响特征。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	257
1162	英汉认知语义对比研究	9787521321586	9787521321586	刘正光 	\N	1	16开	105.90	\N	外语教学与研究出版社	\N	\N	\N	2020-11-01	/book/bbbadb7e-34f4-49c8-bf0e-7e7f0d46556d9787521321586.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	541
1124	海商法	9787567025530	9787567025530	马炎秋 	\N	1-1	16开	58.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2020-10-13	/book/82b61354-57b4-4536-bebc-348eb58455569787567025530.jpg	本书全面阐释海商法基本原理和基本知识，内容主要包括：船舶和船员；有关海上货物运输、海上旅客运输、租船、拖航、救助、保险的合同关系；船舶碰撞、船舶污染海洋环境等行为所造成的人身伤亡、财产损失的当事人或者加害方与受害方之间的侵权法律关系；海上风险产生的共同海损、海事赔偿责任限制、船舶优先权等特殊民事法律关系。本教材突出“双语”特点，注重理论与实际的结合，可作为高等院校相关专业本科生和研究生的海商法教材，也可作为通识课程的教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	627
1125	南沙群岛珊瑚礁鱼类图鉴	9787567022096	9787567022096	方宏达、吕向立 	\N	1-1	16开	368.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2020-04-24	/book/06921c27-847c-463e-9744-d34227e861789787567022096.jpg	本书共记录珊瑚礁鱼类30科250多种，从其形态特征、生活习性、生态分布等方面进行了专业的描述。珊瑚礁鱼类是珊瑚礁生态系统重要的组成部分，南沙群岛毗邻世界珊瑚礁核心区域，鱼类资源极为丰富。本书首次全面收集了南沙群岛珊瑚礁鱼类种类图谱，为我国珊瑚礁鱼类物种多样性研究和珊瑚礁生态保护提供了重要的数据资料。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	677
1126	海洋生物学	9787567016200	9787567016200	张士璀 何建国 孙世春 	\N	1-1	16开	76.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2018-05-16	/book/5ec9559a-7659-4410-82be-9126f7a4223e9787567016200.jpg	海洋生物学研究海洋中生命现象、过程 及其规律的科学，是海洋科学的一个主要学科，也是生海洋生物学是一门综合性交叉学科，主要包括海洋有机体的功能，海洋生物多样性和生态三个方面的内容。它是研究海洋中生命有机体的起源，分布，形态和结构，进化与演替的特征和生物生命过程的活动规律；探索海洋生物之间和生物与其所处的海洋环境之间的相互作用和相互影响的科学。命科学的一个重要分支。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	355
1127	海洋管理概论	9787810674478	9787810674478	管华诗 王曙光 	\N	1-1	16开	28.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2015-08-20	/book/7e11741b-7498-4bed-ba79-1a705d93e54f9787810674478.jpg	本书在阐述海洋政策、海洋立法、海洋权益、海洋功能区别的基础上，从理论与实践的结合上分别讨论了海洋资源管理、海洋环境管理、海洋科技及其产业化管理、海洋经济管理、海洋人力资源管理和海洋执法管理等问题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	439
1128	“一带一路”大型系列丛书.	9787566018892	9787566018892	张新荃 	\N	1-1	16开	58.00	\N	中央民族大学出版社	\N	\N	\N	2021-05-01	/book/88df9f0f-6e05-497e-89fa-07f4e7bdf2339787566018892.jpg	《城外有片石头地》是一本描写新疆山水风光和人文精神的散文集，是作者对新疆怀着深情厚谊、热爱缱绻的真情表白。作者以强烈的责任感和使命感，深入基层第一线，体验火热的生活，以饱满的激情，创作出了大量浓郁的地域特色，散发着深情的乡土气息文学作品。作者以独特眼光，以优美语言，以真实朴实和慷慨激昂的情感，描写了几代新疆人团结奋进、砥砺前行、无私奉献，为加快新疆发展建设做出的积极贡献。歌颂大美新疆，赞扬“一带一路”给新疆带来的巨大发展变化，彰显了新疆各族人民建设新疆的伟大成就。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	216
1129	丝绸之路乐舞艺术研究资料汇编.	9787566015808	9787566015808	孟凡玉主编 	\N	1-1	16开	228.00	\N	中央民族大学出版社	\N	\N	\N	2019-09-01	/book/9f7d195c-8fe1-493e-b858-30217557bd409787566015808.jpg	《丝绸之路乐舞艺术研究资料汇编》系列书稿一共四本，是对于丝绸之路上音乐舞蹈绘画等艺术的研究资料的分类集成。本论文集是其中的“敦煌卷”，书中以敦煌为主题，搜集了几十年来与敦煌有关的乐器、乐谱、讲唱艺术、舞蹈、壁画音乐等经典论文，这些论文基本上都在各大专业期刊上发表过。此论文集的出版有助于敦煌艺术遗产的开掘、继承和发扬。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	871
1130	中国人口较少民族舞蹈文化传承与审美研究丛书：多元一体：民族文化复兴的格局与路径	9787566007070	9787566007070	邓佑玲主编 	0	1-1	16开	76.00	\N	中央民族大学出版社	\N	\N	\N	2021-03-01	/book/35cecfbc-97a7-43f4-8bb6-4233297cfa6a9787566007070.jpg	《多元一体：民族文化复兴的格局与路径》由以下调研报告组成：一、基诺族舞蹈文化田野调查报告；二、京族舞蹈文化田野调查报告；三、达斡尔、鄂温克、鄂伦春族舞蹈田野调查报告；四、新疆伊宁塔塔尔族“艾皮帕”舞蹈田野调查报告；五、毛南族“肥套”仪式田野调查报告。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	732
1131	“一带一路”大型系列丛书.	9787566016409	9787566016409	李佩红著 	\N	1-1	16开	68.00	\N	中央民族大学出版社	\N	\N	\N	2019-04-01	/book/8a52a9ef-9667-4f49-9c16-ca5a011b00089787566016409.jpg	作品撷取了新疆从北至南的人文地理、自然风光，物产和饮食文化等内容，集结几十余篇作者精选出来的有关新疆的散文作品。作者试图以天山为骨，向天山南北两侧辐射，北至塔城、阿勒泰，南至和田、喀什，较为详尽地展现新疆色彩斑斓的独特的民族风貌和风采，希望让内地人对大美新疆有浮光掠影的了解，激发人们对新疆大地的热爱，对促进新疆文化旅游很一定的帮助。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	771
1132	“一带一路”大型系列丛书.	9787566017536	9787566017536	徐常根著 	\N	1-1	16开	88.00	\N	中央民族大学出版社	\N	\N	\N	2019-12-01	/book/2aafccb5-37b8-4f8b-a7cb-9e8be0e692659787566017536.jpg	在雪域高原边防工作生活的五年里，作者亲历并用真情记录了新疆军区驻雪域高原边防官兵，长年克服高原缺氧、孤寂等常人难以忍受的困难，用生命忠诚戍边，守护祖国疆土的的感人故事，讲述了一个个年轻的戍边官兵，在生命禁区艰辛备至、可歌可泣的生活故事。作品浓笔重彩，荡气回肠，感人肺腑。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	676
1135	中国人口较少民族舞蹈文化传承与审美研究丛书：民族舞蹈田野调查笔记第三辑：鄂伦春族、赫哲族、鄂温克族、达斡尔族	9787566013828	9787566013828	邓佑玲主编 	0	1-1	16开	98.00	\N	中央民族大学出版社	\N	\N	\N	2021-03-01	/book/43a8956e-f629-44ac-adcf-56811d0f47ee9787566013828.jpg	主要内容是有关鄂伦春族、赫哲族、鄂温克族、达斡尔族的舞蹈田野调查笔记。各分册全面记录了调查者每天的舞蹈调查经历，除了对被访谈者的情况及访谈内容做全面记录外，还对调查过程中的所见所闻进行了详细的记录。所调查的内容除了与舞蹈有关的各种表演外，还涉及当地的山川风貌、风土民情、节庆活动、民族服饰等少数民族的各项传统文化。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	633
1136	中国人口较少民族舞蹈文化传承与审美研究丛书：民族舞蹈文化传承与流变研究	9787566010926	9787566010926	邓佑玲主编 	0	1-1	16开	64.00	\N	中央民族大学出版社	\N	\N	\N	2021-03-01	/book/352eb853-e654-40d2-9b32-ef6cdf265b529787566010926.jpg	《民族舞蹈文化传承与流变研究》由七篇有关少数民族舞蹈的研究论著组成：一、阿昌族“蹬窝罗”舞蹈文化传承与演变研究；二、广西京族舞蹈文化调研报告；三、赫哲族舞蹈文化流变研究；四、鄂温克族民间舞蹈传承现状研究；五、新疆伊宁塔塔尔族“艾皮帕”舞蹈调查报告；六、云南基诺族舞蹈文化调研报告；七、新疆奇台塔塔尔族舞蹈文化调研报告。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	192
1137	中国人口较少民族舞蹈文化传承与审美研究丛书：民族舞蹈概论	9787566011602	9787566011602	邓佑玲主编 	0	1-1	16开	66.00	\N	中央民族大学出版社	\N	\N	\N	2021-03-01	/book/1877d5d4-8c9b-48d8-a5ad-dc39d835bb119787566011602.jpg	　　《民族舞蹈概论》是一部研究我国少数民族舞蹈的专著，主要包括以下内容：绪论；章 民族舞蹈概说；第二章 民族舞蹈研究方法论；第三章 民族舞蹈起源发生论；第四章 民族舞蹈传承与发展论； 第五章 民族舞蹈存在类型论；第六章 民族舞蹈本体特征论；第七章 民族舞蹈功能价值论；第八章 民族舞蹈教学论。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	539
1138	丝路骑手：红柯评传	9787566018113	9787566018113	韩春萍 	\N	1-1	16开	49.50	\N	中央民族大学出版社	\N	\N	\N	2020-10-01	/book/f73d454b-6bd1-47ff-a442-e1b9d761b1939787566018113.jpg	陕西作家红柯是近年来公认的最具创作实力的作家之一，2018年2月突然去世让文坛惋惜，书写红柯评传就是对红柯及其创作的系统梳理和研究。红柯曾在新疆生活十年，从上世纪九十年代开始致力于对陆上丝绸之路沿线各民族文化的挖掘和书写。除了诗歌和散文集《绚烂与宁静》《龙脉》之外，出版的中短篇小说集有《美丽奴羊》《金色的阿尔泰》《跃马天山》《黄金草原》《古尔图荒原》《莫合烟》《狼嚎》《复活的玛纳斯》等；长篇小说主要有《西去的骑手》《天下无事》《老虎!老虎!》《大河》《百鸟朝凤》《好人难做》《乌尔禾》《生命树》《喀拉布风暴》《少女萨吾尔登》《太阳深处的火焰》等。曾获首届冯牧文学奖，第二届鲁迅文学奖，首届中国小说学会长篇小说奖，第九届庄重文文学奖，连续入围四届茅盾文学奖前十名；被评论界视为继柳青、杜鹏程、陈忠实、贾平凹、路遥之后的陕西第三代标志性作家；同时，作为西部现代文学的代表作家，红柯的小说创作实绩也进入了《中国西部现代文学史》等有关文学史著。本专著以著名作家红柯以及作品为评论对象，以作家的成长年谱努力勾勒出红柯的创作与生活全貌，为学界进一步研究打下基础。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	279
1139	环境与精准预防	9787313204721	9787313204721	邬堂春 等 	\N	1-1	16开	198.00	\N	上海交通大学出版社	\N	\N	\N	2020-01-01	/book/0ac47fff-0a6c-4261-b952-51c5d4a9c3ba9787313204721.jpg	本书为精准医学出版工程?精准预防系列丛书之一。本书从环境污染、职业病、生活习惯等多角度出发，分析环境因素对健康的影响，以及如何通过积极采取相应干预措施，减少甚至消除环境因素对健康的不良影响，实现精准预防的目标。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	839
1140	传染性疾病与精准预防	9787313204820	9787313204820	阚飙 等 	\N	1-1	16开	198.00	\N	上海交通大学出版社	\N	\N	\N	2020-03-01	/book/8233dc1c-1010-4f3d-9276-78e4710cc3019787313204820.jpg	本书为精准医学出版工程?精准预防系列丛书之一。本书从传染性疾病的微生物学、分子遗传学、基因组学研究等多个角度分别阐述传染性疾病的分子机制，并介绍了相应的精准预防策略研究进展，为传染性疾病的精准防控提供参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	625
1141	脑-计算机交互研究前沿	9787313209948	9787313209948	高上凯 吕宝粮 张丽清 	\N	1-1	16开	368.00	\N	上海交通大学出版社	\N	\N	\N	2019-12-01	/book/7c841d88-a065-4eb3-ab89-b3efe744be5a9787313209948.jpg	本书为“类脑计算与类脑智能研究前沿”系列之一。本系列图书正是在中国“脑计划”这一国家级发展战略大背景下，全面梳理我国在类脑计算与类脑智能领域的创新性前沿成果，填补我国在类脑计算与类脑智能在出版领域的空白。本系列图书以专题论述的方式，邀请国内类脑计算领域、脑影像及图谱领域、神经科学领域、人机交互领域、语言处理领域有造诣的学者合力撰写完成。图书主要围绕类脑计算与类脑智能方向的前沿创新技术，介绍类脑计算与类脑智能相关的概念理论、模型和应用，并对相关定义与描述进行研究和讨论，做出权威性的界定。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	328
1142	听觉信息处理研究前沿	9787313222060	9787313222060	党建武 俞凯 等 	\N	1-1	16开	248.00	\N	上海交通大学出版社	\N	\N	\N	2021-05-01	/book/15935238-5208-498b-a22f-5127c078690d9787313222060.jpg	本书为“类脑计算与类脑智能研究前沿”系列之一。本系列图书正是在中国“脑计划”这一国家级发展战略大背景下，全面梳理我国在类脑计算与类脑智能领域的创新性前沿成果，填补我国在类脑计算与类脑智能在出版领域的空白。本系列图书以专题论述的方式，邀请国内类脑计算领域、脑影像及图谱领域、神经科学领域、人机交互领域、语言处理领域有造诣的学者合力撰写完成。图书主要围绕类脑计算与类脑智能方向的前沿创新技术，介绍类脑计算与类脑智能相关的概念理论、模型和应用，并对相关定义与描述进行研究和讨论，做出权威性的界定。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	346
1143	肿瘤的精准免疫治疗	9787313226310	9787313226310	钱其军 田志刚 韩为东 等 	\N	1-1	16开	268.00	\N	上海交通大学出版社	\N	\N	\N	2020-11-01	/book/4d4ab27f-cfd7-4137-bd58-217e5cc7a9f29787313226310.jpg	本书为精准医学出版工程?精准治疗系列丛书之一。本书系统阐述了细胞免疫治疗的最新前沿进展，内容包括肿瘤抗原的精准分析、肿瘤疫苗、T细胞免疫、NK细胞免疫、免疫检查点抑制或激活、健康和肿瘤状态下精准免疫的评估等，为从事细胞免疫治疗的临床和科研人员提供参考和借鉴。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	140
1164	学术英语（第二版）综合	9787521325874	9787521325874	季佩英、范烨、吴晶 	\N	2	大16开	49.90	\N	外语教学与研究出版社	\N	\N	\N	2021-06-30	/book/f1a8ed5a-422f-4ab5-b47c-1ac80bb9f1839787521325874.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	758
1196	物理诊断学（第4版）	9787565918711	9787565918711	马明信 贾继东 	\N	\N	16开	65.00	\N	北京大学医学出版社	\N	\N	\N	2019-01-01	/book/ea416dbe-6154-460f-b9d5-e6ec08f4b8ec9787565918711.jpg	物理诊断学是一门临床医学的入门课程，即由基础医学向临床医学过渡的一门必修的桥梁课。本教材是为本科院校医学生编写，可尽量满足培养临床合格医师的需要。本书目前是第四版，在继续坚持本教材特色的同时，进行了适当地修改和补充，并在相关章节强调了有关加强医患沟通、人文关怀和培养良好职业素质的问题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	663
1144	人类未来	9787313227317	9787313227317	【英】马丁·里斯（Martin Rees） 	\N	1-1	32开	58.00	\N	上海交通大学出版社	\N	\N	\N	2020-03-01	/book/f61d9051-6536-4751-ad8d-6a28f6b4013b9787313227317.jpg	本书是英国著名理论天文学家、数学家、前英国皇家学会会长、《DK宇宙大百科》作者马丁?里斯（MartinRees）的最新力作。 生物技术、网络技术、机器人技术和人工智能的进步——如果我们能够明智地加以追求和应用——将使我们能够促进发展中国家和发达国家的发展，并克服人类在地球上面临的威胁，从气候变化到核战争。与此同时，太空科学的进一步进步将使人类能够利用机器人和人工智能探索太阳系及更远的地方。但是地球上没有“B计划”——如果我们不关心我们的地球，就没有可行的替代方案。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	138
1145	中国对日战犯审判档案集成	9787313227942	9787313227942	中国第二历史档案馆，东京审判研究中心 	0	1-1	16开	61,200.00	\N	上海交通大学出版社	\N	\N	\N	2019-10-01	/book/6be9a0c3-f56e-4c4a-b5fb-645079b3ae869787313227942.jpg	本项目旨在将中国第二历史档案馆所藏此前从未公开的战后日本战犯审判资料悉数呈现，不仅包含处理战犯各项条例、办法及审判程序；战犯处理委员会会议记录等关键资料，各审判法庭及相关委员会提审战犯的文件和起诉书、请愿书、供词、判决书、见证人名单以及审判记录等审判材料，更涵盖地方法院、县乡公所等所存调查表、战犯名册，另有公审日本战犯及日本投降情形照片等。资料的全面、完整程度前所未有。由东京审判研究中心编纂的相关索引和附录，则大大提升了资料使用和研究的便利性。共约5万面。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	147
1146	信息经济学：如何对信息资产进行定价、管理与度量	9787313229625	9787313229625	[美]道格拉斯·B.莱尼（Douglas B.Laney） 	\N	1-1	16开	88.00	\N	上海交通大学出版社	\N	\N	\N	2020-03-01	/book/dad94157-d246-4b15-879e-0a800f97a90f9787313229625.jpg	信息经济学研究了信息的经济意义，它力求将经济和资产管理原则和做法应用于信息资产的估值，处理和部署。本书在全面阐释信息经济学的同时，解决了以下问题： ?CEO和企业领导者如何更充分地将信息作为企业资产?CIO如何提高信息的流动性和可访问性?首席财务官如何帮助企业衡量信息资产的实际和潜在价值。 本书读者对象为首席数据官（CDO）和企业高层管理者等。本书英文原版由英国知名人文社科出版社劳特里奇出版，翻译将由中欧商学院组织团队进行。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	900
1147	查医生援鄂日记	9787313229878	9787313229878	上海交通大学医学院附属仁济医院 	\N	1-1	32开	45.00	\N	上海交通大学出版社	\N	\N	\N	2020-04-01	/book/6f4d1d00-c621-4775-8578-a9d28f03830b9787313229878.jpg	1月24日除夕之夜，查琼芳医生随上海第一批援鄂医疗队启程，赴湖北省金银潭医院，参加新型冠状病毒感染肺炎患者救治工作。在紧张繁忙的援助工作中，她每天用讯飞语音发回一段日记，第一时间真实反映抗疫工作中的感人故事、人物、思考，由仁济医院党委宣传部整理成文。2020年1月24日，除夕之夜，上海第一批援鄂医疗队启程，赴湖北省金银潭医院，参加新型冠状病毒感染肺炎患者救治工作。仁济医院查琼芳医生随队前往。在紧张繁忙的援助工作之余，她每天用讯飞语音发回一段日记，以抗疫一线医生的视角记录了大疫之下的举国之战。全书文笔流畅，语言朴实，查医生细腻的多维视角客观陈述了查医生周围忙忙碌碌的方方面面，查医生不仅看到了医院内医护人员的努力，还看到了李克强总理来视察后的变化，从上海一路不停歇给医生们送来军大衣的集卡司机，各界朋友联系医护人员捐赠的防护用品……	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	137
1148	射频电子辐照加速器原理与关键技术	9787313231864	9787313231864	李金海 	0	1-1	16开	198.00	\N	上海交通大学出版社	\N	\N	\N	2020-09-01	/book/d78c4298-71ca-4a28-b9db-960eb0b344309787313231864.jpg	本书为“先进粒子加速器系列”之一，主要介绍大功率电子直线加速器和大功率重入式电子加速器的相关设计与工程技术问题，以及大功率电子加速器的相关技术问题。具体内容包括大功率电子辐照的应用概述、电子直线加速器的工程技术、电子直线加速器功率效率、辐照均匀化、重入式加速器、X射线转换靶、束流引出的真空隔离等。本书的读者对象为加速器相关领域的研究生、青年学者、工程师，以及相关研究人员和应用人员。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	193
1149	型号空气动力学设计	9787313233479	9787313233479	张锡金 等 著 	\N	1-1	16开	198.00	\N	上海交通大学出版社	\N	\N	\N	2020-12-01	/book/38eb5793-660d-474c-8870-8dda7e385c0e9787313233479.jpg	本书是“大飞机出版工程”系列图书之一。经典内容包括升力产生的无粘与粘性机制，低速翼型与机翼空气动力学，一般亚、跨、超音速空气动力学和粘性流动的一些内容。非经典内容包括非定常空气动力学，高超音速流动及相关技术和大气环境与大气飞行器。除飞行器本身的空气动力学外，还较多介绍了一些其他飞行物包括昆虫所涉及的空气动力学现象。本书兼顾了空气动力学的规范内容和趣味性内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	985
1150	现代涡轮喷气航空发动机简明手册	9787313233943	9787313233943	王光秋 杨晓宇 	\N	1-1	16开	158.00	\N	上海交通大学出版社	\N	\N	\N	2020-11-01	/book/d956848a-34e0-4083-808e-c9f99fef593e9787313233943.jpg	本书是“大飞机出版工程”系列之一。本手册主要介绍国外现代大、中型涡轮喷气式航空发动机产品需求背景、基本结构、技术参数和应用机型。重点介绍国外著名制造商开发的涡扇发动机产品，包括新一代宽体客机和单通道客机选配的先进大涵道比涡扇发动机，也包括新构型发动机产品如齿轮传动涡扇和桨扇发动机。此外，手册中也简要介绍了具有代表性的民用超音速发动机和军用变循环涡轮发动机产品特点和基本技术参数。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	242
1151	压气机气动力学	9787313235794	9787313235794	【英】尼克·坎普施缇 	\N	1-1	16开	248.00	\N	上海交通大学出版社	\N	\N	\N	2021-01-01	/book/b6165ab0-4ef4-4c99-bb81-21b399a534d39787313235794.jpg	本书是“大飞机出版工程·航空发动机系列”丛书之一。航空发动机技术包含诸多关键技术，而空气动力学是其中一项十分重要的内容，本书主要论述涉及核心机(压气机、燃烧室、涡轮)内部的气流流动问题，还考虑内、外流耦合及涡轮叶片内部气流特性问题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	340
1152	中国外来入侵植物志·第一卷	9787313237651	9787313237651	丛书主编：马金双；第一卷作者：闫小玲、严靖、王樟华、李惠茹 	\N	1-1	16开	210.00	\N	上海交通大学出版社	\N	\N	\N	2020-12-01	/book/32809f85-d7f4-4e16-afda-4b8cc6c3a1829787313237651.jpg	《中国外来入侵植物志·槐叶苹科—景天科卷》，根据文献记载和大规模的野外调查，本卷包含本槐叶苹科、满江红科、桑科、荨麻科、蓼科、商陆科、紫茉莉科、番杏科、马齿苋科、落葵科、石竹科、藜科、苋科、仙人掌科、毛茛科、睡莲科、胡椒科、罂粟科、白花菜科、十字花科、木犀草科、景天科。每一种植物都有学名、分类地位、异名、生物学特征、识别要点、原产地、入侵时间、入侵方式、传播途径、入侵生境、危害状况、繁殖方式、可能扩散的区域、防治及管理办法，包括原始文献引证、文献引证和照片图版等。同时，书中还收录这些入侵种的相近种。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	165
1153	胃癌：基础与临床的转化	9787313239808	9787313239808	王理伟， 徐惠绵，曹晖，等 	\N	1-1	16开	228.00	\N	上海交通大学出版社	\N	\N	\N	2020-12-01	/book/d8494eb3-2ec2-4214-af40-cd18b97b46eb9787313239808.jpg	本书为《转化医学出版工程·肿瘤系列》之一。胃癌是威胁人类健康的常见恶性肿瘤之一.近年来,手术方式的改革和放化疗方案的优化仍远未达到降低胃癌发病率和病死率的目标，转化医学作为一种全新的研究模式已引起研究者的重视，并取得了很好的效果。本书较系统地阐述了国内外在胃癌基础研究和临床研究中的现状及最新进展，侧重胃癌的预测、预防、诊断和治疗的转化医学研究，如尤其是中国的成功经验，重点展示作者的原创性成果，体现基础与临床的相互促进，并对整个学科的发展、机遇和挑战提出了应对策略。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	486
1154	头颈部肿瘤：基础与临床的转化	9787313240309	9787313240309	嵇庆海，高明 	\N	1-1	16开	268.00	\N	上海交通大学出版社	\N	\N	\N	2020-12-01	/book/4628031a-9668-48ae-b8ee-ba3a896d41729787313240309.jpg	本书为《转化医学出版工程·肿瘤系列》之一。本书将聚焦于甲状腺肿瘤和头颈部鳞癌的转化医学研究，主要分为两个部分：第一部分包括甲状腺癌的流行病学与病因学，分子诊断、分子标记、分子分型及其应用，以及治疗进展；第二部分包括头颈部鳞癌的流行病学与HPV感染及其防治、分子分型及标记、治疗进展。本书主要是基于国内研究者的原创性成果进行系统梳理，以期为读者展示国内在头颈部肿瘤研究方面最新的成果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	809
1155	骨肉瘤：基础与临床的转化	9787313240316	9787313240316	蔡郑东 华莹奇，等 	\N	1-1	16开	180.00	\N	上海交通大学出版社	\N	\N	\N	2020-12-01	/book/236df142-7201-4a01-bbda-d236f89a6a479787313240316.jpg	本书为转化医学出版工程系列丛书之一，介绍骨肉瘤转化研究领域近些年来较为重要的成果，对针对骨肉瘤正在开发的一些新药物、新治疗手段进行综述，希望通过本书，能为骨科医生、肿瘤科医生、基础研究人员全面了解骨肉瘤的生物学特性提供一本详实、与时俱进的参考书，促进骨肉瘤研究的开展。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	929
1156	气动声学基础及其在航空推进系统中的应用（英文版）	9787313241412	9787313241412	孙晓峰,王晓宇 	\N	1-1	16开	288.00	\N	上海交通大学出版社	\N	\N	\N	2021-11-01	/book/d97ddc6a-465b-4f1d-813a-24ae473705459787313241412.jpg	本书为“大飞机出版工程·航空发动机二期”丛书中一本，本书系统总结了作者近年来承担的国家与地方重大项目，如作为首席科学家主持的973项目“大型客机主要气动噪声机理及先进控制方法研究”的相关科研成果，深入地阐述了风扇噪声的预测和控制，涡声理论以及燃烧稳定性方面的的新理论、新技术和新进展。内容既有来自于长期实践经验和经典理论的总结，也包含了大量通过基础研究和科学试验得到的数据、模型与理论，以及国外相关领域的先进技术和自主创新成果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	653
1157	钱学森画传	9787313247889	9787313247889	奚启新 著 杨亮 改编 钱学森图书馆 供图 	\N	1-1	16开	68.00	\N	上海交通大学出版社	\N	\N	\N	2021-04-01	/book/3be7a523-e5dc-4c47-b595-d273e882a3e49787313247889.jpg	奚启新，解放军总装备部原专业新闻工作者，曾任新华社驻总装备部支社社长，技术四级，大校军衔。钱学森是中国杰出科学家、中国航天事业奠基人、“两弹一星”功勋奖章获得者，曾任第六、七、八届全国政协副主席。 这部画传图文并茂，收入的千余幅图片，加上钱学森的一些手迹、档案资料和编者撰写的30多万文字、形象生动地再现了钱学森这位享誉海内外的杰出科学家的非凡人生，充分展示了他的崇高风范，也从一个侧面再现了“两弹一星”伟业的光辉历程，并将钱老波澜壮阔的人生历程，与100年来中国和中华民族的重要历史时期、重大历史事件紧密结合起来，不仅记述了钱老跌宕起伏的百年人生，而且折射了中国的百年崛起、中华民族的百年复兴。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	100
1158	破茧成蝶：李盾和他的音乐剧世界	9787313250001	9787313250001	李盾 	\N	1-1	16开	128.00	\N	上海交通大学出版社	\N	\N	\N	2021-08-01	/book/dc0e7e77-5b3e-4a3c-aeb8-df138fec98c19787313250001.jpg	本书是中国著名音乐剧制作人、中国音乐剧教父李盾先生所撰写的关于中国原创音乐剧发展的一本读物，主要讲述了李盾先生从1988年到2019年与音乐剧结缘的三十余年经历。1997年，由李盾先生制作的中国第一部原创音乐剧《白蛇传》的首演，也标志着中国原创音乐剧的一个起点。2007年，音乐剧《蝶》的问世，更让中国音乐剧在世界的舞台上奠定了新的高度。时至今日，音乐剧的市场在中国已经遍地开花，正朝气蓬勃地迎来春天…… 站在世界的中心，讲好中国故事。李盾先生将用他30年来的经历与成就，向我们展现中国音乐剧从无到有的30年来的发展和变化。这更是他所坚持的一个信念：世界的重心在倾斜、在向亚洲倾斜，亚洲的中心就在中国，中国五千年的民族拥有太多感天动地的伟大故事，通过音乐剧这种艺术形式，把中国的故事推向世界，引领时代的发展，成为“社会货币”在全世界流通。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	163
1159	遇见影视艺术	9787313250100	9787313250100	天云，武谓；总主编：陈立民 	\N	1-1	32开	68.00	\N	上海交通大学出版社	\N	\N	\N	2021-07-01	/book/266dde3c-0ee7-455e-aaab-cd8a7e5bc56a9787313250100.jpg	《简明影视艺术读本》是“简明艺术读本”书系中的一本，是面向对影视专业有兴趣的读者群体的科普性读物。影视艺术包含电影与电视，是一门综合的大众艺术。读者通过该书稿可以了解到影视艺术创作的基本组成，如编剧、导演、表演、摄影、剪辑、影视音乐等。书稿从实际案例出发，详细分析了影视基本要素的功能作用及创作技巧，中国电影基本发展史以及影视审美的基本概念等。同时，该书稿以近年来影视热点现象及问题为基础，描述并分析了影视、文学与戏剧之间的关系，拓展了读者的专业视野及思路，为广大影视从业者与爱好者提供丰富的参考资料。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	247
1168	战争文学	9787521324242	9787521324242	胡亚敏 	0	1	16开	62.90	\N	外语教学与研究出版社	\N	\N	\N	2021-03-01	/book/4f7da3dd-1aec-46e5-82c2-cc2c33fd78d59787521324242.jpg	　　本书首先厘清了战争文学的定义，简要介绍了世界各国的战争文学传统及战争文学研究的当代意义，并探讨了与战争相关的哲学、政治和文化思想；接着，本书详述了“战争与媒体”“战争、创伤与身份认同”“战争、种族与民族”和“战争、科技与民族身份”四个热点专题，并以《追寻卡西艾托》和《巴格达的弗兰肯斯坦》两部小说为例示范相关主题下的战争文学研究；总结了国内战争文学研究的总体情况，并对未来研究趋势作了展望。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	498
1171	英语教材研究：内容、使用与出版	9787521329278	9787521329278	Nigel Harwood 	\N	1	小16开	99.90	\N	外语教学与研究出版社	\N	\N	\N	2021-09-01	/book/ed4d8d04-9184-492d-aa32-4f429ed693b69787521329278.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	226
1172	英语科技文献阅读	9787521312256	9787521312256	赵毓琴、常梅 	\N	1	16开	45.90	\N	外语教学与研究出版社	\N	\N	\N	2019-12-31	/book/23c2d416-3177-4fa5-a64b-93e9f1d71b389787521312256.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	942
1173	“一带一路”国家跨文化商务交际教程	9787521325096	9787521325096	秦丽莉、宋薇 	\N	1	16开	49.90	\N	外语教学与研究出版社	\N	\N	\N	2021-04-30	/book/16a4f2b7-a7d9-42de-9fb1-de83cd72972a9787521325096.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	654
1174	如何进行思辨性写作（中文版）	9787521323870	9787521323870	Richard Paul、Linda Elder 	\N	1	32开	13.90	\N	外语教学与研究出版社	\N	\N	\N	2021-11-01	/book/55227feb-cc54-4d4b-8595-08ac038df4119787521323870.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	159
1175	分布形态理论研究	9787521330908	9787521330908	刘馨茜 	\N	1	16开	69.90	\N	外语教学与研究出版社	\N	\N	\N	2021-11-15	/book/1b449af9-d6bf-427e-82ce-a7f44ca9136c9787521330908.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	395
1176	汉语语篇分析	9787521331363	9787521331363	张蕾、苗兴伟 	\N	1	16开	69.90	\N	外语教学与研究出版社	\N	\N	\N	2021-10-01	/book/68d504a6-7387-49c0-ac8e-6040c7aedbb79787521331363.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	495
1177	民航通识英语教程	9787521329483	9787521329483	褚天琦、李少忠、李吕华 	\N	1	16开	46.90	\N	外语教学与研究出版社	\N	\N	\N	2021-09-10	/book/13d91136-adbc-452b-abd4-c87445275df49787521329483.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	716
1178	中国文化英语教程	9787560099842(01)	9787560099842(01)	叶朗、朱良志 	\N	2	16开	49.90	\N	外语教学与研究出版社	\N	\N	\N	2010-09-29	/book/757e5bf7-db00-4297-a9ee-97aaa592d4bf9787560099842(01).jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	709
1179	师范英语	9787521327601	9787521327601	张翼 	\N	1	16开	45.90	\N	外语教学与研究出版社	\N	\N	\N	2021-10-31	/book/a7abac9b-ace1-40a9-abad-2e1065e5fe929787521327601.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	524
1180	语言迁移研究	9787521322552	9787521322552	蔡金亭 	\N	1	16开	78.90	\N	外语教学与研究出版社	\N	\N	\N	2021-08-25	/book/fc5265aa-64ba-4f2e-8ebd-7fa961d868469787521322552.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	753
1181	口译加工研究	9787521322828	9787521322828	董燕萍、陈小聪 	\N	1	16开	94.90	\N	外语教学与研究出版社	\N	\N	\N	2020-12-01	/book/ef684523-4e39-4d36-8541-8081be9220f19787521322828.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	203
1182	中国智慧教育区域发展研究报告（2021）	978-7-5760-2102-8	\N	教育部教育管理信息中心 《中国教育信息化》杂志社 腾讯智慧教育发展研究中心 编著 	平装	1-1	大32开	79.00	\N	华东师范大学出版社	\N	\N	\N	2021-10-01	/book/955c9a5c-f344-4d25-bece-58b17ac129401081174.jpg	本书包含智慧教育研究和发展的最新成果、专家观点综述，智慧教育评估的五维模型和评估指标等理论研究内容，以及全国智慧教育发展典型区域的调研数据分析、优秀案例，总结了智慧教育发展的主要特征，展望了未来的发展前景，整理归纳了智慧教育2020大事记。智慧教育是信息时代教育变革的划时代事件，是新时代变革的重要组成部分，是当代教育变革的主题。本书从全景视角观察我国智慧教育发展的进程，对智慧教育研究进展、区域实践、教育新业态全景把握，系统呈现了智慧教育概念内涵与研究热点的变迁，全局呈现了我国智慧教育实践发展的脉动。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	653
1183	长江保护与高质量发展研究报告.2020（下册）	9787563070879	9787563070879	长江保护与绿色发展研究院，江苏长江保护与高质量发展研究基地 	0	\N	0	158.00	\N	河海大学出版社	\N	\N	\N	2021-07-01	/book/936e21b8-16f1-4475-8500-67b49119683d1081184.jpg	本书以共抓大保护、不搞大开发为导向，以生态优先、绿色发展为引领，重点对2019-2020年长江经济带经济、社会、生态、法治、文化、政策、管理等发展情况及态势进行跟踪研究与全面梳理，分析长江经济带高质量发展过程中的问题，探讨长江经济带高质量发展的目标和路径，提出长江保护与高质量发展的对策建议。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	741
1184	计算机控制理论与应用	9787563069224	9787563069224	孙黎霞 	\N	\N	\N	59.00	\N	河海大学出版社	\N	\N	\N	2021-05-01	/book/782ceae8-b7c6-4019-b6d4-d210fb1f95849787563069224.jpg	《计算机控制理论与应用》系统地介绍离散时间系统的分析方法、设计、建模和仿真等内容，以工程应用为背景，侧重于计算机控制系统中一些实际问题的解决。本教材主要包括：计算机控制系统分析和设计，如何将连续时间系统采样为离散时间系统，给出相对应的模型，以及对应模型的基本性质和相应的数学分析工具；在此基础上，介绍离散时间系统的控制器的设计，着重介绍如何处理系统的扰动问题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	531
1185	李仪祉先生遗著（影印本）（十三卷本）	9787563065745	9787563065745	李仪祉、胡步川 	\N	\N	\N	2,990.00	\N	河海大学出版社	\N	\N	\N	2020-11-01	/book/63197217-1dff-4122-bd77-3c9570570b3a9787563065745.jpg	《李仪祉先生遗著》（石印本）（十三卷本）由胡步川先生在抗战时期搜集整理并编印成册，是至今保存最为完整的李仪祉先生著述。本套书包含当时黄河、江淮、西北、华北地区水利建设的详细资料，以及水利概论、水功学术等理论知识，是当代水利专业人员用以了解我国水利技术、工程发展历史的极具价值的资料；同时，遗著中还包括李先生的自传、日记、创作的诗歌等，有助于后人深入了解李先生，具有宝贵的史料价值。本套丛书内容丰富全面，具有很强的历史可信度和权威性，呈现了中国近现代水利发展历程，其出版填补了中国近现代水利史研究论著的空白。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	166
1186	医用高等数学（第2版）	9787565918551	9787565918551	李霞 彭继世 	\N	\N	16开	35.00	\N	北京大学医学出版社	\N	\N	\N	2018-11-01	/book/f04121af-f41a-41a5-8976-e3a4905ed0239787565918551.jpg	分为九章,主要包括:函数、极限与连续；导数与微分；不定积分；定积分；多元函数微积分；常微分方程基础；线性代数基础和概率论基础。本书在总结编者多年来的教学经验和教学成果的基础上,注重基础知识和医学实例的紧密结合,通过大量的具体医学问题,使学生能够将相对枯燥的数学理论融入到医学应用中。此外,本书在每章中还提供了知识扩展与知识链接,这不仅有助于扩大学生的数学知识面,同时也有利于提高其学习数学的兴趣。本书可作为高等医学院校中各专业的高等数学教材使用,也可供医学研究人员学习和参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	346
1187	计算机应用基础（第7版）	9787565918186	9787565918186	郭永青 	\N	\N	16开	45.00	\N	北京大学医学出版社	\N	\N	\N	2018-08-01	/book/47f20083-7319-49b0-b76b-fc7ca254064b9787565918186.jpg	本次教材编写是在2010年教育部高等学校教学指导委员会发布的《高等学校计算机基础教学发展战略研究报告暨计算机基础课程教学基本要求》的整体原则框架下进行的，在再版编写中增加了新的信息技术内容和信息技术在医学中应用的案例导引，力图引导学生以计算思维的思维方式去认识、分析问题，培养学生使用计算机，利用计算机技术来延伸自己处理信息的能力；编写同时也考虑了医药类学生的特点与实际情况，调整了部分章节，压缩了文本编辑等内容，增加了“医学信息学概论”一章，探索了计算机基础教学与医学信息学教学进一步的融合。本书共分为七章，第一章计算机与网络（郭永青、胡彬、李祥生编写），第二章计算机硬件系统（郭建光编写），第三章软件系统（王静编写），第四章常用应用软件（刘群、李祥生、杨俊丽、黄轶旻、王路漫编写），第五章多媒体技术应用（兰顺碧、王路漫、刘群编写），第六章数据管理（齐惠颖编写），第七章医学信息学概述（李祥生、朱彦慧编写）。在每一章节后面，我们都精心编写了习题和上机练习题，便于读者自测练习和上机操作练习。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	733
1260	中国音乐作品结构分析概论	9787810960397	9787810960397	李吉提 著 	\N	1-1	16开	58.00	\N	中央音乐学院出版社	\N	\N	\N	2004-10-01	/book/8cbbd5fc-ea27-4363-8831-152b4f146d159787810960397.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	803
1188	医用化学（第2版）	9787565918070	9787565918070	徐红 杜曦 	\N	\N	16开	45.00	\N	北京大学医学出版社	\N	\N	\N	2018-08-01	/book/bc0b2a0a-bfe5-4a35-952d-21354b279b099787565918070.jpg	本书在上一版的基础上增加了知识拓展、每章小结、习题详解等内容，针对医学生的需要对无机化学、有机化学、物理化学、分析化学等化学基础知识进行了系统而深入浅出的讲解，是医学生进入专业课程学习的必要条件。在本书的编写过程中，编者精选了医药学各专业学生必须掌握的化学基本理论、基本知识和基本技能，对部分内容进行了必要的取舍和整合；同时特别注意引入学科的前沿知识，注重化学与医药学各专业的结合，并强调化学在各专业中的应用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	889
1189	生物化学（第4版）	9787565917851	9787565917851	李刚 贺俊崎 	\N	\N	16开	85.00	\N	北京大学医学出版社	\N	\N	\N	2018-08-01	/book/9b55ada3-2b18-4774-8d25-8ff7d20a8a3b9787565917851.jpg	生物化学，是针对高等医学院校学生编写的生物化学教科书。本版的编委参考了国内外生物化学教科书的新进展，结合国内本领域教科书的特点，对章节安排及内容细节进行了很多修订，也对不少图片进行了修改和重绘，也与最新修订的执业医师资格考试大纲和研究生入学考试大纲的要求保持一致。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	310
1190	眼科学（第4版）	9787565919367	9787565919367	王宁利 杨柳 	\N	\N	16开	68.00	\N	北京大学医学出版社	\N	\N	\N	2020-05-01	/book/4bbca267-8038-46a0-8b28-cc5799e553f49787565919367.jpg	教材从整体框架、书写体例到具体细节都进行了大幅度的更新。努力做到详略分明，对个别诸多方面缺少明确性的病名，如“交感性眼炎”，根据国内外新进展，做了与时俱进的阐述。对各章的病例做了大幅度更新。对每章节后面的“进展与趋势”和Summany进行了缩减。对附录中的英语内容做了调整。适当增加了“视路疾病”“斜视”“眼眶病”等章节的内容。防盲治盲的内容增加了国家最新确定的工作目标，并与每位编委沟通，提醒注意知识产权问题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	685
1191	康复医学（第4版）	9787565919343	9787565919343	戴红 姜贵云 王宁华 	\N	\N	16开	45.00	\N	北京大学医学出版社	\N	\N	\N	2019-08-01	/book/f33e9bb4-7355-4b3c-b984-3d76aea5f1ee9787565919343.jpg	本书在第三版的基础上根据进展，较大幅度地充实了信息服务与技术在康复医学中的应用部分；增加了康复基础的踝关节运动学、治疗学基础；更新了康复服务的政策进展和残疾学内容、人体发育学；及肌力训练、易化技术、物理治疗其他新技术、作业治疗、中国传统康复疗法、康复心理学、康复工程学；增加了冲击波治疗和超声治疗、肩袖损伤的康复、巴金森病的康复、骨质疏松的康复、盆地功能的康复等部分。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	220
1192	大学生心理健康教育（第2版）	9787565920103	9787565920103	崔光成 张曼华 	\N	\N	16开	32.00	\N	北京大学医学出版社	\N	\N	\N	2019-08-01	/book/e682d154-8b6a-4e4b-aee1-8417e2801ceb9787565920103.jpg	本书是为高等医学院校本科各专业学生编写的大学生心理健康教育教材（第2版）。第2版根据广大师生对第1版使用后的意见和建议，结合我国大学生心理健康教育工作的新要求新变化，对第1版进行了调整、充实和完善，目的是使教材更加贴近教学需要、贴近大学生的实际、贴近大学生的学习生活。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	345
1193	医学史（第3版）	9787565919275	9787565919275	张大庆 	\N	\N	16开	39.00	\N	北京大学医学出版社	\N	\N	\N	2019-05-01	/book/461f3ac8-87c1-4c22-a8f0-f85eb02d9c7e9787565919275.jpg	本教材采用通史的体例，全景式地审视人类医学的发展历程，强调了医学模式的演化规律，在关注医学理论和医学技术发展的同时，也关注社会经济、文化传统、哲学思想、宗教信仰等对医学的影响，使学生更全面、深刻地了解医学发展的轨迹、理解医学的本质和价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	887
1194	医学遗传学（第4版）	9787565917806	9787565917806	傅松滨 	\N	\N	16开	35.00	\N	北京大学医学出版社	\N	\N	\N	2018-08-01	/book/60bf37c0-2f1d-4a24-b445-d5a9da51ae5d9787565917806.jpg	医学遗传学是目前医学中最前沿的学科，也是新兴学科。是生命科学主要研究的课题。医学遗传学主要利用DNA技术来研究疾病与基因的关系。本书为我社临床本科国家规划教材医学遗传学修订再版，由哈尔滨医科大学傅松滨教授的担任主编，本书详细介绍了医学遗传学的基础知识，并配有知识拓展等相关配套学习资源，方便学生掌握医学遗传学基础知识。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	171
1197	实验诊断学（第4版）	9787565919350	9787565919350	王建中 张曼 	\N	\N	16开	69.00	\N	北京大学医学出版社	\N	\N	\N	2019-08-01	/book/988b1e93-499b-4406-9206-fbe567a18c979787565919350.jpg	本书第4版是在3版的基础上作了全面、充实、深化的改革后编写而成的。全书内容包括：实验诊断的质量保证，临床一般检验与疾病，红细胞疾病的实验诊断，白细胞疾病的实验诊断，出血与血栓性疾病的实验诊断，血型鉴定与输血不良反映的实验诊断，脂质代谢紊乱的实验诊断，心脏疾病的实验诊断，肝、胆、胰疾病的实验诊断，肾脏疾病的实验诊断，抗菌药物敏感性试验和细菌耐药性检测，器官移植的实验诊断，治疗性药物浓度监测及其临床应用，POCT的实验检测和临床应用等。每章内容均包括“概述”、“疾病的常用实验检测”和“常见疾病的实验诊断”。本书适应医学科学的发展和培养高级临床医学人才的需要。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	736
1198	影像诊断学（第4版）	9787565918995	9787565918995	王滨 贺文 	\N	\N	16开	65.00	\N	北京大学医学出版社	\N	\N	\N	2019-01-01	/book/b51e81bb-5d71-4a4b-b08f-dde9162193189787565918995.jpg	本版教材在内容编排上进行了适当修改，力图反映新的教学内容和课程改革的成果。增加了核医学成像、对比剂、分子影像学的应用技术、方法及其适应证等内容；纳入了一些新病种，减少了一些应用价值不大的传统检查技术方法和相关诊断内容；根据临床应用实际情况有选择地增加了部分病例的影像学图像，并加入了知识拓展模块，使教材更符合医学影像学的新进展。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	413
1199	组织学与胚胎学（第5版）	9787565920844	9787565920844	唐军民 刘荣志 齐云飞 	\N	\N	16开	69.00	\N	北京大学医学出版社	\N	\N	\N	2020-08-01	/book/93313ccd-a827-45fa-9224-539cbdf07e5b9787565920844.jpg	组织学与胚胎学，在原有教学内容的基础上进行了认真的修改，使语言表达更加简练、逻辑性更强。是研究人体微细结构及其发生发展的科学，是基础医学的主干学科之一，也是学习生命科学的必修课程。分为组织学和胚胎学两部分，共29章。在上版基础上修订错误、补充进展、完善逻辑。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	694
1200	病理学与病理生理学（第2版）	9787565920882	9787565920882	魏昕 唐忠辉 宋印利 	\N	\N	16开	85.00	\N	北京大学医学出版社	\N	\N	\N	2019-10-01	/book/7c9fdf08-928a-44df-a276-1b1e2d3841d29787565920882.jpg	本教材内容包括总论和各论。总论主要阐述疾病的基本病理过程，探讨不同疾病发展过程中的普遍规律，如疾病概论、炎症、肿瘤、水和电解质代谢紊乱、酸碱平衡紊乱、休克等。各论主要阐述各器官系统不同疾病发展过程中的特殊规律，即探讨各器官系统常见疾病的病因、发病机制、形态结构、功能及代谢的改变等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	781
1201	眼耳鼻喉口腔科学（第3版）	9787565920929	9787565920929	戴馨 	\N	\N	16开	60.00	\N	北京大学医学出版社	\N	\N	\N	2020-10-01	/book/456d5ed2-7cb7-47be-9cda-c01ebb198b479787565920929.jpg	本书为全国卫生高等职业教育校院合作“双元”规划教材，以菏泽医学专科学校、江西医学高等专科学校等来自全国的高职高专院校为主要编写团队，系统讲述专科层次眼耳鼻喉口腔科学的基础理论知识，配套数字资源内容，可为临床医学专业、妇幼、口腔及医学影像学专业读者学习提供辅助。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	543
1202	皮肤性病学（第5版）	9787565920769	9787565920769	刘洪波 	\N	\N	16开	46.00	\N	北京大学医学出版社	\N	\N	\N	2020-11-01	/book/8ab20d50-7a49-43c2-a967-8a1d5fb055ee9787565920769.jpg	皮肤性病学是临床医学重要的二级学科，是一门以形态学教学为主的临床学科。本书主要介绍了皮肤基础理论、皮肤病的诊断与治疗及皮肤病各论；图文并茂，使学生对皮肤病的认知更加直观；并在文中介绍了近年来诊断或治疗皮肤病的新理论、新方法。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	997
1203	中医学（第4版）	9787565920943	9787565920943	郭宝云 肖跃红 	\N	\N	16开	42.00	\N	北京大学医学出版社	\N	\N	\N	2019-10-01	/book/517a4a43-2b80-42bb-9733-9a3f8e20476d9787565920943.jpg	中医学是研究人体生理病理、疾病诊断与防治及康复的一门学科，至今已有数千年的历史。本书按照卫生高等职业教育要求，从中医基础理论、中医诊断学、中药学、方剂学、针灸学和中医临床各科等方面系统介绍中医学的基本理论和治疗方法。总结了中医学体系的形成和发展，并加入近年来中医学研究热点问题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	981
1204	生物化学	9787565921582	9787565921582	郏弋萍 刘建强 付达华 	\N	\N	16开	38.00	\N	北京大学医学出版社	\N	\N	\N	2020-08-01	/book/14443d43-4b95-4297-af5d-7f247a5d52899787565921582.jpg	本课程有全局观同时，激发学生好奇心，期待继续探索；第二章至第十一章介绍生物化学基本理论，给学生打下坚实基础；第十二章至第十四章介绍临床生物化学相关内容，为将来与临床课程学习和工作无缝链接，架起一座桥梁。每章内容编写分为五大模块：第一模块是思维导图，利用大脑对图像记忆，开发地图式记忆；第二模块是学习目标，让教师和学生有目的地学；第三模块是具体教学内容，力求提供科学、准确知识内容；第四模块是在教学内容中穿插“知识链接”、“案例” ，增加教学内容理解的链接点，而少量课后思考题，帮助学生及时检测学习效果；第五模块是二维码内容，有音频，图片，文字，表格等多样化呈现形式，拓展知识，延伸课题，有助于学生自主学习。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	250
1299	中国农业通史(全四册)	978-7-5683-0242-5	\N	樊志民、卫丽 	0	1-1	16开	396.00	\N	西北农林科技大学出版社	\N	\N	\N	2017-08-01	/book/4bc2ed44-7cd2-4e77-bbd3-1811c0fcb8201081829.jpg	《中国农业通史·厚重的农耕文明》，中国农业起源之始即呈现出“多源起源，多元交汇”的特点。此后的发展进程中，在黄河流域厚重的黄土地带以黄帝为代表的华夏先民辛勤耕耘，率先迈入了文明的门槛，确立了黄河流域在中国历史早期的领先地位。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	780
1205	护理学基础	9787565921094	9787565921094	杨潇二 唐布敏 	\N	\N	16开	75.00	\N	北京大学医学出版社	\N	\N	\N	2019-12-01	/book/93e56062-2132-47be-bc7a-f6c0b0822f299787565921094.jpg	本书是“十三五”全国卫生高等职业教育校院合作“双元”规划教材，全书共二十二章。内容的选取依据护理岗位需要，包括护士素质与护患角色、护理相关理论与护理、护理程序、护理安全、疼痛与舒适、医院与住院环境、入院和出院的护理、患者卧位护理、休息与活动、医院内感染的预防与控制、清洁护理、生命体征的评估和护理、饮食护理、排泄护理、药物疗法、静脉输液与输血、冷疗法与热疗法、标本采集，适用于高职高专护理专业学生学习使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	511
1206	护理学导论	9787565921551	9787565921551	李丽娟 马国平 	\N	\N	16开	36.00	\N	北京大学医学出版社	\N	\N	\N	2020-07-01	/book/b2de5604-6d25-4970-8783-22f74280a2219787565921551.jpg	该教材主要涉及护理学导论相关内容，一是充分运用信息化技术在教材嵌入了音频和视频内容，并与纸质教材相辅相成，使学生学习更加立体化；二是用案例引导教学，理论联系实际，引导学生思考，激发学生的学习兴趣，丰富教学内容；三是插入了图表、图片，图文并茂，使护理学的一些典型特征清晰直观，使教学生动灵活、形象易懂；四是在正文中还加入了相关内容的知识链接，以开阔学生视野、扩大知识面、增强学生对本门课程的学习兴趣；五是在每一节后均附课后练习及思考题，便于学生思考及复习，提高教学效果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	502
1207	内科护理学	9787565919947	9787565919947	汪芝碧 钟云龙 	\N	\N	16开	79.00	\N	北京大学医学出版社	\N	\N	\N	2019-08-01	/book/0ab1e2c6-a447-4749-a159-5a333b92c0db9787565919947.jpg	内科护理坚持以人为本的护理理念。着重培养学生发现问题、解决问题的能力，培养高素质技术技能型护理人才。突出护理专业特色。以护理程序为主线，体现“整体护理”和 以“人”为中心的护理理念，突出护理技能、理论与实践相结合，突出常见病的典型特点和护理要点，着眼于实用性。坚持三个贴近。贴近师生、贴近临床、贴近护士执业资格考试。遵循教材编写的“三基”“五性”“三特定”原则。强调创新、避免重复。强调全书结构规范统一、内容科学严谨。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	890
1208	外科护理学	9787565920547	9787565920547	张德 张萍 祝水英 	\N	\N	16开	85.00	\N	北京大学医学出版社	\N	\N	\N	2019-12-01	/book/9712975e-7e89-43d9-8ce2-14446bc06b639787565920547.jpg	本书是“十三五”全国卫生高等职业教育校院合作“双元”规划教材。系统讲述外科护理学相关知识，在每章都设计了思维导图和学习目标。为了密切联系相邻课程和联系临床，在文中适时地插入“知识链接”或“知识拓展”，供全国高职高专院校三年制专科和五年制高职专科护理专业使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	529
1209	社区护理学	9787565920424	9787565920424	乌建平 何凤英 代爱英 	\N	\N	16开	29.00	\N	北京大学医学出版社	\N	\N	\N	2020-04-01	/book/f4ebc6ff-1bf8-4622-9272-4a811cba32d99787565920424.jpg	本教材共分九章，包括教学理论和实训两部分内容。教学理论中的“学习目标”是针对国家执业护士资格考试大纲要求列出的护理专业学生必须掌握的知识点。“案例导入”以生活或临床实例为引导，可促使学生带着问题学习，在学习中寻找答案。“知识链接”注重科学性、启发性、趣味性和新颖性，用于扩展学生知识面。“测试题”用于学生检验自己的学习效果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	167
1210	护理管理学	9787565921087	9787565921087	陈秋云 吴文君 	\N	\N	16开	42.00	\N	北京大学医学出版社	\N	\N	\N	2020-08-01	/book/dc79be12-a0fc-41f8-b0c8-fc3e7d8a23519787565921087.jpg	护理管理学是现代护理学的重要组成部分，是护理学与管理学融合形成的交叉学科，也是高等职业教育教学的重要课程。本教材以管理学基本理论开篇，逐渐过渡至护理管理学及护理管理实践应用，深入浅出，同时教材中加入管理格言、知识链接、案例分析和实践活动等模块，便于学生理解和学习。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	126
1211	急危重症护理学（第2版）	9787565915222	9787565915222	李文涛 张海燕 	0	\N	16开	39.00	\N	北京大学医学出版社	\N	\N	\N	2017-06-01	/book/42674f65-ea61-40a5-a072-999ebbf8bf591081303.jpg	急危重症护理学是护理学的重要组成部分，是一门综合性的护理学科。对于急危重症病人能够进行快速而准确的护理评估与及时有效的抢救，直接关系到病人的生命安全与预后，需要护士能够熟练掌握急危重症护理的知识与技能。根据急危重症护理学的特点，本教材参考国内外最新的理论与技术进展，结合各位编者丰富的临床实践与教学经验，力求展示最先进、科学与实用的急危重症护理内容。全书分三个单元，共二十七章。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	639
1212	全球健康教程	9787565923753	9787565923753	刘培龙 	0	\N	16开	28.00	\N	北京大学医学出版社	\N	\N	\N	2021-04-01	/book/e45dbf92-ab4e-41c9-aba7-9706043475011081322.jpg	本教材适合预防医学专业长学制本科生和研究生。第一章介绍了全球卫生的起源和发展、基本概念和理论基础；第二章至 第六章按照全球健康的问题—问题的决定因素—目标与应对问题的策略—健康促进干预 的设计—与卫生体系的衔接的顺序依次展开，可以让读者清晰地了解分析全球健康问题的主体思路和主要内容；第七章至第十章针对全球卫生治理以及关键要素的阐释，包括对国际卫生 立法、参与全球卫生治理行为体、和全球健康领域的主要伦理问题以及处理的原则和框架的论 述；最后，第十一章介绍了中国在全球卫生中的作用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	882
1213	营养与食品卫生学教程	9787565921360	9787565921360	马冠生 	0	\N	16开	35.00	\N	北京大学医学出版社	\N	\N	\N	2020-08-01	/book/2a317d60-2558-4867-9208-be9eff91e6691081324.jpg	本教材基于营养学和食品卫生两大部分，营养篇包括了基础营养、公共营养、人群营养、临床营养、食物营养以及营养学常用的研究方法，食品卫生部分包括了，食源性疾病、食品污染、食品添加剂以及食品安全风险评估和食品安全的法律法规。本教材符合预防医学长学制学生和研究生的培养目标和要求，密切联系国内外营养与食品卫生领域的最新研究以及 我国营养与食品卫生事业发展的实践。适合预防医学长学制教学改革和研究生的教学需要。本教材教学框架合理、逻辑性强、图文并茂、具备专业名词、基本概念的英文解释，各章具备课前导读和拓展延伸，有利于培养学生的租住学习和思考能力，配备部分电子学习资源，拓展学生视野，培养学生兴趣。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	803
1422	美术考级教程（全五册）	978-7-307-15287-8	\N	熊风、徐健 主编 	平装	1-1	16开	96.00	\N	武汉大学出版社	\N	\N	\N	2021-11-01	/book/f33fab41-af34-4455-987d-945ce37fd2241083409.jpg	本书为美术考级教程，包括5个分册，分别是书法考级教程、国画考级教程、素描与速写考级教程、色彩与水粉考级教程、儿童画和漫画考级。教材案例丰富，值得相关专业人士和有兴趣的朋友阅读，具有一定的通俗性和指导性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	970
1309	藏在课本里的传统文化	9787563967643	\N	刘泳美，孔祥琛 著 	平装	1-1	16开	36.00	\N	北京工业大学出版社	\N	\N	\N	2019-11-01	/book/54fdd9c2-e2f4-4541-b9b7-cfc9c8ef043b1081891.jpg	传统文化是指传统社会形成的文化，它既是历史发展的内在动力，也是文化进步的智慧源泉。中华传统文化具有独特的审美意识和人文精神，在文学艺术上创造了辉煌的成就；因此，中华传统文化是优秀的文化。本书中四位名师将带领中学生们开启了一场有趣的探索发现之旅，将藏在课本里的丰富的传统文化知识娓娓道来。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	301
1214	儿童口腔医学（第3版）	9787565922435	9787565922435	秦满 夏斌 	0	\N	16开	89.00	\N	北京大学医学出版社	\N	\N	\N	2020-09-01	/book/cdf05625-6c39-477f-9621-5d8da3b14f7c1081338.jpg	本书由北京大学口腔医院儿童口腔科主任秦满教授主编。内容包含儿童的龋病、牙髓病、根尖周病、牙外伤、牙周组织疾病及常见黏膜病等临床常见疾病的诊断及处理原则；注重体现基础理论、基本知识和基本技能，结合国情，强调实用性。第三版中充入的新知识、新技术、新进展，在体现科学性、先进性及启发性方面有所增强。书中对于演示图片进行了精细绘制，图文并茂，并搭配有实习操作指导，便于学生模拟临床实践；以及丰富的临床案例二维码资源，立体化多维度展示儿童口腔医学教学内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	781
1287	淳六味道地药材栽培实用新技术	978-7-5683-0770-3	\N	郑平汉 	平装	1-1	大32开	25.00	\N	西北农林科技大学出版社	\N	\N	\N	2019-11-01	/book/6ad0d567-0911-42c7-8beb-bab2ec00e8e71081769.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	511
1215	临床龋病学（第3版）	9787565923821	9787565923821	岳林 董艳梅 	0	\N	16开	39.00	\N	北京大学医学出版社	\N	\N	\N	2021-08-01	/book/3d70c260-59e7-41af-b7bb-30a6eb8d97ab1081345.jpg	本书是为适应北京大学口腔医学院的“龋病融合课”而编写的教材。全书共分12章，从牙的发育与组织结构、牙的口腔生态环境、龋病病因学理论、龋病微生物学和发病机制、龋病病理学、龋病的临床表现与诊断、龋病的临床处理策略、儿童和青少年龋病、龋病的预防、氟化物防龋等方面进行系统论述。在第2版的基础上，尽可能统一各学科对同一内容的观点、概念和名词术语；补充了近年来文献中较新且得到专家共识的内容；增加了纳入二维码扫描内容的病例解析、扩展阅读等新的立体代教材形式，以利读者更易于理论联系临床实际，了解学科研究进展。适合口腔医学长学制学生使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	117
1244	ASIA	9787564181253	\N	联合国教育科学及文化组织著 	\N	1-1	16开	390.00	\N	东南大学出版社	\N	\N	\N	2019-10-01	/book/0a3182f6-e518-4b2b-94e9-f668904e3fe39787564181253.jpg	本书收录了联合国教科文组织2010—2018年的文化遗产保护的亚太奖作品，以图文并茂的形式，介绍了各保护建筑的历史背景、保护原则、采取的保护措施及建成效果等，这些先进的文化遗产保护成果可以为各国的文化遗产保护提供指导和参考借鉴。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	578
1216	中国近代社会文化史研究	978-7-303-27290-7	\N	王先明 	平装	1-1	小16开	88.00	\N	北京师范大学出版社	\N	\N	\N	2021-12-01	/book/8e9049bd-65da-4fba-9cff-ab85d88d36ba1081354.jpg	　　新时期史学研究取得了丰硕的成果，但是也不无值得反思的问题。作者注意到，社会史、文化史研究日渐聚焦于日常生活和个人体验，却刻意回避对重大历史事件和社会运动的关注；日渐深入解析群体生活的样态风情，而无视精英或社会运动领袖的行为与选择。那么，一旦失去对重大历史事变和社会运动发展的关注和解释能力，它还是社会的历史么？ 　　本书是作者近年社会文化史研究的集结，聚焦社会史研究的方法与未来，政策得失与观念演进，阶层变迁与社会记忆，制度变革与空间改造，推陈出新，史料丰硕，说理透彻，为我们理解近代中国社会提供了敏锐的视角。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	578
1217	金斯伯格访谈录	9787521328875	\N	(美)杰弗里·罗森 著 李磊 译 	平装	1-1	大32开	59.00	\N	外语教学与研究出版社	\N	\N	\N	2021-09-01	/book/e1552f99-510a-44cc-8b33-f156d7b7db0d1081363.jpg	本书记录了杰弗里·罗森与金斯伯格两位老友持续近二十年的对话，金斯伯格在此毫无保留地分享了一位大法官眼中的时代议题：法律应该为少数群体做些什么，两性平等在司法案件中推进了多远，优选法院如何应对党派政治的趋势等等，也谈论友情、生活与爱。对话既呈现出金斯伯格在具体案件中追求平等、正义的深思熟虑，也还原了法袍之下的这位女性，她时而严肃时而风趣，真诚而意志坚定，对生活充满热情。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	899
1218	爆炸技术及应用	9787568286725	9787568286725	黄广炎 冯顺山 刘瀚 王涛 编著 	\N	1-1	16开	68.00	\N	北京理工大学出版社	\N	\N	\N	2021-03-30	/book/43f9b66f-d1b8-4643-8b25-6d321fdef4379787568286725.jpg	本书从炸药爆炸基本理论出发，系统阐述了爆炸技术在航空航天、爆炸加工、爆破拆除、等爆炸控制方面，以及冲击波破片、聚能效应、云雾爆轰等爆炸毁伤领域的应用。针对爆炸危害，讲解了爆炸反恐与安全处置等应用技术。全书共9章。第1章概论部分，主要对爆炸技术的作用、发展历史和应用范围做了分析和综述，第2章炸药爆炸基本理论和第3章爆破器材与起爆方法部分，介绍了炸药爆炸基本原理、炸药起爆理论及技术，对爆轰现象及相关理论、工业爆破所涉及的各种爆破器材以及常用起爆方法进行了较为系统全面的讲述，第4~8章为工程应用部分，介绍了爆炸技术在国民经济各方面的应用，主要讲解了爆炸技术在航天器石油开采、加工中的应用、控制拆除、岩石爆破、水下爆破几大方面的应用，内容既包含传统工程爆破、能源勘探等应用领域，还包括新兴航空航天、爆炸加工等技术应用，涉及抗旱救灾、海上求生等突发救援应用领域。第9章从爆破安全技术角度出发，主要介绍爆破作业过程中安全与防护措施。 本书可作为高等院校弹药工程与爆炸技术、工程力学、安全工程、武器发射工程、特种能源工程与烟火技术等兵器学科专业的本科生及研究生教材；同时也可供相关专业的科研与工程实践领域工作者们参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	698
1219	材料非线性弹性波	9787568291491	9787568291491	（乌克兰）耶利米·J. 卢士奇斯基 著 	\N	1-1	16开	110.00	\N	北京理工大学出版社	\N	\N	\N	2021-01-15	/book/ac015d52-60da-4d24-9ff7-8e5385e7d8ed9787568291491.jpg	本书包括材料和波的概述，非线性弹性理论和弹性材料论述，一维非线性纵波、垂直和水平偏振横横波的分析，一维非线性弹性柱面及扭转波分析，二维非线性弹性瑞利及勒夫表面波分析等五部分，分11章对非线性弹性波现象、波动和材料基本概念、弹性材料概念及理论以及线弹性组合体模型、Murnaghan模型、John和Signorini模型、慢变幅值分析方法等在弹性材料、亚弹性材料和弹性混合介质材料中的非线性弹性波理论建模和分析等内容进行了介绍。 本书内容丰富、前瞻性强，讲解由浅入深，通俗易懂，适合作为机械、力学、检测等专业研究生和工程科研人员的理论参考读物。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	519
1238	房产全寿命周期管理与BIM技术应用	9787564182021	\N	李明勇等编著 	\N	1-1	16开	78.00	\N	东南大学出版社	\N	\N	\N	2019-08-01	/book/8154445c-c479-40eb-b696-f56aba93f5b29787564182021.jpg	本书面向非生产性房产全寿命周期管控全过程，研究探索新形势下非生产性房产管控的定位、目标、业务范围和基本模式，设计面向大数据管理的非生产性房产全寿命周期管控模式，将进一步提升国网公司非生产性房产全寿命期管理水平与绩效，推动非生产性房产的建设规范化、管理标准化、信息集成化和过程可视化，最终实现非生产性房产管控的安全、效能和成本最优的总体目标。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	552
1220	数据挖掘技术与应用	9787568292573	9787568292573	由育阳 编著 	\N	1-1	16开	68.00	\N	北京理工大学出版社	\N	\N	\N	2021-06-25	/book/1801ea65-7aad-4b9c-a6c6-f87b0959f6939787568292573.jpg	本书在数据挖掘领域介绍的内容全面，讲解细致，保留了相当的篇幅讲述数据挖掘各方面的基本概念和方法，如数据挖掘的概述、数据描述和处理、基本统计分析方法、常用的统计学习算法和深度学习算法。本书还介绍了数据挖掘技术应用实例，如数据挖掘技术在睡眠分期中的应用。因此既适合初学者学习又适合专业人员参考。除了包含国内外教材中的内容和特点外，还包括了应用实例的介绍，其内容具有合理性、丰富性和先进性的特点。尤其在数据挖掘应用实例方面，针对具体问题提出解决方案，并附有关键代码，对理解数据、进行数据分析、理解算法实现等非常有帮助。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	925
1221	奇趣机器人	9787568293044	9787568293044	黄岚 编著 	\N	1-1	32开	39.80	\N	北京理工大学出版社	\N	\N	\N	2021-04-08	/book/f5d7391c-6ea7-48a2-91cc-7085b77fe7f19787568293044.jpg	《奇趣机器人》是《中国青少年科幻分级读本（小学卷）》系列丛书中的一册，《中国青少年科幻分级读本（小学卷）》是一套面向小学生的科幻文学读本，这套丛书共五册，每个分册一个主题，本书是有关人工智能主题的。书中的科幻小说探讨了人工智能的未来以及在未来可能要面临的问题，既为读者打开了了解未来世界的大门，也能引起读者对未来的思索。每一篇小说都搭配了文前的导读和科学知识讲解、文后的思维导图和拓展阅读，让小读者能更深刻地理解小说中的内容。很有阅读价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	541
1222	另一个地球	9787568293051	9787568293051	姚利芬 编著 	\N	1-1	32开	39.80	\N	北京理工大学出版社	\N	\N	\N	2021-04-08	/book/cce77e76-8463-4127-b595-158089b97edd9787568293051.jpg	《中国青少年科幻分级读本（小学卷）——另一个地球》是一本面向小学阶段孩子的科幻文学读本，是《中国青少年科幻分级读本（小学卷）》分册之一。编写者精心挑选适合小学高年级段孩子阅读的国内名家科幻作品，搭配文前导读、科学知识讲解、文后思维导图和拓展阅读，给孩子献上了一场缤彩纷呈的阅读盛宴。 具体内容选择上，该册图书所选编的作品围绕地球科学幻想展开。地心世界真的存在着另一种地球文明吗？亚特兰蒂斯人是不是并未灭绝，而是进化成了与我们截然不同的生命体，拥有神奇的技术？地铁、沙漠、考古遗址……这些地方隐藏着什么样的秘密？ 陈楸帆、胡绍晏、赵海虹、超侠等科幻名家，带你进行一场特别的“地球冒险”。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	731
1255	高等音乐（师范）院校钢琴公共课分级教程	9787810965064	9787810965064	李昕 主编 孙晓丹 副主编 	\N	1-1	16开	78.00	\N	中央音乐学院出版社	\N	\N	\N	2013-05-01	/book/13f19886-1fca-4a9c-8979-dc0ae710fcc99787810965064.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	483
1256	全国高等师范院校系列教材	9787810965309	9787810965309	主编 隆强 分册主编 李劲松 分册副主编 赵勇 郑毅峰 	\N	1-1	16开	65.00	\N	中央音乐学院出版社	\N	\N	\N	2013-06-01	/book/fb0e14ea-0a77-4252-b617-42ab8292ce479787810965309.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	834
1223	城市轨道交通路网客流协同管控理论与应用	9787568293358	9787568293358	豆飞 贾利民 徐会杰 魏运 著 	\N	1-1	16开	56.00	\N	北京理工大学出版社	\N	\N	\N	2021-01-29	/book/14afd3d0-76c8-4d55-90eb-3e6b008c35b69787568293358.jpg	城市轨道交通路网规模的扩大引发客流需求不断增长，客流需求与运输能力的矛盾逐步凸显，尤其在早晚高峰时段，客流方向性明显，部分区段长期高负荷运营。如何实现高效、安全的运营管理成为城市轨道交通运营部门关注的焦点。本书在城市轨道交通路网运营管理领域首次将客流、管控及其相互作用作为一个完整的动态系统，并以实现主动式运营管理为目的，从城市轨道交通路网运营特点和管控需求出发，在总结分析典型城市轨道交通常态客流管控模式的基础上，研究了城市轨道交通大客流特点、分类、成因和传播机理，并据此形成了包括车站级客流管控理论体系、网络级客流主动管控方法体系、路网客流管控方案评估体系等在内的以客流管控为主要措施的城市轨道交通路网运营管理解决方案。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	682
1224	火星大揭秘	9787568294218	9787568294218	焦维新 著 	\N	1-1	16开	78.00	\N	北京理工大学出版社	\N	\N	\N	2021-03-19	/book/99cb75cb-fc59-45e3-9c78-8127bc42f0039787568294218.jpg	本书主要介绍火星探测，以及人类为什么特别关注火星探测，探测火星需要攻破哪些技术难关，人类探测火星已经取得的成果等，并且对青少年关心的人类登陆火星的问题，讲解了登陆火星面临的技术困难，以及怎样实现取样返回探测等内容。本书充分展示了火星风貌，满足青少年们了解航天新知识及其发展前景的渴求，激发青少年们对航天事业的兴趣，培养青少年的科学探索精神，激励青少年们努力学习科学文化知识、积极投身航天科学研究，助于拓宽青少年宇宙探索的视角。 本书采用增强现实技术（AR）与科普创作相结合，增强阅读体验。在传统科普出版物上，附加AR等技术手段，让静态的图文“活”起来，通过多通道感官刺激促进读者成长，从多方面调动青少年的感知，达到“视听说触想”完美统一，增加阅读的趣味性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	162
1225	黑客攻击与防范技术	9787568294515	9787568294515	宋超 主编 	\N	1-1	16开	62.00	\N	北京理工大学出版社	\N	\N	\N	2021-01-19	/book/c05fb203-fe02-41b8-875d-89a9af51d2729787568294515.jpg	本教材以黑客入侵实践为主线，体系结构围绕黑客入侵的各个环节展开，即网络扫描、抓包分析、脚本书写、服务与网站漏洞利等，最后两章分别介绍了系统加固的方法以及历年网络安全大赛部分的赛题。本教材编写的目的是提高学生对网络空间安全中理论知识的理解，掌握基本的网络渗透工具的使用，领会网络攻击中常用的方法和手段。本教材的学习需要计算机网络基础、服务器配置、python语言等课程作为前导课程，本教材的学习也为学生今后深入学习网络攻防知识以及成为一名合格的网络渗透、网络运维工程师做准备。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	415
1226	电梯电气原理与控制技术	9787568294966	9787568294966	崔富义 戴亮丰 主编 	\N	1-1	16开	78.00	\N	北京理工大学出版社	\N	\N	\N	2021-09-08	/book/015e2d9b-b8a6-4ade-9cff-65ad34cd88449787568294966.jpg	本书将专业家基础知识与实际的项目工程应用融为一体，围绕实际项目工程构建课程体系，组织实施教学，重在培养学生分析问题和解决问题的工作能力。通过对电梯电气控制基本知识和操作技能的学习，使学生熟知电梯电气部件的电气参数，能按照原理图完成电梯控制柜的安装与接线任务，会分析典型控制回路的工作原理与工作流程，识读和设计电梯电气控制原理图，了解电梯电气原理及控制技术，掌握各控制模块的作用，掌握各控制模块故障引起的电梯故障表现及常见风险分析，能根据电气原理图进行电梯电气调试与故障排除。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	983
1227	基于云架构的智能测试系统关键技术及应用	9787568296175	9787568296175	邓士杰 丁超 唐力伟 张英波 苏续军 汪伟 著 	\N	1-1	16开	56.00	\N	北京理工大学出版社	\N	\N	\N	2021-03-25	/book/97721cdc-0621-4c8e-b783-5a0c1d69574e9787568296175.jpg	本书针对现有技术架构下的自动测试系统存在着测试效率和测试资源利用率偏低，测试成本偏高，导致已无法高效适应大规模并行测试应用场景的问题，借鉴云计算的理念，将电子数据表格技术、虚拟化技术以及最优化理论引入到自动测试系统领域，并对涉及的关键核心问题进行了论述。 本书主要介绍了自动测试系统发展历程、涉及关键技术及未来发展趋势，云架构下智能自动测试系统的硬件模型、软件模型和运行机制，智能传感器技术、硬件测试资源虚拟化技术，不同测试任务下测试资源动态调度理论、原理样机设计与验证等内容。 本书可以作为从事自动测试设备设计与开发工作相关的研发或设计工程师等相关人员的参考用书，也可以作为相关机械工程、仪器仪表等与自动测试技术相关专业的本科生、研究生教材	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	138
1228	安全心理学	9787568296236	9787568296236	杨鑫刚 编著 	\N	1-1	16开	36.00	\N	北京理工大学出版社	\N	\N	\N	2021-03-25	/book/aa59c0a4-43da-474e-8bd7-d118081a58c89787568296236.jpg	《安全心理学》内容丰富、概念清晰、实用性强，是学习安全心理学的一本好教材。它不但可作为安全工程专业的本科教材，也可作为非安全工程专业的自学参考教材。 《安全心理学》主要包含七章内容：安全心理学概论、人的心理过程与安全、个性心理与安全、激励与安全生产、生产环境因素与安全、工作分析与人机分配、心理救援，每一章节都给出了复习思考题。其中包含了安全心理的内部因素（第二、三章），外部因素（第五、六章），实际生产应用举例（第四、七章）。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	531
1229	微流控芯片技术与建模分析	9787568296243	9787568296243	徐远清 耿利娜 编著 	\N	1-1	16开	76.00	\N	北京理工大学出版社	\N	\N	\N	2021-03-30	/book/75859d10-108c-4b1a-89fd-970b65382ed19787568296243.jpg	本书基于作者近几年在北京理工大学的工科研究生教学经验，并结合工科的实际需求而编写。全书分为5章。第1章，简要介绍微流控芯片技术的应用前景和常见的建模方法。第2章，主要介绍微流控芯片的制作材料、制作工艺、功能单元等知识。第3章，主要介绍微流控芯片技术的应用。第4章，介绍如何采用有限元方法建立微流控芯片设计模型，重点介绍偏微分方程、有限差分思想、有限元法原理等基本的知识，并结合COMSOL Multiphysics软件对微流控芯片中的流动、通道设计、微混合、样品操控、液滴操控、微泵等常见微流控芯片功能单元进行建模示范。第5章，针对现有软件在模拟微流控芯片中颗粒操控能力的不足，主要介绍浸入边界-格子Boltzmann方法的基本原理和在细胞分离中的应用，并采用MATLAB进行程序实现。 本书可作为化工、生物、医学工科的研究生教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	407
1257	法国视唱第一册第一分册（1A）	9787810966740	9787810966740	[法]亨利·雷蒙恩 古斯塔夫·卡卢利 编著 张涓 校订 	\N	1-1	16开	38.00	\N	中央音乐学院出版社	\N	\N	\N	2016-06-01	/book/e828fe9a-ecbc-427e-8a0e-2969aa6706a99787810966740.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	891
1230	傅里叶光学原理与系统设计	9787568296380	9787568296380	李林 谢敬辉 廖宁放 成一诺 著 	\N	1-1	16开	108.00	\N	北京理工大学出版社	\N	\N	\N	2021-04-15	/book/2f4f60f9-bf68-4d79-9815-dcb7ab5951439787568296380.jpg	本书系统而深入地介绍了傅里叶光学及其光学系统设计的基本概念、基础理论，以及在一些研究领域的应用。全书内容共分七章，其中第1章和第2章内容介绍了从波动光学过渡到傅里叶变换光学的主要基础理论，第3章到第6章分别介绍了光学传递函数、全息术、光学信息存储、傅里叶光谱技术的系统知识，第7章则介绍了傅里叶变换镜头及光学信息处理系统的设计知识。本书可作为高等院校光电类本科生及研究生教材，也可作为相关研究领域科技人员的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	826
1231	基于ABAQUS的有限元子程序开发及应用	9787568296557	9787568296557	王涛 黄广炎 柳占立 庄茁 编著 	\N	1-1	16开	96.00	\N	北京理工大学出版社	\N	\N	\N	2021-07-20	/book/d16dd42f-6481-4527-af81-da4c5274b4729787568296557.jpg	本书系统介绍了基于ABAQUS的有限元用户子程序开发和应用，可为有需要的科研人员和工程技术人员提供快速掌握较复杂有限元程序开发和仿真分析的实用工具和资料。全书分为两部分，分别是基于 ABAQUS的用户子程序基础、有限元子程序开发进阶。第一部分（第1~8章）介绍了有限元子程序开发的基本过程、Fortran的基本语法和常用到的用户子程序的接口及应用案例；第二部分（第9~14章）介绍了较为复杂的大型有限元子程序开发的方法和子程序开发中的一些高级功能，并且涵盖有目前计算断裂力学、多孔介质材料、冲击动力学的学术研究前沿。此外，书中提供了大量有限元算例、模型和子程序代码的源文件，可供读者学习和进一步开发、改进。 本书适用于有限元计算软件的中高级用户和科研工作者，以及相关专业的高年级本科生、研究生。 读者对象：本书适用于有限元计算软件的中高级用户和科研工作者，以及相关专业的高年级本科生、研究生。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	367
1232	一维纳米结构材料制备及其多样化应用	9787568296687	9787568296687	陈南 著 	\N	1-1	16开	76.00	\N	北京理工大学出版社	\N	\N	\N	2021-04-25	/book/9de2cc51-28dd-48ef-9aaa-7bdeb4838cff9787568296687.jpg	本书结合作者多年从事一维纳米结构材料制备与性能研究的实际经验，系统地介绍了一维纳米材料概念及其在光、电、声、磁、热和其他多方面应用研究。具体包括一维均匀掺杂和非均匀掺杂的纳米材料、一维突变异质结纳米材料、一维体异质结纳米材料等多种新型的一维纳米结构功能材料。 本书内容新颖、叙述深入浅出，介绍了大量新型一维纳米材料制备方法，以期从多方面启发读者了解整个一维纳米材料的设计与制备的方法，为研究者从原子/分子的层次设计新材料和新结构提供一些思路。可供从事化学、物理学、材料科学、环境科学等领域以及有关纳米材料研究和教学人员参考，也可作为大学生和研究生的教科书或参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	758
1239	理想城镇港口区域可持续发展研究	9787564183448	\N	王宇著 	\N	1-1	16开	68.00	\N	东南大学出版社	\N	\N	\N	2019-12-01	/book/7efda250-d6d2-4be9-80de-5739af02cdb19787564183448.jpg	我国长江下游地区经济发达，城市密集，港口区域空间形态各异，港城关系复杂，其港口区域的研究具有重要的学术价值。本文特选其中几个有特色的城市港口区域作为主要的研究和分析对象，从建筑学科的角度对其进行分析和论证，并借鉴产业经济学、人文地理学、交通运输学等其他学科的研究理论和方法，遵循“宏观、中观、微观”的逻辑，针对港域空间发展中存在的问题，提出港口区域空间发展行之有效的方法和手段。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	536
1233	燃气射流动力学	9787568297011	9787568297011	姜毅 蒲鹏宇 程李东 牛钰森 编著 	\N	1-1	16开	58.00	\N	北京理工大学出版社	\N	\N	\N	2021-05-20	/book/75273111-0bdb-45ec-a77d-eac46f3c1bb49787568297011.jpg	本书第一章通过日常生活中的各种射流现象，引导读者认识射流的本质，理解燃气射流的特有性质。第二章主要讲述气体动力学基本理论，首先介绍气体流动的基本性质，根据流体动力学守恒定律构建控制方程。第三章主要讲述燃气射流动力学的基本理论，从喷管内的燃气射流流动入手，逐步引入超声速燃气射流中常见的激波与膨胀波等概念，并分析不同流动状态下的燃气射流结构。第四章主要讲解燃气射流数值计算的基本理论，针对可压缩流动，构建绝热无粘理想气体的黎曼求解器，并将此扩展到多维粘性可压缩流动中。第五章介绍发射工程中典型的燃气射流动力学问题及其分析方法，帮助读者将理论与实践相结合。 本书主要作为航天发射与火箭推进专业研究生入门教材，重点在于建立读者对燃气射流的基本概念，并介绍燃气射流分析的基本方法。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	862
1234	CT图像环形伪影去除方法	9787568297035	9787568297035	李建武 霍其润 颜子夜 著 	\N	1-1	16开	72.00	\N	北京理工大学出版社	\N	\N	\N	2021-04-26	/book/1329266d-8b66-47d1-8c43-fcbf693615d79787568297035.jpg	本书旨在系统地介绍CT图像环形伪影去除、超分辨率重建等若干问题的算法研究和典型应用，共分为7章内容。首先，阐述了CT图像重建原理，分析了CT图像中环形伪影产生原因，讨论了环形伪影去除的前处理与后处理方法。然后，提出了多种CT图像中环形伪影去除的新方法：基于L0范数滤波；基于单向变分和相对变分；基于L0约束单向变分模型；基于变分和低秩矩阵分解。进一步从深度学习的角度，研究了基于变分和生成对抗网络相结合的方法。最后，针对CT图像分辨率各向异性和硬件对分辨率提升的限制，提出了利用超分辨率增强来提升CT图像质量的方法。 本书可以作为信息技术、生物医学工程等专业科研人员和工程技术人员的参考用书，亦可作为相关专业研究生的参考教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	191
1235	信号与系统的处理、分析与实现	9787568297424	9787568297424	振海 张振山 胡红波 吴日恒 何光 才德 编著 	\N	1-1	16开	98.00	\N	北京理工大学出版社	\N	\N	\N	2021-08-13	/book/78f4f1a6-cb5a-4721-9690-32b026980eb39787568297424.jpg	本书简明系统地介绍了信号与系统的基本理论，典型分析与处理方法，以及仿真实现与实验实践等内容，强调理论、应用与实验相结合。全书共分为上下两篇，上篇为原理篇，重点介绍了信号与系统的时域、频域和变换域的分析处理方法与及理论，以及MATLAB仿真实验实现的内容；分为7章：信号与系统的基础知识，连续时间信号与系统的时域分析，离散时间信号及系统的时域分析，连续时间信号与系统的频域分析，离散时间信号与系统的频域分析，连续时间信号与系统的变换域分析，离散时间信号与系统的变换域分析；下篇为实践篇，重点介绍了动态信号测试分析处理仿真设计与实现，MATLAB与LABVIEW仿真实现相结合，体现理论与实践相结合的特点。本书内容上注重经典原理与现代实验相结合，信号与系统的时域、频域、变换域分析处理方法与MATLAB仿真实验，LABVIEW仿真实现相结合，目标上强调知识的精熟学习目的，方法上强调以学生为中心的翻转课堂教学方法，并紧密结合科研实际，以实例方式展示理论与实践相结合。本书可作为机械工程，仪器科学与技术，兵器科学与技术等相关专业的本科生、研究生从事科学研究、实验数据处理与分析的学习中参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	639
1292	园林树木学	978-7-5683-0179-4	\N	吉文丽 	\N	1-1	16开	60.00	\N	西北农林科技大学出版社	\N	\N	\N	2016-11-01	/book/ec6689b9-f42c-4830-95e1-fdcb8cc3ab399787568301794.jpg	该书着重阐述了园林树木方面的理论知识，对我国各地有发展前途的树种，依其在园林中应用的情况，分别按重要树种、一般树种和次要树种进行了繁简程度不同的论述。为帮助读者识别这些树种，书中附有插图200余幅。园林树木学是园林专业主要的专业课之一。可供园林工作者和本专业大中专院校师生参考使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	971
1804	海洋的子民：波利尼西亚之谜	978-7-301-32318-2	9787301323182	[美]克里斯蒂娜?汤普森 	\N	1	16开	88.00	265.0千字	北京大学出版社	472	7301	\N	2022-03-23	/book/2701d96e-2a36-4736-8186-b5cf80b6443a32318.jpg	本书是一部兼具历史通识与科普新知两大特点的大众读物。 数千年前，波利尼西亚人来到太平洋最偏远的岛屿群，广为分布，展开了一个北抵夏威夷、西至新西兰、东到复活节群岛的广阔三角形。在欧洲探险家的船队到来之前，他们曾是住在那里的唯 一 人群。最早的波利尼西亚人是如何找到并扎根于这些辽远广布的岛屿？没有书写或金属工具的人们，如何征服世界上最壮阔的海洋？这个难题，即是在十八世纪出现的著名的“波利尼西亚起源之谜”。众多航海探险家、语言学家、考古学家、民俗学家、生物学家和地理学家，围绕这个疑问，三百年来讨论不休。 本书作者通过详尽的研究与调查，精采地融合了历史、地理、人类学和航海学知识，将波利尼西亚之谜清晰地呈现在读者眼前。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	930
1236	过程控制系统	9787568298148	9787568298148	纪振平 主编 	\N	1-1	16开	72.00	\N	北京理工大学出版社	\N	\N	\N	2021-06-24	/book/8714859e-505c-4b40-a67d-30c7d768c57a9787568298148.jpg	本书主要讲述如何将计算机技术、数字仿真技术、网络通信技术及自动控制理论知识应用于实际工业过程控制系统，以及在实际应用中需要考虑哪些具体理论与工程实际问题。本书全面地论述了过程控制系统的要求、组成、性能指标和发展；工业生产过程数学模型的一般表示形式和建模方法；控制系统常用仪器仪表的选型和应用；控制器的调节规律、选型与参数整定；简单控制系统的结构和特点及分析、设计和调试等；数字化控制系统的采样、数据处理、基本PID及改进算法的数字化实现；常用的复杂控制系统，如串级控制、补偿控制、比值控制、均匀控制、分程控制等系统的结构、分析、设计和实施等；多变量解耦控制系统的分析和解耦设计方法；典型工业过程的控制。 本书是面向应用型大学本科生的教材，因而更强调理论与实际的结合，培养学生分析问题和解决问题的能力，注重对学生应用能力的培养。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	573
1237	旅游企业财务管理	9787568299084	9787568299084	刘清 赵丽君 陈险峰 主编 	\N	1-1	16开	65.00	\N	北京理工大学出版社	\N	\N	\N	2021-06-30	/book/2964bbc0-74eb-4a68-a810-3e3e83fdd9b29787568299084.jpg	本书可作为高等院校旅游管理类专业旅游企业财务管理课程的教学用书，也可作为旅游企业导游人员的培训和工作参考用书。本书根据高等院校大学生的项目课程学习需求，在结构设计上采用了模块、项目和任务编排方式。教材分成旅游企业财务基本理念的确定，旅游企业筹资成本管理、资投资管理、旅游企业资产管理，旅游企业成本与费用管理、旅游企业财务预算与财务分析管理、旅游企业外汇管理模块，每个模块下分别设置了不同工作项目。第一部分是项目任务导入；第二部分是与项目相关的工作任务；第三部分是相关理论知识，为完成工作任务提供必需的相关知识；最后一部分是技能训练，它引导着学生进一步开展实训。本书以旅游企业资金管理流程为方向，通过模块化教学的手段，将教学内容分解为六个模块，以完成项目的任务方式进行教学，全面训练学生的旅游企业财务管理的实践操作能力，培养学生独立分析问题、解决实际问题的能力，实现将理论融合到实践中的教学目标。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	329
1240	实验动物组织病理学彩色图谱	9787564191450	\N	李懿萍,陈平圣,苏宁主编 	\N	1-1	16开	600.00	\N	东南大学出版社	\N	\N	\N	2021-09-01	/book/a9ba96e4-cec1-46dd-8dd0-8ee1d769376e9787564191450.jpg	该书以实验动物为研究对象，用病理的实验方法观察和研究在动物感染、中毒、缺氧的情况下对受试动物损伤而引发的不同程度病变，分析不同药物、在不同剂量情况下，对动物的细胞组织器官造成的病理改变，从而阐述病变发生的原因，发病机制，病理变化，以及病变的转归和结局。代替不可能在人体进行的实验。该书以东南大学医学院病理学系为主的病理专家联合编著，资料来源于长期从事动物实验病理研究课题与研发项目（科研项目见附录），内容包括文字描写和照片，全书照片1000余幅。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	681
1241	地区的现代的新农村	9787564150235	\N	齐康等编著 	\N	1-1	16开	88.00	\N	东南大学出版社	\N	\N	\N	2014-06-01	/book/b2a5bf4e-e349-4352-979b-13241910f7909787564150235.jpg	本书分为理论和实践两大部分。理论部分主要研究了当前城市化进程对农村的影响, 从城乡一体、村落特色、乡镇空间组合和管制、农民等方面, 探讨新形势下农村建设面临的机遇和可能。实践部分探索了地区的农村建筑风格的生成, 并在对乡镇调查的基础上, 例举了我国各地村庄和乡镇典型的成功的规划案例。在当今全球气候变暖、经济一体化、全球经济衰退、复苏, 东方建筑兴起的背景下, 本书以即将全面掀起的新农村建设为研究背景, 总结农村规划发展的经验与教训。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	369
1242	图形创意设计	9787564166663	\N	陈珊妍著 	\N	1-1	16开	68.00	\N	东南大学出版社	\N	\N	\N	2016-08-01	/book/4f0b7e94-4dc1-484b-a249-752d2ae2e6ce9787564166663.jpg	本书结合了国内外图形设计的最新案例、艺术院校图形设计课程教案以及学生创作的一手资料，针对视觉传达设计的教学特点，既阐述了图形设计入门各个阶段的步骤、练习指导，又较为全面地介绍了图形设计领域的原理、表现手法和形式语言，精心收录了多个设计领域的作品案例。大量图例均具有很高的设计水准，并加以说明分析，文字简练，内容详实，信息量大，具有一定的学习参考价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	330
1243	千年壁画、百年沧桑：古代壁画暨流失海外珍贵壁画再现传播与展示	9787564186548	\N	王岩松著 	\N	1-1	16开	298.00	\N	东南大学出版社	\N	\N	\N	2019-12-01	/book/d9c9f49b-e690-4a1d-a92e-8fea56a30d299787564186548.jpg	20世纪二三十年代，社会动荡，大量壁画流失欧、美、亚洲等一些国家的博物馆及私人手中,他们对之予以陈列展示并加以研究、开发与利用。这些原本应该在中国的壁画，至今仍未能“回家”，国人难得一见。这些流失海外的壁画反映着一段不平凡的历史。由于种种原因，国际上还未达成壁画归还的协议和公约，原物回归条件尚不具备，在壁画原作欣赏不便的情况下，对这些壁画进行复制与临摹，便成为弥补缺憾的手段之一，也是保护和传播壁画的有效途径，对传承和弘扬中华优秀传统文化也有着积极的意义。壁画作品包括原属地涉及新疆、山西、甘肃、河南等地，既有鸿篇巨制，也有盈尺残片，均以临摹复制的方式，让它们“回归中国”，让国人不出国门就能欣赏到这些珍贵的壁画。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	151
1245	数字景观：逻辑·结构·方法与运用	9787564186760	\N	成玉宁著 	\N	1-1	16开	290.00	\N	东南大学出版社	\N	\N	\N	2019-10-01	/book/bca379c4-e2b8-43cc-95e3-7bc0f2fb0cd09787564186760.jpg	本书针对“数字景观”这一风景园林前沿课题，从“逻辑、结构、方法与运用”等方面首次系统地建构了数字景观概念；从价值与内涵出发，深度解读了“数字景观”的原理；从逻辑、架构与平台入手，阐释了“数字景观”的结构；针对“数据采集、数据分析、方案模拟、数字建造、绩效测控”等景园规划设计环节，总结了“数字景观”的研究与运用方法；从风景园林环境评价、景园规划设计、海绵城市设计、景园色彩设计、景园空间研究、景园行为研究等领域，详细解读“数字景观”的运用与成果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	216
1424	管理潜台词——英文电影台词背后的管理智慧	9787561584507	\N	施志建 	平装	1-1	大32开	66.00	\N	厦门大学出版社	\N	\N	\N	2022-02-01	/book/7f923b49-1619-4b4f-9dc3-1fd1e9738f631083418.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	654
1246	世纪“广生行”:20世纪中国产业环境下的设计体制研究	9787564188054	\N	张馥枚著 	\N	1-1	16开	49.00	\N	东南大学出版社	\N	\N	\N	2020-02-01	/book/5b443b4e-cf36-4a5d-8588-d9463f3853089787564188054.jpg	本书以“广生行”为代表的上海日化产业一个多世纪的设计发展为例，以三个时代的三个典型人物作为中国现代设计体制研究的切入点，考察一百多年以来另现代设计在不同的历史与社会背景之中的发展变迁和设计师的角色与身份的转化，以此来描述现代设计“嵌入”中国现代化进程的历程。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	439
1247	西藏藏式传统建筑	9787564162726	\N	焦自云等著 	\N	1-1	16开	170.00	\N	东南大学出版社	\N	\N	\N	2019-07-01	/book/7525143b-fdc8-4f05-808a-61b6f4bb00a79787564162726.jpg	本书内容主要是对国家自然科学基金《藏式传统建筑研究》立项（批准号50478004）项目的成果的总结。包括在西藏自治区文化厅、科技厅、江苏省文化厅（为拉萨市对口支援单位）的支持下，通过对自治区内所有的国家级、省级和市级文物保护单位的测绘、调查和建档所得到的一大批关于藏式建筑的资料，地理范围上覆盖了拉萨市、山南地区、日喀则地区、昌都地区、林芝地区等，书中附有大量重要建筑的CAD测绘图和高清数码照片。在以上资料的基础上，按照中国建筑历史上的常用分类法，本书将藏式传统建筑可分为宫殿、寺庙、民居、园林、陵墓等。通过对其时代特征、结构特点、细部做法的分析，探讨了传统藏式建筑的设计理论与方法。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	888
1248	构成秩序视野下新型工业化建筑的产品化设计与建造	9787564191122	\N	罗佳宁著 	\N	1-1	16开	89.00	\N	东南大学出版社	\N	\N	\N	2020-10-01	/book/d49c72fc-6e1b-4108-8cff-16d1ffabc0c79787564191122.jpg	本书首先介绍了传统的建筑构成和建筑秩序理论，并在建筑工业化的视野下对其进行了拓展，构建了“建筑工业化构成（秩序）原理”的理论框架，并以典型建筑类型-预制装配式建筑和典型工业产品-汽车（车身）为例，填充和完善了此原理框架的内容，然后基于此原理框架内容对预制装配式建筑和汽车（车身）进行了半定量类比分析。提出了“建筑产品模式”、“构件法建筑设计”等新型建筑工业化设计与建造理论。最后，通过东南大学的预制装配式建筑工程实践和澳大利亚的预制装配式建筑项目展示了“建筑工业化构成秩序产品化”的一种将制造业融合进建筑业的可行技术策略和路线，为我国建筑工业化的发展方向以及我国目前建筑工业化的研究角度、研究模式和研究内容提供了新的思路。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	720
1249	装配整体式混凝土结构	9787564192587	\N	吴刚著 	\N	1-1	16开	128.00	\N	东南大学出版社	\N	\N	\N	2020-12-01	/book/ccc40ba9-b350-4277-901e-fe6bb1b961aa9787564192587.jpg	系“新型建筑工业化丛书”之一，书稿对国家重点研发计划“装配式混凝土工业化建筑技术基础理论”项目的研究成果进行了梳理和汇总，从国内外“等同现浇”规范标准总结入手，研发了预制预应力混凝土装配整体式框架、无支撑装配整体式混凝土框架、节点外拼接装配式混凝土框架和预制混凝土装配整体式剪力墙结构等新形式，探讨了大直径配筋、集束配筋以及应用高性能混凝土连接等新技术，同时也对装配式混凝土结构耐久性和全寿命分析进行了多层次研究。这些研究成果可以推动建筑工业化基础理论与技术的发展，加速提升我国建筑工业化科技创新能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	194
1250	BIM技术与现代化建筑运维管理	9787564180485	\N	徐照等编著 	\N	1-1	16开	68.00	\N	东南大学出版社	\N	\N	\N	2018-11-01	/book/002d0fd3-5731-455d-b395-68a8f96580729787564180485.jpg	本书主要内容：①打造以BIM为基础的运维管理系统，设计BIM为基础的运维管理系统基本框架，分析在运维管理里面采用的BIM运行思路以及技术手段，减少传统管理模式弊端所带来的不利影响，找到更科学、更规范、更高效也更实惠的运维管理的目标寻找新的突破点。②探讨BIM在运维管理中的应，包括在设备管理中的应用、管理、急救管理和空间管理，挖掘BIM在运维管理上的应用潜力，帮助企业认识BIM在物业运维管理中的应用价值。③BIM在我国的物业运维管理中的应用障碍与对策。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	589
1251	城市社区生活圈规划研究	9787564193546	\N	孙道胜著 	\N	1-1	16开	59.00	\N	东南大学出版社	\N	\N	\N	2020-12-01	/book/24118de7-1138-48da-847e-0c5a2ffd58829787564193546.jpg	本书建构了基于时空间行为的城市社区生活圈概念体系，科学探索了城市社区生活圈的多种划分方法及其空间模式，并创新性地提出城市社区生活圈规划系统及其实施方案，同时利用GPS轨迹数据与活动日志调查的第一手数据，剖析社区生活圈与城市生活圈的规划实践案例，进一步指出城市社区生活圈规划的现状问题与未来方向，是国内首部关于城市社区生活圈研究的著作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	194
1252	工业污染场地竖向阻隔技术	9787564192709	\N	杜延军 	\N	1-1	16开	88.00	\N	东南大学出版社	\N	\N	\N	2021-11-01	/book/b17d96e0-ab79-44b7-8509-75b2e7093a349787564192709.jpg	竖向阻隔屏障是污染场地修复和治理工程中防止污染物迁移扩散不可或缺的技术。作者以新型竖向屏障材料为研究对象，针对污染场地复杂污染液在竖向屏障中的渗透、击穿问题展开了数十年的基础性研究，对于污染物运移参数和防污屏障的寿命评价考虑了一些计算方法。同时，由于我国存在较多早期建设时未能按标准进行环境污染防治的工业搬迁场地，本书就如何针对这类污染场地的修复治理开展了竖向阻隔屏障技术的现场研究。选题新颖、前沿，可弥补我国竖向阻隔屏障研究和应用中，材料研发、优化设计和施工方面的不足。是国内首本竖向阻隔屏障材料研发、设计和应用指导相关的专著。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	966
1254	高等音乐（师范）院校钢琴公共课分级教程	9787810967273	9787810967273	主编 李昕 副主编 林晔 孙晓丹 分册主编 邢媛媛 陈再峰 	\N	1-1	16开	148.00	\N	中央音乐学院出版社	\N	\N	\N	2016-06-01	/book/fd558e56-efb6-46b9-b144-94d6df2458559787810967273.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	450
1258	法国视唱第七册	9787569601121	9787569601121	[法]亨利·雷蒙恩 [法]古斯塔夫·卡卢利 编著 张涓 校订 	0	1-1	16开	72.00	\N	中央音乐学院出版社	\N	\N	\N	2021-03-01	/book/2dd9a139-2cf9-42b5-a1e7-8be506bb4bd39787569601121.jpg	　　《法国视唱》是音乐界沿用了百余年的经典视唱系列教材，全套共34本分册，其中涵盖了单声部、二声部、三声部以及四声部的训练学习。 　　本书为混声二部练习，采用高音与低音谱号组成大谱表记谱。选用巴洛克、古典时期的主调与复调二声部作品，帮助学习者建立起纵向多声部的立体听觉与演唱思维。 　　本书适用于器乐演奏、声乐以及作曲专业的学生，根据专业特点分别进行弹唱、合唱、合奏、听写、作品分析等不同形式的训练。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	818
1259	二声部视唱	9787810969055	9787810969055	[苏]斯波索宾 编著 熊克炎 译 	\N	1-1	16开	35.00	\N	中央音乐学院出版社	\N	\N	\N	2018-06-01	/book/d6c9aefe-e8e7-499c-b4b7-48b90c678def9787810969055.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	450
1261	复调音乐教程（下）	9787810963626	9787810963626	段平泰 著 	\N	1-1	16开	32.00	\N	中央音乐学院出版社	\N	\N	\N	2013-06-01	/book/30f04560-0bdb-4b6c-9ed8-6b0010bca4c79787810963626.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	482
1262	19世纪的音乐（“文化语境中的西方音乐”系列丛书）	9787569600872	9787569600872	[美]瓦尔特·弗利什著 刘小龙译 	\N	1-1	16开	78.00	\N	中央音乐学院出版社	\N	\N	\N	2020-10-01	/book/49544d1b-987d-49a5-a784-ec5947c1f43b9787569600872.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	988
1263	提琴制作工艺学	9787569601428	9787569601428	郑荃 编著 	\N	1-1	16开	220.00	\N	中央音乐学院出版社	\N	\N	\N	2021-07-01	/book/0610d572-cbb7-4ea5-aa15-b33a2112d4799787569601428.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	683
1264	金鳞（13部原创作品）	9787569600490	9787569600490	唐建平 作曲 	\N	1-1	16开	106.00	\N	中央音乐学院出版社	\N	\N	\N	2020-03-01	/book/feb3d98c-dba4-4ef0-b016-43e919fb44c89787569600490.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	834
1265	东西Ⅱ：和光同尘——为混合室内乐队而作（13部原创作品）	9787569600261	9787569600261	张帅 作曲 	\N	1-1	16开	136.00	\N	中央音乐学院出版社	\N	\N	\N	2019-12-01	/book/8323b030-0de9-4e5a-a037-3f301f02020c9787569600261.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	581
1266	大地音诗——为笙、筝和室内乐而作（13部原创作品）	9787569600704	9787569600704	秦文琛 作曲 	\N	1-1	16开	72.00	\N	中央音乐学院出版社	\N	\N	\N	2020-07-01	/book/c3139a50-5aec-4d19-9ced-db07f8e3d8fa9787569600704.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	707
1267	丝绸之路的回响-中国作曲家管弦乐新作品-第二交响曲“长城”（精装）	9787810969123	9787810969123	叶小纲 作曲 	\N	1-1	16开	218.00	\N	中央音乐学院出版社	\N	\N	\N	2018-02-01	/book/3ad5e64d-ea85-4319-9389-5519abf571579787810969123.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	169
1268	马思聪全集	9787810962391	9787810962391	《马思聪》编辑委员会 	\N	1-1	16开	1,800.00	\N	中央音乐学院出版社	\N	\N	\N	2007-11-01	/book/efea4c62-7f7a-495f-a2c7-673c0bb99f5f9787810962391.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	358
1269	给聪明孩子的故事与诗（全4册）	9787559826817	9787559826817	(美) 哈罗德·布鲁姆选编 黄橙 戎佩珏 熊亚芳 译 戎林海 审校 	\N	1-1	32开	198.00	\N	广西师范大学出版社	\N	\N	\N	2021-05-01	/book/fe2da7c4-7be9-4366-991d-0a60e6ef48d09787559826817.jpg	《给聪明孩子的故事与诗》分“春”“夏”“秋”“冬”四卷，精选了布鲁姆教授从5岁反复阅读到70岁的文学经典，包括深具启迪和娱乐性的41个故事、传说和84首诗歌。选品内容大多是十九世纪或更早的作品，既涵盖诸如莎士比亚、马克·吐温、惠特曼、济慈、伊索、屠格涅夫等名家著作，也有不少颇有逸趣的佚名作品。这本书集合了那些最好的、最敞开心扉的幻想、叙述、抒情以及思索，给予孩子清楚、独立、鲜明的自我，同时，也让每个年龄段的读者都可有所收获。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	637
1270	灰烬的光辉：保罗·策兰诗选	9787559834287	9787559834287	（德）保罗·策兰 著；王家新 译 	\N	1-1	32开	82.00	\N	广西师范大学出版社	\N	\N	\N	2021-01-01	/book/bb8a6af3-1cf5-4513-a4c9-7928e04bf48f9787559834287.jpg	《灰烬的光辉：保罗?策兰诗选》由著名诗人、翻译家王家新教授精心编选和翻译，由约360首诗和部分策兰的获奖致辞、散文和重要书信集结而成。本书既充分展现了策兰一生创作的精华，又是王家新多年来翻译和研究策兰的心血结晶，对于策兰译介和中国当代诗歌的创作和翻译都具有重要意义。 本书的约360首诗作从策兰一生十余种诗集中选译，全面体现了策兰一生不同阶段的创作。作为“奥斯威辛”的幸存者、流亡者和天才诗人，策兰的诗既深刻见证了犹太民族的苦难，体现了时代“内在的绞痛”，又以其卓异的“晚期风格”，把现代诗歌的艺术探索推向了一个令人惊异的境地。本书的译者长序全面介绍了策兰的生平和创作，揭示了策兰一生的精神和艺术历程及对我们时代的启示；本书所附录的策兰获奖致辞、散文和书信，也为我们展现了一个痛苦而又卓异的诗歌心灵。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	781
1271	白睿文·映象中国	9787559830449	9787559830449	（美）白睿文 编 	\N	1-1	32开	78.00	\N	广西师范大学出版社	\N	\N	\N	2021-04-01	/book/67fd032e-a9bc-44de-80ad-dea6be5b0d4f9787559830449.jpg	贾樟柯善于用镜头记录时代中小人物，叙述在超现实的经济运动中普通人的悲欢离，是中国第六代导演领军人物。 本书是著名中国电影研究专家白睿文对贾樟柯电影的集中访谈，以年代为序，集中探讨了从《小山回家》《小武》到《江湖儿女》等10部重要的电影，也是贾导电影人生的梳理与总结。书中，贾樟柯亲述从汾阳走向世界背后的动人经历，分享每一部经典作品背后的传奇故事、创作缘起与理念；记录各个创作时期对电影的探索与思考，对于社会、现实的关怀和反思。 通过访谈文字，我们可以也看出贾导对电影美学、创作理念等的见解，对电影形式的探索，更可见一代电影导演的成长之路。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	540
1272	曹雪芹的疆域——《红楼梦》阅读接受史	9787559836519	9787559836519	计文君 著 	\N	1-1	32开	48.00	\N	广西师范大学出版社	\N	\N	\N	2021-05-01	/book/fe643bbd-770d-4e68-9213-453a04c833699787559836519.jpg	《红楼梦》比起其他古典叙事名著，内容更为丰富、也更为复杂，尤其自2017年成为高考必考内容之后，造成了很多中学生及家长的困扰。《曹雪芹的疆域：阅读接受史》作者计文君以《红楼梦》为研究主体，从文化物种获取生存度的角度，勾勒了《红楼梦》从诞生到今天的传奇“经历”，对《红楼梦》从“抄本”到“正典”的接受史及传播史进行了阶段性梳理和深度解读，其中也包含了作者对《红楼梦》更深入、更集中的思考和新读。本书为《红楼梦》研究普及读物，既有学术研究著作的逻辑性阐述，亦有生动有趣的表达，对中学生接受《红楼梦》原典具有一定的指导意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	629
1273	大学问	9787559828422	9787559828422	夏明方 著 	\N	1-1	32开	68.00	\N	广西师范大学出版社	\N	\N	\N	2021-01-01	/book/c0036043-c4cf-4b86-aee7-b8d05e50d6a99787559828422.jpg	本书从灾害史与生态史的角度进行切入，分为六个专题对灾害与历史缠绕的“另一个中国”进行阐述。主要围绕的话题有：灾害作为不确定性因素在历史进程中的重要影响；历史上的重大自然灾害与历史记忆；神州大地、山水之间的生态环境变迁；历代王朝的救灾制度与慈善事业；作为历史借鉴的灾害史与生态史；等等。作者从事件及区域入手，如1942年河南大饥荒、1976年唐山大地震、1931年和1998年武汉的大洪水，2003年的“非典”疫情，以及2020年在武汉爆发的新冠肺炎疫情等，以新的视野分析中国历史上的自然灾害与生态环境变迁，以此透视中国历史与社会的发展，并在新冠疫情之下，对文明的“双相”，以及后新冠时代的人类发展提出历史学者的思考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	764
1274	君是人间惆怅客：齐白石京华烟云录	9787559840844	9787559840844	张涛 著 	\N	1-1	32开	88.00	\N	广西师范大学出版社	\N	\N	\N	2021-09-01	/book/76a38177-9b93-42d3-9b7e-06f44352f11a9787559840844.jpg	齐白石年近花甲三上北京开始北漂，作者对齐白石在北京及周边曾经驻足的地方重新实地探访，如法源寺、琉璃厂、跨车胡同、齐白石旧居、陶然亭、袁崇焕故居（“张园”）、国立北平艺专旧址、保定莲花池、中山公园、来今雨轩、南锣鼓巷、雨儿胡同、齐白石魏公村墓地原址等。将历史文献记载中的齐白石驻足各处的情状与现实中目前实地的场景相结合展开叙述，让历史与现实之间实现一种文本与图像意义上的交融与共鸣。结合齐白石与各处有关的历史人物或有关画作，进行与之相关的深入分析，以此建构起齐白石定居北京时期的生活细节，以及20世纪20-40年代背景之下的北京城人文风貌。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	759
1275	陆春祥笔记新说系列（全5册）	9787559831330	9787559831330	陆春祥 著 	\N	1-1	32开	326.00	\N	广西师范大学出版社	\N	\N	\N	2020-11-01	/book/a11f9b30-ad06-46c6-a4ae-2a42948ec4169787559831330.jpg	笔记新说系列是陆春祥近年来解读古代笔记经典的散文札记合集，包括《字字锦》《笔记的笔记》《太平里的广记》《笔记中的动物》《袖中锦》五本。《笔记中的动物》以动物为话题，《袖中锦》聚焦笔记里的奇谈趣闻，《笔记的笔记》和《太平里的广记》关注的是笔记写作的“热点”，《字字锦》是以时间为线索的笔记大百科。本系列图书用现代思维重述古人故事，赋予古代笔记更多的时代性和新鲜感，为现代人搭建笔记文学的阅读坐标，温故知新，延续经典。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	151
1296	茶学专业实践教学指导	978-7-5683-0367-5	\N	余有本 	0	1-1	16开	30.00	\N	西北农林科技大学出版社	\N	\N	\N	2017-10-01	/book/522b3e61-d3f1-4575-acb3-5c722a8dcc171081818.jpg	本书中包括茶叶加工技术实践、茶树栽培学实践、茶树育种学实践、茶叶生物化学实验、茶叶感官审评与检验实践、茶树病虫害实验、茶艺与茶文化实践等。内容系统全面，综合性强。本教材内容涵盖茶学专业大部分核心课程的实践教学内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	913
1276	伦敦日记：苏联驻伦敦大使二战回忆	9787559839763	9787559839763	（苏联）伊万·迈斯基著；（英）加布里埃尔·戈罗德茨基编注；全克林，赵文焕译 	\N	1-1	32开	158.00	\N	广西师范大学出版社	\N	\N	\N	2021-07-01	/book/bcd49379-d641-4cb3-badb-e55b950315a19787559839763.jpg	苏联驻英大使伊万·迈斯基于1932—1943年在伦敦写下一批珍贵日记，经加布里埃尔·戈罗德茨基谨严选编、作注而成书。日记中记述苏联在英的外交活动，见证了众多二战重大历史事件，由此可窥见苏联外交政策之制定、英国对参战态度之转变、战时诸人之心态等等，是一份不可多得的文献资料。日记里讲述了迈斯基与丘吉尔、劳合·乔治、韦伯夫妇等多位英国政要的交往，更以生动笔法，带人们重临议事厅的演讲现场、海军部深夜密谈的房间、空袭阴云下的伦敦街道……日记中文版特别收录中国相关内容，揭示了苏联制定对外政策过程中，中国所起的作用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	602
1277	入木：黄永玉版画艺术	9787559830876	9787559830876	黄永玉著，北京画院编 	\N	1-1	8开	380.00	\N	广西师范大学出版社	\N	\N	\N	2020-08-01	/book/681f3601-1f60-4bd5-b83b-aef13e84877b9787559830876.jpg	2020年，96岁的黄永玉首部版画全集终于面世，他说，“这是我一辈子刻的木刻，大部分都在这里了，这些木刻板子有如自己一半的历史骸骨，不离不弃地过了九十六年。” 木刻是黄永玉艺术的根，是他视觉体系中的压舱石，而他刀底下所刻的，正是他生命里所有的。这本《入木：黄永玉版画艺术》经黄永玉亲自筛选，收入400余幅创作于20世纪不同时期的版画作品，以及萧乾、黄新波、臧克家、陈履生等对黄永玉版画艺术的创作历程回顾梳理与风格演变分析总结的文章，并附录有黄永玉艺术大事记及文献别册，不仅是其版画成就的全方位展示，还会丰富更多读者对中国现代版画史的认识，促进更多学者的研究，使这批国家文化艺术瑰宝的熠熠光辉得以永续。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	306
1278	思考中医——对自然与生命的时间解读	9787559808998	9787559808998	刘力红 著 	\N	4-1	16开	48.00	\N	广西师范大学出版社	\N	\N	\N	2020-05-01	/book/d6e3957e-07d7-45a0-a9b6-a9db9d521da89787559808998.jpg	本书是对中医疑难病症论述巨著《伤寒论》的解读，涉及“伤寒之意义”、“治病法要”，及“太阳、少阳、太阴”之病症纲要等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	688
1279	文明三部曲1	9787559832870	9787559832870	张笑宇 著 	0	1-1	16开	88.00	\N	广西师范大学出版社	\N	\N	\N	2021-03-01	/book/1a5bacb2-f92d-4486-b43c-57fe024548189787559832870.jpg	人与机器之间的边界，最危险之处并不在于机器能够变得多么像人，而在于人在多大意义上已经变得像机器——像机器一样只在规范之内定义自己， 接受权威灌输和社会主流观念的潜移默化以及消费主 义的各种操纵，而无力反思更高层面的问题。毕竟，人的自由意志能力，并不体现在他们愿意做什么，而体现在他们不愿意去做什么。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	802
1280	我思记忆	9787559827920	9787559827920	李晓 古川 编著 	\N	1-1	32开	78.00	\N	广西师范大学出版社	\N	\N	\N	2020-06-01	/book/5b31e045-a7ff-4ac8-80d9-5f9188b888179787559827920.jpg	本艺术史年表汇聚了古代中国上自远古，下迄清朝末年的传统艺术成果，包括音乐、舞蹈、戏剧、曲艺、书法、篆刻、绘画、雕塑、建筑、园林等十大门类。 各门类中各条目以纪年汇总，艺术门类资料翔实全面，作品条目内容简约准确，条分缕析地展现了我国传统艺术的生长轨迹及辉煌成就，贯穿全书的时间轴线能让读者轻松了解中国艺术的演变。全书系统性强，便于检索，既可作为专业艺术类院校的参考工具书，也可作为普通读者了解我国传统艺术的导引图书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	412
1281	西域探险记	9787559842909	9787559842909	（英）奥雷尔·斯坦因 著 巫新华 译 	\N	1-1	32开	88.00	\N	广西师范大学出版社	\N	\N	\N	2021-11-01	/book/aa657509-5fd2-4a38-8eb2-fed53aab228d9787559842909.jpg	本书简明扼要地记述了斯坦因三次中亚探险考古的主要过程和重要收获，复原了中西多元文化交融的西域历史图景。全书辅以大量珍稀考古实景图片、文物图片和遗址平面图，图文并茂，贯通了遗迹和历史的文明脉络，揭开了引人入胜的古迹神秘面纱，让考古报告变得通俗易懂、生动有趣。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	541
1282	乡下人：沈从文与近代中国（1902—1947）	9787559837097	9787559837097	孙德鹏 著 	\N	1-1	32开	88.00	\N	广西师范大学出版社	\N	\N	\N	2021-05-01	/book/bb7b30c5-fb93-4412-b1f4-e94d8200db9c9787559837097.jpg	这是一部沈从文评传，也是作者与沈从文之间的一次跨学科对话。作者以史学为点，从 “乡下人”的视角回顾沈从文的前半生，在沈从文作品中重建近代中国的记忆，从湘西叙事找寻理解近代中国的另一种方法。 不同于一般从生平出发的人物立传，作者立足沈从文自称“乡下人”的人生经验，结合法史哲等多学科思想、小说文本对其经历与情感展开的推演想象，使得小说人物与传主形象交相辉映，实现了文学对历史的叙事性补充。并通过城市与乡村之间的对照，展现了近代中国的一些独特面向，让人置身于进步与落后的对峙语境，理解近代中国的问题。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	143
1283	小阅读·经典	9787559828644	9787559828644	（日）谷崎润一郎著，陈德文译 	\N	1-1	32开	59.00	\N	广西师范大学出版社	\N	\N	\N	2021-09-01	/book/2a93cab5-ac82-4525-a94f-43044cb1f64e9787559828644.jpg	《阴翳礼赞》从“阴翳造就了东方建筑美”这一观点出发,衍生开来,探讨了东方建筑和文化的精妙之处.谷崎润一郎认为一切有阴翳才好,在《阴翳礼赞》中他表达了对东西方文化比较中进行的反思,回归传统的审美理念的愿望,对东方的庭院式的、孤寂的美有着独到鉴赏.其他各篇也围绕东方和西方文化的差异,行文挥洒自如,旁征博引,妙趣横生,可以说建立了一个“谷崎式”的东方美学体系.	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	388
1284	新民说	9787559808578	9787559808578	（英）肖恩·厄舍 著 海明 译 	\N	1-1	16开	138.00	\N	广西师范大学出版社	\N	\N	\N	2021-09-01	/book/a6553123-228a-4c9b-8bf3-e97dc8ce8db89787559808578.jpg	《清单：关于爱与奇想的124张小纸条》中收录了124张风格各异的清单，每张清单后都附有相关的图片，其中大部分是清单原件的副本。 这124张清单跨越古今，涵盖了许多历史事件，以及名人们经历的奇闻趣事：古埃及人请假的理由，有些在今天看来也仍然适用；达尔文的父亲对儿子事业的质疑，全因担心自己的孩子再也无法过上稳定的生活；爱因斯坦要求妻子遵守的协议，让人看完不禁开始思考婚姻的意义；霍华德·洛夫克拉夫特心中总有些怪诞的念头，平常的文字读来却令人浑身发冷；梦露的新年决心，大概会让人想起自己每年都列下可最终没能完成的年度计划……这些清单很少出现在公众的面前，但是它们都独具魅力和趣味，值得大家细细品位。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	877
1285	眩晕	9787559836281	9787559836281	(德)温弗里德·塞巴尔德 著 徐迟 译 	\N	1-1	32开	52.00	\N	广西师范大学出版社	\N	\N	\N	2021-04-01	/book/9bf05862-a5e0-4e6e-868c-9bde986b328a9787559836281.jpg	本书是塞巴尔德的小说处女作，由四章组成，第一章以司汤达的视角，讲述了他的从军经历、与梅毒的斗争以及无果的爱情；第二章讲述了“我”在意大利多地的旅行，或者说被不安驱动的一次次逃离；第三章讲述了卡夫卡于一九一三年在意大利的一次公务出差和浴疗之旅；最后一章，“我”重返德国故乡，挖掘自己的童年记忆。 四个部分都围绕着一个孤独的叙述者，他们都踏上了古怪而令人不安的旅程，而“我”在旅行中撞见了各种分身、尾随者、历史鬼魂，不断与神秘的猎人格拉胡斯相遇，还隐约与不同时空的司汤达和卡夫卡共享了相似的惊恐和困顿……	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	914
1286	走河：恒河逆旅人	9787559824042	9787559824042	谢旺霖 著 	\N	1-1	32开	68.00	\N	广西师范大学出版社	\N	\N	\N	2020-02-01	/book/212b59d9-8adb-4f0b-be87-fab1f62f5f9c9787559824042.jpg	三十岁那年，作者到了印度。后来，他又退了博士学业，一去再去。起初，他不明白自己为什么去印度，又为什么“走河”。直至多年后，当他用文字艰难回顾那些旅程时才发现，原来，曾经那一连串不明所以的步履，正是为了带领他度过八年漫漫写作的长日，以及日后更为漫长的时光。 《走河》讲述作者只身前往印度，沿恒河及其支流行走，一路溯河而上，最后抵达恒河源头的故事。从大河出海口到大河源头，作者写尽了旅途中的试探、寻径、前进、孤独、执着、荒谬与惊险。他用细腻的文字记录下真实所见的印度，以及印度的平民、苦行僧、外国背包客，形形色色的大城小镇、贫穷村落，寺庙圣地，宗教节庆……他冷静地看待印度社会的繁华与贫穷并存、信仰与世俗交织的热闹生活，在极简用度、回归本真的流浪途中体味心灵与自我、自然和社会的接近。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	283
1288	我国卫生人力资源问题与策略研究	9787567918375	\N	孙梅 著 	平装	1-1	16开	68.00	\N	中国协和医科大学出版社	\N	\N	\N	2021-10-01	/book/c29c98a7-9d38-412b-ba11-fe60f28e84b81081781.jpg	《我国卫生人力资源问题与策略研究》综合管理学、组织行为学、循证决策学等多学科的理论与方法，系统梳理了当前我国卫生人力的现状与问题。在此基础上，明确卫生人力的关键问题，并进一步以上海市卫生人力为例，针对卫生人力数量不足、人才紧缺及激励低效等关键问题展开对策研究。包括在深入剖析上海市卫生人力数量和结构基础上进行卫生人力的预测，构建卫生紧缺人才的评价指标体系，从个体需求与机构激励现状的关系探讨针对不同类型医学人才的激励机制等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	576
1289	麦田追梦人	978-7-5683-0648-5	\N	牛宏泰 	0	1-1	16开	68.00	\N	西北农林科技大学出版社	\N	\N	\N	2019-04-01	/book/3083e32a-0f6a-4488-9ac5-f790b82757ce1081790.jpg	项目主要分为三篇:追梦篇,全面介绍王辉教授四十多年不畏艰难、忠于理想、执着坚守的追梦精神。敬业篇,介绍王辉凭着对土地的挚爱与对事 业的专注,四十几年来埋头于小麦育种科研,打破了优质与高产不能兼得的传统,培育出多个优质高产的小麦品种,为确保国家粮食安全作出了卓 越贡献。扎根黄土地、潜心科研、志存高远、永不懈怠的敬业精神。奉献篇,介绍王辉的科研成果及心系民生、淡泊名利、德高为师的奉献精神。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	247
1290	精耕记	978-7-5683-0689-8	\N	高凤香 	0	1-1	16开	68.00	\N	西北农林科技大学出版社	\N	\N	\N	2019-07-01	/book/7313ee87-41f7-4364-a9c4-324f7ed2a6a31081791.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	471
1291	农言绛帐集	978-7-5683-0787-1	\N	张泼 	0	1-1	16开	80.00	\N	西北农林科技大学出版社	\N	\N	\N	2019-11-01	/book/f2499125-73d0-4011-b9e3-57b1b0031e9b1081799.jpg	这是本讲稿集，内容涉及国学撷言、农史之言、农政之言、农教之言、农调之言等等。包括忆录当年立题论讲的学术背景;题录讲义大体内容及昔日发人未发之创新处;补录近年论题深化提升的最新水平;摘录多年聆听者见仁见智的褒贬良言;并自录作者对论题的反思、自判及与时俱进之见。该书确实非仅为集录既往言论而成书，旨趣兼有探新讲稿编集，深掘开发文献资源的追求。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	749
1293	经济法实务学习手册	978-7-5683-0320-0	\N	何苗 	\N	1-1	16开	15.00	\N	西北农林科技大学出版社	\N	\N	\N	2017-07-01	/book/6c77917a-9034-4bb7-982d-235a69079e239787568303200.jpg	《经济法实务学习指导手册》是《经济法实务》的配套教材。本教材在知识结构上将经济法理论划分为:经济法概述、市场主体法律制度、市场运行法律制度以及宏观调控法律制度四个模块进行编写。不仅有利于学生系统掌握经济法理论知识，也为教师根据不同专业进行授课提供了便利。教材学习内容包括课前准备、课后自测以及实务操作三个部分。课前准备和课后自测可以由学生在课前独立完成，课内实训部分可在教师指导下，由教师和学生共同完成。同时，根据学习项目之间关联性和教学需要设置了综合实训内容部分。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	969
1294	园艺植物生物技术实验指导	978-7-5683-0335-4	\N	王晓峰 	0	1-1	16开	23.00	\N	西北农林科技大学出版社	\N	\N	\N	2017-07-01	/book/1cc01f7a-597c-4bab-9b37-fe7b52c7882c1081811.jpg	本实验指导书主要针对本科生和研究生在学习和科研中遇到的问题，将重要的园艺分子生物学基础和前沿分子实验集中编写了该指导书，以满足本科生和研究生园艺植物生物学课程学习的要求，更注重实验系统的完整和过程的实用性，以便成为学生一本经典的简明实验参考书。编写组成员有多年从事园艺植物分子生物学教师组成，各个编写组成员根据自己的实验特长综合了多种参考资料编写，更重要的是以自己的科研和实验经验作为支撑。本实验指导书近40个章节，没有安排细胞生物学和组织培养上的实验，以免与细胞生物学和组织培养课程实验重复。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	814
1295	园艺植物育种学实验指导	978-7-5683-0343-9	\N	巩振辉 	0	1-1	16开	25.00	\N	西北农林科技大学出版社	\N	\N	\N	2017-08-01	/book/b62f62b2-9fa3-4250-89b9-fbeff9a89dac1081812.jpg	全书包括园艺植物育种学实验、果树育种学实验、蔬菜育种学实验、茶学育种学实验以及花卉育种学实验等五部分共50个实验。该教材具有系统性、注重学生创新意识及创新能力的培养、突出高、新、合的编写原则等特点。可作为园艺及其他相关专业的本科生、研究生、教师及科研人员的参考书及教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	386
1419	指数全球2021	9787521328677	\N	杨丹 	平装	1-1	大32开	65.00	470.0千字	外语教学与研究出版社	392	\N	\N	2021-08-01	/book/8d2ce03e-baa2-470d-a2a2-f36802852b9d1083398.jpg	1.北外校长杨丹教授领衔编著； 2.所涉及研究领域均为国内首次以指数形式进行研究，通过结集出版的形式对外发布； 3.为国家各项决策提供定量分析的依据，加强高校的社会服务功能，为全球指数研究标准的中国导向做出北外贡献。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	471
1300	测量学实验实习指导（第2版）	978-7-5683-0489-4	\N	张鑫 	0	1-1	16开	18.00	\N	西北农林科技大学出版社	\N	\N	\N	2018-12-01	/book/fec61f06-f820-4dd4-8630-82c6e73aa7381081837.jpg	该书是在第一版的基础上，结合现代测量技术的发展和学生实验实习的需要，进行了大幅度的修订。全书分测量实验实习须知、测量实验指导和测量实习指导3大部分。其主要内容包括水准仪、经纬仪的认识和使用，以及全站仪与GPS应用等共计16个实验，并分别列有16个实验报告。该书主要供大学本科，专科农、林、牧及资源环境专业的测量课教学使用，也可共中等技术学校的农、林、牧及资源环境专业师生和初学测量者参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	661
1301	陕西果树病虫害图谱	978-7-5683-0697-3	\N	高智辉 	0	1-1	16开	188.00	\N	西北农林科技大学出版社	\N	\N	\N	2019-07-01	/book/0ec1ddd6-6b5b-43b6-84cb-4a8e833c3fde1081841.jpg	《陕西省果树病虫害图谱》以陕西主要栽培的16种果树上发生的595种常见病虫害为对象，用1560多幅彩色图片，栩栩如生地展示果树主要病虫害的为害状、昆虫形态、病害症状、病原菌形态，以供读者正确诊断果树病虫害;对不同的病虫害的为害状和在陕西的发生规律及生活史进行了精炼的描述。在病虫害防治方面，以生产无公害、绿色和有机果品为宗旨，充分体现低碳、环保、安全、可行的新理念，应用国内外果树病虫害防治方面的新成果、新技术、新农药、新方法，来达到事倍功半的效果，为陕西果农服务，为陕西果业产业健康发展保驾护航。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	132
1303	实验室安全管理教育指导	978-7-5683-0803-8	\N	孟敏 	0	1-1	16开	29.00	\N	西北农林科技大学出版社	\N	\N	\N	2020-03-01	/book/db446b31-df1f-42fd-bf20-272f8a4afec61081855.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	777
1389	高速铁路动车乘务实务（配二维码资源）	978-7-5637-4115-1	\N	黄芹 	\N	1-1	16开	25.00	\N	旅游教育出版社	\N	\N	\N	2020-01-01	/book/5cc55fa4-8ab8-4726-a802-d60fab54e65e4115-1.jpg	本书是高职教育高速铁路动车乘务专业学习教材之一，按照校企合 作原则编写。全书主要包括高速动车设备运用、高速铁路动车组旅客运 输组织、高速铁路动车服务规范等内容。每个章节下用不同的案例来实 现该课程知识目标与能力目标。本书充分体现了以项案例教学、任务驱动， 教、学、做一体、现场评价的特点，全书突出实用性与可操作性，值得 专业学习者学习，也可作铁路行业职工的培训用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	845
1304	机电一体化实训教程	978-7-5683-0715-4	\N	冯涛 	平装	1-1	16开	28.00	\N	西北农林科技大学出版社	\N	\N	\N	2020-06-01	/book/d2b63afb-346e-4433-a2aa-27d15478359c1081857.jpg	本教材是高等工科院校本科生机电一体化课程的实训教材，主要内容包括柔性制造系统、工业机器人和模块生产系统三部分。柔性制造系统部分主要介绍了基于教学实训的柔性制造系统的组成、操作等相关知识;工业机器人部分，以日本安川机器人为对象，介绍了机器人坐标系统、控制系统、示教操作和程序操作等;模块生产系统部分，主要介绍了模块生产系统的组成和各工作站的控制电路等。在此基础上，启发学生提高、改进或凝练成新的课题，达到机电综合训练的目的。本教材可供机械类专业本科生选用，也可作为相关工程技术人员的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	744
1305	小麦遗传与杂优利用研究	978-7-5683-0897-7	\N	杨天章 	0	1-1	16开	160.00	\N	西北农林科技大学出版社	\N	\N	\N	2020-11-01	/book/8070b267-13b6-45d3-a24c-09a5f7775d2c1081866.jpg	本书是根据杨天章教授所撰《凤岗回眸》(内部资料)一书中，有关学术论著的资料和索引，经过重新搜集整编，扩展而成的一本作物遗传育种专业学术论著。内容包括四个部分:第一部分，杂种小麦综述;第二部分，小麦杂优利用研究述评。是对近些年来国内外杂种小麦研究进展的点评;第三部分，国内发表论文选。收录了杨天章教授与其同事、合作者以及研究生关于小麦遗传与杂种优势利用研究方面，在国内期刊发表的重要论文选;第四部分，参加国际学术会议或在国外发表的论文选。可供农业院校师生和从事作物遗传育种工作者参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	630
1306	安南坝保护区野生动物多样性研究	978-7-5683-0861-8	\N	卜书海 	0	1-1	16开	62.00	\N	西北农林科技大学出版社	\N	\N	\N	2020-09-01	/book/05a2496a-0984-448c-9084-e833b2e536881081872.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	530
1307	赤霉素在甘蔗节间伸长上的应用研究文集	978-7-5683-0940-0	\N	吴建明 	0	1-1	16开	68.00	\N	西北农林科技大学出版社	\N	\N	\N	2021-03-01	/book/633321cb-f423-47c3-950c-690a8fc72f351081873.jpg	本书收集了作者及其研究团队十几年来在甘蔗节间伸长以及应用赤霉素调控甘蔗节间伸长方面的研究所发表的论文。文集分六部分:甘蔗茎尖组织解剖研究、赤霉素在甘蔗健康种苗上的应用、甘蔗节间生理研究、赤霉素诱导甘蔗节间伸长的生理和分子机制、赤霉素在甘蔗生产上的应用、无人机喷施赤霉素。主要以甘蔗节间伸长为研究对象，从甘蔗茎尖解剖、节间伸长的物质代谢过程、赤霉素诱导节间伸长的分子和生理机理、赤霉素应用对甘蔗品质和产量的影响、无人机喷施在甘蔗生产上的应用等进行了系统介绍。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	171
1308	菌根真菌提高杨树耐旱耐盐性	978-7-5683-0954-7	\N	唐明 	0	1-1	16开	60.00	\N	西北农林科技大学出版社	\N	\N	\N	2021-05-01	/book/86af211c-a89b-484f-81cc-b04c7bd91fc01081879.jpg	本书主要从丛枝菌根真菌与植物氮素营养、AM真菌对杨树生长、光合、水分及叶片解剖结构的影响、接种AM真菌对欧美杨107营养吸收的影响、AM真菌对欧美杨107叶片氮分配的影响、AM真菌对欧美杨107NH4+和NO3-吸收动力学的影响、速生杨生长与土壤碳氮及AM真菌分布的关系、不同氮水平下AM真菌对杨树生长和品质的影响、AM真菌对杨树光合固碳及二者间的氮/碳交换的影响、AM真菌对杨树氮吸收利用的影响机制、AM真菌对杨树-土壤微系统氮淋失的影响、结论与展望等十章进行展开论述。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	460
1310	世界经典海洋电影赏析	978-7-5670-3019-0	\N	乔洁琼 编著 	平装	1-1	16开	59.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2021-12-01	/book/e4a3d237-49d7-433a-9cb8-30be2a9d73061081900.jpg	本书是关于世界经典海洋电影的赏析读物，既可以作为一般读者了解经典海洋电影的通俗读物，也可作为影视类专业学生学习海洋电影的基本参考书。本书分为海战电影、海难电影、海洋探险、海洋动画四部分介绍国内外优秀海洋电影。本书既有对海洋电影的基本信息的呈现，又有深度阅读和相关链接，可以使读者较为全面了解海洋电影。海洋电影是海洋文化的呈现，通过赏析国内外海洋电影，可以使读者了解世界海洋文化。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	981
1311	海之秘	978-7-5670-2742-8	\N	本册主编 刘琨 	平装	1-1	16开	32.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2021-12-01	/book/e73736c2-90ef-48cd-8ae9-c4439211fbfe1081905.jpg	该书是“基础海洋特色课程汇”中科学学科教材，是基于国家教材的海洋特色教材。本书共包括14个科学小实验，如海水电池、海藻画的制作、会动的鸡蛋、易拉罐的吸引、海洋细菌知多少、牡蛎壳腔容积的测定、多彩褐藻胶的测定、海洋鱼类DNA的提取、微生物间的拮抗作用、海水中粗盐的测定、海水中悬浮体的提取、不同盐度下小鲍鱼吸附力的测定实验、海带提取碘和显微镜观察浮游生物。这些实验皆由科研专家审定并把关，可操作性强、生动、有趣，值得在海洋特色学校和普通学校中推广使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	912
1312	反贫困社会工作案例研究：协会实践	978-7-5628-6425-7	\N	向德平 主编 	平装	1-1	大32开	98.00	\N	华东理工大学出版社	\N	\N	\N	2021-07-01	/book/8c9a07fc-f58e-4f50-9e22-54082421d6981081923.jpg	本书描述中国社会工作教育协会组织高校社会工作专业参与脱贫攻坚的历程，记录中国社会工作教育参与脱贫攻坚的历史实践，呈现社会工作教育反贫困的主要做法和经验，展示社会工作教育反贫困的成就，为社会工作反贫困的理论建设和实践探索提供资料积累和经验启示。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	621
1390	邮轮旅游地理（第2版）	978-7-5637-3956-1	\N	李华 	\N	2-1	16开	38.00	\N	旅游教育出版社	\N	\N	\N	2020-01-01	/book/de26d52e-680c-434d-aacb-81a468b726f53956-1.jpg	本教材为全国邮轮专业规划教材之一，由上海海事学院经济管理系邮轮 专业教师编写。全书分为理论篇和区域篇两部分：理论篇系统介绍邮轮旅游地 理的基础知识和基本理论，内容涵盖邮轮旅游的基本概念和发展、世界邮轮旅 游市场、邮轮公司、全球邮轮港口、邮轮航线和旅游目的地以及世界邮轮建造 业的地理格局等。区域篇综合世界地理区划和全球邮轮航区特征，内容基本涵 盖了全球各区主要的邮轮旅游地理的要素，即港口、航线和旅游目的地。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	676
1398	常用中药材与中药饮片商品鉴别	9787568071413	\N	朱志国等主编 	\N	1-1	大16开	388.00	\N	华中科技大学出版社	\N	\N	\N	2021-06-01	/book/087b32a9-20b2-48f6-b339-cf23d3ee7e3d9787568071413.jpg	"专著,本书分总论和各论两部分.总论有七章.各论介绍约320种药材,含植物、动物和矿物类,每个品种的栏目有正名、别名、药材拉丁名、来源、产销、采收加工、炮制、商品特征(药材、饮片)、主要成分、鉴别、检查、含量测定、商品规格、性味功能、用量用法、贮藏、附注、参考文献等内容.本书叙述条理清晰,图文并茂,介绍的鉴别方法简便易行,实用性强.本书辅以高清晰彩图,充分体现了中药鉴定、中药商品与临床疗效对应的辨状论质原则."	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	662
1399	血液透析技术理论与应用	9787568065016	\N	应滋栋编著 	\N	1-1	大16开	128.00	\N	华中科技大学出版社	\N	\N	\N	2020-12-01	/book/352e1970-5659-49d9-a824-76e2e121c20d9787568065016.jpg	"本专著共分为9章,内容包括血液透析历史、血液透析原理、透析器、血液透析装置、水处理系统、透析液、微生物检测和控制、以可靠性为中心的维修、血透室信息化. 本书主要供血液净化临床工程技师使用,也可供血液透析治疗相关医生、护士等使用."	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	982
1400	中德双元培育老年护理人才探索与实践	9787568065214	\N	"张洪福,萨艾琪,李冬主编" 	\N	1-1	16开	68.00	\N	华中科技大学出版社	\N	\N	\N	2020-08-01	/book/aae318b0-cec8-4a6c-be66-ef813c1bafc99787568065214.jpg	"本专著为中德合作双元制老年护理专业人才培养项目的成果总结. 本书共六章,内容包括:导论,行动领域、学习领域和学习情境相关的职业教育学和护理教学法基础,利用影片、参观考察和科学研究来生成学习情境的教学案例,盘锦职业技术学院针对学习情境的开发与应用,德国护理职业教育当前面临的挑战,有关中国护理职业教育的新思考. 本书由德国专家和中国学者共同合作完成,可供老年护理方向职业教育工作者学习使用."	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	220
1401	神经内科疑难危重病临床诊疗策略	9787568071499	\N	"魏佳军,曾非主编" 	\N	1-1	16开	98.00	\N	华中科技大学出版社	\N	\N	\N	2021-05-01	/book/3f1f1c3e-87d5-4257-abff-40d167b0d6f79787568071499.jpg	"专著,本书选择临床实际的疑难危重病例,从病历资料、病因及发病机制、诊断依据及鉴别诊断、治疗医嘱、出院指导、其他知识点,以及经验与教训等方面,全面详细地分析了神经内科疑难病和危重病的全套规范化诊治过程.全书分为两篇,分别为神经内科疑难病和神经内科危重病,涉及疾病包括泛酸激酶依赖型神经退行性疾病、极后区综合征、韦尼克脑病、双侧延髓内侧梗死等."	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	425
1402	湖北省林业有害生物名录	9787568068543	\N	罗治建主编 	\N	1-1	16开	56.00	\N	华中科技大学出版社	\N	\N	\N	2021-05-01	/book/f587db5e-80d4-4beb-9f32-d854f3e75f0d9787568068543.jpg	"专著,收录了湖北省有害昆虫的真实面貌共计500余条,是湖北省记录有害昆虫的有影响力的著作.使用者可通过书中检索快捷找到有害昆虫的具体种类,分布情况,乃至生物学特征和防治方法等.此书在有害昆虫鉴别和防治方面具有较强的专业性和指导性,是湖北省林业保护工作者,林业经营公司与广大林农的应用工具书.具体包括介绍了茶树芽叶咀食性害虫、茶树吸汁性害虫、茶树枝干与茶籽钻蛀性害虫、地下害虫等百余种茶树害虫的分布、危害和形态识别,生物学特性、发生与环境的关系,虫情预测、生态控制与无公害防治."	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	657
1420	从鸦片战争到五四运动（全本）	978-7-5760-1660-4	\N	胡绳 著 	平装	1-1	16开	100.00	\N	华东师范大学出版社	\N	\N	\N	2022-02-01	/book/ba9755db-a1b7-450d-8aab-3cd4bea1579c1083403.jpg	《从鸦片战争到五四运动》以太平天国、义和团、辛亥革命这三次中国近代史上的革命高潮为中心，系统地叙述了从鸦片战争到五四运动时期的中国人民历次反封建反帝国主义侵略的斗争及奋发自强的救国运动，分析和总结了历次运动失败的原因及中国的出路、开放与自强等重大的问题，清晰地辨明了很多近代史令人困惑的问题，是研究中国近代史的经典名著。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	371
1403	安全壳过滤排放技术进展报告	9787568072601	\N	核设施安全委员会CommitteeontheSafetyofNuclearInstallations著 	\N	1-1	16开	89.80	\N	华中科技大学出版社	\N	\N	\N	2021-07-01	/book/6693852a-e4a4-484c-9084-ca57bea22aea9787568072601.jpg	"专著2011年福岛核事故发生后,对核电厂严重事故的分析及其缓解措施重新引发了业界的广泛关注.安全壳过滤排放系统作为重要的严重事故缓解措施之一,可通过过滤、排气、降压,防止安全壳发生超压失效,从而显著降低放射性物质大规模泄漏的可能性.本译著对核电厂安全壳过滤排放系统在全球主要核能国家的相关政策和应用现状进行了总结,阐述了该系统在不同国家的法规要求、操作程序和设计规范等,并详述了多种过滤排放技术的特点和优势,提供了较权威的技术资料与信息."	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	394
1404	RFID与机器人：定位、导航与控制	9787568071093	\N	"陶波,龚泽宇,吴海兵著" 	\N	1-1	16开	98.00	\N	华中科技大学出版社	\N	\N	\N	2021-06-01	/book/92416909-f552-4110-bd06-2b1232fa85c09787568071093.jpg	"本专著书以机器人化智能制造为背景,引入了RFID技术赋能机器人应用的新途径.全书系统阐述了基于RFID的位置感知技术的原理与方法,着重介绍了基于RFID相位信息的目标定位方法、RFID信息融合下的机器人自主定位技术、基于RFID相位差的移动机器人导航技术以及基于RFID相位梯度的移动机器人伺服控制技术,并结合具体实例介绍了基于RFID位置感知技术在制造业仓储管理中的应用.本书引入了RFID技术赋能机器人应用的新途径,介绍了基于RFID位置感知技术在制造业仓储管理中的应用.可作为广大工程技术人员,特别是物联网、机器人相关从业人员以及高等院校机械类、自动化类专业研究生工作与研究的参考书."	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	743
1405	液晶基多模控光成像探测	9787568037778	\N	"张新宇,佟庆,雷宇,信钊炜著" 	\N	1-1	16开	158.00	\N	华中科技大学出版社	\N	\N	\N	2021-08-01	/book/5c6a4a3b-e8db-423b-b59d-f8d4448522a79787568037778.jpg	本专著书共十二章：第一章综述了焦平面成像探测技术的发展现状和趋势；第二章讨论了电控液晶微光学结构包括微透镜阵列的基本特征；第三章分析了液晶基波前成像探测的基本属性；第四章研究了基于波前成像的景深扩展基本问题；第五章主要开展了基于波前成像的物空间深度测量方法研究；第六章论述了液晶基光场成像探测的基本属性与特征；第七章主要进行了基于电调光场成像的运动参数测量方面的关键问题；第八章主要针对液晶基光场与平面一体化成像问题开展基础性研究；第九章主要涉及红外光场成像用石墨烯基电控液晶微透镜阵列的基本特性；第十章讨论了液晶基偏振成像探测的基本属性与特征；第十一章论述了基于扭曲向列相液晶的偏振光场成像属性基本问题；第十二章主要开展了石墨烯基电控液晶微透镜与偏振光场成像方面的基础方法研究.	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	244
1406	新古典主义与浪漫主义:建筑、雕塑、绘画、素描	9787568062282	\N	"(德)罗尔夫·托曼主编,中铁二院工程集团有限公司译" 	\N	1-1	大16开	598.00	\N	华中科技大学出版社	\N	\N	\N	2020-08-01	/book/89b0253d-e8b0-4f35-ac73-50c5c27aff639787568062282.jpg	"本书综合介绍了1750年至1848年间的建筑与美术艺术,读者可以从中领会到其丰富性与多样性.并精心挑选组合了多位国外有名的专家学者的文章,从建筑与艺术的角度生动的阐述了复杂的新古典主义与浪漫主义,集中展示了新古典主义艺术与浪漫主义主潮的整体面貌,具有丰富的艺术价值和美学意义.本书脉络清晰,文字流畅,加之海量高清精美图片,真实地还原了历史遗迹的本来面貌."	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	678
1604	中国移民史	9787309152210	\N	葛剑雄 等编 	平装	1-1	16开	68.00	\N	复旦大学出版社	\N	\N	\N	2022-01-01	/book/4f485cf1-f22c-4aed-92ec-9587d0f322251084682.jpg	国家“十三五”规划重点图书 国家出版基金项目 本书研究自先秦时代至20世纪末发生在中国境内的移民历史，对各个时段主要的移民运动，一般都说明其起因、迁移对象、迁移时间、迁入地、迁出地、迁移路线及方向、定居过程和产生的影响，并尽可能作定量分析，总结其规律。 在掌握传世与出土历史文献的基础上，本书充分吸收前人的研究成果，力求最大可能地反映历史真实。全书共分七卷：第一卷为全书导论和大事年表，第二卷至第七卷分别为先秦至魏晋南北朝时期、隋唐五代时期、辽宋金元时期、明时期、清时期和清末至20世纪末的断代论述，均列有大量统计表格和地图。各卷按统一的体例撰写，但具有相对的独立性，其考证过程和编写结构因不同时期的移民情况而有各自的侧重点。 本书是目前国内外最完整、系统的中国移民通史，可供历史、人口、地理、社会、经济、文化、民族、地方史等学科的专业人员，政府有关部门，高等院校的教学和科研人员使用，也可作为相关学科研究生的教材。 第一卷 本卷为全书导论和大事年表。导论对本书所用移民的定义和涉及的时间范围与空间范围进行界定，并对中国移民史的阶段划分、历代移民的类型和特点进行了归纳和论述。此外，还从移民对中国历史重大贡献的角度阐述了研究中国移民史的意义，介绍了研究中国移民史的基本方法和手段。本卷是对移民史理论和方法论的总结，可作为中国移民史研究的重要参考书，也可作为移民史概论的教材。大事年表列出自公元前21世纪至公元2000年间可考的主要移民及有关大事，既可查对全书的内容，也可单独用作工具书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	483
1407	能源	9787568060141	\N	(巴)若泽·戈尔登贝格(JoséGoldemberg) 	\N	1-1	大32开	78.00	\N	华中科技大学出版社	\N	\N	\N	2020-05-01	/book/82fc1798-d312-40cc-b3f8-535349611f269787568060141.jpg	"从煤炭、石油、核能、地热能到太阳能和风能,毫无疑问,能源问题已成为当前人类社会面临的一项重大课题.在政策决策者、经济学家、环保人士和行业专家们考虑投资哪项先进技术,如何推广使用可再生能源,以及如何规划使用日益减少的不可再生能源的问题时,能源问题的重要性显得尤为突出.本书通过介绍世界能源系统的基础原理、问题、通过技术及非技术方案解决当前最紧迫的能源问题来帮助读者全面了解能源知识."	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	799
1408	北京西山园林研究	978-7-5618-7024-2	9787561870242	杨菁 	\N	1-1	16开	72.00	377.0千字	天津大学出版社	292	\N	\N	2021-08-01	/book/9feebb79-af78-43ab-a03c-3b836ced70d89787561870242.JPG	本书的研究对象是北京西山园林。北京西山是北京城历史悠久的名山，在地理位置、城市功能和生活联系上都与北京城紧密相连。金代“西山八大水院”的出现是西山园林建设的开始，之后西山范围内出现了皇家园林、寺庙园林、私家园林等，极大地丰富的北京城的景观和生活。本书追溯了从辽金至清末北京西山园林的历史沿革和演变过程。并以两座西山范围内规模最大的皇家园林香山静宜园和玉泉山静明园为例，分析其营造和设计意向，并对西山的寺庙园林，如碧云寺水泉院、大觉寺、潭柘寺等进了了个案研究。本书以期从宏观到细节，不仅为读者展示西山园林的具体建筑布局和历史沿革，将其放在大的历史背景和地理范围内，从西山和北京城的关系进行研究，从更广阔的视野下对西山的园林的价值进行挖掘，并且为其保护工作提供参考和借鉴。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	115
1409	KIBS企业协同能力对服务产品开发绩效的影响研究	978-7-5618-7055-6	9787561870556	王小娟 	\N	1-1	16开	50.00	293.0千字	天津大学出版社	192	\N	\N	2021-09-01	/book/82efb9ee-1012-4481-92c7-74e7abc90dbc9787561870556.JPG	本书作者立足于“KIBS企业协同能力对服务产品开发绩效的影响研究”这一核心问题，以资源依赖理论、知识观理论、企业能力理论及协同理论为基础，结合5个典型KIBS企业的探索性案例分析，构建KIBS企业协同能力对服务产品开发绩效影响的研究模型并提出研究假设；同时，通过对206家KIBS企业的问卷调查，采用探索性和验证性因子分析对KIBS企业协同能力构成维度及其对服务产品开放绩效的直接影响效应进行验证；并综合运用结构方程模型以及回归分析等方法验证了客户知识转化在KIBS企业协同能力对服务产品开发绩效的中介效应以及协同治理机制的调节效应。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	136
1410	城镇片区开发投资决策综合性咨询理论与实务	978-7-5618-7071-6	9787561870716	王廷先，徐敏 	\N	1-1	16开	80.00	423.0千字	天津大学出版社	340	\N	\N	2021-11-01	/book/39154546-dad6-4cdf-93e7-c2cb5cf53bd89787561870716.JPG	本书从城镇的发展和片区开发项目的基本理念出发，以城镇片区开发投资战略确定、发展定位、功能构建、空间布局、实施路径入手，展开对城镇片区开发项目策划咨询过程做详细分析，在此基础上结合先进的管理学理论，对城镇片区开发项目的资金解决方案、开发运作模式、体制机制策划，产业导入和城镇城市运营等方面有着系统全面的研究和描述；本书还结合源海公司自身的对于城镇片区开发项目的实践经验，阐述和分析了源海项目管理咨询公司把理论运用于实践的过程。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	963
1439	英语时文泛读(第2册)	978-7-301-14511-1	9787301145111	范守义 	\N	1	16开	36.00	220.0千字	北京大学出版社	140	7301	\N	\N	/book/37685703-489a-4d47-902a-17444c75f4191451104.jpg	本套教材是北京市精品教材立项项目，语言地道，内容新颖，题材广泛多样，贴近时代与生活，并就不同主题高不同单元，知识内容较成体系，同时练习设计全面合理，形式灵活，易于操作。本书是本套教材第二册。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	379
1411	强制性认证消防产品工厂条件典型配置汇编——建筑耐火构件产品	978-7-5618-6187-5	9787561861875	李博、李涛、 	\N	1-1	16开	30.00	156.0千字	天津大学出版社	112	\N	\N	2021-12-10	/book/449096ab-d4e0-4e23-90f9-43cd126f7d6e9787561861875.JPG	根据国家质量监督检验检疫总局、公安部、国家认证认可监督管理委员会《关于部分消防产品实施强制性产品认证的公告》（2014年第12号公告）的规定，原型式认可的多类消防产品纳入强制性产品认证目录，于2015年9月1日具体实施。一般认证模式采用产品型式试验、工厂条件检查和证后监督结合。对于申请认证的企业及工厂检查员来说，有着迫切需求了解工厂条件检查的具体要求。因此本文就建筑耐火构件产品进行了分类介绍，就工厂条件典型配置要求进行了汇总，并结合具体检查实例提供了意见，以期能为认证企业和检查员提供参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	385
1412	爱的事业——天津大学小幼医工作部及合作共建单位工作实践案例及优秀教学成果汇编	978-7-5618-6981-9	9787561869819	赵翠云等 	\N	1-1	16开	78.00	580.0千字	天津大学出版社	360	\N	\N	2021-12-22	/book/deaf0581-eb72-424d-9300-87a91e12dbbd9787561869819.JPG	《爱的事业》一书汇集了“十三五”期间小幼医工作部、附小、幼儿园、校医院及合作共建单位的优秀论文、结题报告及成功教学案例，集中展示了各部门有代表性的教育教学成果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	521
1413	嘻哈这门生意	9787564917845	\N	[美] 丹·查纳斯 著 金晓宇译 	平装	1-1	大32开	78.00	\N	河南大学出版社	\N	\N	\N	2015-06-01	/book/3818f999-05ed-4c71-ab9f-e4e7a51535831083368.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	609
1414	中华武术通史	978-7-5644-3501-1	\N	张震 	平装	1-1	16开	128.00	\N	北京体育大学出版社	\N	\N	\N	2021-12-01	/book/7622ede4-2f88-4543-874a-b65c4bb39c9c1083378.png	《中华武术通史 第一卷 商周至隋唐》以史前文化时期的武术前形态至隋唐五代多元王朝体系中的武术创造为历史区限，叙述了武术第一次从捕食和军事战争中分离出来，人文化成为集德性、审美、礼仪、教育功用为一体的人本精神载体的历史进程，呈现了为日后武术的成熟与发展奠定前提与基础的武术“元历史”阶段的文化形态。本卷共分五章，分别为第一章 史前文化时期的武术前形态、第二章 商周之际武术的滥觞与发轫、第三章 春秋战国武术文化的兴起、第四章 秦汉王朝秩序下武术的成熟、第五章 魏晋南北朝武术的多样化发展。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	699
1415	中华武术通史	978-7-5644-3505-9	\N	武冬 	平装	1-1	16开	128.00	\N	北京体育大学出版社	\N	\N	\N	2021-12-01	/book/bed06268-9060-4fd4-b85e-b54e6a5f3bef1083383.png	《中华武术通史 第五卷 中华人民共和国（下）》从1983年到2019年，简要回顾近四十年中国武术的发展历史。本卷分为四章。第一章为改革开放初期的武术事业探索。从 1983年第一届全国武术工作会议召开后到1990年武术第一次列入第11届亚运会正式比赛项目。第二章为全面深化改革的武术事业发展,从 1991 年到 1999 年。第三章为深化改革后的武术事业繁荣,从2000年到2008年，武术进一步扩大国际影响力的努力等情况。第四章为新时代中的武术繁荣,从2009年到2019年，在新时代文化强国战略下，武术管理、竞技武术、传统武术、学校武术、武术科研和武术国家化等各个方面的新变化、新进展。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	787
1416	紫云精彩	978-7-5691-0483-7	\N	杨杰　主编 	平装	1-1	32开	60.00	178.0千字	贵州大学出版社	\N	\N	\N	2022-01-01	/book/743c6290-51c9-4a47-9454-1e27aab3f2381083390.jpg	　　《紫云精彩》一书由贵州大学出版社2021年12月正式出版发行。该书是一本推介紫云自然人文美景、歌颂脱贫攻坚成果的诗歌作品集，收录了叶延滨、王久辛、郭晓晔、小语等著名诗人的诗歌作品。透过诗人温情而细腻的笔触，读者可以深刻而具体的感知脱贫攻坚以来紫云苗族布依族自治县产业发展、旅游开发、教育事业、居民生活、民族融合等发生的翻天覆地的变化，进而激发出热爱紫云、建设紫云的共识和热情。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	465
1417	中华传统文化主体精神	9787566832580	\N	王群力 刘强 	平装	1-1	16开	39.80	39.8千字	暨南大学出版社	\N	\N	\N	2021-11-01	/book/34d3b9ab-8509-457a-a11f-3a40b8f1af781083392.png	　　中华优秀传统文化，是中国特色社会主义道路开辟之“源”、拓展之“根”。本书从统一战线视角出发，希望通过对中华传统文化主体精神的阐释，揭示中华优秀传统文化在当代的价值，即走中国特色社会主义道路的原因与意义、在全面建设现代化强国事业中的作用、在构建人类命运共同体努力中的中国智慧。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	698
1418	顺然阁漫笔：远航诗文选	9787562335139	\N	黄善芳 	平装	1-1	大32开	28.00	353.0千字	华南理工大学出版社	367	\N	\N	2011-12-01	/book/077de817-f95f-4286-b8ea-ef5f9fab5dfc1083393.jpg	《顺然阁漫笔：远航诗文选》是一部文学作品集，作者是广东省作家协会会员，所收论文、散文、诗歌、小说和报告文学等大部分已在地市、省、中央各级书报刊发表过。有对朱自清先生等名家研究的学术论文；有热情歌颂改革开放的新人新事物新面貌的散文、诗歌、报告文学，有对语言、文字、写作知识的探讨，理论联系实际；有的在全国、省学术会议上的发言，引起了专家记者的焦点关注，并在报刊作了详细地报道，作者的作品曾得到张中行、魏巍、林志浩、郭风等名家的赞许，海内外发表多篇评论文章及举办研讨会，对作者的创作给予颇高评价：严谨、精炼、朴实、真挚、平易亲切、自然流畅。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	423
1423	彝族民间故事（汉英对照）	978-7-307-22671-5	\N	张永祥 选编 ；汤茜、张立玉 译；[美]H.W.Lan 审校 	平装	1-1	16开	98.00	\N	武汉大学出版社	\N	\N	\N	2021-11-01	/book/ae35ddfa-0486-4f4c-ad4f-b35c2577ff8b1083410.jpg	《彝族民间故事》为汉英对照本，收录了流传于横断山脉地区彝族的民间故事，选取其具有民族特点和代表性的内容，以讲故事的形式再现彝族民众的历史记忆、现实生活、情感表达。本书分为三大部分:"神祇和英雄";"我们的大地";"灵魂与人生"。宣扬孝悌之情、兄弟之义、爱情之美，彰显了其民族道德价值观超越超时空的意义，通过该典籍的挖掘整理，有助于彝族文化的保留和传承。该英译本由中南民族大学外语学院张立玉院长牵头，组织跨文化学科知识丰富的学者，将民族学与翻译学融会贯通，采用恰当的翻译策略，将典籍的内涵 和艺术风格较好地传递给目的语读者。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	624
1425	土木工程材料学	978-7-5641-9680-6	\N	陈先华 	平装	1-1	16开	98.00	\N	东南大学出版社	\N	\N	\N	2021-12-01	/book/95768c94-fb74-4a21-b035-a9ea6a6500731083422.jpg	本教材为东南大学规划教材，根据一流专业人才培养目标和本研一体化教学改革要求编制，面向土木工程、道路桥梁与渡河工程、建筑材料等专业的本科生和研究生。全书有九章，内容包括：材料工程应用基础、传统集料和特殊集料、石灰、石膏、硅酸盐水泥、改性水泥、普通水泥混凝土、辅助胶凝材料、高技术混凝土、聚合物混凝土、沥青、沥青混合料。本教材不仅描述材料的宏观物理力学性能，更注重细观甚至微观层面的原理性描述，在加强土木工程材料学中的基础理论、基本概念和基本测试原理的同时，还描述土木工程材料的发展演变，以及材料的实际行为及其与环境的相互作用，并融入国内外标准规范方法的对比。 本教材绘制和精选的插图多达360余幅，表格100余份，并精心设计了300余道课后习题。本书不仅是服务于一流大学卓越人才培养的教科书，亦可供交通基础设施领域的工程师和从事土木工程材料研发的技术人员学习参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	680
1429	建筑装饰构造(第二版)	978-7-301-26572-7	9787301265727	赵志文 	\N	2	16开	45.00	407.0千字	北京大学出版社	280	7301	\N	\N	/book/73c9676f-d875-4e6e-8ba3-a71252363b852657204.jpg	本书采用全新体例编写，主要内容包括：建筑装饰构造基本知识、室内楼地面、庭院地面、墙柱面、轻质隔墙与隔断、顶棚、建筑幕墙、玻璃采光顶及其他部位装饰等行业必需的装饰构造内容，每个课题均结合工程实例编写，还增加了知识链接、特别提示及推荐阅读资料等模块。 　　《建筑装饰构造》既可作为高职高专建筑装饰类相关专业教学用书，也可作为相关技术人员和专业职业资格考试的培训教材和参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	746
1430	热学	978-7-301-27019-6	9787301270196	刘玉鑫 	\N	1	16开	65.00	560.0千字	北京大学出版社	388	7301	\N	\N	/book/e215da36-1b3f-4fce-8239-8a60f215c1af2701902.jpg	本书是供物理系学生教学使用的普通物理教材，与已出版的光学，力学及计划内的电磁学选题构成一个层次的教学系列，以作者在北大物理学学院的教学经验为写作基础。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	813
1431	实用法律基础(第二版)	978-7-301-30225-5	9787301302255	韩冰 	\N	2	16开	42.00	410.0千字	北京大学出版社	264	7301	\N	\N	/book/ba24dbc1-aacc-4498-9e67-d491b6d012f73022502.jpg	本教材重点讲解非法律专业学生亟需掌握的最实用的法律基础知识，具体包括法学基础理论、宪法、行政法、刑法、民法、婚姻法与继承法、合同法、经济法、诉讼与仲裁等九个方面；在每一个部门法部分，又从最基本的概念入手，依次介绍了每一个部门法的法律原则和法律规范等。 为增加可读性，本教材章前设有案例导入和重点提示，章后设有简答题和案例分析。此外，教材中还设置了举案说法、议一议、案例讨论、法律提示、知识链接、法律词典等小栏目，既关注了近年来有重大影响的法学案例，加强与社会的联系，又使教材的内容得以延伸，体现了交互式的学习，便于学生阅读和自学。 本教材既可以作为普通高等学校和成人高等学校（法律专业除外）的公共课/通识课教材，也可以作为各类非法律专业人士学习法律基础知识的一般读物。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	859
1432	历史脉络中的收藏与鉴定	978-7-301-31441-8	9787301314418	薛龙春 	\N	1	16开	98.00	593.0千字	北京大学出版社	528	7301	\N	\N	/book/8c118e32-9fe0-4a87-8609-f35a042a50a531441.jpg	近年来，图像渐渐成为不同领域学者共同处理的材料，艺术品收藏与鉴定的历史研究也成为许多人共同关心的课题。收藏与鉴定，不仅涉及具体艺术品的甄别、传播与交易，它的装潢、包装、买卖、运输等环节，也获得不同程度的关注。无论是一件作品的递藏，还是一部书画著录，无论是个体的藏家，还是一个时期的收藏全局，其脉络与意义都须置诸具体的历史情境中加以探求与解读。惟有如此，收藏活动才能与更广泛的历史发生联系。同时，除了提供“真品”，鉴定过程中发现的“伪作”，它产生的动机与知识结构，也是理解过往人心、经验与观念的有益材料。而鉴定与收藏之间所形成的张力，还能发展出关于品味、价值观以及文化策略等方面的新议题。 2017年9月，浙江大学文化遗产研究院、艺术与考古博物馆以及亚洲文明研究中心主办“中国艺术的收藏与鉴定”工作坊，本书收入工作坊的论文及讨论，以期深化中国艺术收藏与鉴定的历史研究。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	350
1440	电子信息专业英语	978-7-301-17877-5	9787301178775	高金玉 	\N	1	16开	36.00	333.0千字	北京大学出版社	232	7301	\N	\N	/book/bbb99a16-4ffa-4e03-bd75-707246258f001787702.jpg	Part Ⅰ Electronics Unit 1 Text Electronic components Reading The Development of Electronics 。。。 Unit 12 Text Integrated Services Digital Network (ISDN) Reading Asynchronous Transfer Mode (ATM)	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	270
1433	建筑工程计量与计价（第二版）	978-7-301-32398-4	9787301323984	"吴育萍,王艳红,彭德红" 	\N	2	16开	59.00	528.0千字	北京大学出版社	356	7301	\N	\N	/book/5772a163-39fe-4097-905d-9d6999a266ca32398.jpg	本书内容共分两篇，系统讲述了建筑工程计量与计价基础知识及建筑工程的工程量清单、清单计价文件的编制。第一篇主要介绍工程造价和基本建设概述、建筑安装工程造价的组成、建筑工程造价的计价依据和计价方法，以及建筑面积的计算；第二篇主要介绍房屋建筑工程、装饰工程和措施项目的计量与计价。本书每个单元又细分了教学任务，每个任务根据学习内容设置了丰富的案例，在任务后还设置了同步测试，以加深学生对知识点的掌握。此外，书后还附有案例图纸及实际工程案例。全书从实用性出发，通俗易懂，难度适宜，便于学习。 本书可作为高职高专院校建筑工程技术专业、工程造价专业、工程监理等相关专业的教学用书，也可作为本科、中专、成人学院等相关专业的教学用书，以及工程技术人员的自学用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	474
1434	现代礼仪（第二版）	978-7-301-32631-2	9787301326312	郭学贤 	\N	2	16开	52.00	395.0千字	北京大学出版社	292	7301	\N	\N	/book/34184ae9-b7e8-4020-b7b7-c19c30aa7ca932631.jpg	本书比较系统、全面地阐述了现代礼仪形成的社会条件和发展历程，主要讲述了个人礼仪、家庭礼仪、日常交往礼仪、学校礼仪、社会交际礼仪、职场礼仪、商务礼仪、出游礼仪、涉外礼仪等内容。本书在注重总结和讲述每一项重要的礼仪知识的同时，提出了具体礼仪实训操作的基本规则，以强化学生的行为礼仪规范和提升学生的礼仪素养。本书在上一版的基础上对内容做了一些调整和修改，改掉了上一版中的一些差错，替换了一些案例、图片，并增加了一章内容（网络礼仪）。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	816
1435	记忆的话语机制与文化逻辑	978-7-301-32676-3	9787301326763	闫桢桢 	\N	1	16开	42.00	213.0千字	北京大学出版社	204	7301	\N	\N	/book/c38d1213-f8dd-471c-ac23-36b71c4fec6e32676.jpg	在“中国民族民间舞”的发生研究中，“边疆音乐舞蹈大会”是一个非常有趣的“事件”。它一方面被学界高度肯定，强调其原生性的意义，另一方面，它又被“巧妙”遗忘，诸多学者无意识地将其没入隐隐约约的宏大历史之中。这也就凸显了记忆和遗忘的辩证逻辑；记忆乃是社会性的集体工程，而遗忘却比记忆更加消耗精力和资源。本书尝试以此为切入点，回溯20世纪40年代以来，“中国民族民间舞”的发生轨迹。通过梳理“中国民族民间舞”从业群体、审美形态的发生与发展，探索这一审美符号系统生成的复杂原因与时代特性。同时，从“文化记忆”的理论视角，重审“中国民族民间舞”学科发展中有关“边疆音乐舞蹈大会”的“记忆”策略，并以此为案例，呈现“记忆”建构过程中的话语格局。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	836
1445	特殊教育学（第二版）	978-7-301-26752-3	9787301267523	雷江华，方俊明 	0	2	16开	55.00	420.0千字	北京大学出版社	296	7301	\N	2022-08-01	/book/9381b82c-029f-4e09-9f4a-fdaeaeaea4d62675202.jpg	特殊教育学是特殊教育专业学生最重要的专业基础课，对于学生特殊教育专业思想的形成以及后继课程的学习都有着重要意义。本书内容涉及特殊教育理论、体系、法规、评估、特殊教育师资、特殊儿童家长教育以及各类特殊儿童的心理与教育等。 本书可作为特殊教育专业本科生的教材，也可供广大教师和特殊教育工作者参考，还可为特殊教育需要儿童家长提供有重要价值的参考。 第二版在第一版的基础上进行了修订，更换了部分内容，增添了新近的研究成果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	451
1502	实用交际英语口语实训教程	978-7-5689-2704-8	\N	余莉 	平装	1-2	大16开	42.00	282.0千字	重庆大学出版社	123	\N	\N	2022-02-01	/book/fa29ab7c-aba0-4bc7-8bb5-bf34309e0dc01083863.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	951
1436	宏观经济学十二讲：中国情景	978-7-301-32694-7	9787301326947	"韩立岩,赵尚梅" 	\N	1	16开	79.00	593.0千字	北京大学出版社	432	7301	\N	\N	/book/8a243c6e-acfd-45b3-a124-4f1da79a08f532694.jpg	如何完善宏观经济指导、市场经济制度与交易机制？如何形成知识经济的创新能力？如何稳步地消除贫富差距，而实现社会均富？ 《宏观经济学十二讲：中国情景》是一本中级宏观经济学教材。本书结合中国社会主义市场经济建设过程中的宏观经济学理论发展，以及西方宏观经济学脉络，从国际比较的视角，系统、全面地构建了宏观经济学的知识体系与理论框架。书中凝结了两位作者数十年教学、理论研究成果，在介绍宏观经济学理论的同时，融入大量中国及其他经济体的发展实例，从实践出发辩证地解读宏观经济学理论。 本书可作为本科、硕士和MBA的宏观经济学课程教材，也是大众读者全面理解国际主流宏观经济学理论及其在中国的思辨、实践的绝佳选择。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	442
1437	从失配到适配：北京公共产品空间匹配循证分析	978-7-301-32706-7	9787301327067	陆军 等 	\N	1	16开	89.00	418.0千字	北京大学出版社	348	7301	\N	\N	/book/82a50751-88dc-42cf-bd6e-bcc9176d6e2f32706.jpg	本书以北京市为对象，从理论研究、案例解析、经验集成、策略设计与政策方案等方面，研究中国城市公共产品空间失配的现象、特征、机理和治理策略。主要内容包括如下五个部分：（一）研究导论。（二）理论基础与文献综述。系统综述欧美城市公共品空间失配的前沿成果和理论研究进展，制定研究框架与思路方法。（三）公共产品空间供给研究。从公共品供给的角度，将以北京市公园、教育、医疗、博物馆、电影院等典型公共品为对象，借助GIS空间数据处理工具和SPSS等面板数据处理工具，解析其空间的现状、特征与形成机制，进一步归纳公共产品空间分布的关键影响因子及其作用方式，进行空间配置特征测度，以形成空间规律特征研究的理论框架和实证研究基础。（四）城市公共产品供需空间适配分析。首先，通过问卷调查(questionnaire survey，QS)、获得统计数据和谷歌地图等网络搜集途径，获取一手数据资料，构建数据库。然后，在机理研究基础上，构建城市公共产品的偏好显示机制，进行需求因子筛选、总量需求与结构合理化模拟、供需失衡或空间偏离判别等，以此构建公共品需求分析框架。（五）公共产品空间失配纾解策略研究。以北京为例，参考国际上对城市公共品的供需两端调控经验，系统提出城市公共品空间失配的扭转策略、治理措施和政策建议。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	614
1438	国际关系史（近代卷）	978-7-301-10088-2	9787301100882	"方连庆,王炳元,刘金质" 	\N	1	16开	89.00	700.0千字	北京大学出版社	556	7301	\N	\N	/book/d7087c9f-b221-4fb6-bd37-6e2cf01e88c91008803.jpg	"该书为国家九五规划重点教材(三卷本)中的一卷.该书全面介绍和评述了自17世纪英国资产阶级革命和结束"三十年战争"的至十月革命和第一次世界大战结束之间的大约280年的整个近代国际关系史.资料翔实,证据充分,论证有力,是编者们长期从事国际关系史教学和研究的结晶，既可以作为高校国际关系专业的教科书，又可以作为相关研究的重要参考书和工具书。"	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	569
1441	中小学美术教学活动设计案例精选	978-7-301-20248-7	9787301202487	戴高桃 	\N	1	16开	59.00	350.0千字	北京大学出版社	268	7301	\N	\N	/book/4b0b4222-7c7e-4aeb-bf23-f0eb81c74c2b2024804.jpg	这是国内首次完成的系统而完整的新课程背景下学科教学活动设计和典型案例系列丛书，分册作者由各学科领域的权威特级教师组成，代表了国内这一领域的最高水平。 本丛书所收集的活动，不同于以往的案例，它是课堂上的一个教学环节，或是一种精心设计的导入，或是一个针对具体的学习任务而设计的小游戏……每一个活动设计都体现了以学生为主体的理念，对教师提高教学水平、活跃课堂气氛、激发学生主动合作探究等具有重要参考价值。 本丛书具有很强普适性，使用任何版本的教材教学的教师都可使用，其中所设计的活动类型多种多样，宛如一个课堂活动的"超市"，教师可以根据自己的教学需要，任意选用和组合，即便是每本书或每个设计，也没有强求体例一致，而是让每个教师鲜明的个性跃然纸上，这套丛书可以说是教师的一本非常实用的参考书。 本丛书的编写受到教育部基础司的大力支持，朱幕菊副司长作序并向全国推荐。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	278
1442	统计学实验教程	978-7-301-22450-2	9787301224502	裘雨明 	\N	1	16开	32.00	270.0千字	北京大学出版社	192	7301	\N	\N	/book/ace35aa8-5fae-4c91-8598-9d3198afea842245002.jpg	本书的核心内容是以SPSS为工具的统计方法应用，编写过程强调理论与实践并重，实验教学紧密配合理论教学，以学生主动学习和动手操作为主，摆脱理论学习与实际操作相脱节现象，增强学习兴趣，从而提高学生应用统计方法分析和解决实际问题的能力。本书每个实验之后都附有数据，供学生巩固相关的SPSS操作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	270
1443	AutoCAD建筑绘图教程(第2版)	978-7-301-24540-8	9787301245408	唐英敏，吴志刚，李翔 	\N	2	16开	54.00	504.0千字	北京大学出版社	344	7301	\N	\N	/book/a0575ad9-27ce-47c1-951e-e71e127e261d2454002.jpg	本书共12章，主要包括： AutoCAD 2013基础知识、 绘图环境设置 、绘制平面图形、编辑平面图形 、 图形注释与表格、辅助绘图命令与工具、 尺寸标注 、图纸布局与打印输出、 绘制建筑施工图 、 天正建筑概述、 利用Tarch绘制建筑平面图和利用Tarch绘制建筑立面图、剖面图 。本书集聚多年参与工程设计的经验，教材符合高职高专学生的认知规律和计算机辅助建筑设计的一般规律，在教材处理上应用任务驱动型实例教学法，采用先进的行动导向教学理念，突出重点，分散难点，顾及整体，分层要求，辅以课件，有利于建立以学生为主体的学习模式。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	505
1446	市场调查与统计（第2版）	978-7-301-28116-1	9787301281161	陈惠源 	\N	2	16开	38.00	292.0千字	北京大学出版社	200	7301	\N	\N	/book/949ae1c9-c9a4-477a-8560-7ea498b7ca892811602.jpg	本书编写以市场调查岗位的工作任务和职业能力分析为依据，以市场调查程序性的工作任务为线索。全书共7个项目，用一个具有启发性的任务贯穿全书，对市场调查的各个流程环节进行详细介绍，包括确立市场调查主题，设计调查方案，设计问卷调查，收集资料，整理与分析市场调查资料，分析、预测市场发展趋势、撰写市场调查报告。在调查与统计工具的选择上，本书以Excel2003为基本工具，简洁易懂，方便实用，而且每个项目的能力训练模块已经被教学实践反复验证，极具可操作性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	551
1447	应用统计学（第3版）	978-7-301-28988-4	9787301289884	王淑芬 	\N	3	16开	68.00	600.0千字	北京大学出版社	412	7301	\N	\N	/book/52e82cd2-3481-4ea2-b2ef-2112ab03493d2898802.jpg	本书是一部以IBM SPSS 22.0为分析工具的实用性很强的“互联网+”统计学教材。基本内容包括：统计数据的收集整理与显示、统计数据的特征描述、统计假设检验、相关与回归分析、聚类分析、主成分与因子分析、对应分析，其中包括近年来的一些较新进展。本书以提高读者运用统计方法分析解决实际问题的能力为目的，以“大数据”、“大统计”为背景，在总结教学经验的基础上，补充案例并更新案例数据。书中内容深入浅出，侧重理论知识与技能训练相结合，通过插入大量的二维码资料激发读者的学习兴趣、强化学习效果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	768
1448	建筑工程制图与识图（第三版）	978-7-301-30618-5	9787301306185	白丽红，闫小春 	\N	3	16开	42.00	399.0千字	北京大学出版社	272	7301	\N	\N	/book/0d9011f5-c11b-4371-9dde-102d7e1020f93061802.jpg	本书以应用为目的，以必需、够用为原则，精简画法几何内容，增强专业施工图的内容。为在有限的时间内把需要的知识和技能传授给学生，同时也便于学生抓住重点、提高学习效率，教材在章首列有教学目的和教学要求，配有单独成册习题集，其上有形式各异的练习题目，题目编写采取由浅入深、读画结合、多次反复、循序渐进的方法，力求达到学的容易、教的轻松的目的。本书主要内容包括：绪论；第1章 制图的基本知识与技能；第2章 投影的基本知识；第3章 点、直线、平面的投影；第4章 基本形体的投影；第5章 组合体的投影；第6章 轴测投影；第7章 剖面图与断面图；第8章 建筑工程图的一般知识；第9章 建筑施工图；第10章 结构施工图；附录 综合实训施工图。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	467
1449	建筑构造（第三版）（活页式）	978-7-301-31786-0	9787301317860	肖芳 	\N	3	16开	52.00	462.0千字	北京大学出版社	308	7301	\N	\N	/book/9c817134-5923-4d7c-9560-fc93a8a513cd3178602.jpg	本书根据建筑行业对高职高专层次建筑技术人才的要求，结合大量建筑实例，反映现代建筑构造的新动态和新做法，并根据我国建筑业的现行标准和规范，运用简练的文字、真实的建筑实例、翔实的内容阐述了民用建筑的构造方法、构造做法，着重对学生进行基本知识的传授和基本技能的培养。同时通过AR增强现实技术，以“互联网＋”教材的思路，通过“巧课力”APP客户端，应用 3ds Max 和 BIM 等多种工具，对书中的平面图形进行了三维模型的构建，并采用在线答题的形式对复习思考题进行了扩展，使读者对于“建筑构造”课程的学习不仅仅局限于教材，还有了更形象、直观的认识和了解。 本书共分为11个模块，主要内容包括绪论、民用建筑构造概述、基础与地下室、墙体、楼地层、楼梯与电梯、屋顶、门窗、变形缝、课程实训任务与指导、装配式建筑概述，除模块9课程实训任务与指导外，每个模块后面都有模块小结和复习思考题。 本书可作为高职高专院校、高等学校专科、成人教育学院等建筑工程类专业的教材和教学参考书，也可供从事土木建筑设计和施工的人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	670
1450	汪星撞足球：1.校园足球集结号	978-7-301-32198-0	9787301321980	全国青少年校园足球工作领导小组办公室 	\N	1	16开	36.00	77.0千字	北京大学出版社	104	7301	\N	\N	/book/dd4574cb-a2ba-4f67-95ce-e0c40daf18d232198.jpg	在遥远的动物星系，那里充满爱与和平，焦点的对抗就是星系每年举办的校园足球联赛。其中，汪星球和猫星球的对抗赛是万众瞩目的焦点。不幸的是，汪星队已99年不胜猫爪队。新一届的校园足球联赛也要开始了，能否改写历史，每一个汪星人都充满期待。 作为汪星球最有潜力的新人汪星星在教练雪长老的感召下，开始寻找一个个身怀绝技的新队员。五名小伙伴因共同的足球爱好凝聚，在磨合的过程中，有欢乐、有挫折、有热血，最终形成一支默契的校园足球队，踏上了逐梦之路。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	931
1451	行政法与行政诉讼法图释	978-7-301-32418-9	9787301324189	"黄辉,马琳昆" 	\N	1	16开	49.00	246.0千字	北京大学出版社	196	7301	\N	\N	/book/fa7cf875-3b58-4e90-8cfc-d0ebb400a3e932418.jpg	系编者长期教学改革实践的总结，主要体现了如下特点： 第一，结构分层，知识内容体系化。按照重点、难点、考点等标准对行政法与行政诉讼法的知识体系进行系统整理，使得整体知识结构重点突出。 第二，图表浓缩，知识内容系统化。将课程的核心要素以大量的图表方式来进行呈现，力求做到有图有真相、有表有事实，浓缩的才是精华。 第三，图解法条，知识内容明朗化。对行政法与行政诉讼法的相关法律法规进行图解，突出体系化和立体化，以理论知识与实践案例相结合的形式展现行政法与行政诉讼法的基本原理和基本制度。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	942
1452	在线教育全景解析：行业、合规、监管与案例精选	978-7-301-32468-4	9787301324684	"何周,徐进" 	\N	1	16开	68.00	362.0千字	北京大学出版社	304	7301	\N	\N	/book/970a137f-18a6-4a78-82f9-9fc2837f942c32468.jpg	2019年7月12日，教育部等六部门发布《关于规范校外线上培训的实施意见》，标志着在线教育的监管终于落地，行业即将进入合规运行时代。本书正是在这样的背景下应运而生。《在线教育全景解析：行业、合规、监管与案例精选》共分为六章，分别为在线教育概述、发展历程与宏观环境，在线教育的市场现状与行业概览，在线教育的商业模式与盈利模式，在线教育的细分领域与热门赛道，在线教育经营合规监管，在线教育机构精选案例。精选案例部分选取了12个具有代表性的在线教育机构，如新东方在线、沪江网、51 Talk、学而思网校、网易云课堂等，从公司成立与发展历程、商业模式与主要产品、竞争优势与风险分析等方面展开阐述。《在线教育全景解析：行业、合规、监管与案例精选》的出版对于我国在线教育的规范化具有一定的理论和实践参考价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	636
1453	权变型家庭：中国农村家庭的结构流变与伦理实践	978-7-301-32552-0	9787301325520	王欣 	\N	1	16开	69.00	244.0千字	北京大学出版社	336	7301	\N	\N	/book/f992af55-ae40-478e-8102-94846d305b9c32552.jpg	家庭的现代化变迁既关系到国家的稳定，更关乎每个个体。随着社会的转型，中国农村地区的家庭发生了重大变化，代际之间、夫妻之间的结构时分时合，不完整性凸显。本书将管理学的“权变”思想引入农村家庭领域，提出一种新的理解当代农村家庭变迁的视角，试图从动态实践的家庭结构与伦理关系中寻找新的家庭平衡与秩序点。全书分为八章，包括个体婚嫁与家庭谋略、家庭经济与权力的分配和演变、时分时合的生活模式、个体与家庭的结构变动，以及城市化对农村家庭的冲击等，透过微小的家庭单元，在日常生活实践中分析和探讨当代农村家庭以怎样的形态和路径延续着传统的功能和现代的需求，并试图回答处于现代化进程中的农村家庭正以什么样的行动逻辑走向新时代，其强大的动力、顽强的韧性和现实的困境又是什么，由此找寻当代中国农村家庭变迁的主要经脉，以便深刻地理解并积极地建设好自己的家园。本书是国家社科基金青年项目“农村家庭结构权变及家庭政策创新研究”的最终成果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	292
1454	中国商事仲裁与调解百问	978-7-301-32637-4	9787301326374	沈四宝 张丽霞 田锐华 主编 	0	1	16开	88.00	396.0千字	北京大学出版社	488	7301	\N	2021-12-28	/book/b9f39d6d-5f13-498d-b8b3-c36da320443232637.jpg	本书按照商事仲裁的整个程序进展过程，分为十五章共109个问题，将商事仲裁的特点与优势、商事仲裁机构、商事仲裁协议、仲裁申请、仲裁管辖的异议和救济、仲裁员的选择及仲裁庭的组成、仲裁答辩和反请求应当注意的问题、仲裁审理、仲裁与调解相结合、仲裁裁决、仲裁费用、仲裁裁决的执行、仲裁裁决的异议、境内外商事仲裁、互联网仲裁等，这些商事仲裁和调解业务中最核心、最关键、最基本的内容，以问题和答复的形式，把该领域中最实务的操作建议、相关法律和仲裁规则规定、典型案例、实务难点等内容，结合作者们丰富而深入的实务经验进行深度解析后，介绍给公司法务、律师及其他对仲裁业务感兴趣的人士，具有直接的仲裁实务指导意义和参考价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	574
1455	土建工程制图（第3版）	978-7-301-32692-3	9787301326923	"张黎骅，邹祖银,鲍安红" 	\N	3	16开	65.00	513.0千字	北京大学出版社	344	7301	\N	\N	/book/5d046f62-65be-403b-853c-0d6d0089ecda32692.jpg	“土建工程制图”作为土建类专业工程技术人员必须掌握的技术语言，是土建类学科的一门技术基础课程。本书是按现行有关房屋建筑制图的国家标准，结合近几年教学改革的经验，并参考国内外同类教材编写而成的。本书以土建工程图样的绘制和识读为主线，深入浅出地介绍了工程图样绘制和识读的基本方法及理论，以帮助读者学会工程图样的绘制和阅读。 本书共13 章，主要内容有制图基本知识与技能，正投影基础，立体投影，轴测投影，组合体的三面投影图，标高投影，工程形体的图样画法，建筑施工图，结构施工图，建筑设备图，水利工程图，道路、桥梁、涵洞、隧道工程图及计算机辅助绘图基础。 本书适合作为高等学校土建、水利类各本科专业工程制图课程的教材，也可作为其他类型学校相关专业本、专科学生的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	852
1525	新学衡：新文化运动的异途	978-7-305-25006-4	\N	"朱庆葆,孙江" 	\N	1-1	大16开	50.00	306.0千字	南京大学出版社	204	\N	40	2021-11-30	/book/b08bc566-1e3b-4058-8280-29ac6bd9d38f9787305250064.png	本书继袭南京大学历史上学衡派“论究学术，阐求真理，昌明国粹，融化新知”的宗旨，探究“新文化运动的异途”。本书主要有以下几个栏目：（1）特邀演讲、（2）学衡故事、（3）中西文化、（4）世纪回眸、（5）南雍艺海、（6）学林回声。各栏目分别收集相关学者的论文、研究和讲演等，汇集成册，力求从多方面、多角度，生动展示当今时代融会东西的学术研究视野和研究成果，彰显学术风范，博采众家之长，是学衡派精神的延续和深化。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	418
1469	新版剑桥PET考试·手写体标准字帖：核心词汇+写作范文（赠临摹纸与音频）	978-7-5628-6480-6	\N	剑桥KET/PET考试研究中心 	\N	1-1	\N	25.80	63.0千字	华东理工大学出版社	84	\N	\N	\N	/book/49b6fb93-81d6-4484-8f79-6d80361d3f76562864806.jpg	剑桥PET考试于2020年迎来改革。针对KET年龄段考生的学习习惯，字帖符合考生需求，也贴合纸笔考试的要求。《新版剑桥PET考试·手写体标准字帖：核心词汇+写作范文（赠临摹纸与音频）》一书的内容是核心词汇+写作范文，采用最受欢迎的应考字体衡水体，另外赠送音频和临摹纸。核心词汇精选改革后最新词表的词汇，以主题分类的形式提供高频词汇，让考生在临摹中记忆单词。写作范文为改革后新的写作试题范文，帮助考生练习写作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	856
1456	“对赌协议”典型仲裁案例与实务精要	978-7-301-32732-6	9787301327326	深圳国际仲裁院 中国国际仲裁研究院 编著 	0	1	16开	88.00	527.0千字	北京大学出版社	484	7301	\N	2021-12-27	/book/2de8a991-8152-46c8-940b-e072a9a1a44b32732.jpg	深圳国际仲裁院长期身处资本市场争议解决前沿，迄今为止已经处理了大量对赌协议纠纷案件。为帮助业界了解对赌协议纠纷在仲裁领域的裁判动向，弥补现有讨论的不足，深圳国际仲裁院系统梳理和筛选了近年来有代表性的案例，在脱密处理的前提下，组织学者和实务专家结合《民法典》《全国法院民商事审判工作会议纪要》等相关规定进行了有针对性的评析。希冀通过这本典型仲裁案例选编，勾画出对赌协议纠纷在仲裁领域的裁判全景，为业界提供有价值的参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	732
1811	热力学与统计物理	978-7-301-32855-2	9787301328552	刘川 	\N	1	16开	46.00	312.0千字	北京大学出版社	248	7301	\N	2022-03-08	/book/f6495ea8-8f9a-4575-b9fd-107ae79ac9fb32855.jpg	本书是热力学与统计物理课程教材。主要内容包括热力学和统计物理两大部分。在热力学部分，本书全面回顾了热力学的基础知识，包括平衡态和态变量的定义、热力学三定律、热力学基本微分方程、单元复相系和多元系的平衡等。在统计物理部分，本书系统展开了统计物理的基本图像和方法，包括统计系综的意义、近独立子系、量子理想气体、经典流体、二级相变、平均场理论等。最后，本书还简要介绍了非平衡态统计。本书的主要特点是在统计物理部分直接由系综理论入手，这样有利于读者尽快建立现代统计物理思维。 本书适合作为物理专业教材，也可供化学等相关专业师生参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	287
1457	全球金融治理困境及其破解	978-7-301-32735-7	9787301327357	李国安 	\N	1	16开	66.00	280.0千字	北京大学出版社	312	7301	\N	\N	/book/e81d84ea-8c1b-4f5e-9dec-bc1811b5cd0032735.jpg	2008年全球金融危机爆发至今已逾十数载，关于金融风险和金融危机及其防范的著述汗牛充栋。本书以全球金融治理为切入点，在剖析现行全球金融治理体制困境及其根源的基础上，尝试从国际政治和国际法律的视角探寻破解和解决全球金融治理困境的可行路径和对策。 本书共分八章。第一章主要探讨当前全球金融治理存在的诸多困境，包括金融全球化与金融监管国内化之间冲突的困境、全球金融治理主体碎片化困境、全球金融治理规则碎片化困境以及全球金融治理体制中的不公平困境，进而剖析困境背后之根源，并从宏观视角提出可资借鉴的解决思路。第二章主要分析新兴经济体的崛起对全球金融治理的影响，介绍新兴经济体的崛起与新型国际货币金融体系，剖析新型国际货币金融体系对稳定国际货币金融秩序的贡献和局限性。第三章主要研究国际金融治理理念，指出现行国际金融治理机制代表性和有效性不足的困境。在此基础上，提出全球金融秩序稳定与金融利益共享的新治理理念，倡议互利共赢和全球合作的价值观。第四章主要探析现行国际货币体制的弊端，包括大国对多边主义的操纵和负面影响、IMF作用的弱化、国际货币秩序区域化与分散化、国际货币关系的高端政治特性与当代国际经济关系社会化的矛盾等。第五章在剖析现行全球金融治理体制存在的不公平性、缺乏合法性与透明度等缺陷的基础上，提出构建“多元一体”的全球金融治理新体制的思路，特别是中国作为崛起中的负责任大国，应担负起构建全球金融治理新体制的历史使命，凝聚发展中国家的合力，为发展中国家争得应有的国际金融权益。第六章主要探讨全球金融治理视角下的系统重要性金融机构监管。第七章借鉴全球金融市场顺周期性理论，考察了全球各主要国家实施逆周期监管的实践。第八章集中讨论国际金融治理体制中的硬法与软法及其实施问题，提出构建国际金融硬法与软法协同的治理体系，强调巴塞尔银行监管协议等软法性国际规则在全球金融治理中的重要作用。同时，在全球金融治理规则执行方面，提出构建全球金融治理软法规则的法律位阶和法律执行评估机制，形成与硬法的“遵守”不同的主动执行理念。 本书尝试凝聚多元化的治理主体和治理法制的合力，构建“多元一体”的全球金融治理体系，以期形成一个维系全球金融秩序长期稳定的长效治理机制。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	487
1458	元宇宙：图说元宇宙	978-7-301-32780-7	9787301327807	子弥实验室 2140 著 	0	1	16开	99.00	290.0千字	北京大学出版社	408	7301	\N	2022-01-10	/book/cc7b90e0-fa61-44b4-8ece-7c003c686ad91083605.jpg	2021年是元宇宙的元年。元宇宙的内涵是吸纳了信息革命（5G/6G)、互联网革命（Web 3.0）、人工智能革命，以及VR、AR、MR，特别是虚拟现实技术革命的成果，引发了信息科学、量子科学和生命科学的互动，向人类展现出构建与传统物理世界平行的全息数字世界的可能性。全书共6章：一、什么是元宇宙；二、元宇宙的技术基础；三、元宇宙与通证；四、元宇宙的价值链；五、元宇宙与“第三空间”；六、元宇宙：下一代互联网的新形态等。 本书适合对元宇宙及下一代互联网感兴趣的读者阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	628
1459	社会工作督导：选拔、培养、使用、激励——本土化探索的地方性实践	978-7-5628-6071-6	\N	王瑞鸿 	\N	1-1	\N	98.00	212.0千字	华东理工大学出版社	300	\N	\N	\N	/book/ef6fda95-ebb5-47cd-868c-986e11f312ff562860716.jpg	督导是社会工作专业的一种高级服务方法，是社会工作专业发展到高级水平的一种象征，也是推动社会工作高级人才队伍建设的重要举措。上海浦东新区社会工作协会在社会工作实践方面起步较早，督导方面的探索更是成果颇丰。本书主要以浦东新区社会工作协会在督导方面的创新为例，按照选拔、培养、使用、激励、成效等内容进行编写，汇集了浦东新区社会工作协会大量的生动案例以及更多具有操作性的实施细则，本书兼顾了理论性与实践性、本土性与国际性，适合一线社会工作者、社工机构管理人员以及党和政府相关部门负责人等有志于社会工作服务和社会治理创新的人阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	855
1460	漫画图解——超好记超好用小学英语国际音标	978-7-5628-6385-4	\N	柳珍妮 	\N	1-1	\N	32.00	152.0千字	华东理工大学出版社	164	\N	\N	\N	/book/b390e083-aed2-4a40-8ab8-a92e2313da54562863854.jpg	本书系统讲解小学英语国际音标，通过易混音标对比讲解的模式，漫画图解重难点，便于学生轻松学习、透彻掌握。本书特色在于：1. 图解发音要领、单词、例句和会话，学习不枯燥。2. 讲解丰富，除了发音要领外，特别指出发音需要注意的事项。3. 实操性强，侧重拼读的操练，同时配备练习，及时巩固音标学习效果。4. 赠品丰富，赠送小学英语课标词汇表和音标速查表。5. 外教朗读全书，在每单元设置二维码，扫一扫，就可以跟读学习，非常便捷。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	822
1461	中海自贸区贸易效应研究	978-7-5628-6422-6	\N	姚磊 	\N	1-1	\N	96.00	218.0千字	华东理工大学出版社	250	\N	\N	\N	/book/96c90162-8df2-45a9-b12c-5aae7c25aaa3562864226.jpg	本书的研究主题为中海（中国、海湾阿拉伯国家合作委员会）自贸区贸易效应，旨在从经济学视角探究中海自贸区的现实意义和深远影响。其一，分析建立中海自贸区的经济基础，挖掘双方的比较优势和竞争优势。经研究发现，中海双方建立自贸区的经济基础较好，各自具有较为明显的优势产业，互补性较强，以产业间贸易为主体。其二，估算中海自贸区贸易潜力，模拟分析中海自贸区贸易效应，对动态效应和非传统收益进行深入探讨。经研究发现，中海自贸区的建立将释放一定的双边贸易潜力，而动态效应和非传统收益则成为重中之重。其三，全面阐述中海自贸区贸易效应影响因素，进一步提出推进中海自贸区建设的策略建议。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	762
1683	对口升学考试汽车专业技能考试指导	978-7-5689-2896-0	\N	谭晟 	0	1-3	16开	25.00	191.0千字	重庆大学出版社	121	\N	\N	2021-08-23	/book/b3c38965-7f5f-4f33-b6fe-14b9ffdd5b9e1085431.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	850
1470	新编日语教程1.辅导用书（高考适用版.赠音频）	978-7-5628-6481-3	\N	许纬 	\N	1-1	\N	56.80	599.0千字	华东理工大学出版社	288	\N	\N	\N	/book/108e4c5e-ae8d-43e9-be8c-719a8a0f8848562864813.jpg	"本书为新编日语教程1的配套教学参考资料，帮助参加高考的考生自学日语，供教师备课使用，也可供自学者结合教材使用，帮助高考学生更好地吸收教材知识。编排上采取与教材同步、一课一练的原则。在提取和总结教材中的重要知识点的基础上进行出题,教材中侧重高考的重点单词和语法句型都将在本书中得到体现。本书除了课文分析外，还有贴近高考形式的一些新题型,如增加了听力练习，总体来说，其内容充实,形式新颖。最后还有关于日本文化常识。帮助高考考生更好完成文化常识相关题目。"	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	518
1817	全能手绘效果图技法	978-7-5669-1993-9	\N	吴晨荣 吴祉安 编著 	平装	1-1	16开	59.00	\N	东华大学出版社	\N	\N	\N	2022-04-01	/book/ec84ede1-26b1-41bf-a5be-88348d5727c61086298.jpg	　本书以环境艺术设计教学大纲为目标，图文并茂，结合社会实际对课程知识与技能的要求而编写的，因此，具有知识内容（理论与实践）的丰富性、完整性与系统性，同时本书教学目标具体明确，针对性强，内容具有典型性与时代性。 　　手绘效果图技能是环境设计工作者必备的专业技能，而一部知识点内容完整，掌握技法针对性强的教学工具书应该是非常需要的。相较于同类技法书籍，本书的知识性、针对性与系统性更强些，更具有学术价值与社会价值。同时图文并茂与厚薄适当更利于阅读与降低成本。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	760
1462	初中文言文全解与精练（赠朗诵音频）（八年级）（上册+下册）	978-7-5628-6428-8	\N	项晓红 	\N	1-1	\N	49.80	408.0千字	华东理工大学出版社	132	\N	\N	\N	/book/31a5149f-4a9b-479f-9c88-aa9a97c3d809562864288.jpg	《初中文言文全解全译（赠朗诵音频）》是对部编版初中语文新教材中出现的所有文言文和古诗词进行了详解，每篇文言文和古诗词包括朗读音频、漫画导入、作家作品、全文翻译、作品赏析、知识梳理、课后练习七大版块。“朗读音频”帮助学生读准字音，读对节奏，助力培养文言语感；“漫画导入”用好玩有趣的漫画把文章或诗词的主要内容展现出来，激发学生学习的兴趣；“作家作品”部分为学生提供完整的作家介绍和作品写作背景，便于学生从宏观上把握文章；“全文翻译”部分以原文、注释、翻译对应的形式呈现，对课文进行逐词逐句对照翻译，对重点字、词、句进行详细注解，译文以直译为主，意译为辅； “作品赏析”部分对文章的主旨和写作手法进行详细地鉴赏和分析，便于读者从整体上理解文章；“知识梳理”部分全面总结梳理文中出现的知识点，供学生日常积累和考试复习时参考；“课后练习”部分精选不同省市的中考真题，强化训练，在平时的学习中就能零距离接触中考的内容，从而把握中考的命题规律和方向。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	519
1463	英文原版[迪士尼]经典童话.灰姑娘（赠英文音频、电子书及新课标词汇讲解）	978-7-5628-6436-3	\N	青橙英语 	\N	1-1	\N	29.80	73.0千字	华东理工大学出版社	128	\N	\N	\N	/book/23bbe31e-068e-41ce-965a-5fc942c3ac87562864363.jpg	本书为针对小学高年级以及初中低年级的孩子的英语读物，讲述了在灰姑娘的妈妈尚未去世前，灰姑娘一家的幸福的生活。仲夏节快到了，年幼的灰姑娘在梦想着什么呢？我们一起来看看吧！本书标注了不同级别课标词以及不需要掌握的词汇，增加长难句解析及重点语法点讲解，以脚注的形式呈现，以辅助阅读；同时还配有少量图片，以图呈现文字所描述的内容，加强理解，缓解视觉疲劳。最后本书还赠送青橙资源包，包含配套音频、词汇讲解、电子书等内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	956
1464	计时练：小学数学10分钟课课练（6年级下）	978-7-5628-6453-0	\N	洪劲松 	\N	1-1	\N	22.80	144.0千字	华东理工大学出版社	112	\N	\N	\N	/book/d24aa277-1447-44a6-a218-ef12c506b87b562864530.jpg	本书同步人教版教材，每个年级分上下册，本书为下册。作者在深入研究教材重难点的基础上，全面梳理和深入剖析小学数学考试中的考点，并结合多年教学经验编制题目，着力夯实基础，提高数学的解决能力。针对学生课内的课程进度，本书设置每天一页同步训练，每页的训练时间为10分钟，短时高效。在题型设置上以选择、连线、判断、计算、应用等为主，且每天训练的题型不确定，根据每天训练的内容灵活选择合适的题型。在内容上，有针对每一课的训练，也有针对单元、期中考试、期末考试的训练。且可操作性强，学生每节课后可以及时训练这节课的知识点，也可用于课前预习。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	355
1465	高考日语阅读训练	978-7-5628-6460-8	\N	全国中等日语研究会 	\N	1-1	\N	45.00	265.0千字	华东理工大学出版社	160	\N	\N	\N	/book/dd3d2591-b01b-42ab-bce4-67234ae650d5562864608.jpg	本书是针对高中学生所编写的高考日语考试复习和参考用书。为了帮助广大高三学生顺利通过高考日语考试，本书在新课标和考试真题的基础上精心编写了高考日语阅读题的解题方法和攻略，并配有大量练习题。通过本书的学习，考生可以对考试的题型与内容有更清晰的认识和了解，并很好地把握考试的动向，在复习、备考的过程中更加有针对性。本书分为高考阅读题的基本介绍、阅读题的常见题型与主题的分析、实战演练等几部分，并附有练习题的答案和解析，帮助学生熟悉高考题型，掌握答题技巧，在高考中取得好成绩。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	653
1603	新理念雅思口语教程	978-7-5693-2344-3	\N	钱希 主编 	平装	1-1	16开	58.00	\N	西安交通大学出版社	\N	\N	\N	2022-02-01	/book/83b8a645-7053-4895-b556-284d1336cb581084674.jpg	《新理念雅思口语教程》以主题内容为依托，以口语技能为主线，秉持“以听促说、以读促说、以思促说、以评促说”的原则，将口语作为主要突破口用以提升学生的英语综合能力、思辨能力及用英语讲述中国故事的能力，为其今后的专业深造、职业发展及国际交流提供有效支撑。 本书适合备考雅思的各类考生，也适合希望提升英语口语综合表达能力和思辨能力的高中生、本科生及英语口语基础薄弱的研究生。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	898
1466	新版剑桥PET考试.写作高分范文.剑桥通用五级考试B1	978-7-5628-6465-3	\N	金利 	\N	1-1	\N	36.80	193.0千字	华东理工大学出版社	128	\N	\N	\N	/book/d6c700fb-c975-4eb6-a49e-d219527caaab562864653.jpg	B1 Preliminary（原PET），是剑桥通用英语考试第二级，属于剑桥英语证书。该考试考察听、说、读、写四个方面的英语技能。获得B1 Preliminary证书的考生已经掌握基础的英语知识，并具备日常生活所需的实用英语技能。为了确保考试与语言学习和教学方面的最新研究同步，剑桥考试官方委员会对考试定期进行更新。新的考试形式将从2020年1月开始使用。通过对2020版新考试写作内容的研究，本书将针对新版考试，在写作方面给考生提供备考指导，帮助考生更好地适应新版考试。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	194
1467	青橙英语分级读物.花木兰:赛龙舟(第3级	978-7-5628-6473-8	\N	迪士尼 	\N	1-1	\N	19.80	10.0千字	华东理工大学出版社	36	\N	\N	\N	/book/029e8e94-ca29-462b-ba0f-05f5aef8569a562864738.jpg	《迪士尼公主探索世界英文故事.花木兰 赛龙舟》是专为女孩打造的迪士尼英文故事，适合6-10岁小学生阅读。小读者可跟着花木兰学会永不放弃。故事原版引进，语言纯正，配有手绘大幅插图，可激发学生的阅读兴趣。本书专为小学生研发，严格控制词汇量、句子长度和语法难度。设置课标词、拓展词和句型讲解，帮助学生扫除阅读障碍。随书附赠双语电子书，不限时间地点，想读就读。书中设有二维码，读者可以扫码获取英文音频和中文参考译文。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	117
1468	新编日语教程2.辅导用书（高考适用版.赠音频）	978-7-5628-6478-3	\N	许纬 	\N	1-1	\N	56.80	580.0千字	华东理工大学出版社	288	\N	\N	\N	/book/f13e64e5-b8fa-4a5b-8e19-1f46e5b9297d562864783.jpg	"本书为新编日语教程2的配套教学参考资料，帮助参加高考的考生自学日语，供教师备课使用，也可供自学者结合教材使用，帮助高考学生更好地吸收教材知识。编排上采取与教材同步、一课一练的原则。在提取和总结教材中的重要知识点的基础上进行出题,教材中侧重高考的重点单词和语法句型都将在本书中得到体现。本书除了课文分析外，还有贴近高考形式的一些新题型,如增加了听力练习，总体来说，其内容充实,形式新颖。最后还有关于日本文化常识。帮助高考考生更好完成文化常识相关题目。"	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	257
1471	青橙英语分级读物.冰雪奇缘2(第8级	978-7-5628-6348-9	\N	青橙英语 	\N	1-1	\N	39.80	223.0千字	华东理工大学出版社	160	\N	\N	\N	/book/f2290303-c9cf-4c9c-9271-418af4f44b20562863489.jpg	本书旨在让初二学生在阅读经典迪士尼电影小说的同时，根据对故事的兴趣，将这种兴趣转化成对英语知识学习的动力。英文阅读的文本讲述了艾莎为了追寻真相，义无反顾踏上了征途。安娜和雪宝、克斯托夫也紧紧跟随。在那座常年被浓雾所笼罩的森林里，不仅藏着神秘的自然力量，更隐藏着关于阿伦戴尔王国、艾莎的魔法来源等一系列秘密。随书附赠的精讲课程可以帮助读者直观感受英文句子和段落的结构，体验英文思维。学习生词和句型、分析长难句、理清段落与篇章逻辑关系等，练好阅读的基本功。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	966
1472	周计划：小学英语阅读强化训练（二年级）（赠MP3下载	978-7-5628-6393-9	\N	刘弢 	\N	1-1	\N	22.00	152.0千字	华东理工大学出版社	116	\N	\N	\N	/book/e498185b-e619-4145-8f25-584ec3d3370b562863939.jpg	本书精选100篇小学英语阅读文章，选文经典，所有篇目均选自引进版阅读材料、重点初中招生试题和小学英语竞赛试题。采用周计划的模式，共20周，一周之内每天读一篇，题量不大便于坚持，以达到循序渐进的目的。丛书从一、二年级到六年级难度逐步加升，让阅读者的英语水平在不知不觉中提高。生词注释和例句突出重点，便于完全掌握关键词汇。提供全文翻译，彻底解决读不懂、读不透、练习做了很多可水平提升缓慢的问题。此外，本书附赠MP3下载，并设置二维码方便读者随扫随听。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	840
1473	社会工作实务（初级）真题详解	978-7-5628-6502-5	\N	刘斌志 	\N	1-1	\N	42.80	324.0千字	华东理工大学出版社	220	\N	\N	\N	/book/588e2f6e-a078-4ee8-9d58-5f5bec17cb58562865025.jpg	本书作为全国社会工作者职业水平考试辅导用书丛书之一，收录了全国社会工作职业水平考试的历年真题，一共7套试卷。这套真题解析有如下两个特点： 第一，题目最完整。编者仔细甄选和辨别不同的题目，鉴别出最为原真的试题，并将高频考点一网打尽。第二，解析最用心。每道题都有社工专业教师精心解读，疑难杂症还会集体会诊。这套真题可以有效帮助考生把握考点命题趋势，掌握命题金科玉律，紧跟名师解题思路，学习完美答题技巧。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	362
1481	从生活走向创意	978-7-5628-6539-1	\N	蔡文学 	\N	1-1	\N	78.00	196.0千字	华东理工大学出版社	150	\N	\N	\N	/book/625e6f69-8859-4776-aeea-7de51ef45431562865391.jpg	本教材适用于各中、小、幼学生通识美术教育之用，也可做为职业学校学生提高艺术修养之用。本教材通过作者的亲身美术实践过程的再现，真实的传达美术及设计创作的过程，所采用的方法独特、真实、有效。使学生深刻的认识到艺术来源于生活高于生活，艺术离我们并不遥远，生活中处处都是艺术的源泉和创意设计的源泉。本教材从现代艺术的创作本源出发，使学生了解基本的艺术创作过程，具备欣赏艺术作品的能力，使生活更加丰富多彩。书中内容系作者及其写作团队多年绘画、环艺工程设计实践和教学经验的积累和支撑，经过上海商业学校试教后调整的结果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	778
1474	[迪士尼大电影]双语阅读.	978-7-5628-6504-9	\N	美国迪士尼公司 	\N	1-1	\N	45.00	193.0千字	华东理工大学出版社	224	\N	\N	\N	/book/399313e6-9d77-40da-9f35-7157f1caaea7562865049.jpg	本书为电影《卢卡》官方同名双语小说，该电影将于2021年6月推出。这部治愈温情，而又充满冒险刺激的故事，讲述了在意大利里维埃拉，一个充满冰激凌、意大利面香气、和摩托车骑行的夏天，小男孩卢卡所经历的难忘成长之旅。在这部令人期待的时代冒险片中，卢卡与他新结交的好友一起经历了一场冒险，但所有的乐趣都受到了一个深藏的秘密的威胁：来自另海底世界的海怪。本书英文地道，中文由翻译家朱振武教授领衔翻译。在此基础上，本书附赠配套核心词讲解，可以帮助读者打破阅读障碍，进行流利的阅读。此外，本书还有配套音频，让读者在阅读的同时还可以用英文磨耳朵，提高听力水平。同一种题材，不同的媒介，给你带着不同的体验！	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	895
1475	社会工作综合能力（中级）精讲精练	978-7-5628-6515-5	\N	沈黎 	\N	1-1	\N	69.80	578.0千字	华东理工大学出版社	260	\N	\N	\N	/book/7264d4c3-b840-49ba-ba67-e5f845301b13562865155.jpg	本书作为全国社会工作者职业水平考试辅导用书丛书之一，是针对指导教材的提炼与补充。本书作者根据考试大纲以及指导教材的精神，对主要知识点进行了细致的梳理与分析，基本涵盖《社会工作综合能力（中级）》大纲要求的考点，对全书每一章的所有考核要点主要按照考点讲解、命题思路等几个部分进行深入分析与具体运用。“考点讲解”以指导教材为蓝本，对全书每章的知识点进行归纳总结，并提供与指导教材相配套的考点阐述。“命题思路”在历年考试真题进行分析基础上，探讨本考点的通俗理解，并对可能考核的方式、考核的内容进行预测与解释。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	882
1476	点石成金：用建模思维学高中数学（导学版）（选择性必修第一册）	978-7-5628-6396-0	\N	虞涛 	\N	1-1	\N	59.80	273.0千字	华东理工大学出版社	256	\N	\N	\N	/book/18c645ad-b3d5-476c-96fb-1d33db331b2c562863960.jpg	教育部制定的2017版新课标提出学科核心素养的思想，内容的结构化则是实现这一思想的关键。这套书依据《普通高中数学课程标准》（2017版）编写，核心思想就是将高中的数学知识进行模型的建构，构筑成一定的内容体系，使学生形成逻辑关系清晰、联系紧密的知识结构。本书为选择性必修第一册的导学版，章节设置参照人教版的新教材，每个考点按照历史典故、素养期望、认知结构、路径导航、考试热点、例题示范、思维导图、思想升华、应用前沿的板块进行编排，帮助学生构建“从典型材料，到知识解读及练习，再到新情境”的逻辑关系。本书可作为教师指导或学生自学使用，适合全国各地新教材学习的地区。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	872
1491	[迪士尼]全彩图解小学英语词汇（赠英文音频）	978-7-5628-6602-2	\N	青橙英语 	\N	1-1	\N	38.00	156.0千字	华东理工大学出版社	144	\N	\N	\N	/book/d3a44aef-d054-493f-87b8-0c49278d2e37562866022.jpg	本系列图书以迪士尼家喻户晓的形象为切入点，带领孩子们学习小学英语单词、语法和音标，具有以下特色：1.内容全，融合众多版本教材内容，满足不同地区、不同学生的学习需要；2.讲解全，讲解深入浅出，简单明了，列举大量实例；3.练习全，每章后面有专项练习，题型丰富，包括了小学阶段各类考试的主要题型；4.方法全，每章“学习小贴士”栏目介绍了许多朗朗上口的记忆口诀，便于学生抓住重点高效学习；5.图文并茂，本书配有大量生动活泼的米妮、米奇、高飞等图片。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	129
1195	药理学（第4版）	9787565918032	9787565918032	李学军 余鹰 陶亮 	\N	\N	16开	75.00	\N	北京大学医学出版社	\N	\N	\N	2018-08-01	/book/0362ef41-f9ae-4882-8d9a-729929851aaf9787565918032.jpg	药理学是基础医学与临床医学，医学与药学之间的桥梁学科。在药理学科学的理论指导下进行临床实践，在实验研究的基础上丰富药理学理论。药物的研究和应用除了要尊重科学规律，还要依照法律、法规和相关指导原则的规定，以保障人们的生命健康。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	822
1477	办一所有故事的学校	978-7-5628-6498-1	\N	毛坚琼 	\N	1-1	\N	78.00	300.0千字	华东理工大学出版社	250	\N	\N	\N	/book/e08cd02a-3a99-49ff-a0e1-d75039a972a0562864981.jpg	一流城市需要一流教育，一流教育期待一流学校。本书展呈的是作者及其团队在赓续上海小学百年深厚办学底蕴与优秀传统的基础上，通过加强学校的顶层设计、推动校园的文化变革、铺就多彩的课程跑道、建构全面的育德体系、激活教师的专业成长、培育学习的基础素养、强化绿色的质量保障等务实举措，让上海小学成为一个有温度、有故事的地方，朝着人民满意的一流教育不断迈进。作者及其团队在办学改革中一贯注重聚合“故事”与“温度”的因子，持续不断地思考如何让这些因子在最大限度上发挥育人的合力，如何为学校师生的成长和发展造就多彩可能和多元平台。学校也一直以“办一所有故事的学校”为愿景引领，不断探索走出一条特色鲜明、精彩纷呈的面向教育现代化2035的改革发展之路。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	666
1478	高考日语10年真题与解析（活页版.附赠音频）	978-7-5628-6540-7	\N	许纬 	\N	1-1	\N	35.00	532.0千字	华东理工大学出版社	100	\N	\N	\N	/book/35588f07-b367-434b-bcb4-6c17af7af9a5562865407.jpg	本书是针对高中学生所编写的高考日语考试复习和参考用书。为了帮助广大高三学生顺利通过高考日语考试，本书精心汇编了最近十年的考试真题，并附有详细解析。通过本书的学习，考生可以对考试的题型与内容有更清晰的认识和了解，并很好地把握考试的动向，在复习、备考的过程中更加有针对性。本书的内容及特色如下。本书包含近10年的真题，采用横8开胶订形式，可按年份撕开，便于教师用于课堂测试、考生用于自测。配套解析对每一年的真题进行了详细的、拓展性的解析。听解部分的解析附有完整的听力原文。除了指出正确答案之外，还点明了对做题起决定性作用的关键句。同时，对解题的思路进行了分析，并对听力原文中的重点、难点词汇进行了注音和解释。文字词汇语法部分的解析对正确选项及各个错误选项进行了详细解释和说明。词汇部分为考查的单词、短语等补充了日语的解释，并对重点的词汇、短语等补充了例句。本书为每一年的作文题目提供了一篇范文，供学生参考。本书不仅对十年真题进行了详细的分析，而且对解题方法、解题思路进行了专业的点拨与指导。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	909
1479	新版.CATTI英语三级口译实务.考试指南+强化训练：全国翻译专业资格(水平)考试辅导丛书	978-7-5628-6356-4	\N	中国对外翻译有限公司 	\N	1-1	\N	68.00	567.0千字	华东理工大学出版社	300	\N	\N	\N	/book/2c978a23-2904-4b93-83fd-64cb505e4c56562863564.jpg	全国翻译专业资格（水平）考试（CATTI）是对参试人员口译或笔译方面双语互译能力和水平的评价与认定的一项国家级职业资格考试，与职称直接挂钩。CATI证书的重要性对考生的备考提出了更高的要求，而具有针对性的备考材料就成为一大利器。本书由CATTI官方阅卷机构及口译考试考官——中国对外翻译公司编著，附赠机考模拟软件，适用于2020年新版机考改革。编写人员从考生痛点出发，针对性地讲解翻译技巧，提供训练思路，旨在帮助考生通过考试，拿到证书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	949
1480	新视野日本语（提高）（赠音频）	978-7-5628-6530-8	\N	李庆祥 	\N	1-1	\N	45.00	401.0千字	华东理工大学出版社	200	\N	\N	\N	/book/e5be7efb-3b1a-4a2a-ae65-f51df007faae562865308.jpg	本套教材为“非全日制日语专业”（也适合中等教育）零起点综合日语教材。本教材学完之后学习者普遍达到全日制日语本科二年级结束时水平，日语能力考试N2水平。本套教材分为，主教材1～4册，外加教学参考用书1册，共5册。主教材1～4册分别为“新视野日本语（入门）”，“新视野日本语（基础）”“新视野日本语（提高）”“新视野日本语（精通）”册。本套教材的合作单位为“中国海洋大学国际教育中心”，第一批出版的系列教材包括英语、日语、俄语、法语四种，相关项目名称为“山东省中小学小语种在线教育项目”。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	106
1482	高级英语语法：精讲+练习	978-7-5628-6363-2	\N	罗国梁 	\N	1-1	\N	68.00	1380.0千字	华东理工大学出版社	624	\N	\N	\N	/book/3b81cc06-eb80-4e03-85fa-b251d5b0ab38562863632.jpg	本书打破传统的布局和写法，熔词法和句法于一炉，从惯用法、词语搭配、实际应用、词组和句子结构、修辞以及标准化考试的应试等角度着重阐述了冠词、数词、名词、代词、语法一致、动词、分词、动名词、不定式、荡空结构、虚拟语气、主从结构、倒装语序、介词、小品词等这些切合实际的专题。在每一专题中罗列了相关的、贴近生活的习用语，从而清晰地阐明与该专题有关的英语日常用法、有一定难度的特殊结构和写作技巧，并最后引归到有关的国内外标准化试题加以印证。每个专题的各部分都配有一定量的针对性很强的练习和解释性答案。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	840
1483	超高灵敏度太赫兹超导探测器	978-7-5628-6272-7	\N	史生才 	\N	1-1	\N	278.00	267.0千字	华东理工大学出版社	264	\N	\N	\N	/book/63bdc8af-155f-42e7-86b8-fb111c490333562862727.jpg	太赫兹波段一般定义为0.1-10 THz频率区间，波长范围为3毫米到30微米。该波段是一个有待全面研究和开发的电磁频率窗口，太赫兹天文观测在天体物理及宇宙学中有不可替代的作用。超高灵敏度太赫兹超导探测器已成为太赫兹波段观测的主要手段。本文主要阐述太赫兹超导探测器的基本类型和工作原理，以及该领域的主要研究成果和进展。本书结合作者多年的相关研究成果和实践经验，并借鉴和归纳总结国内外相关研究领域专家学者和科研人员的一些有价值的研究成果编写完成。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	131
1484	官方系列.新韩国语能力考试TOPIKⅠ（初级）习字帖（赠音频）	978-7-5628-6551-3	\N	教育振兴研究会 	\N	1-1	\N	25.80	117.0千字	华东理工大学出版社	112	\N	\N	\N	/book/7b8343e6-f6b8-4439-8340-255bed89af5e562865513.jpg	《官方系列.新韩国语能力考试TOPIKⅠ（初级）习字帖》由TOPIK真题官方授权机构韩国教育振兴研究会权威编写。该字帖由韩语40音描红、TOPIKⅠ（初级）考纲词汇、TOPIKⅠ（初级）考纲语法三大部分组成，选用标准的韩语手写体排版印刷，可以让学习者练就一手漂亮的韩文，同时又能轻松掌握考纲词汇与考纲语法，实现一书多用。考纲词汇按照词性排列，每个单词均配有词源、词义、常用搭配及释义，并配有音频；考纲语法中每个语法条目搭配真题例句，让读者可以边听、边读、边写、边记，帮助读者全方位学习和记忆考纲内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	437
1485	抗肿瘤靶向药物：蛋白酶体抑制剂	978-7-5628-5703-7	\N	药渡经纬信息科技有限公司 	\N	1-1	\N	188.00	303.0千字	华东理工大学出版社	236	\N	\N	\N	/book/a695cb5a-9bff-41b4-a9dd-45997edb852d562857037.jpg	随着全球肿瘤发病率和死亡率逐年增加，近十年来全球抗肿瘤药物的市场快速增长，抗肿瘤药物是药物开发的热点。随着靶点药物和个体治疗概念的流行，各种肿瘤新靶点和个体化治疗靶点成为了药物研发的热点。本书主要介绍了靶点药物蛋白酶体抑制剂，它的开发是当年多发性骨髓瘤治疗的重大突破。本丛书旨在通过对已上市药物的临床前研究试验和数据的总结和归纳，并通过表格、图表等形式一目了然的呈现在读者眼前。资料来源于美国食品药品监督管理局（FDA）、欧洲药品管理局（EMA）或日本药品和医疗器械综合机构（PMDA）提供的资料和数据，以及原研公司所发表的公开资料。本丛书主要针对药物开发的研究者，通过对上市药物的试验和数据的参考和对比，对新药研发进行指导和帮助。同时还可以用于希望对相关药物进行学习和研究的读者。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	242
1486	健康管理理论与实践	978-7-5628-6477-6	\N	叶心明 	\N	1-1	\N	56.00	462.0千字	华东理工大学出版社	300	\N	\N	\N	/book/906ef9a4-0f60-4a88-9d11-bad6a4cf74cf562864776.jpg	本教材以普通大学的非医科专业类的其他专业学生选修健康管理学的需要，以提高大学生健康管理水平、健康风险意识为着眼点，突出行为管理和健康风险因素的管理，系统介绍健康管理的基本理论、基本知识和实际操作的技能和技巧，重点突出以慢病管理为核心的健康管理的理论和实践，将健康管理知识落到实处。本教材共分为十章，健康管理概论、临床与预防医学基础知识、健康教育与健康促进、健康信息管理、营养与健康、心理与健康、身体活动与健康、中医养生与健康、慢性病健康管理、健康管理操作技能与实践等内容，整个教材内容力求科学严谨、深入浅出，理论与实操相结合，以便为非医学类大学生提供一套培训教材。该教材的最大特点是即不同于医学类教材的高深难懂，又不同于社会上健康管理师类应用的科普类教材，而是针对具有高中生物学基础知识且自学能力很强的非医学类本科生为主的高校教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	861
1487	高考日语基本功.词汇（赠音频）	978-7-5628-6533-9	\N	许纬 	\N	1-1	\N	58.00	698.0千字	华东理工大学出版社	240	\N	\N	\N	/book/ecff929c-dac2-4e7e-9ede-b894ad4b509a562865339.jpg	本书为应对高考日语中的基础词汇部分编写，专门为基础比较薄弱的学生打造，为考生复习备考提供了高效的词汇复习方法。全书内容丰富多彩且编排紧凑，附赠外教朗读的单词音频。全书共分如下几个部分：词汇汇总，即通过对近几年的考题进行分析，推测出考察范围的单词，将其根据词性进行分类，帮助考生记忆并运用到考题中去，而后通过练习，帮助考生加深记忆；之后有模拟复习题1000题。通过完整的复习训练，帮助考生突破考试，取得高分。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	653
1488	[漫威]超级英雄双语故事.黑豹:瓦坎达战役(全彩升级版	978-7-5628-6559-9	\N	青橙英语 	\N	1-1	\N	39.80	113.0千字	华东理工大学出版社	156	\N	\N	\N	/book/7a2b9a10-4540-4de0-8892-356cc9a841c9562865599.jpg	《漫威超级英雄双语故事》系列图书由美国漫威公司官方授权，华东理工大学出版社倾情打造的以漫威超级英雄为主人公的中英双语对照系列小说。英文地道，阅读难度与小学中高年级以及初中生阅读水平相匹配。译文由翻译家朱振武教授领衔翻译，语言优美。在此基础上，还配套有核心词讲解以及全书英文朗读音频，可以帮助读者打破阅读障碍，让读者在阅读的同时还可以用英文磨耳朵，提高听力水平。此外，本系列图书还配有许多精美故事插图，由著名插画师亲手绘制，有助于缓解阅读疲劳、辅助阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	294
1497	[迪士尼大电影]双语阅读.小姐与流浪汉	978-7-5628-6235-2	\N	青橙英语 	\N	1-1	\N	38.00	129.0千字	华东理工大学出版社	208	\N	\N	\N	/book/05fc86ab-fdda-4964-8f92-39d68ab95ca1562862352.jpg	本书为《小姐与流浪汉》电影同名双语小说，讲述了一只纯种狗在成为女主人的礼物后，原本过着平静愉快的生活，但在主人有了孩子后感觉遭到冷落，离家出走，跟一只无忧无虑的野狗成了朋友，在一连串的冒险与冲突之后，顺利返回家园的故事。本书英文地道，中文由翻译家朱振武教授领衔翻译。在此基础上，本书附赠配套核心词讲解，可以帮助读者打破阅读障碍，进行流利的阅读。此外，本书还有配套音频，让读者在阅读的同时还可以用英文磨耳朵，提高听力水平。同一种题材，不同的媒介，给你带着不同的体验！	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	345
1489	点石成金：用建模思维学高中数学（导练版）（选择性必修第一册）	978-7-5628-6581-0	\N	虞涛 	\N	1-1	\N	65.00	326.0千字	华东理工大学出版社	176	\N	\N	\N	/book/5ec9511d-89ec-40c5-8c1b-175760f689d6562865810.jpg	教育部制定的2017版新课标提出学科核心素养的思想，内容的结构化则是实现这一思想的关键。这套书依据《普通高中数学课程标准》（2017版）编写，核心思想就是将高中的数学知识进行模型的建构，构筑成一定的内容体系，使学生形成逻辑关系清晰、联系紧密的知识结构。本书为选择性必修第一册的导练版，章节设置参照人教版的新教材，每个考点按照模型集训、灵活演练、晋级测试、易错警示、真题链接、极限挑战、数学滋味的板块进行编排，且各个板块中的题目由易到难，帮助学生从模型题、模拟题，再到真题、难题，逐层深入训练。其中穿插在整个单元练习中的“练一练”“议一议”“标一标”等小提示也能引导学生进行相应的思考及拓展。本书可作为学生练习使用，配套导学版使用效果更佳，适合全国各地新教材学习的地区。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	815
92	天性引领教育	9787565139871	\N	主编 刘晓东 作者 苗曼 	0	1-1	0	40.00	256.0千字	南京师范大学出版社有限责任公司	260	\N	34	2019-03-01	/book/e1c220a3-a733-4043-a4c0-ff289d03db6f9787565139871.jpg	中国幼儿教育向何处去？在当前幼儿教育蓬勃发展的时代背景下，这是一个亟需解决的紧要问题。幼儿教育改革有别于其他任何学段的教育改革，幼儿教育改革的基本依据首先在于儿童的自然天性。儿童天性是自然史赋予人类物种的先天倾向性。天性是先在的，教育是后来者。这种“先在	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	442
1490	[迪士尼]全彩图解小学英语国际音标+发音规则（赠英文音频）	978-7-5628-6600-8	\N	柳珍妮 	\N	1-1	\N	38.00	129.0千字	华东理工大学出版社	120	\N	\N	\N	/book/60fdf364-b6c4-4be7-aef8-389f65862794562866008.jpg	本系列图书以迪士尼家喻户晓的形象为切入点，带领孩子们学习小学英语单词、语法和音标，具有以下特色：1.内容全，融合众多版本教材内容，满足不同地区、不同学生的学习需要；2.讲解全，讲解深入浅出，简单明了，列举大量实例；3.练习全，每章后面有专项练习，题型丰富，包括了小学阶段各类考试的主要题型；4.方法全，每章“学习小贴士”栏目介绍了许多朗朗上口的记忆口诀，便于学生抓住重点高效学习；5.图文并茂，本书配有大量生动活泼的米妮、米奇、高飞等图片。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	556
1492	新编化学化工专业英语（第三版）	978-7-5628-6633-6	\N	邵荣 	\N	1-1	\N	49.80	414.0千字	华东理工大学出版社	112	\N	\N	\N	/book/f921f33d-1b02-4bbf-9a1b-4f0dae563b3a562866336.jpg	本教材不囿于化学化工，而注重从过程工程、大化工的角度选择专业阅读材料，所选文章涉及五大化学、化学工程、环境工程、制药工程、食品工程等领域，适应面广。注重全面英语能力的培养。一般专业英语教材比较侧重专业教材的阅读能力训练，而本书除提供专业阅读资料外，更加注重听、说、读、译的全面训练。工具性、实用性强。书中详细介绍了常见实验室仪器和化工设备的图形及中英文对照名称，以助日常交流；书中分门别类地提供了相关领域的常用词汇表，以便集中记忆；还在书末给出了9个附录供读者使用，这些附录在给读者提供查阅方便的同时，体现了编者希望将专业外语教学摆脱“哑巴英语”，真正做到学以致用的愿望。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	431
1493	[迪士尼英文原版]	978-7-5628-6648-0	\N	美国迪士尼公司 	\N	1-1	\N	32.80	98.0千字	华东理工大学出版社	192	\N	\N	\N	/book/d0e6de17-f47e-485e-a146-fe180ec3566d562866480.jpg	《魔法满屋》是一部全新打造的音乐喜剧动画作品，将于2021年11月推出。故事发生在南美洲北部的哥伦比亚，围绕着一个魅力单纯、天真无邪的小女孩和她的家人展开。小女孩的家人都有魔力，但可惜的是，这个小女孩却没有拥有魔法的力量。故事以魔幻现实主义的风格叙述了近在眼前的家庭问题，显示性强又引人深思，带我们深入探索拉丁美洲文化。与此同时，图书配套英文音频、电子书及核心词讲解，为学英语的读者提供更高效、更舒适的阅读体验。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	749
1494	面向新时代的流程工业工程科技人才培养研究	978-7-5628-6642-8	\N	钱锋 	\N	1-1	\N	98.00	217.0千字	华东理工大学出版社	210	\N	\N	\N	/book/f1b05ee8-3628-416a-ad2a-4d4fd4e88351562866428.jpg	本书系统分析了国际流程工业人才培养的发展趋势，在行业和企业需求实地调研和问卷调查的基础上，梳理了我国流程工业人才培养的现状及存在的问题，提出了流程工业工程科技人才的战略构想。从优化政策环境、提高智能制造人才培养战略定位；完善培养体系，解决人才培养结构性短缺难题；优化知识体系，打破学科专业藩篱；强化师资队伍建设，提高工科教师的综合能力；深化产教融合，突破体制机制障碍等方面提出了面向新时代的中国流程工业领域工程技术人才培养的战略思路与目标、重点任务与实施路径。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	652
1495	小学数学思维拓展32讲（1年级）（升级版）（视频讲解版）	978-7-5628-6590-2	\N	李辉 	\N	1-1	\N	45.00	153.0千字	华东理工大学出版社	160	\N	\N	\N	/book/7821e88c-d176-441d-b5b1-3e044a48208c562865902.jpg	《小学数学思维拓展32讲》由一线经验教师编写，是为小学生量身打造的数学思维训练书，是家长辅导自学的训练书，也是趣味数学班、培优班等教材。丛书紧扣热点——渗透数学思想方法、发展数学思维能力、培养数学情感，每讲拓展目标明示知识背后隐含的思想方法，给学生带来与众不同的思维体验。小学数学思维拓展32讲（1年级）》内容包括分类整理、画中有数、几和第几、比多比少等共32讲专题训练，内容生动有趣，用图示的方式帮助学生理解，适合小学1年级学生使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	933
1496	小学数学思维拓展32讲（2年级）（升级版）（视频讲解版）	978-7-5628-6591-9	\N	李辉 	\N	1-1	\N	45.00	94.0千字	华东理工大学出版社	160	\N	\N	\N	/book/5780a9cf-d32c-41f4-9bb1-6d57d2611d95562865919.jpg	《小学数学思维拓展32讲》由一线经验教师编写，是为小学生量身打造的数学思维训练书，是家长辅导自学的训练书，也是趣味数学班、培优班等教材。丛书紧扣热点——渗透数学思想方法、发展数学思维能力、培养数学情感，每讲拓展目标明示知识背后隐含的思想方法，给学生带来与众不同的思维体验。小学数学思维拓展32讲（2年级）》内容包括花样算式、线段图解、倍的奥秘、巧妙计算等共32讲专题训练，选题典型，生动有趣，图示的方式能帮助学生理解，适合小学2年级学生使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	902
1605	中国移民史	978-7-309-15226-5	\N	曹树基 著 	精装	1-1	32开	110.00	539.0千字	复旦大学出版社	602	\N	\N	2022-01-01	/book/50d6cb2d-b373-4687-a488-9f18adf4f3b81084689.jpg	国家“十三五”规划重点图书 国家出版基金项目 本书研究自先秦时代至20世纪末发生在中国境内的移民历史，对各个时段主要的移民运动，一般都说明其起因、迁移对象、迁移时间、迁入地、迁出地、迁移路线及方向、定居过程和产生的影响，并尽可能作定量分析，总结其规律。 在掌握传世与出土历史文献的基础上，本书充分吸收前人的研究成果，力求最大可能地反映历史真实。全书共分七卷：第一卷为全书导论和大事年表，第二卷至第七卷分别为先秦至魏晋南北朝时期、隋唐五代时期、辽宋金元时期、明时期、清时期和清末至20世纪末的断代论述，均列有大量统计表格和地图。各卷按统一的体例撰写，但具有相对的独立性，其考证过程和编写结构因不同时期的移民情况而有各自的侧重点。 本书是目前国内外最完整、系统的中国移民通史，可供历史、人口、地理、社会、经济、文化、民族、地方史等学科的专业人员，政府有关部门，高等院校的教学和科研人员使用，也可作为相关学科研究生的教材。 第六卷 本卷为清时期的移民史，主要依据《清实录》及各种官修史书、族谱、地方志、地名志中的资料，对清时期的移民运动进行了系统的研究。在这一时期的历次移民运动中，清代前期对西南地区、东南地区、台湾、岭南以及北方边外地区的移民是研究的重点，太平天国战争后的移民也是本书的重点之一；此外，本书还对各族人口的迁移、中国人口的海外迁移及城市化移民等有详细的论述。本书采取计量历史学、社会学的基本方法，对清时期的移民过程、移民分布、移民数量都做了详实的考证，并对各地移民社会的性质做了细致的分析。列有大量统计表格和地图。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	712
1498	[迪士尼大电影]双语阅读.心灵奇旅	978-7-5628-6315-1	\N	青橙英语 	\N	1-1	\N	45.00	164.0千字	华东理工大学出版社	208	\N	\N	\N	/book/d7c04dc5-6776-4464-b03b-e6b0fe58aac2562863151.jpg	本书为《灵魂》电影同名双语小说，讲述梦想成为一位爵士音乐家的主角乔伊找到机会发挥自己时，竟然因意外而变成灵魂，让他开始重新思考生而为人的使命。该作品为探索心灵的故事，让你去发觉是什么最终成就了现在的你，你的热情你的梦想都是由何而来。本书英文地道，中文由翻译家朱振武教授领衔翻译。在此基础上，本书附赠配套核心词讲解，可以帮助读者打破阅读障碍，进行流利的阅读。此外，本书还有配套音频，让读者在阅读的同时还可以用英文磨耳朵，提高听力水平。同一种题材，不同的媒介，给你带着不同的体验！	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	920
1499	民事诉讼鉴定费用制度研究	978-7-307-22665-4	\N	杨瑜娴 著 	平装	1-1	16开	88.00	\N	武汉大学出版社	\N	\N	\N	2021-12-01	/book/7ce7da1b-a124-45e7-8b15-3e7ef5a3e4591083837.jpg	本书是“司法改革背景下我国民事诉讼运行机制完善研究”丛书中的一本，也是湖北省学术著作出版专项资金资助项目。本书作者是武汉大学法学院诉讼法博士杨瑜娴。本书采用比较分析法、实证分析法、规范分析法等研究方法，对民事诉讼鉴定费用予以专题研究。以民事司法鉴定的法律定位出发，对民事诉讼鉴定费用的内在意蕴、法律特点、法律性质、组成部分等理论基础进行探讨。并且，在借鉴域外立法例、判例和相关学说的基础上，从法律定位、多维路径、立法模式、相关规则等方面提出构建和完善我国民事诉讼鉴定费用制度的主要思路。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	683
1500	科幻写作十五课	978-7-5191-2737-4	\N	曹勇军 	0	1-1	16开	68.00	241.0千字	教育科学出版社	308	\N	\N	2021-12-21	/book/95024842-80b7-498d-ba80-df6144ac91cb1083846.jpg	科幻阅读和写作逐渐成为社会热点，越来越多的青少年加入科幻写作行列，但科幻写作有一定门槛，教师指导乏术，学生不得入门。市场上需要一本真正有效指导学生科幻写作的读物，以填补空白。《科幻作文写作指导》是一本指导学生科幻写作的入门书、实战手册。该书分10个章节，详细讲解科幻作文写作的全流程要素，如写前准备、科学设定、故事构思、章法结构（开头、突转、高潮、结尾等）、人物塑造、细节描写等；每一章由知识讲解、名著片段、优秀习作、点评，以及思考练习几个板块构成，采用讲练结合、循序渐进的方式，帮助学生领悟科幻作文写作的奥秘，掌握科幻作文的写作方法。本书适合教师作为科幻写作教学指导书使用，也适合学生阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	734
1501	医学图像分析技术及其应用	978-7-307-22720-0	\N	王倩 著 	平装	1-1	16开	39.00	\N	武汉大学出版社	\N	\N	\N	2021-11-01	/book/3dadd27a-f4cc-44f8-93bf-fd59f9a79c631083854.jpg	本书研究了相关图像的目标区域定位、图像分割及特征量化的处理与分析方法。全书分为五章。第一章为绪论部分，阐述了本著作的研究背景、意义及目的；第二章的主要内容为医学图像目标区域定位方法的研究，主要是从胶囊内镜图像中气泡区域的定位及tMR图像中心脏区域的定位方法来进行深入地探讨；第三章主要研究了医学图像分析中图像分割的经典问题；第四章主要研究了医学图像特征量化分析的方法；第五章主要研究了医学图像的分类与识别方法，其中主要内容包括利用传统的模式识别技术，在所提取的染色体特征基础上，通过BP神经网络及K-means聚类进行染色体核型的二级分类方法；还利用深度学习中的经典卷积神经网络模型进行迁移学习来分类识别胶囊内镜气泡帧。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	177
1503	提花织物设计	9787566919762	\N	罗炳金 	平装	1-1	16开	49.00	\N	东华大学出版社	\N	\N	\N	2022-02-01	/book/6236a5f4-1777-4981-bfc4-de983db1acd21083873.jpg	本书基于工作过程的理念,系统阐述提花织物（简称纹织物）生产的基本原理、装造工艺设计、纹样设计、意匠设计、纹织 CAD 操作功能与应用，以及电子提花机在纹织物生产中的实际应用。 同时，本书设置了生产实际应用模块，其以企业的纹织物设计项目为驱动，以及实际生产案例为导入，具体说明各类纹织物的规格、工艺、图案、意匠的设计和纹织 CAD 的应用。 本书体现新形态教材的特征：教材资源与课程有机结合，纸质教材与电子资源深度融合，支持移动学习、线上线下混合式教学。 本书主要作为高职高专院校纺织类专业教材，也可供纺织产品设计人员，特别是纹织物设计人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	546
1504	北京冬奥会和冬残奥会志愿者读本	978-7-300-27516-1	\N	北京2022年冬奥会和冬残奥会组织委员会 	0	1-1	16开	78.00	250.0千字	中国人民大学出版社	\N	2019G0482	\N	2022-03-17	/book/973ae202-6841-47c5-bce0-baaccb77829b1083898.jpg	《北京冬奥会和冬残奥会志愿者读本》一书为北京2022年冬奥会和冬残奥会组织委员会组织编写的“北京2022年冬奥会和冬残奥会系列教材”中的一本。全书首先向读者介绍了奥林匹克运动的相关知识，以及冬奥会和冬残奥会的历史及比赛项目；在此基础上，从冬奥会和冬残奥会的申办、总体规划、场馆和基础设施、竞赛项目设置、亮点工作及冬奥组委等角度介绍了北京2022年冬奥会和冬残奥会的组织与筹备工作；进而从志愿者与志愿服务、奥运会和残奥会志愿服务两个方面介绍了志愿者与志愿服务，尤其是奥运志愿者与志愿服务的基础知识，并重点介绍北京2022年冬奥会和冬残奥会志愿服务的运行与管理，以及奥运志愿者的技能与行为规范等内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	414
1505	政府会计（新编21世纪财税系列教材）	978-7-300-30167-9	\N	童光辉 周克清 刘丹 王积慧 	0	1-1	16开	68.00	677.0千字	中国人民大学出版社	\N	2020F0628	6	2022-02-01	/book/f65e687c-9487-4a7f-ad2d-0c84144d02781083915.jpg	本书坚持以习近平新时代中国特色社会主义思想为指导,以中共十八届三中全会提出的“建立权责发生制的政府综合财务报告制度”为核心依据,以全面深化改革为着力点,根据《政府会计准则——基本准则》及《政府会计制度——行政事业单位会计科目和报表》等相关政府会计准则制度,按照政府会计基础理论—行政事业单位会计—财政总预算会计的框架设计相关内容。本书共计十八章，包括三个部分，第一部分是政府会计基础理论，主要包括政府会计概论、政府会计的财政制度环境和政府会计的基本方法；第二部分是行政事业单位会计，主要包括行政事业单位会计八大要素的核算与会计报表；第三部分是财政总预算会计，主要包括财政总预算会计五大要素的核算与会计报表。 本书为中国大学MOOC(爱课程网)“政府会计实务”课程的配套新形态教材,并与易财经合作建立了实操实训平台,实现了线上线下资源的深度融合。 本教材可作为高等院校 (含职业院校) 经济管理类专业政府会计相关课程的教材,也可作为财政总预算会计和行政事业单位会计人员的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	647
1506	自信快乐的小孩：别让焦虑和孩子一起长大（第2版）	978-7-300-30114-3	\N	[澳]罗纳德·M.劳佩 安·威格纳尔 苏珊·H.斯彭斯 瓦妮莎·科巴姆 	0	1-1	0	59.00	130.0千字	中国人民大学出版社	\N	301143	10	2022-01-10	/book/503e324b-025d-4adc-b0eb-58b66ea252e51083919.png	研究发现，大多数孩子都怕黑，还有些孩子害怕床下的怪物。不过，至少有10%的孩子有过度的恐惧和担忧——恐惧症、分居焦虑、恐慌症、社交焦虑或强迫症，这些都会阻碍他们充分享受童年。如果你的孩子患有任何形式的焦虑，本书中提供的实用的、经过科学证明的工具将能帮助你。 在第二版中，帮助你焦虑的孩子已经被扩展和更新，包括最新的研究和技术来管理孩子的焦虑。这本书提供了基于认知行为疗法（CBT）的有效技能，帮助您帮助您的孩子克服强烈的恐惧和担忧。你也会发现如何减轻孩子的焦虑情绪，同时用同情来养育孩子。 在里面，你将学会： 帮助你的孩子练习“侦探思维”来识别非理性的忧虑 当你的孩子害怕时该怎么办 如何让你的孩子慢慢地面对挑战 帮助孩子学习重要的社交技能 这本书被授予行为和认知治疗协会自助奖章-这是一个奖项授予优秀的自助书籍，符合认知行为治疗（CBT）原则，并纳入科学测试的策略，以克服心理健康困难。单独使用或与治疗结合使用，我们的书提供了强大的工具，读者可以用来启动他们的生活变化。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	835
1507	多思少算：突破选填压轴题	978-7-300-30138-9	\N	主编：王宇、张华云 	平装	1-1	16开	52.80	140.0千字	中国人民大学出版社	\N	301389	15	2022-01-08	/book/616f0611-6c07-47fa-ba46-8a6ed5cc0fff1083970.jpg	本书是面向初中升学阶段的教研用书及学习用书，围绕选择、填空压轴题的数学思维特点而编写，旨在帮助读者探寻解决这类综合问题的方法和策略。本书在思路和方法上引领读者勤于思考、善于思维，体验思维的提升，多方法、多角度探索，不断总结规律与方法，更加深入地理解知识内涵，有效提升自身的数学学科素养。 本书为给读者留出足够的思考空间，随书配备教学辨色卡。读者可以对题目的思路分析和作答内容进行遮盖，尝试先独立思考解决问题，再通过阅读书中的答题思路对比提升。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	294
1508	数里有形：突破代数综合问题	978-7-300-30142-6	\N	主编：王宇、张华云 	0	1-1	16开	56.80	178.0千字	中国人民大学出版社	\N	301426	15	2022-01-08	/book/425e6c86-7695-4632-92a4-cfc8436011261083977.jpg	本书是面向初中升学阶段的教研用书及学习用书。以数形结合思想作为突破代数综合问题的策略，帮助读者真正认识到数形结合的关键点以及数和形的具体表现形式，注重动手画图分析问题，从而能灵活进行图象特征和代数特征的准确表达，达到突破难点的目的。 本书中的“学习提升”部分是编者在一线教学过程中与同事、学生交流总结后的智慧结晶。“学伴分享”的视频讲解部分是由学生完成的，这也是作业设计的一个新尝试。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	968
1510	新文科探究	978-7-5482-4474-5	\N	周翔，史家银，毕晓峰 主编 	平装	1-1	16开	38.00	257.0千字	云南大学出版社	197	\N	\N	2021-12-01	/book/9ca7ee90-b29e-49b5-8c09-bea32a31e4211083988.jpg	本书是在新文科建设背景下，为进一步做好艺术院校公共课教育教学工作，结合“大文科”的目标要求，把专业建设、课程建设和改革做到实处，切实做好公共课教育教学思想交流，为本科教学提供借鉴。选题基本构架围绕着教育教学理论、教师自身专业研究进行。书稿主要包括课程建设、新文科建设、专业综合研究等版块。新文科建设探究主要包括新文科理论探究、新文科教学科研实践应用调研等；课程建设探究主要包括课程理论探究、课程实践应用调研等；专业综合研究主要包括教师自身专业前沿问题的研究、相关课题研究等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	989
1511	冬奥会交际汉语口袋书	978-7-5619-6063-9	\N	陈丽霞 主编 	平装	1-1	32开	48.00	\N	北京语言大学出版社	128	\N	\N	2022-01-01	/book/9ab801e0-b0fc-428c-91e4-5809b1beb67a1083989.jpg	第24届冬季奥林匹克运动会将于2022年在中国北京市和张家口市联合举行，这是继2008年北京夏季奥运会后，中国再次承办奥林匹克盛会。为更好地满足世界各国代表团与工作人员了解中国文化、感受冬奥精神的需求，实际解决其在华参赛期间可能面临的语言障碍，北语社推出《冬奥会交际汉语口袋书》读本，选取12个主题讲解中文常用例句，帮助外国友人在短时间内掌握日常交际用语，并了解当代中国人的生活和冬奥会文化知识。 全书以短期提高学习者语言沟通能力、交际能力为主要目标，采用英文、法文2种语言注释，按照12个交际主题分类编写，分别是：（1）问候与问询；（2）日期与时间；（3）住宿与服务；（4）交通与出行；（5）谈语言；（6）谈天气；（7）谈饮食；（8）谈旅游；（9）娱乐与购物；（10）观赛与议赛；（11）健康与养生；（12）求助与应急。每个主题包括交际用语、情景会话和拓展3个模块。交际用语为该主题的口语常用语；情景会话展示例句的使用场景；拓展提供扩展词汇、知识，供查阅使用。书中融入了北京2022年冬奥会吉祥物、会徽、比赛场馆和比赛项目等介绍，最大程度地满足奥运会代表团等人的语言使用需求。本书配有录音电子资源，可通过扫描封底的二维码播放例句与会话的录音，方便读者进行自学练习。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	223
1512	成都平原语音历史层次研究	9787569045147	\N	何婉 	平装	1-1	16开	78.00	\N	四川大学出版社	\N	\N	\N	2021-11-01	/book/85dcf88b-2468-40e4-97b2-3c15c39e22301083996.jpg	本书为四川大学出版社出版的汉语国际教育与中华文化推广系列丛书。该书运用历史语言学、地理语言学及社会语言学的相关理论和方法，从今天成都地区方言所体现出来的移民方言和土著方言的层次，结合移民史的相关资料，来研究近400年来成都方言的历史形成。作者选取了成都市区（七区十二县）及周围一共九个方言点作为研究的基点，也分析了诸如历史移民、山川地理、行政区划等因素，探讨成都地区方言的历史形成。并对此问题做了广泛深入的研究，是一本学术水平较高的著作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	429
1547	科学2.0时代科研人员学术交流行为研究	978-7-307-22710-1	\N	李晶 著 	平装	1-1	16开	48.00	\N	武汉大学出版社	\N	\N	\N	2021-11-01	/book/56d7ada8-7c57-468b-9856-e2cece2e463b1084174.jpg	本书以科学2.0时代科研人员的学术交流行为规律为研究对象，从学术交流行为概念、学术交流行为过程与模式、用户的学术信息需求、学术交流平台及特征、科研用户对学术交流平台的使用现状调查、未来学术交流行为的演进与优化等方面进行阐述，注重将学术交流的主体与客体特征相结合，同时将技术变革和推动影响纳入考虑，以期全面展现由技术驱动的科研用户学术交流行为的协同演进过程。本书可作为图书情报学专业研究人员的理论工具书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	236
1546	大学英语视听说教程1	9787312051555	\N	李萌涛，李华东 	0	\N	16开	45.00	\N	中国科学技术大学出版社	\N	\N	\N	2021-12-31	/book/ec8e95b0-42f2-4448-a4d8-2ca8d27c4f911084168.jpg	传统大学英语教材的编写通常把通用英语和学术英语隔离开来，要么只讲通用英语，要么只讲学术英语。为了打破了这一固有模式，我们组织相关理工科背景的高校外语系骨干教师编写了一套涵盖理工科高校学生需求的《新工科英语》丛书，将通用英语与学术英语有机地结合起来，《新工科大学英语视听说教程1》为其中一本。教材编写的理念、选材、活动设计、题型设计等都体现了这种结合理念，这样可以使学生通过学习具有专业性的学术英语，同时具备在学术或专业领域进行交流的能力。本书适用于理工科院校非英语专业大学生学习使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	300
1513	初中音乐素质测评指导	978-7-5672-3610-3	\N	潘丽琴，王欢 主编 	平装	1-1	大32开	40.00	\N	苏州大学出版社	\N	\N	\N	2022-02-01	/book/daec226b-736f-402c-97cd-b480cf95398b1084005.jpg	　　日前，苏州大学出版社推出“高等院校音乐教育专业教学技能规划教材”，共6册，包括《自弹自唱教程（小学篇）》《自弹自唱教程（中学篇）》《视唱基础教程（小学篇）》《视唱基础教程（中学篇）》《优秀中小学音乐教案》《初中音乐素质测评指导》。由苏州大学音乐学院吴磊教授担任总主编。 　　本套教材旨在通过教材改革提高高等院校音乐教育专业的人才培养质量，为培育和打造高素质专业化创新型中小学音乐教师队伍提供有力支撑。本套教材特色鲜明：一是具有较强的发展时代性，围绕师范类专业认证的最新理念；二是具有较强的育人指向性，注重挖掘课程教材的思政元素；三是具有较强的教学针对性，针对新时代中小学音乐教师核心能力进行培育；四是具有较强的实践指导性，关注学生未来职业发展的需要。 　　本套教材在呈现形式上具有较强的现代化特点，采取纸质教材与多媒体数字资源相结合的融媒体教材形式，读者可以扫码欣赏音视频素材，直观感受音乐作品的音响效果和中小学音乐课堂的教学实录。 　　本套教材的出版，不仅可以作为高等院校音乐教育专业本科教学以及专业学位硕士研究生教学使用，也可以满足中小学音乐教师的实践教学所需。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	326
1747	大美之梦：汉风的艺术世界	9787576100594	\N	赵险峰 	0	1-1	16开	186.00	\N	燕山大学出版社	\N	\N	\N	2020-05-01	/book/dd8a40b9-4454-4c1e-87c4-c6cd07dc059e1085842.png	《大美之梦：汉风的艺术世界》一书全面介绍了著名画家汉风的人生经历和艺术造诣，回顾了汉风的成长历程、走过的艺术道路、取得的多方面成就以及他与艺术巨匠们的交往和情谊，并且收录了汉风有代表性的国画作品。本书不仅是一部有艺术品位和学术价值的厚重著作，而且是一部富含精神价值和能量的图书，供美术界、学术界和广大师生交流研究，具有重要意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	469
1514	电力机车制动机系统	978-7-5121-4616-7	\N	罗利锦 孙世峰 	平装	1-1	16开	59.80	\N	北京交通大学出版社	\N	\N	\N	2022-02-01	/book/9aae8b1c-5671-4cb7-bd50-739c571a7fbb1084012.jpg	本书根据职业教育教学改革精神，运用任务驱动、案例分析等手段，由校企专家联合编写。为贯彻立德树人根本任务，本书融入思政教育元素。本书分为6个模块，具体包括：电力机车制动系统的构成及部件间的关系、电力机车制动系统各部件的功能、电力机车制动系统的操作方法、电力机车制动系统的一般故障判断方法、电力机车制动系统试验方法、电力机车制动系统基础制动装置的操作方法。 本书适合作为高等职业学校、中等职业学校铁道机车类专业的教材，也可供铁路企业相关工程技术人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	872
1515	国际财经术语（双语版）	9787566322821	\N	徐凡 主编 	平装	1-1	16开	42.00	\N	对外经济贸易大学出版社	\N	\N	\N	2022-01-01	/book/1b500351-727e-409a-8302-fb9025a823381084017.jpg	本教材以对外经济贸易大学研究生同名公选课程实践为基础，以本课程多轮研究生教学课件为蓝本，结合国际财经与中国财政、金融及实体经济国情，系统讨论核心国际财经术语、原理及实务运用场景，具体呈现以下几个特点：在学科体系上，进一步完善财经英语的研究对象和范畴，以货币银行、证券、保险、信托、经济学、缩略词等六大专题为重点依托。在授课内容上，新增对于时效性财经术语的汇集、分类与阐释，并将其有机融入随堂课件体系之中，其中核心术语重点涉及国际储备和中国外汇储备、中国经济内部均衡和外部平衡相互冲突根源、国际金融危机、美国国际收支逆差、中美贸易争端，以及国际货币基金组织近年政策演变等全球财经焦点问题。在教材内容传承与发展关系问题上，既注重总结西方经典理论，又以中国国情为基础、以核心商务概念为依托，构建多维度英文财经术语教学与研讨视点。就应用性设计理念而言，本教材强调核心财经术语的实用性、规范性及国际通用性，着力培养在读硕士、博士研究生举一反三、学以致用的跨国商务沟通能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	327
1516	高考日语历年真题10套卷	978-7-5669-1886-4	\N	于洋 主编 	平装	1-1	大32开	55.00	\N	东华大学出版社	\N	\N	\N	2022-02-01	/book/f0fdd238-f447-42ac-bd33-e3e92092083f1084023.jpg	为帮助考生熟悉高考日语真题内容，了解自身日语水平，及时发现和弥补自身薄弱环节，能从容应考并获取高分，编者依据《普通高等学校招生全国统一考试大纲（日语）》，并融合自身多年教学经验，编撰了《高考日语历年真题10套卷》。 本书从高考日语历年真题出发，收录了2012年至2021年高考日语全国统一考试真题试卷，并附赠听力录音，高度还原高考场景。本书配有参考答案及详解，其中给出了所有听力原文，题目涉及日语知识运用、考点分析、解题思路，题目语句在文中的出处，涉及的重点词汇及语法等，解析非常翔实。另外，写作部分附有历年真题试卷范文，供各位考生参考。本书适合即将或今后参加日语高考的考生。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	648
1818	西班牙语SIELE考试口语高分指南（A1-C1）	978-7-5669-2005-8	\N	马功勋 主编 	平装	1-1	大32开	72.00	\N	东华大学出版社	\N	\N	\N	2022-04-01	/book/5144a95d-ea2e-43cb-a07a-2df39efef0aa1086300.jpg	　　本书是面向有意向考取官方语言等级证书的学生所准备的教材，书中包含15套SIELE口语考试模拟题。在每套模拟题中，读者都会遇到五个大题对应五个不同的考试等级。这五个大题分别为：1. 听问题并做出回答(A1)；2. 看图说话 (A2); 3. 语音留言信箱或真实场景应答(B1)；4. 看短文并回答问题 (B2)；5. 分析论点并进行口语论述(C1) 。除了模拟考题之外，本书还提供口语论述模版和题型解析，方便学生通过自学的方式达到通过考试的最终目的。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	902
1517	快速突破阿拉伯语专四语法练习400题	978-7-5669-1970-0	\N	郑明纯 主编 单思明 崔泽 郑祥雯 马鹃 编 	平装	1-1	大32开	48.00	\N	东华大学出版社	\N	\N	\N	2022-02-01	/book/cceb2d63-ef43-429a-904a-e1fb19fb43fe1084025.jpg	本书主要围绕阿拉伯语专四语法内容进行编辑，分为基础语法和综合语法两部分。基础语法包含动词、名词、介词和数词四个部分。全书分为19个单元，第一至十三单元是基础语法，第十四至第十九单元是综合语法。每个单元分为“测一测”、“理一理”两个部分。“测一测”是与专四题型相符的20个选择题；“理一理”是针对该测试题涉及到的知识点进行梳理。 本书根据专四选择题隐含的动词、名词、介词、数词、综合语法五大板块进行编辑。练习题与考点紧密结合，帮助学生全面、精准梳理考点，以学生易懂、易记为宗旨，提高复习、备考效率。目前市面上没有阿拉伯语专四备考书籍，与此思路相同或相近的书籍就更没有了。 该书内容以教师自编讲义的形式在本校已经进行了多轮的教学应用，得到了学生的认可，教学效果良好。编者希望能在全国推广，让更多的学生受益。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	115
1518	马克思主义与国家：一种分析的方法（马克思主义研究译丛·典藏版）	978-7-300-30292-8	\N	[英]保罗·威瑟利（Paul Wetherly) 	0	1-1	0	69.00	250.0千字	中国人民大学出版社	\N	2017A0317	\N	2022-02-02	/book/17ffca72-3956-497c-a365-fbab5f2a3ebe1084034.jpg	本书对传统马克思主义国家理论进行了系统的梳理和审视。作者以详尽的文本评论，分析了以往工具主义与结构主义对马克思主义国家理论的种种解读；立足于分析马克思主义的路径，继承并反思了柯亨对马克思历史理论所作的功能解释的观念，从而推进了一种新的“合理的功能解释机制”作为国家理论分析方法。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	446
1532	基本权利保护的法理	978-7-5620-9813-3	\N	"日) 小山刚著；吴东镐,崔东日译" 	\N	1-1	16开	56.00	240.0千字	中国政法大学出版社	312	\N	\N	2021-01-01	/book/dbf02a81-73b9-464e-8757-cf2d304b0a659813-3.jpg	“日本公法译丛”之一，中国人民大学法学院教授、博士生导师王贵松为丛书主编。本书是小山刚的成名作。本书中提出的“国家的基本权利保护义务论”是不同于传统的基本权利理论的新的宪法理论。本书详细阐述国家的基本权利保护义务论在德国联邦法院的判例中出现并得以确立的过程，分别讨论了基本权利保护义务理论的法律结构、德国联邦宪法法院规制基本权利保护义务的基准、基本权利保护义务理论与传统法理之间的区别、基本权利保护义务论与国家目的论之间的关联性、基本权利保护义务与“自我决定”之间的冲突等问题，并从基本权利保护义务的视角重新审视和建构“基本权利的私人间效力问题”。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	842
1519	运营数据分析（新编21世纪高等职业教育精品教材·市场营销系列）	978-7-300-30322-2	\N	彭美华 	0	1-1	16开	32.00	238.0千字	中国人民大学出版社	\N	303222	\N	2022-03-15	/book/51b2e3eb-75be-4a51-b24d-eb95ce2e839a1084040.jpg	随着时代的发展，各行各业都期待通过一定的数据分析拓展业务内涵，提升管理水平。数据分析可以是较高层次的操作，但需匹配较高水平的计算机等专业知识；数据分析也可以是运用Excel软件，把日常的简单数据表格行云流水般处理到位。针对经管类高职学生计算机专业知识薄弱，甚至零基础，但企业管理知识略胜一筹的现状，作者特意选择以易学易练的Excel常用数据分析功能为抓手编写了本教材，以培养学生一定的数据加工处理能力及分析能力。 本教材总共分为五个项目，前面四个项目分别介绍了Excel最常见的数据加工处理方面的知识技能，如排序、筛选、常用函数、绘制图表、数据透视表等，最后一个项目则综合运用前面所学，针对特定的数据源及目标，展开数据的整理及分析操作。每个项目首先设定了需达成的学习目标，然后导入完成该目标必须学习的相关知识及操作技能。所有的技能都配置了教学案例进行详细解说，解说完毕再对接相关的练习加以巩固。教学及练习中涉及的表格数据通过扫描每个项目末尾处的二维码即可获取。每位同学只要认真阅读本教材，便可自行学习，如果相关老师进行及时的引领及指导，则每个项目的教学目标应该都得以实现。 通过本教材的学习，学生可以对于数据分析建立基本认识，对简单数据的处理有自信，从而为将来深层次的数据分析探索奠定基础。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	150
1520	上帝掷骰子吗？——混沌之新数学（新版）	978-7-313-25641-6	\N	[英]伊恩·斯图尔特 著 潘涛 译 朱照宣 校 陈以鸿 审订 	平装	1-1	大32开	88.00	\N	上海交通大学出版社	\N	\N	\N	2022-01-01	/book/f552fdc3-a319-494d-a3ea-1791bd0e68b61084058.jpg	我不会相信上帝跟宇宙掷骰子，爱因斯坦如是说。秩序与混沌究竟什么关系？混沌是大众媒体炒作的怪物（蝴蝶效应），还是现实世界无处不在的实在（有条有紊）？混沌理论与其伴侣复杂性科学为何难解难分？本书为1989年英文初版的增订二版，被公认为通俗诠释混沌之新科学的经典读物。微观粒子、龙头滴水、台球撞击、气候变幻、股市涨跌、心脏搏动、天体翻滚……混沌忽隐忽现，复杂漂浮不定。问题不在于上帝是否掷骰子，而在于如何掷骰子。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	820
1521	数字测图(第3版)	978-7-5689-2945-5	\N	冯大福 吴继业 	平装	3-13	16开	49.80	470.0千字	重庆大学出版社	284	\N	\N	2022-01-01	/book/a177ffbf-a638-4733-b36c-4383333f746c1084059.jpg	本教材主要为高职高专测绘类专业的教学需要而编写，以草图法、编码法和电子平板法测绘大比例尺数字地形图为主线，按照数字测图生产项目实施过程编排全书内容。以南方全站仪、中海达CROS RTK等仪器为主要硬件，以目前最新的南方CASS10.1为主要软件为例来示范数字测图的外业数据采集和内业成图操作。 全书共有7个项目、31个任务。主要内容包括：项目1绪论、项目2数字测图的工作步骤、项目3数字测图外业、项目4数字测图内业、项目5其他数字成图方式简介、项目6数字测图的质量控制、项目7数字地形图的应用。本书附录还精心为读者提供了2个方面的内容：CASS软件使用常见问题解答、常见地物表示方法对照表。本书可作为高职高专测绘类专业的教材，也可以作为广大测绘工程技术人员的参考书和测绘培训机构数字测图技能的培训教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	874
1522	德语文学汉译史考辨：晚清和民国时期	9787544665926	\N	卫茂平 	平装	1-1	大32开	72.00	\N	上海外语教育出版社	\N	\N	\N	2021-03-01	/book/22f79904-f7b4-4d8a-a9fb-f74572a9ee6b1084065.jpg	《德语文学汉译史考辨：晚清和民国时期》于2004年第一次出版，2015年入选“中文学术图书引文索引”数据库。作者以史、传、论相结合的方式勾勒出晚清和民国时期德语文学汉译的历史发展过程，重史料考辨，实证与诠释交互为用。本书对该时期的汉译德语文学图书及报刊文章爬罗剔抉，也对影响德语文学汉译的历史问题采辑探讨，彰显了德语文学汉译史的特点，是理清中德文学关系脉络的一项重要成果。书后还附有详细附录，可供读者参考。本书在原来的基础上纠偏补正，再版对于比较文学及翻译文学研究者、外国文学汉译研究者尤其是德语文学汉译研究者具有重要的借鉴意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	195
1523	教师口语技能	978-7-305-24700-2	\N	"张颖炜,翟方曙" 	\N	1-1	小16开	23.00	150.0千字	南京大学出版社	132	\N	80	2021-11-19	/book/36fa6380-71e6-4012-9939-7881d0177b309787305247002.png	本书是一部针对口语表达训练而编写的教材。《全日制义务教育语文课程标准》将“听说教学”改为“口语交际”，课程标准建议学生的口语交际教学在各种活动中展开。口语交际不仅与学生当前的学习相关，更会影响学生的未来发展。因此，本教材从学生技能训练的实际需要出发，制定了适合学生进行口语表达训练的内容，主要由普通话语音训练、朗读、演讲等五大部分组成。从普通话发音、口语表达技巧、声音训练、能力训练等多方面入手，全面提升学习者的口语表达水平。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	908
1524	海岸带行动策略——以俄罗斯等国为例	978-7-305-24386-8	\N	（俄）尼古拉?列昂尼多维奇?普林克 	\N	1-1	小16开	58.00	254.0千字	南京大学出版社	252	\N	40	2021-11-30	/book/f290220d-b5ad-4325-b96c-d584d02a8fa79787305243868.png	本书系据欧洲联合项目“海岸带综合管理的教育与实践拓展”计划编撰的系列教课书之一种，详细论述了海岸带综合管理的基本理论与方法及其历史与现状，并援引俄国及国际的有益经验作为实证，理论与实际结合，图文并茂，丰富实用，是俄罗斯国立水文气象大学推荐的大中院校管理专业教材。本书对我国海岸带地区自然、经济社会发展规划和管理的理论研究、工作实践及与此相关的教学与培训事务均有借鉴意义；亦适宜对此领域感兴趣的广大读者	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	458
1526	《资本论》三大理论新解	978-7-305-24888-7	\N	孔陆泉 	\N	1-1	小16开	88.00	324.0千字	南京大学出版社	292	\N	32	2021-06-30	/book/ed3eada2-b187-4a55-9c25-8630a7bc2ee89787305248887.png	本书为国家社科基金后期资助项目，全书围绕《资本论》的劳动价值论、剩余价值论和个人所有制论三大理论而展开。劳动价值论是发展社会主义市场经济的理论基础。深化对社会主义社会劳动和劳动价值论的认识，必须坚持辩证唯物主义和历史唯物主义的立场、观点和方法，透过现象看本质，在新的历史条件下坚持和发展马克思的劳动价值论。榨取剩余价值是资本主义生产的唯一动机和目的，资本剥削的强制性、贪婪性和残酷性无与伦比，一切辩护都是站不住脚的。社会主义初级阶段国家资本主义经济和民营经济中私人资本和剩余价值中含有的资本剥削关系，应当放在当代条件下进行分析，充分肯定其积极作用。马克思要求重建的个人所有制，是联合起来的个人的所有制。现行社会主义公有制，必须在个人所有制理论指导下进行改革，克服其弊病而逐渐趋向完善；劳动者个体经济和私营经济，也要克服其不足而更好发展，真正成为社会主义现代化建设的自己人，参与到混合所有制经济中来，共同构建各民族命运共同体，为向全社会个人所有制为基础的自由人联合体过渡贡献力量。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	422
1527	文学研究	978-7-305-23764-5	\N	"徐兴无,王彬彬" 	\N	1-1	16开	48.00	438.0千字	南京大学出版社	288	\N	36	2021-10-20	/book/ff12b9fd-a1d0-451b-8bd6-9b10526238089787305237645.png	中国文学研究有着十分丰厚的学术积累，形成了自己的学术传统，但这也意味着取得大的突破越来越困难。如何走出文学研究的瓶颈状态，在现有的基础上进行创新，推动中国文学研究持续深入的进行，这是一个亟待解决的问题。本书所收文章无论是研究古代作家还是研究现当代作品，都是着眼于这一问题展开。本书所收文章涉及诗文、小说等文体，视野开阔，论证扎实，观点新颖，代表着中国文学研究的新收获，为更为深入的研究提供了有益的借鉴和启发。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	523
1528	进出口税则商品及品目注释（2022年版）（上、下册）	978-7-5175-0546-4	\N	海关总署关税征管司 	平装	1-1	16开	600.00	\N	中国海关出版社	\N	\N	\N	2022-01-01	/book/8fe191a5-2645-446e-8fa7-522781c407ab1084089.jpg	《进出口税则商品及品目注释（2022年版）》是商品归类指导工具书，每5年作一次大范围修订。该书由海关总署关税征管司根据2022年版《商品名称及编码协调制度注释》编译而成，分上下册介绍2022年版《商品名称及编码协调制度》的全部内容，包括归类总规则及其解释、第一至九十七章商品范围及其归类规则解释，是进出口商品归类的法律依据，可对我国海关和有关进出口管理等部门，以及从事国际贸易的进出口企业正确进行商品归类发挥积极指导和规范作用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	731
1529	工业法概论	978-7-5764-0023-6	\N	邵俊武等著 	\N	1-1	16开	69.00	493.0千字	中国政法大学出版社	360	\N	\N	2021-08-01	/book/090b286e-681f-4430-85d3-43c72bf5f0570023-6.jpg	"现代科学和技术进步引领下的工业化的推进,必将引起工业法律制度的变化,尤其是涉及专门性问题的相关规定。本书就工业法的相关问题进行系统的梳理，理清了关于工业法的相关概念，完成了关于工业法相关法律体系的构建，对关于工业法的一系列前沿问题进行研究。对工业法这一领域研究著作为数不多，因此本书的出版是工业法研究的重要一步，也为将来关于工业法的相关研究奠定了基础，具有重要的参考价值。本书内容设置科学，对工业法相关法律规范进行了系统的理论建构。本书作者在工业法领域积极创新，具备较高的理论水平和科研能力，作者对工业法领域的关注，不仅有利于我国工业化的健康发展,也有利于工业法律制度的完善。"	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	719
1530	极限与基线:司法人工智能的应用之路	978-7-5620-9991-8	\N	陈敏光著 	\N	1-1	32开	56.00	200.0千字	中国政法大学出版社	212	\N	\N	2021-10-01	/book/92a8639b-348c-4f42-8ce2-5ad8f253cc719991-8.jpg	人工智能系基于大数据、算法和算力的机器智能，而非有机智能。本书总结提炼出理论极限与现实基线这一分析框架。在理论极限方面，作为工具的人工智能不可能超越理性计算范畴、不可能脱离自身条件而发展、不可能超越既定历史而创新，从而与司法场景中的不可计算性、动态博弈性、能动创新性不相契合；其对司法形态的型塑，包括诉讼从线下搬到线上、规则从物理走向网络、司法从解纷扩至治理，也要受到司法程序价值、司法本体价值的必要限制，并有相关外溢风险的考量。在现实基线方面，存在司法需求技术导入不足和技术导入司法支撑的不足，具体包括司法需求理解不全不准、司法需求导入机制的不畅、相关制度建设并未充分助力司法大数据的真正形成、数据结构化、机器学习和算法监督的困难等。在极限与基线的分析框架下，本研究进一步明确了司法人工智能的总体方向，对人工智能持工具主义的定位、强化司法的主导性，在充分研判司法场景的基础上，加强司法和技术的合作，强化司法需求的技术导入、强化技术应用的司法支撑、强化交叉人才的培养教育。根据以上分析框架和总体方向，通过对服务当事人和社会公众、法院管理、司法审判三大板块司法场景的系统梳理总结，对司法人工智能具体场景应用的可能、限度、主要条件和存在的不足等方面进行了审视和考察，并有针对性地提出了具体的对策建议。?	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	745
1531	法学论文写作：规范与方法	978-7-5764-0022-9	\N	刘继峰著 	\N	1-1	16开	49.00	242.0千字	中国政法大学出版社	320	\N	\N	2021-09-01	/book/5b8b5b01-eb15-48d6-be54-aebf98bd46410022-9.jpg	本书是一本关于法学论文写作技能的书籍，在内容上，主要包括论文写作的基本原理、要求、技能、规范、方法等。 面对越来越实用性的法学培养，机器人式的完成重复性的工作是法律人才的浪费。从学术技能而言，似乎论文写作直接服务于科研或学生毕业论文，但法学培养中的诸多能力，是每个法律人从事法律工作一生应当拥有的技能，如抽象能力、资料价值的挖掘、表达能力等。基于此，本书从论文写作的基本方面着手，并着眼于论文写作的几乎各个方面，为论文写作者提供指导。 和市场上的同类书籍相比较，本书一个特点是，几乎涵盖了论文的每一个角落，毫无遗漏；另一个特点是注重讲理，而不仅仅告诉读者技能是什么；第三，是为了避免单纯展开的规范形式单调、僵化，文中穿插了哲学、古文、诗词等类比说明，阐述。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	477
1533	法学理论讲义稿	978-7-5620-9442-5	\N	周元著 	\N	1-1	16开	79.00	280.0千字	中国政法大学出版社	272	\N	\N	2019-12-01	/book/9a2c33d5-0bc9-439e-b6f6-1ddad0301c199442-5.jpg	本书讲以作者讲授的“法学理论”课程的讲义为主。该课程作为试点课程参与昆明理工大学实施的教育部、云南省教育厅“全面综合型”研究生课程改革试点项目。在讲义稿之后，以附录形式增加三篇文章，以有助于补充性理解。各篇文章都拟为2万字，三篇总共6万字左右，包括作者博士论文精缩版（博士论文未曾出版）、刊载于《朝阳法律评论?孙国华教授纪念文集》（2018）的作者独撰文章《论马克思主义法理学的使命——从孙国华老师留下的问题谈起》、马克思主义公平正义理论的价值（新写，凝聚作者参与有关课题过程的心得和课题结束后延续性的思考）。?	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	499
1534	反歧视法讲义：文本与案例	978-7-5764-0095-3	\N	刘小楠主编 	\N	1-1	16开	89.00	349.0千字	中国政法大学出版社	388	\N	\N	2021-09-01	/book/932977f5-0d01-4be2-acf1-6e570b7d0ec40095-3.jpg	本书旨在为读者提供反歧视法的基本介绍，与其它课程材料相辅相成，为高校教师、学生和研究者提供学习和研究参考；同时通过对歧视的概念、其所产生的原因和法律补救措施的介绍，为执法人员和决策者提供参考。教材分为三编十五章章：第一编基础理论，介绍反歧视法基本概念、基础理论、法律渊源和主要国家的立法和实践。第二编歧视类型，介绍种族民族、性别、宗教信仰、残障、健康、户籍、性倾向等歧视类型的概念、特征、表现以及反对歧视的相关法律措施。第三编法律救济，介绍歧视的救济机制和法律责任以及专门的反歧视机构。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	681
1535	裁判要素的法律生成及相互转化	978-7-5620-9771-6	\N	潘德勇著 	\N	1-1	16开	85.00	315.0千字	中国政法大学出版社	308	\N	\N	2021-07-01	/book/440eeba4-67cf-43bc-8a16-0d19e040f4799771-6.jpg	本书较为系统地阐述了案件裁判的三要素应根据哪些理论和方法进行解释和论证。通过对若干典型疑难案件裁判的分析，将本书的方法运用于具体案件解决上，实现司法裁判的法律效果与社会效果的统一。疑难案件的司法裁判是理论界和实务界高度关注的问题，当前以疑难案件的司法裁判为题的论著不少见，但以裁判要素的法律生成和相互转化为题目的论著尚不多见。尤其是从学科理论到方法上进行疑难案件论证的，更是少之又少。本书的出版，有助于弥补这方面研究的不足。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	425
1536	“平”：中国传统司法理念及其实践研究	978-7-5764-0133-2	\N	潘萍著 	\N	1-1	32开	69.00	350.0千字	中国政法大学出版社	424	\N	\N	2021-08-01	/book/812a33d4-253c-4dac-9ebb-7a0b97edad560133-2.jpg	在“王道平”的治理秩序观和“维齐非齐”伦理正义观的影响下，传统中国司法理念是“平”，内蕴“等者同等”“不等者不等”“等与不等的辩证变动”三原则。作为传统中国司法理念的“平”不仅贯彻于国家律法、诉讼制度、司法人员培养等方面，还被落实在民事、刑事司法实践中。中国传统司法理念作为中国传统司法文明的重要表现，贯穿于中国传统社会的司法实践中。同时，对于当前司法裁判过程中如何处理民众的正义观念与司法公正之间的关系，如何正确处理情、理、法之间的关系等，以达致公平正义都具有重要的借鉴意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	129
1819	微积分概念发展史	978-7-5760-2258-2	\N	[美]卡尔 ·B. 波耶 著 唐生 译 	平装	1-1	大32开	89.80	\N	华东师范大学出版社	\N	\N	\N	2022-04-01	/book/9829c0e3-106f-44d9-b9dd-cf5819632ff31086309.jpg	本书是关于微积分概念发展历程的经典著作。作者从芝诺悖论开始，以柯西的极限理论、戴德金等人对连续性、数和无穷大理论的发展结束，系统介绍了这些概念和一系列相关探索。既有引人入胜的历史叙述，又有对思想源流的深刻分析；不仅阐释了数学发现的方法，而且阐明了数学思想的基础，使读者意识到数学不是一种技术，而是一种思维习惯。这部数学史经典值得数学教师和数学爱好者认真研读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	177
1537	从法官到律师：行政诉讼二十年	978-7-5620-9918-5	\N	吴宇龙著 	\N	1-1	16开	89.00	290.0千字	中国政法大学出版社	292	\N	\N	2021-04-01	/book/fa196a8a-25bf-4b33-87ef-1845db5594cd9918-5.jpg	本书系作者二十年行政审判工作的总结，共三篇。是中级法院法官视角下的行政法实务类书籍。 第一篇论文篇，包含八篇论文，绝大多数已公开发表或征文获奖。其中，《判不应请：行政诉讼肯定性判决的重构——合法性审查原则的回归》获中国法学会青年论坛2014年一等奖；《论规范性文件审查的相对独立性》、《 房屋征收与补偿案件的行政审判思路》、《行政审判司法建议的特性与完善》均发表于最高人民法院主办的《人民司法?应用》。 第二篇案例篇，包含七篇案例分析，大多数已公开发表或入选典型案例。其中，《卖方单方毁约闯入已交付房屋并调换门锁的行为性质——李*诉**公安局治安行政处罚案》入选最高人民法院中国应用法学研究所编《人民法院案例选》并发表于最高人民法院主办的《人民司法?案例》；《攻击网名能否构成诽谤——杨**诉**公安局公共信息网络安全监察分局治安不予处罚案》、《规划部门认定违法建设行为具有独立可诉性——宋**、王**诉**规划局规划行政确认一案》均发表于《人民司法?案例》；《行政判决可以直接变更行政协议——王**、陈**诉**街道办事处征迁行政协议案》发表于《人民法院报》。 第三篇裁判篇，选择作者主审或作为审判长签发的裁判文书十一篇，包括行政协议、房屋征收（拆迁）、履行法定职责、国家赔偿、海关估价、规范性文件审查、退休工龄认定、行政指导等类型案件，均属于典型案件，具有一定参考价值。其中，《寿**诉**区劳动和社会保障局社会保障行政确认案》运用历史解释法对相关文件作出缩限解释，以保障知青这一特殊群体的正当权益；《孙**诉**区人民政府履职行政复议案》确立了统一政务咨询投诉举报平台出现后履职案件的裁判新规则；《方**诉**县公安局消防行政处罚案》中通过对规范性文件的审查，对《治安管理处罚法》第三十九条规定的“其他供社会公众活动的场所”进行了扩张解释。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	457
1538	首都法学论坛.第17辑	978-7-5764-0126-4	\N	米新丽主编 	\N	1-1	16开	59.00	220.0千字	中国政法大学出版社	216	\N	\N	2021-10-01	/book/cd521eed-0cf2-4c76-9689-d346e88bfad80126-4.jpg	《首都法学论坛》是首都经济贸易大学法学院的系列出版物，目前已经由知识产权出版社出版了13辑。该书已成为首都经济贸易大学法学院扩大自身知名度的阵地，成为了以文会友的平台，也是法学院实现自身发展的有效途径。 《首都法学论坛》融理论研究和实务探讨为一体，以理论法学、应用法学板块对法学的各个领域的理论与实践问题进行探讨。遵循学科知识体系、逻辑体系的设计、编排，将使读者从专家、学者深刻、精辟的学术见解中受到启迪的同时，对学科研究动态总体把握上也获得收益。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	576
1748	遵化诗存	9787811429299	\N	清孙赞元编 石向骞 王雙 孙春青点校 	0	1-1	16开	75.00	\N	燕山大学出版社	\N	\N	\N	2020-04-01	/book/a6cfd509-66eb-4dd5-bbef-6692886386aa1085851.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	987
1548	地图学实习教程	978-7-307-22460-5	\N	何宗宜、蔡永香、高贤君、刘远刚、罗小龙、马潇雅、张方利、范晶晶 主编 	平装	1-1	16开	59.00	\N	武汉大学出版社	\N	\N	\N	2022-01-01	/book/7886ec5a-da31-402b-9864-11d1e4421a9a1084175.jpg	本书由《地图学》实习软件使用基础、地图基础知识实习、地图投影实习、地图语言实习、普通地图表示方法实习、专题地图设计与制作、地图设计与制作实习和几种地图制作实例九章组成。包括地形图分幅编号计算，地图投影的判读，地图投影的计算与数值变换，地图符号设计与制作，地图色彩调配，普通地图要素的制作，水系、地貌和居民地的制图综合，几种常用专题地图设计与制作，地图总体设计，网络地图设计与制作，普通地图（挂图）制作实例，荆江分蓄洪区地图制作实例，影像地图制作实例等30个实习，本书可与《地图学》教材配套使用，也可以单独使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	442
1539	蓟门法学.第十辑	978-7-5764-0102-8	\N	"刘大炜,陈维厚主编" 	\N	1-1	16开	98.00	420.0千字	中国政法大学出版社	383	\N	\N	2021-08-01	/book/eba35f1c-e57a-4573-b53b-d98f7d61fa550102-8.jpg	《蓟门法学》是中国政法大学学术论文的优秀结集，收录了中国政法大学本科生、研究生等不同阶段的学生思想成果。是当代法律学科学生学习水平和研究成果的展示平台。不仅能够促使学生在学习中找到自身感兴趣的问题，更能获得知识的积累和认识的升华。《蓟门法学》内容涉及宪法学、行政法学、法理学、法与经济学、法制史学、军事法学等六个学科。同时今年的论文涉及的题材和形式也更加广泛，有侧重于理论探讨、价值评价的方面；也有取材于实践，注重现实的具体操作；还有对比分析、工具分析等多种方法的使用。从字里行间可以感受到广大学子对知识的剖析应用，对问题的追根究底，对科研探索的坚定执着，对真理追逐的智慧胆识。虽然有些文章和观点还显得比较稚嫩，存在诸多不足，但依然可以启发我们学习、借鉴、思考，鼓励我们实践、质疑、创新。翻阅文集，我们可以感受到学子们闪耀着思想火花的鲜明见解和对学术的执着探索。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	924
1541	民法实务与理论研究	978-7-5620-9851-5	\N	董新中著 	\N	1-1	16开	99.00	460.0千字	中国政法大学出版社	444	\N	\N	2021-10-01	/book/c3cd8e0b-3ce5-48be-a254-d2ba9b2f72de9851-5.jpg	全书共分为十二章。绪论，法、民法、法律人；第一章为案件性质识别; 第二章为民事案件的管辖与主管；第三章为请求权基础分析思维方法在司法实践中的运用；第四章为民法体系、民事法律关系在司法实践中的运用；第五章为民法基本原则在司法实务中的运用；第六章为民事政策、民俗习惯在司法实务中的适用；第七章为民事纠纷案件中的当事人确定；第八章为民事法律关系客体；第九章为民事诉讼中诉讼请求的依据——民事权利、民事利益和义务；第十章为代理；第十一章为诉讼时效与除斥期间。本书另有前言与结语。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	979
1542	清语红楼	978-7-307-22681-4	\N	鲁焕清 著 	平装	1-1	16开	58.00	\N	武汉大学出版社	\N	\N	\N	2022-01-01	/book/2d62b2d6-3190-459d-860e-fddf8973cf071084150.jpg	"本著作立足于《红楼梦》文本细读与研究，分上下两篇。 上篇为“人物篇”，分为“情不能已的贾宝玉”“妙不可言的诸金钗”“美不胜收的小人物”和“目不暇接的众配角”四个章节，既管窥蠡测、以小见大地对贾宝玉、林黛玉、薛宝钗等主人公进行独到的赏析，又对以往红楼研究中很少涉及的春燕、藕官、王太医、“鱼眼睛”群像和“未见其人、却有其名”的女孩等形象进行了探视和比较分析。 下篇为“艺术篇”，分“奇巧魔幻的结构”“奇妙传神的器物”“奇绝精雕的细节”和“奇美动人的诗歌”四个章节，层层剥笋地剖析了小说高超的编织技术，选取杯子、扇子、镜子、斗篷等器物研析了小说的叙事范式，并对穿插、留白、忙中闲笔等写作艺术作了探讨。 "	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	672
1543	分析化学实验（第2版）	9787312043673	\N	金谷，姚奇志，江万权，等 	\N	\N	16开	45.00	\N	中国科学技术大学出版社	\N	\N	\N	2020-01-14	/book/01ca828d-f890-40b2-bc91-2462b46f90d99787312043673.png	本书系统地介绍了化学实验室的安全操作、意外事故的急救处理，剧毒和强腐蚀性物质的安全使用等一系列有关化学分析实验室的基本知识；详细地介绍了分析天平及称量、滴定分析和重量分析的基本操作技术及基本知识，气体、液体、固体试样的采样及试样制备和分解、试剂的选择和溶液配制，常用坩埚的使用和维护，并包括基本操作、滴定分析、光度分析、分离实验，以及综合型、探究型、设计型和开放型等不同类型的实验；内容涉及无机分析、有机分析、生物分析、环境分析、材料分析、食品分析以及与这些学科相关的交叉、综合实验。每一类实验都有选择余地，可根据需要选用。本书的特点是在重视基本操作标准规范和练习的基础上，强调了实验的多元及层次化。这既有利于学生“个性化”的培养，又方便实现“通才”教育的目的。实验内容既与分析化学基础课相关，又符合学科发展的特点和趋势。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	560
1544	光学	9787312051494	\N	王沛，鲁拥华 	\N	\N	16开	99.00	\N	中国科学技术大学出版社	\N	\N	\N	2021-12-31	/book/57d42b28-dac2-4ec9-82f3-9ef8fc0efe419787312051494.png	本书为中国科学技术大学交叉学科基础物理教程之一，是针对非物理专业和对理论物理要求不高的物理专业的大学生学习光学所编写的教材。内容包括波动光学、几何光学以及光的量子性导论.全书以光学实验为基础，从光的物理模型出发，对光线的传播、光学成像、光的干涉、光的衍射、光的偏振与双折射、光与物质的相互作用、光的量子性等问题进行了较全面和深入的阐释，并介绍了光学的发展及其在各个领域中的应用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	871
1545	机器学习及其在金融领域中的应用	9787312052842	\N	苟小菊 	\N	\N	16开	68.00	\N	中国科学技术大学出版社	\N	\N	\N	2021-08-31	/book/6624874c-0195-4c01-b3ac-99a52f1d9dd29787312052842.png	智能控制是继经典控制理论和现代控制工程之后出现的一个先进控制理论。它是在众多学科不断发展以及交叉应用的基础上发展成长起来的，并且还在不断地成长。本书作者具有20多年的进行有关智能控制理论及其应用的经历，并在中国科学技术大学自动化系教授了近20年的“智能系统”的课程。本书是在作为“智能系统”课程，2013年出版的教材《智能控制系统及其应用》基础上，增加补充最新的研究成果而成的教材，主要内容包括：人工神经网络、模糊逻辑系统、模糊神经网络，进化算法及其应用，以及深度学习及其网络与应用5大部分，其中第5部分是这次修订版增添的内容。作者在介绍神经网络理论与模糊集合理论的基础上，对人工神经网络与模糊逻辑控制系统的设计及其应用，以及两者之间的相互关系和相互结合，进行了较深层次上的理论分析与综合，并结合进化算法在控制中的建模与控制的各种实际应用，使读者能够从中了解和掌握运用模糊神经系统的理论与技术进行实际的系统设计和灵活应用的方法。通过介绍近年来有关深度学习及其网络与应用，使得读者能够更加深入地了解和应用好人工神经网络。本书选材新颖，材料翔实，系通性强，通俗易懂。既有理论分析与综合，又有实际系统的设计与应用。本书既可作为高校自动化专业、机械专业、电力电气专业、计算机应用专业及其他相关专业的研究生教学用书，也可供从事智能科学、系统科学、计算机科学、应用数学、自动控制等领域研究的广大科技人员阅读和参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	519
1549	生态文明视野下自然资源法治研究	978-7-5764-0137-0	\N	高桂林、杨雪婧 著 	平装	1-1	16开	49.00	\N	中国政法大学出版社	\N	\N	\N	2021-12-01	/book/67033f80-7fac-4b78-8367-639d1f3343451084176.jpg	生态文明是人类在认识自然和改造自然过程中所取得的积极成果,它表现为人类能够依据规律建立和保证与自然和谐的关系,使人类在这种和谐的关系中生存和发展。生态法治既意味着法治理念在环境保护领域的贯彻实施，也意味着生态学和生态主义价值观对法律体系的影响和渗透。本书以生态文明法治建设为视角，立足于人与自然资源和谐发展的基本关系，以我国自然资源法的制度和内容为研究对象，通过规范分析、历史分析和对比分析的方法，试图通过对我国自然资源法具体制度内容的梳理，总结过去我们在处理人与自然关系中的问题和经验，找出我国实现自然资源生态法治的路径，得出我国自然资源法应以生态文明为核心思想来发展、完善的结论。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	629
1550	中南财经政法大学学者学术人生：七秩金融	978-7-307-22712-5	\N	汪平、余明桂 主编 	平装	1-1	16开	48.00	\N	武汉大学出版社	\N	\N	\N	2021-07-01	/book/126c708a-30ff-4a7a-b8cc-1946589fe2d01084181.jpg	本书收录了中南财经政法大学金融学院18位知名专家学者专访或回忆文稿，浓缩了这18位教授治学为人的光辉人生，也向读者展现这18位学者的学术风范以及他们对中南财经政法大学金融学院的建设与发展作出的贡献。以此向无数为中南财经政法大学金融学科呕心沥血的师生致敬，向广大关心中南财经政法大学金融学科发展的社会各界致敬。本书收录了18位中南财经政法大学金融学院知名专家学者的专访或者会议文稿，浓缩了一位位园丁治学为人的光辉人生。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	872
1551	水文气候学实习教程	978-7-307-22383-7	\N	覃伟荣 主编；程秋华、张亚丽、李素霞 副主编 	平装	1-1	16开	32.00	\N	武汉大学出版社	\N	\N	\N	2022-01-01	/book/e3d3849a-5fcd-4f00-94d4-6f1d7a5ef9fd1084186.jpg	本书为地理学综合实验实习指导丛书之一，依据水文学，气候学等专业编制，着重培养学生的理论与实践能力。本教材是针对北部湾地区水文气候现象制定的实习指导书，主要分为六个部分，由实习总体介绍、广西水资源情况等内容组成。教材注重培养学生的实践能力以及野外操作能力，是一门应用型的课程教材。本书针对北部湾地区水文气候现象，注重课程教学实践，是一门应用型的课程教材。主要内容分为六个部分八个章节，主要介绍实习总体情况，广西水资源情况，水文气候的基本原理和基础知识，实习与水文气候结合教学路线等组成。教材注重培养学生的实践能力以及野外操作能力，是一门应用型的课程教材。可供相关教学研究参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	673
1552	信息描述	978-7-307-22450-6	\N	吴丹 主编 	平装	1-1	16开	68.00	\N	武汉大学出版社	\N	\N	\N	2022-01-01	/book/1656adc2-d472-4cfd-98da-d842ca02adcb1084194.jpg	本教材在文献信息编目的基础上，结合大数据环境，将语义信息组织、关联数据等众多网络信息描述的新内容纳入其中，紧跟目前该领域的前沿热点。全面介绍信息描述的基本理论、基本方法和实践发展。主要内容包括机读目录MARC格式，利用CNMARC对各类型信息资源进行描述，网络信息描述的标记语言基础知识、资源描述框架、元数据的基本概念、DC元数据的元素与修饰词，以及应用元数据进行网络信息资源描述的分析设计方法和语义环境下信息描述的发展等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	528
1553	翻译安全学	978-7-5618-6984-0	\N	许建忠 	平装	1-1	大32开	48.00	\N	天津大学出版社	\N	\N	\N	2022-02-01	/book/a45aab99-2ac5-4d83-bc5a-7f95df0aa0781084202.jpg	无论从安全研究视角，还是从翻译研究视角来看，中国翻译安全问题已经进入人们的视野，但对其进行较系统研究还较少见。 本书紧紧围绕翻译安全这一主体，从翻译与安全之关系入手，以翻译系统为主线，以安全体系为横断面，建立起纵横交织的整体结构和框架。 本书内容涉及翻译安全的基本问题、翻译安全史观、翻译安全生产观、翻译生产安全规则观、翻译安全保障观、翻译安全发展观等，对中国翻译安全问题做了较为详细的论述和解读。 本书的出版一方面以期为提升国家翻译安全战略、国家稳步发展保驾护航献出绵薄之力；另一方面以期为实现翻译这一跨语言文化交流活动成为国家民族间增信释疑、凝心聚力的桥梁纽带的目标，共建人类文化交流命运共同体，促进世界和平与发展做出贡献。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	154
1554	叶芝诗解	9787544667593	\N	傅浩 	精装	1-1	16开	148.00	600.0千字	上海外语教育出版社	512	\N	\N	2022-01-01	/book/c6a4e2d0-1f75-459e-b48b-33f8b97e5a971084203.jpg	本书选取爱尔兰大诗人威廉·巴特勒·叶芝（William Butler Yeats,1865-1939)诗作89首英语原文， 配以汉语译文，逐首详加解说，意在为汉语读者提供一种对叶芝其诗其人的理解和认识。形式融合中外注疏学传统而有所发扬，解说不拘一格，紧扣作品，不作无端发挥。方法有破有立，内外研究结合，摈弃所谓意图谬误之说，而以探究作者本意为鹄的，采用文本分析法细读作品，力求无微不至，同时从诗人自注、 自传、回忆录、日记、书信、随笔、小说、剧作、广播稿等一手资料，以及诗人传记、亲友回忆、文学传统、历史事实等背景资料中发掘旁证。见解不乏独到之处，往往发人所未曾发，必要时亦顺便指出国内外叶芝研究者的谬误。 作为一部从形式到内容都颇具特色的叶芝研究专著，本书信息丰富，表述平实，可谓雅俗共赏，可供文学创作者借鉴，研究者参考，教学者使用，爱好者消遣。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	109
1563	苗刀：套路与实战技法	9787500960331	\N	张万龙 	0	1-1	32开	29.00	180.0千字	人民体育出版社	195	\N	\N	2021-12-01	/book/9990c24f-e80d-4b40-aa3d-1b3a0bc5935d1084264.png	苗刀是我国古代优秀的冷兵器之一，最早可以追溯至西汉时期，距今已有2000年的历史。现今的苗刀刀法经过数代武术家的改进，具有演练、防身、健身的作用。《苗刀——套路与实战技法》一书对苗刀的起源及历史传承、风格特点做了介绍，着重对苗刀一二路练法及套路实战用法进行说明。作者对一二路苗刀及套路实战都进行了配图，图上还有详细的线路，对于读者学习与进一步研究都十分有帮助。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	138
1562	柔击术（《柔击道》健康运动功法系列丛书）	9787500960669	\N	何明清 拓跋俊飞 陈林华 	0	1-1	32开	26.00	162.0千字	人民体育出版社	190	\N	\N	2021-12-01	/book/f5a366a2-c8c1-4b7d-86f4-f50d198ece971084256.png	本书作者在习武之余经常亲近大自然，深入观察、模仿百鸟和百兽，并用道家的理论体系和中华传统文化精髓去解读各种不同动物的动作习性，并逐渐创立了柔击术。本书主要介绍柔击术功法的理论体系、功法秘诀、基本动作及养生功效等内容。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	572
1555	司法会计学教程	978-7-307-22783-5	\N	蒙远鹰 主编 	平装	1-1	16开	58.00	\N	武汉大学出版社	\N	\N	\N	2022-02-01	/book/21f5c211-dc86-46fb-a6fa-e41a91b4650c1084204.jpg	司法会计学是运用法学、会计学、审计学的原理来查明经济案件和其他案件中有关财务事实真相，为诉讼活动提供依据的一种诉讼活动，并同其他门类会计工作相区别且独立存在于社会实践中。 本书将司法会计的基本理论和实践有机结合，深入浅出，案例丰富，使教材内容的司法实践融合在一起，达到直接培养面向实务工作第一线的复合型人才的目的。本书是一本交叉学科的教材,将司法会计的基本理论和实践有机结合，案例丰富，使教材内容的司法实践融合在一起，达到直接培养面向实务工作第一线的复合型人才的目的。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	736
1556	2022贺银成国家临床执业及助理医师资格考试实践技能应试指南	978-7-304-11061-1	\N	贺银成 	平装	1-1	16开	99.00	817.0千字	国家开放大学出版社	\N	\N	\N	2021-12-01	/book/216a1455-dd2f-4f64-a35c-ca73c412372f1084212.jpg	实践技能 本书作者贺银成是医考辅导顶级名师、国内畅销的医考图书作者，在考研西医综合、临床执业医师及临床执业助理医师资格考试领域具有全国性的影响力，其编著的“贺银成考研西医书系”“贺银成医考书系”以易用、好记、考试原题命中率高而被全国考生奉为经典。 本书是作者在讲授实践技能强化课程的培训教材基础上编著而成，结合多年来对实践技能考试的潜心研究，全书按照实践技能三站式考试的内容编排，第一站考试内容为临床思维能力，第二站考试内容为体格检查，第三站考查基本操作。本书对所涉考点的详细操作步骤、易犯错误、常考问题进行了细致讲解，并甄选适量典型例题，帮助考生高效复习。 本书适合所有参加国家临床执业及助理医师资格考试的考生以及广大医学工作者。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	862
1557	2022贺银成国家临床执业助理医师资格考试辅导讲义同步练习	978-7-304-11058-1	\N	贺银成 	平装	1-1	16开	98.00	893.0千字	国家开放大学出版社	\N	\N	\N	2021-12-01	/book/c237bfc1-9aa1-4448-9492-eddab7267c4e1084216.jpg	本书作者贺银成是医考辅导顶级名师、国内畅销的医考图书作者，在考研西医综合、临床执业医师及临床执业助理医师资格考试领域具有全国性的影响力，其编著的“贺银成考研西医书系”“贺银成医考书系”以易用、好记、考试原题命中率高而被全国考生奉为经典。 本书按照《贺银成2022国家临床执业助理医师资格考试辅导讲义（上、下册）》的体例和顺序进行编排，是配合讲义使用的同步练习题。全书共分十七篇，包括生物化学、生理学、病理学、药理学、医学心理学、医学伦理学、医学统计学、预防医学、卫生法规、内科学（含诊断学）、传染病学与皮肤性病学、神经病学、精神病学、外科学、妇产科学、儿科学和实践综合。本书中所设计的试题与真题的出题方式及命题风格基本一致，并且将相关知识点、易混点以试题形式对比排列，帮助考生理解和记忆，是临床执业助理医师资格考试的专业题库。 本书适合所有参加国家临床执业助理医师资格考试的考生以及广大医学工作者。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	575
1558	高等教育运动医学&运动康复精品教材——运动医学	978-7-5644-2107-6	\N	王琳 	平装	1-1	16开	48.00	\N	北京体育大学出版社	\N	\N	\N	2020-06-01	/book/2988311e-bc02-4914-844e-3d6312edaec01084225.jpg	《运动医学》是体育院校的重要实用性课程。本教材根据教学大纲，针对体育院校和师范大学体育学院的本科生、专科生，体育职业教育的本、专科专业，突出教学内容的针对性和实用性，以竞技学院学生适用为目标，淡化过去教材中的很多治疗内容。教材在保持系统性的基础上，在运动训练的医务监督、运动性病症和运动损伤部分都尽可能补充了最新的研究进展和理念，让学生能够获得最新的知识。在运动损伤部分增加了局部解剖学、病理简介的内容，提高教材的可读性，帮助学生更好地理解损伤愈合过程，让学生在掌握应用知识的同时理解原理，以期提高今后对知识的应用能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	751
1559	《庄子》中“孔子”形象研究	9787569105094	\N	高庆荣 	平装	1-1	16开	80.00	\N	贵州大学出版社	\N	\N	\N	2021-12-01	/book/d4d0308b-31ae-46bf-9723-b93f64342e1f1084227.jpg	《庄子》是中国思想史上的一座高峰，诗意地说、思辨地说、逻辑地说在其哲学中彼此交融，“以卮言为曼衍，以重言为真，以寓言为广”是《庄子》一书极为突出的特点。相应的，推动寓言情节发展的寓言形象就成为解读《庄子》思想重要的元素。 　　《中“孔子”形象研究/汕大马理论文丛》根据《庄子》的这一特点，以书中出现频率的“孔子”形象作为主要研究对象，站在“孔子”形象阐释史的角度，探讨了《庄子》内、外、杂篇的思想变化在“孔子”形象上的表现。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	569
1560	组织行为学	978-7-5121-4670-9	\N	刘沁易 编著 	平装	1-1	16开	39.00	\N	北京交通大学出版社	\N	\N	\N	2022-03-01	/book/ee89c3a9-dd83-48e7-bb24-a14d93f1f76a1084235.jpg	本书共六个项目，分别是：项目一走进组织行为学，通过对组织、组织行为等的简单介绍，让读者对组织行为学知识形成一个初步的了解；项目二个体行为与管理，主要介绍个体的多种肢体语言和态度等的形成；项目三激励理论与运用，主要介绍目前组织行为学中比较著名的个体激励理论及其实际运用；项目四群体，结合前面介绍的个体知识延伸至个体组合的介绍，了解和认识群体组织的特征；项目五领导及领导行为，这是对于前面群体认识的升华，在了解群体之后如何带领群体，如何激励群体。项目六组织文化和组织变革，通过对文化的影响力进一步深入对人的管理核心，基本把握管理组织的重点和方式。 本书适合作为高职高专院校管理类专业学生的教材，也适合作为相关培训的教学用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	345
1561	中小企业运营管理	978-7-5121-4654-9	\N	魏翠芬 主编 	平装	1-1	16开	43.00	\N	北京交通大学出版社	\N	\N	\N	2022-03-01	/book/f2d5cc87-ad22-45f2-97e0-c6a720d32b591084236.jpg	本书以初创型中小企业为研究对象，从企业创办、营销推广、物流管理、财务管理、人力资源管理、优惠政策获取等方面，全面介绍中小企业运营管理基本知识。本书适用于高职高专层次工商管理类、财经商贸类的专业使用。本书特点是： （1）针对性。专门为初创型中小企业进行设计，具有很强的针对性。 （2）实用性。培养企业的运营管理基本技能，适合于中小企业基层管理者和创业者。 （3）时代性。解读促进中小企业发展的最新优惠政策，紧贴时代脉搏。 （4）校企合作开发。公司高管亲自参与本书的框架结构与内容设计。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	598
1564	羽毛球运动500问	9787500960485	\N	朱建国 	0	1-1	16开	65.00	187.0千字	人民体育出版社	167	\N	\N	2021-12-01	/book/a5654121-3af4-409c-82c2-01f8f1fc2d6c1084265.jpg	《羽毛球运动500问》主要从羽毛球运动爱好者锻炼为出发点：第一，羽毛球运动的基础知识；第二，羽毛球运动的场地、器材；第三，羽毛球运动基本技术；第四，羽毛球运动战术；第五，羽毛球运动的常见损伤防护；第六，羽毛球运动的康复；第七，羽毛球运动的保健；第八，羽毛球运动的营养。 本书围绕这八个方面给羽毛球爱好者提出他们在平时进行羽毛球锻炼时出现的1000个问题，并作出解答。有利于羽毛球锻炼者随时解决自己运动中遇到的问题，可以作为他们随身的常备手册。 本书是用问答的形式呈现，针对性更强，仅仅只有文字叙述，一些问题还会配有插图，这样便于读者更好地理解。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	494
1565	不远万里：国际友人与20世纪中国	978-7-5671-4417-0	\N	张慧瑜 李云雷 主编 	平装	1-1	16开	55.00	\N	上海大学出版社	\N	\N	\N	2022-01-01	/book/cecb5429-ca96-4c42-9f5a-d52a2e23e3a71084274.jpg	在20世纪中国历史中有一批支持中国革命和社会主义建设的国际友人，他们撰写了大量的新闻报道，对外传播20世纪中国社会的巨变，有一些留在中国，参与到教育、医疗、外交等事务中，成为中国人民的老朋友。本书用非虚构写作的方式讲述这些国际友人的中国故事。国际友人的个体生命经验与20世纪全球进步运动的思想与行动网络交织，与中国的革命与社会建设相互作用，呈现出一个复杂、动态的全球20世纪时代景观，也为反思当下的国际关系和全球秩序提供了独特的视野。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	223
1566	学府与学术——一位地方大学校长的12年探索	9787564947545	\N	李小建 	平装	1-1	16开	168.00	\N	河南大学出版社	\N	\N	\N	2021-06-01	/book/1dade963-5357-44b4-bf7b-8f1ef95352471084281.jpg	一所大学的阶段发展史具有一个时代的鲜明印记。河南财经政法大学 2003-2015年的发展,经历了建设新校区、水平评估取得优秀等次、合并组建大学的过程。本书为一位大学校长把12年的思考与实践集结成书,以期透过个例,整理地方大学发展思路,寻求地方大学发展路径，探索地方大学发展经验。 本书试图梳理地方大学从“内抓机制、外引资源、拓展空间”外延为主的发展,到 “以学术为核心，以质量、特色、人才、制度为基点”内涵兴校的发展路径脉络，厘清从“学术兴校”到“一流本科教育”再到“精细化管理”的实践脉络,揭示地方大 学在阶段发展过程中所应遵循的大学本质、所应乘持的发展理念、所应明晰的发展思路。本书对于地方大学建设具有重要的参考意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	681
1567	中华手语大系（视听版）（第一辑）（三册）	978-7-309-15919-6	\N	郑璇 邰丽华 主编 	平装	1-1	16开	98.00	405.0千字	复旦大学出版社	436	\N	\N	2022-01-01	/book/74dd89c7-6f38-4035-8ac8-b9ba89a190341084282.jpg	《中华手语大系》是一套用中国手语诠释中华优秀传统文化的精美读本，可作为特殊教育学校优秀传统文化教育的教材和健听人的手语学习指南。第一辑由《手语说汉字》《手语读》《手语诵唐诗》三本分册构成，组建字、句、诗的新手语学习体系。 从古汉字、《论语》、唐诗文献中，甄选出华人常学常用、耳熟能详、广为传颂的字、句、诗，进行：疑难字词疏通；全句手语翻译；全句拓展讲解；全书配以真人视频示范，让中国及华语区听障学生，通过手语感悟中华优秀传统文化中所蕴藏的哲理和智慧。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	937
1568	英汉翻译理论与实践	9787566323477	\N	张发勇、纵兆荣 主编 	平装	1-1	16开	58.00	\N	对外经济贸易大学出版社	\N	\N	\N	2022-01-01	/book/ff28923f-0df1-4654-bf36-ce6478bb63cb1084284.jpg	　内容简介 　　本书以理论、词语、句法和篇章四个层面为编写主线。在具体内容的安排上，每个章节均有理论论述、实例（佐证理论）、译文赏析（评析翻译技巧和要点）、讲解题（提供翻译实践的技巧和要领）和练习题。 　　本书特色 　　1. 整体设计上，贯彻“以学生为主体，教师为主导”的教学理念，为开展课堂互动，提供了丰富的教学内容；2. 理论与实践相结合；3. 内容设计由浅入深，循序渐进的编写模式；4. 取材上，实行多学科交叉，选材内容涵盖面广泛。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	564
1569	计算机化自适应测验	978-7-5191-2765-7	\N	袁振国 主编 郑蝉金、汪腾 	0	1-1	16开	59.00	78.0千字	教育科学出版社	140	\N	\N	2022-01-21	/book/c07b235d-6b01-43e0-811d-e2f97d5c7fcc1084300.jpg	计算机化自适应测验是一种全新的测评形式，它采取了“因人施测”“裁体量衣”的自适应测评思想，为每一个被试选择一份最适合他/她的测验，即为每个个体选择一份具有最小测量误差（最大测量信度）的测量工具。与传统纸笔测验相比，计算机化自适应测验不仅可以达到更高的测量 度，还具有减少测验长度、减轻被试负担等优势。 本书将用通俗的语言深入浅出地介绍计算机化自适应测验的历史、主要理论与技术，通过现实中的项目来说明计算机化自适应测验在高利害考试、个性化学习反馈、职业资格考试中的应用，最后梳理计算机化测验在个性化学习中的重要作用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	363
1570	现代女性之声：华语电影界的歌女	9787563830770	\N	［美］马彦君（Jean Ma），朱安博 等 译 	0	1-1	16开	60.00	264.0千字	首都经济贸易大学出版社	232	\N	\N	2022-02-01	/book/cda03bfa-9979-4ee0-9c9a-de08103703841084514.jpg	从有声电影时代开始，歌女就深深吸引着中国观众。在《现代女性之声》一书中，作者马彦君（Jean Ma）展示了歌女的崛起如何证明女性在城市现代化中角色的变化，以及电影和音乐产业之间复杂的共生关系。无论是以戏剧女演员、歌舞女郎、革命女郎还是乡村女郎的身份出现的歌女，都属于中国现代女性，而她们半个多世纪的流行表明了中国电影抒情表达的独特性别特征。作者通过介绍中国电影史上许多最引人注目的女演员，比如周璇和葛兰的银幕内外的职业生涯，引导读者了解电影史，揭示了国家危机和冷战冲突是如何塑造歌女形象的。作为连接战前上海和战后香港电影文化的桥梁，歌女展现了连接这两个时期和地区的紧密网络，跨越了战争、国家政治和地理的界限。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	785
1611	安里村往事：胶东一个乡村的记忆	978-7-5623-6889-2	\N	盖龙云 主编 	平装	1-1	16开	78.00	362.0千字	华南理工大学出版社	295	\N	\N	2021-12-01	/book/5a8b8303-364a-446f-bd98-0b3fcb89827c1084716.jpg	村庄是国家的“细胞”，从一定程度上来说，一个村庄的变迁就是一个国家发展变化的缩影——《安里村往事：胶东一个乡村的记忆》讲述的就是位于胶东半岛上的一个普通村庄里的人间烟火。 本书的80多位作者，都是安里村人或其直系亲属。他们熟悉自己的村庄，了解村庄的历史，虽然不是专业作家，但他们用通俗平实的文字，原汁原味地还原了人物、山河，事件的形、神、趣、魂。书中蕴含的人性之美、文明之美、朴素之美，值得我们细细品味。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	968
1571	人力资源服务业管理理论与实务	9787563833153	\N	范围 	0	1-1	16开	55.00	279.0千字	首都经济贸易大学出版社	360	\N	\N	2022-02-01	/book/bf075aeb-f36e-44af-9923-7ab85a9cf7db1084519.jpg	本书是人力资源系列丛书中的一本。全书分为十五章，介绍了人力资源服务的属性、特征和相关主体，分析了人力资源服务的核心内容和发展模式，人力资源服务的业务制度和流程设计，以及人才招聘服务商业模式创新，介绍了高级人才寻访服务的业务类型、人力资源培训和咨询服务、劳动派遣服务的概念、类型、业务制度、流程等，并对人力资源外包服务，流动人员人事档案管理的模式创新、信息化建设进行了论述，对就业服务、职业指导、人力资源管理信息化服务、发展政策进行了详细论述；最后还探讨了人力资源服务行业的规范建设和新业态。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	498
1572	中国税务师行业发展报告（2020）	9787563833092	\N	北京哲学社会科学国家税收法律研究基地 等 	0	1-1	16开	58.00	162.0千字	首都经济贸易大学出版社	232	\N	\N	2022-01-01	/book/18084663-ba2d-4909-bf0f-d00fb055da271084525.jpg	《中国税务师行业发展报告（2020）》由北京哲学社会科学国家税收法律研究基地、首都经济贸易大学财政税务学院和中国税收筹划研究会共同主编，资料详实、内容丰富、结构紧凑、逻辑严谨，可读性颇强，是比较具有参考价值的年度性发展报告。全书从税务师行业发展概述、部分国家和地区税务师发展情况及经验借鉴、国内税务师行业现状分析、提高税务师行业水平和素质、涉税服务市场面临的机遇挑战、新环境下税务师行业发展思路等方面对税务师行业的发展状况做了详细的介绍，同时收录了当下税收领域内人才关于涉税服务、税收法庭、税收筹划等方面的思想碰撞与经验交流的精彩论述，对税务师行业与高校相关学科的进一步发展具有借鉴意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	196
1658	硅基集成芯片制造工艺原理	978-7-309-14995-1	\N	李炳宗 茹国平 屈新萍 蒋玉龙 编著 	平装	1-1	16开	298.00	1392.0千字	复旦大学出版社	862	\N	\N	2021-11-01	/book/f8256a6d-c4be-4397-9f77-85dca32503d91085129.jpg	自1958年集成电路诞生以来，硅基集成芯片制造技术迅速发展，现今已经进入亚5nm时代。硅基芯片制造技术可以概括为一系列微细加工硅片技术，这些愈益精密的微细加工技术持续创新与升级，源于20世纪初以来现代物理等物质科学知识的长期积累。充分了解各种微细加工技术背后的科学原理，是理解和掌握集成芯片制造工艺技术的基础。 全书共20章。前8章概述硅基集成芯片从小规模到极大规模集成的创新演进路径，分析集成芯片制造技术快速升级换代的独特规律，研判器件微小型化技术与摩尔规律的内在联系，并对半导体物理和晶体管原理基础理论知识作概要讨论。后12章分别阐述热氧化、硅单晶与外延生长及SOI晶片、精密图形光刻、扩散掺杂、离子注入与快速退火、PVD与CVD及ALD薄膜淀积、高密度等离子体刻蚀、金属硅化物自对准接触和多层金属互连等多种集成芯片微细加工关键技术，着力分析讨论各种微细加工技术的物理、化学基础原理与规律，其间对制造工艺中广泛应用的真空技术与等离子体技术作概要介绍。本书特别关注进入21世纪以来正在发展的集成芯片制造技术的新结构、新材料、新工艺和新趋势，介绍包括高密度超微立体晶体管和纳米CMOS等集成器件的典型结构与制造工艺。 This book focuses on the Si micro-fabrication technology. Since the invention of integrated circuits (IC) in 1958, the Si micro-fabrication technology has been developing rapidly thanks to the advances in modern physics and other fundamental sciences from the beginning of the 20th century. Fully understanding the scientific principles underlying the various micro-fabrication technologies is the basis for studying and mastering the Si IC chip process technology. This book consists of 20 chapters. The first 8 chapters outline the evolution and innovation of the CMOS and bipolar IC process technology over the past six decades, analyze the unique law of Si IC micro-fabrication technology evolution, discuss the relationship between the scaling-down principle and the Moore’s Law, and review the basic theories of semiconductor physics and transistors. The following 12 chapters elaborate on such key process technologies of Si IC chips as thermal oxidation, Si epitaxial growth and SOI material, lithography, dopant diffusion, ion implant and RTA, PVD/CVD/ALD thin films, high density plasma etching, salicide contact and multi-level interconnection. The physical and chemical principles underlying the micro-fabrication technology are analyzed and discussed for better understanding. Besides, more attention is paid to the fabrication technology of nano-CMOS chips with new structures and materials.	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	199
1573	社会工作者职业生态研究	9787563832705	\N	杨旭华 	0	1-1	16开	48.00	304.0千字	首都经济贸易大学出版社	216	\N	\N	2022-01-01	/book/437938b4-6f18-4d78-8ef2-9373f8f3de9d1084531.jpg	这本社会工作者职业生态研究是一本研究我国社会工作者发展脉络、现状以及新冠肺炎疫情下社会工作者工作现状的学术著作。通过系统的梳理和研究，对我国社会工作者未来的发展提出政策建议。本书主要内容涉及文献研究、社会工作者职业认同的实证研究、社会工作者组织认同的实证研究、新冠肺炎疫情中的社会工作者、国外社会工作者的培养发展管理体系、我国社会工作者的政策分析与发展建议等。书末附有社会工作者职业生态调查问卷和采访提纲等。全书条理清晰，内容丰富，采访了大量社会工作一线人员，收集到了大量第一手鲜活资料，使得本书言之有物，言之有据。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	356
1574	不曾远去的春天	9787569516203	\N	王芬霞 	平装	1-1	大32开	40.00	\N	陕西师范大学出版总社	\N	\N	\N	2020-08-01	/book/928f1540-54d6-487b-89c8-ce96e5f87f3c1084540.png	　　本书稿为诗歌集，包括故乡情思、如歌岁月、爱的絮语和塞北江南四个部分，共收录诗歌200余首，分别从故乡、岁月、爱情、风光等方面展现了时代画卷和风土人情，表达了作者对故乡的思念之情；记录了时代的奋斗历史；抒发了作者对故人、故乡的情愫；讴歌了塞北高原壮丽的山川。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	969
1575	金斯伯格访谈录：RBG给未来世代的声音	978-7-5213-2887-5	\N	[美]杰弗里·罗森（Jeffrey Rosen） 译者：李磊 	平装	1-1	32开	59.00	167.0千字	外语教学与研究出版社	\N	\N	\N	2022-03-01	/book/505b2bc6-3f09-4a9c-b374-ba536c4202311084547.jpg	她是哥伦比亚大学法学院首位获得终身教职的女性。 她是美国最高法院历史上第二位女性大法官，也是美国宪法改革的标杆人物和“异见分子”。 她有专属的昵称、粉丝网站、卡通形象和其他文创周边，已成为美国的文化名片之一。 她曾三次战胜癌症，是健身达人，85岁时还能做20个俯卧撑。 她是RBG，鲁斯·巴德·金斯伯格。 本书是金斯伯格大法官亲手修订的思想传记、老友访谈，记录了杰弗里·罗森与金斯伯格这两位老友持续二十年的对话，金斯伯格毫无保留地分享了一位大法官眼中的时代议题，直击美国种族、性别和极化政治之思，也风趣、幽默地谈论生活与爱，以及针锋相对却又彼此敬服的同事情谊。 对话既呈现出金斯伯格在具体案件中追求平等、正义的深思熟虑，也还原了法袍之下的这位女性，她时而严肃时而风趣，真诚而意志坚定，对生活充满热情。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	841
1576	学前教育专业保教实习指导手册（第二版）	978-7-307-22891-7	\N	卓萍、汤晓宁 主编 	平装	1-1	大32开	30.00	\N	武汉大学出版社	\N	\N	\N	2022-02-01	/book/116ea22b-eef8-4d3a-9f17-2bbc8e37e0e91084551.jpg	目前职业教育正在蓬勃发展，前景可观。本书此次修订正好迎合了当前市场的变革和需要。托育教育专业是这几年学前教育新上的专业，主张双导师制，也就是专业院校与实习单位各自实行教育实践指导教师，能促进幼儿园教师的专业成长和专业专任教师的教学研究，意义非常重大。本书是在2016年第一版基础上的修订版，以训练学前教育专业学生保教岗位职业能力为宗旨，以学前教育专业人才培养方案的“职场认知-保育实习-教育见习-教育实习-顶岗实习”教育实践路径为线索，以操作性文本为基本内容，使本书具有鲜明的实用性、系统性和工具性的特点。即适合学前教育专业学生实习使用，也适合幼儿园教师配合专业院校做好实习指导和效果评价使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	211
1577	家事犯罪防控研究	978-7-5620-8979-7	\N	周琳 	平装	1-1	大32开	56.00	\N	中国政法大学出版社	\N	\N	\N	2019-04-01	/book/dc7ec860-9e78-4ec6-a200-833df54c3e821084557.jpg	本书是对家事犯罪防控的专题研究，全书共六章，包括第一章 家事犯罪的类型及认定，论述了未成年人犯罪、老年人犯罪、家庭暴力犯罪、破坏军婚犯罪认定研究；第二章 家事犯罪防控，论述了古代中国的家事犯罪、家庭暴力犯罪防控；第三章 各类家事犯罪的成因分析，论述了家庭暴力的发生机制和主体范围等，第四章 家事犯罪刑事司法适用，论述了未成年人犯罪、老年人犯罪的在司法实践中的刑事处遇；第五章 家事犯罪矫正教育，论述了未成年人社区服刑人员心理矫正机制构建等；第六章 家事犯罪的立法完善，论述了未成年人监护中的国家责任完善与加强，关于遗弃罪的缓刑适用探讨。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	529
1619	日语口译	978-7-301-15714-5	9787301157145	丁莉 	\N	1	16开	48.00	338.0千字	北京大学出版社	256	7301	\N	\N	/book/88e3db87-3326-4bea-8f94-230ca0381a501571403.jpg	本教材是为自考生而编写的。书中编写了学习者应掌握的大量生活所需的各方面的词汇、惯用日语表达的多种形式、常用的敬语表达及与口译内容相关的知识等内容。旨在使学习者掌握日语口译的基本技能，能够从事一般性口译工作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	782
1578	基础有机化学学习指导	978-7-5645-8243-2	\N	丁姣 	0	1-1	16开	39.00	308.0千字	郑州大学出版社	198	\N	12	2022-02-01	/book/dc6c5323-6a78-40e4-859f-b58bc62589841084564.jpg	本书主要根据教材内容形成每章习题指导和练习，主要包括三大部分：第一部分为各章提要和小结，对各章所涉及的重要概念和基础知识进行系统归纳。第二部分为综合练习，是按有机化学的主要题型分类，主要分为命名、完成反应方程式、鉴别、合成和推断题。综合练习可作为课后作业布置，通过大量的练习，学生可进一步领会有机化学课程的教学要求，有效提高成绩。第三部分为参考答案。该部分提供第二部分综合练习的答案，以及部分典型题型的分析，旨在提供解题思路和方法，同时提供参考答案也方便学生对第二部分综合练习进行自测和自评，有效提高自学效果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	494
1595	工程力学	9787560662206	\N	张红艳 	\N	1-1	16开	39.00	371.0千字	西安电子科技大学出版社	252	\N	10	2022-02-08	/book/edbd0e6e-4dea-4843-8688-4170b144cce49787560662206.jpg	本书分为11章及2个附录，内容涵盖构件的静力学分析、杆件的基本变形及组合变形的强度和刚度问题、应力状态分析、强度理论和压杆稳定性等知识。 除第1章外， 每章末都附有思考题和习题。 本书注重理论联系工程实际，引入大量涉及工程领域的实例和习题，特别引入工程中发生的经典案例，突出强调工程应用性，系统介绍力学的相关基础知识，反映现代基础力学分析、设计新方法。 本书可作为普通高等院校非力学专业中、少学时的“工程力学”课程教材，也可作为专科、成人教育的“工程力学”课程教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	769
1579	作业治疗技术导论	978-7-5645-8205-0	\N	王小井 李婉莹 主编 	0	1-1	16开	59.00	520.0千字	郑州大学出版社	263	\N	8	2022-02-01	/book/73022453-9f42-4a29-a40d-0aa58d042ce71084566.jpg	"作业治疗技术是康复医学中的一个重要组成部分，通过有目的性和选择性的作业活动,促进患者在日常生活、工作、学习、休闲等活动中的功能恢复或重建,是患者回归家庭和社会的桥梁。本书重点介绍了作业治疗常用技术的概念、原则、特点、种类、基本理论和操作方法等，突出作业治疗技术的基本理论、基本知识、基本技能。主要内容包括作业治疗概述、作业评定及活动分析、日常生活活动能力训练、治疗性作业活动、认知功能障碍训练、感觉统合治疗、压力治疗、辅助技术、环境调适、职业康复、作业治疗记录的撰写。为了便于学生自学和教师教学,编者丰富了教材的数字内容,增加了“扫一扫”“练习题”“操作附录”等模块,正文中随文添加相关内容的图片和视频等。"	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	470
1580	词谱辨正	978-7-5645-7349-2	\N	张培阳 	0	1-1	16开	68.00	227.0千字	郑州大学出版社	210	\N	11	2022-02-01	/book/3bb5c09f-ab94-475f-82cd-8238026842e21084574.jpg	本书梳理了从清代万树《词律》到现代龙榆生的《唐宋词格律》，古今著名词谱对于相关词调格律和体式的考索，往往错漏百出，不胜俯拾。本书根据词律的结构、言数、句数、用韵、叠字、句法、对仗和平仄等八个要素，全面而细致地考察了《醉太平》《昭君怨》《锦帐春》《人月圆》《桃源忆故人》《乌夜啼》《太常引》《留春令》《醉花阴》《天仙子》《河满子》《暗香》等十二个重要词调的格律和体式。 本书部分章节的文字曾在国内专业学术刊物发表，并有一定的影响。本书既对“前人之作时有参照”，又时有新观点、新发现，且行文采录词例丰富、翔实，实为该领域一部不可多得之作；无论对于相关学术研究，还是今人的旧体诗词创作均有参考价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	560
1581	脐疗	978-7-5645-8355-2	\N	王季春 	0	1-1	16开	58.00	145.0千字	郑州大学出版社	176	\N	15	2022-01-01	/book/d6ce98ab-8b82-4cc6-b557-06433dfe28ac1084582.jpg	脐疗，为中医外治法，是指将中草药物制成糊、散、膏等剂型，敷于脐部，联合或不联合艾灸、热熨、拔罐等以治疗疾病的方法。属于中药穴位贴敷、灸法等作用于神阙穴外治法的一种。脐疗作为中医外治法的一种，因其特殊优势而常被单独提及并广泛应用。本书对脐疗的作用特点、功能机理、用药特点等进行了多方面的整理和研究，愿以此丰富祖国医学外治法的内容。脐疗临床可操作性强，适应症广泛。脐疗的未来将更加耀眼光彩。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	570
1582	普通本科院校向应用技术院校转型的逻辑与路径研究	978-7-5645-7908-1	\N	刘刚 	0	1-1	16开	46.00	224.0千字	郑州大学出版社	172	\N	12	2022-01-01	/book/4c43b45d-d25b-4d83-ba2f-11ab27ec03501084585.jpg	本研究立足于解决普通本科院校向应用技术院校转型发展的实际问题，回答为什么转如何转的困惑。从职能演进的视角分析应用技术院校转型发展的历史逻辑，从市场和行政的视角分析应用技术院校转型发展的现实逻辑，在调查访谈的基础上指出应用技术院校转型发展的主要困境和误区，提出创新转型发展理念，通过职能重构推动转型发展的具体路径和实践策略。研究对于部分普通本科院校转型、尽快适应和融入现代职业教育发展具有实际应用价值。本书适合高等职业院校、普通高等学校的管理者和教师学习和参考，可供高等教育研究者、高等教育专业学生，以及关心高等教育发展的人士研究和学习。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	647
1583	大数据背景下烟草行业智慧营销研究	978-7-5645-8313-2	\N	郭国峰 	0	1-1	16开	68.00	323.0千字	郑州大学出版社	212	\N	12	2022-01-01	/book/81dc9b82-1e04-4cc1-8849-029434c51bc81084587.jpg	本书是在大数据背景下，阐述烟草行业的智慧营销，内容包括大数据和智慧营销的理论知识、营销模型的构建、营销专题的研究和营销案例的分析，通过日常销售数据对烟草营销进行深层次的研究，有助于实现智慧营销，理论与实际相结合，有助于读者更加明晰烟草行业的智慧营销。本书的理论篇适用于营销管理人员，有助于了解大数据、营销和智慧营销方面的相关知识；模型构建部分适用于模型使用人员，有助于对卷烟进行高效投放、销售等，实现烟草精准营销；营销专题和案例部分适用于一线营销人员，有助于积累经验，掌握信息收集的方法、营销新策略等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	218
1584	筑梦初心——建党百年庆典江苏诗词三百首	9787563073658	\N	　 	平装	1-1	大32开	78.00	\N	河海大学出版社	\N	\N	\N	2021-12-01	/book/d44c2957-ad88-49a6-b423-a12bd358d2ae1084592.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	276
1585	基于STAMP的航空安全理论与实践	9787560661971	\N	崔利杰 	\N	1-1	16开	42.00	316.0千字	西安电子科技大学出版社	216	\N	11	2021-12-14	/book/3f668f83-f456-4518-8b08-e34bd947f4e79787560661971.jpg	"安全是航空领域永恒的主题，预防事故、保证安全是航空界始终高度关注并倾注全力研究的课题。航空系统是一个多目标、多层次、多因素相互制约且相互影响的复杂系统，包含着飞行环境、任务特点、装备质量和维护管理机制等不确定性因素。近年来随着无人机系统的引入和发展，航空安全更是存在着空天地密切协同、人机环高度交织、软硬件深度耦合的现象，航空系统的安全性由各种因素及其不确定性相互交织影响所决定。正因如此，适航安全、结构本质安全、安全管理体系等成为各国航空安全领域研究的热点，不断推动着航空安全由事后调查处理向事先预测防范转变，由单一纵向管理向系统综合管理转变，由经验定性决策向科学定量决策转变。 目前航空领域在安全管理方面多数还停留在分段管理、定性描述、主观评估、经验决策的层面，航空安全系统在安全管理方面存在着数据分散性大、质量参差不齐、关键数据缺失等问题，而且目前的航空安全管理缺少充分的理论方法和科学准确的安全性模型，难以有效指导航空装备开展安全性论证、设计、评估和决策，不能有力支撑航空系统安全性提升。具体体现在：一是基于还原论的危险源辨识技术难以适应当前航空系统功能结构的复杂化、耦合化，无法提供完备的危险源识别方法； 二是在可靠性理论基础上发展的安全性建模和评估方法无法满足复杂航空系统需要，难以展示各类危险因素在任务执行中的传播途径和演化机理； 三是基于概率统计论的不安全事件描述和安全性模型分析方法，不足以准确地开展信息不全时的航空系统安全性评估和验证； 四是高度依靠主观经验的决策和对策生成方法，不能有效地指导航空系统的设计使用和事故预防。 2002年，麻省理工大学Leveson教授在系统论、控制论的基础上，提出了一种新型的系统安全分析理论，即基于系统理论的事故模型和过程（SystemTheoretic Accident Model and Processes, STAMP）理论。STAMP理论将安全性看作是一种系统的涌现性，认为安全性受到系统中与各个行为相关的一系列约束的限制，而事故正是由于系统各层次的行为缺乏约束所导致。2013年，在STAMP理论基础上Leveson等人又提出了基于系统理论的过程分析（SystemTheoretic Process Analysis，STPA）方法，该方法目前已在系统安全分析领域得到了广泛应用。STAMP/STPA理论和方法将系统视为一个控制结构，在分析系统失效致因的基础上，形成了一种基于系统控制思维的事故致因模型。基于STAMP理论的STPA安全分析方法假设事故可能由于系统组件的不安全交互引起，能够全面考虑到组件故障、人为差错、组件交互、软件缺陷、设计错误、外部环境等导致系统进入危险状态的致因因素，可以胜任复杂系统的安全性分析工作。 基于此，本书根据航空系统的具体特点，通过典型事故开展基于系统思维的航空系统安全性分析理论及应用研究，建立针对典型航空系统的安全性分析与验证方法； 利用系统控制论思想，提出适用于航空系统安全的数学模型并给出分析求解方法； 引入不确定理论，探析各类影响因素在军事航空安全中的传播途径和演化机理，进而提出适用于不同航空器、功能系统和管理单位的安全性分析方法，可用于指导航空装备的安全性论证、设计与评估。本书共分为四部分，各部分主要内容介绍如下。 第一部分（第一章）：介绍本书所用技术方法的理论基础，重点针对基于系统思维的航空安全性建模理论进行阐述。 第二部分（第二章）：针对典型军、民机事故开展了基于系统控制论的安全性分析，以案例分析的形式进一步剖析了不同航空器系统飞行事故的发生过程，构建了安全控制逻辑，提取了不安全行为和致因场景。 第三部分（第三章至第五章）：针对不同航空器的典型功能系统开展了安全性分析验证，从系统层对典型功能系统构建了控制结构，识别了不安全控制行为，开展了致因场景分析，并结合相关验证平台进行了环境搭建和安全性验证。 第四部分（第六章）：针对航空系统使用保障的关键环节，对航空修理厂的安全性和试飞安全进行了建模与分析，开展了相应的安全性分析，提出了试飞安全性指标体系。本书由崔利杰、任博、王焕彬、丛继平、陈浩然、张贾奎撰写。 本书研究虽然是作者思考创新的结果，但如果没有前人大量的研究积淀，也不会有本书的研究理念、研究重点和技术路线的确立，在此谨向所引用书籍和文献的作者致以诚挚的谢意，并向给予过指导的老师及各位同事致以深深的感谢，向参与项目研究和协助出版的靳展、曹志远、张文葵、田宇、张赫、陈思言、李浩民等同志表示感谢。本书的研究得到国家自然科学基金（71701210、72001213）、陕西省自然科学基金（2019JQ710）和相关科研项目的资助，对此表示衷心的感谢。 由于作者水平有限，不妥之处在所难免，敬请读者批评指正。 作 者 2021年7月 "	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	114
1586	电子线路CAD实用教程	9787560663296	\N	潘永雄 	\N	6-1	16开	50.00	511.0千字	西安电子科技大学出版社	344	\N	8	2021-12-21	/book/e1a424c4-c80e-44ed-a4eb-4b95b6fcbdca9787560663296.jpg	本书第五版出版至今已近5年，这期间电子元器件封装工艺有了长足的进步，贴片封装元件已成为主流，甚至功率元件也以贴片封装为主；元件封装尺寸越来越小，引脚数量越来越多，引脚间距越来越小，使印制板布线密度越来越大。 由于价格因素及PCB设计行业特有的规律，Protel 99 SE版在国内依然有大量用户，尽管Protel 99 SE在Windows 7、Windows 10操作系统下运行会遇到一些小问题，如不能用传统方式装入原理图(SCH)库文件和PCB封装图库文件，但Protel 99 SE代码小，对硬件配置要求低，安装快捷，使之非常适合作为电子CAD教学软件的平台；此外，Protel 99 SE稳定性高，没有明显的漏洞，可在仿真窗口内创建任意的数学函数图像(因软件设计缺陷，基于DXP平台的Altium Designer各版本在仿真窗口内创建数学函数图像时显示异常)，实现工程设计中常遇到的数值求解计算。因此，本书第六版没有过多地介绍基于DXP平台的Altium Designer ××高版本的使用方法，依然重点介绍电子CAD设计规律，毕竟CAD设计软件仅仅是实现设计思想的平台，掌握了电子CAD设计规则、方法、注意事项后，使用什么软件实现就不难了。 第六版继续围绕表面封装元器件布局/布线特征、PCB设计的一般原则，在保留了第五版架构的基础上，根据读者的意见和建议做了如下修改： (1) 系统地纠正了第五版第5、6章的错漏。 (2) 更新了附录。在附录中系统地阐述了在Windows 7及Windows 10环境下运行Protel 99 SE遇到的问题和解决方法。 本书可作为高等学校及高职院校电子类专业“电子线路CAD”课程的教材或教学参考书，也可作为从事电路线路设计工作的工程技术人员的参考资料。 尽管我们力求做到尽善尽美，但因水平有限，书中仍难免存在不当之处，恳请读者继续批评、指正。 编者 2021年10月	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	158
1820	外事接待实务英语（第三版）	9787566323460	\N	梁悦 王华 	平装	1-1	16开	55.00	341.0千字	对外经济贸易大学出版社	\N	\N	\N	2022-01-01	/book/0b132cde-57bf-4947-8155-144e022e8c911086314.jpg	《外事接待实务英语（第三版）》旨在培养具有良好的英语听、说、读、写、译能力，具备丰富的跨文化交际知识，熟练掌握外事接待程序、知识和技能，从事外事工作一线需要的高素质技术技能型人才。 《外事接待实务英语（第三版）》使用对象的职业岗位为涉外公司的商务外事接待。所以，作为高职高专、应用型本科商务英语专业或应用英语专业的教材，《外事接待实务英语（第三版）》的定位是商务外事接待，而不是指政府或组织间的外事接待，侧重点是涉外公司的商务接待。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	645
1587	4G/5G移动通信技术（高职）	9787560660592	\N	肖杨 	\N	1-1	16开	43.00	365.0千字	西安电子科技大学出版社	248	\N	11	2021-12-21	/book/fae2b9bb-95ef-4453-8921-39c319d7826d9787560660592.jpg	本书从4G LTE无线网络优化基本原理的角度出发，主要介绍LTE无线网络优化实施中需要了解的知识点和网络优化方法，涵盖了基本理论基础、参数规划、信令流程、性能分析等，在此基础上进一步介绍了5G技术的性能指标、网络架构及5G关键技术等内容。 本书首先回顾了LTE的发展历程、关键技术、接口协议、主要参数的规划原则，使得读者对LTE基本原理有基本的了解。随后本书通过对信令流程的介绍，使读者对移动台和网络的寻呼过程、业务建立过程、切换过程等信令传输过程有一个比较全面的认识。本书后半部分结合运营商的需求对实际工程案例做了详细的讲解，并结合仿真软件讲解了LTE进阶知识，力求让读者掌握LTE无线网络问题的基本分析思路和方法，在实践运用中能够举一反三。 本书可作为应用型本科和高职高专院校通信相关专业学生的教材，还可作为通信网络和无线通信等相关领域工程技术人员的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	377
1588	系统理论与方法	9787560659305	\N	刘爱军 	\N	1-1	16开	48.00	487.0千字	西安电子科技大学出版社	328	\N	9	2022-01-18	/book/6abfb9bd-5c50-4dd8-a728-9182fb1791829787560659305.jpg	本书介绍了系统理论的基础知识、系统建模与模型化的基本技术以及系统分析、评价、决策的常用方法。其中，系统研究方法部分重点介绍了层次分析法、模糊综合评判法、数据包络分析方法、理想点法、主成分分析法、群体决策等众多方法。这些方法可以有效地促进系统理论与系统思维的实践应用。“理论-模型-方法”的组织形式很好地展示了系统理论与方法的知识体系。 本书既可作为高等院校系统工程、管理科学与工程、工商管理、物流工程专业学生的教学用书或参考书，又可作为从事复杂系统分析、系统评价和系统决策的研究人员的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	559
1589	企业网络规划与实施	9787560661995	\N	韩少云 	\N	1-1	16开	35.00	399.0千字	西安电子科技大学出版社	272	\N	10	2022-01-20	/book/95caa712-9301-40b0-a336-a7dcc3e954a19787560661995.jpg	本书以信息技术（IT）企业的实际用人要求为导向，总结近几年国家应用型本科及高职院校相关专业教学改革经验及达内集团在IT培训行业十多年的经验，由达内集团诸多具有丰富的开发经验及授课经验的一线讲师编写而成。 本书通过通俗易懂的原理及深入浅出的案例，介绍了网络通信模型、交换技术、IP协议、TCP协议、虚拟局域网、静态路由、三层交换、生成树协议、DHCP与子网划分、VRRP与浮动路由、访问控制列表、网络地址转换、OSPF动态路由协议、OSPF路由协议高级、IPv6与WLAN网络配置等内容。 本书可作为应用型本科院校和高等职业院校计算机应用技术专业的专业课教材，也可作为网络系统运维人员的学习和参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	765
1590	单片机原理及接口技术（第四版）	9787560663371	\N	余锡存 	\N	4-1	16开	34.00	333.0千字	西安电子科技大学出版社	228	\N	13	2022-01-26	/book/e358c6a4-4fd4-4a25-9617-454308463a909787560663371.jpg	"本书首先介绍了微型计算机的基础知识, 并以MCS 51系列单片机为核心, 系统介绍了单片机的基本结构、指令系统、汇编语言程序设计、 中断系统、内部定时器/计数器及串行接口、系统扩展与接口技术、应用系统的设计与开发以及抗干扰技术, 最后附有单片机原理及接口技术实验。本书配有例题、习题与思考题, 便于课堂教学与自学。 本书是高等学校电子类及计算机应用专业的教材, 同时也可供非计算机专业、高等职业教育、自学考试和从事微机应用的人员使用。全书内容深入浅出、通俗易懂、注重工程应用。 "	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	256
1591	Python工程应用——网络信息安全	9787560662459	\N	王晓东 	\N	1-1	16开	45.00	424.0千字	西安电子科技大学出版社	288	\N	10	2022-01-26	/book/7b8ad2ef-7db8-4346-9289-016be3b840629787560662459.jpg	本书以信息安全基础知识点为理论依据，采用Python初学者易于理解的叙述方法，较为全面地介绍了基于Python的安全编程思路和实现技术。全书共分为9章：第1章绪论，探讨了Python与安全编程的关系，以及安全编程的基本思路；第2章介绍Python语言基础知识，为后续章节提供编程语言基础；第3章围绕古典、现代密码体制介绍了密码学编程方法；第4章介绍了区块链编程技术，设计了最简单的区块链系统；第5章从空间域和变换域两个方面介绍了数字水印编程技术；第6章介绍了身份认证编程，设计实现了口令、人脸、说话人识别模块；第7章介绍了计算机主机的安全保护编程，列举了主机安全运维管理、恶意软件分析和漏洞模糊测试编程实例；第8章介绍了计算机网络的安全保护编程，给出了网络嗅探、扫描、防火墙、入侵检测的实现方案；第9章介绍了内容安全保护的编程方法。 本书密切结合信息安全专业理论知识，同时兼顾了Python编程实践技术，知识点明晰，难易适中，可供计算机技术、网络工程、信息安全及相关专业技术人员学习参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	830
1592	天线与电波传播（第四版）	9787560662589	\N	宋铮 	\N	4-1	16开	45.00	456.0千字	西安电子科技大学出版社	308	\N	10	2022-01-28	/book/6efc8487-dda2-4a4d-8209-86550becae8c9787560662589.jpg	本版是在原书第三版的基础上修订而成的。这次修订对第4章进行了较大篇幅的改动；第3、5、8、9章添加或置换了某些特定天线的内容；在某些章节引入了基于电磁场数值仿真软件得到的天线特性。 本书围绕天线与电波传播两大内容展开。全书共 14 章。前 9 章为天线部分，各章内容分别为：天线基础知识、简单线天线、行波天线、非频变天线、缝隙天线与微带天线、手机天线、测向天线、面天线、新型天线；后 5 章为电波传播部分，各章内容分别为：电波传播的基础知识、地面波传播、天波传播、视距传播、地面移动通信中接收场强的预测。各章均配有适量的习题。本书力求兼顾信息量大、行文简洁的特点，追踪当前热点技术及应用。 书中的大量图表体现了MATLAB 在天线与电波传播领域中的有效应用，附录给出了典型的MATLAB程序，个别章节还介绍了专业的天线分析软件的应用实例。同时，本书以二维码的形式提供每章的教学课件和重点、难点的讲解视频（动画），教师和学生可扫码查看。本书的适用对象为电子工程、通信工程专业的大学本科学生，也可供其他专业选用以及供通信和天线工程技术人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	665
1593	电磁波与天线仿真及实践（第二版）	9787560662084	\N	谭立容 	\N	2-1	16开	56.00	545.0千字	西安电子科技大学出版社	368	\N	8	2022-02-08	/book/fdb1f664-f94a-46f2-a227-0440a503a66f9787560662084.jpg	本书主要有三部分内容：一是基础篇，主要介绍电磁场与电磁波基本概念和相关技术， 并对电磁波传播、常用器件及天线进行了重点介绍；二是仿真篇，采用HFSS和ADS等仿真软件，针对电磁波传播、传输线、常用器件及天线， 提供了18个带有详细步骤的仿真案例；三是实践篇，针对无线电技术、微波技术、电子信息技术、物联网应用技术和其他相关专业学生和工程技术人员的学习实践需要，提供了19个实验。读者可以结合学习需要选做相关仿真案例和实验，建议第二和第三部分的学习与第一部分相关基本概念的学习同时进行，这样便于把抽象的知识具体化。学习时可扫描书中的二维码，参看配备的视频资源等。 本书可作为无线电技术、微波技术、电子信息技术、物联网应用技术和其他相关专业学生学习电磁波与天线仿真的教材或参考书，还可作为学习HFSS、 ADS等仿真软件的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	619
1594	传感器与检测技术	9787560662060	\N	张佑春 王海荣 主编 	0	1-1	16开	39.00	356.0千字	西安电子科技大学出版社	244	\N	11	2022-02-08	/book/07ed05ce-bad0-4d08-85ae-fd731f570f6a9787560662060.jpg	本书系统地介绍了多种传感器的工作原理、基本结构、典型应用与验证实验等。全书共11章，内容包括检测技术与传感器技术概述，电阻式传感器与力的检测，电容式传感器与液位检测，电感式传感器与振动检测，霍尔传感器与位移检测，压电式传感器与动态检测，热电式传感器与温度检测，光电式传感器与转速检测，半导体传感器与湿度、气体检测，新型传感器及应用，现代传感器与虚拟仪器技术等。书中几乎每章后都附有思考与练习和实验，便于读者掌握各章的重点。 为方便教学，本书配套有MOOC视频、PPT课件、习题库、实验指导、案例程序等，其中部分资源在本书各章节起始处以二维码的形式给出，也可访问与本书配套的学银在线平台（http://www.xueyinonline.com/detail/207626971）获取。 本书可作为高等职业院校机电类、自动化类、电子信息类等专业相关课程的教学用书，也可作为相关领域的工程技术人员的培训和参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	129
1596	工程数学习题册（概率统计）	9787560663173	\N	方晓峰 	\N	1-1	16开	32.00	271.0千字	西安电子科技大学出版社	192	\N	13	2022-02-08	/book/3b08131d-21ce-4804-8041-8d13e01e617e9787560663173.jpg	"本书主要由习题和参考答案两部分组成, 涉及概率论的基本概念、 随机变量及其分布、 多维随机变量及其分布、随机变量的数字特征、大数定律与中心极限定理、样本及抽样分布、参数估计、假设检验等内容，　习题主要包括客观题和主观题, 其中, 重难点习题附有视频讲解, 读者可通过手机扫描二维码学习相关知识. 本书分为A、B两册, A册包含各章的奇数节内容, B册包含各章的偶数节内容. 本书可作为高等院校非数学专业的本科生学习“概率统计”课程的同步练习用书, 也可作为需要学习概率统计的科技工作者、准备考研的非数学专业学生及其他读者的参考资料. "	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	536
1597	移动社交网络中信息传播建模与调控方法	9787560662299	\N	林亚光 	\N	1-1	16开	44.00	125.0千字	西安电子科技大学出版社	164	\N	14	2022-02-11	/book/2bd6a30f-8eb4-4f77-a667-01d79fe916f69787560662299.jpg	本书介绍了移动社交网络中信息传播的建模与调控方法。全书共五章，分别为绪论、 恶意信息传播过程动力学建模与脉冲控制方法、诈骗信息扩散建模与最优控制方法、恐慌情绪信息扩散建模与多策略协同控制方法、信息传播调控任务分配方法和用户激励机制。本书所提供的模型和方法可以扩展至众多的信息传播建模与调控相关的应用场景中， 具有一定的理论参考、方法借鉴和技术支撑价值。 本书既可作为计算机科学与技术领域的研究人员的参考书，也可作为新型网络和移动社交网络研究领域的研究资料。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	218
1598	大学计算机信息素养实践教程	9787560662947	\N	李霞 	\N	1-1	16开	34.00	306.0千字	西安电子科技大学出版社	208	\N	12	2022-02-14	/book/868a246b-f50b-41b6-a392-cd89fe4287a19787560662947.jpg	本书是《大学计算机信息素养》（?西安电子科技大学出版社同步出版）配套的实践教程。全书共有六个项目、19个任务，内容包括操作系统Windows 10、文字处理软件Word 2016、电子表格处理软件Excel 2016、演示文稿制作软件PowerPoint 2016、图形设计软件Visio 2016、计算机网络及Internet。除项目一和项目六外，其他项目都由多个任务和一个综合实验项目组成。多数任务都设有任务目标、任务描述、相关知识和任务实施四个板块的内容。 本书内容新颖，结构合理，通俗易懂，可作为高等学校非计算机专业计算机通识教育课程的实践教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	810
1599	个人理财实务	9787560663203	\N	易志恒 	\N	1-1	16开	30.00	259.0千字	西安电子科技大学出版社	176	\N	14	2022-02-14	/book/05ea15c3-f601-4c41-98af-4e70608e368a9787560663203.jpg	本书在介绍客户信息收集、整理和分析的基础上，结合我国个人理财市场发展状况，甄选了人们最为关心的现金规划、金融投资规划、家庭保障规划、家庭住房规划、子女教育规划、税收筹划和养老规划等知识作为理财模块，设计了专项理财项目，并根据理财业务流程，对每个项目做重点实务介绍；书中还结合具体实例，设计并撰写了家庭理财规划报告。 为便于学习和掌握，本书突出了实务操作环节，在每个模块之前都进行了知识目标、技能目标、素质目标的提炼，在实务操作中注重相关知识点的补充，并结合具体案例，对实务操作进行分析讲解，做到了教学做一体化。另外，本书在每个模块后都提供了相应的练习来巩固所学知识。 本书可作为高等职业院校、高等专科学校理财类课程的教材，也可供一般读者学习借鉴。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	760
1600	区块链与数字货币	9787560663326	\N	陈彦彬 	\N	1-1	16开	41.00	325.0千字	西安电子科技大学出版社	256	\N	10	2022-02-22	/book/555708b2-8b2f-40ca-bbab-527cc45badbe9787560663326.jpg	本书系统介绍了区块链的技术原理和应用。全书共10章，主要内容包括区块链的发展历程、基本概念、技术原理，比特币，以太坊公链，超主权数字货币，中央银行数字货币，数字货币交易平台，区块链的监管、商业应用，区块链与新技术的结合等。 本书不仅介绍了区块链独有的技术原理和特性，还着重介绍了数字货币的类型及其生态、价值，并通过区块链独有的技术延伸出区块链的监管、商业应用及区块链与新技术的结合等内容，对区块链上的原生商业形态也有所涉及，比如DeFi等。 本书内容全面，易于理解，便于教学，可作为高等院校区块链工程专业、金融科技专业及相关专业的专业课教材，也可以作为区块链从业者的学习参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	603
1601	城市轨道交通电力监控系统	9787560663319	\N	李冰涛 	\N	1-1	16开	53.00	435.0千字	西安电子科技大学出版社	292	\N	8	2022-03-01	/book/5daf0dc8-9a0b-4d9d-9d4f-6b58fe3392659787560663319.jpg	本教材由4个项目组成。项目1为用微控制器处理数据，其中包含5个任务，分别是了解SCADA系统、微控制器对电气设备的控制、理解串口通信、监控软件组态微控制器实现遥信与遥控功能、监控软件组态微控制器实现遥测与遥调功能。项目2为用PLC处理数据，其中包含5个任务，分别是使用S7-200 SMART前的准备工作、监控软件组态SMART实现遥信与遥控功能、监控软件组态SMART实现遥测与遥调功能、用SMART组态文本显示器、使用SMART通过RS485采集数据。项目3为监控软件的应用设置，其中包含4个任务，分别是设置报警与权限、设置报表与曲线、制作变电所主画面、实现网络连接。项目4为实训示例，其中包含4个任务，分别是认识轨道交通供电实训室设备、探究ST700组件式直流微机综合保护装置、PSCADA系统科目训练、ISCS系统科目训练。 本书可作为城市轨道交通供电专业城市轨道交通电力监控系统课程的教学用书，也可作为城市轨道交通供电专业技术人员入门级培训教材和供电职工自修的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	314
1602	高等数学	9787560663067	\N	李玉霞 	\N	1-1	16开	37.00	341.0千字	西安电子科技大学出版社	232	\N	13	2022-03-01	/book/0df9c0fb-e069-4412-acb9-eb67f7db2fc89787560663067.jpg	"本书以高等数学应用为主导, 根据高职高专院校的培养目标和教学要求编写，体现了高职高专教育的特点,在内容的选材上以“必需、够用”为原则， 突出针对性、适用性和实用性.本书共10章，主要内容包括函数及其图形、极限与连续、导数与微分、中值定理与导数的应用、不定积分、定积分及其应用、微分方程、拉普拉斯变换、行列式与矩阵、向量代数与空间解析几何等. 每节均配有习题，附录中提供了习题答案.本书内容深入浅出，论证简洁，例题丰富，便于自学，可作为高职高专院校机电类、电气自动化、会计、机器人、数控技术类等专业学生的教材，也可作为工程技术人员的参考书. "	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	880
1606	熊铁基的学术人生	978-7-5622-9536-5	\N	范军 	平装	1-1	16开	98.00	480.0千字	华中师范大学出版社	528	\N	\N	2022-02-01	/book/8794127d-8494-44e8-aab7-36d138ef03d21084697.jpg	本书由系列文章汇编而成，分上中下三篇。上篇“学术春秋：熊铁基与史学研究”为同行专家对熊铁基教授的主要学术成就所作的评述和摘要介绍，及对他进行的多个访谈录。中篇“师友漫话：熊铁基的教书育人”是师友们对他在为学、为师、为人等方方面面的追述。下篇“师们忆旧：熊铁基与研究生培养”是学生对在他门下求学、生活经历的回忆。本书整体呈现了熊铁基教授治学从教七十载取得的丰硕成果，在学术研究道路上的独特见解和人才培养上的用心用情，表现了他乐观、热情、积极、进取的生活态度和至真至善至美的人生境界。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	402
1607	战争审判研究	上海交通大学战争审判与世界和平研究院 编	\N	程兆奇 主编 	平装	1-1	16开	88.00	\N	上海交通大学出版社	\N	\N	\N	2022-03-01	/book/277010c4-862a-4767-9cde-2b8ca1f087401084702.jpg	《战争审判研究 第一辑》十三篇论文围绕东京审判这一历史性事件，从方方面面剖析它的法律意义、社会影响、历史功绩，作者不少是浸淫于这一领域的首席专家，也有深谙法律的青年学者，使得本书有极高的学术价值和社会意义。不仅说透了东京审判的那些事，也从侧面告诉人们不义之战争终将受到制裁。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	994
1608	中国当代青年建筑师Ⅹ（上册）	978-7-5618-7073-0	\N	何建国 	平装	1-1	16开	349.00	\N	天津大学出版社	\N	\N	\N	2022-03-01	/book/ee0ccbb1-ed40-4e46-8195-6886c134f27b1084708.jpg	《中国当代青年建筑师Ⅹ（上册）》收录了：广东省建筑设计研究院/陈奥彦、清华大学建筑设计研究院/杜爽、湖南省建筑设计院有限公司/冯昶、CCDI悉地国际/郭轶、中国航天建筑设计院/何金生、东南大学建筑设计研究院有限公司/胡石、甘肃省建筑设计研究院有限公司/靳东儒、上海建筑设计研究院有限公司/李磊、深圳市建筑设计研究总院有限公司/廉大鹏、中国建筑西北设计研究院/雷霖、清华同衡建筑设计有限公司/刘智斌、华东建筑设计研究院有限公司/刘彬等一批优秀青年建筑师的最新作品。作品内容涵盖教育建筑、医疗建筑、办公建筑、商业建筑、文化建筑，体育建筑等各种类型的建筑设计，以图文并茂的形式进行诠释，经济技术指标及设计风格解读对于建筑设计师有极高的参考价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	569
1609	中国当代青年建筑师Ⅹ（下册）	978-7-5618-7074-7	\N	何建国 	平装	1-1	16开	349.00	\N	天津大学出版社	\N	\N	\N	2022-03-01	/book/dff58d93-c723-47b6-bab3-bfda5368a2631084709.jpg	《中国当代青年建筑师Ⅹ（下册）》收录了：北京市建筑设计研究院有限公司/王飞、山西省建筑设计研究院/王威、哈尔滨工业大学建筑设计研究院/王宇、上海天华建筑设计有限公司/王媛、中衡设计集团股份有限公司/王志洪、中联西北工程设计研究院有限公司/邢超、中国中建设计集团有限公司/阎福斌、东南大学建筑设计研究院有限公司/胡石、同济大学建筑设计集团/张力、西安建筑科技大学建筑设计研究院/张伟、江苏省建筑设计院/周红雷、中国中元国际工程有限公司/张煜、中国建筑设计研究/赵文斌等一批优秀青年建筑师的最新作品。作品内容涵盖教育建筑、医疗建筑、办公建筑、商业建筑、文化建筑，体育建筑等各种类型的建筑设计，以图文并茂的形式进行诠释，经济技术指标及设计风格解读对于建筑设计师有极高的参考价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	982
1610	国际汉语·第五辑	978-7-306-07274-0	\N	周小兵 	平装	1-1	16开	36.00	215.0千字	中山大学出版社	144	\N	\N	2021-08-01	/book/5458da85-7e41-4a74-b3e9-368ecfe147301084711.jpg	本书包括汉语二语学习与测试、教师发展与培训、教材研究、教材评介四个部分，收入12篇论文，内容涉及边界范式在阅读中词汇加工机制研究中的应用、语素意识对中级CSL学习者词义获得的影响、构词法与近义语素的辨别、汉语水平分级测试方法对研究结果的影响、国际汉语教师培训的历史回顾与现状分析、汉语教师志愿者胜任力调查、汉语培训机构教师专业发展需求调查、对外汉语新手教师和熟手教师线上教师角色认知的对比研究、针对二语教材的DAM话语真实性等级模型、对外汉语阅读教材中的篇章技能训练反思、《中国研习》的研制与开发、职业教育“走出去”背景下的“中文+职业技能”教材探索等，反映了近来对外汉语教学和研究的新动态。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	852
1700	电子商务基础	978-7-5689-2650-8	\N	张海锋 周格生格 	\N	1-1	16开	37.00	281.0千字	重庆大学出版社	209	\N	\N	2021-08-26	/book/dfeb3d2e-80ee-4c85-96ab-d28577d498d192650.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	439
1612	明清园林图像艺术	9787564198893	\N	许浩 	平装	1-1	16开	120.00	\N	东南大学出版社	\N	\N	\N	2021-12-01	/book/6181587d-c1e4-42d4-8ec2-c954ccadec961084720.jpg	全书由两个部分构成。第一部分聚焦于明代园林的图像表达。园林图像是园林营造与图像艺术发展到一定阶段相结合的产物。因此，本书对明代园林图像产生的两个背景条件，即明代园林营造和图像的发展进行考察，在此基础上，梳理明代园林与名胜图像作品(第一章)，并展开对《环翠堂园景图》和《拙政园三十一景图》的个案研究(第二章、第三章)。 第二部分探讨了清代园林的图像构成与视觉呈现。首先，考察了清代园林与图像的发展状况，进而从图像作者、图像内容、媒介材料角度梳理清代园林与名胜图像作品(第四章)。第五章至第八章分别以《静宜园二十八景图》、《圆明园四十景图》、《南巡盛典》、《平山堂图志》为例，深入分析图像的构成与视觉表现特征。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	547
1613	文化产业概论(21世纪文化产业管理系列教材)	978-7-300-30372-7	\N	向勇 	平装	1-1	16开	39.90	280.0千字	中国人民大学出版社	\N	303727	\N	2022-03-15	/book/f1884ef3-004b-4a6d-b145-d2af4f88b2331084732.jpg	《文化产业概论》在介绍文化产业的行业环境、市场格局的基础上，探讨了文化资源的开发利用、文化资产的价值实现、文化创意的故事驱动、文化科技的融合发展、文化企业的组织管理和领导模式、文化产业的营销创新与商业模式、文化金融的运营模式、文化产业的集聚效应、文化产业的国际贸易与传播、文化产业的政策治理和发展趋势等重要问题。每章开篇设有“本章概述”“学习目标”，章末附有“本章小结”“思考与练习”“拓展阅读”等专栏，以方便教师备课和学生学习。本书关注文化产业前沿实践，尽可能为文化产业学习者和从业者提供多元化的理论框架和可操作的研究方法。本书立足新时代，尝试构建中国特色文化产业学术体系、理论体系与话语体系。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	404
1614	专利法（普通高等学校知识产权专业系列教材）	978-7-300-30209-6	\N	闫文军 	0	1-1	16开	58.00	547.0千字	中国人民大学出版社	\N	302096	7	2022-03-15	/book/f7e5b365-d0dc-474b-9d86-47441df50ec71084738.jpg	专利法是知识产权学科体系中的最重要的组成部分之一。随着国家知识产权战略的提出和发展，专利法的地位更加突出，不少理工类院校开设了专利法课程。该书对专利法的概念和知识体系进行了系统介绍，中间穿插大量图片、资料和案例，辅以理论研习和实务探讨，帮助读者理解掌握，并对知识产权国内外最新的经典判例进行了介绍和评析，对实务工作者也很有启发意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	199
1615	土地资源管理学（第二版）（新编21世纪土地资源管理系列教材）	978-7-300-30349-9	\N	张正峰 	0	2-1	16开	59.80	530.0千字	中国人民大学出版社	\N	2020C1020	\N	2022-03-31	/book/fe59b814-c805-425e-8583-33506b23febe1084762.jpg	张正峰教授主编的《土地资源管理学（第二版）》一书从土地资源的基础管理、用地管理、措施管理三个方面系统阐述了土地资源管理的理论与实践。基础管理是土地资源管理的基础，其任务是认识土地资源的属性，摸清区域内土地资源的数量和质量状况，主要包括土地资源的属性、土地资源的调查和评价等内容。用地管理是土地资源管理的核心，其根本任务是对土地利用实行宏观控制和微观计划管理，主要包括国土空间规划与计划的编制、实施和管理，土地的集约利用与可持续利用，以及土地资源的综合整治等内容。措施管理是土地资源管理实现的手段，主要包括土地资源利用过程中一系列的法律的、行政的、经济的、生态的和技术的手段与措施。为了帮助读者更好地掌握相关理论，本书还专门安排了一章内容，对土地资源管理中的典型案例进行分析，案例内容涉及土地集约利用管理、农村集体建设用地市场管理、土地承包经营权流转管理、地籍管理、土地资源生态管理、土地资源信息管理等多个方面。 与教材第一版相比，本书新增了国土空间规划与计划、土地资源权属管理、土地资源信息管理、土地资源管理案例分析四章内容，并对其他章节进行了较大幅度的修订，以充分反映新时代中国土地资源管理学科理论与实践的新发展与新变化。 本书理论联系实际，适合作为高校土地资源管理专业相关课程教材，同时也是自然资源系统从业人员系统学习土地资源管理学理论知识的理想参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	686
1616	宏观文艺学研究（国家社科基金后期资助项目）	978-7-300-30331-4	\N	陆贵山 	0	1-1	16开	99.00	350.0千字	中国人民大学出版社	\N	303314	\N	2022-03-15	/book/e515bc71-8106-4b42-a85c-536582843eff1084787.jpg	《宏观文艺学研究》运用唯物辩证法，以宏观、辩证、综合、创新的思维方式，结合广度、深度、动态和关系四个向度，全面考察文艺的发生、演变和发展趋势。全书共分三编。第一编“文艺根脉和文艺思潮”，研究现实主义和浪漫主义的产生、演变与相互关系，人本主义和科学主义文艺思潮的内涵与关系。第二编“文艺学理系统研究”提出文艺有七大学理系统，即生态主义、历史主义、人本主义、审美主义、文化主义、心理主义、文本主义文论学理系统，并对其进行系统研究。第三编“文艺观念间性研究”研究各种重要的文艺观念的间性关系，诸如文艺本体论以及文艺的社会性和人文性、客体性和主体性、反映论和价值论、创作论和艺术生产论，深化对各种文艺观念内在联系的理解。本书对树立多向度、多层面、全景式和全过程的大视野的思维方式和研究方法，提供了有益启示。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	769
1617	进化论与伦理学(全译本)(附《天演论》)	978-7-301-09560-7	9787301095607	(英)赫胥黎 	\N	1	16开	65.00	220.0千字	北京大学出版社	248	7301	\N	\N	/book/f8fee1e0-b7c0-4e82-ad98-0976c27e3d2c0956003.jpg	赫胥黎（1825-1895）是英国著名的生物学家，1859年达尔文的《物种起源》发表后，赫胥黎深为折服。次年英国科学促进会在牛津大学开会时，他为达尔文的进化论作了出色的辩护。此后他写了许多科普文章，扩大了进化论的影响。《进化论与伦理学》分导言和正文两个部分。导言阐述了达尔文进化论的观点，以生物学、地质学和天文学的材料说明物质世界是充满矛盾和变化的，生物是不断变化的，物竞天择是支配世界的法则。正文部分把进化论的观点应用于人类社会，论述伦理道德的演化，社会中的人和动物一样"优胜劣汰，适者生存"。1894年严复将《进化论与伦理学》翻译为《天演论》。但严复并不是直接翻译，而是对原书作了很大的改动，加入了很多自己的思想。《天演论》的出版对中国近代资产阶级启蒙思想的传播起到了重要的作用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	757
1618	儒藏(精华编九四)	978-7-301-11812-2	9787301118122	北京大学《儒藏》编纂与研究中心 	\N	1	16开	1,200.00	640.0千字	北京大学出版社	680	7301	\N	\N	/book/8049bd97-1459-4acf-b980-40f7900019b91181202.jpg	北京大学儒藏工程是我国一项重大学术文化项目。《儒藏》收录自先秦至清朝结束这一时段中，儒家经典及其注疏、儒家学者的著述和体现儒家思想文化发展的相关文献，包括传世文献与出土文献，尽量选用最好的底本，按传统的经、史、子、集四部分类法进行分类。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	636
1620	电机与电力拖动	978-7-301-18630-5	9787301186305	"孙英伟,齐新生" 	\N	1	16开	48.00	420.0千字	北京大学出版社	288	7301	\N	\N	/book/b586ebda-9277-4444-9f83-0df05945d0c11863002.jpg	项目1：变压器（知识目标：原理、结构、运行）；项目2：直流电动机（知识目标：原理、结构、运行、启动、运行）；项目3：交流电动机（知识目标：原理、结构、启动、运行）；项目 4：其他用途电动机（知识目标：单相电机及控制电机的原理、结构、用途）；项目5：电气控制控制技术与应用：（知识目标：继电器、顺序控制、可逆控制、Y-△角变换启动）;项目6：可编程序控制器控制器简介：（知识目标：PLC简介、编程、应用）。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	955
1621	日语笔译	978-7-301-18790-6	9787301187906	马小兵，翁家慧 	\N	1	16开	38.00	293.0千字	北京大学出版社	188	7301	\N	\N	/book/419619f0-1a57-4c58-8fe7-0ff23c6efa911879002.jpg	本教材是为自考生而编写的。书中涵盖了翻译的基本理论、汉日语言对比、词语翻译、简单句翻译、句式翻译、篇章翻译、翻译的语用与文化层面及几种主要文体的翻译等内容。可使学习者学到翻译的基本理论、基本规律、基本方法和基本技巧。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	866
1622	犯罪人论	978-7-301-19628-1	9787301196281	(意)切萨雷·龙勃罗梭Cesare Lombroso 	\N	1	16开	59.00	365.0千字	北京大学出版社	316	7301	\N	\N	/book/9a7f8d5e-5ed8-438b-848d-fe3df276b2701962802.jpg	本书被视为犯罪学的奠基之作，在现代法学体系中，本书第一次将犯罪者作为一项独立的研究客体，从生物学和精神病学的角度科学理性地分析犯罪人群及其行为，力图从客观上掌握犯罪行为与犯罪者生理和精神上的关联，从而促使犯罪学这一新的学科体系产生。本书在西方犯罪学界久负盛名，于2000年由黄风教授翻译引进到我国出版，曾得到再版。本次由黄风教授对翻译重新修订，授权我社出版。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	900
1623	中国古代文学	978-7-301-20943-1	9787301209431	施国锋 	\N	1	16开	45.00	156.0千字	北京大学出版社	192	7301	\N	\N	/book/c0a95a8e-485c-482a-bf1b-2b4c1a3db1482094302.jpg	本书是我室策划的外国留学生本科汉语系列规划教材。本系列规划教材包括三个大类：语言知识类、语言技能类和文化类。语言知识类包括汉语语法教程、汉语语音教程和汉语词汇教程；语言技能类包括初、中、高三个级别的汉语综合课、分项技能的听说读写译及古代汉语教程；文化类包括中国历史、文学、哲学、文化、旅游、民俗、经济、对外关系、当代社会概况等。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	818
1624	古代汉语	978-7-301-23349-8	9787301233498	"赵世举,李运富" 	\N	1	16开	79.00	541.0千字	北京大学出版社	512	7301	\N	\N	/book/b2e1de9c-b5bf-4a85-871f-bca0e0bff9ae2334903.jpg	本书是中文系古代汉语基础课教材，对古代汉语知识进行了全面介绍，为“高等院校中文学科创新性学习系列教材”中的一本。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	377
1625	材料科学基础(第2版)	978-7-301-24221-6	9787301242216	张晓燕 	\N	2	16开	58.00	503.0千字	北京大学出版社	348	7301	\N	\N	/book/47dd2ca7-65ce-4424-880f-b29ff1e5922f2422102.jpg	增加了实际应用案例和阅读材料等，并更新了相应标准，本书全面系统地介绍了材料科学的基本问题，全书共分为4篇，以金属材料为主，分析金属材料的成分、组织结构、加工工艺与性能之间的关系及其变化规律，其主要内容包括：晶体结构、晶体缺陷、塑性变形、相图、扩散、凝固以及回复再结晶等，着重于基本概念和基本理论。在此基础上介绍陶瓷材料、高分子材料以及复合材料，为学习和研究各种材料提供了必要的基础知识。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	833
1626	当代文学经典读本	978-7-301-25206-2	9787301252062	孙郁 	\N	1	16开	59.00	320.0千字	北京大学出版社	320	7301	\N	\N	/book/c24c2253-1b2e-442f-856a-95439e32160f2520603.jpg	本书为钱理群先生主编的“文学经典读本系列”之一，丛书目标是从文学的角度，以文学的方式，有助于大、中学生和一般读者的语文训练和人文修养。具体编写以文学经典为中心，选名家名作，力图通过有线的选文凸显一条文学史的线索，一种文化传统，一种"层累"的过程。书前有总的导言，每篇选文前有编者撰写的作家作品概论和述评，后有思考题、名家点评（部分存目）。本书为当代文学部分，由孙郁编著。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	126
1627	酒店质量管理原理与实务	978-7-301-25543-8	9787301255438	张红卫，张娓 	\N	1	16开	47.00	414.0千字	北京大学出版社	276	7301	\N	\N	/book/d02c86e8-e927-49d9-ad3c-ed8ea0bbcdca2554302.jpg	本书立足于饭店质量管理的前沿理论，在饭店质量管理类书籍中首次全面阐述顾客感知服务质量理论，同时对影响质量管理的顾客忠诚的理论也进行了系统阐述。同时，本书还注重质量管理的实践性。从实际出发，全方位、全过程、多角度地对影响饭店质量的因素进行了分析。 本书既可以作为高等院校酒店管理、旅游管理及相关专业的教材，也可以作为饭店从业人员的培训教材； 同时对旅游行业管理人员也具有参考价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	165
1628	建筑结构基础与识图	978-7-301-27215-2	9787301272152	周晖 	\N	1	16开	58.00	594.0千字	北京大学出版社	416	7301	\N	\N	/book/81689755-b6ae-4bf9-97fc-f3b06392f8072721503.jpg	本书主要以结构施工图识读能力的培养为主线展开，主要研究一般结构构件的受力特点、构造要求、施工图表示方法等建筑结构基本概念和基本知识。全书共分10大项目，内容包括：建筑力学基本知识，建筑结构材料，结构设计方法与设计指标，混凝土结构基本构件，钢筋混凝土楼（屋）盖、楼梯，基础，钢筋混凝土多层与高层结构，砌体结构基础知识，钢结构基础知识，建筑结构施工图识读等。在编写过程中，编者结合教学实践的经验，突出能力目标的训练及知识目标的掌握，内容选取以够用为原则，注重实用性和针对性，力求反映高等职业技术教育的特点。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	574
1629	建筑材料与检测试验指导（第二版）	978-7-301-28471-1	9787301284711	王辉 	\N	2	16开	35.00	225.0千字	北京大学出版社	160	7301	\N	\N	/book/7627ea25-7c31-44f9-b56a-24bfd06138402847102.jpg	本书采用了最新标准和规范，介绍了新型材料的选用和检测，体现了先进性。内容采用以真实的任务为导向的模式，以材料的进场验收、取样、检测为线索，符合学生的认知规律。其内容突出高等职业技术教育的特色，加大实践动手和实践运用能力的培养。 本书内容包括常规的建筑材料和目前行业要求的绿色、节能及环保材料的介绍，材料的选用和建筑材料检测等。具体内容建筑材料性能检测的基础知识； 建筑材料基本性质检测；气硬性胶凝材料的检测；水泥的检测； 水泥混凝土材料性能检测；建筑砂浆的检测；墙体材料的检测；建筑钢材性能检测；防水材料的检测；第9章 检测报告 。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	687
1630	汽车电器设备技术	978-7-301-29483-3	9787301294833	戚金凤 	\N	1	16开	49.00	402.0千字	北京大学出版社	272	7301	\N	\N	/book/a283a967-fbb5-49a6-a74f-3b2638e638dc2948302.jpg	本书以模块式教学方式为主，介绍了现代汽车电器设备的结构、原理、性能、使用、检测和维修技术及有关实践操作技能。本书共分9个模块，主要学习内容包括：汽车绪论、汽车电源系统、汽车起动系统、汽车点火系统、照明及信号系统、仪表报警系统、安全与舒适系统、汽车空调系统、汽车整车电路系统，采用大量图表说明代替文字阐述，直观易读；实训操作以练习的形式列出，便于组织教学和读者阅读。本书各章节前后有理论知识目标、实训能力目标、思考题、实训总结，便于学生总结学习。本书可作为各类职业院校汽车维修及相关专业的教材，并可供汽车运用、汽车修理、汽车营销、汽车管理等技术人员参考，同时亦可作为汽车维修电工的培训教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	966
1631	茶文化与茶艺（第3版）	978-7-301-31567-5	9787301315675	王莎莎 	\N	3	16开	42.00	345.0千字	北京大学出版社	244	7301	\N	\N	/book/14b37e9c-b209-44bc-931b-025062793ffa3156702.jpg	《茶文化与茶艺》是为了适应当前我国茶艺行业发展及旅游（酒店）职业教育与茶艺专业人才培养的需要，结合茶艺师职业培训和茶艺师国家职业技能鉴定标准的基本要求，以职业活动为导向，以职业技能为核心，理论与实践相结合，旨在普及茶叶知识，提高茶艺服务技能，学习茶艺企业的经营与管理知识的一门学科。本书以“中国茶文化、茶叶基础知识、茶事服务、茶艺表演、茶艺馆的经营与管理、休闲茶饮”六部分为结构体系，系统地介绍了茶文化的产生与发展、现代茶艺服务与管理的现状、发展趋势。本书内容丰富、通俗易懂、雅俗共赏、说古论今、由浅入深，融知识性、趣味性为一体，结合国际职业教育教学法，并配有多种形式的教学手段来帮助学习者加强记忆，使学习者在轻松、愉快的阅读中获得知识、提高修养，掌握技能。本书既可作为高职高专院校学生教材使用，也可作为茶艺爱好者的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	997
1632	农村土地制度改革的中国故事——地方政府行为的逻辑	978-7-301-32503-2	9787301325032	唐健,谭荣,魏西云 	0	1	16开	69.00	308.0千字	北京大学出版社	320	7301	\N	2022-01-25	/book/932678e5-94f2-4599-a246-87bb7cfbc5b232503.jpg	本书回顾总结分析了2015—2018年在全国范围内开展的农村土地制度三项改革的主要内容、进展，并选择若干试点进行对比分析。尝试围绕改革实施、地方行为、制度环境及央地关系等要素，通过构建一个系统的制度分析框架来探讨本轮农村土地制度改革的内在逻辑与规律。主要回答：一是影响农村土地制度改革绩效的制约因素有哪些；二是改革试点中不同地方政府的行为选择逻辑是什么。最后给出农村土地制度改革背后的地方行为逻辑与政策建议，在此基础上提出了农村土地制度改革之道。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	458
1633	如山如河——中国劳动宪法	978-7-301-32704-3	9787301327043	阎天 	0	1	16开	39.00	183.0千字	北京大学出版社	252	7301	\N	2022-01-13	/book/4170a3fa-5a7e-4d2f-a959-56253939dcdf32704.jpg	本书以历史为经线、规范为纬线，展示宪法与劳动在中国大地互动互构的壮阔图景，探讨宪法在平等就业、民主管理、按劳分配、劳动纪律和破产保护诸方面的意涵和演进，凝练“中国劳动宪法”的主题，在宪法学与劳动法学之间建立新的连结。 本书刚柔并济、博古通今、中西合璧，展开了中国劳动宪法的壮丽图景，延展了劳动法治的生命脉络，体现了作者对于劳动法学细腻而深刻的热爱，处处可见关怀与温情。 作者首次完整阐发了“劳动宪法”这一兼具理论创新意义和学术发展价值的概念，以劳动法诠释宪法所展望的美好生活，重新发现了劳动的宪法意义，特别是推动法治发展的代际对话与传承。这无疑将劳动法学科发展推向了新的高度。 ——叶静漪（北京大学法学院教授，中国社会法学研究会副会长兼秘书长）	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	865
1634	全球史概论	978-7-301-32711-1	9787301327111	刘文明 	\N	1	16开	78.00	354.0千字	北京大学出版社	408	7301	\N	\N	/book/54aa5300-fcf5-4f8d-9306-95fa56c7b1bb32711.jpg	本书为首都师范大学全球史研究中心为历史学院全球史专业研究生的教学需要而编纂的全球史教材。20世纪晚期，随着经济全球化的发展，世界经济一体化进程及其相关问题引起了历史学者的关注，于是在世界范围内出现了一个新的历史研究领域——“全球史”。全球史作为一个研究领域，关注跨国家、跨地区的历史现象，包括不同文化的碰撞与交流、物种交流与生态变迁、不同区域的历史比较等，强调从不同文明间的互动来理解世界历史进程，并由此探寻全球性与地方性的关系。当前国内市场上有关全球史的著作大量涌现。本书详细梳理了全球史的学术发展史、全球史的核心概念和理论以及进行全球史研究的方法，并附有研究参考书目，是一本很好的全球史研究入门著作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	405
1823	建筑给水排水常见计算与设计问题解析	9787561870754	\N	魏涛 主编 	平装	1-1	16开	36.00	\N	天津大学出版社	\N	\N	\N	2022-04-01	/book/7d88bfea-13ce-4005-895a-d749b4bcca011086333.jpg	本书是作者在从事建筑给水排水设计与审查工作的过程中，在对遇到的各种专业问题进行归纳总结的基础上，尝试做出相应解析的成果。本书分为“计算问题篇”和“设计问题篇”两部分，其中包含35个建筑给水排水常见计算问题和27个建筑给水排水常见设计问题。 在“计算问题篇”中，作者注重对计算所依据的规范条文进行列举和引用，力求做到过程清晰，完整准确，有理有据；期望通过具体计算过程帮助读者掌握公式中每个参数的含义和具体数值，以期顺利完成计算并得到正确结果。 在“设计问题篇”中，作者采取夹叙夹议的形式，围绕遇到的问题，引用标准、图集资料，将不同资料中对同一问题所做的规定加以归纳和总结，并提出自己的看法。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	970
1635	公司法律师实务	978-7-301-32756-2	9787301327562	郭春宏 	\N	1	16开	168.00	867.0千字	北京大学出版社	708	7301	\N	\N	/book/74c43923-0b9a-49f7-afe4-26f83bd74aae32756.jpg	公司是各种要素的集合，要素的背后反映利益关系。与公司相关的利益主体众多，包括公司及其股东、债权人、董事、监事、高级管理人员、普通职工等。这些主体的经济地位不同，利益追求各异，相互之间形成纷繁复杂的利益关系。利益平衡于是成为公司法的目的和任务，也是贯穿整个公司法制度体系的核心理念。由此，利益平衡成为思考和解决公司法律师实务问题的重要方法和指导原则。最高人民法院在2012年出台的《关于在审判执行工作中切实规范自由裁量权行使保障法律统一适用的指导意见》中正式确认了利益衡量作为司法方法的地位，明确要求要“正确运用利益衡量方法”。 本书来源于经验，又超越经验，是由中华全国律师协会公司法专业委员会资深委员律师们共同执笔的公司法律师实务的完美“教程”，具有以下特色： （1）理念、方法与专业相融合。本书在此基础上总结了一套公司诉讼实务操作方案，便于按步操作，实现客户目标。 （2）系统性。涵盖了公司从设立到终止每个环节的公司法律师实务。 （3）前沿性。关注公司法律师实务操作前沿和热点、难点问题。 （4）实用性。内容务实、可操作，针对性强，具有明确的现实指导意义。既能满足入行不久的律师的需求，又能给已有相关工作经验的律师带来提升、感悟和启发。 （5）独特性。在行文、体例结构以及对相关问题的归纳总结上都具有独特性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	997
1636	思维导图：思维力训练、学习力训练	978-7-301-32795-1	9787301327951	刘艳，李行思 	\N	1	16开	89.00	253.0千字	北京大学出版社	348	7301	\N	\N	/book/2c086216-9a8b-4e71-9649-9773a2381f0432795.jpg	《思维导图：思维力训练》《思维导图：学习力训练》两册。思维导图是一种可视化的思维工具，它能够帮助我们把思考的内容和维度呈现在纸上，将大脑中看不见、摸不着的思维变得一目了然，让读者的思考看得见。全书共分为6章，具体内容如下：第一章：思维导图创造力训练；第二章：思维导图逻辑力训练；第三章：思维导图记忆力训练；第四章：思维导图笔记力训练；第五章：思维导图学习力训练；第六章：思维导图阅读力训练。每章内容都会用思维导图贯穿始终，帮助孩子快速理清思维，构建知识框架，从而提升思维能力和学习效率。每个板块的内容贴近实际学习生活场景。另外，书中配有80多幅手绘思维导图，把导图6力的核心内容完美呈现出来。本书适合小学生及家长阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	609
1637	侵犯财产罪类案裁判规则与适用	978-7-301-32810-1	9787301328101	刘树德，聂昭伟 	\N	1	16开	99.00	601.0千字	北京大学出版社	508	7301	\N	\N	/book/963789d4-7078-4d25-84d5-ad72d9273d4e32810.jpg	本选题按照《刑法》总则、分则的法条顺序，针对《刑法》分则第五章“侵犯财产罪”下各具体罪名在司法实践中的典型问题进行了全面讲解。本选题对该类罪名涉及的罪刑法定原则、罪刑相适应原则、犯罪概念、犯罪形态、共同犯罪、自首与立功、刑罚的具体适用及追诉时效等《刑法》总则问题和该类罪具体罪名及其相关从重、加重处罚情节认定等《刑法》分则问题进行了归纳。 本选题将司法实践中发生的有代表性的问题作为专题，在每一专题下设置“裁判规则”和“规则适用”两个部分。其中，“裁判规则”部分以总结、概括某一问题的法律适用规则为主，旨在为解决类似问题作出清晰指引；“规则适用”部分详细阐释规则背后的理论支撑及法律依据，让读者在“知其然”的同时“知其所以然”。在此基础上，本书选用最高人民法院发布的指导性案例以及作者在审判实践中遇到的典型案件进行适度点评，以便读者能够更为直观地理解规则适用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	538
1638	销售从入门到精通	978-7-301-32828-6	9787301328286	李金旺 	\N	1	16开	49.00	196.0千字	北京大学出版社	272	7301	\N	\N	/book/37b4c381-434b-4f4c-96c3-50e3ae7a3d3732828.jpg	本书从互联网销售冠军教练多年的销售和管理经验入手，讲述了作者从一线销售成长为销售冠军，再从销售冠军成长为销售教练的经验、方法和教训。 全书分为八章，第一章主要讲述销售人的内在成长，第二章讲述销售新人的成长策略，第三章讲述销售思维和经验教训，第四章讲述销售情商，第五章讲述客户心理分析，第六章讲述销售技巧，第七章讲述对销售经理的重新认识，第八章讲述如何打造一支优秀的销售团队。 本书适合销售从业者阅读。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	490
1639	信息化引领教育未来	9787519128364	\N	曾天山、祝新宇 主编 	平装	1-1	16开	52.00	\N	教育科学出版社	\N	\N	\N	2021-12-01	/book/970dc441-550a-408e-9f73-406926057d1c1085019.jpg	本书以信息技术发展及其在教育领域中的应用为线索，借助生动的案例，阐述了信息化对教育领域的深刻影响，构建了现代信息技术、大数据等新型技术环境下，学校混合式教学、无边界学习、教育治理现代化、教育信息化服务供给等方面的新图景。同时，对人工智能在教育领域中的应用前景，给教育带来的机遇和挑战，进行了前瞻性的思考和展望。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	700
1640	真空冶金学	9787548743538	\N	杨斌 徐宝强 主编 熊恒 孔令鑫 蒋文龙 副主编 	平装	1-1	16开	90.00	\N	中南大学出版社	\N	\N	\N	2021-12-01	/book/224f1512-11ab-4945-a3eb-46438a6225b41085026.jpg	《真空冶金学》是普通高等教育新工科人才培养冶金工程专业“十四五”规划教材， 共分8章， 涵盖真空科学、 真空冶金原理、 真空冶金技术和真空工程技术。 第1章介绍了真空科学与技术的物理基础；第2～7章系统介绍了真空蒸馏的理论与实践、 真空还原的理论与实践、 真空热分解的理论与实践， 包括真空熔炼、 真空脱气以及真空烧结、 真空热处理、 真空镀膜、 真空制粉、 真空焊接等内容；第8章系统介绍了真空工程技术的基础内容， 能够更好地为从事真空冶金科研与教学的工作者和工程技术人员了解、 掌握和运用真空技术提供参考。 本教材汇集了有色金属真空冶金领域新的研究成果， 可供冶金、 材料和相关专业本科生、 研究生以及冶金工作者学习使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	611
1735	幼儿基本动作的发展干预研究	978-7-5689-2781-9	\N	李阳 	\N	1-1	16开	78.00	273.0千字	重庆大学出版社	237	\N	\N	2021-09-15	/book/245d808e-2ea2-45d3-bb9d-80ef53a58a4492781.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	497
1641	医病医身医心——111位名医说健康	978-7-306-07339-6	\N	彭福祥等 	平装	1-1	小16开	120.00	410.0千字	中山大学出版社	368	\N	\N	2021-10-01	/book/1cff8207-c203-43da-85cd-8aa28a34bc621085035.jpg	快速识别卒中，谨记“120”口诀 别再把鼻炎当感冒了，过敏性鼻炎要这样治 日行数万步？当心膝关节报废！ 肿瘤标志物升高就是患上了癌症？ 甲状腺有结节，会变成甲状腺癌吗？ 体检查出肺结节，离肺癌有多远？ 乙肝离肝癌到底有多远？ 最易惹上胃癌的生活坏习惯 沉默的红颜杀手，70%的卵巢癌发现时已是晚期！ 孩子烫伤记住5字诀，快速止痛、不易留疤 孩子经常摔跤、运动能力差，警惕肌营养不良症 机器人做手术可靠吗？ …………	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	701
1642	21世纪以来德国文化发展文献选编	978-7-307-21622-8	\N	帅颖 编译 	平装	1-1	8开	874.00	\N	武汉大学出版社	\N	\N	\N	2021-12-01	/book/c92f20e5-b883-4a20-a320-9618489d7c4e1085041.jpg	该书是德国21世纪以来文化发展战略重要文献的选编，包含《联邦政府文化/创意产业倡议》、《德国文化/创意产业发展报告》、2009年到2012年德国文化/创意产业主要经济数据监测、德国全球化时代的对外文化教育政策等，从多角度、多层面展示了德国文化发展状况，具有一定资料价值和参考价值，对于我们了解德国文化发展战略具有较大意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	331
1643	多端混合直流输电系统建模仿真及试验	9787564383039	\N	邢超，陈仕龙 	0	1-1	16开	128.00	556.0千字	西南交通大学出版社	324	\N	\N	2021-10-01	/book/d10b2d6e-224e-48e5-b9c7-b1d93034c6e11085048.jpg	本书为学术著作，依托于项目“光伏电站直流升压汇集接入系统及装置仿真技术和测试技术”，主要建立大型光伏直流升压汇集接入系统及装置实时数模混合仿真测试平台，支撑阀级控制系统和站级控制保护系统的硬件在环实时仿真测试；开展光伏直流升压汇集接入系统及装置仿真研究；探索研究基于实时数模仿真平台的全尺度系统运行支持技术机理和方法。目前国内针对光伏直流升压汇集接入系统的相关课题或工程处于起步阶段，还没有相关的实际工程案例参考。本书通过围绕大型光伏直流升压汇集接入系统的工程建设，开展装置仿真技术和测试，可为电力电子、直流输电等相关专业高校师生和科研院所工程技术人员提供学术和工程应用参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	514
1644	立新·聚芯·融心——佛山市三龙湾会展北区城市更新规划	9787564384524	\N	漆平 赵炜 	0	1-1	16开	135.00	210.0千字	西南交通大学出版社	144	\N	\N	2021-12-01	/book/4927cd8e-215d-4968-83d7-faf89763b7831085057.jpg	本书是2021届“南粤杯”六校城市规划专业联合毕业设计作品集。该项目主要针对城市规划与建筑艺术设计专业，由广东省城乡规划设计院组织六所高校（广州大学、昆明理工大学、厦门大学、南昌大学、四川大学、西安建筑科技大学）以广东省佛山市三龙湾会展北区城市规划设计为设计主题集结成册。“立新”体现创新精神，“聚芯”展示作品设计围绕会展区域城市功能之芯的功能需求，“融心”代表作品外延要有机融入城市总体布局之中。本书以企业专家与高校教师共同指导毕业设计为特点，通过图片、文字、设计成果等展示教学过程，呈现建筑设计专业联合教学模式的教改成果，体现跨地域、跨校际的教学资源共享，体现新时代珠三角地区兼顾城乡规划现代化高水平特征和城市设计的人文精神；同时各高校设计成果在不同理念背景上形成交互展示。本书设计形式多样，为教学改革做出了有益的探索。本书可供从事城市规范设计的相关技术人员学习、借鉴和参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	607
1645	工程地质（第2版）	9787564385682	\N	赖天文 	0	2-4	16开	39.50	400.0千字	西南交通大学出版社	264	\N	\N	2021-12-01	/book/41c86983-e970-4673-8a02-cc49329930281085071.jpg	本书为普通高等院校土木类专业基础课教材，书稿根据新的教学大纲及教学需要，在初版的基础上修订而成，大致继承了初版教材的内容结构和特色，并对部分知识点和习题进行了修订更新。全书共分为8章，主要介绍了工程地质的研究对象、任务和方法，主要内容包括岩土的工程性质、地质作用、地质灾害和地质勘察等。本书可作为土木工程类（工民建、城建、道桥、地下工程）、水利水电工程和测绘工程等专业的教材，也可供广大土木工程技术人员参考，亦可作为同专业的成人教育教材和参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	233
1646	应用统计	9787564385910	\N	梁涛, 刘赪, 赵联文 	0	1-1	16开	28.00	225.0千字	西南交通大学出版社	148	\N	\N	2022-01-01	/book/41374088-99af-4679-8329-d42224c9295b1085077.jpg	本书是普通高等院校应用统计教材。本书针对文科专业的特点，以实际问题的数据分析为线索，突出统计问题的抽象提炼以及分析方法的直观思想阐述，并配合SPSS统计软件的具体操作和对数据分析结果的解读。全书内容共8章，包括数据的可视化分析、随机变量与分布、抽样分布、总体参数的估计和假设检验、方差分析、相关分析和回归分析。本书注重SPSS软件操作的应用，实用性强。本书可用于高等院校文科类各专业统计学课程的教材，也可作为自学和相关科研工作者参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	944
1647	文献检索与科技论文写作	9787564385989	\N	韩占江，张晶 	0	1-1	16开	58.00	500.0千字	西南交通大学出版社	340	\N	\N	2022-01-01	/book/f0d1e43b-805b-47da-aaf7-6258c22212791085079.jpg	本书是高等院校专业拓展课程教材。本书以标准的科技论文的结构为基本框架，以科技文献检索与论文写作为纽带，介绍文献检索方法、论文写作技法，并结合实例，使学生全面掌握科技文献检索方法，最终达到具备论文写作能力。本书主要内容包括：科学研究与文献检索、科技文献检索基础知识、国内重要文献检索工具及其资源获取、国内重要文献检索工具及其资源获取、网络文献资源获取、科技论文写作、科技论文投稿等。本书将文献检索和科技论文写作有机结合，在掌握科技文献动态的基础上进行科研活动，并撰写科研论文。本书结构清晰，内容循序渐进，结合专业特点，旨在提升学习者文献的检索与科技论文写作水平。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	293
94	江苏省恶性肿瘤报告（2017）	9787565139703	\N	主编 武鸣 韩仁强 	0	1-1	0	88.00	500.0千字	南京师范大学出版社有限责任公司	223	\N	30	2018-12-01	/book/5a4f0371-4406-44a6-aaf2-361f4465fbf19787565139703.jpg	本书较为全面、系统地描述了2014-2016年江苏省肿瘤登记地区人群恶性肿瘤发病与死亡的流行情况，在顺利出版了《江苏省恶性肿瘤报告（2015）》和《江苏省恶性肿瘤报告（2016）》之后，继续填补了江苏省人群肿瘤发病和死亡数据的空白，是我省专业描述癌情信息的书籍，标志着江苏	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	658
1648	内容营销与企业外宣	9787564386054	\N	王琦 许文婧 朱凤梅 	0	1-1	16开	35.00	192.0千字	西南交通大学出版社	144	\N	\N	2022-02-01	/book/2d83c20e-aa4a-4372-8b4a-e19e897aae9c1085082.jpg	本书为高等院校商务英语等英语类专业学生使用的教材，适合已具备一定企业实习经历和校企合作培养的学生使用。全书共分6章，包括企业外宣概述、内容营销与品牌定位、“译创”的筹备、“译创”的实施、“译创”的推广、“译创”的优化。本书将课堂和企业案例、教学资源三者融合，教材中嵌入视频、音频、拓展资源和习题等，案例新颖，应用性强，体现跨学科、互动性和互联网+等特性。本书适用于英语、商务英语等本科英语类专业大三年级使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	772
1649	配送管理实务	9787564386061	\N	谢欣 	0	1-1	16开	39.80	446.0千字	西南交通大学出版社	272	\N	\N	2022-02-01	/book/48a62624-0c85-426c-9f87-86a5e1bd8fbc1085083.jpg	现代物流是促进经济社会发展重要产业，配送是其核心业务之一。配送作为现代物流的末端环节，主要解决商品到消费者“最后一公里”的问题，因此人才需求量大，是相关专业学生的主要就业方向。本书为高等职业院校物流专业教材。全书共分为9个项目：物流配送认知，配送中心及其规划与设计，订单作业管理，备货作业管理，拣货与补货作业管理，包装与流通加工，配货与送货作业管理，退货作业管理，配送中心运营管理。本书由成都工业职业技术学院与成都川宁苏宁物流有限公司在良好的校企合作基础上共同开发，以岗位要求为标准。本书也可作为相关从业人员参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	510
1650	大学生职业发展与就业指导	9787564386092	\N	崔凤华 	0	1-1	16开	54.00	542.0千字	西南交通大学出版社	348	\N	\N	2022-02-01	/book/54242f07-362e-4d22-bd5f-a853e6a5e3fc1085085.jpg	本书为高等职业院校职业发展与就业指导教材。本书共12章，介绍了职业与就业相关知识，具体包含：职业生涯规划的含义、意义、方法，自我认知的方法，职业与职位、社会，职业素质的养成，就业制度与政策，职业选择、职业应试，就业心理调试与培养，就业协议的签订，创业与创业者素质的培养等。本书在充分借鉴国内外职业发展、职业生涯规划、就业理论和就业指导经验的基础上，认真探索系统而科学的教学环节和实践环节，努力达到理论分析和技术指导相结合，适合作为大学生职业生涯规划及就业创业指导课程的教材或教学参考书，也可供职场人士阅读借鉴。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	806
1668	王乐夫教授文集	978-7-306-07236-8	\N	王乐夫 	精装	1-1	特16开	78.00	320.0千字	中山大学出版社	286	\N	\N	2021-08-01	/book/e96d4927-971d-4bfa-89d4-a12130776ee51085206.jpg	本文集选取了王乐夫教授在公共管理领域的主要论文，并按公共管理基础理论、公共管理实践、公共领导等主题进行分类，主要内容包括试论公共管理的内涵演变与公共管理学的纵向学科体系、论公共管理类型——公共管理横向体系分析、公共管理与公共行政：内涵比较探析、公共性：公共管理研究的基础与核心、论公共管理的社会性内涵及其他等，集中展示了王乐夫教授在公共管理方面的主要学术思想、学术成就。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	375
1651	幼儿足球游戏与实践	978-7-306-07222-1	\N	邓伟,李寅主编 	平装	1-1	32开	38.00	100.0千字	中山大学出版社	120	\N	\N	2021-09-01	/book/ab137a13-2241-493b-9d48-8a769d9aa06e1085093.jpg	1.实操性强的游戏内容 书中收录20个分年龄段的亲子游戏，并配套学习视频，教师与家长可不受地点限制，随时随地掌握陪幼儿玩的技巧； 2.按幼儿发育阶段划分内容 按照婴幼儿生长发育规律特点，划分为0-2岁、2-4岁，4-6岁三大阶段，分门别类、科学性地阐述亲子游戏的理论与实践方案； 3.四大发育领域，16种发育效果 本书分为身体发育、情绪发育、认知发育、社会性发育，细分为平衡能力、持久力、敏捷性、肌肉性、释放压力、亲和力、自信能力、自控力、语言表达能力、创意能力、专注力、观察能力、感同身受能力、爱心、沟通能力、合作能力等16种发育效果，体系全面地阐述亲子游戏的特征。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	556
1652	读懂学生：五～六年级学生成长规律与育人策略	9787303263745	\N	边玉芳 等 	平装	1-1	16开	79.00	\N	北京师范大学出版社	\N	\N	\N	2021-01-01	/book/41a28dc9-f688-4242-b299-be03bbbbf3b41085101.jpg	本书专门为中小学教师、班主任、学校管理者及其他基础教育领域管理者与研究者所写， 要落实党的教育方针以及立德树人这一教育根本目标必须读懂学生，只有读懂学生，才能基于学生的成长规律设立1-9年级每一阶段学生具体的育人目标，才能遵循学生的成长规律制定和实施科学的育人策略。《读懂学生：5-6年级学生成长规律与育人策略》首次提出了这个年龄阶段学生的成长规律，并依据这个成长规律，提出相应的育人策略，书中还结合案例，详细为读者介绍如何在具体的教育情境下进行科学、有效地育人，全书兼具理论高度和实践价值，是作者及其团队10年研究成果的总结，对教育工作者是一本不可多得的权威参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	249
1653	中医名方解析与应用	978-7-306-06950-4	\N	王保林，王海燕主编 	平装	1-1	小16开	89.80	510.0千字	中山大学出版社	329	\N	\N	2021-08-01	/book/e1d70692-ecaf-405e-9881-b2bbc501621f1085103.jpg	中医方剂浩如烟海，学习和应用均是难题。本书参考诸多中医方剂古籍、现代名家论著，并收集当代名医名方，结合50多年的临床经验，选用组方药味简单、配伍合理、临床使用率高、实践证明疗效可靠、医生易于掌握的中医名方150首，附方300多首，解析方剂的适应证、发病病机、治疗原则、组方原则、配伍中的药物作用及关系、临床应用的要点与加减变化，以及结合现代医学中诊断明确的疾病应用要点、禁忌证等。可供中医专业医学生、临床中医师、中西医结合医师、中医爱好者参考使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	918
1654	中国乡土小说作家作品研究文选（1910—2010）	978-7-305-21873-6	\N	丛书主编：丁帆 本卷主编：李兴阳，黄轶 	平装	1-1	16开	198.00	\N	南京大学出版社	672	\N	\N	2021-12-01	/book/99853c06-5b0d-47af-9745-fdecf1fdd07c1085106.jpg	中国乡土小说是中国新文学最重要的组成部分，也是中国新小说中名家辈出、流派纷呈的文体重镇。本书梳理了中国乡土小说研究自身的百年发展历史，总结经验，辨识其学术价值，推进其发展。中国乡土小说研究之研究，既是一种学术史研究，也是一种特殊的历史研究。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	432
1655	世界语言教育发展报告	978-7-5213-3035-9	\N	文秋芳 杨佳 编著 	平装	1-1	16开	64.90	186.0千字	外语教学与研究出版社	260	\N	\N	2022-01-01	/book/04854a0f-4e39-4719-9c65-31503d5134691085112.jpg	外语教育紧密对接国家战略，服务于国家的经济、文化与社会发展需求。全球化进程对外语教育质量的要求逐渐提高，改进外语教学法是提高外语教育质量的关键因素之一。 自20世纪50年代以来，欧美发达国家的现代外语教学法发展突飞猛进，尤其近20年来各种新兴流派不断涌现。本书分为"专题篇"和"国别篇"两大部分，分别从专题和全球主要国家的角度，对国内国外外语教育的最新趋势进行了分析与研究，研究结果具有较高的学术价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	831
1656	熊铁基文集	978-7-5622-9470-2	熊铁基	熊铁基 	0	1-1	16开	198.00	\N	华中师范大学出版社	\N	\N	\N	2021-12-21	/book/130a0a02-fa8f-45a2-ba22-09a4376f5b3b1085120.jpg	第六卷内容为秦汉官僚制度史研究，本卷以马克思主义史学理论为指导，通过对秦汉时期历史材料的梳理，探讨了那个时代中国的官僚制度。全卷分为中央官制、地方官制以及官吏的选用、考课及其他各项制度三个部分。作者在对大量史料进行分析的基础上，提出了关于秦汉时期官僚制度的论断。本卷无论是在资料的收集上，还是在史料的分析解读上，又或者是在理论的运用上，都有值得认真学习借鉴之处。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	423
1657	熊铁基文集	978-7-5622-9475-7	熊铁基	熊铁基 	0	1-1	16开	168.00	\N	华中师范大学出版社	\N	\N	\N	2021-12-21	/book/f2d250b2-746d-4274-a384-517ff7f224e61085121.jpg	第七卷由《中国老学史》《二十世纪中国老学史》《中国庄学史》三部著作中作者撰写的部分组合而成，内容主要为中国老学史、中国庄学史，且主要集中在隋唐以前的部分。作者在撰写本卷的过程中，充分发掘和仔细深入解读史料，通过对大量史料进行梳理、研究，较为真实地还原了老学和庄学在中国的产生、形成、发展过程，为中国思想史、学术史、宗教史等研究提供便利和必要的补充，具有较高的学术价值和意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	759
1659	提升青少年自尊、沟通和应对技能的150个活动	978-7-307-22716-3	\N	[美]凯文·格鲁泽夫斯基（Kevin Gruzewski）著；刘茜 译；刘忠纯 主审 	平装	1-1	16开	40.00	\N	武汉大学出版社	\N	\N	\N	2021-11-01	/book/5c6767e6-686b-43cd-8640-8dbbf8e13f2a1085130.jpg	"本书是美国知名娱乐治疗师凯文·格鲁泽夫斯基Kevin Gruzewski专为青少年设计的治疗性活动手册。原书名为Therpy games for teens—150 activities to improve self-esteem,communication,and,coping skills。 全书针对青少年面临的常见挑战，如压力、焦虑、抑郁、愤怒、霸凌和哀伤等问题，以娱乐疗法为基础，设计了150个小活动。无论是用物准备还是活动步骤，都十分简洁清晰、切实可行，让青少年在寓教于乐的氛围中，放下防备，通过自我探索和创造性表达，培养自尊，提升沟通和应对技巧。"	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	537
1660	经济新常态背景下西藏草场产权改革与畜牧业经营方式创新研究	978-7-306-07204-7	\N	李继刚 	平装	1-1	16开	62.00	261.0千字	中山大学出版社	264	\N	\N	2021-07-01	/book/3bb673f9-7cd6-4245-98bd-d02d9d5a7fc41085170.jpg	作为我国的五大牧区之一，西藏草场面积占到西藏土地总面积的69%。草地资源是西藏农牧民最重要的生存资源。同时，由于西藏第二、三产业发展滞后，城镇化整体发育程度不高，吸纳农牧区剩余劳动力作用有限。因此，在一个相对长的时期内，畜牧业依然是广大农牧民一个重要的收入来源。 本书以经济新常态为背景，供给侧结构性改革为手段，借鉴社会体制发展框架，采取历史与现实相结合、文化与经济相结合等方法，发现推进西藏畜牧业创新发展，必须在尊重农牧民主体地位，“使市场在资源配置中起决定性作用”的前提下，通过制度创新和更大力度的政策支持，建立有利于农牧民增收、农牧区稳定、畜牧业发展的内生发展机制。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	954
1661	美丽无瑕：科学护肤指南	978-7-306-07259-7	\N	禾葡兰问题肌肤研究院编著 	平装	1-1	16开	68.00	248.0千字	中山大学出版社	233	\N	\N	2021-09-01	/book/6205b348-a410-4229-95d3-703aab8bc51c1085175.jpg	该书从皮肤的奥秘，认识护肤品，皮肤的基础护理，问题皮肤的诊断，特殊部位、群体、情形的皮肤护理，以及护肤美学等方面由浅入深、循序渐进地对护肤做了科学介绍，以期帮助大众树立正确的护肤理念，掌握科学的护肤方法。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	304
1662	动物病理	978-7-5689-2569-3	\N	张传师 吕永智 	平装	1-2	16开	45.00	177.0千字	重庆大学出版社	103	\N	\N	2022-03-01	/book/6fdd6d1d-4407-404f-a3d0-aae529a49e7b1085183.jpg	本书内容包括病理基本知识和实训指导两个部分，阐述了动物病理和疾病认知、局部血液循环障碍、细胞与组织的适应与修复、水盐酸碱平衡、炎症、缺氧、休克、黄疸、肿瘤等病理变化的发生原因、机理和形态学变化，最后一部分为实训指导手册。 本书每个项目设置了学习目标、病例导人和PBL教学问题，便于学习者明确教学重难点；通过实践临床病例引人教学内容，便于学习者将理论知识点与实际结合；要点一览表和项目小结便于学习者对知识点进行梳理总结与巩固。实训指导中病理变化镜检图片清晰、特征明确，能生动形象地展示各种病理变化，便于学习者直观认识。同时课程内容设置中体现“产赛教”理念，使教材的内容更能对接产业，技能型更加突出。 本书可供高职高专畜牧兽医、动物防疫检疫及相关专业师生使用，还可作为相关专业从业人员的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	452
1663	登天之梯：一个儿童精神科医师的诊疗笔记（原书第3版）	978-7-5689-2972-1	\N	布鲁斯·D.佩里 迈亚·塞拉维茨 著 曾早垒 译 	平装	1-2	16开	56.00	321.0千字	重庆大学出版社	342	\N	\N	2022-03-01	/book/65cad828-dc07-4a05-972e-2c2c8290a5131085189.jpg	本书作者佩里是儿童精神科医生以及儿童创伤治疗专家，用细腻的笔触描述了10余个其亲身参与治疗的、让人心痛的创伤儿童，向读者揭示了早年创伤、忽视、虐待以及遭遇的各种不幸经历对儿童大脑以及各种行为问题的形成可能造成的重大负面影响，同时为创伤儿童的家长、看护人、老师、治疗人员和团队以及社会等可以采取哪些措施来有效地帮助那些已经受到伤害的孩子提出了宝贵的建议。全书是科学与人性的完美结合，在科学阐释儿童创伤理论的同时，饱含作者深刻的人文关怀。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	201
1664	东亚钱志（钱币学著作珍本大全·日本卷）	978-7-5598-4296-1	\N	（日）奥平昌洪 著 	平装	1-1	16开	1,280.00	\N	广西师范大学出版社	\N	\N	\N	2021-10-01	/book/7a77f38f-21af-4f53-80d5-b84d3cc3ef891085190.jpg	中国与日本同属以中国为核心的东方钱币文化圈，在钱币研究领域各有所长。明治维新之后，日本的东方钱币文化研究迎来一次高潮，产生了一批集大成的经典钱谱，其中负盛誉的为“三大钱谱”：今井贞吉所著的《古泉大全》、平尾赞平（书署平尾聚泉）的《昭和泉谱》和奥平昌洪的《东亚钱志》。 奥平昌洪所著《东亚钱志》以图文并茂、考证详细等特点著称。分上下两函，共十八卷。该书出版年代较早，发行量甚少，国内钱币学研究者素称难得一见，《东亚钱志》更是早刊载五代幽州刘守光铸“应天元宝”背“万”、“乾圣元宝”背“百”、“应天元宝背拾”纪值钱之谱录。 本次出版的《东亚钱志》为戴建兵、佟昱主编《钱币学著作珍本大全·日本卷》系列之一，以戴建兵教授所藏底本影印出版，可为钱币学研究学者使用提供极大的资料帮助。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	979
1665	中国桃文化经典品读	978-7-5651-5004-3	\N	主编 程杰 本册作者 渠红颜 	平装	1-1	16开	78.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2021-12-01	/book/20fa5b8c-f909-4179-be31-05f53ff930461085195.jpg	《中国桃文化经典品读》由桃文化研究专家渠红岩潜心选注。全书在浩瀚的中国古代文献典籍中精挑细选出百余则有关桃的植物特性、园林园艺、文学艺术、民俗风物以及精神价值等方面的经典作品和文献，既包含植物学、园林园艺知识，也有诗文、绘画作品，分类编排，详明注析，全面、系统地展示中华桃文化的璀璨历史、美好情趣和深厚思想意义，图文并茂地诠释了桃对中华民族社会生产与文化生活的润育与滋养。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	178
1666	百年恰风华:燕山大学校庆工作纪实	9787576102161	\N	王伟伟，贾丽洁，纪红月编 	平装	1-1	16开	78.00	\N	燕山大学出版社	\N	\N	\N	2021-09-01	/book/a3615a1c-47ad-4961-a782-22cc95893dc81085199.jpg	本书内容基于燕山大学百年校庆开展情况，围绕校庆说明、校庆基础、校庆活动、校结、校庆资料等方行详细介绍，内容实，图文并茂。本书的出版一来方便学校的资料存档，二来使读者对燕山大学百年校庆的设计初衷、活动安排等有更深层次的了解，通过对燕山大学百年校庆工作的梳理结，为其他高校开展校庆工作提供参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	805
1667	高手教师	9787576013856	\N	魏智渊 	平装	1-1	16开	58.00	\N	华东师范大学出版社	255	\N	\N	2021-04-01	/book/f424058d-4b28-4164-86e7-2048b42b42941085203.jpg	教师培训专家魏智渊多年来专注于教师发展研究与实战培训，他结合自身的多重教育身份与多样教育实践，从教育观念、课程建设、家校沟通、学生教育、教育细节、自我修炼等六个方面，系统分享了自己对于教师成长发展的独到思考和专业引领，全方位助力一线教师加强自我修炼，打破成长的瓶颈，实现自我突围，从新手教师、普通教师，蜕变为高手教师、卓越教师。书中给出的教师成长建议，源自作者生动的教育实践，专业有效可借鉴，相信它们一定能在一线教师的教育实践中扎根发芽，成为教师专业发展的好帮手。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	271
1669	阴阳会通解伤寒论（第三版）	978-7-306-07271-9	\N	彭家柱 	平装	3-3	特16开	65.00	280.0千字	中山大学出版社	235	\N	\N	2021-08-01	/book/2cca92cd-9090-4ee9-b8e6-845e172091471085215.jpg	本书以“阴升为阳，阳降为阴，阴阳有序运行会通”的阴阳会通思想解读《伤寒论》。全书分为上下两篇。上篇为基础原理篇，以阴阳升降、会通理论对《伤寒论》三阴三阳病证深入剖析。下篇按照宋刻版《伤寒论》条文顺序逐条解读，全面阐释探究《伤寒论》中的“阴阳会通”思想，并参考与《伤寒论》成书年代相近的《神农本草经》中的药性药效来分析，探求仲景用药本源。第一版中，下篇主要对《伤寒论》中有方剂的条文进行解读，但对无方剂的条文涉及甚少。《伤寒论》中无方剂条文与有方剂条文是一个有机的整体，共同阐述了张仲景的医学思想。第二版对上篇基础原理的第一章作了理论补充，在下篇对条文解读进行全面的更新。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	903
1670	解码智能时代2021：前沿趋势10人谈	978-7-5689-2883-0	\N	信风智库 编 王蓉 胡文江 译 	\N	1-1	16开	88.00	443.0千字	重庆大学出版社	198	\N	\N	2021-08-20	/book/b5731cfe-d74c-4ec7-8cbf-f9dbfe5764be92883.jpg	本书聚焦10个业界与公众最为关注的热点话题，访谈10位来自理论研究和智能产业领域的代表人物(包括中科院院士、图灵奖得主、产业领军人等)，话题包括大数据、人工智能、区块链、工业互联网、数字孪生、量子科技、深空探测和脑机接口等，贯穿了智能时代从基础理论研究，到前沿科技探索，再到技术产业应用的三个维度。力求从多维、交融、延续的视角展现一个更加立体与多元的智能时代，挖掘智能时代思考者、研究者、探索者与实践者的前瞻性思考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	908
1671	大学生创新创业基础教程	978-7-5689-2653-9	\N	闫俊霞 吴秋平 陈锐 	0	1-2	16开	45.00	350.0千字	重庆大学出版社	240	\N	\N	2021-07-23	/book/fa7c639d-a018-4b60-b1dd-996488c7d02d92653.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	808
1672	单片机C语言程序设计及仿真	978-7-5689-2518-1	\N	陈伟 白红霞 刘德友 	\N	1-1	16开	59.00	319.0千字	重庆大学出版社	199	\N	\N	2021-07-22	/book/e607f1cd-2e1b-49a4-9a42-18449bee77f792518.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	440
1673	计算机应用基础辅导用书	978-7-5689-2761-1	\N	黄思权 杨传双 	\N	1-1	16开	42.00	401.0千字	重庆大学出版社	249	\N	\N	2021-08-29	/book/64f5c255-db6b-4aa1-94dc-589b16cc25c192761.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	886
1674	园林美术（第3版）	978-7-5624-8361-8	\N	孟庆英 	\N	3-5	16开	51.00	276.0千字	重庆大学出版社	166	\N	\N	2021-08-13	/book/4c56ff2a-242c-4b0d-9230-6a72bce328298361.jpg	本书是高等职业教育园林类专业系列教材之一，由美术基础理论、美术基础实践技能和园林专业应用技能三大模块构成。包含美术概述、绘画基础知识、素描、色彩、园林景观效果图表现技法、园林植物配置与造景、美术字与图案 。每一模块由若干相对独立的单元构成，每个单元包括知识目标、能力要求、正文、课堂训练和拓展训练等。教材内容紧扣园林、建筑、景观、环艺等设计领域的需求，理论基础重点突出实际技能所需要的内容，运用大量精美图片，有步骤、有图解、有赏析，它既是教师的教学参考书，又是学生实践技能的训练摹本，具有明显的高职特色，又具有较强的专业性、规范性、实用性和可操作性。本书配有电子教案，可扫描封底二维码查看，并在电脑上进入重庆大学出版社官网下载。 本书适合高职高专、应用型本科院校、五年制高职园林、建筑、景观、环艺等设计专业作教材，也可作为相关专业设计人员的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	788
1675	关灯就睡觉：哈佛医学院高效睡眠指南	978-7-5689-2873-1	\N	格雷格·D.贾克布 著 杨小虎 刘欢 朱宁 译 	0	1-2	大32开	46.00	177.0千字	重庆大学出版社	214	\N	\N	2021-08-13	/book/b990fc37-f9ec-42c3-b2bc-62cd922becfe1085391.jpg	本书首先回顾了安眠药的最新发展、疗效对比和副作用，以及有关睡眠方面的一些常见误区，让读者了解失眠的本质以及失眠患者许多得不偿失的做法。在此基础上，作者分享了自己在哈佛医学院的行为医学失眠治疗项目，用以指导大家循序渐进地克服失眠。该项目是美国非药物治疗失眠的首创，基于作者在哈佛医学院20余年的研究和临床实践，形成了围绕认知行为疗法展开的六星期失眠计划，通过认知重构、放松疗法等技巧教大家学会更积极地识别自己的消极思想，树立正确的睡眠观念，从而改善睡眠和健康。书中丰富的案例和互动练习，让你清楚地知道为了战胜失眠，你需要做什么以及应该如何去做。 本书将帮助你： 明白对睡眠的焦虑和不良睡眠习惯是如何让你睡不着的？ 了解常用安眠药的副作用以及如何有效地停止或减少安眠药的服用； 改变有关睡眠的消极想法，并建立促进睡眠的行为和生活方式； 掌握放松方法和减压技巧，收获健康和幸福。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	507
1676	酒店英语口语实用教程	978-7-5689-2897-7	\N	刘艳贵 范庆华 	\N	1-1	16开	23.00	208.0千字	重庆大学出版社	121	\N	\N	2021-08-12	/book/785e5637-3443-43f1-8711-12eb08d1040c92897.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	422
1677	护考	978-7-5689-1824-4	\N	全国护士执业资格考试编写组 	\N	3-3	16开	150.00	1085.0千字	重庆大学出版社	589	\N	\N	2021-07-23	/book/899804ed-27db-4bfc-8ec1-3f951222d4ef91824.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	563
1678	对口升学考试机械专业检测卷	978-7-5689-2902-8	\N	田燕 	\N	1-1	8开	28.00	90.0千字	重庆大学出版社	60	\N	\N	2021-08-26	/book/0ba49f19-dac1-403c-840a-d9c735b6344992902.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	951
1679	成长英语自主学习用书·基础篇	978-7-5624-9044-9	\N	“成长英语”编写组 	0	3-15	大16开	34.00	323.0千字	重庆大学出版社	201	\N	\N	2021-09-03	/book/f9946453-d8f8-45a2-8a57-0e1fd4a6fa779044.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	303
1680	市政工程施工组织与管理	978-7-5689-2716-1	\N	黄春蕾 李书艳 	\N	1-1	16开	39.00	265.0千字	重庆大学出版社	181	\N	\N	2021-06-21	/book/5127c6ac-8f99-457d-9803-f8672c30e50c92716.jpg	本书根据全国住房和城乡建设职业教育教学指导委员会市政工程类专业指导委员会编写的《高等职业教育市政工程技术专业教学基本要求》进行编写。编写团队包括高等职业院校教师及行业、企业专家。本书在讲授理论知识的同时，附有完整的市政工程案例，并将纸质教材与数字资源有机整合，学生可扫描书中二维码实现随时随地移动学习。 本书以市政工程施工组织设计为核心，以项目管理为重点，依据现行市政工程施工及验收规范进行。全书共分为8章，内容涉及市政工程施工组织概论、市政工程施工准备工作、流水施工组织、工程网络计划技术、市政工程质量管理、市政工程职业健康安全与环境管理、单位工程施工组织设计、BIM在施工组织管理中的运用、市政工程施工组织设计实例。 本书既可作为高职高专市政工程技术专业及相关专业教材，也可作为成人教育土建类及相关专业的教材，同时可供从事建筑工程等技术工作的人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	527
1681	土木工程课程设计指南	978-7-5689-2700-0	\N	李燕 张广兴 	\N	1-1	16开	36.00	328.0千字	重庆大学出版社	195	\N	\N	2021-08-23	/book/466e0847-4e74-414a-ace7-a627c735867a92700.jpg	"本书是《应用型本科土木工程专业系列教材》之一。全书共涉及土木工程专业课程体系中4门主干课程设计,包括普通钢屋架课程设计、门式刚架课程设计、混凝土课程设计、桩基础课程设计。每个课程设计独立成章,每章均包括设计任务书、设计指导书及设计实例3个部分。另外,在钢结构和混凝土课程设计中增加了专业软件的教学,制作了课程设计实例计算机辅助设计的教学视频;在普通钢屋架课程设计中增加了模型制作环节,实现设计到施工的全过程模拟,并录制了教学视频。 本书可作为高等院校土木工程专业、工程管理专业本科课程设计实践环节教材,也可作为工程领域的技术人员、项目管理人员和政府管理人员的参考书。 "	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	969
1682	工程流体力学（第3版）	978-7-5624-8130-0	\N	赵琴 杨小林 严敬 	\N	3-7	16开	49.00	456.0千字	重庆大学出版社	273	\N	\N	2021-07-25	/book/e53aeaf0-2c70-4ac4-8b44-794471e938348130.jpg	本书是普通高等教育建筑环境与能源应用工程专业基础课教材，也是四川省省级一流本科课程“流体力学”的配套教材。其内容包括：流体力学的研究任务、方法及流体的主要力学性质，流体静力学，流体动力学基础，明渠流，堰流与闸孔出流，渗流，气体动力学基础，湍流射流。本书符合人才培养目标及课程的基本要求，深度适宜，科学理论与概念阐述准确，注重理论联系实际。本书配有PPT、课后习题及解答等基本数字资源，与本书配套的还有教学软件和试题库，可供读者使用。 本书可供建筑环境与能源应用工程、热能与动力工程、水利水电工程、给排水科学与工程、环境工程等多个专业的本科教学使用，也可供相关专业自学考试参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	869
1745	红桥——王尽美在山桥	9787811428384	\N	李泽东 刘剑 	0	1-1	16开	52.00	\N	燕山大学出版社	\N	\N	\N	2021-06-01	/book/8d98bd7e-0622-4213-a98f-bf170b1ecbdc1085832.png	《红桥——王尽美在山桥》是为庆祝中国共产党成立100周年，燕山大学出版社策划、出版的精品主题图书。该书采用纪实文学的手法，深入挖掘历史见证者的口述史料，记录了山桥最早的红色记忆，彰显了王尽美在山桥和中国工人运动史中的风范和担当；深入挖掘整理了王尽美同志在山桥播撒下的革命火种，创建秦皇岛地区第一个党组织的光辉业绩；更展现了山桥人在“红桥精神”引领下实现中国桥梁之梦的艰难历程。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	165
1746	单片机原理及应用	9787811421897	\N	马继伟 伦翠芬 杨英 	0	1-1	16开	59.00	\N	燕山大学出版社	\N	\N	\N	2021-01-01	/book/84b76c7d-9954-4c12-b54b-cb416908769f1085838.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	990
1684	绘画是什么？如何用炼金术语言思考油画	978-7-5689-2660-7	\N	詹姆斯·埃尔金斯 著 林煊 译 	\N	1-1	大32开	55.00	262.0千字	重庆大学出版社	274	\N	\N	2021-09-17	/book/c5b142b7-e988-4d28-828f-ca0555ba7f1592660.jpg	炼金术被埃尔金斯称为“被遗忘的化学”，其文献记载中大量违反科学常识的知识和公式，却是一门用于思考物质及其内部运动过程的最发达的语言。因此，关注炼金术能帮助当代人反思和重构古典时期的绘画本质和艺术理论。 作为利用水与石混合的例证，绘画等视觉艺术是其一，炼金术是其二。在炼金术中，贤者之石是终极目标；而在绘画中，通过水与石的关系最终表现出独一无二的图像和色彩是终极目标。炼金术和绘画一样，其本质是实验室中复杂、肮脏、混乱而漫长的实验，这些实验的成功率不高，失败的案例也很多，并且绝非仅靠文本功夫就能深入探究，必须结合充分、专业、倾尽全力的实践。“物质性的记忆”构成了绘画的主体，而本书正是通过对炼金术常见步骤的分析解读，重现并反思油画画布上细腻的颜料纹路、笔触技巧和调配秘诀，从而有效地充实和巩固艺术史学的“理论地基”。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	643
1685	中餐烹饪基础（第2版）	978-7-5624-7302-2	\N	陈勇 	\N	2-7	16开	49.00	246.0千字	重庆大学出版社	142	\N	\N	2021-08-25	/book/7f59228e-1c4a-4629-8613-5fa834a23f497302.jpg	本书主要介绍了中餐烹饪概述，烹饪基本功训练，刀工与原料成形，烹饪原料的鉴别，烹饪原料初加工，火候，预熟处理，着味、挂糊、上浆、勾芡、制汤工艺基础，调味工艺基础，菜肴烹调方法及运用，菜肴和宴席的配制工艺等基础知识。 本书在重视中餐烹饪基础理论性、指导性的基础上，突出实操技术的务实性、灵活性。本书主要供中等职业学校中餐烹饪专业师生使用，也可作为职工培训学习教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	647
1686	体育与健康	978-7-5689-2784-0	\N	姜振捷 徐云鹏 	0	1-2	16开	42.00	508.0千字	重庆大学出版社	324	\N	\N	2021-07-29	/book/72562e81-eacc-40cd-ac5b-60984fa249dd92784.jpg	本书分为上篇体育理论知识、中篇运动技能、下篇传统与休闲运动项目三部分内容。体育理论部分以高职体育教学目标为基本点，以体育健身理论与方法为框架，以常见的运动征象为基本内容，介绍了高职体育的教学地位、目标和功能，科学健身的原则和方法、运动保健与医务监督的方法、职业病的防治及体疗的方法以及小型体育竞赛的组织与编排。运动技能部分系统介绍了健身效果好的常规体育项目，也精选了学生喜闻乐见的大球和小球运动项目。传统与休闲运动部分在每个运动项目中都系统地介绍了学习方法和健身方法。 本书集知识性与操作性于一体，通俗易懂，可作为高职院校学生的体育与健康指南。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	423
1687	杆系结构有限元	978-7-5689-2727-7	\N	陈名弟 	\N	1-1	16开	39.00	245.0千字	重庆大学出版社	157	\N	\N	2021-08-22	/book/8446421b-f025-492c-87ed-556ce5ae83bb92727.jpg	本书将矩阵位移法与杆系有限元内容重新整合，以矩阵分析思维贯穿始终，从经典位移法的矩阵分析出发，构建了从单元分析到整体分析、从静力分析到动力分析的完整杆系分析系统。同时，结合有限单元法的基础理论，从完全截面分析和完全矩阵变换的角度，提供了单元分析方法的另一种选择，以便与结构分析后续理论（如弹塑性、实体单元等）相衔接。 全书共6章，内容包括矩阵与线性变换、矩阵位移法（传统位移法的矩阵表达）、有限单元法概述、杆系有限元单元分析（建立在截面刚度和变形插值基础上的单元分析）、杆系结构整体分析以及杆系结构动力分析。 本书可作为高等学校土建、水利、机械等专业的杆系结构有限元课程教材，也可作为相关专业工程技术人员的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	974
1688	平面设计应用教程	978-7-5689-2326-2	\N	刘松华 	\N	1-1	16开	58.00	289.0千字	重庆大学出版社	161	\N	\N	2021-07-22	/book/ea1692af-059c-4c1c-ae23-fd8f4a67c70b92326.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	404
1689	火车与飞鸟——经济学经典俗语解析	978-7-5689-2708-6	\N	傅顽璐 	\N	1-1	大32开	48.00	196.0千字	重庆大学出版社	288	\N	\N	2021-06-30	/book/b2e1dcdd-9cd3-47cc-a767-cb63136f811a92708.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	878
1690	网店视觉营销设计与制作	978-7-5689-2964-6	\N	叶丽芬 	\N	1-1	16开	49.00	330.0千字	重庆大学出版社	\N	\N	\N	2021-09-21	/book/230a4bd1-5e61-4c1b-b8ae-db5c5940845e92964.jpg	本教材结合企业对网店美工岗位的需求和网店运营推广“1+X”证书的职业技能要求，把企业项目和“1+X”证书的技能鉴定内容纳入教材内容，开发基于工作过程的实训项目；教材从了解视觉营销价值入手，以如何一步一步为乐乐包袋皮具公司打造有视觉冲击力的网店为主线，理论结合项目案例，介绍视觉色彩、文字、构图基本知识，撰写网店文案，设计网店广告，制作淘宝短视频，设计店铺的C店、手机店、微店。让学生通过项目化的实践，成为能独立从事网店页面设计的应用型人才。 本教材可作为职业院校电子商务专业或其他相关专业教学用书，也可作为网店运营推广1+X证书（初级）美工内容的指导用书或网店美工设计人员的培训资料。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	371
1691	工程力学	978-7-5689-2912-7	\N	朱耀淮 袁科慧 曹晓斌 	\N	1-1	16开	48.00	439.0千字	重庆大学出版社	169	\N	\N	2021-08-03	/book/2db3025c-773b-4b6d-97a2-683e4231e9e192912.jpg	本书共12章，主要内容有：静力学的基本概念、平面汇交力系、力矩与平面力偶系、平面一般力系、材料力学的基本概念、轴向拉伸和压缩、剪切与扭转、平面图形的几何性质、梁的弯曲、斜截面上的应力、组合变形、压杆稳定、附录（型钢规格表），并配套有练习册。本书可作为职业院校铁道工程技术、高铁维护工程技术、道路与桥梁工程技术、城市轨道工程技术、隧道与地下工程技术、建筑工程技术、建筑设计、建筑工程项目管理等专业的教材。当全书通讲时，可作为高职本科教材，也可作为土建类工程技术人员的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	905
1699	园林测量(第3版)	978-7-5624-3743-7	\N	高玉艳 	0	3-15	16开	46.00	499.0千字	重庆大学出版社	307	\N	\N	2021-08-13	/book/6386a45b-ca81-489e-83e2-9a7cc51fc5c91085519.jpg	本书是高等职业教育园林类专业规划系列教材之一，是根据高等职业教育的培养目标编写的。本书既反映园林测量学科最新知识，又顾及生产实际需要，以阐明基本原理和培养学生的实际动手能力，突出实际应用为宗旨,注重实践内容。本书的主要内容为：测量基本知识、水准测量、角度测量、距离测量与直线定向、小地区控制测量、全站仪、全球定位系统(GPS)、大比例尺地形图测绘、大比例尺数字地形图的成图方法、地形图的应用、园林道路测量、园林工程测量、实训。全书共设23项实践技能训练项目、2项综合实训内容，书后附有实训指导，用于指导学生实践。本书配有电子课件（可扫描封底二维码查看，并在电脑上进入重庆大学出版社官网下载），供教师参考。 本书为高等职业教育园林、城市规划、林学、园艺、农田水利、多种经营、土地规划与管理及相关专业学生的教材，也可供中等职业学校和成人教育院校相关专业选用，还可供从事测绘工作的技术人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	532
1692	DIV+CSS3网页设计与制作	978-7-5689-2886-1	\N	宋文平 王卫华 刘跃 	0	1-2	16开	48.00	390.0千字	重庆大学出版社	256	\N	\N	2021-08-31	/book/ae0458e4-200a-437a-9c49-bf43487d5d9392886.jpg	本书根据高职院校“三教”改革精神，进行了将课程思政育人与专业教学融合的尝试。全书分为13个模块，模块1介绍了网页设计的基本知识；模块2介绍了网站的创建与管理；模块3~7介绍了HTML5的基础知识与基于HTML5的超链接、表单、多媒体应用；模块8，9讲述了CSS3基础知识及应用；模块10~11讲述了基于DIV+CSS的布局基础知识；模块12讲述了基于DIV+CSS3的网页布局、网站制作方法；模块13讲述了网站的测试、发布与维护等知识。 本书在编写过程中坚持科学性、实用性、先进性和职业性相统一，力求与计算机技术发展同步，着重提高学习者网页设计和制作的能力。在编排形式上，采用“模块—任务—案例”循序渐进的方式，结合大量的实际案例。每个模块包括若干个任务，每个任务由案例引入、主要知识点、课程育人和课堂互动组成。每个模块末都设置了“技能训练”板块，适合“教、学、做、考”一体化教学。 本书可作为高职高专计算机网络技术、电子商务、软件技术、计算机应用、动漫设计等相关专业的教材，也可供各类培训、网页设计从业人员参考使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	320
1693	动力电池及能源管理技术	978-7-5689-2813-7	\N	黄勇 	\N	1-1	16开	39.00	157.0千字	重庆大学出版社	112	\N	\N	2021-06-17	/book/8e4c606f-5f1a-4074-a62e-9d10408686c492813.jpg	本书从电池的起源和发展开始，系统介绍了电动汽车动力电池技术的发展历史、现状与趋势，内容涵盖动力电池的基础知识；锂离子电池、碱性动力电池的类型、结构、原理及特点；电动汽车电源管理系统及其关键技术。读者可以通过本书迅速了解电动汽车动力电池相关技术及应用情况。 本书内容深入浅出，既适合对电动汽车动力电池技术感兴趣的人士阅读和学习，也可以满足职业院校新能源汽车类相关专业的教学需求。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	541
1694	建筑工程质量控制与验收	978-7-5689-2796-3	\N	杨卫奇 林文剑 	0	1-2	16开	49.00	482.0千字	重庆大学出版社	302	\N	\N	2021-08-27	/book/ff2a68f8-56b0-4b65-a22f-05c4d6284a0392796.jpg	本书以新颁布的法律、法规和建筑行业新标准、新规范为依据，结合职业资格认证特点，以质量员专业技能训练为核心，以满足质量员岗位要求为目标编写而成。全书内容包括建筑工程质量管理概述，建筑工程施工质量控制，建筑工程施工质量验收，地基基础工程质量控制，砌体结构工程质量控制，混凝土结构工程质量控制，钢结构工程质量控制，屋面工程质量控制，建筑装饰装修工程质量控制，建筑节能工程质量控制，建筑工程质量问题与事故处理 11个项目。全书内容实用、形式新颖、特色鲜明。 本书可作为高职高专建筑工程技术、建筑工程管理、建筑工程监理等土建类和工程管理类专业的教材，也可以作为土建方向质量员考试培训教材，还可供建筑施工企业技术管理人员、质量检验人员以及监理人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	192
1695	低垂之眼：20世纪法国思想对视觉的贬损	978-7-5689-2698-0	\N	马丁·杰伊 著 孔锐才 译 	0	1-2	16开	128.00	963.0千字	重庆大学出版社	534	\N	\N	2021-09-21	/book/fc48174d-3776-40a2-8030-1b6cec0f57e41085502.jpg	对视觉的推崇，在西方文化中早已根深蒂固——从柏拉图、笛卡尔直到启蒙运动，视觉往往与清晰、秩序和理性相关联。随着摄影、电影的出现，视觉更晋升为现代感官王国的领主。然而，来自法国的现代思想家——萨特、梅洛-庞蒂、福柯、拉康、巴特、德里达——也以各种方式质疑视觉的霸权地位：从印象派到超现实主义，从现象学到精神分析，从结构主义到后现代分析…… 本书为读者展现了“视觉中心主义”如何被撼动的历史。凭借其杰出的材料整合能力，作者将眼花缭乱的批判整合进宏大的思想史议题，从一个全新的角度呈现出法国思想史。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	347
1697	土力学与基础工程（第5版）	978-7-5624-6086-2	\N	代国忠 李鹏波 	\N	5-11	大16开	69.00	771.0千字	重庆大学出版社	405	\N	\N	2021-08-05	/book/e4267396-a573-4d6c-a92c-cb457e76cd756086.jpg	本书是根据新的《高等学校土木工程本科指导性专业规范》编写的土木工程专业系列教材之一，较系统地介绍了土力学与基础工程的基本理论知识、分析计算方法及在工程实践中的应用等。本书体现了土力学与基础工程的有机结合，强调了“土力学”是“基础工程”设计和应用的理论基础。全书共分为12章，除绪论外，内容包括：土的结构组成与物理性质、土体中的应力计算、土的压缩性与地基沉降计算、土的抗剪强度及土压力、地基承载力及土坡稳定性、浅基础及挡土墙、桩基础、基坑工程、沉井基础与地下连续墙、地基处理技术、特殊土地基。本书密切结合土木工程本科人才培养目标和要求，突出实用性和综合应用性，各章内容由浅入深、概念清楚、层次分明、重点突出，涉及基础工程设计部分均依照我国现行规范进行编写，主要章节附有综合性设计计算实例及习题。 本书主要作为普通高等学校土木工程专业本科的教学用书，亦可供其他专业师生及工程技术人员参考使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	855
1698	AutoCAD辅助园林景观设计(第3版)	978-7-5624-8102-7	\N	余俊 谭明权 	0	3-12	16开	38.00	318.0千字	重庆大学出版社	188	\N	\N	2021-09-23	/book/d2b63cc6-124d-4744-b89b-620652c2907c1085518.jpg	本书是“十三五”职业教育国家规划教材。本书是在AutoCAD 2014中文版的基础上,结合行业制图规范,引融国家绘图员职业标准,采用工作手册式表现形式,按照“项目＋任务”编写体例,结合园林计算机绘图特点来编写的。本书共分上下2篇,上篇是基础命令训练,包含3部分内容:项目1简单介绍AutoCAD园林绘图操作基础;项目2结合例子介绍园林设计中常用的绘图命令;项目3结合例子介绍园林设计中常用的编辑命令。下篇是实战型项目训练,分为3大项目,11个任务;项目4详细介绍园林设计要素的绘制方法;项目5通过案例讲解园林设计方案图的绘制步骤与技巧;项目6介绍园林种植施工图绘制方法.园林工程量的统计方法以及园林施工图尺寸标注与布局打印方法。本书配有数字资源和电子课件(扫描前言上方二维码查看,并从电脑上进入重庆大学出版社官网下载),数字资源的内容包括书中项目提到的素材源文件。书中增加16个二维码,可扫码学习。 本书强调实用性和技巧,叙述深入浅出,讲解细致,并将作者多年应用CAD绘图的心得和摸索出来的技巧进行了总结和推广,可以很大程度地提高绘图效率,对读者有所裨益。 本书可用作高职高专院校,应用型本科院校高职学院、成人教育、五年制高职等园林技术,园林工程技术,风景园林设计等专业的教材,也可供园林景观行业从业人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	764
1701	工程制图基础习题集	978-7-5689-2935-6	\N	何培斌 李奇敏 	0	1-2	8开	39.00	141.0千字	重庆大学出版社	58	\N	\N	2021-08-30	/book/bb03bac0-9c48-4b75-9379-f9fc9b3985d01085526.jpg	本习题集与何培斌、李奇敏主编的《工程制图基础》教材配套使用，其内容编排与主教材基本一致。本套教材是普通高等教育工程类专业教材，主要内容包括制图基本知识和基本技能，投影概念及投影法，点、直线、平面的投影，辅助正投影，平面体及其投影，规则曲线，曲面及曲面立体，轴测图，组合体及其投影，图样画法，计算机辅助三维造型设计及制图等练习。各章习题由浅入深，难度逐渐递增，以方便教师根据不同要求灵活选用。 本习题集可作为高等院校机械类、土建类、非机类、近机类各专业“工程制图”“工程图学”“机械制图”“建筑制图”等相关制图课程的配套习题集使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	729
1704	劳动争议调解仲裁法学	978-7-5689-2749-9	\N	杨春平 	\N	1-1	16开	54.00	446.0千字	重庆大学出版社	311	\N	\N	2021-08-13	/book/f24d21cc-45e7-428b-9477-8db35a4f83fe92749.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	292
1705	商品图片处理	978-7-5689-2659-1	\N	刘玉洁 林丽艺 	\N	1-1	16开	54.00	264.0千字	重庆大学出版社	185	\N	\N	2021-09-21	/book/33f4f0de-f5f1-4f55-9c04-6d1a0198050392659.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	979
1706	应用微生物学原理与技术	978-7-5689-2979-0	\N	孟令波 	\N	1-1	16开	49.00	304.0千字	重庆大学出版社	177	\N	\N	2021-08-20	/book/22997f11-1c1b-48c2-813b-b3b371ca379692979.jpg	本书系统阐述了应用微生物学的基本原理，介绍了微生物学在各行各业的应用技术及发展趋势，帮助读者初步掌握直用微生物学原理和技术，解决微生物在工业、农业、环境等领域中的应用，为全面学习专业课理论和技术奠定基础。全书共6章，内容包括应用微生物学基础知识，微生物在环境污染生物修复、水处理、农药、肥料、饲料、食用菌等方面的应用。本书注重理论联系实际，力求反映应用微生物学的最新研究成果，表述通俗易懂，以利于在生物科学受过初步训练的人所理解。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	985
1707	汽车发动机技术基础与技能	978-7-5689-2816-8	\N	高亮 张光铃 	\N	1-1	16开	37.00	177.0千字	重庆大学出版社	126	\N	\N	2021-09-10	/book/26cc2085-562b-4019-9d1d-f3d7c396b4e492816.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	182
1708	音乐素养（第3版）	978-7-5624-9999-2	\N	邓薇 吴小丽 	0	3-9	16开	36.00	187.0千字	重庆大学出版社	125	\N	\N	2021-07-15	/book/a4be133d-138a-458a-b77f-33f55f4475629999.jpg	本书以培养学生对音乐的理解力和鉴赏力，使其形成正确的音乐审美态度和高尚的音乐审美情趣为目标，将内容划分为六个教学模块。这六个教学模块均以音乐欣赏为基础，适当地加入音乐拓展体验和实践：模块一为音乐概述，模块二为声乐，模块三为器乐，模块四为合唱，模块五为流行音乐，模块六为舞蹈，全书在编写时采用一体化的课程思维，注重让学生在音乐体验和拓展过程中学习音乐，即“做中学”，探索出音乐教学“教师易教、学生易学”的教学模式。 本书为中高职院校及技_工院校音乐课程通用教材，适合中高职院校及技工院校的师生使用，也可供对音乐有兴趣、想提升自身音乐素养的人士作为参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	145
1709	观赏植物栽培技术（第2版）	978-7-5689-2429-0	\N	陈学红 张维成 	\N	2-4	16开	59.00	749.0千字	重庆大学出版社	472	\N	\N	2020-08-23	/book/293c1b52-ccf6-460b-8a58-ea51948f2c6292429.jpg	本书以培养学生的观赏植物生产与养护管理能力为主线，根据行业岗位需求和职业标准，选取教学内容，突出技能训练，注重实用性，着重吸收新知识、新成果，体现“任务驱动、产教结合”的人才培养模式，帮助学生尽快适应工作岗位。 全书分为4大模块，分别为：观赏植物的基础知识，观赏植物的栽培条件，观赏植物的繁殖与栽培管理技术，常见观赏植物的栽培技术。为突出对学生实践技能的培养，本书遵循理论以“必需、可持续”为度，理论教学为实践教学服务的高职教育理念，设计了目标、准备、行动、拓展、评估五个环节。 本书可作为职业院校园艺、园林、现代农业等农林类专业教材，也可作为花卉园艺工、绿化工等职业技能鉴定培训教材，还可供观赏植物生产和管理人员参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	696
1710	儿歌弹唱教程	978-7-5689-2766-6	\N	何怀兵 张娓 	0	1-2	大16开	47.00	297.0千字	重庆大学出版社	145	\N	\N	2021-08-23	/book/58db0b75-28d5-497e-99cb-1bec412c911592766.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	296
1711	商务英语演讲实用教程	978-7-5689-2892-2	\N	黄秋凤 曾密群 	\N	1-1	大16开	32.00	301.0千字	重庆大学出版社	122	\N	\N	2021-09-23	/book/ed95d70d-a3b1-4886-afda-5b18c7e7a88d92892.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	452
1712	新时代大学英语口语教程——实用交际	978-7-5689-2728-4	\N	黄丽君 夏婉璐 	0	1-2	大16开	46.00	316.0千字	重庆大学出版社	115	\N	\N	2021-08-31	/book/7e1299dd-ec0c-4a40-883c-12ed54e9a63c92728.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	643
1713	学前儿童语言教育	978-7-5689-2440-5	\N	王立智 陈彦华 	\N	1-1	16开	42.00	412.0千字	重庆大学出版社	278	\N	\N	2020-08-03	/book/6e21c8af-c15f-46c1-9cec-b8a3759f96d292440.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	666
1714	桥隧维护	978-7-5689-2182-4	\N	田建德 	\N	1-1	16开	56.00	337.0千字	重庆大学出版社	223	\N	\N	2021-09-02	/book/2118eb98-1adb-4490-a345-afe88e0a047392182.jpg	本书共6个项目，项目1主要针对桥隧工的职业进行描述，项目2对桥隧工专业知识进行介绍，项目3、4、5主要针对初、中、高三级人员的理论知识及实操技能进行详述，项目6是经典故障案例分析。本书在内容方面力求全面、完整，注重实操技能培养。 本书的主要服务对象为轨道交通行业工作人员和轨道交通专业在校学生，同时也为热爱轨道交通事业的广大社会人员提供参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	323
1715	设计的精神：物品、环境与意义	978-7-5624-9831-5	\N	斯图亚特·沃克 著 李敏敏 译 	\N	1-1	16开	78.00	300.0千字	重庆大学出版社	244	\N	\N	2021-10-06	/book/a5b40409-bfe0-4634-b6f4-8189d78787f29831.jpg	本书是“绿色设计与可持续发展经典译丛”中的一本，《设计的精神》一书挑战了一系列我们习以为常的共同假设，包括可持续性、进步、增长和全球化等。作者以实践为基础，探讨了关于本土化、人类的意义以及功能对象等问题，证明了通过设计进行研究的想象力潜力，并产生了引人注目的、建设性的、本质上充满希望的未来方向——将大规模生产与个性、产品与地点、实用利益与环境责任相结合，从根本上重新思考我们的物质文化。 书中作者重点探讨了以下几个核心问题： ·对人类意义的理解如何影响设计，以及设计如何更好地结合个人意义的问题。 ·大规模生产需要如何与本土化生产以及提供服务相结合。 ·如何将短命的电子产品引入更可持续的设计范式。 ·在后消费主义世界中设计师角色的变化。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	191
1716	中国近现代插图史	978-7-5689-0578-7	\N	安宝江 刘克丹 	\N	1-1	16开	48.00	133.0千字	重庆大学出版社	122	\N	\N	2021-11-08	/book/0a6ef272-9b73-4b98-a939-11a53858207190578.jpg	《中国近现代插图史》是对20世纪前半叶插图艺术发展历程的回顾与分析，按照历史时段，大致分为晚清和民国两个时期。自清代中后期以来，欧美影响日渐加深，进入20世纪后，这种影响已在各个领域中渐次展开。在这个被动引进和主动吸收并举的过程中，插图艺术从表现形式到艺术观念、从题材内容到风格表现、从载体到阅读方式、从创作主体到接受对象，均已不同于以往。这是中国社会现代化的开端，也是中国艺术在现代社会中变迁的开端。所以，对插图艺术该时段内的考察是包含于艺术现代性探讨之中的。 本书首先对文艺类插图中的文字与图像的抽象与形象特征进行了分析，对近代印刷技术和中国古代插图分别进行了介绍。主体部分以时代为序、新文化运动为节点，在清末民初和新文化开始以后的民国时期这两个大时段内，将封面插图时期，以及与插图密切相关的漫画、连环画、版画分别设置章节进行了分析与讲解。由于鲁迅对中国现当代插图艺术有着重要影响，又单独以一个章节论述了鲁迅的贡献。 本书围绕对插图历程的回顾，除插图自身外，在对每个时期的插图呈现进行原因分析时从出版发行的外部条件、插图艺术家自身因素、外国插图艺术对中国的影响以及影响插图创作的相关社会因素等方面均进行了介绍。同时，对不同时代的典型艺术家或典型作品做了一定的个案分析。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	412
1717	常见螳螂野外识别手册	978-7-5689-2755-0	\N	吴超 	0	1-2	32开	39.00	193.0千字	重庆大学出版社	200	\N	\N	2021-10-30	/book/5cdb4e10-76e1-4013-a9de-01036daae3a392755.jpg	本书对我国有分布的相对常见且有代表性的77种螳螂的形态特征、生活习性及地理分布等信息予以简介，涵盖种数约占我国已知的螳螂物种数的一半，涉及全部科及多数属。书中每个物种均配有可供识别的生态照片，令读者能够更加直观地对常见螳螂进行识别；书后附有中国螳螂主要属的螵蛸图版及农林业上常遇到的物种的生殖器图版，以便于专业人士区分近似种。本书是广大昆虫专业人士不可多得的野外实习工具书，也非常适合昆虫爱好者、生态摄影爱好者、户外运动爱好者等人士用作参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	363
1718	客户关系管理	978-7-5689-2787-1	\N	胡立琴 赵鑫 罗阿玲 	\N	1-1	16开	45.00	323.0千字	重庆大学出版社	209	\N	\N	2021-08-10	/book/00200b55-79d9-4a32-a8ec-df8e501265e392787.jpg	本书以企业与客户之间的关系作为研究对象，灵活运用管理学、营销学、社会学的相关理论，借鉴国内外客户关系管理理论研究的最新成果，把理论知识与实际案例相结合，系统、全面地阐述了客户关系管理的理论。本书总共有3个部分，第一部分为客户关系管理理论；第二部分为客户关系管理的IDIC模型，这是本书的核心章节，包括识别客户、客户开发、区分客户、客户互动、客户定制5个模块；第三部分为客户关系管理的应用，主要包括大数据与客户关系管理、移动互联与客户关系管理、商业智能与客户关系管理。本书既适合从事客户关系管理的读者阅读，也适合作为高等学校的教材。书中选用的典型案例都与章节内容相匹配，深入浅出、通俗易懂，便于读者更好地领会客户关系管理的核心内涵。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	309
1719	屏蔽门、电扶梯设备维护	978-7-5689-2911-0	\N	尚志坚 	\N	1-1	16开	45.00	210.0千字	重庆大学出版社	125	\N	\N	2021-09-17	/book/ae3dbb13-58c9-4833-bee8-1207b722bca392911.jpg	本书是根据城市轨道交通电扶梯及屏蔽门设备的特点，参照国家及轨道行业相关职业标准的要求进行编写的。该书在内容方面力求全面、完整地涵盖了地铁自动扶梯、直梯、楼梯升降机设备及屏蔽门系统设备，涉及从初级工到高级工应掌握的各项知识和技能点。该书图文并茂，通俗易懂，并且对于重点内容均配有相应的视频讲解。 本书的主要服务对象是轨道交通行业工作人员和轨道交通专业在校学生，同时也为热爱轨道交通事业的广大社会人员提供参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	283
1821	迈向法治	9787308200974	\N	詹姆斯·E.弗莱明（James，E.，Fleming） 著，[美] 詹姆斯·E.弗莱明 编，窦海心 译，张文显 主编 	平装	1-1	16开	68.00	\N	浙江大学出版社	\N	\N	\N	2022-03-01	/book/7e6b5d72-0df0-43fd-b270-a47cdcdfe1cf1086322.jpg	法治一直被誉为“无可匹敌的人类善”，但人们对于法治要素的认定有着相当大的分歧。当人们大声疾呼要求维护或推行法治时，他们倡导的是关于尊重私有财产和提倡自由的法治实质性概念？是保障“法律内在道德性”的形式概念？还是强调应当拥有公正去庭并就法律问题展开辩论的程序概念？必要的紧急情况下（如抵御恐怖袭击）是否可以“超越法律”行使权力，来维持或恢复法治？ 在《迈向法治》—书中，来自各个学科的研究人员讨论了这些问题引发的诸多理论法学、政治学与道德的困境，并考察了美国和全世界的实践状况。这本跨学科著作及时出现并梳理了法治的概念，探讨了何时有理由（如果有的话）行使“超越法律”的行政权力以维持或恢复法治，揭示了军事干预后建立法治的前景和风险。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	394
157	合同法（下册）（新编21世纪法学系列教材）	978-7-300-29347-9	\N	王利明 	0	1-1	0	59.00	350.0千字	中国人民大学出版社	\N	293479	\N	2021-05-15	/book/eaf5c838-be11-4f87-9018-1b956df50fde1070416.png	本书对民法典合同编中的各类典型合同展开介绍，深入解析各类合同的法律规则、法律原理、疑难点，厘清原合同法、合同法司法解释与民法典的适用关系，便于学生理解和掌握各类合同的基本特点，也有助于司法实务人员正确理解和适用民法典。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	724
1720	土木工程制图(第2版)	978-7-5689-2264-7	\N	何培斌 	0	2-3	16开	59.00	707.0千字	重庆大学出版社	436	\N	\N	2021-11-01	/book/9045f9f8-0ebe-4ebc-b08b-1ee5a011309d92264.jpg	本书以高等学校土木工程专业指导委员会制定的《高等学校土木工程本科指导性专业规范》为依据，按照《房屋建筑制图统一标准》（GB/T 50001—2017）等最新国家标准，结合计算机应用技术的发展，总结近年来本课程教学改革的实践经验和教学经验编写而成。 本书内容覆盖课程要求的核心知识，满足培养方案和教学计划的要求，主要内容包括:制图基本知识和基本技能，投影的基本概念，点、直线、平面的投影，直线与平面、平面与平面的相对位置，投影变换，平面立体的投影，规则曲线、曲面及曲面立体，轴测投影，组合体，图样画法，透视投影，建筑施工图，结构施工图，建筑给水排水施工图，附属设施施工图，计算机绘制建筑施工图。与本教材配套出版的还有《土木工程制图习题集》。 本书可作为高等学校本科土建类各专业的教材，也可供高等职业学院、开放大学等其他类型学校师生参考使用，还可供有关土建工程技术人员学习使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	957
1721	InDesign	978-7-5689-2112-1	\N	张春燕 郑建楠 	\N	1-1	16开	68.00	330.0千字	重庆大学出版社	183	\N	\N	2021-11-04	/book/38baacdf-b1ef-4ebc-8aed-30dee9920df992112.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	845
1722	实验设计与数据处理	978-7-5689-2930-1	\N	刘方 翁庙成 	\N	1-1	16开	59.00	551.0千字	重庆大学出版社	338	\N	\N	2021-08-10	/book/913a6d50-b9de-42ec-989f-d70f0b3d43d292930.jpg	"本书是在《实验设计与数据处理》1988年版的基础上，总结多年的教学实践经验及研究生优质课程建设项目成果编写而成的。本书着重介绍实验设计与数据处理的基本概念和基础理论，在保持系统性和科学性的前提下，注重引入土木工程相关学科实例，介绍实验设计基本原理与方法；注重实验数据处理实际方法的应用，力求淡化数学理论、突出重点、循序渐进、深入浅出。 全书分为三大部分（共8章）,即数据处理基础、实验设计与统计应用、数据处理统计软件及分析，内容包括绪论、概率与数理统计基础、误差分析、析因实验与方差分析、正交试验设计、建立实验数学模型的方法、实验数据的回归与聚类分析、统计软件SPSS简介及其案例分析等。本书还列举了与土木工程建筑环境专业密切相关的案例和习题。 “实验设计与数据处理”是高等院校研究生、本科生重要的基础课之一。本书既可作为相关专业本科生和研究生的教材，也可作为相关学科的科研、教学和设计人员的参考用书。 "	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	778
1723	劳动实践指导手册（八年级上册）	978-7-5689-2969-1	\N	教育部西南基础教育课程研究中心 重庆市教育学会 	0	1-2	16开	18.00	43.0千字	重庆大学出版社	70	\N	\N	2021-09-19	/book/0910719c-cddb-49d6-a2a9-752b30d548bb92969.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	986
1724	跨文化商务英语交际(第2版)	978-7-5689-2889-2	\N	詹作琼 王济华 	\N	2-7	大16开	59.00	394.0千字	重庆大学出版社	162	\N	\N	2021-11-12	/book/b138df50-152e-49e4-a1e6-cba099851d4992889.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	941
1726	英语读写译教程（第二册）	978-7-5689-2731-4	\N	胡蝶 	0	1-2	大16开	65.00	547.0千字	重庆大学出版社	231	\N	\N	2021-08-10	/book/37fafc1a-6863-4847-a0d8-ee9421323d3c92731.jpg	本书为“新素养高职高专英语系列教材”中的读写译教程第二册。本系列教程针对高职发展的新需求和高职英语教学的实际情况，根据2019年国务院印发的《国家职业教育改革实施方案》进行编写，以“面向社会、针对岗位、强化能力、促进发展”为宗旨，立足高职学生未来的工作需求，对学生进行针对性的工作岗位技能培养，同时为他们未来工作岗位的提升做好文化素养和跨文化交际能力的储备，是具有鲜明高职特色的全新型教材，对推进高等职业教育全面深化改革具有重大意义。 本教材共八个单元，每个单元有四大板块，即读、写、译、练，由浅入深，由易到难，从音标到词汇，再到句子和篇章，编写体例实用、条理清晰、难易适当，符合高职学生学习基础和认知规律。书中力求融入思政元素，全面服务立德树人的根本任务。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	437
1727	英语视听说教程（第一册）	978-7-5689- 2718-5	\N	余荷花 	0	1-2	大16开	62.00	351.0千字	重庆大学出版社	148	\N	\N	2021-08-10	/book/4b8556f5-93c7-4de0-9dd1-cdf3f29070e61085656.jpg	本书为“新素养高职英语系列教程”中的视听说教程第一册。本系列教程针对高职发展的新需求和高职英语教学的实际情况，根据2019年国务院印发的《国家职业教育改革实施方案》而编写，以“面向社会、针对岗位、强化能力、促进发展”为宗旨，立足高职学生未来工作需求，对学生进行针对性的工作岗位技能培养，同时为学生未来工作岗位的提升做好文化素养和跨文化交际能力的储备，是具有鲜明高职特色的全新型教材，对推进高等职业教育全面深化改革具有重大意义。 视听说教程分为两册，本册的八个单元分别为初涉职场、公司架构、职务职位、工作场合、日常工作、产品说明、销售与营销和职场投诉。每个单元分为单元目标、听与读、听与说、听与思、电影欣赏、单元任务等板块，由浅入深、由易到难，从音标到词语，再到句子和篇章，形式多样且富有逻辑性，符合高职学生学习基础和认知规律。书稿力求融入思政元素，润物细无声，全面服务立德树人的根本任务。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	783
95	i-GAS听障儿童早期精准康复服务模式	9787565142277	\N	李永勤、傅传威主编 	0	1-1	0	68.00	338.0千字	南京师范大学出版社有限责任公司	303	\N	68	2019-05-01	/book/0666ec87-b50c-40b3-8cab-5c99cafbdbd79787565142277.jpg	本书以上海市聋儿康复中心20多年积累的听力语言康复服务工作经验为基础，聚焦0-3岁听障儿童早期康复服务，提炼总结出i-GAS听障儿童早期亲子康复服务模式，即以听障儿童及其家庭提供个性化分析及支持为基础，关注听障儿童全领域发展，并提供针对性听觉口语康复和言语语言康复。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	837
1763	南路革命名将唐才猷	978-7-306-07247-4	\N	高良坚，唐翠波主编 	平装	1-1	特16开	98.00	264.0千字	中山大学出版社	\N	\N	\N	2021-06-01	/book/579be2ff-7826-4800-9631-db9f7d0665d41085955.jpg	本书上编“唐才猷文选”重点介绍了唐才猷从1936年到1949年期间找党、参加青抗会、参加老马起义、袭击风朗机场、西进十万大山以及在越南的战斗经历，并收录了他的诗词，以及战争理论。中编“战友文汇”则是从唐才猷战友的角度，从革命期间的各次战役中客观展现了他的领导才能和战斗经验。下编“革命武装历史沿革”则是介绍革命武装历史沿革，重点介绍部队的具体人员情况。而附录则是后人对唐才猷的研究和回忆。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	195
1728	自体心理学：科胡特青年治疗研讨会文集	978-7-5689-2976-9	\N	米利亚姆·埃尔森 编 何元庆 全莉娟 译 	\N	1-1	16开	136.00	373.0千字	重庆大学出版社	451	\N	\N	2022-01-05	/book/05357d2b-7d4c-4561-928b-64282cee8f4992976.jpg	海因茨·科胡特的理论对我们关于自体发展的思考产生了巨大的影响，本书强调了这些理论的临床应用。本书聚焦于在大学设置下对青年的治疗，在前七章讨论自体心理学理论后，从第八章开始每章都以一个研讨会参与者的案例报告开篇，这些案例为科胡特关于临床问题的讨论提供了依据。 阅读科胡特对案例报告直接却一贯深思熟虑的反应，读者可以追溯自体心理学基本概念的产生。尤其是科胡特用了大量的临床例子来揭示：独特的自体客体功能对青少年向成年人过渡的作用。编者埃尔森对演讲和案例讨论的记录指出了科胡特对案例的回应与他后来的理论观点之间的关键联系，是特别有帮助的。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	662
1729	原始体验的边缘	978-7-5689-2987-5	\N	托马斯·H.奥格登 著 卢卫斌 译 	0	1-2	16开	76.00	160.0千字	重庆大学出版社	214	\N	\N	2022-01-05	/book/677a1359-2aa2-4cca-93a1-89871d797c3992987.jpg	托马斯?H.奥格登是一位真正的具有原创精神理论的精神分析大师，他在该书中进一步讨论了对著名客体关系理论家如克莱因、比昂、温尼科特思想的分析。他提出人类经验产生的三个模式，偏执-分裂模式、抑郁模式和自闭-毗连模式（Autistic-Contiguous Mode），在本书主要讨论第三种模式。他提出如果一个人在这三个模式中辩证运动，则产生各种体验，如果这种辩证运动失调，则产生各种临床综合征。全书丰富的案例论证了原始经验在各种心理疾病治疗中的重要作用，对于从事精神分析的心理治疗师具有重要的学习价值。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	950
1730	地基与基础工程	978-7-5689-3021-5	\N	王丽英 雷李梅 覃钢 	0	1-1	16开	49.00	494.0千字	重庆大学出版社	308	\N	\N	2022-01-10	/book/7d26770a-09fe-4d99-9461-1d520b1719b11085685.jpg	本书根据新形势下高职高专建筑工程技术等土建类专业教学改革的要求，主要依据现行的国家标准《建筑地基基础设计规范》(GB 50007—2011)、《岩土工程勘察规范》(GB 50021—2001)、《建筑抗震设计规范》(GB 50011—2010)、《建筑边坡工程技术规范》(GB 50330—2013)，以及行业标准《建筑地基处理技术规范》(JGJ 79—2012)、《建筑基坑支护技术规程》(JGJl20—2012)、《建筑桩基技术规范》(JGJ 94—2008)等进行编写。 全书共10个项目，包括土力学知识和基础工程施工两大部分。第一部分为土力学知识，主要介绍土的基本性质、土中应力、土的变形和沉降、土体抗剪、土压力和土坡稳定等内容；第二部分为基础工程施工，主要介绍岩土工程勘察、浅基础、桩基础、地基处理，基坑工程等内容。为了便于理解和掌握本书的重点和难点，方便学生自学，每个项目包括了项目导读、小结、习题等内容，习题设置与当前职业能力考试紧密结合。 本书既可作为高职高专建筑工程技术以及土建类其他相关专业的教材，还可作为工程技术人员和施工管理人员的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	676
1731	越南语阅读教程1	978-7-5689-3015-4	\N	程潇潇 向有福 	\N	1-1	16开	39.00	194.0千字	重庆大学出版社	144	\N	\N	\N	/book/b6394bdd-fd5a-482b-9b96-f0a35d395fbf93015.jpg	本书共包含16章，主题涉及服装、亲情、朋友、文字与语言、市场、气候、打电话、交通、过节、艺术、城市、时间、书信、读书，等等。每一章包含阅读训练和扩展阅读训练两部分，每一部分都由课文、单词与课后习题组成，课文遵循由易到难、循序渐进的原则，选材实用性强、适用性广，同时也融入了课程思政的理念。每一章的练习题题型包括选择题、填空题、翻译题，在此基础上设置了开放性问答题，旨在提高学生的批判性思维能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	241
1743	金石有声：刘铁峰篆刻近作选	978-7-5761-0271-0	\N	刘铁峰 著 	平装	1-1	16开	198.00	\N	燕山大学出版社	\N	\N	\N	2022-03-01	/book/7321a8b0-5070-43e7-a97e-1df79954ea3a1085764.jpg	由全国普通高校中华优秀传统文化传承基地——燕山大学篆刻艺术教育研究中心资助、燕山大学出版社策划辑印的《金石有声：刘铁峰篆刻近作选》一书即将出版问世。本书精选整理了在印坛辛勤耕耘数十载并取得斐然成就的篆刻艺术家刘铁峰近年来所刻的500多方篆刻作品、数百方新封泥和拓片作品。本期公众号特别推出燕山大学党委书记赵险峰为本书所作的序言，并配发书内图片若干，带读者诸君领略中国篆刻的魅力！	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	716
1744	涧于集	9787811428315	\N	石向骞 等 	0	1-1	16开	286.00	\N	燕山大学出版社	\N	\N	\N	2021-06-01	/book/ce2839a9-6dec-465c-94a7-395a8e3b92461085827.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	612
1732	商业基础知识（第2版）	978-7-5624-5336-9	\N	刘万军 	\N	2-3	16开	39.00	358.0千字	重庆大学出版社	215	\N	\N	\N	/book/53c628e5-b96e-41ab-b726-f1f00b096a825336.jpg	本书围绕认识商业的产生和发展；理解商业活动与商业运行过程；认识主要的商业业态和常用的交易方式；理解市场与商品价格；学会用电子商务购物；认识商业风险，把握商业机会；认识商业物流与配送；理解商业经济效益等方面的任务展开，力求通过各项基本任务的描写，让教师方便地在任务驱动下组织项目教学，让学生通过案例阅读加深商业理论知识的理解，在教师指导下独立完成各项实训任务，以达到更好地提高学生综合素质的目的。本书在每个任务后配有习题和实训项目。 本书可作为中职市场营销、电子商务专业、现代物流、会展、会计、金融、保险、商务文秘、物业管理等专业的教材，同时也可作为高职市场营销、现代物流、电子商务等专业的教材。 《商业基础知识》是中等职业教育市场营销专业的专业基础课程。目前，我国的商业仍处在一个快速发展的时期，新知识、新思想不断涌现，对商贸类人才的需求量与日俱增。商业企业是财经商贸类市场营销专业中职学生第一职业主要就业岗位之一，同时，其他岗位也对商业的基础知识充满着需求。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	484
1733	声乐教程（初级）	978-7-5689-2939-4	\N	张礼慧 唐力生 	\N	1-1	8开	58.00	273.0千字	重庆大学出版社	156	\N	\N	\N	/book/cca10fd0-c26e-4ea2-995b-be1671ec982892939.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	240
1771	五环下的遇见	978-7-5671-4443-9	\N	周玉甫 著 	平装	1-1	16开	58.00	\N	上海大学出版社	\N	\N	\N	2022-03-01	/book/885757d7-0517-4146-801a-4d367f6f77a61085985.jpg	《五环下的遇见》，既有奥运冠军、世界冠军等体坛明星的励志故事，也有体育少年经过奥林匹克熔炉的淬炼在新的赛道上重启人生的精彩篇章。书中还有体育园丁的故事，他们的故事让我们看到了在构建中国体育金字塔的过程中，这些无名英雄的奉献和他们的人生际遇。书中也收录了作者的回忆文章，展示了作者与体育运动的美好“遇见”。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	291
1772	羽翎鹮翩:神州野鸟掠影	9787576100112	\N	　 	平装	1-1	16开	360.00	\N	燕山大学出版社	\N	\N	\N	2010-10-01	/book/9a9f1a66-2d8b-461a-8b82-82a9abfe5a171085986.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	628
1734	ZnO基气敏材料的调控制备及其气体传感应用	978-7-5689-3010-9	\N	郭威威 陆伟丽 	0	1-1	16开	68.00	201.0千字	重庆大学出版社	163	\N	\N	2021-11-21	/book/2a8ad889-e1aa-42da-9d54-290132841a6593010.jpg	"氧化锌(ZnO)是一种重要的 N 型半导体金属氧化物,具有物理化学性质稳定、无毒无害、价格 低廉等优点,在气体传感器方面有广泛的用途。 ZnO 可用来检测很多具有氧化性或者还原性的有 机气体,但普通 ZnO 气敏材料存在灵敏度低、工作温度高、选择性差等缺点。 本书基于 ZnO 气敏 材料的最新研究进展,系统介绍了 ZnO 的基本性质与气体传感应用、ZnO 微纳米结构的调控合成 及气敏性能研究、ZnO 的元素掺杂改性及气敏性能增强机制、ZnO 异质复合材料的制备及气敏性 能研究。 本书每章都将制备的 ZnO 气敏材料制成气体传感器,然后对其灵敏度、响应恢复时间、 稳定性、选择性及抗湿性等进行研究,得到了一些有意义的结果,使读者能在阅读本书的基础上, 利用相关方法开展科学研究工作。"	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	335
1737	MySQL数据库	978-7-5689-3132-8	\N	曾鸿 胡德洪 陈伟华 	0	1-2	16开	49.00	240.0千字	重庆大学出版社	151	\N	\N	2022-01-18	/book/235c67b9-ed14-4d85-b49e-9176f2e6092d1085727.jpg	MySQL数据库是目前应用最广泛的关系型数据库之一。本书基于软件开发中数据库应用的工作过程构建模块，任务驱动、理实一体，适合线上线下混合式教学。本书由7个模块30个任务构成，从认识MySQL、安装MySQL、创建数据库、创建数据表、操作数据表、查询，到创建和使用存储过程、管理MySQL用户等，基于MySQL数据库应用和管理过程进行内容编排。本书提供丰富教学示例，同时示例之后提供大量课堂练习，供读者先模仿再举一反三。拓展阅读部分是课程思政元素之一，介绍了国产数据库的发展历程，提升读者关键技术自主可控意识，为国产数据库的广泛应用打下坚实基础。 本书可作为高职院校数据库技术课程教材，也可以作为软件开发人员和MySQL数据库管理人员的数据库应用工作手册。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	430
1738	机械制造基础(第2版)	978-7-5689-0109-3	\N	李玉平 	\N	2-2	16开	48.00	551.0千字	重庆大学出版社	363	\N	\N	2021-12-28	/book/c317e4cb-6d89-465e-ab76-0f8c6010575390109.jpg	全书共分9章，主要内容包括：工程材料、铸造、锻压、焊接、金属切削加工基础知识、机械零件表面加工、特种加工、先进制造技术及机械加工工艺规程等。考虑到后续课程安排，教材内容处理上有所区别。“工程材料”部分以剖析铁碳合金的金相组织为基础，以介绍工程材料的性质和合理选材为重点。“铸造”“锻压”“焊接”各占一定的篇幅，因为这方面知识是必不可少的，而且本课程前后均未安排与此有关的课程。“金属切削加工的基础知识”“机械零件表面加工”和“机械加工工艺规程”部分，则着重在“机加工实训”的基础上，把感性知识上升到理论高度，进而归纳成系统性基础知识，为后续课程打好基础。而“特种加工”和“先进制造技术”部分，则着眼于拓展知识面、提高人才培养的专业适应性。 本书适合作为高等工科院校机械类、近机械类各专业的《机械制造基础》课程的通用教材，还可供有关工程技术人员参考使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	351
1739	建筑工程计量与计价（第6版）	978-7-5689-3089-5	\N	李会静 唐小林 	0	6-24	16开	59.00	517.0千字	重庆大学出版社	322	\N	\N	2021-11-20	/book/db2cb808-0a8e-4495-8946-cad4937e4fec1085744.jpg	本书对接行业新技术、新工艺、新规范，对房屋建筑与装饰工程的计量与计价进行系统阐述，详细介绍了工程造价基础知识、建筑工程建筑面积计算规范、建筑工程工程量计算规则以及建筑工程施工图预算编制，同时结合实际工程BIM模型进行投标报价编制，内容扩展至施工预算、工程结算与竣工决算。 本书内容新颖、图文并茂、通俗易懂、实用性强，同时配套丰富的教学微课、FLASH动画、PPT、试卷库等数字教学资源，可作为高等职业教育工程造价、建设工程管理、建筑工程技术等专业的教材使用，也可作为从事工程造价管理、概预算或相关工作的人员培训和自学参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	520
1740	仓储与配送实务	978-7-5689-2768-0	\N	刘庭翠 沈捷 	0	1-1	16开	42.00	381.0千字	重庆大学出版社	249	\N	\N	2022-02-24	/book/91b70508-57a5-4be9-833d-72a00c057cf71085746.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	978
804	MATLAB教程（R2018a）	9787512428119	9787512428119	张志涌 	\N	1-1	16开	69.00	\N	北京航空航天大学出版社	\N	\N	\N	2019-03-01	/book/9d434ab7-9200-4332-91ea-c78e5cf88a9d9787512428119.jpg	的学习和实验、实习指导书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	705
1741	电压互感器运维技术及典型案例	978-7-5689-2627-0	\N	刘浩梁 	\N	1-1	16开	45.00	370.0千字	重庆大学出版社	238	\N	\N	2021-11-16	/book/ff3865ae-884a-4bf3-8a85-226b3d62a46592627.jpg	电压互感器作为将一次设备的高电压按比例转换成较低电压的设备，其安全稳定关系着电网的安全及供电的可靠性，正确诊断电压互感器的故障，并采取相关措施及时处理，对于事故防范具有重要意义。全书共8章，内容涵盖了电压互感器基础知识、制造工艺、试验技术、检修技术、安装及现场验收等，并结合实际工作，列举了丰富的故障分析处理案例，为电压互感器的维护、检修提供了重要的参考依据，具有很强的指导性和实用性。 本书可供从事电力系统变电运行、检修、安装、试验及管理等工程技术人员阅读，也可供制造厂商、电力用户及高等院校相关专业的师生参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	337
1749	库岸滑坡灾害稳定性评价及其工程实践	978-7-5625-5100-3	\N	贾建红 肖云华 向家菠 蒋楠 著 	平装	1-1	16开	36.00	\N	中国地质大学出版社	\N	\N	\N	2021-09-01	/book/00c5a1da-b03d-4fe5-9d43-da20bae827c81085860.png	三峡库区地形地貌复杂，沟谷深切，滑坡、崩塌、泥石流时有发生。三峡蓄水后，加剧了部分滑坡的活动性，由此造成的经济损失巨大，并造成不良的社会影响。为此本书在调查研究的基础上，综合分析库岸滑坡灾害稳定性评价及研究现状，针对典型库岸滑坡灾害工程实践，以三峡库区奉节县梨木咀滑坡、刘家染坊滑坡、罗家湾滑坡、孙家滑坡、永乐滑坡、麻柳坡滑坡（藕塘滑坡）为例，分析了库岸滑坡变形现状，研究了影响库岸滑坡的主要因素，阐述了库岸滑坡的成因机制，实现了库岸滑坡稳定性分析评价，预测了库岸滑坡发展变化趋势及其危害性，制定了预防和治理库岸滑坡的对策和措施。 书可为水利工程建设中库岸滑坡稳定性评价、预测及防治措施提供一定的借鉴与启示。可供从事地质灾害研究和水利工程建设、勘查、设计、施工单位的工作人员学习参考，也可供相关专业的学生学习使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	686
1750	乡村振兴战略：理论与实践	978-7-5625-5121-8	\N	罗小玉 张 波 主编 	平装	1-1	16开	39.00	224.0千字	中国地质大学出版社	\N	\N	\N	2021-09-01	/book/5081c6fc-3d32-4631-8c2a-c4626c0639cf1085869.png	本书根据《中共中央 国务院关于实施乡村振兴战略的意见》文件精神，通过乡村振兴战略概述，“十四五”规划与乡村振兴，聚焦《乡村振兴促进法》，全面推进乡村振兴战略的原因、要求及路径，农业现代化与乡村振兴，城乡融合发展与乡村振兴，激活乡村资源与乡村振兴，市场化发展与乡村振兴，绿色文明发展与乡村振兴，创新乡村治理与乡村振兴，脱贫攻坚成效提升与乡村振兴11个章节，详细介绍了乡村振兴战略规划和实施的内容，以期进一步推进新时代农业强、农村美、农民富的乡村振兴新进程。本书在全面总结国家“乡村振兴战略”发展实践和经验的基础上，深人探究乡村振兴规律，系统提出乡村振兴路径，认真推荐乡村振兴典型案例，提出了新时代乡村振兴的思路、方案和经验，为全国实施乡村振兴战略提供可借鉴和可推广的样本示范。本书内容新颖、语言通俗易懂，具有较强的可读性和实用性。本书适用于中等职业学校乡村振兴班学生使用，也可作为乡村振兴干部的培训教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	382
1751	数字战略	9787308221603	\N	魏江、杨洋、邬爱其、陈亮等 著 	平装	1-1	16开	79.00	\N	浙江大学出版社	\N	\N	\N	2022-03-01	/book/d42f6638-c742-4430-8383-32303384a9321085876.jpg	数字技术的快速发展正在重塑宏观环境、行业环境，数字生态系统之间的竞争成为数字经济时代企业战略的核心焦点。数字战略是否重构了战略管理的核心逻辑？数字战略内容体系如何？数字战略如何实现？围绕这三个问题，本书试图构建数字战略的核心框架，搭建数字战略的研究内容体系，推动中国数字战略研究进一步发展。本书具体包括四大模块内容：数字战略逻辑；规模经济、范围经济与速度经济；数字生态竞争战略；数字战略的实现。 本书概括凝练了符合中国情境的数字战略理论，为管理者制定数字战略提供了实践指南，为现代企业应对时代治理需求、提升竞争优势、推进生态发展提供了管理方案。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	442
1752	奈特简明人体解剖学图谱（第5版）	9787565924941	\N	原著 John T.Hansen 主译 张卫光 	平装	1-1	16开	85.00	\N	北京大学医学出版社	\N	\N	\N	2022-01-01	/book/33953e4c-7f13-42dc-9e23-b51d63ecf5501085883.jpg	这是一本绘图精美的解剖学图谱。书中的图片来源于奈特博士绘制的的人体解剖学图谱。奈特博士是杰出的医学家和艺术家。他绘制的人体解剖学图谱已被翻译成16种语言文字，成为全世界医学生的解剖学图谱。在本图谱中，奈特博士团队采用独特的视角，把人体各部位的结构栩栩如生地展现在我们面前，既有油画的层次感，还有鲜明的主题，可谓设计新颖、构思奇妙、寓意深刻，每一张图都是人体结构与艺术的完美结合。这是一本内容丰富的解剖学图谱。书中内容涉及人体的头部、颈部、背部、脊柱、胸部、腹部、盆部、会阴、上肢和下肢等诸多区域，以骨关节、肌、神经、心血管及内脏为主线，显示了骨骼肌系统、神经系统、心血管系统、消化系统、呼吸系统和生殖系统等人体各功能系统中各个器官的形态、结构、位置和毗邻等，还以局部或临床视角呈现了器官间重要的神经、血管、淋巴管或筋膜结构等。这是一本个性化的解剖学图谱。书中每张图片均配有相应解剖结构的简要文字描述，如肌的起点、止点、作用、神经支配、注释等，还包括该解剖结构的临床拓展内容，突出了解剖学图谱的实用性。本书译自NETTER’S ANATOMY FLASH CARDS（5E），并根据中文阅读习惯重新进行了编排，它有效地补充了解剖学教科书在学习资源上的不足，适合临床、口腔、基础、护理、预防等专业的医学生、医务工作者及有兴趣深入理解人体知识的读者使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	747
1753	主体结构工程施工（第2版）	978-7-5625-5067-9	\N	穆雪 王磊 主编 	平装	2-3	16开	48.00	464.0千字	中国地质大学出版社	\N	\N	\N	2021-10-01	/book/254c5475-9bf0-4057-8e2a-a16f3450e0e11085884.png	本教材是中等职业教育建筑工程施工专业的一门专业核心课程，主要研究建筑工程主体结构的构造，各主要工种的施工工艺、施工技术和方法，质量标准及安全技术措施等。本教材配套有多媒体课件、虚拟仿真软件、电子试题库等数字化教学资源，创建了一个理论与实践相融通、线上与线下教学相结合的立体化数字平台。教师和学生可以通过网站登录平台或通过手机扫描教材中知识点的AR码实现个性化自修和交互式教学。本教材在第1版的基础上依据现行新标准、新规范和新技术进行修订，同时根据广大读者的要求和建议也对第1版中的知识点进行了调整，使本书更适合建筑施工技术以及相关专业的教学使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	872
1762	就业·创业指导与实践	978-7-5689-2619-5	\N	王海明 主编 	平装	1-2	16开	52.00	228.0千字	重庆大学出版社	221	\N	\N	2022-01-10	/book/05d8fac3-0982-476f-bffc-1b27af94c0511085932.jpg	《就业·创业指导与实践》是一本具有针对性、时效性、实用性的大学生就业创业指导教材。 书中结合高校大学生的就业创业环境和形势，分上下两篇具体讲解大学生就业创业的相关知识和技能。上篇（大学生就业指导与实践）介绍当前大学生就业的形势与政策、制订职业规划的方法、就业流程、求职技巧和就业相关法律法规等；下篇（大学生创业指导与实践）介绍大学生创业相关政策、大学生创新创业训练计划项目、“互联网+”大学生创新创业大赛、大学生创业方法与技能等。本书整合了国内外关于大学生就业创业的部分理论，讲解通俗易懂；注重理论联系实际，在课程中引入案例展开论述，与社会实际结合紧密。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	634
1754	建筑工程测量	978-7-5625-5168-3	\N	刘强 主编 	平装	1-1	16开	36.00	346.0千字	中国地质大学出版社	\N	\N	\N	2021-12-01	/book/787cf42d-158c-4260-8f45-b19a3d1c45081085891.png	“建筑工程测量”是建筑工程技术专业必须设置的一门专业核心课程，该课程是针对高等职业院校建筑工程技术专业及相关专业方向的人才，如建筑工程施工员、建筑测量员、建筑工程监理员、建筑钢结构施工员、建筑设备施工员等岗位需求而设置的。建筑工程测量是该专业人才必须具备的一项专业技术基础技能，是其就业的主要方向之一。本课程通过学习以全站仪、北斗导航系统为代表的测量新技术、新设备的发展历程，培养学生正确认知、内化习近平新时代中国特色社会主义思想和社会主义核心价值观，培养学生的家国情怀；以训练学生熟练使用建筑测量仪器为前提，进而借助测量仪器进行建筑工程相关的测绘、放线等工作，培养学生吃苦耐劳、团结协作、精益求精、客观科学的职业精神。 本教材是适应高职高专人才培养目标及专业教学改革的需要，依据最新的与建筑工程测量相关的标准编写的。本教材共20个项目，每个项目由项目要求、项目知识、项目预案、项目实施、项目作业组成，部分项目还设置知识拓展作为选修内容。 本教材注重理论与实践相结合，实践性较强，可作为高等职业院校土建类相关专业的教材，也可作为建筑工程施工及技术管理人员的参考书，	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	244
1755	建筑工程信息与资料管理（附工作任务书）（第3版）	978-7-5625-5122-5	\N	张淑敏 何国林 主编 	平装	3-6	16开	48.00	480.0千字	中国地质大学出版社	\N	\N	\N	2021-10-01	/book/afb20826-5da4-472a-8b0c-ddf772af0a431085893.png	本书以国家职业标准为依据，以综合职业能力培养为目标，根据专业实践需求，设置教材知识点；注重教学内容的综合性、实用性和可操作性；注重教学内容的时效性及先进性，结合实际及时引入行业新知识、新规范，确保教学内容与行业需求接轨。全书以一个比较有代表性的15层的框架剪力墙的商务办公楼—某市南王文化广场工程为项目任务，以一个建筑工程从开工筹建到竣工验收的工作程序所需的资料为主要依据设计学习过程，选用了建筑工程施工过程中资料管理的24个“典型性”实际任务为教学任务，让学生熟练掌握建筑工程资料填写、收集、整理、报验、组卷、归档的流程和要求，以及资料软件的熟练使用，使学生毕业之初或实习期间就能胜任监理单位或施工单位，甚至是建设单位的资料员的工作。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	134
1756	车加工技能实训	978-7-5625-5170-6	\N	甘成君 黄华 欧玲主编 	平装	1-1	16开	25.00	230.0千字	中国地质大学出版社	\N	\N	\N	2021-12-01	/book/09b4dd20-6320-4aef-9b06-565576a849f01085895.png	本教材在“以需求为引领，以就业为导向”的工学结合职业教育办学理念指导下，以普车加工基本技能任务为引领，以国家职业技能标准为依据，结合机械专业学生学习特点以及机械类专业一体化课程教学需要编写的工学一体化教材。本书分为3个部分，分别为车工基本技能训练、车加工单项技能训练和车加工综合技能训练。内容编写选取企业典型加工案例，从简单到复杂层层递进，既便于老师教也便于学生学。本书按照工学一体化的教学理念，突出实训，教师在使用过程中可按照教材内容布置实训任务，学生通过练习完成任务，其技能熟练程度可达到教学大纲要求的水平。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	110
1757	李龙文集（第四卷）	978-7-307-21681-5	\N	李龙 著 	平装	1-1	16开	148.00	\N	武汉大学出版社	\N	\N	\N	2022-02-01	/book/e7524699-e942-4d75-a1c5-256cdffafce61085899.jpg	本书收集了李龙先生及其弟子近几年以来在一些核心或者重要期刊和报纸上发表的论文，共计31篇。这些文章反映了李老先生近年来关注的热点、重点问题以及由此形成的相关学术思想，是李龙先生深耕科研的重要成果。本书收集的31篇文章的主题主要集中于法理学、法哲学、对古代法治思想的探析、马克思主义法学的中国化问题、中国特色社会主义人权及其发展、对依法治国的探索、构建法治体系、全面深化改革与全面依法治国的关系、中国法学教育的回顾与发展等方面。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	250
1758	“爱种子”模式下小学语文教学范式的构建与实践	978-7-306-07175-0	\N	罗爱珍主编 	平装	1-1	特16开	50.00	330.0千字	中山大学出版社	254	\N	\N	2021-08-01	/book/e4c748f6-cf55-4f59-a25a-7b3cc9a2858d1085900.jpg	“爱种子”课改实验是广东省教育厅的立项项目。“爱种子”教学模式是由华南师范大学专家团队在原广东省教育厅基础教育处（现为基础教育与信息化处）指导下基于虚拟泛在学习和虚拟泛在教学新形态创建的“互联网+教学”的新模式。借助技术赋能，让广大教师在日常教学中规模化、常态化共享优质教学资源，让教师实现“点点用”“改改用”和“创创用”，提升我省基础教育教学质量，破解教育二元结构的困局，促进教育均衡发展。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	464
1759	国学经典每周一读	978-7-5625-5179-9	\N	陈龙 主编 	平装	1-1	16开	39.00	237.0千字	中国地质大学出版社	\N	\N	\N	2021-12-01	/book/83970d63-2ac5-42b2-9712-489e3b8643c01085906.png	本教材旨在加强中华优秀传统文化教育，培育和践行社会主义核心价值观，落实立德树人根本任务，提升学生的核心素养。本教材依据蒙学、经、史、子的分类，精选了《增广贤文》《论语》《史记》《老子》等国学经典中的名言名句编写而成。本教材先展示原文中的经典句子，再对这些句子进行翻译，还对部分句子进行了赏析。本教材内容丰富多彩，引导学生用零敲碎打的方法，不断积累，笃初慎终，持之以恒，使学习国学经典成为一件有趣的事。本教材主要适合职业院校作为国学经典课程教学用书，也可作为社会从业人员的国学经典素养课程培训教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	158
1761	特色专业建设——职业教育内涵发展之路	978-7-5693-2286-6	\N	姜建华 	平装	1-1	16开	87.00	\N	西安交通大学出版社	\N	\N	\N	2021-11-01	/book/e78df3ee-6e1c-493d-a5e2-9873fc224c831085927.jpg	　　本书从理论和实践两个层面提出职业院校特色专业建设的思路和方向，并将理论和实践相结合，讨论了构建职业院校特色专业建设的实现路径。以职业院校特色专业建设是职业教育发展的内涵为起点，从校企合作、教学团队、办学理念、错位差异、对接产业、课程建设、创新创业、校园文化、督导评估、实训基地、教学管理等11个方面对职业院校特色专业建设进行了研究。 　　本书适合职业院校教师使用，也可作为本科院校职业教育师范类学生的教学用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	171
1764	林香界——关注声音色彩与力度的乐队协奏曲	9787569601275	\N	唐建平 编 	平装	1-1	8开	106.00	\N	中央音乐学院出版社	\N	\N	\N	2021-03-01	/book/4d7cc221-684b-437f-939b-cc04f40422ab1085956.jpg	　　如果说交响曲、协奏曲等音乐作品的构成，充分体现了人类思维的理性力量，中国古代音乐，如古琴、琵琶音乐等，则让人感IJ更具有音乐情感的直观性。作品的音乐有感而发，触景生情，借题发挥，直抒胸臆。这部作品的音乐构成受到了这样的双重影响。具体的创作灵感来自一次北京西部山区的休闲之旅。进入峰峦叠翠的山林，雄浑苍劲的古木扑面，漫天枝叶随风摇曳，夹杂着瀑布般持续倾泻的虫鸣鸟语。慢慢进入山高林深处，几声悠长的清磬摇空而来，缕缕熏香缭绕处是中国历史上大的佛教传戒圣地戒台寺，寺院中一处门匾上雕刻着“莲界香林”。因为偏爱就选取了其中三个字“林香界”作为作品标题，既有一定的随意性，也表达了我在音乐创作观念上的一个侧面。在音乐意象有感而生的过程中，找到音乐材料的组成方法，以其表达直观感受。 　　在具体音乐方面，作品以协奏曲的概念在声音色彩与力度层面铺陈乐思，虽然与传统协奏曲体裁的构成相去甚远，但是却因此有了更为独立的艺术特点，更多关注声音的变化。在音乐语言、具体的音乐材料上，如乐曲开始的两个小节，连同构成作品主体的大量音乐材料，以及交响乐队的音响层次、音响的声音个性、音乐织体的组合形态等，都将乐队的声音作为首要的关注对象。和我的其他作品不同，这部作品的音乐具有更多的散文和音画、诗意性特点。也许以“关注声音色彩与力度的乐队协奏曲”来界定它更为恰当。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	798
1765	麻醉与围手术期现代监测技术	9787565925429	\N	原著主编 Andrew B. Leibowitz；Suzan Uysal；主译 薄禄龙 卞金俊 主审 邓小明 	平装	1-1	16开	80.00	\N	北京大学医学出版社	\N	\N	\N	2022-01-01	/book/b813b9c7-e70b-440d-a494-35ad2e7d14e31085959.jpg	提供了麻醉与围手术期各类监测手段的实践资料，集纳最新的循证医学证据，系统讲解神经功能监测、呼吸监测、心脏超声及超声技术的应用等内容。 探讨了术后病房等医疗环境中的呼吸监测。 详述了监测相关的数字干扰和警报疲劳带来的影响。 深入探讨了未来的监测技术，如可穿戴式设备等，为有志于各类新式监测手段或设备研发的人员带来有益思考。 本书专注于临床实践，有助于提升我国麻醉学等临床从业人员对现代监测技术的掌握与应用，是一线麻醉科医师的必备参考读物。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	489
1766	动态图形设计	978-7-306-07268-9	\N	王贤波,李潇 	平装	1-1	特16开	70.00	300.0千字	中山大学出版社	268	\N	\N	2021-11-01	/book/5423be57-724c-4981-aafd-b5dfe340bbe71085967.jpg	本书分为动态图形设计概述；信息、情节与形式；技术与工具；光与色；图形、文字与声音；空间与时间；运动；特效与合成八个章节，注重理论与实践相结合，赏析与创作相结合，艺术与技术相结合。通过本书的学习，学生能够将传统的平面设计语言与影视艺术、动画技术相结合，从而形成复合设计能力，以适应数字媒体与新媒体中的动态设计需求。 本书注重理论与实践相结合、赏析与创作相结合、艺术与技术相结合，选用了大量业界经典项目案例与本人在动态图形设计教学过程中积累的学生习作案例，并安排相当篇幅完整展示多个动态图形创意设计作品从构思到制作的创作全过程。全书内容编排由易到难、循序渐进，从整体到局部的练习安排能让学生切实提高对动态图形设计从整体把控到细节锻造的能力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	648
1767	再增订本中国禅思想史：从6世纪到10世纪	978-7-301-32723-4	\N	葛兆光 著 党宝海、马晓林、周思成 译 	精装	1-1	16开	128.00	\N	北京大学出版社	552	\N	\N	2022-01-01	/book/3ea8dfac-5338-4fd0-9dc6-c29975f7f5f01085969.jpg	本书以历史学与文献学的方法，叙述6—10世纪中国禅思想史的脉络与演变。作者综合禅门史料、石刻文献、传世文集和敦煌文书，从历史、思想、文化意义及影响三个维度，考证、叙述禅史最关键的四个世纪中，禅宗及其思想的历史变化过程。在20世纪以来禅宗史研究的基础上，不仅修正了此前禅史研究的若干结论，而且对禅思想的内涵及其意义，提出若干与前人不同的新看法。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	942
1822	古算广义	9787308209748	\N	刘操南 著 	平装	1-1	16开	98.00	\N	浙江大学出版社	\N	\N	\N	2022-01-01	/book/f7d4f62c-e180-4232-a137-3b43bcd3d2861086325.jpg	《古算广义/刘操南全集》系刘操南文集之一种，是刘操南先生在我国古代数学与数学史方面研究成果的结集。全书涉及我国古代数学中的四边形之研究、古代数学难题的现代揭发、《缉古算经》的笺释、《九章算术》《海岛算经》的注译等内容，对我国古代数学及相关算籍作了较为细致的研究，是我国古代数学研究的基础性著作，有助于今人了解我国古代数学取得的成果和成就。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	954
93	课程与教学评论·第8辑	9787565142079	\N	主编 杨启亮 李如密 	0	1-1	0	35.00	256.0千字	南京师范大学出版社有限责任公司	161	\N	70	2019-05-01	/book/763718fe-98cd-4c3d-902c-b221e0e022f79787565142079.jpg	该文集的作者是课程与教学各研究领域的专家。作者针对该领域最新的研究前沿问题和热点问题，从课程与教学的不同角度展开评论，重点对课程的价值、课程改革、课程与课程标准、课程与教学的整合、课程与教学方法、课程与教学评估、不同学科的教育教学、教师专业成长与发展等进行了深入的研究，阐述了课程与教学研究的最新成果。入选文章对诸多教育教学问题均有独到的见解和主张，具有一定的使用价值，是从事教育研究者的参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	932
1768	国家金融科技创新	978-7-306-07326-6	\N	韦立坚编著 	平装	1-1	特16开	76.00	397.0千字	中山大学出版社	388	\N	\N	2021-10-01	/book/5c7b768b-3ce8-4ea9-9960-c66a6eb9ef461085971.jpg	本书是中山大学国际金融学院组织出版的“国家金融学”系列教材中的一本，全书共六编二十四章，分别从金融科技、驱动金融科技的技术基础、金融科技产品与服务创新、监管科技、数字货币、金融科技对国际金融体系的影响等六个方面对现代国家金融科技进行深入的分析，形成相对完整的金融科技分析框架，有助于读者透过金融科技创新的表象看到金融发展的内部规律。本书在系统介绍金融科技专业知识的同时，也强调其实际应用，选取了大量应用创新的研究案例进行分析，深入浅出地阐释金融科技相关概念，有利于培养读者的融通应用技能，以及分析问题和解决问题的能力。本书语言流畅、结构清晰，逻辑缜密，具有较强的实用价值，既可以作为培养高端复合型金融科技管理人才的教材，也能作为金融科技从业人士的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	697
1769	法治化营商环境建设与民商法实践	978-7-306-07336-5	\N	周林彬,刘云生,王睿主编 	平装	1-1	特16开	76.00	425.0千字	中山大学出版社	328	\N	\N	2021-11-01	/book/cc25735b-3cbf-4324-a76f-947e08f251641085978.jpg	本书收录了广东省法学会民商法学研究会2019年学术年会、2020年学术年会的精选论文30余篇。主要内容包括《中华人民共和国民法典》的编纂与适用、法治化营商环境的建设与优化，公司法、金融法、知识产权法等具体部门法领域的理论争议与实践困境，粤港澳大湾区法治发展与协同的宏观视野研究，以及民商法具体规则设计和解释的微观视野研究。本书体现了民商法学理论研究者与实务工作者对民商法学学术和实务疑难问题的思辨、对新兴问题的关注，相关研究成果对民商法的立法和司法适用也大有裨益。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	815
1770	葫芦丝、巴乌、箫演奏基础教程	978-7-306-07284-9	\N	陈柏安,金婷婷,胡妍璐 主编 	平装	1-1	16开	35.00	201.0千字	中山大学出版社	160	\N	\N	2021-09-01	/book/739dd9a9-4a17-4ca6-b914-ba37852537731085983.jpg	本教程包含四大部分。一、乐器认知。主要介绍乐器的历史知识、种类划分、基本特征和历史沿革。二、演奏技法。主要介绍演奏指法分类、演奏姿势、演奏口形、气息等方面的知识，着重阐述气、指、舌的基本要领。三、练习曲。选取的曲目具有实用性与进阶性，其中也有较难演奏、具有高级练习曲特征的练习曲。四、乐曲。选取葫芦丝、巴乌、箫3种门类乐器中一些朗朗上口、风格鲜明、具有时代意义的乐曲。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	273
1774	建筑力学与结构（第2版）	978-7-5625-5120-1	\N	谢晖 王敏娜 主编 	平装	2-3	16开	40.00	365.0千字	中国地质大学出版社	\N	\N	\N	2021-11-01	/book/f5bd4e87-7a16-45bb-8625-7da153ad7db11086005.png	本教材综合性强，知识面广，具体内容包括建筑力学基础知识、混凝土结构平法施工图、钢筋混凝土结构基础、砌体结构、高层结构体系、钢结构。教材采用“项目导入，任务驱动”体例编写，通过项目导读、任务要求、任务分析、思政元素、知识导航、复习巩固6个模块来设置一个项目的全部内容，培养学生理论与实践的综合应用能力和分析问题、解决问题的能力。教材中加入课程思政元素，以立德树人为教育目标，让学生在学习专业知识的同时能够了解中国的独特历史、文化、国情，帮助学生坚定理想信念和树立正确的价值取向。本教材主要适用于建筑施工技术及相关专业的教学，也可作为相关专业技术人员的参考用书。 针对“建筑力学与结构”的课程特点，为了让学生更加直观地理解建筑力学与结构的基本概念和知识点，将教材内容与互联网技术相结合，配套视频、动画和VR三维模型等数字化资源，在教材中以二维码形式呈现，学生可通过微信小程序或下载APP扫描二维码，实现移动端自主实时学习。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	588
1775	垃圾分类读本（小学版）	9787567230187	\N	苏州市环境卫生管理处 编 	平装	1-1	16开	20.00	\N	苏州大学出版社	46	\N	\N	2019-11-01	/book/5cec74dd-0dd2-4bcc-b8be-421ff566cd2c1086010.png	《垃圾分类读本（小学版）》编写初衷是通过对我国生活垃圾污染现状的陈述说明生活垃圾给国人带来的环境困扰，进而阐述生活垃圾分类的意义，并借鉴国外生活垃圾分类的成功经验，对我国的生活垃圾分类作知识性指导。《垃圾分类读本（小学版）》介绍了生活垃圾减量处置的一些小窍门，同时希望《垃圾分类读本（小学版）》能够帮助到有志于参与生活垃圾分类行动的朋友们。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	901
1831	厦大建筑元素	9787561581186	\N	张建霖 沈英滢 	平装	1-1	大32开	50.00	\N	厦门大学出版社	\N	\N	\N	2022-04-01	/book/d3e46eeb-23c7-47be-adb7-970179c750501086399.jpg	厦门大学的校园规划和建筑布局精心安排，建筑体量和立面外形、局部空间和装饰细部进益求精，形成了一套独具风格的精品建筑群，即后人称之为“中西合璧”、“穿西装、带斗笠”的嘉庚建筑，在闽南地域乃至全国高校独树一帜。本书是一本文创手账，由校园建筑资深研究人员选编最能代表校园建筑特色元素的设计图、示意图、老照片等图片，辅以解说文字，总体进行精心编排，使其既具有观赏和学习的阅读价值，又具有书写和绘画的实用功能。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	397
1313	新媒体评论教程	978-7-309-15053-7	\N	张涛甫 著 	平装	1-1	16开	45.00	215.0千字	复旦大学出版社	217	\N	\N	2020-08-01	/book/89dd7baa-e9e5-4d01-a8bf-1470d03cd9a71081931.jpg	拜互联网所赐，我们处在盛产言论的时代，却不是优质言论的时代。新媒体让人人有了言说的“话筒”，可惜并不是人人都善于言说。如何既能把握新的语境与语态，又能保持专业高超的品质？张涛甫教授的这本教程，有明确且翔实的解答。 好评论是练出来的。过去十年，张涛甫教授的评论阵地几乎覆盖了中国当下的一流媒体。他丰富的评论经验用之于课堂，也催生了骄人的教学成果：一届学生中有近十位同学成为主流媒体的特约评论员。 本书就是课堂教学的精华浓缩，新媒体评论写作的十个关键主题，在大量的作品和案例中得到生动而细致的阐释。无论你是新手或老手、学生或评论人，都应该读一读它。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	625
1314	经络健康日历2022	9787313259912	\N	上海中医药大学附属龙华医院 组编 陈跃来 等 编著 	平装	1-1	大32开	98.00	\N	上海交通大学出版社	\N	\N	\N	2021-12-01	/book/585f0da6-7b28-442a-b5ff-baa29806c3c01081939.jpg	《经络健康日历2022》由上海中医药大学附属龙华医院组编，全书以日历的形式，对经络健康知识进行了讲解，尤其是把经络巡行、穴位按摩保健等知识与节气、节日、时辰等进行了有机关联。本书48开本，精装彩色印刷，配以精美的插图和丰富的日历等知识内容，可使读者在使用日历的同时，轻松获得有关经络健康的知识。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	599
1725	服装缝制工艺基础	978-7-5689-1965-4	\N	王琳 解冬梅 	\N	1-1	16开	55.00	248.0千字	重庆大学出版社	166	\N	\N	2021-11-05	/book/f8882ff2-6f2a-41df-a678-b13895062a5591965.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	495
89	教师与文本——重思教师专业性	9787565136498	\N	作者 （美）迈克尔·W.阿普尔 译者 扬跃 	0	1-1	0	56.00	238.0千字	南京师范大学出版社有限责任公司	254	\N	34	2019-01-01	/book/f5041b71-29b6-4b8a-a995-28b698228bc09787565136498.jpg	该书是迈克尔·阿普尔教授早期“教育三部曲”之一，在关注“阶级”“种族”与教育关系的基础上，进一步聚焦于“性别与教育的关系”在教学与课程控制中的表现。以及国家议程在强化这一过程中的政治、经济力量。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	891
116	笛子演奏与教学（第3版）	9787565146251	\N	编著 赵宴会 	0	3-1	0	56.00	578.0千字	南京师范大学出版社有限责任公司	250	\N	34	2020-09-01	/book/cd6b4351-77d0-4986-882e-8292e8481e879787565146251.jpg	本教材在坚持循序渐进原则的基础上，将演奏 方法与技巧、乐理常识和乐曲有机结合，并有意识 地将曲目内容分初级篇、中级篇、 篇三个部分 。由于本书近十年来销量四万余册，但曲目老旧， 定价过低，本次再版保持原有知识体系不变， 新 初级曲目14首，中级曲目24首， 曲目8首，并配 备音频资源（演奏示范和伴奏）以供读者使用。本 书之所以深受业余爱好者和专业笛子演奏者钟爱的 原因在于其撰写模式上将理论知识讲解与吹奏实践 紧密结合、同步进行，并按由易到难、由浅入深、 逐级推进的原则。以音符的逐渐递增为主线层层展 开，即首先从发音 容易的筒音作“§”指法中的 “#4”音开始切入练习，之后是“3、2、1、4、5 ”等音按难易程度以滚雪球方式渐次被引入。同时 有计划、有步骤地将理论知识特别是演奏技巧方面 的知识融入到相关曲目学习之中，使学生学而即用 、用而不忘，真正达到理论与实践相结合的理想效 果。此种做法与风靡 的《约翰·汤普森钢琴教 程》颇相似。值得一提的是，理论知识方面不仅仅 局限于笛子及笛子曲本身，还将有选择地就某一作 品进行音乐与文化背景两方面的分析和介绍，以此 激发学生学习兴趣、拓宽其知识面，促其综合素质 的提高。另一个显著特点就是精选了人们所喜闻乐 见的中外名歌、名曲若干首，根据竹笛的演奏技法 和表现特点。对其注上指法和演奏技法符号及简要 练习说明（其中部分由他人创编的曲目均在书中注 明）。名歌包括 外的民歌、流行歌曲、儿童歌 曲、艺术歌曲及近年来新生的网络歌曲，名曲则涉 及中外诸多器乐独奏曲、合奏曲、协奏曲、交响曲 及戏剧、曲艺音乐。作品所涉及的曲作者除了作曲家之外，还涵盖了贝多芬、莫扎特、舒伯 特、柴可夫斯基、比才等 音乐大师。此外， 为了保证教材的专业性与全面性，将一些极具代表 性的常用专业笛曲有机地安排穿插于整个教材之中 ，努力达到内容新、全、专的目标。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	822
346	建筑施工企业专职安全生产管理人员安全生产管理知识培训教材（C1、C2类）	978-7-5689-2764-2	\N	重庆市建设工程安全管理协会 	0	1-2	16开	79.00	498.0千字	重庆大学出版社	334	\N	\N	2021-07-25	/book/64158b00-31e7-440d-9cfe-9ff850520d471073389.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	157
375	习近平新时代中国特色社会主义思想学生读本：高中	9787010235318	\N	本书编写组 	平装	1-1	16开	28.00	\N	人民教育出版社	\N	\N	\N	2021-09-01	/book/0eb6f5be-62d0-417f-9e16-308d89f7a6f21073800.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	814
530	走进培智教育现场1	9787568929486	\N	李宝珍 	平装	1-1	16开	48.00	\N	重庆大学出版社	\N	\N	\N	2021-10-01	/book/89426155-abe9-400f-953c-2b6a4d8d20831074966.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	460
472	寻找油气的物探理论与方法	9787567007536	\N	李庆忠 著 	平装	1-1	大16开	200.00	\N	中国海洋大学出版社有限公司	\N	\N	\N	2015-12-01	/book/bc1f32e2-f325-4235-a0be-8fef778dfb681074439.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	654
515	现代大学英语（第二版）精读	9787521317909	\N	杨立民 	平装	1-1	16开	59.90	\N	外语教学与研究出版社	\N	\N	\N	2020-06-01	/book/2edcb2fb-1221-43d2-baec-b4539c0767181074767.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	225
520	义务教育教科书	9787561795705	\N	本书编写组 	平装	1-1	16开	9.14	\N	华东师范大学出版社	\N	\N	\N	2012-07-01	/book/82c45199-58c6-4ef5-9bbf-af2508a5574a1074816.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	227
534	毛泽东思想和中国特色社会主义理论体系概论（2018年版）	9787040494815	\N	本书编写组 著 	平装	1-1	16开	25.00	\N	高等教育出版社	\N	\N	\N	2018-07-01	/book/d4048308-6ee1-4898-add7-e21df70fc35b1075019.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	155
754	方志学史（修订版）	9787566614117	9787566614117	吕志毅 	\N	1-1	16开	58.00	\N	河北大学出版社	\N	\N	\N	2019-02-13	/book/daf06b20-648a-4c98-b564-83d5714ece369787566614117.jpg	本书是研究中国地方志及其理论的产生、发展和演变规律的一门历史学科。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	161
911	给孩子的简明中国史	9787568169059	9787568169059	张从众 	\N	1-1	32开	158.00	\N	东北师范大学出版社	\N	\N	\N	2020-06-01	/book/f8715f19-1329-47e8-96b5-e90d2ab8e9329787568169059.jpg	本套图书旨在于为三年级以下孩子普及中国古代史，传播中华文化，是一部适合儿童阅读的中国通史。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	556
1004	中国教材研究文库·王占春论教材	9787107344015	9787107344015	王占春/著 	\N	\N	16开	78.00	\N	人民教育出版社	\N	\N	\N	2020-11-01	/book/930da9ec-463e-4436-a9c8-1267293920b59787107344015.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	707
1002	中国教材研究文库·辛安亭论教材	9787107346514	9787107346514	辛安亭/著 	\N	\N	16开	68.00	\N	人民教育出版社	\N	\N	\N	2020-11-01	/book/5bd9a8df-598a-4089-a32d-d22965fe92a39787107346514.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	118
1080	什么是自动化？	9787568529983	9787568529983	王宏伟，王东，夏浩 	\N	1-1	16开	39.80	\N	大连理工大学出版社	\N	\N	\N	2021-09-01	/book/25d36b94-a1be-4570-a41f-1f7896e6e4599787568529983.jpg	《什么是自动化？》一书从故事引申出人类为什么进行自动化研究，用讲故事的方式，通过熟悉的案例，介绍了自动化及自动控制的基本原理、基本思想和应用情况，介绍了自动化专业的优势、发展、就业等，介绍了自动化毕业生的职业发展规划。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	852
1167	新编大学英语思政教程	9787521318500	9787521318500	李昀等 	\N	1	16开	52.90	\N	外语教学与研究出版社	\N	\N	\N	2020-03-26	/book/b2f638e1-39df-4cf4-8329-c54829a74ed29787521318500.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	448
1170	产出导向法促成活动设计	9787521321227	9787521321227	邱琳 	\N	1	小16开	46.90	\N	外语教学与研究出版社	\N	\N	\N	2020-10-31	/book/c1afa4da-5568-4b30-9f8a-25232a09e15a9787521321227.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	393
1253	曲式与作品分析课程谱例集（一）	9787810960366	9787810960366	中央音乐学院作品分析教研室 编 	\N	1-1	16开	45.00	\N	中央音乐学院出版社	\N	\N	\N	2004-07-01	/book/9218258c-4689-429d-9709-a5b68f1b373b9787810960366.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	705
1302	陇东主要家禽高效养殖技术	978-7-5683-0826-7	\N	曹宏 	0	1-1	16开	32.00	\N	西北农林科技大学出版社	\N	\N	\N	2020-05-01	/book/dead50f5-e034-456c-9693-f2b606616e5a1081850.jpg	本书内容共十章，包括养殖业在现代农业发展中的作用、肉羊高效养殖技术、肉牛高效养殖技术、奶牛高效养殖技术、生猪高效养殖技术、肉驴高效养殖技术、肉兔高效养殖技术、家畜疫病防治技术、现代养殖业主要生产机械、现代养殖业经营模式案例，同时附录了相关行业标准。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	363
1421	人工智能：技术与经济的双重奇点	9787569318845	\N	[美]卡勒姆·蔡斯 著 何明 等译 	平装	1-1	16开	102.00	\N	西安交通大学出版社	\N	\N	\N	2022-02-01	/book/0c1397f8-d3fb-429a-9d5c-beb6510ee56b1083404.jpg	三位院士联合重磅推荐 元宇宙不仅是一个人与人在虚拟3D空间中的互动世界，而且可能是AI最终展示出准人类行为的第一个地方和机会。随着AI的进步，我们可能会见证一个人工智能与人类无法区分的元宇宙！ 人工智能（AI）科学的诞生已有60多年，但在这段时间内取得的成就并不高。2012年，人工智能经历了一场“大爆炸”，从那个时候，原本统计学中的“机器学习”分支及其子分支“深度学习”广泛应用在了人工智能中。目前，机器在图像识别方面已经超越了人类，在语音识别及自然语言处理方面也正在赶上我们，然而这场人工智能革命才刚刚开始。 本书认为，21世纪，人工智能能力的指数级增长很可能会带来两个“奇点”，大多数正常规则在此奇点上会发生崩溃。第一个奇点是经济奇点，即当机器智能达到一定等级后，会使许多人失业，我们需要针对经济和社会体系进行彻底改革；第二个奇点是技术奇点，即当机器智能达到并超过成年人类的认知能力时，我们将变为地球上第二等级的智慧体。 这些奇点将带来巨大的挑战，但本书认为，我们能够迎接并战胜这些挑战。 这本书涵盖了： l人工智能的最新发展及其未来潜力 l经济奇点和技术奇点深度解析 l人工智能带来的风险和机遇 l我们应该采取什么行动 人工智能可以成为人类有史以来最好的事情，使我们的未来几乎超越想象的美好，但前提是我们必须直面它给我们带来的挑战。 我们无需担忧和惧怕AI时代的到来，我们所要做的，应当是尽早认清AI与人类的关系，了解变革的规律，更好地拥抱即将到来的新时代。 本书是一本有思维方法论启示的书；是一本站在历史的高度思考科技力量的书；是一本充满想象与预言，但又不失科学论证的书。本书提供了一个崭新的视角：21世纪既是数百年以来科技、创意的顶点，又是对人类终极命运真挚的愿景。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	182
1426	初中物理公式定律	9787564819194	\N	牛胜玉 著 	平装	1-1	128开	9.90	\N	湖南师范大学出版社	\N	\N	\N	2020-11-01	/book/869ca87d-04a8-4178-b6a0-30a6db8415391083433.png	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	984
1427	鲁迅作品十五讲	978-7-301-06477-1	9787301064771	钱理群 	\N	1	16开	69.00	274.0千字	北京大学出版社	364	7301	\N	\N	/book/6ac6e513-8d9b-4b64-83ef-253cae91af2e0647706.jpg	本书通过对鲁迅作品文本的精彩解析，引发对鲁迅思想与文学的深长思考，从而引领者阅读鲁迅作品。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	765
1509	社会艺术教育标准：全民终身学习核心素养	9787303270989	\N	周星 王杰 主编 	平装	1-1	16开	45.00	218.0千字	北京师范大学出版社	176	\N	\N	2022-01-01	/book/8ddb127a-d323-496e-870c-9a729c41d14f1083984.jpg	培养什么样的人不仅关乎每个家庭的未来，同时也关乎整个社会及国家的发展。 艺术教育从本质上来说，关注的是全面育人的教育问题。艺术教育可以提升公民综合素养，增强文化自信，有助于公民全面发展，促进社会和谐与稳定。党的十八大报告明确指出了教育的本质功能和真正价值，并指明了我国教育改革发展的目标及方向。 2019年，中共中央、国务院印发的《中国教育现代化2035》，中共中央办公厅、国务院办公厅印发的《加快推进教育现代化实施方案(2018—2022年)》等相关文件，都强调在社会教育领域加快建设学习型社会，构建全民终身学习服务体系，构建开放的人才成长通道，完善招生入学、弹性学习及继续教育制度，畅通转换渠道。从长远来看，艺术教育可以潜移默化地塑造一个国家、一个民族的精神气质和文化形象。艺术教育在创建社会文明方面具有不可替代的价值，这在全球已达成高度共识。艺术不仅能贴近人的精神世界、丰富人的精神生活，而且在激励人的情绪、优化人对社会的认知方面有着重要的意义。 北京师范大学中国艺术教育研究中心专家团队在参照世界先进国家提升国民艺术素 养成功实践经验的基础上，联合教育部艺术教育资源共享行动单位，共同研究制定了《社会艺术教育标准:全民终身学习核心素养》，将其作为全民学习艺术的指南和一线艺术教师的工作指引。 本标准为教育部委托项目“社区教育制度化规范化发展研究与实践项目课题” (艺术类)、中国成人教育协会“艺术行业社会教育标准体系与学习成果认证体系建设研究与实践”项目研究成果。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	719
1540	“一带一路”法律研究.第3卷	978-7-5620-8990-2	\N	刘晓红主编 	\N	1-1	16开	109.00	290.0千字	中国政法大学出版社	332	\N	\N	2021-06-01	/book/64ac8557-4e08-4d25-9905-c0b8af0492208990-2.jpg	《“一带一路”法律研究（第3卷）》紧跟全球经贸治理的新趋势，设置了名家专栏、国际法专题、热点聚焦、实务透视、争端解决等五个栏目。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	166
1696	旅游英语口语.基础篇	978-7-5689-2805-2	\N	徐阳平 何冬梅 	\N	1-1	16开	49.00	476.0千字	重庆大学出版社	250	\N	\N	2021-09-29	/book/a65b0e0b-d203-460c-b779-620b18cb2e1492805.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	870
1702	小学儿歌弹唱教程	978-7-5689-2848-9	\N	何怀兵 	\N	1-1	大16开	52.00	305.0千字	重庆大学出版社	153	\N	\N	2021-09-14	/book/2b2953e9-4b05-40df-ba3b-d50d227e0db092848.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	706
1703	高等教育循证教学	978-7-5689-2674-4	\N	贝斯·史华兹 里根·古隆 编 刘皓 译 	\N	1-1	16开	35.00	170.0千字	重庆大学出版社	119	\N	\N	2021-04-07	/book/01568606-af54-40da-b446-402d4a3ba07692674.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	228
1736	戏剧影视声乐基础教程	978-7-5689-3029-1	\N	赵彬 朱玉洁 	0	1-1	16开	45.00	229.0千字	重庆大学出版社	166	\N	\N	2022-01-18	/book/0551aa28-f233-4483-9329-2347126121871085722.jpg	\N	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	239
1773	二十四节气大百科	9787576010268	\N	梦动力童书 	平装	1-1	16开	198.00	\N	华东师范大学出版社	\N	\N	\N	2022-04-01	/book/a7b08f67-201d-4f05-a407-e5f15a00c7f41086001.png	《二十四节气大百科》按一年二十四个节气的时间顺序，分为春、夏、秋、冬四册。内文设置六大知识板块，在节气介绍中融入传说故事、农事劳动、民俗活动、古诗谚语和美食美景，让孩子们从更全面的角度认识二十四节气，享受古人的劳动智慧结晶。通过学习节气知识，孩子不仅能开阔视野，更能深入了解我国的传统文化和习俗，领会自然母亲的力量与美感。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	242
1807	高等数学(下册)	978-7-301-32761-6	9787301327616	"李成群,秦斌" 	\N	1	16开	38.00	231.0千字	北京大学出版社	148	7301	\N	2022-02-28	/book/bd7906e1-b55c-45a2-a352-40f10ab7752032761.jpg	"本书稿按应用型高等院校经济类、管理类本科高等数学教材编写。有如下特点：通俗、简单、强调专业应用，凸显一流课程建设要求的“两性一度”。我们在编写过程中，参阅了大量文献，充分吸收他人之优点，为适应应用型本科院校学生需要，在保证《高等数学课程教学基本要求》的前提下，对一些内容作了适当精简和合并。 在每章的开头有“本章导学”“问题背景”，使读者在学习每一章之前，先对内容有一个大致的了解。教材内容力求做到深入浅出、通俗易懂、语言流畅，通过例子、几何图形等帮助读者理解，最终达到熟记。其中的定理和性质有选择的给出证明过程，省略一些繁琐、冗长的推导过程。书中的例子都是经过精心挑选典型例题，特别加强高等数学在经济问题中的应用，相信这些例子有助于读者更好地理解教材内容，加强学生应用意识和创新能力的培养。同时，每一节的结尾都安排“小结”和“应用导学”，配有相应的习题，帮助读者巩固所学知识。最后在每一章的结尾附有“知识结构图”，以便于学生总结知识点；“总习题(A类）”、“总习题(B类）”，对学生全面掌握知识很有帮助,其中总习题(A类）面向全体学生考察基础知识的综合运用能力；总习题(B类）是近年的考研真题，供一些学有余力及有考研志向的学生使用。另外加入数学文化元素，在每章之前加入数学家等故事，以激发学生学习数学的兴趣，了解数学的历史、发展及应用。 本书稿可供应用型高等院校经济类、管理类等本专科各专业的学生使用，也可作为其他专业的教师和学生的参考书。预计每年用书约6000册左右。"	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	892
1829	长江边的名城	9787-5649-4919-8	\N	程遂营 	平装	1-1	16开	49.00	\N	河南大学出版社	\N	\N	\N	2021-11-01	/book/9cd27fa0-bd9a-4782-9c2d-0d65697261e81086389.jpg	该书是在央视《百家讲坛》同名系列讲座的基础上加工而成的，是系列图书的第一部，主要讲述了长江上游的玉树、丽江、遵义、成都、眉山、盐城、宜宾、重庆八座城市的历史、文化和变迁，展现了长江文化的精神内涵，由此揭示了中华文明生生不息的奥秘。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	310
1850	阅读唐律：由法制而文化	978-7-5764-0296-4	\N	张中秋 著 	平装	1-1	大32开	55.00	\N	中国政法大学出版社	\N	\N	\N	2022-01-01	/book/74f56eab-9e29-488b-a0dd-7c72ea7f85ea1086547.jpg	本书是作者学习和研读唐律的习作文集，前部分是关于法律制度的，后部分是关于法律文化的，中间是由制度向文化过渡的，前后构成对唐律由法制而文化的阅读，并在阅读中透视唐代经济民事法律，探讨传统中国政治生活类型的转变和中国传统法的原理，以及透过中外交流比较，揭示法律文化交流的一般原理和中华法系与罗马法的原理与哲学。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	656
1776	建筑工程测量	978-7-5625-5164-5	\N	何国林 颜循英 主编 	平装	1-1	16开	35.00	314.0千字	中国地质大学出版社	\N	\N	\N	2021-12-01	/book/47d3e52c-028f-403a-8f28-34d93f194f0b1086016.png	本书教学内容包括测量基础知识、高程控制测量、角度测量、全站仪的使用和坐标测量、距离测量与直线定向、平面控制测量、建筑施工测量和建筑物变形监测 8 个项 目 。每个项目由不同任务组成 ,每个任务通过任务描述、任务目标、任务书、任务分组、获取信息、任务计划、任务实施、任务评价、任务知识点来编排内容。学习这些理论知识和实训内容,培养学生扎实的技能以及责任意识和团队合作精神。 本书理论内容与实训内容相结合 ,增加了动画和视频等教学资源 ,实现纸质教材+数字资源的完美结合 ,体现“互联网 +”新形态一体化教材理念。学生可以通过观看相应资源 ,时时可学 、处处能学 ,加强学生自主学习的能力 ,实现高效课堂。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	909
1777	基于多维动态数据的移动图书馆用户使用行为研究	978-7-307-13121-7	\N	明均仁 等 著 	平装	1-1	16开	56.00	\N	武汉大学出版社	\N	\N	\N	2021-12-01	/book/8da8d8e3-4c45-4b89-ba8a-fc27170fed921086024.jpg	本书围绕移动图书馆用户行为，以用户行为理论为基础，融合信息科学、心理学、社会学、行为学等多学科理论与方法，结合图书馆信息系统记录、后台日志数据、实验数据与用户的自我报告等多源数据，动态对比与研究移动图书馆用户的服务接受及使用行为，回答为什么开展移动图书馆用户行为分析、怎么开展移动图书馆用户行为分析、如何确定影响用户行为主导因素、如何提升用户使用移动图书馆服务体验等问题，以更好地反映用户行为特征、影响因素、模型构建与机理分析等，对于提升图书馆移动服务质量具有重要参考意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	820
1778	现代汉语动语素研究	9787564944353	\N	郭华 	平装	1-1	16开	58.00	\N	河南大学出版社	\N	\N	\N	2021-12-01	/book/cf506afa-ba0d-422e-983f-cf7ba3f207681086032.jpg	语素研究是汉语的基础研究。作为最小的音义结合体，语素在独立成词和构词入句两个方面都发挥着巨大作用，具有强大的语法功能。除名语素外，动语素在现代汉语语素中数量最多。本书是对现代汉语动语素的专题研究。 通过梳理学界已有的研究成果，本书以《现代汉语词典》（第7版）为蓝本搜集整理了现代汉语单音节动语素的条目，建立了“现代汉语单音节动语素数据库”。并从成词性、兼类、语义、构词等诸多方面，对其进行了全面地统计描写和分析。我们的研究建立在定量分析的基础上，对于动语素既不泛泛而谈，也不完全微观至语素项，更多的是运用统分结合的研究方法。构词部分选择典型语素开展了个案研究。 现代汉语动语素作为语素研究的冰山一角，还有待进一步地深入和扩展。然而，语言研究是为了更好地服务于语言应用。对现代汉语动语素的探讨，对于对外汉语教学、计算机分词和词典的编纂等方面都有重要意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	756
1805	贸易网络中的黄土丘陵（BC1300-1050）	978-7-301-32668-8	9787301326688	曹大志 	\N	1	16开	98.00	400.0千字	北京大学出版社	308	7301	\N	2022-03-09	/book/3b7d70e2-f2ed-4bce-94f1-266391c6466a32668.jpg	20世纪以来，贫瘠的黄土丘陵地区陆续出土了数百件晚商时期精美的青铜器。这个现象长期吸引着考古学界的关注。为了理解它，作者通过检视过去调查的标本，确认了晚商时期遗址400余处；通过在石楼县的区域调查、采样，获得了对黄土丘陵本地社会的深入认识。在此基础上，作者研究了青铜器的产地。多个来源的铜器指示晚商时期的黄土丘陵与华北平原、关中盆地、北方草原都有跨地区的联系。结合考古材料和文字记录，作者提出晚商时期的中国北方存在一个涉及广泛的贸易网络。 黄土丘陵与发达的中原文明相比是较简单的边地社会，但是凭借有利的地理位置，它充当了跨地区联系的枢纽，扮演了中原文明与北方草原联系的中间人角色。黄土丘陵的本地社会在贸易网络中变得更复杂，中原文明也在跨区域的联系中获得成长。本研究从社会—经济和古代贸易的角度观察社会变迁，对理解中原文明的成长、黄土丘陵等北方边地社会的发展，以及青铜时代中国与蒙古的远距离交流提出了系统解释。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	959
1806	大学物理实验报告	978-7-301-32759-3	9787301327593	"师文庆,李永强" 	\N	1	16开	36.00	296.0千字	北京大学出版社	200	7301	\N	2022-02-28	/book/5f4de81e-9b8a-4325-8a62-3b36be66749932759.jpg	实验1 固体和液体密度的测量 实验2 用落球法测定液体的黏滞系数 实验3 液体表面张力系数的测量 实验4 速度和加速度的测定 实验5 验证牛顿第二定律 实验6 用转动法测量物体的转动惯量 实验7 用拉伸法测定金属丝的杨氏模量 实验8 准稳态法测量导热系数 实验9 空气比热容比的测量 实验10用模拟法测绘静电场 实验11 数字示波器的使用 实验12 铁磁材料磁滞回线的测量 实验13 霍耳效应法测量磁感应强度 实验14 薄透镜焦距的测量 实验15 平行光管法测量薄透镜的焦距及分辨率 实验16 分光计的调整和棱镜角的测定 实验17 用分光计测量棱镜玻璃的折射率 实验18 光栅常数和角色散率的测量 实验19 等厚干涉的实验研究 实验20 双棱镜干涉测量光波波长 实验21 弦线上波的传播规律的研究 实验22 声速的测量 实验23 多普勒效应 实验24 半导体热敏电阻特性的研究 实验25 电位差计测量温差电动势 实验26 密立根油滴法测量电子电荷 实验27 夫兰克-赫兹实验 实验28 液晶的光电效应 实验29 迈克尔逊干涉仪 实验30 全息照片的拍摄 实验31 小型棱镜摄谱仪的使用 实验32 用光栅光谱仪测量氦灯的波长 实验33 光电效应和普朗克常量的测量 实验34 超声光栅测量液体中的声速 实验35 光速的测量 实验36 玻尔共振实验 实验37 单缝衍射相对光强分布的测定 实验38 光纤传感特性的实验研究	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	851
1808	新编微积分(理工类)下	978-7-301-32782-1	9787301327821	"林小苹,谭超强,李健" 	\N	1	16开	59.80	617.0千字	北京大学出版社	368	7301	\N	2022-02-28	/book/4b163826-9e22-441a-a0de-2b95646b441632782.jpg	新教材分为《新编微积分（理工类）》上、下两册： 下册主要内容是多元函数微积分，是一元函数微积分的扩展，侧重对空间思维能力、复杂计算能力以及数值计算能力的训练。全书包括向量代数与空间解析几何，多元函数微分学及其应用，重积分，曲线积分与曲面积分，柯西中值定理与泰勒公式，无穷级数，近似计算问题及其计算机共七章内容。 目 录 第七章 向量代数与空间解析几何 第八章 多元函数微分学及其应用 第九章 多元函数积分学1---重积分 第十章 多元函数积分学2---线面积分 第十一章 柯西中值定理与泰勒公式 第十二章 无穷级数 第十三章 近似计算问题及其计算机实现	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	586
1809	高等数学（下）	978-7-301-32824-8	9787301328248	兰州理工大学数学教学部 	\N	1	16开	49.80	457.0千字	北京大学出版社	272	7301	\N	2022-02-28	/book/2f73fe74-83e2-4031-91d4-64fae30b032432824.jpg	本书是根据教育部关于高等学校理工科本科“高等数学”课程的教学基本要求，结合分层分类教学的课程教学内容和课程体系改革方针以及编者多年的教学经验与实践编写而成的. 本书分上、下两册，上册内容包括：函数、极限与连续，导数与微分，微分中值定理与导数的应用，不定积分，定积分及其应用，常微分方程；下册内容包括：向量代数与空间解析几何，多元函数微分法及其应用，重积分及其应用，曲线积分与曲面积分，无穷级数，高等数学中的数学实验. 几乎每节都配有对应内容的习题，此外每章都配有总习题，书末附有习题参考答案与提示，以便于学生理解和学习. 本书在高等数学原有知识体系结构基础上增加了数学实验的内容，适合普通高等学校理工科非数学专业本科生和任课教师参考使用.	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	960
1810	股权质押实证研究	978-7-301-32838-5	9787301328385	许静静 	\N	1	16开	68.00	161.0千字	北京大学出版社	232	7301	\N	2022-03-15	/book/45599f6b-5686-4887-a55f-552649de0ecc32838.jpg	股权质押逐渐成为我国主流的融资渠道，其优势在于以不稀释公司控制权为前提，而将其账面的静态股权激活为动态的财务资源，但当遭遇股价下跌，质押股份就会面临平仓压力，继而公司内部会因之动荡剧烈。近年来，由于A股越来越高的股权质押率，以及伴随着的越来越多的上市公司爆仓新闻，使得股权质押成为上市公司、监管机构及学术界共同的关注焦点。 本书从案例与实证出发，在搜集了资产评估公司大量真实案例的基础上探讨了中国A股上市公司控股股东将股权质押给银行进行融资这一行为对上市公司造成的经济后果。全书共八章，以顾地科技案例、艾迪西案例为入手点，从控股股东股权质押与企业会计稳健性、企业策略性业绩预告、“管理层讨论与分析（MD&A）”披露语气、企业“高送转”股利政策、企业审计师选择等多方面进行了实证分析。在此背景下，对股权质押可能导致的经济后果进行了详尽的探讨，为监管层出台更具有针对性的监管方案提供了参考，为学术界这一日趋热门的研究话题提供了新的证据。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	784
1816	英语外刊阅读教程	978-7-5446-7009-8	\N	魏剑峰 主编 	平装	1-1	16开	46.00	\N	上海外语教育出版社	\N	\N	\N	2022-04-01	/book/38272177-4ea4-4254-bcc2-afb81cea48461086293.jpg	本书是“大学英语考试能力系列”之一。本书精选英语外刊文章，从词汇、句子及篇章三个层面帮助学习者了解报道类文章特点，增强外刊阅读理解能力，从而提高英语综合应用能力。本书特点包括：采用主题阅读方式编排单元选文，16篇文章覆盖工作、环境、健康、教育、文化等8大领域；有针对性地解决英语外刊阅读难点，每个单元讲解一种外刊阅读技巧；练习丰富多样；听读并重，文章配有音频。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	563
1812	“布鲁姆斯伯里团体”现代主义与中国文化关系研究	978-7-301-32906-1	9787301329061	"杨莉馨,白薇臻" 	\N	1	16开	98.00	330.0千字	北京大学出版社	332	7301	\N	2022-03-07	/book/f090f1d1-f1ae-40fd-abd9-24bc14188d4332906.jpg	回望中西文化交流史，我们发现，无论是“西学东渐”还是“东学西传”，中西文学—文化的发展均离不开从对方那里汲取滋养。19世纪后期到20世纪初，西方美学思潮与文学艺术正经历着从以模仿论为基础的现实主义与自然主义传统中脱胎换骨的重大变革，中国文化为欧美现代主义美学与文艺思潮的兴起提供了重要的助推作用。本书将现代主义视为具有跨国特征与多元文化渊源的美学运动，以英国“布鲁姆斯伯里团体”成员与中国文化的关联及对中国道德价值、美学思想的阐发为个案，深入考察了中国文学—文化如何经由转换与变形而助推了英国现代主义的生成；同时在西方中国观念与中国形象演变的大背景下，认真分析了19世纪末到20世纪上半叶，尤其是第一次世界大战前后的英国知识分子对中国态度转变的内外部因素，从一个独特的角度揭示了中国文学—文化参与世界文明现代性构建的突出贡献。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	441
1813	为学生架设攀升的阶梯——基于创新素养提升的小学信息技术教学实践研究	978-7-301-32860-6	9787301328606	任辉 	\N	1	16开	78.00	200.0千字	北京大学出版社	280	7301	\N	2022-03-28	/book/a74a476f-cbff-4cba-9261-9dfd28cce02d32860.jpg	本书围绕核心素养，从学生的学习需求出发，结合学生在探究学习中的兴趣需要、知识需要、发展需要、创新需要，在目标调整、课程建设、学习方式、交流评价、责任关注等多方面多角度为学生核心素养的核心提供助力，为学生架设攀升的阶梯。具体内容包括： 教学设计篇——基于学生需要的设计；教学目标篇——基于目标指向的调整；教学内容篇——基于课程内容的丰富；教学方式篇——基于教与学方式的改变；教学评价篇——基于评价内容的变化；课题研究篇——基于教学研究的深入。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	851
1848	贸大经典·沈达明文集	978--	\N	沈达明 	平装	1-1	大32开	0.00	\N	对外经济贸易大学出版社	\N	\N	\N	2022-04-01	/book/30c28e40-fa7a-4fd9-a3e8-12dfdf0e9be21086538.png	沈达明先生是贸大名师，一生著述甚丰，其治学的严谨、为人的高洁都令后人十分景仰。《贸大经典·沈达明文集》于2015年9月沈达明先生诞辰100周年纪念大会首发。这部文集收录了沈达明先生自1980年至2005年出版的著作，共23本。再版过程中，除了对一些当时的印刷错误尽可能予以勘准；一些译法具有个人独创性，和目前通行的译法有所区别，为了便于读者理解，编辑对一些专业术语和数据以注释的形式予以说明之外，内容均充分尊重原作，以保留其应有的历史价值。汇集、整理、再版这些经典，既是对先生最好的纪念，也对沉淀贸大历史、传承贸大文化、激励晚辈后学有着十分积极的作用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	468
1814	大学英语诵读精选	978-7-301-32908-5	9787301329085	冯瑛 	\N	1	16开	39.80	192.0千字	北京大学出版社	152	7301	\N	2022-03-28	/book/c4cdc898-3454-470f-900e-b02b5171a81d32908.jpg	本书精选了适合大学生背诵的英语语篇（对照中文），主要内容由四个部分组成，分别是基础篇、提高篇、实战篇和感悟篇。 第一部分是基础篇，有40篇文章，文章内容丰富多样，如名人演讲、励志短文、经典的诗歌等。同时，也结合时代热点和思政元素，把思想政治教育融入到英语学习当中。 第二部分是提高篇，选用了新时代一些政治的热点词汇，比如说“脱贫攻坚”“为人民服务”“不忘初心、牢记使命”等，中英文对照，帮助学习者掌握这些热门词汇的英文表达。此外，还精选了两篇习近平主席重要讲话的演讲稿，中英文对照，让学生既了解时事，又能够掌握英文表达，最终的目的就是达到讲好中国故事，把中国的思想观念向外传播。 第三部分是实战篇，结合大学英语四级考试的题型，分为翻译和写作两个部分。在作文部分，精选了14篇四六级考试作文的范文。另外在翻译中，精选了15个中国传统文化中英文对照的翻译段落，希望学生能够从中学会如何将中国传统文化知识翻译成英文，这与四级考试的题型是吻合的。 第四部分是感悟篇，挑选6篇学生在英语学习和背诵过程中的心得体会和经验之谈，向使用这本教材的同学们提供好的经验、好的做法，帮助他们受到启发，找到适合自己的英语学习方法和背诵方法。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	256
1830	寻芳记	9787561582718	\N	林间 	平装	1-1	32开	50.00	\N	厦门大学出版社	\N	\N	\N	2022-04-01	/book/3b7aaf17-327e-4bbc-a762-a40696c3541b1086398.jpg	厦门大学是中国最美丽的高等学府之一。一年四季，树木葱茏；繁华怒放，争奇斗艳。百年之前，陈嘉庚以独到的眼光选择了鹭岛东南海滨这片依山傍海、风景绝佳的土地，选择了厦门这个地处亚热带、气候温暖、四季如春的城市，来建设厦门大学这个美丽的校园。百年来，厦大校园始终以花草繁茂、绿树成荫而著称。本书是一本文创手账图书，选取近百种最具校园特色和观赏价值的植物，以摄影作品和简介带着读者走遍厦大，探寻处处芳草，将自己“寻芳”的动人故事记录下来。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	412
1815	巧学巧用Excel：迅速提升职场效率的关键技能	978-7-301-32878-1	9787301328781	"凌祯,安迪,梁向上" 	\N	1	16开	109.00	777.0千字	北京大学出版社	516	7301	\N	2022-03-30	/book/1782ccf4-deea-443c-a2ae-870ddbc333d832878.jpg	越来越多的职场人士开始发现数据的重要性，而Excel作为职场中最日常、最高效的数据管理工具，可以帮助我们快速整理数据、分析数据、呈现数据。本书立足于企业实际工作中的业务场景，为读者提供一个巧学巧用Excel的高效学习方法，实现办公效率提升。 本书系统地介绍了Excel在数据管理工作中涉及的各项技巧，包括基础制表、规范录入、数据导入、分类汇总、条件格式、迷你图、打印保护、数据透视表、数据透视图、函数公式、商务图表等，并配有大量企业实战级的应用实例，帮助读者全面掌握Excel实战技术。 本书适用于各个层次的Excel用户，既可作为初学者的入门指南，又可作为中、高级用户的参考手册。书中大量来源于职场实战的案例，可作为读者在工作中的模板载体，直接应用到自己的实际工作中。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	309
1825	农业技术推广（第3版）	9787565526626	\N	王守国，宫绍斌 	平装	1-1	16开	45.00	\N	中国农业大学出版社	\N	\N	\N	2021-12-01	/book/fa44d318-8c07-443c-bfe2-056c1d86b4351086346.jpg	本书是“十二五”职业教育国家规划教材,分为农业技术推广基础和农业技术推广学习项目2个部分。农业技术推广基础包括农业技术推广概述、农业创新采用与扩散、农业技术推广心理、农民行为改变和农业技术推广沟通。农业技术推广学习项目设置了农业技术推广程序和方法运用,农业技术推广项目选择与实施, 试验、示范与技术培训,农业技术推广信息服务,农业技术推广调查,农业技术推广工作评价6个学习项目。各部分内容独立成项目,又紧密联系,构成统一整体。同时根据农业技术推广工作需要,设置了编制农业技术推广项目计划、编制推广项目可行性研究报告、农业技术推广项目总结、成果示范、农民技术培训、农业技术推广信息采集与应用、农业技术推广现状调查、农业技术推广项目评价等实训项目。推广基础和各学习项 目设有思考题和学生自测题,以便检验学习效果。本书总结了近年来我国农业技术推广体系改革和建设的新成果、新经验,加强了针对性,突出了实用性, 充分体现了高等职业教育培养高素质技能型人才的特点,可作为农业类专业、畜牧类和渔业类专业的教材, 也可供农业行政人员和技术推广人员使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	577
1826	吐鲁番出土文书新探（第二编）	978-7-307-14325-8	\N	刘安志 主编 	平装	1-1	16开	99.00	\N	武汉大学出版社	\N	\N	\N	2021-12-01	/book/a2d85279-7a3d-426a-8103-879179f43c461086371.jpg	本书为唐长孺先生110周年诞辰纪念专辑，收录二十余篇纪念性及专题性学术论文，其中集中收录有陈国灿先生6篇关于吐鲁番地名研究的文章。全书紧紧围绕吐鲁番地区出土文书整理与研究，将吐鲁番出土文书与相关传世文献相结合，在对吐鲁番出土文书进行缀合、编连、释读的基础之上，对文书所见相关的政治、经济、文化、制度、地理等进行了深入研究。有助于推动中国中古史及中国敦煌吐鲁番学的发展，对于“一带一路”建设、抢救保护文化遗存具有现实意义。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	509
1827	犹记韶华在珞珈：合校二十年开学典礼和毕业典礼校长寄语	978-7-307-21693-8	\N	窦贤康 主编 	平装	1-1	16开	68.00	\N	武汉大学出版社	\N	\N	\N	2020-09-01	/book/9c1dd3f1-db89-46b7-a49b-44806e0e94451086372.jpg	"本书以武汉大学自2000年由四所大学合并，创立新武汉大学，至今已达20年为契机，收集整理了期间5任校长即侯杰昌、刘经南、顾海良、李晓红、窦贤康在开学典礼和毕业典礼上的发言，通过精炼的文字，借以传达武汉大学精神、办学理念、服务理念、报国理念，以及新型人才创新观。呼吁当代大学生应该具有更高的历史站位，自强不息、爱国报国、追求卓越，承担使命，书写人生精彩。 本书收集整理5位杰出且在业内具有较大影响的校长的开学及毕业典礼讲话，具有一定的史料价值，具有一定的出版价值。 "	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	953
1828	平面通用原型女装成衣制版原理与实例	9787566919779	\N	尚祖会 	平装	1-1	16开	99.80	\N	东华大学出版社	\N	\N	\N	2022-01-01	/book/95002878-5320-4ea2-b25c-f8c5a820d6e81086380.jpg	本书介绍了运用女装平面通用原型进行成衣制板的原理与实列，从服装的平面基础原型开始，系统地讲述制板原理及步骤，分门别类地讲解了不同女装款式的制板方法。全书分为基础篇、上装篇和下装篇。基础篇包括衣身结构平衡与省量转移；上装篇包括女式无省衬衫、连袖衬衫、立领荷叶边泡泡袖合体衬衫、三开身西服、一粒扣女西服、合体X型插肩外套、立领落肩袖廓形外套、双排扣女西服、男友装、连衣裙、旗袍、前连袖后落肩翻领大衣、插角大衣、带帽宽松插肩袖大衣、拐袖关门领外套、落肩拐袖外套、大直线落肩外套；下装篇包括女西裤、女短裤、女萝卜裤、套装裙、鱼尾裙、A型裙。此外，本书还对工业制板进行了一定的介绍和阐述。本书图文并茂，步骤清晰，适用于高等院校相关专业作为教材使用，也适用于读者自学掌握制板原理与提高制板技能。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	448
1854	大树西迁	9787569316698	\N	陈彦 	平装	1-1	16开	68.00	\N	西安交通大学出版社	\N	\N	\N	2022-04-01	/book/0fed0e16-9053-4470-9705-e0a15df451311086569.png	《大树西迁》是一部秦腔现代剧，它以20世纪50年代以交大为代表的一批高校、科研院所响应党的号召，从沿海大规模地西迁内地，投身于西部开发建设这一史实为背景精心创作。全剧以苏毅、孟冰茜一家三代人西迁五十年的奋斗历程为主线，以几个不同历史时期的生活画面为切入点，纵横交错地演绎出了主人公五十年情感嬗变、思想升华的心路历程，艺术地再现了那个壮怀激烈的年代，昭示了共和国知识分子“哪里有事业，哪里有爱，哪里就是家”的坚定信念，讴歌了他们前赴后继、忍辱负重、热血担当的人格精神。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	351
1832	文化经济学手册（原书第三版）	9787563831968	\N	【英】露丝·陶斯 【荷】特里尔塞·纳弗雷特 著 译者：周正兵 	平装	1-1	大32开	248.00	\N	首都经济贸易大学出版社	\N	\N	\N	2022-03-01	/book/1f4738a8-c86a-4baa-ab96-27ba116a914d1086406.jpg	文化经济学涵盖了广泛的主题，包括从艺术到游戏的整个创意产业。本书各章以短小易懂的方式描述了这些主题。每章都提供了关于该主题的新研究总结，并提供了进一步阅读的建议和其他相关章节的交叉参考。通过介绍诸多主题，证明了经济学在解释艺术和创意产业的经济方面的功能。作为第三版，本书还展示了数字化对文化部门、现场表演艺术等的巨大影响，并对从艺术市场到博物馆、从电影到电子游戏等文化产业的生产和消费进行了具体讲解。反映了数字化对需求、商业模式和新的供给模式的作用。 本书既有易读性也有专业深度，任何具有经济学基础知识的读者都可以阅读这本书，经济学、商业经济学、创意产业、媒体和艺术管理的学生和教师，甚至是政策制定者都可以使用这本书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	142
1833	学人与学科：以方汉奇影响力为中心	9787565148897	\N	刘泱育 	平装	1-1	大32开	55.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2022-04-01	/book/61e15af0-8fa7-49d7-8d95-1222d0975cfd1086412.png	《学人与学科：以方汉奇影响力为中心》是作者刘泱育在数年中先后出版的“方汉奇研究”的第三本著作，也是他经过多年积累、立项三年、数稿打磨后的成果。 中国有悠久的“以史为鉴”传统。作为一门学科的新闻史学，在中国新闻传播学界因何重要？通常的答案便是从“以史为鉴”的角度着眼。本书则认为，新闻史学之所以重要，不仅仅是由于新闻史学成果使人们有可能“以史为鉴”，而且是因为从事新闻史学研究和教学的学人们重要。 本书是一部尝试从多个角度探讨和研究“方汉奇影响力”的著作，分别从方汉奇影响力的“层次”“范围”“形式”等不同视角探讨了“方汉奇影响力”的具体内容、主题、实现形式等具有特定内涵的问题，第一次在人们面前展现了作为中国当代新闻史学领域的“这一个”典型人物“方汉奇”及其研究成果所凝聚、蕴含和发挥出来的丰富“影响力”。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	230
1834	芋头田里探索乐	9787565150555	\N	南京市香山路幼儿园，任婕，刘悦，王亚楠，朱丽萍 	平装	1-1	大32开	48.00	\N	南京师范大学出版社有限责任公司	\N	\N	\N	2022-04-01	/book/1dc67e5d-2920-455b-b573-53ec2fdf39b91086419.jpg	纸是幼儿生活、学习的必需品，蕴含着各种探索的机会和教育价值。本书遵循幼儿主体的课程原则，主要记录幼儿在观察、探索、表现各类用纸等过程中的探究过程。在整个观察过程中，幼儿始终保持着浓厚的操作探究兴趣，其积极态度和良好行为倾向等学习品质得到了很好的提升。活动过程中，幼儿充分利用园内外资源，在家园互动中进行连续性的操作体验，教师以支持、鼓励、参与等策略推进儿童个体经验的持续发展，充分体现了幼儿在前、教师在后的课程理念。在整个活动中我们关注的是让幼儿做什么不是听什么，关注幼儿整体的行为。鼓励幼儿尽情交往、尽情探索、尽情操作，帮助幼儿获得更多的有益经验，充分发挥幼儿学习的主体性。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	913
1835	月球之书	978-7-5689-2828-1	\N	大卫·沃姆弗兰什 著 丁 一 郑建川 译 	平装	1-1	大32开	0.00	\N	重庆大学出版社	\N	\N	\N	2022-04-01	/book/16ad3d4a-a18e-44ac-a214-88f58f48646d1086428.png	数十亿年前地球上所见的月亮，和我们今天所见有何不同？ 中国周朝时期的青铜器上刻着哪些关于月亮的铭文？ 第一只进入太空的小狗叫什么名字？ 这些只是这本插图精美的书中涉及的众多有趣问题的一小部分。作者沃姆弗兰什为我们展示了月球自身的历史和人类探索月球的过程中最重要的里程碑事件，包括月球的形成之谜，中西方古人对月球持续不断的观测和最为我们熟知的登月计划等。 月亮也许是激发人类最初想象力的来源，人类历史上第一部署名的作品就是关于月神的诗集。月亮在神话、宗教中的重要地位显示着早期人类对于未知世界的好奇与敬畏，随着生产力的进步和人类文明的发展，我们对月球的了解从借助望远镜远观到最后实现登月，正如第一位登上月球的人类所说，“这是我的一小步，却是人类文明的一大步”。 关于月球，我们想要知道的也许更多。跟随大卫•沃姆弗兰什踏上这趟月球之旅，探索关于月球最重要的100个里程碑事件，从月球形成到用数学方法研究月球，从开始使用望远镜到进行月球科考及后续的一系列科学实践。在这趟旅程中我们还会遇到泰勒斯、阿利斯塔克、牛顿、等伟大的科学家，还有《月里嫦娥》这样具有超前意识的艺术影片。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	405
1836	量化民族志:一种面向大数据的研究方法	9787568930468	\N	量化民族志:一种面向大数据的研究方法 	平装	1-1	大32开	69.00	\N	重庆大学出版社	\N	\N	\N	2022-04-01	/book/0c2e480b-1e53-4f0d-b42d-2aeec377ba461086436.png	量化民族志是在整合了数据挖掘、话语分析、心理学、统计学和民族志等方法的基础上，提出的一种全新的科学研究方法。这种方法的提出，主要是为了解决互联网时代如何处理、分析海量数据来做社会科学研究的问题。本书强调了大数据时代，原始数据蕴含的意义是开展所有研究与分析的基石。面对海量数据，必须通过合理的数据整理来赋予数据意义，而挖掘意义，正是民族志方法所具有的优势。本书首先介绍了民族志方法的基本要点，然后介绍了统计分析的基本要点，之后根据互联网大数据的特点，指出应当如何将民族志与统计分析结合，来有机地结合生成“量化民族志方法”。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	959
1837	艺术与科学：从野生茄子到三宅一生	9787568930918	\N	卢瓦克·芒让（Loïc Mangin） 	平装	1-1	大32开	68.00	\N	重庆大学出版社	\N	\N	\N	2022-04-01	/book/aaae7f8c-9897-478b-bdec-0e0aefc1fea71086444.png	《艺术与科学》是从科学角度解读历史上经典艺术品不为人知的内容，除却个人体验、专业解读、历史呈现等读者习以为常的理解艺术的路径，作者另辟蹊径，为读者分析梵高的向日葵，特纳的天空，米开朗基罗的西斯廷教堂，勃鲁盖尔的巴别塔，达芬奇的被单，弗美尔的画，伦勃朗的自画像……让我们得以真正地从视觉与感官去理解它们的价值。作者将艺术品按照与科学的关系划分体例，分为植物与动物；数学与信息科学；天文；地理与气候；人文：认知、感知、医学；物理与技术六个部分。 弗美尔画中的船有什么作用？为什么米开朗基罗创作的耶稣有 33 颗牙齿？达利笔下的十字架为什么有着奇怪的形状？伦勃朗的自画像为什么总是斜眼？这本书将给出科学而有趣的解释。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	721
1838	昆虫家谱：世界昆虫410科野外鉴别指南（标准版）	9787568930185	\N	张巍巍 	平装	1-1	16开	198.00	\N	重庆大学出版社	\N	\N	\N	2022-01-01	/book/de87ea3f-e554-4b48-bf31-f606271787481086449.jpg	　《昆虫家谱：世界昆虫410科野外鉴别指南（标准版）》为《昆虫家谱：世界昆虫410科野外鉴别指南》修订版。全书提供了410科昆虫的简便鉴别方法，这些方法源于作者在昆虫分类与野外识别领域的长期实践与探索，实用性极强。为便于读者理解，该书文字简明、通俗，生态照片特征分明，采用了世界新昆虫分类体系（涉及广义昆虫4纲35目）。在选择物种方面，兼顾了常见昆虫类群与珍稀物种的平衡，收纳了原尾虫、缺翅虫、蛩蠊、捻翅虫等罕见物种的照片。全书照片多达1500余幅，读者可以直观地进行野外昆虫对照识别。 　　《昆虫家谱：世界昆虫410科野外鉴别指南（标准版）》是广大生物专业、植保专业人士不可多得的野外实习工具书，也非常适合昆虫爱好者和生态摄影爱好者作为参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	836
1839	拔剑起蒿莱：周楠革命史迹研究	978-7-306-07242-9	\N	高良坚 编著 	平装	1-1	特16开	98.00	249.0千字	中山大学出版社	404	\N	\N	2021-06-01	/book/96155a97-260e-4cd0-ae9d-23f7a6aeb4fc1086451.jpg	《拔剑起蒿莱——周楠革命史迹研究》是“中共南路革命史料整理暨研究”系列丛书之一，系广东海洋大学人文社会科学研究“建党100周年献礼红色著作专项”重点项目——“广东南路红色文化教育资源开发研究”的最新研究成果之一。周楠的革命生涯一直是个“谜”，有较丰富的海外生活和革命经历，过程纷繁复杂不易掌握，在南路革命历史研究中一直是块“硬骨头”。该书首次对周楠的革命史迹进行一次全面的整理与探究，从少年时期的朝鲜读书工作到青年时期的香港入党从事革命活动，再到上海厦门广州、南路地区、粤桂滇黔边区、越南等地方的革命活动，以及建国后担任广东省人民法院首任正职院长等等进行全面的梳理与探索。周楠是领导广东南路革命时间最长的特委书记。领导了南路人民的抗日战争、桂滇黔边区人民的解放战争、越南华侨工作以及越南中团和南路主力部队在越的整训。创建的南路武装力量，成为华南游击队的重要组成部分。新中国诞生后在法制建设亦有突出的建树，领导了广东省全省法院组织体系的建设，对广东刑事法律制度建设、民事审判建设都有突出的贡献。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	824
1840	广告设计	978-7-5623-6917-2	\N	孟拥 张君 主编；钟尚联 孟慧 张可乐 副主编 	平装	1-1	16开	50.00	\N	华南理工大学出版社	116	\N	\N	2021-12-01	/book/85ff1354-0043-4b02-9111-89c0f19d68891086452.jpg	《广告设计》 围绕广告设计的定义、策略、原理、制作、赏析等方面，结合广告设计创意、广告设计方法与广告设计技巧等内容编写而成。 本书旨在解决广告创意的关键问题，帮助读者更好地思考广告的创意方法，学会通过广告设计更好地为品牌服务，提升品牌形象。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	230
1841	校园排球教学指导	978-7-5644-3625-4	\N	孙平 赵凯 主编 	平装	1-1	16开	50.00	136.0千字	北京体育大学出版社	\N	\N	\N	2022-03-01	/book/07ebc2c7-e5fd-4bfb-b296-349d644489501086455.jpg	《校园排球教学指导》介绍了校园排球运动的课程优化设置、教学活动的科学化组织与开展。同时，还专门就校园排球运动的多元化教学内容即排球运动技术、战术、游戏的教学进行了分析与阐述。教学内容科学严谨、深入浅出，突出了新时期校园排球运动教学的时代特点、对排球运动科学化教、学、练具有重要的理论与实践指导价值，适合于中小学师生阅读参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	367
1842	创意72变——72招让广告小白变创意高手	9787564948597	\N	丁和珍 	平装	1-1	大32开	256.00	\N	河南大学出版社	\N	\N	\N	2021-11-01	/book/e574890c-ea72-4c4e-bb93-c36f16cbcb731086469.jpg	一套《创意72变》=2本创意方法论图书+1张巨型创意实操地图+1盒创意头脑风暴卡+1个甄选的全球顶尖资源库。限时限量赠送一本文案宝典《文案小黄书》 《创意72变》是全套创意实战工具，含2本书系统讲创意方法论、1盒卡用于头脑风暴、1张巨型实操地图，还配套精选了1000+全球顶尖创意资源库。可根据Brief适配激发创意，诸如镜头在变、变成字面意思、变出理由、变成冤家、人变成物等等72招，像孙悟空一样，快速帮助你实现72种创意变化。 系统方法论图书，10年4A黄金时代经验，10年创意公司创业实战，筛选出72种至今还是超级实用的创意手法，以作业流程式倾囊相授。 72张特质头脑风暴卡，和搭档相互刺激，跳出个人死角，批量产出高效的创意。 文案小黄书收录了史上100位伟大文案的创作秘籍，让他们精心点拨你，助你写出让客户抢着要、让消费者忍不住买的小黄书。目前限量赠送，后期需单独购买。 72条路径，3个步骤，摊开在办公桌上，对照地图线路，快速想到高质量的创意。 《创意72变》是基于视频广告而来，向平面H5等广告形式变通起来更容易，而开发全套实战的人，是一直战斗在一线的4A出身的资深创意大牛丁和珍，基于20年从业经验总结而来，超级实用、经典又时新。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	767
1859	机车检测和监测技术	9787564386146	\N	王磊 贺亚楠 	0	1-1	16开	35.00	330.0千字	西南交通大学出版社	212	\N	\N	2022-02-01	/book/5886cf6c-6a14-4d80-9940-92a003bfc71a1086593.jpg	本书是高等职业院校铁道机车专业教材。全书从铁路运用现场出发，精选相关知识，与铁道机车专业其他课程相辅相成，全面构建适应岗位要求的知识体系，同时，引入机车检测和监测的新技术、新装备相关知识，使之更贴近现场实际，以适应铁路发展需求。本书共七章，分别介绍了机车检测和监测技术的概述、无损检测技术、机车远程监测与诊断系统、机车车载安全防护系统、综合检测棚、机车车号识别系统和机车联网平台技术。本书也可作为成人教育、机务段机车运用与检修人员和有关工程技术人员的岗位培训参考用书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	891
1843	电路原理	9787560662329	\N	吴园 	\N	1-1	16开	51.00	473.0千字	西安电子科技大学出版社	320	5606	8	2022-04-06	/book/a39f5c6c-d37c-4213-8e3a-486b37db6f449787560662329.jpg	本书主要内容包括：电路的基本概念和基本定律、电阻电路的分析、电路定理、动态电路的时域分析、正弦稳态电路的分析、三相电路、耦合电感和变压器的分析、电路的频率响应、动态电路的复频域分析、双口网络、非线性电路简介、仿真软件Multisim及MATLAB在电路分析中的应用。书后还附有习题答案，读者可通过扫描二维码获得。 本书是按照电路理论的教学要求精心编写而成的， 重点突出、条理清晰、论述细致、可读性强。本书适合高等院校电气类、自动化类、电子信息类、 通信工程类以及机器人等专业的学生使用，也适合其他工科专业的学生使用。本书还可作为工程技术人员以及高等院校教师的参考书。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	335
1852	高质量发展背景下的中国特色建筑创作：雄安新区建筑设计征集作品集	978-7-5618-6947-5	9787561869475	河北雄安新区规划研究中心 	0	1-1	12开	298.00	610.0千字	天津大学出版社	412	\N	\N	2021-11-01	/book/d779d879-6dcf-49db-8f32-24488d974f591086559.jpg	本书将“高质量发展背景下中国特色的雄安建筑设计竞赛”获奖作品集结成册，包括从6大建筑类型总计700个作品中优选出的131个获奖作品，为起步区的规划建设工作提供值得参鉴的优秀设计案例。本书总计4个章节：第1章主要介绍竞赛背景及要求；第2章主要介绍竞赛作品征集、初评终评等历程，让读者了解本次竞赛全貌；第3章为获奖作品汇编，展示各建筑功能类型中公众组和专业组一、二、三等奖的深化设计方案及设计说明、获奖团队介绍；第4章着重在明确雄安规划要求和地域特征的基础上，基于本次竞赛的成果，对未来雄安新时代城市风貌的塑造进行展望。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	189
1844	电机与电力拖动	9787560663944	\N	王志勇 	0	1-1	16开	49.00	450.0千字	西安电子科技大学出版社	304	5606	8	2022-04-12	/book/239ad5be-0ffc-442a-960e-151d968ea2201086499.png	本书是在河北省一流课程“电机与电力拖动”建设期间编写的适合电气工程及其自动化、自动化等专业的基础课教材， 内容包括电机原理、电力拖动和控制电机等， 既满足电气工程及其自动化专业后续专业课对同步电机和变压器等基础知识的需要， 又兼顾到自动化专业对电力拖动知识的需求。本书分为8章， 分别讲述了直流电机及电力拖动、异步电动机及电力拖动、电动机的选择、同步发电机的原理及特性、交流绕组的结构和原理、典型控制电机的原理和应用等内容。各章节设有内容导学、知识目标、能力目标、小结和思考与练习， 便于教师组织教学和学生自学， 也便于进行过程化考核；例题讲解视频和课程思政元素通过二维码链接给出；此外， 书末还附有两套试卷及答案。 本书可以作为电气类专业学生学习电机与电力拖动的教材， 也可以为相关行业的工程技术人员提供参考。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	385
1845	中国经典童谣诵读100首	9787560652924	\N	王宜振 	平装	1-1	16开	36.00	\N	西安电子科技大学出版社	\N	\N	\N	2019-04-01	/book/f03ecef8-bf1e-40b4-8543-729eb82d36881086524.jpg	读诗那么重要，可又怎样去读呢？我以为，晨诵是读诗的重要环节。为了编选可供学前儿童及小学生阅读的童谣晨诵读本，我们特聘我国著名儿童诗诗人、童诗教育传记王宜振先生担纲主编，组织了由小学著名阅读推广专家、小学语文教育专家、小学语文学科名师、小学特级教师在内的数十人的编辑队伍，编辑了《中国经典童谣诵读100首》，该诗集收入了著名诗人艾青、叶圣陶、冰心、郭沫若、曾卓、臧克家、柯岩、任溶溶、金波、樊发稼、郭风、圣野、高洪波、、张继楼、、林焕彰、谢武彰、李少白、张秋生、王宜振、王立春、安武林、谭旭东、徐鲁、邱易东等近百人诗作。该诗集体现了选家的眼光，体现了童诗的思想美、意境美、音乐美、建筑美、语言美和哲理美的美学价值。它不仅能进行知识的积累，更能直接为心灵输送养分，供生命更具生命的活力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	946
1846	专家讲述生殖的秘密——孕力十足	9787565925542	\N	乔杰 李蓉 主编 	0	1-1	16开	80.00	206.0千字	北京大学医学出版社	244	\N	\N	2021-12-01	/book/d30f439b-b375-4e9d-b47c-b214fd5f8dd91086529.jpg	生育健康是许多家庭都会遇到的问题，生殖医学的进步为无数家庭提供了帮助。为了能在诊疗工作之外，为有生育要求的家庭提供医学科普和健康指导，更好地促进人民的生育健康，北京大学第三医院生殖医学中心的专家编写了这套“专家讲述生殖的秘密”科普丛书。本套丛书为国家出版基金项目，编者全部来自一线生殖医学专家，希望用最简单平朴的语言，深入浅出地将人们最关注的生育相关问题进行解答。语言追求生动有趣，医学知识追求专业易懂，内容构造追求全面详细。本册为其生育力保护相关分册，从生育力定义、评估方式、影响因素、保护手段、相关法规等方面进行讲述，以期帮助大家更好地了解生育力、保护生育力。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	101
1847	广东省哲学社会科学优秀成果精选集（第三辑）	978-7-306-07143-9	\N	张知干 主编 	软精装	1-1	特16开	68.00	280.0千字	中山大学出版社	232	\N	\N	2021-10-01	/book/3a35d3a0-0f39-41a3-9fc2-3de26d91eb1d1086537.jpg	广东省哲学社会科学优秀成果奖，是广东省社科领域的最高奖项，代表广东社科研究的最新和最高水平。本书收录了第八届广东省哲学社会科学优秀成果奖获奖作品，通过介绍精选成果的核心内容和思想精华，以展示广东省哲学社会科学研究所取得的学术成就，为推动广东哲学社会科学事业繁荣发展提供价值材料。希望全省广大社科工作者要以获奖者为榜样，深入学习习近平新时代中国特色社会主义思想，坚持正确政治方向和学术导向，努力提升哲学社会科学研究水平，占领哲学社会科学研究的学术高地，做好党委政府的“思想库”“智囊团”。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	852
1858	铁道机车车辆无损检测技术与应用	9787564386047	\N	刘宏利、房楠、朱慧勇 	0	1-1	16开	49.80	360.0千字	西南交通大学出版社	\N	\N	\N	2022-02-01	/book/dddd4e26-71b1-4d36-9573-a26d4519e85f1086590.jpg	本书为无损检测专业通用教材。教材内容包括磁粉、超声、涡流、渗透、目视、射线等常规检测技术的基础知识、原理、检测方法及技术应用实例，还介绍了无损检测新技术，反映无损检测领域的最新动态。本书为模块化、项目化结构，采用任务驱动的教学模式编写，通过任务提出、相关知识及任务实施过程，实现工学结合、理实一体。教材设置“拓展知识”板块，为无损检测爱好者提供更深层的学习途径；知识风暴的闯关答题，帮助教师了解对学生重点知识学习的掌握程度。同时教材配置了丰富的微课视频、动画等数字化教学资源，为活页式教材开发提供有力支撑。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	118
1849	刑法总论前沿问题研究	978-7-5620-9914-7	\N	王平 主编 	平装	1-1	大32开	79.00	\N	中国政法大学出版社	\N	\N	\N	2021-11-01	/book/37d6b555-2971-4485-b289-858cc2bdfe591086546.png	本书以为，中国传统“四要件”犯罪论体系虽有诸多优势，但“一少一多”是其主要不足。“一少”是指中国传统犯罪论体系没有“有责性”或“责任阻却事由”的专门位置；“一多”是指中国传统犯罪论体系给所谓的“刑事责任”安排了一个专门的章节。本书在弥补这些不足的基础上采用两大阶层四个步骤的犯罪论体系。两大阶层是指犯罪构成要件阶层、犯罪阻却事由阶层。犯罪构成要件阶层包括客观构成要件和主观构成要件，犯罪阻却事由阶层包括违法阻却事由和责任阻却事由，从而在整体上形成认定犯罪的四个步骤。两大阶层四个步骤的犯罪论体系，既考虑到中国传统犯罪构成包括客观要件和主观要件的现实，又吸纳了德日阶层体系的精髓，在犯罪阻却事由部分加入了责任阻却事由，从而使传统与现代有机融合，以期顺利实现中国传统犯罪论体系的创造性转化。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	116
1851	我国反就业歧视法实施机制构建研究	978-7-5764-0194-3	\N	王显勇 著 	平装	1-1	大32开	49.00	\N	中国政法大学出版社	\N	\N	\N	2021-12-01	/book/2712c3e3-176c-45b2-b022-3df7a92a64e91086552.jpg	本书构建反就业歧视法的多元综合实施理论，系统研究反就业歧视法的行政实施机制、社会实施机制、司法实施机制，类型化比较分析各国或地区反就业歧视法律制度的实施模式，从原理上阐释反就业歧视法多元综合实施机制，破解反就业歧视法的理论难题，破解反就业歧视法的实施困境，为构建我国反就业歧视法实施机制提供诸多完善建议了解详情请至新书推荐|《我国反就业歧视法实施机制构建研究》。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	530
1856	纳税检查	9787563831753	\N	张春平 	0	1-1	16开	58.00	418.0千字	首都经济贸易大学出版社	396	\N	\N	2022-04-01	/book/6a65cf0d-220e-4490-a54a-9483072e1d4c1086579.jpg	本书从纳税检查该书理论出发，首先介绍纳税检查的理论方法，由于现在企业几乎均实行电算化，故本书也引入了单子查账方法。其次，从单一税种介绍纳税检查的方法、原理以及实务中的检查问题。最后，本书介绍了纳税检查中难度较大的业务领域。本书结合税收实务中关注的焦点问题，一方面，使本书体系更加丰富，内容从整体上更加生动和立体；另一方面，使理论部分的内容更加贴近实务，具有更强的可操作性。作者结合多年的实务经验，将纳税检查理论方法与实务案例、实务问题进行结合，搭建起征收与征管之间的桥梁，为读者提供系统的纳税检查体系，既具备理论性，又兼备实务性，充分体现了纳税检查中知识运用的综合性、分析思维的发散性、解决方案的非唯一性三个显著特征。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	423
1857	财务决策实验教程（第三版）	9787563833375	\N	李艳 赵燕 龙凤好 	平装	1-1	16开	45.00	420.0千字	首都经济贸易大学出版社	\N	\N	\N	2022-03-01	/book/e12edf49-8724-467f-996e-2c76087af0b91086584.jpg	财务决策实验教程是针对财务决策软件平台专门设计的，依据“强化基础、提升技能、突出综合应用”的思路，以财务管理等岗位所需核心能力为出发点精心设计教材内容。 本教材内容包括四部分组成：平台介绍篇、平台设置篇、实战操作篇、税务稽查篇。平台介绍篇主要介绍财务决策平台的特点；平台设置篇主要介绍平台运行前的准备工作；实战操作篇是教材的核心，围绕企业财务管理和日常业务核算两个核心环节，通过对真实企业的仿真模拟，根据系统设计的运营、财务总监、财务经理、会计、出纳五个角色，采用人机对抗方式展开企业生产运营活动，针对每个典型的业务活动给出了具体的操作方法。税务稽查篇主要介绍税务稽查方法和要点。 本教材主要的特点：其一是逻辑性、整体性强，教材选取一家工业企业为案例，按照实际业务流程为主线，将企业一个月的生产运营活动贯穿始终。其二是内容详实，拓展性强。在设计企业业务时，我们尽量将平台的大部分功能运用于企业实际业务之中，有些功能不能在同一业务中同时运用时，采用“拓展领域”的方式呈现出来。其三操作性强，教材内容实用、图文并茂、简单易学，力求指导学生边学边做，有利于培养学生的应用能力。 本教材可以作为高校财务管理、会计等专业的财务决策平台实验指导书，也可以作为财务决策平台的培训教材。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	685
1860	精准技能帮扶理论与实践研究	9787564385705	\N	罗德超 张雅婷 廖小磊 李杨 	0	1-1	16开	45.00	144.0千字	西南交通大学出版社	160	\N	\N	2021-12-01	/book/52ebc158-e5a9-49e8-af93-9c264a891eef1086597.jpg	本书通过对不同地区经济发展、产业发展、技能人才培养现状的研判，开展多主体、多角度、多层次的精准技能帮扶研究，构建了专业建设帮扶、师资队伍帮建、技能培训提升、精准三扶等四类帮扶模式。主要内容包括对口帮扶地区主要模式和典型案例，开展技能帮扶实施效果调查分析，困难与制约因素分析，对口帮扶地区的模式优化对策以及服务乡村振兴战略的系列举措。本书主要研究成果有利于巩固拓展困难地区脱贫攻坚成果，全面助力实施乡村振兴战略，加强防止返贫的可持续帮扶，提供可借鉴、可推广的系列成果；为有关政府部门及相关单位进一步完善乡村振兴政策与举措提供实证参考依据；有利于形成一套可操作的技能教育与职业理念和技术体系。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	148
1861	统编小学语文教科书南山名师教学设计/（一年级　上册）（一年级　下册）	9787564384876	\N	高乃松 总主编一年级上册 李晓艳 编著一年级下册 谭方 编著 	0	1-1	16开	98.00	906.0千字	西南交通大学出版社	612	\N	\N	2021-12-01	/book/32de0140-a2d5-40b1-8039-e12af35abf6d1086599.jpg	本书是关于小学一年级统编语文教科书的教学设计，力求在凸显统编教材编写理念的基础上，展示鲜明的南山特色与教学亮点。“一年级上册”教学的对象是刚刚进入小学的孩子，内容包含识字、汉语拼音、课文、语文园地以及整本书阅读的教学设计，注重直观性与趣味性，体现了对一年级小朋友的关照和体贴；注重教学过程的实操性，板块清晰，流程细致，对教师教学有很好的提示和指导性。“一年级下册”包含了统编教材一年级下册八个单元共57篇教学设计，包含识字、课文、口语交际、写话、语文园地、整本书阅读等多个版块，每一课教学设计都力求做到充分体现“语文要素”的落实，充分体现“以学为本”的意识，充分体现“语言训练”的主线，充分体现“教学价值”的兑现。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	949
1862	烹饪工艺（第2版）（智媒体版）	9787564383480	\N	周世中 	0	2-13	16开	52.00	340.0千字	西南交通大学出版社	256	\N	\N	2021-11-01	/book/f458a827-441e-45e6-b3d0-6f89e0bbed451086604.jpg	本书为高等职业教育烹饪专业教材，在第一版的基础上，结合新时代烹饪技术的最新发展和烹饪专业教学的要求，全面、系统地介绍了烹饪工艺的相关理论和知识，具体内容涉及烹饪工艺的基础知识、烹饪技术技巧、烹饪操作流程以及各种菜肴、汤料的具体烹制调制方法等。本书配有丰富的信息化资源，更具象地呈现了烹饪技能、烹饪操作过程，充分体现了教材“实用”“够用”还“好用”的特点。本书也可供社会办学、企事业单位等培养培训高技能烹饪人才使用。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	159
88	行政决策新论	9787565135095	\N	钱再见 	0	1-1	0	39.00	241.0千字	南京师范大学出版社有限责任公司	220	\N	42	2018-10-01	/book/fbbd6758-07b8-472b-96e2-53f94e8df8fa9787565135095.jpg	　　《行政决策新论》力争在前人已有研究的学术积累基础上，围绕国家大政方针和政府行政管理活动的新动向，结合中国的现实国情，优化编撰体系，着力将近年来行政决策中的一些新议题融入进来。 　　在体例上，《行政决策新论》立足于使用效果，在每一章节末对核心概念进行了梳理，并提供相关思考题和建议进一步阅读的材料，以便读者在初步阅读和课堂教学的基础上不断拓宽视野和拓展思考空间。 　　《行政决策新论》从知识积累的角度出发，力争为行政决策科学的发展提供可能的知识增量。 　　希望使用《行政决策新论》的本专业学生，还是从事行政决策活动的实践者，都能从中获得对行政决策的理解与实践的有益启发。	0	2023-01-22 19:27:11	2023-02-26 14:05:35	0	284
\.


--
-- Data for Name: tb_textbook_feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_textbook_feedback (id, student_id, textbook_id, images, message, create_time, update_time, is_deleted) FROM stdin;
1	13	1742	/upload/e5e9c74210f0453ca4e99ab7247ccc3c-qwe.jpg	这书很好！！！	2023-02-21 11:52:03	2023-02-26 13:55:18	0
2	12	1742	/upload/e5e9c74210f0453ca4e99ab7247ccc3c-qwe.jpg	这书很好！！！	2023-02-21 11:57:21	2023-02-26 13:55:18	0
6	2	1742	/upload/e5e9c74210f0453ca4e99ab7247ccc3c-qwe.jpg	非常好	2023-02-21 21:36:02	2023-02-26 13:55:18	0
8	11	1742	/upload/e5e9c74210f0453ca4e99ab7247ccc3c-qwe.jpg	这书很好！！！	2023-02-26 15:14:35	2023-02-26 15:14:35	0
9	10	1742	/upload/e5e9c74210f0453ca4e99ab7247ccc3c-qwe.jpg	这书很好！！！	2023-02-26 15:14:51	2023-02-26 15:14:51	0
\.


--
-- Data for Name: tb_textbook_order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_textbook_order (id, textbook_id, supplier_id, state, create_time, update_time, is_deleted) FROM stdin;
\.


--
-- Data for Name: tb_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_user (id, account, password, phone_number, teaching_group_id, secondary_college_id, name, icon, state, create_time, update_time, is_deleted, grade_id, introduction) FROM stdin;
3	banUser	207acd61a3c1bd506d7e9a4535359f8a	17605021234	\N	\N	封禁账号	/icons/default-icon.png	1	2023-02-20 14:07:01	2023-02-20 17:06:45	0	\N	bbb
2	test	207acd61a3c1bd506d7e9a4535359f8a	17612341234	8	1	测试账号	/icons/default-icon.png	0	2023-02-20 10:31:33	2023-02-21 06:25:55	0	\N	aaa
14	teacher1	207acd61a3c1bd506d7e9a4535359f8a	\N	\N	\N	教师	/icons/icon1.jpg	0	2023-02-24 13:52:21	2023-02-24 13:52:21	0	\N	\N
4	student1	207acd61a3c1bd506d7e9a4535359f8a	\N	\N	\N	学生1	/icons/user5-icon.png	0	2023-02-21 14:24:22	2023-02-24 16:06:54	0	1	please set introduction
12	student9	207acd61a3c1bd506d7e9a4535359f8a	\N	\N	\N	学生9	/icons/user5-icon.png	0	2023-02-21 14:24:22	2023-02-24 16:06:54	0	1	please set introduction
6	student3	207acd61a3c1bd506d7e9a4535359f8a	\N	\N	\N	学生3	/icons/user5-icon.png	0	2023-02-21 14:24:22	2023-02-24 16:06:54	0	1	please set introduction
5	student2	207acd61a3c1bd506d7e9a4535359f8a	\N	\N	\N	学生2	/icons/user5-icon.png	0	2023-02-21 14:24:22	2023-02-24 16:06:54	0	1	please set introduction
7	student4	207acd61a3c1bd506d7e9a4535359f8a	\N	\N	\N	学生4	/icons/user5-icon.png	0	2023-02-21 14:24:22	2023-02-24 16:06:54	0	1	please set introduction
9	student6	207acd61a3c1bd506d7e9a4535359f8a	\N	\N	\N	学生6	/icons/user5-icon.png	0	2023-02-21 14:24:22	2023-02-24 16:06:54	0	1	please set introduction
13	student10	207acd61a3c1bd506d7e9a4535359f8a	\N	\N	\N	学生10	/icons/user5-icon.png	0	2023-02-21 14:24:22	2023-02-24 16:06:54	0	1	please set introduction
10	student7	207acd61a3c1bd506d7e9a4535359f8a	\N	\N	\N	学生7	/icons/user5-icon.png	0	2023-02-21 14:24:22	2023-02-24 16:06:54	0	1	please set introduction
8	student5	207acd61a3c1bd506d7e9a4535359f8a	\N	\N	\N	学生5	/icons/user5-icon.png	0	2023-02-21 14:24:22	2023-02-24 16:06:54	0	1	please set introduction
11	student8	207acd61a3c1bd506d7e9a4535359f8a	\N	\N	\N	学生8	/icons/user5-icon.png	0	2023-02-21 14:24:22	2023-02-24 16:06:54	0	1	please set introduction
\.


--
-- Data for Name: tb_user_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_user_info (id, user_faculty_id, sex, birthday, address, email, create_time, update_time, is_deleted) FROM stdin;
\.


--
-- Data for Name: tb_user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_user_role (id, user_id, role_id, create_time, update_time, is_deleted) FROM stdin;
1	2	1	2023-02-24 13:51:08	2023-02-24 13:51:08	0
2	3	1	2023-02-24 13:51:08	2023-02-24 13:51:08	0
3	14	1	2023-02-24 13:52:35	2023-02-24 13:58:01	0
4	4	2	2023-03-01 17:39:24	2023-03-01 17:39:24	0
\.


--
-- Name: tb_approval_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_approval_id_seq', 17, true);


--
-- Name: tb_faculty_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_faculty_info_id_seq', 1, false);


--
-- Name: tb_faculty_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_faculty_role_id_seq', 4, true);


--
-- Name: tb_grade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_grade_id_seq', 2, true);


--
-- Name: tb_login_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_login_log_id_seq', 14, true);


--
-- Name: tb_major_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_major_id_seq', 19, true);


--
-- Name: tb_opening_plan_detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_opening_plan_detail_id_seq', 22, true);


--
-- Name: tb_opening_plan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_opening_plan_id_seq', 13, true);


--
-- Name: tb_operate_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_operate_log_id_seq', 43, true);


--
-- Name: tb_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_permission_id_seq', 32, true);


--
-- Name: tb_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_role_id_seq', 2, true);


--
-- Name: tb_role_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_role_permission_id_seq', 28, true);


--
-- Name: tb_secondary_college_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_secondary_college_id_seq', 8, true);


--
-- Name: tb_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_supplier_id_seq', 19, true);


--
-- Name: tb_teaching_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_teaching_group_id_seq', 9, true);


--
-- Name: tb_textbook_feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_textbook_feedback_id_seq', 9, true);


--
-- Name: tb_textbook_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_textbook_order_id_seq', 1, false);


--
-- Name: tb_user_faculty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_user_faculty_id_seq', 14, true);


--
-- Name: textbook_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.textbook_id_seq', 1924, true);


--
-- Name: tb_approval tb_approval_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_approval
    ADD CONSTRAINT tb_approval_pkey PRIMARY KEY (id);


--
-- Name: tb_user_info tb_faculty_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_user_info
    ADD CONSTRAINT tb_faculty_info_pkey PRIMARY KEY (id);


--
-- Name: tb_user_role tb_faculty_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_user_role
    ADD CONSTRAINT tb_faculty_role_pkey PRIMARY KEY (id);


--
-- Name: tb_grade tb_grade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_grade
    ADD CONSTRAINT tb_grade_pkey PRIMARY KEY (id);


--
-- Name: tb_login_log tb_login_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_login_log
    ADD CONSTRAINT tb_login_log_pkey PRIMARY KEY (id);


--
-- Name: tb_major tb_major_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_major
    ADD CONSTRAINT tb_major_pkey PRIMARY KEY (id);


--
-- Name: tb_opening_plan_detail tb_opening_plan_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_opening_plan_detail
    ADD CONSTRAINT tb_opening_plan_detail_pkey PRIMARY KEY (id);


--
-- Name: tb_opening_plan tb_opening_plan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_opening_plan
    ADD CONSTRAINT tb_opening_plan_pkey PRIMARY KEY (id);


--
-- Name: tb_operate_log tb_operate_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_operate_log
    ADD CONSTRAINT tb_operate_log_pkey PRIMARY KEY (id);


--
-- Name: tb_permission tb_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_permission
    ADD CONSTRAINT tb_permission_pkey PRIMARY KEY (id);


--
-- Name: tb_role_permission tb_role_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_role_permission
    ADD CONSTRAINT tb_role_permission_pkey PRIMARY KEY (id);


--
-- Name: tb_role tb_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_role
    ADD CONSTRAINT tb_role_pkey PRIMARY KEY (id);


--
-- Name: tb_secondary_college tb_secondary_college_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_secondary_college
    ADD CONSTRAINT tb_secondary_college_pkey PRIMARY KEY (id);


--
-- Name: tb_supplier tb_supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_supplier
    ADD CONSTRAINT tb_supplier_pkey PRIMARY KEY (id);


--
-- Name: tb_teaching_group tb_teaching_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_teaching_group
    ADD CONSTRAINT tb_teaching_group_pkey PRIMARY KEY (id);


--
-- Name: tb_textbook_feedback tb_textbook_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_textbook_feedback
    ADD CONSTRAINT tb_textbook_feedback_pkey PRIMARY KEY (id);


--
-- Name: tb_textbook_order tb_textbook_order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_textbook_order
    ADD CONSTRAINT tb_textbook_order_pkey PRIMARY KEY (id);


--
-- Name: tb_user tb_user_faculty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_user
    ADD CONSTRAINT tb_user_faculty_pkey PRIMARY KEY (id);


--
-- Name: tb_textbook textbook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_textbook
    ADD CONSTRAINT textbook_pkey PRIMARY KEY (id);


--
-- Name: tb_approval auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_approval FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_grade auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_grade FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_login_log auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_login_log FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_major auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_major FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_opening_plan auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_opening_plan FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_opening_plan_detail auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_opening_plan_detail FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_operate_log auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_operate_log FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_permission auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_permission FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_role auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_role FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_role_permission auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_role_permission FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_secondary_college auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_secondary_college FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_supplier auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_supplier FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_teaching_group auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_teaching_group FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_textbook auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_textbook FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_textbook_feedback auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_textbook_feedback FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_textbook_order auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_textbook_order FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_user auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_user FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_user_info auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_user_info FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_user_role auto_update_time; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_update_time BEFORE UPDATE ON public.tb_user_role FOR EACH ROW EXECUTE FUNCTION public.auto_update_time_trigger();


--
-- Name: tb_opening_plan fk_grade_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_opening_plan
    ADD CONSTRAINT fk_grade_id FOREIGN KEY (grade_id) REFERENCES public.tb_grade(id);


--
-- Name: tb_user fk_grade_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_user
    ADD CONSTRAINT fk_grade_id FOREIGN KEY (grade_id) REFERENCES public.tb_grade(id);


--
-- Name: tb_grade fk_major_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_grade
    ADD CONSTRAINT fk_major_id FOREIGN KEY (major_id) REFERENCES public.tb_major(id);


--
-- Name: tb_approval fk_opening_plan_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_approval
    ADD CONSTRAINT fk_opening_plan_id FOREIGN KEY (opening_plan_id) REFERENCES public.tb_opening_plan(id);


--
-- Name: tb_opening_plan_detail fk_opening_plan_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_opening_plan_detail
    ADD CONSTRAINT fk_opening_plan_id FOREIGN KEY (opening_plan_id) REFERENCES public.tb_opening_plan(id);


--
-- Name: tb_role_permission fk_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_role_permission
    ADD CONSTRAINT fk_permission_id FOREIGN KEY (permission_id) REFERENCES public.tb_permission(id);


--
-- Name: tb_role_permission fk_role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_role_permission
    ADD CONSTRAINT fk_role_id FOREIGN KEY (role_id) REFERENCES public.tb_role(id);


--
-- Name: tb_user_role fk_role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_user_role
    ADD CONSTRAINT fk_role_id FOREIGN KEY (role_id) REFERENCES public.tb_role(id);


--
-- Name: tb_user fk_secondary_college_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_user
    ADD CONSTRAINT fk_secondary_college_id FOREIGN KEY (secondary_college_id) REFERENCES public.tb_secondary_college(id);


--
-- Name: tb_major fk_secondary_college_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_major
    ADD CONSTRAINT fk_secondary_college_id FOREIGN KEY (secondary_college_id) REFERENCES public.tb_secondary_college(id);


--
-- Name: tb_opening_plan fk_secondary_college_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_opening_plan
    ADD CONSTRAINT fk_secondary_college_id FOREIGN KEY (secondary_college_id) REFERENCES public.tb_secondary_college(id);


--
-- Name: tb_textbook_order fk_supplier_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_textbook_order
    ADD CONSTRAINT fk_supplier_id FOREIGN KEY (supplier_id) REFERENCES public.tb_supplier(id);


--
-- Name: tb_opening_plan fk_teacher_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_opening_plan
    ADD CONSTRAINT fk_teacher_id FOREIGN KEY (teacher_id) REFERENCES public.tb_user(id);


--
-- Name: tb_user fk_teaching_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_user
    ADD CONSTRAINT fk_teaching_group_id FOREIGN KEY (teaching_group_id) REFERENCES public.tb_teaching_group(id);


--
-- Name: tb_opening_plan fk_teaching_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_opening_plan
    ADD CONSTRAINT fk_teaching_group_id FOREIGN KEY (teaching_group_id) REFERENCES public.tb_teaching_group(id);


--
-- Name: tb_textbook_feedback fk_textbook_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_textbook_feedback
    ADD CONSTRAINT fk_textbook_id FOREIGN KEY (textbook_id) REFERENCES public.tb_textbook(id);


--
-- Name: tb_textbook_order fk_textbook_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_textbook_order
    ADD CONSTRAINT fk_textbook_id FOREIGN KEY (textbook_id) REFERENCES public.tb_textbook(id);


--
-- Name: tb_user_info fk_user_faculty_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_user_info
    ADD CONSTRAINT fk_user_faculty_id FOREIGN KEY (user_faculty_id) REFERENCES public.tb_user(id);


--
-- Name: tb_user_role fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_user_role
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.tb_user(id);


--
-- Name: tb_textbook_feedback fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_textbook_feedback
    ADD CONSTRAINT fk_user_id FOREIGN KEY (student_id) REFERENCES public.tb_user(id);


--
-- PostgreSQL database dump complete
--

