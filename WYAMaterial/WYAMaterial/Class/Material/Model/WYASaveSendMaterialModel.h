//
//  WYASaveSendMaterialModel.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/26.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYASaveSendMaterialModel : RLMObject
@property NSString * text;
@property NSString * labelString;
@property NSData * imageDatas;
@end
RLM_ARRAY_TYPE(WYASaveSendMaterialModel);
NS_ASSUME_NONNULL_END

