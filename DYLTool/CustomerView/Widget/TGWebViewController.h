//
//  TGViewController.h
//  CustomerView
//
//  Created by sky on 2018/6/7.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
            通用 WebViewController
 *********************************************/
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface TGWebViewController : UIViewController

/**
 请求的url
 */
@property (nonatomic,copy) NSString *urlString;

/**
 要注入的js方法
 */
@property (nonatomic,copy) NSString *jsString;

/**
 进度条颜色
 */
@property (nonatomic,strong) UIColor *loadingProgressColor;

/**
 是否下拉重新加载
 */
@property (nonatomic, assign) BOOL canDownRefresh;

@end
