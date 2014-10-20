
[Source](https://swiftist.org/topics/126 "Permalink to 74个Swift标准库函数（大部分没在官方文档中列出） - Swiftist 社区")

# 74个Swift标准库函数（大部分没在官方文档中列出） - Swiftist 社区

## 74个Swift标准库函数

本文译自 [Swift Standard Library: Documented and undocumented built-in functions in the Swift standard library – the complete list with all 74 functions][1]。我不是原作者，我只是勤劳的翻译工：）文中作者没有提及他是如何发现这么多未在文档中体现的内置函数的，估计是反编译的结果。我测试了好多个都能用，而且Xcode还会给出语法提示：）, 本翻译并非该 github  帐号作者，翻译作者连接请点击顶部「source」 链接。我不是翻译工，我只是搜藏家:]

Swift包含了74个内置函数，但在`The Swift Programming Langage`一书中只介绍了其中的7个，其它的都没有在文档中体现。

这篇文章列举出了所有的内置Swift函数。文中所谓的`内置函数`是指无需引入任何模块（比如说`Fundation`等）即可以直接使用的函数。

### 下面先来看看7个在文档中提到的内置函数：

```Swift
// 断言，参数如果为`true`则继续，否则抛出异常
// assert mentioned on page 55
assert(true)

// 计算序列的元素个数
// countElements mentioned on page 79
countElements("foo") == 3

// 返回一个新的序列，其中每个元素是一个元组，第一个值为原来元素所在的位置`index`，第二个为原来序列中的元素
// enumerate mentioned on page 94
for (i, j) in enumerate(["A", "B"]) {
    // "0:A", "1:B" will be printed
    println("(i):(j)")
}

// 返回所有参数中的最小值
// min mentioned on page 246
min(8, 2, 3) == 2

//打印
// print mentioned on page 85
print("Hello ")

// 打印（带换行）
// println mentioned on page 4
println("World")

// 排序
// sort mentioned on page 14
for i in sort(["B", "A"]) {
    // "A", "B" will be printed
    println(i)
}
```

### 下面列出一些很实用，但未在文档中体现的内置函数：

* **abs(signedNumber)**：返回数字的绝对值

```Swift
abs(-1) == 1
abs(-42) == 42
abs(42) == 42
```

* **contains(sequence, element)**：如果某个序列`sequence`（比如说一个数组）包含指定的元素`element`，则返回`true`，否则返回`false`。

```Swift
var languages = ["Swift", "Objective-C"]
contains(languages, "Swift") == true
contains(languages, "Java") == false
contains([29, 85, 42, 96, 75], 42) == true
```

* **dropFirst(sequence)**：返回一个去掉了首个元素的、新的序列（比如一个新数组）。

```Swift
var languages = ["Swift", "Objective-C"]
var oldLanguages = dropFirst(languages)
equal(oldLanguages, ["Objective-C"]) == true
```

* **dropLast(sequence)**：返回一个去掉了最后一个元素的、新的序列（比如一个新数组）。

```Swift
var languages = ["Swift", "Objective-C"]
var newLanguages = dropLast(languages)
equal(newLanguages, ["Swift"]) == true
```

* **dump(object)**：打印出某个对象`object`的所有信息

```Swift
var languages = ["Swift", "Objective-C"]
dump(languages)
// Prints:
// ▿ 2 elements
//   - [0]: Swift
//   - [1]: Objective-C
```

* **equal(sequence1, sequence2)**：判断两个序列是否相等

```Swift
var languages = ["Swift", "Objective-C"]
equal(languages, ["Swift", "Objective-C"]) == true
var oldLanguages = dropFirst(languages)
equal(oldLanguages, ["Objective-C"]) == true
```

* **filter(sequence, includeElementClosure)**：对序列`sequence`中每个元素都执行`includeElementClosure`闭包，并将所有闭包结果为`true`的元素合成一个新序列`sequence`并返回。

```Swift
for i in filter(1...100, { $0 % 10 == 0 }) {
    // 10, 20, 30, ...
    println(i)
    assert(contains([10, 20, 30, 40, 50, 60, 70, 80, 90, 100], i))
}
```

* **find(sequence, element)**：返回序列`sequence`中某元素`element`的位置`index`。如果序列中不存在此元素，则返回`nil`。

```Swift
var languages = ["Swift", "Objective-C"]
find(languages, "Objective-C") == 1
find(languages, "Java") == nil
find([29, 85, 42, 96, 75], 42) == 2
```

* **indices(sequence)**：返回序列`sequence`中所有元素的位置（`indices`是`index`的复数）

```Swift
equal(indices([29, 85, 42]), [0, 1, 2])
for i in indices([29, 85, 42]) {
    // 0, 1, 2
    println(i)
}
```

* **join(separator, sequence)**：将序列`sequence`通过分隔符`separator`连成一个字符串，并返回此字符串。

```Swift
join(":", ["A", "B", "C"]) == "A:B:C"
var languages = ["Swift", "Objective-C"]
join("/", languages) == "Swift/Objective-C"
```

* **map(sequence, transformClosure)**：对序列`sequence`中每个元素都执行`includeElementClosure`闭包，并将所有闭包的结果合成一个新序列`sequence`并返回。

```Swift
equal(map(1...3, { $0 * 5 }), [5, 10, 15])
for i in map(1...10, { $0 * 10 }) {
    // 10, 20, 30, ...
    println(i)
    assert(contains([10, 20, 30, 40, 50, 60, 70, 80, 90, 100], i))
}
```

* **max(comparable1, comparable2, etc.)**：返回参数中的最大值。

```Swift
max(0, 1) == 1
max(8, 2, 3) == 8
```

* **maxElement(sequence)**：返回序列`sequence`中的最大值。

```Swift
maxElement(1...10) == 10
var languages = ["Swift", "Objective-C"]
maxElement(languages) == "Swift"
```

* **minElements(sequence)**：返回序列`sequence`中的最小值。

```Swift
minElement(1...10) == 1
var languages = ["Swift", "Objective-C"]
minElement(languages) == "Objective-C"
```

* **reduce(sequence, initial, combineClosure)**：给定一个序列`sequence`，以及一个初始值`initial`，然后将`initial`和序列里的第1个元素作为参数传入`combineClosure`中进行运算，得到的结果保存到`initial`；然后再将`initial`和第2个元素传入`combineClosure`中计算，结果保存到`initial`；重复计算直到所有`sequence`中的元素都计算完毕，并返回最终的`initial`值。

```Swift
var languages = ["Swift", "Objective-C"]
reduce(languages, "", { $0 + $1 }) == "SwiftObjective-C"
reduce([10, 20, 5], 1, { $0 * $1 }) == 1000
```

* **reverse(sequence)**：返回逆序的序列`sequence`。

```Swift
equal(reverse([1, 2, 3]), [3, 2, 1])
for i in reverse([1, 2, 3]) {
    // 3, 2, 1
    println(i)
}
```

* **startsWith(sequence1, sequence2)**：如果序列`sequence1`中开头的元素跟序列`sequence2`中的所有元素都相等，则返回`true`，否则返回`false`。

```Swift
startsWith("foobar", "foo") == true
startsWith(10..100, 10..15) == true
var languages = ["Swift", "Objective-C"]
startsWith(languages, ["Swift"]) == true
```

上面提到的函数是我认为在Swift编程中会经常用到的函数。下面将列出完整的74个函数列表。

### 完整74个内置函数：

```Swift
abs(...)
advance(...)
alignof(...)
alignofValue(...)
assert(...)
bridgeFromObjectiveC(...)
bridgeFromObjectiveCUnconditional(...)
bridgeToObjectiveC(...)
bridgeToObjectiveCUnconditional(...)
c_malloc_size(...)
c_memcpy(...)
c_putchar(...)
contains(...)
count(...)
countElements(...)
countLeadingZeros(...)
debugPrint(...)
debugPrintln(...)
distance(...)
dropFirst(...)
dropLast(...)
dump(...)
encodeBitsAsWords(...)
enumerate(...)
equal(...)
filter(...)
find(...)
getBridgedObjectiveCType(...)
getVaList(...)
indices(...)
insertionSort(...)
isBridgedToObjectiveC(...)
isBridgedVerbatimToObjectiveC(...)
isUniquelyReferenced(...)
join(...)
lexicographicalCompare(...)
map(...)
max(...)
maxElement(...)
min(...)
minElement(...)
numericCast(...)
partition(...)
posix_read(...)
posix_write(...)
print(...)
println(...)
quickSort(...)
reduce(...)
reflect(...)
reinterpretCast(...)
reverse(...)
roundUpToAlignment(...)
sizeof(...)
sizeofValue(...)
sort(...)
split(...)
startsWith(...)
strideof(...)
strideofValue(...)
swap(...)
swift_MagicMirrorData_summaryImpl(...)
swift_bufferAllocate(...)
swift_keepAlive(...)
toString(...)
transcode(...)
underestimateCount(...)
unsafeReflect(...)
withExtendedLifetime(...)
withObjectAtPlusZero(...)
withUnsafePointer(...)
withUnsafePointerToObject(...)
withUnsafePointers(...)
withVaList(...)
```

[1]: http://practicalswift.com/2014/06/14/the-swift-standard-library-list-of-built-in-functions/
  
