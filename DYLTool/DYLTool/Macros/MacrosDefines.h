//
//  MacrosDefines.h
//  DYLTool
//
//  Created by sky on 2018/9/26.
//  Copyright © 2018年 DYL. All rights reserved.
//

#ifndef MacrosDefines_h
#define MacrosDefines_h

/**
 如果 fromClass 里面存在 originSelector, 则这个函数会将 fromClass 里的 originSelector 与 toClass 里的 newSelector 交换实现
 如果 fromClass 里面不存在 originSelector, 则这个函数会为 fromClass 增加方法 originSelector, 并且该方法会使用 toClass 的 newSelector 方法的实现, 而 toClass 的 newSelector 方法的实现则会被替换为空内容
 @warning 如果 fromClass 里的 originSelector 是继承子父类并且 fromClass 也没有重写这个方法,这会导致实际上被替换的是父类,然后父类及父类的所有子类(也即 fromClass 的兄弟类)也受影响.
 
 @param _fromClass 要被替换的 class, 不能为空
 @param _originSelector 要被替换的 class 的 selector, 可为空, 为空相当于为 fromClass 新增这个方法
 @param _toClass 要拿这个 class 的方法替换
 @param _newSelector 要拿 toClass 里的这个方法来替换 originSelector
 @return 是否成功替换(或增加)
 */
static inline BOOL ExchangeImplementationInTwoClasses(Class _fromClass, SEL _originSelector, Class _toClass, SEL _newSelector) {
    if (!_fromClass || !_toClass) {
        return NO;
    }
    Method oriMethod = class_getInstanceMethod(_fromClass, _originSelector);
    Method newMethod = class_getInstanceMethod(_toClass, _newSelector);
    if (!newMethod) {
        return NO;
    }
    BOOL isAddedMethod = class_addMethod(_fromClass, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        IMP oriMethodIMP = method_getImplementation(oriMethod) ?: imp_implementationWithBlock(^(id selfObject) {});
        const char *oriMethodTypeEncoding = method_getTypeEncoding(oriMethod) ?: "v@:";
        class_replaceMethod(_toClass, _newSelector, oriMethodIMP, oriMethodTypeEncoding);
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
    return YES;
}
/// 交换同一个 class 里面的 originSelector 和 newSelector的实现,如果原本不存在 originSelector, 则相当于给 class 新增一个 originSelector 的方法
static inline BOOL ExchangeImplementations(Class _class, SEL _originSelector, SEL _newSelector) {
    return ExchangeImplementationInTwoClasses(_class, _originSelector, _class, _newSelector);
}

/**
 *  某些地方可能会将 CGFLOAT_MIN 作为一个数值参与计算（但其实 CGFLOAT_MIN 更应该被视为一个标志位而不是数值），可能导致一些精度问题，所以提供这个方法快速将 CGFLOAT_MIN 转换为 0
 */
static inline CGFloat removeFloatMin(CGFloat floatValue) {
    return floatValue == CGFLOAT_MIN ? 0 : floatValue;
}

/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */
static inline CGFloat flatSpecificScale(CGFloat floatValue, CGFloat scale) {
    floatValue = removeFloatMin(floatValue);
    scale = scale == 0 ? kScreenScale : scale;
    CGFloat flattedValue = ceil(floatValue * scale) / scale;
    return flattedValue;
}

/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flat() 函数，而应该用 flatSpecificScale
 */
static inline CGFloat flat(CGFloat floatValue) {
    return flatSpecificScale(floatValue, 0);
}

static inline CGSize CGSizeFlatted(CGSize size) {
    return CGSizeMake(flat(size.width), flat(size.height));
}

/// 判断一个CGSize是否存在infinite
static inline BOOL CGSizeIsInf(CGSize size) {
    return isinf(size.width) || isinf(size.height);
}

/// 判断一个CGSize是否为空(宽或高为0)
static inline BOOL CGSizeIsEmpty(CGSize size) {
    return size.width <= 0 || size.height <= 0;
}

/// 判断一个CGSize是否存在NaN
static inline BOOL CGSizeIsNaN(CGSize size) {
    return isnan(size.width) || isnan(size.height);
}

static inline BOOL CGSizeIsValidated(CGSize size) {
    return !CGSizeIsEmpty(size) && !CGSizeIsInf(size) && !CGSizeIsNaN(size);
}

static inline CGRect CGRectMakeWithSize(CGSize size) {
    return CGRectMake(0, 0, size.width, size.height);
}

static inline BOOL KISIPhoneXSeries() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}

#endif /* MacrosDefines_h */
