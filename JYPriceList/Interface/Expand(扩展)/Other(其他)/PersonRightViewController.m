//
//  PersonRightViewController.m
//  JYPriceList
//
//  Created by 解楚豪 on 2018/11/11.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "PersonRightViewController.h"

#import "JYLoginViewController.h"
#import "QRCodeScanViewController.h"

@interface PersonRightViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PersonRightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"个人中心";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    NSArray * arr = @[@"扫一扫",@"退出登录"];
    
    cell.textLabel.text = arr[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            NSLog(@"扫一扫");
            QRCodeScanViewController *showVC = [[QRCodeScanViewController alloc]init];
            UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
            [nav pushViewController:showVC animated:NO];
            [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
                [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
            }];

            
        }
            break;
        case 1:{
            NSLog(@"退出登录");
            JYLoginViewController *loginVC = [[JYLoginViewController alloc] initWithNibName:@"JYLoginViewController" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [nav setNavigationBarHidden:YES];
            [[UIApplication sharedApplication].keyWindow setRootViewController:nav];
//            self.window.rootViewController = nav;
        }
            break;
            
        default:
            break;
    }
    if (indexPath.row == 0) {
        
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 懒加载

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.alwaysBounceVertical = NO;
    }
    
    return _tableView;
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
