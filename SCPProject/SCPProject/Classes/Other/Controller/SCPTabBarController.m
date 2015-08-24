//
//  SCPTabBarController.m
//  SCPProject
//
//  Created by 刘蒲艳 on 15/8/24.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "SCPTabBarController.h"
#import "SCPHomeViewController.h"
#import "SCPSaleViewController.h"
#import "SCPGlobalViewController.h"
#import "SCPMeViewController.h"
#import "SCPNavigationController.h"
#import "UIImage+SCPExtension.h"

@interface SCPTabBarController ()

@end

@implementation SCPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 通过appearance统一设置所有UITabBarItem的文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    NSMutableDictionary *selattrs = [NSMutableDictionary dictionary];
    selattrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selattrs[NSForegroundColorAttributeName] = [UIColor yellowColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selattrs forState:UIControlStateSelected];
    
    // 设置TabBar的背景图片
    UIGraphicsBeginImageContext(self.tabBar.frame.size);
    UIImage *image = [UIImage imageNamed:@"anx_bg"];
    [image drawInRect:self.tabBar.bounds];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.tabBar.backgroundImage = newImage;
    
    // 添加子控制器
    [self addChildViewController];
}

- (void)addChildViewController
{
    [self setupChildVc:[[SCPHomeViewController alloc] init] title:@"首页" image:@"show_firstPage_unselected" selectedImage:@"show_firstPage_selected"];
    [self setupChildVc:[[SCPSaleViewController alloc] init] title:@"特卖" image:@"discount_unselected" selectedImage:@"discount_selected"];
    [self setupChildVc:[[SCPGlobalViewController alloc] init] title:@"全球" image:@"globe白" selectedImage:@"globe黄"];
    [self setupChildVc:[[SCPMeViewController alloc] init] title:@"个人" image:@"user_unselected" selectedImage:@"user_selected"];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageRenderingModeAlwaysOriginalNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageRenderingModeAlwaysOriginalNamed:selectedImage];
    // 随机背景颜色
    vc.view.backgroundColor = SCPColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
    // 包装一个导航控制器，添加导航控制器为tabbar控制器的子控制器
    SCPNavigationController *nav = [[SCPNavigationController alloc] initWithRootViewController:vc];
    
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"anx_bg"] forBarMetrics:UIBarMetricsDefault];
    
    [self addChildViewController:nav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
