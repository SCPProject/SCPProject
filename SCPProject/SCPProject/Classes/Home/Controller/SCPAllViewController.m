//
//  SCPAllViewController.m
//  SCPProject
//
//  Created by 刘蒲艳 on 15/8/24.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "SCPAllViewController.h"
#import "SCPAllCell.h"
#import "SCPAllHeaderReusableView.h"
#import <AFNetworking.h>

@interface SCPAllViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
/** collectionView */
@property (nonatomic,weak) UICollectionView *collectionView;
/** 存放图片 */
@property (nonatomic,strong) NSMutableArray *imageArray;

/** manager */
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation SCPAllViewController
#pragma mark - 懒加载
- (NSMutableArray *)imageArray
{
    if(_imageArray == nil)
    {
        _imageArray = [NSMutableArray array];
    }
    
    return _imageArray;
}

- (AFHTTPSessionManager *)manager
{
    if(_manager == nil)
    {
        _manager = [AFHTTPSessionManager manager];
        NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:_manager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"text/html"];//添加类型
        _manager.responseSerializer.acceptableContentTypes = contentTypes;
    }
    
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupScrollImage];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = (SCPScreenWidth - SCPHomeMargin * 3) * 0.5;
    CGFloat itemH = itemW + 50;
    flowLayout.itemSize = CGSizeMake(itemH, itemH);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor yellowColor];
    self.collectionView = collectionView;
}

// 加载滚动图片
- (void)setupScrollImage
{
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"op"] = @"app_api";
    params[@"version"] = @"v3.2";
    params[@"action"] = @"BlockBan";
    
    [self.manager GET:@"http://www.shepinxiu.com/api.php" parameters:params success:^(NSURLSessionDataTask * __nonnull task, id  __nonnull responseObject) {
        NSArray *array = responseObject[@"data"];
        for (NSDictionary *dict in array) {
            [self.imageArray addObject:dict[@"thumb"]];
        }
        
        // 重新加载数据
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        self.imageArray = nil;
    }];
}

- (void)loadMore
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"op"] = @"app_api";
    params[@"version"] = @"v3.2";
    params[@"action"] = @"RecomTrade";
    params[@"page"] = @1;
    [self.manager GET:@"http://www.shepinxiu.com/api.php" parameters:params success:^(NSURLSessionDataTask * __nonnull task, id  __nonnull responseObject) {
        NSLog(@"----%@",responseObject);
        
        // 重新加载数据
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        self.imageArray = nil;
        NSLog(@"----%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (nonnull UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SCPAllCell *cell = [SCPAllCell allCell:collectionView indexPath:indexPath];
    return cell;
}

- (nonnull UICollectionReusableView *)collectionView:(nonnull UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath
{
    SCPAllHeaderReusableView *reusableview = nil;
    
    // 表头
    if (kind == UICollectionElementKindSectionHeader){
        
        reusableview = [SCPAllHeaderReusableView headerView:collectionView atIndexPath:indexPath];
        reusableview.imageArray = self.imageArray;
    }
    return reusableview;
}


@end
