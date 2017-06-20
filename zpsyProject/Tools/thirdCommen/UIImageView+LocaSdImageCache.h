//
//  UIImageView+LocaSdImageCache.h
//  imageSelectdelet
//
//  Created by KEVEN on 16/5/10.
//  Copyright © 2016年 KEVEN. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImageView (LocaSdImageCache)
- (void)LocoaSdImageCacheWithURL:(NSString *)urlStr placeholderImageName:(NSString *)placeholderStr;
- (void)LocoaSdImageCacheWithURL:(NSString *)urlStr placeholderImageName:(NSString *)placeholderStr completed:(void(^)(UIImage *image, NSError *error,NSURL *imageURL))completedBlock;
- (void)LocoaSdImageCacheWithURL:(NSString *)urlStr placeholder:(UIImage *)placeholder completed:(void(^)(UIImage *image, NSError *error,NSURL *imageURL))completedBlock;
@end
