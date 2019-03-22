//
//  WYAMineCreateMaterialFootView.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/21.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineCreateMaterialFootView.h"

@interface WYAMineCreateMaterialFootView ()
@property (nonatomic, strong) UILabel * reasonLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UIButton * deleteButton;
@property (nonatomic, strong) UIButton * editorButton;
@property (nonatomic, strong) UIView * lineView;
@end

@implementation WYAMineCreateMaterialFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.reasonLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.deleteButton];
        [self addSubview:self.editorButton];
        [self addSubview:self.lineView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = ScreenWidth - 93*SizeAdapter;
    CGFloat left = 71*SizeAdapter;
    CGFloat height = [_model.failReasonString wya_heightWithFontSize:12 width:width];
    [self.reasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(left);
        make.top.equalTo(self.mas_top).offset(10*SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];

    [self.editorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15*SizeAdapter);
        make.top.equalTo(self.reasonLabel.mas_bottom).offset(10*SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(70*SizeAdapter, 13*SizeAdapter));
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(left);
        make.centerY.mas_equalTo(self.deleteButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(70*SizeAdapter, 13*SizeAdapter));
    }];

    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.editorButton.mas_left).offset(-49*SizeAdapter);
        make.top.equalTo(self.reasonLabel.mas_bottom).offset(10*SizeAdapter);
        make.size.mas_equalTo(CGSizeMake(70*SizeAdapter, 13*SizeAdapter));
    }];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.bottom.equalTo(self.mas_bottom).offset(-1);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
} 
#pragma mark ======= Setter

- (void)setModel:(WYAMineCreateMaterialModel *)model{
    if (model) {
        _model = model;
        self.reasonLabel.text = _model.failReasonString;
        self.timeLabel.text = _model.mineCreateTimeString;
        [self layoutIfNeeded];
    }
}
#pragma mark ======= Lazy
- (UILabel *)reasonLabel{
    if(!_reasonLabel){
        _reasonLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.textColor = [UIColor wya_redColor];
            object.font = FONT(12);
            object.numberOfLines = 0;
            object;
       });
    }
    return _reasonLabel;
}

- (UIButton *)deleteButton{
    if(!_deleteButton){
        _deleteButton = ({
            UIButton * object = [[UIButton alloc]init];
            [object setTitle:@"删除" forState:0];
            [object setTitleColor:[UIColor wya_blueColor] forState:0];
            [object setImage:[UIImage imageNamed:@"icon_deleteblue"] forState:0];
            CGFloat space = 12*SizeAdapter;
            object.titleLabel.font = FONT(11);
            object.imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space / 2.0);
            object.titleEdgeInsets = UIEdgeInsetsMake(0, space / 2.0, 0, -space / 2.0);
            object;
       });
    }
    return _deleteButton;
}

- (UIButton *)editorButton{
    if(!_editorButton){
        _editorButton = ({
            UIButton * object = [[UIButton alloc]init];
            [object setTitle:@"重新编辑" forState:0];
            [object setTitleColor:[UIColor wya_blueColor] forState:0];
            [object setImage:[UIImage imageNamed:@"icon_edtior"] forState:0];
            CGFloat space = 12*SizeAdapter;
            object.titleLabel.font = FONT(11);
            object.imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space / 2.0);
            object.titleEdgeInsets = UIEdgeInsetsMake(0, space / 2.0, 0, -space / 2.0);
            object;
       });
    }
    return _editorButton;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = ({
            UIView * object        = [[UIView alloc] init];
            object.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];
            object;
        });
    }
    return _lineView;
}

- (UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object.textColor = [UIColor wya_textGrayColor];
            object.font = FONT(10);
            object;
        });
    }
    return _timeLabel;
}
#pragma mark ======= Public Method
+ (CGFloat)footViewHeightWithModel:(WYAMineCreateMaterialModel *)model{
    CGFloat contentWidth = ScreenWidth - 93*SizeAdapter;
    CGFloat height = [model.failReasonString wya_heightWithFontSize:12 width:contentWidth];
    if ([model.mineCreateAuditType isEqualToString:@"审核失败"]) {
        return height + 40*SizeAdapter;
    }
    return 0.01;
}

@end
