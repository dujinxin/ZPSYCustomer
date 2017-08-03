//
//  eIDApi.h
//
//  Created by eID Mobile Technology Team on 2015/7/16.
//  Copyright (c) 2015 Trimps. All rights reserved.
//


#ifndef __UAI__eIDApi__
#define __UAI__eIDApi__

#include <stdio.h>
#include "CardReader.h"
#include "EIDSDKDefines.h"
#include <vector>

/**
 @file eIDApi.h
 @brief eID-SDK接口文件*/

/** @defgroup Api eIDApi接口定义
 * 定义了所有的eID接口
 */


/** @class eIDApi eIDApi.h
 *  @brief eIDSDK接口类，通过该类的接口使用eID功能
 *  @ingroup Api
 */

/** @brief 哈希计算时数据缓存大小*/
#define CACHE_SIZE_FOR_HASH 256

class eIDApi{
private:
    CCardReader *cardReader;
    void *phDev;
    unsigned char localAsymAlg;
    TEID_ASYMMERTIC_ALG userAsymAlg;
    TEID_HASH_ALG defaultHashAlg;
    TEID_SIGN_ALG defaultSignAlg;
    
    TEID_HASH_ALG currentHashAlg;
    TEID_SIGN_ALG currentSignAlg;
    
    //for hash
    unsigned long hashDataFrom;
    unsigned char unHashedData[CACHE_SIZE_FOR_HASH];
    unsigned long unHashedDataLen;
    bool isHashUpdateCalled;
    
    //for sign
    bool isSignUpdateCalled;
    
    //for verify
    bool isVerifyUpdateCalled;
    SIGN_INFO *signInfo4Verify;
    
private:
    unsigned long getErrorCode(unsigned long errorCode);
    unsigned long getUserAysmAlg();
    unsigned long getDefaultHashAlg();
    unsigned long getDefaultSignAlg();
    unsigned long getUserAysmAlg(TEID_ASYMMERTIC_ALG taaAlg);
    unsigned long getCurrentSignAlg(TEID_SIGN_ALG signAlg);
    unsigned long getCurrentHashAlg(TEID_HASH_ALG hashAlg);
    
    void resetHashStates();
    void resetSignStates();
    void resetVerifyStates();
    unsigned long getZa4Sm2(unsigned char* puchZaData,
                            unsigned long* pulZaLen);
    
    /**	@brief 私钥签名
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}，
     *  签名之前要确保有相应的权限，可以通过{@link login}获取权限。
     * @param taaAlg [in] 采用的非对称算法。
     * @param hashInfo [in] 可调用{@link hashInit}、{@link hashUpdate}、{@link hashFinal}获取该值
     * @param signInfo [out] 输出的签名信息。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long privateKeySign(TEID_ASYMMERTIC_ALG taaAlg, HASH_INFO *hashInfo, SIGN_INFO *signInfo);
    
    /** @brief 公钥验签
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     * @param hashInfo [in] 可调用{@link hashInit}、{@link hashUpdate}、{@link hashFinal}获取该值
     * @param signInfo [in] 待验签数据。
     * @param pbIsSuccess [out] 是否验签成功
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long publicKeyVerify(HASH_INFO *hashInfo, SIGN_INFO *signInfo, bool *pbIsSuccess);

public:
    /** @brief 构造函数，传入通信类对象
     *  @param cardReader 通信类对象
     */
    eIDApi(CCardReader *cardReader);
    
    /** @brief 析构函数
     */
    ~eIDApi(void);
public:
    
#pragma mark - device ops
    
    /** @brief 打开卡片
     *  @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long openDevice();
    
    /** @brief 关闭卡片
     *  
     *  注意：当不再需要卡片通信操作时，请及时调用该函数关闭卡片
     *  @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long closeDevice();
    
    /**
     * @brief 互斥访问加锁。
     * @return 0 - 表示成功，其它结果码表示失败。
     */
    unsigned long lock();
    
    /**
     * @brief 互斥访问解锁。
     * @return 0 - 表示成功，其它结果码表示失败。
     */
    unsigned long unlock();
    
    /**
     * @brief 重新初始化设备。
     * @return 0 - 表示成功，其它结果码表示失败。
     */
    unsigned long reset();
    
    
    
#pragma mark - sign verify
    
    /**	@brief 获取默认的签名算法
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     *
     * @param tsaAlg [out] 默认的签名算法。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long getDefaultSignAlg(TEID_SIGN_ALG *tsaAlg);
    
    /**	@brief 获取支持的签名算法
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     *
     * @param tsaAlgs [out] 支持的签名算法。
     * @param pulSize [in/out] 支持的签名算法数量。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long getSignAlgs(TEID_SIGN_ALG *tsaAlgs, unsigned long *pulSize);
    
    /**	@brief 初始化签名
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     *  签名之前，要确保有相应的权限，可以通过{@link login}获取权限，
     *  sign操作完成之前不能调用其它接口，不然权限可能失效。<br>
     *  调用该接口后，可以多次调用{@link signUpdate}计算签名值，
     *  最后，通过调用{@link signFinal}获取签名结果。
     * @param tsaAlg [in] 采用的签名算法。
     * @param hdfType [in] hash数据来源。
     * @return 0 - 表示成功，其他表示失败的错误码
     */

    unsigned long signInit(TEID_SIGN_ALG tsaAlg, HASH_DATA_FROM hdfType);
    
    /**	@brief 计算签名值，可循环调用
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     *  签名之前，要确保有相应的权限，可以通过{@link login}获取权限，
     *  sign操作完成之前不能调用其它接口，不然权限可能失效。<br>
     *  确保成功调用了{@link signInit}初始化签名，否则将返回错误；
     *  多次成功调用了该接口计算签名值后，可以通过成功调用{@link signFinal}获取签名结果。
     * @param puchDataIn [in] 签名原文。
     * @param ulDataInLen [in] 签名原文长度。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long signUpdate(unsigned char *puchDataIn, unsigned long ulDataInLen);
    
    /**	@brief 获取签名结果
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     *  签名之前，要确保有相应的权限，可以通过{@link login}获取权限，
     *  sign操作完成之前不能调用其它接口，不然权限可能失效。<br>
     *  确保成功调用了{@link signInit}初始化签名，否则将返回错误；
     *  多次成功调用了{@link signUpdate}计算签名值后，可以通过成功调用该接口获取签名结果。
     * @param pSignInfo [out] 输出的签名信息。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long signFinal(SIGN_INFO *pSignInfo);
    
    
    /**	@brief 初始化验签
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     *  调用该接口后，可以多次调用{@link verifyUpdate}计算验签值，
     *  最后，通过调用{@link verifyFinal}获取验签结果。
     * @param pSignInfo [in] 签名信息，从{@link signFinal}获取。
     * @param hdfType [in] hash数据来源。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    
    unsigned long verifyInit(SIGN_INFO *pSignInfo, HASH_DATA_FROM hdfType);
    
    /**	@brief 计算验签值，可循环调用
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     *  确保成功调用了{@link verifyInit}初始化验签，否则将返回错误；
     *  多次成功调用了该接口计算验签值后，可以通过成功调用{@link verifyFinal}获取验签结果；
     * @param puchDataIn [in] 签名原文。
     * @param ulDataInLen [in] 签名原文长度。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long verifyUpdate(unsigned char *puchDataIn, unsigned long ulDataInLen);
    
    /**	@brief 获取验签结果
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     *  确保成功调用了{@link verifyInit}初始化验签，否则将返回错误；
     *  多次成功调用了{@link verifyUpdate}计算验签值后，可以通过成功调用该接口获取验签结果。
     * @param pbIsSuccess [out] 是否验签成功。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long verifyFinal(bool *pbIsSuccess);
    
#pragma mark - hash ops
    
    /**	@brief 获取默认的hash算法
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     *
     * @param thaAlg [out] 默认的hash算法。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long getDefaultHashAlg(TEID_HASH_ALG *thaAlg);
    
    /**	@brief 获取支持的hash算法
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     *
     * @param thaAlgs [out] 支持的hash算法。
     * @param pulSize [in/out] 支持的hash算法数量。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long getHashAlgs(TEID_HASH_ALG *thaAlgs, unsigned long *pulSize);
    
    /** @brief 初始化hash算法
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     *  调用该接口后，可以多次调用{@link hashUpdate}计算hash值，
     *  最后，通过调用{@link hashFinal}获取hash结果
     * @param thaAlg [in] 采用的hash算法
     * @param hdfType [in] hash数据来源。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long hashInit(TEID_HASH_ALG thaAlg, HASH_DATA_FROM hdfType);
    
    /** @brief 计算hash值，可循环调用
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     *  确保成功调用了{@link hashInit}初始化hash，否则将返回错误；
     *  多次成功调用了该接口后，可以通过成功调用{@link hashFinal}获取hash结果。
     * @param puchDataIn    [in] 输入数据。
     * @param ulDataInLen   [in] 输入数据长度。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long hashUpdate(unsigned char *puchDataIn, unsigned long ulDataInLen);
    
    /** @brief 输出hash结果
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     *  确保成功调用了{@link hashInit}初始化hash，
     *  并且成功调用了{@link hashUpdate}计算hash值，否则将返回错误；
     *  最后可以成功调用该接口获取hash结果。
     * @param pHashInfo [out] 输出的hash结果值。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long hashFinal(HASH_INFO *pHashInfo);
    
    
    
#pragma mark - pin ops
    
    /** @brief 获取eID签名密码长度范围
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     * @param pulPinMinLen [out] eID签名密码的最小长度值。
     * @param pulPinMaxLen [out] eID签名密码的最大长度值。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long getPinRange(unsigned long *pulPinMinLen,
                              unsigned long *pulPinMaxLen);
    
    /** @brief 修改eID签名密码
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     * @param puchOldPin    [in] 输入的旧eID签名密码，要求全部数字。
     * @param ulOldPinLen   [in] 输入的旧eID签名密码的长度。
     * @param puchNewPin    [in] 输入的新eID签名密码，要求全部数字。
     * @param ulNewPinLen   [in] 输入的新eID签名密码的长度。
     * @param pbIsLock      [out] 设备是否被锁定，若不关心设备状态，该值设置为NULL
     * @param pulRetryNum   [out]	重试次数，若不关心设备状态，该值设置为NULL
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long changePin(unsigned char *puchOldPin,
                            unsigned long ulOldPinLen,
                            unsigned char *puchNewPin,
                            unsigned long ulNewPinLen,
                            bool *pbIsLock,
                            unsigned long *pulRetryNum);

    
    /** @brief 校验eID签名密码
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     * <br>如果接口返回值为0，则pbIsLock，pulRetryNum参数无效。
     * @param puchPin       [in] 输入的eID签名密码，要求全部数字。
     * @param ulPinLen      [in] 输入的eID签名密码的长度。
     * @param pbIsLock      [out] 设备是否被锁定，若不关心设备状态，该值设置为NULL
     * @param pulRetryNum   [out] 重试次数，若不关心设备状态，该值设置为NULL
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long login(unsigned char *puchPin,
                        unsigned long ulPinLen,
                        bool *pbIsLock,
                        unsigned long *pulRetryNum);
    
    /** @brief 清除设备安全状态
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     *  不管{@link login}是否成功，如果不再需要保持{@link login}状态，请及时调用该函数。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long logout();
    
    
#pragma mark - eid function
    
    /** @brief 产生随机数
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     * @param puchRandData [out] 返回的随机数数据。
     * @param trlLen [in] 取随机数的长度。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long getRandom(unsigned char *puchRandData,
                            TEID_RANDOM_LENGTH trlLen);
    
    /** @brief 读取卡内证书
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     * @param puchCert      [out] 证书数据。
     * @param pulCertLen    [out] 证书数据长度。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long getCert(unsigned char *puchCert,
                          unsigned long *pulCertLen);
    
    /** @brief 读取卡内证书并解析
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     * @param pCertinfo      [out] 证书信息。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long getCertInfo(CERT_INFO *pCertinfo);
    
    /** @brief 判断是否是eID卡
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     *  在接口返回值是0的前提下，出参才有意义
     * @param pbIseIDCard [out] true是eID卡，false是非eID卡
     * @return　0 - 表示成功，其他表示失败的错误码
     */
    unsigned long iseIDCard(bool *pbIseIDCard);
    
    /** @brief 获取能力文件信息
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     * @param pAbilityInfo [out] 获取的能力文件信息。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long getAbilityInfo(ABILITY_INFO *pAbilityInfo);
    
    /** @brief 获取应用专属信息
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     * @param pAppInfo [out] 获取应用专属信息。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long getAppInfo(APP_INFO *pAppInfo);
    
#pragma mark - parse QRCode data
    /** @brief 解析二维码
     *
     * 注意：静态调用该接口，且不需要调用{@link openDevice}。
     * @param qrcodeRawData [in] 扫描到的二维码数据
     * @param qrcodeRawDataLen [in] 扫描到的二维码数据长度，支持两种二维码长度格式：{@link QRCODE_LENGTH_88}和{@link QRCODE_LENGTH_72}
     * @param qrCodeData [out] 导出的二维码数据结构
     * @return 0 - 表示成功，其它表示失败的错误码
     */
    static unsigned long parseQRCode(const char *qrcodeRawData, unsigned long qrcodeRawDataLen, QRCODE* qrCodeData);
    
#pragma mark - not eid function
    /** @brief 获取银行卡卡号
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     * @param puchCardBankNO    [out] 银行卡卡号值。
     * @param pulCardBankNOLen  [out] 银行卡卡号长度。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long getCardBankNO(unsigned char *puchCardBankNO, unsigned long *pulCardBankNOLen);
    
    /** @brief 获取金融卡信息
     *
     *  注意：调用该接口前，确保成功调用了{@link openDevice}。
     * @param pCardInfo [out] 金融卡信息。
     * @return 0 - 表示成功，其他表示失败的错误码
     */
    unsigned long getFinancialCardInfo(FINANCIAL_CARD_INFO *pCardInfo);
    
    /** @brief 获取SDK版本号
     *
     * @return SDK版本号
     */
    static const  char* getVersion();
    
};

#endif /* defined(__UAI__eIDApi__) */
