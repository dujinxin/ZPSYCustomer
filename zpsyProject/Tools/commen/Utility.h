//
//  Utility.h
//  NoWait
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

int hwaddr_aton(const char *txt, unsigned char *addr);

typedef struct _UdpCmd
{
    int cmdtype;
    int len;
    unsigned char macaddr[6];
}T_UdpCmd;

typedef struct _UdpRes
{
    int cmdtype;//AP：3；
    int len;//AP：10
    unsigned int time;//AP:手机剩余多长时间（秒）
    unsigned char macaddr[6];//AP:手机的6字节mac地址
}T_UdpRes;

typedef NS_ENUM(NSInteger, MWWeekday){
    MWWeekdaySunday,      // 周日
    MWWeekdayMonday,      // 周一
    MWWeekdayTuesday,     // 周二
    MWWeekdayWednesday,   // 周三
    MWWeekdayThursday,    // 周四
    MWWeekdayFriday,      // 周五
    MWWeekdaySaturday,    // 周六
    MWWeekdayAllWeek,     // 所有
};
@interface Utility : NSObject

// 获取设备UUID地址，AABBCCDDEEFF
+ (NSString *)getUUIDAddress;
+ (NSString * )macString;
+ (NSString *)idfaString;
+ (NSString *)idfvString;
// 获取设备IP地址
+ (NSString *)getWLanIPAddresses;
+ (NSString *)getHWAddresses;

// 打开应用的设置页面，iOS8开始支持，以下弹出提示框,显示msg
+ (void)openAppAuthorityManagerment;

// 取得用户接入的AP信息
+ (id)fetchSSIDInfo;

// MD5加密算法
+ (NSString *)encodeMD5:(NSString*)entity;

// BASE64加密算法
+ (NSString*)encodeBASE64:(NSData *)data;

// BASE64解密算法
+ (NSData*)decodeBASE64:(NSString *)string;

// 字符串转换为日期格式
+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString*)format;
+ (NSString *)mdStringFromDate:(NSDate *)date;
+ (NSString *)hmStringFromDate:(NSDate *)date;
// 日期格式转换为字符串显示
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString*)format;

// "星期几"
+ (NSString *)weekdayStringFromDate:(NSDate*)inputDate;
// "几月"
+ (NSString*)monthStringFromDate:(NSDate*)date;
// 获得日期组件，可以拿到 年、月、日、星期、时、分、秒等
+ (NSDateComponents*)dateComponentsWithDate:(NSDate *)inputDate;
+ (MWWeekday)weekdayWithDate:(NSDate*)date;
// 删除沙盒中的文件
+(BOOL) deleteSingleFile:(NSString *)filePath;

/** 将数组/字典  写入指定文件名的文件中 */
+(BOOL)addFileWithName:(NSString*)fileName withArray:(NSArray*)arr;
+(NSArray*)getArrayWithFileName:(NSString*)fileName;
+(BOOL)addFileWithName:(NSString*)fileName withDict:(NSDictionary*)dict;
+(NSDictionary*)getDictWithFileName:(NSString*)fileName;
// 获得文件路径(根据文件名)
+(NSString*)getFilePathWithFileName:(NSString*)fileName;


+ (BOOL)checkJson:(id)json withValidator:(id)validatorJson;
+ (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters;
+ (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters;
+ (NSString*)urlEncode:(NSString*)str;
+ (NSString *)URLDecodedString:(NSString*)str;
+ (NSString *)md5StringFromString:(NSString *)string;
+ (void)addDoNotBackupAttribute:(NSString *)path;
+ (NSString *)appVersionString;
+ (NSString *)appBundleIdentifier;
+ (NSString *)appBuild;
+ (NSString *)systemVersionString;
+ (NSString *)deviceModelString;
+ (NSString *)deviceUUIDString;

// 根据16进制和alpha计算UIColor
+ (UIColor *)HEX2Color:(NSInteger)hexCode inAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(NSInteger)hexCode;
+ (UIColor *)colorWithHex:(NSInteger)hexCode alpha:(CGFloat)alpha;
+ (UIColor *)colorWithRandom;

+ (UIColor *)JXColorFromRGB:(NSInteger)rgbValue;
+ (UIColor *)JXColorFromRGBA:(NSInteger)rgbValue alpha:(CGFloat)a;
+ (UIColor *)JXColorFromR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue;
+ (UIColor *)JXColorFromR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;
+ (UIColor *)jxDebugColor;


+ (NSString*)getCurrentDeviceModel;
+ (BOOL)checkAVDeniedStatus;//判断是否用户禁止访问相机
+ (BOOL)checkPhotoDeniedStatus;
+ (void)playSoundWithName:(NSString *)name type:(NSString *)type;
+ (void)updateShopNameLabel:(UILabel *)label shopName:(NSString*)shopName;
/**
 *  价格转换方法。Float->NSString。
 *
 *  @param price     浮点型的价格。如5.0、5.03、-5.0
 *  @param prefixStr 字符串的价格标志。可为空。
 *
 *  @return 字符串价格。如"￥5"、"￥5.03"、"免费"
 */
+ (NSString *)stringWithPrice:(CGFloat)price  prefix:(NSString *)prefixStr;

/**
 *  价格转换方法。Float->NSString。
 *
 *  @param price     浮点型的价格。如5.0、5.03、-5.0
 *  @param prefixStr 字符串的价格标志。可为空。
 *  @param isDefault 是否使用默认前缀。默认"￥"
 *
 *  @return 字符串价格。如"￥5"、"￥5.03"、"免费"
 */
+ (NSString *)stringWithPrice:(CGFloat)price prefix:(NSString *)prefixStr isDefaultPrefix:(BOOL)isDefault;
//图片用color展示
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (void)setUserPhone:(NSString *)phone;
+ (NSString *)userPhone;

+ (CGFloat)distanceFromLocation2D:(CLLocationCoordinate2D *)fromLocation2D toLocation2D:(CLLocationCoordinate2D *)toLocation2D;
+ (CGFloat)distanceFromLocation:(CLLocation *)fromLocation toLocation:(CLLocation *)toLocation; // 单位：米

+ (NSDate *)getCustomDateWithHour:(NSInteger)hour;
+ (NSDate *)getCustomDateWithHour:(NSInteger)hour minute:(NSInteger)minute;

+ (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour;
//05:00 - 19:00
+ (BOOL)isBetweenFromStringHour:(NSString *)fromHour toStringHour:(NSString *)toHour;

/*!
 @author Li.rongrui, 16-08-24 15:08:05
 
 @brief 字典键值转换，主要用于jsonModel
 
 @param dictionary NSDictionary
 
 @return NSDictionary
 */
+ (NSDictionary *)swapKeysAndValuesInDictionary:(NSDictionary *)dictionary;
@end
