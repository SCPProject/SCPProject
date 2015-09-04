//
//  SCPSale.h
//  SCPProject
//
//  Created by 韩辉 on 15/9/4.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCPSale : NSObject

/** 图片 */
@property(nonatomic, copy)NSString *thumb;
/** 宽 */
@property (nonatomic, assign) CGFloat width;
/** 高 */
@property (nonatomic, assign) CGFloat height;
/** linkageid */
@property (nonatomic, copy) NSString *title;
/** ID */
@property (nonatomic, assign) NSInteger ID;


@end
