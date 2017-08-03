//
//  BlueToothDevice.h
//  UAIDemo
//
//  Created by zly on 14-9-19.
//  Copyright (c) 2014年 SanSuo. All rights reserved.
//

#ifndef __UAIDemo__BlueToothDevice__
#define __UAIDemo__BlueToothDevice__

#include <stdio.h>
#include "CardReader.h"
#include "BlueToothErrorCode.h"
#include "DCCardReader.h"
#import <CoreBluetooth/CoreBluetooth.h>

 class BlueToothDevice:public CCardReader{
    
public:
    BlueToothDevice(char *deviceName):CCardReader(deviceName){};
    virtual ~BlueToothDevice(void);
    
     unsigned long OpenDevice(TCHAR* pszDevice, OPEN_DEVICE_METHOD OpenMode, HANDLE* phDev);
    unsigned long CloseDevice(HANDLE hDev);
    unsigned long ResetDevice(HANDLE hDev);
    unsigned long GetDeviceState(HANDLE hDev);
    unsigned long GetAtr(TCHAR* pszDevice, BYTE* pbAtr, unsigned long* pulAtrLen);
//    unsigned long Transmit(HANDLE hDev, CHByteArray& cmd, CHByteArray& ret, unsigned long *pulCosState);
    
    unsigned long Transmit(HANDLE hDev,
                           unsigned char* puchCommand,
                           unsigned long ulCommandLen,
                           unsigned char* puchData,
                           unsigned long* pulDataLen,
                           unsigned long *pulCosState);
    
    unsigned long Lock(HANDLE hDev);
    unsigned long Unlock(HANDLE hDev);
    unsigned long IsValid(TCHAR* tchDevice);
    unsigned long GetErrorCode(unsigned long errorCode);
    
    bool string2hex(const char *string,unsigned char *hex,unsigned long *len_hex);
    bool hex2string(const unsigned char *hex,const unsigned long hex_len,char *string,unsigned long *len_string);
    
public:
//    //由外部搜索到设备后进行赋值
    CBPeripheral *peripheral;
    CardReader *dcReader;
//    NSString *connectedName;
    
};


#endif /* defined(__UAIDemo__BlueToothDevice__) */
