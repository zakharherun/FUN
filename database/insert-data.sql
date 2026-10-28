-- insert-data.sql
-- Dane testowe (wylacznie fikcyjne): po 5 lub wiecej rekordow w kazdej tabeli.
-- Uruchamiac PO table-schema.sql, na pustych tabelach:
--   psql -U postgres -d taskmanager-db -f insert-data.sql
--
-- Nie podajemy id ani created_at - baza wypelnia je sama.
-- Klucze obce: tasks.user_id -> users.id, comments.task_id -> tasks.id,
-- comments.user_id -> users.id. Tabele wypelniamy w kolejnosci:
-- users -> tasks -> comments.
--
-- Klucze obce NIE sa wpisywane recznie (liczbami). Kazde id jest pobierane
-- podzapytaniem z tabeli nadrzednej:
--   user_id -> (SELECT id FROM users WHERE login = '...')
--   task_id -> (SELECT id FROM tasks WHERE title = '...')
-- Dzieki temu skrypt dziala niezaleznie od tego, jakie id nadala baza.
-- Literowka w loginie lub tytule da blad NOT NULL zamiast blednego powiazania.
--
-- Jesli tabele mialy juz dane, wyczysc je:
--   TRUNCATE comments, tasks, users RESTART IDENTITY;

-- 1. USERS
INSERT INTO users (login, email, password_hash, role) VALUES
    ('admin', 'admin@example.com', 'hash-placeholder-1', 'admin'),
    ('anna',  'anna@example.com',  'hash-placeholder-2', 'user'),
    ('piotr', 'piotr@example.com', 'hash-placeholder-3', 'user'),
    ('kasia', 'kasia@example.com', 'hash-placeholder-4', 'user'),
    ('marek', 'marek@example.com', 'hash-placeholder-5', 'user');

SELECT * FROM users ORDER BY id;

-- 2. TASKS: autor zadania (user_id) pobierany z tabeli users po loginie
INSERT INTO tasks (title, description, status, user_id) VALUES
    ('Przygotować makietę',      'Ekran listy i formularza',           'done',
        (SELECT id FROM users WHERE login = 'anna')),
    ('Utworzyć tabele',          'Users, Tasks, Comments',             'in_progress',
        (SELECT id FROM users WHERE login = 'anna')),
    ('Napisać README',           NULL,                                 'new',
        (SELECT id FROM users WHERE login = 'piotr')),
    ('Skonfigurować CI',         'Workflow dla frontendu',             'done',
        (SELECT id FROM users WHERE login = 'admin')),
    ('Dodać filtrowanie',        'Po tytule i statusie',               'new',
        (SELECT id FROM users WHERE login = 'piotr')),
    ('Zaprojektować logo',       'Prosty znak aplikacji',              'in_progress',
        (SELECT id FROM users WHERE login = 'kasia')),
    ('Przygotować dane testowe', 'Minimum 5 rekordów w każdej tabeli', 'new',
        (SELECT id FROM users WHERE login = 'marek'));

-- Sprawdzenie: kazde zadanie z loginem autora
SELECT t.id, t.title, t.status, u.login AS author
FROM tasks t
JOIN users u ON u.id = t.user_id
ORDER BY t.id;

-- 3. COMMENTS: zadanie (task_id) pobierane z tasks po tytule,
--    autor (user_id) pobierany z users po loginie
INSERT INTO comments (content, task_id, user_id) VALUES
    ('Makieta wygląda dobrze',
        (SELECT id FROM tasks WHERE title = 'Przygotować makietę'),
        (SELECT id FROM users WHERE login = 'anna')),
    ('Brakuje klucza obcego w tasks',
        (SELECT id FROM tasks WHERE title = 'Utworzyć tabele'),
        (SELECT id FROM users WHERE login = 'admin')),
    ('Poprawione, dzięki',
        (SELECT id FROM tasks WHERE title = 'Utworzyć tabele'),
        (SELECT id FROM users WHERE login = 'anna')),
    ('Zacznę od sekcji uruchomienia',
        (SELECT id FROM tasks WHERE title = 'Napisać README'),
        (SELECT id FROM users WHERE login = 'piotr')),
    ('CI działa poprawnie',
        (SELECT id FROM tasks WHERE title = 'Skonfigurować CI'),
        (SELECT id FROM users WHERE login = 'marek')),
    ('Można dodać też wyszukiwanie',
        (SELECT id FROM tasks WHERE title = 'Dodać filtrowanie'),
        (SELECT id FROM users WHERE login = 'kasia')),
    ('Logo w dwóch kolorach?',
        (SELECT id FROM tasks WHERE title = 'Zaprojektować logo'),
        (SELECT id FROM users WHERE login = 'admin')),
    ('Dane gotowe do sprawdzenia',
        (SELECT id FROM tasks WHERE title = 'Przygotować dane testowe'),
        (SELECT id FROM users WHERE login = 'marek'));

-- Sprawdzenie: komentarz, tytul zadania i login autora komentarza
SELECT c.id, c.content, t.title AS task, u.login AS author
FROM comments c
JOIN tasks t ON t.id = c.task_id
JOIN users u ON u.id = c.user_id
ORDER BY c.id;

-- Podsumowanie: liczba rekordow w tabelach (oczekiwane: 5 | 7 | 8)
SELECT (SELECT count(*) FROM users)    AS users,
       (SELECT count(*) FROM tasks)    AS tasks,
       (SELECT count(*) FROM comments) AS comments;
