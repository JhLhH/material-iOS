//
//  WYAShareView.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/25.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ShareWeChateBlock)(void);
typedef void (^OpenWeChateBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface WYAMaterialShareView : UIView
/// 是否仅显示朋友圈，默认为NO
@property (nonatomic, assign) BOOL isOnlyFriendCircle;
/// 朋友圈点击
@property (nonatomic, copy) ShareWeChateBlock  shareWeChateBlock;
/// 手动发圈
@property (nonatomic, copy) OpenWeChateBlock  openWeChateBlock;
+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
