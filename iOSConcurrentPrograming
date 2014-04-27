# iOS多线程编程

- 启动线程的方式
    - detachNewThreadSelector:toTarget:withObject:类方法直接生成一个子线程
    - 创建一个NSThread类实例，然后调用start方法。
    - 调用NSObject的+performSelectorInBackground:withObject:方法生成子线程。
    - 创建一个NSThread子类，然后调用子类实例的start方法