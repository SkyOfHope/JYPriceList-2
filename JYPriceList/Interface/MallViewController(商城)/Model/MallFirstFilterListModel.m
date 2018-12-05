//
//  MallFirstFilterListModel.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/6.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "MallFirstFilterListModel.h"

#import "MallSecondFilterListModel.h"

@implementation MallFirstFilterListModel

-(void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"values"]) {
        self.values = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            MallSecondFilterListModel *model = [[MallSecondFilterListModel alloc] initWithDictionary:dic];
            [self.values addObject:model];
        }
        
    }else{
        
        [super setValue:value forKey:key];
    }
    
    
}



@end
