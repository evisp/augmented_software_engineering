# SQL: CRUD Operations

<span class="badge badge--time">90 min</span>
<span class="badge badge--level">Data & APIs</span>
<span class="badge">Needs: File Handling</span>

Files are good for a list or a settings file. When you need to find,
sort, count and change many records, you need a **database**. In this
tutorial you meet the relational model and learn the language every
relational database speaks, **SQL**: you create a table, then read,
filter, sort, add, change, delete and summarise the library's books.

## Why this matters

Nearly every application keeps its data in a relational database: user
accounts, orders, bookings, messages. SQL has been the way to talk to
those databases for fifty years, and the SQL you learn here works,
almost unchanged, in SQLite, PostgreSQL, MySQL and SQL Server.

It is also the skill that answers questions. "How many books does each
author have?" needs a loop and a dictionary in Python. In SQL it is
three short lines.

## Before you start

We use **SQLite**: a whole database in one file, with no server to
install. Install its command-line tool in your WSL terminal:

```bash
sudo apt update && sudo apt install -y sqlite3
sqlite3 --version
```

Then download the practice data and load it into a new database file,
`books.db`:

```bash
mkdir -p ~/library && cd ~/library
curl -O https://evisp.github.io/augmented_software_engineering/assets/sql/books.sql
sqlite3 books.db < books.sql
```

You can also download
[books.sql](../../assets/sql/books.sql){ download="books.sql" } from the
browser. It creates a table of 20 books. **Loading it again resets the
table**, so if you break something, run the last command again.

## Step 1: Tables, rows and columns

A relational database stores data in **tables**. A table looks like a
spreadsheet, but it is stricter, and that strictness is what makes it
reliable.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 236" role="img" aria-labelledby="sc-tab-title sc-tab-desc">
<title id="sc-tab-title">The parts of the books table</title>
<desc id="sc-tab-desc">The books table has named columns: id, title, author, year, genre and pages. Each row is one book. The id column is the primary key, a unique number for every row. The year column holds one kind of fact. A cell with no value, such as the genre and pages of Vargjet e lira, holds NULL.</desc>
<g font-size="11" font-weight="700" fill="var(--h-cherry)">
<text x="80" y="18">primary key: unique</text>
<text x="80" y="32">for every row</text>
<text x="330" y="18">column: one kind of fact,</text>
<text x="330" y="32">one type, a name</text>
</g>
<line x1="104" y1="38" x2="104" y2="54" stroke="var(--h-cherry)" stroke-width="2"/>
<line x1="388" y1="38" x2="388" y2="54" stroke="var(--h-cherry)" stroke-width="2"/>
<g font-size="12" font-family="var(--md-code-font-family, monospace)">
<rect x="80" y="56" width="520" height="30" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<g font-weight="700" fill="var(--h-fig-text)">
<text x="92" y="76">id</text><text x="138" y="76">title</text><text x="252" y="76">author</text><text x="372" y="76">year</text><text x="424" y="76">genre</text><text x="526" y="76">pages</text>
</g>
<rect x="364" y="56" width="50" height="30" fill="none" stroke="var(--h-cherry)" stroke-width="2"/>
<rect x="80" y="86" width="520" height="30" fill="none" stroke="var(--h-fig-line)"/>
<rect x="80" y="116" width="520" height="30" fill="var(--h-cherry-wash, rgba(227,28,63,0.09))" stroke="var(--h-cherry)" stroke-width="2"/>
<rect x="80" y="146" width="520" height="30" fill="none" stroke="var(--h-fig-line)"/>
<g fill="var(--h-fig-text)">
<text x="92" y="106" fill="var(--h-cherry)" font-weight="700">1</text><text x="138" y="106">Kronikë në gur</text><text x="252" y="106">Ismail Kadare</text><text x="372" y="106">1971</text><text x="424" y="106">novel</text><text x="526" y="106">320</text>
<text x="92" y="136" fill="var(--h-cherry)" font-weight="700">18</text><text x="138" y="136">Fluent Python</text><text x="252" y="136">L. Ramalho</text><text x="372" y="136">2015</text><text x="424" y="136">programming</text><text x="526" y="136" font-style="italic" fill="var(--h-fig-muted)">NULL</text>
<text x="92" y="166" fill="var(--h-cherry)" font-weight="700">19</text><text x="138" y="166">Vargjet e lira</text><text x="252" y="166">Migjeni</text><text x="372" y="166">1936</text><text x="424" y="166" font-style="italic" fill="var(--h-fig-muted)">NULL</text><text x="526" y="166" font-style="italic" fill="var(--h-fig-muted)">NULL</text>
</g>
</g>
<rect x="80" y="56" width="48" height="120" fill="none" stroke="var(--h-cherry)" stroke-width="2"/>
<polyline points="72,118 64,118 64,144 72,144" fill="none" stroke="var(--h-cherry)" stroke-width="2"/>
<text x="56" y="128" text-anchor="end" font-size="11" font-weight="700" fill="var(--h-cherry)">row:</text>
<text x="56" y="142" text-anchor="end" font-size="11" fill="var(--h-cherry)">one</text>
<text x="56" y="156" text-anchor="end" font-size="11" fill="var(--h-cherry)">book</text>
<line x1="540" y1="180" x2="540" y2="198" stroke="var(--h-fig-muted)" stroke-width="2"/>
<text x="540" y="214" text-anchor="middle" font-size="11" font-weight="700" fill="var(--h-fig-text)">NULL: no value</text>
<text x="80" y="214" font-size="11" fill="var(--h-fig-muted)">books · 20 rows · the available column is not shown</text>
</svg>
</figure>

- A **table** holds one kind of thing: the `books` table holds books,
  one per row.
- A **column** has a name and a **type**, and every value in it is the
  same kind of fact: `year` is always a whole number, `title` always
  text.
- A **row** is one record: one book, with a value for each column.
- The **primary key**, here `id`, has a different value in every row,
  so each row can be found and changed on its own.
- **NULL** means "no value": unknown or missing. It is not zero and not
  an empty string, and it needs special care, as you will see.

The order of rows in a table means nothing. A database returns rows in
whatever order is fastest, unless you ask for an order.

## Step 2: Open the database

Open `books.db` in the **SQLite shell**:

```bash
sqlite3 books.db
```

The prompt changes to `sqlite>`. Everything you type there is either
SQL, which ends with a semicolon `;`, or a shell command, which starts
with a dot. Make the results readable first:

```text
sqlite> .headers on
sqlite> .mode box
```

Every output on this page uses those two settings. To have them every
time, put both lines in a file called `~/.sqliterc`. Now look around.
`.tables` lists the tables:

```sql
.tables
```

```text
books
```

`.schema` shows how a table was created:

```sql
.schema books
```

```text
CREATE TABLE books (
    id        INTEGER PRIMARY KEY,
    title     TEXT    NOT NULL,
    author    TEXT    NOT NULL,
    year      INTEGER,
    genre     TEXT,
    pages     INTEGER,
    available INTEGER NOT NULL DEFAULT 1
);
```

Leave the shell with `.quit` or ++ctrl+d++. You can also run a file of
SQL without opening the shell: `sqlite3 books.db < some-file.sql`, which
is exactly how you loaded the practice data.

## Step 3: Create a table

That schema is a `CREATE TABLE` statement. Read it line by line:

- `INTEGER PRIMARY KEY` makes `id` the primary key. Leave it out when
  you add a row, and SQLite fills in the next number.
- `TEXT` and `INTEGER` are the **types**. SQLite also has `REAL` for
  decimals and `BLOB` for raw bytes. There is no true/false type:
  `available` uses `1` for yes and `0` for no.
- `NOT NULL` means the column must always have a value. `genre` and
  `pages` have no such rule, so they may be NULL.
- `DEFAULT 1` fills in a value when a new row does not give one.

`books.sql` also starts with `DROP TABLE IF EXISTS books;`, which
deletes the whole table, data and all. That is what makes reloading the
file a reset.

Dates have no special type in SQLite either. Store them as text in the
form `YYYY-MM-DD`: in that form they sort and compare correctly.

!!! tip "Try it"

    The library also needs its members. Create a table `members` with an
    `id` primary key, a `name` that is required, an `email` that is
    required and must be different for every member, and a `joined_on`
    date that defaults to today. Check it with `.tables`.

??? success "Answer"

    `UNIQUE` refuses a value that is already in the column, and
    `CURRENT_DATE` is today's date:

    ```sql
    CREATE TABLE members (
        id        INTEGER PRIMARY KEY,
        name      TEXT NOT NULL,
        email     TEXT NOT NULL UNIQUE,
        joined_on TEXT NOT NULL DEFAULT CURRENT_DATE
    );
    ```

    ```sql
    .tables
    ```

    ```text
    books    members
    ```

## Step 4: Read data with SELECT

`SELECT` reads rows. `*` means "every column", and `LIMIT` keeps only
the first few rows:

```sql
SELECT * FROM books LIMIT 5;
```

```text
┌────┬───────────────────────────────────┬────────────────┬──────┬────────┬───────┬───────────┐
│ id │               title               │     author     │ year │ genre  │ pages │ available │
├────┼───────────────────────────────────┼────────────────┼──────┼────────┼───────┼───────────┤
│ 1  │ Kronikë në gur                    │ Ismail Kadare  │ 1971 │ novel  │ 320   │ 1         │
│ 2  │ Gjenerali i ushtrisë së vdekur    │ Ismail Kadare  │ 1963 │ novel  │ 288   │ 0         │
│ 3  │ Prilli i thyer                    │ Ismail Kadare  │ 1978 │ novel  │ 216   │ 1         │
│ 4  │ Shkëlqimi dhe rënia e shokut Zylo │ Dritëro Agolli │ 1973 │ satire │ 224   │ 1         │
│ 5  │ I humburi                         │ Fatos Kongoli  │ 1992 │ novel  │ 192   │ 1         │
└────┴───────────────────────────────────┴────────────────┴──────┴────────┴───────┴───────────┘
```

Ask only for the columns you need. The result is easier to read, and it
says exactly what you meant:

```sql
SELECT title, author, year FROM books LIMIT 5;
```

```text
┌───────────────────────────────────┬────────────────┬──────┐
│               title               │     author     │ year │
├───────────────────────────────────┼────────────────┼──────┤
│ Kronikë në gur                    │ Ismail Kadare  │ 1971 │
│ Gjenerali i ushtrisë së vdekur    │ Ismail Kadare  │ 1963 │
│ Prilli i thyer                    │ Ismail Kadare  │ 1978 │
│ Shkëlqimi dhe rënia e shokut Zylo │ Dritëro Agolli │ 1973 │
│ I humburi                         │ Fatos Kongoli  │ 1992 │
└───────────────────────────────────┴────────────────┴──────┘
```

SQL keywords are not case-sensitive, but writing them in capitals makes
queries easier to read. Text values go in **single quotes**:
`'Ismail Kadare'`.

!!! tip "Try it"

    Show the title, genre and number of pages of the first three books.

??? success "Answer"

    ```sql
    SELECT title, genre, pages FROM books LIMIT 3;
    ```

    ```text
    ┌────────────────────────────────┬───────┬───────┐
    │             title              │ genre │ pages │
    ├────────────────────────────────┼───────┼───────┤
    │ Kronikë në gur                 │ novel │ 320   │
    │ Gjenerali i ushtrisë së vdekur │ novel │ 288   │
    │ Prilli i thyer                 │ novel │ 216   │
    └────────────────────────────────┴───────┴───────┘
    ```

## Step 5: Filter rows with WHERE

`WHERE` keeps only the rows for which a condition is true. All of
Kadare's books:

```sql
SELECT id, title, year FROM books WHERE author = 'Ismail Kadare';
```

```text
┌────┬────────────────────────────────┬──────┐
│ id │             title              │ year │
├────┼────────────────────────────────┼──────┤
│ 1  │ Kronikë në gur                 │ 1971 │
│ 2  │ Gjenerali i ushtrisë së vdekur │ 1963 │
│ 3  │ Prilli i thyer                 │ 1978 │
└────┴────────────────────────────────┴──────┘
```

The conditions you will use most:

| Condition | Example |
|---|---|
| `=` `<>` `<` `<=` `>` `>=` | `year < 1900` |
| `AND`, `OR`, `NOT` | `genre = 'novel' AND pages > 300` |
| `IN (...)` | `genre IN ('satire', 'dystopia')` |
| `BETWEEN a AND b` | `year BETWEEN 1940 AND 1949`, both ends included |
| `LIKE` | `title LIKE 'The %'`: `%` is any text, `_` one character |
| `IS NULL`, `IS NOT NULL` | `genre IS NULL` |

Books from before 1900:

```sql
SELECT title, author, year FROM books WHERE year < 1900;
```

```text
┌─────────────────────┬─────────────────────┬──────┐
│        title        │       author        │ year │
├─────────────────────┼─────────────────────┼──────┤
│ Pride and Prejudice │ Jane Austen         │ 1813 │
│ Emma                │ Jane Austen         │ 1815 │
│ Don Quixote         │ Miguel de Cervantes │ 1605 │
└─────────────────────┴─────────────────────┴──────┘
```

Novels longer than 300 pages:

```sql
SELECT title, pages FROM books
WHERE genre = 'novel' AND pages > 300;
```

```text
┌───────────────────────────────┬───────┐
│             title             │ pages │
├───────────────────────────────┼───────┤
│ Kronikë në gur                │ 320   │
│ Don Quixote                   │ 1072  │
│ One Hundred Years of Solitude │ 417   │
└───────────────────────────────┴───────┘
```

Satires and dystopias:

```sql
SELECT title, genre FROM books
WHERE genre IN ('satire', 'dystopia');
```

```text
┌───────────────────────────────────┬──────────┐
│               title               │  genre   │
├───────────────────────────────────┼──────────┤
│ Shkëlqimi dhe rënia e shokut Zylo │ satire   │
│ Nineteen Eighty-Four              │ dystopia │
│ Animal Farm                       │ satire   │
└───────────────────────────────────┴──────────┘
```

The 1940s:

```sql
SELECT title, year FROM books
WHERE year BETWEEN 1940 AND 1949;
```

```text
┌──────────────────────┬──────┐
│        title         │ year │
├──────────────────────┼──────┤
│ The Little Prince    │ 1943 │
│ Nineteen Eighty-Four │ 1949 │
│ Animal Farm          │ 1945 │
└──────────────────────┴──────┘
```

Titles that start with "The ":

```sql
SELECT title FROM books WHERE title LIKE 'The %';
```

```text
┌──────────────────────────┐
│          title           │
├──────────────────────────┤
│ The Little Prince        │
│ The Hobbit               │
│ The Pragmatic Programmer │
└──────────────────────────┘
```

And the books whose genre was never filled in. In box mode, NULL shows
as an empty cell:

```sql
SELECT id, title, genre, pages FROM books WHERE genre IS NULL;
```

```text
┌────┬────────────────┬───────┬───────┐
│ id │     title      │ genre │ pages │
├────┼────────────────┼───────┼───────┤
│ 19 │ Vargjet e lira │       │       │
│ 20 │ Sapiens        │       │ 443   │
└────┴────────────────┴───────┴───────┘
```

!!! warning "NULL is not equal to anything, not even NULL"

    `WHERE genre = NULL` looks right, and finds nothing:

    ```sql
    SELECT COUNT(*) AS matches FROM books WHERE genre = NULL;
    ```

    ```text
    ┌─────────┐
    │ matches │
    ├─────────┤
    │ 0       │
    └─────────┘
    ```

    Comparing anything with NULL gives "unknown", which `WHERE` treats as
    false. Always test for missing values with `IS NULL` or
    `IS NOT NULL`.

!!! tip "Try it"

    Which books are out on loan right now, that is, not available?

??? success "Answer"

    ```sql
    SELECT title, author FROM books WHERE available = 0;
    ```

    ```text
    ┌────────────────────────────────┬──────────────────────────┐
    │             title              │          author          │
    ├────────────────────────────────┼──────────────────────────┤
    │ Gjenerali i ushtrisë së vdekur │ Ismail Kadare            │
    │ The Little Prince              │ Antoine de Saint-Exupéry │
    │ Animal Farm                    │ George Orwell            │
    │ Dune                           │ Frank Herbert            │
    │ The Pragmatic Programmer       │ Andrew Hunt              │
    └────────────────────────────────┴──────────────────────────┘
    ```

## Step 6: Sort and limit

`ORDER BY` sorts the result, and `DESC` puts the largest first. Together
with `LIMIT`, it answers "top N" questions. The three longest books:

```sql
SELECT title, pages FROM books ORDER BY pages DESC LIMIT 3;
```

```text
┌─────────────┬───────┐
│    title    │ pages │
├─────────────┼───────┤
│ Don Quixote │ 1072  │
│ Dune        │ 612   │
│ Emma        │ 474   │
└─────────────┴───────┘
```

Sort by several columns, and the second one breaks ties in the first.
Every novel, by author and then by year:

```sql
SELECT author, year, title FROM books
WHERE genre = 'novel'
ORDER BY author, year;
```

```text
┌────────────────────────┬──────┬────────────────────────────────┐
│         author         │ year │             title              │
├────────────────────────┼──────┼────────────────────────────────┤
│ Chinua Achebe          │ 1958 │ Things Fall Apart              │
│ Fatos Kongoli          │ 1992 │ I humburi                      │
│ Gabriel García Márquez │ 1967 │ One Hundred Years of Solitude  │
│ Ismail Kadare          │ 1963 │ Gjenerali i ushtrisë së vdekur │
│ Ismail Kadare          │ 1971 │ Kronikë në gur                 │
│ Ismail Kadare          │ 1978 │ Prilli i thyer                 │
│ Miguel de Cervantes    │ 1605 │ Don Quixote                    │
└────────────────────────┴──────┴────────────────────────────────┘
```

`OFFSET` skips rows, which is how a website shows page 2 of a list:

```sql
SELECT id, title FROM books ORDER BY id LIMIT 5 OFFSET 5;
```

```text
┌────┬──────────────────────┐
│ id │        title         │
├────┼──────────────────────┤
│ 6  │ The Little Prince    │
│ 7  │ Nineteen Eighty-Four │
│ 8  │ Animal Farm          │
│ 9  │ Things Fall Apart    │
│ 10 │ Pride and Prejudice  │
└────┴──────────────────────┘
```

Without `ORDER BY`, "the first five rows" means whichever five the
database happens to return. Whenever the order matters, say so.

!!! tip "Try it"

    Show the three most recently published books, newest first.

??? success "Answer"

    ```sql
    SELECT title, year FROM books ORDER BY year DESC LIMIT 3;
    ```

    ```text
    ┌───────────────┬──────┐
    │     title     │ year │
    ├───────────────┼──────┤
    │ Fluent Python │ 2015 │
    │ Sapiens       │ 2011 │
    │ Clean Code    │ 2008 │
    └───────────────┴──────┘
    ```

## Step 7: Add rows with INSERT

`INSERT INTO` adds rows. Name the columns, then give the values in the
same order. Leave out `id`, and SQLite assigns the next number; leave
out `available`, and it gets its default, `1`:

```sql
INSERT INTO books (title, author, year, genre, pages)
VALUES ('The Left Hand of Darkness', 'Ursula K. Le Guin', 1969, 'sci-fi', 304);
```

`VALUES` can take several rows at once, separated by commas, and `NULL`
leaves a column empty:

```sql
INSERT INTO books (title, author, year, genre, pages) VALUES
    ('Python Crash Course', 'Eric Matthes', 2019, 'programming', 544),
    ('Atomic Habits', 'James Clear', 2018, NULL, 320);
```

Always check what you wrote:

```sql
SELECT * FROM books WHERE id > 20;
```

```text
┌────┬───────────────────────────┬───────────────────┬──────┬─────────────┬───────┬───────────┐
│ id │           title           │      author       │ year │    genre    │ pages │ available │
├────┼───────────────────────────┼───────────────────┼──────┼─────────────┼───────┼───────────┤
│ 21 │ The Left Hand of Darkness │ Ursula K. Le Guin │ 1969 │ sci-fi      │ 304   │ 1         │
│ 22 │ Python Crash Course       │ Eric Matthes      │ 2019 │ programming │ 544   │ 1         │
│ 23 │ Atomic Habits             │ James Clear       │ 2018 │             │ 320   │ 1         │
└────┴───────────────────────────┴───────────────────┴──────┴─────────────┴───────┴───────────┘
```

!!! tip "Try it"

    Add three members to your `members` table from Step 3: two with a
    `joined_on` date, and one without, to see the default.

??? success "Answer"

    ```sql
    INSERT INTO members (name, email, joined_on) VALUES
        ('Arta Hoxha', 'arta@example.com', '2026-01-15'),
        ('Besnik Krasniqi', 'besnik@example.com', '2026-02-03');
    INSERT INTO members (name, email) VALUES ('Drita Leka', 'drita@example.com');
    SELECT * FROM members;
    ```

    ```text
    ┌────┬─────────────────┬────────────────────┬────────────┐
    │ id │      name       │       email        │ joined_on  │
    ├────┼─────────────────┼────────────────────┼────────────┤
    │ 1  │ Arta Hoxha      │ arta@example.com   │ 2026-01-15 │
    │ 2  │ Besnik Krasniqi │ besnik@example.com │ 2026-02-03 │
    │ 3  │ Drita Leka      │ drita@example.com  │ 2026-10-31 │
    └────┴─────────────────┴────────────────────┴────────────┘
    ```

    The third member got today's date, the day this page was written.

## Step 8: Change and remove rows

`UPDATE` changes values in the rows that match `WHERE`. *Atomic Habits*
has no genre yet; give it one:

```sql
UPDATE books SET genre = 'self-help' WHERE id = 23;
```

One `UPDATE` can change several columns at once. *The Left Hand of
Darkness* went out on loan, and its page count was wrong:

```sql
UPDATE books SET available = 0, pages = 290 WHERE id = 21;
```

```sql
SELECT id, title, genre, pages, available FROM books WHERE id > 20;
```

```text
┌────┬───────────────────────────┬─────────────┬───────┬───────────┐
│ id │           title           │    genre    │ pages │ available │
├────┼───────────────────────────┼─────────────┼───────┼───────────┤
│ 21 │ The Left Hand of Darkness │ sci-fi      │ 290   │ 0         │
│ 22 │ Python Crash Course       │ programming │ 544   │ 1         │
│ 23 │ Atomic Habits             │ self-help   │ 320   │ 1         │
└────┴───────────────────────────┴─────────────┴───────┴───────────┘
```

`DELETE FROM` removes the rows that match `WHERE`. *Python Crash
Course* was added by mistake. Check the row first, then delete it:

```sql
SELECT id, title FROM books WHERE id = 22;
```

```text
┌────┬─────────────────────┐
│ id │        title        │
├────┼─────────────────────┤
│ 22 │ Python Crash Course │
└────┴─────────────────────┘
```

```sql
DELETE FROM books WHERE id = 22;
```

```sql
SELECT id, title FROM books WHERE id > 20;
```

```text
┌────┬───────────────────────────┐
│ id │           title           │
├────┼───────────────────────────┤
│ 21 │ The Left Hand of Darkness │
│ 23 │ Atomic Habits             │
└────┴───────────────────────────┘
```

Notice that each statement used the **primary key** to pick exactly one
row. A condition such as `WHERE author = 'Jane Austen'` would change
every one of her books.

!!! danger "UPDATE and DELETE without WHERE change every row"

    `DELETE FROM books;` empties the table, and
    `UPDATE books SET available = 0;` marks every book as out. There is
    no undo. Two habits protect you:

    1. **Run the `WHERE` as a `SELECT` first**, as above. If it shows
       exactly the rows you mean, the same `WHERE` is safe.
    2. **Use a transaction for anything risky.** `BEGIN` starts one;
       nothing is final until `COMMIT`, and `ROLLBACK` undoes it all.
       `changes()` reports how many rows the last statement touched:

    ```sql
    BEGIN;
    UPDATE books SET available = 0;
    SELECT changes() AS changed;
    SELECT SUM(available) AS available FROM books;
    ROLLBACK;
    SELECT SUM(available) AS available FROM books;
    ```

    ```text
    ┌─────────┐
    │ changed │
    ├─────────┤
    │ 22      │
    └─────────┘
    ┌───────────┐
    │ available │
    ├───────────┤
    │ 0         │
    └───────────┘
    ┌───────────┐
    │ available │
    ├───────────┤
    │ 16        │
    └───────────┘
    ```

    The update touched all 22 rows and nothing was available, until
    `ROLLBACK` put everything back.

These four statements, `INSERT`, `SELECT`, `UPDATE` and `DELETE`, are
**CRUD**: create, read, update, delete. Almost everything an
application does with its data is one of them.

!!! tip "Try it"

    In `members`, change Drita's email, delete Besnik, and show the
    table. Then try to add a member with an email that is already used.

??? success "Answer"

    ```sql
    UPDATE members SET email = 'drita.leka@example.com' WHERE id = 3;
    DELETE FROM members WHERE id = 2;
    SELECT * FROM members;
    ```

    ```text
    ┌────┬────────────┬────────────────────────┬────────────┐
    │ id │    name    │         email          │ joined_on  │
    ├────┼────────────┼────────────────────────┼────────────┤
    │ 1  │ Arta Hoxha │ arta@example.com       │ 2026-01-15 │
    │ 3  │ Drita Leka │ drita.leka@example.com │ 2026-10-31 │
    └────┴────────────┴────────────────────────┴────────────┘
    ```

    ```sql
    INSERT INTO members (name, email) VALUES ('Arta H.', 'arta@example.com');
    ```

    ```text
    Runtime error: UNIQUE constraint failed: members.email (19)
    ```

    The `UNIQUE` rule from Step 3 protects the data even from your own
    mistakes.

## Step 9: Summarise with aggregate functions

An **aggregate function** turns many rows into one value:

| Function | Returns |
|---|---|
| `COUNT(*)` | the number of rows |
| `COUNT(column)` | the number of rows where that column is **not** NULL |
| `SUM(column)` | the total |
| `AVG(column)` | the average |
| `MIN(column)`, `MAX(column)` | the smallest and largest value |

```sql
SELECT COUNT(*) AS books, COUNT(genre) AS with_genre,
       COUNT(pages) AS with_pages, SUM(pages) AS total_pages
FROM books;
```

```text
┌───────┬────────────┬────────────┬─────────────┐
│ books │ with_genre │ with_pages │ total_pages │
├───────┼────────────┼────────────┼─────────────┤
│ 22    │ 20         │ 20         │ 7171        │
└───────┴────────────┴────────────┴─────────────┘
```

`COUNT(*)` counts every row, while `COUNT(genre)` skips the rows whose
genre is NULL. `AS` gives a result column a readable name.

Combine aggregates with `WHERE` to summarise only some rows. The
shortest, longest and average novel:

```sql
SELECT MIN(pages) AS shortest, MAX(pages) AS longest,
       ROUND(AVG(pages), 1) AS average
FROM books WHERE genre = 'novel';
```

```text
┌──────────┬─────────┬─────────┐
│ shortest │ longest │ average │
├──────────┼─────────┼─────────┤
│ 192      │ 1072    │ 387.7   │
└──────────┴─────────┴─────────┘
```

`ROUND(..., 1)` keeps one decimal place. Aggregates also skip NULLs:
`AVG(pages)` averages only the books whose page count is known.

!!! tip "Try it"

    How many books are on the shelf, that is, available?

??? success "Answer"

    ```sql
    SELECT COUNT(*) AS on_the_shelf FROM books WHERE available = 1;
    ```

    ```text
    ┌──────────────┐
    │ on_the_shelf │
    ├──────────────┤
    │ 16           │
    └──────────────┘
    ```

    `SUM(available)` gives the same answer, because available books hold
    `1`.

## Step 10: Group rows with GROUP BY

`GROUP BY` splits the rows into groups that share a value, and runs the
aggregate once per group. The result has one row per group.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 222" role="img" aria-labelledby="sc-grp-title sc-grp-desc">
<title id="sc-grp-title">GROUP BY author turns rows into one row per author</title>
<desc id="sc-grp-desc">Seven books in mixed order: three by Ismail Kadare, two by George Orwell and two by Jane Austen. GROUP BY author collects them into three groups, and COUNT counts each group: Ismail Kadare 3, George Orwell 2, Jane Austen 2.</desc>
<defs><marker id="sc-grp-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-cherry)"/></marker></defs>
<text x="3" y="14" font-size="11" font-weight="700" fill="var(--h-fig-muted)">BOOKS, IN ANY ORDER</text>
<g font-size="12" font-family="var(--md-code-font-family, monospace)">
<rect x="3" y="24" width="230" height="24" rx="5" fill="var(--h-cherry)"/><text x="14" y="41" fill="#ffffff">Ismail Kadare</text><text x="222" y="41" text-anchor="end" fill="#ffffff">1971</text>
<rect x="3" y="51" width="230" height="24" rx="5" fill="var(--h-fig-box)" stroke="var(--h-fig-text)"/><text x="14" y="68" fill="var(--h-fig-text)">George Orwell</text><text x="222" y="68" text-anchor="end" fill="var(--h-fig-text)">1949</text>
<rect x="3" y="78" width="230" height="24" rx="5" fill="none" stroke="var(--h-fig-line)" stroke-dasharray="4 3"/><text x="14" y="95" fill="var(--h-fig-text)">Jane Austen</text><text x="222" y="95" text-anchor="end" fill="var(--h-fig-text)">1813</text>
<rect x="3" y="105" width="230" height="24" rx="5" fill="var(--h-cherry)"/><text x="14" y="122" fill="#ffffff">Ismail Kadare</text><text x="222" y="122" text-anchor="end" fill="#ffffff">1963</text>
<rect x="3" y="132" width="230" height="24" rx="5" fill="var(--h-fig-box)" stroke="var(--h-fig-text)"/><text x="14" y="149" fill="var(--h-fig-text)">George Orwell</text><text x="222" y="149" text-anchor="end" fill="var(--h-fig-text)">1945</text>
<rect x="3" y="159" width="230" height="24" rx="5" fill="var(--h-cherry)"/><text x="14" y="176" fill="#ffffff">Ismail Kadare</text><text x="222" y="176" text-anchor="end" fill="#ffffff">1978</text>
<rect x="3" y="186" width="230" height="24" rx="5" fill="none" stroke="var(--h-fig-line)" stroke-dasharray="4 3"/><text x="14" y="203" fill="var(--h-fig-text)">Jane Austen</text><text x="222" y="203" text-anchor="end" fill="var(--h-fig-text)">1815</text>
</g>
<line x1="250" y1="117" x2="420" y2="117" stroke="var(--h-cherry)" stroke-width="2.5" marker-end="url(#sc-grp-arrow)"/>
<text x="335" y="104" text-anchor="middle" font-size="12" font-weight="700" fill="var(--h-cherry)" font-family="var(--md-code-font-family, monospace)">GROUP BY author</text>
<text x="335" y="138" text-anchor="middle" font-size="11.5" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">COUNT(*)</text>
<text x="437" y="14" font-size="11" font-weight="700" fill="var(--h-fig-muted)">ONE ROW PER GROUP</text>
<g font-size="12.5" font-family="var(--md-code-font-family, monospace)" font-weight="700">
<rect x="437" y="60" width="240" height="30" rx="6" fill="var(--h-cherry)"/><text x="450" y="80" fill="#ffffff">Ismail Kadare</text><text x="664" y="80" text-anchor="end" fill="#ffffff">3</text>
<rect x="437" y="100" width="240" height="30" rx="6" fill="var(--h-fig-box)" stroke="var(--h-fig-text)"/><text x="450" y="120" fill="var(--h-fig-text)">George Orwell</text><text x="664" y="120" text-anchor="end" fill="var(--h-fig-text)">2</text>
<rect x="437" y="140" width="240" height="30" rx="6" fill="none" stroke="var(--h-fig-line)" stroke-dasharray="4 3"/><text x="450" y="160" fill="var(--h-fig-text)">Jane Austen</text><text x="664" y="160" text-anchor="end" fill="var(--h-fig-text)">2</text>
</g>
</svg>
</figure>

How many books in each genre? The NULL genres form a group of their
own, shown as an empty cell:

```sql
SELECT genre, COUNT(*) AS books
FROM books
GROUP BY genre
ORDER BY books DESC, genre;
```

```text
┌─────────────┬───────┐
│    genre    │ books │
├─────────────┼───────┤
│ novel       │ 7     │
│ programming │ 3     │
│             │ 2     │
│ romance     │ 2     │
│ satire      │ 2     │
│ sci-fi      │ 2     │
│ children    │ 1     │
│ dystopia    │ 1     │
│ fantasy     │ 1     │
│ self-help   │ 1     │
└─────────────┴───────┘
```

To keep only some **groups**, use `HAVING`. `WHERE` filters rows before
they are grouped; `HAVING` filters the groups after. The authors with
more than one book:

```sql
SELECT author, COUNT(*) AS books
FROM books
GROUP BY author
HAVING COUNT(*) > 1
ORDER BY books DESC, author;
```

```text
┌───────────────┬───────┐
│    author     │ books │
├───────────────┼───────┤
│ Ismail Kadare │ 3     │
│ George Orwell │ 2     │
│ Jane Austen   │ 2     │
└───────────────┴───────┘
```

Both can appear in one query. Genres whose books average more than 300
pages, leaving out the books with no genre:

```sql
SELECT genre, COUNT(*) AS books, ROUND(AVG(pages)) AS avg_pages
FROM books
WHERE genre IS NOT NULL
GROUP BY genre
HAVING AVG(pages) > 300
ORDER BY avg_pages DESC;
```

```text
┌─────────────┬───────┬───────────┐
│    genre    │ books │ avg_pages │
├─────────────┼───────┼───────────┤
│ romance     │ 2     │ 453.0     │
│ sci-fi      │ 2     │ 451.0     │
│ programming │ 3     │ 408.0     │
│ novel       │ 7     │ 388.0     │
│ dystopia    │ 1     │ 328.0     │
│ self-help   │ 1     │ 320.0     │
│ fantasy     │ 1     │ 310.0     │
└─────────────┴───────┴───────────┘
```

`WHERE` cannot test an aggregate, because when `WHERE` runs, the groups
do not exist yet. SQLite says so:

```sql
SELECT author, COUNT(*) FROM books WHERE COUNT(*) > 1 GROUP BY author;
```

```text
Parse error: misuse of aggregate: COUNT()
  SELECT author, COUNT(*) FROM books WHERE COUNT(*) > 1 GROUP BY author;
                             error here ---^
```

!!! tip "Try it"

    Count the available and the unavailable books, in one query.

??? success "Answer"

    Group by the `available` column itself:

    ```sql
    SELECT available, COUNT(*) AS books FROM books GROUP BY available;
    ```

    ```text
    ┌───────────┬───────┐
    │ available │ books │
    ├───────────┼───────┤
    │ 0         │ 6     │
    │ 1         │ 16    │
    └───────────┴───────┘
    ```

## Step 11: Interpret results correctly

A query that runs is not necessarily a query that answers your
question. Most wrong results come from one fact: **SQL does not run a
query in the order you write it.**

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 176" role="img" aria-labelledby="sq-ord-title sq-ord-desc">
<title id="sq-ord-title">The order you write a query and the order it runs</title>
<desc id="sq-ord-desc">You write SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY, LIMIT. The database runs FROM first, then WHERE, GROUP BY, HAVING, then SELECT, then ORDER BY and LIMIT. SELECT moves from first to fifth.</desc>
<text x="3" y="14" font-size="11" font-weight="700" fill="var(--h-fig-muted)">YOU WRITE</text>
<text x="3" y="122" font-size="11" font-weight="700" fill="var(--h-fig-muted)">THE DATABASE RUNS</text>
<g font-size="12" font-weight="700" text-anchor="middle" font-family="var(--md-code-font-family, monospace)">
<rect x="3" y="22" width="90" height="34" rx="8" fill="var(--h-cherry)"/><text x="48" y="44" fill="#ffffff">SELECT</text>
<rect x="101" y="22" width="90" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="146" y="44" fill="var(--h-fig-text)">FROM</text>
<rect x="199" y="22" width="90" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="244" y="44" fill="var(--h-fig-text)">WHERE</text>
<rect x="297" y="22" width="90" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="342" y="44" fill="var(--h-fig-text)">GROUP BY</text>
<rect x="395" y="22" width="90" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="440" y="44" fill="var(--h-fig-text)">HAVING</text>
<rect x="493" y="22" width="90" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="538" y="44" fill="var(--h-fig-text)">ORDER BY</text>
<rect x="591" y="22" width="86" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="634" y="44" fill="var(--h-fig-text)">LIMIT</text>
<rect x="3" y="130" width="90" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="48" y="152" fill="var(--h-fig-text)">1 FROM</text>
<rect x="101" y="130" width="90" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="146" y="152" fill="var(--h-fig-text)">2 WHERE</text>
<rect x="199" y="130" width="90" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="244" y="152" fill="var(--h-fig-text)">3 GROUP BY</text>
<rect x="297" y="130" width="90" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="342" y="152" fill="var(--h-fig-text)">4 HAVING</text>
<rect x="395" y="130" width="90" height="34" rx="8" fill="var(--h-cherry)"/><text x="440" y="152" fill="#ffffff">5 SELECT</text>
<rect x="493" y="130" width="90" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="538" y="152" fill="var(--h-fig-text)">6 ORDER BY</text>
<rect x="591" y="130" width="86" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="634" y="152" fill="var(--h-fig-text)">7 LIMIT</text>
</g>
<g stroke="var(--h-fig-line)" stroke-width="1.6" fill="none">
<line x1="146" y1="58" x2="48" y2="128"/>
<line x1="244" y1="58" x2="146" y2="128"/>
<line x1="342" y1="58" x2="244" y2="128"/>
<line x1="440" y1="58" x2="342" y2="128"/>
<line x1="538" y1="58" x2="538" y2="128"/>
<line x1="634" y1="58" x2="634" y2="128"/>
</g>
<line x1="48" y1="58" x2="440" y2="128" stroke="var(--h-cherry)" stroke-width="2.5"/>
</svg>
</figure>

Read it in that order, and the rules stop being arbitrary:

- **`WHERE` cannot use aggregates or column aliases**: it runs before
  any groups or names exist. That is what `HAVING` is for.
- **`ORDER BY` can use aliases**, such as `ORDER BY books`: it runs after
  `SELECT` has named them.
- **`LIMIT` applies last**, to the sorted result. "Top three" only means
  something after an `ORDER BY`.

A few more traps when reading results:

- **An aggregate over no rows is NULL, not zero.** The page count of an
  author the library does not have prints as an empty cell:

    ```sql
    SELECT SUM(pages) AS total FROM books WHERE author = 'Nobody';
    ```

    ```text
    ┌───────┐
    │ total │
    ├───────┤
    │       │
    └───────┘
    ```

- **Whole numbers divide as whole numbers.** Make one side a decimal to
  get a decimal answer:

    ```sql
    SELECT 7 / 2 AS whole, 7 / 2.0 AS decimal;
    ```

    ```text
    ┌───────┬─────────┐
    │ whole │ decimal │
    ├───────┼─────────┤
    │ 3     │ 3.5     │
    └───────┴─────────┘
    ```

- **Every column in a grouped `SELECT` must be grouped or aggregated.**
  SQLite lets this query run, and shows *one* title from each genre,
  whichever it met first:

    ```sql
    SELECT genre, title FROM books GROUP BY genre;
    ```

    ```text
    ┌─────────────┬───────────────────────────────────┐
    │    genre    │               title               │
    ├─────────────┼───────────────────────────────────┤
    │             │ Vargjet e lira                    │
    │ children    │ The Little Prince                 │
    │ dystopia    │ Nineteen Eighty-Four              │
    │ fantasy     │ The Hobbit                        │
    │ novel       │ Kronikë në gur                    │
    │ programming │ Clean Code                        │
    │ romance     │ Pride and Prejudice               │
    │ satire      │ Shkëlqimi dhe rënia e shokut Zylo │
    │ sci-fi      │ Dune                              │
    │ self-help   │ Atomic Habits                     │
    └─────────────┴───────────────────────────────────┘
    ```

    That is not "the" novel; it is an arbitrary one. Most other databases
    refuse the query outright. Treat a column that is neither grouped nor
    aggregated as a bug.

## Step 12: SQL from Python

Programs use databases through code, not the shell. Python's built-in
`sqlite3` module runs SQL on a SQLite file. Save this next to
`books.db` and run it:

```python title="kadare.py"
import sqlite3
from contextlib import closing

with closing(sqlite3.connect("books.db")) as connection:
    cursor = connection.execute(
        "SELECT title, year FROM books WHERE author = ? ORDER BY year",
        ("Ismail Kadare",),
    )
    rows = cursor.fetchall()

print(rows[0])
for title, year in rows:
    print(year, title)
```

```text
('Gjenerali i ushtrisë së vdekur', 1963)
1963 Gjenerali i ushtrisë së vdekur
1971 Kronikë në gur
1978 Prilli i thyer
```

- `sqlite3.connect()` opens the database file.
- `connection.execute()` runs one SQL statement and returns a
  **cursor**; `fetchall()` gives the rows as a list of tuples.
- `closing(...)`, from `contextlib`, closes the connection at the end of
  the block, like `with open(...)` closes a file.

Changing data needs one more thing: a **commit**, which makes the change
permanent. Using the connection itself in a `with` statement does it:
it commits if the block succeeds, and rolls back if an exception is
raised inside.

```python title="add_book.py"
import sqlite3
from contextlib import closing


def add_book(path, title, author, year):
    """Insert one book and return its new id."""
    with closing(sqlite3.connect(path)) as connection, connection:
        cursor = connection.execute(
            "INSERT INTO books (title, author, year) VALUES (?, ?, ?)",
            (title, author, year),
        )
        return cursor.lastrowid


new_id = add_book("books.db", "Kështjella", "Ismail Kadare", 1970)
print("Added book", new_id)
```

```text
Added book 24
```

On its own, `with connection:` commits but does **not** close the
connection. That surprises almost everyone, hence `closing` as well.
`lastrowid` is the `id` SQLite gave the new row.

### Placeholders, never f-strings

Every query above has `?` where a value goes, and passes the values
separately, as a tuple. **Never build SQL by pasting values into the
string.** See what happens when the "author" comes from a user who
types `x' OR '1'='1`:

```python title="injection.py"
import sqlite3
from contextlib import closing

name = "x' OR '1'='1"

with closing(sqlite3.connect("books.db")) as connection:
    query = f"SELECT title FROM books WHERE author = '{name}'"
    print(query)
    print(len(connection.execute(query).fetchall()), "rows")

    safe = connection.execute(
        "SELECT title FROM books WHERE author = ?", (name,)
    ).fetchall()
    print(len(safe), "rows")
```

```text
SELECT title FROM books WHERE author = 'x' OR '1'='1'
23 rows
0 rows
```

The text closed the quote and added a condition that is always true, so
the f-string query returned **every row**. With a placeholder, the same
text is treated as a name, and matches nothing. This attack is called
**SQL injection**, and it is still one of the most common ways real
applications are broken into.

!!! ai "AI in the loop"

    Assistants write SQL fluently, and a confident query can still answer
    the wrong question. Before you run one, **predict the result**: how
    many rows, roughly what values. If the real result surprises you,
    find out why before you use it. And never run an `UPDATE` or
    `DELETE` from an assistant until you have run its `WHERE` as a
    `SELECT` and seen exactly which rows it touches.

## When something goes wrong

??? note "The shell shows `...>` and nothing happens"

    The statement has no semicolon yet, so the shell is waiting for the
    rest. Type `;` and press ++enter++.

??? note "`Parse error: no such table: books`"

    You opened a different database, often a new, empty one created by a
    typo in the file name. Check with `.databases`, and load `books.sql`
    into the file you meant.

??? note "`Parse error: no such column: Kadare`"

    Text needs single quotes: `WHERE author = 'Ismail Kadare'`. Without
    them, SQL reads the word as a column name. Double quotes are for the
    names of tables and columns, not for values.

??? note "`Parse error: misuse of aggregate`"

    An aggregate such as `COUNT` or `SUM` is in `WHERE`. Move the
    condition to `HAVING`, after `GROUP BY`.

??? note "`Runtime error: UNIQUE constraint failed` or `NOT NULL constraint failed`"

    The row breaks a rule of the table: a value that must be unique is
    already there, or a required column is missing. Read the column name
    in the message, and fix the data, not the rule.

??? note "My query returns nothing, and I know the rows exist"

    Check for `= NULL` (use `IS NULL`), for capital letters in text
    (`'kadare'` is not `'Kadare'`), and for extra spaces inside the
    quotes.

??? note "`sqlite3.ProgrammingError: Cannot operate on a closed database.`"

    The code used the connection after the `closing(...)` block ended.
    Do all the work, including `fetchall()`, inside the block.

## Practice set

Seven exercises, from easy to harder, on `books.db` as you left it after
the steps above. Try each one before you open the answer. If your data
looks different, reload `books.sql` and you will get slightly different
numbers; the queries stay the same.

**1. One author.** List George Orwell's books, oldest first.

??? success "Answer"

    ```sql
    SELECT title, year FROM books
    WHERE author = 'George Orwell'
    ORDER BY year;
    ```

    ```text
    ┌──────────────────────┬──────┐
    │        title         │ year │
    ├──────────────────────┼──────┤
    │ Animal Farm          │ 1945 │
    │ Nineteen Eighty-Four │ 1949 │
    └──────────────────────┴──────┘
    ```

**2. Two conditions.** Find the programming books longer than 400 pages.

??? success "Answer"

    ```sql
    SELECT title, pages FROM books
    WHERE genre = 'programming' AND pages > 400;
    ```

    ```text
    ┌────────────┬───────┐
    │   title    │ pages │
    ├────────────┼───────┤
    │ Clean Code │ 464   │
    └────────────┴───────┘
    ```

**3. Count per genre.** How many books does each genre have? Leave out
the books with no genre, and show the biggest genre first.

??? success "Answer"

    ```sql
    SELECT genre, COUNT(*) AS books
    FROM books
    WHERE genre IS NOT NULL
    GROUP BY genre
    ORDER BY books DESC, genre;
    ```

    ```text
    ┌─────────────┬───────┐
    │    genre    │ books │
    ├─────────────┼───────┤
    │ novel       │ 7     │
    │ programming │ 3     │
    │ romance     │ 2     │
    │ satire      │ 2     │
    │ sci-fi      │ 2     │
    │ children    │ 1     │
    │ dystopia    │ 1     │
    │ fantasy     │ 1     │
    │ self-help   │ 1     │
    └─────────────┴───────┘
    ```

**4. Filter groups.** Which authors have more than 500 pages in the
library, in total? Largest first.

??? success "Answer"

    ```sql
    SELECT author, SUM(pages) AS total_pages
    FROM books
    GROUP BY author
    HAVING SUM(pages) > 500
    ORDER BY total_pages DESC;
    ```

    ```text
    ┌─────────────────────┬─────────────┐
    │       author        │ total_pages │
    ├─────────────────────┼─────────────┤
    │ Miguel de Cervantes │ 1072        │
    │ Jane Austen         │ 906         │
    │ Ismail Kadare       │ 824         │
    │ Frank Herbert       │ 612         │
    └─────────────────────┴─────────────┘
    ```

**5. Missing data.** Add *Juvenilia* by Ndre Mjeda without a year, then
list every book with no year.

??? success "Answer"

    ```sql
    INSERT INTO books (title, author) VALUES ('Juvenilia', 'Ndre Mjeda');
    SELECT id, title, author FROM books WHERE year IS NULL;
    ```

    ```text
    ┌────┬───────────┬────────────┐
    │ id │   title   │   author   │
    ├────┼───────────┼────────────┤
    │ 25 │ Juvenilia │ Ndre Mjeda │
    └────┴───────────┴────────────┘
    ```

**6. Update a group.** All the programming books have come back. Mark
them as available, and check how many rows changed.

??? success "Answer"

    ```sql
    UPDATE books SET available = 1 WHERE genre = 'programming';
    SELECT changes() AS changed;
    SELECT title, available FROM books WHERE genre = 'programming';
    ```

    ```text
    ┌─────────┐
    │ changed │
    ├─────────┤
    │ 3       │
    └─────────┘
    ┌──────────────────────────┬───────────┐
    │          title           │ available │
    ├──────────────────────────┼───────────┤
    │ Clean Code               │ 1         │
    │ The Pragmatic Programmer │ 1         │
    │ Fluent Python            │ 1         │
    └──────────────────────────┴───────────┘
    ```

**7. Delete safely.** Remove every book shorter than 150 pages. Look at
the rows first, then delete inside a transaction, and check the count
before you `COMMIT`.

??? success "Answer"

    ```sql
    SELECT id, title, pages FROM books WHERE pages < 150;
    ```

    ```text
    ┌────┬───────────────────┬───────┐
    │ id │       title       │ pages │
    ├────┼───────────────────┼───────┤
    │ 6  │ The Little Prince │ 96    │
    │ 8  │ Animal Farm       │ 112   │
    └────┴───────────────────┴───────┘
    ```

    ```sql
    BEGIN;
    DELETE FROM books WHERE pages < 150;
    SELECT changes() AS deleted;
    SELECT COUNT(*) AS books_left FROM books;
    COMMIT;
    ```

    ```text
    ┌─────────┐
    │ deleted │
    ├─────────┤
    │ 2       │
    └─────────┘
    ┌────────────┐
    │ books_left │
    ├────────────┤
    │ 22         │
    └────────────┘
    ```

    If the number had been wrong, `ROLLBACK` instead of `COMMIT` would
    have undone the delete.

**8. From Python.** Write a function `titles_by(path, author)` that
returns a list of one author's titles, oldest first, using a
placeholder.

??? success "Answer"

    ```python title="titles_by.py"
    import sqlite3
    from contextlib import closing


    def titles_by(path, author):
        """Return the titles of one author's books, oldest first."""
        with closing(sqlite3.connect(path)) as connection:
            rows = connection.execute(
                "SELECT title FROM books WHERE author = ? ORDER BY year",
                (author,),
            ).fetchall()
        return [title for (title,) in rows]


    print(titles_by("books.db", "Jane Austen"))
    print(titles_by("books.db", "Nobody"))
    ```

    ```text
    ['Pride and Prejudice', 'Emma']
    []
    ```

## Explain it to someone

- [ ] What tables, rows, columns, types, primary keys and NULL are
- [ ] How to open a SQLite database, and run SQL in the shell and from a file
- [ ] How to create a table, with `NOT NULL`, `UNIQUE` and `DEFAULT`
- [ ] How to `INSERT` one row and several, and check what was added
- [ ] How to `SELECT` specific columns, and why `SELECT *` is rarely what you want
- [ ] How to filter rows with `WHERE`, including `IN`, `BETWEEN`, `LIKE` and `IS NULL`
- [ ] How to sort with `ORDER BY` and keep the top rows with `LIMIT`
- [ ] How to `UPDATE` and `DELETE` safely, and what a transaction protects
- [ ] What `COUNT`, `SUM`, `AVG`, `MIN` and `MAX` return, and how `COUNT(*)` differs from `COUNT(column)`
- [ ] How `GROUP BY` and `HAVING` work, and how `HAVING` differs from `WHERE`
- [ ] The order in which a query runs, and how it explains wrong results
- [ ] How to run SQL from Python, and why queries use placeholders

## Quick reference

| SQL | What it does |
|---|---|
| `CREATE TABLE t (id INTEGER PRIMARY KEY, ...)` | Create a table |
| `DROP TABLE IF EXISTS t` | Delete a table and its data |
| `SELECT col1, col2 FROM t` | Read some columns |
| `WHERE cond AND cond` | Keep matching rows |
| `ORDER BY col DESC LIMIT n OFFSET m` | Sort, then keep a page of rows |
| `INSERT INTO t (cols) VALUES (...), (...)` | Add rows |
| `UPDATE t SET col = value WHERE ...` | Change matching rows |
| `DELETE FROM t WHERE ...` | Remove matching rows |
| `COUNT(*)`, `SUM`, `AVG`, `MIN`, `MAX` | Summarise rows |
| `GROUP BY col HAVING cond` | One row per group; filter the groups |
| `BEGIN; ... COMMIT;` or `ROLLBACK;` | Keep or undo a group of changes |
| `.headers on`, `.mode box`, `.tables`, `.schema t` | SQLite shell settings and inspection |
| `connection.execute(sql, (value,))` | Run SQL from Python, with placeholders |

## Next

The `books` table repeats the author's name on every one of their
books, and it has no idea who borrowed what. Next you split the library
into several tables that point at each other, and **join** them back
together to answer questions.

[SQL: Joins & Relationships](sql-joins.md){ .h-button }
