//
//  WYALoginViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYALoginViewController.h"
#import "RootViewController.h"

#import "WYAReviewLoginView.h"
#import "WYALoginView.h"

#import "WXApi.h"


@interface WYALoginViewController ()
@property (nonatomic, strong) WYAReviewLoginView * reviewLoginView;
@property (nonatomic, strong) WYALoginView * loginView;
@end

@implementation WYALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupUI];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark ======= Private Method
- (void)setupUI {
    self.navBar.hidden    = YES;
//    if (<#condition#>) {
        // 当前是在审核状态
//        [self.view addSubview:self.reviewLoginView];
//    } else {
        [self.view addSubview:self.loginView];
//    }
}

- (void)reviewLogin{
    RootViewController * rootViewController = [[RootViewController alloc] init];
    Window.rootViewController = rootViewController;
}

- (void)loginClick{
    BOOL isSuccess = [WXApi isWXAppInstalled];
    if (isSuccess == YES) {
        SendAuthReq * req = [[SendAuthReq alloc] init];
        req.openID        = @"wx808acd6db9965c72";
        req.scope         = @"snsapi_userinfo";
        req.state         = @"123";
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendReq:req];
    } else {
        WYAAlertController * alert =
        [WYAAlertController wya_alertWithTitle:@"您没有安装微信，请安装后登录"
                                       Message:nil
                              AlertLayoutStyle:WYAAlertLayoutStyleHorizontal];
        alert.backgroundButton.enabled = NO;
        alert.presentStyle             = WYAPopupPresentStyleBounce;
        alert.dismissStyle             = WYAPopupDismissStyleShrink;
        // 创建 action
        WYAAlertAction * defaultAction =
        [WYAAlertAction wya_actionWithTitle:@"确定"
                                      style:WYAAlertActionStyleDefault
                                    handler:^{

                                    }];
        [alert wya_addAction:defaultAction];

        [self presentViewController:alert animated:YES completion:nil];
    }


}

#pragma mark ======= Getter
- (WYAReviewLoginView *)reviewLoginView{
    if(!_reviewLoginView){
        _reviewLoginView = ({
            CGFloat reviewLoginView_x = 0;
            CGFloat reviewLoginView_y = 0;
            CGFloat reviewLoginView_width = self.view.cmam_width;
            CGFloat reviewLoginView_height = self.view.cmam_height;
            CGRect reviewLoginView_rect = CGRectMake(reviewLoginView_x, reviewLoginView_y,  reviewLoginView_width, reviewLoginView_height);
            WYAReviewLoginView * object = [[WYAReviewLoginView alloc]init];
            object.frame = reviewLoginView_rect;
            object.loginBlock = ^{
                [self reviewLogin];
            };
            object;
       });
    }
    return _reviewLoginView;
}

- (WYALoginView *)loginView{
    if(!_loginView){
        _loginView = ({
            CGFloat object_x = 0;
            CGFloat object_y = 0;
            CGFloat object_width = self.view.cmam_width;
            CGFloat object_height = self.view.cmam_height;
            CGRect object_rect = CGRectMake(object_x, object_y,  object_width, object_height);
            WYALoginView * object = [[WYALoginView alloc]init];
            object.frame = object_rect;
            object.loginBlock = ^{
                [self loginClick];
            };
            object;
       });
    }
    return _loginView;
}
@end
