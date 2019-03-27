//
//  WYAMineCollectionMaterialImgBodyview.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/21.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYAMineCollectionMaterialImgBodyview : UIView
@property (nonatomic, strong) NSArray * imageArray;
@property(nonatomic, copy) void (^ImageButtonAction)(NSArray * views,NSInteger index);

@end

NS_ASSUME_NONNULL_END
