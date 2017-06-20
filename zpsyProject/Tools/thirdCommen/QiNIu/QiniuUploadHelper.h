//
//  QiniuUploadHelper.h
//  ZPSY
//
//  Created by zhouhao on 2017/3/25.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QiniuUploadHelper : NSObject
@property (copy, nonatomic) void (^singleSuccessBlock)(NSString *);
@property (copy, nonatomic)  void (^singleFailureBlock)();
@property(nonatomic,strong)NSString *QiNiuBaseUrl;
+ (instancetype)sharedUploadHelper;


@end
