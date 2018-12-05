//
//  MallDetailGoodsTableViewCell.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/26.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MallDetailProductsModel;
@interface MallDetailGoodsTableViewCell : UITableViewCell

@property (nonatomic, strong) MallDetailProductsModel *model;

@property (nonatomic, assign) BOOL isColor;

@property (nonatomic, strong) NSArray *attNameArr;

-(void)buildWithMallDetailProductsModel:(MallDetailProductsModel *)model;


@end

NS_ASSUME_NONNULL_END
