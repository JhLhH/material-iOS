//
//  WYAMineCreateMaterialFootView.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/21.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYAMineCreateMaterialModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYAMineCreateMaterialFootView : UITableViewHeaderFooterView
@property (nonatomic, strong) WYAMineCreateMaterialModel * model;

/**
 获取脚视图高度

 @param model 需要的model数据
 @return 返回view的高度
 */
+ (CGFloat)footViewHeightWithModel:(WYAMineCreateMaterialModel *)model;

@end

NS_ASSUME_NONNULL_END
