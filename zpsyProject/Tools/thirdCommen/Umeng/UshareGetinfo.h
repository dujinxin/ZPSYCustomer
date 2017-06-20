//
//  UshareGetinfo.h
//  ZPSY
//
//  Created by zhouhao on 2017/2/13.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UShareUI/UShareUI.h>
@interface UshareGetinfo : NSObject
+(void)shareGetInfoWithController:(UIViewController*)VC PlatformType:(UMSocialPlatformType)paltformType resultBlock:(void(^)(UMSocialUserInfoResponse *resp))resultBlock;
@end
