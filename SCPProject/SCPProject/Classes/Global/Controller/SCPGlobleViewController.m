//
//  SCPGlobleViewController.m
//  SCPProject
//
//  Created by 韩辉 on 15/8/27.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import "SCPGlobleViewController.h"
#import <AFHTTPSessionManager.h>
#import "SCPShopsTableViewCell.h"
#import "SCPGloble.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "SCPChinaTableViewController.h"
#import "SCPItalyTableViewController.h"
#import "SCPKoreaTableViewController.h"

@interface SCPGlobleViewController ()<UITableViewDataSource,UITableViewDelegate>

/** manager */
@property(nonatomic, strong)AFHTTPSessionManager *manager;
/** glo属性 */
@property(nonatomic, strong)SCPGloble *glo;
/** 参数数据 */
@property(nonatomic, strong)NSArray *shops;
/** cell */
@property(nonatomic, weak)SCPShopsTableViewCell *cell;

@end

static NSString * const SCPID = @"shopscell";

@implementation SCPGlobleViewController

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
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"version"] = @"v3.2";
    params[@"op"] = @"app_api";
    params[@"action"] = @"QuanQiu";
    params[@"id"] = 0;
    
    // 请求
    
    [self.manager GET:@"http://www.shepinxiu.com/api.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        self.shops = [SCPGloble objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSLog(@"%zd",self.shops.count);
        //    [self.shops addObjectsFromArray:[SCPAsia objectArrayWithKeyValuesArray:responseObject[@"data"]]];
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
    
    [self.tableView.footer endRefreshing];
    
}

- (void)setUpNetwork
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"version"] = @"v3.2";
    params[@"op"] = @"app_api";
    params[@"action"] = @"QuanQiu";
    params[@"id"] = 0;
    
    // 请求
    
    [self.manager GET:@"http://www.shepinxiu.com/api.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
        self.shops = [SCPGloble objectArrayWithKeyValuesArray:responseObject[@"data"]];
       
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
    
    // 结束刷新
    [self.tableView.header endRefreshing];
}


- (void)setupTableView
{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SCPShopsTableViewCell class]) bundle:nil] forCellReuseIdentifier:SCPID];
    self.tableView.rowHeight = [UIScreen mainScreen].bounds.size.width * (300/640.0);
    // 设置TabbleView的内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, SCPTabbleViewBottomInset, 0);
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
    _cell.asia = self.shops[indexPath.row];
    return _cell;
}

#pragma mark - Tableview delegate
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
        self.glo = self.shops[indexPath.row];
    if ([_glo.linkageid isEqualToString:@"3479"]) {
        [self.navigationController pushViewController:[[SCPChinaTableViewController alloc] init] animated:YES];
    }else if([_glo.linkageid isEqualToString:@"3486"]){
   [self.navigationController pushViewController:[[SCPItalyTableViewController alloc] init] animated:YES];
    }else if([_glo.linkageid isEqualToString:@"3481"]){
       [self.navigationController pushViewController:[[SCPKoreaTableViewController alloc] init] animated:YES];
    }
    
}

@end
