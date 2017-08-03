#pragma once

//
//  CardReader.h
//  eidapi
//
//  Created by eID Mobile Technology Team on 2013/3/11.
//  Copyright (c) 2015 Trimps. All rights reserved.
//

#include "EIDSDKDefines.h"
#include "TypeDefines.h"
#include "ErrorCode.h"

/** @file CardReader.h
 *  @brief 抽象通信类文件
 */

/** @class CCardReader CardReader.h
 *  @brief 设备通信类，使用该类的对象去构造{@link eIDApi}对象。
 *
 *  函数的返回值由4个字节组成，前两个字节为返回码头，其值必须为
 *  <br>ERR_BASE_USER(0xe0FF0000)；后两个字节为实际返回码，由用户自己定义。
 *  <br>如：0xe0FF0004，返回码头为0xe0FF，实际返回码为0x0004。
 * @ingroup Api
 */

class CCardReader
{
public:
    /** @brief 构造函数，传入读卡器名字
     *  @param pchDeviceName 读卡器名字
     */
	CCardReader(TCHAR *pchDeviceName);
    
    /** @brief 析构函数
     */
	virtual ~CCardReader(void);

public:
    
    /** @brief 获取设备状态
     *
     *  @return 0 - 表示成功，其他表示失败的错误码
     */
    virtual unsigned long GetDeviceState(HANDLE hDev) = 0;
    
    /**
     * @brief 打开设备
     * @param pchDeviceName [in] 设备名。
     * @param OpenMode [in] 打开模式，共享（SHARE_MODE），或者独占（EXCLUSIVE）
     * @param phDev [out] 设备句柄。
     * @return 0 - 表示成功，其它结果码表示失败。
     */
	virtual unsigned long OpenDevice(TCHAR* pchDeviceName, OPEN_DEVICE_METHOD OpenMode, HANDLE* phDev) = 0;
    
    /**
     * @brief 关闭设备
     * @param hDev [in] 设备句柄。
     * @return 0 - 表示成功，其它结果码表示失败。
     */
	virtual unsigned long CloseDevice(HANDLE hDev) = 0;
    
    /**
     * @brief 重新初始化设备。
     * @param hDev [in] 设备句柄。
     * @return 0 - 表示成功，其它结果码表示失败。
     */
	virtual unsigned long ResetDevice(HANDLE hDev) = 0;
    
    /** @brief 获取卡片的atr
     *
     *  atr即ATR，为Answer To Reset(复位应答)的缩写，参见ISO_7816规范。
     *  @param deviceName [in] 设备名
     *  @param pbAtr [out] 获取到的atr值
     *  @param pulAtrLen [out] 获取的atr的长度
     * @return 0 - 表示成功，其它结果码表示失败。
     */
	virtual unsigned long GetAtr(TCHAR* deviceName, BYTE* pbAtr, unsigned long* pulAtrLen) = 0;

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
    virtual unsigned long Transmit(HANDLE hDev,
                                   unsigned char* puchCommand,
                                   unsigned long ulCommandLen,
                                   unsigned char* puchData,
                                   unsigned long* pulDataLen,
                                   unsigned long *pulCosState) = 0;
    
    /**
     * @brief 互斥访问加锁。
     * @param hDev [in] 设备句柄。
     * @return 0 - 表示成功，其它结果码表示失败。
     */
	virtual unsigned long Lock(HANDLE hDev) = 0;
    
    /**
     * @brief 互斥访问解锁。
     * @param hDev [in] 设备句柄。
     * @return 0 - 表示成功，其它结果码表示失败。
     */
	virtual unsigned long Unlock(HANDLE hDev) = 0;

public:
    char *pchDeviceName;/*!<设备名*/
};
