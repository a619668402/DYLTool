//
//  TestInputViewController.m
//  DYLTool
//
//  Created by sky on 2018/7/31.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestInputViewController.h"
#import "YLInputView.h"

@interface TestInputViewController ()<YLInputViewDelegate>

@property (nonatomic, strong) YLInputView *inputView;

@end

@implementation TestInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, KNavAndStatusHeight, 50, 30);
    btn.layer.backgroundColor = [UIColor blackColor].CGColor;
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self createInputView];
}


- (void)click {
    [self.inputView.textInput becomeFirstResponder];
}

- (void)createInputView {
    self.inputView = [[YLInputView alloc] initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, 50)];
    self.inputView.textViewMaxLine = 4;
    self.inputView.delegate = self;
    self.inputView.placeholderLabel.text = @"请输入......";
    [self.view addSubview:self.inputView];
}

- (void)yl_inputView:(YLInputView *)inputView inputContent:(NSString *)sendContent {
    [self.inputView.textInput resignFirstResponder];
    KLog(@"-------%@", sendContent);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.inputView.textInput resignFirstResponder];
}

@end
