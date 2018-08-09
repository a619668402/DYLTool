//
//  UIGestureRecognizer+YLBlock.h
//  DYLTool
//
//  Created by sky on 2018/8/9.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YLGestureBlock)(id gestureRecognizer);

@interface UIGestureRecognizer (YLBlock)

+ (instancetype)yl_gestureRecognizerWithActionBlock:(YLGestureBlock)block;

- (instancetype)initWithActionBlock:(YLGestureBlock)block;

@end
