//
//  SCPSaleTableViewCell.m
//  SCPProject
//
//  Created by 韩辉 on 15/9/4.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import "SCPSaleTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "SCPSale.h"
@interface SCPSaleTableViewCell()

//促销image
@property (weak, nonatomic) IBOutlet UIImageView *saleImageView;
//促销Lable
@property (weak, nonatomic) IBOutlet UILabel *saleLable;


@end
@implementation SCPSaleTableViewCell

- (void)setSale:(SCPSale *)sale
{
    _sale = sale;
    [self.saleImageView sd_setImageWithURL:[NSURL URLWithString:sale.thumb]];
    self.saleLable.text = sale.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
