//
//  PassWordViewController.m
//  LoginRegister
//
//  Created by gongren on 16/1/13.
//  Copyright © 2016年 gongren. All rights reserved.
//

#import "PassWordViewController.h"
#import "AppDelegate.h"
#import "People.h"

@interface PassWordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTf;
- (IBAction)findBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;

@property (nonatomic, strong) AppDelegate *delegate;
@property (nonatomic, strong) NSManagedObjectContext *managerContext;

@end

@implementation PassWordViewController

- (NSManagedObjectContext *)managerContext {
    if (_managerContext == nil) {
        self.delegate = [UIApplication sharedApplication].delegate;
        _managerContext = _delegate.managedObjectContext;
    }
    return _managerContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createNavigationBar];
}

- (void)createNavigationBar {
    self.navigationItem.title = @"找回密码";
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

- (IBAction)findBtn:(id)sender {
    
    [self managerContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"People"];
    NSArray *array = [self.managerContext executeFetchRequest:request error:nil];
    
    NSLog(@"=========%@", array);
    int count = 0;
    for (int i = 0; i < array.count; i++) {
        if ([self.emailTf.text isEqualToString:[(People *)array[i] email]]) {
            [self addPrompt:@"已发送邮件，请去邮箱修改密码" flag:@"1"];
        }
        count = i;
    }
    if (count == array.count - 1) {
        [self addPrompt:@"请输入绑定的邮箱" flag:@"0"];
    }
    
}

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
            
        }
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:otherAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
