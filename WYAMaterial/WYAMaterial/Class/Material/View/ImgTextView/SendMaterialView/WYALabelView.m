//
//  WYALabelView.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/22.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYALabelView.h"
#define BASETAG 1000
#define LEFT 17 * SizeAdapter
#define TOP 21 * SizeAdapter
@interface WYALabelView ()
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, assign) NSInteger selectedTag; // 被选中的按钮的tag
@property (nonatomic, assign) CGFloat btnBgViewHeight;
@property (nonatomic, strong) NSMutableArray * selectedTitleArray;
@property (nonatomic, strong) UIView * btnBgView; //承载按钮的View
@property (nonatomic, strong) UIButton * selectedButton;
@end

@implementation WYALabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.btnBgView];
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

    [self.btnBgView mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20 * SizeAdapter);
        make.height.mas_equalTo(self.btnBgViewHeight);
    }];
}
#pragma mark ======= Lazy
- (UIView *)btnBgView {
    if (!_btnBgView) {
        _btnBgView = ({
            UIView * object = [[UIView alloc] init];
            object;
        });
    }
    return _btnBgView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel * object = [[UILabel alloc] init];
            object.font      = FONTS(16);
            object.text      = @"标签";
            object.textColor = [UIColor wya_textBlackColor];
            object;
        });
    }
    return _titleLabel;
}

#pragma mark ======= Setter
- (void)setLabelArray:(NSArray *)labelArray{
    if (labelArray) {
        _labelArray = labelArray;
        CGFloat w     = 0; //保存前一个button的宽以及前一个button距离屏幕边缘的距离
        CGFloat h     = 0; //用来控制button距离父视图的高
        for (int i = 0; i < _labelArray.count; i++) {
            NSString * title  = [_labelArray wya_safeObjectAtIndex:i];
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag        = BASETAG + i;
            if ([self.selectedLabelString isEqualToString:title]) {
                button.selected = YES;
            }
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
            CGFloat length            = [_labelArray[i] boundingRectWithSize:CGSizeMake(ScreenWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width + 15;
            //设置button的frame
            button.frame = CGRectMake(10 * SizeAdapter + w, h, length + 15, 27*SizeAdapter);
            //当button的位置超出屏幕边缘时换行 ScreenWidth 只是button所在父视图的宽度
            if (10 + w + length + 15 > ScreenWidth) {
                w            = 0;                                      //换行时将w置为0
                h            = h + button.frame.size.height + 10;      //距离父视图也变化
                button.frame = CGRectMake(10 + w, h, length + 15, 27*SizeAdapter); //重设button的frame
            }
            w = button.frame.size.width + button.frame.origin.x;
            if (i == _labelArray.count - 1) {
                self.btnBgViewHeight = CGRectGetMaxY(button.frame);
            }
            [self.btnBgView addSubview:button];
        }
        [self layoutIfNeeded];
    }
}

- (void)buttonClicked:(UIButton *)sender {

    NSArray *array = [self.btnBgView subviews];
    for(int i=0;i<array.count;i++)
    {
        id view = array[i];
        if([view isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton*)view;
            btn.selected = NO;
        }
    }
    sender.selected =YES;
    if (sender.selected) {
        if (self.SelecrtedLabelAction) {
            self.SelecrtedLabelAction(sender.titleLabel.text);
        }
    }
}


@end
