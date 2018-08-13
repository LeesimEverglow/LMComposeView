//
//  UIView+LMViewHelper.m
//  Owhat
//
//  Created by Leesim on 2018/5/1.
//  Copyright © 2018年 Owhat. All rights reserved.
//

#import "UIView+LMViewHelper.h"

@implementation UIView (LMViewHelper)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

-(CGFloat)max_x{
    return CGRectGetMaxX(self.frame);
}
-(CGFloat)max_y{
    return CGRectGetMaxY(self.frame);
}
-(CGFloat)min_x{
    return CGRectGetMinX(self.frame);
}
-(CGFloat)min_y{
    return CGRectGetMinY(self.frame);
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame= frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}
- (void)alignHorizontal
{
    self.x = (self.superview.width - self.width) * 0.5;
}

- (void)alignVertical
{
    self.y = (self.superview.height - self.height) *0.5;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    
    if (borderWidth < 0) {
        return;
    }
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (BOOL)isShowOnWindow
{
    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //相对于父控件转换之后的rect
    CGRect newRect = [keyWindow convertRect:self.frame fromView:self.superview];
    //主窗口的bounds
    CGRect winBounds = keyWindow.bounds;
    //判断两个坐标系是否有交汇的地方，返回bool值
    BOOL isIntersects =  CGRectIntersectsRect(newRect, winBounds);
    if (self.hidden != YES && self.alpha >0.01 && self.window == keyWindow && isIntersects) {
        return YES;
    }else{
        return NO;
    }
}

- (CGFloat)borderWidth
{
    return self.borderWidth;
}

- (UIColor *)borderColor
{
    return self.borderColor;
    
}

- (CGFloat)cornerRadius
{
    return self.cornerRadius;
}

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

- (UIViewController *)getCurrentController
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}


@end
