# OC语法

- [一句话知识点](#一句话知识点)
- [代码规范](#代码规范)
	- [变量](#变量)
	- [命名](#命名)
	- [init与dealloc](#init与dealloc)
	- [字面值](#字面值)
	- [方法命名](#方法命名)
- [引用计数](#引用计数)
- [自动引用计数](#自动引用计数)
	- [MRC总结](#手动内存管理总结)
	- [ARC的基本规则](#自动内存管理的基本规则)
	- [property的关键字类型](#property的关键字类型)
	- [配置ARC和MRC混合使用](#配置arc和mrc混合使用)
	- [ARC使用基本规则](#自动内存管理使用基本规则)
	- [ARC严格遵守OC内存管理的基本原则](#arc严格遵守oc内存管理的基本原则)
- [cocoa内存管理规则](#cocoa内存管理规则)
- [属性总结](#属性总结)
- [class关键字](#class关键字)
- [category](#category)
- [protocol](#protocol) 
- [block](#block)
- [appDelegate](#appdelegate)
- [键盘弹出和收起](#键盘弹出和收起)
- [检测网络状况](#检测网络状况)
- [判断设备](#判断设备)
- [objective-c数据类型](#objective-c数据类型)
- [字符串NSString](#字符串)
	- [字符串对象初始化](#字符串对象初始化)
	- [字符串长度获取](#字符串长度获取)
	- [获取字符串的子串](#获取字符串的子串)
	- [字符串的导出](#字符串的导出)
	- [字符串的比较](#字符串的比较)
	- [类型的转换](#类型的转换)
	- [可变字符串](#可变字符串)
	- [编码的转换](#编码的转换)
	- [文本大小自适应](#文本大小自适应)
- [数组NSArray](#数组)
	- [数组的简化](#数组简化) 
	- [可变数组](#可变数组)
- [字典NSDictionary](#字典)
	- [常用方法](#常用方法)
	- [可变字典](#可变字典)
	- [字典与数组的联合使用](#字典与数组的联合使用)
- [NSDictionary、NSData、JSON数据类型相互转换](#dictionary、data、json数据类型相互转换)
	- [NSDictionary类型转换为NSData类型](#dictionary类型转换为data类型)
	- [NSData类型转换为NSDictionary类型](#data类型转换为dictionary类型)
	- [NSDictionary转换为JSON数据类型](#dictionary转换为json数据类型)
	- [JSON转换为OC对象](#json转换为oc对象)
	- [OC对象转换为JSON](#oc对象转换为json)
- [集NSSet](#集)
- [单例Singleton](#singleton)
	- [典型的单例写法](#典型的单例写法)
	- [加锁的写法](#加锁的写法)
	- [第一次实例化创建](#第一次实例化创建)
	- [GCD写法](#gcd写法)
	- [完整写法](#完整写法)
- [文件管理器NSFileManager](#文件管理器)
- [文件句柄NSFileHandle](#文件句柄)
- [Archiver归档](#archiver)
- [沙盒Sandbox](#sandbox)


# 一句话知识点

- 点语法的本质是getter/setter方法调用于
- setter/getter里面不能使用self，会造死循环
- SEL其实是对方法的一种包装，将方法包装成一个SEL类型的数据，去找对应的方法地址。找到地址就可以调用方法。其实消息就是SEL
- 僵尸对象：所占用内存已经被回收的对象，僵尸对象不能再使用
- 野指针：指向僵尸对象(不可用内存)的指针，给野指针发消息会报错(EXEC_BAD_ACCESS)
- 空指针：没有指向任何东西的指针(存的东西是0, NULL, nil)，给空指针发消息不报错
- BOOL类型property一般指定getter方法格式为isMethod, e.g.:@property (getter=isRich) BOOL rich;
- 当一个对象调用autorelease方法时，会将整个对象方放到栈顶的释放池 
- `创建对象时不要直接调用类名，一般用self`.e.g.

        + (id)person {
        	return [[[self alloc] init] autorelease];
        }

- 类的本质是对象。是Class类型的对象，简称类对象。 `typedef struct objc_class *Class`. 类名就代表着类对象，每个类只有一个类对象
- NSUserDefaults 里面不能够存储UIViewController实例或者其示例数组
- 创建视图控制器的时候，最好不要在初始化方法中做与视图相关的操作(getter)，可能引发循环调用

***

# 代码规范

## 变量

- 变量的命令应尽量做到自描述。除了在for()循环语句中，单字母的变量应该避免使用（如i,j,k等）。一般循环语句的当前对象的命名前缀包括“one”、“a/an”。对于简单的单个对象使用“item”命名.

- 尽量的使用属性而非实例变量。除了在初始化方法（init，initWithCoder：等）、dealloc方法以及自定义setter与getter方法中访问属性合成的实例变量，其他的情况使用属性进行访问。

## 命名

- 对于NSString、NSArray、NSNumber或BOOL类型，变量的命名一般不需要表明其类型。
- 如果变量不是以上基本常用类型，则变量的命名就应该反映出自身的类型。但有时仅需要某些类的一个实例的情况下，那么只需要基于类名进行命名。
- 大部分情况下，NSArray或NSSet类型的变量只需要使用单词复数形式（比如mailboxes），不必在命名中包含“mutable”。如果复数变量不是NSArray或NSSet类型，则需要指定其类型。

## init与dealloc

- dealloc方法应该被放置在实现方法的顶部，直接在@synthesize或@dynamic语句之后。init方法应该被放置在dealloc方法的下面。

## 字面值

对于NSString，NSDictionary，NSArray和NSNumber类，当需要创建这些类的不可变实例时，应该使用这些类的字面值表示形式。使用字面值表示的时候nil不需要传入NSArray和NSDictionary中作为字面值。这些种语法兼容老的iOS版本，因此可以在iOS5或者更老的版本中使用它。

良好的风格：

	NSArray *names = @[@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul"];
	NSDictionary *productManagers = @{@"iPhone" : @"Kate", @"iPad" : @"Kamal", @"Mobile Web" : @"Bill"};	
	NSNumber *shouldUseLiterals = @YES;
	NSNumber *buildingZIPCode = @10018;555
 
不良的风格：

	NSArray *names = [NSArray arrayWithObjects:@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul", nil];
	NSDictionary *productManagers = [NSDictionary dictionaryWithObjectsAndKeys: @"Kate", @"iPhone", @"Kamal", @"iPad", @"Bill", @"Mobile Web", nil];	
	NSNumber *shouldUseLiterals = [NSNumber numberWithBool:YES];
	NSNumber *buildingZIPCode = [NSNumber numberWithInteger:10018];

如非必要，避免使用特定类型的数字（相较于使用5.3f，应使用5.3）。

***

## 方法命名

- 一个方法的命名首先描述返回什么，接着是什么情况下被返回。方法签名中冒号的前面描述传入参数的类型。以下类方法和实例方法命名的格式语法：

        [object/class thing+condition];
        [object/class thing+input:input];
        [object/class thing+identifer:input];

- Cocoa命名举例：

    	realPath    = [path     stringByExpandingTildeInPath];
    	fullString  = [string   stringByAppendingString:@"Extra Text"]
    	object      = [array    objectAtIndex:3];
    	// 类方法
    	newString   = [NSString stringWithFormat:@"%f",1.5];
    	newArray    = [NSArray  arrayWithObject:newString];

- 良好的自定义方法命名风格：

    	recipients  = [email    recipientsSortedByLastName];
    	newEmail    = [CDCEmail emailWithSubjectLine:@"Extra Text"];
    	emails      = [mailbox  messagesReceivedAfterDate:yesterdayDate];

- 当需要获取对象值的另一种类型的时候，方法命名的格式语法如下：

    	[object adjective+thing];
    	[object adjective+thing+condition];
    	[object adjective+thing+input:input];
 
- 良好的自定义方法命名风格：

    	capitalized = [name    capitalizedString];
    	rate        = [number  floatValue];
    	newString   = [string  decomposedStringWithCanonicalMapping];
    	subarray    = [array   subarrayWithRange:segment];

- 方法签名尽量做到含义明确。
- 是否相等

	 `- (BOOL)isEqualToString:(NSString *)str;`

- 比较大小 

	`- (NSComparisonResult)compare:(NSString *)str;`

- 转换大小写

    	-(NSString *)uppercaseString;
    	-(NSString *)lowercaseString;

***

# 引用计数

- `消息涉及到对成员变量操作的时候考虑retain/copy`
- 哪些方法对成员变量操作？init、setter、类似setter
- setter/init与dealloc相对应。对象初始化(创建)便retain，对象不需要的时候就release
- 有一个+1(retain/alloc/new/copy/mutableCopy)就对应一个-1(release)
- 为什么需要retain/copy？因为当前消息中用到的成员变量在其他方法种也可能需要调用，如果在当前方法中release了，那么-1就可能销毁数据了，其他方法种就出现了访问野指针。所以持有对象+1，对其他方法种不会照成干扰

		void test(Student *stu)  {
		    Book *book = [[Book alloc] initWithPrice:3.5];
		    stu.book = book; // 如果没有retain.等效于_book = book;
		    [book release];
		}
	
		void test1(Student *stu) {
		    [stu readBook];
		}
	
		int main(int argc, const char * argv[]) {
			Student *stu = [[Student alloc] initWithAge:10];
			test(stu); //book:0
			test1(stu); // 调用book，野指针错误
			[stu release];
		    return 0;
		}
    
    	// Student.m
    	- (void)readBook {
    		NSLog(@"read %@", _book)
    	} 					
	
- 创建对象时尽量使用autorelease

	- 创建临时对象时,尽量同时在同一行中 autorelease 掉,而非使用单独的 release 语句

	- 虽然这样会稍微有点慢,但这样可以阻止因为提前 return 或其他意外情况导致的内存泄露。通盘来看这是值得的。如:
		
			// 避免这样使用(除非有性能的考虑)
			MyController* controller = [[MyController alloc] init];
			// ... 这里的代码可能会提前return ...
			[controller release];
			// 这样更好
			MyController* controller = [[[MyController alloc] init] autorelease];

***

# 自动引用计数

**ARC的判断准则：只要没有指针指向对象，就会释放对象**

- 指针分2种：强指针和弱指针
- 默认情况下，所有指针都是强指针
    
**ARC的特点：**

- 不允许调用release、retain、retainCount方法
- 允许重写dealloc、但是不允许调用[super dealloc]
- @property的参数
    - strong: 相当于retain(适用于OC对象类型)
    - weak: 相当于assign(适用于OC对象类型)
    - assign: 适用于非OC对象类型
    - MRC的retain改为strong(循环引用的时使用：一端用strong，一端用weak)

## 手动内存管理总结

> 如果需要持有一个对象，那么对其发送`retain` 如果之后不再使用该对象，那么需要对其发送`release`（或者`autorealse`） 每一次对`retain`,`alloc`或者`new`的调用，需要对应一次`release`或`autorealse`调用

## 自动内存管理的基本规则

> **只要某个对象被任一`strong`指针指向，那么它将不会被销毁。如果对象没有被任何strong指针指向，那么就将被销毁。**

在默认情况下，所有的实例变量和局部变量都是strong类型的。可以说strong类型的指针在行为上和MRC时代retain的property是比较相似的。

在大部分情况下，weak类型的指针可能并不会很常用。比较常见的用法是在两个对象间存在包含关系时：对象1有一个strong指针指向对象2，并持有它，而对象2中只有一个weak指针指回对象1，从而避免了循环持有

	__weak NSString *str = [[NSString alloc] initWithFormat:…];
	NSLog(@"%@",str); //输出是"(null)"
由于str是weak，它不会持有alloc出来的NSString对象，因此这个对象由于没有有效的strong指针指向，所以在生成的同时就被销毁了。

property也可以用strong或weak来标记，简单地把原来写retain和assign的地方替换成strong或者weak就可以了。

    @property (nonatomic, strong) NSString *firstName;
    @property (nonatomic, weak) id  delegate;

ARC确实可以在适当的地方为代码添加retain或者release，但是你必须在合适的地方把strong指针手动设置到nil

**你必须时刻清醒谁持有了哪些对象，而这些持有者在什么时候应该变为指向nil。**
**将实例变量写在头文件中是一种遗留的陋习**

dealloc:

- 对非ARC管理的内存进行管理和必要的逻辑操作的时候，还是应该保留dealloc的
- 对于retain的CF对象要CFRelease()，对于malloc()到堆上的东西要free()掉
- 对于添加的observer可以在这里remove，schedule的timer在这里invalidate
- [super dealloc]这个消息也不再需要发了，ARC会自动帮你搞定。

# property的关键字类型

- strong 和原来的retain比较相似，strong的property将对应__strong的指针，它将持有所指向的对象
- weak 不持有所指向的对象，而且当所指对象销毁时能将自己置为nil，基本所有的outlet都应该用weak
- unsafe_unretained 这就是原来的assign。当需要支持iOS4时需要用到这个关键字
- copy 和原来基本一样..copy一个对象并且为其创建一个strong指针
- assign 对于对象来说应该永远不用assign了，实在需要的话应该用unsafe_unretained代替(基本找不到这种时候，大部分assign应该都被weak替代)。但是对于基本类型比如int,float,BOOL这样的东西，还是要用assign。
- 特别地，对于NSString对象，在MRC时代很多人喜欢用copy，而ARC时代一般喜欢用strong

当在涉及CF层的东西时，如果函数名中有含有Create, Copy, 或者Retain之一，就表示返回的对象的retainCount+1了，对于这样的对象，最安全的做法是将其放在CFBridgingRelease()里，来平衡retain和release。

## 配置arc和mrc混合使用

- MRC: target -> build phase -> compile -> -fno-objc-arc
- ARC:  target -> build phase -> compile -> -fobjc-arc

## 自动内存管理使用基本规则

- 代码中不能使用retain, release, retain, autorelease
- 不重载dealloc（如果是释放对象内存以外的处理，是可以重载该函数的，但是不能调用[super dealloc]）
- 不能使用NSAllocateObject, NSDeallocateObject
- 不能在C结构体中使用对象指针
- id与void *间的如果cast时需要用特定的方法（__bridge关键字）
- 不能使用NSAutoReleasePool、而需要@autoreleasepool块
- 不能使用“new”开始的属性名称 （如果使用会有下面的编译错误”Property’s synthesized getter follows Cocoa naming convention for returning ‘owned’ objects”）

## arc严格遵守oc内存管理的基本原则

- 自己生成的对象，那么既是其持有者
- 不是自己生成的对象，也可成为其持有者（一个对象可以被多个人持有）
- 如果不想持有对象的时候，必须释放其所有权
- 不能释放已不再持有所有权的对象

**用 __strong 修饰的变量，以及缺省隐藏的 __strong 情况**

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

这种情况毫无悬念，缺省使用 alloc/new/copy/mutableCopy 开头的函数也是这样的结果。并且在这里，编译器帮我们自动的调用了对象的 release 函数，不需要手工维护。再看看下面的情况。

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

由上，虽然不是用 alloc/new/copy/mutableCopy 开头的函数得到的对象，由于是强参照，我们任然成为对象的持有者。而这，正是编译器帮我们做到的。

> 具体做的是什么呢？其实就是【对象在函数中返回时，使用return [[object retain] autorelease]】所描述的；如果你反汇编一下ARC生成的代码，可以看到这时会自动调用名为 objc_retainAutoreleaseReturnValue 的函数，而其作用和 [[object retain] autorelease] 一致。编译器通过函数名分析，如果不是  alloc/new/copy/mutableCopy 开头的函数，自动加入了这段代码。

**当一个 __weak 所指对象被释放时，系统按下面步骤来处理**

- 从weak表中，通过对象地址（key）找到entry
- 将entry中所有指向该对象的变量设为nil
- 从weak表中删除该entry
- 从对象引用计数表中删除对象entry(通过通过对象地址找到)

**另外，当使用 __weak 修饰的变量的时候，变量将放入 autoreleasepool 中，并且用几次放几次**

    {
        id __weak o = obj;
        NSLog(@"1 %@", o);
        NSLog(@"2 %@", o);
        NSLog(@"3 %@", o);
        NSLog(@"4 %@", o);
        NSLog(@"5 %@", o);
    }

这里我们用了5次，那么pool中就被登录了5次；从效率上考虑这样当然不是很好，可以通过代入 __strong 修饰的强参照变量来避开这个问题

    {
        id __weak o = obj;
        id temp = o;
        NSLog(@"1 %@", temp);
        NSLog(@"2 %@", temp);
        NSLog(@"3 %@", temp);
        NSLog(@"4 %@", temp);
        NSLog(@"5 %@", temp);
    }

> 为什么使用弱参照变量的时候，要将其放入 autoreleasepool 中呢？想想弱参照的定义就应该明白了 —- 如果在访问弱参照对象时，该对象被释放了怎么办，程序不就崩溃了嘛；所以为了解决该问题，又再一次用到了 pool。

***

## cocoa内存管理规则

- 使用alloc、new、copy、mutableCopy生成的对象需要手动释放，这些对象成为堆上的对象
- 使用以上4种方法以外的方法（遍历初始化）生成的对象，默认retainCount为1，并且设置为自动释放，这些对象可以称作栈上的临时对象，局部变量、方法或者函数传参
- 使用retain方法持有的对象，需要手动release进行释放，并且保持retain以及release次数想相同
- 集合类可以持有集合中的对象(retain一次)，当集合对象自身销毁时，会将自身中的所有对象release一次
- 持有集合类，不会增加内部对象的引用计数值
- set/init里面retain与dealloc里面release相对应。

***

## 属性总结

- assign:直接赋值，简单、复杂数据类型、SEL(@selector()) 默认属性 避免循环引用(无法释放对象) --delegate:委托、代理设计模式
- retain:引用计数值+1，适用于对象对象
- copy:适用于对象，复制，用于NSString,深度复制，retain不加1，对原值release一次
- readonly:只生成getter
- readwrite:默认属性，生成getter,setter
- noatomic：线程不安全
- atomic:默认，线程安全
- strong:ARC，强引用
- weak:ARC,弱引用
- __ussafe_unretained:类似于assign
- getter =:规定getter方法的名称
- **copy:不可变复制，对可变对象复制是深度复制，其它时候一律浅复制**
- **mutableCopy:可变深度复制**
- 不可变的对象 通过 copy 不可变的
- 不可变的对象 通过 mutablecopy 可变的
- 可变的对象   通过 mutablecopy 可变的
- 可变的对象   通过 copy 不可变的

***

## class关键字

- 在.h文件中用@class来声明类，仅仅是告诉编译器，某个名称是一个类
- 在.m文件中用#import来包含类的所有内容
- 两端循环引用解决方案：一端用retain, 一端用assign

***

# category

- 类别声明可以和需要扩展的类写在同一个.h文件中，写在原声明后面，实现文件同理
- 类别是不能为类声明实例变量的。而只能包含方法。但是，所有类作用域中的实例变量同样也在类别的作用域中。包括类声明的所有实例变量，甚至那些声明为 @private 的。
- 你可为一个类添加的类别的数量没有限制，但是每个类别名必须是唯一的，并且每个类别应当声明/定义不同的方法。
- 类扩展就像匿名的类别，除了扩展中声明的方法必须在主 @implementation 块中实现。使用 Clang/LLVM 2.0 编译器时，你还可以在一个类扩展中定义属性以及实例变量。
- 通常我们用类扩展来声明公有的只读属性和私有的读写属性。
- 类别可以实现原始类的方法，但不推荐这么做，因为它是直接替换原来的方法，这么做后果是再也无法访问原来的方法

***

# protocol

- 与java的接口类似
- @protocol与@class有一致的用法，提前声明，实现时，在.h文件中声明，在.m中导入
- 协议中方法声明关键字：@required(默认)、@optional(可选)
- 协议可以定义在单独的文件中，也可以定义在某个类中(这个协议只用在这个类中)，类别同理

***

# block

- 类似于java的匿名内部类

		int (^sum)(int, int) = ^(int a, int b) {
			return a + b;
		}
		
		int sum = sum(10, 2);
		NSLog(@"%i", sum); 
		typedef int (^mySum)(int, int);
		void test() {
			mySum sum = ^(int a, int b) {
				return a + b;
			}
			NSLog(@"%i"， sum(10, 2));
		}
	
- block可以访问外面定义的变量
- 如果外面的变量用__block声明，就可以在block内部修改
- block与指针函数的区别于联系

		// 定义了Sum这种Block类型
		typedef int (^Sum) (int, int);    
	    // 定义了sump这种指针类型，这种指针是指向函数的
	    typedef int (*Sump) (int, int);
	    // 定义了一个block变量
	    Sum sum1 = ^(int a, int b) {
	        return a + b;
		    };
	    
	    int c = sum1(10, 10);
	    NSLog(@"%i", c);
	    // 定义一个指针变量p指向sum函数
	    Sump p = sum;
	    // c = (*p)(9, 8);
	    c = p(9, 8);
	    NSLog(@"%i", c);

***

## appdelegate

	#pragma mark 程序加载完成,自定义界面加载，数据导入，初始化等
	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
	#pragma mark 程序将要失活，保存用户数据，断开网络连接,游戏暂停
	- (void)applicationWillResignActive:(UIApplication *)application;
	#pragma mark 程序进入后台,释放界面元素，视频，音频媒体，降低程序的驻留内存开销
	- (void)applicationDidEnterBackground:(UIApplication *)application;
	#pragma mark 程序进入前台，恢复界面，数据等
	- (void)applicationWillEnterForeground:(UIApplication *)application;	
	#pragma mark 程序激活，恢复用户数据，恢复网络连接
	- (void)applicationDidBecomeActive:(UIAppliction *)application;
	#pragma mark 程序结束
	- (void)applicationWillTerminate:(UIApplication *)application;

***

# 键盘弹出和收起

	#pragma mark - 处理键盘遮挡输入框
	- (void)registerForKeyboardNotifications {
	    
	    [[NSNotificationCenter defaultCenter] addObserver:self
	                                             selector:@selector(keyboardWasShow:)
	                                                 name:UIKeyboardWillShowNotification
	                                               object:nil];
	    [[NSNotificationCenter defaultCenter] addObserver:self
	                                             selector:@selector(keyboardWillBeHidden:)
	                                                 name:UIKeyboardWillHideNotification
	                                               object:nil];
	}

	- (void)keyboardWasShow:(NSNotification *)notification {
	    
	    NSDictionary *userInfo = [notification userInfo];
	    
	    // Get the origin of the keyboard when it's displayed.
	    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
	    
	    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
	    CGRect keyboardRect = [aValue CGRectValue];
	    
	    // Get the duration of the animation.
	    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
	    NSTimeInterval animationDuration;
	    [animationDurationValue getValue:&animationDuration];
	    
	    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
	    CGFloat moveHeight = keyboardRect.size.height;
	    [UIView animateWithDuration:animationDuration animations:^{
	        self.transform = CGAffineTransformMakeTranslation(0, -moveHeight);
	    } completion:^(BOOL finished) {
	    }];
	    
	    // call back
	    if (_keyboardDidShow) {
	        _keyboardDidShow(keyboardRect, animationDuration);
	    }
	}

	- (void)keyboardWillBeHidden:(NSNotification *)notification {
	    
	    NSDictionary *userInfo = [notification userInfo];
	    
	    /*
	     Restore the size of the text view (fill self's view).
	     Animate the resize so that it's in sync with the disappearance of the keyboard.
	     */
	    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
	    NSTimeInterval animationDuration;
	    [animationDurationValue getValue:&animationDuration];
	    [UIView animateWithDuration:animationDuration animations:^{
	        self.transform = CGAffineTransformIdentity;
	    } completion:^(BOOL finished) {
	    }];
	    
	    // call back
	    if (_keyboardDidRemove) {
	        _keyboardDidRemove(animationDuration);
	    }
	}

***

# 检测网络状况

－　方式一

*前提*

- 工程添加：`SystemConfiguration.framework` framework
- `#import "Reachability.h"` 

		-(BOOL) isConnectionAvailable { 
			
		    BOOL isExistenceNetwork = YES;  
		    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];  
		    switch ([reach currentReachabilityStatus]) {  
		        case NotReachable:  
		            isExistenceNetwork = NO;  
		            // NSLog(@"notReachable");  
		            break;  
		        case ReachableViaWiFi:  
		            isExistenceNetwork = YES;  
		            // NSLog(@"WIFI");  
		            break;  
		        case ReachableViaWWAN:  
		            isExistenceNetwork = YES;  
		            // NSLog(@"3G");  
		            break;  
		    }     
		    return isExistenceNetwork;  
		}  

- 方式二

`导入SystemConfiguration.framework,并#import<SystemConfiguration/SCNetworkReachability.h>`

	+ (BOOL)connectedToNetwork {
	    
	    // 创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
	    
	    struct sockaddr_storage zeroAddress;
	    
	    bzero(&zeroAddress, sizeof(zeroAddress));
	    zeroAddress.ss_len = sizeof(zeroAddress);
	    zeroAddress.ss_family = AF_INET;
	    
	    // Recover reachability flags
	    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	    SCNetworkReachabilityFlags flags;
	    
	    // 获得连接的标志
	    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	    CFRelease(defaultRouteReachability);
	    
	    // 如果不能获取连接标志，则不能连接网络，直接返回
	    if (!didRetrieveFlags) {
	        return NO;
	    }
		
	    // 根据获得的连接标志进行判断
	    BOOL isReachable = flags & kSCNetworkFlagsReachable;
	    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	    return (isReachable&&!needsConnection) ? YES : NO;
	}

***

# 判断设备

	// 设备名称
	return [UIDevice currentDevice].name;
	
	// 设备型号，只可得到是何设备，无法得到是第几代设备
	return [UIDevice currentDevice].model;
	
	// 系统版本型号,如iPhone OS
	return [UIDevice currentDevice].systemVersion;
	
	//系统版本名称，如6.1.3
	return [UIDevice currentDevice].systemName;
	
	//判断是否为iPhone
	\#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
	
	//判断是否为iPad
	\#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	
	//判断是否为ipod
	\#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
	
	//判断是否为iPhone5
	\#define IS_IPHONE_5_SCREEN [[UIScreen mainScreen] bounds].size.height >= 568.0f && [[UIScreen mainScreen] bounds].size.height < 1024.0f

***

# objective-c数据类型

- NSValue可以用来封装任意数据结构

	`(NSValue *)valueWithBytes:(const void *)value objCType:(const char *)type;`
		
- NSNumber类继承于NSValue，用来封装基本书数据类型，如，int, float等

	+ (NSNumber *)numberWithInt:(int)value;
	+ (NSNumber *)numberWithFloat:(float)value;
	+ (NSNumber *)numberWithChar:(char)value;
	+ (NSNumber *)numberWithBool:(BOOL)value;
		
- NSNull用来封装nil值

	`+ (NSNull *)null;`

- NSArray、NSSet和NSDictionary等容器只能存储对象，不能存储基本数据类型和结构体，也不能存储nil
- NSString、NSMutableString对字符串封装
- OC特殊数据类型：id, nil, SEL等 

***

# 字符串

## 字符串对象初始化

- 创建常量字符串

	`NSString *aString = @"This is a String";`
	
- 创建空字符串

		NSString *aString = [[String alloc] init];
		aString = @"This is a String";
- 提升速度的方法

	`NSString *aString = [[NSString alloc] initWithString:@"This is a String"];`
- 其他方法

		-(id)initWithFormat:(NSString *)format // 便利构造器
		-(id)initWithData:(NSData *) encoding:(NSStringEncoding) encoding;
		// 通过一个c字符串得到一个新字符串
		-(id)initWithCString(const char *)cString encoding:(NSStringEncoding)encoding;
- e.g.

		   NSString *s1 = @"Jack";
		   NSString *s2 = [[NSString alloc] initWithString:@"Jack"];
		   NSString *s3 = [[NSString alloc] initWithFormat:@"my age is %d", 10];
		   NSString *s4 = [[NSString alloc] initWithUTF8String:"Lucy"]; // c字符串 --> OC字符串
		   NSString *s5 = [[NSString alloc] initWithContentsOfFile:@"/Users/cuan/Desktop/1.txt" encoding:NSUTF8StringEncoding error:nil];
		   NSString *s6 = [[NSString alloc] initWithContentsOfURL:@"file:///Users/cuan/demo.txt" encoding:NSUTF8StringEncoding error:nil];
    
## 字符串长度获取
		
- 字符串长度获取

	`-(NSInteger)length;`

## 获取字符串的子串

- 拼接字符串

		- (NSString *)stringByAppendingString:(NSString *)aString;
		- (NSString *)stringByAppendingFormat:(NSString *)format....

- 获取字符串的子串

		- (NSString *)substringFromIndex:(NSUInteger)from;
		- (NSString *)substring;ToIndex:(NSUInteger)to;
		- (NSString *)substringWithRang:(NSRang)rang;

- 字符串是否包含别的字符串

		-(BOOL)hasPrefix:(NSString *)aString;
		-(BOOL)hasSuffix:(NSString *)aString;
		-(NSRang)rangeOfString:(NSString *)aString;

## 字符串的导出

	   [@"Hello,world" writeToFile:@"/User/cuan/echo.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];
	   
	   NSURL *url = [NSURL fileURLWithPath:@"/Users/cuan/echo.txt"];
	   [@"hello, every one" writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];

## 字符串的比较

- 是否相等

	`- (BOOL)isEqualToString:(NSString *)str;`
		
- 比较大小

	`- (NSComparisonResult)compare:(NSString *)str;`

- 转换大小写

		- (NSString *)uppercaseString;
		- (NSString *)lowercaseString;

## 类型的转换

	- (double)doubleValue;
	- (float)floatValue;
	- (int)intValue;
	- (NSInteger)integerValue;
	- (long long)longlongValue;
	- (BOOL)boolValue;
	- (double)doubelValue
	- (id)initWithFormat:(NSString *)format....
 
## 可变字符串

	-(id)initWithCapacity:(NSUInteger)capacity;
	+(id)stringWithCapacity:(NSUInteger)capacity;
	-(void)insertString:(NSString *)aString atIndex:(NSUInteger)loc;
	-(void)deleteCharactersInRang:(NSRange)range;
	-(void)appendString:(NSString *)aString;
	-(void)appendFormat:(NSString *)format, ....
	-(void)setString:(NSString)aString;

## 编码的转换
	
	NSStringEncoding utf8Encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
	NSStringEncoding isoEncoding= CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
	NSData *isoStr = [obj dataUsingEncoding:isoEncoding];
	NSString *utf8Str = [[NSString alloc] initWithData:isoStr encoding:utf8Encoding];

## 文本大小自适应

	@implementation NSString (CalculateSize)
	
	- (CGSize)sizeWithFont:(UIFont *)font
	        constraintSize:(CGSize)constraintSize {
	    
	#define DvIOS7 0
	    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
	#undef DvIOS7
	#define DvIOS7 1
	    }
	    
	    CGSize size = CGSizeZero;
	#if DvIOS7
	    CGRect rect = [self boundingRectWithSize:constraintSize
	                                     options:NSStringDrawingTruncatesLastVisibleLine |
	                                             NSStringDrawingUsesFontLeading |
	                                             NSStringDrawingUsesLineFragmentOrigin
	                                  attributes:@{NSFontAttributeName:font}
	                                     context:nil];
	    size = rect.size;
	#else
	    size = [self sizeWithFont:font
	            constrainedToSize:constraintSize
	                lineBreakMode:NSLineBreakByWordWrapping];
	#endif
	    
	    return size;
	}
	
	@end

***

# 数组

## 数组简化

	[NSArray array] 简写为@[]
	[NSArray arrayWithObject:a] 简写为@[a]
	[NSArray arrayWithObjects:a, b, c, nil] 简写为@[a, b, c]
	[array objectAtIndex:idx] 简写为array[idx]
	[array replaceObjectAtIndex:idx withObject:newObj] 简写为array[idx] = newObj;
	
## 可变数组

	- (id)initWithCapacity:(NSUInteger)numItems; // 初始化
	+ (id)arrayWithCapacity:(NSUInteger)numItems;// 初始化
	- (void)addObject:(id)anObject; // 末尾加入一个元素
	- (void)insertObject:(id)anObject atIndex:(NSUInteger)index; // 插入一个元素
	- (void)removeLastObject; // 删除最后一个元素
	- (void)removeObjectAtIndex:(NSUInteger)index; //删除某一个元素
	- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject; //更改某个位置的元素
	+ (instancetype)arrayWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
	- (void)addObject:(id)anObject;

***

# 字典

## 常用方法

	- (instancetype)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys; // 用数据数组和key值数据初始化
	- (instancetype)initWithObjectsAndKeys:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION; // 用key和value对初始化
	+ (instancetype)dictionaryWithObject:(id)object forKey:(id <NSCopying>)key; // 用某个对象初始化
	- (id)objectForKey:(id)akey; // 从key获取value值
	- (id)valueForKey:(id)aKey; // 从key得到value值
	- (NSArray *)allkeys; // 获取所有的key
	- (NSArray *)allVlues; // 获取所有的value值
	
	- [NSDictionary dictionary] 简写为 @{}
	- [NSDictionary dictionaryWithObject:o1 forKey:k1] 简写为 @{k1:o1}
	- [NSDictionary dictionaryWithObjectsAndKeys:o1, k1, o2, k2, o3, k3, nil] 简写为 @{k1:o1, k2:o2, k3:o3}

## 可变字典

	- (void)setObject:(id)anObject forKey:(id)key; // 增加和修改可变字典的内容
	- (void)setValue:(id)anvlaue forKey:(id<NSCopying>)aKey; // 增加和修改可变字典的内容
	- (void)removeObjectForkey:(id)aKey; // 删除Key值对应的对象
	- (void)removeAllObjects; // 删除所有字典内容

## 字典与数组的联合使用

    NSArray *persons = @[
        @{@"name" : @"jack", @"qq" : @"432423423", @"books": @[@"5分钟突破iOS编程", @"5分钟突破android编程"]},
        @{@"name" : @"rose", @"qq" : @"767567"},
        @{@"name" : @"jim", @"qq" : @"423423"},
        @{@"name" : @"jake", @"qq" : @"123123213"}
        ];
    
    NSString *bookName = persons[0][@"books"][1];
    NSLog(@"%@", bookName);

***

# dictionary、data、json数据类型相互转换

## dictionary类型转换为data类型

	//NSDictionary -> NSData:  
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:  
	                                @"balance", @"key",  
	                               @"remaining balance", @"label",  
	                                @"45", @"value",  
	                                @"USD", @"currencyCode",nil];  
	
	NSMutableData *data = [[NSMutableData alloc] init];  
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];  
	[archiver encodeObject:params forKey:@"Some Key Value"];  
	[archiver finishEncoding];

## data转为dictionary

	// NSData -> NSDictionary  
	NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[self dataFilePath]];  
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];  
	NSDictionary *myDictionary = [[unarchiver decodeObjectForKey:@"Some Key Value"] retain];  
	[unarchiver finishDecoding];  
	[unarchiver release];  
	[data release];  

## dictionary转换为json数据类型

	// NSDictionary -> JSON:  
	NSString *jsonStr=[dict JSONRepresentation];  

## json转换为oc对象

	// Create a Foundation object from JSON data
	+ (id)JSONObjectWithData:(NSData *)data
	{
	    if (!data) {
	        return nil;
	    }
	    NSError *error = nil;
	    id object = [NSJSONSerialization JSONObjectWithData:data
	                                                options:NSJSONReadingMutableLeaves
	                                                  error:&error];
	    if (error) {
	        NSLog(@"Deserialized JSON string failed with error message '%@'.",
	              [error localizedDescription]);
	    }    
		return object;
	}

## oc对象转换为json

	// Generate JSON data from a Foundation object
	+ (NSData *)dataWithJSONObject:(id)object
	{
	    if (!object) {
	        return nil;
	    }
	    NSError *error = nil;
	    NSData *data = [NSJSONSerialization dataWithJSONObject:object
	                                                   options:NSJSONWritingPrettyPrinted
	                                                     error:&error];
	    if (error) {
	        NSLog(@"Serialized JSON string failed with error message '%@'.",
	              [error localizedDescription]);
	    }
	    return data;
	}

***

# 集
 
**初始化**

	- (id)initWithObjects:(id)firstObject, ...
	+ (id)setWithObjects:(id)firstObject, ...

**集的元素个数**

	- (NSUInteger)count;
	- (id)member:(id)object;
	- (NSEnumerator *)objectEnumerator;

**获取集中的元素**

	- (NSArray *)allObjects;
	- (id)anyObject;
	- (BOOL)containsObject:(id)anObject;

**NSMutableSet**

	- (void)addObject:(id)anObject;
	- (void)removeObject:(id)object;
	+ (id)setWithObject:(id)object;
	+ (id)setWithObjects:(const id *)objects count:(NSUInteger)cnt;
	+ (id)setWithObjects:(id)firstOject, ...

***

# singleton

## 典型的单例写法

	static id sharedMyManager;
	+ (id)sharedThemeManager {
		if (sharedMyManager == nil) {
			sharedMyMamager = [[self alloc] init];
		}
		return sharedMyManager;
	}

## 加锁的写法

	+ (id)sharedThemeManager {
		@synchronized(self) {
			if (sharedMyManager == nil) {
				sharedMyMamager = [[self alloc] init];
				}
			}
		return sharedMyManager;
	}
	
## 第一次实例化创建

	+ (voidq)initialize {
		static BOOL initialized = NO;
		if (initialized == NO) {
			initialized = YES;
			sharedMyManager = [[self alloc] init];
		}
	}	

## gcd写法

	+ (id)sharedManager {
		static dispatch_once_t once;
		dispatch_once(&once, ^{
			sharedMyManager = [[self alloc] init];
		});
		return sharedMyManager;
	}

## 完整写法
		
`重载下列方法`
	
	+ (Singleton *)sharedSingleton;
	+ (id)allocWithZone:(struct _NSZone *)zone;
	- (id)copyWithZone:(NSZone *)zone;
	- (id)retain;
	- (NSUInteger)retainCount;
	- (oneway void)release;
	- (id)autorelease;	

Demo:

	static Singleton * singleton = nil;
	
	+ (Singleton *)sharedSingleton {
	    
	    @synchronized(self) {
	        if (!singleton) {
	            singleton = [[self alloc] init];
	        }
	    }
	    return singleton;
	}
	
	+ (id)allocWithZone:(struct _NSZone *)zone {
	    
	    @synchronized(self) {
	        if (!singleton) {
	            singleton = [super allocWithZone:zone];
	            return singleton;
	        }
	    }
	    return nil;
	}
	
	- (id)copyWithZone:(NSZone *)zone {
	    
	    return self;
	}
	
	- (id)retain {
	    
	    return self;
	}
	
	- (NSUInteger)retainCount {
	    
	    return NSUIntegerMax;
	}
	
	- (id)autorelease {
	    
	    return self;
	}
	
	- (oneway void)release {
	    
	    // do nothing...
	}

***

# 文件管理器

	// 创建一个单例fileManager对象
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// 显示当前路径下的所有内容
	NSError *error = nil;
	// 浅度遍历
	NSArray *contentArray =  [fileManager contentsOfDirectoryAtPath:@"/Users/cuan" error:&error];
	NSLog(@"%@", contentArray);
	
	// 深度遍历
	contentArray = [fileManager subpathsOfDirectoryAtPath:@"/Users/cuan/Github" error:&error];
	NSLog(@"%@", contentArray);
	
	// 创建目录, YES补全中间目录
	[fileManager createDirectoryAtPath:@"/Users/cuan/Desktop/test" withIntermediateDirectories:YES attributes:nil error:&error];
	
	// 创建文件
	[fileManager createFileAtPath:@"/Users/cuan/Desktop/echo.txt" contents:[@"hello,wolrd" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
	
	// 文件(夹)的删除
	[fileManager removeItemAtPath:@"/Users/cuan/Desktop/test" error:&error];
	
	// 文件(夹)的拷贝
	[fileManager copyItemAtPath:@"/Users/cuan/Desktop/echo.txt" toPath:@"/Users/cuan/Desktop/echo2.txt" error:&error];
	
	// 文件(夹)的移动
	[fileManager copyItemAtPath:@"/Users/cuan/Desktop/echo.txt" toPath:@"/Users/cuan/Desktop/mv/echo.txt" error:&error];

***

# 文件句柄

	// NSFileHandle 文件句柄：对文件内容的操作
    #pragma mark 以只读方式打开文件生成文件句柄
    NSFileHandle *fileHandleReadonly = [NSFileHandle fileHandleForReadingAtPath:@"/Users/cuan/Documents/note.txt"];
    // 通过字节数来读取，每次读取通过指针标记上次读取到的位置
    NSData *context = [fileHandleReadonly readDataOfLength:10]; // 字节数
    NSString *contextString = [[NSString alloc] initWithData:context encoding:NSUTF8StringEncoding];
    NSLog(@"%@", contextString);
	
    // 一次性读完文件(适用于文件内容不多的情况)
    context = [fileHandleReadonly readDataToEndOfFile];
    contextString = [[NSString alloc] initWithData:context encoding:NSUTF8StringEncoding];
    NSLog(@"%@", contextString);
	
    #pragma mark 以只写的方式打开文件生成文件句柄
    NSFileHandle *fileHandleWriteOnly = [NSFileHandle fileHandleForWritingAtPath:@"/Users/cuan/Documents/note.txt"];

    // 覆盖
    [fileHandleWriteOnly writeData:[@"hello" dataUsingEncoding:NSUTF8StringEncoding]];
	
    // 重写
    //        [fileHandleWriteOnly truncateFileAtOffset:0]; // 将文件内容截断至0字节，清空
    // 追加
    [fileHandleWriteOnly seekToEndOfFile]; // 将读写文件指针指向文件末尾
    [fileHandleWriteOnly writeData:[@"xxxxxx" dataUsingEncoding:NSUTF8StringEncoding]];---

***

# archiver归档

**对普通的对象归档的要求**

- 对象必须遵守<NSCoding>协议
- 必须实现以下两个方法

		- (void)encodeWithCoder:(NSCoder *)aCoder {
		    [aCoder encodeInteger:_age forKey:@"age"];
		    [aCoder encodeObject:_name forKey:@"name"];
		    [aCoder encodeObject:_child forKey:@"child"];
		}
	
		- (id)initWithCoder:(NSCoder *)aDecoder {
		    if (self = [super init]) {
		        self.name  = [aDecoder decodeObjectForKey:@"name"];
		        self.age   = [aDecoder decodeIntegerForKey:@"age"];
		        self.child = [aDecoder decodeObjectForKey:@"child"];
			}
		    return self;
		}

Demo:
	
	// 创建字典并存值
	   NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Lucy", @"name",
                                @"22", @"age", nil];
	//        [dictionary  writeToFile:PATH atomically:YES];
    
    // 创建数组典并存值
    NSArray *array = [NSArray arrayWithObjects:@"Lucy", @"22", nil];
	//        [array writeToFile:PATH atomically:YES];    
    // 创建数据容器
    NSMutableData *archiverData = [NSMutableData data];
    // 关联容器与归档管理器
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archiverData];
    // 通过归档管理器将数据归档
    [archiver encodeObject:array forKey:@"array"];
    [archiver encodeObject:dictionary forKey:@"dictionary"];
    // 完成编码，(这步很重要)
    [archiver finishEncoding];
    // 将归档好的数据写入文件
    [archiverData writeToFile:PATH atomically:YES];    
    [archiver release];

	#pragma mark 读取归档数据    
    // 创建解档数据容器
    NSData *unarchiverData = [[NSData alloc] initWithContentsOfFile:PATH]; // 关联解档管理器与数据
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchiverData];
    // 通过解档管理器和key解档数据
    NSArray *unArray = [unarchiver decodeObjectForKey:@"array"];
    NSDictionary *unDictionary = [unarchiver decodeObjectForKey:@"dictionary"];
    NSLog(@"%@\n%@", unArray, unDictionary);
    
    [unarchiverData release];
    [unarchiver release];

	#pragma mark 普通对象的归档与解档
    
    Person *father = [[Person alloc] init];
    Person *son = [[Person alloc] init];
    
    father.name = @"Father";
    father.age = 32;
    father.child = son;
    
    // 获取归档数据
    NSData *personData = [NSKeyedArchiver archivedDataWithRootObject:father];
    // 将归档数据写入文件
    [personData writeToFile:PATH atomically:YES];
    // 读出归档数据
    NSData *unPersonDate = [NSData dataWithContentsOfFile:PATH];
    // 解档数据
    Person *unPerson = [NSKeyedUnarchiver unarchiveObjectWithData:unPersonDate];
    NSLog(@"name = %@, age = %ld, child = %@", unPerson.name, unPerson.age, unPerson.child);
	
	[father release];
	[son release];

***

# sandbox

- 获得home目录

		NSString *homeDirectory = NSHomeDirectory();		
- helloworld.app 目录
	
		NSString *appPath = [[NSBundle mainBundle] bundlePath];
- 获取Documents目录
	
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *path = [paths ObjectAtIndex:0];
- 获取Library目录
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
		NSString *path = [paths ObjectAtIndex:0];
- 获取Caches目录
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
		NSString *path = [paths ObjectAtIndex:0];

***

