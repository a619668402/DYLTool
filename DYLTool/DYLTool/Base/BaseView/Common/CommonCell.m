//
//  CommonCellTableViewCell.m
//  DYLTool
//
//  Created by sky on 2018/7/9.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "CommonCell.h"

@interface CommonCell()

@property (nonatomic, readwrite, strong) BaseCommonItemViewModel *viewModel;
/// 箭头
@property (nonatomic, readwrite, strong) UIImageView *rightArrow;
/// 开关
@property (nonatomic, readwrite, strong) UISwitch *rightSwitch;
/// 标签
@property (nonatomic, readwrite, strong) UILabel *rightLabel;
/// avatar 头像
@property (nonatomic, readwrite, weak) UIImageView *avatarView;
/// QRCode
@property (nonatomic, readwrite, weak) UIImageView *qrCodeView;

/// 三条分割线
@property (nonatomic, readwrite, weak) UIImageView *divider0;
@property (nonatomic, readwrite, weak) UIImageView *divider1;
@property (nonatomic, readwrite, weak) UIImageView *divider2;

/// 中间偏左 view
@property (nonatomic, readwrite, weak) UIImageView *centerLeftView;
/// 中间偏右 view
@property (nonatomic, readwrite, weak) UIImageView *centerRightView;
@end

@implementation CommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark ************* Override Method Start *************

- (void)yl_bindModel:(BaseCommonItemViewModel *)viewModel {
    self.viewModel = viewModel;
    
    self.selectionStyle = viewModel.selectionStyle;
    self.textLabel.text = viewModel.title;
    BOOL flag = KStringIsEmpty(viewModel.icon);
    self.imageView.image = KStringIsEmpty(viewModel.icon) ? nil : M_IMG(viewModel.icon);
    self.detailTextLabel.text = viewModel.subTitle;
    
    if (KStringIsEmpty(viewModel.centerLeftViewName)) {
        self.centerLeftView.hidden = NO;
        self.centerLeftView.image = M_IMG(viewModel.centerLeftViewName);
        self.centerLeftView.yl_size = self.centerLeftView.image.size;
    } else {
        self.centerLeftView.hidden = YES;
    }
    
    if (KStringIsEmpty(viewModel.centerRightViewName)) {
        self.centerRightView.hidden = NO;
        self.centerRightView.image = M_IMG(viewModel.centerRightViewName);
        self.centerRightView.yl_size = self.centerRightView.image.size;
    } else {
        self.centerRightView.hidden = YES;
    }
    
    if ([viewModel isKindOfClass:[CommonArrowItemViewModel class]]) { // 带箭头
        self.accessoryView = self.rightArrow;
    } else if ([viewModel isKindOfClass:[CommonSwitchItemViewModel class]]) {
        // 右边显示开关
        CommonSwitchItemViewModel *switchViewModel = (CommonSwitchItemViewModel *)self.viewModel;
        self.accessoryView = self.rightSwitch;
        self.rightSwitch.on = !switchViewModel.off;
    } else {
        self.accessoryView = nil;
    }
}

- (void)yl_setUp {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.detailTextLabel.textColor = [UIColor hex:@"#888888"];
    self.detailTextLabel.numberOfLines = 0;
    self.textLabel.font = N_17;
    self.detailTextLabel.font = N_16;
}

- (void)yl_setUpChildViews {
    UIImageView *divider0 = [[UIImageView alloc] init];
    self.divider0 = divider0;
    [self addSubview:divider0];
    UIImageView *divider1 = [[UIImageView alloc] init];
    self.divider1 = divider1;
    [self addSubview:divider1];
    UIImageView *divider2 = [[UIImageView alloc] init];
    self.divider2 = divider2;
    [self addSubview:divider2];
    
    divider0.backgroundColor = divider1.backgroundColor = divider2.backgroundColor = [UIColor hex:@"#D9D8D9"];
    
    // 中间偏左图片
    UIImageView *centerLeftView = [[UIImageView alloc] init];
    centerLeftView.hidden = YES;
    self.centerLeftView = centerLeftView;
    [self.contentView addSubview:centerLeftView];
    
    // 中间偏右图片
    UIImageView *centerRightView = [[UIImageView alloc] init];
    centerRightView.hidden = YES;
    self.centerRightView = centerRightView;
    [self.contentView addSubview:centerRightView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置
    if (fabs(self.textLabel.yl_x - self.detailTextLabel.yl_x) <= 0.1f) {
        self.textLabel.yl_bottom = self.detailTextLabel.yl_y;
    } else {
        self.textLabel.yl_centerY = self.yl_height * 0.5f;
    }
    
    self.divider0.frame = CGRectMake(0, 0, self.yl_width, KGlobleLineHeight);
    self.divider1.frame = CGRectMake(14, self.yl_height - KGlobleLineHeight, self.yl_width - 14, KGlobleLineHeight);
    self.divider2.frame = CGRectMake(0, self.yl_height - KGlobleLineHeight, self.yl_width, KGlobleLineHeight);
    
    
    self.centerLeftView.yl_x = self.accessoryView.yl_x - 11;
    self.centerLeftView.yl_centerY = self.yl_height * 0.5f;
    
    self.centerRightView.yl_right = self.detailTextLabel.yl_x - 5;
    self.centerRightView.yl_centerY = self.yl_height * 0.5f;
}
#pragma mark ************* Override Method End   *************

#pragma mark ************* Public Method Start *************

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [self cellWithTableView:tableView style:UITableViewCellStyleValue1];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style {
    static NSString *ID = @"CommonCell";
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)setIndexPath:(NSIndexPath *)indexPath rowInSection:(NSInteger)rows {
    self.divider0.hidden = NO;
    self.divider1.hidden = NO;
    self.divider2.hidden = NO;
    if (rows == 1) { /// 一段
        self.divider1.hidden = YES;
    } else if (indexPath.row == 0) { // 首行
        self.divider2.hidden = YES;
    } else if (indexPath.row == rows - 1) { // 末行
        self.divider1.hidden = YES;
        self.divider0.hidden = YES;
    } else {
        self.divider0.hidden = NO;
        self.divider1.hidden = YES;
        self.divider2.hidden = YES;
    }
}
#pragma mark ************* Public Method End   *************

#pragma mark ************* private Method Start *************

- (void)_switchValueDidiChanged:(UISwitch *)sender {
    CommonSwitchItemViewModel *switchViewModel = (CommonSwitchItemViewModel *)self.viewModel;
    switchViewModel.off = !sender.isOn;
}

#pragma mark ************* private Method End   *************

#pragma mark ************* Lazy Load Start *************

- (UIImageView *)rightArrow {
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] initWithImage:M_IMG(@"tableview_arrow_8x13")];
    }
    return _rightArrow;
}

- (UISwitch *)rightSwitch {
    if (!_rightSwitch) {
        _rightSwitch = [[UISwitch alloc] init];
        [_rightSwitch addTarget:self action:@selector(_switchValueDidiChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _rightSwitch;
}

#pragma mark ************* Lazy Load End   *************
@end
