# ============================================================
#   CLASS 3 — FUNCTIONS, LOOPS & OOP  (3 Hours)
#   Beginner Level | Real-World Examples Throughout
# ============================================================
#
#   PART A — FUNCTIONS (Deep Dive)            ~50 minutes
#     1. Why functions exist (real-world analogy)
#     2. Parameters & arguments
#     3. Default parameter values
#     4. Returning values
#     5. Returning multiple values
#     6. Variable scope (local vs global)
#
#   PART B — LOOPS (Deep Dive)                ~50 minutes
#     7. for loop recap + range tricks
#     8. Looping over lists & strings
#     9. while loops + real examples
#    10. break & continue
#    11. Nested loops
#    12. Loop + accumulator pattern
#
#   PART C — OOP (Object-Oriented Programming) ~80 minutes
#    13. What is OOP? (real-world analogy)
#    14. Creating a Class and Object
#    15. The __init__ method (constructor)
#    16. Instance methods
#    17. Real-world class: BankAccount
#    18. Real-world class: Student
#    19. Inheritance — extending a class
#    20. Mini Project: School System
#
# ============================================================


# ╔══════════════════════════════════════════════════════════╗
#   PART A — FUNCTIONS
# ╚══════════════════════════════════════════════════════════╝

# ─────────────────────────────────────────────
# SECTION 1 — WHY FUNCTIONS EXIST
# ─────────────────────────────────────────────
# Real-world analogy:
#   Think of a function like a VENDING MACHINE.
#   - You press a button (call the function).
#   - You might insert money (pass in arguments).
#   - It does its job and gives you a snack (returns a result).
#   - You don't need to know HOW the machine works inside.
#   - And you can use the same machine many times!
#
# Without functions → you repeat the same code everywhere.
# With functions    → write once, use anywhere.

# WITHOUT functions (bad — repeated code):
print("--- Order 1 ---")
item1 = "Burger"
qty1  = 2
price1 = 150
print(f"Item: {item1} | Qty: {qty1} | Total: Rs.{qty1 * price1}")

print("--- Order 2 ---")
item2 = "Pizza"
qty2  = 1
price2 = 350
print(f"Item: {item2} | Qty: {qty2} | Total: Rs.{qty2 * price2}")

# WITH a function (clean — no repetition):
def print_order(item, qty, price):
    total = qty * price
    print(f"Item: {item} | Qty: {qty} | Total: Rs.{total}")

print_order("Burger", 2, 150)
print_order("Pizza",  1, 350)
print_order("Fries",  3, 80)
# Same result — but only ONE block of code!


# ─────────────────────────────────────────────
# SECTION 2 — PARAMETERS & ARGUMENTS
# ─────────────────────────────────────────────
# Parameters = the variable names written inside def()
# Arguments  = the actual values you pass when calling
#
#              parameter
#                 ↓
# def greet(name):
#     print("Hello", name)
#
# greet("Ali")
#         ↑
#      argument

def greet(name):
    print(f"Hello, {name}! Welcome aboard.")

greet("Ali")       # "Ali" is the argument
greet("Sara")
greet("Ahmed")

# Multiple parameters
def describe_product(product_name, category, price):
    print(f"Product : {product_name}")
    print(f"Category: {category}")
    print(f"Price   : Rs.{price}")
    print("---")

describe_product("iPhone 15", "Electronics", 250000)
describe_product("Office Chair", "Furniture", 15000)


# ─────────────────────────────────────────────
# SECTION 3 — DEFAULT PARAMETER VALUES
# ─────────────────────────────────────────────
# You can give a parameter a default value.
# If the caller doesn't pass that argument, the default is used.
#
# Real-world analogy:
#   Like ordering coffee. If you don't specify sugar, they add 1 spoon.
#   But you can always ask for more or less.

def make_coffee(size, sugar=1, milk=True):
    print(f"\nCoffee Order:")
    print(f"  Size  : {size}")
    print(f"  Sugar : {sugar} spoon(s)")
    print(f"  Milk  : {'Yes' if milk else 'No'}")

make_coffee("Large")                          # uses default sugar=1, milk=True
make_coffee("Medium", sugar=2)                # overrides only sugar
make_coffee("Small", sugar=0, milk=False)     # overrides both


# ─────────────────────────────────────────────
# SECTION 4 — RETURNING VALUES
# ─────────────────────────────────────────────
# A function can SEND BACK a result using 'return'.
# Think of it like asking a calculator a question —
# it gives you the answer back.

def calculate_area(length, width):
    area = length * width
    return area         # send the result back to whoever called us

# The returned value can be stored in a variable
room_area = calculate_area(5, 4)
print(f"Room area: {room_area} sq meters")

# Or used directly in another expression
print(f"Two rooms: {calculate_area(5, 4) + calculate_area(3, 3)} sq meters")

# Real-world: electricity bill calculator
def electricity_bill(units_used, rate_per_unit=18):
    bill = units_used * rate_per_unit
    tax  = bill * 0.17              # 17% GST
    total = bill + tax
    return total

monthly_bill = electricity_bill(300)
print(f"Electricity bill: Rs.{monthly_bill:.2f}")


# ─────────────────────────────────────────────
# SECTION 5 — RETURNING MULTIPLE VALUES
# ─────────────────────────────────────────────
# Python lets a function return more than one value at once.
# They come back as a tuple (group of values).

def min_max_avg(numbers):
    minimum = min(numbers)
    maximum = max(numbers)
    average = sum(numbers) / len(numbers)
    return minimum, maximum, round(average, 2)   # return 3 values at once

scores = [72, 88, 45, 95, 60, 78]

low, high, avg = min_max_avg(scores)    # unpack the 3 returned values
print(f"Lowest : {low}")
print(f"Highest: {high}")
print(f"Average: {avg}")


# ─────────────────────────────────────────────
# SECTION 6 — VARIABLE SCOPE (Local vs Global)
# ─────────────────────────────────────────────
# Scope = where a variable can be seen and used.
#
# LOCAL  variable → created inside a function, only exists there.
# GLOBAL variable → created outside functions, visible everywhere.
#
# Real-world analogy:
#   A LOCAL variable is like a note on your desk at work —
#   only you can see it while you're there.
#   A GLOBAL variable is like a notice board — everyone sees it.

shop_name = "Ali's Store"       # GLOBAL — available everywhere

def show_shop():
    discount = 10               # LOCAL — only exists inside this function
    print(f"Shop   : {shop_name}")   # can read the global variable
    print(f"Discount: {discount}%")

show_shop()

# print(discount)   ← THIS WOULD CAUSE AN ERROR — discount is local!

# Using 'global' keyword to modify a global variable inside a function
visit_count = 0

def record_visit():
    global visit_count          # tell Python we mean the GLOBAL one
    visit_count += 1
    print(f"Visit number: {visit_count}")

record_visit()
record_visit()
record_visit()


# ╔══════════════════════════════════════════════════════════╗
#   PART B — LOOPS (Deep Dive)
# ╚══════════════════════════════════════════════════════════╝

# ─────────────────────────────────────────────
# SECTION 7 — for LOOP RECAP + range() TRICKS
# ─────────────────────────────────────────────
# range(stop)           → 0, 1, 2, ..., stop-1
# range(start, stop)    → start, start+1, ..., stop-1
# range(start, stop, step) → jump by 'step' each time

# Count 1 to 5
for i in range(1, 6):
    print(i, end=" ")       # end=" " keeps everything on one line
print()                     # move to next line

# Count only EVEN numbers from 2 to 20
print("Even numbers:", end=" ")
for i in range(2, 21, 2):  # step = 2
    print(i, end=" ")
print()

# Count DOWN (step = -1)
print("Countdown:", end=" ")
for i in range(10, 0, -1):
    print(i, end=" ")
print("Go!")

# Real-world: generate floor numbers in a building
floors = 15
print(f"\n--- {floors}-Floor Building ---")
for floor in range(1, floors + 1):
    label = f"Floor {floor}"
    if floor == 1:
        label += " (Ground Floor)"
    elif floor == floors:
        label += " (Rooftop)"
    print(label)


# ─────────────────────────────────────────────
# SECTION 8 — LOOPING OVER LISTS & STRINGS
# ─────────────────────────────────────────────

# Looping over a list — like scanning items at a checkout counter
cart = ["Milk", "Bread", "Eggs", "Butter", "Juice"]

print("\n--- Shopping Cart ---")
for item in cart:
    print(f"  ✔ {item}")

# enumerate() gives you the index AND the value at the same time
print("\n--- Numbered List ---")
for index, item in enumerate(cart, start=1):   # start numbering at 1
    print(f"  {index}. {item}")

# Looping over a string (character by character)
word = "PYTHON"
print("\n--- Letters ---")
for letter in word:
    print(letter, end=" - ")
print()

# Real-world: check if an email address is valid (basic check)
email = "ali@example.com"
if "@" in email and "." in email:
    print(f"\n{email} looks like a valid email.")
else:
    print(f"\n{email} does NOT look valid.")


# ─────────────────────────────────────────────
# SECTION 9 — while LOOPS + REAL EXAMPLES
# ─────────────────────────────────────────────
# while loop = "keep going AS LONG AS this is True"
# Best when you don't know exactly how many times to repeat.
#
# Real-world analogy:
#   Like a traffic light — keep the red light ON while cars are waiting.
#   Stop only when the condition changes.

# Example 1: ATM PIN entry (max 3 attempts)
correct_pin = "1234"
attempts    = 0
max_tries   = 3

while attempts < max_tries:
    entered_pin = input("\nEnter your ATM PIN: ")
    attempts += 1

    if entered_pin == correct_pin:
        print("✔ PIN accepted. Welcome!")
        break                   # exit the loop immediately
    else:
        remaining = max_tries - attempts
        if remaining > 0:
            print(f"✘ Wrong PIN. {remaining} attempt(s) left.")
        else:
            print("✘ Card blocked. Too many wrong attempts.")

# Example 2: Savings goal tracker
print("\n--- Savings Goal Tracker ---")
goal    = 10000
savings = 0
month   = 0

while savings < goal:
    monthly_deposit = float(input(f"Month {month + 1} — How much did you save? Rs. "))
    savings += monthly_deposit
    month   += 1
    print(f"  Total so far: Rs.{savings:.2f} / Rs.{goal}")

print(f"\nGoal reached in {month} month(s)! Well done.")


# ─────────────────────────────────────────────
# SECTION 10 — break & continue
# ─────────────────────────────────────────────
# break    → STOP the loop completely right now
# continue → SKIP the rest of this iteration, go to the next one
#
# Real-world analogy:
#   break    = emergency stop button on a conveyor belt
#   continue = "skip this item, move to the next one"

# --- break: stop scanning when a faulty item is found ---
print("\n--- Quality Check ---")
items = ["OK", "OK", "OK", "FAULTY", "OK", "OK"]

for item in items:
    if item == "FAULTY":
        print("Faulty item found! Stopping the line.")
        break
    print(f"Item checked: {item} ✔")

# --- continue: skip out-of-stock items ---
print("\n--- Menu (skip unavailable items) ---")
menu = [
    ("Biryani",  True),
    ("Karahi",   False),     # unavailable
    ("Nihari",   True),
    ("Haleem",   False),     # unavailable
    ("Naan",     True),
]

for dish, available in menu:
    if not available:
        continue            # skip to the next dish
    print(f"  ✔ {dish}")


# ─────────────────────────────────────────────
# SECTION 11 — NESTED LOOPS
# ─────────────────────────────────────────────
# A loop inside another loop.
# The inner loop runs COMPLETELY for every single step of the outer loop.
#
# Real-world analogy:
#   Like a seating chart: for every row, assign every seat.

# --- Seating chart ---
rows  = 3
seats = 4

print("\n--- Cinema Seating ---")
for row in range(1, rows + 1):
    for seat in range(1, seats + 1):
        print(f"R{row}S{seat}", end="  ")
    print()     # new line after each row finishes

# --- Multiplication table grid ---
print("\n--- Multiplication Table (1–5) ---")
for i in range(1, 6):
    for j in range(1, 6):
        print(f"{i * j:4}", end="")     # :4 pads to 4 characters wide
    print()


# ─────────────────────────────────────────────
# SECTION 12 — LOOP + ACCUMULATOR PATTERN
# ─────────────────────────────────────────────
# Very common pattern:
#   Start a variable at 0 (or [])
#   Loop through items
#   Add/collect something each time
#
# Real-world: running a total at a cash register

prices = [120, 350, 80, 450, 200, 95]

total        = 0        # accumulator starts at 0
expensive    = []       # list accumulator starts empty

for price in prices:
    total += price              # add each price to the running total
    if price >= 200:
        expensive.append(price) # collect prices above 200

print(f"\nTotal bill      : Rs.{total}")
print(f"Expensive items : {expensive}")
print(f"Number expensive: {len(expensive)}")


# ╔══════════════════════════════════════════════════════════╗
#   PART C — OOP (Object-Oriented Programming)
# ╚══════════════════════════════════════════════════════════╝

# ─────────────────────────────────────────────
# SECTION 13 — WHAT IS OOP?
# ─────────────────────────────────────────────
# Until now, we stored data in variables and lists.
# OOP lets us GROUP related data AND actions together.
#
# Real-world analogy — think about a CAR:
#
#   Every car has:
#     DATA (attributes):  brand, model, colour, speed, fuel_level
#     ACTIONS (methods):  start(), accelerate(), brake(), refuel()
#
# In OOP:
#   CLASS  = the BLUEPRINT (the car design on paper)
#   OBJECT = an actual INSTANCE built from that blueprint (a real car)
#
# Example:
#   class Car:          ← blueprint
#       ...
#
#   my_car = Car(...)   ← one actual car (object) built from that blueprint
#   your_car = Car(...) ← a different car — same blueprint, different data
#
# KEY TERMS:
#   Class      → blueprint / template
#   Object     → a real item created from the class
#   Attribute  → a piece of data belonging to the object (e.g. brand, speed)
#   Method     → a function belonging to the object (e.g. start, brake)
#   self       → refers to the current object itself (like saying "my own")


# ─────────────────────────────────────────────
# SECTION 14 — CREATING A CLASS AND OBJECT
# ─────────────────────────────────────────────

# Simplest possible class
class Dog:
    # attributes (data)
    name  = "Unknown"
    breed = "Unknown"
    age   = 0

    # method (action)
    def bark(self):
        print(f"{self.name} says: Woof! Woof!")

    def describe(self):
        print(f"Name: {self.name} | Breed: {self.breed} | Age: {self.age}")

# Create two objects (two different dogs) from the same class
dog1 = Dog()
dog1.name  = "Bruno"
dog1.breed = "German Shepherd"
dog1.age   = 3

dog2 = Dog()
dog2.name  = "Coco"
dog2.breed = "Poodle"
dog2.age   = 1

dog1.bark()
dog1.describe()
dog2.bark()
dog2.describe()


# ─────────────────────────────────────────────
# SECTION 15 — THE __init__ METHOD (Constructor)
# ─────────────────────────────────────────────
# Manually setting attributes every time is messy.
# __init__ is a special method that runs AUTOMATICALLY
# when you create a new object. It sets up the data
# right from the start.
#
# Think of __init__ as the REGISTRATION FORM you fill out
# when buying a new SIM card — it sets up your account
# the moment it's created.

class Person:

    def __init__(self, name, age, city):
        # self.name = name means:
        #   "store the 'name' argument as THIS object's own 'name'"
        self.name = name
        self.age  = age
        self.city = city

    def introduce(self):
        print(f"Hi! I'm {self.name}, {self.age} years old, from {self.city}.")

# Now creating objects is clean and fast
person1 = Person("Ali",   22, "Karachi")
person2 = Person("Sara",  19, "Lahore")
person3 = Person("Ahmed", 25, "Islamabad")

person1.introduce()
person2.introduce()
person3.introduce()

# You can still access individual attributes
print(f"\n{person1.name} lives in {person1.city}.")


# ─────────────────────────────────────────────
# SECTION 16 — INSTANCE METHODS
# ─────────────────────────────────────────────
# Methods are functions INSIDE a class.
# They always take 'self' as the FIRST parameter.
# 'self' lets the method access the object's own data.

class Rectangle:

    def __init__(self, length, width):
        self.length = length
        self.width  = width

    def area(self):
        return self.length * self.width

    def perimeter(self):
        return 2 * (self.length + self.width)

    def is_square(self):
        return self.length == self.width      # returns True or False

    def describe(self):
        print(f"Rectangle {self.length} x {self.width}")
        print(f"  Area     : {self.area()}")
        print(f"  Perimeter: {self.perimeter()}")
        print(f"  Is square: {self.is_square()}")

r1 = Rectangle(5, 3)
r2 = Rectangle(4, 4)

r1.describe()
print()
r2.describe()


# ─────────────────────────────────────────────
# SECTION 17 — REAL-WORLD CLASS: BankAccount
# ─────────────────────────────────────────────
# Real-world analogy:
#   A bank account has:
#     DATA:    owner's name, account number, balance
#     ACTIONS: deposit money, withdraw money, check balance

class BankAccount:

    def __init__(self, owner, account_number, initial_balance=0):
        self.owner          = owner
        self.account_number = account_number
        self.balance        = initial_balance
        self.transactions   = []        # list to keep a history

    def deposit(self, amount):
        if amount <= 0:
            print("Deposit amount must be positive.")
            return
        self.balance += amount
        self.transactions.append(f"Deposited Rs.{amount}")
        print(f"  ✔ Rs.{amount} deposited. New balance: Rs.{self.balance}")

    def withdraw(self, amount):
        if amount <= 0:
            print("Withdrawal amount must be positive.")
            return
        if amount > self.balance:
            print(f"  ✘ Insufficient funds. Balance: Rs.{self.balance}")
            return
        self.balance -= amount
        self.transactions.append(f"Withdrew  Rs.{amount}")
        print(f"  ✔ Rs.{amount} withdrawn. New balance: Rs.{self.balance}")

    def check_balance(self):
        print(f"  Account: {self.account_number} | Owner: {self.owner} | Balance: Rs.{self.balance}")

    def print_statement(self):
        print(f"\n  === Statement for {self.owner} ===")
        for record in self.transactions:
            print(f"    {record}")
        print(f"  Current Balance: Rs.{self.balance}")

# --- Using the BankAccount class ---
print("\n--- Bank Demo ---")
account1 = BankAccount("Ali Khan", "PK-001", 5000)
account1.check_balance()
account1.deposit(3000)
account1.withdraw(1500)
account1.withdraw(10000)   # should fail
account1.print_statement()

print()
account2 = BankAccount("Sara Ahmed", "PK-002")   # starts at 0
account2.deposit(20000)
account2.withdraw(5000)
account2.check_balance()


# ─────────────────────────────────────────────
# SECTION 18 — REAL-WORLD CLASS: Student
# ─────────────────────────────────────────────
# Real-world analogy:
#   A student has name and marks.
#   They can add marks, compute average, and get their grade.

class Student:

    def __init__(self, name, roll_number):
        self.name        = name
        self.roll_number = roll_number
        self.marks       = {}       # dictionary: subject → mark

    def add_marks(self, subject, mark):
        self.marks[subject] = mark
        print(f"  Marks added: {subject} = {mark}")

    def get_average(self):
        if len(self.marks) == 0:
            return 0
        return round(sum(self.marks.values()) / len(self.marks), 2)

    def get_grade(self):
        avg = self.get_average()
        if avg >= 90:   return "A"
        elif avg >= 75: return "B"
        elif avg >= 60: return "C"
        elif avg >= 50: return "D"
        else:           return "F"

    def print_report(self):
        print(f"\n  ┌─────────────────────────────────┐")
        print(f"  │  REPORT CARD                    │")
        print(f"  ├─────────────────────────────────┤")
        print(f"  │  Name   : {self.name:<22} │")
        print(f"  │  Roll # : {self.roll_number:<22} │")
        print(f"  ├─────────────────────────────────┤")
        for subject, mark in self.marks.items():
            print(f"  │  {subject:<12}: {mark:<20} │")
        print(f"  ├─────────────────────────────────┤")
        print(f"  │  Average: {self.get_average():<22} │")
        print(f"  │  Grade  : {self.get_grade():<22} │")
        print(f"  └─────────────────────────────────┘")

# --- Using the Student class ---
print("\n--- Student Report Demo ---")
s1 = Student("Ali Khan", "CS-101")
s1.add_marks("Math",    85)
s1.add_marks("English", 78)
s1.add_marks("Science", 92)
s1.add_marks("Urdu",    88)
s1.print_report()

s2 = Student("Sara Ahmed", "CS-102")
s2.add_marks("Math",    62)
s2.add_marks("English", 71)
s2.add_marks("Science", 55)
s2.add_marks("Urdu",    48)
s2.print_report()


# ─────────────────────────────────────────────
# SECTION 19 — INHERITANCE
# ─────────────────────────────────────────────
# Inheritance = a new class AUTOMATICALLY GETS all the
# attributes and methods of an existing class.
# You can then ADD new things or CHANGE existing ones.
#
# Real-world analogy:
#   Think of a general category: VEHICLE
#   A CAR is a vehicle → it inherits everything a vehicle has,
#   but also has its own extra features (e.g. number of doors).
#   A MOTORCYCLE is also a vehicle → same base, different extras.
#
# Syntax:
#   class Child(Parent):
#       ...

# --- Base class (parent) ---
class Animal:

    def __init__(self, name, species, age):
        self.name    = name
        self.species = species
        self.age     = age

    def describe(self):
        print(f"{self.name} is a {self.species}, aged {self.age}.")

    def sleep(self):
        print(f"{self.name} is sleeping... Zzz")

# --- Child class: Dog INHERITS from Animal ---
class Dog(Animal):

    def __init__(self, name, age, breed):
        # Call the parent's __init__ first so name/species/age are set
        super().__init__(name, species="Dog", age=age)
        self.breed = breed          # extra attribute only Dogs have

    # Extra method only Dogs have
    def fetch(self):
        print(f"{self.name} fetches the ball! Good dog!")

    # OVERRIDE the parent's describe() with a better version for dogs
    def describe(self):
        print(f"{self.name} is a {self.breed} dog, aged {self.age}.")

# --- Child class: Cat INHERITS from Animal ---
class Cat(Animal):

    def __init__(self, name, age, indoor):
        super().__init__(name, species="Cat", age=age)
        self.indoor = indoor        # True if house cat, False if stray

    def purr(self):
        print(f"{self.name} purrs contentedly...")

    def describe(self):
        location = "indoor" if self.indoor else "outdoor"
        print(f"{self.name} is an {location} cat, aged {self.age}.")

# --- Using inherited classes ---
print("\n--- Animal Demo ---")
generic_animal = Animal("Parrot", "Bird", 5)
generic_animal.describe()
generic_animal.sleep()

print()
dog = Dog("Bruno", 3, "German Shepherd")
dog.describe()      # uses Dog's version of describe()
dog.sleep()         # inherited from Animal — Dog didn't redefine it
dog.fetch()         # Dog-only method

print()
cat = Cat("Whiskers", 2, indoor=True)
cat.describe()
cat.sleep()
cat.purr()


# ─────────────────────────────────────────────
# SECTION 20 — MINI PROJECT: School System
# ─────────────────────────────────────────────
# Brings together Classes, Inheritance, Loops, and Functions
# in one complete real-world program.

class SchoolMember:
    """Base class — any person in the school."""

    def __init__(self, name, age, school_id):
        self.name      = name
        self.age       = age
        self.school_id = school_id

    def get_info(self):
        return f"[{self.school_id}] {self.name} (Age: {self.age})"


class SchoolStudent(SchoolMember):
    """A student at the school — inherits from SchoolMember."""

    def __init__(self, name, age, school_id, grade_level):
        super().__init__(name, age, school_id)
        self.grade_level = grade_level
        self.subjects    = {}               # subject → mark

    def add_subject_mark(self, subject, mark):
        self.subjects[subject] = mark

    def average(self):
        if not self.subjects:
            return 0
        return round(sum(self.subjects.values()) / len(self.subjects), 1)

    def status(self):
        return "Pass" if self.average() >= 50 else "Fail"

    def get_info(self):
        base = super().get_info()
        return f"{base} | Grade {self.grade_level} | Avg: {self.average()} | {self.status()}"


class SchoolTeacher(SchoolMember):
    """A teacher at the school — inherits from SchoolMember."""

    def __init__(self, name, age, school_id, subject, salary):
        super().__init__(name, age, school_id)
        self.subject = subject
        self.salary  = salary

    def get_info(self):
        base = super().get_info()
        return f"{base} | Teaches: {self.subject} | Salary: Rs.{self.salary:,}"


# --- Build the school ---
print("\n" + "=" * 55)
print("             GREEN VALLEY SCHOOL SYSTEM")
print("=" * 55)

# Create students
st1 = SchoolStudent("Ali Khan",    16, "STU-001", grade_level=10)
st2 = SchoolStudent("Sara Ahmed",  15, "STU-002", grade_level=9)
st3 = SchoolStudent("Omar Farooq", 17, "STU-003", grade_level=11)

# Add their marks
st1.add_subject_mark("Math", 88); st1.add_subject_mark("English", 75); st1.add_subject_mark("Science", 91)
st2.add_subject_mark("Math", 62); st2.add_subject_mark("English", 80); st2.add_subject_mark("Science", 45)
st3.add_subject_mark("Math", 95); st3.add_subject_mark("English", 89); st3.add_subject_mark("Science", 78)

# Create teachers
t1 = SchoolTeacher("Mr. Rashid", 40, "TCH-001", "Mathematics", 75000)
t2 = SchoolTeacher("Ms. Amna",   35, "TCH-002", "English",     68000)

# Collect everyone
students = [st1, st2, st3]
teachers = [t1, t2]

# Print all teachers
print("\n--- TEACHERS ---")
for teacher in teachers:
    print(" ", teacher.get_info())

# Print all students
print("\n--- STUDENTS ---")
for student in students:
    print(" ", student.get_info())

# Find the top student using a loop
print("\n--- TOP STUDENT ---")
top = students[0]
for student in students:
    if student.average() > top.average():
        top = student
print(f"  {top.name} with an average of {top.average()}%")

# Count pass/fail
passed = [s for s in students if s.status() == "Pass"]
failed = [s for s in students if s.status() == "Fail"]
print(f"\n--- RESULTS ---")
print(f"  Passed: {len(passed)} student(s)")
print(f"  Failed: {len(failed)} student(s)")
if failed:
    print("  Needs support:", ", ".join(s.name for s in failed))

print("\n" + "=" * 55)
print("  End of School Report")
print("=" * 55)


# ============================================================
#   END OF CLASS 3
#   Practice Exercises (try on your own):
#
#   FUNCTIONS:
#   1. Write a function is_palindrome(word) that returns True
#      if the word reads the same forwards and backwards.
#      e.g. "madam" → True, "python" → False
#
#   2. Write a function that takes a list of prices and
#      returns the total, the most expensive, and the average.
#
#   LOOPS:
#   3. Print all prime numbers between 1 and 50.
#      Hint: a prime is only divisible by 1 and itself.
#
#   4. Ask the user to type words one at a time until they
#      type "stop". Store all words in a list and print them.
#
#   OOP:
#   5. Create a class called MobilePhone with:
#        Attributes: brand, model, battery (starts at 100)
#        Methods:    make_call(minutes) — reduces battery by minutes
#                    charge()           — resets battery to 100
#                    status()           — prints brand, model, battery %
#      Create two phones and test all the methods.
#
#   6. CHALLENGE: Create a class Library with a list of books.
#      Add methods to: add_book, remove_book, search_book,
#      and list_all_books.
# ============================================================