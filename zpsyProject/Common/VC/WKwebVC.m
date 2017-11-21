//
//  WKwebVC.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/9.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "WKwebVC.h"
#import <WebKit/WebKit.h>
@interface WKwebVC ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate>{
    
}
@property(nonatomic,strong)WKWebView *webView;
@property(nonatomic,strong)UIProgressView *progressView;
@end

@implementation WKwebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackBtn];
    [self setKVO];
    [self reloadWeb];

}

#pragma reload webview

-(void)reloadWeb{
    
    if (_IsrequestFile) {
        
        if ([_pathStr containsString:@"."]) {
            
            NSArray *arr = [_pathStr componentsSeparatedByString:@"."];
            NSString *type = arr[arr.count-1];
            __block NSString *source = @"";
            NSMutableString *name = [[NSMutableString alloc] init];
            [arr enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx != arr.count -1) {
                    [name appendString:obj];
                    [name appendString:@"."];
                }else{
                    source=[name substringToIndex:name.length -1];
                }
            }];
            
            NSURL *path = [[NSBundle mainBundle] URLForResource:source withExtension:type];
            NSURLRequest *request=[NSURLRequest requestWithURL:path];
            [self.webView loadRequest:request];
        }

        
    }else{
        NSURL *url = [NSURL URLWithString:_URLstr];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [self.webView loadRequest:request];
    }
}

#pragma 交互
#pragma mark - WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    //这里可以通过name处理多组交互
    if ([message.name isEqualToString:@"getNavigationBarInfo"]) {
        //body只支持NSNumber, NSString, NSDate, NSArray,NSDictionary 和 NSNull类型
        NSDictionary *dict = message.body;
        NSString *titleStr = [dict objectForKey:@"pageTitle"];
        self.title = titleStr;
    }
    
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler{
    //NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        // 对于跨域，需要手动跳转
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        // 不允许web内跳转
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        self.progressView.alpha = 1.0;
        decisionHandler(WKNavigationActionPolicyAllow);
    }
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
        
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, kNavStatusHeight, kScreenWidth, kScreenHeight - kNavStatusHeight) configuration:config];
        self.webView.navigationDelegate = self;
        self.webView.UIDelegate = self;
        self.webView.scrollView.contentOffset = CGPointMake(0, 0);
        [self.view addSubview:_webView];
        [self userAgent];
        [_webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            NSLog(@"%@",result);
        }];
    }
    return _webView;
}

-(UIProgressView *)progressView{

    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, kNavStatusHeight, kScreenWidth,5)];
        _progressView.tintColor = JXMainColor;
        _progressView.trackTintColor = [UIColor whiteColor];
        [self.view addSubview:_progressView];
        [self.view bringSubviewToFront:_progressView];
    }
    return _progressView;
}

-(void)userAgent{
    
    UIWebView *webViews = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSString *userAgent = [webViews stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    if (![userAgent containsString:@"platformParams="]) {
        
        NSDictionary * dict = @{@"platform":@"ios",@"version":[CTUtility getAppVersion]};
        NSString * str = [dict mj_JSONString];
        NSString *newUserAgent = [userAgent stringByAppendingString:[NSString stringWithFormat:@"platformParams=%@",str]];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    }
}
#pragma SET

-(void)setURLstr:(NSString *)URLstr{
    _URLstr=URLstr;
//    _URLstr=[Utility urlEncode:URLstr];
}

-(void)setPathStr:(NSString *)pathStr{
    _pathStr=pathStr;
}

-(void)setKVO{
    [self.webView addObserver:self
                   forKeyPath:@"loading"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    [self.webView addObserver:self
                   forKeyPath:@"title"
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
        
    } else if ([keyPath isEqualToString:@"title"])
    {
        self.title = self.webView.title;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{

    [self.webView removeObserver:self forKeyPath:@"loading"];//移除kvo
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];

}

-(void)setBackBtn{

    UIImage *backButtonTheme = [UIImage imageNamed:@"nav_return"];
    backButtonTheme = [backButtonTheme imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backButtom = [[UIBarButtonItem alloc] initWithImage:backButtonTheme style:UIBarButtonItemStyleDone target:self action:@selector(goback)];
    self.navigationItem.leftBarButtonItem = backButtom;
}

-(void)goback{

    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
