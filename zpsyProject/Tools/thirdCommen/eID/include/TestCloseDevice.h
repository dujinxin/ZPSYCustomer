//
//  TestCloseDevice.h
//  IdspSDKSample
//
//  Created by zly on 15/8/4.
//  Copyright (c) 2015年 trimps. All rights reserved.
//

#import "BaseTestClass.h"

class TestCloseDevice : public BaseTestClass{
public:
    TestCloseDevice(CCardReader *reader):BaseTestClass(reader){};
    void execute();
};
