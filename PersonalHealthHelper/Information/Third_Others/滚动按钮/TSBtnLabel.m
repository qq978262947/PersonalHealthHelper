//
//  TSBtnLabel.m
//  新浪新闻联系
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 TS. All rights reserved.
//

#import "TSBtnLabel.h"

@implementation TSBtnLabel

-(void)setNameArray:(NSArray *)nameArray
{
    int i = 0;
    int j = 4;
    
    for (NSString * title in nameArray)
    {
        UIButton * btn=[[UIButton alloc]init];
        [btn setTitle:title forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        CGFloat btnW=80;
        CGFloat btnX=10*(i%j+1)+btnW*(i%j);
        CGFloat btnY=50*(i/j);
        CGFloat btnH=40;
        
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);

        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        [self.backView addSubview:btn];
         btn.tag=i;
        NSLog(@"%ld",btn.tag);
        [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
        i++;
        [self.btnArray addObject:btn];

    }
    _nameArray=nameArray;
}
-(NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray =[NSMutableArray array];
    }
    return _btnArray;
}
-(void)setPageNow:(NSInteger)pageNow
{
    for (UIButton * allBtn in self.btnArray) {
        allBtn.selected=NO;
        allBtn.userInteractionEnabled=YES;
        
        if (allBtn.tag==pageNow)
        {
            allBtn.selected=YES;
            allBtn.userInteractionEnabled=NO;
        }
    }
}

-(void)btnTouch:(UIButton *)btn
{

    self.pageNow=btn.tag;
    if (self.delegate!=nil)
    {
        [self.delegate TSBtnLabelBtnTouch:btn];
    }
    [self removeFromSuperview];

}

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
       
        UIView * backgoudnView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 667)];
        backgoudnView.backgroundColor=[UIColor darkGrayColor];
        [self addSubview:backgoudnView];
        [self bringSubviewToFront:backgoudnView];
        backgoudnView.alpha=0.7;
        
        
        
        UIView * backView=[[UIView alloc]initWithFrame:CGRectMake(0, 94, 375, 200)];
        [self addSubview:backView];
         backView.backgroundColor=[UIColor yellowColor];
        self.backView=backView;
    }
    return self;
}

@end
