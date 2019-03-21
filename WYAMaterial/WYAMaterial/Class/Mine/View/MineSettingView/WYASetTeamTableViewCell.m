//
//  WYASetTeamTableViewCell.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYASetTeamTableViewCell.h"

@interface WYASetTeamTableViewCell ()
@property (nonatomic, strong) UIImageView * leftIconImgView;
@property (nonatomic, strong) UILabel * leftTitleLabel;
@property (nonatomic, strong) UILabel * leftContentLabel;
@property (nonatomic, strong) UIButton * rightbutton;
@end

@implementation WYASetTeamTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.leftIconImgView];
        [self.contentView addSubview:self.leftTitleLabel];
        [self.contentView addSubview:self.leftContentLabel];
        [self.contentView addSubview:self.rightbutton];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.leftIconImgView mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.contentView.mas_left).offset(15*SizeAdapter);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40*SizeAdapter, 40*SizeAdapter));
    }];
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.top.mas_equalTo(self.leftIconImgView);
        make.left.equalTo(self.leftIconImgView.mas_right).offset(8*SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 160*SizeAdapter, 15*SizeAdapter));
    }];
    [self.leftContentLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.bottom.mas_equalTo(self.leftIconImgView);
        make.left.equalTo(self.leftIconImgView.mas_right).offset(8*SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 160*SizeAdapter, 15*SizeAdapter));
    }];
    [self.rightbutton mas_makeConstraints:^(MASConstraintMaker * make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-20*SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(70*SizeAdapter, 15*SizeAdapter));
    }];
}

#pragma mark ======= Setter
- (void)setModel:(WYAMinSettingTeamModel *)model {
    if (model) {
        _model                     = model;
        self.leftIconImgView.image = [UIImage imageNamed:_model.teamIcon];
        self.leftTitleLabel.text   = _model.teamName;
        self.leftContentLabel.text = _model.teamIntroduction;
        [self.rightbutton setTitle:_model.teamState forState:UIControlStateNormal];
        [self.rightbutton setTitleColor:[UIColor wya_blackColor] forState:UIControlStateNormal];
    }
}

#pragma mark ======= Lazy
- (UIImageView *)leftIconImgView {
    if (!_leftIconImgView) {
        _leftIconImgView = ({
            UIImageView * object       = [[UIImageView alloc] init];
            object.layer.cornerRadius  = 20*SizeAdapter;
            object.layer.masksToBounds = YES;
            object;
        });
    }
    return _leftIconImgView;
}

- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = ({
            UILabel * object = [[UILabel alloc] init];
            object.textColor = [UIColor wya_blackColor];
            object.font      = FONT(16);
            object;
        });
    }
    return _leftTitleLabel;
}

- (UILabel *)leftContentLabel {
    if (!_leftContentLabel) {
        _leftContentLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.textColor = [UIColor wya_textGrayColor];
            object.font = FONT(12);
            object;
        });
    }
    return _leftContentLabel;
}

- (UIButton *)rightbutton {
    if (!_rightbutton) {
        _rightbutton = ({
            UIButton * object      = [[UIButton alloc] init];
            object.titleLabel.font = FONT(14);
            [object addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            object;
        });
    }
    return _rightbutton;
}
#pragma mark ======= Event
- (void)rightButtonPressed:(UIButton *)sender {
}
@end
