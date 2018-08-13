
//
//  UIView+LMViewHelper.h
//  Owhat
//
//  Created by Leesim on 2018/5/1.
//  Copyright © 2018年 Owhat. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIView (LMViewHelper)
@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;
@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, assign) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;

@property (nonatomic, assign)CGFloat max_x;
@property (nonatomic, assign)CGFloat max_y;
@property (nonatomic, assign)CGFloat min_x;
@property (nonatomic, assign)CGFloat min_y;
/**
 *  水平居中
 */
- (void)alignHorizontal;
/**
 *  垂直居中
 */
- (void)alignVertical;

/**
 *  判断是否显示在主窗口上面
 *
 *  @return 是否
 */
- (BOOL)isShowOnWindow;



/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;
/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;


- (UIViewController *)getCurrentController;

@end
