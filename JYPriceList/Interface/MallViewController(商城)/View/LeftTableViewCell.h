//
//  LeftTableViewCell.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/6.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MallSecondFilterListModel;
@interface LeftTableViewCell : UITableViewCell

@property (nonatomic, strong) MallSecondFilterListModel *model;

-(void)buildWithModel:(MallSecondFilterListModel *)model;

@end

NS_ASSUME_NONNULL_END
