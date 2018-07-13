//
//  BaseTableViewModel.h
//  DYLTool
//
//  Created by sky on 2018/6/28.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseViewModel.h"
#import "RACNetWork.h"

@interface BaseTableViewModel : BaseViewModel

/// the data source of table view. 这里不能用 NSMutableArray, Because NSMutableArray 不支持 KVO, 不能被 RACObserve
@property (nonatomic, copy, readwrite) NSArray *dataSource;

/// tableView's style, default is UITableViewStylePlain, 只适合 UITableView 有效
@property (nonatomic, assign, readwrite) UITableViewStyle style;

/// 是否支持下拉刷新 default is NO
@property (nonatomic, assign, readwrite) BOOL shouldPullDownToRefresh;

/// 是否支持上拉加载更多 default is NO
@property (nonatomic, assign, readwrite) BOOL shouldPullToLoadMore;

/// 是否是多个分区(It's effect tableView's dataSource 'numberOfSectionsInTableView:') default is NO
@property (nonatomic, assign, readwrite) BOOL shouldMultiSections;

/// 是否在上拉加载后,DataSource.count < pageSize 提示没有更多数据. default is NO, 默认做法是数据不够时,隐藏mj_footer
@property (nonatomic, assign, readwrite) BOOL shouldEndRefreshingWithNoMoreData;

/// 当前页 default is 1
@property (nonatomic, assign, readwrite) NSUInteger page;

/// 每页数据 default is 10
@property (nonatomic, assign, readwrite) NSUInteger pageSize;

/// 请求服务器数据的命令
@property (nonatomic, strong, readonly) RACCommand *requestRemoteDataCommand;

/// 选中命令 didSelectRowAtIndexpath:
@property (nonatomic, strong, readwrite) RACCommand *didSelectCommand;

/// request remote data or local data, sub class can override it
/// page - 请求第几页数据
- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page;

@end
