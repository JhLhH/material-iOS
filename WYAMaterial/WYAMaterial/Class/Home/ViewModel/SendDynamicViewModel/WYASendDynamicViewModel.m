//
//  WYASendDynamicViewModel.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYASendDynamicViewModel.h"
#import <Realm/Realm.h>
#import "WYASendDynamicDraftModel.h"
@implementation WYASendDynamicViewModel

+ (BOOL)saveSendDynamicDraftWithText:(NSString *)text images:(NSArray *)images{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:images];
    WYASendDynamicDraftModel * model = [[WYASendDynamicDraftModel alloc] init];
    model.text = text;
    model.imageDatas = data;

    WYARealmBaseManager * dbManager = [WYARealmBaseManager wya_defaultRealm];
    return [dbManager wya_insertRealmWithObject:model];
}

+ (BOOL)updateSendDynamicDraftWithText:(NSString *)text images:(NSArray *)images{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:images];
    WYASendDynamicDraftModel * model = [WYASendDynamicViewModel lookupSendDynamicDraft];
    RLMRealm * realm = [RLMRealm defaultRealm];

    return [realm transactionWithBlock:^{
        model.text = text;
        model.imageDatas = data;
    } error:nil];
}

+ (WYASendDynamicDraftModel *)lookupSendDynamicDraft{
    WYARealmBaseManager * dbManager = [WYARealmBaseManager wya_defaultRealm];
    RLMResults * res = [dbManager wya_lookupRealmWithAllClassName:@"WYASendDynamicDraftModel"];
    NSLog(@"res==%@",res);
    WYASendDynamicDraftModel * model = [res firstObject];
    return model;
}

+ (BOOL)deleteSendDynamicDraft{
    WYASendDynamicDraftModel * model = [WYASendDynamicViewModel lookupSendDynamicDraft];
    WYARealmBaseManager * dbManager = [WYARealmBaseManager wya_defaultRealm];
    return [dbManager wya_deleteRealmWithObject:model];
}

@end
