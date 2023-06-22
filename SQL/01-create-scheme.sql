CREATE ROLE my_tools_sсheme_owner WITH LOGIN PASSWORD 'bp6X_knHq2';
GRANT my_tools_sсheme_owner TO my_tools_owner;

CREATE SCHEMA tools_api       AUTHORIZATION my_tools_owner;

CREATE ROLE my_tools_ta WITH LOGIN PASSWORD '6FsXDeF9a6';
GRANT my_tools_ta TO my_tools_sсheme_owner;

GRANT CONNECT ON DATABASE db_my_tools TO my_tools_ta;

GRANT CREATE ON SCHEMA tools_api       TO my_tools_ta;

GRANT USAGE ON SCHEMA tools_api       TO my_tools_ta;

GRANT ALL ON ALL TABLES IN SCHEMA tools_api       TO my_tools_ta;

ALTER DEFAULT PRIVILEGES FOR USER my_tools_sсheme_owner IN SCHEMA tools_api       GRANT USAGE ON SEQUENCES TO my_tools_ta;

ALTER DEFAULT PRIVILEGES FOR USER my_tools_sсheme_owner IN SCHEMA tools_api       GRANT EXECUTE ON FUNCTIONS TO my_tools_ta;