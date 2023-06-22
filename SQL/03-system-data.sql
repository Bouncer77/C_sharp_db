--------------------------------------- SEARCH_PATH ---------------------------------------
set search_path = 'tool_api';

----------------------------------------- SYSTEM_DATA -----------------------------------------
do $$
declare
    l_constraint_name text;
    l_table_name text;
    l_constraint_row record;
begin

----------------------------------------- ВЕРСИОНИРОВАНИЕ -------------------------------------------------

INSERT INTO tools_api.version
	(version, description)
VALUES
    ('0.0.2', 'Тестовая версия 2');

----------------------------------------- СИСТЕМНЫЕ ДАННЫЕ -------------------------------------------------

INSERT INTO tools_api.tool
	(tool_id, name, description)
OVERRIDING SYSTEM VALUE
VALUES
	(1, 'Углошлифовальная машина Bosch GWS 9-125 S 0601396102', 'Описание болгарки (УШМ) Bosch'),
	(2, 'Перфоратор Bosch GBH 2-26 DFR 0.611.254.768', 'Перфоратор Bosch GBH 2-26 DFR 0.611.254.768 поставляется со сменным патроном. Используется для работы с бетоном, сталью и деревом. Отличается высокой скоростью сверления - 0-900 об/мин. Функционирует в трех режимах - сверление, долбление и ударное сверление. Патрон SDS-plus можно быстро и легко поменять на быстрозажимной.'),
    (3, 'Краскопульт EINHELL TC-SY 500 P 4260010', 'Краскопульт EINHELL TC-SY 500 P 4260010 - идеальный вариант для окрашивания небольших и средних помещений. Совместим с содержащими растворители и разбавляемыми водой эмалями, глазурями, лаками и красителями.')
;

INSERT INTO tools_api."user"
	(user_id, login, full_name, email, last_ip, is_active, create_date, change_date, last_login_date, session_id)
OVERRIDING SYSTEM VALUE
VALUES
	(0, 'system', 'system', '', '127.0.0.1', true, now(), now(), now(), '');


INSERT INTO tools_api.length_constraint
	(constraint_id, table_name, field_name, field_length, description)
VALUES
	(1, 'tool', 'name', 256, 'Наименование инструмента'),
	(2, 'tool', 'description', 10000, 'Описание инструмента')
;

-- применение правил ограничения длины полей
FOR l_constraint_row IN (SELECT table_name, field_name, field_length FROM tools_api.length_constraint) LOOP
    l_constraint_name := concat('length_constraint.', l_constraint_row.table_name, '.', l_constraint_row.field_name);
    l_table_name := concat('tools_api.', l_constraint_row.table_name);
    execute format('ALTER TABLE %s DROP constraint IF EXISTS "%s"', l_table_name, l_constraint_name);
    execute format('ALTER TABLE %s ADD CONSTRAINT "%s" CHECK(char_length(cast(%s as text)) <= %s);', l_table_name, l_constraint_name, l_constraint_row.field_name, l_constraint_row.field_length);
END LOOP;

end;
$$;