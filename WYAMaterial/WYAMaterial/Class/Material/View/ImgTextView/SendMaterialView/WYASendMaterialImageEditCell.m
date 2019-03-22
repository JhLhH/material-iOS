//
//  WYASendDynamicImageEditCell.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYASendMaterialImageEditCell.h"

@implementation WYASendMaterialImageEditCell

- (IBAction)buttonClick:(id)sender {
    if (self.editBlock) {
        self.editBlock();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
