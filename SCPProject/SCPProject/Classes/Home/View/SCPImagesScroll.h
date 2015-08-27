//
//  PYImages.h
//  02-图片滚动
//
//  Created by 刘蒲艳 on 15/5/29.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCPImagesScroll : UIView
// 保存图片
@property (nonatomic,strong) NSArray *imagesArray;

/** 分页的圆点其他颜色 */
@property (nonatomic,strong) UIColor *otherColor;

/** 分页的圆点当前颜色 */
@property (nonatomic,strong) UIColor *currentColor;

/** 设置一个过时的属性 */
@property (nonatomic,strong) UIColor *delColor NS_DEPRECATED_IOS(2_0,6_0);

+ (instancetype)images;
@end
