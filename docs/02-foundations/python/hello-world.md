# Hello, World

<span class="badge badge--time">50 min</span>
<span class="badge badge--level">Python</span>
<span class="badge">Needs: Environment & First Programs</span>

Every program needs to show its results, and most programs spend a lot
of their time handling text. This tutorial covers printing, strings,
how to pull pieces out of a string with indexing and slicing, and how
to keep your code in the official Python style.

## Why this matters

Text is everywhere: user input, file contents, web pages, API
responses, log lines. Being quick with strings makes every later
project easier.

Style matters for a different reason. Code is read far more often than
it is written, by your peers, your reviewers and you in three months.
Python has one official style, and every Holberton Python project is
checked against it.

## Step 1: Print text and variables

`print` writes values to the terminal, then moves to a new line.

```python
print("Hello, Holberton")
print("Python", "is", "fun")          # several values: joined with spaces
print("a", "b", "c", sep="-")         # choose the separator: a-b-c
print("No newline", end="")           # choose what goes at the end
print()                               # an empty line
```

To print variables, the clearest way is an **f-string**: put `f` before
the quotes and the variable names in curly braces.

```python
name = "Ada"
year = 1843
print(f"{name} wrote the first program in {year}.")
```

```
Ada wrote the first program in 1843.
```

Inside the braces you can add a **format spec** after a colon, to
control how a number is shown:

```python
price = 3.14159
print(f"Price: {price:.2f}")     # 2 decimal places   -> Price: 3.14
print(f"[{42:5}]")               # width 5            -> [   42]
print(f"[{42:<5}]")              # width 5, left      -> [42   ]
print(f"[{7:03}]")               # pad with zeros     -> [007]
```

You will see the older styles too, `"%s is %d" % (name, age)` and
`"{} is {}".format(name, age)`. They work, and you should recognise
them, but use f-strings in new code.

## Step 2: Work with strings

A **string** is a sequence of characters. Single and double quotes mean
the same thing; pick whichever avoids escaping.

```python
a = 'single'
b = "double, and it's easy to include an apostrophe"
c = """Triple quotes
span several lines."""
d = "Tab:\tand a new line:\nhere"       # \t and \n are escape sequences
```

The everyday operations:

```python
word = "code"
word + "r"          # 'coder'        concatenation
word * 3            # 'codecodecode' repetition
len(word)           # 4              length
"o" in word         # True           membership
word.upper()        # 'CODE'         a new string; word is unchanged
```

That last comment matters: strings are **immutable**. No method changes
a string in place; each returns a new one. `word.upper()` on its own
line does nothing useful. You need `word = word.upper()` to keep the
result.

## Step 3: Indexing and slicing

Every character in a string has a position, called its **index**.
Counting starts at 0 from the left, and at -1 from the right.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 236" role="img" aria-labelledby="py-slice-title py-slice-desc">
<title id="py-slice-title">Indexing and slicing the string Holberton</title>
<desc id="py-slice-desc">The string Holberton has nine characters. Positive indices run from 0 for H to 8 for n. Negative indices run from minus 9 for H to minus 1 for n. The slice from 0 to 3 takes H, o and l, stopping before index 3. The slice from 3 to the end takes berton.</desc>
<g font-size="11.5" font-weight="700" text-anchor="middle" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">
<text x="106" y="22">0</text><text x="166" y="22">1</text><text x="226" y="22">2</text><text x="286" y="22">3</text><text x="346" y="22">4</text><text x="406" y="22">5</text><text x="466" y="22">6</text><text x="526" y="22">7</text><text x="586" y="22">8</text>
</g>
<g font-size="22" font-weight="700" text-anchor="middle" font-family="var(--md-code-font-family, monospace)">
<rect x="78" y="32" width="56" height="56" rx="8" fill="var(--h-cherry)"/><text x="106" y="68" fill="#ffffff">H</text>
<rect x="138" y="32" width="56" height="56" rx="8" fill="var(--h-cherry)"/><text x="166" y="68" fill="#ffffff">o</text>
<rect x="198" y="32" width="56" height="56" rx="8" fill="var(--h-cherry)"/><text x="226" y="68" fill="#ffffff">l</text>
<rect x="258" y="32" width="56" height="56" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="286" y="68" fill="var(--h-fig-text)">b</text>
<rect x="318" y="32" width="56" height="56" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="346" y="68" fill="var(--h-fig-text)">e</text>
<rect x="378" y="32" width="56" height="56" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="406" y="68" fill="var(--h-fig-text)">r</text>
<rect x="438" y="32" width="56" height="56" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="466" y="68" fill="var(--h-fig-text)">t</text>
<rect x="498" y="32" width="56" height="56" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="526" y="68" fill="var(--h-fig-text)">o</text>
<rect x="558" y="32" width="56" height="56" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="586" y="68" fill="var(--h-fig-text)">n</text>
</g>
<g font-size="11.5" font-weight="700" text-anchor="middle" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">
<text x="106" y="106">-9</text><text x="166" y="106">-8</text><text x="226" y="106">-7</text><text x="286" y="106">-6</text><text x="346" y="106">-5</text><text x="406" y="106">-4</text><text x="466" y="106">-3</text><text x="526" y="106">-2</text><text x="586" y="106">-1</text>
</g>
<text x="68" y="22" text-anchor="end" font-size="11" fill="var(--h-fig-muted)">index</text>
<text x="68" y="106" text-anchor="end" font-size="11" fill="var(--h-fig-muted)">from end</text>
<polyline points="78,128 78,138 254,138 254,128" fill="none" stroke="var(--h-cherry)" stroke-width="2"/>
<text x="166" y="162" text-anchor="middle" font-size="13" font-weight="700" fill="var(--h-cherry)" font-family="var(--md-code-font-family, monospace)">s[0:3] → 'Hol'</text>
<text x="166" y="182" text-anchor="middle" font-size="11" fill="var(--h-fig-muted)">starts at 0, stops before 3</text>
<polyline points="258,128 258,138 614,138 614,128" fill="none" stroke="var(--h-fig-line)" stroke-width="2"/>
<text x="436" y="162" text-anchor="middle" font-size="13" font-weight="700" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">s[3:] → 'berton'</text>
<text x="436" y="182" text-anchor="middle" font-size="11" fill="var(--h-fig-muted)">from 3 to the end</text>
<g font-size="12" font-weight="600" fill="var(--h-fig-text)" text-anchor="middle" font-family="var(--md-code-font-family, monospace)"><text x="166" y="222">s = "Holberton"</text><text x="346" y="222">len(s) = 9</text><text x="526" y="222">last index = 8</text></g>
</svg>
</figure>

**Indexing** takes one character:

```python
s = "Holberton"
s[0]       # 'H'   the first
s[4]       # 'e'
s[-1]      # 'n'   the last, without needing to know the length
s[9]       # IndexError: there is no index 9 in a 9-character string
```

**Slicing** takes a range, written `s[start:stop]`. The start is
included and the stop is not, so `s[0:3]` gives three characters,
indices 0, 1 and 2.

```python
s[0:3]     # 'Hol'
s[3:]      # 'berton'   leave out stop: go to the end
s[:3]      # 'Hol'      leave out start: begin at 0
s[-3:]     # 'ton'      the last three
s[:-3]     # 'Holber'   everything except the last three
s[::2]     # ?          every second character: work it out
s[::-1]    # 'notrebloH' a step of -1 walks backwards
```

The third number is the **step**. Work out `s[::2]` before you run
it: it takes indices 0, 2, 4, 6 and 8.

Two rules make slicing easy to reason about:

- `s[a:b]` has `b - a` characters.
- `s[:n] + s[n:]` is always the whole string.

Unlike indexing, slicing never raises an error for being out of range:
`s[5:100]` simply stops at the end.

## Step 4: Check your style with `pycodestyle`

Python's official style guide is called **PEP 8**. The rules that
matter most at the start:

- Indent with **4 spaces**, never tabs.
- Keep lines to **79 characters** or fewer.
- Put spaces around operators: `x = a + b`, not `x=a+b`.
- No spaces at the end of lines, and one newline at the end of the file.
- Two blank lines before a top-level function definition.

`pycodestyle` checks a file against these rules. You installed it in
your venv in the previous tutorial. Run it on any file you wrote:

```bash
cd ~/holberton/python-basics
source .venv/bin/activate
pycodestyle calc.py
```

When there is nothing wrong it prints nothing. On a messier file, each
line tells you exactly where the problem is:

```
greeting.py:3:80: E501 line too long (86 > 79 characters)
greeting.py:5:6: E225 missing whitespace around operator
greeting.py:7:1: W391 blank line at end of file
```

Read it as **file : line : column : code message**. Codes starting with
`E` are errors in style, `W` are warnings. Holberton projects require
every Python file to pass with no output at all.

!!! ai "AI in the loop"

    Paste a `pycodestyle` message into an assistant and ask what the
    rule is and *why* it exists. Then fix it yourself. Asking the
    assistant to "make this pass pycodestyle" usually works, but you
    learn nothing, and the next file has the same mistakes.

## When something goes wrong

??? note "`SyntaxError: unterminated string literal`"

    A quote is missing, or the string contains the same quote that
    opens it. `'it's'` breaks; `"it's"` works.

??? note "`TypeError: can only concatenate str (not "int") to str`"

    You wrote something like `"Age: " + 30`. Use an f-string,
    `f"Age: {30}"`, or convert with `str(30)`.

??? note "`IndexError: string index out of range`"

    The last index is `len(s) - 1`, not `len(s)`. Use `s[-1]` for the
    last character.

??? note "`pycodestyle: command not found`"

    Your venv is not active. Run `source .venv/bin/activate` from the
    project folder.

## Explain it to someone

- [ ] How to start, use and leave the Python interpreter
- [ ] How to print text and variables, including with f-strings
- [ ] How to change the separator and the line ending of `print`
- [ ] What a string is, and why strings are immutable
- [ ] What indexing is, including negative indices
- [ ] What slicing is, and why `s[a:b]` has `b - a` characters
- [ ] What PEP 8 is, and how to check a file with `pycodestyle`

## Quick reference

| Code | Result |
|---|---|
| `print(a, b, sep=", ", end="!\n")` | Print with a custom separator and ending |
| `f"{x}"`, `f"{x:.2f}"`, `f"{x:5}"` | Insert, 2 decimals, width 5 |
| `len(s)` | Number of characters |
| `s[i]`, `s[-1]` | One character, last character |
| `s[a:b]`, `s[:b]`, `s[a:]` | Slice: from `a` up to, not including, `b` |
| `s[::-1]` | Reversed |
| `s.upper()`, `s.lower()`, `s.strip()` | New string, changed |
| `pycodestyle file.py` | Check style; no output means it passes |

## Next

You can produce output. Now make your programs decide and repeat.

[Control Flow](control-flow.md){ .h-button }
