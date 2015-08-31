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


@interface SCPTAsiaViewController ()

@end

@implementation SCPTAsiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor blueColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@----%zd", [self class], indexPath.row];
    
    return cell;
}

@end
