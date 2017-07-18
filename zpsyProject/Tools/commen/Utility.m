//
//  Utility.m
//  NoWait
//
//

#import "Utility.h"
#include <netdb.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/sockio.h>
#include <stdio.h>
#include <net/ethernet.h>
#include <errno.h>
#import <CommonCrypto/CommonDigest.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CFNetwork/CFNetwork.h>
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

// iOS8判断
#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

// iOS7判断
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

////低于ios6及其以下的判断
#define iOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)

#define iOS777 ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0 && [[[UIDevice currentDevice] systemVersion] floatValue] > 6.0)


@implementation Utility
// 获取设备MAC地址，AABBCCDDEEFF
+ (NSString *)getUUIDAddress{
     NSString *outstring = [Utility deviceUUIDString];
    // 去掉中间的横线
    outstring = [outstring stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return outstring;
}

+ (NSString * )macString{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

+ (NSString *)idfaString {
    
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];
    
    if (adSupportBundle == nil) {
        return @"";
    }
    else{
        
        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
        
        if(asIdentifierMClass == nil){
            return @"";
        }
        else{
            
            //for no arc
            //ASIdentifierManager *asIM = [[[asIdentifierMClass alloc] init] autorelease];
            //for arc
            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
            
            if (asIM == nil) {
                return @"";
            }
            else{
                
                if(asIM.advertisingTrackingEnabled){
                    return [asIM.advertisingIdentifier UUIDString];
                }
                else{
                    return [asIM.advertisingIdentifier UUIDString];
                }
            }
        }
    }
}

+ (NSString *)idfvString
{
    if([[UIDevice currentDevice] respondsToSelector:@selector( identifierForVendor)]) {
        return [Utility deviceUUIDString];
    }
    
    return @"";
}


// 获取设备IP地址
#define BUFFERSIZE  4000
#define min(a,b)    ((a) < (b) ? (a) : (b))
#define max(a,b)    ((a) > (b) ? (a) : (b))

+ (NSString *)getWLanIPAddresses
{
    int                 len, flags;
    char                buffer[BUFFERSIZE], *ptr, *cptr;
    struct ifconf       ifc;
    struct ifreq        *ifr, ifrcopy;
    struct sockaddr_in  *sin;
    
    char temp[80];
    
    int sockfd;
    
    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0)
    {
        perror("socket failed");
        return nil;
    }
    
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) < 0)
    {
        perror("ioctl error");
        return nil;
    }
    
    for (ptr = buffer; ptr < buffer + ifc.ifc_len; )
    {
        ifr = (struct ifreq *)ptr;
        len = max(sizeof(struct sockaddr), ifr->ifr_addr.sa_len);
        ptr += sizeof(ifr->ifr_name) + len;  // for next one in buffer
        
        if (ifr->ifr_addr.sa_family != AF_INET)
        {
            continue;   // ignore if not desired address family
        }
        
        if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL)
        {
            *cptr = 0;      // replace colon will null
        }
        
        //  以太网
        if (strncmp("en0", ifr->ifr_name, IFNAMSIZ) == 0)
        {
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            flags = ifrcopy.ifr_flags;
            if ((flags & IFF_UP) == 0)
            {
                continue;   // ignore if interface not up
            }
            
            sin = (struct sockaddr_in *)&ifr->ifr_addr;
            strcpy(temp, inet_ntoa(sin->sin_addr));
            break;
        }
    }
    
    close(sockfd);
    return [[NSString alloc] initWithCString:temp encoding:NSASCIIStringEncoding];
}

+(NSString *)getHWAddresses
{
    struct ifconf ifc;
    struct ifreq *ifr;
    int  sockfd;
    char buffer[BUFFERSIZE], *cp, *cplim;
    char temp[80];
    
    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0)
    {
        perror("socket failed");
        return nil;
    }
    
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, (char *)&ifc) < 0)
    {
        perror("ioctl error");
        close(sockfd);
        return nil;
    }
    
    ifr = ifc.ifc_req;
    
    cplim = buffer + ifc.ifc_len;
    
    for (cp=buffer; cp < cplim; )
    {
        ifr = (struct ifreq *)cp;
        if (ifr->ifr_addr.sa_family == AF_LINK)
        {
            struct sockaddr_dl *sdl = (struct sockaddr_dl *)&ifr->ifr_addr;
            int a,b,c,d,e,f;
            
            //  以太网
            if (strncmp("en0", ifr->ifr_name, IFNAMSIZ) == 0)
            {
                strcpy(temp, (char *)ether_ntoa((struct ether_addr *)LLADDR(sdl)));
                sscanf(temp, "%x:%x:%x:%x:%x:%x", &a, &b, &c, &d, &e, &f);
                NSString *mac = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",a,b,c,d,e,f];
                return mac;
            }
            
        }
        cp += sizeof(ifr->ifr_name) + max(sizeof(ifr->ifr_addr), ifr->ifr_addr.sa_len);
    }
    
    close(sockfd);
    return nil;
}

+ (void)openAppAuthorityManagerment{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

#pragma mark - 网络状态变化通知
+ (id)fetchSSIDInfo
{
    NSArray *ifs = (__bridge NSArray *)(CNCopySupportedInterfaces());
    
    id info = nil;
    
    // 枚举接口
    for (NSString *ifnam in ifs)
    {
        info = (__bridge id)(CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam));
        
        if (info && [info count])
        {
            break;
        }
    }
    return info;
}

// MD5加密算法
+ (NSString *)encodeMD5:(NSString*)entity
{
    if(entity == nil || [entity length] == 0)
    {
        return nil;
    }
    
    const char *value = [entity UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (uint32_t)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString;
}


// BASE64加密算法
+ (NSString*)encodeBASE64:(NSData *)data
{
    static char base64EncodingTable[64] = {
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
        'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
        'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
        'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
    };
    NSInteger length = [data length];
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    lentext = [data length];
    if (lentext < 1)
        return @"";
    result = [NSMutableString stringWithCapacity: lentext];
    raw = [data bytes];
    ixtext = 0;
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0)
            break;
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext)
                input[i] = raw[ix];
            else
                input[i] = 0;
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++)
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        
        for (i = ctcopy; i < 4; i++)
            [result appendString: @"="];
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length))
            charsonline = 0;
    }
    return result;
}

// DecodeBASE64解密算法
+ (NSData*)decodeBASE64:(NSString *)string
{
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[4];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
    
    if (string == nil) {
        return [NSData data];
    }
    
    ixtext = 0;
    
    tempcstring = (const unsigned char *)[string UTF8String];
    
    lentext = [string length];
    
    theData = [NSMutableData dataWithCapacity: lentext];
    
    ixinbuf = 0;
    
    while (true) {
        if (ixtext >= lentext){
            break;
        }
        
        ch = tempcstring [ixtext++];
        
        flignore = false;
        
        if ((ch >= 'A') && (ch <= 'Z')) {
            ch = ch - 'A';
        } else if ((ch >= 'a') && (ch <= 'z')) {
            ch = ch - 'a' + 26;
        } else if ((ch >= '0') && (ch <= '9')) {
            ch = ch - '0' + 52;
        } else if (ch == '+') {
            ch = 62;
        } else if (ch == '=') {
            flendtext = true;
        } else if (ch == '/') {
            ch = 63;
        } else {
            flignore = true;
        }
        
        if (!flignore) {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
            
            if (flendtext) {
                if (ixinbuf == 0) {
                    break;
                }
                
                if ((ixinbuf == 1) || (ixinbuf == 2)) {
                    ctcharsinbuf = 1;
                } else {
                    ctcharsinbuf = 2;
                }
                
                ixinbuf = 3;
                
                flbreak = true;
            }
            
            inbuf [ixinbuf++] = ch;
            
            if (ixinbuf == 4) {
                ixinbuf = 0;
                
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++) {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }
            
            if (flbreak) {
                break;
            }
        }
    }
    
    return theData;
}


// 根据16进制和alpha计算UIColor
+ (UIColor *)HEX2Color:(NSInteger)hexCode inAlpha:(CGFloat)alpha
{
    float red   = ((hexCode >> 16) & 0x000000FF)/255.0f;
    float green = ((hexCode >> 8) & 0x000000FF)/255.0f;
    float blue  = ((hexCode) & 0x000000FF)/255.0f;
    return [UIColor colorWithRed:red
                           green:green
                            blue:blue
                           alpha:alpha];
}


// 字符串转换为日期格式
+ (NSDate *)dateFromString:(NSString *)dateString{
    return [self dateFromString:dateString format:@"yyyy-MM-dd HH:mm:ss zzz"];
}

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: format];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

// 日期格式转换为字符串显示
+ (NSString *)stringFromDate:(NSDate *)date{
    return [self stringFromDate:date format:@"yyyy-MM-dd HH:mm:ss zzz"];
}

+ (NSString *)mdStringFromDate:(NSDate *)date{
    return [self stringFromDate:date format:@"MM月dd日"];
}

+ (NSString *)hmStringFromDate:(NSDate *)date{
    return [self stringFromDate:date format:@"HH:mm"];
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString*)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:format];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *)weekdayStringFromDate:(NSDate*)inputDate{
    if (!inputDate) return nil;
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDateComponents * comps = [self dateComponentsWithDate:inputDate];
    NSInteger weekday = [comps weekday];
    if (weekday < 1 || weekday > 7) return nil;
    return [arrWeek objectAtIndex:weekday - 1];
}

+ (NSString*)monthStringFromDate:(NSDate*)date{
    if (!date) return nil;
    NSArray * monthArray = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
    NSDateComponents * comps = [self dateComponentsWithDate:date];
    NSInteger month = [comps month];
    if (month < 1 || month > 12) return nil;
    return [monthArray objectAtIndex:month - 1];
}

+ (NSDateComponents*)dateComponentsWithDate:(NSDate *)inputDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags;
    unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

    comps = [calendar components:unitFlags fromDate:inputDate];
    return comps;
}

// NSDate -->> Weekday
+ (MWWeekday)weekdayWithDate:(NSDate*)date{
    NSDateComponents *comps = [Utility dateComponentsWithDate:date];
    MWWeekday weekday = comps.weekday - 1;
    return weekday;
}

// 删除沙盒中的文件
+ (BOOL)deleteSingleFile:(NSString *)filePath
{
    NSError *err = nil;
    
    if (nil == filePath) {
        return NO;
    }
    
    NSFileManager *appFileManager = [NSFileManager defaultManager];
    
    if (![appFileManager fileExistsAtPath:filePath]) {
        return YES;
    }
    
    if (![appFileManager isDeletableFileAtPath:filePath]) {
        return NO;
    }
    
    return [appFileManager removeItemAtPath:filePath error:&err];
}

+ (BOOL)deleteFileWithName:(NSString *)fileName {
    return [self deleteSingleFile:[Utility getFilePathWithFileName:fileName]];
}


+ (BOOL)addFileWithName:(NSString *)fileName withArray:(NSArray *)arr{
    if (fileName == nil || arr == nil || arr.count == 0) {
        
        return NO;
    }
    return [arr writeToFile:[Utility getFilePathWithFileName:fileName] atomically:YES];
}

+ (NSArray *)getArrayWithFileName:(NSString *)fileName{
    return [[NSArray alloc] initWithContentsOfFile:[Utility getFilePathWithFileName:fileName]];
}

+ (BOOL)addFileWithName:(NSString *)fileName withDict:(NSDictionary *)dict{
    if (fileName == nil || dict == nil) {
        return NO;
    }
    //写进文件列表
    return [dict writeToFile:[Utility getFilePathWithFileName:fileName] atomically:YES];
}

+(NSDictionary *)getDictWithFileName:(NSString *)fileName{
    return [[NSDictionary alloc] initWithContentsOfFile:[Utility getFilePathWithFileName:fileName]];
}

+ (NSString*)getFilePathWithFileName:(NSString*)fileName{
    // 取得主路径
    NSString * rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    // 取得数据plist路径
    return [rootPath stringByAppendingPathComponent:fileName];
}

+ (BOOL)checkJson:(id)json withValidator:(id)validatorJson {
    if ([json isKindOfClass:[NSDictionary class]] &&
        [validatorJson isKindOfClass:[NSDictionary class]]) {
        NSDictionary * dict = json;
        NSDictionary * validator = validatorJson;
        BOOL result = YES;
        NSEnumerator * enumerator = [validator keyEnumerator];
        NSString * key;
        while ((key = [enumerator nextObject]) != nil) {
            id value = dict[key];
            id format = validator[key];
            if ([value isKindOfClass:[NSDictionary class]]
                || [value isKindOfClass:[NSArray class]]) {
                return [self checkJson:value withValidator:format];
            } else {
                if ([value isKindOfClass:format] == NO &&
                    [value isKindOfClass:[NSNull class]] == NO) {
                    result = NO;
                    break;
                }
            }
        }
        return result;
    } else if ([json isKindOfClass:[NSArray class]] &&
               [validatorJson isKindOfClass:[NSArray class]]) {
        NSArray * validatorArray = (NSArray *)validatorJson;
        if (validatorArray.count > 0) {
            NSArray * array = json;
            NSDictionary * validator = validatorJson[0];
            for (id item in array) {
                BOOL result = [self checkJson:item withValidator:validator];
                if (!result) {
                    return NO;
                }
            }
        }
        return YES;
    } else if ([json isKindOfClass:validatorJson]) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters {
    NSMutableString *urlParametersString = [[NSMutableString alloc] initWithString:@""];
    if (parameters && parameters.count > 0) {
        for (NSString *key in parameters) {
            NSString *value = parameters[key];
            value = [NSString stringWithFormat:@"%@",value];
            value = [self urlEncode:value];
            [urlParametersString appendFormat:@"&%@=%@", key, value];
        }
    }
    return urlParametersString;
}

+ (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters {
    NSString *filteredUrl = originUrlString;
    NSString *paraUrlString = [self urlParametersStringFromParameters:parameters];
    if (paraUrlString && paraUrlString.length > 0) {
        if ([originUrlString rangeOfString:@"?"].location != NSNotFound) {
            filteredUrl = [filteredUrl stringByAppendingString:paraUrlString];
        } else {
            filteredUrl = [filteredUrl stringByAppendingFormat:@"?%@", [paraUrlString substringFromIndex:1]];
        }
        return filteredUrl;
    } else {
        return originUrlString;
    }
}


+ (NSString*)urlEncode:(NSString*)str {
    //different library use slightly different escaped and unescaped set.
    //below is copied from AFNetworking but still escaped [] as AF leave them for Rails array parameter which we don't use.
    //https://github.com/AFNetworking/AFNetworking/pull/555
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)str, CFSTR("."), CFSTR(":/?#[]@!$&'()*+,;="), kCFStringEncodingUTF8);
    return result;
}

+ (NSString *)URLDecodedString:(NSString*)str{
    return [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
+ (NSString *)md5StringFromString:(NSString *)string {
    if(string == nil || [string length] == 0)
        return nil;
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

+ (void)addDoNotBackupAttribute:(NSString *)path {
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) {
        NSLog(@"error to set do not backup attribute, error = %@", error);
    }
}

+ (NSString *)appVersionString {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBundleIdentifier{
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)appBuild{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)systemVersionString{
    return [NSString stringWithFormat:@"%@%@",[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion];
}

+(NSString *)deviceModelString{
    return [UIDevice currentDevice].model;
}

+ (NSString *)deviceUUIDString{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+(UIColor *)colorWithHex:(NSInteger)hexCode{
    return [self HEX2Color:hexCode inAlpha:1.0f];
}

+(UIColor *)colorWithHex:(NSInteger)hexCode alpha:(CGFloat)alpha{
    return [self HEX2Color:hexCode inAlpha:alpha];
}

+(UIColor *)colorWithRandom{
    return [UIColor colorWithRed:(arc4random() % 255)/255.0
                           green:(arc4random() % 255)/255.0
                            blue:(arc4random() % 255)/255.0
                           alpha:(arc4random() % 255)/255.0];
}


+ (UIColor *)JXColorFromRGB:(NSInteger)rgbValue{
    return JXColorFromRGBA(rgbValue, 1.0);
}
+ (UIColor *)JXColorFromRGBA:(NSInteger)rgbValue alpha:(CGFloat)a{
    return JXColorFromRGBA(rgbValue, a);
}
+ (UIColor *)JXColorFromR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue{
    return JXColorFromR_G_B_A(red, green, blue, 1.0);
}
+ (UIColor *)JXColorFromR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha{
    return JXColorFromR_G_B_A(red, green, blue, alpha);
}
+ (UIColor *)jxDebugColor{
    return JXDebugColor;
}
#define JXColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define JXColorFromRGBA(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha: alphaValue]
//带有RGBA的颜色设置
#define JXColorFromR_G_B_A(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
//获取RGB颜色
#define JXColorFromR_G_B(r,g,b) JXColorFromR_G_B_A(r,g,b,1.0f)


+ (NSString*)getCurrentDeviceModel{
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPad Mini 3G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}
+ (BOOL)checkAVDeniedStatus{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusDenied){
        return YES;
    }
    return NO;
}

+ (BOOL)checkPhotoDeniedStatus{
   PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if(status == PHAuthorizationStatusDenied){
        return YES;
    }
    return NO;
}

+ (void)playSoundWithName:(NSString *)name type:(NSString *)type{
    
    NSString *sysPath = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",name,type];
    if (sysPath) {
        SystemSoundID sound;
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:sysPath],&sound);
        
        if (error == kAudioServicesNoError) {//获取的声音的时候，出现错误
            AudioServicesPlayAlertSound(sound);
            return;
        }
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        SystemSoundID sound;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &sound);
        AudioServicesPlayAlertSound(sound);
    }else {
        NSLog(@"Error: audio file not found at path: %@", path);
        path = [[NSBundle mainBundle] pathForResource:@"pushmsg" ofType:@"caf"];
        SystemSoundID sound;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &sound);
        AudioServicesPlayAlertSound(sound);
    }
}

+ (void)updateShopNameLabel:(UILabel *)label shopName:(NSString*)shopName{
    NSString * shopnameStr = [shopName stringByReplacingOccurrencesOfString:@" " withString:@""];
    shopnameStr = [shopnameStr stringByReplacingOccurrencesOfString:@"（" withString:@"("];
    shopnameStr = [shopnameStr stringByReplacingOccurrencesOfString:@"）" withString:@")"];
    NSRange ra1 = [shopnameStr rangeOfString:@"("];
    NSRange ra2 = [shopnameStr rangeOfString:@")"];
    if (ra1.location != NSNotFound) {
        NSRange range3 = NSMakeRange(ra1.location, ra2.location - ra1.location +1);
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:shopnameStr];
        
        [string addAttribute:NSFontAttributeName value:kFontSystemBold(15) range:NSMakeRange(0, shopnameStr.length)];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range3];
        
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor darkTextColor] range:NSMakeRange(0, shopnameStr.length)];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range3];
        label.attributedText = string;
    }else{
        label.text = shopnameStr;
    }
}

+ (NSString *)stringWithPrice:(CGFloat)price prefix:(NSString *)prefixStr{
    return [self stringWithPrice:price prefix:prefixStr isDefaultPrefix:NO];
}

+ (NSString *)stringWithPrice:(CGFloat)price prefix:(NSString *)prefixStr isDefaultPrefix:(BOOL)isDefault{
    if (price < 0) {
        return @"0";
    }
    NSInteger intNum = price * 100;
    NSInteger yushu = 0;
    yushu = intNum % 100;
    NSString *priceStr = @"";
    if (yushu > 0) {
        if ((yushu % 10) > 0) {
            priceStr = [NSString stringWithFormat:@"%.2f",price];
        }else{
            priceStr = [NSString stringWithFormat:@"%.1f",price];
        }
    }else{
        priceStr = [NSString stringWithFormat:@"%.0f",price];
    }
    
    if (!prefixStr || prefixStr.length == 0) {
        prefixStr = isDefault ? @"￥" : @"";
    }
    return [NSString stringWithFormat:@"%@%@",prefixStr,priceStr];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

static NSString *phoneKey = @"MWUserPhoneKey";
+ (void)setUserPhone:(NSString *)phone{
    [[NSUserDefaults standardUserDefaults] setValue:phone forKey:phoneKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)userPhone{
    return [[NSUserDefaults standardUserDefaults] objectForKey:phoneKey];
}

+ (CGFloat)distanceFromLocation2D:(CLLocationCoordinate2D *)fromLocation2D toLocation2D:(CLLocationCoordinate2D *)toLocation2D{
    CLLocation *orig=[[CLLocation alloc] initWithLatitude:fromLocation2D->latitude longitude:fromLocation2D->longitude];
    CLLocation *dist=[[CLLocation alloc] initWithLatitude:toLocation2D->latitude longitude:toLocation2D->longitude];
    
    return [orig distanceFromLocation:dist];
}

+ (CGFloat)distanceFromLocation:(CLLocation *)fromLocation toLocation:(CLLocation *)toLocation{
    return [fromLocation distanceFromLocation:toLocation];
}

#pragma paivate Methods
/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
+ (NSDate *)getCustomDateWithHour:(NSInteger)hour{
    return [[self class] getCustomDateWithHour:hour minute:0];
}

+ (NSDate *)getCustomDateWithHour:(NSInteger)hour minute:(NSInteger)minute{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSDateComponents *currentComps = [[self class] componentWithDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    [resultComps setMinute:minute];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [resultCalendar dateFromComponents:resultComps];
}

+ (NSDate *)getCustomDateWithStringHour:(NSString *)hour{
    //获取当前时间
    NSDate *theDate = [[self class] dateFromString:hour format:@"HH:mm"];
    NSDateComponents *currentComps = [[self class] componentWithDate:theDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:[currentComps hour]];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [resultCalendar dateFromComponents:resultComps];
}
+ (NSDateComponents *)componentWithDate:(NSDate *)date{
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags;
    unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

    
    currentComps = [currentCalendar components:unitFlags fromDate:date];
    return currentComps;
}


+ (BOOL)isBetweenFromHour:(NSInteger)fromHour fromMinute:(NSInteger)fromMinute toHour:(NSInteger)toHour toMinute:(NSInteger)toMinute{
    NSDate *dateFrom = [self getCustomDateWithHour:fromHour];
    NSDate *dateTo = [self getCustomDateWithHour:toHour];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:dateFrom]==NSOrderedDescending && [currentDate compare:dateTo]==NSOrderedAscending){
        NSLog(@"该时间在 %ld:00-%ld:00 之间！", (long)fromHour, (long)toHour);
        return YES;
    }
    return NO;
}

+ (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour{
    return [self isBetweenFromHour:fromHour fromMinute:0 toHour:toHour toMinute:0];
}

+ (BOOL)isBetweenFromStringHour:(NSString *)fromHour toStringHour:(NSString *)toHour{
    NSDate *dateFrom = [[self class] dateFromString:fromHour format:@"HH:mm"];
    NSDate *dateTo = [[self class] dateFromString:toHour format:@"HH:mm"];
    
    NSDateComponents *compsFrom = [[self class] componentWithDate:dateFrom];
    NSDateComponents *compsTo = [[self class] componentWithDate:dateTo];
    return [[self class] isBetweenFromHour:[compsFrom hour] fromMinute:[compsFrom minute]  toHour:[compsTo hour] toMinute:[compsTo minute]];
}

/*!
 @author Li.rongrui, 16-08-24 15:08:05
 
 @brief 字典键值转换，主要用于jsonModel
 
 @param dictionary NSDictionary
 
 @return NSDictionary
 */
+ (NSDictionary *)swapKeysAndValuesInDictionary:(NSDictionary *)dictionary{
    NSArray *keys = dictionary.allKeys;
    NSArray *values = [dictionary objectsForKeys:keys notFoundMarker:[NSNull null]];
    
    return [NSDictionary dictionaryWithObjects:keys forKeys:values];
}

@end
