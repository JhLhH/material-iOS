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
@property (nonatomic, strong) UIImageView * bgImageView;
@property (nonatomic, strong) UIButton * settingButton;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIButton * userIconImageButton;
@property (nonatomic, strong) UIImageView * editImageView;
@property (nonatomic, strong) UIImageView * userInfoImageView;@property (nonatomic, strong) UILabel * userNameLabel;
@property (nonatomic, strong) UILabel * userInfoLabel;
@end

@implementation WYAMineHeaderView

#pragma mark ======= LifeCircle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        [self.titleLabel addSubview:self.settingButton];
        [self.bgImageView addSubview:self.titleLabel];
        [self addSubview:self.bgImageView];

        [self.bgView addSubview:self.userIconImageButton];
        [self.bgView addSubview:self.userNameLabel];
        [self.bgView addSubview:self.userInfoLabel];
        [self addSubview:self.bgView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];


    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(self);
        make.height.mas_offset(200);
    }];


    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(self.bgImageView.mas_centerX);
        make.top.equalTo(self.bgImageView.mas_top).offset(WYAStatusBarHeight);
        make.size.mas_offset(CGSizeMake(ScreenWidth, 44));
    }];

    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(self.titleLabel.mas_centerY);
        make.right.equalTo(self.titleLabel.mas_right).offset(10);
        make.size.mas_offset(CGSizeMake(40, 40));
    }];

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView.mas_bottom).offset(-30);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_offset(120);
    }];


    [self.userIconImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.top.equalTo(self.mas_top).offset(-25);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];

    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userIconImageButton.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(ScreenWidth);
    }];

    [self.userInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.userIconImageButton.mas_bottom);
        make.left.mas_equalTo(self.userNameLabel.mas_left);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(ScreenWidth);
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
            object.layer.cornerRadius = 25;
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
            object.font = FONT(18);
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
            object.font = FONT(14);
            object.textColor = [UIColor wya_blackTextColor];
            object.text = @"代理层级";
            object;
       });
    }
    return _userInfoLabel;
}

- (UIImageView *)bgImageView{
    if(!_bgImageView){
        _bgImageView = ({
            UIImageView * object = [[UIImageView alloc]init];
            object.image = [UIImage imageNamed:@"1"];
            object.userInteractionEnabled = YES;
            object;
       });
    }
    return _bgImageView;
}

- (UIButton *)settingButton{
    if(!_settingButton){
        _settingButton = ({
            UIButton * object = [[UIButton alloc]init];
            [object setTitle:@"设置" forState:UIControlStateNormal];
            [object setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            object.titleLabel.font = FONT(14);
            [object addTarget:self action:@selector(settingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            object;
       });
    }
    return _settingButton;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.text = @"个人中心";
            object.textColor = [UIColor whiteColor];
            object.font = FONT(18);
            object;
       });
    }
    return _titleLabel;
}
- (UIImageView *)editImageView{
    if(!_editImageView){
        _editImageView = ({
            UIImageView * object = [[UIImageView alloc]init];
            object.backgroundColor = [UIColor wya_blueColor];
            object.layer.cornerRadius = 10;
            object.layer.masksToBounds = YES;
            object;
        });
    }
    return _editImageView;
}

- (UIImageView *)userInfoImageView{
    if(!_userInfoImageView){
        _userInfoImageView = ({
            UIImageView * object = [[UIImageView alloc]init];
            object.backgroundColor = [UIColor orangeColor];
            object;
        });
    }
    return _userInfoImageView;
}
#pragma mark ======= event
- (void)settingButtonClicked:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mineHeaderSettingButtonPressed:)]) {
        [self.delegate mineHeaderSettingButtonPressed:sender];
    }
}




@end
