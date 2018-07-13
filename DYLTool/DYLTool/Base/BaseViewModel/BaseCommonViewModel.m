//
//  BaseCommonViewModel.m
//  DYLTool
//
//  Created by sky on 2018/7/9.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseCommonViewModel.h"

@implementation BaseCommonViewModel

- (void)initialize {
    [super initialize];
    // 选中 Cell 的命令
    @weakify(self);
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSIndexPath *indexPath) {
        @strongify(self);
        BaseCommonGroupViewModel *groupViewModel = self.dataSource[indexPath.section];
        BaseCommonItemViewModel *itemViewModel = groupViewModel.itemViewModels[indexPath.item];
        if (itemViewModel.opeartion) {
            // 有操作执行操作
            itemViewModel.opeartion();
        } else if (itemViewModel.destViewModelClass) {
            // 没有操作就跳转 VC
            Class viewModelClass = itemViewModel.destViewModelClass;
            BaseViewModel *viewModel = [[viewModelClass alloc] initWithParams:self.params services:self.services];
            [self.services pushViewModel:viewModel animated:YES];
        }
        return [RACSignal empty];
    }];
}

@end
