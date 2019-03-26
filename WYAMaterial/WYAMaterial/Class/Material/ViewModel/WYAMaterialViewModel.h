//
//  WYAMaterialViewModel.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYASaveSendMaterialModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WYAMaterialViewModel : NSObject

@end

@interface WYASaveMaterialViewModel : NSObject


/**
 保存发布素材的内容到本地

 @param text 发布的内容
 @param images 图片数组
 @param labelText 选择的标签
 @return 是否成功
 */
+ (BOOL)saveSendMaterialWithText:(NSString *)text images:(NSArray <UIImage *> *)images labelText:(NSString *)labelText;

/**
 更新发布素材的内容到本地

 @param text 发布的内容
 @param images 图片数组
 @param labelText 选择的标签
 @return 是否成功
 */
+ (BOOL)updateSendMaterialWithText:(NSString *)text images:(NSArray <UIImage *> *)images labelText:(NSString *)labelText;

/**
 查找发动态的草稿数据

 @return WYASaveSendMaterialModel
 */
+ (WYASaveSendMaterialModel *)lookUpSendMaterialModel;

/**
 删除草稿

 @return 删除是否成功
 */
+ (BOOL)deleteSendMaterialModel;
@end
NS_ASSUME_NONNULL_END
