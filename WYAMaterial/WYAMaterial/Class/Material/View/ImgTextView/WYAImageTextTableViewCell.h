//
//  WYAImageTextTableViewCell.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/16.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYAMaterialModel.h"
NS_ASSUME_NONNULL_BEGIN
@class WYAImageTextTableViewCell;
/// 收藏点击事件
typedef void (^CollectionAction)(WYAImageTextTableViewCell * target);
/// 转发点击事件
typedef void(^ForwardingAction) (WYAImageTextTableViewCell * target);

@interface WYAImageTextTableViewCell : UITableViewCell

@property (nonatomic, strong) WYAImageTextModel * model;
/// 收藏点击事件
@property (nonatomic, copy) CollectionAction collectionActionBlock;
/// 转发点击事件
@property (nonatomic, copy) ForwardingAction forwardingActionBlock;

+ (CGFloat)getCellHeightWithModel:(WYAImageTextModel *)model;
@end

NS_ASSUME_NONNULL_END
