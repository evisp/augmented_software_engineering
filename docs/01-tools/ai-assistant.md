# AI Assistant

<span class="badge badge--time">40 min</span>
<span class="badge badge--level">Tools</span>
<span class="badge">Needs: VS Code connected to WSL, a GitHub account</span>

You will use three assistants in this program, and each has a different
job. This tutorial sets them up and shows you how to use them without
letting them do your learning for you.

## Why this matters

Professional developers use AI every day: to explain unfamiliar code,
draft boilerplate, find bugs and write tests. You will too, from the
first week.

AI can produce something that looks right very quickly. What it cannot
do is check its own assumptions, know what your project actually needs,
or take responsibility for the result. That part is yours. A project
that passes the Checker but that you cannot explain will not survive a
peer review, and it will not survive a job interview either.

## Three assistants, three jobs

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 196" role="img" aria-labelledby="ai-three-title ai-three-desc">
<title id="ai-three-title">The three assistants and when to use each</title>
<desc id="ai-three-desc">GitHub Copilot lives in VS Code and helps while you write code, with suggestions and chat about your open files. Claude or ChatGPT live in the browser and help when you need to understand something, explaining concepts and errors and comparing approaches. Clippy lives on the intranet and helps when you are stuck on a task, guiding your reasoning step by step without giving you code.</desc>
<rect x="3" y="10" width="216" height="176" rx="12" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="22" y="40" font-size="11" font-weight="700" fill="var(--h-fig-muted)">IN VS CODE</text>
<text x="22" y="64" font-size="15" font-weight="700" fill="var(--h-fig-text)">GitHub Copilot</text>
<text x="22" y="92" font-size="12" fill="var(--h-fig-muted)">Suggestions as you type,</text>
<text x="22" y="110" font-size="12" fill="var(--h-fig-muted)">chat about your open files</text>
<line x1="22" y1="138" x2="200" y2="138" stroke="var(--h-fig-line)"/>
<text x="22" y="164" font-size="12" font-weight="600" fill="var(--h-cherry)">while you write code</text>
<rect x="232" y="10" width="216" height="176" rx="12" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="251" y="40" font-size="11" font-weight="700" fill="var(--h-fig-muted)">IN THE BROWSER</text>
<text x="251" y="64" font-size="15" font-weight="700" fill="var(--h-fig-text)">Claude or ChatGPT</text>
<text x="251" y="92" font-size="12" fill="var(--h-fig-muted)">Explains concepts and errors,</text>
<text x="251" y="110" font-size="12" fill="var(--h-fig-muted)">compares approaches</text>
<line x1="251" y1="138" x2="429" y2="138" stroke="var(--h-fig-line)"/>
<text x="251" y="164" font-size="12" font-weight="600" fill="var(--h-cherry)">when you need to understand</text>
<rect x="461" y="10" width="216" height="176" rx="12" fill="var(--h-cherry)"/>
<text x="480" y="40" font-size="11" font-weight="700" fill="#ffffff" opacity="0.85">ON THE INTRANET</text>
<text x="480" y="64" font-size="15" font-weight="700" fill="#ffffff">Clippy</text>
<text x="480" y="92" font-size="12" fill="#ffffff" opacity="0.92">Guides your reasoning step</text>
<text x="480" y="110" font-size="12" fill="#ffffff" opacity="0.92">by step, never gives code</text>
<line x1="480" y1="138" x2="658" y2="138" stroke="#ffffff" opacity="0.35"/>
<text x="480" y="164" font-size="12" font-weight="600" fill="#ffffff">when you are stuck on a task</text>
</svg>
</figure>

**Copilot** sees the files you have open, so it is the fastest way to
ask about *your* code. **Claude or ChatGPT** have more room for a
conversation, so they are better for understanding a concept or an
error properly. **Clippy** knows Holberton's projects and is built to
make you think: it asks questions and gives you the next step, not the
answer.

## How to use any of them

Whichever assistant you open, the same loop applies.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 172" role="img" aria-labelledby="ai-loop-title ai-loop-desc">
<title id="ai-loop-title">The verify loop</title>
<desc id="ai-loop-desc">Ask with context, read the draft, test it yourself, and only then commit, and only what you can explain. If the test fails or you cannot explain it, go back and revise your question.</desc>
<defs><marker id="ai-loop-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<rect x="3" y="20" width="146" height="70" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="76" y="50" text-anchor="middle" font-size="14" font-weight="700" fill="var(--h-fig-text)">Ask</text>
<text x="76" y="70" text-anchor="middle" font-size="11.5" fill="var(--h-fig-muted)">with context</text>
<rect x="179" y="20" width="146" height="70" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="252" y="50" text-anchor="middle" font-size="14" font-weight="700" fill="var(--h-fig-text)">Read</text>
<text x="252" y="70" text-anchor="middle" font-size="11.5" fill="var(--h-fig-muted)">every line of the draft</text>
<rect x="355" y="20" width="146" height="70" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="428" y="50" text-anchor="middle" font-size="14" font-weight="700" fill="var(--h-fig-text)">Test</text>
<text x="428" y="70" text-anchor="middle" font-size="11.5" fill="var(--h-fig-muted)">run it yourself</text>
<rect x="531" y="20" width="146" height="70" rx="10" fill="var(--h-cherry)"/>
<text x="604" y="50" text-anchor="middle" font-size="14" font-weight="700" fill="#ffffff">Commit</text>
<text x="604" y="70" text-anchor="middle" font-size="11.5" fill="#ffffff" opacity="0.9">if you can explain it</text>
<line x1="153" y1="55" x2="173" y2="55" stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#ai-loop-arrow)"/>
<line x1="329" y1="55" x2="349" y2="55" stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#ai-loop-arrow)"/>
<line x1="505" y1="55" x2="525" y2="55" stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#ai-loop-arrow)"/>
<polyline points="428,96 428,126 76,126 76,98" fill="none" stroke="var(--h-fig-line)" stroke-width="2" stroke-dasharray="5 4" marker-end="url(#ai-loop-arrow)"/>
<text x="252" y="150" text-anchor="middle" font-size="12" font-weight="600" fill="var(--h-fig-muted)">fails, or you cannot explain it: revise</text>
</svg>
</figure>

The step people skip is **Read**. If you cannot say what a line does,
you are not ready to test it, and you are certainly not ready to commit
it.

## Step 1: Switch on GitHub Copilot in VS Code

Copilot is built into VS Code. You only need to sign in.

1. Open VS Code connected to WSL, so the bottom left says
   **WSL: Ubuntu**.
2. Hover over the Copilot icon in the status bar and choose
   **Use AI Features**.
3. Sign in with your GitHub account and approve the request in the
   browser.

If your account has no Copilot plan, it is enrolled in **Copilot Free**
automatically, which gives you a monthly allowance of suggestions and
chat. If you are a student, you can also apply through
[GitHub Education](https://education.github.com/) for the free student
plan. Plans and limits change often, so check the current details
there.

Two shortcuts to learn now:

| Keys | What it opens |
|---|---|
| ++ctrl+alt+i++ | Chat view: a conversation about your project |
| ++ctrl+i++ | Inline chat: ask about, or change, the selected code |

!!! tip "Consider turning off inline suggestions while you learn the basics"

    Grey suggestions that appear as you type are useful once you know
    the language. In your first weeks they type the answer before you
    have thought of it, and you learn the syntax much more slowly.
    Hover over the Copilot icon in the status bar to switch code
    completions off. Chat keeps working, so you can still ask questions.

## Step 2: Set up a browser assistant

Create a free account on [Claude](https://claude.ai/) or
[ChatGPT](https://chatgpt.com/). One is enough; pick whichever you
prefer. Keep it pinned in your browser next to the intranet.

Use it for the bigger questions:

- *Explain* a concept from your project in plain language.
- *Read* an error message with you and say what it means.
- *Compare* two ways of solving something and their trade-offs.

## Step 3: Meet Clippy

Clippy lives on the intranet, on your project pages. It knows what each
task asks for and is built to coach you rather than solve it.

Tell Clippy what you are trying to do, what you have tried and where
you are stuck. It answers with questions and the next step of reasoning,
not with code. That is deliberate. Use it when you are stuck on *how to
think about* a task, before you go looking for code anywhere else.

## Ask well

A vague question gets a vague answer. A good prompt gives the assistant
four things: **what you are working on, what you tried, what happened,
and what kind of help you want.**

!!! prompt "Explain an error"

    ```text
    I'm writing a Python script on Ubuntu for a beginner project.
    Running `python3 0-add.py` gives this error:

    TypeError: unsupported operand type(s) for +: 'int' and 'str'

    Explain what the error means and where to look in my code.
    Don't rewrite the code for me.
    ```

!!! prompt "Ask for a hint, not the answer"

    ```text
    My task: write a function that returns the largest number in a list
    without using max(). I tried looping over the list, but I don't know
    what to compare each number against. Give me a hint for the next
    step, not the solution.
    ```

!!! prompt "Review code you wrote"

    ```text
    Here is my solution to a task. It passes, but review it like a
    senior developer: is anything unclear, fragile or unnecessary?
    Explain each point. Don't give me a rewritten version.

    [paste your code]
    ```

Notice the last line of each prompt. Saying what you *do not* want is
the easiest way to keep the learning on your side.

## Rules for Holberton projects

<div class="grid cards cols-2" markdown>

-   :material-check-circle-outline: **Do**

    ---

    - Ask it to explain concepts, docs and error messages
    - Ask for a hint when you are stuck
    - Ask it to review code you wrote yourself
    - Ask it for test cases you had not thought of
    - Check what it says against the docs or by running it

-   :material-close-circle-outline: **Don't**

    ---

    - Paste a task and submit whatever comes back
    - Commit a line you cannot explain
    - Paste passwords, tokens or `.env` files into any assistant
    - Paste a classmate's code without asking them
    - Trust a confident answer you have not tested

</div>

Your peers and mentors will ask you to explain your code. "The AI wrote
it" is not an explanation.

## When something goes wrong

??? note "There is no Copilot icon in the status bar"

    Update VS Code with **Help > Check for Updates**, then restart it.
    If the icon is still missing, press ++ctrl+shift+p++ and run
    **Chat: Open Chat**, which also offers the sign-in.

??? note "Copilot says I have reached my limit"

    The free plan has a monthly allowance. Use the browser assistant or
    Clippy until it resets, or apply for the student plan through
    GitHub Education.

??? note "The answer looks right but the code fails"

    That happens often. Assistants guess at versions, file names and
    what your task requires. Paste the exact error back and say what
    you expected, or read the docs for the function it used.

## Check yourself

1. The Copilot icon in the status bar shows you are signed in.
2. Open `hello.py`, select the `print` line, press ++ctrl+i++ and ask
   *explain this line*. Read the answer.
3. In Claude or ChatGPT, ask: *What is the difference between running
   `python3 hello.py` and `./hello.py` on Linux?* Then try both in your
   terminal and see whether the answer was right.
4. Open any project on the intranet and ask Clippy how to start the
   first task. Notice that it asks you questions back.

## Quick reference

| Assistant | Where | Use it for | Open it with |
|---|---|---|---|
| GitHub Copilot | VS Code | Questions about your open code | ++ctrl+alt+i++, ++ctrl+i++ |
| Claude or ChatGPT | Browser | Concepts, errors, comparing approaches | claude.ai, chatgpt.com |
| Clippy | Intranet project pages | Reasoning through a task | On the project page |

## Next

Your editor and your assistants are ready. Next you learn to drive the
terminal yourself.

[Learn the shell](shell.md){ .h-button }

Official guide if you want more:
[GitHub Copilot in VS Code](https://code.visualstudio.com/docs/copilot/overview).
