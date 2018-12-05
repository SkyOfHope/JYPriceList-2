//
//  LeftTopView.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/10.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "LeftTopView.h"

@implementation LeftTopView

-(instancetype)init{
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"LeftTopView" owner:self options:nil].lastObject;
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
