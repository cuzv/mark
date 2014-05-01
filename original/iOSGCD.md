## GCD中有三种队列类型

- The main queue: 与主线程功能相同。实际上，提交至main queue的任务会在主线程中执行。
  main queue可以调用dispatch_get_main_queue()来获得。因为main queue是与主线程相关的,
  所以这是一个串行队列。
- Global queues: 全局队列是并发队列，并由整个进程共享。
  进程中存在三个全局队列：高、中（默认）、低三个优先级队列。
  可以调用dispatch_get_global_queue函数传入优先级来访问队列。
- 用户队列: 用户队列 (GCD并不这样称呼这种队列, 但是没有一个特定的名字来形容这种队列，
  所以我们称其为用户队列) 是用函数 dispatch_queue_create 创建的队列. 这些队列是串行的。
  正因为如此，它们可以用来完成同步机制, 有点像传统线程中的mutex。

```
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self goDoSomethingLongAndInvolved];
		        dispatch_async(dispatch_get_main_queue(), ^{
					[textField setStringValue:@"Done doing something long and involved"];
				});
});
```

```
dispatch_queue_t bgQueue = myQueue;
    dispatch_async(dispatch_get_main_queue(), ^{
		NSString *stringValue = [[[textField stringValue] copy] autorelease];
			dispatch_async(bgQueue, ^{
				// use stringValue in the background now
			});
});

```

要用于同步机制，queue必须是一个用户队列，而非全局队列，所以使用usingdispatch_queue_create初始化一个。
然后可以用dispatch_async 或者 dispatch_sync将共享数据的访问代码封装起来：

```
- (id)something {
	
    __block id localSomething;
	dispatch_sync(queue, ^{
		localSomething = [something retain];
	});
	return [localSomething autorelease];
}
						 
- (void)setSomething:(id)newSomething {
	
	dispatch_async(queue, ^{
		if(newSomething != something) {
			
			[something release];
			something = [newSomething retain];
			[self updateSomethingCaches];
		}
	});
}
```
