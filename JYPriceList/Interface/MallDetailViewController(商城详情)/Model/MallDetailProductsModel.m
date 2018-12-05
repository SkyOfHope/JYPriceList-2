//
//  MallDetailProductsModel.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/8.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "MallDetailProductsModel.h"

@implementation MallDetailProductsModel

-(void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"goods_attrs"]) {
        self.goods_attrs = value;
    }else{
        [super setValue:value forKey:key];
    }
    
}



/*
 -(void)setValue:(id)value forKey:(NSString *)key{
 if ([key isEqualToString:@"list"]) {
 self.list = [NSMutableArray array];
 for (NSDictionary *dic in value) {
 CatListModel *model = [[CatListModel alloc] initWithDictionary:dic];
 [self.list addObject:model];
 }
 
 }else{
 [super setValue:value forKey:key];
 }
 }
 */

@end
