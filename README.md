# Assembly and C Integration Laboratory

A comprehensive repository containing a collection of low-level routines written in **x86 and x64 Assembly (MASM)**, integrated with **C wrappers**. The repository serves as an extensive demonstration of direct processor and register operations, memory management, and hardware-level mathematical computations.



---

## Tech Stack
* **Languages:** Assembly (MASM x86/x64), C
* **Environment:** Visual Studio 2022
* **Architecture target:** x86 (32-bit) and x64 (64-bit)
* **Libraries:** `MSVCRT` (Standard C Library), `WinAPI` (System Calls)

---

## Project Structure
The solution consists of two isolated projects designed to demonstrate architecture-specific programming:

* **`asm_x_86`**: Focuses on 32-bit architecture. Implements procedures using standard general-purpose registers (`EAX`, `EBX`, `ECX`, `EDX`) and the **x87 FPU stack** for floating-point arithmetic.
* **`asm_x_64`**: Focuses on 64-bit architecture. Utilizes expanded 64-bit registers (`RAX`, `RBX`, etc.) and adheres to the **Microsoft x64 Calling Convention** (shadow space, register-based parameter passing).



---

## Core Implementations
The laboratory is divided into several procedural categories, ranging from fundamental bitwise logic to complex algorithmic processing.

### 1. Low-Level Mathematical Computations (x87 FPU)
Direct manipulation of the floating-point unit stack (`st(0)` - `st(7)`) to perform high-precision calculations without high-level abstractions.
* **Taylor Series:** Efficient calculation of $e^x$ using iterative expansion.
* **Quadratic Equation:** Implementation of the quadratic formula with discriminant ($\Delta$) validation.
* **Statistics:** Procedures for calculating **Variance**, **Harmonic Mean**, and **Weighted Average**.



### 2. Memory & Array Manipulation
* **Sorting Algorithms:** Custom implementation of array sorting logic via direct memory addressing and pointer arithmetic.
* **Search Operations:** Optimized **Min/Max** discovery in large datasets for both 32-bit and 64-bit integer arrays.
* **Data Transformation:** Array traversal to apply absolute value masks (`0x80000000`) and median calculations.

### 3. Bitwise & Logic Operations
* **128-bit Arithmetic:** Implementation of 128-bit shifts using chained `RCL`/`SHL` instructions across multiple registers.
* **Format Conversions:** Logic for converting between **Two's Complement (U2)**, **Sign-Magnitude**, and **Negative Binary**.
* **Endianness Management:** Swapping byte order (Big-Endian to Little-Endian) using manual logic without the `bswap` instruction.
* **XOR Logic:** Demonstrating variable swapping and equivalence checks using pure XOR gates.

### 4. Encoding & String Processing
* **Charset Converter:** A procedural converter from **Latin-2** to **Windows-1250** encoding.
* **Unicode Handling:** Processing **UTF-8** multi-byte sequences and validating/extracting **UTF-16** code points.
* **Custom I/O:** Hand-written routines for reading and displaying **Hexadecimal** and **Decimal** values via standard streams.

---

## Engineering Insights & Logic
The project demonstrates the critical importance of the **Calling Convention** and **Stack Frame Management**. In the 32-bit project, parameters are passed via the stack, whereas the 64-bit project utilizes `RCX`, `RDX`, `R8`, and `R9` for the first four arguments, requiring careful management of the **Shadow Space**.

---

## Installation & Usage (Visual Studio 2022)



1. **Clone the repository and open the solution file (.sln) in Visual Studio 2022.open the solution file (.sln) in Visual Studio 2022.**
    ```bash
   git clone https://github.com/Stereopapa/life-game-py.git
   cd life-game-py

2. Set the desired project (asm_x_86 or asm_x_64) as the Startup Project.

3. Select the corresponding build architecture (x86 or x64).

4. Open the target C wrapper file (main.c for 32-bit, main.c for 64-bit).

5. In the main() function block, uncomment the specific task procedure you wish to execute (e.g., variance_task();)

6. Build and run the solution.


**Note** For some procedures you need to set up breakpoints in task asm file and check registers in order to see results.
