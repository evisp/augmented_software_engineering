-- library.sql: practice data for "SQL: Joins & Relationships".
-- Load it with:  sqlite3 library.db < library.sql
-- Loading it again resets every table.

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS book_tags;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS library_cards;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;

CREATE TABLE authors (
    id      INTEGER PRIMARY KEY,
    name    TEXT NOT NULL,
    country TEXT
);

CREATE TABLE books (
    id        INTEGER PRIMARY KEY,
    title     TEXT    NOT NULL,
    author_id INTEGER NOT NULL REFERENCES authors (id),
    year      INTEGER
);

CREATE TABLE members (
    id        INTEGER PRIMARY KEY,
    name      TEXT NOT NULL,
    email     TEXT NOT NULL UNIQUE,
    joined_on TEXT NOT NULL
);

-- One card per member, at most: member_id is both the primary key
-- and a foreign key, so it cannot repeat.
CREATE TABLE library_cards (
    member_id   INTEGER PRIMARY KEY REFERENCES members (id),
    card_number TEXT NOT NULL UNIQUE,
    expires_on  TEXT NOT NULL
);

CREATE TABLE loans (
    id          INTEGER PRIMARY KEY,
    book_id     INTEGER NOT NULL REFERENCES books (id),
    member_id   INTEGER NOT NULL REFERENCES members (id),
    loaned_on   TEXT    NOT NULL,
    returned_on TEXT
);

CREATE TABLE tags (
    id   INTEGER PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE book_tags (
    book_id INTEGER NOT NULL REFERENCES books (id),
    tag_id  INTEGER NOT NULL REFERENCES tags (id),
    PRIMARY KEY (book_id, tag_id)
);

INSERT INTO authors (id, name, country) VALUES
    (1, 'Ismail Kadare', 'Albania'),
    (2, 'Dritëro Agolli', 'Albania'),
    (3, 'George Orwell', 'United Kingdom'),
    (4, 'Jane Austen', 'United Kingdom'),
    (5, 'Frank Herbert', 'United States'),
    (6, 'J. R. R. Tolkien', 'United Kingdom'),
    (7, 'Chinua Achebe', 'Nigeria'),
    (8, 'Ursula K. Le Guin', 'United States');

INSERT INTO books (id, title, author_id, year) VALUES
    (1, 'Kronikë në gur', 1, 1971),
    (2, 'Prilli i thyer', 1, 1978),
    (3, 'Gjenerali i ushtrisë së vdekur', 1, 1963),
    (4, 'Shkëlqimi dhe rënia e shokut Zylo', 2, 1973),
    (5, 'Nineteen Eighty-Four', 3, 1949),
    (6, 'Animal Farm', 3, 1945),
    (7, 'Pride and Prejudice', 4, 1813),
    (8, 'Dune', 5, 1965),
    (9, 'The Hobbit', 6, 1937),
    (10, 'Things Fall Apart', 7, 1958);

INSERT INTO members (id, name, email, joined_on) VALUES
    (1, 'Arta Hoxha', 'arta@example.com', '2026-01-15'),
    (2, 'Besnik Krasniqi', 'besnik@example.com', '2026-02-03'),
    (3, 'Drita Leka', 'drita@example.com', '2026-03-10'),
    (4, 'Erion Shehu', 'erion@example.com', '2026-05-22'),
    (5, 'Lea Marku', 'lea@example.com', '2026-09-01');

INSERT INTO library_cards (member_id, card_number, expires_on) VALUES
    (1, 'LIB-0001', '2027-01-15'),
    (2, 'LIB-0002', '2027-02-03'),
    (3, 'LIB-0003', '2027-03-10'),
    (4, 'LIB-0004', '2027-05-22');

INSERT INTO loans (id, book_id, member_id, loaned_on, returned_on) VALUES
    (1, 5, 1, '2026-09-02', '2026-09-16'),
    (2, 8, 2, '2026-09-05', '2026-09-30'),
    (3, 1, 1, '2026-09-18', '2026-10-01'),
    (4, 9, 3, '2026-09-20', '2026-10-04'),
    (5, 7, 4, '2026-09-25', NULL),
    (6, 5, 2, '2026-10-01', '2026-10-12'),
    (7, 2, 1, '2026-10-03', NULL),
    (8, 3, 3, '2026-10-06', '2026-10-20'),
    (9, 8, 3, '2026-10-10', NULL),
    (10, 6, 2, '2026-10-14', '2026-10-28'),
    (11, 1, 4, '2026-10-15', '2026-10-29'),
    (12, 9, 1, '2026-10-22', NULL);

INSERT INTO tags (id, name) VALUES
    (1, 'classic'),
    (2, 'albanian'),
    (3, 'dystopia'),
    (4, 'sci-fi'),
    (5, 'fantasy'),
    (6, 'poetry');

INSERT INTO book_tags (book_id, tag_id) VALUES
    (1, 2), (2, 2), (3, 1), (3, 2), (4, 2),
    (5, 1), (5, 3), (6, 1), (6, 3), (7, 1),
    (8, 1), (8, 4), (9, 1), (9, 5);
