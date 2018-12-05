//
//  ShowQrcodeView.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/11.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowQrcodeView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *qrcodeImg;
@property (nonatomic, assign) BOOL isHide;
@property (nonatomic, assign) BOOL isHideLab;

@property (nonatomic, strong) NSString *imgUrlStr;

-(void)hideControl;

-(instancetype)initWithIsHideLab:(BOOL)isHideLab;

- (void)creatCIQRCodeImageWithStr:(NSString *)str;

@end
