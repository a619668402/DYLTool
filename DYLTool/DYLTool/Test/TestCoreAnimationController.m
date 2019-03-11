//
//  TestCoreAnimationController.m
//  DYLTool
//
//  Created by sky on 2019/2/28.
//  Copyright © 2019年 DYL. All rights reserved.
//

#import "TestCoreAnimationController.h"
#import "TestReflectionView.h"
#import "TestScrollLayer.h"

@interface TestCoreAnimationController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIView *cotainView;

@property (nonatomic, strong) CALayer *colorLayer;

@property (nonatomic, strong) UIView *colorView;

@end

@implementation TestCoreAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)yl_initViews {
    [super yl_initViews];
    /*
    [self.view addSubview:self.cotainView];
    [self testReplicatorlayer];
     */
    
//    [self testReplicatorLayer1];
    
//    [self testScrolllayer];
    
//    [self testChangeColor];

//    [self testChangeViewColor];
    
//    [self testKeyframeAnim];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self test];
        [self testAnimate1];
        
    });
//    [self setPath];
//    [self setPath1];
    
    
}

- (void)testAnimate1 {
    self.colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.colorView.center = CGPointMake(150, 120);
    self.colorView.backgroundColor = black_color;
    [self.view addSubview:self.colorView];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.duration = 1;
//    anim.delegate = self;
    anim.values = @[[NSValue valueWithCGPoint:CGPointMake(150, 100)],
                    [NSValue valueWithCGPoint:CGPointMake(150, 400)],
                    [NSValue valueWithCGPoint:CGPointMake(150, 300)],
                    [NSValue valueWithCGPoint:CGPointMake(150, 400)],
                    [NSValue valueWithCGPoint:CGPointMake(150, 330)],
                    [NSValue valueWithCGPoint:CGPointMake(150, 400)],
                    [NSValue valueWithCGPoint:CGPointMake(150, 360)],
                    [NSValue valueWithCGPoint:CGPointMake(150, 400)]];
    anim.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    anim.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0];
    self.colorView.layer.position = CGPointMake(150, 400);
    [self.colorView.layer addAnimation:anim forKey:nil];
}

#pragma mark ----- CAMediaTimingFunction -----
- (void)setPath1 {
    [self.view addSubview:self.cotainView];
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.75 :1];
    float cp1[2],cp2[2];
    [fn getControlPointAtIndex:1 values:cp1];
    [fn getControlPointAtIndex:2 values:cp2];
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    [path addCurveToPoint:CGPointMake(1, 1) controlPoint1:CGPointMake(cp1[0], cp1[1]) controlPoint2:CGPointMake(cp2[0], cp2[1])];
    [path applyTransform:CGAffineTransformMakeScale(200, 200)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 4.f;
    layer.path = path.CGPath;
    [self.cotainView.layer addSublayer:layer];
    self.cotainView.layer.geometryFlipped = YES;
}

- (void)setPath {
    [self.view addSubview:self.cotainView];
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    float cp1[2],cp2[2];
    [fn getControlPointAtIndex:1 values:cp1];
    [fn getControlPointAtIndex:2 values:cp2];
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    [path addCurveToPoint:CGPointMake(1, 1) controlPoint1:CGPointMake(cp1[0], cp1[1]) controlPoint2:CGPointMake(cp2[0], cp2[1])];
    [path applyTransform:CGAffineTransformMakeScale(200, 200)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 4.f;
    layer.path = path.CGPath;
    [self.cotainView.layer addSublayer:layer];
    self.cotainView.layer.geometryFlipped = YES;
}

- (void)test1 {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = self.view.frame;
    [self.view addSubview:coverView];
    
    self.view.backgroundColor = [UIColor yl_randomColor];
    
    [UIView animateWithDuration:1 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        coverView.transform = transform;
        coverView.alpha = 0;
    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
    }];
}

- (void)test {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 100, 100);
    layer.position = self.view.center;
    layer.contents = (__bridge id)[UIImage imageNamed:@"image_1.jpg"].CGImage;
    [self.view.layer addSublayer:layer];
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.duration = 2.f;
    anim.byValue = @(M_PI * 2);
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [layer addAnimation:anim forKey:nil];
}

- (void)testKeyframeAnim {
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.lineWidth = 3.f;
    [self.view.layer addSublayer:layer];
    
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(0, 0, 50, 50);
    layer1.position = CGPointMake(0, 150);
    layer1.contents = (__bridge id)[UIImage imageNamed:@"image_1.jpg"].CGImage;
    [self.view.layer addSublayer:layer1];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.duration = 5;
    anim.path = bezierPath.CGPath;
    anim.rotationMode = kCAAnimationRotateAuto;
    [layer1 addAnimation:anim forKey:nil];
}

- (void)testChangeViewColor {
    self.colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.colorView.center = self.view.center;
    [self.view addSubview:self.colorView];
    self.colorView.backgroundColor = black_color;
}

- (void)testChangeColor {
    self.colorLayer = [CALayer layer];
    self.colorLayer.bounds = CGRectMake(0, 0, 200, 100);
    self.colorLayer.position = self.view.center;
    self.colorLayer.backgroundColor = blue_color.CGColor;
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
//    self.colorLayer.actions = @{@"backgroundColor":transition};
    [self.view.layer addSublayer:self.colorLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:5];
//    [CATransaction setDisableActions:NO];
//    self.colorView.backgroundColor = [UIColor yl_randomColor];
//    self.colorLayer.backgroundColor = [UIColor yl_randomColor].CGColor;
//    [CATransaction commit];
    
    /*
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath =  @"backgroundColor";
    anim.toValue = (__bridge id)[UIColor yl_randomColor].CGColor;
    anim.delegate = self;
    [self.colorLayer addAnimation:anim forKey:@"bgcolor"];
     */
    
    /*
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"backgroundColor";
    anim.duration = 2.f;
    anim.values = @[(__bridge id)[UIColor blueColor].CGColor,
                    (__bridge id)[UIColor redColor].CGColor,
                    (__bridge id)[UIColor greenColor].CGColor,
                    (__bridge id)[UIColor blueColor].CGColor];
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    anim.timingFunctions = @[fn, fn, fn];
    [self.colorLayer addAnimation:anim forKey:nil];
    */
    
//    [self test1];
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationDuration:3];
    self.colorLayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}

- (void)testScrolllayer {
    CALayer * layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 500, 500);
    layer.position = CGPointMake(150, 100);
    layer.contents = (__bridge id)[UIImage imageNamed:@"image_1.jpg"].CGImage;
    
    //创建自定义的scrollLayer的view
    TestScrollLayer *scrollLayer = [[TestScrollLayer alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    scrollLayer.layer.borderColor = [UIColor grayColor].CGColor;
    scrollLayer.layer.borderWidth = 1;
    
    scrollLayer.center = self.view.center;
    [scrollLayer.layer addSublayer:layer];
    [self.view addSubview:scrollLayer];
}

/// 倒影
- (void)testReplicatorLayer1 {
    /*
    UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 220, 220)];
    v.center = self.view.center;
    v.image = [UIImage imageNamed:@"image_1.jpg"];
    [self.view addSubview:v];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(v.yl_x, v.yl_bottom, v.yl_width, v.yl_height / 2);
    [self.view.layer addSublayer:replicatorLayer];
    
    replicatorLayer.instanceCount = 2;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DScale(transform, 1.0, -1.0, 1.0);
    transform = CATransform3DTranslate(transform, 0, [v yl_height] * 2, 1.0);
    
    replicatorLayer.instanceTransform = transform;
    */
    
    TestReflectionView *v = [[TestReflectionView alloc] initWithFrame:CGRectMake(0, 0, 230, 230)];
    v.center = self.view.center;
    [self.view addSubview:v];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_1.jpg"]];
    iv.frame = CGRectMake(0, 0, 230, 230);
    [v addSubview:iv];
}

- (void)testReplicatorlayer {
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.cotainView.bounds;
    [self.cotainView.layer addSublayer:replicator];
    
    replicator.instanceCount = 10;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 200, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -200, 0);
    replicator.instanceTransform = transform;
    
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100.f, 100.f, 100.f, 100.f);
    layer.backgroundColor = green_color.CGColor;
    [replicator addSublayer:layer];
}

- (UIView *)cotainView {
    if (!_cotainView) {
        _cotainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _cotainView.center = self.view.center;
        _cotainView.backgroundColor = black_color;
    }
    return _cotainView;
}

@end
