//
//  WYAAgentRingSectionFootView.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAAgentRingSectionFootView.h"
#import "WYAAgentRingModel.h"

@interface WYAAgentRingSectionFootView ()
@property (nonatomic, strong) UIView * commentsView; // 关于评论的视图
@end

@implementation WYAAgentRingSectionFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.commentsView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.commentsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(60 * SizeAdapter);
        make.right.mas_equalTo(self.mas_right).with.offset(-12 * SizeAdapter);
        make.top.mas_equalTo(self.mas_top);
        if (self.model.comments.count > 0) {

            NSMutableArray * array = [NSMutableArray array];
            for (WYAAgentRingCommentsModel * commentsModle in self.model.comments) {
                NSString * string = [NSString stringWithFormat:@"%@:%@",commentsModle.personName,commentsModle.comments];
                CGFloat height = [string wya_heightWithFontSize:12 * SizeAdapter width:self.cmam_width - 71 * SizeAdapter];
                [array addObject:[NSNumber numberWithFloat:height]];
            }
            CGFloat allHeight = 0.0f;
            if (self.model.comments.count > 2) {
                if (self.model.show) {
                    for (NSNumber * number in array) {
                        allHeight = allHeight + [number floatValue];
                    }
                    allHeight = allHeight + 20;
                }else{
                    allHeight = [array[0] floatValue] + [array[1] floatValue] + 20;
                }
            }else{
                for (NSNumber * number in array) {
                    allHeight = allHeight + [number floatValue];
                }
            }
            make.height.mas_equalTo(allHeight);
        }else {
            make.height.mas_equalTo(0);
        }

    }];

    [self.commentsView.subviews wya_mas_distributeSudokuViewsWithFixedLineSpacing:0
                                                            fixedInteritemSpacing:0
                                                                        warpCount:1
                                                                       topSpacing:0
                                                                    bottomSpacing:0
                                                                      leadSpacing:0
                                                                      tailSpacing:0];
}

#pragma mark ======= Setter
- (void)setModel:(WYAAgentRingModel *)model{
    _model = model;
    if (model) {
        if (model.comments.count > 0) {
            for (UIView * view in self.commentsView.subviews) {
                [view removeFromSuperview];
            }

            for (NSInteger index = 0; index < model.comments.count; index++) {
                WYAAgentRingCommentsModel * commentsModel = model.comments[index];
                YYLabel * label = [[YYLabel alloc]init];
                label.text = [NSString stringWithFormat:@"%@:%@",commentsModel.personName,commentsModel.comments];
                label.font = FONT(12);
                NSLog(@"show==%d",model.show);
                if (!model.show) {
                    if (index < 2) {
                        [self.commentsView addSubview:label];
                    }
                }else {
                    [self.commentsView addSubview:label];
                }

            }

            if (model.comments.count > 2) {
                UIButton *  object = [[UIButton alloc]init];
                [object setTitle:@"更多评论" forState:UIControlStateNormal];
                [object setTitle:@"收起评论" forState:UIControlStateSelected];
                [object setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                object.titleLabel.font = FONT(15);
                [object addCallBackAction:^(UIButton *button) {
                    self.model.show = !self.model.show;

                    if (self.stretchBlock) {
                        self.stretchBlock(model);
                    }
                }];
                [self.commentsView addSubview:object];
            }
        }
        [self layoutIfNeeded];
    }
}

#pragma mark ======= Public Method
+ (CGFloat)getFootHeightWithModel:(WYAAgentRingModel *)model{
    WYAAgentRingSectionFootView * cell = [[WYAAgentRingSectionFootView alloc]initWithReuseIdentifier:@"xa"];
    cell.model = model;
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    NSLog(@"height==%f",cell.commentsView.cmam_bottom);
    return cell.commentsView.cmam_bottom;
}

#pragma mark ======= Getter
- (UIView *)commentsView{
    if(!_commentsView){
        _commentsView = ({
            UIView * object = [[UIView alloc]init];
            object.backgroundColor = [UIColor lightGrayColor];
            object;
        });
    }
    return _commentsView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
