//
//  WYAMineCreateMaterialModel.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineCreateMaterialModel.h"

@implementation WYAMineCreateMaterialModel
+ (NSArray *)getMineCreateMaterialModelWithResults:(id)results {
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        WYAMineCreateMaterialModel * model = [[WYAMineCreateMaterialModel alloc] init];
        model.mineCreateUserIconName       = @"1";

        model.mineCreateUserInfoString    = @"二级代理";
        model.mineCreateUserInfoImgString = @" ";
        model.mineCreateTimeString        = @"2019-01-20";
        NSString * typeString;
        switch (i) {
            case 1:
                typeString                 = @"正在审核";
                model.mineCreateBodyString = @"店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺";
                break;
            case 3:
                typeString                 = @"审核失败";
                model.mineCreateUserName   = @"3";
                model.mineCreateBodyString = @"店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来,店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来,店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来";
                break;
            case 5:
                typeString                 = @"正在审核";
                model.mineCreateUserName   = @"5";
                model.mineCreateBodyString = @"店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来,店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来,店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来";
                break;
            case 7:
                typeString                 = @"审核失败";
                model.mineCreateUserName   = @"7";
                model.mineCreateBodyString = @"店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来,店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来,店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来";
                break;
            default:
                typeString                 = @"审核成功";
                model.mineCreateUserName   = @"张云雷";
                model.mineCreateBodyString = @"店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺";
                break;
        }
        model.mineCreateAuditType = typeString;

        if (i < 6) {
            NSMutableArray * tempArray = [NSMutableArray array];
            for (int j = 0; j <= i; j++) {
                [tempArray addObject:@"1"];
            }
            model.mineCreateBodyImgArray = [tempArray copy];
            [tempArray removeAllObjects];
        } else {

            model.mineCreateBodyImgArray = @[ @"1", @"1", @"1", @"1", @"1", @"2", @"2", @"2", @"2" ];
        }
        model.mineCreateForwardingNumber = @"666";
        [array addObject:model];
    }
    return [array copy];
}
@end
