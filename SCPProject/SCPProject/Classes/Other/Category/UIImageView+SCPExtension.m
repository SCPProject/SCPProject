//
//  UIImageView+SCPExtension.m
//  SCPProject
//
//  Created by 刘蒲艳 on 15/8/25.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import "UIImageView+SCPExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (SCPExtension)


// 根据传入的URL获取图片
- (void)imageWithURLString:(NSString *)urlStr
{
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"mrbg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
}
@end
