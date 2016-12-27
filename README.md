# XYFaceKeyboard
 自定义动态表情键盘（方便，低耦合，可以自己增加动态表情）
 ===
 <br>个人邮箱：892569921@qq.com [我的CSDN](http://blog.csdn.net/cry__boy):http://blog.csdn.net/cry__boy <br/>
<br>添加方法：cocoapods<br/>
<br>pod 'XYFaceKeyboard'</br>
<br>1.方法<br/>
```objective-c
_xyInputBox = [[XYInputBox alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - xy_commentBoxH,xy_width, xy_commentBoxH) withBgView:self.view];
    _xyInputBox.backgroundColor = xy_grayColor;
    _xyInputBox.xy_delegate = self;
    _xyInputBox.xy_placeholderLabel.text = @"~欣宇最帅~";
    _xyInputBox.xy_placeholderLabel.textColor = xy_placeholderColor;
    _xyInputBox.xy_faceKeyboard.xy_categoryNormalMArr = [NSMutableArray arrayWithArray:@[@"默认",@"欣宇",@"最帅",@"帽兵"]];
    _xyInputBox.xy_faceKeyboard.xy_categorySelectedMArr = [NSMutableArray arrayWithArray:@[@"默认",@"欣宇",@"最帅",@"帽兵"]];
    [_xyInputBox xy_createInputBox];
    ```
    <br>2.发送文本回调</br>
    代理方法
    ```objective-c
    - (void)xy_getMessage:(NSString *)message{
    [_xyInputBox xy_keyboardResignFirstResponder];
    _xyTextView.attributedText = [message xy_dealTheMessage];
    NSLog(@"发出的消息:%@",message);
    
}
    ```
<br>**欢迎大家提意见，一起交流学习，会根据大家的反馈及时更新。谢谢！**<br/>
<br>**如果小弟的一点点薄力可以给大家带来便利，小弟三生有幸！会再接再厉！您的支持就是我的动力！**<br/>
<br>**还有《自定义表情键盘》《自定义九宫格》，都非常不错哦，感兴趣的要关注哦！**<br/>
