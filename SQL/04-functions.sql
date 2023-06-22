--------------------------------------- SEARCH_PATH ---------------------------------------
set search_path = 'tools_api';

---------------------------------------- FUNCTIONS ----------------------------------------
do $$
declare
    l_schemas text[] = array['tools_api'];
    l_schema_name text;
    r record;
    l_max_version_id_dbms_api bigint;
BEGIN
    
SELECT max(version_id) INTO l_max_version_id_dbms_api FROM tools_api."version";

-- check version
if (select "version" from tools_api."version" v WHERE version_id = l_max_version_id_dbms_api) <> '0.0.2' then
    raise exception 'Текущая версия DBMS API (%) отличается от необходимой версии (%) для выполнения скрипта!', (select * from tools_api."version" v), '0.0.2' using errcode = '00001';
end if;

-- delete all functions/procedures in schema "tools_api"
foreach l_schema_name in array l_schemas loop
    -- функции & процедуры
    for r in (select oid, prokind from pg_proc where pronamespace = l_schema_name::regnamespace) loop
        execute 'drop ' || case r.prokind when 'f' then 'function' when 'p' then 'procedure' end || ' if exists ' || r.oid::regprocedure || ' cascade';
    end loop;
end loop;

CREATE OR REPLACE FUNCTION tools_api.ui_get_tools()
    RETURNS TABLE (
        tool_id_var bigint,
        name_var text,
        description_var text)
    LANGUAGE plpgsql
AS $function$
    BEGIN
        RETURN QUERY SELECT tool_id, name, description FROM tool;
    END;
$function$
    SET search_path = tools_api, pg_temp;

CREATE OR REPLACE FUNCTION tools_api.ui_get_constraint()
    RETURNS TABLE (
        type_id_var bigint,
        name_var text,
        value_var numeric,
        description_var text)
    LANGUAGE plpgsql
AS $function$
    BEGIN
        RETURN QUERY select constraint_id, concat(table_name, '.',field_name), field_length, description from length_constraint;
    END;
$function$
    SET search_path = tools_api, pg_temp;

end;
$$;