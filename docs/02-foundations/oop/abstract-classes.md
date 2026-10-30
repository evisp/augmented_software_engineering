# Abstract Classes & Interfaces

<span class="badge badge--time">90 min</span>
<span class="badge badge--level">Object-Oriented Design</span>
<span class="badge">Needs: Inheritance & Polymorphism</span>

Inheritance lets classes share code. This tutorial is about sharing
**promises**: what every class of a kind must be able to do. You turn
`Account` into an abstract contract, let gift cards pay alongside
accounts, give the wallet a transaction log that behaves like a list,
and add reusable behaviour with mixins. By the end, the wallet's design
is something you could hand to another developer and they would know
exactly what each class guarantees.

## Why this matters

Version 2 works, but it relies on good behaviour. Nothing stops someone
creating a plain `Account`, which has no real end-of-month rule, or
adding a new account type and forgetting `month_end`. The mistake shows
up much later, as a wrong balance.

Large codebases, frameworks and libraries all deal with this the same
way: they define **contracts** that classes must fulfil, and check
them as early as possible. Knowing how to read and write those
contracts is what lets you plug your code into someone else's.

## Where we left off

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 130" role="img" aria-labelledby="oop3-plan-title oop3-plan-desc">
<title id="oop3-plan-title">How the wallet grows across the module</title>
<desc id="oop3-plan-desc">Version 1, Classes: the Account class: done. Version 2, Inheritance: savings and checking accounts: done. Version 3, Abstract classes: contracts and mixins: this page. Version 4, UML: drawing the design: coming next. Version 5, Patterns: Factory, Observer and Decorator: coming next.</desc>
<defs><marker id="oop3-plan-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<rect x="3" y="20" width="122" height="90" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<rect x="141" y="20" width="122" height="90" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<rect x="279" y="20" width="122" height="90" rx="10" fill="var(--h-cherry)"/>
<rect x="417" y="20" width="122" height="90" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="555" y="20" width="122" height="90" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<g text-anchor="middle">
<text x="64" y="44" font-size="11" font-weight="700" fill="var(--h-fig-muted)">v1 · DONE</text>
<text x="64" y="70" font-size="14" font-weight="700" fill="var(--h-fig-text)">Classes</text>
<text x="64" y="90" font-size="11" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">Account</text>
<text x="202" y="44" font-size="11" font-weight="700" fill="var(--h-fig-muted)">v2 · DONE</text>
<text x="202" y="70" font-size="14" font-weight="700" fill="var(--h-fig-text)">Inheritance</text>
<text x="202" y="90" font-size="11" fill="var(--h-fig-muted)">savings, checking</text>
<text x="340" y="44" font-size="11" font-weight="700" fill="#ffffff" opacity="0.85">v3 · THIS PAGE</text>
<text x="340" y="70" font-size="14" font-weight="700" fill="#ffffff">Abstract</text>
<text x="340" y="90" font-size="11" fill="#ffffff" opacity="0.9">contracts, mixins</text>
<text x="478" y="44" font-size="11" font-weight="700" fill="var(--h-fig-muted)">v4</text>
<text x="478" y="70" font-size="14" font-weight="700" fill="var(--h-fig-text)">UML</text>
<text x="478" y="90" font-size="11" fill="var(--h-fig-muted)">draw the design</text>
<text x="616" y="44" font-size="11" font-weight="700" fill="var(--h-fig-muted)">v5</text>
<text x="616" y="70" font-size="14" font-weight="700" fill="var(--h-fig-text)">Patterns</text>
<text x="616" y="90" font-size="11" fill="var(--h-fig-muted)">three patterns</text>
</g>
<g stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#oop3-plan-arrow)">
<line x1="127" y1="65" x2="138" y2="65"/>
<line x1="265" y1="65" x2="276" y2="65"/>
<line x1="403" y1="65" x2="414" y2="65"/>
<line x1="541" y1="65" x2="552" y2="65"/>
</g>
</svg>
</figure>

Start from version 2, or the tag
[`v2-inheritance`](https://github.com/evisp/oop-wallet/tree/v2-inheritance):
an `Account` base class with `SavingsAccount` and `CheckingAccount`
below it. The wallet now has three new requirements:

> 1. There is no such thing as a plain account. Every account type
>    must define its own end-of-month rule.
> 2. Customers can also pay with **gift cards**. A gift card has a code
>    and a value, but it is not an account.
> 3. Accounts and gift cards keep a **history** of every transaction,
>    and can be exported as **JSON** for other systems.

This is where the design is heading:

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 324" role="img" aria-labelledby="oop3-map-title oop3-map-desc">
<title id="oop3-map-title">The wallet design at version 3</title>
<desc id="oop3-map-desc">Payer is an interface with one method, pay. Account is an abstract class that implements Payer and declares the abstract method month_end. GiftCard also implements Payer but is not an account. Both Account and GiftCard mix in HistoryMixin and JSONMixin. SavingsAccount and CheckingAccount inherit from Account and implement month_end. Every history is a TransactionLog, which extends the built-in list.</desc>
<defs><marker id="oop3-map-tri" viewBox="0 0 12 12" refX="11" refY="6" markerWidth="11" markerHeight="11" orient="auto-start-reverse"><path d="M1 1 L11 6 L1 11 z" fill="var(--md-default-bg-color)" stroke="var(--h-fig-text)" stroke-width="1.3"/></marker></defs>
<rect x="240" y="8" width="200" height="66" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5" stroke-dasharray="6 4"/>
<text x="340" y="26" text-anchor="middle" font-size="10.5" fill="var(--h-fig-muted)">«interface»</text>
<text x="340" y="46" text-anchor="middle" font-size="14" font-weight="700" fill="var(--h-fig-text)">Payer</text>
<text x="340" y="64" text-anchor="middle" font-size="12" font-style="italic" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">pay(amount)</text>
<rect x="40" y="118" width="260" height="96" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="170" y="136" text-anchor="middle" font-size="10.5" fill="var(--h-fig-muted)">«abstract»</text>
<text x="170" y="156" text-anchor="middle" font-size="14" font-weight="700" font-style="italic" fill="var(--h-fig-text)">Account</text>
<line x1="40" y1="166" x2="300" y2="166" stroke="var(--h-fig-line)"/>
<text x="58" y="186" font-size="12" font-style="italic" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">month_end()  <tspan font-style="normal" font-size="10.5" fill="var(--h-fig-muted)" font-family="var(--md-text-font-family, sans-serif)">abstract</tspan></text>
<text x="58" y="205" font-size="11.5" font-weight="700" fill="var(--h-cherry)">+ HistoryMixin, JSONMixin</text>
<rect x="380" y="118" width="260" height="96" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="510" y="156" text-anchor="middle" font-size="14" font-weight="700" fill="var(--h-fig-text)">GiftCard</text>
<line x1="380" y1="166" x2="640" y2="166" stroke="var(--h-fig-line)"/>
<text x="398" y="186" font-size="12" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">pay(amount)</text>
<text x="398" y="205" font-size="11.5" font-weight="700" fill="var(--h-cherry)">+ HistoryMixin, JSONMixin</text>
<g stroke="var(--h-fig-text)" stroke-width="1.5" fill="none">
<line x1="170" y1="118" x2="296" y2="78" stroke-dasharray="6 4" marker-end="url(#oop3-map-tri)"/>
<line x1="510" y1="118" x2="384" y2="78" stroke-dasharray="6 4" marker-end="url(#oop3-map-tri)"/>
<line x1="170" y1="238" x2="170" y2="218" marker-end="url(#oop3-map-tri)"/>
<polyline points="98,258 98,238 298,238 298,258"/>
</g>
<text x="232" y="100" font-size="10.5" fill="var(--h-fig-muted)" text-anchor="end">implements</text>
<text x="452" y="100" font-size="10.5" fill="var(--h-fig-muted)">implements</text>
<rect x="3" y="258" width="190" height="58" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="98" y="281" text-anchor="middle" font-size="13" font-weight="700" fill="var(--h-fig-text)">SavingsAccount</text>
<text x="98" y="301" text-anchor="middle" font-size="11.5" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">month_end()</text>
<rect x="203" y="258" width="190" height="58" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="298" y="281" text-anchor="middle" font-size="13" font-weight="700" fill="var(--h-fig-text)">CheckingAccount</text>
<text x="298" y="301" text-anchor="middle" font-size="11.5" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">month_end()</text>
<rect x="447" y="258" width="230" height="58" rx="10" fill="var(--h-cherry)"/>
<text x="562" y="281" text-anchor="middle" font-size="13" font-weight="700" fill="#ffffff">TransactionLog</text>
<text x="562" y="301" text-anchor="middle" font-size="11" fill="#ffffff" opacity="0.9">extends list · every history is one</text>
<line x1="562" y1="214" x2="562" y2="256" stroke="var(--h-fig-line)" stroke-width="1.5" stroke-dasharray="4 3"/>
<text x="572" y="240" font-size="10.5" fill="var(--h-fig-muted)">history</text>
</svg>
</figure>

Dashed outlines mark contracts, *italic* names mark abstract parts, and
the hollow arrowheads point from a class to what it inherits from or
implements. You will meet this notation properly in the UML project.

## Step 1: Abstract classes and `@abstractmethod`

An **abstract class** is a class that is not meant to be used on its
own. It holds the code its subclasses share, and declares the methods
each subclass *must* provide. Python's `abc` module provides the tools:
inherit from `ABC`, and mark the required methods with
`@abstractmethod`.

```python
from abc import ABC, abstractmethod


class Account(ABC):
    """Abstract base for wallet accounts holding money, in whole lek."""

    # __init__, owner, balance, deposit, withdraw, __str__, __repr__
    # stay exactly as in version 2

    @abstractmethod
    def month_end(self):
        """Apply end-of-month rules and return the new balance."""
```

The body of `month_end` is now just a docstring. It says what the
method must do, not how. Python then enforces the contract in two
places.

**You cannot create the abstract class itself:**

```python
Account("Ada", 500)
# TypeError: Can't instantiate abstract class Account without an
# implementation for abstract method 'month_end'
```

**You cannot create a subclass that forgets the method:**

```python
class BusinessAccount(Account):
    pass


BusinessAccount("Acme", 10)
# TypeError: Can't instantiate abstract class BusinessAccount without an
# implementation for abstract method 'month_end'
```

The error comes when the object is **created**, not when `month_end` is
finally called at the end of the month. That is the whole point: the
mistake surfaces at once, on the line that caused it.

`SavingsAccount` and `CheckingAccount` already define `month_end`, so
they satisfy the contract and work unchanged. Define it in
`BusinessAccount` and that works too:

```python
class BusinessAccount(Account):
    def month_end(self):
        return self._balance


acme = BusinessAccount("Acme", 10)
acme.deposit(5)          # 15: deposit is inherited, as before
```

Notice what an abstract class is *not*: it is not empty. `Account`
still contains all of its working code, `deposit`, `withdraw`, the
properties and the string methods. An abstract class is a **partly
built class**: shared code, plus clearly marked gaps that every
subclass must fill.

In version 2, the plain `Account.month_end` did nothing. That was a
hint. A method that "does nothing, override me" is a missing contract.

## Step 2: Interfaces

An abstract class that contains **only** abstract methods, and no code
at all, describes pure capability: *what* an object can do, and nothing
about *how*. Other languages call that an **interface** and have a
keyword for it. Python models it with the same tool, an `ABC`.

Both accounts and gift cards can pay. That shared capability becomes an
interface:

```python
class Payer(ABC):
    """Interface: anything that can pay an amount."""

    @abstractmethod
    def pay(self, amount):
        """Pay amount, or raise ValueError; return what is left."""
```

`Account` now implements `Payer`. Paying from an account means
withdrawing, so `pay` simply calls `withdraw`:

```python
class Account(Payer):
    ...

    def pay(self, amount):
        """Pay amount from this account; return the new balance."""
        return self.withdraw(amount)
```

Because `Payer` inherits from `ABC`, `Account` is still abstract, with
two methods in its contract: `pay`, which it implements, and
`month_end`, which it leaves to its subclasses. Thanks to polymorphism,
`linus.pay(300)` runs the *checking* version of `withdraw`, overdraft
and all.

A `GiftCard` is not an account, so it must not inherit from `Account`.
But it can pay, so it implements the same interface:

```python
class GiftCard(Payer):
    """A prepaid card with a fixed value. It is not an account."""

    currency = "ALL"

    def __init__(self, code, value):
        """Create a gift card with a code and a starting value."""
        if not isinstance(code, str) or not code.strip():
            raise ValueError("code must be a non-empty string")
        _check_amount(value)
        self._code = code.strip()
        self._value = value

    @property
    def value(self):
        """What is left on the card."""
        return self._value

    def pay(self, amount):
        """Pay amount from the card; return the value left."""
        _check_amount(amount)
        if amount > self._value:
            raise ValueError("not enough value on the card")
        self._value -= amount
        return self._value
```

### One change to version 2

Gift cards need the same amount check as accounts. In version 2 it was
a method, `Account._check_amount`, which a gift card cannot reach. It
now moves out of the class to a plain module-level function,
`_check_amount(amount)`, and every call to `self._check_amount(amount)`
becomes `_check_amount(amount)`. Shared code belongs where everyone who
needs it can reach it, and a function does not force a gift card to
pretend to be an account.

Now code that takes payments can accept **any** `Payer`:

```python
def checkout(payer, amount):
    """Charge amount to anything that can pay; return what it returns."""
    return payer.pay(amount)


checkout(linus, 300)      # -300: a checking account, in its overdraft
checkout(card, 120)       # 180: what is left on the gift card
isinstance(card, Payer)   # True
isinstance(card, Account) # False
```

## Step 3: Duck typing

Look at `checkout` again. It never checks that `payer` is a `Payer`. It
just calls `pay`. That works for any object that has a `pay` method,
whether or not it inherits from `Payer`:

```python
class FakePayer:
    """Records payments instead of making them. Useful in tests."""

    def __init__(self):
        self.paid = []

    def pay(self, amount):
        self.paid.append(amount)
        return 0


fake = FakePayer()
checkout(fake, 50)        # 0
fake.paid                 # [50]
isinstance(fake, Payer)   # False, and checkout did not care
```

This is **duck typing**, from the saying *"if it walks like a duck and
quacks like a duck, it is a duck"*. Python cares what an object can
**do**, not what it **is**. An object that cannot do it fails at the
moment it is asked:

```python
checkout("Ada", 50)
# AttributeError: 'str' object has no attribute 'pay'
```

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 226" role="img" aria-labelledby="oop3-duck-title oop3-duck-desc">
<title id="oop3-duck-title">checkout works with anything that has a pay method</title>
<desc id="oop3-duck-desc">checkout calls payer.pay. A CheckingAccount and a GiftCard both implement the Payer interface and pay. A FakePayer is not a Payer but has a pay method, so it pays too. A string has no pay method, so checkout fails with an AttributeError.</desc>
<defs><marker id="oop3-duck-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker>
<marker id="oop3-duck-arrow-c" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-cherry)"/></marker></defs>
<rect x="3" y="82" width="190" height="62" rx="10" fill="var(--h-cherry)"/>
<text x="98" y="109" text-anchor="middle" font-size="12.5" font-weight="700" fill="#ffffff" font-family="var(--md-code-font-family, monospace)">checkout(payer, 50)</text>
<text x="98" y="129" text-anchor="middle" font-size="11" fill="#ffffff" opacity="0.9" font-family="var(--md-code-font-family, monospace)">payer.pay(50)</text>
<g font-size="12.5">
<rect x="260" y="8" width="417" height="44" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="278" y="35" font-weight="700" fill="var(--h-fig-text)">CheckingAccount</text>
<text x="440" y="35" font-size="11.5" fill="var(--h-fig-muted)">a Payer</text>
<text x="660" y="35" text-anchor="end" font-weight="700" fill="var(--h-fig-text)">pays ✓</text>
<rect x="260" y="62" width="417" height="44" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="278" y="89" font-weight="700" fill="var(--h-fig-text)">GiftCard</text>
<text x="440" y="89" font-size="11.5" fill="var(--h-fig-muted)">a Payer</text>
<text x="660" y="89" text-anchor="end" font-weight="700" fill="var(--h-fig-text)">pays ✓</text>
<rect x="260" y="116" width="417" height="44" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="278" y="143" font-weight="700" fill="var(--h-fig-text)">FakePayer</text>
<text x="440" y="143" font-size="11.5" fill="var(--h-fig-muted)">not a Payer, has pay()</text>
<text x="660" y="143" text-anchor="end" font-weight="700" fill="var(--h-fig-text)">pays ✓</text>
<rect x="260" y="170" width="417" height="44" rx="8" fill="none" stroke="var(--h-cherry)" stroke-dasharray="5 4"/>
<text x="278" y="197" font-weight="700" fill="var(--h-cherry)" font-family="var(--md-code-font-family, monospace)">"Ada"</text>
<text x="440" y="197" font-size="11.5" fill="var(--h-cherry)">no pay()</text>
<text x="660" y="197" text-anchor="end" font-weight="700" fill="var(--h-cherry)">AttributeError</text>
</g>
<g stroke="var(--h-fig-line)" stroke-width="2" fill="none" marker-end="url(#oop3-duck-arrow)">
<path d="M197 104 C 226 104, 226 30, 254 30"/>
<path d="M197 110 C 226 110, 226 84, 254 84"/>
<path d="M197 118 C 226 118, 226 138, 254 138"/>
</g>
<path d="M197 124 C 226 124, 226 192, 254 192" fill="none" stroke="var(--h-cherry)" stroke-width="2" stroke-dasharray="5 4" marker-end="url(#oop3-duck-arrow-c)"/>
</svg>
</figure>

### ABC or duck typing?

They are two answers to the same question, and Python uses both.

| | Formal interface (`ABC`) | Duck typing |
|---|---|---|
| A class opts in by | inheriting from the interface | having the right methods |
| A missing method is caught | when the object is created | when the method is called |
| Works with classes you did not write | only if they inherit from it | yes |
| Best for | your own families of classes, frameworks | functions that accept "anything that can..." |

The wallet uses both: `Payer` documents and enforces the contract for
its own classes, and `checkout` stays open to anything that can pay,
including test doubles like `FakePayer`.

!!! tip "`typing.Protocol`"

    Modern Python can also *describe* a duck type for tools such as
    type checkers and editors, with `typing.Protocol`. A protocol class
    lists the methods, like an interface, but classes do not need to
    inherit from it. You will meet it when you start using type hints.

## Step 4: Extend a built-in class

Every transaction should be recorded as a `(kind, amount)` tuple, such
as `("deposit", 200)`. A plain list would accept anything, including
`"junk"`. Built-in types are classes too, so you can subclass `list`
and keep everything it does, while adding your own checks and methods:

```python
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
        _check_amount(amount)
```

**Preserve the built-in's behaviour.** Each override does its extra
work, then calls the real `list` method through `super()`. So a
`TransactionLog` still *is* a list in every way that matters:

```python
log = TransactionLog()
log.append(("deposit", 200))
log.append(("withdraw", 50))

log                      # [('deposit', 200), ('withdraw', 50)]
len(log)                 # 2
log[0]                   # ('deposit', 200)
for kind, amount in log: # iteration works
    ...
isinstance(log, list)    # True
log.total("deposit")     # 200: the one new method
```

And bad entries are refused:

```
log.append("junk")                          -> TypeError: entry must be a (kind, amount) tuple
log.append(("gift", 10))                    -> ValueError: unknown kind: 'gift'
log.append(("deposit", -5))                 -> ValueError: amount must be positive
log.extend([("fee", 100), ("deposit", 0)])  -> ValueError: amount must be positive
```

After that failed `extend`, the log is unchanged: neither entry was
added, because `extend` checks everything before adding anything. An
operation that fails halfway and leaves half its work done is one of
the hardest bugs to track down.

!!! warning "The trap: `list` has many doors"

    `list` is written in C, and its methods do not call each other. So
    overriding `append` does **not** guard the other ways in. Even the
    constructor needed its own override above, because `list([...])`
    never calls `append`. In this class, these still skip the checks:

    ```python
    log.insert(0, "junk")     # accepted
    log += ["more junk"]      # accepted
    log[0] = 42               # accepted
    ```

    And slicing or `+` gives back a plain `list`, not a
    `TransactionLog`. Subclass a built-in when you want *all* of its
    behaviour plus a little more, and accept that you guard only the
    doors you override. When *every* change must be checked, hold a
    list inside your class instead of being one: that is the "has a"
    choice from the last tutorial.

    The wallet is safe with this design because no outside code writes
    to a history directly. Accounts keep their log in `_history`, and
    the public `history` property hands out a *copy*.

## Step 5: Multiple inheritance and the MRO

A class can inherit from more than one parent. Python then needs a
single, predictable order in which to look for methods. That order is
the **method resolution order**, which you met in the last tutorial,
and with several parents it matters more:

```python
class GiftCard(HistoryMixin, JSONMixin, Payer):
    ...


GiftCard.mro()
# [GiftCard, HistoryMixin, JSONMixin, Payer, ABC, object]
```

Python builds this order by three rules: a class comes before its
parents, parents keep the left-to-right order you wrote them in, and
every class appears exactly once. That last rule matters when two
parents share an ancestor, the so-called *diamond*: every class here
eventually inherits from `object`, yet `object` appears once, at the
end. If the rules cannot all be satisfied, Python refuses to create the
class:

```python
class Broken(ABC, Payer):    # ABC listed before its own subclass
    pass
# TypeError: Cannot create a consistent method resolution order (MRO)
# for bases ABC, Payer
```

Multiple inheritance between full, independent class hierarchies gets
confusing fast. In practice it is used almost entirely for one job:
mixins.

## Step 6: Mixins

A **mixin** is a small class that adds one piece of behaviour to any
class that lists it as a parent. It is not meant to be used on its own,
and it is not an "is a" relationship. A gift card is not a history; it
*has* the history behaviour mixed in.

The wallet needs two pieces of behaviour that both accounts and gift
cards share, and that have nothing to do with money rules: keeping a
history, and turning into JSON.

```python
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
```

Mix them in by listing them first, before the main base class:

```python
class Account(HistoryMixin, JSONMixin, Payer):
    ...


class GiftCard(HistoryMixin, JSONMixin, Payer):
    ...
```

Then each method that moves money records it with one line, for
example `self._record("deposit", amount)` in `deposit`,
`self._record("payment", amount)` in `GiftCard.pay`, and
`self._record("fee", self.fee)` when a checking account is charged.
Notice the overrides from the last tutorial: `CheckingAccount.withdraw`
replaces the parent's method entirely, so it must record the withdrawal
itself. Keeping the parent's promises includes this one.

Both families now get both behaviours, written once:

```python
linus.history       # [('withdraw', 300), ('fee', 100)]
grace.to_dict()     # {'type': 'SavingsAccount', 'owner': 'Grace', 'balance': 1020, 'rate': 2}
card.to_json()      # '{"type": "GiftCard", "code": "HB-2026", "value": 180}'
```

`to_dict` keeps only simple values, so the history log is left out,
and strips the leading underscore, so `_owner` becomes `owner`.

Good mixins follow a few rules:

- **One job each.** A mixin's name says what it adds: `HistoryMixin`,
  `JSONMixin`.
- **No `__init__` of its own**, if possible. `HistoryMixin` creates its
  log the first time it is needed, so it does not have to take part in
  the classes' constructors.
- **Mixins first, main base last**, as in
  `class GiftCard(HistoryMixin, JSONMixin, Payer)`. Python searches left
  to right, so the mixins' methods are found first and the main base
  class sits at the end.
- **Ask whether it is really shared.** If only one class needs the
  behaviour, put it in that class.

## The code so far

This is version 3 of the wallet, tagged
[`v3-abstract`](https://github.com/evisp/oop-wallet/tree/v3-abstract)
in the companion repository. It has grown, so read it top to bottom
once: the helpers and mixins first, then the interface, the abstract
`Account` with its two subclasses, the gift card, and `checkout`.

??? example "wallet.py · version 3"

    ```python title="wallet.py"
    #!/usr/bin/env python3
    """A small digital wallet, built up across the OOP tutorials.

    Version 3: Abstract Classes & Interfaces.
    """
    import json
    from abc import ABC, abstractmethod


    def _check_amount(amount):
        """Raise if amount is not a positive whole number."""
        if isinstance(amount, bool) or not isinstance(amount, int):
            raise TypeError("amount must be an integer")
        if amount <= 0:
            raise ValueError("amount must be positive")


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
            _check_amount(amount)


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


    class Payer(ABC):
        """Interface: anything that can pay an amount."""

        @abstractmethod
        def pay(self, amount):
            """Pay amount, or raise ValueError; return what is left."""


    class Account(HistoryMixin, JSONMixin, Payer):
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
            _check_amount(amount)
            self._balance += amount
            self._record("deposit", amount)
            return self._balance

        def withdraw(self, amount):
            """Take amount from the balance and return the new balance."""
            _check_amount(amount)
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
            _check_amount(amount)
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


    class GiftCard(HistoryMixin, JSONMixin, Payer):
        """A prepaid card with a fixed value. It is not an account."""

        currency = "ALL"

        def __init__(self, code, value):
            """Create a gift card with a code and a starting value."""
            if not isinstance(code, str) or not code.strip():
                raise ValueError("code must be a non-empty string")
            _check_amount(value)
            self._code = code.strip()
            self._value = value

        @property
        def value(self):
            """What is left on the card."""
            return self._value

        def pay(self, amount):
            """Pay amount from the card; return the value left."""
            _check_amount(amount)
            if amount > self._value:
                raise ValueError("not enough value on the card")
            self._value -= amount
            self._record("payment", amount)
            return self._value

        def __str__(self):
            return f"Gift card {self._code}: {self.value} {self.currency}"

        def __repr__(self):
            return f"GiftCard(code={self._code!r}, value={self.value})"


    def checkout(payer, amount):
        """Charge amount to anything that can pay; return what it returns."""
        return payer.pay(amount)


    if __name__ == "__main__":
        grace = SavingsAccount("Grace", 1000, rate=2)
        linus = CheckingAccount("Linus", overdraft=500)
        card = GiftCard("HB-2026", 300)

        checkout(linus, 300)
        checkout(card, 120)
        for account in (grace, linus):
            account.month_end()

        for item in (grace, linus, card):
            print(item)
        print(linus.history)
        print(card.to_json())
    ```

```bash
./wallet.py
```

```
Grace: 1020 ALL
Linus: -400 ALL (overdraft 500)
Gift card HB-2026: 180 ALL
[('withdraw', 300), ('fee', 100)]
{"type": "GiftCard", "code": "HB-2026", "value": 180}
```

!!! ai "AI in the loop"

    Give an assistant the `Payer` interface and ask it to *design*, not
    write, a new payer: *"Propose a `Voucher` class that fits this
    wallet. Should it implement `Payer`, inherit from `Account` or
    `GiftCard`, and which mixins should it use? Explain each choice."*
    Compare its reasoning with the rules on this page. Then write the
    class yourself and run it through `checkout`.

## When something goes wrong

??? note "`TypeError: Can't instantiate abstract class ... without an implementation for abstract method ...`"

    You created an abstract class, or a subclass that does not define
    every abstract method. Add the method named in the message, with
    exactly that name. A typo such as `month_End` leaves the real one
    still missing.

??? note "My abstract class can be created, and it should not"

    The method is missing its `@abstractmethod` decorator, or the class
    does not inherit from `ABC`, directly or through a parent such as
    `Payer`.

??? note "`AttributeError: '...' object has no attribute 'pay'`"

    Duck typing at work: the object passed in cannot do what the
    function asks. Either pass an object that has the method, or check
    the caller.

??? note "`TypeError: Cannot create a consistent method resolution order (MRO)`"

    The parent classes are listed in an order Python cannot satisfy,
    usually a class placed before one of its own subclasses. Put mixins
    first and the main base class last.

??? note "My `list` subclass accepted something it should have refused"

    It came in through a door you did not override, such as `insert`,
    `+=`, item assignment or the constructor. Override that method too,
    or hold a list inside the class instead of subclassing it.

## Explain it to someone

- [ ] What an abstract class is for, and what it can still contain
- [ ] How `ABC` and `@abstractmethod` enforce a contract, and when the error appears
- [ ] How a subclass satisfies an abstract contract
- [ ] How Python models an interface, and how it differs from an abstract class
- [ ] What duck typing is, and when you would choose it over a formal interface
- [ ] How to extend a built-in such as `list` while keeping its behaviour
- [ ] Which `list` operations skip an overridden `append`, and what to do about it
- [ ] How Python orders methods with multiple inheritance
- [ ] What a mixin is, and the rules that keep mixins simple

## Quick reference

| Code | What it does |
|---|---|
| `class Base(ABC):` | Make a class that can hold abstract methods |
| `@abstractmethod` | Require subclasses to define this method |
| `Class.__abstractmethods__` | The abstract methods still missing |
| `class Thing(Interface):` | Implement an interface |
| `obj.method()` with no type check | Duck typing |
| `class Log(list):` + `super().append(x)` | Extend a built-in, keep its behaviour |
| `class C(MixinA, MixinB, Base):` | Mix behaviour in: mixins first, base last |
| `Class.mro()` | The order Python searches for methods |

## Next

The wallet now has eight classes, two functions and several kinds of
relationship between them. Next you learn to draw that design as a UML
class diagram, so you can plan and discuss a design before writing it.

[Introduction to UML Modeling](uml.md){ .h-button }
