//
//  NSString+Verify.m
//  LRPDemo
//
//  Created by 张成松 on 15/8/28.
//  Copyright (c) 2015年 张成松. All rights reserved.
//

#import "NSString+Verify.h"

@implementation NSString (Verify)

//验证邮箱
- (BOOL)verifyEmailAddress {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
//验证手机号
- (BOOL)verifyTelephone {
    NSString *pattern = @"^1+[3578]+[0-9]{9}"; //首位是1 + 第二位是3/5/7/8
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

@end
