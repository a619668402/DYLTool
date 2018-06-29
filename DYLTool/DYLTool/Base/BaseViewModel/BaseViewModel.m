//
//  BaseViewModel.m
//  DYLTool
//
//  Created by sky on 2018/6/27.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseViewModel.h"
#import <ReactiveObjC.h>

/// 传递导航栏 title key
NSString *const KViewModelTitleKey = @"YLViewModelTitleKey";

@interface BaseViewModel ()

@property (nonatomic, readwrite, copy) NSDictionary *params;

@end

@implementation BaseViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    BaseViewModel *viewModel = [super allocWithZone:zone];
    @weakify(viewModel);
    [[viewModel rac_signalForSelector:@selector(initWithParams:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(viewModel);
        [viewModel initialize];
    }];
    return viewModel;
}

// create viewModel instance
- (instancetype)initWithParams:(NSDictionary *)params {
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
    }
    return self;
}

- (void)initialize {}

@end
