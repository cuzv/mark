# Swift Issues

***

## 目录

- [字符串是值类型](#字符串是值类型)
- [结构体和枚举是值类型](#结构体和枚举是值类型)
- [类和结构体的选择](#类和结构体的选择)
- [集合类型(Collection)的赋值和拷贝行为](#集合类型的赋值和拷贝行为)
- [属性](#属性)
- [构造过程](#构造过程)
- [自动引用计数](#自动引用计数)
- [扩展](#扩展)
- [协议](#协议)
- [幽灵一般的Optional](#幽灵一般的Optional)
- [?和!的用法](#?和!的用法)

***

## 字符串是值类型

Swift的`String`类型是值类型。 如果您创建了一个新的字符串，那么当其进行常量、变量赋值操作或在函数、方法中传递时，会进行值拷贝。 任何情况下，都会对已有字符串值创建新副本，并对该新副本进行传递或赋值操作。 

> 注意：与 Cocoa 中的NSString不同，当您在 Cocoa 中创建了一个NSString实例，并将其传递给一个函数/方法，或者赋值给一个变量，您传递或赋值的是该NSString实例的一个引用，除非您特别要求进行值拷贝，否则字符串不会生成新的副本来进行赋值操作。

## 结构体和枚举是值类型

`值类型被赋予给一个变量，常数或者本身被传递给一个函数的时候，实际上操作的是其的拷贝`

在 Swift 中，所有的基本类型：整数（Integer）、浮点数（floating-point）、布尔值（Booleans）、字符串（string)、数组（array）和字典（dictionaries），都是值类型，并且都是以结构体的形式在后台所实现

在 Swift 中，所有的结构体和枚举都是值类型。这意味着它们的实例，以及实例中所包含的任何值类型属性，在代码中传递的时候都会被复制

## 类和结构体的选择

当符合一条或多条以下条件时，请考虑构建结构体：

- 结构体的主要目的是用来封装少量相关简单数据值。
- 有理由预计一个结构体实例在赋值或传递时，封装的数据将会被拷贝而不是被引用。
- 任何在结构体中储存的值类型属性，也将会被拷贝，而不是被引用。
- 结构体不需要去继承另一个已存在类型的属性或者行为。

合适的结构体候选者包括：

- 几何形状的大小，封装一个width属性和height属性，两者均为Double类型。
- 一定范围内的路径，封装一个start属性和length属性，两者均为Int类型。
- 三维坐标系内一点，封装x，y和z属性，三者均为Double类型。

## 集合类型的赋值和拷贝行为

Swift中`数组（Array）`和字典`（Dictionary）`类型均以结构体的形式实现。

`NSArray`和`NSDictionary`实例总是以对已有实例引用,而不是拷贝的方式被赋值和传递

如果`字典`实例中所储存的键（keys）和/或值（values）是值类型（结构体或枚举），当赋值或调用发生时，它们都会被拷贝。相反，如果键（keys）和/或值（values）是引用类型，被拷贝的将会是引用，而不是被它们引用的类实例或函数。字典的键和值的拷贝行为与结构体所储存的属性的拷贝行为相同。

在Swift 中，数组`（Arrays）`类型的赋值和拷贝行为要比字典`（Dictionary）`类型的复杂的多。当操作数组内容时，数组（Array）能提供接近C语言的的性能，并且拷贝行为只有在必要时才会发生。

如果你将一个数组（Array）实例赋给一个变量或常量，或者将其作为参数传递给函数或方法调用，在事件发生时数组的内容不会被拷贝。相反，数组公用相同的元素序列。当你在一个数组内修改某一元素，修改结果也会在另一数组显示。

对数组来说，拷贝行为仅仅当操作有可能修改数组长度时才会发生。这种行为包括了附加（appending）,插入（inserting）,删除（removing）或者使用范围下标（ranged subscript）去替换这一范围内的元素。只有当数组拷贝确要发生时，数组内容的行为规则与字典中键值的相同

代码分析：

```swift
var dic = [0:0, 1:0, 2:0]  
var newDic = dic  
//Check dic and newDic
dic[0] = 1  
dic    //[0: 1, 1: 0, 2: 0]  
newDic //[0: 0, 1: 0, 2: 0]

var arr = [0,0,0]  
var newArr = arr  
arr[0] = 1  
//Check arr and newArr
arr    //[1, 0, 0]  
newArr //[1, 0, 0]  
```

```swift
var arr = [0,0,0]  
var copiedArr = arr.copy()

arr[0] = 1  
arr       //[1, 0, 0]  
copiedArr //[0, 0, 0]  
```

> oneV's Den: Array 在 copy 时执行的不是深拷贝，所以 Array 中的参照类型在拷贝之后仍然会是参照。Array 中嵌套 Array 的情况亦是如此：对一个 Array 进行的 copy 只会将被拷贝的 Array 指向新的地址，而保持其中所有其他 Array 的引用。

```swift
var arr = [0,0,0]  
var newArr = Array(arr)

arr[0] = 1  
arr       //[1, 0, 0]  
newArr    //[0, 0, 0]  
```

```swift
var arr = [0,0,0]  
var newArr = arr

// arr's address 0x10490000

arr.unshare()

// newArr's address 0x10490000
// arr's address 0x0f0c0000

arr[0] = 1  
arr       //[1, 0, 0]  
newArr    //[0, 0, 0]  
```

>  注意：如果你仅需要确保你对数组的引用是唯一引用，请调用unshare方法，而不是copy方法。unshare方法仅会在确有必要时才会创建数组拷贝。copy方法会在任何时候都创建一个新的拷贝，即使引用已经是唯一引用。

> oneV's Den: unshare() 的作用是如果对象数组不是唯一参照，则复制一份，并将作用的参照指向新的地址（这样它就变成唯一参照，不会意外改变原来的别的同样的参照了）；而如果这个参照已经是唯一参照了的话，就什么都不做

## 属性

> 必须使用var关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let关键字只用来声明常量属性，表示初始化后再也无法修改的值

> 不需要为无法重载的计算属性添加属性监视器，因为可以通过setter直接监控和响应值的变化

> `willSet`和`didSet`监视器在属性初始化过程中不会被调用，它们只会当属性的值在初始化之外的地方被设置时被调用

> 全局的常量或变量都是延迟计算的，跟延迟存储属性相似，不同的地方在于，全局的常量或变量不需要标记`@lazy`特性。局部范围的常量或变量不会延迟计算

可以将一个继承来的只读属性重写为一个读写属性，只需要你在重写版本的属性里提供getter和setter
即可。但是，你不可以将一个继承来的读写属性重写为一个只读属性

> 如果你在重写属性中提供了setter，那么你也一定要提供getter。如果你不想在重写版本中的getter里修改继承来的属性值，你可以直接返回super.someProperty来返回继承来的值

> 不可以同时提供重写的setter和重写的属性观察器。如果你想观察属性值的变化，并且你已经为那个属性提供了定制的setter，那么你在setter中就可以观察到任何值变化了

## 构造过程

只要在构造过程结束前常量的值能确定，你可以在构造过程中的任意时间点修改常量属性的值。

> 对某个类实例来说，它的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改

构造器之间的代理调用规则:

- 指定构造器必须调用其直接父类的的指定构造器
- 便利构造器必须调用同一类中定义的其它构造器
- 便利构造器必须最终以调用一个指定构造器结束

## 通过闭包和函数来设置属性的默认值

```swift
class SomeClass {
    let someProperty: SomeType = {
        // 在这个闭包中给 someProperty 创建一个默认值
        // someValue 必须和 SomeType 类型相同
        return someValue
        }()
}
```
注意闭包结尾的大括号后面接了一对空的小括号。这是用来告诉 Swift
需要立刻执行此闭包。如果你忽略了这对括号，相当于是将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。

> 如果你使用闭包来初始化属性的值，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能够在闭包里访问其它的属性，就算这个属性有默认值也不允许。同样，你也不能使用隐式的self属性，或者调用其它的实例方法

## 自动引用计数

> 引用计数仅仅应用于类的实例。结构体和枚举类型是值类型，不是引用类型，也不是通过引用的方式存储和传递

### 解决实例之间的循环强引用

Swift提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题：弱引用（weak reference）和无主引用（unowned reference）。

弱引用和无主引用允许循环引用中的一个实例引用另外一个实例而不保持强引用。这样实例能够互相引用而不产生循环强引用。

对于生命周期中会变为nil的实例使用弱引用。相反的，对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用

弱引用必须被声明为变量，表明其值能在运行时被修改，因为弱引用可以没有值，你必须将每一个弱引用声明为可选类型

和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用是永远有值的。因此，无主引用总是被定义为非可选类型（non-optional type）

无主引用总是可以被直接访问。不过ARC无法在实例被销毁后将无主引用设为nil，因为非可选类型的变量不允许被赋值为nil 

> 如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误。使用无主引用，你必须确保引用始终指向一个未销毁的实例
> 还需要注意的是如果你试图访问实例已经被销毁的无主引用，程序会直接崩溃，而不会发生无法预期的行为。所以你应当避免这样的事情发生

### 无主引用以及隐式解析可选属性

- 两个属性的值都允许为nil，并会潜在的产生循环强引用。这种场景最适合用弱引用来解决
- 一个属性的值允许为nil，而另一个属性的值不允许为nil，并会潜在的产生循环强引用。这种场景最适合通过无主引用来解决
- 两个属性都必须有值，并且初始化完成后不能为nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性

```swift
class Country {
    let name: String
    let capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
```

```swift
class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
```

在类型结尾处加上感叹号（City!）的方式，将Country的capitalCity属性声明为隐式解析可选类型的属性。这表示像其他可选类型一样，capitalCity属性的默认值为nil，但是不需要展开它的值就能访问它

### 解决闭包引起的循环强引用

> Swift
> 有如下要求：只要在闭包内使用self的成员，就要用self.someProperty或者self.someMethod（而不只是someProperty或someMethod）。这提醒你可能会不小心就捕获了self

捕获列表中的每个元素都是由weak或者unowned关键字和实例的引用（如self或someInstance）成对组成。每一对都在方括号中，通过逗号分开

```swift
@lazy var someClosure: (Int, String) -> String = {
    [unowned self] (index: Int, stringToProcess: String) -> String in
    // closure body goes here
}
```

```swift
@lazy var someClosure: () -> String = {
    [unowned self] in
    // closure body goes here
}
```

当闭包和捕获的实例总是互相引用时并且总是同时销毁时，将闭包内的捕获定义为无主引用。

相反的，当捕获引用有时可能会是nil时，将闭包内的捕获定义为弱引用

 ## 扩展

Swift 中的扩展可以：

- 添加计算型属性和计算静态属性
- 定义实例方法和类型方法
- 提供新的构造器
- 定义下标
- 定义和使用新的嵌套类型
- 使一个已有类型符合某个协议

扩展能向类中添加新的便利构造器，但是它们不能向类中添加新的指定构造器或析构函数。指定构造器和析构函数必须总是由原始的类实现来提供

如果你使用扩展向一个值类型添加一个构造器，在该值类型已经向所有的存储属性提供默认值，而且没有定义任何定制构造器（custom initializers）时，你可以在值类型的扩展构造器中调用默认构造器(default initializers)和逐一成员构造器(memberwise initializers)

下面的例子定义了一个用于描述几何矩形的定制结构体Rect。这个例子同时定义了两个辅助结构体Size和Point，它们都把0.0作为所有属性的默认值：
```swift
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
```

因为结构体Rect提供了其所有属性的默认值，所以正如默认构造器中描述的，它可以自动接受一个默认的构造器和一个成员级构造器。这些构造器可以用于构造新的Rect实例：

```swift
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))
```

## 协议

协议可以规定其遵循者提供特定名称与类型的实例属性(instance property)或类属性(type property)，而不管其是存储型属性(stored property)还是计算型属性(calculate property)。此外也可以指定属性是只读的还是可读写的

如果协议要求属性是可读写的，那么这个属性不能是常量存储型属性或只读计算型属性；如果协议要求属性是只读的(gettable)，那么计算型属性或存储型属性都能满足协议对属性的规定，在你的代码中，即使为只读属性实现了写方法(settable)也依然有效

```swift
protocol SomeProtocol {
    var musBeSettable : Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}
```

如果协议中的实例方法打算改变其遵循者实例的类型，那么在协议定义时需要在方法前加mutating关键字，才能使结构体，枚举来采用并满足协议中对方法的规定

> 注意:
> 用类实现协议中的mutating方法时，不用写mutating关键字;用结构体，枚举实现协议中的mutating方法时，必须写mutating关键字

尽管协议本身并不实现任何功能，但是协议可以被当做类型来使用。使用场景:

- 协议类型作为函数、方法或构造器中的参数类型或返回值类型
- 协议类型作为常量、变量或属性的类型
- 协议类型作为数组、字典或其他容器中的元素类型

## 幽灵一般的 Optional
<a name="幽灵一般的Optional"></a>

在声明时，我们可以通过在类型后面加一个`?`来将变量声明为`Optional`的。如果不是`Optional`的变量，那么它就必须有值。而如果没有值的话，我们使用`Optional`并且将它设置为`nil`来表示没有值

```swift
// num 不是一个 Int
var num: Int?  
// num 没有值
num = nil  // nil  
// num 有值
num = 3    // {Some 3}
```

在声明类型时的这个`?`仅仅只是Apple为了简化写法而提供的一个语法糖。实际上我们是有 Optional 类型的声明，就这里的num为例，最正规的写法应该是这样的：

```swift
// 真 Optional 声明和使用
var num: Optional<Int>  
num = Optional<Int>()  
num = Optional<Int>(3)

`num`不是`Int`类型，它是一个`Optional`类型

```swift
enum Optional<T> : LogicValue, Reflectable {  
    case None
    case Some(T)
    init()
    init(_ some: T)

    /// Allow use in a Boolean context.
    func getLogicValue() -> Bool

    /// Haskell's fmap, which was mis-named
    func map<U>(f: (T) -> U) -> U?
    func getMirror() -> Mirror
}
```

`Optional`是一个泛型枚举enum，而其实我们在使用这个枚举时，如果没有值，我们就规定这个枚举的是.None，如果有，那么它就是Some(value)，而这个枚举又恰好实现了LogicValue 接口，这也就是为什么我们能使用 if 来对一个 Optinal的值进行判断并进一步进行 unwrap 的依据

```swift
var num: Optional<Int> = 3  
if num {       //因为有 LogicValue，  
               //.None 时 getLogicValue() 返回 false
               //.Some 时返回 true
   var realInt = num!
   realInt     //3
}
```

> 猫神叮嘱：Swift 里的 nil 和 objc 里的 nil 完全不是一回事儿。objc 的 nil 是一个实实在在的指针，它指向一个空的对象。而这里的 nil 虽然代表空，但它只是一个语意上的概念，确是有实际的类型的

```swift
// A null sentinel value.
var nil: NilType { get } 
```

nil 其实只是 NilType 的一个变量，而且这个变量是一个 getter，nil 其实只是一个 null的标记值

我们在声明或者赋值一个 Optional 的变量时，? 语法糖做的事情就是声明一个Optional<T>，然后查看等号右边是不是 nil 这个标记值。如果不是，则使用 init(_some: T) 用等号右边的类型 T 的值生成一个 .Some 枚举并赋值给这个 Optional变量；如果是 nil，将其赋为 None 枚举

Apple 推荐我们在 unwrap 的时候使用一种所谓的隐式方法，即下面这种方式来 unwrap：

```swift
var num: Int? = 3  
if let n = num {  
    //have a num
} else {
    //no num
}
```

这样隐式调用足够安全，性能上似乎应该也做优化，推荐在unwrap 的时候尽可能写这样的推断，而减少直接进行 unwrap 这种行为

## `?`和`!`的用法
<a name="?和!的用法"></a>

- `?` 放在类型后面作为 Optional 类型的标记

```swift
var num: Int? = nil        //声明一个 Int 的 Optional，并将其设为啥都没有  
var str: String? = "Hello" //声明一个 String 的 Optional，并给它一个字符串  
```

- `?` 放在某个 Optional 变量后面，表示对这个变量进行判断，并且隐式地 unwrap

```swift
foo?.somemethod()  
```
上面的写法等价于：

```swift
if let maybeFoo = foo {  
    maybeFoo.somemethod()
}
```

```swift
if let upper = john.residence?.address?.buildingIdentifier()?.uppercaseString {  
    println("John's uppercase building identifier is \(upper).")
}
```

最后`buildingIdentifier`后面的问号是在`()`之后的，这代表了这个`Optional`的判断对象是`buildingIdentifier()`的返回值

- `?` 放在某个 optional 的 protocol 方法的括号前面，以表示询问是否可以对该方法调用

```swift
delegate?.questionViewControllerDidGetResult?(self, result)  
```

在 Swift 中，默认的 potocol 类型是没有
optional的方法的，声明一个带有可选方法的接口时，必须要在声明 protocol
时再其前面加上 `@objc` 关键字，并在可选方法前面加上 `@optional`：

```swift
@objc protocol CounterDataSource {
    @optional func optionalMethod() -> Int
    func requiredMethod() -> Int
    @optional var optionalGetter: Int { get }
}
```

- `!` 放在 Optional 变量的后面，表示强制的 unwrap 转换：

```swift
foo!.somemethod()  
```

这将会使一个 Optional<T> 的量被转换为 T。但是需要特别注意，如果这个 Optional的量是 nil 的话，这种转换会在运行时让程序崩溃

- `!` 放在类型后面，表示强制的隐式转换

`?` 声明的是 Optional，而 `!` 其实声明的是一个 `ImplicitlyUnwrappedOptional` 类型

```swift
struct ImplicitlyUnwrappedOptional<T> : LogicValue, Reflectable {  
    var value: T?
    //...
    static var None: T! { get }
    static func Some(value: T) -> T!
    //...
}
```

Optional 需要我们手动进行进行 unwrap，而 `ImplicitlyUnwrappedOptional`则会在使用的时候自动地去unwrap，并对继续之后的操作调用，而不必去增加一次手动的显示/隐式操作

