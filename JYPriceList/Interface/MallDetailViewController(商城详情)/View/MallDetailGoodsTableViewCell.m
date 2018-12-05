//
//  MallDetailGoodsTableViewCell.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/26.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "MallDetailGoodsTableViewCell.h"

#import "MallDetailTagView.h"

#import "MallDetailProductsModel.h"

@interface MallDetailGoodsTableViewCell (){
    CGFloat tagHeight;
}

@property (nonatomic, strong) MallDetailTagView *tagView;
@property (weak, nonatomic) IBOutlet UIView *backView;


@end

@implementation MallDetailGoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    tagHeight = 38.5;
    
}

-(void)buildWithMallDetailProductsModel:(MallDetailProductsModel *)model{
    
    CGFloat tagWidth = (ScreenWidth - 140 - 300 - model.goods_attrs.count-1)/(model.goods_attrs.count+2);
    
    for (int i =0; i < model.goods_attrs.count+2; i++) {
        self.tagView = [[MallDetailTagView alloc] init];
        self.tagView.frame = CGRectMake(i*(tagWidth+1), 1.5, tagWidth, tagHeight);
        if (i<model.goods_attrs.count) {
            self.tagView.tagNameLab.text = [NSString stringWithFormat:@"%@:%@",self.attNameArr[i],model.goods_attrs[i]];
        }else if (i == model.goods_attrs.count){
            self.tagView.tagNameLab.text = [NSString stringWithFormat:@"价格:%@",model.product_price];
        }else if (i == model.goods_attrs.count + 1){
            self.tagView.tagNameLab.text = [NSString stringWithFormat:@"库存:%@",model.product_number];
        }
        if (self.isColor == YES) {
            self.tagView.tagBackView.backgroundColor = [UIColor colorWithRed:242/255.0f green:244/255.0f blue:247/255.0f alpha:1.0];
        }else{
            self.tagView.tagBackView.backgroundColor = [UIColor colorWithRed:237/255.0f green:239/255.0f blue:242/255.0f alpha:1.0];
        }
        

        [self.backView addSubview:self.tagView];
    }
    
    
}



#pragma mark - 懒加载



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
