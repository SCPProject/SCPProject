//
//  SCPAllHeaderReusableView.h
//  SCPProject
//
//  Created by 刘蒲艳 on 15/8/25.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCPAllHeaderReusableView : UICollectionReusableView

/** imageArray */
@property (nonatomic,strong) NSArray *imageArray;

// 返回单元格的标识
+ (NSString *)scpAllHeaderID;

+ (instancetype)headerView:(UICollectionView *)collectionView atIndexPath:(nonnull NSIndexPath *)indexPath;
@end
