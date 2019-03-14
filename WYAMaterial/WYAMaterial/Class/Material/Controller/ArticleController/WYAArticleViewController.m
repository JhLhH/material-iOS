//
//  WYAArticleViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAArticleViewController.h"

@interface WYAArticleViewController ()

@end

@implementation WYAArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.hidden = YES;
    self.view.backgroundColor = randomColor;
//    [self wya_addRightNavBarButtonWithNormalTitle:@"筛选"];
    // Do any additional setup after loading the view.
}

- (void)wya_customrRightBarButtonItemPressed:(UIButton *)sender{
    NSLog(@"筛选");
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
