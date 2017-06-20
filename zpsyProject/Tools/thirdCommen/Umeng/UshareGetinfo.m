//
//  UshareGetinfo.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/13.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "UshareGetinfo.h"

@implementation UshareGetinfo
+(void)shareGetInfoWithController:(UIViewController*)VC PlatformType:(UMSocialPlatformType)paltformType resultBlock:(void(^)(UMSocialUserInfoResponse *resp))resultBlock{
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:paltformType currentViewController:VC completion:^(id result, NSError *error) {
        
        if (error) {
            UMSocialLogInfo(@"Get info fail with error %@",error);
        }else{
            if ([result isKindOfClass:[UMSocialUserInfoResponse class]]) {
                
                UMSocialUserInfoResponse *resp = result;
                BLOCK_SAFE(resultBlock)(resp);
            }
        }
        
    }];
    
    
}
@end
