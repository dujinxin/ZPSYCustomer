//
//  decrypt.h
//  eID-SDK
//
//  Created by Jusive on 16/6/15.
//  Copyright © 2016年 Jusive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface decrypt : NSObject
-(void)decrypt:( NSDictionary *)dict  decrypt:(void(^)(void))decryptBlock;
@end
