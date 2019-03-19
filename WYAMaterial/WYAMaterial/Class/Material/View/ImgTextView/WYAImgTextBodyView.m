//
//  WYAImgTextBodyView.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/16.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAImgTextBodyView.h"

#define IMGWIDTH 100
#define IMGHEIGHT 100
#define COL_COUNT 3
#define BASETAG 100

@interface WYAImgTextBodyView ()

@end

@implementation WYAImgTextBodyView
#pragma mark ======= LifeCircle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark ======= Setter
- (void)setImageArray:(NSArray *)imageArray{
    if (imageArray) {
        _imageArray = imageArray;
        for (UIView * view in self.subviews) {
            [view removeFromSuperview];
        }
        if (_imageArray.count > 1) {
            // 循环创建按钮图片
//            CGFloat width = (self.cmam_width - 2*10)/3
            for (int i = 0; i < imageArray.count; i++) {
                NSInteger row = i / COL_COUNT;// 行
                NSInteger col = i % COL_COUNT;
                NSInteger margin = 10;
                CGFloat btnX = margin + (IMGWIDTH + margin) * col;
                CGFloat btnY = margin + (IMGHEIGHT + margin) * row;
                UIImage * image = [UIImage imageNamed:[imageArray wya_safeObjectAtIndex:0]];
                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setImage:image forState:0];
                button.tag = BASETAG + i;
                button.frame = CGRectMake(btnX, btnY, IMGWIDTH, IMGHEIGHT);
                button.layer.cornerRadius = 8;
                button.layer.masksToBounds = YES;
                [self addSubview:button];
            }
        }else{
            UIImageView * bodyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
            bodyImageView.image = [UIImage imageNamed:imageArray[0]];
            [self addSubview:bodyImageView];
        }

    }
}
#pragma mark ======= Lazy
//- (UIImageView *)bodyImageView{
//    if(!_bodyImageView){
//        _bodyImageView = ({
//            UIImageView * object = [[UIImageView alloc]init];
//            object.layer.cornerRadius = 8;
//            object.layer.masksToBounds = YES;
//            object;
//       });
//    }
//    return _bodyImageView;
//}
@end
