//
//  AdScrollView.m
//  广告循环滚动效果
//
//  Created by QzydeMac on 14/12/20.
//  Copyright (c) 2014年 Qzy. All rights reserved.
//

#import "AdScrollView.h"
//#import "UIImageView+Addtion.h"


#define UISCREENWIDTH  self.bounds.size.width//广告的宽度
#define UISCREENHEIGHT  self.bounds.size.height//广告的高度

#define HIGHT self.bounds.origin.y //由于_pageControl是添加进父视图的,所以实际位置要参考,滚动视图的y坐标

static CGFloat const chageImageTime = 5.0;
static NSUInteger currentImage = 1;//记录中间图片的下标,开始总是为1

@interface AdScrollView ()

{
    //广告的label
    UILabel * _adLabel;
    //循环滚动的三个视图
    UIImageView * _leftImageView;
    UIImageView * _centerImageView;
    UIImageView * _rightImageView;
    //循环滚动的周期时间
    NSTimer * _moveTime;
    //用于确定滚动式由人导致的还是计时器到了,系统帮我们滚动的,YES,则为系统滚动,NO则为客户滚动(ps.在客户端中客户滚动一个广告后,这个广告的计时器要归0并重新计时)
    BOOL _isTimeUp;
    //为每一个图片添加一个广告语(可选)
    UILabel * _leftAdLabel;
    UILabel * _centerAdLabel;
    UILabel * _rightAdLabel;
}

@property (retain,nonatomic,readonly) UIImageView * leftImageView;
@property (retain,nonatomic,readonly) UIImageView * centerImageView;
@property (retain,nonatomic,readonly) UIImageView * rightImageView;

@end

@implementation AdScrollView


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //
        [self initialization];
        
    }
    return self;
}
#pragma mark - 自由指定广告所占的frame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self initialization];
    }
    return self;
}
-(void)initialization{
    self.bounces = NO;
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
    self.contentSize = CGSizeMake(UISCREENWIDTH * 3, UISCREENHEIGHT);
    self.delegate = self;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:longPress];
}
#pragma mark - 设置广告所使用的图片(名字)
- (void)setImageNameArray:(NSArray *)imageNameArray
{
    if (!imageNameArray) {
        return;
    }
    _imageNameArray = imageNameArray;
    
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT)];
    _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    _leftImageView.clipsToBounds = YES;
    [self addSubview:_leftImageView];
    if (_imageNameArray && _imageNameArray.count > 1) {
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH*2, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        _centerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _centerImageView.clipsToBounds = YES;
        _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
        _rightImageView.clipsToBounds = YES;
        
        [self addSubview:_centerImageView];
        [self addSubview:_rightImageView];
        
        self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
        self.contentSize = CGSizeMake(UISCREENWIDTH * 3, UISCREENHEIGHT);
        currentImage = 1;
        [self stop];
        [self setupTimer];
        
        //        _moveTime = [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
        //        _isTimeUp = NO;
        
        //使该线程保持活跃状态，保证定时器计时准确
        //[[NSRunLoop currentRunLoop] run];
        
        
        //        [_leftImageView setImageWithString:_imageNameArray[(currentImage-1)%_imageNameArray.count] placeholderImage:nil];
        //        [_centerImageView setImageWithString:_imageNameArray[(currentImage)%_imageNameArray.count] placeholderImage:nil];
        //        [_rightImageView setImageWithString:_imageNameArray[(currentImage+1)%_imageNameArray.count] placeholderImage:nil];
        
        [_leftImageView sd_setImageWithURL:_imageNameArray[_imageNameArray.count-1] placeholderImage:JXImageNamed(@"image_one")];
        [_centerImageView sd_setImageWithURL:_imageNameArray[0] placeholderImage:JXImageNamed(@"image_one")];
        [_rightImageView sd_setImageWithURL:_imageNameArray[1] placeholderImage:JXImageNamed(@"image_one")];
    }else{
        [self stop];
        self.contentOffset = CGPointMake(0, 0);
        self.contentSize = CGSizeMake(UISCREENWIDTH, UISCREENHEIGHT);
        if (_imageNameArray.count == 1) {
            [_leftImageView sd_setImageWithURL:_imageNameArray[0] placeholderImage:JXImageNamed(@"image_one")];
        }else{
            if (_pageLabel) {
                [_pageLabel setHidden:YES];
            }
            if (_pageControl){
                [_pageControl setHidden:YES];
            }
        }
    }
}

#pragma mark - 设置每个对应广告对应的广告语
- (void)setAdTitleArray:(NSArray *)adTitleArray withShowStyle:(AdTitleShowStyle)adTitleStyle
{
    _adTitleArray = adTitleArray;
    
    if(adTitleStyle == AdTitleShowStyleNone)
    {
        return;
    }
    _leftAdLabel = [[UILabel alloc]init];
    _leftAdLabel.frame = CGRectMake(10, UISCREENHEIGHT - 40, UISCREENWIDTH, 20);
    [_leftImageView addSubview:_leftAdLabel];
    
    if (adTitleArray && adTitleArray.count > 1) {
        _centerAdLabel = [[UILabel alloc]init];
        _rightAdLabel = [[UILabel alloc]init];
        
        _centerAdLabel.frame = CGRectMake(10, UISCREENHEIGHT - 40, UISCREENWIDTH, 20);
        [_centerImageView addSubview:_centerAdLabel];
        _rightAdLabel.frame = CGRectMake(10, UISCREENHEIGHT - 40, UISCREENWIDTH, 20);
        [_rightImageView addSubview:_rightAdLabel];
        
        _leftAdLabel.text = _adTitleArray[(currentImage-1)%_adTitleArray.count];
        _centerAdLabel.text = _adTitleArray[(currentImage)%_adTitleArray.count];
        _rightAdLabel.text = _adTitleArray[(currentImage+1)%_adTitleArray.count];
    }else{
        if(adTitleArray.count == 1){
            _leftAdLabel.text = _adTitleArray[(currentImage-1)%_adTitleArray.count];
        }
    }
    
    
    
    
    if (adTitleStyle == AdTitleShowStyleLeft) {
        _leftAdLabel.textAlignment = NSTextAlignmentLeft;
        _centerAdLabel.textAlignment = NSTextAlignmentLeft;
        _rightAdLabel.textAlignment = NSTextAlignmentLeft;
    }
    else if (adTitleStyle == AdTitleShowStyleCenter)
    {
        _leftAdLabel.textAlignment = NSTextAlignmentCenter;
        _centerAdLabel.textAlignment = NSTextAlignmentCenter;
        _rightAdLabel.textAlignment = NSTextAlignmentCenter;
    }
    else
    {
        _leftAdLabel.textAlignment = NSTextAlignmentRight;
        _centerAdLabel.textAlignment = NSTextAlignmentRight;
        _rightAdLabel.textAlignment = NSTextAlignmentRight;
    }
    
}

#pragma mark - 创建pageView,指定其显示样式
- (void)setPageStyle:(UIPageStyle)pageStyle
{
    if (pageStyle == UIPageNoneStyle) {
        return;
    }else if (pageStyle == UIPageControlPointStyle){
        _pageControl = [[UIPageControl alloc]init];
        //_pageControl.backgroundColor = JXMainColor;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.numberOfPages = _imageNameArray.count;
        _pageControl.frame = CGRectMake(0, 0, 20* _imageNameArray.count, 20);
        _pageControl.center = CGPointMake(0, HIGHT+UISCREENHEIGHT - 10);
        _pageControl.currentPage = 0;
        _pageControl.enabled = NO;
        if (self.superview) {
            [[self superview]addSubview:_pageControl];
        }else{
            [self performSelector:@selector(addPageView:) withObject:_pageControl afterDelay:0.1];
        }
        
    }else if(pageStyle == UIPageLabelNumberStyle){
        _pageLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH -30, HIGHT + UISCREENHEIGHT -30, 20, 20)];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.layer.cornerRadius = 10;
        _pageLabel.clipsToBounds = YES;
        _pageLabel.font = [UIFont systemFontOfSize:12.0];
        _pageLabel.adjustsFontSizeToFitWidth = YES;
        _pageLabel.backgroundColor = [UIColor whiteColor];
        _pageLabel.textColor = [UIColor blackColor];
        if (_imageNameArray.count >0) {
            [self setPageLabelText:1];
        }else{
            _pageLabel.hidden = YES;
        }
        if (self.superview) {
            [[self superview]addSubview:_pageLabel];
        }else{
            [self performSelector:@selector(addPageView:) withObject:_pageLabel afterDelay:0.1];
        }
    }
}
- (void)setupTimer
{
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
    _moveTime = timer;
    //    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

//-(void)setupTimer:(dispatch_queue_t)t name:(NSString *)name{
//    dispatch_queue_t ds = dispatch_queue_create(NULL, 0);
//    dispatch_async(t, ^{
//        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
//        _moveTime = timer;
//        [[NSRunLoop currentRunLoop] run];
//    });
//}
//-(void)setupTimer:(dispatch_queue_t)t block:(dispatch_block_t)block{
//    dispatch_async(t, block);
//    dispatch_block_t b = dispatch_block_create(DISPATCH_BLOCK_DETACHED, ^{
//
//    });
//}

-(void)addPageView:(UIView *)view{
    [[self superview] addSubview:view];
}
#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage
{
    
    [self setContentOffset:CGPointMake(UISCREENWIDTH * 2, 0) animated:YES];
    [self performSelector:@selector(scrollViewDidEndDecelerating:) withObject:nil afterDelay:0.4];
    _isTimeUp = YES;
    //    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

#pragma mark - 图片停止时,调用该函数使得滚动视图复用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.isDragging) {
        [self pause];
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self goOn];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //    _pageLabel.text = [NSString stringWithFormat:@"%d",currentImage];
    if (self.contentOffset.x == 0)
    {
        _pageControl.currentPage = (_pageControl.currentPage - 1)%_imageNameArray.count;
        if (currentImage == 1) {//往后到第一张要重置当前图片为最后一张
            currentImage = _imageNameArray.count;
        }else{
            currentImage -= 1;
        }
        //_pageControl.currentPage = currentImage -1;
        [self setPageLabelText:currentImage];
        [self resetImageWithIndex:currentImage forDereact:AdScrollToLeft];
    }
    else if(self.contentOffset.x == UISCREENWIDTH * 2)
    {
        _pageControl.currentPage = (_pageControl.currentPage + 1)%_imageNameArray.count;
        if (currentImage == _imageNameArray.count) {//往前末张要重置当前图片为第一张
            currentImage = 1;
        }else{
            currentImage += 1;
        }
        //_pageControl.currentPage = currentImage -1;
        [self setPageLabelText:currentImage];
        [self resetImageWithIndex:currentImage forDereact:AdScrollToRight];
    }
    else
    {
        //        _pageLabel.text = [NSString stringWithFormat:@"%d",currentImage +1];
        return;
    }
    
//    _leftAdLabel.text = _adTitleArray[(currentImage-1)%_imageNameArray.count];
//    _centerAdLabel.text = _adTitleArray[currentImage%_imageNameArray.count];
//    _rightAdLabel.text = _adTitleArray[(currentImage+1)%_imageNameArray.count];
    
    
    
    
    self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
    
    //手动控制图片滚动应该取消那个三秒的计时器
    if (!_isTimeUp) {
        [self goOn];
    }else{
        _isTimeUp = NO;
    }
    
}
- (void)resetImageWithIndex:(NSInteger )index forDereact:(Dereaction)dereact{
    
    if (index == 1){
        [_leftImageView sd_setImageWithURL:_imageNameArray[_imageNameArray.count -1] placeholderImage:JXImageNamed(@"image_one")];
        [_centerImageView sd_setImageWithURL:_imageNameArray[0] placeholderImage:JXImageNamed(@"image_one")];
        [_rightImageView sd_setImageWithURL:_imageNameArray[1] placeholderImage:JXImageNamed(@"image_one")];
    }else if(index == _imageNameArray.count){
        [_leftImageView sd_setImageWithURL:_imageNameArray[_imageNameArray.count -2] placeholderImage:JXImageNamed(@"image_one")];
        [_centerImageView sd_setImageWithURL:_imageNameArray[_imageNameArray.count -1] placeholderImage:JXImageNamed(@"image_one")];
        [_rightImageView sd_setImageWithURL:_imageNameArray[0] placeholderImage:JXImageNamed(@"image_one")];
    }else{
        [_leftImageView sd_setImageWithURL:_imageNameArray[index -2]  placeholderImage:JXImageNamed(@"image_one")];
        [_centerImageView sd_setImageWithURL:_imageNameArray[index -1] placeholderImage:JXImageNamed(@"image_one")];
        [_rightImageView sd_setImageWithURL:_imageNameArray[index ] placeholderImage:JXImageNamed(@"image_one")];
    }
    
    //    if (dereact == AdScrollToLeft) {
    //        if (currentImage == 1){
    //            x = _imageNameArray.count;
    //        }else{
    //            x = currentImage -1;
    //        }
    //    }else if (dereact == AdScrollToRight){
    //        if (currentImage == _imageNameArray.count){
    //            x = 1;
    //        }else{
    //            x = currentImage +1;
    //        }
    //    }else if (dereact == AdScrollToCenter){
    //
    //    }else{
    //
    //    }
    //    [_leftImageView setImageWithString:_imageNameArray[(currentImage -1)%_imageNameArray.count] placeholderImage:nil];
    //    [_centerImageView setImageWithString:_imageNameArray[(currentImage )%_imageNameArray.count] placeholderImage:nil];
    //    [_rightImageView setImageWithString:_imageNameArray[(currentImage +1)%_imageNameArray.count] placeholderImage:nil];
}
#pragma mark -- adScrollViewTimer
- (void)pause{
    if (_moveTime) {
        [_moveTime setFireDate:[NSDate distantFuture]];
    }
}
- (void)goOn{
    if (_moveTime) {
        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:chageImageTime]];
    }
}
- (void)start{
    if (!_moveTime) {
        [self setupTimer];
    }else{
        [self goOn];
    }
}
- (void)stop{
    if (_moveTime) {
        [_moveTime invalidate];
        _moveTime = nil;
    }
}
#pragma mark -- adScrollViewGesture
- (void)tapClick:(UITapGestureRecognizer *)tap{
    if (!_imageNameArray.count) {
        return;
    }
    NSInteger page = _pageLabel?(_pageLabel.text.integerValue -1):_pageControl.currentPage;
    if ([self.adDelegate respondsToSelector:@selector(adScrollView:clickedViewForPage:)]) {
        [self.adDelegate adScrollView:self clickedViewForPage:page];
    }
    NSLog(@"点击：%ld",(long)page);
}
- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        //长按时，自动滚动计时器永远暂停
        [self pause];
    }else if (longPress.state == UIGestureRecognizerStateChanged){
    }else if (longPress.state == UIGestureRecognizerStateEnded || longPress.state == UIGestureRecognizerStateCancelled){
        //松开时，计时器延时后继续开始
        [self goOn];
    }
}

- (void)setPageLabelText:(NSInteger)page{
    if (!_pageLabel) {
        return;
    }
    _pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)page,(long)_imageNameArray.count];
    //设置特殊颜色
    NSInteger length = [NSString stringWithFormat:@"%ld", (long)page].length;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_pageLabel.text];
    [attributedString addAttribute:NSForegroundColorAttributeName value:JXColorFromRGB(0xfc5860) range:NSMakeRange(0,length)];
    _pageLabel.attributedText = attributedString;
}

@end

