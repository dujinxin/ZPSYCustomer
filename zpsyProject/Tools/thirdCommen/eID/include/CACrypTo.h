//
//  CrypTo.h
//  SimCert
//
//  Created by s on 13-6-28.
//  Copyright (c) 2013年 Xiaer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Catbee_Type.h"
#import "CACrypTo.h"
//#include "ClassProc_MD5.h"

//---------------------------------------------------------------------------
//
// enum KeySize { Bits128, Bits192, Bits256 };  // key size, in bits, for construtor
//
//---------------------------------------------------------------------------

#define Bits128	16  //√‹‘ø≥§∂»
#define Bits192	24
#define Bits256	32

//---------------------------------------------------------------------------

//class TCrypto
@interface NSCrypto : NSObject
{
	unsigned char nMac_Mode;
    
	int Nb;         // block size in 32-bit words.  Always 4 for AES.  (128 bits).
	int Nk;         // key size in 32-bit words.  4, 6, 8.  (128, 192, 256 bits).
	int Nr;         // number of rounds. 10, 12, 14.
    
    
    
    
	unsigned char State[4][4];  // State matrix
    
	unsigned char seedkey[32];     // the seed key. size will be 4 * keySize from ctor.
	//char* Sbox;   // Substitution box
	//char* iSbox;  // inverse Substitution box
	unsigned char w[16*15];      // key schedule array. (Nb*(Nr+1))*4
	//char* Rcon;   // Round constants.

}
//{
//public:

//    TCrypto(void);
//    ~TCrypto();

-(unsigned short int)PPPFCS16:(unsigned short) fcs cp:(unsigned char *)cp len:(int) len;
    
	//º”√‹Ω‚√‹
    
	enum
	{
		ENCRYPT	=	0,	//º”√‹
		DECRYPT			//Ω‚√‹
	};
    
	//DESÀ„∑®µƒƒ£ Ω
    
	enum
	{
		ECB		=	0,	//ECBƒ£ Ω
		CBC				//CBCƒ£ Ω
	};
    
	typedef bool    (*PSubKey)[16][48];
    
	//-----------------------------------------------------------------------
	//
	// ∫Ø  ˝ √˚ ≥∆:	RunDes
	// π¶ ƒ‹ √Ë  ˆ£∫	÷¥––DESÀ„∑®∂‘Œƒ±æº”Ω‚√‹
	// ≤Œ  ˝ Àµ √˜£∫	bType	:¿‡–Õ£∫º”√‹ENCRYPT£¨Ω‚√‹DECRYPT
	//			bMode	:ƒ£ Ω£∫ECB,CBC
	//			In		:¥˝º”√‹¥Æ÷∏’Î
	//			Out		:¥˝ ‰≥ˆ¥Æ÷∏’Î
	//			datalen	:¥˝º”√‹¥Æµƒ≥§∂»£¨Õ¨ ±Outµƒª∫≥Â«¯¥Û–°”¶¥Û”⁄ªÚ’ﬂµ»”⁄datalen
	//			Key		:√‹‘ø(ø…Œ™8Œª,16Œª,24Œª)÷ß≥÷3√‹‘ø
	//			keylen	:√‹‘ø≥§∂»£¨∂‡≥ˆ24Œª≤ø∑÷Ω´±ª◊‘∂Ø≤√ºı
	//
	// ∑µªÿ÷µ Àµ√˜£∫	bool	: «∑Òº”√‹≥…π¶
	// ◊˜       ’ﬂ:	◊ﬁµ¬«ø
	//
	// ∏¸ –¬ »’ ∆⁄£∫	2003.12.19
	//-----------------------------------------------------------------------
    
//	static bool RunDes(bool bType,bool bMode,char* In,char* Out,unsigned datalen,const char* Key,const unsigned char keylen);
+(bool)RunDes:(bool)bType Mode:(bool)bMode In:(char *)In Out:(char *)Out datalen:(unsigned)datalen Key:(const char *) Key keylen:(const unsigned char)keylen;
    
//protected:

	//º∆À„≤¢ÃÓ≥‰◊”√‹‘øµΩSubKey ˝æ›÷–
    
//	static void SetSubKey(PSubKey pSubKey, const char Key[8]);
+(void)SetSubKey:(PSubKey)PSubKey Key:(const char[8])Key;

	//DESµ•‘™‘ÀÀ„
    
//	static void DES(char Out[8], char In[8], const PSubKey pSubKey, bool Type);
+(void)DES:(char[8])Out In:(char[8])In SubKey:(const PSubKey)PSubKey Type:(bool)Type;

    
	//-----------------------------------------------------------------------
	//
	// œ¬√Ê¥˙¬Î «πÿ”⁄Kaesµƒ
	//
	//-----------------------------------------------------------------------
    
//public:

//	void Cipher(unsigned char *input, unsigned char *output, unsigned char *key, unsigned char keylen);  // encipher 16-bit input
-(void)Cipher:(unsigned char *)input output:(unsigned char *)output key:(unsigned char *)key keylen:(unsigned char)keylen;
//	void InvCipher(unsigned char *input, unsigned char *output, unsigned char *key, unsigned char keylen);  // decipher 16-bit input
-(void)InvCipher:(unsigned char *)input output:(unsigned char*)output key:(unsigned char*)key keylen:(unsigned char)keylen;

//private:


//	unsigned char nMac_Mode;
//    
//	int Nb;         // block size in 32-bit words.  Always 4 for AES.  (128 bits).
//	int Nk;         // key size in 32-bit words.  4, 6, 8.  (128, 192, 256 bits).
//	int Nr;         // number of rounds. 10, 12, 14.

//	void AesInitKey(unsigned char* keyBytes, int keySize);
-(void)AesInitKey:(unsigned char *)keyBytes keySize:(int)keySize;

//	void KeyExpansion(int keySize, unsigned char* keyBytes);
-(void)KeyExpansion:(int)keySize keyBytes:(unsigned char*)keyBytes;


//	unsigned char State[4][4];  // State matrix
//    
//	unsigned char key[32];     // the seed key. size will be 4 * keySize from ctor.
//	//char* Sbox;   // Substitution box
//	//char* iSbox;  // inverse Substitution box
//	unsigned char w[16*15];      // key schedule array. (Nb*(Nr+1))*4
//	//char* Rcon;   // Round constants.

//	void SetNbNkNr(int keyS);
//	void AddRoundKey(int round);
//	void SubBytes();
//	void InvSubBytes();
//	void ShiftRows();
//	void InvShiftRows();
//	void MixColumns();
//	void InvMixColumns();
-(void)SetNbNkNr:(int)keyS;
-(void)AddRoundKey:(int)round;
-(void)SubBytes;
-(void)InvSubBytes;
-(void)ShiftRows;
-(void)MixColumns;
-(void)InvMixColumns;


//	unsigned char gfmultby01(unsigned char b);
//	unsigned char gfmultby02(unsigned char b);
//	unsigned char gfmultby03(unsigned char b);
//	unsigned char gfmultby09(unsigned char b);
//	unsigned char gfmultby0b(unsigned char b);
//	unsigned char gfmultby0d(unsigned char b);
//	unsigned char gfmultby0e(unsigned char b);
-(unsigned char)gfmultby01:(unsigned char)b;
-(unsigned char)gfmultby02:(unsigned char)b;
-(unsigned char)gfmultby03:(unsigned char)b;
-(unsigned char)gfmultby09:(unsigned char)b;
-(unsigned char)gfmultby0b:(unsigned char)b;
-(unsigned char)gfmultby0d:(unsigned char)b;
-(unsigned char)gfmultby0e:(unsigned char)b;


//	void SubWord(unsigned char * word,unsigned char* result);
//	void RotWord(unsigned char * word,unsigned char* result);
-(void)SubWord:(unsigned char*)word result:(unsigned char*)result;
-(void)RotWord:(unsigned char*)word result:(unsigned char*)result;

//	void Dump();
//	unsigned char * DumpKey();
//	unsigned char * DumpTwoByTwo(unsigned char * a);
-(void)Dump;
-(unsigned char*)DumpKey;
-(unsigned char*)DumpTwoByTwo:(unsigned char*)a;


//public: // ¿©’π≤ø∑÷

//	void Des_nEncode(void *in,void *out,void *key,int len);
//	void Des_nDecode(void *in,void *out,void *key,int len);
-(void)Des_nEncode:(void*)in out:(void*)out key:(void*)key len:(int)len;
-(void)Des_nDecode:(void*)in out:(void*)out key:(void*)key len:(int)len;


//	void Set_Key16(unsigned char *Key,unsigned char *InputStr);
-(void)Set_Key16:(unsigned char*)key InputStr:(unsigned char*)InputStr;

//	void Get_RandomKey(void *Key);
-(void)Get_RandomKey:(void *)key;

    
//	void  Des08E(U8* Dst8,U8* Plain8,U8* Key8);
//	void  Des08E_T(U8* Dst8,U8* Plain8,U8* Key16);
-(void)Des08E:(U8*)Dst8 Plain8:(U8*)Plain8 Key8:(U8*)Key8;
-(void)Des08E_T:(U8*)Dst8 Plain8:(U8*)Plain8 Key8:(U8*)Key16;

//	void  Des16E_T(U8* Dst16,U8* Plain16,U8* Key16);
//	void  Des16D_T(U8* Dst16,U8* Plain16,U8* Key16);
-(void)Des16E_T:(U8*)Dst16 Plain16:(U8*)Plain16 Key16:(U8*)Key16;
//-(void)Des16D_T:(U8*)Dst16 Plain16:(U8*)Plain16 Key16:(U8*)Key16;


//	void  Set_MacMode(unsigned char nMode);
//	void  GetMacA(U8* pRandom,U8* pData,U32 nLen,U8* pKey,U8* pMac,U8 mLen);
//	void  GetMacB(U8* pRandom,U8* pData,U32 nLen,U8* pKey,U8* pMac,U8 mLen);
-(void)Set_MacMode:(unsigned char)nMode;
-(void)GetMacA:(U8*)pRandom Data:(U8*)pData Len:(U32)nLen Key:(U8*)pKey Mac:(U8*)pMac Len:(U8)mLen;
-(void)GetMacB:(U8*)pRandom Data:(U8*)pData Len:(U32)nLen Key:(U8*)pKey Mac:(U8*)pMac Len:(U8)mLen;


//	void  String2Hex(unsigned char *pDest, unsigned char *pSrc, unsigned short nLen);
//	void  Hex2String(unsigned char *pDest, unsigned char *pSrc, unsigned short nLen);
//  void  Hex2Data(AnsiString aStr,unsigned char *pData,int nLen);
-(void)String2Hex:(unsigned char*)pDest Src:(unsigned char*)pSrc Len:(unsigned short)nLen;
-(void)Hex2String:(unsigned char*)pDest Src:(unsigned char*)pSrc Len:(unsigned short)nLen;


//	void  Aes16E(void *in,void *out,void *key);
//	void  Aes16D(void *in,void *out,void *key);
//	int  Aes_Encode(void *in,void *out,int len,void *key);
//	void  Aes_Decode(void *in,void *out,int len,void *key);
-(void)Aes16E:(void*)in out:(void*)out key:(void*)key;
-(void)Aes16D:(void*)in out:(void*)out key:(void*)key;
-(int)Aes_Encode:(void*)in out:(void*)out len:(int)len key:(void*)key;
-(void)Aes_Decode:(void*)in out:(void*)out len:(int)len key:(void*)key;

//};

//---------------------------------------------------------------------------

//extern TCrypto *gpCrypto;

//---------------------------------------------------------------------------


//#endif /* defined(__SimCert__CrypTo__) */
@end
