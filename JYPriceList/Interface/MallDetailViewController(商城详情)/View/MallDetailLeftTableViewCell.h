//
//  MallDetailLeftTableViewCell.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/26.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MallGoodsListModel;
@interface MallDetailLeftTableViewCell : UITableViewCell

@property (nonatomic, strong) MallGoodsListModel *model;

-(void)buildWithModel:(MallGoodsListModel *)model;


@end

NS_ASSUME_NONNULL_END
