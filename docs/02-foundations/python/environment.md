# Environment & First Programs

<span class="badge badge--time">45 min</span>
<span class="badge badge--level">Python</span>
<span class="badge">Needs: WSL, VS Code</span>

Before you write real programs, you need to know the two ways Python
runs code, how to turn a file into a program you can run like any
other command, and how to keep each project's packages separate. This
tutorial covers all three.

## Why this matters

Most beginner confusion in Python is not about the language. It is
about the environment: code that prints in one place and not another,
a package that is installed but "not found", a script that works on
your laptop and fails on the Checker. Each of those has a simple cause,
and you will meet all of them in this tutorial on purpose.

## Two ways to run Python

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 210" role="img" aria-labelledby="py-modes-title py-modes-desc">
<title id="py-modes-title">Interactive mode compared with a script</title>
<desc id="py-modes-desc">In interactive mode you type one line at a time after the three-arrow prompt, and Python shows the value of every expression automatically: typing 2 plus 3 shows 5. In a script, Python runs the whole file from top to bottom and shows nothing unless you call print: the line 2 plus 3 produces no output, and print of 2 plus 3 prints 5.</desc>
<rect x="3" y="10" width="326" height="190" rx="12" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="22" y="38" font-size="11" font-weight="700" fill="var(--h-fig-muted)">INTERACTIVE MODE</text>
<text x="22" y="58" font-size="13.5" font-weight="700" fill="var(--h-fig-text)">python3</text>
<g font-family="var(--md-code-font-family, monospace)" font-size="13">
<text x="22" y="96" fill="var(--h-fig-muted)">&gt;&gt;&gt; <tspan fill="var(--h-fig-text)">2 + 3</tspan></text>
<text x="22" y="118" fill="var(--h-cherry)" font-weight="700">5</text>
<text x="22" y="146" fill="var(--h-fig-muted)">&gt;&gt;&gt; <tspan fill="var(--h-fig-text)">x = 10</tspan></text>
<text x="22" y="174" fill="var(--h-fig-muted)">&gt;&gt;&gt; <tspan fill="var(--h-fig-text)">x * 2</tspan></text>
<text x="22" y="194" fill="var(--h-cherry)" font-weight="700">20</text>
</g>
<text x="190" y="118" font-size="11" fill="var(--h-fig-muted)">value shown for you</text>
<text x="190" y="146" font-size="11" fill="var(--h-fig-muted)">statement: no output</text>
<rect x="351" y="10" width="326" height="190" rx="12" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="370" y="38" font-size="11" font-weight="700" fill="var(--h-fig-muted)">SCRIPT</text>
<text x="370" y="58" font-size="13.5" font-weight="700" fill="var(--h-fig-text)">./calc.py</text>
<g font-family="var(--md-code-font-family, monospace)" font-size="13">
<text x="370" y="96" fill="var(--h-fig-text)">2 + 3</text>
<text x="370" y="124" fill="var(--h-fig-text)"><tspan fill="var(--h-cherry)">print</tspan>(2 + 3)</text>
<line x1="370" y1="148" x2="658" y2="148" stroke="var(--h-fig-line)"/>
<text x="370" y="174" fill="var(--h-fig-muted)">$ ./calc.py</text>
<text x="370" y="194" fill="var(--h-cherry)" font-weight="700">5</text>
</g>
<text x="500" y="96" font-size="11" fill="var(--h-fig-muted)">computed, then thrown away</text>
<text x="500" y="124" font-size="11" fill="var(--h-fig-muted)">printed</text>
</svg>
</figure>

**Interactive mode** is for trying things. You type one line, Python
runs it and shows you the result straight away. **A script** is a file
Python runs from top to bottom. It is what you submit for projects, and
it shows only what you explicitly `print`.

## Step 1: Use the interpreter

Open the Ubuntu terminal and start the interpreter:

```bash
python3
```

```
Python 3.12.3 (main, ...) [GCC 13.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

The `>>>` is Python's prompt, the same idea as the shell's `$`. Leave
with `exit()` or ++ctrl+d++.

### Expressions and statements

Python code is made of two kinds of thing.

- An **expression** produces a value: `2 + 3`, `"hi".upper()`,
  `len("abc")`, `x * 2`.
- A **statement** does something: `x = 10` stores a value,
  `import math` loads a module, `if` and `for` control what runs.

In interactive mode, when you type an expression on its own, Python
shows its value. When you type a statement, it shows nothing, because
there is no value to show. Predict each line, then try it:

| You type | Python shows | Why |
|---|---|---|
| `7 * 6` | `42` | Expression: value shown |
| `answer = 7 * 6` | nothing | Assignment is a statement |
| `answer` | `42` | Expression: value shown |
| `"python".upper()` | `'PYTHON'` | Expression, shown as Python writes it, with quotes |
| `print("python".upper())` | `PYTHON` | `print` writes the text itself, no quotes |
| `import math` | nothing | Statement |
| `math.sqrt(16)` | `4.0` | Expression |

Look closely at the fourth and fifth rows. The interpreter shows a
value the way you would type it in code (`'PYTHON'`, with quotes).
`print` shows it the way a person would read it (`PYTHON`). In a script
only the second kind of output exists.

!!! tip "Ask Python, not Google"

    The interpreter has its own manual. `help(str)` describes every
    string method, `help(print)` describes `print`, and `dir("text")`
    lists everything you can call on a string. Press ++q++ to leave a
    help page.

## Step 2: Write a portable, executable script

Make a folder for this module and a first script:

```bash
mkdir -p ~/holberton/python-basics
cd ~/holberton/python-basics
code calc.py
```

```python title="calc.py"
#!/usr/bin/env python3
2 + 3
print(2 + 3)
```

Make it executable and run it:

```bash
chmod u+x calc.py
./calc.py
```

You see `5` once. The bare `2 + 3` was calculated and thrown away,
because a script never shows values on its own.

### Why `#!/usr/bin/env python3`

The first line is the shebang you met in [Shell Basics](../../01-tools/shell.md#write-your-first-script).
You could write `#!/usr/bin/python3`, but that only works on machines
where Python lives at exactly that path. `/usr/bin/env python3` asks
the system to find `python3` wherever it is installed, including inside
the virtual environment you build in Step 4. That is what makes the
script **portable**.

An executable script needs three things: the shebang on the first line,
execute permission from `chmod u+x`, and Unix line endings (see
[When something goes wrong](#when-something-goes-wrong)).

## Step 3: Global installs and isolated environments

`pip` installs Python packages. The question is *where*.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 236" role="img" aria-labelledby="py-venv-title py-venv-desc">
<title id="py-venv-title">Global installation compared with virtual environments</title>
<desc id="py-venv-desc">With a global installation, every project shares one set of packages in the system Python, so project A needing version 1 of a library and project B needing version 2 conflict. With virtual environments, each project has its own dot venv folder with its own packages, so the two versions live side by side and the system Python stays clean.</desc>
<text x="3" y="20" font-size="11" font-weight="700" fill="var(--h-fig-muted)">GLOBAL: ONE SHARED SET</text>
<rect x="3" y="32" width="320" height="64" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="22" y="58" font-size="13" font-weight="700" fill="var(--h-fig-text)">System Python</text>
<text x="22" y="80" font-size="11.5" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">requests 1.x or 2.x?</text>
<rect x="3" y="122" width="150" height="56" rx="10" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)"/>
<text x="78" y="146" text-anchor="middle" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">project A</text>
<text x="78" y="164" text-anchor="middle" font-size="11" fill="var(--h-fig-muted)">needs 1.x</text>
<rect x="173" y="122" width="150" height="56" rx="10" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)"/>
<text x="248" y="146" text-anchor="middle" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">project B</text>
<text x="248" y="164" text-anchor="middle" font-size="11" fill="var(--h-fig-muted)">needs 2.x</text>
<line x1="78" y1="122" x2="120" y2="98" stroke="var(--h-fig-line)" stroke-width="2"/>
<line x1="248" y1="122" x2="206" y2="98" stroke="var(--h-fig-line)" stroke-width="2"/>
<text x="163" y="210" text-anchor="middle" font-size="12" font-weight="700" fill="var(--h-cherry)">conflict: only one version fits</text>
<text x="357" y="20" font-size="11" font-weight="700" fill="var(--h-fig-muted)">ISOLATED: ONE VENV PER PROJECT</text>
<rect x="357" y="32" width="320" height="40" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="376" y="57" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">System Python <tspan font-weight="400" fill="var(--h-fig-muted)">stays clean</tspan></text>
<rect x="357" y="92" width="150" height="104" rx="10" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)"/>
<text x="432" y="116" text-anchor="middle" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">project A</text>
<rect x="371" y="128" width="122" height="54" rx="8" fill="var(--h-cherry)"/>
<text x="432" y="150" text-anchor="middle" font-size="12" font-weight="700" fill="#ffffff" font-family="var(--md-code-font-family, monospace)">.venv</text>
<text x="432" y="168" text-anchor="middle" font-size="11" fill="#ffffff" opacity="0.9">requests 1.x</text>
<rect x="527" y="92" width="150" height="104" rx="10" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)"/>
<text x="602" y="116" text-anchor="middle" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">project B</text>
<rect x="541" y="128" width="122" height="54" rx="8" fill="var(--h-cherry)"/>
<text x="602" y="150" text-anchor="middle" font-size="12" font-weight="700" fill="#ffffff" font-family="var(--md-code-font-family, monospace)">.venv</text>
<text x="602" y="168" text-anchor="middle" font-size="11" fill="#ffffff" opacity="0.9">requests 2.x</text>
<text x="517" y="224" text-anchor="middle" font-size="12" font-weight="700" fill="var(--h-fig-text)">each project gets exactly what it needs</text>
</svg>
</figure>

A **global installation** puts a package into the Python that the whole
system shares. Every project sees it, which sounds convenient until two
projects need different versions of the same package, or an install
breaks a tool Ubuntu itself relies on.

A **virtual environment**, or venv, is a folder inside your project
with its own copy of `pip` and its own packages. Activate it and Python
uses that folder; deactivate it and you are back to the system. Nothing
leaks between projects.

Recent Ubuntu versions enforce this. Try a global install:

```bash
pip install pycodestyle
```

```
error: externally-managed-environment
× This environment is externally managed
```

That error is Ubuntu protecting its own Python. It is pointing you at
the right answer: a virtual environment.

## Step 4: Isolate a project with `venv`

Create a venv in your project folder and activate it:

```bash
cd ~/holberton/python-basics
python3 -m venv .venv
source .venv/bin/activate
```

Your prompt now starts with `(.venv)`. Check which Python you are
using:

```bash
which python3
```

```
/home/you/holberton/python-basics/.venv/bin/python3
```

That path is inside your project. Now install a development tool:
`pycodestyle`, which checks your code against Python's official style
guide. You use it in every project from the next tutorial on.

```bash
pip install pycodestyle
pycodestyle --version
pycodestyle calc.py
```

No error this time. Record what the project needs, so anyone can
rebuild the same environment:

```bash
pip freeze > requirements.txt
cat requirements.txt
```

Now see the isolation for yourself:

```bash
deactivate
pycodestyle --version      # command not found: it only exists in the venv
source .venv/bin/activate
pycodestyle --version      # back again
```

The tool exists inside the environment and nowhere else. That is the
whole idea.

A few habits to keep:

- **One venv per project**, named `.venv`, inside the project folder.
- **Never commit it.** Add `.venv/` to your `.gitignore`. Commit
  `requirements.txt` instead; anyone can rebuild the venv with
  `pip install -r requirements.txt`.
- **Activate it every time** you open a new terminal for the project.
  If `(.venv)` is missing from the prompt, you are using the system
  Python.

!!! tip "Point VS Code at the venv"

    Press ++ctrl+shift+p++, run **Python: Select Interpreter** and pick
    the one in `./.venv`. VS Code then activates it in every new
    terminal and uses its packages for error checking.

!!! ai "AI in the loop"

    When you hit the `externally-managed-environment` error, an
    assistant may suggest `--break-system-packages`. Ask it what that
    flag breaks before you consider it. The honest answer is in the
    name: use a venv instead. This is a good habit in general: when a
    fix contains the words *force* or *break*, find out why.

## When something goes wrong

??? note "`/usr/bin/env: 'python3\r': No such file or directory`"

    The file has Windows line endings (CRLF). Linux reads the invisible
    `\r` as part of the program name. In VS Code, click **CRLF** in the
    status bar and change it to **LF**, then save. To stop it happening
    again, add `"files.eol": "\n"` to your VS Code settings.

??? note "`Permission denied` when running `./script.py`"

    It is not executable yet. Run `chmod u+x script.py`.

??? note "`The virtual environment was not created successfully because ensurepip is not available`"

    Ubuntu's venv support is a separate package. Run
    `sudo apt install -y python3-venv`, then create the venv again.

??? note "`python: command not found`"

    Ubuntu calls it `python3`. Use `python3`, or inside an active venv,
    `python` also works.

??? note "I installed a package but Python says `ModuleNotFoundError`"

    You installed it in one environment and ran Python from another.
    Check the prompt shows `(.venv)` and that `which python3` points
    inside your project, then install again.

## Explain it to someone

- [ ] The difference between an expression and a statement
- [ ] When the interpreter shows output automatically, and when it does not
- [ ] Why a script needs `print` to show anything
- [ ] What makes a script executable, and why `#!/usr/bin/env python3` is portable
- [ ] How to install and run a development tool with `pip`
- [ ] The difference between a global installation and a virtual environment
- [ ] How to create, activate and leave a venv, and how to prove a package is isolated in it

## Quick reference

| Command | What it does |
|---|---|
| `python3` | Start the interactive interpreter |
| `exit()` or ++ctrl+d++ | Leave the interpreter |
| `help(thing)` / `dir(thing)` | Read the docs / list attributes, inside Python |
| `chmod u+x file.py` | Make a script executable |
| `python3 -m venv .venv` | Create a virtual environment |
| `source .venv/bin/activate` | Activate it |
| `deactivate` | Leave it |
| `pip install name` | Install a package into the active venv |
| `pip freeze > requirements.txt` | Record installed packages |
| `pip install -r requirements.txt` | Rebuild them elsewhere |

## Next

Your environment is ready. Time to make Python say something.

[Hello, World](hello-world.md){ .h-button }
