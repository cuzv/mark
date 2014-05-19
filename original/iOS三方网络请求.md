# 三方网络请求

- - -

## 使用ASIHTTPRequest需要导入其依赖库：

- SystemConfiguration.framework
- MessageUI.framework
- MobileCoreServices.framework
- CFNetwork.framework
- libz.1.2.5.dylib

## NOTE
- ASIHTTPRequest类用于实现HTTP GET请求，也是作为POST请求的父类
- ASIHTTPRequest继承于NSOperation，所以即可以直接被执行，也可以加入队列中由队列管理
- ASIFormDataRequest继承于ASIHTTPRequest，实现了HTTP POST请求，并拥有父类的全部特性
- ASINetworkQueue继承于NSOperationQueue，提供了网络请求队列功能，管理其内部的所有请求

- - -

##  GDataXMLNode

- 需要导入的依赖库：libxml2.dylib
- 修改工程配置target -> build setting -> header search path -> ${SDKROOT}/usr/include/libxml2

		- (id)initWithXMLString:(NSString *)str options:(unsigned int)mask error:(NSError `**`)error;

## 节点解析

	- (NSArray *)elementsForName:(NSString *)name;
	- (NSArray *)children;

## XPath解析

	- (NSArray *)nodesForXPath:(NSString *)xPath error:(NSError `**`)error;

- - - 

## SDWebImage 图片异步加载

*SDWebImage是基于ARC的*

依赖库：

	- ImageIO.framework
	- MapKit.framework

### 图片异步加载方法

	- (void)setImageWithURL:(NSURL *)url placeHolderImage:(UIImage *)placeholder;
	- (void)setImageWithURL:(NSURL *)rul forState:(UIControlState)state;

### 清除图片缓存

    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];