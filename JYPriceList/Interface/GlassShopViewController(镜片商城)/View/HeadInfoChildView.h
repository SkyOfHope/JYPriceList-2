//
//  HeadInfoChildView.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/10.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CatListModel;

NS_ASSUME_NONNULL_BEGIN

@interface HeadInfoChildView : UIView

@property (nonatomic, strong) CatListModel *model;

-(void)buildWithCatListModel:(CatListModel *)model;

@end

NS_ASSUME_NONNULL_END
