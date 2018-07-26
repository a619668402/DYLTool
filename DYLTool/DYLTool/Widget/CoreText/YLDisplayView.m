//
//  YLDisplayView.m
//  DYLTool
//
//  Created by sky on 2018/7/24.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLDisplayView.h"
#import <CoreText/CoreText.h>

@interface YLDisplayView()

@property (nonatomic, strong) UIImageView *tapImageView;

@property (nonatomic, strong) UIView *coverView;

@end

@implementation YLDisplayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _setupEvents];
    }
    return self;
}

- (void)_setupEvents {
    UITapGestureRecognizer *tapRecoginzer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_userTapGestureDetected:)];
    [self addGestureRecognizer:tapRecoginzer];
    self.userInteractionEnabled = YES;
}

- (void)_userTapGestureDetected:(UITapGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:self];
    for (YLCoreTextImageData *imageData in self.data.imageArray) {
        // 翻转坐标系
        CGRect imageRect = imageData.imagePosition;
        CGPoint imagePosition = imageRect.origin;
        imagePosition.y = self.bounds.size.height - imageRect.origin.y - imageRect.size.height;
        CGRect rect = CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
        
        // 检测点击位置Point是否在Rect之内
        if (CGRectContainsPoint(rect, point)) {
            [self _showTapImage:[UIImage imageNamed:imageData.name]];
            break;
        }
    }
    // 点击链接
    YLCoreTextLinkData *linkData = [YLCoreTextUtils touchLinkInView:self atPoint:point data:self.data];
    if (linkData) {
        [self _showTapLink:linkData.url];
        return;
    }
}

- (void)_showTapImage:(UIImage *)tapImage {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 图片
    self.tapImageView = [[UIImageView alloc] initWithImage:tapImage];
    self.tapImageView.frame = CGRectZero;
    self.tapImageView.center = window.center;
    [UIView animateWithDuration:0.25 animations:^{
        self.tapImageView.frame = CGRectMake(0, 0, 300, 200);
        self.tapImageView.center = window.center;
    }];
    
    // 蒙版
    self.coverView = [[UIView alloc] initWithFrame:window.frame];
    [self.coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_cancle)]];
    self.coverView.backgroundColor = rgbA(0, 0, 0, 0.6);
    self.coverView.userInteractionEnabled = YES;
    
    [window addSubview:self.coverView];
    [window addSubview:self.tapImageView];
}

- (void)_showTapLink:(NSString *)urlStr {
    KLog(@"------%@------", urlStr);
}

- (void)_cancle {
    [UIView animateWithDuration:0.25 animations:^{
        self.tapImageView.frame = CGRectMake(0, 0, 0, 0);
        self.tapImageView.center = self.coverView.center;
    } completion:^(BOOL finished) {
        [self.tapImageView removeFromSuperview];
        [self.coverView removeFromSuperview];
    }];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // 1.获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 2.旋转坐标系
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    KLog(@"------");
    if (self.data) {
        CTFrameDraw(self.data.ctFrame, context);
        for (YLCoreTextImageData *imageData in self.data.imageArray) {
            UIImage *image = [UIImage imageNamed:imageData.name];
            CGContextDrawImage(context, imageData.imagePosition, image.CGImage);
        }
    }
}

@end
