//
//  CASimConfig.h v2.0.1
//  
//
//  Created by wuch on 14-4-16.
//
//  Modify 14-6-26

#ifndef _CASimConfig_h
#define _CASimConfig_h

/*!
 *  @property config
 *
 *  @discussion The config of the app.
 */

//为方便确认开发代码同步信息，发布ipa请手动录入服务器开发版本号

#define _DEVELOP_CODE_VERSON @"2016.4.29.2795"//@"2.0.0.2571"
//#define _DEVELOP_CODE_VERSON @"2015.06.05挂件版"

//对外发布app的配置属性



//以下为蓝牙读写数据配置属性
typedef enum
{
    _Notify_Mode=0, //_Notify_Mode
    _Recv_Mode=1    //_Recv_Mode
    
}BLE_SWAP_MODE;;

#define BLE_SWAP_MODE _ble_swap_mode
#define _ble_swap_mode 0


//以下为窗体加载配置属性
typedef enum
{
    _root_Central=0,         //主模式窗,default
    _root_AutoTest=1,        //主模式测试窗（测试绑定）
    _root_ByteSend=2,       //主模式测试窗2(测试速率）
    _root_Brocast=3,         //接收主设备广播的广告机
    _peripheral_Central=4    //接收从设备广播的广告机
    
}APP_ROOTVIWEW_MODE;

#define APP_ROOTVIWEW_MODE _app_rootview_mode
#define _app_rootview_mode 0

//以下为蓝牙通道对象配置属性
typedef enum
{
    _TiMode=0,           //_TiMode
    _3221CardMode=1,     //_3221Mode
    _1228CardMode=2      //_1228Mode
    
}APP_CHANNEL_MODE;

//#define _TiMode
#define APP_CHANNEL_MODE _app_channel_mode
#define _app_channel_mode 1

//以下为代码开发过程时候可能用到的宏定义
#define _sumandxor_flag                //是否开启传输过程校验和比对功能（v40版本卡以上需启用）
#define _Subjective_connect            //是否主动重连
//#define _Synchronous_Clock           //同步心跳包（暂时不启用）
#define _auto_bind2connect_by_uuid     //通过uuid重绑定连接
#define _auto_bind2connect_by_nameid   //通过nameid重绑定连接


#endif
