//
//  ca.h
//  CaSimBle
//
//  Created by Sunwardtel-Wangym on 13-4-18.
//  Copyright (c) 2013年 Sunwardtel. All rights reserved.
//

#ifndef CaSimBle_CA_h
#define CaSimBle_CA_h



typedef struct
{
    UInt16 backLen;     // 返回的数据长度
    Byte *backData;     // 返回的数据
    
    Byte   dataLen;     // 发送的数据长度
    
    Byte cls;
    Byte ins;
    Byte p1;
    Byte p2;
    Byte num;
    
    Byte *data;
    
} BLE_APDU;

typedef struct
{
    UInt16 backLen;     // 返回的数据长度
    Byte *backData;     // 返回的数据
    
    Byte   dataLen;     // 发送的数据长度
    
    Byte cls;
    Byte ins;
    Byte p1;
    Byte p2;
    Byte num;
    
    Byte data[256];
    
} BLE_APDU2;

typedef struct //供ca2.0使用
{
    UInt32 backLen;     // 返回的数据长度
    Byte *backData;     // 返回的数据
    
    Byte dataLen[2];     // 发送的数据长度,大端模式
    
    Byte cls;
    Byte ins;
    Byte p1;
    Byte p2;
    Byte p3;
    Byte num[2];// 大端模式
    
    #define len_BLEMutableAPDU_Head 7 //{cls,ins,p1,p2,p3,num[2]}
    //Byte data[2048];//卡上缓存2K。所以数据不要超过2048
    Byte data[3072];//卡上缓存2K。所以数据不要超过2048,3k为测试界限

    
} BLE_MutableAPDU;



#endif
