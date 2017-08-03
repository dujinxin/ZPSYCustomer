//
//  UIView+parentController.h
//  07_114快医
//
//  Created by Jusive on 16/4/23.
//  Copyright © 2016年 apple-pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (parentController)
- (UIViewController *)getCurrentVC;
-(UIViewController *)currentViewController;
- (UIViewController *)parentController;
@end
