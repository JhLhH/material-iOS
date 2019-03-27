//
//  WYAMaterialLabelView.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/22.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMaterialLabelView.h"
@interface WYAMaterialLabelView()
@property (nonatomic, strong) UILabel * leftLabel;
@property (nonatomic, strong) UILabel * rightInfoLabel;
@property (nonatomic, strong) UIImageView * arrowimgView;
@end
@implementation WYAMaterialLabelView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.rightInfoString = @"去关联";
        [self wya_setBackgroundColor:[UIColor wya_whiteColor] forState:UIControlStateNormal];
        [self wya_setBackgroundColor:[UIColor wya_lineColor] forState:UIControlStateHighlighted];
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightInfoLabel];
        [self addSubview:self.arrowimgView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15*SizeAdapter);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(70*SizeAdapter, 16*SizeAdapter));
    }];

    [self.rightInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowimgView.mas_left).offset(-7*SizeAdapter);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 124*SizeAdapter, 12*SizeAdapter));
    }];
    [self.arrowimgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-19*SizeAdapter);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(13*SizeAdapter, 13*SizeAdapter));
    }];
}

#pragma mark ======= Setter
- (void)setRightInfoString:(NSString *)rightInfoString{
    if (rightInfoString) {
        _rightInfoString = rightInfoString;
        self.rightInfoLabel.text = _rightInfoString;
        [self layoutIfNeeded];
    }
}
#pragma mark ======= Lazy
- (UILabel *)rightInfoLabel{
    if(!_rightInfoLabel){
        _rightInfoLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.text = @"去关联";
            object.textColor = [UIColor wya_textBlackColor];
            object.font = FONT(16);
            object.textAlignment = NSTextAlignmentRight;
            object;
       });
    }
    return _rightInfoLabel;
}

- (UIImageView *)arrowimgView{
    if(!_arrowimgView){
        _arrowimgView = ({
            UIImageView * object = [[UIImageView alloc]init];
            object.image = [UIImage imageNamed:@"icon_right"];
            object;
       });
    }
    return _arrowimgView;
}

- (UILabel *)leftLabel{
    if(!_leftLabel){
        _leftLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.text = @"关联标签";
            object.textColor = [UIColor wya_textBlackColor];
            object.font = FONT(16);
            object;
       });
    }
    return _leftLabel;
}
@end
