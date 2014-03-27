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
