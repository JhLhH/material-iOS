//
//  WYAMaterialViewModel.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMaterialViewModel.h"

@implementation WYAMaterialViewModel

@end

@implementation WYASaveMaterialViewModel

+ (BOOL)saveSendMaterialWithText:(NSString *)text images:(NSArray<UIImage *> *)images labelText:(NSString *)labelText{
    NSData * data                    = [NSKeyedArchiver archivedDataWithRootObject:images];
    WYASaveSendMaterialModel * model = [[WYASaveSendMaterialModel alloc] init];
    model.text                       = text;
    model.imageDatas                 = data;
    model.labelString                = labelText;
    WYARealmBaseManager * dbManager = [WYARealmBaseManager wya_defaultRealm];
    return [dbManager wya_insertRealmWithObject:model];
}

+ (BOOL)updateSendMaterialWithText:(NSString *)text images:(NSArray<UIImage *> *)images labelText:(NSString *)labelText{
    NSData * data                    = [NSKeyedArchiver archivedDataWithRootObject:images];
    WYASaveSendMaterialModel * model = [WYASaveMaterialViewModel lookUpSendMaterialModel];
    RLMRealm * realm                 = [RLMRealm defaultRealm];

    return [realm transactionWithBlock:^{
        model.text       = text;
        model.imageDatas = data;
        model.labelString = labelText;
    } error:nil];
}

+ (WYASaveSendMaterialModel *)lookUpSendMaterialModel{
    WYARealmBaseManager * dbManager = [WYARealmBaseManager wya_defaultRealm];
    RLMResults * res                = [dbManager wya_lookupRealmWithAllClassName:@"WYASaveSendMaterialModel"];
    WYASaveSendMaterialModel * model = [res firstObject];
    return model;
}

+ (BOOL)deleteSendMaterialModel{
    WYASaveSendMaterialModel * model = [WYASaveMaterialViewModel lookUpSendMaterialModel];
    if (model) {
        WYARealmBaseManager * dbManager  = [WYARealmBaseManager wya_defaultRealm];
        return [dbManager wya_deleteRealmWithObject:model];
    }
    return YES;
}

@end
