# Object-Relational Mapping

<span class="badge badge--time">2 h</span>
<span class="badge badge--level">Data & APIs</span>
<span class="badge">Needs: Database Design & Normalization</span>

So far you have written SQL by hand and got rows back as tuples. An
**object-relational mapper**, or **ORM**, lets you work with the
database through Python classes instead: a table becomes a class, a row
becomes an object, and the ORM writes the SQL for you. In this tutorial
you map the library database with **SQLAlchemy**, the most widely used
ORM in Python, and read, create, change and delete data without writing
a single SQL string.

## Why this matters

Almost every Python web application talks to its database through an
ORM. It removes a lot of repetitive code, keeps queries safe from
injection, and lets you follow links between tables as easily as
following attributes: `book.author.name`. It also hides the SQL, which
is exactly why you learned SQL first: when an ORM is slow or does
something surprising, the answer is always in the SQL it generates.

## Before you start

You need the library database from
[SQL: Joins & Relationships](sql-joins.md). Reload it, so your results
match this page:

```bash
cd ~/library
sqlite3 library.db < library.sql
```

SQLAlchemy is a package, so install it in a **virtual environment**, as
in [Environment & First Programs](../../02-foundations/python/environment.md):

```bash
sudo apt install -y python3-venv     # only if the next line fails
python3 -m venv .venv
source .venv/bin/activate
pip install sqlalchemy
python3 -c "import sqlalchemy; print(sqlalchemy.__version__)"
```

```text
2.1.6
```

Any version from 2.0 up works with this page. Create every file in
`~/library`, next to `library.db`, and run it with the venv active.

## Step 1: What an ORM does

An ORM connects two worlds that organise data differently:

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 250" role="img" aria-labelledby="om-map-title om-map-desc">
<title id="om-map-title">How an ORM maps classes to tables</title>
<desc id="om-map-desc">On the Python side, the class Book with attributes id, title, author_id and year, and one object, Dune. On the database side, the books table with the same columns, and one row for Dune. A class maps to a table, an attribute to a column, and an object to a row. SQLAlchemy sits between them and turns Python calls into SQL.</desc>
<defs><marker id="om-map-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-cherry)"/></marker></defs>
<g font-size="11" font-weight="700" fill="var(--h-fig-muted)"><text x="3" y="14">PYTHON</text><text x="677" y="14" text-anchor="end">DATABASE</text></g>
<g font-family="var(--md-code-font-family, monospace)" font-size="12">
<rect x="3" y="24" width="210" height="110" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="16" y="46" font-weight="700" fill="var(--h-fig-text)">class Book</text>
<g fill="var(--h-fig-text)"><text x="28" y="68">id: int</text><text x="28" y="86">title: str</text><text x="28" y="104">author_id: int</text><text x="28" y="122">year: int | None</text></g>
<rect x="3" y="150" width="210" height="84" rx="8" fill="var(--h-cherry)"/>
<text x="16" y="172" font-weight="700" fill="#ffffff">dune = Book(...)</text>
<g fill="#ffffff"><text x="28" y="192">dune.title = "Dune"</text><text x="28" y="210">dune.year = 1965</text><text x="28" y="226">dune.author → Author</text></g>
<rect x="467" y="24" width="210" height="110" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="480" y="46" font-weight="700" fill="var(--h-fig-text)">TABLE books</text>
<g fill="var(--h-fig-text)"><text x="492" y="68">id INTEGER</text><text x="492" y="86">title TEXT</text><text x="492" y="104">author_id INTEGER</text><text x="492" y="122">year INTEGER</text></g>
<rect x="467" y="150" width="210" height="84" rx="8" fill="var(--h-cherry)"/>
<text x="480" y="172" font-weight="700" fill="#ffffff">one row</text>
<g fill="#ffffff"><text x="492" y="192">8 | Dune | 5 | 1965</text><text x="492" y="216">author_id 5 → authors</text></g>
</g>
<rect x="260" y="92" width="160" height="70" rx="10" fill="var(--h-fig-box)" stroke="var(--h-cherry)" stroke-width="2"/>
<text x="340" y="122" text-anchor="middle" font-size="13" font-weight="700" fill="var(--h-cherry)">SQLAlchemy</text>
<text x="340" y="142" text-anchor="middle" font-size="11" fill="var(--h-fig-muted)">writes the SQL</text>
<g stroke="var(--h-cherry)" stroke-width="2" marker-end="url(#om-map-arrow)" marker-start="url(#om-map-arrow)">
<line x1="218" y1="80" x2="462" y2="80"/><line x1="218" y1="192" x2="462" y2="192"/>
</g>
<g font-size="11" font-weight="700" fill="var(--h-fig-text)" text-anchor="middle"><text x="340" y="72">class ↔ table, attribute ↔ column</text><text x="340" y="184">object ↔ row, relationship ↔ foreign key</text></g>
</svg>
</figure>

| Python | Database |
|---|---|
| a class, `Book` | a table, `books` |
| an attribute, `title` | a column, `title` |
| an object, `dune` | a row |
| a relationship, `dune.author` | a foreign key, `author_id` |

You describe the mapping once, in **models**: classes that say which
table and columns they stand for. From then on you ask for objects, and
SQLAlchemy writes the `SELECT`, `INSERT`, `UPDATE` and `DELETE`.

## Step 2: Map your first classes

Create `models.py` with two models, for `authors` and `books`:

```python title="models.py"
"""SQLAlchemy models for the library database: a first version."""
from sqlalchemy import ForeignKey
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column


class Base(DeclarativeBase):
    """The base class of every model."""


class Author(Base):
    """A row of the authors table."""

    __tablename__ = "authors"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str]
    country: Mapped[str | None]

    def __repr__(self):
        return f"Author({self.name!r})"


class Book(Base):
    """A row of the books table."""

    __tablename__ = "books"

    id: Mapped[int] = mapped_column(primary_key=True)
    title: Mapped[str]
    author_id: Mapped[int] = mapped_column(ForeignKey("authors.id"))
    year: Mapped[int | None]

    def __repr__(self):
        return f"Book({self.title!r}, {self.year})"
```

- Every model inherits from one `Base` class, made from
  `DeclarativeBase`. `Base` keeps the list of all your tables.
- `__tablename__` names the table the class stands for.
- Each `Mapped[...]` line is a column, and its type comes from the
  annotation: `Mapped[int]` is an integer column that **cannot be
  NULL**, `Mapped[int | None]` one that can.
- `mapped_column(...)` adds details: `primary_key=True`, or
  `ForeignKey("authors.id")` for a foreign key.

The tables already exist in `library.db`, so these classes just
describe them.

## Step 3: Engine, session and a first query

Two objects connect your models to the database:

- the **engine** knows *where* the database is, from a URL:
  `sqlite:///library.db` is the file `library.db` in the current folder.
  Three slashes; four would mean an absolute path;
- a **session** is one conversation with the database. You open it, ask
  for objects or change them, and close it.

```python title="first_query.py"
from sqlalchemy import create_engine, select
from sqlalchemy.orm import Session

from models import Book

engine = create_engine("sqlite:///library.db")

with Session(engine) as session:
    books = session.scalars(select(Book).order_by(Book.year).limit(4)).all()

print(books)
first = books[0]
print(type(first).__name__, first.id, first.title, first.author_id)
```

```text
[Book('Pride and Prejudice', 1813), Book('The Hobbit', 1937), Book('Animal Farm', 1945), Book('Nineteen Eighty-Four', 1949)]
Book 7 Pride and Prejudice 4
```

`select(Book)` builds a query for `Book` objects; `session.scalars(...)`
runs it and gives you the objects, and `.all()` collects them in a list.
What comes back are real `Book` objects, with attributes, not tuples.

## Step 4: See the SQL

A query object prints as the SQL it stands for:

```python title="show_sql.py"
from sqlalchemy import select

from models import Book

query = select(Book).where(Book.year < 1950).order_by(Book.year)
print(query)
```

```text
SELECT books.id, books.title, books.author_id, books.year
FROM books
WHERE books.year < :year_1 ORDER BY books.year
```

That is the same `SELECT` you would write by hand. `:year_1` is a
**placeholder**: the value 1950 is sent separately, exactly like the `?`
in `sqlite3`. An ORM always uses placeholders, so its queries are safe
from SQL injection.

Whenever an ORM query surprises you, print it.

## Step 5: Query with select

The usual operations, side by side with the SQL they produce:

| SQLAlchemy | SQL |
|---|---|
| `session.get(Book, 8)` | `... WHERE id = 8` (by primary key) |
| `select(Book).where(Book.year < 1950)` | `WHERE year < 1950` |
| `.where(cond1, cond2)` | `WHERE cond1 AND cond2` |
| `.order_by(Book.year.desc())` | `ORDER BY year DESC` |
| `.limit(3).offset(3)` | `LIMIT 3 OFFSET 3` |
| `session.scalars(query).all()` | every row, as objects |
| `session.scalars(query).first()` | the first row, or `None` |
| `session.scalar(select(func.count()).select_from(Book))` | `SELECT COUNT(*) FROM books` |

```python title="reading.py"
from sqlalchemy import create_engine, func, select
from sqlalchemy.orm import Session

from models import Book

engine = create_engine("sqlite:///library.db")

with Session(engine) as session:
    print(session.get(Book, 8))
    print(session.get(Book, 99))

    old = session.scalars(
        select(Book).where(Book.year < 1950).order_by(Book.year)
    ).all()
    print(old)

    kadare = session.scalars(
        select(Book).where(Book.author_id == 1, Book.year > 1965)
    ).all()
    print(kadare)

    newest = session.scalars(select(Book).order_by(Book.year.desc())).first()
    print(newest)

    count = session.scalar(select(func.count()).select_from(Book))
    print(count, "books")
```

```text
Book('Dune', 1965)
None
[Book('Pride and Prejudice', 1813), Book('The Hobbit', 1937), Book('Animal Farm', 1945), Book('Nineteen Eighty-Four', 1949)]
[Book('Kronikë në gur', 1971), Book('Prilli i thyer', 1978)]
Book('Prilli i thyer', 1978)
10 books
```

`session.get` returns `None` when there is no such row, so check it
before you use the result. Conditions are written with ordinary Python
operators on the class attributes: `Book.year < 1950` does not compare
anything yet; it builds a piece of SQL.

!!! tip "Try it"

    Print the titles of the books published in the 1940s, oldest first.

??? success "Answer"

    `Book.year.between(1940, 1949)` is the ORM's `BETWEEN`:

    ```python
    query = (select(Book.title)
             .where(Book.year.between(1940, 1949))
             .order_by(Book.year))
    print(session.scalars(query).all())
    ```

    ```text
    ['Animal Farm', 'Nineteen Eighty-Four']
    ```

## Step 6: Relationships

Columns are only half of the mapping. The other half is the links
between tables. Replace `models.py` with the full version, which maps
all seven tables:

```python title="models.py"
"""SQLAlchemy models for the library database, library.db."""
from sqlalchemy import Column, ForeignKey, Table, create_engine, event
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship


class Base(DeclarativeBase):
    """The base class of every model."""


book_tags = Table(
    "book_tags",
    Base.metadata,
    Column("book_id", ForeignKey("books.id"), primary_key=True),
    Column("tag_id", ForeignKey("tags.id"), primary_key=True),
)


class Author(Base):
    """A row of the authors table."""

    __tablename__ = "authors"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str]
    country: Mapped[str | None]

    books: Mapped[list["Book"]] = relationship(back_populates="author")

    def __repr__(self):
        return f"Author({self.name!r})"


class Book(Base):
    """A row of the books table."""

    __tablename__ = "books"

    id: Mapped[int] = mapped_column(primary_key=True)
    title: Mapped[str]
    author_id: Mapped[int] = mapped_column(ForeignKey("authors.id"))
    year: Mapped[int | None]

    author: Mapped["Author"] = relationship(back_populates="books")
    tags: Mapped[list["Tag"]] = relationship(
        secondary=book_tags, back_populates="books"
    )
    loans: Mapped[list["Loan"]] = relationship(back_populates="book")

    def __repr__(self):
        return f"Book({self.title!r}, {self.year})"


class Member(Base):
    """A row of the members table."""

    __tablename__ = "members"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str]
    email: Mapped[str] = mapped_column(unique=True)
    joined_on: Mapped[str]

    card: Mapped["LibraryCard | None"] = relationship(back_populates="member")
    loans: Mapped[list["Loan"]] = relationship(back_populates="member")

    def __repr__(self):
        return f"Member({self.name!r})"


class LibraryCard(Base):
    """A row of the library_cards table: at most one per member."""

    __tablename__ = "library_cards"

    member_id: Mapped[int] = mapped_column(
        ForeignKey("members.id"), primary_key=True
    )
    card_number: Mapped[str] = mapped_column(unique=True)
    expires_on: Mapped[str]

    member: Mapped["Member"] = relationship(back_populates="card")

    def __repr__(self):
        return f"LibraryCard({self.card_number!r})"


class Loan(Base):
    """A row of the loans table: one member borrowing one book."""

    __tablename__ = "loans"

    id: Mapped[int] = mapped_column(primary_key=True)
    book_id: Mapped[int] = mapped_column(ForeignKey("books.id"))
    member_id: Mapped[int] = mapped_column(ForeignKey("members.id"))
    loaned_on: Mapped[str]
    returned_on: Mapped[str | None]

    book: Mapped["Book"] = relationship(back_populates="loans")
    member: Mapped["Member"] = relationship(back_populates="loans")

    def __repr__(self):
        return f"Loan({self.book.title!r}, {self.loaned_on})"


class Tag(Base):
    """A row of the tags table."""

    __tablename__ = "tags"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(unique=True)

    books: Mapped[list["Book"]] = relationship(
        secondary=book_tags, back_populates="tags"
    )

    def __repr__(self):
        return f"Tag({self.name!r})"


def make_engine(path="library.db"):
    """Return an engine for a SQLite file, with foreign keys turned on."""
    engine = create_engine(f"sqlite:///{path}")

    @event.listens_for(engine, "connect")
    def turn_on_foreign_keys(dbapi_connection, connection_record):
        dbapi_connection.execute("PRAGMA foreign_keys = ON")

    return engine
```

New things in this version:

- **`relationship()`** adds an attribute that follows a foreign key.
  `Book.author` gives the `Author` object, and `Author.books` the list
  of that author's books. `back_populates` connects the two sides, so
  changing one updates the other.
- **One-to-one.** `Member.card` is annotated `"LibraryCard | None"`, a
  single object or nothing, instead of a list.
- **Many-to-many.** `book_tags` is a plain `Table`, not a class: it only
  holds two foreign keys. `relationship(secondary=book_tags)` tells
  SQLAlchemy to go through it, so `book.tags` is a list of `Tag`
  objects.
- **`make_engine()`** turns on foreign keys for every connection, the
  same `PRAGMA` as in the SQL tutorials, using an event that runs each
  time SQLAlchemy connects.

Now follow the links like attributes:

```python title="relations.py"
from sqlalchemy import select
from sqlalchemy.orm import Session

from models import Author, Book, Member, make_engine

engine = make_engine()

with Session(engine) as session:
    dune = session.get(Book, 8)
    print(dune.author, dune.author.country)
    print([tag.name for tag in dune.tags])

    kadare = session.scalars(
        select(Author).where(Author.name == "Ismail Kadare")
    ).one()
    print(kadare.books)

    arta = session.get(Member, 1)
    print(arta.card)
    for loan in arta.loans:
        print(" ", loan.loaned_on, loan.book.title, loan.returned_on)

    lea = session.get(Member, 5)
    print(lea.card, lea.loans)
```

```text
Author('Frank Herbert') United States
['classic', 'sci-fi']
[Book('Kronikë në gur', 1971), Book('Prilli i thyer', 1978), Book('Gjenerali i ushtrisë së vdekur', 1963)]
LibraryCard('LIB-0001')
  2026-09-02 Nineteen Eighty-Four 2026-09-16
  2026-09-18 Kronikë në gur 2026-10-01
  2026-10-03 Prilli i thyer None
  2026-10-22 The Hobbit None
None []
```

No joins written anywhere: each attribute access runs the query it
needs. Lea has no card and no loans, so she gets `None` and `[]`.

## Step 7: Create

To add a row, create an object, `add` it to the session, and `commit`:

```python title="create.py"
from sqlalchemy.orm import Session

from models import Author, Book, make_engine

engine = make_engine()

with Session(engine) as session:
    le_guin = session.get(Author, 8)
    earthsea = Book(title="A Wizard of Earthsea", year=1968, author=le_guin)
    session.add(earthsea)
    print("before commit:", earthsea.id)
    session.commit()
    print("after commit:", earthsea.id)

    mjeda = Author(name="Ndre Mjeda", country="Albania",
                   books=[Book(title="Juvenilia", year=1917)])
    session.add(mjeda)
    session.commit()
    print(mjeda.id, mjeda.books, mjeda.books[0].id)
```

```text
before commit: None
after commit: 11
9 [Book('Juvenilia', 1917)] 12
```

- Before the commit, the new book has no `id`: the database assigns it
  during the `INSERT`, and SQLAlchemy fills it in.
- `author=le_guin` sets the relationship, and SQLAlchemy works out
  `author_id` from it. You think in objects, not ids.
- Adding Mjeda also added his book: objects reachable through a
  relationship are saved with it. This is called a **cascade**.

## Step 8: Update

To change a row, change the object's attributes and commit. The session
notices what changed, and lists those objects in `session.dirty`:

```python title="update.py"
from sqlalchemy import select
from sqlalchemy.orm import Session

from models import Book, Loan, Tag, make_engine

engine = make_engine()

with Session(engine) as session:
    loan = session.get(Loan, 12)
    loan.returned_on = "2026-10-31"
    print(session.dirty)

    achebe_book = session.get(Book, 10)
    classic = session.scalars(select(Tag).where(Tag.name == "classic")).one()
    achebe_book.tags.append(classic)

    session.commit()
    print(loan, loan.returned_on)
    print(achebe_book.tags)
```

```text
IdentitySet([Loan('The Hobbit', 2026-10-22)])
Loan('The Hobbit', 2026-10-22) 2026-10-31
[Tag('classic')]
```

`achebe_book.tags.append(classic)` added a row to the junction table
`book_tags`, without you ever naming it. The commit sends every pending
change in **one transaction**: all of them are saved, or none.

## Step 9: Delete

`session.delete(obj)`, then commit. An unused tag goes without trouble.
Deleting an author who still has books is refused, and the session is
rolled back to undo the attempt:

```python title="delete.py"
from sqlalchemy import select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import Session

from models import Author, Tag, make_engine

engine = make_engine()

with Session(engine) as session:
    poetry = session.scalars(select(Tag).where(Tag.name == "poetry")).one()
    session.delete(poetry)
    session.commit()
    print(session.scalars(select(Tag.name)).all())

    kadare = session.get(Author, 1)
    session.delete(kadare)
    try:
        session.commit()
    except IntegrityError as error:
        session.rollback()
        print("Refused:", error.orig)
    print(session.get(Author, 1))
```

```text
['classic', 'albanian', 'dystopia', 'sci-fi', 'fantasy']
Refused: NOT NULL constraint failed: books.author_id
Author('Ismail Kadare')
```

The message is not the foreign key error you might expect. Before
deleting Kadare, SQLAlchemy tried to **unlink** his books by setting
their `author_id` to NULL, which is its default. The `NOT NULL` rule on
`author_id` refused, and nothing was changed.

That default is deliberate: an ORM never deletes rows you did not ask
it to delete. Making it delete an author's books with the author is
possible, with `cascade="all, delete-orphan"` on the relationship, but
think twice: it is the delete anomaly from the design tutorial, on
purpose.

## Step 10: Joins and aggregates

For reports, ask for columns instead of whole objects. `join` uses a
relationship to know how two tables connect, `outerjoin` is a
`LEFT JOIN`, and `func` gives you SQL functions such as `count`:

```python title="aggregates.py"
from sqlalchemy import func, select
from sqlalchemy.orm import Session

from models import Author, Book, Loan, Member, make_engine

engine = make_engine()

per_author = (
    select(Author.name, func.count(Book.id).label("books"))
    .outerjoin(Author.books)
    .group_by(Author.id)
    .order_by(func.count(Book.id).desc(), Author.name)
)

out_now = (
    select(Member.name, Book.title)
    .join(Loan.member)
    .join(Loan.book)
    .where(Loan.returned_on.is_(None))
    .order_by(Loan.loaned_on)
)

with Session(engine) as session:
    for name, books in session.execute(per_author):
        print(f"{books}  {name}")
    print()
    for name, title in session.execute(out_now):
        print(f"{name}: {title}")
```

```text
3  Ismail Kadare
2  George Orwell
1  Chinua Achebe
1  Dritëro Agolli
1  Frank Herbert
1  J. R. R. Tolkien
1  Jane Austen
1  Ndre Mjeda
1  Ursula K. Le Guin

Erion Shehu: Pride and Prejudice
Arta Hoxha: Prilli i thyer
Drita Leka: Dune
```

`session.execute(query)` returns rows, and each row unpacks like a
tuple. `outerjoin` kept every author, and Le Guin now counts one book,
the one you added in Step 7.

!!! tip "Try it"

    Print the SQL of the `per_author` query.

??? success "Answer"

    Add `print(per_author)` at the end of the script:

    ```text
    SELECT authors.name, count(books.id) AS books 
    FROM authors LEFT OUTER JOIN books ON authors.id = books.author_id GROUP BY authors.id ORDER BY count(books.id) DESC, authors.name
    ```

    The `LEFT OUTER JOIN`, the `count`, the `GROUP BY` and the
    `ORDER BY` all came from the Python calls.

## Step 11: The N+1 problem

Following relationships is convenient, and it hides a trap. This script
counts the SQL statements the session sends:

```python title="n_plus_one.py"
from sqlalchemy import event, select
from sqlalchemy.orm import Session, selectinload

from models import Book, make_engine

engine = make_engine()
queries = []


@event.listens_for(engine, "before_cursor_execute")
def count_query(conn, cursor, statement, parameters, context, many):
    queries.append(statement)


with Session(engine) as session:
    for book in session.scalars(select(Book)):
        book.author.name
print("lazy loading:", len(queries), "queries")

queries.clear()
with Session(engine) as session:
    query = select(Book).options(selectinload(Book.author))
    for book in session.scalars(query):
        book.author.name
print("selectinload:", len(queries), "queries")
```

```text
lazy loading: 10 queries
selectinload: 2 queries
```

The first loop ran **1** query for the books, then **one more per
author** the first time each `book.author` was used: 1 + N queries. The
session remembers objects it has already loaded, so it was 10, not 13.
With 10 books that is fine. With 10,000 rows on a web page it is the
most common reason ORM code is slow.

`selectinload(Book.author)` tells the session to load all the authors
in **one** extra query. Whenever a loop follows a relationship, load it
up front like this.

## Step 12: Create tables from models

The models describe the schema, so SQLAlchemy can also **create** it.
On a new, empty file:

```python title="create_all.py"
from sqlalchemy import inspect
from sqlalchemy.schema import CreateTable

from models import Base, Book, make_engine

engine = make_engine("fresh.db")
Base.metadata.create_all(engine)

print(inspect(engine).get_table_names())
print(CreateTable(Book.__table__).compile(engine))
```

```text
['authors', 'book_tags', 'books', 'library_cards', 'loans', 'members', 'tags']

CREATE TABLE books (
    id INTEGER NOT NULL,
    title VARCHAR NOT NULL,
    author_id INTEGER NOT NULL,
    year INTEGER,
    PRIMARY KEY (id),
    FOREIGN KEY(author_id) REFERENCES authors (id)
)
```

`create_all` creates every table that does not exist yet, and leaves
existing ones alone. That is how a new project starts: write the
models, and let SQLAlchemy create the tables. `CreateTable` shows the
SQL it used.

When a project's models change later, `create_all` will **not** alter
existing tables. Real projects use a **migration** tool for that, such
as Alembic, which records each schema change as a small script.

## Step 13: Raw SQL when you need it

An ORM does not forbid SQL. For a query that is easier to write by hand,
`text()` runs it, with named placeholders:

```python title="raw_sql.py"
from sqlalchemy import text
from sqlalchemy.orm import Session

from models import make_engine

engine = make_engine()

with Session(engine) as session:
    rows = session.execute(
        text("SELECT name, joined_on FROM members WHERE joined_on < :day"),
        {"day": "2026-03-01"},
    ).all()

for name, joined_on in rows:
    print(joined_on, name)
```

```text
2026-01-15 Arta Hoxha
2026-02-03 Besnik Krasniqi
```

Use the ORM for everyday work, and SQL for reports and special cases.
Knowing both is the point.

!!! ai "AI in the loop"

    Assistants write SQLAlchemy code readily, but often in the **1.x**
    style, with `session.query(Book).filter(...)`, which still runs and
    is now legacy. Tell the assistant you use SQLAlchemy 2.x with
    `select()`. And for any ORM code that runs in a loop, print the query
    or count the statements, as in Step 11: the assistant cannot see your
    data, and N+1 is invisible until it is slow.

## When something goes wrong

??? note "`ModuleNotFoundError: No module named 'sqlalchemy'`"

    The venv is not active, or SQLAlchemy was installed outside it. Run
    `source .venv/bin/activate`, then `pip install sqlalchemy`.

??? note "`sqlalchemy.exc.OperationalError: no such table: books`"

    The engine opened a different file, usually because the script ran
    from another folder and `sqlite:///library.db` is relative. Run it
    from `~/library`, or use an absolute path:
    `sqlite:////home/you/library/library.db`.

??? note "`DetachedInstanceError: ... is not bound to a Session`"

    You used a relationship, such as `book.author`, after the
    `with Session(...)` block ended. The session is closed, so it cannot
    run the query. Do the work inside the block, or load the relationship
    up front with `selectinload`.

??? note "`IntegrityError` on commit"

    The change breaks a rule of the schema: a `NOT NULL`, `UNIQUE` or
    foreign key constraint. Read the message after `IntegrityError`, call
    `session.rollback()`, and fix the data.

??? note "`ArgumentError` or `InvalidRequestError` when the models load"

    Usually a typo in `back_populates`: both sides must name each other
    exactly. Check that `Author.books` says `back_populates="author"` and
    `Book.author` says `back_populates="books"`.

## Practice set

Six exercises on `library.db`, with the full `models.py`, continuing
from the steps above. Each answer is a small script; run it from
`~/library` with the venv active.

**1. A join.** List the titles of the books by authors from the United
Kingdom, alphabetically.

??? success "Answer"

    ```python title="p1_uk.py"
    from sqlalchemy import select
    from sqlalchemy.orm import Session

    from models import Author, Book, make_engine

    engine = make_engine()

    with Session(engine) as session:
        titles = session.scalars(
            select(Book.title)
            .join(Book.author)
            .where(Author.country == "United Kingdom")
            .order_by(Book.title)
        ).all()

    print(titles)
    ```

    ```text
    ['Animal Farm', 'Nineteen Eighty-Four', 'Pride and Prejudice', 'The Hobbit']
    ```

**2. Many-to-many.** Write `titles_with_tag(session, name)`, which
returns the sorted titles of the books with that tag, or `[]` if there
is no such tag.

??? success "Answer"

    ```python title="p2_by_tag.py"
    from sqlalchemy import select
    from sqlalchemy.orm import Session

    from models import Tag, make_engine


    def titles_with_tag(session, name):
        """Return the titles of the books with one tag, or [] if no such tag."""
        tag = session.scalars(select(Tag).where(Tag.name == name)).first()
        if tag is None:
            return []
        return sorted(book.title for book in tag.books)


    with Session(make_engine()) as session:
        print(titles_with_tag(session, "dystopia"))
        print(titles_with_tag(session, "western"))
    ```

    ```text
    ['Animal Farm', 'Nineteen Eighty-Four']
    []
    ```

**3. One-to-one.** Give Lea a library card, `LIB-0005`, expiring on
`2027-09-01`.

??? success "Answer"

    Assigning to the relationship is enough; the card's `member_id` is
    filled in for you:

    ```python title="p3_card.py"
    from sqlalchemy.orm import Session

    from models import LibraryCard, Member, make_engine

    with Session(make_engine()) as session:
        lea = session.get(Member, 5)
        lea.card = LibraryCard(card_number="LIB-0005", expires_on="2027-09-01")
        session.commit()
        print(lea.card, lea.card.member)
    ```

    ```text
    LibraryCard('LIB-0005') Member('Lea Marku')
    ```

**4. Borrow a book.** Write `borrow(session, member_id, book_id)`, which
creates a loan dated today and returns it, or returns `None` if the
book is already out.

??? success "Answer"

    ```python title="p4_borrow.py"
    from datetime import date

    from sqlalchemy import select
    from sqlalchemy.orm import Session

    from models import Book, Loan, Member, make_engine


    def borrow(session, member_id, book_id):
        """Lend a book to a member and return the loan, or None if it is out."""
        open_loan = session.scalars(
            select(Loan).where(Loan.book_id == book_id,
                               Loan.returned_on.is_(None))
        ).first()
        if open_loan is not None:
            return None
        loan = Loan(member=session.get(Member, member_id),
                    book=session.get(Book, book_id),
                    loaned_on=date.today().isoformat())
        session.add(loan)
        session.commit()
        return loan


    with Session(make_engine()) as session:
        print(borrow(session, 5, 8))
        print(borrow(session, 5, 10))
    ```

    ```text
    None
    Loan('Things Fall Apart', 2026-10-31)
    ```

    Dune is out, so the first call refused. The date is the day the page
    was written; yours will be today.

**5. Count with zeros.** Count the loans of every member, including any
member with none, most first.

??? success "Answer"

    ```python title="p5_counts.py"
    from sqlalchemy import func, select
    from sqlalchemy.orm import Session

    from models import Loan, Member, make_engine

    query = (
        select(Member.name, func.count(Loan.id))
        .outerjoin(Member.loans)
        .group_by(Member.id)
        .order_by(func.count(Loan.id).desc(), Member.name)
    )

    with Session(make_engine()) as session:
        for name, loans in session.execute(query):
            print(f"{loans}  {name}")
    ```

    ```text
    4  Arta Hoxha
    3  Besnik Krasniqi
    3  Drita Leka
    2  Erion Shehu
    1  Lea Marku
    ```

    Lea has one loan now, from exercise 4.

**6. A computed answer.** Write `is_available(book)`, which is `True`
when the book has no loan without a return date.

??? success "Answer"

    ```python title="p6_available.py"
    from sqlalchemy.orm import Session

    from models import Book, make_engine


    def is_available(book):
        """True if the book has no loan without a return date."""
        return all(loan.returned_on is not None for loan in book.loans)


    with Session(make_engine()) as session:
        for book_id in (5, 8, 9):
            book = session.get(Book, book_id)
            print(book.title, is_available(book))
    ```

    ```text
    Nineteen Eighty-Four True
    Dune False
    The Hobbit True
    ```

    The Hobbit was returned in Step 8, so it is available again.

## Explain it to someone

- [ ] What an ORM is, and what maps to what: class, attribute, object, relationship
- [ ] How to write a model with `Mapped`, `mapped_column`, a primary key and a foreign key
- [ ] What the engine and the session are, and how to open a session
- [ ] How to query with `select`, `where`, `order_by`, `limit`, `get`, `first` and `count`
- [ ] How to see the SQL behind a query, and why ORM queries are safe from injection
- [ ] How `relationship` and `back_populates` map one-to-one, one-to-many and many-to-many links
- [ ] How to create, update and delete with `add`, attribute changes, `delete` and `commit`
- [ ] What happens on commit, and when to call `rollback`
- [ ] What the N+1 problem is, and how `selectinload` fixes it
- [ ] How to create tables from models, and when to use raw SQL instead

## Quick reference

| Code | What it does |
|---|---|
| `class Book(Base): __tablename__ = "books"` | Map a class to a table |
| `id: Mapped[int] = mapped_column(primary_key=True)` | A primary key column |
| `year: Mapped[int | None]` | A column that may be NULL |
| `mapped_column(ForeignKey("authors.id"))` | A foreign key |
| `relationship(back_populates="...")` | Follow a link between tables |
| `relationship(secondary=table)` | Many-to-many through a junction table |
| `create_engine("sqlite:///library.db")` | Where the database is |
| `with Session(engine) as session:` | One conversation with the database |
| `session.scalars(select(Book).where(...)).all()` | Query objects |
| `session.get(Book, 8)` | One object by primary key, or `None` |
| `session.add(obj)`, `session.delete(obj)` | Mark an object to insert or delete |
| `session.commit()`, `session.rollback()` | Save every change, or undo them |
| `.options(selectinload(Book.author))` | Load a relationship up front |
| `Base.metadata.create_all(engine)` | Create the tables from the models |
| `session.execute(text("..."), {...})` | Run raw SQL with named placeholders |

## Next

The library's data now lives behind Python objects. Next you open it to
other programs, a web page, a phone app, another service, through a
**REST API** that speaks HTTP and JSON.

[RESTful API](rest-api.md){ .h-button }
