//
//  WYAShareView.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/25.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMaterialShareView.h"
@interface WYAMaterialShareView()
@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) UIButton *  friendCircleBtn; // 朋友圈
@property (nonatomic, strong) UIImageView * friendCircleBtnImageView;
@property (nonatomic, strong) UILabel * friendCircleBtnLabel;
@property (nonatomic, strong) UIButton * handSendCircleBtn; // 手动发圈
@property (nonatomic, strong) UIImageView * handSendCircleBtnImageView;
@property (nonatomic, strong) UILabel * handSendCircleBtnLabel;
@property (nonatomic, strong) UIButton * cancleButton;
@end

@implementation WYAMaterialShareView
#pragma mark ======= Public Method
+ (instancetype)sharedInstance{
    static WYAMaterialShareView * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WYAMaterialShareView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 175*SizeAdapter)];
    });
    return instance;
}
- (void)setIsOnlyFriendCircle:(BOOL)isOnlyFriendCircle{
    _isOnlyFriendCircle = isOnlyFriendCircle;
    if (_isOnlyFriendCircle) {
        self.handSendCircleBtnLabel.text = @"好友";
        self.handSendCircleBtnImageView.image = [UIImage imageNamed:@"icon_haoyou"];
    }
    [self layoutIfNeeded];
}
#pragma mark ======= LifeCircle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.friendCircleBtn addSubview:self.friendCircleBtnImageView];
        [self.friendCircleBtn addSubview:self.friendCircleBtnLabel];
        [self.topView addSubview:self.friendCircleBtn];
        [self.handSendCircleBtn addSubview:self.handSendCircleBtnImageView];
        [self.handSendCircleBtn addSubview:self.handSendCircleBtnLabel];
        [self.topView addSubview:self.handSendCircleBtn];
        [self addSubview:self.topView];
        [self addSubview:self.cancleButton];
        self.backgroundColor = [UIColor wya_hex:@"#E8E6F1"];
        UIRectCorner rectCorner = UIRectCornerTopRight | UIRectCornerTopLeft;
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(8*SizeAdapter, 8*SizeAdapter)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = bezierPath.CGPath;
        self.layer.mask = maskLayer;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(120*SizeAdapter);
    }];

    [self.friendCircleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(70*SizeAdapter);
        make.centerY.mas_equalTo(self.topView.mas_centerY);
        make.height.mas_equalTo(120*SizeAdapter);
        make.width.mas_equalTo(120*SizeAdapter);
    }];

    [self.friendCircleBtnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.friendCircleBtn.mas_left).offset(30*SizeAdapter);
        make.top.equalTo(self.friendCircleBtn.mas_top).offset(21*SizeAdapter);
        make.height.mas_equalTo(60*SizeAdapter);
        make.width.mas_equalTo(60*SizeAdapter);
    }];
    [self.friendCircleBtnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.friendCircleBtn.mas_left).offset(30*SizeAdapter);
        make.top.equalTo(self.friendCircleBtnImageView.mas_bottom).offset(9*SizeAdapter);
        make.height.mas_equalTo(10*SizeAdapter);
        make.width.mas_equalTo(60*SizeAdapter);
    }];


    [self.handSendCircleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView.mas_right).offset(-70*SizeAdapter);
        make.centerY.mas_equalTo(self.topView.mas_centerY);
        make.height.mas_equalTo(120*SizeAdapter);
        make.width.mas_equalTo(120*SizeAdapter);
    }];

    [self.handSendCircleBtnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.handSendCircleBtn.mas_right).offset(-30*SizeAdapter);
        make.top.equalTo(self.handSendCircleBtn.mas_top).offset(21*SizeAdapter);
        make.height.mas_equalTo(60*SizeAdapter);
        make.width.mas_equalTo(60*SizeAdapter);
    }];
    [self.handSendCircleBtnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.handSendCircleBtn.mas_right).offset(-30*SizeAdapter);
        make.top.equalTo(self.handSendCircleBtnImageView.mas_bottom).offset(9*SizeAdapter);
        make.height.mas_equalTo(10*SizeAdapter);
        make.width.mas_equalTo(60*SizeAdapter);
    }];


    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(50*SizeAdapter);
    }];

    [self.friendCircleBtn wya_setButtonImageLocationTopWithSpace:9*SizeAdapter];
    [self.handSendCircleBtn wya_setButtonImageLocationTopWithSpace:9*SizeAdapter];

}

#pragma mark ======= Event

- (void)friendCircleBtnClicked:(UIButton *)sender{
    if (self.shareWeChateActionBlock) {
        self.shareWeChateActionBlock();
    }
}
- (void)handSendCircleBtn:(UIButton *)sender{
    if([self.handSendCircleBtnLabel.text isEqualToString:@"手动发圈"]){
    if (self.openWeChateActionBlock) {
        self.openWeChateActionBlock();
    }}else if([self.handSendCircleBtnLabel.text isEqualToString:@"好友"]){
        if (self.sendWeChateFriendActionBlock) {
            self.sendWeChateFriendActionBlock();
        }
    }
}
- (void)cancleButton:(UIButton *)sender{
    if (self.cancleActionBlock) {
        self.cancleActionBlock();
    }
}
#pragma mark ======= Lazy

- (UIView *)topView{
    if(!_topView){
        _topView = ({
            UIView * object = [[UIView alloc]init];
            object.backgroundColor = [UIColor wya_hex:@"#F6F5FA"];
            object;
       });
    }
    return _topView;
}

- (UIButton *)friendCircleBtn{
    if(!_friendCircleBtn){
        _friendCircleBtn = ({
            UIButton * object = [[UIButton alloc]init];
            [object addTarget:self action:@selector(friendCircleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            object;
       });
    }
    return _friendCircleBtn;
}

- (UIImageView *)friendCircleBtnImageView{
    if(!_friendCircleBtnImageView){
        _friendCircleBtnImageView = ({
            UIImageView * object = [[UIImageView alloc]init];
            object.image  = [UIImage imageNamed:@"icon_pengyouquan"];
            object.layer.cornerRadius = 30*SizeAdapter;
            object.layer.masksToBounds = YES;
            object;
       });
    }
    return _friendCircleBtnImageView;
}

- (UILabel *)friendCircleBtnLabel{
    if(!_friendCircleBtnLabel){
        _friendCircleBtnLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.text = @"朋友圈";
            object.font = FONT(10);
            object.textAlignment = NSTextAlignmentCenter;
            object.textColor = [UIColor wya_hex:@"#868686"];
            object;
       });
    }
    return _friendCircleBtnLabel;
}


- (UIButton *)handSendCircleBtn{
    if(!_handSendCircleBtn){
        _handSendCircleBtn = ({
            UIButton * object = [[UIButton alloc]init];
            [object addTarget:self action:@selector(handSendCircleBtn:) forControlEvents:UIControlEventTouchUpInside];
            object;
        });
    }
    return _handSendCircleBtn;
}

- (UIImageView *)handSendCircleBtnImageView{
    if(!_handSendCircleBtnImageView){
        _handSendCircleBtnImageView = ({
            UIImageView * object = [[UIImageView alloc]init];
            object.image  = [UIImage imageNamed:@"icon_shoudong"];
            object.layer.cornerRadius = 30*SizeAdapter;
            object.layer.masksToBounds = YES;
            object;
       });
    }
    return _handSendCircleBtnImageView;
}

- (UILabel *)handSendCircleBtnLabel{
    if(!_handSendCircleBtnLabel){
        _handSendCircleBtnLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.text = @"手动发圈";
            object.font = FONT(10);
            object.textAlignment = NSTextAlignmentCenter;
            object.textColor = [UIColor wya_hex:@"#868686"];
            object;
       });
    }
    return _handSendCircleBtnLabel;
}

- (UIButton *)cancleButton{
    if(!_cancleButton){
        _cancleButton = ({
            UIButton * object = [[UIButton alloc]init];
            [object setTitle:@"取消" forState:UIControlStateNormal];
            [object setTitleColor:[UIColor wya_textBlackColor] forState:UIControlStateNormal];
            object.titleLabel.font = FONT(18);
            object.backgroundColor = [UIColor wya_whiteColor];
            [object addTarget:self action:@selector(cancleButton:) forControlEvents:UIControlEventTouchUpInside];
            object;
        });
    }
    return _cancleButton;
}
@end
