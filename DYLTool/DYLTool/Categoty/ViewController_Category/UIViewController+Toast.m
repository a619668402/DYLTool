//
//  UIViewController+Toast.m
//  DYLTool
//
//  Created by sky on 2018/6/26.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UIViewController+Toast.h"
#import "MBProgressHUD+Toast.h"

@implementation UIViewController (Toast)

- (void)yl_toast:(NSString *)message {
    [MBProgressHUD showMessageWithView:self.view message:message];
}

@end