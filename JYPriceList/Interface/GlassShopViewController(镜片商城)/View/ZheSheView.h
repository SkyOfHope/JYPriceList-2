//
//  ZheSheView.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/11.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CatListModel;
NS_ASSUME_NONNULL_BEGIN

@interface ZheSheView : UIView

@property (nonatomic, strong)CatListModel *model;

-(void)buildZheSheViewModel:(CatListModel *)model;

@end

NS_ASSUME_NONNULL_END
