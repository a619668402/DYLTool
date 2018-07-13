//
//  CommonSwitchItemViewModel.m
//  DYLTool
//
//  Created by sky on 2018/7/10.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "CommonSwitchItemViewModel.h"

@implementation CommonSwitchItemViewModel

- (void)setOff:(BOOL)off {
    _off = off;
    [KSaveHelper yl_saveBool:off key:self.key];
}

- (void)setKey:(NSString *)key {
    [super setKey:key];
    _off = [KSaveHelper yl_readBoolWithKey:self.key];
}

@end
