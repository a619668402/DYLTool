//
//  UIView+CurrentViewController.m
//  DYLTool
//
//  Created by sky on 2018/6/8.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UIView+CurrentViewController.h"

@implementation UIView (CurrentViewController)

- (UIViewController *)yl_getCurrentViewController {
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end
