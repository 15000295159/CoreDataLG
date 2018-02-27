//
//  LoginViewController.m
//  LoginRegister
//
//  Created by gongren on 16/1/13.
//  Copyright © 2016年 gongren. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "PassWordViewController.h"
#import "AppDelegate.h"
#import "People.h"
#import "SuccessViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *findBtn;
- (IBAction)loginBtn:(id)sender;
- (IBAction)registerBtn:(id)sender;
- (IBAction)findBtn:(id)sender;

@property (nonatomic, strong) NSManagedObjectContext *managerContext;
@property (nonatomic, strong) AppDelegate *delegate;

@end

@implementation LoginViewController

- (NSManagedObjectContext *)managerContext {
    if (_managerContext == nil) {
        //获取AppDelegate对象
        _delegate = [UIApplication sharedApplication].delegate;
        self.managerContext = _delegate.managedObjectContext;
    }
    return _managerContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self createNavigationBar];
    self.loginBtn.layer.cornerRadius = 5;
    self.registerBtn.layer.cornerRadius = 5;
    self.findBtn.layer.cornerRadius = 5;
    
    self.loginTf.delegate = self; //设置输入框的代理方法
    self.passwordTf.delegate = self;
}

- (void)createNavigationBar {
    self.navigationItem.title = @"登录";
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

- (IBAction)loginBtn:(id)sender {
    
    [self managerContext];
    
    NSLog(@"======%@", [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) firstObject]);
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"People"];
    NSArray *peos = [self.managerContext executeFetchRequest:request error:nil];
    int count = 0;
    for (int i = 0; i < peos.count; i++) {
        if (([self.loginTf.text isEqualToString:[(People *)peos[i] name]] && [self.passwordTf.text isEqualToString:[(People *)peos[i] passWord]])) {
            [self addPrompt:@"登录成功" flag:@"1"];
        }
        count = i;
    }
    if (count == peos.count - 1) {
        [self addPrompt:@"用户名或密码不正确" flag:@"0"];
    }
}

- (IBAction)registerBtn:(id)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)findBtn:(id)sender {
    PassWordViewController *pw = [[PassWordViewController alloc] init];
    [self.navigationController pushViewController:pw animated:YES];
}


- (void)addPrompt:(NSString *)message flag:(NSString *)flag{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了确定");
        if ([flag isEqualToString:@"1"]) {
            SuccessViewController *success = [[SuccessViewController alloc] init];
            self.loginTf.text = nil;
            self.passwordTf.text = nil;
            [self.loginTf resignFirstResponder];
            [self.passwordTf resignFirstResponder];
            [self.navigationController pushViewController:success animated:YES];
        }
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:otherAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.loginTf resignFirstResponder];
    [self.passwordTf resignFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
