
//
//  InfoTableViewCell.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/11.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "InfoTableViewCell.h"

#import "TagNameView.h"
#import "ZheSheView.h"
#import "GuangDuView.h"

#import "GoodsListModel.h"
#import "CatListModel.h"

@interface InfoTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *infoBackView;


@property (nonatomic, strong) TagNameView *tagView;
@property (nonatomic, strong) ZheSheView *zheSheView;
@property (nonatomic, strong) GuangDuView *guangDuViwe;

@property (nonatomic, strong) UIView *shopView;
@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) UIView *xianPianView;
@property (nonatomic, strong) UIView *dingZhiPianView;

@property (nonatomic, assign) CGFloat totleWidth;
@property (nonatomic, assign) CGFloat shopWidth;
@property (nonatomic, assign) CGFloat shopX;
//@property (nonatomic, assign) CGFloat infoWitdh;
@property (nonatomic, assign) CGFloat tagHeight;
//@property (nonatomic, assign) CGFloat guangDuHeight;
//@property (nonatomic, assign) CGFloat zheSheHeight;

//@property (nonatomic, assign) CGFloat leftViewHeight;
//@property (nonatomic, assign) CGFloat juDingBuHeight;
@property (nonatomic, assign) CGFloat shopHeight;


@property (nonatomic, strong) NSArray *productArr;
@property (nonatomic, assign) BOOL isQrcode;
@property (nonatomic, strong) NSString *qrcodeImg;

@end

@implementation InfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.leftViewHeight = 90;
//    self.juDingBuHeight = 140;
//
//    self.infoWitdh = 200;
//    self.guangDuHeight = 130;
//    self.zheSheHeight = 70;
//    self.shopHeight = ScreenHeight - self.leftViewHeight - self.juDingBuHeight - 64 - 20-4;
    self.shopHeight = ScreenHeight - JYGlassShopVCLeftViewHeight - JYGlassShopVCTopHeight - JYGlassShopVCNavHeight - 20;
    
}

-(void)configShopCountWithArr:(NSArray *)goodsListDataArr{
    if (self.isTopShow == NO) {
//        self.shopHeight = ScreenHeight - self.leftViewHeight - self.juDingBuHeight - 64 - 20-4;
        self.shopHeight = ScreenHeight - JYGlassShopVCLeftViewHeight - JYGlassShopVCTopHeight - JYGlassShopVCNavHeight - JYGlassShopVCMargin-4;
    }else{
//        self.shopHeight = ScreenHeight - self.leftViewHeight - 20 - 64 - 20-4;
        self.shopHeight = ScreenHeight - JYGlassShopVCLeftViewHeight - JYGlassShopVCMargin - JYGlassShopVCNavHeight - JYGlassShopVCMargin-4;
    }
    
    _totleWidth = 0;
    for (int i = 0; i < goodsListDataArr.count; i++) {
//        NSLog(@"###################################");
        GoodsListModel *model = goodsListDataArr[i];
//        NSLog(@"====== count ====== %lu",(unsigned long)model.list.count);
        
//        _shopWidth = model.list.count * self.infoWitdh + (model.list.count - 1)*1.5;
        _shopWidth = model.list.count * JYGlassShopVCInfoWidth + (model.list.count - 1)*1.5;
        
//        NSLog(@"====== _shopWidth ====== %f",_shopWidth);

        _totleWidth = _totleWidth + _shopWidth+1.5;
//        NSLog(@"====== totleWidth ====== %f",_totleWidth);
        _shopX = _totleWidth - _shopWidth;
//        NSLog(@"====== _shopX ====== %f",_shopX);
        
        self.shopView = [[UIView alloc] init];
        self.shopView.frame = CGRectMake(_shopX, 0, _shopWidth, _shopHeight);
        [self.infoBackView addSubview:self.shopView];
        [self BuildInfoViewWithArr:model.list];
    }
    
}

-(void)BuildInfoViewWithArr:(NSArray *)listArr{
    
    for (int i = 0; i<listArr.count; i++) {
        self.infoView = [[UIView alloc] init];
//        self.infoView.frame = CGRectMake(i*(self.infoWitdh+1.5), 0, self.infoWitdh, self.shopView.height);
        self.infoView.frame = CGRectMake(i*(JYGlassShopVCInfoWidth+1.5), 0, JYGlassShopVCInfoWidth, self.shopView.height);
//        self.infoView.backgroundColor = [UIColor redColor];
        [self.shopView addSubview:self.infoView];
        CatListModel *model = listArr[i];
        self.productArr = model.product;
        [self setUpXianPianUIWithCatListModel:model];
    }
    
}

-(void)setUpXianPianUIWithCatListModel:(CatListModel *)model{
    if (self.currentDataType == 1) {
//        self.tagHeight = (self.shopView.height - self.zheSheHeight - self.guangDuHeight)/self.specificDataArr.count;
        self.tagHeight = (self.shopView.height - JYGlassShopVCZheSheHeight - JYGlassShopVCGuangDuHeight)/self.specificDataArr.count;
        
    }else if (self.currentDataType == 0){
//        self.tagHeight = (self.shopView.height - self.zheSheHeight - self.guangDuHeight)/self.nowDataArr.count;
        self.tagHeight = (self.shopView.height - JYGlassShopVCZheSheHeight - JYGlassShopVCGuangDuHeight)/self.nowDataArr.count;
    }else{
//        self.tagHeight = self.shopView.height - self.zheSheHeight - self.guangDuHeight;
        self.tagHeight = self.shopView.height - JYGlassShopVCZheSheHeight - JYGlassShopVCGuangDuHeight;
    }
    
    
    self.xianPianView = [[UIView alloc] init];
//    self.xianPianView.frame = CGRectMake(0, 0, self.infoWitdh, self.infoView.height);
    self.xianPianView.frame = CGRectMake(0, 0, JYGlassShopVCInfoWidth, self.infoView.height);
//    self.xianPianView.backgroundColor = [UIColor blueColor];
    [self.infoView addSubview:self.xianPianView];
    
    //折射视图
    self.zheSheView = [[ZheSheView alloc] init];
//    self.zheSheView.frame = CGRectMake(0, 0, self.infoWitdh, self.zheSheHeight+2);
    self.zheSheView.frame = CGRectMake(0, 0, JYGlassShopVCInfoWidth, JYGlassShopVCZheSheHeight);
    [self.zheSheView buildZheSheViewModel:model];
    [self.xianPianView addSubview:self.zheSheView];
    
    //现片商品价格视图
    UIView *goodsViewOne = [[UIView alloc] init];
//    goodsViewOne.frame = CGRectMake(0, self.zheSheView.height, self.infoWitdh, self.infoView.height - self.zheSheHeight - self.guangDuHeight);
    goodsViewOne.frame = CGRectMake(0, JYGlassShopVCZheSheHeight, JYGlassShopVCInfoWidth, self.infoView.height - JYGlassShopVCZheSheHeight - JYGlassShopVCGuangDuHeight+2);
    
//    goodsViewOne.backgroundColor = [UIColor orangeColor];
    [self.xianPianView addSubview:goodsViewOne];
    
    NSArray *currentArr = [NSArray array];
    if (self.currentDataType == 1) {
        currentArr = self.specificDataArr;
    }else if (self.currentDataType == 0){
        currentArr = self.nowDataArr;
    }
    
    for (int i = 0; i< currentArr.count; i++) {
        self.tagView = [[TagNameView alloc] init];
        
//        self.tagView.frame = CGRectMake(1, i*_tagHeight, self.infoWitdh, _tagHeight-2);
        if(i == 0){
            self.tagView.frame = CGRectMake(0, i*_tagHeight, JYGlassShopVCInfoWidth, _tagHeight);
        }else{
            self.tagView.frame = CGRectMake(0, i*_tagHeight+1.5, JYGlassShopVCInfoWidth, _tagHeight-1.5);
        }
        
        
        NSString *str;
        if (self.currentDataType == 1) {
            str = [self compareTopAndProduct:self.tagView WithString:self.specificDataArr[i] WithIfSpecific:self.currentDataType];
        }else if (self.currentDataType == 0){
            str = [self compareTopAndProduct:self.tagView WithString:self.nowDataArr[i] WithIfSpecific:self.currentDataType];
        }
        
        
        _tagView.tagNameLab.text = str;
        if (str.length<=0) {
//            self.tagView.tagNameLab.text = @"--";
            self.tagView.tagNameLab.text = @"";
        }else{
            self.tagView.tagNameLab.text = str;
            if (self.isQrcode == YES) {
//                self.tagView.tagNameLab.textColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1];
                self.tagView.tagNameLab.textColor = [UIColor darkGrayColor];
                [self.tagView.tagNameViewBtn addTarget:self action:@selector(tagViewBtnClick) forControlEvents:UIControlEventTouchUpInside];
            }else{
                self.tagView.tagNameLab.textColor = [UIColor blackColor];
            }
        }
        
        [goodsViewOne addSubview:self.tagView];
    }

    self.guangDuViwe = [[GuangDuView alloc] init];
//    self.guangDuViwe.frame = CGRectMake(0, self.zheSheView.height + goodsViewOne.height, self.infoWitdh, self.guangDuHeight);
    self.guangDuViwe.frame = CGRectMake(0, JYGlassShopVCZheSheHeight + goodsViewOne.height, JYGlassShopVCInfoWidth, JYGlassShopVCGuangDuHeight);
    if (self.currentDataType == 0) {
        [self.guangDuViwe buildNowGuangDuModel:model];
    }else if (self.currentDataType == 1){
        [self.guangDuViwe buildSpecifGuangDuModel:model];
    }
    
    [self.xianPianView addSubview:self.guangDuViwe];
    
    
}


-(NSString *)compareTopAndProduct:(UIView *)tagView WithString:(NSString *)topName WithIfSpecific:(NSInteger)ID{
//    NSLog(@"###################################");
    NSString *str;
//    if (ID == 1) {
//        NSLog(@"===== 现在是定制片 =====");
//    }else if(ID == 0){
//        NSLog(@"======= 现在是现片 =======");
//    }
    
    for (NSArray *pArr in self.productArr) {
        for (NSDictionary *dic in pArr) {
            ProductModel *model = [[ProductModel alloc] initWithDictionary:dic];
//            if (model.is_dingz == ID == 1) {
//                NSLog(@"=======当前为定制片=======");
//            }else if(model.is_dingz == ID == 0){
//                NSLog(@"=======当前为现片=======");
//            }else{
//                NSLog(@"^^^^^^^^^^^^^");
//            }
            
            if (model.is_dingz == ID) {
//                NSLog(@"======= %@ ======",model.variety_name);
//                NSLog(@"======= %@ ======",topName);
//                if (model.variety_name == topName) {
//                    NSLog(@"===%@===%@===",model.variety_name,topName);
//                    NSLog(@"====== %@ =====",model.price);
//                }
                
                if ([model.variety_name isEqualToString:topName]) {
                    //判断是否可以弹出二维码
                    if (model.qrcode.length>0) {
                        self.isQrcode = YES;
                        self.qrcodeImg = model.qrcode;
                    }else{
                        self.isQrcode = NO;
                    }
//                    NSLog(@"====== %@ =====",model.price);
//                    str = [NSString stringWithFormat:@"%@元",model.price];
                    str = [NSString stringWithFormat:@"¥%@",model.price];
                }
                
            }
            
        }
    }
    
    return str;
}


#pragma mark - 点击事件
-(void)tagViewBtnClick{
    NSLog(@"点击展示二维码事件");
    self.infoTableViewCellBlock(self.qrcodeImg);
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

