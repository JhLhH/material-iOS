//
//  WYAAgentRingCommentsView.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAAgentRingCommentsView.h"

@interface WYAAgentRingCommentsView () <UITextViewDelegate>
@property (nonatomic, strong) UIButton * sendButton;
@end

@implementation WYAAgentRingCommentsView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.textView                     = [[IQTextView alloc] init];
        self.textView.delegate            = self;
        self.textView.layer.borderColor   = [UIColor wya_hex:@"#E7C083"].CGColor;
        self.textView.layer.borderWidth   = 1 * SizeAdapter;
        self.textView.layer.cornerRadius  = 4 * SizeAdapter;
        self.textView.layer.masksToBounds = YES;
        self.textView.inputAccessoryView  = [[UIView alloc] init];
        self.textView.placeholder = @"请输入内容";
        self.textView.placeholderTextColor = [UIColor wya_textLightGrayColor];
        self.textView.font = FONT(15);
        self.textView.selectedRange = NSMakeRange(0, 0);
        [self addSubview:self.textView];
        [self addSubview:self.sendButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat textView_x      = 5 * SizeAdapter;
    CGFloat textView_y      = 5 * SizeAdapter;
    CGFloat textView_width  = self.cmam_width - 58 * SizeAdapter;
    CGFloat textView_height = self.cmam_height - 10 * SizeAdapter;
    CGRect textView_rect    = CGRectMake(textView_x, textView_y, textView_width, textView_height);
    self.textView.frame     = textView_rect;

    CGFloat sendButton_x      = self.cmam_width - 48 * SizeAdapter;
    CGFloat sendButton_y      = 5 * SizeAdapter;
    CGFloat sendButton_width  = 48 * SizeAdapter;
    CGFloat sendButton_height = self.cmam_height - 10 * SizeAdapter;
    CGRect sendButton_rect    = CGRectMake(sendButton_x, sendButton_y, sendButton_width, sendButton_height);
    self.sendButton.frame     = sendButton_rect;
}

#pragma mark ======= Private Method
- (void)sendComments {
    [self.textView resignFirstResponder];
    self.textView.text = nil;
    self.hidden = YES;
    if (self.sendCommentsBlock) {
        self.sendCommentsBlock(self.textView.text);
    }
}

#pragma mark ======= UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    CGFloat maxHeight = 52 * SizeAdapter;

    NSString * toBeString = textView.text;

    // 获取键盘输入模式
    NSString * lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage;

    if ([lang isEqualToString:@"zh-Hans"]) {
        // zh-Hans代表简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange * selectedRange = [textView markedTextRange];

        //获取高亮部分
        UITextPosition * position = [textView positionFromPosition:selectedRange.start offset:0];

        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > 200) {
                textView.text = [toBeString substringToIndex:200]; //超出限制则截取最大限制的文本
            }
        }
    } else {
        // 中文输入法以外的直接统计
        if (toBeString.length > 200) {
            textView.text = [toBeString substringToIndex:200];
        }
    }

    CGRect frame          = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size           = [textView sizeThatFits:constraintSize];
    if (size.height <= frame.size.height) {
        //         size.height = frame.size.height;
    } else {
        if (size.height >= maxHeight) {
            size.height = maxHeight;
        }
    }
    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
    if (self.frameChangeBlock) {
        self.frameChangeBlock(self, size.height + 10 * SizeAdapter);
    }
}

#pragma mark ======= Lazy
- (UIButton *)sendButton {
    if (!_sendButton) {
        _sendButton = ({
            UIButton * object = [[UIButton alloc] init];
            [object setTitle:@"发送" forState:UIControlStateNormal];
            [object setTitleColor:[UIColor wya_textBlackColor] forState:UIControlStateNormal];
            object.titleLabel.font = FONT(15);
            [object addTarget:self action:@selector(sendComments) forControlEvents:UIControlEventTouchUpInside];
            object;
        });
    }
    return _sendButton;
}
@end
