# Object-Oriented Design

Model problems with classes: bundle data with the rules that protect
it, build families of related types, and describe your design with UML
and design patterns. Five projects, one running example.

<span class="badge badge--level">Foundations</span>
<span class="badge badge--time">40 h</span>
<span class="badge">5 projects</span>
<span class="badge">Needs: Python Fundamentals</span>

<p class="h-progress-label"><span>Tutorials published</span><span>2 of 5</span></p>
<div class="h-progress" role="img" aria-label="2 of 5 tutorials published"><span style="width: 40%"></span></div>

## One example, five projects

Every tutorial in this module builds on the same small digital wallet.
You start with a single `Account` class and finish with a family of
account types, a design you can draw in UML, and the patterns that keep
it easy to change.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 130" role="img" aria-labelledby="oop-idx-plan-title oop-idx-plan-desc">
<title id="oop-idx-plan-title">How the wallet grows across the module</title>
<desc id="oop-idx-plan-desc">Version 1, Classes: the Account class. Version 2, Inheritance: savings and checking accounts. Both are ready. Version 3, Abstract classes: contracts and mixins. Version 4, UML: drawing the design. Version 5, Patterns: Strategy and Observer.</desc>
<defs><marker id="oop-idx-plan-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<rect x="3" y="20" width="122" height="90" rx="10" fill="var(--h-cherry)"/>
<rect x="141" y="20" width="122" height="90" rx="10" fill="var(--h-cherry)"/>
<rect x="279" y="20" width="122" height="90" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="417" y="20" width="122" height="90" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="555" y="20" width="122" height="90" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<g text-anchor="middle">
<text x="64" y="44" font-size="11" font-weight="700" fill="#ffffff" opacity="0.85">v1 · READY</text>
<text x="64" y="70" font-size="14" font-weight="700" fill="#ffffff">Classes</text>
<text x="64" y="90" font-size="11" fill="#ffffff" opacity="0.9" font-family="var(--md-code-font-family, monospace)">Account</text>
<text x="202" y="44" font-size="11" font-weight="700" fill="#ffffff" opacity="0.85">v2 · READY</text>
<text x="202" y="70" font-size="14" font-weight="700" fill="#ffffff">Inheritance</text>
<text x="202" y="90" font-size="11" fill="#ffffff" opacity="0.9">savings, checking</text>
<text x="340" y="44" font-size="11" font-weight="700" fill="var(--h-fig-muted)">v3</text>
<text x="340" y="70" font-size="14" font-weight="700" fill="var(--h-fig-text)">Abstract</text>
<text x="340" y="90" font-size="11" fill="var(--h-fig-muted)">contracts, mixins</text>
<text x="478" y="44" font-size="11" font-weight="700" fill="var(--h-fig-muted)">v4</text>
<text x="478" y="70" font-size="14" font-weight="700" fill="var(--h-fig-text)">UML</text>
<text x="478" y="90" font-size="11" fill="var(--h-fig-muted)">draw the design</text>
<text x="616" y="44" font-size="11" font-weight="700" fill="var(--h-fig-muted)">v5</text>
<text x="616" y="70" font-size="14" font-weight="700" fill="var(--h-fig-text)">Patterns</text>
<text x="616" y="90" font-size="11" fill="var(--h-fig-muted)">Strategy, Observer</text>
</g>
<g stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#oop-idx-plan-arrow)">
<line x1="127" y1="65" x2="138" y2="65"/>
<line x1="265" y1="65" x2="276" y2="65"/>
<line x1="403" y1="65" x2="414" y2="65"/>
<line x1="541" y1="65" x2="552" y2="65"/>
</g>
</svg>
</figure>

!!! tip "Companion repository"

    The code for each stage is in
    [evisp/oop-wallet](https://github.com/evisp/oop-wallet), saved under a
    Git tag per tutorial: `v1-classes`, `v2-inheritance`, and so on.
    Write each version yourself first, then compare it with the tag.

## The path

### Build with objects

<div class="grid cards cols-3" markdown>

-   :material-cube-outline: **1 · Classes & Object Model**

    ---

    Classes and instances, `__init__`, validation, properties and
    string representations.

    <span class="badge badge--ready">Ready</span>
    <span class="badge">8 h</span>

    [:octicons-arrow-right-24: Start](classes.md)

-   :material-family-tree: **2 · Inheritance & Polymorphism**

    ---

    Subclasses that extend and override, and one method call that
    works across types.

    <span class="badge badge--ready">Ready</span>
    <span class="badge">8 h</span>

    [:octicons-arrow-right-24: Start](inheritance.md)

-   :material-file-certificate-outline: **3 · Abstract Classes & Interfaces**

    ---

    Contracts with `ABC`, duck typing, extending built-ins, and mixins.

    <span class="badge badge--soon">Coming soon</span>
    <span class="badge">8 h</span>

</div>

### Design with objects

<div class="grid cards cols-2" markdown>

-   :material-vector-square: **4 · Introduction to UML Modeling**

    ---

    Draw the wallet as class diagrams: attributes, methods,
    inheritance and relationships.

    <span class="badge badge--soon">Coming soon</span>
    <span class="badge">8 h</span>

-   :material-puzzle-outline: **5 · Introduction to Design Patterns**

    ---

    Reshape the wallet with proven solutions such as Strategy and
    Observer.

    <span class="badge badge--soon">Coming soon</span>
    <span class="badge">8 h</span>

</div>

!!! ai "AI in the loop"

    Object-oriented code is where assistants are most tempting: ask for
    a class and you get fifty tidy lines. Write your own design first,
    from the description in each tutorial, then ask an assistant to
    *review* it: what could put the object into an invalid state, which
    names are unclear, what would be hard to change. You learn design by
    making the decisions, not by reading someone else's.
