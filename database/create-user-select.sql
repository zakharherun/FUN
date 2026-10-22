-- create-user-select.sql
-- [ZADANIE] Administracja DB - roles: uzytkownik z uprawnieniami tylko do SELECT.
-- Uruchamiac jako postgres, na bazie "taskmanager-db" (po table-schema.sql).
-- Haslo ponizej to haslo testowe z zadania - w prawdziwym projekcie nalezy je zmienic.
-- Jesli rola juz istnieje (ponowne uruchomienie), najpierw:
--   REASSIGN OWNED BY userek TO postgres; DROP OWNED BY userek; DROP ROLE userek;

CREATE ROLE userek LOGIN PASSWORD 'P@ssW0rD';

-- Nazwa bazy zawiera myslnik, dlatego musi byc w cudzyslowie.
GRANT CONNECT ON DATABASE "taskmanager-db" TO userek;
GRANT USAGE ON SCHEMA public TO userek;

-- Tylko odczyt (SELECT) - brak INSERT / UPDATE / DELETE.
GRANT SELECT ON users, tasks, comments TO userek;
