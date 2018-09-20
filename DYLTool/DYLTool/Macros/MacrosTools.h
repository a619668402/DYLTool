//
//  MacrosTools.h
//  DYLTool
//
//  Created by sky on 2018/6/12.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
                    常用的宏
 *********************************************/

#ifndef MacrosTools_h
#define MacrosTools_h

/**
 判断字符串是否为空

 @param str 字符串
 @return 返回 YES / NO
 */
#define KStringIsEmpty(str) (KObjectIsEmpty(str) || str == nil || str.length < 1 ? YES : NO)

/**
 判断数据是否为空

 @param array 数组
 @return 返回 YES / NO
 */
#define KArrayIsEmpty(array) (KObjectIsEmpty(array) || array.count == 0)

/**
 判断字典是否为空

 @param dic 字典
 @return 返回 YES / NO
 */
#define KDicIsEmpty(dic) (KObjectIsEmpty(dic) || dic.allKeys == 0)

/**
 判断是否是空对象

 @param _object 对象
 @return 返回 YES / NO
 */
#define KObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

/**
 获取屏幕宽度
 */
#define KScreenWidth \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)

/**
 获取屏幕高度
 */
#define KScreenHeight \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)

/**
 获取屏幕 Bounds
 */
#define KScreenSize \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale) : [UIScreen mainScreen].bounds.size)

/**
 状态栏+导航栏高度
 */
#define KNavAndStatusHeight self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height

/**
 判断是否是ipad
 */
#define ISPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
/**
 判断是否是iPhoneX
 */
#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !ISPad : NO)
/**
 判断iPHoneXr
 */
#define IS_PhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !ISPad : NO)
/**
 判断iPhoneXs
 */
#define IS_PhoneXs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !ISPad : NO)
/**
 判断iPhoneXs Max
 */
#define IS_PhoneXs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !ISPad : NO)
/**
 安全距离(iPhoneX, iPhoneXS, iPhoneXR, iPhoneXS_MAX 安全区距离底部34个像素)
 */
#define KSafeBottomMargin ((IS_iPhoneX == YES || IS_PhoneXr == YES || IS_PhoneXs == YES || IS_PhoneXs_Max == YES)? 34.f : 0.f)
/**
 Tabbar高度,(iPhoneX, iPhoneXS, iPhoneXR, iPhoneXS_MAX Tabbar高度等于自身高度 + 安全距离)
 */
#define KTabarAndSafeHeight ((IS_iPhoneX == YES || IS_PhoneXr == YES || IS_PhoneXs == YES || IS_PhoneXs_Max == YES) ? 83.0 : 49.0)

// Application 对象
#define KApplication [UIApplication sharedApplication]
// Window 对象
#define KKeyWindow   [UIApplication sharedApplication].keyWindow
#define KAppDelegate [UIApplication sharedApplication].delegate

// APP 版本号
#define KAppVersion  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 系统版本号
#define KSystemVersion  [[UIDevice currentDevice] systemVersion]

// 自定义打印信息
#ifdef DEBUG
#define KLog(format, ...)  printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else
#define KLog(...)
#endif
// 打印方法
#define KLogFunc KLog(@"%s", __func__)
// 打印错误
#define KLogError(error) KLog(@"%@", error)
// 打印销毁
#define KLogDealloc KLog(@"\n ------------------ %@ 销毁 ----------------- \n", [self class]);

#define KWeakSelf(type) __weak typeof(type) weak##type = type
#define KStrongSelf(type) __strong typeof(type) type   = weak##type

/// 适配iPhone X + iOS 11
#define KAdjustsScrollViewInsets_Never(__scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([__scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = __scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)

// GCD
// 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onckBlock);
// 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
// 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlock);

// 设置圆角
#define kCornerRadius(view, radius) [view.layer setCornerRadius:(radius)]; [view.layer setMasksToBounds:YES];
// 设置边框
#define kBorderWithAndColor(view, width, color) [view.layer setBorderWidth:(width)]; [view.layer setBorderColor:[color CGColor]];

// 字体适配 (375(4.7) 为默认屏幕)
#define KRadio(R) (R) * (KScreenWidth) / 375.0
#define KFont_8 [UIFont systemFontOfSize:KRadio(8.0)]
#define KFont_9 [UIFont systemFontOfSize:KRadio(9.0)]
#define KFont_10 [UIFont systemFontOfSize:KRadio(10.0)]
#define KFont_11 [UIFont systemFontOfSize:KRadio(11.0)]
#define KFont_12 [UIFont systemFontOfSize:KRadio(12.0)]
#define KFont_13 [UIFont systemFontOfSize:KRadio(13.0)]
#define KFont_14 [UIFont systemFontOfSize:KRadio(14.0)]
#define KFont_15 [UIFont systemFontOfSize:KRadio(15.0)]
#define KFont_16 [UIFont systemFontOfSize:KRadio(16.0)]
#define KFont_17 [UIFont systemFontOfSize:KRadio(17.0)]
#define KFont_18 [UIFont systemFontOfSize:KRadio(18.0)]
#define KFont_19 [UIFont systemFontOfSize:KRadio(19.0)]
#define KFont_20 [UIFont systemFontOfSize:KRadio(20.0)]
#define KFont_21 [UIFont systemFontOfSize:KRadio(21.0)]
#define KFont_22 [UIFont systemFontOfSize:KRadio(22.0)]
#define KFont_23 [UIFont systemFontOfSize:KRadio(23.0)]
#define KFont_24 [UIFont systemFontOfSize:KRadio(24.0)]
#define KFont_25 [UIFont systemFontOfSize:KRadio(25.0)]
#define KFont_26 [UIFont systemFontOfSize:KRadio(26.0)]
#define KFont_27 [UIFont systemFontOfSize:KRadio(27.0)]
#define KFont_28 [UIFont systemFontOfSize:KRadio(28.0)]

// 正常字体
#define N_8 [UIFont systemFontOfSize:8]
#define N_9 [UIFont systemFontOfSize:9]
#define N_10 [UIFont systemFontOfSize:10]
#define N_11 [UIFont systemFontOfSize:11]
#define N_12 [UIFont systemFontOfSize:12]
#define N_13 [UIFont systemFontOfSize:13]
#define N_14 [UIFont systemFontOfSize:14]
#define N_15 [UIFont systemFontOfSize:15]
#define N_16 [UIFont systemFontOfSize:16]
#define N_17 [UIFont systemFontOfSize:17]
#define N_18 [UIFont systemFontOfSize:18]
#define N_19 [UIFont systemFontOfSize:19]
#define N_20 [UIFont systemFontOfSize:20]
#define N_21 [UIFont systemFontOfSize:21]
#define N_22 [UIFont systemFontOfSize:22]
#define N_23 [UIFont systemFontOfSize:23]
#define N_24 [UIFont systemFontOfSize:24]
#define N_25 [UIFont systemFontOfSize:25]
#define N_26 [UIFont systemFontOfSize:26]
#define N_27 [UIFont systemFontOfSize:27]
#define N_28 [UIFont systemFontOfSize:28]

// 粗体
#define B_8 [UIFont boldSystemFontOfSize:8]
#define B_9 [UIFont boldSystemFontOfSize:9]
#define B_10 [UIFont boldSystemFontOfSize:10]
#define B_11 [UIFont boldSystemFontOfSize:11]
#define B_12 [UIFont boldSystemFontOfSize:12]
#define B_13 [UIFont boldSystemFontOfSize:13]
#define B_14 [UIFont boldSystemFontOfSize:14]
#define B_15 [UIFont boldSystemFontOfSize:15]
#define B_16 [UIFont boldSystemFontOfSize:16]
#define B_17 [UIFont boldSystemFontOfSize:17]
#define B_18 [UIFont boldSystemFontOfSize:18]
#define B_19 [UIFont boldSystemFontOfSize:19]
#define B_20 [UIFont boldSystemFontOfSize:20]
#define B_21 [UIFont boldSystemFontOfSize:21]
#define B_22 [UIFont boldSystemFontOfSize:22]
#define B_23 [UIFont boldSystemFontOfSize:23]
#define B_24 [UIFont boldSystemFontOfSize:24]
#define B_25 [UIFont boldSystemFontOfSize:25]
#define B_26 [UIFont boldSystemFontOfSize:26]
#define B_27 [UIFont boldSystemFontOfSize:27]
#define B_28 [UIFont boldSystemFontOfSize:28]

// 常用颜色
#define black_color     [UIColor blackColor]
#define blue_color      [UIColor  blueColor]
#define clear_color     [UIColor clearColor]
#define white_color     [UIColor whiteColor]
#define red_color       [UIColor   redColor]
#define gray_color      [UIColor  grayColor]
#define green_color     [UIColor greenColor]

#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


// 图片路径
#define PNGPATH(NAME)       [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)       [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define KPATH(NAME, EXT)    [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

// 加载图片
#define PNGImg(NAME)    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGImg(NAME)    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define KIMG(NAME, EXT) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]
#define M_IMG(IMGNAME)  [UIImage imageNamed:IMGNAME]

// 字符串
#define KURL(url)                            [NSURL URLWithString:url]
#define KStringWithFormat(string, args...)  [NSString stringWithFormat:string, args]
#define KS_INT(int)                         [NSString stringWithFormat:@"%d", num]
#define KS_INTEGER(integer)                 [NSString stringWithFormat:@"%ld", integer]

#endif /* MacrosTools_h */

