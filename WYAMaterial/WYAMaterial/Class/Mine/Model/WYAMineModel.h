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

@interface WYAMineNoticeModel : NSObject

/**
 通知内容最大值为50个字
 */
@property (nonatomic, copy) NSString * contentString;
@property (nonatomic, copy) NSString * timeString;

/**
 获取个人中心模块历史通知数据

 @param results 请求返回的数据
 @return 返回一个供tableView使用的dataSources数据
 */
+ (NSArray *)getModelsWithResults:(id)results;
@end


@interface WYAMinSettingModel : NSObject
@property (nonatomic, copy) NSString * userIconUrl;
@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * userPhoneNum;
@property (nonatomic, copy) NSString * weCheatNum;

+ (instancetype)initWithReqults:(id)results;
@end


@interface WYAMinSettingTeamModel : NSObject
@property (nonatomic, copy) NSString * teamIcon;
@property (nonatomic, copy) NSString * teamName;
@property (nonatomic, copy) NSString * teamIntroduction;
@property (nonatomic, copy) NSString * teamState;
+ (NSArray *)getModelWithReqults:(id)results;
@end

NS_ASSUME_NONNULL_END
