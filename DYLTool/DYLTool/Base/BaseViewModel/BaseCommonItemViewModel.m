//
//  BaseCommonItemViewModel.m
//  DYLTool
//
//  Created by sky on 2018/7/9.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseCommonItemViewModel.h"

@implementation BaseCommonItemViewModel

+ (instancetype)itemViewModelWithTitle:(NSString *)title icon:(NSString *)icon {
    BaseCommonItemViewModel *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+ (instancetype)itemViewModelWithTitle:(NSString *)title {
    return [self itemViewModelWithTitle:title icon:nil];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _selectionStyle = UITableViewCellSelectionStyleGray;
        _rowHeight = 44.0f;
    }
    return self;
}

@end
