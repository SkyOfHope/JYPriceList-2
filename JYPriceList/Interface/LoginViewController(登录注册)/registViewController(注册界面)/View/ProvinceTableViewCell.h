//
//  ProvinceTableViewCell.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/29.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JYLoginRegionListModel;

NS_ASSUME_NONNULL_BEGIN

@interface ProvinceTableViewCell : UITableViewCell

@property (nonatomic, strong) JYLoginRegionListModel *model;

-(void)buildWithModel:(JYLoginRegionListModel *)model;

@end

NS_ASSUME_NONNULL_END
