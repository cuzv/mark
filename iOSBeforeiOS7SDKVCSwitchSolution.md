# iOS 7 SDK之前的VC切换解决方案

[Source](http://www.cnblogs.com/EnamelPot/p/3465561.html "Permalink to UIViewController切换（ios5：transitionFromViewController） - EnamelPot - 博客园")

* * *

    @property(nonatomic,readonly) NSArray *childViewControllers

    - (void)addChildViewController:(UIViewController *)childController
    - (void) removeFromParentViewController
    - (void)transitionFromViewController：：：：：：
    - (void)willMoveToParentViewController:(UIViewController *)parent
    - (void)didMoveToParentViewController:(UIViewController *)parent

childViewControllers：一个数组，里面是子vc。&nbsp;

addChildViewController:向视图控制器容器中添加子视图控制器

removeFromParentViewController：从父视图控制器中删除

transitionFromViewController：交换两个子视图控制器的位置（由于添加的顺序不同，所以子试图控制器在父视图控制器中存在层次关系）

  * fromViewController：当前显示的子试图控制器，将被替换为非显示状态
  * toViewController：将要显示的子视图控制器
  * duration：交换动画持续的时间，单位秒
  * options：动画的方式
  * animations：动画Block
  * completion：完成后执行的Block

willMoveToParentViewController:当一个视图控制器从视图控制器容器中被添加或者被删除之前，该方法被调用

  * parent：父视图控制器，如果没有父视图控制器，将为nil
  * 当我们向我们的视图控制器容器中调用removeFromParentViewController方法时，必须要先调用该方法，且parent参数为nil：
  * 当我们调用addChildViewController方法时，在添加子视图控制器之前将自动调用该方法。所以，就不需要我们显示调用了。

didMoveToParentViewController:当从一个视图控制容器中添加或者移除viewController后，该方法被调用。

  * parent：父视图控制器，如果没有父视图控制器，将为nil
  * 在调用addChildViewController方法加入子视图控制器后，必须调用该方法，告诉iOS，已经完成添加（或删除）子控制器的操作。
  * removeFromParentViewController 方法会自动调用了该方法，所以，删除子控制器后，不需要在显示的调用该方法了。

小结一下：

*（add + did）\[被加入的子视图控制器 didMoveToParentViewController:父视图控制器\];
*（will+transition+did）\[子视图控制器 willMoveToParentViewController:nil\] transition \[子视图控制器 didMoveToParentViewController:父视图控制器\]；
*（will+remove）\[被删除的子试图控制器 willMoveToParentViewController:nil\];

1. 在appDelegate中设置rootviewcontroller为mainVC

	`self.window.rootViewController = [[mainViewController alloc]initWithNibName:nil bundle:nil];`

2. 在mainVC中设置2个按钮

```
    UIButton *fristButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 160, 40)];
    fristButton.backgroundColor = [UIColor yellowColor];
    [fristButton addTarget:self action:@selector(toShowTheFristViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fristButton];

    UIButton *secondButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 20, 160, 40)];
    secondButton.backgroundColor = [UIColor blueColor];
    [secondButton addTarget:self action:@selector(toShowTheSecondViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondButton];
```

3. 新建所有的子vc，addChildViewController进mainVC，new一个UIView，在其中addSubview想要展示的第一个vc的view

```
    FristViewController *fVC=[[FristViewController alloc]initWithNibName:nil bundle:nil];
    [self addChildViewController:fVC];
    SecondViewController *sVC=[[SecondViewController alloc]initWithNibName:nil bundle:nil];
    [self addChildViewController:sVC];

    [mainView addSubview:fVC.view];
```

4. 添加2个按钮方法

```
    -(void)toShowTheFristViewController
    {
       NSLog(@"显示第一个vc");
       [[self.childViewControllers objectAtIndex:1] willMoveToParentViewController:nil];
       [self transitionFromViewController:[self.childViewControllers objectAtIndex:0]
               toViewController:[self.childViewControllers objectAtIndex:1]
               duration:0.3
               options:UIViewAnimationOptionTransitionFlipFromLeft
               animations:^{}
               completion:^(BOOL finished) {
               }];
       [[self.childViewControllers objectAtIndex:0] didMoveToParentViewController:self];
    }
    -(void)toShowTheSecondViewController
    {
       NSLog(@"显示第二个vc");
       [[self.childViewControllers objectAtIndex:0] willMoveToParentViewController:nil];
       [self transitionFromViewController:[self.childViewControllers objectAtIndex:1]
                         toViewController:[self.childViewControllers objectAtIndex:0]
                                 duration:0.3
                                  options:UIViewAnimationOptionTransitionFlipFromLeft
                               animations:^{}
                               completion:^(BOOL finished) {
                               }];
       [[self.childViewControllers objectAtIndex:1]didMoveToParentViewController:self];
    }
 ```
 
 * * *
 
 **oneV's Den demo**
 
 ```
 //ContainerVC.m

 [self addChildViewController:toVC];
 [fromVC willMoveToParentViewController:nil];
 [self.view addSubview:toVC.view];

 __weak id weakSelf = self;
 [self transitionFromViewController:fromVC
                   toViewController:toVC duration:0.3
                            options:UIViewAnimationOptionTransitionCrossDissolve
                         animations:^{}
                         completion:^(BOOL finished) {
     [fromVC.view removeFromSuperView];
     [fromVC removeFromParentViewController];
     [toVC didMoveToParentViewController:weakSelf];
 }];
 ```
 
 **animation中可以添加动画**
 
```
CATransition *animation = [CATransition animation];
animation.duration = 0.5;
animation.type = kCATransitionReveal;
animation.subtype =kCATransitionFromLeft;
[rootVC.view.layer addAnimation:animation forKey:@"animate"];
```