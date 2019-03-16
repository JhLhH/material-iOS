//
//  WYAMoreViewController.m
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/6.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineViewController.h"
#import "WYAMineTableViewCell.h"
#import "WYAMineHeaderView.h"

#import "WYAMineCreateViewController.h"

#import "WYAMineCollectionViewController.h"

#import "WYANoticeViewController.h"


#import "WYAMineModel.h"

#define MINE_CELLID @"WYAMineTableViewCell"

@interface WYAMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) WYAMineHeaderView * headerView;
@property (nonatomic, strong) NSArray * dataSources;
@property (nonatomic, strong) UIImageView * bgImageView;
@end

@implementation WYAMineViewController
#pragma mark ======= LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"个人中心";
    [self wya_addRightNavBarButtonWithNormalTitle:@[@"设置"]];
//    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)wya_customrRightBarButtonItemPressed:(UIButton *)sender{
   NSLog(@"%@",sender.titleLabel.text);
}

#pragma mark ======= Event


#pragma mark ======= Lazy
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = ({
            UITableView * object = [[UITableView alloc]initWithFrame:CGRectMake(0, WYATopHeight, ScreenWidth, ScreenHeight-WYATopHeight - WYATabBarHeight) style:UITableViewStylePlain];
            object.delegate       = self;
            object.dataSource     = self;
            object.separatorStyle = UITableViewCellSeparatorStyleNone;
            object.tableHeaderView = self.headerView;
            [object registerClass:[WYAMineTableViewCell class] forCellReuseIdentifier:MINE_CELLID];
            object;
       });
    }
    return _tableView;
}

- (WYAMineHeaderView *)headerView{
    if(!_headerView){
        _headerView = ({
            WYAMineHeaderView * object = [[WYAMineHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
            object.model = [WYAMineUserInfoModel initWithResults:@" "];
            object;
       });
    }
    return _headerView;
}


- (NSArray *)dataSources{
    if(!_dataSources){
        _dataSources = ({
            NSArray * object = @[@{@"icon":@"",@"content":@"我的收藏"},@{@"icon":@"",@"content":@"我的创建"},@{@"icon":@"",@"content":@"历史通知"}];
            object;
        });
    }
    return _dataSources;
}

#pragma mark ======= Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WYAMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MINE_CELLID];
    cell.dataDict = [self.dataSources wya_safeObjectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController * vc ;
    switch (indexPath.row) {
        case 0:
            {
                WYAMineCreateViewController * tempVc = [[WYAMineCreateViewController alloc]init];
                tempVc.selectIndex                       = 0;
                tempVc.menuViewStyle                     = WYAMenuViewStyleLine;
                tempVc.automaticallyCalculatesItemWidths = YES;
                tempVc.titleColorSelected                = [UIColor wya_blueColor];
                tempVc.titleColorNormal                  = [UIColor wya_blackTextColor];
                tempVc.progressColor                     = [UIColor wya_blueColor];
                vc = tempVc;
            }
            break;
        case 1:
        {
            WYAMineCollectionViewController * tempVc = [[WYAMineCollectionViewController alloc] init];
            tempVc.selectIndex                       = 0;
            tempVc.menuViewStyle                     = WYAMenuViewStyleLine;
            tempVc.automaticallyCalculatesItemWidths = YES;
            tempVc.titleColorSelected                = [UIColor wya_blueColor];
            tempVc.titleColorNormal                  = [UIColor wya_blackTextColor];
            tempVc.progressColor                     = [UIColor wya_blueColor];
            vc = tempVc;
        }
            break;
        case 2:
        {
            vc = [[WYANoticeViewController alloc]init];
        }
            break;
        default:
            break;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
