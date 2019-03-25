//
//  WYAAgentRingCoverView.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAAgentRingCoverView.h"

@interface WYAAgentRingCoverView ()
@property (nonatomic, strong) UIImageView * agentRingCoverImageView;
@property (nonatomic, strong) UIImageView * userHeaderImageView;

@end

@implementation WYAAgentRingCoverView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.agentRingCoverImageView];
        [self addSubview:self.userHeaderImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat agentRingCoverImageView_x      = self.cmam_left;
    CGFloat agentRingCoverImageView_y      = self.cmam_top;
    CGFloat agentRingCoverImageView_width  = self.cmam_width;
    CGFloat agentRingCoverImageView_height = self.cmam_height - 30 * SizeAdapter;
    CGRect agentRingCoverImageView_rect    = CGRectMake(agentRingCoverImageView_x, agentRingCoverImageView_y, agentRingCoverImageView_width, agentRingCoverImageView_height);
    self.agentRingCoverImageView.frame     = agentRingCoverImageView_rect;

    CGFloat userHeaderImageView_width  = 68 * SizeAdapter;
    CGFloat userHeaderImageView_height = userHeaderImageView_width;
    CGFloat userHeaderImageView_x      = self.cmam_right - userHeaderImageView_width - 15 * SizeAdapter;
    CGFloat userHeaderImageView_y      = self.cmam_height - userHeaderImageView_height - 7 * SizeAdapter;

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
            object.layer.cornerRadius  = 8 * SizeAdapter;
            object.layer.masksToBounds = YES;
            object;
        });
    }
    return _userHeaderImageView;
}
@end
