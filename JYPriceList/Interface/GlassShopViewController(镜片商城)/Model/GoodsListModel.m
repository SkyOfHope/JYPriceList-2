


//
//  GoodsListModel.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/6.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "GoodsListModel.h"

@implementation GoodsListModel

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


@end
