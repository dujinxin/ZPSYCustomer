//
//  CTSelectSingleImage.h
//  dataBank
//
//  Created by guojianfeng on 16/11/2.
//  Copyright © 2016年 CT. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^selectImageBlock) (UIImage*image);
@interface CTSelectSingleImage : NSObject
/**
 高宽比
 */
@property (nonatomic,assign) float proportion;
/**
 导航栏颜色
 */
@property(nonatomic,strong) UIColor * navColor;
- (void)selectSingleImageWithView:(UIView *)view didSelect:(selectImageBlock)selectImageBlcok;
@property(nonatomic,copy)selectImageBlock selectImageBlcok;
@end
