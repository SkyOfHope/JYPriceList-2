//
//  BrandListModel.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/5.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "BaseModel.h"

@interface BrandListModel : BaseModel

@property (nonatomic, copy) NSString *brand_name;
@property (nonatomic, assign) NSInteger brand_id;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, assign) BOOL is_on_shelf;
@property (nonatomic, copy) NSString *letter;
@property (nonatomic, assign) NSInteger sort_order;
@property (nonatomic, assign) NSInteger source;


@end
