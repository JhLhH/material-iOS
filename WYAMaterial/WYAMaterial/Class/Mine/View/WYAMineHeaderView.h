//
//  WYAMineHeaderView.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineModel.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void (^SettingActionBlock)(void);
typedef void (^EditUserIconActionBlock)(void);

@interface WYAMineHeaderView : UIView

@property (nonatomic, copy) SettingActionBlock settingActionBlock;
@property (nonatomic, copy) EditUserIconActionBlock editUserIconActionBlock;

@property (nonatomic, strong) WYAMineUserInfoModel * model;
@end

NS_ASSUME_NONNULL_END
