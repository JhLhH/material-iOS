//
//  WYABottomLineTextField.m
//  WYA_OC_OA
//
//  Created by 1 on 2018/11/19.
//  Copyright © 2018年 weiyian. All rights reserved.
//

#import "WYABottomLineTextField.h"

@implementation WYABottomLineTextField

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0.0, rect.size.height - 1);
    CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 0.8);  //线的颜色
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height - 1);
    CGContextStrokePath(context);
}

- (void)setPlaceholderColor:(UIColor *)color{
    
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    
}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        _phoneNumberText = @"";
        [self addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
    
}

- (void)setStyle:(TextUIContentStyle)style{
    
    _style = style;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    
}

- (void)setIsPhoneNumber:(BOOL)isPhoneNumber{
    
    _isPhoneNumber = isPhoneNumber;
    
    if (isPhoneNumber) {
        self.delegate = self;
        self.keyboardType = UIKeyboardTypePhonePad;
    }
    
}

- (void)setText:(NSString *)text{
    
    [super setText:text];
    
    _phoneNumberText = [self trimmingWhitespaceWithStr:text];
    
}

//监听文本框内文字变化
- (void)textFieldDidEditing:(UITextField *)textField{
    
    if (self.style == LightContentStyle) {
        UIButton * clearButton = [self valueForKey:@"_clearButton"];//key值是固定的
        [clearButton setImage:[UIImage imageNamed:@"icon_delete_normal"] forState:UIControlStateNormal];
    }
    
    if (_isPhoneNumber) {
        _phoneNumberText = [self trimmingWhitespaceWithStr:textField.text];
        [self showEndForSpaceTextWithText:self.text];
    }
    
    if (self.editingBlock) {
        self.editingBlock();
    }
    
}

//去除空格
- (NSString *)trimmingWhitespaceWithStr:(NSString *)str
{
    NSString *endStr = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return endStr;
}

#pragma mark -------- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (_isPhoneNumber) {
        
        //如果输入不是数字或者删除，则无效输入
        if (![self isPureInt:string] && ![string isEqualToString:@""]) {
            return NO;
        }
        
        //如果输入最大长度，且当前不是删除操作
        NSString * curNumText = [self trimmingWhitespaceWithStr:textField.text];
        if ((curNumText.length + string.length > 11) && ![string isEqualToString:@""]) {
            return NO;
        }
        
        //设置分割
        if (![string isEqualToString:@""]) {
            [self showEndForSpaceTextWithText:curNumText];
        }
        
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    if (_isPhoneNumber) {
        _phoneNumberText = @"";
    }
    self.editingBlock();
    
    return YES;
}

#pragma mark ---------重写 UIKeyInput 代理方法
//针对搜狗键盘删除，不走回调的问题，特殊处理
- (void)deleteBackward{
    
    //光标位置
    UITextPosition * start = self.selectedTextRange.start;
    NSInteger index = [[start valueForKey:@"_offset"] integerValue];
    //手机号码删除分割
    if (_isPhoneNumber && (index == 4 || index == 9)){
        
        NSString * deletedText = [self.text stringByReplacingCharactersInRange:NSMakeRange(index - 2, 1) withString:@""];
        [self showEndForSpaceTextWithText:deletedText];
        [self cursorOffsetIndex:index - 2];
        
    }else{
        [super deleteBackward];
        if (_isPhoneNumber) {
            [self showEndForSpaceTextWithText:self.text];
            [self cursorOffsetIndex:index - 1];
        }
    }
    
}

//显示带有空格的字符串
- (void)showEndForSpaceTextWithText:(NSString *)text{
    NSString * curNumText = [self trimmingWhitespaceWithStr:text];
    NSMutableString * endStr = [[NSMutableString alloc] initWithString:curNumText];
    if (endStr.length >= 3) {
        [endStr insertString:@" " atIndex:3];
    }
    if (endStr.length >= 8) {
        [endStr insertString:@" " atIndex:8];
    }
    self.text = endStr;
}

// textField需要设置的textField，index要设置的光标位置
- (void)cursorOffsetIndex:(NSInteger)index
{
    NSRange range = NSMakeRange(index,0);
    
    UITextPosition * start = [self positionFromPosition:[self beginningOfDocument]offset:range.location];
    
    UITextPosition * end = [self positionFromPosition:start offset:range.length];
    
    [self setSelectedTextRange:[self textRangeFromPosition:start toPosition:end]];
}





//判断是否为数字
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

@end
