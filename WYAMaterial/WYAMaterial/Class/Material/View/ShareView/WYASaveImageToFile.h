//
//  WYASaveImageToFile.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/26.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN

@interface WYASaveImageToFile : NSObject
-(void)saveImage:(UIImage *)image SaveBlock:(void(^)(BOOL isOK))block;
@end

NS_ASSUME_NONNULL_END
