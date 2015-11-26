# java IO

字符流的由来：


* 以前处理数据都是字节数据，使用字节流技术就可以完成了。
* 因为后期编码表的不断出现，识别某一文字的码表不唯一。比如中文，GBK，unicode都可以识别。就出出现了编码问题。
* 中文字节数据 gbk --&gt; 流处理---&gt;gbk解析可以了。&nbsp;
后期：容器出现这样的问题：


* 中文字节数据gbk --&gt; 流处理 unicode来处理--&gt;数据错误。
* 为了处理文字数据，就需要通过 字节流技术+编码表 相结合来完成。注意：只有文字是这样的，因为文字涉及编码问题。
* 其他数据比如dvd mp3 图片等是不涉及这个问题的。
* 虽然字节流+编码表可以解决文字数据处理问题，但是较为麻烦。为了便于使用，将字节流和编码表进行了封装，就出现了便于文字操作的流技术：字符流。
* 其实字符流就是：字节流+编码表。
IO的体系：
字节流两个基类：
InputStream(字节输入流) &nbsp;OutputStream(字节输出流)
字符流两个基类：
Reader(字符输入流) Writer(字符输出流)

学习io流体系：看顶层(父类共性功能)，用底层(子类具体对象)。
该体系的一个好处就是：
每个子类的后缀名都是所属体系的父类的名称，很容易区分所属的体系。而且每一个子类前缀名都是该子类对象的功能体现。这样我们在使用io体系中的对象时，就非常容易查找了。

需求：将一个段文字数据写入到硬盘上.
思路：


* 一段文字就是字符串数据。
* 写到硬盘上，从哪到哪呢？字符串数据在内存中，写到硬盘上，哎呦！这不是将内存中的数据搞到硬盘上，这就涉及到了设备之间的数据处理。就要用到IO技术。既然是从内存到硬盘，应该是输出流。
* 对于文字而言，io中提供了便捷的操作，比如字符流。
* 结合两者，需要输出流，需要字符流，可是使用字符输出流。Writer
* 具体用哪个子类对象呢？硬盘上用于存储数据的体现：文件。希望可以在Writer体系中知道可以操作文件的Writer对象。&nbsp;找到了具体的对象FileWriter.
两个写入流往一个文件写入数据，就如同，两个人在同时往一张纸写字一样。都是从头开始写，第二人写的会将第一个人的文字覆盖掉。

演示代码：


    package com.itheima.IO;
    import java.io.FileWriter;
    import java.io.IOException;
    import java.util.Properties;
    import java.util.Set;

    public class FileWriterDemo
    {
    	private static final String LINE_SPARATOR = System.getProperty("line.separator");

    	public static void main(String[] args) throws IOException
    	{
    		printProperty();

    		FileWriter fw = new FileWriter("demo", true);
    		fw.write("hello,there!"+LINE_SPARATOR+"Damon");
    		fw.flush();
    		fw.close();
    	}

    	private static void printProperty()
    	{
    		Properties prop = System.getProperties();
    		Set nameSet = prop.stringPropertyNames();
    		for(String name : nameSet)
    		{
    			String value = prop.getProperty(name);
    			System.out.println(name+"::"+value);
    		}
    	}
    }


标准IO异常处理代码：


    FileWriter fw = null;
    try
    {
    	fw = new FileWriter("k:\demo3.txt");
    	fw.write("abcde");
    	fw.flush();
    }
    catch(IOException e)
    {
    	System.out.println(e.toString());
    }
    finally
    {
    	if (fw != null)
    		try
    		{
    			fw.close();
    		}
    		catch (IOException e)
    		{
    			// 相关的代码处理。比如说，将关闭失败的信息记录到日志文件中。
    			throw new RuntimeException("关闭失败");
    		}
    }

需求：读取一个硬盘上的文本文件，将数据打印到控制台上。&nbsp;
思路：


* 读取无非就是将硬盘的数据弄到内存中。要使用到输入流。&nbsp;
* 既然是文字，可以使用字符流，一综合使用字符输入流，该体系时Reader.
* 既然要读取一个文本文件。可以使用 FileReader:用于读取字符文件的便捷类。

字符流的缓冲区。
BufferedReader
BufferedWriter

缓冲区给给流的操作动作(读写)提高效率.所以缓冲区的对象建立必须要有流对象。

代码演示：


    package com.itheima.IO;

    import java.io.FileNotFoundException;
    import java.io.FileReader;
    import java.io.IOException;
    public class FileReaderDemo
    {
    	/**
    	 * @param args
    	 * @throws IOException
    	 */
    	public static void main(String[] args) throws IOException
    	{
    		demo_1();
    		demo_2();
    	}

    	private static void demo_2() throws FileNotFoundException, IOException
    	{
    		FileReader fr = new FileReader("demo");
    		char[] buf = new char[100];
    		int len = 0;
    		while ((len=fr.read(buf)) != -1)
    		{
    			System.out.println(new String(buf, 0, len));
    		}
    	}

    	private static void demo_1() throws FileNotFoundException, IOException
    	{
    		FileReader fr = new FileReader("demo");
    /*		int ch = fr.read();
    		System.out.println("ch="+ch);
    */
    		int ch = 0;
    		while ((ch=fr.read()) != -1)
    		{
    			System.out.print((char)ch);
    		}
    		fr.close();
    	}
    }


复制文本文件代码演示：


    package com.itheima.IO;

    import java.io.FileNotFoundException;
    import java.io.FileReader;
    import java.io.FileWriter;
    import java.io.IOException;

    public class CopyTxtDemo
    {

    	/**
    	 * @param args
    	 * @throws IOException
    	 */
    	public static void main(String[] args) throws IOException
    	{
    		methed_1();
    		method_2();
    		System.out.println("OK！");
    	}

    	private static void method_2() throws FileNotFoundException, IOException
    	{
    		FileReader fr = new FileReader("demo");
    		FileWriter fw = new FileWriter("cptxtfile2");

    		char[] cbuf = new char[1024];
    		int len = 0;
    		while ((len=fr.read(cbuf)) != -1)
    		{
    			fw.write(cbuf, 0, len);
    		}

    		fr.close();
    		fw.close();
    	}

    	private static void methed_1() throws FileNotFoundException, IOException
    	{
    		FileReader fr = new FileReader("demo");
    		FileWriter fw = new FileWriter("cptxtfile");

    		int ch = 0;
    		while ((ch=fr.read()) != -1)
    		{
    			fw.write(ch);
    		}

    		fr.close();
    		fw.close();
    	}

    }


标准写法，异常处理：


    package com.itheima.IO;

    import java.io.FileReader;
    import java.io.FileWriter;
    import java.io.IOException;

    public class CopyOfCopyTxtDemo2
    {
    	/**
    	 * @param args
    	 */
    	public static void main(String[] args)
    	{
    		FileReader fr = null;
    		FileWriter fw = null;
    		char[] cbuf = new char[1024];
    		int len = 0;

    		try
    		{
    			fr = new FileReader("demo");
    			fw = new FileWriter("cptxtfile3");

    			while ((len=fr.read(cbuf)) != -1)
    			{
    				fw.write(cbuf, 0, len);
    			}
    		}
    		catch (Exception e)
    		{
    			System.out.println(e.toString());
    		}
    		finally
    		{
    			if (fw != null)
    				try
    				{
    					fw.close();
    				}
    				catch (IOException e2)
    				{
    					throw new RuntimeException("写入关闭失败");
    				}

    			if (fr != null)
    				try
    				{
    					fr.close();
    				}
    				catch (IOException e2)
    				{
    					e2.printStackTrace();
    				}
    		}
    	}
    }

![][1]


代码演示：


    package cn.itcast.io.p5.mybuffer;

    import java.io.IOException;
    import java.io.Reader;

    public class MyBufferedReader extends Reader{

    	/*
    	 * 缓冲区在定义时，必须有被缓冲的流对象。
    	 * 该流对象是通过构造函数传递的。
    	 *
    	 * 缓冲区最大的特点就是可以提高效率，
    	 * 原因在于对数据进行是临时存储。
    	 * 所以需要定义个容器(数组)。
    	 *
    	 *
    	 *
    	 */
    	private Reader r;

    	private char[] buf = new char[1024];
    	//用于记录存储到缓冲区中字符个数的变量
    	private int count = 0;

    	//用于操作数组中的元素的角标。
    	private int pos = 0;

    	public MyBufferedReader(Reader r) {
    		super();
    		this.r = r;
    	}

    	/*
    	 * 定义一个读取方法，从缓冲区中读取一个字符。
    	 * 实现原理：
    	 * 1，先通过具体的流对象的read([])方法，从目的中读取一批数据存储到缓冲数组中。
    	 *
    	 */
    	public int myRead() throws IOException{

    		//读取一批数据到缓冲数组buf中。
    		//当count为0时，就从目的中取一批数据到缓冲数组。
    		if(count==0){
    			count = r.read(buf);
    			pos = 0;
    		}

    		if(count字符流的桥梁。InputStreamReader&nbsp;
字符流---&gt;字节流的桥梁。OutputStreamWriter

\---------------------------------------
流的操作规律：


* 在进行数据操作时，IO包中提供了N多对象不同功能来操作设备上的数据。
* 在实际开发时，到底用哪个流对象来完成数据处理呢？
* 这是我们最为苦恼的事情。
* 如何明确具体用哪个流对象呢？
* 通过该规律就哦了。
* 规律就是四个明确？
1，明确源和目的。


* 源：InputStream &nbsp; Reader 一定是被读取的。
* 目的：OutputStream &nbsp;Writer 一定是被写入的。&nbsp;

2，处理的数据是否是纯文本的数据？


* 是：使用字符流。Reader Writer
* 否：使用字节流。 InputStream OutputStream
* 如果是源并且是纯文本，Reader
* 如果是目的并且是纯文本，Writer
* 到这里，两个明确确定完，就可以确定出要使用哪个体系。
* 接下来，就应该明确具体这个体系要使用哪个具体的对象。

3，明确数据所在的设备：

源设备：

* 键盘(System.in)
* 硬盘(FileXXX)
* 内存(数组)
* 网络(Socket)

目的设备：

* 显示器(控制台System.out)
* 硬盘(FileXXX)
* 内存(数组)
* 网络(Socket)
* 具体使用哪个对象就可以明确了。

4，明确是否需要额外功能？

* 是否需要高效？缓冲区Buffered
* 是否需要转换？转换流

实际需求：

需求1：复制一个文本文件。

1,明确源和目的：既有源，又有目的。

* 源：InputStream Reader&nbsp;
* 目的：OutputStream Writer.

2,明确是否是纯文本？是！

* 源：Reader
* 目的：Writer

3,明确具体设备:

* 源：硬盘(file)
* 目的：硬盘(file)
* 源对应的体系Reader中可以操作硬盘设备的对象是 FileReader&nbsp;
* 目的对应的体系Writer中可以操作硬盘设备的对象是FileWriter

直接明确具体对象并创建。

	FileReader fr = new FileReader("a.txt");
	FileWriter fw = new FileWriter("b.txt");

4,需要额外功能吗？需要，高效。 使用缓冲区。

	BufferedReader bufr = new BufferedReader(new FileReader("a.txt"));
	BufferedWriter bufw = new BufferedWriter(new FileWriter("b.txt"));

需求2：复制一个图片

1,明确源和目的：既有源，又有目的。

* 源：InputStream Reader&nbsp;
* 目的：OutputStream Writer.

2,明确是否是纯文本？不是！

* 源：InputStream
* 目的：OutputStream

3,明确设备：

* 源：硬盘
* 目的：硬盘：

		FileInputStream fis = new FileInputStream("1.jpg");
		FileOutputStream fos = new FileOutputStrema("2.jpg");

需求3：读取键盘录入，存储到一个文件中。

1,明确源和目的：既有源，又有目的。

* 源：InputStream Reader&nbsp;
* 目的：OutputStream Writer.

2,明确是否是纯文本？一般键盘录入的都是文字，所以是纯文本的。&nbsp;

* 源：Reader
* 目的：Writer

3,明确设备：

* 源：键盘。
* 目的：硬盘。

具体对象

源是：System.in.
目的是：FileWriter

	InputStream in = System.in;
	FileWriter fw = new FileWriter("a.txt");

对这个读写，应该这样完成，通过键盘录入读取字节数据，先不做写入操作，
而是将字节数据临时存储，转成字符串，然后在交给fw写入。

发现代码操作的起来很麻烦。有没有已有的功能可以解决这个问题啊？

4,需要额外功能吗？


* 需要。必须的。
* 需要将键盘录入的字节转成字符。
* 使用转换流。而且是 将字节--&gt;字符的转换流对象。InputStreamReader

InputStreamReader isr = new InputStreamReader(System.in);
FileWriter fw = new FileWriter("a.txt");

还需要其他功能吗？需要，高效。

	BufferedReader bufr = new BufferedReader(new InputStreamReader(System.in));
	BufferedWriter bufw = new BufferedWriter(new FileWriter("a.txt"));

需求4：读取一个文本文件，显示到显示器上。

1,明确源和目的：既有源，又有目的。

* 源：InputStream Reader&nbsp;
* 目的：OutputStream Writer.

2,明确是否是纯文本？是。

* 源：Reader
* 目的：Writer

3,明确设备：

* 源：硬盘。File
* 目的：显示器。System.out

		FileReader fr = new FileReader("a.txt");
		OutputStream out = System.out;

这已经可以完成读写了。
通过fr读取文本到字符数组，将字符数组转成字符串，然后在将字符串转成字节数组。
交给out输出。

4,需要额外功能吗？必须的。转换。需要将已有的字符数据转成字节。字符--&gt;字节的桥梁 OutputStreamWriter

	FileReader fr = new FileReader("a.txt");
	OutputStreamWriter osw = new OutputStreamWriter(System.out);

需要高效。

	BufferedReader bufr = new BufferedReader(new FileReader("a.txt"));
	BufferedWriter bufw = new BufferedWriter(new OutputStreamWrier(System.out));

需求5：读取一个文本文件，将文件中文本按照指定的编码表UTF-8写入到另一个文件中。

1,明确源和目的：既有源，又有目的。

* 源：InputStream Reader&nbsp;
* 目的：OutputStream Writer.

2,明确是否是纯文本？是。

* 源：Reader
* 目的：Writer

3,明确设备：

* 源：硬盘。File
* 目的：硬盘。File

		FileReader fr = new FileReader("a.txt");
		FileWriter fw = new FileWriter("b.txt");

这样做不行，满足不了需求，为什么呢？
因为这个两个对象在操作文本数据，都是用了默认的编码表。在我的本机中默认码表是GBK.
而需求中希望写入到文件的数据是按照utf-8的码表。
其实这两个对象就是字节流+默认编码表。&nbsp;

源对象不变。

	FileReader fr = new FileReader("a.txt");

需要目的为指定编码表。
这时就要用到转换流。因为转换流中可以指定具体的编码表。 需要往里传递一个字节流，而且要操作文件，

	FileOutputStream,`OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream("b.txt"),"UTF-8");`

需要高效

	BufferedReader bufr = new BufferedReader(new FileReader("a.txt"));
	BufferedWriter bufw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("b.txt"),"UTF-8"));

c:\1.txt 源是一个文件也是字节数据，是不是应该使用字节流呢？

	FileInputStream fis = new FileInputStream("c:\1.txt");
	InputStreamReader isr = new InputStreamReader(fis,"gbk");
	isr.read();//字符。

既然是明确操作是文件，而且使用默认编码表。

可以使用InputStreamReader的子类。FileReader

	FileReader fr = new FileReader("c:\1.txt");

[1]: http://img.blog.csdn.net/20130729222107296?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY3V6dmFs/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast
  
