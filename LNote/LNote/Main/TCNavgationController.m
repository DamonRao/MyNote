//
//  TCNavgationController.m
//
//  Created by jianqRRL on 2019/6/19.
//  Copyright © 2019年 JoonSheng. All rights reserved.
//

#import "TCNavgationController.h"

@interface TCNavgationController ()

@end

@implementation TCNavgationController

#pragma mark - load初始化一次
+ (void)load
{
    [self setUpBase];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
#pragma mark - 初始化
+ (void)setUpBase
{
    //改变系统的导航栏
    UINavigationBar * navBar = [UINavigationBar appearance];

    //导航栏背影色
    [navBar setBarTintColor:[UIColor colorWithRed:253/255.0 green:164/255.0 blue:42/255.0 alpha:1]];
    
    //导航栏返回条颜色
    navBar.tintColor = [UIColor whiteColor];
    
    
    //设置导航栏字体
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                      NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:20]}];
    //设置BarButtonItem的主题
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    
    NSMutableDictionary * itemAttrys = [NSMutableDictionary dictionary];
    
    itemAttrys[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    [item setTitleTextAttributes:itemAttrys forState:UIControlStateNormal];
    
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
