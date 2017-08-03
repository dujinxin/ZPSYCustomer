//
//  BaseTestClass.h
//  IdspSDKSample
//
//  Created by zly on 15/7/9.
//  Copyright (c) 2015年 trimps. All rights reserved.
//

#import "BlueToothDevice.h"
#import "eIDApi.h"
#import "DataUtil.h"
class BaseTestClass
{
public:
    BaseTestClass();
    BaseTestClass(CCardReader *reader);
    virtual ~BaseTestClass(void);
    virtual void execute()=0;
    unsigned long OpenDevice();
    unsigned long CloseDevice();
    
    NSMutableAttributedString* getTestResult();
    //    virtual void execute()=0;
    NSMutableAttributedString* getErrString(NSString *apiName, unsigned long errorCode);
    bool hex2string(const unsigned char *hex,const unsigned long hex_len,char *string,unsigned long *len_string);
    bool string2hex(const char *string,unsigned char *hex,unsigned long *len_hex);
    NSString* hex2NSString(const unsigned char *hex,const unsigned long hex_len);
    NSString* getSignAlgString(TEID_SIGN_ALG alg);
    NSString* getHashAlgString(TEID_HASH_ALG alg);
    
public:
    CCardReader *baseReader;
    NSMutableAttributedString* resultStr;
    eIDApi *api;
};

