//
//  NSString+NSDictionary.m
//  eID-SDK
//
//  Created by Jusive on 16/5/26.
//  Copyright © 2016年 Jusive. All rights reserved.
//

#import "NSString+NSDictionary.h"

@implementation NSString (NSDictionary)

-(NSString *)queryStringUsingDictionary:(NSDictionary *)dictionary {
    return [[[NSString alloc] queryStringComponentsUsingDictionary:dictionary] componentsJoinedByString:@"&"];
}

#pragma mark - Private

- (NSArray *)queryStringComponentsUsingDictionary:(NSDictionary *)dictionary {
    NSMutableArray *pairs = [[NSMutableArray alloc] initWithCapacity:dictionary.count];
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
        if ([value isKindOfClass:NSArray.class]) {
            [value enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self addQueryStringComponentUsingKey:key value:obj toPairs:pairs];
            }];
        } else {
            [self addQueryStringComponentUsingKey:key value:value toPairs:pairs];
        }
    }];
    
    return pairs;
}

- (void)addQueryStringComponentUsingKey:(NSString *)key value:(NSString *)value toPairs:(NSMutableArray *)components {
    [components addObject:[NSString stringWithFormat:@"%@=%@", [self escapeString:key], [self escapeString:value]]];
}
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
-(NSString *)escapeString:(NSString *)string {
   #pragma clang diagnostic push
   #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)string, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
    #pragma clang diagnostic pop
}

@end
