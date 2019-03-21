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
/// 白色
+ (UIColor *)wya_whiteColor;
/// 蓝色
+ (UIColor *)wya_blueColor;
/// 底部tabbarNormal灰色
+ (UIColor *)wya_grayTabbarTextColor;
/// 背景色
+ (UIColor *)wya_bgColor;
/// 灰色背景
+ (UIColor *)wya_grayBGColor;
/// 灰色标题
+ (UIColor *)wya_grayTitleColor;
/// 黑色标题
+ (UIColor *)wya_blackTitleColor;
/// 黑色文字内容颜色
+ (UIColor *)wya_blackTextColor;
/// 红色
+ (UIColor *)wya_redColor;
@end

NS_ASSUME_NONNULL_END
