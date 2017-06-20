//
//  MethodDefine.h
//  ZPSY
//
//  Created by zhouhao on 2017/2/4.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#ifndef MethodDefine_h
#define MethodDefine_h
/**
 *  系统版本号
 */
#define kIosVersion [[[UIDevice currentDevice] systemVersion] floatValue]
/**
 *  keyWindow
 */
#define kWindow [UIApplication sharedApplication].keyWindow
// 颜色
/**
 *  RGBAcolor
 */
#define kColorA(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
/**
 *  RGBcolor
 */
#define kColor(R,G,B) kColorA(R,G,B,1.0)
/**
 *  color with value
 */
#define kColorValue(value) kColorA(value,value,value,1.0)
/**
 *  16进制color
 */
#define kColor_hex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 *LOG
 */
#ifndef __UpLine__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

#ifndef	BLOCK_SAFE
#define BLOCK_SAFE(block)           if(block)block
#endif

/*
 *  APP信息
 */
#define APPDELEGATE (AppDelegate*)[[UIApplication sharedApplication]  delegate]
/**
 *  获取屏幕尺寸
 */

#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenSize   kScreenBounds.size
#define kScreenWidth  kScreenSize.width
#define kScreenHeight kScreenSize.height
#define k_is_iPhone5 kScreenWidth==kWidth_iPhone5
#define kWidth_iPhone5    320.0f
#define kWidth_iPhone6    375.0f
#define kWidth_iPhone6p   414.0f
#define kHeight_iPhone5   568.0f
#define kHeight_iPhone6   667.0f
#define kHeight_iPhone6p  736.0f



/**
 *  比例（适配）
 */
#define kScaleOfScreen     kScreenWidth/kWidth_iPhone6    //屏幕比例
#define kWidth_fit(value)  kScaleOfScreen * value         //计算适配宽度
#define kHeight_fit(value) kScaleOfScreen * value         //计算适配高度

//----------------------其他----------------------------
//方正黑体简体字体定义
#define kFontSystem(X)  [UIFont systemFontOfSize:X]
#define kFontSystemBold(X) [UIFont boldSystemFontOfSize:X]
#define kFontMedium(X) [UIFont fontWithName:@"STHeitiSC-Medium" size:X]
#define kFontLight(X) [UIFont fontWithName:@"STHeitiSC-Light" size:X]
#define kFontArialMT(X) [UIFont fontWithName:@"ArialMT" size:X]
//设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]
//程序的本地化,引用国际化的文件
#define MyLocal(x, ...) NSLocalizedString(x, nil)

//----------------------图片----------------------------
//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
//定义UIImage对象
#define ImageNamed(A) [UIImage imageNamed:A]
//去除遮光效果
#define ImageRenderingMode(A)   [[UIImage imageNamed:A] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]

//placeholdeImageStr
#define PlaceHoldeImageStr @"placeHoldeImage"





//建议使用前两种宏定义,性能高于后者

#ifndef isDictWithCountMoreThan0

#define isDictWithCountMoreThan0(__dict__) \
(__dict__!=nil && \
[__dict__ isKindOfClass:[NSDictionary class] ] && \
__dict__.count>0)

#endif

#ifndef isArrayWithCountMoreThan0

#define isArrayWithCountMoreThan0(__array__) \
(__array__!=nil && \
[__array__ isKindOfClass:[NSArray class] ] && \
__array__.count>0)

#endif




#endif /* MethodDefine_h */
