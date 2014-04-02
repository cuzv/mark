# iOS7中的ViewController切换

via:[OneV'S Den](#http://onevcat.com/2013/10/vc-transition-in-ios7/)

* * *

Navigation

- [自定义动画切换的相关的主要API](#自定义动画切换的相关的主要API)
- [Demo](#Demo)
- [手势驱动的百分比切换](#手势驱动的百分比切换)

* *  *

## 自定义动画切换的相关的主要API

在深入之前，我们先来看看新SDK中有关这部分内容的相关接口以及它们的关系和典型用法。这几个接口和类的名字都比较相似，但是还是能比较好的描述出各自的职能的，一开始的话可能比较迷惑，但是当自己动手实现一两个例子之后，它们之间的关系就会逐渐明晰起来。（相关的内容都定义在UIKit的UIViewControllerTransitioning.h中了）

**@protocol UIViewControllerContextTransitioning**

这个接口用来提供切换上下文给开发者使用，包含了从哪个VC到哪个VC等各类信息，一般不需要开发者自己实现。具体来说，iOS7的自定义切换目的之一就是切换相关代码解耦，在进行VC切换时，做切换效果实现的时候必须要需要切换前后VC的一些信息，系统在新加入的API的比较的地方都会提供一个实现了该接口的对象，以供我们使用。

对于切换的动画实现来说（这里先介绍简单的动画，在后面我会再引入手势驱动的动画），这个接口中最重要的方法有：

* -(UIView *)containerView; VC切换所发生的view容器，开发者应该将切出的view移除，将切入的view加入到该view容器中。
* -(UIViewController )viewControllerForKey:(NSString )key; 提供一个key，返回对应的VC。现在的SDK中key的选择只有UITransitionContextFromViewControllerKey和UITransitionContextToViewControllerKey两种，分别表示将要切出和切入的VC。
* -(CGRect)initialFrameForViewController:(UIViewController *)vc; 某个VC的初始位置，可以用来做动画的计算。
* -(CGRect)finalFrameForViewController:(UIViewController *)vc; 与上面的方法对应，得到切换结束时某个VC应在的frame。
* -(void)completeTransition:(BOOL)didComplete; 向这个context报告切换已经完成。

**@protocol UIViewControllerAnimatedTransitioning**

这个接口负责切换的具体内容，也即“切换中应该发生什么”。开发者在做自定义切换效果时大部分代码会是用来实现这个接口。它只有两个方法需要我们实现：

* -(NSTimeInterval)transitionDuration:(id < UIViewControllerContextTransitioning >)transitionContext; 系统给出一个切换上下文，我们根据上下文环境返回这个切换所需要的花费时间（一般就返回动画的时间就好了，SDK会用这个时间来在百分比驱动的切换中进行帧的计算，后面再详细展开）。
* -(void)animateTransition:(id < UIViewControllerContextTransitioning >)transitionContext; 在进行切换的时候将调用该方法，我们对于切换时的UIView的设置和动画都在这个方法中完成。

**@protocol UIViewControllerTransitioningDelegate**

这个接口的作用比较简单单一，在需要VC切换的时候系统会像实现了这个接口的对象询问是否需要使用自定义的切换效果。这个接口共有四个类似的方法：

* -(id< UIViewControllerAnimatedTransitioning >)animationControllerForPresentedController:(UIViewController )presented presentingController:(UIViewController )presenting sourceController:(UIViewController *)source;
* -(id< UIViewControllerAnimatedTransitioning >)animationControllerForDismissedController:(UIViewController *)dismissed;
* -(id< UIViewControllerInteractiveTransitioning >)interactionControllerForPresentation:(id < UIViewControllerAnimatedTransitioning >)animator;
* -(id< UIViewControllerInteractiveTransitioning >)interactionControllerForDismissal:(id < UIViewControllerAnimatedTransitioning >)animator;

前两个方法是针对动画切换的，我们需要分别在呈现VC和解散VC时，给出一个实现了UIViewControllerAnimatedTransitioning接口的对象（其中包含切换时长和如何切换）

* * *

## Demo

1. 先定义一个ModalVC，以及相应的protocal和delegate方法：

```
//ModalViewController.h

@class ModalViewController;
@protocol ModalViewControllerDelegate <NSObject>

-(void) modalViewControllerDidClickedDismissButton:(ModalViewController *)viewController;

@end

@interface ModalViewController : UIViewController
@property (nonatomic, weak) id<ModalViewControllerDelegate> delegate;
@end

//ModalViewController.m
- (void)viewDidLoad
{
    [super viewDidLoad];
  // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [button setTitle:@"Dismiss me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void) buttonClicked:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(modalViewControllerDidClickedDismissButton:)]) {
        [self.delegate modalViewControllerDidClickedDismissButton:self];
    }
}
```

这个是很标准的modalViewController的实现方式了。需要多嘴一句的是，在实际使用中有的同学喜欢在-buttonClicked:中直接给self发送dismissViewController的相关方法。在现在的SDK中，如果当前的VC是被显示的话，这个消息会被直接转发到显示它的VC去。但是这并不是一个好的实现，违反了程序设计的哲学，也很容易掉到坑里，具体案例可以参看这篇文章的评论。
所以我们用标准的方式来呈现和解散这个VC：


```
//MainViewController.m

- (void)viewDidLoad
{
    [super viewDidLoad];
  // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [button setTitle:@"Click me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void) buttonClicked:(id)sender
{
    ModalViewController *mvc =  [[ModalViewController alloc] init];
    mvc.delegate = self;
    [self presentViewController:mvc animated:YES completion:nil];
}

-(void)modalViewControllerDidClickedDismissButton:(ModalViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
```

测试一下，没问题，然后我们可以开始实现自定义的切换效果了。首先我们需要一个实现了UIViewControllerAnimatedTransitioning的对象..嗯，新建一个类来实现吧，比如BouncePresentAnimation：

```
//BouncePresentAnimation.h
@interface BouncePresentAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@end

//BouncePresentAnimation.m
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 1. Get controllers from transition context
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    // 2. Set init frame for toVC
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);

    // 3. Add toVC's view to containerView
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];

    // 4. Do animate now
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         toVC.view.frame = finalFrame;
                     } completion:^(BOOL finished) {
                         // 5. Tell context that we completed.
                         [transitionContext completeTransition:YES];
                     }];
}
```

解释一下这个实现：

1. 我们首先需要得到参与切换的两个ViewController的信息，使用context的方法拿到它们的参照；
2. 对于要呈现的VC，我们希望它从屏幕下方出现，因此将初始位置设置到屏幕下边缘；
3. 将view添加到containerView中；
4. 开始动画。这里的动画时间长度和切换时间长度一致，都为0.8s。usingSpringWithDamping的UIView动画API是iOS7新加入的，描述了一个模拟弹簧动作的动画曲线，我们在这里只做使用，更多信息可以参看相关文档；（顺便多说一句，iOS7中对UIView动画添加了一个很方便的Category，UIViewKeyframeAnimations。使用其中方法可以为UIView动画添加关键帧动画）
5. 在动画结束后我们必须向context报告VC切换完成，是否成功（在这里的动画切换中，没有失败的可能性，因此直接pass一个YES过去）。系统在接收到这个消息后，将对VC状态进行维护。
6. 接下来我们实现一个UIViewControllerTransitioningDelegate，应该就能让它工作了。简单来说，一个比较好的地方是直接在MainViewController中实现这个接口。在MainVC中声明实现这个接口，然后加入或变更为如下代码：

```
@interface MainViewController ()<ModalViewControllerDelegate, UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) BouncePresentAnimation *presentAnimation;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _presentAnimation = [BouncePresentAnimation new];
    }
    return self;
}

-(void) buttonClicked:(id)sender
{
    //...
    mvc.transitioningDelegate = self;
    //...
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.presentAnimation;
}
```

* * * 

## 手势驱动的百分比切换

首先是UIViewControllerContextTransitioning，刚才提到这个是系统提供的VC切换上下文，如果您深入看了它的头文件描述的话，应该会发现其中有三个关于InteractiveTransition的方法，正是用来处理交互式切换的。但是在初级的实际使用中我们其实可以不太理会它们，而是使用iOS 7 SDK已经给我们准备好的一个现成转为交互式切换而新加的类：UIPercentDrivenInteractiveTransition

**UIPercentDrivenInteractiveTransition是什么**

这是一个实现了UIViewControllerInteractiveTransitioning接口的类，为我们预先实现和提供了一系列便利的方法，可以用一个百分比来控制交互式切换的过程。这样使用这个类（一般是其子类）的话就会非常方便。我们在手势识别中只需要告诉这个类的实例当前的状态百分比如何，系统便根据这个百分比和我们之前设定的迁移方式为我们计算当前应该的UI渲染，十分方便。具体的几个重要方法：

* -(void)updateInteractiveTransition:(CGFloat)percentComplete 更新百分比，一般通过手势识别的长度之类的来计算一个值，然后进行更新。之后的例子里会看到详细的用法
* -(void)cancelInteractiveTransition 报告交互取消，返回切换前的状态
* –(void)finishInteractiveTransition 报告交互完成，更新到切换后的状态

**@protocol UIViewControllerInteractiveTransitioning**

UIPercentDrivenInteractiveTransition只是实现了这个接口的一个类。为了实现交互式切换的功能，我们需要实现这个接口。
还有就是上面提到过的UIViewControllerTransitioningDelegate中的返回Interactive实现对象的方法，我们同样会在交互式切换中用到它们。

**继续Demo**

用一个向上划动的手势来吧之前呈现的ModalViewController给dismiss掉～当然是交互式的切换，可以半途取消的那种。

首先新建一个类，继承自UIPercentDrivenInteractiveTransition

```
//SwipeUpInteractiveTransition.h
@interface SwipeUpInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;

- (void)wireToViewController:(UIViewController*)viewController;

@end

//SwipeUpInteractiveTransition.m
@interface SwipeUpInteractiveTransition()
@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, strong) UIViewController *presentingVC;
@end

@implementation SwipeUpInteractiveTransition
-(void)wireToViewController:(UIViewController *)viewController
{
    self.presentingVC = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView*)view {
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

-(CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            // 1. Mark the interacting flag. Used when supplying it in delegate.
            self.interacting = YES;
            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged: {
            // 2. Calculate the percentage of guesture
            CGFloat fraction = translation.y / 400.0;
            //Limit it between 0 and 1
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            self.shouldComplete = (fraction > 0.5);

            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            // 3. Gesture over. Check if the transition should happen or not
            self.interacting = NO;
            if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

@end
```

解释：

1. 我们设定了一个BOOL变量来表示是否处于切换过程中。这个布尔值将在监测到手势开始时被设置，我们之后会在调用返回这个InteractiveTransition的时候用到。
2. 计算百分比，我们设定了向下划动400像素或以上为100%，每次手势状态变化时根据当前手势位置计算新的百分比，结果被限制在0～1之间。然后更新InteractiveTransition的百分数。
3. 手势结束时，把正在切换的标设置回NO，然后进行判断。在2中我们设定了手势距离超过设定一半就认为应该结束手势，否则就应该返回原来状态。在这里使用其进行判断，已决定这次transition是否应该结束。

接下来我们需要添加一个向下移动的UIView动画，用来表现dismiss。这个十分简单，和BouncePresentAnimation很相似，写一个NormalDismissAnimation的实现了UIViewControllerAnimatedTransitioning接口的类就可以了，本文里略过不写了，感兴趣的童鞋可以自行查看源码。
最后调整MainViewController的内容，主要修改点有三个地方：

```
//MainViewController.m
@interface MainViewController ()<ModalViewControllerDelegate,UIViewControllerTransitioningDelegate>
//...
// 1. Add dismiss animation and transition controller
@property (nonatomic, strong) NormalDismissAnimation *dismissAnimation;
@property (nonatomic, strong) SwipeUpInteractiveTransition *transitionController;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  //...
        _dismissAnimation = [NormalDismissAnimation new];
        _transitionController = [SwipeUpInteractiveTransition new];
  //...
}

-(void) buttonClicked:(id)sender
{
  //...
  // 2. Bind current VC to transition controller.
    [self.transitionController wireToViewController:mvc];
  //...
}

// 3. Implement the methods to supply proper objects.
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismissAnimation;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.transitionController.interacting ? self.transitionController : nil;
}
```

解释：

1. 在其中添加dismiss时候的动画和交互切换Controller
2. 在初始化modalVC的时候为交互切换的Controller绑定VC
3. 为UIViewControllerTransitioningDelegate实现dismiss时候的委托方法，包括返回对应的动画以及交互切换Controller