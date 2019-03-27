//
//  WYALoginViewModel.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "BaseNetWorking.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYALoginViewModel : BaseNetWorking
+ (void)loginWithCode:(NSString *)code success:(Success)success fail:(Fail)fail;
@end

NS_ASSUME_NONNULL_END
