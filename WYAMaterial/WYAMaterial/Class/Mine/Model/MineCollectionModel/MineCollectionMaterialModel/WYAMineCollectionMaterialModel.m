//
//  WYAMineCollectionMaterialModel.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineCollectionMaterialModel.h"

@implementation WYAMineCollectionMaterialModel
+ (NSArray *)getmineCollectionMaterialModelWithResults:(id)results{
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        WYAMineCollectionMaterialModel * model = [[WYAMineCollectionMaterialModel alloc]init];
        model.mineCollectionUserIconName = @"1";
        model.mineCollectionUserName = @"张云雷";
        model.mineCollectionUserInfoString = @"二级代理";
        model.mineCollectionUserInfoImgString = @" ";
        model.mineCollectionTimeString = @"2019-01-20";
        if (i<6) {
            NSMutableArray * tempArray = [NSMutableArray array];
            for (int j = 0; j <= i; j++) {
                [tempArray addObject:@"1"];
            }
            model. mineCollectionBodyString = @"店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺";
            model. mineCollectionBodyImgArray = [tempArray copy];
            [tempArray removeAllObjects];
        }else{
            model. mineCollectionBodyString = @"店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来,店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来,店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来";
            model. mineCollectionBodyImgArray = @[@"1",@"1",@"1",@"1",@"1",@"2",@"2",@"2",@"2"];
        }
        model. mineCollectionForwardingNumber = @"666";
        [array addObject:model];
    }
    return [array copy];
}
@end
