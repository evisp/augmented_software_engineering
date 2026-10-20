# Control Flow

<span class="badge badge--time">60 min</span>
<span class="badge badge--level">Python</span>
<span class="badge">Needs: Hello, World</span>

So far your programs run every line once, top to bottom. Control flow
changes that: `if` decides which lines run, and loops decide how many
times. With those two ideas you can write almost any algorithm.

## Why this matters

Every program you will ever write is built from three things: steps in
order, decisions, and repetition. This tutorial covers the last two.

The other skill here is precision. A loop that runs one time too many
or one too few is the most common bug in programming, and the Checker
compares your output character by character. Learning to *reason*
about where a loop starts and stops, before you run it, saves hours.

## Step 1: Compare and combine

A **condition** is an expression that is either `True` or `False`.

| Operator | Meaning | Example | Result |
|---|---|---|---|
| `==` | equal to | `3 == 3.0` | `True` |
| `!=` | not equal to | `"a" != "b"` | `True` |
| `<` `<=` | less than, or equal | `5 <= 5` | `True` |
| `>` `>=` | greater than, or equal | `2 > 7` | `False` |
| `and` | both are true | `x > 0 and x < 10` | |
| `or` | at least one is true | `day == "Sat" or day == "Sun"` | |
| `not` | the opposite | `not finished` | |
| `in` | is contained in | `"py" in "python"` | `True` |

Two things catch everyone at the start:

- **`=` stores, `==` compares.** `if x = 5:` is a syntax error.
- **Python can chain comparisons.** `0 <= x < 10` means exactly what it
  says, and is clearer than `x >= 0 and x < 10`.

Every value also counts as true or false on its own. `0`, `0.0`, the
empty string `""`, `None` and empty collections count as false;
everything else counts as true. So `if name:` means "if `name` is not
empty". Careful: `"0"` is a non-empty string, so it counts as true.

## Step 2: Decide with `if`, `elif` and `else`

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 196" role="img" aria-labelledby="py-if-title py-if-desc">
<title id="py-if-title">An if, elif, else chain</title>
<desc id="py-if-desc">Python checks the conditions in order. If score is at least 90 it runs the A branch and skips the rest. Otherwise, if score is at least 75 it runs the B branch. If neither is true, the else branch runs and prints C. Exactly one branch runs.</desc>
<defs><marker id="py-if-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<g font-family="var(--md-code-font-family, monospace)" font-size="13" font-weight="700" text-anchor="middle">
<rect x="3" y="20" width="190" height="52" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="98" y="51" fill="var(--h-fig-text)">if score &gt;= 90</text>
<rect x="245" y="20" width="190" height="52" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="340" y="51" fill="var(--h-fig-text)">elif score &gt;= 75</text>
<rect x="487" y="20" width="190" height="52" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="582" y="51" fill="var(--h-fig-text)">else</text>
<rect x="38" y="122" width="120" height="44" rx="10" fill="var(--h-cherry)"/>
<text x="98" y="149" fill="#ffffff">print("A")</text>
<rect x="280" y="122" width="120" height="44" rx="10" fill="var(--h-cherry)"/>
<text x="340" y="149" fill="#ffffff">print("B")</text>
<rect x="522" y="122" width="120" height="44" rx="10" fill="var(--h-cherry)"/>
<text x="582" y="149" fill="#ffffff">print("C")</text>
</g>
<g stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#py-if-arrow)">
<line x1="197" y1="46" x2="239" y2="46"/>
<line x1="439" y1="46" x2="481" y2="46"/>
<line x1="98" y1="76" x2="98" y2="116"/>
<line x1="340" y1="76" x2="340" y2="116"/>
<line x1="582" y1="76" x2="582" y2="116"/>
</g>
<g font-size="11.5" font-weight="600" fill="var(--h-fig-muted)">
<text x="218" y="36" text-anchor="middle">no</text>
<text x="460" y="36" text-anchor="middle">no</text>
<text x="108" y="102">yes</text>
<text x="350" y="102">yes</text>
<text x="592" y="102">always</text>
</g>
<text x="340" y="190" text-anchor="middle" font-size="12" font-weight="600" fill="var(--h-fig-text)">checked top to bottom; the first true branch runs, the rest are skipped</text>
</svg>
</figure>

```python
score = 82
if score >= 90:
    print("A")
elif score >= 75:
    print("B")
else:
    print("C")
```

This prints `B`. Python tests each condition in order and runs the
block under the **first** one that is true. Everything after it is
skipped, even if it would also be true.

That makes the order of the conditions part of the logic. Swap the
first two tests and a score of 95 prints `B`, because `95 >= 75` is
checked first.

The block under each line is marked only by **indentation**: four
spaces, no braces. The colon at the end of the `if` line says "a block
follows".

## Step 3: Repeat with `while`

A `while` loop repeats its block for as long as its condition is true.

```python
count = 3
while count > 0:
    print(count)
    count -= 1
print("Go!")
```

```
3
2
1
Go!
```

To understand a loop, trace it: write down the variables on every pass.

| Pass | `count` at start | `count > 0`? | Prints |
|---|---|---|---|
| 1 | 3 | yes | `3` |
| 2 | 2 | yes | `2` |
| 3 | 1 | yes | `1` |
| — | 0 | no, loop ends | `Go!` (after the loop) |

Something inside the loop must eventually make the condition false.
Delete `count -= 1` and the loop never ends. If that happens, press
++ctrl+c++ to stop the program.

## Step 4: Repeat with `for` and `range`

A `for` loop runs its block once for each item in a sequence. To loop
over numbers, use `range`.

```python
for i in range(5):
    print(i)       # 0, 1, 2, 3, 4
```

`range` takes up to three numbers, and the same rule as slicing
applies: **the start is included, the stop is not**.

| Call | Gives | Count |
|---|---|---|
| `range(5)` | 0, 1, 2, 3, 4 | 5 |
| `range(2, 6)` | 2, 3, 4, 5 | 4 |
| `range(2, 11, 3)` | 2, 5, 8 | 3 |
| `range(10, 0, -3)` | 10, 7, 4, 1 | 4 |

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 150" role="img" aria-labelledby="py-range-title py-range-desc">
<title id="py-range-title">range(2, 11, 3) on a number line</title>
<desc id="py-range-desc">On a number line from 0 to 12, range of 2, 11, 3 starts at 2, adds 3 each time to reach 5 and 8, and stops before 11. The next value, 11, would equal the stop, so it is not included.</desc>
<line x1="30" y1="70" x2="650" y2="70" stroke="var(--h-fig-line)" stroke-width="2"/>
<g font-size="12" text-anchor="middle" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">
<text x="40" y="102">0</text><text x="90" y="102">1</text><text x="140" y="102">2</text><text x="190" y="102">3</text><text x="240" y="102">4</text><text x="290" y="102">5</text><text x="340" y="102">6</text><text x="390" y="102">7</text><text x="440" y="102">8</text><text x="490" y="102">9</text><text x="540" y="102">10</text><text x="590" y="102">11</text><text x="640" y="102">12</text>
</g>
<g stroke="var(--h-fig-line)" stroke-width="2">
<line x1="40" y1="64" x2="40" y2="76"/><line x1="90" y1="64" x2="90" y2="76"/><line x1="190" y1="64" x2="190" y2="76"/><line x1="240" y1="64" x2="240" y2="76"/><line x1="340" y1="64" x2="340" y2="76"/><line x1="390" y1="64" x2="390" y2="76"/><line x1="490" y1="64" x2="490" y2="76"/><line x1="540" y1="64" x2="540" y2="76"/><line x1="640" y1="64" x2="640" y2="76"/>
</g>
<circle cx="140" cy="70" r="11" fill="var(--h-cherry)"/>
<circle cx="290" cy="70" r="11" fill="var(--h-cherry)"/>
<circle cx="440" cy="70" r="11" fill="var(--h-cherry)"/>
<circle cx="590" cy="70" r="11" fill="var(--md-default-bg-color)" stroke="var(--h-fig-text)" stroke-width="2" stroke-dasharray="3 3"/>
<g fill="none" stroke="var(--h-cherry)" stroke-width="2">
<path d="M146 56 Q 215 18 284 56"/>
<path d="M296 56 Q 365 18 434 56"/>
</g>
<path d="M446 56 Q 515 18 584 56" fill="none" stroke="var(--h-fig-line)" stroke-width="2" stroke-dasharray="4 4"/>
<g font-size="11.5" font-weight="700" text-anchor="middle">
<text x="215" y="26" fill="var(--h-cherry)">+3</text>
<text x="365" y="26" fill="var(--h-cherry)">+3</text>
<text x="515" y="26" fill="var(--h-fig-muted)">+3</text>
<text x="140" y="130" fill="var(--h-cherry)">start</text>
<text x="590" y="130" fill="var(--h-fig-text)">stop: not included</text>
</g>
</svg>
</figure>

Two questions to ask about any loop, before you run it:

- **What is the first value, and what is the last?** For
  `range(a, b)`, the first is `a` and the last is `b - 1`.
- **How many times does it run?** For `range(a, b)`, exactly `b - a`
  times.

If you want the numbers 1 to 10 inclusive, the stop is 11:
`range(1, 11)`. Getting this wrong by one is called an **off-by-one
error**, and checking the first value, the last value and the count
catches nearly all of them.

### Leave early with `break` and `continue`

- `break` ends the loop immediately.
- `continue` skips the rest of this pass and moves to the next one.

```python
for n in range(1, 10):
    if n % 4 == 0:
        continue        # skip multiples of 4
    if n > 7:
        break           # stop once we pass 7
    print(n)
```

This prints 1, 2, 3, 5, 6 and 7, one per line. Trace it on paper first
to check you agree.

## Step 5: Produce formatted output

Most projects ask for output in an exact format. Combine loops with
what you learned about `print` and f-strings.

**Aligned columns.** A format spec gives every number the same width:

```python
n = 7
for i in range(1, 6):
    print(f"{n} x {i} = {n * i:2}")
```

```
7 x 1 =  7
7 x 2 = 14
7 x 3 = 21
7 x 4 = 28
7 x 5 = 35
```

**A separator between items, not after the last one.** A common
requirement, and a common mistake. Decide on each pass whether you are
at the end:

```python
for i in range(1, 6):
    if i < 5:
        print(i, end=", ")
    else:
        print(i)
```

```
1, 2, 3, 4, 5
```

**A loop inside a loop** builds a grid. The inner loop prints one row;
the empty `print()` after it ends the line.

```python
for row in range(1, 4):
    for col in range(1, 5):
        print(f"{row * col:3}", end="")
    print()
```

```
  1  2  3  4
  2  4  6  8
  3  6  9 12
```

The outer loop runs 3 times and the inner loop runs 4 times for each,
so the inner `print` runs 3 × 4 = 12 times.

## Step 6: Make your output deterministic, and prove it

A program is **deterministic** when the same input always produces
exactly the same output. That is what the Checker relies on: it runs
your script and compares the output with the expected output, byte for
byte. An extra space at the end of a line, or a missing final newline,
is a failure.

You can do the same comparison yourself. Save the expected output to a
file, then:

```bash
./table.py > got.txt
diff got.txt expected.txt
```

No output from `diff` means the two are identical. Anything else
shows you exactly which lines differ. To see invisible characters such
as trailing spaces, run `cat -A got.txt`: every line end is shown as
`$`, so a space before it is easy to spot.

!!! ai "AI in the loop"

    When a loop does not do what you expect, do not ask an assistant to
    fix it. Ask it to **trace** it: *"Trace this loop pass by pass in a
    table, showing each variable at the start of every pass."* Then
    compare its table with your own. Where they differ is where your
    understanding is off, and that is the thing to fix.

## When something goes wrong

??? note "`IndentationError: expected an indented block`"

    The line after `if`, `for` or `while` must be indented by four
    spaces. Check VS Code is set to spaces, not tabs, in the status bar.

??? note "The loop never ends"

    Nothing inside it changes the condition. Press ++ctrl+c++, then add
    the line that moves the loop towards its end, such as `count -= 1`.

??? note "My output is almost right but the Checker fails it"

    Run `./script.py | cat -A` and look for spaces before the `$`, a
    missing last line, or a separator after the last item.

??? note "The loop runs one time too many, or too few"

    Write down the first value, the last value and the count of your
    `range`, and compare them with what the task asks for. The stop is
    never included.

## Explain it to someone

- [ ] How `if`, `elif` and `else` decide which block runs, and why order matters
- [ ] The comparison operators, and the difference between `=` and `==`
- [ ] How `and`, `or` and `not` combine conditions
- [ ] How a `while` loop decides to stop, and how to trace one
- [ ] How `for` and `range` work, and why the stop is not included
- [ ] How to find the first value, last value and number of passes of a loop
- [ ] How to print numbers in a fixed format, with separators only between items
- [ ] What deterministic output means, and how to check it with `diff`

## Quick reference

| Code | What it does |
|---|---|
| `if cond:` / `elif cond:` / `else:` | Run the first block whose condition is true |
| `while cond:` | Repeat while `cond` is true |
| `for x in range(a, b, step):` | Repeat for `a`, `a + step`, ... up to, not including, `b` |
| `break` / `continue` | Leave the loop / skip to the next pass |
| `print(x, end="")` | Print without a newline |
| `f"{x:3}"`, `f"{x:02}"` | Width 3, or width 2 padded with zeros |
| `diff got.txt expected.txt` | Compare two outputs; silence means identical |
| `cat -A file` | Show invisible characters, with `$` at each line end |

## Next

Your programs can decide and repeat. Next, organise them into
functions you can reuse and import.

[Functions & Modularity](functions.md){ .h-button }
