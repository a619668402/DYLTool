//
//  YLInputView.m
//  DYLTool
//
//  Created by sky on 2018/7/30.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLInputView.h"
/// 输入框高度
#define kInputHeight 37
/// 按钮宽
#define kButtonW 50
/// 按钮高
#define kButtonH 30
/// 按钮距离下边距离
#define kButtonMargin 10

@interface YLInputView ()<UITextViewDelegate>
/// 文本输入框最高高度
@property (nonatomic, assign) NSUInteger textInputMaxheight;
/// 文本输入框高度
@property (nonatomic, assign) CGFloat textInputHeight;
/// 键盘高度
@property (nonatomic, assign) CGFloat keyboardHeight;
/// 键盘是否可见
@property (nonatomic, assign) BOOL keyboardIsVisiable;
/// 发送按钮
@property (nonatomic, strong) UIButton *sendBtn;

@property (nonatomic, assign) CGFloat origin_y;
@end

@implementation YLInputView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.origin_y = frame.origin.y;
        
        [self _initViews];
        
        [self _setupSubviews];
        
        [self _addEventListening];
    }
    return self;
}

- (void)dealloc {
    KLogFunc;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)_initViews {
    self.backgroundColor = self.bgColor;
    if (!self.textViewMaxLine || self.textViewMaxLine == 0) {
        self.textViewMaxLine = 2;
    }
}

- (void)_setupSubviews {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.yl_width, 0.5)];
    line.backgroundColor = rgb(227, 228, 232);
    [self addSubview:line];
    
    self.textInput = [[UITextView alloc] initWithFrame:CGRectMake(5, (self.yl_height - kInputHeight)/2, self.yl_width - kButtonW - 20, 37)];
    self.textInput.font = [UIFont systemFontOfSize:15.f];
    self.textInput.layer.cornerRadius = 5.f;
    self.textInput.layer.borderColor = rgb(227, 228, 232).CGColor;
    self.textInput.layer.borderWidth = 1.f;
    self.textInput.returnKeyType = UIReturnKeySend;
    self.textInput.enablesReturnKeyAutomatically = YES;
    self.textInput.delegate = self;
    [self addSubview:self.textInput];
    
    self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (self.yl_height - kInputHeight) / 2, self.yl_width - kButtonW - 20, 37)];
    self.placeholderLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.placeholderLabel.font = self.textInput.font;
    if (self.placeholderLabel.text.length == 0) {
        self.placeholderLabel.text = @" ";
    }
    [self addSubview:self.placeholderLabel];
    
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendBtn.frame = CGRectMake(self.yl_width - kButtonW - 10, self.yl_height - kButtonH - kButtonMargin, kButtonW, kButtonH);
    self.sendBtn.layer.borderWidth = 1.f;
    self.sendBtn.layer.cornerRadius = 5.f;
    self.sendBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.sendBtn.enabled = NO;
    self.sendBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendBtn addTarget:self action:@selector(_sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.sendBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f] forState:UIControlStateNormal];
    [self addSubview:self.sendBtn];
}

- (void)_sendBtnClick:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(yl_inputView:inputContent:)]) {
        [self.delegate yl_inputView:self inputContent:self.textInput.text];
    }
}

/// 添加通知
- (void)_addEventListening {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)_keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardHeight = keyboardFrame.size.height;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:7];
    self.yl_y = keyboardFrame.origin.y - self.yl_height;
    [UIView commitAnimations];
    self.keyboardIsVisiable = YES;
    if (self.keyIsVisiableBlock) {
        self.keyIsVisiableBlock(YES);
    }
}

- (void)_keyboardWillHidden:(NSNotification *)notification {
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.yl_y = self.origin_y;
    }];
    self.keyboardIsVisiable = NO;
    if (self.keyIsVisiableBlock) {
        self.keyIsVisiableBlock(NO);
    }
}

#pragma mark ************* UITextView Delegate Start *************
- (void)textViewDidChange:(UITextView *)textView {
    self.placeholderLabel.hidden = textView.text.length;
    if (textView.text.length) {
        self.sendBtn.enabled = YES;
        [self.sendBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9f] forState:UIControlStateNormal];
    } else {
        self.sendBtn.enabled = NO;
        [self.sendBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f] forState:UIControlStateNormal];
    }
    _textInputHeight = ceilf([self.textInput sizeThatFits:CGSizeMake(self.textInput.yl_width, MAXFLOAT)].height);
    self.textInput.scrollEnabled = _textInputHeight > _textInputMaxheight && _textInputMaxheight > 0;
    if (self.textInput.scrollEnabled) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:7];
        self.textInput.yl_height = 5 + _textInputMaxheight;
        self.yl_y = KScreenHeight - _keyboardHeight - _textInputMaxheight - 5 - 10;
        self.yl_height = _textInputMaxheight + 15;
        self.sendBtn.yl_y = self.yl_height - kButtonH - kButtonMargin;
        [UIView commitAnimations];
    } else {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:7];
        self.textInput.yl_height = _textInputHeight;
        self.yl_y = KScreenHeight - _keyboardHeight - _textInputHeight - 5 - 8;
        self.yl_height = _textInputHeight + 15;
        self.sendBtn.yl_y = self.yl_height - kButtonH - kButtonMargin;
        [UIView commitAnimations];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    // 点击return按钮
    if ([text isEqualToString:@"\n"]){
        if ([_delegate respondsToSelector:@selector(yl_inputView:inputContent:)]) {
            [_delegate yl_inputView:self inputContent:self.textInput.text];
        }
        return NO;
    }
    return YES;
}
#pragma mark ************* UITextView Delegate End   *************

- (void)setTextViewMaxLine:(NSInteger)textViewMaxLine {
    _textViewMaxLine = textViewMaxLine;
    _textInputMaxheight = ceil(self.textInput.font.lineHeight * (textViewMaxLine - 1) +
                               self.textInput.textContainerInset.top + self.textInput.textContainerInset.bottom);
}

- (void)sendSuccessEndEditing {
    self.textInput.text = nil;
    [self.textInput.delegate textViewDidChange:self.textInput];
    [self endEditing:YES];
}

#pragma mark ************* Lazyload Start *************
- (UIColor *)bgColor {
    if (!_bgColor) {
        _bgColor = [UIColor whiteColor];
    }
    return _bgColor;
}
#pragma mark ************* Lazyload End   *************
@end
