//
//  NSString+Verify.h
//  LRPDemo
//
//  Created by 张成松 on 15/8/28.
//  Copyright (c) 2015年 张成松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verify)
//验证邮箱
- (BOOL)verifyEmailAddress;
//验证手机号
- (BOOL)verifyTelephone;

@end
