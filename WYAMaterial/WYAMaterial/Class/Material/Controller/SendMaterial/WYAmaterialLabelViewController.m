//
//  WYAmaterialLabelViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/22.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAmaterialLabelViewController.h"

#import "WYALabelView.h"

@interface WYAmaterialLabelViewController ()
@property (nonatomic, strong) UIScrollView * bgScrollView;
@property (nonatomic, strong) NSArray * datSource;
@property (nonatomic, assign) CGFloat contentViewHeight;
@property (nonatomic, strong) WYALabelView * contentView;
@property (nonatomic, copy) NSString * selectedString;
@end

@implementation WYAmaterialLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"关联标签";
   [self.navBar wya_addRightNavBarButtonWithNormalTitle:@[@"确定"] normalColor:@[[UIColor wya_textWhitColorl]] highlightedColor:@[[UIColor wya_textGrayColor]]];
    [self.bgScrollView addSubview:self.contentView];
    [self.view addSubview:self.bgScrollView];
}
- (void)wya_customrRightBarButtonItemPressed:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.SelectedLabelActionBlock) {
        self.SelectedLabelActionBlock(self.selectedString);
    }
}
- (void)wya_goBack{
    [super wya_goBack];
    if (self.SelectedLabelActionBlock) {
        self.SelectedLabelActionBlock(self.selectedString);
    }
}
#pragma mark ======= Lazy
- (UIScrollView *)bgScrollView{
    if(!_bgScrollView){
        _bgScrollView = ({
            UIScrollView * object = [[UIScrollView alloc]initWithFrame:CGRectMake(0, WYATopHeight, ScreenWidth, ScreenHeight)];
            object.contentSize = CGSizeMake(0, self.contentView.cmam_height);
            object;
       });
    }
    return _bgScrollView;
}

- (NSArray *)datSource{
    if(!_datSource){
        _datSource = ({
            NSArray * object = @[ @"测试", @"演讲速成手啊啊", @"高效率思维", @"提高效率",@"哈哈哈"];
            object;
       });
    }
    return _datSource;
}

- (WYALabelView *)contentView{
    if (!_contentView) {
        _contentView = ({
            self.contentViewHeight   = 114 + (self.datSource.count / 3) * 40;
            WYALabelView * object  = [[WYALabelView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.contentViewHeight)];
            if (self.selectedLabelString) {
                object.selectedLabelString = self.selectedLabelString;
            }
            object.labelArray      = self.datSource;
            object.SelecrtedLabelAction = ^(NSString * _Nonnull labelTitle) {
                self.selectedString = labelTitle;
            };
            object;
        });
    }
    return _contentView;
}
@end
