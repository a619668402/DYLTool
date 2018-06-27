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

- (BaseViewController *)viewControllerFromViewModel:(BaseViewModel *)viewModel {
    NSString *viewController = self.viewModelViewMappings[NSStringFromClass(viewModel.class)];
    
    NSParameterAssert([NSClassFromString(viewController) isSubclassOfClass:[BaseViewController class]]);
    NSParameterAssert([NSClassFromString(viewController) instancesRespondToSelector:@selector(initWithViewModel:)]);
    
    return [[NSClassFromString(viewController) alloc] initWithViewModel:viewModel];
}

@end
