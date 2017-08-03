//
//  SignSucceedViewController.h
//  eID-SDK
//
//  Created by Jusive on 16/5/20.
//  Copyright © 2016年 Jusive. All rights reserved.
//
@interface SignSucceed: NSObject
-(void)NetWorkTools:( NSDictionary *)dict url:(NSString *)url finishs:(void(^)(void))finishBlock;

@end
