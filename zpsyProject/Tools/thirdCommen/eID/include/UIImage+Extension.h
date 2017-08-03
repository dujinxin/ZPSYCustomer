//
//  UIImage+Extension.h
//  GaGaHi
//
//  Created by zhongyekeji on 15/7/27.
//  Copyright (c) 2015年 Zonyet. All rights reserved.
//
//  描述：图片的分类

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
- (UIImage *)resizedImage:(NSString *)name;
-(instancetype)circleImageNamed:(NSString *)name;
- (UIImage *)transformWidth:(CGFloat)width height:(CGFloat)height;

@end


