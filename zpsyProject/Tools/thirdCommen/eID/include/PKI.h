//
//  TestHmac.h
//  IdspSDKPerformance
//
//  Created by Jusive on 16/5/14.
//  Copyright © 2016年 trimps. All rights reserved.
//
#import "BaseTestClass.h"

class  PKI : public BaseTestClass{
    
public:
        PKI(CCardReader *btd,unsigned char *pin):BaseTestClass(btd){
        this->uchUserPinValue = pin;
    };
    void execute();
    void executePositive();

private:
    void verifyPositive(HASH_DATA_FROM hdf);
    void verifyPositive2(HASH_DATA_FROM hdf);
    void verifyPositive(TEID_SIGN_ALG alg, HASH_DATA_FROM hdf);
    
    unsigned char *uchUserPinValue;
    char pchInData[129]={0};
    NSString *getSignAlgStr(TEID_SIGN_ALG alg);
    void initData();
};
