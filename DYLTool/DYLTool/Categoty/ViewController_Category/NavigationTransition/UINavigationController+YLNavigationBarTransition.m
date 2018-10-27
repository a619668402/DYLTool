//
//  UINavigationController+YLNavigationBarTransition.m
//  DYLTool
//
//  Created by sky on 2018/9/26.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UINavigationController+YLNavigationBarTransition.h"
#import "UINavigationBar+YLTransition.h"

@interface BaseTransitionNavigationBar : UINavigationBar

@end

@implementation BaseTransitionNavigationBar

- (void)layoutSubviews {
    [super layoutSubviews];
    if (@available(iOS 11, *)) {
        // iOS 11 之前,自己 init 的 navigationBar,它的 backgroundView 默认会一直保持与 navigationBar 高度相等,但 iOS 11 之后自己 init 的 navigationBar.backgroundView.height 的高度默认一直是44, 所以需要兼容
        UIView *backgroundView = [self valueForKey:@"backgroundView"];
        backgroundView.frame = self.bounds;
    }
}

@end

/// 为了响应NavigationBarTransition分类功能,UIViewController需要做一些支持
/// @see UINavigationController+YLNavigationBarTransition.h
@interface UIViewController (YLNavigationBarTransition)
/// 用来模仿真的navBar,在转场过程中存在一条假的navBar
@property (nonatomic, strong, readwrite) BaseTransitionNavigationBar *transitionNavigationBar;
/// 是否要把真的navBar隐藏
@property (nonatomic, assign, readwrite) BOOL prefersNavigationBarBackgroundViewHiddlen;
/// 原始的clipsToBounds
@property (nonatomic, assign, readwrite) BOOL originClipsToBounds;
/// 原始containerView背景色
@property (nonatomic, strong, readwrite) UIColor *originContainerViewBackgroundColor;
/// 添加假的navBar
- (void)yl_addTransitionNavigationBarIfNeeded;
/// .m文件里自己赋值和使用.因为有些特殊情况下viewDidAppear之后,有可能还有调用到viewWillLayoutSubviews,导致原始的navBar隐藏,所以用这个属性做个保护.
@property (nonatomic, assign, readwrite) BOOL lockTransitionNavigationBar;

@end

@implementation UIViewController (YLNavigationBarTransition)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [self class];
        ExchangeImplementations(cls, @selector(viewWillLayoutSubviews), @selector(yl_navigationBarTransition_viewWillLayoutSubviews));
        ExchangeImplementations(cls, @selector(viewWillAppear:), @selector(yl_navigationBarTranstion_viewWillAppear:));
        ExchangeImplementations(cls, @selector(viewDidAppear:), @selector(yl_navigationBarTransition_viewDidAppear:));
        ExchangeImplementations(cls, @selector(viewDidDisappear:), @selector(yl_navigationBarTransition_viewDidDisAppear:));
    });
}

- (void)yl_navigationBarTranstion_viewWillAppear:(BOOL)animated {
    [self _renderNavigationStyleInViewController:self animated:animated];
    [self yl_navigationBarTranstion_viewWillAppear:animated];
}

- (void)yl_navigationBarTransition_viewDidAppear:(BOOL)animated {
    if (self.transitionNavigationBar) {
        [UIViewController replaceStyleForNavigationBar:self.transitionNavigationBar withNavigationBar:self.navigationController.navigationBar];
        [self removeTransitationNavigationBar];
        self.lockTransitionNavigationBar = YES;
        
        id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.transitionCoordinator;
        [transitionCoordinator containerView].backgroundColor = self.originContainerViewBackgroundColor;
        self.view.clipsToBounds = self.originClipsToBounds;
    }
    self.prefersNavigationBarBackgroundViewHiddlen = NO;
    [self yl_navigationBarTransition_viewDidAppear:animated];
}

- (void)yl_navigationBarTransition_viewDidDisAppear:(BOOL)animated {
    if (self.transitionNavigationBar) {
        [self removeTransitationNavigationBar];
        self.lockTransitionNavigationBar = NO;
        
        self.view.clipsToBounds = self.originClipsToBounds;
    }
    [self yl_navigationBarTransition_viewDidDisAppear:animated];
}

- (void)yl_navigationBarTransition_viewWillLayoutSubviews {
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.transitionCoordinator;
    UIViewController *fromViewController = [transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    
    BOOL isCurrentToViewController = (self == self.navigationController.viewControllers.lastObject && self == toViewController);
    BOOL isPushingViewController = [self.navigationController.viewControllers containsObject:fromViewController];
    
    if (isCurrentToViewController && !self.lockTransitionNavigationBar) {
        BOOL shouldCustomNavigationBarTransition = NO;
        if (!self.transitionNavigationBar) {
            if (isPushingViewController) {
                if ([toViewController canCustomNavigationBarTransitionWhenPushAppearing] || [fromViewController canCustomNavigationBarTransitionWhenPushDisappearing]) {
                    shouldCustomNavigationBarTransition = YES;
                }
            } else {
                if ([toViewController canCustomNavigationBarTransitionWhenPopAppearing] || [fromViewController canCustomNavigationBarTransitionWhenPushDisappearing]) {
                    shouldCustomNavigationBarTransition = YES;
                }
            }
            if (shouldCustomNavigationBarTransition) {
                if (self.navigationController.navigationBar.translucent) {
                    // 如果原生bar是半透明,需要给containerView加个背景色,否则有可能会看到下面的默认黑色背景色
                    toViewController.originContainerViewBackgroundColor = [transitionCoordinator containerView].backgroundColor;
                    [transitionCoordinator containerView].backgroundColor = [self containerViewBackGroundColor];
                }
                fromViewController.originClipsToBounds = fromViewController.view.clipsToBounds;
                toViewController.originClipsToBounds = toViewController.view.clipsToBounds;
                fromViewController.view.clipsToBounds = NO;
                toViewController.view.clipsToBounds = NO;
                [self yl_addTransitionNavigationBarIfNeeded];
                [self resizeTransitionNavigationBarFrame];
                self.navigationController.navigationBar.transitionNavigationBar = self.transitionNavigationBar;
                self.prefersNavigationBarBackgroundViewHiddlen = YES;
            }
        }
    }
    [self yl_navigationBarTransition_viewWillLayoutSubviews];
}

- (void)yl_addTransitionNavigationBarIfNeeded {
    if (!self.view.window || !self.navigationController.navigationBar) {
        return;
    }
    UINavigationBar *originBar = self.navigationController.navigationBar;
    BaseTransitionNavigationBar *customBar = [[BaseTransitionNavigationBar alloc] init];
    if (customBar.barStyle != originBar.barStyle) {
        customBar.barStyle = originBar.barStyle;
    }
    if (customBar.translucent != originBar.translucent) {
        customBar.translucent = originBar.translucent;
    }
    if (![customBar.barTintColor isEqual:originBar.barTintColor]) {
        customBar.barTintColor = originBar.barTintColor;
    }
    UIImage *backgroundImage = [originBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    if (backgroundImage && CGSizeEqualToSize(backgroundImage.size, CGSizeZero)) {
        // 假如这里的图片时如果[UIimage new]这种形式创建的,那么navBar会奇怪的显示为系统默认navBar的样式.不知道为什么 navController 设置自己的 navBar 为 [UIImage new] 却没事，所以这里做个保护。
        backgroundImage = [UIImage yl_imageWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
    }
    [customBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [customBar setShadowImage:originBar.shadowImage];
    
    self.transitionNavigationBar = customBar;
    [self resizeTransitionNavigationBarFrame];
    
    if (!self.navigationController.navigationBarHidden) {
        [self.view addSubview:self.transitionNavigationBar];
    }
}

- (void)removeTransitationNavigationBar {
    if (!self.transitionNavigationBar) {
        return;
    }
    [self.transitionNavigationBar removeFromSuperview];
    self.transitionNavigationBar = nil;
}

- (void)resizeTransitionNavigationBarFrame {
    if (!self.view.window) {
        return;
    }
    UIView *backgroundView = [self.navigationController.navigationBar valueForKey:@"backgroundView"];
    CGRect rect = [backgroundView.superview convertRect:backgroundView.frame toView:self.view];
    self.transitionNavigationBar.frame = rect;
}

#pragma mark ************* 工具方法 Start *************
- (void)_renderNavigationStyleInViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 针对一个container view controller 里面包含了若干个view controller,这种情况里面的view controller 也会响应这个render方法,这样就会覆盖container view contorller的设置,所以应该规避这种情况.
    if (viewController != viewController.navigationController.topViewController) {
        return;
    }
    // 以下用于控制vc的外观样式,如果这个方法有实现,则用方法的返回值,否则在看配置表对应的值是否有配置,有配置就使用配置表,没配置表就什么都不做,维持系统原样式
    if ([viewController conformsToProtocol:@protocol(BaseNavigationControllerAppearanceDelegate)]) {
        UIViewController<BaseNavigationControllerAppearanceDelegate> *vc = (UIViewController<BaseNavigationControllerAppearanceDelegate> *)viewController;
        // 显示 / 隐藏 导航栏
        if ([vc canCustomNavigationBarTransitionIfBarHiddenable]) {
            if ([vc hideNavigationBarWhenTransition]) {
                if (!viewController.navigationController.isNavigationBarHidden) {
                    [viewController.navigationController setNavigationBarHidden:YES animated:animated];
                }
            } else {
                if (viewController.navigationController.isNavigationBarHidden) {
                    [viewController.navigationController setNavigationBarHidden:NO animated:animated];
                }
            }
        }
        
        // 导航栏背景
        if ([vc respondsToSelector:@selector(yl_navigationBarBackgroundImage)]) {
            UIImage *backgroundImage = [vc yl_navigationBarBackgroundImage];
            [viewController.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
        } else {
            UIImage *backgroundImage = nil; // 此时设置通用背景(我这里暂时没有用到,所以用nil代替)
            if (backgroundImage) {
                [viewController.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
            }
        }
        
        // 导航栏底部分割线(暂时没有用到)
        if ([vc respondsToSelector:@selector(yl_navigationBarShadowImage)]) {
            UIImage *shadowImage = [vc yl_navigationBarShadowImage];
            [viewController.navigationController.navigationBar setShadowImage:shadowImage];
        } else {
            UIImage *shadowImage = [UIImage yl_imageWithColor:rgbA(0.1f, 0.1f, 0.1f, 0.65f)];
            if (shadowImage) {
                [viewController.navigationController.navigationBar setShadowImage:shadowImage];
            }
        }
        
        // 导航栏上控件的颜色(BaseNavController中可设置)
        if ([vc respondsToSelector:@selector(yl_navigationBarTintColor)]) {
            UIColor *tintColor = [vc yl_navigationBarTintColor];
            viewController.navigationController.navigationBar.tintColor = tintColor;
        } else {
            UIColor *tintColor = nil;
            if (tintColor) {
                viewController.navigationController.navigationBar.tintColor = tintColor;
            }
        }
    }
}

+ (void)replaceStyleForNavigationBar:(UINavigationBar *)navBarA withNavigationBar:(UINavigationBar *)navBarB {
    navBarB.barStyle = navBarA.barStyle;
    navBarB.barTintColor = navBarA.barTintColor;
    [navBarB setBackgroundImage:[navBarA backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
    [navBarB setShadowImage:navBarA.shadowImage];
}

/// 该 viewController 是否实现自定义 navBar 动画协议
- (BOOL)respondCustomNavigationBarTransitionWhenPushAppearing {
    BOOL respondPushAppearing = NO;
    if ([self conformsToProtocol:@protocol(BaseNavigationBarTransitionDelegate)]) {
        UIViewController<BaseNavigationBarTransitionDelegate> *vc = (UIViewController<BaseNavigationBarTransitionDelegate> *)self;
        if ([vc respondsToSelector:@selector(yl_shouldCustomNavigationBarTransitionWhenPushApperaing)]) {
            respondPushAppearing = YES;
        }
    }
    return respondPushAppearing;
}

- (BOOL)respondCustomNavigationBarTransitionWhenPushDisappearing {
    BOOL respondPushDisappearing = NO;
    if ([self conformsToProtocol:@protocol(BaseNavigationBarTransitionDelegate)]) {
        UIViewController<BaseNavigationBarTransitionDelegate> *vc = (UIViewController<BaseNavigationBarTransitionDelegate> *)self;
        if ([vc respondsToSelector:@selector(yl_shouldCustomNavigationBarTransitionWhenPushDisappearing)]) {
            respondPushDisappearing = YES;
        }
    }
    return respondPushDisappearing;
}

- (BOOL)respondCustomNavigationBarTransitionWhenPopAppearing {
    BOOL respondPopAppearing = NO;
    if ([self conformsToProtocol:@protocol(BaseNavigationBarTransitionDelegate)]) {
        UIViewController<BaseNavigationBarTransitionDelegate> *vc = (UIViewController<BaseNavigationBarTransitionDelegate> *)self;
        if ([vc respondsToSelector:@selector(yl_shouldCustomNavigationBarTransitionWhenPopAppearing )]) {
            respondPopAppearing = YES;
        }
    }
    return respondPopAppearing;
}

- (BOOL)respondCustomNavigationBarTransitionWhenPopDisappearing {
    BOOL respondPopDisappearing = NO;
    if ([self conformsToProtocol:@protocol(BaseNavigationBarTransitionDelegate)]) {
        UIViewController<BaseNavigationBarTransitionDelegate> *vc = (UIViewController<BaseNavigationBarTransitionDelegate> *)self;
        if ([vc respondsToSelector:@selector(yl_shouldCustomNavigationBarTransitionWhenPopDisappearing)]) {
            respondPopDisappearing = YES;
        }
    }
    return respondPopDisappearing;
}

- (BOOL)respondCustomNavigationBarTransitionIfBarHiddenable {
    BOOL respondIfBarHiddenable = NO;
    if ([self conformsToProtocol:@protocol(BaseNavigationBarTransitionDelegate)]) {
         UIViewController<BaseNavigationBarTransitionDelegate> *vc = (UIViewController<BaseNavigationBarTransitionDelegate> *)self;
        if ([vc respondsToSelector:@selector(yl_shouldCustomizeNavigationBarTransitionIfHideable)]) {
            respondIfBarHiddenable = YES;
        }
    }
    return respondIfBarHiddenable;
}

- (BOOL)respondCustomNavigationBarTransitionWithBarHiddenState {
    BOOL respondWithBarHidden = NO;
    if ([self conformsToProtocol:@protocol(BaseNavigationBarTransitionDelegate)]) {
        UIViewController<BaseNavigationBarTransitionDelegate> *vc = (UIViewController<BaseNavigationBarTransitionDelegate> *)self;
        if ([vc respondsToSelector:@selector(yl_preferredNavigationBarHidden)]) {
            respondWithBarHidden = YES;
        }
    }
    return respondWithBarHidden;
}

- (BOOL)canCustomNavigationBarTransitionWhenPushAppearing {
    if ([self respondCustomNavigationBarTransitionWhenPushAppearing]) {
        UIViewController<BaseNavigationBarTransitionDelegate> *vc = (UIViewController<BaseNavigationBarTransitionDelegate> *)self;
        return [vc yl_shouldCustomNavigationBarTransitionWhenPushApperaing];
    }
    return NO;
}

- (BOOL)canCustomNavigationBarTransitionWhenPushDisappearing {
    if ([self respondCustomNavigationBarTransitionWhenPushDisappearing]) {
        UIViewController<BaseNavigationBarTransitionDelegate> *vc = (UIViewController<BaseNavigationBarTransitionDelegate> *)self;
        return [vc yl_shouldCustomNavigationBarTransitionWhenPushDisappearing];
    }
    return NO;
}

- (BOOL)canCustomNavigationBarTransitionWhenPopAppearing {
    if ([self respondCustomNavigationBarTransitionWhenPopAppearing]) {
        UIViewController<BaseNavigationBarTransitionDelegate> *vc = (UIViewController<BaseNavigationBarTransitionDelegate> *)self;
        return [vc yl_shouldCustomNavigationBarTransitionWhenPopAppearing];
    }
    return NO;
}

- (BOOL)canCustomNavigationBarTransitionWhenPopDisappearing {
    if ([self respondCustomNavigationBarTransitionWhenPopDisappearing]) {
        UIViewController<BaseNavigationBarTransitionDelegate> *vc = (UIViewController<BaseNavigationBarTransitionDelegate> *)self;
        return [vc yl_shouldCustomNavigationBarTransitionWhenPopDisappearing];
    }
    return NO;
}

- (BOOL)canCustomNavigationBarTransitionIfBarHiddenable {
    if ([self respondCustomNavigationBarTransitionIfBarHiddenable]) {
        UIViewController<BaseNavigationBarTransitionDelegate> *vc = (UIViewController<BaseNavigationBarTransitionDelegate> *)self;
        return [vc yl_shouldCustomizeNavigationBarTransitionIfHideable];
    }
    return NO;
}

- (BOOL)hideNavigationBarWhenTransition {
    if ([self respondCustomNavigationBarTransitionWithBarHiddenState]) {
        UIViewController<BaseNavigationBarTransitionDelegate> *vc = (UIViewController<BaseNavigationBarTransitionDelegate> *)self;
        BOOL hidden = [vc yl_preferredNavigationBarHidden];
        return hidden;
    }
    return NO;
}

- (UIColor *)containerViewBackGroundColor {
    UIColor *backgroundColor = [UIColor whiteColor];
    if ([self conformsToProtocol:@protocol(BaseNavigationBarTransitionDelegate)]) {
        UIViewController<BaseNavigationBarTransitionDelegate> *vc = (UIViewController<BaseNavigationBarTransitionDelegate> *)self;
        if ([vc respondsToSelector:@selector(yl_containerViewBackgroundColorWithTransitioning)]) {
            backgroundColor = [vc yl_containerViewBackgroundColorWithTransitioning];
        }
    }
    return backgroundColor;
}

#pragma mark ************* 工具方法 End   *************

#pragma mark ************* Getter Setter Start *************
- (BOOL)lockTransitionNavigationBar {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setLockTransitionNavigationBar:(BOOL)lockTransitionNavigationBar {
    objc_setAssociatedObject(self, @selector(lockTransitionNavigationBar), [[NSNumber alloc] initWithBool:lockTransitionNavigationBar], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UINavigationBar *)transitionNavigationBar {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTransitionNavigationBar:(UINavigationBar *)transitionNavigationBar {
    objc_setAssociatedObject(self, @selector(transitionNavigationBar), transitionNavigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)prefersNavigationBarBackgroundViewHiddlen {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setPrefersNavigationBarBackgroundViewHiddlen:(BOOL)prefersNavigationBarBackgroundViewHiddlen {
    [[self.navigationController.navigationBar valueForKey:@"backgroundView"] setHidden:prefersNavigationBarBackgroundViewHiddlen];
    objc_setAssociatedObject(self, @selector(prefersNavigationBarBackgroundViewHiddlen), [[NSNumber alloc] initWithBool:prefersNavigationBarBackgroundViewHiddlen], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)originClipsToBounds {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setOriginClipsToBounds:(BOOL)originClipsToBounds {
    objc_setAssociatedObject(self, @selector(originClipsToBounds), [[NSNumber alloc] initWithBool:originClipsToBounds], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)originContainerViewBackgroundColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setOriginContainerViewBackgroundColor:(UIColor *)originContainerViewBackgroundColor {
    objc_setAssociatedObject(self, @selector(originContainerViewBackgroundColor), originContainerViewBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark ************* Getter Setter End   *************
@end

@implementation UINavigationController (YLNavigationBarTransition)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [self class];
    });
}

- (void)yl_navigationBarTransition_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    if (!disappearingViewController) {
        return [self yl_navigationBarTransition_pushViewController:viewController animated:animated];
    }
    BOOL shouldCustomNavigationBarTransition = NO;
    if ([disappearingViewController canCustomNavigationBarTransitionWhenPushDisappearing]) {
        shouldCustomNavigationBarTransition = YES;
    }
    if (!shouldCustomNavigationBarTransition && [viewController canCustomNavigationBarTransitionWhenPushAppearing]) {
        shouldCustomNavigationBarTransition = YES;
    }
    if (shouldCustomNavigationBarTransition) {
        [disappearingViewController yl_addTransitionNavigationBarIfNeeded];
        disappearingViewController.prefersNavigationBarBackgroundViewHiddlen = YES;
    }
    return [self yl_navigationBarTransition_pushViewController:viewController animated:animated];
}

- (void)yl_navigationBarTransition_setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    if (viewControllers.count <= 0 || !animated) {
        return [self yl_navigationBarTransition_setViewControllers:viewControllers animated:animated];
    }
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    UIViewController *appearingViewController = viewControllers.lastObject;
    if (!disappearingViewController) {
        return [self yl_navigationBarTransition_setViewControllers:viewControllers animated:animated];
    }
    [self _handlePopViewControllerNavigationBarTransitionWithDisappearViewController:disappearingViewController appearViewController:appearingViewController];
    return [self yl_navigationBarTransition_setViewControllers:viewControllers animated:animated];
}

- (UIViewController *)yl_navigationBarTransition_popViewControllerAnimated:(BOOL)animated {
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    UIViewController *appearingViewController = self.viewControllers.count >= 2 ? self.viewControllers[self.viewControllers.count - 2] : nil;
    if (disappearingViewController && appearingViewController) {
        [self _handlePopViewControllerNavigationBarTransitionWithDisappearViewController:disappearingViewController appearViewController:appearingViewController];
    }
    return [self yl_navigationBarTransition_popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)yl_navigationBarTransition_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    UIViewController *appearingViewController = viewController;
    NSArray<UIViewController *> *popedViewControllers = [self yl_navigationBarTransition_popToViewController:viewController animated:animated];
    if (popedViewControllers) {
        [self _handlePopViewControllerNavigationBarTransitionWithDisappearViewController:disappearingViewController appearViewController:appearingViewController];
    }
    return popedViewControllers;
}

- (NSArray<UIViewController *> *)yl_navigationBarTransition_popToRootViewControllerAnimated:(BOOL)animated {
    NSArray<UIViewController *> *poppedViewControllers = [self yl_navigationBarTransition_popToRootViewControllerAnimated:animated];
    if (self.viewControllers.count > 1) {
        UIViewController *disappearingViewController = self.viewControllers.lastObject;
        UIViewController *appearingViewController = self.viewControllers.firstObject;
        if (poppedViewControllers) {
            [self _handlePopViewControllerNavigationBarTransitionWithDisappearViewController:disappearingViewController appearViewController:appearingViewController];
        }
    }
    return poppedViewControllers;
}

- (void)_handlePopViewControllerNavigationBarTransitionWithDisappearViewController:(UIViewController *)disappearViewController appearViewController:(UIViewController *)appearViewController {
    BOOL shouldCustomNavigationBarTransition = NO;
    if ([disappearViewController canCustomNavigationBarTransitionWhenPopDisappearing]) {
        shouldCustomNavigationBarTransition = YES;
    }
    if (appearViewController && !shouldCustomNavigationBarTransition && [appearViewController canCustomNavigationBarTransitionWhenPopAppearing]) {
        shouldCustomNavigationBarTransition = YES;
    }
    if (shouldCustomNavigationBarTransition) {
        [disappearViewController yl_addTransitionNavigationBarIfNeeded];
        if (appearViewController.transitionNavigationBar) {
            // 假设从A->B->C,其中A设置了bar样式,B跟随A所以B里面没有设置bar样式的代码,C又把样式改为另一种,此时从C返回B时,由于B没有设置bar的样式的代码,所以bar的样式依然会保留C的,这就错了,所以每次需要手动改回来才保险
            [UIViewController replaceStyleForNavigationBar:appearViewController.transitionNavigationBar withNavigationBar:self.navigationBar];
        }
        disappearViewController.prefersNavigationBarBackgroundViewHiddlen = YES;
    }
}

@end
