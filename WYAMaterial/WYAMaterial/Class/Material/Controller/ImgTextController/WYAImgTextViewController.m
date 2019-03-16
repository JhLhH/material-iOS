//
//  WYAImgTextViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAImgTextViewController.h"

@interface WYAImgTextViewController ()
@property (nonatomic, strong) UIButton * createMaterialBtn;
@end

@implementation WYAImgTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
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
@end
