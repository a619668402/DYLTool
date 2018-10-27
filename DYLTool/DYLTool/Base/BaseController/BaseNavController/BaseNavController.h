//
//  BaseNavController.h
//  DYLTool
//
//  Created by sky on 2018/6/28.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
                导航控制器根类
 *********************************************/

#import <UIKit/UIKit.h>

@interface BaseNavController : UINavigationController

/// 显示导航栏的细线
- (void)showNavigationBottomLine;
/// 隐藏导航栏的细线
- (void)hideNavigationBottomLine;

/*
- (void)yl_updateNavigationBarForViewController:(UIViewController *)vc;

- (void)yl_updateNavigationBarAlphaForViewController:(UIViewController *)vc;

- (void)yl_updateNavigationBarColorOrImageForViewController:(UIViewController *)vc;

- (void)yl_updateNavigationBarShadowAlphaForViewController:(UIViewController *)vc;
*/
@end

@protocol BaseNavigationBarTransitionDelegate <NSObject>

@optional
/// 设置每个页面导航栏的显示与隐藏, 为了减少对项目的入侵性,默认不开启这个功能,只有当 yl_shouldCustomizeNavigationBarTransitionIfHideable 返回为YES时开启这个功能,如果需要全局开启,在 Controller 基类里面返回YES;
- (BOOL)yl_preferredNavigationBarHidden;

/// 当切换页面时,如果不同页面导航栏的显示状态不同,可以通过 yl_shouldCustomizeNavigationBarTransitionIfHideable 设置是否需要接管导航栏的显示与隐藏,从而不需要在各自页面的 viewWillAppear 和 viewWillDisappear 里面去管理导航栏的状态.
/// @see UINavigationController+YLNavigationBarTransition.h
- (BOOL)yl_shouldCustomizeNavigationBarTransitionIfHideable;

/// 设置当前导航栏是否需要使用自定义的 push / pop transition效果, 默认返回 NO
/// 因为系统的 UINavigationController 只有一个navBar, 所以会导致在切换Controller时,如果两个Controller的navBar状态不一样(包括backgroundImage,shadowImage,barTintColor等等),就会导致在刚要切换的瞬间,navBar的状态立马变成下一个Controller所设置的样式了
/// @see UINavigationController+YLNavigationBarTransition.h
- (BOOL)yl_shouldCustomNavigationBarTransitionWhenPushApperaing;

/// 同上
/// @see UINavigationController+YLNavigationBarTransition.h
- (BOOL)yl_shouldCustomNavigationBarTransitionWhenPushDisappearing;

/// 同上
/// @see UINavigationController+YLNavigationBarTransition.h
- (BOOL)yl_shouldCustomNavigationBarTransitionWhenPopAppearing;

/// 同上
/// @see UINavigationController+YLNavigationBarTransition.h
- (BOOL)yl_shouldCustomNavigationBarTransitionWhenPopDisappearing;

/// 自定义navBar效果过程中UINavigationController的containerView背景色
/// @see UINavigationController+YLNavigationBarTransition.h
- (nullable UIColor *)yl_containerViewBackgroundColorWithTransitioning;

@end

@protocol BaseNavigationControllerAppearanceDelegate <NSObject>

@optional
/// 是否需要将状态栏改为浅色文字,对于 BaseViewController 子类,默认返回 UIStatusBarStyleLightContent, 对于UIViewController,不返回该方法则返回NO
/// @warning 需要在项目的info.plist文件内设置字段"View controller-based status bar appearnce"的值为NO才生效,如果不设置或者职位YES,请使用preferredStatusBarStyle方法(iOS 9之后废弃,此处无效)
- (BOOL)yl_shouldSetStatusBarStyleLight;

/// 设置titleView的tintColor
- (nullable UIColor *)yl_titleViewTintColor;

/// 设置导航栏背景图,默认为NavBarBackgroundImage
- (nullable UIImage *)yl_navigationBarBackgroundImage;

/// 设置导航栏底部的分割线图片,默认为NavBarShadowImage,必须在navigationBar设置了背景图后才有效
- (nullable UIImage *)yl_navigationBarShadowImage;

/// 设置当前导航栏的UIBarButtonItem的tintColor,默认为NavBarTitnColor
- (nullable UIColor *)yl_navigationBarTintColor;

/// 设置系统返回按钮的title, 如果返回nil则使用系统默认的返回按钮标题
- (nullable NSString *)yl_backBarButtonItemTitleWithPreviousViewController:(nullable UIViewController *)viewController;
@end

@protocol BaseNavigationControllerDelegate <UINavigationControllerDelegate, BaseNavigationBarTransitionDelegate, BaseNavigationControllerAppearanceDelegate>

@end
