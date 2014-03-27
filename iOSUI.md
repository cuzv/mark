# iOS UI Notes

- [UIView(视图)](#UIView)
- [UIViewController(视图控制器)](#UIViewController)
- [UIButton(按钮)](#UIButton)
- [UILabel(标签)](#UILabel)
- [UITextField(文本域)）](#UITextField)
- [UITextView(文本视图)](#UITextView)
- [UIPageControl(分页控件)](#UIPageControl)
- [UISwitch(开关)](#UISwitch)
- [UISlider(滑条)](#UISlider)
- [UIProgressView(进度条)](#UIProgressView)
- [UISegmentedControl(分段控件)](#UISegmentedControl)
- [UIActivityIndicatorView(进度指示器/菊花)](#UIActivityIndicatorView)
- [UINavigationController(导航控制器)](#UINavigationController)
- [UINavigationBar(导航条)](#UINavigationBar)
- [UINavigationItem(导航栏按钮)](#UINavigationItem)
- [UIToolBar(工具栏)](#UIToolBar)
- [UITabBarController(标签栏控制器)](#UITabBarController)
- [UIScrollView(滚动视图)](#UIScrollView)
- [UITableView(表视图)](#UITableView)
- [UITableViewController(表视图控制器)](#UITableViewController)
- [UITouch(触摸)](#UITouch)
- [UIPickerView(选择器视图)](#UIPickerView)
- [AV(多媒体)](#AV)

- - -

<h3 id="UIView"> UIView </h3>

**UIView常见属性以及含义**
	
* frame:  			相对于父视图的位置和大小(CGRect)/坐标
* bounds: 			相对于自己的的位置和大小(CGRect)/边框大小
* center:			相对于父视图自己的中心点
* transform 		变换属性(CGAffineTransform)/翻转或者缩放视图
* superview			父视图
* subviews			子视图
* window			当前view所在的window
* backgroundColor	背景色(UIColor)
* alpha				透明度(CGFloat)
* hidden			是否隐藏
* userInteractionEnabled	是否开启交互
* multipleTouchEnabled 是否开启多点触摸
* tag				区分标识
* layer				视图层(CALayer)
* contentMode		内容模式(边界的变化和缩放)
* superView			父视图
* subViews			子视图数组
* clipsToBounds		剪裁子视图
* autoresizesSubviews 允许子类view自动布局
* autoresizingMask	自动布局模式(子类view)
* alpha				透明度
* contentStech		改变视图内容如何拉伸

**TIPS**

* 屏幕上能够看见的都是UIView
* 每一个UIView都是容器
* IBAction === void 能让方法显示到storyboard文件的右键列表
* IButlet能够让属性显示到storyboard的右键列表
* bounds的x,y永远为0(以自身左上角为原点)，frame的x,y以父视图的左上角为原点

**UIView加载过程**

- 首先访问view属性
- 如果存在view，加载。若不存在，则UIViewController调用loadView方法
- loadView方法执行如下操作
	- 如果覆盖了该方法，必须创建view给UIViewController的view属性
	- 如果没有复写该方法，UIViewController会默认调用initWithNibName:bundle:方法初始化并加载view
- 通过viewDidLoad方法来执行一些其他任务

**UIView层的操作常用方法**

- (void)removeFromSuperview; // 从父视图中移除
- (void)addSubview:(UIView *)view; // 添加一个子视图
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)slibingSubview; // 插入一个view到某个view的下层
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)slibingSubview; // 插入一个view到某个view的上层
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index; // 插入一个view到特定层
- (void)bringSubviewToFront:(UIView *)view; // 将某个view放在最上层
- (void)sendSubviewToBack:(UIView *)view; // 将某个view放在最下层
- (BOOL)isDescendantOfView(UIView *)view; // 是否是某个视图的子孙视图
- (void)exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2; // 交换两个层的view
- (UIView *)viewWithTag:(NSInteger)view; // 取到指定tag值的view  

---

