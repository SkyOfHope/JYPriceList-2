//
//  FindPasswordThirdViewController.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/14.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "FindPasswordThirdViewController.h"

#import "FindPasswordFourthViewController.h"

@interface FindPasswordThirdViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *sureTextField;

@property (nonatomic, strong) NSString *codeStr;
@property (nonatomic, strong) NSString *sureCodeStr;


@end

@implementation FindPasswordThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - 点击事件
- (IBAction)backNavButtonClickAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buttonClickAction:(UIButton *)sender {
    [self.view endEditing:YES];
    [self requestForgetpwdThree];
    
}

#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.codeTextField) {
        
    }else if (textField == self.sureTextField){
        
    }
    
    [textField setSecureTextEntry:YES];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.codeTextField) {
        self.codeStr = textField.text;
    }else if (textField == self.sureTextField){
        self.sureCodeStr = textField.text;
    }
}



#pragma mark - 数据请求
-(void)requestForgetpwdThree{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:self.phone forKey:@"phone"];
    if (self.codeStr.length > 0) {
        [para setValue:self.codeStr forKey:@"password"];
    }else{
        [MBProgressHUD showInfoMessage:@"请输入新密码"];
    }
    if ([self.codeStr isEqualToString:self.sureCodeStr]) {
        [para setValue:self.sureCodeStr forKey:@"cpassword"];
    }else{
        [MBProgressHUD showInfoMessage:@"两次密码输入不同"];
    }
    
    [[HRRequestManager manager] POST_PATH:Post_ForgetpwdThree para:para success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"数据请求成功");
            FindPasswordFourthViewController *findFourthVC = [[FindPasswordFourthViewController alloc] initWithNibName:@"FindPasswordFourthViewController" bundle:nil];
            
            [self.navigationController pushViewController:findFourthVC animated:YES];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
