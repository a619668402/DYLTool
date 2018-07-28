//
//  YLNiNeView.m
//  DYLTool
//
//  Created by sky on 2018/7/27.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLNiNeView.h"
#import "YLNineCollectionViewCell.h"

@interface YLNiNeView ()<UICollectionViewDelegate, UICollectionViewDataSource, YLNineCollectionViewCellDelegate>
@end

@implementation YLNiNeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _initViews];
    }
    return self;
}

- (void)layoutSubviews {
    KWeakSelf(self);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.mas_top).offset(0);
        make.left.equalTo(weakself.mas_left).offset(0);
        make.right.equalTo(weakself.mas_right).offset(0);
        make.bottom.equalTo(weakself.mas_bottom).offset(0);
    }];
}

#pragma mark ************* Private Method Start *************
- (void)_initViews {
    [self addSubview:self.collectionView];
}
#pragma mark ************* Private Method End   *************

#pragma mark ************* CollectionView Delegate and DataSource Start *************
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YLNineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YLNineCollectionViewCell class]) forIndexPath:indexPath];
    [cell setData:self.dataSource indexPath:indexPath];
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.dataSource.count) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(yl_addCellClick)]) {
            [self.delegate yl_addCellClick];
        }
    }
}

#pragma mark ************* CollectionView Delegate and DataSource End   *************

#pragma mark ************* YLNineCollectionViewCell Delegate Start *************
- (void)yl_deleteBtnClick:(NSUInteger)index {
    KLog(@"-----%ld", index);
    [self.dataSource removeObjectAtIndex:index];
    [self.collectionView reloadData];
}
#pragma mark ************* YLNineCollectionViewCell Delegate End   *************

#pragma mark ************* Lazyload Start *************
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 1.0f;
        layout.minimumInteritemSpacing = 1.0f;
        float width = (KScreenWidth - 5) / 4.f;
        layout.itemSize = CGSizeMake(width, width);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.yl_width, self.yl_height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor grayColor];
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[YLNineCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([YLNineCollectionViewCell class])];
    }
    return _collectionView;
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    [self.collectionView reloadData];
}
#pragma mark ************* Lazyload End   *************

@end
