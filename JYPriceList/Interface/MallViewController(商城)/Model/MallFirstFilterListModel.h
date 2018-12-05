//
//  MallFirstFilterListModel.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/6.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class MallSecondFilterListModel;
@interface MallFirstFilterListModel : BaseModel

/*
 "attr_id" = 36;
 "attr_name" = "周期";
 "cat_id" = 5;
 "sort_order" = 5;
 values =
 */

@property (nonatomic, strong) NSString *attr_id;

@property (nonatomic, strong) NSString *attr_name;

@property (nonatomic, strong) NSString *cat_id;

@property (nonatomic, strong) NSString *sort_order;

@property (nonatomic, strong) NSMutableArray *values;

@property (nonatomic, assign) BOOL isOpen;


@end

NS_ASSUME_NONNULL_END
