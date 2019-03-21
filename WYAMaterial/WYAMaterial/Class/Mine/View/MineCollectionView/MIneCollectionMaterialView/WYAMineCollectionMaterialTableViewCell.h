//
//  WYAMineCollectionMaterialTableViewCell.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/21.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineCollectionMaterialModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WYAMineCollectionMaterialTableViewCell;
typedef void (^ShowAllBodyAction)(NSIndexPath * cellIndexPath);
/// 收藏点击事件
typedef void (^CollectionAction)(WYAMineCollectionMaterialTableViewCell * target);
/// 转发点击事件
typedef void (^ForwardingAction)(WYAMineCollectionMaterialTableViewCell * target);

@interface WYAMineCollectionMaterialTableViewCell : UITableViewCell
@property (nonatomic, strong) WYAMineCollectionMaterialModel * model;
/// 收藏点击事件
@property (nonatomic, copy) CollectionAction collectionActionBlock;
/// 转发点击事件
@property (nonatomic, copy) ForwardingAction forwardingActionBlock;
/// 全文/收起
@property (nonatomic, copy) ShowAllBodyAction showAllBodyActionBlock;

@property (nonatomic, strong) NSIndexPath * cellIndexPath;
/**
 获取cell的高度

 @param model cell的数据
 @return cell的高度
 */
+ (CGFloat)getCellHeightWithModel:(WYAMineCollectionMaterialModel *)model;
@end

NS_ASSUME_NONNULL_END
