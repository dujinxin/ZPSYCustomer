//
//  UserModel.h
//  ZPSY
//
//  Created by zhouhao on 2017/2/10.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface userInfoModel : NSObject
@property(nonatomic,strong)NSString* nickName;//昵称
@property(nonatomic,strong)NSString* avatar;//头像
@property(nonatomic,strong)NSString* messageNum;//消息
@property(nonatomic,strong)NSString* score;//积分
@property(nonatomic,strong)NSString* genuid;//正品号
@property(nonatomic,strong)NSString* feedbackNum;//反馈
@property(nonatomic,strong)NSString* collectionNum;//收藏
@property(nonatomic,strong)NSString* mobile;//手机号
@end


@interface UserModel : NSObject

//+(instancetype)ShareInstance;
//
//
//
//@property(nonatomic,assign)BOOL IsLogin;//是否登录
//
//
//@property(nonatomic,strong)userInfoModel *userInfo;//用户信息
//
//@property(nonatomic,strong)NSString * TOKEN;

@end
