//
//  WYAMoreViewController.m
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/6.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineViewController.h"

#import "WYAMineHeaderView.h"
#import "WYAMineBodyView.h"

#import "WYAMineCreateViewController.h"

#import "WYAMineCollectionViewController.h"

#import "WYANoticeViewController.h"

#import "WYASettingViewController.h"

#import "WYAMineModel.h"

#define MINE_CELLID @"WYAMineTableViewCell"

@interface WYAMineViewController ()
@property (nonatomic, strong) WYAMineHeaderView * headerView;
@property (nonatomic, strong) WYAMineBodyView * bodyView;
@end

@implementation WYAMineViewController
#pragma mark ======= LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.hidden = YES;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.bodyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ======= Event


#pragma mark ======= Lazy

- (WYAMineHeaderView *)headerView{
    if(!_headerView){
        _headerView = ({
            WYAMineHeaderView * object = [[WYAMineHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 330)];
            object.model = [WYAMineUserInfoModel initWithResults:@" "];
            object.settingActionBlock = ^{
                WYASettingViewController * tempVc = [[WYASettingViewController alloc]init];
                tempVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:tempVc animated:YES];

            };
            object;
       });
    }
    return _headerView;
}
- (WYAMineBodyView *)bodyView{
    if(!_bodyView){
        _bodyView = ({
            WYAMineBodyView * object = [[WYAMineBodyView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.headerView.frame) + 20, ScreenWidth - 20, 200)];
            object.collectionActionBlock = ^{
                WYAMineCollectionViewController * tempVc = [[WYAMineCollectionViewController alloc] init];
                tempVc.selectIndex                       = 0;
                tempVc.menuViewStyle                     = WYAMenuViewStyleLine;
                tempVc.titleColorSelected                = WYA_RGB_COLOR(226, 193, 139);
                tempVc.titleColorNormal                  = [UIColor whiteColor];
                tempVc.progressColor                     = WYA_RGB_COLOR(226, 193, 139);
                tempVc.progressViewBottomSpace           = 5;
                tempVc.progressWidth                     = 25;
                tempVc.progressHeight                    = 3;
                tempVc.progressViewCornerRadius          = 1.5;
                tempVc.hidesBottomBarWhenPushed          = YES;
                [self.navigationController pushViewController:tempVc animated:YES];
            };

            object.createBlock = ^{
                WYAMineCreateViewController * tempVc     = [[WYAMineCreateViewController alloc]init];
                tempVc.selectIndex                       = 0;
                tempVc.menuViewStyle                     = WYAMenuViewStyleLine;
                tempVc.titleColorSelected                = WYA_RGB_COLOR(226, 193, 139);
                tempVc.titleColorNormal                  = [UIColor whiteColor];
                tempVc.progressColor                     = WYA_RGB_COLOR(226, 193, 139);
                tempVc.progressViewBottomSpace           = 5;
                tempVc.progressWidth                     = 25;
                tempVc.progressHeight                    = 3;
                tempVc.progressViewCornerRadius          = 1.5;
                tempVc.hidesBottomBarWhenPushed          = YES;
                [self.navigationController pushViewController:tempVc animated:YES];
            };

            object.noticeBlock = ^{
                WYANoticeViewController * tempVc = [[WYANoticeViewController alloc]init];
                tempVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:tempVc animated:YES];

            };

            object;
        });
    }
    return _bodyView;
}
@end
