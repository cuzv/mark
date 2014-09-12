# The Swift Programming Language Noteworthy

- [The Basics](#the-basics)
- [Basic Operators](#basic-operators)
- [Strings and Characters](#strings-and-characters)
- [Collection Types](#collection-types)
- [Control Flow](#control-flow)
- [Functions](#functions)

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

3. Swift’s type safety prevents non-Boolean values from being substituted for `Bool`. The following example reports a compile-time error:

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

5. Swift’s `nil` is not the same as `nil` in Objective-C. In Objective-C, `nil` is a pointer to a non-existent object. In Swift, `nil` is not a pointer—it is the absence of a value of a certain type. Optionals of any type can be set to `nil`, not just object types.

6. `Optional binding` can be used with `if` and `while` statements to check for a value inside an `optional`, and to extract that value into a constant or variable, as part of a single action.

    ```Swift
    if let actualNumber = possibleNumber.toInt() {
        println("\(possibleNumber) has an integer value of \(actualNumber)")
    } else {
        println("\(possibleNumber) could not be converted to an integer")
    }
    // prints "123 has an integer value of 123"
    ```
    
    This can be read as:

    “If the optional `Int` returned by `possibleNumber.toInt` contains a value, set a new constant called `actualNumber` to the value contained in the optional.”
    
7. `Implicitly unwrapped optionals` should not be used when there is a possibility of a variable becoming `nil` at a later point. Always use a normal optional type if you need to check for a `nil` value during the lifetime of a variable.    

    ```Swift
    let assumedString: String! = "An implicitly unwrapped optional string."
    if  assumedString {
        println(assumedString)
    }
    ```
    
## Basic Operators

1. Unlike the remainder operator in C and Objective-C, Swift’s remainder operator can also operate on floating-point numbers:

    ```Swift
    8 % 2.5   // equals 0.5
    ```

2. Swift also provides two identity operators (`===` and `!==`), which you use to test whether two object references both refer to the same object instance.

3. Nil Coalescing Operator

    ```Swift
    let defaultColorName = "red"
    var userDefinedColorName: String?   // defaults to nil
 
    var colorNameToUse = userDefinedColorName ?? defaultColorName
    // userDefinedColorName is nil, so colorNameToUse is set to the default of "red"
    ```
    
4. The closed range operator (`a...b`) defines a range that runs from a to b, and includes the values a and b. The value of a must not be greater than b. The half-open range operator (`a..<b`) defines a range that runs from a to b, but does not include b. It is said to be half-open because it contains its first value, but not its final value. As with the closed range operator, the value of a must not be greater than b.    

## Strings and Characters

1. Swift approach is different from string mutation in Objective-C and Cocoa, where you choose between two classes (`NSString` and `NSMutableString`) to indicate whether a string can be mutated.

    ```Swift
    var variableString = "Horse"
    variableString += " and carriage"
    // variableString is now "Horse and carriage"
 
    let constantString = "Highlander"
    constantString += " and another Highlander"
    // this reports a compile-time error - a constant string cannot be modified
    ```
    
2. Swift’s `String` type is a value type. If you create a new `String` value, that `String` value is copied when it is passed to a function or method, or when it is assigned to a constant or variable. In each case, a new copy of the existing String value is created, and the new copy is passed or assigned, not the original version.
    
    > This behavior differs from that of `NSString` in Cocoa. When you create an `NSString` instance in Cocoa, and pass it to a function or method or assign it to a variable, you are always passing or assigning a reference to the same      single `NSString`. No copying of the string takes place, unless you specifically request it.

    Behind the scenes, Swift’s compiler optimizes string usage so that actual copying takes place only when absolutely  necessary. This means you always get great performance when working with strings as value types
    
3. If you are working with particularly long string values, be aware that the `countElements` function must iterate over the Unicode scalars in the entire string in order to calculate an accurate character count for that string.

    Note also that the character count returned by `countElements` is not always the same as the `length` property of an `NSString` that contains the same characters. The length of an `NSString` is based on the number of 16-bit code units  within the string’s UTF-16 representation and not the number of Unicode extended grapheme clusters within the string. To reflect this fact, the `length` property from `NSString` is called `utf16Count` when it is accessed on a Swift String value.
    
4. String and character equality is checked with the “equal to” operator (`==`) and the “not equal to” operator (`!=`)

5. About unicode
    
    ```Swift
    let dogString = "Dog‼🐶"

    for codeUnit in dogString.utf8 {
        print("\(codeUnit) ")
    }
    // 68 111 103 226 128 188 240 159 144 182
    
    for codeUnit in dogString.utf16 {
        print("\(codeUnit) ")
    }
    // 68 111 103 8252 55357 56374
    
    for scalar in dogString.unicodeScalars {
        print("\(scalar.value) ")
    }
    // 68 111 103 8252 128054
    ```

## Collection Types

1. Swift arrays are specific about the kinds of values they can store. They differ from Objective-C’s `NSArray` and `NSMutableArray` classes, which can store any kind of object and do not provide any information about the nature of the objects they return. Swift arrays are type safe, and are always clear about what they may contain.

2. How to define an array

    ```Swift
    var normalArry: Array<Int> = [2, 3, 5]
    var shorthandArray:[Int] = [2, 4, 6] // this is preferred
    
    var shoppingList = ["Eggs", "Milk"]
    
    var someInts = [Int]()
    
    var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
    
    var anotherThreeDoubles = [Double](count: 3, repeatedValue: 2.5)
    // anotherThreeDoubles is inferred as [Double], and equals [2.5, 2.5, 2.5]
    var sixDoubles = threeDoubles + anotherThreeDoubles
    // sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
    ```
    
3. Iterating Over an Array

    ```Swift
    for item in shoppingList {
        println(item)
    }
    
    for (index, value) in enumerate(shoppingList) {
        println("Item \(index + 1): \(value)")
    }
    ```
4. You can create a new array by adding together two existing arrays of compatible type with the addition operator (`+`)

    ```Swift
    var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
    var anotherThreeDoubles = [Double](count: 3, repeatedValue: 2.5)
    var sixDoubles = threeDoubles + anotherThreeDoubles
    ```    
    
5. Swift dictionaries are specific about the types of keys and values they can store. They differ from Objective-C’s `NSDictionary` and `NSMutableDictionary` classes, which can use any kind of object as their keys and values and do not provide any information about the nature of those objects. In Swift, the type of keys and values that a particular dictionary can store is always made clear, either through an explicit type annotation or through type inference.

6. How to define a dictionary

    ```Swift
    var dictionary: Dictionary<String, String>
    var anotherDictionary: [String: String] // this is preferred
    ```
    
7. As an alternative to subscripting, use a dictionary’s `updateValue(forKey:)` method to set or update the value for a particular key. Unlike a subscript, however, the `updateValue(forKey:)` method returns the old value after performing an update. This enables you to check whether or not an update took place.

8. Creating an Empty Dictionary

    ```Swift
    var namesOfIntegers = [Int: String]()
    namesOfIntegers[16] = "sixteen"
    namesOfIntegers = [:]
    ```
9. You can use your own custom types as dictionary key types by making them conform to the `Hashable` protocol from Swift’s standard library. Types that conform to the Hashable protocol must provide a gettable Int property called `hashValue`, and must also provide an implementation of the “is equal” operator (`==`). The value returned by a type’s `hashValue` property is not required to be the same across different executions of the same program, or in different programs.

## Control Flow

1. Items in a `Dictionary` may not necessarily be iterated in the same order as they were inserted. The contents of a `Dictionary` are inherently unordered, and iterating over them does not guarantee the order in which they will be retrieved. 

2. In addition to arrays and dictionaries, you can also use the `for-in` loop to iterate over the `Character` values in a string

    ```Swift
    for character in "helloc" {
        println(character)
    }
    ```
3. the `if` statement has a single `if` condition. It executes a set of statements only if that condition is `true`

4. `switch` statements in Swift do not fall through the bottom of each case and into the next one by default. Instead, the entire `switch` statement finishes its execution as soon as the first matching `switch` case is completed, without requiring an explicit break statement. 

    The body of each case must contain at least one executable statement. It is not valid to write the following code, because the first case is empty:

    ```Swift
    let anotherCharacter: Character = "a"
    switch anotherCharacter {
    case "a":
    case "A":
        println("The letter A")
    default:
        println("Not the letter A")
    }
    // this will report a compile-time error
```

    Unlike a `switch` statement in C, this `switch` statement does not match both `"a"` and `"A"`. Rather, it reports a compile-time error that `case "a"`: does not contain any executable statements. This approach avoids accidental fallthrough from one case to another, and makes for safer code that is clearer in its intent.

    > To opt in to fallthrough behavior for a particular switch case, use the fallthrough keyword

5. Values in `switch` cases can be checked for their inclusion in a range.

6. A `switch` case can use a `where` clause to check for additional conditions.

    ```Swift
    let yetAnotherPoint = (1, -1)
    switch yetAnotherPoint {
    case let (x, y) where x == y:
        println("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y:
        println("(\(x), \(y)) is on the line x == -y")
    case let (x, y):
        println("(\(x), \(y)) is just some arbitrary point")
    }
    // prints "(1, -1) is on the line x == -y"
    ```
7. When used inside a `switch` statement, `break` causes the `switch` statement to end its execution immediately, and to transfer control to the first line of code after the `switch` statement’s closing brace (`}`).

8. Fallthrough

    ```Swift
    let integerToDescribe = 5
    var description = "The number \(integerToDescribe) is"
    switch integerToDescribe {
    case 2, 3, 5, 7, 11, 13, 17, 19:
        description += " a prime number, and also"
        fallthrough
    default:
        description += " an integer."
    }
    println(description)
    // prints "The number 5 is a prime number, and also an integer."
```
9. A labeled statement is indicated by placing a label on the same line as the statement’s introducer keyword, followed by a colon. Here’s an example of this syntax for a `while` loop, although the principle is the same for all loops and `switch` statements

    ```Swift
    <#labelName#>: while <#condition#> {
        <#statements#>
    }
    ```

## Functions

1. You can use a tuple type as the return type for a function to return multiple values as part of one compound return value.

    ```Swift
    func minMax(array: [Int]) -> (min: Int, max: Int) {
        var currentMin = array[0]
        var currentMax = array[0]
        
        for value in array[1 ..< array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        
        return (currentMin, currentMax)
    }
    
    func minAndMax(array: Array<Int>) -> (min: Int?, max: Int?) {
        var currentMin = array.first
        var currentMax = array.first
        
        for value in array[1 ..< array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        
        return (currentMin, currentMax)
    }
    
    let bounds = minMax([8, -6, 2, 109, 3, 71])
    println("min is \(bounds.min) and max is \(bounds.max)")
    ```
    
2. An optional tuple type such as `(Int, Int)?` is different from a tuple that contains optional types such as `(Int?, Int?)`. With an optional tuple type, the entire tuple is optional, not just each individual value within the tuple.

    ```Swift
    func minMax(array: [Int]) -> (min: Int, max: Int)? {
        if array.isEmpty { return nil }
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    ```
    
3. External Parameter Names

    ```Swift
    func someFunction(externalParameterName localParameterName: Int) {
        // function body goes here, and can use localParameterName
        // to refer to the argument value for that parameter
    }
    ```
    > If you provide an external parameter name for a parameter, that external name must always be used when you call the function.

4. You can define a default value for any parameter as part of a function’s definition. If a default value is defined, you can omit that parameter when calling the function.

    > Place parameters with default values at the end of a function’s parameter list. This ensures that all calls to the function use the same order for their non-default arguments, and makes it clear that the same function is being called in each case.

    ```Swift
    func join(string s1: String, toString s2: String,
        withJoiner joiner: String = " ") -> String {
            return s1 + joiner + s2
    }
    
    join(string: "hello", toString: "world", withJoiner: "-")
    join(string: "Hello", toString: "World")
    ```

5.  Swift provides an automatic external name for any parameter that has a default value. The automatic external name is the same as the local name, as if you had written a hash symbol before the local name in your code.

6. Variadic Parameters

    ```Swift
    func arithmeticMean(numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        
        return total
    }
    
    arithmeticMean(1, 2, 3, 4, 5)
    // returns 3.0, which is the arithmetic mean of these five numbers
    arithmeticMean(3, 8.25, 18.75)
    // returns 10.0, which is the arithmetic mean of these three numbers
    ```

    > A function may have at most one variadic parameter, and it must always appear last in the parameter list, to avoid ambiguity when calling the function with multiple parameters.

    > If your function has one or more parameters with a default value, and also has a variadic parameter, place the variadic parameter after all the defaulted parameters at the very end of the list.

7. Function parameters are constants by default. Define variable parameters by prefixing the parameter name with the keyword `var`

    ```Swift
    func alignRight(var string: String, count: Int, pad: Character) -> String {
        let amountToPad = count - countElements(string)
        if  amountToPad < 1 {
            return string
        }
       
        let padString = String(pad)
        for _ in 1...amountToPad {
            string = padString + string
        }
        
        return string
    }

    let originalString = "hello"
    let paddedString = alignRight(originalString, 10, "-")
    // paddedString is equal to "-----hello"
    // originalString is still equal to "hello"
    ```
    
8. Variable parameters, as described above, can only be changed within the function itself. If you want a function to modify a parameter’s value, and you want those changes to persist after the function call has ended, define that parameter as an *in-out parameter* instead.

    You write an in-out parameter by placing the inout keyword at the start of its parameter definition. An `in-out` parameter has a value that is passed in to the function, is modified by the function, and is passed back out of the function to replace the original value.

    You can only pass a variable as the argument for an in-out parameter. You cannot pass a constant or a literal value as the argument, because constants and literals cannot be modified. You place an ampersand (`&`) directly before a variable’s name when you pass it as an argument to an inout parameter, to indicate that it can be modified by the function.

    > `In-out` parameters cannot have default values, and variadic parameters cannot be marked as inout. If you mark a parameter as `inout`, it cannot also be marked as `var` or `let`.

    ```Swift
    func swapTwoInts(inout a: Int, inout b: Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    var a = 23, b = 108
    swap(&a, &b)
    a // 108
    b // 23
    ```

9. Every function has a specific *function type*, made up of the parameter types and the return type of the function.

    ```Swift
    func addTwoInts(a: Int, b: Int) -> Int {
        return a + b
    }
    func multiplyTwoInts(a: Int, b: Int) -> Int {
        return a * b
    }   
    ```
    
    The type of both of these functions is `(Int, Int) -> Int`. This can be read as:

    “A function type that has two parameters, both of type Int, and that returns a value of type Int.”

    ```Swift
    func printHelloWorld() {
        println("hello, world")
    }
    ```

    The type of this function is `() -> ()`, or “a function that has no parameters, and returns Void.” Functions that don’t specify a return value always return `Void`,  **which is equivalent to an empty tuple in Swift, shown as `()`**.

10. Function Types as Parameter Types

    ```Swift
        func addTwoInts(#anInt: Int, #anotherInt: Int ) -> Int {
        return anInt + anotherInt
    }
    
    func printMathResult(#mathFunction: (Int, Int) -> Int, #firstParameter: Int, #secondParameter: Int) {
        println("Result: \(mathFunction(firstParameter, secondParameter))")
    }
    
    printMathResult(mathFunction: addTwoInts, firstParameter: 3, secondParameter: 4)
    // "Result: 7"
    
    // closures
    printMathResult(mathFunction: { (a, b) -> Int in
        return a + b
        }, firstParameter: 3, secondParameter: 5)
    // "Result: 8"
    ```
    
11. Function Types as Return Types

    ```Swift
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
    
    func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
        return backwards ? stepBackward : stepForward
    }
    
    var currentValue = 3
    let moveNearerToZero = chooseStepFunction(currentValue > 0)
    
    println("Counting to zero:")
    
    while currentValue != 0 {
        println("\(currentValue)...")
        currentValue = moveNearerToZero(currentValue)
    }
    
    println(currentValue)
    // 3...
    // 2...
    // 1...
    // zero!
    ```
    
12. Nested Functions

    ```Swift
    func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
        func stepForward(input: Int) -> Int { return input + 1 }
        func stepBackward(input: Int) -> Int { return input - 1 }
        return backwards ? stepBackward : stepForward
    }
    var currentValue = -4
    let moveNearerToZero = chooseStepFunction(currentValue > 0)
    // moveNearerToZero now refers to the nested stepForward() function
    while currentValue != 0 {
        println("\(currentValue)... ")
        currentValue = moveNearerToZero(currentValue)
    }
    println("zero!")
    // -4...
    // -3...
    // -2...
    // -1...
    // zero!
    ```
    