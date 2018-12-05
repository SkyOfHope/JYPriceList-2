
//
//  HeadInfoChildView.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/10.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "HeadInfoChildView.h"

#import "CatListModel.h"

@interface HeadInfoChildView()
@property (weak, nonatomic) IBOutlet UILabel *childInfoViewNameLab;


@end

@implementation HeadInfoChildView

-(instancetype)init{
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"HeadInfoChildView" owner:self options:nil].lastObject;
    }
    
    return self;
}

-(void)buildWithCatListModel:(CatListModel *)model{
    
    self.childInfoViewNameLab.text = model.name;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
