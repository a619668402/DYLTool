//
//  BaseViewController.m
//  Base
//
//  Created by sky on 2018/6/11.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseViewController.h"
#import <objc/runtime.h>

@interface BaseViewController ()

@property (nonatomic, strong) MBProgressHUD *hud; // 加载动画控件
@property (nonatomic, assign) BOOL isDisplay; // 判断HUD是否正在显示,默认为NO;
@property (nonatomic, copy, readwrite) NSDictionary *parameter;

@end

@implementation BaseViewController

#pragma mark ---- 初始化方法 -----
- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (instancetype)initWithParameter:(NSDictionary *)parameter {
    if (self = [super init]) {
        if (parameter != nil) {
            self.parameter = [parameter copy];
        }
    }
    return self;
}

#pragma mark ----- 生命周期方法 -----
- (void)viewDidLoad {
    [super viewDidLoad];
    // 赋默认值
    [self initValue];
    // 初始化控件
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray *viewControllers = [self.navigationController viewControllers];
    if (viewControllers.count > 1) {
        // 返回按钮
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        backBtn.frame = CGRectMake(0, 0, 10, 18);
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    // 设置导航栏不覆盖内容
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    NSArray *arrayChildClass = [self findAllof:[self class]];
    NSString *name = [NSString stringWithCString:object_getClassName([arrayChildClass lastObject]) encoding:NSUTF8StringEncoding];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"-------- %@ 已释放 ---------", name);
}

#pragma mark ----- 公共方法 -----

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

- (void)ProcessRequestError:(NSError *)error {
    switch (error.code) {
        case :
            
            break;
            
        default:
            break;
    }
}

#pragma mark ----- 私有方法 -----
- (void)initValue {
    self.isDisplay = NO;
}
- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.hud];
}

- (void)backBtnClick {
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count == 1) {
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

// 获取当前控制器下的子类
- (NSArray *)findAllof:(Class)defaultClass {
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
// MBProgressHUD
- (MBProgressHUD *)hud {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
        _hud.mode = MBProgressHUDModeIndeterminate;
        _hud.bezelView.color = [UIColor blackColor];
        _hud.bezelView.color = [_hud.bezelView.color colorWithAlphaComponent:1];
        _hud.bezelView.layer.cornerRadius = 8.0f;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
        [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
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
// 设置加载动画文字描述
- (void)setLodingMessage:(NSString *)lodingMessage {
    _lodingMessage = lodingMessage;
    self.hud.label.text = lodingMessage;
}

@end
