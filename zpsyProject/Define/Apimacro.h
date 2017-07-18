//
//  macrodefine.h
//  ZPSY
//
//  Created by zhouhao on 2017/2/12.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#ifndef Apimacro_h
#define Apimacro_h

//=====================Api IP=======================

#define BASEURL @"https://app.izheng.org/genuine/"
//html5 域名
#define HtmlBasUrl @"http://app.izheng.org/#/"

//#define BASEURL @"http://192.168.10.12:8082/genuine/"
//#define HtmlBasUrl @"http://192.168.10.12:8082/#/"

//================================

//登录
#define Api_Login @"login/loginAppByPhone"//手机登录
#define Api_getAuthorizationCode @"user/getAuthorizationCode"
#define Api_LoginThird @"login/loginByTencentAndSina"//第三方登录
#define Api_mobileIsExist @"user/mobileIsExist"//验证手机号
#define Api_bindMobile @"user/bindMobile" //绑定手机号

//首页
#define Api_homePage @"advertisement/getList"//首页
#define Api_preferenceGetList @"preference/getList"//正品优选

//历史
#define Api_scanRecordList @"scanRecord/getList"//历史列表
#define Api_scanRecordDeleteAll @"scanRecord/deleteAll" //删除所有
#define Api_scanRecordDeleteById @"scanRecord/deleteById"//根据ID删除

/**
 曝光
 */
#define Api_GetExposureDetail  @"exposureBar/getContenById" //获取曝光详情
#define Api_GetExposureList  @"exposureBar/getList" //获取曝光列表


/**
 我的
 */
#define Api_GetuserByToken @"user/getByToken"//获取用户信息
#define Api_GetScoreList @"user/getScoreList"//获取积分记录
#define Api_GetMessageList @"message/getAllMessage"//消息历史
#define Api_GetFavoritesExposureBarList @"favorite/getMyFavoritesExposureBarList" //收藏曝光列表
#define Api_GetFavoritesGoodsList @"favorite/getMyFavoritesGoodsList" //收藏商品列表
#define Api_getfavoritesPreferenceList @"favorite/getMyFavoritesPreferenceList"//收藏正品优选
#define Api_getFeedBackList @"feedback/getMyFeedbackList"//获取反馈列表
#define Api_getReport @"report/getMyReportList" //举报列表
#define Api_userUpdate @"user/update" //更改用户信息

#define Api_userFavorites @"favorite/favoritesOrCanclefavorites" //收藏，取消收藏
#define Api_isFavorites @"favorite/isAlreadyFavorites" //获取收藏状态
#define Api_GetMyGoodsComment @"comment/getMyGoodsComment"//获取我的商品评论
#define Api_GetMyExposureBarComment @"comment/getMyExposureBarComment"//获取我的曝光评论
#define Api_GetMyPreferenceComment @"comment/getMyPreferenceComment"//获取我的正品优选评论



/**
 获取七牛
 */
#define Api_getUploadToken @"user/getUploadToken"

/**
 设置
 */
#define Api_submitFeedBack @"feedback/addFeedback"//意见反馈

/**
 扫码
 */
#define Api_creatReport @"report/addReport" //创建举报
#define Api_productFindById @"product/findById" //查询商品详情
#define Api_scanRecordFind @"scanRecord/find" //扫码结果查询
#define Api_productComparePrices @"product/comparePrices" //扫码比价

/**
 评论
 */
#define Api_commentPublish @"comment/publish" //发表评论
#define Api_commentGetComment @"comment/getComment"//根据ID获取评论
#define Api_praiseCommitPraise @"praise/commitPraise"//点赞

/**
 分享
 */
#define Api_userScoreChange @"user/score"//修改积分

#endif /* Apimacro_h */
