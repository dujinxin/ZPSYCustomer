//
//  CaSimPhones.h
//  CaSimPhones
//
//  Created by s on 14-4-14.
//  Copyright (c) 2014年 sunward. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ble.h"
#import "ca.h"

@class CaSimBle;

@interface CaSimPhones : NSObject

@property (nonatomic, strong) CaSimBle *caSimBle;
@property (nonatomic, assign) Byte ksclass;
@property (nonatomic, assign) Byte ksIns;

+(CaSimPhones*)shared;

//-(void)PhonesInit:(CaSimBle*)ble;
//-(void)PhonesInitTransParams;//弃用此接口


#pragma mark - 一卡多号

//java卡选择一卡多号应用
-(int)PhonesSelectAppWithResponse:(eventApduResponseBlock)block;

//2.1 选择卡商私有class,ins  读取成功内部将设置self.ksclass,self.ksIns的值
-(int)PhonesReadPrivateParamsWithResponse:(eventApduResponseBlock)block;

//2.2 取卡号
-(int)PhonesReadCardIDWithResponse:(eventApduResponseBlock)block;

//2.3 取随计数
-(int)PhonesGetRandomWithResponse:(eventApduResponseBlock)block;

//2.4添加号码数据
-(int)PhonesAdd:(Byte)index
      PhonesEncryptType:(Byte)encryptType
     PhonesData:(const Byte[])phonesData
  PhonesDataMD5:(const Byte[])phonesDataMD5
           UUID:(const Byte[])uuid
       Response:(eventApduResponseBlock)block;

////2.5删除号码数据
//-(int)PhonesDel:(Byte)index
// PhonesCardData:(NSString*)phonesCardData
//       Response:(eventApduResponseBlock)block;

//2.5删除号码数据
-(int)PhonesDel:(Byte)index
      CardNoMD5:(const Byte[])cardNoMD5
       Response:(eventApduResponseBlock)block;

////2.6切换号码数据
//-(int)PhonesAction:(Byte)index
//    PhonesCardData:(NSString*)phonesCardData
//          Response:(eventApduResponseBlock)block;

//2.6切换号码数据
-(int)PhonesAction:(Byte)index
         CardNoMD5:(const Byte[])cardNoMD5
          Response:(eventApduResponseBlock)block;

//2.7读取号码数据
-(int)PhonesRead:(Byte)index
        Response:(eventApduResponseBlock)block;

@end








