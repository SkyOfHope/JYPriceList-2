//
//  PromptTableViewCell.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/28.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginCompanyModel;

NS_ASSUME_NONNULL_BEGIN

@interface PromptTableViewCell : UITableViewCell

@property (nonatomic, strong)LoginCompanyModel *loginCompanyModel;

-(void)buildWithModel:(LoginCompanyModel *)loginCompanyModel;

@end

NS_ASSUME_NONNULL_END
