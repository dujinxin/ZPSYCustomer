//
//  BaseSeverHttp.h
//  ZPSY
//
//  Created by zhouhao on 2017/2/4.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <Foundation/Foundation.h>
//请求成功回调block
typedef void (^requestSuccessBlock)(id result);

//请求失败回调block
typedef void (^requestFailureBlock)(NSError *error);


@interface BaseSeverHttp : NSObject


/**
 GET
 
 @param path 拼接地址
 @param params 参数
 @param success 成功回调
 @param failure 成功回调
 */
+(void)ZpsyGetWithPath:(NSString*)path WithParams:(id)params
      WithSuccessBlock:(requestSuccessBlock)success
       WithFailurBlock:(requestFailureBlock)failure;

/**
 POST
 
 @param path 拼接地址
 @param params 参数
 @param success 成功回调
 @param failure 成功回调
 */
+(void)ZpsyPostWithPath:(NSString*)path WithParams:(id)params
       WithSuccessBlock:(requestSuccessBlock)success
        WithFailurBlock:(requestFailureBlock)failure;

/**
 DELETE
 
 @param path 拼接地址
 @param params 参数
 @param success 成功回调
 @param failure 成功回调
 */
+(void)ZpsyDeleteWithPath:(NSString*)path WithParams:(id)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure;


/**
 未做处理Get
 @param path 拼接地址
 @param params 参数
 @param success 成功回调
 @param failure 成功回调
 */
+(void)afnetForZpsyGetWithPath:(NSString*)path WithParams:(id)params
              WithSuccessBlock:(requestSuccessBlock)success
               WithFailurBlock:(requestFailureBlock)failure;

@end
