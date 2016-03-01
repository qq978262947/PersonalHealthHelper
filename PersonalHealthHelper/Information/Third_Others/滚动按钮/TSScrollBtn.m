//
//  TSScrollBtn.m
//  TSScrollBtn
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 TS. All rights reserved.
//

#import "TSScrollBtn.h"
#import "TSBtnLabel.h"
@interface TSScrollBtn ()<TSBtnLabelDelegate>

@property (nonatomic,strong)UIScrollView * scrollView;

@property (nonatomic,strong)TSBtnLabel * btnLabel;

@property (nonatomic,strong)UIView * animationView;

@end

@implementation TSScrollBtn

-(void)setNameArray:(NSArray *)nameArray
{
    self.scrollView.contentSize=CGSizeMake(70*nameArray.count+10, 30);
    int i = 0;
    
    for (NSString * title in nameArray)
    {
        UIButton * btn=[[UIButton alloc]init];
        [btn setTitle:title forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        CGFloat btnW=60;
        CGFloat btnX=10*(i+1)+btnW*i;
        CGFloat btnY=0;
        CGFloat btnH=30;
        
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        [self.scrollView addSubview:btn];
        btn.tag=i;
        [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
        
        i++;
        [self.btnArray addObject:btn];
    }
    self.animationView=[[UIView alloc]initWithFrame:CGRectMake(10, self.frame.size.width-3, 60, 3)];
    [self.scrollView addSubview:self.animationView];
    self.animationView.backgroundColor=[UIColor redColor];
    [self.scrollView bringSubviewToFront:self.animationView];
    _nameArray=nameArray;
}
-(NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray =[NSMutableArray array];
    }
    return _btnArray;
}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self.backgroundColor=[UIColor whiteColor];
        UIScrollView * scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 325, self.frame.size.height)];
        [self addSubview: scrollView];
        self.scrollView=scrollView;
        scrollView.showsHorizontalScrollIndicator=NO;
        scrollView.showsVerticalScrollIndicator=NO;
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"showItemView"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"closeItemView"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(menuBtnTouch) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        self.menuBtn=btn;
        btn.frame=CGRectMake(325, 0, 50, 30);
    }
    return self;
}
-(void)setPageNow:(NSInteger)pageNow//通过这个方法从主控制器获得当前被选择的按钮序号
{
    for (UIButton * allBtn in self.btnArray)
    {
        allBtn.selected=NO;
        allBtn.userInteractionEnabled=YES;
        if (allBtn.tag==pageNow)
        {
            allBtn.selected=YES;
            allBtn.userInteractionEnabled=NO;
        }
    }
    _pageNow=pageNow;
    
    //小红线的移动,并且使得选中的按钮位与屏幕中间
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat x=10*(pageNow+1)+60*pageNow;
        self.animationView.frame=CGRectMake(x, self.frame.size.height-3, 60, 3) ;
    }];
    
    if (self.animationView.frame.origin.x>=self.frame.size.width/2)
    {
        [UIView animateWithDuration:0.5 animations:^{
            CGFloat x=self.animationView.frame.origin.x-(self.frame.size.width/2)+30;
            self.scrollView.contentOffset=CGPointMake(x, 0);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentOffset=CGPointMake(0, 0);
        }];
    }
}
-(void)menuBtnTouch//右侧按钮点击事件
{
    if(!self.menuBtn.selected)//如果是闭合状态，点击之后创建选择视图
    {
        TSBtnLabel * btnLable=[TSBtnLabel new];
        
        btnLable.frame=CGRectMake(0, 0, 375, 667);

        btnLable.nameArray=self.nameArray;
        btnLable.delegate=self;
        btnLable.pageNow=self.pageNow;
        NSLog(@"%ld",self.pageNow);
        [self.delegate TSScrollBtnMenuTouchGetView:btnLable];

        self.btnLabel=btnLable;
    }
    else//如果是展开状态，移除
    {
        [self.btnLabel removeFromSuperview];
    }
    self.menuBtn.selected=!self.menuBtn.selected;

}

-(void)btnTouch:(UIButton *)btn//通过点击事件对主控制器进行页数控制
{

    self.pageNow=btn.tag;
    NSLog(@"btn.tag:%ld",btn.tag);
    
    if (self.menuBtn.selected)
    {
        self.menuBtn.selected=NO;
        [self.btnLabel removeFromSuperview];
    }
    if (self.delegate)
    {
        [self.delegate TSScrollBtnTouchWithIndex:btn.tag];
    }
    
}
-(void)TSBtnLabelBtnTouch:(UIButton *)button
{
    [self btnTouch:button];
    NSLog(@"button.tag:%ld",button.tag);

}
@end
