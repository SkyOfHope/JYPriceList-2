
//
//  HeadInfoView.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/10.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "HeadInfoView.h"

#import "HeadInfoChildView.h"

#import "GoodsListModel.h"
#import "CatListModel.h"

@interface HeadInfoView()

@property (weak, nonatomic) IBOutlet UILabel *headInfoNameLab;

@property (weak, nonatomic) IBOutlet UIView *allShopInfoBackView;
@property (nonatomic, strong) HeadInfoChildView *headInfoChildView;

@property (nonatomic, assign) CGFloat infoWidth;
@property (nonatomic, assign) CGFloat leftViewHeight;

@end

@implementation HeadInfoView

-(instancetype)init{
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"HeadInfoView" owner:self options:nil].lastObject;
    }
    
    self.leftViewHeight = 90;
    self.infoWidth = 200;
    
    return self;
}

-(void)buildWithGoodsListModel:(GoodsListModel *)model{
    
    for (int i = 0; i< model.list.count; i++) {
        self.headInfoChildView = [[HeadInfoChildView alloc] init];
        self.headInfoChildView.frame = CGRectMake(i*(200+1.5), 0, 200, self.leftViewHeight - 35);
        
        CatListModel *catListModel = model.list[i];
        
        [self.headInfoChildView buildWithCatListModel:catListModel];
        
        self.headInfoNameLab.text = model.name;
        
        [self.allShopInfoBackView addSubview:self.headInfoChildView];
        
    }
}

-(void)buildWithShopCount:(NSInteger)shopCount{
    
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
