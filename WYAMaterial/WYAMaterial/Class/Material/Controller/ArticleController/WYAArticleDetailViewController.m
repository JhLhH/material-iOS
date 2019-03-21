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
@end

@implementation WYAArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = self.articleTitle;
    self.view.backgroundColor = randomColor;
    [self.navBar addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navBar.mas_right).offset(-10);
        make.top.equalTo(self.navBar.mas_top).offset(WYAStatusBarHeight);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
}
#pragma mark ======= Lazy
- (UIButton *)rightButton{
    if(!_rightButton){
        _rightButton = ({
            UIButton * object = [[UIButton alloc]init];
            [object setTitle:@"转发" forState:UIControlStateNormal];
            [object setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            object.titleLabel.font = FONT(14);
            [object addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            object;
       });
    }
    return _rightButton;
}
- (void)rightButtonPressed:(UIButton *)sender{

}
@end
