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
        self.textView                     = [[UITextView alloc] init];
        self.textView.delegate            = self;
        self.textView.layer.borderColor   = [UIColor wya_hex:@"#E7C083"].CGColor;
        self.textView.layer.borderWidth   = 1 * SizeAdapter;
        self.textView.layer.cornerRadius  = 4 * SizeAdapter;
        self.textView.layer.masksToBounds = YES;
        self.textView.inputAccessoryView  = [[UIView alloc] init];
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
    self.hidden = YES;
    if (self.sendCommentsBlock) {
        self.sendCommentsBlock(self.textView.text);
    }
}

#pragma mark ======= UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {

    CGFloat maxHeight = 90 * SizeAdapter;

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
            [object setTitleColor:[UIColor wya_blackTextColor] forState:UIControlStateNormal];
            object.titleLabel.font = FONT(15);
            [object addTarget:self action:@selector(sendComments) forControlEvents:UIControlEventTouchUpInside];
            object;
        });
    }
    return _sendButton;
}
@end
