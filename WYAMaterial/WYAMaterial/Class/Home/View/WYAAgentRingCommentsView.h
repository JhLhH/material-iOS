//
//  WYAAgentRingCommentsView.h
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYAAgentRingCommentsView : UIView
@property (nonatomic, strong) UITextView * textView;

/**
 设置自身高度变化的block
 */
@property (nonatomic, copy) void(^frameChangeBlock)(WYAAgentRingCommentsView * view, CGFloat height);

/**
 发送回调
 */
@property (nonatomic, copy) void(^sendCommentsBlock)(NSString * text);
@end

NS_ASSUME_NONNULL_END
