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
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIView * commentsView; // 关于评论的视图
@property (nonatomic, strong) UIButton * showCommentsButton;
@property (nonatomic, strong) NSMutableArray * heights;
@property (nonatomic, strong) UIView * line;
@end

@implementation WYAAgentRingSectionFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.commentsView];
        [self.bgView addSubview:self.showCommentsButton];
        [self.contentView addSubview:self.line];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat commentsView_x      = 0;
    CGFloat commentsView_y      = 0;
    CGFloat commentsView_width  = ScreenWidth - 83 * SizeAdapter;
    CGFloat commentsView_height = [self getCommentsHeight];
    CGRect commentsView_rect    = CGRectMake(commentsView_x, commentsView_y, commentsView_width, commentsView_height);
    self.commentsView.frame     = commentsView_rect;

    [self layoutConmmentSubViews];

    CGFloat showCommentsButton_x      = self.commentsView.cmam_left;
    CGFloat showCommentsButton_y      = self.commentsView.cmam_bottom;
    CGFloat showCommentsButton_width  = self.commentsView.cmam_width;
    CGFloat showCommentsButton_height = self.showCommentsButton.hidden ? 0 : 40 * SizeAdapter;
    CGRect showCommentsButton_rect    = CGRectMake(showCommentsButton_x, showCommentsButton_y, showCommentsButton_width, showCommentsButton_height);
    self.showCommentsButton.frame     = showCommentsButton_rect;

    [self.showCommentsButton wya_setButtonImageLoctionRightWithSpace:3];

    CGFloat bgView_x = 69 * SizeAdapter;
    CGFloat bgView_y = 0;
    CGFloat bgView_width = ScreenWidth - 83 * SizeAdapter;
    CGFloat bgView_height = self.commentsView.cmam_height + self.showCommentsButton.cmam_height;
    CGRect bgView_rect = CGRectMake(bgView_x, bgView_y,  bgView_width, bgView_height);
    self.bgView.frame = bgView_rect;

    CGFloat line_x = 0;
    CGFloat line_y = self.contentView.cmam_height - 1 * SizeAdapter;
    CGFloat line_width = ScreenWidth;
    CGFloat line_height = 1 * SizeAdapter;
    CGRect line_rect = CGRectMake(line_x, line_y,  line_width, line_height);
    self.line.frame = line_rect;
}

#pragma mark ======= Setter
- (void)setModel:(WYAAgentRingModel *)model {
    _model = model;
    if (model) {
        if (model.comments.count > 0) {
            {
                // 设置初始状态
                for (UIView * view in self.commentsView.subviews) {
                    view.hidden = YES;
                    [view removeFromSuperview];
                }
                self.showCommentsButton.hidden   = YES;
                self.showCommentsButton.selected = model.show;
                [self.heights removeAllObjects];
            }

            {
                for (NSInteger index = 0; index < model.comments.count; index++) {
                    WYAAgentRingCommentsModel * commentsModel = model.comments[index];

                    YYLabel * label = [self configYYLabelWithModel:commentsModel];

                    if (!model.show) {
                        if (index < 2) {
                            [self.commentsView addSubview:label];
                        }
                    } else {
                        [self.commentsView addSubview:label];
                    }
                }

                if (model.comments.count > 2) {
                    self.showCommentsButton.hidden = NO;
                }
            }
        }
        [self layoutIfNeeded];
    }
}

#pragma mark ======= Private Method
- (CGFloat)getCommentsHeight {
    CGFloat height = 0.0f;
    if (self.model.comments.count > 0) {
        // 判断当前评论的条数大于0条
        CGFloat allHeight = 0.0f;
        if (self.model.comments.count > 2) {

            if (self.model.show) {
                // 判断当前评论是否是展开的状态
                for (NSInteger index = 0; index < self.heights.count; index++) {
                    NSNumber * number = self.heights[index];
                    if (index == 0) {
                        allHeight = allHeight + [number floatValue] + 15 * SizeAdapter;
                    } else {
                        allHeight = allHeight + [number floatValue];
                    }
                }
            } else {
                allHeight = [self.heights[0] floatValue] + [self.heights[1] floatValue] + 15 * SizeAdapter;
            }
        } else {

            for (NSInteger index = 0; index < self.heights.count; index++) {
                NSNumber * number = self.heights[index];
                if (index == 0) {
                    allHeight = allHeight + [number floatValue] + 15 * SizeAdapter;
                } else {
                    allHeight = allHeight + [number floatValue];
                }
            }
            allHeight = allHeight + 15 * SizeAdapter;
        }
        height = allHeight;
    }
    return height;
}

- (void)layoutConmmentSubViews {
    UIView * lastView;
    for (NSInteger index = 0; index < self.commentsView.subviews.count; index++) {
        UIView * view       = self.commentsView.subviews[index];
        CGFloat height      = [self.heights[index] floatValue];
        CGFloat view_x      = 10 * SizeAdapter;
        CGFloat view_y      = lastView.cmam_bottom + (index == 0 ? 15 * SizeAdapter : 0 * SizeAdapter);
        CGFloat view_width  = self.commentsView.cmam_width - 20 * SizeAdapter;
        CGFloat view_height = height;
        CGRect view_rect    = CGRectMake(view_x, view_y, view_width, view_height);
        view.frame          = view_rect;
        lastView            = view;
    }
}

- (YYLabel *)configYYLabelWithModel:(WYAAgentRingCommentsModel *)model {

    NSMutableAttributedString * text = [self commentsAttributedStringWithModel:model];

    YYLabel * label               = [[YYLabel alloc] init];
    label.preferredMaxLayoutWidth = ScreenWidth - 103 * SizeAdapter;
    label.numberOfLines           = 0;
    label.attributedText          = text;

    if (model.show) {
        CGSize introSize      = CGSizeMake(ScreenWidth - 103 * SizeAdapter, CGFLOAT_MAX);
        YYTextLayout * layout = [YYTextLayout layoutWithContainerSize:introSize text:text];
        label.textLayout      = layout;
        CGFloat introHeight   = layout.textBoundingSize.height;
        [self.heights addObject:[NSNumber numberWithFloat:introHeight]];
    } else {
        [self addSeeMoreButtonWithYYLabel:label commentsModel:model];
        [self.heights addObject:[NSNumber numberWithFloat:35 * SizeAdapter]];
    }

    return label;
}

- (NSMutableAttributedString *)commentsAttributedStringWithModel:(WYAAgentRingCommentsModel *)model {
    NSString * closeString = @"收起评论";
    NSString * string;
    if (model.show) {
        // 当前评论处于展开状态，添加收起评论字样
        string = [NSString stringWithFormat:@"%@: %@ %@", model.personName, model.comments, closeString];
    } else {
        string = [NSString stringWithFormat:@"%@: %@", model.personName, model.comments];
    }

    NSMutableAttributedString * text = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange commentsRange            = [string rangeOfString:model.comments options:NSCaseInsensitiveSearch];
    NSRange nameRange                = [string rangeOfString:model.personName options:NSCaseInsensitiveSearch];
    NSRange closeRange               = [string rangeOfString:closeString options:NSCaseInsensitiveSearch];

    [text yy_setFont:FONTS(12) range:nameRange];
    [text yy_setColor:[UIColor wya_textLightBlackColor] range:nameRange];
    [text yy_setFont:FONTS(12) range:commentsRange];
    [text yy_setColor:[UIColor wya_textDarkGrayColor] range:commentsRange];
    text.yy_lineSpacing = 2 * SizeAdapter;
    text.yy_kern        = [NSNumber numberWithInt:1 * SizeAdapter];
    if (model.show) {
        // 当前评论处于展开状态，添加收起评论，以及相关事件
        WeakSelf(weakSelf);
        [text yy_setFont:FONT(12) range:closeRange];
        [text yy_setColor:[UIColor wya_blueColor] range:closeRange];

        YYTextHighlight * textHighlight = [YYTextHighlight new];
        [textHighlight setColor:[UIColor redColor]];
        [textHighlight setTapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            StrongSelf(strongSelf);
            model.show = NO;
            if (strongSelf.singleCommentsBlock) {
                strongSelf.singleCommentsBlock(strongSelf.model);
            }
        }];
        [text yy_setTextHighlight:textHighlight range:closeRange];
    }
    return text;
}

- (void)addSeeMoreButtonWithYYLabel:(YYLabel *)label commentsModel:(WYAAgentRingCommentsModel *)commentsModel {

    NSMutableAttributedString * text = [[NSMutableAttributedString alloc] initWithString:@"...更多"];

    YYTextHighlight * textHighlight = [YYTextHighlight new];
    [textHighlight setColor:[UIColor wya_blueColor]];
    WeakSelf(weakSelf);
    textHighlight.tapAction = ^(UIView * containerView, NSAttributedString * text, NSRange range, CGRect rect) {
        StrongSelf(strongSelf);
        commentsModel.show = YES;
        if (strongSelf.singleCommentsBlock) {
            strongSelf.singleCommentsBlock(strongSelf.model);
        }

    };
    NSRange range = [text.string rangeOfString:@"更多"];
    [text yy_setColor:[UIColor wya_blueColor] range:range];
    [text yy_setTextHighlight:textHighlight range:range];
    text.yy_font           = FONT(12);
    text.yy_baselineOffset = [NSNumber numberWithInt:-2];
    YYLabel * seeMore      = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];

    NSAttributedString * truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore
                                                                                  contentMode:UIViewContentModeBottom
                                                                               attachmentSize:seeMore.cmam_size
                                                                                  alignToFont:text.yy_font
                                                                                    alignment:YYTextVerticalAlignmentBottom];

    label.truncationToken = truncationToken;
}

#pragma mark ======= Public Method
+ (CGFloat)getFootHeightWithModel:(WYAAgentRingModel *)model {
    WYAAgentRingSectionFootView * cell = [[WYAAgentRingSectionFootView alloc] initWithReuseIdentifier:@"xa"];
    cell.model                         = model;
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    return cell.showCommentsButton.cmam_bottom + 10 * SizeAdapter;
}

#pragma mark ======= Getter
- (UIView *)bgView{
    if(!_bgView){
        _bgView = ({
            UIView * object = [[UIView alloc]init];
            object.backgroundColor     = [UIColor wya_hex:@"#F2F2F5"];
            object.layer.cornerRadius  = 5 * SizeAdapter;
            object.layer.masksToBounds = YES;
            object;
        });
    }
    return _bgView;
}

- (UIView *)commentsView {
    if (!_commentsView) {
        _commentsView = ({
            UIView * object            = [[UIView alloc] init];
            object.backgroundColor     = [UIColor wya_hex:@"#F2F2F5"];
            object;
        });
    }
    return _commentsView;
}

- (UIButton *)showCommentsButton {
    if (!_showCommentsButton) {
        _showCommentsButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"更多评论" forState:UIControlStateNormal];
            [object setTitle:@"收起评论" forState:UIControlStateSelected];
            [object setTitleColor:[UIColor wya_blueColor] forState:UIControlStateNormal];
            [object setImage:[UIImage imageNamed:@"icon_down"] forState:UIControlStateNormal];
            [object setImage:[UIImage imageNamed:@"icon_up"] forState:UIControlStateSelected];
            [object setBackgroundColor:[UIColor wya_bgColor]];
            object.titleLabel.font = FONT(13);
            object.hidden          = YES;

            [object addCallBackAction:^(UIButton * button) {
                self.model.show = !self.model.show;

                if (self.stretchBlock) {
                    self.stretchBlock(self.model);
                }
            }];
            object;
        });
    }
    return _showCommentsButton;
}

- (NSMutableArray *)heights {
    if (!_heights) {
        _heights = ({
            NSMutableArray * object = [[NSMutableArray alloc] init];
            object;
        });
    }
    return _heights;
}

- (UIView *)line{
    if(!_line){
        _line = ({
            UIView * object = [[UIView alloc]init];
            object.backgroundColor = [UIColor wya_lineColor];
            object;
       });
    }
    return _line;
}

@end
