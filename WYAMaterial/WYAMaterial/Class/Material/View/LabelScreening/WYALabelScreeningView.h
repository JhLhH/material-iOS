//
//  WYALabelScreeningView.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/15.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYALabelScreeningView;
NS_ASSUME_NONNULL_BEGIN

//@protocol WYALabelScreeningViewDelegate <NSObject>
//
//@required
//- (void)
//
//@end

@interface WYALabelScreeningView : UIView
@property (nonatomic, assign) BOOL screenViewIsShow;
@property (nonatomic, strong) NSArray * dataSources;
/**
 展示筛选视图
 */
- (void)showScreenView;

/**
 隐藏筛选视图
 */
- (void)hidenScreenView;
@end

NS_ASSUME_NONNULL_END
