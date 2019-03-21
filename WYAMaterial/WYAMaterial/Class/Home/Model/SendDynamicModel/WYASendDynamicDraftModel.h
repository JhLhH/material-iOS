//
//  WYASendDynamicDraftModel.h
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYASendDynamicDraftModel : RLMObject

@property NSString * text;

@property NSData * imageDatas;

@end

RLM_ARRAY_TYPE(WYASendDynamicDraftModel)

NS_ASSUME_NONNULL_END
