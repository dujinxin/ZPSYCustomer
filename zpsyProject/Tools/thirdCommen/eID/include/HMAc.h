//
//  TestHmac.h
//  IdspSDKPerformance
//
//  Created by Jusive on 16/5/14.
//  Copyright © 2016年 trimps. All rights reserved.
//
#import "BaseTestClass.h"

#define MAX_CAPACITY 1024*1
#define MAX_DATA_LENGTH 1024

#define RANDOM(number) (rand()%number)

#define BLOCK_LENGTH 64

class  HMAc : public BaseTestClass{
    
public:
      HMAc(CCardReader *reader):BaseTestClass(reader){};
       void execute();
    
private:
    void executeHash(HASH_DATA_FROM hdfType);
    void executeHash(HASH_DATA_FROM hdfType, TEID_HASH_ALG thaAlg);
    void initData();
    
    unsigned char uchData_63[63]={0};
    unsigned long ulDataLen_63=63;
    
    unsigned char uchData_64[64]={0};
    unsigned long ulDataLen_64=64;
    unsigned long pinLen;
};
