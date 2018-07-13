//
//  BaseTableViewCell.m
//  Base
//
//  Created by sky on 2018/6/21.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self yl_setUp];
        [self yl_setUpChildViews];
    }
    return self;
}

- (void)yl_setUp {}

/**
 初始化子控件
 */
- (void)yl_setUpChildViews {}

@end
