//
//  JSCallOCViewController.m
//  webviewDemo
//
//  Created by jikaipeng on 2017/8/31.
//  Copyright © 2017年 kuxuan. All rights reserved.
//

#import "JSCallOCViewController.h"
#import "JavaScriptModel.h"
#define kScreenWidth                [UIScreen mainScreen].bounds.size.width
#define kScreenHeight               [UIScreen mainScreen].bounds.size.height

/*
 JavaScriptCore这个框架是iOS7之后苹果推出的，方便了开发者的使用，让web页面和iOS本地原生应用交互起来更加简单。
 */
@interface JSCallOCViewController ()<UIWebViewDelegate,jSObjectdelegate>

@property (nonatomic, strong) UIWebView *webview;

@property (nonatomic, strong) JSContext *context;

@end

@implementation JSCallOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    //  配置webview
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    //如果网页不是响应式布局，需要调用这个方法
//    self.webview.scalesPageToFit = YES;
    //设置代理
    self.webview.delegate = self;
    //获取当前页面的title
    NSString *title = [self.webview stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;

//    //获取当前页面的url
//    NSString *url = [self.webview stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    //是否响应电话等信息
    self.webview.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
    // 加载本地网页 方法1
    NSURL *htmlUrl = [[NSBundle mainBundle] URLForResource:@"JavaScriptCore.html" withExtension:nil];
    [self.webview loadRequest:[NSURLRequest requestWithURL:htmlUrl]];
    
    //加载网络请求
    //    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    //    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:self.webview];
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    if (navigationType == UIWebViewNavigationTypeBackForward) {
//        [_webview canGoBack]?[_webview goBack]:[self.navigationController popViewControllerAnimated:YES];
//    }
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    //[self.hud showAnimated:YES];
    NSLog(@"开始加载");
}

/**
    JavaScriptCore中web页面调用原生应用的方法可以用Delegate或Block两种方法。
    JSContext：给JavaScript提供运行的上下文环境
    JSValue：JavaScript和Objective-C数据和方法的桥梁
    JSExport：协议，如果采用协议的方法交互，自己定义的协议必须遵守此协议
 **/


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 捕捉异常回调
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        NSLog(@"异常信息:%@",exception);
    };
    
    //  通过JSExport协议关联Native的方法
    self.context[@"Native"] = self;
    
    
//    // 通过block形式关联javascript的函数
//    __weak typeof(self) weakSelf = self;
//    
//    self.context[@"deliverValue"] = ^(NSString *message)
//    {
//        __strong typeof(self) strongSelf = weakSelf;
//        dispatch_async(dispatch_get_main_queue(), ^{
//           
//            UIAlertController *alertcontrol = [UIAlertController alertControllerWithTitle:@"这是一则消息" message:message preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *cacelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                
//            }];
//            UIAlertAction *quxiaolAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//                
//            }];
//            [alertcontrol addAction:cacelAction];
//            [alertcontrol addAction:quxiaolAction];
//            [strongSelf.navigationController presentViewController:alertcontrol animated:YES completion:^{
//                
//            }];
//        });
//    };
}

// webview加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    //[self.hud hideAnimated:YES];
    
    NSLog(@"加载失败");
    
}

#pragma mark - JSExport Methods

- (void)callme:(NSString *)string
{
    NSLog(@"%@",string);
    
}

- (void)share:(NSString *)shareUrl
{
    NSLog(@"分享的url=%@",shareUrl);
    JSValue *shareCallBack = self.context[@"shareCallBack"];
    [shareCallBack callWithArguments:nil];
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
