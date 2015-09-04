//
//  SCPSaleViewController.m
//  SCPProject
//
//  Created by 刘蒲艳 on 15/8/24.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "SCPSaleViewController.h"
#import <AFHTTPSessionManager.h>
#import "SCPSaleTableViewCell.h"
#import "SCPSale.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>



@interface SCPSaleViewController ()<UITableViewDataSource,UITableViewDelegate>

/** manager */
@property(nonatomic, strong)AFHTTPSessionManager *manager;
/** glo属性 */
@property(nonatomic, strong)SCPSale *glo;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 参数数据 */
@property(nonatomic, strong)NSMutableArray *shops;
/** cell */
@property(nonatomic, weak)SCPSaleTableViewCell *cell;
/** 上一次的请求 */
@property(nonatomic, strong)NSDictionary *params;

@end

static NSString * const SCPID = @"salecell";

@implementation SCPSaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresh];
}

/**
 *  上拉下拉
 */
- (void)setupRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(setUpNetwork)];
    [self.tableView.header beginRefreshing];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

- (void)loadMoreTopics
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    self.page++;
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"version"] = @"v3.2";
    params[@"op"] = @"app_api";
    params[@"action"] = @"SaleList";
    params[@"page"] = @(self.page);
    self.params = params;

    // 请求
    
    [self.manager GET:@"http://www.shepinxiu.com/api.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (self.params != params) {
            [SVProgressHUD showInfoWithStatus:@"已无更多数据" maskType:SVProgressHUDMaskTypeBlack];
            return ;
        }
        NSArray *newShops = [SCPSale objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.shops addObjectsFromArray:newShops];
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        //停止刷新
        [self.tableView.footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
        [self.tableView.footer endRefreshing];
        // 恢复页码
        self.page--;
    }];
}

- (void)setUpNetwork
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"version"] = @"v3.2";
    params[@"op"] = @"app_api";
    params[@"action"] = @"SaleList";
    self.params = params;
    
    
    // 请求
    
    [self.manager GET:@"http://www.shepinxiu.com/api.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
      
        if (self.params != params) {
            [SVProgressHUD showInfoWithStatus:@"已无更多数据" maskType:SVProgressHUDMaskTypeBlack];
            return ;
        }
        
        self.shops = [SCPSale objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.header endRefreshing];
        [SVProgressHUD dismiss];
        
        //清空页码
        self.page = 1;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
    // 结束刷新
    [self.tableView.header endRefreshing];
}


- (void)setupTableView
{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SCPSaleTableViewCell class]) bundle:nil] forCellReuseIdentifier:SCPID];
    self.tableView.rowHeight = [UIScreen mainScreen].bounds.size.width * (281/640.0) + 9;
    // 设置TabbleView的内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 设置标题
    self.title = @"特卖专场";
    // 删除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置背景图片
    self.view.backgroundColor = SCPMainBackground;
}



#pragma mark - 懒加载
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



#pragma mark - Tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.shops.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:SCPID];
    _cell.backgroundColor = SCPMainBackground;
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _cell.sale = self.shops[indexPath.row];
    return _cell;
}

#pragma mark - Tableview delegate
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
//    self.glo = self.shops[indexPath.row];
//    if ([_glo.linkageid isEqualToString:@"3479"]) {
//        [self.navigationController pushViewController:[[SCPChinaTableViewController alloc] init] animated:YES];
//    }else if([_glo.linkageid isEqualToString:@"3486"]){
//        [self.navigationController pushViewController:[[SCPItalyTableViewController alloc] init] animated:YES];
//    }else if([_glo.linkageid isEqualToString:@"3481"]){
//        [self.navigationController pushViewController:[[SCPKoreaTableViewController alloc] init] animated:YES];
//    }
    
}

@end