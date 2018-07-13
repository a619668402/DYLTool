//
//  CommonFooterView.m
//  DYLTool
//
//  Created by sky on 2018/7/10.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "CommonFooterView.h"
#import "BaseCommonGroupViewModel.h"

@interface CommonFooterView ()

@property (nonatomic, readwrite, strong) BaseCommonGroupViewModel *viewModel;

@property (nonatomic, readwrite, weak) UILabel *contentLabel;

@end

@implementation CommonFooterView

#pragma mark ************* Override Method Start *************

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self yl_setUp];
        
        [self yl_setUpChildViews];
    }
    return self;
}

- (void)yl_setUp {
    self.contentView.backgroundColor = [UIColor hex:@"#EFEFF4"];
}

- (void)yl_setUpChildViews {
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textColor = [UIColor hex:@"#888888"];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.font = N_14;
    contentLabel.numberOfLines = 0;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

- (void)yl_bindModel:(BaseCommonGroupViewModel *)viewModel {
    self.viewModel = viewModel;
    self.contentLabel.text = viewModel.footer;
}

#pragma mark ************* Override Method End   *************

#pragma mark ************* Public Method Start *************

+ (instancetype)footerWithTableView:(UITableView *)tableView {
    static NSString *ID = @"CommonFooterView";
    CommonFooterView *footer = (CommonFooterView *)[tableView dequeueReusableCellWithIdentifier:ID];
    if (footer) {
        footer = [[self alloc] initWithReuseIdentifier:ID];
    }
    return footer;
}

#pragma mark ************* Public Method End   *************

#pragma mark ************* Private Method Start *************

- (void)_makeSubviewConstrains {
    KWeakSelf(self);
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.contentView).with.offset(20);
        make.top.equalTo(weakself.contentView).with.offset(5);
        make.right.equalTo(weakself.contentView).with.offset(-20);
    }];
}

#pragma mark ************* Private Method End   *************
@end
