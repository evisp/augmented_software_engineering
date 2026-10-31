# File Handling

<span class="badge badge--time">75 min</span>
<span class="badge badge--level">Data & APIs</span>
<span class="badge">Needs: Exception Handling</span>

Every program you have written so far forgets everything the moment it
stops. A **file** is the simplest way to keep data: write it once, read
it back tomorrow. In this tutorial you open, write, read and close text
files, and save structured data as **JSON**, all on a small library's
book list.

## Why this matters

Almost every program touches files: settings, logs, exports, data
someone else produced. And JSON is how programs pass data to each other:
the configuration of a tool, the answer from a web API, the body of a
request. Once you can read and write it, a whole world of data opens
up.

## Before you start

You need Python 3 in your WSL terminal and VS Code, as set up in
[Environment & First Programs](../../02-foundations/python/environment.md).
Create a practice folder and download the two files this tutorial uses:

```bash
mkdir -p ~/library && cd ~/library
curl -O https://evisp.github.io/augmented_software_engineering/assets/files/books.txt
curl -O https://evisp.github.io/augmented_software_engineering/assets/files/catalog.json
ls
```

You can also download them from the browser:
[books.txt](../../assets/files/books.txt){ download="books.txt" } and
[catalog.json](../../assets/files/catalog.json){ download="catalog.json" }.

`books.txt` lists ten books, one per line, with the title, author and
year separated by semicolons:

```text title="books.txt"
Kronikë në gur;Ismail Kadare;1971
Gjenerali i ushtrisë së vdekur;Ismail Kadare;1963
The Little Prince;Antoine de Saint-Exupéry;1943
Nineteen Eighty-Four;George Orwell;1949
Things Fall Apart;Chinua Achebe;1958
Pride and Prejudice;Jane Austen;1813
Dune;Frank Herbert;1965
The Hobbit;J. R. R. Tolkien;1937
Don Quixote;Miguel de Cervantes;1605
One Hundred Years of Solitude;Gabriel García Márquez;1967
```

Create every script in this tutorial inside `~/library`, and run it
from there with `python3 name.py`. You will see why that matters in the
first step. If you mess up a file, download it again.

## Step 1: Files and paths

A **file** is a named piece of data on disk. A **text file**, like
`books.txt`, holds characters. On disk, each character is stored as one
or more bytes, and the rule that maps characters to bytes is the
**encoding**. The modern standard is **UTF-8**, which can store any
character: `ë`, `é`, `ç`, Chinese, emoji.

To open a file, Python needs its **path**, the directions to it:

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 232" role="img" aria-labelledby="fh-path-title fh-path-desc">
<title id="fh-path-title">Absolute and relative paths</title>
<desc id="fh-path-desc">A folder tree: the root folder contains home, which contains ada, which contains library, which holds books.txt and where.py. The absolute path /home/ada/library/books.txt starts at the root. The terminal is in the library folder, so the relative path books.txt starts there.</desc>
<g stroke="var(--h-fig-line)" stroke-width="1.6" fill="none">
<path d="M18 46 V72 H40"/>
<path d="M58 82 V108 H80"/>
<path d="M98 118 V144 H120"/>
<path d="M138 154 V180 H160 M138 180 V212 H160"/>
</g>
<g font-size="12.5" font-family="var(--md-code-font-family, monospace)">
<rect x="3" y="18" width="36" height="28" rx="6" fill="var(--h-fig-box)" stroke="var(--h-fig-text)"/><text x="21" y="37" text-anchor="middle" fill="var(--h-fig-text)" font-weight="700">/</text>
<rect x="42" y="58" width="56" height="28" rx="6" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="70" y="77" text-anchor="middle" fill="var(--h-fig-text)">home</text>
<rect x="82" y="94" width="56" height="28" rx="6" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="110" y="113" text-anchor="middle" fill="var(--h-fig-text)">ada</text>
<rect x="122" y="130" width="76" height="28" rx="6" fill="var(--h-cherry)"/><text x="160" y="149" text-anchor="middle" fill="#ffffff" font-weight="700">library</text>
<rect x="162" y="166" width="96" height="28" rx="6" fill="var(--h-fig-box)" stroke="var(--h-cherry)" stroke-width="2"/><text x="210" y="185" text-anchor="middle" fill="var(--h-fig-text)" font-weight="700">books.txt</text>
<rect x="162" y="198" width="96" height="28" rx="6" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="210" y="217" text-anchor="middle" fill="var(--h-fig-text)">where.py</text>
</g>
<text x="210" y="149" font-size="11" font-weight="700" fill="var(--h-cherry)">◀ the terminal is here</text>
<g font-size="11" font-weight="700" fill="var(--h-fig-muted)">
<text x="330" y="30">ABSOLUTE PATH · starts at the root, /</text>
<text x="330" y="132">RELATIVE PATH · starts at the current folder</text>
</g>
<g font-family="var(--md-code-font-family, monospace)" font-size="13.5" font-weight="700">
<rect x="330" y="40" width="346" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-text)"/>
<text x="344" y="62" fill="var(--h-fig-text)">/home/ada/library/books.txt</text>
<rect x="330" y="142" width="346" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-cherry)" stroke-width="2"/>
<text x="344" y="164" fill="var(--h-cherry)">books.txt</text>
</g>
<g font-size="11.5" fill="var(--h-fig-muted)">
<text x="330" y="94">Works from anywhere, but only on this computer.</text>
<text x="330" y="196">Short, but only correct from ~/library.</text>
<text x="330" y="214">Run from elsewhere: FileNotFoundError.</text>
</g>
</svg>
</figure>

- An **absolute path** starts at the root, `/`, and works from anywhere.
- A **relative path**, like `books.txt`, is looked up from the **current
  working directory**: the folder your terminal is in when you run
  `python3`. Not the folder the script is in.

Python tells you the current working directory:

```python title="where.py"
import os

print(os.getcwd())
```

```bash
python3 where.py
```

```text
/home/ada/library
```

These examples run as a user called `ada`; your folder will show your
own user name.

!!! tip "Try it"

    From `~/library`, run `cd ..` and then `python3 library/where.py`.
    What does it print, and would `open("books.txt")` still work?

??? success "Answer"

    It prints `/home/ada`, the folder the terminal is in, even though the
    script is in `library`. A relative `books.txt` would now be looked up
    in `/home/ada`, and fail with `FileNotFoundError`. Run your scripts
    from the folder that holds the files.

## Step 2: Open and close a file

`open()` connects your program to a file and returns a **file object**.
You read and write through that object, then **close** it:

```python title="first_open.py"
file = open("books.txt", "r", encoding="utf-8")
print(file)
print(file.read(25))
file.close()
print(file.closed)
```

```text
<_io.TextIOWrapper name='books.txt' mode='r' encoding='utf-8'>
Kronikë në gur;Ismail Kad
True
```

`open()` takes three things:

- the **path**, here `"books.txt"`;
- the **mode**, `"r"` for read. It is the default, so you can leave it
  out, as later examples do;
- the **encoding**, here `"utf-8"`.

`file.read(25)` read the first 25 characters, and after `close()`,
`file.closed` is `True`.

**Always pass `encoding="utf-8"`.** Without it, Python uses your system's
default, which differs between computers. With the wrong encoding,
`books.txt` cannot even be read, because of the `ë` in the very first
title:

```python title="wrong_encoding.py"
file = open("books.txt", encoding="ascii")
print(file.read())
file.close()
```

```text
UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 in position 6: ordinal not in range(128)
```

!!! tip "Try it"

    Open `catalog.json` and print its first 40 characters.

??? success "Answer"

    ```python title="try_open.py"
    file = open("catalog.json", encoding="utf-8")
    print(file.read(40))
    file.close()
    ```

    ```text
    [
      {
        "title": "Kronikë në gur",
       
    ```

## Step 3: Choose a mode

The mode decides what `open()` does to the file, and it matters most
when the file already exists:

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 220" role="img" aria-labelledby="fh-mode-title fh-mode-desc">
<title id="fh-mode-title">What r, w and a do to a file that exists</title>
<desc id="fh-mode-desc">The file holds two lines, Dune and The Hobbit. Opened with r, the content stays and the cursor is at the start, ready to read. Opened with w, the file is emptied immediately. Opened with a, the content stays and the cursor is at the end, so new text is added after it.</desc>
<g font-size="12.5" font-weight="700" text-anchor="middle" font-family="var(--md-code-font-family, monospace)">
<text x="108" y="18" fill="var(--h-fig-text)">open(path, "r")</text>
<text x="340" y="18" fill="var(--h-cherry)">open(path, "w")</text>
<text x="572" y="18" fill="var(--h-fig-text)">open(path, "a")</text>
</g>
<g font-size="11" fill="var(--h-fig-muted)" font-weight="700">
<text x="3" y="42">BEFORE</text><text x="235" y="42">BEFORE</text><text x="467" y="42">BEFORE</text>
<text x="3" y="132">AFTER OPENING</text><text x="235" y="132">AFTER OPENING</text><text x="467" y="132">AFTER OPENING</text>
</g>
<g font-size="12.5" font-family="var(--md-code-font-family, monospace)" fill="var(--h-fig-text)">
<rect x="3" y="50" width="210" height="52" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="18" y="71">Dune</text><text x="18" y="91">The Hobbit</text>
<rect x="235" y="50" width="210" height="52" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="250" y="71">Dune</text><text x="250" y="91">The Hobbit</text>
<rect x="467" y="50" width="210" height="52" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="482" y="71">Dune</text><text x="482" y="91">The Hobbit</text>
<rect x="3" y="140" width="210" height="52" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/><text x="18" y="161">Dune</text><text x="18" y="181">The Hobbit</text>
<rect x="235" y="140" width="210" height="52" rx="8" fill="var(--h-fig-box)" stroke="var(--h-cherry)" stroke-width="2.5" stroke-dasharray="6 4"/>
<rect x="467" y="140" width="210" height="52" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/><text x="482" y="161">Dune</text><text x="482" y="181">The Hobbit</text>
</g>
<g stroke="var(--h-cherry)" stroke-width="2.5">
<line x1="15" y1="148" x2="15" y2="166"/>
<line x1="249" y1="148" x2="249" y2="166"/>
<line x1="563" y1="173" x2="563" y2="187"/>
</g>
<text x="340" y="172" text-anchor="middle" font-size="12" font-weight="700" fill="var(--h-cherry)">emptied at once</text>
<g font-size="11.5" fill="var(--h-fig-muted)" text-anchor="middle">
<text x="108" y="212">unchanged · cursor at the start</text>
<text x="340" y="212">content gone · cursor at the start</text>
<text x="572" y="212">unchanged · cursor at the end</text>
</g>
<g stroke="var(--h-fig-line)" stroke-width="1.6"><line x1="108" y1="104" x2="108" y2="136"/><line x1="340" y1="104" x2="340" y2="136"/><line x1="572" y1="104" x2="572" y2="136"/></g>
</svg>
</figure>

| Mode | Meaning | File exists | File missing |
|---|---|---|---|
| `"r"` | read | reads from the start | `FileNotFoundError` |
| `"w"` | write | **empties it first**, then writes | creates it |
| `"a"` | append | keeps it, writes at the end | creates it |
| `"x"` | create | `FileExistsError` | creates it |

The red bar in the diagram is the **cursor**: the position where the
next read or write happens. Step 7 is about it.

!!! danger "`"w"` empties the file when it opens, not when it writes"

    Opening a file with `"w"` deletes its content immediately, even if
    you never write anything:

    ```python title="w_empties.py"
    file = open("scratch.txt", "w", encoding="utf-8")
    file.write("first version\n")
    file.close()

    file = open("scratch.txt", "w", encoding="utf-8")
    file.close()

    file = open("scratch.txt", encoding="utf-8")
    print(repr(file.read()))
    file.close()
    ```

    ```text
    ''
    ```

    When you want to add to a file, use `"a"`. When you must not
    overwrite an existing file, use `"x"`, which refuses.

## Step 4: Write text

`write()` writes a string and returns how many characters it wrote. It
does **not** start a new line: you add `"\n"`, the newline character,
yourself.

```python title="write_list.py"
file = open("reading-list.txt", "w", encoding="utf-8")
file.write("Dune\n")
file.write("The Hobbit\n")
count = file.write("Kronikë në gur\n")
file.close()
print(count)
```

```text
15
```

`Kronikë në gur` is 14 characters, plus the newline: 15. Look at the
result from the terminal:

```bash
cat reading-list.txt
```

```text
Dune
The Hobbit
Kronikë në gur
```

Now add a book with mode `"a"`:

```python title="append_list.py"
file = open("reading-list.txt", "a", encoding="utf-8")
file.write("Don Quixote\n")
file.close()
```

Run it **twice**, then look again:

```text
Dune
The Hobbit
Kronikë në gur
Don Quixote
Don Quixote
```

Append never removes anything: each run adds one more line. That is
what you want for a log, and a surprise if you expected a single copy.

Forget the `"\n"`, and the lines run together:

```python title="no_newline.py"
file = open("squashed.txt", "w", encoding="utf-8")
file.write("Dune")
file.write("The Hobbit")
file.close()
```

```text
DuneThe Hobbit
```

`print()` can also write to a file, with `file=`. It adds the newline
for you:

```python title="print_file.py"
file = open("shortlist.txt", "w", encoding="utf-8")
print("Dune", file=file)
print("The Hobbit", file=file)
file.close()
```

!!! tip "Try it"

    Write a function `add_title(path, title)` that adds one title to the
    end of a list file, on its own line. Call it twice to start a
    `wishlist.txt`.

??? success "Answer"

    ```python title="add_title.py"
    def add_title(path, title):
        """Add one title to the end of a list file, on its own line."""
        file = open(path, "a", encoding="utf-8")
        file.write(title + "\n")
        file.close()


    add_title("wishlist.txt", "Things Fall Apart")
    add_title("wishlist.txt", "Pride and Prejudice")
    ```

    ```bash
    cat wishlist.txt
    ```

    ```text
    Things Fall Apart
    Pride and Prejudice
    ```

## Step 5: Read a file

Python gives you four ways to read text:

| Call | Returns |
|---|---|
| `file.read()` | the whole file, as one string |
| `file.readline()` | the next line, as a string, `"\n"` included |
| `file.readlines()` | all the lines, as a list of strings |
| `for line in file:` | one line at a time, in a loop |

Every line you read ends with the newline character, `"\n"`.
`repr()` shows it:

```python title="read_line.py"
file = open("books.txt", encoding="utf-8")
first = file.readline()
print(repr(first))
file.close()
```

```text
'Kronikë në gur;Ismail Kadare;1971\n'
```

That is why you usually remove it with `rstrip("\n")` before using the
line. Then `split(";")` cuts the line into its three parts. Every book
from before 1900:

```python title="old_books.py"
file = open("books.txt", encoding="utf-8")
for line in file:
    title, author, year = line.rstrip("\n").split(";")
    if int(year) < 1900:
        print(f"{title} ({year}), {author}")
file.close()
```

```text
Pride and Prejudice (1813), Jane Austen
Don Quixote (1605), Miguel de Cervantes
```

`readlines()` and `read()` load the whole file at once, which is fine
for small files:

```python title="read_all.py"
file = open("books.txt", encoding="utf-8")
lines = file.readlines()
file.close()
print(len(lines))
print(repr(lines[-1]))

file = open("books.txt", encoding="utf-8")
text = file.read()
file.close()
print(text.count("Kadare"))
```

```text
10
'One Hundred Years of Solitude;Gabriel García Márquez;1967\n'
2
```

The loop, `for line in file:`, reads **one line at a time** and never
holds the whole file in memory. Prefer it: it works the same on a file
of ten lines and on one of ten million.

!!! tip "Try it"

    Find the oldest book in `books.txt` and print its title and year.

??? success "Answer"

    ```python title="oldest.py"
    oldest_title = None
    oldest_year = None

    file = open("books.txt", encoding="utf-8")
    for line in file:
        title, author, year = line.rstrip("\n").split(";")
        if oldest_year is None or int(year) < oldest_year:
            oldest_title, oldest_year = title, int(year)
    file.close()

    print(f"Oldest: {oldest_title} ({oldest_year})")
    ```

    ```text
    Oldest: Don Quixote (1605)
    ```

## Step 6: Close files with `with`

Closing a file is not a formality. Python **buffers** what you write: it
collects it in memory and saves it to disk in batches, and the last batch
is only saved when the file is closed. Until then, other programs, or
even your own, may see nothing:

```python title="buffer_demo.py"
writer = open("buffer-demo.txt", "w", encoding="utf-8")
writer.write("not saved yet\n")

reader = open("buffer-demo.txt", encoding="utf-8")
print(repr(reader.read()))

writer.close()
print(repr(reader.read()))
reader.close()
```

```text
''
'not saved yet\n'
```

The second `open()` read an empty file. Only after `writer.close()` was
the text really on disk.

The danger is an error between `open()` and `close()`: the `close()`
never runs. The **`with` statement** solves it. It closes the file when
the block ends, **whatever happens inside**:

```python title="with_read.py"
with open("reading-list.txt", encoding="utf-8") as file:
    print(file.read(), end="")

print(file.closed)
```

```text
Dune
The Hobbit
Kronikë në gur
Don Quixote
Don Quixote
True
```

Even when an exception interrupts the block, the file is closed:

```python title="with_error.py"
try:
    with open("reading-list.txt", encoding="utf-8") as file:
        for line in file:
            year = int(line)
except ValueError as error:
    print("Error:", error)

print(file.closed)
```

```text
Error: invalid literal for int() with base 10: 'Dune\n'
True
```

From here on, every example uses `with`. One `with` can open several
files. This one copies just the titles from `books.txt` into a new file:

```python title="titles_only.py"
with open("books.txt", encoding="utf-8") as source, \
        open("titles.txt", "w", encoding="utf-8") as target:
    for line in source:
        title = line.split(";")[0]
        target.write(title + "\n")
```

```bash
head -n 4 titles.txt
```

```text
Kronikë në gur
Gjenerali i ushtrisë së vdekur
The Little Prince
Nineteen Eighty-Four
```

!!! tip "Try it"

    Rewrite `add_title` from Step 4 with `with`.

??? success "Answer"

    ```python title="add_title_with.py"
    def add_title(path, title):
        """Add one title to the end of a list file, on its own line."""
        with open(path, "a", encoding="utf-8") as file:
            file.write(title + "\n")


    add_title("wishlist.txt", "Dune")
    ```

    ```text
    Things Fall Apart
    Pride and Prejudice
    Dune
    ```

## Step 7: Move the cursor

An open file remembers a **cursor**: the position of the next read or
write. Each read moves it forward. `tell()` reports where it is, and
`seek()` moves it.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 150" role="img" aria-labelledby="fh-cur-title fh-cur-desc">
<title id="fh-cur-title">The cursor moves forward as you read</title>
<desc id="fh-cur-desc">The file starts with the characters D, u, n, e, a newline, then The Hobbit and another newline. The cursor starts at position 0. After readline the cursor is at position 5, at the start of the second line. seek(0) moves it back to the start.</desc>
<defs><marker id="fh-cur-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-cherry)"/></marker></defs>
<g font-size="14" font-family="var(--md-code-font-family, monospace)" text-anchor="middle">
<g fill="var(--h-fig-box)" stroke="var(--h-fig-line)">
<rect x="56" y="40" width="36" height="36"/><rect x="92" y="40" width="36" height="36"/><rect x="128" y="40" width="36" height="36"/><rect x="164" y="40" width="36" height="36"/><rect x="200" y="40" width="36" height="36"/>
<rect x="236" y="40" width="36" height="36"/><rect x="272" y="40" width="36" height="36"/><rect x="308" y="40" width="36" height="36"/><rect x="344" y="40" width="36" height="36"/><rect x="380" y="40" width="36" height="36"/><rect x="416" y="40" width="36" height="36"/><rect x="452" y="40" width="36" height="36"/><rect x="488" y="40" width="36" height="36"/><rect x="524" y="40" width="36" height="36"/><rect x="560" y="40" width="36" height="36"/><rect x="596" y="40" width="36" height="36"/>
</g>
<g fill="var(--h-fig-text)">
<text x="74" y="63">D</text><text x="110" y="63">u</text><text x="146" y="63">n</text><text x="182" y="63">e</text>
<text x="254" y="63">T</text><text x="290" y="63">h</text><text x="326" y="63">e</text><text x="362" y="63"> </text><text x="398" y="63">H</text><text x="434" y="63">o</text><text x="470" y="63">b</text><text x="506" y="63">b</text><text x="542" y="63">i</text><text x="578" y="63">t</text>
</g>
<g fill="var(--h-cherry)" font-weight="700" font-size="13"><text x="218" y="63">\n</text><text x="614" y="63">\n</text></g>
</g>
<g font-size="11" fill="var(--h-fig-muted)" text-anchor="middle" font-family="var(--md-code-font-family, monospace)">
<text x="56" y="30">0</text><text x="236" y="30">5</text><text x="632" y="30">16</text>
</g>
<g stroke="var(--h-cherry)" stroke-width="3"><line x1="56" y1="36" x2="56" y2="82"/><line x1="236" y1="36" x2="236" y2="82"/></g>
<g font-size="11.5" font-weight="700" fill="var(--h-cherry)" font-family="var(--md-code-font-family, monospace)">
<text x="56" y="100" text-anchor="middle">tell() → 0</text>
<text x="236" y="100" text-anchor="middle">after readline(): tell() → 5</text>
</g>
<path d="M230 112 C 190 140, 100 140, 62 112" fill="none" stroke="var(--h-cherry)" stroke-width="2" stroke-dasharray="5 4" marker-end="url(#fh-cur-arrow)"/>
<text x="146" y="146" text-anchor="middle" font-size="11.5" font-weight="700" fill="var(--h-cherry)" font-family="var(--md-code-font-family, monospace)">seek(0)</text>
</svg>
</figure>

```python title="cursor.py"
with open("reading-list.txt", encoding="utf-8") as file:
    print(file.tell())
    print(repr(file.readline()))
    print(file.tell())
    print(repr(file.read()))
    print(repr(file.read()))
    file.seek(0)
    print(repr(file.readline()))
```

```text
0
'Dune\n'
5
'The Hobbit\nKronikë në gur\nDon Quixote\nDon Quixote\n'
''
'Dune\n'
```

Notice the last `read()` returned `''`: the cursor was already at the
end, so there was nothing left. That is the classic "my second read is
empty" bug. `seek(0)` goes back to the start.

!!! note "Positions in text files"

    In a text file, `tell()` counts **bytes**, not characters, and `ë`
    takes two bytes in UTF-8. So with text files, only `seek()` to `0`
    or to a number that `tell()` gave you earlier.

!!! tip "Try it"

    In a single `with` block, count the lines of `books.txt`, then go
    back and read the first line again.

??? success "Answer"

    ```python title="twice.py"
    with open("books.txt", encoding="utf-8") as file:
        count = len(file.readlines())
        file.seek(0)
        first = file.readline().rstrip("\n")

    print(count, "books")
    print("First:", first)
    ```

    ```text
    10 books
    First: Kronikë në gur;Ismail Kadare;1971
    ```

## Step 8: Handle missing files

Opening a file can fail, and the error says why:

| Exception | Cause |
|---|---|
| `FileNotFoundError` | No file at that path, in mode `"r"` |
| `PermissionError` | The file's [permissions](../../01-tools/shell-permissions.md) do not allow it |
| `IsADirectoryError` | The path is a folder, not a file |
| `FileExistsError` | The file exists, in mode `"x"` |

Catch the one you expect with `try` and `except`, as in
[Exception Handling](../../02-foundations/python/exceptions.md). A
missing list is often just an empty list:

```python title="missing.py"
def read_titles(path):
    """Return the lines of a list file, or an empty list if it is missing."""
    try:
        with open(path, encoding="utf-8") as file:
            return [line.rstrip("\n") for line in file]
    except FileNotFoundError:
        print(f"No file called {path}, starting with an empty list")
        return []


print(read_titles("reading-list.txt"))
print(read_titles("favourites.txt"))
```

```text
['Dune', 'The Hobbit', 'Kronikë në gur', 'Don Quixote', 'Don Quixote']
No file called favourites.txt, starting with an empty list
[]
```

And a file with no read permission:

```bash
echo "secret" > locked.txt
chmod 000 locked.txt
python3 -c 'open("locked.txt", encoding="utf-8")'
```

```text
PermissionError: [Errno 13] Permission denied: 'locked.txt'
```

!!! tip "Try it"

    What happens with `open("~/library/books.txt", encoding="utf-8")`?
    The file is right there.

??? success "Answer"

    ```python title="tilde.py"
    file = open("~/library/books.txt", encoding="utf-8")
    ```

    ```text
    FileNotFoundError: [Errno 2] No such file or directory: '~/library/books.txt'
    ```

    `~` is a shortcut that the **shell** understands, not Python. Python
    looks for a folder literally called `~`. Expand it first:

    ```python title="tilde_fix.py"
    import os

    path = os.path.expanduser("~/library/books.txt")
    print(path)
    with open(path, encoding="utf-8") as file:
        print(file.readline(), end="")
    ```

    ```text
    /home/ada/library/books.txt
    Kronikë në gur;Ismail Kadare;1971
    ```

## Step 9: Save data as JSON

Lines of text suit a simple list. But a catalog has structure: each
book has a title, a year that is a number, a yes-or-no `available`, and
a list of tags. For that, use **JSON**, a text format for data. Here is
the start of `catalog.json`:

```json title="catalog.json"
[
  {
    "title": "Kronikë në gur",
    "author": "Ismail Kadare",
    "year": 1971,
    "available": true,
    "tags": ["albanian", "novel"]
  },
  {
    "title": "The Little Prince",
    "author": "Antoine de Saint-Exupéry",
    "year": 1943,
    "available": false,
    "tags": ["classic", "children"]
  },
  ...
```

JSON looks like Python, with a few differences:

| Python | JSON |
|---|---|
| `dict` | object `{...}`, keys always strings in **double** quotes |
| `list`, `tuple` | array `[...]` |
| `str` | string, in double quotes |
| `int`, `float` | number |
| `True`, `False` | `true`, `false` |
| `None` | `null` |

Turning data into text like this is called **serialisation**; turning
the text back into data is **deserialisation**. The `json` module does
both, with four functions:

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 186" role="img" aria-labelledby="fh-json-title fh-json-desc">
<title id="fh-json-title">The four json functions</title>
<desc id="fh-json-desc">Python data, such as a list of dictionaries, becomes a JSON string with json.dumps, and comes back with json.loads. json.dump writes Python data straight into an open file, and json.load reads it back from the file. Going towards text is serialisation; coming back is deserialisation.</desc>
<defs><marker id="fh-json-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-cherry)"/></marker>
<marker id="fh-json-arrow2" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-text)"/></marker></defs>
<g font-size="11" font-weight="700" fill="var(--h-fig-muted)" text-anchor="middle">
<text x="93" y="14">PYTHON DATA</text><text x="340" y="14">JSON TEXT</text><text x="587" y="14">FILE ON DISK</text>
</g>
<rect x="3" y="22" width="180" height="62" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<rect x="250" y="22" width="180" height="62" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<rect x="497" y="22" width="180" height="62" rx="10" fill="var(--h-cherry)"/>
<g font-size="12" font-family="var(--md-code-font-family, monospace)" text-anchor="middle">
<text x="93" y="49" fill="var(--h-fig-text)">{"year": 1965,</text><text x="93" y="67" fill="var(--h-fig-text)"> "available": True}</text>
<text x="340" y="49" fill="var(--h-fig-text)">'{"year": 1965,</text><text x="340" y="67" fill="var(--h-fig-text)"> "available": true}'</text>
<text x="587" y="58" fill="#ffffff" font-weight="700">catalog.json</text>
</g>
<g font-size="12" font-weight="700" font-family="var(--md-code-font-family, monospace)">
<line x1="187" y1="40" x2="244" y2="40" stroke="var(--h-cherry)" stroke-width="2.2" marker-end="url(#fh-json-arrow)"/>
<text x="216" y="34" text-anchor="middle" fill="var(--h-cherry)" font-size="11">dumps</text>
<line x1="246" y1="68" x2="189" y2="68" stroke="var(--h-fig-text)" stroke-width="2.2" marker-end="url(#fh-json-arrow2)"/>
<text x="216" y="82" text-anchor="middle" fill="var(--h-fig-text)" font-size="11">loads</text>
<path d="M120 88 V118 Q120 128 130 128 H550 Q560 128 560 118 V92" fill="none" stroke="var(--h-cherry)" stroke-width="2.2" marker-end="url(#fh-json-arrow)"/>
<text x="340" y="121" text-anchor="middle" fill="var(--h-cherry)">serialise: json.dump(data, file)</text>
<path d="M640 88 V146 Q640 156 630 156 H60 Q50 156 50 146 V92" fill="none" stroke="var(--h-fig-text)" stroke-width="2.2" marker-end="url(#fh-json-arrow2)"/>
<text x="345" y="176" text-anchor="middle" fill="var(--h-fig-text)">deserialise: data = json.load(file)</text>
</g>
</svg>
</figure>

The `s` stands for **string**: `dumps` and `loads` work with strings,
`dump` and `load` work with files.

```python title="json_text.py"
import json

book = {
    "title": "Dune",
    "author": "Frank Herbert",
    "year": 1965,
    "available": True,
    "tags": ["sci-fi"],
    "borrower": None,
}

text = json.dumps(book)
print(text)
print(type(text).__name__)

back = json.loads(text)
print(back == book)
```

```text
{"title": "Dune", "author": "Frank Herbert", "year": 1965, "available": true, "tags": ["sci-fi"], "borrower": null}
str
True
```

Notice the changes in the text: `True` became `true`, `None` became
`null`, and everything is in double quotes. `loads` turned it back into
an equal dictionary.

Reading a JSON file gives you ordinary Python lists and dictionaries:

```python title="load_catalog.py"
import json

with open("catalog.json", encoding="utf-8") as file:
    catalog = json.load(file)

print(type(catalog).__name__, len(catalog))
print(catalog[0]["title"], catalog[0]["tags"])

for book in catalog:
    if book["available"]:
        print("-", book["title"])
```

```text
list 6
Kronikë në gur ['albanian', 'novel']
- Kronikë në gur
- Nineteen Eighty-Four
- Pride and Prejudice
- The Hobbit
```

To save, change the data and `dump` it back. `indent=2` makes the file
readable for people, and `ensure_ascii=False` keeps letters such as `ë`
as they are:

```python title="save_catalog.py"
import json

with open("catalog.json", encoding="utf-8") as file:
    catalog = json.load(file)

catalog.append({
    "title": "Things Fall Apart",
    "author": "Chinua Achebe",
    "year": 1958,
    "available": True,
    "tags": ["classic", "novel"],
})

with open("catalog.json", "w", encoding="utf-8") as file:
    json.dump(catalog, file, indent=2, ensure_ascii=False)

print(len(catalog), "books saved")
```

```text
7 books saved
```

```bash
tail -n 9 catalog.json
```

```text
    "author": "Chinua Achebe",
    "year": 1958,
    "available": true,
    "tags": [
      "classic",
      "novel"
    ]
  }
]
```

Without `ensure_ascii=False`, JSON escapes every non-English letter.
Still valid, but hard to read:

```python title="ascii.py"
import json

print(json.dumps("Kronikë në gur"))
print(json.dumps("Kronikë në gur", ensure_ascii=False))
```

```text
"Kronik\u00eb n\u00eb gur"
"Kronikë në gur"
```

JSON cannot store everything Python can. Keys become strings, tuples
come back as lists, sets are refused, and text that is not valid JSON
cannot be loaded:

```python title="json_limits.py"
import json

print(json.loads(json.dumps({1: "one"})))
print(json.loads(json.dumps(("Dune", 1965))))

try:
    json.dumps({"Dune", "The Hobbit"})
except TypeError as error:
    print("TypeError:", error)

try:
    json.loads("{'title': 'Dune'}")
except json.JSONDecodeError as error:
    print("JSONDecodeError:", error)
```

```text
{'1': 'one'}
['Dune', 1965]
TypeError: Object of type set is not JSON serializable
JSONDecodeError: Expecting property name enclosed in double quotes: line 1 column 2 (char 1)
```

The last one is the most common JSON mistake: **single quotes** are
not JSON.

!!! tip "Try it"

    Load `catalog.json` and list the titles of the books tagged
    `"classic"`.

??? success "Answer"

    ```python title="count_tag.py"
    import json

    with open("catalog.json", encoding="utf-8") as file:
        catalog = json.load(file)

    classics = [book["title"] for book in catalog if "classic" in book["tags"]]
    print(len(classics), classics)
    ```

    ```text
    4 ['The Little Prince', 'Nineteen Eighty-Four', 'Pride and Prejudice', 'Things Fall Apart']
    ```

## Step 10: Save objects as JSON

In Object-Oriented Design you modelled data with
[classes](../../02-foundations/oop/classes.md). A library would have a
`Book` class. But `json` only knows dictionaries, lists, strings,
numbers, booleans and `None`. An object of your own class is refused:

```python title="not_serializable.py"
import json


class Book:
    """A book in the library catalog."""

    def __init__(self, title, year):
        self.title = title
        self.year = year


dune = Book("Dune", 1965)
try:
    json.dumps(dune)
except TypeError as error:
    print("TypeError:", error)
```

```text
TypeError: Object of type Book is not JSON serializable
```

The usual solution: give the class two methods that translate between
an object and a dictionary. `to_dict()` turns the object into a
dictionary that `json` can save, and the class method `from_dict()`
builds an object back from a loaded dictionary. Then two small
functions save and load a whole list of books:

```python title="book.py"
"""A Book class that can be saved to and loaded from JSON."""
import json


class Book:
    """A book in the library catalog."""

    def __init__(self, title, author, year, available=True):
        self.title = title
        self.author = author
        self.year = year
        self.available = available

    def __repr__(self):
        state = "in" if self.available else "out"
        return f"Book({self.title!r}, {self.year}, {state})"

    def to_dict(self):
        """Return the book as a dictionary that json can save."""
        return {
            "title": self.title,
            "author": self.author,
            "year": self.year,
            "available": self.available,
        }

    @classmethod
    def from_dict(cls, data):
        """Build a book from a dictionary loaded from JSON."""
        return cls(data["title"], data["author"], data["year"],
                   data["available"])


def save_books(path, books):
    """Save a list of books to a JSON file."""
    with open(path, "w", encoding="utf-8") as file:
        json.dump([book.to_dict() for book in books], file,
                  indent=2, ensure_ascii=False)


def load_books(path):
    """Load a list of books from a JSON file."""
    with open(path, encoding="utf-8") as file:
        return [Book.from_dict(data) for data in json.load(file)]
```

`from_dict` reads only the keys it needs, so it can even load the books
in `catalog.json`, which have extra `tags`:

```python title="shelf.py"
from book import load_books, save_books

shelf = load_books("catalog.json")
print(shelf[:3])

shelf[0].available = False
save_books("shelf.json", shelf)

again = load_books("shelf.json")
print(again[0])
print(again[0] is shelf[0], again[0].title == shelf[0].title)
```

```text
[Book('Kronikë në gur', 1971, in), Book('The Little Prince', 1943, out), Book('Nineteen Eighty-Four', 1949, in)]
Book('Kronikë në gur', 1971, out)
False True
```

```bash
head -n 8 shelf.json
```

```text
[
  {
    "title": "Kronikë në gur",
    "author": "Ismail Kadare",
    "year": 1971,
    "available": false
  },
  {
```

The loaded book is a **new object** with the same data: `is` is
`False`, but the titles match. That is what deserialisation means: you
get the data back, not the same object.

!!! info "What about `vars()`?"

    For a simple object, `vars(book)`, or `book.__dict__`, already gives
    a dictionary of its attributes:

    ```python title="vars_demo.py"
    from book import Book

    dune = Book("Dune", "Frank Herbert", 1965)
    print(vars(dune))
    ```

    ```text
    {'title': 'Dune', 'author': 'Frank Herbert', 'year': 1965, 'available': True}
    ```

    It is a handy shortcut. An explicit `to_dict()` is safer: you choose
    exactly what goes into the file, and renaming an attribute later does
    not silently change your file format.

!!! tip "Try it"

    Add a `borrower` attribute to `Book`, `None` by default, and save it
    in `to_dict()`. Make sure `from_dict()` can still load `shelf.json`,
    which was saved before `borrower` existed.

??? success "Answer"

    ```python title="book_borrower.py"
    """Book with a borrower: still loads files saved before the change."""
    import json


    class Book:
        """A book in the library catalog."""

        def __init__(self, title, author, year, available=True, borrower=None):
            self.title = title
            self.author = author
            self.year = year
            self.available = available
            self.borrower = borrower

        def to_dict(self):
            """Return the book as a dictionary that json can save."""
            return {
                "title": self.title,
                "author": self.author,
                "year": self.year,
                "available": self.available,
                "borrower": self.borrower,
            }

        @classmethod
        def from_dict(cls, data):
            """Build a book from a dictionary loaded from JSON."""
            return cls(data["title"], data["author"], data["year"],
                       data["available"], data.get("borrower"))


    with open("shelf.json", encoding="utf-8") as file:
        shelf = [Book.from_dict(data) for data in json.load(file)]

    print(shelf[0].title, shelf[0].borrower)
    shelf[0].borrower = "Ada"
    print(json.dumps(shelf[0].to_dict(), ensure_ascii=False))
    ```

    ```text
    Kronikë në gur None
    {"title": "Kronikë në gur", "author": "Ismail Kadare", "year": 1971, "available": false, "borrower": "Ada"}
    ```

    `data.get("borrower")` returns `None` when the key is missing, where
    `data["borrower"]` would raise `KeyError`. Old files keep loading.

!!! ai "AI in the loop"

    Assistants write file code in seconds, and one wrong letter in a mode
    destroys data: a `"w"` where you meant `"a"` empties the file without
    a word. Before you run file code you did not write, find every
    `open()` and say out loud which file it touches and in which mode.
    Try it on a copy of your data first.

## When something goes wrong

??? note "`FileNotFoundError`, but the file is right there"

    The path is relative and the terminal is in another folder. Run
    `pwd` and `ls`; `cd` to the folder with the file, or use an absolute
    path. Also check for `~` in the path (see Step 8) and for typos in
    the extension: `book.txt` is not `books.txt`.

??? note "`UnicodeDecodeError`"

    The file was opened without `encoding="utf-8"`, or with the wrong
    encoding. Add `encoding="utf-8"` to every `open()`.

??? note "My file is empty after the script ran"

    It was opened with `"w"`, which empties the file as it opens. To add
    to a file, use `"a"`.

??? note "Every line prints with an empty line after it"

    Each line ends with `"\n"`, and `print()` adds another. Use
    `line.rstrip("\n")`, or `print(line, end="")`.

??? note "The second read returns nothing"

    The cursor is at the end of the file. `seek(0)` goes back to the
    start, or read the file once into a variable and reuse it.

??? note "`json.decoder.JSONDecodeError`"

    The text is not valid JSON. The usual causes are single quotes, a
    comma after the last item, or an empty file. The message gives the
    line and column of the problem.

??? note "`TypeError: Object of type ... is not JSON serializable`"

    You passed something `json` does not know: a set, or an object of
    your own class. Convert it first: `list(the_set)`, or
    `the_object.to_dict()`.

## Practice set

Seven exercises, from easy to harder. All of them run in `~/library`,
on `books.txt` and on `catalog.json` as you left it after Step 9, with
seven books. Try each one before you open the answer.

**1. Count.** Print how many books `books.txt` lists, and how many of
them are by Ismail Kadare.

??? success "Answer"

    ```python title="p1_count.py"
    total = 0
    kadare = 0

    with open("books.txt", encoding="utf-8") as file:
        for line in file:
            title, author, year = line.rstrip("\n").split(";")
            total += 1
            if author == "Ismail Kadare":
                kadare += 1

    print(f"{total} books, {kadare} by Ismail Kadare")
    ```

    ```text
    10 books, 2 by Ismail Kadare
    ```

**2. Authors.** Write every author in `books.txt` to `authors.txt`,
each one once, in alphabetical order.

??? success "Answer"

    ```python title="p2_authors.py"
    authors = set()

    with open("books.txt", encoding="utf-8") as file:
        for line in file:
            authors.add(line.split(";")[1])

    with open("authors.txt", "w", encoding="utf-8") as file:
        for author in sorted(authors):
            file.write(author + "\n")

    print(len(authors), "authors written")
    ```

    ```text
    9 authors written
    ```

    ```text
    Antoine de Saint-Exupéry
    Chinua Achebe
    Frank Herbert
    Gabriel García Márquez
    George Orwell
    Ismail Kadare
    J. R. R. Tolkien
    Jane Austen
    Miguel de Cervantes
    ```

**3. Numbered list.** Write `numbered.txt`, with lines such as
`1. Kronikë në gur (1971)`.

??? success "Answer"

    ```python title="p3_numbered.py"
    with open("books.txt", encoding="utf-8") as source, \
            open("numbered.txt", "w", encoding="utf-8") as target:
        for number, line in enumerate(source, start=1):
            title, author, year = line.rstrip("\n").split(";")
            target.write(f"{number}. {title} ({year})\n")
    ```

    ```bash
    head -n 4 numbered.txt
    ```

    ```text
    1. Kronikë në gur (1971)
    2. Gjenerali i ushtrisë së vdekur (1963)
    3. The Little Prince (1943)
    4. Nineteen Eighty-Four (1949)
    ```

**4. Text to JSON.** Convert `books.txt` into `books.json`: a list of
dictionaries with `title`, `author` and `year`, where `year` is a
number, not a string.

??? success "Answer"

    ```python title="p4_to_json.py"
    import json

    books = []
    with open("books.txt", encoding="utf-8") as file:
        for line in file:
            title, author, year = line.rstrip("\n").split(";")
            books.append({"title": title, "author": author, "year": int(year)})

    with open("books.json", "w", encoding="utf-8") as file:
        json.dump(books, file, indent=2, ensure_ascii=False)

    print(len(books), "books converted")
    ```

    ```text
    10 books converted
    ```

**5. Report.** From `catalog.json`, print how many books are available,
and list the borrowed ones, oldest first.

??? success "Answer"

    ```python title="p5_report.py"
    import json

    with open("catalog.json", encoding="utf-8") as file:
        catalog = json.load(file)

    available = [book for book in catalog if book["available"]]
    borrowed = [book for book in catalog if not book["available"]]

    print(f"{len(available)} of {len(catalog)} books available")
    print("Borrowed:")
    for book in sorted(borrowed, key=lambda book: book["year"]):
        print(f"  {book['year']}  {book['title']}")
    ```

    ```text
    5 of 7 books available
    Borrowed:
      1943  The Little Prince
      1965  Dune
    ```

**6. Safe loading.** Write `load_or_empty(path)`, which returns the data
in a JSON file, or `[]` if the file is missing or is not valid JSON, with
a warning in that second case. Test it on an empty file.

??? success "Answer"

    ```python title="p6_safe_load.py"
    import json


    def load_or_empty(path):
        """Return the data in a JSON file, or [] if it is missing or broken."""
        try:
            with open(path, encoding="utf-8") as file:
                return json.load(file)
        except FileNotFoundError:
            return []
        except json.JSONDecodeError as error:
            print(f"Warning: {path} is not valid JSON ({error})")
            return []


    open("empty.json", "w", encoding="utf-8").close()

    print(len(load_or_empty("catalog.json")))
    print(load_or_empty("nothing-here.json"))
    print(load_or_empty("empty.json"))
    ```

    ```text
    7
    []
    Warning: empty.json is not valid JSON (Expecting value: line 1 column 1 (char 0))
    []
    ```

**7. Borrow a book.** Write `borrow(path, title)`, which loads the
catalog, marks the book as not available, and saves the file. It should
refuse a book that is already borrowed, or that does not exist.

??? success "Answer"

    ```python title="p7_borrow.py"
    import json


    def borrow(path, title):
        """Mark a book in a catalog file as borrowed, and save the file."""
        with open(path, encoding="utf-8") as file:
            catalog = json.load(file)

        for book in catalog:
            if book["title"] == title:
                if not book["available"]:
                    print(f"{title} is already borrowed")
                    return False
                book["available"] = False
                with open(path, "w", encoding="utf-8") as file:
                    json.dump(catalog, file, indent=2, ensure_ascii=False)
                print(f"{title} borrowed")
                return True

        print(f"No book called {title}")
        return False


    borrow("catalog.json", "The Hobbit")
    borrow("catalog.json", "The Hobbit")
    borrow("catalog.json", "Ulysses")
    ```

    ```text
    The Hobbit borrowed
    The Hobbit is already borrowed
    No book called Ulysses
    ```

    Run the report from exercise 5 again, and The Hobbit is now borrowed:

    ```text
    4 of 7 books available
    Borrowed:
      1937  The Hobbit
      1943  The Little Prince
      1965  Dune
    ```

## Explain it to someone

- [ ] What a path is, and the difference between an absolute and a relative one
- [ ] What the current working directory is, and why it decides whether a relative path works
- [ ] How to open a file, and what the path, the mode and the encoding each control
- [ ] What `"r"`, `"w"`, `"a"` and `"x"` do to a file that already exists
- [ ] How to write text to a file, and why you add `"\n"` yourself
- [ ] How to read a whole file, one line, all lines, and line by line in a loop
- [ ] What the cursor is, and how `tell()` and `seek()` move it
- [ ] Why a file must be closed, and why `with` is safer than calling `close()`
- [ ] Which exceptions opening a file can raise, and how to handle them
- [ ] What JSON is, and what serialisation and deserialisation mean
- [ ] The difference between `dumps`/`loads` and `dump`/`load`
- [ ] How to save objects of your own class as JSON, and load them back

## Quick reference

| Code | What it does |
|---|---|
| `open(path, mode, encoding="utf-8")` | Open a file; mode `"r"`, `"w"`, `"a"` or `"x"` |
| `with open(...) as file:` | Open, and close automatically when the block ends |
| `file.write(text)` | Write text; add `"\n"` yourself |
| `print(text, file=file)` | Write text and a newline |
| `file.read()` | The whole file as one string |
| `file.readline()` / `file.readlines()` | One line / all lines as a list |
| `for line in file:` | Line by line |
| `line.rstrip("\n")` | Remove the newline at the end |
| `file.tell()` / `file.seek(0)` | Where the cursor is / back to the start |
| `os.getcwd()` | The current working directory |
| `json.dumps(data)` / `json.loads(text)` | Data to a JSON string / back |
| `json.dump(data, file, indent=2, ensure_ascii=False)` | Save data to a JSON file |
| `json.load(file)` | Load data from a JSON file |
| `obj.to_dict()` / `Cls.from_dict(data)` | Your own class to JSON-ready data / back |

## Next

Files are perfect for a list or a settings file. But when you need to
find, sort, count and change thousands of records, and keep them correct
while several programs use them, you need a **database**. Next, SQL.

[SQL: CRUD Operations](sql-crud.md){ .h-button }
