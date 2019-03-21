//
//  WYAReviewLoginView.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/21.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAReviewLoginView.h"
#import "WYABottomLineTextField.h"

@interface WYAReviewLoginView ()
@property (nonatomic, strong) UIImageView * bgImageView;
@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * materialLabel;
@property (nonatomic, strong) UILabel * phoneLab;
@property (nonatomic, strong) WYABottomLineTextField * usernameTF;
@property (nonatomic, strong) UILabel * passwordLab;
@property (nonatomic, strong) WYABottomLineTextField * passwordTF;;
@property (nonatomic, strong) UIButton * loginBtn;
@property (nonatomic, strong) UIImageView * wyaImageView;

@end

@implementation WYAReviewLoginView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.bgImageView];
        [self addSubview:self.iconImageView];
        [self addSubview:self.materialLabel];
        [self addSubview:self.usernameTF];
        [self addSubview:self.passwordTF];
        [self addSubview:self.phoneLab];
        [self addSubview:self.passwordLab];
        [self addSubview:self.loginBtn];
        [self addSubview:self.wyaImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgImageView.frame = self.bounds;

    CGFloat iconImageView_x = 33 * SizeAdapter;
    CGFloat iconImageView_y = 104 * SizeAdapter;
    CGFloat iconImageView_width = 36 * SizeAdapter;
    CGFloat iconImageView_height = 14 * SizeAdapter;
    CGRect iconImageView_rect = CGRectMake(iconImageView_x, iconImageView_y,  iconImageView_width, iconImageView_height);
    self.iconImageView.frame = iconImageView_rect;

    CGFloat materialLabel_x = self.iconImageView.cmam_right + 5 * SizeAdapter;
    CGFloat materialLabel_y = self.iconImageView.cmam_top - 3 * SizeAdapter;
    CGFloat materialLabel_width = 70 * SizeAdapter;
    CGFloat materialLabel_height = 17 * SizeAdapter;
    CGRect materialLabel_rect = CGRectMake(materialLabel_x, materialLabel_y,  materialLabel_width, materialLabel_height);
    self.materialLabel.frame = materialLabel_rect;

    CGFloat phoneLab_x = self.iconImageView.cmam_left;
    CGFloat phoneLab_y = self.iconImageView.cmam_bottom + 47 * SizeAdapter;
    CGFloat phoneLab_width = 55 * SizeAdapter;
    CGFloat phoneLab_height = 12 * SizeAdapter;
    CGRect phoneLab_rect = CGRectMake(phoneLab_x, phoneLab_y,  phoneLab_width, phoneLab_height);
    self.phoneLab.frame = phoneLab_rect;

    CGFloat usernameTF_x = self.phoneLab.cmam_left;
    CGFloat usernameTF_y = self.phoneLab.cmam_bottom + 15 * SizeAdapter;
    CGFloat usernameTF_width = self.cmam_width - 62 * SizeAdapter;
    CGFloat usernameTF_height = 45 * SizeAdapter;
    CGRect usernameTF_rect = CGRectMake(usernameTF_x, usernameTF_y,  usernameTF_width, usernameTF_height);
    self.usernameTF.frame = usernameTF_rect;

    CGFloat passwordLab_x = self.usernameTF.cmam_left;
    CGFloat passwordLab_y = self.usernameTF.cmam_bottom + 18 * SizeAdapter;
    CGFloat passwordLab_width = 50 * SizeAdapter;
    CGFloat passwordLab_height = 12 * SizeAdapter;
    CGRect passwordLab_rect = CGRectMake(passwordLab_x, passwordLab_y,  passwordLab_width, passwordLab_height);
    self.passwordLab.frame = passwordLab_rect;

    CGFloat passwordTF_x = self.passwordLab.cmam_left;
    CGFloat passwordTF_y = self.passwordLab.cmam_bottom + 15 * SizeAdapter;
    CGFloat passwordTF_width = self.cmam_width - 62 * SizeAdapter;
    CGFloat passwordTF_height = 45 * SizeAdapter;
    CGRect passwordTF_rect = CGRectMake(passwordTF_x, passwordTF_y,  passwordTF_width, passwordTF_height);
    self.passwordTF.frame = passwordTF_rect;

    CGFloat loginBtn_x = (self.cmam_width - 315 * SizeAdapter) / 2;
    CGFloat loginBtn_y = self.passwordTF.cmam_bottom + 56 * SizeAdapter;
    CGFloat loginBtn_width = 315 * SizeAdapter;
    CGFloat loginBtn_height = 44 * SizeAdapter;
    CGRect loginBtn_rect = CGRectMake(loginBtn_x, loginBtn_y,  loginBtn_width, loginBtn_height);
    self.loginBtn.frame = loginBtn_rect;

    CGFloat wyaImageView_x = (self.cmam_width - 112 * SizeAdapter) / 2;
    CGFloat wyaImageView_y = self.cmam_height - 36 * SizeAdapter;
    CGFloat wyaImageView_width = 112 * SizeAdapter;
    CGFloat wyaImageView_height = 21 * SizeAdapter;
    CGRect wyaImageView_rect = CGRectMake(wyaImageView_x, wyaImageView_y,  wyaImageView_width, wyaImageView_height);
    self.wyaImageView.frame = wyaImageView_rect;
}

#pragma mark ======= Lazy
- (UIImageView *)bgImageView{
    if(!_bgImageView){
        _bgImageView = ({
            UIImageView * object = [[UIImageView alloc]init];
            [object setImage:[UIImage imageNamed:@"750-1334"]];
            object.contentMode = UIViewContentModeScaleAspectFill;
            object;
        });
    }
    return _bgImageView;
}

- (UIImageView *)iconImageView{
    if(!_iconImageView){
        _iconImageView = ({
            UIImageView * object = [[UIImageView alloc]init];
            [object setImage:[UIImage imageNamed:@"icon_logo"]];
            object;
        });
    }
    return _iconImageView;
}

- (UILabel *)phoneLab{
    if(!_phoneLab){
        _phoneLab = ({
            UILabel * object = [[UILabel alloc]init];
            object.textColor = [UIColor wya_whiteColor];
            object.text = @"手机号码";
            object.font = FONT(12);
            object;
        });
    }
    return _phoneLab;
}

- (WYABottomLineTextField *)usernameTF{
    if(!_usernameTF){
        _usernameTF = ({

            UILabel * leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 45)];
            leftLab.text = @"+86";
            leftLab.font = FONT(15);
            leftLab.textColor = [UIColor whiteColor];
            UIView * rightLine = [[UIView alloc] initWithFrame:CGRectMake(45, 14, 1, 17)];
            rightLine.backgroundColor = WYAOATFLineColor;
            [leftLab addSubview:rightLine];

            WYABottomLineTextField * object = [[WYABottomLineTextField alloc]init];
            object.style = LightContentStyle;
            object.keyboardType = UIKeyboardTypeNumberPad;
            object.font = FONT(20);
            object.placeholder = @"请输入手机号";
            object.leftViewMode = UITextFieldViewModeAlways;
            object.textColor = [UIColor wya_whiteColor];
            object.leftView = leftLab;
            [object setPlaceholderColor:[UIColor wya_whiteColor]];
            object;
       });
    }
    return _usernameTF;
}

- (UILabel *)passwordLab{
    if(!_passwordLab){
        _passwordLab = ({
            UILabel * object = [[UILabel alloc]init];
            object.textColor = [UIColor wya_whiteColor];
            object.text = @"密码";
            object.font = FONT(12);
            object;
        });
    }
    return _passwordLab;
}

- (WYABottomLineTextField *)passwordTF{
    if(!_passwordTF){
        _passwordTF = ({
            WYABottomLineTextField * object = [[WYABottomLineTextField alloc]init];
            object.style = LightContentStyle;
            object.secureTextEntry = YES;
            object.tintColor = [UIColor whiteColor];
            object.placeholder = @"请输入密码";
            [object setPlaceholderColor:[UIColor wya_whiteColor]];
            object.font = FONT(20);
            object.textColor = [UIColor whiteColor];
            object.editingBlock = ^{
                if (self.usernameTF.text.length > 0) {
                    self.loginBtn.enabled = YES;
                }
            };
            object;
       });
    }
    return _passwordTF;;
}

- (UIButton *)loginBtn{
    if(!_loginBtn){
        _loginBtn = ({
            UIButton * object = [[UIButton alloc]init];
            [object setTitle:@"登录" forState:UIControlStateNormal];
            [object setTitleColor:[UIColor wya_textBlackColor] forState:UIControlStateNormal];
            [object setTitleColor:[UIColor wya_textGrayColor] forState:UIControlStateDisabled];
            [object setBackgroundImage:[UIImage wya_createImageWithColor:[UIColor wya_whiteColor]] forState:UIControlStateNormal];
            [object setBackgroundImage:[UIImage wya_createImageWithColor:[UIColor wya_bgColor]] forState:UIControlStateNormal];
            object.layer.cornerRadius = 22 * SizeAdapter;
            object.layer.masksToBounds = YES;
            object.titleLabel.font = FONT(16);
            object.enabled = NO;
            [object addCallBackAction:^(UIButton *button) {
                if (self.loginBlock) {
                    self.loginBlock();
                }
            }];
            object;
       });
    }
    return _loginBtn;
}

- (UILabel *)materialLabel{
    if(!_materialLabel){
        _materialLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.text = @"素材库";
            object.textColor = [UIColor wya_whiteColor];
            object.font = FONT(18);
            object;
       });
    }
    return _materialLabel;
}

- (UIImageView *)wyaImageView{
    if(!_wyaImageView){
        _wyaImageView = ({
            UIImageView * object = [[UIImageView alloc]init];
            object.image = [UIImage imageNamed:@"icon_bottomlogo"];
            object;
        });
    }
    return _wyaImageView;
}

@end
