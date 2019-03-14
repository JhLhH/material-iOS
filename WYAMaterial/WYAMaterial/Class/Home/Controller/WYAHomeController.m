//
//  WYAHomePageViewController.m
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/6.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAHomeController.h"
#import "AnimationExampleController.h"
#import "WYANavBarViewController.h"
#import "NetWorkExampleViewController.h"
#import "RefreshExampleController.h"
#define CELLID @"cellId"

@interface WYAHomeController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * dataSources;
@end

@implementation WYAHomeController
#pragma mark ======= system interface
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ======= Lazy loading
- (NSArray *)dataSources {
    if (_dataSources == nil) {
        _dataSources = @[ @"导航栏操作", @"刷新加载", @"cell的动画效果", @"网络相关" ];
    }
    return _dataSources;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView            = [[UITableView alloc] initWithFrame:CGRectMake(0, WYATopHeight, ScreenWidth, ScreenHeight)];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELLID];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}
#pragma mark ======= UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
    }
    cell.textLabel.text = self.dataSources[indexPath.row];
    return cell;
}
#pragma mark ======= UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseViewController * vc;
    switch (indexPath.row) {
        case 0: {
            vc = [[WYANavBarViewController alloc] init];
        } break;
        case 1: {
            vc = [[RefreshExampleController alloc] init];
        } break;
        case 2: {
            vc = [[AnimationExampleController alloc] init];
        } break;
        case 3: {
            vc = [[NetWorkExampleViewController alloc] init];
        }

        break;
        default:
            break;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
