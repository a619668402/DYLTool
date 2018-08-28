//
//  TestBezierPathController.m
//  DYLTool
//
//  Created by sky on 2018/8/24.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestBezierPathController.h"

@interface TestBezierPathController ()

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation TestBezierPathController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)yl_initViews {
    [super yl_initViews];
    
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.frame = self.view.bounds;
//
//    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)) radius:200/2 -1 startAngle:0 endAngle:2*M_PI clockwise:YES];
//    layer.path = path1.CGPath;
//    layer.strokeColor = [[UIColor redColor] CGColor];
////    layer.fillColor = [[UIColor blackColor] CGColor];
//    layer.fillColor = nil;
//    [self.view.layer addSublayer:layer];
//
//    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
//    strokeStartAnimation.fromValue = @(0.9);
//    strokeStartAnimation.toValue = @(0.5);
//
//    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    strokeStartAnimation.fromValue = @(0.8);
//    strokeStartAnimation.toValue = @(0.5);
//
//    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotationAnimation.fromValue = @(0);
//    rotationAnimation.toValue = @(M_PI * 2);
//
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.duration = 5;
//    group.removedOnCompletion = NO;
//    group.fillMode = kCAFillModeForwards;
//    group.animations = @[strokeStartAnimation, strokeEndAnimation];
//    [layer addAnimation:group forKey:nil];

    /*
    CAShapeLayer * circle = [CAShapeLayer layer];
    circle.frame = self.view.bounds;
    //
    UIBezierPath  * circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)) radius:100 startAngle:M_PI / 4 endAngle:M_PI / 2 clockwise:YES];
    circle.path = circlePath.CGPath;
    circle.strokeColor = [UIColor blueColor].CGColor;
    circle.fillColor = nil;
    [self.view.layer addSublayer:circle];
    //通过圆的strokeStart 改变来进行改变
    CABasicAnimation * strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(0.2);
    strokeStartAnimation.toValue = @(0);
    //通过圆的strokeEnd 改变来进行改变
    CABasicAnimation * strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(1);
    strokeEndAnimation.toValue = @(0.5);
    //通过圆的transform.rotation.z 改变来进行改变
    CABasicAnimation * rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue = @(-M_PI * 2);
    //组合动画
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.duration = 20;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.animations = @[strokeStartAnimation,strokeEndAnimation,rotationAnimation];
//    [circle addAnimation:group forKey:nil];
     
     */
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.view.bounds;
    layer.strokeColor = [[UIColor blackColor] CGColor];
    layer.fillColor = nil;
    [self.view.layer addSublayer:layer];

    CGFloat arcCenterX = KScreenWidth * 0.5f;
    CGFloat arcCenterY = 200;
    
    /// 机器猫
    // 头
    CAShapeLayer *headerLayer = [CAShapeLayer layer];
    UIBezierPath *headerPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(arcCenterX - 80, 120, 160, 160)];
    [self _setLayer:headerLayer path:headerPath delay:0];
    [self _setAnimation:headerLayer delay:2];
    
    // 鼻子
    CAShapeLayer *noseLayer = [CAShapeLayer layer];
    UIBezierPath *nosePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(KScreenWidth * 0.5, 210) radius:10 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [self _setLayer:noseLayer path:nosePath delay:2 * 1];
    [self _setAnimation:noseLayer delay:2 * 1];
    
    // 脸
    CAShapeLayer *faceLayer = [CAShapeLayer layer];
    UIBezierPath *facePath = [UIBezierPath bezierPath];
    [facePath moveToPoint:CGPointMake(arcCenterX - 80 * sqrt(2.0) / 2, arcCenterY + 80 * sqrt(2.0) / 2)];
    [facePath addCurveToPoint:CGPointMake(arcCenterX - 30, arcCenterY - 20) controlPoint1:CGPointMake(arcCenterX - 80, arcCenterY + 25) controlPoint2:CGPointMake(arcCenterX - 80, arcCenterY - 20)];
    [facePath addLineToPoint:CGPointMake(arcCenterX + 30, arcCenterY - 20)];
    [facePath addCurveToPoint:CGPointMake(arcCenterX+80*sqrt(2.0)/2, arcCenterY+80*sqrt(2.0)/2) controlPoint1:CGPointMake(arcCenterX+80, arcCenterY-20) controlPoint2:CGPointMake(arcCenterX+80, arcCenterY+25)];
    [facePath addQuadCurveToPoint:CGPointMake(arcCenterX-80*sqrt(2.0)/2, arcCenterY+80*sqrt(2.0)/2) controlPoint:CGPointMake(arcCenterX, arcCenterY+105)];
    [self _setLayer:faceLayer path:facePath delay:2 * 2];
    [self _setAnimation:faceLayer delay:2 * 2];
    
    // 左眼
    CAShapeLayer *leftEyeLayer = [CAShapeLayer layer];
    UIBezierPath *leftEyePath = [UIBezierPath bezierPath];
    [leftEyePath moveToPoint:CGPointMake(arcCenterX - 30, arcCenterY - 25)];
    [leftEyePath addQuadCurveToPoint:CGPointMake(arcCenterX-15, arcCenterY-45) controlPoint:CGPointMake(arcCenterX-30, arcCenterY-45)];
    [leftEyePath addQuadCurveToPoint:CGPointMake(arcCenterX, arcCenterY-25) controlPoint:CGPointMake(arcCenterX, arcCenterY-45)];
    [leftEyePath addQuadCurveToPoint:CGPointMake(arcCenterX-15, arcCenterY-5) controlPoint:CGPointMake(arcCenterX, arcCenterY-5)];
    [leftEyePath addQuadCurveToPoint:CGPointMake(arcCenterX-30, arcCenterY-25) controlPoint:CGPointMake(arcCenterX-30, arcCenterY-5)];
    [self _setLayer:leftEyeLayer path:leftEyePath delay:2 * 3];
    [self _setAnimation:leftEyeLayer delay:2 * 3];
    
    // 左眼珠
    CAShapeLayer *leftEyeBallLayer = [CAShapeLayer layer];
    UIBezierPath *leftEyeBallPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arcCenterX - 12, arcCenterY - 30) radius:2.5 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [self _setLayer:leftEyeBallLayer path:leftEyeBallPath delay:2 * 4];
    [self _setAnimation:leftEyeBallLayer delay:2 * 4];
    
    // 右眼
    CAShapeLayer *rightEyeLayer = [CAShapeLayer layer];
    UIBezierPath *rightEyePath = [UIBezierPath bezierPath];
    [rightEyePath moveToPoint:CGPointMake(arcCenterX + 30, arcCenterY - 25)];
    [rightEyePath addQuadCurveToPoint:CGPointMake(arcCenterX + 15, arcCenterY - 45) controlPoint:CGPointMake(arcCenterX + 30, arcCenterY - 45)];
    [rightEyePath addQuadCurveToPoint:CGPointMake(arcCenterX, arcCenterY - 25) controlPoint:CGPointMake(arcCenterX, arcCenterY - 45)];
    [rightEyePath addQuadCurveToPoint:CGPointMake(arcCenterX + 15, arcCenterY - 5) controlPoint:CGPointMake(arcCenterX, arcCenterY - 5)];
    [rightEyePath addQuadCurveToPoint:CGPointMake(arcCenterX + 30, arcCenterY - 25) controlPoint:CGPointMake(arcCenterX + 30, arcCenterY - 5)];
    [self _setLayer:rightEyeLayer path:rightEyePath delay:2 * 5];
    [self _setAnimation:rightEyeLayer delay:2 * 5];
    
    // 右眼珠
    CAShapeLayer *rightEyeBallLayer = [CAShapeLayer layer];
    UIBezierPath *rightEyeBallPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arcCenterX + 12, arcCenterY - 30) radius:2.5 startAngle:0 endAngle:M_PI * 2 clockwise:NO];
    [self _setLayer:rightEyeBallLayer path:rightEyeBallPath delay:2 * 6];
    [self _setAnimation:rightEyeBallLayer delay:2 * 6];
    
    // 嘴巴
    CAShapeLayer *mouthLayer = [CAShapeLayer layer];
    UIBezierPath *mouthPath = [UIBezierPath bezierPath];
    [mouthPath moveToPoint:CGPointMake(arcCenterX - 60, arcCenterY + 25)];
    [mouthPath addQuadCurveToPoint:CGPointMake(arcCenterX + 60, arcCenterY + 25) controlPoint:CGPointMake(arcCenterX, arcCenterY + 90)];
    [self _setLayer:mouthLayer path:mouthPath delay:2 * 6];
    [self _setAnimation:mouthLayer delay:2 * 6];
    
    CAShapeLayer *mouthLayer1 = [CAShapeLayer layer];
    UIBezierPath *mouthPath1 = [UIBezierPath bezierPath];
    [mouthPath1 moveToPoint:CGPointMake(arcCenterX, arcCenterY + 20)];
    [mouthPath1 addLineToPoint:CGPointMake(arcCenterX, arcCenterY + 55)];
    [self _setLayer:mouthLayer1 path:mouthPath1 delay:2 * 7];
    [self _setAnimation:mouthLayer delay:2 * 8];
    
    // 胡子
    [self _setBeardFromPoint:CGPointMake(arcCenterX-50, arcCenterY-5) toPoint:CGPointMake(arcCenterX-15, arcCenterY+10) delay:2 * 8];
    [self _setBeardFromPoint:CGPointMake(arcCenterX-55, arcCenterY+15) toPoint:CGPointMake(arcCenterX-15, arcCenterY+20) delay:2 * 9];
    [self _setBeardFromPoint:CGPointMake(arcCenterX-50, arcCenterY+45) toPoint:CGPointMake(arcCenterX-15, arcCenterY+30) delay:2*10];
    [self _setBeardFromPoint:CGPointMake(arcCenterX+50, arcCenterY-5) toPoint:CGPointMake(arcCenterX+15, arcCenterY+10) delay:2*11];
    [self _setBeardFromPoint:CGPointMake(arcCenterX+55, arcCenterY+15) toPoint:CGPointMake(arcCenterX+15, arcCenterY+20) delay:2*12];
    [self _setBeardFromPoint:CGPointMake(arcCenterX+50, arcCenterY+45) toPoint:CGPointMake(arcCenterX+15, arcCenterY+30) delay:2*13];
    
    // 左胳膊
    CGFloat distanceXToArcCenter = 80*cos(M_PI_2*4/9);
    CGFloat distanceYToArcCenter = 80*sin(M_PI_2*4/9);
    CAShapeLayer *leftArmLayer = [CAShapeLayer layer];
    UIBezierPath *leftArmPath = [UIBezierPath bezierPath];
    [leftArmPath moveToPoint:CGPointMake(arcCenterX - distanceXToArcCenter, arcCenterY + distanceYToArcCenter)];
    [leftArmPath addLineToPoint:CGPointMake(arcCenterX - 95, arcCenterY + 90)];
    [leftArmPath addQuadCurveToPoint:CGPointMake(arcCenterX - 75, arcCenterY + 110) controlPoint:CGPointMake(arcCenterX - 92, arcCenterY + 107)];
    [leftArmPath addLineToPoint:CGPointMake(arcCenterX - distanceXToArcCenter + 1.5, arcCenterY + 95)];
    [self _setLayer:leftArmLayer path:leftArmPath delay:2 * 14];
    [self _setAnimation:leftArmLayer delay:2 * 14];
    
    // 左手
    CAShapeLayer *leftHandLayer = [CAShapeLayer layer];
    UIBezierPath *leftHandPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arcCenterX - 95, arcCenterY + 110) radius:20 startAngle:0 endAngle:M_PI / 2 * 3 clockwise:YES];
    [self _setLayer:leftHandLayer path:leftHandPath delay:2 * 14];
    [self _setAnimation:leftHandLayer delay:2 * 14];
    
    // 右胳膊
    CAShapeLayer *rightArmLayer = [CAShapeLayer layer];
    UIBezierPath *rightArmPath = [UIBezierPath bezierPath];
    [rightArmPath moveToPoint:CGPointMake(arcCenterX + distanceXToArcCenter, arcCenterY + distanceYToArcCenter)];
    [rightArmPath addLineToPoint:CGPointMake(arcCenterX + 95, arcCenterY + 90)];
    [rightArmPath addQuadCurveToPoint:CGPointMake(arcCenterX + 75, arcCenterY + 110) controlPoint:CGPointMake(arcCenterX + 92, arcCenterY + 107)];
    [rightArmPath addLineToPoint:CGPointMake(arcCenterX + distanceXToArcCenter + 1.5, arcCenterY + 95)];
    [self _setLayer:rightArmLayer path:rightArmPath delay:2 * 14];
    [self _setAnimation:rightArmLayer delay:2 * 14];
    
    // 右手
    CAShapeLayer *rightHandLayer = [CAShapeLayer layer];
    UIBezierPath *rightHandPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arcCenterX + 95, arcCenterY + 110) radius:20 startAngle:M_PI * 3 / 2 endAngle:M_PI clockwise:YES];
    [self _setLayer:rightHandLayer path:rightHandPath delay:2 * 14];
    [self _setAnimation:rightHandLayer delay:2 * 14];
    
    // 围巾
    CAShapeLayer *mufflerLayer = [CAShapeLayer layer];
    UIBezierPath *mufflerPath = [UIBezierPath bezierPath];
    [mufflerPath moveToPoint:CGPointMake(arcCenterX - distanceXToArcCenter, arcCenterY + distanceYToArcCenter)];
    [mufflerPath addQuadCurveToPoint:CGPointMake(arcCenterX + distanceXToArcCenter, arcCenterY + distanceYToArcCenter) controlPoint:CGPointMake(arcCenterX, arcCenterY + 109)];
    [mufflerPath addLineToPoint:CGPointMake(arcCenterX + distanceXToArcCenter + 2, arcCenterY + distanceYToArcCenter + 7)];
    [mufflerPath addQuadCurveToPoint:CGPointMake(arcCenterX - distanceXToArcCenter - 2, arcCenterY + distanceYToArcCenter + 7) controlPoint:CGPointMake(arcCenterX, arcCenterY + 115)];
    [mufflerPath closePath];
    [self _setLayer:mufflerLayer path:mufflerPath delay:2 * 15];
    [self _setAnimation:mufflerLayer delay:2 * 15];
    
    // 身体
    CAShapeLayer *bodyLayer = [CAShapeLayer layer];
    UIBezierPath *bodyPath = [UIBezierPath bezierPath];
    [bodyPath moveToPoint:CGPointMake(arcCenterX - distanceXToArcCenter, arcCenterY + distanceYToArcCenter)];
    [bodyPath addQuadCurveToPoint:CGPointMake(arcCenterX - distanceXToArcCenter + 5, arcCenterY + 150) controlPoint:CGPointMake(arcCenterX - distanceXToArcCenter + 2, arcCenterY + 140)];
    [bodyPath addQuadCurveToPoint:CGPointMake(arcCenterX - distanceXToArcCenter + 3, arcCenterY + 170) controlPoint:CGPointMake(arcCenterX - (distanceXToArcCenter + 5) / 2, arcCenterY + 160)];
    [bodyPath addQuadCurveToPoint:CGPointMake(arcCenterX - 8, arcCenterY + 170) controlPoint:CGPointMake(arcCenterX - (distanceXToArcCenter + 5) / 2, arcCenterY + 175)];
    [bodyPath addQuadCurveToPoint:CGPointMake(arcCenterX + 8, arcCenterY + 170) controlPoint:CGPointMake(arcCenterX, arcCenterY + 155)];
    [bodyPath addQuadCurveToPoint:CGPointMake(arcCenterX+distanceXToArcCenter-3, arcCenterY+170) controlPoint:CGPointMake(arcCenterX+(distanceXToArcCenter+5)/2, arcCenterY+175)];
    [bodyPath addQuadCurveToPoint:CGPointMake(arcCenterX+distanceXToArcCenter-5, arcCenterY+150) controlPoint:CGPointMake(arcCenterX+distanceXToArcCenter-2, arcCenterY+160)];
    [bodyPath addQuadCurveToPoint:CGPointMake(arcCenterX+distanceXToArcCenter, arcCenterY+distanceYToArcCenter+8) controlPoint:CGPointMake(arcCenterX+distanceXToArcCenter-2, arcCenterY+140)];
    [bodyPath addQuadCurveToPoint:CGPointMake(arcCenterX-distanceXToArcCenter, arcCenterY+distanceYToArcCenter+7) controlPoint:CGPointMake(arcCenterX, arcCenterY+115)];
    [self _setLayer:bodyLayer path:bodyPath delay:2 * 16];
    [self _setAnimation:bodyLayer delay:2 * 16];
    
    // 左脚
    CAShapeLayer *leftFootlayer = [CAShapeLayer layer];
    UIBezierPath *leftFootPath = [UIBezierPath bezierPath];
    [leftFootPath moveToPoint:CGPointMake(arcCenterX - distanceXToArcCenter + 3, arcCenterY + 170)];
    [leftFootPath addQuadCurveToPoint:CGPointMake(arcCenterX - distanceXToArcCenter + 3, arcCenterY + 195) controlPoint:CGPointMake(arcCenterX - distanceXToArcCenter - 20, arcCenterY + 185)];
    [leftFootPath addQuadCurveToPoint:CGPointMake(arcCenterX - 13 , arcCenterY + 195) controlPoint:CGPointMake(arcCenterX - (distanceXToArcCenter + 10) / 2, arcCenterY + 200)];
    [leftFootPath addQuadCurveToPoint:CGPointMake(arcCenterX - 10, arcCenterY + 170) controlPoint:CGPointMake(arcCenterX + 8, arcCenterY + 187)];
    [self _setLayer:leftFootlayer path:leftFootPath delay:2 * 17];
    [self _setAnimation:leftFootlayer delay:2 * 17];
    
    // 右脚
    CAShapeLayer *rightFootlayer = [CAShapeLayer layer];
    UIBezierPath *rightFootPath = [UIBezierPath bezierPath];
    [rightFootPath moveToPoint:CGPointMake(arcCenterX + 10, arcCenterY + 170)];
    [rightFootPath addQuadCurveToPoint:CGPointMake(arcCenterX + 15, arcCenterY + 195) controlPoint:CGPointMake(arcCenterX - 12, arcCenterY + 185)];
    [rightFootPath addQuadCurveToPoint:CGPointMake(arcCenterX + distanceXToArcCenter - 5, arcCenterY + 195) controlPoint:CGPointMake(arcCenterX+(distanceXToArcCenter+20)/2, arcCenterY + 200)];
    [rightFootPath addQuadCurveToPoint:CGPointMake(arcCenterX + distanceXToArcCenter - 3, arcCenterY + 170) controlPoint:CGPointMake(arcCenterX + distanceXToArcCenter + 18, arcCenterY + 185)];
    [self _setLayer:rightFootlayer path:rightFootPath delay:2 * 18];
    [self _setAnimation:rightFootlayer delay:2 * 18];
    
    // 肚子
    CAShapeLayer *belLayer = [CAShapeLayer layer];
    UIBezierPath *belPath = [UIBezierPath bezierPath];
    [belPath moveToPoint:CGPointMake(arcCenterX - 30, arcCenterY + 80)];
    [belPath addCurveToPoint:CGPointMake(arcCenterX - 30, arcCenterY + 150) controlPoint1:CGPointMake(arcCenterX - 65, arcCenterY + 95) controlPoint2:CGPointMake(arcCenterX - 60, arcCenterY + 140)];
    [belPath addQuadCurveToPoint:CGPointMake(arcCenterX + 30, arcCenterY + 150) controlPoint:CGPointMake(arcCenterX, arcCenterY + 160)];
    [belPath addCurveToPoint:CGPointMake(arcCenterX + 30, arcCenterY + 80) controlPoint1:CGPointMake(arcCenterX + 60, arcCenterY + 140) controlPoint2:CGPointMake(arcCenterX + 65, arcCenterY + 95)];
    [belPath addQuadCurveToPoint:CGPointMake(arcCenterX - 30, arcCenterY + 80) controlPoint:CGPointMake(arcCenterX, arcCenterY + 92)];
    [self _setLayer:belLayer path:belPath delay:2 * 19];
    [self _setAnimation:belLayer delay:2 * 19];
    
    // 铃铛
    CAShapeLayer *bellLayer = [CAShapeLayer layer];
    UIBezierPath *bellPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arcCenterX, arcCenterY + 97) radius:15 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [self _setLayer:bellLayer path:bellPath delay:2 * 20];
    [self _setAnimation:bellLayer delay:2 * 19];
    
    // 铃铛上的线
    CAShapeLayer *bellLineLayer = [CAShapeLayer layer];
    UIBezierPath *bellLinePath = [UIBezierPath bezierPath];
    [bellLinePath moveToPoint:CGPointMake(arcCenterX - (sqrt(pow(15.0, 2) - pow(5.0, 2))), arcCenterY + 92)];
    [bellLinePath addLineToPoint:CGPointMake(arcCenterX - (sqrt(pow(15.0, 2) - pow(5.0, 2))), arcCenterY + 92)];
    [bellLinePath moveToPoint:CGPointMake(arcCenterX + (sqrt(pow(15.0, 2) - pow(2.0, 2))), arcCenterY+95)];
    [bellLinePath addLineToPoint:CGPointMake(arcCenterX - (sqrt(pow(15.0, 2) - pow(2.0, 2))), arcCenterY+95)];
    [self _setLayer:bellLineLayer path:bellLinePath delay:2 * 20];
    [self _setAnimation:bellLineLayer delay:2 * 20];
    
    // 铃铛上的圆点
    CAShapeLayer *bellCirLayer = [CAShapeLayer layer];
    UIBezierPath *bellCirPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arcCenterX, arcCenterY + 102) radius:2.5 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [bellCirPath moveToPoint:CGPointMake(arcCenterX, arcCenterY + 104.5)];
    [bellCirPath addLineToPoint:CGPointMake(arcCenterX, arcCenterY + 112)];
    [self _setLayer:bellCirLayer path:bellCirPath delay:2 * 20];
    [self _setAnimation:bellCirLayer delay:2 * 20];
    
    // 口袋
    CAShapeLayer *bagLayer = [CAShapeLayer layer];
    UIBezierPath *bagPath = [UIBezierPath bezierPath];
    [bagPath moveToPoint:CGPointMake(arcCenterX - 40, arcCenterY + 112)];
    [bagPath addQuadCurveToPoint:CGPointMake(arcCenterX + 40, arcCenterY + 112) controlPoint:CGPointMake(arcCenterX, arcCenterY + 120)];
    [bagPath addCurveToPoint:CGPointMake(arcCenterX - 40, arcCenterY + 112) controlPoint1:CGPointMake(arcCenterX + 28, arcCenterY + 160) controlPoint2:CGPointMake(arcCenterX - 28, arcCenterY + 160)];
    [self _setLayer:bagLayer path:bagPath delay:2 * 21];
    [self _setAnimation:bagLayer delay:2 * 21];
    
    //上色
    [self _setLayerColor:headerLayer color:[UIColor colorWithRed:21/255.0 green:159/255.0 blue:237/255.0 alpha:1] delay:2*1];
    [self _setLayerColor:noseLayer color:[UIColor redColor] delay:2 * 1];
    [self _setLayerColor:faceLayer color:[UIColor whiteColor] delay:2 * 1];
    [self _setLayerColor:leftEyeLayer color:[UIColor whiteColor] delay:2 * 1];
    [self _setLayerColor:leftEyeBallLayer color:[UIColor blackColor] delay:2 * 1];
    [self _setLayerColor:rightEyeLayer color:[UIColor whiteColor] delay:2 * 1];
    [self _setLayerColor:rightEyeBallLayer color:[UIColor blackColor] delay:2 * 1];
    [self _setLayerColor:leftArmLayer color:[UIColor colorWithRed:21/255.0 green:159/255.0 blue:237/255.0 alpha:1] delay:2*1];
    [self _setLayerColor:leftHandLayer color:[UIColor whiteColor] delay:2*1];
    [self _setLayerColor:rightHandLayer color:[UIColor whiteColor] delay:2*1];
    [self _setLayerColor:rightArmLayer color:[UIColor colorWithRed:21/255.0 green:159/255.0 blue:237/255.0 alpha:1] delay:2*1];
    [self _setLayerColor:mufflerLayer color:[UIColor redColor] delay:2*1];
    [self _setLayerColor:bodyLayer color:[UIColor colorWithRed:21/255.0 green:159/255.0 blue:237/255.0 alpha:1] delay:2*1];
    [self _setLayerColor:belLayer color:[UIColor whiteColor] delay:2*1];
    [self _setLayerColor:bellLayer color:[UIColor yellowColor] delay:2*1];
    [self _setLayerColor:bagLayer color:[UIColor whiteColor] delay:2 * 1];
    
    
    /*
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 200)];
    [path addQuadCurveToPoint:CGPointMake(355, 200) controlPoint:CGPointMake(375 * 0.5f, 120)];
    [path addLineToPoint:CGPointMake(355, 300)];
    [path addLineToPoint:CGPointMake(20, 300)];
    [path closePath];
    path.lineWidth = 5.f;
    layer.fillColor = [[UIColor redColor] CGColor];
    layer.path = path.CGPath;
    */
    
    /*
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 200)];
    [path addCurveToPoint:CGPointMake(350, 300) controlPoint1:CGPointMake(180, 140) controlPoint2:CGPointMake(280, 440)];
    path.lineWidth = 5;
    layer.path = path.CGPath;
    
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(95, 195, 10, 10);
    layer1.backgroundColor = [[UIColor redColor] CGColor];
    [layer addSublayer:layer1];
    
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(345, 295, 10, 10);
    layer2.backgroundColor = [[UIColor redColor] CGColor];
    [layer addSublayer:layer2];
    
    CALayer *layer3 = [CALayer layer];
    layer3.frame = CGRectMake(175, 135, 10, 10);
    layer3.backgroundColor = [[UIColor redColor] CGColor];
    [layer addSublayer:layer3];
    
    CALayer *layer4 = [CALayer layer];
    layer4.frame = CGRectMake(275, 435, 10, 10);
    layer4.backgroundColor = [UIColor redColor].CGColor;
    [layer addSublayer:layer4];
    */
    
    /*
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(60, 120)];
    [path addQuadCurveToPoint:CGPointMake(230, 120) controlPoint:CGPointMake(150, 300)];
    path.lineWidth = 5.f;
    layer.path = path.CGPath;
     */
    
    /*
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 120)];
    [path addLineToPoint:CGPointMake(150, 230)];
    [path addLineToPoint:CGPointMake(230, 230)];
    [path addArcWithCenter:CGPointMake(200, 230) radius:120 startAngle:0 endAngle:M_PI clockwise:YES];
    path.lineWidth = 4.f;
    layer.path = path.CGPath;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anim.fromValue = @(0);
    anim.toValue = @(1);
    anim.duration = 5.f;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    [layer addAnimation:anim forKey:nil];
     */
    
    /*
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(KScreenWidth * 0.5, 350) radius:100 startAngle:M_PI endAngle:M_PI * 0.5 clockwise:NO];
    path.lineWidth = 3.f;
    layer.path = path.CGPath;
    */
    /*
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 120, 254, 254) byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(50, 50)];
    path.lineWidth = 4.f;
    layer.path = path.CGPath;
    layer.fillColor = [[UIColor greenColor] CGColor];
    */
    
    /*
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 100, 200, 200) cornerRadius:20];
    path.lineWidth = 4.f;
    layer.path = path.CGPath;
    */
    
    /*
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(20, KNavAndStatusHeight + 50, 200, 200)];
    path.lineWidth = 20.f;
    layer.path = path.CGPath;
    */
    
    /*
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, KNavAndStatusHeight + 50, 200, 360)];
    path.lineWidth = 4.f;
    layer.path = [path CGPath];
    [path closePath];
    */
    
    /*
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(10, KNavAndStatusHeight + 20)];
    [path1 addLineToPoint:CGPointMake(200, 350)];
    [path1 addLineToPoint:CGPointMake(10, 700)];
    [path1 closePath];
    path1.lineWidth = 60.f;
    path1.lineCapStyle = kCGLineCapRound;
    layer.strokeColor = [[UIColor blackColor] CGColor];
    layer.fillColor = nil;
    layer.path = [path1 CGPath];
    [self.view.layer addSublayer:layer];
     */
    
}

- (void)_setLayerColor:(CAShapeLayer *)layer color:(UIColor *)color delay:(NSTimeInterval)delay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(42 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        layer.fillColor = color.CGColor;
    });
}

- (void)_setBeardFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint delay:(NSTimeInterval)timeInterval{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:fromPoint];
    [path addLineToPoint:toPoint];
    [self _setLayer:layer path:path delay:timeInterval];
    [self _setAnimation:layer delay:timeInterval];
}

- (void)_setLayer:(CAShapeLayer *)layer path:(UIBezierPath *)path delay:(NSTimeInterval)timeInterVal {
    layer.path = path.CGPath;
    layer.fillColor = [[UIColor clearColor] CGColor];
    layer.strokeColor = [[UIColor blackColor] CGColor];
//    [self.view.layer addSublayer:layer];
}

- (void)_setAnimation:(CAShapeLayer *)layer delay:(NSTimeInterval)delay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        anim.fromValue = @(1);
        anim.toValue = @(0);
        anim.duration = 2;
        anim.fillMode = kCAFillModeForwards;
        anim.removedOnCompletion = NO;
        [layer addAnimation:anim forKey:nil];
        [self.view.layer addSublayer:layer];
    });
}

- (void)yl_initValues {
    [super yl_initValues];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
    self.array = array;
    [self.array removeObjectAtIndex:0];
    KLog(@"%@", array);
    KLog(@"%@", self.array);
    
    Son *s = [[Son alloc] init];
}

@end

@implementation Father

@end

@implementation Son

- (instancetype)init {
    if (self = [super init]) {
        KLog(@"%@", NSStringFromClass([self class]));
        KLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}

@end
