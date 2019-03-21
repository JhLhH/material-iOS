//
//  WYAContentView.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/15.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^SureButtonPressed)(NSArray * selectedBtnArray);
typedef void (^ResetButtonPressed)(void);

@interface WYAContentView : UIView
@property (nonatomic, copy) SureButtonPressed sureButtonAction;
@property (nonatomic, copy) ResetButtonPressed resetButtonAction;
@property (nonatomic, strong) NSArray * contentArray;

- (void)resetContentViewItem;

@end

NS_ASSUME_NONNULL_END
