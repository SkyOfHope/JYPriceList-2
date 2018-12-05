//
//  SearchResultTableViewCell.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/8/30.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^SearchResultTableViewCellBlock)(NSInteger tag);

@interface SearchResultTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *zimuLab;
@property (weak, nonatomic) IBOutlet UIView *tagBackView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, copy) SearchResultTableViewCellBlock searchResultTableViewCellBlock;


-(void)setCellWithArr:(NSArray *)arr;

@end
