//
//  SCPPageControl.m
//  SCPProject
//
//  Created by 刘蒲艳 on 15/9/6.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "SCPPageControl.h"

@implementation SCPPageControl

/*
 in iOS 7 [self.subViews objectAtIndex: i] returns UIView Instead of UIImageView and setImage is not the property of UIView and the app crashes.
 
 Check Whether the subview is UIView(for iOS7) or UIImageView(for iOS6 or earlier). And If it is UIView I am going to add UIImageView as subview on that view and voila its working and not crash..!!
 */
- (void) setCurrentPage:(NSInteger)page {
    [super setCurrentPage:page];
    
    [self updateSize];
    [self updateDots];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    [super setNumberOfPages:numberOfPages];
    
    [self updateSize];
    [self updateDots];
}

- (void)updateSize
{
    for (NSUInteger i = 0; i < [self.subviews count]; i++) {
        UIImageView *subview = [self.subviews objectAtIndex:i];
        CGSize size = CGSizeMake(5, 5);
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,size.width,size.height)];
    }
}

-(void) updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIImageView *dot = [self imageViewForSubview:[self.subviews objectAtIndex: i]];
        if (i == self.currentPage) dot.image = [UIImage imageNamed:@"danx_02"];
        else dot.image = [UIImage imageNamed:@"danx_01"];
    }
}

- (UIImageView *) imageViewForSubview: (UIView *) view
{
    UIImageView * dot = nil;
    if ([view isKindOfClass:[UIView class]])
    {
        for (UIView *subview in view.subviews)
        {
            if ([subview isKindOfClass:[UIImageView class]])
            {
                dot = (UIImageView *)subview;
                break;
            }
        }
        if (dot == nil)
        {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width, view.frame.size.height)];
            [view addSubview:dot];
        }
    }
    else
    {
        dot = (UIImageView *) view;
    }
    
    return dot;
}

@end
