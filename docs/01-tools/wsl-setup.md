# WSL

<span class="badge badge--time">35 min</span>
<span class="badge badge--level">Tools</span>
<span class="badge">Needs: Windows 10 (2004+) or 11, admin rights</span>

WSL, the Windows Subsystem for Linux, runs a real Ubuntu inside Windows.
Every project in this program is written, run and checked on Linux, so
this is where your code will live.

## Why this matters

Almost every server, cloud machine and container you will deploy to
runs Linux. Holberton projects are tested on Ubuntu too, so code that
works on Windows can still fail the Checker because of a path, a line
ending or a missing command.

WSL removes that gap. You keep the Windows you are used to for your
browser, Slack and VS Code. Your code runs on Linux, and the two share
files. This setup is required for the program.

!!! note "On a Mac or Linux?"

    You do not need WSL. macOS and Linux already have a Unix terminal.
    Go straight to [VS Code](vscode-setup.md) and use your normal
    terminal wherever these tutorials say *Ubuntu terminal*.

## How the pieces fit

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 216" role="img" aria-labelledby="wsl-fit-title wsl-fit-desc">
<title id="wsl-fit-title">Windows and Ubuntu side by side with WSL</title>
<desc id="wsl-fit-desc">On the Windows side you have your apps, such as VS Code and the browser, and your Windows files. On the Ubuntu side, inside WSL, your code runs with Python, Node.js and Git, and your projects live in a folder in your Linux home. VS Code connects to Ubuntu through the WSL extension. Windows files are reachable from Ubuntu under slash mnt slash c.</desc>
<rect x="3" y="14" width="286" height="188" rx="12" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="24" y="44" font-size="12" font-weight="700" fill="var(--h-fig-muted)">WINDOWS</text>
<rect x="24" y="60" width="244" height="58" rx="8" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)"/>
<text x="42" y="84" font-size="14" font-weight="700" fill="var(--h-fig-text)">VS Code, browser, Slack</text>
<text x="42" y="104" font-size="11.5" fill="var(--h-fig-muted)">what you look at and type in</text>
<rect x="24" y="130" width="244" height="52" rx="8" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)"/>
<text x="42" y="152" font-size="13" font-weight="600" fill="var(--h-fig-text)">Your Windows files</text>
<text x="42" y="170" font-size="11.5" fill="var(--h-fig-muted)">C:\Users\you\Documents</text>
<rect x="391" y="14" width="286" height="188" rx="12" fill="var(--h-cherry)"/>
<text x="412" y="44" font-size="12" font-weight="700" fill="#ffffff" opacity="0.85">UBUNTU, INSIDE WSL</text>
<rect x="412" y="60" width="244" height="58" rx="8" fill="rgba(255,255,255,0.14)"/>
<text x="430" y="84" font-size="14" font-weight="700" fill="#ffffff">Python, Node.js, Git</text>
<text x="430" y="104" font-size="11.5" fill="#ffffff" opacity="0.9">where the code actually runs</text>
<rect x="412" y="130" width="244" height="52" rx="8" fill="rgba(255,255,255,0.14)"/>
<text x="430" y="152" font-size="13" font-weight="600" fill="#ffffff">Your projects</text>
<text x="430" y="170" font-size="11.5" fill="#ffffff" opacity="0.9">~/holberton</text>
<line x1="293" y1="89" x2="387" y2="89" stroke="var(--h-fig-line)" stroke-width="2"/>
<text x="340" y="78" text-anchor="middle" font-size="11" font-weight="600" fill="var(--h-cherry)">WSL extension</text>
<line x1="387" y1="156" x2="293" y2="156" stroke="var(--h-fig-line)" stroke-width="2" stroke-dasharray="4 4"/>
<text x="340" y="176" text-anchor="middle" font-size="11" font-weight="600" fill="var(--h-fig-muted)">/mnt/c</text>
</svg>
</figure>

One thing to hold on to: **the window is Windows, the code is Linux.**

## Step 1: Check your Windows

Press ++win+r++, type `winver` and press ++enter++. You need Windows 11,
or Windows 10 version 2004 or later. If you are on an older version,
run Windows Update first.

Then open Task Manager with ++ctrl+shift+esc++, go to **Performance**,
then **CPU**, and find the line **Virtualization**. It should say
**Enabled**. If it says disabled, see
[When something goes wrong](#when-something-goes-wrong) before you
continue.

## Step 2: Install WSL

Right-click the Start button and choose **Terminal (Admin)**. On
Windows 10 this may be called **Windows PowerShell (Admin)**. Then run:

```powershell
wsl --install
```

This turns on the Windows features WSL needs, downloads the Linux
kernel and installs Ubuntu. It takes a few minutes. Restart when it
asks.

## Step 3: Create your Linux user

After the restart, Ubuntu opens by itself and asks for a username and
a password.

- **Username:** lowercase, no spaces. It does not have to match your
  Windows name.
- **Password:** pick one you will remember. You type it every time you
  run a command with `sudo`.

Linux shows nothing while you type a password, not even dots. That is
normal. Type it and press ++enter++.

Check it worked. Back in the Windows terminal, run:

```powershell
wsl --list --verbose
```

You want to see Ubuntu with version 2:

```
  NAME      STATE           VERSION
* Ubuntu    Running         2
```

## Step 4: Update Ubuntu and install the basics

Open Ubuntu from the Start menu. Everything from here on runs in the
Ubuntu terminal, not in PowerShell.

Update the package lists and upgrade what is installed:

```bash
sudo apt update && sudo apt upgrade -y
```

Then install the tools the first projects need:

```bash
sudo apt install -y build-essential git curl python3 python3-pip python3-venv
```

Check them:

```bash
python3 --version
git --version
```

You should see Python 3.10 or later, and any recent Git version.

!!! ai "AI in the loop"

    When an install fails, copy the full error message into Claude or
    ChatGPT and ask what it means and what each suggested fix does.
    Run a fix only once you understand what it changes. Pasting commands
    you do not understand into a terminal with `sudo` is how people
    break their setup.

## Step 5: Make your projects folder

This is the one WSL rule worth memorising.

**Keep your projects in your Linux home folder.** Files there live on
the Linux filesystem and are fast. Files under `/mnt/c` live on the
Windows filesystem, and every read crosses a bridge. Git and Python
become noticeably slow, and file permissions behave strangely.

```bash
mkdir -p ~/holberton
cd ~/holberton
pwd
```

You should see `/home/yourname/holberton`. That is where every project
in this program goes.

To look at the folder in Windows Explorer, run:

```bash
explorer.exe .
```

The dot means *this folder*. Explorer opens it under **Linux** in the
sidebar.

!!! tip "Make Ubuntu your default terminal"

    In Windows Terminal, open **Settings**, set **Default profile** to
    **Ubuntu** and save. Every new terminal tab then opens straight into
    Linux.

## When something goes wrong

??? note "`wsl --install` fails, or Virtualization says disabled"

    Virtualisation is turned off in your BIOS. Restart, enter the BIOS
    setup (usually ++f2++, ++f10++ or ++del++ while the laptop starts),
    and enable **Intel VT-x** or **AMD-V**, sometimes called **SVM**.
    Save, restart and run `wsl --install` again.

??? note "`wsl --list --verbose` shows version 1"

    Run `wsl --set-version Ubuntu 2` in PowerShell and wait. It can take
    a few minutes. Then run `wsl --set-default-version 2` so future
    installs use version 2.

??? note "Ubuntu opens and closes straight away"

    Run `wsl --update` in PowerShell, restart the laptop and open Ubuntu
    again.

??? note "I forgot my Linux password"

    In PowerShell, run `wsl -u root` to open Ubuntu as the administrator
    account. Then run `passwd yourname`, set a new password, and type
    `exit`.

??? note "`Could not get lock /var/lib/dpkg/lock`"

    Another update is running in the background. Wait a minute and run
    your `apt` command again.

## Check yourself

1. In PowerShell, `wsl --list --verbose` shows Ubuntu with version 2.
2. In the Ubuntu terminal, `cd ~/holberton && pwd` prints
   `/home/yourname/holberton`, not a `/mnt/c` path.
3. `python3 --version` prints 3.10 or later.
4. `git --version` prints a version number.
5. `explorer.exe .` opens your `holberton` folder in Windows Explorer.

## Quick reference

| Command | Where | What it does |
|---|---|---|
| `wsl --install` | PowerShell (Admin) | Installs WSL and Ubuntu |
| `wsl --list --verbose` | PowerShell | Shows installed Linux versions |
| `wsl --update` | PowerShell | Updates WSL itself |
| `sudo apt update && sudo apt upgrade -y` | Ubuntu | Updates Ubuntu's packages |
| `sudo apt install -y name` | Ubuntu | Installs a package |
| `cd ~/holberton` | Ubuntu | Goes to your projects folder |
| `explorer.exe .` | Ubuntu | Opens the current folder in Windows Explorer |

## Next

Linux is running. Now connect an editor to it.

[Set up VS Code](vscode-setup.md){ .h-button }

Official guide if you want more:
[Install WSL](https://learn.microsoft.com/windows/wsl/install).
