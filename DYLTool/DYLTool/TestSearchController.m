//
//  TestSearchController.m
//  DYLTool
//
//  Created by sky on 2018/7/4.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestSearchController.h"
#import "TestSearchController_1.h"
#import "TestCommonViewController.h"
#import "TestCommonViewModel.h"

@interface TestSearchController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) NSMutableArray *results;

@property (nonatomic, strong) UIView *customerNav;

@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation TestSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)yl_initViews {
    [super yl_initViews];
    [self.view addSubview:self.customerNav];
    [self.customerNav addSubview:self.backBtn];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)yl_initValues {
    [super yl_initValues];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active) {
        return self.results.count;
    }
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (self.searchController.active) {
        cell.textLabel.text = self.results[indexPath.item];
    } else {
        cell.textLabel.text = self.datas[indexPath.item];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.item == 1) {
        /*
        TestSearchController_1 *vc = [[TestSearchController_1 alloc] initWithViewModel:nil];
        [self.navigationController pushViewController:vc animated:YES];
         */
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//        self.navigationItem.backBarButtonItem = backItem;
        TestCommonViewModel *viewModel = [[TestCommonViewModel alloc] initWithParams:nil services:nil];
        TestCommonViewController *vc = [[TestCommonViewController alloc] initWithViewModel:viewModel];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *inputStr = [searchController.searchBar text];
    if (self.results.count > 0) {
        [self.results removeAllObjects];
    }
    for (NSString *str in self.datas) {
        if ([str.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
            [self.results addObject:str];
        }
    }
    [self.tableView reloadData];
}

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    // 判断要显示的控制器是自己
//    BOOL isSelf = [viewController isKindOfClass:[self class]];
//    if (isSelf) {
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//    } else {
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//    }
//}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < 30; i ++) {
            [_datas addObject:[NSString stringWithFormat:@"测试--- %d", i]];
        }
    }
    return _datas;
}

- (NSMutableArray *)results {
    if (!_results) {
        _results = [NSMutableArray arrayWithCapacity:0];
    }
    return _results;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
    }
    return _searchController;
}


- (UIView *)customerNav {
    if (!_customerNav) {
        _customerNav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 64)];
        _customerNav.backgroundColor = [UIColor whiteColor];
    }
    return _customerNav;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _backBtn.frame = CGRectMake(0, 20, 60, 44);
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        _backBtn.titleLabel.textColor = [UIColor whiteColor];
        [_backBtn setImage:[UIImage imageNamed:@"barbuttonicon_back_15x30"] forState:UIControlStateNormal];
        @weakify(self);
        [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _backBtn;
}

@end
