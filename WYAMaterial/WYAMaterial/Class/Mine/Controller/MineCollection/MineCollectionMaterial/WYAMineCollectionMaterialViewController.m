//
//  WYAMineCollectionMaterialViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineCollectionMaterialViewController.h"

@interface WYAMineCollectionMaterialViewController ()

@end

@implementation WYAMineCollectionMaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.hidden = YES;
    self.view.backgroundColor = randomColor;
    // Do any additional setup after loading the view.
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
