//
//  WYAMineHeaderView.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineHeaderView.h"
#import <SDWebImage/UIButton+WebCache.h>
@interface WYAMineHeaderView()
@property (nonatomic, strong) UIButton * userIconImageButton;
@property (nonatomic, strong) UILabel * userNameLabel;
@property (nonatomic, strong) UILabel * userInfoLabel;
@end

@implementation WYAMineHeaderView

#pragma mark ======= LifeCircle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor wya_grayBGColor];
        [self addSubview:self.userIconImageButton];
        [self addSubview:self.userNameLabel];
        [self addSubview:self.userInfoLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    [self.userIconImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(45*SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];

    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userIconImageButton.mas_top);
        make.left.equalTo(self.userIconImageButton.mas_right).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(ScreenWidth-CGRectGetMaxX(self.userIconImageButton.frame));
    }];

    [self.userInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.userIconImageButton.mas_bottom);
        make.left.mas_equalTo(self.userNameLabel.mas_left);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(ScreenWidth-CGRectGetMaxX(self.userIconImageButton.frame));
    }];

}

#pragma mark ======= Setter
- (void)setModel:(WYAMineUserInfoModel *)model{
    if (model) {
        _model = model;
        [self.userIconImageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:_model.userIconUrlString] forState:UIControlStateNormal];
        self.userNameLabel.text = _model.userNameString;
        self.userInfoLabel.text = _model.userInfoString;
        [self layoutIfNeeded];
    }
}

#pragma mark ======= Lazy
- (UIButton *)userIconImageButton{
    if(!_userIconImageButton){
        _userIconImageButton = ({
            UIButton * object = [[UIButton alloc]init];
            object.backgroundColor = [UIColor wya_blueColor];
            object.layer.cornerRadius = 20;
            object.layer.masksToBounds = YES;
            object;
       });
    }
    return _userIconImageButton;
}

- (UILabel *)userNameLabel{
    if(!_userNameLabel){
        _userNameLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.font = FONT(14);
            object.textColor = [UIColor wya_blackTextColor];
            object.text = @"用户昵称";
            object;
       });
    }
    return _userNameLabel;
}

- (UILabel *)userInfoLabel{
    if(!_userInfoLabel){
        _userInfoLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.font = FONT(12);
            object.textColor = [UIColor wya_blackTextColor];
            object.text = @"代理层级";
            object;
       });
    }
    return _userInfoLabel;
}
@end
