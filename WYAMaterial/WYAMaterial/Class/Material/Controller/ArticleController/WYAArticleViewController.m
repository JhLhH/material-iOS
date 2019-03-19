//
//  WYAArticleViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAArticleViewController.h"
#import "WYAArticleTableViewCell.h"
#define ARTICLE_CELLID @"WYAArticleTableViewCell"
@interface WYAArticleViewController ()
//<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation WYAArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];

}

//#pragma mark ======= Lazy
//- (UITableView *)tableView{
//    if(!_tableView){
//        _tableView = ({
//            UITableView * object = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - WYATopHeight - 44 - WYATabBarHeight) style:UITableViewStylePlain];
//            object.delegate       = self;
//            object.dataSource     = self;
//            object.separatorStyle = UITableViewCellSeparatorStyleNone;
//            [object registerClass:[WYAArticleTableViewCell class] forCellReuseIdentifier:ARTICLE_CELLID];
//            object;
//       });
//    }
//    return _tableView;
//}


@end
