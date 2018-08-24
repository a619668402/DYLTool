//
//  YLShareView.m
//  DYLTool
//
//  Created by sky on 2018/8/20.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLShareView.h"

#define YLShareViewHeight 235.f
#define YLShareViewShowDuration 0.3f

@interface YLShareView ()
/// 容器View
@property (nonatomic, strong, readwrite) UIView *contentView;
/// 取消按钮
@property (nonatomic, strong, readwrite) UIButton *cancelBtn;
/// 背景
@property (nonatomic, strong, readwrite) UIView *bgView;
/// 数据源
@property (nonatomic, copy, readwrite) NSArray *dataSource;

@property (nonatomic, strong, readwrite) NSMutableArray *btnArray;

@property (nonatomic, strong, readwrite) UIScrollView *topScrollView;

@property (nonatomic, strong, readwrite) UIScrollView *bottomScrollView;
/// 分割线
@property (nonatomic, strong, readwrite) UIView *lineView;

@end

@implementation YLShareView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _initValues];
        [self _initViews];
        [self _configData];
    }
    return self;
}

- (void)_initValues {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6f];
}

- (void)_initViews {
    // 背景View
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor clearColor];
    self.bgView.frame = CGRectMake(0, KScreenHeight, KScreenWidth, YLShareViewHeight);
    [self addSubview:self.bgView];
    // 取消按钮
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    self.cancelBtn.layer.cornerRadius = 5.f;
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.bgView addSubview:self.cancelBtn];
    // 容器View
    self.contentView = [[UIView alloc] init];
    self.contentView.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    self.contentView.layer.cornerRadius = 5.f;
    [self.bgView addSubview:self.contentView];
    
    self.topScrollView = [[UIScrollView alloc] init];
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.topScrollView];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.layer.backgroundColor = [[UIColor blackColor] CGColor];
    [self.contentView addSubview:self.lineView];
    
    self.bottomScrollView = [[UIScrollView alloc] init];
    self.bottomScrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.bottomScrollView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    KWeakSelf(self);
    // 取消按钮
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.bgView.mas_left).offset(10);
        make.bottom.equalTo(weakself.bgView.mas_bottom).offset(-10);
        make.right.equalTo(weakself.bgView.mas_right).offset(-10);
        make.height.mas_equalTo(44);
    }];
    // 容器View
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.bgView.mas_top).offset(0);
        make.left.equalTo(weakself.cancelBtn.mas_left).offset(0);
        make.right.equalTo(weakself.cancelBtn.mas_right).offset(0);
        make.bottom.equalTo(weakself.cancelBtn.mas_top).offset(-5);
    }];
    
    [self.topScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.contentView.mas_top).offset(0);
        make.left.equalTo(weakself.contentView.mas_left).offset(0);
        make.right.equalTo(weakself.contentView.mas_right).offset(0);
        make.height.equalTo(weakself.contentView.mas_height).multipliedBy(0.49);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.contentView.mas_left).offset(0);
        make.right.equalTo(weakself.contentView.mas_right).offset(0);
        make.height.mas_equalTo(0.5f);
        make.centerY.equalTo(weakself.contentView.mas_centerY).offset(0);
    }];
    
    [self.bottomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.contentView.mas_bottom).offset(0);
        make.left.equalTo(weakself.contentView.mas_left).offset(0);
        make.right.equalTo(weakself.contentView.mas_right).offset(0);
        make.height.equalTo(weakself.contentView.mas_height).multipliedBy(0.49);
    }];
}

- (void)showShareView {
    self.frame = [[UIScreen mainScreen] bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:YLShareViewShowDuration animations:^{
       self.bgView.frame = CGRectMake(0, KScreenHeight - YLShareViewHeight - KSafeBottomMargin, self.bgView.yl_width, self.bgView.yl_height);
    }];
}

- (void)_dismissShareView {
    [UIView animateWithDuration:YLShareViewShowDuration animations:^{
        self.bgView.frame = CGRectMake(0, KScreenHeight, self.bgView.yl_width, self.bgView.yl_height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)_configData {
    CGFloat height = (YLShareViewHeight - 44 - 15) * 0.49;
    for (int i = 0; i < self.dataSource.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(height * i, 0, height, height);
        [btn setTitle:self.dataSource[i] forState:UIControlStateNormal];
        [btn setTitleRect:CGRectMake(0, height - 25, height, 25)];
        [btn setImageRect:CGRectMake((height - 35) / 2, (height - 60) / 2, 35, 35)];
        btn.titleLabel.font = N_15;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setImage:[UIImage imageNamed:@"ff_IconShowAlbum_25x25"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn shake:0.1 * i];
        [self.topScrollView addSubview:btn];
        [self.btnArray addObject:btn];
//        [self.bottomScrollView addSubview:btn];
    }
    [self.btnArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
        CGAffineTransform fromTransform = CGAffineTransformMakeTranslation(0, 50);
        button.transform = fromTransform;
        button.alpha = 0.3;

        [UIView animateWithDuration:0.9+idx*0.1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            button.transform = CGAffineTransformIdentity;
            button.alpha = 1;
        } completion:^(BOOL finished) {

        }];
    }];
    self.topScrollView.contentSize = CGSizeMake(height * self.dataSource.count, height);
//    self.bottomScrollView.contentSize = CGSizeMake(height * self.dataSource.count, height);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self _dismissShareView];
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"微信朋友圈", @"微信好友", @"手机QQ", @"QQ空间", @"新浪微博", @"腾讯微博", @"支付宝好友", @"支付宝生活圈"];
    }
    return _dataSource;
}

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}


@end
