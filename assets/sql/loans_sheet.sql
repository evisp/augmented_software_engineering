-- loans_sheet.sql: practice data for "Database Design & Normalization".
-- Load it with:  sqlite3 design.db < loans_sheet.sql
-- Loading it again resets both tables. It does not touch the tables
-- you create during the tutorial; drop those yourself to start over.

DROP TABLE IF EXISTS loans_sheet;
DROP TABLE IF EXISTS orders_sheet;

-- The library's old loans spreadsheet, imported as it was.
CREATE TABLE loans_sheet (
    loaned_on      TEXT,
    returned_on    TEXT,
    member_name    TEXT,
    member_email   TEXT,
    book_title     TEXT,
    author         TEXT,
    author_country TEXT,
    tags           TEXT
);

INSERT INTO loans_sheet VALUES
    ('2026-09-02', '2026-09-16', 'Arta Hoxha', 'arta@example.com', 'Nineteen Eighty-Four', 'George Orwell', 'United Kingdom', 'classic, dystopia'),
    ('2026-09-05', '2026-09-30', 'Besnik Krasniqi', 'besnik@example.com', 'Dune', 'Frank Herbert', 'United States', 'classic, sci-fi'),
    ('2026-09-18', '2026-10-01', 'Arta Hoxha', 'arta@example.com', 'Kronikë në gur', 'Ismail Kadare', 'Albania', 'albanian'),
    ('2026-09-20', '2026-10-04', 'Drita Leka', 'drita@example.com', 'The Hobbit', 'J. R. R. Tolkien', 'United Kingdom', 'classic, fantasy'),
    ('2026-09-25', NULL, 'Erion Shehu', 'erion@example.com', 'Pride and Prejudice', 'Jane Austen', 'United Kingdom', 'classic'),
    ('2026-10-01', '2026-10-12', 'Besnik Krasniqi', 'besnik@example.com', 'Nineteen Eighty-Four', 'George Orwell', 'UK', 'classic, dystopia'),
    ('2026-10-03', NULL, 'Arta Hoxha', 'arta@example.com', 'Prilli i thyer', 'Ismail Kadare', 'Albania', 'albanian'),
    ('2026-10-06', '2026-10-20', 'Drita Leka', 'drita@example.com', 'Gjenerali i ushtrisë së vdekur', 'Ismail Kadare', 'Albania', 'classic, albanian'),
    ('2026-10-10', NULL, 'Drita Leka', 'drita@example.com', 'Dune', 'Frank Herbert', 'United States', 'classic, sci-fi'),
    ('2026-10-14', '2026-10-28', 'Besnik Krasniqi', 'besnik@example.com', 'Animal Farm', 'George Orwell', 'United Kingdom', 'classic, dystopia'),
    ('2026-10-15', '2026-10-29', 'Erion Shehu', 'erion@example.com', 'Kronikë në gur', 'Ismail Kadare', 'Albania', 'albanian'),
    ('2026-10-22', NULL, 'Arta Hoxha', 'arta@example.com', 'The Hobbit', 'J. R. R. Tolkien', 'United Kingdom', 'classic, fantasy');

-- For the practice set: book orders from suppliers, also from a spreadsheet.
CREATE TABLE orders_sheet (
    ordered_on     TEXT,
    supplier       TEXT,
    supplier_phone TEXT,
    book_title     TEXT,
    author         TEXT,
    quantity       INTEGER,
    unit_price     INTEGER
);

INSERT INTO orders_sheet VALUES
    ('2026-08-03', 'Tirana Book Supply', '+355 69 000 0001', 'Dune', 'Frank Herbert', 3, 1200),
    ('2026-08-03', 'Tirana Book Supply', '+355 69 000 0001', 'The Hobbit', 'J. R. R. Tolkien', 2, 1100),
    ('2026-08-17', 'North Books', '+355 69 000 0002', 'Kronikë në gur', 'Ismail Kadare', 5, 900),
    ('2026-09-01', 'Tirana Book Supply', '+355 69 000 0001', 'Animal Farm', 'George Orwell', 4, 700),
    ('2026-09-01', 'Tirana Book Supply', '+355 69 000 0001', 'Dune', 'Frank Herbert', 2, 1250),
    ('2026-09-15', 'North Books', '+355 69 000 0002', 'Prilli i thyer', 'Ismail Kadare', 3, 950);
