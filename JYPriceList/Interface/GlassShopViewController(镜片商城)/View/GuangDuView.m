//
//  GuangDuView.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/11.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "GuangDuView.h"

#import "CatListModel.h"

#import "ShowQrcodeView.h"

@interface GuangDuView ()

@property (weak, nonatomic) IBOutlet UIImageView *guangDuImgView;

@property (nonatomic, strong) ShowQrcodeView *showQrcodeView;

@property (nonatomic, strong) NSString *currentImgUrl;

@end

@implementation GuangDuView

-(instancetype)init{
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"GuangDuView" owner:self options:nil].lastObject;
    }
    
    return self;
}



-(void)buildNowGuangDuModel:(CatListModel *)model{
    
    [self.guangDuImgView sd_setImageWithURL:[NSURL URLWithString:model.now_guangdu]];
    
    self.currentImgUrl = model.now_guangdu;
    
}

-(void)buildSpecifGuangDuModel:(CatListModel *)model{
    [self.guangDuImgView sd_setImageWithURL:[NSURL URLWithString:model.custom_guangdu]];
    
    self.currentImgUrl = model.custom_guangdu;
}

#pragma mark - 点击事件
- (IBAction)buttonClickAction:(UIButton *)sender {
    
    self.showQrcodeView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.showQrcodeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    
    [self.showQrcodeView.qrcodeImg sd_setImageWithURL:[NSURL URLWithString:self.currentImgUrl]];
    [[UIApplication sharedApplication].keyWindow addSubview:self.showQrcodeView];
}


#pragma mark - 懒加载
-(ShowQrcodeView *)showQrcodeView{
    if (!_showQrcodeView) {
        _showQrcodeView = [[ShowQrcodeView alloc] initWithIsHideLab:YES];
    }
    
    return _showQrcodeView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
