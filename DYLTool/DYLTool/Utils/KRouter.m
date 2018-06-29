//
//  KRouter.m
//  DYLTool
//
//  Created by sky on 2018/6/27.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "KRouter.h"

@interface KRouter()

/**
 viewModel - ViewController 映射
 */
@property (nonatomic, copy) NSDictionary *viewModelViewMappings;

@end

@implementation KRouter

static KRouter *sharedInstance = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone: zone];
    });
    return sharedInstance;
}

- (id)copyWithZone:(NSZone *)zone {
    return sharedInstance;
}

- (BaseViewController *)viewControllerFromViewModel:(BaseViewModel *)viewModel {
    NSString *viewController = self.viewModelViewMappings[NSStringFromClass(viewModel.class)];
    
    NSParameterAssert([NSClassFromString(viewController) isSubclassOfClass:[BaseViewController class]]);
    NSParameterAssert([NSClassFromString(viewController) instancesRespondToSelector:@selector(initWithViewModel:)]);
    
    return [[NSClassFromString(viewController) alloc] initWithViewModel:viewModel];
}

/// viewModel - ViewController 的映射
/// If You Use Push, Present, You Must Config This Dict.
- (NSDictionary *)viewModelViewMappings {
    return @{@"viewModel":@"ViewController"};
}

@end
