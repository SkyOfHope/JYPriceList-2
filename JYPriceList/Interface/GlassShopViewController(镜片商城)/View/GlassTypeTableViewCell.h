//
//  GlassTypeTableViewCell.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/10.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlassTypeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *glassTypeNameLab;

@property (nonatomic, assign) BOOL isTopShow;

-(void)buildWithNowArr:(NSArray *)nowArr;
-(void)buildWithSpecificArr:(NSArray *)specificArr;

@end

NS_ASSUME_NONNULL_END
