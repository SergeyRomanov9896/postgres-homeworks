-- 1. Создать таблицу student с полями student_id serial, first_name varchar, last_name varchar, birthday date, phone varchar
CREATE TABLE IF NOT EXISTS student (
student_id serial PRIMARY KEY,
first_name varchar,
last_name varchar,
birthday date,
phone varchar
);

-- 2. Добавить в таблицу student колонку middle_name varchar
ALTER TABLE student ADD COLUMN middle_name varchar;

-- 3. Удалить колонку middle_name
ALTER TABLE student DROP COLUMN middle_name;

-- 4. Переименовать колонку birthday в birth_date
ALTER TABLE department RENAME COLUMN birthday TO birth_date;

-- 5. Изменить тип данных колонки phone на varchar(32)
ALTER TABLE student ALTER COLUMN phone SET DATA TYPE varchar(32);

-- 6. Вставить три любых записи с автогенерацией идентификатора
INSERT INTO student (first_name, last_name, birthday, phone, middle_name)
VALUES ('Иван', 'Иванов', '2000-03-15', '+79123456789', 'Иванович');

INSERT INTO student (first_name, last_name, birthday, phone, middle_name)
VALUES ('Мария', 'Петрова', '1999-07-22', '+79234567890', 'Сергеевна');

INSERT INTO student (first_name, last_name, birthday, phone, middle_name)
VALUES ('Алексей', 'Сидоров', '2001-11-05', '+79345678901', 'Дмитриевич');

-- 7. Удалить все данные из таблицы со сбросом идентификатор в исходное состояние
TRUNCATE TABLE student RESTART IDENTITY;