//
//  homeModel.m
//  ZPSY
//
//  Created by zhouhao on 2017/3/7.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "homeModel.h"

@implementation homeModel

-(instancetype)init{

    if (self=[super init]) {
        
        self.banerListArr = [NSMutableArray array];
        self.adverListArr = [NSMutableArray array];
        self.preferenceListArr = [NSMutableArray array];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    self=[super init];
    if (self) {
        self.banerListArr = [aDecoder decodeObjectForKey:@"banerListArr"];
        self.adverListArr = [aDecoder decodeObjectForKey:@"adverListArr"];
        self.preferenceListArr = [aDecoder decodeObjectForKey:@"preferenceListArr"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.banerListArr forKey:@"banerListArr"];
    [aCoder encodeObject:self.adverListArr forKey:@"adverListArr"];
    [aCoder encodeObject:self.preferenceListArr forKey:@"preferenceListArr"];
}


@end
