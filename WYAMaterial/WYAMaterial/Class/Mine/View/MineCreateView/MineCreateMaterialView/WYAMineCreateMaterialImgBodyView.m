//
//  WYAMineCreateMaterialImgBodyView.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineCreateMaterialImgBodyView.h"

#define MARGIN 10 * SizeAdapter
#define IMGWIDTH (ScreenWidth - 88 * SizeAdapter - 3 * MARGIN) / 3
#define IMGHEIGHT (ScreenWidth - 88 * SizeAdapter - 3 * MARGIN) / 3
#define COL_COUNT 3
#define BASETAG 100

@interface WYAMineCreateMaterialImgBodyView ()

@end

@implementation WYAMineCreateMaterialImgBodyView
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
    if (imageArray) {
        _imageArray = imageArray;
        for (UIView * view in self.subviews) {
            [view removeFromSuperview];
        }
        if (_imageArray.count > 1) {
            // 循环创建按钮图片
            for (int i = 0; i < imageArray.count; i++) {
                NSInteger row     = i / COL_COUNT; // 行
                NSInteger col     = i % COL_COUNT;
                CGFloat btnX      = (IMGWIDTH + MARGIN) * col;
                CGFloat btnY      = (IMGHEIGHT + MARGIN) * row;
                UIImage * image   = [UIImage imageNamed:[imageArray wya_safeObjectAtIndex:0]];
                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setImage:image forState:0];
                button.tag                 = BASETAG + i;
                button.frame               = CGRectMake(btnX, btnY, IMGWIDTH, IMGHEIGHT);
                button.layer.cornerRadius  = 2 * SizeAdapter;
                button.layer.masksToBounds = YES;
                [self addSubview:button];
            }
        } else {
            UIImageView * bodyImageView       = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200 * SizeAdapter, 200 * SizeAdapter)];
            bodyImageView.image               = [UIImage imageNamed:imageArray[0]];
            bodyImageView.layer.cornerRadius  = 2 * SizeAdapter;
            bodyImageView.layer.masksToBounds = YES;
            [self addSubview:bodyImageView];
        }
    }
}

@end
