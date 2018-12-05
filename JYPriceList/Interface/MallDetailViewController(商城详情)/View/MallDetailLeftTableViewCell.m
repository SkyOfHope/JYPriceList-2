//
//  MallDetailLeftTableViewCell.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/26.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "MallDetailLeftTableViewCell.h"

#import "MallGoodsListModel.h"

@interface MallDetailLeftTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIView *imgBackView;


@end

@implementation MallDetailLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)buildWithModel:(MallGoodsListModel *)model{
    
    self.nameLab.text = model.name;
    self.priceLab.text = model.market_price;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected == YES) {
        self.imgBackView.backgroundColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1];
    }else{
        self.imgBackView.backgroundColor = [UIColor lightGrayColor];
    }
    
    // Configure the view for the selected state
}

@end
