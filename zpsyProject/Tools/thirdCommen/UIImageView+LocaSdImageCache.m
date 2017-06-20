//
//  UIImageView+LocaSdImageCache.m
//  imageSelectdelet
//
//  Created by KEVEN on 16/5/10.
//  Copyright © 2016年 KEVEN. All rights reserved.
//

#import "UIImageView+LocaSdImageCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation UIImageView (LocaSdImageCache)
- (void)LocoaSdImageCacheWithURL:(NSString *)urlStr placeholderImageName:(NSString *)placeholderStr{
    UIImage *placeholder = [UIImage imageNamed:[NSString stringWithFormat:@"%@",placeholderStr]];
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    if (originalImage) {
        [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeholder];
    } else {
        [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (cacheType!=SDImageCacheTypeDisk) {
                [[SDImageCache sharedImageCache] storeImage:image forKey:urlStr toDisk:YES];
            }
        }];
    }

}
- (void)LocoaSdImageCacheWithURL:(NSString *)urlStr placeholderImageName:(NSString *)placeholderStr completed:(void(^)(UIImage *image, NSError *error,NSURL *imageURL))completedBlock{
    
    
    UIImage *placeholder = [UIImage imageNamed:[NSString stringWithFormat:@"%@",placeholderStr]];
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    if (originalImage) {
        [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (self) {
                if (completedBlock) {
                    completedBlock(image,error,imageURL);
                }
            }
        }];
    } else {
        [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (self) {
                if (completedBlock) {
                    completedBlock(image,error,imageURL);
                }
            }
            if (cacheType!=SDImageCacheTypeDisk) {
                [[SDImageCache sharedImageCache] storeImage:image forKey:urlStr toDisk:YES];
            }
        }];
    }
    
}

- (void)LocoaSdImageCacheWithURL:(NSString *)urlStr placeholder:(UIImage *)placeholder completed:(void(^)(UIImage *image, NSError *error,NSURL *imageURL))completedBlock{
    
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    if (originalImage) {
        [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (self) {
                if (completedBlock) {
                    completedBlock(image,error,imageURL);
                }
            }
            
        }];
    } else {
        [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (self) {
                if (completedBlock) {
                    completedBlock(image,error,imageURL);
                }
            }
            if (cacheType!=SDImageCacheTypeDisk) {
                [[SDImageCache sharedImageCache] storeImage:image forKey:urlStr toDisk:YES];
            }
        }];
    }
    
}

@end
