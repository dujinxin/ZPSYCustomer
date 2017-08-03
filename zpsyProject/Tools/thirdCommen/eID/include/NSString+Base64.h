//
//  NSString+Base64.h
//  eID-SDK
//
//  Created by Jusive on 16/5/23.
//  Copyright © 2016年 Jusive. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSString (Base64)
/**
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;
/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString;
- (NSString *) base64StringFromData:(NSData *)data;
@end

