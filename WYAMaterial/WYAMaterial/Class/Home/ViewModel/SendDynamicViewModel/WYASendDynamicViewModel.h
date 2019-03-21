//
//  WYASendDynamicViewModel.h
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WYASendDynamicDraftModel;
NS_ASSUME_NONNULL_BEGIN

@interface WYASendDynamicViewModel : NSObject

/**
 保存发动态的草稿数据

 @param text 文字
 @param images 图片数组
 */
+ (BOOL)saveSendDynamicDraftWithText:(NSString *)text images:(NSArray *)images;

/**
 更新发动态的草稿数据

 @param text 文字
 @param images 图片数组
 */
+ (BOOL)updateSendDynamicDraftWithText:(NSString *)text images:(NSArray *)images;

/**
 查找发动态的草稿数据

 @return dic
 */
+ (WYASendDynamicDraftModel *)lookupSendDynamicDraft;

+ (BOOL)deleteSendDynamicDraft;
@end

NS_ASSUME_NONNULL_END
