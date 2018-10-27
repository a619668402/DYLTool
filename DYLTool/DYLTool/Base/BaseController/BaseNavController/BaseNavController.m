//
//  BaseNavController.m
//  DYLTool
//
//  Created by sky on 2018/6/28.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseNavController.h"
#import "TestChangeNavController.h"

@interface BaseNavController ()<UINavigationControllerDelegate>

/// 导航栏分割线
@property (nonatomic, weak, readwrite) UIImageView *navigationBottomLine;

@end

@implementation BaseNavController

// initialize的自然调用是在第一次主动使用当前类的时候
// 在initialize方法收到调用时，运行环境基本健全
// initialize的运行过程中是能保证线程安全的
// 不需要调用 super 方法,子类在调用时,父类已经调用过
+ (void)initialize {
    // 设置 UINavigationBar 主题
    [self _setupNavigationBarTheme];
    // 设置 UIBarButtonItem 主题
    [self _setupBarButtonItemTheme];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    // 初始化
    [self _setup];
}

#pragma mark ************* override Method Start *************
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果在push的不是栈底控制器(最先push进来的那个控制器)
    if (self.viewControllers.count > 0) {
        // 隐藏底部tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        /* 使用系统的返回按钮(在BaseViewController中设置)
        // 设置左侧按钮标题
        NSString *title = @"返回";
        // 1. 取出当前控制器的 title
        title = [[self topViewController] navigationItem].title ?: @"返回";
        // 2. 判断要被 Push 的控制器 是否也是 BaseViewController
        if ([viewController isKindOfClass:[BaseViewController class]]) {
            BaseViewModel *viewModel = [(BaseViewController *)viewController viewModel];
            // 3. 查看 viewModel 的 backTitle 是否有值
            title = viewModel.backTitle ?: title;
        }
        /*
        UIBarButtonItem *backItem = [UIBarButtonItem yl_backItemWithImage:@"barbuttonicon_back_15x30" target:self action:@selector(_back)];
        // 4. 设置导航栏左右按钮,统一管理
        viewController.navigationItem.leftBarButtonItem = backItem;
        */
    }
    [super pushViewController:viewController animated:animated];
}

- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden {
    return self.topViewController.prefersStatusBarHidden;
}

#pragma mark ************* override Method End  *************

#pragma mark ************* NavigationControllerDelegate Start *************
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isHideNav = [viewController isKindOfClass:[TestChangeNavController class]];
    KLog(@"----isHideNav = %d", isHideNav);
    [self setNavigationBarHidden:isHideNav animated:animated];
}
#pragma mark ************* NavigationControllerDelegate End   *************

#pragma mark ************* public Method Start *************
- (void)showNavigationBottomLine {
    self.navigationBottomLine.hidden = NO;
}

- (void)hideNavigationBottomLine {
    self.navigationBottomLine.hidden = YES;
}
#pragma mark ************* public Method End  *************

#pragma mark ************* private Method Start *************
- (void)_back {
    [self popViewControllerAnimated:YES];
}

- (void)_setup {
    [self _setupNavigationBarBottomLine];
    // 添加边缘滑动手势
    id target = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (UIImageView *)_findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subView in view.subviews) {
        UIImageView *imageView = [self _findHairlineImageViewUnder:subView];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
#pragma mark ----- 设置导航栏的分割线 -----
- (void)_setupNavigationBarBottomLine {
    // 隐藏系统的导航栏分割线
    UIImageView *navigationBarBottomLine = [self _findHairlineImageViewUnder:self.navigationBar];
    navigationBarBottomLine.hidden = YES;
    
    // 添加自己的分割线
    CGFloat navSystemLineH = 0.5f;
    UIImageView *navSystemLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationBar.yl_height - navSystemLineH, KScreenWidth, navSystemLineH)];
    navSystemLine.backgroundColor = rgb(223.0f, 223.0f, 221.0f);
    [self.navigationBar addSubview:navSystemLine];
    self.navigationBottomLine = navSystemLine;
}
#pragma mark ----- 设置导航栏样式 -----
+ (void)_setupNavigationBarTheme {
    UINavigationBar *appearance = [UINavigationBar appearance];
    // 设置背景 (必须设置为透明,不然布局有问题, iOS8 以下会崩溃 在_setup 设置 self.navigationBar.translucent = YES;)
    [appearance setTranslucent:YES]; // 必须设置为YES
    // 设置导航栏样式
    [appearance setBarStyle:UIBarStyleDefault];
    // 设置导航栏文字按钮渲染色
    [appearance setTintColor:[UIColor whiteColor]];
     // 设置导航栏背景渲染色
    CGFloat rgb = 0.1f;
    [appearance setBarTintColor:rgbA(rgb, rgb, rgb, 0.65f)];
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = N_18;
    textAttrs[NSForegroundColorAttributeName] = white_color;
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    textAttrs[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:textAttrs];
    
    // 去掉导航栏阴影图片
    [appearance setShadowImage:[UIImage new]];
}

// 设置 UIBarButtonItem 主题
+ (void)_setupBarButtonItemTheme {
    // 通过appearance对象能修改整个项目中所有的UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    // 设置文字属性
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = white_color;
    textAttrs[NSFontAttributeName] = N_16;
    NSShadow *shadow = [NSShadow new];
    shadow.shadowOffset = CGSizeZero;
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置不可用状态的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}
#pragma mark ************* private Method End *************

@end
