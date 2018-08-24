//
//  UIButton+Layout.h
//  DYLTool
//
//  Created by sky on 2018/7/23.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
          设置 title 和 image 大小和坐标
 *********************************************/
#import <UIKit/UIKit.h>

@interface UIButton (YLLayout)

@property (nonatomic, assign) CGRect titleRect;

@property (nonatomic, assign) CGRect imageRect;

@end
