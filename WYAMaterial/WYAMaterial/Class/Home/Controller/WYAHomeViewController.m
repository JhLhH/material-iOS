//
//  WYAHomePageViewController.m
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/6.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAHomeViewController.h"
#import "WYASendDynamicViewController.h"

#import "WYAAgentRingModel.h"
#import "WYAAgentRingViewModel.h"

#import "WYAAgentRingCell.h"
#import "WYAAgentRingCommentsView.h"
#import "WYAAgentRingCoverView.h"
#import "WYAAgentRingSectionFootView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <YYImage/YYImage.h>

@interface WYAHomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) WYAAgentRingViewModel * viewModel;
@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, assign) BOOL isRefresh;       // 判断是否已经触发了刷新
@property (nonatomic, assign) CGFloat lastOffset_y; // 记录tableview最后偏移量
@property (nonatomic, assign) CGFloat lastAlpha;    // 记录tableview最后的透明度

@property (nonatomic, strong) WYAAgentRingCoverView * agentRingCoverView;
@property (nonatomic, strong) UITableView * agentRingTableView;
@property (nonatomic, strong) UIButton * sendDynamicButton; // 发动态按钮
@property (nonatomic, strong) WYANoticeBar * noticeBar;
@property (nonatomic, strong) YYAnimatedImageView * gifAnimatedImageView;
@property (nonatomic, strong) WYAAgentRingCommentsView * commentsView;

@end

@implementation WYAHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"首页";
    [self setupUI];
    [self getNetWorkDataSource];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self.agentRingTableView forKeyPath:@"contentOffset"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark ======= Private Method
- (void)setupUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navBar wya_addRightNavBarButtonWithNormalTitle:@[ @"发布" ] normalColor:@[ [UIColor whiteColor] ] highlightedColor:@[ [UIColor whiteColor] ]];
    self.navBar.backgroundColor             = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    self.agentRingTableView.tableHeaderView = self.agentRingCoverView;
    self.navTitleColor                      = [UIColor whiteColor];
    [self.view addSubview:self.agentRingTableView];
    [self.view addSubview:self.noticeBar];
    [self.view addSubview:self.sendDynamicButton];
    [self.view addSubview:self.gifAnimatedImageView];
    [self.view addSubview:self.commentsView];
}

- (void)getNetWorkDataSource {
    self.dataSource = [self.viewModel testSource];
    [self.agentRingTableView reloadData];
}

- (void)wya_customrRightBarButtonItemPressed:(UIButton *)sender {
}

- (void)addAgentRingRefresh {
    NSLog(@"调用一次");
    self.gifAnimatedImageView.hidden = NO;
}

- (void)showImageBrowserWithModel:(WYAAgentRingModel *)model index:(NSInteger)index {
    NSMutableArray * array = [NSMutableArray array];
    for (NSInteger i = 0; i < model.urls.count; i++) {
        [array addObject:[UIImage imageNamed:@"1"]];
    }
    WYAImageBrowser * imageBrowser      = [[WYAImageBrowser alloc] init];
    imageBrowser.frame                  = Window.bounds;
    imageBrowser.images                 = [array copy];
    imageBrowser.selectIndex            = index;
    imageBrowser.pageControlNormalColor = [UIColor wya_hex:@"#FFFFFF"];
    imageBrowser.pageControlSelectColor = [UIColor wya_hex:@"#E7C083"];
    __block WYAImageBrowser * imageB    = imageBrowser;
    imageBrowser.imageSelectBlock       = ^(NSInteger index) {
        [imageB removeFromSuperview];
    };
    [Window addSubview:imageBrowser];
}

- (void)agentRingCommentEdit {
    self.commentsView.hidden = NO;
    [self.commentsView.textView becomeFirstResponder];
}

#pragma mark ======= KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {

        NSValue * newvalue = change[NSKeyValueChangeNewKey];
        CGFloat point_y    = newvalue.UIOffsetValue.vertical;
        NSLog(@"New:%f", point_y);

        if (point_y < -100) {
            if (self.isRefresh == NO) {
                [self addAgentRingRefresh];
                self.isRefresh = YES;
            }
        } else if (point_y == 0) {
            if (self.isRefresh == YES) {
                self.isRefresh = NO;
            }
        }

        if (point_y > 0) {
            if (self.lastOffset_y) {
                if (point_y > self.lastOffset_y) {
                    // 回弹
                    CGFloat ccc = (point_y - self.lastOffset_y) / 100;
                    NSLog(@"ccc==%f", ccc);
                    NSLog(@"lastAlp==%f", self.lastAlpha);
                    if (self.lastAlpha) {
                        self.lastAlpha = self.lastAlpha + ccc;
                    } else {
                        self.lastAlpha = 0.5 + ccc;
                    }
                    self.navBar.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:self.lastAlpha > 1 ? 1 : self.lastAlpha];
                } else {
                    // 下拉
                    CGFloat ppp = (self.lastOffset_y - point_y) / 100;
                    NSLog(@"ppp==%f", ppp);
                    if (self.lastAlpha) {
                        self.lastAlpha = self.lastAlpha - ppp;
                    }

                    self.navBar.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:self.lastAlpha < 0.5 ? 0.5 : self.lastAlpha];
                }
            }
            self.lastOffset_y = point_y;
        }

    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark ======= UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeakSelf(weakSelf);
    WYAAgentRingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model              = self.dataSource[indexPath.section];
    cell.stretchBlock       = ^(WYAAgentRingModel * _Nonnull model) {
        [tableView beginUpdates];
        [tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
        [tableView endUpdates];
    };
    cell.forwardingBlock = ^(WYAAgentRingModel * _Nonnull model) {

    };
    cell.collectionBlock = ^(WYAAgentRingModel * _Nonnull model) {

    };
    cell.commentsBlock = ^(WYAAgentRingModel * _Nonnull model) {
        [weakSelf agentRingCommentEdit];
    };
    cell.praiseBlock = ^(WYAAgentRingModel * _Nonnull model) {

    };
    cell.imageBlock = ^(WYAAgentRingModel * _Nonnull model, NSInteger index) {
        [weakSelf showImageBrowserWithModel:model index:index];
    };
    return cell;
}

#pragma mark ======= UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [WYAAgentRingCell getCellHeightWithModel:self.dataSource[indexPath.section]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [WYAAgentRingSectionFootView getFootHeightWithModel:self.dataSource[section]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    WYAAgentRingSectionFootView * footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"foot"];
    footView.model                         = self.dataSource[section];
    footView.stretchBlock                  = ^(WYAAgentRingModel * _Nonnull model) {
        NSLog(@"model.show==%d", model.show);
        [tableView beginUpdates];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        [tableView endUpdates];
    };
    footView.singleCommentsBlock = ^(WYAAgentRingModel * _Nonnull model) {
        [tableView beginUpdates];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        [tableView endUpdates];
    };
    return footView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark ======= Getter
- (UITableView *)agentRingTableView {
    if (!_agentRingTableView) {
        _agentRingTableView = ({
            CGFloat object_x      = 0;
            CGFloat object_y      = 0;
            CGFloat object_width  = ScreenWidth;
            CGFloat object_height = ScreenHeight - WYATabBarHeight;
            CGRect object_rect    = CGRectMake(object_x, object_y, object_width, object_height);

            UITableView * object                = [[UITableView alloc] initWithFrame:object_rect style:UITableViewStyleGrouped];
            object.delegate                     = self;
            object.dataSource                   = self;
            object.estimatedRowHeight           = 0;
            object.estimatedSectionFooterHeight = 0;
            object.estimatedSectionHeaderHeight = 0;
            object.backgroundColor              = [UIColor whiteColor];
            object.separatorStyle               = UITableViewCellSeparatorStyleNone;
            [object registerClass:[WYAAgentRingCell class] forCellReuseIdentifier:@"cell"];
            [object registerClass:[WYAAgentRingSectionFootView class] forHeaderFooterViewReuseIdentifier:@"foot"];
            [object addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            //            UIRefreshControl * refreshControl = [[UIRefreshControl alloc]init];
            //            [refreshControl addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventValueChanged];
            //            object.refreshControl = refreshControl;
            object;
        });
    }
    return _agentRingTableView;
}

- (WYAAgentRingCoverView *)agentRingCoverView {
    if (!_agentRingCoverView) {
        _agentRingCoverView = ({

            CGFloat object_x      = 0;
            CGFloat object_y      = 0;
            CGFloat object_width  = self.agentRingTableView.cmam_width;
            CGFloat object_height = 248 * SizeAdapter;
            CGRect object_rect    = CGRectMake(object_x, object_y, object_width, object_height);

            WYAAgentRingCoverView * object = [[WYAAgentRingCoverView alloc] init];
            object.frame                   = object_rect;
            object;
        });
    }
    return _agentRingCoverView;
}

- (WYAAgentRingViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = ({
            WYAAgentRingViewModel * object = [[WYAAgentRingViewModel alloc] init];
            object;
        });
    }
    return _viewModel;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = ({
            NSArray * object = [[NSArray alloc] init];
            object;
        });
    }
    return _dataSource;
}

- (UIButton *)sendDynamicButton {
    if (!_sendDynamicButton) {
        _sendDynamicButton = ({
            CGFloat object_x      = self.view.cmam_width - 76 * SizeAdapter;
            CGFloat object_y      = self.view.cmam_height - WYATabBarHeight - 76 * SizeAdapter;
            CGFloat object_width  = 60 * SizeAdapter;
            CGFloat object_height = 60 * SizeAdapter;
            CGRect object_rect    = CGRectMake(object_x, object_y, object_width, object_height);

            UIButton * object = [[UIButton alloc] initWithFrame:object_rect];
            [object setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
            object.layer.cornerRadius  = object_width / 2;
            object.layer.masksToBounds = YES;
            [object addCallBackAction:^(UIButton * button) {
                WYASendDynamicViewController * sendDynamic = [[WYASendDynamicViewController alloc] init];
                sendDynamic.hidesBottomBarWhenPushed       = YES;
                [self.navigationController pushViewController:sendDynamic animated:YES];
            }];
            object;
        });
    }
    return _sendDynamicButton;
}

- (WYANoticeBar *)noticeBar {
    if (!_noticeBar) {
        _noticeBar = ({

            CGFloat object_x      = 0;
            CGFloat object_y      = WYATopHeight;
            CGFloat object_width  = ScreenWidth;
            CGFloat object_height = 30 * SizeAdapter;
            CGRect object_rect    = CGRectMake(object_x, object_y, object_width, object_height);

            WYANoticeBar * object = [[WYANoticeBar alloc]
                initWithFrame:object_rect];
            object.showNoticeButton      = YES;
            object.noticeButtonImage     = [UIImage imageNamed:@"icon_notice"];
            object.showRightButton       = NO;
            object.showText              = @"待修改通知栏文字";
            object.showTextColor         = [UIColor wya_whiteColor];
            object.noticeBackgroundColor = random(12, 12, 10, 0.5);
            object;
        });
    }
    return _noticeBar;
}

- (YYAnimatedImageView *)gifAnimatedImageView {
    if (!_gifAnimatedImageView) {
        _gifAnimatedImageView = ({
            CGFloat object_x             = 50;
            CGFloat object_y             = self.noticeBar.cmam_bottom + 20 * SizeAdapter;
            CGFloat object_width         = 60 * SizeAdapter;
            CGFloat object_height        = 60 * SizeAdapter;
            CGRect object_rect           = CGRectMake(object_x, object_y, object_width, object_height);
            UIImage * image              = [YYImage imageNamed:@"wya-applogo1"];
            YYAnimatedImageView * object = [[YYAnimatedImageView alloc] initWithImage:image];
            object.frame                 = object_rect;
            object.hidden                = YES;
            object;
        });
    }
    return _gifAnimatedImageView;
}

- (WYAAgentRingCommentsView *)commentsView {
    if (!_commentsView) {
        _commentsView = ({
            CGFloat object_x                  = 0;
            CGFloat object_y                  = ScreenHeight - WYATabBarHeight - 49 * SizeAdapter;
            CGFloat object_width              = ScreenWidth;
            CGFloat object_height             = 49 * SizeAdapter;
            CGRect object_rect                = CGRectMake(object_x, object_y, object_width, object_height);
            WYAAgentRingCommentsView * object = [[WYAAgentRingCommentsView alloc] init];
            object.frame                      = object_rect;
            object.backgroundColor            = [UIColor wya_whiteColor];
            object.hidden                     = YES;
            object.frameChangeBlock           = ^(WYAAgentRingCommentsView * _Nonnull view, CGFloat height) {
                CGFloat view_x      = view.cmam_left;
                CGFloat view_y      = ScreenHeight - WYATabBarHeight - height;
                CGFloat view_width  = view.cmam_width;
                CGFloat view_height = height;
                CGRect view_rect    = CGRectMake(view_x, view_y, view_width, view_height);
                view.frame          = view_rect;
            };

            object;
        });
    }
    return _commentsView;
}
@end
