# XYFaceKeyboard
自定义动态表情键盘（简单，低耦合，可以更换动态表情）
===
 <br>个人邮箱：892569921@qq.com [我的CSDN](http://blog.csdn.net/cry__boy):http://blog.csdn.net/cry__boy <br/>
 <br>QQ技术群:549943887</br>
<br>添加方法：cocoapods<br/>
<br>pod 'XYFaceKeyboard'</br>
<br>效果</br>
![image](https://github.com/cryboyofyu/XYFaceKeyboard/blob/master/XYFaceKeyboardExample/XYShowImage/XYFaceShow1.gif)   
![image](https://github.com/cryboyofyu/XYFaceKeyboard/blob/master/XYFaceKeyboardExample/XYShowImage/XYFaceShow2.gif)
<br>**1.可以自定义更换表情,更改plist文件即可**</br>
<br>**2.可以自定义表情类别title**</br>
<br>**3.可以输入框文字自动滚动**</br>
<br>**4.可以自定义placeholder,及背景样式**</br>
<br>1.方法<br/>
```objective-c
_xyInputBox = [[XYInputBox alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - xy_commentBoxH,xy_width, xy_commentBoxH) withBgView:self.view];
    _xyInputBox.backgroundColor = xy_grayColor;
    _xyInputBox.xy_delegate = self;
    _xyInputBox.xy_placeholderLabel.text = @"~欣宇最帅~";
    _xyInputBox.xy_placeholderLabel.textColor = xy_placeholderColor;
    _xyInputBox.xy_faceKeyboard.xy_categoryNormalMArr = [NSMutableArray arrayWithArray:@[@"默认",@"欣宇",@"最帅",@"最帅"]];
    _xyInputBox.xy_faceKeyboard.xy_categorySelectedMArr = [NSMutableArray arrayWithArray:@[@"默认",@"github",@"点赞",@"酷毙"]];
    [_xyInputBox xy_createInputBox];
    2.发送文本回调
    代理方法
    - (void)xy_getMessage:(NSString *)message{
    [_xyInputBox xy_keyboardResignFirstResponder];
    _xyTextView.attributedText = [message xy_dealTheMessage];
    NSLog(@"发出的消息:%@",message);
 ```   
}
    
<br>**欢迎大家提意见，一起交流学习，会根据大家的反馈及时更新。谢谢！别忘了给个星哦~**<br/>
<br>**如果小弟的一点点薄力可以给大家带来便利，小弟三生有幸！会再接再厉！您的支持就是我的动力！**<br/>
<br>**还有《高仿微信群组页面》《自定义九宫格》《高仿微博首页》《消息角标》，都非常不错哦，感兴趣的要关注哦！**<br/>
