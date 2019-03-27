//
//  WYAImgTextBodyView.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/16.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAImgTextBodyView.h"

#define MARGIN 5 * SizeAdapter
#define IMGWIDTH (ScreenWidth - 120 * SizeAdapter - 2 * MARGIN) / 3
#define IMGHEIGHT (ScreenWidth - 120 * SizeAdapter - 2 * MARGIN) / 3
#define COL_COUNT 3
#define BASETAG 100

@interface WYAImgTextBodyView ()

@end

@implementation WYAImgTextBodyView
#pragma mark ======= LifeCircle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
#pragma mark ======= Setter
- (void)setImageArray:(NSArray *)imageArray {
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    if (imageArray) {
        _imageArray = imageArray;
        if (_imageArray.count > 1) {
            // 循环创建按钮图片
            for (int i = 0; i < imageArray.count; i++) {
                NSInteger row     = i / COL_COUNT; // 行
                NSInteger col     = i % COL_COUNT;
                CGFloat btnX      = (IMGWIDTH + MARGIN) * col;
                CGFloat btnY      = (IMGHEIGHT + MARGIN) * row;
                UIImage * image   = [UIImage imageNamed:[imageArray wya_safeObjectAtIndex:0]];
                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setBackgroundImage:image forState:0];
                button.tag                 = BASETAG + i;
                button.frame               = CGRectMake(btnX, btnY, IMGWIDTH, IMGHEIGHT);
                button.layer.cornerRadius  = 5 * SizeAdapter;
                button.layer.masksToBounds = YES;
                [button addTarget:self action:@selector(listButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
            }
        } else {
            UIButton * bodyImageView       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (ScreenWidth - 190.5 * SizeAdapter), (ScreenWidth - 190.5 * SizeAdapter))];
            [bodyImageView setBackgroundImage:[UIImage imageNamed:imageArray[0]] forState:UIControlStateNormal];
            bodyImageView.layer.cornerRadius  = 5 * SizeAdapter;
            bodyImageView.layer.masksToBounds = YES;
            bodyImageView.tag = BASETAG + 0;
            [bodyImageView addTarget:self action:@selector(oneImgButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:bodyImageView];
        }
    }
}

#pragma mark ======= Event
- (void)listButtonClicked:(UIButton *)sender{
    if (self.ImageButtonAction) {
        self.ImageButtonAction(self.subviews, sender.tag - BASETAG);
    }
}
- (void)oneImgButtonClicked:(UIButton *)sender{
    if (self.ImageButtonAction) {
        self.ImageButtonAction(self.subviews, sender.tag - BASETAG);
    }
}
@end
