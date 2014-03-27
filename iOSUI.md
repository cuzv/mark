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

<h3 id="UIViewController"> UIViewController </h3>

**初始化**

	UIViewController *viewController = 	[[UIViewController alloc] init];

**UIViewController生命周期**

- (void)viewDidLoad; //视图加载完成
- (void)viewWillAppear:(BOOL)animated; // 将要显示
- (void)viewDidAppear:(BOOL)animated; // 显示完成
- (void)viewWillDisappear:(BOOL)animated; // 将要移除
- (void)viewDidDisappear:(BOOL)animated; // 已经移除
- (void)didReceiveMemoryWarning; // 内存警告
- (BOOL)shouldAutorotate; // 支持转屏
- (NSInteger)supportedInterfaceOrientations; // 支持的转屏方向 
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration; // 控制器试图将要旋转到某个朝向，在方法中处理新的界面布局
	
**视图控制器的切换**
	
	// 设置切换动画效果
    detailViewControl.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    // 切换到下一视图
	[self presentViewController:detailViewControl animated:YES completion:nil];
	// 返回上一视图
	[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];	

---

<h3 id="UIButton"> UIButton(按钮) </h3>

**UIButton初始化**

	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	button.frame = CGRectMake(100, 100, 130, 140);
	[button setTitle:@"按钮" forState:UIControlStateNormal];
	[button addTarget:self action:@selector(pressedButton:) forControlEvents:UIControleEventTouchUpInside]
	
**事件与回调**

- UIControlEventTouchUpInside // 触摸弹起	
- UIControlEventValueChanged  // 值变化事件
- UIControlEventTouchDown	  // 边界内触摸按下事件
- UIControlEventTouchDownRepeat // 轻击数大于1的重复按下事件

**设置背景和图片**

	- [button setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
	- button.adjustsImageWhenHightlighted = YES; //高亮按钮变暗(需设置背景图片)
	- [button setTitle:@"按钮" forState:UIControlStateNormal];
	
	- [lightButton setImage:[UIImage imageNamed:@"开灯"] forState:UIControlStateNormal];
    - [lightButton setImage:[UIImage imageNamed:@"关灯"] forState:UIControlStateHighlighted]; // 高亮状态
    - [lightButton setImage:[UIImage imageNamed:@"关灯"] forState:UIControlStateSelected]; // 选中状态
	- UIControlStateDisable //无法交互状态
	
---

<h3 id="UILabel"> UILabel(标签) </h3>	
	
**UILabel常用属性**

- text 					// 设置文本内容
- font 					// 设置文本字体格式和大小
- textColor 			// 设置文本颜色
- textAlignment 		// 设置对齐方式
- backgroundColor 		// 设置背景色
- numberOfLines 		//文本显示行数，0表示不限制
- lineBreakMode   (NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail); // 单词换行|末尾"..."	
- baselineAdjustment	// 文本基线位置(只有一行文本时有效)
	
**demo**

	CGSize size = [self sizeWithString:string font:[UIFont systemFontOfSize:15] constraintSize:CGSizeMake(150, 568)];

    UILabel *rightLabel        = [[UILabel alloc] initWithFrame:CGRectMake(165, 250, size.width, size.height)];
    rightLabel.backgroundColor = [UIColor greenColor];
    rightLabel.tag             = 14;
    rightLabel.text            = string;
    rightLabel.textAlignment   = NSTextAlignmentLeft;
    rightLabel.font            = [UIFont systemFontOfSize:15];
    rightLabel.textColor       = [UIColor grayColor];
    rightLabel.numberOfLines   = 0; //文本显示行数，0表示不限制
    rightLabel.lineBreakMode   = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail; // 单词换行|末尾"..."
    [self.view addSubview:rightLabel];
    [rightLabel release];
	
	// 根据字符内容多少获取Rect的size
	- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constraintSize:(CGSize)constraintSize
	{
	    CGRect rect = [string boundingRectWithSize:CGSizeMake(150, 568)
	                                       options:NSStringDrawingTruncatesLastVisibleLine |
	                                                NSStringDrawingUsesFontLeading |
	                                                NSStringDrawingUsesLineFragmentOrigin
	                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
	                                       context:nil];
	    return rect.size;
	}

---

<h3 id="UITextField"> UITextField(文本域) </h3>

**UITextField常用属性**

- borderStyle 边框样式
- placeholder 提示文字
- keyboardType 键盘样式
- keyboardAppearance 键盘外观
- secureTextEntry 密文输入
- clearButtonMode 清楚按钮模式
- inputView 弹出视图(可以自定义键盘)
- inputAccessView 共存键盘
- leftView 左侧视图
- leftViewMode 左侧视图模式
- rightView 右侧视图
- rightViewMode 右侧视图模式
- clearsOnBegingEditing 再次编辑是否清空
- contentVerticalAlignment 内容纵向对齐方式
- contentHorizontalAlignment 内容横向对齐方式
- textAlignment 文本横向对齐方式
- adjustsFontSizeToFitWidth 文本滚动
- autocapitalizationType 首字母是否大写

**demo**

	UITextField *textField           = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 50, CGRectGetMinY(self.view.frame) + 150, 200, 25)];
    textField.tag = 15;
    textField.borderStyle            = UITextBorderStyleRoundedRect;
    textField.placeholder            = @"请输入文本....";
    textField.font                   = [UIFont systemFontOfSize:10];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;    // 自动大写
    textField.autocorrectionType     = UITextAutocorrectionTypeNo;          // 自动更正
    textField.tintColor              = [UIColor redColor];                  // 主色调
    textField.keyboardType           = UIKeyboardTypeDefault;               // 键盘类型
    textField.returnKeyType          = UIReturnKeyDone;                     // return键类型
    textField.clearButtonMode        = UITextFieldViewModeWhileEditing;     // 清除模式
    textField.delegate               = self;                                // 设置委托
    textField.secureTextEntry        = YES;
    [self.view addSubview:textField];	

注意：若要实现<UITextFieldDelegate>协议中的方法，必须设置delegate为当前对象	

**<UITextFieldDelegate>中的方法**

- \- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField; // 文本输入框是否可以进入编辑模式
- \- (void)textFieldDidBeginEditing:(UITextField *)textField;  // 文本输入框已经进入编辑模式
- \- (BOOL)textFieldShouldEndEditing:(UITextField *)textField; // 文本输入框是否可以结束编辑模式
- \- (void)textFieldDidEndEditing:(UITextField *)textField; // 文本输入框已经结束编辑模式
- \- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string; // 替换文本输入框内容
- \- (BOOL)textFieldShouldClear:(UITextField *)textField; // 文本输入框是否可以点击clear按钮
- \- (BOOL)textFieldShouldReturn:(UITextField *)textField; // 文本输入框是否可以点击return按钮

---

<h3 id="UITextView"> UITextView </h3>

**UITextView常用属性**

- text 文字内容
- textColor 文字颜色
- textAlignment 文字对齐方式
- selectedRange 控制滚动
- editable 是否可编辑

**UITextView常用方法**

- \- (void)scrollRangeTovisible:(NSRange)range;
- \- (void)textViewShouldBeginEditing:(UITextView *)textView;
- \- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
- \- (void)textViewDidBeginEditing:(UITextView *)textView;
- \- (void)textViewDidEndEditing:(UITextView *)textView;
- \- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- \- (void)textViewDidChange:(UITextView *)textView;
- \- (void)textViewDidChangeSelection:(UITextView *)textView;


---

<h3 id="UIPageControl"> UIPageControl(分页控件) </h3>

**常用属性和方法**

- numberOfPage	共有几个分页"圆圈"
- currentPage	显示当前的页
- hideForSinglePage	只存在一页时，是否隐藏，默认YES
- (void)updateCurrentPageDisplay;	刷新视图

**TIPS**

- 通常与UIScrollView连用，提示用户当前显示的页数 

---

<h3 id="UISwitch"> UISwitch(开关) </h3>
	
**UISwitch常用属性**

- isOn 是否打开状态
- onTintColor 开启状态颜色
- tintColor 关闭状态颜色
- thumbTintColor 按钮颜色
- onImage 开启状态图片
- offImage 关闭状态图片

**UISwitch常用方法**

- \-(void)setOn:(BOOL)on animated:(BOOL)animated; // 设置开关状态并带有动画效果
	
**demo**

	UISwitch *switchControl      = [[UISwitch alloc] initWithFrame:CGRectMake(120, 50, 80, 30)];
    UISwitch *switchControl      = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 40, CGRectGetMinY(self.view.frame) + 55, 80, 30)];
    switchControl.tintColor      = [UIColor grayColor]; // 主色调,边框
    switchControl.onTintColor    = [UIColor redColor]; // 开启后颜色
    switchControl.thumbTintColor = [UIColor blackColor]; // 开关按钮颜色
	//    switchControl.on             = YES; // 默认开启
    [switchControl addTarget:self action:@selector(processControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switchControl];
    [switchControl release];

---

<h3 id="UISlider"> UISlider(滑条) </h3>
	
**UISlider常用属性**	
	
- value 当前值
- minimumValue 最小值
- maximumValue 最大值
- minimumValueImage 最小值一侧图片
- maximumValueImage 最大值一侧图片
- minimumTintColor 最小值颜色
- maximumTintColor 最大值颜色
- thumbTintColor 滑块颜色

**UISlider常用方法**

- \- (void)setValue:(float)value animated:(BOOL)animated;
- \- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state;
- \- (void)setMinimumTrackImage:(UIImage *)image forState(UIControlState)state;
- \- (void)setMaximumTrackImage:(UIImage *)image forState(UIControlState)state;
		
**demo**
	
	UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMaxY(switchControl.frame) + 20, 200, 30)];
    [self.view addSubview:slider];
    slider.value                 = 0.5;
    slider.minimumValue          = 0.2; // 最小值
    slider.maximumValue          = 1.0; // 最大值
    slider.minimumTrackTintColor = [UIColor redColor]; // 滑条最小进度指示色
    slider.maximumTrackTintColor = [UIColor grayColor]; // 滑条最大进度指示色
    slider.continuous            = NO; //是否持续调用事件方法
    self.view.alpha              = slider.value;
    [slider addTarget:self action:@selector(processControl:) forControlEvents:UIControlEventValueChanged];
    [slider release];

---

<h3 id="UIProgressView"> UIProgressView(进度条) </h3>

**UIProgressView常用属性**

- progress 当前进度值
- progressTintColor 高亮颜色
- trackTintColor 轨道颜色
- progressImage 进度条图片
- trackImage 轨道图片

**demo**

	UIProgressView *progressView   = [[UIProgressView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMaxY(slider.frame) + 20, 200, 30)];
    progressView.tag               = 20;
    progressView.progress          = slider.value;
    progressView.progressTintColor = [UIColor redColor];
    progressView.trackTintColor    = [UIColor grayColor];
    [self.view addSubview:progressView];
    [progressView release];
    
---

<h3 id="UISegmentedControl"> UISegmentedControl(分段控件) </h3>

**demo**

	// 分段控件
    UISegmentedControl *segmentedControl  = [[UISegmentedControl alloc] initWithItems:@[@"白", @"红", @"绿", @"蓝"]];
    segmentedControl.bounds               = CGRectMake(0, 0, 200, 30);
    segmentedControl.center               = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(progressView.frame) + 40);
    segmentedControl.selectedSegmentIndex = 0; // 当前默认选中的按钮索引
    segmentedControl.tintColor            = [UIColor blackColor];
    [segmentedControl addTarget:self action:@selector(processControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    [segmentedControl release];

---

<h3 id="UIActivityIndicatorView"> UIActivityIndicatorView(进度指示器/菊花) </h3>

	// 进度指示器
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.bounds           = CGRectMake(0, 0, 40, 40);
    activityIndicatorView.center           = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(segmentedControl.frame) + 30);
	//    activityIndicatorView.hidesWhenStopped = NO; // 进度指示器动画停止后是否显示，默认是YES
    
    activityIndicatorView.tag              = 21;
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView release];

---

<h3 id="UIImageView"> UIImageView </h3>

**UIImageView常用属性**

- image 图片
- animationImages 动画数组
- animationDuration 动画周期
- animationRepeatCount 动画循环次数
- contentMode 内容模式

**UIImageViewdog动画**

- \- (void)startAnimating; // 开始动画
- \- (void)stopAnimating; // 结束动画
- \- (void)isAnimating; // 是否在动画中

---

<h3 id="UINavigationController"> UINavigatonController(导航控制器) </h3>

**基本概念**

- UINavigationController继承于UIViewController，通过栈的方式来管理视图控制器，视图控制器通过入栈，出栈操作进行切换
- UINavigationController用于处理复杂的分层数据
- UINavigationController维护一个视图控制器，任何类型的视图控制器都可以放到导航控制器的栈中

**初始化方法**

- \- (id)initWithRootViewController:(UIViewController *)rootViewController;

**视图入栈和出栈操作**
	
	// 入栈
	DetailNextViewController *detailNextViewController = [[DetailNextViewController alloc] init];
    [self.navigationController pushViewController:detailNextViewController animated:YES];
    [detailNextViewController release];
    
    // 出栈
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    [self.navigationController popToViewController:viewControllers[1] animated:YES];

**说明**

- viewControllers能够拿到所有视图控制器的实例
- viewControllers视图控制器在数组中的顺序即为视图控制器在导航控制器栈中的顺序
- 传参进去的视图控制器实例必须存在于导航控制器栈中

**自定义导航控制器的push、pop动画效果**

在导航器对应视图的layer上，加载自己的动画效果

	+ (CATransition *)addCubeAnimation
	{
		CATransition *animation = [CATransition animation];
		// 设置动画效果
		animation setType:@"cube";
		// 设置作用方向
		[animation setSubType:kCATransitionFromRight];
		// 设置动画时长
		[animation setDuration:0.8f];
		// 设置动画作用范围
		[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		return animation;
	}

**TIPS**

- 一个导航控制器包含若干个视图控制器
- 一个导航控制器包含一个NavigationBar和一个toolBar
- NavigationBar中的"按钮"是一个UINavigationItem(only one)
- 通过设置UINavigationItem的属性，显示Item(UINavigationBar)
- UINavigationItem不是由navigationBar控制的，更不是由UINavigationController来控制，而是由当前视图控制器来控制的

---

<h3 id="UINavigationBar"> UINavigationBar </h3>

**UINavigationBar常用属性和方法**

	//设置导航条样式
	@property (nonatomic, assign)UIBarStyle barStyle;
	
	// 设置导航条自动裁剪属性
	@property (nonatomic) BOOL clipsToBounds
	
	// IOS5以后设置导航条的背景图片和显示模式
	- (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics;
	
	// 隐藏导航条的属性
	@property (nonatomic, getter=isNavigationBarHidden) BOOL navigationBarHidden;
	
	// 隐藏导航条的方法
	- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;

---

<h3 id="UINavigationItem"> UINavigationItem </h3>

- 每个视图控制器都有一个UINavigationItem属性
- 每个视图控制器都可以通过UINavigationItem属性来定制导航栏的显示效果

**常用属性和方法**

	// 设置标题，显示在导航栏的中间
	@property(nonatomic,copy) NSString *title;
	// 设置标题视图，显示在导航栏的中间位置
	@property(nonatomic,retain) UIBarButtonItem *backBarButtonItem;
	// 左侧按钮
	@property(nonatomic,retain) UIBarButtonItem *leftBarButtonItem;
	// 右侧按钮
	@property(nonatomic,retain) UIBarButtonItem *rightBarButtonItem;
	// 设置左侧按钮
	- (void)setLeftBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated;
	// 设置右侧按钮
	- (void)setRightBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated;
	
	@property(nonatomic,copy) NSArray *leftBarButtonItems NS_AVAILABLE_IOS(5_0);
	@property(nonatomic,copy) NSArray *rightBarButtonItems NS_AVAILABLE_IOS(5_0);
	- (void)setLeftBarButtonItems:(NSArray *)items animated:(BOOL)animated NS_AVAILABLE_IOS(5_0); 
	- (void)setRightBarButtonItems:(NSArray *)items animated:(BOOL)animated NS_AVAILABLE_IOS(5_0);
	
---

<h3 id="UIToolBar"> UIToolBar </h3>

- UINavigationController有个UIToolBar属性
- UIToolBar继承于UIView
- UINavigationController底部工具栏默认处于隐藏状态
- 每个视图控制器可以通过toolBarItems属性来定制toolBar

---

<h3 id="UITabBarController"> UITabBarController </h3>

- UITabBarController继承于视图控制器，通过标签栏项的形式来管理视图控制器，各个标签栏项之间的视图控制器彼此独立，互不影响
- UITabBarController中各个视图的生命周期和UITabBarController的声明周期是一致的
- 点击不同的标签栏项(UITabBarItem)，展现不同的视图控制器的view
- 被点中的标签栏项对应的视图控制器的view处于显示状态，其他的视图控制器的view处于卸载状态

---

<h3 id="UIScrollView"> UIScrollView(滚动视图) </h3>

**创建一个UIScrollView实例**

```
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼// 创建⼀一个UIScrollView实例
CGRect frame = CGRectMake( 0, 0, 200, 200);
UIScrollView *scrollView= [[UIScrollView alloc] initWithFrame:frame];
// 添加子视图(框架可以超过scrollview的边界)
frame= CGRectMake( 0, 0, 500, 500);
UIImageView *myImageView= [[UIImageView alloc] initWithFrame:frame]; [scrollView addSubview:myImageView];
// 设置内容尺寸
scrollView.contentSize = CGSize(500,500);
```

**UIScrollView常用属性**

```
contentSize
// 里面内容的大小,也就是可以滚动的大小,默认是0,没有滚动效果。 tracking
// 当 touch 后还没有拖动的时候值是YES,否则NO
zoomBouncing
// 当内容放大到最大或者最小的时候值是 YES,否则 NO zooming
// 当正在缩放的时候值是 YES,否则 NO decelerating
// 当滚动后,手指放开但是还在继续滚动中。这个时候是 YES,其它时候是 NO decelerationRate
// 设置手指放开后的减速率
maximumZoomScale
// ⼀一个浮点数,表示能放最大的倍数 minimumZoomScale
// ⼀一个浮点数,表示能缩最小的倍数 pagingEnabled
// 当值是 YES 会自动滚动到 subview 的边界。默认是NO scrollEnabled
// 决定是否可以滚动
showsHorizontalScrollIndicator
// 滚动时是否显示水平滚动条 showsVerticalScrollIndicator
// 滚动时是否显示垂直滚动条 bounces
// 默认是 yes,就是滚动超过边界会反弹有反弹回来的效果。假如是 NO,那么滚动到达边
界会立刻停止。
bouncesZoom
// 和 bounces 类似,区别在于:这个效果反映在缩放上面,假如缩放超过最大缩放,那么会 反弹效果;假如是 NO,则到达最大或者最小的时候立即停止。
directionalLockEnabled
// 默认是 NO,可以在垂直和水平方向同时运动。当值是 YES 时,假如⼀一开始是垂直或者是 水平运动,那么接下来会锁定另外⼀一个方向的滚动。 假如⼀一开始是对角方向滚动,则不会禁止 某个方向
indicatorStyle
// 滚动条的样式,基本只是设置颜色。总共3个颜色:默认、黑、白 scrollIndicatorInsets
// 设置滚动条的位置
```

**UIScrollView常用代理方法**

```
￼￼// scrollView已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
// 视图已经放大或缩小
- (void)scrollViewDidZoom:(UIScrollView *)scrollView;
// scrollView开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
// scrollView结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
// scrollView开始减速(以下两个方法注意与以上两个方法加以区别)
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView; // scrollview减速停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
```

**UIScrollView的捏合手势**

UIScrollView能很简单的使用捏手势来进行缩放,可以缩小或者放大,只需要 实现一个委托方法就可以,简单的几个步骤就可以让滚动视图的子视图支持缩放功能

```
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return view; // view可以进行缩放
}

- (void)loadView
{
  self.scrollView.minimumZoomScale = 0.5;
  self.scrollView.maximumZoomScale = 6.0;
  self.scrollView.contentSize = CGSizeMake(1280, 960);
  self.scrollView.delegate = self;
} // 适合单张图片
```
---

<h3 id="UITableView"> UITableView(表视图) </h3>

**表视图常用属性**

	// 表视图分割线风格
	@property (nonatomic) UITableViewCellSeparatorStyle separatorStyle;
	// 表视图分割线颜色、默认标准灰色
	@property (nonatomic, retain) UIColor *separatorColor;
	// 表视图头部视图
	@property (nonatomic, retain) UIView *tableHeaderView;
	// 表视图尾部视图
	@property (nonatomic, retain) UIView *tableFooterView;
	// 表视图单元格行高
	@property (nonatomic) CGFloat rowHeight;
	// 表视图section头部行高
	@property (nonatomic) CGFloat sectionHeaderHeight;
	// 表视图section尾部行高
	@property (nonatomic) CGFloat sectionFooterHeight;
	// 表视图背景
	@property (nonatomic, readwrite, retain) UIView *backgroundView;
	// 默认为NO,不可以编辑,设置时,不存在动画效果
	@property(nonatomic,getter=isEditing) BOOL editing;
	// 覆盖此方法,存在动画效果
	- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
	// 默认为YES,当表视图不在编辑时,单元格是否可以选中
	@property(nonatomic) BOOL allowsSelection NS_AVAILABLE_IOS(3_0);
	// 默认为NO,当表视图在编辑时,单元格是否可以选中
	@property(nonatomic) BOOL allowsSelectionDuringEditing;
	// 默认为NO,是否可以同时选中多个单元格,注意版本问题
	@property(nonatomic) BOOL allowsMultipleSelection NS_AVAILABLE_IOS(5_0);
	// 默认为NO,在编辑状态下时,是否可以同时选中多个单元格,注意版本问题
	@property(nonatomic) BOOL allowsMultipleSelectionDuringEditing NS_AVAILABLE_IOS(5_0);

**常用方法**

	￼// 指定⼀一个cell,返回⼀一个NSIndexPath实例,如果cell没有显示,返回nil
	- (NSIndexPath *)indexPathForCell:(UITableViewCell *)cell;
	// 指定⼀一个范围,返回⼀一个数组,内容是NSIndexPath实例,指定rect无效,返回nil
	- (NSArray *)indexPathsForRowsInRect:(CGRect)rect;
	// 指定⼀一个NSIndexPath,返回⼀一个cell实例,如果cell没有显示,返回为nil
	- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;
	// 根据显示的cell,返回⼀一组cell实例的数组,如果没有显示,返回nil
	- (NSArray *)visibleCells;
	// 根据显示的cell,返回⼀一组NSIndexPath实例的数组,如果没有显示,返回nil
	- (NSArray *)indexPathsForVisibleRows;
	// 滑动到指定的位置,可以配置动画
	- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition: (UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
	// 插入⼀一行cell,指定⼀一个实现动画效果
	- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation: (UITableViewRowAnimation)animation;
	// 删除⼀一行cell, 指定⼀一个实现动画效果
	- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation: (UITableViewRowAnimation)animation;
	// 刷新⼀一个行cell,指定⼀一个实现动画效果
	- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation: (UITableViewRowAnimation)animationNS_AVAILABLE_IOS(3_0);
	// 移动cell的位置,指定⼀一个实现动画效果
	- (void)moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath NS_AVAILABLE_IOS(5_0);
	// 指定特定的行和列
	  + (NSIndexPath *)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
	  @property(nonatomic,readonly) NSInteger section; // 指定分区 @property(nonatomic,readonly) NSInteger row; // 指定行

￼**常用数据源方法**

	// 配置section中含有行数
	- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section;
	// 创建单元格实例
	- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
	@optional
	// 配置表视图section个数,默认为1
	- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
	// section中的头部视图的标题
	- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection: (NSInteger)section;
	// section中的尾部视图的标题
	- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection: (NSInteger)section;
	// 指定单元格是否支持编辑
	- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
	// 指定单元格是否支持移动
	- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
	// 用户编辑了哪⼀一个单元格,在这里执行删除操作
	- (void)tableView:(UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
	// 实现此方法,移动单元格
	- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

**常用委托方法**

	￼// 配置行高
	- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath;
	// 设置section 头部、尾部视图的高度
	- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection: (NSInteger)section;
	- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection: (NSInteger)section;
	// 自定义section头部、尾部视图,注意:需要指定高度
	- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection: (NSInteger)section;
	- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection: (NSInteger)section;
	￼￼// 用户单击单元格中辅助按钮时,调用该方法
	- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
	// 用户单击单元格,调用该方法
	- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath;
	// 取消单元格时,调用该方法
	- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath: (NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
	// 设置单元格编辑样式
	- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;

**单元格的重用**

	// 静态标识符
	static NSString *identifier = @"Cell";
	// 检测查询是否有闲置的单元格
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	    if (cell == nil) {
	        cell = [[[UITableViewCell alloc]
	                     initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼autorelease];
	    }
	// 设置cell的内容
	return cell;

- - -

<h3 id="UITableViewController"> UITableViewController(表视图控制器) </h3>

**常用属性**

	￼￼// 通过这个属性,访问和设置表视图
	@property(nonatomic,retain) UITableView *tableView;
	// 默认YES,当视图出现时,是否取消选中状态
	@property(nonatomic) BOOL clearsSelectionOnViewWillAppear;
	￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼// 默认为nil,如你需要它将会被创建
	@property(nonatomic,readonly,retain) UIImageView *imageView NS_AVAILABLE_IOS(3_0);
	// 默认为nil,如果你需要它将会被创建
	@property(nonatomic,readonly,retain) UILabel *textLabel NS_AVAILABLE_IOS(3_0);
	// 默认为nil,如果你需要它将会被创建,注意需要选择表视图的风格 @property(nonatomic,readonly,retain) UILabel *detailTextLabel NS_AVAILABLE_IOS(3_0);
	// 添加自定义视图,需要添加在contentView中,如果你直接添加在cell中,那么当编辑模式时,它 的位置不会发生改变,因此我们添加自定义视图时,需要添加到contentView中
	@property(nonatomic,readonly,retain) UIView // 通过这个属性定制单元格背景
	@property(nonatomic,retain) UIView // 通过这个属性定制单元格选中背景 @property(nonatomic,retain) UIView
	￼// 多选时选中的背景视图
	@property(nonatomic,retain) UIView *multipleSelectionBackgroundView NS_AVAILABLE_IOS(5_0);
	// 获取单元格标识符
	@property(nonatomic,readonly,copy) NSString *reuseIdentifier;
	// 设置单元格选中风格
	@property(nonatomic) UITableViewCellSelectionStyle selectionStyle;
	// 获取单元格编辑风格
	@property(nonatomic,readonly) UITableViewCellEditingStyle editingStyle; // 设置单元格辅助图标类型
	@property(nonatomic) UITableViewCellAccessoryType
	// 自定义辅助图标
	@property(nonatomic,retain) UIView
	// 自定义编辑图标
	@property(nonatomic,retain) UIView	

**改变系统样式位置**

	- (void)layoutSubviews {
      		[super layoutSubviews];
	      self.textLabel.frame = CGRectMake(10, 5, 200, 20);
	      self.detailLabel.frame = CGRectMake(10, 30, 100, 10);
	      self.imageView.frame = CGRectMake(260, 30, 50, 10);
	  }

**定制单元格第一种方式:向contentView添加子视图**

```
if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:identifier] autorelease];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 20)];
    titleLab.tag = 100;
    titleLab.font = [UIFont boldSystemFontOfSize:14.0f];
    titleLab.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:titleLab];
    [titleLab release];
    // 添加其他子视图.....
}
UILabel *titleLab = (UILabel *)[cell.contentView viewWithTag:100]; titleLab.text = @"label内容";
```

**定义单元格第二种方式:xib定义单元格**
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼
```
￼￼if (cell == nil) {
    NSBundle *bundle = [NSBundle mainBundle];
    // 加载xib
    NSArray *array = [bundle loadNibNamed:@"newsCell" owner:self
                                  options:nil];
    cell = [array objectAtIndex:0];
}
UILabel *titleLab = (UILabel *)[cell.contentView viewWithTag:100]; titleLab.text = @"label内容";
```

**￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼定制单元格第三种方式:子类化定制**

```
- (void)_initViews {
    _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLab.font = [UIFont boldSystemFontOfSize:14.0f];
    _titleLab.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_titleLab];
    // .....初始化其他UI控件
}

- (void)setNews:(News *)news {
    _titleLab.text = news.title;
    _commentLab.text = [NSString stringWithFormat:@"%d条评论", news.commentCount];
    _timeLab.text = [NSString stringWithFormat:@"%d小时前",news.timeVal];
}
    
- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLab.frame = CGRectMake(10, 5, 200, 20);
    _commentLab.frame = CGRectMake(10, 30, 100, 10);
    _timeLab.frame = CGRectMake(260, 30, 50, 10);
}
```

**表视图的编辑**

```
- (void)tableView:(UITableView *)tableView
    commitEditingStyle: (UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_data removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        //新增
        NSString *obj = [NSString stringWithFormat:@"我是新添加的"];
        [_data insertObject:obj atIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
```

**编辑模式数据源方法**

```
￼// 定义可编辑的单元格
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
// 定义编辑模式下,按钮的显示样式,有新增、删除 -(UITableViewCellEditingStyle)tableView:(UITableView *)tableView
editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath; // 新增、删除按钮事件
- (void)tableView:(UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
// 实现此方法,单元格即可移动
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath; // 指定可移动的单元格
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
```

**过滤表格内容**

```
￼￼￼￼- (void)textChange:(UITextField *)textfield {
    NSString *text = textfield.text;
    if ([text length] == 0) {
        self.filterData = _data;
        [self.tableView reloadData];
        return;
    }
    // 过滤条件
    NSString *p = [NSString stringWithFormat:@"SELF LIKE[c]'%@*'",text];
    //使用谓词过滤
    NSPredicate *predicate = [NSPredicate predicateWithFormat:p];
    self.filterData = [_data filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}
```

- - -

<h3 id="UITouch"> UITouch </h3>

```
响应者类通过复写以下方法,可以监听触摸事件
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼// 当⼀一个或多个⼿手指触碰屏幕时
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
// 当⼀一个或多个⼿手指在屏幕上移动时
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
// 当⼀一个或多个⼿手指离开屏幕时
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
// 当触摸序列被诸如电话呼⼊入这样的系统事件所取消时
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
```

**UITouch类中常用属性**
```
window: 触摸产⽣生时所处的窗⼝口。
view: 触摸产⽣生时所处的视图。
tapCount: 轻击(Tap)操作和⿏鼠标的单击操作类似,tapCount表⽰示短时间内轻击屏幕的次数。因此可以根据tapCount判 断单击、双击或更多的轻击。
timestamp: 时间戳记录了触摸事件产⽣生或变化时的时间。单位是秒。
phase: 触摸事件在屏幕上有⼀一个周期,即触摸开始、触摸点移动、触摸结束,还有中途取消。⽽而通过phase可以查看当前 触摸事件在⼀一个周期中所处的状态。phase是UITouchPhase类型的,这是⼀一个枚举配型,包含了
UITouchPhaseBegan(触摸开始)
UITouchPhaseMoved(接触点移动)
UITouchPhaseStationary(接触点⽆无移动)
UITouchPhaseEnded(触摸结束)
UITouchPhaseCancelled(触摸取消)
```

**UITouch类中常用方法**

```
//  函数返回⼀一个CGPoint类型的值,表⽰示触摸在view这个视图上的位置,这⾥里返回的位 置是针对view的坐标系的。
￼￼- (CGPoint)locationInView:(UIView *)view;
//  该⽅方法记录了前⼀一个坐标值,函数返回也是⼀一个CGPoint类型的值, 表⽰示触摸在 view这个视图上的位置,这⾥里返回的位置是针对view的坐标系的
- (CGPoint)previousLocationInView:(UIView *)view;
```

**事件的传递**

- 从事件发生到其处理的对象,传递要经过特殊的一段过程。
- 当用户点击设备屏 幕时,iOS捕捉到一系列的触摸,将其打包到UIEvent对象中并放置到应用程序 活动事件队列中。
- UIApplication对象从事件队列中取出最前面的事件并将其分发
- 通常,其发送事件给应用程序的主窗口——UIWindow实例,再由窗口对 象发送事件给”第一响应者 (触摸的视图)”处理

**事件响应者链的基本概念**

- 响应者对象是一个能接收并处理事件的对象。
- UIResponser是所有响应者对 象的基类。
- 该基类定义了一系列编程接口,不但为事件处理进行服务而且还提 供了通用的响应行为处理。
- UIApplication, UIView(包括UIWindow),UIViewController都直接或间接的继承自UIResponser,所有的这些类的实例都是响应者对象。

**事件响应者链**

- 当用户与视图交互时,将会 消息传递给视图控制器,如果 不存在控制器,传递给父视图
- 如果不处理该消息,则继续 将消息向上传递
- 最上层的视图如果也不处 理,将事件交予Window对象
- 最后交由UIApplication实 例,如果不处理,丢弃事件

**手势识别器UIGestureRecognizer*

- UIGestureRecognizer类,用于检测、识别用户使用设备时所用的手势。
- 它是一 个抽象类,定义了所有手势的基本行为。
- 以下是UIGestureRecognizer子类,用于处理具体的用户手势行为
	- UITapGestureRecognizer(轻击)
	- UIPinchGestureRecognizer(捏合)
	- UIPanGestureRecognizer(平移)
	- UISwipeGestureRecognizer(轻扫)
	- UIRotationGestureRecognizer(旋转)
	- UILongPressGestureRecognizer(长按)

**Demo**

```
// 一只手单击
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
initWithTarget:self action:@selector(singleGesture:)];
[self.view addGestureRecognizer:singleTap];
[singleTap release];

// 一只手双击
￼￼UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]
initWithTarget:self action:@selector(doubleGesture:)];
doubleTap.numberOfTapsRequired = 2;
[self.view addGestureRecognizer:doubleTap];
[doubleTap release];

// 区别两种手势(一只手单击、双击)
[singleTap requireGestureRecognizerToFail:doubleTap];
```

￼￼**平移⼿手势(滑动)**

```
UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
[self.view addGestureRecognizer:panGesture];
[panGesture release];
￼￼- (void)pan:(UIPanGestureRecognizer *)_pan
{
    CGPoint point = [_pan locationInView:self.view];
    tempView.center = point;
}
```

**⻓长按⼿手势**

```
UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
longPressGesture.minimumPressDuration = 3;
[self.view addGestureRecognizer:longPressGesture]; [longPressGesture release];
￼￼- (void)longPress:(UILongPressGestureRecognizer *)_longPress
{
    NSLog(@"long press : %u", [_longPress state]);
}
```

**旋转⼿手势**

```
UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(rotation:)];
[self.view addGestureRecognizer:rotationGesture]; [rotationGesture release];
￼￼- (void)rotation:(UIRotationGestureRecognizer *)_rotation
{
    float degress = _rotation.rotation*(180/M_PI);
    tempView.transform = CGAffineTransformRotate(tempView.transform, degress/1000);
}
```

**捏合手势**

```
static float scale = 0;
- (void)pinch:(UIPinchGestureRecognizer *)_pinch
{
    if (_pinch.state == UIGestureRecognizerStateEnded) {
        return;
    }
    
    if (scale == 0) {
        if (_pinch.scale > 0) {
            NSLog(@"放⼤大1");
        } else {
            NSLog(@"缩⼩小1");
        }
    } else {
        if (scale - _pinch.scale < 0) {
            NSLog(@"放⼤大2");
        } else {
            NSLog(@"缩⼩小2");
        }
    }
    scale = _pinch.scale;
}
```

- - -

<h3 id="UIPickerView"> UIPickerView(选择器视图) </h3>

￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼**UIPickerView的使用**

- UIPickerView控件生成的表格可以提供滚动的轮盘,如下图,它有两个或多个轮盘 (Component)。
- 这些表格表面上类似于标准的UITableView控件,但是它们使用的数据和委托协议有 细微的差别。
- UIPickerView的宽度和高度是固定的,纵向是320x216,横向480x162

**￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼UIPickerView常用方法**

```
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼//是否启⽤用选择启⽰示器,就是⼀一个蓝⾊色的条 @property(nonatomic)BOOL showsSelectionIndicator;
//获取指定列的⾏行数
- (NSInteger)numberOfRowsInComponent:(NSInteger)component;
//刷新所有列
- (void)reloadAllComponents;
//刷新指定的列
- (void)reloadComponent:(NSInteger)component;
//选择⼀一⾏行
- (void)selectRow:(NSInteger)row
    inComponent:(NSInteger)component
       animated:(BOOL)animated;
//获取某列选择的⾏行数
- (NSInteger)selectedRowInComponent:(NSInteger)component;
```

￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼**UIPickerView委托方法**

```
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼//返回列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//返回每⼀一列对应的⾏行数
- (NSInteger)pickerView:(UIPickerView *)pickerView
  numberOfRowsInComponent:(NSInteger)component
//返回显⽰示的⽂文本
- (NSString *)pickerView:(UIPickerView *)pickerView
           titleForRow:(NSInteger)row
          forComponent:(NSInteger)component
//选中某⼀一⾏行的事件
- (void)pickerView:(UIPickerView *)pickerView
    didSelectRow:(NSInteger)row
     inComponent:(NSInteger)component
```

**UIDatePicker常用属性**

```
￼￼//设置初始化显⽰示的date⽇日期。
@property(nonatomic,retain) NSDate *date; //设置最⼩小⽇日期
@property(nonatomic,retain) NSDate *minimumDate; //设置最⼤大⽇日期
@property(nonatomic,retain) NSDate *maximumDate; //设置⽇日期的显⽰示样式
@property(nonatomic) UIDatePickerMode datePickerMode; //分钟间隔值
@property(nonatomic)NSInteger minuteInterval;
```

**datePickerMode 四种显示模式**

- UIDatePickerModeTime 显示时间
- UIDatePickerModeDate 显示日期
- UIDatePickerModeDateAndTime 显示日期和时间
- UIDatePickerModeCountDownTimer 显示时间

**￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼图像加载**

- 本地加载,程序包和沙盒中的图像读取的方式是一样的,都是通过文件路径读取,不同 是路径不一样

```
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼1.获取项⺫⽬目包路径
//程序包根路径
NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
//图像路径
NSString *path = [resourcePath stringByAppendingPathComponent:@"icon.png"];
￼￼2.获取沙盒路径
//沙盒下的Documents⺫⽬目录
NSString *path = [NSHomeDirectory()
                   stringByAppendingPathComponent:@"Documents/icon.png"];
￼￼//通过路径对应的图⽚片⽂文件
UIImage *image = [UIImage imageWithContentsOfFile:path];
```

- ￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼网络加载

```
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/img/520.gif"]; //⺴⽹网络获取数据
NSData *data = [NSData dataWithContentsOfURL:url];
//将NSData转成UIImage
UIImage *image = [UIImage imageWithData:data];
￼￼￼// UIImage转成NSData //compressionQuality图像的范围为0.0(最低品质)到1.0(最⾼高品质)的压缩系数 NSData *data = UIImageJPEGRepresentation(UIImage *image, CGFloat compressionQuality);
//将NSData写⼊入⽂文件⺫⽬目录
[data writeToFile:path atomically:YES];
```

- ￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼相册访问
	- 相册资源访问通过UIImagePickerController类来读取。UIImagePickerController类继承自UINavigationController,是个独立的导航控制 器,一般使用模态窗口的方式弹出
	- ￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼sourceType属性可指定选取器要选取的资源类型,有如下3种类型:
	- 所有同步到iPhone的图像以及包括⽤用户拍摄的图⽚片在内的任何相册 UIImagePickerControllerSourceTypePhotoLibrary //仅含相册 		`UIImagePickerControllerSourceTypeSavedPhotosAlbum //允许⽤用户使⽤用iPhone内置的摄像头的拍照 `
	- UIImagePickerControllerSourceTypeCamera
	  ￼￼	`设置图像编辑,允许选取器框定和拉伸图像。默认为NO。 @property(nonatomic)BOOL allowsEditing`

```
// ￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼UIImagePickerController委托, 图像选取必须实现UIImagePickerControllerDelegate协议,以监听选择的资源。
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼// 选取完成后调⽤用,3.x系统以后调⽤用此⽅方法,上⾯面的委托⽅方法会忽略掉。 
// info包含了许多数据,通过UIImagePickerControllerEditedImage读取编辑后的图像通过UIImagePickerControllerOriginalImage 读取源图像
- (void)imagePickerController:(UIImagePickerController *)picker
  didFinishPickingMediaWithInfo:(NSDictionary *)info;
// 取消选取
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
```

￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼**调用摄像头**

UIImagePickerController的 sourceType属性设置为 UIImagePickerControllerSourceTypeCamera 即可调用摄像头拍照。拍完后通过UIImageWriteToSavedPhotosAlbum将照片保存至相册

```
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; //将图⽚片保存⾄至相册
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFninishSavingWithError:contextInfo:), nil);
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)image:(UIImage *)image didFninishSavingWithError:(NSError *)error
                                           contextInfo:(void *)contextInfo {
                                               if (!error) {
                                                   NSLog(@"保存成功");
                                               }
}
```

- - - 

<h3 id="AV"> AV(多媒体) </h3>

**iOS系统中的音频播放方式**

- AVAudioPlayer、AVPlayer、系统声音、音频队列 ·AVAudioPlayer
- 使用简单方便,但只能播放本地音频,不支持流媒体播放 ·AVPlayer
- iOS4.0以后,可以使用AVPlayer播放本地音频和支持流媒体播放,但提供接口较 少,处理音频不够灵活
- 音频队列
- 音频队列主要处理流媒体播放,提供了强大且灵活的API接口(C函数的接口),但 处理起来也较为复杂

**AVAUDIOPLAYER的使用**

- 引用框架
- 使用AVAudioPlayer或AVPlayer需要引用AVFoundation类库

```
NSBundle *bundle = [NSBundle mainBundle];
// ⾳音频⽂文件路径
NSString *urlString = [bundle pathForResource:@"tell me why" ofType:@"mp3"];
// 初始化本地的url
NSURL *url = [[NSURL alloc] initFileURLWithPath:urlString]; // 初始化⾳音频对象
AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
// 分配播放所需的资源,并将其加⼊入内部播放队列 [player prepareToPlay];
// 播放
if ([player play]){
    NSLog(@"正在播放");
}
```

**AVAudioPlayer代理方法**

```
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag {
    // 播放结束时执⾏行的动作
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer*)player error: (NSError *)error {
    // 解码错误执⾏行的动作
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer*)player {
    // 处理中断的代码
}
    
- (void)audioPlayerEndInterruption:(AVAudioPlayer*)player {
    // 处理中断结束的代码
}
```

**AVPLAYER的使用**

```
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼NSString *urlString = @"http://zhangmenshiting2.baidu.com/data2/music/ 1736524/1736524.mp3? xcode=4c984fdae3c1bad69e17a9d95288ce1e&mid=0.33322142677174";
// 初始化远程url
NSURL *url = [NSURL URLWithString:urlString]; // 初始化播放器
AVPlayer *player = [[AVPlayer alloc] initWithURL:url]; // 播放
[player play];
```

**播放系统声音**

格式为:caf/wav/aiff格式,且时长小于30s

```
NSBundle *bundle = [NSBundle mainBundle];
NSString *path = [bundle pathForResource:@"44th Street Medium" ofType:@"caf"];
// 初始化本地⽂文件url
NSURL *url = [NSURL fileURLWithPath:path];
UInt32 soundID;
// 将URL所在的⾳音频⽂文件注册为系统声⾳音,soundID⾳音频ID标⽰示该⾳音频
AudioServicesCreateSystemSoundID((CFURLRef)url, &soundID);
// 播放⾳音频
AudioServicesPlaySystemSound(soundID);
￼￼// 播放系统震动
AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
```

**后台播放任务**

- 当你的应用程序在后台时(被挂起), 在iOS系统(4.0之后)允许你做三件事:播放音频(audio),位置信息以及voip(网络电话),播放音频
- 在plist文件中添加“UIBackgroundMode”属性,值为“audio” , 设置AVAudioSession模式,播放音频时,通常将属性设置为AVAudioSessionCategoryPlayback(音频播放之前设置)

```
NSError *error;
AVAudioSession *audionSession = [AVAudioSession sharedInstance];
[audionSession setCategory:AVAudioSessionCategoryPlayback
error:&error];
```

**自定义后台任务**

- demo1 

```
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼- (void)applicationDidEnterBackground:(UIApplication *)application
{
    UIApplication *application = [UIApplication sharedApplication];
    //启动⼀一个后台任务
    bgTask = [application beginBackgroundTaskWithExpirationHandler:^(void) {
        //当该任务超时回调该block块
        //结束该任务
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
}
```

- demo2

```
// 程序进⼊入后台调⽤用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 开启⼀一个后台任务,避免程序被挂起
    bgTask = [application beginBackgroundTaskWithExpirationHandler:^ {
                [application endBackgroundTask:bgTask];
                bgTask = UIBackgroundTaskInvalid;
            }];
    // 开启新的线程
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^ {
        // 开启定时器监听后台运⾏行时间
        [NSTimer scheduledTimerWithTimeInterval:1 target:self repeats:YES];
  }];
}
selector:@selector(timerAction) userInfo:self[[NSRunLoop currentRunLoop] run];

￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼- (void)timerAction {
    _count++;
    NSLog(@"%d",__count);
    //因为⼀一个任务只能保持600秒,所以当500秒的时,新开⼀一个新的任务 if (__count % 500 == 0) {
      UIApplication *application = [UIApplication sharedApplication];
      bgTask = [application beginBackgroundTaskWithExpirationHandler:^(void) {
          [application endBackgroundTask:bgTask];
          bgTask = UIBackgroundTaskInvalid;
      }];
}
```

**iOS视频播放**

- iOS内置了视频播放器,我们可以通过使用MPMoviePlayerController或者 MPMoviePlayerViewController类(视图控制器)来播放视频(含流媒体视频播 放),两者使用也较为简单
- 需引入“MediaPlayer.framewrok”库
- MPMoviePlayerController播放器可以任意修改播放页面尺寸
- MPMoviePlayerViewController类是一个特殊的视图控制器类,它包含了一个播 放器(MPMoviePlayerController)

- demo1
 
```
MPMoviePlayerController的使用
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼// 初始化url
NSURL *url = [NSURL URLWithString:@"http://tv.flytv.com.cn/seg/ 17.m3u8"];
// 初始化视频播放
MPMoviePlayerController *moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
// 将视频播放视图加⼊入
[self.view addSubview:moviePlayer.view];
moviePlayer.view.frame = self.view.bounds;
// 开始播放
[moviePlayer play];
```

- demo2

```
// 初始化url
NSURL *url = [NSURL URLWithString:@"http://tv.flytv.com.cn/seg/ 17.m3u8"];
// 初始化播放器控制器
MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc]
initWithContentURL:url];
// 模态窗⼝口弹出播放器
[self presentModalViewController:moviePlayer animated:YES]; [moviePlayer release];
```

**￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼视频播放常用的通知**

- 视频播放结束的通知 MPMoviePlayerPlaybackDidFinishNotification
- 视频播放状态改变的通知 MPMoviePlayerPlaybackStateDidChangeNotification
- 视频加载状态改变的通知 MPMoviePlayerLoadStateDidChangeNotification

- - -
