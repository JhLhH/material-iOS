//
//  WYARefreshView.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/21.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYARefreshView.h"

@interface WYARefreshView ()
@property (nonatomic, strong) UIImageView * animationImageView;
@property (nonatomic, strong) UIImageView * textImageView;
@end

@implementation WYARefreshView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.animationImageView];
        [self.animationImageView wya_setRotationAnimation:360 time:1 repeatCount:0];
        [self addSubview:self.textImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat animationImageView_x = (self.cmam_width - 28 * SizeAdapter) / 2;
    CGFloat animationImageView_y = (self.cmam_height - 28 * SizeAdapter) / 2;
    CGFloat animationImageView_width = 28 * SizeAdapter;
    CGFloat animationImageView_height = 28 * SizeAdapter;
    CGRect animationImageView_rect = CGRectMake(animationImageView_x, animationImageView_y,  animationImageView_width, animationImageView_height);
    self.animationImageView.frame = animationImageView_rect;

    CGFloat textImageView_x = (self.cmam_width - 30 * SizeAdapter) / 2;
    CGFloat textImageView_y = (self.cmam_height - 30 * SizeAdapter) / 2;
    CGFloat textImageView_width = 30 * SizeAdapter;
    CGFloat textImageView_height = 30 * SizeAdapter;
    CGRect textImageView_rect = CGRectMake(textImageView_x, textImageView_y,  textImageView_width, textImageView_height);
    self.textImageView.frame = textImageView_rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (UIImageView *)animationImageView{
    if(!_animationImageView){
        _animationImageView = ({
            UIImageView * object = [[UIImageView alloc]init];
            object.image = [UIImage imageNamed:@"wya-applogo"];
            object;
       });
    }
    return _animationImageView;
}

- (UIImageView *)textImageView{
    if(!_textImageView){
        _textImageView = ({
            UIImageView * object = [[UIImageView alloc]init];
            object.image = [UIImage imageNamed:@"wya-applogo--w"];
            object;
       });
    }
    return _textImageView;
}
@end
