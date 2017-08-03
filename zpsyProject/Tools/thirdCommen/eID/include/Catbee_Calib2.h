
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
// #define MODE_SAVE_LSB
#define CA_APDU_CLA     			0xE8    // APDUָ�����

#define CA_APDU_INS_SelectDomain		0x70    // ѡ��ȫ��
#define CA_APDU_INS_EnumDomain 			0x72    // ��ȡ��ȫ���б�
#define CA_APDU_INS_CreateDomain    		0x74	// ������ȫ��
#define CA_APDU_INS_WriteData    		0x76    // д������
#define CA_APDU_INS_ReadData    		0x78   	// ��ȡ����
#define CA_APDU_INS_VerifyPin 			0x7A    // ��֤����
#define CA_APDU_INS_RSA_Encrypt	   		0x7C    // RSA��˽Կ����
#define CA_APDU_INS_RSA_Decrypt	    		0x7E    // RSA��˽Կ����
#define CA_APDU_INS_SetMerchantKey 		0x80    // �������޸Ĺ�����Կ
#define CA_APDU_INS_ClearPassword		0x82    // ��ձ�������
#define CA_APDU_INS_UpdatePassword    		0x84    // �޸�����
#define CA_APDU_INS_SetStatus 			0x86    // ���ð�ȫ��״̬
#define CA_APDU_INS_DelDomain    		0x88    // ɾ����ȫ��
#define CA_APDU_INS_ClearSelect			0x8A    // ��հ�ȫ��ѡ��
#define CA_APDU_INS_InitData			0x8B    // ��ʼ����������
#define CA_APDU_INS_GetPubKey			0x8C    // ��ȡ��Կ
#define CA_APDU_INS_Test			0x8d    // ����ָ��
#define CA_APDU_INS_GetPrivateKey		0x8f    // ��ȡ˽Կ
#define CA_APDU_INS_SM2_Encrypt			0x71    // SM2��Կ����
#define CA_APDU_INS_SM2_Decrypt			0x73    // SM2˽Կ����
#define CA_APDU_INS_SM2_Sign			0x75    // SM2˽Կǩ��
#define CA_APDU_INS_SM2_Verify			0x77    // SM2��Կ��֤ǩ��
#define CA_APDU_INS_SYM_GenKey			0x79	// ���ɶԳƣ�AES��TDES����Կ
#define CA_APDU_INS_SYM_Encrypt			0x81	// �Գƣ�AES��TDES������
#define CA_APDU_INS_ASYM_Decrypt		0x83	// ˽Կ����,���ܺ���������ڶԳƣ�AES��TDES������
#define CA_APDU_INS_SYM_Decrypt			0x85	// �Գƣ�AES��TDES������
#define CA_APDU_INS_ASYM_Public_Import		0x87	// ���빫Կ
#define CA_APDU_INS_ASYM_Public_Import_Encrypt	0x89	// ���빫Կ����
#define CA_APDU_INS_SelectDomain2		0x7B	// ѡ��ȫ��2�����ع�Կ
#define CA_APDU_INS_RSA_PrivateCryption		0x8E	// RSA˽Կ�ӽ���
//#define CA_APDU_INS_SelectDomain_Inner		0x8F	// �ڲ�ѡ��ȫ��
//#define CA_APDU_INS_RSA_Test			0x8F	// RSA����

#define CA_MAX_DOMAIN_COUNT    			32   	// �����

#define CA_MAX_DATA_BLOCK_LEN 			256  	// һ�����ݿ�ĳ���
#define CA_MAX_DATA_BLOCK_COUNT 		160  	// ���ݿ������
#define CA_MAX_DOMAIN_DATA_BLOCK_COUNT 		32 	// ÿ��������ݿ������

#define CA_TYPE_ARITHM_3DES			0x01	// Triple DES
#define CA_TYPE_ARITHM_AES			0x02	// AES

#define CA_TYPE_KEY_MAC_CREATE			0x01	// ������Կ
#define CA_TYPE_KEY_MAC_MANAGE			0x02	// ������Կ
#define CA_TYPE_KEY_MAC_PASSWORD			0x03	// ������Կ

#define CA_KEY_ID_ENCRYPT				0x01	// ������Կ
#define CA_KEY_ID_MAC				0x02	// MAC��Կ
#define CA_KEY_ID_CREATE				0x03	// ������Կ

#define CA_MAX_SM2_MODULUS_BIT_LEN 		256	// SM2ģλ��
#define CA_MAX_SM2_MODULUS_LEN 			32	// SM2ģ��
#define CA_MAX_RSA_MODULUS_LEN 			128	// ģ��
#define CA_MAX_MAIN_TDESKEY_COUNT 			0x00

#define CA_MAX_ASYM_KEY_SIZE 			584

#define CA_LEN_DMID				16
#define CA_LEN_NAME				16
#define CA_LEN_PASSWORD				8
#define CA_LEN_LIMITDATE			4
#define CA_LEN_RANDOM				16
#define CA_LEN_MAC				4
#define CA_LEN_MANAGEKEY			16
#define CA_LEN_MD5				16

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
// Key�ļ���¼��ʽ
// 
//-----------------------------------------------------------------------------

typedef struct
{
	U8 nKeyID;			// ��Կ����
	U8 nKeyIndex;		    	// ��Կ����
	U8 nKeyVer;			// ��Կ�汾��
	U8 nKeyArithmetic;	    	// �㷨��ʶ

	U8 nErrorCount;			// ���������
					// ����������ĸ߰��ֽ�Ϊ��ʼ���������ָ����Կ���������������������
					// ����������ĵͰ��ֽ�Ϊ��ǰ���������ָ����ǰ��������Ĵ�������������������Ĵ���������ʼ���������ֵ����Կ�Զ�������

	U8 nKeyLen;         		// KEY�ĳ���
	U8 nR1;                 	// ����
	U8 nR2;         	    	// ����

	U8 aKey[16];        		// ��Կ����,�����PIN,��ռ��6Bytes

} CA_STU_Des_Key;

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

typedef struct
{
	U8  aDMID[16];                        	// Ψһ��ʶ��
	U8  aName[16];                        	// ���� UCS2����
	U8  nType;                            	// ����
	U8  nStatus;				// ״̬
	U8  nUserDel;                     	// �Ƿ������û�ɾ����ȫ��
	U8  nPinVerify;				// 0:����֤���� 1����֤����
	U8  aLimitDate[4];                     	// ��Ч���ޣ�cn���룬��2030��12��31�գ����Ա���Ϊ0x20301231
	U32 nDataSpace;				// ���������ݿռ��ֽ���
	
	U8  aManageKey[16]; 			// ������Կ
	U8  aPassword[16];			// ǰ��8�ֽ�Ϊ8λ���ֻ�����ĸ��ɣ�����8�ֽ�Ϊǰ��8�ֽ�ȡ����������������֤ʱPIN��Ϊ8���ַ�0

	union
	{
		RSA_PARA mRSA;
		SM2_PARA mSM2;

    	} Key;

} CA_STU_Domain;

//-----------------------------------------------------------------------------
//
// ����CA���ݽṹ
//
//-----------------------------------------------------------------------------
#define CA_MAIN_FLAG_INIT_OK 0x69
#define CA_MAIN_FLAG_INIT_NO 0x00
typedef struct
{
	U8 aVersion[4];
	U8 aCreateKey[16];						// ������Կ
	U8 nInitFlag;			                // ��ʼ�������������
	U8 aReserved[3];			            // ����

	union
	{
		RSA_PARA mRSA;
		SM2_PARA mSM2;

    	} TempKey;					// ���ڴ洢�ⲿ������Կ��

	CA_STU_Domain  mDomain[CA_MAX_DOMAIN_COUNT];  			// ��������
//	CA_STU_Des_Key mTDesKey[MAX_MAIN_TDESKEY_COUNT]; 		// TDES��Կ
	CA_STU_DATA_BLOCK_HEAD mDataBlockHead[CA_MAX_DATA_BLOCK_COUNT];	// ���ݿ�ͷ
	U8 aDataBlock[CA_MAX_DATA_BLOCK_COUNT][CA_MAX_DATA_BLOCK_LEN];	// ���ݿ�	
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
	U8 aDMID[16];		// ��ȫ��Ψһ��ʶ����ƥ��İ�ȫ��ʱ����CA_APDU_SelectDomain_Resp�����򷵻�CA_APDU_SelectDomain_Resp2
} CA_APDU_SelectDomain_Ins;

// Ӧ��ṹ
typedef struct
{
	U8  aCardID[8];			// ��ID
	U8  aVersion[8];		// �汾��, 8λ�ַ�
	U16 nDomainTotal;		// ֧�ְ�ȫ������
	U16 nDomainCount;	 	// ��ǰ��ȫ������
	U32 nDataSize;			// �ڴ�����
	U32 nDataSizeUsed;		// �ѷ����ڴ�
	U32 nDataBlockSize;		// �ڴ���С
	U8  aRandom[16];		// �������
	U8  aName[16];                        	
	U8  nType;                            	
	U8  nStatus;				
	U8  nUserDel;                     	
	U8  nPinVerify;	
	U8  aLimitDate[4];   
	U32 nDataSpace;			// ���ݿռ�����
} CA_APDU_SelectDomain_Resp;

// Ӧ��ṹ2
typedef struct
{
	U8  aCardID[8];			// ��ID
	U8  aVersion[8];		// �汾��, 8λ�ַ�
	U16 nDomainTotal;		// ��ȫ������
	U16 nDomainUsed;	 	// ��ȫ����ʹ������
	U32 nDataSize;			// �ڴ�����
	U32 nDataSizeUsed;		// �ѷ����ڴ�
	U32 nDataBlockSize;		// ��ռ��С
	U8  aRandom[16];		// �������
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
typedef struct
{
	U8 aDMIDList[0];	//  ÿ16���ֽ�Ϊһ����ȫ��ID
} CA_APDU_EnumDomain_Resp;

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
	U8  aDMID[16];                        	
	U8  aName[16];                        	
	U8  nType;                            	
	U8  nStatus;				
	U8  nUserDel;                     	
	U8  nPinVerify;				
	U8  aLimitDate[4];                     	
	U32 nDataSpace;				
	U8  aManageKey[16];			
	U8  aPassword[8];			
} CA_APDU_CreateDomain_Ins_Plain;

typedef struct
{
	U8 aCipherData[72];			// ��������
	U8 aMac[4];	
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
	U8 aMac[4];                // ����У��mac
} CA_APDU_VerifyPin_Ins;

// Ӧ��ṹ ��

//-----------------------------------------------------------------------------
//
// ���ð�ȫ���������Կ
//
//-----------------------------------------------------------------------------

// ǰ��: ѡ��ȫ����֤����(����Ҫ)

// ָ��ṹ
typedef struct
{
	U8 aCipherData[24];                  // ����
	U8 aMac[4];	
	
} CA_APDU_SetTDesKey_Ins;

// Ӧ��ṹ ��

//-----------------------------------------------------------------------------
//
// д����
//
//-----------------------------------------------------------------------------

// ǰ��: ѡ��ȫ����֤����(����Ҫ)

// ָ��ṹ

// P1 = ���ݿ��, P2 = ����д�뿪ʼλ��, Le = �����ֽ��� 
/*
typedef struct
{
	U8 aData[0];                      	// ����
	U8 aMac[4];				// ���ݼ�����
} CA_APDU_WriteData_Ins;
*/

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
/*
typedef struct
{
	U8 aData[0];        	// ����������
} CA_APDU_ReadData_Resp;
*/

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
#define MAX_LENGTH_IDA 	            128     // ǩ�����������Ϣ��󳤶�

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
	U32 nIDLen;				// ǩ���������Ϣ�ĳ���
	U32 nPlainLen;                      	// ���ĳ���
	U8  aData[4]; 				// ǩ�����������Ϣ������. ʵ�ʳ��ȷֱ���nIDLen��nPlainLenָ��
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
	U32 nIDLen;				// ǩ���������Ϣ�ĳ���
	U32 nPlainLen;                      	// ���ĳ���
	U8  aData[4]; 				// ǩ�����������Ϣ������. ʵ�ʳ��ȷֱ���nIDLen��nPlainLenָ��
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
	U8 aMac[4];
} CA_APDU_DelDomain_Ins;

// Ӧ��ṹ ��

//-----------------------------------------------------------------------------
//
// �û���������
//
//-----------------------------------------------------------------------------

// ǰ��: ѡ��ȫ����֤����(����Ҫ)
 
// P1 = 00 , P2 = 00 

// ָ��ṹ

// aCipherPsw������:
// U8 aPassword[8];		// ֵΪȫ���ʾ����Ҫ������֤

typedef struct
{
	U8 aCipherPsw[16]; 	// ����������
	U8 aMac[4];
} CA_APDU_UpdatePassword_Ins;

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
	U8 aMac[4];
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

#define STATUS_DOMAIN_PIN_VERIFY_OK 0x88 	// ��������У��ɹ�
#define STATUS_DOMAIN_SELECT_NULL 0x00 // δѡ��ȫ��	 
#define STATUS_DOMAIN_SELECT_ZERO_OK 0xAB // ��ȫ���ʶȫ��ʱѡ��ɹ�	 
#define STATUS_DOMAIN_SELECT_OK 0xCC	// ��ȫ���ʶ��Ϊȫ��ʱѡ��ɹ�
typedef struct
{
	U8 nDomainSelectStatus;	
	U8 nDomainIndex;	
	U8 nPinVerifyStatus;		
	U8 nP4;
	U8 aDMID[16];
	U8 aRandom[16];
} CA_RAM_WORK_PARAM_DOMAIN;

#define STATUS_SYM_KEY_ENCRYPT_GEN_OK 0xF6	// �Գƣ�AES��TDES����Կ�����ɹ�
#define STATUS_SYM_KEY_DECRYPT_GEN_OK 0xF8	// �Գƣ�AES��TDES����Կ�����ɹ�
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
	U8 nP3;
	U8 nP4;
 	union
 	{
 		CA_RAM_WORK_PARAM_SYM mSym;
 		CA_RAM_WORK_PARAM_ASYM_PUBLIC mAsymPublic;	
 	} mKey;
 	
} CA_RAM_WORK_PARAM_KEY;

//-----------------------------------------------------------------------------

#endif

