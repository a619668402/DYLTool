//
//  UINavigationController+YLNavigationBarTransition.h
//  DYLTool
//
//  Created by sky on 2018/9/26.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    系统的UINavigationController只有一个navBar,所以会导致在切换Controller的时候,如果两个Controller的navBar不一致(包括backgroundImage,shadowImage,barTintColor等等),就会导致在刚要切换的瞬间,navBar的状态都立马变成下一个Controller所设置的样式
 */
@interface UINavigationController (YLNavigationBarTransition)

@end
