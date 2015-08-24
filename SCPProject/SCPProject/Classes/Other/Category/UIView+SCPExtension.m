//
//  UIView+SCPExtension.m
//  SCPProject
//
//  Created by 刘蒲艳 on 15/8/24.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "UIView+SCPExtension.h"

@implementation UIView (SCPExtension)

- (void)setScp_width:(CGFloat)scp_width
{
    CGRect frame = self.frame;
    frame.size.width = scp_width;
    self.frame = frame;
}

- (CGFloat)scp_width
{
    return self.frame.size.width;
}

- (void)setScp_height:(CGFloat)scp_height
{
    CGRect frame = self.frame;
    frame.size.height = scp_height;
    self.frame = frame;
}

- (CGFloat)scp_height
{
    return self.frame.size.height;
}

- (void)setScp_x:(CGFloat)scp_x
{
    CGRect frame = self.frame;
    frame.origin.x = scp_x;
    self.frame = frame;
}

- (CGFloat)scp_x
{
    return self.frame.origin.x;
}

- (void)setScp_y:(CGFloat)scp_y
{
    CGRect frame = self.frame;
    frame.origin.y = scp_y;
    self.frame = frame;
}

- (CGFloat)scp_y
{
    return self.frame.origin.y;
}

- (void)setScp_centerX:(CGFloat)scp_centerX
{
    CGPoint center = self.center;
    center.x = scp_centerX;
    self.center = center;
}

-(CGFloat)scp_centerX
{
    return self.center.x;
}

- (void)setScp_centerY:(CGFloat)scp_centerY
{
    CGPoint center = self.center;
    center.y = scp_centerY;
    self.center = center;
}

- (CGFloat)scp_centerY
{
    return self.center.y;
}

- (void)setScp_size:(CGSize)scp_size
{
    CGRect frame = self.frame;
    frame.size = scp_size;
    self.frame = frame;
}

- (CGSize)scp_size
{
    return self.frame.size;
}

+ (BOOL)isShowOnKeyWindow:(UIView *)view
{
    // 将当前View的坐标系转换为窗口坐标系
    // 第二个参数如果写nil，表示的也是UIWindow
    //        CGPoint windowP = [subView convertPoint:subView.frame.origin toView:[UIApplication sharedApplication].keyWindow];
    // 将控件在父控件的坐标系转换为在主窗口的坐标系
    
    // 判断两个矩形是否相交
    //        CGRectIntersectsRect(<#CGRect rect1#>, <#CGRect rect2#>)
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    CGRect windowRect = window.bounds;
    CGRect newRect = [view.superview convertRect:view.frame toView:window];
    return view.window == window && !view.hidden && view.alpha > 0.01 && CGRectIntersectsRect(windowRect, newRect);
}

+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
