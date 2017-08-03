//
//  CaSimBle.h
//  CaSimBle
//
//  Created by Sunwardtel-Wangym on 13-11-26.
//  Copyright (c) 2013年 Sunward. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ble.h"
#import "ca.h"


typedef enum
{
    bleLoaderType_Native,
    bleloaderType_Java,
    bleLoaderType_None
    
} BleLoaderType;


typedef struct
{
    Byte nBleChip;     //  芯片代码
    Byte nBleStage;    //  阶段代码(app不用）
    Byte nBleVerson;   //  版本代码
    Byte nBleFunc;     //  功能代码
    Byte nReserved[2]; //  预留字节
//    Byte nZero[2];     //  字节对齐
   
}BleLoader_Version;


@class CBBleCentral;
@class CBBlePeripheral;






@interface CaSimBle : NSObject

+(nonnull CaSimBle*)shared;

@property (nonatomic, readonly) BleLoaderType bleLoaderType;// 蓝牙卡的类别
@property (nonatomic, strong, nullable) CBPeripheral* blePeripheral;
@property (nonatomic, strong, nullable) CBBleCentral *bleCentral;

@property (nonatomic, strong, nullable) CBCharacteristic *sendCharacteristic;
@property (weak, nonatomic) id<SunwardBleDelegate> delegate;

#pragma mark - CaSimBle methods
-(void)SC_BLEInit;
-(void)SC_BLEStopScan;                                      // 开始扫描
-(void)SC_BLEStartScan;                                     // 停止扫描
-(int)SC_BLEConnect:(nonnull CBPeripheral*)peripheral;//options=@{CBConnectPeripheralOptionNotifyOnNotificationKey:[NSNumber numberWithBool:YES]}
-(int)SC_BLEConnect:(nonnull CBPeripheral*)peripheral options:(nullable NSDictionary<NSString *, id> *)options;              // ble连接
-(int)SC_BLEDisConnect:(nonnull CBPeripheral*)peripheral;           // 断开ble连接
-(int)SC_BLETransmitData:(NSData *)data forCmdDevice:(CmdDevice)device forRespnose:(eventApduResponseBlock)block;
-(int)SC_BLETransmitApduEx:(BLE_APDU)apdu forCmdDevice:(CmdDevice)device forRespnose:(eventApduResponseBlock)block;
-(int)SC_BLETransmitApdu2Ex:(BLE_APDU2)apdu2 forCmdDevice:(CmdDevice)device forRespnose:(eventApduResponseBlock)block;
-(int)SC_BLETransmitMutableApduEx:(BLE_MutableAPDU *)mutableApdu forCmdDevice:(CmdDevice)device forRespnose:(eventMutableApduResponseBlock)block;
//-(int)SC_BLETransmitSingleApduEx:(BLE_MutableAPDU*)mutableApdu forCmdDevice:(CmdDevice)device forRespnose:(eventApduResponseBlock)block;
//-(int)SC_BLETransmitFrame:(Byte*)sendData forSendLen:(int)sendLen forCmd:(int)cmd;
//-(int)SC_BLETransmitFrameEx:(Byte*)sendData forSendLen:(int)sendLen forCmd:(int)cmd forRespnose:(eventFrameResponseBlock)block;
/*
-(void)SC_BLEBind:(NSString*)iccid forUUID:(NSString*)uuid forRespnose:(eventApduResponseBlock)block;
-(void)SC_BLEUnBind:(NSString*)iccid forUUID:(NSString*)uuid forRespnose:(eventApduResponseBlock)block;
-(void)SC_BLEGetBindList:(eventApduResponseBlock)block;;   // 测试指令，不启用
*/
//-(int)SC_BLEJavaSendMarkWithRespnose:(eventApduResponseBlock)block;
//-(int)SC_BLEPressSend:(NSInteger)nTotal forCmdDevice:(CmdDevice)device forRespnose:(eventApduResponseBlock)block;
//-(int)SC_BLEPairing:(NSString *)pwd forPairingType:(PairingType)pairingType forRespnose:(eventApduResponseBlock)block;
-(int)SC_BLEMatchCode:(NSData *)matchCodeData Response:(eventApduResponseBlock)block;

//-(int)SC_BLEPairingEX:(NSString*)pwd forPairingType:(PairingType)pairingType forUUID:(NSString*)uuid forRespnose:(eventApduResponseBlock)block;

//-(void)SC_BLESetSIMLoader:(BleLoader_Version*)pLoader;
//-(BleLoader_Version*)SC_BLEGetSIMLoader;
-(void)setLoaderVersion:(BleLoader_Version*)pVersion;//设置caSimBle保存的loaderVersion,native卡，java卡指令需区别对待
-(BleLoader_Version*)loaderVersion;//获取caSimBle保存的loaderVersion
-(int)BleGetLoaderVersionWithResponse:(eventApduResponseBlock)block;
-(int)BleGetCardNoWithResponse:(eventApduResponseBlock)block;//获取卡号

-(int)SC_BLEIOSMarkBleConnectWithRespnose:(eventApduResponseBlock)block;
-(int)SC_BLEIOSMarkBleDisConnectWithRespnose:(eventApduResponseBlock)block;
-(int)SC_BLEIOSRestartBleWithRespnose:(eventApduResponseBlock)block;

//-(void)SC_BLEIOS1356RestartWithType:(NSInteger)nType WithRespnose:(eventApduResponseBlock)block;
-(int)BleSleepWithResponse:(eventApduResponseBlock)block;
-(int)BleWakeUpWithResponse:(eventApduResponseBlock)block;


-(int)SC_BLESetBleParameter:(NSInteger)nType forTypeInfo:(NSString*)TypeInfo forRespnose:(eventApduResponseBlock)block;
//-(BLE_STATUS)SC_BLEGetStatus;
-(int)SC_BLEGetParameter:(NSInteger)nType forNumber:(NSInteger)nNumber forRespnose:(eventApduResponseBlock)block;
//设置蓝牙卡广播名 16字节 null-terminate
-(int)BleSetPeripheralName:(nonnull NSData *)nameData Response:(eventApduResponseBlock)block;
//设置蓝牙卡配对码 8字节
-(int)BleSetPeripheralMatchCode:(nonnull NSData *)matchCodeData Response:(eventApduResponseBlock)block;


//-(NSString*)SC_BLEGetDeviceID;
//-(void)SC_BLESetDeviceID;

// for debug
//-(NSString*)SC_BLEGetStaticString;
//-(void)SC_BLESetStaticString:(NSString *)staticString;
//-(uint)SC_BLEGetTxCounter;
//-(void)SC_BLESetTxCounter:(uint)txCounter;
//-(uint)SC_BLEGetRxCounter;
//-(void)SC_BLESetRxCounter:(uint)rxCounter;
//-(NSString*)SC_BLEGetStringBuffer;
//-(void)SC_BLESetStringBuffer:(NSString *)buffer;
//-(NSMutableString*)SC_BLEGetLogBuffer;
//-(void)SC_BLESetLogBuffer:(NSMutableString *)buffer;
//-(BOOL)SC_BLEGetConnectedFinish;
//-(BOOL)SC_BLEGetIsLogEnabled;
//-(void)SC_BLESetIsLogEnabled:(BOOL)isLogEnabled;
//-(BOOL)SC_BLEGetIsMemoEnabled;
//-(void)SC_BLESetIsMemoEnabled:(BOOL)isMemoEnabled;
//-(BOOL)SC_BLEGetIsPressTest;
//-(void)SC_BLESetIsPressTest:(BOOL)isPressTest;

@end


