//
//  WYAMineCollectionDynamicViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineCollectionDynamicViewController.h"

#import "WYAMineCollectionDynamicCell.h"
#import "WYAMineCollectionDynamicFootView.h"

#import "WYAMineCollectionDynamicModel.h"
#import "WYAMineCollectionDynamicViewModel.h"

@interface WYAMineCollectionDynamicViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) WYAMineCollectionDynamicViewModel * viewModel;
@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, strong) UITableView * mineCollectionDynamicTableView;

@end

@implementation WYAMineCollectionDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.hidden        = YES;
    self.view.backgroundColor = randomColor;
    [self setupUI];
    [self getNetWorkDataSource];
    // Do any additional setup after loading the view.
}
#pragma mark ======= Private Method
- (void)setupUI {
    [self.view addSubview:self.mineCollectionDynamicTableView];
}

- (void)getNetWorkDataSource {
    self.dataSource = [self.viewModel testSource];
    [self.mineCollectionDynamicTableView reloadData];
}

#pragma mark ======= UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYAMineCollectionDynamicCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model                          = self.dataSource[indexPath.section];
    cell.stretchBlock                   = ^(WYAMineCollectionDynamicModel * _Nonnull model) {
        [tableView beginUpdates];
        [tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
        [tableView endUpdates];
    };
    cell.forwardingBlock = ^(WYAMineCollectionDynamicModel * _Nonnull model) {

    };
    cell.collectionBlock = ^(WYAMineCollectionDynamicModel * _Nonnull model) {

    };
    cell.commentsBlock = ^(WYAMineCollectionDynamicModel * _Nonnull model) {

    };
    cell.praiseBlock = ^(WYAMineCollectionDynamicModel * _Nonnull model) {

    };
    return cell;
}

#pragma mark ======= UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [WYAMineCollectionDynamicCell getCellHeightWithModel:self.dataSource[indexPath.section]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [WYAMineCollectionDynamicFootView getFootHeightWithModel:self.dataSource[section]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    WYAMineCollectionDynamicFootView * foot = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"foot"];
    foot.model                              = self.dataSource[section];
    foot.stretchBlock                       = ^(WYAMineCollectionDynamicModel * _Nonnull model) {
        NSLog(@"model.show==%d", model.show);
        [tableView beginUpdates];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        [tableView endUpdates];
    };
    foot.singleCommentsBlock = ^(WYAMineCollectionDynamicModel * _Nonnull model) {
        [tableView beginUpdates];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        [tableView endUpdates];
    };
    return foot;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark ======= Getter
- (UITableView *)mineCollectionDynamicTableView {
    if (!_mineCollectionDynamicTableView) {
        _mineCollectionDynamicTableView = ({
            CGFloat object_x      = self.view.cmam_left;
            CGFloat object_y      = 0;
            CGFloat object_width  = self.view.cmam_width;
            CGFloat object_height = ScreenHeight - WYATopHeight - 44;
            CGRect object_rect    = CGRectMake(object_x, object_y, object_width, object_height);

            UITableView * object                = [[UITableView alloc] initWithFrame:object_rect style:UITableViewStyleGrouped];
            object.delegate                     = self;
            object.dataSource                   = self;
            object.estimatedRowHeight           = 0;
            object.estimatedSectionFooterHeight = 0;
            object.estimatedSectionHeaderHeight = 0;
            object.backgroundColor              = [UIColor whiteColor];
            object.separatorStyle               = UITableViewCellSeparatorStyleNone;
            [object registerClass:[WYAMineCollectionDynamicCell class] forCellReuseIdentifier:@"cell"];
            [object registerClass:[WYAMineCollectionDynamicFootView class] forHeaderFooterViewReuseIdentifier:@"foot"];
            object;
        });
    }
    return _mineCollectionDynamicTableView;
}

- (WYAMineCollectionDynamicViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = ({
            WYAMineCollectionDynamicViewModel * object = [[WYAMineCollectionDynamicViewModel alloc] init];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
