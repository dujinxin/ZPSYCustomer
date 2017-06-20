//
//  KevenPicEditview.m
//  imageSelectdelet
//
//  Created by KEVEN on 16/5/5.
//  Copyright © 2016年 KEVEN. All rights reserved.
//

#import "KevenPicEditAndShowView.h"
#import "UIImageView+LocaSdImageCache.h"
#import "PhotoBroswerVC.h"



#define kevenPicEditDefaultImageName [@"KevenPicEditPic.bundle" stringByAppendingPathComponent:@"my_home_img_commodity.png"]
#define kevenPicEditCloseBtnImageName  [@"KevenPicEditPic.bundle" stringByAppendingPathComponent:@"close_button.png"]
#define kevenPicEditdialogboxImageName  [@"KevenPicEditPic.bundle" stringByAppendingPathComponent:@"home_dialogbox_shengchengdingdan_img.png"]
#define  FailHTTPSImageUrl   @"https://FailHTTPSImageUrl"

#pragma 添加cell
@interface EditPicShowCell : UICollectionViewCell{
    
}
@property (nonatomic,strong)UIImageView *imageview;
@property (nonatomic,copy)void(^DeleteCellBlock)();
@property (nonatomic,assign)BOOL IsEdit;
@property (nonatomic,strong)NSString *DeleteImageStr;
@end
@implementation EditPicShowCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        _imageview.layer.cornerRadius=5;
//        _imageview.layer.masksToBounds=YES;
        [self.contentView addSubview:_imageview];
        float width=frame.size.width;
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(width-20, 0, 20, 20)];
        btn.tag=10;
        
        [btn setBackgroundImage:[UIImage imageNamed:kevenPicEditCloseBtnImageName] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(DeleteBtnClickEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
    }
    return self;
}

-(void)setDeleteCellBlock:(void (^)())DeleteCellBlock{

    _DeleteCellBlock=DeleteCellBlock;

}

-(void)DeleteBtnClickEvent{
    
    if (_DeleteCellBlock) {
        _DeleteCellBlock();
    }
    
}
-(void)setIsEdit:(BOOL)IsEdit{
    
    _IsEdit=IsEdit;
    UIView *v=[self.contentView viewWithTag:10];
    v.hidden=!_IsEdit;
}
-(void)setDeleteImageStr:(NSString *)DeleteImageStr{
    _DeleteImageStr=DeleteImageStr;
    UIButton *btn=[self.contentView viewWithTag:10];
    if (_DeleteImageStr) {
        [btn setBackgroundImage:[UIImage imageNamed:_DeleteImageStr] forState:UIControlStateNormal];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:kevenPicEditCloseBtnImageName] forState:UIControlStateNormal];
    }
}
@end


#pragma CollectionView
@interface KevenPicEditAndShowView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{

    NSMutableArray *PicArray;
    NSInteger MaxCount;
    
    NSMutableArray *tempArray;
    float MyHeight;
    
    NSMutableArray *UrlPicArray;
    
    CGSize FlowlayoutSize;
    
}
@property (nonatomic,strong)UICollectionView *MyCollectionView;
@end

@implementation KevenPicEditAndShowView

static NSString * const reuseIdentifier = @"kevenPicEditCell";
static NSString * const reuseIdentifier1 = @"kevenPicEditCell1";
static NSString * const reuseIdentifier2 = @"kevenPicEditCell2";
static NSString * const AddIdentifier = @"kevenPicAddCell";

-(void)setDeleteImageName:(NSString *)deleteImageName{
    _deleteImageName=deleteImageName;
}

-(void)setImageUrlArray:(NSMutableArray<NSString *> *)ImageUrlArray{
    _ImageUrlArray=ImageUrlArray;
    [self InitPicArrayWithArray:_ImageUrlArray];
    float width=self.frame.size.width;
    float With=width>0? width:300;
    float spaceWidth = 5;
    float ItemWidth=(With-4*spaceWidth)/3;
    float ItemHeight=ItemWidth;
    NSInteger flage=(PicArray.count%3)>0? 1:0;
    MyHeight=(PicArray.count/3+flage)*(ItemHeight+spaceWidth)+spaceWidth;
    
    MyHeight = MyHeight>(ItemHeight+10)? MyHeight:(ItemHeight+10);
    FlowlayoutSize=CGSizeMake(ItemWidth, ItemHeight);
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, MyHeight);
    _MyCollectionView.frame=CGRectMake(0, 0, self.frame.size.width, MyHeight);

    [_MyCollectionView reloadData];
    
}

-(instancetype)initWithFrame:(CGRect)frame ImagsUrl:(NSArray<NSString*>*)array maxCount:(NSInteger)maxCount IsEdit:(BOOL)isEdit{
    if (CGRectEqualToRect(CGRectZero, frame)) {
        frame=[UIScreen mainScreen].bounds;
    }
    self=[super initWithFrame:frame];
    if (self) {
        _IsEdit=isEdit;
        MaxCount=maxCount>0? maxCount:9;
        [self InitPicArrayWithArray:array];
        float width=frame.size.width;
        float With=width>0? width:300;
        float spaceWidth = 5;
        float ItemWidth=(With-4*spaceWidth)/3;
        float ItemHeight=ItemWidth;
        NSInteger flage=(PicArray.count%3)>0? 1:0;
        MyHeight=(PicArray.count/3+flage)*(ItemHeight+spaceWidth)+spaceWidth;
        
        MyHeight = MyHeight>(ItemHeight+10)? MyHeight:(ItemHeight+10);
        
        UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
        FlowlayoutSize=CGSizeMake(ItemWidth, ItemHeight);
//        flowlayout.itemSize=CGSizeMake(ItemWidth, ItemHeight);
        flowlayout.minimumLineSpacing=5;
        flowlayout.minimumInteritemSpacing=4;
        flowlayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
        _MyCollectionView.collectionViewLayout=flowlayout;
        _MyCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, With, MyHeight) collectionViewLayout:flowlayout];
        [_MyCollectionView registerClass:[EditPicShowCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _MyCollectionView.delegate = self;
        _MyCollectionView.dataSource=self;
        _MyCollectionView.backgroundColor=[UIColor clearColor];
        _MyCollectionView.scrollEnabled=NO;
        [self addSubview:_MyCollectionView];
        [_MyCollectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

-(void)setIsEdit:(BOOL)IsEdit{
    _IsEdit=IsEdit;
    [self.MyCollectionView reloadData];
}

-(float)Height{
    return MyHeight;
}

-(NSArray<UIImage *> *)imageArray{
    return PicArray;
}

-(NSArray *)NoEditUrlArray{
    NSMutableArray *array=[NSMutableArray array];
    [UrlPicArray enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isEqualToString:FailHTTPSImageUrl]) {
            [array addObject:obj];
        }
    }];
    return array;
}

-(NSArray<UIImage *> *)LocalImageArray{
    NSMutableArray *array=[NSMutableArray array];
    [UrlPicArray enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:FailHTTPSImageUrl]) {
            [array addObject:[PicArray objectAtIndex:idx]];
        }
    }];
    return array;
}

-(void)InitPicArrayWithArray:(NSArray*)array{

    if (array==nil) {
        array=@[];
    }
    PicArray=[NSMutableArray array];
    UrlPicArray=[NSMutableArray array];
    NSInteger count=(array.count)>MaxCount? MaxCount:(array.count);
    for (int i=0; i<count; i++) {
        UIImage *image=[UIImage imageNamed:kevenPicEditDefaultImageName];
        [PicArray addObject:image];
        [UrlPicArray addObject:array[i]];
    }
}

#pragma mark <UICollectionViewDataSource>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  FlowlayoutSize;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return PicArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    @synchronized (PicArray) {
            NSString *reuseId=reuseIdentifier;
            EditPicShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
            cell.IsEdit=_IsEdit;
            __weak typeof(self)weakself=self;
            cell.DeleteImageStr=_deleteImageName;
            [cell setDeleteCellBlock:^{
                [PicArray removeObjectAtIndex:indexPath.row];
                [UrlPicArray removeObjectAtIndex:indexPath.row];
                if (PicArray.count==MaxCount-1) {
                    
                    [collectionView reloadData];
                }
                else{
                    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
                    [weakself performSelector:@selector(refreshCollectionview) withObject:nil afterDelay:0.4];
                }
                if (_DeletePicBlock) {
                    _DeletePicBlock();
                }
            }];
//            [cell.imageview LocoaSdImageCacheWithURL:UrlPicArray[indexPath.row] placeholder:PicArray[indexPath.row] completed:^(UIImage *image, NSError *error, NSURL *imageURL) {
//                if (image) {
//                    
//                    [UrlPicArray enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                        if ([obj isEqualToString:[imageURL absoluteString]]) {
//                            PicArray[idx]=image;
//                            *stop=YES;
//                        }
//                    }];
//                }
//            }];
        [cell.imageview sd_setImageWithURL:[NSURL URLWithString:UrlPicArray[indexPath.row]] placeholderImage:PicArray[indexPath.row] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                
                [UrlPicArray enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isEqualToString:[imageURL absoluteString]]) {
                        PicArray[idx]=image;
                        *stop=YES;
                    }
                }];
            }
        }];
        cell.imageview.contentMode=UIViewContentModeScaleAspectFill;
        cell.imageview.clipsToBounds=YES;
        return cell;
            
        }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self networkImageShow:indexPath];

}
/*****************/

/*
 *  展示网络图片
 */
-(void)networkImageShow:(NSIndexPath*)indexPatch{
    
    PhotoBroswerVCType type=PhotoBroswerVCTypeZoom;
    __weak typeof(self) weakSelf=self;
    UIViewController *VC=[self findViewController:self];
    [PhotoBroswerVC show:VC type:type index:indexPatch.row photoModelBlock:^NSArray *{
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:PicArray.count];
        for (NSUInteger i = 0; i< PicArray.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            NSString *str=UrlPicArray[i];
            if (![str isEqualToString:FailHTTPSImageUrl]) {
                pbModel.image_HD_U = str;
            }else{
                pbModel.image=PicArray[i];
            }
            
            //源frame
            EditPicShowCell *cell=(EditPicShowCell*)[weakSelf.MyCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            UIImageView *imageV =(UIImageView *) cell.imageview;
            pbModel.sourceImageView = imageV;
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
}





#pragma 数据处理
-(void)AddLocalIMgArray:(NSArray<UIImage*>*)array{

    [array enumerateObjectsUsingBlock:^(UIImage*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (PicArray.count<MaxCount) {
            [PicArray addObject:obj];
            [UrlPicArray addObject:FailHTTPSImageUrl];
        }else{
            *stop=YES;
        }
    }];

    [self.MyCollectionView reloadData];

}
-(void)AddNetImageArray:(NSArray<NSString*>*)array{
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (PicArray.count<MaxCount) {
            UIImage *image=[UIImage imageNamed:kevenPicEditDefaultImageName];
            [PicArray addObject:image];
            [UrlPicArray addObject:obj];
        }else{
            *stop=YES;
        }
    }];
    [self.MyCollectionView reloadData];
}

-(void)refreshCollectionview{

    [self.MyCollectionView reloadData];
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

- (UIViewController *)findViewController:(UIView *)sourceView
{
    id target=sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}


//kvo
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        CGSize oldsize=[[change objectForKey:@"old"] CGSizeValue];
        CGSize newsize=[[change objectForKey:@"new"] CGSizeValue];
        CGRect rect=self.frame;
        rect.size.height=newsize.height+5;
        self.frame=rect;
        _MyCollectionView.frame=CGRectMake(0, 0, newsize.width, newsize.height+5);
        MyHeight=newsize.height+5;
        if (CGSizeEqualToSize(oldsize, newsize)||CGSizeEqualToSize(oldsize,CGSizeZero)) {
            return;
        }

        
        if (_refreshWithViewHeight) {
            _refreshWithViewHeight(newsize.height);
        }
        
    }
    
}
-(void)dealloc{
    [_MyCollectionView removeObserver:self forKeyPath:@"contentSize"];
}
@end
