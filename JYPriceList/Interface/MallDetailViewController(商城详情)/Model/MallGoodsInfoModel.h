//
//  MallGoodsInfoModel.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/13.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "BaseModel.h"

#import "MallDetailGalleryModel.h"

#import "MallDetailProModel.h"

#import "MallDetailProductsModel.h"

#import "MallDetailInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MallGoodsInfoModel : BaseModel

@property (nonatomic, strong) MallDetailInfoModel *detailInfoModel;

@property (nonatomic, strong) NSMutableArray *gallery;

@property (nonatomic, strong) NSMutableArray *pro;

@property (nonatomic, strong) NSMutableArray *products;

@property (nonatomic, assign) CGFloat goodsProViewHeight;

@end

NS_ASSUME_NONNULL_END
