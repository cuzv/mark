
[Source](http://blog.csdn.net/cuzval/article/details/11519193 "Permalink to 黑马程序员_网络编程 - cuzval的专栏 - 博客频道")

# 网络编程

udp发送和接收：

发送步骤：

1,既然要进行udp协议的网络通信，当然要建立udp的socket服务.
DatagramSocket ds = new DatagramSocket(10000);

2,确定发送的具体的数据。
String str = "hi，udp 哥们来了！";
byte[] buf = str.getBytes();

3,创建数据包对象，因为udp协议是需要将数据封装到指定的数据包中。
DatagramPacket dp = new DatagramPacket(buf,buf.length,InetAddress.getByName("192.168.1.100"),10000);



4,使用udpsocket服务的send方法。将数据包发出。
ds.send(dp);

5,关闭资源。
ds.close();


接收步骤：

1,创建udp socket服务对象。绑定一个指定的端口。给该应用程序分配一个数据标示。也可以称之为监听一个端口。
DatagramSocket ds = new DatagramSocket(10000);

2,创建数据包，用于存储接收到的数据，并用数据包对象的方法对数据包中的内容进行解析。
byte[] buf = new byte[1024];
DatagramPacket dp = new DatagramPacket(buf,buf.length);

3,使用socket对象的receive方法将接收到的数据都存储到数据包的对象中。
ds.receive(dp);//阻塞式方法。&nbsp;

4,既然数据已经存储到数据包中，直接用数据包的方法对这些数据进行解析。&nbsp;
//获取ip。
String ip = dp.getAddress().getHostAddress();
//获取port
int port = dp.getPort();
//获取数据内容。
byte[] data = dp.getData();
String text = new String(data,0,dp.getLength());
System.out.println(ip+":"+port+"::"+text);

5,关闭资源。
ds.close();


TCP客户端和服务端：

客户端：

1,创建tcp客户端对象。必须要有socket服务。客户端通常一建立，就需要去进行连接。
因为这是面向连接的协议。所以必须明确要连接那个主机，以及端口。
Socket s = new Socket("192.168.1.100",10002);

2，连接一旦建立，就形成了数据传输的通道，其实该通道就是IO流。而这个IO流是有socket建立的。
//所以称之为socket io流。该流中也有输入流和输出流。
//想要通过socket io 流获取输出流。
OutputStream out = s.getOutputStream();

3，使用输出流对象将数据写入。
&nbsp;out.write("hi，tcp 哥们又来了!~".getBytes());
&nbsp;
4，关闭资源。
s.close();


服务端：

1，创建tcp服务端对象。并监听一个端口。&nbsp;
ServerSocket ss = new ServerSocket(10002);

2，获取客户端对象和指定的客户端进行通信。该方法是 accept();
Socket s = ss.accept();
//获取一次客户端ip地址。
String ip = s.getInetAddress().getHostAddress();
System.out.println(ip+"....connected");

3,有了socket，就可以获取其中的流，必须要读取客户端的数据，需要获取读取流。
InputStream in = s.getInputStream();
byte[] buf = new byte[1024];
int len = in.read(buf);
String &nbsp;text = new String(buf,0,len);
System.out.println(text);

4，关闭资源：
s.close();// 关闭客户端。
ss.close();//关闭服务端。


UDP应用实例：


    package com.itheima.net;

    import java.io.BufferedReader;
    import java.io.IOException;
    import java.io.InputStreamReader;
    import java.net.DatagramPacket;
    import java.net.DatagramSocket;
    import java.net.InetAddress;
    import java.net.SocketException;
    import java.net.UnknownHostException;

    public class UDPChatDemo
    {

    	public static void main(String[] args) throws SocketException
    	{
    		sop("hello,word!");
    		DatagramSocket send = new DatagramSocket(10002);
    		DatagramSocket rece = new DatagramSocket(10001);

    		new Thread(new Send(send)).start();
    		new Thread(new Rece(rece)).start();
    	}

    	public static void sop(Object obj)
    	{
    		System.out.println(obj);
    	}
    }

    class Send implements Runnable
    {
    	private DatagramSocket ds;

    	public Send(DatagramSocket ds)
    	{
    		super();
    		this.ds = ds;
    	}

    	@Override
    	public void run()
    	{
    		try
    		{
    			BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
    			String line = null;
    			for (;(line=br.readLine()) != null;)
    			{

    				byte[] buf = line.getBytes();
    				DatagramPacket dp = new DatagramPacket(buf, buf.length, InetAddress.getByName("127.0.0.1"), 10001);
    				ds.send(dp);
    				if ("over".equals(line))
    					break;
    			}
    		}
    		catch (UnknownHostException e)
    		{
    			e.printStackTrace();
    		}
    		catch (IOException e)
    		{
    			e.printStackTrace();
    		}
    		finally
    		{
    			ds.close();
    		}
    	}
    }

    class Rece implements Runnable
    {
    	private DatagramSocket ds;

    	public Rece(DatagramSocket ds)
    	{
    		super();
    		this.ds = ds;
    	}

    	@Override
    	public void run()
    	{
    		try
    		{
    			byte[] buf = new byte[1024];
    			while (true)
    			{
    				DatagramPacket dp = new DatagramPacket(buf, buf.length);
    				ds.receive(dp);
    				String ip = dp.getAddress().getHostAddress();
    				String text = new String(dp.getData(), 0, dp.getLength());
    				System.out.println(ip+":"+text);
    				if ("over".equals(text))
    					System.out.println(ip+"gone...");
    			}
    		} catch (IOException e)
    		{
    			e.printStackTrace();
    		}
    		finally
    		{
    			ds.close();
    		}
    	}
    }

TCP应用实例：

上传图片：

客户端程序：


    package com.itheima.net;

    import java.io.FileInputStream;
    import java.io.OutputStream;
    import java.io.IOException;
    import java.io.InputStream;
    import java.net.Socket;
    import java.net.UnknownHostException;

    public class UploadPicClient
    {
    	private static final String	FILE_SEPARTOR	= System.getProperty("file.separator");

    	/**
    	 * @param args
    	 * @throws IOException
    	 * @throws UnknownHostException
    	 */
    	public static void main(String[] args) throws UnknownHostException, IOException
    	{
    		Socket so = new Socket("127.0.0.1" ,10027);

    		FileInputStream fis = new FileInputStream("TempFile"+FILE_SEPARTOR+"keyboard.jpg");

    		OutputStream out = so.getOutputStream();

    		byte[] buf = new byte[1024];

    		int len = 0;
    		while ((len=fis.read(buf)) != -1)
    		{
    			out.write(buf, 0, len);
    		}

    		so.shutdownOutput();

    		InputStream in = so.getInputStream();
    		byte[] bufIn = new byte[1024];
    		int lenIn = in.read(bufIn);
    		String info = new String(bufIn, 0, lenIn);
    		System.out.println(info);

    		fis.close();
    		so.close();
    	}
    }



服务端程序：


    package com.itheima.net;

    import java.io.FileOutputStream;
    import java.io.IOException;
    import java.io.InputStream;
    import java.io.OutputStream;
    import java.net.ServerSocket;
    import java.net.Socket;

    public class UploadPicServer
    {

    	private static final String	FILE_SEPAROTR	= System.getProperty("file.separator");

    	/**
    	 * @param args
    	 * @throws IOException
    	 */
    	public static void main(String[] args) throws IOException
    	{
    		// TODO Auto-generated method stub
    		ServerSocket ss =new ServerSocket(10027);

    		Socket s = ss.accept();

    		System.out.println(s.getInetAddress().getHostAddress()+"----connected");

    		InputStream in = s.getInputStream();

    		FileOutputStream fos = new FileOutputStream("TempFile"+FILE_SEPAROTR+"up.jpg");

    		byte[] buf = new byte[1024];
    		int len = 0;
    		while ((len=in.read(buf)) != -1)
    		{
    			fos.write(buf, 0, len);
    		}

    		OutputStream out = s.getOutputStream();
    		out.write("upload successed!".getBytes());

    		fos.close();
    		s.close();
    		ss.close();
    	}

    }


上传文本：

客户端程序：


    package com.itheima.net;

    import java.io.BufferedReader;
    import java.io.FileReader;
    import java.io.IOException;
    import java.io.InputStreamReader;
    import java.io.PrintWriter;
    import java.net.Socket;
    import java.net.UnknownHostException;



    public class UploadTextClient
    {

    	private static final String	FILE_SEPARTOR	= System.getProperty("file.separator");
    	/**
    	 * @param args
    	 * @throws IOException
    	 * @throws UnknownHostException
    	 */
    	public static void main(String[] args) throws UnknownHostException, IOException
    	{
    		// 创建客户端socket服务
    		Socket so = new Socket("127.0.0.1" ,10092);

    		// 读取本读文件
    		BufferedReader br = new BufferedReader(new FileReader("TempFile"+FILE_SEPARTOR+"uptext"));

    		// 目的：网络
    		PrintWriter out = new PrintWriter(so.getOutputStream(), true);
    		String line = null;
    		while ((line=br.readLine()) != null)
    		{
    			out.println(line);
    		}

    		// 结束标记
    		so.shutdownOutput();

    		// 给反馈信息
    		BufferedReader bufIn = new BufferedReader(new InputStreamReader(so.getInputStream()));
    		String text = bufIn.readLine();
    		System.out.println("server:"+text);
    		bufIn.close();
    		so.close();
    	}
    }


服务端程序：


    package com.itheima.net;

    import java.io.BufferedReader;
    import java.io.FileWriter;
    import java.io.IOException;
    import java.io.InputStreamReader;
    import java.io.PrintWriter;
    import java.net.ServerSocket;
    import java.net.Socket;

    public class UploadTextServer
    {

    	private static final String	FILE_SEPARTOR = System.getProperty("file.separator");

    	/**
    	 * @param args
    	 * @throws IOException
    	 */
    	public static void main(String[] args) throws IOException
    	{
    		// 创建服务端socket服务
    		ServerSocket ss = new ServerSocket(10092);

    		// 获取客户端对象
    		Socket s = ss.accept();

    		System.out.println(s.getInetAddress().getHostAddress()+"-----connected!");

    		// 读取信息
    		BufferedReader bufIn = new BufferedReader(new InputStreamReader(s.getInputStream()));

    		// 存储数据
    		PrintWriter pw = new PrintWriter(new FileWriter("TempFile"+FILE_SEPARTOR+"upserver"), true);

    		String line = null;
    		while ((line=bufIn.readLine()) != null)
    		{
    			pw.println(line);
    		}

    		// 给反馈
    		PrintWriter out = new PrintWriter(s.getOutputStream(), true);
    		out.println("upload successed!");

    		pw.close();
    		s.close();
    		ss.close();
    	}
    }


网络编程总结：

1,常见的客户端和服务端。
客户端：浏览器。
服务端：Tomcat。

2，
客户端：浏览器。
服务端：自定义。&nbsp;
浏览器给服务端发送的数据是：
http协议的请求消息：

GET /myweb/1.html HTTP/1.1 // 请求行 包含： &nbsp;请求方式(GET,POST)空格 请求的资源路径 空格 http的协议版本。&nbsp;
下面这些都是请求消息头中属性信息。
Accept: image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, application/xaml+xml, application/x-ms-xbap, application/x-ms-application, */*
Accept-Language: zh-cn
Accept-Encoding: gzip, deflate
User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; InfoPath.2; .NET4.0C)
Host: 192.168.1.100:9090
Connection: Keep-Alive
空行
请求体(这次请求没有请求体)

3，
浏览器：自定义
服务器：Tomcat。

自定义的浏览器已经收到了服务端返回的数据。

在数据之前发现以下内容：这些是HTTP协议的应答消息。

HTTP/1.1 200 OK //应答行 &nbsp;http协议版本 &nbsp;应答状态码 &nbsp; 应答状态状态码信息码描述
应答消息头的属性信息
Server: Apache-Coyote/1.1
ETag: W/"199-1323480176984"
Last-Modified: Sat, 10 Dec 2011 01:22:56 GMT
Content-Type: text/html
Content-Length: 199
Date: Fri, 10 Aug 2012 06:55:44 GMT
Connection: close
空行
应答体
\---------------------------------------
开发结构有两种：
1，C/S结构。
client / server &nbsp;客户端和服务端。
特点：


* 客户端和服务端的软件都需要程序员进行编写。
* 客户端维护起来较为麻烦。
* 客户端的存在可以将一部分运算分离到客户端来运行，减轻了服务器端的压力。&nbsp;

2，B/S结构。
browser / server 浏览器和服务端。
特点：


* 客户端不用程序员编写，直接使用系统中具备的浏览器软件作为客户端即可。程序员只需要编写服务器端就哦了。
* 维护起来也很容易，因为只要维护服务器即可。
* 所有的运算都在服务器端，相对压力较大。&nbsp;  


[Source](http://blog.csdn.net/cuzval/article/details/11964531 "Permalink to 黑马程序员_反射技术和正则表达式 - cuzval的专栏 - 博客频道")

## 反射技术和正则表达式

&nbsp;-----------------  [ android培训][1]、[java培训][1]、期待与您交流！ ----------

如何获取Class对象呢？
方式一：


* &nbsp;通过对象的getClass方法进行获取。
* 麻烦在于每次是不是都需要具体的类和该类的对象，以及调用getClass方法。


    Person p = new Person();
    Class clazz = p.getClass();

方式二：


* 任何数据类型都具备着一个静态的属性class，这个属性直接获取到该类型的对应Class对象。
* 比第一种简单，不用创建对象，不用调用getClass方法。
* 但是还是要使用具体的类，和该类中的一个静态属性class完成。&nbsp;


    Class clazz = Person.class;

方式三：


* 这种方式较为简单，只要知道的类的名称即可。
* 不需要使用该类，也不需要去调用具体的属性和行为。就可以获取到Class 对象了。&nbsp;
* 这种仅知道类名就可以获取该类字节码对象的方式，更有利于扩展。


    String className = "cn.itcast.bean.Person";
    Class clazz = Class.forName(className);

通过Class创建对象：

1，查找并加载Person.class文件进内存，并将该文件封装成Class对象。

2，在依据Class对象创建该类具体的实例。

3，调用构造函数对对象进行初始化。&nbsp;



    String className = "cn.itcast.bean.Person";
    Class clazz = Class.forName(className);
    Object  obj = clazz.newInstance();

如果指定的类中没有空参数的构造函数。或者要创建的类对象需要通过指定的构造函数进行初始化。

这时就不能使用newInstance方法了。既然要通过指定的构造函数进行对象的初始化。就必须先获取这个构造函数。


    String className = "cn.itcast.bean.Person";
    Class clazz = Class.forName(className);

    //获取指定类中的指定的构造函数。
    Constructor constructor = clazz.getConstructor(String.class,int.class);

    //创建对象。对象的建立都需要构造函数的初始化。 怎么创建对象可以通过构造器对象完成。
    Object obj = constructor.newInstance("lisi",20);

如何获取字段，并对字段进行赋值和获取。&nbsp;


    String className = "cn.itcast.bean.Person";
    Class clazz = Class.forName(className);

    //获取该类中的名称为age的字段
    Field ageField = clazz.getDeclaredField("age");

    //System.out.println(ageField);
    //想要给该变量赋值。 必须先要有对象。

    Object obj = clazz.newInstance();

    //对该私有字段进行取消权限检查的能力。
    ageField.setAccessible(true);//暴力访问。
    ageField.set(obj, 19);

    Object o = ageField.get(obj);
    System.out.println(o);


访问类中的方法


    String className = "cn.itcast.bean.Person";
    Class clazz = Class.forName(className);
    Method method = clazz.getMethod("toString", null);

    //获取能调用该方法的对象。
    Object obj = clazz.newInstance();
    Object returnValue = method.invoke(obj, null);
    System.out.println(returnValue);


    String className = "cn.itcast.bean.Person";
    Class clazz = Class.forName(className);
    Method method = clazz.getMethod("show", null);
    method.invoke(null, null);


    String className = "cn.itcast.bean.Person";
    Class clazz = Class.forName(className);
    Method method = clazz.getMethod("function", String.class,int.class);
    Object obj = clazz.newInstance();
    method.invoke(obj, "haha",89);


Person类的代码：


    public class Person {
    	private String name;
    	private int age;
    	public Person() {
    		super();
    		System.out.println("person run");

    	}
    	public Person(String name, int age) {
    		super();
    		this.name = name;
    		this.age = age;
    	}

    	public String toString() {

    		return name+":"+age;
    	}


    	public static void show(){
    		System.out.println("person static show run");
    	}

    	public void function(String a,int b){
    		System.out.println("person param function "+a+","+b);
    	}

    	private void prviateShow(){
    		System.out.println("person private show run");
    	}
    }

* 正则表达式：就是用操作字符串数据的规则表达式。
* 规则：就是用一些符号组成，每个符号都代表着特有的含义。其实这些符号想当于对应着底层一段代码。对外提供符号是简化了操作。&nbsp; &nbsp;
* 弊端：必须要先学习这些符号。符号多了，阅读性会较差。


正则表达式对字符串的常见操作：
1，匹配。
使用的是String类中的matchers方法。
2，切割。
使用的是String类中的split方法。&nbsp;
3，替换。
使用的是String类中的replaceAll方法。
4，获取。
将匹配的规则的内容获取出来。
使用到正则表达式对象。Pattern

使用步骤：


* 先将正则表达式编译成Pattern对象。
* 通过Pattern对象的matcher方法获取Matcher匹配器对象。
* 通过匹配器对象的方法，将正则规则作用到字符串上以便于操作。

需求：对QQ号进行校验。要求：5~15 位，不能以0开头，必须是数字。

regex = "[1-9][0-9]{4,14}";


    package com.itheima.regex.demo;
    import java.util.regex.Matcher;
    import java.util.regex.Pattern;
    public class RegexDemo3 {
    	public static void main(String[] args) {
    		checkTel();
    		splitDemo();
    		replaceAllDemo();
    		getDemo();
    	}

    	public static void getDemo(){
    		String str = "da jia zhu yi le ,yao pai wei dian ying la !";
    		String reg = "\b[a-z]{3}\b";//三个字母组成的单词都取出来。
    		//正则规则被编译成Pattern对象。
    		Pattern p = Pattern.compile(reg);
    		//通过正则对象的方法matcher和字符串想关联获取匹配器对象。
    		Matcher m = p.matcher(str);
    		//使用匹配器的方法对字符串进行操作。
    		while(m.find()){
    			System.out.println(m.start()+"---"+m.group()+"----"+m.end());
    		}
    	}

    	//替换演示。
    	public static void replaceAllDemo(){
    //		String str = "werqqtyuzzzio";
    //		str = str.replaceAll("(.)\1+","$1");//后一个参数可以通过$数字 引用前一个参数中的组。

    		String str = "15812345678";
    		str = str.replaceAll("(\d{3})\d{4}(\d{4})","$1****$2");
    		System.out.println(str);
    	}

    	//切割演示，
    	public static  void splitDemo(){
    //		String str = "23    19 -1 9 56";
    //		String[] arr = str.split(" +");

    //		String str = "zhangsan.lisi.wangwu";
    //		String[] arr = str.split("\.");

    		String str  = "werqqtyuzzzio";
    		String[] arr = str.split("(.)\1+");
    		for(String s : arr){
    			System.out.println(s);
    		}
    	}

    	//匹配演示。对手机号码进行校验。
    	public static void checkTel(){
    		String str = "158000001111";
    		String reg = "1[358]\d{9}";
    		boolean b = str.matches(reg);
    		System.out.println(str+":"+b);
    	}
    }



192.108.90.34 &nbsp;10.10.10.10 &nbsp;5.5.5.5 &nbsp; &nbsp;30.107.100.5

对ip地址字符串中的ip地址进行排序。按照ip的分类顺序

* &nbsp;为了排序方便。最好让ip中的每一段都是三位，这样就可以用字典顺序进行排序了。
* &nbsp;给每一段进行补零的操作。
* &nbsp;而每一段需要的补的零又不一样多，咋办？
* &nbsp;干脆，都按最多的两个零补。
* &nbsp;然后在每一段保留最后三位。


    String ip = "192.108.90.34  10.10.10.10  5.5.5.5    30.107.100.5";

    		ip = ip.replaceAll("(\d+)", "00$1");
    		System.out.println(ip);
    		ip = ip.replaceAll("0*(\d{3})","$1");
    		System.out.println(ip);

    		String[] ips = ip.split(" +");

    		Arrays.sort(ips);

    		for(String i : ips){
    			System.out.println(i.replaceAll("0*(\d+)", "$1"));
    		}


&nbsp;&nbsp;


&nbsp;
&nbsp;&nbsp;
&nbsp;&nbsp;
&nbsp;&nbsp;
&nbsp;&nbsp;
&nbsp;&nbsp;


[1]: http://www.itheima.com
  
  

[Source](http://blog.csdn.net/cuzval/article/details/13090833 "Permalink to 黑马程序员_类加载器和代理 - cuzval的专栏 - 博客频道")

## 类加载器和代理

* ava虚拟机中可以安装多个类加载器,系统默认三个主要 类加载器,每个类负责加载特定位置的类:&nbsp;BootStrap,ExtClassLoader,AppClassLoader
* 类加载器也是Java类,因为其他是java类的类加载器本⾝身 也要被类加载器加载,显然必须有第⼀一个类加载器不是不 是java类,这正是BootStrap
* Java虚拟机中的所有类装载器采⽤用具有父子关系的树形结 构进⾏行组织,在实例化每个类装载器对象时,需要为其指 定⼀一个⽗父级类装载器对象或者默认采⽤用系统类装载器为其父级类加载

1\. 逐一编写如下代码来说明放置在不同位置的类确实由不同的类加载器加载的:

System.out.println(ClassLoaderTest.class.getClassLoader().getClass().getName()); //将上面语句的测试类改为System则抛NullPointerException,这两个类存放位置不同

System.out.println(System.class.getClassLoader().getClass().getName()); 改为System.out.println(System.class.getClassLoader());打印的结果为null。

2.用下面的代码让查看类加载器的层次结构关系ClassLoader loader = ClassLoaderTest.class.getClassLoader();

//打印出当前的类装载器,及该类装载器的各级父类装载器&nbsp;

while(loader != null){

System.out.println(loader.getClass().getName());&nbsp;

loader = loader.getParent();

}

![][1]


当Java虚拟机要加载⼀一个类时,到底派出哪个类加载器去加载 呢?

* 首先当前线程的类加载器去加载线程中的第⼀一个类。&nbsp;如果类A中引⽤用了类B,Java虚拟机将使⽤用加载类A的类装载器来加载类
* 还可以直接调⽤用ClassLoader.loadClass()⽅方法来指定某个类加载器去加载某个类。

每个类加载器加载类时,⼜又先委托给其上级类加载器。

* 当所有祖宗类加载器没有加载到类,回到发起者类加载器,还加载不 了,则抛ClassNotFoundException,不是再去找发起者类加载器的⼉儿 ⼦子,因为没有getChild⽅方法,即使有,那有多个⼉儿⼦子,找哪⼀一个呢?
* 对着类加载器的层次结构图和委托加载原理,解释先前将&nbsp;ClassLoaderTest输出成jre/lib/ext⺫⽬目录下的itcast.jar包中后,运⾏行结果为&nbsp;ExtClassLoader的原因。

每个ClassLoader本身只能分别加载特定位置和目录中的类,但它们可以委托其他的类装载器去加载类,这就是类加载器的委托模 式。类装载器一级级委托到BootStrap类加载器,当BootStrap无法加载当前所要加载的类时,然后才一级级回退到子孙类装载器去进 行真正的加载。当回退到最初的类装载器时,如果它自己也不能完成类的装载,那就应报告ClassNotFoundException异常。

&nbsp;

![][2]



    使用代理的好处：

* 要为系统中的各种接口的类增加代理功能,那将需要太多的代理类,全部采用静态代理方式,将是一件非常麻烦的事情
* JVM可以在运行期动态生成出类的字节码,这种动态生成的类往往被用作代理类,即动态代理类。&nbsp;
* JVM生成的动态类必须实现⼀一个或多个接口,所以,JVM生成的动态类只能用作具有相同接口的目标类的代理。&nbsp;
* CGLIB库可以动态生成一个类的子类⼀一个类的子类也可以用作该类的代理,所以,如果要为一个没有实现接口的类生成动态代理类,那么可以使用CGLIB库。&nbsp;


    代理类的各个方法中通常除了要调用目标的相应方法和对外返回目标返回的结果外,还可以在代理⽅方法中的如下四个位置加上系统功能代码:


* 在调用目标方法之前
* 在调用目标方法之后
* 在调用目标方法前后
* 在处理目标方法异常的catch块中&nbsp;




[1]: http://img.blog.csdn.net/20131026094036265?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY3V6dmFs/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast
[2]: http://img.blog.csdn.net/20131026171923437?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY3V6dmFs/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast
  