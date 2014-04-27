# ARC

## MRC总结:
> 如果需要持有一个对象，那么对其发送`retain` 如果之后不再使用该对象，那么需要对其发送`release`（或者`autorealse`） 每一次对`retain`,`alloc`或者`new`的调用，需要对应一次`release`或`autorealse`调用

- - - 

## ARC的基本规则：
> **只要某个对象被任一`strong`指针指向，那么它将不会被销毁。如果对象没有被任何strong指针指向，那么就将被销毁。**

在默认情况下，所有的实例变量和局部变量都是strong类型的。可以说strong类型的指针在行为上和MRC时代retain的property是比较相似的。

在大部分情况下，weak类型的指针可能并不会很常用。比较常见的用法是在两个对象间存在包含关系时：对象1有一个strong指针指向对象2，并持有它，而对象2中只有一个weak指针指回对象1，从而避免了循环持有

	__weak NSString *str = [[NSString alloc] initWithFormat:…];
	NSLog(@"%@",str); //输出是"(null)"
由于str是weak，它不会持有alloc出来的NSString对象，因此这个对象由于没有有效的strong指针指向，所以在生成的同时就被销毁了。

property也可以用strong或weak来标记，简单地把原来写retain和assign的地方替换成strong或者weak就可以了。
```
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, weak) id  delegate;
```

- - - 

ARC确实可以在适当的地方为代码添加retain或者release，但是你必须在合适的地方把strong指针手动设置到nil

**你必须时刻清醒谁持有了哪些对象，而这些持有者在什么时候应该变为指向nil。**
**将实例变量写在头文件中是一种遗留的陋习**

dealloc:
- 对非ARC管理的内存进行管理和必要的逻辑操作的时候，还是应该保留dealloc的
- 对于retain的CF对象要CFRelease()，对于malloc()到堆上的东西要free()掉
- 对于添加的observer可以在这里remove，schedule的timer在这里invalidate
- [super dealloc]这个消息也不再需要发了，ARC会自动帮你搞定。

- - -

property的关键字类型:

- strong 和原来的retain比较相似，strong的property将对应__strong的指针，它将持有所指向的对象
- weak 不持有所指向的对象，而且当所指对象销毁时能将自己置为nil，基本所有的outlet都应该用weak
- unsafe_unretained 这就是原来的assign。当需要支持iOS4时需要用到这个关键字
- copy 和原来基本一样..copy一个对象并且为其创建一个strong指针
- assign 对于对象来说应该永远不用assign了，实在需要的话应该用unsafe_unretained代替(基本找不到这种时候，大部分assign应该都被weak替代)。但是对于基本类型比如int,float,BOOL这样的东西，还是要用assign。
- 特别地，对于NSString对象，在MRC时代很多人喜欢用copy，而ARC时代一般喜欢用strong

当在涉及CF层的东西时，如果函数名中有含有Create, Copy, 或者Retain之一，就表示返回的对象的retainCount+1了，对于这样的对象，最安全的做法是将其放在CFBridgingRelease()里，来平衡retain和release。

- - -

## 配置ARC和MRC混合使用

- MRC: target -> build phase -> compile -> -fno-objc-arc
- ARC:  target -> build phase -> compile -> -fobjc-arc


ARC使用基本规则

- 代码中不能使用retain, release, retain, autorelease
- 不重载dealloc（如果是释放对象内存以外的处理，是可以重载该函数的，但是不能调用[super dealloc]）
- 不能使用NSAllocateObject, NSDeallocateObject
- 不能在C结构体中使用对象指针
- id与void *间的如果cast时需要用特定的方法（__bridge关键字）
- 不能使用NSAutoReleasePool、而需要@autoreleasepool块
- 不能使用“new”开始的属性名称 （如果使用会有下面的编译错误”Property’s synthesized getter follows Cocoa naming convention for returning ‘owned’ objects”）

## ARC 严格遵守 Objective-C 内存管理的基本原则

- 自己生成的对象，那么既是其持有者
- 不是自己生成的对象，也可成为其持有者（一个对象可以被多个人持有）
- 如果不想持有对象的时候，必须释放其所有权
- 不能释放已不再持有所有权的对象

**用 __strong 修饰的变量，以及缺省隐藏的 __strong 情况**
```
{
    /*
     * 生成对象并拥有所有权
     */
    id __strong obj = [[NSObject alloc] init];

    /*
     * 自己一直是持有对象状态
     */
}
    /*
     * 变量出生命周期时，失去全部所有者，对象内存空间被释放
     */
```

这种情况毫无悬念，缺省使用 alloc/new/copy/mutableCopy 开头的函数也是这样的结果。并且在这里，编译器帮我们自动的调用了对象的 release 函数，不需要手工维护。再看看下面的情况。

```
{
    /*
     * 生成对象但是并没有其所有权
     */
    id __strong obj = [NSMutableArray array];

    /*
     * 由于变量声明是强引用，自己一直是持有对象状态
     * 编译器根据函数名，再将该对象放入 autoreleasepool 中
     */
}
    /*
     * 变量出生命周期时，失去全部所有者，对象内存空间被释放
     */
```

由上，虽然不是用 alloc/new/copy/mutableCopy 开头的函数得到的对象，由于是强参照，我们任然成为对象的持有者。而这，正是编译器帮我们做到的。

> 具体做的是什么呢？其实就是【对象在函数中返回时，使用return [[object retain] autorelease]】所描述的；如果你反汇编一下ARC生成的代码，可以看到这时会自动调用名为 objc_retainAutoreleaseReturnValue 的函数，而其作用和 [[object retain] autorelease] 一致。编译器通过函数名分析，如果不是  alloc/new/copy/mutableCopy 开头的函数，自动加入了这段代码。

**当一个 __weak 所指对象被释放时，系统按下面步骤来处理**

- 从weak表中，通过对象地址（key）找到entry
- 将entry中所有指向该对象的变量设为nil
- 从weak表中删除该entry
- 从对象引用计数表中删除对象entry(通过通过对象地址找到)

**另外，当使用 __weak 修饰的变量的时候，变量将放入 autoreleasepool 中，并且用几次放几次**

```
{
    id __weak o = obj;
    NSLog(@"1 %@", o);
    NSLog(@"2 %@", o);
    NSLog(@"3 %@", o);
    NSLog(@"4 %@", o);
    NSLog(@"5 %@", o);
}
```	

这里我们用了5次，那么pool中就被登录了5次；从效率上考虑这样当然不是很好，可以通过代入 __strong 修饰的强参照变量来避开这个问题


```
{
    id __weak o = obj;
    id temp = o;
    NSLog(@"1 %@", temp);
    NSLog(@"2 %@", temp);
    NSLog(@"3 %@", temp);
    NSLog(@"4 %@", temp);
    NSLog(@"5 %@", temp);
}
```

> 为什么使用弱参照变量的时候，要将其放入 autoreleasepool 中呢？想想弱参照的定义就应该明白了 —- 如果在访问弱参照对象时，该对象被释放了怎么办，程序不就崩溃了嘛；所以为了解决该问题，又再一次用到了 pool。