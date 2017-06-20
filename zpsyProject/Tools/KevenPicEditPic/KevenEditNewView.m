//
//  KevenPicEditview.m
//  imageSelectdelet
//
//  Created by KEVEN on 16/5/5.
//  Copyright © 2016年 KEVEN. All rights reserved.
//

#import "KevenEditNewView.h"
#import "UIImageView+LocaSdImageCache.h"
#import "PhotoBroswerVC.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#define kevenPicEditDefaultImageName [@"KevenPicEditPic.bundle" stringByAppendingPathComponent:@"my_home_img_commodity.png"]
#define kevenPicEditCloseBtnImageName  [@"KevenPicEditPic.bundle" stringByAppendingPathComponent:@"close_button.png"]
#define kevenPicEditdialogboxImageName  [@"KevenPicEditPic.bundle" stringByAppendingPathComponent:@"home_dialogbox_shengchengdingdan_img.png"]
#define  FailHTTPSImageUrl   @"https://FailHTTPSImageUrl"

#pragma 添加cell
@interface EditPicNewCell : UICollectionViewCell{
    
}
@property (nonatomic,strong)UIImageView *imageview;
@property (nonatomic,copy)void(^DeleteCellBlock)();
@property (nonatomic,assign)BOOL IsEdit;
@property (nonatomic,strong)NSString *DeleteImageStr;
@end
@implementation EditPicNewCell
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
#pragma 添加cell
@interface PicAddItemNewCell : UICollectionViewCell
@property (nonatomic,copy)void(^AddCellBlock)();
@property (nonatomic,strong)NSString* AddImageStr;
@end
@implementation PicAddItemNewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [btn setBackgroundImage:[UIImage imageNamed:kevenPicEditdialogboxImageName] forState:UIControlStateNormal];
        btn.tag=10;
        [btn addTarget:self action:@selector(addBtnClickEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
    return self;
}
-(void)addBtnClickEvent{
    if (_AddCellBlock) {
        _AddCellBlock();
    }
}

-(void)setAddImageStr:(NSString *)AddImageStr{
    _AddImageStr=AddImageStr;
    UIButton *btn=[self.contentView viewWithTag:10];
    if (_AddImageStr) {
        [btn setBackgroundImage:[UIImage imageNamed:_AddImageStr] forState:UIControlStateNormal];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:kevenPicEditdialogboxImageName] forState:UIControlStateNormal];
    }
}


@end

#pragma CollectionView
@interface KevenEditNewView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{

    NSMutableArray *PicArray;
    NSInteger MaxCount;
    
    float MyHeight;
    
    NSMutableArray *UrlPicArray;
    
    CGSize FlowlayoutSize;
    
    
    float spaceWidth;
    
}
@property (nonatomic,strong)NSMutableArray *picArray;
@property (nonatomic,strong)UICollectionView *MyCollectionView;
@end

@implementation KevenEditNewView
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
    float ItemWidth=(With-4*spaceWidth)/3;
    float ItemHeight=ItemWidth;
    NSInteger flage=(PicArray.count%3)>0? 1:0;
    MyHeight=(PicArray.count/3+flage)*(ItemHeight+spaceWidth)+spaceWidth;
    
    MyHeight = MyHeight>(ItemHeight+2*spaceWidth)? MyHeight:(ItemHeight+2*spaceWidth);
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
        spaceWidth = 2;
        float ItemWidth=(With-4*spaceWidth)/3;
        float ItemHeight=ItemWidth;
        NSInteger flage=(PicArray.count%3)>0? 1:0;
        MyHeight=(PicArray.count/3+flage)*(ItemHeight+spaceWidth)+spaceWidth;
        
        MyHeight = MyHeight>(ItemHeight+2*spaceWidth)? MyHeight:(ItemHeight+2*spaceWidth);
        
        UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
        FlowlayoutSize=CGSizeMake(ItemWidth, ItemHeight);
//        flowlayout.itemSize=CGSizeMake(ItemWidth, ItemHeight);
        flowlayout.minimumLineSpacing=spaceWidth;
        flowlayout.minimumInteritemSpacing=spaceWidth-1;
        flowlayout.sectionInset = UIEdgeInsetsMake(spaceWidth, spaceWidth, 0, spaceWidth);
        _MyCollectionView.collectionViewLayout=flowlayout;
        _MyCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, With, MyHeight) collectionViewLayout:flowlayout];
        [_MyCollectionView registerClass:[EditPicNewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_MyCollectionView registerClass:[PicAddItemNewCell class] forCellWithReuseIdentifier:AddIdentifier];
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
    
    self.canAddImage=PicArray.count>=9? NO:YES;
    
}

#pragma mark <UICollectionViewDataSource>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  FlowlayoutSize;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return PicArray.count>=MaxCount? MaxCount:PicArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    @synchronized (PicArray) {
        
        if (PicArray.count==indexPath.row) {
            PicAddItemNewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AddIdentifier forIndexPath:indexPath];
            cell.AddImageStr=_AddImageName;
            __weak typeof(self) weakself=self;
            [cell setAddCellBlock:^{
                [weakself SelectPicCameraOrPhoto];
            }];
            return cell;
        }
            NSString *reuseId=reuseIdentifier;
            EditPicNewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
            cell.IsEdit=_IsEdit;
            __weak typeof(self)weakself=self;
            cell.DeleteImageStr=_deleteImageName;
            [cell setDeleteCellBlock:^{
                NSString *urlstr=UrlPicArray[indexPath.row];
                [PicArray removeObjectAtIndex:indexPath.row];
                [UrlPicArray removeObjectAtIndex:indexPath.row];
                self.canAddImage=PicArray.count>=9? NO:YES;
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
                if (![urlstr isEqualToString:FailHTTPSImageUrl]) {
                    if (_DeleteUrlPicBlock) {
                        _DeleteUrlPicBlock(urlstr);
                    }
                }
            }];
            [cell.imageview LocoaSdImageCacheWithURL:UrlPicArray[indexPath.row] placeholder:PicArray[indexPath.row] completed:^(UIImage *image, NSError *error, NSURL *imageURL) {
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
            EditPicNewCell *cell=(EditPicNewCell*)[weakSelf.MyCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
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
    self.canAddImage=PicArray.count>=9? NO:YES;
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
    self.canAddImage=PicArray.count>=9? NO:YES;
    [self.MyCollectionView reloadData];

}

-(void)DeleteImgStr:(NSString*)urlString{

    if (urlString) {
     
        [UrlPicArray enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isEqualToString:urlString]) {
                [UrlPicArray removeObjectAtIndex:idx];
                [PicArray removeObjectAtIndex:idx];
                *stop=YES;
            }
            
        }];
        self.canAddImage=PicArray.count>=9? NO:YES;
        [_MyCollectionView reloadData];
    }
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

//选择图片
-(void)SelectPicCameraOrPhoto{
    __weak UIViewController *vc = [self findViewController:self];
    __weak typeof(self) weakself=self;
    NSInteger PicCount =MaxCount-PicArray.count;
    
    //    if (PicCount<=0) {
    //        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"你选择的图片已达上限" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //        UIAlertAction *Cancellaction=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    //        [alert addAction:Cancellaction];
    //        UIWindow *window=[UIApplication sharedApplication].keyWindow;
    //        [window.rootViewController presentViewController:alert animated:YES completion:nil];
    //        return;
    //    }
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction=[UIAlertAction actionWithTitle:@"相机拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself GetPIcFromPhoto];
    }];
    UIAlertAction *OKaction=[UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:PicCount delegate:nil];
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            [weakself setChooseView:photos];
        }];
        [vc presentViewController:imagePickerVc animated:YES completion:nil];
    }];
    
    UIAlertAction *cancellAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alert addAction:cameraAction];
    [alert addAction:OKaction];
    [alert addAction:cancellAction];
    [vc presentViewController:alert animated:YES completion:nil];
}
-(void)GetPIcFromPhoto{
    BOOL canopen= [CTUtility handleWithAuthWith:AuthorizationTakePhoto];
    if (!canopen) {
        [MBProgressHUD showSuccess:@"相机已关闭,请去打开相机权限"];
        return;
    }
    
    BOOL isCamer = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (isCamer == NO) {
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"不能在模拟器上跑o" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cameraAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:cameraAction];
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [window.rootViewController presentViewController:alert animated:YES completion:nil];
       // UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"不能在模拟器上跑o" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        //[alertView show];
        return;
    }
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerController.delegate = self;
    [[self findViewController:self] presentViewController:pickerController animated:YES completion:nil];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //关闭相册选取控制器
    [picker dismissViewControllerAnimated:YES completion:^{
        
        //获取到媒体的类型
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        //判断选取的资源是否为视频
        if ([mediaType isEqualToString:@"public.movie"]) {
            //获取到媒体的URL地址
            return;
            
        }
        //判断选取的资源是否为相片
        else if([mediaType isEqualToString:@"public.image"]) {
            //获取到选取的照片数据
            //获取原始图片
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            CGSize newSize=CGSizeMake(image.size.width/4, image.size.height/4);
            //We set the scaled image from the context
            UIImage* scaledImage = [self ScaleImage:image size:newSize];
            [self setChooseView:@[scaledImage]];
        }
        
    }];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)setChooseView:(NSArray*)array{


    [PicArray addObjectsFromArray:array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [UrlPicArray addObject:FailHTTPSImageUrl];
    }];
    self.canAddImage=PicArray.count>=9? NO:YES;
    [self.MyCollectionView reloadData];


}
-(UIImage*)ScaleImage:(UIImage*)image size:(CGSize)newSize{
    //We prepare a bitmap with the new size
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0);
    
    //Draws a rect for the image
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    //We set the scaled image from the context
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    scaledImage =[UIImage imageWithData:UIImageJPEGRepresentation(scaledImage, 1)];
    return scaledImage;
}
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
        rect.size.height=newsize.height+spaceWidth;
        self.frame=rect;
        _MyCollectionView.frame=CGRectMake(0, 0, newsize.width, newsize.height+spaceWidth);
        MyHeight=newsize.height+spaceWidth;
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
