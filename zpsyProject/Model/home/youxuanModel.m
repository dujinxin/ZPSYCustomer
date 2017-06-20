//
//  bannerModel.m
//  ZPSY
//
//  Created by zhouhao on 2017/3/22.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "youxuanModel.h"

@implementation youxuanModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id"
             };
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super init];
    if (self) {
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.shortTitle = [aDecoder decodeObjectForKey:@"shortTitle"];
        self.source = [aDecoder decodeObjectForKey:@"source"];
        self.sourceUrl = [aDecoder decodeObjectForKey:@"sourceUrl"];
        self.contents = [aDecoder decodeObjectForKey:@"contents"];
        self.thumbnail = [aDecoder decodeObjectForKey:@"thumbnail"];
        self.img = [aDecoder decodeObjectForKey:@"img"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.shortTitle forKey:@"shortTitle"];
    [aCoder encodeObject:self.source forKey:@"source"];
    [aCoder encodeObject:self.sourceUrl forKey:@"sourceUrl"];
    [aCoder encodeObject:self.contents forKey:@"contents"];
    [aCoder encodeObject:self.thumbnail forKey:@"thumbnail"];
    [aCoder encodeObject:self.img forKey:@"img"];
}

@end
