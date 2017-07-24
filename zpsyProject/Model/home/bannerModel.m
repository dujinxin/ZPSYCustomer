//
//  bannerModel.m
//  ZPSY
//
//  Created by zhouhao on 2017/3/23.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "bannerModel.h"

@implementation HomeEntity
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super init];
    if (self) {
        //        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        //        self.title = [aDecoder decodeObjectForKey:@"title"];
        //        self.type = [aDecoder decodeObjectForKey:@"type"];
        //        self.image = [aDecoder decodeObjectForKey:@"image"];
        //        self.detail = [aDecoder decodeObjectForKey:@"detail"];
        //        self.field1 = [aDecoder decodeObjectForKey:@"field1"];
        //        self.jumpUrl = [aDecoder decodeObjectForKey:@"jumpUrl"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    //    [aCoder encodeObject:self.ID forKey:@"ID"];
    //    [aCoder encodeObject:self.title forKey:@"title"];
    //    [aCoder encodeObject:self.type forKey:@"type"];
    //    [aCoder encodeObject:self.image forKey:@"image"];
    //    [aCoder encodeObject:self.detail forKey:@"detail"];
    //    [aCoder encodeObject:self.field1 forKey:@"field1"];
    //    [aCoder encodeObject:self.jumpUrl forKey:@"jumpUrl"];
}
@end

@implementation bannerEntity

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super init];
    if (self) {
//        self.ID = [aDecoder decodeObjectForKey:@"ID"];
//        self.title = [aDecoder decodeObjectForKey:@"title"];
//        self.type = [aDecoder decodeObjectForKey:@"type"];
//        self.image = [aDecoder decodeObjectForKey:@"image"];
//        self.detail = [aDecoder decodeObjectForKey:@"detail"];
//        self.field1 = [aDecoder decodeObjectForKey:@"field1"];
//        self.jumpUrl = [aDecoder decodeObjectForKey:@"jumpUrl"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
//    [aCoder encodeObject:self.ID forKey:@"ID"];
//    [aCoder encodeObject:self.title forKey:@"title"];
//    [aCoder encodeObject:self.type forKey:@"type"];
//    [aCoder encodeObject:self.image forKey:@"image"];
//    [aCoder encodeObject:self.detail forKey:@"detail"];
//    [aCoder encodeObject:self.field1 forKey:@"field1"];
//    [aCoder encodeObject:self.jumpUrl forKey:@"jumpUrl"];
}
@end
@implementation ExposureEntity
@end
