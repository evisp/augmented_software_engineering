# Classes & Object Model

<span class="badge badge--time">75 min</span>
<span class="badge badge--level">Object-Oriented Design</span>
<span class="badge">Needs: Exception Handling</span>

Until now your data and the functions that work on it have lived
apart: a balance in one variable, a `deposit` function somewhere else.
A **class** puts them together. In this tutorial you build the first
piece of a small digital wallet, an `Account` that holds money, refuses
bad input and protects its own balance. The rest of the module keeps
building on it.

## Why this matters

Programs model things: users, orders, accounts, bookings. Each thing
has **data** (an account has an owner and a balance) and **rules**
(the balance can never go below zero). Without classes, nothing stops
some other part of the program from breaking those rules. With a class,
the data and the rules travel together, and the object itself refuses
to get into an invalid state.

Almost every framework you will use later, from web back-ends to the
HBnB portfolio project, is built from classes. Reading and designing
them is a core skill.

## The running example

One wallet grows across all five projects of this module. This page
builds version 1.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 130" role="img" aria-labelledby="oop1-plan-title oop1-plan-desc">
<title id="oop1-plan-title">How the wallet grows across the module</title>
<desc id="oop1-plan-desc">Version 1, Classes: the Account class, built on this page. Version 2, Inheritance: savings and checking accounts. Version 3, Abstract classes: contracts and mixins. Version 4, UML: drawing the design. Version 5, Patterns: Strategy and Observer.</desc>
<defs><marker id="oop1-plan-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<rect x="3" y="20" width="122" height="90" rx="10" fill="var(--h-cherry)"/>
<rect x="141" y="20" width="122" height="90" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="279" y="20" width="122" height="90" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="417" y="20" width="122" height="90" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="555" y="20" width="122" height="90" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<g text-anchor="middle">
<text x="64" y="44" font-size="11" font-weight="700" fill="#ffffff" opacity="0.85">v1 · THIS PAGE</text>
<text x="64" y="70" font-size="14" font-weight="700" fill="#ffffff">Classes</text>
<text x="64" y="90" font-size="11" fill="#ffffff" opacity="0.9" font-family="var(--md-code-font-family, monospace)">Account</text>
<text x="202" y="44" font-size="11" font-weight="700" fill="var(--h-fig-muted)">v2</text>
<text x="202" y="70" font-size="14" font-weight="700" fill="var(--h-fig-text)">Inheritance</text>
<text x="202" y="90" font-size="11" fill="var(--h-fig-muted)">savings, checking</text>
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
<g stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#oop1-plan-arrow)">
<line x1="127" y1="65" x2="138" y2="65"/>
<line x1="265" y1="65" x2="276" y2="65"/>
<line x1="403" y1="65" x2="414" y2="65"/>
<line x1="541" y1="65" x2="552" y2="65"/>
</g>
</svg>
</figure>

Every finished version is saved in the companion repository,
[evisp/oop-wallet](https://github.com/evisp/oop-wallet), under a tag.
Write the code yourself as you read, then compare it with the tag.

## Step 1: Design before you type

Start from a description of what the program must do, in plain words:

> A customer has an account with a balance, in lek. They can deposit
> and withdraw money. The balance can never go below zero, and nobody
> may change it directly.

Read it and sort the words. **Nouns** that have their own data become
**classes** and **attributes**. **Verbs** become **methods**. **Rules**
become **validation**.

| In the description | Becomes | In code |
|---|---|---|
| account | a class | `Account` |
| customer, balance | attributes | `owner`, `balance` |
| deposit, withdraw | methods | `deposit()`, `withdraw()` |
| never below zero | a check that raises | `ValueError("insufficient funds")` |
| nobody changes it directly | protected state | a read-only `balance` |

Five minutes on this table saves an hour of rewriting. You will draw
the same design formally in the UML project.

## Step 2: Class and instance

A **class** is a blueprint: it describes what every account has and
can do. An **instance**, or **object**, is one account built from that
blueprint, with its own data.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 252" role="img" aria-labelledby="oop1-ci-title oop1-ci-desc">
<title id="oop1-ci-title">One class, three instances</title>
<desc id="oop1-ci-desc">The Account class lists the attributes every account has, owner and balance, the shared class attribute currency, and the methods deposit and withdraw. Three instances are built from it: ada with balance 600, linus with balance 0 and grace with balance 1200. Each instance has its own owner and balance, and all of them share the methods.</desc>
<defs><marker id="oop1-ci-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<text x="3" y="14" font-size="11" font-weight="700" fill="var(--h-fig-muted)">CLASS · THE BLUEPRINT</text>
<rect x="3" y="24" width="240" height="220" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="123" y="52" text-anchor="middle" font-size="15" font-weight="700" fill="var(--h-fig-text)">Account</text>
<line x1="3" y1="66" x2="243" y2="66" stroke="var(--h-fig-line)"/>
<g font-family="var(--md-code-font-family, monospace)" font-size="12.5" fill="var(--h-fig-text)">
<text x="20" y="92">owner</text>
<text x="20" y="114">balance</text>
<text x="20" y="136" fill="var(--h-fig-muted)">currency = "ALL"</text>
</g>
<line x1="3" y1="152" x2="243" y2="152" stroke="var(--h-fig-line)"/>
<g font-family="var(--md-code-font-family, monospace)" font-size="12.5" fill="var(--h-fig-text)">
<text x="20" y="180">deposit(amount)</text>
<text x="20" y="204">withdraw(amount)</text>
</g>
<text x="168" y="92" font-size="10.5" fill="var(--h-fig-muted)">data</text>
<text x="168" y="180" font-size="10.5" fill="var(--h-fig-muted)">behaviour</text>
<text x="405" y="14" font-size="11" font-weight="700" fill="var(--h-fig-muted)">INSTANCES · ONE PER ACCOUNT</text>
<g font-family="var(--md-code-font-family, monospace)">
<rect x="405" y="24" width="272" height="62" rx="10" fill="var(--h-cherry)"/>
<text x="424" y="50" font-size="14" font-weight="700" fill="#ffffff">ada</text>
<text x="424" y="72" font-size="12" fill="#ffffff" opacity="0.92">owner='Ada'  balance=600</text>
<rect x="405" y="103" width="272" height="62" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="424" y="129" font-size="14" font-weight="700" fill="var(--h-fig-text)">linus</text>
<text x="424" y="151" font-size="12" fill="var(--h-fig-muted)">owner='Linus'  balance=0</text>
<rect x="405" y="182" width="272" height="62" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="424" y="208" font-size="14" font-weight="700" fill="var(--h-fig-text)">grace</text>
<text x="424" y="230" font-size="12" fill="var(--h-fig-muted)">owner='Grace'  balance=1200</text>
</g>
<g stroke="var(--h-fig-line)" stroke-width="2" fill="none" marker-end="url(#oop1-ci-arrow)">
<path d="M247 134 C 320 134, 320 55, 399 55"/>
<line x1="247" y1="134" x2="399" y2="134"/>
<path d="M247 134 C 320 134, 320 213, 399 213"/>
</g>
<text x="322" y="122" text-anchor="middle" font-size="11.5" font-weight="600" fill="var(--h-cherry)" font-family="var(--md-code-font-family, monospace)">Account(...)</text>
</svg>
</figure>

The smallest possible class has no body at all:

```python
class Account:
    pass


ada = Account()
linus = Account()
print(type(ada))      # <class '__main__.Account'>
print(ada is linus)   # False: two separate objects
```

Calling the class, `Account()`, builds a new instance. `ada` and
`linus` come from the same blueprint, but they are two separate
objects. That is the whole idea: **one class, as many instances as you
need, each with its own state.**

Class names use `CapitalisedWords`. Function, method and variable names
stay in `lower_case`, as before.

## Step 3: `__init__` and `self`

An empty account is not much use. Every account should start with an
owner and a balance. The special method `__init__` runs automatically
each time an instance is created, and it sets up that instance's
**attributes**:

```python
class Account:
    def __init__(self, owner, balance=0):
        self.owner = owner
        self.balance = balance


ada = Account("Ada", 500)
linus = Account("Linus")
print(ada.owner, ada.balance)      # Ada 500
print(linus.owner, linus.balance)  # Linus 0
```

**`self` is the instance being built.** When you write
`Account("Ada", 500)`, Python creates an empty object, then calls
`__init__` with that object as `self`, `"Ada"` as `owner` and `500` as
`balance`. `self.owner = owner` stores the name *on that object*, which
is why `ada` and `linus` each keep their own.

You can see an instance's own attributes with `vars`:

```python
vars(ada)    # {'owner': 'Ada', 'balance': 500}
```

`__init__` is called the **initialiser**. It never returns a value; its
only job is to put the new object into a sensible starting state.

## Step 4: Methods that work on the object's state

A **method** is a function defined inside a class. Its first parameter
is always `self`, so it can read and change the instance it was called
on.

```python
class Account:
    def __init__(self, owner, balance=0):
        self.owner = owner
        self.balance = balance

    def deposit(self, amount):
        self.balance += amount
        return self.balance

    def withdraw(self, amount):
        self.balance -= amount
        return self.balance


ada = Account("Ada", 500)
ada.deposit(200)     # 700
ada.withdraw(100)    # 600
```

`ada.deposit(200)` is shorthand. Python turns it into
`Account.deposit(ada, 200)`: it looks up `deposit` on the class and
passes `ada` in as `self`. Try both; they do exactly the same thing.
That is the entire mystery of `self`: it is the object before the dot.

Notice that the methods **return** the new balance, as you learned in
Functions & Modularity. They do not print. Whoever uses the class
decides what to show.

## Step 5: Validate input when constructing objects

The class works, and it is already broken. Try these:

```python
ada.withdraw(10_000)        # -9350: the balance is now negative
ada.deposit(-500)           # a "deposit" that removes money
bad = Account("", "lots")   # an account with no owner and a text balance
ada.balance = 1_000_000     # anyone can set any balance
```

Every line breaks a rule from the description in Step 1, and Python
accepts all of them. The class must enforce its own rules. The approach
is the one from [Exception Handling](../python/exceptions.md#step-5-raise-exceptions-yourself):
check the input and raise a specific exception.

```python
class Account:
    def __init__(self, owner, balance=0):
        if not isinstance(owner, str):
            raise TypeError("owner must be a string")
        if not owner.strip():
            raise ValueError("owner must not be empty")
        if isinstance(balance, bool) or not isinstance(balance, int):
            raise TypeError("balance must be an integer")
        if balance < 0:
            raise ValueError("balance must not be negative")
        self.owner = owner.strip()
        self.balance = balance

    def deposit(self, amount):
        self._check_amount(amount)
        self.balance += amount
        return self.balance

    def withdraw(self, amount):
        self._check_amount(amount)
        if amount > self.balance:
            raise ValueError("insufficient funds")
        self.balance -= amount
        return self.balance

    def _check_amount(self, amount):
        if isinstance(amount, bool) or not isinstance(amount, int):
            raise TypeError("amount must be an integer")
        if amount <= 0:
            raise ValueError("amount must be positive")
```

Now the broken calls fail loudly and clearly:

```
Account("", 100)         -> ValueError: owner must not be empty
Account(42)              -> TypeError: owner must be a string
Account("Ada", -5)       -> ValueError: balance must not be negative
Account("Ada", "lots")   -> TypeError: balance must be an integer
ada.withdraw(10_000)     -> ValueError: insufficient funds
ada.deposit(-500)        -> ValueError: amount must be positive
ada.deposit(2.5)         -> TypeError: amount must be an integer
```

Three design points are worth noticing:

- **Validate in `__init__`.** If the constructor checks everything, an
  invalid `Account` can never exist. Every other method can then trust
  the object's state.
- **One helper, used twice.** `deposit` and `withdraw` both need the
  same amount check, so it lives in one method, `_check_amount`. The
  leading underscore says it is for the class's own use, not for
  callers. More on that in the next step.
- **Why the `bool` check?** In Python, `True` passes
  `isinstance(True, int)`, and `True + 1` is `2`. Without the extra
  check, `ada.deposit(True)` would quietly add 1 lek. The reason is
  that `bool` is a *subclass* of `int`, which is exactly what the next
  tutorial is about.

Amounts are whole numbers of lek on purpose. Floating-point numbers
cannot store most decimal fractions exactly, so `0.1 + 0.2` is not
`0.3`. Real financial software stores money as whole units for the
same reason.

## Step 6: Control access to internal attributes

One line from Step 5 still works: `ada.balance = 1_000_000`. The
validation in `deposit` and `withdraw` means nothing if anyone can
write to `balance` directly. This is what **encapsulation** is about:
the object keeps its data behind a small set of methods, and those
methods are the only way in.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 206" role="img" aria-labelledby="oop1-enc-title oop1-enc-desc">
<title id="oop1-enc-title">Outside code reaches internal state only through the public interface</title>
<desc id="oop1-enc-desc">Outside code calls ada.deposit(200), which goes through the public deposit method, checks the amount, and updates the internal _balance. Reading ada.balance goes through a read-only property. Assigning ada.balance equals 0 is rejected at the interface with an AttributeError, because the property has no setter.</desc>
<defs><marker id="oop1-enc-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<text x="3" y="14" font-size="11" font-weight="700" fill="var(--h-fig-muted)">OUTSIDE CODE</text>
<text x="253" y="14" font-size="11" font-weight="700" fill="var(--h-fig-muted)">PUBLIC INTERFACE</text>
<text x="493" y="14" font-size="11" font-weight="700" fill="var(--h-fig-muted)">INTERNAL STATE</text>
<g font-family="var(--md-code-font-family, monospace)" font-size="12.5">
<rect x="3" y="26" width="200" height="44" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="18" y="53" fill="var(--h-fig-text)">ada.deposit(200)</text>
<rect x="3" y="88" width="200" height="44" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="18" y="115" fill="var(--h-fig-text)">ada.balance</text>
<rect x="3" y="150" width="200" height="44" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="18" y="177" fill="var(--h-fig-text)">ada.balance = 0</text>
<rect x="253" y="26" width="200" height="44" rx="8" fill="var(--md-default-bg-color)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="268" y="47" fill="var(--h-fig-text)">deposit()</text>
<text x="268" y="62" font-size="10.5" fill="var(--h-fig-muted)" font-family="var(--md-text-font-family, sans-serif)">checks the amount first</text>
<rect x="253" y="88" width="200" height="44" rx="8" fill="var(--md-default-bg-color)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="268" y="109" fill="var(--h-fig-text)">balance</text>
<text x="268" y="124" font-size="10.5" fill="var(--h-fig-muted)" font-family="var(--md-text-font-family, sans-serif)">read-only property</text>
<rect x="253" y="150" width="200" height="44" rx="8" fill="none" stroke="var(--h-cherry)" stroke-width="1.5" stroke-dasharray="5 4"/>
<text x="268" y="171" fill="var(--h-cherry)" font-weight="700">no setter</text>
<text x="268" y="186" font-size="10.5" fill="var(--h-cherry)" font-family="var(--md-text-font-family, sans-serif)">AttributeError</text>
<rect x="493" y="26" width="184" height="106" rx="10" fill="var(--h-cherry)"/>
<text x="510" y="68" fill="#ffffff" font-weight="700">_owner = 'Ada'</text>
<text x="510" y="92" fill="#ffffff" font-weight="700">_balance = 700</text>
</g>
<text x="510" y="118" font-size="10.5" fill="#ffffff" opacity="0.9">changed only by methods</text>
<g stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#oop1-enc-arrow)">
<line x1="207" y1="48" x2="247" y2="48"/>
<line x1="457" y1="48" x2="487" y2="48"/>
<line x1="207" y1="110" x2="247" y2="110"/>
<line x1="487" y1="110" x2="457" y2="110"/>
<line x1="207" y1="172" x2="247" y2="172"/>
</g>
</svg>
</figure>

Python has no truly private attributes. Instead it uses naming
conventions, and one tool, the **property**, that lets you control
exactly how an attribute is read and written.

### `_name`: "internal, please do not touch"

A single leading underscore marks an attribute or method as internal.
Python does not stop anyone from using it, but every Python developer
reads it as "not part of the public interface; may change without
warning". You already used it for `_check_amount`.

### `__name`: name mangling

Two leading underscores make Python rename the attribute behind the
scenes, which is called **name mangling**:

```python
class Card:
    def __init__(self, pin):
        self.__pin = pin


card = Card(1234)
card.__pin           # AttributeError: 'Card' object has no attribute '__pin'
vars(card)           # {'_Card__pin': 1234}
card._Card__pin      # 1234
```

`__pin` was stored as `_Card__pin`. That protects it from *accidental*
clashes, especially in subclasses, but it is not security: anyone who
knows the rule can still reach it. In this wallet we use a single
underscore, because the account types you build in the next tutorial
will need to work with the balance too.

### `@property`: control reading and writing

A **property** looks like an attribute from outside, but runs a method
when it is read or written. Store the real value in `_balance`, and
expose a `balance` property with only a *getter*:

```python
    @property
    def balance(self):
        """The current balance. Read-only: use deposit and withdraw."""
        return self._balance
```

Reading works exactly as before, and writing is now refused:

```python
ada.balance               # 700
ada.balance = 1_000_000   # AttributeError: property 'balance' of 'Account' object has no setter
```

For `owner`, renaming should be allowed but still validated. A property
can have a *setter* as well, which runs on every assignment:

```python
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
```

```python
ada.owner = "  Ada Lovelace "   # stored as 'Ada Lovelace'
ada.owner = ""                  # ValueError: owner must not be empty
```

Here is the neat part: inside `__init__`, write `self.owner = owner`.
That assignment goes through the setter too, so the owner checks live
in **one place** and run both when the account is created and whenever
it is renamed later.

## Step 7: String representations

Print an object with no string methods and you get its type and memory
address, which tells you nothing:

```python
print(ada)    # <__main__.Account object at 0x7f3ed9336cf0>
```

Two special methods fix this, each for a different reader:

- **`__str__`** is for **people**. `print()` and `str()` use it.
- **`__repr__`** is for **developers**. The interpreter, debuggers, and
  lists of objects use it. A good `__repr__` looks like the code that
  would rebuild the object.

```python
    def __str__(self):
        return f"{self.owner}: {self.balance} {self.currency}"

    def __repr__(self):
        return f"Account(owner={self.owner!r}, balance={self.balance})"
```

```python
print(ada)          # Ada: 600 ALL
repr(ada)           # "Account(owner='Ada', balance=600)"
print([ada, linus]) # [Account(owner='Ada', balance=600), Account(owner='Linus', balance=0)]
f"{ada} | {ada!r}"  # 'Ada: 600 ALL | Account(owner='Ada', balance=600)'
```

Notice the list: printing a list shows its items with `__repr__`, not
`__str__`. If you only write one of the two, write `__repr__`; Python
falls back to it when there is no `__str__`.

Both methods **return** a string. Neither prints.

## Step 8: Class attributes

Some data belongs to the class, not to any one account. Every account
in this wallet uses the same currency, so it is defined once, directly
in the class body:

```python
class Account:
    """A wallet account holding money, in whole lek."""

    currency = "ALL"
```

```python
Account.currency            # 'ALL'
ada.currency                # 'ALL': found on the class
"currency" in vars(ada)     # False: ada does not store its own copy
```

When you read `ada.currency`, Python looks on the instance first, and
then on the class. Change the class attribute and every instance sees
the change. But assigning `ada.currency = "USD"` does not change the
class: it creates a new attribute on `ada` alone, which then hides the
class one. Use class attributes for values that really are shared,
such as constants, and change them only through the class.

## The code so far

This is version 1 of the wallet. It is also tagged
[`v1-classes`](https://github.com/evisp/oop-wallet/tree/v1-classes) in
the companion repository.

??? example "wallet.py · version 1"

    ```python title="wallet.py"
    #!/usr/bin/env python3
    """A small digital wallet, built up across the OOP tutorials.

    Version 1: Classes & Object Model.
    """


    class Account:
        """A wallet account holding money, in whole lek."""

        currency = "ALL"

        def __init__(self, owner, balance=0):
            """Create an account for owner with an opening balance."""
            self.owner = owner
            if isinstance(balance, bool) or not isinstance(balance, int):
                raise TypeError("balance must be an integer")
            if balance < 0:
                raise ValueError("balance must not be negative")
            self._balance = balance

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
            self._check_amount(amount)
            self._balance += amount
            return self._balance

        def withdraw(self, amount):
            """Take amount from the balance and return the new balance."""
            self._check_amount(amount)
            if amount > self._balance:
                raise ValueError("insufficient funds")
            self._balance -= amount
            return self._balance

        def _check_amount(self, amount):
            """Raise if amount is not a positive whole number."""
            if isinstance(amount, bool) or not isinstance(amount, int):
                raise TypeError("amount must be an integer")
            if amount <= 0:
                raise ValueError("amount must be positive")

        def __str__(self):
            return f"{self.owner}: {self.balance} {self.currency}"

        def __repr__(self):
            return f"Account(owner={self.owner!r}, balance={self.balance})"


    if __name__ == "__main__":
        ada = Account("Ada", 500)
        ada.deposit(200)
        ada.withdraw(100)
        print(ada)
        print(repr(ada))
    ```

```bash
./wallet.py
```

```
Ada: 600 ALL
Account(owner='Ada', balance=600)
```

The file passes `pycodestyle`, and the demo runs only under
`if __name__ == "__main__":`, so other files can import `Account`
without printing anything.

!!! ai "AI in the loop"

    Paste your class into an assistant and ask it to **attack** it:
    *"Find inputs or sequences of calls that put this `Account` into an
    invalid state. Don't fix anything, just list them."* Then decide for
    each one whether your class should prevent it, and fix it yourself.
    Thinking like someone trying to break your object is the fastest
    way to learn what encapsulation is for.

## When something goes wrong

??? note "`TypeError: Account.__init__() takes from 2 to 3 positional arguments but 4 were given`"

    Python counts `self` as one of the arguments. Check the number of
    values you pass matches the parameters after `self`.

??? note "`TypeError: Account.deposit() missing 1 required positional argument: 'amount'`"

    Usually you called the method on the class, `Account.deposit(200)`,
    instead of on an instance, `ada.deposit(200)`. Or you forgot `self`
    as the first parameter of the method.

??? note "`NameError: name '_balance' is not defined` inside a method"

    Attributes always need `self.` in front: `self._balance`, not
    `_balance`.

??? note "`RecursionError: maximum recursion depth exceeded` in a property"

    The property stores its value under its own name, for example
    `self.owner = value` inside the `owner` setter, so the setter calls
    itself forever. Store it under the underscore name: `self._owner`.

??? note "`AttributeError: property 'balance' of 'Account' object has no setter`"

    That is the class working as designed. Change the balance through
    `deposit` and `withdraw`.

## Explain it to someone

- [ ] The difference between a class and an instance
- [ ] How you turn a plain description into a class, attributes and methods
- [ ] What `__init__` does and what `self` is
- [ ] How a method reads and changes an object's state
- [ ] Why validation belongs in the constructor, and how it uses exceptions
- [ ] What encapsulation means, and why `ada.balance = 1_000_000` must fail
- [ ] The meaning of `_name`, `__name` and name mangling
- [ ] How `@property` makes an attribute read-only, or validated on write
- [ ] The difference between `__str__` and `__repr__`, and who each is for
- [ ] The difference between a class attribute and an instance attribute

## Quick reference

| Code | What it does |
|---|---|
| `class Account:` | Define a class |
| `Account("Ada", 500)` | Create an instance; runs `__init__` |
| `def __init__(self, ...):` | Set up a new instance's attributes |
| `self.x = value` | Store an attribute on the instance |
| `def method(self, ...):` | Define a method; `self` is the object before the dot |
| `_name` / `__name` | Internal by convention / name-mangled |
| `@property` | Read an attribute through a method |
| `@x.setter` | Validate or refuse writes to `x` |
| `__str__` / `__repr__` | Text for people / text for developers |
| `vars(obj)` | Show an instance's own attributes |

## Next

One kind of account is not enough for a real wallet. Next you create
savings and checking accounts that reuse everything `Account` already
does.

[Object-Oriented Design](index.md){ .h-button }
