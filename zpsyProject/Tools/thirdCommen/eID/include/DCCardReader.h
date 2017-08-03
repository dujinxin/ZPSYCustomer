//
//  CardReader.h
//
//  Created by eID on 2015/5/28.
//  Copyright (c) 2015年 trimps. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CardReader : NSObject

/*! @brief 初始化读卡器适配器
 *  @param cardReader 读卡器对象
 */
-(id)InitWithCardReader:(id)cardReader;

/*! @brief获得卡片ATS，非接触式卡片的ATS(Answer To Select)值。
 *  如果为接触式卡片，则为ATR(Answer To Reset)值，主要用于区分卡片提供商。
 */
-(NSData *)GetCardATS;

/**
 * 获取设备状态
 * <br>在调用 OpenDevice()之前，首先调用GetDeviceState()判断设备状态，若已打开设备，则不执行OpenDevice()；反之执行OpenDevice()。
 * @return 0 - 表示设备打开成功，其它结果码表示失败。
 */
-(long)GetDeviceState;

/**
 * 打开设备
 * @return 0 - 表示打开成功，其它结果码表示失败。
 */
-(long)OpenDevice;

/**
 * 关闭设备
 * @return 0 - 表示关闭成功，其它结果码表示失败。
 */
-(long)CloseDevice;

/*! @brief 收发APDU指令
 * @param apduCmd 要发送的APDU命令
 * @param recv 执行APDU命令后返回的结果
 * @param state 执行状态如9000
 * @return 0 - 表示发送指令成功，其它结果码表示失败。
 */
-(long)SendApdu:(NSData *) apduCmd received:(NSMutableData *)recv state:(NSMutableData *)state;

/*! @brief 重新初始化
 * @return 0 - 表示成功，其它结果码表示失败。
*/

-(long)Reset;

/*! @brief 读写互斥锁
 * @return 0 - 表示成功，其它结果码表示失败。
 */
-(long)Lock;

/*! @brief 解除读写互斥锁
 * @return 0 - 表示成功，其它结果码表示失败。
 */
-(long)Unlock;

/*! @brief 获取读卡设备类型名，比如nfc，blueTooth等
 * @return 返回读卡设备类型名
 */
-(NSString *)GetAdapterTypeName;

/*! @brief 获取读卡设备版本，比如blueTooth 1.0
 * @return 返回读卡设备版本
 */
-(NSString *)GetAdapterVersion;

@end
