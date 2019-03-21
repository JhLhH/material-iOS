//
//  WYASettingTableViewCell.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYASettingTableViewCell : UITableViewCell
@property (nonatomic, assign) NSInteger  row;
@property (nonatomic, strong) NSArray <NSString *>* dataArray;
@end

NS_ASSUME_NONNULL_END
