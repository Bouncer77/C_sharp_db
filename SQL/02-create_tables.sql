--------------------------------------- SEARCH_PATH ---------------------------------------
set search_path = 'tools_api';

----------------------------------------- CREATE TABLES -----------------------------------------
do $$
begin

----------------------------- VERSION -----------------------------

DROP TABLE IF EXISTS tools_api.version CASCADE;

CREATE TABLE tools_api.version (
	version_id bigint PRIMARY KEY GENERATED BY DEFAULT AS identity,
    version text UNIQUE not null,
    description text
);

-------------------------- DATA TYPE ---------------------------------------

DROP TABLE IF EXISTS tools_api.tool CASCADE;

CREATE TABLE tools_api.tool (
	tool_id bigint PRIMARY KEY GENERATED ALWAYS AS identity,
	name text NOT NULL,
	description text
	);

COMMENT ON TABLE tools_api.tool IS 'Инструмент';
COMMENT ON COLUMN tools_api.tool.tool_id IS 'Идентификатор инструмента';
COMMENT ON COLUMN tools_api.tool.name IS 'Наименование инструмента';
COMMENT ON COLUMN tools_api.tool.description IS 'Описание инструмента';

------------------------ USER -------------------------------------

DROP TABLE IF EXISTS tools_api.user CASCADE;

CREATE TABLE tools_api.user (
    user_id bigint PRIMARY KEY GENERATED ALWAYS AS identity (START WITH 100 INCREMENT BY 1),
    login text NOT NULL,
    full_name text,
    email text,
    last_ip inet,
    is_active boolean NOT NULL,
    create_date timestamp NOT NULL,
    change_date timestamp NOT NULL,
    last_login_date timestamp NOT NULL,
    session_id text
    );

COMMENT ON TABLE tools_api.user IS 'Пользователь';
COMMENT ON COLUMN tools_api.user.user_id IS 'Идентификатор пользователя';
COMMENT ON COLUMN tools_api.user.login IS 'Логин пользователя';
COMMENT ON COLUMN tools_api.user.full_name IS 'ФИО пользователя';
COMMENT ON COLUMN tools_api.user.email IS 'Адрес электронной почты';
COMMENT ON COLUMN tools_api.user.last_ip IS 'IP-адрес последнего входа';
COMMENT ON COLUMN tools_api.user.is_active IS 'Признак активности';
COMMENT ON COLUMN tools_api.user.create_date IS 'Дата создания';
COMMENT ON COLUMN tools_api.user.change_date IS 'Дата последнего изменения';
COMMENT ON COLUMN tools_api.user.last_login_date IS 'Дата последнего входа в систему';
COMMENT ON COLUMN tools_api.user.session_id IS 'Идентификатор сессии';


    
   -------------------- length_constraint ---------------------------------

DROP TABLE IF EXISTS tools_api.length_constraint CASCADE;

CREATE TABLE tools_api.length_constraint (
	constraint_id bigint PRIMARY KEY generated BY DEFAULT AS identity,
	table_name text NOT NULL,
	field_name text NOT NULL,
	field_length numeric NOT NULL,
	description text NOT NULL
	) ;

COMMENT ON TABLE tools_api.length_constraint IS 'Ограничения';
COMMENT ON COLUMN tools_api.length_constraint.constraint_id IS 'Идентификатор ограничения';
COMMENT ON COLUMN tools_api.length_constraint.table_name IS 'Наименование таблицы';
COMMENT ON COLUMN tools_api.length_constraint.field_name IS 'Наименование поля';
COMMENT ON COLUMN tools_api.length_constraint.field_length IS 'Максимальная длина поля (количестве символов)';
COMMENT ON COLUMN tools_api.length_constraint.description IS 'Описание ограничиваемого поля';

end;
$$;