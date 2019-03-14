//
//  WYAMineCollectionViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineCollectionViewController.h"
#import "WYAMineCollectionMaterialViewController.h"
#import "WYAMineCollectionDynamicViewController.h"

@interface WYAMineCollectionViewController ()<WYANavBarDelegate,UIGestureRecognizerDelegate>

@end

@implementation WYAMineCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.backgroundColor = [UIColor yellowColor];
    self.navBar = [[WYANavBar alloc] init];
    self.navBar.navTitle = @"动态";
    self.navBar.delegate = self;
    [self.navBar wya_goBackButtonWithImage:@"返回"];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self.view addSubview:self.navBar];
}

- (void)wya_goBackPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ======= delegate
- (NSInteger)wya_numberOfTitlesInMenuView:(WYAMenuView *)menu {
    return 2;
}
- (NSInteger)wya_numbersOfChildControllersInPageController:(WYAPageController *)pageController {
    return 2;
}
- (NSString *)wya_pageController:(WYAPageController *)pageController titleAtIndex:(NSInteger)index {
    switch (index % 2) {
        case 0:
            return @"动态";
        case 1:
            return @"素材";
    }
    return @"NONE";
}

- (UIViewController *)wya_pageController:(WYAPageController *)pageController
                   viewControllerAtIndex:(NSInteger)index {
    switch (index % 2) {
        case 0:
            return [[WYAMineCollectionDynamicViewController alloc] init];
        case 1:
            return [[WYAMineCollectionMaterialViewController alloc] init];
    }
    return [[UIViewController alloc] init];
}

- (void)wya_pageController:(WYAPageController *)pageController
   willEnterViewController:(__kindof UIViewController *)viewController
                  withInfo:(NSDictionary *)info{
    if ([NSStringFromClass([viewController class]) isEqualToString:@"WYAMineCreateDynamicViewController"]) {
        self.navBar.navTitle = @"动态";
        [self.navBar wya_addRightNavBarButtonWithNormalTitle:@[]];
    }else{
        self.navBar.navTitle = @"素材";
    }
}


- (CGFloat)wya_menuView:(WYAMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super wya_menuView:menu widthForItemAtIndex:index];
    return width + 20;
}
- (CGRect)wya_pageController:(WYAPageController *)pageController
   preferredFrameForMenuView:(WYAMenuView *)menuView {

    menuView.backgroundColor = [UIColor wya_whiteColor];

    return CGRectMake(0, WYATopHeight, ScreenWidth,
                      44);
}

- (CGRect)wya_pageController:(WYAPageController *)pageController
   preferredFrameContentView:(WYAPageScrollView *)contentView {

    return CGRectMake(0, WYATopHeight + 44 , ScreenWidth,
                      ScreenHeight- (WYATopHeight + 44));
}

@end
