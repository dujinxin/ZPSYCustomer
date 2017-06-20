//
//  ConfigFile.h
//  ZPSY
//
//  Created by zhouhao on 2017/2/5.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#ifndef ConfigFile_h
#define ConfigFile_h

//=====================第三方配置=======================
//========激光=======
#define JPappKey @"0755873c8113c46dc0711fbd"

//友盟
#define USHARE_DEMO_APPKEY @"58d335e1bbea8320ab0009b4"

//微信
#define wxAppKey @"wx4ddf36ff13036d95"
#define wxAppSecret @"5fbbff26d3cecefe41c4d843b6fd1d72"

//QQ
#define QQAppKey @"101382849"
#define QQAppSecret @"984c980729f524d9da797eca5652e01d"

//Sina
#define SinaAppKey @"1137827924"
#define SinaAppSecret @"ea8017aac1f52ae38a030d31778183ca"

//=======================颜色==========================
#define kColor_1 kColor(20,148,255)        //用于重点突出文字、数字、按钮和点击后的icon
#define kColor_2 kColor(255,255,255)       //用于分隔模块的底色，以及部分按钮的文字
/**
 *   纯黑色(用于重要文字信息，如导航栏文字，内页标题文字)
 */
#define kColor_4 kColor(51,51,51)

/**
 *   主标题黑色(用于次级文字，如列表页的标签、菜单栏和导航栏文字、图标)
 */
#define kColor_5 kColor(102,102,102)

/**
 *   次级标题黑色(用于辅助文字信息，普通文字段落信息和引导词)
 */
#define kColor_6 kColor(153,153,153)

/*
 *   弱3(用于默认文字信息 1px)
 **/
#define kColor_7 kColor(204,204,204)

/**
 *   弱2(用于同模块不同内容的分割线，分割线默认  1px)
 */
#define kColor_8 kColor(229,229,229)

/**
 *   弱1(用于分隔模块或者背景的底色)
 */
#define kColor_9 kColor(245,245,245)
/**
 *   红色
 */
#define kColor_red kColor_hex(0xc3222c)
//========================fontSize=====================

#define kFontWithF(f) [UIFont systemFontOfSize:f]
#define kFont_1 kFontWithF(21)    //用于部分的状态提示  （如填充、认证成功提示、支付页面金额文字）
#define kFont_2 kFontWithF(18)    //用于重要的文字或操作按钮  （如导航栏标题栏）
#define kFont_3 kFontWithF(16)    //用于重要的文字  （如买手主页名称、消息页用户名称）
#define kFont_4 kFontWithF(15)    //用于大部分的文字标题  （如用户名称、切换导航）
#define kFont_5 kFontWithF(14)    //用于大部分文字  （如完善个人资料）
#define kFont_6 kFontWithF(13)    //用于大多数文字  （如任务详情描述）
#define kFont_7 kFontWithF(12)    //用于辅助性文字  （如备注、提示说明、时间）
#define kFont_8 kFontWithF(11)    //用于辅助性文字  （如菜单栏图标字体）


#endif /* ConfigFile_h */
