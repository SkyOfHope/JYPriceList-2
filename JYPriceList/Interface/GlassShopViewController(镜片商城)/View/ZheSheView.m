
//
//  ZheSheView.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/11.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "ZheSheView.h"

#import "CatListModel.h"

@interface ZheSheView ()

//折射率
@property (weak, nonatomic) IBOutlet UILabel *refractiveLab;
//阿贝数
@property (weak, nonatomic) IBOutlet UILabel *abbeLab;

//透射比
@property (weak, nonatomic) IBOutlet UILabel *transmittanceLab;

@end


@implementation ZheSheView

-(instancetype)init{
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ZheSheView" owner:self options:nil].lastObject;
    }
    
    return self;
}

-(void)buildZheSheViewModel:(CatListModel *)model{
    self.refractiveLab.text = model.refractive;
    self.abbeLab.text = model.abbe;
    self.transmittanceLab.text = model.transmittance;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
