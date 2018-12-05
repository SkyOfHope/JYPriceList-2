//
//  MallGoodsInfoModel.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/13.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "MallGoodsInfoModel.h"

@implementation MallGoodsInfoModel

-(void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"info"]) {
        self.detailInfoModel = [[MallDetailInfoModel alloc] initWithDictionary:value];
    }else if ([key isEqualToString:@"gallery"]) {
        self.gallery = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            MallDetailGalleryModel *model = [[MallDetailGalleryModel alloc] initWithDictionary:dic];
            [self.gallery addObject:model];
        }
    }else if ([key isEqualToString:@"pro"]) {
        self.pro = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            MallDetailProModel *model = [[MallDetailProModel alloc] initWithDictionary:dic];
            [self.pro addObject:model];
        }
    }else if ([key isEqualToString:@"products"]) {
        self.products = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            MallDetailProductsModel *model = [[MallDetailProductsModel alloc] initWithDictionary:dic];
            [self.products addObject:model];
        }
    }else{
        [super setValue:value forKey:key];
    }

}


-(CGFloat)goodsProViewHeight{
    
    if (self.pro.count % 3 == 0) {
        NSLog(@"整除");
        if (self.pro.count > 0) {
            _goodsProViewHeight = self.pro.count/3 * 40 + (self.pro.count/3 + 2)*5;
        }else{
            _goodsProViewHeight = 0;
        }
        
    }else{
        NSLog(@"除不尽");
        if (self.pro.count > 0) {
            _goodsProViewHeight = (self.pro.count/3 + 1) * 40 + (self.pro.count/3 + 2)*5;
        }
    }
    
    return _goodsProViewHeight;
}




@end
