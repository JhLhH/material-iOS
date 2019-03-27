//
//  WYALabelView.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/22.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYALabelView : UIView
@property (nonatomic, strong) NSArray * labelArray;
@property(nonatomic, copy) void (^SelecrtedLabelAction)(NSString * labelTitle);
@property (nonatomic, copy) NSString * selectedLabelString;
@end

NS_ASSUME_NONNULL_END
