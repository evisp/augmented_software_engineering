# Exception Handling

<span class="badge badge--time">60 min</span>
<span class="badge badge--level">Python</span>
<span class="badge">Needs: Core Data Structures</span>

Programs fail. A user types letters where you expected a number, a list
is empty, a key is missing. An **exception** is how Python reports a
failure while the program is running. This tutorial shows you how to
read one, catch the ones you expect, raise your own, and write
functions that fail in a way their callers can rely on.

## Why this matters

There are two bad ways to deal with errors: ignore them, so the program
crashes on the first odd input, or swallow all of them, so it carries
on with wrong data and nobody knows why. Good code sits between the
two. It handles the failures it expects, in a precise and visible way,
and lets real bugs surface.

In the previous tutorial you prevented errors by **checking first**.
This one adds the other tool: **try it, and handle the failure**. You
need both.

## Step 1: Read a traceback

When an exception is not handled, Python stops and prints a
**traceback**. Most people read it from the top. Read it from the
bottom.

```python title="avg.py"
def average(numbers):
    return sum(numbers) / len(numbers)


print(average([4, 8]))
print(average([]))
```

```
6.0
Traceback (most recent call last):
  File "/home/you/holberton/python-basics/avg.py", line 6, in <module>
    print(average([]))
          ~~~~~~~^^^^
  File "/home/you/holberton/python-basics/avg.py", line 2, in average
    return sum(numbers) / len(numbers)
           ~~~~~~~~~~~~~^~~~~~~~~~~~~~
ZeroDivisionError: division by zero
```

1. **The last line** says *what* went wrong: the exception type,
   `ZeroDivisionError`, and a message.
2. **The frame above it** says *where*: line 2, inside `average`. The
   `^` marks point at the exact operation.
3. **The frames above that** say *how you got there*: line 6 called
   `average` with an empty list.

The fix is rarely on the last line of code shown. Here the division is
fine; the question is what `average` should do with an empty list.

## Step 2: Know the common exceptions

Each exception type names a different kind of mistake. Recognising them
on sight tells you where to look.

| Exception | Raised when | Example |
|---|---|---|
| `TypeError` | A value is the wrong type for the operation | `"3" + 4` |
| `ValueError` | The type is right but the value is not | `int("forty")` |
| `IndexError` | A list index is out of range | `[1, 2][5]` |
| `KeyError` | A dictionary key is missing | `{"a": 1}["b"]` |
| `ZeroDivisionError` | Dividing by zero | `10 / 0` |
| `NameError` | A name is not defined, often a typo | `prnt("hi")` |
| `AttributeError` | The object has no such method or attribute | `"text".push("x")` |
| `FileNotFoundError` | A file to open does not exist | `open("missing.txt")` |

## Step 3: Catch a specific exception

Put the code that might fail in a `try` block, and say what to do if it
fails in an `except` block naming the exception:

```python
def ratio(a, b):
    try:
        return a / b
    except ZeroDivisionError:
        print("b must not be zero")
    except TypeError:
        print("a and b must be numbers")
    return None


ratio(6, 3)       # 2.0
ratio(6, 0)       # prints "b must not be zero", returns None
ratio("6", 3)     # prints "a and b must be numbers", returns None
```

Python runs the `try` block. If an exception is raised, it jumps
straight to the first `except` that matches the type, and the rest of
the `try` block is skipped. If none matches, the exception carries on
up to the caller as if there were no `try` at all.

To use the error message, name the exception with `as`:

```python
try:
    value = settings["timeout"]
except KeyError as e:
    print(f"Missing key: {e}")       # Missing key: 'timeout'
```

You can catch several types in one clause with a tuple:
`except (TypeError, ValueError) as e:`.

### Why catch specific exceptions

It is tempting to write `except Exception:` and catch everything. Look
at what it hides:

```python
prices = {"apple": 0.5}
try:
    total = prices["aple"] * quantity
except Exception:
    total = 0
```

`total` is `0` and nothing complains, yet there are two bugs: a typo in
the key and a variable, `quantity`, that might not exist. A broad
`except` turns bugs into silent wrong answers, which are far harder to
find than a crash.

**Catch only the exceptions you expect, and know what you will do about
each.** A bare `except:` with no type is worse still: it even catches
++ctrl+c++, so you cannot stop the program.

Keep the `try` block small, too. Wrap only the line that can fail in
the way you expect, not the whole function.

## Step 4: `else` and `finally`

A `try` statement can have two more parts.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 236" role="img" aria-labelledby="ex-flow-title ex-flow-desc">
<title id="ex-flow-title">How try, except, else and finally run</title>
<desc id="ex-flow-desc">Python runs the try block. If no exception is raised, the else block runs. If a matching exception is raised, its except block runs. If an exception is raised that no except clause matches, neither runs. In all three cases the finally block runs next. Then the program continues after the try statement, except in the unmatched case, where the exception goes on to the caller.</desc>
<defs><marker id="ex-flow-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<rect x="3" y="93" width="110" height="50" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="58" y="123" text-anchor="middle" font-size="14" font-weight="700" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">try</text>
<g font-family="var(--md-code-font-family, monospace)" font-size="13" font-weight="700" text-anchor="middle">
<rect x="262" y="14" width="160" height="44" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="342" y="41" fill="var(--h-fig-text)">else</text>
<rect x="262" y="96" width="160" height="44" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="342" y="123" fill="var(--h-fig-text)">except ValueError</text>
<rect x="262" y="178" width="160" height="44" rx="10" fill="none" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<text x="342" y="205" fill="var(--h-fig-muted)" font-weight="600">(nothing matches)</text>
<rect x="470" y="14" width="96" height="208" rx="12" fill="var(--h-cherry)"/>
<text x="518" y="112" fill="#ffffff">finally</text>
</g>
<text x="518" y="134" text-anchor="middle" font-size="11" fill="#ffffff" opacity="0.9">always runs</text>
<g stroke="var(--h-fig-line)" stroke-width="2" fill="none">
<polyline points="117,108 180,36 256,36" marker-end="url(#ex-flow-arrow)"/>
<polyline points="117,118 256,118" marker-end="url(#ex-flow-arrow)"/>
<polyline points="117,128 180,200 256,200" marker-end="url(#ex-flow-arrow)"/>
<line x1="426" y1="36" x2="464" y2="36" marker-end="url(#ex-flow-arrow)"/>
<line x1="426" y1="118" x2="464" y2="118" marker-end="url(#ex-flow-arrow)"/>
<line x1="426" y1="200" x2="464" y2="200" marker-end="url(#ex-flow-arrow)"/>
<line x1="570" y1="76" x2="600" y2="76" marker-end="url(#ex-flow-arrow)"/>
<line x1="570" y1="200" x2="600" y2="200" marker-end="url(#ex-flow-arrow)"/>
</g>
<g font-size="11" font-weight="600" fill="var(--h-fig-muted)">
<text x="132" y="62">no error</text>
<text x="150" y="112">ValueError</text>
<text x="132" y="184">other error</text>
</g>
<text x="606" y="72" font-size="11.5" font-weight="600" fill="var(--h-fig-text)">carry on</text>
<text x="606" y="88" font-size="11" fill="var(--h-fig-muted)">after try</text>
<text x="606" y="196" font-size="11.5" font-weight="600" fill="var(--h-cherry)">error goes</text>
<text x="606" y="212" font-size="11" fill="var(--h-cherry)">to the caller</text>
</svg>
</figure>

- **`else`** runs only if the `try` block raised **no** exception. Put
  the code that depends on the `try` succeeding here, instead of inside
  the `try`, so that an error in it is not mistaken for the one you are
  catching.
- **`finally`** runs **no matter what**: after success, after a handled
  exception, after an unhandled one, even after a `return`. Use it for
  clean-up that must always happen, such as closing a file or a
  connection, or reporting that a step finished.

```python
def parse_age(text):
    try:
        age = int(text)
    except ValueError:
        print(f"Not a number: {text!r}")
        return None
    else:
        print(f"Parsed {age}")
        return age
    finally:
        print("Done checking")


parse_age("42")
parse_age("forty")
```

```
Parsed 42
Done checking
Not a number: 'forty'
Done checking
```

Notice that `Done checking` prints even though both branches have
already reached a `return`. `finally` runs on the way out of the
function, before the value is handed back.

## Step 5: Raise exceptions yourself

Your own functions can raise exceptions too. Do it when the caller
passed something your function cannot sensibly handle. Silently
returning a made-up value would hide their mistake.

```python
def set_age(age):
    """Return age if it is valid; raise otherwise."""
    if not isinstance(age, int):
        raise TypeError("age must be an integer")
    if age < 0:
        raise ValueError("age must not be negative")
    return age
```

Pick the type that describes the problem, `TypeError` for the wrong
kind of value and `ValueError` for a wrong value of the right kind, and
write a message that says what was expected. The caller can then catch
exactly that:

```python
for value in [30, -1, "30"]:
    try:
        print(set_age(value))
    except (TypeError, ValueError) as e:
        print(f"{type(e).__name__}: {e}")
```

```
30
ValueError: age must not be negative
TypeError: age must be an integer
```

Inside an `except` block, a bare `raise` re-raises the exception you
caught. Use it to note that something failed, for example by printing a
message, while still letting the caller decide what to do about it.

## Step 6: Fail safely and predictably

A function **fails safely** when bad input never crashes the program
unexpectedly and never produces a wrong answer that looks right. It
**fails predictably** when the caller knows in advance what happens on
failure, because the docstring says so.

There are two honest designs. Choose one per function and document it.

=== "Return None"

    Catch the expected exceptions, report them on standard error, and
    return `None`. Good when failure is normal and the caller just needs
    to know there is no answer.

    ```python
    import sys


    def safe_average(numbers):
        """Return the average of numbers, or None if it cannot be computed."""
        try:
            return sum(numbers) / len(numbers)
        except ZeroDivisionError:
            print("Cannot average an empty list", file=sys.stderr)
        except TypeError:
            print("All items must be numbers", file=sys.stderr)
        return None
    ```

=== "Raise an exception"

    Check the input and raise a specific exception with a helpful
    message. Good when bad input is the caller's mistake and they should
    fix it, not carry on.

    ```python
    def average(numbers):
        """Return the average of numbers.

        Raises ValueError if numbers is empty.
        """
        if not numbers:
            raise ValueError("numbers must not be empty")
        return sum(numbers) / len(numbers)
    ```

`print(..., file=sys.stderr)` sends a message to **standard error**
instead of standard output. Both appear in your terminal, but they are
separate streams: anyone redirecting your program's output to a file,
or a Checker comparing it, sees only the real output, not your error
messages.

What a safe function must never do: return a value that *looks* valid
when it is not, such as `0` for the average of nothing, or catch
everything and carry on as if nothing happened.

!!! ai "AI in the loop"

    Paste a full traceback into an assistant and ask it to *walk you
    through it from the bottom*: which line failed, with what values,
    and how the program got there. Then ask *"what inputs would make
    this function raise, and which of those should it handle?"* Decide
    the answer to the second question yourself. That decision is the
    design of your function.

## When something goes wrong

??? note "My `except` block never runs"

    The exception raised is a different type from the one you catch.
    Read the last line of the traceback and catch that exact type.

??? note "The program keeps going with a wrong result, and I cannot see why"

    Look for a broad `except Exception:` or bare `except:`. Narrow it
    to the exception you expect, and the real bug will show itself.

??? note "My error message appears in the output and the Checker fails"

    Print error messages to standard error:
    `print("message", file=sys.stderr)`, with `import sys` at the top.

??? note "`finally` printed something I did not expect"

    `finally` always runs, including after a `return` in `try`,
    `except` or `else`. Move code that should run only on success into
    `else`.

## Explain it to someone

- [ ] What an exception is, and how to read a traceback from the bottom
- [ ] When `TypeError`, `ValueError`, `IndexError`, `KeyError` and `ZeroDivisionError` are raised
- [ ] How `try` and `except` work, and what happens when no `except` matches
- [ ] Why you catch specific exceptions instead of `Exception` or a bare `except:`
- [ ] What `else` and `finally` are for, and when each runs
- [ ] How and when to raise an exception yourself, with a useful message
- [ ] The two ways a function can fail safely, and how to choose between them
- [ ] Why error messages go to standard error

## Quick reference

| Code | What it does |
|---|---|
| `try:` / `except ValueError:` | Run code, handle one kind of failure |
| `except (TypeError, ValueError) as e:` | Handle several kinds; `e` holds the message |
| `else:` | Runs only if `try` raised nothing |
| `finally:` | Always runs, last |
| `raise ValueError("message")` | Signal a failure yourself |
| `raise` | Inside `except`: re-raise the current exception |
| `print(msg, file=sys.stderr)` | Write to standard error |
| `isinstance(x, int)` | Check a value's type before using it |

## Next

You have finished Python Fundamentals: you can write programs that
decide, repeat, organise themselves into functions and modules, work
with collections, and handle failure. Next, model problems with classes.

[Object-Oriented Design](../oop/index.md){ .h-button }
