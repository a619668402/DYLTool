//
//  BaseCollectionViewCell.m
//  Base
//
//  Created by sky on 2018/6/21.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self yl_setUpChildViews];
    }
    return self;
}

- (void)yl_setUpChildViews {}

@end
