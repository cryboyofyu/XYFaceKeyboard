//
//  XYPageControl.m
//  XYFaceKeyboardExample
//
//  Created by XY Lv on 16/12/20.
//  Copyright © 2016年 吕欣宇. All rights reserved.
//

#import "XYPageControl.h"

@implementation XYPageControl

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
    }
    return self;
}

- (void)xy_updateDots{
    for(int i=0;i< self.subviews.count;i++){
        UIImageView * xyDot = [self.subviews objectAtIndex:i];
        if(i==self.currentPage){
            if([xyDot isKindOfClass:[UIImageView class]]){
                xyDot.image = self.xy_selectedImg;
                xyDot.backgroundColor = [UIColor redColor];

            }else{
                xyDot.backgroundColor = [UIColor redColor];
            }
        }else{
            if([xyDot isKindOfClass:[UIImageView class]]){
                xyDot.image = self.xy_selectedImg;
                xyDot.backgroundColor = [UIColor lightGrayColor];

            }else{
                xyDot.backgroundColor = [UIColor lightGrayColor];
            }
        }
    }
}

- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    [self xy_updateDots];
}



@end

















































