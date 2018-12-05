//
//  MallDetailViewController.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/26.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "JYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MallDetailDelegate <NSObject>

-(void)TopSelectNum:(NSInteger)num;

@end


@interface MallDetailViewController : JYBaseViewController

//商品组Id
@property (nonatomic, strong) NSString *mallDetailId;

//顶部横画数据
@property (nonatomic, strong) NSMutableArray *topDataArr;
//左侧列表数据
@property (nonatomic, strong) NSMutableArray *leftDataArr;

@property (nonatomic, assign) NSInteger topSelectNum;

@property (nonatomic, assign) NSInteger leftSelectCellRow;

@property (nonatomic, assign) NSInteger leftListCurrentPage;

@property (nonatomic, strong) NSString *leftListFilter;

@property (nonatomic, strong) NSString *leftListCat_id;

@property (nonatomic, strong) NSString *leftListBid;

@property (nonatomic, weak) id <MallDetailDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
