//
//  WYANoticeTableViewCell.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/15.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYANoticeTableViewCell.h"

@interface WYANoticeTableViewCell()
@property (nonatomic, strong) UILabel * noticeContentLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UIView * bgView;
@end

@implementation WYANoticeTableViewCell

#pragma mark ======= LifeCircle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.bgView addSubview:self.noticeContentLabel];
        [self.bgView addSubview:self.timeLabel];
        [self.contentView addSubview:self.bgView];
        self.backgroundColor = [UIColor wya_grayBGColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];

    CGFloat height = [_model.contentString wya_heightWithFontSize:14 width:ScreenWidth-20];
    [self.noticeContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 20, height));
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.noticeContentLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.noticeContentLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 20, 20));
    }];
}

#pragma mark ======= Setter

- (void)setModel:(WYAMineNoticeModel *)model{
    if (model) {
        _model = model;
        self.noticeContentLabel.text = _model.contentString;
        self.timeLabel.text = _model.timeString;
        [self layoutIfNeeded];
    }
}

#pragma mark ======= Lazy

- (UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.font = FONT(12);
            object.textColor = [UIColor wya_grayTitleColor];
            object;
       });
    }
    return _timeLabel;
}

- (UILabel *)noticeContentLabel{
    if(!_noticeContentLabel){
        _noticeContentLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.font = FONT(14);
            object.textColor = [UIColor wya_blackTextColor];
            object.numberOfLines = 0;
            object;
       });
    }
    return _noticeContentLabel;
}

- (UIView *)bgView{
    if(!_bgView){
        _bgView = ({
            UIView * object = [[UIView alloc]init];
            object.backgroundColor = [UIColor wya_whiteColor];
            object;
        });
    }
    return _bgView;
}
#pragma mark ======= Public Method
+ (CGFloat)getCellHeightWithModel:(WYAMineNoticeModel *)model{
    CGFloat cellHeight = 5 + [model.contentString wya_heightWithFontSize:14 width:ScreenWidth-20] + 5 + 35;
    return cellHeight;
}

@end
