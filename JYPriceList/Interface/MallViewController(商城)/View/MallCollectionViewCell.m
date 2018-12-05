
//
//  MallCollectionViewCell.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/25.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "MallCollectionViewCell.h"

#import "MallGoodsListModel.h"

#import "ShowQrcodeView.h"

@interface MallCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *qrcodeBackView;
@property (nonatomic, strong) ShowQrcodeView *showQrcodeView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLab;
@property (weak, nonatomic) IBOutlet UILabel *priceNameLab;

@end


@implementation MallCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setUpUI];
}

-(void)setUpUI{
    
    self.backView.layer.cornerRadius = 10;
    self.backView.clipsToBounds = YES;
//    self.backView.layer.borderColor = [UIColor colorWithRed:166/255.0f green:168/255.0f blue:174/255.0f alpha:1.0].CGColor;
    self.backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.backView.layer.borderWidth = 1;
    
    self.qrcodeBackView.layer.cornerRadius = 15;
    self.qrcodeBackView.clipsToBounds = YES;
    
}

-(void)buildWithModel:(MallGoodsListModel *)mallGoodsListModel{
    
    self.shopNameLab.text = mallGoodsListModel.name;
    self.priceNameLab.text = mallGoodsListModel.market_price;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:mallGoodsListModel.goods_img]];
    
}

#pragma mark - 点击事件

- (IBAction)qrcodeButtonClickAction:(UIButton *)sender {
    
    self.mallCollectionViewCellBlock(sender.tag);
}

- (IBAction)detailButtonClickAction:(UIButton *)sender {
    
    self.mallCollectionViewCellBlock(sender.tag);
}



#pragma mark - 懒加载

-(ShowQrcodeView *)showQrcodeView{
    _showQrcodeView = [[ShowQrcodeView alloc] init];
    
    return _showQrcodeView;
}



@end
