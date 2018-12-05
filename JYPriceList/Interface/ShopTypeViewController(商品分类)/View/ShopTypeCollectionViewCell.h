//
//  ShopTypeCollectionViewCell.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/24.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ShopCatListModel;
@interface ShopTypeCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString *shopCatListModel;

-(void)buildWithModel:(ShopCatListModel *)shopCatListModel;


@end

NS_ASSUME_NONNULL_END
