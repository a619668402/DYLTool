//
//  BaseTableController.m
//  DYLTool
//
//  Created by sky on 2018/6/27.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseTableController.h"

@interface BaseTableController ()

@property (nonatomic, readwrite, weak) UITableView *tableView;

@property (nonatomic, readwrite, assign) UIEdgeInsets contentInsets;

@property (nonatomic, readonly, strong) BaseTableViewModel *viewModel;

@end

@implementation BaseTableController

@dynamic viewModel;

#pragma mark ************* 生命周期 Start *************
- (instancetype)initWithViewModel:(BaseTableViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        if ([viewModel shouldRequestRemoteDataOnViewDidLoad]) {
            @weakify(self);
            [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(RACTuple * _Nullable x) {
                @strongify(self);
                // 请求第一页数据
                [self.viewModel.requestRemoteDataCommand execute:@1];
            }];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)dealloc {
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
}

#pragma mark ************* 生命周期 End   *************

#pragma mark ************* override Start *************

- (void)bindViewModel {
    [super bindViewModel];
    // observe viewModel's dataSource
    @weakify(self);
    [[RACObserve(self.viewModel, dataSource) deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        // 刷新数据
        [self reloadData];
    }];
}

// init child Views
- (void)yl_initViews {
    [super yl_initViews];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    /* config TableView 边距
     [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.edges.mas_equalTo(UIEdgeInsetsZero);
     }];
     */
    self.tableView = tableView;
    tableView.contentInset = self.contentInset;
    // 注册Cell
    [self.tableView yl_registerCell:[UITableViewCell class]];
    
    // 添加刷新控件
    if (self.viewModel.shouldPullDownToRefresh) {
        // 下拉刷新
        @weakify(self);
        [self.tableView yl_addHeaderRefresh:^(MJRefreshNormalHeader *header) {
            // 加载下拉刷新的数据
            @strongify(self);
            [self _tableViewDidTrigerHeaderRefresh];
        }];
        [self.tableView.mj_header beginRefreshing];
    }
    
    if (self.viewModel.shouldPullToLoadMore) {
        // 上拉加载
        @weakify(self);
        [self.tableView yl_addFooterRefresh:^(MJRefreshAutoNormalFooter *footer) {
            // 加载上拉刷新数据
            @strongify(self);
            [self _tableViewDidTrigerFooterRefresh];
        }];
        
        // 隐藏footer or 无更多数据
        RAC(self.tableView.mj_footer, hidden) = [[RACObserve(self.viewModel, dataSource) deliverOnMainThread] map:^id _Nullable(NSArray *dataSource) {
            @strongify(self);
            NSUInteger count = dataSource.count;
            
            // 无数据, 默认隐藏 mj_footer
            if (count == 0) {
                return @1;
            }
            if (self.viewModel.shouldEndRefreshingWithNoMoreData) {
                return @(0);
            }
            return (count % self.viewModel.pageSize) ? @1 : @0;
        }];
    }
    
    if (@available(iOS 11.0, *)) {
        // 适配 iPhoneX + iOS 11
        KAdjustsScrollViewInsets_Never(tableView);
        // iOS 11上发生tableView顶部有留白，原因是代码中只实现了heightForHeaderInSection方法，而没有实现viewForHeaderInSection方法。那样写是不规范的，只实现高度，而没有实现view，但代码这样写在iOS 11之前是没有问题的，iOS 11之后应该是由于开启了估算行高机制引起了bug。
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
    }
}

#pragma mark ----- UITableView DataSource -----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.viewModel.shouldMultiSections) {
        return self.viewModel.dataSource ? self.viewModel.dataSource.count : 0;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.viewModel.shouldMultiSections) {
        return [self.viewModel.dataSource[section] count];
    }
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    id object = nil;
    if (self.viewModel.shouldMultiSections) {
        object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    }
    if (!self.viewModel.shouldMultiSections) {
        object = self.viewModel.dataSource[indexPath.row];
    }
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    return cell;
}

#pragma mark ----- UITableView Delegate -----
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // execute command
    [self.viewModel.didSelectCommand execute:indexPath];
}

#pragma mark ************* override End   *************


#pragma mark ************* public Method Start *************
- (void)reloadData {
    [self.tableView reloadData];
}
/// sub class can override it
- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(KNavAndStatusHeight, 0, 0, 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}
#pragma mark ************* public Method End   *************

#pragma mark ************* private Method Start *************
// 下拉事件
- (void)_tableViewDidTrigerHeaderRefresh {
    @weakify(self);
    [[[self.viewModel.requestRemoteDataCommand execute:@1] deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.viewModel.shouldEndRefreshingWithNoMoreData) {
            // 重置没有更多的状态
            [self.tableView.mj_footer resetNoMoreData];
        }
    } error:^(NSError * _Nullable error) {
        // 已经在 bingViewModel 中添加了对数据源变化的监听来刷新数据
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
    } completed:^{
        // 已经在 bingViewModel 中添加了对数据源变化的监听来刷新数据
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        // 请求完成
        [self _requestDataCompleted];
    }];
}
// 上拉事件
- (void)_tableViewDidTrigerFooterRefresh {
    @weakify(self);
    [[[self.viewModel.requestRemoteDataCommand execute:@(self.viewModel.page + 1)] deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        // 请求成功之后 页数 + 1
        self.viewModel.page += 1;
    } error:^(NSError * _Nullable error) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshing];
    } completed:^{
        @strongify(self);
        [self.tableView.mj_footer endRefreshing];
        [self _requestDataCompleted];
    }];
}

- (void)_requestDataCompleted {
    NSUInteger count = self.viewModel.dataSource.count;
    if (self.viewModel.shouldEndRefreshingWithNoMoreData && count % self.viewModel.pageSize) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}
#pragma mark ************* private Method End   *************
@end
