//
//  XYFaceKeyboard.h
//  XYFaceKeyboardExample
//
//  Created by XY Lv on 16/12/20.
//  Copyright © 2016年 吕欣宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYFaceboardDelegate <NSObject>

@optional
- (void)xy_textViewDicChange:(UITextView *)textView;

@end

@interface XYFaceKeyboard : UIView<UIScrollViewDelegate>
@property (nonatomic,weak)id<XYFaceboardDelegate>xy_delegate;
@property (nonatomic,strong)UITextView * xy_inputTextView;
@property (nonatomic,strong)UITextField * xy_inputTF;
@property (nonatomic,copy)  void(^xySendFaceBlock)(NSString * str);
@property (nonatomic,strong)NSMutableArray * xy_faceCategoryBtnsMArr;
@property (nonatomic,strong)NSMutableArray * xy_categoryNormalMArr;//未选中：可加图片或文字
@property (nonatomic,strong)NSMutableArray * xy_categorySelectedMArr;//选中：可加图片或文字
@property (nonatomic,strong)NSMutableArray * xy_categoryTitleColor_normalMArr;//未选中文字颜色
@property (nonatomic,strong)NSMutableArray * xy_categoryTitleColor_selectedMArr;//选中文字颜色

- (void)xy_reloadFaceKeyboard;

@end



















