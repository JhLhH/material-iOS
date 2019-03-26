//
//  WYAMineCreateMaterialViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
// 63

#import "WYAMineCreateMaterialViewController.h"

#import "WYAMineCreateMaterialModel.h"
#import "WYAMineCreateMaterialTableViewCell.h"
#import "WYAMineCreateMaterialFootView.h"
#import "WYASendMaterialViewController.h"
#define CREATE_MATERIAL_CELLID @"WYAMineCreateMaterialTableViewCell"
#define CREATE_MATERIAL_FOOT @"createMaterialFoot"
@interface WYAMineCreateMaterialViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataSources;
@end

@implementation WYAMineCreateMaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.hidden        = YES;
    [self.view addSubview:self.tableView];
}
#pragma mark ======= Lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView * object  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - WYATopHeight - 44) style:UITableViewStyleGrouped];
            object.delegate       = self;
            object.dataSource     = self;
            object.estimatedRowHeight           = 0;
            object.estimatedSectionFooterHeight = 0;
            object.estimatedSectionHeaderHeight = 0;
            object.backgroundColor = [UIColor whiteColor];
            object.separatorStyle = UITableViewCellSeparatorStyleNone;
            [object registerClass:[WYAMineCreateMaterialTableViewCell class] forCellReuseIdentifier:CREATE_MATERIAL_CELLID];
            [object registerClass:[WYAMineCreateMaterialFootView class] forHeaderFooterViewReuseIdentifier:CREATE_MATERIAL_FOOT];
            object;
        });
    }
    return _tableView;
}

- (NSMutableArray *)dataSources {
    if (!_dataSources) {
        _dataSources = ({
            NSMutableArray * object = [NSMutableArray arrayWithArray:[WYAMineCreateMaterialModel getMineCreateMaterialModelWithResults:@" "]];
            object;
        });
    }
    return _dataSources;
}
#pragma mark ======= Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [WYAMineCreateMaterialTableViewCell getCellHeightWithModel:[self.dataSources wya_safeObjectAtIndex:indexPath.section]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYAMineCreateMaterialTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CREATE_MATERIAL_CELLID forIndexPath:indexPath];
    cell.model                                = [self.dataSources wya_safeObjectAtIndex:indexPath.section];
    cell.selectionStyle                       = UITableViewCellSelectionStyleNone;
    cell.cellIndexPath                        = indexPath;
    cell.collectionActionBlock                = ^(WYAMineCreateMaterialTableViewCell * _Nonnull target) {
        // 收藏
        NSLog(@"收藏");
    };
    cell.forwardingActionBlock = ^(WYAMineCreateMaterialTableViewCell * _Nonnull target) {
        // 转发
        NSLog(@"转发");
    };
    cell.showAllBodyActionBlock = ^(NSIndexPath * _Nonnull cellIndexPath) {
//        NSArray<NSIndexPath *> * indexPathArray = @[ cellIndexPath ];
        //3.传入数组，对当前cell进行刷新
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:cellIndexPath.section] withRowAnimation:UITableViewRowAnimationNone];

    };
    cell.showImageActionBlock = ^(WYAMineCreateMaterialTableViewCell * _Nonnull target, NSArray * _Nonnull views, NSInteger index) {
        [self showImageBrowserWithModel:target.model views:views index:index];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    WYAMineCreateMaterialModel * model = [self.dataSources wya_safeObjectAtIndex:section];
    return [WYAMineCreateMaterialFootView footViewHeightWithModel:model];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
     WYAMineCreateMaterialModel * model = [self.dataSources wya_safeObjectAtIndex:section];
    if ([model.mineCreateAuditType isEqualToString:@"审核失败"]) {
        WYAMineCreateMaterialFootView * footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CREATE_MATERIAL_FOOT];
        footView.model = model;
        footView.DeleteMaterialActionBlock = ^(WYAMineCreateMaterialFootView * _Nonnull target) {
            [self.dataSources removeObject:target.model];
            [self.tableView reloadData];
        };
        footView.EditorMaterialActionBlock = ^(WYAMineCreateMaterialFootView * _Nonnull target) {
            WYASendMaterialViewController * vc = [[WYASendMaterialViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.editorModel = target.model;
            vc.materialType = MaterialTypeEditor;
            [self.navigationController pushViewController:vc animated:YES];
        };
        return footView;
    }
    return [[UIView alloc]init];
}
#pragma mark ======= 图片预览
- (void)showImageBrowserWithModel:(WYAMineCreateMaterialModel *)model views:(NSArray *)views index:(NSInteger)index {

    [WYAImageBrowser showImageBrowserWithCurrentImageIndex:index imageCount:model.mineCreateBodyImgArray.count datasource:nil placeHoldImageBlock:^UIImage *(WYAImageBrowser *browser, NSInteger index) {
        return [UIImage imageNamed:@"1"];
    } HighQualityImageURLBlock:nil AssetBlock:nil SourceImageViewBlock:^UIImageView *(WYAImageBrowser *browser, NSInteger index) {
        return views[index];
    }];
}
@end
