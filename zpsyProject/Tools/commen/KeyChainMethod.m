//
//  KeyChainMethod.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/10.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "KeyChainMethod.h"
#import <SAMKeychain/SAMKeychain.h>

@implementation KeyChainMethod


//设备唯一标识

+(NSString *)getUniqueDeviceIdentifierAsString
{
    NSString *keyName = [[NSBundle mainBundle] bundleIdentifier];
    NSString *strApplicationUUID =  [SAMKeychain passwordForService:keyName account:@"incoding"];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        NSError *error = nil;
        SAMKeychainQuery *query = [[SAMKeychainQuery alloc] init];
        query.service = keyName;
        query.account = @"incoding";
        query.password = strApplicationUUID;
        query.synchronizationMode = SAMKeychainQuerySynchronizationModeNo;
        [query save:&error];
        
    }
    
    return strApplicationUUID;
}
@end
