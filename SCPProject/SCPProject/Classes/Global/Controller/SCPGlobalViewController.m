//
//  SCPGlobalViewController.m
//  SCPProject
//
//  Created by 刘蒲艳 on 15/8/24.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "SCPGlobalViewController.h"

@interface SCPGlobalViewController ()

@end

@implementation SCPGlobalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTitlesView];
}

/**
 * 设置顶部的标签栏
 */

- (void)setupTitlesView
{
// 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor redColor];
    titlesView.scp_width = self.view.scp_width;
    titlesView.scp_height = 35;
    titlesView.scp_y = -29;
    [self.view addSubview:titlesView];
    

}

@end
