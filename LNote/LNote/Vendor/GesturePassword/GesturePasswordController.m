//
//  GesturePasswordController.m
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

#import <Security/Security.h>
#import <CoreFoundation/CoreFoundation.h>

#import "GesturePasswordController.h"

#import "KeychainItemWrapper/KeychainItemWrapper.h"

NSString *const GesturePasswordFinishNotification=@"GesturePasswordFinishNotification";

@interface GesturePasswordController ()

@property (nonatomic,strong) GesturePasswordView * gesturePasswordView;
@property (nonatomic,strong) UIButton *closeBtn;
@end

@implementation GesturePasswordController {
    NSString * previousString;
    NSString * password;
}

@synthesize gesturePasswordView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    previousString = [NSString string];
    KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
    password = [keychin objectForKey:(__bridge id)kSecValueData];

    if(_isLaunch)
    {
        [self launch];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)launch
{
    if ([password isEqualToString:@""] || password==nil) {
        
        [self reset:YES];
    }
    else {
        [self verify];
    }
}
#pragma -mark 验证手势密码
- (void)verify{
    if(gesturePasswordView)
    {
        [gesturePasswordView removeFromSuperview];
        gesturePasswordView=nil;
    }
    gesturePasswordView = [[GesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [gesturePasswordView.tentacleView setRerificationDelegate:self];
    [gesturePasswordView.tentacleView setStyle:1];
    [gesturePasswordView setGesturePasswordDelegate:self];
    gesturePasswordView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:gesturePasswordView];
}

#pragma -mark 重置手势密码
- (void)reset:(BOOL)isLaunch
{
    if(gesturePasswordView)
    {
        [gesturePasswordView removeFromSuperview];
        gesturePasswordView=nil;
    }
    
    gesturePasswordView = [[GesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [gesturePasswordView.tentacleView setResetDelegate:self];
    [gesturePasswordView.tentacleView setStyle:2];
    [gesturePasswordView.forgetButton setHidden:YES];
    [gesturePasswordView.changeButton setHidden:YES];
    [self.view addSubview:gesturePasswordView];
    if(isLaunch)
    {
        self.closeBtn.hidden=YES;
    }else
    {
        self.closeBtn.hidden=NO;
    }
}

#pragma -mark 清空记录
- (void)clear{
    KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
    [keychin resetKeychainItem];
}

#pragma -mark 改变手势密码
- (void)change{
   
}

#pragma -mark 忘记手势密码
- (void)forget{
    if(gesturePasswordView)
    {
        [gesturePasswordView removeFromSuperview];
        gesturePasswordView=nil;
    }
    gesturePasswordView = [[GesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [gesturePasswordView.tentacleView setResetDelegate:self];
    [gesturePasswordView.tentacleView setStyle:2];
    [gesturePasswordView.forgetButton setHidden:NO];
    [gesturePasswordView.forgetButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [gesturePasswordView.forgetButton setTitle:@"重 置" forState:UIControlStateNormal];
    [gesturePasswordView.changeButton setHidden:YES];
    [self.view addSubview:gesturePasswordView];
    [self clear];
}

- (BOOL)verification:(NSString *)result{
    if ([result isEqualToString:password]) {
        [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        [gesturePasswordView.state setText:@"输入正确"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:GesturePasswordFinishNotification object:nil];
        
        //[self presentViewController:(UIViewController) animated:YES completion:nil];
        return YES;
    }
    [gesturePasswordView.state setTextColor:[UIColor redColor]];
    [gesturePasswordView.state setText:@"手势密码错误"];
    return NO;
}

- (BOOL)resetPassword:(NSString *)result{
    if ([previousString isEqualToString:@""]) {
        previousString=result;
        [gesturePasswordView.tentacleView enterArgin];
        [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        [gesturePasswordView.state setText:@"请验证输入密码"];
        return YES;
    }
    else {
        if ([result isEqualToString:previousString]) {
            KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
            [keychin setObject:@"<帐号>" forKey:(__bridge id)kSecAttrAccount];
            [keychin setObject:result forKey:(__bridge id)kSecValueData];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:GesturePasswordFinishNotification object:nil];
            
            if(_changeFinish)
            {
                _changeFinish(YES);
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
            [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
            [gesturePasswordView.state setText:@"已保存手势密码"];
            
            return YES;
        }
        else{
            previousString =@"";
            [gesturePasswordView.state setTextColor:[UIColor redColor]];
            [gesturePasswordView.state setText:@"两次密码不一致，请重新输入"];
            return NO;
        }
    }
    
}


-(UIButton *)closeBtn
{
    if(!_closeBtn)
    {
        _closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(20,StatueBarHeight+10,30,30)];
        [_closeBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_closeBtn setTitle:@"X" forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchDown];
        _closeBtn.hidden=YES;
        [self.view addSubview:_closeBtn];
    }
    return _closeBtn;
}

-(void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
