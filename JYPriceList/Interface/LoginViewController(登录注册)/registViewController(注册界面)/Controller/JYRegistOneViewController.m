//
//  JYRegistOneViewController.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/20.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "JYRegistOneViewController.h"

#import "JYRegistOneTableViewCell.h"

#import "JYRegistTwoViewController.h"

static NSString *const JYRegistOneTableViewCellID = @"JYRegistOneTableViewCellIdentifier";

@interface JYRegistOneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong) NSDictionary *pDic;

@end

@implementation JYRegistOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self setUpUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpUI{

    //关闭纵向滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"JYRegistOneTableViewCell" bundle:nil] forCellReuseIdentifier:JYRegistOneTableViewCellID];
    
    
}

#pragma mark - 点击事件

- (IBAction)buttonClickAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 940;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYRegistOneTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:JYRegistOneTableViewCellID forIndexPath:indexPath];
    
    weakSelf(weakSelf);
    cell.registOneTableViewCellBlock = ^(NSMutableDictionary *mDic) {
        weakSelf.pDic = mDic;
//        JYRegistTwoViewController *twoVC = [[JYRegistTwoViewController alloc] initWithNibName:@"JYRegistTwoViewController" bundle:nil];
//        twoVC.user_id = @"7596";
//        [weakSelf.navigationController pushViewController:twoVC animated:YES];
        [weakSelf requestLoginRegister];
    };
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - 数据请求
-(void)requestLoginRegister{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (self.pDic[@"init_session"] != nil) {
        [para setObject:self.pDic[@"init_session"] forKey:@"init_session"];
    }
    
    if (self.pDic[@"user_name"] != nil) {
        [para setObject:self.pDic[@"user_name"] forKey:@"user_name"];
    }else{
        [MBProgressHUD showInfoMessage:@"用户名不能为空"];
        return;
    }
    if (self.pDic[@"password"] != nil) {
        [para setObject:self.pDic[@"password"] forKey:@"password"];
    }else{
        [MBProgressHUD showInfoMessage:@"密码不能为空"];
        return;
    }
    if (self.pDic[@"password"] != nil) {
        [para setObject:self.pDic[@"password"] forKey:@"password"];
    }else{
        [MBProgressHUD showInfoMessage:@"密码不能为空"];
        return;
    }
    if (self.pDic[@"cpassword"] != nil) {
        [para setObject:self.pDic[@"cpassword"] forKey:@"cpassword"];
    }else{
        [MBProgressHUD showInfoMessage:@"确认密码不能为空"];
        return;
    }
    if (self.pDic[@"true_name"] != nil) {
        [para setObject:self.pDic[@"true_name"] forKey:@"true_name"];
    }else{
        [MBProgressHUD showInfoMessage:@"真实姓名不能为空"];
        return;
    }
    
    if (self.pDic[@"mobile_phone"] != nil) {
        [para setObject:self.pDic[@"mobile_phone"] forKey:@"mobile_phone"];
    }else{
        [MBProgressHUD showInfoMessage:@"电话号码不能为空"];
        return;
    }
    
    if (self.pDic[@"mobile_code"] != nil) {
        [para setObject:self.pDic[@"mobile_code"] forKey:@"mobile_code"];
    }else{
        [MBProgressHUD showInfoMessage:@"手机验证码不能为空"];
        return;
    }
    
    if (self.pDic[@"qq"] != nil) {
        [para setObject:self.pDic[@"qq"] forKey:@"qq"];
    }
    
    if (self.pDic[@"email"] != nil) {
        [para setObject:self.pDic[@"email"] forKey:@"email"];
    }
    
//    [[HRRequestManager manager] POST_PATH:Post_LoginRegister WithInit_session:self.pDic[@"password"] para:para success:^(id responseObject) {
//        if ([responseObject[@"status"] integerValue] == 1) {
//            NSLog(@"数据请求成功");
//
//            JYRegistTwoViewController *twoVC = [[JYRegistTwoViewController alloc] initWithNibName:@"JYRegistTwoViewController" bundle:nil];
//
//            twoVC.user_id = responseObject[@"data"][@"user_id"];
//            [self.navigationController pushViewController:twoVC animated:YES];
//        }
//    } failure:^(NSError *error) {
//
//    }];
    
    [[HRRequestManager manager] POST_PATH:Post_LoginRegister para:para  success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"数据请求成功");

            JYRegistTwoViewController *twoVC = [[JYRegistTwoViewController alloc] initWithNibName:@"JYRegistTwoViewController" bundle:nil];

            twoVC.user_id = responseObject[@"data"][@"user_id"];
            [self.navigationController pushViewController:twoVC animated:YES];
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
