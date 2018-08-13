//
//  LMHeaderView.m
//  LMComposeView
//
//  Created by Leesim on 2018/8/13.
//  Copyright © 2018年 LiMing. All rights reserved.
//

#import "LMHeaderView.h"


@interface LMHeaderView ()

@property (nonatomic,strong) UIButton * titleButton;

@end

@implementation LMHeaderView

- (void)layoutSubviews{
    
    self.backgroundColor = [UIColor blueColor];
    self.titleButton.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
}

-(void)titleButtonAction:(UIButton*)button{
    button.selected = !button.selected;
}

-(UIButton *)titleButton{
    if (!_titleButton) {
        _titleButton = [[UIButton alloc]init];
        _titleButton.bounds = CGRectMake(0, 0, 100, 50);
        [_titleButton setTitle:@"默认标题" forState:UIControlStateNormal];
        [_titleButton setTitle:@"选中标题" forState:UIControlStateSelected];
        _titleButton.backgroundColor = [UIColor yellowColor];
        [_titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_titleButton addTarget:self action:@selector(titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_titleButton];
    }
    return _titleButton;
}

//当touch的pints在视图的子视图时，返回子视图，否则将事件透传到下面的视图
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitTestView = [super hitTest:point withEvent:event];
    if (hitTestView == self) {
        hitTestView = nil;
    }
    return hitTestView;
}


@end
