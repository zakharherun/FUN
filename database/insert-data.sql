-- insert-data.sql
-- Dane testowe (wylacznie fikcyjne): po 5 lub wiecej rekordow w kazdej tabeli.
-- Uruchamiac PO table-schema.sql, na pustych tabelach:
--   psql -U postgres -d task_manager -f insert-data.sql
--
-- Nie podajemy id ani created_at - baza wypelnia je sama (id od 1).
-- Klucze obce: tasks.user_id -> users.id, comments.task_id -> tasks.id,
-- comments.user_id -> users.id. Wskazane id musza istniec, dlatego tabele
-- wypelniamy w kolejnosci: users -> tasks -> comments.
--
-- Jesli tabele mialy juz dane (id nie zaczynaja sie od 1), wyczysc je:
--   TRUNCATE comments, tasks, users RESTART IDENTITY;

-- 1. USERS (id 1-5)
INSERT INTO users (login, email, password_hash, role) VALUES
    ('admin', 'admin@example.com', 'hash-placeholder-1', 'admin'),
    ('anna',  'anna@example.com',  'hash-placeholder-2', 'user'),
    ('piotr', 'piotr@example.com', 'hash-placeholder-3', 'user'),
    ('kasia', 'kasia@example.com', 'hash-placeholder-4', 'user'),
    ('marek', 'marek@example.com', 'hash-placeholder-5', 'user');

-- Sprawdz, czy uzytkownicy o id 1-5 istnieja (wymagane przez klucze obce nizej)
SELECT * FROM users ORDER BY id;

-- 2. TASKS (id 1-7), user_id musi istniec w users
INSERT INTO tasks (title, description, status, user_id) VALUES
    ('Przygotować makietę',        'Ekran listy i formularza',             'done',        2),
    ('Utworzyć tabele',            'Users, Tasks, Comments',               'in_progress', 2),
    ('Napisać README',             NULL,                                   'new',         3),
    ('Skonfigurować CI',           'Workflow dla frontendu',               'done',        1),
    ('Dodać filtrowanie',          'Po tytule i statusie',                 'new',         3),
    ('Zaprojektować logo',         'Prosty znak aplikacji',                'in_progress', 4),
    ('Przygotować dane testowe',   'Minimum 5 rekordów w każdej tabeli',   'new',         5);

-- Sprawdz, czy zadania o id 1-7 istnieja (wymagane przez comments.task_id)
SELECT * FROM tasks ORDER BY id;

-- 3. COMMENTS (id 1-8): (content, task_id, user_id)
-- task_id musi istniec w tasks, user_id musi istniec w users
INSERT INTO comments (content, task_id, user_id) VALUES
    ('Makieta wygląda dobrze',           1, 2),
    ('Brakuje klucza obcego w tasks',    2, 1),
    ('Poprawione, dzięki',               2, 2),
    ('Zacznę od sekcji uruchomienia',    3, 3),
    ('CI działa poprawnie',              4, 5),
    ('Można dodać też wyszukiwanie',     5, 4),
    ('Logo w dwóch kolorach?',           6, 1),
    ('Dane gotowe do sprawdzenia',       7, 5);

SELECT * FROM comments ORDER BY id;

-- Podsumowanie: liczba rekordow w tabelach (oczekiwane: 5 | 7 | 8)
SELECT (SELECT count(*) FROM users)    AS users,
       (SELECT count(*) FROM tasks)    AS tasks,
       (SELECT count(*) FROM comments) AS comments;
