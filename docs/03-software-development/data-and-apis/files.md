# File Handling

<span class="badge badge--time">75 min</span>
<span class="badge badge--level">Data & APIs</span>
<span class="badge">Needs: From Script to Application</span>

Everything the wallet knows lives in memory, and memory is wiped every
time the program stops. Files are the simplest way to make a program
remember. In this tutorial you learn to open, write, read and close
files safely, then give the wallet two of them: a **snapshot** of every
customer and account, and a **journal** of every transaction. Run the
program twice and it carries on where it stopped.

## Why this matters

Almost every program reads or writes files: configuration, logs,
exports, uploads, data passed between systems. Getting the basics right
matters more than it looks. A file that is never closed can lose data;
a write in the wrong mode can wipe out everything that was there.

Files are also the first step towards databases. By the end of this
tutorial you will have hit the limits of plain files yourself, and you
will know exactly what a database is for.

## Where we left off

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 120" role="img" aria-labelledby="fh-plan-title fh-plan-desc">
<title id="fh-plan-title">How the wallet application grows across Data &amp; APIs</title>
<desc id="fh-plan-desc">Version 6, From Script to Application: the wallet package: done. Version 7, File Handling: a snapshot and a journal: this page. Version 8, SQL CRUD: tables and rows: coming next. Version 9, Joins: data across tables: coming next. Version 10, Database design: a normalised schema: coming next. Version 11, ORM: classes mapped to tables: coming next. Version 12, REST API: the wallet over HTTP: coming next.</desc>
<defs><marker id="fh-plan-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<rect x="3" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<rect x="101" y="16" width="86" height="88" rx="10" fill="var(--h-cherry)"/>
<rect x="199" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="297" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="395" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="493" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="591" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<g text-anchor="middle">
<text x="46" y="38" font-size="10" font-weight="700" fill="var(--h-fig-muted)">v6 · DONE</text>
<text x="46" y="64" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">Package</text>
<text x="46" y="84" font-size="10" fill="var(--h-fig-muted)">modules</text>
<text x="144" y="38" font-size="10" font-weight="700" fill="#ffffff" opacity="0.85">v7 · NOW</text>
<text x="144" y="64" font-size="12.5" font-weight="700" fill="#ffffff">Files</text>
<text x="144" y="84" font-size="10" fill="#ffffff" opacity="0.9">JSON, journal</text>
<text x="242" y="38" font-size="10" font-weight="700" fill="var(--h-fig-muted)">v8</text>
<text x="242" y="64" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">SQL CRUD</text>
<text x="242" y="84" font-size="10" fill="var(--h-fig-muted)">tables</text>
<text x="340" y="38" font-size="10" font-weight="700" fill="var(--h-fig-muted)">v9</text>
<text x="340" y="64" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">Joins</text>
<text x="340" y="84" font-size="10" fill="var(--h-fig-muted)">relations</text>
<text x="438" y="38" font-size="10" font-weight="700" fill="var(--h-fig-muted)">v10</text>
<text x="438" y="64" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">Design</text>
<text x="438" y="84" font-size="10" fill="var(--h-fig-muted)">schema</text>
<text x="536" y="38" font-size="10" font-weight="700" fill="var(--h-fig-muted)">v11</text>
<text x="536" y="64" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">ORM</text>
<text x="536" y="84" font-size="10" fill="var(--h-fig-muted)">mapping</text>
<text x="634" y="38" font-size="10" font-weight="700" fill="var(--h-fig-muted)">v12</text>
<text x="634" y="64" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">REST API</text>
<text x="634" y="84" font-size="10" fill="var(--h-fig-muted)">endpoints</text>
</g>
<g stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#fh-plan-arrow)">
<line x1="91" y1="60" x2="99" y2="60"/>
<line x1="189" y1="60" x2="197" y2="60"/>
<line x1="287" y1="60" x2="295" y2="60"/>
<line x1="385" y1="60" x2="393" y2="60"/>
<line x1="483" y1="60" x2="491" y2="60"/>
<line x1="581" y1="60" x2="589" y2="60"/>
</g>
</svg>
</figure>

Start from the tag
[`v6-package`](https://github.com/evisp/oop-wallet/tree/v6-package): the
wallet as a package, run from `main.py`. This tutorial adds one new
module, `wallet/storage.py`, and two small methods to existing
classes.

The first five steps use a scratch file to learn the tools. The rest
apply them to the wallet. Work in a scratch folder for the first part:

```bash
mkdir -p ~/holberton/files-practice
cd ~/holberton/files-practice
python3
```

## Step 1: Open a file

`open` connects your program to a file and returns a **file object**,
which you use to read or write:

```python
file = open("notes.txt", "w", encoding="utf-8")
```

It takes three things:

- **The path.** A plain name such as `"notes.txt"` is relative to the
  folder you ran the program from, not to the script's folder. A path
  such as `"data/notes.txt"` goes into a subfolder, which must exist.
- **The mode**: what you intend to do. It decides where the file's
  **cursor** starts, and what happens to the file's existing content.
- **The encoding**: how text becomes bytes on disk. Always pass
  `encoding="utf-8"`. Without it, Python uses the system default, which
  differs between Linux and Windows, and Albanian letters such as ë and
  ç come out garbled when the file moves between them.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 210" role="img" aria-labelledby="fh-modes-title fh-modes-desc">
<title id="fh-modes-title">What the three main modes do to a file</title>
<desc id="fh-modes-desc">Mode r reads: the cursor starts at the beginning of the existing content, and the file must exist. Mode w writes: the existing content is removed as soon as the file is opened, the cursor starts at the beginning, and the file is created if it is missing. Mode a appends: the cursor is at the end, every write goes after the existing content, and the file is created if it is missing.</desc>
<g font-family="var(--md-code-font-family, monospace)" font-size="22" font-weight="700" text-anchor="middle">
<rect x="3" y="16" width="56" height="48" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/><text x="31" y="48" fill="var(--h-fig-text)">"r"</text>
<rect x="3" y="81" width="56" height="48" rx="10" fill="var(--h-cherry)"/><text x="31" y="113" fill="#ffffff">"w"</text>
<rect x="3" y="146" width="56" height="48" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/><text x="31" y="178" fill="var(--h-fig-text)">"a"</text>
</g>
<g font-family="var(--md-code-font-family, monospace)" font-size="12" text-anchor="middle">
<rect x="84" y="22" width="100" height="36" rx="6" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="134" y="45" fill="var(--h-fig-text)">line 1</text>
<rect x="188" y="22" width="100" height="36" rx="6" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="238" y="45" fill="var(--h-fig-text)">line 2</text>
<rect x="84" y="87" width="100" height="36" rx="6" fill="none" stroke="var(--h-fig-line)" stroke-dasharray="4 3"/><text x="134" y="110" fill="var(--h-fig-muted)" text-decoration="line-through">line 1</text>
<rect x="188" y="87" width="100" height="36" rx="6" fill="none" stroke="var(--h-fig-line)" stroke-dasharray="4 3"/><text x="238" y="110" fill="var(--h-fig-muted)" text-decoration="line-through">line 2</text>
<rect x="84" y="152" width="100" height="36" rx="6" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="134" y="175" fill="var(--h-fig-text)">line 1</text>
<rect x="188" y="152" width="100" height="36" rx="6" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="238" y="175" fill="var(--h-fig-text)">line 2</text>
<rect x="296" y="152" width="100" height="36" rx="6" fill="var(--h-cherry)"/><text x="346" y="175" fill="#ffffff" font-weight="700">new line</text>
</g>
<g fill="var(--h-cherry)">
<rect x="79" y="16" width="3" height="48"/><polygon points="80.5,66 74,76 87,76"/>
<rect x="79" y="81" width="3" height="48"/><polygon points="80.5,131 74,141 87,141"/>
<rect x="291" y="146" width="3" height="48"/><polygon points="292.5,196 286,206 299,206"/>
</g>
<g font-size="12.5">
<text x="430" y="36" font-weight="700" fill="var(--h-fig-text)">Read</text>
<text x="430" y="54" font-size="11.5" fill="var(--h-fig-muted)">reads from the start; must exist</text>
<text x="430" y="101" font-weight="700" fill="var(--h-cherry)">Write</text>
<text x="430" y="119" font-size="11.5" fill="var(--h-fig-muted)">empties the file at once; creates it</text>
<text x="430" y="166" font-weight="700" fill="var(--h-fig-text)">Append</text>
<text x="430" y="184" font-size="11.5" fill="var(--h-fig-muted)">writes go to the end; creates it</text>
</g>
</svg>
</figure>

| Mode | Meaning | If the file exists | If it does not |
|---|---|---|---|
| `"r"` | read, the default | read from the start | `FileNotFoundError` |
| `"w"` | write | **emptied immediately** | created |
| `"a"` | append | writes go to the end | created |
| `"x"` | create | `FileExistsError` | created |

Add `"+"` to read and write with the same file object, as in `"r+"`, or
`"b"` for binary files such as images, as in `"rb"`. This tutorial needs
neither.

The cherry row deserves the warning: **`"w"` empties the file the moment
you open it**, before you write anything. Opening a file with `"w"`
"just to look" destroys it.

## Step 2: Write text to a file

`write` adds a string at the cursor, and returns how many characters it
wrote:

```python
file = open("notes.txt", "w", encoding="utf-8")
file.write("First line\n")      # 11
file.write("Second line\n")     # 12
file.close()
```

Two details catch everyone:

- **`write` adds no newline.** You write `"\n"` yourself, or every
  "line" ends up on one line.
- **`write` takes only strings.** `file.write(42)` raises
  `TypeError: write() argument must be str, not int`. Convert first, or
  use an f-string.

`print` can also write to a file, adding the space and newline for you:

```python
with open("notes.txt", "a", encoding="utf-8") as file:
    print("Third", "line", file=file)
```

The `with` line is explained in Step 4. For now, read it as "open the
file, and close it at the end of the block".

## Step 3: Read a file

There are four ways to read, depending on how much you want at once.

**The whole file**, as one string, with `read()`:

```python
with open("notes.txt", encoding="utf-8") as file:
    text = file.read()
# 'First line\nSecond line\n'
```

`read(n)` reads only the next `n` characters. Mode `"r"` is the
default, so it can be left out.

**Line by line**, by looping over the file object. This is the way to
read large files, because only one line is in memory at a time:

```python
with open("notes.txt", encoding="utf-8") as file:
    for line in file:
        print(line.rstrip("\n"))
```

```
First line
Second line
```

Each `line` still ends with its `"\n"`. Remove it with
`line.rstrip("\n")`, or `print(line)` prints a blank line after each
one.

**One line at a time**, with `readline()`, which returns `""` once the
file is finished, and **all lines as a list**, with `readlines()`:

```python
file.readline()     # 'First line\n'
file.readline()     # 'Second line\n'
file.readline()     # '': the end of the file
file.readlines()    # ['First line\n', 'Second line\n'], from a fresh start
```

## Step 4: Make sure the file is closed

A file object holds something the operating system lends you, and
`close()` gives it back. Forgetting has real consequences:

- **Data can be lost.** Writes are collected in a memory buffer and
  saved to disk in batches. Until the file is closed or flushed, the
  text may not be on disk at all:

    ```python
    file = open("draft.txt", "w", encoding="utf-8")
    file.write("hello")
    open("draft.txt", encoding="utf-8").read()   # '': not on disk yet
    file.close()
    open("draft.txt", encoding="utf-8").read()   # 'hello'
    ```

- **Files stay locked.** On Windows, another program cannot delete or
  replace a file you still have open.
- **Every system has a limit** on how many files one program can hold
  open. A loop that opens a file per transaction and never closes them
  eventually crashes.

Calling `close()` yourself is not enough, because if anything between
`open` and `close` raises an exception, `close` is skipped. The safe
version uses `try` and `finally`, which you met in Exception Handling:

```python
file = open("notes.txt", encoding="utf-8")
try:
    text = file.read()
finally:
    file.close()          # runs even if read() fails
```

### The `with` statement

That pattern is so common that Python has a statement for it:

```python
with open("notes.txt", encoding="utf-8") as file:
    text = file.read()
# here the file is already closed
```

`with` opens the file, assigns it to `file`, runs the indented block, and
then **closes the file whatever happens**: at the end of the block,
after a `return`, or when an exception is raised inside it. It is
exactly the `try` and `finally` above, in two lines. You can check:

```python
file.closed     # True
```

From here on, every file in this course is opened with `with`. Objects
that work with `with` are called **context managers**; files are the
one you will use most, and database connections, which you meet next,
are another.

## Step 5: Move the cursor

Every open file has a **cursor**, a position measured from the start.
Reading and writing happen at the cursor, and move it forward. Two
methods let you control it:

- `tell()` returns the current position.
- `seek(position)` moves the cursor there.

Write a small file, then move around in it:

```python
with open("notes.txt", "w", encoding="utf-8") as file:
    file.write("deposit,1000\nwithdraw,230\n")

with open("notes.txt", encoding="utf-8") as file:
    file.tell()        # 0: at the start
    file.readline()    # 'deposit,1000\n'
    mark = file.tell() # 13: just after the first line
    file.read()        # 'withdraw,230\n'
    file.tell()        # 26: the end
    file.seek(0)       # back to the start
    file.readline()    # 'deposit,1000\n' again
    file.seek(mark)    # back to the saved position
    file.readline()    # 'withdraw,230\n'
```

Two rules apply to text files:

- **Only seek to `0`, or to a number `tell()` gave you.** In a text file a
  position is not always a character count, because some characters take
  more than one byte on disk. Positions that came from `tell()` are
  always safe.
- **`tell()` does not work inside a `for line in file` loop.** Python
  reads ahead while looping, so the position is not reliable, and it
  refuses: `OSError: telling position disabled by next() call`. Use
  `readline()` or `readlines()` when you need positions.

In Step 10 the wallet uses exactly this to read only the journal lines
it has not seen yet.

## Step 6: Plan the wallet's files

Now apply all of this to the wallet. It needs to remember two different
kinds of thing, and each suits a different file:

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 280" role="img" aria-labelledby="fh-two-title fh-two-desc">
<title id="fh-two-title">The wallet's two files</title>
<desc id="fh-two-desc">The customers and accounts in memory are saved to data/customers.json with save_customers, which opens it in mode w and replaces the whole snapshot, and read back with load_customers, which reads the whole file. Separately, every transaction reaches a FileJournal observer, which appends one line to data/journal.log in mode a. The journal is read line by line by statement, and from a saved position by JournalReader.</desc>
<defs><marker id="fh-two-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker>
<marker id="fh-two-arrow-c" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-cherry)"/></marker></defs>
<rect x="3" y="20" width="210" height="206" rx="12" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="22" y="46" font-size="11" font-weight="700" fill="var(--h-fig-muted)">IN MEMORY</text>
<g font-size="12.5" font-family="var(--md-code-font-family, monospace)" fill="var(--h-fig-text)">
<text x="22" y="74">Customer</text>
<text x="38" y="96">SavingsAccount</text>
<text x="38" y="118">CheckingAccount</text>
</g>
<text x="22" y="150" font-size="11" fill="var(--h-fig-muted)">gone when the program stops</text>
<rect x="430" y="20" width="247" height="80" rx="10" fill="var(--md-default-bg-color)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="446" y="46" font-size="12.5" font-weight="700" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">data/customers.json</text>
<text x="446" y="66" font-size="11.5" fill="var(--h-fig-text)">snapshot · JSON</text>
<text x="446" y="84" font-size="11" fill="var(--h-fig-muted)">replaced on every save</text>
<rect x="430" y="150" width="247" height="80" rx="10" fill="var(--md-default-bg-color)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="446" y="176" font-size="12.5" font-weight="700" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">data/journal.log</text>
<text x="446" y="196" font-size="11.5" fill="var(--h-fig-text)">journal · one line per event</text>
<text x="446" y="214" font-size="11" fill="var(--h-fig-muted)">only ever appended to</text>
<rect x="256" y="176" width="130" height="50" rx="10" fill="var(--h-cherry)"/>
<text x="321" y="198" text-anchor="middle" font-size="12.5" font-weight="700" fill="#ffffff">FileJournal</text>
<text x="321" y="215" text-anchor="middle" font-size="10.5" fill="#ffffff" opacity="0.9">an observer</text>
<g stroke="var(--h-fig-line)" stroke-width="2" fill="none">
<line x1="217" y1="44" x2="424" y2="44" marker-end="url(#fh-two-arrow)"/>
<line x1="424" y1="78" x2="219" y2="78" marker-end="url(#fh-two-arrow)"/>
<line x1="217" y1="200" x2="250" y2="200" marker-end="url(#fh-two-arrow)"/>
</g>
<line x1="390" y1="200" x2="424" y2="200" stroke="var(--h-cherry)" stroke-width="2" marker-end="url(#fh-two-arrow-c)"/>
<g font-size="11.5" font-weight="600">
<text x="320" y="36" text-anchor="middle" fill="var(--h-cherry)" font-family="var(--md-code-font-family, monospace)">save_customers()  "w"</text>
<text x="320" y="96" text-anchor="middle" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">load_customers()  read()</text>
<text x="232" y="190" text-anchor="middle" fill="var(--h-fig-muted)">notify</text>
<text x="407" y="190" text-anchor="middle" fill="var(--h-cherry)" font-family="var(--md-code-font-family, monospace)">"a"</text>
</g>
<text x="553" y="256" text-anchor="middle" font-size="11" fill="var(--h-fig-muted)">read by <tspan font-family="var(--md-code-font-family, monospace)">statement()</tspan> line by line,</text>
<text x="553" y="272" text-anchor="middle" font-size="11" fill="var(--h-fig-muted)">and by <tspan font-family="var(--md-code-font-family, monospace)">JournalReader</tspan> with seek and tell</text>
</svg>
</figure>

| | The snapshot | The journal |
|---|---|---|
| Holds | the current state: customers, accounts, balances | the history: every transaction ever made |
| Format | JSON, one document | plain text, one line per transaction |
| Written with | `"w"`: the whole file is replaced on each save | `"a"`: new lines are added at the end |
| Read with | `read()`: all at once | line by line |

The snapshot can be replaced every time because only the latest state
matters. The journal must never be rewritten: its whole value is that it
remembers everything, in order.

All the new code goes into one module, `wallet/storage.py`. It sits at
the top of the package's layers, because it imports `Customer` and
`account_factory`, and nothing in the package imports it.

## Step 7: Save a snapshot

**JSON** is a text format for structured data, and Python's `json`
module converts between it and dictionaries and lists. It has nothing
to do with files: `json.dumps` turns data into a string, and
`json.loads` turns a string back into data. Writing that string to a
file is still your job.

Each account can already describe itself, with `to_dict()` from the
`JSONMixin`. The snapshot also needs the factory's *kind*, such as
`"savings"`, so the account can be created again later. The factory is
the one place that knows kinds, so it gets a reverse lookup:

```python
# in wallet/factory.py, inside AccountFactory
    def kind_of(self, account):
        """Return the registered kind that creates this account's class."""
        for kind, account_class in self._registry.items():
            if type(account) is account_class:
                return kind
        raise ValueError(f"no registered kind for {type(account).__name__}")
```

Then saving is: build the records, turn them into one JSON string, and
write it.

```python
def _account_record(account):
    """Return what is needed to rebuild account, as a dictionary."""
    record = account.to_dict()
    del record["type"]
    return {"kind": account_factory.kind_of(account), **record}


def save_customers(customers, path):
    """Write every customer and account to path; return characters written."""
    records = [
        {
            "name": customer.name,
            "email": customer.email,
            "accounts": [_account_record(a) for a in customer.accounts],
        }
        for customer in customers
    ]
    _ensure_folder(path)
    with open(path, "w", encoding="utf-8") as file:
        return file.write(json.dumps(records, indent=2) + "\n")
```

`_ensure_folder` creates the `data/` folder if it is not there yet, with
`os.makedirs(folder, exist_ok=True)`. `indent=2` lays the JSON out over
several lines, so a person can read it:

```json title="data/customers.json"
[
  {
    "name": "Ada",
    "email": "ada@example.com",
    "accounts": [
      {
        "kind": "savings",
        "owner": "Ada",
        "balance": 1091,
        "rate": 2
      },
      {
        "kind": "checking",
        "owner": "Ada",
        "balance": 200,
        "overdraft": 500
      }
    ]
  }
]
```

## Step 8: Load it back

Loading is the reverse: read the whole file, turn the text back into
data, and rebuild the objects with the factory.

```python
def load_customers(path):
    """Read the customers saved in path; return [] if there is no file."""
    try:
        with open(path, encoding="utf-8") as file:
            text = file.read()
    except FileNotFoundError:
        return []
    customers = []
    for record in json.loads(text):
        customer = Customer(record["name"], record["email"])
        for data in record["accounts"]:
            options = dict(data)
            kind = options.pop("kind")
            balance = options.pop("balance")
            account = account_factory.create(kind, **options)
            account._restore_balance(balance)
            customer.add_account(account)
        customers.append(customer)
    return customers
```

A missing file is not an error here, it is the first run: there is
nothing saved yet, so there are no customers. That is why
`FileNotFoundError` returns an empty list.

### Loading is not depositing

Look at how the balance comes back. The account is created with no
balance, and then `_restore_balance` puts the saved one back:

```python
# in wallet/accounts.py, inside Account
    def _restore_balance(self, balance):
        """Set a saved balance back, without recording a transaction."""
        if isinstance(balance, bool) or not isinstance(balance, int):
            raise TypeError("balance must be an integer")
        self._balance = balance
```

Why not `SavingsAccount("Ada", balance=1091)`? For two reasons. The
constructor records an opening balance as a *deposit*, so every load
would invent a deposit that never happened. And the constructor refuses
negative balances, so an overdrawn checking account could never be
loaded at all. Creating a new account and restoring a saved one are
different operations, with different rules, so they get different
methods. The leading underscore says that only the package itself
should use it.

The snapshot stores customers and their accounts. Gift cards are left
out to keep the example short; saving them follows exactly the same
steps, and makes a good exercise.

## Step 9: Journal every transaction

The journal needs to hear about every deposit, withdrawal, payment,
interest and fee, from every account. The wallet already has a way to
announce exactly that: the **Observer** pattern from the last module.
The journal is simply a new observer, with a `notify` method that
appends a line:

```python
class FileJournal:
    """Observer: append one line to a text file for every event."""

    def __init__(self, path):
        _ensure_folder(path)
        self.path = path

    def notify(self, source, topic, amount):
        """Append the event as one comma-separated line."""
        line = f"{_owner_of(source)},{type(source).__name__},{topic},{amount}"
        with open(self.path, "a", encoding="utf-8") as file:
            file.write(line + "\n")
```

```text title="data/journal.log"
Ada,SavingsAccount,deposit,1000
Ada,CheckingAccount,deposit,500
Ada,CheckingAccount,withdraw,230
Ada,CheckingAccount,withdraw,70
Ada,SavingsAccount,deposit,70
Ada,SavingsAccount,interest,21
```

Subscribe it to each account, and every transaction is saved. No class
in the wallet changed to make this happen: persistence plugged in
through an interface that was designed for something else. That is the
payoff of the patterns from the last module.

`notify` opens and closes the file for each line. That is slower than
keeping it open, but every line is safely on disk the moment it is
written, and there is never an open file to forget about. For a few
transactions at a time, safety wins.

## Step 10: Read the journal

**A statement** reads the journal line by line and keeps the lines for
one customer:

```python
def statement(path, owner):
    """Return the journal entries for owner, one formatted line each."""
    lines = []
    try:
        with open(path, encoding="utf-8") as file:
            for line in file:
                who, source, topic, amount = line.rstrip("\n").split(",")
                if who == owner:
                    lines.append(f"{source:<16} {topic:<9} {amount:>6}")
    except FileNotFoundError:
        pass
    return lines
```

The journal could grow to millions of lines, and looping over the file
keeps only one of them in memory at a time.

**"What is new since I last looked"** is the job of the cursor. A
`JournalReader` remembers the position where it stopped reading, and
next time jumps straight there:

```python
class JournalReader:
    """Read a journal a little at a time, remembering where it stopped."""

    def __init__(self, path):
        self.path = path
        self._position = 0

    def read_new(self):
        """Return the lines added since the last call, without newlines."""
        try:
            with open(self.path, encoding="utf-8") as file:
                file.seek(self._position)
                lines = file.readlines()
                self._position = file.tell()
        except FileNotFoundError:
            return []
        return [line.rstrip("\n") for line in lines]
```

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 168" role="img" aria-labelledby="fh-cur-title fh-cur-desc">
<title id="fh-cur-title">Reading only the new lines of the journal</title>
<desc id="fh-cur-desc">The journal holds lines 1 to 6 from the first run and lines 7 to 11 from the second run. At the end of its previous call, JournalReader saved the position returned by tell, just after line 6. The next call seeks to that position and reads only lines 7 to 11, then saves the new end position.</desc>
<g font-size="11" font-weight="700" fill="var(--h-fig-muted)">
<text x="43" y="30">run 1 wrote these</text>
<text x="367" y="30">run 2 appended these</text>
</g>
<g font-family="var(--md-code-font-family, monospace)" font-size="12" font-weight="700" text-anchor="middle">
<rect x="43" y="44" width="50" height="40" rx="6" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="68" y="69" fill="var(--h-fig-muted)">1</text>
<rect x="97" y="44" width="50" height="40" rx="6" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="122" y="69" fill="var(--h-fig-muted)">2</text>
<rect x="151" y="44" width="50" height="40" rx="6" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="176" y="69" fill="var(--h-fig-muted)">3</text>
<rect x="205" y="44" width="50" height="40" rx="6" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="230" y="69" fill="var(--h-fig-muted)">4</text>
<rect x="259" y="44" width="50" height="40" rx="6" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="284" y="69" fill="var(--h-fig-muted)">5</text>
<rect x="313" y="44" width="50" height="40" rx="6" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="338" y="69" fill="var(--h-fig-muted)">6</text>
<rect x="369" y="44" width="50" height="40" rx="6" fill="var(--h-cherry)"/><text x="394" y="69" fill="#ffffff">7</text>
<rect x="423" y="44" width="50" height="40" rx="6" fill="var(--h-cherry)"/><text x="448" y="69" fill="#ffffff">8</text>
<rect x="477" y="44" width="50" height="40" rx="6" fill="var(--h-cherry)"/><text x="502" y="69" fill="#ffffff">9</text>
<rect x="531" y="44" width="50" height="40" rx="6" fill="var(--h-cherry)"/><text x="556" y="69" fill="#ffffff">10</text>
<rect x="585" y="44" width="50" height="40" rx="6" fill="var(--h-cherry)"/><text x="610" y="69" fill="#ffffff">11</text>
</g>
<g stroke="var(--h-fig-text)" stroke-width="2">
<line x1="40" y1="38" x2="40" y2="96"/>
<line x1="366" y1="38" x2="366" y2="96"/>
<line x1="638" y1="38" x2="638" y2="96"/>
</g>
<g font-size="11" font-weight="700" text-anchor="middle" fill="var(--h-fig-text)">
<text x="40" y="112">0</text>
<text x="366" y="112">saved position</text>
<text x="638" y="112" text-anchor="end">new end</text>
</g>
<text x="366" y="128" text-anchor="middle" font-size="11" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">tell() last time</text>
<polyline points="369,142 369,150 635,150 635,142" fill="none" stroke="var(--h-cherry)" stroke-width="2"/>
<text x="502" y="164" text-anchor="middle" font-size="11.5" font-weight="700" fill="var(--h-cherry)">seek(saved) then readlines(): only 7 to 11</text>
</svg>
</figure>

It uses `readlines()` rather than a `for` loop on purpose: as Step 5
warned, `tell()` is refused inside a loop over the file.

## Step 11: Run it twice

The new `main.py` loads Ada if she was saved before, or creates her on
the first run. It then subscribes the journal, makes the same kind of
payment as before, closes the month, saves the snapshot and prints a
statement.

```bash
./main.py
```

```
Ada: 1091 ALL
Ada: 200 ALL (overdraft 500)
Saved 1 customer, 315 characters
This run added 6 journal lines
Statement for Ada:
SavingsAccount   deposit     1000
CheckingAccount  deposit      500
CheckingAccount  withdraw     230
CheckingAccount  withdraw      70
SavingsAccount   deposit       70
SavingsAccount   interest      21
```

Now run it again. The balances carry on from where they stopped, and the
journal keeps growing:

```
Ada: 1184 ALL
Ada: 400 ALL (overdraft 500)
Saved 1 customer, 315 characters
This run added 5 journal lines
Statement for Ada:
SavingsAccount   deposit     1000
CheckingAccount  deposit      500
CheckingAccount  withdraw     230
CheckingAccount  withdraw      70
SavingsAccount   deposit       70
SavingsAccount   interest      21
CheckingAccount  deposit      500
CheckingAccount  withdraw     230
CheckingAccount  withdraw      70
SavingsAccount   deposit       70
SavingsAccount   interest      23
```

The wallet remembers. To start again from nothing, delete the folder:
`rm -r data`. The `data/` folder is listed in `.gitignore`, because it
holds what the program produced, not code.

## Step 12: Where files stop being enough

Files work, and for many programs they are all you need. Push them a
little further and the cracks show. Every one of these is real in the
code you just wrote:

- **The format is fragile.** A customer called `"Smith, Jane"` writes a
  journal line with an extra comma, and `statement` crashes with
  `ValueError: too many values to unpack`.
- **Two files must agree, and nothing makes them.** If the program
  crashes after writing the journal but before saving the snapshot, the
  journal shows transactions the balances never received.
- **A crash during a save loses everything.** `"w"` empties the snapshot
  first; a crash halfway through the write leaves a broken file.
- **Two programs cannot share the files safely.** Two copies of the
  wallet running at once overwrite each other's snapshots.
- **Every question means reading everything.** "Which accounts are
  overdrawn?" or "all fees in October" means loading the whole snapshot
  or scanning the whole journal.

A **database** solves all five: it stores structured rows instead of
text lines, keeps related data consistent, finishes a change completely
or not at all, lets many programs work at once, and answers questions
without reading everything. That is the next tutorial.

## The code so far

This is version 7, tagged
[`v7-files`](https://github.com/evisp/oop-wallet/tree/v7-files). The new
module is `wallet/storage.py`; the other changes are `kind_of` in
`factory.py`, `_restore_balance` in `accounts.py`, the new `main.py`,
and `data/` in `.gitignore`.

??? example "New and changed files · version 7"

    === "wallet/storage.py"

        ```python
        """Save the wallet to files, and read it back.

        Two files, two jobs:

        - a snapshot of every customer and account, as JSON, replaced on every save;
        - a journal of every transaction, one line each, only ever appended to.
        """
        import json
        import os

        from .customers import Customer
        from .factory import account_factory


        def _ensure_folder(path):
            """Create the folder that will hold path, if it does not exist."""
            folder = os.path.dirname(path)
            if folder:
                os.makedirs(folder, exist_ok=True)


        def _account_record(account):
            """Return what is needed to rebuild account, as a dictionary."""
            record = account.to_dict()
            del record["type"]
            return {"kind": account_factory.kind_of(account), **record}


        def save_customers(customers, path):
            """Write every customer and account to path; return characters written."""
            records = [
                {
                    "name": customer.name,
                    "email": customer.email,
                    "accounts": [_account_record(a) for a in customer.accounts],
                }
                for customer in customers
            ]
            _ensure_folder(path)
            with open(path, "w", encoding="utf-8") as file:
                return file.write(json.dumps(records, indent=2) + "\n")


        def load_customers(path):
            """Read the customers saved in path; return [] if there is no file."""
            try:
                with open(path, encoding="utf-8") as file:
                    text = file.read()
            except FileNotFoundError:
                return []
            customers = []
            for record in json.loads(text):
                customer = Customer(record["name"], record["email"])
                for data in record["accounts"]:
                    options = dict(data)
                    kind = options.pop("kind")
                    balance = options.pop("balance")
                    account = account_factory.create(kind, **options)
                    account._restore_balance(balance)
                    customer.add_account(account)
                customers.append(customer)
            return customers


        def _owner_of(source):
            """Return the name of whoever owns or holds source."""
            holder = getattr(source, "holder", None)
            if holder is not None:
                return holder.name
            return getattr(source, "owner", "-")


        class FileJournal:
            """Observer: append one line to a text file for every event."""

            def __init__(self, path):
                _ensure_folder(path)
                self.path = path

            def notify(self, source, topic, amount):
                """Append the event as one comma-separated line."""
                line = f"{_owner_of(source)},{type(source).__name__},{topic},{amount}"
                with open(self.path, "a", encoding="utf-8") as file:
                    file.write(line + "\n")


        def statement(path, owner):
            """Return the journal entries for owner, one formatted line each."""
            lines = []
            try:
                with open(path, encoding="utf-8") as file:
                    for line in file:
                        who, source, topic, amount = line.rstrip("\n").split(",")
                        if who == owner:
                            lines.append(f"{source:<16} {topic:<9} {amount:>6}")
            except FileNotFoundError:
                pass
            return lines


        class JournalReader:
            """Read a journal a little at a time, remembering where it stopped."""

            def __init__(self, path):
                self.path = path
                self._position = 0

            def read_new(self):
                """Return the lines added since the last call, without newlines."""
                try:
                    with open(self.path, encoding="utf-8") as file:
                        file.seek(self._position)
                        lines = file.readlines()
                        self._position = file.tell()
                except FileNotFoundError:
                    return []
                return [line.rstrip("\n") for line in lines]
        ```

    === "main.py"

        ```python
        #!/usr/bin/env python3
        """Run the wallet: load, use and save it. Run it twice to see it remember."""
        from wallet import Customer, RoundUp, SpendingLimit, checkout
        from wallet.storage import (
            FileJournal, JournalReader, load_customers, save_customers, statement,
        )

        SNAPSHOT = "data/customers.json"
        JOURNAL = "data/journal.log"


        def main():
            """Load or create Ada, make a payment, close the month, and save."""
            customers = load_customers(SNAPSHOT)
            first_run = not customers
            if first_run:
                ada = Customer("Ada", "ada@example.com")
                ada.open_account("savings", rate=2)
                ada.open_account("checking", overdraft=500)
                customers = [ada]
            ada = customers[0]
            savings, checking = ada.accounts

            journal = FileJournal(JOURNAL)
            reader = JournalReader(JOURNAL)
            reader.read_new()
            for account in ada.accounts:
                account.subscribe(journal)

            if first_run:
                savings.deposit(1000)
            checking.deposit(500)
            payer = RoundUp(SpendingLimit(checking, limit=500), savings)
            checkout(payer, 230)
            ada.month_end()

            written = save_customers(customers, SNAPSHOT)
            for account in ada.accounts:
                print(account)
            print(f"Saved {len(customers)} customer, {written} characters")
            print(f"This run added {len(reader.read_new())} journal lines")
            print(f"Statement for {ada.name}:")
            print(*statement(JOURNAL, ada.name), sep="\n")


        if __name__ == "__main__":
            main()
        ```

    === "wallet/factory.py"

        ```python
        """Create accounts by kind, without naming their classes."""
        from .accounts import Account, CheckingAccount, SavingsAccount


        class AccountFactory:
            """Create accounts by kind, from a registry of account classes."""

            def __init__(self):
                self._registry = {}

            def register(self, kind, account_class):
                """Make kind create account_class, and return account_class."""
                if not isinstance(kind, str) or not kind.strip():
                    raise ValueError("kind must be a non-empty string")
                if not (isinstance(account_class, type)
                        and issubclass(account_class, Account)):
                    raise TypeError("account_class must be a subclass of Account")
                self._registry[kind] = account_class
                return account_class

            def create(self, kind, owner, **options):
                """Create an account of a registered kind."""
                if kind not in self._registry:
                    raise ValueError(f"unknown account kind: {kind!r}")
                return self._registry[kind](owner, **options)

            def kinds(self):
                """The registered kinds, sorted."""
                return sorted(self._registry)

            def kind_of(self, account):
                """Return the registered kind that creates this account's class."""
                for kind, account_class in self._registry.items():
                    if type(account) is account_class:
                        return kind
                raise ValueError(f"no registered kind for {type(account).__name__}")


        account_factory = AccountFactory()
        account_factory.register("savings", SavingsAccount)
        account_factory.register("checking", CheckingAccount)
        ```

    === "wallet/accounts.py"

        ```python
        """Accounts: the abstract base and its two kinds."""
        from abc import abstractmethod

        from .history import HistoryMixin
        from .mixins import JSONMixin, ObservableMixin
        from .payer import Payer
        from .validation import check_amount


        class Account(ObservableMixin, HistoryMixin, JSONMixin, Payer):
            """Abstract base for wallet accounts holding money, in whole lek."""

            currency = "ALL"

            def __init__(self, owner, balance=0):
                """Create an account for owner with an opening balance."""
                self.owner = owner
                if isinstance(balance, bool) or not isinstance(balance, int):
                    raise TypeError("balance must be an integer")
                if balance < 0:
                    raise ValueError("balance must not be negative")
                self._balance = balance
                if balance:
                    self._record("deposit", balance)

            @property
            def owner(self):
                """The account holder's name."""
                return self._owner

            @owner.setter
            def owner(self, value):
                if not isinstance(value, str):
                    raise TypeError("owner must be a string")
                if not value.strip():
                    raise ValueError("owner must not be empty")
                self._owner = value.strip()

            @property
            def balance(self):
                """The current balance. Read-only: use deposit and withdraw."""
                return self._balance

            def deposit(self, amount):
                """Add amount to the balance and return the new balance."""
                check_amount(amount)
                self._balance += amount
                self._record("deposit", amount)
                return self._balance

            def withdraw(self, amount):
                """Take amount from the balance and return the new balance."""
                check_amount(amount)
                if amount > self._balance:
                    raise ValueError("insufficient funds")
                self._balance -= amount
                self._record("withdraw", amount)
                return self._balance

            def pay(self, amount):
                """Pay amount from this account; return the new balance."""
                return self.withdraw(amount)

            def _restore_balance(self, balance):
                """Set a saved balance back, without recording a transaction."""
                if isinstance(balance, bool) or not isinstance(balance, int):
                    raise TypeError("balance must be an integer")
                self._balance = balance

            @abstractmethod
            def month_end(self):
                """Apply end-of-month rules and return the new balance."""

            def __str__(self):
                return f"{self.owner}: {self.balance} {self.currency}"

            def __repr__(self):
                return (f"{type(self).__name__}(owner={self.owner!r}, "
                        f"balance={self.balance})")


        class SavingsAccount(Account):
            """An account that earns interest every month."""

            def __init__(self, owner, balance=0, rate=1):
                """Create a savings account; rate is monthly interest in percent."""
                super().__init__(owner, balance)
                if isinstance(rate, bool) or not isinstance(rate, int):
                    raise TypeError("rate must be an integer")
                if not 0 <= rate <= 10:
                    raise ValueError("rate must be between 0 and 10")
                self._rate = rate

            @property
            def rate(self):
                """Monthly interest rate, in whole percent."""
                return self._rate

            def add_interest(self):
                """Add this month's interest and return the amount added."""
                interest = self._balance * self._rate // 100
                if interest > 0:
                    self._balance += interest
                    self._record("interest", interest)
                return interest

            def month_end(self):
                """Add this month's interest and return the new balance."""
                self.add_interest()
                return self._balance

            def __repr__(self):
                return (f"{type(self).__name__}(owner={self.owner!r}, "
                        f"balance={self.balance}, rate={self.rate})")


        class CheckingAccount(Account):
            """An everyday account that may go below zero, up to a limit."""

            fee = 100

            def __init__(self, owner, balance=0, overdraft=0):
                """Create a checking account with an overdraft limit."""
                super().__init__(owner, balance)
                if isinstance(overdraft, bool) or not isinstance(overdraft, int):
                    raise TypeError("overdraft must be an integer")
                if overdraft < 0:
                    raise ValueError("overdraft must not be negative")
                self._overdraft = overdraft

            @property
            def overdraft(self):
                """How far below zero the balance may go."""
                return self._overdraft

            def withdraw(self, amount):
                """Take amount out, letting the balance go down to -overdraft."""
                check_amount(amount)
                if self._balance - amount < -self._overdraft:
                    raise ValueError("overdraft limit exceeded")
                self._balance -= amount
                self._record("withdraw", amount)
                return self._balance

            def month_end(self):
                """Charge the monthly fee if overdrawn; return the new balance."""
                if self._balance < 0:
                    self._balance -= self.fee
                    self._record("fee", self.fee)
                return self._balance

            def __str__(self):
                return f"{super().__str__()} (overdraft {self.overdraft})"

            def __repr__(self):
                return (f"{type(self).__name__}(owner={self.owner!r}, "
                        f"balance={self.balance}, overdraft={self.overdraft})")
        ```

!!! ai "AI in the loop"

    Files are where small mistakes destroy data. Before you run file code
    from an assistant, read every `open()` call and ask yourself which
    mode it uses and what that mode does to an existing file. A single
    `"w"` where `"a"` was meant wipes your journal. You can also ask the
    assistant directly: *"What happens to my data if this program
    crashes on each line of this function?"* That question is the start
    of database thinking.

## When something goes wrong

??? note "`FileNotFoundError: [Errno 2] No such file or directory`"

    The path is relative to the folder you ran the program from. Run
    `pwd` to check, and run `main.py` from the root of the repository.
    When writing, the folder must exist too: create it first, as
    `_ensure_folder` does.

??? note "My file is empty after I ran the program"

    Either it was opened with `"w"`, which empties it immediately, or it
    was never closed, so the text stayed in the buffer. Use `"a"` to add
    to a file, and always open files with `with`.

??? note "`io.UnsupportedOperation: not writable`"

    The file was opened for reading, the default mode. Pass `"w"` or
    `"a"` to write.

??? note "`ValueError: I/O operation on closed file.`"

    You used the file object after the `with` block ended. Move the code
    that reads or writes inside the block.

??? note "`OSError: telling position disabled by next() call`"

    `tell()` was called while looping over the file with `for`. Read with
    `readline()` or `readlines()` instead.

??? note "Every line in my output is followed by an empty line"

    Each line read from a file keeps its `"\n"`, and `print` adds
    another. Strip it first: `print(line.rstrip("\n"))`.

## Explain it to someone

- [ ] How to open a file, and what the path, the mode and the encoding each control
- [ ] What `"r"`, `"w"` and `"a"` do to a file that already exists
- [ ] How to write text to a file, and why you add `"\n"` yourself
- [ ] How to read the full content of a file
- [ ] How to read a file line by line, and why that suits large files
- [ ] What the cursor is, and how `tell()` and `seek()` move it
- [ ] Why a file must be closed, and what can go wrong if it is not
- [ ] What the `with` statement does, and why it is safer than calling `close()`
- [ ] Why the wallet uses a snapshot and a journal, and which mode each needs
- [ ] Where plain files stop being enough

## Quick reference

| Code | What it does |
|---|---|
| `with open(path, mode, encoding="utf-8") as f:` | Open a file, and close it at the end of the block |
| `"r"`, `"w"`, `"a"`, `"x"` | Read, write (empties it), append, create new |
| `f.write(text)` | Write a string at the cursor; returns characters written |
| `print(..., file=f)` | Write with spaces and a newline added |
| `f.read()` / `f.read(n)` | Read everything / the next `n` characters |
| `for line in f:` | Read line by line |
| `f.readline()` / `f.readlines()` | One line / all lines as a list |
| `f.tell()` / `f.seek(pos)` | Where the cursor is / move it |
| `json.dumps(data)` / `json.loads(text)` | Data to a JSON string / back again |
| `os.makedirs(folder, exist_ok=True)` | Create a folder if it is missing |

## Next

The wallet remembers, and you have seen exactly where files fall short.
Next you move its data into a database, starting with tables, and how to
create, read, update and delete rows in them.

[Data & APIs](index.md){ .h-button }
