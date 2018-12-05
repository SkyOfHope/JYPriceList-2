//
//  GlobalVariable.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/27.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "GlobalVariable.h"

@implementation GlobalVariable

@synthesize strTest;

+(GlobalVariable *)sharedGlobalVariable{
    static GlobalVariable *globalVariable;
    @synchronized (self) {
        //线程锁,防止数据呗多线程操作
        
        if (!globalVariable) {
            globalVariable = [[GlobalVariable alloc] init];
        }
        
        return globalVariable;
    }
    
}

-(id)init{
    if (self = [super init]) {
        strTest = @"原始字符串";
        self.isHorisen = YES;
        self.isCheck = NO;
    }
    
    return self;
}


@end
