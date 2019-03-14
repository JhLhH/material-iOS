//
//  UIColor+WYAColor.m
//  WYAiOSEnv
//
//  Created by 李俊恒 on 2019/1/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "UIColor+WYAColor.h"

@implementation UIColor (WYAColor)
/// 白色
+ (UIColor *)wya_whiteColor {
    return [UIColor wya_hex:@"#FFFFFF"];
}
/// 蓝色
+ (UIColor *)wya_blueColor {
    return [UIColor wya_hex:@"#108DE7"];
}
/// 底部tabbarNormal灰色
+ (UIColor *)wya_grayTabbarTextColor {
    return [UIColor wya_hex:@"#909090"];
}
/// 背景色
+ (UIColor *)wya_bgColor {
    return [UIColor wya_hex:@"#F6F6F6"];
}
/// 灰色背景
+ (UIColor *)wya_grayBGColor {
    return [UIColor wya_hex:@"#DEDEDE"];
}
/// 灰色标题
+ (UIColor *)wya_grayTitleColor {
    return [UIColor wya_hex:@"#BEBEBE"];
}
/// 黑色标题
+ (UIColor *)wya_blackTitleColor {
    return [UIColor wya_hex:@"#000000"];
}
/// 黑色文字内容颜色
+ (UIColor *)wya_blackTextColor {
    return [UIColor wya_hex:@"#333333"];
}
/// 红色
+ (UIColor *)wya_redColor {
    return [UIColor wya_hex:@"#FF352D"];
}
@end
