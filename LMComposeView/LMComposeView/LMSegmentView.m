//
//  LMSegmentView.m
//  LMComposeView
//
//  Created by Leesim on 2018/8/11.
//  Copyright © 2018年 LiMing. All rights reserved.
//

#import "LMSegmentView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface LMSegmentView ()

@property (nonatomic,strong) NSArray * titleArray;

@property (nonatomic,strong) UIView * selectView;

@end

@implementation LMSegmentView

- (instancetype)initWithTitleArray:(NSArray *)titleArray withFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.frame = frame;
        self.titleArray = titleArray;
        
        
        [self confirmUI];
        
    }
    return self;
}

-(void)confirmUI{
    
    CGFloat width = SCREEN_WIDTH/self.titleArray.count;
    
    if (width<SCREEN_WIDTH/4) {
        width = (SCREEN_WIDTH+SCREEN_WIDTH/4)/4;
    }
    
    for (int i = 0; i < self.titleArray.count; i++) {
        UIButton * button  =[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(i*width, 0, width, self.bounds.size.height);
        button.tag = 5000+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        self.contentSize = CGSizeMake(CGRectGetMaxX(button.frame), button.bounds.size.height);
        
        if (i == self.titleArray.count-1) {
            self.selectView.frame = CGRectMake(0, button.frame.size.height-2, button.bounds.size.width, 2);
        }
    }
}


-(void)buttonClick:(UIButton *)button{
    [self scrollButtonSelectededCenter:button];
    if (self.didSelectSegmentWithIndexBlock) {
        self.didSelectSegmentWithIndexBlock(button.tag%5000);
    }
}

-(void)setScrollViewToSegmentIndex:(NSInteger)scrollViewToSegmentIndex{
    _scrollViewToSegmentIndex = scrollViewToSegmentIndex;
    [self scrollButtonSelectededCenter:self.subviews[scrollViewToSegmentIndex]];
}

/** 滚动标题选中居中 */
- (void)scrollButtonSelectededCenter:(UIButton *)button {
    //动画移动标示
    [UIView animateWithDuration:0.2 animations:^{
        self.selectView.frame = CGRectMake(button.frame.origin.x, self.selectView.frame.origin.y, self.selectView.frame.size.width, self.selectView.frame.size.height);
    }];
    // 计算偏移量
    CGFloat offsetX = button.center.x - SCREEN_WIDTH * 0.5;
    if (offsetX < 0) offsetX = 0;
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.contentSize.width - SCREEN_WIDTH;
    
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    // 滚动标题滚动条
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}


-(UIView *)selectView{
    if (!_selectView) {
        _selectView = [[UIView alloc]init];
        _selectView.backgroundColor = [UIColor purpleColor];
        [self addSubview:_selectView];
    }
    return _selectView;
}

@end
