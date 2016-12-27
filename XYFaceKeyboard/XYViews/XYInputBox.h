//
//  XYInputBox.h
//  XYFaceKeyboardExample
//
//  Created by XY Lv on 16/12/20.
//  Copyright © 2016年 吕欣宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYFaceKeyboard.h"

@interface XYInputBox : UIView<UITextViewDelegate>


@property (nonatomic,strong)UITextView  * xy_textView;
@property (nonatomic,strong)UILabel     * xy_placeholderLabel;
@property (nonatomic,strong)UIButton    * xy_sendBtn;
@property (nonatomic,strong)UIButton    * xy_toFaceBtn;
@property (nonatomic,strong)XYFaceKeyboard * xy_faceKeyboard;

@property (nonatomic,assign)BOOL          xy_isKeyboardShow;
@property (nonatomic,strong)UIView      * xy_bgView;
@property (nonatomic,assign)id            xy_delegate;

- (instancetype)initWithFrame:(CGRect)frame withBgView:(UIView *)bgView;
- (void)xy_createInputBox;
- (void)xy_keyboardResignFirstResponder;
- (void)xy_textViewBegainEdit;
@end

@protocol XYMessageDelegate <NSObject>

- (void)xy_getMessage:(NSString *)message;

@optional
- (void)xy_keyboardWillShowWithKeyboardHeight:(CGFloat)height;



@end










































