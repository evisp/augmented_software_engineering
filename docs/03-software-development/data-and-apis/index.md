# Data & APIs

Make the wallet a real application: save its data in files, move it
into a relational database, map its classes to tables, and serve it
over the web through a REST API. Six projects, one application that
keeps growing.

<span class="badge badge--level">Software Development</span>
<span class="badge badge--time">60 h</span>
<span class="badge">6 projects</span>
<span class="badge">Needs: Object-Oriented Design</span>

<p class="h-progress-label"><span>Tutorials published</span><span>1 of 6</span></p>
<div class="h-progress" role="img" aria-label="1 of 6 tutorials published"><span style="width: 17%"></span></div>

## One application, six projects

The digital wallet you built in Object-Oriented Design carries on here.
Each tutorial adds one layer to it, until other programs can use it over
the web.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 120" role="img" aria-labelledby="da-idx-plan-title da-idx-plan-desc">
<title id="da-idx-plan-title">How the wallet application grows across Data &amp; APIs</title>
<desc id="da-idx-plan-desc">Version 6, From Script to Application: the wallet package: ready. Version 7, File Handling: a snapshot and a journal: ready. Version 8, SQL CRUD: tables and rows: coming next. Version 9, Joins: data across tables: coming next. Version 10, Database design: a normalised schema: coming next. Version 11, ORM: classes mapped to tables: coming next. Version 12, REST API: the wallet over HTTP: coming next.</desc>
<defs><marker id="da-idx-plan-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<rect x="3" y="16" width="86" height="88" rx="10" fill="var(--h-cherry)"/>
<rect x="101" y="16" width="86" height="88" rx="10" fill="var(--h-cherry)"/>
<rect x="199" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="297" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="395" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="493" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="591" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<g text-anchor="middle">
<text x="46" y="38" font-size="10" font-weight="700" fill="#ffffff" opacity="0.85">v6 · READY</text>
<text x="46" y="64" font-size="12.5" font-weight="700" fill="#ffffff">Package</text>
<text x="46" y="84" font-size="10" fill="#ffffff" opacity="0.9">modules</text>
<text x="144" y="38" font-size="10" font-weight="700" fill="#ffffff" opacity="0.85">v7 · READY</text>
<text x="144" y="64" font-size="12.5" font-weight="700" fill="#ffffff">Files</text>
<text x="144" y="84" font-size="10" fill="#ffffff" opacity="0.9">JSON, journal</text>
<text x="242" y="38" font-size="10" font-weight="700" fill="var(--h-fig-muted)">v8</text>
<text x="242" y="64" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">SQL CRUD</text>
<text x="242" y="84" font-size="10" fill="var(--h-fig-muted)">tables</text>
<text x="340" y="38" font-size="10" font-weight="700" fill="var(--h-fig-muted)">v9</text>
<text x="340" y="64" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">Joins</text>
<text x="340" y="84" font-size="10" fill="var(--h-fig-muted)">relations</text>
<text x="438" y="38" font-size="10" font-weight="700" fill="var(--h-fig-muted)">v10</text>
<text x="438" y="64" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">Design</text>
<text x="438" y="84" font-size="10" fill="var(--h-fig-muted)">schema</text>
<text x="536" y="38" font-size="10" font-weight="700" fill="var(--h-fig-muted)">v11</text>
<text x="536" y="64" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">ORM</text>
<text x="536" y="84" font-size="10" fill="var(--h-fig-muted)">mapping</text>
<text x="634" y="38" font-size="10" font-weight="700" fill="var(--h-fig-muted)">v12</text>
<text x="634" y="64" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">REST API</text>
<text x="634" y="84" font-size="10" fill="var(--h-fig-muted)">endpoints</text>
</g>
<g stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#da-idx-plan-arrow)">
<line x1="91" y1="60" x2="99" y2="60"/>
<line x1="189" y1="60" x2="197" y2="60"/>
<line x1="287" y1="60" x2="295" y2="60"/>
<line x1="385" y1="60" x2="393" y2="60"/>
<line x1="483" y1="60" x2="491" y2="60"/>
<line x1="581" y1="60" x2="589" y2="60"/>
</g>
</svg>
</figure>

!!! tip "Same companion repository, new versions"

    The code continues in [evisp/oop-wallet](https://github.com/evisp/oop-wallet),
    and the version numbers carry on from the OOP module: `v6-package`,
    `v7-files`, and so on, one tag per tutorial.

!!! info "Start with the bridge"

    Before the first project, the short tutorial
    [From Script to Application](script-to-application.md) splits the
    single `wallet.py` into a package of modules. Every tutorial in this
    module builds on that structure.

## The path

### Store and query data

<div class="grid cards cols-2" markdown>

-   :material-file-document-edit-outline: **1 · File Handling**

    ---

    Open, write, read and close files safely; a JSON snapshot and an
    append-only journal for the wallet.

    <span class="badge badge--ready">Ready</span>
    <span class="badge">4 h</span>

    [:octicons-arrow-right-24: Start](files.md)

-   :material-table-edit: **2 · SQL: CRUD Operations**

    ---

    Tables and rows: create, read, update and delete the wallet's data
    with SQL.

    <span class="badge badge--soon">Coming soon</span>
    <span class="badge">8 h</span>

-   :material-table-network: **3 · SQL: Joins & Relationships**

    ---

    Customers, accounts and transactions together: questions that span
    several tables.

    <span class="badge badge--soon">Coming soon</span>
    <span class="badge">8 h</span>

-   :material-database-cog-outline: **4 · Database Design & Normalization**

    ---

    Turn the UML class diagram into a schema with keys, and remove
    duplicated data.

    <span class="badge badge--soon">Coming soon</span>
    <span class="badge">8 h</span>

</div>

### Connect it to code

<div class="grid cards cols-2" markdown>

-   :material-swap-horizontal: **5 · Object-Relational Mapping**

    ---

    Map the wallet's classes to tables, and work with the database
    through Python objects.

    <span class="badge badge--soon">Coming soon</span>
    <span class="badge">24 h</span>

-   :material-api: **6 · RESTful API**

    ---

    Serve the wallet over HTTP: endpoints, methods, status codes and
    JSON.

    <span class="badge badge--soon">Coming soon</span>
    <span class="badge">8 h</span>

</div>

!!! ai "AI in the loop"

    This module is where code starts touching real data. Assistants
    write file, SQL and API code quickly, and a single wrong mode, a
    missing `WHERE` or an unvalidated request can destroy or expose data.
    Before you run anything an assistant wrote, ask: *what does this do
    to the data if it fails halfway?* Read it until you can answer.
