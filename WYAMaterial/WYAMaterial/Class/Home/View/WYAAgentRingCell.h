//
//  WYAAgentRingCell.h
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYAAgentRingModel;

NS_ASSUME_NONNULL_BEGIN

@interface WYAAgentRingCell : UITableViewCell

@property (nonatomic, strong) WYAAgentRingModel * model;

@property (nonatomic, copy) void (^forwardingBlock)(WYAAgentRingModel * model);

@property (nonatomic, copy) void (^collectionBlock)(WYAAgentRingModel * model);

@property (nonatomic, copy) void (^commentsBlock)(WYAAgentRingModel * model);

@property (nonatomic, copy) void (^praiseBlock)(WYAAgentRingModel * model);

@property (nonatomic, copy) void (^stretchBlock)(WYAAgentRingModel * model);

@property (nonatomic, copy) void (^imageBlock)(WYAAgentRingModel * model, NSArray * views, NSInteger index);

+ (CGFloat)getCellHeightWithModel:(WYAAgentRingModel *)model;

@end

NS_ASSUME_NONNULL_END
