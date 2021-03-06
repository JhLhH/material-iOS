//
//  WYAContentView.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/15.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAContentView.h"

#define BASETAG 1000
#define LEFT 17 * SizeAdapter
#define TOP 21 * SizeAdapter

@interface WYAContentView ()

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIScrollView * bgScrollView; //承载按钮的View
@property (nonatomic, strong) UIButton * resetButton;
@property (nonatomic, strong) UIButton * sureButton;
//@property (nonatomic, assign) NSInteger selectedTag; // 被选中的按钮的tag
@property (nonatomic, assign) CGFloat btnBgViewHeight;
@property (nonatomic, strong) NSMutableArray * selectedTitleArray;
@end

@implementation WYAContentView

#pragma mark ======= LifeCircle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.resetButton];
        [self addSubview:self.sureButton];
        [self addSubview:self.bgScrollView];
        self.btnBgViewHeight = 100;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.mas_left).offset(LEFT);
        make.top.equalTo(self.mas_top).offset(TOP);
        make.size.mas_equalTo(CGSizeMake(70 * SizeAdapter, 16 * SizeAdapter));
    }];

    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20 * SizeAdapter);
        make.height.mas_equalTo(self.btnBgViewHeight > 300*SizeAdapter ? 300*SizeAdapter : self.btnBgViewHeight);
    }];

    [self.resetButton mas_makeConstraints:^(MASConstraintMaker * make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.5, 44));
    }];

    [self.sureButton mas_makeConstraints:^(MASConstraintMaker * make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.5, 44));
    }];
    self.bgScrollView.contentSize = CGSizeMake(0, self.btnBgViewHeight);
}

#pragma mark ======= Setter
- (void)setContentArray:(NSArray *)contentArray {
    if (contentArray) {
        _contentArray = contentArray;
        CGFloat w     = 0; //保存前一个button的宽以及前一个button距离屏幕边缘的距离
        CGFloat h     = 0; //用来控制button距离父视图的高
        for (int i = 0; i < _contentArray.count; i++) {
            NSString * title  = [_contentArray wya_safeObjectAtIndex:i];
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag        = BASETAG + i;
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor wya_textBlackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor wya_whiteColor] forState:UIControlStateSelected];
            [button wya_setBackgroundColor:[UIColor wya_textBlackColor] forState:UIControlStateSelected];
            [button wya_setBackgroundColor:[UIColor wya_bgColor] forState:UIControlStateNormal];

            button.backgroundColor          = [UIColor wya_bgColor];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.font          = FONT(14);
            button.layer.cornerRadius       = 14*SizeAdapter;
            button.layer.masksToBounds      = YES;
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            //根据计算文字的大小
            NSDictionary * attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14 * SizeAdapter]};
            CGFloat length            = [_contentArray[i] boundingRectWithSize:CGSizeMake(ScreenWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width + 15*SizeAdapter;
            //设置button的frame
            button.frame = CGRectMake(10 * SizeAdapter + w, h, length + 15*SizeAdapter, 27*SizeAdapter);
            //当button的位置超出屏幕边缘时换行 ScreenWidth 只是button所在父视图的宽度
            if (10*SizeAdapter + w + length + 15*SizeAdapter > ScreenWidth) {
                w            = 0;                                      //换行时将w置为0
                h            = h + button.frame.size.height + 10*SizeAdapter;      //距离父视图也变化
                button.frame = CGRectMake(10*SizeAdapter + w, h, length + 15*SizeAdapter, 27*SizeAdapter); //重设button的frame
            }
            w = button.frame.size.width + button.frame.origin.x;
            if (i == _contentArray.count - 1) {
                self.btnBgViewHeight = CGRectGetMaxY(button.frame);
            }
            if (self.btnBgViewHeight > 300*SizeAdapter) {
                self.bgScrollView.scrollEnabled = YES;
            }
            [self.bgScrollView addSubview:button];
        }
        [self layoutIfNeeded];
    }
}

#pragma mark ======= Public Method
- (void)resetContentViewItem {
    for (UIButton * btn in self.selectedTitleArray) {
        btn.selected = NO;
    }
    [self.selectedTitleArray removeAllObjects];
}
#pragma mark ======= Event

- (void)buttonClicked:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (sender.isSelected && ![self.selectedTitleArray containsObject:sender]) {
        [self.selectedTitleArray wya_safeAddObject:sender];
    } else if (!sender.isSelected && [self.selectedTitleArray containsObject:sender]) {
        [self.selectedTitleArray removeObject:sender];
    }
}

- (void)resetButtonClicked:(UIButton *)sender {

    [self resetContentViewItem];
}
- (void)sureButtonClicked:(UIButton *)sender {

    if (self.sureButtonAction) {
        self.sureButtonAction([self.selectedTitleArray copy]);
    }
}
#pragma mark ======= Lazy

- (UIScrollView *)bgScrollView{
    if(!_bgScrollView){
        _bgScrollView = ({
            UIScrollView * object = [[UIScrollView alloc]init];
            object.scrollEnabled = NO;
            object;
        });
    }
    return _bgScrollView;
}

- (NSMutableArray *)selectedTitleArray {
    if (!_selectedTitleArray) {
        _selectedTitleArray = ({
            NSMutableArray * object = [[NSMutableArray alloc] init];
            object;
        });
    }
    return _selectedTitleArray;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel * object = [[UILabel alloc] init];
            object.font      = FONTS(16);
            object.text      = @"标签分类";
            object.textColor = [UIColor wya_textBlackColor];
            object;
        });
    }
    return _titleLabel;
}

- (UIButton *)resetButton {
    if (!_resetButton) {
        _resetButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"重置" forState:UIControlStateNormal];
            object.backgroundColor = [UIColor wya_textWhitColorl];
            object.titleLabel.font = FONT(16);
            object.layer.borderColor = [UIColor wya_lineColor].CGColor;
            object.layer.borderWidth = 0.5;
            [object setTitleColor:[UIColor wya_blackColor] forState:UIControlStateNormal];
            [object addTarget:self action:@selector(resetButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            object;
        });
    }
    return _resetButton;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"确定" forState:UIControlStateNormal];
            object.backgroundColor = [UIColor wya_goldenColor];
            object.titleLabel.font = FONT(16);
            object.layer.borderColor = [UIColor wya_lineColor].CGColor;
            object.layer.borderWidth = 0.5;
            [object setTitleColor:[UIColor wya_textWhitColorl] forState:UIControlStateNormal];
            [object addTarget:self action:@selector(sureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            object;
        });
    }
    return _sureButton;
}
@end
