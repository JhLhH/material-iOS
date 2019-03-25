//
//  WYASettingViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/16.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYASettingViewController.h"

#import "WYASetTeamTableViewCell.h"
#import "WYASettingTableViewCell.h"

#import "WYAMineModel.h"

#define SETTING_CELLID @"WYASettingTableViewCell"
#define SETEAM_CELLID @"WYASetTeamTableViewCell"

@interface WYASettingViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIButton * logOutButton;
@property (nonatomic, strong) NSArray * dataSource;
@end

@implementation WYASettingViewController
#pragma mark ======= LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle             = @"个人中心设置";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.logOutButton];
    [self.logOutButton mas_makeConstraints:^(MASConstraintMaker * make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-WYABottomHeight);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, 48));
    }];
}

#pragma mark ======= Lazy
- (UIButton *)logOutButton {
    if (!_logOutButton) {
        _logOutButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"退出登录" forState:UIControlStateNormal];
            [object setTitleColor:[UIColor wya_textBlackColor] forState:UIControlStateNormal];
//            object.layer.cornerRadius  = 24;
//            object.layer.masksToBounds = YES;
            object.layer.borderColor = [UIColor wya_lineColor].CGColor;
            object.layer.borderWidth = 0.5;
            [object wya_setBackgroundColor:[UIColor wya_whiteColor] forState:UIControlStateNormal];
            object;
        });
    }
    return _logOutButton;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView * object   = [[UITableView alloc] initWithFrame:CGRectMake(0, WYATopHeight, ScreenWidth, ScreenHeight - WYATopHeight - WYABottomHeight - 48) style:UITableViewStylePlain];
            object.delegate        = self;
            object.dataSource      = self;
            object.backgroundColor = [UIColor wya_bgColor];
            object.tableFooterView = [UIView new];
            [object registerClass:[WYASettingTableViewCell class] forCellReuseIdentifier:SETTING_CELLID];
            [object registerClass:[WYASetTeamTableViewCell class] forCellReuseIdentifier:SETEAM_CELLID];
            object;
        });
    }
    return _tableView;
}
- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = ({
            WYAMinSettingModel * model = [WYAMinSettingModel initWithReqults:@""];
            NSMutableArray * array     = [NSMutableArray array];
            [array addObject:@[ @"头像", model.userIconUrl ]];
            [array addObject:@[ @"昵称", model.userName ]];
            [array addObject:@[ @"手机号", model.userPhoneNum ]];
            [array addObject:@[ @"微信号", model.weCheatNum ]];

            NSArray * teamArray = [WYAMinSettingTeamModel getModelWithReqults:@" "];

            NSArray * object = @[ [array copy], teamArray ];
            object;
        });
    }
    return _dataSource;
}
#pragma mark ======= Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 55;
    }
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WYASettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:SETTING_CELLID];
        cell.row                       = indexPath.row;
        cell.selectionStyle            = UITableViewCellSelectionStyleNone;
        cell.dataArray                 = [self.dataSource[0] wya_safeObjectAtIndex:indexPath.row];
        return cell;
    }
    WYASetTeamTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:SETEAM_CELLID];
    cell.model                     = [self.dataSource[1] wya_safeObjectAtIndex:indexPath.row];
    cell.selectionStyle            = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * footView        = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15*SizeAdapter)];
    footView.backgroundColor = [UIColor wya_hex:@"#F2F2F2"];
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 0 ? 12*SizeAdapter : 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
