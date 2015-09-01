//
//  SCPTAsiaViewController.m
//  SCPProject
//
//  Created by 韩辉 on 15/8/27.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import "SCPTAsiaViewController.h"
#import "SCPAsia.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>


@interface SCPTAsiaViewController ()

/** manager */
@property(nonatomic, strong)AFHTTPSessionManager *manager;

/** 参数数据 */
@property(nonatomic, strong)NSMutableArray *shops;

@end

@implementation SCPTAsiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 删除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置背景图片
    self.view.backgroundColor = SCPMainBackground;
    
    // 网络请求
    [self setUpNetwork];
}

- (void)setUpNetwork
{
   
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"version"] = @"v3.2";
    params[@"op"] = @"app_api";
    params[@"action"] = @"QuanQiu";
    
    // 请求
    
    [self.manager GET:@"http://www.shepinxiu.com/api.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
    
        self.shops = [SCPAsia objectArrayWithKeyValuesArray:responseObject];
//    [self.shops addObjectsFromArray:[SCPAsia objectArrayWithKeyValuesArray:responseObject[@"data"]]];

        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];

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



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.shops.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
       
    }
    cell.backgroundColor = [UIColor purpleColor];
    NSDictionary *shop = self.shops[indexPath.row];
    cell.textLabel.text = shop[@"name"];
//    [cell.backgroundView sd_setImageWithURL:[NSURL URLWithString:shop[@"thumb"]] placeholderImage:[UIImage imageNamed:@"empty_bg"]];

    
    return cell;
}

@end
