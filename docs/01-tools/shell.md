# Shell Basics

<span class="badge badge--time">50 min</span>
<span class="badge badge--level">Tools</span>
<span class="badge">Needs: Ubuntu in WSL, or a Mac or Linux terminal</span>

The shell is the program that reads what you type in the terminal and
makes it happen. In this tutorial you learn what it is, how to move
around the filesystem with it, and how to find answers on your own.

## Why this matters

Servers have no mouse. When you deploy code, debug a container or fix
something on a remote machine, the shell is all you get. Holberton's
Checker also runs everything from a shell, so the faster you are here,
the faster every project goes.

It is also simpler than it looks. A dozen commands cover most of what
you will do in a day.

## Terminal, shell and prompt

People use *terminal* and *shell* as if they mean the same thing. They
do not.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 150" role="img" aria-labelledby="sh-layers-title sh-layers-desc">
<title id="sh-layers-title">Terminal, shell and the system</title>
<desc id="sh-layers-desc">The terminal is the window: it shows text and sends your keystrokes. The shell, usually bash, reads each command and runs it. The system underneath holds the programs and files that the command uses, such as ls, python3 and your folders.</desc>
<defs><marker id="sh-layers-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<rect x="3" y="20" width="200" height="96" rx="12" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="22" y="50" font-size="11" font-weight="700" fill="var(--h-fig-muted)">THE WINDOW</text>
<text x="22" y="74" font-size="15" font-weight="700" fill="var(--h-fig-text)">Terminal</text>
<text x="22" y="96" font-size="11.5" fill="var(--h-fig-muted)">shows text, sends keystrokes</text>
<rect x="240" y="20" width="200" height="96" rx="12" fill="var(--h-cherry)"/>
<text x="259" y="50" font-size="11" font-weight="700" fill="#ffffff" opacity="0.85">THE INTERPRETER</text>
<text x="259" y="74" font-size="15" font-weight="700" fill="#ffffff">Shell (bash)</text>
<text x="259" y="96" font-size="11.5" fill="#ffffff" opacity="0.9">reads a command, runs it</text>
<rect x="477" y="20" width="200" height="96" rx="12" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="496" y="50" font-size="11" font-weight="700" fill="var(--h-fig-muted)">THE SYSTEM</text>
<text x="496" y="74" font-size="15" font-weight="700" fill="var(--h-fig-text)">Programs and files</text>
<text x="496" y="96" font-size="11.5" fill="var(--h-fig-muted)">ls, python3, your folders</text>
<line x1="207" y1="68" x2="234" y2="68" stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#sh-layers-arrow)"/>
<line x1="444" y1="68" x2="471" y2="68" stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#sh-layers-arrow)"/>
<text x="221" y="140" text-anchor="middle" font-size="11.5" font-weight="600" fill="var(--h-fig-muted)">you type</text>
<text x="458" y="140" text-anchor="middle" font-size="11.5" font-weight="600" fill="var(--h-fig-muted)">it runs</text>
</svg>
</figure>

- **The terminal** is the window. It draws text and passes your keys
  along. Windows Terminal and the VS Code panel are both terminals.
- **The shell** is the program inside it that reads a command,
  works out what you meant and runs it. On Ubuntu the default shell is
  **bash**. You can check yours with `echo $SHELL`.
- **The prompt** is the text the shell prints when it is ready for your
  next command.

```bash
yourname@LAPTOP:~/holberton$
```

| Part | Meaning |
|---|---|
| `yourname` | the user you are logged in as |
| `LAPTOP` | the name of the machine |
| `~/holberton` | your current folder, the *working directory* |
| `$` | you are a normal user. It becomes `#` when you are root |

## RTFM: read the manual

*RTFM* stands for "read the fine manual", and it is the first advice
any experienced developer gives. Almost every command ships with its
own documentation, written by the people who built it.

```bash
man ls
```

This opens the manual page for `ls`. Inside it:

| Key | What it does |
|---|---|
| ++space++ / ++b++ | Page down / page up |
| ++slash++ then a word | Search. ++n++ jumps to the next match |
| ++q++ | Quit |

Some commands are not separate programs but are built into the shell
itself, such as `cd`. Those use `help`:

```bash
type cd        # cd is a shell builtin
help cd
type ls        # ls is /usr/bin/ls
```

For a quick summary of any program, try `ls --help`.

!!! ai "AI in the loop"

    An assistant is a fast way to understand a command: ask
    *"what does `ls -la` do, flag by flag?"*. But assistants sometimes
    invent flags that do not exist. Treat the answer as a lead, then
    confirm it with `man`. The manual describes the version actually
    installed on your machine.

## The filesystem is a tree

Linux keeps every file in a single tree. There are no drive letters.
The top of the tree is the **root directory**, written `/`.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 290" role="img" aria-labelledby="sh-tree-title sh-tree-desc">
<title id="sh-tree-title">The Linux directory tree</title>
<desc id="sh-tree-desc">The root directory, slash, sits at the top. Below it are bin, etc, home, root, tmp and usr. Slash home contains your home folder, which contains holberton. Slash root, a different directory, is the home folder of the root user.</desc>
<rect x="300" y="8" width="80" height="36" rx="8" fill="var(--h-cherry)"/>
<text x="340" y="32" text-anchor="middle" font-size="16" font-weight="700" fill="#ffffff" font-family="var(--md-code-font-family, monospace)">/</text>
<text x="394" y="31" font-size="11.5" font-weight="600" fill="var(--h-cherry)">the root directory</text>
<line x1="340" y1="44" x2="340" y2="66" stroke="var(--h-fig-line)" stroke-width="2"/>
<line x1="65" y1="66" x2="615" y2="66" stroke="var(--h-fig-line)" stroke-width="2"/>
<line x1="65" y1="66" x2="65" y2="88" stroke="var(--h-fig-line)" stroke-width="2"/>
<line x1="175" y1="66" x2="175" y2="88" stroke="var(--h-fig-line)" stroke-width="2"/>
<line x1="285" y1="66" x2="285" y2="88" stroke="var(--h-fig-line)" stroke-width="2"/>
<line x1="395" y1="66" x2="395" y2="88" stroke="var(--h-fig-line)" stroke-width="2"/>
<line x1="505" y1="66" x2="505" y2="88" stroke="var(--h-fig-line)" stroke-width="2"/>
<line x1="615" y1="66" x2="615" y2="88" stroke="var(--h-fig-line)" stroke-width="2"/>
<g font-family="var(--md-code-font-family, monospace)" font-size="13" text-anchor="middle">
<rect x="25" y="88" width="80" height="32" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="65" y="109" fill="var(--h-fig-text)">bin</text>
<rect x="135" y="88" width="80" height="32" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="175" y="109" fill="var(--h-fig-text)">etc</text>
<rect x="245" y="88" width="80" height="32" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="285" y="109" fill="var(--h-fig-text)" font-weight="700">home</text>
<rect x="355" y="88" width="80" height="32" rx="8" fill="var(--h-fig-box)" stroke="var(--h-cherry)" stroke-dasharray="4 3" stroke-width="1.5"/>
<text x="395" y="109" fill="var(--h-cherry)" font-weight="700">root</text>
<rect x="465" y="88" width="80" height="32" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="505" y="109" fill="var(--h-fig-text)">tmp</text>
<rect x="575" y="88" width="80" height="32" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="615" y="109" fill="var(--h-fig-text)">usr</text>
<rect x="245" y="160" width="80" height="32" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="285" y="181" fill="var(--h-fig-text)" font-weight="700">you</text>
<rect x="231" y="232" width="108" height="32" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="285" y="253" fill="var(--h-fig-text)">holberton</text>
</g>
<line x1="285" y1="120" x2="285" y2="160" stroke="var(--h-fig-line)" stroke-width="2"/>
<line x1="285" y1="192" x2="285" y2="232" stroke="var(--h-fig-line)" stroke-width="2"/>
<text x="232" y="172" text-anchor="end" font-size="11.5" font-weight="600" fill="var(--h-fig-text)">/home/you</text>
<text x="232" y="188" text-anchor="end" font-size="11.5" fill="var(--h-fig-muted)">your home directory, also ~</text>
<text x="218" y="253" text-anchor="end" font-size="11.5" fill="var(--h-fig-muted)">~/holberton</text>
<text x="395" y="140" text-anchor="middle" font-size="11.5" font-weight="600" fill="var(--h-cherry)">/root</text>
<text x="395" y="156" text-anchor="middle" font-size="11" fill="var(--h-fig-muted)">home of the root user</text>
</svg>
</figure>

Three places on that tree matter most:

- **`/` is the root directory**, the top of everything.
- **`/home/you` is your home directory**, written `~` for short. Your
  files and settings live here.
- **`/root` is the home directory of the user called root**, the
  administrator account. It is just one folder inside `/`, not the top
  of the tree. The names are confusing; the picture is not.

Every file has a **path** that says where it sits in the tree:

- An **absolute path** starts at the root: `/home/you/holberton`.
- A **relative path** starts from where you are now: `holberton`, or
  `../tmp`.

## Move around

You are always *in* one directory, called the **working directory**.
Three commands are enough to move around.

**Where am I?** `pwd` prints the working directory.

```bash
pwd
```

```
/home/you
```

**What is here?** `ls` lists the contents.

```bash
ls            # names only
ls -l         # long format: permissions, owner, size, date
ls -la        # long format, including hidden files
ls /etc       # list another directory without going there
```

**Go somewhere.** `cd` changes the working directory.

```bash
cd holberton          # relative: into holberton, below where you are
cd /tmp               # absolute: straight to /tmp
cd ..                 # up one level
cd                    # home, from anywhere (same as cd ~)
cd -                  # back to the previous directory, and print it
```

`cd -` is the one people forget. It flips between your last two
locations, which is handy when you are working in two folders at once.

## `.`, `..` and hidden files

Run `ls -la` in your home folder:

```
drwxr-x--- 5 you you 4096 Oct 20 09:12 .
drwxr-xr-x 3 root root 4096 Oct 19 18:40 ..
-rw-r--r-- 1 you you  220 Oct 19 18:40 .bash_logout
-rw-r--r-- 1 you you 3771 Oct 19 18:40 .bashrc
drwxr-xr-x 2 you you 4096 Oct 20 09:12 holberton
```

- **`.`** is the directory you are in. `./script.sh` means "the
  `script.sh` in this folder".
- **`..`** is the directory above it. `cd ..` goes up one level.
- **Hidden files** are any files whose name starts with a dot, such as
  `.bashrc`. Plain `ls` skips them; `ls -a` shows them. They usually
  hold settings, which is why they are kept out of the way.

There is nothing secret about a hidden file. The dot only changes
whether `ls` shows it by default.

## Use the history

The shell remembers what you typed.

| Do this | What happens |
|---|---|
| ++up++ / ++down++ | Walk back and forward through previous commands |
| `history` | List recent commands, numbered |
| `!42` | Run command number 42 from that list again |
| `!!` | Run the last command again. `sudo !!` reruns it as root |
| ++ctrl+r++ then type | Search backwards for a command containing that text |

++ctrl+r++ saves more time than anything else on this page. Try it now:
press it, type `cd`, and press ++ctrl+r++ again to see older matches.

## Write your first script

A shell script is a text file of commands that run one after the
other. The first line is the **shebang**: `#!` followed by the path to
the program that should run the file.

```bash title="hello_shell"
#!/bin/bash
echo "Hello from the shell"
```

The shebang tells Linux to run this file with `/bin/bash`. Without it,
Linux has to guess, and Holberton's checkers will reject the file.

Create it, make it executable, and run it:

```bash
cd ~/holberton
code hello_shell        # write the two lines and save
chmod u+x hello_shell
./hello_shell
```

`chmod u+x` gives you, the owner, permission to execute the file. You
learn exactly how that works in [Shell Permissions](shell-permissions.md).
The `./` says "the file in this folder", because the shell does not
look in the current folder for programs unless you tell it to.

!!! tip "Holberton script conventions"

    Projects usually ask for the shebang `#!/bin/bash` on the first
    line, a final newline at the end of the file, and nothing else on
    the first line. The VS Code settings from the
    [VS Code tutorial](vscode-setup.md#step-5-settings-that-keep-the-checker-happy)
    add the final newline for you.

## When something goes wrong

??? note "`Permission denied` when running a script"

    The file is not executable. Run `chmod u+x filename`, then try
    `./filename` again.

??? note "`command not found`"

    Check the spelling first. If you are running your own script, add
    `./` in front of the name. If it is a program, it may not be
    installed: `sudo apt install name` usually fixes it.

??? note "`No such file or directory`"

    The path is wrong relative to where you are. Run `pwd` to see where
    you are and `ls` to see what is actually there. Remember that names
    are case sensitive: `Holberton` and `holberton` are different.

??? note "I am stuck inside a manual page"

    Press ++q++. The same works for `less` and most other full-screen
    viewers.

## Explain it to someone

The project asks you to explain each of these without looking anything
up. Tick them off when you can.

- [ ] What RTFM means, and how to open a manual page
- [ ] What a shebang is, and why the first line of a script needs one
- [ ] What the shell is, and how it differs from a terminal
- [ ] What the prompt shows
- [ ] How to reuse previous commands with the history
- [ ] What `cd`, `pwd` and `ls` do
- [ ] What `.` and `..` are
- [ ] What the working directory is, how to print it and how to change it
- [ ] What the root directory is, and what the home directory is
- [ ] The difference between `/` and `/root`
- [ ] What makes a file hidden, and how to list hidden files
- [ ] What `cd -` does

## Quick reference

| Command | What it does |
|---|---|
| `pwd` | Print the working directory |
| `ls -la` | List everything here, hidden files included, in long format |
| `cd path` | Change to `path` |
| `cd` or `cd ~` | Go to your home directory |
| `cd ..` / `cd -` | Up one level / back to the previous directory |
| `man command` | Read the manual for a command |
| `help builtin` | Read the help for a shell builtin such as `cd` |
| `type command` | Say whether a command is a builtin or a program |
| `history` | List recent commands |
| `echo $SHELL` | Show which shell you are using |

## Next

You can move around. Now learn who is allowed to do what.

[Shell Permissions](shell-permissions.md){ .h-button }
