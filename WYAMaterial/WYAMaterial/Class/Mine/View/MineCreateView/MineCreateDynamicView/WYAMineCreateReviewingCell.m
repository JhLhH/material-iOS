//
//  WYAMineCreateReviewingCell.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineCreateReviewingCell.h"

#import "WYAMineCreateDynamicModel.h"

#import "WYAViewSettingModel.h"

@interface WYAMineCreateReviewingCell ()
@property (nonatomic, strong) UIButton * userHeaderButton;       // 用户头像按钮
@property (nonatomic, strong) UILabel * userNameLabel;           // 用户昵称
@property (nonatomic, strong) UIImageView * userLevelImageView;  // 用户层级图片
@property (nonatomic, strong) UILabel * userLevelLabel;          // 用户层级
@property (nonatomic, strong) UILabel * userReleaseTimeLabel;    // 用户发布时间
@property (nonatomic, strong) UILabel * userReleaseContentLabel; // 用户发布内容
@property (nonatomic, strong) UIButton * showButton;             // 全文按钮
@property (nonatomic, strong) UIView * userReleaseImagesView;    // 用户发布图片父视图
@property (nonatomic, strong) UIImageView * reviewStatusImageView;
@end

@implementation WYAMineCreateReviewingCell {
    CGFloat contentHeight;

    CGFloat userReleaseContentLabelWidth; // 用户发布内容宽度
    CGFloat singleImageWidth; // 单张图片宽度
    CGFloat userReleaseImagesViewWidth; // 承载图片父视图的宽度
    CGFloat releaseImagePadding; // 图片间距
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        userReleaseContentLabelWidth = ScreenWidth - 74 * SizeAdapter;
        singleImageWidth = ScreenWidth - 190.5 * SizeAdapter;
        userReleaseImagesViewWidth = ScreenWidth - 120 * SizeAdapter;
        releaseImagePadding = 5 * SizeAdapter;

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.userHeaderButton];
        [self.contentView addSubview:self.userNameLabel];
        [self.contentView addSubview:self.userLevelImageView];
        [self.contentView addSubview:self.userLevelLabel];
        [self.contentView addSubview:self.userReleaseTimeLabel];
        [self.contentView addSubview:self.userReleaseContentLabel];
        [self.contentView addSubview:self.showButton];
        [self.contentView addSubview:self.userReleaseImagesView];
        [self.contentView addSubview:self.reviewStatusImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.userHeaderButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(userHeaderLeft * SizeAdapter);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(userHeaderTop * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(userHeaderWidth * SizeAdapter, userHeaderWidth * SizeAdapter));
    }];

    [self.userNameLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.top.mas_equalTo(self.userHeaderButton.mas_top).with.offset(userNameLabelTop * SizeAdapter);
        make.left.mas_equalTo(self.userHeaderButton.mas_right).with.offset(userNameLabelLeft * SizeAdapter);
        make.width.mas_equalTo(userNameLabelWidth * SizeAdapter);
        make.height.mas_equalTo(userNameLabelHeight * SizeAdapter);
    }];

    [self.userLevelImageView mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userNameLabel.mas_left);
        make.top.mas_equalTo(self.userNameLabel.mas_bottom).with.offset(userLevelImageViewTop * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(userLevelImageViewWidth * SizeAdapter, userLevelImageViewHeight * SizeAdapter));
    }];

    [self.userLevelLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userLevelImageView.mas_right).with.offset(userLevelLabelLeft * SizeAdapter);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-userLevelLabelRight * SizeAdapter);
        make.centerY.mas_equalTo(self.userLevelImageView.mas_centerY);
        make.height.mas_equalTo(userLevelLabelHeight * SizeAdapter);
    }];

    [self.userReleaseContentLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userNameLabel.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-userReleaseContentLabelRight * SizeAdapter);
        make.top.mas_equalTo(self.userLevelImageView.mas_bottom).with.offset(userReleaseContentLabelTop * SizeAdapter);
        make.height.mas_equalTo(self->contentHeight);
    }];

    [self.showButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userReleaseContentLabel.mas_left);
        make.top.mas_equalTo(self.userReleaseContentLabel.mas_bottom).with.offset(self.showButton.hidden ? 0 : showButtonTop * SizeAdapter);
        make.width.mas_equalTo(showButtonWidth * SizeAdapter);
        make.height.mas_equalTo(self.showButton.hidden
                                ? 0
                                : showButtonHeight * SizeAdapter);
    }];

    [self.userReleaseImagesView mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userReleaseContentLabel);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-userReleaseImagesViewRight * SizeAdapter);
        make.top.mas_equalTo(self.showButton.mas_bottom).with.offset(userReleaseImagesViewTop * SizeAdapter);
        make.height.mas_equalTo([self userReleaseImagesViewHeightWith:self.model]);
    }];

    [self.userReleaseTimeLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userReleaseImagesView.mas_left);
        make.top.mas_equalTo(self.userReleaseImagesView.mas_bottom).with.offset(userReleaseTimeLabelTop * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(userReleaseTimeLabelWidth * SizeAdapter, userReleaseTimeLabelHeight * SizeAdapter));
    }];

    [self.reviewStatusImageView mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-17 * SizeAdapter);
        make.top.mas_equalTo(self.contentView).with.offset(40 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(60 * SizeAdapter, 60 * SizeAdapter));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark ======= Private Method
- (CGFloat)userReleaseImagesViewHeightWith:(WYAMineCreateDynamicModel *)agentRingModel {
    CGFloat height = 0.0f;
    if (agentRingModel.urls.count > 0) {
        if (agentRingModel.urls.count < 2) {
            height = singleImageWidth;
        } else {
            CGFloat itemHeight = (userReleaseImagesViewWidth - 2 * releaseImagePadding) / 3;
            NSInteger row      = agentRingModel.urls.count / 3;
            NSInteger column   = agentRingModel.urls.count % 3;
            if (column == 0) {
                // 整除的
                if (row > 1) {
                    height = itemHeight * row + releaseImagePadding * (row - 1);
                } else {
                    height = itemHeight;
                }
            } else {
                if (row > 0) {
                    height = itemHeight * (row + 1) + releaseImagePadding * row;
                } else {
                    height = itemHeight;
                }
            }
        }
    }
    return height;
}

- (void)addUserReleaseImageViewSubView {
    if (self.userReleaseImagesView.subviews.count > 0) {
        if (self.userReleaseImagesView.subviews.count < 2) {
            UIView * view = [self.userReleaseImagesView.subviews firstObject];

            CGFloat view_width  = singleImageWidth;
            CGFloat view_height = view_width;
            CGFloat view_x      = 0;
            CGFloat view_y      = 0;

            CGRect view_rect = CGRectMake(view_x, view_y, view_width, view_height);
            view.frame       = view_rect;
        } else {
            for (NSInteger index = 0; index < self.userReleaseImagesView.subviews.count; index++) {
                UIView * view  = self.userReleaseImagesView.subviews[index];
                CGFloat row    = index / 3;
                CGFloat column = index % 3;

                CGFloat view_width  = (userReleaseImagesViewWidth - 2 * releaseImagePadding) / 3;
                CGFloat view_height = view_width;
                CGFloat view_x      = (view_width + releaseImagePadding) * column;
                CGFloat view_y      = (view_width + releaseImagePadding) * row;

                CGRect view_rect = CGRectMake(view_x, view_y, view_width, view_height);
                view.frame       = view_rect;
            }
        }
    }
}

#pragma mark ======= Public Method
+ (CGFloat)getCellHeightWithModel:(WYAMineCreateDynamicModel *)model {
    CGFloat height        = (userHeaderTop
                             + userNameLabelTop
                             + userNameLabelHeight
                             + userLevelImageViewTop
                             + userLevelImageViewHeight
                             + userReleaseContentLabelTop) * SizeAdapter;

    CGFloat contantHeight = [model.content wya_heightWithFontSize:userReleaseContentLabelFont width:ScreenWidth - 74 * SizeAdapter] - 10 * SizeAdapter;
    if (model.contentShow) {
        height = height + contantHeight;
    } else {
        height = height + userReleaseContentLabelNormalHeight * SizeAdapter;
    }

    if (contantHeight > userReleaseContentLabelNormalHeight * SizeAdapter) {
        height = height + (showButtonTop + showButtonHeight) * SizeAdapter;
    }

    WYAMineCreateReviewingCell * cell = [[WYAMineCreateReviewingCell alloc] init];
    CGFloat imageH          = [cell userReleaseImagesViewHeightWith:model];

    return height + imageH + (userReleaseTimeLabelTop
                              + userReleaseTimeLabelHeight
                              + userReleaseTimeLabelBottom) * SizeAdapter;

}

#pragma mark ======= Setter
- (void)setModel:(WYAMineCreateDynamicModel *)model {
    _model = model;
    if (model) {
        //        self.userHeaderButton
        self.userNameLabel.text           = model.userName;
        self.userLevelLabel.text          = model.userLevel;
        self.userReleaseTimeLabel.text    = model.time;
        self.userReleaseContentLabel.text = model.content;
        
        // 判断全文按钮是否显示
        CGFloat height = [model.content wya_heightWithFontSize:userReleaseContentLabelFont width:userReleaseContentLabelWidth] - userReleaseContentLabelPadding * SizeAdapter;
        if (height > userReleaseContentLabelNormalHeight * SizeAdapter) {
            self.showButton.hidden = NO;
        } else {
            self.showButton.hidden = YES;
        }

        // 判断全文按钮是否隐藏
        if (model.contentShow) {
            contentHeight            = height;
            self.showButton.selected = YES;
        } else {
            contentHeight            = userReleaseContentLabelNormalHeight * SizeAdapter;
            self.showButton.selected = NO;
        }

        // 添加图片
        if (self.model.urls.count > 0) {
            for (UIView * view in self.userReleaseImagesView.subviews) {
                view.hidden = YES;
                [view removeFromSuperview];
            }

            for (NSInteger index = 0; index < model.urls.count; index++) {
                UIButton * object = [[UIButton alloc] init];
                [object setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
                object.tag                 = index;
                object.layer.cornerRadius  = releaseImageCornerRadius * SizeAdapter;
                object.layer.masksToBounds = YES;
                [object addCallBackAction:^(UIButton * button) {
                    if (self.imageBlock) {
                        self.imageBlock(model, self.userReleaseImagesView.subviews, button.tag);
                    }
                }];
                [self.userReleaseImagesView addSubview:object];
            }
            [self addUserReleaseImageViewSubView];
        }
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}

#pragma mark ======= Getter
- (UIButton *)userHeaderButton {
    if (!_userHeaderButton) {
        _userHeaderButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setBackgroundImage:[UIImage wya_createImageWithColor:randomColor] forState:UIControlStateNormal];
            object.layer.cornerRadius  = userHeaderCornerRadius * SizeAdapter;
            object.layer.masksToBounds = YES;
            object.layer.borderColor = [UIColor wya_goldenColor].CGColor;
            object.layer.borderWidth = userHeaderBorderWidth * SizeAdapter;
            object;
        });
    }
    return _userHeaderButton;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = ({
            UILabel * object = [[UILabel alloc] init];
            object.font      = FONT(userNameLabelFont);
            object.textColor = [UIColor wya_textLightBlackColor];
            object;
        });
    }
    return _userNameLabel;
}

- (UIImageView *)userLevelImageView {
    if (!_userLevelImageView) {
        _userLevelImageView = ({
            UIImageView * object = [[UIImageView alloc] init];
            object.image         = [UIImage imageNamed:@"icon_huizhang"];
            object;
        });
    }
    return _userLevelImageView;
}

- (UILabel *)userLevelLabel {
    if (!_userLevelLabel) {
        _userLevelLabel = ({
            UILabel * object = [[UILabel alloc] init];
            object.font      = FONT(userLevelLabelFont);
            object.textColor = [UIColor wya_goldenLevelTextColor];
            object;
        });
    }
    return _userLevelLabel;
}

- (UILabel *)userReleaseContentLabel {
    if (!_userReleaseContentLabel) {
        _userReleaseContentLabel = ({
            UILabel * object     = [[UILabel alloc] init];

            object.font = FONT(userReleaseContentLabelFont);
            object.textColor = [UIColor wya_textBlackColor];
            object.numberOfLines           = 0;
            object;
        });
    }
    return _userReleaseContentLabel;
}

- (UIView *)userReleaseImagesView {
    if (!_userReleaseImagesView) {
        _userReleaseImagesView = ({
            UIView * object = [[UIView alloc] init];
            object;
        });
    }
    return _userReleaseImagesView;
}

- (UILabel *)userReleaseTimeLabel {
    if (!_userReleaseTimeLabel) {
        _userReleaseTimeLabel = ({
            UILabel * object     = [[UILabel alloc] init];
            object.font          = FONT(userReleaseTimeLabelFont);
            object.textAlignment = NSTextAlignmentLeft;
            object.textColor     = [UIColor wya_textGrayColor];
            object;
        });
    }
    return _userReleaseTimeLabel;
}

- (UIButton *)showButton {
    if (!_showButton) {
        _showButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"全文" forState:UIControlStateNormal];
            [object setTitle:@"收起" forState:UIControlStateSelected];
            [object setTitleColor:[UIColor wya_blueColor] forState:UIControlStateNormal];
            [object setTitleColor:[UIColor wya_blueColor] forState:UIControlStateSelected];
            object.hidden                     = YES;
            object.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            object.titleLabel.font            = FONT(showButtonFont);
            [object addCallBackAction:^(UIButton * button) {
                self.model.contentShow = !self.model.contentShow;
                button.selected        = self.model.contentShow;
                if (self.stretchBlock) {
                    self.stretchBlock(self.model);
                }
            }];
            object;
        });
    }
    return _showButton;
}

- (UIImageView *)reviewStatusImageView {
    if (!_reviewStatusImageView) {
        _reviewStatusImageView = ({
            UIImageView * object       = [[UIImageView alloc] init];
            object.image = [UIImage imageNamed:@"icon_inreview"];
            object.layer.cornerRadius  = 30 * SizeAdapter;
            object.layer.masksToBounds = YES;
            object;
        });
    }
    return _reviewStatusImageView;
}

@end
