//
//  WYAMaterialViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMaterialViewController.h"

#import "WYAImgTextViewController.h"
#import "WYAArticleViewController.h"

#import "WYALabelScreeningView.h"

@interface WYAMaterialViewController ()<WYANavBarDelegate>
@property (nonatomic, strong) WYALabelScreeningView * screeningView;
@end

@implementation WYAMaterialViewController
#pragma mark ======= LifeCircle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.menuView.backgroundColor = [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar = [[WYANavBar alloc] init];
    self.navBar.navTitle = @"图文";
    self.navBar.navTitleColor = [UIColor whiteColor];
    self.navBar.backgroundColor = [UIColor blackColor];
    self.navBar.isShowLine = NO;
    self.navBar.delegate = self;
    [self.navBar wya_addRightNavBarButtonWithNormalTitle:@[@"筛选"]
                                             normalColor:@[[UIColor whiteColor]]
                                        highlightedColor:@[[UIColor grayColor]]];
    [self.view addSubview:self.navBar];
}

- (void)wya_rightBarButtonItemPressed:(UIButton *)sender{
    NSLog(@"筛选");
    if (!self.screeningView.screenViewIsShow) {
        [self.screeningView showScreenView];
    }else{
        [self.screeningView hidenScreenView];
    }
}

#pragma mark ======= Lazy

- (WYALabelScreeningView *)screeningView{
    if(!_screeningView){
        _screeningView = ({
            WYALabelScreeningView * object = [[WYALabelScreeningView alloc]initWithFrame:CGRectZero];
            object;
        });
    }
    return _screeningView;
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
            return @"图文";
        case 1:
            return @"文章";
    }
    return @"NONE";
}

- (UIViewController *)wya_pageController:(WYAPageController *)pageController
                   viewControllerAtIndex:(NSInteger)index {
    switch (index % 2) {
        case 0:
            return [[WYAImgTextViewController alloc] init];
        case 1:
            return [[WYAArticleViewController alloc] init];
    }
    return [[UIViewController alloc] init];
}

- (void)wya_pageController:(WYAPageController *)pageController didEnterViewController:(nonnull __kindof UIViewController *)viewController withInfo:(nonnull NSDictionary *)info{
    if ([NSStringFromClass([viewController class]) isEqualToString:@"WYAArticleViewController"]) {
        self.navBar.navTitle = @"文章";
        [self.navBar wya_addRightNavBarButtonWithNormalTitle:@[]];
    }else{
        self.navBar.navTitle = @"图文";
        [self.navBar wya_addRightNavBarButtonWithNormalTitle:@[@"筛选"]
                                                 normalColor:@[[UIColor whiteColor]]
                                            highlightedColor:@[[UIColor grayColor]]];

    }
}

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
                      ScreenHeight- (WYATopHeight + 44) - WYATabBarHeight );
}


@end
