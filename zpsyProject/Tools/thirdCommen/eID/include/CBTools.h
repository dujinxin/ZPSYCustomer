//
//  CBTools.h
//  CASIM
//
//  Created by Sunwardtel-Wangym on 13-5-7.
//  Copyright (c) 2013年 Sunwardtel. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ble.h"
#import "ca.h"
#import "Catbee_Type.h"
#import "CaSimBle.h"
#import "KKLog.h"

@interface CBTools : NSObject

+(int)hexStringToBytes:(NSString *)str forBytes:(Byte *)bytes;
+(NSString *)dataToHexString:(NSString *)head forData:(NSData *)nsData forBlankEnable:(BOOL)blank;
//+(void)packData:(Byte *)data forFrameData:(BLE_Frame *)frame;
//+(void)unPackData:(Byte *)data forFrameData:(BLE_Frame *)frame;
//+(void)packApduData:(NSMutableData*)data forApdu:(BLE_APDU)apdu;
+(NSMutableArray*)splitMutableApdu:(BLE_MutableAPDU*)mutableApdu; //多包拆分成单包列表

+(BLE_APDU2)changeToSingleApdu:(BLE_MutableAPDU*)mutableApdu forMutable:(BOOL)isMutable forTotal:(NSInteger)nTotal forIndex:(NSInteger)nIndex;

+(unsigned short)crc16withBytes:(unsigned char*)buf forLen:(unsigned short)length;
//+(Byte)sumWithBytes:(unsigned char*)buf forLen:(unsigned short)length;
//+(Byte)xorWithBytes:(unsigned char*)buf forLen:(unsigned short)length;

+(U16)getU16:(const Byte*)p;
+(U32)getU32:(const Byte*)p;
+(void)Reverse:(Byte*)p length:(int)len;
+(void)ReverseFrom:(const Byte*)pf To:(Byte*)pt length:(int)len;

+(NSString *) GB2312ToNSString:(NSData *) data;


//+(void)saveICCID:(NSString *)iccid;
//+(id)readICCID;
//+(void)deleteICCID;
//
//+(void)saveUUID:(NSString *)uuid;
//+(id)readUUID;
//+(void)deleteUUID;
//
//+(void)saveCARDID:(NSString *)cardid;
//+(id)readCARDID;
//+(void)deleteCARDID;
//
//+(void)savePAIRUUID:(NSString *)pairuuid;
//+(id)readPAIRUUID;
//+(void)deletePAIRUUID;

#define kPeripheralName  @"kPeripheralName"
#define kPeripheralMatchCode  @"kPeripheralMatchCode"
#define kPeripheralIdentifier  @"kPeripheralIdentifier"
//#define kPeripheralName  @"kPeripheralName"

+(void)setObject:(NSString *)something forKey:(NSString *)key;

+(NSString *)objectForKey:(NSString *)key;

+(void)removeObjectForKey:(NSString *)key;

@end


@interface CBFrame : NSObject

-(BLE_Frame*)getFrame;
-(void)setFrame:(BLE_Frame*)frame;

@end


@interface CBApdu : NSObject

-(BLE_APDU2)getApdu2;
-(void)setApdu2:(BLE_APDU2)apdu2;

@end


void KKNSLog(NSString *format, ...);
void KKNSLog2(KKLogLevel level, NSString *format, ...);


