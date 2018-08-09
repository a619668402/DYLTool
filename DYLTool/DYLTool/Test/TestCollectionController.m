//
//  TestCollectionController.m
//  DYLTool
//
//  Created by sky on 2018/8/8.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestCollectionController.h"
#import "TestCollectionViewCell.h"

@interface TestCollectionController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation TestCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)yl_initValues {
    [super yl_initValues];
}

- (void)yl_initViews {
    [super yl_initViews];
    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, KNavAndStatusHeight + 10, KScreenWidth - 20, KScreenHeight - KNavAndStatusHeight - 10) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.clipsToBounds = NO;
        [_collectionView registerClass:[TestCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([TestCollectionViewCell class])];
        _collectionView.backgroundColor = white_color;
    }
    return _collectionView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        [_dataSource addObject:@"Java"];
        [_dataSource addObject:@"Object-C"];
        [_dataSource addObject:@"JavaScript"];
        [_dataSource addObject:@"Python"];
        [_dataSource addObject:@"C#"];
        [_dataSource addObject:@"PHP"];
        [_dataSource addObject:@".NET"];
        [_dataSource addObject:@"HTML"];
        [_dataSource addObject:@"大数据"];
        [_dataSource addObject:@"区块链"];
        [_dataSource addObject:@"正则表达式"];
        [_dataSource addObject:@"C++"];
        [_dataSource addObject:@"C"];
        [_dataSource addObject:@"GO"];
        [_dataSource addObject:@"Android"];
        [_dataSource addObject:@"计算机网络"];
    }
    return _dataSource;
}

- (void)_btnClick:(UIButton *)btn {
    TestCollectionViewCell *cell = (TestCollectionViewCell *)[[[btn superview] superview] superview];
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    [self.dataSource removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

#pragma mark ************* Collection Delegate and DataSource Start *************
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [self.dataSource[indexPath.item] yl_widthWithFontSize:15.f height:35];
    return CGSizeMake(width + 30, 55);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TestCollectionViewCell class]) forIndexPath:indexPath];
    [cell setModel:self.dataSource[indexPath.item]];
    [cell.btn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
#pragma mark ************* Collection Delegate and DataSource End   *************
@end
