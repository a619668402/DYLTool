//
//  TestCustomView.m
//  DYLTool
//
//  Created by sky on 2018/9/13.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestCustomView.h"

@implementation TestCustomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 1.f;
        self.layer.borderColor = [[UIColor redColor] CGColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(self.yl_centerX, self.yl_centerY)];
//    [path addArcWithCenter:CGPointMake(self., self.yl_centerY) radius:100 startAngle:0 endAngle:M_PI / 2 * 4 clockwise:YES];
    [path setLineWidth:5.f];
//    [path stroke];
    [path fill];
}

@end
