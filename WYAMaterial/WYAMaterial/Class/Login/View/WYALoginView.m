//
//  WYALoginVIew.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYALoginView.h"

@interface WYALoginView ()
@property (nonatomic, strong) UIImageView * bgImageView;
@property (nonatomic, strong) UILabel * materialLabel;
@property (nonatomic, strong) UIImageView * materialImageView;
@property (nonatomic, strong) UIButton * loginButton;
@property (nonatomic, strong) UIImageView * wyaImageView;
@end

@implementation WYALoginView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.bgImageView];
        [self addSubview:self.materialLabel];
        [self addSubview:self.materialImageView];
        [self addSubview:self.loginButton];
        [self addSubview:self.wyaImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat bgImageView_x = 0;
    CGFloat bgImageView_y = 0;
    CGFloat bgImageView_width = self.cmam_width;
    CGFloat bgImageView_height = self.cmam_height;
    CGRect bgImageView_rect = CGRectMake(bgImageView_x, bgImageView_y,  bgImageView_width, bgImageView_height);
    self.bgImageView.frame = bgImageView_rect;

    CGFloat materialLabel_x = 0;
    CGFloat materialLabel_y = 76 * SizeAdapter;
    CGFloat materialLabel_width = self.cmam_width;
    CGFloat materialLabel_height = 20 * SizeAdapter;
    CGRect materialLabel_rect = CGRectMake(materialLabel_x, materialLabel_y,  materialLabel_width, materialLabel_height);
    self.materialLabel.frame = materialLabel_rect;

    CGFloat materialImageView_x = (self.cmam_width - 166 * SizeAdapter) / 2;
    CGFloat materialImageView_y = self.materialLabel.cmam_bottom + 21 * SizeAdapter;
    CGFloat materialImageView_width = 166 * SizeAdapter;
    CGFloat materialImageView_height = 40 * SizeAdapter;
    CGRect materialImageView_rect = CGRectMake(materialImageView_x, materialImageView_y,  materialImageView_width, materialImageView_height);
    self.materialImageView.frame = materialImageView_rect;

    CGFloat loginButton_x = (self.cmam_width - 300 * SizeAdapter) / 2;
    CGFloat loginButton_y = self.cmam_height - 134 * SizeAdapter;
    CGFloat loginButton_width = 300 * SizeAdapter;
    CGFloat loginButton_height = 48 * SizeAdapter;
    CGRect loginButton_rect = CGRectMake(loginButton_x, loginButton_y,  loginButton_width, loginButton_height);
    self.loginButton.frame = loginButton_rect;

    CGFloat wyaImageView_x = (self.cmam_width - 112 * SizeAdapter) / 2;
    CGFloat wyaImageView_y = self.cmam_height - 36 * SizeAdapter;
    CGFloat wyaImageView_width = 112 * SizeAdapter;
    CGFloat wyaImageView_height = 21 * SizeAdapter;
    CGRect wyaImageView_rect = CGRectMake(wyaImageView_x, wyaImageView_y,  wyaImageView_width, wyaImageView_height);
    self.wyaImageView.frame = wyaImageView_rect;
}

#pragma mark ======= Getter
- (UIImageView *)bgImageView{
    if(!_bgImageView){
        _bgImageView = ({
            UIImageView * object = [[UIImageView alloc]init];
            if (WYAiPhoneX) {
                object.image = [UIImage imageNamed:@"1242-2208"];
            } else {
                object.image = [UIImage imageNamed:@"750-1334"];
            }
            object.contentMode = UIViewContentModeScaleAspectFill;
            object;
        });
    }
    return _bgImageView;
}

- (UILabel *)materialLabel{
    if(!_materialLabel){
        _materialLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.text = @"素材库";
            object.textColor = [UIColor wya_whiteColor];
            object.font = FONT(18);
            object.textAlignment = NSTextAlignmentCenter;
            object;
        });
    }
    return _materialLabel;
}

- (UIImageView *)materialImageView{
    if(!_materialImageView){
        _materialImageView = ({
            UIImageView * object = [[UIImageView alloc]init];
            object.image = [UIImage imageNamed:@"icon_logo"];
            object;
        });
    }
    return _materialImageView;
}


- (UIButton *)loginButton{
    if(!_loginButton){
        _loginButton = ({
            CGFloat space     = 12 * SizeAdapter;
            UIButton *  object = [[UIButton alloc]init];
            [object setTitle:@"微信授权登录" forState:UIControlStateNormal];
            [object setTitleColor:[UIColor wya_textBlackColor] forState:UIControlStateNormal];
            [object setImage:[UIImage imageNamed:@"icon_wechatblack"] forState:UIControlStateNormal];
            object.titleLabel.font = [UIFont systemFontOfSize:18];
            [object setBackgroundImage:[UIImage wya_createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            object.layer.cornerRadius = 24 * SizeAdapter;
            object.layer.masksToBounds = YES;
            object.imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space / 2.0);
            object.titleEdgeInsets = UIEdgeInsetsMake(0, space / 2.0, 0, -space / 2.0);
            [object addCallBackAction:^(UIButton *button) {
                if (self.loginBlock) {
                    self.loginBlock();
                }
            }];
            object;
       });
    }
    return _loginButton;
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
