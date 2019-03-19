//
//  WYAMaterialModel.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMaterialModel.h"

@implementation WYAMaterialModel

@end

@implementation WYAImageTextModel
+ (NSArray *)getImgTextModelWithResults:(id)results{
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        WYAImageTextModel * model = [[WYAImageTextModel alloc]init];
        model.userIconName = @"1";
        model.userName = @"张云雷";
        model.userInfoString = @"二级代理";
        model.userInfoImgString = @" ";
        model.timeString = @"2019-01-20";
        model.bodyString = @"店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来";
        if (i<6) {
            NSMutableArray * tempArray = [NSMutableArray array];
            for (int j = 0; j <= i; j++) {
                [tempArray addObject:@"1"];
            }
            model.bodyImgArray = [tempArray copy];
            [tempArray removeAllObjects];
        }else{
            model.bodyImgArray = @[@"1",@"1",@"1",@"1",@"1",@"2",@"2",@"2",@"2"];
        }
        model.forwardingNumber = @"666";
        [array addObject:model];
    }
    return [array copy];
}

@end
