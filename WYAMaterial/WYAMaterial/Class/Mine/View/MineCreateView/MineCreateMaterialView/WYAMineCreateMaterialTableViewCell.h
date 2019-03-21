//
//  WYAMineCreateMaterialTableViewCell.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYAMineCreateMaterialModel.h"

NS_ASSUME_NONNULL_BEGIN
@class WYAMineCreateMaterialTableViewCell;
typedef void (^ShowAllBodyAction)(NSIndexPath * cellIndexPath);
/// 收藏点击事件
typedef void (^CollectionAction)(WYAMineCreateMaterialTableViewCell * target);
/// 转发点击事件
typedef void(^ForwardingAction) (WYAMineCreateMaterialTableViewCell * target);

@interface WYAMineCreateMaterialTableViewCell : UITableViewCell

@property (nonatomic, strong) WYAMineCreateMaterialModel * model;
/// 收藏点击事件
@property (nonatomic, copy) CollectionAction collectionActionBlock;
/// 转发点击事件
@property (nonatomic, copy) ForwardingAction forwardingActionBlock;
/// 全文/收起
@property (nonatomic, copy) ShowAllBodyAction showAllBodyActionBlock;

@property (nonatomic, strong) NSIndexPath * cellIndexPath;
/// 是否在cell上显示下划线
@property (nonatomic, assign) BOOL isShowCellLine;
/**
 获取cell的高度

 @param model cell的数据
 @return cell的高度
 */
+ (CGFloat)getCellHeightWithModel:(WYAMineCreateMaterialModel *)model;
@end

NS_ASSUME_NONNULL_END
