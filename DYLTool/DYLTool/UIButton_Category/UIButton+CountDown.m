//
//  UIButton+CountDown.m
//  DYLTool
//
//  Created by sky on 2018/6/20.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UIButton+CountDown.h"

@implementation UIButton (CountDown)

- (void)yl_countDownWithTotalTime:(NSInteger)totalTime title:(NSString *)title countDownTitle:(NSString *)countDownTitle mainColor:(UIColor *)mainColor countDownColor:(UIColor *)countDownColor{
    __block NSInteger timeOut = totalTime;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
       // 倒计时结束,关闭
        if (timeOut == 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setBackgroundColor:mainColor];
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        } else {
            int seconds = timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.1d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setBackgroundColor:countDownColor];
                [self setTitle:[NSString stringWithFormat:@"%@%@", timeStr, countDownTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            timeOut --;
        }
    });
    dispatch_resume(_timer);
}

@end
