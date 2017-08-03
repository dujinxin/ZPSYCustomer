//
//  ZCTradeKeyboard.h

//
//  Created by Jusive on 15/4/24.

//  交易密码键盘

#import <Foundation///Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@class ZCTradeKeyboard;

@protocol ZCTradeKeyboardDelegate <NSObject>

@optional
/** 数字按钮点击 */
- (void)tradeKeyboard:(ZCTradeKeyboard *)keyboard numBtnClick:(NSInteger)num;
/** 删除按钮点击 */
- (void)tradeKeyboardDeleteBtnClick;
/** 确定按钮点击 */
- (void)tradeKeyboardOkBtnClick;
@end

@interface ZCTradeKeyboard : UIView
// 所有数字按钮的数组
@property (nonatomic, strong) NSMutableArray *numBtns;
// 代理
@property (nonatomic, weak) id<ZCTradeKeyboardDelegate> delegate;
@end