//
//  BaseModel.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/5.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic, copy) NSString *ID;
- (id)initWithDictionary:(NSDictionary*)jsonDic;


@end
