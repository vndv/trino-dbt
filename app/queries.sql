-- Создание схемы (если не существует)
CREATE SCHEMA IF NOT EXISTS example_db;

-- Создание таблицы
CREATE TABLE example_db.users (
    id INTEGER,
    name VARCHAR(50),
    age INTEGER,
    registration_date DATE
)
WITH (
    format = 'PARQUET'           
);


INSERT INTO example_db.users (id, name, age, registration_date) 
VALUES 
    (1, 'Иван Петров', 28, DATE '2023-10-15'),
    (2, 'Мария Сидорова', 32, DATE '2023-09-22'),
    (3, 'Алексей Иванов', 25, DATE '2023-11-05');
    
INSERT INTO example_db.users (id, name, age, registration_date) 
VALUES 
    (4, 'Иван Иванов', 24, DATE '2023-01-15');