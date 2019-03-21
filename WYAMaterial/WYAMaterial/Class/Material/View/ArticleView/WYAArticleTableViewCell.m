//
//  WYAArticleTableViewCell.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAArticleTableViewCell.h"

@interface WYAArticleTableViewCell ()
@property (nonatomic, strong) UILabel * articleTitleLabel;
@property (nonatomic, strong) UIButton * forwardingButton;
@property (nonatomic, strong) UILabel * articleContentLabel;
@property (nonatomic, strong) UIImageView * articleImageView;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * forwardingNumLabel;
@property (nonatomic, strong) UILabel * readeNumLabel;
@property (nonatomic, strong) UIButton * bgButton;
@end

@implementation WYAArticleTableViewCell

#pragma mark ======= LifeCircle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.bgButton addSubview:self.articleTitleLabel];
        [self.bgButton addSubview:self.forwardingButton];
        [self.bgButton addSubview:self.articleContentLabel];
        [self.bgButton addSubview:self.articleImageView];
        [self.bgButton addSubview:self.timeLabel];
        [self.bgButton addSubview:self.forwardingNumLabel];
        [self.bgButton addSubview:self.readeNumLabel];

        self.contentView.backgroundColor = [UIColor wya_grayBGColor];
        [self.contentView addSubview:self.bgButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat leftMargin = 20;
    CGFloat width      = ScreenWidth - 2 * leftMargin - 50;
    [self.bgButton mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.contentView.mas_left).offset(leftMargin);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-leftMargin);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    [self.articleTitleLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.bgButton.mas_left).offset(leftMargin);
        make.top.equalTo(self.bgButton.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(width, 30));
    }];
    [self.forwardingButton mas_makeConstraints:^(MASConstraintMaker * make) {
        make.right.equalTo(self.bgButton.mas_right).offset(-5);
        make.top.equalTo(self.bgButton.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];

    [self.articleContentLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.bgButton.mas_left).offset(leftMargin);
        make.top.equalTo(self.articleTitleLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(width, 30));
    }];

    [self.articleImageView mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.bgButton.mas_left).offset(leftMargin);
        make.top.equalTo(self.articleContentLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(width, 160));
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.bgButton.mas_left).offset(leftMargin);
        make.top.equalTo(self.articleImageView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 20));
    }];

    [self.readeNumLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.right.equalTo(self.bgButton.mas_right).offset(-10);
        make.top.equalTo(self.articleImageView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 20));
    }];

    [self.forwardingNumLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.right.equalTo(self.readeNumLabel.mas_left).offset(20);
        make.top.equalTo(self.articleImageView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 20));
    }];

    [self.bgButton wya_setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bgButton wya_setBackgroundColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateHighlighted];
}

#pragma mark ======= Public Method
+ (CGFloat)getCellHeightWithModel:(WYAArticleModel *)model {
    return 310;
}

#pragma mark ======= Setter
- (void)setModel:(WYAArticleModel *)model {
    if (model) {
        _model                        = model;
        self.articleTitleLabel.text   = _model.titleString;
        self.articleContentLabel.text = _model.contentString;
        [self.articleImageView sd_setImageWithURL:[NSURL URLWithString:_model.contentImgString] placeholderImage:[UIImage imageNamed:@"1"]];
        self.timeLabel.text          = _model.timeString;
        self.forwardingNumLabel.text = [NSString stringWithFormat:@"转发 %@", _model.forwardingNumString];
        self.readeNumLabel.text      = [NSString stringWithFormat:@"阅读 %@", _model.readNumString];
        [self layoutIfNeeded];
    }
}
#pragma mark ======= Lazy
- (UILabel *)articleTitleLabel {
    if (!_articleTitleLabel) {
        _articleTitleLabel = ({
            UILabel * object = [[UILabel alloc] init];
            object.textColor = [UIColor blackColor];
            object.font      = FONTS(18);
            object;
        });
    }
    return _articleTitleLabel;
}

- (UIButton *)forwardingButton {
    if (!_forwardingButton) {
        _forwardingButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"转发" forState:UIControlStateNormal];
            object.titleLabel.font = FONT(14);
            [object setTitleColor:[UIColor whiteColor] forState:0];
            object.backgroundColor = [UIColor orangeColor];
            object;
        });
    }
    return _forwardingButton;
}

- (UILabel *)articleContentLabel {
    if (!_articleContentLabel) {
        _articleContentLabel = ({
            UILabel * object = [[UILabel alloc] init];
            object.textColor = [UIColor wya_grayTitleColor];
            object.font      = FONTS(14);
            object;
        });
    }
    return _articleContentLabel;
}

- (UIImageView *)articleImageView {
    if (!_articleImageView) {
        _articleImageView = ({
            UIImageView * object       = [[UIImageView alloc] init];
            object.layer.cornerRadius  = 8;
            object.layer.masksToBounds = YES;
            object;
        });
    }
    return _articleImageView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = ({
            UILabel * object = [[UILabel alloc] init];
            object.textColor = [UIColor wya_grayTitleColor];
            object.font      = FONTS(12);
            object;
        });
    }
    return _timeLabel;
}

- (UILabel *)forwardingNumLabel {
    if (!_forwardingNumLabel) {
        _forwardingNumLabel = ({
            UILabel * object = [[UILabel alloc] init];
            object.textColor = [UIColor wya_grayTitleColor];
            object.font      = FONTS(13);
            object;
        });
    }
    return _forwardingNumLabel;
}

- (UILabel *)readeNumLabel {
    if (!_readeNumLabel) {
        _readeNumLabel = ({
            UILabel * object = [[UILabel alloc] init];
            object.textColor = [UIColor wya_grayTitleColor];
            object.font      = FONTS(13);
            object;
        });
    }
    return _readeNumLabel;
}

- (UIButton *)bgButton {
    if (!_bgButton) {
        _bgButton = ({
            UIButton * object          = [[UIButton alloc] init];
            object.layer.cornerRadius  = 8;
            object.layer.masksToBounds = YES;
            [object addTarget:self action:@selector(bgButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            object;
        });
    }
    return _bgButton;
}
- (void)bgButtonClicked:(UIButton *)sender {
    NSLog(@"哈哈哈哈");
    if (self.DidSelectActionBlock) {
        self.DidSelectActionBlock(self);
    }
}

@end
