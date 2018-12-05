//
//  MallSecondFilterListModel.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/6.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MallSecondFilterListModel : BaseModel

/*
 ed = 0;
 filter = "0.0.0.0.0.112085";
 id = 112085;
 value = "星绽棕";
 */
@property (nonatomic, strong) NSString *ed;

@property (nonatomic, strong) NSString *filter;

@property (nonatomic, strong) NSString *value;



@end

NS_ASSUME_NONNULL_END
