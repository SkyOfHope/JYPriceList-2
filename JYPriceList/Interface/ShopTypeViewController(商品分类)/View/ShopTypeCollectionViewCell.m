//
//  ShopTypeCollectionViewCell.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/24.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "ShopTypeCollectionViewCell.h"

#import "ShopCatListModel.h"

@interface ShopTypeCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIView *imgBackView;

@end


@implementation ShopTypeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgBackView.layer.cornerRadius = 55;
    self.imgBackView.clipsToBounds = YES;
    
    
}

-(void)buildWithModel:(ShopCatListModel *)shopCatListModel{
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shopCatListModel.thumb]];
    self.nameLab.text = shopCatListModel.cat_name;
    
}



@end
