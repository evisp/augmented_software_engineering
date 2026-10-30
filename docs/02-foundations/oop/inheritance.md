# Inheritance & Polymorphism

<span class="badge badge--time">75 min</span>
<span class="badge badge--level">Object-Oriented Design</span>
<span class="badge">Needs: Classes & Object Model</span>

The wallet has one kind of account. A real wallet needs several:
savings accounts that earn interest, checking accounts that may go
below zero. They share almost everything an `Account` already does.
**Inheritance** lets you write that shared part once and add only what
is different. **Polymorphism** then lets the rest of your program treat
every account the same way, even though each behaves in its own way.

## Why this matters

Without inheritance you would copy `Account` into `SavingsAccount` and
`CheckingAccount`, then fix every bug three times. With it, the
validation, properties and string methods you wrote in the last
tutorial are reused as they are, and each new class contains only the
lines that make it different.

Polymorphism is the bigger idea. It is what lets you write
`account.month_end()` without caring which kind of account it is, and
add a fourth kind next year without touching the code that uses them.
Frameworks are built on it, and so is the HBnB portfolio project.

## Where we left off

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 130" role="img" aria-labelledby="oop2-plan-title oop2-plan-desc">
<title id="oop2-plan-title">How the wallet grows across the module</title>
<desc id="oop2-plan-desc">Version 1, Classes: the Account class: done. Version 2, Inheritance: savings and checking accounts: this page. Version 3, Abstract classes: contracts and mixins: coming next. Version 4, UML: drawing the design: coming next. Version 5, Patterns: Factory, Observer and Decorator: coming next.</desc>
<defs><marker id="oop2-plan-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<rect x="3" y="20" width="122" height="90" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<rect x="141" y="20" width="122" height="90" rx="10" fill="var(--h-cherry)"/>
<rect x="279" y="20" width="122" height="90" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="417" y="20" width="122" height="90" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<rect x="555" y="20" width="122" height="90" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<g text-anchor="middle">
<text x="64" y="44" font-size="11" font-weight="700" fill="var(--h-fig-muted)">v1 · DONE</text>
<text x="64" y="70" font-size="14" font-weight="700" fill="var(--h-fig-text)">Classes</text>
<text x="64" y="90" font-size="11" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">Account</text>
<text x="202" y="44" font-size="11" font-weight="700" fill="#ffffff" opacity="0.85">v2 · THIS PAGE</text>
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
<text x="616" y="90" font-size="11" fill="var(--h-fig-muted)">three patterns</text>
</g>
<g stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#oop2-plan-arrow)">
<line x1="127" y1="65" x2="138" y2="65"/>
<line x1="265" y1="65" x2="276" y2="65"/>
<line x1="403" y1="65" x2="414" y2="65"/>
<line x1="541" y1="65" x2="552" y2="65"/>
</g>
</svg>
</figure>

You finished the last tutorial with an `Account` class that validates
its input, protects its balance and prints itself clearly. Start from
that file, or from the tag
[`v1-classes`](https://github.com/evisp/oop-wallet/tree/v1-classes).

The wallet now has a new requirement:

> The wallet offers two more account types. A **savings account** earns
> interest every month. A **checking account** may go below zero, down
> to an agreed overdraft limit, and is charged a 100 lek fee for every
> month it ends overdrawn.

## Step 1: Parent and child classes

Both new accounts *are* accounts: they have an owner and a balance, and
you can deposit into them. That "is a" relationship is what inheritance
models.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 306" role="img" aria-labelledby="oop2-tree-title oop2-tree-desc">
<title id="oop2-tree-title">Account and its two subclasses</title>
<desc id="oop2-tree-desc">Account is the parent class, with owner, balance, deposit, withdraw and month_end. SavingsAccount inherits from it, adds rate and add_interest, and overrides month_end. CheckingAccount inherits from it, adds overdraft, overrides withdraw and month_end, and extends __str__ using super.</desc>
<g font-size="11" font-weight="700">
<text x="3" y="20" fill="var(--h-cherry)">+ added</text>
<text x="3" y="38" fill="var(--h-fig-text)">↻ overridden</text>
<text x="3" y="56" fill="var(--h-fig-muted)">plain: inherited</text>
</g>
<text x="474" y="34" font-size="11" font-weight="700" fill="var(--h-fig-muted)">PARENT · BASE CLASS</text>
<rect x="220" y="8" width="240" height="124" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<text x="340" y="34" text-anchor="middle" font-size="15" font-weight="700" fill="var(--h-fig-text)">Account</text>
<line x1="220" y1="46" x2="460" y2="46" stroke="var(--h-fig-line)"/>
<g font-family="var(--md-code-font-family, monospace)" font-size="12" fill="var(--h-fig-text)">
<text x="238" y="68">owner, balance</text>
<text x="238" y="90">deposit(), withdraw()</text>
<text x="238" y="112">month_end(), __str__()</text>
</g>
<polygon points="340,134 331,149 349,149" fill="var(--md-default-bg-color)" stroke="var(--h-fig-text)" stroke-width="1.5"/>
<g stroke="var(--h-fig-text)" stroke-width="1.5" fill="none">
<line x1="340" y1="149" x2="340" y2="160"/>
<polyline points="153,178 153,160 527,160 527,178"/>
</g>
<text x="352" y="174" font-size="11" font-weight="600" fill="var(--h-fig-muted)">inherits from</text>
<rect x="3" y="178" width="300" height="122" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<rect x="377" y="178" width="300" height="122" rx="10" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="153" y="206" text-anchor="middle" font-size="14" font-weight="700" fill="var(--h-fig-text)">SavingsAccount</text>
<text x="527" y="206" text-anchor="middle" font-size="14" font-weight="700" fill="var(--h-fig-text)">CheckingAccount</text>
<line x1="3" y1="218" x2="303" y2="218" stroke="var(--h-fig-line)"/>
<line x1="377" y1="218" x2="677" y2="218" stroke="var(--h-fig-line)"/>
<g font-family="var(--md-code-font-family, monospace)" font-size="12">
<text x="21" y="240" fill="var(--h-cherry)" font-weight="700">+ rate</text>
<text x="21" y="260" fill="var(--h-cherry)" font-weight="700">+ add_interest()</text>
<text x="21" y="280" fill="var(--h-fig-text)">↻ month_end()</text>
<text x="395" y="238" fill="var(--h-cherry)" font-weight="700">+ overdraft</text>
<text x="395" y="256" fill="var(--h-fig-text)">↻ withdraw()</text>
<text x="395" y="274" fill="var(--h-fig-text)">↻ month_end()</text>
<text x="395" y="292" fill="var(--h-fig-text)">↻ __str__() <tspan font-family="var(--md-text-font-family, sans-serif)" font-size="10.5" fill="var(--h-fig-muted)">via super()</tspan></text>
</g>
</svg>
</figure>

- The **parent class**, also called the **base class** or superclass,
  is `Account`.
- The **child classes**, or **subclasses**, are `SavingsAccount` and
  `CheckingAccount`.
- A child **inherits** every attribute and method of its parent. It can
  then **add** new ones and **override** inherited ones.

The syntax is one pair of brackets after the class name. A subclass
with no body at all is already a working account:

```python
class BusinessAccount(Account):
    pass


acme = BusinessAccount("Acme", 10)
acme.deposit(90)        # 100: deposit came from Account
print(acme)             # Acme: 100 ALL: __str__ came from Account
```

Every class has a parent, even when you do not write one. `Account`
inherits from Python's built-in class `object`, which is where the
default `__str__` and `__repr__` you saw printing
`<__main__.Account object at 0x...>` came from.

## Step 2: Extend the constructor with `super()`

A savings account needs everything `Account.__init__` already sets up,
plus an interest rate. Do not copy the parent's checks. Call the
parent's `__init__` with `super()`, then add what is new:

```python
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
```

`super()` means "the parent class, for this object". The line
`super().__init__(owner, balance)` runs all of `Account`'s validation
and sets `_owner` and `_balance`. The next lines handle only what is
new. The validation from the last tutorial still protects every savings
account:

```python
SavingsAccount("", 100)              # ValueError: owner must not be empty
SavingsAccount("Ada", 100, rate=50)  # ValueError: rate must be between 0 and 10
```

!!! warning "Forget `super().__init__` and the object is half built"

    If the subclass defines `__init__` and never calls the parent's,
    `Account.__init__` does not run. The object exists, but it has no
    `_owner` or `_balance`, and the first access fails with
    `AttributeError: ... has no attribute '_balance'`. When a subclass
    has its own `__init__`, its first line is almost always
    `super().__init__(...)`.

## Step 3: Add new behaviour

A subclass can add methods the parent does not have. Savings accounts
earn interest:

```python
    def add_interest(self):
        """Add this month's interest and return the amount added."""
        interest = self._balance * self._rate // 100
        self._balance += interest
        return interest
```

The rate is a whole percentage per month, and `//` keeps the interest
in whole lek, the same reason the balance is an integer.

Everything else is inherited unchanged, including the rules:

```python
grace = SavingsAccount("Grace", 1000, rate=2)
grace.deposit(100)      # 1100: inherited from Account
grace.add_interest()    # 22: new in SavingsAccount
grace.withdraw(5000)    # ValueError: insufficient funds, from Account
```

## Step 4: Override a method

A checking account must let the balance go below zero, up to its
overdraft limit. `Account.withdraw` refuses that. So `CheckingAccount`
defines its own `withdraw`, which **overrides** the parent's:

```python
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
        self._check_amount(amount)
        if self._balance - amount < -self._overdraft:
            raise ValueError("overdraft limit exceeded")
        self._balance -= amount
        return self._balance
```

```python
linus = CheckingAccount("Linus", overdraft=500)
linus.withdraw(300)    # -300: allowed
linus.withdraw(300)    # ValueError: overdraft limit exceeded
```

Two details from the last tutorial pay off here. The new `withdraw`
reuses the inherited `_check_amount`, so amounts are still validated in
one place. And it can update `self._balance` directly, because we used
a single underscore. Had we named it `__balance`, name mangling would
have stored it as `_Account__balance`, and `self.__balance` inside
`CheckingAccount` would have looked for `_CheckingAccount__balance`
instead.

### How Python finds a method

When you call a method, Python searches for it starting at the
object's own class, then moves up through the parents, and uses the
first match it finds.

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 176" role="img" aria-labelledby="oop2-look-title oop2-look-desc">
<title id="oop2-look-title">Method lookup goes from the object's class up to its parents</title>
<desc id="oop2-look-desc">For grace.deposit, Python checks SavingsAccount, which has no deposit, then Account, which has it, so Account's deposit runs. For linus.withdraw, Python checks CheckingAccount first, which has its own withdraw, so that one runs and Account is never checked.</desc>
<defs><marker id="oop2-look-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<g font-family="var(--md-code-font-family, monospace)" font-size="12.5" font-weight="700">
<text x="3" y="16" fill="var(--h-fig-text)">grace.deposit(100)</text>
<text x="3" y="104" fill="var(--h-fig-text)">linus.withdraw(300)</text>
</g>
<g font-size="12.5" font-weight="700" text-anchor="middle">
<rect x="3" y="26" width="134" height="46" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="70" y="54" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">grace</text>
<rect x="183" y="26" width="134" height="46" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="250" y="47" fill="var(--h-fig-text)">SavingsAccount</text>
<text x="250" y="63" font-size="10.5" font-weight="600" fill="var(--h-fig-muted)">no deposit here</text>
<rect x="363" y="26" width="134" height="46" rx="8" fill="var(--h-cherry)"/>
<text x="430" y="47" fill="#ffffff">Account</text>
<text x="430" y="63" font-size="10.5" font-weight="600" fill="#ffffff">found: this runs</text>
<rect x="543" y="26" width="134" height="46" rx="8" fill="none" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<text x="610" y="54" fill="var(--h-fig-muted)">object</text>
<rect x="3" y="114" width="134" height="46" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="70" y="142" fill="var(--h-fig-text)" font-family="var(--md-code-font-family, monospace)">linus</text>
<rect x="183" y="114" width="134" height="46" rx="8" fill="var(--h-cherry)"/>
<text x="250" y="135" fill="#ffffff">CheckingAccount</text>
<text x="250" y="151" font-size="10.5" font-weight="600" fill="#ffffff">found: this runs</text>
<rect x="363" y="114" width="134" height="46" rx="8" fill="none" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<text x="430" y="135" fill="var(--h-fig-muted)">Account</text>
<text x="430" y="151" font-size="10.5" font-weight="600" fill="var(--h-fig-muted)">never checked</text>
<rect x="543" y="114" width="134" height="46" rx="8" fill="none" stroke="var(--h-fig-line)" stroke-dasharray="5 4"/>
<text x="610" y="142" fill="var(--h-fig-muted)">object</text>
</g>
<g stroke="var(--h-fig-line)" stroke-width="2" marker-end="url(#oop2-look-arrow)">
<line x1="141" y1="49" x2="177" y2="49"/>
<line x1="321" y1="49" x2="357" y2="49"/>
<line x1="141" y1="137" x2="177" y2="137"/>
</g>
</svg>
</figure>

That search order is called the **method resolution order**, or MRO.
You can print it:

```python
SavingsAccount.mro()    # [SavingsAccount, Account, object]
```

This is also why overriding works: the child's version is found first,
so the parent's is never reached.

## Step 5: Extend an inherited method with `super()`

Overriding replaces the parent's method. Sometimes you want to keep it
and add to it. Call it through `super()` inside the override.

A checking account should print like any account, plus its overdraft:

```python
    def __str__(self):
        return f"{super().__str__()} (overdraft {self.overdraft})"
```

```python
print(linus)    # Linus: -300 ALL (overdraft 500)
```

`super().__str__()` runs `Account.__str__` and returns
`Linus: -300 ALL`. The override adds the rest. If the base format ever
changes, the checking account follows automatically.

### One change to version 1

In version 1, `__repr__` started with the class name written out:
`f"Account(owner=..."`. That is fine until a subclass inherits it: a
`BusinessAccount` would then call itself `Account(...)` in every
debugger and list, which is misleading. The fix is to ask the object
for its real class name:

```python
    def __repr__(self):
        return (f"{type(self).__name__}(owner={self.owner!r}, "
                f"balance={self.balance})")
```

`type(self).__name__` is `"Account"` for an account and
`"BusinessAccount"` for a business account. A parent class should not
assume it is the only class that will use its methods. The two new
classes override `__repr__` anyway, to include their extra attribute:

```python
repr(grace)    # "SavingsAccount(owner='Grace', balance=1122, rate=2)"
repr(linus)    # "CheckingAccount(owner='Linus', balance=-300, overdraft=500)"
```

## Step 6: Polymorphism: one call, many behaviours

Every account needs some work done at the end of each month, but the
work is different: savings accounts earn interest, checking accounts
may be charged a fee, plain accounts do nothing. Give the parent a
`month_end` method that does nothing, and let each child override it:

```python
# in Account
    def month_end(self):
        """Apply end-of-month rules and return the new balance.

        A plain account has none.
        """
        return self._balance

# in SavingsAccount
    def month_end(self):
        """Add this month's interest and return the new balance."""
        self.add_interest()
        return self._balance

# in CheckingAccount
    def month_end(self):
        """Charge the monthly fee if overdrawn; return the new balance."""
        if self._balance < 0:
            self._balance -= self.fee
        return self._balance
```

Now the code that closes the month does not need to know which kind of
account it holds:

```python
accounts = [
    Account("Ada", 500),
    SavingsAccount("Grace", 1000, rate=2),
    CheckingAccount("Linus", overdraft=500),
]
accounts[2].withdraw(300)
for account in accounts:
    account.month_end()
    print(account)
```

```
Ada: 500 ALL
Grace: 1020 ALL
Linus: -400 ALL (overdraft 500)
```

<figure class="h-figure" markdown="0">
<svg viewBox="0 0 680 210" role="img" aria-labelledby="oop2-poly-title oop2-poly-desc">
<title id="oop2-poly-title">One call, three behaviours</title>
<desc id="oop2-poly-desc">The loop calls account.month_end() on three objects. On the Account for Ada, nothing changes and the balance stays 500. On the SavingsAccount for Grace, 20 lek of interest is added, giving 1020. On the CheckingAccount for Linus, who is overdrawn, the 100 lek fee is charged, giving minus 400.</desc>
<defs><marker id="oop2-poly-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 z" fill="var(--h-fig-line)"/></marker></defs>
<g font-size="12.5" font-weight="700">
<rect x="3" y="10" width="180" height="52" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="18" y="32" fill="var(--h-fig-text)">Account</text>
<text x="18" y="50" font-size="11" font-weight="400" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">Ada, 500</text>
<rect x="3" y="79" width="180" height="52" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="18" y="101" fill="var(--h-fig-text)">SavingsAccount</text>
<text x="18" y="119" font-size="11" font-weight="400" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">Grace, 1000, rate 2</text>
<rect x="3" y="148" width="180" height="52" rx="8" fill="var(--h-fig-box)" stroke="var(--h-fig-line)"/>
<text x="18" y="170" fill="var(--h-fig-text)">CheckingAccount</text>
<text x="18" y="188" font-size="11" font-weight="400" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">Linus, -300</text>
</g>
<rect x="250" y="75" width="180" height="60" rx="10" fill="var(--h-cherry)"/>
<text x="340" y="102" text-anchor="middle" font-size="13" font-weight="700" fill="#ffffff" font-family="var(--md-code-font-family, monospace)">.month_end()</text>
<text x="340" y="121" text-anchor="middle" font-size="10.5" fill="#ffffff" opacity="0.9">the same call for each</text>
<g font-size="12.5">
<rect x="497" y="10" width="180" height="52" rx="8" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)"/>
<text x="512" y="32" font-weight="700" fill="var(--h-fig-text)">no change</text>
<text x="512" y="50" font-size="11" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">500</text>
<rect x="497" y="79" width="180" height="52" rx="8" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)"/>
<text x="512" y="101" font-weight="700" fill="var(--h-fig-text)">+20 interest</text>
<text x="512" y="119" font-size="11" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">1020</text>
<rect x="497" y="148" width="180" height="52" rx="8" fill="var(--md-default-bg-color)" stroke="var(--h-fig-line)"/>
<text x="512" y="170" font-weight="700" fill="var(--h-fig-text)">-100 fee</text>
<text x="512" y="188" font-size="11" fill="var(--h-fig-muted)" font-family="var(--md-code-font-family, monospace)">-400</text>
</g>
<g stroke="var(--h-fig-line)" stroke-width="2" fill="none" marker-end="url(#oop2-poly-arrow)">
<path d="M187 36 C 220 36, 215 96, 244 96"/>
<line x1="187" y1="105" x2="244" y2="105"/>
<path d="M187 174 C 220 174, 215 114, 244 114"/>
<path d="M434 96 C 465 96, 460 36, 491 36"/>
<line x1="434" y1="105" x2="491" y2="105"/>
<path d="M434 114 C 465 114, 460 174, 491 174"/>
</g>
</svg>
</figure>

That is **polymorphism**: objects of different classes respond to the
same method call, each in its own way. The loop only relies on one
promise, *every account has a `month_end` method*, and each class keeps
that promise differently.

Compare the version without it:

```python
for account in accounts:                         # don't do this
    if isinstance(account, SavingsAccount):
        account.add_interest()
    elif isinstance(account, CheckingAccount):
        if account.balance < 0:
            ...                                  # charge the fee somehow
```

Every new account type would mean editing this loop, and every other
loop like it. With polymorphism, a new type means one new class with
its own `month_end`, and no existing code changes.

You have used polymorphism since your first week: `print` works on any
object because every class has a `__str__`, and `len` works on strings,
lists and dictionaries alike.

## Step 7: Check relationships with `isinstance` and `issubclass`

Sometimes you do need to ask what kind of object you have, or how two
classes are related.

| Expression | Result | Why |
|---|---|---|
| `isinstance(grace, SavingsAccount)` | `True` | grace was built from it |
| `isinstance(grace, Account)` | `True` | a savings account *is an* account |
| `isinstance(ada, SavingsAccount)` | `False` | a plain account is not a savings account |
| `isinstance(grace, (SavingsAccount, CheckingAccount))` | `True` | a tuple means "any of these" |
| `type(grace) is SavingsAccount` | `True` | its exact class |
| `type(grace) is Account` | `False` | `type` ignores parents |
| `issubclass(SavingsAccount, Account)` | `True` | the child inherits from the parent |
| `issubclass(Account, SavingsAccount)` | `False` | not the other way round |
| `issubclass(SavingsAccount, object)` | `True` | every class inherits from `object` |

`isinstance` checks an **object** against a class, and counts parents.
`issubclass` checks a **class** against a class. `type(x) is Y` checks
the exact class only, ignoring inheritance, which is rarely what you
want.

Now the puzzle from the last tutorial has an answer:

```python
issubclass(bool, int)    # True
isinstance(True, int)    # True: a bool *is an* int
type(True) is int        # False: its exact class is bool
```

`bool` is a subclass of `int`, so every `True` passes an `int` check.
That is why `_check_amount` tests for `bool` separately.

Use these checks at the edges of your program, for example to validate
input, as the constructors do. Inside your own logic, prefer calling a
method and letting polymorphism choose the behaviour.

## Step 8: Design simple hierarchies

A few rules keep inheritance helpful instead of tangled.

- **Inherit only for "is a".** A savings account *is an* account. A
  customer *has* accounts but is not one, and a transaction *belongs to*
  an account but is not one. "Has a" relationships are modelled by
  storing one object inside another, which you will draw in the UML
  project.
- **Keep the parent's promises.** Code written for `Account` must still
  work when given a `CheckingAccount`. Its `withdraw` still takes an
  amount, still validates it, still returns the new balance and still
  raises `ValueError` when refused. Only the limit changed. This rule
  has a name, the *Liskov substitution principle*, and breaking it is
  the most common inheritance bug.
- **Keep hierarchies shallow.** One or two levels below the base class
  is plenty. If you find yourself five levels deep, some of those
  classes are probably "has a" in disguise.
- **Put shared code in the parent, differences in the children.** If
  two children contain the same lines, move them up.

## The code so far

This is version 2 of the wallet, tagged
[`v2-inheritance`](https://github.com/evisp/oop-wallet/tree/v2-inheritance)
in the companion repository.

??? example "wallet.py · version 2"

    ```python title="wallet.py"
    #!/usr/bin/env python3
    """A small digital wallet, built up across the OOP tutorials.

    Version 2: Inheritance & Polymorphism.
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

        def month_end(self):
            """Apply end-of-month rules and return the new balance.

            A plain account has none.
            """
            return self._balance

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
            self._balance += interest
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
            self._check_amount(amount)
            if self._balance - amount < -self._overdraft:
                raise ValueError("overdraft limit exceeded")
            self._balance -= amount
            return self._balance

        def month_end(self):
            """Charge the monthly fee if overdrawn; return the new balance."""
            if self._balance < 0:
                self._balance -= self.fee
            return self._balance

        def __str__(self):
            return f"{super().__str__()} (overdraft {self.overdraft})"

        def __repr__(self):
            return (f"{type(self).__name__}(owner={self.owner!r}, "
                    f"balance={self.balance}, overdraft={self.overdraft})")


    if __name__ == "__main__":
        accounts = [
            Account("Ada", 500),
            SavingsAccount("Grace", 1000, rate=2),
            CheckingAccount("Linus", overdraft=500),
        ]
        accounts[2].withdraw(300)
        for account in accounts:
            account.month_end()
            print(account)
        total = sum(account.balance for account in accounts)
        print(f"Total: {total} {Account.currency}")
    ```

```bash
./wallet.py
```

```
Ada: 500 ALL
Grace: 1020 ALL
Linus: -400 ALL (overdraft 500)
Total: 1120 ALL
```

!!! ai "AI in the loop"

    Before adding a class to a hierarchy, describe the new account type
    to an assistant and ask: *"Should this inherit from `Account`, or
    hold an `Account` instead? What promises of `Account` would it
    break?"* Then argue with the answer. Deciding *is a* versus *has a*
    is a design judgement, and it is exactly the kind of question your
    peers will ask in a code review.

## When something goes wrong

??? note "`AttributeError: 'SavingsAccount' object has no attribute '_balance'`"

    The subclass has its own `__init__` and does not call
    `super().__init__(...)`, so the parent never set `_balance` up. Add
    the call as the first line.

??? note "My override never runs; the parent's method runs instead"

    The names do not match exactly. A typo such as `month_End` creates a
    new, separate method, and Python keeps finding the parent's
    `month_end`. Copy the name from the parent.

??? note "`TypeError: SavingsAccount.__init__() takes from 2 to 4 positional arguments but 5 were given`"

    The subclass's `__init__` has its own parameters. Check them, and
    pass extra values by name for clarity: `SavingsAccount("Ada", 100, rate=2)`.

??? note "`AttributeError: 'CheckingAccount' object has no attribute '_CheckingAccount__balance'`"

    The parent stores the value with two underscores, so it is
    name-mangled to the parent's class. Use a single underscore for
    attributes subclasses need, as the wallet does.

??? note "`RecursionError` inside an overridden method"

    The override calls itself, for example `self.withdraw(amount)`
    inside `withdraw`. To reach the parent's version, call
    `super().withdraw(amount)`.

## Explain it to someone

- [ ] How inheritance lets a class reuse another class's behaviour
- [ ] Which class is the parent and which is the child, and what each inherits
- [ ] How to create a subclass that adds attributes and methods
- [ ] What `super().__init__(...)` does, and what happens without it
- [ ] The difference between overriding a method and extending it with `super()`
- [ ] How Python finds a method: the method resolution order
- [ ] What polymorphism is, and why it beats a chain of `isinstance` checks
- [ ] The difference between `isinstance`, `issubclass` and `type(x) is Y`
- [ ] Why `isinstance(True, int)` is `True`
- [ ] How to decide between "is a" and "has a" when designing a hierarchy

## Quick reference

| Code | What it does |
|---|---|
| `class Child(Parent):` | Define a subclass |
| `super().__init__(...)` | Run the parent's initialiser |
| `def method(self):` in the child | Override the parent's method |
| `super().method()` | Call the parent's version inside an override |
| `type(self).__name__` | The object's actual class name |
| `Class.mro()` | The order Python searches for methods |
| `isinstance(obj, Class)` | Is `obj` a `Class`, or a subclass of it? |
| `issubclass(A, B)` | Does class `A` inherit from `B`? |

## Next

`Account` can still be created on its own, and nothing forces a new
account type to define `month_end`. Next you turn the base class into a
contract that every account type must fulfil.

[Abstract Classes & Interfaces](abstract-classes.md){ .h-button }
