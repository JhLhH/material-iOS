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
#import "WYARefreshView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <YYImage/YYImage.h>

@interface WYAHomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) WYAAgentRingViewModel * viewModel;
@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, assign) BOOL isRefresh;       // 判断是否已经触发了刷新
@property (nonatomic, assign) CGFloat lastOffset_y; // 记录tableview最后偏移量
@property (nonatomic, assign) CGFloat lastAlpha;    // 记录tableview最后的透明度
@property (nonatomic, assign) CGFloat lastNoticeAlpha;
@property (nonatomic, strong) WYAAgentRingCoverView * agentRingCoverView;
@property (nonatomic, strong) UITableView * agentRingTableView;
@property (nonatomic, strong) WYANoticeBar * noticeBar;
@property (nonatomic, strong) YYAnimatedImageView * gifAnimatedImageView;
@property (nonatomic, strong) WYARefreshView * refreshView;
@property (nonatomic, strong) WYAAgentRingCommentsView * commentsView;

@end

@implementation WYAHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self getNetWorkDataSource];
    [self addNotice];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self.agentRingTableView forKeyPath:@"contentOffset"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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

    self.navTitle = @"首页";
    [self.navBar wya_addRightNavBarButtonWithNormalTitle:@[ @"发布" ] normalColor:@[ [UIColor wya_whiteColor] ] highlightedColor:@[ [UIColor wya_whiteColor] ]];
    self.rightBarButtonItemTitleFont = 15 * SizeAdapter;
    self.navBackGroundColor             = [[UIColor wya_blackColor] colorWithAlphaComponent:0.5f];
    self.agentRingTableView.tableHeaderView = self.agentRingCoverView;
    [self.view addSubview:self.agentRingTableView];
    [self.view addSubview:self.refreshView];
    [self.view addSubview:self.noticeBar];
    [self.view addSubview:self.commentsView];
}

- (void)getNetWorkDataSource {
    self.dataSource = [self.viewModel testSource];
    [self.agentRingTableView reloadData];
}

- (void)wya_customrRightBarButtonItemPressed:(UIButton *)sender {
    WYASendDynamicViewController * sendDynamic = [[WYASendDynamicViewController alloc] init];
    sendDynamic.hidesBottomBarWhenPushed       = YES;
    [self.navigationController pushViewController:sendDynamic animated:YES];
}

- (void)addNotice{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBorardWillHidden) name:UIKeyboardWillHideNotification object:nil];
}

- (void)addAgentRingRefresh {
    NSLog(@"调用一次");
    self.refreshView.hidden = NO;
    [self.refreshView.animationImageView wya_setRotationAnimation:360 time:0.7 repeatCount:0];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGFloat object_x             = 32 * SizeAdapter;
        CGFloat object_y             = self.noticeBar.cmam_bottom + 20 * SizeAdapter;
        CGFloat object_width         = 32 * SizeAdapter;
        CGFloat object_height        = 32 * SizeAdapter;
        CGRect object_rect           = CGRectMake(object_x, object_y, object_width, object_height);
        self.refreshView.frame = object_rect;
        self.refreshView.alpha = 1;
    } completion:^(BOOL finished) {

    }];

    [UIView animateWithDuration:0.5 delay:1 usingSpringWithDamping:0.9 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGFloat object_x             = 32 * SizeAdapter;
        CGFloat object_y             = WYAStatusBarHeight;
        CGFloat object_width         = 32 * SizeAdapter;
        CGFloat object_height        = 32 * SizeAdapter;
        CGRect object_rect           = CGRectMake(object_x, object_y, object_width, object_height);
        self.refreshView.frame = object_rect;
        self.refreshView.alpha = 0;
        self.isRefresh = NO;
    } completion:^(BOOL finished) {
        [self.refreshView.animationImageView wya_removeRotationAnimation];
    }];
}

- (void)keyBorardWillHidden{
    self.commentsView.hidden = YES;
}

- (void)setupNavBarBackgroundAndNoticeBarWithY:(CGFloat)point_y{
    if (point_y > 0) {
        if (self.lastOffset_y) {
            if (point_y > self.lastOffset_y) {
                // 回弹
                CGFloat ccc = (point_y - self.lastOffset_y) / 182 * SizeAdapter;

                if (self.lastAlpha) {
                    self.lastAlpha = self.lastAlpha + ccc;
                } else {
                    self.lastAlpha = 0.5 + ccc;
                }
                self.navBar.backgroundColor = [[UIColor wya_blackColor] colorWithAlphaComponent:self.lastAlpha > 1 ? 1 : self.lastAlpha];
            } else {
                // 下拉
                CGFloat ppp = (self.lastOffset_y - point_y) / 182 * SizeAdapter;

                if (self.lastAlpha) {
                    self.lastAlpha = self.lastAlpha - ppp;
                }

                self.navBar.backgroundColor = [[UIColor wya_blackColor] colorWithAlphaComponent:self.lastAlpha < 0.5 ? 0.5 : self.lastAlpha];
            }

            if (point_y > self.lastOffset_y) {
                CGFloat ccc = (point_y - self.lastOffset_y) / 182 * SizeAdapter;
                //            NSLog(@"ccc==%f", ccc);
                //            NSLog(@"lastNoticeAlpha==%f", self.lastNoticeAlpha);
                if (self.lastNoticeAlpha) {
                    self.lastNoticeAlpha = self.lastNoticeAlpha - ccc;
                } else {
                    self.lastNoticeAlpha = 1 - ccc;
                }
                self.noticeBar.alpha = self.lastNoticeAlpha;
            } else if (point_y < self.lastOffset_y) {

                CGFloat ppp = (self.lastOffset_y - point_y) / 182 * SizeAdapter;
                //            NSLog(@"ppp==%f", ppp);
                if (self.lastNoticeAlpha) {
                    self.lastNoticeAlpha = self.lastNoticeAlpha + ppp;
                }
                self.noticeBar.alpha = self.lastNoticeAlpha;
            }
        }
        self.lastOffset_y = point_y;
    }
}

- (void)showImageBrowserWithModel:(WYAAgentRingModel *)model views:(NSArray *)views index:(NSInteger)index {
    [WYAImageBrowser showImageBrowserWithCurrentImageIndex:index imageCount:model.urls.count datasource:nil placeHoldImageBlock:^UIImage *(WYAImageBrowser *browser, NSInteger index) {
        return [UIImage imageNamed:@"1"];
    } HighQualityImageURLBlock:nil AssetBlock:nil SourceImageViewBlock:^UIImageView *(WYAImageBrowser *browser, NSInteger index) {
        return views[index];
    }];
}

/**
 评论点击事件
 */
- (void)agentRingCommentEdit {
    self.commentsView.hidden = NO;
    [self.commentsView.textView becomeFirstResponder];
}

/**
 转发事件
 */
- (void)forwardClick{

}

/**
 收藏事件
 */
- (void)collectionClick{

}

/**
 点赞事件
 */
- (void)praiseClick{

}

#pragma mark ======= KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {

        NSValue * newvalue = change[NSKeyValueChangeNewKey];
        CGFloat point_y    = newvalue.UIOffsetValue.vertical;

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

        [self setupNavBarBackgroundAndNoticeBarWithY:point_y];

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
        [weakSelf forwardClick];
    };
    cell.collectionBlock = ^(WYAAgentRingModel * _Nonnull model) {
        [weakSelf collectionClick];
    };
    cell.commentsBlock = ^(WYAAgentRingModel * _Nonnull model) {
        [weakSelf agentRingCommentEdit];
    };
    cell.praiseBlock = ^(WYAAgentRingModel * _Nonnull model) {
        [weakSelf praiseClick];
    };
    cell.imageBlock = ^(WYAAgentRingModel * _Nonnull model, NSArray * _Nonnull views, NSInteger index) {
        [self showImageBrowserWithModel:model views:views index:index];
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
    WYAAgentRingModel * model = self.dataSource[section];
    if (model.comments.count > 0) {
        return [WYAAgentRingSectionFootView getFootHeightWithModel:self.dataSource[section]];
    } else {
        return 1 * SizeAdapter;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    WYAAgentRingModel * model = self.dataSource[section];
    if (model.comments.count > 0) {
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
    } else {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1 * SizeAdapter)];
        view.backgroundColor = [UIColor wya_lineColor];
        return view;
    }
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
            object.backgroundColor              = [UIColor wya_textBlackColor];
            object.separatorStyle               = UITableViewCellSeparatorStyleNone;
            [object registerClass:[WYAAgentRingCell class] forCellReuseIdentifier:@"cell"];
            [object registerClass:[WYAAgentRingSectionFootView class] forHeaderFooterViewReuseIdentifier:@"foot"];
            [object addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
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
            CGFloat object_height = 255 * SizeAdapter;
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
            object.showTextFont          = 12;
            object.showTextColor         = [UIColor wya_whiteColor];
            object.noticeBackgroundColor = [[UIColor wya_blackColor] colorWithAlphaComponent:0.5];
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
            object.sendCommentsBlock = ^(NSString * _Nonnull text) {
                self.commentsView = nil;
            };
            object;
        });
    }
    return _commentsView;
}

- (WYARefreshView *)refreshView{
    if(!_refreshView){
        _refreshView = ({
            CGFloat object_x             = 32 * SizeAdapter;
            CGFloat object_y             = WYAStatusBarHeight;
            CGFloat object_width         = 32 * SizeAdapter;
            CGFloat object_height        = 32 * SizeAdapter;
            CGRect object_rect           = CGRectMake(object_x, object_y, object_width, object_height);
            WYARefreshView * object = [[WYARefreshView alloc]init];
            object.frame = object_rect;
            object.hidden = YES;
            object.alpha = 0;
            object;
       });
    }
    return _refreshView;
}
@end
