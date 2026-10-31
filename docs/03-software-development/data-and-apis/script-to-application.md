# From Script to Application

<span class="badge badge--time">40 min</span>
<span class="badge badge--level">Data & APIs</span>
<span class="badge">Needs: Introduction to Design Patterns</span>

The wallet you built in Object-Oriented Design is one file of 540
lines. In this module it becomes an application: it will save its data,
move into a database and answer requests over the web. Before it can
grow like that, it needs a structure. In this short tutorial you split
the single file into a **package** of small modules, without changing
what the program does, and prove that nothing changed.

## Why this matters

One long file works until several things happen at once. You cannot
find anything without searching. Two teammates editing different
classes still edit the same file, and their pull requests conflict.
Every import loads everything. And the next steps, files, a database,
an API, each add hundreds of lines.

Real applications are organised into packages, one module per
responsibility. Every framework you will use expects that shape, and so
does every codebase you will join. Learning to split a program safely
is also your first real **refactor**: improving the structure of code
while keeping its behaviour exactly the same.

## Where we left off

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 120" role="img" aria-labelledby="s2a-plan-title s2a-plan-desc">
<title id="s2a-plan-title">How the wallet application grows across Data &amp; APIs</title>
<desc id="s2a-plan-desc">Version 6, From Script to Application: the wallet package: this page. Version 7, File Handling: a snapshot and a journal: coming next. Version 8, SQL CRUD: tables and rows: coming next. Version 9, Joins: data across tables: coming next. Version 10, Database design: a normalised schema: coming next. Version 11, ORM: classes mapped to tables: coming next. Version 12, REST API: the wallet over HTTP: coming next.</desc>
<defs><marker id="s2a-plan-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<rect x="3" y="16" width="86" height="88" rx="10" fill="var(--h-cherry)"/>
<rect x="101" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="199" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="297" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="395" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="493" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="591" y="16" width="86" height="88" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<g text-anchor="middle">
<text x="46" y="38" font-size="10" font-weight="700" fill="#ffffff" opacity="0.85">v6 · NOW</text>
<text x="46" y="64" font-size="12.5" font-weight="700" fill="#ffffff">Package</text>
<text x="46" y="84" font-size="10" fill="#ffffff" opacity="0.9">modules</text>
<text x="144" y="38" font-size="10" font-weight="700" fill="var(--h-fig-muted)">v7</text>
<text x="144" y="64" font-size="12.5" font-weight="700" fill="var(--h-fig-text)">Files</text>
<text x="144" y="84" font-size="10" fill="var(--h-fig-muted)">JSON, journal</text>
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
<g stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#s2a-plan-arrow)">
<line x1="91" y1="60" x2="99" y2="60"/>
<line x1="189" y1="60" x2="197" y2="60"/>
<line x1="287" y1="60" x2="295" y2="60"/>
<line x1="385" y1="60" x2="393" y2="60"/>
<line x1="483" y1="60" x2="491" y2="60"/>
<line x1="581" y1="60" x2="589" y2="60"/>
</g>
</svg>
</figure>

The wallet keeps growing in the same companion repository,
[evisp/oop-wallet](https://github.com/evisp/oop-wallet), and the version
numbers carry on: this tutorial is `v6-package`. Start from the tag
[`v5-patterns`](https://github.com/evisp/oop-wallet/tree/v5-patterns).

## Step 1: Plan the split

Group the code by **responsibility**: things that change together
belong together. The class diagram from the UML tutorial is the best
guide, because its boxes are already the units of the design.

| Module | Contains | Imports from |
|---|---|---|
| `validation.py` | `check_amount` | nothing |
| `mixins.py` | `JSONMixin`, `ObservableMixin` | nothing |
| `payer.py` | the `Payer` interface, `checkout` | nothing |
| `observers.py` | `AuditLog`, `SMSAlert` | nothing |
| `history.py` | `TransactionLog`, `HistoryMixin` | `validation` |
| `accounts.py` | `Account`, `SavingsAccount`, `CheckingAccount` | `validation`, `history`, `mixins`, `payer` |
| `cards.py` | `GiftCard` | `validation`, `history`, `mixins`, `payer` |
| `factory.py` | `AccountFactory`, `account_factory` | `accounts` |
| `decorators.py` | `PayerDecorator`, `SpendingLimit`, `Receipts`, `RoundUp` | `validation`, `payer`, `accounts` |
| `customers.py` | `Customer` | `accounts`, `cards`, `factory`, `mixins` |

Write the last column before you move any code. It is the plan for the
imports, and it shows straight away whether the split will work, as
Step 4 explains.

Then, before you move a single line, save what the program prints now.
You will need it in Step 6 to prove the split changed nothing:

```bash
./wallet.py > /tmp/before.txt
```

## Step 2: Packages and `__init__.py`

A **package** is a folder of modules with a file called `__init__.py`
in it. The folder name becomes the package name:

```text
oop-wallet/
├── wallet/                 # the package
│   ├── __init__.py         # runs when anyone imports wallet
│   ├── validation.py
│   ├── mixins.py
│   ├── payer.py
│   ├── observers.py
│   ├── history.py
│   ├── accounts.py
│   ├── cards.py
│   ├── factory.py
│   ├── decorators.py
│   └── customers.py
├── main.py                 # the program you run
├── DESIGN.md
└── README.md
```

Each module can now be imported on its own, with a dotted name:

```python
from wallet.accounts import SavingsAccount
from wallet.factory import account_factory
```

`__init__.py` runs the first time anyone imports the package. Use it to
**re-export** the names other code needs, so users of the package do not
have to know which module each class lives in:

```python title="wallet/__init__.py"
"""A small digital wallet, built up across the tutorials.

Version 6: From Script to Application.
"""
from .accounts import Account, CheckingAccount, SavingsAccount
from .cards import GiftCard
from .customers import Customer
from .decorators import PayerDecorator, Receipts, RoundUp, SpendingLimit
from .factory import AccountFactory, account_factory
from .history import TransactionLog
from .observers import AuditLog, SMSAlert
from .payer import Payer, checkout

__all__ = [
    "Account", "AccountFactory", "AuditLog", "CheckingAccount",
    "Customer", "GiftCard", "Payer", "PayerDecorator", "Receipts",
    "RoundUp", "SMSAlert", "SavingsAccount", "SpendingLimit",
    "TransactionLog", "account_factory", "checkout",
]
```

Now `from wallet import Customer` works, exactly as if the package were
still one file. `__all__` lists the public names: it is what
`from wallet import *` imports, and it documents the package's interface
in one place. Anything not listed, such as `check_amount`, is an
internal detail.

## Step 3: Import between modules

Inside a package, modules import from each other with **relative
imports**. A leading dot means "from this package":

```python title="wallet/accounts.py"
"""Accounts: the abstract base and its two kinds."""
from abc import abstractmethod

from .history import HistoryMixin
from .mixins import JSONMixin, ObservableMixin
from .payer import Payer
from .validation import check_amount
```

You could write the absolute form, `from wallet.history import
HistoryMixin`, and it works too. The relative form keeps working if the
package is ever renamed, and makes it obvious that the import is
internal. Standard library imports such as `abc` come first, then a
blank line, then the package's own modules: the order PEP 8 recommends.

### The one rename

In version 5, the amount check was a module-level function called
`_check_amount`. A leading underscore on a module-level name means
*private to this module*. Now that `accounts.py`, `cards.py`,
`history.py` and `decorators.py` all import it from `validation.py`, it
is no longer private to anything. It becomes `check_amount`, and that is
the only name that changes in the whole refactor.

## Step 4: Avoid circular imports

There is one rule that makes a package easy to import: **imports only
point down.** Arrange the modules in layers, so that each one imports
only from the layers below it.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 328" role="img" aria-labelledby="s2a-layers-title s2a-layers-desc">
<title id="s2a-layers-title">The wallet package in layers</title>
<desc id="s2a-layers-desc">main.py, outside the package, imports wallet. wallet's __init__.py re-exports the public names. Inside the package the modules form five layers, and each imports only from layers below it. Layer 4: customers. Layer 3: factory and decorators. Layer 2: accounts and cards. Layer 1: history. Layer 0, which imports nothing from the package: validation, mixins, payer and observers.</desc>
<defs><marker id="s2a-layers-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-cherry)"/></marker></defs>
<line x1="26" y1="22" x2="26" y2="304" stroke="var(--h-cherry)" stroke-width="3" marker-end="url(#s2a-layers-arrow)"/>
<text x="16" y="163" font-size="12" font-weight="700" fill="var(--h-cherry)" text-anchor="middle" transform="rotate(-90 16 163)">imports point down</text>
<rect x="120" y="46" width="557" height="278" rx="14" fill="none" stroke="var(--h-fig-line)" stroke-dasharray="6 4"/>
<text x="134" y="68" font-size="12" font-weight="700" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">wallet/</text>
<g font-size="10.5" font-weight="700" fill="var(--h-fig-muted)" text-anchor="end">
<text x="108" y="28">program</text>
<text x="108" y="74">package</text>
<text x="108" y="120">layer 4</text>
<text x="108" y="166">layer 3</text>
<text x="108" y="212">layer 2</text>
<text x="108" y="258">layer 1</text>
<text x="108" y="304">layer 0</text>
</g>
<g font-size="12" font-weight="700" text-anchor="middle" font-family="var(--md-code-font-family, monospace)">
<rect x="330" y="6" width="140" height="32" rx="8" fill="var(--h-cherry)"/><text x="400" y="27" fill="#ffffff">main.py</text>
<rect x="280" y="54" width="240" height="32" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/><text x="400" y="75" fill="var(--h-fig-text)">__init__.py</text>
<rect x="340" y="100" width="120" height="32" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="400" y="121" fill="var(--h-fig-text)">customers</text>
<rect x="270" y="146" width="120" height="32" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="330" y="167" fill="var(--h-fig-text)">factory</text>
<rect x="410" y="146" width="120" height="32" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="470" y="167" fill="var(--h-fig-text)">decorators</text>
<rect x="270" y="192" width="120" height="32" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="330" y="213" fill="var(--h-fig-text)">accounts</text>
<rect x="410" y="192" width="120" height="32" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="470" y="213" fill="var(--h-fig-text)">cards</text>
<rect x="340" y="238" width="120" height="32" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/><text x="400" y="259" fill="var(--h-fig-text)">history</text>
<rect x="138" y="284" width="120" height="32" rx="8" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)"/><text x="198" y="305" fill="var(--h-fig-text)">validation</text>
<rect x="272" y="284" width="120" height="32" rx="8" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)"/><text x="332" y="305" fill="var(--h-fig-text)">mixins</text>
<rect x="406" y="284" width="120" height="32" rx="8" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)"/><text x="466" y="305" fill="var(--h-fig-text)">payer</text>
<rect x="540" y="284" width="120" height="32" rx="8" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)"/><text x="600" y="305" fill="var(--h-fig-text)">observers</text>
</g>
<line x1="400" y1="38" x2="400" y2="54" stroke="var(--h-fig-line)" stroke-width="2"/>
</svg>
</figure>

The bottom layer imports nothing from the package, so it can always be
loaded first. Each layer above it only needs layers that are already
loaded. With the arrows all pointing one way, there is no loop.

Break the rule and Python cannot finish loading. Suppose `accounts.py`
imported `Customer` from `customers.py`, which imports `Account` from
`accounts.py`. Python starts loading one module, is sent to the other,
and is sent back to the first one before it has finished:

```
ImportError: cannot import name 'Account' from partially initialized
module 'wallet.accounts' (most likely due to a circular import)
```

The fix is never a clever import trick. It is a design question: which
of the two modules should depend on the other? Here, an account does not
need to know about customers, so the import goes in one direction only.
Your UML diagram usually answers this already: follow the arrows.

## Step 5: Give the program an entry point

The package is a library: it defines classes but does nothing by
itself. The demo that used to sit under `if __name__ == "__main__":` at
the bottom of `wallet.py` moves to its own file, outside the package:

```python title="main.py"
#!/usr/bin/env python3
"""Run the wallet demo."""
from wallet import (
    AuditLog, Customer, Receipts, RoundUp, SMSAlert, SpendingLimit,
    checkout,
)


def main():
    """Open accounts, pay with decorators, and report what happened."""
    ada = Customer("Ada", "ada@example.com")
    savings = ada.open_account("savings", balance=1000, rate=2)
    checking = ada.open_account("checking", overdraft=500)

    audit = AuditLog()
    sms = SMSAlert("+355 69 000 0000")
    for account in ada.accounts:
        account.subscribe(audit)
    checking.subscribe(sms, topics=["fee"])

    payer = RoundUp(Receipts(SpendingLimit(checking, limit=500)), savings)
    checkout(payer, 230)
    ada.month_end()

    for account in ada.accounts:
        print(account)
    print(*payer.receipts, sep="\n")
    print(*audit.lines, sep="\n")
    print(*sms.sent, sep="\n")


if __name__ == "__main__":
    main()
```

Two habits from Functions & Modularity appear here. The work happens
inside a function, `main()`, so nothing runs if another file imports
`main.py`. And the guard at the bottom calls it only when the file is
run directly.

Run it from the **root of the repository**, the folder that contains
both `main.py` and `wallet/`:

```bash
cd ~/oop-wallet
./main.py
```

Python looks for imports in the folder of the script you run, which is
how `import wallet` finds the package.

## Step 6: Prove that nothing changed

A refactor that changes behaviour is not a refactor, it is a bug you
have not found yet. Prove it the same way the Checker would: compare the
output before and after, byte for byte. You saved the "before" in
Step 1:

```bash
./main.py > /tmp/after.txt
diff /tmp/before.txt /tmp/after.txt
```

No output from `diff` means the two runs printed exactly the same ten
lines. If you forgot to save the "before", Git still has it:
`git show v5-patterns:wallet.py | python3 - > /tmp/before.txt`. Then run the style and import checks over every module:

```bash
pycodestyle main.py wallet/
python3 -m pyflakes main.py wallet/
```

`pyflakes` catches what `pycodestyle` cannot: an import you forgot, or
one you no longer use. After a split, both are common. Install it in
your venv with `pip install pyflakes`.

!!! tip "One refactor, one commit"

    Commit the split on its own, with no new features mixed in:
    `git rm wallet.py`, `git add wallet main.py`, then
    `git commit -m "Split wallet.py into the wallet package"`. Anyone
    reviewing it, including you in six months, can then trust that the
    commit only moved code.

## The code so far

This is version 6, tagged
[`v6-package`](https://github.com/evisp/oop-wallet/tree/v6-package).
Every class is exactly as it was in version 5; only its location, its
imports and the name `check_amount` changed.

??? example "The wallet package · version 6"

    === "wallet/__init__.py"

        ```python
        """A small digital wallet, built up across the tutorials.

        Version 6: From Script to Application.
        """
        from .accounts import Account, CheckingAccount, SavingsAccount
        from .cards import GiftCard
        from .customers import Customer
        from .decorators import PayerDecorator, Receipts, RoundUp, SpendingLimit
        from .factory import AccountFactory, account_factory
        from .history import TransactionLog
        from .observers import AuditLog, SMSAlert
        from .payer import Payer, checkout

        __all__ = [
            "Account", "AccountFactory", "AuditLog", "CheckingAccount",
            "Customer", "GiftCard", "Payer", "PayerDecorator", "Receipts",
            "RoundUp", "SMSAlert", "SavingsAccount", "SpendingLimit",
            "TransactionLog", "account_factory", "checkout",
        ]
        ```

    === "wallet/validation.py"

        ```python
        """Checks shared by every part of the wallet."""


        def check_amount(amount):
            """Raise if amount is not a positive whole number."""
            if isinstance(amount, bool) or not isinstance(amount, int):
                raise TypeError("amount must be an integer")
            if amount <= 0:
                raise ValueError("amount must be positive")
        ```

    === "wallet/mixins.py"

        ```python
        """Reusable behaviour: JSON export and events."""
        import json


        class JSONMixin:
            """Give a class a dictionary and JSON form of its simple attributes."""

            def to_dict(self):
                """Return the type and simple attributes as a dictionary."""
                data = {"type": type(self).__name__}
                for name, value in vars(self).items():
                    if isinstance(value, (str, int, float, bool)):
                        data[name.lstrip("_")] = value
                return data

            def to_json(self):
                """Return to_dict() as a JSON string."""
                return json.dumps(self.to_dict())


        class ObservableMixin:
            """Let observers subscribe to this object's events, by topic.

            Every recorded transaction is published as an event whose topic is
            its kind: "deposit", "withdraw", "payment", "interest" or "fee".
            """

            def subscribe(self, observer, topics=None):
                """Send observer the events in topics, or every event if None."""
                if not callable(getattr(observer, "notify", None)):
                    raise TypeError("observer must have a notify method")
                if isinstance(topics, str):
                    topics = [topics]
                wanted = None if topics is None else frozenset(topics)
                if "_observers" not in vars(self):
                    self._observers = []
                self._observers.append((observer, wanted))

            def unsubscribe(self, observer):
                """Stop sending events to observer."""
                observers = vars(self).get("_observers", [])
                observers[:] = [(o, t) for o, t in observers if o is not observer]

            def _publish(self, topic, amount):
                """Notify every observer that wants this topic."""
                for observer, wanted in list(vars(self).get("_observers", ())):
                    if wanted is None or topic in wanted:
                        observer.notify(self, topic, amount)

            def _record(self, kind, amount):
                """Record the transaction, then publish it as an event."""
                super()._record(kind, amount)
                self._publish(kind, amount)
        ```

    === "wallet/payer.py"

        ```python
        """The Payer interface, and a checkout that accepts any payer."""
        from abc import ABC, abstractmethod


        class Payer(ABC):
            """Interface: anything that can pay an amount."""

            @abstractmethod
            def pay(self, amount):
                """Pay amount, or raise ValueError; return what is left."""


        def checkout(payer, amount):
            """Charge amount to anything that can pay; return what it returns."""
            return payer.pay(amount)
        ```

    === "wallet/observers.py"

        ```python
        """Observers that react to wallet events."""


        class AuditLog:
            """Observer: keep one line for every event it is sent."""

            def __init__(self):
                self.lines = []

            def notify(self, source, topic, amount):
                """Record the event."""
                self.lines.append(f"{type(source).__name__} {topic} {amount}")


        class SMSAlert:
            """Observer: text a phone number about the events it is sent."""

            def __init__(self, phone):
                self.phone = phone
                self.sent = []

            def notify(self, source, topic, amount):
                """Send a short message about the event."""
                self.sent.append(f"To {self.phone}: {topic} of {amount} ALL")
        ```

    === "wallet/history.py"

        ```python
        """Transaction history: a checked list, and a mixin that keeps one."""
        from .validation import check_amount


        class TransactionLog(list):
            """A list that only accepts (kind, amount) transaction entries."""

            KINDS = ("deposit", "withdraw", "payment", "interest", "fee")

            def __init__(self, entries=()):
                super().__init__()
                self.extend(entries)

            def append(self, entry):
                """Add one entry, after checking it."""
                self._check(entry)
                super().append(entry)

            def extend(self, entries):
                """Add several entries; check them all before adding any."""
                entries = list(entries)
                for entry in entries:
                    self._check(entry)
                super().extend(entries)

            def total(self, kind):
                """Return the sum of all amounts of one kind."""
                return sum(amount for k, amount in self if k == kind)

            def _check(self, entry):
                if not isinstance(entry, tuple) or len(entry) != 2:
                    raise TypeError("entry must be a (kind, amount) tuple")
                kind, amount = entry
                if kind not in self.KINDS:
                    raise ValueError(f"unknown kind: {kind!r}")
                check_amount(amount)


        class HistoryMixin:
            """Give a class a transaction history."""

            def _record(self, kind, amount):
                """Add one entry to this object's history."""
                if "_history" not in vars(self):
                    self._history = TransactionLog()
                self._history.append((kind, amount))

            @property
            def history(self):
                """A copy of the transaction history."""
                return TransactionLog(vars(self).get("_history", ()))
        ```

    === "wallet/accounts.py"

        ```python
        """Accounts: the abstract base and its two kinds."""
        from abc import abstractmethod

        from .history import HistoryMixin
        from .mixins import JSONMixin, ObservableMixin
        from .payer import Payer
        from .validation import check_amount


        class Account(ObservableMixin, HistoryMixin, JSONMixin, Payer):
            """Abstract base for wallet accounts holding money, in whole lek."""

            currency = "ALL"

            def __init__(self, owner, balance=0):
                """Create an account for owner with an opening balance."""
                self.owner = owner
                if isinstance(balance, bool) or not isinstance(balance, int):
                    raise TypeError("balance must be an integer")
                if balance < 0:
                    raise ValueError("balance must not be negative")
                self._balance = balance
                if balance:
                    self._record("deposit", balance)

            @property
            def owner(self):
                """The account holder's name."""
                return self._owner

            @owner.setter
            def owner(self, value):
                if not isinstance(value, str):
                    raise TypeError("owner must be a string")
                if not value.strip():
                    raise ValueError("owner must not be empty")
                self._owner = value.strip()

            @property
            def balance(self):
                """The current balance. Read-only: use deposit and withdraw."""
                return self._balance

            def deposit(self, amount):
                """Add amount to the balance and return the new balance."""
                check_amount(amount)
                self._balance += amount
                self._record("deposit", amount)
                return self._balance

            def withdraw(self, amount):
                """Take amount from the balance and return the new balance."""
                check_amount(amount)
                if amount > self._balance:
                    raise ValueError("insufficient funds")
                self._balance -= amount
                self._record("withdraw", amount)
                return self._balance

            def pay(self, amount):
                """Pay amount from this account; return the new balance."""
                return self.withdraw(amount)

            @abstractmethod
            def month_end(self):
                """Apply end-of-month rules and return the new balance."""

            def __str__(self):
                return f"{self.owner}: {self.balance} {self.currency}"

            def __repr__(self):
                return (f"{type(self).__name__}(owner={self.owner!r}, "
                        f"balance={self.balance})")


        class SavingsAccount(Account):
            """An account that earns interest every month."""

            def __init__(self, owner, balance=0, rate=1):
                """Create a savings account; rate is monthly interest in percent."""
                super().__init__(owner, balance)
                if isinstance(rate, bool) or not isinstance(rate, int):
                    raise TypeError("rate must be an integer")
                if not 0 <= rate <= 10:
                    raise ValueError("rate must be between 0 and 10")
                self._rate = rate

            @property
            def rate(self):
                """Monthly interest rate, in whole percent."""
                return self._rate

            def add_interest(self):
                """Add this month's interest and return the amount added."""
                interest = self._balance * self._rate // 100
                if interest > 0:
                    self._balance += interest
                    self._record("interest", interest)
                return interest

            def month_end(self):
                """Add this month's interest and return the new balance."""
                self.add_interest()
                return self._balance

            def __repr__(self):
                return (f"{type(self).__name__}(owner={self.owner!r}, "
                        f"balance={self.balance}, rate={self.rate})")


        class CheckingAccount(Account):
            """An everyday account that may go below zero, up to a limit."""

            fee = 100

            def __init__(self, owner, balance=0, overdraft=0):
                """Create a checking account with an overdraft limit."""
                super().__init__(owner, balance)
                if isinstance(overdraft, bool) or not isinstance(overdraft, int):
                    raise TypeError("overdraft must be an integer")
                if overdraft < 0:
                    raise ValueError("overdraft must not be negative")
                self._overdraft = overdraft

            @property
            def overdraft(self):
                """How far below zero the balance may go."""
                return self._overdraft

            def withdraw(self, amount):
                """Take amount out, letting the balance go down to -overdraft."""
                check_amount(amount)
                if self._balance - amount < -self._overdraft:
                    raise ValueError("overdraft limit exceeded")
                self._balance -= amount
                self._record("withdraw", amount)
                return self._balance

            def month_end(self):
                """Charge the monthly fee if overdrawn; return the new balance."""
                if self._balance < 0:
                    self._balance -= self.fee
                    self._record("fee", self.fee)
                return self._balance

            def __str__(self):
                return f"{super().__str__()} (overdraft {self.overdraft})"

            def __repr__(self):
                return (f"{type(self).__name__}(owner={self.owner!r}, "
                        f"balance={self.balance}, overdraft={self.overdraft})")
        ```

    === "wallet/cards.py"

        ```python
        """Gift cards: payers that are not accounts."""
        from .history import HistoryMixin
        from .mixins import JSONMixin, ObservableMixin
        from .payer import Payer
        from .validation import check_amount


        class GiftCard(ObservableMixin, HistoryMixin, JSONMixin, Payer):
            """A prepaid card with a fixed value. It is not an account."""

            currency = "ALL"

            def __init__(self, code, value):
                """Create a gift card with a code and a starting value."""
                if not isinstance(code, str) or not code.strip():
                    raise ValueError("code must be a non-empty string")
                check_amount(value)
                self._code = code.strip()
                self._value = value
                self._holder = None

            @property
            def holder(self):
                """The customer holding this card, or None."""
                return self._holder

            @property
            def value(self):
                """What is left on the card."""
                return self._value

            def pay(self, amount):
                """Pay amount from the card; return the value left."""
                check_amount(amount)
                if amount > self._value:
                    raise ValueError("not enough value on the card")
                self._value -= amount
                self._record("payment", amount)
                return self._value

            def __str__(self):
                return f"Gift card {self._code}: {self.value} {self.currency}"

            def __repr__(self):
                return f"GiftCard(code={self._code!r}, value={self.value})"
        ```

    === "wallet/factory.py"

        ```python
        """Create accounts by kind, without naming their classes."""
        from .accounts import Account, CheckingAccount, SavingsAccount


        class AccountFactory:
            """Create accounts by kind, from a registry of account classes."""

            def __init__(self):
                self._registry = {}

            def register(self, kind, account_class):
                """Make kind create account_class, and return account_class."""
                if not isinstance(kind, str) or not kind.strip():
                    raise ValueError("kind must be a non-empty string")
                if not (isinstance(account_class, type)
                        and issubclass(account_class, Account)):
                    raise TypeError("account_class must be a subclass of Account")
                self._registry[kind] = account_class
                return account_class

            def create(self, kind, owner, **options):
                """Create an account of a registered kind."""
                if kind not in self._registry:
                    raise ValueError(f"unknown account kind: {kind!r}")
                return self._registry[kind](owner, **options)

            def kinds(self):
                """The registered kinds, sorted."""
                return sorted(self._registry)


        account_factory = AccountFactory()
        account_factory.register("savings", SavingsAccount)
        account_factory.register("checking", CheckingAccount)
        ```

    === "wallet/decorators.py"

        ```python
        """Decorators that add behaviour to any payer."""
        from .accounts import Account
        from .payer import Payer
        from .validation import check_amount


        class PayerDecorator(Payer):
            """Wrap a payer to add behaviour to pay; forward everything else."""

            def __init__(self, wrapped):
                if not callable(getattr(wrapped, "pay", None)):
                    raise TypeError("wrapped must have a pay method")
                self._wrapped = wrapped

            def pay(self, amount):
                """Pass the payment on to the wrapped payer."""
                return self._wrapped.pay(amount)

            def __getattr__(self, name):
                return getattr(self._wrapped, name)

            def __str__(self):
                return str(self._wrapped)

            def __repr__(self):
                return f"{type(self).__name__}({self._wrapped!r})"


        class SpendingLimit(PayerDecorator):
            """Refuse any single payment above a limit."""

            def __init__(self, wrapped, limit):
                super().__init__(wrapped)
                check_amount(limit)
                self._limit = limit

            def pay(self, amount):
                """Pay amount, unless it is over the limit."""
                if amount > self._limit:
                    raise ValueError(f"payment over the limit of {self._limit}")
                return super().pay(amount)


        class Receipts(PayerDecorator):
            """Keep a receipt for every payment that goes through."""

            def __init__(self, wrapped):
                super().__init__(wrapped)
                self.receipts = []

            def pay(self, amount):
                """Pay amount, then write a receipt."""
                result = super().pay(amount)
                self.receipts.append(f"Paid {amount} ALL")
                return result


        class RoundUp(PayerDecorator):
            """Round each payment up to the next 100 and save the difference."""

            def __init__(self, wrapped, savings):
                super().__init__(wrapped)
                if not isinstance(savings, Account):
                    raise TypeError("savings must be an Account")
                self._savings = savings

            def pay(self, amount):
                """Pay amount, then move the round-up into savings if possible."""
                result = super().pay(amount)
                spare = -amount % 100
                if spare:
                    try:
                        result = super().pay(spare)
                    except ValueError:
                        return result
                    self._savings.deposit(spare)
                return result
        ```

    === "wallet/customers.py"

        ```python
        """Customers, who hold accounts and gift cards."""
        from .accounts import Account
        from .cards import GiftCard
        from .factory import account_factory
        from .mixins import JSONMixin


        class Customer(JSONMixin):
            """A wallet customer, who can hold accounts and gift cards."""

            def __init__(self, name, email):
                """Create a customer with a name and an email address."""
                if not isinstance(name, str) or not name.strip():
                    raise ValueError("name must be a non-empty string")
                if not isinstance(email, str) or "@" not in email:
                    raise ValueError("email must contain @")
                self._name = name.strip()
                self._email = email.strip()
                self._accounts = []
                self._gift_cards = []

            @property
            def name(self):
                """The customer's name."""
                return self._name

            @property
            def email(self):
                """The customer's email address."""
                return self._email

            @property
            def accounts(self):
                """The customer's accounts, as a tuple."""
                return tuple(self._accounts)

            @property
            def gift_cards(self):
                """The customer's gift cards, as a tuple."""
                return tuple(self._gift_cards)

            def add_account(self, account):
                """Add an account this customer owns, and return it."""
                if not isinstance(account, Account):
                    raise TypeError("account must be an Account")
                if account.owner != self._name:
                    raise ValueError("account belongs to another customer")
                if account in self._accounts:
                    raise ValueError("account already added")
                self._accounts.append(account)
                return account

            def open_account(self, kind, **options):
                """Open a new account of a registered kind, and return it."""
                account = account_factory.create(kind, self._name, **options)
                return self.add_account(account)

            def add_gift_card(self, card):
                """Give this customer a gift card nobody else holds; return it."""
                if not isinstance(card, GiftCard):
                    raise TypeError("card must be a GiftCard")
                if card.holder is not None:
                    raise ValueError("gift card already has a holder")
                card._holder = self
                self._gift_cards.append(card)
                return card

            def total_balance(self):
                """Return the sum of all account balances."""
                return sum(account.balance for account in self._accounts)

            def month_end(self):
                """Run the end-of-month rules on every account."""
                for account in self._accounts:
                    account.month_end()

            def __str__(self):
                return (f"{self.name} <{self.email}>: "
                        f"accounts: {len(self._accounts)}, "
                        f"gift cards: {len(self._gift_cards)}")

            def __repr__(self):
                return f"Customer(name={self.name!r}, email={self.email!r})"
        ```

    === "main.py"

        ```python
        #!/usr/bin/env python3
        """Run the wallet demo."""
        from wallet import (
            AuditLog, Customer, Receipts, RoundUp, SMSAlert, SpendingLimit,
            checkout,
        )


        def main():
            """Open accounts, pay with decorators, and report what happened."""
            ada = Customer("Ada", "ada@example.com")
            savings = ada.open_account("savings", balance=1000, rate=2)
            checking = ada.open_account("checking", overdraft=500)

            audit = AuditLog()
            sms = SMSAlert("+355 69 000 0000")
            for account in ada.accounts:
                account.subscribe(audit)
            checking.subscribe(sms, topics=["fee"])

            payer = RoundUp(Receipts(SpendingLimit(checking, limit=500)), savings)
            checkout(payer, 230)
            ada.month_end()

            for account in ada.accounts:
                print(account)
            print(*payer.receipts, sep="\n")
            print(*audit.lines, sep="\n")
            print(*sms.sent, sep="\n")


        if __name__ == "__main__":
            main()
        ```

!!! ai "AI in the loop"

    Assistants are good at mechanical moves, and splitting a file is
    one. Write your own plan first, the table from Step 1, then ask an
    assistant to *check* it: *"Here are my modules and what each imports.
    Is there a circular import? Is anything in the wrong layer?"* If you
    let it do the move, run the `diff` from Step 6 before you trust a
    single line.

## When something goes wrong

??? note "`ModuleNotFoundError: No module named 'wallet'`"

    You ran `main.py` from the wrong folder, for example from inside
    `wallet/`. Go to the folder that contains both `main.py` and
    `wallet/`, and run it from there.

??? note "`ImportError: attempted relative import with no known parent package`"

    You ran a module inside the package directly, such as
    `python3 wallet/accounts.py`. Modules with relative imports are
    meant to be imported, not run. Run `main.py`, or test a module with
    `python3 -c "from wallet.accounts import Account"`.

??? note "`ImportError: cannot import name ... from partially initialized module`"

    A circular import: two modules import each other. Decide which one
    should depend on the other, and remove the import going the other
    way.

??? note "My changes to `wallet.py` have no effect"

    The old file is still there next to the new package, and the package
    wins: Python imports the `wallet/` folder and silently ignores
    `wallet.py`. Delete the old file with `git rm wallet.py`.

## Explain it to someone

- [ ] Why a growing program is split into modules, and how to decide what goes where
- [ ] What a package is, and what `__init__.py` does
- [ ] What re-exporting and `__all__` give the users of a package
- [ ] The difference between relative and absolute imports, and when to use each
- [ ] Why `_check_amount` became `check_amount`
- [ ] What a circular import is, and how layering prevents one
- [ ] Why the program's entry point lives outside the package
- [ ] How to prove that a refactor did not change behaviour

## Quick reference

| Code | What it does |
|---|---|
| `wallet/__init__.py` | Makes `wallet/` a package; runs on first import |
| `from .accounts import Account` | Relative import, inside the package |
| `from wallet.accounts import Account` | Absolute import, from anywhere |
| `__all__ = [...]` | The package's public names |
| `def main():` + `if __name__ == "__main__": main()` | A program's entry point |
| `diff before.txt after.txt` | Prove two outputs are identical |
| `python3 -m pyflakes wallet/` | Find unused and missing imports |

## Next

The wallet is now an application with a structure that can grow. But
every time it stops, everything it knew is gone. Next you teach it to
remember: save to files, and read them back.

[File Handling](files.md){ .h-button }
