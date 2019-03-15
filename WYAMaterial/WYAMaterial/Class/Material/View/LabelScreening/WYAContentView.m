//
//  WYAContentView.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/15.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAContentView.h"

#define BASETAG 1000
#define LEFT 10
#define TOP 10
@interface WYAContentView()

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIView * btnBgView; //承载按钮的View
@property (nonatomic, strong) UIButton * resetButton;
@property (nonatomic, strong) UIButton * sureButton;
@property (nonatomic, assign) NSInteger selectedTag; // 被选中的按钮的tag
@property (nonatomic, assign) CGFloat btnBgViewHeight;
@end

@implementation WYAContentView

#pragma mark ======= LifeCircle

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.resetButton];
        [self addSubview:self.sureButton];
        [self addSubview:self.btnBgView];
        self.btnBgViewHeight = 100;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(LEFT);
        make.top.equalTo(self.mas_top).offset(TOP);
        make.size.mas_offset(CGSizeMake(ScreenWidth, 30));
    }];

    [self.btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_offset(self.btnBgViewHeight);
    }];

//    [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
//        make.left.mas_offset(self.mas_left);
//        make.size.mas_offset(CGSizeMake(ScreenWidth*0.5, 44));
//    }];
//
//    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
//        make.right.mas_offset(self.mas_right);
//        make.size.mas_offset(CGSizeMake(ScreenWidth*0.5, 44));
//    }];
}

- (void)setContentArray:(NSArray *)contentArray{
    if (contentArray) {
        _contentArray = contentArray;
        CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
        CGFloat h = 10;//用来控制button距离父视图的高
        for (int i = 0; i < _contentArray.count; i++) {
            NSString * title = [_contentArray wya_safeObjectAtIndex:i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = BASETAG + i;
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor wya_grayTitleColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor wya_whiteColor] forState:UIControlStateSelected];
            button.backgroundColor = [UIColor groupTableViewBackgroundColor];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.font = FONT(14);
            button.layer.cornerRadius = 15;
            button.layer.masksToBounds = YES;
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            //根据计算文字的大小
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
            CGFloat length = [_contentArray[i] boundingRectWithSize:CGSizeMake(ScreenWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
            //设置button的frame
            button.frame = CGRectMake(10 + w, h, length + 15 , 30);
            //当button的位置超出屏幕边缘时换行 ScreenWidth 只是button所在父视图的宽度
            if(10 + w + length + 15 > ScreenWidth){
                w = 0; //换行时将w置为0
                h = h + button.frame.size.height + 10;//距离父视图也变化
                button.frame = CGRectMake(10 + w, h, length + 15, 30);//重设button的frame
            }
            w = button.frame.size.width + button.frame.origin.x;
            if (i == _contentArray.count - 1) {
                self.btnBgViewHeight = CGRectGetMaxY(button.frame);
            }
            [self.btnBgView addSubview:button];
        }
          [self layoutIfNeeded];

    }
}

#pragma mark ======= Event

- (void)buttonClicked:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        sender.backgroundColor = [UIColor blackColor];
    }else{
        sender.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
}

#pragma mark ======= Lazy
- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.font = FONTS(20);
            object.text = @"标签分类";
            object.textColor = [UIColor blackColor];
            object;
       });
    }
    return _titleLabel;
}

- (UIButton *)resetButton{
    if(!_resetButton){
        _resetButton = ({
            UIButton * object = [[UIButton alloc]init];
            object;
       });
    }
    return _resetButton;
}

- (UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = ({
            UIButton * object = [[UIButton alloc]init];
            object;
       });
    }
    return _sureButton;
}

- (UIView *)btnBgView{
    if(!_btnBgView){
        _btnBgView = ({
            UIView * object = [[UIView alloc]init];
            object;
       });
    }
    return _btnBgView;
}

@end
