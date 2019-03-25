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
+ (NSArray *)getImgTextModelWithResults:(id)results {
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        WYAImageTextModel * model = [[WYAImageTextModel alloc] init];
        model.userIconName        = @"1";
        model.userName            = @"张云雷";
        model.userInfoString      = @"二级代理";
        model.userInfoImgString   = @" ";
        model.timeString          = @"2019-01-20";

        if (i < 6) {
            NSMutableArray * tempArray = [NSMutableArray array];
            for (int j = 0; j <= i; j++) {
                [tempArray addObject:@"1"];
            }
            model.bodyString   = @"店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺";
            model.bodyImgArray = [tempArray copy];
            [tempArray removeAllObjects];
        } else {
            model.bodyString   = @"店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来,店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来,店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来，店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺，订单、商品和售后都来";
            if (i == 7) {
                model.userName = @"哈哈哈哈哈哈";
                model.bodyImgArray = @[];
            }else{
            model.bodyImgArray = @[ @"1", @"1", @"1", @"1", @"1", @"2", @"2", @"2", @"2" ];
            }
        }
        model.forwardingNumber = @"666";
        [array addObject:model];
    }
    return [array copy];
}

@end

@implementation WYAArticleModel

+ (NSArray *)getArticleWithResults:(id)results {
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        WYAArticleModel * model   = [[WYAArticleModel alloc] init];
        model.titleString         = @"一代一品一个系统多个独立产品线哈哈哈哈";
        model.contentString       = @"店主不用铺货、无需发货、申请成为店主后会拥有属于自己的独立店铺";
        model.contentImgString    = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1552901682&di=b23661d86c50223d02fb22c8c77d1e42&src=http://b-ssl.duitang.com/uploads/item/201602/24/20160224122640_XSZYB.thumb.700_0.jpeg";
        model.timeString          = @"2019-01-20";
        model.forwardingNumString = @"263";
        model.readNumString       = @"635";
        [array addObject:model];
    }
    return [array copy];
}

@end
