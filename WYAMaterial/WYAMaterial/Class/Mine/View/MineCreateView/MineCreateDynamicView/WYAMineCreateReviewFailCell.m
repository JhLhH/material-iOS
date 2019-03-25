//
//  WYAMineCreateReviewFailCell.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/18.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineCreateReviewFailCell.h"

#import "WYAMineCreateDynamicModel.h"

@interface WYAMineCreateReviewFailCell ()
@property (nonatomic, strong) UIButton * userHeaderButton;       // 用户头像按钮
@property (nonatomic, strong) UILabel * userNameLabel;           // 用户昵称
@property (nonatomic, strong) UIImageView * userLevelImageView;  // 用户层级图片
@property (nonatomic, strong) UILabel * userLevelLabel;          // 用户层级
@property (nonatomic, strong) UILabel * userReleaseTimeLabel;    // 用户发布时间
@property (nonatomic, strong) UILabel * userReleaseContentLabel; // 用户发布内容
@property (nonatomic, strong) UIButton * showButton;             // 全文按钮
@property (nonatomic, strong) UIView * userReleaseImagesView;    // 用户发布图片父视图
@property (nonatomic, strong) UIImageView * reviewStatusImageView;
@property (nonatomic, strong) YYLabel * resultLabel;
@property (nonatomic, strong) UIButton * deleteButton;
@property (nonatomic, strong) UIButton * editButton;
@end

@implementation WYAMineCreateReviewFailCell {
    CGFloat contentHeight;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
        [self.contentView addSubview:self.resultLabel];
        [self.contentView addSubview:self.deleteButton];
        [self.contentView addSubview:self.editButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.userHeaderButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(17 * SizeAdapter);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(20 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(44 * SizeAdapter, 44 * SizeAdapter));
    }];

    [self.userNameLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.top.mas_equalTo(self.userHeaderButton.mas_top).with.offset(2 * SizeAdapter);
        make.left.mas_equalTo(self.userHeaderButton.mas_right).with.offset(11 * SizeAdapter);
        make.width.mas_equalTo(100 * SizeAdapter);
        make.height.mas_equalTo(15 * SizeAdapter);
    }];

    [self.userLevelImageView mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userNameLabel.mas_left);
        make.top.mas_equalTo(self.userNameLabel.mas_bottom).with.offset(8 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(14 * SizeAdapter, 15 * SizeAdapter));
    }];

    [self.userLevelLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userLevelImageView.mas_right).with.offset(8 * SizeAdapter);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-26 * SizeAdapter);
        make.centerY.mas_equalTo(self.userLevelImageView.mas_centerY);
        make.height.mas_equalTo(11 * SizeAdapter);
    }];

    [self.userReleaseContentLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userNameLabel.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-15 * SizeAdapter);
        make.top.mas_equalTo(self.userLevelImageView.mas_bottom).with.offset(17 * SizeAdapter);
        make.height.mas_equalTo(self->contentHeight);
    }];

    [self.showButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userReleaseContentLabel.mas_left);
        make.top.mas_equalTo(self.userReleaseContentLabel.mas_bottom);
        make.width.mas_equalTo(50 * SizeAdapter);
        make.height.mas_equalTo(self.showButton.hidden
                                ? 0
                                : 30 * SizeAdapter);
    }];

    [self.userReleaseImagesView mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.right.mas_equalTo(self.userReleaseContentLabel);
        make.top.mas_equalTo(self.showButton.mas_bottom).with.offset(15 * SizeAdapter);
        make.height.mas_equalTo([self userReleaseImagesViewHeightWith:self.model]);
    }];

    [self.resultLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.right.mas_equalTo(self.userReleaseImagesView);
        make.top.mas_equalTo(self.userReleaseImagesView.mas_bottom).with.offset(10 * SizeAdapter);
        make.height.mas_equalTo([self configYYLabelWithModel:self.model]);
    }];

    [self.editButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-20 * SizeAdapter);
        make.top.mas_equalTo(self.resultLabel.mas_bottom).with.offset(10 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(80 * SizeAdapter, 26 * SizeAdapter));
    }];

    [self.deleteButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.right.mas_equalTo(self.editButton.mas_left).with.offset(-20 * SizeAdapter);
        make.centerY.mas_equalTo(self.editButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60 * SizeAdapter, 26 * SizeAdapter));
    }];

    [self.userReleaseTimeLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.resultLabel.mas_left);
        make.centerY.mas_equalTo(self.deleteButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60 * SizeAdapter, 20 * SizeAdapter));
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
            height = 184 * SizeAdapter;
        } else {
            CGFloat itemHeight = (ScreenWidth - 106 * SizeAdapter) / 3;
            NSInteger row      = agentRingModel.urls.count / 3;
            NSInteger column   = agentRingModel.urls.count % 3;
            if (column == 0) {
                // 整除的
                if (row > 1) {
                    height = itemHeight * row + 10 * SizeAdapter * (row - 1);
                } else {
                    height = itemHeight;
                }
            } else {
                if (row > 0) {
                    height = itemHeight * (row + 1) + 10 * SizeAdapter * row;
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

            CGFloat view_width  = (ScreenWidth - 106 * SizeAdapter) / 3 * 2;
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

                CGFloat view_width  = (self.contentView.cmam_width - 106 * SizeAdapter) / 3;
                CGFloat view_height = view_width;
                CGFloat view_x      = (view_width + 10 * SizeAdapter) * column;
                CGFloat view_y      = (view_width + 10 * SizeAdapter) * row;

                CGRect view_rect = CGRectMake(view_x, view_y, view_width, view_height);
                view.frame       = view_rect;
            }
        }
    }
}

- (CGFloat)configYYLabelWithModel:(WYAMineCreateDynamicModel *)model {

    NSMutableAttributedString * text = [self commentsAttributedStringWithModel:model];

    self.resultLabel.attributedText          = text;
    CGFloat height = 0.0f;
    if (model.show) {
        CGSize introSize      = CGSizeMake(ScreenWidth - 93 * SizeAdapter, CGFLOAT_MAX);
        YYTextLayout * layout = [YYTextLayout layoutWithContainerSize:introSize text:text];
        self.resultLabel.textLayout      = layout;
        CGFloat introHeight   = layout.textBoundingSize.height + 10 * SizeAdapter;
        height = introHeight;
    } else {
        [self addSeeMoreButtonWithYYLabel:self.resultLabel commentsModel:model];
        height = 30 * SizeAdapter;
    }

    return height;
}

- (NSMutableAttributedString *)commentsAttributedStringWithModel:(WYAMineCreateDynamicModel *)model {
    NSString * closeString = @"收起评论";
    NSString * string;
    if (model.show) {
        // 当前评论处于展开状态，添加收起评论字样
        string = [NSString stringWithFormat:@"%@ %@", model.failReslut, closeString];
    } else {
        string = model.failReslut;
    }

    NSMutableAttributedString * text = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange commentsRange            = [string rangeOfString:model.failReslut options:NSCaseInsensitiveSearch];

    NSRange closeRange               = [string rangeOfString:closeString options:NSCaseInsensitiveSearch];

    [text yy_setFont:FONTS(12) range:commentsRange];
    [text yy_setColor:[UIColor wya_redColor] range:commentsRange];
    text.yy_lineSpacing = 2 * SizeAdapter;
    text.yy_kern        = [NSNumber numberWithInt:1 * SizeAdapter];
    if (model.show) {
        // 当前评论处于展开状态，添加收起评论，以及相关事件
        WeakSelf(weakSelf);
        [text yy_setFont:FONT(12) range:closeRange];
        [text yy_setColor:[UIColor wya_blueColor] range:closeRange];

        YYTextHighlight * textHighlight = [YYTextHighlight new];
        [textHighlight setTapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            StrongSelf(strongSelf);
            model.show = NO;
//            if (strongSelf.singleCommentsBlock) {
//                strongSelf.singleCommentsBlock(strongSelf.model);
//            }
        }];
        [text yy_setTextHighlight:textHighlight range:closeRange];
    }
    return text;
}

- (void)addSeeMoreButtonWithYYLabel:(YYLabel *)label commentsModel:(WYAMineCreateDynamicModel *)commentsModel {

    NSMutableAttributedString * text = [[NSMutableAttributedString alloc] initWithString:@"...更多"];

    YYTextHighlight * textHighlight = [YYTextHighlight new];
    [textHighlight setColor:[UIColor wya_blueColor]];
    WeakSelf(weakSelf);
    textHighlight.tapAction = ^(UIView * containerView, NSAttributedString * text, NSRange range, CGRect rect) {
        StrongSelf(strongSelf);
        commentsModel.show = YES;
//        if (strongSelf.singleCommentsBlock) {
//            strongSelf.singleCommentsBlock(strongSelf.model);
//        }

    };
    NSRange range = [text.string rangeOfString:@"更多"];
    [text yy_setColor:[UIColor wya_blueColor] range:range];
    [text yy_setTextHighlight:textHighlight range:range];
    text.yy_font           = FONT(12);
    text.yy_baselineOffset = [NSNumber numberWithInt:-2];
    YYLabel * seeMore      = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];

    NSAttributedString * truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore
                                                                                  contentMode:UIViewContentModeBottom
                                                                               attachmentSize:seeMore.cmam_size
                                                                                  alignToFont:text.yy_font
                                                                                    alignment:YYTextVerticalAlignmentBottom];

    label.truncationToken = truncationToken;
}

#pragma mark ======= Public Method
+ (CGFloat)getCellHeightWithModel:(WYAMineCreateDynamicModel *)model {
    CGFloat height        = 85 * SizeAdapter;
    CGFloat contantHeight = [model.content wya_heightWithFontSize:14 width:ScreenWidth - 88 * SizeAdapter] - 8 * SizeAdapter;
    if (model.contentShow) {
        height = height + contantHeight;
    } else {
        height = height + 40 * SizeAdapter;
    }

    if (contantHeight > 40 * SizeAdapter) {
        height = height + 30 * SizeAdapter;
    }

    WYAMineCreateReviewFailCell * cell = [[WYAMineCreateReviewFailCell alloc] init];
    CGFloat imageH                     = [cell userReleaseImagesViewHeightWith:model];
    CGFloat failResultHeight = [cell configYYLabelWithModel:model];
    return height + imageH + failResultHeight + 70 * SizeAdapter;
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
        CGFloat height = [model.content wya_heightWithFontSize:14 width:ScreenWidth - 88 * SizeAdapter] - 8 * SizeAdapter;
        if (height > 40 * SizeAdapter) {
            self.showButton.hidden = NO;
        } else {
            self.showButton.hidden = YES;
        }

        // 判断全文按钮是否隐藏
        if (model.contentShow) {
            contentHeight            = height;
            self.showButton.selected = YES;
        } else {
            contentHeight            = 40 * SizeAdapter;
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
                object.layer.cornerRadius  = 5 * SizeAdapter;
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
            object.layer.cornerRadius  = 22 * SizeAdapter;
            object.layer.masksToBounds = YES;
            object;
        });
    }
    return _userHeaderButton;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = ({
            UILabel * object = [[UILabel alloc] init];
            object.font      = FONT(15);
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
            object.font      = FONT(11);
            object.textColor = [UIColor wya_goldenLevelTextColor];
            object;
        });
    }
    return _userLevelLabel;
}

- (UILabel *)userReleaseTimeLabel {
    if (!_userReleaseTimeLabel) {
        _userReleaseTimeLabel = ({
            UILabel * object     = [[UILabel alloc] init];
            object.font          = FONT(10);
            object.textAlignment = NSTextAlignmentLeft;
            object.textColor     = [UIColor wya_textGrayColor];
            object;
        });
    }
    return _userReleaseTimeLabel;
}

- (UILabel *)userReleaseContentLabel {
    if (!_userReleaseContentLabel) {
        _userReleaseContentLabel = ({
            UILabel * object     = [[UILabel alloc] init];

            object.font = FONT(14);
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
            object.titleLabel.font            = FONT(15);
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

- (YYLabel *)resultLabel {
    if (!_resultLabel) {
        _resultLabel = ({
            YYLabel * object       = [[YYLabel alloc] init];
            object.preferredMaxLayoutWidth = ScreenWidth - 93 * SizeAdapter;
            object.numberOfLines           = 0;
            object;
        });
    }
    return _resultLabel;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = ({
            CGFloat space     = 12 * SizeAdapter;
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"删除" forState:UIControlStateNormal];
            [object setTitleColor:[UIColor wya_blueColor] forState:UIControlStateNormal];
            [object setImage:[UIImage imageNamed:@"icon_deleteblue"] forState:UIControlStateNormal];
            object.titleLabel.font = FONT(11);
            object.imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space / 2.0);
            object.titleEdgeInsets = UIEdgeInsetsMake(0, space / 2.0, 0, -space / 2.0);
            [object addCallBackAction:^(UIButton * button){
                if (self.deleteBlock) {
                    self.deleteBlock(self.model);
                }
            }];
            object;
        });
    }
    return _deleteButton;
}

- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = ({
            CGFloat space     = 12 * SizeAdapter;
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"重新编辑" forState:UIControlStateNormal];
            [object setTitleColor:[UIColor wya_blueColor] forState:UIControlStateNormal];
            [object setImage:[UIImage imageNamed:@"icon_edtior"] forState:UIControlStateNormal];
            object.titleLabel.font = FONT(11);
            object.imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space / 2.0);
            object.titleEdgeInsets = UIEdgeInsetsMake(0, space / 2.0, 0, -space / 2.0);
            [object addCallBackAction:^(UIButton * button){
                if (self.againEditBlock) {
                    self.againEditBlock(self.model);
                }
            }];
            object;
        });
    }
    return _editButton;
}

- (UIImageView *)reviewStatusImageView {
    if (!_reviewStatusImageView) {
        _reviewStatusImageView = ({
            UIImageView * object       = [[UIImageView alloc] init];
            object.image = [UIImage imageNamed:@"icon_fail"];
            object.layer.cornerRadius  = 30 * SizeAdapter;
            object.layer.masksToBounds = YES;
            object;
        });
    }
    return _reviewStatusImageView;
}
@end
