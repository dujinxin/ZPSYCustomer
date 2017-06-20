//
//  CTTool.h
//  dataBank
//
//  Created by 章晓 on 16/9/12.
//  Copyright © 2016年 CT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,Authorization) {
    AuthorizationTakePhoto = 0,
    AuthorizationPhoto = 1,
    AuthorizationAudio = 2,
    AuthorizationLocation = 3,
};

@interface CTUtility : NSObject

+ (NSString *)stringFromString:(NSString*)timerStr sourceformat:(NSString*)sourceformat toFormat:(NSString*)toFormatStr;

+ (NSString *)stringFromDate:(NSDate *)date;

/**
 *  字符串转date
 */
+ (NSDate *)dateFromString:(NSString *)timeStr format:(NSString *)format;

/**
 *  时间戳转字符串
 */
+ (NSString *)stringFromDatesp:(NSString *)datesp;

/**
 *  判断是否为整形
 */
+ (BOOL)judgeWithText:(UITextField *)textField;

/**
 *  判断是否为emoji
 */
+ (BOOL)judgeEmoji:(NSString *)string;

/**
 *获取当前时间戳
 */
+ (NSString *)GetTimeStamp;
/**
 *  获取当前时间(date)
 */
+(NSDate *)getLocalDate;

/**
 *  获取当前时间(字符串，时间戳)
 */
+ (NSDictionary *)getLocalTimeDict;

/**
 *  时间戳转字符串
 */
+ (NSMutableArray *)arrayWithDateSp:(NSString *)datesp;

/**
 *  时间NSDate转字符串
 */
+ (NSMutableArray *)arrayWithDate:(NSDate *)date;

/**
 *  获取父控制器
 */
+ (UIViewController *)findViewController:(UIView *)sourceView;

/**
 *  比较时间差
 */
+ (NSDateComponents *)componentsNowdate:(NSDate *)nowdate toDate:(NSDate *)todate;

/**
 * 得到version
 */
+ (NSString *)getAppVersion;

/**
 *  获得appiocnname
 */
+ (NSString *)getAppIconName;
/**
 *  获得appname
 */
+(NSString*)getAppName;
/**
 *  获取app的各种权限设置
 */
+ (BOOL)handleWithAuthWith:(Authorization)Authorization;

/**
 *  截图
 */
+ (UIImage *)getSnapshotImage;

/**
 *  判断邮箱是否合法
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 *  判断电话号码是否合法
 */
+ (BOOL)isValidateMobile:(NSString *)mobile;

/**
 *  判断类中是否包含一个属性
 */
+ (BOOL)getVariableWithClass:(Class) myClass varName:(NSString *)name;

/**
 *  数字验证
 */
+ (BOOL)validateNumber:(NSString *)mobile length:(NSInteger)num;

/**
 *  qq号验证
 */
+ (BOOL)validateQQ:(NSString *)qq;

/**
 *  数字验证
 */
+ (NSString *)checkNumberString:(NSString *)string;

/**
 *  昵称  //|[。、，； ：“”《》！（）¥？] 正则
 */
+ (BOOL)validateNickname:(NSString *)nickname length:(NSInteger)num;

/**
 *  中文英文数字
 */
+ (BOOL)validateString:(NSString *)string length:(NSInteger)num;

/**
 *  真实姓名验证
 */
+ (BOOL)validateNameString:(NSString *)string length:(NSInteger)num;

/**
 *  微信号验证
 */
+ (BOOL)validateWeixinString:(NSString *)string length:(NSInteger)num;

/*
 *  真实姓名 check  默认 十六个英文字母 或 十六个中文汉字 返回yes
 */
+ (BOOL)checkNameString:(NSString *)string length:(NSInteger)num;

/*
 *  中英文  默认 英文字母+中文汉字 十六个 返回yes
 */
+ (BOOL)checkNameChineseAndEnglish:(NSString *)string length:(NSInteger)num;

/**
 *  当前window最上层的控制器
 */
+ (UIViewController *)currentWindowTopViewController;

/**
 *  获取当前window的跟控制器
 */
+ (UIViewController *)windowRootViewController;

/**
 *  获得当前根控制器的顶部控制器
 */
+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController;



/**
 sha256加密

 @param str 要加密的sourceString
 @return 加过密的string
 */
+ (NSString*)sha256WithStr:(NSString*)str;


/**
 获取IP

 @param preferIPv4 是否只支持IP4
 @return 字符串格式 00:00:00:00
 */
+ (NSString *)getIPAddress:(BOOL)preferIPv4;


/**
 获取当前控制器
 */
+ (UIViewController *)getCurrentVC;
@end
