# my_first_code.py
print("Hello, GitHub from Python! 👋")

# Simple calculator
def add_numbers(a, b):
    """Add two numbers"""
    return a + b

def greet(name):
    """Greet a person"""
    return f"Hello, {name}! Welcome to Python programming."

# Main program
if __name__ == "__main__":
    print("=" * 40)
    print("My First Python Program")
    print("=" * 40)
    
    # Print greeting
    print(greet("Developer"))
    
    # Use the calculator
    num1 = 10
    num2 = 20
    result = add_numbers(num1, num2)
    print(f"\nCalculation: {num1} + {num2} = {result}")
    
    # Create a list
    fruits = ["Apple", "Banana", "Cherry", "Date"]
    print(f"\nMy favorite fruits: {fruits}")
    
    # Loop through list
    print("\nPrinting fruits:")
    for i, fruit in enumerate(fruits, 1):
        print(f"{i}. {fruit}")
    
    print("\n✨ Program completed successfully! ✨")


# 1. VARIABLES & DATA TYPES (Storage Boxes)
# Intergers (Whole Number)
age = 25

# Floats (Decimal Number)
price = 19.99

# Strings (Text)
name = "Afaq "

# Booleans (True/False)
is_student = True

# 2. CONTROL STRUCTURES (Decision Making)

# IF-ELSE (Road Bumps)
temperature = 30
if temperature > 25:
    print("Wear shorts")
else:
    print("Wear pants")

# FOR LOOP (Shopping List)
# Method 1: Going thriugh each item
fruits = ["Apple", "Banana", "Cherry"]
for fruit in fruits:
    print(f"I ate {fruit}")

# Method 2: Using index
for i in range(5):
    print("Hello, World!")