-- select-training.sql
-- [ZADANIE 4] Select training. Uruchamiac po table-schema.sql i insert-data.sql.

-- 1. Login i email wszystkich uzytkownikow, alfabetycznie po loginie
SELECT login, email
FROM users
ORDER BY login;

-- 2. Tytuly i statusy zadan zakonczonych (status = 'done')
SELECT title, status
FROM tasks
WHERE status = 'done';

-- 3. Liczba zadan w kazdym statusie, od najwiekszej liczby
SELECT status, COUNT(*) AS liczba_zadan
FROM tasks
GROUP BY status
ORDER BY liczba_zadan DESC;

-- 4. Tytul kazdego zadania oraz login jego autora
-- (w naszej tabeli kolumna nazywa sie user_id)
SELECT t.title, u.login
FROM tasks t
JOIN users u ON u.id = t.user_id
ORDER BY t.id;
