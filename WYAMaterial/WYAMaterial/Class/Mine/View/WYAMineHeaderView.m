//
//  WYAMineHeaderView.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineHeaderView.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface WYAMineHeaderView ()
@property (nonatomic, strong) UIImageView * bgImageView;
@property (nonatomic, strong) UIButton * settingButton;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIButton * userIconImageButton;
@property (nonatomic, strong) UIImageView * editImageView;
@property (nonatomic, strong) UILabel * userNameLabel;
@property (nonatomic, strong) UILabel * userInfoLabel;
@property (nonatomic, strong) UIImageView * userinfoImageView;
@end

@implementation WYAMineHeaderView

#pragma mark ======= LifeCircle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self.titleLabel addSubview:self.settingButton];
        [self.bgImageView addSubview:self.titleLabel];
        [self addSubview:self.bgImageView];

        [self.bgView addSubview:self.userIconImageButton];
        //        [self.bgView addSubview:self.editImageView];
        [self.bgView addSubview:self.userNameLabel];
        [self.bgView addSubview:self.userInfoLabel];
        [self.bgView addSubview:self.userinfoImageView];
        [self addSubview:self.bgView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker * make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(200);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.centerX.mas_equalTo(self.bgImageView.mas_centerX);
        make.top.equalTo(self.bgImageView.mas_top).offset(WYAStatusBarHeight);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, 44));
    }];

    [self.settingButton mas_makeConstraints:^(MASConstraintMaker * make) {
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.right.equalTo(self.titleLabel.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];

    [self.bgView mas_makeConstraints:^(MASConstraintMaker * make) {
        make.top.equalTo(self.bgImageView.mas_bottom).offset(-30);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(155);
    }];

    [self.userIconImageButton mas_makeConstraints:^(MASConstraintMaker * make) {
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.top.equalTo(self.bgView.mas_top).offset(-95 * 0.5);
        make.size.mas_equalTo(CGSizeMake(95, 95));
    }];

    //    [self.editImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(self.userIconImageButton.mas_right).offset(0);
    //        make.bottom.equalTo(self.userIconImageButton.mas_bottom).offset(0);
    //        make.size.mas_equalTo(CGSizeMake(30, 30));
    //    }];

    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.top.equalTo(self.userIconImageButton.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(ScreenWidth);
    }];

    CGFloat width = [self.userInfoLabel.text wya_widthWithFontSize:14 height:20];

    [self.userInfoLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(width);
    }];

    [self.userinfoImageView mas_makeConstraints:^(MASConstraintMaker * make) {
        make.right.equalTo(self.userInfoLabel.mas_left).offset(0);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}

#pragma mark ======= Setter
- (void)setModel:(WYAMineUserInfoModel *)model {
    if (model) {
        _model = model;
        [self.userIconImageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:_model.userIconUrlString] forState:UIControlStateNormal];
        self.userNameLabel.text = _model.userNameString;
        self.userInfoLabel.text = @"啊实打实大重视程度发";
        [self layoutIfNeeded];
    }
}

#pragma mark ======= Private Method
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView * view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint temPoint = [self.userIconImageButton convertPoint:point fromView:self];
        // 判断是否在点击区域内
        if (CGRectContainsPoint(self.userIconImageButton.bounds, temPoint)) {
            return _userIconImageButton;
        }
    }
    return view;
}

#pragma mark ======= Lazy

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = ({
            UIImageView * object          = [[UIImageView alloc] init];
            object.image                  = [UIImage imageNamed:@"1"];
            object.userInteractionEnabled = YES;
            object;
        });
    }
    return _bgImageView;
}

- (UIButton *)settingButton {
    if (!_settingButton) {
        _settingButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"设置" forState:UIControlStateNormal];
            [object setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            object.titleLabel.font = FONT(14);
            [object addTarget:self action:@selector(settingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            object;
        });
    }
    return _settingButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel * object              = [[UILabel alloc] init];
            object.userInteractionEnabled = YES;
            object.text                   = @"个人中心";
            object.textColor              = [UIColor whiteColor];
            object.font                   = FONT(18);
            object.textAlignment          = NSTextAlignmentCenter;
            object;
        });
    }
    return _titleLabel;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = ({
            UIView * object               = [[UIView alloc] init];
            object.userInteractionEnabled = YES;
            object.backgroundColor        = [UIColor whiteColor];
            object.layer.shadowColor      = [UIColor wya_grayBGColor].CGColor;
            object.layer.shadowOffset     = CGSizeMake(0, 0);
            object.layer.shadowOpacity    = 1;
            object.layer.shadowRadius     = 2;
            object.layer.cornerRadius     = 10;
            object.layer.masksToBounds    = YES;
            object.clipsToBounds          = NO;
            object;
        });
    }
    return _bgView;
}

- (UIButton *)userIconImageButton {
    if (!_userIconImageButton) {
        _userIconImageButton = ({
            UIButton * object          = [[UIButton alloc] init];
            object.backgroundColor     = [UIColor wya_blueColor];
            object.layer.cornerRadius  = 95 * 0.5;
            object.layer.masksToBounds = YES;
            [object addTarget:self action:@selector(userIconButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            object;
        });
    }
    return _userIconImageButton;
}

- (UIImageView *)editImageView {
    if (!_editImageView) {
        _editImageView = ({
            UIImageView * object          = [[UIImageView alloc] init];
            object.userInteractionEnabled = YES;
            object.backgroundColor        = [UIColor orangeColor];
            object.layer.cornerRadius     = 15;
            object.layer.masksToBounds    = YES;
            object;
        });
    }
    return _editImageView;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = ({
            UILabel * object     = [[UILabel alloc] init];
            object.font          = FONT(18);
            object.textColor     = [UIColor wya_blackTextColor];
            object.text          = @"寂地鲸鱼";
            object.textAlignment = NSTextAlignmentCenter;
            object;
        });
    }
    return _userNameLabel;
}

- (UILabel *)userInfoLabel {
    if (!_userInfoLabel) {
        _userInfoLabel = ({
            UILabel * object     = [[UILabel alloc] init];
            object.font          = FONT(14);
            object.textColor     = [UIColor orangeColor];
            object.text          = @"二级代理";
            object.textAlignment = NSTextAlignmentCenter;
            object;
        });
    }
    return _userInfoLabel;
}

- (UIImageView *)userinfoImageView {
    if (!_userinfoImageView) {
        _userinfoImageView = ({
            UIImageView * object       = [[UIImageView alloc] init];
            object.backgroundColor     = [UIColor redColor];
            object.layer.cornerRadius  = 10;
            object.layer.masksToBounds = YES;
            object;
        });
    }
    return _userinfoImageView;
}

#pragma mark ======= event

- (void)settingButtonClicked:(UIButton *)sender {
    NSLog(@"点击设置");
    if (self.settingActionBlock) {
        self.settingActionBlock();
    }
}

- (void)userIconButtonClicked:(UIButton *)sender {
    NSLog(@"点击头像");
    //    if (self.editUserIconActionBlock) {
    //        self.editUserIconActionBlock();
    //    }
}

@end
