//
//  WYAArticleViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAArticleViewController.h"

#import "WYAArticleTableViewCell.h"

#import "WYAMaterialModel.h"

#import "WYAArticleDetailViewController.h"

#define ARTICLE_CELLID @"WYAArticleTableViewCell"

@interface WYAArticleViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@end

@implementation WYAArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.hidden = YES;
    [self.view addSubview:self.tableView];
}

#pragma mark ======= Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView * object  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - WYATopHeight - 44 - WYATabBarHeight) style:UITableViewStylePlain];
            object.delegate       = self;
            object.dataSource     = self;
            object.separatorStyle = UITableViewCellSeparatorStyleNone;
            [object registerClass:[WYAArticleTableViewCell class] forCellReuseIdentifier:ARTICLE_CELLID];
            object;
        });
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = ({
            NSArray * array         = [WYAArticleModel getArticleWithResults:@""];
            NSMutableArray * object = [NSMutableArray arrayWithArray:array];
            object;
        });
    }
    return _dataSource;
}
#pragma mark ======= Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYAArticleModel * model = [self.dataSource wya_safeObjectAtIndex:indexPath.row];
    return [WYAArticleTableViewCell getCellHeightWithModel:model];
    ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYAArticleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ARTICLE_CELLID];
    WYAArticleModel * model        = [self.dataSource wya_safeObjectAtIndex:indexPath.row];
    cell.model                     = model;
    cell.selectionStyle            = UITableViewCellSelectionStyleNone;
    cell.DidSelectActionBlock      = ^(WYAArticleTableViewCell * _Nonnull taraget) {
        [self didSelectActionBlockWithModel:taraget.model];
    };
    return cell;
}

- (void)didSelectActionBlockWithModel:(WYAArticleModel *)model {
    WYAArticleDetailViewController * vc = [[WYAArticleDetailViewController alloc] init];
    vc.articleTitle                     = model.titleString;
    vc.urlString                        = model.detailsUrlString;
    vc.hidesBottomBarWhenPushed         = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
