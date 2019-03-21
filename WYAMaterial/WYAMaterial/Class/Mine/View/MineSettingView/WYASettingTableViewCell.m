//
//  WYASettingTableViewCell.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYASettingTableViewCell.h"

@interface WYASettingTableViewCell ()
@property (nonatomic, strong) UILabel * leftTitleLabel;
@property (nonatomic, strong) UILabel * rightInfoLabel;
@property (nonatomic, strong) UIImageView * rightIconImageView;
@end

@implementation WYASettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.leftTitleLabel];
        [self.contentView addSubview:self.rightInfoLabel];
        [self.contentView addSubview:self.rightIconImageView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.contentView.mas_left).offset(16*SizeAdapter);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50*SizeAdapter, 20*SizeAdapter));
    }];

    [self.rightInfoLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.right.equalTo(self.contentView.mas_right).offset(-21*SizeAdapter);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 90*SizeAdapter, 20*SizeAdapter));
    }];

    [self.rightIconImageView mas_makeConstraints:^(MASConstraintMaker * make) {
        make.right.equalTo(self.contentView.mas_right).offset(-21*SizeAdapter);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(35*SizeAdapter, 35*SizeAdapter));
    }];
}
#pragma mark ======= Setter
- (void)setRow:(NSInteger)row {
    _row = row;
}
- (void)setDataArray:(NSArray<NSString *> *)dataArray {
    if (dataArray) {
        _dataArray               = dataArray;
        self.leftTitleLabel.text = [dataArray firstObject];
        if (_row == 0) {
            self.rightInfoLabel.hidden    = YES;
            self.rightIconImageView.image = [UIImage imageNamed:[dataArray lastObject]];
        } else {
            self.rightIconImageView.hidden = YES;
            self.rightInfoLabel.text       = [dataArray lastObject];
        }
        [self layoutIfNeeded];
    }
}

#pragma mark ======= Lazy
- (UIImageView *)rightIconImageView {
    if (!_rightIconImageView) {
        _rightIconImageView = ({
            UIImageView * object       = [[UIImageView alloc] init];
            object.layer.cornerRadius  = 17.5*SizeAdapter;
            object.layer.masksToBounds = YES;
            object;
        });
    }
    return _rightIconImageView;
}

- (UILabel *)rightInfoLabel {
    if (!_rightInfoLabel) {
        _rightInfoLabel = ({
            UILabel * object     = [[UILabel alloc] init];
            object.font          = FONT(15);
            object.textColor     = [UIColor wya_blackColor];
            object.textAlignment = NSTextAlignmentRight;
            object;
        });
    }
    return _rightInfoLabel;
}

- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = ({
            UILabel * object     = [[UILabel alloc] init];
            object.font          = FONT(16);
            object.textColor     = [UIColor wya_blackColor];
            object.textAlignment = NSTextAlignmentLeft;
            object;
        });
    }
    return _leftTitleLabel;
}
@end
