//
//  KevenClipImageView.h
//  YSHYClipImageDemo
//
//  Created by KEVEN on 16/5/3.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    CIRCULARCLIP   = 0,   //圆形裁剪
    SQUARECLIP            //方形裁剪
    
}ClipType;
@interface ClipImageView : UIView<UIGestureRecognizerDelegate>
{
    UIImageView *_imageView;
    UIImage *_image;
    UIView * _overView;
}
@property (nonatomic, assign)CGFloat scaleRation;//图片缩放的最大倍数
@property (nonatomic, assign)CGFloat radius; //圆形裁剪框的半径
@property (nonatomic, assign)CGRect circularFrame;//裁剪框的frame
@property (nonatomic, assign)CGRect OriginalFrame;
@property (nonatomic, assign)CGRect currentFrame;
@property (nonatomic, assign)ClipType clipType;  //裁剪的形状

-(void)lastRestViewinit;

-(UIImage*)makesureGetCliImage;

-(instancetype)initWithImage:(UIImage *)image;
@end
