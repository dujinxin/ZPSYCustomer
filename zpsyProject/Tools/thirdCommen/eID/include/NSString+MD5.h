//
//  NSString+MD5.h
//  eID-SDK
//
//  Created by Jusive on 16/5/20.
//  Copyright © 2016年 Jusive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)
-(NSString *)md5HexDigest:(NSString*)input;
@end
