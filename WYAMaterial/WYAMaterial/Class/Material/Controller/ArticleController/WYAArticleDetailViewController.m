//
//  WYAArticleDetailViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAArticleDetailViewController.h"

@interface WYAArticleDetailViewController ()
@property (nonatomic, strong) UIButton * rightButton;
@property (nonatomic, strong) WYAAlertController * shareController;
@end

@implementation WYAArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle             = @"文章详情";
    self.navBar.backgroundColor = [[UIColor wya_blackColor] colorWithAlphaComponent:1];
    [self.navBar addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker * make) {
        make.right.equalTo(self.navBar.mas_right).offset(-14*SizeAdapter);
        make.top.equalTo(self.navBar.mas_top).offset(WYAStatusBarHeight);
        make.size.mas_equalTo(CGSizeMake(52*SizeAdapter, 44));
    }];
    [self.rightButton wya_setButtonImageLoctionRightWithSpace:3*SizeAdapter];
}
#pragma mark ======= Lazy
- (WYAAlertController *)shareController{
    if(!_shareController){
        _shareController = ({
            WYAMaterialShareView * shareView = [WYAMaterialShareView sharedInstance];
            shareView.isOnlyFriendCircle = YES;
            shareView.cancleActionBlock = ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            };
            WYAAlertController * object = [WYAAlertController wya_alertWithCustomView:shareView AlertStyle:WYAAlertStyleCustomSheet];
            object;
        });
    }
    return _shareController;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"转发" forState:UIControlStateNormal];
            [object setImage:[UIImage imageNamed:@"icon_zhuanfawhite"] forState:UIControlStateNormal];
            [object setTitleColor:[UIColor wya_textWhitColorl] forState:UIControlStateNormal];
            [object setImage:[UIImage imageNamed:@"icon_zhuanfa"] forState:UIControlStateHighlighted];
            [object setTitleColor:[UIColor wya_textGrayColor] forState:UIControlStateHighlighted];
            object.titleLabel.font = FONT(14);
            [object setEnlargeEdgeWithTop:10 right:10 bottom:10 left:0];
            [object addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            object;
        });
    }
    return _rightButton;
}
- (void)rightButtonPressed:(UIButton *)sender {
    [self presentViewController:self.shareController animated:YES completion:nil];
}
@end
