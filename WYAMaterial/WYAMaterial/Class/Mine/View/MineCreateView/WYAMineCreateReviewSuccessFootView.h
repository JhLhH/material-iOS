//
//  WYAMineCreateReviewSuccessFootView.h
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYAMineCreateDynamicModel;
NS_ASSUME_NONNULL_BEGIN

@interface WYAMineCreateReviewSuccessFootView : UITableViewHeaderFooterView
@property (nonatomic, strong) WYAMineCreateDynamicModel * model;
@property (nonatomic, copy) void(^stretchBlock)(WYAMineCreateDynamicModel * model);
@property (nonatomic, copy) void(^singleCommentsBlock)(WYAMineCreateDynamicModel * model);
+ (CGFloat)getFootHeightWithModel:(WYAMineCreateDynamicModel *)model;
@end

NS_ASSUME_NONNULL_END
