//
//  YLNiNeView.h
//  DYLTool
//
//  Created by sky on 2018/7/27.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YLNineViewDelegate <NSObject>

/// 新增cell点击事件
- (void)yl_addCellClick;

@end

@interface YLNiNeView : UIView

/// UICollectionView
@property (nonatomic, strong) UICollectionView *collectionView;
/// 数据源
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, weak) id<YLNineViewDelegate> delegate;

@end
