//
//  NSString+NSDictionary.h
//  eID-SDK
//
//  Created by Jusive on 16/5/26.
//  Copyright © 2016年 Jusive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSDictionary)
-(NSString *)queryStringUsingDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
