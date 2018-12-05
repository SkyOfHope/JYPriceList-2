//
//  ChoosePromptView.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/28.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChoosePromptViewBlock)(NSInteger cid);

@interface ChoosePromptView : UIView

@property (nonatomic, copy) ChoosePromptViewBlock choosePromptViewBlock;

@property (nonatomic, strong) NSArray *dataSourceArr;

@property (nonatomic, assign) BOOL isHide;

-(void)hideControl;


@end

NS_ASSUME_NONNULL_END
