//
//  WYAMineCreateMaterialModel.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYAMineCreateMaterialModel : NSObject
/// 用户头像
@property (nonatomic, copy) NSString * mineCreateUserIconName;
/// 用户名
@property (nonatomic, copy) NSString * mineCreateUserName;
/// 用户层级信息
@property (nonatomic, copy) NSString * mineCreateUserInfoString;
/// 用户层级图标
@property (nonatomic, copy) NSString * mineCreateUserInfoImgString;
/// 发布时间
@property (nonatomic, copy) NSString * mineCreateTimeString;
/// 发布内容
@property (nonatomic, copy) NSString * mineCreateBodyString;
/// 发布图片
@property (nonatomic, copy) NSArray * mineCreateBodyImgArray;
/// 转发数量
@property (nonatomic, copy) NSString * mineCreateForwardingNumber;
/// 是否需要展开
@property (nonatomic, assign) BOOL isShowContent;
/// 审核状态
@property (nonatomic, copy) NSString * mineCreateAuditType;
/// 失败原因
@property (nonatomic, copy) NSString * failReasonString;
/// 选择标签的文字
@property (nonatomic, copy) NSString * labelString;
/**
 获取图文数据模型

 @param results 网络请求的图文数据模型
 @return 返回数据源
 */
+ (NSArray *)getMineCreateMaterialModelWithResults:(id)results;
@end

NS_ASSUME_NONNULL_END
