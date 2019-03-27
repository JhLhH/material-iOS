//
//  WYAAgentRingCoverView.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAAgentRingCoverView.h"

const CGFloat agentRingCoverImageViewBottom = 30;

const CGFloat userHeaderImageViewWidth = 68;
const CGFloat userHeaderImageViewRight = 15;
const CGFloat userHeaderImageViewBottom = 7;
const CGFloat userHeaderImageViewCornerRadius = 8;
const CGFloat userHeaderImageViewBorderWidth = 0.5;
@interface WYAAgentRingCoverView ()
@property (nonatomic, strong) UIImageView * agentRingCoverImageView;
@property (nonatomic, strong) UIImageView * userHeaderImageView;

@end

@implementation WYAAgentRingCoverView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor wya_whiteColor];
        [self addSubview:self.agentRingCoverImageView];
        [self addSubview:self.userHeaderImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat agentRingCoverImageView_x      = 0;
    CGFloat agentRingCoverImageView_y      = 0;
    CGFloat agentRingCoverImageView_width  = self.cmam_width;
    CGFloat agentRingCoverImageView_height = self.cmam_height - agentRingCoverImageViewBottom * SizeAdapter;
    CGRect agentRingCoverImageView_rect    = CGRectMake(agentRingCoverImageView_x, agentRingCoverImageView_y, agentRingCoverImageView_width, agentRingCoverImageView_height);
    self.agentRingCoverImageView.frame     = agentRingCoverImageView_rect;

    CGFloat userHeaderImageView_width  = userHeaderImageViewWidth * SizeAdapter;
    CGFloat userHeaderImageView_height = userHeaderImageView_width;
    CGFloat userHeaderImageView_x      = self.cmam_right - userHeaderImageView_width - userHeaderImageViewRight * SizeAdapter;
    CGFloat userHeaderImageView_y      = self.cmam_height - userHeaderImageView_height - userHeaderImageViewBottom * SizeAdapter;

    CGRect userHeaderImageView_rect = CGRectMake(userHeaderImageView_x, userHeaderImageView_y, userHeaderImageView_width, userHeaderImageView_height);
    self.userHeaderImageView.frame  = userHeaderImageView_rect;
}

#pragma mark ======= Getter
- (UIImageView *)agentRingCoverImageView {
    if (!_agentRingCoverImageView) {
        _agentRingCoverImageView = ({
            UIImageView * object = [[UIImageView alloc] init];
            object.image         = [UIImage imageNamed:@"pic_shouyebackground"];
            object;

        });
    }
    return _agentRingCoverImageView;
}

- (UIImageView *)userHeaderImageView {
    if (!_userHeaderImageView) {
        _userHeaderImageView = ({
            UIImageView * object       = [[UIImageView alloc] init];
            object.image = [UIImage imageNamed:@"pic_shouyeportrait"];
            object.layer.cornerRadius  = userHeaderImageViewCornerRadius * SizeAdapter;
            object.layer.masksToBounds = YES;
            object.layer.borderColor = [UIColor wya_goldenColor].CGColor;
            object.layer.borderWidth = userHeaderImageViewBorderWidth * SizeAdapter;
            object;
        });
    }
    return _userHeaderImageView;
}
@end
