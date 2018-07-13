//
//  MBProgressHUD+Toast.m
//  Base
//
//  Created by sky on 2018/6/12.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "MBProgressHUD+Toast.h"

@implementation MBProgressHUD (Toast)

+ (void)showMessageWithView:(UIView *)view message:(NSString *)message; {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    hud.detailsLabel.text = message;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:14.0f];
    hud.detailsLabel.numberOfLines = 0;
    hud.margin = 10.0f;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.bezelView.layer.cornerRadius = 4.0f;
    hud.offset = CGPointMake(0, 180);
    hud.bezelView.backgroundColor = [UIColor blackColor];
    [hud hideAnimated:YES afterDelay:2.0f];
}

@end
