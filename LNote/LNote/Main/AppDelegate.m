//
//  AppDelegate.m
//  LNote
//


#import "AppDelegate.h"
#import "MainViewController.h"
#import "ICLanguageTool.h"
#import "GesturePasswordController.h"
@interface AppDelegate ()
@property(nonatomic,strong)MainViewController *mainVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [ICLanguageTool sharedInstance];
    
    //add Gesture before mainView
    GesturePasswordController *ges=[[GesturePasswordController alloc] init];
    ges.isLaunch=YES;
    
    self.window.rootViewController = ges;
    
    [self.window makeKeyAndVisible];
    
    [self setUpFixiOS11]; //适配IOS 11

    [self registNotification];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(MainViewController *)mainVC
{
    if(!_mainVC)
    {
        _mainVC=[[MainViewController alloc] init];
    }
    return _mainVC;
}
#pragma mark - FixiOS11
- (void)setUpFixiOS11
{
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
}
#pragma mark - Notification

-(void)registNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"RDNotificationLanguageChanged" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gestureFinishNotification:) name:GesturePasswordFinishNotification object:nil];
    
}

-(void)gestureFinishNotification:(NSNotification *)notifi
{
    self.window.rootViewController = self.mainVC;
}

-(void)changeLanguage
{
    if(_mainVC)
    {
        [_mainVC.view removeFromSuperview];
        _mainVC=nil;
    }
    self.window.rootViewController = self.mainVC;
}


@end
