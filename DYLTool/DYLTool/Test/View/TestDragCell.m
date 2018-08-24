//
//  TestDragCell.m
//  DYLTool
//
//  Created by sky on 2018/8/24.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestDragCell.h"

@interface TestDragCell ()

@property (nonatomic, strong) UILabel *lab;

@end

@implementation TestDragCell

- (void)yl_setUpChildViews {
    self.lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.yl_width, self.yl_height)];
    self.lab.layer.borderColor = [[UIColor blackColor] CGColor];
    self.lab.layer.borderWidth = 1.5f;
    self.lab.textColor = [UIColor blackColor];
    self.lab.font = [UIFont systemFontOfSize:18.f];
    self.lab.textAlignment = NSTextAlignmentCenter;
    self.lab.layer.cornerRadius = 6.f;
    [self addSubview:self.lab];
}

- (void)setData:(NSString *)data {
    self.lab.text = data;
}

@end
