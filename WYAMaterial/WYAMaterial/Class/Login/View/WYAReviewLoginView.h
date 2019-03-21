//
//  WYAReviewLoginView.h
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/21.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYAReviewLoginView : UIView
@property (nonatomic, copy) void(^loginBlock)(void);
@end

NS_ASSUME_NONNULL_END
