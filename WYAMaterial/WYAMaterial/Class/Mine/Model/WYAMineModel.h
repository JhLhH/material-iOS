//
//  WYAMineModel.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WYAMineUserInfoModel;
NS_ASSUME_NONNULL_BEGIN

@interface WYAMineModel : NSObject
@property (nonatomic, strong) WYAMineUserInfoModel * userInfoModel;
@end

@interface WYAMineUserInfoModel : NSObject
@property (nonatomic, copy) NSString * userIconUrlString;
@property (nonatomic, copy) NSString * userNameString;
@property (nonatomic, copy) NSString * userInfoString;

/**
 获取个人中心用户的基本信息模型

 @param results 请求返回的结果
 @return WYAMineUserInfoModel 对象
 */
+ (instancetype)initWithResults:(id)results;

@end

NS_ASSUME_NONNULL_END
