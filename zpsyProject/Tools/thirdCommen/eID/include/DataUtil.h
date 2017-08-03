//
//  DataUtil.h
//  IdspSDKSample
//
//  Created by zly on 15/7/9.
//  Copyright (c) 2015年 trimps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataUtil : NSObject

-(NSData*)stringToByte:(NSString*)string;
+ (NSString *)ByteToString:(NSData *)HexNSdata;
+ (NSMutableAttributedString *)getAttrStrWithString:(NSString *)str;
+ (NSMutableAttributedString *)getAttrStrWithString:(NSString *)str succeed:(BOOL)succeed;

@end
