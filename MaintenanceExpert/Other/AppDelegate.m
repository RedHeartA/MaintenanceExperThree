//
//  AppDelegate.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "AppDelegate.h"

#import "ZSTabBarController.h"
#import "ZSNavigationController.h"
#import "ZSLoginViewController.h"
#import "FYHGuidePageVC.h"
#import <SMS_SDK/SMSSDK.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"


/**
 *
 *   SMSSDK 的appkey AND secret
 */
#define appkey @"193803994e67e"
#define app_secrect @"3eaf0099d54d6fe3f27052cfa849dc5b"

@interface AppDelegate ()
{
    NSMutableArray *picArr;//启动图VC:图片 Arr 设置
    
}


@end

@implementation AppDelegate


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
    return UIInterfaceOrientationMaskPortrait;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    [AMapServices sharedServices].apiKey = @GaodeAPIKey;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ZSLoginViewController *login = [[ZSLoginViewController alloc]init];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefault objectForKey:@"username"];
    
    /**
     *  登录状态判定
     */
    if (username == nil) {
        
        [self createUI];
//        ZSNavigationController *nav = [[ZSNavigationController alloc]initWithRootViewController:login];
//        
//        self.window.rootViewController = nav;
        
    }else {
        ZSTabBarController *tabBarvc = [[ZSTabBarController alloc]init];
        
        ZSNavigationController *nav = [[ZSNavigationController alloc]initWithRootViewController:tabBarvc];
        
        self.window.rootViewController = nav;
    }
    
    /**
     *  对SMSSDK进行授权关联
     */
    [SMSSDK registerApp:appkey
             withSecret:app_secrect];
    
    [ShareSDK registerApp:@"1958e7c42f7e4"
          activePlatforms:@[
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         default:
                             break;
                     }
                 } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                                   appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                             break;
                         case SSDKPlatformTypeQQ:
                             [appInfo SSDKSetupQQByAppId:@"1105770265"
                                                  appKey:@"KEYF1Fop4PeqVRvMsyX"
                                                authType:SSDKAuthTypeBoth];
                             break;
                         default:
                             break;
                     }
                 }];    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)createUI {
    
    
    
    picArr = @[
               [UIImage imageNamed:@"loading-1.1"],
               [UIImage imageNamed:@"loading-2.2"],
               [UIImage imageNamed:@"loading-3.3"],
               ].mutableCopy;
    [[FYHGuidePageVC sharedGuideVC] fyhGuidePageWithPicArr:picArr];
    FYHGuidePageVC *guidePageVC = [FYHGuidePageVC sharedGuideVC];

    
    _window.rootViewController = guidePageVC;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
