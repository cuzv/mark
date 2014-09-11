# The Swift Programming Language Noteworthy

- [The Basics](#the-basics)
- [Basic Operators](#basic-operators)
- [Strings and Characters](#strings-and-characters)
- [Collection Types](#collection-types)
- [Control Flow](#control-flow)

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
    
4. The closed range operator `(a...b)` defines a range that runs from a to b, and includes the values a and b. The value of a must not be greater than b. The half-open range operator `(a..<b)` defines a range that runs from a to b, but does not include b. It is said to be half-open because it contains its first value, but not its final value. As with the closed range operator, the value of a must not be greater than b.    

## Strings and Characters

1. Swift approach is different from string mutation in Objective-C and Cocoa, where you choose between two classes (NSString and NSMutableString) to indicate whether a string can be mutated.

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

    Note also that the character count returned by `countElements` is not always the same as the `length` property of an `NSString` that contains the same characters. The length of an `NSString` is based on the number of 16-bit code units  within the string’s UTF-16 representation and not the number of Unicode extended grapheme clusters within the           string. To reflect this fact, the `length` property from `NSString` is called `utf16Count` when it is accessed on a     Swift String value.
    
4. String and character equality is checked with the “equal to” operator `(==)` and the “not equal to” operator `(!=)`

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
4. You can create a new array by adding together two existing arrays of compatible type with the addition operator (+)

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
9. You can use your own custom types as dictionary key types by making them conform to the Hashable protocol from Swift’s standard library. Types that conform to the Hashable protocol must provide a gettable Int property called hashValue, and must also provide an implementation of the “is equal” operator (==). The value returned by a type’s hashValue property is not required to be the same across different executions of the same program, or in different programs.

## Control Flow

