


//
//  BrandListSort.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/5.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "BrandListSort.h"

@implementation BrandListSort

-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"list"]) {
        self.list = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            BrandListModel *model = [[BrandListModel alloc]initWithDictionary:dic];
            [self.list addObject:model];
        }
    }else{
        [super setValue:value forKey:key];
    }
}

@end
