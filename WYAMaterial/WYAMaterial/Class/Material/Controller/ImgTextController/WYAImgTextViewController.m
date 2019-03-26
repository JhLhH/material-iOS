//
//  WYAImgTextViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAImgTextViewController.h"

#import "WYAImageTextTableViewCell.h"

#import "WYAMaterialModel.h"

#define IMGTEXT_CELLID @"WYAImageTextTableViewCell"

@interface WYAImgTextViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataSources;
@property (nonatomic, strong) WYAAlertController * shareController;
@end

@implementation WYAImgTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.hidden        = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}
#pragma mark ======= Lazy

- (WYAAlertController *)shareController{
    if(!_shareController){
        _shareController = ({
            WYAMaterialShareView * shareView = [WYAMaterialShareView sharedInstance];
            shareView.cancleActionBlock = ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            };
            WYAAlertController * object = [WYAAlertController wya_alertWithCustomView:shareView AlertStyle:WYAAlertStyleCustomSheet];
            object;
        });
    }
    return _shareController;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView * object  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - WYATopHeight - 44 - WYATabBarHeight) style:UITableViewStylePlain];
            object.delegate       = self;
            object.dataSource     = self;
            object.separatorStyle = UITableViewCellSeparatorStyleNone;
            [object registerClass:[WYAImageTextTableViewCell class] forCellReuseIdentifier:IMGTEXT_CELLID];
            object;
        });
    }
    return _tableView;
}

- (NSMutableArray *)dataSources {
    if (!_dataSources) {
        _dataSources = ({
            NSMutableArray * object = [NSMutableArray arrayWithArray:[WYAImageTextModel getImgTextModelWithResults:@" "]];
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
    return [WYAImageTextTableViewCell getCellHeightWithModel:[self.dataSources wya_safeObjectAtIndex:indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYAImageTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:IMGTEXT_CELLID forIndexPath:indexPath];
    cell.model                       = [self.dataSources wya_safeObjectAtIndex:indexPath.row];
    cell.selectionStyle              = UITableViewCellSelectionStyleNone;
    cell.cellIndexPath               = indexPath;
    cell.collectionActionBlock       = ^(WYAImageTextTableViewCell * _Nonnull target) {
        // 收藏
        NSLog(@"收藏");
    };
    cell.forwardingActionBlock = ^(WYAImageTextTableViewCell * _Nonnull target) {
        // 转发
        NSLog(@"转发");
        [self presentViewController:self.shareController animated:YES completion:^{
            [UIView wya_showCenterToastWithMessage:@"文案已复制到剪切板"];
        }];
    };
    cell.showAllBodyActionBlock = ^(NSIndexPath * _Nonnull cellIndexPath) {
        NSArray<NSIndexPath *> * indexPathArray = @[ cellIndexPath ];
        //3.传入数组，对当前cell进行刷新
        [self.tableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
    };
    cell.showImageActionBlock = ^(WYAImageTextTableViewCell * _Nonnull target, NSArray * _Nonnull views, NSInteger index) {
        [self showImageBrowserWithModel:target.model views:views index:index];
    };
    return cell;
}

#pragma mark ======= 图片预览

- (void)showImageBrowserWithModel:(WYAImageTextModel *)model views:(NSArray *)views index:(NSInteger)index {

    [WYAImageBrowser showImageBrowserWithCurrentImageIndex:index imageCount:model.bodyImgArray.count datasource:nil placeHoldImageBlock:^UIImage *(WYAImageBrowser *browser, NSInteger index) {
        return [UIImage imageNamed:@"1"];
    } HighQualityImageURLBlock:nil AssetBlock:nil SourceImageViewBlock:^UIImageView *(WYAImageBrowser *browser, NSInteger index) {
        return views[index];
    }];
} 
@end
