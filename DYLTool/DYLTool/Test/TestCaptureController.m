//
//  TestCaptureController.m
//  DYLTool
//
//  Created by sky on 2019/3/5.
//  Copyright © 2019年 DYL. All rights reserved.
//

#import "TestCaptureController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface TestCaptureController ()

@property (nonatomic, strong) AVCaptureSession *captureSession;
/// 预览Layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
/// 采集设备
@property (nonatomic, strong) AVCaptureDevice *device;
/// 输入流
@property (nonatomic, strong) AVCaptureDeviceInput *input;
/// 输出流
@property (nonatomic, strong) AVCaptureStillImageOutput *output;

@property (nonatomic, strong) AVCaptureConnection *connection;

@end

@implementation TestCaptureController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)yl_initViews {
    [super yl_initViews];
}

- (void)yl_initValues {
    [super yl_initValues];
    self.captureSession = [[AVCaptureSession alloc] init];
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        if ([self.device lockForConfiguration:nil]) {
            self.device.focusMode = AVCaptureFocusModeAutoFocus;
            [self.device unlockForConfiguration];
        }
    }
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    if ([self.captureSession canAddInput:self.input]) {
        [self.captureSession addInput:self.input];
    }
    self.output = [[AVCaptureStillImageOutput alloc] init];
    if ([self.captureSession canAddOutput:self.output]) {
        [self.captureSession addOutput:self.output];
    }
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    self.previewLayer.frame = self.view.bounds;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    [self.captureSession startRunning];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(10, KNavAndStatusHeight, 50, 50);
    btn1.backgroundColor = red_color;
    [btn1 addTarget:self action:@selector(_btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(KScreenWidth - 60, KNavAndStatusHeight, 50, 50);
    btn2.backgroundColor = red_color;
    [btn2 addTarget:self action:@selector(_btn2Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)_btn1Click:(UIButton *)btn {
    CGFloat temp = self.device.videoZoomFactor;
    [self setZoomValue:temp --];
}

- (void)_btn2Click:(UIButton *)btn {
    CGFloat temp = self.device.videoZoomFactor;
    [self setZoomValue:temp++];
}

- (CGFloat)maxZoomFactor {
    return MIN(self.device.activeFormat.videoMaxZoomFactor, 4.0f);
}

- (void)setZoomValue:(CGFloat)zoomValue {
    if (!self.device.isRampingVideoZoom) {
        if ([self.device lockForConfiguration:nil]) {
            CGFloat zoomFactor = MIN([self maxZoomFactor], zoomValue <= 0 ? 1 : zoomValue);
            self.device.videoZoomFactor = zoomFactor;
            [self.device unlockForConfiguration];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint location = [touch locationInView:self.view];
//    if (self.device.isFocusPointOfInterestSupported && [self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
//        if ([self.device lockForConfiguration:nil]) {
//            self.device.focusPointOfInterest = location;
//            self.device.focusMode = AVCaptureFocusModeAutoFocus;
//            [self.device unlockForConfiguration];
//        }
//    }
    /* 打开闪光灯
    if ([self flashMode] == AVCaptureFlashModeOn) {
        [self setFlashMode:AVCaptureFlashModeOff];
    } else {
        [self setFlashMode:AVCaptureFlashModeOn];
    }
     */
    
    /* 打开手电筒
    if ([self torchMode] == AVCaptureTorchModeOn) {
        [self setTorchModel:AVCaptureTorchModeOff];
    } else {
        [self setTorchModel:AVCaptureTorchModeOn];
    }
     */
    
//    [self captureStillImage];
}

- (BOOL)cameraHasFlash {
    return [self.device hasFlash];
}

- (AVCaptureFlashMode)flashMode {
    return [self.device flashMode];
}

- (AVCaptureTorchMode)torchMode {
    return [self.device torchMode];
}

- (void)setTorchModel:(AVCaptureTorchMode)torchMode {
    if ([self.device isTorchModeSupported:torchMode]) {
        if ([self.device lockForConfiguration:nil]) {
            self.device.torchMode = torchMode;
            [self.device unlockForConfiguration];
        }
    }
}

- (void)setFlashMode:(AVCaptureFlashMode)flashMode {
    if ([self.device isFlashModeSupported:flashMode]) {
        if ([self.device lockForConfiguration:nil]) {
            self.device.flashMode = flashMode;
            [self.device unlockForConfiguration];
        }
    }
}

- (void)captureStillImage {
    self.connection = [self.output connectionWithMediaType:AVMediaTypeVideo];
    if (self.connection.isVideoOrientationSupported) {
        self.connection.videoOrientation = [self currentVideoOrientation];
    }
    
    [self.output captureStillImageAsynchronouslyFromConnection:self.connection completionHandler:^(CMSampleBufferRef  _Nullable imageDataSampleBuffer, NSError * _Nullable error) {
        if (imageDataSampleBuffer != NULL) {
            NSData *imgData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [[UIImage alloc] initWithData:imgData];
            [self writeImageToAssetsLibrary:image];
        } else {
            KLog(@"failure------------");
        }
    }];
}

- (void)writeImageToAssetsLibrary:(UIImage *)image {
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:image.CGImage orientation:(NSUInteger)image.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {
        if (!error) {
            KLog(@"----success----");
        }
    }];
}

- (AVCaptureVideoOrientation)currentVideoOrientation {
    AVCaptureVideoOrientation orientation;
    switch ([UIDevice currentDevice].orientation) {
        case UIDeviceOrientationPortrait:
            orientation = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationLandscapeLeft:
            orientation = AVCaptureVideoOrientationLandscapeLeft;
            break;
        case UIDeviceOrientationLandscapeRight:
            orientation = AVCaptureVideoOrientationLandscapeRight;
            break;
        default:
            orientation = AVCaptureVideoOrientationLandscapeRight;
            break;
    }
    return orientation;
}

@end
