//
//  JYRegistTwoTableViewCell.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/20.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JYRegistTwoTableViewCellBlock)(NSInteger tag,NSMutableDictionary *pDic);

@interface JYRegistTwoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *imgBtn;

@property (nonatomic, copy) JYRegistTwoTableViewCellBlock registTwoTableViewCellBlock;




@end
