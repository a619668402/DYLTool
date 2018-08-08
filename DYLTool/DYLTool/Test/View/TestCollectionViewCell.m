//
//  TestCollectionViewCell.m
//  DYLTool
//
//  Created by sky on 2018/8/8.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestCollectionViewCell.h"

@implementation TestCollectionViewCell

- (void)yl_setUpChildViews {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15.f];
    label.layer.cornerRadius = 3.f;
    label.layer.borderWidth = 1.f;
    label.userInteractionEnabled = YES;
    label.layer.borderColor = [red_color CGColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = label;
    [self.contentView addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.backgroundColor = [green_color CGColor];
    btn.layer.cornerRadius = 10.f;
    [label addSubview:btn];
    self.btn = btn;
}

- (void)setModel:(NSString *)str {
    self.titleLabel.text = str;
    self.titleLabel.frame = CGRectMake(0, 5, [str yl_widthWithFontSize:15.f height:35] + 30, 45);
    self.titleLabel.textColor = black_color;
    
    self.btn.frame = CGRectMake(self.yl_width - 17, -3, 20, 20);
}

@end
