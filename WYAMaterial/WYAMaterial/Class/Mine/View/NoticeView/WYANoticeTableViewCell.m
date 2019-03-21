//
//  WYANoticeTableViewCell.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/15.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYANoticeTableViewCell.h"

@interface WYANoticeTableViewCell ()
@property (nonatomic, strong) UILabel * noticeContentLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@end

@implementation WYANoticeTableViewCell

#pragma mark ======= LifeCircle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.noticeContentLabel];
        [self.contentView addSubview:self.timeLabel];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat height;
    if ([_model.contentString wya_heightWithFontSize:15 width:ScreenWidth - 87] > 70) {
        height = [_model.contentString wya_heightWithFontSize:15 width:ScreenWidth - 87];
    } else {
        height = 70;
    }

    [self.noticeContentLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(17);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 87, height));
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(16);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
}

#pragma mark ======= Setter

- (void)setModel:(WYAMineNoticeModel *)model {
    if (model) {
        _model                       = model;
        self.noticeContentLabel.text = _model.contentString;
        self.timeLabel.text          = _model.timeString;
        [self layoutIfNeeded];
    }
}

#pragma mark ======= Lazy

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = ({
            UILabel * object = [[UILabel alloc] init];
            object.font      = FONT(11);
            object.textColor = [UIColor wya_grayTitleColor];
            object;
        });
    }
    return _timeLabel;
}

- (UILabel *)noticeContentLabel {
    if (!_noticeContentLabel) {
        _noticeContentLabel = ({
            UILabel * object     = [[UILabel alloc] init];
            object.font          = FONT(15);
            object.textColor     = [UIColor wya_blackTextColor];
            object.numberOfLines = 0;
            object;
        });
    }
    return _noticeContentLabel;
}

#pragma mark ======= Public Method
+ (CGFloat)getCellHeightWithModel:(WYAMineNoticeModel *)model {
    CGFloat cellHeight = [model.contentString wya_heightWithFontSize:15 width:ScreenWidth - 87] > 70 ? [model.contentString wya_heightWithFontSize:15 width:ScreenWidth - 87] + 20 : 70 + 20;
    return cellHeight;
}

@end
