//
//  WYALabelScreeningView.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/15.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYALabelScreeningView.h"

#import "WYAContentView.h"

@interface WYALabelScreeningView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UITapGestureRecognizer * recongizer;
@property (nonatomic, strong) WYAContentView * contentView;
@property (nonatomic, assign) CGFloat contentViewHeight;
@end

@implementation WYALabelScreeningView
#pragma mark ======= LifeCircle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(0, WYATopHeight, ScreenWidth, ScreenHeight - WYATopHeight)]) {
        self.backgroundColor = [[UIColor wya_blackColor] colorWithAlphaComponent:0.7f];
        [self addSubview:self.contentView];
        [self addGestureRecognizer:self.recongizer];
    }
    return self;
}
#pragma mark ======= Public Method
- (void)showScreenView {
    self.screenViewIsShow = YES;
    self.hidden           = !self.screenViewIsShow;
    [Window addSubview:self];
}
- (void)hidenScreenView {
    self.screenViewIsShow = NO;
    self.hidden           = !self.screenViewIsShow;
}

#pragma mark ======= Lazy

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = ({
            UIView * object = [[UIView alloc] init];
            object;
        });
    }
    return _bgView;
}

- (UITapGestureRecognizer *)recongizer {
    if (!_recongizer) {
        _recongizer = ({
            UITapGestureRecognizer * object = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenScreenView:)];
            object.delegate                 = self;
            object;
        });
    }
    return _recongizer;
}
- (WYAContentView *)contentView {
    if (!_contentView) {
        _contentView = ({
            self.contentViewHeight   = 130*SizeAdapter + (self.dataSources.count / 3) * 40*SizeAdapter;
            if (self.contentViewHeight > 420*SizeAdapter) {
                self.contentViewHeight = 420*SizeAdapter;
            }
            WYAContentView * object  = [[WYAContentView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.contentViewHeight)];
            object.contentArray      = self.dataSources;
            object.resetButtonAction = ^{
                if (self.resetBlock) {
                    self.resetBlock();
                    [self hidenScreenView];
                }
            };
            object.sureButtonAction = ^(NSArray * _Nonnull selectedBtnArray) {
                if (self.sureBlock) {
                    NSMutableArray * selectedLabelArray = [NSMutableArray array];
                    for (UIButton * btn in selectedBtnArray) {
                        [selectedLabelArray wya_safeAddObject:btn.titleLabel.text];
                    }
                    self.sureBlock(selectedLabelArray);
                    [self hidenScreenView];
                }
            };
            object;
        });
    }
    return _contentView;
}
- (NSArray *)dataSources {
    if (!_dataSources) {
        _dataSources = ({
            NSArray * object = @[ @"测试", @"演讲速成手啊啊", @"高效率思维", @"提高效率", @"哈哈哈" ];

            object;
        });
    }
    return _dataSources;
}
#pragma mark ======= UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch {
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
}

#pragma mark ======= Event

- (void)hiddenScreenView:(UIGestureRecognizer *)recognizer {
    self.screenViewIsShow = NO;
    self.hidden           = !self.screenViewIsShow;
}

@end
