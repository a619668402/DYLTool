//
//  YLAlertView.m
//  DYLTool
//
//  Created by sky on 2018/7/19.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLAlertMessageView.h"

#define YLAlertView_W               HitoActureWidth(260.f)
#define YLALertViewTitle_H          30.0f
#define YLAlertViewMsgMin_H         80.0f
#define YLAlertBtn_H                35.0f

//比例宽和高(以6为除数)
#define HitoActureHeight(height)  roundf(height/375.0 * KScreenWidth)

#define HitoActureWidth(Width)  roundf(Width/667.0 * KScreenHeight)

@interface YLAlertMessageView ()
/// 弹窗背景
@property (nonatomic, strong) UIView *alertView;
/// 弹窗标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 弹窗信息
@property (nonatomic, strong) UILabel *messageLabel;
/// 取消按钮
@property (nonatomic, strong) UIButton *cancleBtn;
/// 确定按钮
@property (nonatomic, strong) UIButton *otherBtn;
@end

@implementation YLAlertMessageView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancleBtnTitle:(NSString *)cancleBtnTitle otherBtnTitle:(NSString *)otherBtnTitle {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        if (title) {
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, YLAlertView_W, YLALertViewTitle_H)];;
            self.titleLabel.text = message;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.textColor = [UIColor blackColor];
            self.titleLabel.font = N_17;
        }
        CGFloat messageLabelSpace = 15;
        self.messageLabel = [[UILabel alloc] init];
        self.messageLabel.backgroundColor = [UIColor whiteColor];
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.text = message;
        self.messageLabel.textColor = [UIColor blackColor];
        self.messageLabel.font = N_15;
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.messageLabel.characterSpace = 1;
        self.messageLabel.lineSpace = 2;
        CGSize messageSize = [self.messageLabel yl_getLabelRectWithMaxWidth:YLAlertView_W - messageLabelSpace * 2];
        self.messageLabel.frame = CGRectMake(messageLabelSpace, self.titleLabel.yl_bottom + 10, YLAlertView_W - messageLabelSpace * 2, messageSize.height < YLAlertViewMsgMin_H ? YLAlertViewMsgMin_H : messageSize.height);
        
        if (cancleBtnTitle) {
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.cancleBtn setTitle:cancleBtnTitle forState:UIControlStateNormal];
            self.cancleBtn.titleLabel.font = N_15;
            self.cancleBtn.layer.cornerRadius = 3;
            self.cancleBtn.layer.masksToBounds = YES;
            self.cancleBtn.backgroundColor = [UIColor grayColor];
            [self.cancleBtn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.alertView addSubview:self.cancleBtn];
        }
        if (otherBtnTitle) {
            self.otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.otherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.otherBtn setTitle:otherBtnTitle forState:UIControlStateNormal];
            self.otherBtn.titleLabel.font = N_15;
            self.otherBtn.layer.cornerRadius = 3;
            self.otherBtn.layer.masksToBounds = YES;
            self.otherBtn.backgroundColor = [UIColor grayColor];
            [self.otherBtn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.alertView addSubview:self.otherBtn];
        }
        
        CGFloat btn_y = self.messageLabel.yl_bottom + 10;
        if (cancleBtnTitle && !otherBtnTitle) {
            self.cancleBtn.tag = 1;
            self.cancleBtn.frame = CGRectMake(messageLabelSpace, btn_y, YLAlertView_W - messageLabelSpace * 2, YLAlertBtn_H);
        } else if (!cancleBtnTitle && otherBtnTitle) {
            self.otherBtn.tag = 2;
            self.otherBtn.frame = CGRectMake(messageLabelSpace, btn_y, YLAlertView_W - messageLabelSpace * 2, YLAlertBtn_H);
        } else if (otherBtnTitle && cancleBtnTitle) {
            self.cancleBtn.tag = 1;
            self.otherBtn.tag = 2;
            CGFloat btnSpace = 20; // 按钮间距
            CGFloat btn_w = (YLAlertView_W - messageLabelSpace * 2 - btnSpace) / 2;
            self.cancleBtn.frame = CGRectMake(messageLabelSpace, btn_y, btn_w, YLAlertBtn_H);
            self.otherBtn.frame = CGRectMake(self.cancleBtn.yl_right + btnSpace, btn_y, btn_w, YLAlertBtn_H);
        }
        
        self.alertView.frame = CGRectMake(0, 0, YLAlertView_W, self.cancleBtn.yl_bottom + 10);
        self.alertView.center = self.center;
        [self addSubview:self.alertView];
        [self.alertView addSubview:self.titleLabel];
        [self.alertView addSubview:self.messageLabel];
    }
    return self;
}

#pragma mark ************* Public Method Start *************
- (void)show {
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.alertView.transform = transform;
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {}];
}
#pragma mark ************* Public Method End   *************

#pragma mark ************* Private Method Start *************
- (void)_dismissAlertView {
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

- (void)_btnClick:(UIButton *)btn {
    KLogFunc;
    if (btn.tag == 2) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(yl_AlertMessageViewOtherBtnClick)]) {
            [self.delegate yl_AlertMessageViewOtherBtnClick];
        }
    }
    [self _dismissAlertView];
}
#pragma mark ************* Private Method End   *************

#pragma mark ************* Lazyload Start *************
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _alertView.layer.cornerRadius = 5.0f;
        _alertView.userInteractionEnabled = YES;
    }
    return _alertView;
}
#pragma mark ************* Lazyload End   *************

@end
