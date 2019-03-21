//
//  WYAMineCreateReviewFailCell.h
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/18.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYAMineCreateDynamicModel;
NS_ASSUME_NONNULL_BEGIN

@interface WYAMineCreateReviewFailCell : UITableViewCell

@property (nonatomic, strong) WYAMineCreateDynamicModel * model;

@property (nonatomic, copy) void (^stretchBlock)(WYAMineCreateDynamicModel * model);

@property (nonatomic, copy) void (^imageBlock)(WYAMineCreateDynamicModel * model, NSInteger index);

+ (CGFloat)getCellHeightWithModel:(WYAMineCreateDynamicModel *)model;
@end

NS_ASSUME_NONNULL_END
