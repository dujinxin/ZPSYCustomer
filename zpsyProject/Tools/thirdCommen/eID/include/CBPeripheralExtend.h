//
//  CBPeripheralExtend.h
//  CaSimBle2Demo
//
//  Created by s on 16/4/5.
//  Copyright © 2016年 sunward. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

@interface CBPeripheral (Text)

@property (nonatomic, readonly) NSString *stateText;
@property (nonatomic, readonly) NSString *uuids;
@property (nonatomic, readonly) CBCharacteristic *bleCharacteristic;

@end
