//
//  ViewController.m
//  XYFaceKeyboardExample
//
//  Created by XY Lv on 16/12/20.
//  Copyright © 2016年 吕欣宇. All rights reserved.
//

#import "ViewController.h"
#import "XYInputBox.h"
#import "XYKEYBOARDCONFIG.h"
#import <YYTextView.h>
#import "UIButton+XYButton.h"
@interface ViewController ()<XYMessageDelegate>
{
    XYInputBox * _xyInputBox;
    YYTextView * _xyTextView;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self xy_layoutTextView];
    [self xy_layoutInputBox];
    
}

- (void)xy_layoutInputBox{
    
    _xyInputBox = [[XYInputBox alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - xy_commentBoxH,xy_width, xy_commentBoxH) withBgView:self.view];
    _xyInputBox.backgroundColor = xy_grayColor;
    _xyInputBox.xy_delegate = self;
    _xyInputBox.xy_placeholderLabel.text = @"~欣宇最帅~";
    _xyInputBox.xy_placeholderLabel.textColor = xy_placeholderColor;
    _xyInputBox.xy_faceKeyboard.xy_categoryNormalMArr = [NSMutableArray arrayWithArray:@[@"默认",@"欣宇",@"最帅",@"最帅"]];
    _xyInputBox.xy_faceKeyboard.xy_categorySelectedMArr = [NSMutableArray arrayWithArray:@[@"默认",@"github",@"点赞",@"酷毙"]];
    [_xyInputBox xy_createInputBox];

}

- (void)xy_layoutTextView{
    _xyTextView = [[YYTextView alloc]initWithFrame:CGRectMake(10, 20, xy_width - 20, 150)];
    _xyTextView.editable = NO;
    _xyTextView.backgroundColor = xy_grayColor;
    [self.view addSubview:_xyTextView];
    
}

#pragma mark-xy -代理
- (void)xy_getMessage:(NSString *)message{
    [_xyInputBox xy_keyboardResignFirstResponder];
    _xyTextView.attributedText = [message xy_dealTheMessage];
    NSLog(@"发出的消息:%@",message);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


















