//
//  PwdView.h
//  eID-SDK
//
//  Created by Jusive on 16/6/12.
//  Copyright © 2016年 Jusive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCTradeKeyboard.h"
@interface PwdView : UIView
@property (nonatomic, weak) ZCTradeKeyboard *keyboard;

/** 键盘状态 */
@property (nonatomic, assign, getter=isKeyboardShow) BOOL keyboardShow;
@end
