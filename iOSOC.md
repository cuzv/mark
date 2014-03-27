# iOS OC Notes

* * *

**Navigation**

- [一句话知识点](#一句话知识点)
- [代码规范](#代码规范)
	- [变量](#变量)
	- [命名](#命名)
	- [init与dealloc](#init与dealloc)
	- [字面值](#字面值)
- [retain/release](#retain/releas)
- [ARC](#ARC)
- [cocoa内存管理规则](#cocoa内存管理规则)
- [property总结](#property总结)
- [@class](#@class)
- [Category](#Category)
- [Protocol](#protocol) 
- [block](#block)
- [OC数据类型](#OC数据类型)
- [NSString](#NSString)
	- [NSString对象初始化](#NSString对象初始化)
	- [字符串长度获取](#字符串长度获取)
	- [获取字符串的子串](#获取字符串的子串)
	- [字符串的导出](#字符串的导出)
	- [字符串的比较](#字符串的比较)
	- [类型的转换](#类型的转换)
	- [可变字符串](#可变字符串)
- [NSArray](#NSArray)
- [NSDictionary](#NSDictionary)
- [NSSet](#NSSet)
- [Singleton](#singleton)
- [NSFileManger](#NSFileManager)
- [NSFileHandle](#NSFileHandle)
- [Archiver](#Archiver)
- [Sandbox](#sandbox)

* * *

## 一句话知识点

- 点语法的本质是getter/setter方法调用于
- setter/getter里面不能使用self，会造死循环
- SEL其实是对方法的一种包装，将方法包装成一个SEL类型的数据，去找对应的方法地址。找到地址就可以调用方法。其实消息就是SEL
- 僵尸对象：所占用内存已经被回收的对象，僵尸对象不能再使用
- 野指针：指向僵尸对象(不可用内存)的指针，给野指针发消息会报错(EXEC_BAD_ACCESS)
- 空指针：没有指向任何东西的指针(存的东西是0, NULL, nil)，给空指针发消息不报错
- BOOL类型property一般指定getter方法格式为isMethod, e.g.:@property (getter=isRich) BOOL rich;
- 当一个对象调用autorelease方法时，会将整个对象方放到栈顶的释放池 
- `创建对象时不要直接调用类名，一般用self`.e.g.
    
        + (id)person
        {
            return [[[self alloc] init] autorelease];
        }

- 类的本质是对象。是Class类型的对象，简称类对象。 `typedef struct objc_class *Class`. 类名就代表着类对象，每个类只有一个类对象
- NSUserDefaults 里面不能够存储UIViewController实例或者其示例数组
- 创建视图控制器的时候，最好不要在初始化方法中做与视图相关的操作(getter)，可能引发循环调用

- - -

## 代码规范

### 变量

- 变量的命令应尽量做到自描述。除了在for()循环语句中，单字母的变量应该避免使用（如i,j,k等）。一般循环语句的当前对象的命名前缀包括“one”、“a/an”。对于简单的单个对象使用“item”命名.

- 尽量的使用属性而非实例变量。除了在初始化方法（init，initWithCoder：等）、dealloc方法以及自定义setter与getter方法中访问属性合成的实例变量，其他的情况使用属性进行访问。

---

### 命名

- 对于NSString、NSArray、NSNumber或BOOL类型，变量的命名一般不需要表明其类型。

- 如果变量不是以上基本常用类型，则变量的命名就应该反映出自身的类型。但有时仅需要某些类的一个实例的情况下，那么只需要基于类名进行命名。

- 大部分情况下，NSArray或NSSet类型的变量只需要使用单词复数形式（比如mailboxes），不必在命名中包含“mutable”。如果复数变量不是NSArray或NSSet类型，则需要指定其类型。

---

### init与dealloc

- dealloc方法应该被放置在实现方法的顶部，直接在@synthesize或@dynamic语句之后。init方法应该被放置在dealloc方法的下面。

---

### 字面值

- 对于NSString，NSDictionary，NSArray和NSNumber类，当需要创建这些类的不可变实例时，应该使用这些类的字面值表示形式。使用字面值表示的时候nil不需要传入NSArray和NSDictionary中作为字面值。这些种语法兼容老的iOS版本，因此可以在iOS5或者更老的版本中使用它。

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

---

**方法命名**

- 一个方法的命名首先描述返回什么，接着是什么情况下被返回。方法签名中冒号的前面描述传入参数的类型。以下类方法和实例方法命名的格式语法：

		[object/class thing+condition];
		
		[object/class thing+input:input];
		
		[object/class thing+identifer:input];

- Cocoa命名举例：

		realPath    = [path     stringByExpandingTildeInPath];
		
		fullString  = [string   stringByAppendingString:@"Extra Text"];
		
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

---

## retain/release

- `消息涉及到对成员变量操作的时候考虑retain/copy`
- 哪些方法对成员变量操作？init、setter、类似setter
- setter/init与dealloc相对应。对象初始化(创建)便retain，对象不需要的时候就release
- 有一个+1(retain/alloc/new/copy/mutableCopy)就对应一个-1(release)
- 为什么需要retain/copy？因为当前消息中用到的成员变量在其他方法种也可能需要调用，如果在当前方法中release了，那么-1就可能销毁数据了，其他方法种就出现了访问野指针。所以持有对象+1，对其他方法种不会照成干扰

		void test(Student *stu) 
		{
		    Book *book = [[Book alloc] initWithPrice:3.5];
		
		    stu.book = book; // 如果没有retain.等效于_book = book;
	
		    [book release];
		}
		
		void test1(Student *stu) 
		{
		    [stu readBook];
		}
		
		int main(int argc, const char * argv[])
		{
			Student *stu = [[Student alloc] initWithAge:10];
		
			test(stu); //book:0
		
			test1(stu); // 调用book，野指针错误
		
			[stu release];
		
		    return 0;
		}
		
		Student.m
		- (void) readBook
		{
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

---

## ARC

**ARC的判断准则：只要没有指针指向对象，就会释放对象**

- 指针分2种：强指针和弱指针
    - 默认情况下，所有指针都是强指针
    
**ARC的特点：**

- 不允许调用release、retain、retainCount方法
- 允许重写dealloc、但是不允许调用[super dealloc]
- @property的参数
    - strong: 相当于retain(适用于OC对象类型)
    - weak: 相当于assign(适用于OC对象类型)
    - assign: 适用于非OC对象类型
    - MRC的retain改为strong(循环引用的时使用：一端用strong，一端用weak)

---

## Cocoa内存管理规则

- 使用alloc、new、copy、mutableCopy生成的对象需要手动释放，这些对象成为堆上的对象
- 使用以上4种方法以外的方法（遍历初始化）生成的对象，默认retainCount为1，并且设置为自动释放，这些对象可以称作栈上的临时对象，局部变量、方法或者函数传参
- 使用retain方法持有的对象，需要手动release进行释放，并且保持retain以及release次数想相同
- 集合类可以持有集合中的对象(retain一次)，当集合对象自身销毁时，会将自身中的所有对象release一次
- 持有集合类，不会增加内部对象的引用计数值
- set/init里面retain与dealloc里面release相对应。

---

## 属性的总结

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

---

## @class

- 在.h文件中用@class来声明类，仅仅是告诉编译器，某个名称是一个类
- 在.m文件中用#import来包含类的所有内容
- 两端循环引用解决方案：一端用retain, 一端用assign

---

## category

- 类别声明可以和需要扩展的类写在同一个.h文件中，写在原声明后面，实现文件同理
- 类别是不能为类声明实例变量的。而只能包含方法。但是，所有类作用域中的实例变量同样也在类别的作用域中。包括类声明的所有实例变量，甚至那些声明为 @private 的。
- 你可为一个类添加的类别的数量没有限制，但是每个类别名必须是唯一的，并且每个类别应当声明/定义不同的方法。
- 类扩展就像匿名的类别，除了扩展中声明的方法必须在主 @implementation 块中实现。使用 Clang/LLVM 2.0 编译器时，你还可以在一个类扩展中定义属性以及实例变量。
- 通常我们用类扩展来声明公有的只读属性和私有的读写属性。
- 类别可以实现原始类的方法，但不推荐这么做，因为它是直接替换原来的方法，这么做后果是再也无法访问原来的方法

---

##  protocol

- 与java的接口类似
- @protocol与@class有一致的用法，提前声明，实现时，在.h文件中声明，在.m中导入
- 协议中方法声明关键字：@required(默认)、@optional(可选)
- 协议可以定义在单独的文件中，也可以定义在某个类中(这个协议只用在这个类中)，类别同理

---

## block

	- 类似于java的匿名内部类
	
	int (^sum)(int, int) = ^(int a, int b)
	{
		return a + b;
	}
	
	int sum = sum(10, 2);
	NSLog(@"%i", sum); 
	typedef int (^mySum)(int, int);
	void test()
	{
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

---

## OC数据类型

- NSValue可以用来封装任意数据结构

		(NSValue *)valueWithBytes:(const void *)value objCType:(const char *)type;
		
- NSNumber类继承于NSValue，用来封装基本书数据类型，如，int, float等

		+ (NSNumber *)numberWithInt:(int)value;
		+ (NSNumber *)numberWithFloat:(float)value;
		+ (NSNumber *)numberWithChar:(char)value;
		+ (NSNumber *)numberWithBool:(BOOL)value;
		
- NSNull用来封装nil值

		+ (NSNull *)null;
		
- NSArray、NSSet和NSDictionary等容器只能存储对象，不能存储基本数据类型和结构体，也不能存储nil

- NSString、NSMutableString对字符串封装

- OC特殊数据类型：id, nil, SEL等 

---

## NSString

### NSString对象初始化

- 创建常量字符串

		NSString *aString = @"This is a String";
	
- 创建空字符串

		NSString *aString = [[String alloc] init];
		aString = @"This is a String";
		
- 提升速度的方法

		NSString *aString = [[NSString alloc] initWithString:@"This is a String"];
		
- 其他方法

		-(id)initWithFormat:(NSString *)format // 便利构造器
		-(id)initWithData:(NSData *) encoding:(NSStringEncoding) encoding;
		-(id)initWithCString(const char *)cString encoding:(NSStringEncoding)encoding; // 通过一个c字符串得到一个新字符串
		
- e.g.

        NSString *s1 = @"Jack";
        NSString *s2 = [[NSString alloc] initWithString:@"Jack"];
        NSString *s3 = [[NSString alloc] initWithFormat:@"my age is %d", 10];
        NSString *s4 = [[NSString alloc] initWithUTF8String:"Lucy"]; // c字符串 --> OC字符串
        NSString *s5 = [[NSString alloc] initWithContentsOfFile:@"/Users/cuan/Desktop/1.txt" encoding:NSUTF8StringEncoding error:nil];
        NSString *s6 = [[NSString alloc] initWithContentsOfURL:@"file:///Users/cuan/demo.txt" encoding:NSUTF8StringEncoding error:nil];
    
### 字符串长度获取
		
- 字符串长度获取

		-(NSInteger)length;

### 获取字符串的子串

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

### 字符串的导出

    [@"Hello,world" writeToFile:@"/User/cuan/echo.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSURL *url = [NSURL fileURLWithPath:@"/Users/cuan/echo.txt"];
    [@"hello, every one" writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];

### 字符串的比较

- 是否相等

		-(BOOL)isEqualToString:(NSString *)str;
		
- 比较大小

		-(NSComparisonResult)compare:(NSString *)str;

- 转换大小写

		-(NSString *)uppercaseString;
		-(NSString *)lowercaseString;

### 类型的转换

	-(double)doubleValue;
	-(float)floatValue;
	-(int)intValue;
	-(NSInteger)integerValue;
	-(long long)longlongValue;
	-(BOOL)boolValue;
	-(double)doubelValue
	-(id)initWithFormat:(NSString *)format....
 
### 可变字符串

	-(id)initWithCapacity:(NSUInteger)capacity;
	+(id)stringWithCapacity:(NSUInteger)capacity;
	-(void)insertString:(NSString *)aString atIndex:(NSUInteger)loc;
	-(void)deleteCharactersInRang:(NSRange)range;
	-(void)appendString:(NSString *)aString;
	-(void)appendFormat:(NSString *)format, ....
	-(void)setString:(NSString)aString;

---

## NSArray

**初始化**

	+(id)arrayWithObjetcts(id)firstObject, ...
	+(id)arrayWithArray:(NSArray *)array;
	-(id)initWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
	-(id)initWithArray:(NSArray *)array;

**数组元素个数**

	int count = [array count]

**获取数组元素**

	[array objectAtIndex:n];
	[array lastObject];
	
**NSArray简化**

	[NSArray array] 简写为@[]
	[NSArray arrayWithObject:a] 简写为@[a]
	[NSArray arrayWithObjects:a, b, c, nil] 简写为@[a, b, c]
	[array objectAtIndex:idx] 简写为array[idx]
	[array replaceObjectAtIndex:idx withObject:newObj] 简写为array[idx] = newObj;
	
**NSMutableArray**

	- (id)initWithCapacity:(NSUInteger)numItems; // 初始化
	+ (id)arrayWithCapacity:(NSUInteger)numItems;// 初始化
	- (void)addObject:(id)anObject; // 末尾加入一个元素
	- (void)insertObject:(id)anObject atIndex:(NSUInteger)index; // 插入一个元素
	- (void)removeLastObject; // 删除最后一个元素
	- (void)removeObjectAtIndex:(NSUInteger)index; //删除某一个元素
	- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject; //更改某个位置的元素
	+ (instancetype)arrayWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
	- (void)addObject:(id)anObject;

---

## NSDictionary

**NSDictionary**

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

**NSMutableDictionary**

	- (void)setObject:(id)anObject forKey:(id)key; // 增加和修改可变字典的内容
	- (void)setValue:(id)anvlaue forKey:(id<NSCopying>)aKey; // 增加和修改可变字典的内容
	- (void)removeObjectForkey:(id)aKey; // 删除Key值对应的对象
	- (void)removeAllObjects; // 删除所有字典内容

**字典与数组的联合使用**

    NSArray *persons = @[
        @{@"name" : @"jack", @"qq" : @"432423423", @"books": @[@"5分钟突破iOS编程", @"5分钟突破android编程"]},
        @{@"name" : @"rose", @"qq" : @"767567"},
        @{@"name" : @"jim", @"qq" : @"423423"},
        @{@"name" : @"jake", @"qq" : @"123123213"}
        ];
    
    NSString *bookName = persons[0][@"books"][1];
    NSLog(@"%@", bookName);

---

## NSSet
 
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

---

### Singleton

- 典型的单例写法

		static id sharedMyManager;
		+ (id)sharedThemeManager
		{
			if (sharedMyManager == nil) {
				sharedMyMamager = [[self alloc] init];
			}
			return sharedMyManager;
		}

- 加锁的写法

		+ (id)sharedThemeManager
		{
			@synchronized(self) {
				if (sharedMyManager == nil) {
					sharedMyMamager = [[self alloc] init];
				}
			}
			return sharedMyManager;
		}
	
- 第一次实例化创建Lock free

		+ (voidq)initialize
		{
			static BOOL initialized = NO;
			if (initialized == NO) {
				initialized = YES;
				sharedMyManager = [[self alloc] init];
			}
		}	

- GCD写法

		+ (id)sharedManager
		{
			static dispatch_once_t once;
			dispatch_once(&once, ^{
				sharedMyManager = [[self alloc] init];
			});
			return sharedMyManager;
		}

- 完整写法
		
	**重载下列方法**
		
		+ (id)allocWithZone:(NSZone *)zone;
		+ (id)copyWithZone:(NSZone *)zone;
		+ (id)retain;
		+ (void)release;
		+ (void)autorelease;		

---

## NSFileManager

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

---

## NSFileHandle

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

---

## Archiver

**对普通的对象归档的要求**

- 对象必须遵守<NSCoding>协议
- 必须实现以下两个方法

			- (void)encodeWithCoder:(NSCoder *)aCoder
			{
			    [aCoder encodeInteger:_age forKey:@"age"];
			    [aCoder encodeObject:_name forKey:@"name"];
			    [aCoder encodeObject:_child forKey:@"child"];
			}
			
			- (id)initWithCoder:(NSCoder *)aDecoder
			{
			    if (self = [super init]) {
			        self.name  = [aDecoder decodeObjectForKey:@"name"];
			        self.age   = [aDecoder decodeIntegerForKey:@"age"];
			        self.child = [aDecoder decodeObjectForKey:@"child"];
			    }
			    return self;
			}

**demo**

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

---

## Sandbox

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

- - -