//
//  WYAAgentRingCell.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAAgentRingCell.h"
#import "WYAAgentRingModel.h"

@interface WYAAgentRingCell ()
@property (nonatomic, strong) UIButton * userHeaderButton;       // 用户头像按钮
@property (nonatomic, strong) UILabel * userNameLabel;           // 用户昵称
@property (nonatomic, strong) UILabel * userLevelLabel;          // 用户层级
@property (nonatomic, strong) UILabel * userReleaseTimeLabel;    // 用户发布时间
@property (nonatomic, strong) YYLabel * userReleaseContentLabel; // 用户发布内容
@property (nonatomic, strong) UIView * userReleaseImagesView;    // 用户发布图片父视图
@property (nonatomic, strong) UIButton * forwardingButton;       // 转发
@property (nonatomic, strong) UIButton * collectionButton;       // 收藏
@property (nonatomic, strong) UIButton * commentsButton;         // 评论
@property (nonatomic, strong) UIButton * praiseButton;           // 点赞

@end

@implementation WYAAgentRingCell
{
    CGFloat contentHeight;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.userHeaderButton];
        [self.contentView addSubview:self.userNameLabel];
        [self.contentView addSubview:self.userLevelLabel];
        [self.contentView addSubview:self.userReleaseTimeLabel];
        [self.contentView addSubview:self.userReleaseContentLabel];
        [self.contentView addSubview:self.userReleaseImagesView];
        [self.contentView addSubview:self.forwardingButton];
        [self.contentView addSubview:self.collectionButton];
        [self.contentView addSubview:self.commentsButton];
        [self.contentView addSubview:self.praiseButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.userHeaderButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(16 * SizeAdapter);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(16 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(32 * SizeAdapter, 32 * SizeAdapter));
    }];

    [self.userNameLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.top.mas_equalTo(self.userHeaderButton.mas_top);
        make.left.mas_equalTo(self.userHeaderButton.mas_right).with.offset(5 * SizeAdapter);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(15 * SizeAdapter);
    }];

    [self.userLevelLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userNameLabel.mas_left);
        make.top.mas_equalTo(self.userNameLabel.mas_bottom).with.offset(5 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(60 * SizeAdapter, 15 * SizeAdapter));
    }];

    [self.userReleaseTimeLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userLevelLabel.mas_right);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-16 * SizeAdapter);
        make.centerY.mas_equalTo(self.userLevelLabel.mas_centerY);
        make.height.mas_equalTo(15 * SizeAdapter);
    }];

    [self.userReleaseContentLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userNameLabel.mas_left);
        make.right.mas_equalTo(self.userReleaseTimeLabel.mas_right);
        make.top.mas_equalTo(self.userReleaseTimeLabel.mas_bottom).with.offset(5 * SizeAdapter);
        make.height.mas_equalTo(self->contentHeight);
    }];

    [self.userReleaseImagesView mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.right.mas_equalTo(self.userReleaseContentLabel);
        make.top.mas_equalTo(self.userReleaseContentLabel.mas_bottom).with.offset(10 * SizeAdapter);
        if (self.model.urls.count > 0) {
            CGFloat itemHeight = (ScreenWidth - 89 * SizeAdapter) / 3;
            if (self.model.urls.count < 2) {
                make.height.mas_equalTo(itemHeight * 2);
            } else {
                NSInteger row = self.model.urls.count / 3;
                NSInteger column = self.model.urls.count % 3;
                NSLog(@"row==%d,column=%d",row,column);
                if (column == 0) {
                    // 整除的
                    if (row > 1) {
                        make.height.mas_equalTo(itemHeight * row + 10 * SizeAdapter * (row - 1));
                    } else {
                        make.height.mas_equalTo(itemHeight);
                    }
                } else {
                    if (row > 0) {
                        make.height.mas_equalTo(itemHeight * (row + 1) + 10 * SizeAdapter * row);
                    } else {
                        make.height.mas_equalTo(itemHeight);
                    }

                }
            }
        }
    }];

    if (self.userReleaseImagesView.subviews.count > 0) {
        if (self.userReleaseImagesView.subviews.count < 2) {
            UIView * view = [self.userReleaseImagesView.subviews firstObject];

            CGFloat view_width = (ScreenWidth - 89 * SizeAdapter) / 3 * 2;
            CGFloat view_height = view_width;
            CGFloat view_x = 0;
            CGFloat view_y = 0;

            CGRect view_rect = CGRectMake(view_x, view_y,  view_width, view_height);
            view.frame = view_rect;
        } else {
            for (NSInteger index = 0; index < self.userReleaseImagesView.subviews.count; index++) {
                UIView * view = self.userReleaseImagesView.subviews[index];
                CGFloat row = index / 3;
                CGFloat column = index % 3;

                CGFloat view_width = (self.contentView.cmam_width - 89 * SizeAdapter) / 3;
                CGFloat view_height = view_width;
                CGFloat view_x = (view_width + 10 * SizeAdapter) * column;
                CGFloat view_y = (view_width + 10 * SizeAdapter) * row;

                CGRect view_rect = CGRectMake(view_x, view_y,  view_width, view_height);
                view.frame = view_rect;
            }
        }
    }

//    [self.userReleaseImagesView.subviews wya_mas_distributeSudokuViewsWithFixedLineSpacing:5 * SizeAdapter
//                                                                     fixedInteritemSpacing:5 * SizeAdapter
//                                                                                 warpCount:3
//                                                                                topSpacing:0
//                                                                             bottomSpacing:0
//                                                                               leadSpacing:0
//                                                                               tailSpacing:0];

    [self.forwardingButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userReleaseImagesView.mas_left);
        make.top.mas_equalTo(self.userReleaseImagesView.mas_bottom).with.offset(10 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(60 * SizeAdapter, 20 * SizeAdapter));
    }];

    [self.collectionButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.forwardingButton.mas_right).with.offset(10 * SizeAdapter);
        make.centerY.mas_equalTo(self.forwardingButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60 * SizeAdapter, 20 * SizeAdapter));
    }];

    [self.commentsButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.collectionButton.mas_right).with.offset(20 * SizeAdapter);
        make.centerY.mas_equalTo(self.forwardingButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60 * SizeAdapter, 20 * SizeAdapter));
    }];

    [self.praiseButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.commentsButton.mas_right).with.offset(20 * SizeAdapter);
        make.centerY.mas_equalTo(self.forwardingButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80 * SizeAdapter, 20 * SizeAdapter));
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
- (void)addSeeMoreButtonWithAgentRingModel:(WYAAgentRingModel *)agentRingModel {

    NSMutableAttributedString * text = [[NSMutableAttributedString alloc] initWithString:@"...全文"];

    YYTextHighlight * textHighlight = [YYTextHighlight new];
    [textHighlight setColor:[UIColor blueColor]];
    WeakSelf(weakSelf);
    textHighlight.tapAction = ^(UIView * containerView, NSAttributedString * text, NSRange range, CGRect rect) {
        StrongSelf(strongSelf);
        agentRingModel.contentShow = YES;
        if (strongSelf.stretchBlock) {
            strongSelf.stretchBlock(strongSelf.model);
        }

    };

    [text yy_setColor:[UIColor blueColor] range:[text.string rangeOfString:@"全文"]];
    [text yy_setTextHighlight:textHighlight range:[text.string rangeOfString:@"全文"]];
    text.yy_font = FONT(13);

    YYLabel * seeMore      = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];

    NSAttributedString * truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore
                                                                                  contentMode:UIViewContentModeCenter
                                                                               attachmentSize:seeMore.cmam_size
                                                                                  alignToFont:text.yy_font
                                                                                    alignment:YYTextVerticalAlignmentCenter];

    self.userReleaseContentLabel.truncationToken = truncationToken;
}

#pragma mark ======= Public Method
+ (CGFloat)getCellHeightWithModel:(WYAAgentRingModel *)model {
    WYAAgentRingCell * cell = [[WYAAgentRingCell alloc] initWithStyle:0 reuseIdentifier:@"xxx"];
    cell.model              = model;
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
//    NSLog(@"hei==%f",cell.userReleaseImagesView.cmam_bottom);
//    NSLog(@"height==%f",cell.forwardingButton.cmam_bottom);

    return cell.forwardingButton.cmam_bottom + 10 * SizeAdapter;
}

#pragma mark ======= Setter
- (void)setModel:(WYAAgentRingModel *)model {
    _model = model;
    if (model) {
        //        self.userHeaderButton
        self.userNameLabel.text           = model.userName;
        self.userLevelLabel.text          = model.userLevel;
        self.userReleaseTimeLabel.text    = model.time;

        self.forwardingButton.selected    = model.forwarding;
        self.collectionButton.selected    = model.collection;
        [self.praiseButton setTitle:[NSString stringWithFormat:@"%d点赞", model.person] forState:UIControlStateNormal];

        NSMutableAttributedString * text = [[NSMutableAttributedString alloc]initWithString:model.content];
        self.userReleaseContentLabel.attributedText = text;
        CGSize introSize      = CGSizeMake(ScreenWidth - 69 * SizeAdapter, CGFLOAT_MAX);
        YYTextLayout * layout = [YYTextLayout layoutWithContainerSize:introSize text:text];
        if (model.contentShow) {
            self.userReleaseContentLabel.textLayout      = layout;
            contentHeight   = layout.textBoundingSize.height;

        } else {
            if (layout.textBoundingSize.height > 36 * SizeAdapter) {
                [self addSeeMoreButtonWithAgentRingModel:model];
                contentHeight = 36 * SizeAdapter;
            } else {
                contentHeight = layout.textBoundingSize.height;
            }
        }

        if (self.model.urls.count > 0) {
            for (UIView * view in self.userReleaseImagesView.subviews) {
                [view removeFromSuperview];
            }

            for (WYAAgentRingImageModel * imageModel in model.urls) {
                UIButton * object = [[UIButton alloc] init];
                [object setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
                [object addCallBackAction:^(UIButton * button){

                }];
                [self.userReleaseImagesView addSubview:object];
            }
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
            object.text      = @"李世航";
            object.textColor = [UIColor grayColor];
            object;
        });
    }
    return _userNameLabel;
}

- (UILabel *)userLevelLabel {
    if (!_userLevelLabel) {
        _userLevelLabel = ({
            UILabel * object = [[UILabel alloc] init];
            object.font      = FONT(13);
            object.text      = @"总部";
            object.textColor = [UIColor grayColor];
            object;
        });
    }
    return _userLevelLabel;
}

- (UILabel *)userReleaseTimeLabel {
    if (!_userReleaseTimeLabel) {
        _userReleaseTimeLabel = ({
            UILabel * object     = [[UILabel alloc] init];
            object.font          = FONT(13);
            object.text          = @"2019-3-14 14:05";
            object.textAlignment = NSTextAlignmentRight;
            object.textColor     = [UIColor grayColor];
            object;
        });
    }
    return _userReleaseTimeLabel;
}

- (YYLabel *)userReleaseContentLabel {
    if (!_userReleaseContentLabel) {
        _userReleaseContentLabel = ({
            YYLabel * object     = [[YYLabel alloc] init];
            object.preferredMaxLayoutWidth = ScreenWidth - 69 * SizeAdapter;
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

- (UIButton *)forwardingButton {
    if (!_forwardingButton) {
        _forwardingButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"转发" forState:UIControlStateNormal];
            [object setTitle:@"已转" forState:UIControlStateSelected];
            [object setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [object setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            object.titleLabel.font            = FONT(13);
            object.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [object addCallBackAction:^(UIButton * button) {
                if (self.forwardingBlock) {
                    self.forwardingBlock(self.model);
                }
            }];
            object;
        });
    }
    return _forwardingButton;
}

- (UIButton *)collectionButton {
    if (!_collectionButton) {
        _collectionButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"收藏" forState:UIControlStateNormal];
            [object setTitle:@"已藏" forState:UIControlStateSelected];
            [object setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [object setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            object.titleLabel.font = FONT(13);
            [object addCallBackAction:^(UIButton * button) {
                if (self.collectionBlock) {
                    self.collectionBlock(self.model);
                }
            }];
            object;
        });
    }
    return _collectionButton;
}

- (UIButton *)commentsButton {
    if (!_commentsButton) {
        _commentsButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"评论" forState:UIControlStateNormal];
            [object setTitle:@"已评" forState:UIControlStateSelected];
            [object setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [object setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            object.titleLabel.font = FONT(13);
            [object addCallBackAction:^(UIButton * button) {
                if (self.commentsBlock) {
                    self.commentsBlock(self.model);
                }
            }];
            object;
        });
    }
    return _commentsButton;
}

- (UIButton *)praiseButton {
    if (!_praiseButton) {
        _praiseButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"66人点赞" forState:UIControlStateNormal];
            [object setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [object setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            object.titleLabel.font = FONT(13);
            [object addCallBackAction:^(UIButton * button) {
                if (self.praiseBlock) {
                    self.praiseBlock(self.model);
                }
            }];
            object;
        });
    }
    return _praiseButton;
}

@end
