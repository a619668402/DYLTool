//
//  TestFilterViewController.m
//  DYLTool
//
//  Created by sky on 2018/7/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestFilterViewController.h"
#import "YLTopFilterView.h"
#import "YLTopFilterViewModel.h"

@interface TestFilterViewController ()

@property (nonatomic, strong) YLTopFilterViewModel *filterViewModel;

@property (nonatomic, strong) YLTopFilterView *filterView;

@end

@implementation TestFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)yl_initViews {
    [super yl_initViews];
    self.filterView = [[YLTopFilterView alloc] initWithFrame:CGRectMake(0, KNavAndStatusHeight, KScreenWidth, 45) viewModel:self.filterViewModel];
    [self.view addSubview:self.filterView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(self.filterView.yl_x, self.filterView.yl_bottom, self.filterView.yl_width, 0)];
    view1.backgroundColor = [UIColor greenColor];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(self.filterView.yl_x, self.filterView.yl_bottom, self.filterView.yl_width, 0)];
    view2.backgroundColor = [UIColor grayColor];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(self.filterView.yl_x, self.filterView.yl_bottom, self.filterView.yl_width, 0)];
    view3.backgroundColor = [UIColor redColor];
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(self.filterView.yl_x, self.filterView.yl_bottom, self.filterView.yl_width, 0)];
    view4.backgroundColor = [UIColor blackColor];
    self.filterViewModel.viewSource = @[view1, view2, view3, view4];
}

- (void)yl_initValues {
    [super yl_initValues];
    self.filterViewModel = [[YLTopFilterViewModel alloc] init];
    self.filterViewModel.dataSource = @[@"歌手", @"专辑", @"主播电台", @"用户"];
    self.filterViewModel.selectColor = [UIColor redColor];
    self.filterViewModel.fontSize = 16.0f;
}

@end
