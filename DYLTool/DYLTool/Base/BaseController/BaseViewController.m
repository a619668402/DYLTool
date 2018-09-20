//
//  BaseViewController.m
//  Base
//
//  Created by sky on 2018/6/11.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseViewController.h"
#import <objc/runtime.h>
#import <ReactiveObjC.h>

#import "MacrosTools.h"

@interface BaseViewController ()

@property (nonatomic, strong) YLProgressHUD *hud; // 加载动画控件
@property (nonatomic, assign) BOOL isDisplay; // 判断HUD是否正在显示,默认为NO;
@property (nonatomic, strong, readwrite) BaseViewModel *viewModel;
@end

@implementation BaseViewController

#pragma mark ---- 初始化方法 -----
- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    BaseViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController);
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(viewController);
        // 绑定 ViewModel
        [viewController bindViewModel];
        // 赋默认值
        [viewController yl_initValues];
        // 初始化控件
        [viewController yl_initViews];
    }];
    return viewController;
}

- (instancetype)initWithViewModel:(BaseViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

#pragma mark ----- 协议方法 -----

- (void)yl_initViews {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.hud];
}

- (void)yl_initValues {
    // 设置返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    // HUD 是否显示
    self.isDisplay = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    // 手势关闭 Controller
    self.fd_interactivePopDisabled = YES;
    // 通过代理隐藏导航栏
//    self.navigationController.delegate = self;
}

#pragma mark ----- 生命周期方法 -----
- (void)viewDidLoad {
    [super viewDidLoad];
    KLog(@"ParentViewController-------");
    /*
    // 赋默认值
    [self yl_initValues];
    // 初始化控件
    [self yl_initViews];
     */
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏系统返回按钮
    self.navigationItem.hidesBackButton = NO;
    /* BaseNavController 中已设置
    /// 设置导航栏颜色 (在 ViewDidLoad 不生效)
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
     */
    // 隐藏导航栏细线
    self.viewModel.prefersNavigationBarBottomLineHidden ? [(BaseNavController *) self.navigationController hideNavigationBottomLine] : [(BaseNavController *)self.navigationController showNavigationBottomLine];
    // 配置键盘
    IQKeyboardManager.sharedManager.enable = self.viewModel.keyBoardEnable;
    IQKeyboardManager.sharedManager.shouldResignOnTouchOutside = self.viewModel.shouldResignOnTouchOutside;
    IQKeyboardManager.sharedManager.keyboardDistanceFromTextField = self.viewModel.keyboardDistanceFromTextField;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:self.viewModel.prefersNavigationBarHidden animated:YES];
    if ([self isMovingToParentViewController]) {
        self.snapshot = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
    }
}

- (void)dealloc {
    NSArray *arrayChildClass = [self _findAllof:[self class]];
    NSString *name = [NSString stringWithCString:object_getClassName([arrayChildClass lastObject]) encoding:NSUTF8StringEncoding];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    KLog(@"-------- %@ 已释放 ---------", name);
}

/* 在子 Controller 中设置
#pragma mark ----- UINavigationController Delegate -----
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是自己
    BOOL isSelf =
    [viewController isKindOfClass:[self class]];
    if (isSelf) {
        [self.navigationController setNavigationBarHidden:!self.viewModel.prefersNavigationBarHidden animated:YES];
    } else {
        [self.navigationController setNavigationBarHidden:isSelf animated:YES];
    }
}
*/

#pragma mark ************* Override Method Start *************

/// Status Bar 前景色
- (BOOL)prefersStatusBarHidden { return NO; }

- (UIStatusBarStyle)preferredStatusBarStyle { return UIStatusBarStyleLightContent; }

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation { return UIStatusBarAnimationFade; }

#pragma mark ************* Override Method End   *************

#pragma mark ----- 公共方法 -----
// 绑定 viewModel
- (void)bindViewModel {
    KLog(@"----%@", self.viewModel.navTitle);
    RAC(self.navigationItem, title) = RACObserve(self, viewModel.navTitle);
}
/* 通过 bindViewModel 设置标题
// 设置导航栏顶部字体
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}
*/
- (void)showIndicatorView {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.hud != nil && self.isDisplay == NO) {
            self.hud.label.text = @"正在加载";
            [self.hud showAnimated:YES];
            self.isDisplay = YES;
        }
    });
}

- (void)showIndicatorViewWithMessage:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.hud != nil && self.isDisplay == NO) {
            self.hud.label.text = message;
            [self.hud showAnimated:YES];
            self.isDisplay = YES;
        }
    });
}

- (void)dismissIndicatorView {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.hud != nil && self.isDisplay == YES) {
            [self.hud hideAnimated:YES];
            self.isDisplay = NO;
        }
    });
}
#pragma mark ----- 处理错误信息 -----
- (void)ProcessRequestError:(NSError *)error {
    switch (error.code) {
    }
}

#pragma mark ----- 私有方法 -----
- (void)_backBtnClick {
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count == 1) {
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

// 获取当前控制器下的子类
- (NSArray *)_findAllof:(Class)defaultClass {
    int count = objc_getClassList(NULL, 0);
    if (count <= 0) {
        return [NSArray arrayWithObject:defaultClass];
    }
    
    NSMutableArray *output = [NSMutableArray arrayWithObject:defaultClass];
    Class *classes = (Class *) malloc(sizeof(Class) * count);
    objc_getClassList(classes, count);
    for (int i = 0; i < count; i ++) {
        if (defaultClass == class_getSuperclass(classes[i])) {
            [output addObject:classes[i]];
        }
    }
    free(classes);
    return [NSArray arrayWithArray:output];
}

#pragma mark ----- 懒加载 -----
/// MBProgressHUD
- (YLProgressHUD *)hud {
    if (!_hud) {
        _hud = [[YLProgressHUD alloc] initWithView:self.view];
        _hud.mode = YLProgressHUDModeIndeterminate;
        _hud.bezelView.color = [UIColor blackColor];
        _hud.bezelView.color = [_hud.bezelView.color colorWithAlphaComponent:1];
        _hud.bezelView.layer.cornerRadius = 8.0f;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
        [UIActivityIndicatorView appearanceWhenContainedIn:[YLProgressHUD class], nil].color = [UIColor whiteColor];
#else
        [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = [UIColor whiteColor];
#endif
        _hud.removeFromSuperViewOnHide = NO;
        _hud.userInteractionEnabled = YES;
        _hud.label.textColor = [UIColor whiteColor];
        _hud.label.font = [UIFont systemFontOfSize:14.0f];
    }
    return _hud;
}
/// 设置加载动画文字描述
- (void)setLodingMessage:(NSString *)lodingMessage {
    _lodingMessage = lodingMessage;
    self.hud.label.text = lodingMessage;
}

@end
