//
//  GlassTypeTableViewCell.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/10.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "GlassTypeTableViewCell.h"

#import "TagNameView.h"

@interface GlassTypeTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *goodsTypeBackView;
@property (nonatomic, strong) TagNameView *tagNameView;

@property (nonatomic, assign) CGFloat leftTableViewHeight;
@property (nonatomic, assign) CGFloat tagViewHeight;
//@property (nonatomic, assign) CGFloat leftViewHeight;
//@property (nonatomic, assign) CGFloat juDingBuHeight;
//@property (nonatomic, assign) CGFloat zheSheHeight;
//@property (nonatomic, assign) CGFloat guangDuHeight;

@end 

@implementation GlassTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    //self.tagViewHeight = 50;
//    self.leftViewHeight = 90;
//    self.juDingBuHeight = 140;
//    self.zheSheHeight = 72;
//    self.guangDuHeight = 130;
    
//    self.leftTableViewHeight = ScreenHeight - self.leftViewHeight - self.juDingBuHeight - 64 - 20-8;
    self.leftTableViewHeight = ScreenHeight - JYGlassShopVCLeftViewHeight - JYGlassShopVCTopHeight - JYGlassShopVCNavHeight - 20-8;
    
    
}

-(void)buildWithNowArr:(NSArray *)nowArr{
    if (self.isTopShow == YES){
//        self.leftTableViewHeight = ScreenHeight - self.leftViewHeight - 20 - 64 - 20-8;
        self.leftTableViewHeight = ScreenHeight - JYGlassShopVCLeftViewHeight - 20 - JYGlassShopVCNavHeight - 20-8;
    }else{
//        self.leftTableViewHeight = ScreenHeight - self.leftViewHeight - self.juDingBuHeight - 64 - 20-8;
        self.leftTableViewHeight = ScreenHeight - JYGlassShopVCLeftViewHeight - JYGlassShopVCTopHeight - JYGlassShopVCNavHeight - 20-8;
    }
//    self.tagViewHeight = (self.leftTableViewHeight - self.zheSheHeight - self.guangDuHeight)/nowArr.count-2;
    self.tagViewHeight = (self.leftTableViewHeight - JYGlassShopVCZheSheHeight - JYGlassShopVCGuangDuHeight)/nowArr.count;
    
    [self.goodsTypeBackView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i< nowArr.count; i++) {
        self.tagNameView = [[TagNameView alloc] init];
        self.tagNameView.frame = CGRectMake(0, i*self.tagViewHeight, self.goodsTypeBackView.width, self.tagViewHeight);
        self.tagNameView.tagNameLab.text = nowArr[i];
        [self.goodsTypeBackView addSubview:self.tagNameView];
    }
}

-(void)buildWithSpecificArr:(NSArray *)specificArr{
    if (self.isTopShow == YES){
//        self.leftTableViewHeight = ScreenHeight - self.leftViewHeight - 20 - 64 - 20-8;
        self.leftTableViewHeight = ScreenHeight - JYGlassShopVCLeftViewHeight - 20 - JYGlassShopVCNavHeight - 20-8;
    }else{
//        self.leftTableViewHeight = ScreenHeight - self.leftViewHeight - self.juDingBuHeight - 64 - 20-8;
        self.leftTableViewHeight = ScreenHeight - JYGlassShopVCLeftViewHeight - JYGlassShopVCTopHeight - JYGlassShopVCNavHeight - 20-8;
//        self.leftTableViewHeight = ScreenHeight - self.leftViewHeight - self.juDingBuHeight - 64 - 20-8;
        self.leftTableViewHeight = ScreenHeight - JYGlassShopVCLeftViewHeight - JYGlassShopVCTopHeight - JYGlassShopVCNavHeight - 20-8;
    }
//    self.tagViewHeight = (self.leftTableViewHeight - self.zheSheHeight - self.guangDuHeight)/specificArr.count;
    self.tagViewHeight = (self.leftTableViewHeight - JYGlassShopVCZheSheHeight - JYGlassShopVCGuangDuHeight)/specificArr.count;
    
    [self.goodsTypeBackView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i< specificArr.count; i++) {
        self.tagNameView = [[TagNameView alloc] init];
        self.tagNameView.frame = CGRectMake(0, i*self.tagViewHeight, self.goodsTypeBackView.width, self.tagViewHeight);
        self.tagNameView.tagNameLab.text = specificArr[i];
        [self.goodsTypeBackView addSubview:self.tagNameView];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
