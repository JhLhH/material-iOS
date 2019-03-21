//
//  WYASendMaterialViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/21.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYASendMaterialViewController.h"

@interface WYASendMaterialViewController ()

@end

@implementation WYASendMaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navBar wya_addLeftNavBarButtonWithNormalTitle:@[@"取消"] normalColor:@[[UIColor wya_textWhitColorl]] highlightedColor:@[[UIColor wya_textGrayColor]]];
    [self.navBar wya_addRightNavBarButtonWithNormalTitle:@[@"发布"] normalColor:@[[UIColor wya_textWhitColorl]] highlightedColor:@[[UIColor wya_textGrayColor]]];
    // Do any additional setup after loading the view.
}
- (void)wya_customLeftBarButtonItemPressed:(UIButton *)sender{
    if (self.materialType == MaterialTypeCreate) {
        // 在点击取消按钮时需要确认是否保存草稿
    }else{
        // 是否放弃编辑
    }
}
- (void)wya_customrRightBarButtonItemPressed:(UIButton *)sender{

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
