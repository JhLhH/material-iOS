//
//  WYAMineCollectionMaterialModel.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYAMineCollectionMaterialModel : NSObject
/// 用户头像
@property (nonatomic, copy) NSString * mineCollectionUserIconName;
/// 用户名
@property (nonatomic, copy) NSString * mineCollectionUserName;
/// 用户层级信息
@property (nonatomic, copy) NSString * mineCollectionUserInfoString;
/// 用户层级图标
@property (nonatomic, copy) NSString * mineCollectionUserInfoImgString;
/// 发布时间
@property (nonatomic, copy) NSString * mineCollectionTimeString;
/// 发布内容
@property (nonatomic, copy) NSString * mineCollectionBodyString;
/// 发布图片
@property (nonatomic, copy) NSArray * mineCollectionBodyImgArray;
/// 转发数量
@property (nonatomic, copy) NSString * mineCollectionForwardingNumber;
/// 是否需要展开
@property (nonatomic, assign) BOOL isShowContent;

/**
 获取图文数据模型

 @param results 网络请求的图文数据模型
 @return 返回数据源
 */
+ (NSArray *)getmineCollectionMaterialModelWithResults:(id)results;
@end

NS_ASSUME_NONNULL_END
