//
//  FindPasswordSecondViewController.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/14.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "FindPasswordSecondViewController.h"

#import "FindPasswordThirdViewController.h"

@interface FindPasswordSecondViewController ()<UITextFieldDelegate>

//图片标志
@property (nonatomic, strong) NSString *Token;
@property (weak, nonatomic) IBOutlet UIImageView *imgCode;
@property (weak, nonatomic) IBOutlet UITextField *imgCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneCodeTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;

@property (nonatomic, strong) NSString *imgCodeStr;
@property (nonatomic, strong) NSString *phoneCodeStr;

@end

@implementation FindPasswordSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.phoneNumTextField.text = self.phoneNum;
    [self requestLoginSessionToken];
    
}


#pragma mark - 点击事件
- (IBAction)backNavButtonClickAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buttonClickAction:(UIButton *)sender {
    [self.view endEditing:YES];
    
    switch (sender.tag) {
        case 1:{
            NSLog(@"点击图片验证码");
            [self requestLoginSessionToken];
        }
            break;
        case 2:{
            NSLog(@"点击手机获取验证码");
            [self requestLoginSendsms];
        }
            break;
        case 3:{
            NSLog(@"点击下一步");
//            FindPasswordThirdViewController *findThirdVC = [[FindPasswordThirdViewController alloc] initWithNibName:@"FindPasswordThirdViewController" bundle:nil];
//
//            [self.navigationController pushViewController:findThirdVC animated:YES];
            [self requestForgetpwdTwo];
        }
            break;
            
        default:
            break;
    }
    
    
}
#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.imgCodeTextField) {
        
    }else if (textField == self.phoneCodeTextField){
        
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.imgCodeTextField) {
        self.imgCodeStr = textField.text;
    }else if (textField == self.phoneCodeTextField){
        self.phoneCodeStr = textField.text;
    }
    
}




#pragma mark - 数据请求
//获取token//发送图片验证码
-(void)requestLoginSessionToken{
    
    [[HRRequestManager manager] POST_PATH:Post_LoginSessionToken para:nil success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"token数据请求成功");
            self.Token = responseObject[@"data"][@"session_token"];
            
            if (self.Token.length > 0) {
                //price.jingku.cn
//                NSString *imgURL = @"http://price.jingku.cn/public/index/login/captcha?method=verify&init_session=";
                NSString *imgURL = @"http://price.jingkoo.net/public/index/login/captcha?method=verify&init_session=";
                NSString *url = [NSString stringWithFormat:@"%@&t=%u",[imgURL stringByAppendingString:self.Token],(arc4random() % 100)];
                
                NSLog(@"%@",url);
                //        NSString *url = [NSString stringWithFormat:@"%@",[imgURL stringByAppendingString:self.Token]];
                NSLog(@"%@",url);
                [self.imgCode sd_setImageWithURL:[NSURL URLWithString:url]];
                
            }
            
        }
    } failure:^(NSError *error) {
        
        
    }];
    
}



//
-(void)requestLoginSendsms{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:self.Token forKey:@"init_session"];
    
    if (self.phoneNum.length > 0) {
        [para setObject:self.phoneNum forKey:@"mobile"];
    }else{
        [MBProgressHUD showInfoMessage:@"用户名不能为空"];
        return;
    }
    
    if (self.imgCodeStr.length > 0) {
        [para setObject:self.imgCodeStr forKey:@"captcha"];
    }else{
        [MBProgressHUD showInfoMessage:@"图片验证码不能为空"];
        return;
    }
    
    [para setObject:@"mind" forKey:@"type"];
    
    [[HRRequestManager manager] POST_PATH:Post_loginSendsms WithInit_session:self.Token para:para success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"数据请求成功");
            
            
        }else{
            [self requestLoginSessionToken];
            [MBProgressHUD showInfoMessage:responseObject[@"error_description"]];
        }
    } failure:^(NSError *error) {
        [self requestLoginSessionToken];
    }];
    
    
}


//忘记密码第二步
-(void)requestForgetpwdTwo{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [para setValue:self.phoneNum forKey:@"phone"];
    if (self.phoneCodeStr.length > 0) {
        [para setValue:self.phoneCodeStr forKey:@"phone_code"];
    }else{
        [MBProgressHUD showInfoMessage:@"请获取手机验证码"];
    }
    
    [[HRRequestManager manager] POST_PATH:Post_ForgetpwdTwo para:para success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"数据请求成功");
            
            FindPasswordThirdViewController *findThirdVC = [[FindPasswordThirdViewController alloc] initWithNibName:@"FindPasswordThirdViewController" bundle:nil];
            findThirdVC.phone = responseObject[@"data"][@"phone"];
            [self.navigationController pushViewController:findThirdVC animated:YES];
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
