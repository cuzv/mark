
[Source](http://hawstein.com/posts/make-thiner-tspl.html "Permalink to 把《The Swift Programming Language》读薄"): <http://hawstein.com/posts/make-thiner-tspl.html>

# 把《The Swift Programming Language》读薄

July 1, 2014

## 目录

1. [About Swift](#About)
2. [The Basics](#Basic)
3. [Basic Operators](#BasicOperator)
4. [Strings and Characters](#String)
5. [Collection Types](#Collection)
6. [Control Flow](#ControlFlow)
7. [Functions](#Function)
8. [Closures](#Closure)
9. [Enumerations](Enumeration)
10. [Classes and Structures](#Class)
11. [Properties](#Property)
12. [Methods](#Method)
13. [Subscripts](#Subscript)
14. [Inheritance](#Inheritance)
15. [Initialization](#Initialization)
16. [Deinitialization](#Deinitialization)
17. [Automatic Reference Counting](#ARC)
18. [Optional Chaining](#OptionalChaining)
19. [Type Casting](#TypeCasting)
20. [Nested Types](#NestedType)
21. [Extensions](#Extension)
22. [Protocols](#Protocol)
23. [Generics](#Generic)
24. [Advanced Operators](#AdvancedOperator)
25. [A Swift Tour](#Tour)

## About Swift
<a name="About"></a>

We simplified memory management with Automatic Reference Counting.

Swift provides seamless access to existing Cocoa frameworks and mix-and-match interoperability with Objective-C code.

## The Basics
<a name="Basic"></a>

let声明常量，var声明变量

You can access the minimum and maximum values of each integer type with its min and max properties.

虽然有UInt，但能用Int的时候就用Int。


    // 各种进制的字面量表示
    let decimalInteger = 17
    let binaryInteger = 0b10001       // 17 in binary notation
    let octalInteger = 0o21           // 17 in octal notation
    let hexadecimalInteger = 0x11     // 17 in hexadecimal notation

    // 更易于阅读的写法
    let paddedDouble = 000123.456
    let oneMillion = 1_000_000
    let justOverOneMillion = 1_000_000.000_000_1


Floating-point values are always truncated when used to initialize a new integer value in this way. This means that 4.75 becomes 4, and -3.9 becomes -3.


    // 定义类型别名 typealias
    typealias AudioSample = UInt16

    // optional binding，只有当yyy是optional的时候才可以这样用。optional的yyy非空时为真，将yyy中的值取出赋给xxx，空时（nil）为假；

    if let xxx = yyy {
         // do something
    } else {
         // do other thing
    }

    // decompose一个tuple时，对于不想使用的元素用'_'接收
    let http404Error = (404, "Not Found")
    let (justTheStatusCode, _) = http404Error
    println("The status code is \(justTheStatusCode)")
    // prints "The status code is 404

    let possibleNumber = "123"
    let convertedNumber = possibleNumber.toInt()
    // convertedNumber is inferred to be of type "Int?", or "optional Int"，因为toInt()可能会失败（比如"123a"）导致返回nil


You can use an if statement to find out whether an optional contains a value. If an optional does have a value, it evaluates to true; if it has no value at all, it evaluates to false.

Once you're sure that the optional does contain a value, you can access its underlying value by adding an exclamation mark (!) to the end of the optional's name. The exclamation mark effectively says, "I know that this optional definitely has a value; please use it." This is known as forced unwrapping of the optional's value。

If you define an optional constant or variable without providing a default value, the constant or variable is automatically set to nil for you.

## Basic Operators
<a name="BasicOperator"></a>

Unlike C, Swift lets you perform remainder (%) calculations on floating-point numbers.


    if x = y {
        // this is not valid, because x = y does not return a value
    }

    // Swift中的取模操作
    -9 % 4   // equals -1，理解成：-9 = (4 × -2) + -1


Swift also provides two identity operators (=== and !==), which you use to test whether two object references both refer to the same object instance


    // ？？？
    var arr1 = [1, 2, 3]
    var arr2 = arr1
    arr2[0] = 10;
    arr1     // [10, 2, 3]
    arr2     // [10, 2, 3]
    arr1 === arr2  // 修改arr2，arr1也跟着修改，所以应该是指向一个object，这里应该是true，但结果却是false


## String and Characters
<a name="String"></a>

Swift's String type is a value type. If you create a new String value, that String value is copied when it is passed to a function or method, or when it is assigned to a constant or variable.

String判断是否包含某前缀或后缀的方法：hasPrefix，hasSuffix

String怎么随机取其中一个字符？

## Collection Types
<a name="Collection"></a>


    // arr随着brr改变
    var arr = ["hello", "world"]
    var brr = arr
    brr[0] = "haw"
    brr     // ["haw", "world"]
    arr     // ["haw", "world"]


    // arr不随brr改变，说明brr原本与arr指向一块内存，以下操作后指向新的内存，并把数组中的元素值copy了一遍。
    // 长度发生变化时，Array会发生拷贝
    var arr = ["hello", "world"]
    var brr = arr
    brr[0..0] = ["haw"]
    brr     // ["haw", "hello", "world"]
    arr      //  ["hello", "world"]


    // arr不随brr改变，同上
    var arr = ["hello", "world"]
    var brr = arr
    brr.insert("haw", atIndex: 0)      // remove也一样

    brr     // ["haw", "hello", "world"]
    arr      //  ["hello", "world"]



    for (index, value) in enumerate(shoppingList) {
        println("Item \(index + 1): \(value)")
    }
    // Item 1: Six eggs
    // Item 2: Milk
    // Item 3: Flour
    // Item 4: Baking Powder
    // Item 5: Bananas



    var threeDoubles = Double[](count: 3, repeatedValue: 0.0)
    // threeDoubles is of type Double[], and equals [0.0, 0.0, 0.0]
    var anotherThreeDoubles = Array(count: 3, repeatedValue: 2.5)
    // anotherThreeDoubles is inferred as Double[], and equals [2.5, 2.5, 2.5]


The only restriction is that KeyType must be hashable—that is, it must provide a way to make itself uniquely representable. All of Swift's basic types (such as String, Int, Double, and Bool) are hashable by default, and all of these types can be used as the keys of a dictionary. Enumeration member values without associated values (as described in Enumerations) are also hashable by default.


    // 以下将字典airports中key为DUB的值更新为Dublin International，返回的是它原来的值
    if let oldValue = airports.updateValue("Dublin International", forKey: "DUB") {
        println("The old value for DUB was \(oldValue).")
    }
    // prints "The old value for DUB was Dublin.


You can also use subscript syntax to retrieve a value from the dictionary for a particular key. Because it is possible to request a key for which no value exists, a dictionary's subscript returns an optional value of the dictionary's value type.


    airports["APL"] = "Apple International"
    // "Apple International" is not the real airport for APL, so delete it
    airports["APL"] = nil
    // APL has now been removed from the dictionary

    if let removedValue = airports.removeValueForKey("DUB") {
        println("The removed airport's name is \(removedValue).")
    } else {
        println("The airports dictionary does not contain a value for DUB.")
    }
    // prints "The removed airport's name is Dublin International.

    //
    for airportCode in airports.keys {
        println("Airport code: \(airportCode)")
    }
    // Airport code: TYO
    // Airport code: LHR

    for airportName in airports.values {
        println("Airport name: \(airportName)")
    }
    // Airport name: Tokyo
    // Airport name: London Heathrow

    let airportCodes = Array(airports.keys)
    // airportCodes is ["TYO", "LHR"]

    let airportNames = Array(airports.values)
    // airportNames is ["Tokyo", "London Heathrow"]


Arrays and dictionaries store multiple values together in a single collection. If you create an array or a dictionary and assign it to a variable, the collection that is created will be mutable. This means that you can change (or mutate) the size of the collection after it is created by adding more items to the collection, or by removing existing items from the ones it already contains. Conversely, if you assign an array or a dictionary to a constant, that array or dictionary is immutable, and its size cannot be changed.

For dictionaries, immutability also means that you cannot replace the value for an existing key in the dictionary. An immutable dictionary's contents cannot be changed once they are set.

Immutability has a slightly different meaning for arrays, however. You are still not allowed to perform any action that has the potential to change the size of an immutable array, but you are allowed to set a new value for an existing index in the array. This enables Swift's Array type to provide optimal performance for array operations when the size of an array is fixed.

## Control Flow
<a name="ControlFlow"></a>

    let base = 3
    let power = 10
    var answer = 1
    for _ in 1...power {
        answer *= base
    }
    println("\(base) to the power of \(power) is \(answer)")
    // prints "3 to the power of 10 is 59049


switch中的case情况要穷尽所有的可能性，如果可以穷尽（比如case是enum类型的有限几个值）则可以不加default，否则一定要加default。case中可以使用区间，开闭都可以。


    let count = 3_000_000_000_000
    let countedThings = "stars in the Milky Way"
    var naturalCount: String
    switch count {
    case 0:
        naturalCount = "no"
    case 1...3:
        naturalCount = "a few"
    case 4...9:
        naturalCount = "several"
    case 10...99:
        naturalCount = "tens of"
    case 100...999:
        naturalCount = "hundreds of"
    case 1000...999_999:
        naturalCount = "thousands of"
    default:
        naturalCount = "millions and millions of"
    }
    println("There are \(naturalCount) \(countedThings).")
    // prints "There are millions and millions of stars in the Milky Way.


    let somePoint = (1, 1)
    switch somePoint {
    case (0, 0):
        println("(0, 0) is at the origin")
    case (_, 0):
        println("(\(somePoint.0), 0) is on the x-axis")
    case (0, _):
        println("(0, \(somePoint.1)) is on the y-axis")
    case (-2...2, -2...2):
        println("(\(somePoint.0), \(somePoint.1)) is inside the box")
    default:
        println("(\(somePoint.0), \(somePoint.1)) is outside of the box")
    }
    // prints "(1, 1) is inside the box


Unlike C, Swift allows multiple switch cases to consider the same value or values. In fact, the point (0, 0) could match all four of the cases in this example. However, if multiple matches are possible, the first matching case is always used. The point (0, 0) would match case (0, 0) first, and so all other matching cases would be ignored.


    switch anotherPoint {
    case (let x, 0):
        println("on the x-axis with an x value of \(x)")
    case (0, let y):
        println("on the y-axis with a y value of \(y)")
    case let (x, y):
        println("somewhere else at (\(x), \(y))")
    }
    // prints "on the x-axis with an x value


    let yetAnotherPoint = (1, -1)
    switch yetAnotherPoint {
    case let (x, y) where x == y:
        println("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y:
        println("(\(x), \(y)) is on the line x == -y")
    case let (x, y):
        println("(\(x), \(y)) is just some arbitrary point")
    }
    // prints "(1, -1) is on the line x == -y

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
    // prints "The number 5 is a prime number, and also an integer.


    gameLoop: while square != finalSquare {
        if ++diceRoll == 7 { diceRoll = 1 }
        switch square + diceRoll {
        case finalSquare:
            // diceRoll will move us to the final square, so the game is over
            break gameLoop
        case let newSquare where newSquare &gt; finalSquare:
            // diceRoll will move us beyond the final square, so roll again
            continue gameLoop
        default:
            // this is a valid move, so find out its effect
            square += diceRoll
            square += board[square]
        }
    }
    println("Game over!")


## Functions
<a name="Function"></a>

If you provide an external parameter name for a parameter, that external name must always be used when calling the function.


    func join(string s1: String, toString s2: String, withJoiner joiner: String)
        -&gt; String {
            return s1 + joiner + s2
    }
    join(string: "hello", toString: "world", withJoiner: ", ")
    // returns "hello, world"



    func containsCharacter(#string: String, #characterToFind: Character) -&gt; Bool {
        for character in string {
            if character == characterToFind {
                return true
            }
        }
        return false
    }

    let containsAVee = containsCharacter(string: "aardvark", characterToFind: "v")
    // containsAVee equals true, because "aardvark" contains a "v"



    func join(string s1: String, toString s2: String,
        withJoiner joiner: String = " ") -&gt; String {
            return s1 + joiner + s2
    }
    join(string: "hello", toString: "world", withJoiner: "-")
    // returns "hello-world"
    join(string: "hello", toString: "world")
    // returns "hello world"



    func join(s1: String, s2: String, joiner: String = " ") -&gt; String {
        return s1 + joiner + s2
    }
    join("hello", "world", joiner: "-")
    // returns "hello-world"  有默认值的参数，如果你没有使用外部参数名，Swift会自动提供一个和内部参数名一样的外部参数名



    func arithmeticMean(numbers: Double...) -&gt; Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    arithmeticMean(1, 2, 3, 4, 5)
    // returns 3.0, which is the arithmetic mean of these five numbers
    arithmeticMean(3, 8, 19)
    // returns 10.0, which is the arithmetic mean of these three numbers


A function may have at most one variadic parameter, and it must always appear last in the parameter list, to avoid ambiguity when calling the function with multiple parameters.

If your function has one or more parameters with a default value, and also has a variadic parameter, place the variadic parameter after all the defaulted parameters at the very end of the list.

形参默认是常量，如果要改变形参，需要用var显式声明为变量 // swift中有许多默认情况和主流（比如C\C++）语言都是相反的，它将更常见的情况设定为默认


    func alignRight(var string: String, count: Int, pad: Character) -&gt; String {
        let amountToPad = count - countElements(string)
        for _ in 1...amountToPad {
            string = pad + string
        }
        return string
    }
    let originalString = "hello"
    let paddedString = alignRight(originalString, 10, "-")
    // paddedString is equal to "-----hello"
    // originalString is still equal to "hello"


In-out parameters cannot have default values, and variadic parameters cannot be marked as inout. If you mark a parameter as inout, it cannot also be marked as var or let.


    func swapTwoInts(inout a: Int, inout b: Int) { // 类似于引用传参
        let temporaryA = a
        a = b
        b = temporaryA
    }

    var someInt = 3
    var anotherInt = 107
    swapTwoInts(&amp;someInt, &amp;anotherInt)
    println("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
    // prints "someInt is now 107, and anotherInt is now 3"


像定义常量或变量一样定义函数：


    var mathFunction: (Int, Int) -&gt; Int = addTwoInts
    println("Result: \(mathFunction(2, 3))")
    // prints "Result: 5"

    let anotherMathFunction = addTwoInts
    // anotherMathFunction is inferred to be of type (Int, Int) -&gt; Int



    func printMathResult(mathFunction: (Int, Int) -&gt; Int, a: Int, b: Int) {
        println("Result: \(mathFunction(a, b))")
    }
    printMathResult(addTwoInts, 3, 5)
    // prints "Result: 8"


Swift支持嵌套函数：


    func chooseStepFunction(backwards: Bool) -&gt; (Int) -&gt; Int {
        func stepForward(input: Int) -&gt; Int { return input + 1 }
        func stepBackward(input: Int) -&gt; Int { return input - 1 }
        return backwards ? stepBackward : stepForward
    }
    var currentValue = -4
    let moveNearerToZero = chooseStepFunction(currentValue &gt; 0)
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


## Closures
<a name="Closures"></a>

Global and nested functions, as introduced in Functions, are actually special cases of closures. Closures take one of three forms:

* Global functions are closures that have a name and do not capture any values.
* Nested functions are closures that have a name and can capture values from their enclosing function.
* Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.

Closure expression syntax has the following general form:


    { (parameters) -&gt; return type in
        statements
    }



    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    func backwards(s1: String, s2: String) -&gt; Bool {
        return s1 &gt; s2
    }
    // 方法1
    var reversed = sort(names, backwards)
    // reversed is equal to ["Ewa", "Daniella", "Chris", "Barry", "Alex"]

    // 1.5
    reversed = sort(names, { (s1: String, s2: String) -&gt; Bool in return s1 &gt; s2 } )

    // 方法2
    reversed = sort(names, { s1, s2 in return s1 &gt; s2 } )

    // 方法3
    reversed = sort(names, { s1, s2 in s1 &gt; s2 } ) // Implicit Returns from Single-Expression Closures

    // 方法4
    reversed = sort(names, { $0 &gt; $1 } )

    // 方法5
    reversed = sort(names, &gt;)

    // 方法6
    reversed = sort(names) { $0 &gt; $1 }


It is always possible to infer parameter types and return type when passing a closure to a function as an inline closure expression. As a result, you rarely need to write an inline closure in its fullest form.


    func someFunctionThatTakesAClosure(closure: () -&gt; ()) {
        // function body goes here
    }

    // here's how you call this function without using a trailing closure:

    someFunctionThatTakesAClosure({
        // closure's body goes here
        })

    // here's how you call this function with a trailing closure instead:

    someFunctionThatTakesAClosure() {
        // trailing closure's body goes here
    }


If a closure expression is provided as the function's only argument and you provide that expression as a trailing closure, you do not need to write a pair of parentheses () after the function's name when you call the function.


    let digitNames = [
        0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
        5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
    ]
    let numbers = [16, 58, 510]
    let strings = numbers.map {
        (var number) -&gt; String in
        var output = ""
        while number &gt; 0 {
            output = digitNames[number % 10]! + output
            number /= 10
        }
        return output
    }
    // strings is inferred to be of type String[]
    // its value is ["OneSix", "FiveEight", "FiveOneZero"]



    func makeIncrementor(forIncrement amount: Int) -&gt; () -&gt; Int {
        var runningTotal = 0
        func incrementor() -&gt; Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementor
    }

    let incrementByTen = makeIncrementor(forIncrement: 10)
    incrementByTen()
    // returns a value of 10
    incrementByTen()
    // returns a value of 20
    incrementByTen()
    // returns a value of 30

    let incrementBySeven = makeIncrementor(forIncrement: 7)
    incrementBySeven()
    // returns a value of 7
    incrementByTen()
    // returns a value of 40

    let alsoIncrementByTen = incrementByTen
    alsoIncrementByTen()
    // returns a value of 50


functions and closures are reference types.

## Enumerations
<a name="Enumeration"></a>


    enum CompassPoint {
        case North
        case South
        case East
        case West
    }

    enum Planet {
        case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
    }

    var directionToHead = CompassPoint.West
    directionToHead = .East

    directionToHead = .South
    switch directionToHead {
    case .North:
        println("Lots of planets have a north")
    case .South:
        println("Watch out for penguins")
    case .East:
        println("Where the sun rises")
    case .West:
        println("Where the skies are blue")
    }
    // prints "Watch out for penguins"



    let somePlanet = Planet.Earth
    switch somePlanet {
    case .Earth:
        println("Mostly harmless")
    default:
        println("Not a safe place for humans")
    }
    // prints "Mostly harmless"



    enum Barcode {
        case UPCA(Int, Int, Int)
        case QRCode(String)
    }

    var productBarcode = Barcode.UPCA(8, 85909_51226, 3)
    productBarcode = .QRCode("ABCDEFGHIJKLMNOP")

    switch productBarcode {
    case .UPCA(let numberSystem, let identifier, let check):
        println("UPC-A with value of \(numberSystem), \(identifier), \(check).")
    case .QRCode(let productCode):
        println("QR code with value of \(productCode).")
    }
    // prints "QR code with value of ABCDEFGHIJKLMNOP."

    switch productBarcode {
    case let .UPCA(numberSystem, identifier, check):
        println("UPC-A with value of \(numberSystem), \(identifier), \(check).")
    case let .QRCode(productCode):
        println("QR code with value of \(productCode).")
    }
    // prints "QR code with value of ABCDEFGHIJKLMNOP."



    // raw values
    enum ASCIIControlCharacter: Character {
        case Tab = "	"
        case LineFeed = "
    "
        case CarriageReturn = "
"
    }

    enum Planet: Int {
        case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
    }

    let earthsOrder = Planet.Earth.toRaw()
    // earthsOrder is 3

    let possiblePlanet = Planet.fromRaw(7)
    // possiblePlanet is of type Planet? and equals Planet.Uranus

    let positionToFind = 9
    if let somePlanet = Planet.fromRaw(positionToFind) {
        switch somePlanet {
        case .Earth:
            println("Mostly harmless")
        default:
            println("Not a safe place for humans")
        }
    } else {
        println("There isn't a planet at position \(positionToFind)")
    }
    // prints "There isn't a planet at position 9"


## Classes and Structures
<a name="Class"></a>

Classes have additional capabilities that structures do not:

Inheritance enables one class to inherit the characteristics of another. Type casting enables you to check and interpret the type of a class instance at runtime. Deinitializers enable an instance of a class to free up any resources it has assigned. Reference counting allows more than one reference to a class instance.

Structures are always copied when they are passed around in your code, and do not use reference counting.


    if tenEighty === alsoTenEighty {
        println("tenEighty and alsoTenEighty refer to the same Resolution instance.")
    }
    // prints "tenEighty and alsoTenEighty refer to the same Resolution instance."


Whenever you assign a Dictionary instance to a constant or variable, or pass a Dictionary instance as an argument to a function or method call, the dictionary is copied at the point that the assignment or call takes place.


    var ages = ["Peter": 23, "Wei": 35, "Anish": 65, "Katya": 19]
    var copiedAges = ages
    copiedAges["Peter"] = 24
    println(ages["Peter"])
    // prints "23"


If you assign an Array instance to a constant or variable, or pass an Array instance as an argument to a function or method call, the contents of the array are not copied at the point that the assignment or call takes place. Instead, both arrays share the same sequence of element values. When you modify an element value through one array, the result is observable through the other.

For arrays, copying only takes place when you perform an action that has the potential to modify the length of the array. This includes appending, inserting, or removing items, or using a ranged subscript to replace a range of items in the array.


    var a = [1, 2, 3]
    var b = a
    var c = a

    println(a[0])
    // 1
    println(b[0])
    // 1
    println(c[0])
    // 1

    a[0] = 42
    println(a[0])
    // 42
    println(b[0])
    // 42
    println(c[0])
    // 42

    a.append(4)
    a[0] = 777
    println(a[0])
    // 777
    println(b[0])
    // 42
    println(c[0])
    // 42

    b.unshare()

    b[0] = -105
    println(a[0])
    // 777
    println(b[0])
    // -105
    println(c[0])
    // 42

    if b === c {
        println("b and c still share the same array elements.")
    } else {
        println("b and c now refer to two independent sets of array elements.")
    }
    // prints "b and c now refer to two independent sets of array elements."



    var names = ["Mohsen", "Hilary", "Justyn", "Amy", "Rich", "Graham", "Vic"]
    var copiedNames = names.copy()
    copiedNames[0] = "Mo"
    println(names[0])
    // prints "Mohsen"


If you simply need to be sure that your reference to an array's contents is the only reference in existence, call the unshare method, not the copy method. The unshare method does not make a copy of the array unless it is necessary to do so. The copy method always copies the array, even if it is already unshared.

## Properties
<a name="Property"></a>

Computed properties are provided by classes, structures, and enumerations. Stored properties are provided only by classes and structures.


    let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
    // this range represents integer values 0, 1, 2, and 3
    rangeOfFourItems.firstValue = 6
    // this will report an error, even thought firstValue is a variable property


Because rangeOfFourItems is declared as a constant (with the let keyword), it is not possible to change its firstValue property, even though firstValue is a variable property.

This behavior is due to structures being value types. When an instance of a value type is marked as a constant, so are all of its properties.

The same is not true for classes, which are reference types. If you assign an instance of a reference type to a constant, you can still change that instance's variable properties.


    class DataImporter {
        /*
        DataImporter is a class to import data from an external file.
        The class is assumed to take a non-trivial amount of time to initialize.
        */
        var fileName = "data.txt"
        // the DataImporter class would provide data importing functionality here
    }

    class DataManager {
        @lazy var importer = DataImporter()
        var data = String[]()
        // the DataManager class would provide data management functionality here
    }

    let manager = DataManager()
    manager.data += "Some data"
    manager.data += "Some more data"
    // the DataImporter instance for the importer property has not yet been created

    println(manager.importer.fileName)
    // the DataImporter instance for the importer property has now been created
    // prints "data.txt"


In addition to stored properties, classes, structures, and enumerations can define computed properties, which do not actually store a value. Instead, they provide a getter and an optional setter to retrieve and set other properties and values indirectly.


    struct Point {
        var x = 0.0, y = 0.0
    }
    struct Size {
        var width = 0.0, height = 0.0
    }
    struct Rect {
        var origin = Point()
        var size = Size()
        var center: Point { // center是computed property
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
        }
    }
    var square = Rect(origin: Point(x: 0.0, y: 0.0),
        size: Size(width: 10.0, height: 10.0))
    let initialSquareCenter = square.center
    square.center = Point(x: 15.0, y: 15.0)
    println("square.origin is now at (\(square.origin.x), \(square.origin.y))")
    // prints "square.origin is now at (10.0, 10.0)"


You must declare computed properties—including read-only computed properties—as variable properties with the var keyword, because their value is not fixed.


    struct Cuboid {
        var width = 0.0, height = 0.0, depth = 0.0
        var volume: Double {
        return width * height * depth
        }
    }
    let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
    println("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
    // prints "the volume of fourByFiveByTwo is 40.0"


willSet and didSet observers are not called when a property is first initialized. They are only called when the property's value is set outside of an initialization context.


    class StepCounter {
        var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            println("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps &gt; oldValue  {
                println("Added \(totalSteps - oldValue) steps")
            }
        }
        }
    }
    let stepCounter = StepCounter()
    stepCounter.totalSteps = 200
    // About to set totalSteps to 200
    // Added 200 steps
    stepCounter.totalSteps = 360
    // About to set totalSteps to 360
    // Added 160 steps
    stepCounter.totalSteps = 896
    // About to set totalSteps to 896
    // Added 536 steps


If you assign a value to a property within its own didSet observer, the new value that you assign will replace the one that was just set.

Global constants and variables are always computed lazily, in a similar manner to Lazy Stored Properties. Unlike lazy stored properties, global constants and variables do not need to be marked with the @lazy attribute. Local constants and variables are never computed lazily.

For value types (that is, structures and enumerations), you can define stored and computed type properties. For classes, you can define computed type properties only.

Unlike stored instance properties, you must always give stored type properties a default value. This is because the type itself does not have an initializer that can assign a value to a stored type property at initialization time.


    struct SomeStructure {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
        // return an Int value here
        }
    }
    enum SomeEnumeration {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
        // return an Int value here
        }
    }
    class SomeClass {
        class var computedTypeProperty: Int {
        // return an Int value here
        }
    }

    println(SomeClass.computedTypeProperty)
    // prints "42"

    println(SomeStructure.storedTypeProperty)
    // prints "Some value."
    SomeStructure.storedTypeProperty = "Another value."
    println(SomeStructure.storedTypeProperty)
    // prints "Another value."



    struct AudioChannel {
        static let thresholdLevel = 10
        static var maxInputLevelForAllChannels = 0
        var currentLevel: Int = 0 {
        didSet {
            if currentLevel &gt; AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel &gt; AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
        }
    }

    var leftChannel = AudioChannel()
    var rightChannel = AudioChannel()

    leftChannel.currentLevel = 7
    println(leftChannel.currentLevel)
    // prints "7"
    println(AudioChannel.maxInputLevelForAllChannels)
    // prints "7"

    rightChannel.currentLevel = 11
    println(rightChannel.currentLevel)
    // prints "10"
    println(AudioChannel.maxInputLevelForAllChannels)
    // prints "10"


## Methods
<a name="Method"></a>

Structures and enumerations are value types. By default, the properties of a value type cannot be modified from within its instance methods.


    struct Point {
        var x = 0.0, y = 0.0
        mutating func moveByX(deltaX: Double, y deltaY: Double) {
            x += deltaX
            y += deltaY
        }
    }
    var somePoint = Point(x: 1.0, y: 1.0)
    somePoint.moveByX(2.0, y: 3.0)
    println("The point is now at (\(somePoint.x), \(somePoint.y))")
    // prints "The point is now at (3.0, 4.0)"



    let fixedPoint = Point(x: 3.0, y: 3.0)
    fixedPoint.moveByX(2.0, y: 3.0)
    // this will report an error



    enum TriStateSwitch {
        case Off, Low, High
        mutating func next() {
            switch self {
            case Off:
                self = Low
            case Low:
                self = High
            case High:
                self = Off
            }
        }
    }
    var ovenLight = TriStateSwitch.Low
    ovenLight.next()
    // ovenLight is now equal to .High
    ovenLight.next()
    // ovenLight is now equal to .Off



    struct LevelTracker {
        static var highestUnlockedLevel = 1
        static func unlockLevel(level: Int) {
            if level &gt; highestUnlockedLevel { highestUnlockedLevel = level }
        }
        static func levelIsUnlocked(level: Int) -&gt; Bool {
            return level  Bool {
            if LevelTracker.levelIsUnlocked(level) {
                currentLevel = level
                return true
            } else {
                return false
            }
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
    // prints "highest unlocked level is now 2"

    player = Player(name: "Beto")
    if player.tracker.advanceToLevel(6) {
        println("player is now on level 6")
    } else {
        println("level 6 has not yet been unlocked")
    }
    // prints "level 6 has not yet been unlocked"


## Subscripts
<a name="Subscript"></a>

    subscript(index: Int) -&gt; Int {
        get {
            // return an appropriate subscript value here
        }
        set(newValue) {
            // perform a suitable setting action here
        }
    }

    // read-only subscript
    subscript(index: Int) -&gt; Int {
        // return an appropriate subscript value here
    }

    struct TimesTable {
        let multiplier: Int
        subscript(index: Int) -&gt; Int {
            return multiplier * index
        }
    }
    let threeTimesTable = TimesTable(multiplier: 3)
    println("six times three is \(threeTimesTable[6])")
    // prints "six times three is 18"



    struct Matrix {
        let rows: Int, columns: Int
        var grid: Double[]
        init(rows: Int, columns: Int) {
            self.rows = rows
            self.columns = columns
            grid = Array(count: rows * columns, repeatedValue: 0.0)
        }
        func indexIsValidForRow(row: Int, column: Int) -&gt; Bool {
            return row &gt;= 0 &amp;&amp; row &lt; rows &amp;&amp; column &gt;= 0 &amp;&amp; column &lt; columns
        }
        subscript(row: Int, column: Int) -&gt; Double {
            get {
                assert(indexIsValidForRow(row, column: column), "Index out of range")
                return grid[(row * columns) + column]
            }
            set {
                assert(indexIsValidForRow(row, column: column), "Index out of range")
                grid[(row * columns) + column] = newValue
            }
        }
    }

    var matrix = Matrix(rows: 2, columns: 2)
    matrix[0, 1] = 1.5
    matrix[1, 0] = 3.2

    let someValue = matrix[2, 2]
    // this triggers an assert, because [2, 2] is outside of the matrix bounds


## Inheritance
<a name="Inheritance"></a>

Swift classes do not inherit from a universal base class. Classes you define without specifying a superclass automatically become base classes for you to build upon.


    class Car: Vehicle {
        var speed: Double = 0.0
        init() {
            super.init()
            maxPassengers = 5
            numberOfWheels = 4
        }
        override func description() -&gt; String {
            return super.description() + "; "
                + "traveling at \(speed) mph"
        }
    }


You can present an inherited read-only property as a read-write property by providing both a getter and a setter in your subclass property override. You cannot, however, present an inherited read-write property as a read-only property.

You can prevent a method, property, or subscript from being overridden by marking it as final

## Initialization
<a name="Initialization"></a>

Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties cannot be left in an indeterminate state.

Swift provides an automatic external name for every parameter in an initializer if you don't provide an external name yourself. This automatic external name is the same as the local name, as if you had written a hash symbol before every initialization parameter.

If you do not want to provide an external name for a parameter in an initializer, provide an underscore (_) as an explicit external name for that parameter to override the default behavior described above.


    struct Color {
        let red = 0.0, green = 0.0, blue = 0.0
        init(red: Double, green: Double, blue: Double) {
            self.red   = red
            self.green = green
            self.blue  = blue
        }
    }

    let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)

    let veryGreen = Color(0.0, 1.0, 0.0)
    // this reports a compile-time error - external names are required


You can modify the value of a constant property at any point during initialization, as long as it is set to a definite value by the time initialization finishes.


    class SurveyQuestion {
        let text: String
        var response: String?
        init(text: String) {
            self.text = text
        }
        func ask() {
            println(text)
        }
    }
    let beetsQuestion = SurveyQuestion(text: "How about beets?")
    beetsQuestion.ask()
    // prints "How about beets?"
    beetsQuestion.response = "I also like beets. (But not with cheese.)"


structure types automatically receive a memberwise initializer if they provide default values for all of their stored properties and do not define any of their own custom initializers.


    struct Size {
        var width = 0.0, height = 0.0
    }
    let twoByTwo = Size(width: 2.0, height: 2.0)


If you want your custom value type to be initializable with the default initializer and memberwise initializer, and also with your own custom initializers, write your custom initializers in an extension rather than as part of the value type's original implementation.

Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.

Convenience initializers are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer's parameters set to default values. You can also define a convenience initializer to create an instance of that class for a specific use case or input value type.

To simplify the relationships between designated and convenience initializers, Swift applies the following three rules for delegation calls between initializers:

Rule 1： Designated initializers must call a designated initializer from their immediate superclass.

Rule 2： Convenience initializers must call another initializer available in the same class.

Rule 3： Convenience initializers must ultimately end up calling a designated initializer.

A simple way to remember this is:

Designated initializers must always delegate up. Convenience initializers must always delegate across.

Class initialization in Swift is a two-phase process. In the first phase, each stored property is assigned an initial value by the class that introduced it. Once the initial state for every stored property has been determined, the second phase begins, and each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use.


    class Food {
        var name: String
        init(name: String) {
            self.name = name
        }
        convenience init() {
            self.init(name: "[Unnamed]")
        }
    }

    let namedMeat = Food(name: "Bacon")
    // namedMeat's name is "Bacon"

    let mysteryMeat = Food()
    // mysteryMeat's name is "[Unnamed]"

    class RecipeIngredient: Food {
        var quantity: Int
        init(name: String, quantity: Int) {
            self.quantity = quantity
            super.init(name: name)
        }
        convenience init(name: String) {
            self.init(name: name, quantity: 1)
        }
    }

    let oneMysteryItem = RecipeIngredient()
    let oneBacon = RecipeIngredient(name: "Bacon")
    let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

    class ShoppingListItem: RecipeIngredient {
        var purchased = false
        var description: String {
        var output = "\(quantity) x \(name.lowercaseString)"
            output += purchased ? " ✔" : " ✘"
            return output
        }
    }

    var breakfastList = [
        ShoppingListItem(),
        ShoppingListItem(name: "Bacon"),
        ShoppingListItem(name: "Eggs", quantity: 6),
    ]
    breakfastList[0].name = "Orange juice"
    breakfastList[0].purchased = true
    for item in breakfastList {
        println(item.description)
    }
    // 1 x orange juice ✔
    // 1 x bacon ✘
    // 6 x eggs ✘



    class SomeClass {
        let someProperty: SomeType = {
            // create a default value for someProperty inside this closure
            // someValue must be of the same type as SomeType
            return someValue
            }()
    }


Note that the closure's end curly brace is followed by an empty pair of parentheses. This tells Swift to execute the closure immediately.


    struct Checkerboard {
        let boardColors: Bool[] = {
            var temporaryBoard = Bool[]()
            var isBlack = false
            for i in 1...10 {
                for j in 1...10 {
                    temporaryBoard.append(isBlack)
                    isBlack = !isBlack
                }
                isBlack = !isBlack
            }
            return temporaryBoard
            }()
        func squareIsBlackAtRow(row: Int, column: Int) -&gt; Bool {
            return boardColors[(row * 10) + column]
        }
    }

    let board = Checkerboard()
    println(board.squareIsBlackAtRow(0, column: 1))
    // prints "true"
    println(board.squareIsBlackAtRow(9, column: 9))
    // prints "false"


## Deinitialization
<a name="Deinitialization"></a>

Deinitializers are only available on class types.


    deinit {
        // perform the deinitialization
    }



    struct Bank {
        static var coinsInBank = 10_000
        static func vendCoins(var numberOfCoinsToVend: Int) -&gt; Int {
            numberOfCoinsToVend = min(numberOfCoinsToVend, coinsInBank)
            coinsInBank -= numberOfCoinsToVend
            return numberOfCoinsToVend
        }
        static func receiveCoins(coins: Int) {
            coinsInBank += coins
        }
    }

    lass Player {
        var coinsInPurse: Int
        init(coins: Int) {
            coinsInPurse = Bank.vendCoins(coins)
        }
        func winCoins(coins: Int) {
            coinsInPurse += Bank.vendCoins(coins)
        }
        deinit {
            Bank.receiveCoins(coinsInPurse)
        }
    }

    var playerOne: Player? = Player(coins: 100)
    println("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
    // prints "A new player has joined the game with 100 coins"
    println("There are now \(Bank.coinsInBank) coins left in the bank")
    // prints "There are now 9900 coins left in the bank"

    playerOne!.winCoins(2_000)
    println("PlayerOne won 2000 coins &amp; now has \(playerOne!.coinsInPurse) coins")
    // prints "PlayerOne won 2000 coins &amp; now has 2100 coins"
    println("The bank now only has \(Bank.coinsInBank) coins left")
    // prints "The bank now only has 7900 coins left"

    playerOne = nil
    println("PlayerOne has left the game")
    // prints "PlayerOne has left the game"
    println("The bank now has \(Bank.coinsInBank) coins")
    // prints "The bank now has 10000 coins"


## Automatic Reference Counting
<a name="ARC"></a>


    class Person {
        let name: String
        init(name: String) { self.name = name }
        var apartment: Apartment?
        deinit { println("\(name) is being deinitialized") }
    }

    class Apartment {
        let number: Int
        init(number: Int) { self.number = number }
        var tenant: Person?
        deinit { println("Apartment #\(number) is being deinitialized") }
    }

    var john: Person?
    var number73: Apartment?

    john = Person(name: "John Appleseed")
    number73 = Apartment(number: 73)

    john!.apartment = number73
    number73!.tenant = john


Resolving Strong Reference Cycles Between Class Instances: Weak References


    class Person {
        let name: String
        init(name: String) { self.name = name }
        var apartment: Apartment?
        deinit { println("\(name) is being deinitialized") }
    }

    class Apartment {
        let number: Int
        init(number: Int) { self.number = number }
        weak var tenant: Person?
        deinit { println("Apartment #\(number) is being deinitialized") }
    }

    var john: Person?
    var number73: Apartment?

    john = Person(name: "John Appleseed")
    number73 = Apartment(number: 73)

    john!.apartment = number73
    number73!.tenant = john


Resolving Strong Reference Cycles Between Class Instances: Unowned References


    class Customer {
        let name: String
        var card: CreditCard?
        init(name: String) {
            self.name = name
        }
        deinit { println("\(name) is being deinitialized") }
    }

    class CreditCard {
        let number: Int
        unowned let customer: Customer
        init(number: Int, customer: Customer) {
            self.number = number
            self.customer = customer
        }
        deinit { println("Card #\(number) is being deinitialized") }
    }

    var john: Customer?
    john = Customer(name: "John Appleseed")
    john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)


Unowned References and Implicitly Unwrapped Optional Properties


    class Country {
        let name: String
        let capitalCity: City!
        init(name: String, capitalName: String) {
            self.name = name
            self.capitalCity = City(name: capitalName, country: self)
        }
    }

    class City {
        let name: String
        unowned let country: Country
        init(name: String, country: Country) {
            self.name = name
            self.country = country
        }
    }

    var country = Country(name: "Canada", capitalName: "Ottawa")
    println("\(country.name)'s capital city is called \(country.capitalCity.name)")
    // prints "Canada's capital city is called Ottawa"


The initializer for City is called from within the initializer for Country. However, the initializer for Country cannot pass self to the City initializer until a new Country instance is fully initialized, as described in Two-Phase Initialization.

To cope with this requirement, you declare the capitalCity property of Country as an implicitly unwrapped optional property, indicated by the exclamation mark at the end of its type annotation (City!). This means that the capitalCity property has a default value of nil, like any other optional, but can be accessed without the need to unwrap its value as described in Implicitly Unwrapped Optionals.

Resolving Strong Reference Cycles for Closures


    class HTMLElement {

        let name: String
        let text: String?

        @lazy var asHTML: () -&gt; String = {
            if let text = self.text {
                return "\(text)"
            } else {
                return ""
            }
        }

        init(name: String, text: String? = nil) {
            self.name = name
            self.text = text
        }

        deinit {
            println("\(name) is being deinitialized")
        }

    }

    var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
    println(paragraph!.asHTML())
    // prints "hello, world"
    paragraph = nil  // the message in the HTMLElement deinitializer is not printed



    class HTMLElement {

        let name: String
        let text: String?

        @lazy var asHTML: () -&gt; String = {
            [unowned self] in
            if let text = self.text {
                return "\(text)"
            } else {
                return ""
            }
        }

        init(name: String, text: String? = nil) {
            self.name = name
            self.text = text
        }

        deinit {
            println("\(name) is being deinitialized")
        }

    }

    var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
    println(paragraph!.asHTML())
    // prints "hello, world"

    paragraph = nil
    // prints "p is being deinitialized"


## Optional Chaining
<a name="OptionalChaining"></a>

You specify optional chaining by placing a question mark (?) after the optional value on which you wish to call a property, method or subscript if the optional is non-nil.


    class Person {
        var residence: Residence?
    }

    class Residence {
        var numberOfRooms = 1
    }

    let john = Person()
    let roomCount = john.residence!.numberOfRooms
    // this triggers a runtime error

    if let roomCount = john.residence?.numberOfRooms { // 返回的是Int?
        println("John's residence has \(roomCount) room(s).")
    } else {
        println("Unable to retrieve the number of rooms.")
    }
    // prints "Unable to retrieve the number of rooms."

    john.residence = Residence()
    if let roomCount = john.residence?.numberOfRooms {
        println("John's residence has \(roomCount) room(s).")
    } else {
        println("Unable to retrieve the number of rooms.")
    }
    // prints "John's residence has 1 room(s)."


The fact that it is queried through an optional chain means that the call to numberOfRooms will always return an Int? instead of an Int.

You cannot set a property's value through optional chaining.


    if john.residence?.printNumberOfRooms() {
        println("It was possible to print the number of rooms.")
    } else {
        println("It was not possible to print the number of rooms.")
    }
    // prints "It was not possible to print the number of rooms."

    if let firstRoomName = john.residence?[0].name {
        println("The first room name is \(firstRoomName).")
    } else {
        println("Unable to retrieve the first room name.")
    }
    // prints "Unable to retrieve the first room name."


If you try to retrieve an Int value through optional chaining, an Int? is always returned, no matter how many levels of chaining are used. Similarly, if you try to retrieve an Int? value through optional chaining, an Int? is always returned, no matter how many levels of chaining are used.

## Type Casting
<a name="TypeCasting"></a>

Type casting in Swift is implemented with the is and as operators. These two operators provide a simple and expressive way to check the type of a value or cast a value to a different type.


    class MediaItem {
        var name: String
        init(name: String) {
            self.name = name
        }
    }

    class Movie: MediaItem {
        var director: String
        init(name: String, director: String) {
            self.director = director
            super.init(name: name)
        }
    }

    class Song: MediaItem {
        var artist: String
        init(name: String, artist: String) {
            self.artist = artist
            super.init(name: name)
        }
    }

    let library = [
        Movie(name: "Casablanca", director: "Michael Curtiz"),
        Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
        Movie(name: "Citizen Kane", director: "Orson Welles"),
        Song(name: "The One And Only", artist: "Chesney Hawkes"),
        Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
    ]
    // the type of "library" is inferred to be MediaItem[]

    // Use the type check operator (is) to check whether an instance is of a certain subclass type.

    var movieCount = 0
    var songCount = 0

    for item in library {
        if item is Movie {
            ++movieCount
        } else if item is Song {
            ++songCount
        }
    }

    println("Media library contains \(movieCount) movies and \(songCount) songs")
    // prints "Media library contains 2 movies and 3 songs"

    for item in library {
        if let movie = item as? Movie {
            println("Movie: '\(movie.name)', dir. \(movie.director)")
        } else if let song = item as? Song {
            println("Song: '\(song.name)', by \(song.artist)")
        }
    }

    // Movie: 'Casablanca', dir. Michael Curtiz
    // Song: 'Blue Suede Shoes', by Elvis Presley
    // Movie: 'Citizen Kane', dir. Orson Welles
    // Song: 'The One And Only', by Chesney Hawkes
    // Song: 'Never Gonna Give You Up', by Rick Astley


Casting does not actually modify the instance or change its values. The underlying instance remains the same; it is simply treated and accessed as an instance of the type to which it has been cast.

AnyObject can represent an instance of any class type. Any can represent an instance of any type at all, apart from function types.


    let someObjects: AnyObject[] = [
        Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
        Movie(name: "Moon", director: "Duncan Jones"),
        Movie(name: "Alien", director: "Ridley Scott")
    ]

    for object in someObjects {
        let movie = object as Movie
        println("Movie: '\(movie.name)', dir. \(movie.director)")
    }
    // Movie: '2001: A Space Odyssey', dir. Stanley Kubrick
    // Movie: 'Moon', dir. Duncan Jones
    // Movie: 'Alien', dir. Ridley Scott

    for movie in someObjects as Movie[] {
        println("Movie: '\(movie.name)', dir. \(movie.director)")
    }
    // Movie: '2001: A Space Odyssey', dir. Stanley Kubrick
    // Movie: 'Moon', dir. Duncan Jones
    // Movie: 'Alien', dir. Ridley Scott



    var things = Any[]()

    things.append(0)
    things.append(0.0)
    things.append(42)
    things.append(3.14159)
    things.append("hello")
    things.append((3.0, 5.0))
    things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))

    for thing in things {
        switch thing {
        case 0 as Int:
            println("zero as an Int")
        case 0 as Double:
            println("zero as a Double")
        case let someInt as Int:
            println("an integer value of \(someInt)")
        case let someDouble as Double where someDouble &gt; 0:
            println("a positive double value of \(someDouble)")
        case is Double:
            println("some other double value that I don't want to print")
        case let someString as String:
            println("a string value of \"\(someString)\"")
        case let (x, y) as (Double, Double):
            println("an (x, y) point at \(x), \(y)")
        case let movie as Movie:
            println("a movie called '\(movie.name)', dir. \(movie.director)")
        default:
            println("something else")
        }
    }

    // zero as an Int
    // zero as a Double
    // an integer value of 42
    // a positive double value of 3.14159
    // a string value of "hello"
    // an (x, y) point at 3.0, 5.0
    // a movie called 'Ghostbusters', dir. Ivan Reitman


## Nested Types
<a name="NestedType"></a>


    struct BlackjackCard {

        // nested Suit enumeration
        enum Suit: Character {
            case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
        }

        // nested Rank enumeration
        enum Rank: Int {
            case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
            case Jack, Queen, King, Ace
            struct Values {
                let first: Int, second: Int?
            }
            var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.toRaw(), second: nil)
                }
            }
        }

        // BlackjackCard properties and methods
        let rank: Rank, suit: Suit
        var description: String {
        var output = "suit is \(suit.toRaw()),"
            output += " value is \(rank.values.first)"
            if let second = rank.values.second {
                output += " or \(second)"
            }
            return output
        }
    }

    let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
    println("theAceOfSpades: \(theAceOfSpades.description)")
    // prints "theAceOfSpades: suit is ♠, value is 1 or 11"

    let heartsSymbol = BlackjackCard.Suit.Hearts.toRaw()
    // heartsSymbol is "♡"


## Extensions
<a name="Extension"></a>

Extensions are similar to categories in Objective-C.

Extensions in Swift can:

Add computed properties and computed static properties Define instance methods and type methods Provide new initializers Define subscripts Define and use new nested types Make an existing type conform to a protocol

If you define an extension to add new functionality to an existing type, the new functionality will be available on all existing instances of that type, even if they were created before the extension was defined.


    extension SomeType {
        // new functionality to add to SomeType goes here
    }

    extension SomeType: SomeProtocol, AnotherProtocol {
        // implementation of protocol requirements goes here
    }



    extension Double {
        var km: Double { return self * 1_000.0 }
        var m: Double { return self }
        var cm: Double { return self / 100.0 }
        var mm: Double { return self / 1_000.0 }
        var ft: Double { return self / 3.28084 }
    }
    let oneInch = 25.4.mm
    println("One inch is \(oneInch) meters")
    // prints "One inch is 0.0254 meters"
    let threeFeet = 3.ft
    println("Three feet is \(threeFeet) meters")
    // prints "Three feet is 0.914399970739201 meters"


Extensions can add new computed properties, but they cannot add stored properties, or add property observers to existing properties.


    struct Size {
        var width = 0.0, height = 0.0
    }
    struct Point {
        var x = 0.0, y = 0.0
    }
    struct Rect {
        var origin = Point()
        var size = Size()
    }

    let defaultRect = Rect()
    let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
        size: Size(width: 5.0, height: 5.0))

    extension Rect {
        init(center: Point, size: Size) {
            let originX = center.x - (size.width / 2)
            let originY = center.y - (size.height / 2)
            self.init(origin: Point(x: originX, y: originY), size: size)
        }
    }

    let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
        size: Size(width: 3.0, height: 3.0))
    // centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)



    extension Int {
        func repetitions(task: () -&gt; ()) {
            for i in 0..self {
                task()
            }
        }
    }

    3.repetitions({
        println("Hello!")
        })
    // Hello!
    // Hello!
    // Hello!

    //Use trailing closure syntax to make the call more succinct:
    3.repetitions {
        println("Goodbye!")
    }
    // Goodbye!
    // Goodbye!
    // Goodbye!


// Structure and enumeration methods that modify self or its properties must mark the instance method as mutating, just like mutating methods from an original implementation.


    extension Int {
        mutating func square() {
            self = self * self
        }
    }
    var someInt = 3
    someInt.square()
    // someInt is now 9



    extension Int {
        subscript(digitIndex: Int) -&gt; Int {
            var decimalBase = 1
                for _ in 1...digitIndex {
                    decimalBase *= 10
                }
                return (self / decimalBase) % 10
        }
    }
    746381295[0]
    // returns 5
    746381295[1]
    // returns 9
    746381295[2]
    // returns 2
    746381295[8]
    // returns 7
    746381295[9]
    // returns 0, as if you had requested:
    0746381295[9]



    extension Character {
        enum Kind {
            case Vowel, Consonant, Other
        }
        var kind: Kind {
        switch String(self).lowercaseString {
        case "a", "e", "i", "o", "u":
            return .Vowel
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
        "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            return .Consonant
        default:
            return .Other
            }
        }
    }

    func printLetterKinds(word: String) {
        println("'\(word)' is made up of the following kinds of letters:")
        for character in word {
            switch character.kind {
            case .Vowel:
                print("vowel ")
            case .Consonant:
                print("consonant ")
            case .Other:
                print("other ")
            }
        }
        print("
    ")
    }
    printLetterKinds("Hello")
    // 'Hello' is made up of the following kinds of letters:
    // consonant vowel consonant consonant vowel


NOTE: character.kind is already known to be of type Character.Kind. Because of this, all of the Character.Kind member values can be written in shorthand form inside the switch statement, such as .Vowel rather than Character.Kind.Vowel.

## Protocols
<a name="Protocol"></a>

A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol doesn't actually provide an implementation for any of these requirements—it only describes what an implementation will look like. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol.


    protocol SomeProtocol {
        // protocol definition goes here
    }

    struct SomeStructure: FirstProtocol, AnotherProtocol {
        // structure definition goes here
    }

    class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
        // class definition goes here
    }



    protocol SomeProtocol {
        var mustBeSettable: Int { get set }
        var doesNotNeedToBeSettable: Int { get }
    }

    // Always prefix type property requirements with the class keyword when you define them in a protocol.
    protocol AnotherProtocol {
        class var someTypeProperty: Int { get set }
    }



    protocol FullyNamed {
        var fullName: String { get }
    }

    struct Person: FullyNamed {
        var fullName: String
    }
    let john = Person(fullName: "John Appleseed")
    // john.fullName is "John Appleseed"

    class Starship: FullyNamed {
        var prefix: String?
        var name: String
        init(name: String, prefix: String? = nil) {
            self.name = name
            self.prefix = prefix
        }
        var fullName: String {
        return (prefix ? prefix! + " " : "") + name
        }
    }
    var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
    // ncc1701.fullName is "USS Enterprise"


Protocols use the same syntax as normal methods, but are not allowed to specify default values for method parameters.


    protocol SomeProtocol {
        class func someTypeMethod()
    }

    protocol RandomNumberGenerator {
        func random() -&gt; Double
    }

    class LinearCongruentialGenerator: RandomNumberGenerator {
        var lastRandom = 42.0
        let m = 139968.0
        let a = 3877.0
        let c = 29573.0
        func random() -&gt; Double {
            lastRandom = ((lastRandom * a + c) % m)
            return lastRandom / m
        }
    }
    let generator = LinearCongruentialGenerator()
    println("Here's a random number: \(generator.random())")
    // prints "Here's a random number: 0.37464991998171"
    println("And another one: \(generator.random())")
    // prints "And another one: 0.729023776863283"


If you mark a protocol instance method requirement as mutating, you do not need to write the mutating keyword when writing an implementation of that method for a class. The mutating keyword is only used by structures and enumerations.


    protocol Togglable {
        mutating func toggle()
    }

    enum OnOffSwitch: Togglable {
        case Off, On
        mutating func toggle() {
            switch self {
            case Off:
                self = On
            case On:
                self = Off
            }
        }
    }
    var lightSwitch = OnOffSwitch.Off
    lightSwitch.toggle()
    // lightSwitch is now equal to .On



    class Dice {
        let sides: Int
        let generator: RandomNumberGenerator
        init(sides: Int, generator: RandomNumberGenerator) {
            self.sides = sides
            self.generator = generator
        }
        func roll() -&gt; Int {
            return Int(generator.random() * Double(sides)) + 1
        }
    }

    var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
    for _ in 1...5 {
        println("Random dice roll is \(d6.roll())")
    }
    // Random dice roll is 3
    // Random dice roll is 5
    // Random dice roll is 4
    // Random dice roll is 5
    // Random dice roll is 4



    protocol DiceGame {
        var dice: Dice { get }
        func play()
    }
    protocol DiceGameDelegate {
        func gameDidStart(game: DiceGame)
        func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
        func gameDidEnd(game: DiceGame)
    }

    class SnakesAndLadders: DiceGame {
        let finalSquare = 25
        let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
        var square = 0
        var board: Int[]
        init() {
            board = Int[](count: finalSquare + 1, repeatedValue: 0)
            board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
            board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        }
        var delegate: DiceGameDelegate?
        func play() {
            square = 0
            delegate?.gameDidStart(self)
            gameLoop: while square != finalSquare {
                let diceRoll = dice.roll()
                delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
                switch square + diceRoll {
                case finalSquare:
                    break gameLoop
                case let newSquare where newSquare &gt; finalSquare:
                    continue gameLoop
                default:
                    square += diceRoll
                    square += board[square]
                }
            }
            delegate?.gameDidEnd(self)
        }
    }

    class DiceGameTracker: DiceGameDelegate {
        var numberOfTurns = 0
        func gameDidStart(game: DiceGame) {
            numberOfTurns = 0
            if game is SnakesAndLadders {
                println("Started a new game of Snakes and Ladders")
            }
            println("The game is using a \(game.dice.sides)-sided dice")
        }
        func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
            ++numberOfTurns
            println("Rolled a \(diceRoll)")
        }
        func gameDidEnd(game: DiceGame) {
            println("The game lasted for \(numberOfTurns) turns")
        }
    }

    let tracker = DiceGameTracker()
    let game = SnakesAndLadders()
    game.delegate = tracker
    game.play()
    // Started a new game of Snakes and Ladders
    // The game is using a 6-sided dice
    // Rolled a 3
    // Rolled a 5
    // Rolled a 4
    // Rolled a 5
    // The game lasted for 4 turns



    protocol TextRepresentable {
        func asText() -&gt; String
    }

    extension Dice: TextRepresentable {
        func asText() -&gt; String {
            return "A \(sides)-sided dice"
        }
    }

    let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
    println(d12.asText())
    // prints "A 12-sided dice"

    extension SnakesAndLadders: TextRepresentable {
        func asText() -&gt; String {
            return "A game of Snakes and Ladders with \(finalSquare) squares"
        }
    }
    println(game.asText())
    // prints "A game of Snakes and Ladders with 25 squares"


If a type already conforms to all of the requirements of a protocol, but has not yet stated that it adopts that protocol, you can make it adopt the protocol with an empty extension:


    struct Hamster {
        var name: String
        func asText() -&gt; String {
            return "A hamster named \(name)"
        }
    }
    extension Hamster: TextRepresentable {}

    let simonTheHamster = Hamster(name: "Simon")
    let somethingTextRepresentable: TextRepresentable = simonTheHamster
    println(somethingTextRepresentable.asText())
    // prints "A hamster named Simon"



    let things: TextRepresentable[] = [game, d12, simonTheHamster]

    for thing in things {
        println(thing.asText())
    }
    // A game of Snakes and Ladders with 25 squares
    // A 12-sided dice
    // A hamster named Simon



    protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
        // protocol definition goes here
    }

    protocol PrettyTextRepresentable: TextRepresentable {
        func asPrettyText() -&gt; String
    }

    extension SnakesAndLadders: PrettyTextRepresentable {
        func asPrettyText() -&gt; String {
            var output = asText() + ":
    "
            for index in 1...finalSquare {
                switch board[index] {
                case let ladder where ladder &gt; 0:
                    output += "▲ "
                case let snake where snake &lt; 0:
                    output += "▼ "
                default:
                    output += "○ "
                }
            }
            return output
        }
    }

    println(game.asPrettyText())
    // A game of Snakes and Ladders with 25 squares:
    // ○ ○ ▲ ○ ○ ▲ ○ ○ ▲ ▲ ○ ○ ○ ▼ ○ ○ ○ ○ ▼ ○ ○ ▼ ○ ▼ ○



    // Protocol Composition

    protocol Named {
        var name: String { get }
    }
    protocol Aged {
        var age: Int { get }
    }
    struct Person: Named, Aged {
        var name: String
        var age: Int
    }
    // any type that conforms to both the Named and Aged protocols
    func wishHappyBirthday(celebrator: protocol) {
        println("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
    }
    let birthdayPerson = Person(name: "Malcolm", age: 21)
    wishHappyBirthday(birthdayPerson)
    // prints "Happy birthday Malcolm - you're 21!"


You can check for protocol conformance only if your protocol is marked with the @objc attribute, as seen for the HasArea protocol above. This attribute indicates that the protocol should be exposed to Objective-C code and is described in Using Swift with Cocoa and Objective-C. Even if you are not interoperating with Objective-C, you need to mark your protocols with the @objc attribute if you want to be able to check for protocol conformance.

Note also that @objc protocols can be adopted only by classes, and not by structures or enumerations. If you mark your protocol as @objc in order to check for conformance, you will be able to apply that protocol only to class types.


    @objc protocol HasArea {
        var area: Double { get }
    }

    class Circle: HasArea {
        let pi = 3.1415927
        var radius: Double
        var area: Double { return pi * radius * radius }
        init(radius: Double) { self.radius = radius }
    }
    class Country: HasArea {
        var area: Double
        init(area: Double) { self.area = area }
    }
    class Animal {
        var legs: Int
        init(legs: Int) { self.legs = legs }
    }

    let objects: AnyObject[] = [
        Circle(radius: 2.0),
        Country(area: 243_610),
        Animal(legs: 4)
    ]

    for object in objects {
        if let objectWithArea = object as? HasArea {
            println("Area is \(objectWithArea.area)")
        } else {
            println("Something that doesn't have an area")
        }
    }
    // Area is 12.5663708
    // Area is 243610.0
    // Something that doesn't have an area



    // Optional Protocol Requirements

    @objc protocol CounterDataSource {
        @optional func incrementForCount(count: Int) -&gt; Int
        @optional var fixedIncrement: Int { get }
    }

    @objc class Counter {
        var count = 0
        var dataSource: CounterDataSource?
        func increment() {
            if let amount = dataSource?.incrementForCount?(count) {
                count += amount
            } else if let amount = dataSource?.fixedIncrement? {
                count += amount
            }
        }
    }

    class ThreeSource: CounterDataSource {
        let fixedIncrement = 3
    }

    var counter = Counter()
    counter.dataSource = ThreeSource()
    for _ in 1...4 {
        counter.increment()
        println(counter.count)
    }
    // 3
    // 6
    // 9
    // 12

    class TowardsZeroSource: CounterDataSource {
        func incrementForCount(count: Int) -&gt; Int {
            if count == 0 {
                return 0
            } else if count &lt; 0 {
                return 1
            } else {
                return -1
            }
        }
    }

    counter.count = -4
    counter.dataSource = TowardsZeroSource()
    for _ in 1...5 {
        counter.increment()
        println(counter.count)
    }
    // -3
    // -2
    // -1
    // 0
    // 0


## Generics
<a name="Generic"></a>


    func swapTwoValues(inout a: T, inout b: T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }

    var someInt = 3
    var anotherInt = 107
    swapTwoValues(&amp;someInt, &amp;anotherInt)
    // someInt is now 107, and anotherInt is now 3

    var someString = "hello"
    var anotherString = "world"
    swapTwoValues(&amp;someString, &amp;anotherString)
    // someString is now "world", and anotherString is now "hello"



    struct Stack {
        var items = T[]()
        mutating func push(item: T) {
            items.append(item)
        }
        mutating func pop() -&gt; T {
            return items.removeLast()
        }
    }

    var stackOfStrings = Stack()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")
    stackOfStrings.push("cuatro")
    // the stack now contains 4 strings
    let fromTheTop = stackOfStrings.pop()
    // fromTheTop is equal to "cuatro", and the stack now contains 3 strings


Type Constraints:


    func someFunction(someT: T, someU: U) {
        // function body goes here
    }



    func findIndex(array: T[], valueToFind: T) -&gt; Int? {
        for (index, value) in enumerate(array) {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }

    let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
    // doubleIndex is an optional Int with no value, because 9.3 is not in the array
    let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea")
    // stringIndex is an optional Int containing a value of 2


Associated Types:


    protocol Container {
        typealias ItemType
        mutating func append(item: ItemType)
        var count: Int { get }
        subscript(i: Int) -&gt; ItemType { get }
    }

    struct Stack: Container {
        // original Stack implementation
        var items = T[]()
        mutating func push(item: T) {
            items.append(item)
        }
        mutating func pop() -&gt; T {
            return items.removeLast()
        }
        // conformance to the Container protocol
        // 自动推断出 typealias ItemType = T
        mutating func append(item: T) {
            self.push(item)
        }
        var count: Int {
        return items.count
        }
        subscript(i: Int) -&gt; T {
            return items[i]
        }
    }



    extension Array: Container {}


Array's existing append method and subscript enable Swift to infer the appropriate type to use for ItemType, just as for the generic Stack type above. After defining this extension, you can use any Array as a Container.

Where Clauses:


    func allItemsMatch&lt;
        C1: Container, C2: Container
        where C1.ItemType == C2.ItemType, C1.ItemType: Equatable&gt;
        (someContainer: C1, anotherContainer: C2) -&gt; Bool {

            // check that both containers contain the same number of items
            if someContainer.count != anotherContainer.count {
                return false
            }

            // check each pair of items to see if they are equivalent
            for i in 0..someContainer.count {
                if someContainer[i] != anotherContainer[i] {
                    return false
                }
            }

            // all items match, so return true
            return true

    }

    var stackOfStrings = Stack()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")

    var arrayOfStrings = ["uno", "dos", "tres"]

    if allItemsMatch(stackOfStrings, arrayOfStrings) {
        println("All items match.")
    } else {
        println("Not all items match.")
    }
    // prints "All items match."


## Advanced Operators
<a name="AdvancedOperator"></a>

    let initialBits: UInt8 = 0b00001111
    let invertedBits = ~initialBits  // equals 11110000

    let firstSixBits: UInt8 = 0b11111100
    let lastSixBits: UInt8  = 0b00111111
    let middleFourBits = firstSixBits &amp; lastSixBits  // equals 00111100

    let someBits: UInt8 = 0b10110010
    let moreBits: UInt8 = 0b01011110
    let combinedbits = someBits | moreBits  // equals 11111110

    let firstBits: UInt8 = 0b00010100
    let otherBits: UInt8 = 0b00000101
    let outputBits = firstBits ^ otherBits  // equals 00010001

    let shiftBits: UInt8 = 4   // 00000100 in binary
    shiftBits  16    // redComponent is 0xCC, or 204
    let greenComponent = (pink &amp; 0x00FF00) &gt;&gt; 8   // greenComponent is 0x66, or 102
    let blueComponent = pink &amp; 0x0000FF           // blueComponent is 0x99, or 153

    // 如果允许溢出，在运算符前加&amp;
    var willOverflow = UInt8.max
    // willOverflow equals 255, which is the largest value a UInt8 can hold
    willOverflow = willOverflow &amp;+ 1
    // willOverflow is now equal to 0

    var willUnderflow = UInt8.min
    // willUnderflow equals 0, which is the smallest value a UInt8 can hold
    willUnderflow = willUnderflow &amp;- 1
    // willUnderflow is now equal to 255

    var signedUnderflow = Int8.min
    // signedUnderflow equals -128, which is the smallest value an Int8 can hold
    signedUnderflow = signedUnderflow &amp;- 1
    // signedUnderflow is now equal to 127


运算符重载：


    struct Vector2D {
        var x = 0.0, y = 0.0
    }
    // It is said to be infix because it appears in between those two targets.
    @infix func + (left: Vector2D, right: Vector2D) -&gt; Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }

    let vector = Vector2D(x: 3.0, y: 1.0)
    let anotherVector = Vector2D(x: 2.0, y: 4.0)
    let combinedVector = vector + anotherVector
    // combinedVector is a Vector2D instance with values of (5.0, 5.0)

    @prefix func - (vector: Vector2D) -&gt; Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }

    let positive = Vector2D(x: 3.0, y: 4.0)
    let negative = -positive
    // negative is a Vector2D instance with values of (-3.0, -4.0)
    let alsoPositive = -negative
    // alsoPositive is a Vector2D instance with values of (3.0, 4.0)

    // 复合赋值运算符
    @assignment func += (inout left: Vector2D, right: Vector2D) {
        left = left + right
    }

    var original = Vector2D(x: 1.0, y: 2.0)
    let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
    original += vectorToAdd
    // original now has values of (4.0, 6.0)

    @prefix @assignment func ++ (inout vector: Vector2D) -&gt; Vector2D {
        vector += Vector2D(x: 1.0, y: 1.0)
        return vector
    }

    var toIncrement = Vector2D(x: 3.0, y: 4.0)
    let afterIncrement = ++toIncrement
    // toIncrement now has values of (4.0, 5.0)
    // afterIncrement also has values of (4.0, 5.0)


It is not possible to overload the default assignment operator (=). Only the compound assignment operators can be overloaded. Similarly, the ternary conditional operator (a ? b : c) cannot be overloaded.


    // Equivalence Operators
    @infix func == (left: Vector2D, right: Vector2D) -&gt; Bool {
        return (left.x == right.x) &amp;&amp; (left.y == right.y)
    }
    @infix func != (left: Vector2D, right: Vector2D) -&gt; Bool {
        return !(left == right)
    }

    let twoThree = Vector2D(x: 2.0, y: 3.0)
    let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
    if twoThree == anotherTwoThree {
        println("These two vectors are equivalent.")
    }
    // prints "These two vectors are equivalent."


Custom operators can be defined only with the characters / = - + * % &lt; &gt; ! &amp; | ^ . ~.

New operators are declared at a global level using the operator keyword, and can be declared as prefix, infix or postfix:


    operator prefix +++ {}

    @prefix @assignment func +++ (inout vector: Vector2D) -&gt; Vector2D {
        vector += vector
        return vector
    }

    var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
    let afterDoubling = +++toBeDoubled
    // toBeDoubled now has values of (2.0, 8.0)
    // afterDoubling also has values of (2.0, 8.0)


Precedence and Associativity for Custom Infix Operators


    operator infix +- { associativity left precedence 140 }
    func +- (left: Vector2D, right: Vector2D) -&gt; Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
    let firstVector = Vector2D(x: 1.0, y: 2.0)
    let secondVector = Vector2D(x: 3.0, y: 4.0)
    let plusMinusVector = firstVector +- secondVector
    // plusMinusVector is a Vector2D instance with values of (4.0, -2.0)


## A Swift Tour
<a name="Tour"></a>

Functions are actually a special case of closures. (In Swift, functions are just named closures) You can write a closure without a name by surrounding code with braces (`{}`). Use `in` to separate the arguments and return type from the body.

Methods on classes have one important difference from functions. Parameter names in functions are used only within the function, but parameters names in methods are also used when you call the method (except for the first parameter). By default, a method has the same name for its parameters when you call it and within the method itself. You can specify a second name, which is used inside the method.


    // 错误
    let convertedRank = Rank.fromRaw(3)  // convertedRank 的类型是Rank?
    let threeDescription = convertedRank.toRaw() // optional type不能直接方法

    //正确
    let convertedRank = Rank.fromRaw(3)!
    let threeDescription = convertedRank.toRaw()  // 3

    // 正确
    let convertedRank = Rank.fromRaw(3)
    let threeDescription = convertedRank!.toRaw()  // 3

    // 正确
    let convertedRank = Rank.fromRaw(3)
    let threeDescription = convertedRank?.toRaw()  // {some 3}


One of the most important differences between structures and classes is that structures are always copied when they are passed around in your code, but classes are passed by reference

结构体中的方法要修改结构体，需要加mutating关键字；类则不用，加了反而错误。

Use `extension` to add functionality to an existing type, such as new methods and computed properties. You can use an extension to add protocol conformance to a type that is declared elsewhere, or even to a type that you imported from a library or framework.


    extension Int: ExampleProtocol {
        var simpleDescription: String {
        return "The number \(self)"
        }
        mutating func adjust() {
            self += 42
        }
    }
    7.simpleDescription


You can use a protocol name just like any other named type—for example, to create a collection of objects that have different types but that all conform to a single protocol. When you work with values whose type is a protocol type, methods outside the protocol definition are not available.


    let protocolValue: ExampleProtocol = a // a is an instance of SimpleClass, and SimpleClass adopt ExampleProtocol
    protocolValue.simpleDescription
    // protocolValue.anotherProperty  // Uncomment to see the error


Even though the variable protocolValue has a runtime type of SimpleClass, the compiler treats it as the given type of ExampleProtocol. This means that you can't accidentally access methods or properties that the class implements in addition to its protocol conformance.

