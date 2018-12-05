


//
//  CatListModel.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/11.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "CatListModel.h"

@implementation CatListModel

-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"product"] || [key isEqualToString:@"products"]) {
        self.product = [NSMutableArray array];
        if ([value isKindOfClass: [NSDictionary class]]) {
            NSDictionary *dic = value;
            NSArray *dicArr = dic.allValues;
            NSDictionary *dicTwo = dicArr.firstObject;
            NSArray *dicTwoArr = dicTwo.allValues;
            NSLog(@"%@",dicTwoArr);
            [self.product addObject:dicTwoArr];

        }
        for (id content in value) {
            if ([content isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = (NSDictionary *)content;
                NSArray *array = dic.allValues;
                [self.product addObject:array];
                
            }
            
        }
        
    }else{
        [super setValue:value forKey:key];
    }
}


@end
