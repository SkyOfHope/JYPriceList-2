

//
//  FindPasswordFirstViewController.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/14.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "FindPasswordFirstViewController.h"

#import "FindPasswordSecondViewController.h"

@interface FindPasswordFirstViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNametextField;

@property (nonatomic, strong) NSString *userName;

@end

@implementation FindPasswordFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.userNametextField) {
        
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.userNametextField) {
        self.userName = textField.text;
    }
    
}



#pragma mark - 点击事件
- (IBAction)backNavButtonClickAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buttonClickAction:(UIButton *)sender {
    [self.view endEditing:YES];
    [self requestForgetpwd];
//    FindPasswordSecondViewController *findSecondVC = [[FindPasswordSecondViewController alloc] initWithNibName:@"FindPasswordSecondViewController" bundle:nil];
//
//    [self.navigationController pushViewController:findSecondVC animated:YES];
    
//    [UIView animateWithDuration:3.3f animations:^{
//        
//        self.view.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
//        self.view.alpha = 0.f;
//        
//    } completion:^(BOOL finished) {
//        
//        [self.navigationController pushViewController:findSecondVC animated:YES];
//        
//    }];
    
    
}


#pragma mark - 数据请求
-(void)requestForgetpwd{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (self.userName.length > 0) {
        [para setObject:self.userName forKey:@"username"];
    }else{
        [MBProgressHUD showInfoMessage:@"请填写用户名"];
    }
    
    
    [[HRRequestManager manager] POST_PATH:Post_Forgetpwd para:para success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"数据请求成功");
            FindPasswordSecondViewController *findSecondVC = [[FindPasswordSecondViewController alloc] initWithNibName:@"FindPasswordSecondViewController" bundle:nil];
            
            findSecondVC.phoneNum = responseObject[@"data"][@"phone"];
            [self.navigationController pushViewController:findSecondVC animated:YES];
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
