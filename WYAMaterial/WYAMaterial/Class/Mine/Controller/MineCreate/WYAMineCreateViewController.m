//
//  WYAMineCreateViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineCreateViewController.h"
#import "WYAMineCreateMaterialViewController.h"
#import "WYAMineCreateDynamicViewController.h"

@interface WYAMineCreateViewController ()<WYANavBarDelegate,UIGestureRecognizerDelegate>

@end

@implementation WYAMineCreateViewController
#pragma mark ======= LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    self.menuView.backgroundColor = [UIColor blackColor];

}

- (void)createNavBar{
    self.navBar = [[WYANavBar alloc] init];
    self.navBar.backgroundColor = [UIColor blackColor];
    self.navBar.navTitle = @"我的创建";
    self.navBar.isShowLine = NO;
    self.navBar.navTitleColor = [UIColor whiteColor];
    self.navBar.delegate = self;
    [self.navBar wya_goBackButtonWithImage:@"fanhui"];
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
            return @"我的动态";
        case 1:
            return @"我的素材";
    }
    return @"NONE";
}

- (UIViewController *)wya_pageController:(WYAPageController *)pageController
                   viewControllerAtIndex:(NSInteger)index {
    switch (index % 2) {
        case 0:
            return [[WYAMineCreateDynamicViewController alloc] init];
        case 1:
            return [[WYAMineCreateMaterialViewController alloc] init];
    }
    return [[UIViewController alloc] init];
}

//- (void)wya_pageController:(WYAPageController *)pageController
//   willEnterViewController:(__kindof UIViewController *)viewController
//                  withInfo:(NSDictionary *)info{
//    if ([NSStringFromClass([viewController class]) isEqualToString:@"WYAMineCreateDynamicViewController"]) {
//        self.navBar.navTitle = @"我的动态";
//    }else{
//        self.navBar.navTitle = @"我的素材";
//    }
//}


- (CGFloat)wya_menuView:(WYAMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super wya_menuView:menu widthForItemAtIndex:index];
    return width + 20;
}
- (CGRect)wya_pageController:(WYAPageController *)pageController
   preferredFrameForMenuView:(WYAMenuView *)menuView {

    return CGRectMake(0, WYATopHeight, ScreenWidth,
                      44);
}

- (CGRect)wya_pageController:(WYAPageController *)pageController
   preferredFrameContentView:(WYAPageScrollView *)contentView {

    return CGRectMake(0, WYATopHeight + 44 , ScreenWidth,
                      ScreenHeight- (WYATopHeight + 44));
}
@end
