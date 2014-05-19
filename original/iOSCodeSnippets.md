# codeSnippets

navigation

- [appDelegate](#appDelegate)
- [UIViewController](#UIViewController)
- [切换到下一视图](#切换到下一视图)
- [返回上一个视图](#返回上一个视图)
- [关闭键盘](#关闭键盘)
- [限制长度，过滤输入](#限制长度，过滤输入)
- [文本内容自适应](#文本内容自适应)
- [键盘弹出和收起的通知](#键盘弹出和收起的通知)
- [在不同IOS版本中更改UINavigationBar背景图片](#在不同IOS版本中更改UINavigationBar背景图片)
- [改变导航控制器文本颜色](#改变导航控制器文本颜色)
- [改变标签控制器颜色](#改变标签控制器颜色)
- [NSDictionary、NSData、JSON数据类型相互转换](#NSDictionary、NSData、JSON数据类型相互转换)
- [获取uiview的uiviewcontroller](#获取uiview的uiviewcontroller)
- [检测网络状况](#检测网络状况)
- [判断设备](#判断设备)
- [获取UIView的UIViewcontroller](#获取UIView的UIViewcontroller)
- [显示警告窗口](#显示警告窗口)
- [购物车曲线动画](#购物车曲线动画)
- [UITextView实现PlaceHolder](#UITextView实现PlaceHolder)
- [UILabel实现顶部对齐](#UILabel实现顶部对齐)
- [Cell编辑按钮颜色](#Cell编辑按钮颜色)

* * *

## appDelegate

	#pragma mark 程序加载完成,自定义界面加载，数据导入，初始化等
	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
	
	#pragma mark 程序将要失活，保存用户数据，断开网络连接,游戏暂停
	- (void)applicationWillResignActive:(UIApplication *)application;
	#pragma mark 程序进入后台,释放界面元素，视频，音频媒体，降低程序的驻留内存开销
	- (void)applicationDidEnterBackground:(UIApplication *)application;
	
	#pragma mark 程序进入前台，恢复界面，数据等
	- (void)applicationWillEnterForeground:(UIApplication *)application;
	
	#pragma mark 程序激活，恢复用户数据，恢复网络连接
	- (void)applicationDidBecomeActive:(UIApplication *)application;
	
	#pragma mark 程序结束
	- (void)applicationWillTerminate:(UIApplication *)application;
	
* * *

## UIViewController

	// 自定义初始化方法，用于XIB加载控制器界面的时候
	- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNi
	
	// 控制器的视图加载完成
	- (void)viewDidLoad
	
	// 是否支持自动旋转
	- (NSUInteger)supportedInterfaceOrientations
	{
	    return UIInterfaceOrientationMaskAllButUpsideDown;
	}
	
	// 控制器支持设备朝向
	- (BOOL)shouldAutorotate
	{
	    return NO;
	}
	
	// 控制器试图将要旋转到某个朝向，在方法中处理新的界面布局
	- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;

* * *

## 切换到下一视图
	
	- (void)showDetail:(UIButton *)sender
	{
		DetailViewController *detailViewControl = [[[DetailViewController alloc] init] autorelease];
		
		// 设置切换动画效果
	    detailViewControl.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	    
	    // 控制器模态切换
	    [self presentViewController:detailViewControl animated:YES completion:^{
	        NSLog(@"Detail View Controller is show. ");
	    }];
	}
	
	// 导航视图控制器
	DetailViewController *detailViewController = [[DetailViewController alloc] init];
	[self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];

* * *

## 返回上一个视图

	- (void)back:(UIButton *)sender
	{
	    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
	        NSLog(@"返回deatail");
	    }];
	}
	
	// 导航视图控制器
	[self.navigationController popViewControllerAnimated:YES];	
	

* * *
## 关闭键盘

	#pragma mark - <UITextFieldDelegate>

	- (BOOL)textFieldShouldReturn:(UITextField *)textField
	{
	    // 关闭键盘
	    // solution 1
		//    [textField resignFirstResponder];
	    
	    //solution 2
	    [self.view endEditing:YES];
	    return YES;
	}	
	

* * *

## 限制长度，过滤输入

	#pragma mark - <UITextFieldDelegate>
	#define NUMBER_SET @"0123456789"
	- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
	{
	    if (range.location >= 11) {
	        return NO;
	    }
	    
	    if ([NUMBER_SET rangeOfString:string].location == NSNotFound) {
	        return NO;
	    }
	    
	    return YES;
	}

* * *

## 文本内容自适应

	// Before IOS 7
	CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(150, 568) lineBreakMode:NSLineBreakByWordWrapping];

	// After IOS 7
	- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constraintSize:(CGSize)constraintSize
	{
	    CGRect rect = [string boundingRectWithSize:constraintSize
	                                       options:NSStringDrawingTruncatesLastVisibleLine |
	                                                NSStringDrawingUsesFontLeading |
	                                                NSStringDrawingUsesLineFragmentOrigin
	                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
	                                       context:nil];
	    return rect.size;
	}

* * *

## 键盘弹出和收起的通知

	// 注册键盘弹出的系统通知
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@(keyboardWillShow) name:UIKeyboardWillShowNotification Object:nil];
	
	- (void)keyboardWillShow
	{
		[UIView animateWithDuration:0.25 animations:^{
			_btn.fram = CGRectMake(10, 220, 300, 30);
		} completion:^(BOOL finished){
		
		}];
	}
	
	// 注册键盘收起的系统通知
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@(keyboardWillhide) name:UIKeyboardWillHideNotification Object:nil];
	
	- (void)keyboardWillhide
	{
		[UIView animateWithDuration:0.25 animations:^{
			_btn.fram = CGRectMake(10, 400, 300, 30);
		} completion:^(BOOL finished){
		
		}];
	}
	
* * *
	
## 在不同IOS版本中更改UINavigationBar背景图片

	@implementation UINavigationBar (custom)
		
		static UIImage *backgroundImage = nil;
		- (void)setNavigationBarWithImage:(UIImage *)bgImage
		{
			if (backgroundImage != bgImage) {
				[backgroundImage release];
				[backgroundImage = bgImag retain];
				
			}
			
			// IOS 5.x
			if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
				[self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
				if ([[[UIDevice currentDevice] systemVersion] floatValue] > 6.0) {
					[UIApplication sharedApplication].statusBarStyle = UIBarStyleBlackOpaque;
				}
			}
			else { // IOS 4.x
				[self drawRect:self.bounds];
			}
		}
		
		// 重写drawRect方法，在5.x中该方法被废弃
		- (void)drawRect:(CGRect)rect
		{
			[backgroundImage drawInRect:rect];
		}
		
	@end

* * *

## 改变导航控制器文本颜色

```
for (UINavigationController *navi in navis) {
        navi.navigationBar.tintColor = [UIColor whiteColor];
        [navi.navigationBar setBackgroundImage:[UIImage imageNamed:@"navi"] forBarMetrics:UIBarMetricsDefault];
        navi.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                   NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};
    }
```

* * *

## 改变标签控制器颜色

```
tabBarController.tabBar.tintColor = [UIColor orangeColor];
[[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:12.0f]} forState:UIControlStateNormal];
[[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor   ], NSFontAttributeName:[UIFont systemFontOfSize:12.0f]} forState:UIControlStateSelected];
```

* * *

## NSDictionary、NSData、JSON数据类型相互转换

- NSDictionary类型转换为NSData类型

```
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
```

- NSData类型转换为NSDictionary类型

```
//NSData -> NSDictionary  
NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[self dataFilePath]];  
NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];  
NSDictionary *myDictionary = [[unarchiver decodeObjectForKey:@"Some Key Value"] retain];  
[unarchiver finishDecoding];  
[unarchiver release];  
[data release];  
```

* * * 

- NSDictionary转换为JSON数据类型

```
//NSDictionary -> JSON:  
NSString *jsonStr=[dict JSONRepresentation];  
```

- JSON转换为OC对象(数组、字典)

```
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
```

- OC对象(数组、字典)转换为JSON

```
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
```

* * *

## 获取UIView的UIViewcontroller

```
@implementation UIView (FindUIViewController)  
  
- (UIViewController *)viewController {  
    /// Finds the view's view controller.  
      
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.  
    UIResponder *responder = self;  
    while ((responder = [responder nextResponder]))  
        if ([responder isKindOfClass: [UIViewController class]])  
            return (UIViewController *)responder;  
      
    // If the view controller isn't found, return nil.  
    return nil;  
}  
  
@end
```

* * *


## 检测网络状况

－　方式一

*前提*

- 工程添加：`SystemConfiguration.framework` framework
- `#import "Reachability.h"` 

```
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
```

- 方式二

`导入SystemConfiguration.framework,并#import<SystemConfiguration/SCNetworkReachability.h>`

```
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

```

* * *

## 判断设备

```
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
```

* * *

## 显示警告窗口

```
- (void)alertWithMessage:(NSString *)message {

    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Alert"
                              message:message
                              delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:nil];
    
    [alertView show];
    [alertView release];
    
    // wait two seconds dismiss
    NSMethodSignature *signature = [UIAlertView instanceMethodSignatureForSelector:
                                    @selector(dismissWithClickedButtonIndex:animated:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:alertView];
    [invocation setSelector:@selector(dismissWithClickedButtonIndex:animated:)];
    NSInteger index = 0;
    [invocation setArgument:&index atIndex:2];
    BOOL animated = YES;
    [invocation setArgument:&animated atIndex:3];
    [invocation retainArguments];
    [invocation performSelector:@selector(invoke) withObject:nil afterDelay:2];
}
```

* * * 

## 购物车曲线动画

```
CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 1.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.fillMode = kCAFillModeForwards;
    animation.calculationMode = kCAAnimationCubicPaced;
    animation.removedOnCompletion = YES;
    animation.delegate = self;
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, CGRectGetMidX(self.bounds),
                      CGRectGetMidY(self.bounds) + 100);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 30, 100, 40, 700);
    animation.path = curvedPath;
    [_imageView.layer addAnimation:animation forKey:nil];
    CGPathRelease(curvedPath);
```

* * * 

## UITextView实现PlaceHolder

```
//
//  DDPlaceHolderTextView.h
//  面试职通车
//
//  Created by 萧川 on 14-4-22.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDPlaceHolderTextView : UITextView

@property(nonatomic, strong) NSString *placeholder;
@property(nonatomic, strong) UIColor *placeholderColor;

@end
```

```
//
//  DDPlaceHolderTextView.m
//  面试职通车
//
//  Created by 萧川 on 14-4-22.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPlaceHolderTextView.h"

@interface DDPlaceHolderTextView ()

@property(nonatomic, strong) UILabel *placeHolderLabel;

- (void)initialize;
- (void)updateShouldDrawPlaceholder;
- (void)textChanged:(NSNotification *)notification;

@end

@implementation DDPlaceHolderTextView {

    BOOL _shouldDrawPlaceholder;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]
        removeObserver:self
        name:UITextViewTextDidChangeNotification object:self];
}

- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        [self initialize];
    }
    return self;
}

- (void)setText:(NSString *)string {
    
    [super setText:string];
    [self updateShouldDrawPlaceholder];
}


- (void)setPlaceholder:(NSString *)string {
    
    if ([string isEqual:_placeholder]) {
        return;
    }
    
    _placeholder = string;
    [self updateShouldDrawPlaceholder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        
        [self initialize];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (_shouldDrawPlaceholder) {
        [_placeholderColor set];
        CGRect drawRect = CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f, self.frame.size.height - 16.0f);
        [_placeholder drawInRect:drawRect
                  withAttributes:@{NSFontAttributeName:self.font}];
    }
}


#pragma mark - Private

- (void)initialize {
    
    [[NSNotificationCenter defaultCenter]
        addObserver:self
        selector:@selector(textChanged:)
        name:UITextViewTextDidChangeNotification object:self];
    
    self.placeholderColor = [UIColor colorWithWhite:0.702f alpha:1.0f];
    _shouldDrawPlaceholder = NO;
}


- (void)updateShouldDrawPlaceholder {
    
    BOOL prev = _shouldDrawPlaceholder;
    _shouldDrawPlaceholder = self.placeholder && self.placeholderColor && self.text.length == 0;
    
    if (prev != _shouldDrawPlaceholder) {
        [self setNeedsDisplay];
    }
}


- (void)textChanged:(NSNotification *)notificaiton {
    
    [self updateShouldDrawPlaceholder];
}

@end

```

* * *

## UILabel实现顶部对齐

```
#import <UIKit/UIKit.h>

typedef enum VerticalAlignment {
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface DDAlignmentLabel : UILabel

@end
```

```

#import "DDAlignmentLabel.h"

@interface DDAlignmentLabel ()

@property (nonatomic, assign) VerticalAlignment verticalAlignment;

@end

@implementation DDAlignmentLabel

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.verticalAlignment = VerticalAlignmentMiddle;
    }
    return self;
}

- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment {
    
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds
     limitedToNumberOfLines:(NSInteger)numberOfLines {
    
    CGRect textRect = [super textRectForBounds:bounds
                        limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y +
                bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y +
                (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    
    CGRect actualRect = [self textRectForBounds:requestedRect
                         limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end
```

* * *

## Cell编辑按钮颜色

```
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageListCell *cell= (MessageListCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIImageView *obj = (UIImageView *)[[[[[cell.subviews firstObject] subviews] lastObject] subviews] firstObject];
    obj.tintColor = ElementBColor;    
}

```