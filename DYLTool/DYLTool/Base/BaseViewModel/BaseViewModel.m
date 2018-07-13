//
//  BaseViewModel.m
//  DYLTool
//
//  Created by sky on 2018/6/27.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseViewModel.h"

/// 传递导航栏 title key
NSString *const KViewModelTitleKey = @"YLViewModelTitleKey";

@interface BaseViewModel ()

@property (nonatomic, readwrite, copy) NSDictionary *params;

@property (nonatomic, readwrite, strong) id<BaseViewModelServices> services;

@end

@implementation BaseViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    BaseViewModel *viewModel = [super allocWithZone:zone];
    @weakify(viewModel);
    [[viewModel rac_signalForSelector:@selector(initWithParams:services:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(viewModel);
        [viewModel initialize];
    }];
    return viewModel;
}

// create viewModel instance
- (instancetype)initWithParams:(NSDictionary *)params services:(id<BaseViewModelServices>)services {
    self = [super init];
    if (self) {
        // 默认在 viewDidLoad 中加载本地和网络数据
        self.shouldRequestRemoteDataOnViewDidLoad = YES;
        self.shouldFetchLocalDataOnViewModelInitliaze = YES;
        // 允许 IQKeyboardManager 接管键盘弹出事件
        self.keyBoardEnable = YES;
        self.shouldResignOnTouchOutside = YES;
        self.keyboardDistanceFromTextField = 10.f;
        
        self.navTitle = params[KViewModelTitleKey];
        // 赋值
        self.params = params;
        self.services = services;
    }
    return self;
}

- (void)initialize {}

@end
