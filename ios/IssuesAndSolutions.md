# Issues & Solutinos

[让Category支持添加属性与成员变量](#让-category支-持添加属性与成员变量)

## 让Category支持添加属性与成员变量

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
