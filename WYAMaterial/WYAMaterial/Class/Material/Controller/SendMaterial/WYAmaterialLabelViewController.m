//
//  WYAmaterialLabelViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/22.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAmaterialLabelViewController.h"
//#import 
@interface WYAmaterialLabelViewController ()
@property (nonatomic, strong) UIScrollView * bgScrollView;
@end

@implementation WYAmaterialLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"关联标签";
   [self.navBar wya_addRightNavBarButtonWithNormalTitle:@[@"确定"] normalColor:@[[UIColor wya_textWhitColorl]] highlightedColor:@[[UIColor wya_textGrayColor]]];
}
- (void)wya_customrRightBarButtonItemPressed:(UIButton *)sender{

}
#pragma mark ======= Lazy
- (UIScrollView *)bgScrollView{
    if(!_bgScrollView){
        _bgScrollView = ({
            UIScrollView * object = [[UIScrollView alloc]init];
            object;
       });
    }
    return _bgScrollView;
}
@end
