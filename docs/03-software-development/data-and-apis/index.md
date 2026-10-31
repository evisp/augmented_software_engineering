# Data & APIs

Learn to keep data and share it: read and write files, store and query
data in a relational database, map it to Python objects, and serve it
over the web through a REST API.

<span class="badge badge--level">Software Development</span>
<span class="badge badge--time">60 h</span>
<span class="badge">6 projects</span>
<span class="badge">Needs: Object-Oriented Design</span>

<p class="h-progress-label"><span>Tutorials published</span><span>6 of 6</span></p>
<div class="h-progress" role="img" aria-label="6 of 6 tutorials published"><span style="width: 100%"></span></div>

## How these tutorials work

The projects on the Holberton intranet are where you build. These
tutorials are where you learn the basics first, and practise them on
small examples until they feel natural.

<div class="grid cards cols-3" markdown>

-   :material-stairs: **Learn step by step**

    ---

    One idea per step, each with a short example and the real output it
    prints. Run every example yourself.

-   :material-pencil-box-outline: **Try it**

    ---

    Most steps end with a short exercise. Write your answer first, then
    open the collapsed answer to compare.

-   :material-dumbbell: **Practise**

    ---

    Each tutorial ends with a practice set, from easy to harder, on the
    same data you used along the way.

</div>

## The practice data: a small library

Every tutorial in this module uses the same theme: a small library with
books, authors and the people who borrow them. You download the files
you need at the start of each tutorial, and you can download them again
whenever you break something.

| Tutorial | Practice data |
|---|---|
| File Handling | [`books.txt`](../../assets/files/books.txt), a list of ten books; [`catalog.json`](../../assets/files/catalog.json), the same kind of data as JSON |
| SQL: CRUD Operations | [`books.sql`](../../assets/sql/books.sql), one table of 20 books |
| SQL: Joins & Relationships | [`library.sql`](../../assets/sql/library.sql), authors, books, members, cards, loans and tags |
| Database Design & Normalization | [`loans_sheet.sql`](../../assets/sql/loans_sheet.sql), the library's old loans spreadsheet |
| Object-Relational Mapping, RESTful API | [`library.sql`](../../assets/sql/library.sql) again, through Python classes and then over HTTP |

!!! tip "What you need"

    Python 3, a WSL terminal and VS Code, as set up in
    [Tools](../../01-tools/index.md) and
    [Python Fundamentals](../../02-foundations/python/index.md).
    The SQL tutorials show you how to install SQLite.

## The path

### Store and query data

<div class="grid cards cols-2" markdown>

-   :material-file-document-edit-outline: **1 · File Handling**

    ---

    Open, write, read and close files safely, and save data as JSON.

    <span class="badge badge--ready">Ready</span>
    <span class="badge">4 h</span>

    [:octicons-arrow-right-24: Start](files.md)

-   :material-table-edit: **2 · SQL: CRUD Operations**

    ---

    Tables and rows: create, read, update and delete data with SQL.

    <span class="badge badge--ready">Ready</span>
    <span class="badge">8 h</span>

    [:octicons-arrow-right-24: Start](sql-crud.md)

-   :material-table-network: **3 · SQL: Joins & Relationships**

    ---

    Link related tables with keys, and answer questions that span
    several of them.

    <span class="badge badge--ready">Ready</span>
    <span class="badge">8 h</span>

    [:octicons-arrow-right-24: Start](sql-joins.md)

-   :material-database-cog-outline: **4 · Database Design & Normalization**

    ---

    Design tables with keys, and remove duplicated data.

    <span class="badge badge--ready">Ready</span>
    <span class="badge">8 h</span>

    [:octicons-arrow-right-24: Start](database-design.md)

</div>

### Connect it to code

<div class="grid cards cols-2" markdown>

-   :material-swap-horizontal: **5 · Object-Relational Mapping**

    ---

    Map classes to tables, and work with the database through Python
    objects.

    <span class="badge badge--ready">Ready</span>
    <span class="badge">24 h</span>

    [:octicons-arrow-right-24: Start](orm.md)

-   :material-api: **6 · RESTful API**

    ---

    Serve data over HTTP: endpoints, methods, status codes and JSON.

    <span class="badge badge--ready">Ready</span>
    <span class="badge">8 h</span>

    [:octicons-arrow-right-24: Start](rest-api.md)

</div>

!!! ai "AI in the loop"

    This module is where code starts touching real data. Assistants
    write file, SQL and API code quickly, and a single wrong mode, a
    missing `WHERE` or an unvalidated request can destroy or expose data.
    Before you run anything an assistant wrote, ask: *what does this do
    to the data if it fails halfway?* Read it until you can answer.
