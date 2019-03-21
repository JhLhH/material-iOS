//
//  UIColor+WYAColor.m
//  WYAiOSEnv
//
//  Created by 李俊恒 on 2019/1/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "UIColor+WYAColor.h"

@implementation UIColor (WYAColor)
#pragma mark ======= 基本配色
+ (UIColor *)wya_whiteColor {
    return [UIColor wya_hex:@"#FFFFFF"];
}

+ (UIColor *)wya_goldenColor{
    return [UIColor wya_hex:@"#e7c083"];
}

+ (UIColor *)wya_blueColor {
    return [UIColor wya_hex:@"#4787f2"];
}

+ (UIColor *)wya_blackColor{
    return [UIColor wya_hex:@"333333"];
}

+ (UIColor *)wya_lightBlackColor{
    return [UIColor wya_hex:@"#584f60"];
}

+ (UIColor *)wya_redColor {
    return [UIColor wya_hex:@"#ff3c4a"];
}

+ (UIColor *)wya_greenColor{
    return [UIColor wya_hex:@"#26be76"];
}


+ (UIColor *)wya_bgColor {
    return [UIColor wya_hex:@"#f5f5f7"];
}

+ (UIColor *)wya_lineColor{
    return [UIColor wya_hex:@"#e8e8e8"];
}


#pragma mark ======= 字体颜色
+ (UIColor *)wya_textLightBlackColor{
    return [UIColor wya_hex:@"#584f60"];
}

+ (UIColor *)wya_textBlackColor{
    return [UIColor wya_hex:@"#333333"];
}

+ (UIColor *)wya_textWhitColorl{
    return [UIColor wya_hex:@"#ffffff"];
}

+ (UIColor *)wya_textDarkGrayColor{
    return [UIColor wya_hex:@"#777777"];
}

+ (UIColor *)wya_textGrayColor{
    return [UIColor wya_hex:@"#999999"];
}

+ (UIColor *)wya_textLightGrayColor{
    return [UIColor wya_hex:@"#bbbbbb"];
}

+ (UIColor *)wya_textOrangeColor{
    return [UIColor wya_hex:@"#ff9100"];
}

+ (UIColor *)wya_goldenLevelTextColor{
    return [UIColor wya_hex:@"#C4903F"];
}
@end
