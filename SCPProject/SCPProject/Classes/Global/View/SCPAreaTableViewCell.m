//
//  SCPAreaTableViewCell.m
//  SCPProject
//
//  Created by 韩辉 on 15/9/4.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import "SCPAreaTableViewCell.h"
#import "SCPArea.h"
#import <UIImageView+WebCache.h>

@interface SCPAreaTableViewCell()

/** 店铺图片 */
@property (weak, nonatomic) IBOutlet UIImageView *shopImgeView;
/** 店铺的名字 */
@property (weak, nonatomic) IBOutlet UILabel *shopName;
/** 详细的地址 */
@property (weak, nonatomic) IBOutlet UILabel *detailAddress;
/** 距离 */
@property (weak, nonatomic) IBOutlet UILabel *distance;

@end

@implementation SCPAreaTableViewCell



- (void)setArea:(SCPArea *)area
{
    _area = area;
    [self.shopImgeView sd_setImageWithURL:[NSURL URLWithString:area.photo]];
    self.shopName.text = area.nickname;
    self.detailAddress.text = area.address;
    self.distance.text = [NSString stringWithFormat:@"%@KM",area.distince];
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
