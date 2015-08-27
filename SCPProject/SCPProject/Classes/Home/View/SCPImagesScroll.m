//
//  PYImages.m
//  02-图片滚动
//
//  Created by 刘蒲艳 on 15/5/29.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "SCPImagesScroll.h"

@interface SCPImagesScroll () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic,strong) NSTimer *timer;

// 显示的图片
@property (strong,nonatomic) UIImageView *showImage;

// 可重复利用的图片
@property (strong,nonatomic) UIImageView *reuseImage;

// 加载上一次索引
@property (nonatomic,assign) int oldIndex;

@end

@implementation SCPImagesScroll
/**
 * 通过代码创建的控件，会执行init/initWithFrame方法初始化
 * 通过xib/storyboard加载的控件，会执行initWithCoder方法初始化
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self setup];
    }
    
    return self;
}

#pragma mark 初始化完毕执行 加载完xib文件内容，才开始初始化 一般使用此方法进行初始化 如果使用initWithCoder 可能会导致没有加载完成就执行
- (void)awakeFromNib
{
    [self setup];
    
    // 设置定时翻转
    [self addTimer];
}

- (void)setup
{
    self.scrollView.delegate = self;
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    self.scrollView.pagingEnabled = YES;
    
    CGFloat scrollW = self.scrollView.frame.size.width;
    CGFloat scrollH = self.scrollView.frame.size.height;
    
    
    // 添加可重复利用的图片
    self.reuseImage = [[UIImageView alloc] init];
    self.reuseImage.frame = CGRectMake(0, 0, scrollW, scrollH);
    [self.scrollView addSubview:self.reuseImage];
    
    // 添加显示的图片
    self.showImage = [[UIImageView alloc] init];
    self.showImage.frame = CGRectMake(scrollW, 0, scrollW, scrollH);
    // 设置图片索引
    self.showImage.tag = 0;
    [self.scrollView addSubview:self.showImage];
    
    self.scrollView.contentSize = CGSizeMake(scrollW * 3, 0);
    self.scrollView.contentOffset = CGPointMake(scrollW, 0);

}

- (void)setImagesArray:(NSArray *)imagesArray
{
    _imagesArray = imagesArray;
    self.showImage.image = [imagesArray firstObject];
    self.pageControl.numberOfPages = self.imagesArray.count;
}

- (void)setOtherColor:(UIColor *)otherColor
{
    _otherColor = otherColor;
    _pageControl.pageIndicatorTintColor = _otherColor;
}

- (void)setCurrentColor:(UIColor *)currentColor
{
    _currentColor = currentColor;
    _pageControl.currentPageIndicatorTintColor = _currentColor;
}

#pragma mark 添加定时器
- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    // 添加定时器到主线程中
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark 移除定时器
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark 设置定时器执行的内容
- (void)nextPage
{
    NSUInteger page;
    CGFloat scrollW = self.scrollView.frame.size.width;
    if(_pageControl.currentPage == _pageControl.numberOfPages - 1)
        page = 0;
    else
        page = _pageControl.currentPage + 1;
    
    NSInteger index = self.scrollView.contentOffset.x / scrollW;
    [_scrollView setContentOffset:CGPointMake((index + 1) * scrollW, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollW = self.scrollView.frame.size.width;
    
    CGPoint offset = scrollView.contentOffset;
    
    // 获得重复利用的图片的frame
    CGRect reuseFrame = self.reuseImage.frame;
    // 图片index
    NSInteger index = self.showImage.tag;
    
    if(offset.x > self.showImage.frame.origin.x) // 向右移动了
    {
        reuseFrame.origin.x = self.scrollView.frame.size.width * 2;
        index += 1;
        if (index >= self.imagesArray.count) {
            index = 0;
        }
    }
    else // 向左移动了
    {
        reuseFrame.origin.x = 0;
        index -= 1;
        if(index < 0)
        {
            index = self.imagesArray.count - 1;
        }
    }
    
    // 给reuseImageView赋值图片
    self.reuseImage.frame = reuseFrame;
    self.reuseImage.tag = index;
    self.reuseImage.image = self.imagesArray[index];
    
    if(offset.x <= 0 || offset.x >= self.scrollView.frame.size.width * 2)
    {
        UIImageView *tmpImageView = self.showImage;
        self.showImage = self.reuseImage;
        self.reuseImage = tmpImageView;
        
        self.showImage.frame = self.reuseImage.frame;
        
        self.scrollView.contentOffset = CGPointMake(scrollW, 0);
    }
    
    // 设置当前滚动的页
    _pageControl.currentPage = self.showImage.tag;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 拖拽开始移除定时器
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 拖拽结束添加定时器
    [self addTimer];
}

- (void)dealloc
{
    [self removeTimer];
}

+ (instancetype)images
{    // 加载xib文件
    SCPImagesScroll *images = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    return images;
}

@end
