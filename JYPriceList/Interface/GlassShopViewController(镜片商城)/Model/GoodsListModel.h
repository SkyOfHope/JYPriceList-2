//
//  GoodsListModel.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/6.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "BaseModel.h"

#import "CatListModel.h"

@interface GoodsListModel : BaseModel

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSMutableArray *list;

@end
