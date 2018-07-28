//
//  NineCollectionViewCell.h
//  DYLTool
//
//  Created by sky on 2018/7/27.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YLNineCollectionViewCellDelegate <NSObject>

/// 删除按钮点击事件
///
/// @param index        点击Cell索引
- (void)yl_deleteBtnClick:(NSUInteger)index;

@end

@interface YLNineCollectionViewCell : UICollectionViewCell
/// 展示图片
@property (nonatomic, strong) UIImageView *imgView;

/// 删除图标
@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, weak) id<YLNineCollectionViewCellDelegate> delegate;

/// 设置 Cell 中的数据
///
/// @param dataSource   数据源
/// @param indexPath    索引
- (void)setData:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath;

@end
