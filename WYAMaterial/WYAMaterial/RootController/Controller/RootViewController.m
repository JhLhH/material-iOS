//
//  RootViewController.m
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/3.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "RootViewController.h"
#import "WYAArticleViewController.h"
#import "WYAHomeViewController.h"
#import "WYAImgTextViewController.h"
#import "WYAMaterialViewController.h"
#import "WYAMineViewController.h"

@interface RootViewController ()
/**
 存放初始化tabBar的数据模型
 */

@property (nonnull, nonatomic, strong) NSArray<RootControllerModel *> * tabBarModelArray;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabBarModelArray];
    self.tabBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark =========== createModel
- (void)createTabBarModelArray {
    NSMutableArray * array           = [NSMutableArray array];
    RootControllerModel * item1Model = [RootControllerModel modelWithTitle:@"首页"
                                                                 className:@"WYAHomeViewController"
                                                           normalImageName:@"home_normal"
                                                         selectedImageName:@"home_selected"];
    RootControllerModel * item2Model = [RootControllerModel modelWithTitle:@"素材库"
                                                                 className:@"WYAMaterialViewController"
                                                           normalImageName:@"More_normal"
                                                         selectedImageName:@"More_selected"];

    RootControllerModel * item3Model = [RootControllerModel modelWithTitle:@"我的"
                                                                 className:@"WYAMineViewController"
                                                           normalImageName:@"More_normal"
                                                         selectedImageName:@"More_selected"];
    [array addObject:item1Model];
    [array addObject:item2Model];
    [array addObject:item3Model];
    _tabBarModelArray = [array copy];
    [self creatViewControllers];
}

#pragma mark - UI -
- (void)creatViewControllers {
    NSMutableArray * viewControllers = [NSMutableArray array];
    for (RootControllerModel * model in _tabBarModelArray) {

        NSString * className = model.className;
        UIViewController * viewController;
        if ([model.className isEqualToString:@"WYAMaterialViewController"]) {
            WYAMaterialViewController * vc = [[WYAMaterialViewController alloc] init];
            vc.selectIndex                 = 0;
            vc.menuViewStyle               = WYAMenuViewStyleLine;
            vc.titleColorSelected          = WYA_RGB_COLOR(226, 193, 139);
            vc.titleColorNormal            = [UIColor whiteColor];
            vc.progressColor               = WYA_RGB_COLOR(226, 193, 139);
            vc.progressViewBottomSpace     = 5;
            vc.progressWidth               = 25;
            vc.progressHeight              = 3;
            vc.progressViewCornerRadius    = 1.5;
            viewController                 = vc;
        } else {
            viewController = [[NSClassFromString(className) alloc] init];
        }
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        nav.tabBarItem.title         = model.tabBarTitle;
        nav.tabBarItem.image         = [model normalImage];
        nav.tabBarItem.selectedImage = [model selectedImage];
        CGFloat fontSize             = self.tabBarTitleFont == 0 ? 14 : self.tabBarTitleFont;
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : self.normalTitleColor == nil ? WYA_RGB_COLOR(102, 102, 102) : self.normalTitleColor,
                                                             NSFontAttributeName : FONT(fontSize) }
                                                 forState:UIControlStateNormal];

        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.selectedTitleColor == nil ? WYA_RGB_COLOR(77, 154, 247) : self.selectedTitleColor, NSForegroundColorAttributeName, nil] forState:(UIControlStateSelected)];
        [viewControllers addObject:nav];
    }
    self.viewControllers = viewControllers;
#pragma mark ======= 调整文字和图片的间距
    for (UITabBarItem * i in self.tabBar.items) {
        i.titlePositionAdjustment = UIOffsetMake(0, 2);
        i.imageInsets             = UIEdgeInsetsMake(-1, 0, 1, 0);
    }
}

- (void)setTabBarTitleFont:(CGFloat)tabBarTitleFont {
    _tabBarTitleFont = tabBarTitleFont;
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : self.normalTitleColor == nil ? [UIColor grayColor] : self.normalTitleColor,
                                                         NSFontAttributeName : FONT(tabBarTitleFont) }
                                             forState:UIControlStateNormal];
}
- (void)setNormalTitleColor:(UIColor *)normalTitleColor {
    _normalTitleColor = normalTitleColor;
    CGFloat fontSize  = self.tabBarTitleFont == 0 ? 14 : self.tabBarTitleFont;
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : _normalTitleColor,
                                                         NSFontAttributeName : FONT(fontSize) }
                                             forState:UIControlStateNormal];
}
- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_selectedTitleColor, NSForegroundColorAttributeName, nil] forState:(UIControlStateSelected)];
}
@end
