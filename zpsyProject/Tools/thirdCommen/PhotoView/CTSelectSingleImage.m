//
//  CTSelectSingleImage.m
//  dataBank
//
//  Created by guojianfeng on 16/11/2.
//  Copyright © 2016年 CT. All rights reserved.
//

#import "CTSelectSingleImage.h"
#import "KevenClipImgControl.h"
#import "CTUtility.h"

@interface CTSelectSingleImage ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong,nonatomic) UIViewController *controller;
@property (strong,nonatomic) UIImage *selectImage;
@end

@implementation CTSelectSingleImage

- (void)selectSingleImageWithView:(UIView *)view didSelect:(selectImageBlock)selectImageBlcok{
    self.controller = [CTUtility findViewController:view];
    //创建相机选择控制器
    [self createAlertController];
    self.selectImageBlcok = [selectImageBlcok copy];
}

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)createAlertController{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectPictures];
    }]];
    
    [alertVc addAction:[UIAlertAction actionWithTitle:@"相机拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([CTUtility handleWithAuthWith:AuthorizationTakePhoto]) {
            [self selectPicturesWithCamera];
        }
        
    }]];
    
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self.controller presentViewController:alertVc animated:YES completion:nil];
}

- (void)selectPictures{
    UIImagePickerController *pickView = [[UIImagePickerController alloc]init];
    pickView.delegate =self;
    [self.controller presentViewController:pickView animated:YES completion:nil];
    if (self.navColor) {
        pickView.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        pickView.navigationBar.barTintColor = self.navColor;
        pickView.navigationBar.tintColor = JXMainColor;
        pickView.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:JXMainColor};
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc]init];
        backItem.title=@"back";
        [backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"nav_return_white"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];//更改背景图片
        pickView.navigationItem.backBarButtonItem= backItem;//更改背景图片
    }
    
}

- (void)selectPicturesWithCamera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *pickView = [[UIImagePickerController alloc]init];
        pickView.sourceType =UIImagePickerControllerSourceTypeCamera;
        pickView.delegate =self;
        [self.controller presentViewController:pickView animated:YES completion:nil];
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"相机" message:@"相机不可用" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
    }
}

- (UIImage *)selectImage{
    if (_selectImage.imageOrientation == UIImageOrientationUp) return _selectImage;
    
    UIGraphicsBeginImageContextWithOptions(_selectImage.size, NO, _selectImage.scale);
    [_selectImage drawInRect:(CGRect){0, 0, _selectImage.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if (info [UIImagePickerControllerOriginalImage]==nil) return;
    self.selectImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self clipImage];
}

- (void)clipImage{
    KevenClipImgControl *vc=[[KevenClipImgControl alloc] init];
    [vc setClipType:MySQUARECLIP];
    vc.mustClip = YES;
    float width = [UIScreen mainScreen].bounds.size.width-20;

    float height = self.proportion > 0 ?  ( width * self.proportion) : ([UIScreen mainScreen].bounds.size.width-20);
    vc.ClipFrame=CGRectMake(0, 0, width, height);
    vc.ImgArray =[NSMutableArray arrayWithObject:self.selectImage];
    __weak typeof(self) weakself=self;
    [vc setGetEditedImageArray:^(NSMutableArray *array) {
        [array enumerateObjectsUsingBlock:^(UIImage*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGSize newSize=CGSizeMake(width, height);
            UIImage *scaledImage = [self ScaleImage:obj size:newSize];
            weakself.selectImage = scaledImage;
            if (weakself.selectImageBlcok) {
                weakself.selectImageBlcok(weakself.selectImage);
            }
        }];
        
    }];
    [self.controller.navigationController pushViewController:vc animated:YES];
}

-(UIImage*)ScaleImage:(UIImage*)image size:(CGSize)newSize{
    //We prepare a bitmap with the new size
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0);
    //Draws a rect for the image
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    //We set the scaled image from the context
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    scaledImage =[UIImage imageWithData:UIImageJPEGRepresentation(scaledImage, 1)];
    return scaledImage;
}
@end
