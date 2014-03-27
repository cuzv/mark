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

