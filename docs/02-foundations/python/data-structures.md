# Core Data Structures

<span class="badge badge--time">90 min</span>
<span class="badge badge--level">Python</span>
<span class="badge">Needs: Functions & Modularity</span>

Real programs work with collections: a list of users, a grid of
values, a set of tags, a table of prices. Python has four built-in
collections, and each is good at one thing. This tutorial covers all
four, how to use them without crashing on unexpected input, and the
one behaviour that surprises everyone: two names for the same list.

## Why this matters

Choosing the right collection makes code shorter, faster and easier to
read. Checking whether a word is in a set of ten thousand words is
instant; in a list, Python checks them one by one.

The other half of this page is about **edge cases**: empty lists,
missing keys, repeated values, indices that do not exist. Your code
will meet all of them, because real data is messy and the Checker
tests with exactly these inputs on purpose.

## The four collections

| | Example | Ordered | Changeable | Duplicates | Use it for |
|---|---|---|---|---|---|
| **list** | `[3, 1, 3]` | yes | yes | yes | A sequence you add to, change and loop over |
| **tuple** | `(3, 4)` | yes | no | yes | A fixed group of values, such as a point or several return values |
| **set** | `{1, 3}` | no | yes | no | Unique items, membership tests, comparing groups |
| **dict** | `{"a": 1}` | yes | yes | keys: no | Looking values up by a key |

## Step 1: Lists

A **list** is an ordered, changeable sequence. Indexing and slicing work
exactly as they do on strings.

```python
langs = ["python", "c", "javascript"]
langs[0]               # 'python'
langs[-1]              # 'javascript'
len(langs)             # 3

langs.append("sql")    # add to the end
langs.insert(1, "bash")
langs.pop()            # remove and return the last item: 'sql'
langs.remove("c")      # remove the first "c"
"go" in langs          # False
```

Unlike strings, lists are **mutable**: `append`, `insert`, `pop` and
`remove` change the list itself and return nothing useful (except
`pop`). Compare two ways to sort:

```python
nums = [3, 1, 2]
s = sorted(nums)       # a NEW sorted list; nums is unchanged
nums.sort()            # sorts nums itself; returns None
```

`new_list = old_list.sort()` is a common bug: `new_list` is `None`.

### Loop with or without the index

```python
for lang in langs:                 # when you only need the items
    print(lang)

for i in range(len(langs)):        # when you need the position too
    print(i, langs[i])
```

## Step 2: Two names, one list

This is the behaviour behind most list bugs.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 210" role="img" aria-labelledby="ds-alias-title ds-alias-desc">
<title id="ds-alias-title">Assignment shares a list; copy makes a new one</title>
<desc id="ds-alias-desc">After b equals a, both names point to the same list object, so appending through b also changes what a shows. After c equals a dot copy, c points to a separate new list, so changing c leaves a alone.</desc>
<defs><marker id="ds-alias-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker>
<marker id="ds-alias-arrow-c" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-cherry)"/></marker></defs>
<text x="3" y="20" font-size="12" font-weight="700" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">b = a</text>
<text x="3" y="38" font-size="11" fill="var(--h-fig-muted)">two names, one list</text>
<g font-family="var(--md-code-font-family, monospace)" font-size="14" font-weight="700">
<rect x="20" y="58" width="44" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="42" y="80" text-anchor="middle" fill="var(--h-fig-text)">a</text>
<rect x="20" y="118" width="44" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="42" y="140" text-anchor="middle" fill="var(--h-fig-text)">b</text>
<rect x="150" y="86" width="150" height="38" rx="8" fill="var(--h-cherry)"/><text x="225" y="110" text-anchor="middle" fill="#ffffff">[1, 2, 3, 4]</text>
</g>
<line x1="68" y1="75" x2="144" y2="98" stroke="var(--h-cherry)" stroke-width="2" marker-end="url(#ds-alias-arrow-c)"/>
<line x1="68" y1="135" x2="144" y2="113" stroke="var(--h-cherry)" stroke-width="2" marker-end="url(#ds-alias-arrow-c)"/>
<text x="20" y="186" font-size="11.5" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">b.append(4)  →  a is [1, 2, 3, 4] too</text>
<line x1="340" y1="8" x2="340" y2="200" stroke="var(--h-fig-line)" opacity="0.5"/>
<text x="370" y="20" font-size="12" font-weight="700" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">c = a.copy()</text>
<text x="370" y="38" font-size="11" fill="var(--h-fig-muted)">two names, two lists</text>
<g font-family="var(--md-code-font-family, monospace)" font-size="14" font-weight="700">
<rect x="387" y="58" width="44" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="409" y="80" text-anchor="middle" fill="var(--h-fig-text)">a</text>
<rect x="387" y="118" width="44" height="34" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="409" y="140" text-anchor="middle" fill="var(--h-fig-text)">c</text>
<rect x="500" y="56" width="170" height="38" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/><text x="585" y="80" text-anchor="middle" fill="var(--h-fig-text)">[1, 2, 3, 4]</text>
<rect x="500" y="116" width="170" height="38" rx="8" fill="var(--h-cherry)"/><text x="585" y="140" text-anchor="middle" fill="#ffffff">[1, 2, 3, 4, 5]</text>
</g>
<line x1="435" y1="75" x2="494" y2="75" stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#ds-alias-arrow)"/>
<line x1="435" y1="135" x2="494" y2="135" stroke="var(--h-cherry)" stroke-width="2" marker-end="url(#ds-alias-arrow-c)"/>
<text x="387" y="186" font-size="11.5" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">c.append(5)  →  a is unchanged</text>
</svg>
</figure>

A variable does not hold a list. It *points to* one. `b = a` does not
copy anything; it gives the same list a second name.

```python
a = [1, 2, 3]
b = a
b.append(4)
print(a)        # [1, 2, 3, 4]  a changed too: it is the same list

c = a.copy()    # a.copy(), a[:] and list(a) all make a new list
c.append(5)
print(a)        # [1, 2, 3, 4]  unchanged
print(c)        # [1, 2, 3, 4, 5]
```

The same thing happens when you pass a list to a function. The
parameter is another name for the caller's list, so a function that
changes it changes the caller's data:

```python
def add_bonus(scores):           # changes the list it was given
    for i in range(len(scores)):
        scores[i] += 5


def with_bonus(scores):          # builds and returns a new list
    return [s + 5 for s in scores]


marks = [70, 85]
new = with_bonus(marks)          # marks is still [70, 85]; new is [75, 90]
add_bonus(marks)                 # marks is now [75, 90]
```

Both are valid. What matters is that the function's name and docstring
make clear which one it does. When a task says *without modifying the
original*, build and return a new collection.

### Build a new list with a comprehension

The `with_bonus` function used a **list comprehension**: a short way to
build a new list from an existing one.

```python
[n * 2 for n in [1, 2, 3]]                 # [2, 4, 6]
[n for n in [4, 7, 10, 13] if n % 2 == 0]  # [4, 10]  only the even ones
```

Read it as "*this expression*, for each item, if *this condition*". It
never changes the original list.

## Step 3: Access elements safely

`items[i]` raises an `IndexError` when `i` is out of range. When a
function should cope with bad input instead of crashing, check first:

```python
def item_at(items, index):
    """Return the item at index, or None if there is none."""
    if index < 0 or index >= len(items):
        return None
    return items[index]


item_at(["a", "b"], 1)     # 'b'
item_at(["a", "b"], 5)     # None
item_at([], 0)             # None: the empty list is handled too
```

Note the decision to reject negative indices. Python would accept
`items[-1]`, but if the task defines index as a position counted from
0, a negative number is invalid input. Read what the task means by
*valid*, then check exactly that.

The same idea, without changing the original:

```python
def replaced(items, index, value):
    """Return a copy of items with one element replaced."""
    copy = items[:]
    if 0 <= index < len(items):
        copy[index] = value
    return copy
```

## Step 4: Matrices

A **matrix** is a list of lists: each inner list is a row.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 196" role="img" aria-labelledby="ds-mx-title ds-mx-desc">
<title id="ds-mx-title">A matrix as a list of rows</title>
<desc id="ds-mx-desc">grid has two rows and three columns. grid at 0 is the row 1, 2, 3; grid at 1 is the row 4, 5, 6. grid at 1, 2 picks row 1, then column 2 inside it, which is 6. The outer loop goes over rows and the inner loop over the numbers in each row.</desc>
<g font-size="11.5" font-weight="700" text-anchor="middle" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">
<text x="200" y="22">col 0</text><text x="270" y="22">col 1</text><text x="340" y="22">col 2</text>
<text x="104" y="68" text-anchor="end">grid[0]</text>
<text x="104" y="128" text-anchor="end">grid[1]</text>
</g>
<g font-family="var(--md-code-font-family, monospace)" font-size="18" font-weight="700" text-anchor="middle">
<rect x="170" y="36" width="60" height="50" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="200" y="68" fill="var(--h-fig-text)">1</text>
<rect x="240" y="36" width="60" height="50" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="270" y="68" fill="var(--h-fig-text)">2</text>
<rect x="310" y="36" width="60" height="50" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="340" y="68" fill="var(--h-fig-text)">3</text>
<rect x="170" y="96" width="60" height="50" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="200" y="128" fill="var(--h-fig-text)">4</text>
<rect x="240" y="96" width="60" height="50" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="270" y="128" fill="var(--h-fig-text)">5</text>
<rect x="310" y="96" width="60" height="50" rx="8" fill="var(--h-cherry)"/><text x="340" y="128" fill="#ffffff">6</text>
</g>
<rect x="160" y="30" width="220" height="62" rx="12" fill="none" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="160" y="90" width="220" height="62" rx="12" fill="none" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<text x="420" y="104" font-size="14" font-weight="700" fill="var(--h-cherry)" font-family="var(--md-code-font-family, monospace)">grid[1][2] → 6</text>
<text x="420" y="126" font-size="11.5" fill="var(--h-fig-muted)">row 1 first, then column 2</text>
<text x="420" y="56" font-size="11.5" fill="var(--h-fig-muted)">each row is a list</text>
<text x="420" y="72" font-size="11.5" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">len(grid) = 2, len(grid[0]) = 3</text>
<text x="270" y="186" text-anchor="middle" font-size="12" font-weight="600" fill="var(--h-fig-text)">outer loop: rows · inner loop: numbers in the row</text>
</svg>
</figure>

```python
grid = [[1, 2, 3],
        [4, 5, 6]]

grid[1][2]     # 6: row 1, then column 2
len(grid)      # 2 rows
len(grid[0])   # 3 columns
```

To print it, loop over rows, and over the numbers in each row. The
cleanest way to put exactly one space *between* numbers, and none at
the end, is `join`, which glues strings together with a separator:

```python
for row in grid:
    print(" ".join(str(n) for n in row))
```

```
1 2 3
4 5 6
```

`join` only accepts strings, so each number is converted with `str`
first, or with an f-string such as `f"{n:2}"` to align columns. A
comprehension inside a comprehension builds a new matrix and leaves the
original alone:

```python
times_ten = [[n * 10 for n in row] for row in grid]
# [[10, 20, 30], [40, 50, 60]]; grid is unchanged
```

Edge case: an empty matrix, `[[]]`, has one row with no numbers. The
loop above prints one empty line, which is usually exactly what the
task expects.

## Step 5: Tuples

A **tuple** is like a list that cannot be changed. Use one for a fixed
group of values that belong together.

```python
point = (3, 4)
x, y = point          # unpacking: x is 3, y is 4
point[0] = 1          # TypeError: tuples cannot be changed
x, y = y, x           # swap two variables in one line
```

Tuples are the clean way to **return several values** from a function.
`return a, b` returns a tuple, and the caller unpacks it:

```python
def min_max(numbers):
    """Return the smallest and largest number, or (None, None) if empty."""
    if not numbers:
        return None, None
    return min(numbers), max(numbers)


low, high = min_max([4, 9, 1])    # low is 1, high is 9
min_max([])                       # (None, None)
```

Notice the empty case returns the **same shape**: two values. The
caller can always write `low, high = min_max(...)` without checking
first. Returning a single `None` there would crash the unpacking.

## Step 6: Sets

A **set** holds unique values, in no particular order. Its strength is
comparing groups.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 220" role="img" aria-labelledby="ds-set-title ds-set-desc">
<title id="ds-set-title">Intersection and symmetric difference of two sets</title>
<desc id="ds-set-desc">Alice knows python, git and sql. Bob knows git, javascript and python. The intersection, alice and bob, is the overlap: git and python. The symmetric difference, alice caret bob, is everything in exactly one of the two sets: sql and javascript.</desc>
<g opacity="0.95">
<circle cx="120" cy="104" r="78" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-width="1.5"/>
<circle cx="210" cy="104" r="78" fill="none" stroke="var(--h-fig-line)" stroke-width="1.5"/>
<path d="M165 40.5 A78 78 0 0 1 165 167.5 A78 78 0 0 1 165 40.5 Z" fill="var(--h-cherry)"/>
</g>
<text x="80" y="20" text-anchor="middle" font-size="12" font-weight="700" fill="var(--h-fig-text)">alice</text>
<text x="250" y="20" text-anchor="middle" font-size="12" font-weight="700" fill="var(--h-fig-text)">bob</text>
<g font-family="var(--md-code-font-family, monospace)" font-size="12" text-anchor="middle">
<text x="92" y="108" fill="var(--h-fig-text)">sql</text>
<text x="165" y="96" fill="#ffffff" font-weight="700">git</text>
<text x="165" y="116" fill="#ffffff" font-weight="700">python</text>
<text x="246" y="108" fill="var(--h-fig-text)">javascript</text>
</g>
<text x="165" y="206" text-anchor="middle" font-size="12" font-weight="700" fill="var(--h-cherry)" font-family="var(--md-code-font-family, monospace)">alice &amp; bob</text>
<g opacity="0.95">
<circle cx="460" cy="104" r="78" fill="var(--h-cherry)"/>
<circle cx="550" cy="104" r="78" fill="var(--h-cherry)"/>
<path d="M505 40.5 A78 78 0 0 1 505 167.5 A78 78 0 0 1 505 40.5 Z" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)" stroke-width="1.5"/>
</g>
<text x="420" y="20" text-anchor="middle" font-size="12" font-weight="700" fill="var(--h-fig-text)">alice</text>
<text x="590" y="20" text-anchor="middle" font-size="12" font-weight="700" fill="var(--h-fig-text)">bob</text>
<g font-family="var(--md-code-font-family, monospace)" font-size="12" text-anchor="middle">
<text x="432" y="108" fill="#ffffff" font-weight="700">sql</text>
<text x="505" y="96" fill="var(--h-fig-muted)">git</text>
<text x="505" y="116" fill="var(--h-fig-muted)">python</text>
<text x="586" y="108" fill="#ffffff" font-weight="700">javascript</text>
</g>
<text x="505" y="206" text-anchor="middle" font-size="12" font-weight="700" fill="var(--h-cherry)" font-family="var(--md-code-font-family, monospace)">alice ^ bob</text>
</svg>
</figure>

```python
alice = {"python", "git", "sql"}
bob = {"git", "javascript", "python"}

alice & bob     # intersection:         {'git', 'python'}   in both
alice | bob     # union:                all four            in either
alice - bob     # difference:           {'sql'}             only in alice
alice ^ bob     # symmetric difference: {'javascript', 'sql'}  in exactly one
```

Sets also remove duplicates: `set([3, 1, 3, 2, 1])` is `{1, 2, 3}`, and
`len(set(items))` counts the distinct values in a list.

!!! warning "Sets have no order"

    Printing a set can show its items in any order, and the order may
    change between runs. When output must be exact, sort it first:
    `sorted(alice & bob)` always gives `['git', 'python']`.

## Step 7: Dictionaries

A **dictionary** maps keys to values. You look a value up by its key,
not by a position.

```python
stock = {"apples": 5, "pears": 2}

stock["apples"]          # 5
stock["kiwis"]           # KeyError: 'kiwis'
stock.get("kiwis")       # None: no error
stock.get("kiwis", 0)    # 0: a default of your choice
"pears" in stock         # True: `in` checks keys

stock["kiwis"] = 7       # add a new key
stock["apples"] += 1     # update an existing one
del stock["pears"]       # remove a key (KeyError if it is missing)
```

Loop over keys, or over keys and values together. For exact output,
sort the keys:

```python
for name in sorted(stock):
    print(f"{name}: {stock[name]}")

for name, qty in stock.items():
    ...
```

```
apples: 6
kiwis: 7
```

A dictionary is the natural way to **count repeated values**. Use
`get` with a default of `0`, so the first time a word appears is not a
special case:

```python
words = ["git", "python", "git", "sql", "git"]
counts = {}
for word in words:
    counts[word] = counts.get(word, 0) + 1
# {'git': 3, 'python': 1, 'sql': 1}
```

## Step 8: Think about edge cases first

Before you write a function, list the awkward inputs and decide what it
should do with each. Most failed checks are one of these.

| Input | Question to ask | Usual answer |
|---|---|---|
| Empty list `[]` | What is the max of nothing? | Return `None`, or the documented default |
| Index out of range, or negative | Crash, or return something? | Check bounds; follow the task |
| Missing key | `d[key]` or `d.get(key)`? | `get` with a default when missing is normal |
| Repeated values | Count them, or once each? | `dict` to count, `set` to deduplicate |
| `None` passed instead of a list | Is that valid input? | Check `if items is None` if the task allows it |
| Original must not change | Am I mutating it? | Build and return a new collection |

Then test the function with each of them, not only with the friendly
example from the task.

!!! ai "AI in the loop"

    Assistants are good at finding edge cases you missed. Write your
    function first, then ask: *"List inputs that could break this
    function or make it return something unexpected. Don't fix the
    code."* Test each one yourself. Asking for the cases rather than
    the fix keeps the reasoning on your side.

## When something goes wrong

??? note "My original list changed and I did not touch it"

    Somewhere you have two names for one list: an assignment such as
    `b = a`, or a function that modifies its parameter. Copy with
    `a[:]` or `a.copy()`, or build a new list.

??? note "`AttributeError: 'NoneType' object has no attribute ...`"

    You stored the result of a method that changes a list in place,
    such as `nums = nums.sort()`. Use `nums.sort()` on its own line, or
    `nums = sorted(nums)`.

??? note "`KeyError` with a dictionary"

    The key is not there. Check with `key in d`, or read it with
    `d.get(key, default)`.

??? note "My set output is in a different order from the expected output"

    Sets have no order. Sort before printing.

??? note "`TypeError: sequence item 0: expected str instance, int found`"

    `join` needs strings. Convert each item: `" ".join(str(n) for n in row)`.

## Explain it to someone

- [ ] When to use a list, a tuple, a set and a dictionary
- [ ] How to loop over a list and a matrix and print exact, formatted output
- [ ] How to read or change a list element without risking an `IndexError`
- [ ] Why `b = a` does not copy a list, and three ways that do
- [ ] How to return a new collection instead of changing the input
- [ ] How to return several values with a tuple, and unpack them
- [ ] How to compute an intersection and a symmetric difference with sets
- [ ] How to add, update, read and delete dictionary entries, safely
- [ ] How you handle empty inputs, missing keys and repeated values

## Quick reference

| Code | What it does |
|---|---|
| `lst.append(x)`, `lst.pop()` | Add to the end / remove the last |
| `sorted(lst)` vs `lst.sort()` | New sorted list / sort in place, returns `None` |
| `lst.copy()`, `lst[:]` | A new list with the same items |
| `[f(x) for x in lst if cond]` | Build a new list |
| `" ".join(str(x) for x in row)` | Items joined by single spaces |
| `return a, b` / `a, b = f()` | Return several values / unpack them |
| `s1 & s2`, `s1 ^ s2` | Intersection / symmetric difference |
| `d.get(k, default)` | Read a key without a `KeyError` |
| `d[k] = d.get(k, 0) + 1` | Count occurrences |
| `for k in sorted(d):` | Loop over keys in a fixed order |

## Next

Your functions now handle awkward input by checking for it. Next, learn
what to do when something fails anyway.

[Exception Handling](exceptions.md){ .h-button }
