//
//  CaSimCA.h
//  CaSimCA
//
//  Created by s on 14-4-11.
//  Copyright (c) 2014年 sunward. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "ble.h"

@class CaSimBle;

@interface CaSimCA2 : NSObject

@property (nonatomic, strong) CaSimBle *caSimBle;


+(CaSimCA2*)shared;

//-(void)CAInit:(CaSimBle*)ble;

//#pragma mark - CASIM CA methods Extend
//
//-(int)_SC_EncryptDataB:(unsigned char *)pbySrc
//                SrcLen:(unsigned char)bySrcLen
//                   Dst:(unsigned char *)pbyDst
//                DstLen:(unsigned char *)byDstLen
//                   Key:(unsigned char *)pbyKey;

#pragma mark - CASIM CA methods

//选择应用
-(int)CaUiccSelectAppWithResponse:(eventApduResponseBlock)block;

//1.1选择安全域
-(int)CaUiccSelectUUID:(const Byte [])pDMID Response:(eventApduResponseBlock)block;

//1.2读取安全域标识列表
-(int)CaUiccReadUUIDs:(Byte)index
                  len:(Byte)len
             Response:(eventApduResponseBlock)block;

//1.3发卡方创建安全域
-(int)CaUiccCreateUUIDWithCreateKeyIndex:(Byte)CreateKeyIndex
                                  Random:(const Byte[])pRandom
                                    DMID:(const Byte[])pDMID
                                    Name:(const Byte[])pName
                                 keyType:(Byte) KeyType
                                  Status:(Byte) Status
                                 UserDel:(Byte) UserDel
                               PinVerify:(Byte) PinVerify
                               LimitDate:(const Byte[])pLimitDate
                          DataZone1Space:(const Byte[])pDataZone1Space
                     DataZone1WriteRight:(const Byte[])pDataZone1WriteRight
                      DataZone1ReadRight:(const Byte[])pDataZone1ReadRight
                          DataZone2Space:(const Byte[])pDataZone2Space
                     DataZone2WriteRight:(const Byte[])pDataZone2WriteRight
                      DataZone2ReadRight:(const Byte[])pDataZone2ReadRight
                             UserPinFlag:(Byte)UserPinFlag
                            UserPinCount:(Byte)UserPinCount
                            AdminPinFlag:(Byte)AdminPinFlag
                           AdminPinCount:(Byte)AdminPinCount
                         PubKeyReadRight:(const Byte[])PubKeyReadRight
                                 UserPin:(const Byte[])pUserPin
                                  AdmPin:(const Byte[])pAdmPin
                               CreateKey:(const Byte[])pCreateKey
                                Response:(eventApduResponseBlock)block;

//1.4发卡方写入数据,pData数据长度最大为超过2041，超过请分多次发送
-(int)CaUiccWriteDataWithZoneIndex:(const Byte[]) pZoneIndex
                                   Offset:(const Byte[]) pOffset
                                     Data:(const Byte[]) pData
                                  DataLen:(const Byte[]) pDataLen
                                 Response:(eventApduResponseBlock)block;

//1.5 读取数据
-(int)CaUiccReadDataWithZoneIndex:(const Byte[]) pZoneIndex
                                  Offset:(const Byte[]) pOffset
                                 DataLen:(const Byte[]) pDataLen
                                Response:(eventApduResponseBlock)block;

//1.6 验证密码

-(int)CaUiccVerifyWithRandom:(const Byte[])pRandom
                  VerifyType:(Byte)verifyType
                   VerifyKey:(const Byte[])pVerifyKey
                    Response:(eventApduResponseBlock)block;

//1.7 RSA公私钥加密
-(int)CaUiccRsaEncryptWithCryptType:(Byte)cryptType  //00 签名密钥 01 加密密钥
                            KeyType:(const Byte[])KeyType //0001 私钥 0002 公钥
                        PlainData:(const Byte[])pPlainData
                         PlainLen:(const Byte[])PlainLen
                         Response:(eventApduResponseBlock)block;

//1.8 RSA公私钥解密
-(int)CaUiccRsaDecrypWithCryptType:(Byte)cryptType  //00 签名密钥 01 加密密钥
                           KeyType:(const Byte[])KeyType
                         CiperData:(const Byte[])pCipherData
                          CiperLen:(const Byte[])CipherLen
                          Response:(eventApduResponseBlock)block;
//1.9 修改创建密钥
-(int)CaUiccChangeCreateKeyWithIndex:(Byte)index
                        NewCreateKey:(const Byte[])pNewCreateKey
                        OldCreateKey:(const Byte[])pOldCreateKey
                              Random:(const Byte[])pRandom
                            Response:(eventApduResponseBlock)block;

//1.10 解锁用户密码
-(int)CaUiccUnblockPinWithNewUserPin:(const Byte[])pNewUserPin
                           ManageKey:(const Byte[])pManageKey
                              Random:(const Byte[])pRandom
                            Response:(eventApduResponseBlock)block;

//1.11.1 修改管理子密钥
-(int)CaUiccChangeMrgKeyWithRandom:(const Byte[])pRandom
                      OldManageKey:(const Byte[])pOldManageKey
                      NewManageKey:(const Byte[])pNewManageKey
                          Response:(eventApduResponseBlock)block;

//1.11.2 修改用户密码
-(int)CaUiccChangeUserPinWithRandom:(const Byte[])pRandom
                         OldUserPin:(const Byte[])pOldUserPin
                         NewUserPin:(const Byte[])pNewUserPin
                           Response:(eventApduResponseBlock)block;

//1.12 用户设置安全域状态
-(int)CaUiccSetupDomainStatus:(Byte)Status
                     Response:(eventApduResponseBlock)block;

//1.13 删除安全域
-(int)CaUiccDeleteUUIDWithRandom:(const Byte[])pRandom
                         DelType:(Byte) DelType
                          DelKey:(const Byte[])pDelKey
                        Response:(eventApduResponseBlock)block;

//1.14 清空安全域选择
-(int)CaUiccUnselectUUID:(eventApduResponseBlock)block;

//1.15 取公钥
-(int)CaUiccGetPublickKey:(Byte)len
                CryptType:(Byte)cryptType
                 Response:(eventApduResponseBlock)block;

//1.16 SM2公钥加密
-(int)CaUiccSM2Encrypt:(const Byte[])pInData
               DataLen:(const Byte[]) DataLen
             CryptType:(Byte)cryptType
              Response:(eventApduResponseBlock)block;

//1.17 SM2私钥解密
-(int)CaUiccSM2Decrypt:(const Byte[])pInData
               DataLen:(const Byte[]) DataLen
             CryptType:(Byte)cryptType
              Response:(eventApduResponseBlock)block;

//1.18 SM2私钥签名

-(int)CaUiccSM2SignWithData:(const Byte[])pData
                    DataLen:(const Byte[])DataLen
                  CryptType:(Byte)cryptType
                   Response:(eventApduResponseBlock)block;


//1.19 SM2公钥验证签名

-(int)CaUiccSM2VerifyWithCryptType:(Byte)cryptType
                        SignatureR:(const Byte[])pSignatureR
                        SignatureS:(const Byte[])pSignatureS
                        ModulusLen:(Byte)modulusLen
                      PlainDataLen:(const Byte[])PlainDataLen
                         PlainData:(const Byte[])pPlainData
                          Response:(eventApduResponseBlock)block;

//1.20 生成对称密钥
-(int)CaUiccGenerateSymKeyWithAsymKeyType:(Byte)asynKeyType
                               SymKeytype:(Byte)symKeytype
                            PubickKeyData:(const Byte[])pPukkeydata
                         PublikKeyDataLen:(const Byte[])PublikKeyDataLen
                                 Response:(eventApduResponseBlock)block;

//1.21 对称密钥加密数据
-(int)CaUiccSymKeyEncrypt:(const Byte[])pPlain
                      DataLen:(const Byte[])DataLen
                     Response:(eventApduResponseBlock)block;

//1.22 私钥解密对称密钥
-(int)CaUiccDecodeSymKeyWithSymKeyType:(Byte)symKeyType
                          AsymKeyIndex:(Byte)asymKeyIndex
                                Cipher:(const Byte[])pCipher
                             CipherLen:(const Byte[])CipherLen
                              Response:(eventApduResponseBlock)block;

//1.23 对称密钥解密
-(int)CaUiccSymKeyDecrypt:(const Byte[])pCipher
                CipherLen:(const Byte[])CipherLen
                 Response:(eventApduResponseBlock)block;

//1.24 取随机数
-(int)CaUiccGetRandom:(Byte)Length
             Response:(eventApduResponseBlock)block;

//1.25 导入公钥
-(int)CaUiccImportPublickKey:(Byte)publicKeyType
                        Data:(const Byte[])pPublickKey
                     DataLen:(const Byte[])dataLen
                    Response:(eventApduResponseBlock)block;



//1.26 导入的公钥加密
-(int)CaUiccImportedPublickKeyEncrypt:(const Byte[])pPlain
                             PlainLen:(const Byte[])PlainLen
                             Response:(eventApduResponseBlock)block;

//1.27 选择安全域2
-(int)CaUiccSelectUUID2:(const Byte[])pDMID
                UserPin:(const Byte[])pUserPin
           AsymKeyIndex:(Byte)asymKeyIndex
               Response:(eventApduResponseBlock)block;

//1.28 RSA私钥加解密
-(int)CaUiccRsaPrivateKeyDecrypHashAndEncryWithAsymKeyIndex:(Byte)asymKeyIndex
                                                DecryptType:(const Byte[])decryptType
                                                  CiperData:(const Byte[])pCipherData
                                                   CiperLen:(const Byte[])pCipherLen
                                                   Response:(eventApduResponseBlock)block;

//1.29 导入RSA加密密钥对
-(int)CaUiccImportRSAEncryptKeyPair:(const Byte[])keyPairCipher
                   KeyPairCipherLen:(const Byte[])keyPairCipherLen  //注意格式，如624要传入0x30,0x36,0x32,0x34
                       SymKeyCipher:(const Byte[])symKeyCipher
                    SymKeyCipherLen:(Byte)symKeyCipherLen
                           Response:(eventApduResponseBlock)block;

//1.30 分包发送 通道中实现

//1.31 清空安全域
-(int)CaUIccClearDomainWithResetSignKey:(Byte)resetSignKey
                               Response:(eventApduResponseBlock)block;

//1.32 生成签名密钥对
-(int)CaUiccGenerateSignKeyPairWithResponse:(eventApduResponseBlock)block;

//CA 2.0 蓝牙多包的发送接口
//-(int)Ca_BLETransmitMutableApduEx:(BLE_MutableAPDU*)mutableApdu forCmdDevice:(CmdDevice)device forRespnose:(eventMutableApduResponseBlock)block ;

@end












