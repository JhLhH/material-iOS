//
//  WYASendMaterialViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/21.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYASendMaterialViewController.h"

@interface WYASendMaterialViewController ()

@end

@implementation WYASendMaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navBar wya_addLeftNavBarButtonWithNormalTitle:@[@"取消"] normalColor:@[[UIColor wya_textWhitColorl]] highlightedColor:@[[UIColor wya_textGrayColor]]];
    [self.navBar wya_addRightNavBarButtonWithNormalTitle:@[@"发布"] normalColor:@[[UIColor wya_textWhitColorl]] highlightedColor:@[[UIColor wya_textGrayColor]]];
    // Do any additional setup after loading the view.
}
- (void)wya_customLeftBarButtonItemPressed:(UIButton *)sender{
    if (self.materialType == MaterialTypeCreate) {
        // 在点击取消按钮时需要确认是否保存草稿
        [self createPop];
    }else{
        // 是否放弃编辑
    }
}
- (void)wya_customrRightBarButtonItemPressed:(UIButton *)sender{

}

- (void)createPop{
    WYAAlertController * alert =
    [WYAAlertController wya_alertWithTitle:@"是否保存草稿？"
                                   Message:nil
                          AlertLayoutStyle:WYAAlertLayoutStyleHorizontal];
    alert.backgroundButton.enabled = NO;
    alert.presentStyle             = WYAPopupPresentStyleBounce;
    alert.dismissStyle             = WYAPopupDismissStyleShrink;
    // 创建 action
    WYAAlertAction * defaultAction =
    [WYAAlertAction wya_actionWithTitle:@"不保留"
                                  style:WYAAlertActionStyleCancel
                                handler:^{

                                    [self.navigationController popViewControllerAnimated:YES];
                                }];

    WYAAlertAction * cancelAction =
    [WYAAlertAction wya_actionWithTitle:@"保留"
                                  style:WYAAlertActionStyleDefault
                                handler:^{
//                                    BOOL isSuccess;
//                                    if (self.model) {
//                                        isSuccess = [WYASendDynamicViewModel updateSendDynamicDraftWithText:self.textView.text images:self.dataSource];
//                                    } else {
//                                        isSuccess = [WYASendDynamicViewModel saveSendDynamicDraftWithText:self.textView.text images:self.dataSource];
//                                    }
                                    [UIView wya_showBottomToastWithMessage:@"保存失败"];
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        [self.navigationController popViewControllerAnimated:YES];
                                    });
                                }];

    [alert wya_addAction:defaultAction];
    [alert wya_addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
