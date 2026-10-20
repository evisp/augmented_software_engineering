# Functions & Modularity

<span class="badge badge--time">75 min</span>
<span class="badge badge--level">Python</span>
<span class="badge">Needs: Control Flow</span>

A function is a named piece of code that takes inputs and gives back a
result. A module is a file of functions that other files can use. This
tutorial covers both, and the two ideas beginners most often get wrong:
the difference between `print` and `return`, and what really happens
when one file imports another.

## Why this matters

Without functions, a program is one long list of steps that you cannot
reuse, test or name. With them, you write a piece of logic once, give
it a clear name, check it on its own, and call it from anywhere.

Every project from here on is built from functions, and the Checker
tests most of them by **importing** your file and calling your
functions directly. If you do not understand `return` and importing,
your code can look right when you run it and still fail every check.

## Step 1: Define and call a function

```python
def area(width, height):
    """Return the area of a rectangle."""
    return width * height


print(area(3, 4))      # 12
```

- `def` starts the definition, followed by the function's **name**.
- `width` and `height` are **parameters**: names for the inputs, used
  inside the function.
- The text in triple quotes is the **docstring**. It says what the
  function does, and `help(area)` shows it.
- `return` ends the function and hands a value back to whoever called
  it.
- `area(3, 4)` is a **call**. The values `3` and `4` are the
  **arguments**: they are assigned to the parameters, in order.

Parameters can have **default values**, and arguments can be passed by
name:

```python
def greet(name, greeting="Hello"):
    return f"{greeting}, {name}!"


greet("Ada")                        # 'Hello, Ada!'
greet("Ada", "Welcome")             # 'Welcome, Ada!'
greet(greeting="Hi", name="Linus")  # 'Hi, Linus!'  by name, any order
```

## Step 2: `print` is not `return`

This is the single most important idea on this page.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 230" role="img" aria-labelledby="fn-io-title fn-io-desc">
<title id="fn-io-title">Where return and print send a value</title>
<desc id="fn-io-desc">Arguments go into the function. The return statement sends a value back to the code that called the function, where it can be stored in a variable, used in a calculation or passed to another function. The print function sends text to the screen instead, for a person to read; the calling code receives nothing, which Python represents as None.</desc>
<defs><marker id="fn-io-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker>
<marker id="fn-io-arrow-c" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-cherry)"/></marker></defs>
<rect x="3" y="70" width="150" height="70" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="78" y="100" text-anchor="middle" font-size="13.5" font-weight="700" fill="var(--h-fig-text)">Arguments</text>
<text x="78" y="120" text-anchor="middle" font-size="12" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">3, 4</text>
<rect x="240" y="50" width="200" height="110" rx="12" fill="var(--h-cherry)"/>
<text x="340" y="96" text-anchor="middle" font-size="15" font-weight="700" fill="#ffffff" font-family="var(--md-code-font-family, monospace)">area(w, h)</text>
<text x="340" y="120" text-anchor="middle" font-size="12" fill="#ffffff" opacity="0.9">does the work</text>
<rect x="527" y="70" width="150" height="70" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="602" y="100" text-anchor="middle" font-size="13.5" font-weight="700" fill="var(--h-fig-text)">Your code</text>
<text x="602" y="120" text-anchor="middle" font-size="12" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">result = 12</text>
<rect x="265" y="196" width="150" height="30" rx="8" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)" stroke-dasharray="4 3"/>
<text x="340" y="216" text-anchor="middle" font-size="12" font-weight="600" fill="var(--h-fig-muted)">the screen</text>
<line x1="157" y1="105" x2="234" y2="105" stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#fn-io-arrow)"/>
<line x1="444" y1="105" x2="521" y2="105" stroke="var(--h-cherry)" stroke-width="2.5" marker-end="url(#fn-io-arrow-c)"/>
<text x="482" y="94" text-anchor="middle" font-size="12" font-weight="700" fill="var(--h-cherry)">return</text>
<text x="482" y="126" text-anchor="middle" font-size="11" fill="var(--h-fig-muted)">value back</text>
<line x1="340" y1="164" x2="340" y2="190" stroke="var(--h-fig-line)" stroke-width="2" stroke-dasharray="4 3" marker-end="url(#fn-io-arrow)"/>
<text x="352" y="182" font-size="12" font-weight="700" fill="var(--h-fig-muted)">print</text>
<text x="430" y="216" font-size="11" fill="var(--h-fig-muted)">a person reads it; your code gets None</text>
<text x="340" y="30" text-anchor="middle" font-size="12" font-weight="600" fill="var(--h-fig-text)">return gives the value to your program; print only shows it to a person</text>
</svg>
</figure>

- **`return`** gives a value back to the code that called the function.
  That code can store it, compare it, do maths with it, or pass it to
  another function.
- **`print`** writes text to the screen for a person to read. The
  calling code gets nothing back. In Python, "nothing" is the value
  `None`.

See it for yourself:

```python
def shout_print(text):
    print(text.upper())


def shout_return(text):
    return text.upper()


a = shout_print("hi")      # prints HI straight away
b = shout_return("hi")     # prints nothing
print(a)
print(b)
print(shout_print("hey"))
```

```
HI
None
HI
HEY
None
```

Walk through it:

1. `shout_print("hi")` prints `HI`, then ends without a `return`, so
   `a` is `None`.
2. `shout_return("hi")` prints nothing. It hands `'HI'` back, and `b`
   stores it.
3. `print(a)` prints `None`. `print(b)` prints `HI`.
4. `print(shout_print("hey"))` first runs the function, which prints
   `HEY`, then prints what the function returned: `None`.

That stray `None` in your output is the classic sign that a function
printed when it should have returned.

**The rule:** a function that *computes* something should `return` it.
Only print when showing something to a person *is* the job, and then
usually in one place, at the top level of your program. A function that
returns is useful everywhere; a function that prints is useful only on
a screen.

## Step 3: Put logic inside functions

Everything from Control Flow works inside a function. A `return` can
appear anywhere, and it ends the function immediately.

```python
def letter(score):
    """Return the letter grade for a score from 0 to 100."""
    if score >= 90:
        return "A"
    if score >= 75:
        return "B"
    return "C"


def count_vowels(text):
    """Return how many vowels text contains."""
    count = 0
    for char in text.lower():
        if char in "aeiou":
            count += 1
    return count


print(letter(95), letter(80), letter(40))    # A B C
print(count_vowels("Holberton School"))      # 5
```

`letter` needs no `elif` or `else`: once a `return` runs, nothing after
it in the function runs. In `count_vowels`, notice where the `return`
sits: after the loop, at the function's indentation. Indent it one
level further and the function returns after the first character.

Variables created inside a function are **local**: they exist only
while the function runs. After `count_vowels` finishes, `count` is
gone. That is a feature. Each function is a sealed box whose only
outputs are its return value and anything it prints.

## Step 4: How Python runs a file

When Python runs a file, it executes the top-level lines from top to
bottom. A `def` is one of those lines: it *creates* the function, but
does not run its body. The body runs only when something calls it.

```python title="shapes.py"
#!/usr/bin/env python3
print("1. Python starts reading shapes.py")


def area(width, height):
    print("3. Inside area()")
    return width * height


print("2. area() is defined, but has not run")
result = area(3, 4)
print(f"4. The result is {result}")
```

```
1. Python starts reading shapes.py
2. area() is defined, but has not run
3. Inside area()
4. The result is 12
```

Keep this in mind for the next step: **importing a file runs it**. All
of its top-level code, from top to bottom, exactly as above.

## Step 5: Import from another file

Any `.py` file is a **module**. Another file in the same folder can
import its functions and variables.

```python title="greetings.py"
#!/usr/bin/env python3
"""Small greeting helpers."""

DEFAULT_NAME = "world"


def greet(name=DEFAULT_NAME):
    """Return a greeting for name."""
    return f"Hello, {name}!"


print(greet())
print(greet("Holberton"))
```

```python title="app.py"
#!/usr/bin/env python3
from greetings import greet, DEFAULT_NAME

print(greet("Ada"))
print(f"The default name is {DEFAULT_NAME}")
```

`from greetings import greet, DEFAULT_NAME` brings in a function and a
variable by name. Note there is no `.py` in the import. There are two
styles:

```python
from greetings import greet     # then call greet("Ada")
import greetings                # then call greetings.greet("Ada")
```

The second keeps the module name visible, which helps when you import
from several files. Now run the program:

```bash
./app.py
```

```
Hello, world!
Hello, Holberton!
Hello, Ada!
The default name is world
```

The first two lines are a bug. `app.py` only wanted the `greet`
function, but importing `greetings.py` ran all of its top-level code,
including the two test lines at the bottom. You meant those lines for
when you run `greetings.py` yourself, not for every file that imports
it.

## Step 6: `if __name__ == "__main__"`

Python gives every running file a variable called `__name__`. Its
value depends on *how* the file is being run.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 236" role="img" aria-labelledby="fn-main-title fn-main-desc">
<title id="fn-main-title">The value of __name__ when a file is run or imported</title>
<desc id="fn-main-desc">When you run greetings.py directly, its __name__ is the string __main__, so the block under if __name__ equals __main__ runs. When app.py imports greetings, the module's __name__ is the string greetings, so that block is skipped, while the function and variable definitions still run and become available to app.py.</desc>
<rect x="3" y="8" width="326" height="220" rx="12" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="22" y="36" font-size="11" font-weight="700" fill="var(--h-fig-muted)">RUN DIRECTLY</text>
<text x="22" y="60" font-size="13" font-weight="700" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">$ ./greetings.py</text>
<text x="22" y="96" font-size="12.5" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">__name__ == <tspan fill="var(--h-cherry)" font-weight="700">"__main__"</tspan></text>
<rect x="22" y="116" width="288" height="44" rx="8" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)"/>
<text x="38" y="143" font-size="12" fill="var(--h-fig-text)">definitions run: <tspan font-family="var(--md-code-font-family, monospace)">greet</tspan>, <tspan font-family="var(--md-code-font-family, monospace)">DEFAULT_NAME</tspan></text>
<rect x="22" y="168" width="288" height="44" rx="8" fill="var(--h-cherry)"/>
<text x="38" y="195" font-size="12" font-weight="700" fill="#ffffff">main block runs: test lines print</text>
<rect x="351" y="8" width="326" height="220" rx="12" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="370" y="36" font-size="11" font-weight="700" fill="var(--h-fig-muted)">IMPORTED</text>
<text x="370" y="60" font-size="13" font-weight="700" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">from greetings import greet</text>
<text x="370" y="96" font-size="12.5" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">__name__ == <tspan font-weight="700">"greetings"</tspan></text>
<rect x="370" y="116" width="288" height="44" rx="8" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)"/>
<text x="386" y="143" font-size="12" fill="var(--h-fig-text)">definitions run: available to app.py</text>
<rect x="370" y="168" width="288" height="44" rx="8" fill="none" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<text x="386" y="195" font-size="12" font-weight="700" fill="var(--h-fig-muted)">main block skipped</text>
</svg>
</figure>

- Run a file directly and its `__name__` is the string `"__main__"`.
- Import it and its `__name__` is the module's name, here `"greetings"`.

So a single `if` lets a file tell the two situations apart. Put the code
that should run *only when the file is the program* under it:

```python title="greetings.py"
#!/usr/bin/env python3
"""Small greeting helpers."""

DEFAULT_NAME = "world"


def greet(name=DEFAULT_NAME):
    """Return a greeting for name."""
    return f"Hello, {name}!"


if __name__ == "__main__":
    print(greet())
    print(greet("Holberton"))
```

Now both work as intended:

```bash
./greetings.py     # Hello, world!  Hello, Holberton!
./app.py           # Hello, Ada!  The default name is world
```

The guard is not decoration. It is what makes one file work both as a
**script** you run and as a **module** other code imports. Make it a
habit: definitions at the top, the guarded block at the bottom, and no
other top-level code that does work.

## Step 7: Import files with Holberton names

Holberton task files are often named like `0-greetings.py`. That name
cannot be imported with `import`, because a Python name cannot start
with a digit or contain a hyphen. `import 0-greetings` is a syntax
error.

The test files you receive use the built-in `__import__` function
instead, which takes the module name as a string:

```python title="0-main.py"
#!/usr/bin/env python3
greet = __import__('0-greetings').greet
print(greet("Grace"))
```

This is exactly how the Checker calls your functions. It imports your
file, picks out the function, and calls it with its own arguments. So
two things must be true of every task file:

1. The function must **return** what the task asks for, not print it,
   unless the task says to print.
2. Importing the file must produce **no output of its own**. Anything
   you add to test it goes under `if __name__ == "__main__":`.

!!! ai "AI in the loop"

    Before running a pair of files, ask an assistant to **predict** the
    output, and write your own prediction first. *"Here are
    `greetings.py` and `app.py`. What does `./app.py` print, line by
    line, and why?"* Then run it. When you, the assistant and Python
    disagree, you have found exactly the part of importing you need to
    understand better.

## When something goes wrong

??? note "My function prints the right thing, but the Checker says the result is `None`"

    The function prints instead of returning. Replace the `print(...)`
    inside it with `return ...`.

??? note "There is an extra `None` in my output"

    You printed the result of a function that already prints. Either
    call it without `print(...)`, or change the function to return.

??? note "`ModuleNotFoundError: No module named 'greetings'`"

    The file you import must be in the same folder as the file you run,
    and you write its name without `.py`. Check the spelling with `ls`.

??? note "Importing my file prints things or runs my tests"

    That code is at the top level. Move it under
    `if __name__ == "__main__":`.

??? note "`NameError: name 'count' is not defined` outside a function"

    `count` is local to the function. Return it, and store the returned
    value: `total = count_vowels(text)`.

## Explain it to someone

- [ ] How to define a function with parameters, defaults and a return value
- [ ] The difference between parameters and arguments
- [ ] The difference between `print` and `return`, and where a stray `None` comes from
- [ ] How to use conditionals and loops inside a function, and where `return` goes
- [ ] What happens when Python runs a file, and when a function's body runs
- [ ] What `__name__` contains when a file is run, and when it is imported
- [ ] Why `if __name__ == "__main__":` is needed
- [ ] How to import functions and variables from another file
- [ ] How Holberton test files import task files with `__import__`

## Quick reference

| Code | What it does |
|---|---|
| `def name(a, b=1):` | Define a function with a default for `b` |
| `return value` | End the function and give `value` back |
| `"""Docstring."""` | Describe the function; shown by `help(name)` |
| `from module import name` | Import one function or variable |
| `import module` | Import the module; use `module.name` |
| `__import__('0-file').name` | Import from a file whose name is not a valid identifier |
| `if __name__ == "__main__":` | Run this block only when the file is run directly |

## Next

Your functions take single values. Next, give them collections to work
with.

[Core Data Structures](data-structures.md){ .h-button }
