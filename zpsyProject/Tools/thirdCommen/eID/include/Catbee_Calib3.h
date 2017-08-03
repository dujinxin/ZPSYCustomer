
//-----------------------------------------------------------------------------
//
// Catbee_CaUicc.h (CaUiccEngine 头文件)
//
//-----------------------------------------------------------------------------

#ifndef Catbee_CaUiccH
#define Catbee_CaUiccH

#include "Catbee_CA.h"

//-----------------------------------------------------------------------------

typedef U16     (*FuncDef_Ret16NULL)(void);

//#define CA_DEBUG 0
#define CA_APDU_CLA     			0xE8    // APDU指令类别

#define CA_APDU_INS_SelectDomain		0x70    // 选择安全域
#define CA_APDU_INS_SM2_Encrypt			0x71    // SM2公钥加密
#define CA_APDU_INS_EnumDomain 			0x72    // 读取安全域列表
#define CA_APDU_INS_SM2_Decrypt			0x73    // SM2私钥解密
#define CA_APDU_INS_CreateDomain    	0x74	// 创建安全域
#define CA_APDU_INS_SM2_Sign			0x75    // SM2私钥签名
#define CA_APDU_INS_WriteData    		0x76    // 写入数据
#define CA_APDU_INS_SM2_Verify			0x77    // SM2公钥验证签名
#define CA_APDU_INS_ReadData    		0x78   	// 读取数据
#define CA_APDU_INS_SYM_GenKey			0x79	// 生成对称（AES、TDES）密钥
#define CA_APDU_INS_VerifyPin 			0x7A    // 验证PIN
#define CA_APDU_INS_SelectDomain2		0x7B	// 选择安全域2，返回公钥
#define CA_APDU_INS_RSA_Encrypt	   		0x7C    // RSA公私钥加密
#define CA_APDU_INS_ClearDomain			0x7D	// 重置安全域
#define CA_APDU_INS_RSA_Decrypt	    	0x7E    // RSA公私钥解密
#define CA_APDU_INS_Import_AsymKey_RSA  0x7F    // 导入非对称密钥对

#define CA_APDU_INS_ChangeCreateKey 	0x80    // 修改创建密钥
#define CA_APDU_INS_SYM_Encrypt			0x81	// 对称（AES、TDES）加密
#define CA_APDU_INS_UnblockPin			0x82    // 解锁PIN
#define CA_APDU_INS_ASYM_Decrypt		0x83	// 私钥解密,解密后的数据用于对称（AES、TDES）解密
#define CA_APDU_INS_ChangePin    		0x84    // 修改PIN
#define CA_APDU_INS_SYM_Decrypt			0x85	// 对称（AES、TDES）解密
#define CA_APDU_INS_SetStatus 			0x86    // 设置安全域状态
#define CA_APDU_INS_ASYM_Public_Import	0x87	// 导入公钥
#define CA_APDU_INS_DelDomain    		0x88    // 删除安全域
#define CA_APDU_INS_ASYM_Public_Import_Encrypt	0x89	// 导入公钥加密
#define CA_APDU_INS_ClearSelect			0x8A    // 清空安全域选择
#define CA_APDU_INS_InitData			0x8B    // 初始化数据区域
#define CA_APDU_INS_GetPubKey			0x8C    // 获取公钥
#define CA_APDU_INS_DevAuth			0x8d    // 设备认证
#define CA_APDU_INS_RSA_PrivateCryption		0x8E	// RSA私钥加解密
#define CA_APDU_INS_Envelope			0x8F	// 拼包指令
#define CA_APDU_INS_GenSignKey			0x98	// 生成签名密钥对

#define CA_MAX_E2_DATA_SIZE    			60 * 1024   	// 数据空间大小

#define CA_MAX_DOMAIN_COUNT    			16   	// 域个数

#define CA_MAX_DATA_BLOCK_LEN 			256  	// 一个数据块的长度
#define CA_MAX_DATA_BLOCK_COUNT 		186  	// 数据块的数量
#define CA_MAX_DOMAIN_DATA_BLOCK_COUNT 		32 	// 每个域的数据块的数量
#define CA_MAX_NUM_CREATEKEY_FLAG		64 	// 创建密钥标志个数

#define CA_TYPE_ARITHM_3DES			0x01	// Triple DES
#define CA_TYPE_ARITHM_AES			0x02	// AES

#define CA_TYPE_KEY_MAC_CREATE			0x01	// 创建密钥
#define CA_TYPE_KEY_MAC_MANAGE			0x02	// 管理密钥
#define CA_TYPE_KEY_MAC_PIN		        0x03    // 保护密钥

#define CA_SM2_256_MODULUS_BIT_LEN 		256	// SM2 256模位数
#define CA_SM2_512_MODULUS_BIT_LEN 		512	// SM2 512模位数
#define CA_SM2_256_MODULUS_LEN 			32	// SM2 256模长
#define CA_SM2_512_MODULUS_LEN 			64	// SM2 512模长
#define CA_RSA_1024_MODULUS_LEN 		128	// RSA 1024模长
#define CA_RSA_2048_MODULUS_LEN 		256	// RSA 2048模长
#define CA_MAX_SM2_MODULUS_LEN 			32	// SM2模长
#define CA_MAX_RSA_MODULUS_LEN 			128	// RSA模长

#define CA_MAX_ZONE_COUNT 			    0x02	// 数据分区数
#define CA_MAX_CREATE_KEY_COUNT 		0x20	// 创建密钥个数
#define CA_MAX_ASYM_KEY_COUNT 			0x02	// 非对称密钥对个数
#define CA_MAX_E2_RECV_APDU_DATA_SIZE 		2048	// APDU数据报文缓存大小
#define CA_MAX_E2_RECV_APDU_SIZE 		(CA_MAX_E2_RECV_APDU_DATA_SIZE + 8)	// APDU缓存大小
#define CA_MAX_RAM_SEND_DATA_SIZE 		256	// 发送缓存大小

#define CA_LEN_DMID				16
#define CA_LEN_NAME				16
#define CA_LEN_PASSWORD				16
#define CA_LEN_LIMITDATE			4
#define CA_LEN_RANDOM				16
#define CA_LEN_MAC				8
#define CA_LEN_KEY				16
#define CA_LEN_MD5				16
#define CA_LEN_CARDID				8

//#define CA_

#define CA_SECURE_NEVER_ACCOUNT 0x0000
#define CA_SECURE_ADM_ACCOUNT 0x0001
#define CA_SECURE_USER_ACCOUNT 0x0010
#define CA_SECURE_ANYONE_ACCOUNT 0x00ff

//-----------------------------------------------------------------------------
//
// RSA数据结构
// 
//-----------------------------------------------------------------------------

typedef struct
{
	U32 nSizeN;                                 // 模数 N 的长度，单位 bit 
    U32 nE;                                     // 公钥幂指数 E
	U8  aModulus[CA_RSA_1024_MODULUS_LEN];      // 模
	U8  aPrivate[CA_RSA_1024_MODULUS_LEN];	    // 私钥
} CA_STU_RSA;

//-----------------------------------------------------------------------------
//
// SM2数据结构
// 
//-----------------------------------------------------------------------------

typedef struct
{
	U32 nP;							                    //模数的位数,256bit
	U8 aPrivate[CA_MAX_SM2_MODULUS_LEN];
	U8 aPublicQx[CA_MAX_SM2_MODULUS_LEN];
	U8 aPublicQy[CA_MAX_SM2_MODULUS_LEN];
	U8 aSignatureR[CA_MAX_SM2_MODULUS_LEN];				//明文签名信息R
	U8 aSignatureS[CA_MAX_SM2_MODULUS_LEN];				//明文签名信息S
} CA_STU_SM2;

//-----------------------------------------------------------------------------
//
// 数据块头结构
// 
//-----------------------------------------------------------------------------

#define CA_INDEX_DOMAIN_INVALID 0xff

typedef struct
{
	U8 nDomainIndex;			// 域索引
	U8 nZoneIndex;				// 数据分区索引
	U16 nBlockNo;				// 块号
} CA_STU_DATA_BLOCK_HEAD;

//-----------------------------------------------------------------------------
//
// 数据区域属性
// 
//-----------------------------------------------------------------------------

typedef struct
{
	U32 nDataSpace;				// 数据空间大小
	U16 nWriteRight;				// 写权限
	U16 nReadRight;				// 读权限
} CA_STU_DATA_ZONE_ATTRI;

//-----------------------------------------------------------------------------
//
// 非对称密钥
// 
//-----------------------------------------------------------------------------

typedef struct
{
	union
	{
		CA_STU_RSA mRSA;
		CA_STU_SM2 mSM2;	
	} Key;
} CA_STU_ASYM_KEY;

//-----------------------------------------------------------------------------
//
// 密钥
// 
//-----------------------------------------------------------------------------

#define CA_INDEX_ASYMKEY_SIGN 0x00			// 签名密钥索引
#define CA_INDEX_ASYMKEY_ENCRYPTION 0x01		// 加密密钥索引

#define CA_INDEX_PIN_ADM 0x00				// 管理员PIN索引
#define CA_INDEX_PIN_USER 0x01				// 用户PIN索引

typedef struct
{	
	// 对于用户PIN前面8字节为8位数字或者字母组成，后面8字节为前面8字节取反。不启用密码验证时PIN码为8个字符0
	U8  aPin[2][CA_LEN_KEY]; 				// 管理员PIN，用户PIN
	CA_STU_ASYM_KEY AsymKey[CA_MAX_ASYM_KEY_COUNT];		// 非对称密钥，一个用来签名，一个用来加密
} CA_STU_DOMAIN_KEY;
    	
//-----------------------------------------------------------------------------
//
// CA基本信息
// 
//-----------------------------------------------------------------------------

typedef struct
{	
	U8  aVersion[4];				// 软件版本
	U32 nDataSize;					// 内存总量
	U32 nDataSizeUsed;				// 已分配内存
	U16 nDomainUsed;	 			// 安全域已使用数量
	U8  aReseved[2];

} CA_STU_MAIN_INFO;

//-----------------------------------------------------------------------------
//
// 安全域数据结构
//
//-----------------------------------------------------------------------------

#define DOMAIN_TYPE_RSA1024  		0x01		// RSA算法1024位
#define DOMAIN_TYPE_RSA2048  		0x02		// RSA算法1024位
#define DOMAIN_TYPE_SM2256   		0x03		// SM2算法256位
#define DOMAIN_TYPE_SM2512   		0x04		// SM2算法512位

#define DOMAIN_STATUS_NULL   		0xff 		// 空闲
#define DOMAIN_STATUS_USED   		0x01 		// 使用
#define DOMAIN_STATUS_STOP   		0x02 		// 停用

#define DOMAIN_USER_DEL_ENABLE  	0x01 		// 允许用户删除
#define DOMAIN_USER_DEL_UNENABLE  	0x02 		// 不允许用户删除
#define DOMAIN_PIN_VERIFY_ENABLE	0x01 		// 验证保护密码
#define DOMAIN_PIN_VERIFY_UNENABLE	0x02 		// 不需要验证保护密码
#define DOMAIN_PIN_LOCK_YES		0x80 		// PIN码锁定
#define DOMAIN_PIN_UPDATE_YES		0x01 		// PIN码已修改

typedef struct
{
	U8  aDMID[CA_LEN_DMID];                 // 唯一标识符
	U8  aName[CA_LEN_NAME];                 // 域名 UCS2编码
	U8  nType;                            	// 类型
	U8  nStatus;				// 状态
	U8  nUserDel;                     	// 是否允许用户删除安全域
	U8  nPinVerify;				// 0:不验证PIN 1：验证PIN
	U8  aLimitDate[4];                     	// 有效期限，cn编码，如2030年12月31日，可以编码为0x20301231
	
	CA_STU_DATA_ZONE_ATTRI DataZoneAttri[CA_MAX_ZONE_COUNT]; // 数据分区属性

	U8 nUserPinFlag;			// 用户PIN码锁定标志 用户PIN码修改标志
	U8 nUserPinCount;			// 用户PIN码最大验证次数 用户PIN码剩余验证次数
	U8 nAdmPinFlag;				// 管理员PIN码锁定标志 管理员PIN码修改标志
	U8 nAdmPinCount;			// 管理员PIN码最大验证次数 管理员PIN码剩余验证次数

	U16 nPubKeyReadRight;			// 公钥读取权限
	U8 nCreateKeyIndex;			// 创建密钥索引
	U8 nReserved;

} CA_STU_DOMAIN_INFO;

//-----------------------------------------------------------------------------
//
// 卡上CA数据结构
//
//-----------------------------------------------------------------------------

#define CA_MAIN_FLAG_INIT_OK 0x98228869
#define CA_MAIN_FLAG_INIT_AGAIN 0x28458976
#define CA_MAIN_FLAG_INIT_NO 0xffffffff

typedef struct
{
	U32 nInitFlag;							// 初始化数据区域标志
	U8 aCreateFlag[8];						// 创建密钥使用标志	
	U8 aDomainCreateKey[CA_MAX_CREATE_KEY_COUNT][CA_LEN_KEY];	// 安全域创建密钥

	CA_STU_MAIN_INFO mMainInfo;	
	CA_STU_DOMAIN_INFO  mDomain[CA_MAX_DOMAIN_COUNT];  		// 域属性
	CA_STU_DATA_BLOCK_HEAD mDataBlockHead[CA_MAX_DATA_BLOCK_COUNT];	// 数据块头
	CA_STU_DOMAIN_KEY mDomainKey[CA_MAX_DOMAIN_COUNT];		// 域密钥
	U8 aDataBlock[CA_MAX_DATA_BLOCK_COUNT][CA_MAX_DATA_BLOCK_LEN];	// 数据块

	CA_STU_ASYM_KEY mAsymImportKey;					// 用于存储外部导入密钥对
	
	U8 aRecvData[CA_MAX_E2_RECV_APDU_SIZE];				// 命令报文数据缓存
	U8 aReserved[236];						// 保留			           		
} CA_STU_MAIN;

// 以下为指令使用到的结构

//-----------------------------------------------------------------------------
//
// 选择安全域
//
//-----------------------------------------------------------------------------

// 指令结构
typedef struct
{
	U8 aDMID[CA_LEN_DMID];		// 安全域唯一标识
} CA_APDU_SelectDomain_Ins;

// 应答结构
typedef struct
{
	U8  aCardID[8];				// 卡ID
	U8  aVersion[8];			// 软件版本
	U16 nDomainTotal;			// 安全域容量
	U16 nDomainUsed;	 		// 安全域已使用数量
	U32 nDataSize;				// 内存总量
	U32 nDataSizeUsed;			// 已分配内存
	U32 nDataBlockSize;			// 内存块大小
	U8  aRandom[CA_LEN_RANDOM];             // 随机数
	U32 nMaxApduDataLen;			// APDU命令数据域最大长度
	U32 nMaxApduRespLen;			// APDU响应报文最大长度
	U8  aName[CA_LEN_NAME];                 // 域名 UCS2编码
	U8  nType;                            	// 类型
	U8  nStatus;				// 状态
	U8  nUserDel;                     	// 是否允许用户删除安全域
	U8  nPinVerify;				// 0:不验证PIN 1：验证PIN
	U8  aLimitDate[4];                     	// 有效期限，cn编码，如2030年12月31日，可以编码为0x20301231
	
	CA_STU_DATA_ZONE_ATTRI DataZoneAttri[CA_MAX_ZONE_COUNT]; // 数据分区属性

	U8 nUserPinFlag;			// 用户PIN码锁定标志 用户PIN码修改标志
	U8 nUserPinCount;			// 用户PIN码最大验证次数 用户PIN码剩余验证次数
	U8 nAdmPinFlag;				// 管理员PIN码锁定标志 管理员PIN码修改标志
	U8 nAdmPinCount;			// 管理员PIN码最大验证次数 管理员PIN码剩余验证次数
	
	U16 nPubKeyReadRight;			// 公钥读取权限
	U8 nP1;
	U8 nP2;
	
} CA_APDU_SelectDomain_Resp;

typedef struct
{
	U8  aCardID[8];					// 卡ID
	U8  aVersion[8];				// 软件版本
	U16 nDomainTotal;				// 安全域容量
	U16 nDomainUsed;	 			// 安全域已使用数量
	U32 nDataSize;					// 内存总量
	U32 nDataSizeUsed;				// 已分配内存
	U32 nDataBlockSize;				// 内存块大小
	U8  aRandom[CA_LEN_RANDOM];                 	// 随机数
	U32 nMaxApduDataLen;				// 支持的APDU命令数据域最大长度
	U32 nMaxApduRespLen;				// 支持的APDU响应报文最大长度
	
} CA_APDU_SelectDomain_Resp2;

//-----------------------------------------------------------------------------
//
// 清空安全域选择
//
//-----------------------------------------------------------------------------

// 指令结构 无
// 应答结构 无

//-----------------------------------------------------------------------------
//
// 获取安全域ID列表
//
//-----------------------------------------------------------------------------

// 安全域ID列表数据一个报文可能无法返回, 需要多个报文返回
// P1 = xx, 返回安全域ID列表第xx个报文，xx从0x01开始。 P2 = 00 

// 指令结构 无

// 应答结构
/*typedef struct
{
	U8 aDMIDList[0];	//  每16个字节为一个安全域ID
} CA_APDU_EnumDomain_Resp;*/

//-----------------------------------------------------------------------------
//
// 创建安全域
//
//-----------------------------------------------------------------------------

// 前提：选择安全域，安全域唯一标识给全零

// 指令结构

// aCipherData的明文：

typedef struct
{
	CA_STU_DOMAIN_INFO mDomainInfo;
	
	U8  aAdmPin[CA_LEN_KEY];
	U8  aUserPin[CA_LEN_KEY];	
} CA_APDU_CreateDomain_Ins_Plain;

typedef struct
{
	U8 aCipherData[104];			// 密文数据
	U8 aMac[CA_LEN_MAC];	
} CA_APDU_CreateDomain_Ins;

// 应答结构
typedef struct
{
	U32 PublicExponent;			// 公钥指数
	U32 nModulusLen;                  	// 模长
	U8  aModulus[CA_MAX_RSA_MODULUS_LEN];	// 模数
} CA_APDU_CreateDomain_Resp;

typedef struct
{
	U32 nP;					//模数的位数,256bit
	U8 aPublicQx[CA_MAX_SM2_MODULUS_LEN];
	U8 aPublicQy[CA_MAX_SM2_MODULUS_LEN];
} CA_APDU_CreateDomain_Resp2;

//-----------------------------------------------------------------------------
//
// 密码验证
//
//-----------------------------------------------------------------------------

// 前提: 选择安全域

// 指令结构
typedef struct
{
	U8 aMac[CA_LEN_MAC];                // 密码校验mac
} CA_APDU_VerifyPin_Ins;

// 应答结构 无

//-----------------------------------------------------------------------------
//
// 修改创建密钥
//
//-----------------------------------------------------------------------------

// 指令结构
typedef struct
{
	U8 aCipherData[24];                  // 密文
	U8 aMac[CA_LEN_MAC];	
	
} CA_APDU_ChangeCreateKey_Ins;

// 应答结构 无

//-----------------------------------------------------------------------------
//
// 写数据
//
//-----------------------------------------------------------------------------

// 前提: 选择安全域，验证密码(若需要)

// 指令结构

// P1 = 0, P2 = 0, Lc = 命令报文字节数 

typedef struct
{
	U16 nZoneIndex;				// 数据区域索引
	U16 nOffset;				// 数据写入的偏移量
	U16 nDataLen;				// 待写入数据的长度
	U8 aData[1];                      	// 待写入数据
} CA_APDU_WriteData_Ins;


// 应答结构 无

//-----------------------------------------------------------------------------
//
// 读数据
//
//-----------------------------------------------------------------------------

// 前提: 选择安全域，验证密码(若需要)

// P1 = 数据块号, P2 = 开始读取的位置, Le = 需要读取的数据长度(00表示读取从开始读取位置至记录末尾的数据) 

// 指令结构 无

// 应答结构

typedef struct
{
	U16 nZoneIndex;				// 数据区域索引
	U16 nOffset;				// 数据读取的偏移量
	U16 nReadLen;				// 期望读取数据的长度（若此值为0，表示返回所有数据）
} CA_APDU_ReadData_Ins;


//-----------------------------------------------------------------------------
//
// RSA加密
//
//-----------------------------------------------------------------------------

// 前提: 选择安全域，验证密码(若需要)

// 指令结构

#define TYPE_ENCRYPT_PRIVATEKEY 	0x0001 		   //私钥加密
#define TYPE_ENCRYPT_PUBLICKEY 		0x0002 		   //公钥加密

typedef struct
{
	U16 nPlainLen;                    //明文长度
	U16 nType;                        //密钥类型
	U8  aPlainData[4];                //明文
} CA_APDU_RSA_Encrypt_Ins;

// 应答结构
/*
typedef struct
{
	U8 aCipherData[0];                  //密文
} CA_APDU_RSA_Encrypt_Resp;
*/

//-----------------------------------------------------------------------------
//
// RSA解密
//
//-----------------------------------------------------------------------------

// 前提: 选择安全域，验证密码(若需要)

// 指令结构

#define TYPE_DECRYPT_PRIVATEKEY 	0x0001 		   //私钥解密
#define TYPE_DECRYPT_PUBLICKEY 		0x0002 		   //公钥解密

typedef struct
{
	U16 nCipherLen;                      	//密文长度
	U16 nType;                        	//密钥类型
	U8  aCipherData[4];                  	//密文
} CA_APDU_RSA_Decrypt_Ins;

// 应答结构
/*
typedef struct
{
	U8 aPlainData[0];                   //明文
} CA_APDU_RSA_Decrypt_Resp;
*/

//-----------------------------------------------------------------------------
//
// SM2公钥加密
//
//-----------------------------------------------------------------------------

#define MAX_LENGTH_PLAIN 	        128 	// 明文最大长度
#define MAX_LENGTH_SIGN_MESSAGE 	128     // 签名信息最大长度

// 前提: 选择安全域，验证密码(若需要)

// 指令结构

typedef struct
{
	U32 nPlainLen;                    // 明文长度
	U8  aPlainData[4];                // 明文
} CA_APDU_SM2_Encrypt_Ins;

// 应答结构
/*
typedef struct
{
	U8 aCipherData[0];                  //密文
} CA_APDU_SM2_Encrypt_Resp;
*/

//-----------------------------------------------------------------------------
//
// SM2私钥解密
//
//-----------------------------------------------------------------------------

// 前提: 选择安全域，验证密码(若需要)

// 指令结构

typedef struct
{
	U32 nCipherLen;                      	// 密文长度
	U8  aCipherData[4];                  	// 密文
} CA_APDU_SM2_Decrypt_Ins;

// 应答结构
/*
typedef struct
{
	U8 aPlainData[0];                   //明文
} CA_APDU_SM2_Decrypt_Resp;
*/

//-----------------------------------------------------------------------------
//
// SM2签名
//
//-----------------------------------------------------------------------------

// 前提: 选择安全域，验证密码(若需要)

// 指令结构

typedef struct
{
	U32 nPlainLen;                      	// 明文长度
	U8  aData[4]; 				// 明文. 实际长度由nPlainLen指定
} CA_APDU_SM2_Sign_Ins;

// 应答结构

typedef struct
{
	U8 aSignatureR[CA_MAX_SM2_MODULUS_LEN];				// 明文签名信息R
	U8 aSignatureS[CA_MAX_SM2_MODULUS_LEN];				// 明文签名信息S
} CA_APDU_SM2_Sign_Resp;


//-----------------------------------------------------------------------------
//
// SM2验证签名
//
//-----------------------------------------------------------------------------

// 前提: 选择安全域，验证密码(若需要)

// 指令结构

typedef struct
{
	U8 aSignatureR[CA_MAX_SM2_MODULUS_LEN];			// 明文签名信息R
	U8 aSignatureS[CA_MAX_SM2_MODULUS_LEN];			// 明文签名信息S
	U32 nPlainLen;                      			// 明文长度
	U8  aData[4]; 						// 明文. 实际长度由nPlainLen指定
} CA_APDU_SM2_Verify_Ins;

// 应答结构 无

//-----------------------------------------------------------------------------
//
// 删除安全域
//
//-----------------------------------------------------------------------------

// 前提：选择安全域，验证密码(若需要)

// 指令结构
// P1 = 1 用户删除，P1 = 2 发卡方删除, P2 = 0
typedef struct
{
	U8 aMac[CA_LEN_MAC];
} CA_APDU_DelDomain_Ins;

// 应答结构 无

//-----------------------------------------------------------------------------
//
// 修改PIN
//
//-----------------------------------------------------------------------------

// 前提: 选择安全域，验证密码(若需要)
 
// P1 = 00 , P2 = 0x00 管理员PIN 0x01 用户PIN

// 指令结构

// aCipherPsw的明文:
// U8 aPin[16];	

typedef struct
{
	U8 aCipherPsw[24]; 	// 新密码密文
	U8 aMac[CA_LEN_MAC];
} CA_APDU_ChangePin_Ins;

// 应答结构 无

//-----------------------------------------------------------------------------
//
// 用户设置安全域状态
//
//-----------------------------------------------------------------------------

// 前提: 选择安全域，验证密码(若需要)
 
// P1 = 00 , P2 = 00 

// 指令结构

typedef struct
{
	U8 nStatus; 	
} CA_APDU_SetStatus_Ins;

// 应答结构 无

//-----------------------------------------------------------------------------
//
// 清空保护密码
//
//-----------------------------------------------------------------------------

// 前提: 选择安全域，验证密码(若需要)
 
// P1 = 01：用户 , P2 = 02：管理密钥 

// 指令结构

typedef struct
{
	U8 aMac[CA_LEN_MAC];
} CA_APDU_ReloadPin_Ins;

// 应答结构 无

//-----------------------------------------------------------------------------
//
// 取公钥
//
//-----------------------------------------------------------------------------

// 前提：选择安全域，验证密码(若需要)

// 指令结构 无

// 应答结构

//同CA_APDU_CreateDomain_Resp

//-----------------------------------------------------------------------------
//
// 取私钥
//
//-----------------------------------------------------------------------------

// 前提：选择安全域，验证密码(若需要)

// 指令结构 无

// 应答结构

typedef struct
{
	U32 nPrivateExponentLength;			// 私钥长度
	U8 aPrivateExponent[CA_MAX_RSA_MODULUS_LEN];	// 私钥
} CA_APDU_GetPrivateKey_Resp;

typedef struct
{
	U32 nP;						//模数的位数,256bit
	U8 aPrivate[32];
} CA_APDU_GetPrivateKey_Resp2;

//-----------------------------------------------------------------------------
//
// 生成对称（AES、TDES）密钥
//
//-----------------------------------------------------------------------------

// P1 = 加密公钥密钥类型 P2 = 对称（AES、TDES）密钥类型

// 指令结构
typedef struct
{
	U32 PublicExponent;			// 公钥指数
	U32 nModulusLen;                  	// 模长
	U8  aModulus[CA_MAX_RSA_MODULUS_LEN];	// 模数
} CA_APDU_SYM_GenKey_Ins;

typedef struct
{
	U32 nP;					//模数的位数,256bit
	U8 aPublicQx[CA_MAX_SM2_MODULUS_LEN];
	U8 aPublicQy[CA_MAX_SM2_MODULUS_LEN];
} CA_APDU_SYM_GenKey_Ins1;

// 应答结构

typedef struct
{
	U8 aCipher[4];	// 用卡内公钥加密对称（AES、TDES）密钥得到的加密数据，变长
} CA_APDU_SYM_GenKey_Resp;

//-----------------------------------------------------------------------------
//
// 对称（AES、TDES）加密
//
//-----------------------------------------------------------------------------

// 指令结构
typedef struct
{
	U8  aPlain[4];	//  明文数据，变长
} CA_APDU_SYM_Encrypt_Ins;

// 应答结构

typedef struct
{
	U8 aCipher[4];	// 用卡内AES密钥加密输入明文得到的密文，变长
} CA_APDU_SYM_Encrypt_Desp;

//-----------------------------------------------------------------------------
//
// 私钥解密,解密后的数据为对称（AES、TDES）密钥,用于解密
//
//-----------------------------------------------------------------------------

// 前提: 选择安全域，验证密码(若需要)

// P1 = 对称（AES、TDES）密钥类型

// 指令结构
typedef struct
{
	U8  aCipher[4];	//  密文数据，变长
} CA_APDU_ASYM_Decrypt_Ins;

//-----------------------------------------------------------------------------
//
// 对称（AES、TDES）解密
//
//-----------------------------------------------------------------------------

// 指令结构
typedef struct
{
	U8  aCipher[4];	//  密文数据，变长
} CA_APDU_SYM_Decrypt_Ins;

// 应答结构

typedef struct
{
	U8 aPlain[4];	// 明文，变长
} CA_APDU_SYM_Decrypt_Desp;


//-----------------------------------------------------------------------------
//
// 外部传入非对称公钥，存于内存
//
//-----------------------------------------------------------------------------

// P1 = 加密公钥密钥类型 P2 = 0

// 指令结构
typedef struct
{
	U32 PublicExponent;			// 公钥指数
	U32 nModulusLen;                  	// 模长
	U8  aModulus[CA_MAX_RSA_MODULUS_LEN];	// 模数
} CA_APDU_ASYM_Public_Import_Ins;

typedef struct
{
	U32 nP;					//模数的位数,256bit
	U8 aPublicQx[CA_MAX_SM2_MODULUS_LEN];
	U8 aPublicQy[CA_MAX_SM2_MODULUS_LEN];
} CA_APDU_ASYM_Public_Import_Ins1;

// 应答结构

// 无

//-----------------------------------------------------------------------------
//
// 外部传入非对称公钥进行加密操作
//
//-----------------------------------------------------------------------------

// 指令结构
typedef struct
{
    U8 aPlain[4];    // 待加密数据，变长 
} CA_APDU_ASYM_Public_Import_Encrypt_Ins;

// 应答结构

typedef struct
{
	U8 aCipher[4];	// 非对称公钥加密形成的密文
} CA_APDU_ASYM_Public_Import_Encrypt_Resp;

//-----------------------------------------------------------------------------
//
// 内存工作参数
//
//-----------------------------------------------------------------------------

#define STATUS_DOMAIN_ADM_PIN_VERIFY_OK 0x88 	// 管理员PIN校验成功
#define STATUS_DOMAIN_USER_PIN_VERIFY_OK 0x98 	// 用户PIN校验成功
#define STATUS_DOMAIN_PIN_VERIFY_NO 0x00 	// PIN校验未成功
#define STATUS_DOMAIN_SELECT_NULL 0x00 		// 未选择安全域	 
#define STATUS_DOMAIN_SELECT_ZERO_OK 0xAB 	// 安全域标识全零时选择成功	 
#define STATUS_DOMAIN_SELECT_OK 0xCC		// 安全域标识不为全零时选择成功
typedef struct
{
	U8 nDomainSelectStatus;	
	U8 nDomainIndex;	
	U8 nPinVerifyStatus;
	U8 nP4;		
	U8 aDMID[16];
	U8 aRandom[16];
} CA_RAM_WORK_PARAM_DOMAIN;

#define STATUS_SYM_KEY_GEN_OK 0xF6	// 对称（AES、TDES）密钥创建成功
#define STATUS_SYM_KEY_GEN_NOT 0x00	// 对称（AES、TDES）密钥未创建
typedef struct
{
	U8 aSymKey[16];
} CA_RAM_WORK_PARAM_SYM;

#define STATUS_ASYM_PUBLIC_KEY_IMPORT_NO 0xA9	// 非对称公钥未导入内存
#define STATUS_ASYM_PUBLIC_KEY_IMPORT_OK 0xEF	// 非对称公钥导入内存成功
typedef struct
{       
	U8 aData[4];
} CA_RAM_WORK_PARAM_ASYM_PUBLIC;


typedef struct
{
	U8 nP1;
	U8 nP2;
	U16 nP3;
 	union
 	{
 		CA_RAM_WORK_PARAM_SYM mSym;
 		CA_RAM_WORK_PARAM_ASYM_PUBLIC mAsymPublic;	
 	} mKey;
 	
} CA_RAM_WORK_PARAM_KEY;

//-----------------------------------------------------------------------------

#endif

