//
//  WYANoticeTableViewCell.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/15.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYAMineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WYANoticeTableViewCell : UITableViewCell
@property (nonatomic, strong) WYAMineNoticeModel * model;

/**
 获取cell的高度

 @param model 历史通知model
 @return 返回cell高度
 */
+ (CGFloat)getCellHeightWithModel:(WYAMineNoticeModel *)model;
@end

NS_ASSUME_NONNULL_END
