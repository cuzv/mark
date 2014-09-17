# iOS Realization

- [转换对象](#转换对象)
- [让 Category 支持添加属性与成员变量](#让-category-支持添加属性与成员变量)
- [获取图片](#获取图片)
- [通过颜色创建图片](#通过颜色创建图片)
- [让 UILabel 具有 padding 效果](#让-uilabel-具有-padding-效果)
- [让 UITextField 具有 padding 效果](#让-uitextfield-具有-padding-效果)
- [方便快捷获取调整视图坐标与大小](#方便快捷获取调整视图坐标与大小)
- [为视图添加边线](#为视图添加边线)
- [寻找视图的控制器](#寻找视图的控制器)
- [吐司框效果](#吐司框效果)
- [徽标效果](#徽标效果)
- [统计并限制输入长度](#统计并限制输入长度)
- [禁用粘贴功能](#禁用粘贴功能)
- [判断键盘是否已经升起](#判断键盘是否已经升起)
- [GCD Timer](#cgd-timer)
- [在 Storyboard  Autolayout 模式下使用 UIScrollview](#在-storyboard-autolayout-模式下使用-uiscrollview)

## 转换对象

```objective-c
@interface NSObject (Convert)

// 快速创建模型
- (instancetype)initWithProperties:(NSDictionary *)properties;

// 获取属性列表
- (NSMutableArray *)properties;
+ (NSMutableArray *)properties;

// 自身对象转为字典
- (NSDictionary *)convertToDictionary;

// 打印对象
- (NSMutableString *)toString;

@end
```

```objective-c
#import <objc/message.h>
#import <objc/runtime.h>

@implementation NSObject (Convert)

- (instancetype)initWithProperties:(NSDictionary *)properties {
    if (self = [self init]) {
        [properties enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([obj isKindOfClass:[NSNull class]]) {
                obj = @"";
            }
            if ([key isEqualToString:@"id"]) {
                key = @"ID";
            }
            [self setValue:obj forKey:key];
        }];
    }
    
    return self;
}

#pragma mark - runtime

- (NSMutableArray *)properties {
    NSMutableArray *propertyArray = [[NSMutableArray alloc] init];
    u_int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSString *stringName = [NSString  stringWithCString:propertyName
                                                   encoding:NSUTF8StringEncoding];
        [propertyArray addObject:stringName];
    }
    
    free(propertyList);
    
    return propertyArray;
}

+ (NSMutableArray *)properties {
    NSMutableArray *propertyArray = [[NSMutableArray alloc] init];
    u_int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSString *stringName = [NSString  stringWithCString:propertyName
                                                   encoding:NSUTF8StringEncoding];
        [propertyArray addObject:stringName];
    }
    
    free(propertyList);
    
    return propertyArray;
}

- (NSDictionary *)convertToDictionary {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    // 获取本类属性列表字符串数组
    NSMutableArray *propertyArray = [self properties];
    
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [dict setObject:[self valueForKey:obj] forKey:obj];
    }];
    
    return dict;
}

- (NSString *)toString {
    NSMutableString *desc = [[NSMutableString alloc] init];
    
    NSMutableArray *propertyArray = [self properties];
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *string = [NSString stringWithFormat:@"%@ = %@, ", obj, [self valueForKey:obj]];
        [desc appendString:string];
    }];
    
    NSRange range = NSMakeRange([desc length] - 2, 1);
    [desc deleteCharactersInRange:range];
    
    return desc;
}

@end
```

## 让 Category 支持添加属性与成员变量

```objective-c
// NSObject+IndieBandName.h
@interface NSObject (IndieBandName)
@property (nonatomic, strong) NSString *indieBandName;
@end
```

```objective-c
// NSObject+IndieBandName.m    
#import "NSObject+Extension.h"
#import <objc/runtime.h>
static const void *IndieBandNameKey = &IndieBandNameKey;    
@implementation NSObject (IndieBandName)
@dynamic indieBandName;

- (NSString *)indieBandName {
    return objc_getAssociatedObject(self, IndieBandNameKey);
}

- (void)setIndieBandName:(NSString *)indieBandName{
    objc_setAssociatedObject(self, IndieBandNameKey, indieBandName,
OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
```

## 获取图片

```objective-c
@interface UIImage (Fetch)

// 通过名字获取图片，不带后缀，png图片
+ (UIImage *)imageWithName:(NSString *)aName;

// 通过名字和后缀获取图片
+ (UIImage *)imageWithName:(NSString *)aName suffix:(NSString *)aSuffix;

// 通过带后缀名字获取图片
+ (UIImage *)imageWithNameHasSuffix:(NSString *)aNameHasSuffix;

@end
```

```objective-c
@implementation UIImage (Fetch)

+ (UIImage *)imageWithName:(NSString *)aName {
    return [self imageWithName:aName suffix:@"png"];
}

+ (UIImage *)imageWithName:(NSString *)aName suffix:(NSString *)aSuffix {
    return [UIImage imageWithContentsOfFile:
            [[NSBundle mainBundle]
             pathForResource:aName
             ofType:aSuffix]];
}

+ (UIImage *)imageWithNameHasSuffix:(NSString *)aNameHasSuffix {
    return [UIImage imageWithContentsOfFile:
            [[NSBundle mainBundle]
             pathForAuxiliaryExecutable:aNameHasSuffix]];
}

@end
```

## 通过颜色创建图片

```objective-c
@interface UIImage (Generate)
+ (UIImage *)imageWithColor:(UIColor *)aColor;
+ (UIImage *)imageWithColor:(UIColor *)aColor size:(CGSize)aSize;
@end
```

```objective-c
#import "UIImage+Generate.h"

@implementation UIImage (Generate)

+ (UIImage *)imageWithColor:(UIColor *)aColor {
    return [self imageWithColor:aColor size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)aColor size:(CGSize)aSize {
    UIGraphicsBeginImageContext(aSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGRect rect = CGRectMake(0, 0, aSize.width, aSize.height);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
```

## 让 UILabel 具有 padding 效果

```objective-c
@interface PaddingLabel : UILabel
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@end
```

```objective-c
@implementation PaddingLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end
```

## 让 UITextField 具有 padding 效果

```objective-c
#define kPaddingWidth 5
// 控制 placeHolder 的位置，左右缩 5
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, kPaddingWidth , 0);
}

// 控制文本的位置，左右缩 5
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, kPaddingWidth , 0);
}
```

## 方便快捷获取调整视图坐标与大小

```objective-c
@interface UIView (Accessor)

- (void)setOrigin:(CGPoint)point;
- (CGPoint)origin;

- (void)setSize:(CGSize)size;
- (CGSize)size;

- (void)setMinX:(CGFloat)x;
- (CGFloat)minX;

- (void)setMidX:(CGFloat)x;
- (CGFloat)midX;

- (void)setMaxX:(CGFloat)x;
- (CGFloat)maxX;

- (void)setMinY:(CGFloat)y;
- (CGFloat)minY;

- (void)setMidY:(CGFloat)y;
- (CGFloat)midY;

- (void)setMaxY:(CGFloat)y;
- (CGFloat)maxY;

- (void)setWidth:(CGFloat)width;
- (CGFloat)width;

- (void)setHeight:(CGFloat)height;
- (CGFloat)height;

@end
```

```objective-c
@implementation UIView (Accessor)

- (void)setOrigin:(CGPoint)point {
    self.frame = CGRectMake(point.x, point.y, self.width, self.height);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.minX, self.minY, size.width, size.height);
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setMinX:(CGFloat)x {
    self.frame = CGRectMake(x, self.minY, self.width, self.height);
}

- (CGFloat)minX {
    return self.frame.origin.x;
}

- (void)setMidX:(CGFloat)x {
    self.frame = CGRectMake(x - self.width / 2, self.minY, self.width, self.height);
}

- (CGFloat)midX {
    return CGRectGetMidX(self.frame);
}

- (void)setMaxX:(CGFloat)x {
    self.frame = CGRectMake(x - self.width, self.minY, self.width, self.height);
}

- (CGFloat)maxX {
    return self.minX + self.width;
}

- (void)setMinY:(CGFloat)y {
    self.frame = CGRectMake(self.minX, y, self.width, self.height);
}

- (CGFloat)minY {
    return self.frame.origin.y;
}

- (void)setMidY:(CGFloat)y {
    self.frame = CGRectMake(self.minX, y - self.height / 2, self.width, self.height);
}

- (CGFloat)midY {
    return CGRectGetMidY(self.frame);
}

- (void)setMaxY:(CGFloat)y {
    self.frame = CGRectMake(self.minX, y - self.height, self.width, self.height);
}

- (CGFloat)maxY {
    return self.minY + self.height;
}

- (void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.minX, self.minY, width, self.height);
}

- (CGFloat)width {
    return CGRectGetWidth(self.bounds);
}

- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.minX, self.minY, self.width, height);
}

- (CGFloat)height {
    return CGRectGetHeight(self.bounds);
}

@end
```

## 为视图添加边线

```objective-c
typedef enum {
    CHEdgeOrientationTop,
    CHEdgeOrientationLeft,
    CHEdgeOrientationBottom,
    CHEdgeOrientationRight
} CHEdgeOrientation;

@interface UIView (BorderLine)
- (void)setBorderLineColor:(UIColor *)aColor;
- (void)setBorderLineColor:(UIColor *)aColor edgeOrientation:(CHEdgeOrientation)orientation;
@end
```

```objective-c
@implementation UIView (BorderLine)

- (void)setBorderLineColor:(UIColor *)aColor {
    [self setBorderLineColor:aColor edgeOrientation:CHEdgeOrientationBottom];
    [self setBorderLineColor:aColor edgeOrientation:CHEdgeOrientationTop];
    [self setBorderLineColor:aColor edgeOrientation:CHEdgeOrientationLeft];
    [self setBorderLineColor:aColor edgeOrientation:CHEdgeOrientationRight];
}

- (void)setBorderLineColor:(UIColor *)aColor
           edgeOrientation:(CHEdgeOrientation)orientation {
    CALayer *line = [[CALayer alloc] init];
    line.backgroundColor = aColor.CGColor;
    
    CGRect lineFrame = CGRectZero;
    if (CHEdgeOrientationTop == orientation) {
        // 上边加线
        lineFrame = CGRectMake(CGRectGetMinX(self.bounds),
                               CGRectGetMinY(self.bounds),
                               CGRectGetWidth(self.bounds),
                               1);
    } else if (CHEdgeOrientationLeft == orientation) {
        // 左边加线
        lineFrame = CGRectMake(CGRectGetMinX(self.bounds),
                               CGRectGetMinY(self.bounds),
                               1,
                               CGRectGetHeight(self.bounds));
    } else if (CHEdgeOrientationBottom == orientation) {
        // 底边加线
        lineFrame = CGRectMake(CGRectGetMinX(self.bounds),
                               CGRectGetMaxY(self.bounds),
                               CGRectGetWidth(self.bounds),
                               1);
    } else {
        // 右边加线
        lineFrame = CGRectMake(CGRectGetMaxX(self.bounds),
                               CGRectGetMinY(self.bounds),
                               1,
                               CGRectGetHeight(self.bounds));
    }
    line.frame = lineFrame;
    [self.layer addSublayer:line];
}

@end
```

## 寻找视图的控制器

```objective-c
@interface UIView (FindUIViewController)
- (UIViewController *)viewController;
@end
```

```objective-c
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

## 吐司框效果

```objective-c
@interface UIView (Toast)
+ (void)toastMessage:(NSString *)theMessage;
@end
```

```objective-c
#import "PaddingLabel.h"
#define kDelayDuration 0.8
@implementation UIView (Toast)

// 提示信息，自动消失
+ (void)toastMessage:(NSString *)theMessage {
    UIFont *theFont = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    CGSize boundingRectSize = CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - 80, CGRectGetHeight([[UIScreen mainScreen] bounds]));
    CGSize size = [theMessage boundingRectWithSize:boundingRectSize
                                           options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:theFont}
                                           context:nil].size;
    
    PaddingLabel *toastLabel = [[PaddingLabel alloc] init];
    toastLabel.bounds = CGRectMake(0, 0, size.width + 20, size.height + 20);
    CGRect bounds = [[UIScreen mainScreen] bounds];
    toastLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    toastLabel.textColor = [UIColor whiteColor];
    toastLabel.textAlignment = NSTextAlignmentCenter;
    toastLabel.numberOfLines = 0;
    toastLabel.layer.cornerRadius = 5;
    toastLabel.layer.masksToBounds = YES;
    toastLabel.font = theFont;
    toastLabel.text = theMessage;
    
    // 实现可以让toast显示在键盘上方
    [[[[UIApplication sharedApplication] windows] lastObject] addSubview:toastLabel];
    
    toastLabel.center = CGPointMake(bounds.size.width / 2 , bounds.size.height * 2);
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toastLabel.center = CGPointMake(bounds.size.width / 2 ,
                                                         CGRectGetMaxY(toastLabel.superview.frame)
                                                         - 100 - CGRectGetHeight(toastLabel.bounds) / 2);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5
                                               delay:kDelayDuration
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              toastLabel.alpha = 0;
                                          }
                                          completion:^(BOOL finished) {
                                              [toastLabel removeFromSuperview];
                                          }];
                     }];
}

@end
```

## 徽标效果

```objective-c
@interface BadgeView : UIView

@property (nonatomic, assign) NSUInteger unreadNumber;

- (instancetype)initWithOrigin:(CGPoint)origin;
- (instancetype)initWithOrigin:(CGPoint)origin unreadNumber:(NSUInteger)unreadNumber;

@end
```

```objective-c
#import "UIView+Accessor.h"
#define RGBColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define CHFont [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]

@interface BadgeView ()
@property (nonatomic, strong) UILabel *badgeLabel;
@end

@implementation BadgeView

- (instancetype)initWithOrigin:(CGPoint)origin {
    return [self initWithFrame:CGRectMake(origin.x, origin.y, 0, 0)];
}

- (instancetype)initWithOrigin:(CGPoint)origin unreadNumber:(NSUInteger)unreadNumber {
    if (self = [self initWithOrigin:origin]) {
        [self setUnreadNumber:unreadNumber];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBColor(255, 65, 73, 1);
        _badgeLabel = [UILabel new];
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.backgroundColor = self.backgroundColor;
        _badgeLabel.font = CHFont;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setUnreadNumber:(NSUInteger)unreadNumber {
    _unreadNumber = unreadNumber;
    NSString *unreadStr = _unreadNumber > 99 ? [NSString stringWithFormat:@"99+"] : [NSString stringWithFormat:@"%d", _unreadNumber];
    self.width = [unreadStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)
                                           options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:CHFont}
                                           context:nil].size.width + 4;
    self.width = self.width < 20 ? 20 : self.width;
    self.height = 20.0f;
    if(unreadNumber > 0){
        [self setNeedsDisplay];
        self.hidden = NO;
    }else{
        self.hidden = YES;
    }
}

- (void)drawRect:(CGRect)rect {
    NSString *unreadStr = _unreadNumber > 99 ? [NSString stringWithFormat:@"99+"] : [NSString stringWithFormat:@"%d",_unreadNumber];
    _badgeLabel.text = unreadStr;
    self.layer.cornerRadius = self.width > self.height + 5 ? self.width / 3 : self.width / 2;
    [_badgeLabel drawTextInRect:self.bounds];
}

@end
```

## 统计并限制输入长度

```objective-c
@interface TextConfigure : NSObject <UITextViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, assign) NSUInteger maxCount;
@property (nonatomic, strong) UILabel *placeHolderLabel; // only text view use

@end
```

```objective-c
@implementation TextConfigure

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maxCount = 100;
        _countLabel.bounds = CGRectMake(0, 0, 30, 22);
    }
    return self;
}

- (void)setCountLabel:(UILabel *)countLabel {
    if (![_countLabel isEqual:countLabel]) {
        _countLabel = countLabel;
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.bounds = CGRectMake(0, 0, 30, 22);
        _countLabel.textColor = [UIColor lightGrayColor];
        self.countLabel.text = [@(self.maxCount) stringValue];
    }
}

- (void)setMaxCount:(NSUInteger)maxCount {
    if (_maxCount != maxCount) {
        _maxCount = maxCount;
        self.countLabel.text = [@(self.maxCount) stringValue];
    }
}

- (void)setPlaceHolderLabel:(UILabel *)placeHolderLabel {
    if (![_placeHolderLabel isEqual:placeHolderLabel]) {
        _placeHolderLabel = placeHolderLabel;
        _placeHolderLabel.textColor = [UIColor lightGrayColor];
        _placeHolderLabel.text = _placeHolderLabel.text ? : @"请输入内容";
        _placeHolderLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
}

- (void)textDidChange:(NSNotification *)notification {
    NSUInteger length;
    if ([notification.object isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)notification.object;
        length = textView.text.length;
    } else if ([notification.object isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)notification.object;
        length = textField.text.length;
    }
    _countLabel.text = [NSString stringWithFormat:@"%d", self.maxCount - length];
}

- (void)initialNotificationForObject:(id)object {
    static dispatch_once_t onceToken;
    if ([object isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)object;
        dispatch_once(&onceToken, ^{
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(textDidChange:)
                                                         name:UITextViewTextDidChangeNotification
                                                       object:textView];
        });
    } else if ([object isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)object;
        dispatch_once(&onceToken, ^{
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(textDidChange:)
                                                         name:UITextFieldTextDidChangeNotification
                                                       object:textField];
        });
    }
}

#pragma mark - text view delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self initialNotificationForObject:textView];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length) {
        [self.placeHolderLabel setHidden:YES];
    } else {
        [self.placeHolderLabel setHidden:NO];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if(textView.text.length < 1) {
        [self.placeHolderLabel setHidden:NO];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (NSMaxRange(range) + text.length > self.maxCount){
        return NO;
    }
    if (text.length > 0) {
        if(self.countLabel.text.intValue > 0) {
            self.countLabel.text = [NSString stringWithFormat:@"%d",self.maxCount - (NSMaxRange(range) + text.length)];
            if(textView.text.length == self.maxCount - 1) {
                textView.text = [textView.text stringByAppendingString:text];
            }
        }
    } else {
        self.countLabel.text = [NSString stringWithFormat:@"%d",self.maxCount - (textView.text.length - range.length)];
    }

    if (self.countLabel && self.countLabel.text.intValue <= 0) {
        return NO;
    }
    return YES;
}

#pragma mark - text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self initialNotificationForObject:textField];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (NSMaxRange(range)+string.length > self.maxCount) {
        return NO;
    }
    if (string.length > 0) {
        if(self.countLabel.text.intValue > 0) {
            self.countLabel.text = [NSString stringWithFormat:@"%d",self.maxCount - (NSMaxRange(range) + string.length)];
            if(textField.text.length == self.maxCount - 1) {
                textField.text = [textField.text stringByAppendingString:string];
            }
        }
    } else {
        self.countLabel.text = [NSString stringWithFormat:@"%d",self.maxCount - (textField.text.length - range.length)];
    }
    if (self.countLabel.text.intValue <= 0) {
        return NO;
    }
    
    return YES;
}

@end
```

### usage

```objective-c
    // text configure
    _textConfigure = [TextConfigure new];
    _textConfigure.countLabel = _countLabel;
    _textConfigure.maxCount = 20;
    
    // text view
    UILabel *placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    [_textView addSubview:placeHolderLabel];
    _textConfigure.placeHolderLabel = placeHolderLabel;
    _textView.delegate = _textConfigure;

    // text field
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    _textField.rightView = countLabel;
    _textField.rightViewMode = UITextFieldViewModeWhileEditing;
    _textConfigure.countLabel = countLabel;
    _textField.delegate = _textConfigure;
```

## 禁用粘贴功能

覆盖以下方法：

```objective-c
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender NS_AVAILABLE_IOS(3_0) {
    return NO;
}

```

## 判断键盘是否已经升起

```objective-c
- (BOOL)isKeyboardOnScreen {
    BOOL isKeyboardShown = NO;
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    if (windows.count > 1) {
        NSArray *wSubviews =  [windows[1]  subviews];
        if (wSubviews.count) {
            CGRect keyboardFrame = [wSubviews[0] frame];
            CGRect screenFrame = [windows[1] frame];
            if (keyboardFrame.origin.y+keyboardFrame.size.height == screenFrame.size.height) {
                isKeyboardShown = YES;
            }
        }
    }
    
    return isKeyboardShown;
}

+(BOOL) isKeyBoardInDisplay {
    BOOL isExists = NO;
    for (UIWindow *keyboardWindow in [[UIApplication sharedApplication] windows])   {
        if ([[keyboardWindow description] hasPrefix:@"<UITextEffectsWindow"] == YES) {
            isExists = YES;
        }
    }
    
    return isExists;
}
```

## GCD Timer

```objective-c
    __block int completeness = 0;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 0.3 * NSEC_PER_SEC / 18, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (completeness != 100) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view updateDownloadingHUDProgress:completeness];
            });
            completeness++;
        } else {
            dispatch_source_cancel(timer);
        }
    });
    dispatch_source_set_cancel_handler(timer, ^{
//        dispatch_release(timer);
    });
    dispatch_resume(timer);
```

## 在  Storyboard  Autolayout 模式下使用 UIScrollview

- Setting UIViewControl 「Size Inspector」-「Simulated Size」「Freeform」「width: 320 height: 1000」
- Drag a UIScrollview to this UIViewControl's view make sure it's frame is the same with UIViewControl's frame
- Setting the UIScrollview's `frame` and `contentSize` on `viewDidAppear:`