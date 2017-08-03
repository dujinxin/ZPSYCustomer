//
//  BlueToothErrorCode.h
//  UAIDemo
//
//  Created by zly on 14-9-19.
//  Copyright (c) 2014年 SanSuo. All rights reserved.
//

#ifndef UAIDemo_BlueToothErrorCode_h
#define UAIDemo_BlueToothErrorCode_h

//来自 BleDiscovery.h的错误码定义

// 成功
#define CARDREADERERROR_OK                  0x00

//蓝牙没有链接
#define CARDREADERERROR_CONNECTDEVICE       0x02

//上电或者下电失败
#define CARDREADERERROR_ATR                 0x04

//等待数据超时
#define CARDREADERERROR_TIMEOUT             0x05

//其他错误
#define CARDREADERERROR_OTHER               0x06

//蓝牙没有连接成功
#define CARDREADERERROR_CONNECTBLE          0x07

//等待读写特征超时
#define CARDREADERERROR_TIMEOUTCHAR         0x08
//返回的状态码不是9000 或者 其他错误
#define CARDREADERERROR_VERSION             0x09

//设备中没有放卡
#define CARDREADERERROR_NOCARD              0x0A

//有卡没有上电
#define CARDREADERERROR_POWERON             0x0B

//初始化reader失败
#define CARDREADERERROR_INITERROR           0x0C

//未知错误
#define CARDREADERERROR_UNKNOWN             0x0D



#endif
