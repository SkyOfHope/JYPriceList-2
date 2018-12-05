//
//  MallCollectionViewCell.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/25.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MallGoodsListModel;

typedef void(^MallCollectionViewCellBlock)(NSInteger tag);

@interface MallCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) MallCollectionViewCellBlock mallCollectionViewCellBlock;

@property (nonatomic, strong) MallGoodsListModel *mallGoodsListModel;

-(void)buildWithModel:(MallGoodsListModel *)mallGoodsListModel;


@end

NS_ASSUME_NONNULL_END
