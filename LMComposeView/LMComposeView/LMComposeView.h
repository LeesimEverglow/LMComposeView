//
//  LMComposeView.h
//  LMComposeView
//
//  Created by Leesim on 2018/8/7.
//  Copyright © 2018年 LiMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LMComposeViewDelegate<NSObject>

-(void)composeViewDidClickSegementButtonWithIndex:(NSInteger)index;

@end

@interface LMComposeView : UIView

@property (nonatomic,weak) id <LMComposeViewDelegate>delegate;


/**
 布局复合View

 @param scrollViewArray 滚动视图的数组
 @param titleArray 分类标题字符串数组
 @param headerView 顶部公用的headerView
 @param composeViewFrame 组合空间的frame
 */
-(void)confirmComposeViewWithScrollViewArray:(NSArray *)scrollViewArray withSegmentButtonTitleArray:(NSArray*)titleArray withHeaderView:(UIView *)headerView withComposeViewFrame:(CGRect)composeViewFrame;


@end
