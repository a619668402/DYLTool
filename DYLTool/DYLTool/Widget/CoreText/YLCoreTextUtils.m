//
//  YLCoreTextUtils.m
//  DYLTool
//
//  Created by sky on 2018/7/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLCoreTextUtils.h"

@implementation YLCoreTextUtils

+ (YLCoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(YLCoreTextData *)data {
    CTFrameRef textFrame = data.ctFrame;
    CFArrayRef lines = CTFrameGetLines(textFrame);
    if (!lines) {
        return nil;
    }
    CFIndex count = CFArrayGetCount(lines);
    YLCoreTextLinkData *foundLink = nil;
    
    // 获得每一行的origin坐标
    CGPoint origins[count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    // 翻转坐标系
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, view.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.0f, -1.0f);
    for (int i = 0; i < count; i ++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        
        // 获取每一行的CGRect信息
        CGRect flippedRect = [self _getLineBounds:line point:linePoint];
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        
        if (CGRectContainsPoint(rect, point)) {
            // 将点击的坐标系转换成相对于当前行的坐标
            CGPoint releativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
            // 获得当前点击坐标系对应的字符串偏移
            CFIndex idx = CTLineGetStringIndexForPosition(line, releativePoint);
            // 判断这个偏移是否在我们的链表中
            foundLink = [self _linkAtIndex:idx linkArray:data.linkArray];
            return foundLink;
        }
    }
    return nil;
}
/// 获取每一行的CGRect信息
+ (CGRect)_getLineBounds:(CTLineRef)line point:(CGPoint)point {
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(point.x, point.y, width, height);
}
/// 判断这个偏移是否在链表中
+ (YLCoreTextLinkData *)_linkAtIndex:(CFIndex)i linkArray:(NSArray *)linkArray {
    YLCoreTextLinkData *link = nil;
    for (YLCoreTextLinkData *data in linkArray) {
        if (NSLocationInRange(i, data.range)) {
            link = data;
            break;
        }
    }
    return link;
}

@end
