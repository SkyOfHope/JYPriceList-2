
//
//  GlassBrandNameCollectionViewCell.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/8/28.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "GlassBrandNameCollectionViewCell.h"

#import "BrandListModel.h"

@interface GlassBrandNameCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;


@end


@implementation GlassBrandNameCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.backView.layer.cornerRadius = 60;
//    self.backView.layer.masksToBounds = YES;
    
    self.imageView.layer.cornerRadius = 60;
    self.imageView.clipsToBounds = YES;
    self.backView.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影的偏移量，默认是（0， -3）
    self.backView.layer.shadowOffset = CGSizeMake(2, 2);
    // 设置阴影不透明度，默认是0
    self.backView.layer.shadowOpacity = 0.7;
    // 设置阴影的半径，默认是3
    self.backView.layer.shadowRadius = 5;
    self.backView.layer.cornerRadius = 60.0;
    self.backView.clipsToBounds = NO;
    
}

-(void)buildingWithModel:(BrandListModel *)model{
    self.nameLab.text = model.brand_name;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
}


@end
