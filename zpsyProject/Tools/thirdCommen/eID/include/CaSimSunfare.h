//
//  CaSimSunfare.h
//  CaSimSunfare
//
//  Created by s on 13-12-23.
//  Copyright (c) 2013年 sunward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ble.h"


@class CaSimBle;

@interface CaSimSunfare : NSObject

@property (nonatomic, strong) CaSimBle *caSimBle;

+(CaSimSunfare*)shared;
//-(void)SunfareInit:(CaSimBle*)ble;

//3.1选择应用
-(int)SunfareSelectApp:(const Byte[])pAID
          Response:(eventApduResponseBlock)block;
//3.2认证
-(int)SunfareAuthentication:(Byte)sectionNo
                      KeyID:(const Byte[])pKeyID
                        Mac:(const Byte[])mac
                   Response:(eventApduResponseBlock)block;

//3.3读数据
-(int)SunfareRead:(Byte)sectionNo
             Offset:(Byte)offset
                Len:(Byte)len
           Response:(eventApduResponseBlock)block;
//3.4写数据
-(int)SunfareWrite:(Byte)sectionNo
            Offset:(Byte)offset
             KeyID:(const Byte[])pKeyID
              Data:(const Byte[])pData  //密文+校验码 native卡CRC  java卡MD5
               Len:(Byte)len     //密文+校验码的长度
          Response:(eventApduResponseBlock)block;

//3.5备份数据
-(int)SunfareBackup:(Byte)sectionNo
          KeyID:(const Byte[])pKeyID
    FormBlockNo:(Byte)fromBlockNo
      ToBlockNo:(Byte)toBlockNo
         Mac:(const Byte[])mac
       Response:(eventApduResponseBlock)block;

//3.6修改访问控制信息
-(int)SunfareChangeRule:(Byte)sectionNo
                  KeyID:(const Byte[])pKeyID
            CardNoControlInfoEn:(const Byte[])pCardNoControlInfoEn
                     Mac:(const Byte[])mac
               Response:(eventApduResponseBlock)block;
//3.7取随机数
-(int)SunfareGetRandom:(Byte)len
          Response:(eventApduResponseBlock)block;

@end
