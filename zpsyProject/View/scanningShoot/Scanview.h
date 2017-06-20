//
//  Scanview.h
//  ZPSY
//
//  Created by zhouhao on 2017/2/6.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ScanTypeEnum) {
    ScanTypeQRCode,  //二维码
    ScanTypeBarCode, //条形码
    ScanTypeGmCode,  //GM
    ScanTypeOther,   //其他
    ScanTypeFalse,   //解码失败
};


@interface Scanview : UIView
@property(nonatomic,assign)BOOL StartScaning;//是否开始扫描
@property(nonatomic,assign)BOOL OpenStrobeLight;//是否打开闪关灯

//扫描结果返回
@property(nonatomic,copy)void (^scanResultBlock)(NSString* codeValue,ScanTypeEnum type);

#if !TARGET_IPHONE_SIMULATOR
//打开相册选择识别
-(void)OpenImagePicker;
#endif
@end
