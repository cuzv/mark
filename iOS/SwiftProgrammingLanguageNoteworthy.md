# The Swift Programming Language Noteworthy

- [The Basics](#the-basics)
- [Basic Operators](#basic-operators)
- [Strings and Characters](#strings-and-characters)
- [Collection Types](#collection-types)
- [Control Flow](#control-flow)
- [Functions](#functions)
- [Closures](#closures)
- [Enumerations](#enumerations)
- [Classes and Structures](#classes-and-structures)
- [Properties](#properties)
- [Methods](#methods)
- [Subscripts](#subscripts)
- [Inheritance](#inheritance)
- [Initialization](#initialization)
- [Deinitialization](#deinitialization)

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
    
## Closures

1. Closure Expression Syntax

    ```Swift
        { (<#parameters#>) -> <#return type#> in
            <#statements#>
        }
    ```

2. Inferring

    ```Swift
    reversed = sorted(names, { (s1: String, s2: String) -> Bool in return s1 > s2 } )
    reversed = sorted(names, { s1, s2 in return s1 > s2 } )
    ```
    Single-expression closures can implicitly return the result of their single expression by omitting the `return` keyword from their declaration, as in this version of the previous example:

    ```Swift
    reversed = sorted(names, { s1, s2 in s1 > s2 } )
    ```
    
    Swift automatically provides shorthand argument names to inline closures, which can be used to refer to the values of the closure’s arguments by the names `$0`, `$1`, `$2`, and so on.

    ```Swift
    reversed = sorted(names, { $0 > $1 } )
    ```
    There’s actually an even shorter way to write the closure expression above
    
    ```Swift
    reversed = sorted(names, >)
    ```

3. Trailing Closures

    ```Swift
    func someFunctionTahtTakesAClosure(closure: () -> ()) {
        // function body goes here
    }
    
    // here's how you call this function without using a trailing closure
    someFunctionTahtTakesAClosure { () -> () in
        // closure's body goes here
    }
    
    // here's how you call this function with a trailing closure instead
    someFunctionTahtTakesAClosure() {
    }
    
    // or like this
    someFunctionTahtTakesAClosure {
    }
    ```

    > If a closure expression is provided as the function’s only argument and you provide that expression as a trailing closure, you do not need to write a pair of parentheses` () `after the function’s name when you call the function.

    ```Swift
    let digitNames = [
        0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
        5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
    ]
    
    let numbers = [16, 58, 510]
    let strings = numbers.map {
        (var number) -> String in
        var output = ""
        while number > 0 {
            output = digitNames[number % 10]! + output
            number /= 10
        }
    
        return output
    }
    strings
    ```

4. Capturing Values

    A closure can capture constants and variables from the surrounding context in which it is defined. The closure can then refer to and modify the values of those constants and variables from within its body, even if the original scope that defined the constants and variables no longer exists.

    The simplest form of a closure in Swift is a nested function, written within the body of another function. A nested function can capture any of its outer function’s arguments and can also capture any constants and variables defined within the outer function.

    ```Swift
    func makeIncrementor(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        
        func incrementor() -> Int {
            runningTotal += amount
            return runningTotal
        }
        
        return incrementor
    }
    ```
    
    > Swift determines what should be captured by reference and what should be copied by value. You don’t need to annotate `amount` or `runningTotal` to say that they can be used within the nested `incrementor` function. Swift also handles all memory management involved in disposing of `runningTotal` when it is no longer needed by the `incrementor` function.

    ```Swift
    let incrementByTen = makeIncrementor(forIncrement: 10)
    incrementByTen() // 10
    incrementByTen() // 20
    
    let incrementBySeven = makeIncrementor(forIncrement: 7)
    incrementBySeven() // 7
    
    incrementByTen() // 30
    ```

    > If you assign a closure to a property of a class instance, and the closure captures that instance by referring to the instance or its members, you will create a strong reference cycle between the closure and the instance. Swift uses *capture lists* to break these strong reference cycles. 

5. Closures Are Reference Types
    
    In the example above, ` incrementBySeven` and `incrementByTen` are constants, but the closures these constants refer to are still able to increment the `runningTotal` variables that they have captured. This is because functions and closures are reference types.

    Whenever you assign a function or a closure to a constant or a variable, you are actually setting that constant or variable to be a reference to the function or closure. In the example above, it is the choice of closure that `incrementByTen` *refers* to that is constant, and not the contents of the closure itself.

## Enumerations

1. If you are familiar with C, you will know that C enumerations assign related names to a set of integer values. Enumerations in Swift are much more flexible, and do not have to provide a value for each member of the enumeration. If a value (known as a “raw” value) is provided for each enumeration member, the value can be a string, a character, or a value of any integer or floating-point type.

    Enumerations in Swift are first-class types in their own right. They adopt many features traditionally supported only by classes, such as computed properties to provide additional information about the enumeration’s current value, and instance methods to provide functionality related to the values the enumeration represents. Enumerations can also define initializers to provide an initial member value; can be extended to expand their functionality beyond their original implementation; and can conform to protocols to provide standard functionality.

2. Enumeration Syntax

    ```Swift
    enum CompassPoint {
        case North
        case South
        case East
        case West
    }
    ```

    The `case` keyword indicates that a new line of member values is about to be defined.

    > Unlike C and Objective-C, Swift enumeration members are not assigned a default integer value when they are created. In the `CompassPoint` example above, `North`, `South`, `East` and `West` do not implicitly equal `0`, `1`, `2` and `3`. Instead, the different enumeration members are fully-fledged values in their own right, with an explicitly-defined type of `CompassPoint`.

    Multiple member values can appear on a single line, separated by commas

    ```Swift
    enum Planet {
        case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
    }
    ```

3. Associated Values

    ```Swift
    enum Barcode {
        case UPCA(Int, Int, Int, Int)
        case QRCode(String)
    }
    
    var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
    productBarcode = .QRCode("ABCDEFGHIJKLMNOP")
    
    switch productBarcode {
    case let .UPCA(numberSystem, manufacturer, product, check):
        println("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
    case let .QRCode(productCode):
        println("QR code: \(productCode).")
    }
    // prints "QR code: ABCDEFGHIJKLMNOP."
    ```

4. Raw Values

    Raw values can be strings, characters, or any of the integer or floating-point number types. Each raw value must be unique within its enumeration declaration. When integers are used for raw values, they auto-increment if no value is specified for some of the enumeration members.

    ```Swift
    enum Planet: Int {
        case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
    }
    ```

    Access the raw value of an enumeration member with its `toRaw` method

    ```Swift
    let earthsOrder = Planett.Earth.toRaw()
    // earthsOrder is 3
    ```

    Use an enumeration’s fromRaw method to try to find an enumeration member with a particular raw value. This example identifies Uranus from its raw value of 7

    ```Swift
    let possiblePlant = Planett.fromRaw(7)
    // possiblePlanet is of type Planet? and equals Planet.Uranus
    ```

## Classes and Structures

1. Comparing Classes and Structures

    Classes and structures in Swift have many things in common. Both can:
    
    - Define properties to store values
    - Define methods to provide functionality
    - Define subscripts to provide access to their values using subscript syntax
    - Define initializers to set up their initial state
    - Be extended to expand their functionality beyond a default implementation
    - Conform to protocols to provide standard functionality of a certain kind

    Classes have additional capabilities that structures do not:

    - Inheritance enables one class to inherit the characteristics of another.
    - Type casting enables you to check and interpret the type of a class instance at runtime.
    - Deinitializers enable an instance of a class to free up any resources it has assigned.
    - Reference counting allows more than one reference to a class instance.

    > Structures are always copied when they are passed around in your code, and do not use reference counting.

2. Unlike Objective-C, Swift enables you to set sub-properties of a structure property directly.

3. All structures have an automatically-generated memberwise initializer, which you can use to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name:

    ```Swift
    struct Resolution {
        var width = 0
        var height = 0
    }
    
    let vga = Resolution(width: 640, height: 480)
    ```

    Unlike structures, class instances do not receive a default memberwise initializer

4. Structures and Enumerations Are Value Types

     A value type is a type whose value is copied when it is assigned to a variable or constant, or when it is passed to a function.

    **In fact, all of the basic types in Swift—integers, floating-point numbers, Booleans, strings, arrays and dictionaries—are value types, and are implemented as structures behind the scenes.**

    ```Swift
    let hd = Resolution(width: 1920, height: 1080)
    
    var cinema = hd
    
    cinema.width = 2048
    println("cinema is now \(cinema.width) pixels wide")
    // prints "cinema is now 2048 pixels wide"
    
    println("hd is still \(hd.width) pixels wide")
    // prints "hd is still 1920 pixels wide"
    ```
    The same behavior applies to enumerations

5. Classes Are Reference Types

    Unlike value types, *reference types* are *not copied* when they are assigned to a variable or constant, or when they are passed to a function. Rather than a copy, a reference to the same existing instance is used instead.

    ```Swift
    et tenEighty = VideoMode()
    tenEighty.resolution = hd
    tenEighty.interlaced = true
    tenEighty.name = "1080i"
    tenEighty.frameRate = 25.0
    
    let alsoTenEigthy = tenEighty
    alsoTenEigthy.frameRate = 30.0
    
    println("The frameReate property of tenEighty is now \(tenEighty.frameRate)")
    
    // prints "The frameRate property of tenEighty is now 30.0"
    ```

6. Identity Operators

    Because classes are reference types, it is possible for multiple constants and variables to refer to the same single instance of a class behind the scenes. 

    It can sometimes be useful to *find out if two constants or variables refer to exactly the same instance of a class*. To enable this, Swift provides two identity operators:

    - Identical to (`===`)
    - Not identical to (`!==`)

    Note that “identical to” (represented by three equals signs, or ===) does not mean the same thing as “equal to” (represented by two equals signs, or ==):

    - “Identical to” means that two constants or variables of class type refer to exactly the same class instance.
    - “Equal to” means that two instances are considered “equal” or “equivalent” in value, for some appropriate meaning of “equal”, as defined by the type’s designer.

7. Choosing Between Classes and Structures

    As a general guideline, consider creating a structure when one or more of these conditions apply:
    - The structure’s primary purpose is to encapsulate a few relatively simple data values.
    - It is reasonable to expect that the encapsulated values will be copied rather than referenced when you assign or pass around an instance of that structure.
    - Any properties stored by the structure are themselves value types, which would also be expected to be copied rather than referenced.
    - The structure does not need to inherit properties or behavior from another existing type.

    Examples of good candidates for structures include:

    - The size of a geometric shape, perhaps encapsulating a width property and a height property, both of type Double.
    - A way to refer to ranges within a series, perhaps encapsulating a start property and a length property, both of type Int.
    - A point in a 3D coordinate system, perhaps encapsulating x, y and z properties, each of type Double.

    In all other cases, define a class, and create instances of that class to be managed and passed by reference. In practice, this means that most custom data constructs should be classes, not structures.

8. Swift’s `String,` `Array`, and `Dictionary` types are implemented as structures. This means that strings, arrays, and dictionaries are copied when they are assigned to a new constant or variable, or when they are passed to a function or method.

    > The description above refers to the “copying” of strings, arrays, and dictionaries. The behavior you see in your code will always be as if a copy took place. However, Swift only performs an actual copy behind the scenes when it is absolutely necessary to do so. Swift manages all value copying to ensure optimal performance, and you should not avoid assignment to try to preempt this optimization.

## Properties

1. Computed properties are provided by classes, structures, and enumerations. Stored properties are provided only by classes and structures.

2. Property observers can be added to stored properties you define yourself, and also to properties that a subclass inherits(whether stored or computed)  from its superclass.

3. If you create an instance of a structure and assign that instance to a constant, you cannot modify the instance’s properties, even if they were declared as variable properties:

    ```Swift
    let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
    // this range represents integer values 0, 1, 2, and 3
    rangeOfFourItems.firstValue = 6
    // this will report an error, even though firstValue is a variable property
    ```

    This behavior is due to structures being value types. When an instance of a value type is marked as a constant, so are all of its properties.

4. You must always declare a lazy property(stored property) as a variable (with the `var` keyword), because its initial value might not be retrieved until after instance initialization completes. Constant properties must always have a value before initialization completes, and therefore cannot be declared as lazy.

5. Computed Properties

    ```Swift
    struct Rect {
        var origin = Point()
        var size = Size()
        var center: Point {
            get {
                let centerX = origin.x + (size.width / 2)
                let centerY = origin.y + (size.height / 2)
                return Point(x: centerX, y: centerY)
            }
    //        set(newCenter) {
    //            origin.x = newCenter.x - (size.width / 2)
    //            origin.y = newCenter.y - (size.height / 2)
    //        }
            set {
                origin.x = newValue.x - (size.width / 2)
                origin.y = newValue.y - (size.height / 2)
            }
        }
    }
    
    var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
    let initialSquareCenter = square.center
    square.center = Point(x: 15.0, y: 15.0)
    
    println("square.origin is now at (\(square.origin.x), \(square.origin.y))")
    ```

    A computed property with a getter but no setter is known as a read-only computed property. A read-only computed property always returns a value, and can be accessed through dot syntax, but cannot be set to a different value.

6. You don’t need to define property observers for non-overridden computed properties, because you can observe and respond to changes to their value from directly within the computed property’s setter.

    > `willSet` and `didSet` observers are not called when a property is first initialized. They are only called when the property’s value is set outside of an initialization context.

7. Type Property

    Instance properties are properties that belong to an instance of a particular type. Every time you create a new instance of that type, it has its own set of property values, separate from any other instance.

    You can also define properties that belong to the type itself, not to any one instance of that type. There will only ever be one copy of these properties, no matter how many instances of that type you create. These kinds of properties are called *type properties*.

    For value types (that is, structures and enumerations), you can define stored and computed type properties. For classes, you can define computed type properties only.

    > Unlike stored instance properties, you must always give stored type properties a default value. This is because the type itself does not have an initializer that can assign a value to a stored type property at initialization time.

    You define type properties for *value types* with the `static` keyword, and type properties for *class types* with the `class` keyword. The example below shows the syntax for stored and computed type properties

    ```Swift
    struct SomeStructure {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 1
        }
    }
    
    enum SomeEnumeration {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 1
        }
    }
    
    class SomeClass {
        class var computedTypeProperty: Int {
            return 1
        }
    }
    ```

## Methods

1. Methods are functions that are associated with a particular type. The fact that structures and enumerations can define methods in Swift is a major difference from C and Objective-C.

2. Local and External Parameter Names for Methods

    ```Swift
    class Counter {
        var count: Int = 0
        func incrementBy(amount: Int, numberOfTimes: Int) {
            count += amount * numberOfTimes
        }
    }
    ```
    
    This `incrementBy` method has two parameters—`amount` and `numberOfTimes`. By default, Swift treats amount as a local name only, but treats numberOfTimes as both a local and an external name.

    You can either add an explicit external name yourself, or you can prefix the first parameter’s name with a hash symbol to use the local name as an external name too.

    Conversely, if you do not want to provide an external name for the second or subsequent parameter of a method, override the default behavior by using an underscore character (`_`) as an explicit external parameter name for that parameter.

3. Structures and enumerations are value types. By default, the properties of a value type cannot be modified from within its instance methods. You can opt in to this behavior by placing the `mutating` keyword before the func keyword for that method

4. Mutating methods can assign an entirely new instance to the implicit `self` property

    ```Swift
    struct LevelTracker {
        static var highestUnlockedLevel = 1
        static func unlockLevel(level: Int) {
            if level > highestUnlockedLevel { highestUnlockedLevel = level }
        }
        
        static func levelIsUnlocked(levle: Int) -> Bool {
            return levle <= highestUnlockedLevel
        }
        
        var currentLevel = 1
        mutating func advanceToLevel(level: Int) -> Bool {
            if LevelTracker.levelIsUnlocked(level) {
                currentLevel = level
                return true
            }
            
            return false
        }
    }
    
    class Player {
        var tracker = LevelTracker()
        let playerName: String
        func completedLevel(level: Int) {
            LevelTracker.unlockLevel(level + 1)
            tracker.advanceToLevel(level + 1)
        }
        
        init(name: String) {
            playerName = name
        }
    }
    
    var player = Player(name: "Argyrios")
    player.completedLevel(1)
    println("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
    
    player = Player(name: "Beto")
    if player.tracker.advanceToLevel(6) {
        println("player is now on level 6")
    } else {
        println("level 6 has not yet been unlocked")
    }
    ```

    NOTE: `unlockLevel(Int)` will report error in xcode GM: `Execution was interrupted, reason:EXC_BAD_ACCESS(code=EXE_I386_GPFLT).`

5. dispatch_once generate a singleton

    ```Swift
    class SomeClass {
        class var sharedInstance : SomeClass {
            struct Static {
                static var onceToken : dispatch_once_t = 0
                static var instance : SomeClass?
            }
                
            dispatch_once(&Static.onceToken) {
                Static.instance = SomeClass()
            }
                
            return Static.instance!
        }
    }
    ```

## Subscripts

1. Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence.

    ```Swift
    struct TimesTable {
        let multiplier: Int
        subscript(index: Int) -> Int {
            return multiplier * index
        }
    }
    
    let thressTimesTable = TimesTable(multiplier: 3)
    thressTimesTable[6] // 18
    ```
2. Swift’s `Dictionary` type implements its key-value subscripting as a subscript that takes and receives an optional type. For the `numberOfLegs` dictionary above, the key-value subscript takes and returns a value of type `Int?`, or “optional int”. The `Dictionary` type uses an optional subscript type to model the fact that not every key will have a value, and to give a way to delete a value for a key by assigning a `nil` value for that key.

    ```Swift
    var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
    numberOfLegs["bird"] = 2
    ```

3. Subscript Options

    ```Swift
    struct Matrix {
        let rows: Int, columns: Int
        var grid: [Double]
        init(rows: Int, columns: Int) {
            self.rows = rows
            self.columns = columns
            grid = Array(count: rows * columns, repeatedValue: 0.0)
        }
        
        func indexIsValidForRow(row: Int, column: Int) -> Bool {
            return row >= 0 && row < rows && columns >= 0 && column < columns
        }
        
        subscript(row: Int, column: Int) -> Double {
            get {
                assert(indexIsValidForRow(row, column: column), "Index out of range")
                return grid[(row * columns) + column]
            }
            
            set {
                assert(indexIsValidForRow(row, column: column),
                "Index out of range")
                grid[(row * columns) + column] = newValue
            }
        }
    }
    
    var matrix = Matrix(rows: 2, columns: 2)
    matrix[0, 1] = 1.5
    matrix[1, 0] = 3.2
    ```

## Inheritance

1. Any class that does not inherit from another class is known as a base class.

    > Swift classes do not inherit from a universal base class. Classes you define without specifying a superclass automatically become base classes for you to build upon.

2. You can provide a custom getter (and setter, if appropriate) to override any inherited property, regardless of whether the inherited property is implemented as a stored or computed property at source.

    You can present an inherited read-only property as a read-write property by providing both a getter and a setter in your subclass property override. You cannot, however, present an inherited read-write property as a read-only property.

    > If you provide a setter as part of a property override, you must also provide a getter for that override. If you don’t want to modify the inherited property’s value within the overriding getter, you can simply pass through the inherited value by returning `super.someProperty` from the getter, where `someProperty` is the name of the property you are overriding

3. You can use property overriding to add property observers to an inherited property. This enables you to be notified when the value of an inherited property changes, regardless of how that property was originally implemented. 

    > You cannot add property observers to inherited constant stored properties or inherited read-only computed properties. The value of these properties cannot be set, and so it is not appropriate to provide a willSet or didSet implementation as part of an override.

    > Note also that you cannot provide both an overriding setter and an overriding property observer for the same property. If you want to observe changes to a property’s value, and you are already providing a custom setter for that property, you can simply observe any value changes from within the custom setter.

## Initialization

1. Unlike Objective-C initializers, Swift initializers do not return a value. Their primary role is to ensure that new instances of a type are correctly initialized before they are used for the first time.

2. When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any property observers.

3. If a property always takes the same initial value, provide a default value rather than setting a value within an initializer. The end result is the same, but the default value ties the property’s initialization more closely to its declaration. It makes for shorter, clearer initializers and enables you to infer the type of the property from its default value. The default value also makes it easier for you to take advantage of default initializers and initializer inheritance

4. The names and types of an initializer’s parameters play a particularly important role in identifying which initializer should be called. Because of this, Swift provides an automatic external name for every parameter in an initializer if you don’t provide an external name yourself. This automatic external name is the same as the local name, as if you had written a hash symbol before every initialization parameter.

5. Initializers can call other initializers to perform part of an instance’s initialization. This process, known as *initializer delegation*, avoids duplicating code across multiple initializers.

    The rules for how initializer delegation works, and for what forms of delegation are allowed, are different for value types and class types. Value types (structures and enumerations) do not support inheritance, and so their initializer delegation process is relatively simple, because they can only delegate to another initializer that they provide themselves. Classes, however, can inherit from other classes. This means that classes have additional responsibilities for ensuring that all stored properties they inherit are assigned a suitable value during initialization

    For value types, you use `self.init` to refer to other initializers from the same value type when writing your own custom initializers. You can only call `self.init` from within an initializer.

    **Note that if you define a custom initializer for a value type, you will no longer have access to the default initializer (or the memberwise initializer, if it is a structure) for that type**. This constraint prevents a situation in which additional essential setup provided in a more complex initializer is circumvented by someone accidentally using one of the automatic initializers instead.

6. Swift defines two kinds of initializers for class types to help ensure all stored properties receive an initial value. These are known as *designated initializers* and *convenience initializers*.

    *Designated initializers* are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.

    Every class must have at least one designated initializer. In some cases, this requirement is satisfied by inheriting one or more designated initializers from a superclass

    *Convenience initializers* are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values. You can also define a convenience initializer to create an instance of that class for a specific use case or input value type.

    Designated initializers for classes are written in the same way as simple initializers for value types:

    ```Swift
    init(<#parameters#>) {
        <#statements#>
    }
    ```
    
    Convenience initializers are written in the same style, but with the convenience modifier placed before the init keyword, separated by a space

    ```Swift
    convenience init(<#parameters#>) {
        <#statements#>
    }
    ```
    
    To simplify the relationships between designated and convenience initializers, Swift applies the following three rules for delegation calls between initializers:
    
    <a name="initializer-chaining"></a>

    1. A designated initializer must call a designated initializer from its immediate superclass.
    2. A convenience initializer must call another initializer from the same class.
    3. A convenience initializer must ultimately call a designated initializer.

    A simple way to remember this is:
    
    1. Designated initializers must always delegate up.
    2. Convenience initializers must always delegate across.

    InitializerChaining
        
    ![(InitializerChaining)](./SwiftProgrammingLanguageNoteworthy.img/InitializerChaining.png)

    InitializerChainingMoreComplex
    
    ![(InitializerChainingMoreComplex)](./SwiftProgrammingLanguageNoteworthy.img/InitializerChainingMoreComplex.png)

7. Two-Phase Initialization

    Class initialization in Swift is a two-phase process. In the first phase, each stored property is assigned an initial value by the class that introduced it. Once the initial state for every stored property has been determined, the second phase begins, and each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use.
    
    The use of a two-phase initialization process makes initialization safe, while still giving complete flexibility to each class in a class hierarchy. Two-phase initialization prevents property values from being accessed before they are initialized, and prevents property values from being set to a different value by another initializer unexpectedly.(not exactly understand what this paragraph meaning)

    > Swift’s two-phase initialization process is similar to initialization in Objective-C. The main difference is that during phase 1, Objective-C assigns zero or null values (such as `0` or `nil`) to every property. Swift’s initialization flow is more flexible in that it lets you set custom initial values, and can cope with types for which `0` or `nil` is not a valid default value.

    Swift’s compiler performs four helpful safety-checks to make sure that two-phase initialization is completed without error:

    1. A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer. 

        As mentioned above, the memory for an object is only considered fully initialized once the initial state of all of its stored properties is known. In order for this rule to be satisfied, a designated initializer must make sure that all its own properties are initialized before it hands off up the chain.

    2. A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization.

    3. A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class). If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer.

    4. An initializer cannot call any instance methods, read the values of any instance properties, or refer to self as a value **until after the first phase of initialization is complete**.

        The class instance is not fully valid until the first phase ends. Properties can only be accessed, and methods can only be called, once the class instance is known to be valid at the end of the first phase.

    Here’s how two-phase initialization plays out, based on the four safety checks above:
    
    **Phase 1**

    1. A designated or convenience initializer is called on a class.
    2. Memory for a new instance of that class is allocated. The memory is not yet initialized.
    3. A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
    4. The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
    5. This continues up the class inheritance chain until the top of the chain is reached.
    6. Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.

        ![phase](./SwiftProgrammingLanguageNoteworthy.img/phase1.png)

    **Phase 2**
    
    1. Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
    2. Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.

        ![phase](./SwiftProgrammingLanguageNoteworthy.img/phase2.png)

8. Unlike subclasses in Objective-C, Swift subclasses do not inherit their superclass initializers by default. Swift’s approach prevents a situation in which a simple initializer from a superclass is inherited by a more specialized subclass and is used to create a new instance of the subclass that is not fully or correctly initialized.

    When you write a subclass initializer that matches a superclass designated initializer, you are effectively providing an override of that designated initializer. Therefore, you must write the `override` modifier before the subclass’s initializer definition. This is true even if you are overriding an automatically provided default initializer

    As with an overridden property, method or subscript, the presence of the override modifier prompts Swift to check that the superclass has a matching designated initializer to be overridden, and validates that the parameters for your overriding initializer have been specified as intended.

    > You always write the `override` modifier when overriding a superclass designated initializer, even if your subclass’s implementation of the initializer is a convenience initializer. (This description is different from Swift beta version, now is v1.0)

    ```Swift
    // code by Moch
    class MyView: UIView {
        var someValue: Double
        init(frame: CGRect, someValue: Double) {
            self.someValue = someValue
            super.init(frame: frame)
        }
    
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override convenience init(frame: CGRect) {
            self.init(frame: frame, someValue: 10)
        }
    }
    ```

    Conversely, if you write a subclass initializer that matches a superclass convenience initializer, that superclass convenience initializer can never be called directly by your subclass, as per the rules described above in [Initializer Chaining](#initializer-chaining) . 


9. Automatic Initializer Inheritance

    As mentioned above, subclasses do not inherit their superclass initializers by default. However, superclass initializers are automatically inherited if certain conditions are met

    Rule1: If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers.

    Rule2: If your subclass provides an implementation of all of its superclass designated initializers—either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition—then it automatically inherits all of the superclass convenience initializers.

    These rules apply even if your subclass adds further convenience initializers.

10. If a stored property’s default value requires some customization or setup, you can use a closure or global function to provide a customized default value for that property. Whenever a new instance of the type that the property belongs to is initialized, the closure or function is called, and its return value is assigned as the property’s default value.

    ```Swift
         class SomeClass {
            let someProperty: SomeType = {
                // create a default value for someProperty inside this closure
                // someValue must be of the same type as SomeType
                return someValue
                }()
        }
    ```
    
    Note that the closure’s end curly brace is followed by an empty pair of parentheses. This tells Swift to execute the closure immediately. If you omit these parentheses, you are trying to assign the closure itself to the property, and not the return value of the closure.  

    > If you use a closure to initialize a property, remember that the rest of the instance has not yet been initialized at the point that the closure is executed. This means that you cannot access any other property values from within your closure, even if those properties have default values. You also cannot use the implicit `self` property, or call any of the instance’s methods.

## Deinitialization



