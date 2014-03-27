<h3 id="￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼net"> ￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼网络与多线程 </h3>

**进程的基本概念**
- 每一个进程都是一个应用程序,都有独立的内存空间,一般来说一个应用程序存在- 一个进程,但也多个进程的情况- ￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼视图的操作一定 · 要主线程来完- 同一个进程中的线程共享内存中内存和资源成

**多线程的基本概念**
- 每一个程序都有一个主线程,程序启动时创建(调用main来启动)- 主线程的生命周期是和应用程序绑定的,程序退出(结束)时,主线程也就停止了- 多线程技术表示,一个应用程序有多个线程,使用多线程能提供CPU的使用率,防 止主线程堵塞- 任何有可能堵塞主线程的任务不要在主线程执行(访问网络)

**线程的创建与启动**

```￼￼// 1. 第一种开启新的线程调⽤mutableThreadNSThread *t = [[NSThread alloc] initWithTarget:selfobject:nil];[t start]; // 需要⼿手动开启selector:@selector(mutableThread)￼￼// 2. 第二种开启新的线程调⽤用 mutableThread[NSThread detachNewThreadSelector:@selector(mutableThread)                           toTarget:self withObject:nil];￼￼// 3. 第三种开启新的线程调⽤用 mutableThread[self performSelectorInBackground:@selector(mutableThread)                         withObject:nil];
￼￼// 4.block语法启动⼀一个线程NSOperationQueue *threadQueue = [[NSOperationQueue alloc] init];
    [threadQueue addOperationWithBlock:^(void) {}];NSThread *t = [NSThread currentThread];
if (![t isMainThread]) {    NSLog(@"是多线程");
}￼￼// 5.NSOperation开启⼀一个线程NSOperationQueue *threadQueue = [[NSOperationQueue alloc] init];
NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self
                                                                 selector:@selector(mutableThread)
                                                                   object:nil];
[threadQueue addOperation:op];￼￼// 在主线程上调⽤用 reloadData ⽅方法[self performSelectorOnMainThread:@selector(reloadData)                      withObject:nil waitUntilDone:NO];
```

**NSThread的常用方法**

```￼￼// 判断当前线程是否是多线程+ (BOOL)isMultiThreaded;// 获取当前线程对象+ (NSThread *)currentThread;// 使当前线程睡眠指定的时间,单位为秒+ (void)sleepForTimeInterval:(NSTimeInterval)ti;
// 退出当前线程+ (void)exit;// 判断当前线程是否为主线程+ (BOOL)isMainThread// 启动该线程- (void)start
```

**GCD(Grand Central Dispatch)**

```
// 创建⼀一个队列dispatch_queue_t queue = dispatch_queue_create("test", NULL); 
// 创建异步线程dispatch_async(queue, ^{    // 多线程    // 回到主线程执⾏
    dispatch_async(dispatch_get_main_queue(), ^{    // 主线程
    });});
```

**子线程的内存管理**

```
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼// 创建⼦子线程[self performSelectorInBackground:@selector(mutableThread)                         withObject:nil];
- (void)mutableThread {
    // 创建⾃自动释放池    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];    for (int i=0; i<10; i++) {        NSLog(@"%d",i);        [NSThread sleepForTimeInterval:1];  }  [self performSelectorOnMainThread:@selector(reloadData)
                          withObject:nil
                      waitUntilDone:NO];  [pool release];}
```

**NSRunloop的基本概念**
- Run loops 是线程相关的的基础框架的一部分- 一个 run loop 就是一个事件处理 的循环,用来不停的调度工作以及处理输入事件
- 线程的生命周期存在五个状态:新建、就绪、运行、阻塞、死亡 
- NSRunLoop可以保持一个线程一直为活动状态,不会马上销毁掉

**定时器在多线程的使用**

在多线程中使用定时器必须开启Runloop,因为只有开启Runloop保持线程为活动 状态,才能保持定时器能不断执行

```
￼￼- (void)runThread {    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(timeAction)
                                   userInfo:nil
                                    repeats:YES];
     // 开启Runloop来使线程保持存活状态
     [[NSRunLoop currentRunLoop] run];
     [pool release];}
```

**￼￼￼￼￼￼￼￼HTTP请求**

```
Http请求主要由两部分组成:http请求头、http请求体 ·POST请求才有请求体 ·请求的参数有两种形式:1.放在URL后面,2.放在请求体中
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼URL: http://weibo.com/mechenwei?page=1&pagesize=20HTTP请求头:Accept: text/html,application/xhtml+xml,application/ xml;q=0.9,*/*;q=0.8Accept-Charset: GBK,utf-8;Accept-Encoding: gzip,deflate,sdchAccept-Language: zh-CN,zh;Connection: keep-alive........HTTP请求体: userName=wxhl&password=wxhl2805
```

**￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼HTTP响应**

HTTP响应主要由两部分组成:响应头、响应内容 ·HTTP响应有个状态码,标示响应的结果,例如200表示成功,404未找到页面

```
HTTP响应头:Cache-Control:no-cache, must-revalidate Connection:closeContent-Encoding:gzip Content-Type:text/html; charset=utf-8 Date:Thu, 10 Jan 2013 02:41:29 GMT DPOOL_HEADER:alice82........HTTP响应体: {username:”wxhl”,success:true};
```

**￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼访问网络的基本流程**- 构造NSURL实例(地址)
- 生成NSURLRequest请求
- 通过NSURLConnection发送请求
- 通过返回NSURLRespond实例和NSError实例分析结果
- 接受返回数据
**NSURLRequest的使用**

```NSURLRequest 包装了网络请求的信息。￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼NSURL *url = [NSURL URLWithString:@"http://www.baidu.com:8080/search?id=1"];cachePolicy 缓存策略 
timeoutInterval 超时时间 
NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
```

```
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];[request setURL:url];// 设置请求⽅方式[request setHTTPMethod:@"POST"];// 设置超时时间[request setTimeoutInterval:60];// 设置请求参数[request setHTTPBody:_data];// 设置请求头[request setValue:@"tttt" forHTTPHeaderField:@"cookes"];
```

**  同步请求用法**

```
// 构造urlNSURL *url = [NSURL URLWithString:@"http://www.iphonetrain.com"];// 创建⼀一个请求对象NSURLRequest *request = [NSURLRequest requestWithURL:url]; NSURLResponse *response;// 发送同步请求,请求成功后返回数据NSData *resultData = [NSURLConnection sendSynchronousRequest:request                                    returningResponse:&response                                                error:nil];NSString *dataString = [[NSString alloc] initWithData:resultData                                     encoding:NSUTF8StringEncoding];self.resultText.text = dataString;
```

**￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼异步请求用法**

- 第一种方式

```￼￼NSURL *url = [NSURL URLWithString:request_url];NSURLRequest *request = [NSURLRequest requestWithURL:url];// 发送异步请求[NSURLConnection connectionWithRequest:request delegate:self];￼￼- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
} 

// 接受加载的数据- (void)connectionDidFinishLoading:(NSURLConnection *)connection {    NSString *dataString = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];    self.resultText.text = dataString; 
} 
// 数据加载完以后调⽤用
```

- 第二种方式

```
// 开一个子线程
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼- (IBAction)asychroRequest:(id)sender {      [self performSelectorInBackground:@selector(loadData) withObject:nil];  } 
// 启动⼀一个新的线程加载数据￼￼- (void)loadData {    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; NSURL *url = [NSURL URLWithString:request_url];    NSURLRequest *request = [NSURLRequest requestWithURL:url]; NSURLResponse *response = nil;    // 发送同步请求   NSData *data = [NSURLConnection sendSynchronousRequest:request                                       returningResponse:&response                                                   error:nil];   NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];   [self performSelectorOnMainThread:@selector(afterLoadData:) withObject:stringData waitUntilDone:NO];   [pool release];}
```

**xml和json的基本概念**
- xml:可扩展标记语言,是一种数据交换格式,解析方式一般分为两种Dom和Sax 解析。- Dom解析:把整个数据看做是一个Dom对象,将他们一次性读入内存,功耗大, 解析难度低- Sax解析:Sax采用逐步解析的方式,占用内存小,特点是方便、灵活,解析相对 麻烦- json:一种轻量级的数据交换格式,“{”表示一个字典的开始,“}”表示一个字典 的结束,“[”表示一个数组的开始,“]”表示一个数组的结束。  ￼￼￼￼
**￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼解析的开源框架**
- XML Dom解析,GDataXMLNode,XMLDictionary等
- XML Sax解析,NSXMLParser等- JSON 解析,JSONKit,iOS5之后系统自带解析库等
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼















































