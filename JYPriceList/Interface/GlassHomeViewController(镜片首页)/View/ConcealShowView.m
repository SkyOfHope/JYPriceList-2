//
//  ConcealShowView.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/23.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "ConcealShowView.h"

@interface ConcealShowView ()

@property (weak, nonatomic) IBOutlet UIView *backView;


@end


@implementation ConcealShowView

-(instancetype)init{
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ConcealShowView" owner:self options:nil].lastObject;
    }
    
    self.backView.layer.cornerRadius = 10;
    self.backView.layer.masksToBounds = YES;
    
    return self;
}

//隐藏界面
-(void)hideControl{
    
    [UIView animateWithDuration:.3 animations:^{
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([event touchesForView:self]) {
//        [self hideControl];
        [MBProgressHUD showErrorMessage:@"请选择同意，否则您将无法使用此APP"];
    }
    
}

- (IBAction)buttonClickAction:(UIButton *)sender {
    if (sender.tag == 1) {
        [self hideControl];
    }else{
        [MBProgressHUD showErrorMessage:@"请选择同意，否则您将无法使用此APP"];
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
