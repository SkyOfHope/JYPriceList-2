
//
//  PromptTableViewCell.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/28.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "PromptTableViewCell.h"

#import "LoginCompanyModel.h"

@interface PromptTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;


@end

@implementation PromptTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)buildWithModel:(LoginCompanyModel *)loginCompanyModel{
    
    self.nameLab.text = loginCompanyModel.cname;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
