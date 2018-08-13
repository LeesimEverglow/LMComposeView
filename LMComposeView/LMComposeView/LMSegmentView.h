//
//  LMSegmentView.h
//  LMComposeView
//
//  Created by Leesim on 2018/8/11.
//  Copyright © 2018年 LiMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMSegmentView : UIScrollView

/**
 初始化

 @param titleArray 每个分组的标题
 @param frame 坐标
 @return 返回segment
 */
- (instancetype)initWithTitleArray:(NSArray *)titleArray withFrame:(CGRect)frame;

/**
 点击每个分类按钮的代理
 */
@property (nonatomic,copy) void (^didSelectSegmentWithIndexBlock)(NSInteger index);

/**
 直接滚动到某个分类
 */
@property (nonatomic,assign) NSInteger  scrollViewToSegmentIndex;

@end
