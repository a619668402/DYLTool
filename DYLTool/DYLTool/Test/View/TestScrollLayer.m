//
//  TestScrollLayer.m
//  DYLTool
//
//  Created by sky on 2019/2/28.
//  Copyright © 2019年 DYL. All rights reserved.
//

#import "TestScrollLayer.h"

@implementation TestScrollLayer

+ (Class)layerClass {
    return [CAScrollLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp{
    //允许剪切
    self.layer.masksToBounds = true;
    
    //给view添加UIPanGestureRecognizer
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}

-(void)pan:(UIPanGestureRecognizer *)sender{
    //获取pan的变化点
    CGPoint translation = [sender translationInView:self];
    CGPoint offset = self.bounds.origin;
    NSLog(@"offset.x = %f offset.y = %f",offset.x,offset.y);
    NSLog(@"translation.x = %f translation.y = %f",translation.x,translation.y);
    //计算差值
    offset.x -= translation.x;
    offset.y -= translation.y;
    //scrollLayer滑动,这里其实是在改变self.layer的bounds的原点origin
    [(CAScrollLayer *)self.layer scrollToPoint:offset];
    //重置滑动的位移
    [sender setTranslation:CGPointZero inView:self];
}

@end

