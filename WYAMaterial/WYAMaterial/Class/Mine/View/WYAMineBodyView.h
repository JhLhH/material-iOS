//
//  WYAMineBodyView.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/16.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^MineCollectionBlock)(void);
typedef void (^MineCreateBlock)(void);
typedef void (^MineNoticeBlock)(void);

@interface WYAMineBodyView : UIView
@property (nonatomic, copy) MineCreateBlock createBlock;
@property (nonatomic, copy) MineCollectionBlock collectionActionBlock;
@property (nonatomic, copy) MineNoticeBlock noticeBlock;
@end

NS_ASSUME_NONNULL_END
