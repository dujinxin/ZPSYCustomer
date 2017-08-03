
//-----------------------------------------------------------------------------
//
// Catbee_CaUicc.h (CaUiccEngine ͷ�ļ�)
//
//-----------------------------------------------------------------------------

#ifndef Catbee_CaUiccH
#define Catbee_CaUiccH

#include "Catbee_CA.h"

//-----------------------------------------------------------------------------

typedef U16     (*FuncDef_Ret16NULL)(void);

//#define CA_DEBUG 0
#define CA_APDU_CLA     			0xE8    // APDUָ�����

#define CA_APDU_INS_SelectDomain		0x70    // ѡ��ȫ��
#define CA_APDU_INS_SM2_Encrypt			0x71    // SM2��Կ����
#define CA_APDU_INS_EnumDomain 			0x72    // ��ȡ��ȫ���б�
#define CA_APDU_INS_SM2_Decrypt			0x73    // SM2˽Կ����
#define CA_APDU_INS_CreateDomain    	0x74	// ������ȫ��
#define CA_APDU_INS_SM2_Sign			0x75    // SM2˽Կǩ��
#define CA_APDU_INS_WriteData    		0x76    // д������
#define CA_APDU_INS_SM2_Verify			0x77    // SM2��Կ��֤ǩ��
#define CA_APDU_INS_ReadData    		0x78   	// ��ȡ����
#define CA_APDU_INS_SYM_GenKey			0x79	// ���ɶԳƣ�AES��TDES����Կ
#define CA_APDU_INS_VerifyPin 			0x7A    // ��֤PIN
#define CA_APDU_INS_SelectDomain2		0x7B	// ѡ��ȫ��2�����ع�Կ
#define CA_APDU_INS_RSA_Encrypt	   		0x7C    // RSA��˽Կ����
#define CA_APDU_INS_ClearDomain			0x7D	// ���ð�ȫ��
#define CA_APDU_INS_RSA_Decrypt	    	0x7E    // RSA��˽Կ����
#define CA_APDU_INS_Import_AsymKey_RSA  0x7F    // ����ǶԳ���Կ��

#define CA_APDU_INS_ChangeCreateKey 	0x80    // �޸Ĵ�����Կ
#define CA_APDU_INS_SYM_Encrypt			0x81	// �Գƣ�AES��TDES������
#define CA_APDU_INS_UnblockPin			0x82    // ����PIN
#define CA_APDU_INS_ASYM_Decrypt		0x83	// ˽Կ����,���ܺ���������ڶԳƣ�AES��TDES������
#define CA_APDU_INS_ChangePin    		0x84    // �޸�PIN
#define CA_APDU_INS_SYM_Decrypt			0x85	// �Գƣ�AES��TDES������
#define CA_APDU_INS_SetStatus 			0x86    // ���ð�ȫ��״̬
#define CA_APDU_INS_ASYM_Public_Import	0x87	// ���빫Կ
#define CA_APDU_INS_DelDomain    		0x88    // ɾ����ȫ��
#define CA_APDU_INS_ASYM_Public_Import_Encrypt	0x89	// ���빫Կ����
#define CA_APDU_INS_ClearSelect			0x8A    // ��հ�ȫ��ѡ��
#define CA_APDU_INS_InitData			0x8B    // ��ʼ����������
#define CA_APDU_INS_GetPubKey			0x8C    // ��ȡ��Կ
#define CA_APDU_INS_DevAuth			0x8d    // �豸��֤
#define CA_APDU_INS_RSA_PrivateCryption		0x8E	// RSA˽Կ�ӽ���
#define CA_APDU_INS_Envelope			0x8F	// ƴ��ָ��
#define CA_APDU_INS_GenSignKey			0x98	// ����ǩ����Կ��

#define CA_MAX_E2_DATA_SIZE    			60 * 1024   	// ���ݿռ��С

#define CA_MAX_DOMAIN_COUNT    			16   	// �����

#define CA_MAX_DATA_BLOCK_LEN 			256  	// һ�����ݿ�ĳ���
#define CA_MAX_DATA_BLOCK_COUNT 		186  	// ���ݿ������
#define CA_MAX_DOMAIN_DATA_BLOCK_COUNT 		32 	// ÿ��������ݿ������
#define CA_MAX_NUM_CREATEKEY_FLAG		64 	// ������Կ��־����

#define CA_TYPE_ARITHM_3DES			0x01	// Triple DES
#define CA_TYPE_ARITHM_AES			0x02	// AES

#define CA_TYPE_KEY_MAC_CREATE			0x01	// ������Կ
#define CA_TYPE_KEY_MAC_MANAGE			0x02	// ������Կ
#define CA_TYPE_KEY_MAC_PIN		        0x03    // ������Կ

#define CA_SM2_256_MODULUS_BIT_LEN 		256	// SM2 256ģλ��
#define CA_SM2_512_MODULUS_BIT_LEN 		512	// SM2 512ģλ��
#define CA_SM2_256_MODULUS_LEN 			32	// SM2 256ģ��
#define CA_SM2_512_MODULUS_LEN 			64	// SM2 512ģ��
#define CA_RSA_1024_MODULUS_LEN 		128	// RSA 1024ģ��
#define CA_RSA_2048_MODULUS_LEN 		256	// RSA 2048ģ��
#define CA_MAX_SM2_MODULUS_LEN 			32	// SM2ģ��
#define CA_MAX_RSA_MODULUS_LEN 			128	// RSAģ��

#define CA_MAX_ZONE_COUNT 			    0x02	// ���ݷ�����
#define CA_MAX_CREATE_KEY_COUNT 		0x20	// ������Կ����
#define CA_MAX_ASYM_KEY_COUNT 			0x02	// �ǶԳ���Կ�Ը���
#define CA_MAX_E2_RECV_APDU_DATA_SIZE 		2048	// APDU���ݱ��Ļ����С
#define CA_MAX_E2_RECV_APDU_SIZE 		(CA_MAX_E2_RECV_APDU_DATA_SIZE + 8)	// APDU�����С
#define CA_MAX_RAM_SEND_DATA_SIZE 		256	// ���ͻ����С

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
// RSA���ݽṹ
// 
//-----------------------------------------------------------------------------

typedef struct
{
	U32 nSizeN;                                 // ģ�� N �ĳ��ȣ���λ bit 
    U32 nE;                                     // ��Կ��ָ�� E
	U8  aModulus[CA_RSA_1024_MODULUS_LEN];      // ģ
	U8  aPrivate[CA_RSA_1024_MODULUS_LEN];	    // ˽Կ
} CA_STU_RSA;

//-----------------------------------------------------------------------------
//
// SM2���ݽṹ
// 
//-----------------------------------------------------------------------------

typedef struct
{
	U32 nP;							                    //ģ����λ��,256bit
	U8 aPrivate[CA_MAX_SM2_MODULUS_LEN];
	U8 aPublicQx[CA_MAX_SM2_MODULUS_LEN];
	U8 aPublicQy[CA_MAX_SM2_MODULUS_LEN];
	U8 aSignatureR[CA_MAX_SM2_MODULUS_LEN];				//����ǩ����ϢR
	U8 aSignatureS[CA_MAX_SM2_MODULUS_LEN];				//����ǩ����ϢS
} CA_STU_SM2;

//-----------------------------------------------------------------------------
//
// ���ݿ�ͷ�ṹ
// 
//-----------------------------------------------------------------------------

#define CA_INDEX_DOMAIN_INVALID 0xff

typedef struct
{
	U8 nDomainIndex;			// ������
	U8 nZoneIndex;				// ���ݷ�������
	U16 nBlockNo;				// ���
} CA_STU_DATA_BLOCK_HEAD;

//-----------------------------------------------------------------------------
//
// ������������
// 
//-----------------------------------------------------------------------------

typedef struct
{
	U32 nDataSpace;				// ���ݿռ��С
	U16 nWriteRight;				// дȨ��
	U16 nReadRight;				// ��Ȩ��
} CA_STU_DATA_ZONE_ATTRI;

//-----------------------------------------------------------------------------
//
// �ǶԳ���Կ
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
// ��Կ
// 
//-----------------------------------------------------------------------------

#define CA_INDEX_ASYMKEY_SIGN 0x00			// ǩ����Կ����
#define CA_INDEX_ASYMKEY_ENCRYPTION 0x01		// ������Կ����

#define CA_INDEX_PIN_ADM 0x00				// ����ԱPIN����
#define CA_INDEX_PIN_USER 0x01				// �û�PIN����

typedef struct
{	
	// �����û�PINǰ��8�ֽ�Ϊ8λ���ֻ�����ĸ��ɣ�����8�ֽ�Ϊǰ��8�ֽ�ȡ����������������֤ʱPIN��Ϊ8���ַ�0
	U8  aPin[2][CA_LEN_KEY]; 				// ����ԱPIN���û�PIN
	CA_STU_ASYM_KEY AsymKey[CA_MAX_ASYM_KEY_COUNT];		// �ǶԳ���Կ��һ������ǩ����һ����������
} CA_STU_DOMAIN_KEY;
    	
//-----------------------------------------------------------------------------
//
// CA������Ϣ
// 
//-----------------------------------------------------------------------------

typedef struct
{	
	U8  aVersion[4];				// ����汾
	U32 nDataSize;					// �ڴ�����
	U32 nDataSizeUsed;				// �ѷ����ڴ�
	U16 nDomainUsed;	 			// ��ȫ����ʹ������
	U8  aReseved[2];

} CA_STU_MAIN_INFO;

//-----------------------------------------------------------------------------
//
// ��ȫ�����ݽṹ
//
//-----------------------------------------------------------------------------

#define DOMAIN_TYPE_RSA1024  		0x01		// RSA�㷨1024λ
#define DOMAIN_TYPE_RSA2048  		0x02		// RSA�㷨1024λ
#define DOMAIN_TYPE_SM2256   		0x03		// SM2�㷨256λ
#define DOMAIN_TYPE_SM2512   		0x04		// SM2�㷨512λ

#define DOMAIN_STATUS_NULL   		0xff 		// ����
#define DOMAIN_STATUS_USED   		0x01 		// ʹ��
#define DOMAIN_STATUS_STOP   		0x02 		// ͣ��

#define DOMAIN_USER_DEL_ENABLE  	0x01 		// �����û�ɾ��
#define DOMAIN_USER_DEL_UNENABLE  	0x02 		// �������û�ɾ��
#define DOMAIN_PIN_VERIFY_ENABLE	0x01 		// ��֤��������
#define DOMAIN_PIN_VERIFY_UNENABLE	0x02 		// ����Ҫ��֤��������
#define DOMAIN_PIN_LOCK_YES		0x80 		// PIN������
#define DOMAIN_PIN_UPDATE_YES		0x01 		// PIN�����޸�

typedef struct
{
	U8  aDMID[CA_LEN_DMID];                 // Ψһ��ʶ��
	U8  aName[CA_LEN_NAME];                 // ���� UCS2����
	U8  nType;                            	// ����
	U8  nStatus;				// ״̬
	U8  nUserDel;                     	// �Ƿ������û�ɾ����ȫ��
	U8  nPinVerify;				// 0:����֤PIN 1����֤PIN
	U8  aLimitDate[4];                     	// ��Ч���ޣ�cn���룬��2030��12��31�գ����Ա���Ϊ0x20301231
	
	CA_STU_DATA_ZONE_ATTRI DataZoneAttri[CA_MAX_ZONE_COUNT]; // ���ݷ�������

	U8 nUserPinFlag;			// �û�PIN��������־ �û�PIN���޸ı�־
	U8 nUserPinCount;			// �û�PIN�������֤���� �û�PIN��ʣ����֤����
	U8 nAdmPinFlag;				// ����ԱPIN��������־ ����ԱPIN���޸ı�־
	U8 nAdmPinCount;			// ����ԱPIN�������֤���� ����ԱPIN��ʣ����֤����

	U16 nPubKeyReadRight;			// ��Կ��ȡȨ��
	U8 nCreateKeyIndex;			// ������Կ����
	U8 nReserved;

} CA_STU_DOMAIN_INFO;

//-----------------------------------------------------------------------------
//
// ����CA���ݽṹ
//
//-----------------------------------------------------------------------------

#define CA_MAIN_FLAG_INIT_OK 0x98228869
#define CA_MAIN_FLAG_INIT_AGAIN 0x28458976
#define CA_MAIN_FLAG_INIT_NO 0xffffffff

typedef struct
{
	U32 nInitFlag;							// ��ʼ�����������־
	U8 aCreateFlag[8];						// ������Կʹ�ñ�־	
	U8 aDomainCreateKey[CA_MAX_CREATE_KEY_COUNT][CA_LEN_KEY];	// ��ȫ�򴴽���Կ

	CA_STU_MAIN_INFO mMainInfo;	
	CA_STU_DOMAIN_INFO  mDomain[CA_MAX_DOMAIN_COUNT];  		// ������
	CA_STU_DATA_BLOCK_HEAD mDataBlockHead[CA_MAX_DATA_BLOCK_COUNT];	// ���ݿ�ͷ
	CA_STU_DOMAIN_KEY mDomainKey[CA_MAX_DOMAIN_COUNT];		// ����Կ
	U8 aDataBlock[CA_MAX_DATA_BLOCK_COUNT][CA_MAX_DATA_BLOCK_LEN];	// ���ݿ�

	CA_STU_ASYM_KEY mAsymImportKey;					// ���ڴ洢�ⲿ������Կ��
	
	U8 aRecvData[CA_MAX_E2_RECV_APDU_SIZE];				// ��������ݻ���
	U8 aReserved[236];						// ����			           		
} CA_STU_MAIN;

// ����Ϊָ��ʹ�õ��Ľṹ

//-----------------------------------------------------------------------------
//
// ѡ��ȫ��
//
//-----------------------------------------------------------------------------

// ָ��ṹ
typedef struct
{
	U8 aDMID[CA_LEN_DMID];		// ��ȫ��Ψһ��ʶ
} CA_APDU_SelectDomain_Ins;

// Ӧ��ṹ
typedef struct
{
	U8  aCardID[8];				// ��ID
	U8  aVersion[8];			// ����汾
	U16 nDomainTotal;			// ��ȫ������
	U16 nDomainUsed;	 		// ��ȫ����ʹ������
	U32 nDataSize;				// �ڴ�����
	U32 nDataSizeUsed;			// �ѷ����ڴ�
	U32 nDataBlockSize;			// �ڴ���С
	U8  aRandom[CA_LEN_RANDOM];             // �����
	U32 nMaxApduDataLen;			// APDU������������󳤶�
	U32 nMaxApduRespLen;			// APDU��Ӧ������󳤶�
	U8  aName[CA_LEN_NAME];                 // ���� UCS2����
	U8  nType;                            	// ����
	U8  nStatus;				// ״̬
	U8  nUserDel;                     	// �Ƿ������û�ɾ����ȫ��
	U8  nPinVerify;				// 0:����֤PIN 1����֤PIN
	U8  aLimitDate[4];                     	// ��Ч���ޣ�cn���룬��2030��12��31�գ����Ա���Ϊ0x20301231
	
	CA_STU_DATA_ZONE_ATTRI DataZoneAttri[CA_MAX_ZONE_COUNT]; // ���ݷ�������

	U8 nUserPinFlag;			// �û�PIN��������־ �û�PIN���޸ı�־
	U8 nUserPinCount;			// �û�PIN�������֤���� �û�PIN��ʣ����֤����
	U8 nAdmPinFlag;				// ����ԱPIN��������־ ����ԱPIN���޸ı�־
	U8 nAdmPinCount;			// ����ԱPIN�������֤���� ����ԱPIN��ʣ����֤����
	
	U16 nPubKeyReadRight;			// ��Կ��ȡȨ��
	U8 nP1;
	U8 nP2;
	
} CA_APDU_SelectDomain_Resp;

typedef struct
{
	U8  aCardID[8];					// ��ID
	U8  aVersion[8];				// ����汾
	U16 nDomainTotal;				// ��ȫ������
	U16 nDomainUsed;	 			// ��ȫ����ʹ������
	U32 nDataSize;					// �ڴ�����
	U32 nDataSizeUsed;				// �ѷ����ڴ�
	U32 nDataBlockSize;				// �ڴ���С
	U8  aRandom[CA_LEN_RANDOM];                 	// �����
	U32 nMaxApduDataLen;				// ֧�ֵ�APDU������������󳤶�
	U32 nMaxApduRespLen;				// ֧�ֵ�APDU��Ӧ������󳤶�
	
} CA_APDU_SelectDomain_Resp2;

//-----------------------------------------------------------------------------
//
// ��հ�ȫ��ѡ��
//
//-----------------------------------------------------------------------------

// ָ��ṹ ��
// Ӧ��ṹ ��

//-----------------------------------------------------------------------------
//
// ��ȡ��ȫ��ID�б�
//
//-----------------------------------------------------------------------------

// ��ȫ��ID�б�����һ�����Ŀ����޷�����, ��Ҫ������ķ���
// P1 = xx, ���ذ�ȫ��ID�б��xx�����ģ�xx��0x01��ʼ�� P2 = 00 

// ָ��ṹ ��

// Ӧ��ṹ
/*typedef struct
{
	U8 aDMIDList[0];	//  ÿ16���ֽ�Ϊһ����ȫ��ID
} CA_APDU_EnumDomain_Resp;*/

//-----------------------------------------------------------------------------
//
// ������ȫ��
//
//-----------------------------------------------------------------------------

// ǰ�᣺ѡ��ȫ�򣬰�ȫ��Ψһ��ʶ��ȫ��

// ָ��ṹ

// aCipherData�����ģ�

typedef struct
{
	CA_STU_DOMAIN_INFO mDomainInfo;
	
	U8  aAdmPin[CA_LEN_KEY];
	U8  aUserPin[CA_LEN_KEY];	
} CA_APDU_CreateDomain_Ins_Plain;

typedef struct
{
	U8 aCipherData[104];			// ��������
	U8 aMac[CA_LEN_MAC];	
} CA_APDU_CreateDomain_Ins;

// Ӧ��ṹ
typedef struct
{
	U32 PublicExponent;			// ��Կָ��
	U32 nModulusLen;                  	// ģ��
	U8  aModulus[CA_MAX_RSA_MODULUS_LEN];	// ģ��
} CA_APDU_CreateDomain_Resp;

typedef struct
{
	U32 nP;					//ģ����λ��,256bit
	U8 aPublicQx[CA_MAX_SM2_MODULUS_LEN];
	U8 aPublicQy[CA_MAX_SM2_MODULUS_LEN];
} CA_APDU_CreateDomain_Resp2;

//-----------------------------------------------------------------------------
//
// ������֤
//
//-----------------------------------------------------------------------------

// ǰ��: ѡ��ȫ��

// ָ��ṹ
typedef struct
{
	U8 aMac[CA_LEN_MAC];                // ����У��mac
} CA_APDU_VerifyPin_Ins;

// Ӧ��ṹ ��

//-----------------------------------------------------------------------------
//
// �޸Ĵ�����Կ
//
//-----------------------------------------------------------------------------

// ָ��ṹ
typedef struct
{
	U8 aCipherData[24];                  // ����
	U8 aMac[CA_LEN_MAC];	
	
} CA_APDU_ChangeCreateKey_Ins;

// Ӧ��ṹ ��

//-----------------------------------------------------------------------------
//
// д����
//
//-----------------------------------------------------------------------------

// ǰ��: ѡ��ȫ����֤����(����Ҫ)

// ָ��ṹ

// P1 = 0, P2 = 0, Lc = ������ֽ��� 

typedef struct
{
	U16 nZoneIndex;				// ������������
	U16 nOffset;				// ����д���ƫ����
	U16 nDataLen;				// ��д�����ݵĳ���
	U8 aData[1];                      	// ��д������
} CA_APDU_WriteData_Ins;


// Ӧ��ṹ ��

//-----------------------------------------------------------------------------
//
// ������
//
//-----------------------------------------------------------------------------

// ǰ��: ѡ��ȫ����֤����(����Ҫ)

// P1 = ���ݿ��, P2 = ��ʼ��ȡ��λ��, Le = ��Ҫ��ȡ�����ݳ���(00��ʾ��ȡ�ӿ�ʼ��ȡλ������¼ĩβ������) 

// ָ��ṹ ��

// Ӧ��ṹ

typedef struct
{
	U16 nZoneIndex;				// ������������
	U16 nOffset;				// ���ݶ�ȡ��ƫ����
	U16 nReadLen;				// ������ȡ���ݵĳ��ȣ�����ֵΪ0����ʾ�����������ݣ�
} CA_APDU_ReadData_Ins;


//-----------------------------------------------------------------------------
//
// RSA����
//
//-----------------------------------------------------------------------------

// ǰ��: ѡ��ȫ����֤����(����Ҫ)

// ָ��ṹ

#define TYPE_ENCRYPT_PRIVATEKEY 	0x0001 		   //˽Կ����
#define TYPE_ENCRYPT_PUBLICKEY 		0x0002 		   //��Կ����

typedef struct
{
	U16 nPlainLen;                    //���ĳ���
	U16 nType;                        //��Կ����
	U8  aPlainData[4];                //����
} CA_APDU_RSA_Encrypt_Ins;

// Ӧ��ṹ
/*
typedef struct
{
	U8 aCipherData[0];                  //����
} CA_APDU_RSA_Encrypt_Resp;
*/

//-----------------------------------------------------------------------------
//
// RSA����
//
//-----------------------------------------------------------------------------

// ǰ��: ѡ��ȫ����֤����(����Ҫ)

// ָ��ṹ

#define TYPE_DECRYPT_PRIVATEKEY 	0x0001 		   //˽Կ����
#define TYPE_DECRYPT_PUBLICKEY 		0x0002 		   //��Կ����

typedef struct
{
	U16 nCipherLen;                      	//���ĳ���
	U16 nType;                        	//��Կ����
	U8  aCipherData[4];                  	//����
} CA_APDU_RSA_Decrypt_Ins;

// Ӧ��ṹ
/*
typedef struct
{
	U8 aPlainData[0];                   //����
} CA_APDU_RSA_Decrypt_Resp;
*/

//-----------------------------------------------------------------------------
//
// SM2��Կ����
//
//-----------------------------------------------------------------------------

#define MAX_LENGTH_PLAIN 	        128 	// ������󳤶�
#define MAX_LENGTH_SIGN_MESSAGE 	128     // ǩ����Ϣ��󳤶�

// ǰ��: ѡ��ȫ����֤����(����Ҫ)

// ָ��ṹ

typedef struct
{
	U32 nPlainLen;                    // ���ĳ���
	U8  aPlainData[4];                // ����
} CA_APDU_SM2_Encrypt_Ins;

// Ӧ��ṹ
/*
typedef struct
{
	U8 aCipherData[0];                  //����
} CA_APDU_SM2_Encrypt_Resp;
*/

//-----------------------------------------------------------------------------
//
// SM2˽Կ����
//
//-----------------------------------------------------------------------------

// ǰ��: ѡ��ȫ����֤����(����Ҫ)

// ָ��ṹ

typedef struct
{
	U32 nCipherLen;                      	// ���ĳ���
	U8  aCipherData[4];                  	// ����
} CA_APDU_SM2_Decrypt_Ins;

// Ӧ��ṹ
/*
typedef struct
{
	U8 aPlainData[0];                   //����
} CA_APDU_SM2_Decrypt_Resp;
*/

//-----------------------------------------------------------------------------
//
// SM2ǩ��
//
//-----------------------------------------------------------------------------

// ǰ��: ѡ��ȫ����֤����(����Ҫ)

// ָ��ṹ

typedef struct
{
	U32 nPlainLen;                      	// ���ĳ���
	U8  aData[4]; 				// ����. ʵ�ʳ�����nPlainLenָ��
} CA_APDU_SM2_Sign_Ins;

// Ӧ��ṹ

typedef struct
{
	U8 aSignatureR[CA_MAX_SM2_MODULUS_LEN];				// ����ǩ����ϢR
	U8 aSignatureS[CA_MAX_SM2_MODULUS_LEN];				// ����ǩ����ϢS
} CA_APDU_SM2_Sign_Resp;


//-----------------------------------------------------------------------------
//
// SM2��֤ǩ��
//
//-----------------------------------------------------------------------------

// ǰ��: ѡ��ȫ����֤����(����Ҫ)

// ָ��ṹ

typedef struct
{
	U8 aSignatureR[CA_MAX_SM2_MODULUS_LEN];			// ����ǩ����ϢR
	U8 aSignatureS[CA_MAX_SM2_MODULUS_LEN];			// ����ǩ����ϢS
	U32 nPlainLen;                      			// ���ĳ���
	U8  aData[4]; 						// ����. ʵ�ʳ�����nPlainLenָ��
} CA_APDU_SM2_Verify_Ins;

// Ӧ��ṹ ��

//-----------------------------------------------------------------------------
//
// ɾ����ȫ��
//
//-----------------------------------------------------------------------------

// ǰ�᣺ѡ��ȫ����֤����(����Ҫ)

// ָ��ṹ
// P1 = 1 �û�ɾ����P1 = 2 ������ɾ��, P2 = 0
typedef struct
{
	U8 aMac[CA_LEN_MAC];
} CA_APDU_DelDomain_Ins;

// Ӧ��ṹ ��

//-----------------------------------------------------------------------------
//
// �޸�PIN
//
//-----------------------------------------------------------------------------

// ǰ��: ѡ��ȫ����֤����(����Ҫ)
 
// P1 = 00 , P2 = 0x00 ����ԱPIN 0x01 �û�PIN

// ָ��ṹ

// aCipherPsw������:
// U8 aPin[16];	

typedef struct
{
	U8 aCipherPsw[24]; 	// ����������
	U8 aMac[CA_LEN_MAC];
} CA_APDU_ChangePin_Ins;

// Ӧ��ṹ ��

//-----------------------------------------------------------------------------
//
// �û����ð�ȫ��״̬
//
//-----------------------------------------------------------------------------

// ǰ��: ѡ��ȫ����֤����(����Ҫ)
 
// P1 = 00 , P2 = 00 

// ָ��ṹ

typedef struct
{
	U8 nStatus; 	
} CA_APDU_SetStatus_Ins;

// Ӧ��ṹ ��

//-----------------------------------------------------------------------------
//
// ��ձ�������
//
//-----------------------------------------------------------------------------

// ǰ��: ѡ��ȫ����֤����(����Ҫ)
 
// P1 = 01���û� , P2 = 02��������Կ 

// ָ��ṹ

typedef struct
{
	U8 aMac[CA_LEN_MAC];
} CA_APDU_ReloadPin_Ins;

// Ӧ��ṹ ��

//-----------------------------------------------------------------------------
//
// ȡ��Կ
//
//-----------------------------------------------------------------------------

// ǰ�᣺ѡ��ȫ����֤����(����Ҫ)

// ָ��ṹ ��

// Ӧ��ṹ

//ͬCA_APDU_CreateDomain_Resp

//-----------------------------------------------------------------------------
//
// ȡ˽Կ
//
//-----------------------------------------------------------------------------

// ǰ�᣺ѡ��ȫ����֤����(����Ҫ)

// ָ��ṹ ��

// Ӧ��ṹ

typedef struct
{
	U32 nPrivateExponentLength;			// ˽Կ����
	U8 aPrivateExponent[CA_MAX_RSA_MODULUS_LEN];	// ˽Կ
} CA_APDU_GetPrivateKey_Resp;

typedef struct
{
	U32 nP;						//ģ����λ��,256bit
	U8 aPrivate[32];
} CA_APDU_GetPrivateKey_Resp2;

//-----------------------------------------------------------------------------
//
// ���ɶԳƣ�AES��TDES����Կ
//
//-----------------------------------------------------------------------------

// P1 = ���ܹ�Կ��Կ���� P2 = �Գƣ�AES��TDES����Կ����

// ָ��ṹ
typedef struct
{
	U32 PublicExponent;			// ��Կָ��
	U32 nModulusLen;                  	// ģ��
	U8  aModulus[CA_MAX_RSA_MODULUS_LEN];	// ģ��
} CA_APDU_SYM_GenKey_Ins;

typedef struct
{
	U32 nP;					//ģ����λ��,256bit
	U8 aPublicQx[CA_MAX_SM2_MODULUS_LEN];
	U8 aPublicQy[CA_MAX_SM2_MODULUS_LEN];
} CA_APDU_SYM_GenKey_Ins1;

// Ӧ��ṹ

typedef struct
{
	U8 aCipher[4];	// �ÿ��ڹ�Կ���ܶԳƣ�AES��TDES����Կ�õ��ļ������ݣ��䳤
} CA_APDU_SYM_GenKey_Resp;

//-----------------------------------------------------------------------------
//
// �Գƣ�AES��TDES������
//
//-----------------------------------------------------------------------------

// ָ��ṹ
typedef struct
{
	U8  aPlain[4];	//  �������ݣ��䳤
} CA_APDU_SYM_Encrypt_Ins;

// Ӧ��ṹ

typedef struct
{
	U8 aCipher[4];	// �ÿ���AES��Կ�����������ĵõ������ģ��䳤
} CA_APDU_SYM_Encrypt_Desp;

//-----------------------------------------------------------------------------
//
// ˽Կ����,���ܺ������Ϊ�Գƣ�AES��TDES����Կ,���ڽ���
//
//-----------------------------------------------------------------------------

// ǰ��: ѡ��ȫ����֤����(����Ҫ)

// P1 = �Գƣ�AES��TDES����Կ����

// ָ��ṹ
typedef struct
{
	U8  aCipher[4];	//  �������ݣ��䳤
} CA_APDU_ASYM_Decrypt_Ins;

//-----------------------------------------------------------------------------
//
// �Գƣ�AES��TDES������
//
//-----------------------------------------------------------------------------

// ָ��ṹ
typedef struct
{
	U8  aCipher[4];	//  �������ݣ��䳤
} CA_APDU_SYM_Decrypt_Ins;

// Ӧ��ṹ

typedef struct
{
	U8 aPlain[4];	// ���ģ��䳤
} CA_APDU_SYM_Decrypt_Desp;


//-----------------------------------------------------------------------------
//
// �ⲿ����ǶԳƹ�Կ�������ڴ�
//
//-----------------------------------------------------------------------------

// P1 = ���ܹ�Կ��Կ���� P2 = 0

// ָ��ṹ
typedef struct
{
	U32 PublicExponent;			// ��Կָ��
	U32 nModulusLen;                  	// ģ��
	U8  aModulus[CA_MAX_RSA_MODULUS_LEN];	// ģ��
} CA_APDU_ASYM_Public_Import_Ins;

typedef struct
{
	U32 nP;					//ģ����λ��,256bit
	U8 aPublicQx[CA_MAX_SM2_MODULUS_LEN];
	U8 aPublicQy[CA_MAX_SM2_MODULUS_LEN];
} CA_APDU_ASYM_Public_Import_Ins1;

// Ӧ��ṹ

// ��

//-----------------------------------------------------------------------------
//
// �ⲿ����ǶԳƹ�Կ���м��ܲ���
//
//-----------------------------------------------------------------------------

// ָ��ṹ
typedef struct
{
    U8 aPlain[4];    // ���������ݣ��䳤 
} CA_APDU_ASYM_Public_Import_Encrypt_Ins;

// Ӧ��ṹ

typedef struct
{
	U8 aCipher[4];	// �ǶԳƹ�Կ�����γɵ�����
} CA_APDU_ASYM_Public_Import_Encrypt_Resp;

//-----------------------------------------------------------------------------
//
// �ڴ湤������
//
//-----------------------------------------------------------------------------

#define STATUS_DOMAIN_ADM_PIN_VERIFY_OK 0x88 	// ����ԱPINУ��ɹ�
#define STATUS_DOMAIN_USER_PIN_VERIFY_OK 0x98 	// �û�PINУ��ɹ�
#define STATUS_DOMAIN_PIN_VERIFY_NO 0x00 	// PINУ��δ�ɹ�
#define STATUS_DOMAIN_SELECT_NULL 0x00 		// δѡ��ȫ��	 
#define STATUS_DOMAIN_SELECT_ZERO_OK 0xAB 	// ��ȫ���ʶȫ��ʱѡ��ɹ�	 
#define STATUS_DOMAIN_SELECT_OK 0xCC		// ��ȫ���ʶ��Ϊȫ��ʱѡ��ɹ�
typedef struct
{
	U8 nDomainSelectStatus;	
	U8 nDomainIndex;	
	U8 nPinVerifyStatus;
	U8 nP4;		
	U8 aDMID[16];
	U8 aRandom[16];
} CA_RAM_WORK_PARAM_DOMAIN;

#define STATUS_SYM_KEY_GEN_OK 0xF6	// �Գƣ�AES��TDES����Կ�����ɹ�
#define STATUS_SYM_KEY_GEN_NOT 0x00	// �Գƣ�AES��TDES����Կδ����
typedef struct
{
	U8 aSymKey[16];
} CA_RAM_WORK_PARAM_SYM;

#define STATUS_ASYM_PUBLIC_KEY_IMPORT_NO 0xA9	// �ǶԳƹ�Կδ�����ڴ�
#define STATUS_ASYM_PUBLIC_KEY_IMPORT_OK 0xEF	// �ǶԳƹ�Կ�����ڴ�ɹ�
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

