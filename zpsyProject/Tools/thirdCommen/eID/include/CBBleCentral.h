//
//  CBBleCentral.h
//  CASIM
//
//  Created by Sunwardtel-Wangym on 13-5-7.
//  Copyright (c) 2013年 Sunwardtel. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ble.h"

@interface CBBleCentral : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>


@property (nonatomic, strong, nonnull) NSString *caSimBleServiceUUIDString;
@property (nonatomic, strong, nonnull) NSString *caSimBleCharacteristicUUIDString;
@property (nonatomic, assign) BOOL autoFindCaSimBle;

#pragma mark - Base methods

+(nonnull CBBleCentral *)shared;
//-(void)hardwareResponse:(eventHardwareBlock)block;
//-(void)apduResponse:(nullable eventApduResponseBlock)block;
//-(void)frameResponse:(nullable eventFrameResponseBlock)block;

//-(void)transmit:(Byte *)data forSendLen:(NSInteger)sendLen forCmdType:(CmdType)cmdType forCmdDevice:(CmdDevice)cmdDevice forFrameCmd:(Byte)frameCmd;
//-(void)logLevel:(KKLogLevel)level Info:(NSString *)format, ...;

-(int)transmitAdpuData:(nonnull NSData *)apduData CmdDevice:(CmdDevice)cmdDevice response:(nullable eventApduResponseBlock)block;

#pragma mark - Central Mode methods

-(void)startScan;
-(void)stopScan;
//-(void)resetScann;
//-(void)repeatScan;

//-(void)connect:(CBPeripheral *)peripheral;

-(void)connectPeripheral:(nonnull CBPeripheral *)peripheral options:(nullable NSDictionary<NSString *, id> *)options;
-(void)cancelPeripheralConnection:(nullable CBPeripheral *)peripheral;

#pragma mark - Peripheral Mode methods


#pragma mark - Base Property


#pragma mark - Central Mode Property

@property (strong, nonatomic, nullable) CBCentralManager  *centralManager;
@property (strong, nonatomic, nullable) CBPeripheral      *blePeripheral;
//@property (strong, nonatomic, nullable) NSMutableArray    *dicoveredPeripherals;
@property (strong, nonatomic, nullable) CBCharacteristic  *sendCharacteristic;
@property (strong, nonatomic, nullable) CBCharacteristic  *recvCharacteristic;

@property (weak, nonatomic) id<SunwardBleDelegate> delegate;

//@property(readonly)          NSUInteger         currentPeripheralState;
//@property(readwrite)          NSString          *staticString;
//@property(readwrite)          NSString          *bleDeviceID;

//@property(readonly)           BOOL              connectedFinish;
//@property(readwrite)          uint              rxCounter;

//@property(readonly)           NSUInteger        currentCentralManagerState;

@property(nonatomic)          BOOL              logEnabled;   // 是否启用日志

@property(nonatomic)          BOOL              isBusy;

//@property(nonatomic)          BOOL              isRFClose;∫


#pragma mark - Peripheral Mode Property


@end
