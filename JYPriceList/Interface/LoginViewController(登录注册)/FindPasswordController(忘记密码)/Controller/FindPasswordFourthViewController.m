//
//  FindPasswordFourthViewController.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/14.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "FindPasswordFourthViewController.h"

@interface FindPasswordFourthViewController ()

@end

@implementation FindPasswordFourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - 点击事件
- (IBAction)backNavButtonClickAction:(UIButton *)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)buttonClickAction:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
