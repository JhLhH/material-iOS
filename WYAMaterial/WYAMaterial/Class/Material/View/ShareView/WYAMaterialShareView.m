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
@property (nonatomic, strong) UIButton * handSendCircleBtn; // 手动发圈
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
    [self layoutIfNeeded];
}
#pragma mark ======= LifeCircle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.topView addSubview:self.friendCircleBtn];
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
    if (!_isOnlyFriendCircle) {
        [self.friendCircleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.topView.mas_left).offset(72*SizeAdapter);
            make.top.equalTo(self.topView.mas_top).offset(0);
            make.bottom.equalTo(self.topView.mas_bottom).offset(0);
            make.width.mas_equalTo(116*SizeAdapter);
        }];
        [self.handSendCircleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.topView.mas_right).offset(-72*SizeAdapter);
            make.centerY.mas_equalTo(self.topView.mas_centerY);
            make.height.mas_equalTo(116*SizeAdapter);
            make.width.mas_equalTo(116*SizeAdapter);
        }];
    }else{
        [self.friendCircleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self.topView);
        }];
    }


    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(50*SizeAdapter);
    }];

    [self.friendCircleBtn wya_setButtonImageLocationTopWithSpace:9*SizeAdapter];
    [self.handSendCircleBtn wya_setButtonImageLocationTopWithSpace:9*SizeAdapter];

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
            [object setImage:[UIImage imageNamed:@"icon_pengyouquan"] forState:UIControlStateNormal];
            [object setTitle:@"朋友圈" forState:UIControlStateNormal];
            object.titleLabel.font = FONT(10);
//            object.imageView.layer.cornerRadius = 30*SizeAdapter;
//            object.imageView.layer.masksToBounds = YES;
//            object.imageView.bounds = CGRectMake(0, 0, 60*SizeAdapter, 60*SizeAdapter);
            [object setTitleColor:[UIColor wya_hex:@"#868686"] forState:UIControlStateNormal];
            object;
       });
    }
    return _friendCircleBtn;
}

- (UIButton *)handSendCircleBtn{
    if(!_handSendCircleBtn){
        _handSendCircleBtn = ({
            UIButton * object = [[UIButton alloc]init];
            [object setImage:[UIImage imageNamed:@"icon_shoudong"] forState:UIControlStateNormal];
            [object setTitle:@"手动发圈" forState:UIControlStateNormal];
            object.titleLabel.font = FONT(10);
            [object setTitleColor:[UIColor wya_hex:@"#868686"] forState:UIControlStateNormal];
            object;
       });
    }
    return _handSendCircleBtn;
}

- (UIButton *)cancleButton{
    if(!_cancleButton){
        _cancleButton = ({
            UIButton * object = [[UIButton alloc]init];
            [object setTitle:@"取消" forState:UIControlStateNormal];
            [object setTitleColor:[UIColor wya_textBlackColor] forState:UIControlStateNormal];
            object.titleLabel.font = FONT(18);
            object.backgroundColor = [UIColor wya_whiteColor];
            object;
       });
    }
    return _cancleButton;
}
@end
