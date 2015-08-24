//
//  SCPFindPswViewController.m
//  SCPProject
//
//  Created by 韩辉 on 15/8/25.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import "SCPFindPswViewController.h"

@interface SCPFindPswViewController ()
/** 手机号 */
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
/** 验证码 */
@property (weak, nonatomic) IBOutlet UITextField *checkOutNum;
/** 设置新密码 */
@property (weak, nonatomic) IBOutlet UITextField *setNewPsw;
/** 确认新密码 */
@property (weak, nonatomic) IBOutlet UITextField *sureNewPsw;

@end

@implementation SCPFindPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"找回密码";
}
- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.phoneNum resignFirstResponder];
    [self.checkOutNum resignFirstResponder];
    [self.setNewPsw resignFirstResponder];
    [self.sureNewPsw resignFirstResponder];
}

/** 获取验证码 */
- (IBAction)getCheckOutNum {
    
}

/** 确认 */
- (IBAction)sure {
    
}

@end
