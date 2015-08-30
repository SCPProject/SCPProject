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
#import "SCPAllShopModel.h"
#import <MJExtension.h>

@interface SCPAllViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
/** collectionView */
@property (nonatomic,weak) UICollectionView *collectionView;
/** 存放图片 */
@property (nonatomic,strong) NSMutableArray *imageArray;

/** 存放模型数据 */
@property (nonatomic,strong) NSMutableArray *shops;

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

- (NSMutableArray *)shops
{
    if(_shops == nil)
    {
        _shops = [NSMutableArray array];
    }
    
    return _shops;
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
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self setupCollectionView];
    
    [self setupScrollImage];
    // 加载数据
    [self loadMore];
}

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = (SCPScreenWidth - SCPHomeMargin * 2.5) * 0.5;
    CGFloat itemH = itemW + 50;
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.sectionInset = UIEdgeInsetsMake(SCPHomeMargin, SCPHomeMargin, SCPHomeMargin, SCPHomeMargin);
    // 列间距
    flowLayout.minimumLineSpacing = SCPHomeMargin * 0.5;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    // 注册
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SCPAllCell class]) bundle:nil] forCellWithReuseIdentifier:[SCPAllCell scpAllCellID]];
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
        
        [_shops addObjectsFromArray:[SCPAllShopModel objectArrayWithKeyValuesArray:responseObject[@"data"]]];
        
        // 重新加载数据
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        self.imageArray = nil;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (nonnull UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SCPAllCell *cell = [SCPAllCell allCell:collectionView indexPath:indexPath];
    cell.shopModel = self.shops[indexPath.row];
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
