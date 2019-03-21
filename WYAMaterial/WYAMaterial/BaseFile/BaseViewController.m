//
//  BaseViewController.m
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/3.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () <WYANavBarDelegate, UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor wya_bgColor];
    [self addCustomNavBar];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.navBar];
}
#pragma mark ======= private
- (void)addCustomNavBar {
    NSArray * arrViewControllers = self.navigationController.viewControllers;
    if ([arrViewControllers indexOfObject:self] > 0) {
        [self.navBar wya_goBackButtonWithImage:@"icon_back"];
    }
    [self.view addSubview:self.navBar];
}
#pragma mark---------- 版本对比
- (void)wya_versionUpdateAlertView {
    // 获取appStore版本号
    NSString * url =
        [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@", @"1436011775"];
    [self Postpath:url]; // 获取版本号
}

- (void)Postpath:(NSString *)path {
    NSURL * url = [NSURL URLWithString:path];
    NSMutableURLRequest * request =
        [NSMutableURLRequest requestWithURL:url
                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                            timeoutInterval:10];

    [request setHTTPMethod:@"POST"];

    NSOperationQueue * queue = [NSOperationQueue new];

    [NSURLConnection
        sendAsynchronousRequest:request
                          queue:queue
              completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {
                  NSMutableDictionary * receiveStatusDic = [[NSMutableDictionary alloc] init];
                  if (data) {
                      NSDictionary * receiveDic =
                          [NSJSONSerialization JSONObjectWithData:data
                                                          options:NSJSONReadingMutableLeaves
                                                            error:nil];
                      if ([[receiveDic valueForKey:@"resultCount"] intValue] > 0) {
                          [receiveStatusDic setValue:@"1" forKey:@"status"];
                          [receiveStatusDic setValue:[[[receiveDic valueForKey:@"results"]
                                                         objectAtIndex:0] valueForKey:@"version"]
                                              forKey:@"version"];

                      } else {
                          [receiveStatusDic setValue:@"-1" forKey:@"status"];
                      }
                  } else {
                      [receiveStatusDic setValue:@"-1" forKey:@"status"];
                  }

                  [self
                      performSelectorOnMainThread:@selector(compareCurVersionNumWithAppStoreNumber:)
                                       withObject:receiveStatusDic
                                    waitUntilDone:NO];
              }];
}

- (void)compareCurVersionNumWithAppStoreNumber:(id)appStoreVersion {
    NSString * appStoreNum        = appStoreVersion[@"version"]; //线上版本号
    NSDictionary * infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString * app_Version =
        [infoDictionary objectForKey:@"CFBundleShortVersionString"]; // 当前版本号
    NSInteger isShowAlertView =
        [NSString wya_compareVersion:appStoreNum
                                  to:app_Version]; // 对比版本号
    NSString * msg = [NSString
        stringWithFormat:
            @"当前版本为%@,新版本%@发布，为不影响您的使用请及时更新",
            app_Version, appStoreNum];
    if (isShowAlertView == 1) {
        UIAlertController * alert =
            [UIAlertController alertControllerWithTitle:@"更新提示"
                                                message:msg
                                         preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                                style:UIAlertActionStyleDestructive
                                                              handler:^(UIAlertAction * action){

                                                              }];
        UIAlertAction * defaultAction = [UIAlertAction
            actionWithTitle:@"确定"
                      style:UIAlertActionStyleDefault
                    handler:^(UIAlertAction * action) {
                        // 跳转AppStore更新
                        NSString * webLink = @"https://itunes.apple.com/cn/app/id1436011775";
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webLink]];
                    }];

        [alert addAction:cancelAction];
        [alert addAction:defaultAction];

        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Getter -
- (WYANavBar *)navBar {
    if (!_navBar) {
        _navBar = ({
            WYANavBar * object     = [[WYANavBar alloc] init];
            object.delegate        = self;
            object.navTitle        = @"素材库";
            object.isShowLine = NO;
            object.navTitleColor   = [UIColor whiteColor];
            object.backgroundColor = [UIColor blackColor];
            object;
        });
    }
    return _navBar;
}

#pragma mark ======= setter
- (void)setHiddenNavBar:(BOOL)hiddenNavBar {
    _hiddenNavBar = hiddenNavBar;
    if (hiddenNavBar) {
        self.navBar.hidden = YES;
    } else {
        self.navBar.hidden = NO;
    }
}
- (void)setNavTitle:(NSString *)navTitle {
    _navTitle            = navTitle;
    self.navBar.navTitle = _navTitle;
}
- (void)setNavTitleFont:(CGFloat)navTitleFont {
    _navTitleFont            = navTitleFont;
    self.navBar.navTitleFont = _navTitleFont;
}
- (void)setNavTitleColor:(UIColor *)navTitleColor {
    _navTitleColor            = navTitleColor;
    self.navBar.navTitleColor = _navTitleColor;
}
- (void)setNavBackGroundColor:(UIColor *)navBackGroundColor {
    _navBackGroundColor         = navBackGroundColor;
    self.navBar.backgroundColor = _navBackGroundColor;
}
- (void)setIsShowNavLine:(BOOL)isShowNavLine {
    _isShowNavLine         = isShowNavLine;
    self.navBar.isShowLine = _isShowNavLine;
}
- (void)setNavBackGroundImageNamed:(NSString *)navBackGroundImageNamed {
    _navBackGroundImageNamed    = navBackGroundImageNamed;
    self.navBar.backgroundImage = [UIImage imageNamed:_navBackGroundImageNamed];
}
- (void)setItemsSpace:(CGFloat)itemsSpace {
    _itemsSpace       = itemsSpace;
    self.navBar.space = _itemsSpace;
}
- (void)setLeftBarButtonItemTitleFont:(CGFloat)leftBarButtonItemTitleFont {
    _leftBarButtonItemTitleFont            = leftBarButtonItemTitleFont;
    self.navBar.leftBarButtonItemTitleFont = _leftBarButtonItemTitleFont;
}
- (void)setRightBarButtonItemTitleFont:(CGFloat)rightBarButtonItemTitleFont {
    _rightBarButtonItemTitleFont            = rightBarButtonItemTitleFont;
    self.navBar.rightBarButtonItemTitleFont = _rightBarButtonItemTitleFont;
}
#pragma mark ======= public methods
#pragma mark--------- left
- (void)wya_addLeftNavBarButtonWithNormalTitle:(NSArray<NSString *> *)normalTitles {
    [self.navBar wya_addLeftNavBarButtonWithNormalTitle:normalTitles];
}
- (void)wya_addLeftNavBarButtonWithNormalImage:(NSArray<NSString *> *)normalImages
                                highlightedImg:(NSArray<NSString *> *)highlightedImgs {
    [self.navBar wya_addLeftNavBarButtonWithNormalImage:normalImages
                                         highlightedImg:highlightedImgs];
}
- (void)wya_addLeftNavBarButtonWithNormalTitle:(NSArray<NSString *> *)normalTitles
                                   normalColor:(NSArray<UIColor *> *)normalColors
                              highlightedColor:(NSArray<UIColor *> *)highlightedColors {
    [self.navBar wya_addLeftNavBarButtonWithNormalTitle:normalTitles
                                            normalColor:normalColors
                                       highlightedColor:highlightedColors];
}
#pragma mark-------- right
- (void)wya_addRightNavBarButtonWithNormalTitle:(NSArray<NSString *> *)normalTitles {
    [self.navBar wya_addRightNavBarButtonWithNormalTitle:normalTitles];
}
- (void)wya_addRightNavBarButtonWithNormalImage:(NSArray<NSString *> *)normalImages
                                 highlightedImg:(NSArray<NSString *> *)highlightedImgs {
    [self.navBar wya_addRightNavBarButtonWithNormalImage:normalImages
                                          highlightedImg:highlightedImgs];
}
- (void)wya_addRightNavBarButtonWithNormalTitle:(NSArray<NSString *> *)normalTitles
                                    normalColor:(NSArray<UIColor *> *)normalColors
                               highlightedColor:(NSArray<UIColor *> *)highlightedColors {
    [self.navBar wya_addRightNavBarButtonWithNormalTitle:normalTitles
                                             normalColor:normalColors
                                        highlightedColor:highlightedColors];
}
#pragma mark ======= WYANavBarDelegate
- (void)wya_goBackPressed:(UIButton *)sender {
    [self wya_goBack];
}
- (void)wya_leftBarButtonItemPressed:(UIButton *)sender {
    [self wya_customLeftBarButtonItemPressed:sender];
}
- (void)wya_rightBarButtonItemPressed:(UIButton *)sender {
    [self wya_customrRightBarButtonItemPressed:sender];
}
#pragma mark ======= Event
- (void)wya_goBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)wya_customLeftBarButtonItemPressed:(UIButton *)sender {
    NSLog(@"%@", sender.titleLabel.text);
}
- (void)wya_customrRightBarButtonItemPressed:(UIButton *)sender {
    NSLog(@"%@", sender.titleLabel.text);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
