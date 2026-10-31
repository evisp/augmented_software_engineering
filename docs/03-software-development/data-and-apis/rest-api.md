# RESTful API

<span class="badge badge--time">2 h</span>
<span class="badge badge--level">Data & APIs</span>
<span class="badge">Needs: Object-Relational Mapping</span>

The library's data lives in a database, and Python code can reach it
through the ORM. Other programs cannot: not a web page, not a phone app,
not another team's service. An **API** opens the data to them, over
HTTP, in JSON. In this tutorial you learn how HTTP requests and
responses work, what makes an API **RESTful**, and you build one for
the library with **Flask**, test it with `curl`, use it from Python, and
write automated tests for it.

## Why this matters

Almost every modern application is a set of programs talking over
HTTP: the front end asks the back end for data, the back end asks
payment and email services, and so on. REST is the most common way to
design those conversations. Knowing it lets you build back ends, and
also use the thousands of public APIs out there, which all follow the
same ideas. Your portfolio projects are built exactly this way.

## Before you start

You need `models.py`, the full version from
[Object-Relational Mapping](orm.md), and a fresh `library.db`, both in
`~/library`. Install Flask and `requests` in the same venv:

```bash
cd ~/library
source .venv/bin/activate
sqlite3 library.db < library.sql
pip install flask requests
```

`curl`, which sends HTTP requests from the terminal, is already in
Ubuntu. You will use **two terminals**: one runs the API, the other
sends requests to it.

## Step 1: HTTP in one picture

Every exchange on the web is one **request** from a client and one
**response** from a server:

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 236" role="img" aria-labelledby="ra-http-title ra-http-desc">
<title id="ra-http-title">An HTTP request and its response</title>
<desc id="ra-http-desc">The request has a method, POST, a path, /books, headers such as Content-Type: application/json, and a JSON body with the new book. The response has a status code, 201 Created, headers such as Content-Type and Location: /books/11, and a JSON body with the created book.</desc>
<defs><marker id="ra-http-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-cherry)"/></marker></defs>
<g font-size="11" font-weight="700" fill="var(--h-fig-muted)"><text x="80" y="14">REQUEST · client → server</text><text x="390" y="14">RESPONSE · server → client</text></g>
<g font-family="var(--md-code-font-family, monospace)" font-size="11.5">
<rect x="80" y="24" width="290" height="200" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="92" y="48" fill="var(--h-cherry)" font-weight="700">POST <tspan fill="var(--h-fig-text)">/books</tspan> <tspan fill="var(--h-fig-muted)" font-weight="400">HTTP/1.1</tspan></text>
<text x="92" y="84" fill="var(--h-fig-text)">Content-Type: application/json</text>
<text x="92" y="132" fill="var(--h-fig-text)">{"title": "A Wizard of</text>
<text x="92" y="150" fill="var(--h-fig-text)">  Earthsea", "author_id": 8,</text>
<text x="92" y="168" fill="var(--h-fig-text)">  "year": 1968}</text>
<rect x="390" y="24" width="287" height="200" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="402" y="48" fill="var(--h-fig-muted)">HTTP/1.1 <tspan fill="var(--h-cherry)" font-weight="700">201 CREATED</tspan></text>
<text x="402" y="84" fill="var(--h-fig-text)">Content-Type: application/json</text>
<text x="402" y="102" fill="var(--h-fig-text)">Location: /books/11</text>
<text x="402" y="132" fill="var(--h-fig-text)">{"id": 11, "title": "A Wizard</text>
<text x="402" y="150" fill="var(--h-fig-text)">  of Earthsea", "year": 1968,</text>
<text x="402" y="168" fill="var(--h-fig-text)">  "author": {...}}</text>
</g>
<g stroke="var(--h-fig-line)" stroke-dasharray="3 3"><line x1="86" y1="60" x2="364" y2="60"/><line x1="86" y1="114" x2="364" y2="114"/><line x1="396" y1="60" x2="671" y2="60"/><line x1="396" y1="114" x2="671" y2="114"/></g>
<g font-size="11" font-weight="700" fill="var(--h-fig-text)" text-anchor="end">
<text x="72" y="48">method,</text><text x="72" y="62">path</text>
<text x="72" y="88">headers</text>
<text x="72" y="140">body</text>
</g>
</svg>
</figure>

- The **method** says what to do: `GET` to read, `POST` to create, and
  so on.
- The **path** says what to do it to: `/books`, `/books/8`.
- **Headers** carry details about the message, such as
  `Content-Type: application/json`: "the body is JSON".
- The **body** carries data. A `GET` has none; a `POST` sends the new
  book.
- The response starts with a **status code**: `201 Created`, `404 Not
  Found`. Then its own headers and body.

## Step 2: What makes an API RESTful

**REST** is a style for designing HTTP APIs, built on a few ideas:

- **Resources, named with nouns.** Everything the API exposes is a
  resource with a URL: `/books` is the collection of books, `/books/8`
  one book. No verbs in URLs: not `/getBook?id=8`.
- **Methods are the verbs.** The same URL does different things with
  different methods.
- **Representations.** The client never touches the database; it gets
  a representation of the resource, here JSON.
- **Stateless.** Every request carries everything the server needs. The
  server does not remember the previous request.
- **Status codes tell the outcome**, so a client can react without
  reading the body.

The methods line up with CRUD and with SQL:

| Method | Path | Meaning | SQL | Success |
|---|---|---|---|---|
| `GET` | `/books` | List the books | `SELECT` | `200 OK` |
| `GET` | `/books/8` | Read one book | `SELECT ... WHERE id = 8` | `200 OK` |
| `POST` | `/books` | Create a book | `INSERT` | `201 Created` |
| `PATCH` | `/books/8` | Change some fields | `UPDATE` | `200 OK` |
| `PUT` | `/books/8` | Replace the whole book | `UPDATE` | `200 OK` |
| `DELETE` | `/books/8` | Delete the book | `DELETE` | `204 No Content` |

`GET`, `PUT` and `DELETE` are **idempotent**: sending the same request
twice leaves the data as sending it once. `POST` is not: send it twice,
get two books.

Here is the API you will build, layer by layer:

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 140" role="img" aria-labelledby="ra-lay-title ra-lay-desc">
<title id="ra-lay-title">The layers of the library API</title>
<desc id="ra-lay-desc">A client, such as curl, requests or a browser, sends an HTTP request to Flask. Flask calls the route function for the method and path. The function uses an ORM session, and the session runs SQL on library.db. The answer travels back as JSON.</desc>
<defs><marker id="ra-lay-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<g text-anchor="middle">
<rect x="3" y="30" width="118" height="64" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="62" y="56" font-size="13" font-weight="700" fill="var(--h-fig-text)">Client</text><text x="62" y="76" font-size="11" fill="var(--h-fig-muted)">curl, requests</text>
<rect x="143" y="30" width="118" height="64" rx="10" fill="var(--h-cherry)"/>
<text x="202" y="56" font-size="13" font-weight="700" fill="#ffffff">Flask</text><text x="202" y="76" font-size="11" fill="#ffffff">method + path</text>
<rect x="283" y="30" width="118" height="64" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="342" y="56" font-size="13" font-weight="700" fill="var(--h-fig-text)">Route</text><text x="342" y="76" font-size="11" fill="var(--h-fig-muted)">a function</text>
<rect x="423" y="30" width="118" height="64" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="482" y="56" font-size="13" font-weight="700" fill="var(--h-fig-text)">Session</text><text x="482" y="76" font-size="11" fill="var(--h-fig-muted)">the ORM</text>
<rect x="563" y="30" width="114" height="64" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="620" y="56" font-size="13" font-weight="700" fill="var(--h-fig-text)">SQLite</text><text x="620" y="76" font-size="11" fill="var(--h-fig-muted)">library.db</text>
</g>
<g stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#ra-lay-arrow)"><line x1="123" y1="52" x2="140" y2="52"/><line x1="263" y1="52" x2="280" y2="52"/><line x1="403" y1="52" x2="420" y2="52"/><line x1="543" y1="52" x2="560" y2="52"/></g>
<g font-size="11" font-weight="700" fill="var(--h-fig-muted)" text-anchor="middle"><text x="132" y="22">HTTP</text><text x="272" y="22">call</text><text x="412" y="22">objects</text><text x="552" y="22">SQL</text></g>
<defs><marker id="ra-lay-back" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-cherry)"/></marker></defs>
<path d="M620 96 V106 Q620 112 614 112 H68 Q62 112 62 106 V99" fill="none" stroke="var(--h-cherry)" stroke-width="1.8" stroke-dasharray="5 4" marker-end="url(#ra-lay-back)"/>
<text x="340" y="132" text-anchor="middle" font-size="11" font-weight="700" fill="var(--h-cherry)">the answer travels back as JSON</text>
</svg>
</figure>

## Step 3: A first endpoint

Create `api.py`. Start with the setup, a function that turns a `Book`
into a dictionary, and one **route**: a function that Flask calls for a
given method and path.

```python title="api.py"
"""A REST API for the library, built with Flask and the ORM models."""
from flask import Flask, abort, jsonify, request
from sqlalchemy import select
from sqlalchemy.orm import Session

from models import Author, Book, Member, make_engine

app = Flask(__name__)
app.json.ensure_ascii = False
app.json.sort_keys = False
engine = make_engine()
```

```python
def book_json(book):
    """Return a book as a dictionary ready for JSON."""
    return {
        "id": book.id,
        "title": book.title,
        "year": book.year,
        "author": {"id": book.author.id, "name": book.author.name},
    }
```

```python
@app.get("/books")
def list_books():
    """List the books, optionally only those of one author."""
    query = select(Book).order_by(Book.id)
    author_id = request.args.get("author_id", type=int)
    if author_id is not None:
        query = query.where(Book.author_id == author_id)
    with Session(engine) as session:
        return jsonify([book_json(book) for book in session.scalars(query)])
```

- `@app.get("/books")` registers the function for `GET /books`.
- Each request opens its own session, uses it, and closes it: the API
  is stateless, and so is each call.
- `jsonify` turns Python lists and dictionaries into a JSON response,
  with the header `Content-Type: application/json`.
- `book_json` decides what the outside world sees. The API does not
  just dump the table: it nests the author's name, and it could hide
  columns that are nobody else's business.

Start the API in the first terminal:

```bash
flask --app api run
```

```text
 * Serving Flask app 'api'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on http://127.0.0.1:5000
Press CTRL+C to quit
```

Leave it running. In the second terminal, send a request.
`python3 -m json.tool` pretty-prints the JSON, and `head` keeps the
start of it:

```bash
curl -s http://127.0.0.1:5000/books | python3 -m json.tool --no-ensure-ascii | head -n 20
```

```text
[
    {
        "id": 1,
        "title": "Kronikë në gur",
        "year": 1971,
        "author": {
            "id": 1,
            "name": "Ismail Kadare"
        }
    },
    {
        "id": 2,
        "title": "Prilli i thyer",
        "year": 1978,
        "author": {
            "id": 1,
            "name": "Ismail Kadare"
        }
    },
    {
```

In the first terminal, Flask logs each request with its status code.
Stop the server with ++ctrl+c++, and restart it after every change to
`api.py`.

## Step 4: One resource, and 404

A **path parameter** picks one resource: `<int:book_id>` matches a
number in the path and passes it to the function.

```python
@app.get("/books/<int:book_id>")
def get_book(book_id):
    """Return one book, with its tags, or 404."""
    with Session(engine) as session:
        book = session.get(Book, book_id)
        if book is None:
            abort(404, description=f"No book with id {book_id}")
        data = book_json(book)
        data["tags"] = [tag.name for tag in book.tags]
        return jsonify(data)
```

`curl -i` shows the status line and headers too:

```bash
curl -i http://127.0.0.1:5000/books/8
```

```text
HTTP/1.1 200 OK
Content-Type: application/json

{"id":8,"title":"Dune","year":1965,"author":{"id":5,"name":"Frank Herbert"},"tags":["classic","sci-fi"]}
```

A book that does not exist must not crash the API or answer `200` with
nothing. `abort(404, ...)` stops the function and answers **404 Not
Found**. By default Flask would send an HTML error page, which a program
cannot use, so one more function at the end of `api.py` answers every
error in JSON:

```python
@app.errorhandler(400)
@app.errorhandler(404)
@app.errorhandler(405)
@app.errorhandler(409)
def error_json(error):
    """Answer every error with JSON instead of an HTML page."""
    return jsonify({"error": error.description}), error.code
```

```bash
curl -i http://127.0.0.1:5000/books/999
```

```text
HTTP/1.1 404 NOT FOUND
Content-Type: application/json

{"error":"No book with id 999"}
```

## Step 5: Query parameters

Filters, sorting and paging do not get their own URLs: they are **query
parameters**, after the `?`. `list_books` already reads `author_id`:

```bash
curl -s "http://127.0.0.1:5000/books?author_id=1"
```

```text
[{"id":1,"title":"Kronikë në gur","year":1971,"author":{"id":1,"name":"Ismail Kadare"}},{"id":2,"title":"Prilli i thyer","year":1978,"author":{"id":1,"name":"Ismail Kadare"}},{"id":3,"title":"Gjenerali i ushtrisë së vdekur","year":1963,"author":{"id":1,"name":"Ismail Kadare"}}]
```

`request.args.get("author_id", type=int)` returns `None` when the
parameter is missing or is not a number, so a bad value is ignored
instead of crashing the query. Quote the URL in the shell: an unquoted
`&` would mean something else to Bash.

## Step 6: Create with POST

To create a book, the client sends it as JSON in the request body:

```python
@app.post("/books")
def create_book():
    """Create a book from the JSON body; answer 201 with the new book."""
    data = request.get_json(silent=True) or {}
    title = data.get("title")
    if not isinstance(title, str) or not title.strip():
        abort(400, description="'title' is required")
    with Session(engine) as session:
        author = session.get(Author, data.get("author_id"))
        if author is None:
            abort(400, description="'author_id' must be an existing author")
        book = Book(title=title.strip(), year=data.get("year"), author=author)
        session.add(book)
        session.commit()
        response = jsonify(book_json(book))
        response.status_code = 201
        response.headers["Location"] = f"/books/{book.id}"
        return response
```

- `request.get_json(silent=True)` reads the body; `silent=True` returns
  `None` instead of failing when the body is not JSON.
- **Validate before you touch the database.** Never trust what a client
  sends: a missing title or an unknown author is the client's mistake,
  so the answer is **400 Bad Request** with a message saying what is
  wrong.
- A successful create answers **201 Created**, with the new resource in
  the body and its URL in the `Location` header.

With `curl`, `-X` sets the method, `-H` adds a header and `-d` sends the
body:

```bash
curl -i -X POST http://127.0.0.1:5000/books -H "Content-Type: application/json" -d '{"title": "A Wizard of Earthsea", "author_id": 8, "year": 1968}'
```

```text
HTTP/1.1 201 CREATED
Content-Type: application/json
Location: /books/11

{"id":11,"title":"A Wizard of Earthsea","year":1968,"author":{"id":8,"name":"Ursula K. Le Guin"}}
```

```bash
curl -s http://127.0.0.1:5000/books/11
```

```text
{"id":11,"title":"A Wizard of Earthsea","year":1968,"author":{"id":8,"name":"Ursula K. Le Guin"},"tags":[]}
```

And the client's mistakes:

```bash
curl -i -X POST http://127.0.0.1:5000/books -H "Content-Type: application/json" -d '{"author_id": 8}'
```

```text
HTTP/1.1 400 BAD REQUEST
Content-Type: application/json

{"error":"'title' is required"}
```

```bash
curl -s -X POST http://127.0.0.1:5000/books -H "Content-Type: application/json" -d '{"title": "Ghost", "author_id": 99}'
```

```text
{"error":"'author_id' must be an existing author"}
```

## Step 7: Update and delete

`PATCH` changes only the fields the client sends:

```python
@app.patch("/books/<int:book_id>")
def update_book(book_id):
    """Change the title or year of a book."""
    data = request.get_json(silent=True) or {}
    with Session(engine) as session:
        book = session.get(Book, book_id)
        if book is None:
            abort(404, description=f"No book with id {book_id}")
        if "title" in data:
            book.title = data["title"]
        if "year" in data:
            book.year = data["year"]
        session.commit()
        return jsonify(book_json(book))
```

```bash
curl -s -X PATCH http://127.0.0.1:5000/books/11 -H "Content-Type: application/json" -d '{"year": 1969}'
```

```text
{"id":11,"title":"A Wizard of Earthsea","year":1969,"author":{"id":8,"name":"Ursula K. Le Guin"}}
```

`PUT` would replace the **whole** resource, so the client would have to
send every field. `PATCH` is what most APIs use for edits.

`DELETE` answers **204 No Content** on success: done, nothing to send
back. A book with loans must not disappear, so that answers **409
Conflict**: the request is valid, but clashes with the current state of
the data.

```python
@app.delete("/books/<int:book_id>")
def delete_book(book_id):
    """Delete a book that has never been lent; answer 204."""
    with Session(engine) as session:
        book = session.get(Book, book_id)
        if book is None:
            abort(404, description=f"No book with id {book_id}")
        if book.loans:
            abort(409, description="This book has loans and cannot be deleted")
        session.delete(book)
        session.commit()
        return "", 204
```

```bash
curl -i -X DELETE http://127.0.0.1:5000/books/11
```

```text
HTTP/1.1 204 NO CONTENT
Content-Type: text/html; charset=utf-8
```

Deleting it again finds nothing:

```bash
curl -s -X DELETE http://127.0.0.1:5000/books/11
```

```text
{"error":"No book with id 11"}
```

And Dune has loans:

```bash
curl -i -X DELETE http://127.0.0.1:5000/books/8
```

```text
HTTP/1.1 409 CONFLICT
Content-Type: application/json

{"error":"This book has loans and cannot be deleted"}
```

Flask itself answers a method that has no route on that path with
**405 Method Not Allowed**:

```bash
curl -i -X PUT http://127.0.0.1:5000/books/8
```

```text
HTTP/1.1 405 METHOD NOT ALLOWED
Content-Type: application/json

{"error":"The method is not allowed for the requested URL."}
```

## Step 8: Nested resources

Some resources belong to others: a member's loans. The URL says so:
`/members/1/loans`.

```python
@app.get("/members/<int:member_id>/loans")
def member_loans(member_id):
    """List one member's loans, newest first."""
    with Session(engine) as session:
        member = session.get(Member, member_id)
        if member is None:
            abort(404, description=f"No member with id {member_id}")
        loans = sorted(member.loans, key=lambda loan: loan.loaned_on,
                       reverse=True)
        return jsonify([
            {"book": loan.book.title,
             "loaned_on": loan.loaned_on,
             "returned_on": loan.returned_on}
            for loan in loans
        ])
```

```bash
curl -s http://127.0.0.1:5000/members/1/loans
```

```text
[{"book":"The Hobbit","loaned_on":"2026-10-22","returned_on":null},{"book":"Prilli i thyer","loaned_on":"2026-10-03","returned_on":null},{"book":"Kronikë në gur","loaned_on":"2026-09-18","returned_on":"2026-10-01"},{"book":"Nineteen Eighty-Four","loaned_on":"2026-09-02","returned_on":"2026-09-16"}]
```

`None` became `null`: the book has not been returned.

!!! tip "Try it"

    What do `/members/5/loans` and `/members/42/loans` return, and with
    which status codes?

??? success "Answer"

    Lea, member 5, exists but has no loans: `200` with an empty list.
    Member 42 does not exist: `404`. An empty collection is not an error.

    ```bash
    curl -s http://127.0.0.1:5000/members/5/loans
    ```

    ```text
    []
    ```

    ```bash
    curl -s http://127.0.0.1:5000/members/42/loans
    ```

    ```text
    {"error":"No member with id 42"}
    ```

## Step 9: Status codes

The status code is the first thing a client checks. The first digit
gives the family:

| Code | Name | Use it when |
|---|---|---|
| `200` | OK | A read or an update worked |
| `201` | Created | A `POST` created a resource; add a `Location` header |
| `204` | No Content | It worked, and there is nothing to send back |
| `400` | Bad Request | The client sent invalid data |
| `401` | Unauthorized | The client must log in first |
| `403` | Forbidden | Logged in, but not allowed |
| `404` | Not Found | No resource at that URL |
| `405` | Method Not Allowed | The URL exists, the method does not |
| `409` | Conflict | Valid, but clashes with the current data |
| `500` | Internal Server Error | A bug in the server |

**2xx** means it worked, **4xx** that the client must change something,
**5xx** that the server failed. A `500` is always your bug: an unhandled
exception in a route. Users should only ever see the codes you chose.

## Step 10: Use the API from Python

Programs call APIs with an HTTP library. `requests` is the most used in
Python. With the server running:

```python title="client.py"
"""Use the library API from Python, with the requests package."""
import requests

BASE = "http://127.0.0.1:5000"

response = requests.get(f"{BASE}/books", params={"author_id": 3})
print(response.status_code, response.headers["Content-Type"])
for book in response.json():
    print(book["id"], book["title"])

response = requests.post(f"{BASE}/books",
                         json={"title": "Homage to Catalonia",
                               "author_id": 3, "year": 1938})
print(response.status_code, response.headers["Location"])

response = requests.get(f"{BASE}/books/999")
print(response.status_code, response.json())

try:
    response.raise_for_status()
except requests.HTTPError as error:
    print("HTTPError:", error)
```

```bash
python3 client.py
```

```text
200 application/json
5 Nineteen Eighty-Four
6 Animal Farm
201 /books/11
404 {'error': 'No book with id 999'}
HTTPError: 404 Client Error: NOT FOUND for url: http://127.0.0.1:5000/books/999
```

- `params=` builds the query string, and `json=` sends a JSON body with
  the right `Content-Type`.
- `response.json()` turns the body back into Python data.
- `raise_for_status()` raises an exception for any 4xx or 5xx, which is
  handy when an error should stop the program.

The same code works against any REST API on the internet, given its URL
and its documentation.

## Step 11: Test the API

Clicking around with `curl` does not scale. Flask has a **test client**
that sends requests to the app without a server, so tests can check
every endpoint in a second. These tests use a copy of the database, so
they never change the real one:

```python title="test_api.py"
"""Tests for the library API, run against a fresh copy of the data."""
import shutil
import unittest

shutil.copy("library.db", "test-library.db")

import api  # noqa: E402
from models import make_engine  # noqa: E402

api.engine = make_engine("test-library.db")


class BooksApiTest(unittest.TestCase):
    """Check the /books endpoints."""

    def setUp(self):
        self.client = api.app.test_client()

    def test_list_books(self):
        response = self.client.get("/books")
        self.assertEqual(response.status_code, 200)
        self.assertGreaterEqual(len(response.get_json()), 10)

    def test_missing_book_is_404(self):
        response = self.client.get("/books/999")
        self.assertEqual(response.status_code, 404)
        self.assertIn("error", response.get_json())

    def test_create_needs_title(self):
        response = self.client.post("/books", json={"author_id": 1})
        self.assertEqual(response.status_code, 400)

    def test_create_and_read_back(self):
        response = self.client.post(
            "/books", json={"title": "Test Book", "author_id": 1})
        self.assertEqual(response.status_code, 201)
        location = response.headers["Location"]
        self.assertEqual(self.client.get(location).get_json()["title"],
                         "Test Book")


if __name__ == "__main__":
    unittest.main(verbosity=2)
```

Stop the server first, then run the tests:

```bash
python3 test_api.py
```

```text
test_create_and_read_back (__main__.BooksApiTest.test_create_and_read_back) ... ok
test_create_needs_title (__main__.BooksApiTest.test_create_needs_title) ... ok
test_list_books (__main__.BooksApiTest.test_list_books) ... ok
test_missing_book_is_404 (__main__.BooksApiTest.test_missing_book_is_404) ... ok

----------------------------------------------------------------------
Ran 4 tests in 0.05s

OK
```

Run the tests after every change. When one fails, you know at once what
you broke.

## The whole API

??? example "api.py"

    ```python title="api.py"
    """A REST API for the library, built with Flask and the ORM models."""
    from flask import Flask, abort, jsonify, request
    from sqlalchemy import select
    from sqlalchemy.orm import Session

    from models import Author, Book, Member, make_engine

    app = Flask(__name__)
    app.json.ensure_ascii = False
    app.json.sort_keys = False
    engine = make_engine()


    def book_json(book):
        """Return a book as a dictionary ready for JSON."""
        return {
            "id": book.id,
            "title": book.title,
            "year": book.year,
            "author": {"id": book.author.id, "name": book.author.name},
        }


    @app.get("/books")
    def list_books():
        """List the books, optionally only those of one author."""
        query = select(Book).order_by(Book.id)
        author_id = request.args.get("author_id", type=int)
        if author_id is not None:
            query = query.where(Book.author_id == author_id)
        with Session(engine) as session:
            return jsonify([book_json(book) for book in session.scalars(query)])


    @app.get("/books/<int:book_id>")
    def get_book(book_id):
        """Return one book, with its tags, or 404."""
        with Session(engine) as session:
            book = session.get(Book, book_id)
            if book is None:
                abort(404, description=f"No book with id {book_id}")
            data = book_json(book)
            data["tags"] = [tag.name for tag in book.tags]
            return jsonify(data)


    @app.post("/books")
    def create_book():
        """Create a book from the JSON body; answer 201 with the new book."""
        data = request.get_json(silent=True) or {}
        title = data.get("title")
        if not isinstance(title, str) or not title.strip():
            abort(400, description="'title' is required")
        with Session(engine) as session:
            author = session.get(Author, data.get("author_id"))
            if author is None:
                abort(400, description="'author_id' must be an existing author")
            book = Book(title=title.strip(), year=data.get("year"), author=author)
            session.add(book)
            session.commit()
            response = jsonify(book_json(book))
            response.status_code = 201
            response.headers["Location"] = f"/books/{book.id}"
            return response


    @app.patch("/books/<int:book_id>")
    def update_book(book_id):
        """Change the title or year of a book."""
        data = request.get_json(silent=True) or {}
        with Session(engine) as session:
            book = session.get(Book, book_id)
            if book is None:
                abort(404, description=f"No book with id {book_id}")
            if "title" in data:
                book.title = data["title"]
            if "year" in data:
                book.year = data["year"]
            session.commit()
            return jsonify(book_json(book))


    @app.delete("/books/<int:book_id>")
    def delete_book(book_id):
        """Delete a book that has never been lent; answer 204."""
        with Session(engine) as session:
            book = session.get(Book, book_id)
            if book is None:
                abort(404, description=f"No book with id {book_id}")
            if book.loans:
                abort(409, description="This book has loans and cannot be deleted")
            session.delete(book)
            session.commit()
            return "", 204


    @app.get("/members/<int:member_id>/loans")
    def member_loans(member_id):
        """List one member's loans, newest first."""
        with Session(engine) as session:
            member = session.get(Member, member_id)
            if member is None:
                abort(404, description=f"No member with id {member_id}")
            loans = sorted(member.loans, key=lambda loan: loan.loaned_on,
                           reverse=True)
            return jsonify([
                {"book": loan.book.title,
                 "loaned_on": loan.loaned_on,
                 "returned_on": loan.returned_on}
                for loan in loans
            ])


    @app.errorhandler(400)
    @app.errorhandler(404)
    @app.errorhandler(405)
    @app.errorhandler(409)
    def error_json(error):
        """Answer every error with JSON instead of an HTML page."""
        return jsonify({"error": error.description}), error.code
    ```

!!! ai "AI in the loop"

    An assistant can generate a complete CRUD API in a minute. Review it
    as the person who will be blamed when it breaks: does every route
    **validate** its input, does it answer the **right status codes**,
    can a client delete or change data it should not? Then ask the
    assistant for the `curl` commands or tests that prove each answer,
    and run them yourself.

## When something goes wrong

??? note "`curl: (7) Failed to connect to 127.0.0.1 port 5000`"

    The server is not running. Start it in the other terminal with
    `flask --app api run`, from `~/library`, with the venv active.

??? note "`Address already in use`"

    Another server is still on port 5000, often one you forgot in another
    terminal. Stop it, or start this one on another port:
    `flask --app api run --port 5001`.

??? note "My change to `api.py` does nothing"

    The server is still running the old code. Restart it, or start it
    with `--debug`, which reloads the code when you save the file.

??? note "A `POST` answers `400` although the JSON looks right"

    Check the `Content-Type: application/json` header and the quotes:
    in the shell, wrap the JSON in single quotes, and use double quotes
    inside it, as JSON requires.

??? note "`500 Internal Server Error`"

    An exception in a route. The traceback is in the server's terminal,
    not in the response. Read it there, fix the bug, and handle the case
    with the right `4xx` if it was caused by bad input.

## Practice set

Five exercises. Add each route to `api.py`, before the error handler,
restart the server, and reload `library.sql` first for exactly these
results. Exercise 3 also needs `Loan` imported from `models`, and
`date` from `datetime`.

**1. Authors.** Add `GET /authors`: every author with their number of
books, sorted by name.

??? success "Answer"

    ```python
    @app.get("/authors")
    def list_authors():
        """List every author, with how many books each has."""
        with Session(engine) as session:
            authors = session.scalars(select(Author).order_by(Author.name))
            return jsonify([
                {"id": a.id, "name": a.name, "books": len(a.books)}
                for a in authors
            ])
    ```

    ```bash
    curl -s http://127.0.0.1:5000/authors
    ```

    ```text
    [{"id":7,"name":"Chinua Achebe","books":1},{"id":2,"name":"Dritëro Agolli","books":1},{"id":5,"name":"Frank Herbert","books":1},{"id":3,"name":"George Orwell","books":2},{"id":1,"name":"Ismail Kadare","books":3},{"id":6,"name":"J. R. R. Tolkien","books":1},{"id":4,"name":"Jane Austen","books":1},{"id":8,"name":"Ursula K. Le Guin","books":0}]
    ```

**2. Nested books.** Add `GET /authors/<id>/books`, with `404` for an
unknown author.

??? success "Answer"

    ```python
    @app.get("/authors/<int:author_id>/books")
    def author_books(author_id):
        """List one author's books, or 404 if there is no such author."""
        with Session(engine) as session:
            author = session.get(Author, author_id)
            if author is None:
                abort(404, description=f"No author with id {author_id}")
            return jsonify([book_json(book) for book in author.books])
    ```

    ```bash
    curl -s http://127.0.0.1:5000/authors/3/books
    ```

    ```text
    [{"id":5,"title":"Nineteen Eighty-Four","year":1949,"author":{"id":3,"name":"George Orwell"}},{"id":6,"title":"Animal Farm","year":1945,"author":{"id":3,"name":"George Orwell"}}]
    ```

    ```bash
    curl -s http://127.0.0.1:5000/authors/42/books
    ```

    ```text
    {"error":"No author with id 42"}
    ```

**3. Borrow.** Add `POST /members/<id>/loans`, with a body such as
`{"book_id": 10}`. Answer `201` with the new loan, `404` for an unknown
member or book, and `409` if the book is already out.

??? success "Answer"

    ```python
    @app.post("/members/<int:member_id>/loans")
    def borrow_book(member_id):
        """Lend the book in the JSON body to a member: 201, or 409 if it is out."""
        data = request.get_json(silent=True) or {}
        with Session(engine) as session:
            member = session.get(Member, member_id)
            book = session.get(Book, data.get("book_id"))
            if member is None or book is None:
                abort(404, description="No such member or book")
            if any(loan.returned_on is None for loan in book.loans):
                abort(409, description=f"'{book.title}' is already out")
            loan = Loan(member=member, book=book,
                        loaned_on=date.today().isoformat())
            session.add(loan)
            session.commit()
            return jsonify({"id": loan.id, "book": book.title,
                            "loaned_on": loan.loaned_on}), 201
    ```

    ```bash
    curl -i -X POST http://127.0.0.1:5000/members/5/loans -H "Content-Type: application/json" -d '{"book_id": 10}'
    ```

    ```text
    HTTP/1.1 201 CREATED
    Content-Type: application/json

    {"id":13,"book":"Things Fall Apart","loaned_on":"2026-10-31"}
    ```

    ```bash
    curl -s -X POST http://127.0.0.1:5000/members/5/loans -H "Content-Type: application/json" -d '{"book_id": 8}'
    ```

    ```text
    {"error":"'Dune' is already out"}
    ```

**4. Paging.** Let `GET /books` take `?limit=` and `?offset=`, with a
default of 20 and a maximum of 50 books per page.

??? success "Answer"

    Replace `list_books`. `min` and `max` keep the numbers in range, so a
    client cannot ask for a million rows at once:

    ```python
    @app.get("/books")
    def list_books():
        """List the books, one page at a time: ?limit= (1 to 50) and ?offset=."""
        limit = min(max(request.args.get("limit", 20, type=int), 1), 50)
        offset = max(request.args.get("offset", 0, type=int), 0)
        query = select(Book).order_by(Book.id).limit(limit).offset(offset)
        author_id = request.args.get("author_id", type=int)
        if author_id is not None:
            query = query.where(Book.author_id == author_id)
        with Session(engine) as session:
            return jsonify([book_json(book) for book in session.scalars(query)])
    ```

    ```bash
    curl -s "http://127.0.0.1:5000/books?limit=2&offset=4"
    ```

    ```text
    [{"id":5,"title":"Nineteen Eighty-Four","year":1949,"author":{"id":3,"name":"George Orwell"}},{"id":6,"title":"Animal Farm","year":1945,"author":{"id":3,"name":"George Orwell"}}]
    ```

    ```bash
    curl -s "http://127.0.0.1:5000/books?limit=1000&offset=9"
    ```

    ```text
    [{"id":10,"title":"Things Fall Apart","year":1958,"author":{"id":7,"name":"Chinua Achebe"}}]
    ```

**5. A test.** Write tests that `DELETE /books/8` answers `409` and
leaves the book in place, and that deleting a book with no loans answers
`204`, then `404` when you read it.

??? success "Answer"

    ```python title="test_conflict.py"
    """A test for deleting a book that has loans."""
    import shutil
    import unittest

    shutil.copy("library.db", "test-library.db")

    import api  # noqa: E402
    from models import make_engine  # noqa: E402

    api.engine = make_engine("test-library.db")


    class DeleteTest(unittest.TestCase):
        """Check DELETE /books/<id>."""

        def test_book_with_loans_is_409(self):
            client = api.app.test_client()
            response = client.delete("/books/8")
            self.assertEqual(response.status_code, 409)
            self.assertEqual(client.get("/books/8").status_code, 200)

        def test_unused_book_is_204_then_404(self):
            client = api.app.test_client()
            self.assertEqual(client.delete("/books/4").status_code, 204)
            self.assertEqual(client.get("/books/4").status_code, 404)


    if __name__ == "__main__":
        unittest.main(verbosity=2)
    ```

    ```bash
    python3 test_conflict.py
    ```

    ```text
    test_book_with_loans_is_409 (__main__.DeleteTest.test_book_with_loans_is_409) ... ok
    test_unused_book_is_204_then_404 (__main__.DeleteTest.test_unused_book_is_204_then_404) ... ok

    ----------------------------------------------------------------------
    Ran 2 tests in 0.04s

    OK
    ```

## Explain it to someone

- [ ] What an HTTP request and response contain: method, path, headers, body, status code
- [ ] What makes an API RESTful: resources, methods, representations, statelessness
- [ ] How the methods map to CRUD and SQL, and which ones are idempotent
- [ ] How to write Flask routes with path and query parameters
- [ ] How to read a JSON body, validate it, and answer with the right status code
- [ ] The difference between `PUT` and `PATCH`
- [ ] What `200`, `201`, `204`, `400`, `404`, `405`, `409` and `500` mean
- [ ] How to call an API with `curl` and with `requests`
- [ ] How to test an API with Flask's test client

## Quick reference

| Code | What it does |
|---|---|
| `app = Flask(__name__)` | Create the application |
| `@app.get("/books")`, `@app.post(...)`, `.patch`, `.delete` | Register a route for a method and a path |
| `"/books/<int:book_id>"` | A path parameter, passed to the function |
| `request.args.get("x", type=int)` | A query parameter, or `None` |
| `request.get_json(silent=True)` | The JSON body, or `None` |
| `jsonify(data)`, `return data, 201` | A JSON response, with a status code |
| `abort(404, description="...")` | Stop and answer with an error |
| `@app.errorhandler(404)` | Customise an error response |
| `flask --app api run --debug` | Run the server, reloading on changes |
| `curl -i -X POST URL -H "..." -d '...'` | Send a request and show the headers |
| `requests.get(url, params=...)`, `requests.post(url, json=...)` | Call an API from Python |
| `app.test_client().get("/books")` | Test without a server |

## Next

That completes Data & APIs: files, SQL, database design, an ORM and a
REST API, all on one library. The same pieces, at a larger scale, are
the back end of the portfolio projects. Next, the module that builds
what users see in the browser.

[Web Front-end](../web-frontend/index.md){ .h-button }
