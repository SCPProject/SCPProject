//
//  UIImageView+SCPExtension.h
//  SCPProject
//
//  Created by 刘蒲艳 on 15/8/25.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SCPExtension)

// 根据传入的URL获取图片
- (void)imageWithURLString:(NSString *)urlStr;
@end
