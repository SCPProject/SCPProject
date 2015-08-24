//
//  SCPSpeedResignViewController.m
//  SCPProject
//
//  Created by 韩辉 on 15/8/25.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import "SCPSpeedResignViewController.h"
#import <SVProgressHUD.h>

@interface SCPSpeedResignViewController ()
/** 手机号 */
@property (weak, nonatomic) IBOutlet UITextField *phineNum;

@end

@implementation SCPSpeedResignViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"注册(1/3)";
}

- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.phineNum resignFirstResponder];
}

/** 获取验证码 */
- (IBAction)getCheckOutNum {

    if (self.phineNum.text.length == 0) {
       
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];

    }else if(self.phineNum.text.length < 11){

        [SVProgressHUD showErrorWithStatus:@"手机号不正确"];
    }
}

@end
