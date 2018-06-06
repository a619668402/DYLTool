//
//  DYLEmptyView.h
//  EmptyView
//
//  Created by sky on 2018/5/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PlaceholderViewType) {
    /** 没网 */
    PlaceholderViewTypeNoNetWork = 1,
    /** 没数据 */
    PlaceholderViewTypeNoData,
    /** 服务器 500 */
    PlaceholderViewTypeServerError
};

@class PlaceholderView;
@protocol PlaceholderViewDelegate <NSObject>

/** 占位图重新加载加载按钮点击回调 */
- (void)placeholderView:(PlaceholderView *)placeholderView reloadButtonDidClick:(UIButton *)sender;

@end

@interface PlaceholderView : UIView

/** 占位图类型 (只读) */
@property (nonatomic, assign, readonly) PlaceholderViewType type;

@property (nonatomic, weak, readonly) id <PlaceholderViewDelegate> delegate;

/**
 *  构造方法
 *  @param frame 占位图frame
 *  @param type  占位图类型
 *  @param delegate 占位图代理方
 *  return 指定frame,类型和代理方法的占位图
 */
- (instancetype)initWithFrame:(CGRect)frame type:(PlaceholderViewType)type delegate:(id)delegate;

@end
