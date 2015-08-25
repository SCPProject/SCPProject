//
//  SCPHomeViewController.m
//  SCPProject
//
//  Created by 刘蒲艳 on 15/8/24.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "SCPHomeViewController.h"
#import "UIImage+SCPExtension.h"
#import "SCPAllViewController.h"
#import "SCPShowViewController.h"

@interface SCPHomeViewController () <UIScrollViewDelegate>
/** contentScroll */
@property (nonatomic,weak) UIScrollView *contentScroll;

/** 当前选中的按钮 */
@property (nonatomic,weak) UIButton *btnSelected;

/** 标题下划线 */
@property (nonatomic,weak) UIView *yellowView;

/** titleView */
@property (nonatomic,weak) UIView *titleView;


@end

@implementation SCPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加所有子控制器
    [self addAllChildViewController];
    
    // 添加内容层
    [self setupContentView];
    
    // 设置导航条
    [self setupNav];
}

- (void)setupNav
{
    // 标题
    UIView *titleView = [[UIView alloc] init];
    titleView.scp_width = 200;
    titleView.scp_height = SCPNavH;
    self.titleView = titleView;
    
    // 下划线
    UIView *yellowView = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor yellowColor];
    CGFloat yellowH = 2;
    [titleView addSubview:yellowView];
    self.yellowView = yellowView;
    
    CGFloat btnW = titleView.scp_width / self.childViewControllers.count;
    for(int i = 0; i < self.childViewControllers.count; i++)
    {
        // 全部
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:[self.childViewControllers[i] title] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn sizeToFit];
        btn.scp_centerY = titleView.scp_height * 0.5;
        btn.scp_width = btnW;
        btn.scp_x = btnW * i;
        // 设置tag从1开始，防止跟系统默认的0混淆
        btn.tag = i + 1;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn addTarget:self action:@selector(btnTitleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
        
        // 默认选中第一个按钮
        if(i == 0)
        {
            self.btnSelected = btn;
            [self.btnSelected setTitleColor:yellowView.backgroundColor forState:UIControlStateNormal];
            // 强制重绘
            [self.btnSelected layoutIfNeeded];
            yellowView.frame = CGRectMake(self.btnSelected.scp_x, titleView.scp_height - yellowH, self.btnSelected.titleLabel.scp_width, yellowH);
            // 添加第一个控制器
            [self scrollViewDidEndDecelerating:self.contentScroll];
        }
    }
    self.navigationItem.titleView = titleView;
    
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageRenderingModeAlwaysOriginalNamed:@"icon_show_more"] style:UIBarButtonItemStylePlain target:self action:@selector(itemRightClick)];
}

// 点击标题切换
- (void)btnTitleClick:(UIButton *)sender
{
    [self.btnSelected setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnSelected.enabled = YES;
    self.btnSelected = sender;
    sender.enabled = NO;
    [self.btnSelected setTitleColor:self.yellowView.backgroundColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.25 animations:^{
        self.yellowView.scp_width = self.btnSelected.titleLabel.scp_width;
        self.yellowView.scp_x = self.btnSelected.scp_x;
    }];
    // 设置滚动范围
    [self.contentScroll setContentOffset:CGPointMake((self.btnSelected.tag - 1) * self.contentScroll.scp_width, 0) animated:YES];
}

// 显示内部部分
- (void)setupContentView
{
    UIScrollView *content = [[UIScrollView alloc] init];
    content.frame = self.view.bounds;
    content.delegate = self;
    content.pagingEnabled = YES;
    content.contentSize = CGSizeMake(SCPScreenWidth * self.childViewControllers.count, SCPScreenHeight);
    [self.view addSubview:content];
    self.contentScroll = content;
}

// 子控制器
- (void)addAllChildViewController
{
    SCPAllViewController *all = [[SCPAllViewController alloc] init];
    all.title = @"全部";
    [self addChildViewController:all];
    
    SCPShowViewController *show = [[SCPShowViewController alloc] init];
    show.title = @"秀场";
    [self addChildViewController:show];
}

- (void)itemRightClick
{
    SCPLog(@"点击导航条右侧");
}

#pragma mark - scrollDelegate
// 拖拽结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    CGFloat scrollW = self.contentScroll.scp_width;
    NSInteger index = scrollView.contentOffset.x / scrollW;
    UIButton *btn = (UIButton *)[self.titleView viewWithTag:(index + 1)];
    [self btnTitleClick:btn];
}

// 拖拽动画结束
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat scrollW = self.contentScroll.scp_width;
    CGFloat scrollH = self.contentScroll.scp_height;
    NSInteger index = (NSInteger)(scrollView.contentOffset.x / scrollW);
    UIViewController *viewController = self.childViewControllers[index];
    viewController.view.frame = CGRectMake(scrollView.contentOffset.x, 0, scrollW, scrollH);
    [scrollView addSubview:viewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
