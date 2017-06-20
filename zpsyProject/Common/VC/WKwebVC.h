//
//  WKwebVC.h
//  ZPSY
//
//  Created by zhouhao on 2017/2/9.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKwebVC : UIViewController

@property(nonatomic)NSString *URLstr;//url

@property(nonatomic)NSString* pathStr;//加载文件名

@property(nonatomic,assign)BOOL IsrequestFile;

@end
