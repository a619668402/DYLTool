//
//  UIViewController+Toast.m
//  DYLTool
//
//  Created by sky on 2018/6/26.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UIViewController+YLToast.h"

@implementation UIViewController (YLToast)

- (void)yl_toast:(NSString *)message {
    [YLProgressHUD showMessageWithView:self.view message:message];
}

@end
