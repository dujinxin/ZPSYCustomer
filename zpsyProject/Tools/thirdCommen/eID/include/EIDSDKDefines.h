//
//  EIDSDKDefines.h
//  EIDSDK
//
//  Created by eID Mobile Technology Team on 2015/7/28.
//  Copyright (c) 2015 Trimps. All rights reserved.
//

#ifndef EIDSDKDefines_h
#define EIDSDKDefines_h

#import <string.h>

/** @file EIDSDKDefines.h
 @brief eID-SDK 结构体枚举文件*/

/** @defgroup Defines 接口参数和返回值定义
 *  定义了接口用到的所有参数和接口返回值的含义
 *  @{
 */

#define QRCODE_LENGTH_88 88 /*!<若签名算法为SM3的二维码数据长度*/
#define QRCODE_LENGTH_72 72 /*!<若签名算法为SHA1的二维码数据长度*/

/** @brief卡片能力信息*/
typedef struct ABILITY_INFO
{
    unsigned short ushDllVer;           /*!<库版本号，1字节*/
    unsigned short ushChipVer;          /*!<芯片型号，2字节*/
    unsigned short ushCOSVer;           /*!<COS厂商代码，2字节*/
    unsigned short ushFileSystemVer;	/*!<文件系统版本号，2字节*/
    unsigned short ushJavaVer;          /*!<Java版本号，2字节*/
    unsigned short ushOfflineFlag;      /*!<离线验证标识，1字节，第1位（高位）为1表示能够离线验证，0表示只可在线验证*/
    unsigned long ulSymmetricItems;     /*!<对称算法能力标识，2字节*/
    unsigned long ulAsymmetricItems;	/*!<非对称算法能力标识，2字节*/
    unsigned long ulHashItems;          /*!<Hash算法能力标识，2字节*/
    unsigned char uchIssuerOrg[32];     /*!<载体机构代码，2字节*/
    unsigned char uchIDCarrier[32];		/*!<载体自定义标识，8字节*/
    unsigned char uchUserAsymAlgType;   /*!<用户公私钥对算法标识，1字节，默认0x00，表示RSA；0x01，表示RSA；0x02，表示SM2*/
    
} ABILITY_INFO;

/** @brief 应用主算法*/
enum APA_INFO {
    APA_INFO_3DES,
    APA_INFO_SM4,
};

/** @brief应用专用信息*/
typedef struct APP_INFO
{
    APA_INFO apaInfo;                   /*!<应用主算法*/
    unsigned char uchVer[10];           /*!<应用规范版本号，2字节*/
    unsigned char uchDeveloper[10];     /*!<应用开发商标识，2字节*/
    unsigned char uchCOSVer;            /*!<COS版本号，应用开发商自定义，1字节*/
    unsigned char uchAppletVer;         /*!<Applet版本号，应用开发商自定义，1字节*/
    
    //这里有疑问需要修改
    unsigned char uchUserAsymAlgType[20];   /*!<用户公私钥对算法标识，1字节，默认0x00，表示RSA；0x01，表示RSA；0x02，表示SM2*/
    
} APP_INFO;



/** @brief 打开设备方式*/
enum OPEN_DEVICE_METHOD
{
    SHARE_MODE = 0x01,/*!<共享模式*/
    EXCLUSIVE  = 0x02/*!<独占模式*/
};

/** @brief 哈希算法定义*/
enum TEID_HASH_ALG
{
    TEID_HASH_SM3		= 0x01,		/*!<国密SM3哈希算法*/
    TEID_HASH_SHA1		= 0x02,		/*!<SHA-1算法*/
    TEID_HASH_SHA256	= 0x04,		/*!<SHA256算法*/
    TEID_HASH_AUTO      = 0XFF,     /*!<自动判断支持的算法*/
};

/** @brief 签名算法定义*/
enum TEID_SIGN_ALG
{
    TEID_SIGN_SHA1_WITH_RSA1024     = 0x01,		/*!<使用SHA1做RSA1024签名*/
    TEID_SIGN_SM3_WITH_SM2          = 0x02,		/*!<使用SM3做SM2签名*/
    TEID_SIGN_SHA256_WITH_RSA1024   = 0x03,     /*!<使用SHA256做RSA1024签名*/
    TEID_SIGN_AUTO                  = 0XFF,     /*!<自动判断支持的算法*/
};


/** @brief 非对称算法定义*/
enum TEID_ASYMMERTIC_ALG
{
    TEID_ASYM_RSA1024	= 0x01,		/*!<1024bitRSA非对称算法*/
    TEID_ASYM_RSA2048	= 0x02,		/*!<2048bitRSA非对称算法，暂不支持*/
    TEID_ASYM_SM2		= 0x04,		/*!<签名用国密SM2(ECC)非对称算法*/
    TEID_ASYM_RSA1280	= 0x20,		/*!<1280bitRSA非对称算法，暂不支持*/
    TEID_ASYM_AUTO      = 0XFF,     /*!<自动判断支持的算法*/
};

/** @brief 随机数长度定义*/
enum TEID_RANDOM_LENGTH
{
    TEID_RANDOM_LENGTH_4	= 0x01,		/*!<随机数长度为4*/
    TEID_RANDOM_LENGTH_8	= 0x02,		/*!<随机数长度为8*/
    TEID_RANDOM_LENGTH_16	= 0x03,		/*!<随机数长度为16*/
};

/** @brief 金融卡类型定义*/
enum FINANCIAL_CARD_TYPE
{
    FINANCIAL_CARD_SEMI_CREADIT     = 0X01,/*!<银联准贷记应用*/
    FINANCIAL_CARD_DEBIT            = 0X02,/*!<银联借记应用*/
    FINANCIAL_CARD_CREDIT           = 0X03,/*!<银联贷记应用*/
    FINANCIAL_CARD_CASH             = 0X04,/*!<银联电子现金应用*/
    FINANCIAL_CARD_UNKNOWN          = 0X05,/*!<未知应用*/
};

/** @brief hash结果信息
 *
 *  包括hash值，hash长度，采用的hash算法
 */
typedef struct HASH_INFO{
    unsigned char *puchData;/*!<hash 结果值*/
    unsigned long *ulDataLen;/*!<hash 长度*/
    TEID_HASH_ALG thaAlg;/*!<采用的hash算法*/
}HASH_INFO;

/** @brief 签名信息
 *
 *  包括签名值，签名长度，采用的签名算法
 */
typedef struct SIGN_INFO{
    unsigned char *puchData;/*!<签名值*/
    unsigned long *ulDataLen;/*!<签名长度*/
    TEID_SIGN_ALG tsaAlg;/*!<签名算法*/
}SIGN_INFO;

/** @brief hash数据来源
 *
 *  目前仅支持，使用卡外数据、使用卡内和卡外数据进行hash两种
 */
enum HASH_DATA_FROM{
    HASH_DATA_FROM_OUTCARD      = 0x01,     /*!<数据来自卡外*/
    HASH_DATA_FROM_INOUTCARD    = 0x11      /*!<数据来自卡内和卡外*/
};

/** @brief 金融卡信息
 *
 *  目前包括，是否是金融卡，金融卡类型
 */
typedef struct FINANCIAL_CARD_INFO{
    bool isFinancialCard;/*!<是否是金融卡*/
    FINANCIAL_CARD_TYPE fctType;/*!<金融卡类型*/
}FINANCIAL_CARD_INFO;

/** @brief 证书信息
 *
 *  包括证书序列号，发行方序列号，发行方通用名，主题项通用名
 */
typedef struct CERT_INFO{
    
    char pcheIDSN[128];/*!<证书序列号*/
    char pcheIDIssuerSN[128];/*!<证书发行方序列号*/
    char pcheIDIssuer[128];/*!<证书发行方通用名*/
    char pcheIDSC[128];/*!<证书主题项通用名*/
    
}CERT_INFO;


/** @brief 参与HMAC计算的原文
 * 
 *  包括版本号、终端机构ID、载体标识（idcarrier）、交易时间、地区号、网点号
 */
typedef struct HMAC_ORIGINAL_DATA{

    char version;/*!<版本号*/
    char issuerID[3];/*!<终端机构ID*/
    char idCarrier[13];/*!<载体标识（idcarrier）*/
    char tradingTime[15];/*!<交易时间*/
    char districtID[6];/*!<地区号*/
    char branchID[6];/*!<网点号*/
    
    /** @brief HMAC_ORIGINAL_DATA初始化函数
     */
    HMAC_ORIGINAL_DATA (){
        
        memset(this, 0, sizeof(HMAC_ORIGINAL_DATA));
    }
    
}HMAC_ORIGINAL_DATA;

/** @brief 二维码数据
 *
 *  包括参与HMAC计算的原文、签名算法标记、HMAC签名值、MAC校验值
 */
typedef struct QRCODE{
    
    struct HMAC_ORIGINAL_DATA hmacOriginalData; /*!<用于HMAC计算的原始数据*/
    
    char signType;/*!<签名算法标记*/
    char HMAC[45];/*!<HMAC签名值*/
    char MAC[5];/*!<MAC校验值*/
    
    /** @brief QRCODE初始化函数
     */
    QRCODE() {
    
        signType = 0;
        memset(HMAC, 0, sizeof(HMAC));
        memset(MAC, 0, sizeof(MAC));
    }

}QRCODE;

/** @} */ // end of group1

#endif
