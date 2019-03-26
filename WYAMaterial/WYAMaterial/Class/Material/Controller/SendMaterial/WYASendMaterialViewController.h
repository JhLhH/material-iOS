//
//  WYASendMaterialViewController.h
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/21.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "BaseViewController.h"
#import "WYAMineCreateMaterialModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM (NSInteger, MaterialType){
    MaterialTypeCreate = 0,
    MaterialTypeEditor
};
@interface WYASendMaterialViewController : BaseViewController
@property (nonatomic, assign) MaterialType materialType;
//@property (nonatomic, strong) NSArray <UIImage *> * imageArray;
//@property (nonatomic, copy) NSString * contentString;
//@property (nonatomic, copy) NSString * labelText;
@property (nonatomic, strong) WYAMineCreateMaterialModel * editorModel;
@end

NS_ASSUME_NONNULL_END
