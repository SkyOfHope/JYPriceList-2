//
//  GlassBrandNameCollectionViewCell.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/8/28.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrandListModel;
@interface GlassBrandNameCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)BrandListModel *model;

-(void)buildingWithModel:(BrandListModel *)model;

@end
