//
//  WYAMineBodyView.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/16.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineBodyView.h"

#define BTNWIDTH self.frame.size.width/3
#define BTNHEIGHT self.frame.size.height
@interface WYAMineBodyView()
@property (nonatomic, strong) UIButton * leftButton;
@property (nonatomic, strong) UIButton * centerButton;
@property (nonatomic, strong) UIButton * rightButton;
@end
@implementation WYAMineBodyView
#pragma mark ======= LifeCircle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
        [self addSubview:self.leftButton];
        [self addSubview:self.centerButton];
        [self addSubview:self.rightButton];
    }
    return self;
}
#pragma mark ======= Private Method
- (void)setUI{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowColor = [UIColor wya_grayBGColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 2;
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = NO;
}
#pragma mark ======= Lazy
- (UIButton *)leftButton{
    if(!_leftButton){
        _leftButton = ({
            UIButton * object = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, BTNWIDTH, BTNHEIGHT)];
            UIImage * image = [UIImage wya_imageWithColor:randomColor size:CGSizeMake(60, 60) rate:1];
            [object setTitle:@"我的收藏" forState:0];
            object.titleLabel.font = FONT(14);
            [object setTitleColor:[UIColor blackColor] forState:0];
            [object setImage:image forState:0];
            [object wya_setButtonImageLocationTopWithSpace:20];
            [object addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            object;
       });
    }
    return _leftButton;
}

- (UIButton *)centerButton{
    if(!_centerButton){
        _centerButton = ({
            UIButton * object = [[UIButton alloc]initWithFrame:CGRectMake(BTNWIDTH, 0, BTNWIDTH, BTNHEIGHT)];
            UIImage * image = [UIImage wya_imageWithColor:randomColor size:CGSizeMake(60, 60) rate:1];
            [object setTitle:@"我的创建" forState:0];
            object.titleLabel.font = FONT(14);
            [object setTitleColor:[UIColor blackColor] forState:0];
            [object setImage:image forState:0];
            [object wya_setButtonImageLocationTopWithSpace:20];
            [object addTarget:self action:@selector(centerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

            object;
       });
    }
    return _centerButton;
}

- (UIButton *)rightButton{
    if(!_rightButton){
        _rightButton = ({
            UIButton * object = [[UIButton alloc]initWithFrame:CGRectMake(2*BTNWIDTH, 0, BTNWIDTH, BTNHEIGHT)];
            UIImage * image = [UIImage wya_imageWithColor:randomColor size:CGSizeMake(60, 60) rate:1];
            [object setTitle:@"历史通知" forState:0];
            object.titleLabel.font = FONT(14);
            [object setTitleColor:[UIColor blackColor] forState:0];
            [object setImage:image forState:0];
            [object wya_setButtonImageLocationTopWithSpace:20];
            [object addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

            object;
       });
    }
    return _rightButton;
}
#pragma mark ======= Event
- (void)leftBtnClicked:(UIButton *)sender{
    if (self.collectionActionBlock) {
        self.collectionActionBlock();
    }
}
- (void)centerButtonClicked:(UIButton *)sender{
    if (self.createBlock) {
        self.createBlock();
    }
}
- (void)rightButtonClicked:(UIButton *)sender{
    if (self.noticeBlock) {
        self.noticeBlock();
    }
}
@end
