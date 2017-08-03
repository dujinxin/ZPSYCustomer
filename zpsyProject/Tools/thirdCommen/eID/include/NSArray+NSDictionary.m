
//
//  NSArray+NSDictionary.m
//  eID-SDKHP
//
//  Created by Jusive on 16/5/31.
//  Copyright © 2016年 Jusive. All rights reserved.
//

#import "NSArray+NSDictionary.h"

@implementation NSArray (NSDictionary)
-(NSArray *)enumerateObjectsUsingDictionary:(NSDictionary *)dictionary{
    NSArray *keys = [dictionary allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    return sortedArray;
}
@end
