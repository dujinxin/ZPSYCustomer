//
//  ble.h
//  CaSimBle
//
//  Created by Sunwardtel-Wangym on 13-11-27.
//  Copyright (c) 2013年 Sunwardtel. All rights reserved.
//

#ifndef CaSimBle_Ble_h
#define CaSimBle_Ble_h

#import <CoreBluetooth/CoreBluetooth.h>
#import "CASimConfig.h"
#import "ca.h"
#import "KKLog.h"


#define FRAME_HEAD_LEN      2       // ble通讯帧头长度
#define FRAME_MAX_LEN       18      // ble通讯帧最大数据长度
#define FRAME_MAX_COUNT     15
#define BLE_MAX_RECV_LEN    270
#define _sumandxor_len      2


typedef enum
{
    CmdType_APDU,       // 标准APDU
    CmdType_Frame,      // 帧命令格式
    CmdType_Unknow
    
} CmdType;

#ifdef _TiMode
typedef enum
{
    Device_3221=0,        // 3221处理
    Device_51822=1,       // 51822处理
    Device_Unknown=2
} CmdDevice;
#else
typedef enum
{
    Device_3221,        // 3221处理
    Device_51822,       // 51822处理
    Device_Unknown
    
} CmdDevice;
#endif


typedef struct
{    
    CmdType   cmdType;          // bit15        指令类型
    
    //标准APDU
    UInt16       total;            // bit14-bit11  总条数(0-15)
    UInt16       serialNo;         // bit10－bit7   序号；(0-15)
    CmdDevice cmdDevice;        // bit6         命令处理端
    int       reserve;          // bit5         保留
    
    // 帧命令
    UInt16    frameCmd;         // bit11－bit6：命令值（0－127）
    
    int       frameLen;         // bit4-bit0：当前帧数据长度(0-30)
    
/*  bit15       1   X   0：标准APDU；1：帧命令格式
    
    bit14-bit5  10  X   标准APDU：
    bit14-bit11为总条数
    bit10－bit7为当前序号；
    bit6为命令处理端，0：3221处理；1：51822处理；
    帧命令：
    bit11－bit6：命令值（0－127）
    bit5：保留
    bit4-bit0：当前帧数据长度(0-30)
*/
    // 通讯结构定义
    UInt16    frameHead;
//    Byte     *frameData;
    Byte  frameData[FRAME_MAX_LEN + _sumandxor_len];
    
} BLE_Frame;



#pragma mark 服务、特征值UUID
#define SERVICE_UUID                    @"1866"//@"180D"
#define CHARACTERISTIC_UUID             @"2A88"//@"2A37"
#define TRANSFER_SERVICE_UUID           @"1866"//@"1809"
#define TRANSFER_CHARACTERISTIC_UUID    @"2A88"//@"2A1C"

//通用表示成功的状态字
#define SW_BLE_SUCCESS          0x9000

#pragma mark 通道返回状态字
#define Ble_NotInit             0x9100      //未初始化，需先调用 -(void)SC_BLEInit;
#define Ble_DataOverFlow        0x9101      //数据不能超过3K
#define BLE_NotSupport          0x9102      // 不支持此类型
#define BLE_Disconnected        0x9103      // blePeripheral.state!=CBPeripheralStateConnected
#define BLE_NoSendCharacteristic  0x9104    //  sendCharacteristic == nil
#define BLE_BUSY                0x9105      // 通道忙

#pragma mark 通讯失败状态字
#define SW_BLE_TIMEOUT          0x9200      // 发送超时
#define SW_BLE_CLOSERF          0x9201      // 2.4G工作模式 卡端通过帧指令通知，无状态字，所以要自己定义状态字
#define SW_BLE_CHECKFAIL        0x9202      // 传输数据校验失败

@protocol SunwardBleDelegate <CBCentralManagerDelegate,CBPeripheralDelegate>
@optional

-(void)peripheral:(nonnull CBPeripheral *)peripheral didDiscoverCharacteristicsForCaSimBle:(nonnull CBCharacteristic *)characteristic;

@optional
- (void)logLevel:(KKLogLevel)level Info:(nonnull NSString *)Info;

@end

typedef void (^eventApduResponseBlock)(Byte *data, NSInteger len, NSInteger sw);
typedef void (^eventFrameResponseBlock)(Byte *data, NSInteger len, NSInteger sw);

typedef eventApduResponseBlock eventMutableApduResponseBlock ;

#endif
