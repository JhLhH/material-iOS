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

@interface WYAImgTextViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton * createMaterialBtn;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataSources;
@end

@implementation WYAImgTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.createMaterialBtn];
    [self.createMaterialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.bottom.equalTo(self.view.mas_bottom).offset(-25);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
}


#pragma mark ======= Lazy
- (UIButton *)createMaterialBtn{
    if(!_createMaterialBtn){
        _createMaterialBtn = ({
            UIButton * object = [[UIButton alloc]init];
            object.backgroundColor = [UIColor blackColor];
            object.layer.shadowColor = [UIColor grayColor].CGColor;
            object.layer.shadowOffset = CGSizeMake(0,0);
            object.layer.shadowOpacity = 1;
            object.layer.shadowRadius = 2;
            object.layer.cornerRadius = 30;
            object.layer.masksToBounds = YES;
            object.clipsToBounds = NO;
            object;
        });
    }
    return _createMaterialBtn;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = ({
            UITableView * object = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - WYATopHeight - 44 - WYATabBarHeight) style:UITableViewStylePlain];
            object.delegate       = self;
            object.dataSource     = self;
            object.separatorStyle = UITableViewCellSeparatorStyleNone;
            [object registerClass:[WYAImageTextTableViewCell class] forCellReuseIdentifier:IMGTEXT_CELLID];
            object;
       });
    }
    return _tableView;
}

- (NSMutableArray *)dataSources{
    if(!_dataSources){
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
    WYAImageTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IMGTEXT_CELLID forIndexPath:indexPath];
    cell.model = [self.dataSources wya_safeObjectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
