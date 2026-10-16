-- table-schema.sql
-- Skrypt tworzacy tabele bazy task_manager (PostgreSQL) na podstawie diagramu ERD:
--   users    (id, login, email, password_hash, role, created_at)
--   tasks    (id, title, description, status, created_at, user_id -> users.id)
--   comments (id, content, created_at, task_id -> tasks.id, user_id -> users.id)
--
-- Kolejnosc ma znaczenie: klucz obcy moze wskazywac tylko tabele, ktora juz istnieje.
-- Uruchamiac na PUSTEJ bazie:
--   psql -U postgres -d task_manager -f table-schema.sql

CREATE TABLE users (
    id            INT GENERATED ALWAYS AS IDENTITY
                  PRIMARY KEY,
    login         VARCHAR(50)  NOT NULL UNIQUE,
    email         VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role          VARCHAR(20)  NOT NULL DEFAULT 'user'
                  CHECK (role IN ('user', 'admin')),
    created_at    TIMESTAMP    NOT NULL DEFAULT now()
);

CREATE TABLE tasks (
    id          INT GENERATED ALWAYS AS IDENTITY
                PRIMARY KEY,
    title       VARCHAR(200) NOT NULL
                CHECK (length(trim(title)) > 0),
    description TEXT,
    status      VARCHAR(20)  NOT NULL DEFAULT 'new'
                CHECK (status IN ('new', 'in_progress', 'done')),
    created_at  TIMESTAMP    NOT NULL DEFAULT now(),
    user_id     INT          NOT NULL
                REFERENCES users (id)
);

CREATE TABLE comments (
    id         INT GENERATED ALWAYS AS IDENTITY
               PRIMARY KEY,
    content    TEXT      NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    task_id    INT       NOT NULL
               REFERENCES tasks (id)
               ON DELETE CASCADE,
    user_id    INT       NOT NULL
               REFERENCES users (id)
);
