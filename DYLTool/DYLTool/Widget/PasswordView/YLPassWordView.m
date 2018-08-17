//
//  YLPassWordView.m
//  DYLTool
//
//  Created by sky on 2018/8/17.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLPassWordView.h"
// 密码点大小
#define KDotSize CGSizeMake(10,10)
// 密码个数
#define KDotCount 6
@interface YLPassWordView ()<UITextFieldDelegate>
/// 密码输入框
@property (nonatomic, strong, readwrite) UITextField *pswTf;
/// 存放加密黑色点
@property (nonatomic, strong, readwrite) NSMutableArray *dotArr;
@end

@implementation YLPassWordView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _initValues];
        [self _initViews];
    }
    return self;
}

- (void)_initValues {
    self.backgroundColor = [UIColor whiteColor];
}

- (void)_initViews {
    [self addSubview:self.pswTf];
    [self _setupWithTextField];
}

#pragma mark ************* UITextField Delegate Start *************
- (void)textFieldDidChange:(UITextField *)textField {
    for (UIView *dotView in self.dotArr) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i ++) {
        ((UIView *)[self.dotArr objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == KDotCount) {
        KLog(@"----输入完毕----");
        [self.pswTf resignFirstResponder];
    }
    KLog(@"%@", textField.text);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    KLog(@"----输入变化----");
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    } else if (string.length == 0) {
        return YES;
    } else if (textField.text.length >= KDotCount) {
        return NO;
    } else {
        return YES;
    }
}
#pragma mark ************* UITextField Delegate End   *************

- (void)clearUpPassword {
    [self.pswTf resignFirstResponder];
    self.pswTf.text = nil;
    [self textFieldDidChange:self.pswTf];
}

#pragma mark ************* Private Method Start *************
- (void)_setupWithTextField {
    CGFloat width = self.yl_width / KDotCount;
    // 生成分割线
    for (int i = 0; i < KDotCount; i ++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.pswTf.frame) + (i + 1) * width, 0, 1, self.yl_height)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
    }
    self.dotArr = [NSMutableArray array];
    // 生成中间黑点
    for (int i = 0; i < KDotCount; i ++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.pswTf.frame) + (width - KDotCount) / 2 + i * width, CGRectGetMinY(self.pswTf.frame) + (self.yl_height - KDotSize.height) / 2, KDotSize.width, KDotSize.height)];
        dotView.layer.backgroundColor = [[UIColor blackColor] CGColor];
        dotView.layer.cornerRadius = KDotSize.width / 2.f;
        dotView.hidden = YES;
        [self addSubview:dotView];
        
        [self.dotArr addObject:dotView];
    }
}

#pragma mark ************* Private Method End   *************

- (UITextField *)pswTf {
    if (!_pswTf) {
        _pswTf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.yl_width, self.yl_height)];
        _pswTf.backgroundColor = [UIColor clearColor];
        // 输入文字颜色为无色
        _pswTf.textColor = [UIColor clearColor];
        // 输入光标颜色为无色
        _pswTf.tintColor = [UIColor clearColor];
        _pswTf.delegate = self;
        _pswTf.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _pswTf.keyboardType = UIKeyboardTypeNumberPad;
        _pswTf.layer.borderColor = [[UIColor grayColor] CGColor];
        _pswTf.layer.borderWidth = 1;
        [_pswTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _pswTf;
}

- (NSMutableArray *)dotArr {
    if (!_dotArr) {
        _dotArr = [NSMutableArray array];
    }
    return _dotArr;
}
@end
