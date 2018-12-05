//
//  MallDetailContentView.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/9.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "MallDetailContentView.h"

#import <WebKit/WebKit.h>
#import "MallDetailGoodsTableViewCell.h"

#import "MallDetailInfoModel.h"
#import "MallDetailProModel.h"
#import "MallDetailGalleryModel.h"
#import "MallGoodsInfoModel.h"

#import "ShowQrcodeView.h"
#import "MallDetailTagView.h"

static NSString *const MallDetailGoodsTableViewCellID = @"MallDetailGoodsTableViewCellIdentifier";
@interface MallDetailContentView ()<UITableViewDelegate, UITableViewDataSource,WKNavigationDelegate, WKUIDelegate>

@property (weak, nonatomic) IBOutlet UITableView *goodsTableView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLab;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLab;
@property (weak, nonatomic) IBOutlet UIView *goodsDetailBackView;
@property (weak, nonatomic) IBOutlet UIImageView *largeImageView;
@property (weak, nonatomic) IBOutlet UIView *horisonBaceVeiw;

@property (nonatomic, strong) MallGoodsInfoModel *detailGoodsInfoModel;
@property (nonatomic, strong) ShowQrcodeView *showQrcodeView;
@property (nonatomic, strong) MallDetailTagView *tagView;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIView *goodsProView;
@property (nonatomic, strong) UIImageView *selectedImage;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MallDetailContentView

-(instancetype)init{
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"MallDetailContentView" owner:self options:nil].lastObject;
    }
    
    return self;
}

-(instancetype)initWithModel:(MallGoodsInfoModel *)model{
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"MallDetailContentView" owner:self options:nil].lastObject;
    }
    [self buildGoodsProView];
    
    self.detailGoodsInfoModel = model;
    return self;
}

-(void)setUpUI{
    self.goodsTableView.showsVerticalScrollIndicator = NO;
    self.goodsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册cell
    [self.goodsTableView registerNib:[UINib nibWithNibName:@"MallDetailGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:MallDetailGoodsTableViewCellID];
    
    self.goodsNameLab.text = self.detailGoodsInfoModel.detailInfoModel.goods_name;
    self.goodsPriceLab.text = self.detailGoodsInfoModel.detailInfoModel.shop_price;
    
    [self.largeImageView sd_setImageWithURL:[NSURL URLWithString: self.detailGoodsInfoModel.detailInfoModel.goods_thumb]];
    [self buildWebView];
    
    [self buildHorisonScrollView];
}

-(void)buildGoodsProView{
    self.goodsProView.frame = CGRectMake(0, 0, ScreenWidth - MallDetailLeftTabeViewWidth - Margin * 2 , self.goodsProViewHeight);
    self.goodsProView.backgroundColor = [UIColor whiteColor];
    [self.goodsDetailBackView addSubview:self.goodsProView];
    
    CGFloat tagViewWidth = (self.goodsProView.width - 20)/3;
//    for (int i = 0; i<self.proArr.count; i++) {
    for (int i = 0; i<self.detailGoodsInfoModel.pro.count; i++) {
    
        CGFloat x = (i%3)*tagViewWidth + (i%3+1)*5;
        CGFloat y = (i/3+1)*5 + i/3*40;
        
        self.tagView = [[MallDetailTagView alloc] init];
        
        self.tagView.frame = CGRectMake(x, y, tagViewWidth, 40);
        
//        MallDetailProModel *model = self.proArr[i];
        MallDetailProModel *model = self.detailGoodsInfoModel.pro[i];
        self.tagView.tagNameLab.text = [NSString stringWithFormat:@"%@:%@",model.name,model.value];
        
        self.tagView.tagBackView.layer.borderWidth = 2.0;
        self.tagView.tagBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.goodsProView addSubview:self.tagView];
    }
    
}

-(void)buildWebView{
    
    self.webView.frame = CGRectMake(0, self.goodsProViewHeight, self.goodsDetailBackView.width, 500);
    
    //关闭竖s向指示器
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.scrollView.bounces = NO;
    [self.goodsDetailBackView addSubview:self.webView];
    
    MallDetailInfoModel *infoModel = self.detailGoodsInfoModel.detailInfoModel;
    [self fileWithHTML:infoModel.goods_desc];
}

-(void)buildHorisonScrollView{
    self.scrollView.frame = CGRectMake(0, 0, 250, 80);
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.horisonBaceVeiw addSubview:self.scrollView];
    
//    self.scrollView.contentSize = CGSizeMake(self.galleryArr.count* 88, 0);
    self.scrollView.contentSize = CGSizeMake(self.detailGoodsInfoModel.gallery.count * 88, 0);
    MallDetailInfoModel *model = self.detailGoodsInfoModel.detailInfoModel;
    
    if (self.detailGoodsInfoModel.gallery.count>0) {
        for (int i = 0 ; i < self.detailGoodsInfoModel.gallery.count; i++) {
            UIImageView *image = [[UIImageView alloc] init];
            image.frame = CGRectMake(i*(80+8), 0, 80, 80);
            image.userInteractionEnabled = YES;
//            MallDetailGalleryModel *model = self.galleryArr[i];
            MallDetailGalleryModel *model = self.detailGoodsInfoModel.gallery[i];
//            [image sd_setImageWithURL:[NSURL URLWithString:model.thumb_url]];
            [image sd_setImageWithURL:[NSURL URLWithString:model.img_url]];
            image.layer.borderWidth = 2.0;
            if (i == 0) {
//                image.layer.borderColor = [UIColor redColor].CGColor;
                image.layer.borderColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1].CGColor;
//
                self.selectedImage = image;
            }else{
                image.layer.borderColor = [UIColor lightGrayColor].CGColor;
            }
//            [self.galleryImg ];
            
            [self.scrollView addSubview:image];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgBtnClick:)];
            [image addGestureRecognizer:tap];
            
//            UIButton *imgBtn = [[UIButton alloc] init];
//            imgBtn.frame = CGRectMake(0, 0, self.galleryImg.width, self.galleryImg.height);
//            imgBtn.tag = self.galleryImg.tag;
//            [imgBtn addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            [self.galleryImg addSubview:imgBtn];
            
        }
    }else{
        UIImageView *image = [[UIImageView alloc] init];
        image.userInteractionEnabled = YES;
        image.frame = CGRectMake(0, 0, 80, 80);
        [image sd_setImageWithURL:[NSURL URLWithString:self.detailGoodsInfoModel.detailInfoModel.goods_thumb]];
        image.layer.borderWidth = 2.0;
//        image.layer.borderColor = [UIColor redColor].CGColor;
        image.layer.borderColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1].CGColor;
        [self.scrollView addSubview:image];
        
//        UIButton *imgBtn = [[UIButton alloc] init];
//        imgBtn.frame = CGRectMake(0, 0, self.galleryImg.width, self.galleryImg.height);
//        imgBtn.tag = self.galleryImg.tag;
//        [imgBtn addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.galleryImg addSubview:imgBtn];
        
    }
    
}
/*
-(void)imgBtnClick:(UIButton *)sender{
    self.galleryImg = (UIImageView *)[sender viewWithTag:sender.tag];
    
    self.galleryImg.layer.borderWidth = 1.5;
    self.galleryImg.layer.borderColor = [UIColor redColor].CGColor;
    
//    if (self.galleryImg.tag == sender.tag) {
//        self.galleryImg.layer.borderWidth = 1.5;
////        self.galleryImg.layer.borderColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1].CGColor;
//        self.galleryImg.layer.borderColor = [UIColor redColor].CGColor;
//    }
    
}
*/
#pragma mark - 点击事件
- (IBAction)scanQrcodeBtnClickAction:(UIButton *)sender {
//    NSLog(@"数据处理");
//    _showQrcodeView = [[ShowQrcodeView alloc] init];

    [self.showQrcodeView creatCIQRCodeImageWithStr:[NSString stringWithFormat:@"{type:'group',group:%@}",self.detailGoodsInfoModel.detailInfoModel.qrcode_id]];
    _showQrcodeView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _showQrcodeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.showQrcodeView];
}

-(void)imgBtnClick:(UITapGestureRecognizer *)sender{
    NSInteger index = [self.scrollView.subviews indexOfObject:sender.view];
    UIImageView *imageV = self.scrollView.subviews[index];
//    imageV.layer.borderColor = [UIColor redColor].CGColor;
    imageV.layer.borderColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1].CGColor;
    if (self.selectedImage) {
        self.selectedImage.layer.borderColor = [UIColor grayColor].CGColor;
    }
    self.selectedImage = imageV;
    MallDetailGalleryModel *model = self.detailGoodsInfoModel.gallery[index];
    [self.largeImageView sd_setImageWithURL:[NSURL URLWithString:model.img_original]];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return self.productsArr.count;
    return self.detailGoodsInfoModel.products.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MallDetailGoodsTableViewCell *cell = [self.goodsTableView dequeueReusableCellWithIdentifier:MallDetailGoodsTableViewCellID forIndexPath:indexPath];
    if (indexPath.row%2 == 0) {
        cell.isColor = YES;
    }else{
        cell.isColor = NO;
    }
    cell.attNameArr = self.attrNameArr;
//    [cell buildWithMallDetailProductsModel:self.productsArr[indexPath.row]];
    [cell buildWithMallDetailProductsModel:self.detailGoodsInfoModel.products[indexPath.row]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

#pragma mark - 处理html数据
-(NSString *)fileWithHTML:(NSString *)html{
    //str为我们取出的html数据
    //    NSString * str = [reponse[@"data"] objectForKey:@"gn_content"];
    //将str转换成标准的html数据
    html = [self htmlEntityDecode:html];
    NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
                            "<head> \n"
                            "<style type=\"text/css\"> \n"
                            "body {font-size:15px;}\n"
                            "</style> \n"
                            "</head> \n"
                            "<body>"
                            "<script type='text/javascript'>"
                            "window.onload = function(){\n"
                            "var $img = document.getElementsByTagName('img');\n"
                            "for(var p in  $img){\n"
                            " $img[p].style.width = '100%%';\n"
                            "$img[p].style.height ='auto'\n"
                            "}\n"
                            "}"
                            "</script>%@"
                            "</body>"
                            "</html>",html];
    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"https://price.jingkoo.net"]];
    
    return html;
}
//将 &lt 等类似的字符转化为HTML中的“<”等
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}

#pragma mark - 懒加载
-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
    }
    
    return _webView;
}

-(UIView *)goodsProView{
    if (!_goodsProView) {
        _goodsProView = [[UIView alloc] init];
    }
    
    return _goodsProView;
}

-(ShowQrcodeView *)showQrcodeView{
    if (!_showQrcodeView) {
        _showQrcodeView = [[ShowQrcodeView alloc] init];
    }
    
    return _showQrcodeView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    
    return _scrollView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
