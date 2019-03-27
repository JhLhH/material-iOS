//
//  AppDelegate.m
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/3.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "WYALoginViewController.h"
#import "WYAMaterialViewController.h"
#import "WYALoginViewModel.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [WXApi registerApp:@"wx808acd6db9965c72"];
    [Bugly startWithAppId:@"209aebc96b"];

    self.window                 = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    WYALoginViewController * login = [[WYALoginViewController alloc]init];
    RootViewController * rootViewController = [[RootViewController alloc] init];
    self.window.rootViewController          = rootViewController;
    [self.window makeKeyAndVisible];
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

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark ======= WXApiDelegate
- (void)onReq:(BaseReq *)req {
    NSLog(@"req==%@", req);
}

- (void)onResp:(BaseResp *)resp {
    NSLog(@"resp==%@", resp);
    SendAuthResp * sendResp = (SendAuthResp *)resp;
    WYAUserDefaultObjectForKey(sendResp.code);
    [WYALoginViewModel loginWithCode:sendResp.code success:^(id data) {
        NSLog(@"data==%@",data);
        if ([[data[@"status"] stringValue] isEqualToString:@"1"]) {
            [UIView wya_showCenterToastWithMessage:data[@"msg"]];
            NSDictionary * dic = data[@"data"];
            WYAUserDefaultSetObjectForKey(dic[@"access_token"], @"access_token");
            RootViewController * rootViewController = [[RootViewController alloc] init];
            Window.rootViewController = rootViewController;
        }
    } fail:^(NSString *errorDes) {
        NSLog(@"errorDes==%@",errorDes);
    }];
}

#pragma mark ======= Private Method
- (void)getData {
    // 先判断本地是否有access_token,如果有把token上传至后台，然后根据返回值进行操作

    if (WYAUserDefaultObjectForKey(@"access_token")) {
        // 上传至后台

    } else {
        // 需要用户去授权登录，将获取的code上传至后台，后台返回access_token保存至本地
    }
}
@end
