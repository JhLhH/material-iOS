//
//  WYALoginVIew.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYALoginView : UIView
@property (nonatomic, copy) void(^loginBlock)(void);
@end

NS_ASSUME_NONNULL_END
