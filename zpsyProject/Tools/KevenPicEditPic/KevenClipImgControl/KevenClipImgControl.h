//
//  KevenClipImgControl.h
//  YSHYClipImageDemo
//
//  Created by KEVEN on 16/5/3.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    MyCIRCULARCLIP   = 0,   //圆形裁剪
    MySQUARECLIP            //方形裁剪
    
}MyClipType;
@interface KevenClipImgControl : UIViewController

//图片数组
@property (nonatomic,strong)NSMutableArray<UIImage*>*ImgArray;

//裁剪的形状
@property (nonatomic, assign)MyClipType clipType;

//裁剪矩形时 -> 默认为方形
@property (nonatomic, assign)CGRect ClipFrame;

/**
 *  获取裁剪后的图片数组
 */
@property (nonatomic,copy)void(^GetEditedImageArray)(NSMutableArray*);

//是否必须裁剪
@property (nonatomic, assign)BOOL mustClip;
@end
