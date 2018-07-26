//
//  TestCommonViewModel.m
//  DYLTool
//
//  Created by sky on 2018/7/10.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestCommonViewModel.h"

@implementation TestCommonViewModel

- (instancetype)initWithParams:(NSDictionary *)params services:(id<BaseViewModelServices>)services {
    if (self = [super initWithParams:params services:services]) {
//        [self _configureData];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    [self _configureData];
}

- (void)_configureData {
    BaseCommonGroupViewModel *group0 = [BaseCommonGroupViewModel groupViewModel];
    BaseCommonItemViewModel *item0_1 = [BaseCommonItemViewModel itemViewModelWithTitle:@"测试-第一组" icon:@"ff_IconShowAlbum_25x25"];
    item0_1.destViewModelClass = nil;
    group0.itemViewModels = @[item0_1];
    
    BaseCommonGroupViewModel *group1 = [BaseCommonGroupViewModel groupViewModel];
    BaseCommonItemViewModel *item1_1 = [BaseCommonItemViewModel itemViewModelWithTitle:@"测试-第二1组" icon:@"ff_IconShowAlbum_25x25"];
    BaseCommonItemViewModel *item1_2 = [BaseCommonItemViewModel itemViewModelWithTitle:@"测试-第二2组" icon:@"ff_IconShowAlbum_25x25"];
    BaseCommonItemViewModel *item1_3 = [BaseCommonItemViewModel itemViewModelWithTitle:@"测试-第二3组" icon:@"ff_IconShowAlbum_25x25"];
    BaseCommonItemViewModel *item1_4 = [BaseCommonItemViewModel itemViewModelWithTitle:@"测试-第二4组" icon:@"ff_IconShowAlbum_25x25"];
    item1_1.destViewModelClass = nil;
    item1_2.destViewModelClass = nil;
    item1_3.destViewModelClass = nil;
    item1_4.destViewModelClass = nil;
    group1.itemViewModels = @[item1_1, item1_2, item1_3, item1_4];
    
    BaseCommonGroupViewModel *group2 = [BaseCommonGroupViewModel groupViewModel];
    BaseCommonItemViewModel *item2_1 = [BaseCommonItemViewModel itemViewModelWithTitle:@"测试-第三组" icon:@"ff_IconShowAlbum_25x25"];
    BaseCommonItemViewModel *item2_2 = [BaseCommonItemViewModel itemViewModelWithTitle:@"测试-第三组" icon:@"ff_IconShowAlbum_25x25"];
    BaseCommonItemViewModel *item2_3 = [BaseCommonItemViewModel itemViewModelWithTitle:@"测试-第三组" icon:@"ff_IconShowAlbum_25x25"];
    BaseCommonItemViewModel *item2_4 = [BaseCommonItemViewModel itemViewModelWithTitle:@"测试-第三组" icon:@"ff_IconShowAlbum_25x25"];
    group2.itemViewModels = @[item2_1, item2_2, item2_3, item2_4];
    
    self.dataSource = @[group0, group1, group2];
}

@end
