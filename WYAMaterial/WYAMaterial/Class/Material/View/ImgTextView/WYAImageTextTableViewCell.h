//
//  WYAImageTextTableViewCell.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/16.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMaterialModel.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class WYAImageTextTableViewCell;
typedef void (^ShowAllBodyAction)(NSIndexPath * cellIndexPath);
/// 收藏点击事件
typedef void (^CollectionAction)(WYAImageTextTableViewCell * target);
/// 转发点击事件
typedef void (^ForwardingAction)(WYAImageTextTableViewCell * target);
/// 图片预览
typedef void (^ShowImageAction)(WYAImageTextTableViewCell * target, NSArray * views, NSInteger index);

@interface WYAImageTextTableViewCell : UITableViewCell

@property (nonatomic, strong) WYAImageTextModel * model;
/// 收藏点击事件
@property (nonatomic, copy) CollectionAction collectionActionBlock;
/// 转发点击事件
@property (nonatomic, copy) ForwardingAction forwardingActionBlock;
/// 全文/收起
@property (nonatomic, copy) ShowAllBodyAction showAllBodyActionBlock;
/// 图片预览
@property (nonatomic, copy) ShowImageAction  showImageActionBlock;

@property (nonatomic, strong) NSIndexPath * cellIndexPath;
/**
 获取cell的高度

 @param model cell的数据
 @return cell的高度
 */
+ (CGFloat)getCellHeightWithModel:(WYAImageTextModel *)model;

@end

NS_ASSUME_NONNULL_END
