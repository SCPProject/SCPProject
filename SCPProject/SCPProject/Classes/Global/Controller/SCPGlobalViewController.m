//
//  SCPGlobalViewController.m
//  SCPProject
//
//  Created by 刘蒲艳 on 15/8/24.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "SCPGlobalViewController.h"
#import "SCPGlobleViewController.h"
#import "SCPTAsiaViewController.h"
#import "SCPEuropViewController.h"
#import "SCPNorthAmeracaViewController.h"

@interface SCPGlobalViewController ()<UIScrollViewDelegate>
/** 被选中的按钮 */
@property(nonatomic, weak) UIButton *selectedBtn;
/** titlesView */
@property(nonatomic, weak) UIView *titlesView;
/** 黄色滚动条 */
@property(nonatomic, weak) UIView *yellowView;
/** SCrollView */
@property(nonatomic, weak) UIScrollView *contentView;


@end

@implementation SCPGlobalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置顶部的标题栏
    [self setupTitlesView];

    // 添加子控制器
    [self setupChildVc];
    
    // 设置内容层
    [self setupContentView];
    
}
/**
 *  设置内容层
 */
- (void)setupContentView
{
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame= self.view.bounds;
    contentView.backgroundColor = [UIColor darkGrayColor];
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
    // NSLog(@"%@",NSStringFromCGRect(self.view.bounds));
    // NSLog(@"%@",NSStringFromCGRect(contentView.bounds));
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.scp_width *self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的View
  [self scrollViewDidEndScrollingAnimation:contentView];
   
}

/**
 *  添加子控制器
 */
- (void)setupChildVc
{
    SCPGlobleViewController *globleVc = [[SCPGlobleViewController alloc] init];
    [self addChildViewController:globleVc];
    
    SCPTAsiaViewController *asiaVc = [[SCPTAsiaViewController alloc] init];
    [self addChildViewController:asiaVc];
    
    SCPEuropViewController *europVc = [[SCPEuropViewController alloc] init];
    [self addChildViewController:europVc];
    
    SCPNorthAmeracaViewController *northAmeraca = [[SCPNorthAmeracaViewController alloc] init];
    [self addChildViewController:northAmeraca];
   

}

/**
 *  设置顶部的标签栏
 */
- (void)setupTitlesView
{
    /** 标签栏整体 */
    UIView *titlesView = [[UIView alloc] init];
   //   titlesView.backgroundColor = [UIColor redColor];
    titlesView.scp_width = [UIScreen mainScreen].bounds.size.width;
    titlesView.scp_height = SCPNavH;
    self.titlesView = titlesView;
    
    /** 添加黄色View */
    UIView *yellowView = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor yellowColor];
    CGFloat yellowViewH = 2;
    yellowView.scp_height = yellowViewH;
    yellowView.scp_y = self.titlesView.scp_height - yellowViewH;
    self.yellowView = yellowView;
    [titlesView addSubview:yellowView];
    
    /** 添加按钮 */
    NSArray *array = @[@"全球",@"亚洲",@"欧洲",@"北美"];
    NSUInteger width = titlesView.scp_width / array.count;
    for (int i = 0; i < array.count ; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.scp_width = width;
        button.scp_height = titlesView.scp_height;
        button.scp_x = i * width;
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       ;
        [button setTitleColor:[UIColor yellowColor] forState:UIControlStateDisabled];
      
        // 添加button的tag
        button.tag = i+1;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        // 设置按钮选中后底部的View无法显示需要强制布局(强制更新子控件的frame)才能显示出来
        [button layoutIfNeeded];

        [titlesView addSubview:button];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 默认选中第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedBtn = button;
            
            self.yellowView.scp_width = self.selectedBtn.titleLabel.scp_width;
            self.yellowView.scp_centerX = self.selectedBtn.scp_centerX;
        }

    }

    self.navigationItem.titleView = titlesView;

}


- (void)buttonClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;


    // 底部指示器动画
    [UIView animateWithDuration:0.25 animations:^{
    self.yellowView.scp_width = self.selectedBtn.titleLabel.scp_width;
    self.yellowView.scp_centerX = self.selectedBtn.scp_centerX;
}];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = (button.tag-1) * self.contentView.scp_width;

    [self.contentView setContentOffset:offset animated:YES];
   
}



#pragma mark - UISCrollViewDelegate
/**
 *  拖拽结束
 *
 *  @param scrollView 传入的scrollView
 */
- (void)scrollViewDidEndDecelerating:(nonnull UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    // 索引
    NSInteger index = scrollView.contentOffset.x / SCPScreenWidth;
    UIButton *button = (UIButton *)[self.titlesView viewWithTag:index+1];
    [self buttonClick:button];
}

/**
 *  拖拽动画结束
 *
 *  @param scrollView 结束时的scrollView
 */
- (void)scrollViewDidEndScrollingAnimation:(nonnull UIScrollView *)scrollView
{
    // 索引
    NSInteger index = scrollView.contentOffset.x / scrollView.scp_width;
//    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, SCPScreenWidth, SCPScreenHeight);
    [scrollView addSubview:vc.view];
    // 设置内边距
    
}

@end
