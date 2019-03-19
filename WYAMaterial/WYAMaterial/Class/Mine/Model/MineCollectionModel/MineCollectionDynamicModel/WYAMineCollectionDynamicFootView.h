//
//  WYAMineCollectionDynamicFootView.h
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYAMineCollectionDynamicModel;
NS_ASSUME_NONNULL_BEGIN

@interface WYAMineCollectionDynamicFootView : UITableViewHeaderFooterView
@property (nonatomic, strong) WYAMineCollectionDynamicModel * model;
@property (nonatomic, copy) void(^stretchBlock)(WYAMineCollectionDynamicModel * model);
@property (nonatomic, copy) void(^singleCommentsBlock)(WYAMineCollectionDynamicModel * model);
+ (CGFloat)getFootHeightWithModel:(WYAMineCollectionDynamicModel *)model;
@end

NS_ASSUME_NONNULL_END
