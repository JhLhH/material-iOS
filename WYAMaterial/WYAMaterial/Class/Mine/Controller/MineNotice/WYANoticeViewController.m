//
//  WYANoticeViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/15.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYANoticeViewController.h"

#import "WYAMineModel.h"

#import "WYANoticeTableViewCell.h"

#define NOTICE_CELLID @"WYANoticeTableViewCell"

@interface WYANoticeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataSources;
@end

@implementation WYANoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"历史通知";
    [self.view addSubview:self.tableView];
}

#pragma mark ======= Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView * object   = [[UITableView alloc] initWithFrame:CGRectMake(0, WYATopHeight, ScreenWidth, ScreenHeight - WYATopHeight) style:UITableViewStylePlain];
            object.delegate        = self;
            object.dataSource      = self;
            object.tableFooterView = [UIView new];
            [object registerClass:[WYANoticeTableViewCell class] forCellReuseIdentifier:NOTICE_CELLID];
            object;
        });
    }
    return _tableView;
}

- (NSMutableArray *)dataSources {
    if (!_dataSources) {
        _dataSources = ({
            NSMutableArray * object = [NSMutableArray arrayWithArray:[WYAMineNoticeModel getModelsWithResults:@""]];
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
    WYAMineNoticeModel * model = [self.dataSources wya_safeObjectAtIndex:indexPath.row];
    return [WYANoticeTableViewCell getCellHeightWithModel:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WYANoticeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NOTICE_CELLID];
    cell.model                    = [self.dataSources wya_safeObjectAtIndex:indexPath.row];
    cell.selectionStyle           = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
