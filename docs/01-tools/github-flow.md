# GitHub Flow

<span class="badge badge--time">75 min</span>
<span class="badge badge--level">Tools</span>
<span class="badge">Needs: Git & GitHub, a partner from your cohort</span>

GitHub Flow is the simple way most teams work together on one codebase:
every change lives on its own branch, goes through a pull request, gets
reviewed, and is merged into `main` only when it is ready. This
tutorial walks through the whole cycle, from forking a repository to
tagging a release.

## Why this matters

On your own, Git is a safety net. In a team, it is how work gets
reviewed, discussed and shipped without people overwriting each other.
The team projects later in the program use this flow, and so does
almost every company you will apply to.

Do this tutorial with a partner. Reviewing someone else's pull request
teaches you as much as opening your own.

## The flow

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 150" role="img" aria-labelledby="gf-flow-title gf-flow-desc">
<title id="gf-flow-title">GitHub Flow in six steps</title>
<desc id="gf-flow-desc">Branch from main. Commit small, clear changes. Push the branch to GitHub. Open a pull request. A teammate reviews it, and you update it until it is approved. Merge it into main, then delete the branch.</desc>
<defs><marker id="gf-flow-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<g font-size="13.5" font-weight="700" text-anchor="middle">
<rect x="3" y="24" width="98" height="76" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="52" y="58" fill="var(--h-fig-text)">Branch</text>
<rect x="116" y="24" width="98" height="76" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="165" y="58" fill="var(--h-fig-text)">Commit</text>
<rect x="229" y="24" width="98" height="76" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="278" y="58" fill="var(--h-fig-text)">Push</text>
<rect x="342" y="24" width="98" height="76" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="391" y="58" fill="var(--h-fig-text)">Pull request</text>
<rect x="455" y="24" width="98" height="76" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="504" y="58" fill="var(--h-fig-text)">Review</text>
<rect x="568" y="24" width="109" height="76" rx="10" fill="var(--h-cherry)"/>
<text x="622" y="58" fill="#ffffff">Merge</text>
</g>
<g font-size="11" text-anchor="middle" fill="var(--h-fig-muted)">
<text x="52" y="80">off main</text>
<text x="165" y="80">small, clear</text>
<text x="278" y="80">to GitHub</text>
<text x="391" y="80">describe it</text>
<text x="504" y="80">until approved</text>
<text x="622" y="80" fill="#ffffff" opacity="0.9">into main</text>
</g>
<g stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#gf-flow-arrow)">
<line x1="103" y1="62" x2="113" y2="62"/>
<line x1="216" y1="62" x2="226" y2="62"/>
<line x1="329" y1="62" x2="339" y2="62"/>
<line x1="442" y1="62" x2="452" y2="62"/>
<line x1="555" y1="62" x2="565" y2="62"/>
</g>
<polyline points="504,106 504,128 165,128 165,104" fill="none" stroke="var(--h-fig-line)" stroke-width="2" stroke-dasharray="5 4" marker-end="url(#gf-flow-arrow)"/>
<text x="334" y="146" text-anchor="middle" font-size="11.5" font-weight="600" fill="var(--h-fig-muted)">changes requested: commit again on the same branch</text>
</svg>
</figure>

`main` is always working code. Nobody commits to it directly; changes
reach it only through a reviewed pull request.

## Step 1: Fork and set up remotes

When you do not have write access to a repository, for example an
open source project or a repo your partner owns, you **fork** it: GitHub
makes a copy under your account. You work on your fork and propose
changes back to the original.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 246" role="img" aria-labelledby="gf-fork-title gf-fork-desc">
<title id="gf-fork-title">Upstream, your fork and your laptop</title>
<desc id="gf-fork-desc">The original repository, called upstream, is forked into your account on GitHub, called origin. You clone origin to your laptop and push your branches back to it. You open a pull request from origin to upstream. To stay up to date you fetch from upstream directly.</desc>
<defs><marker id="gf-fork-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker>
<marker id="gf-fork-arrow-c" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-cherry)"/></marker></defs>
<rect x="240" y="8" width="200" height="66" rx="12" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="340" y="36" text-anchor="middle" font-size="14" font-weight="700" fill="var(--h-fig-text)">upstream</text>
<text x="340" y="56" text-anchor="middle" font-size="11.5" fill="var(--h-fig-muted)">the original repo, on GitHub</text>
<rect x="3" y="166" width="200" height="66" rx="12" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="103" y="194" text-anchor="middle" font-size="14" font-weight="700" fill="var(--h-fig-text)">origin</text>
<text x="103" y="214" text-anchor="middle" font-size="11.5" fill="var(--h-fig-muted)">your fork, on GitHub</text>
<rect x="477" y="166" width="200" height="66" rx="12" fill="var(--h-cherry)"/>
<text x="577" y="194" text-anchor="middle" font-size="14" font-weight="700" fill="#ffffff">your laptop</text>
<text x="577" y="214" text-anchor="middle" font-size="11.5" fill="#ffffff" opacity="0.9">where you work</text>
<line x1="252" y1="78" x2="112" y2="160" stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#gf-fork-arrow)"/>
<text x="148" y="108" text-anchor="end" font-size="12" font-weight="600" fill="var(--h-fig-muted)">1. Fork</text>
<line x1="136" y1="160" x2="276" y2="78" stroke="var(--h-cherry)" stroke-width="2.5" marker-end="url(#gf-fork-arrow-c)"/>
<text x="214" y="138" font-size="12" font-weight="700" fill="var(--h-cherry)">4. Pull request</text>
<line x1="207" y1="190" x2="471" y2="190" stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#gf-fork-arrow)"/>
<line x1="471" y1="210" x2="207" y2="210" stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#gf-fork-arrow)"/>
<text x="340" y="182" text-anchor="middle" font-size="12" font-weight="600" fill="var(--h-fig-muted)">2. clone</text>
<text x="340" y="230" text-anchor="middle" font-size="12" font-weight="600" fill="var(--h-fig-muted)">3. push your branch</text>
<line x1="430" y1="78" x2="560" y2="160" stroke="var(--h-fig-line)" stroke-width="2" stroke-dasharray="5 4" marker-end="url(#gf-fork-arrow)"/>
<text x="514" y="108" font-size="12" font-weight="600" fill="var(--h-fig-muted)">fetch upstream</text>
</svg>
</figure>

One partner creates a repo called `flow-practice` with a README. The
other forks it with the **Fork** button on GitHub, then clones the
fork:

```bash
cd ~/holberton
git clone https://github.com/your-username/flow-practice.git
cd flow-practice
git remote add upstream https://github.com/partner-username/flow-practice.git
git remote -v
```

You now have two remotes. **`origin`** is your fork, where you push.
**`upstream`** is the original, where you get other people's changes.

Before starting any new piece of work, bring `main` up to date:

```bash
git switch main
git fetch upstream
git merge upstream/main
git push origin main
```

!!! tip "Working in the same repo instead"

    If your partner adds you as a collaborator instead, you skip the
    fork: clone their repo directly and there is only `origin`. Every
    other step is the same.

## Step 2: Create a branch with a clear name

Name branches by the kind of change and what it does, in lowercase with
hyphens.

| Prefix | For | Example |
|---|---|---|
| `feature/` | New functionality | `feature/user-login` |
| `fix/` | Bug fixes | `fix/empty-cart-crash` |
| `docs/` | Documentation only | `docs/setup-instructions` |
| `refactor/` | Restructuring with no behaviour change | `refactor/split-utils` |
| `chore/` | Tooling, config, dependencies | `chore/add-gitignore` |

```bash
git switch -c docs/add-contributors
```

## Step 3: Make meaningful commits

A good commit does one thing and says what it does. Many teams also
start the message with a type, a convention called **Conventional
Commits**:

```bash
git commit -m "docs: add contributors section to README"
git commit -m "fix: handle empty input in parser"
git commit -m "feat: add login form"
```

The types line up with branch prefixes and with version numbers later
in this tutorial. Whatever convention your team picks, keep messages in
the imperative and keep each commit small.

Push the branch to your fork:

```bash
git push -u origin docs/add-contributors
```

## Step 4: Open a pull request

A **pull request**, or PR, asks the repository's owners to review your
branch and merge it. After you push, GitHub shows a **Compare & pull
request** button. Click it, check that the base is `main` on the
original repo and the head is your branch, then write a description.

A good description answers three questions:

```markdown title="Pull request description"
## What
Adds a Contributors section to the README listing both partners.

## Why
New team members could not tell who to ask about the project.

## How to test
Open README.md on this branch and check the section renders.

Closes #3
```

`Closes #3` links the PR to issue number 3 and closes the issue when
the PR is merged. Keep the PR small: a reviewer can read 100 lines
carefully, but skims 1,000.

You can also open it from the terminal with `gh pr create`, which asks
for the title and description.

!!! ai "AI in the loop"

    Copilot can draft a PR description from your changes. Use it as a
    first draft, then edit it until every sentence is true and specific.
    It can also do a first review pass, but it does not replace your
    teammate. It cannot know what the team agreed or why the change
    was needed.

## Step 5: Review, and respond to review

Swap roles. Open your partner's PR, go to **Files changed**, and read
every line.

- Click the **+** next to a line to leave a comment on it.
- Use **Insert a suggestion** to propose an exact change they can
  accept with one click.
- When you are done, click **Review changes** and choose one of:
  **Comment** (no verdict), **Request changes** (must be fixed before
  merging) or **Approve**.

Good review comments are specific and kind. "This loop runs twice for
the same item, could we break after the first match?" helps. "This is
wrong" does not. Ask questions when you do not understand something:
often the code is the thing that needs to change.

When you receive comments, fix them **on the same branch** and push
again. The PR updates by itself; there is no need to open a new one.
Reply to each comment so the reviewer knows it is handled.

## Step 6: Resolve conflicts in a pull request

If `main` changed while your PR was open, GitHub may say *This branch
has conflicts that must be resolved*. Bring the latest `main` into your
branch and resolve them locally:

```bash
git switch docs/add-contributors
git fetch upstream
git merge upstream/main          # use origin/main if you have no fork
# fix the conflict markers, as in the Git tutorial
git add README.md
git commit -m "Merge main into docs/add-contributors"
git push
```

The PR updates, the conflict warning disappears, and the reviewer can
approve.

## Step 7: Merge and clean up

Once the PR is approved, the repo owner clicks **Merge pull request**.
GitHub offers three ways; teams usually pick one and stick to it.

| Option | Result on `main` |
|---|---|
| Create a merge commit | All your commits, plus one merge commit |
| Squash and merge | Your commits combined into one |
| Rebase and merge | Your commits replayed on top, no merge commit |

Then delete the branch. It has done its job, and old branches pile up
fast.

```bash
git switch main
git fetch upstream && git merge upstream/main
git branch -d docs/add-contributors              # delete it locally
git push origin --delete docs/add-contributors   # delete it on your fork
git fetch --prune                                # forget remote branches that are gone
```

GitHub also shows a **Delete branch** button right after merging.

## Step 8: Tag a release with SemVer

When `main` reaches a state worth naming, you tag it with a version
number. **Semantic Versioning**, or SemVer, uses three numbers:
**MAJOR.MINOR.PATCH**.

| Change | Bump | Example |
|---|---|---|
| Breaks something people relied on | MAJOR | `1.4.2` → `2.0.0` |
| Adds a feature, nothing breaks | MINOR | `1.4.2` → `1.5.0` |
| Fixes a bug, nothing new | PATCH | `1.4.2` → `1.4.3` |

Versions below `1.0.0` mean "still being built, anything may change".
A first public release is `1.0.0`.

```bash
git switch main && git pull
git tag -a v1.0.0 -m "First release"
git push origin v1.0.0
```

On GitHub, open **Releases**, then **Draft a new release**, pick the
tag and paste the notes from your changelog.

## Step 9: Keep a CHANGELOG

A `CHANGELOG.md` at the root of the repo tells people what changed in
each version, in words rather than commits. A widely used format is
[Keep a Changelog](https://keepachangelog.com/):

```markdown title="CHANGELOG.md"
# Changelog

## [Unreleased]

## [1.0.0] - 2026-10-20
### Added
- Contributors section in the README.
- Setup instructions for WSL.

### Fixed
- Broken link to the project board.
```

Collect changes under **Unreleased** as PRs are merged. When you tag a
release, rename that section to the new version and date, and start a
new empty **Unreleased** above it. Use the headings **Added**,
**Changed**, **Fixed** and **Removed**.

## When something goes wrong

??? note "I committed to `main` on my fork"

    Move the work to a branch and reset `main`:
    `git switch -c feature/name`, then `git switch main` and
    `git reset --hard upstream/main`, then `git push --force origin main`.
    Force-pushing is acceptable here only because it is your own fork's
    `main`. Never force-push a shared branch.

??? note "My fork is far behind the original"

    `git switch main`, `git fetch upstream`, `git merge upstream/main`,
    `git push origin main`. GitHub's **Sync fork** button on your fork's
    page does the same.

??? note "`fatal: 'upstream' does not appear to be a git repository`"

    You have not added the upstream remote yet. Run
    `git remote add upstream <url of the original repo>`.

??? note "The PR shows commits I did not make"

    Your branch started from an old `main`. Update `main` from upstream,
    then merge `main` into your branch, as in Step 6.

## Explain it to someone

- [ ] The steps of GitHub Flow, and why `main` is never committed to directly
- [ ] What a fork is, and the difference between `origin` and `upstream`
- [ ] How to name a branch, and why naming conventions help a team
- [ ] What makes a commit message meaningful
- [ ] How to open a pull request and what its description should say
- [ ] How to comment, request changes and approve in a review
- [ ] How to resolve a conflict that appears in a pull request
- [ ] How SemVer numbers change for a breaking change, a feature and a fix
- [ ] What goes in a CHANGELOG and when it is updated
- [ ] How to clean up branches after a merge

## Quick reference

| Command | What it does |
|---|---|
| `git remote add upstream url` | Connect your clone to the original repo |
| `git fetch upstream` | Download upstream's latest commits |
| `git merge upstream/main` | Bring them into your current branch |
| `git switch -c type/short-name` | Start a new branch |
| `git push -u origin branch` | Publish a branch to your fork |
| `gh pr create` | Open a pull request from the terminal |
| `git tag -a v1.0.0 -m "msg"` | Tag a release |
| `git push origin v1.0.0` | Publish the tag |
| `git branch -d branch` | Delete a merged branch locally |
| `git push origin --delete branch` | Delete it on GitHub |
| `git fetch --prune` | Forget remote branches that were deleted |

## Next

Your tools are ready: a Linux machine, an editor, AI assistants, the
shell and Git. Time to write real programs.

[Start Python Fundamentals](../02-foundations/python/index.md){ .h-button }

GitHub's own guide if you want more:
[GitHub flow](https://docs.github.com/get-started/using-github/github-flow).
