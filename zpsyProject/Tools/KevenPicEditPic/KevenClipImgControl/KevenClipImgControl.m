//
//  KevenClipImgControl.m
//  YSHYClipImageDemo
//
//  Created by KEVEN on 16/5/3.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "KevenClipImgControl.h"
#import "ClipImageView.h"
#define kClipDuration 0.7   // 动画持续时间(秒)
#define ClipSrcName(file) [@"Clip.bundle" stringByAppendingPathComponent:file]
#define ClipFrameworkSrcName(file) [@"Frameworks/KevenClipImgControl.framework/Clip.bundle" stringByAppendingPathComponent:file]
@interface KevenClipImgControl (){

    NSInteger curentTag;
    NSMutableArray *ImgViewArray;

}

@end

@implementation KevenClipImgControl

-(void)setImgArray:(NSMutableArray<UIImage *> *)ImgArray{
    _ImgArray=[ImgArray mutableCopy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    curentTag=0;
    ImgViewArray=[NSMutableArray array];
    if (_ImgArray.count>0) {
        self.title=[NSString stringWithFormat:@"%zi/%zi",curentTag+1,_ImgArray.count];
        [self initImgView];
    }
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    UIImage *image = [UIImage imageNamed:ClipSrcName(@"nav_return")] ?: [UIImage imageNamed:ClipFrameworkSrcName(@"nav_return")];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(LeftBtnClickEvent) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *LeftBtnItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:LeftBtnItem];
}


-(void)initImgView{

    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [btn setTitleColor:kColor_1 forState:UIControlStateNormal];
    [btn setTitle:@"裁剪" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(ClipBtnClickEvent) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
    
    
    for (NSInteger i=_ImgArray.count-1; i>=0; i--) {
        
        ClipImageView *imgview=[[ClipImageView alloc] initWithImage:_ImgArray[i]];
        imgview.frame=self.view.frame;
        if (_clipType==MyCIRCULARCLIP) {
            imgview.clipType=CIRCULARCLIP;
        }else{
            imgview.clipType=SQUARECLIP;
            if (CGRectEqualToRect(_ClipFrame, CGRectNull)||CGRectEqualToRect(_ClipFrame, CGRectZero)) {
                imgview.radius=self.view.frame.size.width/2-1;
            }else{
                imgview.circularFrame=_ClipFrame;
            }
            
        }
        imgview.tag=i;
        
        [imgview lastRestViewinit];
        [self.view addSubview:imgview];
        [ImgViewArray insertObject:imgview atIndex:0];
    }
        
    
}


-(void)ClipBtnClickEvent{

    ClipImageView *imgview=ImgViewArray[curentTag];
    UIImage *img=[imgview makesureGetCliImage];
    [_ImgArray replaceObjectAtIndex:curentTag withObject:img];
    if (curentTag>=_ImgArray.count-1) {
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        if (_GetEditedImageArray) {
            _GetEditedImageArray(_ImgArray);
        }
    }else{
        curentTag+=1;
        self.title=[NSString stringWithFormat:@"%zi/%zi",curentTag+1,_ImgArray.count];
        ClipImageView *v2 = ImgViewArray[curentTag];
        CATransition *animation = [CATransition animation];
//        animation.delegate = self;
        animation.duration = kClipDuration;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"pageCurl";
        animation.subtype = kCATransitionFromBottom;
        NSUInteger green = [[self.view subviews] indexOfObject:imgview];
        NSUInteger blue = [[self.view subviews] indexOfObject:v2];
        [self.view exchangeSubviewAtIndex:green withSubviewAtIndex:blue];
        [[self.view layer] addAnimation:animation forKey:@"animation"];
    }
}



-(void)LeftBtnClickEvent{

    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    if (!_mustClip) {
        if (_ImgArray.count>0) {
            if (_GetEditedImageArray) {
                _GetEditedImageArray(_ImgArray);
            }
        }
    }
    
}



- (void)setMustClip:(BOOL)mustClip{
    _mustClip = mustClip;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
