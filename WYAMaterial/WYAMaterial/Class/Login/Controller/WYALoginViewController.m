//
//  WYALoginViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYALoginViewController.h"
#import "WXApi.h"
@interface WYALoginViewController ()

@end

@implementation WYALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupUI];


}

#pragma mark ======= Private Method
- (void)setupUI{
    self.navBar.hidden = YES;
    CGFloat object_x = (ScreenWidth - 100 * SizeAdapter) / 2;
    CGFloat object_y = (ScreenHeight - 100 * SizeAdapter) / 2;
    CGFloat object_width = 100 * SizeAdapter;
    CGFloat object_height = 100 * SizeAdapter;
    CGRect object_rect = CGRectMake(object_x, object_y,  object_width, object_height);
    UIButton *  object = [[UIButton alloc]initWithFrame:object_rect];
    [object setTitle:@"微信登录" forState:UIControlStateNormal];
    [object setTitleColor:[UIColor wya_whiteColor] forState:UIControlStateNormal];
    [object setBackgroundImage:[UIImage wya_createImageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    [object addCallBackAction:^(UIButton *button) {
        SendAuthReq * req = [[SendAuthReq alloc]init];
        req.openID = @"wx808acd6db9965c72";
        req.scope = @"snsapi_userinfo";
        req.state = @"123";
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendReq:req];

    }];
    [self.view addSubview:object];
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
