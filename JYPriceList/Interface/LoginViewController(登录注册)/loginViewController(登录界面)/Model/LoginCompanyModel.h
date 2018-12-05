//
//  LoginCompanyModel.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/28.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginCompanyModel : BaseModel

@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, copy) NSString *cname;

@end

NS_ASSUME_NONNULL_END
