//
//  Scanview.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/6.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "Scanview.h"
#import <AVFoundation/AVFoundation.h>
#import <Endian.h>

#if !TARGET_IPHONE_SIMULATOR
#import "gmyDecoder.h"
static const CGFloat kScanW=250;
static const CGFloat kScanH=250;

@interface Scanview ()<AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,AVCaptureVideoDataOutputSampleBufferDelegate,DecodeMessageDelegate>{
    gmyDecoder *mDecoder;//GM解析
    SystemSoundID soundID;
}

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, weak)   UIView *maskView;
@property (nonatomic, strong) UIView *scanWindow;
@end
#endif

@implementation Scanview

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
#if !TARGET_IPHONE_SIMULATOR
        mDecoder = [[gmyDecoder alloc] init:self];
        //遮罩
        [self setupMaskView];
        //音频
        [self systemSoundIdInit];
        //扫描动画
        [self setupScanWindowView];
        //扫描设置
        [self beginScanning];
#endif
    }
    return self;
}
#if !TARGET_IPHONE_SIMULATOR
- (void)beginScanning
{
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!input) return;
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置有效扫描区域
    CGRect scanCrop=[self getScanCrop:_scanWindow.bounds readerViewBounds:self.frame];
    output.rectOfInterest = scanCrop;
    //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [_session addInput:input];
    [_session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    //GM  === Start
    AVCaptureVideoDataOutput *avCaptureVideoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    
    NSDictionary *settings = [[NSDictionary alloc] initWithObjectsAndKeys:
                              [NSNumber numberWithUnsignedInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange], kCVPixelBufferPixelFormatTypeKey,
                              nil];
    
    avCaptureVideoDataOutput.videoSettings = settings;
    dispatch_queue_t queue = dispatch_queue_create("org.doubango.idoubs", NULL);
    [avCaptureVideoDataOutput setSampleBufferDelegate:self queue:queue];
    
    [_session addOutput:avCaptureVideoDataOutput];
    
    //GM  === END
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.layer.bounds;
    [self.layer insertSublayer:layer atIndex:0];
    //开始捕获
//    self.StartScaning=YES;
}
- (void)setupScanWindowView
{
    _scanWindow = [[UIView alloc] initWithFrame:CGRectMake((self.width-kWidth_fit(kScanW))/2, (self.height-kWidth_fit(kScanH))/2, kWidth_fit(kScanW), kWidth_fit(kScanH))];
    _scanWindow.clipsToBounds = YES;
//    _scanWindow.backgroundColor=[UIColor redColor];
    [self addSubview:_scanWindow];
    
//    _scanNetImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_net"]];
//    CGFloat buttonWH = 18;
    
    UIImageView *imageTopLeft=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_1"]];
    UIImageView *imageTopRight=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_2"]];
    UIImageView *imageBottomLeft=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_3"]];
    UIImageView *imageBottomRight=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_4"]];
    
    CGFloat w=18;
    imageTopLeft.frame=CGRectMake(0, 0, w, w);
    imageTopRight.frame=CGRectMake(kWidth_fit(kScanW)-w, 0, w, w);
    imageBottomLeft.frame=CGRectMake(0, kWidth_fit(kScanH)-w, w, w);
    imageBottomRight.frame=CGRectMake(kWidth_fit(kScanW)-w, kWidth_fit(kScanH)-w, w, w);
    
    [_scanWindow addSubview:imageTopLeft];
    [_scanWindow addSubview:imageTopRight];
    [_scanWindow addSubview:imageBottomLeft];
    [_scanWindow addSubview:imageBottomRight];
    
}
-(void)systemSoundIdInit{

    NSURL *filePath   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);

}
#pragma mark-> 获取扫描区域的比例关系
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    
    CGFloat x,y,width,height;
    
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    
    return CGRectMake(x, y, width, height);
}
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        [_session stopRunning];
        AudioServicesPlaySystemSound(soundID);
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        if (metadataObject.type==AVMetadataObjectTypeQRCode) {
            BLOCK_SAFE(_scanResultBlock)(metadataObject.stringValue,ScanTypeQRCode);
        }else if (metadataObject.type==AVMetadataObjectTypeCode128Code || metadataObject.type==AVMetadataObjectTypeEAN8Code || metadataObject.type==AVMetadataObjectTypeEAN13Code){
            BLOCK_SAFE(_scanResultBlock)(metadataObject.stringValue,ScanTypeBarCode);
        }else{
            BLOCK_SAFE(_scanResultBlock)(metadataObject.stringValue,ScanTypeOther);
        }
    }
}


#pragma 闪光灯
-(void)setOpenStrobeLight:(BOOL)OpenStrobeLight{
    _OpenStrobeLight=OpenStrobeLight;
    [self turnTorchOn:_OpenStrobeLight];
}

- (void)turnTorchOn:(BOOL)on
{
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}

#pragma 扫描
-(void)setStartScaning:(BOOL)StartScaning{
    _StartScaning = StartScaning;
    if(_StartScaning){
        [_session startRunning];
    }else{
        [_session stopRunning];
    }
}
#pragma 遮罩
- (void)setupMaskView
{
    UIBezierPath * path= [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.width, self.height)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    [path appendPath:[UIBezierPath bezierPathWithRect:CGRectMake((self.width-kWidth_fit(kScanW))/2, (self.height-kWidth_fit(kScanH))/2, kWidth_fit(kScanW), kWidth_fit(kScanH))]];
    [path setUsesEvenOddFillRule:YES];
    layer.path = path.CGPath;
    layer.fillRule = kCAFillRuleEvenOdd;
    layer.fillColor = [[UIColor blackColor] CGColor];
    layer.opacity = 0.5;
    [self.layer addSublayer:layer];
}


#pragma mark-> 我的相册
-(void)OpenImagePicker{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        //1.初始化相册拾取器
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        controller.delegate = self;
        
        //4.随便给他一个转场动画
        controller.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        [[CTUtility findViewController:self] presentViewController:controller animated:YES completion:nil];
        
    }else{
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [[CTUtility findViewController:self] presentViewController:alert animated:YES completion:nil];
    }
    
}
#pragma mark-> imagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //1.获取选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //2.初始化一个监测器
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        //监测到的结果数组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        if (features.count >=1) {
            /**结果对象 */
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            BLOCK_SAFE(_scanResultBlock)(scannedResult,ScanTypeQRCode);
            
        }
        else{
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"该图片没有包含一个二维码！" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [[CTUtility findViewController:self] presentViewController:alert animated:YES completion:nil];
        }
        
        
    }];
    
    
}



//#pragma mark -捕捉页面
#pragma mark AVCaptureVideoDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    //捕捉数据输出
    
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    int width = (int)(CVPixelBufferGetWidth(imageBuffer));
    int height = (int)(CVPixelBufferGetHeight(imageBuffer));
    CVPlanarPixelBufferInfo_YCbCrBiPlanar *info = (CVPlanarPixelBufferInfo_YCbCrBiPlanar *)baseAddress;
    int Yoffset = EndianU32_BtoN(info->componentInfoY.offset);
    uint8_t *YBuffer = baseAddress+Yoffset;
    
    CGRect scanRect=_scanWindow.frame;
    int l, t, r, b;
    
    l = scanRect.origin.y*width/self.frame.size.height;
    t = scanRect.origin.x*height/self.frame.size.width;
    r = (scanRect.origin.y+scanRect.size.height)*width/self.frame.size.height;
    b = (scanRect.origin.x+scanRect.size.width)*height/self.frame.size.width;
    
    int ret = [mDecoder gray_image_decode:YBuffer width:width height:height left:l top:t right:r bottom:b];
    
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    if (ret>0){
        [_session stopRunning];
    }
}

-(bool) messageHandling:(int)msg_id Data:(NSString *)data
{
    if (msg_id==GMY_DECODE_FAIL)
    {
        //NSLog(@"解码失败");
        return true;
    }
    if (msg_id==GMY_REQUESTING_SERVER_DATA)
    {
        AudioServicesPlaySystemSound(soundID);
        return true;
    }
    if (msg_id==GMY_REQUEST_SERVER_DATA_FAIL)
    {
        BLOCK_SAFE(_scanResultBlock)(data,ScanTypeFalse);
        //NSLog(@"解码成功，但获取服务器数据失败");
        return true;
    }
    if (msg_id==GMY_REQUEST_SERVER_DATA_SUCCESS)
    {
        BLOCK_SAFE(_scanResultBlock)(data,ScanTypeGmCode);
        //NSLog(@"解码成功");

        return true;
    }
    
    return true;
}


#endif

@end
