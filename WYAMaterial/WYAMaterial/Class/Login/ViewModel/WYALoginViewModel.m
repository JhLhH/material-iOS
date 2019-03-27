//
//  WYALoginViewModel.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYALoginViewModel.h"

@implementation WYALoginViewModel

+ (void)loginWithCode:(NSString *)code success:(Success)success fail:(Fail)fail {

    NSString * sysVersion = [[UIDevice currentDevice] systemVersion];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSString * string = @"https://gateway.wyawds.com/api/material-app/login.json";
    [WYALoginViewModel PostWithUrl:string headerParams:@{@"version" : appVersion, @"platform" : [NSString stringWithFormat:@"ios%@",sysVersion]} params:@{@"code" : code} success:^(id data) {
        success(data);
    } fail:^(NSString *errorDes) {
        fail(errorDes);
    }];
}

@end
