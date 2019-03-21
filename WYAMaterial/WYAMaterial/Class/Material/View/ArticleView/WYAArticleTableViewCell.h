//
//  WYAArticleTableViewCell.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMaterialModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYAArticleTableViewCell : UITableViewCell
@property (nonatomic, strong) WYAArticleModel * model;
@property (nonatomic, copy) void (^DidSelectActionBlock)(WYAArticleTableViewCell * taraget);
+ (CGFloat)getCellHeightWithModel:(WYAArticleModel *)model;
@end

NS_ASSUME_NONNULL_END
