//
//  DXReader.h
//  DongxinSimDemo
//
//  Created by chopper on 16/3/4.
//  Copyright © 2016年 trimps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardReader.h"
#import "CBTools.h"

class DXReader : public CCardReader{
public:
    DXReader(char *deviceName):CCardReader(deviceName){};
    /** @brief 获取设备状态
     *
     *  @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long GetDeviceState(HANDLE hDev);
    
    /**
     * @brief 打开设备
     * @param pchDeviceName [in] 设备名。
     * @param OpenMode [in] 打开模式，共享（SHARE_MODE），或者独占（EXCLUSIVE）
     * @param phDev [out] 设备句柄。
     * @return 0 - 表示成功，其它结果码表示失败。
     */
    unsigned long OpenDevice(TCHAR* pchDeviceName, OPEN_DEVICE_METHOD OpenMode, HANDLE* phDev);
    
    /**
     * @brief 关闭设备
     * @param hDev [in] 设备句柄。
     * @return 0 - 表示成功，其它结果码表示失败。
     */
    unsigned long CloseDevice(HANDLE hDev);
    
    /**
     * @brief 重新初始化设备。
     * @param hDev [in] 设备句柄。
     * @return 0 - 表示成功，其它结果码表示失败。
     */
    unsigned long ResetDevice(HANDLE hDev);
    
    /** @brief 获取卡片的atr
     *
     *  atr即ATR，为Answer To Reset(复位应答)的缩写，参见ISO_7816规范。
     *  @param deviceName [in] 设备名
     *  @param pbAtr [out] 获取到的atr值
     *  @param pulAtrLen [out] 获取的atr的长度
     * @return 0 - 表示成功，其它结果码表示失败。
     */
    unsigned long GetAtr(TCHAR* deviceName, BYTE* pbAtr, unsigned long* pulAtrLen);
    
    /**
     * @brief 发送APDU指令给卡片。
     * @param hDev [in] 设备句柄。
     * @param  puchCommand [in] 要发送的APDU命令。
     * @param  ulCommandLen [in] 指令长度
     * @param  puchData [out] 执行APDU命令后返回的数据。
     * @param  pulDataLen [out] 返回的数据长度
     * @param  pulCosState [out] 执行APDU命令后返回的状态码。
     * @return 0 - 表示成功，其它结果码表示失败。
     */
    unsigned long Transmit(HANDLE hDev,
                                   unsigned char* puchCommand,
                                   unsigned long ulCommandLen,
                                   unsigned char* puchData,
                                   unsigned long* pulDataLen,
                                   unsigned long *pulCosState);
    
    /**
     * @brief 互斥访问加锁。
     * @param hDev [in] 设备句柄。
     * @return 0 - 表示成功，其它结果码表示失败。
     */
    unsigned long Lock(HANDLE hDev);
    
    /**
     * @brief 互斥访问解锁。
     * @param hDev [in] 设备句柄。
     * @return 0 - 表示成功，其它结果码表示失败。
     */
    unsigned long Unlock(HANDLE hDev);
    
    char *MyStrCpy(char *dst, const char *src);
    
public:
    
    //    //由外部搜索到设备后进行赋值
    CBPeripheral *peripheral;

private:
    unsigned char currAtr[128];
    int atrLen;
    unsigned long GetErrorCode(unsigned long errorCode);
    BLE_APDU getApduFromString(NSString *str);
    BLE_APDU getApduFromData(NSData *data);
};