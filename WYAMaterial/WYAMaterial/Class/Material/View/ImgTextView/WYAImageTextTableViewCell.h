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

@interface WYAImageTextTableViewCell : UITableViewCell
@property (nonatomic, strong) WYAImageTextModel * model;
+ (CGFloat)getCellHeightWithModel:(WYAImageTextModel *)model;
@end

NS_ASSUME_NONNULL_END
