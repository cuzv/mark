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

