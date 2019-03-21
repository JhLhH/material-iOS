//
//  WYAMineCollectionDynamicCell.h
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYAMineCollectionDynamicModel;
NS_ASSUME_NONNULL_BEGIN

@interface WYAMineCollectionDynamicCell : UITableViewCell
@property (nonatomic, strong) WYAMineCollectionDynamicModel * model;

@property (nonatomic, copy) void (^forwardingBlock)(WYAMineCollectionDynamicModel * model);

@property (nonatomic, copy) void (^collectionBlock)(WYAMineCollectionDynamicModel * model);

@property (nonatomic, copy) void (^commentsBlock)(WYAMineCollectionDynamicModel * model);

@property (nonatomic, copy) void (^praiseBlock)(WYAMineCollectionDynamicModel * model);

@property (nonatomic, copy) void (^stretchBlock)(WYAMineCollectionDynamicModel * model);

@property (nonatomic, copy) void (^imageBlock)(WYAMineCollectionDynamicModel * model, NSInteger index);

+ (CGFloat)getCellHeightWithModel:(WYAMineCollectionDynamicModel *)model;
@end

NS_ASSUME_NONNULL_END
