-- test-user-select.sql
-- Test uprawnien roli userek. Uruchamiaj KAZDE polecenie osobno
-- (zaznacz je myszka i F5 w Query Tool), bo po bledzie pgAdmin przerywa skrypt.

-- 1. Przelaczenie na uzytkownika userek (zamiast logowania na nowy serwer)
SET ROLE userek;
SELECT current_user;                 -- oczekiwane: userek

-- 2. Odczyt dziala
SELECT count(*) FROM tasks;          -- dziala
SELECT count(*) FROM comments;       -- dziala

-- 3. Proba INSERT - oczekiwany blad: permission denied for table tasks
INSERT INTO tasks (title, description, status, user_id)
VALUES ('Test uprawnień', 'Wpis dodany przez userek', 'new', 1);

-- (opcjonalnie) DELETE tez jest zablokowany: permission denied for table comments
-- DELETE FROM comments;

-- 4. Powrot do uzytkownika postgres
RESET ROLE;
SELECT current_user;                 -- oczekiwane: postgres

-- 5. Ten sam INSERT jako postgres - teraz dziala (INSERT 0 1)
INSERT INTO tasks (title, description, status, user_id)
VALUES ('Test uprawnień', 'Wpis dodany przez postgres', 'new', 1);

SELECT * FROM tasks ORDER BY id;

-- (opcjonalnie) sprzatanie po tescie:
-- DELETE FROM tasks WHERE title = 'Test uprawnień';
