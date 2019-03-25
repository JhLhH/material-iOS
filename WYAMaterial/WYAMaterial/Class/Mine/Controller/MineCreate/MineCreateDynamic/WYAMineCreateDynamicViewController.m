//
//  WYAMineCreateDynamicViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineCreateDynamicViewController.h"
#import "WYASendDynamicViewController.h"

#import "WYAMineCreateReviewFailCell.h"
#import "WYAMineCreateReviewSuccessCell.h"
#import "WYAMineCreateReviewSuccessFootView.h"
#import "WYAMineCreateReviewingCell.h"

#import "WYAMineCreateDynamicModel.h"
#import "WYAMineCreateDynamicViewModel.h"

@interface WYAMineCreateDynamicViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) WYAMineCreateDynamicViewModel * viewModel;
@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, strong) UITableView * mineCreateTableView;
@end

@implementation WYAMineCreateDynamicViewController

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
    [self.view addSubview:self.mineCreateTableView];
}

- (void)getNetWorkDataSource {
    self.dataSource = [self.viewModel testSource];
    [self.mineCreateTableView reloadData];
}

- (void)showImageBrowserWithModel:(WYAMineCreateDynamicModel *)model views:(NSArray *)views index:(NSInteger)index {
    NSMutableArray * array = [NSMutableArray array];
    for (NSInteger i = 0; i < model.urls.count; i++) {
        [array addObject:[UIImage imageNamed:@"1"]];
    }
    [WYAImageBrowser showImageBrowserWithCurrentImageIndex:index imageCount:model.urls.count datasource:nil placeHoldImageBlock:^UIImage *(WYAImageBrowser *browser, NSInteger index) {
        return [UIImage imageNamed:@"1"];
    } HighQualityImageURLBlock:nil AssetBlock:nil SourceImageViewBlock:^UIImageView *(WYAImageBrowser *browser, NSInteger index) {
        return views[index];
    }];
}

- (void)againEditDynamicWithModel:(WYAMineCreateDynamicModel *)model{
    WYASendDynamicViewController * sendDynamic = [[WYASendDynamicViewController alloc] init];
    [self.navigationController pushViewController:sendDynamic animated:YES];
}

#pragma mark ======= UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeakSelf(weakSelf);
    WYAMineCreateDynamicModel * dynamicModel = self.dataSource[indexPath.section];
    if (dynamicModel.reviewStatus == 1) {
        WYAMineCreateReviewSuccessCell * cell = [tableView dequeueReusableCellWithIdentifier:@"success" forIndexPath:indexPath];
        cell.model                            = dynamicModel;
        cell.stretchBlock                     = ^(WYAMineCreateDynamicModel * _Nonnull model) {
            [tableView beginUpdates];
            [tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
            [tableView endUpdates];
        };
        cell.forwardingBlock = ^(WYAMineCreateDynamicModel * _Nonnull model) {

        };
        cell.collectionBlock = ^(WYAMineCreateDynamicModel * _Nonnull model) {

        };
        cell.commentsBlock = ^(WYAMineCreateDynamicModel * _Nonnull model) {

        };
        cell.praiseBlock = ^(WYAMineCreateDynamicModel * _Nonnull model) {

        };
        cell.imageBlock = ^(WYAMineCreateDynamicModel * _Nonnull model, NSArray * _Nonnull views, NSInteger index) {
            [weakSelf showImageBrowserWithModel:model views:views index:index];
        };
        return cell;
    } else if (dynamicModel.reviewStatus == 0) {
        WYAMineCreateReviewFailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"fail" forIndexPath:indexPath];
        cell.model                         = dynamicModel;
        cell.stretchBlock                  = ^(WYAMineCreateDynamicModel * _Nonnull model) {
            [tableView beginUpdates];
            [tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
            [tableView endUpdates];
        };
        cell.imageBlock = ^(WYAMineCreateDynamicModel * _Nonnull model, NSArray * _Nonnull views, NSInteger index) {
            [weakSelf showImageBrowserWithModel:model views:views index:index];
        };
        cell.deleteBlock = ^(WYAMineCreateDynamicModel * _Nonnull model) {

        };
        cell.againEditBlock = ^(WYAMineCreateDynamicModel * _Nonnull model) {

        };
        return cell;
    } else {
        WYAMineCreateReviewingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ing" forIndexPath:indexPath];
        cell.model                        = dynamicModel;
        cell.stretchBlock                 = ^(WYAMineCreateDynamicModel * _Nonnull model) {
            [tableView beginUpdates];
            [tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
            [tableView endUpdates];
        };
        cell.imageBlock = ^(WYAMineCreateDynamicModel * _Nonnull model, NSArray * _Nonnull views, NSInteger index) {
            [weakSelf showImageBrowserWithModel:model views:views index:index];
        };
        return cell;
    }
}

#pragma mark ======= UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYAMineCreateDynamicModel * model = self.dataSource[indexPath.section];
    if (model.reviewStatus == 1) {
        return [WYAMineCreateReviewSuccessCell getCellHeightWithModel:model];
    } else if (model.reviewStatus == 0) {
        return [WYAMineCreateReviewFailCell getCellHeightWithModel:model];
    } else {
        return [WYAMineCreateReviewingCell getCellHeightWithModel:model];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    WYAMineCreateDynamicModel * model = self.dataSource[section];
    if (model.reviewStatus == 1) {
        return [WYAMineCreateReviewSuccessFootView getFootHeightWithModel:model];
    } else {
        return 1 * SizeAdapter;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    WYAMineCreateDynamicModel * model = self.dataSource[section];
    if (model.reviewStatus == 1) {
        WYAMineCreateReviewSuccessFootView * foot = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"foot"];
        foot.model                                = model;
        foot.stretchBlock                         = ^(WYAMineCreateDynamicModel * _Nonnull model) {
            NSLog(@"model.show==%d", model.show);
            [tableView beginUpdates];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
            [tableView endUpdates];
        };
        foot.singleCommentsBlock = ^(WYAMineCreateDynamicModel * _Nonnull model) {
            [tableView beginUpdates];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
            [tableView endUpdates];
        };
        return foot;
    } else {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1 * SizeAdapter)];
        view.backgroundColor = [UIColor wya_lineColor];
        return view;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark ======= Getter
- (UITableView *)mineCreateTableView {
    if (!_mineCreateTableView) {
        _mineCreateTableView = ({
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
            [object registerClass:[WYAMineCreateReviewSuccessCell class] forCellReuseIdentifier:@"success"];
            [object registerClass:[WYAMineCreateReviewFailCell class] forCellReuseIdentifier:@"fail"];
            [object registerClass:[WYAMineCreateReviewingCell class] forCellReuseIdentifier:@"ing"];
            [object registerClass:[WYAMineCreateReviewSuccessFootView class] forHeaderFooterViewReuseIdentifier:@"foot"];
            object;
        });
    }
    return _mineCreateTableView;
}

- (WYAMineCreateDynamicViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = ({
            WYAMineCreateDynamicViewModel * object = [[WYAMineCreateDynamicViewModel alloc] init];
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
