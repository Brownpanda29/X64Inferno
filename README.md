# X64Inferno - Advanced Keylogger

## Introduction

X64Inferno is an advanced keylogger written in assembly language x86-64. This powerful tool is designed to silently record every keystroke made on an infected device, providing its operator with access to sensitive information.

## Author

- Name: Ethan Prime
- GitHub Username: brownpanda29

## How to Assemble and Compile

1. **Clone the Repository**:

    ```
    git clone https://github.com/brownpanda29/X64Inferno.git
    ```

2. **Navigate to the Source Code**:

    ```
    cd X64Inferno
    ```

3. **Assemble the X86-64 Code**:

    To assemble the code, you can use an assembler like NASM. Here's an example command:

    ```
    nasm -f elf64 x64inferno.asm -o x64inferno.o
    ```

4. **Compile into an Executable**:

    To compile the assembled code into an executable, you can use a linker like LD. Here's an example command:

    ```
    ld x64inferno.o -o x64inferno
    ```

5. **Run X64Inferno**:

    ```
    ./x64inferno
    ```

6. **Choose a Target**:

    Select a target and initiate the keylogging process.

## Disclaimer

X64Inferno is a tool created for specific purposes. Its use in real-life situations is illegal and unethical.

## License

This project is not associated with any specific license.

---
