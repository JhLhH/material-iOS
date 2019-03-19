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
@property (nonatomic, strong) UILabel * userReleaseContentLabel; // 用户发布内容
@property (nonatomic, strong) UIButton * showButton; // 全文按钮
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
        [self.contentView addSubview:self.showButton];
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

    [self.showButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userReleaseContentLabel.mas_left);
        make.top.mas_equalTo(self.userReleaseContentLabel.mas_bottom);
        make.width.mas_equalTo(50 * SizeAdapter);
        make.height.mas_equalTo(self.showButton.hidden
                                ? 0
                                : 30 * SizeAdapter);
    }];

    [self.userReleaseImagesView mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.right.mas_equalTo(self.userReleaseContentLabel);
        make.top.mas_equalTo(self.showButton.mas_bottom).with.offset(0 * SizeAdapter);
        make.height.mas_equalTo([self userReleaseImagesViewHeightWith:self.model]);
    }];

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
- (CGFloat)userReleaseImagesViewHeightWith:(WYAAgentRingModel *)agentRingModel{
    CGFloat height = 0.0f;
    if (agentRingModel.urls.count > 0) {
        CGFloat itemHeight = (ScreenWidth - 89 * SizeAdapter) / 3;
        if (agentRingModel.urls.count < 2) {
            height = itemHeight * 2;
        } else {
            NSInteger row = agentRingModel.urls.count / 3;
            NSInteger column = agentRingModel.urls.count % 3;
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

- (void)addUserReleaseImageViewSubView{
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
}

#pragma mark ======= Public Method
+ (CGFloat)getCellHeightWithModel:(WYAAgentRingModel *)model {
    CGFloat height = 56.0f;
    CGFloat contantHeight = [model.content wya_heightWithFontSize:15 width:ScreenWidth - 69 * SizeAdapter];
    if (model.contentShow) {
        height = height + contantHeight;
    } else {
        height = height + 51 * SizeAdapter;
    }

    if (contantHeight > 51 * SizeAdapter) {
        height = height + 30 * SizeAdapter;
    }

    WYAAgentRingCell * cell = [[WYAAgentRingCell alloc] init];
    CGFloat imageH = [cell userReleaseImagesViewHeightWith:model];
    return height + imageH + 40 * SizeAdapter;
}

#pragma mark ======= Setter
- (void)setModel:(WYAAgentRingModel *)model {
    _model = model;
    if (model) {
        //        self.userHeaderButton
        self.userNameLabel.text           = model.userName;
        self.userLevelLabel.text          = model.userLevel;
        self.userReleaseTimeLabel.text    = model.time;
        self.userReleaseContentLabel.text = model.content;
        self.forwardingButton.selected    = model.forwarding;
        [self.collectionButton setTitle:[NSString stringWithFormat:@"%d", model.collection] forState:UIControlStateNormal];
        [self.praiseButton setTitle:[NSString stringWithFormat:@"%d", model.person] forState:UIControlStateNormal];

        // 判断全文按钮是否显示
        CGFloat height = [model.content wya_heightWithFontSize:15 width:ScreenWidth - 69 * SizeAdapter];
        if (height > 51 * SizeAdapter) {
            self.showButton.hidden = NO;
        }else{
            self.showButton.hidden = YES;
        }

        // 判断全文按钮是否隐藏
        if (model.contentShow) {
            contentHeight   = height;
            self.showButton.selected = YES;
        } else {
            contentHeight = 51 * SizeAdapter;
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
                object.tag = index;
                object.layer.cornerRadius = 5 * SizeAdapter;
                object.layer.masksToBounds = YES;
                [object addCallBackAction:^(UIButton * button){
                    if (self.imageBlock) {
                        self.imageBlock(model, button.tag);
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
            object.layer.cornerRadius = 16 * SizeAdapter;
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
            object.textAlignment = NSTextAlignmentRight;
            object.textColor     = [UIColor grayColor];
            object;
        });
    }
    return _userReleaseTimeLabel;
}

- (UILabel *)userReleaseContentLabel {
    if (!_userReleaseContentLabel) {
        _userReleaseContentLabel = ({
            UILabel * object     = [[UILabel alloc] init];
            object.font = FONT(15);
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
            CGFloat space = 3.f;
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"转发" forState:UIControlStateNormal];
            [object setTitle:@"已转" forState:UIControlStateSelected];
            [object setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [object setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            object.titleLabel.font            = FONT(13);
            object.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [object setImage:[UIImage imageNamed:@"点赞已选"] forState:UIControlStateNormal];
            object.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            object.titleEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
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
            CGFloat space = 3.f;
            UIButton * object = [[UIButton alloc] init];
            object.titleLabel.font = FONT(13);
            [object setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [object setImage:[UIImage imageNamed:@"点赞已选"] forState:UIControlStateNormal];
            object.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            object.titleEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
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
            CGFloat space = 3.f;
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"评论" forState:UIControlStateNormal];
            [object setTitle:@"已评" forState:UIControlStateSelected];
            [object setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [object setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            object.titleLabel.font = FONT(13);
            [object setImage:[UIImage imageNamed:@"点赞已选"] forState:UIControlStateNormal];
            object.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            object.titleEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
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
            CGFloat space = 3.f;
            UIButton * object = [[UIButton alloc] init];
            [object setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [object setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            object.titleLabel.font = FONT(13);
            [object setImage:[UIImage imageNamed:@"点赞已选"] forState:UIControlStateNormal];
            object.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            object.titleEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
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


- (UIButton *)showButton{
    if(!_showButton){
        _showButton = ({
            UIButton *  object = [[UIButton alloc]init];
            [object setTitle:@"全文" forState:UIControlStateNormal];
            [object setTitle:@"收起" forState:UIControlStateSelected];
            [object setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [object setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            object.hidden = YES;
            object.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            object.titleLabel.font = FONT(15);
            [object addCallBackAction:^(UIButton *button) {
                self.model.contentShow = !self.model.contentShow;
                button.selected = self.model.contentShow;
                if (self.stretchBlock) {
                    self.stretchBlock(self.model);
                }
            }];
            object;
       });
    }
    return _showButton;
}

@end
