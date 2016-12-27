//
//  LVKEYBOARDCONFIG.h
//  MeetU
//
//  Created by LV on 16/7/28.
//  Copyright © 2016年 cryboy. All rights reserved.
//

#define xy_width [UIScreen mainScreen].bounds.size.width
#define xy_height [UIScreen mainScreen].bounds.size.height
#define xy(number) ([UIScreen mainScreen].bounds.size.width/320.00f *(number))
#define xy_commentBoxH xy(49)
#define xy_textViewH xy(39)
#define xy_textViewW xy_width - xy(5)*3 - xy_textViewH
#define xy_emotionBtnW xy_textViewH
#define xy_leftDistance xy(5)
#define xy_textViewFont xy(16)
#define xy_emotionKeyboarH xy(216)
#define xy_padding xy(5)
#define xy_grayColor [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00]
#define xy_placeholderColor [UIColor colorWithRed:0.71 green:0.72 blue:0.72 alpha:1.00]












