//
//  WYAImageTextTableViewCell.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/16.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAImageTextTableViewCell.h"
#import "WYAImgTextBodyView.h"
#import <SDWebImage/UIButton+WebCache.h>

#define ITEM_MARGIN 5 * SizeAdapter
#define ITEM_WH (ScreenWidth - 120 * SizeAdapter - 2 * ITEM_MARGIN) / 3

#define DEFAULT_IMAGE_SIZE (ScreenWidth - 190.5 * SizeAdapter)

#define CONTENT_WIDTH (ScreenWidth - 74 * SizeAdapter)

#define IMAGE_WIDTH (ScreenWidth - 120 * SizeAdapter)

#define DEFAULT_CONTENT_HEIGHT 80*SizeAdapter

@interface WYAImageTextTableViewCell ()
@property (nonatomic, assign) CGFloat contentHeight;
/// 用户头像按钮
@property (nonatomic, strong) UIButton * userHeaderButton;
/// 用户昵称
@property (nonatomic, strong) UILabel * userNameLabel;
/// 层级图标
@property (nonatomic, strong) UIImageView * userLevelIconView;
/// 用户层级
@property (nonatomic, strong) UILabel * userLevelLabel;
/// 用户发布时间
@property (nonatomic, strong) UILabel * userTimeLabel;
/// 用户发布内容
@property (nonatomic, strong) UILabel * userContentLabel;
/// 全文按钮
@property (nonatomic, strong) UIButton * showAllBodyButton;
/// 图片视图
@property (nonatomic, strong) WYAImgTextBodyView * userBodyImageView;
/// 转发
@property (nonatomic, strong) UIButton * forwardingButton;
/// 收藏
@property (nonatomic, strong) UIButton * collectionButton;
/// 分割线
@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, assign) BOOL isAnimation;

@end

@implementation WYAImageTextTableViewCell

#pragma mark ======= LifeCircle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.userHeaderButton];
        [self.contentView addSubview:self.userNameLabel];
        [self.contentView addSubview:self.userLevelIconView];
        [self.contentView addSubview:self.userLevelLabel];
        [self.contentView addSubview:self.userTimeLabel];
        [self.contentView addSubview:self.userContentLabel];
        [self.contentView addSubview:self.showAllBodyButton];
        [self.contentView addSubview:self.userBodyImageView];
        [self.contentView addSubview:self.forwardingButton];
        [self.contentView addSubview:self.collectionButton];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.userHeaderButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.contentView.mas_left).offset(12 * SizeAdapter);
        make.top.equalTo(self.contentView.mas_top).offset(18 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(40 * SizeAdapter, 40 * SizeAdapter));
    }];

    CGFloat userNameWidth = [_model.userName wya_widthWithFontSize:15 height:15 * SizeAdapter];
    [self.userNameLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.userHeaderButton.mas_right).offset(10 * SizeAdapter);
        make.top.equalTo(self.contentView.mas_top).offset(20 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(userNameWidth, 15 * SizeAdapter));
    }];

    [self.userLevelIconView mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.userHeaderButton.mas_right).offset(10 * SizeAdapter);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(8.5 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(15 * SizeAdapter, 15 * SizeAdapter));
    }];

    CGFloat userLevelWidth = [_model.userInfoString wya_widthWithFontSize:11 height:10 * SizeAdapter];
    [self.userLevelLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.userLevelIconView.mas_right).offset(8 * SizeAdapter);
        make.centerY.mas_equalTo(self.userLevelIconView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(userLevelWidth, 11 * SizeAdapter));
    }];

    [self.userContentLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.contentView.mas_left).offset(62 * SizeAdapter);
        make.top.equalTo(self.userLevelLabel.mas_bottom).offset(12 * SizeAdapter);
        make.right.equalTo(self.contentView.mas_right).offset(-12 * SizeAdapter);
        make.height.mas_equalTo(self.contentHeight);
    }];

    [self.showAllBodyButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userContentLabel.mas_left);
        make.top.equalTo(self.userContentLabel.mas_bottom).offset(5*SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(40 * SizeAdapter, self.showAllBodyButton.hidden ? 0 : 20 * SizeAdapter));

    }];

    if (_model.bodyImgArray.count > 1) {
        int index;
        if (_model.bodyImgArray.count <= 3) {
            index = 1;
        } else if (_model.bodyImgArray.count > 6) {
            index = 3;
        } else {
            index = 2;
        }
        CGFloat height = index * (ITEM_MARGIN + ITEM_WH);
        [self.userBodyImageView mas_remakeConstraints:^(MASConstraintMaker * make) {
            make.left.mas_equalTo(self.userContentLabel.mas_left);
            make.top.equalTo(self.showAllBodyButton.mas_bottom).offset(12 * SizeAdapter);
            make.size.mas_equalTo(CGSizeMake(IMAGE_WIDTH, height));
        }];
    } else if(_model.bodyImgArray.count == 1){
        [self.userBodyImageView mas_remakeConstraints:^(MASConstraintMaker * make) {
            make.left.mas_equalTo(self.userContentLabel.mas_left);
            make.top.equalTo(self.showAllBodyButton.mas_bottom).offset(12 * SizeAdapter);
            make.size.mas_equalTo(CGSizeMake(DEFAULT_IMAGE_SIZE, DEFAULT_IMAGE_SIZE));
        }];
    }else{
        [self.userBodyImageView mas_remakeConstraints:^(MASConstraintMaker * make) {
            make.left.mas_equalTo(self.userContentLabel.mas_left);
            make.top.equalTo(self.showAllBodyButton.mas_bottom).offset(12 * SizeAdapter);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }

    [self.userTimeLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userContentLabel.mas_left);
        make.top.equalTo(self.userBodyImageView.mas_bottom).offset(12 * SizeAdapter);
        make.width.mas_equalTo(60 * SizeAdapter);
        make.height.mas_equalTo(8*SizeAdapter);
    }];

    [self.forwardingButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12 * SizeAdapter);
        make.centerY.mas_equalTo(self.userTimeLabel.mas_centerY);
        make.width.mas_equalTo(50 * SizeAdapter);
        make.height.mas_equalTo(15*SizeAdapter);
    }];

    [self.collectionButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.right.equalTo(self.forwardingButton.mas_left).offset(-27 * SizeAdapter);
        make.centerY.mas_equalTo(self.userTimeLabel.mas_centerY);
        make.width.mas_equalTo(50 * SizeAdapter);
        make.height.mas_equalTo(15*SizeAdapter);
    }];

    [self.lineView mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark ======= Setter
- (void)setModel:(WYAImageTextModel *)model {
    if (model) {
        _model = model;
        [self.userHeaderButton sd_setImageWithURL:[NSURL URLWithString:_model.userIconName] forState:0];
        self.userNameLabel.text = _model.userName;
        self.userLevelLabel.text          = _model.userInfoString;
        self.userTimeLabel.text           = _model.timeString;
        self.userContentLabel.text        = _model.bodyString;
        self.userBodyImageView.imageArray = _model.bodyImgArray.count > 0 ? _model.bodyImgArray : nil;

        // 判断全文按钮是否显示
//        CGFloat height = [_model.bodyString wya_heightWithFontSize:14 width:CONTENT_WIDTH];
        CGFloat height = [UILabel getHeightByWidth:CONTENT_WIDTH title:_model.bodyString font:[UIFont systemFontOfSize:14*SizeAdapter]];
        if (height > DEFAULT_CONTENT_HEIGHT) {
            self.showAllBodyButton.hidden = NO;
        } else {
            self.showAllBodyButton.hidden = YES;
        }

        // 判断全文按钮是否隐藏
        if (_model.isShowContent) {
            self.contentHeight              = height;
            self.showAllBodyButton.selected = YES;
        } else {
            if (height < DEFAULT_CONTENT_HEIGHT) {
                self.contentHeight = height;
            } else {
                self.contentHeight = DEFAULT_CONTENT_HEIGHT;
            }
            self.showAllBodyButton.selected = NO;
        }

        [self layoutIfNeeded];
    }
}
#pragma mark ======= Lazy
- (UIButton *)userHeaderButton {
    if (!_userHeaderButton) {
        _userHeaderButton = ({
            UIButton * object          = [[UIButton alloc] init];
            object.backgroundColor     = [UIColor wya_lightBlackColor];
            object.layer.cornerRadius  = 20 * SizeAdapter;
            object.layer.masksToBounds = YES;
            object;
        });
    }
    return _userHeaderButton;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = ({
            UILabel * object     = [[UILabel alloc] init];
            object.textColor     = [UIColor wya_textBlackColor];
            object.font          = FONT(15);
//            object.textAlignment = NSTextAlignmentLeft;
            object;
        });
    }
    return _userNameLabel;
}

- (UIImageView *)userLevelIconView {
    if (!_userLevelIconView) {
        _userLevelIconView = ({
            UIImageView * object   = [[UIImageView alloc] init];
            object.image = [UIImage imageNamed:@"icon_huizhang"];
            object;
        });
    }
    return _userLevelIconView;
}

- (UILabel *)userLevelLabel {
    if (!_userLevelLabel) {
        _userLevelLabel = ({
            UILabel * object = [[UILabel alloc] init];
            object.textColor = [UIColor wya_goldenLevelTextColor];
            object.font      = FONT(11);
            object;
        });
    }
    return _userLevelLabel;
}

- (UILabel *)userTimeLabel {
    if (!_userTimeLabel) {
        _userTimeLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.textColor = [UIColor wya_textGrayColor];
            object.font = FONT(10);
            object;
        });
    }
    return _userTimeLabel;
}

- (UILabel *)userContentLabel {
    if (!_userContentLabel) {
        _userContentLabel = ({
            UILabel * object     = [[UILabel alloc] init];
            object.textColor     = [UIColor wya_textBlackColor];
            object.font          = FONT(14);
            object.numberOfLines = 0;
            object.textAlignment = NSTextAlignmentLeft;
            object;
        });
    }
    return _userContentLabel;
}

- (UIButton *)showAllBodyButton {
    if (!_showAllBodyButton) {
        _showAllBodyButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"全文" forState:0];
            [object setTitle:@"收起" forState:UIControlStateSelected];
            [object setTitleColor:[UIColor wya_blueColor] forState:0];
            [object setTitleColor:[UIColor wya_blueColor] forState:UIControlStateSelected];
            [object addTarget:self action:@selector(showAllBodyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            object.titleLabel.font          = FONT(14);
            object.titleLabel.textAlignment = NSTextAlignmentLeft;
            object;
        });
    }
    return _showAllBodyButton;
}
- (WYAImgTextBodyView *)userBodyImageView {
    if (!_userBodyImageView) {
        _userBodyImageView = ({
            WYAImgTextBodyView * object = [[WYAImgTextBodyView alloc] init];
            object.ImageButtonAction = ^(NSArray * _Nonnull views, NSInteger index) {
                if (self.showImageActionBlock) {
                    self.showImageActionBlock(self, views, index);
                }
            };
            object;
        });
    }
    return _userBodyImageView;
}

- (UIButton *)collectionButton {
    if (!_collectionButton) {
        _collectionButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"收藏" forState:0];
            [object setTitleColor:[UIColor wya_textBlackColor] forState:0];
            [object setImage:[UIImage imageNamed:@"icon_collect"] forState:UIControlStateNormal];
            [object setImage:[UIImage imageNamed:@"icon_collect_press"] forState:UIControlStateSelected];
            [object addTarget:self action:@selector(collectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            object.titleLabel.font = FONT(12);
            CGFloat space = 6*SizeAdapter;
            object.imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space / 2.0);
            object.titleEdgeInsets = UIEdgeInsetsMake(0, space / 2.0, 0, -space / 2.0);
            object;
        });
    }
    return _collectionButton;
}

- (UIButton *)forwardingButton {
    if (!_forwardingButton) {
        _forwardingButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"转发" forState:0];
//            [object setTitle:@"已转发" forState:UIControlStateSelected];
            [object setTitleColor:[UIColor wya_textBlackColor] forState:0];
            [object setImage:[UIImage imageNamed:@"icon_zhuanfa"] forState:UIControlStateNormal];
            object.titleLabel.font = FONT(12);
            CGFloat space = 6*SizeAdapter;
            object.imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space / 2.0);
            object.titleEdgeInsets = UIEdgeInsetsMake(0, space / 2.0, 0, -space / 2.0);
            [object addTarget:self action:@selector(forwardingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            object;
        });
    }
    return _forwardingButton;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = ({
            UIView * object        = [[UIView alloc] init];
            object.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];
            object;
        });
    }
    return _lineView;
}

#pragma mark ======= Event
- (void)forwardingButtonClicked:(UIButton *)sender {
    if ([WXApi isWXAppInstalled]) {
        if (self.forwardingActionBlock) {
            self.forwardingActionBlock(self);
        }
    }else{
        [UIView wya_showCenterToastWithMessage:@"请安装微信后使用该功能"];
    }

}
- (void)collectionButtonClicked:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (self.collectionActionBlock) {
        self.collectionActionBlock(self);
    }
}

- (void)showAllBodyButtonClicked:(UIButton *)sender {

    self.model.isShowContent = !self.model.isShowContent;
    sender.selected          = self.model.isShowContent;
    if (self.showAllBodyActionBlock) {
        self.showAllBodyActionBlock(self.cellIndexPath);
    }
}

#pragma mark ======= Public Method

+ (CGFloat)getCellHeightWithModel:(WYAImageTextModel *)model {

    CGFloat contentHeight = [UILabel getHeightByWidth:CONTENT_WIDTH title:model.bodyString font:[UIFont systemFontOfSize:14*SizeAdapter]];
    CGFloat showAllHeight = 0;
    if (contentHeight> DEFAULT_CONTENT_HEIGHT) {
        showAllHeight = 25*SizeAdapter;
    }
    if (!model.isShowContent) {
        if (contentHeight > DEFAULT_CONTENT_HEIGHT) {
            contentHeight = DEFAULT_CONTENT_HEIGHT;
        }
    }

    CGFloat bodyImgHeight;
    if (model.bodyImgArray.count > 1) {
        int index;
        if (model.bodyImgArray.count <= 3) {
            index = 1;
        } else if (model.bodyImgArray.count > 6) {
            index = 3;
        } else {
            index = 2;
        }
        bodyImgHeight = index * (ITEM_MARGIN + ITEM_WH);
    } else if(model.bodyImgArray.count == 1){
        bodyImgHeight = DEFAULT_IMAGE_SIZE;
    }else{
        bodyImgHeight = 0;
    }

    return 70.5 * SizeAdapter + contentHeight + showAllHeight + bodyImgHeight + 47 * SizeAdapter;
}
@end
