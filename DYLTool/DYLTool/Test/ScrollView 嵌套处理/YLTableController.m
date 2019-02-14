//
//  YLTableController.m
//  DYLTool
//
//  Created by sky on 2019/1/11.
//  Copyright © 2019年 DYL. All rights reserved.
//

#import "YLTableController.h"
#import "YLTableView.h"

@interface YLTableController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, readwrite) YLTableView *tableView;

@property (nonatomic, assign, readwrite) BOOL canScroll;

@end

@implementation YLTableController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)yl_initViews {
    self.tableView = [[YLTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, KSafeBottomMargin);
    [self.tableView yl_registerCell:[UITableViewCell class]];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = KStringWithFormat(@"第 %ld 行数据!", indexPath.row);
    return cell;
}

- (void)makeTableControllerScroll:(BOOL)canScroll {
    self.canScroll = canScroll;
    self.tableView.showsVerticalScrollIndicator = canScroll;
}

- (void)makeTableControllerScrollToTop {
    [self.tableView setContentOffset:CGPointZero];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0) {
        self.canScroll = NO;
        scrollView.contentOffset = CGPointZero;
        scrollView.showsVerticalScrollIndicator = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(tableControllerLeaveTop)]) {
            [self.delegate tableControllerLeaveTop];
        }
    }
}

@end
