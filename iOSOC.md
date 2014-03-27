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

