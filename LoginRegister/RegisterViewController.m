//
//  RegisterViewController.m
//  LoginRegister
//
//  Created by gongren on 16/1/13.
//  Copyright © 2016年 gongren. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "NSString+Verify.h"
#import "People.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTf;
@property (weak, nonatomic) IBOutlet UITextField *passWordTf;
@property (weak, nonatomic) IBOutlet UITextField *againPassWordTf;
@property (weak, nonatomic) IBOutlet UITextField *emailTf;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;

@property (weak, nonatomic) IBOutlet UIButton *regesterButton;

@property (nonatomic, strong) NSManagedObjectContext *managerContext;
@property (nonatomic, strong) AppDelegate *delegate;

- (IBAction)registerButton:(id)sender;
- (IBAction)cancelBtn:(id)sender;

@end

@implementation RegisterViewController

- (NSManagedObjectContext *)managerContext {
    if (_managerContext == nil) {
        self.delegate = [UIApplication sharedApplication].delegate;
        self.managerContext = _delegate.managedObjectContext;
    }
    return _managerContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createNavigationBar];

}

- (void)createNavigationBar {
    self.navigationItem.title = @"注册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)registerButton:(id)sender {
    
    //判断输入内容不能为空
    if (self.userNameTf.text.length == 0 || self.passWordTf.text.length == 0 || self.againPassWordTf.text.length == 0 || self.phoneTf.text.length == 0 || self.emailTf.text.length == 0) {
        [self addPrompt:@"内容不能为空!" flag:@"0"];
    }
    
    //判断两次密码不正确
    if (![self.passWordTf.text isEqualToString:self.againPassWordTf.text]) {
        [self addPrompt:@"输入的两次密码不一致" flag:@"0"];
    }
    //判断手机格式不正确
    if (![self.phoneTf.text verifyTelephone]) {
        [self addPrompt:@"手机号格式不正确" flag:@"0"];
    }
    //判断邮箱格式不正确
    if (![self.emailTf.text verifyEmailAddress]) {
        [self addPrompt:@"邮箱格式不正确" flag:@"0"];
    }
    
    [self addPrompt:@"注册成功" flag:@"1"];
}

//取消按钮
- (IBAction)cancelBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addPrompt:(NSString *)message flag:(NSString *)flag{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了确定");
        if ([flag isEqualToString:@"1"]) {
            [self add];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:otherAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)add {

    [self managerContext];
    
    NSLog(@"======%@", [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) firstObject]);
    
    
    //这个地方执行不下去就crash了。。。。。
    NSEntityDescription *des = [NSEntityDescription entityForName:@"People" inManagedObjectContext:self.managerContext];
    People *per = [[People alloc] initWithEntity:des insertIntoManagedObjectContext:self.managerContext];
    
    //设置属性
    per.name = self.userNameTf.text;
    per.passWord = self.passWordTf.text;
    per.phone = self.phoneTf.text;
    per.email = self.emailTf.text;
    
    //保存
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate saveContext];
    
    
    NSLog(@"---------------成功");
 
}



@end
