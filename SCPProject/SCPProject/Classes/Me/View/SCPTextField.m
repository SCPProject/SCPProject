//
//  SCPTextField.m
//  SCPProject
//
//  Created by 韩辉 on 15/8/24.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import "SCPTextField.h"
#import <objc/runtime.h>

@implementation SCPTextField

+ (void)initialize
{

//    [self getIvars];
}

+ (void)getProperties
{

}

- (void)awakeFromNib
{
        UILabel *placeholderLabel = [self valueForKeyPath:@"_placeholderLabel"];
        placeholderLabel.textColor = [UIColor redColor];
    
        // 修改占位文字颜色
        [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    // 设置光标颜色和文字颜色一致
   // self.tintColor = self.textColor;
    
    // 不成为第一响应者
    // [self resignFirstResponder];
}


+ (void)getIvars
{
    unsigned int count = 0;
    
    // 拷贝出所有的成员列表
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出成员变量
        //        Ivar ivar = *(ivars + i);
        Ivar ivar = ivars[i];
        
        // 打印成员变量名字
       // NSLog(@"%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
    
    // 释放
    free(ivars);
}

@end
