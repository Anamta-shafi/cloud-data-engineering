# ============================================================
#   CLASS 1 — HOMEWORK QUESTIONS
# ============================================================

# ─────────────────────────────────────────────
# QUESTION 1 — Variables & print()
# ─────────────────────────────────────────────

your_name = "Anamta Shafi"
your_age = 20
your_city = "Karachi"

print("My name is", your_name + ",", "I am", your_age,
      "years old and I live in", your_city + ".")


# ─────────────────────────────────────────────
# QUESTION 2 — Arithmetic Operations
# ─────────────────────────────────────────────

rice_bag = 350
cooking_oil = 480
sugar_bag = 120

total_cost = rice_bag + cooking_oil + sugar_bag
discount = total_cost * 0.10
final_price = total_cost - discount

print("Total Cost:", total_cost)
print("Discount:", discount)
print("Final Price:", final_price)


# ─────────────────────────────────────────────
# QUESTION 3 — Type Conversion & Input
# ─────────────────────────────────────────────

birth_year = int(input("Enter your birth year: "))
age = 2024 - birth_year

print("You are approximately", age, "years old.")


# ─────────────────────────────────────────────
# QUESTION 4 — if / elif / else
# ─────────────────────────────────────────────

temperature = int(input("Enter temperature in Celsius: "))

if temperature > 35:
    print("It's very hot! Wear light clothes.")
elif temperature >= 25:
    print("It's warm. A t-shirt is fine.")
elif temperature >= 15:
    print("It's a bit cool. Consider a jacket.")
else:
    print("It's cold! Wear a warm coat.")


# ─────────────────────────────────────────────
# QUESTION 5 — if / elif / else (Grade Calculator)
# ─────────────────────────────────────────────

marks = int(input("Enter marks out of 100: "))

if marks >= 90:
    print("Grade A (Excellent)")
elif marks >= 75:
    print("Grade B (Good)")
elif marks >= 60:
    print("Grade C (Average)")
elif marks >= 50:
    print("Grade D (Below Average)")
else:
    print("Grade F (Fail)")

if marks >= 50:
    print("Congratulations!")
else:
    print("Better luck next time.")


# ─────────────────────────────────────────────
# QUESTION 6 — for Loop
# ─────────────────────────────────────────────

number = int(input("Enter a number: "))

for i in range(1, 11):
    print(number, "x", i, "=", number * i)


# ─────────────────────────────────────────────
# QUESTION 7 — for Loop + List
# ─────────────────────────────────────────────

scores = [72, 88, 45, 95, 60, 53, 78, 91, 40, 85]

for score in scores:
    if score >= 50:
        print(score, "→ Pass")
    else:
        print(score, "→ Fail")


# ─────────────────────────────────────────────
# QUESTION 8 — while Loop
# ─────────────────────────────────────────────

secret_number = 7
tries = 0

guess = int(input("Guess the number: "))

while guess != secret_number:
    tries += 1

    if guess > secret_number:
        print("Too high! Try again.")
    else:
        print("Too low! Try again.")

    guess = int(input("Guess again: "))

tries += 1
print("Correct! You got it in", tries, "tries.")


# ─────────────────────────────────────────────
# QUESTION 9 — Functions
# ─────────────────────────────────────────────

def is_even(number):
    return number % 2 == 0


def celsius_to_fahrenheit(celsius):
    return (celsius * 9/5) + 32


num = int(input("Enter a number: "))

if is_even(num):
    print("The number is even.")
else:
    print("The number is odd.")

celsius = float(input("Enter temperature in Celsius: "))
fahrenheit = celsius_to_fahrenheit(celsius)

print("Temperature in Fahrenheit:", fahrenheit)


# ─────────────────────────────────────────────
# QUESTION 10 — Lists + Functions
# ─────────────────────────────────────────────

def analyse_scores(scores):

    highest = max(scores)
    lowest = min(scores)
    average = round(sum(scores) / len(scores), 2)

    passed = 0
    failed = 0

    for score in scores:
        if score >= 50:
            passed += 1
        else:
            failed += 1

    return {
        "highest": highest,
        "lowest": lowest,
        "average": average,
        "passed": passed,
        "failed": failed
    }


scores = [72, 88, 45, 95, 60, 53, 78, 91, 40, 85]

result = analyse_scores(scores)

print("Highest Score :", result["highest"])
print("Lowest Score  :", result["lowest"])
print("Average Score :", result["average"])
print("Passed        :", result["passed"])
print("Failed        :", result["failed"])

# ============================================================
# END OF HOMEWORK
# ============================================================