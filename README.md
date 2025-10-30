#  Flutter Calculator – Lab 2

**I have used VS code for doing this lab.**
 Please  also check my 'code attribution' part also, where i describe my original work and the references from outside sources.

A simple yet elegant **Calculator Application** built using **Flutter** as part of **Lab 2** for the *CSD228 – Mobile Web Development* course at **Sault College**.

This project performs **Addition, Subtraction, Multiplication, and Division**, and follows all specifications provided in the lab instructions.  
It features a clean UI, responsive layout, and persistent state using `SharedPreferences`.

** Typical Android phones: 360–420px

iPhones: 375–430px **

Our app is meant to run on web, tablet, or mobile, and this design respects that.

-----------------------------------------------------------------------------------------------------------------------
**Code Attribution**

The Flutter language is very new to us, so this was our first time learning it.

This project is primarily authored by me (Ekjot Kaur). 
However, certain small code snippets and logic references were adapted from official Flutter documentation and tutorials for educational purposes. 
Some of the references were mentioned on **brightspace** which we were enabled by the instructor, which i reviewed and followed the steps along.

These are some outside sources, that help me understand the logic :
Dart Language Tour: Syntax reference for operators and conditional logic (https://dart.dev/language)
Flutter Layout Examples : Helped understand layout widgets like Expanded, Row, Column, and GridView  (https://flutter.dev/docs/development/ui/layout)
Flutter Docs : Example usage of SharedPreferences for state persistence (https://docs.flutter.dev/cookbook/persistence/key-value)

**My Original Work:**

Entire calculator UI design and styling (button grid, colors, layout)

Arithmetic logic implementation (+, -, ×, ÷)

Error handling and number display logic

Responsive layout handling

Integration of SharedPreferences for saving the last result

README documentation and presentation formatting


----------------------------------------------------------------------------------------------------------------

##  Project Overview

The goal of this lab was to design and implement a basic calculator that:
- Resembles a **typical handheld calculator**
- Performs the four basic arithmetic operations
- Includes **CE (Clear Entry)** and **C (Clear All)** buttons
- Displays results clearly and handles up to 8 digits
- Maintains the **last state** of the calculator using persistent storage

---

##  Features Implemented

| Feature | Description |
|----------|-------------|
| Arithmetic Operations | Addition, Subtraction, Multiplication, and Division |
|  Digit Buttons | A 3×3 grid for digits (1–9) plus a row for 0, CE, and C |
|  State Management | Uses `SharedPreferences` to remember the last value |
|  Design | Neumorphic style buttons with shadows and rounded corners |
|  Responsive Layout | Works perfectly on **desktop**, **tablet**, and **mobile view** |
|  Error Handling | Handles invalid operations gracefully |
|  Logic Separation | Simple calculator logic inside a clean Flutter structure |

---------------------------------------------

*(The calculator automatically centers on screen and adjusts neatly on different device sizes.)*

---

##   (How to Run This Project?)

Follow these steps to run the project locally on your system:

###
- Clone the Repository
Open terminal and run:
```bash
git clone https://github.com/ekjotkaursault/flutter_calculator.git

- Navigate to the Project Folder:
cd flutter_calculator

-Install Dependencies:
flutter pub get

- Run the App on Web :
flutter run -d chrome

-----------------------------------------------------------------------------------------------

**⚙️ Project Structure**

flutter_calculator/
 ┣ lib/
 ┃ ┗ main.dart              # Main calculator UI and logic
 ┣ web/                     # Web build configuration
 ┣ android/                 # Android platform files
 ┣ ios/                     # iOS platform files
 ┣ windows/, macos/, linux/ # Desktop platform folders
 ┣ pubspec.yaml             # Flutter dependencies & project setup
 ┗ README.md                # Project documentation

**Technical Notes**

Framework: Flutter SDK

Language: Dart

Persistent Storage: SharedPreferences

Font Used: Poppins

UI Theme: Light, neumorphic style

Responsive Behavior: Fixed logical width (~360px), centered for all screens

------------------------------------------------------------------------------------------------------------------------------------

 Acknowledgment

This project was developed with guidance from Professor Stephen Perelgut.
Special thanks for his feedback and support throughout Lab 2.

------------------------------------------------------------------------------------------------------------------------------------

Author

Ekjot Kaur
GitHub: https://github.com/ekjotkaursault 







