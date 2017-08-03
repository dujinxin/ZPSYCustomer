//
//  NSArray+NSDictionary.h
//  eID-SDKHP
//
//  Created by Jusive on 16/5/31.
//  Copyright © 2016年 Jusive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (NSDictionary)
-(NSArray *)enumerateObjectsUsingDictionary:(NSDictionary *)dictionary;
@end
