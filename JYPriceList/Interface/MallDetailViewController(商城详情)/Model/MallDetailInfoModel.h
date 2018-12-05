//
//  MallDetailInfoModel.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/8.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MallDetailInfoModel : BaseModel

/*
 goods_desc = "<p style="text-align: center;"><img src="http://img.jingku.cn//images/upload/20171110/1510280871133570.jpg" title="1510280871133570.jpg" alt="详情.jpg"/></p>",
 goods_name = "博士伦蕾丝闪眸日抛隐形眼镜10片装灰色",
 goods_id = 9415,
 */

@property (nonatomic, copy) NSMutableString *goods_desc;

@property (nonatomic, strong) NSString *goods_name;

@property (nonatomic, strong) NSString *goods_id;

@property (nonatomic, strong) NSString *shop_price;

@property (nonatomic, strong) NSString *goods_img;

@property (nonatomic, strong) NSString *goods_thumb;

@property (nonatomic, strong) NSString *qrcode_id;

@end

NS_ASSUME_NONNULL_END
