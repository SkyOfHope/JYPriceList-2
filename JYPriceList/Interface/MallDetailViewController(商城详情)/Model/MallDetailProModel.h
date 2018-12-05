//
//  MallDetailProModel.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/8.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MallDetailProModel : BaseModel

/*
 name = "色系",
 value = "灰色",
 */

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *value;



@end

NS_ASSUME_NONNULL_END
