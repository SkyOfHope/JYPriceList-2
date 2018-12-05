//
//  InfoTableViewCell.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/11.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^InfoTableViewCellBlock)(NSString *qrcodeImg);

NS_ASSUME_NONNULL_BEGIN

@interface InfoTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *topDataArr;
@property (nonatomic, strong) NSArray *nowDataArr;
@property (nonatomic, strong) NSArray *specificDataArr;
@property (nonatomic, assign) NSInteger currentDataType;

@property (nonatomic, assign) BOOL isTopShow;

@property (nonatomic, strong) InfoTableViewCellBlock infoTableViewCellBlock;

-(void)configShopCountWithArr:(NSArray *)goodsListDataArr;

//-(void)setUpUIWithNowArr:(NSArray *)nowArr WithSpecificArr:(NSArray *)secificArr;


@end

NS_ASSUME_NONNULL_END
