//
//  UIColor+WYAColor.h
//  WYAiOSEnv
//
//  Created by 李俊恒 on 2019/1/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (WYAColor)
#pragma mark ======= 基本配色
/// 白色
+ (UIColor *)wya_whiteColor;
/// 金色
+ (UIColor *)wya_goldenColor;
/// 蓝色
+ (UIColor *)wya_blueColor;
/// 黑色
+ (UIColor *)wya_blackColor;
/// 突出色偏黑
+ (UIColor *)wya_lightBlackColor;
/// 红色
+ (UIColor *)wya_redColor;
/// 绿色
+ (UIColor *)wya_greenColor;
/// 背景色
+ (UIColor *)wya_bgColor;
/// 分割线颜色
+ (UIColor *)wya_lineColor;


#pragma mark ======= 字体颜色
/// 文字突出色黑色（非标准黑色）
+ (UIColor *)wya_textLightBlackColor;
/// 文字黑色
+ (UIColor *)wya_textBlackColor;
/// 文字白色
+ (UIColor *)wya_textWhitColorl;
/// 文字深灰色
+ (UIColor *)wya_textDarkGrayColor;
/// 文字灰色
+ (UIColor *)wya_textGrayColor;
/// 文字浅灰色
+ (UIColor *)wya_textLightGrayColor;
/// 橙色文字
+ (UIColor *)wya_textOrangeColor;

@end

NS_ASSUME_NONNULL_END
