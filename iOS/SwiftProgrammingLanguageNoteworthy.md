# The Swift Programming Language Notes

- [The Basics](#the-basics)
- [Basic Operators](#basic-operators)

## The Basics

1. Unlike multiline comments in C, multiline comments in Swift can be nested inside other multiline comments. You write nested comments by starting a multiline comment block and then starting a second multiline comment within the first block. The second block is then closed, followed by the first block:

    ```Swift
    /* this is the start of the first multiline comment
    /* this is the second, nested multiline comment */
    this is the end of the first multiline comment */
    ```

2. About int

    ```Swift
    let cannotBeNegative: UInt8 = -1
    // UInt8 cannot store negative numbers, and so this will report an error
    let tooBig: Int8 = Int8.max + 1
    // Int8 cannot store a number larger than its maximum value,
    // and so this will also report an error
    ```

3. Swift’s type safety prevents non-Boolean values from being substituted for Bool. The following example reports a compile-time error:

    ```Swift
    let i = 1
    if i {
        // this example will not compile, and will report an error
    }
    ```

    However, the alternative example below is valid:

    ```Swift
    let i = 1
    if i == 1 {
        // this example will compile successfully
    }
    ```

4. `nil` cannot be used with non-optional constants and variables.

5. Swift’s nil is not the same as nil in Objective-C. In Objective-C, nil is a pointer to a non-existent object. In Swift, nil is not a pointer—it is the absence of a value of a certain type. Optionals of any type can be set to nil, not just object types.

6. Optional binding can be used with `if` and `while` statements to check for a value inside an optional, and to extract that value into a constant or variable, as part of a single action.

    ```Swift
    if let actualNumber = possibleNumber.toInt() {
        println("\(possibleNumber) has an integer value of \(actualNumber)")
    } else {
        println("\(possibleNumber) could not be converted to an integer")
    }
    // prints "123 has an integer value of 123"
    ```
    
    This can be read as:

    “If the optional `Int` returned by `possibleNumber.toInt` contains a value, set a new constant called `actualNumber`     to the value contained in the optional.”
    
7. Implicitly unwrapped optionals should not be used when there is a possibility of a variable becoming `nil` at a later point. Always use a normal optional type if you need to check for a `nil` value during the lifetime of a variable.    

    ```Swift
    let assumedString: String! = "An implicitly unwrapped optional string."
    if  assumedString {
        println(assumedString)
    }
    ```
## Basic Operators



