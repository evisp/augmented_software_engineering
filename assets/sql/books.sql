-- books.sql: practice data for the tutorial "SQL: CRUD Operations".
-- Load it with:  sqlite3 books.db < books.sql
-- Loading it again resets the table to these 20 books.

DROP TABLE IF EXISTS books;

CREATE TABLE books (
    id        INTEGER PRIMARY KEY,
    title     TEXT    NOT NULL,
    author    TEXT    NOT NULL,
    year      INTEGER,
    genre     TEXT,
    pages     INTEGER,
    available INTEGER NOT NULL DEFAULT 1
);

INSERT INTO books (title, author, year, genre, pages, available) VALUES
    ('Kronikë në gur', 'Ismail Kadare', 1971, 'novel', 320, 1),
    ('Gjenerali i ushtrisë së vdekur', 'Ismail Kadare', 1963, 'novel', 288, 0),
    ('Prilli i thyer', 'Ismail Kadare', 1978, 'novel', 216, 1),
    ('Shkëlqimi dhe rënia e shokut Zylo', 'Dritëro Agolli', 1973, 'satire', 224, 1),
    ('I humburi', 'Fatos Kongoli', 1992, 'novel', 192, 1),
    ('The Little Prince', 'Antoine de Saint-Exupéry', 1943, 'children', 96, 0),
    ('Nineteen Eighty-Four', 'George Orwell', 1949, 'dystopia', 328, 1),
    ('Animal Farm', 'George Orwell', 1945, 'satire', 112, 0),
    ('Things Fall Apart', 'Chinua Achebe', 1958, 'novel', 209, 1),
    ('Pride and Prejudice', 'Jane Austen', 1813, 'romance', 432, 1),
    ('Emma', 'Jane Austen', 1815, 'romance', 474, 1),
    ('Dune', 'Frank Herbert', 1965, 'sci-fi', 612, 0),
    ('The Hobbit', 'J. R. R. Tolkien', 1937, 'fantasy', 310, 1),
    ('Don Quixote', 'Miguel de Cervantes', 1605, 'novel', 1072, 1),
    ('One Hundred Years of Solitude', 'Gabriel García Márquez', 1967, 'novel', 417, 1),
    ('Clean Code', 'Robert C. Martin', 2008, 'programming', 464, 1),
    ('The Pragmatic Programmer', 'Andrew Hunt', 1999, 'programming', 352, 0),
    ('Fluent Python', 'Luciano Ramalho', 2015, 'programming', NULL, 1),
    ('Vargjet e lira', 'Migjeni', 1936, NULL, NULL, 1),
    ('Sapiens', 'Yuval Noah Harari', 2011, NULL, 443, 1);
