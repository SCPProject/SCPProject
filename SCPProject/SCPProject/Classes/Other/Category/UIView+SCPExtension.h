//
//  UIView+SCPExtension.h
//  SCPProject
//
//  Created by 刘蒲艳 on 15/8/24.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SCPExtension)
/**
 *  高度
 */
@property (nonatomic,assign) CGFloat scp_height;

/**
 *  宽度
 */
@property (nonatomic,assign) CGFloat scp_width;

/**
 *  x
 */
@property (nonatomic,assign) CGFloat scp_x;

/**
 *  y
 */
@property (nonatomic,assign) CGFloat scp_y;

/**
 * 中心点X
 */
@property (nonatomic,assign) CGFloat scp_centerX;

/**
 * 中心点y
 */
@property (nonatomic,assign) CGFloat scp_centerY;

/**
 *  尺寸
 */
@property (nonatomic,assign) CGSize scp_size;

/**
 * 是否在当前窗口显示
 */
+ (BOOL)isShowOnKeyWindow:(UIView *)view;

/**
 * 从XIB加载
 */
+ (instancetype)viewFromXib;
@end
