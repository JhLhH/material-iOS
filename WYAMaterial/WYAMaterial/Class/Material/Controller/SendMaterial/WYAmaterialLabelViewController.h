//
//  WYAmaterialLabelViewController.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/22.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYAmaterialLabelViewController : BaseViewController
@property(nonatomic, copy) void (^SelectedLabelActionBlock)(NSString * title);
/// 被编辑状态进入后显示选中的标签
@property (nonatomic, copy) NSString * selectedLabelString;
@end

NS_ASSUME_NONNULL_END
