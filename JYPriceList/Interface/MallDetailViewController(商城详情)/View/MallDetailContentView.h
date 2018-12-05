//
//  MallDetailContentView.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/9.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MallGoodsInfoModel;
@interface MallDetailContentView : UIView

@property (nonatomic, strong) NSArray *attrNameArr;

@property (nonatomic, assign) CGFloat topLayout;


@property (nonatomic, assign) CGFloat goodsProViewHeight;

-(instancetype)initWithModel:(MallGoodsInfoModel *)model;
-(void)setUpUI;

@end

NS_ASSUME_NONNULL_END
