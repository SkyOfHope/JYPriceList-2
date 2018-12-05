//
//  ShowLogoutView.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/17.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "ShowLogoutView.h"

#import "JYLoginViewController.h"

@implementation ShowLogoutView

-(instancetype)init{
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ShowLogoutView" owner:self options:nil].lastObject;
    }
    
    return self;
}

//隐藏界面
-(void)hideControl{
    
    [UIView animateWithDuration:.3 animations:^{
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -----点击事件
- (IBAction)buttonClickAction:(UIButton *)sender {
    
    if (sender.tag == 2) {
        [self hideControl];
    }else if (sender.tag == 1){
//        NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
//        NSDictionary* dict = [defs dictionaryRepresentation];
//        for(id key in dict) {
//            [defs removeObjectForKey:key];
//        }
//        [defs synchronize];
        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        [defaults removeObjectForKey:@"token"];
        
        [defaults synchronize];
//        JYLoginViewController *loginVC = [[JYLoginViewController alloc] initWithNibName:@"JYLoginViewController" bundle:nil];
//        [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
        
        JYLoginViewController *loginVC = [[JYLoginViewController alloc] initWithNibName:@"JYLoginViewController" bundle:nil];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [nav setNavigationBarHidden:YES];
        self.window.rootViewController = nav;
    }
    
}

//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([event touchesForView:self]) {
        [self hideControl];
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
