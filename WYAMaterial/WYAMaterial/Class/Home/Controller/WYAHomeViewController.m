//
//  WYAHomePageViewController.m
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/6.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAHomeViewController.h"

#import "WYAAgentRingViewModel.h"
#import "WYAAgentRingModel.h"

#import "WYAAgentRingCoverView.h"
#import "WYAAgentRingCell.h"
#import "WYAAgentRingSectionFootView.h"
@interface WYAHomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) WYAAgentRingViewModel * viewModel;

@property (nonatomic, strong) WYAAgentRingCoverView * agentRingCoverView;
@property (nonatomic, strong) UITableView * agentRingTableView;

@property (nonatomic, strong) NSArray * dataSource;
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

#pragma mark ======= Private Method
- (void)setupUI {
    self.agentRingTableView.tableHeaderView = self.agentRingCoverView;
    [self.view addSubview:self.agentRingTableView];
}

- (void)getNetWorkDataSource{
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
    cell.model = self.dataSource[indexPath.section];

    return cell;
}

#pragma mark ======= UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [WYAAgentRingCell getCellHeightWithModel:self.dataSource[indexPath.section]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [WYAAgentRingSectionFootView getFootHeightWithModel:self.dataSource[section]];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    WYAAgentRingSectionFootView * footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"foot"];
    footView.backgroundColor = [UIColor whiteColor];
    footView.model = self.dataSource[section];
    footView.stretchBlock = ^(WYAAgentRingModel * _Nonnull model) {
        NSLog(@"model.show==%d",model.show);
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    return  footView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark ======= Getter
- (UITableView *)agentRingTableView{
    if(!_agentRingTableView){
        _agentRingTableView = ({
            CGFloat object_x = self.view.cmam_left;
            CGFloat object_y = WYATopHeight;
            CGFloat object_width = self.view.cmam_width;
            CGFloat object_height = self.view.cmam_height - WYATopHeight * 2;
            CGRect object_rect = CGRectMake(object_x, object_y,  object_width, object_height);

            UITableView * object = [[UITableView alloc]initWithFrame:object_rect style:UITableViewStyleGrouped];
            object.delegate       = self;
            object.dataSource     = self;
//            object.backgroundColor = [UIColor groupTableViewBackgroundColor];
//            object.separatorStyle = <#UITableViewCellSeparatorStyle#>;
            [object registerClass:[WYAAgentRingCell class] forCellReuseIdentifier:@"cell"];
            [object registerClass:[WYAAgentRingSectionFootView class] forHeaderFooterViewReuseIdentifier:@"foot"];
            object;
       });
    }
    return _agentRingTableView;
}

- (WYAAgentRingCoverView *)agentRingCoverView{
    if(!_agentRingCoverView){
        _agentRingCoverView = ({

            CGFloat object_x = 0;
            CGFloat object_y = 0;
            CGFloat object_width = self.agentRingTableView.cmam_width;
            CGFloat object_height = 200;
            CGRect object_rect = CGRectMake(object_x, object_y,  object_width, object_height);

            WYAAgentRingCoverView * object = [[WYAAgentRingCoverView alloc]init];
            object.frame = object_rect;
            object;
       });
    }
    return _agentRingCoverView;
}

- (WYAAgentRingViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = ({
            WYAAgentRingViewModel * object = [[WYAAgentRingViewModel alloc]init];
            object;
       });
    }
    return _viewModel;
}

- (NSArray *)dataSource{
    if(!_dataSource){
        _dataSource = ({
            NSArray * object = [[NSArray alloc]init];
            object;
       });
    }
    return _dataSource;
}
@end
