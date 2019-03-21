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

/// 图文

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
/// 是否需要展开
@property (nonatomic, assign) BOOL isShowContent;

/**
 获取图文数据模型

 @param results 网络请求的图文数据模型
 @return 返回数据源
 */
+ (NSArray *)getImgTextModelWithResults:(id)results;

@end

/// 文章
@interface WYAArticleModel : NSObject
/// 标题
@property (nonatomic, copy) NSString * titleString;
/// 内容简介
@property (nonatomic, copy) NSString * contentString;
/// 封面图
@property (nonatomic, copy) NSString * contentImgString;

/// 时间
@property (nonatomic, copy) NSString * timeString;
/// 转发数
@property (nonatomic, copy) NSString * forwardingNumString;
/// 阅读数
@property (nonatomic, copy) NSString * readNumString;
/// 详情链接
@property (nonatomic, copy) NSString * detailsUrlString;

/**
 获取文章的数据

 @param results 请求返回的文章数据
 @return 以数组形式返回
 */
+ (NSArray *)getArticleWithResults:(id)results;
@end
NS_ASSUME_NONNULL_END
