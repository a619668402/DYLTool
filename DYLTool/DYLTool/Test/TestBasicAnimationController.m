//
//  TestBasicAnimationController.m
//  DYLTool
//
//  Created by sky on 2018/8/1.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestBasicAnimationController.h"
#import <GLKit/GLKit.h>

@interface TestBasicAnimationController ()<CAAnimationDelegate>

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIImageView *tempView;

@property (nonatomic, strong) UIView *tempView1;

@property (nonatomic, strong) UIView *containView;

@property (nonatomic, strong) UILabel *label1;

@property (nonatomic, strong) UILabel *label2;

@property (nonatomic, strong) UILabel *label3;

@property (nonatomic, strong) UILabel *label4;

@property (nonatomic, strong) UILabel *label5;

@property (nonatomic, strong) UILabel *label6;

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
    /*
    [self.view addSubview:self.label];
    [self.view addSubview:self.btn];
    
     
    [self.view addSubview:self.tempView];
    [self.view addSubview:self.tempView1];
     
     */
    
    [self.view addSubview:self.containView];
    [self.containView addSubview:self.label1];
    [self.containView addSubview:self.label2];
    [self.containView addSubview:self.label3];
    [self.containView addSubview:self.label4];
    [self.containView addSubview:self.label5];
    [self.containView addSubview:self.label6];
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.f;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.containView.layer.sublayerTransform = perspective;
    
    CATransform3D transform1 = CATransform3DMakeTranslation(0, 0, 100);
    self.label1.layer.transform = transform1;
    [self applyLightingToLayer:self.label1.layer];
    
    CATransform3D transform2 = CATransform3DMakeTranslation(100, 0, 0);
    transform2 = CATransform3DRotate(transform2, M_PI_2, 0, 1, 0);
    self.label2.layer.transform = transform2;
    [self applyLightingToLayer:self.label2.layer];
    
    CATransform3D transform3 = CATransform3DMakeTranslation(-100, 0, 0);
    transform3 = CATransform3DRotate(transform3, -M_PI_2, 0, 1, 0);
    self.label3.layer.transform = transform3;
    [self applyLightingToLayer:self.label3.layer];
    
    CATransform3D transform4 = CATransform3DMakeTranslation(0, 100, 0);
    transform4 = CATransform3DRotate(transform4, M_PI_2, 1, 0, 0);
    self.label4.layer.transform = transform4;
    [self applyLightingToLayer:self.label4.layer];
    
    CATransform3D transform5 = CATransform3DMakeTranslation(0, -100, 0);
    transform5 = CATransform3DRotate(transform5, -M_PI_2, 1, 0, 0);
    self.label5.layer.transform = transform5;
    [self applyLightingToLayer:self.label5.layer];
    
    CATransform3D transform6 = CATransform3DMakeTranslation(0, 0, -100);
    self.label6.layer.transform = transform6;
    [self applyLightingToLayer:self.label6.layer];
    /*
     */
}

- (void)applyLightingToLayer:(CALayer *)face {
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /*
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimation.fromValue = [NSValue valueWithCGPoint:self.label.frame.origin];
    basicAnimation.toValue = [NSValue valueWithCGPoint:location];
    basicAnimation.delegate = self;
    basicAnimation.duration = 3.0f;
    [self.label.layer addAnimation:basicAnimation forKey:@"position_animation"];
     
    [UIView animateWithDuration:5 animations:^{
        CATransform3D transform = self.tempView.layer.transform;
        transform = CATransform3DRotate(transform, M_PI / 4, 1, 0.5, 0.5);
        transform.m34 = -1.0 / 500;
        self.tempView.layer.transform = transform;
    }];
     
     */
    
    [UIView animateWithDuration:5 animations:^{
        CATransform3D transform = self.containView.layer.sublayerTransform;
        transform = CATransform3DRotate(transform, M_PI / 4, 1, 0, 0);
        self.containView.layer.sublayerTransform = transform;
    }];
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

- (UIImageView *)tempView {
    if (!_tempView) {
        _tempView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _tempView.image = [UIImage imageNamed:@"image_2.jpg"];
        _tempView.center = self.view.center;
    }
    return _tempView;
}

- (UIView *)tempView1 {
    if (!_tempView1) {
        _tempView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _tempView1.backgroundColor = red_color;
        _tempView1.center = self.tempView.center;
    }
    return _tempView1;
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

- (UIView *)containView {
    if (!_containView) {
        _containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _containView.center = self.view.center;
    }
    return _containView;
}

- (UILabel *)label1 {
    if (!_label1) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _label1.backgroundColor = [UIColor yl_randomColor];
//        _label1.center = self.containView.center;
    }
    return _label1;
}

- (UILabel *)label2 {
    if (!_label2) {
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _label2.backgroundColor = [UIColor yl_randomColor];
//        _label2.center = self.containView.center;
    }
    return _label2;
}

- (UILabel *)label3 {
    if (!_label3) {
        _label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _label3.backgroundColor = [UIColor yl_randomColor];
//        _label3.center = self.containView.center;
    }
    return _label3;
}

- (UILabel *)label4 {
    if (!_label4) {
        _label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _label4.backgroundColor = [UIColor yl_randomColor];
//        _label4.center = self.containView.center;
    }
    return _label4;
}

- (UILabel *)label5 {
    if (!_label5) {
        _label5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _label5.backgroundColor = [UIColor yl_randomColor];
//        _label5.center = self.containView.center;
    }
    return _label5;
}

- (UILabel *)label6 {
    if (!_label6) {
        _label6 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _label6.backgroundColor = [UIColor yl_randomColor];
//        _label6.center = self.containView.center;
    }
    return _label6;
}



@end
