//
//  CTTool.m
//  dataBank
//
//  Created by 章晓 on 16/9/12.
//  Copyright © 2016年 CT. All rights reserved.
//

#import "CTUtility.h"
#import <objc/runtime.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>

#define arrayType @[@"yyyy",@"MM",@"dd",@"HH",@"mm",@"ss"]

@implementation CTUtility

+ (BOOL)judgeWithText:(UITextField *)textField{
    NSString *string = textField.text;
    //判断最后一位是否为小数点
    if (string.length != 0) {
        NSString *lastString = [string substringFromIndex:[string length]-1];
        if ([lastString isEqualToString:@"."]) {
            textField.text = [string substringToIndex:[string length]-1];
        }
    }
    
    //判断是否为整形：
    NSScanner* scanint = [NSScanner scannerWithString:string];
    int intval;
    BOOL judgeInt = [scanint scanInt:&intval] && [scanint isAtEnd];
    
    //判断是否为浮点形：
    NSScanner* scanfloat = [NSScanner scannerWithString:string];
    float floatval;
    BOOL judgeFloat = [scanfloat scanFloat:&floatval] && [scanfloat isAtEnd];
    
    if (judgeInt || judgeFloat) {
        if ([string floatValue]>=0 && [string intValue]>=0) {
            return YES;
        }else{
            return NO;
        }
    } else{
        return NO;
    }
}

//判断是否为emoji
+ (BOOL)judgeEmoji:(NSString *)string{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}

//获取当前时间
+(NSDate *)getLocalDate{
    return [NSDate date];//获取当前时间，日期
}


+ (NSString *)stringFromString:(NSString*)timerStr sourceformat:(NSString*)sourceformat toFormat:(NSString*)toFormatStr{
    NSDate *date=[CTUtility dateFromString:timerStr format:sourceformat];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:toFormatStr];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return  strDate;
}

+ (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return  strDate;
}

+ (NSDate *)dateFromString:(NSString *)timeStr format:(NSString *)format{
    NSDateFormatter *dateFromatter = [[NSDateFormatter alloc] init];
    [dateFromatter setDateFormat:format?format:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFromatter dateFromString:timeStr];
    return date;
}

+ (NSString *)stringFromDatesp:(NSString *)datesp{
    NSTimeInterval timeint=[datesp integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeint];

    return  [self stringFromDate:date];
}

+ (NSString *)GetTimeStamp{
    NSDate *currentDate = [NSDate date];
    return [NSString stringWithFormat:@"%ld", (long)[currentDate timeIntervalSince1970]];
}
//获取当前时间
+ (NSDictionary *)getLocalTimeDict{
    NSDictionary *dict;
    NSDate *currentDate = [NSDate date];//获取当前时间，日期

    dict = @{@"timestring":[CTUtility stringFromDate:currentDate],@"timesp":[NSString stringWithFormat:@"%ld", (long)[currentDate timeIntervalSince1970]]};
    
    return dict;
}

//时间戳转字符串
+ (NSMutableArray *)arrayWithDateSp:(NSString *)datesp{
    NSTimeInterval timeint=[datesp integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeint];
    return [self arrayWithDate:date];
}

//时间NSDate转字符串
+ (NSMutableArray *)arrayWithDate:(NSDate *)date{
    NSMutableArray *dictTemp = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:arrayType[i]];
        NSString *strDate = [dateFormatter stringFromDate:date];
        [dictTemp addObject:strDate];
    }
    return dictTemp;
}

//获取父控制器
+ (UIViewController *)findViewController:(UIView *)sourceView
{
    id target=sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

//比较时间差
+ (NSDateComponents *)componentsNowdate:(NSDate *)nowdate toDate:(NSDate *)todate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    return [calendar components:unit fromDate:nowdate toDate:todate options:0];
}

+ (NSString *)getAppVersion{
    //获得info
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    // app version
    return [NSString stringWithFormat:@"%@.%@",app_Version,app_build];
}

+ (NSString *)getAppIconName{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *iconName = [[infoDic valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    return iconName;
}
+(NSString*)getAppName{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDic objectForKey:@"CFBundleDisplayName"];
    return appName;
}
//获取各种权限
+ (BOOL)handleWithAuthWith:(Authorization)Authorization{
    __block BOOL Autho = NO;
    //相机
    if (Authorization == AuthorizationTakePhoto){
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
            Autho = NO;
        } else {
            Autho = YES;
        }
    }
    //相册
    else if(Authorization == AuthorizationPhoto){
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        if (status == kCLAuthorizationStatusDenied || kCLAuthorizationStatusRestricted) {
            Autho = NO;
        } else {
            Autho = YES;
        }
    }
    //定位
    else if(Authorization == AuthorizationLocation){
        //定位服务是否可用
        BOOL enable=[CLLocationManager locationServicesEnabled];
        //是否具有定位权限
        int status=[CLLocationManager authorizationStatus];
        if(!enable || status<3)
        {
            Autho = NO;
        }else{
            Autho = YES;
        }
    }else if(Authorization == AuthorizationAudio){
        //音频服务是否可用
        if ([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)]) {
            [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                if (granted) {
                    Autho = YES;
                }else{
                    Autho = NO;
                }
            }];
        }
    }
    return Autho;
}

//截图
+ (UIImage *)getSnapshotImage{
    UIGraphicsBeginImageContextWithOptions(kScreenSize, NO, 1);
    [kWindow drawViewHierarchyInRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight) afterScreenUpdates:NO];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}

+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSLog(@"%i",[emailTest evaluateWithObject:email]);
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isValidateMobile:(NSString *)mobile
{
        if([mobile isEqualToString:@""])
        {
            return NO;
        }
        NSString * phoneStr;
        if ([mobile rangeOfString:@"+"].location !=NSNotFound)
        {
            NSString *temp = [[NSMutableString stringWithString:mobile] stringByReplacingOccurrencesOfString:@"-" withString:@""];
            NSMutableString * mTemp = [NSMutableString stringWithFormat:@"%@",temp];
            if ([mTemp hasPrefix:@"+86"])
            {
                [mTemp deleteCharactersInRange:NSMakeRange(3, 1)];
            }
            NSString *temp2 = [[NSMutableString stringWithString:mTemp] stringByReplacingOccurrencesOfString:@" " withString:@""];
            phoneStr = [[NSMutableString stringWithString:temp2] stringByReplacingOccurrencesOfString:@"+" withString:@""];
        }
        else
        {
            NSString *temp = [[NSMutableString stringWithString:mobile] stringByReplacingOccurrencesOfString:@"-" withString:@""];
            phoneStr = [[NSMutableString stringWithString:temp] stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        //    NSString * phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[012356789]|18[0-9]|14[012356789])[0-9]{8}$";
        //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        //    return [phoneTest evaluateWithObject:phoneStr];
        /**
         * 手机号码
         * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
         * 联通：130,131,132,152,155,156,185,186
         * 电信：133,1349,153,180,189,181(增加)
         */
        NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9]|9[0])\\d{8}$";
        /**
         10         * 中国移动：China Mobile
         11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
         12         */
        NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
        /**
         15         * 中国联通：China Unicom
         16         * 130,131,132,152,155,156,185,186
         17         */
        NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
        /**
         20         * 中国电信：China Telecom
         21         * 133,1349,153,17开头,180,189,181(增加),190(增加)
         22         */
        NSString * CT = @"^1((33|53|7[0-9]|8[019]|9[0])[0-9]|349)\\d{7}$";
        
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        
        if (([regextestmobile evaluateWithObject:phoneStr]
             || [regextestcm evaluateWithObject:phoneStr]
             || [regextestct evaluateWithObject:phoneStr]
             || [regextestcu evaluateWithObject:phoneStr])) {
            return YES;
        }
        return NO;
}

//判断类中是否包含一个属性
+ (BOOL) getVariableWithClass:(Class) myClass varName:(NSString *)name{
    unsigned int outCount, i;
    Ivar *ivars = class_copyIvarList(myClass, &outCount);
    for (i = 0; i < outCount; i++) {
        Ivar property = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        if ([keyName isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

//数字验证
+ (BOOL) validateNumber:(NSString *)mobile length:(NSInteger)num{
    num = num > 0 ? num : 12;
    NSString *phoneRegex = [NSString stringWithFormat:@"^[0-9]{0,%ld}$",(long)num];
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"%i",[phoneTest evaluateWithObject:mobile]);
    return [phoneTest evaluateWithObject:mobile];
}

//qq号
+ (BOOL)validateQQ:(NSString *)qq{
    NSString *QQRegex = @"^[1-9][0-9]{4,12}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",QQRegex];
    //    NSLog(@"%i",[phoneTest evaluateWithObject:mobile]);
    return [phoneTest evaluateWithObject:qq];
}

+ (NSString *)checkNumberString:(NSString *)string{
    if ([string isEqualToString:@"00"]) {
        string = @"0.";
    }else if ([string isEqualToString:@"."]){
        string = @"0.";
    }else if (string.length > 1 && [[string substringFromIndex:string.length - 1] isEqualToString:@"."]){
        NSArray *arr = [string componentsSeparatedByString:@"."];
        if (arr.count > 2) {
            string = [string substringToIndex:[string length] - 1];
        }
    }else if (string.length == 2 && [[string substringToIndex:1] isEqualToString:@"0"] && (![[string substringFromIndex:1] isEqualToString:@"."])){
        string = [string substringFromIndex:1];
    }else if ([string isEqualToString:@"0.00"]){
        string = @"";
    }
    
    NSScanner *scan = [NSScanner scannerWithString:string];
    float val;
    
    if ([scan scanFloat:&val] && [scan isAtEnd]){
        if ([string containsString:@"."]) {
            NSRange ran = [string rangeOfString:@"."];
            if ([string substringFromIndex:ran.location +1].length > 2) {
                string = [string substringToIndex:ran.location +3];
            }
            if ([string substringToIndex:ran.location].length > 8) {
                string = [string substringToIndex:8];
            }
        }else if (string.length > 8){
            string = [string substringToIndex:8];
        }
    }else{
        string = @"";
    }
    return string;
}

//昵称  //|[。、，； ：“”《》！（）¥？]
+ (BOOL) validateNickname:(NSString *)nickname length:(NSInteger)num{
    NSString *nicknameRegex = [NSString stringWithFormat:@"^([\u4e00-\u9fa5]|[a-zA-Z0-9]){0,%ld}$",(long)num];//@"^[\u4e00-\u9fa5]{0,64}$"
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    //    NSLog(@"%i",[passWordPredicate evaluateWithObject:nickname]);
    return [passWordPredicate evaluateWithObject:nickname];
}

//中文英文数字 ()
+ (BOOL)validateString:(NSString *)string length:(NSInteger)num{
    num = num > 0 ? num : 15;
    NSString *stringRegex = [NSString stringWithFormat:@"^([,.¥——‘，。、，； ：“”《》！（）¥？]|[\u4e00-\u9fa5]|[a-zA-Z0-9]){0,%ld}$",(long)num];
    NSPredicate *passPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringRegex];
    return [passPredicate evaluateWithObject:string];
}

//真实姓名
+ (BOOL)validateNameString:(NSString *)string length:(NSInteger)num{
    num = num > 0 ? num : 6;
    NSString *stringRegex = [NSString stringWithFormat:@"^([\u4e00-\u9fa5]|[a-zA-Z]){0,%ld}$",(long)num];
    NSPredicate *passPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringRegex];
    return [passPredicate evaluateWithObject:string];
}

//微信号  （微信账号仅支持6-20个字母、数字、下划线或减号，以字母开头）
+ (BOOL)validateWeixinString:(NSString *)string length:(NSInteger)num{
    num = num > 0 ? num : 20;
    NSString *stringRegex = [NSString stringWithFormat:@"^([_-]|[a-zA-Z0-9]){0,%ld}$",(long)num];
    NSPredicate *passPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringRegex];
    return [passPredicate evaluateWithObject:string];
}
//真实姓名 check  默认 十六个英文字母 或 十六个中文汉字 返回yes
+ (BOOL)checkNameString:(NSString *)string length:(NSInteger)num{
    num = num > 0 ? num : 16;
    NSString *stringRe = [NSString stringWithFormat:@"^[\u4e00-\u9fa5]{0,%ld}$",(long)num];
    NSPredicate *passPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringRe];
    
    NSString *stringReC = [NSString stringWithFormat:@"[a-zA-Z]{0,16}$"];
    NSPredicate *passPreC = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringReC];
    return [passPre evaluateWithObject:string] || [passPreC evaluateWithObject:string];
}
//中英文
+ (BOOL)checkNameChineseAndEnglish:(NSString *)string length:(NSInteger)num{
    num = num > 0 ? num : 16;
    NSString *stringRegex = [NSString stringWithFormat:@"^([\u4e00-\u9fa5]|[a-zA-Z]){0,%ld}$",(long)num];
    NSPredicate *passPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringRegex];
    return [passPredicate evaluateWithObject:string];
}

+ (UIViewController *)currentWindowTopViewController{
    return [self topViewControllerWithRootViewController:[self windowRootViewController]];   //根据根控制器获取当前的控制器
}

//获取当前window的跟控制器
+ (UIViewController *)windowRootViewController{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];   //最顶层的view
    id nextResponder = [frontView nextResponder];        //向上寻找响应者
    
    if ([nextResponder isKindOfClass:[UIViewController class]])   //如果响应者是控制器
        result = nextResponder;
    else
        result = window.rootViewController;                 //这应该是tabbarcontroller吧
    
    return result;
}

//获得当前根控制器的顶部控制器
+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

+ (NSString*)sha256WithStr:(NSString*)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes,(CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

#pragma mark - 获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         //筛选出IP地址格式
         if([self isValidatIP:address]) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result=[ipAddress substringWithRange:resultRange];
            //输出结果
            NSLog(@"%@",result);
            return YES;
        }
    }
    return NO;
}

+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags && IFF_UP)) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if( addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}
+ (UIViewController *)getCurrentVC
{
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [CTUtility findBestViewController:viewController];
}
+(UIViewController*) findBestViewController:(UIViewController*)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [CTUtility findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [CTUtility findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [CTUtility findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [CTUtility findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        return vc;
    }
}


@end
