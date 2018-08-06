//
//  TestBasicAnimationController.m
//  DYLTool
//
//  Created by sky on 2018/8/1.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestBasicAnimationController.h"

@interface TestBasicAnimationController ()<CAAnimationDelegate>

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIView *tempView;

@end

@implementation TestBasicAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)yl_initValues {
    [super yl_initValues];
}

- (void)yl_initViews {
    [super yl_initViews];
    [self.view addSubview:self.label];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.tempView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimation.fromValue = [NSValue valueWithCGPoint:self.label.frame.origin];
    basicAnimation.toValue = [NSValue valueWithCGPoint:location];
    basicAnimation.delegate = self;
    basicAnimation.duration = 3.0f;
    [self.label.layer addAnimation:basicAnimation forKey:@"position_animation"];
}

- (void)animationDidStart:(CAAnimation *)anim {
    KLogFunc;
    CABasicAnimation *baseAnim = (CABasicAnimation *)anim;
    [baseAnim setValue:baseAnim.toValue forKey:@"value"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    KLogFunc;
    if (flag) {
        self.label.layer.position = [[anim valueForKey:@"value"] CGPointValue];
    }
}

- (void)_btnClick:(UIButton *)btn {
    /*
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *key1 = [NSValue valueWithCGPoint:self.btn.frame.origin];
    NSValue *key2 = [NSValue valueWithCGPoint:CGPointMake(80, 150)];
    NSValue *key3 = [NSValue valueWithCGPoint:CGPointMake(45, 200)];
    NSValue *key4 = [NSValue valueWithCGPoint:CGPointMake(52, 250)];
    NSArray *values = @[key1, key2, key3, key4];
    keyFrameAnimation.values = values;
    keyFrameAnimation.duration = 4.0f;
    keyFrameAnimation.beginTime = CACurrentMediaTime() + 2;
    [self.btn.layer addAnimation:keyFrameAnimation forKey:@"frameAnimation"];
     */
    
    /*
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    shake.values = @[@0, @-5, @-10, @5, @10, @-5, @-10, @0];
    shake.additive = YES;
    shake.duration = 0.25;
    [btn.layer addAnimation:shake forKey:@"shakeAnimation"];
     */
    
    /*
    CATransition *transition = [[CATransition alloc] init];
    transition.type = @"pageCurl";
    transition.subtype = kCATransitionFromLeft;
    transition.duration = 1.0f;
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    self.tempView.layer.backgroundColor = rgb(R, G, B).CGColor;
    [self.tempView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
     */
    
    UIViewAnimationOptions option = UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveLinear;
    [UIView transitionWithView:self.tempView duration:0.5 options:option animations:^{
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        self.tempView.layer.backgroundColor = rgb(R, G, B).CGColor;
    } completion:^(BOOL finished) {
        KLogFunc;
    }];
}

- (UIView *)tempView {
    if (!_tempView) {
        _tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, KScreenWidth, KScreenHeight - 150)];
        _tempView.layer.backgroundColor = [UIColor greenColor].CGColor;
    }
    return _tempView;
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake((KScreenWidth - 80) / 2, 100, 80, 50);
        _btn.layer.backgroundColor = [UIColor blackColor].CGColor;
        [_btn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, KNavAndStatusHeight, 60, 40)];
        _label.layer.backgroundColor = [UIColor orangeColor].CGColor;
    }
    return _label;
}

@end
