//
//  PHBtnsBar.m
//  PersonalHealthHelper
//
//  Created by Dylan on 3/1/16.
//  Copyright © 2016 PH. All rights reserved.
//

#import "PHBtnsBar.h"
@interface PHBtnsBar()
@property (nonatomic,strong)NSMutableArray * btnArray;

@end
@implementation PHBtnsBar
-(NSMutableArray *)btnArray
{
    if (_btnArray==nil) {
        _btnArray=[NSMutableArray array];
    }
    return _btnArray;
}
-(void)setSelectNumber:(NSInteger)selectNumber
{
    _selectNumber=selectNumber;
    for (UIButton * btn in self.btnArray)
    {
        btn.selected=NO;
        btn.userInteractionEnabled=YES;
        if (btn.tag==selectNumber) {
            btn.selected=YES;
            btn.userInteractionEnabled=NO;
        }
    }
}
+(instancetype)btnsBarWithFrame:(CGRect)frame andNameArray:(NSArray *)nameArray
{
    PHBtnsBar * btnsBar=[[PHBtnsBar alloc]initWithFrame:frame];
    btnsBar.nameArray=nameArray;
    return btnsBar;
}
-(void)setNameArray:(NSArray *)nameArray
{
    _nameArray=nameArray;
    CGFloat btnW=[UIScreen mainScreen].bounds.size.width/nameArray.count;
    for (int i= 0;  i<nameArray.count; i++)
    {
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.btnArray addObject:btn];
        btn.frame=CGRectMake(i*btnW,0 ,btnW ,self.bounds.size.height);
        btn.tag=i;
        //btn样式
        [btn setTitle:self.nameArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        
        [self addSubview:btn];
        [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)btnTouch:(UIButton *)sender
{
    for (UIButton * btn in self.btnArray)
    {
        btn.selected=NO;
        btn.userInteractionEnabled=YES;
    }
    sender.selected=YES;
    sender.userInteractionEnabled=NO;
    if (self.delegate)
    {
        [self.delegate phBtnBar:self btnTouchWihtTag:sender.tag];
    }
    NSLog(@"首页点击了顶部工具栏第%ld个按钮",sender.tag);
}

@end
