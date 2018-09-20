//
//  UIViewController+TestSwizee.m
//  DYLTool
//
//  Created by sky on 2018/9/6.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UIViewController+TestSwizee.h"

@implementation UIViewController (TestSwizee)

+ (void)load {
    Method oldMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method newMethod = class_getInstanceMethod([self class], @selector(yl_viewDidLoad));
//    method_exchangeImplementations(oldMethod, newMethod);
}

- (void)yl_viewDidLoad {
    [self yl_viewDidLoad];
    NSLog(@"-------testSwizee------");
}

@end
