//
//  ProductModel.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/7.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "BaseModel.h"

@interface ProductModel : BaseModel

/*
 "goods_id" = 2;
 id = 21;
 "is_dingz" = 1;
 "is_qium" = 0;
 price = "521.00";
 qrcode = "<null>";
 relation = "";
 "variety_id" = 2;
 "variety_name" = "唯品膜（VP）11";
 */


@property (nonatomic, copy) NSString *goods_id;
//@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) NSInteger is_dingz;
@property (nonatomic, copy) NSString *is_qium;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *qrcode;
@property (nonatomic, copy) NSString *relation;
@property (nonatomic, copy) NSString *variety_id;
@property (nonatomic, copy) NSString *variety_name;




@end
