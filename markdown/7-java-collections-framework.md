
[Source](http://blog.csdn.net/cuzval/article/details/9325523 "Permalink to 黑马程序员_集合框架(Collection，Iterator) - cuzval的专栏 - 博客频道")

## collection、Iterator

为什么出现集合类？

* 面向对象语言对事物的体现都是以对象的形式，所以为了方便对多个对象的操作，就对对象进行存储，集合就是存储对象最常用的一种方式
&nbsp;数组和集合类同是容器，有何不同？


* &nbsp;数组虽然也可以存储对象，但长度是固定的；集合长度是可变的
* &nbsp;数组中可以存储基本数据类型，集合只能存储对象&nbsp;
集合类的特点：


* 集合只用于存储对象，集合长度是可变的，集合可以存储不同类型的对象

集合的用处：

* 用于存储对象的容器
* 该容器的长度是可变的

集合和数组的区别：

* 集合长度是可变的，数组长度是固定的
* 集合中只能存储对象，数组中即可以存储对象，又可以存储基本类型数值
* 集合中存储的对象可以是任意类型的，数组中只能存储同一类型的对象

集合框架的由来：


* 容器很多，因为每个容器中的数据结构是不同的。
* 数据结构：就是数据在容器中存储方式
* 如散装鸡蛋和品牌鸡蛋的存储方式
* 容器虽然因为结构有不同，但是都具备着共性，可以不断地向上抽取。
* 就形成集合框架，该框架的顶层之一就是Collection接口。 &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
* 该接口中定义了集合框架中最共性的功能。 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* 最终使用的时候，其实使用的该框架最子类的对象。 &nbsp; &nbsp; &nbsp; &nbsp;

Collection中有哪些方法呢？

1. 添加方法。

		boolean add(object e):一次添加一个元素。
		boolean addAll(Collection):将一个参数容器中的元素添加到当前容器中。

2. 删除方法。

		boolean remove(object):删除一个指定对象。 
		boolean removeAll(Collection):删除指定collection中和本Collection中相同的元素。
		void clear():直接将集合中的元素清空。

3. 判断方法：

		boolean contains(object):是否包含指定元素。
		boolean containsAll(Collection):是否包含指定容器中的元素。
		boolean isEmpty():是否有元素。

4. 获取元素个数： 

		int size():获取元素有几个。
	
5. 取交集。

		boolean retainAll(collection):保留和指定collection集合中相同的元素，不相同的元素会被删除。

6. 将集合转成数组。

7. 取出元素的方法：

		Iterator iterator():
		迭代器：取出集合中元素的方式的一个对象。该对象本身就内置在容器中。

	如何获取到集合的迭代器呢？

		* 可以通过iterator()方法来完成。该方法返回一个Iterator类型对象。
		* 迭代器接口出现：将每一个容器中的取出方式进行了封装。并对外暴露。
		* 这样无论是什么容器或者数据结构，只要内部取出方式实现了Iterator接口，
		* 都可以通过该接口取出这些容器中的元素。
		* 它的出现，将容器的取出方式和容器的数据结构相分离，降低了耦合性。
		* 而取出方式因为直接在访问容器中的元素，并依赖具体的数据结构，所以被定义在了容器中。
		* 通过内部类来实现Iterator接口。 
		* 大型游戏机中抓布娃娃的游戏机中的夹子。就是那个迭代器。
		* 只要是Collection集合中的容器，迭代器是通用取出方式。

演示代码如下：


    //创建集合。
    Collection coll = new ArrayList();

    //添加元素。
    coll.add("abc1");
    coll.add("abc2");
    coll.add("abc3");

    /*
    //获取该集合的迭代器对象。
    Iterator it = coll.iterator();

    //使用迭代器对象中的方法完成元素的获取。
    while(it.hasNext())
    {
    	System.out.println(it.next());
    }
    */

    //将while改成for结构。开发的时候建议写for。
    for(Iterator it = coll.iterator(); it.hasNext(); )
    {
    	System.out.println(it.next());
    }

输出结果


    demo1
    demo2
    demo3

使用集合是的一些小细节

创建一个集合容器。其实也是一个对象


    Collection coll = new ArrayList();

存储时，add可以接收任意类型的对象因为参数类型是Object。
所以对象元素存入时都被提升为了Object。其实在集合中真正存储都是对象的引用。


    coll.add(new Object());
    coll.add("abc");

用迭代器取出时，其实取出的也是引用。


    coll.add(5);

上面这样写是可以的。因为jdk1.5后，有了自动装箱机制。

相当于new Integer(5).装箱Integer.valueOf(5);
等同于coll.add(Integer.valueOf(5));//拆箱 intValue();

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
一般开发时，最常见的就是往集合存储自定义对象对自定义对象进行描述。&nbsp;&nbsp;

存储时，都被提升为了Object。 &nbsp;&nbsp;

取出时如果要使用自定义对象的特有方法，一定要进行向下转型。

注意事项：在迭代时，循环中只要有一个next()即可 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;

示例代码如下：


    Collection coll = new ArrayList();
    coll.add(new Person("lisi2",22));
    coll.add(new Person("lisi3",23));
    coll.add(new Person("lisi4",24));

    //取出元素。
    Iterator it = coll.iterator();
    while(it.hasNext())
    {
    	Person p = (Person)it.next();
    	System.out.println(p.getName()+":"+p.getAge());
    	//System.out.println(((Person)it.next()).getName()+":"+((Person)it.next()).getAge()); //出错，next()只能调用一次

    }

Vector:jdk1.0就存在了，底层是数组结构，可变长度数组

原理：一旦原数组长度不够，会创建新数组，将原数组的元素复制到新数组，并

将新元素添加到数组中

* ArrayList:底层是数组结构，也是支持长度可变变数组的，是不同步的。代替了Vector，因为效率高，查询效率高，增删低
* LinkedList:底层是链接列表结构。简称链表结构。好处是对元素的增删效率非常高，查询低
  
***

## List、Set

![][1]


Collection
List：列表。
特点：


* 有序(存储元素的顺序和取出元素的顺序一致)
* 该集合中的元素都有索引，所以可以通过索引(角标)来访问元素。 
* 它可以存储重复元素。 
* 常见子类对象:记住：具体的子类对象，我们要学习应该是该对象的特有的数据结构，以及相关的特点。
* Vector:jdk1.0就存在了。底层是数组结构的。可变长度数组，
* 原理：一旦原数组长度不够，会创建新数组，将原数组的元素复制到新数组中，并将新元素添加到新数组中。
* Vector是同步的。
* ArrayList:底层是数组结构，也是支持长度可变数组的。是不同步的。替代了Vector.因为效率高。 查询效率很高。 但是增删的效率很低。
* LinkedList:底层是链接列表结构，简称链表结构。是不同步的。这个中结构的好处：对元素的增删非常效率很高。 查询的效率很低。
* Set：集：中的方法和Collection一致，只要重点注意它的子类对象即可。取出元素只能使用迭代器。
特点：


* 不包含重复元素。(最大的特点)
* 这个集合存入元素的顺序和取出元素的顺序不一定一致。(具体的容器对象数据结构不同，顺序也有不同)
* HashSet：底层数据结构是哈希表，不保证顺序，是不同步的。
* 哈希表：提供数组的查询效率而出现的。
* 将要存储的元素先通过哈希算法算出一个哈希值来标识存储的位置，代表着元素。
* 要找元素时，先将该元素通过哈希算法算出哈希值，在通过哈希值到哈希表中去查找。
特点：


* 不关系元素的顺序。
* 提高了查询效率。
* 不可能出现重复元素，因为哈希值都不同。即使相同，会再次判断两个元素的equals，内容是否相同。
如果内容也相同，不存，如果内容不同，存储。
所以哈希表要保证元素的唯一性，必须要依赖于两个方法。
1,hashCode
2,equals

TreeSet：可以给Set集合中的元素进行指定顺序的排序。非同步的。 


* 默认情况下，是通过元素的自然顺序排的序。
* 它保证元素唯一性的依据是看比较方法的返回结果是否是0.是0.就视为元素相同。不存。

TreeSet排序的方式一：

* 让元素自身具备比较性，需要实现Comparable接口，覆盖compareTo方法。
* 这种比较方式成为自然顺序排序。
如果元素自身不具备比较性或者具备的比较性(自然顺序)不是所需要的。

这时只能用第二种方式 。

TreeSet排序的方式二：

* 让容器自身具备比较性。容器一初始化就具备了比较功能。
* 因为容器时在对象构造时完成的。通过查阅，有一个构造方法TreeSet(Comparator).
* 在容器初始化时可以指定一个比较器。 
* 需要实现Comparator接口，覆盖compare方法即可。
* 所以这种方式成为比较器排序。 
集合的技巧掌握：


* 明确具体集合对象名称的后缀：
* 如果后缀是List，都所属于List体系。通常都是非同步的。
* 如果后缀是Set，都属于Set体系，通常也是非同步的。
* 这些体系中的其他子类对象，后缀不是所属接口名的，一般都是同步的。比如Vector.
* 这在常用子类对象中通用。 

明确数据结构：


* 对于jdk1.2版本的子类对象。
* 后缀名是所属的体系。
* 前缀名是就是数据结构的名称。
比如：
ArrayList: 看到Array，就要明确是数组结构。查询快。
LinkedList：看到Link，就要明确链表结构，就要想到 add get remove 和first last结合的方法.增删快。，

HashSet：

* 看到hash，就要明确是哈希表。查询巨快，而且唯一性。
* 想到元素必须覆盖 hashCode方法和equals方法。 

TreeSet：

* 看到Tree，就要明确是二叉树，可以对元素排序。
* 就要想到两种排序方式：
自然顺序：Comparable接口，覆盖compareTo(一个参数 )java.lang

比较器：Comparator接口，覆盖compare(两个参数);java.util

判断元素唯一性的依据就是比较方法的返回结果return 0;

演示List子接口中的特有方法。
因为该接口的特点是 对元素有索引标示。
所以它的特有方法应该都是围绕着索引定义的。
1，添加：
void add(index,element);
boolean addAll(index,collection);


2，删除：
object remove(index):获取并删除。记住大家，增加或者删除方法的成功都会改变集合的长度。


3，获取：
获取元素：
Object get(index):获取
获取元素索引：
int indexOf(object);
int lastIndexOf(object);
获取子列表：
List subList(fromIndex,toIndex):获取列表中的一部分，包含fromIndex位置，不包含toIndex位置。


4，修改。
object set(index,element):替换指定位置的元素，并返回被替换掉的元素。
我们发现，List接口是可以对元素进行增删改查的操作的。
注意：只有这个集合具备着增删改查。具备的原因：因为有索引。


演示代码：


    package com.itheima.collection;

    import java.util.ArrayList;
    import java.util.List;

    public class Demo3
    {

    	public static void main(String[] args)
    	{
    		sop("hello,word!");
    		List list = new ArrayList();
    		listDemo(list);
    	}

    	public static void listDemo(List list)
    	{
    		list.add("Demo1");
    		list.add("Demo2");
    		list.add("Demo3");
    		sop("原来集合"+list);

    		// 插入元素
    		list.add("insert00");
    		sop(list);

    		// 删除指定位置元素
    		list.remove(2);
    		sop(list);

    		// 获取指定位置的原始
    		sop(list.get(1));

    		// 修改指定位置上的元素
    		list.set(1, "set1");
    		sop(list);

    		// 索引元素位置
    		sop(list.indexOf("Demo1"));

    		// 获取子串
    		sop(list.subList(0, 2));
    	}

    	public static void sop(Object obj)
    	{
    		System.out.println(obj);
    	}

    }

* 当对集合进行迭代时，在迭代的过程，如果用集合对象对元素进行了修改。
* 而迭代器是不知道的，所以在迭代的过程中就会发生不确定性。
* 为了避免这种情况的发生，在迭代时，不要使用集合对象对迭代中的元素进行操作。
* 但是，我们还想在迭代的过程中对被迭代的元素进行更多的操作。该怎么办呢？
* 可以使用迭代器的方法。但是Iterator的方法很郁闷，只有判断hasNext,获取next，删除，remove三个方法。
* 注意：要想解决这个问题，list接口中提供了一个特有的迭代器。
* 这个迭代器就是ListIterator 列表迭代器。就可以解决这个问题。
* 介绍一下ListIterator。
* 它的父接口是Iterator。
* 一看其方法，add remove set next 它就可以实现在迭代过程中进行元素的增删改查的动作。
* 它还支持逆向遍历。

注意：这个列表迭代器只能对List集合使用。


vector演示代码：


    package com.itheima.collection;

    import java.util.Enumeration;
    import java.util.Iterator;
    import java.util.Vector;

    /**
     * @author mskv
     *
     */
    public class VectorDemo
    {
    	public static void sop(Object obj)
    	{
    		System.out.println(obj);
    	}

    	public static void main(String[] args)
    	{
    		Vector v = new Vector();
    		v.add("Demo1");
    		v.add("Demo2");
    		v.add("Demo3");
    		sop(v);

    /*		for (Iterator it = v.iterator();it.hasNext();)
    		{
    			sop(it.next());
    		}*/

    		// 枚举和iterator一样，但是iterator多了一个移除操作，枚举只能取vector集合中的元素。
    		// 最后枚举被迭代器取代了
    		for (Enumeration en = v.elements();en.hasMoreElements();)
    		{
    			sop(en.nextElement());
    		}
    	}
    }


头尾操作方法。
addFirst();
addLast();
getFirst():从头部获取元素，但不删除。如果没有元素，会抛出NoSuchElementException
getLast();
removeFirst()：从头部获取元素，但删除。如果没有元素，会抛出NoSuchElementException
removeLast();


队列模拟：


    package com.itheima.collection;
    import java.util.LinkedList;

    public class QueenDemo
    {
    	private LinkedList link = null;
    	public QueenDemo()
    	{
    		link = new LinkedList();
    	}

    	public void quAdd(Object obj)
    	{
    		link.addLast(obj);
    	}

    	public Object quGet()
    	{
    		return link.removeFirst();
    	}

    	public boolean isEmp()
    	{
    		return link.isEmpty();
    	}
    }


    package com.itheima.collection;

    public class LinkedListDemo
    {
    	public static void sop(Object obj)
    	{
    		System.out.println(obj);
    	}

    	public static void main(String[] args)
    	{
    		QueenDemo qd = new QueenDemo();
    		qd.quAdd("QueenDemo1");
    		qd.quAdd("QueenDemo2");
    		qd.quAdd("QueenDemo3");

    		while (!qd.isEmp())
    		{
    			sop(qd.quGet());

    		}
    	}
    }


ArrayListTest:


    package com.itheima.bean;

    public class Person
    {
    	private String name;
    	private int age;
    	/**
    	 * @param name
    	 * @param age
    	 */
    	public Person(String name, int age)
    	{
    		super();
    		this.name = name;
    		this.age = age;
    	}
    	/**
    	 * @return the name
    	 */
    	public String getName()
    	{
    		return name;
    	}
    	/**
    	 * @param name the name to set
    	 */
    	public void setName(String name)
    	{
    		this.name = name;
    	}
    	/**
    	 * @return the age
    	 */
    	public int getAge()
    	{
    		return age;
    	}
    	/**
    	 * @param age the age to set
    	 */
    	public void setAge(int age)
    	{
    		this.age = age;
    	}
    	/* (non-Javadoc)
    	 * @see java.lang.Object#toString()
    	 */
    	@Override
    	public String toString()
    	{
    		return "[name=" + name + ", age=" + age + "]";
    	}

    	public boolean equals(Object obj)
    	{
    		if (!(obj instanceof Person))
    			return false;
    		Person p = (Person) obj;
    		return this.getName().equals(p.getName()) && (this.getAge() == p.getAge());
    	}
    }



    /**
     *
     */
    package com.itheima.collection;

    import java.util.ArrayList;
    import java.util.Iterator;

    import com.itheima.bean.Person;

    /**
     * @author mskv
     *
     */
    public class ArrayListTest
    {
    	public static void sop(Object obj)
    	{
    		System.out.println(obj);
    	}

    	/**
    	 * @param args
    	 */
    	public static void main(String[] args)
    	{
    		ArrayList al = new ArrayList();
    		al.add("ArrayListTest0");
    		al.add("ArrayListTest1");
    		al.add("ArrayListTest2");
    		al.add("ArrayListTest3");
    		al.add("ArrayListTest2");
    		sop(al);
    		al = removeRepeatElements(al);
    		sop(al);

    		// 存储自定义对象Person，若姓名年龄一样即为同一人
    		ArrayList alp = new ArrayList();
    		alp.add(new Person("lucy", 22));
    		alp.add(new Person("mike", 23));
    		alp.add(new Person("lili", 25));
    		alp.add(new Person("jack", 25));
    		alp.add(new Person("lili", 25));
    		sop(alp.toString());
    		alp = removeRepeatElements(alp);
    		sop(alp);
    	}

    	// 定义一个方法，移除集合中重复的元素
    	public static ArrayList removeRepeatElements(ArrayList al)
    	{
    		ArrayList tmp = new ArrayList();

    		for (Iterator it = al.iterator();it.hasNext();)
    		{
    			Object obj = it.next();
    			if (!tmp.contains(obj))
    			{
    				tmp.add(obj);
    			}
    		}
    		return tmp;
    	}
    }


注意：ArrayList判断元素是否相同使用的是equals方法

比如contains中就是判断依赖于equals方法

或者remove方法都是依赖于equals方法

尤其在存储自定义对象是，该对象一定要覆盖equals方法

建立对象自身特点的判断依据，equals就是用于比较对象内容的

练习：对字符串长度进行排序

思路：


* 对字符串对象进行排序是很简单的。因为字符串对象本身就具备着自然顺序(字典顺序)，因为它实现了Comparable接口。覆盖了compareTo方法。
* 要求是对字符串进行长度的排序。发现字符串具备的自然顺序不是所需要的。这时就只能使用比较器的方式。
* 需要定义个比较器。
演示代码如下：

        package com.itheima.collection;
        import java.util.Comparator;
    
        public class ComparatorByLen implements Comparator
        {
        	public int compare(Object obj1, Object obj2)
        	{
        		String s1 = (String) obj1;
        		String s2 = (String) obj2;
    
        		int tmp = s1.length() - s2.length();
        		return tmp==0 ? s1.compareTo(s1):tmp;
        	}
        }
***
   
        package com.itheima.collection;
        import com.itheima.collection.ComparatorByLen;
        import java.util.TreeSet;
    
        public class TreeSetTest
        {
        	public static void main(String[] args)
        	{
        		sop("hello,word!");
        		/**
        		 * 对字符串长度排序：使用比较器
        		 *
        		 */
        		TreeSet ts = new TreeSet(new ComparatorByLen());
        		ts.add("ajagodg");
        		ts.add("adgge");
        		ts.add("agod90agsdg");
        		ts.add("cmkadofoa");
        		sop(ts);
        	}
    
        	public static void sop(Object obj)
        	{
        		System.out.println(obj);
        	}
        }


总结记忆：

* 集合的技巧掌握： 明确具体集合对象名称的后缀： 
* 如果后缀是List，都所属于List体系。通常都是非同步的。 
* 如果后缀是Set，都属于Set体系，通常也是非同步的。 
* 这些体系中的其他子类对象，后缀不是所属接口名的，一般都是同步的。比如Vector. 
* 这在常用子类对象中通用。 
* 明确数据结构： 对于jdk1.2版本的子类对象。 后缀名是所属的体系。 
* 前缀名是就是数据结构的名称。 比如： ArrayList: 
* 看到Array，就要明确是数组结构。查询快。 
* LinkedList：看到Link，就要明确链表结构，就要想到 add get remove 
* 和first last结合的方法.增删快。

综合示例演练：

* 想要按照字符串的长度排序。
* 说明字符串对象所具备的自然顺序不是所需要的。
* 只好使用另一种对象比较的方式。就是比较器。 
* 在排序的时候传入一个指定的比较器进来。 按照指定的方式进行比较排序

        package cn.itcast.api.p2.comparator;
    
        import java.util.Comparator;
    
        public class ComparatorByStringLen implements Comparator {
        	public int compare(String o1, String o2) {
    
        		int temp = o1.length() - o2.length();
        		return temp==0?o1.compareTo(o2):temp;
        	}
    
        }

        package cn.itcast.test;
    
        import java.util.Comparator;
    
        import cn.itcast.api.p2.comparator.ComparatorByStringLen;
    
        public class Test9 {
        	public static void main(String[] args) {
    
        		String[] arr = {"abcd","zz","hahaah","xixix","qq","mm","abcd","hahaah"};
        		sortStringArray2(arr,new ComparatorByStringLen());
        		String str = toString(arr);
        		System.out.println(str);
        	}
    
        	public static void sortStringArray2(String[] arr,Comparator comp){
    
        		for (int i = 0; i < arr.length-1; i++) {
        			for (int j = i+1; j < arr.length; j++) {
        				if(comp.compare(arr[i], arr[j])>0){
        					swap(arr,i,j);
        				}
        			}
        		}
        	}
    
        	private static String toString(String[] arr) {
    
        		StringBuilder sb = new StringBuilder();
    
        		sb.append("[");
        		for (int i = 0; i < arr.length; i++) {
        			if(i!=arr.length-1)
        				sb.append(arr[i]+", ");
        			else
        				sb.append(arr[i]+"]");
        		}
        		return sb.toString();
        	}
        	public static void sortStringArray(String[] arr){
    
        		for (int i = 0; i < arr.length-1; i++) {
        			for (int j = i+1; j < arr.length; j++) {
        				if(arr[i].compareTo(arr[j])>0){
        					swap(arr,i,j);
        				}
        			}
        		}
        	}
        	private static void swap(String[] arr, int i, int j) {
        		String temp = arr[i];
        		arr[i] = arr[j];
        		arr[j] = temp;
        	}
        }


[1]: http://img.blog.csdn.net/20130715162956671?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY3V6dmFs/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center

***

## 泛型

[Source](http://blog.csdn.net/cuzval/article/details/9374155)

泛型：jdk1.5版本，出现的技术。是一个安全机制。&nbsp;

泛型技术的由来：


* 集合中可以存储任意类型对象，但是在取出时，如果要使用具体对象的特有方法时，需要进行向下转型，
* 如果存储的对象类型不一致，在转型过程中就会出现ClassCastException异常。
* 这样就给程序带来了不安全性。


在jdk1.5以后就有了解决方案。就是泛型技术。


* 解决方案就是，在存储元素时，就不允许存储不同类型的元素。
* 存储了就编译失败。&nbsp;所以就需要在存储元素时，在容器上明确具体的元素类型。这其实和数组定义很像。

好处：


* 将运行时期的ClassCastException异常转移到了编译事情，进行检查，并以编译失败来体现。&nbsp;
* 这样有利于程序员尽早解决问题。&nbsp;避免了向下转型(强转)的麻烦
什么时候写泛型呢？


* 先简单理解：只要在使用类或者接口时，该类或者接口在api文当描述时都带着就需要在使用时，定义泛型。
* 其实，泛型无非就是通过定义了一个形式参数。专门用于接收具体的引用类型。
* 在使用时，一定要传递对应的实际参数类型。集合中泛型的应用特别多见。

泛型的擦除：


* 泛型技术是用于编译时期的技术，编译器会按照中的指定类型对元素进行检查，
* 检查不匹配，就编译失败，匹配，就编译通过，通过后，生产的class文件中是没有泛型的。这就成为泛型的擦除。
泛型的补偿：

* 运行时，可以根据具体的元素对象获取其具体的类型。并用该类型对元素进行自动转换。
* 泛型对对于程序的设计也有一定优化动作。


接下来就有了新的思考方法，这其实源于jdk1.5的泛型技术。


* 当一个类要操作的引用数据类型不确定的时候，可以将该类型定义一个形参。
* 用到的这类时，有使用者来通过传递类型参数的形式，来确定要操作的具体的对象类型。
* 意味着在定义这个类时，需要在类上定义形参。用于接收具体的类型实参。
* 这就是将泛型定义在类上。这就是泛型类。

什么时候使用泛型类呢？只要类中操作的引用数据类型不确定的时候，就可以定义泛型类。
有了泛型类，省去了曾经的强转和类型转换异常的麻烦。


    class Util{
    	private QQ obj;
    	public void setObject(QQ obj){
    		this.obj = obj;
    	}
    	public QQ getObject(){
    		return obj;
    	}
    }


定义一个工具类对worker对象也可以对Student对象进行操作，设置和获取。甚至于任意对象。
之所以定义Object类型的对象是因为不能确定要操作什么类型的具体对象。
弊端是要使用对象的特有方法需要向下转型，并且问题发生，会出现的运行时期，而不是编译时期，不已解决。


    class Tool
    {
    	private Object obj;
    	public void setObject(Object obj)
    	{
    	this.obj = obj;
    	}

    	public Object getObject()
    	{
    		return obj;
    	}
    }


自定义泛型和方法演示代码：


    package com.itheima.collection;

    public class GenericDemo
    {
    	public static void main(String[] args)
    	{
    		GenDemo str = new GenDemo();
    		str.speak("hello,there!");
    		str.speakOther(new Integer(5));
    		GenDemo.hello("thanks!");

    		GenDemo in = new GenDemo();
    		in.speak(new Integer(6));
    		in.speakOther(new Integer(9));
    		in.speakOther("Strings also can");
    	}
    }

    // 自定义泛型类
    class GenDemo
    {
    	public void speak(E e)
    	{
    		System.out.println("说了什么？"+e.toString());
    	}

    	// 这个speakOther方法，要操作的类型不确定的，但是一不一定和调用该方法的对象指定的类型一致。
    	// 故使用泛型方法
    	public  void speakOther(F f)
    	{
    		System.out.println("说点不同类型的："+f.toString());
    	}

    	// 静态方法不能访问类上定义的泛型，如果需要泛型，该泛型只能定义在方法上。
    	public static  void hello(S s)
    	{
    		System.out.println("静态方法说："+s.toString());
    	}
    }

运行结果如下：


    说了什么？hello,there!
    说点不同类型的：5
    静态方法说：thanks!
    说了什么？6
    说点不同类型的：9
    说点不同类型的：Strings also can

泛型的通配符：?


* 当操作的不同容器中的类型都不确定的时候，而且使用的都是元素从Object类中继承的方法。
* 这时泛型就用通配符?来表示即可。
* 我们就通过Collection中的containsAll方法来对 ? 应用进行一下 体现。&nbsp;
* boolean &nbsp;containsAll(Collection)
* 注意：如果我们要定义这样类似的方法怎么定义呢？

        interface Collection
        {
        	public boolean add(E e);
        	public boolean containsAll(Collection coll);
        }
    
        Collection c1 = new ArrayList();
        c1.add("abc1");
        c1.add("abc2");
    
        Collection c2 = new ArrayList();
        c2.add("abc1");
        c1.containsAll(c2);//这是必须可以的。
    
        Collection c3 = new ArrayList();
        c3.add(5);
    
        c1.containsAll(c3);//注意：containsAll方法使用的内部原理就是通过元素的equals进行相同的判断。
        //equals方法的参数是Object.所以可以接受任意类型的对象。意味着： "abc".equals(new Integer(5));

演示代码：

    package com.itheima.collection;
    import java.util.ArrayList;
    import java.util.Collection;
    import java.util.Iterator;

    public class GenericDemo2
    {
    	public static void main(String[] args)
    	{
    		ArrayList als = new ArrayList();
    		als.add("als1");
    		als.add("als2");
    		als.add("als3");
    //		System.out.println(als);

    		ArrayList ali = new ArrayList();
    		ali.add(3);
    		ali.add(4);
    		ali.add(7);
    //		System.out.println(ali);
    		printColl(als);
    		printColl(ali);
    	}

    	public static void printColl(Collection al)
    	{
    		for (Iterator it = al.iterator();it.hasNext();)
    		{
    			System.out.println(it.next().toString());
    		}
    	}
    }



泛型的限定：


* 明确具体类型代表一个类型。
* 明确?代表所有类型。
* 能不能对操作的类型限制在一个范围之内呢？
* 比如：定义一个功能，只操作Person类型或者Person的子类型。&nbsp;
* 这时可以用 ? extends E:接收E类型或者E的子类型。这就是上限。&nbsp;
* 下限：? super E: 接收E类型或者E的父类型。
* 什么时候使用上限呢？一般情况下，只要是往容器中添加元素时，使用上限。 &nbsp;? extends E
* 什么时候使用下限呢？一般清况下，只要是从容器中取出元素时，是用下限。 ? super E


演示下限。

    private static void superEDemo()
    {
    	TreeSet ts = new TreeSet(new CompByName());
    	ts.add(new Student("lisi1",21));
    	ts.add(new Student("lisi0",24));
    	ts.add(new Student("lisi2",22));

    	Iterator it = ts.iterator();
    	while(it.hasNext()
    	{
    		Person p = it.next();
    		System.out.println(p.getName()+":::student:::"+p.getAge());
    	}
    	TreeSet ts1 = new TreeSet(new CompByName());
    	ts1.add(new Worker("wangwu8",21));
    	ts1.add(new Worker("wangwu1",24));
    	ts1.add(new Worker("wangwu5",22));

    	Iterator it1 = ts1.iterator();
    	while(it1.hasNext())
    	{
    		Person p = it1.next();
    		System.out.println(p.getName()+":::worker:::"+p.getAge());
    	}
    }


演示上限。


    private static void extendsEDemo()
    {
    	Collection coll = new ArrayList();
    	coll.add(new Student("lisi1",21));
    	coll.add(new Student("lisi0",24));
    	coll.add(new Student("lisi2",22));

    	TreeSet ts = new TreeSet(coll);//将coll中的元素存储到TreeSet集合。
    	ts.add(new Person("wangwu",23));

    	Iterator it = ts.iterator();
    	while(it.hasNext())
    	{
    		Person p = it.next();
    		System.out.println(p.getName()+"::::::"+p.getAge());
    	}
    }




* 姓名排序。比较器是将容器中的元素取出来进行比较、&nbsp;
* 发现，如果对学生或者工人都进行姓名的排序，用的都是父类Person中的内容。
* 不同的子类型需要定义不同的比较器就很麻烦，复用性差。
* 定义Person类型的比较器行不？
* 比较器是将容器中的元素取出来进行比较。所以无论你的元素是Student类型还是Worker类型。；
* 我都可以用Person类型来接收。而Person类型是两者父类型。&nbsp;


    class CompByName implements Comparator
    {
    	public int compare(Person o1, Person o2)
    	{
    		int temp = o1.getName().compareTo(o2.getName());
    		return temp==0? o1.getAge()-o2.getAge():temp;
    	}
    }





jdk1.5以后 出现的新方式。这种升级就是简化书写。
Collection有了一个父接口，Iterable
该接口封装了iterator方法，同时提供了一个新的语句。foreach语句。
格式：
for(变量 : Collection集合or数组){
}

* foreach循环简化了迭代器。迭代器还用吗？用，因为迭代过程中还可以remove().一般只对基本遍历简化使用。
* foreach循环特点：必须明确被遍历的目标。没有目标没用。目的只能是数组或者Collection集合。如果要对数组的中的元素进行特定操作时，建议传统for循环，通过角标完成。&nbsp;

        ArrayList al = new ArrayList();
        al.add("abc1");
        al.add("abc2");
        al.add("abc3");
        al.add("abc5");
        for(String s : al)
        {
        	System.out.println(s);
        }
    
        int[] arr = {7,23,1,67,90,8};
        for(int i : arr)//只为遍历元素，无法操作角标。
        {
        	System.out.println("i="+i);
        }  
    
***

## Map、Collections、Arrays

[Source](http://blog.csdn.net/cuzval/article/details/9386279 "Permalink to 黑马程序员_(集合框架(Map，Collections，Arrays)) - cuzval的专栏 - 博客频道")

集合框架中的另一个顶层接口，Map。

* Map:用于存储具备着对应关系的键和值。而且要保证键的唯一性。一次存储一对儿元素。
* Collection一次存储一个元素，称之为单列集合。
* Map集合一次存储一对儿元素，称之为双列集合。

Map常见方法：
1，添加。
v put(k,v):
void putAll(map);


2，删除。
void clear():清空集合。
v remove(key):通过键删除元素，并返回对应的值。


3，判断。
boolean containsKey(key);
boolean containsValue(value);
boolean isEmpty();


4，获取。
value get(key):根据键获取值。如果键不存在，返回null。可以用来判断一个集合中是否存在某一个键。


5，获取map中所有的元素(对应关系)。
Map是不具备迭代器的，获取原理就是将map集合先转成set集合。然后在使用迭代器。
Set keySet();
Set entrySet();
Colection values();获取map集合中所有的值。&nbsp;

演示代码：


    package com.itheima.collection;

    import java.util.Collection;
    import java.util.HashMap;
    import java.util.Iterator;
    import java.util.Map;
    import java.util.Set;

    public class MapDemo
    {
    	public static void main(String[] args)
    	{
    		mapDemo();
    	}

    	private static void mapDemo()
    	{
    		Map map = new HashMap();
    		// 添加元素
    		map.put(24, "Kobe");
    		map.put(23, "Jordan");
    		map.put(3, "Paul");
    		map.put(16, "Paul");
    		System.out.println(map);

    		// 存了相同的键，会替换原来的值并返回
    		System.out.println(map.put(3, "Noname"));
    		System.out.println(map);

    		// 获取元素
    		System.out.println(map.get(16));

    		// 打印元素
    		printMap(map);
    	}

    	private static void printMap(Map map)
    	{
    		// 通过Map集合的Set keySet()方法实现
    		printMapByKeySet(map);

    		// 通过Map集合的Set entrySet()方法实现
    		// Entry其实就是Map接口中的内部接口
    		prinMapByEntrySet(map);

    		// 通过values()方法获取map中所有的值，返回collection，因为值可以重复
    		prinMapByValues(map);
    	}

    	private static void prinMapByValues(Map map)
    	{
    		Collection coll = map.values();
    		for (Iterator it = coll.iterator(); it.hasNext();)
    		{
    			String values = it.next();
    			System.out.println(values);
    		}
    	}

    	private static void prinMapByEntrySet(Map map)
    	{
    		// 通过entrySet获取Map集合中的键值关系，存到set集合
    		Set entrySet = map.entrySet();
    		// 通过set集合的迭代器遍历元素
    		for (Iterator it = entrySet.iterator(); it
    				.hasNext();)
    		{
    			Map.Entry me = it.next();
    			System.out.println(+me.getKey() + ":: " + me.getValue());
    		}
    	}

    	private static void printMapByKeySet(Map map)
    	{
    		// 通过keySet获取map集合中的键集
    		Set keySet = map.keySet();
    		// 通过迭代器取值
    		for (Iterator it = keySet.iterator(); it.hasNext();)
    		{
    			Integer key = it.next();
    			String value = map.get(key);
    			System.out.println(key + ": " + value);
    		}
    	}
    }

Map体系:

|--Hashtable:底层是哈希表数据结构，是线程同步的，不允许null作为键，null作为值。

|--HashMap：底层是哈希表数据结构，是线程不同步的，允许null作为键，null作为值。替代了Hashtable。

|--TreeMap：可以对Map集合中的键进行指定顺序的排序，默认是使用键的自然顺序。当然也可以使用比较器。

为了成功地在哈希表中存储和获取对象，用作键的对象必须实现`hashCode` 方法和`equals` 方法。

需求：
将学生对象和归属地的映射关系存储到HashMap集合中，并全部取出。
学生对象中包含着姓名和年龄这样的属性。
公司：这里仅用字符串表示即可。

思路：对学生对象进行描述。同姓名同年龄视为同一人。



    package com.itheima.bean;

    public class Student
    {
    	private String name;
    	private int age;
    	public Student()
    	{
    		super();
    	}

    	public Student(String name, int age)
    	{
    		super();
    		this.name = name;
    		this.age = age;
    	}

    	public String getName()
    	{
    		return name;
    	}

    	public void setName(String name)
    	{
    		this.name = name;
    	}

    	public int getAge()
    	{
    		return age;
    	}

    	public void setAge(int age)
    	{
    		this.age = age;
    	}

    	@Override
    	public int hashCode()
    	{
    		final int prime = 31;
    		int result = 1;
    		result = prime * result + age;
    		result = prime * result + ((name == null) ? 0 : name.hashCode());
    		return result;
    	}

    	@Override
    	public boolean equals(Object obj)
    	{
    		if (this == obj)
    			return true;
    		if (obj == null)
    			return false;
    		if (getClass() != obj.getClass())
    			return false;
    		Student other = (Student) obj;
    		if (age != other.age)
    			return false;
    		if (name == null)
    		{
    			if (other.name != null)
    				return false;
    		}
    		else if (!name.equals(other.name))
    			return false;
    		return true;
    	}


    	@Override
    	public String toString()
    	{
    		return "name=" + name + ", age=" + age + ",Corp";
    	}
    }


HashMap演示代码：



    package com.itheima.collection;

    import java.util.HashMap;
    import java.util.Iterator;
    import java.util.Map;
    import java.util.Set;

    import com.itheima.bean.Student;

    public class HashMapDemo
    {


    	public static void main(String[] args)
    	{
    			HashMap hm = new HashMap();
    			hm.put(new Student("Lucy", 22), "Facebok");
    			hm.put(new Student("Mike", 23), "Mircosoft");
    			hm.put(new Student("Bob", 26), "Amzon");
    			hm.put(new Student("Tom", 23), "Google");
    			hm.put(new Student("Tom", 23), "Apple");

    			// 通过entrySet方法取出
    			Set entrySet = hm.entrySet();
    			for (Iterator it = entrySet.iterator(); it.hasNext();)
    			{
    				System.out.println(it.next());
    			}
    	}

    }

输出结果：


    name=Bob, age=26,Corp=Amzon
    name=Lucy, age=22,Corp=Facebok
    name=Mike, age=23,Corp=Mircosoft
    name=Tom, age=23,Corp=Apple

对学生对象按照年龄排序
TreeMap演示代码：



    package com.itheima.collection;

    import java.util.Comparator;
    import java.util.Iterator;
    import java.util.Map;
    import java.util.Set;
    import java.util.TreeMap;
    import com.itheima.bean.Student;

    public class TreeMapDemo
    {
    	public static void main(String[] args)
    	{
    //		TreeMap tm = new TreeMap();

    		// 自然顺序为按年龄排序，一旦定义就补可以更改
    		// 现在要按姓名排序，故使用比较器
    		TreeMap tm = new TreeMap(new Comparator()
    		{
    			public int compare(Student s1, Student s2)
    			{
    				int tmp = s1.getName().compareTo(s2.getName());
    				return tmp==0 ? s1.getAge() - s2.getAge() : tmp;
    			}

    		});
    		tm.put(new Student("Lucy", 22), "Facebok");
    		tm.put(new Student("Mike", 23), "Mircosoft");
    		tm.put(new Student("Bob", 26), "Amzon");
    		tm.put(new Student("Tom", 23), "Google");
    		tm.put(new Student("Tom", 23), "Apple");

    		// 通过entrySet方法取出
    		Set entrySet = tm.entrySet();
    		for (Iterator it = entrySet.iterator(); it.hasNext();)
    		{
    			System.out.println(it.next());
    		}
    	}
    }


输出结果：


    name=Bob, age=26,Corp=Amzon
    name=Lucy, age=22,Corp=Facebok
    name=Mike, age=23,Corp=Mircosoft
    name=Tom, age=23,Corp=Apple


LinkedHashMap演示代码：


    package com.itheima.collection;

    import java.util.HashMap;
    import java.util.Iterator;
    import java.util.LinkedHashMap;
    import java.util.Map;

    public class LinkedHashMapDemo
    {
    	public static void main(String[] args)
    	{
    		HashMap hm = new LinkedHashMap();
    		hm.put(23, "Kobe");
    		hm.put(16, "Paul");
    		hm.put(3, "Paul");
    		hm.put(9, "paker");

    		printMethod_1(hm);

    		printMethod_2(hm);

    		printMethod_3(hm);
    	}

    	private static void printMethod_3(HashMap hm)
    	{
    		for (Map.Entry me : hm.entrySet())
    		{
    			Integer key = me.getKey();
    			String value = me.getValue();
    			System.out.println(key+"------"+value);
    		}
    	}

    	private static void printMethod_2(HashMap hm)
    	{
    		for (Integer i : hm.keySet())
    		{
    			String value = hm.get(i);
    			System.out.println(i+"--"+value);
    		}
    	}

    	private static void printMethod_1(HashMap hm)
    	{
    		for (Iterator it =  hm.entrySet().iterator(); it.hasNext();)
    		{
    			Map.Entry me = it.next();
    			System.out.println(me.getKey()+"---"+me.getValue());
    		}
    	}
    }



输入结果：


    23---Kobe
    16---Paul
    3---Paul
    9---paker
    23--Kobe
    16--Paul
    3--Paul
    9--paker
    23------Kobe
    16------Paul
    3------Paul
    9------paker




练习：
"abcdvbzvadsza"获取该字符串中每个字母出现的次数，
要求结果是： 字母(次数)字母(次数) 如：a(2)b(3)c(1)e(5)...
思路：


* 发现字母和次数之间存在对应关系。也就是映射关系，这就让我想到了map集合。
* map集合中应该存储是字母和次数，键是字母，值是次数。&nbsp;
* 将map作为一张表，使用了查表法思想。对字符串中的每一个字母都去map表中进行次数的查找。
* &nbsp;&nbsp;如果没有找到对应的次数，就将该字母和1存储到表中。
* 如果找到了对应的次数，就将该次数取出，并对该次数自增后，在将该字母和新的次数重新存入表中，
* &nbsp;&nbsp;对应map集合而言，键相同，值会覆盖
* 所有的字母都查询完毕后，map表就有了所有字母和次数的对应关系，
* 在将这些对应关系变成指定格式的字符串即可。
代码如下：

        package com.itheima.collection;
    
        import java.util.Iterator;
        import java.util.Map;
        import java.util.TreeMap;
    
        public class TreeMapTest
        {
        	public static void main(String[] args)
        	{
        		String str = "abcdvbzvadsza";
        		String strFin = getStrCount(str);
        		System.out.println(strFin);
        	}
    
        	private static String getStrCount(String str)
        	{
        		// 将字符串转换为字符数组
        		char[] chs = str.toCharArray();
    
        		// 定义TreeMap容器作为存储字母和次数的表
        		TreeMap map = new TreeMap();
    
        		// 遍历，查表，存值
        		for (int i = 0; i &lt; chs.length; i++)
        		{
        			//判断是否是字母。
        			if(!(chs[i]&gt;='a' &amp;&amp; chs[i]='A' &amp;&amp;  chs[i] 0)
        				max = tmp;
        		}
        		return max;
        	}
    
        	private static void sortDemo(ArrayList al)
        	{
        		// 自然排序
        		Collections.sort(al);
        		System.out.println(al);
    
        		// 长度排序，比较器实现
        		Collections.sort(al, new Comparator()
        		{
        			public int compare(String o1, String o2)
        			{
        				int tmp = o1.length() - o2.length();
        				return tmp==0 ? o1.compareTo(o2) : tmp;
        			}
        		});
        		System.out.println(al);
        	}
        }

输出结果：

    [hello, aldga, makie, mskv, hello]
    [aldga, hello, hello, makie, mskv]
    [mskv, aldga, hello, hello, makie]
    ------------我是万恶的分割线---------------
    mskv
    mskv
    makie
    ------------我是万恶的分割线---------------
    [ahgdtge, agmlalg, sdgga, erqa, adg]





目前我们学习的集合框架中的大部分常用的集合对象都是线程不同步的。
万一为多线程访问，会出现线程安全问题。
可以通过Collections中的同步集合方法，将非同步的集合，转换成同步的集合。&nbsp;

    public static  Collection synchronizedCollection(Collection c)
    public static  Set synchronizedSet(Set s)
    public static  List synchronizedList(List lis
    public static  Map synchronizedMap(Map m)

Arrays：操作数组的工具类。&nbsp;


* 里面都是静态方法。&nbsp;
* 重点介绍一个方法：数组转成集合。 asList([]);
* 数组对象能有的就是一个属性length，使用了Arrays以后，也就具备那么几个方法。&nbsp;
* 可是将数组转成集合后，就可以使用集合的方法来操作数组中的元素。&nbsp;比如：contains方法。 indexOf
* 这样做了可以有更多的方法对数组中的元素进行操作。
* 但是有些方法不能用，因为数组的长度是固定的。不能使用增或删的方法。&nbsp;

        package com.itheima.collection;
    
        import java.util.ArrayList;
        import java.util.Arrays;
        import java.util.List;
    
        public class ArraysDemo
        {
        	public static void main(String[] args)
        	{
        		int[] arr = {1, 3, 4, 56, 34, 3, 43};
        		System.out.println(Arrays.toString(arr));
    
        		String[] str = {"abc","haha","xixi"};
        		List list = Arrays.asList(str);
        //		list.add("heihei");//UnsupportedOperationException
        		System.out.println(list.contains("haha"));
        		System.out.println(list);
    
        		//特殊情况。
        		Integer[] nums = {7,9,3};
        		List list2 = Arrays.asList(nums);
        		System.out.println(list2.size());
    
        		// 集合转数组
        		// 集合转成数组的原因，限制对元素的操作，比如增删。
        		ArrayList al = new ArrayList();
        		al.add("agdla");
        		al.add("asdgae");
        		al.add("rehgre");
        		String arr2[] = al.toArray(new String[al.size()]);
        		System.out.println(Arrays.toString(arr2));
        	}
        }

输出结果：

    [1, 3, 4, 56, 34, 3, 43]
    true
    [abc, haha, xixi]
    3
    [agdla, asdgae, rehgre]


&nbsp;如果要传入多个参数，而且都是同一类型，可以定义数组类型的参数。
&nbsp;但是传递时，必须先有数组对象。
&nbsp;jdk1.5后，为了简化书写，出现了特性，可变参数。
&nbsp;同样还是代表数组，但是不需要在创建数组对象了，直接将数组中的元素作为参数传入即可。
&nbsp;它会自动的将这些参数封装到数组中。&nbsp;
&nbsp;局限性。可变参数必须定义在参数列表的最后面。
&nbsp;

    int sum = add5(4,1,7,4,8,9);
    System.out.println(sum);
    public static int add(int a,int... arr)
    {
        int sum = 0;
        for(int x=0; x
        {
            sum+=arr[x];
        }
        return sum;
    }


&nbsp;如果要传入多个参数，而且都是同一类型，可以定义数组类型的参数。
&nbsp;但是传递时，必须先有数组对象。
&nbsp;jdk1.5后，为了简化书写，出现了特性，可变参数。
&nbsp;同样还是代表数组，但是不需要在创建数组对象了，直接将数组中的元素作为参数传入即可。
&nbsp;它会自动的将这些参数封装到数组中。&nbsp;
&nbsp;局限性。可变参数必须定义在参数列表的最后面。
&nbsp;


    int sum = add5(4,1,7,4,8,9);
    System.out.println(sum);
    public static int add(int a,int... arr)
    {
    	int sum = 0;
    	for(int x=0; x 
    }
    return sum;

静态导入：
    
    package com.itheima.collection
    import java.util.Collections;
    import java.util.List;
    import java.util.ArrayList;
    //将一个类中的静态成员进行导入。简化书写。 
    import static java.util.Collections.*;
    import static java.lang.System.*;
    public class StaticImportDemo 
    {
    	public static void main(String[] args) 
    	{
    		List<String> list = new ArrayList<String>();
    		list.add("abc1");
    		list.add("abc6");
    		list.add("abc2");
    		list.add("abc9");
    		
    		sort(list);		
    		max(list);
    	}
    }
    
