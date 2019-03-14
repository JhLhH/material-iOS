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

@implementation WYAMineUserInfoModel

+ (instancetype)initWithResults:(id)results{
    WYAMineUserInfoModel * model = [[WYAMineUserInfoModel alloc]init];
    model.userInfoString = @"联创";
    model.userNameString = @"楚留香";
    model.userIconUrlString = @" ";
    return model;
}

@end
