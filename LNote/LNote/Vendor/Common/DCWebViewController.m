//
//  DCWebViewController.m
//  CDDStoreDemo
//
//  Created by jianqRRL on 2019/4/23.
//  Copyright © 2019年 RocketsChen. All rights reserved.
//

#import "DCWebViewController.h"
#import "UIWebView+DKProgress.h"
#import "DKProgressLayer.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width


@interface DCWebViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;

@end

@implementation DCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBarHidden=YES;
    
    
    // Do any additional setup after loading the view.
    UIWebView *webview=[[UIWebView alloc] initWithFrame:self.view.bounds];
    webview.delegate=self;
    webview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:webview];
    
    _webView=webview;

 
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    if(_urlString.length>0)
    {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
    }

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];//设置状态栏字体颜色为白色
}
-(void)loadwebViewPorgress
{
    self.webView.dk_progressLayer = [[DKProgressLayer alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 2)];
    
    self.webView.dk_progressLayer.progressColor = [self colorWithHexString:@"#4285f4"];
    
    self.webView.dk_progressLayer.progressStyle = DKProgressStyle_Gradual;
    
    [self.navigationController.navigationBar.layer addSublayer:self.webView.dk_progressLayer];
}
- (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
    
    //    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//     [_HUD hide:YES];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//     [_HUD hide:YES];
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
