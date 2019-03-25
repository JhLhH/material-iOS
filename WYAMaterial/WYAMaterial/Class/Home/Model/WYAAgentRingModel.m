//
//  WYAAgentRingModel.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAAgentRingModel.h"

@implementation WYAAgentRingImageModel

@end

@implementation WYAAgentRingCommentsModel

@end


@implementation WYAAgentRingModel

-(NSString *)personPraise{
    if (self.person > 999 && self.person < 9999) {
        NSInteger count = self.person / 1000;
        return [NSString stringWithFormat:@"%ldk",(long)count];
    } else if (self.person > 9999 && self.person < 99999) {
        NSInteger count = self.person / 10000;
        return [NSString stringWithFormat:@"%ldw",(long)count];
    }
    return [NSString stringWithFormat:@"%d",self.person];
}

-(NSString *)personCollection{
    if (self.collection > 999 && self.collection < 9999) {
        NSInteger count = self.collection / 1000;
        return [NSString stringWithFormat:@"%ldk",(long)count];
    } else if (self.collection > 9999 && self.collection < 99999) {
        NSInteger count = self.collection / 10000;
        return [NSString stringWithFormat:@"%ldw",(long)count];
    }
    return [NSString stringWithFormat:@"%d",self.collection];
}

@end
