//
//  TopHorisenBrandView.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/8/31.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "SeriesListModel.h"

@class MallBrandListModel;

@interface TopHorisenBrandView : UIView
@property (weak, nonatomic) IBOutlet UIButton *currentBtn;

@property (weak, nonatomic) IBOutlet UIView *iconBackView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (nonatomic, strong) NSString *tagCateID;


@property (nonatomic, strong)SeriesListModel *model;

@property (nonatomic, strong)MallBrandListModel *mallBrandListModel;

-(void)chooseAction:(void(^)(TopHorisenBrandView *view,NSString *cataId))comple;

-(void)buildWithModel:(SeriesListModel *)model;

-(void)buildWithMallBrandListModel:(MallBrandListModel *)mallBrandListModel;

@end
