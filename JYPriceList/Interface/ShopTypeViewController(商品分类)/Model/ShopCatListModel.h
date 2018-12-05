//
//  ShopCatListModel.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/5.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopCatListModel : BaseModel

/*
 "" = 9;
 "cat_name" = "工具";
 thumb = "https://img.jingku.cn/data/catthumb/1466585104740368683.png";
 */

@property (nonatomic, strong) NSString *cat_id;

@property (nonatomic, strong) NSString *cat_name;

@property (nonatomic, strong) NSString *thumb;



@end

NS_ASSUME_NONNULL_END
