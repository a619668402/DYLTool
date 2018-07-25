//
//  YLDisplayView.m
//  DYLTool
//
//  Created by sky on 2018/7/24.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLDisplayView.h"
#import <CoreText/CoreText.h>

@implementation YLDisplayView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // 1.获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 2.旋转坐标系
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    if (self.data) {
        CTFrameDraw(self.data.ctFrame, context);
    }
}

@end
