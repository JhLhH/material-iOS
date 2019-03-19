//
//  WYAMineCollectionDynamicModel.h
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface WYAMineCollectionDynamicImageModel : NSObject

@property (nonatomic, copy) NSString * imageUrl;

@end

@interface WYAMineCollectionDynamicCommentsModel : NSObject

@property (nonatomic, copy) NSString * personName;

@property (nonatomic, copy) NSString * comments;

@property (nonatomic, assign) BOOL show;

@end

@interface WYAMineCollectionDynamicModel : NSObject

@property (nonatomic, copy) NSString * userHeader;

@property (nonatomic, copy) NSString * userName;

@property (nonatomic, copy) NSString * userLevel;

@property (nonatomic, copy) NSString * time;

@property (nonatomic, copy) NSString * content;

@property (nonatomic, strong) NSArray <WYAMineCollectionDynamicImageModel *> * urls;

@property (nonatomic, assign) BOOL forwarding;

@property (nonatomic, assign) int collection;

@property (nonatomic, assign) int person;

@property (nonatomic, strong) NSArray <WYAMineCollectionDynamicCommentsModel *> * comments;

/**
 审核状态：0：失败，1：成功， 2：正在审核
 */
@property (nonatomic, assign) int reviewStatus;

@property (nonatomic, assign) BOOL show;

@property (nonatomic, assign) BOOL contentShow;

@end

NS_ASSUME_NONNULL_END
