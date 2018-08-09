//
//  UIView+YLExtendTouchRect.m
//  DYLTool
//
//  Created by sky on 2018/8/9.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UIView+YLExtendTouchRect.h"

void Swizee(Class c, SEL origin, SEL new) {
    Method originMethod = class_getInstanceMethod(c, origin);
    Method newMethod = class_getInstanceMethod(c, new);
    if (class_addMethod(c, origin, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(c, new, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, newMethod);
    }
}

@implementation UIView (YLExtendTouchRect)

+ (void)load {
    Swizee(self, @selector(pointInside:withEvent:), @selector(_pointInside:withEvent:));
}

- (BOOL)_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.touchExtendInset, UIEdgeInsetsZero) || self.hidden || ([self isKindOfClass:[UIControl class]] && !((UIControl *)self).enabled)) {
        return [self _pointInside:point withEvent:event];
    }
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.touchExtendInset);
    hitFrame.size.width = MAX(hitFrame.size.width, 0);
    hitFrame.size.height = MAX(hitFrame.size.height, 0);
    return CGRectContainsPoint(hitFrame, point);
}

static char touchExtendInsetKey;
- (void)setTouchExtendInset:(UIEdgeInsets)touchExtendInset {
    objc_setAssociatedObject(self, &touchExtendInsetKey, [NSValue valueWithUIEdgeInsets:touchExtendInset], OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)touchExtendInset {
    return [objc_getAssociatedObject(self, &touchExtendInsetKey) UIEdgeInsetsValue
            ];
}
@end
