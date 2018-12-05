//
//  MallGoodsListModel.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/7.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MallGoodsListModel : BaseModel

/*
 "" = 468;
 "goods_id" = 9424;
 id = 374;
 keywords = "";
 "market_price" = "¥118.00";
 name = "博士伦美瞳蕾丝炫眸半年抛彩色隐形眼镜1片装-棕色";
 thumb = "https://img.jingku.cn/images/201805/thumb_img/9424_thumb_G_15
 */

@property (nonatomic, strong) NSString *cat_id;

@property (nonatomic, strong) NSString *goods_id;

@property (nonatomic, strong) NSString *keywords;

@property (nonatomic, strong) NSString *market_price;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *thumb;

@property (nonatomic, strong) NSString *qrcode_id;

@property (nonatomic, strong) NSString *goods_img;


@end

NS_ASSUME_NONNULL_END
