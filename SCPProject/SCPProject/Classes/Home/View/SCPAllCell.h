//
//  SCPAllCell.h
//  SCPProject
//
//  Created by 刘蒲艳 on 15/8/24.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCPAllShopModel.h"

@interface SCPAllCell : UICollectionViewCell
/** model */
@property (nonatomic,strong) SCPAllShopModel *shopModel;

+ (instancetype)allCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@end
