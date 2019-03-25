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

        self.contentView.backgroundColor = [UIColor wya_bgColor];
        [self.contentView addSubview:self.bgButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat leftMargin = 16*SizeAdapter;
    CGFloat width      = ScreenWidth - 2 * leftMargin;
    [self.bgButton mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.contentView.mas_left).offset(10*SizeAdapter);
        make.top.equalTo(self.contentView.mas_top).offset(leftMargin);
        make.right.equalTo(self.contentView.mas_right).offset(-10*SizeAdapter);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    [self.articleTitleLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.bgButton.mas_left).offset(leftMargin);
        make.top.equalTo(self.bgButton.mas_top).offset(leftMargin);
        make.size.mas_equalTo(CGSizeMake(width - 47*SizeAdapter, 20*SizeAdapter));
    }];
    [self.forwardingButton mas_makeConstraints:^(MASConstraintMaker * make) {
        make.right.equalTo(self.bgButton.mas_right).offset(-leftMargin);
        make.top.equalTo(self.bgButton.mas_top).offset(18*SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(15*SizeAdapter, 14*SizeAdapter));
    }];

    [self.articleContentLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.bgButton.mas_left).offset(leftMargin);
        make.top.equalTo(self.articleTitleLabel.mas_bottom).offset(19*SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(width, 20*SizeAdapter));
    }];

    [self.articleImageView mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.bgButton.mas_left).offset(leftMargin);
        make.top.equalTo(self.articleContentLabel.mas_bottom).offset(17*SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(width, 170*SizeAdapter));
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.bgButton.mas_left).offset(leftMargin);
        make.top.equalTo(self.articleImageView.mas_bottom).offset(18*SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(90*SizeAdapter, 10*SizeAdapter));
    }];

    [self.readeNumLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.right.equalTo(self.bgButton.mas_right).offset(-15*SizeAdapter);
        make.top.equalTo(self.articleImageView.mas_bottom).offset(16*SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(60*SizeAdapter, 12*SizeAdapter));
    }];

    [self.forwardingNumLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.right.equalTo(self.readeNumLabel.mas_left).offset(-17*SizeAdapter);
        make.top.equalTo(self.articleImageView.mas_bottom).offset(16*SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(60*SizeAdapter, 12*SizeAdapter));
    }];

    [self.bgButton wya_setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bgButton wya_setBackgroundColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateHighlighted];
}

#pragma mark ======= Public Method
+ (CGFloat)getCellHeightWithModel:(WYAArticleModel *)model {
    return 330*SizeAdapter;
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
            object.textColor = [UIColor wya_textBlackColor];
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
            [object setBackgroundImage:[UIImage imageNamed:@"icon_zhuanfablack"] forState:UIControlStateNormal];
            [object setBackgroundImage:[UIImage imageNamed:@"icon_zhuanfa"] forState:UIControlStateHighlighted];
            [object setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
            [object addTarget:self action:@selector(forwardingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            object;
        });
    }
    return _forwardingButton;
}

- (UILabel *)articleContentLabel {
    if (!_articleContentLabel) {
        _articleContentLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.textColor = [UIColor wya_textDarkGrayColor];
            object.font = FONTS(15);
            object;
        });
    }
    return _articleContentLabel;
}

- (UIImageView *)articleImageView {
    if (!_articleImageView) {
        _articleImageView = ({
            UIImageView * object       = [[UIImageView alloc] init];
            object.layer.cornerRadius  = 8*SizeAdapter;
            object.layer.masksToBounds = YES;
            object;
        });
    }
    return _articleImageView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.textColor = [UIColor wya_textGrayColor];
            object.font = FONTS(10);
            object;
        });
    }
    return _timeLabel;
}

- (UILabel *)forwardingNumLabel {
    if (!_forwardingNumLabel) {
        _forwardingNumLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.textColor = [UIColor wya_textGrayColor];
            object.font = FONTS(12);
            object.textAlignment = NSTextAlignmentRight;
            object;
        });
    }
    return _forwardingNumLabel;
}

- (UILabel *)readeNumLabel {
    if (!_readeNumLabel) {
        _readeNumLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.textColor = [UIColor wya_textGrayColor];
            object.font = FONTS(12);
            object.textAlignment = NSTextAlignmentRight;
            object;
        });
    }
    return _readeNumLabel;
}

- (UIButton *)bgButton {
    if (!_bgButton) {
        _bgButton = ({
            UIButton * object          = [[UIButton alloc] init];
            object.layer.cornerRadius  = 8*SizeAdapter;
            object.layer.masksToBounds = YES;
            [object addTarget:self action:@selector(bgButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            object;
        });
    }
    return _bgButton;
}
#pragma mark ======= Event

- (void)bgButtonClicked:(UIButton *)sender {
    NSLog(@"哈哈哈哈");
    if (self.DidSelectActionBlock) {
        self.DidSelectActionBlock(self);
    }
}

- (void)forwardingButtonClicked:(UIButton *)sender{
    NSLog(@"转发");
    if (self.ForwardingActionBlock) {
        self.ForwardingActionBlock(self);
    }
}

@end
