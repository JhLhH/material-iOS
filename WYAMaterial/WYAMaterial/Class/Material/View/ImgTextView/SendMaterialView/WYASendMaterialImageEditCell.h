//
//  WYASendDynamicImageEditCell.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYASendMaterialImageEditCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView * imgView;
@property (nonatomic, copy) void (^editBlock)(void);
@end

NS_ASSUME_NONNULL_END
