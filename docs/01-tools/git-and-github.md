# Git & GitHub

<span class="badge badge--time">75 min</span>
<span class="badge badge--level">Tools</span>
<span class="badge">Needs: Shell Basics, a GitHub account</span>

Git saves snapshots of your work. GitHub stores those snapshots online
so you do not lose them and other people can see them. In this
tutorial you set both up, push your first repository, then learn to
branch, merge, resolve a conflict and undo a mistake.

## Why this matters

You will write a lot of code in this program. Some of it will work and
then stop working, and you will want yesterday's version back. Git
gives you that.

There is a second reason. When you apply for a job, your GitHub profile
is one of the first things a hiring manager opens. Every project you
finish here ends up there, and the Checker reads your work from it.
Start building that history on day one.

## How Git works

Four places hold your work. Three are on your laptop, one is on
GitHub. Each command moves your work from one place to the next.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 172" role="img" aria-labelledby="git-flow-title git-flow-desc">
<title id="git-flow-title">How work moves through Git</title>
<desc id="git-flow-desc">Your working directory, then the staging area using git add, then the local repository history using git commit, then GitHub using git push. The git pull command brings work back from GitHub to your working directory.</desc>
<defs><marker id="git-flow-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<rect x="3" y="40" width="146" height="64" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="76" y="68" text-anchor="middle" font-size="13.5" font-weight="700" fill="var(--h-fig-text)">Working directory</text>
<text x="76" y="87" text-anchor="middle" font-size="11.5" fill="var(--h-fig-muted)">files you edit</text>
<rect x="179" y="40" width="146" height="64" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="252" y="68" text-anchor="middle" font-size="13.5" font-weight="700" fill="var(--h-fig-text)">Staging area</text>
<text x="252" y="87" text-anchor="middle" font-size="11.5" fill="var(--h-fig-muted)">picked to save</text>
<rect x="355" y="40" width="146" height="64" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="428" y="68" text-anchor="middle" font-size="13.5" font-weight="700" fill="var(--h-fig-text)">Local history</text>
<text x="428" y="87" text-anchor="middle" font-size="11.5" fill="var(--h-fig-muted)">commits on your laptop</text>
<rect x="531" y="40" width="146" height="64" rx="10" fill="var(--h-cherry)"/>
<text x="604" y="68" text-anchor="middle" font-size="13.5" font-weight="700" fill="#ffffff">GitHub</text>
<text x="604" y="87" text-anchor="middle" font-size="11.5" fill="#ffffff" opacity="0.9">online, shareable</text>
<line x1="153" y1="72" x2="173" y2="72" stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#git-flow-arrow)"/>
<line x1="329" y1="72" x2="349" y2="72" stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#git-flow-arrow)"/>
<line x1="505" y1="72" x2="525" y2="72" stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#git-flow-arrow)"/>
<text x="163" y="28" text-anchor="middle" font-size="12" font-weight="600" fill="var(--h-cherry)">git add</text>
<text x="339" y="28" text-anchor="middle" font-size="12" font-weight="600" fill="var(--h-cherry)">git commit</text>
<text x="515" y="28" text-anchor="middle" font-size="12" font-weight="600" fill="var(--h-cherry)">git push</text>
<polyline points="604,110 604,134 76,134 76,112" fill="none" stroke="var(--h-fig-line)" stroke-width="2" stroke-dasharray="5 4" marker-end="url(#git-flow-arrow)"/>
<text x="340" y="156" text-anchor="middle" font-size="12" font-weight="600" fill="var(--h-fig-muted)">git pull</text>
</svg>
</figure>

Keep this picture in your head. Most Git confusion comes from not
knowing which of the four boxes your work is sitting in right now.

## Step 1: Tell Git who you are

Git writes your name on every commit. Set it once, in the Ubuntu
terminal:

```bash
git config --global user.name "Your Full Name"
git config --global user.email "your-email@example.com"
git config --global init.defaultBranch main
```

Use the same email address as your GitHub account. If the two do not
match, your commits show up on GitHub without your profile attached.
The last line makes every new repository start on a branch called
`main`, the same name GitHub uses.

Nothing prints when this works. Check it:

```bash
git config --global --list
```

## Step 2: Let your laptop talk to GitHub

GitHub does not accept your account password in the terminal. You
authenticate with a **Personal Access Token** instead: a long random
string that works like a password, but only for what you allow and only
until it expires.

=== "Personal access token"

    1. On GitHub, open **Settings**, then **Developer settings**, then
       **Personal access tokens**, then **Fine-grained tokens**.
    2. Click **Generate new token**. Give it a name and an expiry of
       90 days.
    3. Under **Repository access**, choose **All repositories**. Under
       **Permissions**, set **Contents** to **Read and write**.
    4. Click **Generate token** and copy it. GitHub shows it once and
       never again, so store it in a password manager now.

    Then tell Git to remember it:

    ```bash
    git config --global credential.helper store
    ```

    The first time you push, Git asks for a username and a password.
    Type your GitHub username, then paste the token as the password.
    Git saves it and stops asking.

=== "GitHub CLI"

    The `gh` tool creates and stores a token for you through the
    browser.

    ```bash
    sudo apt update && sudo apt install -y gh
    gh auth login
    ```

    Choose GitHub.com, HTTPS, *yes* to authenticate Git with your
    GitHub credentials, then *login with a web browser*. Copy the
    one-time code, press ++enter++ and finish in the browser.

    Check it worked with `gh auth status`.

!!! warning "Never put your token in a URL or a file you commit"

    You will find advice online to clone with
    `https://username:token@github.com/...`. It works, and it leaks.
    Git writes that URL into `.git/config`, your shell saves it in its
    history, and one screenshot in Slack gives someone else access to
    your account. If a token ever leaks, delete it on GitHub straight
    away and make a new one.

## Step 3: Create a repository on GitHub

A **repository**, or repo, is a project folder that Git tracks. It is
easiest to create it on GitHub and copy it down.

1. On GitHub, click the green **New** button.
2. Name it `git-practice`.
3. Leave it public, and leave **Add a README file** unchecked.
4. Click **Create repository**.

## Step 4: Clone it to your laptop

Cloning downloads the repo and connects your local folder to GitHub.
That connection is called a **remote**, and Git names it `origin`.

```bash
cd ~/holberton
git clone https://github.com/your-username/git-practice.git
cd git-practice
git remote -v
```

You should see the clone warn that the repository is empty, and two
`origin` lines pointing at GitHub. The warning is fine.

## Step 5: The everyday loop

Make a change, check it, stage it, commit it, push it. You will run
this loop hundreds of times.

```bash
echo "# Git practice" > README.md
git status
```

`git status` is the most useful command in Git. Run it whenever you are
unsure where things stand. Right now it lists `README.md` as
*untracked*: Git sees the file but is not saving it yet.

```bash
git add README.md                 # stage it
git commit -m "Add README"        # save a snapshot locally
git push -u origin main           # send it to GitHub
```

The `-u` links your local `main` to GitHub's `main`, so from now on
`git push` and `git pull` are enough. Refresh the repo page in your
browser. Your file is there.

To see what you have saved so far:

```bash
git log --oneline
```

!!! tip "Write commit messages in the imperative"

    Write "Add login form", not "Added login form". Git's own messages
    read that way, so your history stays consistent. If a message needs
    the word *and*, you are probably saving two changes at once. Make
    two commits.

## Step 6: Ignore what does not belong

Some files should never be committed: caches, editor settings,
dependencies you can reinstall, and above all secrets. List them in a
file called `.gitignore` at the root of the repo.

```text title=".gitignore"
# Python
__pycache__/
*.pyc
.venv/

# JavaScript
node_modules/

# Secrets and local settings
.env
.vscode/
```

```bash
git add .gitignore
git commit -m "Add .gitignore"
git push
```

Now create a file called `.env` and run `git status`. Git does not list
it. Ignored files stay on your laptop and never reach GitHub.

!!! warning "`.gitignore` does not untrack files already committed"

    If you committed a file before ignoring it, Git keeps tracking it.
    Stop tracking it with `git rm --cached filename`, then commit. If it
    was a secret, treat it as leaked: it is still in the history.

## Step 7: Work on a branch

A **branch** is a separate line of commits. You make one for each
change, work there without touching `main`, and merge it back when it
is ready.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 180" role="img" aria-labelledby="git-branch-title git-branch-desc">
<title id="git-branch-title">A feature branch merged back into main</title>
<desc id="git-branch-desc">The main branch has two commits. A feature branch starts from the second, with git switch -c, and gets two commits of its own. It is then merged back into main with git merge, creating a merge commit.</desc>
<line x1="40" y1="120" x2="640" y2="120" stroke="var(--h-fig-line)" stroke-width="3"/>
<path d="M200 120 C 230 120, 240 56, 280 56 L 420 56 C 470 56, 490 120, 530 120" fill="none" stroke="var(--h-cherry)" stroke-width="3"/>
<circle cx="90" cy="120" r="12" fill="var(--h-fig-text)"/>
<circle cx="200" cy="120" r="12" fill="var(--h-fig-text)"/>
<circle cx="300" cy="56" r="12" fill="var(--h-cherry)"/>
<circle cx="400" cy="56" r="12" fill="var(--h-cherry)"/>
<circle cx="530" cy="120" r="15" fill="var(--md-default-bg-color)" stroke="var(--h-fig-text)" stroke-width="3"/>
<circle cx="530" cy="120" r="6" fill="var(--h-fig-text)"/>
<text x="40" y="150" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">main</text>
<text x="300" y="28" font-size="12.5" font-weight="700" fill="var(--h-cherry)">feature/greeting</text>
<text x="200" y="152" text-anchor="middle" font-size="11.5" font-weight="600" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">git switch -c</text>
<text x="530" y="158" text-anchor="middle" font-size="11.5" font-weight="600" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">git merge</text>
<text x="350" y="88" text-anchor="middle" font-size="11" fill="var(--h-fig-muted)">your commits, isolated</text>
</svg>
</figure>

```bash
git switch -c feature/greeting      # create the branch and move to it
echo "Hello from a branch" > greeting.txt
git add greeting.txt
git commit -m "Add greeting"
git push -u origin feature/greeting
```

`git branch` lists your branches and marks the current one with `*`.
`git switch main` moves back. Notice that `greeting.txt` disappears from
your folder on `main`: it only exists on the branch so far.

## Step 8: Merge, and resolve a conflict

To bring the branch into `main`, switch to `main` and merge:

```bash
git switch main
git merge feature/greeting
git push
```

Most merges finish by themselves. A **conflict** happens when both
branches changed the same lines, and Git cannot know which version you
want. Make one on purpose so you know what it looks like:

```bash
git switch -c feature/title
echo "# Git practice, branch version" > README.md
git commit -am "Change title on branch"

git switch main
echo "# Git practice, main version" > README.md
git commit -am "Change title on main"

git merge feature/title
```

Git stops and reports a conflict in `README.md`. Open the file:

```
<<<<<<< HEAD
# Git practice, main version
=======
# Git practice, branch version
>>>>>>> feature/title
```

The part above `=======` is what `main` has. The part below is what the
branch has. Edit the file so it says what it should, delete all three
marker lines, then finish the merge:

```bash
git add README.md
git commit -m "Merge feature/title"
git push
```

VS Code highlights conflicts and offers **Accept Current**, **Accept
Incoming** and **Accept Both** buttons above each one. They do the same
editing for you, but read the result before you commit.

## Step 9: Undo a mistake

Git has two main ways to undo a commit. The difference is whether you
rewrite history or add to it.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 212" role="img" aria-labelledby="git-undo-title git-undo-desc">
<title id="git-undo-title">git reset compared with git revert</title>
<desc id="git-undo-desc">With git reset, commit C is removed and the branch points back at B: history is rewritten, so use it only for commits you have not pushed. With git revert, a new commit, C prime, is added that undoes C: history is kept, so it is safe on shared branches.</desc>
<text x="3" y="26" font-size="12.5" font-weight="700" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">git reset --hard HEAD~1</text>
<line x1="40" y1="62" x2="232" y2="62" stroke="var(--h-fig-line)" stroke-width="3"/>
<line x1="232" y1="62" x2="320" y2="62" stroke="var(--h-fig-line)" stroke-width="3" stroke-dasharray="5 5" opacity="0.6"/>
<circle cx="60" cy="62" r="14" fill="var(--h-fig-text)"/><text x="60" y="67" text-anchor="middle" font-size="12" font-weight="700" fill="var(--md-default-bg-color)">A</text>
<circle cx="160" cy="62" r="14" fill="var(--h-fig-text)"/><text x="160" y="67" text-anchor="middle" font-size="12" font-weight="700" fill="var(--md-default-bg-color)">B</text>
<circle cx="260" cy="62" r="14" fill="none" stroke="var(--h-fig-line)" stroke-width="2" stroke-dasharray="4 3"/><text x="260" y="67" text-anchor="middle" font-size="12" font-weight="700" fill="var(--h-fig-muted)">C</text>
<text x="160" y="100" text-anchor="middle" font-size="11" font-weight="700" fill="var(--h-cherry)">main</text>
<text x="370" y="58" font-size="12" font-weight="600" fill="var(--h-fig-text)">C is gone; main points at B</text>
<text x="370" y="78" font-size="11.5" fill="var(--h-fig-muted)">Rewrites history. Only for commits</text>
<text x="370" y="94" font-size="11.5" fill="var(--h-fig-muted)">you have not pushed yet.</text>
<line x1="3" y1="122" x2="677" y2="122" stroke="var(--h-fig-line)" opacity="0.5"/>
<text x="3" y="148" font-size="12.5" font-weight="700" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">git revert C</text>
<line x1="40" y1="182" x2="340" y2="182" stroke="var(--h-fig-line)" stroke-width="3"/>
<circle cx="60" cy="182" r="14" fill="var(--h-fig-text)"/><text x="60" y="187" text-anchor="middle" font-size="12" font-weight="700" fill="var(--md-default-bg-color)">A</text>
<circle cx="140" cy="182" r="14" fill="var(--h-fig-text)"/><text x="140" y="187" text-anchor="middle" font-size="12" font-weight="700" fill="var(--md-default-bg-color)">B</text>
<circle cx="220" cy="182" r="14" fill="var(--h-fig-text)"/><text x="220" y="187" text-anchor="middle" font-size="12" font-weight="700" fill="var(--md-default-bg-color)">C</text>
<circle cx="310" cy="182" r="16" fill="var(--h-cherry)"/><text x="310" y="187" text-anchor="middle" font-size="12" font-weight="700" fill="#ffffff">C'</text>
<text x="370" y="178" font-size="12" font-weight="600" fill="var(--h-fig-text)">C' is a new commit that undoes C</text>
<text x="370" y="198" font-size="11.5" fill="var(--h-fig-muted)">Keeps history. Safe on shared branches.</text>
</svg>
</figure>

**`git revert`** adds a new commit that does the opposite of an old
one. Nothing disappears, so it is safe on any branch other people use,
including `main` after you have pushed.

```bash
git log --oneline          # find the commit's short hash, e.g. a1b2c3d
git revert a1b2c3d         # Git opens an editor for the message; save and close
git push
```

**`git reset`** moves the branch back to an earlier commit, as if the
later ones never happened. Use it only on commits you have *not*
pushed, because it rewrites history that others may already have.

| Command | Commit removed? | Your changes |
|---|---|---|
| `git reset --soft HEAD~1` | Yes | Kept, and still staged |
| `git reset HEAD~1` | Yes | Kept in your files, unstaged |
| `git reset --hard HEAD~1` | Yes | **Deleted.** There is no undo button |

`HEAD~1` means "one commit before the current one". The safe default
when you are unsure is `git revert`.

!!! ai "AI in the loop"

    Paste the output of `git status` or a conflict into Copilot Chat
    and ask what state your repository is in and what your options are.
    Assistants are good at reading Git output. Ask for an explanation
    rather than a command, and never run `reset --hard` or a force push
    because an assistant suggested it until you know what it deletes.

## When something goes wrong

??? note "`fatal: not a git repository`"

    You are not inside the repo folder. Run `pwd`, then `cd` into the
    folder you cloned.

??? note "`Authentication failed` when you push"

    The token is wrong or expired, or you typed your GitHub password
    instead of the token. Make a new token, run `rm ~/.git-credentials`,
    and push again. Or run `gh auth login`.

??? note "`Updates were rejected because the remote contains work`"

    Someone pushed to GitHub after you last pulled. Run `git pull`,
    resolve any conflicts, then push again.

??? note "`Please tell me who you are`"

    You skipped Step 1. Set your name and email, then commit again.

??? note "I committed to `main` instead of a branch"

    If you have not pushed yet: `git switch -c feature/name` to keep the
    commit on a new branch, then `git switch main` and
    `git reset --hard origin/main` to put `main` back the way GitHub has
    it.

## Explain it to someone

- [ ] How to configure Git with your name and email
- [ ] How to create a repository on GitHub and clone it locally
- [ ] What the working directory, staging area and history are, and
      which command moves work between them
- [ ] What `.gitignore` is for, and what belongs in it
- [ ] How to push and pull, and how a Personal Access Token is used
- [ ] What a branch is, and how to create and switch between them
- [ ] How to merge a branch, and how to resolve a conflict
- [ ] The difference between `git reset` and `git revert`, and when to
      use each

## Quick reference

| Command | What it does |
|---|---|
| `git status` | Show what changed and what is staged |
| `git add file` / `git add .` | Stage one file / everything |
| `git commit -m "message"` | Save a snapshot locally |
| `git push` / `git pull` | Send commits to GitHub / bring them down |
| `git log --oneline` | List commits, one per line |
| `git switch -c name` | Create a branch and move to it |
| `git switch name` | Move to an existing branch |
| `git merge name` | Merge a branch into the current one |
| `git revert hash` | Undo a commit with a new commit |
| `git reset HEAD~1` | Remove the last local commit, keep the changes |
| `git rm --cached file` | Stop tracking a file without deleting it |

## Next

You can track your own work. Next, work with other people.

[GitHub Flow](github-flow.md){ .h-button }

Want to go deeper: the [Pro Git book](https://git-scm.com/book) is free
and thorough, and [Learn Git Branching](https://learngitbranching.js.org/)
lets you practise branching visually.
