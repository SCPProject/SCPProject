//
//  SelfViewController.m
//  LuxuryShow奢品秀
//
//  Created by 韩辉 on 15/8/23.
//  Copyright (c) 2015年 韩辉. All rights reserved.
//

#import "SCPMeViewController.h"
#import "SCPFindPswViewController.h"
#import "SCPSpeedResignViewController.h"

@interface SCPMeViewController ()
/** 整个View */
@property (strong, nonatomic) IBOutlet UIView *holeView;
/** show图片 */
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
/** 整个按钮的View */
@property (weak, nonatomic) IBOutlet UIView *buttonView;
/** 电话号码textField */
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
/** 密码textField */
@property (weak, nonatomic) IBOutlet UITextField *pswNumField;

@end

@implementation SCPMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登陆";

    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    

}
- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.phoneNumTextField resignFirstResponder];
    [self.pswNumField resignFirstResponder];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    NSLog(@"%@",NSStringFromCGRect(self.holeView.frame));
    CGRect frame = self.holeView.frame;
    frame.origin.y -= 70;
    self.holeView.frame = frame;

    // 设置showView的隐藏
    self.showImageView.hidden = YES;
    // 设置按钮View的隐藏
    self.buttonView.hidden = YES;


    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    CGRect frame = self.holeView.frame;
    frame.origin.y += 70;
    self.holeView.frame = frame;
    // 设置showView的显示
    self.showImageView.hidden = NO;
    // 设置按钮View的显示
    self.buttonView.hidden = NO;
    
}

/** 立即登录 */
- (IBAction)loginNow {
    
}
/** 新浪微博登陆 */
- (IBAction)sinaLogin {
    
}
/** 微信登陆 */
- (IBAction)weChatLogin {
    
}
/** 快速注册 */
- (IBAction)speedLogin {
    
    SCPSpeedResignViewController *speedResignVc = [[SCPSpeedResignViewController alloc] init];
    [self.navigationController pushViewController:speedResignVc animated:YES];
    
}
/** 忘记密码 */
- (IBAction)forgetPsw {
    SCPFindPswViewController *findVc = [[SCPFindPswViewController alloc] init];
    [self.navigationController pushViewController:findVc animated:YES];
    
}


@end
