//
//  WYAImageTextTableViewCell.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/16.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAImageTextTableViewCell.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "WYAImgTextBodyView.h"

#define ITEM_WH 100
#define ITEM_MARGIN 10

#define LEFT_MARGIN 10

@interface WYAImageTextTableViewCell()
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
@end
@implementation WYAImageTextTableViewCell

#pragma mark ======= LifeCircle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.userHeaderButton];
        [self.contentView addSubview:self.userNameLabel];
        [self.contentView addSubview:self.userLevelIconView];
        [self.contentView addSubview:self.userLevelLabel];
        [self.contentView addSubview:self.userTimeLabel];
        [self.contentView addSubview:self.userContentLabel];
        [self.contentView addSubview:self.userBodyImageView];
        [self.contentView addSubview:self.forwardingButton];
        [self.contentView addSubview:self.collectionButton];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.userHeaderButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];

    CGFloat userNameWidth = [_model.userName wya_widthWithFontSize:15 height:20];
    [self.userNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userHeaderButton.mas_right).offset(LEFT_MARGIN);
        make.centerY.mas_equalTo(self.userHeaderButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(userNameWidth, 20));
    }];

    [self.userLevelIconView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.userNameLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];

    CGFloat userLevelWidth = [_model.userInfoString wya_widthWithFontSize:13 height:20];
    [self.userLevelLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userLevelIconView.mas_right).offset(5);
        make.top.mas_equalTo(self.userNameLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(userLevelWidth, 20));
    }];


    [self.userTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.userNameLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];

    CGFloat bodyTextHeight = [_model.bodyString wya_heightWithFontSize:14 width:ScreenWidth - 67 - 10];
    [self.userContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userHeaderButton.mas_right).offset(LEFT_MARGIN);
        make.top.equalTo(self.userHeaderButton.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 67 - 10, bodyTextHeight));
    }];

    if (_model.bodyImgArray.count > 1) {
        int index;
        if (_model.bodyImgArray.count<=3) {
            index = 1;
        }else if (_model.bodyImgArray.count>6){
            index = 3;
        }else{
            index = 2;
        }
        CGFloat height = index * (ITEM_MARGIN + ITEM_WH);
        [self.userBodyImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userHeaderButton.mas_right).offset(LEFT_MARGIN);
            make.top.equalTo(self.userContentLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth - 67 - 10, height));
        }];
    }else{
        [self.userBodyImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userHeaderButton.mas_right).offset(LEFT_MARGIN);
            make.top.equalTo(self.userContentLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(200, 200));
        }];
    }

    [self.collectionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(243*SizeAdapter);
        make.top.equalTo(self.userBodyImageView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 15));
    }];

    [self.forwardingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.collectionButton.mas_right).offset(30);
        make.top.equalTo(self.userBodyImageView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 15));
    }];

    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];

}

#pragma mark ======= Setter
- (void)setModel:(WYAImageTextModel *)model{
    if (model) {
        _model = model;
        [self.userHeaderButton sd_setImageWithURL:[NSURL URLWithString:_model.userIconName] forState:0];
        self.userNameLabel.text = _model.userName;
        [self.userLevelIconView sd_setImageWithURL:[NSURL URLWithString:_model.userInfoImgString] placeholderImage:nil];
        self.userLevelLabel.text = _model.userInfoString;
        self.userTimeLabel.text = _model.timeString;
        self.userContentLabel.text = _model.bodyString;
        self.userBodyImageView.imageArray = _model.bodyImgArray;
        [self layoutIfNeeded];
    }
}
#pragma mark ======= Lazy
- (UIButton *)userHeaderButton{
    if(!_userHeaderButton){
        _userHeaderButton = ({
            UIButton * object = [[UIButton alloc]init];
            object.backgroundColor = randomColor;
            object.layer.cornerRadius = 22.5;
            object.layer.masksToBounds = YES;
            object;
       });
    }
    return _userHeaderButton;
}

- (UILabel *)userNameLabel{
    if(!_userNameLabel){
        _userNameLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.textColor = [UIColor blackColor];
            object.font = FONT(15);
            object;
       });
    }
    return _userNameLabel;
}

- (UIImageView *)userLevelIconView{
    if(!_userLevelIconView){
        _userLevelIconView = ({
            UIImageView * object = [[UIImageView alloc]init];
            object.backgroundColor = [UIColor orangeColor];
            object.layer.cornerRadius = 10;
            object.layer.masksToBounds = YES;
            object;
       });
    }
    return _userLevelIconView;
}

- (UILabel *)userLevelLabel{
    if(!_userLevelLabel){
        _userLevelLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.textColor = [UIColor orangeColor];
            object.font = FONT(13);
            object;
       });
    }
    return _userLevelLabel;
}

- (UILabel *)userTimeLabel{
    if(!_userTimeLabel){
        _userTimeLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.textColor = [UIColor wya_grayTitleColor];
            object.font = FONT(12);
            object;
       });
    }
    return _userTimeLabel;
}

- (UILabel *)userContentLabel{
    if(!_userContentLabel){
        _userContentLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.textColor = [UIColor blackColor];
            object.font = FONT(14);
            object.numberOfLines = 0;
            object;
       });
    }
    return _userContentLabel;
}

- (UIButton *)showAllBodyButton{
    if(!_showAllBodyButton){
        _showAllBodyButton = ({
            UIButton * object = [[UIButton alloc]init];
            [object setTitle:@"全文" forState:0];
            [object setTitle:@"收起" forState:UIControlStateSelected];
            [object setTitleColor:[UIColor wya_blueColor] forState:0];
            object.titleLabel.font = FONT(14);
            object;
       });
    }
    return _showAllBodyButton;
}
- (WYAImgTextBodyView *)userBodyImageView{
    if(!_userBodyImageView){
        _userBodyImageView = ({
            WYAImgTextBodyView * object = [[WYAImgTextBodyView alloc]init];
            object;
        });
    }
    return _userBodyImageView;
}


- (UIButton *)collectionButton{
    if(!_collectionButton){
        _collectionButton = ({
            UIButton * object = [[UIButton alloc]init];
            [object setTitle:@"收藏" forState:0];
            [object setTitleColor:[UIColor blackColor] forState:0];
            object.titleLabel.font = FONT(13);
            object;
       });
    }
    return _collectionButton;
}

- (UIButton *)forwardingButton{
    if(!_forwardingButton){
        _forwardingButton = ({
            UIButton * object = [[UIButton alloc]init];
            [object setTitle:@"转发" forState:0];
            [object setTitleColor:[UIColor blackColor] forState:0];
            object.titleLabel.font = FONT(13);
            object;
        });
    }
    return _forwardingButton;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = ({
            UIView * object = [[UIView alloc]init];
            object.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
            object;
        });
    }
    return _lineView;
}
#pragma mark ======= Public Method

+ (CGFloat)getCellHeightWithModel:(WYAImageTextModel *)model{
    if (model.bodyImgArray.count > 1) {
        int index ;
        if (model.bodyImgArray.count<=3) {
            index = 1;
        }else if (model.bodyImgArray.count>6){
            index = 3;
        }else{
            index = 2;
        }
        CGFloat height = index * (ITEM_MARGIN + ITEM_WH);

        return [model.bodyString wya_heightWithFontSize:14 width:ScreenWidth - 67 - 10] + 75 + height + 45;
    }
    return [model.bodyString wya_heightWithFontSize:14 width:ScreenWidth - 67 - 10] + 75 + 200 + 45;
}

@end
