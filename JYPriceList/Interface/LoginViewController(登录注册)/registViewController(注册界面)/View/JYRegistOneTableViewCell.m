//
//  JYRegistOneTableViewCell.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/20.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "JYRegistOneTableViewCell.h"

@interface JYRegistOneTableViewCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *codeImg;

//用户名称
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *userNameTextField;
//密码
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *codeTextField;
//确认密码
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *sureCodeTextField;
//真实姓名
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *reallyNameTextField;
//手机号
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *phoneNumTextField;
//图片验证码
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *imgCodeTextField;
//手机号验证码
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *phoneCodeTextField;
//邮箱
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *emailTextField;
//QQ
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *QQNumTextField;

@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, strong) NSString *Token;
@property (nonatomic, strong) NSString *phoneNum;
@property (nonatomic, strong) NSString *imgCode;

@end

@implementation JYRegistOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.dataDic = [NSMutableDictionary dictionary];
    [self requestLoginSessionToken];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.userNameTextField) {
        
    }else if (textField == self.codeTextField){
        
    }else if (textField == self.sureCodeTextField){
        
    }else if (textField == self.imgCodeTextField){
        
        
    }else if (textField == self.reallyNameTextField){
        
    }else if (textField == self.phoneNumTextField){
        
        
    }else if (textField == self.phoneCodeTextField){
        
    }else if (textField == self.QQNumTextField){
        
    }else if (textField == self.emailTextField){
        
    }
    
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.userNameTextField) {
        [self.dataDic setObject:textField.text forKey:@"user_name"];
    }else if (textField == self.codeTextField){
        [self.dataDic setObject:textField.text forKey:@"password"];
    }else if (textField == self.sureCodeTextField){
        [self.dataDic setObject:textField.text forKey:@"cpassword"];
    }else if (textField == self.imgCodeTextField){
        self.imgCode = textField.text;
        
    }else if (textField == self.reallyNameTextField){
        [self.dataDic setObject:textField.text forKey:@"true_name"];
    }else if (textField == self.phoneNumTextField){
        [self.dataDic setObject:textField.text forKey:@"mobile_phone"];
        self.phoneNum = textField.text;
    }else if (textField == self.phoneCodeTextField){
        [self.dataDic setObject:textField.text forKey:@"mobile_code"];
    }else if (textField == self.QQNumTextField){
        [self.dataDic setObject:textField.text forKey:@"qq"];
    }else if (textField == self.emailTextField){
        [self.dataDic setObject:textField.text forKey:@"email"];
    }
    
    if (textField == self.imgCodeTextField) {
        
    }
    
    NSLog(@"&&&&&&&&&&&&&&&%@",textField.text);
    
}



#pragma mark - 点击事件
- (IBAction)buttonClickAcion:(UIButton *)sender {
    self.registOneTableViewCellBlock(self.dataDic);
    
}
- (IBAction)imgCodeBtnClickAction:(UIButton *)sender {
    [self requestLoginSessionToken];
    
}
- (IBAction)gainCodeButtonAction:(UIButton *)sender {
    [self requestLoginSendsms];
}


//获取token//发送图片验证码
-(void)requestLoginSessionToken{
    
    [[HRRequestManager manager] POST_PATH:Post_LoginSessionToken para:nil success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"token数据请求成功");
            self.Token = responseObject[@"data"][@"session_token"];
            [self.dataDic setObject:self.Token forKey:@"init_session"];
            if (self.Token.length > 0) {
                
                NSString *imgURL = @"http://price.jingku.cn/public/index/login/captcha?method=verify&init_session=";
                NSString *url = [NSString stringWithFormat:@"%@&t=%u",[imgURL stringByAppendingString:self.Token],(arc4random() % 100)];
                //                        NSString *url = [NSString stringWithFormat:@"%@",[imgURL stringByAppendingString:self.Token]];
                NSLog(@"%@",url);
                [self.codeImg sd_setImageWithURL:[NSURL URLWithString:url]];
                
            }
            
        }
    } failure:^(NSError *error) {
        
        
    }];
    
}

-(void)requestLoginSendsms{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:self.Token forKey:@"init_session"];
    
    if (self.phoneNum.length > 0) {
        [para setObject:self.phoneNum forKey:@"mobile"];
    }else{
        [MBProgressHUD showInfoMessage:@"请输入手机号"];
        return;
    }
    if (self.imgCode.length > 0) {
        [para setObject:self.imgCode forKey:@"captcha"];
    }else{
        [MBProgressHUD showInfoMessage:@"请输入图片验证码"];
        return;
    }
    
    
    [para setObject:@"reg" forKey:@"type"];
    
    [[HRRequestManager manager] POST_PATH:Post_loginSendsms WithInit_session:self.Token para:para success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            
            
        }else{
            [MBProgressHUD showErrorMessage:responseObject[@"error_description"]];
            [self requestLoginSessionToken];
        }
        

    } failure:^(NSError *error) {
        
        [self requestLoginSessionToken];
    }];
    
//    [[HRRequestManager manager] POST_PATH:Post_loginSendsms para:para success:^(id responseObject) {
//
//        if ([responseObject[@"status"] integerValue] == 1) {
//
//
//        }else{
//            [MBProgressHUD showInfoMessage:responseObject[@"error_description"]];
//        }
    
//
//    } failure:^(NSError *error) {
//
//    }];
//
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
