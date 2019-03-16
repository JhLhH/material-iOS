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
@property (nonatomic, strong) UIButton * showCommentsButton;
@property (nonatomic, strong) NSMutableArray * heights;
@end

@implementation WYAAgentRingSectionFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.commentsView];
        [self.contentView addSubview:self.showCommentsButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat commentsView_height = 0.f;

    if (self.model.comments.count > 0) {
        // 判断当前评论的条数大于0条
        CGFloat allHeight = 0.0f;
        if (self.model.comments.count > 2) {

            if (self.model.show) {
                // 判断当前评论是否是展开的状态
                for (NSNumber * number in self.heights) {
                    allHeight = allHeight + [number floatValue] + 10 * SizeAdapter;
                }
            } else {
                allHeight = [self.heights[0] floatValue] + [self.heights[1] floatValue] + 20 * SizeAdapter;
            }
        } else {
            for (NSNumber * number in self.heights) {
                allHeight = allHeight + [number floatValue] + 10 * SizeAdapter;
            }
        }
        commentsView_height = allHeight;
    }
    CGFloat commentsView_x     = 53 * SizeAdapter;
    CGFloat commentsView_y     = 0;
    CGFloat commentsView_width = ScreenWidth - 69 * SizeAdapter;
    CGRect commentsView_rect   = CGRectMake(commentsView_x, commentsView_y, commentsView_width, commentsView_height);
    self.commentsView.frame    = commentsView_rect;

    UIView * lastView;
    for (NSInteger index = 0; index < self.commentsView.subviews.count; index++) {
        UIView * view       = self.commentsView.subviews[index];
        CGFloat height      = [self.heights[index] floatValue];
        CGFloat view_x      = 0;
        CGFloat view_y      = lastView.cmam_bottom;
        CGFloat view_width  = self.commentsView.cmam_width;
        CGFloat view_height = height + 10 * SizeAdapter;
        CGRect view_rect    = CGRectMake(view_x, view_y, view_width, view_height);
        view.frame          = view_rect;
        lastView            = view;
    }

    CGFloat showCommentsButton_x      = self.commentsView.cmam_left;
    CGFloat showCommentsButton_y      = self.commentsView.cmam_bottom;
    CGFloat showCommentsButton_width  = self.commentsView.cmam_width;
    CGFloat showCommentsButton_height = self.showCommentsButton.hidden ? 0 : 30 * SizeAdapter;
    CGRect showCommentsButton_rect    = CGRectMake(showCommentsButton_x, showCommentsButton_y, showCommentsButton_width, showCommentsButton_height);
    self.showCommentsButton.frame     = showCommentsButton_rect;
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
                self.showCommentsButton.hidden = YES;
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
- (YYLabel *)configYYLabelWithModel:(WYAAgentRingCommentsModel *)model {

    NSMutableAttributedString * text = [self commentsAttributedStringWithModel:model];

    YYLabel * label               = [[YYLabel alloc] init];
    label.preferredMaxLayoutWidth = ScreenWidth - 69 * SizeAdapter;
    label.numberOfLines           = 0;
    label.attributedText          = text;

    if (model.show) {
        CGSize introSize      = CGSizeMake(ScreenWidth - 69 * SizeAdapter, CGFLOAT_MAX);
        YYTextLayout * layout = [YYTextLayout layoutWithContainerSize:introSize text:text];
        label.textLayout      = layout;
        CGFloat introHeight   = layout.textBoundingSize.height + 10 * SizeAdapter;
        [self.heights addObject:[NSNumber numberWithFloat:introHeight]];
    } else {
        [self addSeeMoreButtonWithYYLabel:label commentsModel:model];
        [self.heights addObject:[NSNumber numberWithFloat:30 * SizeAdapter]];
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
    [text yy_setColor:[UIColor blackColor] range:nameRange];
    [text yy_setFont:FONTS(13) range:commentsRange];
    [text yy_setColor:[UIColor lightGrayColor] range:commentsRange];
    text.yy_lineSpacing = 2 * SizeAdapter;

    if (model.show) {
        // 当前评论处于展开状态，添加收起评论，以及相关事件
        WeakSelf(weakSelf);
        [text yy_setFont:FONT(13) range:closeRange];
        [text yy_setColor:[UIColor blueColor] range:closeRange];

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

    NSMutableAttributedString * text = [[NSMutableAttributedString alloc] initWithString:@"...全文"];

    YYTextHighlight * textHighlight = [YYTextHighlight new];
    [textHighlight setColor:[UIColor blueColor]];
    WeakSelf(weakSelf);
    textHighlight.tapAction = ^(UIView * containerView, NSAttributedString * text, NSRange range, CGRect rect) {
        StrongSelf(strongSelf);
        commentsModel.show = YES;
        if (strongSelf.singleCommentsBlock) {
            strongSelf.singleCommentsBlock(strongSelf.model);
        }

    };

    [text yy_setColor:[UIColor blueColor] range:[text.string rangeOfString:@"全文"]];
    [text yy_setTextHighlight:textHighlight range:[text.string rangeOfString:@"全文"]];
    text.yy_font = label.font;

    YYLabel * seeMore      = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];

    NSAttributedString * truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore
                                                                                  contentMode:UIViewContentModeCenter
                                                                               attachmentSize:seeMore.cmam_size
                                                                                  alignToFont:text.yy_font
                                                                                    alignment:YYTextVerticalAlignmentCenter];

    label.truncationToken = truncationToken;
}

#pragma mark ======= Public Method
+ (CGFloat)getFootHeightWithModel:(WYAAgentRingModel *)model {
    WYAAgentRingSectionFootView * cell = [[WYAAgentRingSectionFootView alloc] initWithReuseIdentifier:@"xa"];
    cell.model                         = model;
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    return cell.showCommentsButton.cmam_bottom;
}

#pragma mark ======= Getter
- (UIView *)commentsView {
    if (!_commentsView) {
        _commentsView = ({
            UIView * object        = [[UIView alloc] init];
            object.backgroundColor = [UIColor wya_bgColor];
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
            [object setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
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

@end
