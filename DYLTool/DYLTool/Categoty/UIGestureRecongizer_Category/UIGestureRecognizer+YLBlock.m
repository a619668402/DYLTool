//
//  UIGestureRecognizer+YLBlock.m
//  DYLTool
//
//  Created by sky on 2018/8/9.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UIGestureRecognizer+YLBlock.h"

static const int target_key;

@implementation UIGestureRecognizer (YLBlock)

+ (instancetype)yl_gestureRecognizerWithActionBlock:(YLGestureBlock)block {
    return [[self alloc] initWithActionBlock:block];
}

- (instancetype)initWithActionBlock:(YLGestureBlock)block {
    self = [self init];
    [self _addActionBlock:block];
    [self addTarget:self action:@selector(invoke:)];
    return self;
}

- (void)_addActionBlock:(YLGestureBlock)block {
    if (block) {
        objc_setAssociatedObject(self, &target_key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)invoke:(id)sender {
    YLGestureBlock block = objc_getAssociatedObject(self, &target_key);
    if (block) {
        block(sender);
    }
}

@end
