//
//  GlobalVariable.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/27.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalVariable : NSObject{
    NSString *strTest;
//    BOOL isHorisen;
}

@property (nonatomic, strong) NSString *strTest;
@property (nonatomic, assign) BOOL isHorisen;
@property (nonatomic, assign) BOOL isCheck;

+(GlobalVariable *)sharedGlobalVariable;

@end

NS_ASSUME_NONNULL_END
