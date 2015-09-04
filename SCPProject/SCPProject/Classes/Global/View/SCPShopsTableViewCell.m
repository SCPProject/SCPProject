//
//  SCPShopsTableViewCell.m
//  SCPProject
//
//  Created by 韩辉 on 15/9/2.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import "SCPShopsTableViewCell.h"
#import "SCPAsia.h"
#import <UIImageView+WebCache.h>

@interface SCPShopsTableViewCell()

// cell背景图片
@property (weak, nonatomic) IBOutlet UIImageView *scpImageView;


@end

@implementation SCPShopsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setAsia:(SCPAsia *)asia
{
      _asia = asia;
    [self.scpImageView sd_setImageWithURL:[NSURL URLWithString:asia.thumb] placeholderImage:[UIImage imageNamed:@"empty_bg"]];
    }


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
