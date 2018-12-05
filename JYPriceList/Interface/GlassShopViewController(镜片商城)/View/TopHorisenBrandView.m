

//
//  TopHorisenBrandView.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/8/31.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "TopHorisenBrandView.h"

#import "MallBrandListModel.h"

@interface TopHorisenBrandView()

@property (nonatomic, copy) void(^chooseBlock)(TopHorisenBrandView *view,NSString *cataId);
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation TopHorisenBrandView

-(instancetype)init{
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"TopHorisenBrandView" owner:self options:nil].lastObject;
        
        [self setUpUI];
    }
    
    return self;
}

-(void)setUpUI{
    self.iconBackView.layer.cornerRadius = 55/2;
    self.iconBackView.layer.masksToBounds = YES;
    self.iconBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.iconBackView.layer.borderWidth = 2;
    self.nameLab.textColor = [UIColor lightGrayColor];
    
}

-(void)buildWithModel:(SeriesListModel *)model{
    self.nameLab.text = model.series_name;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
}

-(void)buildWithMallBrandListModel:(MallBrandListModel *)mallBrandListModel{
    self.nameLab.text = mallBrandListModel.brand_name;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:mallBrandListModel.brand_logo]];
}


#pragma mark - 点击事件
- (IBAction)buttonClickAction:(UIButton *)sender {
    self.chooseBlock(self,self.tagCateID);
}


-(void)chooseAction:(void (^)(TopHorisenBrandView *, NSString *))comple{
    self.chooseBlock = comple;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
