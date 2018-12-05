//
//  JYRegistOneTableViewCell.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/20.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JYRegistOneTableViewCellBlock)(NSMutableDictionary *mDic);

@interface JYRegistOneTableViewCell : UITableViewCell

@property (nonatomic, copy)JYRegistOneTableViewCellBlock registOneTableViewCellBlock;

@property (nonatomic, strong)NSString *user_name;



@end
