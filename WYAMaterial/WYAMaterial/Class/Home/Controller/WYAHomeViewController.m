//
//  WYAHomePageViewController.m
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/6.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAHomeViewController.h"
#import "WYASendDynamicViewController.h"
#import "WYAAgentRingModel.h"
#import "WYAAgentRingViewModel.h"

#import "WYAAgentRingCell.h"
#import "WYAAgentRingCoverView.h"
#import "WYAAgentRingSectionFootView.h"

@interface WYAHomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) WYAAgentRingViewModel * viewModel;
@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, strong) WYAAgentRingCoverView * agentRingCoverView;
@property (nonatomic, strong) UITableView * agentRingTableView;
@property (nonatomic, strong) UIButton * sendDynamicButton; // 发动态按钮
@property (nonatomic, strong) WYANoticeBar * noticeBar;
@end

@implementation WYAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"首页";
    [self setupUI];
    [self getNetWorkDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
     return UIStatusBarStyleLightContent;
}

#pragma mark ======= Private Method
- (void)setupUI {
    [self.view addSubview:self.noticeBar];
    self.agentRingTableView.tableHeaderView = self.agentRingCoverView;
    [self.view addSubview:self.agentRingTableView];
    [self.view addSubview:self.sendDynamicButton];
}

- (void)getNetWorkDataSource {
    self.dataSource = [self.viewModel testSource];
    [self.agentRingTableView reloadData];
}

#pragma mark ======= UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYAAgentRingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model              = self.dataSource[indexPath.section];
    cell.stretchBlock = ^(WYAAgentRingModel * _Nonnull model) {
        [tableView beginUpdates];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [tableView endUpdates];
    };
    cell.forwardingBlock = ^(WYAAgentRingModel * _Nonnull model) {

    };
    cell.collectionBlock = ^(WYAAgentRingModel * _Nonnull model) {

    };
    cell.commentsBlock = ^(WYAAgentRingModel * _Nonnull model) {

    };
    cell.praiseBlock = ^(WYAAgentRingModel * _Nonnull model) {

    };
//    cell.
    return cell;
}

#pragma mark ======= UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [WYAAgentRingCell getCellHeightWithModel:self.dataSource[indexPath.section]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [WYAAgentRingSectionFootView getFootHeightWithModel:self.dataSource[section]];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    WYAAgentRingSectionFootView * footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"foot"];
    footView.model                         = self.dataSource[section];
    footView.stretchBlock                  = ^(WYAAgentRingModel * _Nonnull model) {
        NSLog(@"model.show==%d", model.show);
        [tableView beginUpdates];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        [tableView endUpdates];
    };
    footView.singleCommentsBlock = ^(WYAAgentRingModel * _Nonnull model) {
        [tableView beginUpdates];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        [tableView endUpdates];
    };
    return footView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark ======= Getter
- (UITableView *)agentRingTableView {
    if (!_agentRingTableView) {
        _agentRingTableView = ({
            CGFloat object_x      = self.view.cmam_left;
            CGFloat object_y      = WYATopHeight + 30 * SizeAdapter;
            CGFloat object_width  = self.view.cmam_width;
            CGFloat object_height = ScreenHeight - WYATopHeight - WYATabBarHeight - 30 * SizeAdapter;
            CGRect object_rect    = CGRectMake(object_x, object_y, object_width, object_height);

            UITableView * object   = [[UITableView alloc] initWithFrame:object_rect style:UITableViewStyleGrouped];
            object.delegate        = self;
            object.dataSource      = self;
            object.estimatedRowHeight = 0;
            object.estimatedSectionFooterHeight = 0;
            object.estimatedSectionHeaderHeight = 0;
            object.backgroundColor = [UIColor whiteColor];
            object.separatorStyle  = UITableViewCellSeparatorStyleNone;
            [object registerClass:[WYAAgentRingCell class] forCellReuseIdentifier:@"cell"];
            [object registerClass:[WYAAgentRingSectionFootView class] forHeaderFooterViewReuseIdentifier:@"foot"];
            object;
        });
    }
    return _agentRingTableView;
}

- (WYAAgentRingCoverView *)agentRingCoverView {
    if (!_agentRingCoverView) {
        _agentRingCoverView = ({

            CGFloat object_x      = 0;
            CGFloat object_y      = 0;
            CGFloat object_width  = self.agentRingTableView.cmam_width;
            CGFloat object_height = 200;
            CGRect object_rect    = CGRectMake(object_x, object_y, object_width, object_height);

            WYAAgentRingCoverView * object = [[WYAAgentRingCoverView alloc] init];
            object.frame                   = object_rect;
            object;
        });
    }
    return _agentRingCoverView;
}

- (WYAAgentRingViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = ({
            WYAAgentRingViewModel * object = [[WYAAgentRingViewModel alloc] init];
            object;
        });
    }
    return _viewModel;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = ({
            NSArray * object = [[NSArray alloc] init];
            object;
        });
    }
    return _dataSource;
}

- (UIButton *)sendDynamicButton{
    if(!_sendDynamicButton){
        _sendDynamicButton = ({
            CGFloat object_x = self.view.cmam_width - 76 * SizeAdapter;
            CGFloat object_y = self.view.cmam_height - WYATabBarHeight - 76 * SizeAdapter;
            CGFloat object_width = 60 * SizeAdapter;
            CGFloat object_height = 60 * SizeAdapter;
            CGRect object_rect = CGRectMake(object_x, object_y,  object_width, object_height);

            UIButton *  object = [[UIButton alloc]initWithFrame:object_rect];
            [object setBackgroundImage:[UIImage wya_createImageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
            object.layer.cornerRadius = object_width / 2;
            object.layer.masksToBounds = YES;
            [object addCallBackAction:^(UIButton *button) {
                WYASendDynamicViewController * sendDynamic = [[WYASendDynamicViewController alloc]init];
                sendDynamic.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:sendDynamic animated:YES];
            }];
            object;
       });
    }
    return _sendDynamicButton;
}


- (WYANoticeBar *)noticeBar{
    if(!_noticeBar){
        _noticeBar = ({

            CGFloat object_x = 0;
            CGFloat object_y = WYATopHeight;
            CGFloat object_width = ScreenWidth;
            CGFloat object_height = 30 * SizeAdapter;
            CGRect object_rect = CGRectMake(object_x, object_y,  object_width, object_height);

            WYANoticeBar * object = [[WYANoticeBar alloc]
                                     initWithFrame:object_rect];
            object.showNoticeButton      = YES;
            object.noticeButtonImage     = [UIImage imageNamed:@"1"];
            object.showRightButton       = YES;
            object.rightButtonImage      = [UIImage imageNamed:@"2"];
            object.showText              = @"待修改通知栏文字";
            object.showTextColor         = [UIColor wya_whiteColor];
            object.noticeBackgroundColor = [UIColor blackColor];
            object;
       });
    }
    return _noticeBar;
}
@end
