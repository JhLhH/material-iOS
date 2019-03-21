//
//  WYAMineTableViewCell.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineTableViewCell.h"

@interface WYAMineTableViewCell ()
@property (nonatomic, strong) UIImageView * mineIconImageView;
@property (nonatomic, strong) UILabel * mineLabel;
@property (nonatomic, strong) UIButton * mineArrowButton;
@property (nonatomic, strong) UIView * mineLineView;
@end

@implementation WYAMineTableViewCell

#pragma mark ======= LifeCircle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.mineIconImageView];
        [self.contentView addSubview:self.mineLabel];
        [self.contentView addSubview:self.mineArrowButton];
        [self.contentView addSubview:self.mineLineView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.mineIconImageView mas_makeConstraints:^(MASConstraintMaker * make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(10 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];

    [self.mineLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.centerY.mas_equalTo(self.mineIconImageView.mas_centerY);
        make.left.equalTo(self.mineIconImageView.mas_right).offset(10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(200 * SizeAdapter);
    }];

    [self.mineArrowButton mas_makeConstraints:^(MASConstraintMaker * make) {
        make.centerY.mas_equalTo(self.mineIconImageView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(25);
    }];

    [self.mineLineView mas_makeConstraints:^(MASConstraintMaker * make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mineLabel.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark ======= Setter
- (void)setDataDict:(NSDictionary *)dataDict {
    if (dataDict.allKeys.count > 1) {
        _dataDict                    = dataDict;
        self.mineIconImageView.image = [UIImage imageNamed:_dataDict[@"icon"]];
        self.mineLabel.text          = _dataDict[@"content"];
        [self layoutIfNeeded];
    }
}

#pragma mark ======= Lazy

- (UIImageView *)mineIconImageView {
    if (!_mineIconImageView) {
        _mineIconImageView = ({
            UIImageView * object       = [[UIImageView alloc] init];
            object.backgroundColor     = [UIColor wya_grayTitleColor];
            object.layer.cornerRadius  = 8;
            object.layer.masksToBounds = YES;
            object;
        });
    }
    return _mineIconImageView;
}

- (UILabel *)mineLabel {
    if (!_mineLabel) {
        _mineLabel = ({
            UILabel * object = [[UILabel alloc] init];
            object.textColor = [UIColor wya_blackTextColor];
            object.font      = FONT(16);
            object;
        });
    }
    return _mineLabel;
}

- (UIButton *)mineArrowButton {
    if (!_mineArrowButton) {
        _mineArrowButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@">" forState:UIControlStateNormal];
            [object setTitleColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateNormal];
            //            [object setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            object;
        });
    }
    return _mineArrowButton;
}

- (UIView *)mineLineView {
    if (!_mineLineView) {
        _mineLineView = ({
            UIView * object        = [[UIView alloc] init];
            object.backgroundColor = [UIColor groupTableViewBackgroundColor];
            object;
        });
    }
    return _mineLineView;
}
@end
