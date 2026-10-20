# VS Code

<span class="badge badge--time">30 min</span>
<span class="badge badge--level">Tools</span>
<span class="badge">Needs: WSL set up</span>

VS Code is the editor you will use for every project in this program:
Python, SQL, HTML, CSS and JavaScript. It installs on Windows and works
inside Ubuntu, so you get a familiar window and a Linux machine
underneath it.

## Why this matters

A good editor does a lot of quiet work. It catches typos before the
Checker does, keeps your formatting consistent, and puts a terminal, Git
and an AI assistant in the same window as your code. Set it up properly
once and you stop thinking about it.

## The window at a glance

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 300" role="img" aria-labelledby="vs-win-title vs-win-desc">
<title id="vs-win-title">The five parts of the VS Code window</title>
<desc id="vs-win-desc">1, the activity bar down the far left. 2, the side bar with the file explorer. 3, the editor in the middle, where you write code. 4, the panel at the bottom with the terminal. 5, the status bar along the bottom edge, whose left corner shows WSL: Ubuntu when VS Code is connected to Linux.</desc>
<rect x="3" y="4" width="674" height="290" rx="12" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)"/>
<rect x="3" y="4" width="44" height="262" rx="12" fill="var(--h-fig-box)"/>
<rect x="15" y="26" width="20" height="16" rx="3" fill="var(--h-fig-line)"/>
<rect x="15" y="56" width="20" height="16" rx="3" fill="var(--h-fig-line)" opacity="0.6"/>
<rect x="15" y="86" width="20" height="16" rx="3" fill="var(--h-fig-line)" opacity="0.6"/>
<rect x="15" y="116" width="20" height="16" rx="3" fill="var(--h-fig-line)" opacity="0.6"/>
<line x1="47" y1="4" x2="47" y2="266" stroke="var(--h-fig-line)"/>
<rect x="47" y="4" width="166" height="262" fill="var(--h-fig-box)" opacity="0.55"/>
<text x="62" y="30" font-size="10.5" font-weight="700" fill="var(--h-fig-muted)">EXPLORER</text>
<text x="62" y="54" font-size="12" fill="var(--h-fig-text)">▾ holberton</text>
<text x="78" y="76" font-size="12" fill="var(--h-fig-text)">hello.py</text>
<text x="78" y="98" font-size="12" fill="var(--h-fig-muted)">README.md</text>
<line x1="213" y1="4" x2="213" y2="266" stroke="var(--h-fig-line)"/>
<text x="232" y="34" font-size="12" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">1</text>
<text x="256" y="34" font-size="12" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)"><tspan fill="var(--h-cherry)">print</tspan>("Hello, Holberton")</text>
<text x="232" y="56" font-size="12" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">2</text>
<line x1="213" y1="160" x2="677" y2="160" stroke="var(--h-fig-line)"/>
<text x="232" y="182" font-size="10.5" font-weight="700" fill="var(--h-fig-muted)">TERMINAL</text>
<text x="232" y="206" font-size="12" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">you@laptop:~/holberton$ python3 hello.py</text>
<text x="232" y="228" font-size="12" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">Hello, Holberton</text>
<line x1="3" y1="266" x2="677" y2="266" stroke="var(--h-fig-line)"/>
<path d="M3 266 H120 V294 H15 A12 12 0 0 1 3 282 Z" fill="var(--h-cherry)"/>
<text x="20" y="285" font-size="11.5" font-weight="700" fill="#ffffff">WSL: Ubuntu</text>
<text x="140" y="285" font-size="11" fill="var(--h-fig-muted)">main</text>
<text x="190" y="285" font-size="11" fill="var(--h-fig-muted)">Ln 1, Col 1</text>
<text x="270" y="285" font-size="11" fill="var(--h-fig-muted)">Python</text>
<circle cx="25" cy="160" r="11" fill="var(--h-cherry)"/>
<text x="25" y="164.5" text-anchor="middle" font-size="12" font-weight="700" fill="#ffffff">1</text>
<circle cx="190" cy="54" r="11" fill="var(--h-cherry)"/>
<text x="190" y="58.5" text-anchor="middle" font-size="12" font-weight="700" fill="#ffffff">2</text>
<circle cx="650" cy="34" r="11" fill="var(--h-cherry)"/>
<text x="650" y="38.5" text-anchor="middle" font-size="12" font-weight="700" fill="#ffffff">3</text>
<circle cx="650" cy="182" r="11" fill="var(--h-cherry)"/>
<text x="650" y="186.5" text-anchor="middle" font-size="12" font-weight="700" fill="#ffffff">4</text>
<circle cx="650" cy="280" r="11" fill="var(--h-cherry)"/>
<text x="650" y="284.5" text-anchor="middle" font-size="12" font-weight="700" fill="#ffffff">5</text>
</svg>
</figure>

1. **Activity bar.** Switches the side bar between Explorer, Search,
   Source Control, Extensions and Copilot Chat.
2. **Side bar.** Shows whatever the activity bar picked. Most of the
   time, the files in your project.
3. **Editor.** Where you write code. You can split it to see two files
   at once.
4. **Panel.** The terminal lives here. It is a real Ubuntu terminal,
   the same one you used in the WSL tutorial.
5. **Status bar.** The bottom left corner must say **WSL: Ubuntu**.
   That label tells you your code runs on Linux. Check it whenever
   something behaves strangely.

## Step 1: Install VS Code on Windows

Download it from [code.visualstudio.com](https://code.visualstudio.com/)
and run the installer. Tick these boxes when offered:

- Add "Open with Code" action to the file context menu
- Add "Open with Code" action to the directory context menu
- Add to PATH

The last one lets you type `code .` in a terminal to open the current
folder. You will use it constantly.

Install VS Code on Windows only. Do not install it inside Ubuntu.

## Step 2: Install the WSL extension

1. Open VS Code and press ++ctrl+shift+x++ to open Extensions.
2. Search for **WSL**, published by Microsoft, and click **Install**.

## Step 3: Open your projects folder from Ubuntu

Open the Ubuntu terminal and run:

```bash
cd ~/holberton
code .
```

The first time, Ubuntu downloads a small helper called the VS Code
Server. Give it a minute. A VS Code window opens with your `holberton`
folder in the Explorer.

Look at the bottom left corner. It should say **WSL: Ubuntu**. Open the
terminal with ++ctrl+grave++ (the key above ++tab++). The prompt looks
like this:

```bash
yourname@LAPTOP:~/holberton$
```

That is Linux. Everything you type there runs on Ubuntu.

## Step 4: Install extensions on the Linux side

Extensions install separately on each side. Having one on Windows does
not mean it works in the WSL window.

Open Extensions with ++ctrl+shift+x++ in the WSL window and install
these. Each one shows an **Install in WSL: Ubuntu** button.

| Extension | Publisher | What it gives you |
|---|---|---|
| Python | Microsoft | Highlighting, error hints and the Python interpreter |
| ESLint | Microsoft | Flags JavaScript mistakes as you type |

Later modules add a few more. Keep the list short: every extension
slows the editor down a little.

## Step 5: Settings that keep the Checker happy

Holberton's style checkers reject lines longer than 79 characters,
spaces at the end of a line, and files without a final newline. VS Code
can handle all three for you.

Press ++ctrl+shift+p++, run **Preferences: Open User Settings (JSON)**,
and add these lines inside the curly braces:

```json
{
  "files.autoSave": "afterDelay",
  "files.insertFinalNewline": true,
  "files.trimTrailingWhitespace": true,
  "editor.rulers": [79],
  "editor.renderWhitespace": "trailing",
  "[python]": { "editor.tabSize": 4 },
  "[javascript]": { "editor.tabSize": 2 }
}
```

If the file already has settings, add the new lines among them and
separate each line with a comma. Save with ++ctrl+s++.

The ruler draws a thin line at column 79. Keep your code to the left of
it.

## Step 6: Run your first file

In the Explorer, click the new-file icon and create `hello.py`:

```python
print("Hello, Holberton")
```

Run it in the terminal:

```bash
python3 hello.py
```

The output appears right below. The Checker runs your files from a
terminal exactly like this, so get used to running them the same way
rather than with a Run button.

!!! ai "AI in the loop"

    VS Code has GitHub Copilot built in. You switch it on in the next
    tutorial, together with a browser assistant and Clippy, and learn
    when to use which.

## Shortcuts worth knowing

| Keys | What it does |
|---|---|
| ++ctrl+shift+p++ | Command palette. Everything VS Code can do is in here |
| ++ctrl+p++ | Jump to a file by typing part of its name |
| ++ctrl+grave++ | Show or hide the terminal |
| ++ctrl+b++ | Show or hide the side bar |
| ++ctrl+shift+e++ | File explorer |
| ++ctrl+slash++ | Comment or uncomment the selected lines |
| ++alt+up++ / ++alt+down++ | Move the current line up or down |
| ++ctrl+d++ | Select the next match of the selected word |

## When something goes wrong

??? note "`code: command not found` in Ubuntu"

    Close and reopen the Ubuntu terminal. If it still fails, reinstall
    VS Code on Windows and make sure **Add to PATH** is ticked, then
    restart the laptop.

??? note "The status bar does not say WSL: Ubuntu"

    You opened the folder from Windows. Close the window, open the
    Ubuntu terminal, and run `cd ~/holberton && code .` again.

??? note "An extension is installed but does nothing"

    It is installed on the Windows side only. Open Extensions in the WSL
    window and click **Install in WSL: Ubuntu**.

??? note "Everything is slow, and Git takes seconds"

    Your project is under `/mnt/c`. Move it into `~/holberton`, as in
    the [WSL tutorial](wsl-setup.md#step-5-make-your-projects-folder).

## Check yourself

1. The bottom left corner says **WSL: Ubuntu**.
2. In the VS Code terminal, `pwd` prints `/home/yourname/holberton`.
3. `python3 hello.py` prints `Hello, Holberton`.
4. Type a line longer than the ruler in `hello.py`. You can see where
   it crosses column 79.
5. Add a few spaces at the end of a line and save. They disappear.

## Next

You have an editor running on Linux. Now bring in the assistants.

[Set up your AI assistant](ai-assistant.md){ .h-button }

Official guide if you want more:
[Developing in WSL](https://code.visualstudio.com/docs/remote/wsl).
