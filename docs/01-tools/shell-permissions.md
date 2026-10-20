# Shell Permissions

<span class="badge badge--time">45 min</span>
<span class="badge badge--level">Tools</span>
<span class="badge">Needs: Shell Basics</span>

Linux is a multi-user system. Every file has an owner, a group, and a
set of rules about who may read it, change it or run it. In this
tutorial you learn to read those rules, change them, and act as another
user when you need to.

## Why this matters

`Permission denied` is one of the first errors you will meet, and one
of the most common on servers. Most of the time the fix is one command,
but only if you understand what the system is protecting.

Permissions also matter for safety. A web server that can write to its
own code, or a secrets file that every user can read, is how systems
get broken into.

## Read the permissions

Run `ls -l` on a file:

```
-rwxr-xr-- 1 you developers 512 Oct 20 10:04 deploy.sh
```

The first ten characters are the permissions. Read them in four parts.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 250" role="img" aria-labelledby="pm-bits-title pm-bits-desc">
<title id="pm-bits-title">Reading -rwxr-xr-- as 754</title>
<desc id="pm-bits-desc">The first character is the file type: a dash for a regular file, d for a directory. The next three, r w x, are the owner's permissions, 4 plus 2 plus 1 equals 7. The next three, r dash x, are the group's, 4 plus 0 plus 1 equals 5. The last three, r dash dash, are everyone else's, 4 plus 0 plus 0 equals 4. Together they make 754.</desc>
<g font-family="var(--md-code-font-family, monospace)" font-size="20" font-weight="700" text-anchor="middle">
<rect x="96" y="14" width="44" height="48" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="118" y="45" fill="var(--h-fig-muted)">-</text>
<rect x="152" y="14" width="44" height="48" rx="8" fill="var(--h-cherry)"/>
<text x="174" y="45" fill="#ffffff">r</text>
<rect x="200" y="14" width="44" height="48" rx="8" fill="var(--h-cherry)"/>
<text x="222" y="45" fill="#ffffff">w</text>
<rect x="248" y="14" width="44" height="48" rx="8" fill="var(--h-cherry)"/>
<text x="270" y="45" fill="#ffffff">x</text>
<rect x="304" y="14" width="44" height="48" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="326" y="45" fill="var(--h-fig-text)">r</text>
<rect x="352" y="14" width="44" height="48" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="374" y="45" fill="var(--h-fig-muted)">-</text>
<rect x="400" y="14" width="44" height="48" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="422" y="45" fill="var(--h-fig-text)">x</text>
<rect x="456" y="14" width="44" height="48" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="4 3"/>
<text x="478" y="45" fill="var(--h-fig-text)">r</text>
<rect x="504" y="14" width="44" height="48" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="4 3"/>
<text x="526" y="45" fill="var(--h-fig-muted)">-</text>
<rect x="552" y="14" width="44" height="48" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="4 3"/>
<text x="574" y="45" fill="var(--h-fig-muted)">-</text>
</g>
<g fill="none" stroke="var(--h-fig-line)" stroke-width="2">
<polyline points="152,74 152,82 292,82 292,74"/>
<polyline points="304,74 304,82 444,82 444,74"/>
<polyline points="456,74 456,82 596,82 596,74"/>
</g>
<text x="118" y="104" text-anchor="middle" font-size="12" font-weight="700" fill="var(--h-fig-text)">type</text>
<text x="118" y="122" text-anchor="middle" font-size="11" fill="var(--h-fig-muted)">- file, d dir</text>
<text x="222" y="104" text-anchor="middle" font-size="12.5" font-weight="700" fill="var(--h-cherry)">owner (u)</text>
<text x="374" y="104" text-anchor="middle" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">group (g)</text>
<text x="526" y="104" text-anchor="middle" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">others (o)</text>
<g font-family="var(--md-code-font-family, monospace)" font-size="12.5" text-anchor="middle" fill="var(--h-fig-muted)">
<text x="222" y="126">4 + 2 + 1</text>
<text x="374" y="126">4 + 0 + 1</text>
<text x="526" y="126">4 + 0 + 0</text>
</g>
<g font-size="30" font-weight="700" text-anchor="middle">
<text x="222" y="168" fill="var(--h-cherry)">7</text>
<text x="374" y="168" fill="var(--h-fig-text)">5</text>
<text x="526" y="168" fill="var(--h-fig-text)">4</text>
</g>
<line x1="152" y1="190" x2="596" y2="190" stroke="var(--h-fig-line)"/>
<text x="374" y="222" text-anchor="middle" font-size="15" font-weight="700" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">chmod 754 deploy.sh</text>
<text x="374" y="242" text-anchor="middle" font-size="11" fill="var(--h-fig-muted)">r = 4, w = 2, x = 1, - = 0</text>
</svg>
</figure>

1. **Type.** `-` for a regular file, `d` for a directory, `l` for a
   link.
2. **Owner** (`u`, for *user*). Here `rwx`: the owner can read, write
   and execute.
3. **Group** (`g`). Here `r-x`: members of the `developers` group can
   read and execute, but not change it.
4. **Others** (`o`). Here `r--`: everyone else can only read it.

The two names after the permissions, `you` and `developers`, are the
file's owner and group.

### What r, w and x mean

The letters mean slightly different things on files and on directories.

| | On a file | On a directory |
|---|---|---|
| `r` read | See the contents | List the names inside (`ls`) |
| `w` write | Change the contents | Create, rename or delete files inside |
| `x` execute | Run it as a program | Enter it (`cd`) and reach files inside |

### Each set as one digit

Each letter has a value: **r = 4, w = 2, x = 1**. Add up the letters
in a set and you get one digit from 0 to 7. Three sets make three
digits.

| Digit | Letters | Typical use |
|---|---|---|
| 7 | `rwx` | Owner of a script or directory |
| 6 | `rw-` | Owner of a normal file |
| 5 | `r-x` | Others may run or enter, not change |
| 4 | `r--` | Read only |
| 0 | `---` | No access |

So `755` is `rwxr-xr-x`, the usual setting for scripts and
directories, and `644` is `rw-r--r--`, the usual setting for normal
files. `600` (`rw-------`) is for files only you should read, such as
keys.

## Change permissions with `chmod`

`chmod` changes the permissions. You can give it the three digits, or
describe the change with letters.

```bash
chmod 755 deploy.sh      # set exactly rwxr-xr-x
chmod u+x deploy.sh      # add execute for the owner
chmod g-w notes.txt      # remove write from the group
chmod o=r notes.txt      # set others to exactly read
chmod a+r notes.txt      # add read for all three (a = all)
chmod ug+rw,o-rwx data/  # combine changes with commas
```

Digits are quicker when you know the result you want. Letters are
safer when you only want to change one thing and leave the rest alone.

Only the file's owner, or root, can change its permissions.

!!! warning "Never fix an error with `chmod 777`"

    `777` gives everyone permission to read, change and run the file.
    It makes the error go away and opens a hole anyone on the machine
    can use. Work out who actually needs access, and grant exactly that.

## Users and groups

Every user has a name and a number, the **user ID** or UID. Every user
also belongs to one or more groups, each with a **group ID** or GID.

```bash
whoami          # your effective user name
id              # your user ID, group ID and every group you are in
id -u           # just your effective user ID, as a number
groups          # the groups you are in
groups alex     # the groups another user is in
```

Usually your *real* ID (who you logged in as) and your *effective* ID
(who the system treats you as right now) are the same. They differ
when you run something as another user, which is the next section.

### Create users and groups

These commands need root privileges, so they start with `sudo`. They
are safe to try on your own WSL machine.

```bash
sudo adduser alex                # create user alex, with a home folder
sudo groupadd developers         # create a group
sudo usermod -aG developers alex # add alex to the group
groups alex                      # check
```

`adduser` is Ubuntu's friendly version and asks you questions. The
lower-level `useradd` does the same job with flags, and it is what
`man` pages and scripts often use. Clean up afterwards with
`sudo deluser alex` and `sudo groupdel developers`.

## Change owner and group

`chown` changes a file's owner, and optionally its group. `chgrp`
changes only the group.

```bash
sudo chown alex report.txt              # owner becomes alex
sudo chown alex:developers report.txt   # owner and group
sudo chgrp developers report.txt        # group only
sudo chown -R alex project/             # a folder and everything in it
```

**Why does `chown` need `sudo`?** If normal users could give their
files away, they could create a file and make it look as though
someone else wrote it, or push their files onto another user's disk
quota. Only root can change who owns a file. You can change the group
of a file you own, but only to a group you belong to.

## Act as root, or as another user

**root** is the administrator account, with user ID 0. It can do
anything, which is why you avoid working as root all the time.

<div class="grid cards cols-2" markdown>

-   **`sudo` runs one command as root**

    ---

    ```bash
    sudo apt update
    sudo !!
    ```

    It asks for *your* password, runs that one command with root
    privileges, and records it in a log. Your user must be allowed to
    use `sudo`, which the first user on Ubuntu is.

-   **`su` switches to another user**

    ---

    ```bash
    su alex      # become alex
    sudo su -    # become root
    exit         # back to yourself
    ```

    `su` asks for the *target* user's password and opens a shell as
    them. The prompt changes to show who you are. The `-` also loads
    their environment and takes you to their home folder.

</div>

Use `sudo` for single commands. Use `su` when you really need to work
as another user for a while, and type `exit` as soon as you are done.

!!! ai "AI in the loop"

    Assistants often suggest commands that start with `sudo`. Before
    you run one, ask what each part does and what it changes. A command
    you do not understand, run as root, is the fastest way to break
    your system or open it up to someone else.

## When something goes wrong

??? note "`Permission denied`"

    Run `ls -l` on the file and on the folder it is in. Work out which
    of the three sets applies to you (are you the owner, in the group,
    or other?) and which letter is missing. Then grant only that.

??? note "`Operation not permitted` with `chown` or `chgrp`"

    Changing an owner needs root. Run it again with `sudo`.

??? note "`you is not in the sudoers file`"

    Your user is not allowed to use `sudo`. On your own WSL machine the
    first user always is. On a shared machine, ask the administrator.

??? note "`su: Authentication failure`"

    `su` wants the password of the user you are switching *to*, not
    your own. To become root on Ubuntu, use `sudo su -` with your own
    password instead.

## Explain it to someone

- [ ] What `chmod`, `sudo`, `su`, `chown` and `chgrp` do
- [ ] How to read Linux permissions from `ls -l`
- [ ] How to write each set of permissions as one digit
- [ ] How to change the permissions, owner and group of a file
- [ ] Why a normal user cannot `chown` a file
- [ ] How to run one command with root privileges
- [ ] How to switch to another user, or become root
- [ ] How to create a user and a group
- [ ] How to print real and effective user and group IDs
- [ ] How to print the groups a user is in
- [ ] How to print your effective user ID

## Quick reference

| Command | What it does |
|---|---|
| `ls -l file` | Show permissions, owner and group |
| `chmod 755 file` | Set permissions with digits |
| `chmod u+x file` | Change one permission with letters |
| `sudo chown user:group file` | Change owner and group |
| `sudo chgrp group file` | Change group only |
| `whoami` / `id -u` | Effective user name / effective user ID |
| `id` | Real and effective user and group IDs, and groups |
| `groups user` | Groups a user belongs to |
| `sudo adduser name` / `sudo groupadd name` | Create a user / a group |
| `sudo command` | Run one command as root |
| `su user` / `exit` | Become another user / go back |

## Next

You can move around and control who may touch what. Now start tracking
your work.

[Git & GitHub](git-and-github.md){ .h-button }
