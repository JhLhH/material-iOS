//
//  WYAMaterialModel.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYAMaterialModel : NSObject

@end

@interface WYAImageTextModel : NSObject
/// 用户头像
@property (nonatomic, copy) NSString * userIconName;
/// 用户名
@property (nonatomic, copy) NSString * userName;
/// 用户层级信息
@property (nonatomic, copy) NSString * userInfoString;
/// 用户层级图标
@property (nonatomic, copy) NSString * userInfoImgString;
/// 发布时间
@property (nonatomic, copy) NSString * timeString;
/// 发布内容
@property (nonatomic, copy) NSString * bodyString;
/// 发布图片
@property (nonatomic, copy) NSArray * bodyImgArray;
/// 转发数量
@property (nonatomic, copy) NSString * forwardingNumber;

/**
 获取图文数据模型

 @param results 网络请求的图文数据模型
 @return 返回数据源
 */
+ (NSArray *)getImgTextModelWithResults:(id)results;

@end

NS_ASSUME_NONNULL_END
