//
//  YLTableView.m
//  DYLTool
//
//  Created by sky on 2019/1/11.
//  Copyright © 2019年 DYL. All rights reserved.
//

#import "YLTableView.h"

@implementation YLTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
