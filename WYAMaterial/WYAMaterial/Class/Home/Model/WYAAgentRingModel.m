//
//  WYAAgentRingModel.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAAgentRingModel.h"

@implementation WYAAgentRingImageModel

@end

@implementation WYAAgentRingCommentsModel

@end

@interface WYAAgentRingModel ()

@property (nonatomic, strong) NSMutableArray * heights;
@end

@implementation WYAAgentRingModel

- (CGFloat)cellHeight{
    CGFloat h = 56 * SizeAdapter;
    CGFloat contentH = [self.content wya_heightWithFontSize:15
                                                      width:ScreenWidth - 69 * SizeAdapter];
    CGFloat contentHeight = self.contentShow ? contentH : 51 * SizeAdapter;
    CGFloat showH = contentH > 51 * SizeAdapter ? 30 * SizeAdapter : 0;
    CGFloat imageH = 0.0;
    if (self.urls.count > 0) {
        CGFloat itemHeight = (ScreenWidth - 89 * SizeAdapter) / 3;
        if (self.urls.count < 2) {
            imageH = itemHeight * 2;
        } else {
            NSInteger row = self.urls.count / 3;
            NSInteger column = self.urls.count % 3;

            if (column == 0) {
                // 整除的
                if (row > 1) {
                    imageH = itemHeight * row + 10 * SizeAdapter * (row - 1);
                } else {
                    imageH = itemHeight;
                }
            } else {
                if (row > 0) {
                    imageH = itemHeight * (row + 1) + 10 * SizeAdapter * row;
                } else {
                    imageH = itemHeight;
                }

            }
        }
    }

    for (WYAAgentRingCommentsModel * model in self.comments) {
        [self configYYLabelWithModel:model];
    }
    CGFloat allHeight = 0.0f;
    if (self.comments.count > 0) {
        // 判断当前评论的条数大于0条

        if (self.comments.count > 2) {

            if (self.show) {
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
    }
    CGFloat commentShowH = 0.0f;
    if (self.comments.count > 2) {
        commentShowH = 30 * SizeAdapter;
    }

    h = h + contentHeight + showH + imageH;
    return h;
//    return 300;
}


- (void)configYYLabelWithModel:(WYAAgentRingCommentsModel *)model {

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
        [self.heights addObject:[NSNumber numberWithFloat:30 * SizeAdapter]];
    }

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
        [text yy_setFont:FONT(13) range:closeRange];
        [text yy_setColor:[UIColor blueColor] range:closeRange];

        YYTextHighlight * textHighlight = [YYTextHighlight new];
        [textHighlight setColor:[UIColor redColor]];
        [text yy_setTextHighlight:textHighlight range:closeRange];
    }
    return text;
}

- (NSMutableArray *)heights{
    if(!_heights){
        _heights = ({
            NSMutableArray * object = [[NSMutableArray alloc]init];
            object;
        });
    }
    return _heights;
}
@end
