//
//  WYAMineHeaderView.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYAMineModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol WYAMineHeaderDelegate <NSObject>

@required
- (void)mineHeaderSettingButtonPressed:(UIButton *)sender;
- (void)mineHeaderEditUserIconButtonPressed:(UIButton *)sender;

@end
@interface WYAMineHeaderView : UIView
@property (nonatomic, weak) id<WYAMineHeaderDelegate> delegate;
@property (nonatomic, strong) WYAMineUserInfoModel * model;
@end

NS_ASSUME_NONNULL_END
