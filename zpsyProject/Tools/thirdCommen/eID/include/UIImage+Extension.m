//
//  UIImage+Extension.m
//  GaGaHi
//
//  Created by zhongyekeji on 15/7/27.
//  Copyright (c) 2015年 Zonyet. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

-(UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

- (UIImage *)transformWidth:(CGFloat)width height:(CGFloat)height
{
    CGFloat destW = width;
    CGFloat destH = height;
    CGFloat sourceW = width;
    CGFloat sourceH = height;
    
    CGImageRef imageRef = self.CGImage;
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                destW,
                                                destH,
                                                CGImageGetBitsPerComponent(imageRef),
                                                4*destW,
                                                CGImageGetColorSpace(imageRef),
                                                (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *resultImage = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return resultImage;
}
- (instancetype)circleImage{
    //开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    //获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //矩形框
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    //添加一个圆
    CGContextAddEllipseInRect(context, rect);
    
    //裁剪
    CGContextClip(context);
    
    //往圆上画一张图片
    [self drawInRect:rect];
    
    //获取图形上下文中的图形
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
    
}

-(instancetype)circleImageNamed:(NSString *)name{
    return [[UIImage imageNamed:name]circleImage];
}
@end


