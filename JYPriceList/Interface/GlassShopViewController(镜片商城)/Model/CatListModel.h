//
//  CatListModel.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/11.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "BaseModel.h"

#import "ProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CatListModel : BaseModel

/*
 abbe = "1.99";
 "cat_id" = 3;
 "custom_guangdu" = "https://img.jingku.cn/";
 "goods_id" = "<null>";
 id = 14;
 name = "超厚型";
 "now_guangdu" =
 
 refractive = "1.99";
 "series_id" = 1;
 "sort_order" = 0;
 transmittance = "1.99";
 "variety_id" = "<null>";
 */

//阿贝数
@property (nonatomic, strong) NSString *abbe;

//折射率
@property (nonatomic, strong) NSString *refractive;

//透射比
@property (nonatomic, strong) NSString *transmittance;

//现片光度范围图片
@property (nonatomic, strong) NSString *now_guangdu;

//定制片光度范围图片
@property (nonatomic, strong) NSString *custom_guangdu;

//
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSMutableArray *product;




@end

NS_ASSUME_NONNULL_END
