//
//  WYAMineCollectionMaterialViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineCollectionMaterialViewController.h"

#import "WYAMineCollectionMaterialModel.h"

#import "WYAMineCollectionMaterialTableViewCell.h"

#define COLECTION_MATERIAL_CELLID @"WYAMineCollectionMaterialTableViewCell"

@interface WYAMineCollectionMaterialViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataSources;
@end

@implementation WYAMineCollectionMaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.hidden        = YES;
    self.view.backgroundColor = randomColor;
    [self.view addSubview:self.tableView];
}
#pragma mark ======= Lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView * object  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - WYATopHeight - 44) style:UITableViewStylePlain];
            object.delegate       = self;
            object.dataSource     = self;
            object.separatorStyle = UITableViewCellSeparatorStyleNone;
            [object registerClass:[WYAMineCollectionMaterialTableViewCell class] forCellReuseIdentifier:COLECTION_MATERIAL_CELLID];
            object;
        });
    }
    return _tableView;
}

- (NSMutableArray *)dataSources {
    if (!_dataSources) {
        _dataSources = ({
            NSMutableArray * object = [NSMutableArray arrayWithArray:[WYAMineCollectionMaterialModel getmineCollectionMaterialModelWithResults:@" "]];
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
    return [WYAMineCollectionMaterialTableViewCell getCellHeightWithModel:[self.dataSources wya_safeObjectAtIndex:indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYAMineCollectionMaterialTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:COLECTION_MATERIAL_CELLID forIndexPath:indexPath];
    cell.model                                    = [self.dataSources wya_safeObjectAtIndex:indexPath.row];
    cell.selectionStyle                           = UITableViewCellSelectionStyleNone;
    cell.cellIndexPath                            = indexPath;
    cell.collectionActionBlock                    = ^(WYAMineCollectionMaterialTableViewCell * _Nonnull target) {
        // 收藏
        NSLog(@"收藏");
    };
    cell.forwardingActionBlock = ^(WYAMineCollectionMaterialTableViewCell * _Nonnull target) {
        // 转发
        NSLog(@"转发");
    };
    cell.showAllBodyActionBlock = ^(NSIndexPath * _Nonnull cellIndexPath) {
        NSArray<NSIndexPath *> * indexPathArray = @[ cellIndexPath ];
        //3.传入数组，对当前cell进行刷新
        [self.tableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];

    };
    return cell;
}

@end
