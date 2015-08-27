//
//  SCPAllHeaderReusableView.m
//  SCPProject
//
//  Created by 刘蒲艳 on 15/8/25.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import "SCPAllHeaderReusableView.h"
#import "SCPImagesScroll.h"

@interface SCPAllHeaderReusableView()
/** scrollImage */
@property (nonatomic,weak) SCPImagesScroll *imageScroll;

@end

@implementation SCPAllHeaderReusableView

+ (instancetype)headerView:(UICollectionView *)collectionView atIndexPath:(nonnull NSIndexPath *)indexPath
{
    SCPAllHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
    
    return headerView;
}

- (nonnull instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //图片循环滚动
        SCPImagesScroll *images = [SCPImagesScroll viewFromXib];
        images.frame = CGRectMake(0, 0, self.scp_width, 130);
        images.otherColor = [UIColor grayColor];
        images.currentColor = [UIColor blackColor];
        
        [self addSubview:images];
        self.imageScroll = images;
        
        // 特价推荐
        UIView *saleView = [[UIView alloc] init];
        saleView.backgroundColor = SCPColor(19, 20, 24);
        saleView.frame = CGRectMake(SCPHomeMargin, CGRectGetMaxY(images.frame) + SCPHomeMargin, self.scp_width - 2 * SCPHomeMargin, 30);
        // 创建Label
        UILabel *label = [[UILabel alloc] init];
        label.text = @"特价推荐";
        label.textColor = SCPColor(250, 250, 250);
        [label sizeToFit];
        label.scp_x = 20;
        label.scp_centerY = saleView.scp_centerY;
        
        // 添加下划线
        UIView *underlineView = [[UIView alloc] init];
        underlineView.backgroundColor = SCPColor(66, 67, 69);
        CGFloat margin = 2;
        CGFloat underlineViewH = 1;
        underlineView.frame = CGRectMake(margin, saleView.scp_height - 5, saleView.scp_width - 2 * margin, underlineViewH);
        [self addSubview:saleView];
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    self.imageScroll.imagesArray = imageArray;
}

@end
