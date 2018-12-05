//
//  MallDetailProductsModel.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/8.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MallDetailProductsModel : BaseModel

/*
 product_id = 26976,
 goods_attrs = (
 "0.00",
 ),
 goods_attr = "248063",
 product_price = "45.00",
 product_number = 11,
 mods = 1,
 */

@property (nonatomic, strong) NSString *product_id;

@property (nonatomic, strong) NSString *goods_attr;

@property (nonatomic, strong) NSString *product_price;

@property (nonatomic, strong) NSString *product_number;

@property (nonatomic, strong) NSString *mods;

@property (nonatomic, strong) NSMutableArray *goods_attrs;




@end

NS_ASSUME_NONNULL_END
