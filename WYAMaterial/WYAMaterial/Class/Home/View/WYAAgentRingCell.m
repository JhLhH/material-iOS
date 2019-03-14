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
@property (nonatomic, strong) UIButton * userHeaderButton; // 用户头像按钮
@property (nonatomic, strong) UILabel * userNameLabel; // 用户昵称
@property (nonatomic, strong) UILabel * userLevelLabel; // 用户层级
@property (nonatomic, strong) UILabel * userReleaseTimeLabel; // 用户发布时间
@property (nonatomic, strong) UILabel * userReleaseContentLabel; // 用户发布内容
@property (nonatomic, strong) UIView * userReleaseImagesView; // 用户发布图片父视图
@property (nonatomic, strong) UIButton * forwardingButton; // 转发
@property (nonatomic, strong) UIButton * collectionButton; // 收藏
@property (nonatomic, strong) UIButton * commentsButton; // 评论
@property (nonatomic, strong) UIButton * praiseButton; // 点赞

@end

@implementation WYAAgentRingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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

    [self.userHeaderButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(16 * SizeAdapter);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(16 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(32 * SizeAdapter, 32 * SizeAdapter));
    }];

    [self.userNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userHeaderButton.mas_top);
        make.left.mas_equalTo(self.userHeaderButton.mas_right).with.offset(5 * SizeAdapter);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(15 * SizeAdapter);
    }];

    [self.userLevelLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameLabel.mas_left);
        make.top.mas_equalTo(self.userNameLabel.mas_bottom).with.offset(5 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(60 *SizeAdapter, 15 * SizeAdapter));
    }];

    [self.userReleaseTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userLevelLabel.mas_right);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-16 * SizeAdapter);
        make.centerY.mas_equalTo(self.userLevelLabel.mas_centerY);
        make.height.mas_equalTo(15 * SizeAdapter);
    }];

    [self.userReleaseContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameLabel.mas_left);
        make.right.mas_equalTo(self.userReleaseTimeLabel.mas_right);
        make.top.mas_equalTo(self.userReleaseTimeLabel.mas_bottom).with.offset(5 * SizeAdapter);
        make.height.mas_equalTo(50 * SizeAdapter);
    }];

    [self.userReleaseImagesView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.userReleaseContentLabel);
        make.top.mas_equalTo(self.userReleaseContentLabel.mas_bottom).with.offset(10 * SizeAdapter);
        if (self.model.urls.count > 0) {
            NSInteger remaining = self.model.urls.count % 3;
            if (remaining == 0) {
                make.height.mas_equalTo(80 * SizeAdapter * (self.model.urls.count / 3));
            }else {
                make.height.mas_equalTo(80 * SizeAdapter * (self.model.urls.count / 3 + 1));
            }

        }

    }];

    [self.userReleaseImagesView.subviews wya_mas_distributeSudokuViewsWithFixedLineSpacing:5 * SizeAdapter
                                                                     fixedInteritemSpacing:5 * SizeAdapter
                                                                                 warpCount:3
                                                                                topSpacing:0
                                                                             bottomSpacing:0
                                                                               leadSpacing:0
                                                                               tailSpacing:0];

    [self.forwardingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userReleaseImagesView.mas_left);
        make.top.mas_equalTo(self.userReleaseImagesView.mas_bottom).with.offset(10 * SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(60 * SizeAdapter, 20 * SizeAdapter));
    }];

    [self.collectionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.forwardingButton.mas_right).with.offset(10 * SizeAdapter);
        make.centerY.mas_equalTo(self.forwardingButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60 * SizeAdapter, 20 * SizeAdapter));
    }];

    [self.commentsButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.collectionButton.mas_right).with.offset(20 * SizeAdapter);
        make.centerY.mas_equalTo(self.forwardingButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60 * SizeAdapter, 20 * SizeAdapter));
    }];

    [self.praiseButton mas_remakeConstraints:^(MASConstraintMaker *make) {
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

#pragma mark ======= Public Method
+ (CGFloat)getCellHeightWithModel:(WYAAgentRingModel *)model{
    WYAAgentRingCell * cell = [[WYAAgentRingCell alloc]initWithStyle:0 reuseIdentifier:@"xxx"];
    cell.model = model;
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    NSLog(@"height==%f",cell.forwardingButton.cmam_bottom);
    return cell.forwardingButton.cmam_bottom + 10 * SizeAdapter;
}

#pragma mark ======= Setter
- (void)setModel:(WYAAgentRingModel *)model{
    _model = model;
    if (model) {
//        self.userHeaderButton
        self.userNameLabel.text = model.userName;
        self.userLevelLabel.text = model.userLevel;
        self.userReleaseTimeLabel.text = model.time;
        self.userReleaseContentLabel.text = model.content;
        self.forwardingButton.selected = model.forwarding;
        self.collectionButton.selected = model.collection;
        [self.praiseButton setTitle:[NSString stringWithFormat:@"%d点赞",model.person] forState:UIControlStateNormal];

        if (self.model.urls.count > 0) {
            for (UIView * view in self.userReleaseImagesView.subviews) {
                [view removeFromSuperview];
            }

            for (WYAAgentRingImageModel * imageModel in model.urls) {
                UIButton *  object = [[UIButton alloc]init];
                [object setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
                [object addCallBackAction:^(UIButton *button) {

                }];
                [self.userReleaseImagesView addSubview:object];
            }
        }

        
        [self layoutIfNeeded];
    }
}

#pragma mark ======= Getter
- (UIButton *)userHeaderButton{
    if(!_userHeaderButton){
        _userHeaderButton = ({
            UIButton *  object = [[UIButton alloc]init];
            [object setBackgroundImage:[UIImage wya_createImageWithColor:randomColor] forState:UIControlStateNormal];
            object;
       });
    }
    return _userHeaderButton;
}

- (UILabel *)userNameLabel{
    if(!_userNameLabel){
        _userNameLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.font = FONT(15);
            object.text = @"李世航";
            object.textColor = [UIColor grayColor];
            object;
       });
    }
    return _userNameLabel;
}

- (UILabel *)userLevelLabel{
    if(!_userLevelLabel){
        _userLevelLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.font = FONT(13);
            object.text = @"总部";
            object.textColor = [UIColor grayColor];
            object;
       });
    }
    return _userLevelLabel;
}

- (UILabel *)userReleaseTimeLabel{
    if(!_userReleaseTimeLabel){
        _userReleaseTimeLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.font = FONT(13);
            object.text = @"2019-3-14 14:05";
            object.textAlignment = NSTextAlignmentRight;
            object.textColor = [UIColor grayColor];
            object;
       });
    }
    return _userReleaseTimeLabel;
}

- (UILabel *)userReleaseContentLabel{
    if(!_userReleaseContentLabel){
        _userReleaseContentLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.font = FONT(13);
            object.text = @"测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式测试样式";
            object.textColor = [UIColor redColor];
            object.numberOfLines = 0;
            object;
       });
    }
    return _userReleaseContentLabel;
}

- (UIView *)userReleaseImagesView{
    if(!_userReleaseImagesView){
        _userReleaseImagesView = ({
            UIView * object = [[UIView alloc]init];
            object;
        });
    }
    return _userReleaseImagesView;
}

- (UIButton *)forwardingButton{
    if(!_forwardingButton){
        _forwardingButton = ({
            UIButton *  object = [[UIButton alloc]init];
            [object setTitle:@"转发" forState:UIControlStateNormal];
            [object setTitle:@"已转" forState:UIControlStateSelected];
            [object setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [object setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            object.titleLabel.font = FONT(13);
            object.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [object addCallBackAction:^(UIButton *button) {
                if (self.forwardingBlock) {
                    self.forwardingBlock(self.model);
                }
            }];
            object;
       });
    }
    return _forwardingButton;
}

- (UIButton *)collectionButton{
    if(!_collectionButton){
        _collectionButton = ({
            UIButton *  object = [[UIButton alloc]init];
            [object setTitle:@"收藏" forState:UIControlStateNormal];
            [object setTitle:@"已藏" forState:UIControlStateSelected];
            [object setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [object setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            object.titleLabel.font = FONT(13);
            [object addCallBackAction:^(UIButton *button) {
                if (self.collectionBlock) {
                    self.collectionBlock(self.model);
                }
            }];
            object;
       });
    }
    return _collectionButton;
}

- (UIButton *)commentsButton{
    if(!_commentsButton){
        _commentsButton = ({
            UIButton *  object = [[UIButton alloc]init];
            [object setTitle:@"评论" forState:UIControlStateNormal];
            [object setTitle:@"已评" forState:UIControlStateSelected];
            [object setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [object setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            object.titleLabel.font = FONT(13);
            [object addCallBackAction:^(UIButton *button) {
                if (self.commentsBlock) {
                    self.commentsBlock(self.model);
                }
            }];
            object;
       });
    }
    return _commentsButton;
}

- (UIButton *)praiseButton{
    if(!_praiseButton){
        _praiseButton = ({
            UIButton *  object = [[UIButton alloc]init];
            [object setTitle:@"66人点赞" forState:UIControlStateNormal];
            [object setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [object setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            object.titleLabel.font = FONT(13);
            [object addCallBackAction:^(UIButton *button) {
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
