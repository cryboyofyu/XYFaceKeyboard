//
//  XYInputBox.m
//  XYFaceKeyboardExample
//
//  Created by XY Lv on 16/12/20.
//  Copyright © 2016年 吕欣宇. All rights reserved.
//

#import "XYInputBox.h"
#import "XYKEYBOARDCONFIG.h"
#import "UIButton+XYButton.h"
@implementation XYInputBox

- (instancetype)initWithFrame:(CGRect)frame withBgView:(UIView *)bgView{
    self = [super initWithFrame:frame];
    if(self){
        
        _xy_faceKeyboard = [[XYFaceKeyboard alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame), xy_width, xy_emotionKeyboarH)];
        self.xy_bgView = bgView;
        [bgView addSubview:self];
    }
    return self;
}

- (void)xy_createInputBox{
    [self xy_layoutTextViewWithBgView:self.xy_bgView];
    [self xy_layoutKeyboardBtnWithBgView:self.xy_bgView];
    [self xy_layoutFaceboardWithBgView:self.xy_bgView];
    [_xy_faceKeyboard xy_reloadFaceKeyboard];
}

- (void)xy_addKeyboardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xyKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xyKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [_xy_textView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)xy_layoutTextViewWithBgView:(UIView *)bgView{
    _xy_textView = [[UITextView alloc]initWithFrame:CGRectMake(xy_leftDistance, (CGRectGetHeight(self.frame) - xy_textViewH)/2, xy_textViewW, xy_textViewH)];
    [_xy_textView.layer  setCornerRadius:xy(6)];
    _xy_textView.backgroundColor = [UIColor whiteColor];
    _xy_textView.font = [UIFont systemFontOfSize:xy_textViewFont];
    [_xy_textView.layer setMasksToBounds:YES];
    _xy_textView.delegate = self;
    _xy_textView.returnKeyType = UIReturnKeySend;
    [self addSubview:_xy_textView];
#pragma mark-xy -添加手势  当结束编辑状态 按textview 光标移到最后
    UITapGestureRecognizer * xyTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xyTap:)];
    [_xy_textView addGestureRecognizer:xyTap];
    
#pragma mark-xy -添加placeholder label
    _xy_placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(xy_padding, 0, _xy_textView.bounds.size.width - xy_padding, _xy_textView.bounds.size.height)];
    _xy_placeholderLabel.text = @"~欣宇最帅~";
    _xy_placeholderLabel.textColor = xy_placeholderColor;

    [_xy_textView addSubview:_xy_placeholderLabel];
}

- (void)xy_layoutKeyboardBtnWithBgView:(UIView *)bgView{
    _xy_toFaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _xy_toFaceBtn.frame = CGRectMake(CGRectGetMaxX(_xy_textView.frame) + xy_leftDistance, _xy_textView.frame.origin.y, xy_emotionBtnW, xy_emotionBtnW);
    [_xy_toFaceBtn setBackgroundImage:[UIImage imageNamed:@"icon_emotion"] forState:UIControlStateNormal];
    [_xy_toFaceBtn setTitle:@"发送" forState:UIControlStateSelected];
    [_xy_toFaceBtn setTitleColor:[UIColor colorWithRed:0.53 green:0.82 blue:0.77 alpha:1.00] forState:UIControlStateSelected];
    [_xy_toFaceBtn addTarget:self action:@selector(xy_faceBoardClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_xy_toFaceBtn];
}

- (void)xy_layoutSendBtnWithBgView:(UIView *)bgView{
    _xy_sendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _xy_sendBtn.frame = CGRectMake(xy_width-xy(75),xy(7),xy(65),xy(30));
    _xy_sendBtn.clipsToBounds = YES;
    _xy_sendBtn.layer.cornerRadius = 5;
    _xy_sendBtn.backgroundColor = [UIColor orangeColor];
    [_xy_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [_xy_sendBtn addTarget:self action:@selector(xy_sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_xy_sendBtn];
}

- (void)xy_layoutFaceboardWithBgView:(UIView *)bgView{
    [self xy_addKeyboardNotification];

    _xy_isKeyboardShow = YES;
    _xy_faceKeyboard.xy_inputTextView = _xy_textView;
    __weak typeof (self) xyWeakSelf = self;
    _xy_faceKeyboard.xySendFaceBlock = ^ (NSString * message){
        if([xyWeakSelf.xy_delegate respondsToSelector:@selector(xy_getMessage:)]){
            [xyWeakSelf.xy_delegate xy_getMessage:message];
        }
    };
    [_xy_bgView addSubview:_xy_faceKeyboard];
    
}

- (void)xy_textViewBegainEdit{
    _xy_textView.editable = YES;
    [_xy_textView becomeFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        _xy_faceKeyboard.frame = CGRectMake(0, xy_height, _xy_faceKeyboard.bounds.size.width, _xy_faceKeyboard.bounds.size.height);
    }];
}

#pragma mark-xy --------------------------代理位置-----------------------------------
- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSRange xyInsertionPoint = NSMakeRange(textView.text.length, 0);
    textView.selectedRange = xyInsertionPoint;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    textView.editable = NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString * xyStr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if([text isEqualToString:@"\n"]){
        [self xy_sendMessage];
    }
    if(xyStr.length>0){
        _xy_placeholderLabel.hidden = YES;
    }else{
        _xy_placeholderLabel.hidden = NO;
    }
    
    return YES;
}

#pragma mark-xy ------------------------响应位置------------------------------------
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if([keyPath isEqualToString:@"text"]){
        NSString * xyTextNew = [change valueForKey:NSKeyValueChangeNewKey];
        if(xyTextNew.length>0){
            _xy_placeholderLabel.hidden = YES;
        }else{
            _xy_placeholderLabel.hidden = NO;

        }
    }
}

- (void)xyTap:(UIGestureRecognizer *)gesture{
    [self xy_textViewBegainEdit];
}

- (void)xyKeyboardWillShow:(NSNotification *)notification{
    _xy_isKeyboardShow = YES;
    [_xy_toFaceBtn setBackgroundImage:[UIImage imageNamed:@"icon_emotion"] forState:UIControlStateNormal];
    _xy_toFaceBtn.selected = NO;

    NSDictionary * xyUserInfo = [notification userInfo];
    NSValue * xyValue = [xyUserInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect xyKeyboardRect = [xyValue CGRectValue];
    xyKeyboardRect = [self convertRect:xyKeyboardRect fromView:nil];
    self.xy_viewHeight = [NSNumber numberWithFloat:xy_height - xyKeyboardRect.size.height - self.bounds.size.height];
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, xy_height - xyKeyboardRect.size.height - CGRectGetHeight(self.frame), self.bounds.size.width, self.bounds.size.height);
    }];
    if([_xy_delegate respondsToSelector:@selector(xy_keyboardWillShowWithKeyboardHeight:)]){
        [_xy_delegate xy_keyboardWillShowWithKeyboardHeight:xyKeyboardRect.size.height];
    }
}

- (void)xyKeyboardWillHide:(NSNotification *)notification{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, CGRectGetHeight(self.xy_bgView.frame) - xy_commentBoxH, xy_width, xy_commentBoxH);
    }];
}

- (void)xy_keyboardResignFirstResponder{
    [_xy_textView resignFirstResponder];
    self.xy_isKeyboardShow = YES;
    self.xy_viewHeight = [NSNumber numberWithFloat:CGRectGetMaxY(self.frame) - CGRectGetHeight(self.frame)];
    
    [UIView animateWithDuration:0.25 animations:^{
        _xy_faceKeyboard.frame = CGRectMake(0, xy_height, xy_width, xy_emotionKeyboarH);
        self.self.frame = CGRectMake(0, xy_height - CGRectGetHeight(self.frame), xy_width, CGRectGetHeight(self.frame));
    }];
}

- (void)xy_faceBoardClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    NSLog(@"选中状态:%d",sender.selected);
    _xy_isKeyboardShow = !_xy_isKeyboardShow;

    if(sender.selected == 0){
        
        [self xy_sendMessage];
        [_xy_toFaceBtn setBackgroundImage:[UIImage imageNamed:@"icon_emotion"] forState:UIControlStateNormal];


    }else{
        
        [_xy_toFaceBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];

        if(_xy_isKeyboardShow){
            [self xy_textViewBegainEdit];
        }else{
            [_xy_textView resignFirstResponder];
            self.xy_viewHeight = [NSNumber numberWithFloat:xy_height - xy_emotionKeyboarH - CGRectGetHeight(self.frame)];
            [UIView animateWithDuration:0.25 animations:^{
                self.frame = CGRectMake(0, xy_height - xy_emotionKeyboarH - CGRectGetHeight(self.frame), xy_width, CGRectGetHeight(self.frame));
                _xy_faceKeyboard.frame = CGRectMake(0, xy_height-xy_emotionKeyboarH, xy_width, xy_emotionKeyboarH);
            }];
            if(self.xy_delegate&&[self.xy_delegate respondsToSelector:@selector(xy_keyboardWillShowWithKeyboardHeight:)]){
                [self.xy_delegate xy_keyboardWillShowWithKeyboardHeight:xy_emotionKeyboarH];
            }
            self.xy_textView.layoutManager.allowsNonContiguousLayout = NO;
            [self.xy_textView scrollRectToVisible:CGRectMake(0, _xy_textView.contentSize.height - xy_textViewH, _xy_textView.contentSize.width, xy_textViewH) animated:YES];
        }
    }
    
}

- (void)xy_sendMessage{
    [self xy_keyboardResignFirstResponder];
    if (![_xy_textView.text isEqualToString:@""]) {
        NSLog(@"xy_发送的文本:%@",_xy_textView.text);
        if ([_xy_delegate respondsToSelector:@selector(xy_getMessage:)]) {
            [_xy_delegate xy_getMessage:_xy_textView.text];
        }
        _xy_textView.text = nil;
    }
}

@end
