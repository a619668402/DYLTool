//
//  TestTZImagePickerController.m
//  DYLTool
//
//  Created by sky on 2018/7/27.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestTZImagePickerController.h"
#import <TZImagePickerController.h>
#import <RSKImageCropper.h>

@interface TestTZImagePickerController ()<TZImagePickerControllerDelegate, RSKImageCropViewControllerDelegate>

@property (nonatomic, strong) UIImageView *img;

@end

@implementation TestTZImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(4, KNavAndStatusHeight, KScreenWidth - 8, 50)];
    tf.layer.backgroundColor = [gray_color CGColor];
    tf.layer.cornerRadius = 4.f;
    [tf yl_limitMaxLength:10];
    [self.view addSubview:tf];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, KNavAndStatusHeight + 200, 100, 40);
    btn.backgroundColor = black_color;
    [btn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn yl_setCorner:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    [self.view addSubview:btn];
    
    self.img = [[UIImageView alloc] initWithFrame:CGRectMake(0, btn.yl_y + btn.yl_height, KScreenWidth, KScreenWidth)];
//    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.contentMode = UIViewContentModeScaleAspectFit;
    _img.layer.cornerRadius = KScreenWidth / 2.f;
    _img.layer.masksToBounds = YES;
    [self.view addSubview:self.img];
}

- (void)_btnClick:(UIButton *)btn {
    TZImagePickerController *vc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [vc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        RSKImageCropViewController *cropViewController = [[RSKImageCropViewController alloc] initWithImage:photos[0] cropMode:RSKImageCropModeCircle];
        cropViewController.delegate = self;
//        cropViewController.dataSource = self;
        [self.navigationController pushViewController:cropViewController animated:YES];
    }];
    
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect rotationAngle:(CGFloat)rotationAngle {
    [self.navigationController popViewControllerAnimated:YES];
    self.img.image = croppedImage;
}

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
