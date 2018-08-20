//
//  UIScrollView+Refresh.h
//  DYLTool
//
//  Created by sky on 2018/6/26.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
            添加上拉加载更多,下拉刷新
 *********************************************/
#import <UIKit/UIKit.h>
#import <MJRefresh.h>

@interface UIScrollView (YLRefresh)

/**
 添加下拉刷新控件

 @param refreshBlock <#refreshBlock description#>
 @return <#return value description#>
 */
- (MJRefreshNormalHeader *)yl_addHeaderRefresh:(void(^)(MJRefreshNormalHeader *header))refreshBlock;

/**
 添加上拉加载控件

 @param refreshBlock <#refreshBlock description#>
 @return <#return value description#>
 */
- (MJRefreshAutoNormalFooter *)yl_addFooterRefresh:(void(^)(MJRefreshAutoNormalFooter *footer))refreshBlock;

@end
