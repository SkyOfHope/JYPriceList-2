//
//  JYLoginViewController.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/19.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "JYLoginViewController.h"

#import "JYBaseNavigationController.h"
//#import "GlassShopViewController.h"
#import "GlassHomeViewController.h"
#import "JYRegistOneViewController.h"
#import "ChoosePromptView.h"

#import "LoginCompanyModel.h"
#import "ShopTypeViewController.h"
#import "PersonRightViewController.h"
#import "FindPasswordFirstViewController.h"

@interface JYLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *selectBtn;
//图片验证按钮
@property (weak, nonatomic) IBOutlet UIButton *imgCodeBtn;
//图片验证码背景view
@property (weak, nonatomic) IBOutlet UIView *codeImgBackView;
@property (weak, nonatomic) IBOutlet UIView *codeCheckBackView;
//手机验证码登录按钮
@property (weak, nonatomic) IBOutlet UIButton *phoneLoginBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

//获取验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
//用户名称
@property (weak, nonatomic) IBOutlet UITextField *userNameTaxtField;
//图片验证码
@property (weak, nonatomic) IBOutlet UITextField *imgCodeTextField;
//验证码
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
//验证码图片
@property (weak, nonatomic) IBOutlet UIImageView *codeImg;

//用户名称
@property (nonatomic, strong) NSString *userName;
//验证码
@property (nonatomic, strong) NSString *codeStr;
//登录类型
@property (nonatomic, strong) NSString *type;
//公司Id
@property (nonatomic, assign) NSInteger cid;
//图片验证码
@property (nonatomic, strong) NSString *imgCodeStr;
//图片标志
@property (nonatomic, strong) NSString *Token;

@property (nonatomic, strong) ChoosePromptView *choosePromptView;

@property (nonatomic, strong) NSMutableArray *loginCompanyDataSourceArr;

/**
 *  属性
 */
@property(nonatomic,strong) MMDrawerController * drawerController;


@end

@implementation JYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.loginCompanyDataSourceArr = [NSMutableArray array];
    
    self.type = @"1";
    self.phoneLoginBtn.selected = YES;
    self.selectBtn = self.phoneLoginBtn;
    
    self.userNameTaxtField.placeholder = @"请输入手机号";
    self.codeTextField.placeholder = @"请输入验证码";
    //获取验证码
    [self requestLoginSessionToken];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有方法
-(void)buildWithPromptViewWithArray:(NSMutableArray *)array{
    
    self.choosePromptView = [[ChoosePromptView alloc] init];
    self.choosePromptView.height = ScreenHeight;
    self.choosePromptView.width = ScreenWidth;
    self.choosePromptView.dataSourceArr = array;
    self.choosePromptView.backgroundColor = [UIColor colorWithRed:250/255 green:250/255 blue:250/255 alpha:.5];
    self.choosePromptView.layer.masksToBounds = YES;
    weakSelf(weakSelf);
    self.choosePromptView.choosePromptViewBlock = ^(NSInteger cid) {
        weakSelf.cid = cid;
        [weakSelf requestLoginIndex];
        
    };
    
    [[[UIApplication sharedApplication] delegate].window addSubview:self.choosePromptView];
    
}


#pragma mark - 点击事件
- (IBAction)buttonClickAction:(UIButton *)sender {
    //结束编辑
    [self.view endEditing:YES];
    
    switch (sender.tag) {
        case 3:{
            NSLog(@"获取验证码");
            [self requestLoginSendsms];
        }
            break;
        case 4:{
            NSLog(@"立即注册立即注册");
            JYRegistOneViewController *registVC = [[JYRegistOneViewController alloc] initWithNibName:@"JYRegistOneViewController" bundle:nil];
            
            [self.navigationController pushViewController:registVC animated:YES];
        }
            break;
        case 5:{
            NSLog(@"忘记密码忘记密码");
            FindPasswordFirstViewController *findVC = [[FindPasswordFirstViewController alloc] initWithNibName:@"FindPasswordFirstViewController" bundle:nil];
            
            [self.navigationController pushViewController:findVC animated:YES];
        }
            break;
        case 6:{
            NSLog(@"登录登录登录登录登录");
            [self.view endEditing:YES];
            /*
            //1、初始化控制器
            ShopTypeViewController *glassHomeVC = [[ShopTypeViewController alloc] initWithNibName:@"ShopTypeViewController" bundle:nil];
            UIViewController *rightVC = [[PersonRightViewController alloc] init];
            
            //2、初始化导航控制器glassHomeVCNav
            UINavigationController *centerNvaVC = [[UINavigationController alloc]initWithRootViewController:glassHomeVC];
            UINavigationController *rightNvaVC = [[UINavigationController alloc]initWithRootViewController:rightVC];
            
//            //1、初始化控制器
//            GlassHomeViewController *glassHomeVC = [[GlassHomeViewController alloc] initWithNibName:@"GlassHomeViewController" bundle:nil];
//            UIViewController *rightVC = [[PersonRightViewController alloc] init];
//
//            //2、初始化导航控制器glassHomeVCNav
//            UINavigationController *centerNvaVC = [[UINavigationController alloc]initWithRootViewController:glassHomeVC];
//            UINavigationController *rightNvaVC = [[UINavigationController alloc]initWithRootViewController:rightVC];

            
            //3、使用MMDrawerController
            self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerNvaVC rightDrawerViewController:rightNvaVC];
            
            //4、设置打开/关闭抽屉的手势
            self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
            self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
            //5、设置左右两边抽屉显示的多少
            self.drawerController.maximumRightDrawerWidth = 300.0;
            //6、初始化窗口、设置根控制器、显示窗口
            //    [self.window setRootViewController:self.drawerController];
            [[UIApplication sharedApplication].keyWindow setRootViewController:self.drawerController];
//            GlassHomeViewController *glassHomeVC = [[GlassHomeViewController alloc] initWithNibName:@"GlassHomeViewController" bundle:nil];
//            JYBaseNavigationController *nav = [[JYBaseNavigationController alloc] initWithRootViewController:glassHomeVC];
//            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            
//            ShopTypeViewController *shopTypeVC = [[ShopTypeViewController alloc]  initWithNibName:@"ShopTypeViewController" bundle:nil];
//            JYBaseNavigationController *nav = [[JYBaseNavigationController alloc] initWithRootViewController:shopTypeVC];
//            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            */
            [self requestLoginCompany];
            
        }
            break;
        case 7:{
            NSLog(@"获取图片验证码");
            [self requestLoginSessionToken];
        }
            break;
            
        default:
            break;
    }
    
}

- (IBAction)loginWayBtnClickAction:(UIButton *)sender {
    //结束编辑
    [self.view endEditing:YES];
    
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    sender.selected = YES;
    
    self.codeTextField.text = @"";
    self.imgCodeTextField.text = @"";
    self.userNameTaxtField.text = @"";
    
    if (sender.tag == 1) {
        NSLog(@"手机验证码登录");
        self.codeBtn.hidden = NO;
        self.codeImgBackView.hidden = NO;
        self.codeCheckBackView.hidden =  NO;
        self.topConstraint.constant = 65;
        self.bottomConstraint.constant = 35;
        self.userNameTaxtField.placeholder = @"请输入手机号";
        self.codeTextField.placeholder = @"请输入验证码";
        
        self.type = @"1";
        
    }else if (sender.tag == 2){
        NSLog(@"用户密码登陆");
        self.codeBtn.hidden = YES;
        self.codeImgBackView.hidden = YES;
        self.codeCheckBackView.hidden =  YES;
        self.topConstraint.constant = 10;
        self.type = @"0";
        self.bottomConstraint.constant = 70;
        self.userNameTaxtField.placeholder = @"请输入用户名";
        self.codeTextField.placeholder = @"请输入密码";
    }
    
    
}

#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.userNameTaxtField) {
        
    }else if (textField == self.codeTextField){
        [textField setSecureTextEntry:YES];
    }else if(textField == self.imgCodeTextField){
        
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.userNameTaxtField) {
        self.userName = textField.text;
    }else if (textField == self.codeTextField){
        self.codeStr = textField.text;
    }else if(textField == self.imgCodeTextField){
        self.imgCodeStr = textField.text;
//        [self requestLoginSendsms];
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
                NSString *imgURL = @"http://price.jingku.cn/public/index/login/captcha?method=verify&init_session=";
                NSString *url = [NSString stringWithFormat:@"%@&t=%u",[imgURL stringByAppendingString:self.Token],(arc4random() % 100)];
                
                NSLog(@"%@",url);
                //        NSString *url = [NSString stringWithFormat:@"%@",[imgURL stringByAppendingString:self.Token]];
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
    
    if (self.userName.length > 0) {
        [para setObject:self.userName forKey:@"mobile"];
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
            [MBProgressHUD showInfoMessage:responseObject[@"成功"]];
        }else{
            [self requestLoginSessionToken];
            [MBProgressHUD showInfoMessage:responseObject[@"error_description"]];
        }
    } failure:^(NSError *error) {
        [self requestLoginSessionToken];
    }];
    
//    [[HRRequestManager manager] POST_PATH:Post_loginSendsms para:para success:^(id responseObject) {
//        if ([responseObject[@"status"] integerValue] == 1) {
//            NSLog(@"数据请求成功");
//            [MBProgressHUD showInfoMessage:responseObject[@"成功"]];
//        }else{
//            [self requestLoginSessionToken];
//            [MBProgressHUD showInfoMessage:responseObject[@"error_description"]];
//        }
//        
//    } failure:^(NSError *error) {
//        [self requestLoginSessionToken];
//    }];
    
    
}



//登录
-(void)requestLoginCompany{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (self.userName.length > 0) {
        [para setValue:self.userName forKey:@"username"];
    }else{
        [MBProgressHUD showInfoMessage:@"用户名不能为空"];
        return;
    }
    
    if (self.type.length > 0) {
        [para setValue:self.type forKey:@"type"];
        if ([self.type isEqualToString:@"1"]) {
            [para setObject:self.Token forKey:@"init_session"];
            if(self.codeStr.length > 0){
                [para setValue:self.codeStr forKey:@"mobile_code"];
            }else{
                [MBProgressHUD showInfoMessage:@"密码不能为空"];
                return;
            }
        }else{
            if(self.codeStr.length > 0){
                [para setValue:self.codeStr forKey:@"password"];
            }else{
                [MBProgressHUD showInfoMessage:@"密码不能为空"];
                return;
            }
        }
        
    }else{
        [MBProgressHUD showInfoMessage:@"请选择登录方式"];
        return;
    }
    [self.loginCompanyDataSourceArr removeAllObjects];
    [[HRRequestManager manager] POST_PATH:Post_LoginCompany para:para success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"数据请求成功");
            
            for (NSDictionary *dic in responseObject[@"data"]) {
                LoginCompanyModel *model = [[LoginCompanyModel alloc] initWithDictionary:dic];
                [self.loginCompanyDataSourceArr addObject:model];
            }
            
            if (self.loginCompanyDataSourceArr.count > 1) {
                [self buildWithPromptViewWithArray:self.loginCompanyDataSourceArr];
            }else{
                LoginCompanyModel *model = self.loginCompanyDataSourceArr[0];
                self.cid = model.cid;
                [self requestLoginIndex];
            }
            
            
            
//            [MBProgressHUD showInfoMessage:responseObject[@"info"]];
            
//            [self buildWithPromptView];
            

        }else{
            [MBProgressHUD showInfoMessage:responseObject[@"error_description"]];
        }
    } failure:^(NSError *error) {
        
    }];
}


-(void)requestLoginIndex{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:self.userName forKey:@"username"];
    [para setObject:self.codeStr forKey:@"password"];
    [para setObject:[NSString stringWithFormat:@"%ld",(long)self.cid] forKey:@"cid"];
    [para setObject:self.type forKey:@"type"];
    [[HRRequestManager manager] POST_PATH:Post_LoginIndex para:para success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"数据请求成功");
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:responseObject[@"data"][@"token"] forKey:@"token"];
            [defaults synchronize];
            
            /*
            //1、初始化控制器
            ShopTypeViewController *glassHomeVC = [[ShopTypeViewController alloc] initWithNibName:@"ShopTypeViewController" bundle:nil];
            UIViewController *rightVC = [[PersonRightViewController alloc] init];
            
            //2、初始化导航控制器glassHomeVCNav
            UINavigationController *centerNvaVC = [[UINavigationController alloc]initWithRootViewController:glassHomeVC];
            UINavigationController *rightNvaVC = [[UINavigationController alloc]initWithRootViewController:rightVC];
            
            
//            //1、初始化控制器
//            GlassHomeViewController *glassHomeVC = [[GlassHomeViewController alloc] initWithNibName:@"GlassHomeViewController" bundle:nil];
//            UIViewController *rightVC = [[PersonRightViewController alloc] init];
//
//            //2、初始化导航控制器glassHomeVCNav
//            UINavigationController *centerNvaVC = [[UINavigationController alloc]initWithRootViewController:glassHomeVC];
//            UINavigationController *rightNvaVC = [[UINavigationController alloc]initWithRootViewController:rightVC];
            
            //3、使用MMDrawerController
            self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerNvaVC rightDrawerViewController:rightNvaVC];
            
            //4、设置打开/关闭抽屉的手势
            self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
            self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
            //5、设置左右两边抽屉显示的多少
            self.drawerController.maximumRightDrawerWidth = 300.0;
            //6、初始化窗口、设置根控制器、显示窗口
            //    [self.window setRootViewController:self.drawerController];
            [[UIApplication sharedApplication].keyWindow setRootViewController:self.drawerController];
            */
            
//            JYBaseNavigationController *nav = [[JYBaseNavigationController alloc] initWithRootViewController:glassHomeVC];
//            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
//
            ShopTypeViewController *shopTypeVC = [[ShopTypeViewController alloc]  initWithNibName:@"ShopTypeViewController" bundle:nil];
            JYBaseNavigationController *nav = [[JYBaseNavigationController alloc] initWithRootViewController:shopTypeVC];
            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                GlassHomeViewController *glassHomeVC = [[GlassHomeViewController alloc] initWithNibName:@"GlassHomeViewController" bundle:nil];
//                JYBaseNavigationController *nav = [[JYBaseNavigationController alloc] initWithRootViewController:glassHomeVC];
//                [UIApplication sharedApplication].keyWindow.rootViewController = nav;
//            });
        }else{
            [MBProgressHUD showInfoMessage:responseObject[@"error_description"]];
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
