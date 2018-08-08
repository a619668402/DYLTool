//
//  TestCollectionViewCell.h
//  DYLTool
//
//  Created by sky on 2018/8/8.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface TestCollectionViewCell : BaseCollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *btn;

- (void)setModel:(NSString *)str;

@end
