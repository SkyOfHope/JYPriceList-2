//
//  MallBrandListModel.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/6.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MallBrandListModel : BaseModel

/*
 "brand_id" = 97;
 "brand_logo" = "https://img.jingku.cn/data/brandlogo/1503299430561792932.jpg";
 "brand_name" = "蓝视博得";
 selected = 0;
 */

@property (nonatomic, strong) NSString *brand_id;

@property (nonatomic, strong) NSString *brand_logo;

@property (nonatomic, strong) NSString *brand_name;

@property (nonatomic, strong) NSString *selected;


@end

NS_ASSUME_NONNULL_END
