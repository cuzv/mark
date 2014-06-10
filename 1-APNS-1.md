
[Source](http://tanqisen.github.io/blog/2013/02/27/ios-push-apns/ "Permalink to 一步一步实现iOS应用PUSH功能 - Cooper's Blog")

# iOS Push Notification

### 1\. push原理

iOS push 工作机制可以用下图简要概括

![][1]

* `Provider`:应用自己的服务器；
* `APNS`:Apple Push Notification Service的简称，苹果的PUSH服务器；

push的主要工作流程是：

* iOS设备连接网络后，会自动与APNS保持类似TCP的长链接，等待APNS推送消息的到来；
* 应用启动时注册消息推送，并获取设备的在APNS中注册的唯一设备标示deviceToken上传给应用服务器(即Provider)；
* 在需要给应用推送消息时，Provider把push内容、接收push消息的deviceToken按APNS指定的格式打包好，发送给APNS；
* APNS收到Provider发送的消息后，查找deviceToken指定的设备，如果该设备已经和APNS建立了连接，则立即将消息推送给该设备，如果设备不在线，则在该设备下次连接到APNS后将消息推送到设备。请注意苹果并不保证推送一定成功；
* 设备收到push消息后，iOS系统会根据SSL证书判断这个push消息是发给那个应用的，进而启动相应客户端。

&gt; 上述过程中，有两个关键步骤需要自己处理的是：1.客户端获取deviceToken，并上传到Provider；2.Provider发送push消息到APNS。这两个步骤中都需要苹果的push证书授权，下面就来介绍如何生成push证书，以及Provisioning Profile。

### 2\. push证书及Provisioning Profile生成

* 用付费帐号登录到

* 生成push证书前要先生成开发证书

生成开发证书的过程不详细介绍，可以参考[如何联机调试和发布程序][2]。只是有一点需要注意的，生成开发证书过程中需要通过Keychain生成一个CSR文件，默认名为CertificateSigningRequest.certSigningRequest，这个文件将在生成push证书的时候用到。

* 创建一个App ID

    * 创建过程中Description可以任意填写，比如叫`push_demo`；
    * Bundle Identifier一般用`com.company.appname`这样的格式，例如`com.mycompany.demo`；

&gt; 注意：要用push功能的Bundle Identifier一定不能出现通配符，比如`com.mycompany.*`，这样的名字是不能使用push的。

* 生成Push SSL Certificate

生成好App ID后点击`Configure`进入配置页。打开`Enable for Apple Push Notification service`选项，该选项下有`Development Push SSL Certificate`和`Production Push SSL Certificate`两个SSL Certificate可以配置，前面一个是用来的开发的push证书，后面一个是用来发布的。我们以开发push证书为例，点击`Development Push SSL Certificate`-&gt;`Configure`，后面会要求选择CSR文件，这就是生成开发证书时的CertificateSigningRequest.certSigningRequest文件，选择好CSR后就生成好相应的SSL Certificate了。下载下来，保存名为`aps_developer.cer`。

* 从Keychain中导出私钥、设置好密码，命名为private_key.p12

* 生成push证书

    * 这时我们一共得到3个文件:

        1. CertificateSigningRequest.certSigningRequest
        2. private_key.p12
        3. aps_developer.cer
    * 将aps_developer.cer转成pem格式

                openssl x509 -in aps_developer.cer -inform DER -out aps_developer.pem -outform PEM


    * 将private_key.p12格式的私钥转换成private_key.pem

                openssl pkcs12 -nocerts -out private_key.pem -in private_key.p12


&gt; 这一步会要求输入p12私钥的密码，以及设置新生成的pem的密码。

    * 创建用于服务端的SSL p12格式证书，命名为aps_developer.p12

                openssl pkcs12 -export -in aps_developer.pem -inkey private_key.pem -certfile CertificateSigningRequest.certSigningRequest -name "aps_developer" -out aps_developer.p12


&gt; 这一步会要求输入private_key.pem的密码，注意不是private_key.p12的密码。如果密码错误，或者CertificateSigningRequest.certSigningRequest文件不匹配都不能正常生成aps_developer.p12文件，如果生成的aps_developer.p12文件大小是0，说明生成过程中出了问题，请检查pem私钥、密码、以及CertificateSigningRequest.certSigningRequest是否正确。

aps_developer.p12就是Provider向APNS发送push消息需要的SSL证书。把这个证书和密码提供给服务端，服务端就可以发送push消息给APNS了。这时服务端已经可以工作了，但客户端还必须配置相应的Provisioning Profile才能启动应用的push功能。

&gt; 服务器配置需注意的是，由于我们生成的是开发环境的push证书，所以服务器应该连接APNS的sandbox环境地址：`gateway.sandbox.push.apple.com:2195`，如果应用正式发布，就要连接正式环境，必须生成相应的发布证书，并连接APNS正式环境地址：`gateway.push.apple.com:2195`。

* 生成Provisioning Profile

    * 新建Profile，命名为push_dev；
    * 选择相应证书；
    * App ID选择push_demo;
    * 选择设备；
    * 下载并安装该Profile供开发使用；

### 3\. Xcode证书设置、Info.plist设置

* 用Xcode打开客户端工程，设置Info.plist的Bundle identifier为`com.mycompany.demo`。
* 打开工程设置，必须将证书设置为与push_dev关联的证书。

### 4\. 客户端获取deviceToken

服务端要发送push消息给某一设备还必须知道该设备的deviceToken。应用运行后获取到deviceToken，然后上传给服务器，下面介绍应用如何获取deviceToken。应用必须先注册使用push功能。


      - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
          [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
          // do something
          // ...
      }

在AppDelegate中添加下面方法来获取deviceToken：

      - (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
          NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
          NSLog(@"%@", token);
      }

      - (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
          NSLog(@"%@", error);
      }

应用获取到deviceToken后，上传给Provider，Provider就可以用这个deviceToken给这个设备push消息了。

### 5\. Payload格式及自定义数据

服务器配置好证书并拿到deviceToken后就可以向APNS发送消息了。发送消息的格式如下图所示：

![][3]

Payload就是push的消息负载，这就是应用需要关心的数据。 Payload是一个JSON字典，最大值是 256 字节，超过这个限制，APNS将拒绝转发。基本格式如下：

      {
        "aps": {
          "alert":"Hello Push!",
          "badge":1,
          "sound":"default"
        }
      }

必须包含`aps`键值。`badge`表示应用程序图标显示的数字，`sound`表示收到push的提示音。 Payload的具体结构参考[Apple Push Notification Service][4]

要在这个结构中新增自定义数据，请加在aps空间之外。比如后台推送消息给应用同时要求应用打开某个页面：

      {
        "aps": {
          "alert":"Hello Push!",
          "badge":1,
          "sound":"default"
        },
        "page":"home"
      }

后台告诉客户端收到这个push后打开应用的主页，这里的page、home都是自己定义的。必须注意的是，Payload大小不能超过限制，所以可以把自定义数据更简化点，比如可以把home与编号1对应，page简写为p，这样`"p":1`表示打开主页，可以缩小Payload的大小。

### 6\. 客户端接收push消息

iOS系统收到push消息后，如果用户点击查看，系统将根据证书启动相应应用。如果应用已经启动，将调用AppDelegate的方法：

      - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
          // userInfo 就是push消息的Payload
      }



如果应用还没有启动，通过push冷启动后，仍然能在启动后获取Payload：

      - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
          NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
          NSLog(@"Payload: %@", userInfo);
      }

目前为止，push功能基本就完成了，可以开始push功能测试了，如果服务器还没开发完成，或者想快速测试是否能正常push，可以使用下面的代码实现后台push测试。发送push前要配置好SSL证书，以及deviceToken和Payload结构。

[object c 版本][5]
[c 版本][6]
[java 版本][7]
[php 版本][8]


还有个小问题，当Payload设置了badge，应用图标上将一直显示一个数字提示，如果要清除数字提示，或者设置成其他数字，调用下面函数就可以完成。

      [[UIApplication sharedApplication] setApplicationIconBadgeNumber:number];

number为0就会清除数字提示。

[1]: http://tanqisen.github.io/images/ios_push.jpg
[2]: http://www.cocoachina.com/bbs/read.php?tid=7923&amp;keyword=%B7%A2%B2%BC
[3]: http://tanqisen.github.io/images/ios_push_payload.jpg
[4]: http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/ApplePushService/ApplePushService.html
[5]: https://github.com/stefanhafeneger/PushMeBaby
[6]: https://github.com/kumaranvram/PushNotificationApp
[7]: https://github.com/qiaohe/pushNotificationService
[8]: https://github.com/dsaki/PushNotification
  