//
//  SCPAllCell.m
//  SCPProject
//
//  Created by 刘蒲艳 on 15/8/24.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "SCPAllCell.h"
#import "UIImageView+SCPExtension.h"

@interface SCPAllCell()
// cell中对应的图片
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
// cell中对应的标题
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
// 原价
@property (weak, nonatomic) IBOutlet UILabel *lblOldPrice;
// 分割线
@property (weak, nonatomic) IBOutlet UILabel *lblSeperator;
// 折扣
@property (weak, nonatomic) IBOutlet UILabel *lblDiscount;
// 现价
@property (weak, nonatomic) IBOutlet UILabel *lblNewPrice;
@end

@implementation SCPAllCell

+ (instancetype)allCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"allCell";
    SCPAllCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [SCPAllCell viewFromXib];
    }
    return cell;
}

- (void)awakeFromNib
{
}

- (void)setShopModel:(SCPAllShopModel *)shopModel
{
    _shopModel = shopModel;
    
    // 图片
    [self.iconImageView imageWithURLString:self.shopModel.thumb];
    // 标题
    self.lblTitle.text = self.shopModel.title;
    // 原价
    if(self.shopModel.yprice)
    {
        // 有原价
        self.lblOldPrice.text = [NSString stringWithFormat:@"￥%@",self.shopModel.yprice];
        self.lblSeperator.hidden = YES;
        self.lblDiscount.hidden = YES;
        self.lblNewPrice.textColor = [UIColor yellowColor];
        
        
        // 给原价添加删除线
        NSUInteger length = [self.lblOldPrice.text length];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.lblOldPrice.text];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:SCPColor(109, 109, 109) range:NSMakeRange(0, length)];
        [self.lblOldPrice setAttributedText:attri];
    }
    else
    {
        // 无原价
        self.lblOldPrice.text = @"";
        [self.lblOldPrice setAttributedText:nil];
        self.lblSeperator.hidden = NO;
        self.lblDiscount.hidden = NO;
        self.lblNewPrice.textColor = [UIColor whiteColor];
    }
    self.lblNewPrice.text = [NSString stringWithFormat:@"￥%@",self.shopModel.price];
    self.lblDiscount.text = [NSString stringWithFormat:@"%f折",self.shopModel.discount];
    
}
@end
