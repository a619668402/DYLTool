//
//  TestMetalController.m
//  DYLTool
//
//  Created by sky on 2019/2/27.
//  Copyright © 2019年 DYL. All rights reserved.
//

#import "TestMetalController.h"
#import <MetalKit/MetalKit.h>


@interface TestMetalController ()

@property (nonatomic, weak) id<MTLCommandQueue> commandQueue;

@property (nonatomic, weak) id<MTLRenderPipelineState> rps;

@property (nonatomic, weak) id<MTLBuffer> vertexBuffer;

@property (nonatomic, strong) CALayer *layer;



@end

@implementation TestMetalController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.layer = [CALayer layer];
    self.layer.backgroundColor = green_color.CGColor;
    self.layer.frame = CGRectMake(0, KNavAndStatusHeight, KScreenWidth, 50);
    [self.view.layer addSublayer:self.layer];
    [self.layer setValue:@"111" forKey:@"aaa"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 30);
    btn.center = self.view.center;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:@"Test" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(100, KNavAndStatusHeight + 80, 60, 60)];
    shadowView.backgroundColor = green_color;
    shadowView.layer.cornerRadius = 10.f;
    shadowView.layer.shadowColor = red_color.CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(5, 5);
    shadowView.layer.shadowOpacity = 0.5f;
    shadowView.layer.shadowRadius = 10.f;
    [self.view addSubview:shadowView];
}


- (void)_btnClick:(UIButton *)btn {
    NSString *str = [self.layer valueForKey:@"aaa"];
    NSLog(@"-------%@----------", str);
}


@end
