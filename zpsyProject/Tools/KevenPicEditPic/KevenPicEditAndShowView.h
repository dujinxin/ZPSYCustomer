//
//  KevenPicEditview.h
//  imageSelectdelet
//
//  Created by KEVEN on 16/5/5.
//  Copyright © 2016年 KEVEN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KevenPicEditAndShowView : UIView{

}
@property (nonatomic,copy)void(^DeletePicBlock)();

/**
 *  编辑 状态下 回调刷新高度
 */
@property (nonatomic,copy)void(^refreshWithViewHeight)(float height);

/**
 *  编辑 状态下 获取所有图片
 */
@property (nonatomic,strong)NSArray<UIImage*>*imageArray;

/**
 *  编辑 状态下 获取所有本地新添加的图片
 */
@property (nonatomic,readonly)NSArray<UIImage*>*LocalImageArray;

/**
 *  编辑 状态下 获取未编辑的网络urlStr
 */
@property (nonatomic,readonly)NSArray*NoEditUrlArray;

/**
 *   高度
 */
@property (nonatomic,readonly)float Height;

/**
 *  删除 图片
 */
@property (nonatomic,strong)NSString *deleteImageName;
/**
 *  初始化
 *
 *  @param frame    必须填写 且 必须 不等于 CGRectZero
 *  @param array    NSURL 数组
 *  @param maxCount 最大图片量
 *  @param isEdit   是否处于编辑状态
 *  @return KevenPicEditview 对象
 */
-(instancetype)initWithFrame:(CGRect)frame ImagsUrl:(NSArray<NSString*>*)array maxCount:(NSInteger)maxCount IsEdit:(BOOL)isEdit;
@property(nonatomic,assign)BOOL IsEdit;

/**
 *  NSURL 数组
 */
@property(nonatomic,strong)NSMutableArray<NSString*> *ImageUrlArray;

//追加网络图片
-(void)AddNetImageArray:(NSArray<NSString*>*)array;
//添加本地图片
-(void)AddLocalIMgArray:(NSArray<UIImage*>*)array;
@end
