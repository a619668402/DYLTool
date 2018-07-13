//
//  BaseCommonController.m
//  DYLTool
//
//  Created by sky on 2018/7/9.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseCommonController.h"
#import "CommonCell.h"
#import "CommonHeaderView.h"
#import "CommonFooterView.h"

@interface BaseCommonController ()

@property (nonatomic, readwrite, strong) BaseCommonViewModel *viewModel;

@end

@implementation BaseCommonController

@dynamic viewModel;

#pragma mark ************* 生命周期方法 Start *************
- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark ************* 生命周期方法 End   *************

#pragma mark ************* Override Method Start *************
- (void)yl_initViews {
    [super yl_initViews];
}

- (void)yl_initValues {
    [super yl_initValues];
}

- (void)bindViewModel {
    [super bindViewModel];
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(KNavAndStatusHeight + 16, 0, 0, 0);
}

- (void)configureCell:(BaseTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    [cell yl_bindModel:object];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [CommonCell cellWithTableView:tableView];
}
#pragma mark ************* Override Method End   *************

#pragma mark ************* private Method Start *************

#pragma mark ************* private Method  End   *************

#pragma mark ************* TableView Delegate and DataSource Start *************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BaseCommonGroupViewModel *groupItemViewModel = self.viewModel.dataSource[section];
    return groupItemViewModel.itemViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonCell *cell = (CommonCell *)[self tableView:tableView dequeueReusableCellWithIdentifier:@"CommonCell" forIndexPath:indexPath];
    BaseCommonGroupViewModel *groupViewModel = self.viewModel.dataSource[indexPath.section];
    id object = groupViewModel.itemViewModels[indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:object];
    [cell setIndexPath:indexPath rowInSection:groupViewModel.itemViewModels.count];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CommonHeaderView *headerView = [CommonHeaderView headerViewWithTableView:tableView];
    BaseCommonGroupViewModel *groupViewModel = self.viewModel.dataSource[section];
    [headerView yl_bindModel:groupViewModel];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CommonFooterView *footerView = [CommonFooterView footerWithTableView:tableView];
    BaseCommonGroupViewModel *groupViewModel = self.viewModel.dataSource[section];
    [footerView yl_bindModel:groupViewModel];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    BaseCommonGroupViewModel *groupViewModel = self.viewModel.dataSource[section];
    return groupViewModel.headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    BaseCommonGroupViewModel *groupViewModel = self.viewModel.dataSource[section];
    return groupViewModel.footerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseCommonGroupViewModel *groupViewModel = self.viewModel.dataSource[indexPath.section];
    BaseCommonItemViewModel *itemViewModel = groupViewModel.itemViewModels[indexPath.row];
    return itemViewModel.rowHeight;
}

#pragma mark ************* TableView Delegate and DataSource End   *************

@end
