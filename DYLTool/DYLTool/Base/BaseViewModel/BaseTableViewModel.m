//
//  BaseTableViewModel.m
//  DYLTool
//
//  Created by sky on 2018/6/28.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseTableViewModel.h"

@interface BaseTableViewModel()

@property (nonatomic, strong, readwrite) RACCommand *requestRemoteDataCommand;

@end

@implementation BaseTableViewModel

- (void)initialize {
    [super initialize];
    
    self.page = 1;
    self.pageSize = 10;
    
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber *page) {
        // 当对象将要释放的时候 取消网络请求
        return [self requestRemoteDataSignalWithPage:page.unsignedIntegerValue];
    }];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [RACSignal empty];
}

@end
