//
//  KQRCodeController.m
//  DYLTool
//
//  Created by sky on 2018/8/6.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "KQRCodeController.h"
#import <AVFoundation/AVFoundation.h>

#define KQRCodeWidth 260 * (KScreenWidth / 375.f)  // 正方形二维码边长
#define KScanIMG_H 241

@interface KQRCodeController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;

@end

@implementation KQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupMaskView];
    [self _setupScanWindowView];
    [self beginScaning];
}

- (void)yl_initValues {
    [super yl_initValues];
}

- (void)yl_initViews {
    [super yl_initViews];
}

- (void)_setupMaskView {
    // 设置统一的视图颜色和视图透明度
    UIColor *color = [UIColor blackColor];
    float alpha = 0.7;
    
    // 设置扫描区域外部的上部的视图
    UIView *topView = [[UIView alloc] init];
    topView.frame = CGRectMake(0, KNavAndStatusHeight, KScreenWidth, (KScreenHeight - KNavAndStatusHeight - KQRCodeWidth) / 2.f);
    topView.backgroundColor = color;
    topView.alpha = alpha;
    
    // 设置扫描区域外部左边的视图
    UIView *leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(0, KNavAndStatusHeight + topView.yl_height, (KScreenWidth - KQRCodeWidth) / 2.f, KQRCodeWidth);
    leftView.backgroundColor = color;
    leftView.alpha = alpha;
    
    // 设置扫描区域外部右边视图
    UIView *rightView = [[UIView alloc] init];
    rightView.frame = CGRectMake((KScreenWidth - KQRCodeWidth) / 2.f + KQRCodeWidth, KNavAndStatusHeight + topView.yl_height, (KScreenWidth - KQRCodeWidth) / 2.f, KQRCodeWidth);
    rightView.backgroundColor = color;
    rightView.alpha = alpha;
    
    // 设置扫描区域外部底部视图
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0, KNavAndStatusHeight + topView.yl_height + KQRCodeWidth, KScreenWidth, KScreenHeight - KNavAndStatusHeight - topView.yl_height - KQRCodeWidth);
    bottomView.backgroundColor = color;
    bottomView.alpha = alpha;
    
    // 将设置好的扫描二维码区域以外的视图添加到视图层上
    [self.view addSubview:topView];
    [self.view addSubview:leftView];
    [self.view addSubview:rightView];
    [self.view addSubview:bottomView];
}

- (void)_setupScanWindowView {
    // 设置扫描区域的位置
    UIView *scanWindow = [[UIView alloc] initWithFrame:CGRectMake((KScreenWidth - KQRCodeWidth) / 2.f, (KScreenHeight - KQRCodeWidth - KNavAndStatusHeight) / 2.f + KNavAndStatusHeight, KQRCodeWidth, KQRCodeWidth)];
    scanWindow.clipsToBounds = YES;
    [self.view addSubview:scanWindow];
    
    // 设置扫描区域动画效果
    CGFloat scanNetImageViewH = KScanIMG_H;
    CGFloat scanNetImageViewW = scanWindow.frame.size.width;
    UIImageView *scanNetImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_center"]];
    scanNetImageView.frame = CGRectMake(0, -scanNetImageViewH, scanNetImageViewW, scanNetImageViewH);
    CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
    scanNetAnimation.keyPath = @"transform.translation.y";
    scanNetAnimation.byValue = @(KQRCodeWidth);
    scanNetAnimation.duration = 1.0;
    scanNetAnimation.repeatCount = MAXFLOAT;
    [scanNetImageView.layer addAnimation:scanNetAnimation forKey:nil];
    [scanWindow addSubview:scanNetImageView];
    
    // 设置扫描区域四个角的边框
    CGFloat buttonWH = 18;
    UIButton *topLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    topLeft.frame = CGRectMake(0, 0, buttonWH, buttonWH);
    [topLeft setImage:[UIImage imageNamed:@"scan_left_top"] forState:UIControlStateNormal];
    [scanWindow addSubview:topLeft];
    
    UIButton *topRight = [UIButton buttonWithType:UIButtonTypeCustom];
    topRight.frame = CGRectMake(KQRCodeWidth - buttonWH, 0, buttonWH, buttonWH);
    [topRight setImage:[UIImage imageNamed:@"scan_right_top"] forState:UIControlStateNormal];
    [scanWindow addSubview:topRight];
    
    UIButton *bottomLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomLeft.frame = CGRectMake(0, KQRCodeWidth - buttonWH, buttonWH, buttonWH);
    [bottomLeft setImage:[UIImage imageNamed:@"scan_left_bottom"] forState:UIControlStateNormal];
    [scanWindow addSubview:bottomLeft];
    
    UIButton *bottomRight = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomRight.frame = CGRectMake(KQRCodeWidth - buttonWH, KQRCodeWidth - buttonWH, buttonWH, buttonWH);
    [bottomRight setImage:[UIImage imageNamed:@"scan_right_bottom"] forState:UIControlStateNormal];
    [scanWindow addSubview:bottomRight];
}

- (void)beginScaning {
    // 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!input) {
        return;
    }
    // 创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    CGFloat x = (KScreenHeight - KQRCodeWidth - KNavAndStatusHeight) / 2.f / KScreenHeight;
    CGFloat y = (KScreenWidth - KQRCodeWidth) / 2.f / KScreenWidth;
    CGFloat width = KQRCodeWidth / KScreenHeight;
    CGFloat height = KQRCodeWidth / KScreenWidth;
    output.rectOfInterest = CGRectMake(x, y, width, height);
    
    // 设置代理在主线程刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // 初始化链接对象
    _session = [[AVCaptureSession alloc] init];
    // 高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    [_session addInput:input];
    [_session addOutput:output];
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    // 开始捕获
    [_session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        [_session stopRunning];
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"scanSuccess.wav" withExtension:nil];
        // 加载音效文件,重建音效ID(SoundId, 一个ID对应一个音效文件)
        SystemSoundID soundID = 8787;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        // 播放音效文件
        AudioServicesPlayAlertSound(soundID);
        AudioServicesPlaySystemSound(soundID);
        // 得到二维码数据
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        NSString *str = [metadataObject stringValue];
        KLog(@"%@", str);
    }
}



@end
