//
//  WYAMineCreateMaterialTableViewCell.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineCreateMaterialTableViewCell.h"

#import "WYAMineCreateMaterialImgBodyView.h"

#import <SDWebImage/UIButton+WebCache.h>

#define ITEM_MARGIN 10 * SizeAdapter
#define ITEM_WH (ScreenWidth - 88 * SizeAdapter - 3 * ITEM_MARGIN) / 3

#define DEFAULT_CONTENT_HEIGHT 80 * SizeAdapter

#define CONTENT_WIDTH (ScreenWidth - 88 * SizeAdapter)

@interface WYAMineCreateMaterialTableViewCell ()
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
@property (nonatomic, strong) WYAMineCreateMaterialImgBodyView * userBodyImageView;
/// 转发
@property (nonatomic, strong) UIButton * forwardingButton;
/// 收藏
@property (nonatomic, strong) UIButton * collectionButton;
/// 分割线
@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, assign) BOOL isAnimation;

/// 审核状态视图
@property (nonatomic, strong) UIImageView * auditImgView;
@end

@implementation WYAMineCreateMaterialTableViewCell
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
        [self.contentView addSubview:self.auditImgView];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.userHeaderButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.contentView.mas_left).offset(17 * SizeAdapter);
        make.top.equalTo(self.contentView.mas_top).offset(18 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(44 * SizeAdapter, 44 * SizeAdapter));
    }];

    CGFloat userNameWidth = [_model.mineCreateUserName wya_widthWithFontSize:15 height:15 * SizeAdapter];
    [self.userNameLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.userHeaderButton.mas_right).offset(11 * SizeAdapter);
        make.top.equalTo(self.contentView.mas_top).offset(20 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(userNameWidth, 15 * SizeAdapter));
    }];

    [self.userLevelIconView mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.userHeaderButton.mas_right).offset(10 * SizeAdapter);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(8 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(15 * SizeAdapter, 15 * SizeAdapter));
    }];

    CGFloat userLevelWidth = [_model.mineCreateUserInfoString wya_widthWithFontSize:11 height:10 * SizeAdapter];
    [self.userLevelLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.userLevelIconView.mas_right).offset(8 * SizeAdapter);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(10 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(userLevelWidth, 10 * SizeAdapter));
    }];

    [self.userContentLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.contentView.mas_left).offset(73 * SizeAdapter);
        make.top.equalTo(self.userLevelLabel.mas_bottom).offset(15 * SizeAdapter);
        make.right.equalTo(self.contentView.mas_right).offset(-15 * SizeAdapter);
        make.height.mas_equalTo(self.contentHeight);
    }];

    [self.auditImgView mas_makeConstraints:^(MASConstraintMaker * make) {
        make.right.equalTo(self.contentView.mas_right).offset(-14 * SizeAdapter);
        make.bottom.equalTo(self.userContentLabel.mas_top).offset(24 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(60 * SizeAdapter, 60 * SizeAdapter));
    }];

    [self.showAllBodyButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userContentLabel.mas_left);
        make.top.equalTo(self.userContentLabel.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(40 * SizeAdapter, self.showAllBodyButton.hidden ? 0 : 10 * SizeAdapter));

    }];

    if (_model.mineCreateBodyImgArray.count > 1) {
        int index;
        if (_model.mineCreateBodyImgArray.count <= 3) {
            index = 1;
        } else if (_model.mineCreateBodyImgArray.count > 6) {
            index = 3;
        } else {
            index = 2;
        }
        CGFloat height = index * (ITEM_MARGIN + ITEM_WH);
        [self.userBodyImageView mas_remakeConstraints:^(MASConstraintMaker * make) {
            make.left.mas_equalTo(self.userContentLabel.mas_left);
            make.top.equalTo(self.showAllBodyButton.mas_bottom).offset(15 * SizeAdapter);
            make.size.mas_equalTo(CGSizeMake(CONTENT_WIDTH, height));
        }];
    } else if(_model.mineCreateBodyImgArray.count == 1){
        [self.userBodyImageView mas_remakeConstraints:^(MASConstraintMaker * make) {
            make.left.mas_equalTo(self.userContentLabel.mas_left);
            make.top.equalTo(self.showAllBodyButton.mas_bottom).offset(15 * SizeAdapter);
            make.size.mas_equalTo(CGSizeMake(200 * SizeAdapter, 200 * SizeAdapter));
        }];
    }else{
        [self.userBodyImageView mas_remakeConstraints:^(MASConstraintMaker * make) {
            make.left.mas_equalTo(self.userContentLabel.mas_left);
            make.top.equalTo(self.showAllBodyButton.mas_bottom).offset(15 * SizeAdapter);
            make.size.mas_equalTo(CGSizeMake(200 * SizeAdapter, 0));
        }];
    }

    [self.userTimeLabel mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.left.mas_equalTo(self.userContentLabel.mas_left);
        make.top.equalTo(self.userBodyImageView.mas_bottom).offset(20 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(60 * SizeAdapter, 8 * SizeAdapter));
    }];

    [self.forwardingButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.right.equalTo(self.contentView.mas_right).offset(-25 * SizeAdapter);
        make.top.equalTo(self.userBodyImageView.mas_bottom).offset(17 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(50 * SizeAdapter, 15 * SizeAdapter));
    }];

    [self.collectionButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.right.equalTo(self.forwardingButton.mas_left).offset(-26 * SizeAdapter);
        make.top.equalTo(self.userBodyImageView.mas_bottom).offset(17 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(50 * SizeAdapter, 15 * SizeAdapter));
    }];

    [self.lineView mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark ======= Setter
- (void)setModel:(WYAMineCreateMaterialModel *)model {
    if (model) {
        _model = model;
        [self.userHeaderButton sd_setImageWithURL:[NSURL URLWithString:_model.mineCreateUserIconName] forState:0];
        self.userNameLabel.text = _model.mineCreateUserName;
        self.userLevelLabel.text          = _model.mineCreateUserInfoString;
        self.userTimeLabel.text           = _model.mineCreateTimeString;
        self.userContentLabel.text        = _model.mineCreateBodyString;
        self.userBodyImageView.imageArray = _model.mineCreateBodyImgArray.count > 0 ? _model.mineCreateBodyImgArray:nil;

        self.userTimeLabel.hidden = YES;
        self.forwardingButton.hidden = YES;
        self.collectionButton.hidden = YES;
        self.lineView.hidden = YES;
        if ([_model.mineCreateAuditType isEqualToString:@"正在审核"]) {
            self.auditImgView.image = [UIImage imageNamed:@"icon_inreview"];
            self.userTimeLabel.hidden = NO;
            self.lineView.hidden = NO;
        }if ([_model.mineCreateAuditType isEqualToString:@"审核失败"]) {
            self.auditImgView.image = [UIImage imageNamed:@"icon_fail"];
        }else if ([_model.mineCreateAuditType isEqualToString:@"审核成功"]){
            self.userTimeLabel.hidden = NO;
            self.forwardingButton.hidden = NO;
            self.collectionButton.hidden = NO;
            self.lineView.hidden = NO;
            self.auditImgView.image = [UIImage imageNamed:@"icon_successful"];
        }
        // 判断全文按钮是否显示
        CGFloat height = [_model.mineCreateBodyString wya_heightWithFontSize:14 width:CONTENT_WIDTH];
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
            UILabel * object     = [[UILabel alloc] init];
            object.textColor     = [UIColor wya_blackColor];
            object.font          = FONT(15);
            object.textAlignment = NSTextAlignmentCenter;
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
- (WYAMineCreateMaterialImgBodyView *)userBodyImageView {
    if (!_userBodyImageView) {
        _userBodyImageView = ({
            WYAMineCreateMaterialImgBodyView * object = [[WYAMineCreateMaterialImgBodyView alloc] init];
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

- (UIImageView *)auditImgView {
    if (!_auditImgView) {
        _auditImgView = ({
            UIImageView * object       = [[UIImageView alloc] init];
            object.layer.cornerRadius  = 30 * SizeAdapter;
            object.layer.masksToBounds = YES;
            object;
        });
    }
    return _auditImgView;
}
#pragma mark ======= Event
- (void)forwardingButtonClicked:(UIButton *)sender {
    if (self.forwardingActionBlock) {
        self.forwardingActionBlock(self);
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

+ (CGFloat)getCellHeightWithModel:(WYAMineCreateMaterialModel *)model {

    CGFloat contentHeight = [model.mineCreateBodyString wya_heightWithFontSize:14 width:CONTENT_WIDTH];

    if (!model.isShowContent) {
        if (contentHeight > DEFAULT_CONTENT_HEIGHT) {
            contentHeight = DEFAULT_CONTENT_HEIGHT;
        }
    }

    CGFloat bodyImgHeight;
    if (model.mineCreateBodyImgArray.count > 1) {
        int index;
        if (model.mineCreateBodyImgArray.count <= 3) {
            index = 1;
        } else if (model.mineCreateBodyImgArray.count > 6) {
            index = 3;
        } else {
            index = 2;
        }
        bodyImgHeight = index * (ITEM_MARGIN + ITEM_WH);
    } else if(model.mineCreateBodyImgArray.count == 1){
        bodyImgHeight = 200 * SizeAdapter;
    }else{
        bodyImgHeight = 0;
    }

    CGFloat bottomHeight;

    if ([model.mineCreateAuditType isEqualToString:@"审核失败"]) {
        bottomHeight = 37 * SizeAdapter;
    } else {
        bottomHeight = 52 * SizeAdapter;
    }

    return 70 * SizeAdapter + contentHeight + 15 * SizeAdapter + bodyImgHeight + bottomHeight;
}

@end
