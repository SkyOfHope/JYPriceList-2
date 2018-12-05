//
//  HeadInfoView.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/10.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsListModel;

NS_ASSUME_NONNULL_BEGIN

@interface HeadInfoView : UIView

//@property (nonatomic, assign) NSInteger shopCount;
@property (nonatomic, strong) GoodsListModel *model;

-(void)buildWithShopCount:(NSInteger)shopCount;

-(void)buildWithGoodsListModel:(GoodsListModel *)model;


@end

NS_ASSUME_NONNULL_END
