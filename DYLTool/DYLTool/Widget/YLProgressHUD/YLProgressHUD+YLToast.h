//
//  MBProgressHUD+Toast.h
//  Base
//
//  Created by sky on 2018/6/12.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLProgressHUD.h"

@interface YLProgressHUD (YLToast)

+ (void)showMessageWithView:(UIView *)view message:(NSString *)message;

@end
