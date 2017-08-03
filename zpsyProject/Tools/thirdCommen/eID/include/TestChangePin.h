//
//  TestChangePin.h
//  IdspSDKSample
//
//  Created by zly on 15/7/14.
//  Copyright (c) 2015年 trimps. All rights reserved.
//

#import "BaseTestClass.h"

class TestChangePin : public BaseTestClass{
public:
    TestChangePin(CCardReader *reader, unsigned char *oldPin, unsigned long oldLen,
                  unsigned char *newPin, unsigned long newLen):BaseTestClass(reader){
        this->oldPinValue = oldPin;
        this->newPinValue = newPin;
        this->oldLen = oldLen;
        this->newLen = newLen;
    };
    void execute();
private:
    unsigned char *oldPinValue;
    unsigned long oldLen;
    unsigned char *newPinValue;
    unsigned long newLen;
};
