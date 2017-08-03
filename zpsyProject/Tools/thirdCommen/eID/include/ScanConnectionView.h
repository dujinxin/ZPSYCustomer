//
//  ScanConnectionViewController.h
//  eID-SDK
//
//  Created by Jusive on 16/5/11.
//  Copyright © 2016年 Jusive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ble.h"
#define CONFIRM_BUTTON_TEXT @"确定"
@interface ScanConnectionView : UIView<SunwardBleDelegate>
+(CBPeripheral *)SharedPeripheral;
@end
