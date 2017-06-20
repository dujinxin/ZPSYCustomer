//
//  ExposureDetailView.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/28.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "ExposureDetailView.h"
#import <WebKit/WebKit.h>
@interface ExposureDetailView ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property(nonatomic, strong)WKWebView      *webView;
@property(nonatomic, strong)UIProgressView *progressView;

@end



@implementation ExposureDetailView

-(instancetype)init{
    self=[super init];
    if (self) {
        [self viewinit];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame: frame];
    if (self) {
        [self viewinit];
    }
    return self;
}

-(void)viewinit{
    [self addSubview:self.webView];
    [self setKVO];
}


#pragma SET
-(void)setUrlStr:(NSString *)UrlStr{
    _UrlStr=UrlStr;
    NSURL *url=[NSURL URLWithString:_UrlStr];
    NSURLRequest *quest=[[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:quest];
}



#pragma 交互
#pragma mark - WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    //这里可以通过name处理多组交互
    if ([message.name isEqualToString:@"getNavigationBarInfo"]) {
        //body只支持NSNumber, NSString, NSDate, NSArray,NSDictionary 和 NSNull类型
        NSDictionary *dict = message.body;
        NSString *titleStr = [dict objectForKey:@"pageTitle"];
        if (titleStr) {
            [CTUtility findViewController:self].title = titleStr;
        }
    }
    
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *hostname = navigationAction.request.URL.host;
    NSString *schemename = navigationAction.request.URL.scheme;
    
    if (schemename && [schemename isEqualToString:@"zpsy"]) {
        BLOCK_SAFE(self.enventDoBlock)(hostname);
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    self.progressView.alpha = 1.0;
    decisionHandler(WKNavigationActionPolicyAllow);
    
//    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
//        // 对于跨域，需要手动跳转
//        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
//        // 不允许web内跳转
//        decisionHandler(WKNavigationActionPolicyCancel);
//    } else {
//        self.progressView.alpha = 1.0;
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
}

//在响应完成时，调用的方法。如果设置为不允许响应，web内容就不会传过来
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
//接收到服务器跳转请求之后调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

#pragma GET
-(WKWebView *)webView{
    
    if (!_webView) {
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        //初始化偏好设置属性：preferences
        config.preferences = [WKPreferences new];
        //The minimum font size in points default is 0;
        config.preferences.minimumFontSize = 10;
        //是否支持JavaScript
        config.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        //通过JS与webView内容交互
        config.userContentController = [WKUserContentController new];
        // 注入JS对象名称senderModel，当JS通过senderModel来调用时，我们可以在WKScriptMessageHandler代理中接收到
        [config.userContentController addScriptMessageHandler:self name:@"getNavigationBarInfo"];
        
        [self userAgent];
        
        _webView = [[WKWebView alloc]initWithFrame:self.bounds configuration:config];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        [_webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            NSLog(@"%@",result);
        }];
    }
    return _webView;
}
-(UIProgressView *)progressView{
    
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth,5)];
        _progressView.tintColor = [UIColor greenColor];
        _progressView.trackTintColor = [UIColor whiteColor];
        [self addSubview:_progressView];
        [self bringSubviewToFront:_progressView];
    }
    return _progressView;
}

-(void)userAgent{

    UIWebView *webViews = [[UIWebView alloc] initWithFrame:self.bounds];
    NSString *userAgent = [webViews stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    if (![userAgent containsString:@"platformParams="]) {
        
        NSDictionary * dict = @{@"platform":@"ios",@"version":[CTUtility getAppVersion]};
        NSString * str = [dict mj_JSONString];
        NSString *newUserAgent = [userAgent stringByAppendingString:[NSString stringWithFormat:@"platformParams=%@",str]];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    }
}

-(void)setKVO{
    [self.webView addObserver:self
                   forKeyPath:@"loading"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"loading"])
    {
        NSLog(@"loading");
        
    } else if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        self.progressView.progress = self.webView.estimatedProgress;
    }
    
    // 加载完成
    if (!self.webView.loading)
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.progressView.alpha = 0.0;
        }];
    }
}
-(void)dealloc{
    
    [self.webView removeObserver:self forKeyPath:@"loading"];//移除kvo
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}


@end
