//
//  WYAMoreViewController.m
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/6.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineViewController.h"

#import "WYAMineBodyView.h"
#import "WYAMineHeaderView.h"

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

- (WYAMineHeaderView *)headerView {
    if (!_headerView) {
        _headerView = ({
            WYAMineHeaderView * object = [[WYAMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 290*SizeAdapter)];
            object.model               = [WYAMineUserInfoModel initWithResults:@" "];
            object.settingActionBlock  = ^{
                WYASettingViewController * tempVc = [[WYASettingViewController alloc] init];
                tempVc.hidesBottomBarWhenPushed   = YES;
                [self.navigationController pushViewController:tempVc animated:YES];

            };
            object;
        });
    }
    return _headerView;
}
- (WYAMineBodyView *)bodyView {
    if (!_bodyView) {
        _bodyView = ({
            WYAMineBodyView * object     = [[WYAMineBodyView alloc] initWithFrame:CGRectMake(10*SizeAdapter, self.headerView.cmam_bottom + 20*SizeAdapter, ScreenWidth - 20*SizeAdapter, 130*SizeAdapter)];
            object.collectionActionBlock = ^{
                WYAMineCollectionViewController * tempVc = [[WYAMineCollectionViewController alloc] init];
                tempVc.selectIndex                       = 0;
                tempVc.menuViewStyle                     = WYAMenuViewStyleLine;
                tempVc.titleColorSelected                = [UIColor wya_goldenColor];
                tempVc.titleColorNormal                  = [UIColor wya_goldenColor];
                tempVc.progressColor                     = [UIColor wya_goldenColor];
                tempVc.progressViewBottomSpace           = 5;
                tempVc.progressWidth                     = 25;
                tempVc.progressHeight                    = 3;
                tempVc.progressViewCornerRadius          = 1.5;
                tempVc.hidesBottomBarWhenPushed          = YES;
                [self.navigationController pushViewController:tempVc animated:YES];
            };

            object.createBlock = ^{
                WYAMineCreateViewController * tempVc = [[WYAMineCreateViewController alloc] init];
                tempVc.selectIndex                   = 0;
                tempVc.menuViewStyle                 = WYAMenuViewStyleLine;
                tempVc.titleColorSelected            = [UIColor wya_goldenColor];
                tempVc.titleColorNormal              = [UIColor wya_goldenColor];
                tempVc.progressColor                 = [UIColor wya_goldenColor];
                tempVc.progressViewBottomSpace       = 5;
                tempVc.progressWidth                 = 25;
                tempVc.progressHeight                = 3;
                tempVc.progressViewCornerRadius      = 1.5;
                tempVc.hidesBottomBarWhenPushed      = YES;
                [self.navigationController pushViewController:tempVc animated:YES];
            };

            object.noticeBlock = ^{
                WYANoticeViewController * tempVc = [[WYANoticeViewController alloc] init];
                tempVc.hidesBottomBarWhenPushed  = YES;
                [self.navigationController pushViewController:tempVc animated:YES];

            };

            object;
        });
    }
    return _bodyView;
}
@end
