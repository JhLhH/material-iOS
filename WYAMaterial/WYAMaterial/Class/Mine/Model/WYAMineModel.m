//
//  WYAMineModel.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineModel.h"

@implementation WYAMineModel

@end




/**
 个人中心头部视图的数据
 */
@implementation WYAMineUserInfoModel

+ (instancetype)initWithResults:(id)results{
    WYAMineUserInfoModel * model = [[WYAMineUserInfoModel alloc]init];
    model.userInfoString = @"联创";
    model.userNameString = @"楚留香";
    model.userIconUrlString = @" ";
    return model;
}

@end

/**
 获取历史通知
 */
@implementation WYAMineNoticeModel

+ (NSArray *)getModelsWithResults:(id)results{
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        WYAMineNoticeModel * model = [[WYAMineNoticeModel alloc]init];
        model.contentString = @"通知内容有多少内容文字统统就在这个页面展通知内容有多少内容文字统统就在这个页面展社交新零售数字素材库";
        model.timeString = @"2019.03.15 11：11:11 - 2019.03.15 21：21:21";
        [array addObject:model];
    }
    return [array copy];
}

@end
