//
//  UIScrollView+Refresh.m
//  DYLTool
//
//  Created by sky on 2018/6/26.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UIScrollView+YLRefresh.h"

@implementation UIScrollView (YLRefresh)

- (MJRefreshNormalHeader *)yl_addHeaderRefresh:(void (^)(MJRefreshNormalHeader *))refreshBlock {
    __weak __typeof(&*self) weakSelf = self;
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __weak __typeof(&*weakSelf) strongSelf = weakSelf;
        !refreshBlock ?: refreshBlock((MJRefreshNormalHeader *)strongSelf.mj_header);
    }];
    mj_header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = mj_header;
    return mj_header;
}

- (MJRefreshAutoNormalFooter *)yl_addFooterRefresh:(void (^)(MJRefreshAutoNormalFooter *))refreshBlock {
    __weak __typeof(&*self) weakSelf = self;
    MJRefreshAutoNormalFooter *mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __weak __typeof(&*weakSelf) strongSelf = weakSelf;
        !refreshBlock ?: refreshBlock((MJRefreshAutoNormalFooter *)strongSelf.mj_footer);
    }];
    [mj_footer setTitle:@"别拉了,已经到底了..." forState:MJRefreshStateNoMoreData];
    self.mj_footer = mj_footer;
    return mj_footer;
}

@end
