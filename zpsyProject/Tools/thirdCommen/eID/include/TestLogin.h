//
//  TestLogin.h
//  IdspSDKSample
//
//  Created by zly on 15/7/10.
//  Copyright (c) 2015年 trimps. All rights reserved.
//

#import "BaseTestClass.h"

class TestLogin : public BaseTestClass{
public:
    TestLogin(CCardReader *reader, unsigned char *pin, unsigned long pinLength):BaseTestClass(reader){
        this->uchUserPinValue = pin;
        this->pinLen = pinLength;
    };
    void execute();
private:
    unsigned char *uchUserPinValue;
    unsigned long pinLen;
};
