//
//  BaseNavigationControllerStack.m
//  DYLTool
//
//  Created by sky on 2018/7/4.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseNavigationControllerStack.h"
#import "BaseNavigationProtocol.h"
#import "BaseViewController.h"
#import "BaseNavController.h"
#import "KRouter.h"

@interface BaseNavigationControllerStack()

@property (nonatomic, strong) id<BaseViewModelServices> services;

@property (nonatomic, strong) NSMutableArray *navigationControllers;

@end

@implementation BaseNavigationControllerStack

- (instancetype)initWithServiecs:(id<BaseViewModelServices>)services {
    self = [super init];
    if (self) {
        self.services = services;
        self.navigationControllers = [NSMutableArray array];
        [self registerNavigationHooks];
    }
    return self;
}

- (void)pushNavigationController:(UINavigationController *)navigationController {
    if ([self.navigationControllers containsObject:navigationController]) {
        return;
    }
    [self.navigationControllers addObject:navigationController];
}

- (UINavigationController *)popNavigationController {
    UINavigationController *navigationController = self.navigationControllers.lastObject;
    [self.navigationControllers removeLastObject];
    return navigationController;
}

- (UINavigationController *)topNavigationController {
    return self.navigationControllers.lastObject;
}

- (void)registerNavigationHooks {
    @weakify(self);
    [[(NSObject *)self.services rac_signalForSelector:@selector(pushViewModel:animated:)] subscribeNext:^(RACTuple * _Nullable tuple) {
        @strongify(self);
        BaseViewController *topViewController = (BaseViewController *)[self.navigationControllers.lastObject topViewController];
        if (topViewController.tabBarController) {
            topViewController.snapshot = [topViewController.tabBarController.view snapshotViewAfterScreenUpdates:NO];
        } else {
            topViewController.snapshot = [[self.navigationControllers.lastObject view] snapshotViewAfterScreenUpdates:NO];
        }
        UIViewController *viewController = (UIViewController *)[KRouter.shareInstance viewControllerFromViewModel:tuple.first];
        [self.navigationControllers.lastObject pushViewController:viewController animated:[tuple.second boolValue]];
    }];
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(popViewModelAnimated:)] subscribeNext:^(RACTuple * _Nullable tuple) {
        @strongify(self);
        [self.navigationControllers.lastObject popViewControllerAnimated:[tuple.first boolValue]];
    }];
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(popToRootViewModelAnimated:)] subscribeNext:^(RACTuple * _Nullable tuple) {
        @strongify(self);
        [self.navigationControllers.lastObject popToRootViewControllerAnimated:[tuple.first boolValue]];
    }];
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(presentViewModel:animated:completion:)] subscribeNext:^(RACTuple * _Nullable tuple) {
        @strongify(self);
        UIViewController *viewController = (UIViewController *)[KRouter.shareInstance viewControllerFromViewModel:tuple.first];
        UINavigationController *presentingViewControlelr = [self.navigationControllers lastObject];
        if (![viewController isKindOfClass:[UINavigationController class]]) {
            viewController = [[BaseNavController alloc] initWithRootViewController:viewController];
        }
        [self pushNavigationController:(UINavigationController *)viewController];
        
        [presentingViewControlelr presentViewController:viewController animated:[tuple.second boolValue] completion:tuple.third];
    }];
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(dismissViewModelAnimated:completion:)] subscribeNext:^(RACTuple * _Nullable tuple) {
        @strongify(self);
        [self popNavigationController];
        [self.navigationControllers.lastObject dismissViewModelAnimated:[tuple.first boolValue] completion:tuple.second];
    }];
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(resetRootViewModel:)] subscribeNext:^(RACTuple * _Nullable tuple) {
        @strongify(self);
        [self.navigationControllers removeAllObjects];
        /// VM 映射 VC
        UIViewController *viewController = (UIViewController *)[KRouter.shareInstance viewControllerFromViewModel:tuple.first];
        if (![viewController isKindOfClass:[UINavigationController class]] &&
            ![viewController isKindOfClass:[BaseViewController class]]) {
            viewController = [[BaseNavController alloc] initWithRootViewController:viewController];
            [self pushNavigationController:(UINavigationController *)viewController];
        }
        [UIApplication sharedApplication].delegate.window.rootViewController = viewController;
    }];
}

@end
