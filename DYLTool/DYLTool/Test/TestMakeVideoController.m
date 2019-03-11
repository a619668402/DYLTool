//
//  TestMakeVideoController.m
//  DYLTool
//
//  Created by sky on 2019/2/21.
//  Copyright © 2019年 DYL. All rights reserved.
//

#import "TestMakeVideoController.h"

@interface TestMakeVideoController ()<CAAnimationDelegate>

@property (nonatomic, strong, readwrite) UIView *recoderView;

@property (nonatomic, strong, readwrite) UIButton *startBtn;

@property (nonatomic, strong, readwrite) UIButton *stopBtn;

@property (nonatomic, strong, readwrite) UIButton *makeBtn;

@property (nonatomic, strong, readwrite) CADisplayLink *timer;

@property (nonatomic, strong, readwrite) NSMutableArray *layerArray;

@property (nonatomic, assign, readwrite) NSInteger index;

@end

@implementation TestMakeVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)yl_initViews {
    [super yl_initViews];
    
    self.recoderView = [[UIView alloc] initWithFrame:CGRectMake(0, KNavAndStatusHeight, KScreenWidth, 300)];
    self.recoderView.backgroundColor = black_color;
    [self.view addSubview:self.recoderView];
    
    CATextLayer *layer1 = [self makeTextLayerWithStr:@"测试第一个"];
    CATextLayer *layer2 = [self makeTextLayerWithStr:@"测试第二个1111"];
    /*
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration = 1;
    anim.delegate = self;
    anim.repeatCount = 1;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.fromValue = @(0.1);
    anim.toValue = @(1.5);
     */
    layer1.bounds = CGRectMake(0, 0, 150, 30);
    [layer1 addAnimation:[self scaleAnimation] forKey:@""];
    [self.recoderView.layer addSublayer:layer1];
    [self.recoderView.layer addSublayer:layer2];
    [self.layerArray addObject:layer1];
    [self.layerArray addObject:layer2];
    /*
    self.startBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.startBtn.frame = CGRectMake((KScreenWidth - 100) / 2, 320 + KNavAndStatusHeight, 100, 40);
    [self.startBtn setTitle:@"Start" forState:UIControlStateNormal];
    [self.startBtn addTarget:self action:@selector(startBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startBtn];
    
    self.stopBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.stopBtn.frame = CGRectMake((KScreenWidth - 100) / 2, 370 + KNavAndStatusHeight, 100, 40);
    [self.stopBtn setTitle:@"Stop" forState:UIControlStateNormal];
    [self.stopBtn addTarget:self action:@selector(stopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.stopBtn];
    
    self.makeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.makeBtn.frame = CGRectMake((KScreenWidth - 100) / 2, 420 + KNavAndStatusHeight, 100, 40);
    [self.makeBtn setTitle:@"Make" forState:UIControlStateNormal];
    [self.makeBtn addTarget:self action:@selector(makeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.makeBtn];
     */
}

- (void)yl_initValues {
    [super yl_initValues];
    self.layerArray = [NSMutableArray array];
    self.index = 1;
    /*
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(_shotImage)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    if (@available(iOS 10.0, *)) {
        [self.timer setPreferredFramesPerSecond:15];
    } else {
    }
    [self.timer setPaused:YES];
     */
}

#pragma mark ----- CABasicAnimation -----
- (CABasicAnimation *)scaleAnimation {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration = 1;
    anim.delegate = self;
    anim.repeatCount = 1;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.fromValue = @(0.1);
    anim.toValue = @(1.5);
    return anim;
}

- (CABasicAnimation *)translateAnimationWithValue:(NSNumber *)value {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.y"];
    anim.duration = 0.5;
    anim.repeatCount = 1;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.toValue = value;
    return anim;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        for (int i = 0; i < self.index; i ++) {
            if (i >= self.layerArray.count) {
                continue;
            }
            CATextLayer *layer = self.layerArray[i];
            [layer addAnimation:[self translateAnimationWithValue:@(layer.position.y - 40)] forKey:@""];
        }
        
        for (int i = self.index; i < self.layerArray.count; i ++) {
            if (i >= self.layerArray.count) {
                continue;
            }
            CATextLayer *layer = self.layerArray[i];
            layer.bounds = CGRectMake(0, 0, 150, 30);
            [layer addAnimation:[self scaleAnimation] forKey:@""];
        }
        self.index ++;
        
        /*
        CATextLayer *layer = self.layerArray[0];
        [layer addAnimation:[self translateAnimationWithValue:@(layer.position.y - 40)] forKey:@""];
        CATextLayer *layer1 = self.layerArray[1];
        [layer1 addAnimation:[self scaleAnimation] forKey:@""];
         */
    }
}

#pragma mark ----- Create CATextLayer -----
- (CATextLayer *)makeTextLayerWithStr:(NSString *)str {
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.string = str;
    textLayer.fontSize = 12.f;
    textLayer.position = CGPointMake(100, 260);
    textLayer.anchorPoint = CGPointMake(0, 1);
    return textLayer;
}

#pragma mark
- (void)startBtnClick:(UIButton *)btn {
//    [self.timer setPaused:NO];
    
}

- (void)stopBtnClick:(UIButton *)btn {
    [self.timer setPaused:YES];
}

- (void)makeBtnClick:(UIButton *)btn {
    
}

- (void)_shotImage {
    UIImage *image = [UIImage yl_screenShotImageFromView:self.recoderView];
    NSData *data = UIImageJPEGRepresentation(image, 5);
    [self makeDir];
    [KFileManager yl_writeDataToFile:KStringWithFormat(@"/shopImg/%@.png", [self getNowTimeTimestamp]) data:data];
}

- (void)makeDir {
    BOOL flag = [KFileManager yl_isDirExist:KStringWithFormat(@"%@/shopImg", [KFileManager yl_getDocumentPath])];
    if (!flag) {
        [KFileManager yl_createDir:KStringWithFormat(@"%@/shopImg", [KFileManager yl_getDocumentPath])];
    }
}

- (NSString *)getNowTimeTimestamp {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

@end
