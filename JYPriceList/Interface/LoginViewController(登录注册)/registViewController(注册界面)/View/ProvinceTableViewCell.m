//
//  ProvinceTableViewCell.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/29.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "ProvinceTableViewCell.h"
#import "JYLoginRegionListModel.h"

@interface ProvinceTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation ProvinceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)buildWithModel:(JYLoginRegionListModel *)model{
    
    self.nameLab.text = model.region_name;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
