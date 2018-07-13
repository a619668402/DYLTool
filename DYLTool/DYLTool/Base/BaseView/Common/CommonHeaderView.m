//
//  CommonHeaderView.m
//  DYLTool
//
//  Created by sky on 2018/7/10.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "CommonHeaderView.h"
#import "BaseCommonGroupViewModel.h"

@interface CommonHeaderView ()

@property (nonatomic, readwrite, strong) BaseCommonGroupViewModel *viewModel;

@property (nonatomic, readwrite, weak) UILabel *contentLabel;

@end

@implementation CommonHeaderView

#pragma mark ************* Override Method Start *************

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 初始化
        [self yl_setUp];
        // 创建子控件
        [self yl_setUpChildViews];
        // 设置约束
        [self _makeSubviewConstraints];
    }
    return self;
}

- (void)yl_setUp {
    self.contentView.backgroundColor = [UIColor hex:@"#EFEFF4"];
}

- (void)yl_setUpChildViews {
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textColor = [UIColor hex:@"#888888"];
    contentLabel.font = N_14;
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

- (void)yl_bindModel:(BaseCommonGroupViewModel *)viewModel {
    self.viewModel = viewModel;
    self.contentLabel.text = viewModel.header;
}

#pragma mark ************* Override Method End   *************

#pragma mark ************* public Method Start *************

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    static NSString *ID = @"CommonHeaderView";
    CommonHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header) {
        header = [[self alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

#pragma mark ************* public Method End   *************

#pragma mark ************* private Method Start *************

- (void)_makeSubviewConstraints {
    KWeakSelf(self);
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.contentView).with.offset(20);
        make.top.equalTo(weakself.contentView).with.offset(5);
        make.right.equalTo(weakself.contentView).with.offset(-20);
    }];
}

#pragma mark ************* private Method End   *************
@end
