//
//  WYAAgentRingModel.h
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYAAgentRingImageModel : NSObject

@property (nonatomic, copy) NSString * imageUrl;

@end

@interface WYAAgentRingCommentsModel : NSObject

@property (nonatomic, copy) NSString * personName;

@property (nonatomic, copy) NSString * comments;

@property (nonatomic, assign) BOOL show;

@end

@interface WYAAgentRingModel : NSObject

@property (nonatomic, copy) NSString * userHeader;

@property (nonatomic, copy) NSString * userName;

@property (nonatomic, copy) NSString * userLevel;

@property (nonatomic, copy) NSString * time;

@property (nonatomic, copy) NSString * content;

@property (nonatomic, strong) NSArray<WYAAgentRingImageModel *> * urls;

@property (nonatomic, assign) BOOL forwarding;

@property (nonatomic, assign) int collection;

@property (nonatomic, assign) int person;

@property (nonatomic, strong) NSArray<WYAAgentRingCommentsModel *> * comments;

@property (nonatomic, assign) BOOL show;

@property (nonatomic, assign) BOOL contentShow;

@property (nonatomic, copy) NSString * personPraise;

@property (nonatomic, copy) NSString * personCollection;
@end

NS_ASSUME_NONNULL_END
