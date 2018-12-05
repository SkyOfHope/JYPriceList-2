
//
//  SearchResultTableViewCell.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/8/30.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "SearchResultTableViewCell.h"

#import "BrandListModel.h"

@interface SearchResultTableViewCell()

@property (nonatomic, strong) UIColor *textColorNormal;
@property (nonatomic, strong) UIColor *textColorSelected;
@property (nonatomic, strong) UIColor *backgroundColorSelected;
@property (nonatomic, strong) UIColor *backgroundColorNormal;

@property (nonatomic, strong) NSArray *tagArr;

@end

@implementation SearchResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setCellWithArr:(NSArray *)arr{
    
    CGFloat H_distance = 15.0;//间距——高
    CGFloat W_distance = 13.0;//间距——宽
    
    CGFloat sum_w = W_distance;//总宽
    CGFloat sum_h = 0;//总高
    CGFloat one_width = self.tagBackView.width/2/10.0f;//一个字符所占宽度
    CGFloat sum_w_befor = sum_w;
    
  
    for (int i = 0; i<arr.count; i++) {
        
        BrandListModel *model = arr[i];
        
        //提取数据的大小
//        NSString *str = arr[i];
        NSString *str = model.brand_name;
        NSInteger numberOfStr = str.length;
        //把标签的宽度加入总宽中
        sum_w_befor = sum_w;//没有累加前的总宽，为了给label赋位置。
        sum_w += W_distance + numberOfStr*one_width;//累加后的宽为了判断是否折行。
        
        if (sum_w>self.tagBackView.width) {//如果宽度超过了屏幕宽 则折行
            sum_w = W_distance;
            sum_w_befor = sum_w;
            sum_w += W_distance + numberOfStr*one_width;//折行后数据的处理（难点，少了我不少脑细胞）
            sum_h+= H_distance+30;
            
        }
        
        UILabel *textLabl = [[UILabel alloc]initWithFrame:CGRectMake(sum_w_befor, sum_h+H_distance,numberOfStr*one_width+10, 30)];
        textLabl.textAlignment = NSTextAlignmentCenter;
        textLabl.layer.cornerRadius = 2;
        textLabl.layer.masksToBounds = YES;
        textLabl.layer.borderWidth = 1;
        textLabl.layer.borderColor =[UIColor lightGrayColor].CGColor;
        textLabl.font = [UIFont systemFontOfSize:15];
        textLabl.text = str;
        [self.tagBackView addSubview:textLabl];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(sum_w_befor, sum_h+H_distance, numberOfStr*one_width, 30);
        btn.titleLabel.text = @"";
        btn.tag = model.brand_id;
        [btn addTarget:self action:@selector(TagBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tagBackView addSubview:btn];
        
    }
    sum_h+=H_distance+H_distance+ 30;

}

-(void)TagBtnAction:(UIButton *)btn{
    NSLog(@"点击点击点击");
    
    self.searchResultTableViewCellBlock(btn.tag);
    
    
}


@end
