//
//  WYAAgentRingSectionFootView.h
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYAAgentRingModel;
NS_ASSUME_NONNULL_BEGIN

@interface WYAAgentRingSectionFootView : UITableViewHeaderFooterView

@property (nonatomic, strong) WYAAgentRingModel * model;
@property (nonatomic, copy) void(^stretchBlock)(WYAAgentRingModel * model);

+ (CGFloat)getFootHeightWithModel:(WYAAgentRingModel *)model;
@end

NS_ASSUME_NONNULL_END
