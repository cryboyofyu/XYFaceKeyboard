//
//  XYFaceKeyboard.m
//  XYFaceKeyboardExample
//
//  Created by XY Lv on 16/12/20.
//  Copyright © 2016年 吕欣宇. All rights reserved.
//

#import "XYFaceKeyboard.h"
#import "UIButton+XYButton.h"
#import "XYKEYBOARDCONFIG.h"
#import "XYPageControl.h"
#define FACE_NAME_HEAD  @"["
#pragma mark-lv - 表情转义字符的长度（ /s占2个长度，xxx占3个长度，共5个长度 ）
#define FACE_NAME_LEN   5
#define FACE_COUNT_ALL  54
#define LTFACE_COUNT_ALL  56
#define HZFACE_COUNT_ALL  47

#define PBFACE_COUNT_ALL  54
#define XFACE_COUNT_ALL  43

#define FACE_COUNT_ROW  4

#define FACE_COUNT_CLU  7

#define FACE_COUNT_PAGE ( FACE_COUNT_ROW * FACE_COUNT_CLU )

#define FACE_ICON_SIZE  44*(xy_width/320.0)

#define FACESize 30*(xy_width/320.0)
@implementation XYFaceKeyboard
{
    UIScrollView * _xyScrollView;
    NSMutableArray * _xyOtherImgMArr;
    UIScrollView * _xyFaceScrollView;
    XYPageControl * _xyPageControl;
    NSDictionary * _xyFace0Dic;
    NSDictionary * _xyFace1Dic;
    NSDictionary * _xyFace2Dic;
    NSDictionary * _xyFace3Dic;

}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        [self xy_initDataMArr];
        [self xy_layoutFaceCategoryBtnsWithNormalMArr:_xy_categoryNormalMArr withSelectedMArr:_xy_categorySelectedMArr];
        [self xy_layoutBgScrollView];
        [self xy_layoutPageControl];
        [self xy_layoutKeyboardDeleteBtn];
        
        [self xy_layoutScrollCategoryBtnsWithPageTag:1000 withDataDic:_xyFace0Dic];
    }
    return self;
}

- (void)xy_initDataMArr{
    self.xy_faceCategoryBtnsMArr = [[NSMutableArray alloc]init];
    _xy_categoryNormalMArr = [[NSMutableArray alloc]init];
    _xy_categorySelectedMArr = [[NSMutableArray alloc]init];
    _xy_categoryTitleColor_normalMArr = [[NSMutableArray alloc]init];
    _xy_categoryTitleColor_selectedMArr = [[NSMutableArray alloc]init];
    for(int i=0;i<4;i++){
        [_xy_categoryNormalMArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"xyBtn%d",i]]];
        [_xy_categorySelectedMArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"xyBtnSelected%d",i]]];
        
    }
    _xyFace0Dic = [NSDictionary dictionaryWithContentsOfFile:
                   [[NSBundle mainBundle] pathForResource:@"XYFace0"
                                                   ofType:@"plist"]];
    _xyFace1Dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"XYFace1" ofType:@"plist"]];
    _xyFace2Dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"XYFace2" ofType:@"plist"]];
    _xyFace3Dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"XYFace3" ofType:@"plist"]];

}

- (void)xy_reloadFaceKeyboard{
    for(UIButton * btn in self.xy_faceCategoryBtnsMArr){
        [btn removeFromSuperview];
    }
    [self xy_layoutFaceCategoryBtnsWithNormalMArr:_xy_categoryNormalMArr withSelectedMArr:_xy_categorySelectedMArr];
}

- (void)xy_layoutFaceCategoryBtnsWithNormalMArr:(NSMutableArray *)normalMArr withSelectedMArr:(NSMutableArray *)selectedMArr{
    double xyBtnWidth = xy_width/normalMArr.count;
    for(int i=0;i<normalMArr.count;i++){
        UIButton * itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        id object = [normalMArr objectAtIndex:i];
        id selectObject = [selectedMArr objectAtIndex:i];
        if([object isKindOfClass:[UIImage class]]){
            [itemBtn setBackgroundImage:[normalMArr objectAtIndex:i] forState:UIControlStateNormal];
            [itemBtn setBackgroundImage:[selectedMArr objectAtIndex:i] forState:UIControlStateSelected];

        }else if([object isKindOfClass:[NSString class]]){
            [itemBtn setTitle:object forState:UIControlStateNormal];
            [itemBtn setTitle:selectObject forState:UIControlStateSelected];
            if(_xy_categoryTitleColor_normalMArr.count == normalMArr.count){
                [itemBtn setTitleColor:[_xy_categoryTitleColor_normalMArr objectAtIndex:i] forState:UIControlStateNormal];
                [itemBtn setTitleColor:[_xy_categoryTitleColor_selectedMArr objectAtIndex:i] forState:UIControlStateSelected];
            }else{
                [itemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [itemBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

            }
           
        }
        if(i==0){
            itemBtn.selected = YES;
        }
        [itemBtn addTarget:self action:@selector(xyItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn.tag = i;
        itemBtn.frame = CGRectMake(i * xyBtnWidth, 210, xyBtnWidth, 40);
        [self addSubview:itemBtn];
        [self.xy_faceCategoryBtnsMArr addObject: itemBtn];
        
    }
}

- (void)xy_layoutBgScrollView{
    if(!_xyScrollView){
        _xyScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, xy_width, 190)];
        _xyScrollView.pagingEnabled = YES;
        _xyScrollView.showsHorizontalScrollIndicator = NO;
        _xyScrollView.showsVerticalScrollIndicator = NO;
        _xyScrollView.delegate = self;
        [self addSubview:_xyScrollView];
    }
}

- (void)xy_layoutPageControl{
    _xyPageControl = [[XYPageControl alloc]initWithFrame:CGRectMake((xy_width - 100)/2.0, 190, 100, 20)];
    [_xyPageControl addTarget:self action:@selector(xyPageClick:) forControlEvents:UIControlEventValueChanged];
    _xyPageControl.userInteractionEnabled = YES;
    _xyPageControl.numberOfPages = 1;
    _xyPageControl.currentPage = 0;
    [self addSubview:_xyPageControl];
}

- (void)xy_layoutKeyboardDeleteBtn{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"del_emoji_normal"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"del_emoji_select"] forState:UIControlStateSelected];
    [backBtn addTarget:self action:@selector(xyBackFace) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(xy_width-48, 182, 38, 28);//320-272
    [self addSubview:backBtn];
}

- (void)xy_layoutScrollCategoryBtnsWithPageTag:(int)tag withDataDic:(NSDictionary *)dataDic{
    NSArray *array = [dataDic allKeys];
    
    _xyScrollView.tag = tag;
    _xyScrollView.contentSize = CGSizeMake((array.count / FACE_COUNT_PAGE+1 ) * xy_width, 190);
    _xyScrollView.contentOffset = CGPointMake(0, 0);

    [self xy_layoutFaceBtnsWithCount:array.count withTag:tag withFaceDataDic:dataDic];

}

- (void)xy_layoutFaceBtnsWithCount:(NSInteger)count withTag:(int)tag withFaceDataDic:(NSDictionary *)dataDic{
    
            if(tag==2000){
            for (int i = 0; i < count; i++) {
                
            UIButton *xyFaceButton = [UIButton buttonWithType:UIButtonTypeCustom];

            xyFaceButton.tag = i+tag+1000;
            [xyFaceButton addTarget:self
                           action:@selector(sendOtherImg:)
                 forControlEvents:UIControlEventTouchUpInside];
            CGFloat x = xy_width/2.0;
            xyFaceButton.frame = CGRectMake(((i+1)%2)*x+10, (20+20)*((i-1)/2)+20, x-20, 20);
                NSArray *array = [dataDic allKeys];
                NSArray *nameArr = [dataDic allValues];
                [xyFaceButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",array[i]]] forState:UIControlStateNormal];
                                
            xyFaceButton.xy_btnBgImgName = nameArr[i];
           [_xyScrollView addSubview:xyFaceButton];

            }
        }else{
            for (int i = 0; i < count; i++) {
                
            UIButton *xyFaceButton = [UIButton buttonWithType:UIButtonTypeCustom];
            xyFaceButton.tag = i+tag+1000;
            [xyFaceButton addTarget:self
                           action:@selector(xyFaceButtonClick:)
                 forControlEvents:UIControlEventTouchUpInside];
            
#pragma mark-lv -计算每一个表情按钮的坐标和在哪一屏
            CGFloat x = ((i % FACE_COUNT_PAGE) % FACE_COUNT_CLU) * FACE_ICON_SIZE + 6 + (i / FACE_COUNT_PAGE * xy_width);
                
            CGFloat y = ((i % FACE_COUNT_PAGE) / FACE_COUNT_CLU) * 44 + 8;
            xyFaceButton.frame = CGRectMake( x+(FACE_ICON_SIZE-FACESize)/2.0, y+(FACE_ICON_SIZE-FACESize)/2.0, FACESize, FACESize);
            
            NSArray *array = [dataDic allKeys];
            NSArray *nameArr = [dataDic allValues];
            
            [xyFaceButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", array[i]]]
                        forState:UIControlStateNormal];
            xyFaceButton.xy_btnBgImgName = nameArr[i];
                [_xyScrollView addSubview:xyFaceButton];

         }
        }
    

}

#pragma mark-lv ---------------------代理位置-------------------------------------------
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"----%ld",(long)scrollView.tag);
    [_xyPageControl setCurrentPage:_xyScrollView.contentOffset.x /xy_width];
    [_xyPageControl updateCurrentPageDisplay];
    
}

#pragma mark-lv ---------------------响应事件位置-----------------------------------------
- (void)sendOtherImg:(UIButton *)sender{
    
    
#pragma mark-lv -后加
    self.xy_inputTextView.text = [self.xy_inputTextView.text stringByAppendingString:sender.xy_btnBgImgName];
}

- (void)xyItemBtnClick:(UIButton *)sender{
    for (UIButton *xyItemBtn in self.xy_faceCategoryBtnsMArr)
    {
        xyItemBtn.selected = NO;
    }
    sender.selected = YES;
    for (UIButton *btn in _xyScrollView.subviews) {
        [btn removeFromSuperview];
        
    }
    
    switch (sender.tag)
    {
        case 0:
            [self xy_layoutScrollCategoryBtnsWithPageTag:1000 withDataDic:_xyFace0Dic];
            _xyPageControl.numberOfPages = [_xyFace0Dic allKeys].count / FACE_COUNT_PAGE+1 ;
            break;
        case 1:
            [self xy_layoutScrollCategoryBtnsWithPageTag:2000 withDataDic:_xyFace1Dic];
            _xyPageControl.numberOfPages = 7 / FACE_COUNT_PAGE +1;
            break;
        case 2:
            
            [self xy_layoutScrollCategoryBtnsWithPageTag:3000 withDataDic:_xyFace2Dic];
            _xyPageControl.numberOfPages = [_xyFace2Dic allKeys].count / FACE_COUNT_PAGE+1 ;

            break;
        case 3:
            [self xy_layoutScrollCategoryBtnsWithPageTag:4000 withDataDic:_xyFace3Dic];
            _xyPageControl.numberOfPages = [_xyFace3Dic allKeys].count / FACE_COUNT_PAGE +1;
            break;
        default:
            break;
            
    }
    [_xyPageControl setCurrentPage:0];
}

- (void)xyPageClick:(id)sender{
    [_xyFaceScrollView  setContentOffset:CGPointMake(_xyPageControl.currentPage * 320,0) animated:YES];
    [_xyPageControl setCurrentPage:_xyPageControl.currentPage];
}

- (void)xyFaceButtonClick:(UIButton *)sender{
    if (self.xy_inputTextView) {
        NSMutableString *xyFaceString = [[NSMutableString alloc]initWithString:self.xy_inputTextView.text];
        [xyFaceString appendString:sender.xy_btnBgImgName];
        self.xy_inputTextView.text = xyFaceString;
        
    }
}

- (void)xyBackFace{
    NSString *inputString;
    inputString = self.xy_inputTF.text;
    if ( self.xy_inputTextView ) {
        
        inputString = self.xy_inputTextView.text;
    }
    
    if ( inputString.length ) {
        
        NSString *string = nil;
        NSInteger stringLength = inputString.length;
        
        NSRange range = [string rangeOfString:FACE_NAME_HEAD];
        if ( range.location == 0 ) {
            
            NSArray *array = [inputString componentsSeparatedByString:@"["];
            if (array.count >= 2)
            {
                string = [inputString substringToIndex:stringLength-[array[array.count-1] length]-1];
            }else
            {
                string = [inputString substringToIndex:stringLength - 1];
            }
            
        }
        else {
            
            string = [inputString substringToIndex:stringLength - 1];
        }
        
        
        if ( self.xy_inputTF ) {
            
            self.xy_inputTF.text = string;
        }
        
        if ( self.xy_inputTextView ) {
            
            self.xy_inputTextView.text = string;
            [self.xy_delegate xy_textViewDicChange:self.xy_inputTextView];
        }
    }

}


@end








































